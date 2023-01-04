
# Ex1

A cache tem 64 bytes. A matriz é de doubles, e cada double ocupa 8 bytes. 
A cache pode ter 8 doubles.
Logo, o tamanho ideal da matriz é 8 números, para que quando for ler, lê uma linha completa.

a) 
A tem localidade espacial, ao trazer um elemento, traz logo os elementos seguintes.
B não tem localidade.
C tem localidade temporal, porque está sempre a ir ler o valor (c += ...). C também tem localidade espacial, porque quando vais buscar um elemento, vai buscar os seguintes.

b)
Matriz B: NxNxN, por cada célula tens um miss completo, carregar todos os elementos (N). 
                Por cada linha, tens de ir por cada elemento N vezes, logo é NxN
                Por cada matrix, tens de ir por cada linha NxN vezes, logo é NxNxN

c) Transpõe-se a matriz C, para que ao calcular o produto de matrizes, se possa percorrer a matriz C por linhas. Assim, temos localidade espacial. 
Assim, o número total de vezes para percorrer B é NxN.

d) 
Os misses estimados são muito superiores que os reais, porque uma linha da matriz A cabe em cache. 
