#include <cuda_runtime.h>
#include <stdio.h>

int main(int argc, char** argv)
{
   cudaDeviceProp prop;
   cudaGetDeviceProperties(&prop, 0);

   printf("Device name: %s\n", prop.name);
   printf("Memory clock rate (KHz) : %d\n", prop.memoryClockRate);
   printf("Memory bus width (bits) : %d\n", prop.memoryBusWidth);
   printf("Compute capability : %d.%d\n", prop.major, prop.minor);
   printf("Max threads per block : %d\n", prop.maxThreadsPerBlock);
   printf("Max threads per multiprocessor: %d\n", prop.maxThreadsPerMultiProcessor);
   printf("Multiprocessor count: %d\n", prop.multiProcessorCount);
   return 0;
}
