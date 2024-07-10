.data
PE: .word 0           # Variável para armazenar o produto escalar
n: .word 8            # Número de elementos nos vetores A e B
A: .word 30, -20, 30, -40, 81, 92, 27, 26   # Vetor A com valores aleatórios
B: .word 82, -70, 60, -50, 42, 39, 19, 10   # Vetor B com valores aleatórios
C: .word 0, 0, 0, 0, 0, 0, 0, 0   # Vetor C para armazenar A + B
D: .word 0, 0, 0, 0, 0, 0, 0, 0   # Vetor D para armazenar A - B

.text
.globl main

main:
    # Chamada para adicionar e subtrair vetores A e B para obter C e D
    jal soma_vetores
    jal subtrai_vetores

    # Chamada para calcular o produto escalar entre C e D
    jal produto_escalar

    # Fim do programa
    j end

# Sub-rotina para somar vetores A e B e armazenar em C
soma_vetores:
    la $t0, A     # Endereço de A
    la $t1, B     # Endereço de B
    la $t2, C     # Endereço de C
    lw $t3, n     # Carrega n
    
    li $t4, 0     # $t4 = i = 0

loop_soma:
    lw $t5, 0($t0)     # Carrega A[i]
    lw $t6, 0($t1)     # Carrega B[i]
    add $t7, $t5, $t6  # Calcula A[i] + B[i]
    sw $t7, 0($t2)     # Armazena em C[i]
    
    addi $t0, $t0, 4   # Próximo elemento de A
    addi $t1, $t1, 4   # Próximo elemento de B
    addi $t2, $t2, 4   # Próximo elemento de C
    
    addi $t4, $t4, 1   # Incrementa i
    blt $t4, $t3, loop_soma  # Loop se i < n
    
    jr $ra            # Retorna

# Sub-rotina para subtrair vetores A e B e armazenar em D
subtrai_vetores:
    la $t0, A     # Endereço de A
    la $t1, B     # Endereço de B
    la $t2, D     # Endereço de D
    lw $t3, n     # Carrega n
    
    li $t4, 0     # $t4 = i = 0

loop_subtrai:
    lw $t5, 0($t0)     # Carrega A[i]
    lw $t6, 0($t1)     # Carrega B[i]
    sub $t7, $t5, $t6  # Calcula A[i] - B[i]
    sw $t7, 0($t2)     # Armazena em D[i]
    
    addi $t0, $t0, 4   # Próximo elemento de A
    addi $t1, $t1, 4   # Próximo elemento de B
    addi $t2, $t2, 4   # Próximo elemento de D
    
    addi $t4, $t4, 1   # Incrementa i
    blt $t4, $t3, loop_subtrai  # Loop se i < n
    
    jr $ra            # Retorna

# Sub-rotina para calcular o produto escalar entre vetores C e D
produto_escalar:
    la $t0, C     # Endereço de C
    la $t1, D     # Endereço de D
    lw $t2, n     # Carrega n
    li $t3, 0     # PE = 0 (inicializa o produto escalar)

    li $t4, 0     # $t4 = i = 0

loop_produto:
    lw $t5, 0($t0)     # Carrega C[i]
    lw $t6, 0($t1)     # Carrega D[i]

    # Multiplicação manual usando soma repetida
    li $t7, 0        # Inicializa $t7 com 0 (acumulador do produto)
    li $t8, 0        # Inicializa $t8 com 0 (contador)
    
    # Multiplicação C[i] * D[i]
    abs $t9, $t6     # t9 = |D[i]|
mult_loop:
    beq $t8, $t9, end_mult  # Se $t8 == |D[i]|, fim da multiplicação
    add $t7, $t7, $t5       # t7 = t7 + C[i]
    addi $t8, $t8, 1        # t8++
    j mult_loop             # Repetir o loop
end_mult:
    bgez $t6, positive_mult # Se D[i] >= 0, salta
    sub $t7, $zero, $t7     # Se D[i] < 0, t7 = -t7
positive_mult:
    add $t3, $t3, $t7       # PE += t7

    addi $t0, $t0, 4   # Próximo elemento de C
    addi $t1, $t1, 4   # Próximo elemento de D
    
    addi $t4, $t4, 1   # Incrementa i
    blt $t4, $t2, loop_produto  # Loop se i < n
    
    la $t8, PE         # Endereço de PE
    sw $t3, 0($t8)     # Salva o resultado do produto escalar em PE
    
    jr $ra         # Retorna

end:
    # Termina o programa
    nop
