from bcc import BPF
from bcc.utils import printb

BPF_SOURCE_CODE = r"""
#include <linux/ip.h>

#define MAC_HEADER_SIZE 14;
#define member_address(source_struct, source_member)            \
    ({                                                          \
        void* __ret;                                            \
        __ret = (void*) (((char*)source_struct) + offsetof(typeof(*source_struct), source_member)); \
        __ret;                                                  \
    }) 
#define member_read(destination, source_struct, source_member)  \
  do{                                                           \
    bpf_probe_read(                                             \
      destination,                                              \
      sizeof(source_struct->source_member),                     \
      member_address(source_struct, source_member)              \
    );                                                          \
  } while(0)

typedef struct hist_key {
  char ipv4_daddr[4];
} hist_key_t;
  
BPF_HISTOGRAM(counter, hist_key_t);

static inline int do_trace(void* ctx, struct sk_buff* skb) {
  char* head;
  u16 mac_header;
  u16 network_header;
  
  member_read(&head, skb, head);
  member_read(&mac_header, skb, mac_header);
  member_read(&network_header, skb, network_header);
  
  if(network_header == 0) {
    network_header = mac_header + MAC_HEADER_SIZE;
  }

  char *ip_header_address = head + network_header;

  u64 ip_version = 0;
  bpf_probe_read(&ip_version, sizeof(u8), ip_header_address);
  ip_version = ip_version >> 4 & 0xf;

  if (ip_version == 4) { // IPv4
    struct iphdr ip_header;
    bpf_probe_read(&ip_header, sizeof(ip_header), ip_header_address);
    if (ip_header.protocol == 1) { // ICMP, other fields: ttl
      // Spliting IPv4 address, should be a better way to copy objects
      unsigned char ip_parts[4];
      ip_parts[0] = ip_header.daddr & 0xFF;
      ip_parts[1] = (ip_header.daddr >> 8) & 0xFF;
      ip_parts[2] = (ip_header.daddr >> 16) & 0xFF;
      ip_parts[3] = (ip_header.daddr >> 24) & 0xFF;
      
      hist_key_t key = {};
      key.ipv4_daddr[0] = ip_parts[0];
      key.ipv4_daddr[1] = ip_parts[1];
      key.ipv4_daddr[2] = ip_parts[2];
      key.ipv4_daddr[3] = ip_parts[3];

      counter.increment(key);

      bpf_trace_printk("ICMP packet to %d.%d.x.%d\n", ip_parts[0], ip_parts[1], ip_parts[3]);
    }
  }

  return 0;
}

TRACEPOINT_PROBE(net, net_dev_queue) {
  do_trace(args, (struct sk_buff*)args->skbaddr);
  return 0;
}
"""

bpf = BPF(text = BPF_SOURCE_CODE)

while True:
  try:
    (task, pid, cpu, flags, ts, msg) = bpf.trace_fields()
    printb(b"%-6d %s" % (pid, msg))
    for i, count in bpf["counter"].items():
      print("%d.%d.%d.%d: %d" % (i.ipv4_daddr[0], i.ipv4_daddr[1], i.ipv4_daddr[2], i.ipv4_daddr[3], count.value))
  except ValueError:
    continue
  except KeyboardInterrupt:
    break