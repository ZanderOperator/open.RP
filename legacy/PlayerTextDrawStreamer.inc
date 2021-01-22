#include <YSI_Coding\y_hooks>

#if !defined LIMIT_OF_PLAYER_TEXT_DRAWS
	#define LIMIT_OF_PLAYER_TEXT_DRAWS 300
#endif

#if LIMIT_OF_PLAYER_TEXT_DRAWS < 1
	#error u stupid fk what r u doing
#endif

static stock _G(n, p) return (n >> (4 * p)) & 0xF;
static stock _S(&n, p, v) { n = n & ~(0xF << (p * 4)) | (v << (p * 4)); }

#define M_VAL -0xABCDEF
#define M_COMPRESSED_VAL 15

#define GTA_SA_WIDTH 640.0
#define GTA_SA_HEIGHT 448.0

enum { // Compressed data
	/*
	 * Server data
	 */
	epTD_Active,
	/*
	 * SA-MP data
	 */
	epTD_Alignment,
	epTD_UseBox,
	epTD_Shadow,
	epTD_Outline,
	epTD_Proportional,
	epTD_Selectable,
	epTD_Font
};

enum _:ePlayerTextDrawProperties {
	/*
	 * Server data
	 */
	PlayerText:epTD_SAMP_ID,
	/*
	 * SA-MP data
	 */
	Float:epTD_Position_X,
	Float:epTD_Position_Y,
	Float:epTD_LetterSize_X,
	Float:epTD_LetterSize_Y,
	Float:epTD_TextSize_X,
	Float:epTD_TextSize_Y,

	Float:epTD_PreviewRot_X,
	Float:epTD_PreviewRot_Y,
	Float:epTD_PreviewRot_Z,
	Float:epTD_Preview_Zoom,

	epTD_Color,
	epTD_BoxColor,
	epTD_BackgroundColor,
	epTD_PreviewModel,
	epTD_PreviewVehCol_1,
	epTD_PreviewVehCol_2
};

new pTextDraws_Compressed[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS];
new pTextDraws_String[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS][256 char];

new pTextDraws[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS][_:ePlayerTextDrawProperties];

PlayerText:pTD_GetIdx(playerid) {
	for(new i; i < sizeof pTextDraws[]; ++i) {
		if(! _G(pTextDraws_Compressed[playerid][i], epTD_Active)) {
			return PlayerText:i;
		}
	}
	return PlayerText:INVALID_TEXT_DRAW;
}

PlayerText:pTD_Create(playerid, Float:x, Float:y, text[]) {
	new PlayerText:idx = pTD_GetIdx(playerid);
	if(idx == PlayerText:INVALID_TEXT_DRAW) {
		return PlayerText:INVALID_TEXT_DRAW;
	}
	pTextDraws[playerid][idx][epTD_SAMP_ID] = PlayerText:INVALID_TEXT_DRAW;
	_S(pTextDraws_Compressed[playerid][idx], epTD_Active, 1);
	_S(pTextDraws_Compressed[playerid][idx], epTD_UseBox, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Shadow, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Outline, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Font, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Proportional, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Selectable, M_COMPRESSED_VAL);
	_S(pTextDraws_Compressed[playerid][idx], epTD_Alignment, M_COMPRESSED_VAL);
	pTextDraws[playerid][idx][epTD_Position_X] = x;
	pTextDraws[playerid][idx][epTD_Position_Y] = y;
	pTextDraws[playerid][idx][epTD_LetterSize_X] = M_VAL;
	pTextDraws[playerid][idx][epTD_LetterSize_Y] = M_VAL;
	pTextDraws[playerid][idx][epTD_TextSize_X] = M_VAL;
	pTextDraws[playerid][idx][epTD_TextSize_Y] = M_VAL;
	pTextDraws[playerid][idx][epTD_Color] = M_VAL;
	pTextDraws[playerid][idx][epTD_BoxColor] = M_VAL;
	pTextDraws[playerid][idx][epTD_BackgroundColor] = M_VAL;
	pTextDraws[playerid][idx][epTD_PreviewModel] = M_VAL;
	pTextDraws[playerid][idx][epTD_PreviewRot_X] = M_VAL;
	pTextDraws[playerid][idx][epTD_PreviewRot_Y] = M_VAL;
	pTextDraws[playerid][idx][epTD_PreviewRot_Z] = M_VAL;
	pTextDraws[playerid][idx][epTD_Preview_Zoom] = 1.0;
	pTextDraws[playerid][idx][epTD_PreviewVehCol_1] = M_VAL;
	pTextDraws[playerid][idx][epTD_PreviewVehCol_2] = M_VAL;
	strpack(pTextDraws_String[playerid][idx], text);

	return idx;
}

