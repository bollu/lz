add_mlir_dialect_library(MLIRlambdapure
    Dialect.cpp
    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/include/lambdapure
    DEPENDS
    LambdapureOpsIncGen
    )
