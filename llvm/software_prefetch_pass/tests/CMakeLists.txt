add_executable(Test_Program test_program.cpp)

target_compile_options(Test_Program PRIVATE "-Xclang -load -Xclang /data/llvm-project/llvm/build/lib/libSWPrefetecherPass.so")