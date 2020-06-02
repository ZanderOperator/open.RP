#include <YSI\y_hooks>

new
	kartgate1,
	kartgate2;
	
new
	Iterator:GoKartVehicles<7>;
	
new
	Iterator:GoKartPlayers<7>;

new
	bool:go_kart_approved[MAX_PLAYERS],
	bool:KartStarted,
	KartTimer,
	kart_count = 11;
	
new
	KartPlayerCP[MAX_PLAYERS],
	KartPlayerLap[MAX_PLAYERS];
	
	
new const Float:go_kart_cps[][3] =
{
    {2470.03296, -2097.62476, 12.53787},
	{2440.26953, -2101.48926, 12.54288},
	{2434.61792, -2129.42407, 12.54576},
	{2460.07324, -2128.65479, 12.54030},
	{2502.41211, -2120.61182, 12.54502},
	{2529.53296, -2113.88501, 12.54021},
	{2528.53418, -2082.21680, 12.54525},
	{2508.41650, -2083.59521, 12.54118}
	
};

hook OnGameModeInit()
{
    LoadKartMap();
	return 1;
}

hook OnGameModeExit()
{
	foreach(new v : GoKartVehicles)
	    DestroyVehicle(v);
	   
	Iter_Clear(GoKartVehicles); 
	return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5107, 2496.765, -2108.367, 19.500, 0.250);
	RemoveBuildingForPlayer(playerid, 3244, 2535.093, -2131.875, 12.992, 0.250);
	RemoveBuildingForPlayer(playerid, 3244, 2532.031, -2074.625, 12.992, 0.250);
	RemoveBuildingForPlayer(playerid, 3289, 2484.414, -2141.007, 12.187, 0.250);
	RemoveBuildingForPlayer(playerid, 3289, 2496.062, -2141.007, 12.187, 0.250);
	RemoveBuildingForPlayer(playerid, 3290, 2503.125, -2073.375, 12.429, 0.250);
	RemoveBuildingForPlayer(playerid, 3290, 2515.421, -2073.375, 12.406, 0.250);
	RemoveBuildingForPlayer(playerid, 3288, 2432.726, -2133.023, 12.453, 0.250);
	RemoveBuildingForPlayer(playerid, 3686, 2448.132, -2075.632, 16.046, 0.250);
	RemoveBuildingForPlayer(playerid, 3745, 2475.101, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3745, 2482.023, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3745, 2489.101, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3745, 2496.093, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3290, 2452.960, -2129.015, 25.273, 0.250);
	RemoveBuildingForPlayer(playerid, 3756, 2484.234, -2118.554, 17.703, 0.250);
	RemoveBuildingForPlayer(playerid, 3755, 2484.234, -2118.554, 17.703, 0.250);
	RemoveBuildingForPlayer(playerid, 5365, 2496.765, -2108.367, 19.500, 0.250);
	RemoveBuildingForPlayer(playerid, 5295, 2413.054, -2106.421, 23.054, 0.250);
	RemoveBuildingForPlayer(playerid, 5367, 2413.054, -2106.421, 23.054, 0.250);
	RemoveBuildingForPlayer(playerid, 3257, 2432.726, -2133.023, 12.453, 0.250);
	RemoveBuildingForPlayer(playerid, 3258, 2484.414, -2141.007, 12.187, 0.250);
	RemoveBuildingForPlayer(playerid, 3258, 2496.062, -2141.007, 12.187, 0.250);
	RemoveBuildingForPlayer(playerid, 3256, 2452.960, -2129.015, 25.273, 0.250);
	RemoveBuildingForPlayer(playerid, 3567, 2446.828, -2075.843, 13.257, 0.250);
	RemoveBuildingForPlayer(playerid, 3567, 2438.359, -2075.843, 13.257, 0.250);
	RemoveBuildingForPlayer(playerid, 3627, 2448.132, -2075.632, 16.046, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2428.390, -2066.632, 12.679, 0.250);
	RemoveBuildingForPlayer(playerid, 3643, 2489.101, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3643, 2482.023, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3643, 2475.101, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3643, 2496.093, -2073.476, 17.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3256, 2515.421, -2073.375, 12.406, 0.250);
	RemoveBuildingForPlayer(playerid, 3256, 2503.125, -2073.375, 12.429, 0.250);
	
