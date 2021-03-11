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

#define FACTION_ID_PD                       (1)
#define FACTION_ID_SD                       (3)
#define IMPOUND_PRICE                       (1000)
#define FLASHLIGHT_OBJECT                   (9)

// #define ms_LAWSKIN (969) // pd
//#define ms_GOVSKIN (968) // gov


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static lawskins_police[] =
{
    265, 267, 280, 281, 284, 306, 307, 20500, 20501, 20502, 20503, 20504, 20505, 20506, 20507, 20508, 20509, 20510, 20511,
    20512, 20513, 20514, 20515, 20516, 20517, 20518, 20519, 20520, 20521, 20522, 20523, 20524, 20525, 20526, 20527, 20528,
    20529, 20530, 20531, 20532, 20533, 20534, 20535, 20536, 20537, 20538, 20539, 20540, 20541, 20542, 20543, 20544, 20545,
    20546, 20547, 20548, 20549, 20550, 20551, 20552, 20553, 20554, 20555, 20556, 20557, 20558, 20559, 20560, 20561, 20562,
    20563, 20564, 20565, 20566, 20567, 20568, 20569, 20570, 20571, 20572
};

static lawskins_sheriff[] =
{
    20903, 20904, 20905, 20906, 20907, 20908, 20909, 20910, 20911, 20912, 20913, 20914, 20915, 20916,
    20917, 20918, 20919, 20920, 20921, 20922, 20923, 20924, 20925, 20926, 20927, 20928, 20929, 20930, 20931, 20932, 20933,
    20934, 20935, 20936
};

static
    ramp,
    rampstatus,
    pdkapija,
    pdvrata,
    lspd_doors  [13],
    lspd_dstatus[13];

static
    bool:undercover_mask     [MAX_PLAYERS] = {false, ...},
    Text3D:unknown_text      [MAX_PLAYERS],

    SetPDChannel_ID          [MAX_PLAYERS],
    SetFDChannel_ID          [MAX_PLAYERS],

    bool:PanicAlarmSpamFlag  [MAX_PLAYERS] = {false, ...},
    bool:flashlight_status   [MAX_PLAYERS] = {false, ...},

    // TODO: player related variables should be a part of Player/Char module
    // TODO: players can tie themselves with rope, cuffs should be a PD only functionality
    bool:bPlayerCuffed       [MAX_PLAYERS] = {false, ...},
    // TODO: taser functionality should be in its own module
    bool:bPlayerTased        [MAX_PLAYERS] = {false, ...},
    bool:bHasTaser           [MAX_PLAYERS] = {false, ...},
    bool:bBeanbagBullets     [MAX_PLAYERS] = {false, ...},
    
    Timer:TaserTimer               [MAX_PLAYERS],
    Timer:TaserAnimTimer     [MAX_PLAYERS],
    //
    bool:PDApprovedUndercover[MAX_PLAYERS] = {false, ...},
    bool:PDDuty              [MAX_PLAYERS],
    PoliceWeapon             [MAX_PLAYERS],
    PoliceAmmo               [MAX_PLAYERS],

    bool:PDVehLocked         [MAX_PLAYERS] = {false, ...},
    PDLockedSeat             [MAX_PLAYERS],
    PDLockedVeh              [MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...},

    bool:AllowedGovVehRepair [MAX_PLAYERS] = {false, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_IsCuffed(playerid)
{
    return bPlayerCuffed[playerid];
}

stock Player_SetIsCuffed(playerid, bool:v)
{
    bPlayerCuffed[playerid] = v;
}

stock bool:Player_IsTased(playerid)
{
    return bPlayerTased[playerid];
}

stock Player_SetIsTased(playerid, bool:v)
{
    bPlayerTased[playerid] = v;
}

stock bool:Player_HasTaserGun(playerid)
{
    return bHasTaser[playerid];
}

stock Player_SetHasTaserGun(playerid, bool:v)
{
    bHasTaser[playerid] = v;
}

stock bool:Player_BeanbagBulletsActive(playerid)
{
    return bBeanbagBullets[playerid];
}

stock Player_SetBeanbagBulletsActive(playerid, bool:v)
{
    bBeanbagBullets[playerid] = v;
}

stock bool:Player_PDVehLocked(playerid)
{
    return PDVehLocked[playerid];
}

stock Player_SetPDVehLocked(playerid, bool:v)
{
    PDVehLocked[playerid] = v;
}

stock bool:Player_OnPoliceDuty(playerid)
{
    return PDDuty[playerid];
}

stock Player_SetOnPoliceDuty(playerid, bool:v)
{
    PDDuty[playerid] = v;
}

stock bool:Player_ApprovedUndercover(playerid)
{
    return PDApprovedUndercover[playerid];
}

stock Player_SetApprovedUndercover(playerid, bool:v)
{
    PDApprovedUndercover[playerid] = v;
}

stock bool:Player_CanRepairGovVehicle(playerid)
{
    return AllowedGovVehRepair[playerid];
}

stock Player_SetCanRepairGovVehicle(playerid, bool:v)
{
    AllowedGovVehRepair[playerid] = v;
}

// Callbacks
forward GateClose();
public GateClose()
{
    SetDynamicObjectRot(pdvrata,0,0.2471923828125,358.9912109375);
    MoveDynamicObject(pdkapija,1589.029419, -1638.166748, 15.182871, 2.5);
}

// TODO: move to Taser module
timer OnTaserShoot[1100](playerid)
{
    SetPlayerArmedWeapon(playerid, WEAPON_SILENCED);
    ClearAnimations(playerid);
    return 1;
}

timer ClearTaserEffect[10000](playerid, bool:clearanims)
{
    if(clearanims)
    {
        TogglePlayerControllable(playerid, true);
        ClearAnimations(playerid, 1);
    }
    stop TaserAnimTimer[playerid];
    stop TaserTimer[playerid];

    Player_SetIsTased(playerid, false);
    return 1;
}

timer ApplyTaserAnim[100](playerid)
{
    ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 1, 1, 0);
    return 1;
}

// PA - Panic Alarm
timer PASpamTimer[60000](playerid)
{
    PanicAlarmSpamFlag[playerid] = false;
    return 1;
}

static bool:IsAtArrestPoint(playerid)
{
    new bool:near_arrest_point;

    // "!!" promotes integer to boolean
    near_arrest_point = !!(IsPlayerInRangeOfPoint(playerid, 10.0, 1940.9509, 809.7464, -46.6122)
                        || IsPlayerInRangeOfPoint(playerid, 10.0, 1192.9391,1327.4951,-54.7172));

    return near_arrest_point;
}

/*
GetPDChannelName(pdchannel_id)
{
    new channel_name[20];
    switch (pdchannel_id)
    {
        case 1: // CH 1
            channel_name = "LSPD DISP";
        case 2: // CH 2
            channel_name = "L-TAC 1";
        case 3: // CH 3
            channel_name = "L-TAC 2";
        case 4: // CH 4
            channel_name = "L-TAC 3";
        case 5: // CH 5
            channel_name = "METRO";
        case 6: // CH 6
            channel_name = "DD";
        default:
            channel_name = "N/A";
    }
    return channel_name;
}

GetFDChannelName(fdchannel_id)
{
    new channel_name[20];
    switch (fdchannel_id)
    {
        case 1: // CH 1
            channel_name = "Fire Department";
        case 2: // CH 2
            channel_name = "Medic Department";
        case 3: // CH 3
            channel_name = "Air Divison";
        case 4: // CH 4
            channel_name = "Hazmat Division";
        default:
            channel_name = "N/A";
    }
    return channel_name;
}

SendPDChannelMessage(color = COLOR_WHITE, message[], pdchannel_id)
{
    foreach (new i : Player)
    {
        if(SetPDChannel_ID[i] == pdchannel_id)
        {
            SendClientMessage(i, color, message);
            PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
        }
    }
    return 1;
}

SendFDChannelMessage(color = COLOR_WHITE, message[], fdchannel_id)
{
    foreach (new i : Player)
    {
        if(SetFDChannel_ID[i] == fdchannel_id)
        {
            SendClientMessage(i, color, message);
            PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
        }
    }
    return 1;
}
*/

/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

// Also called on OnPlayerDisconnect
hook function ResetPlayerVariables(playerid)
{
    Player_SetIsCuffed(playerid, false);
    Player_SetIsTased(playerid, false);
    Player_SetHasTaserGun(playerid, false);
    Player_SetApprovedUndercover(playerid, false);
    Player_SetOnPoliceDuty(playerid, false);
    Player_SetBeanbagBulletsActive(playerid, false);

    PDLockedSeat[playerid] = 0;
    PDLockedVeh [playerid] = INVALID_VEHICLE_ID;
    Player_SetPDVehLocked(playerid, false);

    PoliceWeapon[playerid] = 0;
    PoliceAmmo  [playerid] = 0;
	return continue(playerid);
}

hook OnPlayerSpawn(playerid)
{
    PDLockedSeat[playerid] = 0;
    PDLockedVeh [playerid] = INVALID_VEHICLE_ID;
    Player_SetPDVehLocked(playerid, false);
}

