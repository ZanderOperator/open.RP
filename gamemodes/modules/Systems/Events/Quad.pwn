//= 10/06/2019 - L3o.
#include <YSI\y_hooks>

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (defines)
#define MAX_PLAYERS_ON_QEVENT (21)

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (vars)
new QuadPlayer[MAX_PLAYERS],
	QuadPlayerCP[MAX_PLAYERS],
	QuadCountTimer,
	quad_counter = 0,
	bool: quad_created = false,
	quadograda,
	quadcar[21];

static stock
		count,
		QuadStarted 		= 0,
		FirstQuadWinner		= 999,
		SecondQuadWinner	= 999,
		ThirdQuadWinner		= 999;

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (functions)
stock CreateQuadVehicles()
{
	quadcar[0] = CreateVehicle(471, -345.9333, 1512.9717, 74.8404, 0.5431, 0, 0, 0); VehicleInfo[quadcar[0]][vHealth] = 1000.0; VehicleInfo[quadcar[0]][vFuel] = 100; VehicleInfo[quadcar[0]][vCanStart] = 1; VehicleInfo[quadcar[0]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[1] = CreateVehicle(471, -345.9785, 1517.7310, 74.8401, 0.5431, 0, 0, 0); VehicleInfo[quadcar[1]][vHealth] = 1000.0; VehicleInfo[quadcar[1]][vFuel] = 100; VehicleInfo[quadcar[1]][vCanStart] = 1; VehicleInfo[quadcar[1]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[2] = CreateVehicle(471, -342.8741, 1513.0007, 74.8416, 0.3656, 0, 0, 0); VehicleInfo[quadcar[2]][vHealth] = 1000.0; VehicleInfo[quadcar[2]][vFuel] = 100; VehicleInfo[quadcar[2]][vCanStart] = 1; VehicleInfo[quadcar[2]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[3] = CreateVehicle(471, -342.9041, 1517.7344, 74.8401, 0.3656, 0, 0, 0); VehicleInfo[quadcar[3]][vHealth] = 1000.0; VehicleInfo[quadcar[3]][vFuel] = 100; VehicleInfo[quadcar[3]][vCanStart] = 1; VehicleInfo[quadcar[3]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[4] = CreateVehicle(471, -339.7604, 1513.0337, 74.8403, 0.3983, 0, 0, 0); VehicleInfo[quadcar[4]][vHealth] = 1000.0; VehicleInfo[quadcar[4]][vFuel] = 100; VehicleInfo[quadcar[4]][vCanStart] = 1; VehicleInfo[quadcar[4]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[5] = CreateVehicle(471, -339.7913, 1517.4854, 74.8410, 0.3982, 0, 0, 0); VehicleInfo[quadcar[5]][vHealth] = 1000.0; VehicleInfo[quadcar[5]][vFuel] = 100; VehicleInfo[quadcar[5]][vCanStart] = 1; VehicleInfo[quadcar[5]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[6] = CreateVehicle(471, -336.5557, 1512.9956, 74.8402, 0.8548, 0, 0, 0); VehicleInfo[quadcar[6]][vHealth] = 1000.0; VehicleInfo[quadcar[6]][vFuel] = 100; VehicleInfo[quadcar[6]][vCanStart] = 1; VehicleInfo[quadcar[6]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[7] = CreateVehicle(471, -336.6248, 1517.6135, 74.8385, 0.8548, 0, 0, 0); VehicleInfo[quadcar[7]][vHealth] = 1000.0; VehicleInfo[quadcar[7]][vFuel] = 100; VehicleInfo[quadcar[7]][vCanStart] = 1; VehicleInfo[quadcar[7]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[8] = CreateVehicle(471, -333.4187, 1512.9806, 74.8401, 359.2111, 0, 0, 0); VehicleInfo[quadcar[8]][vHealth] = 1000.0; VehicleInfo[quadcar[8]][vFuel] = 100; VehicleInfo[quadcar[8]][vCanStart] = 1; VehicleInfo[quadcar[8]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[9] = CreateVehicle(471, -333.3742, 1517.6940, 74.8403, 0.5483, 0, 0, 0); VehicleInfo[quadcar[9]][vHealth] = 1000.0; VehicleInfo[quadcar[9]][vFuel] = 100; VehicleInfo[quadcar[9]][vCanStart] = 1; VehicleInfo[quadcar[9]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[10] = CreateVehicle(471, -330.3658, 1512.9504, 74.8410, 359.6682, 0, 0, 0); VehicleInfo[quadcar[10]][vHealth] = 1000.0; VehicleInfo[quadcar[10]][vFuel] = 100; VehicleInfo[quadcar[10]][vCanStart] = 1; VehicleInfo[quadcar[10]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[11] = CreateVehicle(471, -330.3458, 1517.6726, 74.8402, 0.1407, 0, 0, 0); VehicleInfo[quadcar[11]][vHealth] = 1000.0; VehicleInfo[quadcar[11]][vFuel] = 100; VehicleInfo[quadcar[11]][vCanStart] = 1; VehicleInfo[quadcar[11]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[12] = CreateVehicle(471, -327.2119, 1512.8108, 74.8403, 0.5875, 0, 0, 0); VehicleInfo[quadcar[12]][vHealth] = 1000.0; VehicleInfo[quadcar[12]][vFuel] = 100; VehicleInfo[quadcar[12]][vCanStart] = 1; VehicleInfo[quadcar[12]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[13] = CreateVehicle(471, -327.2621, 1517.7084, 74.8410, 0.5875, 0, 0, 0); VehicleInfo[quadcar[13]][vHealth] = 1000.0; VehicleInfo[quadcar[13]][vFuel] = 100; VehicleInfo[quadcar[13]][vCanStart] = 1; VehicleInfo[quadcar[13]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[14] = CreateVehicle(471, -324.0248, 1513.0424, 74.8402, 0.2915, 0, 0, 0); VehicleInfo[quadcar[14]][vHealth] = 1000.0; VehicleInfo[quadcar[14]][vFuel] = 100; VehicleInfo[quadcar[14]][vCanStart] = 1; VehicleInfo[quadcar[14]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[15] = CreateVehicle(471, -324.0494, 1517.7527, 74.8388, 0.2937, 0, 0, 0); VehicleInfo[quadcar[15]][vHealth] = 1000.0; VehicleInfo[quadcar[15]][vFuel] = 100; VehicleInfo[quadcar[15]][vCanStart] = 1; VehicleInfo[quadcar[15]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[16] = CreateVehicle(471, -320.8638, 1513.0750, 74.8409, 359.6989, 0, 0, 0); VehicleInfo[quadcar[16]][vHealth] = 1000.0; VehicleInfo[quadcar[16]][vFuel] = 100; VehicleInfo[quadcar[16]][vCanStart] = 1; VehicleInfo[quadcar[16]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[17] = CreateVehicle(471, -320.8956, 1517.4703, 74.8394, 1.3871, 0, 0, 0); VehicleInfo[quadcar[17]][vHealth] = 1000.0; VehicleInfo[quadcar[17]][vFuel] = 100; VehicleInfo[quadcar[17]][vCanStart] = 1; VehicleInfo[quadcar[17]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[18] = CreateVehicle(471, -346.4572, 1524.1067, 74.8392, 271.0160, 0, 0, 0); VehicleInfo[quadcar[18]][vHealth] = 1000.0; VehicleInfo[quadcar[18]][vFuel] = 100; VehicleInfo[quadcar[18]][vCanStart] = 1; VehicleInfo[quadcar[18]][vUsage] = VEHICLE_USAGE_NORMAL;
    quadcar[19] = CreateVehicle(471, -346.4546, 1521.8671, 74.8408, 271.1157, 0, 0, 0); VehicleInfo[quadcar[19]][vHealth] = 1000.0; VehicleInfo[quadcar[19]][vFuel] = 100; VehicleInfo[quadcar[19]][vCanStart] = 1; VehicleInfo[quadcar[19]][vUsage] = VEHICLE_USAGE_NORMAL;
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hooks)
hook OnGameModeInit()
{
	quadograda = CreateDynamicObject(982, -305.29999, 1507.5, 75, 0, 0, 270.247, -1, -1, -1, 200.0);
	CreateDynamicObject(983, -318.20001, 1510.7, 75, 0, 0, 1, -1, -1, -1, 200.0);
	CreateDynamicObject(983, -292.70001, 1510.7, 75, 0, 0, 3.246, -1, -1, -1, 200.0);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	QuadPlayer[playerid] = 0;
	QuadPlayerCP[playerid] = 0;
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 471 && !QuadPlayer[playerid] && QuadPlayerCP[playerid] > 0 )
		{
			RemovePlayerFromVehicle(playerid);
			SendClientMessage(playerid, COLOR_RED, "ERROR: Niste prijavljeni za Quad event!");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetVehicleModel(vehicleid) == 471 && QuadPlayer[playerid])
	{
		RepairVehicle(vehicleid);
		SetVehicleToRespawn(vehicleid);
		DisablePlayerRaceCheckpoint(playerid);
		QuadPlayer[playerid] = 0;
		QuadPlayerCP[playerid] = 0;
		SendClientMessage(playerid, COLOR_ORANGE, "[QUAD EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == 471 && QuadPlayer[killerid])
	{
		RepairVehicle(vehicleid);
		SetVehicleToRespawn(vehicleid);
		DisablePlayerRaceCheckpoint(killerid);
		QuadPlayer[killerid] = 0;
		QuadPlayerCP[killerid] = 0;
		SendClientMessage(killerid, COLOR_ORANGE, "[QUAD EVENT]: Izbaceni ste iz eventa jer ste unistili vozilo!");
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	switch(QuadPlayerCP[playerid])
	{
		case 1:
		{
			GameTextForPlayer(playerid, "~r~Pricekaj ovdje do pocetka Quad utrke.", 5000, 3);
			DisablePlayerRaceCheckpoint(playerid);
		}
		case 2:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -300.8459,1446.3538,72.9948, -315.5348,1398.3810,71.3546, 20.0);
		}
		case 3:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -315.5348,1398.3810,71.3546, -365.1587,1464.5282,62.8273, 20.0);
		}
		case 4:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -365.1587,1464.5282,62.8273, -320.5416,1323.2253,53.0918, 20.0);
		}
		case 5:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -320.5416,1323.2253,53.0918, -418.9161,1445.8309,34.4525, 20.0);
		}
		case 6:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -418.9161,1445.8309,34.4525, -438.5108,1638.6521,35.0720, 20.0);
		}
		case 7:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -438.5108,1638.6521,35.0720, -400.0891,1748.6345,41.9574, 20.0);
		}
		case 8:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -400.0891,1748.6345,41.9574, -402.0848,1916.6584,57.5054, 20.0);
		}
		case 9:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -402.0848,1916.6584,57.5054, -427.5626,1770.5791,71.3951, 20.0);
		}
		case 10:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -427.5626,1770.5791,71.3951, -479.1776,1934.5352,85.9381, 20.0);
		}
		case 11:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -479.1776,1934.5352,85.9381, -377.0199,2064.3198,60.3467, 20.0);
		}
		case 12:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -377.0199,2064.3198,60.3467, -347.1172,2168.2986,43.6934, 20.0);
		}
		case 13:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -347.1172,2168.2986,43.6934, -372.1988,2355.4395,29.2156, 20.0);
		}
		case 14:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -372.1988,2355.4395,29.2156, -403.5100,2455.0193,42.3886, 20.0);
		}
		case 15:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -403.5100,2455.0193,42.3886, -437.9898,2577.9688,45.2985, 20.0);
		}
		case 16:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -437.9898,2577.9688,45.2985, -553.7694,2717.5369,65.0577, 20.0);
		}
		case 17:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -553.7694,2717.5369,65.0577, -781.2863,2730.7617,44.8054, 20.0);
		}
		case 18:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -781.2863,2730.7617,44.8054, -1264.7394,2669.7971,47.9028, 20.0);
		}
		case 19:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1264.7394,2669.7971,47.9028, -1353.6357,2652.4761,50.6340, 20.0);
		}
		case 20:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1353.6357,2652.4761,50.6340, -1580.0411,2730.5012,59.3272, 20.0);
		}
		case 21:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1580.0411,2730.5012,59.3272, -1766.7478,2706.4043,58.9073, 20.0);
		}
		case 22:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1766.7478,2706.4043,58.9073, -1654.3595,2599.9312,80.4630, 20.0);
		}
		case 23:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1654.3595,2599.9312,80.4630, -1662.8783,2464.3062,85.9044, 20.0);
		}
		case 24:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1662.8783,2464.3062,85.9044, -1744.5374,2460.0884,72.0353, 20.0);
		}
		case 25:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1744.5374,2460.0884,72.0353, -1686.1088,2393.0166,56.9785, 20.0);
		}
		case 26:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1686.1088,2393.0166,56.9785, -1752.6340,2289.8286,34.7975, 20.0);
		}
		case 27:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1752.6340,2289.8286,34.7975, -1676.4010,2337.4954,32.6707, 20.0);
		}
		case 28:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1676.4010,2337.4954,32.6707, -1610.1589,2377.3799,49.7573, 20.0);
		}
		case 29:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1610.1589,2377.3799,49.7573, -1436.1534,2364.5313,52.6204, 20.0);
		}
		case 30:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1436.1534,2364.5313,52.6204, -1349.6799,2161.9185,47.3850, 20.0);
		}
		case 31:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1349.6799,2161.9185,47.3850, -1162.5715,1798.7854,39.5073, 20.0);
		}
		case 32:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1162.5715,1798.7854,39.5073, -900.1340,1791.7156,59.6628, 20.0);
		}
		case 33:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -900.1340,1791.7156,59.6628, -779.6450,2049.2446,59.8636, 20.0);
		}
		case 34:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -779.6450,2049.2446,59.8636, -486.8950,1995.3231,59.6695, 20.0);
		}
		case 35:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -486.8950,1995.3231,59.6695, -393.1130,2042.7026,63.1516, 20.0);
		}
		case 36:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -393.1130,2042.7026,63.1516, -464.9035,1770.1857,72.5355, 20.0);
		}
		case 37:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -464.9035,1770.1857,72.5355, -423.8676,1915.5992,56.8591, 20.0);
		}
		case 38:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -423.8676,1915.5992,56.8591, -422.8964,1666.4540,36.4926, 20.0);
		}
		case 39:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -422.8964,1666.4540,36.4926, -397.2952,1419.6083,38.5058, 20.0);
		}
		case 40:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -397.2952,1419.6083,38.5058, -320.8866,1322.9297,53.0558, 20.0);
		}
		case 41:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -320.8866,1322.9297,53.0558, -367.0070,1464.6056,62.6167, 20.0);
		}
		case 42:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -367.0070,1464.6056,62.6167, -308.2943,1394.2070,71.7662, 20.0);
		}
		case 43:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -308.2943,1394.2070,71.7662, -302.4184,1506.5977,74.8710, 20.0);
		}
		case 44:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            QuadPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 1, -302.4184,1506.5977,74.8710, -302.4184,1506.5977,74.8710, 20.0);
		}
		case 45:
		{
			PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
			SetTimerEx("StopFinishSound", 7000, 0, "i", playerid);
			DisablePlayerRaceCheckpoint(playerid);
			GameTextForPlayer(playerid, "~w~Uspjesno ste zavrsili Quad utrku~n~~r~Cestitamo!", 5000, 3);
			new name[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, name, sizeof(name));
			if(FirstQuadWinner == 999)
		    {
		        FirstQuadWinner = playerid;
		        foreach(new i:Player)
		        {
	                    format(string, sizeof(string), "[QUAD EVENT]: %s je pobijedio u Quad utrci.", name);
	                    SendClientMessage(i, COLOR_ORANGE, string);
	                    QuadPlayer[playerid] = 0;
	                    QuadPlayerCP[playerid] = 0;
				}
		    }
		    else if(SecondQuadWinner == 999)
		    {
		        SecondQuadWinner = playerid;
		        foreach(new i:Player)
		        {
	                    format(string, sizeof(string), "[QUAD EVENT]: %s je osvojio drugo mjesto u Quad utrci.", name);
	                    SendClientMessage(i, COLOR_ORANGE, string);
	                    QuadPlayer[playerid] = 0;
	                    QuadPlayerCP[playerid] = 0;
				}
		    }
		    else if(ThirdQuadWinner == 999)
		    {
		        ThirdQuadWinner = playerid;
		        foreach(new i:Player)
		        {
	                   format(string, sizeof(string), "[QUAD EVENT]: %s je osvojio trece mjesto u Quad utrci.", name);
	                   SendClientMessage(i, COLOR_ORANGE, string);
	                   DisablePlayerRaceCheckpoint(i);
	                   QuadPlayer[i] = 0;
	                   QuadPlayerCP[i] = 0;
	                   QuadStarted = 0;
		        }
		    }
		    return 1;
		}
	}
	return 1;
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (timers)
forward OnQuadCountDown();
public OnQuadCountDown()
{
	va_GameTextForAll("~w~%d", 1000, 4, count - 1);

	foreach(new playerid : Player)
	{
		PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	}
	count--;

	if(!count) {
	    if(QuadStarted == 1) {
     		foreach(new i:Player) {
				if(QuadPlayer[i] != 0) {
					QuadPlayerCP[i] = 2;
					SetPlayerRaceCheckpoint(i, 0, -307.1650,1512.8640,74.8412, -300.8459,1446.3538,72.9948, 30.0);
				}
			}
			MoveDynamicObject(quadograda, -305.29999, 1507.5, 73, 50.000);
			FirstQuadWinner = 999;
			SecondQuadWinner = 999;
			ThirdQuadWinner = 999;
		}
		GameTextForAll("~g~GO GO GO!", 2500, 4);
		foreach(new playerid : Player) {
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		}
		KillTimer(QuadCountTimer);
	}
	return 1;
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)

