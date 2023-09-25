"""
This eBPF program will be attached to a kprobe at the entry to the execve system call. 
It’s going to populate a hash table with key–value pairs, where the key is a 
user ID and the value is a counter for the number of times execve is called 
by a process running under that user ID. In practice, this
example will show how many times each different user has run programs"""

#!bin/bash/python

from bcc import BPF

# BPF_HASH(counter_table) is a BCC macro that defines a hash table map

# bpf_get_current_uid_gid() is a helper function used to obtain the user ID
# that is running the process that triggered this kprobe event. This uid is held
# in the lower 32 bits of the 64-bit value that gets returned. (The top 32 bits hold
# the group ID, but that part is masked out.) [the & 0xFFFFFFF is the masking part]

# Look for an entry in the hash table with a key matching the user ID. It returns a
# pointer to the corresponding value in the hash table. the pointer is stored in p.



# Now update the counter 

program = r""" BPF_HASH(counter_table);

int hello(void *ctx)
{
    u64 uid;
    u64 counter = 0;
    u64 *p ;
}

uid = bpf_get_current_uid_gid() & 0xFFFFFFFF;
p = counter_table.lookup(&uid);
if(p!=0)
{
    counter = *p;
}
counter++;
counter_table.update(&uid, &counter);
return 0; """

b = BPF(text=program)
