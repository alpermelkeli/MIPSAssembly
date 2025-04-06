.data


array: .word 1 2 3 4 5 6 7 #array

.text
.globl main


main: addi $sp, $sp, -4
 
      sw $ra, 0($sp)
      
      addi $a0, $0, 0 # load element to argument register       
      
      addi $s0, $0, 7 	 # s0 = size

      la $s1, array	 # s1 = base adress of array

      jal find_position

      add $s3, $0, $v0 # s3 = the index of the given element in this array; if not found -1.      

      lw $ra, 0($sp)

      addi $sp, $sp, 4

      jr $ra


find_position:
 
	addi $t0, $0, 0 #t0 = 0 -> it will be counter
               
loop:
	beq $t0, $s0, not_found
	
	sll $t1, $t0, 2 	#t1 = counter * 4 -> it will use to calculate the current address 
        
	add $t1, $s1, $t1	#t1 = counter * 4 + base adress -> &array[i]
	
	lw $t1, 0($t1)		#t1 = array[i]

	beq $t1, $a0, found
	
	addi $t0, $t0, 1

	j loop

found: 
	add $v0, $0, $t0 # return count 

	jr $ra

not_found: 
	addi $v0, $0, -1 # return -1
	
	jr $ra 
