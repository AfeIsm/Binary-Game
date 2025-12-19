# convertDecimalToBinary.asm — converts an integer (0–255) into an 8-bit binary string

.include "SysCalls.asm"

.data
binaryBuffer: .space 9

.text
.globl convertDecimalToBinary
convertDecimalToBinary:
    la   $t0, binaryBuffer
    addi $t0, $t0, 8
    sb   $zero, 0($t0)
    addi $t0, $t0, -1
    move $t1, $a0
    li   $t2, 8
loop_bits:
    beqz $t2, done
    andi $t3, $t1, 1
    beqz $t3, bit_zero
    li   $t4, '1'
    j    store_bit
bit_zero:
    li   $t4, '0'
store_bit:
    sb   $t4, 0($t0)
    srl  $t1, $t1, 1
    addi $t0, $t0, -1
    addi $t2, $t2, -1
    j    loop_bits
done:
    la   $v0, binaryBuffer
    jr   $ra
