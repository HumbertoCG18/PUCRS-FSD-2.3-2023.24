.text
.globl inicio
 

inicio:		lw $t0, n	# Carrega o tamanho do vetor
    
		# Carrega endereços dos vetores
		la $t1, A
		la $t2, B
		la $t3, C
		la $t4, D
    
		# Loop para adição e subtração de vetores A e B
		xor	$t5, $t5, $t5     # Inicializa i
    
add_sub_loop:   
		lw	$t6, 0($t1)   # Carrega A[i]
		lw	$t7, 0($t2)   # Carrega B[i]
    
		add	$t8, $t6, $t7   # Adiciona A[i] + B[i]
		sub	$t9, $t6, $t7   # Subtrai A[i] - B[i]
    
		sw	$t8, 0($t3)   # Armazena resultado da adição em C[i]
		sw	$t9, 0($t4)   # Armazena resultado da subtração em D[i]
    
		addi	$t1, $t1, 4   # Avança para o próximo elemento em A
		addi	$t2, $t2, 4   # Avança para o próximo elemento em B
		addi	$t3, $t3, 4   # Avança para o próximo elemento em C
		addi	$t4, $t4, 4   # Avança para o próximo elemento em D
		addi	$t5, $t5, 1   # Incrementa contador do loop
		blt	$t5, $t0, add_sub_loop   # Se o i < n, retorna para "add_sub_loop"
		j calc_sum_pos   # Vai para cálculo da soma dos valores positivos
		
calc_sum_pos:
		la	$t3, C		# Reinicia a posição do C
		la	$t4, D		# Reinicia a posição do D
		xor	$t5, $t5, $t5	# Reinicia o i
		xor	$t6, $t6, $t6	# Reinicia o auxiliar
		xor	$t7, $t7, $t7	# Reinicia o auxiliar
		xor	$t8, $t8, $t8	# Reinicia o auxiliar
		xor	$t9, $t9, $t9	# Reinicia o auxiliar
		
calc_sum_loop_C:
    		lw	$t6, 0($t3)	# Carrega C[i]
    		addi	$t3, $t3, 4	# Avança para o próximo elemento em C
    		addi	$t5, $t5, 1	# Incrementa contador do loop
    		bltz	$t6, calc_sum_loop_C
    		
    		add	$t8, $t8, $t6	# Adiciona X = X + C[i]
    		

    		blt	$t5, $t0, calc_sum_loop_C   # Se o i < n, retorna para "add_sub_loop"

		xor	$t5, $t5, $t5	# Reinicia o i
calc_sum_loop_D:
    		lw	$t7, 0($t4)	# Carrega D[i]
    		addi	$t4, $t4, 4	# Avança para o próximo elemento em D
       		addi	$t5, $t5, 1	# Incrementa contador do loop
    		blt	$t7, 0, calc_sum_loop_D
    		
    		add	$t9, $t9, $t7	# Adiciona X = X + D[i]

    		blt	$t5, $t0, calc_sum_loop_D	# Se o i < n, retorna para "add_sub_loop"
    		

end:	
    # Multiplica os valores somados de C e D
    mul $t8, $t8, $t9   # Multiplica a soma dos valores positivos de C e D
    sw $t8, MP          # Armazena o resultado na variável MP

    j end


.data
A: .word -5 7 8 9 -3 1 -6 2
B: .word 4 2 9 -7 2 -1 -6 8
C: .word 0 0 0 0 0 0 0 0
D: .word 0 0 0 0 0 0 0 0
MP: .word 0
n: .word 8