# main.asm — program entry point for the Binary Game

.include "SysCalls.asm"

.text
.globl main

main:
    jal gameMain
    li $v0, SysExit
    syscall



