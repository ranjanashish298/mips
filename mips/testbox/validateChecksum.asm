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
    subu $t1, $t1, 55    # Convert letter character to integer value (A=10, B=11, ...)
    divu $s1 $t1 10
    remu $s2, $t1 10
    sb  $s1, 18($t0)
    sb  $s2, 19($t0)
    
    lb $t2, 1($a0)      # Load second character of IBAN
    subu $t2, $t2, 55    # Convert letter character to integer value (A=10, B=11, ...)
    divu $s1 $t2 10
    remu $s2, $t2 10
    sb  $s1, 20($t0)
    sb  $s2, 21($t0)
   
    
    lb $t3, 2($a0)      # Load third character of IBAN
    subu $t3, $t3, 48    # Convert letter character to integer value (A=10, B=11, ...)
    divu $s1 $t3 10
    remu $s2, $t3 10
    sb  $s1, 20($t0)
    sb  $s2, 21($t0)
    
    lb $t4, 3($a0)      # Load fourth character of IBAN
    subu $t4, $t4, 48    # Convert letter character to integer value (A=10, B=11, ...)
    divu $s1 $t4 10
    remu $s2, $t4 10
    sb  $s1, 20($t0)
    sb  $s2, 21($t0)
    
    li $t9, 0 		#counter for loop-execution
loop:
    lb $t4, 4($a0)
    subu $t4, $t4, 48 # Convert ASCII digit to integer value
    sb $t4, ($t0)
    addiu $a0, $a0, 1 # Move to next byte in IBAN string
    addiu $t0, $t0, 1 # Move to next byte in buffer
    addiu $t9, $t9, 1 # Increment digit counter
    bne $t9, 18, loop # Repeat until all 18 digits have been processed
	
	

#now modulo_str again

	li $s5, 0
    	li $a2, 97	#mod 97 value
    	li $a1, 24	#final byte length
loop1:
    lb $s0, ($t0)
    mulu $s5, $s5, 10    # Multiply previous result by 10
    addu $s5, $s5, $s0  # Add next digit
    remu $s5, $s5, $a2  # Compute modulus
    addiu $t0, $t0, 1   # Move to next byte in buffer
    addiu $a1, $a1, -1  # Decrease digit count
    bnez $a1, loop1     # Repeat until all 24 digits have been processed
	
	
    move $v0, $s5 	#return mod 97 value in $9
	
	jr	$ra
