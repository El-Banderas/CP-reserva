Processadores físicos vs. Virtual

Cada físico tem um virtual, logo 10 físicos dão origem a 10 físicos + 10 virtuais.
Assim, enquanto uma acede à memória, a outra pode fazer adições.


# Exercícios
Se não meteres nada no w, ele é partilhado. Logo, há concorrência de dados, e o w pode não subir as 100 vezes.

1.1 Private mantêm o valor da variável no fim do for, e começa com o valor a 0.

1.2 First private mantêm a inicialização que estava fora.   

1.3 Lastprivate mantêm o valor da variável após o for.

1.4 Reduce, soma nas 2 threads. Cria 2 variáveis, uma para cada thread, vai somando, e no fim soma em w as duas variáveis criadas.

## Ex 2

a) Sim, porque existem corridas à informação.
b) Sim, diminui cada vez mais, porque há mais concorrência no acesso aos dados, e o resultado das somas não é corretamente guardado.

c) Já tem o valor correto, acrescentei `#pragma omp critical`.
d) Sim, com o reduce. (#pragma omp parallel for reduction(+:dot))

Mesmo quando se mete o critical, podem dar resultados diferentes, porque:
As somas aqui não são propriamente comutativas. Somar números grandes com pequenos pode originar valores diferentes.

## Ex 3


