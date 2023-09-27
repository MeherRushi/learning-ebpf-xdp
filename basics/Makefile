# -I tag is used in the gcc compiler to tell the complier to include 
# the follwoing directories to look for while searching for the #include preporecessor statement
# -g for debigging
# -O2 optimization level 2, $@ for the target and $< is the 
# name of the first pre-req file, -o naming the output file and -c compile till like the assembly code
# Sometimes "Nothing to be done for all" error can be caused by spaces 
# before command in makefile rule instead of tab. Please ensure that you use tabs instead of spaces inside of your rules.

TARGETS = hello hello-func

all: $(TARGETS)
.PHONY: all

$(TARGETS): %: %.bpf.o 

%.bpf.o: %.bpf.c
	clang \
	    -target bpf \
		-I/usr/include/$(shell uname -m)-linux-gnu \
		-g \
	    -O2 -o $@ -c $<

clean: 
	- rm *.bpf.o
	- rm -f /sys/fs/bpf/hello 
	- rm -f /sys/fs/bpf/hello-func
