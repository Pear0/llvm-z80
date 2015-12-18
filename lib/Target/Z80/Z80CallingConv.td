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
  CCIfType<[i8], CCAssignToReg<[A, B, C, D, E, H, L]>>,
  
  // i16 are returned in register HL
  CCIfType<[i16], CCAssignToReg<[HL, BC, DE, IY]>>,
  
  // i32 are returned in register C32A
  CCIfType<[i32], CCAssignToReg<[C32A]>>,
  
  // f32 are returned in register C32A
  CCIfType<[f32], CCAssignToReg<[C32A]>>,
  
  // i64 are returned in register C64
  CCIfType<[i64], CCAssignToReg<[C64]>>,
  
  // f64 are returned in register C64
  CCIfType<[f64], CCAssignToReg<[C64]>>
  
]>;

//===----------------------------------------------------------------------===//
// Z80 Argument Calling Conventions
//===----------------------------------------------------------------------===//

def CC_Z80 : CallingConv<[
  // Assign i8 arguments in registers then stack slots
  CCIfType<[i8], CCAssignToReg<[A, H, L]>>,
  CCIfType<[i8], CCAssignToStack<1, 1>>,

  // Assign i16 arguments in registers then stack slots
  CCIfType<[i16], CCAssignToReg<[HL, BC, DE, IY]>>,
  CCIfType<[i16], CCAssignToStack<2, 1>>,
  
  // Assign i32 arguments in registers then stack slots
  CCIfType<[i32], CCAssignToReg<[C32A]>>,
  CCIfType<[i32], CCAssignToStack<4, 1>>,
  
  // Assign f32 arguments in registers then stack slots
  CCIfType<[f32], CCAssignToReg<[C32A]>>,
  CCIfType<[f32], CCAssignToStack<4, 1>>,
  
  // Assign i64 arguments in registers then stack slots
  CCIfType<[i64], CCAssignToReg<[C64]>>,
  CCIfType<[i64], CCAssignToStack<8, 1>>,
  
  // Assign f64 arguments in registers then stack slots
  CCIfType<[f64], CCAssignToReg<[C64]>>,
  CCIfType<[f64], CCAssignToStack<8, 1>>
  
]>;

//===----------------------------------------------------------------------===//
// Callee-saved Registers.
//===----------------------------------------------------------------------===//

def CSR_NoRegs : CalleeSavedRegs<(add)>;

//I don't like this solution for doubles but I think it's necessary
//def CSR_16 : CalleeSavedRegs<(add BC, DE, IX, IY)>;
def CSR_16 : CalleeSavedRegs<(add IX)>;