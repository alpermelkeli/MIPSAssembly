.data

array: .word 1 2 3 4 5
	
	.text
	.globl main


main: addi $sp, $sp, -4 #sp = sp - 4  
      sw $ra, 0($sp) 	#store the return adress at stack
      la $a0, array 	#a0 = base adress
      jal average
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      add $s3, $0, $v0
      jr $ra



average: addi $t0, $0, 0 	#t0 = 0 = i
	 addi $s0, $0, 5 	#s0 = 5 = size
	 addi $s1, $0, 0 	#s1 = 0 = sum

loop:	 beq $t0, $s0, done 	# if size == 1 done
	 sll $t1, $t0, 2 	#t1 = i*4
	 add $t1, $t1, $a0 	#t1 = offset + base adress
	 lw $t1, 0($t1) 	#t1 = array[i]
	 add $s1, $s1, $t1 	#sum += array[i]
	 addi $t0, $t0, 1 	# i+=1
	 j loop

done:    div $s1, $s0 	# sum / size  
	 mflo $v0
	 jr $ra
