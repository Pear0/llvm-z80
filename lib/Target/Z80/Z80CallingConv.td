//===-- Z80CallingConv.td - Z80 Calling Conventions --------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the Z80 architectures.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Z80 Return Value Calling Convention
//===----------------------------------------------------------------------===//

def RetCC_Z80 : CallingConv<[
  // i8 are returned in register A
  CCIfType<[i8], CCAssignToReg<[A]>>,
  
  // Throw other i8 arguments onto the stack
  CCIfType<[i8], CCAssignToStack<1, 1>>,
  
  // i16 are returned in register HL
  CCIfType<[i16], CCAssignToReg<[HL]>>,
  
  // Throw other i8 arguments onto the stack
  CCIfType<[i16], CCAssignToStack<2, 1>>,
  
  // i32 are thrown on the stack
  CCIfType<[i32], CCAssignToStack<4, 1>>,
  
  // f32 are thrown on the stack
  CCIfType<[f32], CCAssignToStack<4, 1>>,

  // f64 are thrown on the stack
  CCIfType<[f64], CCAssignToStack<8, 1>>
]>;

//===----------------------------------------------------------------------===//
// Z80 Argument Calling Conventions
//===----------------------------------------------------------------------===//

def CC_Z80 : CallingConv<[
  // Assign i8 arguments in registers
  CCIfType<[i8], CCAssignToReg<[A, H, L]>>,

  // Assign other i8 arguments to stack slots
  CCIfType<[i8], CCAssignToStack<1, 1>>,

  // Assign i16 arguments in registers
  CCIfType<[i16], CCAssignToReg<[HL]>>,

  // Assign other i16 arguments to stack slots
  CCIfType<[i16], CCAssignToStack<2, 1>>,

  // i32 are thrown on the stack
  CCIfType<[i32], CCAssignToStack<4, 1>>,
  
  // f32 are thrown on the stack
  CCIfType<[f32], CCAssignToStack<4, 1>>,

  // f64 are thrown on the stack
  CCIfType<[f64], CCAssignToStack<8, 1>>
]>;

//===----------------------------------------------------------------------===//
// Callee-saved Registers.
//===----------------------------------------------------------------------===//

def CSR_NoRegs : CalleeSavedRegs<(add)>;

def CSR_16 : CalleeSavedRegs<(add BC, DE, IX, IY)>;