hook OnPlayerDisconnect(playerid, reason)
{
    // TODO: should be part of Taser module
    if(Player_IsTased(playerid))
    {
        ClearTaserEffect(playerid, false);
    }
    //
    if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
    {
        DestroyDynamic3DTextLabel(unknown_text[playerid]);
        unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
    }

    PanicAlarmSpamFlag[playerid] = false;
    SetPDChannel_ID[playerid] = 0;
    SetFDChannel_ID[playerid] = 0;
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PanicAlarmSpamFlag[playerid] = false;
    //RemoveBuildingForPlayer(playerid, 3744, 1992.304, -2146.421, 15.132, 0.250);
   // RemoveBuildingForPlayer(playerid, 3574, 1992.296, -2146.414, 15.070, 0.250);

    // Heliport Map by sWiperro
    RemoveBuildingForPlayer(playerid, 5137, 2005.250, -2137.460, 16.515, 0.250);
    RemoveBuildingForPlayer(playerid, 5195, 2005.250, -2137.460, 16.515, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 1992.304, -2146.421, 15.132, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2101.789, -2162.578, 15.132, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2101.796, -2162.562, 15.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 1992.296, -2146.414, 15.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3567, 2083.523, -2159.617, 13.257, 0.250);
    RemoveBuildingForPlayer(playerid, 1306, 2001.023, -2119.984, 19.750, 0.250);
    RemoveBuildingForPlayer(playerid, 5337, 1995.437, -2066.148, 18.531, 0.250);
    return 1;
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    if(!response)
    {
        return 1;
    }
    new index = Player_ModelToIndex(playerid, modelid);
    switch (fselectid)
    {
        case ms_LAWSKIN:
        {
            SetPlayerSkin(playerid, lawskins_police[index]);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Uzeli ste skin ID %d.", lawskins_police[index]);
        }
        case ms_SDSKIN:
        {
            SetPlayerSkin(playerid, lawskins_sheriff[index]);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Uzeli ste skin ID %d.", lawskins_sheriff[index]);
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    CreateDynamicObject(994, 1545.21606, -1620.69897, 12.89000, 0.00000, 0.00000, 90.00000);
    ramp = CreateDynamicObject(968, 1544.6943359375, -1630.73046875, 13.27956199646, 0.000000, 90, 90);
    rampstatus = 0;

    pdkapija = CreateDynamicObject(971,1589.00000000,-1638.00000000,12.89999962,0.00000000,0.00000000,0.00000000);
    pdvrata = CreateDynamicObject(1495,1582.59997559,-1638.00000000,12.39999962,0.00000000,0.00000000,0.00000000);

    // USMS - Garage
    CreateDynamicObject(9093, 606.34991, -1488.73291, 15.62600, 2.00000, 0.00000, 90.00000);
    CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324, 0.00000, 0.00000, 55.47064, 9, -1, -1, 100.00); // world 9
    CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790, 0.00000, 0.00000, 55.47060, 9, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190, 0.00000, 0.00000, 55.02290, 9, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890, 0.00000, 0.00000, 55.02290, 9, -1, -1, 100.00);

    // LSPD WILSHIRE - DOORS (LEO)
    lspd_doors[0] = CreateDynamicObject(1569, -1178.213623, -1668.080688, 896.097229, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[1] = CreateDynamicObject(1569, -1202.099365, -1650.670166, 899.596374, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[2] = CreateDynamicObject(1569, -1201.181274, -1644.569702, 899.596252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[3] = CreateDynamicObject(1569, -1193.331298, -1644.569702, 899.596252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[4] = CreateDynamicObject(1569, -1187.880859, -1647.799438, 899.596252, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[5] = CreateDynamicObject(1569, -1171.442871, -1662.140991, 896.107238, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[6] = CreateDynamicObject(1537, -1165.977783, -1657.548461, 896.127258, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[7] = CreateDynamicObject(3089, -1178.615356, -1646.455932, 897.367919, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[8] = CreateDynamicObject(1569, -1171.442871, -1657.331298, 896.107238, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[9] = CreateDynamicObject(19302, -1192.597412, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[10] = CreateDynamicObject(19302, -1189.407348, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[11] = CreateDynamicObject(19302, -1186.197143, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    lspd_doors[12] = CreateDynamicObject(968, 764.66992, -1416.04749, 13.26500, 0.00000, 89.00000, 0.00000, -1, -1, -1, 600.00, 600.00);

    // Heliport Map by sWiperro
    new heliport_map;
    heliport_map = CreateDynamicObject(10063, 2080.009033, -2141.120849, 8.566017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    heliport_map = CreateDynamicObject(10063, 2020.399658, -2141.110839, 8.576017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    heliport_map = CreateDynamicObject(10063, 2000.639404, -2141.120849, 8.566017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    heliport_map = CreateDynamicObject(970, 2036.231445, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(11504, 2058.239746, -2123.503906, 25.122892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 7488, "vegasdwntwn1", "villainnwall02_128", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 4, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 5, 3436, "motel01", "vegasmoteldoor01_128", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 6, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    heliport_map = CreateDynamicObject(16095, 2057.320556, -2124.391357, 28.212888, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
    heliport_map = CreateDynamicObject(19815, 2060.319335, -2125.897460, 30.389759, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    heliport_map = CreateDynamicObject(19815, 2060.309082, -2125.897460, 31.049757, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    heliport_map = CreateDynamicObject(19815, 2054.348632, -2125.897460, 31.049757, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    heliport_map = CreateDynamicObject(19815, 2054.337646, -2125.897460, 30.379755, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
    heliport_map = CreateDynamicObject(970, 2040.392211, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2044.562622, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(11245, 2054.829101, -2124.099853, 34.433017, -1.399997, -68.400070, 1.899996, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
    heliport_map = CreateDynamicObject(970, 2032.081787, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2027.951660, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2023.791992, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2019.632202, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2015.482543, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2011.332153, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2007.182006, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2003.022216, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1998.862792, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1994.713012, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1990.543212, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1986.382934, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1982.232666, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1978.092651, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1973.933105, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1972.953247, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2048.672607, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2058.202148, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2062.372070, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2066.522949, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2070.692871, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2074.842529, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2078.992431, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2083.152343, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2087.313232, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2091.463134, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2095.624023, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2099.784912, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2103.935058, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2107.495605, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2107.485595, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2103.315917, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2099.155517, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2095.005615, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2090.834716, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2086.684570, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2082.533691, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2078.403808, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2074.233154, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2070.072509, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2065.912597, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2061.762207, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2057.601318, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2053.440917, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2049.281738, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2045.121337, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2040.991455, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2036.840698, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2032.690551, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2028.550415, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2024.410156, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2020.270507, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2016.120727, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2011.981079, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2007.841186, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 2003.700805, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1999.561157, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1995.431152, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1991.300903, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1987.161254, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1982.990722, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1978.859985, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1974.720336, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(970, 1972.959960, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(19452, 2096.780761, -2139.041748, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19370, 1975.499023, -2141.128417, 25.042892, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 13744, "docg01alfa_lahills", "Helipad_H", 0xFFFFFFFF);
    SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 19480, "signsurf", "sign", 0x00000000);
    heliport_map = CreateDynamicObject(19452, 2007.330932, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2020.351318, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 1992.430664, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(3934, 2020.431884, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(3934, 2007.291503, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(3934, 1992.461303, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(19452, 1993.020996, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 1983.401245, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2002.811157, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2012.441406, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2022.071533, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2031.701293, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19370, 2105.870849, -2144.089355, 25.042892, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 13744, "docg01alfa_lahills", "Helipad_H", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 19480, "signsurf", "sign", 0x00000000);
    heliport_map = CreateDynamicObject(19452, 2041.085571, -2142.536376, 23.372894, 0.000000, 0.000000, -106.900001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2050.489990, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2060.129882, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(3934, 2020.431884, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
    heliport_map = CreateDynamicObject(19452, 2069.760253, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2079.380859, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2089.009765, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2098.630126, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19327, 2054.505615, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(heliport_map, 0, "{000000}LOS SANTOS", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    heliport_map = CreateDynamicObject(19327, 2056.606445, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(heliport_map, 0, "{000000}POLICE DEPA", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    heliport_map = CreateDynamicObject(19327, 2058.258056, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(heliport_map, 0, "{000000}RTMENT", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    heliport_map = CreateDynamicObject(19327, 2059.788330, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(heliport_map, 0, "{000000}- HOOVER", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    heliport_map = CreateDynamicObject(19327, 2061.458740, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(heliport_map, 0, "{000000}HELIPORT", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    heliport_map = CreateDynamicObject(19452, 2047.369750, -2127.340576, 23.372894, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2069.108886, -2127.340576, 23.372894, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2064.218505, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2054.607910, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19452, 2052.267333, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    heliport_map = CreateDynamicObject(19430, 2112.638183, -2134.199218, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
    heliport_map = CreateDynamicObject(19430, 2112.638183, -2131.068847, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
    heliport_map = CreateDynamicObject(19430, 2112.638183, -2128.107421, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
    heliport_map = CreateDynamicObject(19430, 2112.638183, -2125.087646, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
    heliport_map = CreateDynamicObject(19452, 2081.080566, -2139.041748, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    heliport_map = CreateDynamicObject(4005, 2085.804931, -2134.004638, 10.148071, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2088.864013, -2144.255615, 10.148071, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2088.154296, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2042.645385, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 1997.125976, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 1994.444702, -2144.645751, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 1991.384765, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2036.883789, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2084.963378, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(4005, 2043.071655, -2133.575439, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3876, 2067.089599, -2123.622802, -5.857117, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(16101, 2054.452880, -2124.048339, 26.549764, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3287, 2044.900634, -2122.031738, 28.362894, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3934, 1992.540161, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3934, 2007.451538, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3934, 2096.443359, -2128.563476, 25.122892, 0.000000, 0.000000, 51.800006, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3666, 1975.421752, -2141.053955, 24.622884, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3666, 2105.837890, -2144.007568, 24.622886, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(11713, 2069.240722, -2126.804199, 26.602890, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(11727, 2065.009277, -2127.627441, 28.032894, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(1537, 2110.136474, -2144.131347, 12.632811, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(8948, 2110.076171, -2139.716552, 14.342810, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    heliport_map = CreateDynamicObject(3934, 2081.253662, -2128.452636, 25.122892, 0.000000, 0.000000, 46.600006, -1, -1, -1, 300.00, 300.00);

    // Impound GaraZa
    CreateObject(17089, -1233.80469, -1451.27344, 98.76563,   356.85840, 0.00000, 3.14159);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_SECONDARY_ATTACK) // LSPD INTERIORI
    {
        if(IsPlayerInRangeOfPoint( playerid, 3.0, 629.6035, 1686.5359, 4503.2939)) // NA ULAZU U HQ
            SetPlayerPosEx(playerid,1539.0114, 11.4043, 4001.5081,3,9,true);
        else if(IsPlayerInRangeOfPoint( playerid, 3.0, 1539.0114, 11.4043, 4001.5081)) // IZLAZ IZ HQa
            SetPlayerPosEx(playerid,629.6035, 1686.5359, 4503.2939,3,10,true);
    }
    if(PRESSED(KEY_NO))
    { // Leo
        if(!IsACop(playerid) && !IsASD(playerid)) return 1;
        if(IsObjectAttached(playerid, 18641) == -1) return 1;
        if(IsPlayerInAnyVehicle(playerid)) return 1;

        if(flashlight_status[playerid])
        {
            // Flashlight is on - remove it
            RemovePlayerAttachedObject(playerid, FLASHLIGHT_OBJECT);
        }
        else
        {
            // Lampa sljasti ko bangkok.
            SetPlayerAttachedObject(playerid, FLASHLIGHT_OBJECT, 18656, 5, 0.1, 0.038, -0.1, -90, 180, 0, 0.03, 0.03, 0.03);
        }

        flashlight_status[playerid] = !flashlight_status[playerid]; // toggle
    }
    if(PRESSED(KEY_YES)) // Tipka Y
    {
        // TODO: make a helper function and a const array of all PD door positions and distances required
        // loop through and get the required index into the array and move the required door
        // doing that will reduce all of this code duplication
        //======================== [LSPD WILSHIRE NEW] =========================
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 764.66992, -1416.04749, 13.26500))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[12] == 0) {
                SetDynamicObjectRot(lspd_doors[12], 0.0000, 0.0000, 0.0000);
                lspd_dstatus[12] = 1;
            }
            else if(lspd_dstatus[12] == 1) {
                SetDynamicObjectRot(lspd_doors[12], 0.0000, 89.0000, 0.0000);
                lspd_dstatus[12] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.2136, -1668.0807, 896.0972))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[0] == 0) {
                SetDynamicObjectRot(lspd_doors[0], 0, 0,  88.6089);
                lspd_dstatus[0] = 1;
            }
            else if(lspd_dstatus[0] == 1) {
                SetDynamicObjectRot(lspd_doors[0], 0, 0, 0.000000);
                lspd_dstatus[0] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1202.099365, -1650.670166, 899.596374))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[1] == 0) {
                SetDynamicObjectRot(lspd_doors[1], 0, 0,  178.4952);
                lspd_dstatus[1] = 1;
            }
            else if(lspd_dstatus[1] == 1) {
                SetDynamicObjectRot(lspd_doors[1], 0, 0,  87.5528);
                lspd_dstatus[1] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1201.1813, -1644.5697, 899.5963))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[2] == 0) {
                SetDynamicObjectRot(lspd_doors[2], 0, 0,  95.0652);
                lspd_dstatus[2] = 1;
            }
            else if(lspd_dstatus[2] == 1) {
                SetDynamicObjectRot(lspd_doors[2], 0, 0, 0.0);
                lspd_dstatus[2] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1193.331298, -1644.569702, 899.596252))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[3] == 0) {
                SetDynamicObjectRot(lspd_doors[3], 0, 0,  88.2804);
                lspd_dstatus[3] = 1;
            }
            else if(lspd_dstatus[3] == 1) {
                SetDynamicObjectRot(lspd_doors[3], 0, 0, 0.0);
                lspd_dstatus[3] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1187.880859, -1647.799438, 899.596252))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[4] == 0) {
                SetDynamicObjectRot(lspd_doors[4], 0, 0, 184.6753);
                lspd_dstatus[4] = 1;
            }
            else if(lspd_dstatus[4] == 1) {
                SetDynamicObjectRot(lspd_doors[4], 0.0000, 0.0000, 90.0000);
                lspd_dstatus[4] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1171.442871, -1662.140991, 896.10723))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[5] == 0) {
                SetDynamicObjectRot(lspd_doors[5], 0.0000, 0.0000, 348.1025);
                lspd_dstatus[5] = 1;
            }
            else if(lspd_dstatus[5] == 1) {
                SetDynamicObjectRot(lspd_doors[5], 0.0000, 0.0000, 90.0000);
                lspd_dstatus[5] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1165.977783, -1657.548461, 896.127258))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[6] == 0) {
                SetDynamicObjectRot(lspd_doors[6], 0.0000, 0.0000, 192.1085);
                lspd_dstatus[6] = 1;
            }
            else if(lspd_dstatus[6] == 1) {
                SetDynamicObjectRot(lspd_doors[6], 0.0000, 0.0000, 270.0000);
                lspd_dstatus[6] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.615356, -1646.455932, 897.367919))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[7] == 0) {
                SetDynamicObjectRot(lspd_doors[7], 0.0000, 0.0000, 181.3910);
                lspd_dstatus[7] = 1;
            }
            else if(lspd_dstatus[7] == 1) {
                SetDynamicObjectRot(lspd_doors[7], 0.0000, 0.0000, 270.0000);
                lspd_dstatus[7] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.615356, -1646.455932, 897.367919))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[8] == 0) {
                SetDynamicObjectRot(lspd_doors[8], 0.0000, 0.0000, 6.7015);
                lspd_dstatus[8] = 1;
            }
            else if(lspd_dstatus[8] == 1) {
                SetDynamicObjectRot(lspd_doors[8], 0.0000, 0.0000, 90.0000);
                lspd_dstatus[8] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1192.5974, -1640.8801, 893.0573))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[9] == 0) {
                MoveDynamicObject(lspd_doors[9],-1194.1974, -1640.8801, 893.0573, 3);
                lspd_dstatus[9] = 1;
            }
            else if(lspd_dstatus[9] == 1) {
                MoveDynamicObject(lspd_doors[9],-1192.8374, -1640.8801, 893.0573, 3);
                lspd_dstatus[9] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1189.4073, -1640.8801, 893.0573))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[10] == 0) {
                MoveDynamicObject(lspd_doors[10],-1190.9873, -1640.8801, 893.0573, 3);
                lspd_dstatus[10] = 1;
            }
            else if(lspd_dstatus[10] == 1) {
                MoveDynamicObject(lspd_doors[10],-1189.4073, -1640.8801, 893.0573, 3);
                lspd_dstatus[10] = 0;
            }
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.5, -1186.1971, -1640.8801, 893.0573))
        {
            if(!IsACop(playerid) && !IsASD(playerid)) return 1;

            if(lspd_dstatus[11] == 0) {
                MoveDynamicObject(lspd_doors[11],-1187.7971, -1640.8801, 893.0573, 3);
                lspd_dstatus[11] = 1;
            }
            else if(lspd_dstatus[11] == 1) {
                MoveDynamicObject(lspd_doors[11],-1186.1971, -1640.8801, 893.0573, 3);
                lspd_dstatus[11] = 0;
            }
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_PD_EQUIP:
        {
            if(!response)
            {
                if(VehicleEquipment[playerid] != INVALID_VEHICLE_ID)
                {
                    new
                        engine, lights, alarm, doors, bonnet, boot, objective;
                    GetVehicleParamsEx(VehicleEquipment[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleParamsEx(VehicleEquipment[playerid], engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
                }
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {   // Skins
                    //ShowPlayerDialog(playerid, DIALOG_PD_SKIN, DIALOG_STYLE_LIST, "ODABIR SKINA", "71\n93\n211\n217\n265\n267\n280\n281\n282\n283\n284\n288\nCivilni skin", "Choose", "Abort");
                    if(IsACop(playerid))
                    {
                        for(new i = 0; i < sizeof(lawskins_police); i++)
                        {
                            if(lawskins_police[i] != 0)
                            {
                                fselection_add_item(playerid, lawskins_police[i]);
                                Player_ModelToIndexSet(playerid, i, lawskins_police[i]);
                            }
                        }
                        fselection_show(playerid, ms_LAWSKIN, "Police Clothes"); 
                    }
                    else if(IsASD(playerid))
                    {
                        for(new i = 0; i < sizeof(lawskins_sheriff); i++)
                        {
                            if(lawskins_sheriff[i] != 0)
                            {
                                fselection_add_item(playerid, lawskins_sheriff[i]);
                                Player_ModelToIndexSet(playerid, i, lawskins_sheriff[i]);
                            }
                        }
                        fselection_show(playerid, ms_SDSKIN, "Sheriff Clothes"); 
                    }
                }
                case 1:
                { // Duty
                    ShowPlayerDialog(playerid, DIALOG_PD_EQUIP_DUTY, DIALOG_STYLE_LIST, "Offduty ili onduty?", "Onduty\nOffduty", "Choose", "Abort");
                }
                case 2:
                { // Heal
                    new
                        Float:tempheal;
                    GetPlayerHealth(playerid,tempheal);
                    if(tempheal < 100.0)
                        SetPlayerHealth(playerid,99.9);

                    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
                    SetPlayerArmour(playerid, 99);

                    ProxDetector(30.0, 
                        playerid, 
                        va_return("* %s wears a kevlar vest.", GetName(playerid, true)), 
                        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
                    );
                }
                case 3:
                { // Buygun
                    if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete koristiti ovu komandu dok ste level 1!"), ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
                    if(IsACop(playerid) && PlayerFaction[playerid][pRank] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste rank 2!"), ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
                    ShowPlayerDialog(playerid,DIALOG_PD_BUYGUN,DIALOG_STYLE_LIST,"POLICE ARMOURY","Desert Eagle - 50 metaka\nShotgun - 50 metaka\nMP5 - 150 metaka\nM4 - 200 metaka\nSniper Rifle - 50 metaka\nKnife\nTeargas - 10\nColt45 - 50\nSilenced - 50 metaka\nSpraycan\nNitestick\nBean Bag - 50 metaka\nRifle - 50 komanda","Choose","Exit");
                }
            }
        }
        case DIALOG_PD_EQUIP_DUTY:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {   // Onduty
                    if(Player_OnLawDuty(playerid))
                    {
                        SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti.!");
                        return 1;
                    }

                    if(!CheckPlayerWeapons(playerid, 24))
                        return 1;

                    AC_ResetPlayerWeapons(playerid); 

                    Player_SetHasTaserGun(playerid, false);
                    Player_SetOnPoliceDuty(playerid, true);
                    Player_SetLawDuty(playerid, true);

                    AC_GivePlayerWeapon(playerid, 3, 1);
                    AC_GivePlayerWeapon(playerid, 24, 50);
                    AC_GivePlayerWeapon(playerid, 41, 1000);
                    AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 500);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                    
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste na duznosti i mozete koristit PD komande.");
                    new 
                        string[144];
                    format(string, sizeof(string), "*[HQ] %s %s je na duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);

                    format(string, sizeof(string), "* %s oblaci svoju radnu uniformu i priprema se za posao.", GetName(playerid, true));
                    ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {   // Off Duty
                    if(!Player_OnLawDuty(playerid))
                    {
                        SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
                        return 1;
                    }

                    AC_ResetPlayerWeapons(playerid);
                    Player_SetOnPoliceDuty(playerid, false);
                    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                    SetPlayerArmour(playerid, 0.0);
                    SetPlayerHealth(playerid, 99.9);
                    SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
                    Player_SetLawDuty(playerid, false);

                    new 
                        string[144];
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sada ste van  duznosti i ne mozete koristit PD komande.");
                    format(string, sizeof(string), "*[HQ] %s %s je van duznosti.", ReturnPlayerRankName(playerid), GetName(playerid,false));
                    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);

                    format(string, sizeof(string), "* %s svlaci svoju radnu uniformu i oblaci civilnu.", GetName(playerid, true));
                    ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            ShowPlayerDialog(playerid, DIALOG_PD_EQUIP, DIALOG_STYLE_LIST, "LSPD Equipment", "Skin\nDuty\nHeal\nWeapons", "Choose", "Abort");
        }
        case DIALOG_PD_BUYGUN:
        {
            if(!response) return 1;

            if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete koristiti ovu funkciju ako ste level 1!");

            // TODO: follow same logic as before: make a const array of weapon names in locker and their ID for GivePlayerWeapon
            // remove this switch statement branching and make a helper function doing the specific task
            new tmpString[65];
            switch (listitem)
            {
                case 0:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_DEAGLE)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_DEAGLE);
                    AC_GivePlayerWeapon(playerid, WEAPON_DEAGLE, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Desert Eagle iz lockera.");
                    format(tmpString, sizeof(tmpString), "** %s je uzeo Desert Eagle iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_SHOTGUN)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_SHOTGUN);
                    AC_GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Shotgun iz lockera.");
                    format(tmpString, sizeof(tmpString), "** %s je uzeo Shotgun iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_MP5)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_MP5);
                    AC_GivePlayerWeapon(playerid, WEAPON_MP5, 150);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste MP5 iz lockera.");
                    format(tmpString, sizeof(tmpString), "** %s je uzeo MP5 iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 3:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_M4)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_M4);
                    AC_GivePlayerWeapon(playerid, WEAPON_M4, 200);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste M4 iz lockera.");
                    format(tmpString, sizeof(tmpString), "** %s je uzeo M4 iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 4:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_SNIPER)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_SNIPER);
                    AC_GivePlayerWeapon(playerid, WEAPON_SNIPER, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Sniper Rifle iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Sniper Rifle iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 5:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_KNIFE)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_KNIFE);
                    AC_GivePlayerWeapon(playerid, WEAPON_KNIFE, 1);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Knife iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Knife iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 6:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_TEARGAS)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_TEARGAS);
                    AC_GivePlayerWeapon(playerid, WEAPON_TEARGAS, 10);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Teargas iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Teargas iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 7:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_COLT45)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_COLT45);
                    AC_GivePlayerWeapon(playerid, WEAPON_COLT45, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Colt45 iz lockera..");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Colt45 iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 8:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_SILENCED)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_SILENCED);
                    AC_GivePlayerWeapon(playerid, WEAPON_SILENCED, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Silenced iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Silenced iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 9:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_SPRAYCAN)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_SPRAYCAN);
                    AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 1000);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Spraycan iz lockera..");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Spraycan iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 10:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_NITESTICK)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_NITESTICK);
                    AC_GivePlayerWeapon(playerid, WEAPON_NITESTICK, 1);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Nitestick iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Nitestick iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 11:
                {
                    if(!CheckPlayerWeapons(playerid, 25)) return 1;
                    AC_GivePlayerWeapon(playerid, 25, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Bean bag shotgun iz Armoury-a.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Bean bag shotgun iz Armoury-a.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    Player_SetBeanbagBulletsActive(playerid, true);
                }
                case 12:
                {
                    if(!CheckPlayerWeapons(playerid, WEAPON_RIFLE)) return 1;
                    AC_ResetPlayerWeapon(playerid, WEAPON_RIFLE);
                    AC_GivePlayerWeapon(playerid, WEAPON_RIFLE, 50);
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Rifle iz lockera.");
                    format(tmpString, sizeof(tmpString), "* %s je uzeo Rifle iz lockera.", GetName(playerid, true));
                    ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
        }
        case DIALOG_PENALCODE:
        {
            if(!response) return 1;
            // TODO: remove this switch statement. either load from database / file or make a const array
            // of strings (newline at the end), eg. LSPD_PenalCode_array[NUM_OF_STATUTES(sections)][STR_MAX_SIZE]
            // the trick is in arranging the same number of messages per "class" (for modulo operator)
            // then just index into the array based on listitem and print out the messages (might have to use modulo operator)
            //
            // when undertaking this feat, extract this functionality in a small, contained filterscript
            // for easier testing (SendClientMessage line limit might be a problem) and to quickly spot problems
            // as there is no dependency needed here on other systems
            switch (listitem)
            {
                case 0:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}1. Ubojstva");
                    SendClientMessage(playerid, COLOR_WHITE, "1.1 - Pokusaj ubojstva - 6,5 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "1.2 - Ubojstvo - 8 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "1.3 - Maliciozno ubojstvo - 8,5 sati");
                }
                case 1:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}2. Fizicki i verbalni kontakti");
                    SendClientMessage(playerid, COLOR_WHITE, "2.1 - Prijetnje - 30 minuta");
                    SendClientMessage(playerid, COLOR_WHITE, "2.2 - Nezakonita upotreba sile - 1 sat");
                    SendClientMessage(playerid, COLOR_WHITE, "2.3 - Tezi oblik nezakonite upotrebe sile - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "2.4 - Napad oruzjem - 3 sata");
                }
                case 2:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}3. Tortura i otmice");
                    SendClientMessage(playerid, COLOR_WHITE, "3.1 - Otmica - 4,5 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "3.2 - Tortura - 7 sati");
                }
                case 3:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}4. Krada imovine (novca i drugih predmeta)");
                    SendClientMessage(playerid, COLOR_WHITE, "4.1 - Krada do 3000$ - 30 minuta + 3000$");
                    SendClientMessage(playerid, COLOR_WHITE, "4.2 - Krada imovine do 10 000$ - 30 minuta + 5 000$");
                    SendClientMessage(playerid, COLOR_WHITE, "4.3 - Krada imovine od 10 000$ - 100 000$ - 3,5 sati zatvora + 20 000$");
                    SendClientMessage(playerid, COLOR_WHITE, "4.4 - Krada imovine preko 100 000$ - 4,5 sati zatvora + 40 000$");
                }
                case 4:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}5. Ostali tipovi krade");
                    SendClientMessage(playerid, COLOR_WHITE, "5.1 - Krada automobila (kolicinski manje)- 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "5.2 - Krada automobila (kolicinski vise)- 4,5 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "5.3 - Krada oruzja (manje) - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "5.4 - Krada oruzja (vise) - 6 sati");
                }
                case 5:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}6. Unistavanje imovine i posjedi");
                    SendClientMessage(playerid, COLOR_WHITE, "6.1 - Vandalizam - 30 minuta");
                    SendClientMessage(playerid, COLOR_WHITE, "6.2 - Palez - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "6.3 - Ulazak u zabranjeno podrucje - 30 min");
                }
                case 6:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}7. Reketiranje i iznude");
                    SendClientMessage(playerid, COLOR_WHITE, "7.1 - Iznuda - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "7.2 - Prevara - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "7.3 - Reketiranje - 7 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "7.4 - Pranje novca - 9 sati");
                }
                case 7:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}8. Uznemiravanje u javnosti");
                    SendClientMessage(playerid, COLOR_WHITE, "8.1 - Isticanje stidnih mjesta i razuzdano ponasanje - 15 min$");
                    SendClientMessage(playerid, COLOR_WHITE, "8.2 - Voajerstvo - 30 min");
                    SendClientMessage(playerid, COLOR_WHITE, "8.3 - Prostitucija - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "8.4 - Svodnistvo - 6 sati");
                }
                case 8:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}9. Sexualno uznemiravanje i ostalo");
                    SendClientMessage(playerid, COLOR_WHITE, "9.1 - Silovanje - 9 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "9.2 - Sexualno nanosenje tjelesnih ozljeda - 9 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "9.3 - Vigilantizam - 6 sati");

                }
                case 9:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}10. Mito, krijumcarenje i ne placanje kazne");
                    SendClientMessage(playerid, COLOR_WHITE, "10.1 - Mito - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "10.2 - Krijumcarenje (blazi oblik)- 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "10.3 - Krijumcarenje (tezi oblik)- 9 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "10.4 - Ne placanje kazne - 1 sat");
                }
                case 10:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}11. Podmicivanje i podvodenje");
                    SendClientMessage(playerid, COLOR_WHITE, "11.1 - Podmicivanje sluzbenog lica - 3 sata + 10 000$");
                    SendClientMessage(playerid, COLOR_WHITE, "11.2 - Podmicivanje osoba iz drzavnih ureda - 3 sata + 20 000$");
                    SendClientMessage(playerid, COLOR_WHITE, "11.3 - Podvodenje biraca - 6 sati + 100 000$");

                }
                case 11:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}12. Kriminal protiv javnoga reda i mira");
                    SendClientMessage(playerid, COLOR_WHITE, "12.1 - Stvaranje nemira - 30 min");
                    SendClientMessage(playerid, COLOR_WHITE, "12.2 - Poticanje na pobunu - 1 sat");
                    SendClientMessage(playerid, COLOR_WHITE, "12.3 - Nezakoniti prosvjedi - 3 sata");
                }
                case 12:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}13. Kriminal protiv javne sigurnosti");
                    SendClientMessage(playerid, COLOR_WHITE, "13.1 - Nezakonito prodavanje na ulici - 30 min");
                    SendClientMessage(playerid, COLOR_WHITE, "13.2 - Koristenje pica u voznji - 15 min");
                    SendClientMessage(playerid, COLOR_WHITE, "13.3 - Lijecenje bez license - 3 sata");
                }
                case 13:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}14. Krsenja pravila voznje motornim vozilima");
                    SendClientMessage(playerid, COLOR_WHITE, "14.1 - Voznja bez dozvole - 30 min");
                    SendClientMessage(playerid, COLOR_WHITE, "14.2 - Bijeg od policije - 1 sat");
                    SendClientMessage(playerid, COLOR_WHITE, "14.3 - Bijeg nakon udesa(laksi oblik) - 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "14.4 - Bijeg nakon udesa (tezi oblik) - 4,5 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "14.5 - Pucanje iz automobila - 6 sati");
                }
                case 14:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}15. Kriminal oruzjem");
                    SendClientMessage(playerid, COLOR_WHITE, "15.1 - Proizvodnja oruzja - 6 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "15.2 - Posjedovanje oruzja (lakse oruzje)- 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "15.3 - Posjedovanje oruzja (automatske puske)- 6 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "15.4 - Posjedovanje oruzja (exploziv) - 9 sati");
                    SendClientMessage(playerid, COLOR_WHITE, "15.5 - Prodaja oruzja - 9 sati");
                }
                case 15:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}16. Prometni zakon");
                    SendClientMessage(playerid, COLOR_WHITE, "16.1 - Maximalna brzina - 15 minuta");
                    SendClientMessage(playerid, COLOR_WHITE, "16.2 - Nesigurna voznja - 10 000$");
                    SendClientMessage(playerid, COLOR_WHITE, "16.3 - Voznja u alkoholiziranom stanju - 30 min");
                    SendClientMessage(playerid, COLOR_WHITE, "16.4 - Posjedovanje NOSa - 3 sata + 10000$");
                    SendClientMessage(playerid, COLOR_WHITE, "16.5 - Voznja u neregistriranome vozilu - 10 000$");
                }
                case 16:
                {
                    SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}17. Prodaja, preprodaja i koristenje opojnih sredstava ");
                    SendClientMessage(playerid, COLOR_WHITE, "17.1 - Koristenje opojnih sredstava - 1 sat");
                    SendClientMessage(playerid, COLOR_WHITE, "17.2 - Prodaja opojnih sredstava (lakse droge)- 3 sata");
                    SendClientMessage(playerid, COLOR_WHITE, "17.3 - Prodaja opojnih sredstava (teze droge)- 6 sati");
                }
            }
        }
        case DIALOG_CODES: 
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - 10 Codes.", "\n{3C95C2}[10-1] Sastanak na lokaciji  / Rollcall.\n\
                        {3C95C2}[10-3] Prekinite pricati na radio.\n\
                        {3C95C2}[10-4] Razumeo.\n\
                        {3C95C2}[10-6] Zanemarite poslednju transmisiju.\n\
                        {3C95C2}[10-8] Slobodan za pozive / clear from.\n\
                        {3C95C2}[10-9] Nedostupan za pozive.\n\
                        {3C95C2}[10-20] Lokacija.\n\
                        {3C95C2}[10-55] Zaustavljeno vozilo na [lokacija] zbog kontrole.\n\
                        {3C95C2}[10-57] VICTOR -  Osumnjiceni bezi u vozilu.\n\
                        {3C95C2}[10-58] FOXTROT -  Osumnjiceni bezi peske.\n\
                        {3C95C2}[10-66] Felony Stop.\n\
                        {3C95C2}[10-70] Potrebno pojacanje.\n\
                        {3C95C2}[10-99] Situacija zavrsena.",
                        "Close", ""
                   );
                }
                case 1:
                {
                    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Response Codes.", "\n{3C95C2}[Code 0] Hitno potrebna asistencija, ostavite sve sto radite i odazovite se.\n\
                        {3C95C2}[Code 1] Odazovite se na radio.\n\
                        {3C95C2}[Code 2] Odazivanje na poziv bez upaljene sirene i rotacij.\n\
                        {3C95C2}[Code 2A] Potreban additional unit (dodatna jedinica).\n\
                        {3C95C2}[Code 3] Odazivanje na poziv sa upaljenom sirenom i rotacijom.\n\
                        {3C95C2}[Code 4] Nepotrebna asistencija.\n\
                        {3C95C2}[Code 5] Svi officeri neka napuste odredjenu lokaciju.\n\
                        {3C95C2}[Code 6] Stigao na scenu.\n\
                        {3C95C2}[Code 7] Na pauzi.\n\
                        {3C95C2}[Code 37]  Ukradeno vozilo.\n\
                        {3C95C2}[Code 77] Oprez na mogucu zasedu.",
                        "Close", ""
                   );
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Identity Codes.", "\n{3C95C2}[IC 1] Belac.\n\
                        {3C95C2}[IC 2] Crnac.\n\
                        {3C95C2}[IC 3] Meksikanac/Latino.\n\
                        {3C95C2}[IC 4] Azijat/Asian.\n\
                        {3C95C2}[IC 5] Nepoznat/Unknown.",
                        "Close", ""
                   );
                }
                case 3:
                {
                    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Terminology / Shortcuts.", "\n{3C95C2}[Start of Watch] Pocetak smene (Primer: Police Officer 100  Start of Watch under 2-LINCOL-10).\n\
                        {3C95C2}[End of Watch] Zavrsetak smene (Primer: Police Officer 100 End of Watch from 2-LINCOL-10).\n\
                        {3C95C2}[Mayday] Pad helikoptera.\n\
                        {3C95C2}[DOA] Dead on Arrival.\n\
                        {3C95C2}[MVA] Motor Vehicle Accident.\n\
                        {3C95C2}[DUI] Driver Under Influence.\n\
                        {3C95C2}[UI] Under Influence.\n\
                        {3C95C2}[Sitrep] Opis situacije / Pretezno koriste supervisory kada se povezu na radio komunikaciju.\n\
                        {3C95C2}[TTCF] Twin Towers Correctional Facility.\n\
                        {3C95C2}[BT] Bomb Threat.\n\
                        {3C95C2}[AC] Aircraft Crash.",
                        "Close", ""
                   );
                }
            }
        }
    }
    return 0;
}

