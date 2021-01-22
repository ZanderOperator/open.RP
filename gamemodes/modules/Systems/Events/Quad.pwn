//= 10/06/2019 - L3o.
// TODO: script statistics at the top

#if defined MODULE_EVENTS_QUAD
    #endinput
#endif
#define MODULE_EVENTS_QUAD

/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>

/*
    ########  ######## ######## #### ##    ## ######## 
    ##     ## ##       ##        ##  ###   ## ##       
    ##     ## ##       ##        ##  ####  ## ##       
    ##     ## ######   ######    ##  ## ## ## ######   
    ##     ## ##       ##        ##  ##  #### ##       
    ##     ## ##       ##        ##  ##   ### ##       
    ########  ######## ##       #### ##    ## ######## 
*/

#define MAX_PLAYERS_ON_QEVENT (21)
#define QUAD_CP_SIZE          (20.0)


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static
    QuadPlayer  [MAX_PLAYERS],
    QuadPlayerCP[MAX_PLAYERS],
    bool:QuadCreated = false,
    bool:QuadStarted = false,
    QuadPlayers      = 0,
    QuadCountdown    = 0,
    Timer:QuadCountTimer,
    FirstQuadWinner  = INVALID_PLAYER_ID,
    SecondQuadWinner = INVALID_PLAYER_ID,
    ThirdQuadWinner  = INVALID_PLAYER_ID,
    quad_fence,
    quad_vehicle[21];


static const Float:QuadSpawn[3] =
{
    -318.7222, 1527.6124, 75.3570
};

