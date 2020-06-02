#include <YSI\y_hooks>

new Float:nrgcp[][4] = {
	{1338.98694, -2410.35889, 12.49472},
	{1362.41077, -2166.00146, 12.52974},
	{1607.36487, -2089.50513, 18.17701},
	{1659.70667, -1965.10217, 22.85061},
	{1602.46057, -1649.01807, 27.69270},
	{1604.62634, -1349.95300, 28.71843},
	{1624.48596, -1229.16821, 49.72134},
	{1701.00830, -717.76807, 47.65150},
	{1677.50269, -372.93561, 39.83967},
	{1662.63708, -82.41007, 34.63660},
	{1610.90857, 97.32083, 36.48319},
	{1705.92700, 429.52759, 30.86723},
	{1785.13416, 689.76355, 14.90642},
	{1797.53821, 844.02563, 9.59014},
	{1797.48096, 1567.49609, 5.66172},
	{1746.68188, 1639.82019, 7.89821},
	{1715.11023, 1604.19116, 9.00097},
	{1340.36169, 1302.96863, 9.79645}
};

new
	RaceNRGCP[MAX_PLAYERS],
	nrggate;

stock static CreateEventNRG(modelid, Float:X, Float:Y, Float:Z, Float:Rot, color1, color2, respawn)
{
	new
		carid = CreateVehicle(modelid, X, Y, Z, Rot, color1, color2, respawn);
    ResetVehicleInfo(carid);

    VehicleInfo[ carid ][ vModel ]      = modelid;
    VehicleInfo[ carid ][ vColor1 ]     = color1;
    VehicleInfo[ carid ][ vColor2 ]     = color2;
    VehicleInfo[ carid ][ vParkX ]      = X;
    VehicleInfo[ carid ][ vParkY ]      = Y;
    VehicleInfo[ carid ][ vParkZ ]      = Z;
    VehicleInfo[ carid ][ vAngle ]      = 0.0;
    VehicleInfo[ carid ][ vHealth ]     = 1000.0;
    VehicleInfo[ carid ][ vType ]       = VEHICLE_TYPE_CAR;
    VehicleInfo[ carid ][ vUsage ]      = VEHICLE_USAGE_EVENT;

	new
		engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
    SetVehicleParamsEx(carid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
    return 1;
}

stock static CreateNRGVehicles()
{
	CreateEventNRG(522, 1315.6259, -2603.5007, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1315.2249, -2601.5410, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1314.8268, -2599.6819, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1314.5031, -2597.9702, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1314.1660, -2596.2822, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1313.8314, -2594.7793, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1313.5767, -2593.0925, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1313.2156, -2591.3901, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1312.8738, -2589.8677, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1312.4626, -2588.1963, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1312.1089, -2586.6541, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1315.8995, -2585.1643, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1316.4072, -2586.6619, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1316.9076, -2588.3293, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1317.2550, -2589.7905, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1317.6398, -2591.4270, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1317.9795, -2593.1387, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1318.2893, -2594.6726, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1318.5027, -2596.3792, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1318.9552, -2597.9763, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1319.4347, -2599.8147, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1319.8538, -2601.5874, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1316.2780, -2605.5215, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1320.4540, -2603.5803, 12.9871, -66.7200, -1, -1, 100);
	CreateEventNRG(522, 1319.0273, -2583.9663, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1319.4972, -2585.3347, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1319.9147, -2587.0854, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1320.3781, -2588.5994, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1320.7915, -2590.2485, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1321.2484, -2591.9077, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1321.6304, -2593.3381, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1321.9817, -2594.8992, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1322.4230, -2596.6648, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1322.8782, -2598.4888, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1323.3612, -2599.9978, 12.9871, -68.3400, -1, -1, 100);
	CreateEventNRG(522, 1324.0221, -2602.0811, 12.9871, -68.3400, -1, -1, 100);
}
	
hook OnGameModeInit()
{
    CreateNRGVehicles();
	nrggate = CreateDynamicObject(982, 1339.31201, -2504.64624, 13.06570,   0.00000, 0.00000, -90.30004);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(RaceNRGCP[playerid] == 1) {
	    RaceNRGCP[playerid] = 0;
	    SetPlayerColor(playerid, COLOR_PLAYER);

		if(IsPlayerInAnyVehicle(playerid))
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 522 && RaceNRGCP[ playerid ] ) {
		RepairVehicle(vehicleid);
		
		new
			engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		
		SetVehicleToRespawn(vehicleid);
		DisablePlayerCheckpoint(playerid);
		RaceKartCP[ playerid ] = 0;
		SendClientMessage(playerid, COLOR_ORANGE, "[CROSS EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER) {
        if(VehicleInfo[GetPlayerVehicleID(playerid)][vUsage] == VEHICLE_USAGE_EVENT && GetVehicleModel(GetPlayerVehicleID(playerid)) == 522 && !RaceNRGCP[playerid])
		{
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_RED, "ERROR: Niste unutar Anniversary NRG Race eventa!");
            return 1;
        }
    }
    return 1;
}

CMD:callnrgs(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2)
		return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni!");

	new
        giveplayerid;
        
    if(sscanf(params, "u", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /callnrgs [ime/playerid]");

	if(giveplayerid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_RED, "ERROR: Krivi unos playerida!");

	if(RaceNRGCP[giveplayerid] != 0)
		return SendClientMessage(playerid, COLOR_RED, "ERROR: Taj igraè je veæ u utrci!");


    RaceNRGCP[giveplayerid] = 1;
    SetPlayerColor(giveplayerid, COLOR_RED);
    
    va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Pozvao te je admin %s na Anniversary NRG Race!", GetName(playerid, true));
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Pozvao si %s na Anniversary NRG Race!", GetName(giveplayerid, true));
    return 1;
}

CMD:nrgo(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");
	
	foreach(Player, i)
	{
	    if(RaceNRGCP[i] == 1)
	    {
			SetPlayerRaceCheckpoint(playerid, 0, 1339.1099, -2488.4631, 12.5340, nrgcp[0][0], nrgcp[0][1], nrgcp[0][2], 30.0);
		}
	}
	MoveDynamicObject(nrggate, 1339.31201, -2504.64624, 10.95230, 5.0, 0.0, 0.0, 0.0);
	SendClientMessageToAll(COLOR_GREEN, "[ANNOUNCMENT]: NRG Race je zapoèeo!");
	return 1;
}

CMD:nrgc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");

    MoveDynamicObject(nrggate, 827.94257, -1323.78894, 13.01499, 5.0, 0.0, 0.0, 0.0);
    
    SendClientMessage(playerid, COLOR_RED, "[ ! ] Zatvorio si nrg ogradu!");
	return 1;
}

CMD:gotonrg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");

	SetPlayerPos(playerid, nrgcp[0][0], nrgcp[0][1], nrgcp[0][2]);
	return 1;
}