CMD:quad(playerid, params[])  {
	new action[25];
			
	if(sscanf(params, "s[25] ", action)) {
		SendClientMessage(playerid, COLOR_RED, "[ ! ] /quad [option].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): quitquad, join");
		SendClientMessage(playerid, 0xAFAFAFAA, "(admin): create, vehdestroy, vehspawn, startrace, stoprace, goto");
		return (true);
	}
	
	if(strcmp(action,"vehdestroy", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		for(new i = 0; i < 20; i++) {
			DestroyVehicle(quadcar[i]);
		}
	}
	
	if(strcmp(action,"vehspawn", true) == 0) { 
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		CreateQuadVehicles();
	}
	
	if(strcmp(action, "create", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		SendClientMessageToAll(COLOR_ORANGE,"[QUAD EVENT]: Administrator je pokrenuo quad event, da ucestvujete koristite (/quad join).");
		
		quad_created = true;
		CreateQuadVehicles();
	}
	
	if(strcmp(action,"join", true) == 0) {
		if(quad_counter == MAX_PLAYERS_ON_QEVENT)
			return SendErrorMessage(playerid, "[ERROR]: Event je popunjen, nema vise mjesta.");
			
		if(QuadPlayer[playerid] == 1)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Vec ste se join-ali na quad.");
			
		if(quad_created == false)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Administrator nije pokrenuo/kreirao quad.");
			
		if(QuadStarted == 1)
			return SendClientMessage(playerid, COLOR_RED, "Quad je vec pokrenut, trebate ga prije toga zaustaviti (/stopquad).");
			
		QuadPlayer[playerid] = 1;
		QuadPlayerCP[playerid] = 1;
		SetPlayerHealth(playerid, 100);
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		SetPlayerRaceCheckpoint(playerid, 2, -307.1650,1512.8640,74.8412, -307.1650,1512.8640,74.8412, 30.0);
		
		SendClientMessage(playerid, COLOR_RED, "[QUAD]: Uspjesno ste se prijavili za quad event. Udjite u vozilo i stanite na marker.");
	}
	
	if(strcmp(action,"startrace", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 2)
			return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande.");
	
		if(quad_created == false)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Administrator nije pokrenuo/kreirao quad.");
			
		if(QuadStarted == 1)
			return SendClientMessage(playerid, COLOR_RED, "Quad je vec pokrenut, trebate ga prije toga zaustaviti (/stopquad).");

		QuadStarted = 1;
		count = 11;
		QuadCountTimer = SetTimer("OnQuadCountDown", 1000, true);
		SendClientMessage(playerid, COLOR_WHITE, "[QUAD EVENT]: Zapoceli ste Quad utrku.");
	}
	
	if(strcmp(action,"stoprace", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		foreach(new i:Player) {
			if(QuadPlayer[i] == 1)
			{
				DisablePlayerRaceCheckpoint(i);
				QuadPlayer[i] = 0;
				QuadPlayerCP[i] = 0;
			}
		}
		QuadStarted = 0;
		quad_created = false;
		FirstQuadWinner = 999;
		SecondQuadWinner = 999;
		ThirdQuadWinner = 999;
		MoveDynamicObject(quadograda, -305.29999, 1507.5, 75, 50.000);
		
		SendClientMessage(playerid, COLOR_WHITE, "[QUAD EVENT]: Zaustavili ste Quad utrku.");
		for(new i = 0; i < 20; i++) {
			DestroyVehicle(quadcar[i]);
		}
	}
	
	if(strcmp(action,"goto", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 2)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 2+).");
		
		SetPlayerPos(playerid, -318.7222, 1527.6124, 75.3570);
	}
	
	if(strcmp(action,"quitquad", true) == 0) {
		if(QuadPlayer[playerid] == 1)
		{
			QuadPlayer[playerid] = 0;
			QuadPlayerCP[playerid] = 0;
			DisablePlayerRaceCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_WHITE, "Odustali ste od Quad utrke.");
		}
		else { 
			return SendClientMessage(playerid, COLOR_RED, "Niste prijavljeni za Quad utrku!"); 
		}
	}
   	return (true);
}
