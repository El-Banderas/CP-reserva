# Ex1

Como o algoritmo funciona:
Tens um array de tamanho N, analisas todos os números do array, e no primeiro filtro vês se são divisíveis entre 1 e N/3. Os que forem divisíveis, metes a 0.

filtro 1 -> verificas quais são divisíveis por números € [1,N/3]
filtro 2 -> Dos restantes, verificas quais são divisíveis por números € [N/3+1,2*N/3]
...

### a)

if (rank == 0){
criar primeServer, e initFilter(1, SMAP/3, SMAXP)
for(i = 0; i < n_messages; i++){
gera uma parte do array, tipo x
ps1->mprocess array de tamanho x
envia esse array de tamanho x para o processo seguinte
}
}
if (rank == 1){
criar primeServer, e initFilter(1/3, 2\*SMAP/3, SMAXP)
for(i = 0; i < n_messages; i++){
gera uma parte do array, tipo x
ps1->mprocess array de tamanho x
envia esse array de tamanho x
}
}

# Ex 2

Matrizes usadas:
A x B = C

Cada processo fica responsável por x linhas da matriz final, e as matrizes de origem são constantes, todos os processos podem usar.
As linhas são calculadas em paralelo, por cada processo. Cada processo fica com X linhas da matriz A e X colunas da B (ou fazes transposta da B)

Fazes broadcast das matrizes originais. Scatter das linhas da matriz final, e cada processo calcula essas linhas.
Com o gather no fim, juntas os vários bocados das matrizes. O programador define a ordem pela qual eles se juntam no fim, gather,
em função das contas que fizeram. Pode ser definidas pelos valores do rank.

Código:

Matriz A e B podes enviar apenas uma parte.

Isto é feito na função mmult(){
Scatter (matriz A) , broadcast da matriz B. QUem manda é o ranking 0
O Gather vai buscar de todos, e junta.
}

## Coisas gerais:

Não faz sentido lançar tasks para coisas pequenas, porque o custo de as criar é mau.

Reduções em árvores de processos para uma operação, por exemplo soma:
p1  
 p12 = operação (p1, p2)
p2
p_total = operação(p12, p34)  
p3
p34 = operação(p3,p4)
p4

O MPI_INIT tem um overhead
processo 0 MPI_INI | faz coisas | faz coisas sempre e vai mandando
processo 1 MPI_INI | tempo parado | faz coisas | alterna quem faz coisas, porque o p2 está à espera que o p1 acabe de filtrar cada bocadinho.
processo 2 MPI_INI | MPI_RECV | espera um bocado |

O primeiro inicia o array, tem mais contas para fazer.
Para além disso, o primeiro conjunto de números tem mais contas, porque vai fazer mais operações, porque os números 2, 3, e 5 eliminam muitos mais números.
Uma forma de resolver é o primeiro filtro ter menos números, e os outros mais.

```c
void mmult(){
    MPI_Scatter(A, size*(sizee/nprocs), MPI_DOUBLE, pA, size*(size/nprocs), MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_BCcast(B, size*size, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    for (int i = 0; i < size/nprocs; i++){
        for(int j = 0; j<size;j++){
            for (int k = 0; k < size; k++){
                pC[i*size+j] += pA[i*size+k]* B[k*size+j]
            }
        }
    }
    MPI_Gather(pC, size*(size/nprocs), MPI_DOUBLE, C, size*(size/nprocs), MPI_DOUBLE, 0, MPI_COMM_WORLD);

    int main(int argc, char *argv[]){
        MPI_Status status;
        MPI-Init(&argc, &argv);
        MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
        MPI_Comm_size (MPI_Comm_WORLD, &nprocs);
        ...
        alloc();
        if (myrank==0) init();
        mmult();
        if (myrank==0) printf("...", C[400]);
        MPI_Finalize();
        return 0;
    }

}
```
