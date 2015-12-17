//===- Z80RegisterInfo.td - Describe the Z80 Register Info ----*- tblgen -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Declaration that describes the Z80 register file
//===----------------------------------------------------------------------===//

class Z80Reg<string n, bits<16> Enc = 0, int Cost = 0>
  : Register<n> {
  let Namespace  = "Z80";
  let HWEncoding = Enc;
  let CostPerUse = Cost;
}

class Z80SubRegIndex<int size, int offset = 0> : SubRegIndex<size, offset> {
  let Namespace = "Z80";
}

def subreg_hi : Z80SubRegIndex<8, 8>;
def subreg_lo : Z80SubRegIndex<8, 0>;

class Z80RegWithSubRegs<string n, bits<16> Enc = 0, list<Register> subregs = [], int Cost = 0>
  : Z80Reg<n, Enc, Cost> {
  let SubRegs = subregs;
  let SubRegIndices = [subreg_hi, subreg_lo];
  let CoveredBySubRegs = 1;
}

//32 bit
def subreg32_hi : Z80SubRegIndex<16, 16>;
def subreg32_lo : Z80SubRegIndex<16, 0>;

//32 bit divided into 8 bit regs
def subreg32_hi_hi : Z80SubRegIndex<8, 24>;
def subreg32_hi_lo : Z80SubRegIndex<8, 16>;
def subreg32_lo_hi : Z80SubRegIndex<8, 8>;
def subreg32_lo_lo : Z80SubRegIndex<8, 0>;

class Z80Reg32WithSubRegs<string n, bits<16> Enc = 0, list<Register> subregs = [], int Cost = 0>
  : Z80Reg<n, Enc, Cost> {
  let SubRegs = subregs;
  let SubRegIndices = [subreg32_hi, subreg32_lo];
  let CoveredBySubRegs = 1;
}

//64 bit
def subreg64_highest : Z80SubRegIndex<16, 48>;
def subreg64_high    : Z80SubRegIndex<16, 32>;
def subreg64_low     : Z80SubRegIndex<16, 16>;
def subreg64_lowest  : Z80SubRegIndex<16, 0>;

//64 bit divided into 8 bit regs
def subreg64_highest_hi : Z80SubRegIndex<8, 56>;
def subreg64_highest_lo : Z80SubRegIndex<8, 48>;
def subreg64_high_hi    : Z80SubRegIndex<8, 40>;
def subreg64_high_lo    : Z80SubRegIndex<8, 32>;
def subreg64_low_hi     : Z80SubRegIndex<8, 24>;
def subreg64_low_lo     : Z80SubRegIndex<8, 16>;
def subreg64_lowest_hi  : Z80SubRegIndex<8, 8>;
def subreg64_lowest_lo  : Z80SubRegIndex<8, 0>;

class Z80Reg64WithSubRegs<string n, bits<16> Enc = 0, list<Register> subregs = [], int Cost = 0>
  : Z80Reg<n, Enc, Cost> {
  let SubRegs = subregs;
  let SubRegIndices = [subreg64_highest, subreg64_high, subreg64_low, subreg64_lowest];
  let CoveredBySubRegs = 1;
}

class Z80Reg8Class<dag reglist>
  : RegisterClass<"Z80", [i8], 8, reglist> {
}

class Z80Reg16Class<dag reglist>
  : RegisterClass<"Z80", [i16], 8, reglist> {
}


class Z80Reg32Class<dag reglist>
  : RegisterClass<"Z80", [i32, f32], 8, reglist> {
}

class Z80Reg64Class<dag reglist>
  : RegisterClass<"Z80", [i64, f64], 8, reglist> {
}

//===----------------------------------------------------------------------===//
//  Registers
//===----------------------------------------------------------------------===//

// 8 bit registers
def A : Z80Reg<"a", 7>, DwarfRegNum<[0]>;
def B : Z80Reg<"b", 0>, DwarfRegNum<[1]>;
def C : Z80Reg<"c", 1>, DwarfRegNum<[2]>;
def D : Z80Reg<"d", 2>, DwarfRegNum<[3]>;
def E : Z80Reg<"e", 3>, DwarfRegNum<[4]>;
def H : Z80Reg<"h", 4>, DwarfRegNum<[5]>;
def L : Z80Reg<"l", 5>, DwarfRegNum<[6]>;
def XH : Z80Reg<"xh", 4, 1>, DwarfRegNum<[7]>;
def XL : Z80Reg<"xl", 5, 1>, DwarfRegNum<[8]>;
def YH : Z80Reg<"yh", 4, 1>, DwarfRegNum<[9]>;
def YL : Z80Reg<"yl", 5, 1>, DwarfRegNum<[10]>;

// Flags register
def FLAGS : Z80Reg<"f">, DwarfRegNum<[11]>;

// 16 bit registers
def BC : Z80RegWithSubRegs<"bc", 0, [B, C]>, DwarfRegNum<[20]>;
def DE : Z80RegWithSubRegs<"de", 1, [D, E]>, DwarfRegNum<[21]>;
def HL : Z80RegWithSubRegs<"hl", 2, [H, L]>, DwarfRegNum<[22]>;
def AF : Z80RegWithSubRegs<"af", 3, [A, FLAGS]>, DwarfRegNum<[23]>;
def IX : Z80RegWithSubRegs<"ix", 2, [XH, XL], 1>, DwarfRegNum<[24]>;
def IY : Z80RegWithSubRegs<"iy", 2, [YH, YL], 1>, DwarfRegNum<[25]>;

def SP : Z80Reg<"sp">, DwarfRegNum<[26]>;
def PC : Z80Reg<"pc">, DwarfRegNum<[27]>;

//32 bit composite registers
def C32A : Z80Reg32WithSubRegs<"bcde", 0, [BC, DE], 2>, DwarfRegNum<[30]>;
def C32B : Z80Reg32WithSubRegs<"hlix", 0, [HL, IX], 3>, DwarfRegNum<[31]>;

//64 bit composite register
def C64 : Z80Reg64WithSubRegs<"bcdehlix", 0, [BC, DE, HL, IX], 4>, DwarfRegNum<[40]>;

//Register classes
def GR8  : Z80Reg8Class<(add A, B, C, D, E, H, L, XH, XL)>;
def GR16 : Z80Reg16Class<(add BC, DE, HL, IX, IY)>;
def BR16 : Z80Reg16Class<(add BC, DE, HL, IX)>;
def IR16 : Z80Reg16Class<(add IX, IY)>;

def EXR16 : Z80Reg16Class<(add HL, DE)>;

//Composite register classes
def GR32 : RegisterClass<"Z80", [i32, f32], 8, (add C32A, C32B)>;
def GR64 : RegisterClass<"Z80", [i64, f64], 8, (add C64)>;
