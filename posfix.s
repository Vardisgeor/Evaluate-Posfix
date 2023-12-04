

    .data

ch:                 .space 20

input:              .asciiz "Postfix (input): "
totalmsg:           .asciiz "\nPostfix Evaluation: "
errorempty:         .asciiz "Invalid Postfix"
errordivi:          .asciiz "Divide by zero."


    .text
    .globl main

main:

    li $t5, 0       # i = 0
    li $s1, 0       # result = 0 

    la $a0, input   # emfanizei minima
    li $v0, 4
    syscall 

    la $a0, ch      # Diabazei input
    li $a1, 20      # To bazei sto ch
    li $v0, 8
    syscall
    
    la $t2, ch      # bazei input sto $t3
    lb $t3, ($t2)

    j loop

keno:

    add $t2, $t2, 1 # address of next char
    lb $t3, ($t2)

loop:
    
    beq $t3, ' ', keno
    beq $t3, '=', else

    li $t4, 0        # number = 0

while:

    blt $t3, '0', continue
    bgt $t3, '9', continue

    mul $t4, $t4, 10
    add $t4,$t4, $t3
    sub $t4, $t4, 48

    add $t2, $t2, 1     # address of next char
    lb $t3, ($t2)

    j while

continue:

    beq $t3, '+', continue2
    beq $t3, '-', continue2
    beq $t3, '*', continue2
    beq $t3, '/', continue2 

    move $a1,$t4    
    jal push

    add $t2, $t2, 1
    lb $t3, ($t2)
    j loop

continue2:
   
    jal pop
    move $a2, $a0      #x1

    jal pop
    move $a3, $a0      #x2

    jal calc           #result
    move $s1, $v0

    move $a1,$s1
    jal push

    j keno

else:

    bne $t5, 1, exit
 
    la $a0, totalmsg
    li $v0, 4
    syscall

    lw $a0, ($sp)       #print result of posfix
    li $v0, 1
    syscall

    li $v0, 10
    syscall

pop:

    beq $t5, 0, exit    #if i == 0 go to exit
    
    lw $a0, ($sp)    
    add $sp, $sp, 4     #move item from stack
    
    sub $t5, $t5, 1

    jr $ra

push:

    sub $sp, $sp, 4     #add item in stack
    sw $a1, ($sp)    

    add $t5, $t5, 1     #i++ (stack pointer)

    jr $ra

calc:

    li $v0, 0

    beq $t3, '+', addition
    beq $t3, '-', subtract
    beq $t3, '*', multiply
    beq $t3, '/', division

    jr $ra 

addition:

    add $v0, $a2, $a3   #add

    jr $ra 

subtract:
    
    sub $v0, $a3, $a2   #sub
    

    jr $ra 

multiply:
    
    mul $v0, $a2, $a3   #mul
    

    jr $ra

division:

    beq $a2, 0, exitdiv #divided by zero

    div $v0, $a3, $a2   #div

    jr $ra  

exit:

    la $a0, errorempty
    li $v0, 4
    syscall

    li $v0,10
    syscall

exitdiv:

    la $a0, errordivi
    li $v0, 4
    syscall

    li $v0,10
    syscall

	
	
	
	