static const Float:QuadCheckpoints[][3] =
{
    {-307.1650, 1512.8640, 74.8412},
    {-300.8459, 1446.3538, 72.9948},
    {-315.5348, 1398.3810, 71.3546},
    {-365.1587, 1464.5282, 62.8273},
    {-320.5416, 1323.2253, 53.0918},
    {-418.9161, 1445.8309, 34.4525},
    {-438.5108, 1638.6521, 35.0720},
    {-400.0891, 1748.6345, 41.9574},
    {-402.0848, 1916.6584, 57.5054},
    {-427.5626, 1770.5791, 71.3951},
    {-479.1776, 1934.5352, 85.9381},
    {-377.0199, 2064.3198, 60.3467},
    {-347.1172, 2168.2986, 43.6934},
    {-372.1988, 2355.4395, 29.2156},
    {-403.5100, 2455.0193, 42.3886},
    {-437.9898, 2577.9688, 45.2985},
    {-553.7694, 2717.5369, 65.0577},
    {-781.2863, 2730.7617, 44.8054},
    {-1264.7394, 2669.7971, 47.9028},
    {-1353.6357, 2652.4761, 50.6340},
    {-1580.0411, 2730.5012, 59.3272},
    {-1766.7478, 2706.4043, 58.9073},
    {-1654.3595, 2599.9312, 80.4630},
    {-1662.8783, 2464.3062, 85.9044},
    {-1744.5374, 2460.0884, 72.0353},
    {-1686.1088, 2393.0166, 56.9785},
    {-1752.6340, 2289.8286, 34.7975},
    {-1676.4010, 2337.4954, 32.6707},
    {-1610.1589, 2377.3799, 49.7573},
    {-1436.1534, 2364.5313, 52.6204},
    {-1349.6799, 2161.9185, 47.3850},
    {-1162.5715, 1798.7854, 39.5073},
    {-900.1340, 1791.7156, 59.6628},
    {-779.6450, 2049.2446, 59.8636},
    {-486.8950, 1995.3231, 59.6695},
    {-393.1130, 2042.7026, 63.1516},
    {-464.9035, 1770.1857, 72.5355},
    {-423.8676, 1915.5992, 56.8591},
    {-422.8964, 1666.4540, 36.4926},
    {-397.2952, 1419.6083, 38.5058},
    {-320.8866, 1322.9297, 53.0558},
    {-367.0070, 1464.6056, 62.6167},
    {-308.2943, 1394.2070, 71.7662},
    {-302.4184, 1506.5977, 74.8710}
};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock CreateQuadVehicles()
{
    quad_vehicle[0] = CreateVehicle(471, -345.9333, 1512.9717, 74.8404, 0.5431, 0, 0, 0); VehicleInfo[quad_vehicle[0]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[0]][vFuel] = 100; VehicleInfo[quad_vehicle[0]][vCanStart] = 1; VehicleInfo[quad_vehicle[0]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[1] = CreateVehicle(471, -345.9785, 1517.7310, 74.8401, 0.5431, 0, 0, 0); VehicleInfo[quad_vehicle[1]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[1]][vFuel] = 100; VehicleInfo[quad_vehicle[1]][vCanStart] = 1; VehicleInfo[quad_vehicle[1]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[2] = CreateVehicle(471, -342.8741, 1513.0007, 74.8416, 0.3656, 0, 0, 0); VehicleInfo[quad_vehicle[2]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[2]][vFuel] = 100; VehicleInfo[quad_vehicle[2]][vCanStart] = 1; VehicleInfo[quad_vehicle[2]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[3] = CreateVehicle(471, -342.9041, 1517.7344, 74.8401, 0.3656, 0, 0, 0); VehicleInfo[quad_vehicle[3]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[3]][vFuel] = 100; VehicleInfo[quad_vehicle[3]][vCanStart] = 1; VehicleInfo[quad_vehicle[3]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[4] = CreateVehicle(471, -339.7604, 1513.0337, 74.8403, 0.3983, 0, 0, 0); VehicleInfo[quad_vehicle[4]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[4]][vFuel] = 100; VehicleInfo[quad_vehicle[4]][vCanStart] = 1; VehicleInfo[quad_vehicle[4]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[5] = CreateVehicle(471, -339.7913, 1517.4854, 74.8410, 0.3982, 0, 0, 0); VehicleInfo[quad_vehicle[5]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[5]][vFuel] = 100; VehicleInfo[quad_vehicle[5]][vCanStart] = 1; VehicleInfo[quad_vehicle[5]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[6] = CreateVehicle(471, -336.5557, 1512.9956, 74.8402, 0.8548, 0, 0, 0); VehicleInfo[quad_vehicle[6]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[6]][vFuel] = 100; VehicleInfo[quad_vehicle[6]][vCanStart] = 1; VehicleInfo[quad_vehicle[6]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[7] = CreateVehicle(471, -336.6248, 1517.6135, 74.8385, 0.8548, 0, 0, 0); VehicleInfo[quad_vehicle[7]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[7]][vFuel] = 100; VehicleInfo[quad_vehicle[7]][vCanStart] = 1; VehicleInfo[quad_vehicle[7]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[8] = CreateVehicle(471, -333.4187, 1512.9806, 74.8401, 359.2111, 0, 0, 0); VehicleInfo[quad_vehicle[8]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[8]][vFuel] = 100; VehicleInfo[quad_vehicle[8]][vCanStart] = 1; VehicleInfo[quad_vehicle[8]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[9] = CreateVehicle(471, -333.3742, 1517.6940, 74.8403, 0.5483, 0, 0, 0); VehicleInfo[quad_vehicle[9]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[9]][vFuel] = 100; VehicleInfo[quad_vehicle[9]][vCanStart] = 1; VehicleInfo[quad_vehicle[9]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[10] = CreateVehicle(471, -330.3658, 1512.9504, 74.8410, 359.6682, 0, 0, 0); VehicleInfo[quad_vehicle[10]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[10]][vFuel] = 100; VehicleInfo[quad_vehicle[10]][vCanStart] = 1; VehicleInfo[quad_vehicle[10]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[11] = CreateVehicle(471, -330.3458, 1517.6726, 74.8402, 0.1407, 0, 0, 0); VehicleInfo[quad_vehicle[11]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[11]][vFuel] = 100; VehicleInfo[quad_vehicle[11]][vCanStart] = 1; VehicleInfo[quad_vehicle[11]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[12] = CreateVehicle(471, -327.2119, 1512.8108, 74.8403, 0.5875, 0, 0, 0); VehicleInfo[quad_vehicle[12]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[12]][vFuel] = 100; VehicleInfo[quad_vehicle[12]][vCanStart] = 1; VehicleInfo[quad_vehicle[12]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[13] = CreateVehicle(471, -327.2621, 1517.7084, 74.8410, 0.5875, 0, 0, 0); VehicleInfo[quad_vehicle[13]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[13]][vFuel] = 100; VehicleInfo[quad_vehicle[13]][vCanStart] = 1; VehicleInfo[quad_vehicle[13]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[14] = CreateVehicle(471, -324.0248, 1513.0424, 74.8402, 0.2915, 0, 0, 0); VehicleInfo[quad_vehicle[14]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[14]][vFuel] = 100; VehicleInfo[quad_vehicle[14]][vCanStart] = 1; VehicleInfo[quad_vehicle[14]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[15] = CreateVehicle(471, -324.0494, 1517.7527, 74.8388, 0.2937, 0, 0, 0); VehicleInfo[quad_vehicle[15]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[15]][vFuel] = 100; VehicleInfo[quad_vehicle[15]][vCanStart] = 1; VehicleInfo[quad_vehicle[15]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[16] = CreateVehicle(471, -320.8638, 1513.0750, 74.8409, 359.6989, 0, 0, 0); VehicleInfo[quad_vehicle[16]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[16]][vFuel] = 100; VehicleInfo[quad_vehicle[16]][vCanStart] = 1; VehicleInfo[quad_vehicle[16]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[17] = CreateVehicle(471, -320.8956, 1517.4703, 74.8394, 1.3871, 0, 0, 0); VehicleInfo[quad_vehicle[17]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[17]][vFuel] = 100; VehicleInfo[quad_vehicle[17]][vCanStart] = 1; VehicleInfo[quad_vehicle[17]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[18] = CreateVehicle(471, -346.4572, 1524.1067, 74.8392, 271.0160, 0, 0, 0); VehicleInfo[quad_vehicle[18]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[18]][vFuel] = 100; VehicleInfo[quad_vehicle[18]][vCanStart] = 1; VehicleInfo[quad_vehicle[18]][vUsage] = VEHICLE_USAGE_NORMAL;
    quad_vehicle[19] = CreateVehicle(471, -346.4546, 1521.8671, 74.8408, 271.1157, 0, 0, 0); VehicleInfo[quad_vehicle[19]][vHealth] = 1000.0; VehicleInfo[quad_vehicle[19]][vFuel] = 100; VehicleInfo[quad_vehicle[19]][vCanStart] = 1; VehicleInfo[quad_vehicle[19]][vUsage] = VEHICLE_USAGE_NORMAL;
}

stock bool:IsQuadVehicle(carid)
{
    for (new i = 0; i < sizeof(quad_vehicle); i++)
    {
        if(carid >= quad_vehicle[0] && carid <= quad_vehicle[sizeof(quad_vehicle) - 1])
            return true;
    }
    return false;
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

hook OnGameModeInit()
{
    quad_fence = CreateDynamicObject(982, -305.29999, 1507.5, 75, 0, 0, 270.247, -1, -1, -1, 200.0);
    CreateDynamicObject(983, -318.20001, 1510.7, 75, 0, 0, 1, -1, -1, -1, 200.0);
    CreateDynamicObject(983, -292.70001, 1510.7, 75, 0, 0, 3.246, -1, -1, -1, 200.0);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    QuadPlayer  [playerid] = 0;
    QuadPlayerCP[playerid] = 0;
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 471 && !QuadPlayer[playerid])
        {
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_RED, "Niste prijavljeni za Quad event!");
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
        QuadPlayer  [playerid] = 0;
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
        QuadPlayer  [killerid] = 0;
        QuadPlayerCP[killerid] = 0;
        SendClientMessage(killerid, COLOR_ORANGE, "[QUAD EVENT]: Izbaceni ste iz eventa jer ste unistili vozilo!");
    }
    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    switch (QuadPlayerCP[playerid])
    {
        case 1:
        {
            GameTextForPlayer(playerid, "~r~Pricekaj ovdje do pocetka Quad utrke.", 5000, 3);
            DisablePlayerRaceCheckpoint(playerid);
        }
        case 2 .. (sizeof(QuadCheckpoints)-2):
        {
            new cp = QuadPlayerCP[playerid];

            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerRaceCheckpoint(playerid, 0,
                QuadCheckpoints[cp][0],   QuadCheckpoints[cp][1],   QuadCheckpoints[cp][2],
                QuadCheckpoints[cp+1][0], QuadCheckpoints[cp+1][1], QuadCheckpoints[cp+1][2],
                QUAD_CP_SIZE
            );

            QuadPlayerCP[playerid]++;
        }
        case (sizeof(QuadCheckpoints)-1):
        {
            new cp = QuadPlayerCP[playerid];

            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerRaceCheckpoint(playerid, 1,
                QuadCheckpoints[cp][0], QuadCheckpoints[cp][1], QuadCheckpoints[cp][2],
                QuadCheckpoints[cp][0], QuadCheckpoints[cp][1], QuadCheckpoints[cp][2],
                QUAD_CP_SIZE
            );

            QuadPlayerCP[playerid]++;
        }
        case sizeof(QuadCheckpoints):
        {
            PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
            defer StopFinishSound(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            GameTextForPlayer(playerid, "~w~Uspjesno ste zavrsili Quad utrku~n~~r~Cestitamo!", 5000, 3);

            QuadPlayers--;
            QuadPlayer  [playerid] = 0;
            QuadPlayerCP[playerid] = 0;
            Player_SetOnEvent(playerid, false);

            if(FirstQuadWinner == INVALID_PLAYER_ID)
            {
                FirstQuadWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[QUAD EVENT]: %s je pobijedio u Quad utrci.",
                        GetName(FirstQuadWinner, true)
                    );
                }
            }
            else if(SecondQuadWinner == INVALID_PLAYER_ID)
            {
                SecondQuadWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[QUAD EVENT]: %s je osvojio drugo mjesto u Quad utrci.",
                        GetName(SecondQuadWinner, true)
                    );
                }
            }
            else if(ThirdQuadWinner == INVALID_PLAYER_ID)
            {
                ThirdQuadWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[QUAD EVENT]: %s je osvojio trece mjesto u Quad utrci.",
                        GetName(ThirdQuadWinner, true)
                    );

                    if(QuadPlayer[i])
                    {
                        SendClientMessage(i, COLOR_ORANGE, "[QUAD EVENT]: Utrka je zavrsila.");
                        DisablePlayerRaceCheckpoint(i);
                        QuadPlayer  [playerid] = 0;
                        QuadPlayerCP[playerid] = 0;
                    }
                }
                QuadStarted = false;
            }
        }
    }
    return 1;
}


/*
    ######## #### ##     ## ######## ########   ######  
       ##     ##  ###   ### ##       ##     ## ##    ## 
       ##     ##  #### #### ##       ##     ## ##       
       ##     ##  ## ### ## ######   ########   ######  
       ##     ##  ##     ## ##       ##   ##         ## 
       ##     ##  ##     ## ##       ##    ##  ##    ## 
       ##    #### ##     ## ######## ##     ##  ######  
*/

timer OnQuadCountDown[1000]()
{
    if(!QuadStarted)
    {
        stop QuadCountTimer;
    }

    QuadCountdown--;
    if(QuadCountdown != 0)
    {
        foreach(new i : Player)
        {
            if(!QuadPlayer[i]) continue;

            va_GameTextForPlayer(i, "~g~QUAD - START~n~~w~%d", 1000, 4, QuadCountdown - 1);
            PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
    }
    else
    {
        MoveDynamicObject(quad_fence, -305.29999, 1507.5, 73, 50.000);
        FirstQuadWinner  = INVALID_PLAYER_ID;
        SecondQuadWinner = INVALID_PLAYER_ID;
        ThirdQuadWinner  = INVALID_PLAYER_ID;

        foreach(new i : Player)
        {
            if(!QuadPlayer[i]) continue;

            new cp = QuadPlayerCP[i];
            SetPlayerRaceCheckpoint(i, 0,
                QuadCheckpoints[cp][0],   QuadCheckpoints[cp][1],   QuadCheckpoints[cp][2],
                QuadCheckpoints[cp+1][0], QuadCheckpoints[cp+1][1], QuadCheckpoints[cp+1][2],
                QUAD_CP_SIZE
            );
            QuadPlayerCP[i]++;

            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            GameTextForPlayer(i, "~g~GO GO GO!", 2500, 4);
        }
        stop QuadCountTimer;
    }

    return 1;
}


/*
     ######  ##     ## ########
    ##    ## ###   ### ##     ##
    ##       #### #### ##     ##
    ##       ## ### ## ##     ##
    ##       ##     ## ##     ##
    ##    ## ##     ## ##     ##
     ######  ##     ## ########
*/

CMD:quad(playerid, params[])
{
    new action[25];

    if(sscanf(params, "s[25]", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[!] /quad [option].");
        SendClientMessage(playerid, 0xAFAFAFAA, "(options): join, quit");
        SendClientMessage(playerid, 0xAFAFAFAA, "(admin): create, vehdestroy, vehspawn, startrace, stoprace, goto");
        return 1;
    }

    if(!strcmp(action, "vehdestroy", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        for (new i = 0; i < sizeof(quad_vehicle); i++)
        {
            DestroyVehicle(quad_vehicle[i]);
        }
        return 1;
    }
    else if(!strcmp(action, "vehspawn", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        CreateQuadVehicles();
        return 1;
    }
    else if(!strcmp(action, "create", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        SendClientMessageToAll(COLOR_ORANGE, "[QUAD EVENT]: Administrator je pokrenuo quad event, da ucestvujete koristite (/quad join).");

        QuadCreated = true;
        CreateQuadVehicles();
        return 1;
    }
    else if(!strcmp(action, "join", true))
    {
        if(QuadCreated == false)
            return SendClientMessage(playerid, COLOR_RED, "Administrator nije pokrenuo/kreirao quad.");

        if(QuadStarted)
            return SendClientMessage(playerid, COLOR_RED, "Quad je vec pokrenut, trebate ga prije toga zaustaviti (/quad stoprace).");

        if(QuadPlayers == MAX_PLAYERS_ON_QEVENT)
            return SendErrorMessage(playerid, "[ERROR]: Event je popunjen, nema vise mjesta.");

        if(QuadPlayer[playerid])
            return SendClientMessage(playerid, COLOR_RED, "Vec ste se joinali na Quad.");

        QuadPlayer  [playerid] = 1;
        QuadPlayerCP[playerid] = 1;
        QuadPlayers++;

        //SetPlayerHealth(playerid, 100.0);
        //PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
        SetPlayerPos(playerid, QuadSpawn[0], QuadSpawn[1], QuadSpawn[2]);
        SetPlayerRaceCheckpoint(playerid, 2,
            QuadCheckpoints[0][0], QuadCheckpoints[0][1], QuadCheckpoints[0][2],
            QuadCheckpoints[0][0], QuadCheckpoints[0][1], QuadCheckpoints[0][2],
            30.0
        );
        SendClientMessage(playerid, COLOR_RED, "[QUAD]: Uspjesno ste se prijavili za Quad event. Udjite u vozilo i stanite na marker.");
        SendClientMessage(playerid, COLOR_RED, "[QUAD]: Ukoliko zelite odustati, tipkajte /quad quit.");
        Player_SetOnEvent(playerid, true);
        return 1;
    }
    else if(!strcmp(action, "startrace", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 2)
            return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande.");

        if(QuadStarted)
            return SendClientMessage(playerid, COLOR_RED, "Quad je vec pokrenut, trebate ga prije toga zaustaviti (/quad stoprace).");

        if(QuadCreated == false)
            return SendClientMessage(playerid, COLOR_RED, "Administrator nije pokrenuo/kreirao quad.");

        QuadStarted    = true;
        QuadCountdown  = 11;
        QuadCountTimer = repeat OnQuadCountDown();
        SendClientMessage(playerid, COLOR_WHITE, "[QUAD EVENT]: Zapoceli ste Quad utrku.");
        return 1;
    }
    else if(!strcmp(action, "stoprace", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337)
            return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Zaustavili ste Quad utrku.");

        foreach(new i : Player)
        {
            if(!QuadPlayer[i]) continue;

            for (new v = quad_vehicle[0]; v <= quad_vehicle[sizeof(quad_vehicle)-1]; v++)
            {
                if(GetPlayerVehicleID(i) == v)
                {
                    SetVehicleVelocity(v, 0.0, 0.0, 0.0);
                    RemovePlayerFromVehicle(i);
                }
            }

            DisablePlayerRaceCheckpoint(i);
            QuadPlayer  [i] = 0;
            QuadPlayerCP[i] = 0;
            Player_SetOnEvent(i, false);
        }

        QuadStarted = false;
        QuadCreated = false;

        FirstQuadWinner  = INVALID_PLAYER_ID;
        SecondQuadWinner = INVALID_PLAYER_ID;
        ThirdQuadWinner  = INVALID_PLAYER_ID;

        MoveDynamicObject(quad_fence, -305.29999, 1507.5, 75, 50.000);
        for (new i = 0; i < sizeof(quad_vehicle); i++)
        {
            if(IsValidVehicle(quad_vehicle[i]))
                DestroyVehicle(quad_vehicle[i]);
        }
        return 1;
    }
    else if(!strcmp(action, "goto", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 2)
            return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 2+).");

        SetPlayerPos(playerid, QuadSpawn[0], QuadSpawn[1], QuadSpawn[2]);
        return 1;
    }
    else if(!strcmp(action, "quit", true))
    {
        if(QuadPlayer[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_RED, "[SERVER] Niste prijavljeni za Quad utrku!");
            return 1;
        }

        QuadPlayer  [playerid] = 0;
        QuadPlayerCP[playerid] = 0;
        Player_SetOnEvent(playerid, false);
        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Odustali ste od Quad utrke.");
        return 1;
    }
    return 1;
}
