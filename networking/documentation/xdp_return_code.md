# XDP Program Return Codes

An xdp program is triggered by the arrival of a network packet. The program examines the packet, and when it is done,
the return code gives a verdict on what to do with the packet:

- XDP_PASS indicates that the packet should be sent to the netwrok stack in the normal way (as if there was no XDP program)

- XDP_DROP causes the packet to be discarded immediately.

- XDP_TX sends the packet back out on the same interface that it arrived on

- XDP_REDIRECT is used to send the packet to another interface

- XDP_ABORTED results in the packet being dropped but implies an error case or something unexpected rather than a normal drop
