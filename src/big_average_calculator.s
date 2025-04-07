.data

array: .word 5 2 11 100 23 40 50 3 9


.text
.globl main

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $s0, array #s0 = base adress
	addi $s1, $0, 9 #s1 = size
	addi $a0, $0, 5 #a0 = K
	addi $s2, $0, 1 #s2 = 1	
	jal big_average
	add $s3, $0, $v0
	lw $ra, 0($sp)
	jr $ra
	


big_average:
	addi $t0, $0, 0 #t0 = i = 0
	addi $t1, $0, 0 #t1 = counter = 0 it counts bigger elements
	addi $t2, $0, 0 #t2 = sum
	
loop:
	beq $t0, $s1, done
	sll $t3, $t0, 2 #t3 = i*4 = offset
	add $t3, $s0, $t3 #t3 = base adress + offset = &array[i] 
	lw $t3, 0($t3) # t3 = array[i]
	slt $t4, $a0, $t3
	beq $t4, $s2, found_bigger
	j skip


found_bigger: 
	add $t2, $t2, $t3 #sum += array[i]
	addi $t1, $t1, 1 #counter += 1
	addi $t0, $t0, 1 #i += 1
	j loop

skip:
	addi $t0, $t0, 1 # i += 1
	j loop


done:
	div $t2, $t1
	mflo $v0
	jr $ra
	
	
	
