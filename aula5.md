# Notas

As variáveis dentro do pragma são privadas à thread

# Ex 1

### a)
Não é, porque as threads, apesar de funcionarem em paralelo, não escrevem ao mesmo tempo no buffer de saída. Por isso, é aleatório quem acede ao buffer de escrita.
### b)
Sim, porque cada thread executa sequencialmente. 
### c)
Cada thread executa as mesmas coisas, o trabalho é balanceado, e começam ao mesmo tempo. 

# Ex 2

### a)
Quando faz `omp for`, divide 100 pelo número de threads.
Quando faz `omp master`, a thread master faz tudo.
Quando faz `omp single`, a thread single faz tudo. Ele procura uma thread com menos carga e atribuí-lhe o trabalho. Na master, obriga a que seja a principal a fazer.


### b)
Não, na primeira divide por 4, nas outras não.

### c)
Só uma thread executa a parte definida como critical.
?? Sim, é sempre a mesma. Porque a operação é crítica, o for, logo só uma thread vai fazer o for.

# Ex 3

Só abre o sinal de vermelho para verde quando todas as threads chegam aquele ponto.
O output não tem de ser sempre o mesmo, porque a ordem pela qual passam a barreira é indiferente.

a) 
Não é sempre o mesmo, mas imprime sempre aos pares. A barreira força a que todas as threads passem por lá antes de irem para o próximo i.

b) 

# Ex 4

Static é sempre o mesmo
Dinámico, vai alocando à medida que threads ficam livres.
guided,  
