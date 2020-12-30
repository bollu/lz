//===- HaskDialect.td - Hask dialect -----------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef Unification_DIALECT
#define Unification_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Unification dialect definition.
//===----------------------------------------------------------------------===//

def Unification_Dialect : Dialect {
    let name = "unification";
    let cppNamespace = "unification";
}

//===----------------------------------------------------------------------===//
// Base standalone operation definition.
//===----------------------------------------------------------------------===//

class Unification_Op<string mnemonic, list<OpTrait> traits = []> :
        Op<Unification_Dialect, mnemonic, traits>;

#endif // Unification_DIALECT
