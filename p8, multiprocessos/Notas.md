Não fiz o código porque não apeteceu ao computador. Por isso, tirei notas.

MPI_Send (&msg, N elementos, MPI_Int, Dest, tipo mensagem, MPI_Comm_World);

N elementos é o número de inteiros que são enviados.
Tags/Tipo mensagem - funcionam como caixas de correio, metes um número, e só recebes as que correspondem a esse número.

MPI_Receive (&msg, N elementos, MPI_Int, source, tipo mensagem, MPI_Comm_World, &Status);
O source pode ser Any_dest
Com o status dá para saber quem mandou a mensagem.

Alína a e b não tem paralelismo. C tem paralelismo.

0 1 2 3
m1
m2
m3
m4

0 1 2 3
m2 m1  
m3
m4

0 1 2 3
m3 m2 m1  
m4

Memória partilhada vs. Memórias distribuída
Distribuída não tem data races, porque o endereço 0 é único para cada processador.
Partilhada, todas as threads tem a mesma coisa no endereço 0.

Ex2 - Para fazer o farm, no receive, metemos ANY_SOURCE no campo de receção, e assim podemos receber desordenadamente.
Pelo status, vemos quem envia.
