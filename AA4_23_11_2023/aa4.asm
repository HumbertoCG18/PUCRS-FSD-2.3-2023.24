.data
A: .word -5, 7, 8, 9, -3, 1, -6, 2
B: .word 4, 2, 9, -7, 2, -1, -6, 8
C: .word 0, 0, 0, 0, 0, 0, 0, 0
D: .word 0, 0, 0, 0, 0, 0, 0, 0
MP: .word 0, 0, 0, 0, 0, 0, 0, 0
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
    la $t5, MP

    # Loop para adição, subtração e multiplicação de vetores A e B
    xor $t6, $t6, $t6     # Inicializa i

loop:
    lw $t7, 0($t1)    # Carrega A[i]
    lw $t8, 0($t2)    # Carrega B[i]

    add $t9, $t7, $t8    # Adiciona A[i] + B[i]
    sub $t10, $t7, $t8    # Subtrai A[i] - B[i]
    mul $t11, $t7, $t8    # Multiplica A[i] * B[i]

    sw $t9, 0($t3)    # Armazena resultado da adição em C[i]
    sw $t10, 0($t4)    # Armazena resultado da subtração em D[i]
    sw $t11, 0($t5)    # Armazena resultado da multiplicação em MP[i]

    addi $t1, $t1, 4    # Avança para o próximo elemento em A
    addi $t2, $t2, 4    # Avança para o próximo elemento em B
    addi $t3, $t3, 4    # Avança para o próximo elemento em C
    addi $t4, $t4, 4    # Avança para o próximo elemento em D
    addi $t5, $t5, 4    # Avança para o próximo elemento em MP
    addi $t6, $t6, 1    # Incrementa contador do loop
    blt $t6, $t0, loop    # Se o i < n, retorna para o loop

    # Loop para soma dos valores positivos em C
    la $t3, C    # Reinicia a posição do C
    xor $t6, $t6, $t6    # Reinicia o i
    xor $t7, $t7, $t7    # Reinicia o auxiliar
    xor $t8, $t8, $t8    # Reinicia o auxiliar

loop_C:
    lw $t7, 0($t3)    # Carrega C[i]
    addi $t3, $t3, 4    # Avança para o próximo elemento em C
    addi $t6, $t6, 1    # Incrementa contador do loop
    bltz $t7, loop_C    # Se o valor é negativo, volta para loop_C

    add $t8, $t8, $t7    # Adiciona X = X + C[i]

    blt $t6, $t0, loop_C    # Se o i < n, retorna para loop_C

    # Loop para soma dos valores positivos em D
    la $t4, D    # Reinicia a posição do D
    xor $t6, $t6, $t6    # Reinicia o i
    xor $t7, $t7, $t7    # Reinicia o auxiliar

loop_D:
    lw $t7, 0($t4)    # Carrega D[i]
    addi $t4, $t4, 4    # Avança para o próximo elemento em D
    addi $t6, $t6, 1    # Incrementa contador do loop
    blt $t7, $zero, loop_D    # Se o valor é negativo, volta para loop_D

    add $t8, $t8, $t7    # Adiciona X = X + D[i]

    blt $t6, $t0, loop_D    # Se o i < n, retorna para loop_D

end:
    j end
