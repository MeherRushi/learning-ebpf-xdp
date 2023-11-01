# Learning eBPF 🚀

This is a demo repo where I mainly document my journey of learning eBPF and XDP.
<!-- Hey there! Welcome to my eBPF (Extended Berkeley Packet Filter) and XDP (Express DataPathway)
learning playground. This is where I dive headfirst into the exciting world of eBPF and document my journey. -->

## What's eBPF, Anyway?

eBPF is a revolutionary kernel technology that allows developers to write custom
code that can be loaded into the kernel dynamically, changing the way the kernel
behaves

## What's Inside?

Here's what you'll discover in this repo:

- **Code Hacks:** Explore my collection of eBPF code snippets, each tackling a unique use case or wild experiment.

- **Learning Logs:** Dive into my informal, yet hopefully insightful, documentation of eBPF concepts and quirks. It is like 
a collection of personal notes and quick fixes for issues I have faced

- **Cool Finds:** Stumble upon eBPF gems—articles, books, and official docs that helped me along the way.

- **Lab Experiments:** Peek into my eBPF experiments and maybe even try them out for yourself. Let's learn and break things together!

## File Structure

I have built this repo based on many resources which you can find in the [Resources](##Resources) section of this readme. However, the 2 main resources that I have followed are the `learning-ebpf by Liz Rice`<!-- Need to attach link--> and `xdp-tutorial by ____`<!-- Need to attach link-->


This repo contains the following file structure :
   - basics : This folder contains the basic programs that have been implemeted in the book `learning eBPF by Liz Rize`. I believe these can be found in Ch1 to 4 and Ch7 of the book. They inlcude my exploration of the bcc compiler and the libbpf library and understanding the basics of the eBPF program, their compilation, and writing Makefiles

   - bcc : This is a sub-module, it is the clone of the bcc repo
   - bpftool : This is also a clone of the bpftool repo. This tool has been extremely helpful for debugging or loading or providing features such as map pinning etc for eBPF program
   - libbpf : This is also a sub-module that is an essential library for writing eBPF programs in restricted C

   - networking : My main aim of learning eBPF was to use it in the field of networking, mainly for security reasons. I wanted to build a open-source Layer4 DOS and DDOS mitigation system using eBPF and XDP. This is the link of the project repo. So I have spent quite a little bit of time understanding xdp and packet parsing. The dependencies that one would need to install just for eBPF are also documented inside this repo (in the xdp_tutorial follow [which has an additional dependency of libxdp + xdp-tools]). I spent a lot of time trying to install modules effienctly and setting up my path variables etc.

   The sub-directory structure of the directory is as follows:
      - Documentation : This has very rough documentaion of the extreme basics
      - ICMP_drop : This repo contains code for basic dropping of ICMP packets. This is a set of extremely basic programs to get familiar with the basics of xdp code.
      - xdp_tutorial_follow : This repo has the solutions of (currently till Packet01) of the xdp-tutorial repo
      - xdp-tutorial : This is a sub-module which is a tutorial.

## Resources

References and Literature Survey

1) Beginner/Intermediate/Adv Intro to eBPF by Bredan Greg : https://www.brendangregg.com/blog/2019-01-01/learn-ebpf-tracing.html
2) Basic Firewall building program : https://arthurchiao.art/blog/firewalling-with-bpf-xdp/#11-bpfxdp-in-a-nutshell 
3) IEEE executive project Network Monitoring with eBPF : https://github.com/advaithcurpod/network-monitoring-eBPF 
4) Theory Programming Kernel with eBPF: https://www.kerno.io/blog/programming-the-kernel-with-ebpf 
5) Art of writing eBPF code : https://sysdig.com/blog/the-art-of-writing-ebpf-programs-a-primer/ 
6) Amazing repo which is a collection of a lot of other references : https://github.com/zoidbergwill/awesome-ebpf#tutorials 
7) Resource List : https://qmonnet.github.io/whirl-offload/2016/09/01/dive-into-bpf/ 
8) Bredan Greg Blogs/books : https://www.brendangregg.com/blog/2019-01-01/learn-ebpf-tracing.html 
9) https://www.brendangregg.com/bpf-performance-tools-book.html 
10) https://www.brendangregg.com/systems-performance-2nd-edition-book.html
11) Iovisor bcc fundamentals : https://github.com/iovisor/bcc/blob/master/docs/reference_guide.md  
12) XDP tutorial : https://github.com/xdp-project/xdp-tutorial/tree/master/basic01-xdp-pass 
13) BPF Internals : https://www.usenix.org/conference/lisa21/presentation/gregg-bpf 
14) Linux Torvalds repo bpf samples : https://github.com/torvalds/linux/tree/v4.20/samples/bpf 
15) Cilium Docs : https://docs.cilium.io/en/latest/bpf/ 
16) Kernel.org documentation : https://www.kernel.org/doc/html/latest/bpf/index.html 




Some Important papers: 

