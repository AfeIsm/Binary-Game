# validateAnswer.asm — validates player input for both conversion modes

.include "SysCalls.asm"

.data
msgCorrect:      .asciiz "Correct!\n"
msgWrong:        .asciiz "Incorrect, try again!\n"
msgInvalidBin:   .asciiz "Invalid binary input (use only 0 and 1). Try again.\n"
cleanBuffer:     .space  40

.text
.globl validateAnswer

validateAnswer:
    beqz $a0, mode_bin_to_dec
    j mode_dec_to_bin

mode_bin_to_dec:
    subu $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    move $a0, $a1
    jal convertBinaryToDecimal
    move $s0, $v0
bin_dec_loop:
    li $a0, 0
    jal getUserInput
    move $s1, $v0
    beq $s1, $s0, bin_dec_correct
    li $v0, SysPrintString
    la $a0, msgWrong
    syscall
    j bin_dec_loop
bin_dec_correct:
    li $v0, SysPrintString
    la $a0, msgCorrect
    syscall
    li $v0, 1
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    addu $sp, $sp, 12
    jr $ra

mode_dec_to_bin:
    subu $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    move $s0, $a2
dec_bin_loop:
    li $a0, 1
    jal getUserInput
    move $t0, $v0
    la $t1, cleanBuffer
    li $t2, 0
sanitize_loop:
    lb $t3, 0($t0)
    beqz $t3, sanitize_done
    li $t4, '0'
    beq $t3, $t4, store_char
    li $t4, '1'
    beq $t3, $t4, store_char
    li $t4, ' '
    beq $t3, $t4, skip_char
    li $t4, '\n'
    beq $t3, $t4, skip_char
    li $t4, '\t'
    beq $t3, $t4, skip_char
skip_char:
    addi $t0, $t0, 1
    j sanitize_loop
store_char:
    sb $t3, 0($t1)
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    addi $t0, $t0, 1
    j sanitize_loop
sanitize_done:
    sb $zero, 0($t1)
    beqz $t2, invalid_binary_input
    la $a0, cleanBuffer
    jal convertBinaryToDecimal
    move $s1, $v0
    beq $s1, $s0, dec_bin_correct
    li $v0, SysPrintString
    la $a0, msgWrong
    syscall
    j dec_bin_loop
invalid_binary_input:
    li $v0, SysPrintString
    la $a0, msgInvalidBin
    syscall
    j dec_bin_loop
dec_bin_correct:
    li $v0, SysPrintString
    la $a0, msgCorrect
    syscall
    li $v0, 1
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    addu $sp, $sp, 12
    jr $ra
