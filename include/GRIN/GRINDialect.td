//===- HaskDialect.td - Hask dialect -----------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef GRIN_DIALECT
#define GRIN_DIALECT
include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// GRIN dialect definition.
//===----------------------------------------------------------------------===//

def GRIN_Dialect : Dialect {
    let name = "grin";
    let cppNamespace = "grin";
}

//===----------------------------------------------------------------------===//
// Base standalone operation definition.
//===----------------------------------------------------------------------===//

class GRIN_Op<string mnemonic, list<OpTrait> traits = []> :
        Op<GRIN_Dialect, mnemonic, traits>;

#endif // GRIN_DIALECT
