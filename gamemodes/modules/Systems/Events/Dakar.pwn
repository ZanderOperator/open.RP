// 10/06/2019 - L3o


#include <YSI\y_hooks>

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (defines)
#define MAX_PLAYERS_ON_DEVENT (21)

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (vars)
new DakarPlayer[MAX_PLAYERS],
	DakarPlayerCP[MAX_PLAYERS],
	bool: dakar_created = false,
	CountTimer,
	dakarograda1,
	dakarograda2,
	dakar_counter = 0,
	dakarcar[21];

static stock
		count,
		DakarStarted 			= 0,
		FirstDakarWinner		= 999,
		SecondDakarWinner		= 999,
		ThirdDakarWinner		= 999;

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (functions)
stock CreateDakarVehicles() {
	dakarcar[0] = CreateVehicle(495, 341.646392, 2548.056396, 17.118400, 178.841705, 0, 0, 0); VehicleInfo[dakarcar[0]][vHealth] = 1000.0; VehicleInfo[dakarcar[0]][vFuel] = 100; VehicleInfo[dakarcar[0]][vCanStart] = 1; VehicleInfo[dakarcar[0]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[1] = CreateVehicle(495, 341.646392, 2548.056396, 17.118400, 178.841705, 0, 0, 0); VehicleInfo[dakarcar[1]][vHealth] = 1000.0; VehicleInfo[dakarcar[1]][vFuel] = 100; VehicleInfo[dakarcar[1]][vCanStart] = 1; VehicleInfo[dakarcar[1]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[2] = CreateVehicle(495, 341.277801, 2531.588134, 17.132799, 178.725402, 0, 0, 0); VehicleInfo[dakarcar[2]][vHealth] = 1000.0; VehicleInfo[dakarcar[2]][vFuel] = 100; VehicleInfo[dakarcar[2]][vCanStart] = 1; VehicleInfo[dakarcar[2]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[3] = CreateVehicle(495, 346.519409, 2547.504150, 17.080699, 180.000503, 0, 0, 0); VehicleInfo[dakarcar[3]][vHealth] = 1000.0; VehicleInfo[dakarcar[3]][vFuel] = 100; VehicleInfo[dakarcar[3]][vCanStart] = 1; VehicleInfo[dakarcar[3]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[4] = CreateVehicle(495, 346.440093, 2532.005126, 17.109500, 179.670700, 0, 0, 0); VehicleInfo[dakarcar[4]][vHealth] = 1000.0; VehicleInfo[dakarcar[4]][vFuel] = 100; VehicleInfo[dakarcar[4]][vCanStart] = 1; VehicleInfo[dakarcar[4]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[5] = CreateVehicle(495, 351.600891, 2547.611816, 17.013500, 179.267807, 0, 0, 0); VehicleInfo[dakarcar[5]][vHealth] = 1000.0; VehicleInfo[dakarcar[5]][vFuel] = 100; VehicleInfo[dakarcar[5]][vCanStart] = 1; VehicleInfo[dakarcar[5]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[6] = CreateVehicle(495, 351.352813, 2531.799560, 17.085100, 179.115600, 0, 0, 0); VehicleInfo[dakarcar[6]][vHealth] = 1000.0; VehicleInfo[dakarcar[6]][vFuel] = 100; VehicleInfo[dakarcar[6]][vCanStart] = 1; VehicleInfo[dakarcar[6]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[7] = CreateVehicle(495, 356.608489, 2547.904785, 16.939800, 178.925201, 0, 0, 0); VehicleInfo[dakarcar[7]][vHealth] = 1000.0; VehicleInfo[dakarcar[7]][vFuel] = 100; VehicleInfo[dakarcar[7]][vCanStart] = 1; VehicleInfo[dakarcar[7]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[8] = CreateVehicle(495, 356.302307, 2531.409423, 17.058900, 179.644104, 0, 0, 0); VehicleInfo[dakarcar[8]][vHealth] = 1000.0; VehicleInfo[dakarcar[8]][vFuel] = 100; VehicleInfo[dakarcar[8]][vCanStart] = 1; VehicleInfo[dakarcar[8]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[9] = CreateVehicle(495, 361.597290, 2547.606201, 16.896400, 180.510498, 0, 0, 0); VehicleInfo[dakarcar[9]][vHealth] = 1000.0; VehicleInfo[dakarcar[9]][vFuel] = 100; VehicleInfo[dakarcar[9]][vCanStart] = 1; VehicleInfo[dakarcar[9]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[10] = CreateVehicle(495, 361.617095, 2531.625732, 17.037500, 179.847305, 0, 0, 0); VehicleInfo[dakarcar[10]][vHealth] = 1000.0; VehicleInfo[dakarcar[10]][vFuel] = 100; VehicleInfo[dakarcar[10]][vCanStart] = 1; VehicleInfo[dakarcar[10]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[11] = CreateVehicle(495, 366.435089, 2547.302978, 16.885498, 179.360900, 0, 0, 0); VehicleInfo[dakarcar[11]][vHealth] = 1000.0; VehicleInfo[dakarcar[11]][vFuel] = 100; VehicleInfo[dakarcar[11]][vCanStart] = 1; VehicleInfo[dakarcar[11]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[12] = CreateVehicle(495, 366.510101, 2531.701904, 17.009899, 179.025207, 0, 0, 0); VehicleInfo[dakarcar[12]][vHealth] = 1000.0; VehicleInfo[dakarcar[12]][vFuel] = 100; VehicleInfo[dakarcar[12]][vCanStart] = 1; VehicleInfo[dakarcar[12]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[13] = CreateVehicle(495, 371.544708, 2547.822021, 16.889400, 178.812194, 0, 0, 0); VehicleInfo[dakarcar[13]][vHealth] = 1000.0; VehicleInfo[dakarcar[13]][vFuel] = 100; VehicleInfo[dakarcar[13]][vCanStart] = 1; VehicleInfo[dakarcar[13]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[14] = CreateVehicle(495, 371.414001, 2531.644287, 16.987100, 179.776000, 0, 0, 0); VehicleInfo[dakarcar[14]][vHealth] = 1000.0; VehicleInfo[dakarcar[14]][vFuel] = 100; VehicleInfo[dakarcar[14]][vCanStart] = 1; VehicleInfo[dakarcar[14]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[15] = CreateVehicle(495, 376.595611, 2547.250488, 16.889900, 179.028305, 0, 0, 0); VehicleInfo[dakarcar[15]][vHealth] = 1000.0; VehicleInfo[dakarcar[15]][vFuel] = 100; VehicleInfo[dakarcar[15]][vCanStart] = 1; VehicleInfo[dakarcar[15]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[16] = CreateVehicle(495, 376.419097, 2531.645751, 16.962699, 179.639297, 0, 0, 0); VehicleInfo[dakarcar[16]][vHealth] = 1000.0; VehicleInfo[dakarcar[16]][vFuel] = 100; VehicleInfo[dakarcar[16]][vCanStart] = 1; VehicleInfo[dakarcar[16]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[17] = CreateVehicle(495, 381.588714, 2547.656738, 16.887100, 179.070297, 0, 0, 0); VehicleInfo[dakarcar[17]][vHealth] = 1000.0; VehicleInfo[dakarcar[17]][vFuel] = 100; VehicleInfo[dakarcar[17]][vCanStart] = 1; VehicleInfo[dakarcar[17]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[18] = CreateVehicle(495, 381.330993, 2531.338134, 16.927900, 179.100494, 0, 0, 0); VehicleInfo[dakarcar[18]][vHealth] = 1000.0; VehicleInfo[dakarcar[18]][vFuel] = 100; VehicleInfo[dakarcar[18]][vCanStart] = 1; VehicleInfo[dakarcar[18]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[19] = CreateVehicle(495, 386.839813, 2547.597167, 16.889799, 178.236999, 0, 0, 0); VehicleInfo[dakarcar[19]][vHealth] = 1000.0; VehicleInfo[dakarcar[19]][vFuel] = 100; VehicleInfo[dakarcar[19]][vCanStart] = 1; VehicleInfo[dakarcar[19]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakarcar[20] = CreateVehicle(495, 386.511688, 2531.422851, 16.901300, 180.254302, 0, 0, 0); VehicleInfo[dakarcar[20]][vHealth] = 1000.0; VehicleInfo[dakarcar[20]][vFuel] = 100; VehicleInfo[dakarcar[20]][vCanStart] = 1; VehicleInfo[dakarcar[20]][vUsage] = VEHICLE_USAGE_NORMAL;
}

stock dakar_vehicles(carid)
{
	for(new i = 0; i < sizeof(dakarcar); i++)
	{
 		if (carid >= dakarcar[0] && carid <= sizeof dakarcar) return true;
 	}
	return 0;
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hooks / pub.)
public OnPlayerEnterRaceCheckpoint(playerid) {
	switch(DakarPlayerCP[playerid])
	{
		case 1:
		{
			GameTextForPlayer(playerid, "~r~Pricekaj ovdje do pocetka Dakar utrke.", 5000, 3);
			DisablePlayerRaceCheckpoint(playerid);
		}
		case 2:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 184.5693,2501.4507,16.0462, -226.5221,2512.1274,28.5627, 20.0);
		}
		case 3:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -226.5221,2512.1274,28.5627, -699.5148,2517.5972,74.8462, 20.0);
		}
		case 4:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -699.5148,2517.5972,74.8462, -824.2711,2729.3931,45.1460, 20.0);
		}
		case 5:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -824.2711,2729.3931,45.1460, -1218.2679,2676.0330,45.7523, 20.0);
		}
		case 6:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1218.2679,2676.0330,45.7523, -1100.4137,2366.9429,84.7633, 20.0);
		}
		case 7:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1100.4137,2366.9429,84.7633, -1063.8564,2134.1338,87.2306, 20.0);
		}
		case 8:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1063.8564,2134.1338,87.2306, -1272.4089,1994.5693,63.4255, 20.0);
		}
		case 9:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1272.4089,1994.5693,63.4255, -1308.5040,1908.4788,50.8996, 20.0);
		}
		case 10:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1308.5040,1908.4788,50.8996, -1174.9597,1675.0942,20.8654, 20.0);
		}
		case 11:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1174.9597,1675.0942,20.8654, -1033.5931,1418.0524,38.4419, 20.0);
		}
		case 12:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -1033.5931,1418.0524,38.4419, -978.8105,1449.7777,36.8201, 20.0);
		}
		case 13:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -978.8105,1449.7777,36.8201, -856.0881,1491.8328,18.1211, 20.0);
		}
		case 14:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -856.0881,1491.8328,18.1211, -685.0940,1227.9476,12.2763, 20.0);
		}
		case 15:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -685.0940,1227.9476,12.2763, -459.9577,1044.6108,10.5958, 20.0);
		}
		case 16:
		{
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -459.9577,1044.6108,10.5958, -279.2259,793.0493,14.9276, 20.0);
		}
		case 17:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, -279.2259,793.0493,14.9276, 198.7271,953.8658,27.3410, 20.0);
		}
		case 18:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 198.7271,953.8658,27.3410, 658.0703,1088.1443,27.9665, 20.0);
		}
		case 19:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 658.0703,1088.1443,27.9665, 829.5692,1159.1196,27.5392, 20.0);
		}
		case 20:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 829.5692,1159.1196,27.5392, 850.6667,1565.5934,17.3895, 20.0);
		}
		case 21:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 850.6667,1565.5934,17.3895, 818.6127,2007.8622,9.3344, 20.0);
		}
		case 22:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 818.6127,2007.8622,9.3344, 784.9023,2552.6687,29.1620, 20.0);
		}
		case 23:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 784.9023,2552.6687,29.1620, 1062.3401,2788.1953,8.2695, 20.0);
		}
		case 24:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 1062.3401,2788.1953,8.2695, 1333.0400,2826.5098,10.3820, 20.0);
		}
		case 25:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 1333.0400,2826.5098,10.3820, 1475.9784,2816.8455,10.3815, 20.0);
		}
		case 26:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 1475.9784,2816.8455,10.3815, 1547.7458,2684.4412,10.2458, 20.0);
		}
		case 27:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 1547.7458,2684.4412,10.2458, 1595.4004,2590.4617,10.2803, 20.0);
		}
		case 28:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 0, 1595.4004,2590.4617,10.2803, 1785.4630,2616.5105,10.3818, 20.0);
		}
		case 29:
		{
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			DisablePlayerRaceCheckpoint(playerid);
            DakarPlayerCP[playerid]++;
			SetPlayerRaceCheckpoint(playerid, 1, 1785.4630,2616.5105,10.3818, 1785.4630,2616.5105,10.3818, 20.0);
		}
		case 30:
		{
			new string[128];
			PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
			SetTimerEx("StopFinishSound", 7000, 0, "i", playerid);
			DisablePlayerRaceCheckpoint(playerid);
			GameTextForPlayer(playerid, "~w~Uspjesno ste zavrsili dakar utrku~n~~r~Cestitamo!", 5000, 3);
			
			if(FirstDakarWinner == 999) {
		        FirstDakarWinner = playerid;
		        foreach(new i:Player)
		        {
	                    format(string, sizeof(string), "[DAKAR EVENT]: %s je pobijedio u Dakar utrci.", GetName(FirstDakarWinner, true));
	                    SendClientMessage(i, COLOR_ORANGE, string);
	                    DakarPlayer[playerid] = 0;
	                    DakarPlayerCP[playerid] = 0;
				}
		    }
		    else if(SecondDakarWinner == 999) {
		        SecondDakarWinner = playerid;
		        foreach(new i:Player)
		        {
	                    format(string, sizeof(string), "[DAKAR EVENT]: %s je osvojio drugo mjesto u Dakar utrci.", GetName(SecondDakarWinner, true));
	                    SendClientMessage(i, COLOR_ORANGE, string);
	                    DakarPlayer[playerid] = 0;
	                    DakarPlayerCP[playerid] = 0;
				}
		    }
		    else if(ThirdDakarWinner == 999) {
		        ThirdDakarWinner = playerid;
		        foreach(new i:Player) {
	                format(string, sizeof(string), "[DAKAR EVENT]: %s je osvojio trece mjesto u Dakar utrci.", GetName(ThirdDakarWinner, true));
	                SendClientMessage(i, COLOR_ORANGE, string);
	                DisablePlayerRaceCheckpoint(i);
	                DakarPlayer[i] = 0;
	                DakarPlayerCP[i] = 0;
	                DakarStarted = 0;
		        }
		    }
		    return (true);
		}
	}   
	return (true);
}

