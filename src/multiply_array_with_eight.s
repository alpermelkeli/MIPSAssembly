.data

array: .word 5 2 11 100 23 40 50 3 9


.text
.globl main

main:
	addi $sp $sp -4     
	sw $ra 0($sp)
	
	addi $s0 $0 9 #s0 = size
	la $s1 array #s1 = base_adress
	addi $t0 $0 0 #t0 = index
	
	loop:
	slt $t1 $t0 $s0 #check if index less than the size
	beq $t1 $0 done
	
	sll $t2 $t0 2 #t2 = index * 4 
	add $t2 $t2 $s1 #t2 = base_adress + index * 4
	lw $t3 0($t2) #t3 = array[index]
	sll $t3 $t3 3 #t3 = array[index] * 8
	sw $t3 0($t2) #array[index] = t3 
	addi $t0 $t0 1 #index = index + 1
	j loop

	done: 

	lw $ra 0($sp)
	jr $ra