18) Fast Packet Processing with eBPF and XDP: Concepts, Code, Challenges, and Applications: (Main reference Paper) https://www.researchgate.net/publication/339084847_Fast_Packet_Processing_with_eBPF_and_XDP_Concepts_Code_Challenges_and_Applications
19) [A flow-based IDS using Machine Learning in eBPF (Reference for the ML part)](https://arxiv.org/pdf/2102.09980.pdf#:~:text=So%20far%20eBPF%20has%20been,machine%20learning%20entirely%20in%20eBPF.)
20) [CICIDS2017 dataset](https://www.kaggle.com/datasets/cicdataset/cicids2017)
21) [XDP in practice: integrating XDP into our DDoS mitigation pipeline:](https://netdevconf.org/2.1/papers/Gilberto_Bertin_XDP_in_practice.pdf)

Some related technologies and tools

22) eBPF Summit : https://ebpf.io/applications/
23) Once again: Amazing repo which is a collection of a lot of other references : https://github.com/zoidbergwill/awesome-ebpf#tutorials 
24) Cilium : https://github.com/cilium/cilium 


Some other resources

25) Basic Intro eBPF for complete beginners : https://www.youtube.com/watch?v=J_EehoXLbIU&ab_channel=Computerphile 
26) NetDev XDP talk : https://www.youtube.com/watch?v=iBkR4gvjxtE&ab_channel=netdevconf 
27) Linux-kernel-observability-ebpf https://sematext.com/blog/linux-kernel-observability-ebpf/ 
28) Ebpf-and-xdp-for-processing-packets-at-bare-metal-speed: https://sematext.com/blog/ebpf-and-xdp-for-processing-packets-at-bare-metal-speed/ 
29) Cilium : https://medium.com/@luishrsoares/getting-started-with-cilium-ebpf-778d00c113aa 

30) Hooking : https://en.wikipedia.org/wiki/Hooking 
31) eBPF.io : https://ebpf.io/what-is-ebpf/#development-toolchains

References from others (Didn't go through them)

32) https://www.youtube.com/watch?v=iBkR4gvjxtE 
33) https://blog.yadutaf.fr/2017/07/28/tracing-a-packet-journey-using-linux-tracepoints-perf-ebpf/ 
34) https://www.collabora.com/news-and-blog/blog/2019/04/05/an-ebpf-overview-part-1-introduction/ 
35) https://stackoverflow.com/questions/67553794/what-is-variable-attribute-sec-means 
36) https://bpietraga.me/experiments-with-writing-c-ebpf-code/ 
37) https://blogs.igalia.com/dpino/2019/01/10/the-express-data-path/
38) www.tigera.io%2Flearn%2Fguides%2Febpf%2Febpf-xdp%2F 
39) https://www.redhat.com/en/blog/using-express-data-path-xdp-red-hat-enterprise-linux-8 
40) https://stackoverflow.com/questions/55436213/how-can-i-get-the-bpf-helpers-h-header-file-for-my-linux-kernel 
41) https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/network-tracing-using-the-bpf-compiler-collection_configuring-and-managing-networking 
42) https://dev.to/satrobit/absolute-beginner-s-guide-to-bcc-xdp-and-ebpf-47oi 
43) https://www.mcorbin.fr/pages/xdp-introduction/ 


References regarding DOS

42) [What is DOS? - Cloudfare](https://www.cloudflare.com/en-gb/learning/ddos/glossary/denial-of-service/)
43) [Ping of Death](https://www.cloudflare.com/en-gb/learning/ddos/glossary/denial-of-service/)
44) [Types of DOS Attacks](https://www.educba.com/types-of-dos-attacks/)
45) hello


Some cloudfare tools for reference:

46) [xdpcap - tcmdump with xdp packet filter](https://github.com/cloudflare/xdpcap)
47) [Rakelimit - UDP Packet filter - Blog - has other links](https://blog.cloudflare.com/building-rakelimit/)
48) [Rakelimit - Github Repo](https://github.com/cloudflare/rakelimit)
49) 

Some more papers and Articles:

50) [Signature based DDOS prevention in xdp](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=9511420)
51) [Signature-Based DDoS Attack Mitigation: Automated Generating Rules for
Extended Berkeley Packet Filter and Express Data Path](https://essay.utwente.nl/80125/1/vanwieren_MA_DACS.pdf)
52) [DoS and DDoS mitigations with eBPF, XDP and DPDK](https://www.slideshare.net/azilian/dos-and-ddos-mitigations-with-ebpf-xdp-and-dpdk)

Some repo's :

53) [eBPF-firewall repo](https://github.com/nikofil/ebpf-firewall/tree/master)


### Getting in on the Fun

To join my eBPF adventure, here's what you can do:

1. Clone this repo to your local machine:

   ```bash
   git clone https://github.com/MeherRushi/learning-ebpf.git
   ```
Explore my code snippets, learning logs, and experiments. Feel free to tinker and experiment on your own.

Share your own eBPF insights or collaborate on wild experiments. We're all learning, so let's share the knowledge!

<!-- ## Let's Collaborate!

I'm all ears for contributions and discussions. If you have cool eBPF code, tips, or just want to chat, feel free to jump in. Check out my [contribution guidelines](CONTRIBUTING.md) for the lowdown.

## Connect with the eBPF Tribe

Join our eBPF-loving community! Ask questions, share your eBPF stories, or just hang out:

- [GitHub Discussions](https://github.com/your-username/learning-ebpf/discussions)

## Licensing Stuff

This learning journey is licensed under the [MIT License](LICENSE.md). It's all about sharing the knowledge and having a blast while doing it! -->

Happy eBPF-ing! 🧙‍♂️

