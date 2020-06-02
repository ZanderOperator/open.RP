/*

	By adri1 	15/05/2015
	For TDEditor 1.15+

*/

enum TDE_TD_STRUCT
{
	TDE_IsValidTextDraw,
	Text:TDE_TextDrawID,
	TDE_TextDrawText[800],
	Float:TDE_TextDrawPosX,
	Float:TDE_TextDrawPosY,
	Float:TDE_TextDrawLetterX,
	Float:TDE_TextDrawLetterY,
	Float:TDE_TextDrawTextX,
	Float:TDE_TextDrawTextY,
	TDE_TextDrawAlignmentV,
	TDE_TextDrawOutline,
	TDE_TextDrawShadow,
	TDE_TextDrawModelid,
	Float:TDE_TextDrawRotX,
	Float:TDE_TextDrawRotY,
	Float:TDE_TextDrawRotZ,
	Float:TDE_TextDrawZoom,
	TDE_TextDrawSelectable,
	TDE_TextDrawColorV,
	TDE_TextDrawBGColor,
	TDE_TextDrawUseBoxV,
	TDE_TextDrawBoxColorV,
	TDE_TextDrawVehCol1,
	TDE_TextDrawVehCol2,
	TDE_TextDrawFontV,
	TDE_Proportional
};

new TDE_TextDrawInfo[500][TDE_TD_STRUCT];


TDE_TextDrawCreate(&Text:textdraw, Float:x, Float:y, text[])
{
	textdraw = TextDrawCreate(x, y, text);
	TDE_TextDrawInfo[_:textdraw][TDE_IsValidTextDraw]		= 1;
	TDE_TextDrawInfo[_:textdraw][TDE_TextDrawPosX]			= x;
	TDE_TextDrawInfo[_:textdraw][TDE_TextDrawPosY]			= y;
	format(TDE_TextDrawInfo[_:textdraw][TDE_TextDrawText], 800, "%s", text);
	return 1;
}

TDE_TextDrawLetterSize(Text:text, Float:x, Float:y)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawLetterSize(text, x, y);
    TDE_TextDrawInfo[_:text][TDE_TextDrawLetterX]			= x;
	TDE_TextDrawInfo[_:text][TDE_TextDrawLetterY]			= y;
	return 1;
}

TDE_TextDrawAlignment(Text:text, alignment)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawAlignment(text, alignment);
    TDE_TextDrawInfo[_:text][TDE_TextDrawAlignmentV]		= alignment;
	return 1;
}

TDE_TextDrawColor(Text:text, color)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawColor(text, color);
    TDE_TextDrawInfo[_:text][TDE_TextDrawColorV]			= color;
	return 1;
}

TDE_TextDrawUseBox(Text:text, use)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawUseBox(text, use);
    TDE_TextDrawInfo[_:text][TDE_TextDrawUseBoxV]			= use;
	return 1;
}

TDE_TextDrawSetShadow(Text:text, size)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetShadow(text, size);
    TDE_TextDrawInfo[_:text][TDE_TextDrawShadow]			= size;
	return 1;
}

TDE_TextDrawSetOutline(Text:text, size)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetOutline(text, size);
    TDE_TextDrawInfo[_:text][TDE_TextDrawOutline]			= size;
	return 1;
}

TDE_TextDrawBackgroundColor(Text:text, color)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawBackgroundColor(text, color);
    TDE_TextDrawInfo[_:text][TDE_TextDrawBGColor]			= color;
	return 1;
}

TDE_TextDrawFont(Text:text, font)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawFont(text, font);
    TDE_TextDrawInfo[_:text][TDE_TextDrawFontV]				= font;
	return 1;
}

TDE_TextDrawSetProportional(Text:text, set)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetProportional(text, set);
    TDE_TextDrawInfo[_:text][TDE_Proportional]				= set;
	return 1;
}

TDE_TextDrawTextSize(Text:text, Float:x, Float:y)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawTextSize(text, x, y);
    TDE_TextDrawInfo[_:text][TDE_TextDrawTextX]				= x;
    TDE_TextDrawInfo[_:text][TDE_TextDrawTextY]				= y;
    return 1;
}

TDE_TextDrawSetPreviewModel(Text:text, modelindex)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetPreviewModel(text, modelindex);
    TDE_TextDrawInfo[_:text][TDE_TextDrawModelid]			= modelindex;
	return 1;
}

TDE_TextDrawSetPreviewRot(Text:text, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetPreviewRot(text, fRotX, fRotY, fRotZ, fZoom);
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotX]				= fRotX;
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotY]				= fRotY;
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotZ]				= fRotZ;
    TDE_TextDrawInfo[_:text][TDE_TextDrawZoom]				= fZoom;
	return 1;
}

TDE_TextDrawSetPreviewVehCol(Text:text, color1, color2)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetPreviewVehCol(text, color1, color2);
    TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol1]			= color1;
    TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol2]			= color2;
	return 1;
}

TDE_TextDrawSetString(Text:text, string[])
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetString(text, string);
    format(TDE_TextDrawInfo[_:text][TDE_TextDrawText], 800, "%s", string);
	return 1;
}

TDE_TextDrawSetSelectable(Text:text, set)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawSetSelectable(text, set);
    TDE_TextDrawInfo[_:text][TDE_TextDrawSelectable]		= set;
	return 1;
}

TDE_TextDrawBoxColor(Text:text, color)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
    TextDrawBoxColor(text, color);
    TDE_TextDrawInfo[_:text][TDE_TextDrawBoxColorV]			= color;
	return 1;
}

