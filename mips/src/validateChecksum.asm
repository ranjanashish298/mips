	.data
 		buffer_24 : .space 24
 		
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	# TODO
	
    la $t0, buffer_24   # Load address of new buffer into $t0

    # Copy first two characters to end of new buffer
    lb $t1, ($a0)       # Load first character of IBAN
    subiu $t1, $t1, 55    # Convert letter character to integer value (A=10, B=11, ...)
    divu $t2 $t1 10
    remu $t3, $t1 10
    sb  $t2, 18($t0)
    sb  $t3, 19($t0)
    
    lb $t1, 1($a0)      # Load second character of IBAN
    subiu $t1, $t1, 55    # Convert letter character to integer value (A=10, B=11, ...)
    divu $t2 $t1 10
    remu $t3, $t1 10
    sb  $t2, 20($t0)
    sb  $t3, 21($t0)
   
    
    lb $t1, 2($a0)      # Load third character of IBAN
    subiu $t1, $t1, 48    # Convert letter character to integer value (A=10, B=11, ...)
    sb  $t1, 22($t0)
    
     
    lb $t1, 3($a0)      # Load fourth character of IBAN
    subiu $t1, $t1, 48
    sb  $t1, 23($t0)
    

    
    li $t9, 0 		#counter for loop-execution
loop:
    lb $t4, 4($a0)
    subiu $t4, $t4, 48 # Convert ASCII digit to integer value
    sb $t4, ($t0)
    addiu $a0, $a0, 1 # Move to next byte in IBAN string
    addiu $t0, $t0, 1 # Move to next byte in buffer
    addiu $t9, $t9, 1 # Increment digit counter
    bne $t9, 18, loop # Repeat until all 18 digits have been processed
	
	
    addiu $t0 $t0 -18  #Rearraniging pointer again to the start of $t0
    
   #now modulo_str again

	li $t5, 0
    	li $a2, 97	#mod 97 value
    	li $a1, 24	#final byte length
loop1:
    lbu $t6, ($t0)
    subiu $t4, $t6, 48
    mulu $t5, $t5, 10    # Multiply previous result by 10
    addu $t5, $t5, $t6  # Add next digit
    remu $t5, $t5, $a2  # Compute modulus
    addiu $t0, $t0, 1   # Move to next byte in buffer
    addiu $a1, $a1, -1  # Decrease digit count
    mfhi $t5
    bge $a1, 1, loop1     # Repeat until all 24 digits have been processed
	
	
    move $v0, $t5 	#return mod 97 value in $v0
	
	jr	$ra