// TODO: Tie was moved to Player module as it's part of player functionality, Cuffing is PD
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(Player_IsCuffed(playerid) &&
        VehicleInfo[vehicleid][vLocked] && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
    {
        new seat = GetPlayerVehicleSeat(playerid);
        PutPlayerInVehicle(playerid, vehicleid, seat);
        GameTextForPlayer(playerid, "~w~Vehicle ~r~locked~", 3000, 4);
    }
    return 1;
}

// TODO: move to Taser module
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(playerid == INVALID_PLAYER_ID)
    {
        Kick(playerid);
        return 0;
    }
    if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid))
    {
        return 0;
    }
    if(weaponid <= 0 || weaponid > 46)
    {
        Kick(playerid);
        return 0;
    }
    if(weaponid < 22 || weaponid > 38)
    {
        return 0;
    }

    if(weaponid == WEAPON_SILENCED && Player_HasTaserGun(playerid) && (IsACop(playerid) || IsASD(playerid)))
    {
        ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0);
        defer OnTaserShoot(playerid);
    }
    return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(issuerid == INVALID_PLAYER_ID)
    {
        return 0;
    }
    if(!IsPlayerLogged(playerid))
    {
        return 1; // TODO: decide what to do for not logged in players, shall they take damage?
    }
    if(!IsACop(issuerid) || !IsASD(issuerid))
    {
        // Player takes all other damage normally
        return 1;
    }

    if(weaponid == WEAPON_SILENCED && Player_HasTaserGun(issuerid))
    {
        if(Player_IsTased(playerid)) return 0;

        new
            Float:taz_x,
            Float:taz_y,
            Float:taz_z,
            Float:taz_h;

        GetPlayerPos(playerid, taz_x, taz_y, taz_z);
        GetPlayerHealth(playerid, taz_h);
        SetPlayerHealth(playerid, taz_h + 1);

        if(ProxDetectorS(10, playerid, issuerid))
        {
            new damageString[87];
            format(damageString, sizeof(damageString), "* %s shoots %s with tazer and he falls down!",
                GetName(issuerid, true),
                GetName(playerid, true)
           );
            ProxDetector(15.0, playerid, damageString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            TogglePlayerControllable(playerid, 0);
            ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 0, 0, 1, 0);
            SetPlayerDrunkLevel(playerid, 10000);

            TaserAnimTimer[playerid] = defer ApplyTaserAnim(playerid);
            TaserTimer[playerid] = defer ClearTaserEffect(playerid, true);
            Player_SetIsTased(playerid, true);
        }
    }
    else if(weaponid == WEAPON_SHOTGUN && Player_BeanbagBulletsActive(issuerid))
    {
        if(Player_IsTased(playerid)) return 0;

        new Float:bb_h;
        GetPlayerHealth(playerid, bb_h);
        SetPlayerHealth(playerid, bb_h + 1);

        if(ProxDetectorS(15, playerid, issuerid))
        {
            new damageString[87];
            format(damageString, sizeof(damageString), "* %s shoots %s with bean bag bullet and he falls!",
                GetName(issuerid, true),
                GetName(playerid, true)
           );
            ProxDetector(15.0, playerid, damageString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            TogglePlayerControllable(playerid, 0);

            ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 1, 1, 0);
            SetPlayerDrunkLevel(playerid, 10000);

            TaserAnimTimer[playerid] = defer ApplyTaserAnim(playerid);
            TaserTimer[playerid] = defer ClearTaserEffect(playerid, true);
            Player_SetIsTased(playerid, true);
        }
    }

    // 0 means block damage update
    return 0;
}

