	.data
	.globl main
numberstr:
	.asciiz "65539"
	#.asciiz "413746471724057190131442"
	#.asciiz "123456781234567890131400"
	#.asciiz "12345"
	.text
main:
	la	$a0 numberstr
	li	$a1 5
	#li	$a1 24
	
	la	$a2 8
	#la	$a2 97
	
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall
	li	$v0 10
	syscall
