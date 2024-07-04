.data
PE: .word 0
n: .word 8
A: .word 1, 2, 3, 4, 5, 6, 7, -8
B: .word -8, 7, -6, 5, 4, -3, 2, -1
C: .space 32  # 8 words * 4 bytes per word
D: .space 32  # 8 words * 4 bytes per word

.text
.globl main

main:
    # Initialize PE to 0
    la $t0, PE        # Load address of PE into $t0
    li $t1, 0         # Load immediate 0 into $t1
    sw $t1, 0($t0)    # Store 0 into PE

    # Load the number of elements (n)
    la $t1, n         # Load address of n into $t1
    lw $t1, 0($t1)    # Load value of n into $t1

    # Load base addresses of arrays A and B
    la $t2, A         # Load address of A into $t2
    la $t3, B         # Load address of B into $t3

    # Initialize loop counter i to 0
    li $t4, 0         # Load immediate 0 into $t4 (i = 0)

loop_main:
    beq $t4, $t1, end # if i == n, exit loop

    # Load elements A[i] and B[i]
    lw $t5, 0($t2)    # Load A[i] into $t5
    lw $t6, 0($t3)    # Load B[i] into $t6

    # Multiply A[i] and B[i] and accumulate in PE
    mul $t7, $t5, $t6 # t7 = A[i] * B[i]
    la $t0, PE        # Load address of PE into $t0
    lw $t8, 0($t0)    # Load current PE into $t8
    add $t8, $t8, $t7 # PE = PE + (A[i] * B[i])
    sw $t8, 0($t0)    # Store updated PE back into memory

    # Increment array pointers and loop counter
    addi $t2, $t2, 4  # Move to the next element in A
    addi $t3, $t3, 4  # Move to the next element in B
    addi $t4, $t4, 1  # i++

    j loop_main       # Jump back to the beginning of the loop

end:
    # End of program
    j end             # Infinite loop to end the program
