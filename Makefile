CC=g++
NVCC=nvcc
CFLAGS=-I/usr/include/python2.7 
CFLAGS_3=-I/usr/include/python3.5
CUDA_NVCC_FLAGS=--compiler-options -fPIC
HIDE_HW_DEPRECATIONS=-Wno-deprecated-gpu-targets



py2build:python/pythonInterface.cpp CUDA/cudacode.cu
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CFLAGS) -o cppApp python/pythonInterface.cpp CUDA/cudacode.cu -lboost_python -lpython2.7
	@echo "Built CPP binary"


	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS) -c python/pythonInterface.cpp  -o projectObj.o 
	@echo "Compiled python interface"
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS) -c CUDA/cudacode.cu  -o cudaObj.o 
	@echo "Compiled CUDA"
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS) -shared projectObj.o cudaObj.o  -o projectLibs.so -lboost_python -lpython2.7
	@echo "Linking modules"
	@echo "Built shared library"

py3build:python/pythonInterface.cpp CUDA/cudacode.cu
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CFLAGS_3) -o cppApp python/pythonInterface.cpp CUDA/cudacode.cu  -lboost_python
	@echo "Built CPP binary"


	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS_3) -c python/pythonInterface.cpp  -o projectObj.o 
	@echo "Compiled python interface"
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS_3) -c CUDA/cudacode.cu  -o cudaObj.o 
	@echo "Compiled CUDA"
	@$(NVCC) $(HIDE_HW_DEPRECATIONS) $(CUDA_NVCC_FLAGS) $(CFLAGS_3) -shared projectObj.o cudaObj.o  -o projectLibs.so  -lboost_python35
	@echo "Linking modules"
	@echo "Built shared library"



clean:
	 rm -rf *.o *.so *.out cppApp
	 @echo "Removed build files"