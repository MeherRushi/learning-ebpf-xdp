# Important facts

## Makefile 

Okay, so I didn't about the makefiles for a very long time. It is disappointing, I concur.
But moving ahead makefiles are very instrumental in building C programs.

### What's a Makefile, anyway?

A Makefile is a powerful tool for automating the build process of your software projects. It allows you to define rules and dependencies for building, compiling, and organizing your code, making it easier to manage complex projects.

### Description

This repo will contain a lot text files with random facts, will try to organise and make the documentation better later.

## Resources

I did learn from the internet. Would recommend the following 
    - [Software development with c++](https://www.youtube.com/watch?v=yM2BvbQksTc&list=PLxNPSjHT5qvu27ax_VIAalaGIEjxj2Bp0&index=3&ab_channel=CoffeeBeforeArc)
    - [Basics of Makefile](https://youtu.be/yWLkyN_Satk?si=r9KjPNIBhzPkCsTl)


## the Strace Error : 

```strace: exec: Exec format error
+++ exited with 1 +++```

The error message you've provided, "strace: exec: Exec format error," indicates that the strace command encountered an issue when trying to execute the specified program. This error typically occurs when the format of the executable file is not recognized or is incompatible with the system.

Here's what this message means:
- strace is a utility used for tracing system calls and signals made by a program.
- "exec:" indicates that strace is trying to execute a program.
- "Exec format error" means that the format of the program being executed is not valid or recognized by the system.

This error is often seen when you try to execute a binary or script that is incompatible with your system's architecture or operating system. Some common reasons for this error include:
- The binary is compiled for a different architecture (e.g., trying to run a 64-bit binary on a 32-bit system).
- The binary is corrupted or incomplete.
- The script or binary file lacks a proper shebang line (e.g., #!/bin/bash for a Bash script) and doesn't specify how it should be executed.