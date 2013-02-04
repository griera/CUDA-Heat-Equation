#include <math.h>
#include <float.h>
#include <cuda.h>

__global__ void gpu_Heat(float *h, float *g, int N) {
    // In this case, the stride is N

    int i = blockIdx.y * blockDim.y + threadIdx.y;
    int j = blockIdx.x * blockDim.x + threadIdx.x;

    // Assert if current thread belongs to first row or column of input matrix
    bool is_first_row = threadIdx.y == 0 && blockIdx.y == 0;
    bool is_first_col = threadIdx.x == 0 && blockIdx.x == 0;

    if (i < N - 1 && j < N - 1 && !is_first_row && !is_first_col) {
        int pos = i * N + j;
        g[pos] = 0.25 * (h[pos - 1] + h[pos - N] + h[pos + 1] + h[pos + N]);
    }
}
