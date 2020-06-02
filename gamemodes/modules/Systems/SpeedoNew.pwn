#include <YSI\y_hooks>

new
	Text:EngineState,
	Text:Oil,
	Text:Lights;
		
new
	PlayerText:Speedo[MAX_PLAYERS],
	PlayerText:Fuel[MAX_PLAYERS],
	PlayerText:Miles[MAX_PLAYERS],
	PlayerText:SpeedKMH[MAX_PLAYERS],
	PlayerText:FuelTXT[MAX_PLAYERS],
	PlayerText:Lock[MAX_PLAYERS];

hook OnGameModeInit()
{
	EngineState = TextDrawCreate(553.666687, 344.155700, "mdl-2157:Engine-Broken");
	TextDrawLetterSize(EngineState, 0.000000, 0.000000);
	TextDrawTextSize(EngineState, 13.000000, 13.000000);
	TextDrawAlignment(EngineState, 1);
	TextDrawColor(EngineState, -1);
	TextDrawSetShadow(EngineState, 0);
	TextDrawSetOutline(EngineState, 0);
	TextDrawBackgroundColor(EngineState, 255);
	TextDrawFont(EngineState, 4);
	TextDrawSetProportional(EngineState, 0);
	TextDrawSetShadow(EngineState, 0);
	
	Oil = TextDrawCreate(571.333007, 351.207519, "mdl-2157:Oil");
	TextDrawLetterSize(Oil, 0.000000, 0.000000);
	TextDrawTextSize(Oil, 13.000000, 13.000000);
	TextDrawAlignment(Oil, 1);
	TextDrawColor(Oil, -1);
	TextDrawSetShadow(Oil, 0);
	TextDrawSetOutline(Oil, 0);
	TextDrawBackgroundColor(Oil, 255);
	TextDrawFont(Oil, 4);
	TextDrawSetProportional(Oil, 0);
	TextDrawSetShadow(Oil, 0);
	
	Lights = TextDrawCreate(538.333251, 354.111114, "mdl-2157:Lights");
	TextDrawLetterSize(Lights, 0.000000, 0.000000);
	TextDrawTextSize(Lights, 12.000000, 12.000000);
	TextDrawAlignment(Lights, 1);
	TextDrawColor(Lights, -1);
	TextDrawSetShadow(Lights, 0);
	TextDrawSetOutline(Lights, 0);
	TextDrawBackgroundColor(Lights, 255);
	TextDrawFont(Lights, 4);
	TextDrawSetProportional(Lights, 0);
	TextDrawSetShadow(Lights, 0);
	
	TextDrawHideForAll(EngineState);
	TextDrawHideForAll(Oil);
	TextDrawHideForAll(Lights);
	
	return 1;
}

