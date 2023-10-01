```C
SEC("xdp")

int firewall(struct xdp_md *ctx)
{
    bool drop;

    drop = <examine whether the packet to be dropped or not>

    if(drop)
        return XDP_DROP;
    else
        return XDP_PASS;
}
```

An XDP program can also manipulate the packet contents

> the ctx parameter is a pointer to an xdp_md structure which holds holds the metadata about the incoming packet. (xdp 
--> xdp and md --> metadata)

