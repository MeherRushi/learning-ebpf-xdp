/* SPDX-License-Identifier: GPL-2.0 */
#include <stddef.h>
#include <linux/bpf.h>
#include <linux/in.h>			// In in.h , it has IPPROTO_ICMP protocol type
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ipv6.h>
#include <linux/icmpv6.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>


/* Defines xdp_stats_map from packet04 */
#include "../common/xdp_stats_kern_user.h"
#include "../common/xdp_stats_kern.h"

/* Header cursor to keep track of current parsing position */
struct hdr_cursor {
	void *pos;
};

/* Packet parsing helpers.
 *
 * Each helper parses a packet header, including doing bounds checking, and
 * returns the type of its contents if successful, and -1 otherwise.
 *
 * For Ethernet and IP headers, the content type is the type of the payload
 * (h_proto for Ethernet, nexthdr for IPv6), for ICMP it is the ICMP type field.
 * All return values are in host byte order.
 */
static __always_inline int parse_ethhdr(struct hdr_cursor *nh,
					void *data_end,
					struct ethhdr **ethhdr)
{
	struct ethhdr *eth = nh->pos;
	int hdrsize = sizeof(*eth);

	/* Byte-count bounds check; check if current pointer + size of header
	 * is after data_end.
	 */
	if (nh->pos + hdrsize > data_end)
		return -1;

	nh->pos += hdrsize;	//next header has been shifted now
	*ethhdr = eth;

	return eth->h_proto; /* network-byte-order */
}

/* Assignment 2: Implement and use this */
static __always_inline int parse_ip6hdr(struct hdr_cursor *nh,
					void *data_end,
					struct ipv6hdr **ip6hdr)
{
	struct ipv6hdr *ip6h;
	ip6h = nh->pos;

	/* 
	Boundary Check condition using Pointer arthematic
	When we assign the nh->pos to ipv6hdr_fn structure
	then increamting the pointer by 1 will cause it move
	the size of the pointer. So we effectively check that
	the header lies inside the packet data_end
	 */

	if (ip6h + 1 > data_end)
		return -1;

	// Incrementing the nh->pos pointer using pointer 
	// arthematic once again
	nh->pos = ip6h + 1;

	// Now assign the header to the ip6hdr pointer that
	// we took as argument so that it can be accesed in 
	// in the main function

	*ip6hdr = ip6h;

	/* 
	Now, we return the ip6h->next_header field.
	
	The "Next Header" field in an IPv6 header is an 8-bit field 
	that indicates the type of extension header that follows the
	IPv6 header. It can also indicate the protocols contained 
	within upper-layer packets, such as TCP or UDP or ICMP 
	*/

	return ip6h->nexthdr;  
}

/* Assignment 3: Implement and use this */
static __always_inline int parse_icmp6hdr(struct hdr_cursor *nh,
					  void *data_end,
					  struct icmp6hdr **icmp6hdr)
{
	struct icmp6hdr *icmp6h;
	icmp6h = nh->pos;

	//Bound Check
	if (icmp6h +1 > data_end)
		return -1;
	
	nh->pos = icmp6h + 1;
	*icmp6hdr = icmp6h;

	int seq = bpf_ntohs(icmp6h->icmp6_sequence);
	bpf_printk("seq=%d",seq);

	return seq;
	// return icmp6h->icmp6_type;

}

