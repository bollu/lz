add_mlir_dialect_library(MLIRHask
        HaskCanonicalization.cpp
        HaskDialect.cpp
        HaskOps.cpp
        LeanLowering.cpp
        WorkerWrapperPass.cpp
        HaskLowering.cpp
        HaskLazify.cpp
	HaskFuseRefcount.cpp
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Hask
        DEPENDS
        MLIRHaskOpsIncGen
        LINK_LIBS PUBLIC MLIRIR
)
