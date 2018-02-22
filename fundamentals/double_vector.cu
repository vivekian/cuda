#include <cuda_runtime.h>
#include <stdio.h>

__global__ void doublevector(int* vec, int N)
{
    int idx = (blockIdx.x * blockDim.x) + threadIdx.x;

    if (idx < N) {
        vec[idx] *= 2;
    }
}

__global__ void init(int* vec, int N)
{
    int idx = (blockIdx.x * blockDim.x) + threadIdx.x;

    if (idx < N) {
        vec[idx] = idx;
    }
}

bool check(int* vec, int N)
{
    for (int i=0; i<N; ++i) {
        if (vec[i] != i*2) {
            return false;
        }
    }

    return true;
}

int main(int argc, char** argv)
{
    const int N = 4096;
    int* vec;

    // managed memory in cuda
    cudaError_t result = cudaMallocManaged(&vec, N * sizeof(int));
    if (result != cudaSuccess) {
        printf("cudaMalloc failed\n");
    }

    // initialize the vector on the gpu
    init<<<4, N/4>>>(vec, N);

    // launch a gpu kernel with 4 blocks and 1024 threads in each block.
    doublevector<<<4,N/4>>>(vec, N);

    // block the cpu for the gpu to finish execution
    cudaDeviceSynchronize();

    if (!check(vec, N)) {
        printf("test failed\n");
    }

    cudaFree(vec);
    return 0;
}
