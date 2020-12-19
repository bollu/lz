//===- HaskDialect.td - Hask dialect -----------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef Pointer_DIALECT
#define Pointer_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Pointer dialect definition.
//===----------------------------------------------------------------------===//

def Pointer_Dialect : Dialect {
    let name = "ptr";
    let cppNamespace = "ptr";
}

//===----------------------------------------------------------------------===//
// Base standalone operation definition.
//===----------------------------------------------------------------------===//

class Pointer_Op<string mnemonic, list<OpTrait> traits = []> :
        Op<Pointer_Dialect, mnemonic, traits>;

#endif // Pointer_DIALECT
