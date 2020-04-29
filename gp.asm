#TODO: Whole fucking project
#TODO: Hope this is the last project in MIPS

.data
	prompt: .asciiz "Enter size: "
	messageForValid: .asciiz "Input is valid!"
	messageForInvalid: .asciiz "Input is invalid, size matters!"
.text

	# prompt user to enter size
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get actual size
	li $v0, 5
	syscall
	
	# store result in $t0
	move $t0, $v0
	
	bgt $t0, 2, InputIsValid
	# if input is less or equal to two (e.i. invalid)
	li $v0, 4
	la $a0, messageForInvalid
	syscall
	# terminate program
	li $v0, 10
	syscall
	
	InputIsValid:
	li $v0, 4
	la $a0, messageForValid
	syscall
