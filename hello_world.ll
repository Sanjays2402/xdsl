; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@hello_str = internal constant [15 x i8] c"Hello, World!\0A\00"

declare void @puts(ptr)

define i32 @main() {
  call void @puts(ptr @hello_str)
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
