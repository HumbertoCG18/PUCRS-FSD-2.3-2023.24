.data
A: .word -5, 7, 8, 9, -3, 1, -6, 2
B: .word 4, 2, 9, -7, 2, -1, -6, 8
C: .word 0, 0, 0, 0, 0, 0, 0, 0
D: .word 0, 0, 0, 0, 0, 0, 0, 0
MP: .word 0
n: .word 8

.text
.globl inicio

inicio:
    lw $t0, n        # Carrega o tamanho do vetor
    
    # Carrega endereços dos vetores
    la $t1, A
    la $t2, B
    la $t3, C
    la $t4, D

    # Loop para adição e subtração de vetores A e B
    xor $t5, $t5, $t5     # Inicializa i

add_sub_loop:
    lw $t6, 0($t1)    # Carrega A[i]
    lw $t7, 0($t2)    # Carrega B[i]

    add $t8, $t6, $t7    # Adiciona A[i] + B[i]
    sub $t9, $t6, $t7    # Subtrai A[i] - B[i]

    sw $t8, 0($t3)    # Armazena resultado da adição em C[i]
    sw $t9, 0($t4)    # Armazena resultado da subtração em D[i]

    addi $t1, $t1, 4    # Avança para o próximo elemento em A
    addi $t2, $t2, 4    # Avança para o próximo elemento em B
    addi $t3, $t3, 4    # Avança para o próximo elemento em C
    addi $t4, $t4, 4    # Avança para o próximo elemento em D
    addi $t5, $t5, 1    # Incrementa contador do loop
    blt $t5, $t0, add_sub_loop    # Se o i < n, retorna para "add_sub_loop"
    
    # Loop para calcular a soma dos valores positivos de C
    li $t5, 0            # Reinicializa i
    li $t6, 0            # Reinicializa o contador da soma de C

calc_sum_pos_loop_C:
    lw $t8, 0($t3)    # Carrega C[i]
    addi $t3, $t3, 4    # Avança para o próximo elemento em C
    addi $t5, $t5, 1    # Incrementa contador do loop
    bltz $t8, calc_sum_pos_loop_C

    add $t6, $t6, $t8    # Adiciona valores positivos de C

    blt $t5, $t0, calc_sum_pos_loop_C    # Se o i < n, retorna para o loop de C

    # Loop para calcular a soma dos valores positivos de D
    li $t5, 0            # Reinicializa i
    li $t7, 0            # Reinicializa o contador da soma de D

calc_sum_pos_loop_D:
    lw $t9, 0($t4)    # Carrega D[i]
    addi $t4, $t4, 4    # Avança para o próximo elemento em D
    addi $t5, $t5, 1    # Incrementa contador do loop
    blt $t9, $zero, calc_sum_pos_loop_D

    add $t7, $t7, $t9    # Adiciona valores positivos de D

    blt $t5, $t0, calc_sum_pos_loop_D    # Se o i < n, retorna para o loop de D

    # Cálculo da multiplicação das somas
    li $t5, 0            # Reinicializa i
    li $t9, 0            # Inicializa o acumulador da multiplicação

mult_loop:
    blt $t5, $t6, end_mult_loop    # Se i < soma de valores positivos de C, encerra o loop

    add $t9, $t9, $t7    # Adiciona os valores positivos de D para a multiplicação
    addi $t5, $t5, 1    # Incrementa contador do loop
    j mult_loop

end_mult_loop:
    # Armazena o resultado da multiplicação
    sw $t9, MP

end:
    j end
