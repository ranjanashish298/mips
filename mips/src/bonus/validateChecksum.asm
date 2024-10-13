	.data
	.globl validate_checksum
	.text


# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	# TODO
	addi $sp, $sp, -8      # allocate space on the stack
    sw $ra, 4($sp)         # save the return address

    move $t0, $a0          # copy the pointer to $t0
    li $t1, 0              # initialize the checksum to 0
    li $t2, 10             # initialize the divisor to 10

loop:
    lbu $t3, ($t0)         # load the next character into $t3
    addi $t0, $t0, 1       # increment the pointer

    beqz $t3, endloop      # exit the loop if the character is null

    blt $t3, '0', invalid  # invalid character
    bgt $t3, '9', invalid  # invalid character

    sub $t3, $t3, '0'      # convert the character to a number
    mul $t3, $t3, $t2      # multiply the number by the divisor
    addu $t1, $t1, $t3     # add the product to the checksum

    bne $t2, 1, decrdiv    # decrement the divisor if it's not 1
    nop

    li $t2, 10             # reset the divisor to 10
    b loop                 # continue the loop

decrdiv:
    addi $t2, $t2, -1      # decrement the divisor
    b loop                 # continue the loop

invalid:
    li $v0, 1              # set the return value to 1
    j end                  # exit the subroutine

endloop:
    rem $t1, $t1, 97       # take the checksum modulo 97
    beqz $t1, valid        # valid if the remainder is 0

    li $v0, 1              # set the return value to 1
    j end                  # exit the subroutine

valid:
    li $v0, 0              # set the return value to 0

end:
    lw $ra, 4($sp)         # restore the return address
    addi $sp, $sp, 8       # deallocate space on the stack

	jr	$ra
