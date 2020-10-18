/*
	SA-MP rBits Include
	Copyright © 2011-2012 RyDeR`
*/

#if defined _Included_rBits
	#endinput
#else
	#define _Included_rBits
#endif

#define BIT_TAGS \
	{ Bit1, Bit2, Bit4, Bit8, Bit16 }
		
enum e_Bits {
	Bit1,
	Bit2,
	Bit4,
	Bit8,
	Bit16,
	Bit32
};

#define Bit1:%0<%1> \
	Bit1: %0[((%1) + 31) >>> _: Bit32]
	
#define	Bit1_Set(%0,%1,%2) \
	rBit_Set(%0, (%1), (%2), Bit1)
	
#define Bit1_Get(%0,%1) \
	rBit_Get(%0, (%1), Bit1)

#define Bit2:%0<%1> \
	Bit2: %0[((%1) + 15) >>> _: (Bit32 - Bit2)]
	
#define	Bit2_Set(%0,%1,%2) \
	rBit_Set(%0, (%1), (%2), Bit2)
	
#define Bit2_Get(%0,%1) \
	rBit_Get(%0, (%1), Bit2)

#define Bit4:%0<%1> \
	Bit4: %0[((%1) + 7) >>> _: (Bit32 - Bit4)]
	
#define	Bit4_Set(%0,%1,%2) \
	rBit_Set(%0, (%1), (%2), Bit4)
	
#define Bit4_Get(%0,%1) \
	rBit_Get(%0, (%1), Bit4)

#define Bit8:%0<%1> \
	Bit8: %0[(%1) char]
	
#define Bit8_Set(%0,%1,%2) \
	(_: %0{(%1)} = (%2))
	
#define Bit8_Get(%0,%1) \
	(_: %0{(%1)})
	
/*
#define Bit8:%0<%1> \
	Bit8: %0[((%1) + 3) >>> _: (Bit32 - Bit8)]
	
#define Bit8_Set(%0,%1,%2) \
	Bit_Set(%0, (%1), (%2), Bit8)
	
#define Bit8_Get(%0,%1) \
	Bit_Get(%0, (%1), Bit8)
*/

#define Bit16:%0<%1> \
	Bit16: %0[((%1) + 1) >>> _: (Bit32 - Bit16)]
	
#define	Bit16_Set(%0,%1,%2) \
	rBit_Set(%0, (%1), (%2), Bit16)
	
#define Bit16_Get(%0,%1) \
	rBit_Get(%0, (%1), Bit16)

stock rBit_Set(BIT_TAGS: abArray[], iIdx, const iValue, const e_Bits: iShift, const iSize = sizeof(abArray)) {
	new
		bVar = ((iIdx & ((1 << _: (Bit32 - iShift)) - 1)) << _: iShift),
		bLim = ((1 << (1 << _: iShift)) - 1)
	;
	iIdx = (iIdx >>> _: (Bit32 - iShift));
	
	if(!(-1 < iIdx < iSize)) {
		return 0;
	}
	(_: abArray[iIdx] &= ~(bLim << bVar));
	(_: abArray[iIdx] |= ((bLim & iValue) << bVar));
	
	return 1;
}

stock rBit_Get(BIT_TAGS: abArray[], iIdx, const e_Bits: iShift, const iSize = sizeof(abArray)) {
	new
		bVar = ((iIdx & ((1 << _: (Bit32 - iShift)) - 1)) << _: iShift),
		bLim = ((1 << (1 << _: iShift)) - 1)
	;
	iIdx = (iIdx >>> _: (Bit32 - iShift));
	
	if(!(-1 < iIdx < iSize)) {
		return 0;
	}
	return ((_: abArray[iIdx] >>> bVar) & bLim);
}
