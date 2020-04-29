#TODO: Whole fucking project
#TODO: Hope this is the last project in MIPS

.data
	prompt: .asciiz "Enter size: "
.text

	# prompt user to enter size
	li $v0, 4
	la $a0, prompt
	syscall