project(Tests)

set(CMAKE_C_FLAGS "-fprofile-instr-generate -Xclang -fprofile-instrument=llvm")
set(CMAKE_CXX_FLAGS "-fprofile-instr-generate -Xclang -fprofile-instrument=llvm")

add_executable(multiple_ifs_in_a_row multiple_ifs_in_a_row.c)
