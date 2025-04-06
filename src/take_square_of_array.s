.data

array: .word 1 2 3 4 5 6

.text
.globl main


main: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, array #a0 = base adress of array
	addi $s0, $0, 6 #s0 = size
	addi $t0, $0, 0 #t0 = i
	jal take_square

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


take_square:
	beq $t0, $s0, done
	sll $t1, $t0, 2 #t1 = offset
	add $t1, $t1, $a0 #t1 = offset + base adress = &array[i]
	lw $t2, 0($t1) #t2 = array[i]
	mult $t2, $t2 #t2 = array[i] * array[i]
	mflo $t2  #t2 
	sw $t2, 0($t1) # array[i] = t2 * t2
	addi $t0, $t0, 1 #i+=1
	j take_square
done: 
	jr $ra
	
	
