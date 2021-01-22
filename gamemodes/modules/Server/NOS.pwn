#include <YSI_Coding\y_hooks>

static 
	Timer:NosTimer[MAX_PLAYERS],
	NOSCooldown[MAX_PLAYERS];
	
new
	PlayerText:nosbars[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	Text:nosicon[MAX_PLAYERS]		= { Text:INVALID_TEXT_DRAW, ... };
	
new
	Float:nospos[MAX_PLAYERS][3];
			
hook OnPlayerDisconnect(playerid, reason)
{
	stop NosTimer[playerid];
	NOSCooldown[playerid] = -1;
	
	nospos[playerid][0] = 0.0;
	nospos[playerid][1] = 0.0;
	nospos[playerid][2] = 0.0;
	
	if(nosbars[playerid] != PlayerText:INVALID_TEXT_DRAW)
		DestroyNOSTD(playerid);
	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][vNitro] != -1 && VehicleInfo[vehicleid][vNOSCap] > 0)
		{
			if((HOLDING(KEY_FIRE) || HOLDING(KEY_ACTION)))
			{
				GetPlayerPos(playerid, nospos[playerid][0], nospos[playerid][1], nospos[playerid][2]); //Getanje pozicije radi afk da se ne trosi nitro
				
				NosTimer[playerid] = repeat CalcNitroCap(playerid, vehicleid);
				
				AddVehicleComponent(vehicleid, 1010);
				NOSCooldown[playerid] = GetTickCount();
			}
			else if(RELEASED(KEY_FIRE) || RELEASED(KEY_ACTION)) 
			{
				if((GetTickCount() - NOSCooldown[playerid]) > 50 && (GetTickCount() - NOSCooldown[playerid]) < 1120) // 1120 jer da timer od 800 milisekundi KASNI TOLKO!!!!!
				{
					if(!IsPlayerAdmin(playerid))
						VehicleInfo[vehicleid][vNOSCap] -= 3;
					
					ShowNosCap(playerid);
				}
				stop NosTimer[playerid];
				RemoveVehicleComponent(vehicleid, 1010);
			}
		}
		else
		{
			RemoveVehicleComponent(vehicleid, 1010);
			VehicleInfo[vehicleid][vNOSCap] = 0;
			ShowNosCap(playerid);
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT && VehicleInfo[vehicleid][vNitro] != -1) {
		new
			model = GetVehicleModel(vehicleid);
		if(IsAHelio(model) || IsAPlane(model) || IsABike(model)) return 1;
		CreateNosTextdraws(playerid);
	}
	if(newstate == PLAYER_STATE_ONFOOT && nosbars[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		stop NosTimer[playerid];
		DestroyNOSTD(playerid);
	}
	return 1;
}

timer CalcNitroCap[800](playerid, vehicleid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, nospos[playerid][0], nospos[playerid][1], nospos[playerid][2])) // AFK CHECK da se ne trosi kad se alt taba
	{
		stop NosTimer[playerid];
		RemoveVehicleComponent(vehicleid, 1010);
		return 0;
	}

	nospos[playerid][0] = 0.0;
	nospos[playerid][1] = 0.0;
	nospos[playerid][2] = 0.0;
	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		stop NosTimer[playerid];
		return 0;
	}
	if(VehicleInfo[vehicleid][vNOSCap] > 0)
	{
		if(!IsPlayerAdmin(playerid))
			VehicleInfo[vehicleid][vNOSCap] -= 5;
		else
			VehicleInfo[vehicleid][vNOSCap] -= 1;
		
		ShowNosCap(playerid);
	}
	else
	{
		stop NosTimer[playerid];
		RemoveVehicleComponent(vehicleid, 1010);
		VehicleInfo[vehicleid][vNOSCap] = 0;
		ShowNosCap(playerid);
	}
	return 1;
}
	