hook OnPlayerTargetPlayer(playerid, targetid, weaponid)
{
    if(targetid != INVALID_PLAYER_ID) return 0;
    if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid)) return 0;
    if(!IsACop(playerid) || !IsASD(playerid)) return 1;

    if(weaponid == WEAPON_SILENCED && Player_HasTaserGun(playerid) && !ProxDetectorS(6.0, playerid, targetid))
    {
        // Reset animation
        ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
    }
    return 1;
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT) 
    {
        if(Player_PDVehLocked(playerid) && PDLockedVeh[playerid] != INVALID_VEHICLE_ID)
        {
            PutPlayerInVehicle(playerid, PDLockedVeh[playerid], PDLockedSeat[playerid]);
        }
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

CMD:beanbag(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni");

    if(AC_GetPlayerWeapon(playerid) != 25)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Kako bi uzeli gumene metke morate imati shotgun.");

    if(!Player_BeanbagBulletsActive(playerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Prebacili ste na gumene metke! Ukucajte komandu opet da vratite na regularne.");
    }
    else
    {
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Prebacili ste na regularne metke! Ukucajte komandu opet da vratite na gumene metke.");
    }
    Player_SetBeanbagBulletsActive(playerid, !Player_BeanbagBulletsActive(playerid));
    return 1;
}

/*
CMD:setchannel(playerid, params[]) {
    new pdchannel_id, fdchannel_id;
    if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || IsAGov(playerid))
    {
        if(IsACop(playerid))
        {
            if(sscanf(params, "d", pdchannel_id))
            {
                SendClientMessage(playerid, COLOR_RED, "[?]: /setchannel [channel_id].");
                SendClientMessage(playerid, COLOR_GREY,"[CH 1] LSPD DISP.");
                SendClientMessage(playerid, COLOR_GREY,"[CH 2] L-TAC 1.");
                SendClientMessage(playerid, COLOR_GREY,"[CH 3] L-TAC 2.");
                SendClientMessage(playerid, COLOR_GREY,"[CH 4] L-TAC 3.");
                SendClientMessage(playerid, COLOR_GREY,"[CH 5] METRO.");
                SendClientMessage(playerid, COLOR_GREY,"[CH 6] DD.");
                return 1;
            }

            if(pdchannel_id < 1 || pdchannel_id > 6)
                return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 1 ili veca od 6!");

            if(pdchannel_id == SetPDChannel_ID[playerid])
                return SendErrorMessage(playerid, "Vec se nalazite u tom kanalu.");
            SetPDChannel_ID[playerid] = pdchannel_id;
            va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste se spojili na channel: %s.", GetPDChannelName(pdchannel_id));
        }
        if(IsFDMember(playerid))
        {
            if(sscanf(params, "d", fdchannel_id))
            {
                SendClientMessage(playerid, COLOR_RED, "[?]: /setchannel [channel_id].");
                SendClientMessage(playerid, COLOR_GREY,"[CH 1] Fire Department");
                SendClientMessage(playerid, COLOR_GREY,"[CH 2] Medic Department");
                SendClientMessage(playerid, COLOR_GREY,"[CH 3] Air Divison");
                SendClientMessage(playerid, COLOR_GREY,"[CH 4] Hazmat Division");
                return 1;
            }

            if(fdchannel_id < 1 || fdchannel_id > 4)
                return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 1 ili veca od 4!");

            if(fdchannel_id == SetFDChannel_ID[playerid])
                return SendErrorMessage(playerid, "Vec se nalazite u tom kanalu.");

            SetFDChannel_ID[playerid] = fdchannel_id;
            va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste se spojili na channel: %s.", GetFDChannelName(fdchannel_id));
        }
    }
    return 1;
}

CMD:ch(playerid, params[]) {
    new string[256], message[128];
    if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || IsAGov(playerid))
    {
        if(IsACop(playerid))
        {
            if(SetPDChannel_ID[playerid] == 0)
            return SendErrorMessage(playerid, "Prvo se morate spojiti na neki od kanala (/setchannel).");

            if(sscanf(params, "s[128]", message)) {
            SendClientMessage(playerid, COLOR_RED, "[?]: /ch [message].");
            return 1;
            }

            format(string, sizeof(string), "**[CH: %s] %s: %s", GetPDChannelName(SetPDChannel_ID[playerid]), GetName(playerid, true), message);
            SendPDChannelMessage(0xB5AF8FFF, string, SetPDChannel_ID[playerid]);
        }

        else if(IsFDMember(playerid))
        {
            if(SetFDChannel_ID[playerid] == 0)
            return SendErrorMessage(playerid, "Prvo se morate spojiti na neki od kanala (/setchannel).");

            if(sscanf(params, "s[128]", message)) {
            SendClientMessage(playerid, COLOR_RED, "[?]: /ch [message].");
            return 1;
            }

            format(string, sizeof(string), "**[CH: %s] %s: %s", GetFDChannelName(SetFDChannel_ID[playerid]), GetName(playerid, true), message);
            SendFDChannelMessage(0xB5AF8FFF, string, SetFDChannel_ID[playerid]);
        }
    } else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/LSFD.");
    return 1;
}
*/

// TODO: move to Taser module
CMD:tazer(playerid, params[])
{
    if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete koristiti ovu funkciju ako ste level 1!");
    if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu u autu.");

    if(!(IsACop(playerid) || IsASD(playerid)))
    {
        return 1;
    }

    new weapon, ammo;
    if(!Player_HasTaserGun(playerid))
    {
        // TODO: helper function, GivePlayerTaser(playerid)
        GetPlayerWeaponData(playerid, 2, weapon, ammo);
        PoliceWeapon[playerid] = weapon;
        PoliceAmmo  [playerid] = ammo;
        AC_ResetPlayerWeapon(playerid, AC_GetPlayerWeapon(playerid));
        AC_GivePlayerWeapon(playerid, 23, 5);

        new
            tazerString[51];
        format(tazerString, sizeof(tazerString), "* %s uzima tazer sa pojasa.", GetName(playerid, true));
        ProxDetector(15.0, playerid, tazerString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    else
    {
        // TODO: helper function TakePlayerTaser(playerid)
        AC_ResetPlayerWeapon(playerid, AC_GetPlayerWeapon(playerid));

        if(PoliceWeapon[playerid])
        {
            AC_GivePlayerWeapon(playerid, PoliceWeapon[playerid], PoliceAmmo[playerid]);
        }
    }
    Player_SetHasTaserGun(playerid, !Player_HasTaserGun(playerid));
    return 1;
}

CMD:arrest(playerid, params[])
{
    new giveplayerid, moneys, jailtime, reason[24], string[128];

    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/USMS.");
    if(!IsAtArrestPoint(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za uhicenje!");
    if(sscanf(params, "uiis[24]", giveplayerid, moneys, jailtime, reason))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /arrest [playerid][cijena][minute][reason]");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uneseni igrac nije online!");
    if(moneys < 1 || moneys > 100000)       return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Cijena zatvora nemoze biti manja od $1 i veca od $5000!");
    if(jailtime < 1 || jailtime > 1000)     return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Minute pritvora nemogu biti manje od 1 i vece od 1000!");
    if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas!");
    //if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi uhitit!");

    va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Uhitili ste %s !", GetName(giveplayerid));
    SendClientMessage(playerid, COLOR_RED, "[!] Odvedite zatvorenika u celiju!");

    format(string, sizeof(string), "* [HQ] %s %s je uhitio %s. Razlog: %s; Kazna: %d$. ", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), reason, moneys);

    if(IsACop(playerid))
        SendRadioMessage(1, COLOR_COP, string);
    else if(IsASD(playerid))
        SendRadioMessage(3, COLOR_COP, string);

    va_GameTextForPlayer(giveplayerid, "Uhitio vas je %s ~n~ za $%d", 5000, 5, GetName(playerid), moneys);
    SendClientMessage(giveplayerid, COLOR_RED, "[!] Nakon sto ste uhiceni, ostali ste bez dozvole za oruzje!");

    AC_ResetPlayerWeapons(giveplayerid);
    LicenseInfo[giveplayerid][pGunLic]    = 0; // ukidanje dozvole za oruzje
    PlayerJail[giveplayerid][pArrested] += 1; // Dodavanje arrest rekorda +1

    if(IsPlayerInRangeOfPoint(playerid, 10.0, 1940.9509, 809.7464, -46.6122))
        PutPlayerInJail(giveplayerid, jailtime, 1);
    else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1192.9391,1327.4951,-54.7172))
        PutPlayerInJail(giveplayerid, jailtime, 3);

    if(IsACop(playerid))
        PlayerToFactionMoney(giveplayerid, FACTION_TYPE_LAW, moneys);
    else if(IsASD(playerid))
        PlayerToFactionMoney(giveplayerid, FACTION_TYPE_LAW2, moneys);

    InsertPlayerMDCCrime(playerid, giveplayerid, reason, jailtime); // spremanje u tablicu dosjee
    return 1;
}

CMD:editarrest(playerid, params[])
{
    new giveplayerid, pick, ammount;

    if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi Policajac.");
    if(!IsAtArrestPoint(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za uhicenje!");
    if(sscanf(params, "iii", giveplayerid, pick, ammount))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /editarrest [pick][ammount] ");
        SendClientMessage(playerid, -1, "Izbor: 1 - vrijeme | 2 - sektor");
        return 1;
    }
    if(!IsPlayerConnected(giveplayerid))    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uneseni igrac nije online!");
    if(pick < 1 || pick > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pogresan izbor.");
    if(PlayerJail[giveplayerid][pJailed] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije u zatvoru.");

    if(pick == 1)
    {
        PlayerJail[giveplayerid][pJailTime] = ammount;
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste vrijeme u zatvoru igracu %s na %i", GetName(giveplayerid), ammount);
    }
    else if(pick == 2)
    {
        // TODO: one variable can not be set to multiple things AT ONCE, maybe logical OR is required?
        if(ammount != 1 && ammount != 2 && ammount != 3) return SendClientMessage(playerid, -1, "SEKTOR: A | B | C");
        PutPlayerInSector(giveplayerid);
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste sektor u zatvoru igracu %s na %i", GetName(giveplayerid), ammount);
    }
    return 1;
}

CMD:unfree(playerid, params[])
{
    if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD!");

    // TODO: what if PlayerFaction[playerid][pMember] is -1 or out of bounds? Do not index into an array so HASTILY
    // Always do bounds checking when appropriate
    if(PlayerFaction[playerid][pRank] < FactionInfo[PlayerFaction[playerid][pMember]][rUnFree])
        return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rank %d kako bi ste mogli koristiti ovu komandu!", FactionInfo[PlayerFaction[playerid][pMember]][rUnFree]);

    new giveplayerid, string[128];
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /unfree [playerid / Part of name]");

    if(giveplayerid == INVALID_PLAYER_ID)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac je offline!");
        return 1;
    }
    if(giveplayerid == playerid)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne mozete osloboditi sami sebe!");
        return 1;
    }
    if(PlayerJail[giveplayerid][pJailed] != 1)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije zatvoren ili je u AREI!");
        return 1;
    }

    format(string, sizeof(string), "* Oslobodili ste %s iz zatvora.", GetName(giveplayerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    format(string, sizeof(string), "* Oslobodjeni ste, oslobodio vas je %s %s.", ReturnPlayerRankName(playerid), GetName(playerid));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
    // TODO: make a function, ResetPlayerJailVariables(playerid)
    PlayerJail[giveplayerid][pBailPrice] = 0;
    PlayerJail[giveplayerid][pJailed] = 0;
    PlayerJail[giveplayerid][pJailTime] = 1;
    SetPlayerColor(giveplayerid,TEAM_HIT_COLOR);
    return 1;
}

CMD:cuff(playerid, params[])
{
    if(!(IsACop(playerid) || IsASD(playerid) || (IsAGov(playerid) && PlayerFaction[playerid][pRank] >= 2)))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi LSPD");
        return 1;
    }

    new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /cuff [playerid / Part of name]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
    //if(Player_IsCuffed(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Osoba vec ima lisice!");
    if(!ProxDetectorS(2.5, playerid, giveplayerid) && IsPlayerInAnyVehicle(playerid) && IsPlayerInAnyVehicle(giveplayerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas !");
        return 1;
    }

    if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi stavit lisice!");

    va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je stavio lisice.", GetName(playerid, true));
    va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Stavio si lisice %s.", GetName(giveplayerid, true));

    // TODO: why not use va_SendClientMessage again? Stick to a standard, do not mix things.
    new
        cuffString[97];
    format(cuffString, sizeof(cuffString), "* %s stavlja lisice na %s, tako da mu nebi pobjegao.", GetName(playerid, true), GetName(giveplayerid, true));
    ProxDetector(30.0, playerid, cuffString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    GameTextForPlayer(giveplayerid, "~r~Uhapsen", 2500, 3);

    // TODO: helper function, CuffPlayer(playerid)
    SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
    SetPlayerAttachedObject(giveplayerid, 7, 19418, 6, -0.027999, 0.051999, -0.030000, -18.699926, 0.000000, 104.199928, 1.489999, 3.036000, 1.957999);
    TogglePlayerControllable(giveplayerid, 1);
    Player_SetIsCuffed(giveplayerid, true);
    return 1;
}

CMD:uncuff(playerid, params[])
{
    if(!(IsACop(playerid) || IsASD(playerid) || (IsAGov(playerid) && PlayerFaction[playerid][pRank] >= 2)))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi LSPD");
        return 1;
    }

    new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /cuff [playerid / Part of name]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
    if(!ProxDetectorS(5.0, playerid, giveplayerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
        return 1;
    }
    if(giveplayerid == playerid)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne mozes skiniti lisice sam sebi!");
        return 1;
    }
    if(!Player_IsCuffed(giveplayerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije zavezan !");
        return 1;
    }

    // TODO: why not use va_SendClientMessage again? Stick to a standard, do not mix things.
    new
        cuffString[57];
    format(cuffString, sizeof(cuffString), "* Officer %s vam je skinuo lisice.", GetName(playerid));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, cuffString);
    format(cuffString, sizeof(cuffString), "* Skinili ste lisice sa %s.", GetName(giveplayerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, cuffString);
    GameTextForPlayer(giveplayerid, "~g~Slobodan", 2500, 3);

    // TODO: helper function RemovePlayerCuffs(playerid)
    if(IsPlayerAttachedObjectSlotUsed(giveplayerid, 7)) RemovePlayerAttachedObject(giveplayerid, 7);
    SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
    Player_SetIsCuffed(giveplayerid, false);
    return 1;
}

CMD:pdtrunk(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

    new vehicleid = GetNearestVehicle(playerid);
    if(vehicleid == INVALID_VEHICLE_ID)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila!");
    if(IsVehicleWithoutTrunk(GetVehicleModel(vehicleid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema prtljaznik!");

    // Helper function, Toggle/OpenVehicleTrunk(vehicleid), which based on the value of the variable
    // VehicleInfo[vehicleid][vTrunk] (could be turned into a getter)
    // does the appropriate action of opening or closing the vehicle trunk
    new
        engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF)
    {
        SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
        VehicleInfo[vehicleid][vTrunk] = VEHICLE_PARAMS_ON;
        GameTextForPlayer(playerid, "~w~gepek otvoren", 1000, 5);
    }
    else if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_ON)
    {
        SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
        VehicleInfo[vehicleid][vTrunk] = VEHICLE_PARAMS_OFF;
        GameTextForPlayer(playerid, "~w~gepek zatvoren", 1000, 5);
    }
    return 1;
}

CMD:pdramp(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 20, 1544.7363,-1627.0232,13.3672)) return SendClientMessage(playerid, COLOR_RED,"Niste u blizini rampe!");
    if(PlayerFaction[playerid][pLeader] != 1 && PlayerFaction[playerid][pMember] != 1) return SendClientMessage(playerid, COLOR_RED,"Niste clan LS-PDa.");

    rampstatus ^= 1; // toggle
    if(rampstatus)
    {
        MoveDynamicObject(ramp, 1544.6943359375, -1630.73046875, 13.27956199646+0.0001, 0.0002, 0, 0, 90);
        SendClientMessage(playerid, COLOR_RED, "[!] Identitet potvrdjen! Rampa se otvara...");
    }
    else
    {
        MoveDynamicObject(ramp, 1544.6943359375, -1630.73046875, 13.27956199646-0.0001, 0.0003, 0, 90, 90);
        SendClientMessage(playerid, COLOR_RED, "[!] Identitet potvrdjen! Rampa se zatvara...");
    }
    return 1;
}

CMD:law(playerid, params[])
{
    new pd_counter, sd_counter, fd_counter, gov_counter;

    foreach(new i: Player)
    {
        if(IsFDMember(i))
            fd_counter++;

        if(IsASD(i))
            sd_counter++;

        if(IsACop(i))
            pd_counter++;

        if(IsAGov(i))
            gov_counter++;
    }

    va_SendClientMessage(playerid, COLOR_WHITE, "{3C95C2}Law Enforcement On Duty:\n{FFFFFF}\
Police: %d; Sheriffs: %d; Fire Department: %d; Government: %d;", pd_counter, sd_counter, fd_counter, gov_counter);
    return 1;
}

CMD:govrepair(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    // TODO: what if vehicleid is 65535 = INVALID_VEHICLE_ID?
    // Always do bounds checking before indexing an array!!!
    // TODO: consider splitting this long line (split at around 120 characters)
    if(VehicleInfo[vehicleid][vFaction] != 1 && VehicleInfo[vehicleid][vFaction] != 2 && VehicleInfo[vehicleid][vFaction] != 3 && VehicleInfo[vehicleid][vFaction] != 4 && VehicleInfo[vehicleid][vFaction] != 5) return SendClientMessage(playerid,COLOR_RED, "Mozes popravljati samo vozila organizacije!");
    if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");

    // TODO: reduce level of nesting (at least by 2, maybe even 3 levels)
    new fid = PlayerFaction[playerid][pMember];
    if(fid != 4)
    {
        if(FactionInfo[fid][fFactionBank] < 100) return SendClientMessage(playerid,COLOR_RED, "Vasa organizacija nema novaca!");
        if(IsACop(playerid))
        {
            if(PlayerFaction[playerid][pMember] == 1)
            {
                // TODO: consider splitting this long line (split at around 120 characters)
                if(IsPlayerInRangeOfPoint(playerid, 5.0, 1570.4080,-1632.6095,13.3828) || IsPlayerInRangeOfPoint(playerid, 10.0, 755.9906,-1431.2805,13.5234) || IsPlayerInRangeOfPoint(playerid, 10.0, 1136.7454,2286.2957,10.8203) || IsPlayerInRangeOfPoint(playerid, 10.0, 2055.0149,-2150.2551,26.1129))
                {
                    AC_RepairVehicle(vehicleid);
                    AC_SetVehicleHealth(vehicleid, 1200.0);
                    VehicleInfo[vehicleid][vFuel] = 100;
                    VehicleInfo[vehicleid][vCanStart] = 1;
                    VehicleInfo[vehicleid][vDestroyed] = false;
                    Player_SetCanRepairGovVehicle(playerid, false);
                    FactionToBudgetMoney(FACTION_TYPE_LAW, 100); // Novac ide iz factionbank u proraeun
                    SendClientMessage(playerid, COLOR_RED, "[!] Vase vozilo je popravljeno i napunjeno gorivom.");
                }
                else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za popravak vozila!");
            }
        }
        else if(IsASD(playerid))
        {
            if(IsPlayerInRangeOfPoint(playerid, 10.0, 622.9983,-601.3151,16.0462)) {
                AC_RepairVehicle(vehicleid);
                AC_SetVehicleHealth(vehicleid, 1200.0);
                VehicleInfo[vehicleid][vFuel] = 100;
                VehicleInfo[vehicleid][vCanStart] = 1;
                VehicleInfo[vehicleid][vDestroyed] = false;
                Player_SetCanRepairGovVehicle(playerid, false);
                FactionToBudgetMoney(FACTION_TYPE_LAW2, 100); // Novac ide iz factionbank u proraeun
                SendClientMessage(playerid, COLOR_RED, "[!] Vase vozilo je popravljeno i napunjeno gorivom.");
            }
            else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za popravak vozila!");
        }
        else if(IsANews(playerid))
        {
            if(IsPlayerInRangeOfPoint(playerid, 10.0, 292.1505,-1545.1261,24.5938)) // NEWS
            {
                AC_RepairVehicle(vehicleid);
                AC_SetVehicleHealth(vehicleid, 1000.0);
                VehicleInfo[vehicleid][vFuel] = 100;
                VehicleInfo[vehicleid][vCanStart] = 1;
                VehicleInfo[vehicleid][vDestroyed] = false;
                Player_SetCanRepairGovVehicle(playerid, false);
                FactionToBudgetMoney(FACTION_TYPE_NEWS, 100); // Novac ide iz factionbank u proraeun
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
            }
            else return SendClientMessage(playerid, COLOR_RED, "[!] Niste na mjestu za popravak vozila!");
        }
        else if(IsFDMember(playerid))
        {
            if(IsPlayerInRangeOfPoint(playerid, 10.0, 1174.9698,-1309.0844,13.9958)) // LSFD
            {
                AC_RepairVehicle(vehicleid);
                AC_SetVehicleHealth(vehicleid, 1000.0);
                VehicleInfo[vehicleid][vFuel] = 100;
                VehicleInfo[vehicleid][vCanStart] = 1;
                VehicleInfo[vehicleid][vDestroyed] = false;
                Player_SetCanRepairGovVehicle(playerid, false);
                FactionToBudgetMoney(FACTION_TYPE_FD, 100); // Novac ide iz factionbank u proraeun
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
            }
            else return SendClientMessage(playerid, COLOR_RED, "[!] Niste na mjestu za popravak vozila!");
        }
    }
    else if(IsAGov(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 15.0, 1471.5919,-1830.6121,13.5469)) // Mayor
        {
            AC_RepairVehicle(vehicleid);
            if(VehicleInfo[vehicleid][vBodyArmor] == 1) AC_SetVehicleHealth(vehicleid, 1600.0);
            else AC_SetVehicleHealth(vehicleid, 1000.0);
            VehicleInfo[vehicleid][vFuel] = 100;
            VehicleInfo[vehicleid][vCanStart] = 1;
            VehicleInfo[vehicleid][vDestroyed] = false;
            Player_SetCanRepairGovVehicle(playerid, false);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
        }
        else return SendClientMessage(playerid, COLOR_RED, "[!] Niste na mjestu za popravak vozila!");
    }
    else SendClientMessage(playerid,COLOR_RED, "Nisi ovlasten za koristenje ove komande.");
    return 1;
}

CMD:codes(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

    ShowPlayerDialog(playerid,DIALOG_CODES,DIALOG_STYLE_LIST,"Police Scanner Codes","{3C95C2}[1] - 10 Codes\n{3C95C2}[2] - Response Codes\n{3C95C2}[3] - Identity Codes\n{3C95C2}[4] - Terminology","Choose","Close");
    return 1;
}

CMD:suspend(playerid, params[])
{
    new giveplayerid, string[128];
    if((PlayerFaction[playerid][pLeader] == 1 || (PlayerFaction[playerid][pRank] >= 11 && PlayerFaction[playerid][pMember] == 1)) || PlayerFaction[playerid][pLeader] == 5)
    {
        if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /suspend [playerid / Part of name]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");

        PlayerFaction[giveplayerid][pRank] = 0;
        Player_SetLawDuty(giveplayerid, false);
        format(string, sizeof(string), "[!] Suspendirali ste %s sa duznosti!", GetName(giveplayerid));
        SendClientMessage(playerid, COLOR_RED, string);
        format(string, sizeof(string), "[!] Suspendirani ste sa duznosti! Command officer %s", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_RED, string);
    }
    else if(PlayerFaction[playerid][pLeader] == 4)
    {
        if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /suspend [playerid / Part of name]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");

        PlayerFaction[giveplayerid][pRank] = 0;
        Player_SetLawDuty(giveplayerid, false);
        format(string, sizeof(string), "[!] Suspendirali ste %s sa duznosti!", GetName(giveplayerid));
        SendClientMessage(playerid, COLOR_RED, string);
        format(string, sizeof(string), "[!] Suspendirani ste sa duznosti! Mayor %s", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_RED, string);
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi dovoljan rank!");
    return 1;
}

CMD:lawdoors(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste clan LSPDa/USMSa!");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste vozac!");

    new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /lawdoors [dio imena/playerid]");
    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan unos igraca!");

    new string[62];
    if(Player_PDVehLocked(giveplayerid))
    {
        format(string, sizeof(string), "* %s otkljucava zadnja vrata u vozilu.", GetName(playerid));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

        PDLockedSeat[giveplayerid] = 0;
        PDLockedVeh [giveplayerid] = INVALID_VEHICLE_ID;
        Player_SetPDVehLocked(giveplayerid, false);
    }
    else
    {
        format(string, sizeof(string), "* %s zakljucava zadnja vrata u vozilu.",GetName(playerid));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

        PDLockedSeat[giveplayerid] = GetPlayerVehicleSeat(giveplayerid);
        PDLockedVeh [giveplayerid] = GetPlayerVehicleID(playerid);
        Player_SetPDVehLocked(giveplayerid, true);
    }
    return 1;
}

CMD:take(playerid, params[])
{
    new opcija[20], giveplayerid;
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac !");
    if(PlayerFaction[playerid][pRank] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti rank 1 ili vise da bi koristio ovo !");

    if(sscanf( params, "us[20] ", giveplayerid, opcija))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /take [playerid][opcija]");
        SendClientMessage(playerid, COLOR_RED, "[!] driverslicense - flyinglicense - boatlicense - weaponlicense - weapons - toolkit");
        SendClientMessage(playerid, COLOR_RED, "[!] weaponpackage - drugs");
        return 1;
    }
    if(strcmp(opcija,"driverslicense",true) == 0)
    {
        new dani, year, month, day;
        getdate(year, month, day);

        if(sscanf(params, "us[20]i ", giveplayerid, opcija, dani)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /take [ID][izbor][dani]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");

        new tmpString[120];
        format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo vozacku dozvolu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|_____________________ Oduzeta vozacka dozvola ______________________|");
        format(tmpString, sizeof(tmpString), "* %s %s vam je oduzeo vozacku dozvolu na %d dana.", ReturnPlayerRankName(playerid), GetName(playerid), dani);
        SendClientMessage(giveplayerid, 0xCC0000FF, tmpString);
        format(tmpString, sizeof(tmpString), "* Danasnji datum: %d.%d.%d.", day, month, year);
        SendClientMessage(giveplayerid, 0xCC0000FF, tmpString);
        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|____________________________________________________________________|");

        LicenseInfo[giveplayerid][pCarLic] = 0;
    }
    else if(strcmp(opcija,"weaponpackage",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");

        new
            tmpString[71];
        format(tmpString, sizeof(tmpString), "[!] Oduzeli ste %s sve weapon pakete.", GetName(giveplayerid));
        SendClientMessage(playerid, COLOR_RED, tmpString);
        format(tmpString, sizeof(tmpString), "* Policajac %s vam je oduzeo weapon pakete.", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);

        RemoveWeaponPackages(giveplayerid);
    }
    else if(strcmp(opcija,"flyinglicense",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");

        new
            tmpString[120];
        format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo dozvolu za letenje %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
        SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

        format(tmpString, sizeof(tmpString), "* Policajac %s vam je oduzeo dozvolu za letenje.", GetName(playerid));
        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);
        LicenseInfo[giveplayerid][pFlyLic] = 0;
    }
    else if(strcmp(opcija,"toolkit",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(ProxDetectorS(5.0, playerid, giveplayerid)) {
            new
                tmpString[77];
            format(tmpString, sizeof(tmpString), "[!] Oduzeli ste %s opremu za obijanje.", GetName(giveplayerid));
            SendClientMessage(playerid, COLOR_RED, tmpString);
            format(tmpString, sizeof(tmpString), "[!] Policajac %s vam je oduzeo opremu za obijanje.", GetName(playerid));
            SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
            PlayerInventory[giveplayerid][pToolkit] = 0;
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
    }
    else if(strcmp(opcija,"weaponlicense",true) == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "[!] Komanda je izbacena");
        return 1;
    }
    /*
    else if(strcmp(opcija,"weaponlicense",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(ProxDetectorS(5.0, playerid, giveplayerid)) {
            new
                tmpString[120];
            format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo dozvolu za oruzje %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
            SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

            format(tmpString, sizeof(tmpString), "[!] Policajac %s vam je oduzeo dozvolu za oruzje.", GetName(playerid));
            SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
            LicenseInfo[giveplayerid][pGunLic] = 0;
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
    }*/
    else if(strcmp(opcija,"boatlicense",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(ProxDetectorS(5.0, playerid, giveplayerid)) {
            new
                tmpString[120];
            format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeoeku dozvolu za brod%s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
            SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);

            format(tmpString, sizeof(tmpString), "[!] Policajac %s vam je oduzeo dozvolu za brod.", GetName(playerid));
            SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
            LicenseInfo[giveplayerid][pBoatLic] = 0;
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
    }
    else if(strcmp(opcija,"weapons",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(ProxDetectorS(5.0, playerid, giveplayerid)) {

            new
                tmpString[65];
            format(tmpString, sizeof(tmpString), "[!] Oduzeli ste %s oruzje.", GetName(giveplayerid));
            SendClientMessage(playerid, COLOR_GREEN, tmpString);
            format(tmpString, sizeof(tmpString), "[!] Policajac %s vam je oduzeo oruzje.", GetName(playerid));
            SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
            AC_ResetPlayerWeapons(giveplayerid);
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
    }
    else if(strcmp(opcija,"drugs",true) == 0)
    {
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
        if(ProxDetectorS(5.0, playerid, giveplayerid))
        {
            new
                tmpString[65];
            format(tmpString, sizeof(tmpString), "[!] Oduzeli ste %s drogu.", GetName(giveplayerid));
            SendClientMessage(playerid, COLOR_GREEN, tmpString);
            format(tmpString, sizeof(tmpString), "[!] Policajac %s vam je oduzeo drogu.", GetName(playerid));
            SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
            DeletePlayerDrug(giveplayerid, -1);
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
    }
    else SendClientMessage(playerid, COLOR_RED, " Nepoznato ime za oduzimanje !");
    return 1;
}

CMD:checktrunk(playerid, params[])
{
    new vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_PRIVATE);
    if(vehicleid == INVALID_VEHICLE_ID) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu privatnog vozila.");
    if(IsVehicleWithoutTrunk(GetVehicleModel(vehicleid))) 
        return SendClientMessage(playerid, COLOR_RED, "Ovo vozilo nema prtljaznik!");
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) 
        return SendClientMessage(playerid, COLOR_RED, "Morate biti na nogama da biste koristili ovu komandu.");
    if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF) 
        return SendClientMessage(playerid, COLOR_RED, "Prtljaznik je zatvoren.");
   
    ShowPlayerDialog(playerid, DIALOG_VEH_CHECKTRUNK, DIALOG_STYLE_MSGBOX, "Oruzja u vozilu:", ListPlayerVehicleWeapons(playerid, vehicleid), "Exit", "");

    new
        tmpString[49];
    format(tmpString, sizeof(tmpString), "* %s gleda u prtljaznik.", GetName(playerid));
    ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

CMD:impound(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

    new
        vehicleid = GetPlayerVehicleID(playerid);
    // TODO: array bounds checking
    if(VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Mozete zaplijeniti samo osobna vozila!");

    new
        Float:X, Float:Y, Float:Z,
        Float:z_rot;
    GetVehiclePos(vehicleid, X, Y, Z);
    GetVehicleZAngle(vehicleid, z_rot);

    VehicleInfo[vehicleid][vParkX]      = X;
    VehicleInfo[vehicleid][vParkY]      = Y;
    VehicleInfo[vehicleid][vParkZ]      = Z;
    VehicleInfo[vehicleid][vAngle]      = z_rot;
    VehicleInfo[vehicleid][vImpounded]  = 1;

    mysql_fquery(SQL_Handle(), 
        "UPDATE cocars SET parkX = '%f', parkY = '%f', parkZ = '%f', angle = '%f', impounded = '%d' WHERE id = '%d'",
        X,
        Y,
        Z,
        z_rot,
        VehicleInfo[vehicleid][vImpounded],
        VehicleInfo[vehicleid][vSQLID]
   );

    new
        engine, lights, alarm, doors, bonnect, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnect, boot, objective);
    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnect, boot, objective);

    new
        tmpString[120];
    format(tmpString, sizeof(tmpString), "*[HQ] %s %s je zaplijenio vozilo (ID: %d).", ReturnPlayerRankName(playerid), GetName(playerid), vehicleid);
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, tmpString);
    RemovePlayerFromVehicle(playerid);
    return 1;
}

CMD:payimpound(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar vozila!");

    new
        vehicleid = GetPlayerVehicleID(playerid);
    // TODO: array bounds checking
    if(!VehicleInfo[vehicleid][vImpounded]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar zaplijenjenog vozila!");

    VehicleInfo[vehicleid][vImpounded]  = 0;

    mysql_fquery(SQL_Handle(), "UPDATE cocars SET impounded = '%d' WHERE id = '%d'",
        VehicleInfo[vehicleid][vImpounded],
        VehicleInfo[vehicleid][vSQLID]
   );

    PlayerToFactionMoney(playerid, FACTION_TYPE_LAW, IMPOUND_PRICE); // novac igraea ide u factionbank od PDa

    SendClientMessage( playerid, COLOR_RED, "[!] Uspjesno ste platili zaplijenu vozila!");
    SendClientMessage( playerid, COLOR_RED, "[!] Morate kupiti novi parking inace ce vam se vozilo spawnati u impound garazi!");
    return 1;
}

// TODO: should be a part of Fire Department module commands
// TODO: also don't hardcode positions, make a const array
CMD:fdgarage(playerid, params[])
{
    if(!IsACop(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

    // TODO: reduce level of nesting
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1178.1522, -1338.7764, 13.9013) && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 284.8465, -1540.9485, 24.5968, 9, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 287.2799, -1537.8717, 24.5278);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 9);
                }
            }

            SetPlayerVirtualWorld(playerid, 9);
            SetVehicleVirtualWorld(vehicleid, 9);
            SetVehicleZAngle(vehicleid, 160);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 10.0, 284.8465, -1540.9485, 24.5968) && GetPlayerVirtualWorld(playerid) == 9)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 1178.1522, -1338.7764, 13.9013, 0, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 1178.1522, -1338.7764, 13.9013);
            SetVehicleVirtualWorld(vehicleid, 0);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleZAngle(vehicleid, -90);
        }
    }
    return 1;
}

