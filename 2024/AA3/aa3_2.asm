.data
A: .space 40       # Space for 10 integers (10 * 4 bytes)
B: .space 40       # Space for 10 integers (10 * 4 bytes)
C: .space 40       # Space for result vector C (10 * 4 bytes)
D: .space 40       # Space for result vector D (10 * 4 bytes)
PE: .word 0        # Storage for scalar product result

.text
.globl main

main:
    # Initialize random seed (optional, if needed)
    li $v0, 42        # syscall 42 for random integer
    syscall

    # Loop to initialize arrays A and B with 10 elements each
    li $t0, 0         # Initialize index i = 0
    li $t1, 10        # Number of elements in arrays A and B

init_loop:
    bge $t0, $t1, init_done   # Exit loop if i >= n

    # Generate random integer for A[i]
    li $v0, 42        # syscall 42 for random integer
    syscall
    move $t2, $v0     # Move random value to $t2

    # Store random value in A[i]
    sw $t2, A($t0)    # A[i] = random value

    # Generate random integer for B[i]
    li $v0, 42        # syscall 42 for random integer
    syscall
    move $t3, $v0     # Move random value to $t3

    # Store random value in B[i]
    sw $t3, B($t0)    # B[i] = random value

    addi $t0, $t0, 1  # Increment index i
    j init_loop       # Jump back to loop

init_done:
    # Call subroutines for vector addition, subtraction, and scalar product
    jal add_vectors   # Call subroutine for vector addition
    jal sub_vectors   # Call subroutine for vector subtraction
    jal scalar_product  # Call subroutine for scalar product (Specification 1)

    # Exit program
    li $v0, 10        # syscall 10 to exit program
    syscall

# Subroutine to add vectors A and B
add_vectors:
    li $t0, 0         # Initialize index i = 0

add_loop:
    bge $t0, $t1, add_done   # Exit loop if i >= n

    lw $t2, A($t0)    # Load A[i] into $t2
    lw $t3, B($t0)    # Load B[i] into $t3
    add $t4, $t2, $t3  # C[i] = A[i] + B[i]
    sw $t4, C($t0)    # Store result in C[i]

    addi $t0, $t0, 1  # Increment index i
    j add_loop        # Jump back to loop

add_done:
    jr $ra            # Return from subroutine

# Subroutine to subtract vectors A and B
sub_vectors:
    li $t0, 0         # Initialize index i = 0

sub_loop:
    bge $t0, $t1, sub_done   # Exit loop if i >= n

    lw $t2, A($t0)    # Load A[i] into $t2
    lw $t3, B($t0)    # Load B[i] into $t3
    sub $t4, $t2, $t3  # D[i] = A[i] - B[i]
    sw $t4, D($t0)    # Store result in D[i]

    addi $t0, $t0, 1  # Increment index i
    j sub_loop        # Jump back to loop

sub_done:
    jr $ra            # Return from subroutine

# Subroutine to compute scalar product of vectors C and D (Specification 1)
scalar_product:
    li $t0, 0         # Initialize index i = 0
    li $t5, 0         # Initialize product accumulator

scalar_loop:
    bge $t0, $t1, scalar_done   # Exit loop if i >= n

    lw $t2, C($t0)    # Load C[i] into $t2
    lw $t3, D($t0)    # Load D[i] into $t3
    mul $t4, $t2, $t3  # $t4 = C[i] * D[i]
    add $t5, $t5, $t4  # Accumulate product

    addi $t0, $t0, 1  # Increment index i
    j scalar_loop     # Jump back to loop

scalar_done:
    # Store result in PE (scalar product)
    sw $t5, PE

    jr $ra            # Return from subroutine
