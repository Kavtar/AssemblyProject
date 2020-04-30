#TODO: Whole fucking project
#TODO: Hope this is the last project in MIPS

.data
	prompt: .asciiz "Enter size: "
	messageForValid: .asciiz "Input is valid!\n"
	messageForInvalid: .asciiz "Input is invalid, size matters!"
	comma: .asciiz ","
	space:.asciiz  " "          # space to insert between numbers
	head: .asciiz  "The Fibonacci numbers are:\n"
	fibs: .word   0 : 50         # "array" of words to contain fib values
	fileName: .asciiz "D:\logs.txt"
	startMessageLogging: .asciiz "Execution started:\n"
	promptMessageLogging: .asciiz "Prompting user for input...\n"
	validInputMessageLogging: .asciiz ">Input is valid. Processing..\n"
	invalidInputMessageLogging: .asciiz ">Input isn't greater than 2. Terminating...\n"
.text
	# open file
	li $v0, 13 			# open file with syscall code 13
	la $a0, fileName		# get the file name
	li $a1, 1			# set file flag to write (1)
	syscall
	move $s1, $v0			# save the file descriptor $s0 = file
	
	# write into file
	li $v0, 15			# write file syscall code = 15
	move $a0, $s1			# file descriptor
	la $a1, startMessageLogging	# string which will be written
	la $a2, 20			# specify string length
	syscall
	
	
	#-----------------------------------------------------------------#
	
	# write into file
	li $v0, 15			# write file syscall code = 15
	move $a0, $s1			# file descriptor
	la $a1, promptMessageLogging	# string which will be written
	la $a2, 29			# specify string length
	syscall
	
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
	
	# write into file
	li $v0, 15				# write file syscall code = 15
	move $a0, $s1				# file descriptor
	la $a1, invalidInputMessageLogging	# string which will be written
	la $a2, 44				# specify string length
	syscall
	
	#---------------------------------------------#
	
	# close file
	li $v0, 16		# close file, syscall code = 16
	move $a0, $s1		# file descriptor
	syscall
	
	#---------------------------------------------#
	# terminate program
	li $v0, 10
	syscall
	
	InputIsValid:
	# write into file
	li $v0, 15				# write file syscall code = 15
	move $a0, $s1				# file descriptor
	la $a1, validInputMessageLogging	# string which will be written
	la $a2, 32				# specify string length
	syscall
	
	li $v0, 4
	la $a0, messageForValid
	syscall
	
	
	la   $s0, fibs        # load address of array
    
	
	li   $s2, 1           # 1 is the known value of first and second Fib. number
      	sw   $s2, 0($s0)      # F[0] = 1
      	sw   $s2, 4($s0)      # F[1] = F[0] = 1
      	addi $s1, $t0, -2     # Counter for loop, will execute (size-2) times
      
      	# Loop to compute each Fibonacci number using the previous two Fib. numbers.
loop: 	lw   $s3, 0($s0)      # Get value from array F[n-2]
      	lw   $s4, 4($s0)      # Get value from array F[n-1]
      	add  $s2, $s3, $s4    # F[n] = F[n-1] + F[n-2]
      	sw   $s2, 8($s0)      # Store newly computed F[n] in array
      	addi $s0, $s0, 4      # increment address to now-known Fib. number storage
      	addi $s1, $s1, -1     # decrement loop counter
      	bgtz $s1, loop        # repeat while not finished
      
      	# Fibonacci numbers are computed and stored in array. Print them.
      	la   $a0, fibs        # first argument for print (array)
      	add  $a1, $zero, $t0  # second argument for print (size)
      	jal  PrintArray            # call print routine. 


	#---------------------------------------------#
	
	# close file
	li $v0, 16		# close file, syscall code = 16
	move $a0, $s1		# file descriptor
	syscall
	
	#---------------------------------------------#
	
	
      	# The program is finished. Exit.
      	li   $v0, 10          # system call for exit
      	syscall               # Exit!
		
###############################################################
	# Subroutine to print the numbers on one line.
PrintArray: 	add  $t0, $zero, $a0  # starting address of array of data to be printed
      		add  $t1, $zero, $a1  # initialize loop counter to array size
      		la   $a0, head        # load address of the print heading string
      		li   $v0, 4           # specify Print String service
      		syscall               # print the heading string
      
out:  		lw   $a0, 0($t0)      # load the integer to be printed (the current Fib. number)
      		li   $v0, 1           # specify Print Integer service
      		syscall               # print fibonacci number
      
      		la   $a0, space       # load address of spacer for syscall
      		li   $v0, 4           # specify Print String service
      		syscall               # print the spacer string
      
      		addi $t0, $t0, 4      # increment address of data to be printed
      		addi $t1, $t1, -1     # decrement loop counter
      		bgtz $t1, out         # repeat while not finished
      
      		jr   $ra              # return from subroutine
# End of subroutine to print the numbers on one line
###############################################################
			
		    	
		    	
			
			 	
			 	  