CMD:pdgarage(playerid, params[])
{
    if(!IsACop(playerid) && PlayerFaction[playerid][pLeader] != 1)
        return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

    // TODO: reduce level of nesting
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 755.9906,-1431.2805,13.5234) && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 1583.6351, -1639.1971, 13.4000, 60, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 1589.5824, -1642.6031, 12.9500);

            foreach(new i : Player) {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 60);
                }
            }

            SetPlayerVirtualWorld(playerid, 60);
            SetVehicleVirtualWorld(vehicleid, 60);
            SetVehicleZAngle(vehicleid, 198.5400);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1589.5824, -1642.6031, 12.9500) && GetPlayerVirtualWorld(playerid) == 60)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 756.1514, -1432.2513, 13.3890, 0, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 755.1030, -1436.6173, 17.1210);
            SetVehicleVirtualWorld(vehicleid, 0);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleZAngle(vehicleid, 271.2346);
        }
    }
    return 1;
}

CMD:pdgarage1(playerid, params[])
{
    if(!IsACop(playerid) && PlayerFaction[playerid][pLeader] != 1)
        return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

    // TODO: reduce level of nesting
    //MAIN HQ
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 2150.9697, -2190.0781, 13.2593) && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 1148.2179, 2264.5469, 12.6698, 90, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 1148.2179, 2264.5469, 12.6698);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 90);
                }
            }

            SetPlayerVirtualWorld(playerid, 90);
            SetVehicleVirtualWorld(vehicleid, 90);
            SetVehicleZAngle(vehicleid, 1.0812);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 15.0, 1148.2179, 2264.5469, 12.6698))
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 2150.9697, -2190.0781, 13.2593, 0, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 2150.9697, -2190.0781, 13.2593);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleVirtualWorld(vehicleid, 0);
            SetVehicleZAngle(vehicleid, 1.0812);
        }
    }
    return 1;
}

