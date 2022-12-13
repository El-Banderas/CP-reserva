#include "stencil.h"

#define NUM_BLOCKS 128
#define NUM_THREADS_PER_BLOCK 256
#define SIZE NUM_BLOCKS *NUM_THREADS_PER_BLOCK

using namespace std;

// O id varia entre 0 e o comprimento de a.

__global__ void stencilKernel(float *a, float *c)
{
    int id = blockIdx.x * blockDim.x + threadIdx.x;
    int lid = threadIdx.x;                            // local thread id within a block
    __shared__ float temp[NUM_THREADS_PER_BLOCK + 4]; // para o das pontas, porque o temp tem de ter:
    // n1 n2 nMesmo nMesmo ... nMesmo n3 n4
    // Porque para calcular os valores precisas sempre de 2 em cada ponta.
    temp[lid] = a[id];
    if (lid == 1)
    {
        temp[0] = a[NUM_BLOCKS - 2];
        temp[1] = a[NUM_BLOCKS - 1];
    }
    __syncthreads(); // wait for all threads within a block
    // Temos de escrever todos os valores antes de avançar para o cálculo do c
    c[id] = 0;
    for (int n = -2; n <= 2; n++)
    {
        if ((id + n >= 0) && (id + n < SIZE))
            // Tem de ser mais 2, porque o array tmp começa com os 2 primeiros valores das pontas.
            // O lid é necessário para ires buscar ao array temp não as coisas do primeiro bloco, mas as do seguinte.
            c[id] += temp[n + lid + 2];
    }
}

void stencil(float *a, float *c)
{
    chrono::steady_clock::time_point begin = chrono::steady_clock::now();

    for (int i = 0; i < SIZE; i++)
    {
        // considers 4 neighbours
        for (int n = -2; n <= 2; n++)
        {
            if ((i + n >= 0) && (i + n < SIZE))
                c[i] += a[i + n];
        }
    }

    chrono::steady_clock::time_point end = chrono::steady_clock::now();
    cout << endl
         << "Sequential CPU execution: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << " microseconds" << endl
         << endl;
}

void launchStencilKernel(float *a, float *c)
{
    // pointers to the device memory
    float *da, *dc;
    // declare variable with size of the array in bytes
    int bytes = SIZE * sizeof(float);

    // allocate the memory on the device
    cudaMalloc((void **)&da, bytes);
    cudaMalloc((void **)&dc, bytes);
    checkCUDAError("mem allocation");

    // copy inputs to the device
    cudaMemcpy(&da, a, bytes, cudaMemcpyHostToDevice);
    checkCUDAError("memcpy h->d");

    // launch the kernel
    startKernelTime();
    stencilKernel<<<NUM_THREADS_PER_BLOCK, NUM_BLOCKS>>>(da, dc);
    stopKernelTime();
    checkCUDAError("kernel invocation");

    // copy the output to the host
    cudaMemcpy((void **)&dc, c, bytes, cudaMemcpyDeviceToHost);
    checkCUDAError("memcpy d->h");

    // free the device memory
    cudaFree(da);
    cudaFree(dc);
    checkCUDAError("mem free");
}

int main(int argc, char **argv)
{
    // arrays on the host
    float a[SIZE], b[SIZE], c[SIZE];

    // initialises the array
    for (unsigned i = 0; i < SIZE; ++i)
        a[i] = (float)rand() / RAND_MAX;

    stencil(a, b);

    launchStencilKernel(a, c);

    return 0;
}