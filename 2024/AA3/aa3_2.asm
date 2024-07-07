.data
PE: .word 0       # Address in Data Segment: 0x10010000
n: .word 8
A: .word 1, 2, 3, 4, 5, 6, 7, -8
B: .word -8, 7, -6, 5, 4, -3, 2, -1
C: .space 32  # 8 words * 4 bytes per word
D: .space 32  # 8 words * 4 bytes per word

.text
.globl main

main:
    # Inicializa PE com 0
    la $t0, PE        # Carrega o endereço de PE em $t0
    li $t1, 0         # Carrega o valor 0 em $t1
    sw $t1, 0($t0)    # Armazena 0 em PE

    # Carrega o número de elementos (n)
    la $t1, n         # Carrega o endereço de n em $t1
    lw $t1, 0($t1)    # Carrega o valor de n em $t1

    # Carrega os endereços base dos vetores A e B
    la $t2, A         # Carrega o endereço de A em $t2
    la $t3, B         # Carrega o endereço de B em $t3

    # Inicializa o contador do loop i com 0
    li $t4, 0         # Carrega o valor 0 em $t4 (i = 0)

    # Loop principal para a adição de vetores
loop_add:
    beq $t4, $t1, loop_sub # se i == n, pula para subtração

    # Carrega elementos A[i] e B[i]
    lw $t5, 0($t2)    # Carrega A[i] em $t5
    lw $t6, 0($t3)    # Carrega B[i] em $t6

    # Adiciona A[i] e B[i] e armazena em C[i]
    add $t7, $t5, $t6 # t7 = A[i] + B[i]
    la $t8, C         # Carrega o endereço de C em $t8
    add $t9, $t8, $t4 # t9 = endereço de C[i]
    sw $t7, 0($t9)    # Armazena A[i] + B[i] em C[i]

    # Incrementa os ponteiros dos vetores e o contador do loop
    addi $t2, $t2, 4  # Move para o próximo elemento em A
    addi $t3, $t3, 4  # Move para o próximo elemento em B
    addi $t4, $t4, 4  # i++

    j loop_add        # Salta de volta para o início do loop

# Loop para a subtração de vetores
loop_sub:
    beq $t4, $t1, calc_dot_product # se i == n, pula para produto escalar

    # Carrega elementos A[i] e B[i]
    lw $t5, 0($t2)    # Carrega A[i] em $t5
    lw $t6, 0($t3)    # Carrega B[i] em $t6

    # Subtrai B[i] de A[i] e armazena em D[i]
    sub $t7, $t5, $t6 # t7 = A[i] - B[i]
    la $t8, D         # Carrega o endereço de D em $t8
    add $t9, $t8, $t4 # t9 = endereço de D[i]
    sw $t7, 0($t9)    # Armazena A[i] - B[i] em D[i]

    # Incrementa os ponteiros dos vetores e o contador do loop
    addi $t2, $t2, 4  # Move para o próximo elemento em A
    addi $t3, $t3, 4  # Move para o próximo elemento em B
    addi $t4, $t4, 4  # i++

    j loop_sub        # Salta de volta para o início do loop

# Produto escalar
calc_dot_product:
    li $t4, 0         # Reinicia o contador do loop para 0
    li $t8, 0         # Inicializa a soma do produto escalar com 0

loop_dot_product:
    beq $t4, $t1, store_pe # se i == n, pula para armazenar PE

    # Carrega elementos C[i] e D[i]
    la $t2, C         # Carrega o endereço de C em $t2
    la $t3, D         # Carrega o endereço de D em $t3
    lw $t5, 0($t2)    # Carrega C[i] em $t5
    lw $t6, 0($t3)    # Carrega D[i] em $t6

    # Multiplica C[i] e D[i] e acumula em t8
    mul $t7, $t5, $t6 # t7 = C[i] * D[i]
    add $t8, $t8, $t7 # t8 += C[i] * D[i]

    # Incrementa os ponteiros dos vetores e o contador do loop
    addi $t2, $t2, 4  # Move para o próximo elemento em C
    addi $t3, $t3, 4  # Move para o próximo elemento em D
    addi $t4, $t4, 4  # i++

    j loop_dot_product# Salta de volta para o início do loop

store_pe:
    la $t0, PE        # Carrega o endereço de PE em $t0
    sw $t8, 0($t0)    # Armazena o valor de PE na memória

end:
    # Fim do programa
    j end             # Loop infinito para encerrar o programa
