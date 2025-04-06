.data

.text
.globl main

main:
	addi $sp, $sp, -4

	sw $ra, 0($sp)

	addi $a0, $0, 5

	jal factorial

	add $s4, $0, $v0

	lw $ra, 0($sp)

	jr $ra

factorial: 
	   addi $sp, $sp, -8  # make room

           sw   $a0, 4($sp)   # store $a0

           sw   $ra, 0($sp)   # store $ra

           addi $t0, $0, 2    

           slt  $t0, $a0, $t0 # a <= 1 ?

           beq  $t0, $0, else # no: go to else  

           addi $v0, $0, 1    # yes: return 1

           addi $sp, $sp, 8   # restore $sp

           jr   $ra           # return
else:      
	   addi $a0, $a0, -1  # n = n - 1

           jal  factorial     # recursive call this jal command will change $ra with nextline: lw $ra 0($sp) so this function will resume here after nested calls.

           lw   $ra, 0($sp)   # restore $ra

           lw   $a0, 4($sp)   # restore $a0

           addi $sp, $sp, 8   # restore $sp

           mul  $v0, $a0, $v0 # n * factorial(n-1)

           jr   $ra           # return
	
