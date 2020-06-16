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
	PlayerText:sBG1[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sBG2[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sBG3[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sBG4[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sBG5[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sModelGas[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sModelLock[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:sModelWheel[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:LockText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:Speed[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SpeedText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:GasText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MilesText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };

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

	sBG1[playerid] = CreatePlayerTextDraw(playerid, 516.000122, 382.474243, "box");
	PlayerTextDrawLetterSize(playerid, sBG1[playerid], 0.000000, 5.900002);
	PlayerTextDrawTextSize(playerid, sBG1[playerid], 630.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, sBG1[playerid], 1);
	PlayerTextDrawColor(playerid, sBG1[playerid], -1);
	PlayerTextDrawUseBox(playerid, sBG1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sBG1[playerid], 135);
	PlayerTextDrawSetShadow(playerid, sBG1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, sBG1[playerid], 255);
	PlayerTextDrawFont(playerid, sBG1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sBG1[playerid], 1);
	PlayerTextDrawShow(playerid, sBG1[playerid]);

	sModelGas[playerid] = CreatePlayerTextDraw(playerid, 566.600219, 399.525665, "");
	PlayerTextDrawTextSize(playerid, sModelGas[playerid], 17.000000, 18.000000);
	PlayerTextDrawAlignment(playerid, sModelGas[playerid], 1);
	PlayerTextDrawColor(playerid, sModelGas[playerid], -1);
	PlayerTextDrawSetShadow(playerid, sModelGas[playerid], 0);
	PlayerTextDrawFont(playerid, sModelGas[playerid], 5);
	PlayerTextDrawSetProportional(playerid, sModelGas[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, sModelGas[playerid], 1650);
	PlayerTextDrawSetPreviewRot(playerid, sModelGas[playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid, sModelGas[playerid], 0);
	PlayerTextDrawShow(playerid, sModelGas[playerid]);

	sModelWheel[playerid] = CreatePlayerTextDraw(playerid, 567.599731, 384.452026, "");
	PlayerTextDrawTextSize(playerid, sModelWheel[playerid], 15.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, sModelWheel[playerid], 1);
	PlayerTextDrawColor(playerid, sModelWheel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, sModelWheel[playerid], 0);
	PlayerTextDrawFont(playerid, sModelWheel[playerid], 5);
	PlayerTextDrawSetProportional(playerid, sModelWheel[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, sModelWheel[playerid], 1096);
	PlayerTextDrawSetPreviewRot(playerid, sModelWheel[playerid], 0.000000, 0.000000, 50.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid, sModelWheel[playerid], 0);
	PlayerTextDrawShow(playerid, sModelWheel[playerid]);

	sModelLock[playerid] = CreatePlayerTextDraw(playerid, 566.600219, 417.296112, "");
	PlayerTextDrawTextSize(playerid, sModelLock[playerid], 18.000000, 17.000000);
	PlayerTextDrawAlignment(playerid, sModelLock[playerid], 1);
	PlayerTextDrawColor(playerid, sModelLock[playerid], -1);
	PlayerTextDrawSetShadow(playerid, sModelLock[playerid], 0);
	PlayerTextDrawFont(playerid, sModelLock[playerid], 5);
	PlayerTextDrawSetProportional(playerid, sModelLock[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, sModelLock[playerid], 19804);
	PlayerTextDrawSetPreviewRot(playerid, sModelLock[playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid, sModelLock[playerid], 0);
	PlayerTextDrawShow(playerid, sModelLock[playerid]);

	sBG2[playerid] = CreatePlayerTextDraw(playerid, 566.399047, 385.792388, "box");
	PlayerTextDrawLetterSize(playerid, sBG2[playerid], 0.000000, 5.166666);
	PlayerTextDrawTextSize(playerid, sBG2[playerid], 516.301635, 0.000000);
	PlayerTextDrawAlignment(playerid, sBG2[playerid], 1);
	PlayerTextDrawColor(playerid, sBG2[playerid], -1);
	PlayerTextDrawUseBox(playerid, sBG2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sBG2[playerid], 100);
	PlayerTextDrawSetShadow(playerid, sBG2[playerid], 0);
	PlayerTextDrawFont(playerid, sBG2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sBG2[playerid], 0);
	PlayerTextDrawShow(playerid, sBG2[playerid]);

	Speed[playerid] = CreatePlayerTextDraw(playerid, 541.667236, 384.862884, "0%");
	PlayerTextDrawLetterSize(playerid, Speed[playerid], 0.453332, 3.271704);
	PlayerTextDrawTextSize(playerid, Speed[playerid], 0.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Speed[playerid], 2);
	PlayerTextDrawColor(playerid, Speed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speed[playerid], 255);
	PlayerTextDrawFont(playerid, Speed[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Speed[playerid], 1);
	PlayerTextDrawShow(playerid, Speed[playerid]);

	SpeedText[playerid] = CreatePlayerTextDraw(playerid, 525.333374, 413.585296, "km/h");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid], 0.323666, 1.637333);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid], 255);
	PlayerTextDrawFont(playerid, SpeedText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid], 1);
	PlayerTextDrawShow(playerid, SpeedText[playerid]);

	MilesText[playerid] = CreatePlayerTextDraw(playerid, 585.000000, 386.555450, "0000000");
	PlayerTextDrawLetterSize(playerid, MilesText[playerid], 0.190999, 1.010962);
	PlayerTextDrawAlignment(playerid, MilesText[playerid], 1);
	PlayerTextDrawColor(playerid, MilesText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MilesText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MilesText[playerid], 255);
	PlayerTextDrawFont(playerid, MilesText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MilesText[playerid], 1);
	PlayerTextDrawShow(playerid, MilesText[playerid]);

	GasText[playerid] = CreatePlayerTextDraw(playerid, 585.033691, 403.756500, "0/100");
	PlayerTextDrawLetterSize(playerid, GasText[playerid], 0.190999, 1.010962);
	PlayerTextDrawAlignment(playerid, GasText[playerid], 1);
	PlayerTextDrawColor(playerid, GasText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, GasText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, GasText[playerid], 255);
	PlayerTextDrawFont(playerid, GasText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GasText[playerid], 1);
	PlayerTextDrawShow(playerid, GasText[playerid]);

	LockText[playerid] = CreatePlayerTextDraw(playerid, 585.033691, 421.357574, "LOCKED");
	PlayerTextDrawLetterSize(playerid, LockText[playerid], 0.190999, 1.010962);
	PlayerTextDrawAlignment(playerid, LockText[playerid], 1);
	PlayerTextDrawColor(playerid, LockText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, LockText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, LockText[playerid], 255);
	PlayerTextDrawFont(playerid, LockText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, LockText[playerid], 1);
	PlayerTextDrawShow(playerid, LockText[playerid]);

	sBG3[playerid] = CreatePlayerTextDraw(playerid, 570.033020, 385.892700, "box");
	PlayerTextDrawLetterSize(playerid, sBG3[playerid], 0.000000, 1.366666);
	PlayerTextDrawTextSize(playerid, sBG3[playerid], 629.699829, 0.000000);
	PlayerTextDrawAlignment(playerid, sBG3[playerid], 1);
	PlayerTextDrawColor(playerid, sBG3[playerid], -1);
	PlayerTextDrawUseBox(playerid, sBG3[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sBG3[playerid], 87);
	PlayerTextDrawSetShadow(playerid, sBG3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, sBG3[playerid], 255);
	PlayerTextDrawFont(playerid, sBG3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sBG3[playerid], 1);
	PlayerTextDrawShow(playerid, sBG3[playerid]);

	sBG4[playerid] = CreatePlayerTextDraw(playerid, 570.033020, 402.993743, "box");
	PlayerTextDrawLetterSize(playerid, sBG4[playerid], 0.000000, 1.366666);
	PlayerTextDrawTextSize(playerid, sBG4[playerid], 629.699829, 0.000000);
	PlayerTextDrawAlignment(playerid, sBG4[playerid], 1);
	PlayerTextDrawColor(playerid, sBG4[playerid], -1);
	PlayerTextDrawUseBox(playerid, sBG4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sBG4[playerid], 87);
	PlayerTextDrawSetShadow(playerid, sBG4[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, sBG4[playerid], 255);
	PlayerTextDrawFont(playerid, sBG4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sBG4[playerid], 1);
	PlayerTextDrawShow(playerid, sBG4[playerid]);

	sBG5[playerid] = CreatePlayerTextDraw(playerid, 569.933044, 420.594818, "box");
	PlayerTextDrawLetterSize(playerid, sBG5[playerid], 0.000000, 1.366666);
	PlayerTextDrawTextSize(playerid, sBG5[playerid], 629.599853, 0.000000);
	PlayerTextDrawAlignment(playerid, sBG5[playerid], 1);
	PlayerTextDrawColor(playerid, sBG5[playerid], -1);
	PlayerTextDrawUseBox(playerid, sBG5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sBG5[playerid], 87);
	PlayerTextDrawSetShadow(playerid, sBG5[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, sBG5[playerid], 255);
	PlayerTextDrawFont(playerid, sBG5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sBG5[playerid], 1);
	PlayerTextDrawShow(playerid, sBG5[playerid]);
	return 1;
}

stock DestroySpeedoTextDraws(playerid)
{
	Bit1_Set( gr_PlayerUsingSpeedo, playerid, false );

	PlayerTextDrawDestroy(playerid, sBG1[playerid]);
	PlayerTextDrawDestroy(playerid, sBG2[playerid]);
	PlayerTextDrawDestroy(playerid, sBG3[playerid]);
	PlayerTextDrawDestroy(playerid, sBG4[playerid]);
	PlayerTextDrawDestroy(playerid, sBG5[playerid]);
	PlayerTextDrawDestroy(playerid, sModelGas[playerid]);
	PlayerTextDrawDestroy(playerid, sModelLock[playerid]);
	PlayerTextDrawDestroy(playerid, sModelWheel[playerid]);
	PlayerTextDrawDestroy(playerid, LockText[playerid]);
	PlayerTextDrawDestroy(playerid, Speed[playerid]);
	PlayerTextDrawDestroy(playerid, SpeedText[playerid]);
	PlayerTextDrawDestroy(playerid, GasText[playerid]);
	PlayerTextDrawDestroy(playerid, MilesText[playerid]);

	sBG1[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sBG2[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sBG3[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sBG4[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sBG5[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sModelGas[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sModelLock[playerid]= PlayerText:INVALID_TEXT_DRAW;
	sModelWheel[playerid]= PlayerText:INVALID_TEXT_DRAW;
	LockText[playerid]= PlayerText:INVALID_TEXT_DRAW;
	Speed[playerid]= PlayerText:INVALID_TEXT_DRAW;
	SpeedText[playerid]= PlayerText:INVALID_TEXT_DRAW;
	GasText[playerid]= PlayerText:INVALID_TEXT_DRAW;
	MilesText[playerid]= PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

forward Float:GetVSpeed(playerid);
public Float:GetVSpeed(playerid)
{
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
		if( GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {
			new
				tmpstring[14];
			format(tmpstring, 14, "%.0f", GetVSpeed(playerid));
			PlayerTextDrawSetString(playerid, Speed[playerid], tmpstring);

			format(tmpstring, 14, "%d/100", VehicleInfo[GetPlayerVehicleID(playerid)][vFuel]);
			PlayerTextDrawSetString(playerid, GasText[playerid], tmpstring);

			format(tmpstring, 14, "%06.1f", VehicleInfo[GetPlayerVehicleID(playerid)][vTravel]);
			PlayerTextDrawSetString(playerid, MilesText[playerid], tmpstring);

			format(tmpstring, 14, "%s", VehicleInfo[GetPlayerVehicleID(playerid)][vLocked] == 1 ? ("~r~LOCKED") : ("~g~UNLOCKED"));
			PlayerTextDrawSetString(playerid, LockText[playerid], tmpstring);
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
	}
	else if( newstate == PLAYER_STATE_ONFOOT && Bit1_Get( gr_PlayerUsingSpeedo, playerid ) ) DestroySpeedoTextDraws(playerid);
	return 1;
}

