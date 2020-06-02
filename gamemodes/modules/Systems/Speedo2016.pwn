#include <YSI\y_hooks>

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
	PlayerText:Speed[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SpeedText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GasText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MilesText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	Bit1: gr_PlayerUsingSpeedo	<MAX_PLAYERS> = {Bit1:false, ... };

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
stock CreateSpeedoTextDraws(playerid)
{
	Bit1_Set( gr_PlayerUsingSpeedo, playerid, true );
	Speed[playerid] = CreatePlayerTextDraw(playerid, 480.000122, 365.120452, "000");
	PlayerTextDrawLetterSize(playerid, Speed[playerid], 0.998799, 4.198400);
	PlayerTextDrawAlignment(playerid, Speed[playerid], 1);
	PlayerTextDrawColor(playerid, Speed[playerid], 255);
	PlayerTextDrawSetShadow(playerid, Speed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speed[playerid], -1);
	PlayerTextDrawFont(playerid, Speed[playerid], 3);
	PlayerTextDrawSetProportional(playerid, Speed[playerid], 1);
	PlayerTextDrawShow(playerid, Speed[playerid]);

	SpeedText[playerid] = CreatePlayerTextDraw(playerid, 543.200012, 374.080017, "kmh");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid], 0.369998, 1.226665);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid], -1);
	PlayerTextDrawFont(playerid, SpeedText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid], 1);
	PlayerTextDrawShow(playerid, SpeedText[playerid]);

	GasText[playerid] = CreatePlayerTextDraw(playerid, 543.199890, 386.773468, "00%");
	PlayerTextDrawLetterSize(playerid, GasText[playerid], 0.345999, 1.525333);
	PlayerTextDrawAlignment(playerid, GasText[playerid], 1);
	PlayerTextDrawColor(playerid, GasText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, GasText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, GasText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GasText[playerid], -1);
	PlayerTextDrawFont(playerid, GasText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GasText[playerid], 1);
	PlayerTextDrawShow(playerid, GasText[playerid]);

	MilesText[playerid] = CreatePlayerTextDraw(playerid, 488.000000, 401.706726, "0000000");
	PlayerTextDrawLetterSize(playerid, MilesText[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, MilesText[playerid], 1);
	PlayerTextDrawColor(playerid, MilesText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MilesText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MilesText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MilesText[playerid], -1);
	PlayerTextDrawFont(playerid, MilesText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MilesText[playerid], 1);
	PlayerTextDrawShow(playerid, MilesText[playerid]);
	
	return 1;
}

stock DestroySpeedoTextDraws(playerid)
{
	Bit1_Set( gr_PlayerUsingSpeedo, playerid, false );
	
	PlayerTextDrawDestroy(playerid, Speed[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedText[playerid]);
	PlayerTextDrawDestroy(playerid, GasText[playerid]);
	PlayerTextDrawDestroy(playerid, MilesText[playerid]);

	Speed[playerid]		= PlayerText:INVALID_TEXT_DRAW;
	SpeedText[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	GasText[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	MilesText[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

Float:GetVSpeed(playerid, pvid=0)
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
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
		{
			new 
				tmpstring[12],
				pvid = GetPlayerVehicleID(playerid);
			
			format(tmpstring, 12, "%.0f", GetVSpeed(playerid, pvid));
			PlayerTextDrawSetString(playerid, Speed[playerid], tmpstring);
			
			format(tmpstring, 12, "%d%", VehicleInfo[pvid][vFuel]);
			PlayerTextDrawSetString(playerid, GasText[playerid], tmpstring);
				
			format(tmpstring, 12, "%06.1f", VehicleInfo[pvid][vTravel]);
			PlayerTextDrawSetString(playerid, MilesText[playerid], tmpstring);
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
		PlayerInfo[playerid][pSpeedo] = 1;
	}
	else if(newstate == PLAYER_STATE_ONFOOT && Bit1_Get(gr_PlayerUsingSpeedo, playerid ))
	{
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
