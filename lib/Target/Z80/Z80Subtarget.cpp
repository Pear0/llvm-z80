//===- Z80Subtarget.cpp - Z80 Subtarget Information ---------------*- C++ -*-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the Z80 specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#include "Z80Subtarget.h"
#include "Z80.h"
#include "llvm/ADT/Triple.h"
#include "llvm/ADT/StringRef.h"


#define DEBUG_TYPE "unicode"

#define GET_SUBTARGETINFO_TARGET_DESC
#define GET_SUBTARGETINFO_CTOR
#include "Z80GenSubtargetInfo.inc"

using namespace llvm;

Z80Subtarget::Z80Subtarget(const Triple &TT, StringRef CPU,
                 StringRef FS, TargetMachine &TM) : 
  Z80GenSubtargetInfo(TT, CPU, FS) {
    
    
    
}
