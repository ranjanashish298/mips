	.data
	.globl main
ibanstr:
	.asciiz "DE42413746471724057190"
	#.asciiz "DE00123456781234567890"
	.text
main:
	la	$a0 ibanstr
	jal	validate_checksum
	move	$a0 $v0
	li	$v0 1
	syscall
	li	$v0 10
	syscall
