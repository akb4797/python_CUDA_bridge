#include <iostream>
#include <boost/python.hpp>

#include "../CUDA/cudacode.h"


 void greet()
{
   printf("\nCUDA Greet interface");
   cudaInterface cudaObj;
   cudaObj.testBenchDriver();

}

void sendToCUDA(char* inpParam, int len)
{
   for(int itr=0; itr<len; itr++)
      printf("\nCUDA sent Val : %c",inpParam[itr]);
}


BOOST_PYTHON_MODULE(projectLibs)
{
    using namespace boost::python;
    def("greet", greet);
    def("sendToCUDA",sendToCUDA);
}

int main()
{
    printf("\nMain..");
  	cudaInterface cudaObj;
    cudaObj.testBenchDriver();
}
