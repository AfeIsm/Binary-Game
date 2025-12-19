# getUserInput.asm — handles decimal and binary user input

.include "SysCalls.asm"

.data
inputBuffer: .space 32
msgEnterDec: .asciiz "Enter decimal value: "
msgEnterBin: .asciiz "Enter binary value: "

.text
.globl getUserInput

getUserInput:
    beqz $a0, get_decimal_input
    j get_binary_input

get_decimal_input:
    li   $v0, SysPrintString
    la   $a0, msgEnterDec
    syscall
    li   $v0, SysReadInt
    syscall
    jr   $ra

get_binary_input:
    li   $v0, SysPrintString
    la   $a0, msgEnterBin
    syscall
    li   $v0, SysReadString
    la   $a0, inputBuffer
    li   $a1, 32
    syscall
    la   $v0, inputBuffer
    jr   $ra