hook OnGameModeInit()
{
    CreateDynamicObject(983, 382.119537, 2528.107178, 16.193573, 0.0000, 0.0000, 268.8997, -1, -1, -1, 200.0);
	dakarograda1 = CreateDynamicObject(982, 378.345764, 2489.771484, 16.167931, 0.0000, 0.0000, 359.1406, -1, -1, -1, 200.0);
	dakarograda2 = CreateDynamicObject(982, 378.744781, 2515.375977, 16.184555, 0.0000, 0.0000, 359.1406, -1, -1, -1, 200.0);
	return (true);
}

hook OnPlayerDisconnect(playerid, reason)
{
	DakarPlayer[playerid] = 0;
	DakarPlayerCP[playerid] = 0;
	return (true);
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
	if(newstate == PLAYER_STATE_DRIVER) {
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 495 && !DakarPlayer[playerid]) {
			SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Kako bi koristili ovo vozilo, morate biti na dakar event-u.");
			RemovePlayerFromVehicle(playerid);
		}
	}
	return (true);
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetVehicleModel(vehicleid) == 495 && DakarPlayer[playerid]) {
		if(DakarStarted == 1) {
			RepairVehicle(vehicleid);
			SetVehicleToRespawn(vehicleid);
			DisablePlayerRaceCheckpoint(playerid);
			DakarPlayer[playerid] = 0;
			DakarPlayerCP[playerid] = 0;
			SendClientMessage(playerid, COLOR_ORANGE, "[DAKAR EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
		}
	}
	return (true);
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == 495 && DakarPlayer[killerid]) {
		RepairVehicle(vehicleid);
		SetVehicleToRespawn(vehicleid);
		DisablePlayerRaceCheckpoint(killerid);
		DakarPlayer[killerid] = 0;
		DakarPlayerCP[killerid] = 0;
		SendClientMessage(killerid, COLOR_ORANGE, "[DAKAR EVENT]: Izbaceni ste iz eventa jer ste unistili vozilo!");
	}
	return (true);
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (timers)
forward OnCountDown();
public OnCountDown()
{
	count--;
	foreach(new i:Player) {
		if(DakarPlayer[i] == 1) {
			va_GameTextForPlayer(i, "~g~DAKAR - START~n~~w~%d", 1000, 4, count - 1);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
		}
	}
	
	if(!count)
	{
	    if(DakarStarted == 1) {
     		foreach(new i:Player) {
				if(DakarPlayer[i] == 1) {
					DakarPlayerCP[i] = 2;
					SetPlayerRaceCheckpoint(i, 0, 392.9321,2501.3328,16.4844, 184.5693,2501.4507,16.0462, 30.0);
				}
			}
			MoveDynamicObject(dakarograda1, 378.345764, 2489.771484, 14.467930,50.000);
 			MoveDynamicObject(dakarograda2, 378.744781, 2515.375977, 14.459570,50.000);
			FirstDakarWinner = 999;
			SecondDakarWinner = 999;
			ThirdDakarWinner = 999;
		}
		GameTextForAll("~g~GO GO GO", 2500, 4);
		foreach(new playerid : Player) {
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		}
		KillTimer(CountTimer);
	}
	return (true);
}

