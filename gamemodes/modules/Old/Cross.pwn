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

/////////////////////////////////////////////////////////////////

new RaceCrossCP[MAX_PLAYERS];
new CrossFence;

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
///////////////////////////////////////////////////////////////////
stock static CreateEventCross(modelid, Float:X, Float:Y, Float:Z, Float:Rot, color1, color2, respawn)
{
	new
		carid = CreateEventCross(modelid, X, Y, Z, Rot, color1, color2, respawn);
	ResetVehicleInfo(carid);
	
	VehicleInfo[ carid ][ vModel ] 		= modelid;
	VehicleInfo[ carid ][ vColor1 ] 	= color1;
	VehicleInfo[ carid ][ vColor2 ] 	= color2;
	VehicleInfo[ carid ][ vParkX ]		= X;
	VehicleInfo[ carid ][ vParkY ]      = Y;
	VehicleInfo[ carid ][ vParkZ ]      = Z;
	VehicleInfo[ carid ][ vAngle ]      = Rot;
	VehicleInfo[ carid ][ vHealth ]		= 1000.0;
	VehicleInfo[ carid ][ vType ]		= VEHICLE_TYPE_CAR;
	VehicleInfo[ carid ][ vUsage ] 		= VEHICLE_USAGE_EVENT;
	
	new
		engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(carid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	return carid;
}

stock static CreateMotocrossVehicles()
{
	CrossFence = CreateDynamicObject(984, -504.1089,2592.7949,53.1594, 0, 0, 0, -1, -1, -1, 200.0, 100.0);
    CreateEventCross(468, -508.5053,2580.3735,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.6508,2577.8672,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.7855,2575.6235,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.8018,2573.0398,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.9383,2570.6077,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.6339,2568.2707,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.8950,2565.7527,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.9006,2563.2954,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.9872,2560.8694,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -509.2357,2558.5823,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -509.2153,2556.1917,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -509.2542,2553.6487,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -509.4337,2551.0811,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -509.6374,2548.7048,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.5381,2582.7336,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.4384,2603.6506,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.2571,2606.1077,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.3369,2608.5552,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -508.1606,2610.9685,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.1704,2613.4187,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.0540,2615.8696,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -508.1826,2618.2939,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -507.9869,2620.6677,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.8792,2623.0330,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.6294,2625.4778,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.8002,2627.8867,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.8381,2630.3503,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.7484,2632.7222,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.4481,2635.2415,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -507.4940,2637.6523,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.3244,2582.1519,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.2045,2579.5188,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.0883,2576.9270,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.1974,2574.2800,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -519.7813,2571.7622,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.3111,2604.7607,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.3330,2607.4131,53.4141, 270, 0, 0, 0);
    CreateEventCross(468, -520.1213,2609.9531,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -520.2932,2612.5405,53.4154, 270, 0, 0, 0);
    CreateEventCross(468, -520.2142,2615.0300,53.4154, 270, 0, 0, 0);
}

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/
///////////////////////////////////////////////////////////////////

hook OnGameModeInit()
{
	CreateMotocrossVehicles();
	return 1;
}

hook ResetPlayerVariables(playerid)
{
	RaceCrossCP[playerid] = 0;
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( newstate == PLAYER_STATE_DRIVER ) {
		if( VehicleInfo[ GetPlayerVehicleID(playerid) ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(GetPlayerVehicleID(playerid)) == 468 && !RaceCrossCP[ playerid ] ) {
			RemovePlayerFromVehicle(playerid);
			SendClientMessage(playerid, COLOR_RED, "Niste unutar Anniversary Cross Race eventa!");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 468 && RaceCrossCP[ playerid ] ) {
		RepairVehicle(vehicleid);
		
		new
			engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		
		SetVehicleToRespawn(vehicleid);
		DisablePlayerCheckpoint(playerid);
		RaceCrossCP[ playerid ] = 0;
		SendClientMessage(playerid, COLOR_ORANGE, "[CROSS EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 468 && RaceCrossCP[ killerid ] ) {
		RepairVehicle(vehicleid);
		
		new
			engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		
		SetVehicleToRespawn(vehicleid);
		DisablePlayerCheckpoint(killerid);
		RaceCrossCP[ killerid ] = 0;
		SendClientMessage(killerid, COLOR_ORANGE, "[CROSS EVENT]: Izbaceni ste iz eventa jer je vozilo unisteno!");
	}
	return 1;
}

hook OnPlayerEntRaceCP(playerid)
{
	switch(RaceCrossCP[playerid]) {
		case 1: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -406.3663,2590.7578,42.7658, -343.7102,2516.8899,35.7428, 20.0);
		}
		case 2: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -343.7102,2516.8899,35.7428, -98.6476,2439.8984,15.4386, 20.0);
		}
		case 3: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -98.6476,2439.8984,15.4386, -37.4195,2303.3188,24.9151, 20.0);
		}
		case 4: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -37.4195,2303.3188,24.9151, 314.2549,2291.8250,25.1492, 20.0);
		}
		case 5: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 314.2549,2291.8250,25.1492, 553.6786,2315.8584,33.4040, 20.0);
		}
		case 6: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 553.6786,2315.8584,33.4040, 614.6067,1997.4449,35.4941, 20.0);
		}
		case 7: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 614.6067,1997.4449,35.4941, 533.0906,1685.7010,11.3577, 20.0);
		}
		case 8: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 533.0906,1685.7010,11.3577, 304.1662,1275.1759,13.8636, 20.0);
		}
		case 9: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 304.1662,1275.1759,13.8636, 183.9863,1115.7041,15.4181, 20.0);
		}
		case 10: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 183.9863,1115.7041,15.4181, 383.2654,1096.7766,15.1831, 20.0);
		}
		case 11: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 383.2654,1096.7766,15.1831, 729.8656,1261.0449,14.7269, 20.0);
		}
		case 12: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 729.8656,1261.0449,14.7269, 740.6407,1536.3519,9.5249, 20.0);
		}
		case 13: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 740.6407,1536.3519,9.5249, 739.4002,1847.6581,5.5391, 20.0);
		}
		case 14: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 739.4002,1847.6581,5.5391, 659.7404,1863.2014,5.4688, 20.0);
		}
		case 15: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 659.7404,1863.2014,5.4688, 596.4747,1847.4574,15.0408, 20.0);
		}
		case 16: {
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 596.4747,1847.4574,15.0408, 586.5714,2196.2434,37.3366, 20.0);
		}
		case 17: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 586.5714,2196.2434,37.3366, 287.5100,2503.8208,16.1533, 20.0);
		}
		case 18: {
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            RaceCrossCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 1, 287.5100,2503.8208,16.1533, 0.0, 0.0, 0.0, 20.0);
		}
		/*case 19: {
			PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			va_SendClientMessageToAll(COLOR_GREEN, "*** %s je zavrsio cross utrku! ***", GetName(playerid, false));
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			RaceCrossCP[playerid] = 0;
		}*/
	}   return 1;
}

/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/
///////////////////////////////////////////////////////////////////
CMD:callcrossers(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /callcrossers [dio imena/playerid]");	
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage(playerid, COLOR_RED, "Krivi unos playerida!");
    if( RaceCrossCP[giveplayerid] != 0 ) return SendClientMessage(playerid, COLOR_RED, "Igrac se vec trka!");
	
	RaceCrossCP[giveplayerid] = 1;
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Pozvao te je admin %s na Anniversary Cross Race!", GetName(playerid, true));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Pozvao si %s na Anniversary Cross Race!", GetName(giveplayerid, true));
	return 1;
}
CMD:startcross(playerid, params[])
{
	DestroyDynamicObject(CrossFence);
	foreach(Player, i) {
		if( RaceCrossCP[ i ] == 1 ) {
			DisablePlayerCheckpoint(i);
			SetPlayerRaceCheckpoint(playerid, 0, -485.9677, 2592.9192, 52.9852, -406.3663,2590.7578,42.7658, 10.0);
		}
	}
	return 1;
}