// TODO: no idea what SD means, but it should be part of SD module commands
CMD:sdgarage(playerid, params[])
{
    if(!IsASD(playerid) && PlayerFaction[playerid][pLeader] != 1)
        return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

    // TODO: reduce level of nesting
    //MAIN HQ
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 629.1385, -625.4520, 17.0423) && GetPlayerVirtualWorld(playerid) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, -1631.8292, 692.3904, 6.7737, 70, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, -1631.8292, 692.3904, 6.7737);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 70);
                }
            }

            SetPlayerVirtualWorld(playerid, 70);
            SetVehicleVirtualWorld(vehicleid, 70);
            SetVehicleZAngle(vehicleid, 358.4658);
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 20.0, -1631.8292, 692.3904, 6.7737))
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerPosEx(playerid, 629.1385, -625.4520, 17.0423, 0, 0, false);
        }
        else
        {
            new
                vehicleid = GetPlayerVehicleID(playerid);
            SetVehiclePos(vehicleid, 629.1385, -625.4520, 17.0423);

            foreach(new i : Player)
            {
                if(IsPlayerInVehicle(i, vehicleid))
                {
                    SetPlayerVirtualWorld(i, 0);
                }
            }

            SetPlayerVirtualWorld(playerid, 0);
            SetVehicleVirtualWorld(vehicleid, 0);
            SetVehicleZAngle(vehicleid, 271.7859);
        }
    }
    return 1;
}

