---
title: "Tutorial: Packet01 - packet parsing"
---

# Tutorial: Packet01 - packet parsing

Now that you have completed the basic steps of the tutorial, you are
ready to begin writing packet processing programs. This lesson contains
the first introduction to packet processing, where we will see how to
parse the packet contents, and how to make sure that the kernel verifier
will accept your programs.

# Table of Contents

-   [Setup notes](#setup-notes)
-   [What you will learn in this
    lesson](#what-you-will-learn-in-this-lesson)
    -   [The data and data_end
        pointers](#the-data-and-data_end-pointers)
    -   [Packet bounds checking](#packet-bounds-checking)
    -   [Header cursor to keep track of current parsing
        position](#header-cursor-to-keep-track-of-current-parsing-position)
    -   [Program return codes](#program-return-codes)
    -   [Packet header definitions and byte
        order](#packet-header-definitions-and-byte-order)
    -   [Function inlining and loop
        unrolling](#function-inlining-and-loop-unrolling)
-   [Assignments](#assignments)
    -   [Assignment 1: Fix the bounds checking
        error](#assignment-1-fix-the-bounds-checking-error)
    -   [Assignment 2: Parsing the IP
        header](#assignment-2-parsing-the-ip-header)
    -   [Assignment 3: Parsing the ICMPv6 header and reacting to
        it](#assignment-3-parsing-the-icmpv6-header-and-reacting-to-it)
    -   [Assignment 4: Adding VLAN
        support](#assignment-4-adding-vlan-support)
    -   [Assignment 5: Adding IPv4
        support](#assignment-5-adding-ipv4-support)

# Setup notes

We will use the loader from the basic04 lesson. The Makefile in this
directory contains a rule to copy it over to this directory, so you can
run it as `./xdp_loader`{.verbatim} after running `make`{.verbatim}. The
`testenv.sh`{.verbatim} script will use this when run with the
`load`{.verbatim} command. In the example below, we assume you\'ve
installed the alias for testenv (by running
`eval $(./testenv.sh alias)`{.verbatim}), so all examples will use the
short `t`{.verbatim} command to refer to the `testenv.sh`{.verbatim}
script.

# What you will learn in this lesson

This lesson will teach you how to parse packet data from XDP. This is
done via direct memory access using pointers to the packet data, which
is one of the reasons for the high performance attainable using XDP.
This works because the kernel verifier will check that all data accesses
are within the packet boundaries. We will see how this works, and how
you can deal with verifier errors.

You will also learn how to decide the packet verdict via program return
code based on the packet data, and we will cover how to structure the
packet parsing code to ensure readability and code reuse.

A few points to be aware of while completing the assignments are listed
below.

## The data and data_end pointers

When an XDP program is executed, it will receive as a parameter a
pointer to a `struct xdp_md`{.verbatim} object, which contains context
information about the packet. This object is defined in
`bpf.h`{.verbatim} as follows:

``` {.c org-language="C"}
struct xdp_md {
    __u32 data;
    __u32 data_end;
    __u32 data_meta;
    /* Below access go through struct xdp_rxq_info */
    __u32 ingress_ifindex; /* rxq->dev->ifindex */
    __u32 rx_queue_index;  /* rxq->queue_index  */
};
```

The last two items in this struct are just data fields which contain the
ifindex and RX queue index that the packet was received on. The program
can use this in its decision making (along with the packet data itself).

The three first items are actually pointers, even though they are
defined with the `__u32`{.verbatim} type. The `data`{.verbatim} field
points to the start of the packet, the `data_end`{.verbatim} field
points to the end, and the `data_meta`{.verbatim} field points to the
metadata area that XDP programs can use to store extra metadata to
accompany the packet. In this lesson we will only be working with the
`data`{.verbatim} and `data_end`{.verbatim} fields.

The verifier will rewrite the pointer accesses when the program is
loaded to point to the actual packet data. But to satisfy the compiler
type checking we need to cast the fields to pointers when accessing
them. For this reason, XDP programs often start with an assignment like
this:

``` {.c org-language="C"}
void *data_end = (void *)(long)ctx->data_end;
void *data = (void *)(long)ctx->data;
```

## Packet bounds checking

As mentioned above, packet data is accessed using direct memory reads,
which the verifier will ensure are safe. However, doing this at runtime
for every pointer access would result in a significant performance
overhead. So instead, what the verifier does is check that the XDP
program does its own bounds checking; this is the purpose of the
`data_end`{.verbatim} pointer.

When the verifier performs its static analysis at load time, it will
track all memory address offsets used by the program, and look for
comparisons with the `data_end`{.verbatim} pointer, which will be set to
the end of the packet at runtime. This means that if the program does
something like this:

``` {.c org-language="C"}
if (data + 10 < data_end)
  /* do something with the first 10 bytes of data */
else
  /* skip the packet access */
```

The verifier can know that all instructions in the `true`{.verbatim}
branch of the `if`{.verbatim} statement can safely access the first 10
bytes of the packet, while the `else`{.verbatim} branch cannot. So if a
program does attempt to access the packet data in the else branch, the
program will be rejected.

## Header cursor to keep track of current parsing position

When going through a packet and parsing subsequent headers, it is
generally necessary to keep track of the current parsing position. When
using helper functions to parse packet headers, those helper functions
generally need to modify the current parser position. To avoid having to
deal with pointer arithmetic on pointers to pointers, we encapsulate
this in a *cursor* object, which we can pass to helper functions. The
cursor is simply defined as a single-entry struct:

``` {.c org-language="C"}
/* Header cursor to keep track of current parsing position */
struct hdr_cursor {
    void *pos;
};
```

## Program return codes

The final verdict for what happens to a packet after it has been
processed by the XDP program is communicated to the kernel by means of
the program return code. These are also defined in `bpf.h`{.verbatim}:

``` {.c org-language="C"}
enum xdp_action {
    XDP_ABORTED = 0,
    XDP_DROP,
    XDP_PASS,
    XDP_TX,
    XDP_REDIRECT,
};
```

`ABORTED`{.verbatim} and `DROP`{.verbatim} will both drop the packet,
but `ABORTED`{.verbatim} will also trigger a tracepoint event
(`xdp:xdp_exception`{.verbatim}; this has zero overhead when the
tracepoint is not reached). `PASS`{.verbatim} will allow the packet to
continue up to the kernel networking stack for processing,
`TX`{.verbatim} will retransmit the packet out of the same interface it
was received on, and `REDIRECT`{.verbatim} will transmit the packet out
of another interface (where the destination interface needs to be set by
a BPF helper call prior to returning `REDIRECT`{.verbatim}).

Note that the XDP program can perform arbitrary alterations to the
packets before these verdicts are rendered. For the `TX`{.verbatim} and
`REDIRECT`{.verbatim} actions, some packet data transformation is
generally required (such as rewriting ethernet header addresses), while
for the others it is optional. We will see how this can be used in the
next lesson.

## Packet header definitions and byte order

Since an XDP program only receives a pointer to a raw data buffer, it
will need to do its own parsing of packet headers. To aid in this, the
kernel headers define structs that contain the packet header fields.
Parsing packets generally involves a lot of casting of data buffers to
the right struct types, as we will see in the assignments below. The
header definitions we will be using in this lesson are the following:

  Struct                         Header file
  ------------------------------ ---------------------------------
  `struct ethhdr`{.verbatim}     `<linux/if_ether.h>`{.verbatim}
  `struct ipv6hdr`{.verbatim}    `<linux/ipv6.h>`{.verbatim}
  `struct iphdr`{.verbatim}      `<linux/ip.h>`{.verbatim}
  `struct icmp6hdr`{.verbatim}   `<linux/icmpv6.h>`{.verbatim}
  `struct icmphdr`{.verbatim}    `<linux/icmp.h>`{.verbatim}

Since the packet data comes straight off the wire, the data fields will
be in network byte order. Use the `bpf_ntohs()`{.verbatim} and
`bpf_htons()`{.verbatim} functions to convert to and from host byte
order, respectively. See the comment at the top of
[file:../headers/bpf_endian.h](../headers/bpf_endian.h) for why the
`bpf_`{.verbatim}-prefixed versions are needed.

## Function inlining and loop unrolling

Because eBPF programs only have limited support for function calls,
helper functions need to be inlined into the main function. The
`__always_inline`{.verbatim} marker on the function definition ensures
this, overriding any inlining decisions the compiler would otherwise
make.

Similarly, because eBPF does not support looping, we need to unroll any
loops in the program. This can be done by adding the
`#pragma unroll`{.verbatim} statement on the line before the loop, and
only works with loops where the number of iterations are known at
compile time (such as for loops with a static counter).

# Assignments

The end goal of this lesson is to build an XDP program that will inspect
packet headers, and drop every other ICMP echo request (i.e. ping)
packet seen on the interface, while allowing everything else to pass up
to the kernel. The assignments below will gradually build up towards
this goal.

The starting point for this assignment is the packet parsing program in
[file:xdp_prog_kern.c](xdp_prog_kern.c), which will parse the packet
Ethernet header using a helper function. Each assignment will extend
this program by adding new features. The program includes the stats
helper from basic04 which you can use to monitor what actions the
program takes as you develop it. Use `t
stats`{.verbatim} to run the stats monitoring application (after you
have loaded your BPF program).

## Assignment 1: Fix the bounds checking error

The parser function in `xdp_prog_kern.c`{.verbatim} will parse the
Ethernet header, do bounds checking, and return the next header type and
position. However, there is a bug in the bounds checking logic, so the
program will be rejected by the verifier (test this by running
`t load`{.verbatim} after compiling it).

Your first assignment is to fix this bug (**hint**: it\'s in the
`if`{.verbatim} statement in `parse_ethhdr()`{.verbatim}), and make sure
that the program can be successfully loaded onto an interface.

## Assignment 2: Parsing the IP header

Now that our Ethernet parsing program runs, we will add parsing of the
IP header. To do this, implement the `parse_ip6hdr()`{.verbatim}
function that has a commented-out prototype below the
`parse_ethhdr()`{.verbatim} function. The function will be quite similar
to `parse_ethhdr()`{.verbatim}, but you\'ll need to look up the IPv6
header structure definition in `ipv6.h`{.verbatim}.

When you add bounds checking, notice that the style used in
`parse_ethhdr()`{.verbatim}, which computes the size of the header and
does byte-wise comparison, is not the only one possible. You can also
use pointer arithmetic-style comparison, which makes use of the fact
that incrementing a pointer will move the memory it is pointing to by
the size of the structure. Using this will get you a bounds check that
looks like this:

``` {.c org-language="C"}
struct ipv6hdr *ip6h = nh->pos;

/* Pointer-arithmetic bounds check; pointer +1 points to after end of
 * thing being pointed to. We will be using this style in the remainder
 * of the tutorial.
 */
if (ip6h + 1 > data_end)
    return -1;
```

Don\'t forget to also increment the nh-\>pos pointer so it points to the
data right after the IP header, which is what you\'ll be looking at when
parsing the ICMPv6 header in the next assignment.

To check that your program works, test that it compiles and loads. You
can also change the return code to drop IP packets, and check that this
works using either `t tcpdump`{.verbatim} or `t ping`{.verbatim}.

## Assignment 3: Parsing the ICMPv6 header and reacting to it

Now that we can successfully parse packets down to the IP header, we
will need to add parsing of the payload that we are interested in. I.e.,
the ICMPv6 header. To do this, implement the
`parse_icmp6hdr()`{.verbatim} function.

After parsing the ICMPv6 header, it is finally time to make our
decisions based on the packet payload. In this case, we are interested
in the sequence number. The data structure is quite deeply nested, but
the header file also defines a convenient alias, so the sequence number
can be accessed as `icmp6h->icmp6_sequence`{.verbatim} (but don\'t
forget byte order conversion).

With this, we can finally implement the drop logic mentioned above, by
simply returning `XDP_DROP`{.verbatim} if the sequence number is even,
and `XDP_PASS`{.verbatim} otherwise. Verify that this works by loading
the program and running a ping; you should see responses on every other
sequence number:

``` {.bash org-language="sh"}
$ make
$ t load
$ t ping
Running ping from inside test environment:

PING fc00:dead:cafe:1::1(fc00:dead:cafe:1::1) 56 data bytes
64 bytes from fc00:dead:cafe:1::1: icmp_seq=1 ttl=64 time=0.059 ms
64 bytes from fc00:dead:cafe:1::1: icmp_seq=3 ttl=64 time=0.135 ms
^C
--- fc00:dead:cafe:1::1 ping statistics ---
4 packets transmitted, 2 received, 50% packet loss, time 44ms
rtt min/avg/max/mdev = 0.059/0.097/0.135/0.038 ms
```

## Assignment 4: Adding VLAN support

Now that we have the basic functionality working, we can improve it to
also correctly handle VLAN tags on the Ethernet packets, as an example
of how to parse multiple variable headers depending on the payload. In
Linux, VLANs are configured by creating virtual interfaces of type vlan;
but since the XDP program runs directly on the real interface, it will
see all packets with their VLAN tags, before the kernel assigns them to
the virtual VLAN interfaces. We can use this to create a parser that
will work with any VLAN encapsulation (but see the note about hardware
offloads below).

For now we just want to parse the VLAN tags and find the encapsulated IP
header (in the next lesson we will move on to adding and removing VLAN
tags). This means that we can just augment our
`parse_ethhdr()`{.verbatim} function to also parse VLAN tags. If any
tags are found, we simply grab the next header type from the innermost
tag instead of directly from the Ethernet header, and move the nexthdr
pointer to after the end of the VLAN tag.

Unfortunately, the VLAN tag header is not exported by any of the IP
header files. However, it is quite simple, so we can just define it
ourselves, like this (copied from the internal kernel headers):

``` {.c org-language="C"}
struct vlan_hdr {
    __be16  h_vlan_TCI;
    __be16  h_vlan_encapsulated_proto;
};
```

The ethertype of a VLAN tag is either `ETH_P_8021Q`{.verbatim} or
`ETH_P_8021AD`{.verbatim}, both of which are defined in
`if_ether`{.verbatim}. So we can define a simple helper function to
check if a VLAN tag is present:

``` {.c org-language="C"}
static __always_inline int proto_is_vlan(__u16 h_proto)
{
        return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
                  h_proto == bpf_htons(ETH_P_8021AD));
}
```

Which can be used like this:

``` {.c org-language="C"}
if (proto_is_vlan(eth->h_proto)) {
  /* Process VLAN tag */
}
```

Another thing to bear in mind is that a single packet can have several
nested VLAN tags. We can handle this by using an unrolled loop to parse
subsequent VLAN headers, as long as their encapsulated protocol
continues to be on of the VLAN types.

Using the above, modify your parsing program to also work with VLAN
tags. You can test this by setting up the test environment with VLAN
interfaces; simply pass the `--vlan`{.verbatim} tag to
`t setup`{.verbatim}; or run `t reset --vlan`{.verbatim} to
re-initialise an existing environment with the addition of a VLAN
interface. Once you have initialised the environment to include VLANs,
you can run `t
ping --vlan`{.verbatim} to run a ping on the VLAN interfaces, and verify
that every other packet is still being dropped.

### A note about VLAN offloads

Since XDP needs to see the VLAN headers as part of the packet headers,
it is important to turn off VLAN hardware offload (which most hardware
NICs support), since that will remove the VLAN tag from the packet
header and instead communicate it out of band to the kernel via the
packet hardware descriptor. The `testenv`{.verbatim} script already
disables VLAN offload when setting up the environment, but for
reference, here is how to turn it off for other devices, using ethtool:

``` example
# Check current setting:
ethtool -k DEV | grep vlan-offload
# Disable for both RX and TX
ethtool --offload DEV rxvlan off txvlan off
# Same as:
# ethtool -K DEV rxvlan off txvlan off
```

## Assignment 5: Adding IPv4 support

While we would obviously all like IPv6 to be ubiquitous everywhere,
sometimes it is still necessary to handle legacy IPv4 packets. To this
end, the final assignment for this lesson is to extend our program to
perform the same function for v4 ICMP packets as it does for ICMPv6
packets. This means adding two new parser functions for the IPv4
headers, and handling each according to the payload type of the Ethernet
header.

This should be a pretty straight-forward extension of the program. The
only complication to be aware of is that IPv4 headers can vary in size,
so you\'ll need to do the bounds checking in two passes: First verify
that the iphdr struct itself fits in the packet payload, then compute
the actual header size as `hdrsize = iph->ihl * 4`{.verbatim}, and
finally verify that this full size fits in the packet (and adjust the
nexthdr pointer accordingly).

To test IPv4 support, you can run `t setup --legacy-ip`{.verbatim} which
will configure IPv4 addresses on the virtual interfaces, and
`t ping --legacy-ip`{.verbatim} to run a ping afterwards. Note that you
will need to pass both `--legacy-ip`{.verbatim} and `--vlan`{.verbatim}
to the `setup`{.verbatim} (or `reset`{.verbatim}) commands if you want
both at the same time; however, no IPv4 addresses will be configured on
the VLAN interfaces, so you can\'t use `t ping`{.verbatim} with both.

Once you have added IPv4 support and verified that every other v4 ICMP
packet is being dropped when you load the program, you have completed
this lesson, and you are ready move on to `packet02`{.verbatim} to learn
about packet modification!