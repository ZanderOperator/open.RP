//Upload:http://forum.sa-mp.com/showthread.php?t=590770

/****************************************************************************************************
 *                                                                                                  *
 *                                        R G B A Conversion                                        *
 *                                                                                                  *
 * Copyright � 2014 - 2017 Abyss Morgan. All rights reserved.                                       *
 *                                                                                                  *
 * File Version: 1.1                                                                                *
 *                                                                                                  *
 * ShiftRGBAToHex(color,&red,&green,&blue,&alpha);                                                  *
 * ShiftHexToRGBA(&color,red=0,green=0,blue=0,alpha=0);                                             *
 * ShiftRGBAToRGB(color);                                                                           *
 * ShiftRGBToRGBA(color,alpha=0);                                                                   *
 * ShiftRGBToARGB(color,alpha=0);                                                                   *
 * ShiftRGBAToARGB(color);                                                                          *
 * ShiftARGBToRGBA(color);                                                                          *
 * GetRFromRGBA(color);                                                                             *
 * GetGFromRGBA(color);                                                                             *
 * GetBFromRGBA(color);                                                                             *
 * GetAFromRGBA(color);                                                                             *
 * GetRHexFromRGBA(color);                                                                          *
 * GetGHexFromRGBA(color);                                                                          *
 * GetBHexFromRGBA(color);                                                                          *
 * GetAHexFromRGBA(color);                                                                          *
 *                                                                                                  *
 ****************************************************************************************************/

#if defined _rgb_function
	#endinput
#endif
#define _rgb_function

//RGBA to Hex
stock ShiftRGBAToHex(color,&red,&green,&blue,&alpha){
	red = (color >>> 24);
	green = (color >>> 16 & 0xFF);
	blue = (color >>> 8 & 0xFF);
	alpha = (color & 0xFF);
}

//Hex to RGBA
stock ShiftHexToRGBA(&color,red=0,green=0,blue=0,alpha=0){
	color = (alpha & 0xFF) | ((blue & 0xFF) << 8) | ((green & 0xFF) << 16) | (red << 24);
}

//RGBA to RGB
stock ShiftRGBAToRGB(color){
	new r, g, b;
	r = (color >>> 24);
	g = (color >>> 16 & 0xFF);
	b = (color >>> 8 & 0xFF);
	color = (b & 0xFF) | ((g & 0xFF) << 8) | (r << 16);
	return color;
}

//RGB to RGBA
stock ShiftRGBToRGBA(color,alpha=0){
	new r, g, b;
	r = (color >>> 16 & 0xFF);
	g = (color >>> 8 & 0xFF);
	b = (color & 0xFF);
	color = (alpha & 0xFF) | ((b & 0xFF) << 8) | ((g & 0xFF) << 16) | (r << 24);
	return color;
}

//RGB to ARGB
stock ShiftRGBToARGB(color,alpha=0){
	new r, g, b;
	r = (color >>> 16 & 0xFF);
	g = (color >>> 8 & 0xFF);
	b = (color & 0xFF);
	color = (b & 0xFF) | ((g & 0xFF) << 8) | ((r & 0xFF) << 16) | (alpha << 24);
	return color;
}

//RGBA to ARGB
stock ShiftRGBAToARGB(color){
	new r, g, b, a;
	r = (color >>> 24);
	g = (color >>> 16 & 0xFF);
	b = (color >>> 8 & 0xFF);
	a = (color & 0xFF);
	color = (b & 0xFF) | ((g & 0xFF) << 8) | ((r & 0xFF) << 16) | (a << 24);
	return color;
}

// ARGB to RGBA
stock ShiftARGBToRGBA(color){
	new r, g, b, a;
	a = (color >>> 24);
	r = (color >>> 16 & 0xFF);
	g = (color >>> 8 & 0xFF);
	b = (color & 0xFF);
	color = (a & 0xFF) | ((b & 0xFF) << 8) | ((g & 0xFF) << 16) | (r << 24);
	return color;
}

// RGBA:0xFAB0A0FF R:0xFA000000
stock GetRFromRGBA(color){
	new r;
	r = (color >>> 24);
	color = (r << 24);
	return color;
}

// RGBA:0xFAB0A0FF G:0x00B00000
stock GetGFromRGBA(color){
	new g;
	g = (color >>> 16 & 0xFF);
	color = ((g & 0xFF) << 16);
	return color;
}

// RGBA:0xFAB0A0FF B:0x0000A000
stock GetBFromRGBA(color){
	new b;
	b = (color >>> 8 & 0xFF);
	color = ((b & 0xFF) << 8);
	return color;
}

// RGBA:0xFAB0A0FF A:0x000000FF
stock GetAFromRGBA(color){
	new a;
	a = (color & 0xFF);
	color = (a & 0xFF);
	return color;
}

// RGBA:0xFAB0A0FF R:0xFA
stock GetRHexFromRGBA(color){
	return (color >>> 24);
}

// RGBA:0xFAB0A0FF G:0xB0
stock GetGHexFromRGBA(color){
	return (color >>> 16 & 0xFF);
}

// RGBA:0xFAB0A0FF B:0xA0
stock GetBHexFromRGBA(color){
	return (color >>> 8 & 0xFF);
}

// RGBA:0xFAB0A0FF A:0xFF
stock GetAHexFromRGBA(color){
	return (color & 0xFF);
}