# Dados de entrada
n = 8
A = [30, -20, 30, -40, 81, 92, 27, 26]
B = [82, -70, 60, -50, 42, 39, 19, 10]
C = [0] * n  # Vetor para armazenar A + B
D = [0] * n  # Vetor para armazenar A - B

# Função para somar vetores A e B e armazenar em C
def soma_vetores(A, B, C):
    for i in range(n):
        C[i] = A[i] + B[i]

# Função para subtrair vetores A e B e armazenar em D
def subtrai_vetores(A, B, D):
    for i in range(n):
        D[i] = A[i] - B[i]

# Função para calcular o produto escalar entre vetores C e D
def produto_escalar(C, D):
    PE = 0
    for i in range(n):
        PE += C[i] * D[i]
    return PE

# Execução das funções
soma_vetores(A, B, C)
subtrai_vetores(A, B, D)
PE = produto_escalar(C, D)

# Saída do produto escalar
print(f"Produto Escalar (PE) entre vetores C e D: {PE}")

# Saída dos vetores C e D para verificação
print(f"Vetor C (A + B): {C}")
print(f"Vetor D (A - B): {D}")
