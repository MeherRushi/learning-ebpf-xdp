# https://www.youtube.com/watch?v=viQRxaxs70c&ab_channel=TheDigitalFolks
TARGET = xdp_ping
BPF_OBJ = ${TARGET:=.bpf.o}

all: $(TARGET) $(BPF_OBJ) 
.PHONY: all 
.PHONY: $(TARGET)

$(TARGET): $(BPF_OBJ)
	bpftool net detach xdp dev lo
	rm -f /sys/fs/bpf/$(TARGET)
	bpftool prog load $(BPF_OBJ) /sys/fs/bpf/$(TARGET)
	bpftool net attach xdp pinned /sys/fs/bpf/$(TARGET) dev lo


$(BPF_OBJ): %.o: %.c vmlinux.h
	clang \
	    -target bpf \
	    -D __BPF_TRACING__ \
		-I/usr/include/$(shell uname -m)-linux-gnu \
		-g \
	    -Wall \
	    -O2 -o $@ -c $<

vmlinux.h:
	bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

clean:
	- bpftool net detach xdp dev lo
	- rm -f /sys/fs/bpf/$(TARGET)
	- rm $(BPF_OBJ)
	- rm vmlinux.h
