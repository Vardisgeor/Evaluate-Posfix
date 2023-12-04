# Evaluate-Posfix
Using Assembly MIPS-32 evaluate the posfix value.

The provided MIPS assembly code functions as a postfix expression evaluator. The program prompts the user to 
input a postfix expression, which is then read into the array. Subsequently, the code enters a loop to 
traverse each character of the postfix expression. Within this loop, spaces are ignored, and the code 
distinguishes between numeric operands and arithmetic operators. Numeric operands are converted 
to integers, and arithmetic operations (+, -, *, /) are performed using a stack-based approach. 
The stack is manipulated through push and pop operations, and the result of each operation is 
stored. Special attention is given to handling division by zero errors. Finally, the 
evaluated result is displayed to the user. The code is structured to efficiently process the postfix 
expression and provide an accurate result while addressing potential errors in the input.
