# Introduction

XDP is a part of the upstream Linux kernel, and enables users to install packet processing programs into the kernel, that will be executed for each arriving packet, before the kernel does any other processing on the data. The programs are written in restricted C, and compiled into the eBPF byte code format that is executed and JIT-compiled in the kernel, after being verified for safety. This approach offers great flexibility and high performance, and integrates well with the rest of the system. For a general introduction to XDP, read the academic paper (pdf), or the Cilium BPF reference guide.

This tutorial aims to be a practical introduction to the different steps needed to successfully write useful programs using the XDP system. We assume you have a basic understanding of Linux networking and how to configure it with the iproute2 suite of tools, but assume no prior experience with eBPF or XDP. Prior programming experience is also helpful: the lessons are all written in C and they include some basic pointer arithmetic and aliasing.

# Setting Up Dependencies
Refer to [Dependencies](Dependencies.md).
Extracted Information required for Debian or Ubuntu

Need to install
- ⬜ libxdp
- ⬜ xdp-tools 
- ✅ libbpf
- ✅ llvm
- ✅ clang
- ✅ libelf-dev
- ✅ libpcap-dev 
- ✅ build-essential
- ✅ sudo apt-get install -y gcc-multilib (On x86_64 PC, the gcc-multilib debian package makes a symbol link at "/usr/include/asm" to "/usr/include/x86_64-linux-gnu".
I guess that on the ARM32 system (Raspbian) /usr/include/asm might linked to /usr/include/aarch64-linux-gnu or arm-linux-gnueabihf)

# Credits

This is based on the tutorial in the [repo](https://github.com/xdp-project/xdp-tutorial)


## NOTE

I have written my own comments while solving the assignments which are for my future reference


I should have forked and started working on the repo directly, but I already started and reached a certain point of progress by the time I realised that cloned the repo from upstream without forking.

Initially I made the effort to write my own Make files but after a lot of failed attempts and complicated navigation that the tutorial had posed, I decided to copy the files and use them as and when needed. 

I initially also had a more clean directory structure in mind (which doesn't require me to repeadedly clone the libxdp repo) but I decided not to mess with it due make files configurations