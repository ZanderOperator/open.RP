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

new
	RaceBoatCP[MAX_PLAYERS];

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
stock static CreateEventBoat(modelid, Float:X, Float:Y, Float:Z, Float:Rot, color1, color2, respawn)
{
	new
		carid = CreateVehicle(modelid, X, Y, Z, Rot, color1, color2, respawn);
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

stock static CreateBoatsForRace()
{
	CreateEventBoat(446, -799.5344, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -787.8848, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -777.1486, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -764.8141, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -751.7964, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -739.1390, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -726.0422, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -712.7075, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -699.2497, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -685.5453, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -670.5608, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -655.5845, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -640.6052, 1921.8101, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -799.5344, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -623.8066, 1921.8082, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -787.8848, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -777.1486, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -764.8141, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -751.7964, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -739.1390, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -726.0422, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -712.7075, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -699.2497, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -685.5453, 1941.2097, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -670.5608, 1942.1493, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -655.5845, 1942.6635, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -640.5853, 1942.6635, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -623.8066, 1942.6635, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -777.1486, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -764.8141, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -751.7964, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -739.1390, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -726.0422, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -712.7075, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -699.2497, 1940.8551, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -699.2497, 1981.3744, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -670.5608, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -655.5845, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -640.5853, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -787.8848, 1960.6688, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -751.7964, 1981.3767, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -739.1390, 1981.3767, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -726.0621, 1981.3757, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -712.7275, 1981.3744, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -685.5453, 1961.3893, -0.4935, 180.0000, -1, -1, 100);
	CreateEventBoat(446, -685.5652, 1981.3757, -0.4935, 180.0000, -1, -1, 100);
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
	CreateBoatsForRace();
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( newstate == PLAYER_STATE_DRIVER ) {
		if( VehicleInfo[ GetPlayerVehicleID(playerid) ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(GetPlayerVehicleID(playerid)) == 446 && !RaceBoatCP[ playerid ] ) {
			RemovePlayerFromVehicle(playerid);
			SendClientMessage(playerid, COLOR_RED, "ERROR: Niste unutar Anniversary Boat Race eventa!");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 446 && RaceBoatCP[ playerid ] ) {
		RepairVehicle(vehicleid);
		
		new
			engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		
		SetVehicleToRespawn(vehicleid);
		DisablePlayerCheckpoint(playerid);
		RaceBoatCP[ playerid ] = 0;
		SendClientMessage(playerid, COLOR_ORANGE, "[BOAT EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 446 && RaceBoatCP[ killerid ] ) {
		RepairVehicle(vehicleid);
		
		new
			engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		
		SetVehicleToRespawn(vehicleid);
		DisablePlayerCheckpoint(killerid);
		RaceBoatCP[ killerid ] = 0;
		SendClientMessage(killerid, COLOR_ORANGE, "[BOAT EVENT]: Izbaceni ste iz eventa jer je vozilo unisteno!");
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	RaceBoatCP[playerid] = 0;
	return 1;
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
CMD:callboaters(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni!");
	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /callboaters [dio imena/playerid]");	
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage(playerid, COLOR_RED, "ERROR: Krivi unos playerida!");
    if( RaceBoatCP[giveplayerid] != 0 ) return SendClientMessage(playerid, COLOR_RED, "ERROR: Igrac se vec trka!");
	
	RaceBoatCP[giveplayerid] = 1;
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Pozvao te je admin %s na Anniversary Boat Race!", GetName(playerid, true));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Pozvao si %s na Anniversary Boat Race!", GetName(giveplayerid, true));
	return 1;
}

CMD:startboat_race(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni!");
	foreach(Player, i) {
		if( RaceBoatCP[ i ] == 1 ) {
			DisablePlayerCheckpoint(i);
			SetPlayerRaceCheckpoint(i, 0, -715.9678,1781.8000,-0.5890, -496.8011,1477.9352,-0.4942, 30.0);
		}
	}
	return 1;
}