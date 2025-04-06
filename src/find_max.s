.data

array: .word 1 256 3 10 2 7 100

.text
.globl main

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $s0, array #s0 = base adress of array
	addi $s1, $0, 7 #s1 = size of array
	addi $t0, $0, 0 #t0 = i
	li $s2, 0x0 #s2 = max_value = 0x0 initially
	jal find_max
	lw $ra 0($sp)
	jr $ra

find_max: 
	beq $t0, $s1, done #size==i go to done
	sll $t1, $t0, 2 #t1 = i*4 = offset
	add $t1, $t1, $s0 #t1 = base adress + offset &array[i]
	lw $t1, 0($t1) #t1 = array[i]
	slt $t2, $t1, $s2 # t1<s2 ? 1 : 0
	beq $t2, $0, found_new_max #if array[i] is bigger go found_new_max
	addi $t0, $t0, 1 # i+=1
	j find_max

found_new_max:
	add $s2, $0, $t1 #max_value = array[i]
	addi $t0, $t0, 1 #i+=1
	j find_max

done: 
	add $v0, $0, $s2 #return max
	jr $ra
	
