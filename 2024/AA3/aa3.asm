.data
vetor_A: .word 10, -5, 8, -3, 15, 6, -7, 4
vetor_B: .word -2, 7, -10, 12, 3, -6, 9, -1
vetor_C: .space 32   # Espaço para 8 inteiros (8 * 4 bytes)
vetor_D: .space 32   # Espaço para 8 inteiros (8 * 4 bytes)
tamanho_vetor: .word 8   # Tamanho dos vetores A e B
resultado_PE: .word 0    # Variável para armazenar o resultado do produto escalar

.text
.globl main

main:
    # Inicialização dos registradores
    li $t0, 0             # Índice para percorrer os vetores A e B
    la $s0, vetor_A       # Endereço do vetor A
    la $s1, vetor_B       # Endereço do vetor B
    la $s2, vetor_C       # Endereço do vetor C (resultado da adição)
    la $s3, vetor_D       # Endereço do vetor D (resultado da subtração)
    lw $s4, tamanho_vetor # Tamanho dos vetores A e B
    
    # Loop para inicializar os vetores C e D com zero
    init_loop:
        beq $t0, $s4, end_init_loop  # Se índice igual ao tamanho, sai do loop
        
        # Inicializa vetor C[i] com zero
        sw $zero, 0($s2)
        
        # Inicializa vetor D[i] com zero
        sw $zero, 0($s3)
        
        addi $t0, $t0, 1  # Incrementa o índice
        addi $s2, $s2, 4  # Avança para o próximo elemento de C
        addi $s3, $s3, 4  # Avança para o próximo elemento de D
        j init_loop      # Volta ao início do loop
    
    end_init_loop:
    # Chamada das sub-rotinas de adição e subtração
    jal adicao_vetores   # Chama a sub-rotina de adição
    jal subtracao_vetores  # Chama a sub-rotina de subtração
    
    # Chamada da sub-rotina de produto escalar
    jal produto_escalar
    
    # Finaliza o programa
    li $v0, 10
    syscall

# Sub-rotina para adicionar vetores A e B, armazenando em C
adicao_vetores:
    # Reinicializa o índice
    li $t0, 0
    
    add_loop:
        beq $t0, $s4, end_add_loop  # Se índice igual ao tamanho, sai do loop
        
        lw $s5, 0($s0)    # Carrega A[i] em $s5
        lw $s6, 0($s1)    # Carrega B[i] em $s6
        
        add $s7, $s5, $s6  # Soma A[i] + B[i]
        sw $s7, 0($s2)      # Armazena em C[i]
        
        addi $t0, $t0, 1   # Incrementa o índice
        addi $s0, $s0, 4   # Avança para o próximo elemento de A
        addi $s1, $s1, 4   # Avança para o próximo elemento de B
        addi $s2, $s2, 4   # Avança para o próximo elemento de C
        
        j add_loop         # Volta ao início do loop
    
    end_add_loop:
    jr $ra  # Retorna à chamada

# Sub-rotina para subtrair vetores A e B, armazenando em D
subtracao_vetores:
    # Reinicializa o índice
    li $t0, 0
    
    sub_loop:
        beq $t0, $s4, end_sub_loop  # Se índice igual ao tamanho, sai do loop
        
        lw $s5, 0($s0)    # Carrega A[i] em $s5
        lw $s6, 0($s1)    # Carrega B[i] em $s6
        
        sub $s7, $s5, $s6  # Subtrai A[i] - B[i]
        sw $s7, 0($s3)      # Armazena em D[i]
        
        addi $t0, $t0, 1   # Incrementa o índice
        addi $s0, $s0, 4   # Avança para o próximo elemento de A
        addi $s1, $s1, 4   # Avança para o próximo elemento de B
        addi $s3, $s3, 4   # Avança para o próximo elemento de D
        
        j sub_loop         # Volta ao início do loop
    
    end_sub_loop:
    jr $ra  # Retorna à chamada

# Sub-rotina para calcular o produto escalar entre vetores C e D
produto_escalar:
    # Reinicializa o índice e acumulador
    li $t0, 0
    li $t1, 0
    
    scalar_loop:
        beq $t0, $s4, end_scalar_loop  # Se índice igual ao tamanho, sai do loop
        
        lw $s5, 0($s2)    # Carrega C[i] em $s5
        lw $s6, 0($s3)    # Carrega D[i] em $s6
        
        mul $s7, $s5, $s6  # Calcula C[i] * D[i]
        add $t1, $t1, $s7  # Acumula o resultado
        
        addi $t0, $t0, 1   # Incrementa o índice
        addi $s2, $s2, 4   # Avança para o próximo elemento de C
        addi $s3, $s3, 4   # Avança para o próximo elemento de D
        
        j scalar_loop      # Volta ao início do loop
    
    end_scalar_loop:
    # Salva o resultado do produto escalar em memória
    sw $t1, resultado_PE
    
    jr $ra  # Retorna à chamada
