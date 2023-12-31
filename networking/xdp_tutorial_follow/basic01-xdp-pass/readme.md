# How to load a xdp program ? 

## Step 1 : Writing a simple XDP Program
Writing a xdp program - I think we learnt that thing

## Step 2 : Compiling to an ELF object file
Compiling it - Using Make Files or the direct terminal - Doable.
The LLVM+clang compiler turns this restricted-C code into BPF-byte-code and stores it in an ELF object file, named xdp_pass_kern.o.

### Looking into the BTF Byte code (BPF-ELF object)
You can inspect the contents of the xdp_pass_kern.o file with different tools like readelf or llvm-objdump. As the Makefile enables the debug option -g (LLVM version >= 4.0), the llvm-objdump tool can annotate assembler output with the original C code:

Run: 
```bash
llvm-objdump -S xdp_pass_kern.o
```

## Step 3 : Loading and the XDP hook
Loading the xdp program .Okay there are couple of ways to do it.

1) **Manually Writing a C program** :
Might be an overkill but like used again used in tutoral basics02. The libbpf library provides both an ELF loader and several BPF helper functions. It understands BPF Type Format (BTF) and implements CO-RE relocation as part of ELF loading, which is where our libelf-devel dependency comes from.

>The C code in xdp_pass_user.c (which gets compiled to the program xdp_pass_user) shows how to write a BPF loader specifically for our xdp_pass_kern.o ELF file. This loader attaches the program in the ELF file to an XDP hook on a network device.

It does seem overkill to write a C program to simply load and attach a specific BPF-program. However, we still include this in the tutorial since it will help you integrate BPF into other Open Source projects.


- **Loading it user the xdp_pass_user program**
    To load the program using our own loader, issue this command:
    ```
    $ sudo ./xdp_pass_user --dev lo
    Success: Loading XDP prog name:xdp_prog_simple(id:732) on device:lo(ifindex:1)
    ```

    Loading the program again will add a second program instance to the XDP dispatcher on the interface.

    ```
    $ sudo ./xdp_pass_user -d lo
    Success: Loading XDP prog name:xdp_prog_simple(id:745) on device:lo(ifindex:1)

    $ xdp-loader status lo
    CURRENT XDP PROGRAM STATUS:

    Interface        Prio  Program name      Mode     ID   Tag               Chain actions
    --------------------------------------------------------------------------------------
    lo                     xdp_dispatcher    skb      738  94d5f00c20184d17
    =>              50     xdp_prog_simple           732  3b185187f1855c4c  XDP_PASS
    =>              50     xdp_prog_simple           745  3b185187f1855c4c  XDP_PASS

    ```


2) **The standard iproute2 tool**

Iproute2 provides libbpf based BPF loading capability that can be used with the standard ip tool; 

So in this case you can actually load our ELF-file xdp_pass_kern.o (where we named our ELF section “xdp”) like this:
```
ip link set dev lo xdpgeneric obj xdp_pass_kern.o sec xdp
```

Listing the device via ip link show also shows the XDP info:
```
$ ip link show dev lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 xdpgeneric qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    prog/xdp id name xdp_prog_simple 220 tag 3b185187f1855c4c jited     
```

Removing the XDP program again from the device:
```
ip link set dev lo xdpgeneric off
```

It is important to note that the ip tool from iproute2 does not implement the XDP multi-dispatch protocol. When we use this tool, our program gets attached directly to the lo interface.


3) **BPFTOOL**

From the learningebpf book - loaded the eBPF program and attached it to the eth0 interface using the follow‐
ing commands:
```
bpftool prog load hello.bpf.o /sys/fs/bpf/hello
bpftool net attach xdp id 540 dev eth0
```
It’s worth noting that XDP programs attach to a specific interface (or virtual interface), and you may very well have different XDP programs attached to different Networking interfaces.


4) ⚠️**xdp_loader**⚠️
> I couldn't install. I am able to run the loader in the xdp-tools/xdp-loader but not as a command.I'm not sure what the erroris but ig I have to manually set path. I'm not sure though :( 

The xdp-tools project provides the xdp-loader tool which has commands for loading, unloading and showing the status of loaded XDP programs.

We can load our xdp_pass_kern.o program and attach it using the XDP multi-dispatch protocol like this:

```
xdp-loader load -m skb lo xdp_pass_kern.o
```
We can show the status of the XDP programs attached to the device:
```bash
$ xdp-loader status lo
CURRENT XDP PROGRAM STATUS:

Interface        Prio  Program name      Mode     ID   Tag               Chain actions
--------------------------------------------------------------------------------------
lo                     xdp_dispatcher    skb      486  94d5f00c20184d17
 =>              50     xdp_prog_simple           493  3b185187f1855c4c  XDP_PASS
 ```


 #### Issues I faced and their resolution

- Okay, **ISSUE 1** : we need to make sure to include xdp in the path of the compilation of xdp programs. The best way I can think of doing it is by adding the libxdp folder in the current working directory and then use #include "libxdp" rather than from the system directories folder, or else I will have to add it to my gcc search directories or manually to usr/inlcude. Or this could also be done by adding a -I tag while doing the compilation process. For Example. 
```bash
gcc -Wall -I ../../../xdp-tools/headers/ -lebpf -lelf -lrt -D __BPF_TRACING__ -o xdp_pass_user xdp_pass_user.c
```
    Also take note that -lebpf and -lelf -lrt flags are used along with a few extra others, Always good to include

- Along the same lines **ISSUE 2** is for the xdp_loader. Either manually add the path of the program to the PATH variable or like add it to the PATH variable permanantly. So adding it to the bash doesnt seem like a great idea, because it will load that as a path variable everytime the shell is loaded which is an overhead I believe.

    So the best thing to do would be to add the path of the tool manually everytime. Below is the command I used based on the current path . Feel free to modify it according to the project

    ```bash
     export PATH=$PATH:~/Meher/learning/ebpf/xdp-tools/xdp-loader/xdp-loader
    ```
    The above command adds the mentioned path to the path environment variable add the end. (Appends)

> I think the best way to deal with these issues is to install both libbpf and libxdp and write a make file that uses them. It kind of solves the issue.

- When I do all the above fixes and try to use xdp-loader I get some kind of crappy message saying `This program must be run as root.` and when I sudo run it, then I get sudo: command not found error. I am kind of going a little crazy rn, so imma take lite on this tool.


