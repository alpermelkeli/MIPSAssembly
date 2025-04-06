.data


.text
.globl main


main: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lui $a0, 0xFFFF #load upper bit of the number 
	ori $a0, $a0, 0xFFF0 #load lower bit of the number

	addi $s0, $0, 32 #total shift count is 32
	addi $t0, $0, 0 #count of shifting	
	addi $t1, $0, 0 #count of zero bit
	
	jal find_zero_bit_count
	
	add $s3, $0, $v0 #get returned value and save to s3 register	

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

find_zero_bit_count: 
	beq $t0, $s0, done
	
	andi $t2, $a0, 0x1 #t2 = last bit of the number
        beq $t2, $0, is_zero
	
	j is_not_zero 

is_zero:
        srl $a0, $a0, 1 #shift number to 1 bit right
	addi $t1, $t1, 1 #zero_count+=1
	addi $t0, $t0, 1 #shift_count+=1
	j find_zero_bit_count

is_not_zero:
        srl $a0, $a0, 1 #shift number to 1 bit right
	addi $t0, $t0, 1 #shift_count+=1
	j find_zero_bit_count

done:
	add $v0, $0, $t1 # return count of zero bit
	jr $ra
		