CreateNosTextdraws(playerid)
{
	nosicon[playerid] = TextDrawCreate(596.000000, 218.051956, "");
	TextDrawLetterSize(nosicon[playerid], 0.000000, 0.000000);
	TextDrawTextSize(nosicon[playerid], 60.000000, 60.000000);
	TextDrawAlignment(nosicon[playerid], 1);
	TextDrawColor(nosicon[playerid], -1);
	TextDrawSetShadow(nosicon[playerid], 0);
	TextDrawSetOutline(nosicon[playerid], 0);
	TextDrawBackgroundColor(nosicon[playerid], -256);
	TextDrawFont(nosicon[playerid], 5);
	TextDrawSetProportional(nosicon[playerid], 0);
	TextDrawSetShadow(nosicon[playerid], 0);
	TextDrawSetPreviewModel(nosicon[playerid], 1008);
	TextDrawSetPreviewRot(nosicon[playerid], -100.000000, 0.000000, 70.000000, 1.500000);
	
	nosbars[playerid] = CreatePlayerTextDraw(playerid, 627.999755, 252.222274, "100%");
	PlayerTextDrawLetterSize(playerid, nosbars[playerid], 0.226999, 0.874074);
	PlayerTextDrawAlignment(playerid, nosbars[playerid], 2);
	PlayerTextDrawColor(playerid, nosbars[playerid], -1);
	PlayerTextDrawSetShadow(playerid, nosbars[playerid], 0);
	PlayerTextDrawSetOutline(playerid, nosbars[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, nosbars[playerid], 255);
	PlayerTextDrawFont(playerid, nosbars[playerid], 3);
	PlayerTextDrawSetProportional(playerid, nosbars[playerid], 1);
	PlayerTextDrawSetShadow(playerid, nosbars[playerid], 0);
	
	TextDrawShowForPlayer(playerid, nosicon[playerid]);
	
	ShowNosCap(playerid);
	
	return 1;
}

DestroyNOSTD(playerid)
{
	PlayerTextDrawDestroy(playerid, nosbars[playerid]);
	TextDrawDestroy(nosicon[playerid]);
	
	nosbars[playerid] = PlayerText:INVALID_TEXT_DRAW;
	nosicon[playerid] = Text:INVALID_TEXT_DRAW;
	
	return 1;
}

ShowNosCap(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);

	switch(VehicleInfo[vehicleid][vNOSCap])
	{
		case 0: PlayerTextDrawSetString(playerid, nosbars[playerid], "0%");
		case 1 .. 10: PlayerTextDrawSetString(playerid, nosbars[playerid], "10%");
		case 11 .. 20: PlayerTextDrawSetString(playerid, nosbars[playerid], "20%");
		case 21 .. 30: PlayerTextDrawSetString(playerid, nosbars[playerid], "30%");
		case 31 .. 40: PlayerTextDrawSetString(playerid, nosbars[playerid], "40%");
		case 41 .. 50: PlayerTextDrawSetString(playerid, nosbars[playerid], "50%");
		case 51 .. 60: PlayerTextDrawSetString(playerid, nosbars[playerid], "60%");
		case 61 .. 70: PlayerTextDrawSetString(playerid, nosbars[playerid], "70%");
		case 71 .. 80: PlayerTextDrawSetString(playerid, nosbars[playerid], "80%");
		case 81 .. 90: PlayerTextDrawSetString(playerid, nosbars[playerid], "90%");
		case 91 .. 100: PlayerTextDrawSetString(playerid, nosbars[playerid], "100%");
		default: PlayerTextDrawSetString(playerid, nosbars[playerid], "");
	}
	PlayerTextDrawShow(playerid, nosbars[playerid]);
	//TextDrawShowForPlayer(playerid, nosicon[playerid]);
	
	return 1;
}

CMD:checknos(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid,COLOR_RED, "Ne mozete koristiti ovu komandu!");
	
	new
		veh;
	
	if(sscanf(params, "d", veh))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /checknos [vozilo id]");
	
	if(veh == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid,COLOR_RED, "Krivi id vozila");
		
	va_SendClientMessage(playerid, COLOR_RED, "[!] Vozilo ID %d ima %d nitra.", veh, VehicleInfo[veh][vNOSCap]);
	return 1;
}

CMD:refillnos(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendClientMessage(playerid,COLOR_RED, "Ne mozete koristiti ovu komandu!");
	
	new
		car;
		
	if((car = GetPlayerVehicleID(playerid)) == 0)
		return SendClientMessage(playerid,COLOR_RED, "Nisi u vozilu!");
	
	VehicleInfo[car][vNOSCap] = 100;
	ShowNosCap(playerid);
	
	va_SendClientMessage(playerid, COLOR_RED, "[!] Napunili ste nitro na vozilu id: %d!", car);
	
	return 1;
}