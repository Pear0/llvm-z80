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


enum AsmWriterFlavorZ80 {
  // Note: This numbering has to match the GCC assembler dialects for inline
  // asm alternatives to work right.
  Metal = 0, Knight = 1
};

static cl::opt<AsmWriterFlavorZ80>
AsmWriterFlavor("z80-asm-syntax", cl::init(Metal),
  cl::desc("Choose style of code to emit from z80 backend:"),
  cl::values(clEnumValN(Metal,   "metal",   "Emit Metal (bare) z80 assembly"),
             clEnumValN(Knight, "knight", "Emit KnightOS z80 assembly"),
             clEnumValEnd));

Z80MCAsmInfo::Z80MCAsmInfo(const Triple &TT)
{
    AssemblerDialect = (AsmWriterFlavor == Knight) ? 1 : 0;
    
    PointerSize = 2;
    CalleeSaveStackSlotSize = 2;
    
    SeparatorString = "\\";
    CommentString = ";";
    //GlobalPrefix = "C_";
    ZeroDirective = "\t.block\t";
    AscizDirective = "\t.asciiz\t"; //Note: asciiz not asciz 
    
    //SASS assembler uses db and dw in place of byte and short
    Data8bitsDirective = "\t.db\t";
    Data16bitsDirective = "\t.dw\t";
    Data32bitsDirective = NULL;
    Data64bitsDirective = NULL;
}
