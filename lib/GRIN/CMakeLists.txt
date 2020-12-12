add_mlir_dialect_library(MLIRGRIN
        GRINDialect.cpp
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/GRIN
        DEPENDS
        MLIRGRINOpsIncGen
	LINK_LIBS PUBLIC
	MLIRIR
	)
