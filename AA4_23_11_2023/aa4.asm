.data
    N:      .word 8         # Tamanho do vetor
    A:      .word 10, 20, -5, 30, 0, 0, 0, 0     # Vetor A
    B:      .word 2, 3, 4, -8, 0, 0, 0, 0        # Vetor B
    C:      .word 0, 0, 0, 0, 0, 0, 0, 0         # Vetor C
    D:      .word 0, 0, 0, 0, 0, 0, 0, 0         # Vetor D
    MP:     .word 0         # Variável para armazenar o resultado da multiplicação das somas dos valores positivos

.text
.globl _start

_start:
    # Carrega o tamanho do vetor
    lw $t0, N
    
    # Carrega endereços dos vetores
    la $t1, A
    la $t2, B
    la $t3, C
    la $t4, D
    
    # Loop para adição e subtração de vetores A e B
    li $t5, 0     # Inicializa contador do loop
    
add_sub_loop:
    bge $t5, $t0, calc_sum_pos   # Se o contador >= tamanho do vetor, vai para cálculo da soma dos valores positivos
    
    lw $t6, ($t1)   # Carrega A[i]
    lw $t7, ($t2)   # Carrega B[i]
    
    add $t8, $t6, $t7   # Adiciona A[i] + B[i]
    sub $t9, $t6, $t7   # Subtrai A[i] - B[i]
    
    sw $t8, ($t3)   # Armazena resultado da adição em C[i]
    sw $t9, ($t4)   # Armazena resultado da subtração em D[i]
    
    addi $t1, $t1, 4   # Avança para o próximo elemento em A
    addi $t2, $t2, 4   # Avança para o próximo elemento em B
    addi $t3, $t3, 4   # Avança para o próximo elemento em C
    addi $t4, $t4, 4   # Avança para o próximo elemento em D
    addi $t5, $t5, 1   # Incrementa contador do loop
    
    j add_sub_loop   # Loop novamente
    
calc_sum_pos:
    # Loop para calcular a soma dos valores positivos de C e D
    li $t5, 0     # Reinicia contador do loop
    li $t6, 0     # Inicializa soma dos valores positivos de C
    li $t7, 0     # Inicializa soma dos valores positivos de D
    
calc_sum_loop:
    bge $t5, $t0, end_program   # Se o contador >= tamanho do vetor, encerra o programa
    
    lw $t8, ($t3)    # Carrega C[i]
    lw $t9, ($t4)    # Carrega D[i]
    
    bgez $t8, add_c   # Se C[i] >= 0, vai para soma dos valores positivos de C
    j check_d         # Senão, verifica D[i]
    
add_c:
    add $t6, $t6, $t8   # Soma de valores positivos de C
    j check_d           # Verifica D[i]
    
check_d:
    bgez $t9, add_d     # Se D[i] >= 0, vai para soma dos valores positivos de D
    increment           # Senão, incrementa contador e continua o loop
    
add_d:
    add $t7, $t7, $t9   # Soma de valores positivos de D
    
increment:
    addi $t5, $t5, 1   # Incrementa contador do loop
    addi $t3, $t3, 4   # Avança para o próximo elemento em C
    addi $t4, $t4, 4   # Avança para o próximo elemento em D
    j calc_sum_loop     # Loop novamente
    
end_program:
    # Calcula a multiplicação das somas dos valores positivos de C e D
    mul $t8, $t6, $t7
    
    # Armazena o resultado da multiplicação
    sw $t8, MP
    
    # Termina o programa
    li $v0, 10
    syscall
