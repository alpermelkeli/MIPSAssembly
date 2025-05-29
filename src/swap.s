        .data
val1:   .word 10
val2:   .word 20

        .text
        .globl main

main:
	#val1 and val2 stores the adress of data
        la   $a0, val1
        la   $a1, val2

        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        jal  swap

        lw   $ra, 0($sp)
        addi $sp, $sp, 4

        jr   $ra

swap:
        lw   $t0, 0($a0)
        lw   $t1, 0($a1)

        sw   $t1, 0($a0)
        sw   $t0, 0($a1)

        jr   $ra