forward StopFinishSound(playerid);
public StopFinishSound(playerid) {
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
	return (true);
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)
CMD:dakar(playerid, params[])
{
	new action[25];
			
	if(sscanf(params, "s[25] ", action))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] /dakar [option].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): quitdakar, join");
		SendClientMessage(playerid, 0xAFAFAFAA, "(admin): create, vehdestroy, vehspawn, startrace, stoprace, goto");
		return (true);
	}
	
	if(strcmp(action,"vehdestroy", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		for(new i = 0; i < 21; i++) {
			DestroyVehicle(dakarcar[i]);
		}
	}
	
	if(strcmp(action,"vehspawn", true) == 0) { 
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		CreateDakarVehicles();
	}
	
	if(strcmp(action, "create", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		SendClientMessageToAll(COLOR_ORANGE,"[DAKAR]: Administrator je pokrenuo dakar, da ucestvujete koristite (/dakar join).");
		
		dakar_created = true;
		CreateDakarVehicles();
	}
	
	if(strcmp(action,"join", true) == 0) {
		if(dakar_counter == MAX_PLAYERS_ON_DEVENT)
			return SendErrorMessage(playerid, "[ERROR]: Event je popunjen, nema vise mjesta.");
			
		if(DakarPlayer[playerid] == 1)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Vec ste se join-ali na dakar.");
			
		if(dakar_created == false)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Administrator nije pokrenuo/kreirao dakar.");
		
		if(DakarStarted == 1)
			return SendClientMessage(playerid, COLOR_RED, "[SERVER] Dakar je vec pokrenut, trebate ga prije toga zaustaviti (/stopdakar).");
			
		DakarPlayer[playerid] = 1;	
		dakar_counter++;
		SetPlayerPos(playerid, 401.4361, 2532.7856, 16.5451);
		SendClientMessage(playerid, COLOR_RED, "[DAKAR]: Uspjesno ste se prijavili za dakar event. Udjite u vozilo i stanite na marker.");
		Bit1_Set(gr_OnEvent, playerid, true);
	}
	
	if(strcmp(action,"startrace", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		if(DakarStarted == 1)
			return SendClientMessage(playerid, COLOR_RED, "[SERVER] Dakar je vec pokrenut, trebate ga prije toga zaustaviti (/stopdakar).");

		DakarStarted = 1;
		count = 11;
		CountTimer = SetTimer("OnCountDown", 1000, true);
	}
	
	if(strcmp(action,"stoprace", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		foreach(new i:Player)
		{
			if(DakarPlayer[i] == 1)
			{
				DisablePlayerRaceCheckpoint(playerid);
				DakarPlayer[i] = 0;
				DakarPlayerCP[i] = 0;
				Bit1_Set(gr_OnEvent, playerid, false);
			}
		}
		DakarStarted = 0;
		dakar_created = false;
		dakar_counter = 0;
		
		FirstDakarWinner = 999;
		SecondDakarWinner = 999;
		ThirdDakarWinner = 999;
		
		for(new i = 0; i < 21; i++) {
			DestroyVehicle(dakarcar[i]);
		}
		MoveDynamicObject(dakarograda1, 378.345764, 2489.771484, 16.167931, 50.000);
		MoveDynamicObject(dakarograda2, 378.744781, 2515.375977, 16.184555, 50.000);
	}
	
	if(strcmp(action,"goto", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 2)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 2+).");
		
		SetPlayerPos(playerid, 401.4361, 2532.7856, 16.5451);
	}
	
	if(strcmp(action,"quitdakar", true) == 0) {
		if(DakarPlayer[playerid] == 1)
		{
			DakarPlayer[playerid] = 0;
			DakarPlayerCP[playerid] = 0;
			Bit1_Set(gr_OnEvent, playerid, false);
			DisablePlayerRaceCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_WHITE, "[Server] Odustali ste od Dakar utrke.");
		}
		else { 
			return SendClientMessage(playerid, COLOR_RED, "[SERVER] Niste prijavljeni za Dakar utrku!"); 
		}
	}
   	return (true);
}
