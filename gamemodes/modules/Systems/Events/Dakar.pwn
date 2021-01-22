// 10/06/2019 - L3o

// TODO: add script usage statistics (nr of vehicles, objects, etc) at the top
// TODO: there must exist a general races/events system, which is easily extendable
// and depends on data from database (is "dynamic")

#if defined MODULE_EVENTS_DAKAR
    #endinput
#endif
#define MODULE_EVENTS_DAKAR

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

#define MAX_PLAYERS_ON_DEVENT (21)
#define DAKAR_CP_SIZE         (20.0)


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
    DakarPlayer  [MAX_PLAYERS],
    DakarPlayerCP[MAX_PLAYERS],
    bool:DakarCreated = false,
    bool:DakarStarted = false,
    DakarCountdown,
    DakarPlayers,
    Timer:DakarCountTimer,
    FirstDakarWinner  = INVALID_PLAYER_ID,
    SecondDakarWinner = INVALID_PLAYER_ID,
    ThirdDakarWinner  = INVALID_PLAYER_ID,
    dakar_fence[2],
    dakar_vehicle[21];


static const Float:DakarSpawn[3] =
{
    401.4361, 2532.7856, 16.5451
};

static const Float:DakarCheckpoints[][3] =
{
    {392.9321, 2501.3328, 16.4844},
    {184.5693, 2501.4507, 16.0462},
    {-226.5221, 2512.1274, 28.5627},
    {-699.5148, 2517.5972, 74.8462},
    {-824.2711, 2729.3931, 45.1460},
    {-1218.2679, 2676.0330, 45.7523},
    {-1100.4137, 2366.9429, 84.7633},
    {-1063.8564, 2134.1338, 87.2306},
    {-1272.4089, 1994.5693, 63.4255},
    {-1308.5040, 1908.4788, 50.8996},
    {-1174.9597, 1675.0942, 20.8654},
    {-1033.5931, 1418.0524, 38.4419},
    {-978.8105, 1449.7777, 36.8201},
    {-856.0881, 1491.8328, 18.1211},
    {-685.0940, 1227.9476, 12.2763},
    {-459.9577, 1044.6108, 10.5958},
    {-279.2259, 793.0493, 14.9276},
    {198.7271, 953.8658, 27.3410},
    {658.0703, 1088.1443, 27.9665},
    {829.5692, 1159.1196, 27.5392},
    {850.6667, 1565.5934, 17.3895},
    {818.6127, 2007.8622, 9.3344},
    {784.9023, 2552.6687, 29.1620},
    {1062.3401, 2788.1953, 8.2695},
    {1333.0400, 2826.5098, 10.3820},
    {1475.9784, 2816.8455, 10.3815},
    {1547.7458, 2684.4412, 10.2458},
    {1595.4004, 2590.4617, 10.2803},
    {1785.4630, 2616.5105, 10.3818}
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

stock CreateDakarVehicles()
{
    dakar_vehicle[0] = CreateVehicle(495, 341.646392, 2548.056396, 17.118400, 178.841705, 0, 0, 0); VehicleInfo[dakar_vehicle[0]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[0]][vFuel] = 100; VehicleInfo[dakar_vehicle[0]][vCanStart] = 1; VehicleInfo[dakar_vehicle[0]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[1] = CreateVehicle(495, 341.646392, 2548.056396, 17.118400, 178.841705, 0, 0, 0); VehicleInfo[dakar_vehicle[1]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[1]][vFuel] = 100; VehicleInfo[dakar_vehicle[1]][vCanStart] = 1; VehicleInfo[dakar_vehicle[1]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[2] = CreateVehicle(495, 341.277801, 2531.588134, 17.132799, 178.725402, 0, 0, 0); VehicleInfo[dakar_vehicle[2]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[2]][vFuel] = 100; VehicleInfo[dakar_vehicle[2]][vCanStart] = 1; VehicleInfo[dakar_vehicle[2]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[3] = CreateVehicle(495, 346.519409, 2547.504150, 17.080699, 180.000503, 0, 0, 0); VehicleInfo[dakar_vehicle[3]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[3]][vFuel] = 100; VehicleInfo[dakar_vehicle[3]][vCanStart] = 1; VehicleInfo[dakar_vehicle[3]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[4] = CreateVehicle(495, 346.440093, 2532.005126, 17.109500, 179.670700, 0, 0, 0); VehicleInfo[dakar_vehicle[4]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[4]][vFuel] = 100; VehicleInfo[dakar_vehicle[4]][vCanStart] = 1; VehicleInfo[dakar_vehicle[4]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[5] = CreateVehicle(495, 351.600891, 2547.611816, 17.013500, 179.267807, 0, 0, 0); VehicleInfo[dakar_vehicle[5]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[5]][vFuel] = 100; VehicleInfo[dakar_vehicle[5]][vCanStart] = 1; VehicleInfo[dakar_vehicle[5]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[6] = CreateVehicle(495, 351.352813, 2531.799560, 17.085100, 179.115600, 0, 0, 0); VehicleInfo[dakar_vehicle[6]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[6]][vFuel] = 100; VehicleInfo[dakar_vehicle[6]][vCanStart] = 1; VehicleInfo[dakar_vehicle[6]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[7] = CreateVehicle(495, 356.608489, 2547.904785, 16.939800, 178.925201, 0, 0, 0); VehicleInfo[dakar_vehicle[7]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[7]][vFuel] = 100; VehicleInfo[dakar_vehicle[7]][vCanStart] = 1; VehicleInfo[dakar_vehicle[7]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[8] = CreateVehicle(495, 356.302307, 2531.409423, 17.058900, 179.644104, 0, 0, 0); VehicleInfo[dakar_vehicle[8]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[8]][vFuel] = 100; VehicleInfo[dakar_vehicle[8]][vCanStart] = 1; VehicleInfo[dakar_vehicle[8]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[9] = CreateVehicle(495, 361.597290, 2547.606201, 16.896400, 180.510498, 0, 0, 0); VehicleInfo[dakar_vehicle[9]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[9]][vFuel] = 100; VehicleInfo[dakar_vehicle[9]][vCanStart] = 1; VehicleInfo[dakar_vehicle[9]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[10] = CreateVehicle(495, 361.617095, 2531.625732, 17.037500, 179.847305, 0, 0, 0); VehicleInfo[dakar_vehicle[10]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[10]][vFuel] = 100; VehicleInfo[dakar_vehicle[10]][vCanStart] = 1; VehicleInfo[dakar_vehicle[10]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[11] = CreateVehicle(495, 366.435089, 2547.302978, 16.885498, 179.360900, 0, 0, 0); VehicleInfo[dakar_vehicle[11]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[11]][vFuel] = 100; VehicleInfo[dakar_vehicle[11]][vCanStart] = 1; VehicleInfo[dakar_vehicle[11]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[12] = CreateVehicle(495, 366.510101, 2531.701904, 17.009899, 179.025207, 0, 0, 0); VehicleInfo[dakar_vehicle[12]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[12]][vFuel] = 100; VehicleInfo[dakar_vehicle[12]][vCanStart] = 1; VehicleInfo[dakar_vehicle[12]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[13] = CreateVehicle(495, 371.544708, 2547.822021, 16.889400, 178.812194, 0, 0, 0); VehicleInfo[dakar_vehicle[13]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[13]][vFuel] = 100; VehicleInfo[dakar_vehicle[13]][vCanStart] = 1; VehicleInfo[dakar_vehicle[13]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[14] = CreateVehicle(495, 371.414001, 2531.644287, 16.987100, 179.776000, 0, 0, 0); VehicleInfo[dakar_vehicle[14]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[14]][vFuel] = 100; VehicleInfo[dakar_vehicle[14]][vCanStart] = 1; VehicleInfo[dakar_vehicle[14]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[15] = CreateVehicle(495, 376.595611, 2547.250488, 16.889900, 179.028305, 0, 0, 0); VehicleInfo[dakar_vehicle[15]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[15]][vFuel] = 100; VehicleInfo[dakar_vehicle[15]][vCanStart] = 1; VehicleInfo[dakar_vehicle[15]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[16] = CreateVehicle(495, 376.419097, 2531.645751, 16.962699, 179.639297, 0, 0, 0); VehicleInfo[dakar_vehicle[16]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[16]][vFuel] = 100; VehicleInfo[dakar_vehicle[16]][vCanStart] = 1; VehicleInfo[dakar_vehicle[16]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[17] = CreateVehicle(495, 381.588714, 2547.656738, 16.887100, 179.070297, 0, 0, 0); VehicleInfo[dakar_vehicle[17]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[17]][vFuel] = 100; VehicleInfo[dakar_vehicle[17]][vCanStart] = 1; VehicleInfo[dakar_vehicle[17]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[18] = CreateVehicle(495, 381.330993, 2531.338134, 16.927900, 179.100494, 0, 0, 0); VehicleInfo[dakar_vehicle[18]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[18]][vFuel] = 100; VehicleInfo[dakar_vehicle[18]][vCanStart] = 1; VehicleInfo[dakar_vehicle[18]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[19] = CreateVehicle(495, 386.839813, 2547.597167, 16.889799, 178.236999, 0, 0, 0); VehicleInfo[dakar_vehicle[19]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[19]][vFuel] = 100; VehicleInfo[dakar_vehicle[19]][vCanStart] = 1; VehicleInfo[dakar_vehicle[19]][vUsage] = VEHICLE_USAGE_NORMAL;
    dakar_vehicle[20] = CreateVehicle(495, 386.511688, 2531.422851, 16.901300, 180.254302, 0, 0, 0); VehicleInfo[dakar_vehicle[20]][vHealth] = 1000.0; VehicleInfo[dakar_vehicle[20]][vFuel] = 100; VehicleInfo[dakar_vehicle[20]][vCanStart] = 1; VehicleInfo[dakar_vehicle[20]][vUsage] = VEHICLE_USAGE_NORMAL;
}

stock bool:IsDakarVehicle(carid)
{
    for (new i = 0; i < sizeof(dakar_vehicle); i++)
    {
        if(carid >= dakar_vehicle[0] && carid <= dakar_vehicle[sizeof(dakar_vehicle) - 1])
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

public OnPlayerEnterRaceCheckpoint(playerid)
{
    switch (DakarPlayerCP[playerid])
    {
        case 1:
        {
            GameTextForPlayer(playerid, "~r~Pricekaj ovdje do pocetka Dakar utrke.", 5000, 3);
            DisablePlayerRaceCheckpoint(playerid);
        }
        case 2 .. (sizeof(DakarCheckpoints)-2):
        {
            new cp = DakarPlayerCP[playerid];

            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerRaceCheckpoint(playerid, 0,
                DakarCheckpoints[cp][0],   DakarCheckpoints[cp][1],   DakarCheckpoints[cp][2],
                DakarCheckpoints[cp+1][0], DakarCheckpoints[cp+1][1], DakarCheckpoints[cp+1][2],
                DAKAR_CP_SIZE
            );

            DakarPlayerCP[playerid]++;
        }
        case (sizeof(DakarCheckpoints)-1):
        {
            new cp = DakarPlayerCP[playerid];

            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerRaceCheckpoint(playerid, 1,
                DakarCheckpoints[cp][0], DakarCheckpoints[cp][1], DakarCheckpoints[cp][2],
                DakarCheckpoints[cp][0], DakarCheckpoints[cp][1], DakarCheckpoints[cp][2],
                DAKAR_CP_SIZE
            );

            DakarPlayerCP[playerid]++;
        }
        case sizeof(DakarCheckpoints):
        {
            PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
            defer StopFinishSound(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            GameTextForPlayer(playerid, "~w~Uspjesno ste zavrsili dakar utrku~n~~r~Cestitamo!", 5000, 3);

            DakarPlayers--;
            DakarPlayer  [playerid] = 0;
            DakarPlayerCP[playerid] = 0;
            Player_SetOnEvent(playerid, false);

            if(FirstDakarWinner == INVALID_PLAYER_ID)
            {
                FirstDakarWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[DAKAR EVENT]: %s je pobijedio u Dakar utrci.",
                        GetName(FirstDakarWinner, true)
                    );
                }
            }
            else if(SecondDakarWinner == INVALID_PLAYER_ID)
            {
                SecondDakarWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[DAKAR EVENT]: %s je osvojio drugo mjesto u Dakar utrci.",
                        GetName(SecondDakarWinner, true)
                    );
                }
            }
            else if(ThirdDakarWinner == INVALID_PLAYER_ID)
            {
                ThirdDakarWinner = playerid;
                foreach(new i : Player)
                {
                    va_SendClientMessage(i, COLOR_ORANGE, "[DAKAR EVENT]: %s je osvojio trece mjesto u Dakar utrci.",
                        GetName(ThirdDakarWinner, true)
                    );

                    if(DakarPlayer[i])
                    {
                        SendClientMessage(i, COLOR_ORANGE, "[DAKAR EVENT]: Utrka je zavrsila.");
                        DisablePlayerRaceCheckpoint(i);
                        DakarPlayer  [playerid] = 0;
                        DakarPlayerCP[playerid] = 0;
                    }
                }
                DakarStarted = false;
            }
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    CreateDynamicObject(983, 382.119537, 2528.107178, 16.193573, 0.0000, 0.0000, 268.8997, -1, -1, -1, 200.0);
    dakar_fence[0] = CreateDynamicObject(982, 378.345764, 2489.771484, 16.167931, 0.0000, 0.0000, 359.1406, -1, -1, -1, 200.0);
    dakar_fence[1] = CreateDynamicObject(982, 378.744781, 2515.375977, 16.184555, 0.0000, 0.0000, 359.1406, -1, -1, -1, 200.0);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DakarPlayer  [playerid] = 0;
    DakarPlayerCP[playerid] = 0;
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 495 && !DakarPlayer[playerid])
        {
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Kako bi koristili ovo vozilo, morate biti na Dakar event-u.");
        }
    }
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(vehicleid) == 495 && DakarPlayer[playerid])
    {
        RepairVehicle(vehicleid);
        SetVehicleToRespawn(vehicleid);
        DisablePlayerRaceCheckpoint(playerid);
        DakarPlayer  [playerid] = 0;
        DakarPlayerCP[playerid] = 0;
        SendClientMessage(playerid, COLOR_ORANGE, "[DAKAR EVENT]: Izbaceni ste iz eventa jer ste izasli iz vozila!");
    }
    return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
    if(GetVehicleModel(vehicleid) == 495 && DakarPlayer[killerid])
    {
        RepairVehicle(vehicleid);
        SetVehicleToRespawn(vehicleid);
        DisablePlayerRaceCheckpoint(killerid);
        DakarPlayer  [killerid] = 0;
        DakarPlayerCP[killerid] = 0;
        SendClientMessage(killerid, COLOR_ORANGE, "[DAKAR EVENT]: Izbaceni ste iz eventa jer ste unistili vozilo!");
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

timer OnDakarCountDown[1000]()
{
    if(!DakarStarted)
    {
        stop DakarCountTimer;
    }

    DakarCountdown--;
    if(DakarCountdown != 0)
    {
        foreach(new i : Player)
        {
            if(!DakarPlayer[i]) continue;

            va_GameTextForPlayer(i, "~g~DAKAR - START~n~~w~%d", 1000, 4, DakarCountdown - 1);
            PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
    }
    else
    {
        MoveDynamicObject(dakar_fence[0], 378.345764, 2489.771484, 14.467930, 50.000);
        MoveDynamicObject(dakar_fence[1], 378.744781, 2515.375977, 14.459570, 50.000);
        FirstDakarWinner  = INVALID_PLAYER_ID;
        SecondDakarWinner = INVALID_PLAYER_ID;
        ThirdDakarWinner  = INVALID_PLAYER_ID;

        foreach(new i : Player)
        {
            if(!DakarPlayer[i]) continue;

            new cp = DakarPlayerCP[i];
            SetPlayerRaceCheckpoint(i, 0,
                DakarCheckpoints[cp][0],   DakarCheckpoints[cp][1],   DakarCheckpoints[cp][2],
                DakarCheckpoints[cp+1][0], DakarCheckpoints[cp+1][1], DakarCheckpoints[cp+1][2],
                DAKAR_CP_SIZE
            );
            DakarPlayerCP[i]++;

            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            GameTextForPlayer(i, "~g~GO GO GO", 2500, 4);
        }
        stop DakarCountTimer;
    }
    return 1;
}

timer StopFinishSound[7000](playerid)
{
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
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

CMD:dakar(playerid, params[])
{
    new action[25];
    if(sscanf(params, "s[25] ", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[!] /dakar [option].");
        SendClientMessage(playerid, 0xAFAFAFAA, "(options): join, quit");
        SendClientMessage(playerid, 0xAFAFAFAA, "(admin): create, vehspawn, vehdestroy, startrace, stoprace, goto");
        return 1;
    }

    if(!strcmp(action, "vehdestroy", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        for (new i = 0; i < sizeof(dakar_vehicle); i++)
        {
            DestroyVehicle(dakar_vehicle[i]);
        }
        return 1;
    }
    else if(!strcmp(action, "vehspawn", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        CreateDakarVehicles();
    }
    else if(!strcmp(action, "create", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        SendClientMessageToAll(COLOR_ORANGE, "[DAKAR]: Administrator je pokrenuo dakar, da ucestvujete koristite (/dakar join).");

        DakarCreated = true;
        CreateDakarVehicles();
    }
    else if(!strcmp(action, "join", true))
    {
        if(DakarCreated == false)
            return SendClientMessage(playerid, COLOR_RED, "Administrator nije pokrenuo/kreirao Dakar.");

        if(DakarStarted)
            return SendClientMessage(playerid, COLOR_RED, "[SERVER] Dakar utrka je vec zapocela!");

        if(DakarPlayers == MAX_PLAYERS_ON_DEVENT)
            return SendErrorMessage(playerid, "[ERROR]: Event je popunjen, nema vise mjesta.");

        if(DakarPlayer[playerid])
            return SendClientMessage(playerid, COLOR_RED, "Vec ste se joinali na Dakar.");

        DakarPlayer  [playerid] = 1;
        DakarPlayerCP[playerid] = 1;
        DakarPlayers++;

        SetPlayerPos(playerid, DakarSpawn[0], DakarSpawn[1], DakarSpawn[2]);
        SetPlayerRaceCheckpoint(playerid, 2,
            DakarCheckpoints[0][0], DakarCheckpoints[0][1], DakarCheckpoints[0][2],
            DakarCheckpoints[0][0], DakarCheckpoints[0][1], DakarCheckpoints[0][2],
            30.0
        );
        /*
        SetPlayerRaceCheckpoint(playerid, 0,
            DakarCheckpoints[0][0], DakarCheckpoints[0][1], DakarCheckpoints[0][2],
            DakarCheckpoints[1][0], DakarCheckpoints[1][1], DakarCheckpoints[1][2],
            30.0
        );
        */
        SendClientMessage(playerid, COLOR_RED, "[DAKAR]: Uspjesno ste se prijavili za Dakar event. Udjite u vozilo i stanite na marker.");
        SendClientMessage(playerid, COLOR_RED, "[DAKAR]: Ukoliko zelite odustati, tipkajte /dakar quit.");
        Player_SetOnEvent(playerid, true);
    }
    else if(!strcmp(action, "startrace", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337)
            return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        if(DakarStarted)
            return SendClientMessage(playerid, COLOR_RED, "[SERVER] Dakar je vec pokrenut, trebate ga prije toga zaustaviti (/dakar stoprace).");

        if(DakarCreated == false)
            return SendClientMessage(playerid, COLOR_RED, "Administrator nije pokrenuo/kreirao Dakar.");

        DakarStarted    = true;
        DakarCountdown  = 11;
        DakarCountTimer = repeat OnDakarCountDown();
        SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Zapoceli ste Dakar utrku.");
    }
    else if(!strcmp(action, "stoprace", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Zaustavili ste Dakar utrku.");

        foreach(new i : Player)
        {
            if(!DakarPlayer[i]) continue;

            for (new v = dakar_vehicle[0]; v <= dakar_vehicle[sizeof(dakar_vehicle)-1]; v++)
            {
                if(GetPlayerVehicleID(i) == v)
                {
                    SetVehicleVelocity(v, 0.0, 0.0, 0.0);
                    RemovePlayerFromVehicle(i);
                }
            }

            DisablePlayerRaceCheckpoint(i);
            DakarPlayer  [i] = 0;
            DakarPlayerCP[i] = 0;
            Player_SetOnEvent(i, false);
        }

        DakarStarted = false;
        DakarCreated = false;
        DakarPlayers = 0;

        FirstDakarWinner  = INVALID_PLAYER_ID;
        SecondDakarWinner = INVALID_PLAYER_ID;
        ThirdDakarWinner  = INVALID_PLAYER_ID;

        for (new i = 0; i < sizeof(dakar_vehicle); i++)
        {
            if(IsValidVehicle(dakar_vehicle[i]))
                DestroyVehicle(dakar_vehicle[i]);
        }
        MoveDynamicObject(dakar_fence[0], 378.345764, 2489.771484, 16.167931, 50.000);
        MoveDynamicObject(dakar_fence[1], 378.744781, 2515.375977, 16.184555, 50.000);
        return 1;
    }
    else if(!strcmp(action, "goto", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 2)
            return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande (admin lvl 2+).");

        SetPlayerPos(playerid, DakarSpawn[0], DakarSpawn[1], DakarSpawn[2]);
        return 1;
    }
    else if(!strcmp(action, "quit", true))
    {
        if(DakarPlayer[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_RED, "[SERVER] Niste prijavljeni za Dakar utrku!");
        }

        DakarPlayer  [playerid] = 0;
        DakarPlayerCP[playerid] = 0;
        Player_SetOnEvent(playerid, false);
        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Odustali ste od Dakar utrke.");
        return 1;
    }
    return 1;
}