/*	new jedan = CreatePlayerObject(playerid, 19427, 2445.0043, -2079.4658, 14.4268, 0.0000, 0.0000, 266.0456);
	SetPlayerObjectMaterialText(playerid, jedan, "1", 0, 130, "Arial", 24, 1, -16777216, 0, 1);
	new dva = CreatePlayerObject(playerid, 19427, 2444.0483, -2079.4694, 14.3068, 0.0000, 0.0000, 267.4177);
	SetPlayerObjectMaterialText(playerid, dva, "2", 0, 130, "Arial", 24, 1, -16777216, 0, 1);
	new tri = CreatePlayerObject(playerid, 19427, 2446.0275, -2079.4826, 14.3068, 0.0000, 0.0000, 261.0645);
	SetPlayerObjectMaterialText(playerid, tri, "3", 0, 130, "Arial", 24, 1, -16777216, 0, 1); */
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(go_kart_approved[playerid])
	{
		if(Iter_Contains(GoKartPlayers, playerid) && Iter_Count(GoKartPlayers) == 1)
		{
            KartStarted = false;

			SetObjectPos(kartgate1, 2469.35254, -2100.46069, 13.21661);
			SetObjectPos(kartgate2, 2469.34692, -2095.66162, 13.21661);

			SendClientMessageToAll(0x33AA33AA, "* Karting utrka je zavrSena!");

			go_kart_approved[playerid] = false;
		    Iter_Remove(GoKartPlayers, playerid);
		    KartPlayerLap[playerid] = 0;
		    KartPlayerCP[playerid] = 0;
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
        if(IsAKartEventVehicle(GetPlayerVehicleID(playerid)))
    	{
    	    if(go_kart_approved[playerid])
        	{
        	    //SetPlayerCheckpoint(playerid, go_kart_cps[0][0], go_kart_cps[0][1], go_kart_cps[0][2], 10.0);
        	    TogglePlayerControllable(playerid, 0);
        	    SendClientMessage(playerid, COLOR_RED, "[ ! ] USli ste u kart vozilo! Prièekajte ostale igraèe kako bi utrka zapoèela!");
			}
        	else RemovePlayerFromVehicle(playerid);
    	}
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(go_kart_approved[playerid] && IsPlayerInAnyVehicle(playerid))
	{
	    if(IsAKartEventVehicle(GetPlayerVehicleID(playerid)))
	    {
			if(KartPlayerLap[playerid] == 3)
			{
			    new
					p_k_name[24];

			    GetPlayerName(playerid, p_k_name, 24);
			    va_SendClientMessageToAll(0x33AA33AA, "* %s je zavrSio kart utrku!", p_k_name);
			    KartPlayerCP[playerid] = 0;
			    KartPlayerLap[playerid] = 0;
			    
			    DisablePlayerCheckpoint(playerid);
			    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			    go_kart_approved[playerid] = false;

				if(Iter_Count(GoKartPlayers) == 1)
			    {
			    	KartStarted = false;

					SetObjectPos(kartgate1, 2469.35254, -2100.46069, 13.21661);
					SetObjectPos(kartgate2, 2469.34692, -2095.66162, 13.21661);
					
					SendClientMessageToAll(0x33AA33AA, "* Karting utrka je zavrSena!");

					Iter_Remove(GoKartPlayers, playerid);
					return 1;
				}
				Iter_Remove(GoKartPlayers, playerid);
				
				return 1;
			}

			if(KartPlayerCP[playerid] == (sizeof(go_kart_cps) - 1))
			    KartPlayerCP[playerid] = 0, KartPlayerLap[playerid] ++;
			else
				KartPlayerCP[playerid] ++;
			
			new
	            cp = KartPlayerCP[playerid];
	            
			DisablePlayerCheckpoint(playerid);

			SetPlayerCheckpoint(playerid, go_kart_cps[cp][0], go_kart_cps[cp][1], go_kart_cps[cp][2], 5.0);
	    }
	}
    return 1;
}

IsAKartEventVehicle(vehid)
{
	if(Iter_Contains(GoKartVehicles, vehid))
	    return 1;

	return 0;
}

LoadKartMap()
{
	new
		carid;
	
	carid = AC_CreateVehicle(571, 2471.8647, -2100.1311, 12.8026, 89.7000, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);

	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;

	carid = AC_CreateVehicle(571, 2471.8711, -2098.0508, 12.8026, 89.0400, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);
	
	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;
	
	carid = AC_CreateVehicle(571, 2471.8391, -2095.8110, 12.8026, 89.2800, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);
	
	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;

	carid = AC_CreateVehicle(571, 2471.7610, -2093.5925, 12.8026, 89.2800, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);
	
	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;
	
	carid = AC_CreateVehicle(571, 2471.6714, -2091.3679, 12.8026, 89.2800, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);
	
	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;
	
	carid = AC_CreateVehicle(571, 2471.8684, -2102.2727, 12.8026, 89.7000, -1, -1, 100);
	Iter_Add(GoKartVehicles, carid);
	
	VehicleInfo[carid][vHealth] = 1000.0;
	VehicleInfo[carid][vFuel] = 100;
	VehicleInfo[carid][vCanStart] = 1;
	VehicleInfo[carid][vUsage] = VEHICLE_USAGE_NORMAL;


	//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
	new tmpobjid;
	tmpobjid = CreateDynamicObject(5107,2496.765,-2108.367,19.500,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14569, "traidman", "darkgrey_carpet_256", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 14569, "traidman", "darkgrey_carpet_256", 0);
	SetDynamicObjectMaterial(tmpobjid, 3, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(979,2464.385,-2089.131,12.954,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(3819,2460.606,-2073.304,17.406,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(979,2474.385,-2089.062,12.954,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2483.658,-2089.051,12.954,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2474.360,-2107.721,12.954,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2483.656,-2107.712,12.954,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2492.364,-2086.934,12.954,0.000,0.000,207.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2492.334,-2105.344,12.954,0.000,0.000,30.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2499.098,-2099.181,12.954,0.000,0.000,55.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2500.773,-2082.916,12.954,0.000,0.000,204.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2505.217,-2092.375,12.954,0.000,0.000,41.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2508.667,-2078.289,12.954,0.000,0.000,216.478,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2512.378,-2086.450,12.954,0.000,0.000,38.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2520.559,-2084.026,12.954,0.000,0.000,-5.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2517.129,-2075.974,12.954,0.000,0.000,174.269,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2526.298,-2076.795,12.954,0.000,0.000,175.508,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2527.263,-2088.462,12.954,0.000,0.000,-62.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2533.043,-2081.383,12.954,0.000,0.000,116.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2530.075,-2097.078,12.954,0.000,0.000,-82.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2535.862,-2090.182,12.954,0.000,0.000,100.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2536.263,-2099.418,12.954,0.000,0.000,85.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2530.386,-2106.228,12.954,0.000,0.000,266.052,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2525.592,-2111.151,12.954,0.000,0.000,185.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2536.992,-2108.538,12.954,0.000,0.000,103.952,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2533.661,-2114.781,12.954,0.000,0.000,20.939,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2529.482,-2120.939,12.954,0.000,0.000,91.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2521.187,-2116.283,12.954,0.000,0.000,273.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2523.334,-2124.958,12.954,0.000,0.000,295.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2531.577,-2129.533,12.954,0.000,0.000,117.364,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2529.043,-2134.551,12.954,0.000,0.000,12.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2520.844,-2130.098,12.954,0.000,0.000,193.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2514.577,-2126.981,12.954,0.000,0.000,116.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2520.115,-2136.624,12.954,0.000,0.000,14.223,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2512.359,-2134.683,12.954,0.000,0.000,316.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2505.692,-2128.253,12.954,0.000,0.000,316.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2508.337,-2120.919,12.954,0.000,0.000,156.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2502.334,-2114.802,12.954,0.000,0.000,113.392,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2499.484,-2121.495,12.954,0.000,0.000,309.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2495.827,-2111.539,12.954,0.000,0.000,193.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2493.299,-2120.901,12.954,0.000,0.000,42.026,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2487.710,-2115.499,12.954,0.000,0.000,219.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2480.910,-2130.519,12.954,0.000,0.000,219.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2490.783,-2128.432,12.954,0.000,0.000,101.117,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2484.311,-2123.035,12.954,0.000,0.000,271.433,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2487.900,-2135.833,12.954,0.000,0.000,36.523,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2479.470,-2138.577,12.954,0.000,0.000,360.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2472.870,-2133.405,12.954,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2470.234,-2139.106,12.954,0.000,0.000,6.446,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2463.017,-2135.895,12.954,0.000,0.000,-55.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2464.935,-2130.220,12.954,0.000,0.000,136.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2461.549,-2122.418,12.954,0.000,0.000,91.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2456.644,-2129.430,12.954,0.000,0.000,324.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2457.026,-2119.343,12.954,0.000,0.000,200.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2448.312,-2122.504,12.954,0.000,0.000,200.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2448.771,-2128.725,12.954,0.000,0.000,25.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2440.426,-2132.612,12.954,0.000,0.000,25.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2439.629,-2125.664,12.954,0.000,0.000,200.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2432.810,-2131.412,12.954,0.000,0.000,316.721,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2430.877,-2123.744,12.954,0.000,0.000,251.741,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2437.076,-2123.077,12.954,0.000,0.000,-291.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2440.423,-2114.419,12.954,0.000,0.000,-291.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2432.920,-2114.838,12.954,0.000,0.000,-98.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2464.421,-2107.493,12.954,0.000,0.000,-360.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2455.238,-2090.173,12.954,0.000,0.000,193.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2443.094,-2105.751,12.954,0.000,0.000,76.987,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2448.364,-2101.408,12.954,0.000,0.000,358.422,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2456.261,-2104.494,12.954,0.000,0.000,-40.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2446.530,-2093.302,12.954,0.000,0.000,206.798,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2438.626,-2098.234,12.954,0.000,0.000,217.167,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(979,2434.246,-2105.656,12.954,0.000,0.000,-98.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(19445,2469.310,-2102.147,10.807,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(19445,2469.305,-2094.510,10.810,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(18767,2435.718,-2076.156,9.170,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2445.624,-2079.157,11.573,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2445.628,-2077.153,13.579,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18767,2435.718,-2075.156,9.170,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2445.628,-2075.146,11.572,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2450.131,-2077.150,9.077,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2441.113,-2077.151,9.077,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18981,2492.647,-2070.493,9.520,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18981,2467.655,-2070.500,9.520,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2460.151,-2072.507,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2460.154,-2077.500,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2470.135,-2072.515,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2480.125,-2072.511,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2490.110,-2072.501,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2500.102,-2072.495,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2455.648,-2072.512,17.012,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2504.649,-2072.500,17.019,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18981,2467.662,-2079.514,4.065,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2470.144,-2077.501,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18981,2492.644,-2079.509,4.057,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2480.136,-2077.506,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2490.123,-2077.506,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2500.109,-2077.502,16.068,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2504.647,-2077.499,11.563,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18766,2455.648,-2077.507,11.563,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18767,2450.432,-2076.052,11.654,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(18767,2450.432,-2075.058,11.654,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14569, "traidman", "darkgrey_carpet_256", 0);
	tmpobjid = CreateDynamicObject(3819,2470.334,-2073.304,17.406,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(3819,2480.174,-2073.304,17.406,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(3819,2489.916,-2073.304,17.406,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(3819,2499.709,-2073.304,17.406,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	SetDynamicObjectMaterial(tmpobjid, 2, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(18762,2442.444,-2079.055,12.448,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
	tmpobjid = CreateDynamicObject(18762,2444.016,-2079.054,11.982,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(18762,2445.018,-2079.054,12.118,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(18762,2446.016,-2079.054,11.982,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0);
	tmpobjid = CreateDynamicObject(8673,2465.724,-2079.883,15.748,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(8673,2486.126,-2079.884,15.748,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(8673,2495.132,-2079.881,15.748,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(11474,2505.280,-2078.430,16.562,0.000,0.000,95.652,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(11474,2505.299,-2075.487,16.708,0.000,0.000,95.652,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	tmpobjid = CreateDynamicObject(11474,2455.358,-2076.247,16.708,0.000,0.000,95.652,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3306, "cunte_house1", "pinkfence_law", 0);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(18761,2469.367,-2098.352,17.555,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2894,2442.520,-2078.897,14.939,0.000,0.000,-180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19610,2442.477,-2079.137,15.553,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(19611,2442.477,-2079.245,13.935,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	
	kartgate1 = CreateObject(1653, 2469.35254, -2100.46069, 13.21661,   0.00000, 0.00000, -90.05998);
	kartgate2 = CreateObject(1653, 2469.34692, -2095.66162, 13.21661,   0.00000, 0.00000, -90.05998);
}

CMD:karthelp(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");

	SendClientMessage(playerid, -1, "/karto, /kartc, /startkart(kad svi udju u vozila), /approvekart (id/ime)");
	SendClientMessage(playerid, -1, "/removefromkart (id/ime), /gotokart, /karters ( lista svih trkaca) ");
	return 1;
}

forward OnCountDownKart();
public OnCountDownKart()
{
	new
	    shwstr[15];
	    
	foreach(new playerid : GoKartPlayers)
	{
		PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);

		format(shwstr, 15, "~w~%d", kart_count - 1);
		GameTextForPlayer(playerid, shwstr, 1000, 4);
	}
	kart_count --;

	if(!kart_count)
	{
	    if(KartStarted)
	    {
            foreach(new i : GoKartPlayers)
			{
				KartPlayerCP[i] = 1;
				SetPlayerCheckpoint(i, go_kart_cps[1][0], go_kart_cps[1][1], go_kart_cps[1][2], 5.0);
				TogglePlayerControllable(i, 1);
			}
			SetObjectPos(kartgate1, 2469.35254, -2100.46069, 11.29773);
			SetObjectPos(kartgate2, 2469.34692, -2095.66162, 11.29773);
		}

		GameTextForAll("~g~GO GO GO", 2500, 4);

		foreach(new x : GoKartPlayers)
		{
			PlayerPlaySound(x, 1057, 0.0, 0.0, 0.0);
		}
		KillTimer(KartTimer);
	}
	return 1;
}

CMD:startkart(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");
	    
	if(!Iter_Count(GoKartPlayers))
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nema dovoljno igraca kako bi se zapocela utrka!");
	    
	if(KartStarted)
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Kart je vec pokrenut! Koristite /karters kako bi vidjeli listu igraca.");

	KartStarted = true;
	kart_count = 11;
	KartTimer = SetTimer("OnCountDownKart", 1000, true);
	return 1;
}

CMD:karto(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");

	SetObjectPos(kartgate1, 2469.35254, -2100.46069, 11.29773);
	SetObjectPos(kartgate2, 2469.34692, -2095.66162, 11.29773);
	return 1;
}

CMD:kartc(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");
	    
 	SetObjectPos(kartgate1, 2469.35254, -2100.46069, 13.21661);
	SetObjectPos(kartgate2, 2469.34692, -2095.66162, 13.21661);
	return 1;
}

CMD:approvekart(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");
		
	if(KartStarted)
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Ne moZete dodavati igrace zato Sto je joS utrka u toku!"), SendClientMessage(playerid, 0xfa5555AA, "Koristi /karters te kickaj preostalog igraca kako bi utrka zavrsila!");
		
	new
	    user;

	if(sscanf(params, "u", user))
	    return SendClientMessage(playerid, -1, "KORISTI: /approvekart [Ime/IdIgraca]");
	    
	if(go_kart_approved[user])
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Igrac je vec pozvan na go kart!");
	    
	if(user == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nepoznati igrac!");
	    
	if(Iter_Count(GoKartPlayers) == 6)
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Samo 6 igraca moze sudjelovati u eventu u jednoj trci!");
	    
    go_kart_approved[user] = true;
    
    if(!Iter_Contains(GoKartPlayers, user))
    	Iter_Add(GoKartPlayers, user);
    
    SendClientMessage(playerid, -1, "Dopustio si igracu da udje u go-kart!");
    
    SendClientMessage(user, -1, "Odobren vam je go kart! Udjite u go-kart i stanite na startu!");
    return 1;
}

CMD:removefromkart(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");
		
 	if(Iter_Count(GoKartPlayers) == 0)
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Nema igraca u utrci!");

	new
	    user;

	if(sscanf(params, "u", user))
	    return SendClientMessage(playerid, -1, "KORISTI: /approvekart [Ime/IdIgraca]");

	if(!Iter_Contains(GoKartPlayers, user))
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Taj igrac nije u utrci!");
		
	Iter_Remove(GoKartPlayers, user);
	
	DisablePlayerCheckpoint(playerid);
	
	go_kart_approved[user] = false;

	if(Iter_Count(GoKartPlayers) == 0)
	{
	    KartStarted = false;

		SetObjectPos(kartgate1, 2469.35254, -2100.46069, 13.21661);
		SetObjectPos(kartgate2, 2469.34692, -2095.66162, 13.21661);
		
		KartPlayerCP[playerid] = 0;
  		KartPlayerLap[playerid] = 0;

		SendClientMessageToAll(0x33AA33AA, "* Karting utrka je zavrSena!");
	}
	return 1;
}

CMD:gotokart(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");

	SetPlayerPos(playerid, 2469.1602,-2086.4277,13.5469);
	return 1;
}

CMD:karters(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Nisi admin!");
		
	new
	    count = 0;

	foreach(new i : GoKartPlayers)
	{
		va_SendClientMessage(playerid, -1, "[%d] %s[%d]", count, ReturnName(i), i);

		++ count;
	}

	if(!count)
	    return SendClientMessage(playerid,COLOR_RED, "ERROR: Nema igraca koji koriste kart!");

	return 1;
}
