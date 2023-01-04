
# Ex1

a) Se N -> N*2, (número de instruções)
(N*2)^3 -> 8N^3, o tempo de execução fica 8 vezes maior.
Número de instruções aumenta.

b) 
O2 - 8 * 512^3
-00 - 45 * 512^3

c)
        size    Texe     #I                  #CC           CPI médio
-02 |   512    1.1716    6 088 867 556    3 000 000 000      0.54
    |   128    0.0922    20 180 208       13 000 000
    |   256    0.306     144 782 219      125 000 000
-O0 |   512    0.45      1 113 332 042    1 000 000 000       1.11

Se dividirmos 256 por 128 no número de instruções dá aproximadamente 7, porque algumas instruções não aumentam. 

e) Apesar de termos um CPI mais baixo com O2, é melhor porque são feitas menos instruções, que compensa um aumento de CPI. Cada instrução demora mais a fazer.

Tempo por ciclos (constante porque é relativo à frequência) é proporcional ao tempo de execução.
+ Tempo por ciclos =>  + Tempo execução

# Ex 2

a) ILP, como tem várias unidades funcionais ("add" diferente de "load"), podem executar em paralelo.
Porque o bottleneck é 4 micro-instruções por ciclo. Ideal: 0.25 CPI
O que é micro-instrução? 

b) Há menos instruções, logo cada instrução é realizada sempre, e o CPI é mais alto??

c)
Entre as 2 primeiras, mov e mul, e entre "addsd %xmm0, %xmm1" e o "movsd %xmm1, (%rcx)".
Para fazer a multiplicação, temos de ter o valor de %xmm0.
Dependências assinaladas

movsd (%rdx), %xmm0      addq $8, %rdx , existe dependência nesta linha, mas não tem mal, dá para duplicar
                |
mulsd (%rax), %xmm0      addq $4096, %rax
             /                     /
addsd %xmm0, %xmm1       cmpq %rax, %rsi
            /
movsd %xmm1, (%rcx)         jne .L12 (não tem dependência)

A dependência da primeira linha pode ser evitada se duplicares o valor.

e) Para reduzir dependências, podes fazer duas contas de cada vez, e assim deixa de haver tantas dependências, e fica mais eficaz.

 CPI menos que 1 por paralelismo ao nível de instruções.
