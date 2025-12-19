# convertBinaryToDecimal.asm — converts an 8-bit binary string to its decimal value

.include "SysCalls.asm"

.text
.globl convertBinaryToDecimal

convertBinaryToDecimal:
    li $v0, 0
    li $t0, 0
convert_loop:
    lb $t1, 0($a0)
    beqz $t1, convert_done
    sll $v0, $v0, 1
    li $t2, '1'
    beq $t1, $t2, add_one
    j next_char
add_one:
    addi $v0, $v0, 1
next_char:
    addi $a0, $a0, 1
    j convert_loop
convert_done:
    jr $ra
