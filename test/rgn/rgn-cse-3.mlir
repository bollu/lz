// Check that rgn can be CSE'd.
// RUN: hask-opt -allow-unregistered-dialect --rgn-cse %s  | FileCheck %s
// This tests CSE on regions.
// Should not CSE since rgn x has more instructions.
// CHECK: "block.block"(%0, %1) : (i32, i32) -> ()

func @main() {
	%x = "rgn.val" () ({
		%c = constant 42 : i32
		%d = constant 100 : i32
		"rgn.return" (%c) : (i32) -> ()
	}) : () -> (i32)

	%y = "rgn.val" () ({
		%c = constant 42 : i32
		"rgn.return" (%c)  : (i32) -> ()
	}) : () -> (i32)

	"block.block" (%x, %y)  : (i32, i32) -> ()
	return
}