CreateSpeedoTextDraws(playerid)
{
	Bit1_Set( gr_PlayerUsingSpeedo, playerid, true );

	Speedo[playerid] = CreatePlayerTextDraw(playerid, 486.999816, 301.015136, "mdl-2157:spdoo0");
	PlayerTextDrawLetterSize(playerid, Speedo[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Speedo[playerid], 150.000000, 150.000000);
	PlayerTextDrawAlignment(playerid, Speedo[playerid], 1);
	PlayerTextDrawColor(playerid, Speedo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedo[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Speedo[playerid], 255);
	PlayerTextDrawFont(playerid, Speedo[playerid], 4);
	PlayerTextDrawSetProportional(playerid, Speedo[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Speedo[playerid], 0);
	
	Fuel[playerid] = CreatePlayerTextDraw(playerid, 557.000000, 330.881408, "mdl-2157:fuel0");
	PlayerTextDrawLetterSize(playerid, Fuel[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Fuel[playerid], 100.000000, 100.000000);
	PlayerTextDrawAlignment(playerid, Fuel[playerid], 1);
	PlayerTextDrawColor(playerid, Fuel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Fuel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Fuel[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Fuel[playerid], 255);
	PlayerTextDrawFont(playerid, Fuel[playerid], 4);
	PlayerTextDrawSetProportional(playerid, Fuel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Fuel[playerid], 0);
	
	Miles[playerid] = CreatePlayerTextDraw(playerid, 562.666870, 409.851928, "0.0");
	PlayerTextDrawLetterSize(playerid, Miles[playerid], 0.182331, 0.940442);
	PlayerTextDrawAlignment(playerid, Miles[playerid], 2);
	PlayerTextDrawColor(playerid, Miles[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Miles[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Miles[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Miles[playerid], 255);
	PlayerTextDrawFont(playerid, Miles[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Miles[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Miles[playerid], 0);
	
	SpeedKMH[playerid] = CreatePlayerTextDraw(playerid, 562.000244, 394.918395, "0_km/h");
	PlayerTextDrawLetterSize(playerid, SpeedKMH[playerid], 0.182331, 0.940442);
	PlayerTextDrawAlignment(playerid, SpeedKMH[playerid], 2);
	PlayerTextDrawColor(playerid, SpeedKMH[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpeedKMH[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedKMH[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, SpeedKMH[playerid], 255);
	PlayerTextDrawFont(playerid, SpeedKMH[playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedKMH[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SpeedKMH[playerid], 0);
	
	FuelTXT[playerid] = CreatePlayerTextDraw(playerid, 563.667663, 403.629516, "FUEL:0%");
	PlayerTextDrawLetterSize(playerid, FuelTXT[playerid], 0.108998, 0.741333);
	PlayerTextDrawAlignment(playerid, FuelTXT[playerid], 2);
	PlayerTextDrawColor(playerid, FuelTXT[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FuelTXT[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FuelTXT[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, FuelTXT[playerid], 255);
	PlayerTextDrawFont(playerid, FuelTXT[playerid], 2);
	PlayerTextDrawSetProportional(playerid, FuelTXT[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FuelTXT[playerid], 0);
	
	Lock[playerid] = CreatePlayerTextDraw(playerid, 525.333312, 405.963043, "mdl-2157:Locks-Locked");
	PlayerTextDrawLetterSize(playerid, Lock[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Lock[playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, Lock[playerid], 1);
	PlayerTextDrawColor(playerid, Lock[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Lock[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Lock[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Lock[playerid], 255);
	PlayerTextDrawFont(playerid, Lock[playerid], 4);
	PlayerTextDrawSetProportional(playerid, Lock[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Lock[playerid], 0);
	
	PlayerTextDrawShow(playerid, Speedo[playerid]);
	PlayerTextDrawShow(playerid, Fuel[playerid]);
	PlayerTextDrawShow(playerid, Miles[playerid]);
	PlayerTextDrawShow(playerid, SpeedKMH[playerid]);
	PlayerTextDrawShow(playerid, FuelTXT[playerid]);
	PlayerTextDrawShow(playerid, Lock[playerid]);
	
	return 1;
}

DestroySpeedoTextDraws(playerid)
{
	Bit1_Set( gr_PlayerUsingSpeedo, playerid, false );
	
	PlayerTextDrawDestroy(playerid, Speedo[playerid]);
	PlayerTextDrawDestroy(playerid, Fuel[playerid]);
	PlayerTextDrawDestroy(playerid, Miles[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedKMH[playerid]);
	PlayerTextDrawDestroy(playerid, FuelTXT[playerid]);
	PlayerTextDrawDestroy(playerid, Lock[playerid]);

	TextDrawHideForPlayer(playerid, EngineState); 
	TextDrawHideForPlayer(playerid, Oil);
	TextDrawHideForPlayer(playerid, Lights); 
	
	return 1;
}

GetVSpeed(playerid, vid=0)
{
	if(vid == 0)
		vid = GetPlayerVehicleID(playerid);
	
	new
		Float:Vx,
	    Float:Vy,
		Float:Vz,
		Float:rtn;

	GetVehicleVelocity(vid, Vx, Vy, Vz);
	rtn = floatsqroot(floatpower(floatabs(Vx), 2) + floatpower(floatabs(Vy), 2) + floatpower(floatabs(Vz), 2));

	return floatround(floatmul(floatmul(rtn, 100), 1.959), floatround_ceil);
}

/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##     ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

hook OnPlayerUpdate(playerid)
{
	if( IsPlayerInAnyVehicle(playerid) ) {
		if( GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) 
		{
			new
				tmpvid = GetPlayerVehicleID(playerid),
				tmpstring[24];

			switch(GetVSpeed(playerid, tmpvid))
			{
				case 0 .. 9: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo0");
				case 10 .. 19: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo10");
				case 20 .. 29: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo20");
				case 30 .. 39: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo30");
				case 40 .. 49: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo40");
				case 50 .. 59: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo50");
				case 60 .. 69: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo60");
				case 70 .. 79: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo70");
				case 80 .. 89: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo80");
				case 90 .. 99: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo90");
				case 100 .. 109: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo100");
				case 110 .. 119: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo110");
				case 120 .. 129: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo120");
				case 130 .. 139: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo130");
				case 140 .. 149: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo140");
				case 150 .. 159: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo150");
				case 160 .. 169: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo160");
				case 170 .. 179: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo170");
				case 180 .. 189: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo180");
				case 190 .. 199: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo190");
				case 200 .. 209: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo200");
				case 210 .. 219: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo210");
				case 220 .. 229: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo220");
				case 230 .. 239: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo230");
				case 240 .. 9999: PlayerTextDrawSetString(playerid, Speedo[playerid], "mdl-2157:spdoo240");
			}
			
			switch(VehicleInfo[tmpvid][vFuel])
			{
				case 0: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel0");
				case 1 .. 5: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel5");
				case 6 .. 10: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel10");
				case 11 .. 15: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel15");
				case 16 .. 20: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel20");
				case 21 .. 25: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel25");
				case 26 .. 30: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel30");
				case 31 .. 35: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel35");
				case 36 .. 40: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel40");
				case 41 .. 45: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel45");
				case 46 .. 50: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel50");
				case 51 .. 55: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel55");
				case 56 .. 60: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel60");
				case 61 .. 65: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel65");
				case 66 .. 70: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel70");
				case 71 .. 75: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel75");
				case 76 .. 80: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel80");
				case 81 .. 85: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel85");
				case 86 .. 90: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel90");
				case 91 .. 95: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel95");
				case 96 .. 100: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel100");
				default: PlayerTextDrawSetString(playerid, Fuel[playerid], "mdl-2157:fuel0");
			}
			
			format(tmpstring, 24, "%d_km/h", GetVSpeed(playerid));
			PlayerTextDrawSetString(playerid, SpeedKMH[playerid], tmpstring);

			format(tmpstring, 24, "FUEL:%d%", VehicleInfo[tmpvid][vFuel]);
			PlayerTextDrawSetString(playerid, FuelTXT[playerid], tmpstring);

			format(tmpstring, 24, "%06.1f", VehicleInfo[tmpvid][vTravel]);
			PlayerTextDrawSetString(playerid, Miles[playerid], tmpstring);
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT ) {
		new
			model = GetVehicleModel(GetPlayerVehicleID(playerid));
		if( IsAHelio(model) || IsAPlane(model) || IsABike(model)) return 1;
		CreateSpeedoTextDraws(playerid);
		PlayerInfo[playerid][pSpeedo] = 1;
		if(VehicleInfo[GetPlayerVehicleID(playerid)][ vLights ] == 1)
			TextDrawShowForPlayer(playerid, Lights);
		else
			TextDrawHideForPlayer(playerid, Lights);
		
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vDestroyed])
			TextDrawShowForPlayer(playerid, EngineState);
		else
			TextDrawHideForPlayer(playerid, EngineState);
	}
	else if( newstate == PLAYER_STATE_ONFOOT && Bit1_Get( gr_PlayerUsingSpeedo, playerid ) ){
		DestroySpeedoTextDraws(playerid);
		PlayerInfo[playerid][pSpeedo] = 0;
	}
	return 1;
}

CMD:speedo(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER )
	{
		SendClientMessage(playerid, COLOR_GREY, "Niste na vozackom mjestu u automobilu.");
	}
	else if (!PlayerInfo[playerid][pSpeedo])
	{
		SendClientMessage(playerid, COLOR_WHITE, "Ukljucili ste speedometer!");
  		PlayerInfo[playerid][pSpeedo] = 1;
		CreateSpeedoTextDraws(playerid);
	}
	else
	{
		SendClientMessage(playerid, COLOR_WHITE, "Iskljucili ste speedometer!");
  		PlayerInfo[playerid][pSpeedo] = 0;
		DestroySpeedoTextDraws(playerid);
	}

	return 1;
}
