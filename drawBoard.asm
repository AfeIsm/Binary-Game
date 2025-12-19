# drawBoard.asm — renders the 8-bit ASCII game board for binary display

.include "SysCalls.asm"

.data
topBorder:    .asciiz "+---+---+---+---+---+---+---+---+\n"
bottomBorder: .asciiz "+---+---+---+---+---+---+---+---+\n"
endBar:       .asciiz "|\n"
emptyCell:    .asciiz "|   "
cellStart:    .asciiz "| "
cellSpace:    .asciiz " "

.text
.globl drawBoard
.globl drawEmptyBoard

drawBoard:
    addi $sp, $sp, -12
    sw   $ra, 8($sp)
    sw   $s0, 4($sp)
    sw   $s1, 0($sp)
    move $s0, $a0
    li   $s1, 8
    li   $v0, SysPrintString
    la   $a0, topBorder
    syscall
print_loop:
    beqz $s1, done_row
    li   $v0, SysPrintString
    la   $a0, cellStart
    syscall
    lb   $t0, 0($s0)
    li   $v0, SysPrintChar
    move $a0, $t0
    syscall
    li   $v0, SysPrintString
    la   $a0, cellSpace
    syscall
    addi $s0, $s0, 1
    addi $s1, $s1, -1
    j    print_loop
done_row:
    li   $v0, SysPrintString
    la   $a0, endBar
    syscall
    li   $v0, SysPrintString
    la   $a0, bottomBorder
    syscall
    lw   $s1, 0($sp)
    lw   $s0, 4($sp)
    lw   $ra, 8($sp)
    addi $sp, $sp, 12
    jr   $ra

drawEmptyBoard:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $s0, 0($sp)
    li   $v0, SysPrintString
    la   $a0, topBorder
    syscall
    li   $t1, 8
empty_loop:
    beqz $t1, end_empty
    li   $v0, SysPrintString
    la   $a0, emptyCell
    syscall
    addi $t1, $t1, -1
    j    empty_loop
end_empty:
    li   $v0, SysPrintString
    la   $a0, endBar
    syscall
    li   $v0, SysPrintString
    la   $a0, bottomBorder
    syscall
    lw   $s0, 0($sp)
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra
