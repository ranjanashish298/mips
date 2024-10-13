	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	# TODO
		
    #counter for 2 loops to repeat 8 and 10 times respectively		
    li $t0, 0                 
    li $t4, 0
    
 
loop1:
    lb $t1, 4($a0)       # load the 4th byte from the IBAN buffer
    sb $t1, ($a1)        # store the byte in the BLZ buffer
    addiu $a0, $a0, 1    # increment to the next byte in the IBAN buffer
    addiu $a1, $a1, 1    # increment to the next byte in the BLZ buffer
    addiu $t0, $t0, 1    # increment the counter
    bne $t0, 8, loop1    # repeat until 8 bytes have been read
    
loop2:  #similar steps like loop 1, we extract from the 12th byte of IBAN till end
        lb $t2, 4($a0)
	sb $t2, ($a2)
	addiu $a0, $a0, 1
	addiu $a2, $a2, 1
	addiu $t4, $t4, 1
	bne $t4, 10, loop2


 jr $ra                



 







    