CMD:pdunlock(playerid, params[])
{
    if(!IsACop(playerid) && PlayerFaction[playerid][pLeader] != 1 && !IsASD(playerid) && PlayerFaction[playerid][pLeader] != 3)
        return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

    if(!IsPlayerInRangeOfPoint(playerid, 30.0, 1985.1077, -2183.0867, 13.5469))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za koristenje /pdunlock komande!");

    new vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_PRIVATE);
    if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");

    // TODO: helper function ToggleVehicleLock(vehicleid)/UnlockVehicle(vehicleid)
    new
        engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);
    VehicleInfo[vehicleid][vLocked] = false;

    new
        string[46];
    GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 3);
    format(string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true));
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
    return 1;
}

CMD:cleartrunk(playerid, params[])
{
    if(!IsACop(playerid) && PlayerFaction[playerid][pLeader] != 1) return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

    if(PlayerFaction[playerid][pRank] < FactionInfo[PlayerFaction[playerid][pMember]][rClrTrunk])
         return va_SendClientMessage(playerid,COLOR_RED, "Niste policajac R%d+!", FactionInfo[PlayerFaction[playerid][pMember]][rClrTrunk]);

    new vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_PRIVATE);
    if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");

    new
        string[48];
    format(string, sizeof(string), "* %s uzima sav sadrzaj iz vozila.", GetName(playerid, true));
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);

    DeleteVehicleWeapons(vehicleid);

    #if defined MODULE_LOGS
    new carname[32];
    strunpack(carname, Model_Name(VehicleInfo[vehicleid][vModel]));

    Log_Write("/logfiles/pd_taketrunk.txt", "(%s) %s(%s) emptied the trunk of %s. [Owner: %s | Owner SQLID: %d]",
        GetName(playerid, false),
        ReturnPlayerIP(playerid),
        carname,
        ConvertSQLIDToName(VehicleInfo[vehicleid][vOwner]),
        VehicleInfo[vehicleid][vOwner]
   );
    #endif

    SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste uzeli oruzje iz gepeka.");
    return 1;
}

