#include "vmlinux.h"
#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>
#include "packet.h"

SEC("xdp")
int xdp_ping(struct xdp_md *ctx){
    long protocol = lookup_protocol(ctx);

    if(protocol == 1) // ICMP protocol number is 1
    {
        bpf_printk("Hello ping");
    }
    return XDP_PASS;
}

char LICENSE[] SEC("license") = "Dual BSD/GPL";