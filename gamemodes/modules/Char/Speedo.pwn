/*
	Khawaja - 2020
*/

#include <YSI_Coding\y_hooks>

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

static stock
    PlayerText:VehicleName[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:Speed[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GasText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:LockedText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SpeedVar[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	bool:UsingSpeedometer[MAX_PLAYERS];

stock bool:Player_UsingSpeedometer(playerid)
{
	return UsingSpeedometer[playerid];
}

stock Player_SetSpeedometer(playerid, bool:v)
{
	UsingSpeedometer[playerid] = v;
}

stock CreateSpeedoTextDraws(playerid)
{
    Player_SetSpeedometer(playerid, true);

	VehicleName[playerid] = CreatePlayerTextDraw(playerid, 552.500732, 399.250274, "veh");
	PlayerTextDrawLetterSize(playerid, VehicleName[playerid], 0.172497, 1.136247);
	PlayerTextDrawAlignment(playerid, VehicleName[playerid], 1);
	PlayerTextDrawColor(playerid, VehicleName[playerid], 357697791);
	PlayerTextDrawSetShadow(playerid, VehicleName[playerid], 0);
	PlayerTextDrawSetOutline(playerid, VehicleName[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, VehicleName[playerid], 255);
	PlayerTextDrawFont(playerid, VehicleName[playerid], 2);
	PlayerTextDrawSetProportional(playerid, VehicleName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, VehicleName[playerid], 0);

	Speed[playerid] = CreatePlayerTextDraw(playerid, 552.603515, 406.500396, "111");
	PlayerTextDrawLetterSize(playerid, Speed[playerid], 0.561999, 2.676244);
	PlayerTextDrawAlignment(playerid, Speed[playerid], 1);
	PlayerTextDrawColor(playerid, Speed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speed[playerid], 255);
	PlayerTextDrawFont(playerid, Speed[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Speed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Speed[playerid], 0);

	GasText[playerid] = CreatePlayerTextDraw(playerid, 610.397949, 411.449951, "100%");
	PlayerTextDrawLetterSize(playerid, GasText[playerid], 0.304499, 1.039999);
	PlayerTextDrawAlignment(playerid, GasText[playerid], 2);
	PlayerTextDrawColor(playerid, GasText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, GasText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GasText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GasText[playerid], 255);
	PlayerTextDrawFont(playerid, GasText[playerid], 2);
	PlayerTextDrawSetProportional(playerid, GasText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, GasText[playerid], 0);

	LockedText[playerid] = CreatePlayerTextDraw(playerid, 553.705810, 430.489440, "unlocked");
	PlayerTextDrawLetterSize(playerid, LockedText[playerid], 0.210996, 0.991873);
	PlayerTextDrawAlignment(playerid, LockedText[playerid], 1);
	PlayerTextDrawColor(playerid, LockedText[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, LockedText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LockedText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, LockedText[playerid], 255);
	PlayerTextDrawFont(playerid, LockedText[playerid], 2);
	PlayerTextDrawSetProportional(playerid, LockedText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, LockedText[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, LockedText[playerid], true);

	SpeedVar[playerid] = CreatePlayerTextDraw(playerid, 596.401367, 421.550567, "km/h");
	PlayerTextDrawLetterSize(playerid, SpeedVar[playerid], 0.253499, 0.886874);
	PlayerTextDrawAlignment(playerid, SpeedVar[playerid], 1);
	PlayerTextDrawColor(playerid, SpeedVar[playerid], -457153537);
	PlayerTextDrawSetShadow(playerid, SpeedVar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedVar[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedVar[playerid], 255);
	PlayerTextDrawFont(playerid, SpeedVar[playerid], 2);
	PlayerTextDrawSetProportional(playerid, SpeedVar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SpeedVar[playerid], 0);


    PlayerTextDrawShow(playerid, VehicleName[playerid]);
	PlayerTextDrawShow(playerid, Speed[playerid]);
	PlayerTextDrawShow(playerid, GasText[playerid]);
	PlayerTextDrawShow(playerid, LockedText[playerid]);
	PlayerTextDrawShow(playerid, SpeedVar[playerid]);
	return 1;
}

stock DestroySpeedoTextDraws(playerid)
{
	Player_SetSpeedometer(playerid, false);

	PlayerTextDrawDestroy(playerid, VehicleName[playerid]);
	PlayerTextDrawDestroy(playerid, Speed[playerid]);
	PlayerTextDrawDestroy(playerid, GasText[playerid]);
	PlayerTextDrawDestroy(playerid, LockedText[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedVar[playerid]);

	VehicleName[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	Speed[playerid]			= PlayerText:INVALID_TEXT_DRAW;
	GasText[playerid]		= PlayerText:INVALID_TEXT_DRAW;
	LockedText[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	SpeedVar[playerid]		= PlayerText:INVALID_TEXT_DRAW;
	
	Player_SetSpeedometer(playerid, false);
	return 1;
}

Float:GetPlayerVehicleSpeed(playerid, pvid=0)
{
	if(!pvid)
		pvid = GetPlayerVehicleID(playerid);
		
	new
		Float:Vx,
	    Float:Vy,
		Float:Vz,
		Float:rtn;

	GetVehicleVelocity(GetPlayerVehicleID(playerid), Vx, Vy, Vz);
	rtn = floatsqroot(floatpower(floatabs(Vx), 2) + floatpower(floatabs(Vy), 2) + floatpower(floatabs(Vz), 2));
	return floatmul(floatmul(rtn, 100), 1.959);
}

hook function ResetPlayerVariables(playerid)
{
	DestroySpeedoTextDraws(playerid);
	return continue(playerid);
}

hook OnPlayerUpdate(playerid) // PHONE_HIDE = 0
{
	if( IsPlayerInAnyVehicle(playerid) )
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Player_PhoneStatus(playerid) == 0)
		{
			new
				tmpstring[12],
				pvid = GetPlayerVehicleID(playerid);

			if(!Player_UsingSpeedometer(playerid))
				CreateSpeedoTextDraws(playerid);
				
            new vehicleName[MAX_VEHICLE_NAME];
            GetVehicleNameById(GetPlayerVehicleID(playerid), vehicleName, MAX_VEHICLE_NAME);
  			PlayerTextDrawSetString(playerid, VehicleName[playerid], vehicleName);

			format(tmpstring, 12, "%.0f", GetPlayerVehicleSpeed(playerid, pvid));
			PlayerTextDrawSetString(playerid, Speed[playerid], tmpstring);

			format(tmpstring, 12, "%d%", VehicleInfo[pvid][vFuel]);
			PlayerTextDrawSetString(playerid, GasText[playerid], tmpstring);

			format(tmpstring, 14, "%s", VehicleInfo[GetPlayerVehicleID(playerid)][vLocked] == 1 ? ("~r~LOCKED") : ("~g~UNLOCKED"));
			PlayerTextDrawSetString(playerid, LockedText[playerid], tmpstring);
			
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT)
	{
		new
			model = GetVehicleModel(GetPlayerVehicleID(playerid));
		if( IsAHelio(model) || IsAPlane(model) || IsABike(model)) return 1;
		CreateSpeedoTextDraws(playerid);
	}
	else if(newstate == PLAYER_STATE_ONFOOT && Player_UsingSpeedometer(playerid))
		DestroySpeedoTextDraws(playerid);
		
	return 1;
}
