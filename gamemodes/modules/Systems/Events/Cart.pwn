#include <YSI\y_hooks>

new Float:kartcp[][4] =
{
	{1058.18372, -1324.94470, 12.34107},
	{1057.73535, -1400.59485, 12.44075},
	{1200.97314, -1400.95239, 12.26449},
	{1202.09460, -1281.60681, 12.33272},
	{1216.67090, -1145.41980, 22.44813},
	{1342.45471, -1145.57251, 22.67404},
	{1342.59473, -1402.22742, 12.28235},
	{1389.55701, -1451.41345, 12.35508},
	{1354.86292, -1580.19775, 12.36831},
	{1348.00464, -1732.38660, 12.37227},
	{1336.66846, -1855.35303, 12.36849},
	{1672.92590, -1868.81995, 12.37166},
	{1689.55627, -1814.25452, 12.37027},
	{1821.92297, -1832.44421, 12.39589},
	{1961.75659, -1862.93115, 12.36786},
	{1961.70239, -1978.92078, 12.37497},
	{2065.04395, -1983.66016, 12.53837},
	{2222.53418, -2141.58716, 12.37193},
	{2200.28418, -2163.58252, 12.36646},
	{2294.18091, -2259.77515, 12.37307},
	{2291.49292, -2338.73145, 12.53911}
};

new
	RaceKartCP[MAX_PLAYERS],
	kartgate;
	
stock static CreateEventKart(modelid, Float:X, Float:Y, Float:Z, Float:Rot, color1, color2, respawn)
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

stock static CreateKartVehicles()
{
	CreateEventKart(571, 738.9493, -1350.0792, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.9493, -1350.0792, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.8699, -1347.4766, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.7038, -1345.0448, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.6380, -1342.7260, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.5175, -1340.5486, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.4572, -1338.3696, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.2972, -1336.1932, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 738.3088, -1333.6729, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 741.6757, -1333.5836, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 741.8176, -1335.8755, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 741.7711, -1338.2167, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 741.9067, -1340.3030, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 742.0237, -1342.5085, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 742.0812, -1344.7041, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 742.1545, -1347.1868, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 742.2484, -1349.7933, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.5289, -1349.6647, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.5297, -1346.9720, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.4723, -1344.3917, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.3005, -1342.2794, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.2295, -1340.0409, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 745.0670, -1337.8689, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 744.9646, -1335.8279, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 744.8842, -1333.6488, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.1608, -1333.4664, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.2748, -1335.6246, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.2283, -1337.7666, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.2808, -1339.8660, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.2578, -1342.1472, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.4503, -1344.2432, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.4559, -1346.8640, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 748.5416, -1349.4827, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.2772, -1333.2826, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.2978, -1335.5228, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.3970, -1337.7013, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.4555, -1339.8606, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.5707, -1341.8983, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.5270, -1343.9803, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.6799, -1346.6772, 12.8256, -88.0200, -1, -1, 100);
	CreateEventKart(571, 751.8096, -1349.2549, 12.8256, -88.0200, -1, -1, 100);
}

hook OnGameModeInit()
{
    CreateKartVehicles();
	kartgate = CreateDynamicObject(982, 827.94257, -1323.78894, 13.01499, 0.0, 0.0, 0.0, -1, -1, -1, 100.0, 200.0);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(RaceKartCP[playerid] == 1) {
	    RaceKartCP[playerid] = 0;
	    SetPlayerColor(playerid, COLOR_PLAYER);

		if(IsPlayerInAnyVehicle(playerid)) {
            new
				kartid;

			kartid = GetPlayerVehicleID(playerid);
			SetVehicleToRespawn(kartid);
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if( VehicleInfo[ vehicleid ][ vUsage ] == VEHICLE_USAGE_EVENT && GetVehicleModel(vehicleid) == 571 && RaceKartCP[ playerid ] ) {
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
    if(newstate == PLAYER_STATE_DRIVER)
	{
        if(VehicleInfo[GetPlayerVehicleID(playerid)][vUsage] == VEHICLE_USAGE_EVENT && GetVehicleModel(GetPlayerVehicleID(playerid)) == 571 && !RaceKartCP[playerid])
		{
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_RED, "Niste unutar Anniversary Kart Race eventa!");
            return 1;
        }
    }
    return 1;
}

CMD:callkarters(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");

	new
        giveplayerid;
    if(sscanf(params, "u", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /callkarters [ime/playerid]");

	if(giveplayerid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_RED, "Krivi unos playerida!");

	if(RaceKartCP[giveplayerid] != 0)
		return SendClientMessage(playerid, COLOR_RED, "Taj igraè je veæ u utrci!");


    RaceKartCP[giveplayerid] = 1;
    SetPlayerColor(giveplayerid, COLOR_RED);
    va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Pozvao te je admin %s na Anniversary Kart Race!", GetName(playerid, true));
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Pozvao si %s na Anniversary Kart Race!", GetName(giveplayerid, true));
    return 1;
}

CMD:karto(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");
	
	foreach(Player, i)
	{
	    if(RaceKartCP[i] == 1)
	    {
			SetPlayerRaceCheckpoint(playerid, 0, 831.44495, -1324.22131, 12.38826, kartcp[0][0], kartcp[0][1], kartcp[0][2], 10.0);
		}
	}
	MoveDynamicObject(kartgate, 827.94257, -1323.78894, 9.75610, 5.0, 0.0, 0.0, 0.0);
	return 1;
}

CMD:kartc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");

    MoveDynamicObject(kartgate, 827.94257, -1323.78894, 13.01499, 5.0, 0.0, 0.0, 0.0);
    
    SendClientMessage(playerid, COLOR_RED, "[ ! ] Zatvorio si go-kart ogradu!");
	return 1;
}

CMD:gotokart(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	    return SendClientMessage(playerid, COLOR_RED, "NemoZeS koristiti ovu komandu");

	SetPlayerPos(playerid, kartcp[0][0], kartcp[0][1], kartcp[0][2]);
	return 1;
}