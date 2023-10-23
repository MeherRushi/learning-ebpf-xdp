# Dependencies 

The main dependencies are `libxdp`, `libbpf`, `llvm`, `clang` and `libelf`. LLVM+clang compiles our restricted-C programs into BPF-byte-code, which is stored in an ELF object file (libelf), that is loaded by libbpf into the kernel via the bpf syscall. XDP programs are managed by libxdp which implements the XDP multi-dispatch protocol. Some of the lessons also use the perf utility to track the kernel behaviour through tracepoints.

## Packages on Debian/Ubuntu
On Debian and Ubuntu installations, install the dependencies like this:

```linux
 $ sudo apt install clang llvm libelf-dev libpcap-dev build-essential
 ```

To install the ‘perf’ utility, run this on Debian:

```
 $ sudo apt install linux-perf
 ```

or this on Ubuntu:

```
$ sudo apt install linux-tools-$(uname -r)
```



# Kernel headers dependency
The Linux kernel provides a number of header files, which are usually installed in /usr/include/linux. The different Linux distributions usually provide a software package with these headers.

Some of the header files (we depend on) are located in the kernel tree under include/uapi/linux/ (e.g. include/uapi/linux/bpf.h), but you should not include those files as they go through a conversion process when exported/installed into distros’ /usr/include/linux directory. In the kernel git tree you can run the command: make headers_install which will create a lot of headers files in directory “usr/”.

For now, this tutorial depends on kernel headers package provided by your distro. We may choose to shadow some of these later.


## Packages on Debian/Ubuntu
On Debian and Ubuntu installations, install the headers like this

```
$ sudo apt install linux-headers-$(uname -r)
```

# Recommended tools
The bpftool is the recommended tool for inspecting BPF programs running on your system. It also offers simple manipulation of eBPF programs and maps. The bpftool is part of the Linux kernel tree under tools/bpf/bpftool/, but some Linux distributions also ship the tool as a software package.

If you are planning on working through the packet processing examples you should also install tcpdump.

##Packages on Ubuntu
Starting from Ubuntu 19.10, bpftool can be installed with:
```
$ sudo apt install linux-tools-common linux-tools-generic
$ sudo apt install tcpdump
```