// TODO: should be part of undercover module with its own helper functions and local variables
CMD:undercover(playerid, params[])
{
    // TODO: reduce level of nesting
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSPDa/USMSa!");
    if(!IsPlayerInRangeOfPoint(playerid, 6.0, 2877.2317,-843.6631,-21.6994) && !IsPlayerInRangeOfPoint(playerid,6.0,2040.6858,1260.2460,-11.1115) && !IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) && !IsPlayerInRangeOfPoint(playerid,5.0,1073.3243,1309.4116,-47.7425))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar LSPD/SASD armorya da bi ste mogli koristiti ovu komandu.");

    if(!isnull(PlayerExName[playerid]))
    {
        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj pravi nick!");
        SetPlayerName(playerid, PlayerExName[playerid]);
        PlayerExName[playerid][0] = EOS;
        return 1;
    }

    if(!Player_ApprovedUndercover(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati odobrenje za undercover!");

    new
        param[8],
        item;

    if(sscanf( params, "s[8] ", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /undercover [skins/name/mask]");
    if(!strcmp(param, "skins", true))
    {
        if(sscanf( params, "s[8]i", param, item)) return SendClientMessage(playerid, COLOR_RED, "[?]: /undercover skins [skinid]");

        if(1 <= item <= 299)
        {
            switch (item)
            {
                case 147, 277, 278, 289, 286, 285, 287, 282, 283, 274, 275, 276: return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan Skin ID!");
            }

            new
                tmpString[65];
            format(tmpString, sizeof(tmpString), "* %s skida svoju uniformu i presvlaci se.", GetName(playerid, true));
            ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            SetPlayerSkin(playerid, item);
            SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Presvukli ste se i sada vas nitko nece moci prepoznati.");
            Player_SetApprovedUndercover(playerid, false);
        }
        else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan Skin ID!");
    }
    if(!strcmp(param, "name", true))
    {
        if(!isnull(PlayerExName[playerid]))
        {
            SetPlayerName(playerid, PlayerExName[playerid]);
            SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj prijasnji nick!");
            PlayerExName[playerid][0] = EOS;
            return 1;
        }

        new
            newName[MAX_PLAYER_NAME];
        if(sscanf(params, "s[7]s[24]", param, newName)) return SendClientMessage(playerid, COLOR_RED, "[?]: /undercover name [novi nick]");
        if(!IsValidName(newName)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan roleplay nick!");

        format(PlayerExName[playerid], MAX_PLAYER_NAME, GetName(playerid, false));

        new status = SetPlayerName(playerid, newName);
        if(status == -1)
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko na serveru posjeduje taj nick!");
        }
        else if(status == 0)
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete taj nick!");
        }
        else if(status == 1)
        {
            va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili nick u %s", newName);
            Player_SetApprovedUndercover(playerid, false);
        }
    }
    if(!strcmp(param, "mask", true))
    {
        if(undercover_mask[playerid] == false)
        {
            foreach(new i : Player)
            {
                ShowPlayerNameTagForPlayer(i, playerid, 0);
            }

            SendClientMessage(playerid, COLOR_RED, "[Undercover]: Iznad glave vam pise 'unknown', sto znaci da igraci vise nece imati mogucnost vidjet vas nick.");

            new
                undercover_Name[24];
            format(undercover_Name, sizeof(undercover_Name), "Unknown_%d", PlayerInventory[playerid][pMaskID]);
            if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
            {
                DestroyDynamic3DTextLabel(unknown_text[playerid]);
                unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
            }
            undercover_mask[playerid] = true;
            unknown_text[playerid] = CreateDynamic3DTextLabel(undercover_Name, 0xB2B2B2AA, 0, 0, -20, 25, playerid);
            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, unknown_text[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
        }
        else if(undercover_mask[playerid] == true)
        {
            foreach(new i : Player)
            {
                ShowPlayerNameTagForPlayer(i, playerid, 1);
            }

            undercover_mask[playerid] = false;
            va_SendClientMessage(playerid, COLOR_RED, "[Undercover]: Vise niste undercover, nick iznad glave vam je vracen na defualt (%s).", GetName(playerid));

            if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
            {
                DestroyDynamic3DTextLabel(unknown_text[playerid]);
                unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
            }
        }
    }
    return 1;
}

CMD:pa(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD/LSFD!");
    if(PanicAlarmSpamFlag[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate malo pricekati prije koristenja Panic Alarma ponovno.");

    new tmpString[128];
    format(tmpString, sizeof(tmpString), "** %s pritisce Panic Alarm dugme na radio-prijamniku.", GetName(playerid, true));
    SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
    SendClientMessage(playerid, COLOR_PURPLE, tmpString);

    new zone[100];
    format(zone, sizeof(zone), GetPlayerStreet(playerid));
    format(tmpString, sizeof(tmpString), "[HQ] Panic Alarm se upalio od strane %s %s.", ReturnPlayerRankName(playerid), GetName(playerid, false));
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_SKYBLUE, tmpString);
    format(tmpString, sizeof(tmpString), "[HQ] Zadnja lokacija je %s.", zone);
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_SKYBLUE, tmpString);

    PanicAlarmSpamFlag[playerid] = true;
    defer PASpamTimer(playerid);
    return 1;
}

CMD:hq(playerid, params[])
{
    if(strlen(params) >= 110)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Tekst ne smije imati vise od 110 znakova!");

    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD!");

    new
        string[144], result[110];
    if(sscanf(params, "s[110]", result)) return SendClientMessage(playerid, COLOR_RED, "[?]: /hq [text]");

    format(string, sizeof(string), "[HQ] %s %s: %s", ReturnPlayerRankName(playerid), GetName(playerid, false), result);
    SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_SKYBLUE, string);
    return 1;
}

CMD:ramdoor(playerid, params[])
{
    if(!IsACop(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PD/FD!");
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");

    new
        house = Player_InfrontHouse(playerid);
    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se pred vratima kuce!");
    if(!HouseInfo[house][hLock]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su otkljucana!");

    if(IsCrowbarBreaking(playerid))
    {
        CancelCrowbarBreaking(playerid);
        return 1;
    }

    new
        object = IsObjectAttached(playerid, 18634);
    if(object == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pajser u rukama!");

    if(5 <= PlayerObject[playerid][object][poBoneId] <= 6)
    {
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pricekajte tipke koje morate unijeti, za prekid probijanja kucajte /ramdoor!");
        SetPlayerCrowbarBreaking(playerid);
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pajser mora biti u rukama!");
    return 1;
}

CMD:housetake(playerid, params[])
{
    if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PDa!");

    new
        param[8],
        house = Player_InHouse(playerid);

    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
    if(sscanf(params, "s[8]", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /housetake [weapons]");

    if(!strcmp(param, "weapons", true))
    {
        // Enum
        new id = Storage_PlayerNearRack(playerid);
        if(id == -1)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini police s oruzjem!");

        for (new i = 0; i < MAX_WEAPON_ONRACK; i++)
        {
            Storage_SetRackWeaponInSlot(id, i, 0);
            Storage_SetRackAmmoInSlot(id, i, 0);
            HouseStorage_SaveWep(id, i);
        }
        Storage_RackRefresh(id);
        HouseStorage_Save(id);

        #if defined MODULE_LOGS
        Log_Write("/logfiles/pd_housetakes.txt", "(%s) %s emptied out all weapons from storage[ID: %d] of house[Address: %s | SQLID: %d]", 
            ReturnDate(), 
            GetName(playerid, false), 
            Storage_GetId(id), 
            HouseInfo[house][hAdress],
            HouseInfo[house][hSQLID]
       );
        #endif

        new
            tmpString[55];
        format(tmpString, sizeof(tmpString), "* %s uzima svo oruzje sa police.", GetName(playerid, true));
        ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    return 1;
}

CMD:returnduty(playerid, params[])
{
    if(!IsACop(playerid) && !IsFDMember(playerid) && !IsASD(playerid) && !IsAGov(playerid)) return SendClientMessage(playerid,COLOR_RED, "Niste ovlasteni!");
    if(Player_OnLawDuty(playerid)) 
        return SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti!");

    new vehicleid;
    if(IsACop(playerid))
        vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_FACTION, FACTION_TYPE_LAW);
    else if(IsFDMember(playerid))
        vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_FACTION, FACTION_TYPE_FD);
    else if(IsASD(playerid))
        vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_FACTION, FACTION_TYPE_LAW2);
    else if(IsAGov(playerid))
        vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_FACTION, FACTION_TYPE_LEGAL);
   
    if(vehicleid == INVALID_VEHICLE_ID)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu fakcijskog vozila!");

    Player_SetLawDuty(playerid, true);
    Player_SetOnPoliceDuty(playerid, true);

    new tmpstring[120];
    format(tmpstring, sizeof(tmpstring), "*[HQ] %s %s je ponovno na duznosti (( Crash)).", ReturnPlayerRankName(playerid), GetName(playerid,false));

    if(IsACop(playerid))
        SendRadioMessage(1, COLOR_COP, tmpstring);
    if(IsASD(playerid))
        SendRadioMessage(3, COLOR_COP, tmpstring);
    else if(IsFDMember(playerid))
        SendRadioMessage(2, COLOR_ALLDEPT, tmpstring);
    else if(IsAGov(playerid))
        SendRadioMessage(4, COLOR_DARKYELLOW, tmpstring);

    return 1;
}

CMD:callsign(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PDa/SDa!");
    if(!Player_OnLawDuty(playerid)) return SendClientMessage(playerid,COLOR_RED, "Morate biti na duznosti!");

    if(isnull(params))
        return SendClientMessage(playerid, COLOR_RED, "[?]: /callsign [UNIT]");

    new
        str[128];
    format(str, sizeof(str), "** HQ: %s %s je sada pod callsignom %s! **", ReturnPlayerRankName(playerid), GetName(playerid,false), params);
    if(IsACop(playerid))
        SendRadioMessage(1, COLOR_COP, str);
    if(IsASD(playerid))
        SendRadioMessage(3, COLOR_COP, str);
    return 1;
}
