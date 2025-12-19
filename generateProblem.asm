# generateProblem.asm — creates random binary or decimal problems for each game round

.include "SysCalls.asm"

.data
.globl currentMode
currentMode:   .word 0
binaryPrompt:  .asciiz "Binary: "
decimalPrompt: .asciiz "Decimal: "
newline:       .asciiz "\n"
randSeeded:    .word 0
randGenID:     .word 1

.text
.globl generateProblem

generateProblem:
    subu $sp, $sp, 24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)

    la   $t0, randSeeded
    lw   $t1, 0($t0)
    bne  $t1, $zero, rng_seeded_done
    li   $v0, 30
    syscall
    move $t2, $a0
    li   $a0, 1
    move $a1, $t2
    li   $v0, 40
    syscall
    li   $t1, 1
    sw   $t1, 0($t0)

rng_seeded_done:
    la   $t3, randGenID
    lw   $s3, 0($t3)
    move $a0, $s3
    li   $a1, 2
    li   $v0, 42
    syscall
    move $s0, $a0
    la   $t4, currentMode
    sw   $s0, 0($t4)
    move $a0, $s3
    li   $a1, 256
    li   $v0, 42
    syscall
    move $s1, $a0
    beqz $s0, display_binary_problem
    li $v0, SysPrintString
    la $a0, decimalPrompt
    syscall
    li $v0, SysPrintInt
    move $a0, $s1
    syscall
    li $v0, SysPrintString
    la $a0, newline
    syscall
    j generate_done

display_binary_problem:
    move $a0, $s1
    jal convertDecimalToBinary
    move $t0, $v0
    li $v0, SysPrintString
    la $a0, binaryPrompt
    syscall
    li $v0, SysPrintString
    move $a0, $t0
    syscall
    li $v0, SysPrintString
    la $a0, newline
    syscall

generate_done:
    move $v0, $s0
    move $v1, $s1
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    addu $sp, $sp, 24
    jr $ra
