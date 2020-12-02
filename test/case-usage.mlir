// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: constructor(X 42)
// Test that a non-trivial use of a case works. So we don't just have:
// %x = case {.. ret }; return(%x)
// but we have %x = case { ... ret }; %y = nontrivial(%x)
module {
  func @main () -> !lz.value {
    %lit_43 = lz.make_i64(43)
    %case_val = lz.caseint %lit_43
                  [0 -> { ^entry(%ival: !lz.value):
                    lz.return %ival: !lz.value
                  }]
                  [@default -> { ^entry: // ... or here?
                    %lit_one = lz.make_i64(1)
                    %pred = lz.primop_sub(%lit_43, %lit_one)
                    lz.return %pred : !lz.value
                  }]

    %x = lz.construct(@X, %case_val:!lz.value)
    return %x : !lz.value
  }
}
