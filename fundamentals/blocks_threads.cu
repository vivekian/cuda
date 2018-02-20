#include <cuda_runtime.h>
#include <stdio.h>

__global__ void gpukernel()
{
    printf("%d %d %d %d\n", blockIdx.x, threadIdx.x, blockDim.x, gridDim.x);
}

int main(int argc, char** argv)
{
    // launch a gpu kernel with 3 blocks and 4 threads in each block.
    gpukernel<<<3,4>>>();

    // block the cpu for the gpu to finish execution
    cudaDeviceSynchronize();
    return 0;
}