stock AR_Calc(playerid, Float:x, Float:size_x, bool:centered_sprite = false, &Float:result_x, &Float:result_size_x)
{
	size_x *= floatmul(floatpower(GetPlayerCameraAspectRatio(playerid), -1)), floatdiv(GTA_SA_WIDTH, GTA_SA_HEIGHT));
	if(centered_sprite) x -= size_x / 2;

	result_x = x;
	result_size_x = size_x;
	return 1;
}

pTD_Destroy(playerid, PlayerText:text) {
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID]);
	}
	for(new i; i < sizeof pTextDraws[][]; ++i) {
		pTextDraws[playerid][text][i] = 0;
	}
}

pTD_LetterSize(playerid, PlayerText:text, Float:x, Float:y) {
	pTextDraws[playerid][text][epTD_LetterSize_X] = x;
	pTextDraws[playerid][text][epTD_LetterSize_Y] = y;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawLetterSize(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], x, y);
	}
}

pTD_TextSize(playerid, PlayerText:text, Float:x, Float:y) {
	pTextDraws[playerid][text][epTD_TextSize_X] = x;
	pTextDraws[playerid][text][epTD_TextSize_Y] = y;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawTextSize(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], x, y);
	}
}

pTD_Alignment(playerid, PlayerText:text, alignment) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Alignment, alignment);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawAlignment(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], alignment);
	}
}

pTD_Color(playerid, PlayerText:text, color) {
	pTextDraws[playerid][text][epTD_Color] = color;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawColor(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], color);
	}
}

pTD_UseBox(playerid, PlayerText:text, use) {
	_S(pTextDraws_Compressed[playerid][text], epTD_UseBox, use);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawUseBox(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], use);
	}
}

pTD_BoxColor(playerid, PlayerText:text, color) {
	pTextDraws[playerid][text][epTD_BoxColor] = color;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawBoxColor(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], color);
	}
}

pTD_SetShadow(playerid, PlayerText:text, size) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Shadow, size);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetShadow(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], size);
	}
}

pTD_SetOutline(playerid, PlayerText:text, size) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Outline, size);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetOutline(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], size);
	}
}

pTD_BackgroundColor(playerid, PlayerText:text, color) {
	pTextDraws[playerid][text][epTD_BackgroundColor] = color;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawBackgroundColor(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], color);
	}
}

pTD_Font(playerid, PlayerText:text, font) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Font, font);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawFont(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], font);
	}
}

pTD_SetProportional(playerid, PlayerText:text, set) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Proportional, set);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetProportional(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], set);
	}
}

pTD_SetSelectable(playerid, PlayerText:text, set) {
	_S(pTextDraws_Compressed[playerid][text], epTD_Selectable, set);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetSelectable(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], set);
	}
}

pTD_Show(playerid, PlayerText:text) 
{
	#define __TD pTextDraws[playerid][text]
	
	if(pTextDraws[playerid][text][epTD_SAMP_ID] == PlayerText:INVALID_TEXT_DRAW) 
	{
		new unpackedString[256];
		strunpack(unpackedString, pTextDraws_String[playerid][text]);

		new Float:final_x, Float: final_size_x;
		AR_Calc(playerid, pTextDraws[playerid][text][epTD_Position_X], __TD[epTD_TextSize_X], false, final_x, final_size_x);
		pTextDraws[playerid][text][epTD_SAMP_ID] = CreatePlayerTextDraw(
			playerid,
			pTextDraws[playerid][text][epTD_Position_X], 
			pTextDraws[playerid][text][epTD_Position_Y], 
			unpackedString
		);
		__TD[epTD_TextSize_X] = final_size_x;
	}
	
	if(__TD[epTD_LetterSize_X] != M_VAL) {
		pTD_LetterSize(playerid, text, __TD[epTD_LetterSize_X], __TD[epTD_LetterSize_Y]);
	}
	if(__TD[epTD_TextSize_X] != M_VAL) {
		pTD_TextSize(playerid, text, __TD[epTD_TextSize_X], __TD[epTD_TextSize_Y]);
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Alignment) != M_COMPRESSED_VAL) {
		pTD_Alignment(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Alignment));
	}
	if(__TD[epTD_Color] != M_VAL) {
		pTD_Color(playerid, text, __TD[epTD_Color]);
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_UseBox) != M_COMPRESSED_VAL) {
		pTD_UseBox(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_UseBox));
	}
	if(__TD[epTD_BoxColor] != M_VAL) {
		pTD_BoxColor(playerid, text, __TD[epTD_BoxColor]);
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Shadow) != M_COMPRESSED_VAL) {
		pTD_SetShadow(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Shadow));
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Outline) != M_COMPRESSED_VAL) {
		pTD_SetOutline(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Outline));
	}
	if(__TD[epTD_BackgroundColor] != M_VAL) {
		pTD_BackgroundColor(playerid, text, __TD[epTD_BackgroundColor]);
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Font) != M_COMPRESSED_VAL) {
		pTD_Font(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Font));
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Proportional) != M_COMPRESSED_VAL) {
		pTD_SetProportional(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Proportional));
	}
	if(_G(pTextDraws_Compressed[playerid][text], epTD_Selectable) != M_COMPRESSED_VAL) {
		pTD_SetSelectable(playerid, text, _G(pTextDraws_Compressed[playerid][text], epTD_Selectable));
	}
	if(__TD[epTD_PreviewModel] != M_VAL) {
		pTD_SetPreviewModel(playerid, text, __TD[epTD_PreviewModel]);
	}
	if(__TD[epTD_PreviewRot_X] != M_VAL) {
		pTD_SetPreviewRot(playerid, text, __TD[epTD_PreviewRot_X], __TD[epTD_PreviewRot_Y], __TD[epTD_PreviewRot_Z], __TD[epTD_Preview_Zoom]);
	}
	if(__TD[epTD_PreviewVehCol_1] != M_VAL) {
		pTD_SetPreviewVehCol(playerid, text, __TD[epTD_PreviewVehCol_1], __TD[epTD_PreviewVehCol_2]);
	}
	#undef __TD
	PlayerTextDrawShow(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID]);
}

