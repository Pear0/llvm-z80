//===-- Z80MCAsmInfo.cpp - Z80 asm properties -----------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declarations of the Z80MCAsmInfo properties.
//
//===----------------------------------------------------------------------===//

#include "Z80MCAsmInfo.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/CommandLine.h"
using namespace llvm;


enum AsmWriterFlavorTy {
  // Note: This numbering has to match the GCC assembler dialects for inline
  // asm alternatives to work right.
  Metal = 0, Knight = 1
};

static cl::opt<AsmWriterFlavorTy>
AsmWriterFlavor("z80-asm-syntax", cl::init(Metal),
  cl::desc("Choose style of code to emit from z80 backend:"),
  cl::values(clEnumValN(Metal,   "metal",   "Emit Metal (bare) z80 assembly"),
             clEnumValN(Knight, "knight", "Emit KnightOS z80 assembly"),
             clEnumValEnd));

Z80MCAsmInfo::Z80MCAsmInfo(StringRef TT)
{
    AssemblerDialect = AsmWriterFlavor;
}
