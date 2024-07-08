# Inicialização de variáveis e arrays
PE = 0
n = 8
A = [1, 2, 3, 4, 5, 6, 7, -8]
B = [-8, 7, -6, 5, 4, -3, 2, -1]
C = [0] * n
D = [0] * n

# Loop principal para a adição de vetores
for i in range(n):
    C[i] = A[i] + B[i]  # Adiciona A[i] e B[i] e armazena em C[i]

# Loop para a subtração de vetores
for i in range(n):
    D[i] = A[i] - B[i]  # Subtrai B[i] de A[i] e armazena em D[i]

# Produto escalar
PE = 0
for i in range(n):
    PE += C[i] * D[i]  # Multiplica C[i] e D[i] e acumula em PE

# Fim do programa
# A variável PE contém o resultado final do produto escalar
print("Produto Escalar (PE):", PE)
