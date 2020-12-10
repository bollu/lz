// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: constructor(X 42)
// Test that a non-trivial use of a case works. So we don't just have:
// %x = case {.. ret }; return(%x)
// but we have %x = case { ... ret }; %y = nontrivial(%x)
module {
  func @main () -> !lz.value {
    %lit_43 = constant 43: i64
    %case_val = lz.caseint %lit_43
                  [0 -> { ^entry(%ival: i64):
                    lz.return %ival: i64
                  }]
                  [@default -> { ^entry: // ... or here?
                    %lit_one = constant 1 : i64
                    %pred = subi %lit_43, %lit_one : i64
                    lz.return %pred : i64
                  }]

    %x = lz.construct(@X, %case_val: i64)
    return %x : !lz.value
  }
}
