set(CMAKE_SYSTEM_PROCESSOR Yeet)
set(CMAKE_SYSTEM_VERSION 1)

set(CMAKE_C_COMPILER_TARGET "${ZIG_TARGET}")
set(CMAKE_CXX_COMPILER_TARGET "${ZIG_TARGET}")

set(CMAKE_CROSSCOMPILING TRUE)

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_C_COMPILER "zig" "cc -target ${CMAKE_C_COMPILER_TARGET}")
set(CMAKE_CXX_COMPILER "zig" "c++ -target ${CMAKE_C_COMPILER_TARGET}")
