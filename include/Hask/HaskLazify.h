#pragma once
#include "./Runtime.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"

std::unique_ptr<mlir::Pass> createLzLazifyPass();
void registerLzLazifyPass();
