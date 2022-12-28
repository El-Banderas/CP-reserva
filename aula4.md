## Loop unrolling (em casa, está incompleto)

Separar para `for (k += 2; ... )` cada iteração faz duas instruções
                c[i][j] = ...
                c[i][j+1], por exempl

* Tens menos instruções de salto, e comparações, logo menos instruções no total

## Vetorização

### Porque não dá para fazer vetorização na multiplicação de matrizes?

Porque a segunda matriz não tem a informação num vetor, logo não dá para vetorizar (uma instrução, muitos elementos)

Outra limitação é só usarmos uma posição para guardar resultado, dificulta a vetorização. É preferível guardar o resultado em várias posições de memória.

c) C = A  x B
* Variando j k i
`c[i][j] += A[i][k] x B[k][j]`
No C percorres em coluna, No A também, e B é um ponto, demora mais a avançar.

* Variando i k j
`c[i][j] += A[i][k] x B[k][j]`
     | varia por linha, j           
               | só varia no fim
No C percorres em linha, no A é um ponto, e B é em linha. O J é o que avança mais. 
No A, podes replicar o mesmo valor num array, ao multiplicar um vetor por um ponto constante, ficas com valores corretos.


* Variando k i j
`c[i][j] += A[i][k] x B[k][j]`
É igual à anterior.
(Tem uma imagem na pasta do ficheiro)
### Outra parte
A meio tens esta parte:

```
	movupd	(%rsi,%rax), %xmm0  -- rax aponta para uma posição da matriz, que vai ser utilizada na operação.
	movupd	(%rdx,%rax), %xmm2
	mulpd	%xmm1, %xmm0
	addpd	%xmm2, %xmm0
	movups	%xmm0, (%rdx,%rax) -- Guardar na memória, posição do %rax
	addq	$16, %rax  -- O %rax avança 16, que é 2 doubles.
	cmpq	$4096, %rax	$16, %rax
	cmpq	$4096, %rax
```
d)
O que tem pd é vetorial.
 É expectável que o número de instruções passe para metade, porque cada instrução trata de dois números.

## Ex 3

double = 8 bytes. 
256 / 8 = 32 bytes que o vector aguenta.
Logo, um vector leva 4 doubles.
Conseguimos fazer duas instruções de FP de cada vez (ignora stores).

2.5GHz x 4 doubles * 2 = 20 GH floating points (flops)


Sem vetorização
2.5GHz x 2 = 5 GH floating points (flops).
    Só fazes um floating point de cada vez, não há vetorização.


O que a imagem na pasta quer dizer é: quanto mais espaço ocupar o valor (floating point), menos floating points podes processar de cada vez. Se tiveres umm floating point de 1 byte, consegues fazer vetorização e tens 20GHz.

### c)

Multiplicação: A x B, A é constante, um ponto. 
                   B são lidos 2 valores:  `addq	$16, %rax  -- O %rax avança 16, que é 2 doubles.`

  2
 --
 2x8