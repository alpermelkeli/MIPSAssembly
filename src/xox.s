.data
prompt1:    .asciiz "Player X - Choose a position (0-8): "
prompt2:    .asciiz "Player O - Choose a position (0-8): "
invalid:    .asciiz "Invalid move! Try again.\n"
newline:    .asciiz "\n"
board:      .space 9          # 9 bytes for the 3x3 board

.text
.globl main

main:
    # Initialize the board with '.' characters
    li $t0, 0              # i = 0
    li $t1, 9              # limit = 9
    li $t2, 46             # '.' ASCII = 46
init_loop:
    beq $t0, $t1, game_loop_start
    sb $t2, board($t0)
    addi $t0, $t0, 1
    j init_loop

game_loop_start:
    li $s0, 0              # Turn: 0 = X, 1 = O

game_loop:
    jal print_board

    # Print prompt based on whose turn it is
    beq $s0, 0, prompt_X
    li $v0, 4
    la $a0, prompt2
    syscall
    j get_input

prompt_X:
    li $v0, 4
    la $a0, prompt1
    syscall

get_input:
    li $v0, 5          # Read integer from user
    syscall
    move $t3, $v0      # $t3 = player's move (0–8)

    # Validate move: 0 <= move < 9
    blt $t3, 0, invalid_move
    bge $t3, 9, invalid_move

    # Check if the selected position is empty
    lb $t4, board($t3)
    li $t5, 46          # '.' character
    bne $t4, $t5, invalid_move

    # Write X or O to the board
    beq $s0, 0, write_X
    li $t6, 79          # ASCII 'O'
    sb $t6, board($t3)
    j switch_turn

write_X:
    li $t6, 88          # ASCII 'X'
    sb $t6, board($t3)

switch_turn:
    # Switch turn (0 <-> 1)
    xori $s0, $s0, 1
    j game_loop

invalid_move:
    li $v0, 4
    la $a0, invalid
    syscall
    j game_loop

################################################
# print_board: Displays the 3x3 board on screen
################################################
print_board:
    li $t0, 0
print_loop:
    beq $t0, 9, print_done
    lb $a0, board($t0)
    li $v0, 11      # Print a single character
    syscall

    addi $t0, $t0, 1
    remu $t1, $t0, 3
    bne $t1, $zero, print_loop

    # Print newline after every 3 characters
    li $v0, 4
    la $a0, newline
    syscall
    j print_loop

print_done:
    jr $ra

