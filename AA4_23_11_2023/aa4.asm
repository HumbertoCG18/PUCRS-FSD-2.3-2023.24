.data
A: .word 10, 20, -5, 30
B: .word 2, 3, 4, -8
C: .space 16 # Vetor C terá o mesmo tamanho que A e B (4 inteiros)
D: .space 16 # Vetor D terá o mesmo tamanho que A e B (4 inteiros)
MS: .word 0   # Variável para armazenar o resultado da multiplicação

.text
.globl main

main:
    # Inicialização dos vetores A e B
    la $t0, A
    la $t1, B
    la $t2, C
    la $t3, D

    # Carregamento dos valores de A e B para os vetores correspondentes na memória
    li $t4, 0 # Inicializa o contador
    load_loop:
        lw $t5, 0($t0) # Carrega o valor de A[i]
        sw $t5, 0($t2) # Armazena o valor de A[i] em C[i]

        lw $t5, 0($t1) # Carrega o valor de B[i]
        sw $t5, 0($t3) # Armazena o valor de B[i] em D[i]

        addi $t0, $t0, 4 # Incrementa o ponteiro de A
        addi $t1, $t1, 4 # Incrementa o ponteiro de B
        addi $t2, $t2, 4 # Incrementa o ponteiro de C
        addi $t3, $t3, 4 # Incrementa o ponteiro de D

        addi $t4, $t4, 1 # Incrementa o contador
        blt $t4, 4, load_loop # Condição de parada do loop (4 elementos)

    # Chamada da sub-rotina para multiplicação da soma dos valores positivos
    la $a0, C
    la $a1, D
    jal multiply_positive

    # Salva o resultado da multiplicação na variável MS
    sw $v0, MS

    # Fim do programa
    li $v0, 10        # Código de saída do programa
    syscall

# Sub-rotina para multiplicação da soma dos valores positivos
multiply_positive:
    li $t0, 0         # Inicializa o contador do loop
    li $t4, 0         # Inicializa a variável para a soma de C
    li $t5, 0         # Inicializa a variável para a soma de D

    mul_loop_C:
        lw $t1, 0($a0) # Carrega o valor de C[i]
        bgez $t1, add_C # Se o valor for >= 0, soma ao acumulador
        j next_C        # Senão, passa para o próximo elemento de C

    add_C:
        add $t4, $t4, $t1 # Soma ao acumulador de C

    next_C:
        addi $a0, $a0, 4 # Incrementa o ponteiro de C
        addi $t0, $t0, 1 # Incrementa o contador
        blt $t0, 4, mul_loop_C # Condição de parada do loop (4 elementos)

    li $t0, 0         # Reinicia o contador do loop

    mul_loop_D:
        lw $t2, 0($a1) # Carrega o valor de D[i]
        bgez $t2, add_D # Se o valor for >= 0, soma ao acumulador
        j next_D        # Senão, passa para o próximo elemento de D

    add_D:
        add $t5, $t5, $t2 # Soma ao acumulador de D

    next_D:
        addi $a1, $a1, 4 # Incrementa o ponteiro de D
        addi $t0, $t0, 1 # Incrementa o contador
        blt $t0, 4, mul_loop_D # Condição de parada do loop (4 elementos)

    mul_result:
        mul $t6, $t4, $t5 # Multiplica as somas obtidas de C e D
        move $v0, $t6     # Retorna o resultado na $v0
    jr $ra
