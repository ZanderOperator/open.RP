#include <YSI\y_hooks>

new PlayerText:ConnectTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:CopyrightTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:CoATextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RPTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };
	
stock CreateLoginTextdraws(playerid)
{
	// Connect background TextDraw
    ConnectTextDraw[playerid] = CreatePlayerTextDraw(playerid, -20.000000, 0.000000, "_");
	PlayerTextDrawUseBox(playerid, ConnectTextDraw[playerid], 1);
	PlayerTextDrawBoxColor(playerid, ConnectTextDraw[playerid], 0x00000055);
	PlayerTextDrawLetterSize(playerid, ConnectTextDraw[playerid], 0.0, 100.0);
	PlayerTextDrawFont(playerid, ConnectTextDraw[playerid], 3);
	PlayerTextDrawLetterSize(playerid, ConnectTextDraw[playerid], 1.0, 100.0);
	PlayerTextDrawColor(playerid, ConnectTextDraw[playerid], 0x00000055);

	// Copyright TextDraw
	CopyrightTextDraw[playerid] = CreatePlayerTextDraw(playerid, 320.0, 428.0, COPYRIGHT);
	PlayerTextDrawFont(playerid, CopyrightTextDraw[playerid], 2);
    PlayerTextDrawColor(playerid, CopyrightTextDraw[playerid], COLOR_GEFORCE_SILVER);
	PlayerTextDrawLetterSize(playerid, CopyrightTextDraw[playerid], 0.249, 1.040);
	PlayerTextDrawSetShadow(playerid, CopyrightTextDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, CopyrightTextDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, CopyrightTextDraw[playerid], 1);
	PlayerTextDrawAlignment(playerid, CopyrightTextDraw[playerid], 2);

	// CoA TextDraw
	CoATextDraw[playerid] = CreatePlayerTextDraw(playerid, 320.0, 73.5, "City~n~of~n~Angels");
	PlayerTextDrawLetterSize(playerid, CoATextDraw[playerid], 0.600,1.639);
	PlayerTextDrawColor(playerid, CoATextDraw[playerid], COLOR_GEFORCE_SILVER);
	PlayerTextDrawFont(playerid, CoATextDraw[playerid], 3);
	PlayerTextDrawSetShadow(playerid,CoATextDraw[playerid], 0);
    PlayerTextDrawSetOutline(playerid, CoATextDraw[playerid], 1);
    PlayerTextDrawSetProportional(playerid, CoATextDraw[playerid], 1);
	PlayerTextDrawAlignment(playerid, CoATextDraw[playerid], 2);
	
	// Roleplay TextDraw
	RPTextDraw[playerid] = CreatePlayerTextDraw(playerid, 320.0, 120.0, "Roleplay");
	PlayerTextDrawLetterSize(playerid, RPTextDraw[playerid], 0.700,1.839);
	PlayerTextDrawColor(playerid, RPTextDraw[playerid], COLOR_BLACK);
	PlayerTextDrawFont(playerid, RPTextDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid,RPTextDraw[playerid], 0);
    PlayerTextDrawSetOutline(playerid, RPTextDraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RPTextDraw[playerid], COLOR_WHITE);
    PlayerTextDrawSetProportional(playerid, RPTextDraw[playerid], 1);
	PlayerTextDrawAlignment(playerid, RPTextDraw[playerid], 2);
	
	GlobalForumLink[playerid] = CreatePlayerTextDraw(playerid, 501.700073, 9.744050, WEB_URL);
	PlayerTextDrawLetterSize(playerid, GlobalForumLink[playerid], 0.248749, 1.020959);
	PlayerTextDrawAlignment(playerid, GlobalForumLink[playerid], 1);
	PlayerTextDrawColor(playerid, GlobalForumLink[playerid], 0xFFFFFFAA);
	PlayerTextDrawSetShadow(playerid, GlobalForumLink[playerid], 1);
	PlayerTextDrawSetOutline(playerid, GlobalForumLink[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, GlobalForumLink[playerid], 255);
	PlayerTextDrawFont(playerid, GlobalForumLink[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GlobalForumLink[playerid], 1);
	PlayerTextDrawShow(playerid, GlobalForumLink[playerid]);
	
	ShowLoginTextDraws(playerid);
	return 1;
}

stock DestroyLoginTextdraws(playerid)
{
	HideLoginTextDraws(playerid);
	PlayerTextDrawDestroy(playerid, ConnectTextDraw[playerid]);
	ConnectTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, CopyrightTextDraw[playerid]);
	CopyrightTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, CoATextDraw[playerid]);
	CoATextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, RPTextDraw[playerid]);
	RPTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, GlobalForumLink[playerid]);
	GlobalForumLink[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock HideLoginTextDraws(playerid)
{
    PlayerTextDrawHide(playerid, ConnectTextDraw[playerid]);
	PlayerTextDrawHide(playerid, CopyrightTextDraw[playerid]);
	PlayerTextDrawHide(playerid, CoATextDraw[playerid]);
	PlayerTextDrawHide(playerid, RPTextDraw[playerid]);
}

stock ShowLoginTextDraws(playerid)
{
	PlayerTextDrawShow(playerid, ConnectTextDraw[playerid]);
	PlayerTextDrawShow(playerid, CopyrightTextDraw[playerid]);
	PlayerTextDrawShow(playerid, CoATextDraw[playerid]);
	PlayerTextDrawShow(playerid, RPTextDraw[playerid]);
	PlayerTextDrawShow(playerid, GlobalForumLink[playerid]);
}

hook OnPlayerRequestClass(playerid, classid)
{
	CreateLoginTextdraws(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyLoginTextdraws(playerid);
	return 1;
}