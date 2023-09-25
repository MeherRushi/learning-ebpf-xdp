TARGETS = hello hello-func

all: $(TARGETS)
.PHONY: all

$(TARGETS): %: %.bpf.o

%.bpf.o: %.bpf.c
	clang \
		-target bpf \
			-I/usr/include/$(shell uname -m)-linux-gnu \	# -I tag is used in the gcc compiler to tell the complier to include the follwoing directories to look for while searching for the #include preporecessor statement
			-g \		#-g for debigging
		-O2 -o $@ -c $<						#-O2 optimization level 2, $@ for the target and $< is the name of the first pre-req file, -o naming the output file and -c compile till like the assembly code
clean:
	-rm *.bpf.o
	-rm -f /sys/fs/bpf/hello
	-rm -f /sys/fs/bpf/hello-func
