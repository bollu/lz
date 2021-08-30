// Check that rgn can be CSE'd.
// RUN: hask-opt -allow-unregistered-dialect --rgn-opt %s  | FileCheck %s
// This tests CSE on regions.

func @main() {
	%x = "rgn.val" () ({
		%c = constant 42 : i32
		"rgn.return" (%c) : (i32) -> ()
	}) : () -> (i32)

	%y = "rgn.val" () ({
		%c = constant 42 : i32
		"rgn.return" (%c)  : (i32) -> ()
	}) : () -> (i32)

	"block.block" (%x, %y)  : (i32, i32) -> ()
	return
}