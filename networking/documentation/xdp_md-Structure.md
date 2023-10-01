Definintion of `xdp_md`

```C
struct xdp_md 
{
    __u32 data;
    __u32 data_end;
    __u32 data_meta;
    /* Below acces go through struct_rxq_info*/
    /* Below access go through struct xdp_rxq_info */
__u32 ingress_ifindex; /* rxq->dev->ifindex */
__u32 rx_queue_index; /* rxq->queue_index */
__u32 egress_ifindex; /* txq->dev->ifindex */
};
```

> the __u32 is actually a _pointer_ I am not quite sure why though???????