	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	# TODO
	
        	    	 #my implementation start for the horner's logic
        li $t5 0 
        
loop:   
    	lbu $t0, ($a0)        #load the first byte from the buffer
   	subiu $t4, $t0, 48    #convert from ASCII to int
   	
   	mulu $t5, $t5, 10    	#multiplying the number by 10	
   	addu $t5, $t5 $t4	#horner logic
   	remu $t5 $t5 $a2	#horner logic 
   	
    	
    	addiu $a0, $a0, 1	#moving to next byte in the buffer
    	addiu $a1, $a1, -1 	#decreasing byte length/characters by 1
    	mfhi $t5
    	bge $a1  1 loop

	move $v0 $t5
    	
    	
    	jr $ra

    	
    	
