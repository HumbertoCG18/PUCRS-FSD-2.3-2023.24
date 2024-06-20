#memoria de instrução
.text

.global inicio

#t0 = i
#t1 = n
#t2 = endereço vetor [i]
#t3 = conteudo do valor [i]
#t4 = maior


inicio: xor $st0, $t0, $t0 #zera o i.
        la  $t1, n         #le o endereço de N e salva em T1
        lw  $t1, 0($t1)    #salva dentro de t1 o conteudo 
        
        la  $t2, vetor     #le o endereço de vetor
        lw  $t3, 0($t2)    #salva dentro do t3 conteudo do vetor 

loop:   lw  $t4, 0($t2)    #maior = vetor[0]

        addi $t0, $t0, 1   #incrementando i.
        addi $$t2, $t2, 4  #incrementando o endereço de vetor

        blt $t0, $t1, loop 
fim: j fim

# memoria de dados
.data
n: .word            5
maior_mem: .word    0
vetor: .word        6 2 120 450 8  


