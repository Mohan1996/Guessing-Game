#Mohan Aravind
#HW 1- Guessing Game

.data

welcome:       .asciiz "Hello User, welcome to the Guessing Game!\n"
guess:         .asciiz "Guess a number: "
guess_higher:  .asciiz "Try a higher guess!\n"
guess_lower:   .asciiz "Try a lower guess!\n"
ten_guesses:   .asciiz "You guessed 10 times and failed!"
success :      .asciiz "Congrats, you won the game!\n"
bye:           .asciiz "Thanks for playing the Guessing game!\n"

secret_number:      .word 11  #Secret number that the user will try to guess
user_guess:         .word 1   #Stores user guesses
max:                .word 10  #Max number of guesses the program allows
   


.text
main:                  


#save user_guess into a register
lw $t0, secret_number($0)        #Stores secret number into $t2
lw $t2, max($0)                  #Stores max number of guesses into $t2


#code for welcome message

li $v0, 4                        
la $a0, welcome                 #Prints a welcome message to user
syscall

BEGIN:

#Code to check number of guesses
beq $t1, $t2, MAX_GUESS         #Checks if the counter($t1) is equal to the the max number of guesses(10)
addi $t1, $t1, 1                #Adds 1 to the counter($t1) so that it keeps count of the number of guesses


#code for asking user to guess

li $v0, 4                       
la $a0, guess                  #Prints the prompt that asks user to guess a number
syscall

#saving user guess

li $v0, 5                      
syscall
add $s0, $0, $v0               #Saves user input guesses into $s0

#Compare user input with secret number
beq $s0, $t0, WIN              #Compares user input with $t0. If both are the same, program spiks to WIN function
blt $s0, $t0, LOW              #If user input is high, program skips to LOW to prompt them to guess a lower value
 
j HIGH                         #Skips to HIGH function

HIGH:

la $a0, guess_lower            #Prints a message to prompt user to guess lower value   
li $v0, 4
syscall

j BEGIN                        #Skips to BEGIN function to start loop over

LOW:

la $a0, guess_higher           #Prints a message to prompt user to guess a higher value
li $v0, 4
syscall

j BEGIN                        #Skips to BEGIN function to start loop over

MAX_GUESS:
#Function when 10 guesses are all used up by user
la $a0, ten_guesses;           #Prints a message for when ten guesses has been reached          
li $v0, 4
syscall
j EXIT                          #Skips to EXIT function to end program

WIN:
la $a0, success                 #Prints a message to the user saying that the User guessed the right number
li $v0, 4
syscall

EXIT:
la $a0, bye                     #Shuts down the program
li $v0, 10
syscall



 



	
