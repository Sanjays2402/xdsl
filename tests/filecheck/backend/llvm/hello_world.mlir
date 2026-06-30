// RUN: xdsl-opt -t llvm %s | filecheck %s

builtin.module {
  llvm.mlir.global internal constant @hello_str("Hello, World!\0A\00") {addr_space = 0 : i32} : !llvm.array<15 x i8>

  llvm.func @puts(!llvm.ptr)

  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @hello_str : !llvm.ptr
    llvm.call @puts(%0) : (!llvm.ptr) -> ()
    %ret = llvm.mlir.constant(0 : i32) : i32
    llvm.return %ret : i32
  }
}

// CHECK: @"hello_str" = internal constant [15 x i8] c"Hello, World!\0a\00"
// CHECK: declare void @"puts"(ptr {{.*}})
// CHECK: define i32 @"main"()
// CHECK:   call ccc void @"puts"([15 x i8]* @"hello_str")
// CHECK:   ret i32 0
