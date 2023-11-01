from bcc import BPF
from bcc.utils import printb

BPF_SOURCE_CODE = r"""
#define SIGKILL 9

static inline bool equal_to_true(const char *str) {
  char comparand[11];
  bpf_probe_read(&comparand, sizeof(comparand), str);
  char compare[] = "/tmp/secret";
  for (int i = 0; i < 11; ++i)
    if (compare[i] != comparand[i])
      return false;
  return true;
}

TRACEPOINT_PROBE(syscalls, sys_enter_openat) {
  // args details on /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
  if(equal_to_true(args->filename) == true) {
    bpf_trace_printk("Killing process trying to access: %s\n", args->filename);
    bpf_send_signal(SIGKILL);
  }
  return 0;
}
"""

bpf = BPF(text = BPF_SOURCE_CODE)

while True:
  try:
    (task, pid, cpu, flags, ts, msg) = bpf.trace_fields()
    printb(b"%-6d %s" % (pid, msg))
  except ValueError:
    continue
  except KeyboardInterrupt:
    break