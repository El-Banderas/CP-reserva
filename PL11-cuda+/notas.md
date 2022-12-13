## coisas

Tens o array a:

0 10 20 30 40
coisa coisa coisa coisa coisa

E o array tmp que varia entre

Thread id x é o identificador da thread no bloco

O objetivo é cada thread guardar no array tmp a sua parte. A origem dessa cópia está no array a.

O que está no a, está organizado assim:

t0 t1 t2 t3 | t0 t1 t2 t3 | ...

E assim, ao fazeres id, avanças no array a entre 0 e length de A
E o threadId.x varia entre 0 e o comprimento do array de tmp.

O shared é tipo uma cache para o GPU. Assim, em vez de o GPU ir buscar à memória global os valores, tem esses valores guardados num array mais pertinho, o tmp. Esse tmp está em shared.