SEC("xdp")
int  xdp_parser_func(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct ethhdr *eth;

	/* Default action XDP_PASS, imply everything we couldn't parse, or that
	 * we don't want to deal with, we just pass up the stack and let the
	 * kernel deal with it.
	 */
	__u32 action = XDP_PASS; /* Default action */

        /* These keep track of the next header type and iterator pointer */
	struct hdr_cursor nh;
	int nh_type;
	

	/* Start next header cursor position at data start */
	nh.pos = data;

	/* Packet parsing in steps: Get each header one at a time, aborting if
	 * parsing fails. Each helper function does sanity checking (is the
	 * header type in the packet correct?), and bounds checking.
	 */
	nh_type = parse_ethhdr(&nh, data_end, &eth);	
	if (nh_type != bpf_htons(ETH_P_IPV6))			
		goto out;				// Just pass the packet cause we only want to drop ODD ICMP packets


	bpf_printk("step 1");
	/* Assignment additions go below here */
	/* 
		Okay, So My understanding is as follows. 
		
		So I am assuming that as we go down the network
		stack header for different protocols are added. And here we are concerned with packets
		that have a ethernet header. So we parse those packets and use the eth [which is a struct
		pointer to ethhdr] -> h_proto field (which is the protocol of the packet it encapsulates 
		ig) and to the get the protocol type. Then we use the bpf_htons() function and the pre-def-
		-ined constant ETH_P_IPV6 and check if it is a IPV6 type packet. As different packets are 
		numbered in different format, in the if_ether.h file we can see that ETH_P_IPV6 is numbered
		0x86DD. 

		A good reference material that I have found.

		Next step is that now that we know it is a IPV6 packet, we just have to parse it and again
		finf the type of the protocol that the data it is encapsulating has i.e if it is TCP, UDP or
		ICMP etc. 

		If we figure out that it is ICMP, go ahead and parse that as well. And ig whatver is mention-
		-ed in the readme. 
		------------------------ 
		After parsing the ICMPv6 header, it is finally time to make our decisions 
		based on the packet payload. In this case, we are interested in the sequence number. The data
		structure is quite deeply nested, but the header file also defines a convenient alias, so the 
		sequence number can be accessed as icmp6h->icmp6_sequence (but don’t forget byte order conversion).

		With this, we can finally implement the drop logic mentioned above, by simply returning XDP_DROP 
		if the sequence number is even, and XDP_PASS otherwise	
		-----------------------

	 */

	//declare a pointer to a ipv6hdr struct
	struct ipv6hdr *ip6hdr;

	// find the nh_type
	nh_type = parse_ip6hdr(&nh, data_end, &ip6hdr);
	bpf_printk("step 2");

	/* 
	Checking the nh_type , we use the bpf_htons() function
	to check for IPV6 and IPV4 etc, which can be found in the 
	<linux/if_ether.h> headerfile

	We check for the ICMP or UDP or TCP packet protocol.
	Rule: 
	The protocols 6 - TCP, 
	17 - UDP, and 
	58 - IPv6-ICMP 

	ICMPv6 messages may be classified as error messages and 
	information messages. ICMPv6 messages are transported by 
	IPv6 packets in which the IPv6 Next Header value for ICMPv6 
	is set to the value 58. -> Couldn't find header file

	 */

	if (nh_type != 58)
	{
		goto out;				// Just pass the packet cause we only want to drop ODD ICMP packets
	}			
	bpf_printk("step 3");
	/* 
	Step 3: We will have to parse the ICMP packets and drop 
	odd sequence number
	 */  

	// declare a pointer to the icmphdr struct
	struct icmp6hdr *icmp6hdr;

	// find the nh_type by parsing
	// nh_type = parse_icmp6hdr(&nh, data_end, &icmp6hdr);
	bpf_printk("step 4");

	// supposed to do an check condition for the type
	// of the next packet header. But lite

	/*  
	 Now in the icmp body check if sequece number is odd and
	 drop them i.e if the sequence number is even then just goto out
	 i.e pass them 

	??????????????????????????????????????????????
	This does not work but I call within the funciton, it works??

	int seq = bpf_ntohs(icmp6hdr->icmp6_sequence);
	bpf_printk("seq=%d",seq);
	?????????????????????????????????????????????????????
	*/
	
	/* ???????????????????????????????
	int seq = bpf_ntohs(icmp6hdr->icmp6_sequence);
	bpf_printk("seq=%d",seq); 
	??????????????????????????????????*/

	// if(bpf_ntohs(icmp6hdr->icmp6_sequence)%2 != 1) // if not odd i.e if it is even then goto with default action
	// 	goto out;

	int seq_num;
	seq_num = parse_icmp6hdr(&nh, data_end, &icmp6hdr);
	if(seq_num %2 == 0)
		goto out;

	action = XDP_DROP;

out:
	return xdp_stats_record_action(ctx, action); 	/* read via xdp_stats */
}

char _license[] SEC("license") = "GPL";