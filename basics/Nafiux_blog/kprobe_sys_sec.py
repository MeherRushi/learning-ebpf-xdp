#!/usr/bin/python3

from bcc import BPF

program = r"""
#include <uapi/linux/ptrace.h>

# define NAME_MAX 256
# define SIGKILL 9

static inline int fname_check(const char* __user filename) {
    char fname[NAME_MAX];
    bpf_probe_read_user_str(fname, sizeof(fname), filename);
    char base_fname[] = "secret";

    for (int i = 0; i < 6; i++){
        if (fname[i] != base_fname[i])
        return 0;
    }

  bpf_trace_printk("Killing process trying to access: %s\n", fname);
  return 1;
}

static inline int fname_check_abs(const char* __user filename) {
    char fname[NAME_MAX];
    bpf_probe_read_user_str(fname, sizeof(fname), filename);
    char base_fname[] = "/home/meherrushi/Meher/example/secret";
    int len = sizeof(base_fname)/sizeof(base_fname[0]) ;

    for (int i = 0; i < len; i++){
        if (fname[i] != base_fname[i])
        return 0;
    }

  bpf_trace_printk("Killing process trying to access: %s\n", fname);
  return 1;
}

int syscall__openat(struct pt_regs *ctx, int dfd, const char __user *filename, int flags) {

    if(fname_check(filename) == 1) {
        bpf_send_signal(SIGKILL);
    }

    if(fname_check_abs(filename) == 1) {
        bpf_send_signal(SIGKILL);
    }

    return 0;
}
"""

b = BPF(text=program)
syscall = b.get_syscall_fnname("openat")
b.attach_kprobe(event=syscall, fn_name="syscall__openat")

print("Tracing openat syscalls... Ctrl-C to end.")
b.trace_print()
