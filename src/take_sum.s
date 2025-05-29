        .data
val1:   .word 10
val2:   .word 20

        .text
        .globl main

main:
	#set arguments
	la   $t0, val1      # Load address of val1 into $t0
        lw   $a0, 0($t0)    # Load value at address into $a0

        la   $t1, val2      # Load address of val2 into $t1
        lw   $a1, 0($t1)    # Load value at address into $a1	
	
	#prepare stack pointer for the function calling
	addi $sp $sp -4
	sw $ra 0($sp)
	
	jal sum #this will jump pc to sum and save next instruction adress at $ra

	add $s0 $0 $v0 #write returned value to the $s0 register

	#this instructions will run at the end of the function
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra

sum:
	add $v0 $a0 $a1 #v0 = a0 + a1
	jr $ra
	
	
