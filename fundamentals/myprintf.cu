#include <cuda_runtime.h>
#include <stdio.h>

__global__ void helloworld()
{
    printf("hello world\n");
}

int main(int argc, char** argv)
{
    // launch a gpu kernel
    helloworld<<<3,3>>>();

    // block the cpu for the gpu to finish execution
    cudaDeviceSynchronize();
    return 0;
}
