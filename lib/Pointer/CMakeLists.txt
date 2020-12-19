add_mlir_dialect_library(MLIRPointer
        PointerDialect.cpp
        PointerOps.cpp
                
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Pointer

        DEPENDS
        MLIRPointerOpsIncGen
	
        LINK_LIBS PUBLIC
	MLIRIR
	)
