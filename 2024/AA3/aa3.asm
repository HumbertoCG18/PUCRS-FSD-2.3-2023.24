#T4 ESPECIFICAÃ‡ÃƒO 1.

# t0 = PE;
# t1 = n;
# t2 = A[];
# t3 = B[];
# t4 = i;
# t5 = j;
# t6 = A[i];
# t7 = B[i];
# a0 = sempre 0;
# a1 = 'B[i]' originais;
# a2 = 'A[i]' originais;

.text

.global


begin:		
		la $t0, PE 		# t0 carrega endereco de PE;
		lw $t0, 0($t0)		# t0 = 0;	
		la $t1, n		# t1 carrega endereco de n;
		lw $t1,0($t1)		# t1 = 8;
		
		la $t2, A		# t2 carrega endereco de A[0];
		la $t3, B		# t3 carrega endereco de B[0];
		
		xor $t4, $t4, $t4	# t4 = i = 0;
		xor $a0,$a0,$a0 	# a0 = 0;
		
loop_main:	
			xor $t5,$t5,$t5				# t5 = j = 0;
			lw $t6, 0($t3)				# t6 = B[i]; 
			lw $t7, 0($t2)				# t7 = A[i];
			blt $t4, $t1, loop_multiply 		# if(i < n) multiply;
			sw $t0, PE				# salva o que esta em t0 no PE;
			j end					# fim
				

loop_multiply:
			lw $a1, 0($t3)				# a1  salva B[i] original; 
			lw $a2, 0($t2)				# a2 salva A[i] original; 
			blt $t5, $t6, incremento_multiply	# if(j<B[i]) incremento_multiplay;
			blt $t6, $t5, inverte_b			# if(B[i] < j) inverte B;
			j incremento_main			# incrementa enderecos e o 'i';
		
inverte_b:	
			sub $t6 , $a0, $t6		# t6 = 0 - t6;
			j loop_multiply			# vai pra multiplicacao;
inverte_a:	
			sub $t7 , $a0, $t7		# t7 = 0 - t7;
			j loop_multiply			# vai pra multiplicacao;
						
		
verifica_a:		
			blt $a2, $a0, incremento_soma_negativos		# se chegou aqui entao B[i] original é negativo, se for verdade entao A[i] original tambem é negativo;
			j incremento_subtracao				# se anterior falhar entao os sinais sao opostos e causa uma subtracao

incremento_multiply:
			blt $t7, $a0 , inverte_a		# if(A[i] < 0) negativo => inverete valor do A; 
			blt $a1, $a0, verifica_a		# if(B[i] < 0 ) verifica sianl do o A;
			blt $a2, $a0, incremento_subtracao	# if(A[i] < 0 ) B[i] ja é maior que 0 se (verdade entao fica sinais opostos);
			add $t0,$t0, $t7 			# PE = PE + A[i];
			addi $t5, $t5, 1 			# j++;
			j loop_multiply				# retorna pro loop;
			
incremento_soma_negativos:
			add $t0,$t0, $t7 		# PE = PE + A[i];
			addi $t5, $t5, 1 		# j++;
			j loop_multiply			# retorna pro loop;

incremento_subtracao: 
			sub $t0,$t0, $t7 	# PE = PE - A[i];
			addi $t5, $t5, 1 	# j++;
			j loop_multiply		# retorna pro loop;


incremento_main:
		addi $t2, $t2, 4	# endereco do A += 4 (proximo elemento do vetor);
		addi $t3, $t3, 4	# endereco do B += 4 (proximo elemento do vetor);
		addi $t4, $t4, 1	# i++;
		j loop_main		# retorna loop principal;

end: j end



.data

PE:	.word	0
n:	.word	8
A:	.word	1 2 3 4 5 6 7 -8
B:	.word	-8 7 -6 5 4 -3 2 -1
C:	.word	0 0 0 0 0 0 0 0
D:	.word	0 0 0 0 0 0 0 0
