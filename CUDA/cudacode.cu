
#include "helper.h"
#include "cudacode.h"


__global__ void findQueryMatch_GPU(char* inpArray, char* queiryArray, int* retVal, int sizeInput)
{
	//printf("blockIdx.x:%d * blockDim.x:%d + threadIdx.x:%d \n", blockIdx.x, blockDim.x, threadIdx.x);

    int itr = (blockIdx.x* blockDim.x + threadIdx.x);
   // printf("\nitr : %d", itr);

    if((itr < sizeInput) && (itr%2 ==0))
    {     
        int xorVal = (inpArray[itr] ^ queiryArray[itr%2] || inpArray[itr+1] ^ queiryArray[(itr+1)%2]);
        //printf("\nXor param : %d, %d", (valOne),valTwo);
    /*
        printf("\nInp : %c, %c", inpArray[itr],inpArray[itr+1]);
        printf("\nQuer : %c, %c", queiryArray[itr%2], queiryArray[(itr%2)+1]);
        printf("\nXor : %d", xorVal);
    */

        if(xorVal == 0)
        {
            *retVal = 1;
            //printf("\nretVal : %d", *retVal);
        }


    }
    
 

}


cudaInterface::cudaInterface()
{

	cudaDeviceProp	prop;
	int count;
	HANDLE_ERROR( cudaGetDeviceCount( &count ) );
	
	for (int i=0; i< count; i++) {
		HANDLE_ERROR( cudaGetDeviceProperties( &prop, i ) );
		std::cout << "GPU Device name : " << prop.name << std::endl;
		std::cout << "totalGlobalMem : " << prop.totalGlobalMem << std::endl;
		std::cout << "sharedMemPerBlock : " << prop.sharedMemPerBlock << std::endl;

		printf( "Max thread dimensions:	(%d, %d, %d)\n",prop.maxThreadsDim[0], prop.maxThreadsDim[1],prop.maxThreadsDim[2]);
		printf( "Max grid dimensions:	(%d, %d, %d)\n",prop.maxGridSize[0], prop.maxGridSize[1],prop.maxGridSize[2] );

	}

    queiryBlockSize = 2;
    inputBlockSize = queiryBlockSize;

    MAX_GT_NUM = 4;
    MAX_GT_SIZE = 2;

    inputPtr = new char[MAX_GT_NUM*MAX_GT_SIZE];
    queiryPtr = new char[MAX_GT_SIZE];

    inptTailPtr = inputPtr;

	//cudaSetDevice(0);
}

void cudaInterface::checkMatch()
{
    printf("\nCUDA driver call..");
    int matchFoundFlag= 0;

    queiryBlockSize = 2;
    inputBlockSize = 4;

    char inputArray[] = {'a','b','c','d'};
    char queiryArray[] = {'c','d'};



	char* d_input;
	char* d_query;
    int* ptr;

	cudaMalloc((void **)&d_input,inputBlockSize*sizeof(char)) ;
	cudaMalloc((void**)&d_query,queiryBlockSize*sizeof(char)) ;
    cudaMalloc((void**)&ptr, sizeof(int));

	cudaMemcpy(d_input, inputArray, inputBlockSize*sizeof(char), cudaMemcpyHostToDevice);
	cudaMemcpy(d_query, queiryArray, queiryBlockSize*sizeof(char), cudaMemcpyHostToDevice);
    cudaMemcpy(ptr, &matchFoundFlag, sizeof(int), cudaMemcpyHostToDevice);


    findQueryMatch_GPU <<<1,1000 >>> (d_input, d_query, ptr, inputBlockSize);

    cudaMemcpy(&matchFoundFlag, ptr, sizeof(int), cudaMemcpyDeviceToHost);

    cudaDeviceSynchronize();

    if(matchFoundFlag)
    {
        printf(" : Match");
    }
    else
    {
        printf(" : No Match");
    }
	//cudaMemcpy(outArray, d_output, 5*sizeof(int), cudaMemcpyDeviceToHost);
	

	cudaFree(d_input);
	cudaFree(d_query);
    cudaFree(ptr);

}

int cudaInterface::searchFor(char* quieryString)
{
    /*
    Returns : 
    1 : Match found
    0 : NO match found
    */
    int matchFoundFlag= 0;
    int retVal = 0;

    queiryBlockSize = MAX_GT_SIZE;
    inputBlockSize = MAX_GT_NUM*MAX_GT_SIZE;

    
    

    //Skip check if cold start
    if(inptTailPtr == inputPtr)
    {
        printf("\nInitiating Memory\n");

        inptTailPtr += MAX_GT_SIZE;
        strcpy(inputPtr, quieryString);
        retVal = 1;
    }
    else
    {
        //printf("\nScanning Memory");
        strcpy(queiryPtr, quieryString);
        inptTailPtr += MAX_GT_SIZE;


        char* d_input;
        char* d_query;
        int* ptr;
    
        cudaMalloc((void **)&d_input,inputBlockSize*sizeof(char)) ;
        cudaMalloc((void**)&d_query,queiryBlockSize*sizeof(char)) ;
        cudaMalloc((void**)&ptr, sizeof(int));
    
        cudaMemcpy(d_input, inputPtr, inputBlockSize*sizeof(char), cudaMemcpyHostToDevice);
        cudaMemcpy(d_query, queiryPtr, queiryBlockSize*sizeof(char), cudaMemcpyHostToDevice);
        cudaMemcpy(ptr, &matchFoundFlag, sizeof(int), cudaMemcpyHostToDevice);
    
    
        findQueryMatch_GPU <<<1,1000 >>> (d_input, d_query, ptr, inputBlockSize);
    
        cudaMemcpy(&matchFoundFlag, ptr, sizeof(int), cudaMemcpyDeviceToHost);
    
        cudaDeviceSynchronize();
    
        if(matchFoundFlag)
        {
            printf(" : Match\n");
            retVal = 1;
        }
        else
        {
            printf(" : No Match\n");
            strcpy(inptTailPtr, quieryString);

        }
        //cudaMemcpy(outArray, d_output, 5*sizeof(int), cudaMemcpyDeviceToHost);
        
    
        cudaFree(d_input);
        cudaFree(d_query);
        cudaFree(ptr);
    
    }

    return retVal;

 
}

void cudaInterface::testBenchDriver()
{
#if 1
    std::cout << "TEST BENCH" << std::endl;
    std::string testString = "ab";

    char testArrayOne[] =  {'a','b'};
    char testArrayTwo[] =  {'d','e'};
    char testArrayFour[] =  {'x','y'};

    int retVal = this->searchFor(testArrayOne);
    retVal = this->searchFor(testArrayTwo);
    retVal = this->searchFor(testArrayOne);
    retVal = this->searchFor(testArrayTwo);
    retVal = this->searchFor(testArrayFour);
    std::cout << "EXPECTED OUTPUT : NM, M, M, NM"<< std::endl;
#endif
}