#ifndef __CUDA_SUPPORT__
#define __CUDA_SUPPORT__

#include <iostream>
#include <string>
#include <assert.h>
#include <stdio.h>


using namespace std;

class cudaInterface
{
public:
    cudaInterface();
    void checkMatch();
    int searchFor(char* quieryString);
    void testBenchDriver();

private:

protected:

    int queiryBlockSize;
    int inputBlockSize;

    int MAX_GT_NUM;
    int MAX_GT_SIZE;

    char* inputPtr;
    char* queiryPtr;

    char* inptTailPtr;
    
};

#endif