pTD_Hide(playerid, PlayerText:text) {
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID]);
		pTextDraws[playerid][text][epTD_SAMP_ID] = PlayerText:INVALID_TEXT_DRAW;
	}
}

pTD_SetString(playerid, PlayerText:text, string[]) {
	strpack(pTextDraws_String[playerid][text], string);
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetString(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], string);
	}
}

pTD_SetPreviewModel(playerid, PlayerText:text, modelindex) {
	pTextDraws[playerid][text][epTD_PreviewModel] = modelindex;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewModel(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], modelindex);
	}
}

pTD_SetPreviewRot(playerid, PlayerText:text, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom = 1.0) {
	pTextDraws[playerid][text][epTD_PreviewRot_X] = fRotX;
	pTextDraws[playerid][text][epTD_PreviewRot_Y] = fRotY;
	pTextDraws[playerid][text][epTD_PreviewRot_Z] = fRotZ;
	pTextDraws[playerid][text][epTD_Preview_Zoom] = fZoom;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewRot(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], fRotX, fRotY, fRotZ, fZoom);
	}
}

pTD_SetPreviewVehCol(playerid, PlayerText:text, color1, color2) {
	pTextDraws[playerid][text][epTD_PreviewVehCol_1] = color1;
	pTextDraws[playerid][text][epTD_PreviewVehCol_2] = color2;
	if(pTextDraws[playerid][text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewVehCol(playerid, PlayerText:pTextDraws[playerid][text][epTD_SAMP_ID], color1, color2);
	}
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	for(new i; i < sizeof pTextDraws[]; ++i) {
		if(pTextDraws[playerid][i][epTD_SAMP_ID] == playertextid) {
			CallRemoteFunction("OnPlayerClickPTextdraw", "ii", playerid, i);
			break;
		}
	}
}

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < sizeof pTextDraws[]; ++i) {
		pTD_Destroy(playerid, PlayerText:i);
	}
    return 1;
}


#define CreatePlayerTextDraw pTD_Create
#define PlayerTextDrawDestroy pTD_Destroy
#define PlayerTextDrawLetterSize pTD_LetterSize
#define PlayerTextDrawTextSize pTD_TextSize
#define PlayerTextDrawAlignment pTD_Alignment
#define PlayerTextDrawColor pTD_Color
#define PlayerTextDrawUseBox pTD_UseBox
#define PlayerTextDrawBoxColor pTD_BoxColor
#define PlayerTextDrawSetShadow pTD_SetShadow
#define PlayerTextDrawSetOutline pTD_SetOutline
#define PlayerTextDrawBackgroundColor pTD_BackgroundColor
#define PlayerTextDrawFont pTD_Font
#define PlayerTextDrawSetProportional pTD_SetProportional
#define PlayerTextDrawSetSelectable pTD_SetSelectable
#define PlayerTextDrawShow pTD_Show
#define PlayerTextDrawHide pTD_Hide
#define PlayerTextDrawSetString pTD_SetString
#define PlayerTextDrawSetPreviewModel pTD_SetPreviewModel
#define PlayerTextDrawSetPreviewRot pTD_SetPreviewRot
#define PlayerTextDrawSetPreviewVehCol pTD_SetPreviewVehCol