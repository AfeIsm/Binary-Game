# gameMain.asm —main game logic and level control for the Binary Game

.include "SysCalls.asm"

.data
welcomeMsg:      .asciiz "\nWelcome to the Binary Game!\n"
levelMsg:        .asciiz "\n--- Level "
questionsMsg:    .asciiz " ---\n"
levelDoneMsg:    .asciiz "\nLevel complete! Moving to next level...\n"
gameOverMsg:     .asciiz "\nCongratulations! You completed all 10 levels!\n"

.text
.globl gameMain
gameMain:
    li   $v0, SysPrintString
    la   $a0, welcomeMsg
    syscall
    li   $s1, 1              

level_loop:
    bgt  $s1, 10, game_complete

    li   $v0, SysPrintString
    la   $a0, levelMsg
    syscall
    li   $v0, SysPrintInt
    move $a0, $s1
    syscall
    li   $v0, SysPrintString
    la   $a0, questionsMsg
    syscall

    li   $s0, 0              

level_question_loop:
    bge  $s0, $s1, level_done

    addi $sp, $sp, -8
    sw   $s0, 0($sp)
    sw   $s1, 4($sp)

 
    jal  generateProblem
    move $s2, $v0           
    move $t4, $v1          

    # Only show board for binary → decimal
    beqz $s2, draw_bin_board
    j    do_validate

draw_bin_board:
    move $a0, $t4
    jal  convertDecimalToBinary
    move $t5, $v0
    move $a0, $t5
    jal  drawBoard

do_validate:
    beqz $s2, mode_0_validate   

    li   $a0, 1
    li   $a1, 0
    move $a2, $t4
    jal  validateAnswer
    j    after_validate

mode_0_validate:
    beqz $t5, mode0_generate_ptr
    j    mode0_have_ptr

mode0_generate_ptr:
    move $a0, $t4
    jal  convertDecimalToBinary
    move $t5, $v0

mode0_have_ptr:
    li   $a0, 0
    move $a1, $t5
    move $a2, $t4
    jal  validateAnswer

after_validate:
    lw   $s0, 0($sp)
    lw   $s1, 4($sp)
    addi $sp, $sp, 8

    addi $s0, $s0, 1
    j    level_question_loop

level_done:
    li   $v0, SysPrintString
    la   $a0, levelDoneMsg
    syscall
    addi $s1, $s1, 1
    j    level_loop

game_complete:
    li   $v0, SysPrintString
    la   $a0, gameOverMsg
    syscall
    li   $v0, SysExit
    syscall
