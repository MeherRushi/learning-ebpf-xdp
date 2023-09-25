TARGETS = hello hello-func

all: $(TARGETS)
.PHONY: all

$(TARGETS): %: %.bpf.o

%.bpf.o: %.bpf.c
	clang \
		-target bpf \
			-I/usr/include/$(shell uname -m)-linux-gnu \	# -I tag is used in the gcc compiler to tell the complier to include the follwoing directories to look for while searching for the #include preporecessor statement
			-g \
		-O2 -o $@ -c $<
clean:
	-rm *.bpf.o
	-rm -f /sys/fs/bpf/hello
	-rm -f /sys/fs/bpf/hello-func