TDE_TextDrawDestroy(Text:text)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
	if(TDE_TextDrawInfo[_:text][TDE_IsValidTextDraw] == 0) return 1;
    TextDrawDestroy(text);
    TDE_TextDrawInfo[_:text][TDE_IsValidTextDraw]			= 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawID]                = Text:INVALID_TEXT_DRAW;
    format(TDE_TextDrawInfo[_:text][TDE_TextDrawText], 800, "");
    TDE_TextDrawInfo[_:text][TDE_TextDrawPosX]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawPosY]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawLetterX]           = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawLetterY]           = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawTextX]             = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawTextY]             = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawAlignmentV]        = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawOutline]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawShadow]            = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawModelid]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotX]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotY]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawRotZ]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawZoom]              = 0.0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawSelectable]        = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawColorV]            = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawBGColor]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawUseBoxV]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawBoxColorV]         = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol1]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol2]           = 0;
    TDE_TextDrawInfo[_:text][TDE_TextDrawFontV]             = 0;
    TDE_TextDrawInfo[_:text][TDE_Proportional]              = 0;
	return 1;
}

#define TDE_TextDrawShowForPlayer   						TextDrawShowForPlayer
#define TDE_TextDrawHideForPlayer   						TextDrawHideForPlayer



/*                                          */



TDE_TextDrawSetPos(Text:text, Float:x, Float:y)
{
    if(_:text > sizeof(TDE_TextDrawInfo)) return 1;
	TDE_TextDrawInfo[_:text][TDE_TextDrawPosX] 				= x;
	TDE_TextDrawInfo[_:text][TDE_TextDrawPosY] 				= y;
	TDE_UpdateTextDraw(text);
	return 1;
}

TDE_TextDrawGetPos(Text:text, &Float:x, &Float:y)
{
	x 														= TDE_TextDrawInfo[_:text][TDE_TextDrawPosX];
	y 														= TDE_TextDrawInfo[_:text][TDE_TextDrawPosY];
	return 1;
}

TDE_TextDrawGetFontSize(Text:text, &Float:x, &Float:y)
{
    x 														= TDE_TextDrawInfo[_:text][TDE_TextDrawLetterX];
	y 														= TDE_TextDrawInfo[_:text][TDE_TextDrawLetterY];
	return 1;
}

#define TDE_TextDrawGetFont(%0)             				TDE_TextDrawInfo[_:%0][TDE_TextDrawFontV]
#define TDE_TextDrawIsBox(%0)                               TDE_TextDrawInfo[_:%0][TDE_TextDrawUseBoxV]
#define TDE_TextDrawGetAlignment(%0)                        TDE_TextDrawInfo[_:%0][TDE_TextDrawAlignmentV]
#define TDE_TextDrawIsProportional(%0)                      TDE_TextDrawInfo[_:%0][TDE_Proportional]

TDE_UpdateTextDraw(&Text:text)
{
	TextDrawDestroy(text);
	text = TextDrawCreate(TDE_TextDrawInfo[_:text][TDE_TextDrawPosX], TDE_TextDrawInfo[_:text][TDE_TextDrawPosY], TDE_TextDrawInfo[_:text][TDE_TextDrawText]);
	TextDrawLetterSize(text, TDE_TextDrawInfo[_:text][TDE_TextDrawLetterX], TDE_TextDrawInfo[_:text][TDE_TextDrawLetterY]);
	TextDrawAlignment(text, TDE_TextDrawInfo[_:text][TDE_TextDrawAlignmentV]);
	TextDrawColor(text, TDE_TextDrawInfo[_:text][TDE_TextDrawColorV]);
	TextDrawUseBox(text, TDE_TextDrawInfo[_:text][TDE_TextDrawUseBoxV]);
	TextDrawSetShadow(text, TDE_TextDrawInfo[_:text][TDE_TextDrawShadow]);
	TextDrawSetOutline(text, TDE_TextDrawInfo[_:text][TDE_TextDrawOutline]);
	TextDrawBackgroundColor(text, TDE_TextDrawInfo[_:text][TDE_TextDrawBGColor]);
	TextDrawFont(text, TDE_TextDrawInfo[_:text][TDE_TextDrawFontV]);
	TextDrawSetProportional(text, TDE_TextDrawInfo[_:text][TDE_Proportional]);
	TextDrawTextSize(text, TDE_TextDrawInfo[_:text][TDE_TextDrawTextX], TDE_TextDrawInfo[_:text][TDE_TextDrawTextY]);
	TextDrawSetPreviewModel(text, TDE_TextDrawInfo[_:text][TDE_TextDrawModelid]);
	TextDrawSetPreviewRot(text, TDE_TextDrawInfo[_:text][TDE_TextDrawRotX], TDE_TextDrawInfo[_:text][TDE_TextDrawRotY], TDE_TextDrawInfo[_:text][TDE_TextDrawRotZ], TDE_TextDrawInfo[_:text][TDE_TextDrawZoom]);
    TextDrawSetPreviewVehCol(text, TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol1], TDE_TextDrawInfo[_:text][TDE_TextDrawVehCol2]);
    TextDrawSetSelectable(text, TDE_TextDrawInfo[_:text][TDE_TextDrawSelectable]);
    TextDrawBoxColor(text, TDE_TextDrawInfo[_:text][TDE_TextDrawBoxColorV]);
	return 1;
}

/*

	By adri1 	15/05/2015
	For TDEditor 1.15+

*/
