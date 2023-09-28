"""
In this program, we are just printing a Hello World statement
every time a execve system call happens. The logs that are appearing on screen by
the python user space program is because the bpf_trace_printk() helper
function in the kernel always sends output to the same predefined pseudofile loca‐
tion: /sys/kernel/debug/tracing/trace_pipe"""

#!/usr/bin/python3  
from bcc import BPF

""" The eBPF program itself is 
written in C code, and it’s this part: """

# This is the code that runs in the
# kernel and the rest of the code exists in the 
# user space only. This C code is executed 
# due to a some event and we attach it to a hook or 
# kprobe which then runs it directly in the 
# kernel.

""" All the eBPF program does is use a helper function, bpf_trace_printk(), to write a
message. Helper functions are another feature that distinguishes “extended” BPF
from its “classic” predecessor. They are a set of functions that eBPF programs can call
to interact with the system; For now you can just think of this as printing a line of text. """

program = r"""
int hello(void *ctx) {
    bpf_trace_printk("Hello World!");
    return 0;
}
"""

""" The entire eBPF program is defined as a string called program in the Python code.
This C program needs to be compiled before it can be executed, but BCC takes care
of that for you. All you need to do is pass this string as a parameter when creating a BPF object,
as in the following line: """
b = BPF(text=program)


""" eBPF programs need to be attached to an event, and for this example I’ve chosen to
attach to the system call execve, which is the syscall used to execute a program.
Whenever anything or anyone starts a new program executing on this machine, that
will call execve(), which will trigger the eBPF program. Although the “execve()”
name is a standard interface in Linux, the name of the function that implements it in
the kernel depends on the chip architecture, but BCC gives us a convenient way to
look up the function name for the machine we’re running on: """
syscall = b.get_syscall_fnname("execve")


""" Now, syscall represents the name of the kernel function I’m going to attach to, using
a kprobe .You can attach the hello function to that event, like this: """
b.attach_kprobe(event=syscall, fn_name="hello")

""" At this point, the eBPF program is loaded into the kernel and attached to an event, so
the program will be triggered whenever a new executable gets launched on the
machine. All that’s left to do in the Python code is to read the tracing that is output by
the kernel and write it on the screen: """
b.trace_print()
""" This trace_print() function will loop indefinitely (until you stop the program, per‐
haps with Ctrl+C), displaying any trace. """


""" Some commands (echo is a common example) might be shell built-ins that run as part of the shell process,
rather than executing a new program. These won’t trigger the execve() event, so no trace will be generated. """

""" There is a more performant way to attach eBPF programs to functions, available from kernel version 5.5
onward, that uses fentry (and the corresponding fexit instead of kretprobe for the exit from a function) """