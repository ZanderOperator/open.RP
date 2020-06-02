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
new 
	Float:crashhealth[MAX_VEHICLES][MAX_PLAYERS],
	Float:oldcrashhealth[MAX_VEHICLES][MAX_PLAYERS],
	Float:finalhealth[MAX_VEHICLES][MAX_PLAYERS],
	textdrawtimer[MAX_PLAYERS],
	textdrawiterate[MAX_PLAYERS],
	vehicledamaged[MAX_VEHICLES],
    PlayerText:crashTD[MAX_PLAYERS];
    
/*
	##     ##  #######   #######  ##    ##
	##     ## ##     ## ##     ## ##   ##
	##     ## ##     ## ##     ## ##  ##
	######### ##     ## ##     ## #####
	##     ## ##     ## ##     ## ##  ##
	##     ## ##     ## ##     ## ##   ##
	##     ##  #######   #######  ##    ##
*/

stock VehicleHealthCheck(vehicleid, playerid)
{
	GetVehicleHealth(vehicleid, oldcrashhealth[vehicleid][playerid]);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	KillTimer(textdrawtimer[playerid]);
	DestroyCarCrashTD(playerid);
	textdrawiterate[playerid] = 0;
	return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch( hittype ) {
		case BULLET_HIT_TYPE_VEHICLE: {
	 		vehicledamaged[hitid] = 1;
	 	}
	}
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static CreateCarCrashTD(playerid) 
{
	DestroyCarCrashTD(playerid);
	
	switch(textdrawiterate[playerid]) {
		case 0: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid,-20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff0000aa);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff0000aa);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff0000aa);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 1: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000088);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000088);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000088);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 2: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000077);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000077);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000077);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 3: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000066);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000066);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000066);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 4: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000055);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000055);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000055);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 5: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000044);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000044);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000044);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 6: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000033);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000033);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000033);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
		case 7: {
			crashTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000,2.000000,"|");
			PlayerTextDrawUseBox(playerid, crashTD[playerid],1);
			PlayerTextDrawBoxColor(playerid, crashTD[playerid],0xff000022);
			PlayerTextDrawTextSize(playerid, crashTD[playerid],660.000000,22.000000);
			PlayerTextDrawAlignment(playerid, crashTD[playerid],0);
			PlayerTextDrawBackgroundColor(playerid, crashTD[playerid],0xff000022);
			PlayerTextDrawFont(playerid, crashTD[playerid],3);
			PlayerTextDrawLetterSize(playerid, crashTD[playerid],1.000000,52.200000);
			PlayerTextDrawColor(playerid, crashTD[playerid],0xff000022);
			PlayerTextDrawSetOutline(playerid, crashTD[playerid],1);
			PlayerTextDrawSetProportional(playerid, crashTD[playerid],1);
			PlayerTextDrawSetShadow(playerid, crashTD[playerid],1);
		}
	}
	PlayerTextDrawShow(playerid, crashTD[playerid]);
	return 1;
}

stock static DestroyCarCrashTD(playerid)
{
	if( crashTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, crashTD[playerid]);
		crashTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

hook OnPlayerCrashVehicle(playerid, vehicleid, Float:damage)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
    	new veh = GetPlayerVehicleID(playerid);
    	GetVehicleHealth(veh, crashhealth[veh][playerid]);
		finalhealth[veh][playerid] = oldcrashhealth[veh][playerid] - crashhealth[veh][playerid];
        if((VehicleInfo[veh][vFaction] == 1 || VehicleInfo[veh][vFaction] == 5 || VehicleInfo[veh][vFaction] == 2) && finalhealth[veh][playerid] > 499)
            finalhealth[veh][playerid] = 0;
		if(damage > 125 && vehicledamaged[veh] == 0)
		{
		    new
				string[128],
				Float:playerhealth;

		    GetPlayerHealth(playerid, playerhealth);
		    if(playerhealth < 5)
          		SetPlayerHealth(playerid, 3);
			else
		    	SetPlayerHealth(playerid, playerhealth);
		    
    		SetPlayerDrunkLevel(playerid, 50000);
    		TogglePlayerControllable(playerid, 0);
    		SetTimerEx("PlayerSecondFreeze", 1800, 0, "i", playerid);
    		SetTimerEx("StopCameraEffect", 10000, 0, "i", playerid);
    		if(textdrawiterate[playerid] == 0)
    		{
    			textdrawtimer[playerid] = SetTimerEx("FadeOutCamera", 1880, true, "i", playerid);
    			CreateCarCrashTD(playerid);
			}
    		ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		vehicledamaged[veh] = 0;
		oldcrashhealth[veh][playerid] = crashhealth[veh][playerid];
	}
	return 1;
}
forward FadeOutCamera(playerid);
public FadeOutCamera(playerid)
{
	if(textdrawiterate[playerid] < 7)
	{
	    DestroyCarCrashTD(playerid);
	    textdrawiterate[playerid]++;
	    CreateCarCrashTD(playerid);
    } else {
        DestroyCarCrashTD(playerid);
        textdrawiterate[playerid] = 0;
        KillTimer(textdrawtimer[playerid]);
    }
	return 1;
}
forward PlayerSecondFreeze(playerid);
public PlayerSecondFreeze(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}
forward StopCameraEffect(playerid);
public StopCameraEffect(playerid)
{
    SetPlayerDrunkLevel(playerid, 0);
	return 1;
}
