# to-do

## For basic security

Ok So we have a lot to do in this :
Let's start by noting it down

1) Firstly, a few suggestions fr Shashank D - We need to improve on the model . Make a system architecture and then start working on it.Ok, so what is up with the system architecture - Need to design the flow of the program that we plan to build

2) Need to read about how DOS is prevented in general . And then write XDP code for this. So need to look into rate learning algorithms and pick and implement a simple one.

3) Need to do the XDP tutorial and work start of with a basic program.

4) Improvement would be to look into the distribution of packet processing. Hashig and load balancing and also need to look Into Kataran

5) Look into Spining VM's for experimentaiton instead of on the raw machine.




## Rough - todo 

to do read about the jump statement

re-read tailcalls to understand better

Alexei Starovoitov wrote a good description of BPF reference
counters and file descriptors in his blog post “Lifetime of BPF
Objects”.

need to read why reg:4 is there in the bpf_insn

REad about the XDP once again
Good post by kernel function bpf_trace_printk(). Andrii Nak‐
ryiko wrote a good post on this on his blog


XDP Reference Guide that’s included as part of the Cilium project’s
documentation. If you’d like more details, the kernel documenta‐
tion describes the eBPF instructions and encoding quite clearly.


For a lot more detail on tail calls and BPF to BPF calls, there’s an
excellent post by Jakub Sitnicki on Cloudflare’s blog: “Assembly
within! BPF tail calls on x86 and ARM”.

To better understand the differences between XDP and TC eBPF
programs, read the “Program Types” section in the BPF and XDP
Reference Guide from the Cilium project.

For a more complete overview of TC and its concepts, I recommend Quentin Monnet’s post “Understanding
tc “direct action” mode for BPF”.

6 Ceznam shared data about the performance boost its team saw when experimenting with an eBPF-based load
balancer in this blog post.

3 If you want to explore this, try CTF Challenge 3 from eBPF Summit 2022. I won’t give spoilers here in the
book, but you can see the solution in a walkthrough given by Duffie Cooley and me here.
4 See Daniel Borkmann’s presentation “Little Helper Minions for Scaling Microservices” that includes a history
of eBPF, where he tells this anecdote.

Since this is a book on eBPF and not networking, I haven’t delved
into details such as why the IP and MAC addresses need to be
updated or what happens if they aren’t. If you’re interested, I cover
this some more in my YouTube video of the eBPF Summit talk
where I originally wrote this example code. 

2 This example is based on a talk I gave at eBPF Summit 2021 called “A Load Balancer from scratch”. Build an
eBPF load balancer in just over 15 minutes!

In core (ch5)
- what is <anon>?
- when I run my program why do I get prg name as python3 instead of hello-buffer-co (15 word limit)

> If you’d like to better understand how the BTF type data is generated and de-duplicated, there is another excellent blog post from Andrii Nakryiko on the subject.