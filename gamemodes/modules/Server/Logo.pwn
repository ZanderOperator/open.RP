#include <YSI_Coding\y_hooks>

static
	PlayerText:WebURLTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ConnectTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:ServerNameTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RPTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

CreateWebTD(playerid)
{
	DestroyWebTD(playerid);
	WebURLTextDraw[playerid] = CreatePlayerTextDraw(playerid, 580.700073, 3.744050, WEB_URL);
	PlayerTextDrawLetterSize(playerid, WebURLTextDraw[playerid], 0.248749, 1.020959);
	PlayerTextDrawAlignment(playerid, WebURLTextDraw[playerid], 1);
	PlayerTextDrawColor(playerid, WebURLTextDraw[playerid], 0xFFFFFFAA);
	PlayerTextDrawSetShadow(playerid, WebURLTextDraw[playerid], 1);
	PlayerTextDrawSetOutline(playerid, WebURLTextDraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, WebURLTextDraw[playerid], 255);
	PlayerTextDrawFont(playerid, WebURLTextDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WebURLTextDraw[playerid], 1);
	PlayerTextDrawShow(playerid, WebURLTextDraw[playerid]);
}

stock DestroyWebTD(playerid)
{
	if(WebURLTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW) 
	{
		PlayerTextDrawDestroy(playerid, WebURLTextDraw[playerid]);
		WebURLTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

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

	// Server Name TextDraw
	new 
		serverName[64];
	strcpy(serverName, SERVER_NAME, 64);
	ServerNameTD[playerid] = CreatePlayerTextDraw(playerid, 320.0, 73.5, serverName);
	PlayerTextDrawLetterSize(playerid, ServerNameTD[playerid], 0.600,1.639);
	PlayerTextDrawColor(playerid, ServerNameTD[playerid], COLOR_GEFORCE_SILVER);
	PlayerTextDrawFont(playerid, ServerNameTD[playerid], 3);
	PlayerTextDrawSetShadow(playerid,ServerNameTD[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ServerNameTD[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ServerNameTD[playerid], 1);
	PlayerTextDrawAlignment(playerid, ServerNameTD[playerid], 2);
	
	// Roleplay TextDraw
	RPTextDraw[playerid] = CreatePlayerTextDraw(playerid, 320.0, 95.0, "Roleplay");
	PlayerTextDrawLetterSize(playerid, RPTextDraw[playerid], 0.700,1.839);
	PlayerTextDrawColor(playerid, RPTextDraw[playerid], COLOR_BLACK);
	PlayerTextDrawFont(playerid, RPTextDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid,RPTextDraw[playerid], 0);
    PlayerTextDrawSetOutline(playerid, RPTextDraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RPTextDraw[playerid], COLOR_WHITE);
    PlayerTextDrawSetProportional(playerid, RPTextDraw[playerid], 1);
	PlayerTextDrawAlignment(playerid, RPTextDraw[playerid], 2);
	
	ShowLoginTextDraws(playerid);
	return 1;
}

DestroyLoginTextdraws(playerid)
{
	HideLoginTextDraws(playerid);
	PlayerTextDrawDestroy(playerid, ConnectTextDraw[playerid]);
	ConnectTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, ServerNameTD[playerid]);
	ServerNameTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, RPTextDraw[playerid]);
	RPTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, WebURLTextDraw[playerid]);
	WebURLTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock HideLoginTextDraws(playerid)
{
    PlayerTextDrawHide(playerid, ConnectTextDraw[playerid]);
	PlayerTextDrawHide(playerid, ServerNameTD[playerid]);
	PlayerTextDrawHide(playerid, RPTextDraw[playerid]);
}

stock ShowLoginTextDraws(playerid)
{
	PlayerTextDrawShow(playerid, ConnectTextDraw[playerid]);
	PlayerTextDrawShow(playerid, ServerNameTD[playerid]);
	PlayerTextDrawShow(playerid, RPTextDraw[playerid]);
	PlayerTextDrawShow(playerid, WebURLTextDraw[playerid]);
}

hook OnPlayerRequestClass(playerid, classid)
{
	CreateLoginTextdraws(playerid);
	CreateWebTD(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyLoginTextdraws(playerid);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	DestroyLoginTextdraws(playerid);
	CreateWebTD(playerid);
	return 1;
}

CMD:toghud(playerid, params[])
{
	new 
		option[4];
	if(sscanf(params, "s[4]", option)) 
		return SendClientMessage(playerid, -1, "[?]: /toghud (on/off)");

	if(!strcmp(option, "on")) 
	{
		DestroyWebTD(playerid);
		DestroyZonesTD(playerid);
	}
	else if(!strcmp(option, "off")) 
	{
		CreateWebTD(playerid);
		CreateZonesTD(playerid);
	}
	return 1;
}