	.data  
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	#move $t0, $a0
	


    li $t1, 'D'
    sb $t1, ($a0)

    li $t1, 'E'
    sb $t1, 1($a0)

    li $t1, '0'
    sb $t1, 2($a0)

    li $t1, '0'
    sb $t1, 3($a0)

    
    
	li $t1, 0                 
        li $t4, 0
    
 
loop1:
    lb $t3, ($a1)       # load  byte from the blz buffer
    sb $t3, 4($a0)        # store the byte in the  buffer
    addiu $a0, $a0, 1    # increment to the next byte in the  buffer
    addiu $a1, $a1, 1    # increment to the next byte in the BLZ buffer
    addiu $t1, $t1, 1    # increment the counter
    bne $t1, 8, loop1    # repeat until 8 bytes have been read
    
    
    
loop2:  #similar steps like loop 1, we extract from the 12th byte of IBAN till end
        lb $t2, ($a2)
	sb $t2, 4($a0)
	addiu $a0, $a0, 1
	addiu $a2, $a2, 1
	addiu $t4, $t4, 1
	bne $t4, 10, loop2
	
	#********************TILL HERE I GOT THE $A0 BUFFER*************************
	
        addiu $sp $sp -8 
        sw $a0 4($sp)   # decrease $sp, allocate frame
	sw    $ra 0($sp)	
	
	
	jal validate_checksum
	lw   $a0  4($sp)
	lw    $ra 0($sp)
	addiu $sp $sp 8	
	
	li $t7 98
	subu $t6 $t7 $v0  	#$s6= (check digits) has the value in integer that needs to be stored to $a0
	
	#Now I want to check if the digits are 
	
	divu $t3 $t6 10
	addi $t3 $t3 48
	remu $t4 $t6 10
	addi $t4 $t4 48
	
	
			
	sb $t3 2($a0)
	sb $t4 3($a0)
	jr	$ra
