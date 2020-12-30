add_mlir_dialect_library(MLIRUnification
        UnificationDialect.cpp
        UnificationOps.cpp
                
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Unification

        DEPENDS
        MLIRUnificationOpsIncGen
	
        LINK_LIBS PUBLIC
	MLIRIR
	)
