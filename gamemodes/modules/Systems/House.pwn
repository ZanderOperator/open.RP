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

#define ZONE_WIDTH              150.0
#define ZONE_HEIGHT             195.0

#define CP_TYPE_HOUSE       (1)


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
    Iterator: House<MAX_HOUSES>;

enum E_HOUSE_INTS
{
    Float:iEnterX,
    Float:iEnterY,
    Float:iEnterZ,
    iInterior,
    iDescription[42]
}
static const HouseInts[][E_HOUSE_INTS] =
{
    {235.3054,     1186.6835,      1080.2578,      3,     "Large/2 story/3 bedrooms"                 },
    {225.756989,   1240.000000,    1082.149902,    2,     "Medium/1 story/1 bedroom"                 },
    {223.1929,     1287.0780,      1082.1406,      1,     "Small/1 story/1 bedroom"                  },
    {225.630997,   1022.479980,    1084.069946,    7,     "Very Large/2 story/4 bedrooms"            },
    {295.138977,   1474.469971,    1080.519897,    15,    "Small/1 story/2 bedrooms"                 },
    {328.1066,     1478.0106,      1084.4375,      15,    "Small/1 story/2 bedrooms"                 },
    {385.803986,   1471.769897,    1080.209961,    15,    "Small/1 story/1 bedroom/no bathroom"      },
    {375.971985,   1417.269897,    1081.409912,    15,    "Small/1 story/1 bedroom"                  },
    {490.810974,   1401.489990,    1080.339966,    2,     "Large/2 story/3 bedrooms"                 },
    {446.8264,     1397.3435,      1084.3047,      5,     "Medium/1 story/2 bedrooms"                },
    {227.722992,   1114.389893,    1081.189941,    4,     "Large/2 story/4 bedrooms"                 },
    {260.983978,   1286.549927,    1080.299927,    4,     "Small/1 story/1 bedroom"                  },
    {221.7330,     1140.5146,      1082.6094,      10,    "Small/1 story/1 bedroom/NO BATHROOM"      },
    {23.9878,      1340.3865,      1084.3750,      4,     "Medium/2 story/1 bedroom"                 },
    {-262.601990,  1456.619995,    1084.449951,    5,     "Large/2 story/1 bedroom/NO BATHROOM"      },
    {22.778299,    1404.959961,    1084.449951,    5,     "Medium/1 story/2 bedrooms/NO BATHROOM"    },
    {140.2267,     1365.9246,      1083.8594,      6,     "Large/2 story/4 bedrooms/NO BATHROOM"     },
    {234.045990,   1064.879883,    1084.309937,    6,     "Large/2 story/3 bedrooms"                 },
    {-68.294098,   1353.469971,    1080.279907,    15,    "Small/1 story/NO BEDROOM"                 },
    {-285.548981,  1470.979980,    1084.449951,    8,     "1 bedroom/living room/kitchen/NO BATHROOM"},
    {-42.581997,   1408.109985,    1084.449951,    9,     "Small/1 story/NO BEDROOM"                 },
    {83.345093,    1324.439941,    1083.889893,    9,     "Medium/2 story/2 bedrooms"                },
    {260.941986,   1238.509888,    1084.259888,    1,     "Small/1 story/1 bedroom"                  },
    {244.411987,   305.032990,     999.231995,     2,     "Denise's Bedroom"                         },
    {266.4986,     305.0700,       999.1484,       3,     "Katie's Bedroom"                          },
    {291.282990,   310.031982,     999.154968,     4,     "Helena's Bedroom (barn)"                  },
    {302.181000,   300.722992,     999.231995,     5,     "Michelle's Bedroom"                       },
    {322.197998,   302.497986,     999.231995,     6,     "Barbara's Bedroom"                        },
    {343.7173,     304.9440,       999.1484,       3,     "Millie's Bedroom"                         },
    {2495.6416,    -1692.2361,     1014.7422,      5,     "CJ's Mom's House"                         },
    {1263.079956,  -785.308960,    1091.959961,    2,     "Madd Dogg's Mansion (West door)"          },
    {2468.450,     -1698.4801,     1013.5078,      1,     "Ryder's house"                            },
    {2526.459961,  -1679.089966,   1015.500000,    2,     "Sweet's House"                            },
    {2543.659912,  -1303.629883,   1025.069946,    6,     "Big Smoke's Crack Factory (Ground Floor)" },
    {744.542969,   1437.669922,    1102.739990,    3,     "Fanny Batter's Whore House"               },
    {964.106995,   -53.205498,     1001.179993,    5,     "Tiger Skin Rug Brothel"                   },
    {2350.339844,  -1181.649902,   1028.000000,    8,     "Burning Desire Gang House"                },
    {2807.9172,    -1174.4333,     1025.5703,      5,     "Colonel Furhberger's House"               },
    {318.6453,     1114.4795,      1083.8828,      12,    "Crack Den"                                },
    {2324.3267,    -1149.1440,     1050.7101,      12,    "Unused Safe House"                        },
    {446.5014,     507.0295,       1001.4195,      15,    "Budget Inn Motel Room"                    },
    {2216.3398,    -1150.5099,     1025.7969,      11,    "Jefferson Motel"                          }
};

static
    GlobalMapIcon[MAX_PLAYERS],
    HouseAlarmZone[MAX_HOUSES],
    Timer:GlobalZoneT[MAX_HOUSES],
    Timer:GlobalMapIconT[MAX_HOUSES],
    Float:PickLockMaxValue[MAX_PLAYERS][3],
    PlayerBar:PickLockBars[MAX_PLAYERS][3],
    PlayerBar:FootKickingBar[MAX_PLAYERS],
    Float:tmpPos[MAX_PLAYERS][3],
    tmpInterior[MAX_PLAYERS],
    tmpSkin[MAX_PLAYERS],
    tmpViwo[MAX_PLAYERS],
    SkinSlot[MAX_PLAYERS],
    CreatingHouseID[MAX_PLAYERS],
    PickLockTimeC[MAX_PLAYERS],
    Timer:PickLockTimer[MAX_PLAYERS],
    Timer:PlayerPickLockTimer[MAX_PLAYERS],
    Timer:PlayerClosedTimer[MAX_PLAYERS],
    AlarmEffect[3] = { 41800, 3401, 42801 };

enum
{
    DOOR_RAM_NONE = 0,
    DOOR_RAM_FOOT = 1,
    DOOR_RAM_CROWBAR = 2
};

static
    HouseAreaID[MAX_PLAYERS],
    HouseCP[MAX_PLAYERS],
    InHouse[MAX_PLAYERS], 
    InfrontHouse[MAX_PLAYERS],
    bool:HouseAlarmActive[MAX_HOUSES],
    bool:PickingLock[MAX_PLAYERS],
    PickLockSlot[MAX_PLAYERS],
    RammingDoor[MAX_PLAYERS] = {DOOR_RAM_NONE, ...};

static
    PlayerText:HouseBcg1        [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:HouseBcg2        [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:HouseInfoText    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:HouseInfoTD      [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:HouseCMDTD       [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:PicklockBcg      [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:Picklock1Done    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:Picklock2Done    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:Picklock3Done    [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:PickLockTimeTitle[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:PickLockTime     [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:FootKickingBcg1  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:FootKickingBcg2  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:FootKickingText  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};   

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

bool: House_Exists(houseid)
{
    return Iter_Contains(House, houseid);
}

Player_InHouse(playerid)
{
    return InHouse[playerid];
}

Player_SetInHouse(playerid, v)
{
    InHouse[playerid] = v;
}

Player_InfrontHouse(playerid)
{
    return InfrontHouse[playerid];
}

Player_SetInfrontHouse(playerid, v)
{
    InfrontHouse[playerid] = v;
}

Player_GetHouseCP(playerid)
{
    return HouseCP[playerid];
}

Player_SetHouseCP(playerid, v)
{
    HouseCP[playerid] = v;
}

Player_HouseArea(playerid)
{
    return HouseAreaID[playerid];
}

Player_SetHouseArea(playerid, v)
{
    HouseAreaID[playerid] = v;
}

Player_GetRammingDoor(playerid)
{
    return RammingDoor[playerid];
}

Player_SetRammingDoor(playerid, v)
{
    RammingDoor[playerid] = v;
}

GetHouseFromSQL(sqlid)
{
    new 
        housekey = INVALID_HOUSE_ID;
    foreach(new house : House) 
	{
		if(HouseInfo[house][hOwnerID] == sqlid) 
		{
			housekey = house;
			break;
		}
	}
    return housekey;
}

CheckPlayerHouseInt(playerid, int, viwo)
{
    foreach(new h: House)
	{
		if(IsPlayerInRangeOfPoint(playerid, 250.0, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]) 
            && HouseInfo[h][hInt] == int 
            && HouseInfo[h][hVirtualWorld] == viwo)
		{
			Player_SetInHouse(playerid, h);
			break;
		}
	}
    return 1;
}

Public:OnHouseInsertInDB(houseid, playerid)
{
    HouseInfo[houseid][hSQLID] = cache_insert_id();
    if(HouseInfo[houseid][hInt] > 0)
    {
        HouseInfo[houseid][hVirtualWorld] = HouseInfo[houseid][hSQLID];
        UpdateHouseVirtualWorld(houseid);
    }
    else
        ShowPlayerDialog(playerid, DIALOG_VIWO_PICK, DIALOG_STYLE_INPUT, "Odabir Virtual Worlda", "Molimo Vas unesite Virtual World(viwo) u kojem je kuca namappana:", "Input", "Exit");

    return 1;
}

stock UpdateHouseVirtualWorld(houseid)
{
    if(!Iter_Contains(House, houseid))
        return 1;

    mysql_fquery(g_SQL, "UPDATE houses SET viwo = '%d' WHERE id = '%d'",
        HouseInfo[houseid][hVirtualWorld],
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

stock ResetHouseVariables(playerid)
{
    tmpPos[playerid][0]     = 0.0;
    tmpPos[playerid][1]     = 0.0;
    tmpPos[playerid][2]     = 0.0;

    tmpInterior[playerid]       = 0;
    tmpSkin[playerid]           = 1;
    SkinSlot[playerid]          = 0;
    tmpViwo[playerid]           = 0;
    CreatingHouseID[playerid] = INVALID_HOUSE_ID;

    DestroyHouseInfoTD(playerid);
    stop PlayerClosedTimer[playerid];

    ResetLockPickVars(playerid);
    ResetDoorKickingVars(playerid);

    RammingDoor[playerid] = DOOR_RAM_NONE;
    PickingLock[playerid] = false;
    PickLockSlot[playerid] = 3;
    
    Player_SetInHouse       (playerid, INVALID_HOUSE_ID);
    Player_SetInfrontHouse  (playerid, INVALID_HOUSE_ID);
    Player_SetHouseCP       (playerid, INVALID_HOUSE_ID);
    Player_SetHouseArea     (playerid, INVALID_HOUSE_ID);
    return 1;
}

stock CreateHouseInfoTD(playerid)
{
    DestroyHouseInfoTD(playerid);

    HouseBcg1[playerid] = CreatePlayerTextDraw(playerid, 639.612121, 116.752761, "usebox");
    PlayerTextDrawLetterSize(playerid,      HouseBcg1[playerid], 0.000000, 10.236042);
    PlayerTextDrawTextSize(playerid,        HouseBcg1[playerid], 497.499877, 0.000000);
    PlayerTextDrawAlignment(playerid,       HouseBcg1[playerid], 1);
    PlayerTextDrawColor(playerid,           HouseBcg1[playerid], 0);
    PlayerTextDrawUseBox(playerid,          HouseBcg1[playerid], true);
    PlayerTextDrawBoxColor(playerid,        HouseBcg1[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       HouseBcg1[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      HouseBcg1[playerid], 0);
    PlayerTextDrawFont(playerid,            HouseBcg1[playerid], 0);
    PlayerTextDrawShow(playerid,            HouseBcg1[playerid]);

    HouseBcg2[playerid] = CreatePlayerTextDraw(playerid, 639.575012, 116.860000, "usebox");
    PlayerTextDrawLetterSize(playerid,      HouseBcg2[playerid], 0.000000, 1.238053);
    PlayerTextDrawTextSize(playerid,        HouseBcg2[playerid], 497.500000, 0.000000);
    PlayerTextDrawAlignment(playerid,       HouseBcg2[playerid], 1);
    PlayerTextDrawColor(playerid,           HouseBcg2[playerid], 0);
    PlayerTextDrawUseBox(playerid,          HouseBcg2[playerid], true);
    PlayerTextDrawBoxColor(playerid,        HouseBcg2[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       HouseBcg2[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      HouseBcg2[playerid], 0);
    PlayerTextDrawFont(playerid,            HouseBcg2[playerid], 0);
    PlayerTextDrawShow(playerid,            HouseBcg2[playerid]);

    HouseInfoText[playerid] = CreatePlayerTextDraw(playerid, 501.850006, 117.488006, "HOUSE INFO");
    PlayerTextDrawLetterSize(playerid,      HouseInfoText[playerid], 0.336050, 1.023200);
    PlayerTextDrawAlignment(playerid,       HouseInfoText[playerid], 1);
    PlayerTextDrawColor(playerid,           HouseInfoText[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       HouseInfoText[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      HouseInfoText[playerid], 1);
    PlayerTextDrawFont(playerid,            HouseInfoText[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, HouseInfoText[playerid], 51);
    PlayerTextDrawSetProportional(playerid, HouseInfoText[playerid], 1);
    PlayerTextDrawShow(playerid,            HouseInfoText[playerid]);

    HouseInfoTD[playerid] = CreatePlayerTextDraw(playerid, 503.999877, 134.456085, "Vlasnik: Richard Collins~n~Cijena: 10.000~g~$~n~~w~Rent: 10~g~$~n~~w~Level: 16");
    PlayerTextDrawLetterSize(playerid,      HouseInfoTD[playerid], 0.282599, 0.967758);
    PlayerTextDrawAlignment(playerid,       HouseInfoTD[playerid], 1);
    PlayerTextDrawColor(playerid,           HouseInfoTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       HouseInfoTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      HouseInfoTD[playerid], 0);
    PlayerTextDrawFont(playerid,            HouseInfoTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, HouseInfoTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, HouseInfoTD[playerid], 1);
    PlayerTextDrawShow(playerid,            HouseInfoTD[playerid]);

    HouseCMDTD[playerid] = CreatePlayerTextDraw(playerid, 503.550079, 190.175903, "Raspolozive komande:~n~      /doorshout, /ring, /enter");
    PlayerTextDrawLetterSize(playerid,      HouseCMDTD[playerid], 0.240599, 0.879841);
    PlayerTextDrawAlignment(playerid,       HouseCMDTD[playerid], 1);
    PlayerTextDrawColor(playerid,           HouseCMDTD[playerid], -5963521);
    PlayerTextDrawSetShadow(playerid,       HouseCMDTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      HouseCMDTD[playerid], 0);
    PlayerTextDrawFont(playerid,            HouseCMDTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, HouseCMDTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, HouseCMDTD[playerid], 1);
    PlayerTextDrawShow(playerid,            HouseCMDTD[playerid]);
    return 1;
}

stock DestroyHouseInfoTD(playerid)
{
    PlayerTextDrawDestroy(playerid, HouseBcg1[playerid]);
    PlayerTextDrawDestroy(playerid, HouseBcg2[playerid]);
    PlayerTextDrawDestroy(playerid, HouseInfoText[playerid]);
    PlayerTextDrawDestroy(playerid, HouseInfoTD[playerid]);
    PlayerTextDrawDestroy(playerid, HouseCMDTD[playerid]);

    HouseBcg1    [playerid] = PlayerText:INVALID_TEXT_DRAW;
    HouseBcg2    [playerid] = PlayerText:INVALID_TEXT_DRAW;
    HouseInfoText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    HouseInfoTD  [playerid] = PlayerText:INVALID_TEXT_DRAW;
    HouseCMDTD   [playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}

stock LoadHouses()
{
    Iter_Init(House);
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM houses WHERE 1"), 
        "OnServerHousesLoad", 
        ""
   );
    return 1;
}

Public:OnServerHousesLoad()
{
    new num_rows = cache_num_rows();
    if(!num_rows) return printf("MySQL Report: No houses exist to load.");

    for (new row = 0; row < num_rows; row++)
    {
        cache_get_value_name_int(row,       "id"        ,   HouseInfo[row][hSQLID]);
        cache_get_value_name_float(row,     "enterX"    ,   HouseInfo[row][hEnterX]);
        cache_get_value_name_float(row,     "enterY"    ,   HouseInfo[row][hEnterY]);
        cache_get_value_name_float(row,     "enterZ"    ,   HouseInfo[row][hEnterZ]);
        cache_get_value_name_float(row,     "exitX" ,   HouseInfo[row][hExitX]);
        cache_get_value_name_float(row,     "exitY" ,   HouseInfo[row][hExitY]);
        cache_get_value_name_float(row,     "exitZ" ,   HouseInfo[row][hExitZ]);
        cache_get_value_name(row,           "adress"    ,   HouseInfo[row][hAdress], 32);
        cache_get_value_name_int(row,       "ownerid"   ,   HouseInfo[row][hOwnerID]);
        cache_get_value_name_int(row,       "value"     ,   HouseInfo[row][hValue]);
        cache_get_value_name_int(row,       "int"       ,   HouseInfo[row][hInt]);
        cache_get_value_name_int(row,       "viwo"      ,   HouseInfo[row][hVirtualWorld]);
        cache_get_value_name_int(row,       "lock"      ,   HouseInfo[row][hLock]);
        cache_get_value_name_int(row,       "rentabil"  ,   HouseInfo[row][hRentabil]);
        cache_get_value_name_int(row,       "takings"   ,   HouseInfo[row][hTakings]);
        cache_get_value_name_int(row,       "level" ,   HouseInfo[row][hLevel]);
        cache_get_value_name_int(row,       "freeze"    ,   HouseInfo[row][hFreeze]);
        cache_get_value_name_int(row,       "viwoexit"  ,   HouseInfo[row][h3dViwo]);
        cache_get_value_name_int(row,       "opensafe"  ,   HouseInfo[row][hSafeStatus]);
        cache_get_value_name_int(row,       "safepass"  ,   HouseInfo[row][hSafePass]);
        cache_get_value_name_int(row,       "safe"      ,   HouseInfo[row][hSafe]);
        cache_get_value_name_int(row,       "ormar" ,   HouseInfo[row][hOrmar]);
        cache_get_value_name_int(row,       "skin1" ,   HouseInfo[row][hSkin1]);
        cache_get_value_name_int(row,       "skin2" ,   HouseInfo[row][hSkin2]);
        cache_get_value_name_int(row,       "skin3" ,   HouseInfo[row][hSkin3]);
        cache_get_value_name_int(row,       "groceries",    HouseInfo[row][hGroceries]);
        cache_get_value_name_int(row,       "doorlevel" , HouseInfo[row][hDoorLevel]);
        cache_get_value_name_int(row,       "alarm"     , HouseInfo[row][hAlarm]);
        cache_get_value_name_int(row,       "locklevel" , HouseInfo[row][hLockLevel]);
        cache_get_value_name_int(row,       "moneysafe" , HouseInfo[row][hMoneySafe]);
        cache_get_value_name_int(row,       "radio"     , HouseInfo[row][hRadio]);
        cache_get_value_name_int(row,       "tv"            , HouseInfo[row][hTV]);
        cache_get_value_name_int(row,       "microwave" , HouseInfo[row][hMicrowave]);
        cache_get_value_name_int(row,       "storage_alarm", HouseInfo[row][hStorageAlarm]);
        cache_get_value_name_int(row,       "bank"          , HouseInfo[row][hTakings]);
        cache_get_value_name_int(row,       "fur_slots" , HouseInfo[row][hFurSlots]);

        HouseInfo[row][hFurLoaded] = false;
        LoadHouseExterior(row);
        CreateHouseEnter(row);
        Iter_Add(House, row);
    }
    printf("MySQL Report: Houses Loaded. [%d/%d]", Iter_Count(House), MAX_HOUSES);
    return 1;
}

static stock InsertHouseInDB(houseid, playerid) // Dodavanje nove kuce
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, 
            "INSERT INTO houses (level, value, adress, enterX, enterY, enterZ,\n\
                exitX, exitY, exitZ, ownerid, int) VALUES \n\
                ('%d', '%d', '%e', '%f', '%f', '%f', '%f', '%f', '%f', '0', '0', '%d')",
            HouseInfo[houseid][hLevel],
            HouseInfo[houseid][hValue],
            HouseInfo[houseid][hAdress],
            HouseInfo[houseid][hEnterX],
            HouseInfo[houseid][hEnterY],
            HouseInfo[houseid][hEnterZ],
            HouseInfo[houseid][hExitX],
            HouseInfo[houseid][hExitY],
            HouseInfo[houseid][hExitZ],
            HouseInfo[houseid][hInt]
       ), 
        "OnHouseInsertInDB", 
        "ii", 
        houseid, 
        playerid
   );
    return 1;
}

static CreateHouseEnter(houseid)
{
    if(IsValidDynamicCP(HouseInfo[houseid][hEnterCP]))
        DestroyDynamicCP(HouseInfo[houseid][hEnterCP]);
    
    if(IsValidDynamicArea(HouseInfo[houseid][hAreaID]))
        DestroyDynamicArea(HouseInfo[houseid][hAreaID]);

    if(HouseInfo[houseid][h3dViwo] > 0)
    {
        HouseInfo[houseid][hEnterCP] = CreateDynamicCP(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]-1.0, 2.0, HouseInfo[houseid][h3dViwo], 5, -1, 5.0);
        HouseInfo[houseid][hAreaID] = CreateDynamicCircle(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HOUSE_EXTERIOR_RADIUS, HouseInfo[houseid][h3dViwo], -1, -1);
    }
    else
    {
        HouseInfo[houseid][hEnterCP] = CreateDynamicCP(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]-1.0, 2.0, -1, -1, -1, 5.0);
        HouseInfo[houseid][hAreaID] = CreateDynamicCircle(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HOUSE_EXTERIOR_RADIUS, -1, -1, -1);
    }
    return 1;
}

static stock ShowHouseInfo(playerid, house)
{
    // TODO: maybe convert this to dialog
    va_SendClientMessage(playerid, COLOR_WHITE, "Vlasnik: %s", ConvertSQLIDToName(HouseInfo[house][hOwnerID]));
    va_SendClientMessage(playerid, COLOR_WHITE, "Sef: "COL_GREEN"%s", (HouseInfo[house][hSafe]) ? ("DA") : ("NE"));
    if(!HouseInfo[house][hAlarm])
    {
        SendClientMessage(playerid, COLOR_WHITE, "Alarm: "COL_RED"NE");
    }
    else
    {
        va_SendClientMessage(playerid, COLOR_WHITE, "Alarm Level: %d", HouseInfo[house][hAlarm]);
    }
    if(HouseInfo[house][hDoorLevel] == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Vrata: "COL_RED"Jako losa kvaliteta");
    }
    else
    {
        va_SendClientMessage(playerid, COLOR_WHITE, "Vrata Level: %d", HouseInfo[house][hDoorLevel]);
    }
    if(HouseInfo[house][hLockLevel] == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Brava: "COL_RED"Jako losa kvaliteta");
    }
    else
    {
        va_SendClientMessage(playerid, COLOR_WHITE, "Brava Level: %d", HouseInfo[house][hLockLevel]);
    }
}

static stock CreatePlayerClosedScene(playerid)
{
    Streamer_UpdateEx(playerid,     255.3966, -39.9467, 1002.5233);
    SetPlayerCameraPos(playerid,    255.3966, -39.9467, 1002.5233);
    SetPlayerCameraLookAt(playerid, 258.5737, -41.8325, 1002.0000);

    SetPlayerPos(playerid, 258.5737, -41.8325, 1002.0000);
    SetPlayerFacingAngle(playerid, -123.9000);
    SetPlayerVirtualWorld(playerid, playerid+100);
    SetPlayerInterior(playerid, 1000);
    TogglePlayerControllable(playerid, false);
    ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Legs", 4.1, 1, 0, 0, 0, 0, 1, 0);

    PlayerClosedTimer[playerid] = defer ClosedPlayerTimer(playerid);
    return 1;
}

static stock StopHouseAlarm(houseid)
{
    if(IsValidGangZone(HouseAlarmZone[houseid]))
    {
        GangZoneDestroy(HouseAlarmZone[houseid]);
        stop GlobalZoneT[houseid];
    }
    foreach(new i : Player)
    {
        if(IsACop(i) && IsASD(i))
        {
            if(IsValidDynamicMapIcon(GlobalMapIcon[i]))
                DestroyDynamicMapIcon(GlobalMapIcon[i]);
        }
    }
    HouseAlarmActive[houseid] = false;
}

stock PlayHouseAlarm(houseid)
{
    if(houseid == INVALID_HOUSE_ID) return 1;
    if(HouseAlarmActive[houseid]) return 1;

    new string[64];
    switch (HouseInfo[houseid][hAlarm])
    {
        case 1:
        { // Salje samo poruku onima oko kuce
            format(string, sizeof(string), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
            HouseProxDetector(houseid, 60.0, string, COLOR_PURPLE);
            PlaySoundForPlayersInRange(AlarmEffect[0], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);
        }
        case 2:
        { // Salje samo poruku onima oko kuce & SMS-a ownera (ako je online)
            /************ LEVEL 1 ************/
            format(string, sizeof(string), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
            HouseProxDetector(houseid, 60.0, string, COLOR_PURPLE);
            PlaySoundForPlayersInRange(AlarmEffect[1], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

            /************ LEVEL 2 ************/
            new ownerid = INVALID_PLAYER_ID;
            foreach (new i : Player)
            {
                if(houseid == PlayerKeys[i][pHouseKey])
                {
                    ownerid = i;
                    break;
                }
            }
            if(ownerid == INVALID_PLAYER_ID) return 1;
            if(!IsPlayerAlive(ownerid)) return 1;

            SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
        }
        case 3:
        { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD
            /************ LEVEL 1 ************/
            format(string, sizeof(string), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
            HouseProxDetector(houseid, 60.0, string, COLOR_PURPLE);
            PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

            /************ LEVEL 3 ************/
            SendPoliceMessage(COLOR_LIGHTBLUE, "*__________ EMERGENCY CALL (911) __________*");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
            format(string, sizeof(string), "Location: %s || Adress: %s",
                GetZoneFromXYZ(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
                HouseInfo[houseid][hAdress]
           );
            SendPoliceMessage(COLOR_LIGHTBLUE, string);
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* __________________________________________ *");

            /************ LEVEL 2 ************/
            new ownerid = INVALID_PLAYER_ID;
            foreach (new i : Player)
            {
                if(houseid == PlayerKeys[i][pHouseKey])
                {
                    ownerid = i;
                    break;
                }
            }
            if(ownerid == INVALID_PLAYER_ID) return 1;
            if(!IsPlayerAlive(ownerid)) return 1;

            SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
        }
        case 4:
        { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD & kreira mapicon za PD i vlasnika
            /************ LEVEL 1 ************/
            format(string, sizeof(string), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
            HouseProxDetector(houseid, 60.0, string, COLOR_PURPLE);
            PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

            /************ LEVEL 3 ************/
            SendPoliceMessage(COLOR_LIGHTBLUE, "*__________ EMERGENCY CALL (911) __________*");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
            format(string, sizeof(string), "Location: %s || Adress: %s",
                GetZoneFromXYZ(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
                HouseInfo[houseid][hAdress]
           );
            SendPoliceMessage(COLOR_LIGHTBLUE, string);
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* __________________________________________ *");

            /************ LEVEL 4 ************/
            new gang_zone = CreateGangZoneAroundPoint(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], ZONE_WIDTH, ZONE_HEIGHT);

            foreach (new i : Player)
            {
                if(IsACop(i) || PlayerKeys[i][pHouseKey] == houseid)
                {
                    GangZoneShowForPlayer(i, gang_zone, COLOR_YELLOW);
                    GangZoneFlashForPlayer(i, gang_zone, COLOR_RED);
                }
            }
            HouseAlarmZone[houseid] = gang_zone;
            GlobalZoneT[houseid] = defer DestroyGlobalZone(houseid);

            /************ LEVEL 2 ************/
            new ownerid = INVALID_PLAYER_ID;
            foreach (new i : Player)
            {
                if(houseid == PlayerKeys[i][pHouseKey])
                {
                    ownerid = i;
                    break;
                }
            }
            if(ownerid == INVALID_PLAYER_ID) return 1;
            if(!IsPlayerAlive(ownerid)) return 1;

            SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
        }
        case 5:
        { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD & gang zone oko kuce & kreira mapicon za PD i vlasnika
            /************ LEVEL 1 ************/
            format(string, sizeof(string), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
            HouseProxDetector(houseid, 60.0, string, COLOR_PURPLE);
            PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

            /************ LEVEL 3 ************/
            SendPoliceMessage(COLOR_LIGHTBLUE, "*____________ EMERGENCY CALL (911) ____________*");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
            format(string, sizeof(string), "Location: %s || Adress: %s",
                GetZoneFromXYZ(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
                HouseInfo[houseid][hAdress]
           );
            SendPoliceMessage(COLOR_LIGHTBLUE, string);
            SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
            SendPoliceMessage(COLOR_LIGHTBLUE, "* ______________________________________________ *");

            /************ LEVEL 4 ************/
            new gang_zone = CreateGangZoneAroundPoint(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], ZONE_WIDTH, ZONE_HEIGHT);

            foreach (new i : Player)
            {
                if(IsACop(i) || PlayerKeys[i][pHouseKey] == houseid)
                {
                    GangZoneShowForPlayer(i, gang_zone, COLOR_YELLOW);
                    GangZoneFlashForPlayer(i, gang_zone, COLOR_RED);
                }
            }
            HouseAlarmZone[houseid] = gang_zone;
            GlobalZoneT[houseid] = defer DestroyGlobalZone(houseid);

            /************ LEVEL 5 ************/
            foreach (new i : Player)
            {
                if(IsACop(i))
                {
                    GlobalMapIcon[i] = CreateDynamicMapIcon(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], 16, -1, -1, -1, i, 9000.0, MAPICON_GLOBAL);
                }
            }
            GlobalMapIconT[houseid] = defer DestroyGlobalMapIcon();

            /************ LEVEL 2 ************/
            new ownerid = INVALID_PLAYER_ID;
            foreach (new i : Player)
            {
                if(houseid == PlayerKeys[i][pHouseKey])
                {
                    ownerid = i;
                    break;
                }
            }
            if(ownerid == INVALID_PLAYER_ID) return 1;
            if(!IsPlayerAlive(ownerid)) return 1;

            SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
        }
    }
    HouseAlarmActive[houseid] = true;
    return 1;
}

stock ResetHouseInfo(houseid)
{
    HouseInfo[houseid][hSQLID]              = -1;
    HouseInfo[houseid][hEnterX]             = 0.0;
    HouseInfo[houseid][hEnterY]             = 0.0;
    HouseInfo[houseid][hEnterZ]             = 0.0;
    HouseInfo[houseid][hExitX]              = 0.0;
    HouseInfo[houseid][hExitY]              = 0.0;
    HouseInfo[houseid][hExitZ]              = 0.0;
    HouseInfo[houseid][hOwnerID]            = 0;
    strcpy(HouseInfo[houseid][hAdress], "None", 32);
    HouseInfo[houseid][hValue]              = 0;
    HouseInfo[houseid][hInt]                = 0;
    HouseInfo[houseid][hVirtualWorld]       = 0;
    HouseInfo[houseid][hLock]               = 0;
    HouseInfo[houseid][hRent]               = 0;
    HouseInfo[houseid][hRentabil]           = 0;
    HouseInfo[houseid][hTakings]            = 0;
    HouseInfo[houseid][hLevel]              = 0;
    HouseInfo[houseid][hFreeze ]           = 0;
    HouseInfo[houseid][h3dViwo]             = 0;
    HouseInfo[houseid][hSafeStatus]         = 0;
    HouseInfo[houseid][hSafePass]           = 0;
    HouseInfo[houseid][hSafe]               = 0;
    HouseInfo[houseid][hOrmar]              = 0;
    HouseInfo[houseid][hSkin1]              = 0;
    HouseInfo[houseid][hSkin2]              = 0;
    HouseInfo[houseid][hSkin3]              = 0;
    HouseInfo[houseid][hGroceries]          = 0;
    HouseInfo[houseid][hDoorLevel]          = 0;
    HouseInfo[houseid][hAlarm]              = 0;
    HouseInfo[houseid][hLockLevel]          = 0;
    
    if(IsValidDynamicCP(HouseInfo[houseid][hEnterCP]))
        DestroyDynamicCP(HouseInfo[houseid][hEnterCP]);

    if(IsValidDynamicArea(HouseInfo[houseid][hAreaID]))
        DestroyDynamicArea(HouseInfo[houseid][hAreaID]);

    if(HouseAlarmActive[houseid])
    {
        GangZoneDestroy(HouseAlarmZone[houseid]);
        stop GlobalZoneT[houseid];
        HouseAlarmActive[houseid] = false;
    }
    stop GlobalMapIconT[houseid];
    return 1;
}

static ResetHouseEnumerator()
{
    for (new i=0; i<MAX_HOUSES; i++)
        ResetHouseInfo(i);

    return 1;
}

static Area_GetHouseID(areaid)
{
    new houseid = INVALID_HOUSE_ID;
    foreach(new house: House)
    {
        if(HouseInfo[house][hAreaID] == areaid)
        {
            houseid = house;
            break;
        }
    }
    return houseid;
}

static CP_GetHouseID(checkpointid)
{
    new houseid = INVALID_HOUSE_ID;
    foreach(new house: House)
    {
        if(HouseInfo[house][hEnterCP] == checkpointid)
        {
            houseid = house;
            break;
        }
    }
    return houseid;
}

stock BuyHouse(playerid, bool:credit_activated = false)
{
    new house = Player_InfrontHouse(playerid);
    // TODO: bounds check
    PlayerKeys[playerid][pHouseKey] = house;
    PlayerInfo[playerid][pSpawnChange] = 1;
    HouseInfo[house][hOwnerID] = PlayerInfo[playerid][pSQLID];
    //BizzInfo[2][bTill] += HouseInfo[house][hValue];

    mysql_fquery(g_SQL, "UPDATE houses SET ownerid = '%d' WHERE id = '%d'",
        HouseInfo[house][hOwnerID],
        HouseInfo[house][hSQLID]
   );

    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
        PlayerInfo[playerid][pSpawnChange],
        PlayerInfo[playerid][pSQLID]
   );

    SendClientMessage(playerid, COLOR_RED, "[!] Spawn Vam je automatski prebacen na kupljenu kucu.");

    new price = HouseInfo[house][hValue];
    if(credit_activated)
    {
        price -= CreditInfo[playerid][cAmount];
    }
    PlayerToBudgetMoney(playerid, price); // Novac ide u proracun od kupnje kuce na /buy
    SetPlayerSpawnInfo(playerid);

    SetPlayerPos(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]);
    SetPlayerInterior(playerid, HouseInfo[house][hInt]);
    SetPlayerVirtualWorld(playerid, HouseInfo[house][hVirtualWorld]);
    Player_SetInHouse(playerid, house);
    PlayerInfo[playerid][pSpawnChange] = 1;

    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
        PlayerInfo[playerid][pSpawnChange],
        PlayerInfo[playerid][pSQLID]
   );

    SendClientMessage(playerid, COLOR_RED, "[!] Ukucajte /help da bi ste vidjeli sve komande vezane uz kucu !");
    return 1;
}

stock RemoveHouse(houseid) // TODO: make /ahouse create/delete/changeint/etc. cmd
{
    if(houseid == INVALID_HOUSE_ID) return 0;
    mysql_fquery(g_SQL, "DELETE FROM houses WHERE id = '%d'", HouseInfo[houseid][hSQLID]);
    ResetHouseInfo(houseid);
    Iter_Remove(House, houseid);
    return 1;
}

HouseProxDetector(houseid, Float:radius, const string[], color)
{
	foreach(new i : Player) 
	{
		if(IsPlayerInRangeOfPoint(i, radius, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]))
			SendClientMessage(i, color, string);
	}
	return 1;
}

/*
    d8888b. d888888b  .o88b. db   dD      db       .d88b.   .o88b. db   dD
    88  8D   88'   d8P  Y8 88 ,8P'      88      .8P  Y8. d8P  Y8 88 ,8P'
    88oodD'    88    8P      88,8P        88      88    88 8P      88,8P
    88~~~      88    8b      888b        88      88    88 8b      888b
    88        .88.   Y8b  d8 88 88.      88booo. 8b  d8' Y8b  d8 88 88.
    88      Y888888P  Y88P' YP   YD      Y88888P  Y88P'   Y88P' YP   YD
*/
static stock ResetLockPickVars(playerid)
{
    if(!PickingLock[playerid]) return 1;

    PickLockMaxValue[playerid][0] = 0.0;
    PickLockMaxValue[playerid][1] = 0.0;
    PickLockMaxValue[playerid][2] = 0.0;
    PickLockTimeC   [playerid]    = 0;

    stop PickLockTimer[playerid];
    stop PlayerPickLockTimer[playerid];
    DestroyPickLockTDs(playerid);

    PickingLock[playerid] = false;
    PickLockSlot[playerid] = 3;
    SkinSlot[playerid] = 0;

    DestroyPlayerProgressBar(playerid, PickLockBars[playerid][0]);
    DestroyPlayerProgressBar(playerid, PickLockBars[playerid][1]);
    DestroyPlayerProgressBar(playerid, PickLockBars[playerid][2]);
    return 1;
}

static stock DestroyPickLockTDs(playerid)
{
    if(PicklockBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, PicklockBcg[playerid]);
        PicklockBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(Picklock1Done[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, Picklock1Done[playerid]);
        Picklock1Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(Picklock2Done[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, Picklock2Done[playerid]);
        Picklock2Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(Picklock3Done[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, Picklock3Done[playerid]);
        Picklock3Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(PickLockTimeTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, PickLockTimeTitle[playerid]);
        PickLockTimeTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(PickLockTime[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, PickLockTime[playerid]);
        PickLockTime[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

static stock CreatePickLockTDs(playerid)
{
    DestroyPickLockTDs(playerid);

    PicklockBcg[playerid] = CreatePlayerTextDraw(playerid, 345.449951, 284.636169, "usebox");
    PlayerTextDrawLetterSize(playerid, PicklockBcg[playerid], 0.000000, 12.329438);
    PlayerTextDrawTextSize(playerid, PicklockBcg[playerid], 216.599868, 0.000000);
    PlayerTextDrawAlignment(playerid, PicklockBcg[playerid], 1);
    PlayerTextDrawColor(playerid, PicklockBcg[playerid], 0);
    PlayerTextDrawUseBox(playerid, PicklockBcg[playerid], true);
    PlayerTextDrawBoxColor(playerid, PicklockBcg[playerid], 102);
    PlayerTextDrawSetShadow(playerid, PicklockBcg[playerid], 0);
    PlayerTextDrawSetOutline(playerid, PicklockBcg[playerid], 0);
    PlayerTextDrawFont(playerid, PicklockBcg[playerid], 0);
    PlayerTextDrawShow(playerid, PicklockBcg[playerid]);

    Picklock1Done[playerid] = CreatePlayerTextDraw(playerid, 250.0, 288.0, "0");
    PlayerTextDrawLetterSize(playerid, Picklock1Done[playerid], 0.298350, 1.093199);
    PlayerTextDrawAlignment(playerid, Picklock1Done[playerid], 2);
    PlayerTextDrawColor(playerid, Picklock1Done[playerid], -1);
    PlayerTextDrawSetShadow(playerid, Picklock1Done[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Picklock1Done[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, Picklock1Done[playerid], 51);
    PlayerTextDrawFont(playerid, Picklock1Done[playerid], 2);
    PlayerTextDrawSetProportional(playerid, Picklock1Done[playerid], 1);
    PlayerTextDrawShow(playerid, Picklock1Done[playerid]);

    Picklock2Done[playerid] = CreatePlayerTextDraw(playerid, 279.0, 288.0, "0");
    PlayerTextDrawLetterSize(playerid, Picklock2Done[playerid], 0.328049, 1.136878);
    PlayerTextDrawAlignment(playerid, Picklock2Done[playerid], 2);
    PlayerTextDrawColor(playerid, Picklock2Done[playerid], -1);
    PlayerTextDrawSetShadow(playerid, Picklock2Done[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Picklock2Done[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, Picklock2Done[playerid], 51);
    PlayerTextDrawFont(playerid, Picklock2Done[playerid], 2);
    PlayerTextDrawSetProportional(playerid, Picklock2Done[playerid], 1);
    PlayerTextDrawShow(playerid, Picklock2Done[playerid]);

    Picklock3Done[playerid] = CreatePlayerTextDraw(playerid, 308.0, 288.0, "0");
    PlayerTextDrawLetterSize(playerid, Picklock3Done[playerid], 0.334199, 1.080320);
    PlayerTextDrawAlignment(playerid, Picklock3Done[playerid], 2);
    PlayerTextDrawColor(playerid, Picklock3Done[playerid], -1);
    PlayerTextDrawSetShadow(playerid, Picklock3Done[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Picklock3Done[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, Picklock3Done[playerid], 51);
    PlayerTextDrawFont(playerid, Picklock3Done[playerid], 2);
    PlayerTextDrawSetProportional(playerid, Picklock3Done[playerid], 1);
    PlayerTextDrawShow(playerid, Picklock3Done[playerid]);

    PickLockTimeTitle[playerid] = CreatePlayerTextDraw(playerid, 286.050079, 387.407745, "Vrijeme:");
    PlayerTextDrawLetterSize(playerid, PickLockTimeTitle[playerid], 0.285899, 0.762239);
    PlayerTextDrawAlignment(playerid, PickLockTimeTitle[playerid], 2);
    PlayerTextDrawColor(playerid, PickLockTimeTitle[playerid], -1);
    PlayerTextDrawSetShadow(playerid, PickLockTimeTitle[playerid], 0);
    PlayerTextDrawSetOutline(playerid, PickLockTimeTitle[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, PickLockTimeTitle[playerid], 51);
    PlayerTextDrawFont(playerid, PickLockTimeTitle[playerid], 2);
    PlayerTextDrawSetProportional(playerid, PickLockTimeTitle[playerid], 1);
    PlayerTextDrawShow(playerid, PickLockTimeTitle[playerid]);

    PickLockTime[playerid] = CreatePlayerTextDraw(playerid, 326.849822, 387.407745, "150");
    PlayerTextDrawLetterSize(playerid, PickLockTime[playerid], 0.285899, 0.762239);
    PlayerTextDrawAlignment(playerid, PickLockTime[playerid], 2);
    PlayerTextDrawColor(playerid, PickLockTime[playerid], -16776961);
    PlayerTextDrawSetShadow(playerid, PickLockTime[playerid], 0);
    PlayerTextDrawSetOutline(playerid, PickLockTime[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, PickLockTime[playerid], 51);
    PlayerTextDrawFont(playerid, PickLockTime[playerid], 2);
    PlayerTextDrawSetProportional(playerid, PickLockTime[playerid], 1);
    PlayerTextDrawShow(playerid, PickLockTime[playerid]);
}

static stock UpdatePickLockTD(playerid, slot, result)
{
    new string[8];
    if(slot == 0)
    {
        format(string, sizeof(string), "%d", result);
        PlayerTextDrawSetString(playerid, Picklock1Done[playerid], string);
    }
    else if(slot == 1)
    {
        format(string, sizeof(string), "%d", result);
        PlayerTextDrawSetString(playerid, Picklock2Done[playerid], string);
    }
    else if(slot == 2)
    {
        format(string, sizeof(string), "%d", result);
        PlayerTextDrawSetString(playerid, Picklock3Done[playerid], string);
    }
    return 1;
}

// TODO: bool
static stock IsDoorUnlocked(playerid)
{
    if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][0]) >= PickLockMaxValue[playerid][0] &&
        GetPlayerProgressBarValue(playerid, PickLockBars[playerid][1]) >= PickLockMaxValue[playerid][1] &&
        GetPlayerProgressBarValue(playerid, PickLockBars[playerid][2]) >= PickLockMaxValue[playerid][2])
    {
        return 1;
    }
    return 0;
}

Float:GetDistanceBetweenPoints3D(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
    return VectorSize(x1-x2,y1-y2,z1-z2);
}

static stock SetPlayerPickLock(playerid)
{
    TogglePlayerControllable(playerid, false);
    CreatePickLockTDs(playerid);

    new
        value,
        time,
        house = Player_InfrontHouse(playerid);

    switch (HouseInfo[house][hLockLevel])
    {
        case 2: { value = 40; time = 85; }
        case 3: { value = 60; time = 100; }
    }

    PickingLock[playerid] = true;
    PickLockSlot[playerid] = 0;

    PickLockMaxValue[playerid][0] = float(random(value)) + 1.5;
    PickLockMaxValue[playerid][1] = float(random(value)) + 1.0;
    PickLockMaxValue[playerid][2] = float(random(value)) + 1.5;

    PickLockTimeC[playerid] = time;
    PickLockTimer[playerid] = repeat PicklockTime(playerid , house);

    new string[10];
    valstr(string, time, false);
    PlayerTextDrawSetString(playerid, PickLockTime[playerid], string);

    PickLockBars[playerid][0] = CreatePlayerProgressBar(playerid, 257.0, 301.0, 10.0, 93.5, COLOR_GREEN, 100.0, BAR_DIRECTION_DOWN);
    ShowPlayerProgressBar(playerid, PickLockBars[playerid][0]);
    PickLockBars[playerid][1] = CreatePlayerProgressBar(playerid, 285.0, 301.0, 10.0, 93.5, 0xFF9933FF, 100.0, BAR_DIRECTION_DOWN);
    ShowPlayerProgressBar(playerid, PickLockBars[playerid][1]);
    PickLockBars[playerid][2] = CreatePlayerProgressBar(playerid, 314.0, 301.0, 10.0, 93.5, 0xFF9933FF, 100.0, BAR_DIRECTION_DOWN);
    ShowPlayerProgressBar(playerid, PickLockBars[playerid][2]);

    SetPlayerProgressBarValue(playerid, PickLockBars[playerid][0], 0.0);
    SetPlayerProgressBarValue(playerid, PickLockBars[playerid][1], 0.0);
    SetPlayerProgressBarValue(playerid, PickLockBars[playerid][2], 0.0);

    UpdatePickLockTD(playerid, 0, floatround(PickLockMaxValue[playerid][0]));
    UpdatePickLockTD(playerid, 1, floatround(PickLockMaxValue[playerid][1]));
    UpdatePickLockTD(playerid, 2, floatround(PickLockMaxValue[playerid][2]));

    PlayerPickLockTimer[playerid] = repeat PickLockTimerFunction(playerid);
    return 1;
}

/*
    d88888b  .d88b.   .d88b.  d888888b      d88888b d8b   db d888888b d88888b d8888b.
    88'     .8P  Y8. .8P  Y8. ~~88~~'      88'     888o  88 ~~88~~' 88'     88  8D
    88ooo   88    88 88    88    88         88ooooo 88V8o 88    88    88ooooo 88oobY'
    88~~~   88    88 88    88    88         88~~~~~ 88 V8o88    88    88~~~~~ 888b
    88      8b  d8' 8b  d8'    88         88.     88  V888    88    88.     88 88.
    YP       Y88P'   Y88P'     YP         Y88888P VP   V8P    YP    Y88888P 88   YD
*/
static stock ResetDoorKickingVars(playerid)
{
    DestroyFootEnterTDs(playerid);
    DestroyPlayerProgressBar(playerid, FootKickingBar[playerid]);
    RammingDoor[playerid] = DOOR_RAM_NONE;
}

static stock DestroyFootEnterTDs(playerid)
{
    if(FootKickingBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, FootKickingBcg1[playerid]);
        FootKickingBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }

    if(FootKickingBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, FootKickingBcg2[playerid]);
        FootKickingBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }

    if(FootKickingText[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, FootKickingText[playerid]);
        FootKickingText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

static stock CreateFootEnterTDs(playerid)
{
    DestroyFootEnterTDs(playerid);

    FootKickingBcg1[playerid] = CreatePlayerTextDraw(playerid, 418.950134, 301.324188, "usebox");
    PlayerTextDrawLetterSize(playerid, FootKickingBcg1[playerid], 0.000000, 6.586106);
    PlayerTextDrawTextSize(playerid, FootKickingBcg1[playerid], 226.600006, 0.000000);
    PlayerTextDrawAlignment(playerid, FootKickingBcg1[playerid], 1);
    PlayerTextDrawColor(playerid, FootKickingBcg1[playerid], 0);
    PlayerTextDrawUseBox(playerid, FootKickingBcg1[playerid], true);
    PlayerTextDrawBoxColor(playerid, FootKickingBcg1[playerid], 102);
    PlayerTextDrawSetShadow(playerid, FootKickingBcg1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, FootKickingBcg1[playerid], 0);
    PlayerTextDrawFont(playerid, FootKickingBcg1[playerid], 0);
    PlayerTextDrawShow(playerid, FootKickingBcg1[playerid]);

    FootKickingBcg2[playerid] = CreatePlayerTextDraw(playerid, 409.750000, 306.924011, "usebox");
    PlayerTextDrawLetterSize(playerid, FootKickingBcg2[playerid], 0.000000, 0.865557);
    PlayerTextDrawTextSize(playerid, FootKickingBcg2[playerid], 237.250015, 0.000000);
    PlayerTextDrawAlignment(playerid, FootKickingBcg2[playerid], 1);
    PlayerTextDrawColor(playerid, FootKickingBcg2[playerid], 0);
    PlayerTextDrawUseBox(playerid, FootKickingBcg2[playerid], true);
    PlayerTextDrawBoxColor(playerid, FootKickingBcg2[playerid], 102);
    PlayerTextDrawSetShadow(playerid, FootKickingBcg2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, FootKickingBcg2[playerid], 0);
    PlayerTextDrawFont(playerid, FootKickingBcg2[playerid], 0);
    PlayerTextDrawShow(playerid, FootKickingBcg2[playerid]);

    FootKickingText[playerid] = CreatePlayerTextDraw(playerid, 322.899993, 306.264190, "Provaljivanje vrata");
    PlayerTextDrawLetterSize(playerid, FootKickingText[playerid], 0.295199, 0.885999);
    PlayerTextDrawAlignment(playerid, FootKickingText[playerid], 2);
    PlayerTextDrawColor(playerid, FootKickingText[playerid], -1);
    PlayerTextDrawSetShadow(playerid, FootKickingText[playerid], 0);
    PlayerTextDrawSetOutline(playerid, FootKickingText[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, FootKickingText[playerid], 51);
    PlayerTextDrawFont(playerid, FootKickingText[playerid], 2);
    PlayerTextDrawSetProportional(playerid, FootKickingText[playerid], 1);
    PlayerTextDrawShow(playerid, FootKickingText[playerid]);
}

static stock SetPlayerFootEntering(playerid)
{
    CreateFootEnterTDs(playerid);
    FootKickingBar[playerid] = CreatePlayerProgressBar(playerid, 246.000000, 330.0, 158.0, 15.0, COLOR_GREEN, 100.0, BAR_DIRECTION_RIGHT);
    ShowPlayerProgressBar(playerid, FootKickingBar[playerid]);
    Player_SetRammingDoor(playerid, DOOR_RAM_FOOT);

    TogglePlayerControllable(playerid, false);
    ApplyAnimationEx(playerid, "POLICE", "Door_Kick", 3.1, 0, 1, 1, 1, 0, 1, 0);
    return 1;
}
/*
     .o88b. d8888b.  .d88b.  db   d8b   db d8888b.  .d8b.  d8888b.
    d8P  Y8 88  8D .8P  Y8. 88   I8I   88 88  8D d8' 8b 88  8D
    8P      88oobY' 88    88 88   I8I   88 88oooY' 88ooo88 88oobY'
    8b      888b   88    88 Y8   I8I   88 88~~~b. 88~~~88 888b
    Y8b  d8 88 88. 8b  d8' 8b d8'8b d8' 88   8D 88   88 88 88.
     Y88P' 88   YD  Y88P'   8b8' 8d8'  Y8888P' YP   YP 88   YD
*/

stock SetPlayerCrowbarBreaking(playerid)
{
    Player_SetRammingDoor(playerid, DOOR_RAM_CROWBAR);

    new
        house = Player_InfrontHouse(playerid),
        keyTime,
        wholeTime,
        result;

    switch (HouseInfo[house][hDoorLevel])
    {
        case 0..3: { keyTime = 1500; wholeTime = 125; result = 50; }
        case 4:    { keyTime = 1000; wholeTime = 145; result = 80; }
        case 5:    { keyTime = 800;  wholeTime = 170; result = 100; }
    }

    SetPlayerKeyInput(playerid, result, keyTime, wholeTime, 1);
    TogglePlayerControllable(playerid, false);
    return 1;
}

stock IsCrowbarBreaking(playerid)
{
    return Player_GetRammingDoor(playerid) == DOOR_RAM_CROWBAR;
}

stock CancelCrowbarBreaking(playerid)
{
    DisablePlayerKeyInput(playerid);
    TogglePlayerControllable(playerid, true);
    Player_SetRammingDoor(playerid, DOOR_RAM_NONE);
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

timer PickLockTimerFunction[800](playerid)
{
    if(!PickingLock[playerid])
        stop PlayerPickLockTimer[playerid];

    new slot = PickLockSlot[playerid];
    if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) < 0.0) return 1;
    if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot]) return 1;

    SetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot], GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) - 0.15);

    new result = floatround(PickLockMaxValue[playerid][slot] - GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]));
    UpdatePickLockTD(playerid, slot, result);
    return 1;
}

timer ClosedPlayerTimer[2000](playerid)
{
    ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINSURE, DIALOG_STYLE_MSGBOX, "ODABIR SKINA", "Zelite li obuci ovaj skin?", "Pick", "Abort");
    return 1;
}

timer PicklockTime[1000](playerid, houseid)
{
    new string[10];
    valstr(string, PickLockTimeC[playerid] - 1, false);
    PlayerTextDrawSetString(playerid, PickLockTime[playerid], string);

    if(--PickLockTimeC[playerid] == 0)
    {
        ResetLockPickVars(playerid);

        // Setting of HouseAlarmOff was never implemented
        /*
        if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
        {
            PlayHouseAlarm(houseid);
        }*/
        PlayHouseAlarm(houseid);
    }
}

timer DestroyGlobalZone[480000](houseid)
{
    foreach(new i : Player)
    {
        if(PlayerKeys[i][pHouseKey] == houseid || IsACop(i))
        {
            GangZoneDestroy(HouseAlarmZone[houseid]);
            HouseAlarmZone[houseid] = -1;
            break;
        }
    }
    return 1;
}

timer DestroyGlobalMapIcon[480000]()
{
    foreach(new i : Player)
    {
        if(IsValidDynamicMapIcon(GlobalMapIcon[i]))
            DestroyDynamicMapIcon(GlobalMapIcon[i]);
    }
    return 1;
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
    ResetHouseEnumerator();
    return 1;
}

hook function LoadServerData()
{
    LoadHouses();
	return continue();

}

hook function ResetPlayerVariables(playerid)
{
    ResetHouseVariables(playerid);
	return continue(playerid);
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    new house = CP_GetHouseID(checkpointid);
    if(!Iter_Contains(House, house))
        return 1;

    CreateHouseInfoTD(playerid);
    new string[128];
    if(HouseInfo[house][hOwnerID] != 0)
    {
        // TODO: see if it can be refactored
        if(HouseInfo[house][hRentabil])
        {
            format(string, sizeof(string), "ID: %d~n~Vlasnik: %s~n~Adresa: %s~n~Cijena: %d~g~$~n~~w~Rent: %d~g~$~n~~w~Level: %d",
                house,
                ConvertSQLIDToName(HouseInfo[house][hOwnerID]),
                HouseInfo[house][hAdress],
                HouseInfo[house][hValue],
                HouseInfo[house][hRent],
                HouseInfo[house][hLevel]
           );
        }
        else
        {
            format(string, sizeof(string), "ID: %d~n~Vlasnik: %s~n~Adresa: %s~n~Cijena: %d~g~$~n~~w~Level: %d",
                house,
                ConvertSQLIDToName(HouseInfo[house][hOwnerID]),
                HouseInfo[house][hAdress],
                HouseInfo[house][hValue],
                HouseInfo[house][hLevel]
           );
        }
    }
    else
    {
        format(string, sizeof(string), "ID: %d~n~Kuca je na prodaju~n~Cijena: %d~g~$~n~~w~Level: %d~n~Alarm: %d~n~Vrata: %d",
            house,
            HouseInfo[house][hValue],
            HouseInfo[house][hLevel],
            HouseInfo[house][hAlarm],
            HouseInfo[house][hDoorLevel]
       );
        PlayerTextDrawSetString(playerid, HouseCMDTD[playerid], "Raspolozive komande:~n~      /enter, /buyhouse");
    }

    PlayerTextDrawSetString(playerid, HouseInfoTD[playerid], string);
    Player_SetHouseCP(playerid, checkpointid);
    Player_SetInfrontHouse(playerid, house);
    return 1;
}

hook OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
    new 
        house = CP_GetHouseID(checkpointid);
    
    if(!Iter_Contains(House, house) || Player_GetHouseCP(playerid) != house)
        return 1;

    DestroyHouseInfoTD(playerid);
    Player_SetHouseCP(playerid, -1);
    Player_SetInfrontHouse(playerid, INVALID_HOUSE_ID);
    return 1;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
    new 
        house = Area_GetHouseID(areaid);
    if(!Iter_Contains(House, house))
        return 1;

    Player_SetHouseArea(playerid, house);
    return 1;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
    if(!Iter_Contains(House, Area_GetHouseID(areaid))) 
        return 1;

    Player_SetHouseArea(playerid, INVALID_HOUSE_ID);
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT))
    {
        if(Player_GetRammingDoor(playerid) == DOOR_RAM_FOOT)
        {
            if(GetPlayerAnimationIndex(playerid) == 1189) return 1;

            new
                house = Player_InfrontHouse(playerid),
                Float:tmpHealth;
            if(!Iter_Contains(House, house))
            {
                return 1;
            }

            ApplyAnimationEx(playerid, "POLICE", "Door_Kick", 3.1, 0, 1, 1, 1, 0, 1, 0);
            GetPlayerHealth(playerid, tmpHealth);

            new
                Float:healthDed     = 0.0,
                Float:progressBar   = 0.0;
            if(HouseInfo[house][hLockLevel] == 2)
            {
                healthDed   = 0.00000001;
                progressBar = 0.10;
            }
            else if(HouseInfo[house][hLockLevel] == 3)
            {
                healthDed   = 0.0000001;
                progressBar = 0.07;
            }

            SetPlayerHealth(playerid, tmpHealth - healthDed);
            SetPlayerProgressBarValue(playerid, FootKickingBar[playerid], GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) + progressBar);
            if(GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) >= 50.0)
            {
                // Setting of HouseAlarmOff was never implemented
                //if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
                PlayHouseAlarm(house);
            }
            if(GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) == 100.0)
            {
                HouseInfo[house][hLock] = 0;
                GameTextForPlayer(playerid, "~g~Vrata su otkljucana", 2500, 1);
                ResetDoorKickingVars(playerid);
                TogglePlayerControllable(playerid, true);
            }
            return 1;
        }
        if(PickingLock[playerid])
        {
            new
                slot = PickLockSlot[playerid],
                result = floatround(PickLockMaxValue[playerid][slot] - GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]));
            UpdatePickLockTD(playerid, slot, result);

            if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot])
            {
                SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], COLOR_RED);
                HidePlayerProgressBar(playerid, PickLockBars[playerid][slot]);
                ShowPlayerProgressBar(playerid, PickLockBars[playerid][slot]);

                if(IsDoorUnlocked(playerid))
                {
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste otkljucali vrata!");
                    // TODO: NO! Extract into variable, and do bounds checking on HouseInfo "index"
                    HouseInfo[Player_InfrontHouse(playerid)][hLock] = 0;
                    ResetLockPickVars(playerid);
                    TogglePlayerControllable(playerid, true);
                }
                return 1;
            }
            SetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot], GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) + 0.20);
        }
    }
    else if((newkeys & KEY_YES) && !(oldkeys & KEY_YES))
    {
        if(PickingLock[playerid])
        {
            new slot = PickLockSlot[playerid];

            slot++;
            if(slot > 2)
                slot = 0;

            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][0]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);
            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][1]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);
            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][2]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][0]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][0]);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][1]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][1]);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][2]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][2]);

            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : 0xFFFF22AA);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][slot]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][slot]);

            PickLockSlot[playerid] = slot;
        }
    }
    else if((newkeys & KEY_NO) && !(oldkeys & KEY_NO))
    {
        if(PickingLock[playerid])
        {
            new slot = PickLockSlot[playerid];

            slot--;
            if(slot < 0)
                slot = 2;

            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][0]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);
            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][1]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);
            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][2]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : COLOR_GREEN);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][0]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][0]);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][1]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][1]);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][2]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][2]);

            SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], (GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot]) ? COLOR_RED : 0xFFFF22AA);

            HidePlayerProgressBar(playerid, PickLockBars[playerid][slot]);
            ShowPlayerProgressBar(playerid, PickLockBars[playerid][slot]);
            PickLockSlot[playerid] = slot;
        }
    }
    return 1;
}

hook OnPlayerKeyInputEnds(playerid, type, succeeded)
{
    if(type == 1 && succeeded == 1)
    {
        new house = Player_InfrontHouse(playerid);
        // TODO: bounds checking
        HouseInfo[house][hLock] = 0;

        GameTextForPlayer(playerid, "~g~Vrata su otkljucana", 2500, 1);
        DisablePlayerKeyInput(playerid);
        TogglePlayerControllable(playerid, true);

        new rand = random(5);
        if(rand == 5 || rand == 2 || rand == 1)
        {
            // Setting of HouseAlarmOff was never implemented
            //if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
            PlayHouseAlarm(house);
        }
    }
    return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    new 
        houseid = Player_HouseArea(playerid);
    if(!Iter_Contains(House, houseid))
        return 1;
    if(!HouseInfo[houseid][hLock])
        return 1;
        
    if(GetDistanceBetweenPoints3D(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], fX, fY, fZ) <= 2.5)
    {
        if(AC_GetPlayerWeapon(playerid) != WEAPON_SHOTGUN && AC_GetPlayerWeapon(playerid) != WEAPON_SHOTGSPA)
            return 1;

        if(!IsACop(playerid))
            PlayHouseAlarm(houseid);

        new string[100];
        format(string, sizeof(string), "* Vrata su probijena sacmaricom. ((%s))", GetName(playerid, true));
        ProxDetector(50.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        HouseInfo[houseid][hLock] = false;

        foreach(new i: Player)
        {
            if(Player_InHouse(i) == houseid)
            {
                format(string, sizeof(string), "* Cuje se intenzivni zvuk pucnja sacmarice kod vratiju. ((%s))", GetName(playerid, true));
                ProxDetector(50.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                break;
            }
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_HOUSE_MAIN:
        {
            if(!response)
            {
                return 1;
            }

            new house = PlayerKeys[playerid][pHouseKey];
            if(house == INVALID_HOUSE_ID)
            {
                SendErrorMessage(playerid, "Niste vlasnik kuce!");
                return 1;
            }

            switch (listitem)
            {
                case 0: // Weapon
                {
                    if(PlayerInfo[playerid][pLevel] == 1)
                        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");

                    if(IsACop(playerid) || IsASD(playerid) ||IsFDMember(playerid))
                        return SendClientMessage(playerid, COLOR_RED, "Ne mozes koristiti house storage ako si policajac ili FD!");

                    if(HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID])
                        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo vlasnik kuce/najmoprimac moze uzimati/spremati oruzje!");

                    if(!IsPlayerInRangeOfPoint(playerid, 40.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                        return SendClientMessage(playerid, COLOR_RED, "[GRRESKA]: Nisi u svojoj kuci!");

                    ShowPlayerDialog(playerid, DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak\n{3C95C2}[6] - Sef za novac.","Pick","Exit");
                }
                case 1:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_UPGRADES,DIALOG_STYLE_LIST,"{3C95C2}** House Upgrades","Sef(500$)\nOrmar(500$)\nAlarm(1000$)\nVrata(1000$)\nBrava(800$)\nTelefon(500$)\nRadio(800$)\nKasa za novce(1550$)\nTV(1000$)\nMikrovalna(300$)\nStorage Alarm","Choose","Back");
                case 2:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_DOORS,DIALOG_STYLE_LIST,"Otvori/zatvori","Otvori kucu\nZatvori kucu","Choose","Back");
                case 3:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_RENT,DIALOG_STYLE_LIST,"MOGUCNOST NAJMA","Kuca ima najam\nKuca nema najam\nCijena najma","Choose","Back");
                case 4:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_RENTERS,DIALOG_STYLE_LIST,"IZBACI PODSTANARE","Izbaci jednog\nIzbaci sve","Choose","Back");
                case 5:
                {
                    if(!IsPlayerInRangeOfPoint(playerid, 25.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY],HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                    {
                        SendClientMessage(playerid, COLOR_RED, "Nisi u svojoj kuci!");
                        return 1;
                    }

                    if(HouseInfo[house][hOrmar])
                        ShowPlayerDialog(playerid, DIALOG_HOUSE_ORMAR,DIALOG_STYLE_LIST,"KUCA - ORMAR","Stavi trenutni skin u ormar\nUdji u ormar\nIzbaci skin iz ormara","Choose","Back");
                    else
                        SendClientMessage(playerid, COLOR_RED, "Nemas ormar u kuci!");
                }
                case 6:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_STUFF,DIALOG_STYLE_LIST,"KUCA - KUHINJA","Spremi namirnice u kucu\nOtvori hladnjak i uzmi nesto za jesti","Choose","Back");
                case 7:
                    ShowHouseInfo(playerid, house);
                case 8:
                    va_ShowPlayerDialog(playerid, DIALOG_HOUSE_SELL,DIALOG_STYLE_LIST,"ZELITE LI STVARNO PRODATI KUCU ZA %d$?","Ne\nDa","Choose","Back", (HouseInfo[house][hValue] / 2));
                case 9:
                    ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PLAYER, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "U prazni prostor ispod unesite ID igraca", "Sell", "Close");
            }
            return 1;
        }
        case DIALOG_SELL_HOUSE_PLAYER:
        {
            if(!response)
            {
                return 1;
            }

            new pID = strval(inputtext),
                houseid = PlayerKeys[playerid][pHouseKey];
            // TODO: use defines and don't use high numbers for invalid ID's (unless required), typically, use -1
            if(houseid == INVALID_HOUSE_ID)
                return 1;

            if(!IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti blizu vase kuce!");
            if(!IsPlayerConnected(pID) || !SafeSpawned[pID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije sigurno spawnan/online!");
            if(!ProxDetectorS(5.0, playerid, pID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
            if(PlayerKeys[pID][pHouseKey] != INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac vec ima kucu!");

            GlobalSellingPlayerID[playerid] = pID;
            ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce", "Input", "Close");
            return 1;
        }
        case DIALOG_SELL_HOUSE_PRICE:
        {
            if(!response)
            {
                return 1;
            }

            new
                housePrice = strval(inputtext),
                pID = GlobalSellingPlayerID[playerid];

            if(housePrice > 9999999 || housePrice < 1000) return ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce\nCijena kuce ne moze biti manja od 10000$, a veca od 9999999$", "Input", "Close");

            if(AC_GetPlayerMoney(pID) < housePrice) return ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce\nIgrac nema dovoljno novca za kupovinu vase kuce", "Input", "Close");

            GlobalSellingPrice[pID]    = housePrice;
            GlobalSellingPlayerID[pID] = playerid;
            va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste ponudili vasu kucu igracu %s za %d$", GetName(pID), housePrice);

            new string[85];
            format(string, sizeof(string), "Igrac %s vam je ponudio da kupite njegovu kucu za %d", GetName(playerid), housePrice);
            ShowPlayerDialog(pID, DIALOG_SELL_HOUSE_PLAYER_2, DIALOG_STYLE_MSGBOX, "PONUDA ZA KUPOVINU KUCE", string, "Buy", "Close");
            return 1;
        }
        case DIALOG_SELL_HOUSE_PLAYER_2:
        {
            if(!response)
            {
                return 1;
            }

            new pID = GlobalSellingPlayerID[playerid],
                housePrice = GlobalSellingPrice[playerid];

            if(AC_GetPlayerMoney(playerid) < housePrice) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupovinu ove kuce.");

            PlayerKeys[playerid][pHouseKey]     = PlayerKeys[pID][pHouseKey];
            PlayerKeys[pID][pHouseKey]          = INVALID_HOUSE_ID;
            PlayerInfo[playerid][pSpawnChange]  = 1;
            PlayerInfo[pID][pSpawnChange]       = 0;
            PlayerInfo[playerid][pExtraFurniture]   = 0;
            HouseInfo[PlayerKeys[playerid][pHouseKey]][hOwnerID] = PlayerInfo[playerid][pSQLID];

            mysql_fquery(g_SQL, "UPDATE houses SET ownerid = '%d' WHERE id = '%d'",
                HouseInfo[PlayerKeys[playerid][pHouseKey]][hOwnerID],
                HouseInfo[PlayerKeys[playerid][pHouseKey]][hSQLID]
           );

            // Spawn Change Seller & Buyer
            mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                PlayerInfo[pID][pSpawnChange],
                PlayerInfo[pID][pSQLID]
           );

            mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                PlayerInfo[playerid][pSpawnChange],
                PlayerInfo[playerid][pSQLID]
           );

            SetPlayerSpawnInfo(pID);
            SetPlayerSpawnInfo(playerid);

            PlayerToPlayerMoneyTAX(playerid, pID, housePrice, true, LOG_TYPE_HOUSESELL);

            va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste kupili kucu od %s za %d$", GetName(pID), housePrice);
            va_SendClientMessage(pID, COLOR_YELLOW, "Igrac %s je kupio od vas kucu za %d", "Ok", "", GetName(playerid), housePrice);

            GlobalSellingPrice[playerid]    = 0;
            GlobalSellingPlayerID[pID]      = INVALID_PLAYER_ID;

            #if defined MODULE_LOGS
            Log_Write("/logfiles/buy_house.txt", "(%s) %s(%s) bought a house on adress %s[SQLID:%d] from %s(%s) for %d$.",
                ReturnDate(),
                GetName(playerid, false),
                ReturnPlayerIP(playerid),
                HouseInfo[PlayerKeys[playerid][pHouseKey]][hAdress],
                HouseInfo[PlayerKeys[playerid][pHouseKey]][hSQLID],
                GetName(pID, false),
                ReturnPlayerIP(pID),
                housePrice
           );
            #endif
            return 1;
        }
        case DIALOG_HOUSE_SEF:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            switch (listitem)
            {
                case 0:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_BANK, DIALOG_STYLE_INPUT, "{3C95C2}[Safe - Deposit Money]", "\nIspod unesite kolicinu novca koju zelite ostaviti u vasu kucu.{3C95C2}[WARNING]: Maximalno mozete ostaviti 25.000$", "Deposit", "Close");
                case 1:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_WITHDRAW, DIALOG_STYLE_INPUT, "{3C95C2}[Safe - Withdraw Money]", "\nIspod unesite kolicinu novca koju zelite uzeti iz vase kuce.", "Take", "Close");
            }
            return 1;
        }
        case DIALOG_HOUSE_BANK:
        {
            new
                // TODO: rename "bouse" to something meaningful and do bounds checking
                bouse = PlayerKeys[playerid][pHouseKey],
                length = strval(inputtext);

            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            if(length < 1 || length > AC_GetPlayerMoney(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u ruci!");
            if(length > 25000) return SendClientMessage(playerid, COLOR_RED,"Mozes staviti maksimalno 25.000$!");
            if(!IsPlayerInRangeOfPoint(playerid, 100.0, HouseInfo[bouse][hExitX], HouseInfo[bouse][hExitY], HouseInfo[bouse][hExitZ])) return SendClientMessage(playerid, COLOR_RED, "Predaleko ste od kuce !");
            if((HouseInfo[bouse][hTakings] + length) >= 25000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalna kolicina novca je 25.000$!");

            PlayerToHouseMoney(playerid, bouse, length); // Novac ide u kucu od igraca

            va_SendClientMessage(playerid, COLOR_RED, "[!] Stavili ste $%d u vasu kucu, sada imate ukupno: $%d.",
                length,
                HouseInfo[bouse][hTakings]
           );

            #if defined MODULE_LOGS
            Log_Write("/logfiles/a_house_cash.txt", "(%s) %s(%s) put %d$ in house on adress %s[SQLID: %d].",
                ReturnDate(),
                GetName(playerid, false),
                ReturnPlayerIP(playerid),
                length,
                HouseInfo[bouse][hAdress],
                HouseInfo[bouse][hSQLID]
           );
            #endif
            return 1;
        }
        case DIALOG_HOUSE_WITHDRAW:
        {
            // TODO: rename, bounds check
            new bouse = PlayerKeys[playerid][pHouseKey],
                length = strval(inputtext);

            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_SEF,DIALOG_STYLE_LIST,"KUCNI SEF","Sakrij novac u kucu\nPodigni novac iz kuce","Choose","Back");
            if(length >  HouseInfo[bouse][hTakings] || length < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u kucnom fondu!");
            if(!IsPlayerInRangeOfPoint(playerid, 100.0, HouseInfo[bouse][hExitX], HouseInfo[bouse][hExitY], HouseInfo[bouse][hExitZ])) return SendClientMessage(playerid, COLOR_RED, "Predaleko ste od kuce !");
            HouseToPlayerMoney(playerid, bouse, length); // Novac iz kuce ide igracu

            va_SendClientMessage(playerid, COLOR_RED, "[!] Uzeli ste  $%d iz vase kuce, sada imate ukupno: $%d.",
                length,
                HouseInfo[bouse][hTakings]
           );

            #if defined MODULE_LOGS
            Log_Write("/logfiles/a_house_cash.txt", "(%s) %s(%s) took %d$ from house on adress %s[SQLID: %d].",
                ReturnDate(),
                GetName(playerid, false),
                ReturnPlayerIP(playerid),
                length,
                HouseInfo[bouse][hAdress],
                HouseInfo[bouse][hSQLID]
           );
            #endif
            return 1;
        }
        case DIALOG_HOUSE_SAFE:
        {
            new house = PlayerKeys[playerid][pHouseKey];
            // TODO: bounds check
            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_SEF,DIALOG_STYLE_LIST,"KUCNI SEF","Sakrij novac u kucu\nPodigni novac iz kuce","Choose","Back");
            if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema sef!");

            switch (listitem)
            {
                case 0://Otkljucaj sef-izbacuje dialog da upises sifru
                {
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_UNLOCK, DIALOG_STYLE_INPUT, "KUCNI SEF", "Upisi trenutnu sifru da otkljucas sef!", "Next", "Back");
                }
                case 1://Zakljucaj sef-ne treba sifra
                {
                    ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
                    HouseInfo[house][hSafeStatus] = 0;
                    GameTextForPlayer(playerid, "~g~Sef zakljucan", 1000, 1);
                }
                case 2://info, odmah izbacuje sta ima unutra
                {
                    if(!HouseInfo[house][hSafeStatus]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate prvo otkljucati sef da bi ste mogli viditi njegov sadrzaj.");

                    SendClientMessage(playerid, COLOR_RED, "[!]___________________ {FA5656}KUCNI SEF ___________________|");
                    va_SendClientMessage(playerid, COLOR_WHITE, "U sefu je pohranjeno %s.", FormatNumber(HouseInfo[house][hMoneySafe]));
                }
                case 3://izbacuje dialog da upises novu sifru!
                {
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_CHANGEPASS, DIALOG_STYLE_INPUT, "NOVA SIFRA SEFA", "Upisi novu sifru!", "Next", "Back");
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_CHANGEPASS:
        {
            new
                house = PlayerKeys[playerid][pHouseKey],
                pass = strval(inputtext);

            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_SAFE,DIALOG_STYLE_LIST,"KUCNI SEF","Otkljucaj\nZakljucaj\nInfo\nPromjeni sifru","Choose","Back");
            if(house == INVALID_HOUSE_ID || HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo vlasnik moze mijenjati sifru sefa!");
            if(!IsPlayerInRangeOfPoint(playerid, 20.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Predaleko ste od kuce!");
            if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sef!");
            if(pass > 999999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sifra mora biti u brojevima i moze se sastojati najvise od 6 znamenki!");
            if(!IsNumeric(inputtext)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate korisitit samo brojeve!");

            HouseInfo[house][hSafePass] = pass;

            mysql_fquery(g_SQL, "UPDATE houses SET safepass = '%d' WHERE id = '%d'", 
                HouseInfo[house][hSafePass], 
                HouseInfo[house][hSQLID]
           );

            ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant",4.1, 0, 0, 0, 0, 0, 1, 0);
            GameTextForPlayer(playerid, "~g~Sifra je promjenjena", 1000, 1);
            va_SendClientMessage(playerid, COLOR_RED, "[!] Nova sifra: %d", HouseInfo[house][hSafePass]);
            return 1;
        }
        case DIALOG_HOUSE_UNLOCK:
        {
            new
                house = PlayerKeys[playerid][pHouseKey],
                pass = strval(inputtext);

            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_SAFE,DIALOG_STYLE_LIST,"KUCNI SEF","Otkljucaj\nZakljucaj\nInfo\nPromjeni sifru","Choose","Back");
            if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kucu!");
            if(!IsPlayerInRangeOfPoint(playerid, 20.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Predaleko ste od kuce !");
            if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete sef!");
            if(HouseInfo[house][hSafeStatus]) return SendClientMessage(playerid, COLOR_RED, "[!] Sef je vec otvoren!");
            if(pass != HouseInfo[house][hSafePass]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sifra je pogresna!");

            ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1, 0);
            HouseInfo[house][hSafeStatus] = 1;
            SendClientMessage(playerid, COLOR_RED, "[!] Sifra potvrdjena. Sef je otvoren!");
            return 1;
        }
        case DIALOG_HOUSE_UPGRADES:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            new
                house = PlayerKeys[playerid][pHouseKey];

            if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kucu!");

            switch (listitem)
            {
                case 0:
                { // Sef
                    if(HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca vec ima kupljen sef!");
                    if(AC_GetPlayerMoney(playerid) < 500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca.");

                    HouseInfo[house][hSafe] = 1;
                    PlayerToBudgetMoney(playerid, 500); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    SendClientMessage(playerid, COLOR_RED, "[!] Vasa kuca sada ima sef u koji mozete sakriti sirovine, drogu i oruzje.");
                    
                    mysql_fquery(g_SQL, "UPDATE houses SET safe = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hSafe], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 1:
                { // Ormar
                    if(HouseInfo[house][hOrmar]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca vec ima kupljen ormar!");
                    if(AC_GetPlayerMoney(playerid) < 500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to.");

                    HouseInfo[house][hOrmar] = 1;
                    PlayerToBudgetMoney(playerid, 500); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    SendClientMessage(playerid, COLOR_RED, "[!] Sada mozete koristiti ormar.");
                   
                    mysql_fquery(g_SQL, "UPDATE houses SET ormar = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hOrmar], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 2:
                { // Alarm
                    if(HouseInfo[house][hAlarm] == 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level alarma!");
                    if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to.(1000$)");

                    HouseInfo[house][hAlarm]++;
                    PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Alarm level ++", 1000, 1);
                    
                    mysql_fquery(g_SQL, "UPDATE houses SET alarm = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hAlarm], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 3:
                { // Vrata
                    if(HouseInfo[house][hDoorLevel] == 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level vrata! ");
                    if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (1000$).");

                    HouseInfo[house][hDoorLevel] ++;
                    PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Door level ++", 1000, 1);

                    mysql_fquery(g_SQL, "UPDATE houses SET doorlevel = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hDoorLevel], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 4:
                { // Brava
                    if(HouseInfo[house][hLockLevel] == 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level brave!");
                    if(AC_GetPlayerMoney(playerid) < 800) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (800$).");

                    HouseInfo[house][hLockLevel] ++;
                    PlayerToBudgetMoney(playerid, 800); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Lock level ++", 1000, 1);

                    mysql_fquery(g_SQL, "UPDATE houses SET locklevel = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hLockLevel], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 5:
                { // Telefon
                    // TODO: finish implementation or remove it
                    SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno nedostupno!");
                }
                case 6:
                { // Radio
                    if(HouseInfo[house][hRadio]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete radio!");
                    if(AC_GetPlayerMoney(playerid) < 800) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (500$).");

                    HouseInfo[house][hRadio] = 1;
                    PlayerToBudgetMoney(playerid, 800); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Kupljen novi radio", 1000, 1);
                   
                    mysql_fquery(g_SQL, "UPDATE houses SET radio = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hRadio], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 7:
                { // Kasa za novac
                    if(HouseInfo[house][hMoneySafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete kasu za novce!");
                    if(AC_GetPlayerMoney(playerid) < 1550) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (1550$).");

                    HouseInfo[house][hMoneySafe] = 1;
                    PlayerToBudgetMoney(playerid, 1550); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Kupljena nova kasa za novac", 1000, 1);
                    mysql_fquery(g_SQL, "UPDATE houses SET moneysafe = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hMoneySafe], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 8:
                { // TV
                    if(HouseInfo[house][hTV]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete televiziju!");
                    if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (500$).");

                    HouseInfo[house][hTV] = 1;
                    PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Kupljen novi tv", 1000, 1);
                    BizzInfo[85][bTill] += 500;

                    mysql_fquery(g_SQL, "UPDATE houses SET tv = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hTV], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 9:
                { // Mikrovalna
                    if(HouseInfo[house][hMicrowave]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete mikrovalnu!");
                    if(AC_GetPlayerMoney(playerid) < 300) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (300$).");

                    HouseInfo[house][hMicrowave] = 1;
                    PlayerToBudgetMoney(playerid, 300); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    GameTextForPlayer(playerid, "~g~Kupljen nova mikrovalna", 1000, 1);
                    
                    mysql_fquery(g_SQL, "UPDATE houses SET microwave = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hMicrowave], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 10:
                { // Storage Alarm -> storage_alarm
                    if(HouseInfo[house][hStorageAlarm] == 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete Storage Alarm u najboljoj verziji(level 3)!");
                    if(AC_GetPlayerMoney(playerid) < 7000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (7000$).");

                    if(HouseInfo[house][hStorageAlarm] == 2)
                        HouseInfo[house][hStorageAlarm] = 3;

                    if(HouseInfo[house][hStorageAlarm] == 1)
                        HouseInfo[house][hStorageAlarm] = 2;

                    if(HouseInfo[house][hStorageAlarm] == 0)
                        HouseInfo[house][hStorageAlarm] = 1;

                    PlayerToBudgetMoney(playerid, 7000); // Novac ide u proracun
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    va_SendClientMessage(playerid, COLOR_RED, "[STORAGE ALARM]: Uspjesno ste kupili storage-alarm level %d, da ga unapredite kupite ponovo.", HouseInfo[house][hStorageAlarm]);

                    mysql_fquery(g_SQL, "UPDATE houses SET storage_alarm = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hStorageAlarm], 
                        HouseInfo[house][hSQLID]
                   );
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_DOORS:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            switch (listitem)
            {
                case 0:
                { // Otkljucaj
                    new
                        house = Player_InHouse(playerid);
                    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred ulaznih vrata!");
                    if(PlayerKeys[playerid][pHouseKey] != house) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");

                    if(IsPlayerInRangeOfPoint(playerid, 8.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
                    {
                        HouseInfo[house][hLock] = 0;
                        GameTextForPlayer(playerid, "~w~Vrata ~g~otkljucana", 5000, 6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                    {
                        HouseInfo[house][hLock] = 0;
                        GameTextForPlayer(playerid, "~w~Vrata ~g~otkljucana", 5000, 6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                    }
                }
                case 1:
                { // Zakljucaj
                    new
                        house = Player_InHouse(playerid);
                    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred ulaznih vrata!");
                    if(PlayerKeys[playerid][pHouseKey] != house) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");
                    if(IsPlayerInRangeOfPoint(playerid, 8.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
                    {
                        HouseInfo[house][hLock] = 1;
                        GameTextForPlayer(playerid, "~w~Vrata ~r~zakljucana", 5000, 6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                    {
                        HouseInfo[house][hLock] = 1;
                        GameTextForPlayer(playerid, "~w~Vrata ~r~zakljucana", 5000, 6);
                        PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                    }
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_RENT:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            new
                house = PlayerKeys[playerid][pHouseKey];
            if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kucu!");

            switch (listitem)
            {
                case 0:
                { // Mogu iznajmljivati
                    HouseInfo[house][hRentabil] = 1;
                    mysql_fquery(g_SQL, "UPDATE houses SET rentabil = '1' WHERE id = '%d'", HouseInfo[house][hSQLID]);
                    GameTextForPlayer(playerid, "~g~Kuca stavljena na iznajmljivanje", 1000, 1);
                }
                case 1:
                { // Nece moci iznajmljivati
                    HouseInfo[house][hRentabil] = 0;
                    mysql_fquery(g_SQL, "UPDATE houses SET rentabil = '0' WHERE id = '%d'", HouseInfo[house][hSQLID]);
                    GameTextForPlayer(playerid, "~r~Kuca maknuta sa iznajmljivanja", 1000, 1);
                }
                case 2: ShowPlayerDialog(playerid, DIALOG_HOUSE_RENTPRICE, DIALOG_STYLE_INPUT, "NAJAM", "Upisi novu cijenu najma!", "Next", "Back");
            }
            return 1;
        }
        case DIALOG_HOUSE_RENTPRICE:
        {
            if(!response)
            {
                ShowPlayerDialog(
                    playerid,
                    DIALOG_HOUSE_RENT,
                    DIALOG_STYLE_LIST,
                    "MOGUCNOST NAJMA",
                    "Kuca ima najam\nKuca nema najam\nCijena najma",
                    "Choose",
                    "Back"
               );
                return 1;
            }

            new
                renting = strval(inputtext),
                house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds checking
            if(renting < 50 || renting > 500)
            {
                SendClientMessage(playerid, COLOR_RED, "Minimalna cijena renta je $50, a maksimalna $500.");
                return 1;
            }

            HouseInfo[house][hRent] = renting;

            mysql_fquery(g_SQL, "UPDATE houses SET rent = '%d' WHERE id = '%d'", 
                HouseInfo[house][hRent], 
                HouseInfo[house][hSQLID]
           );

            va_SendClientMessage(playerid, COLOR_RED, "[!] Stanarina postavljena na $%d", HouseInfo[house][hRent]);
            return 1;
        }
        case DIALOG_HOUSE_RENTERS:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            switch (listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_EVICT, DIALOG_STYLE_INPUT, "KUCA - PODSTANARI", "Upisi ID podstanara kojeg zelis izbacit na ulicu!", "Next", "Back");
                }
                case 1:
                {
                    foreach(new i : Player)
                    {
                        if(PlayerKeys[i][pRentKey] == PlayerKeys[playerid][pHouseKey])
                        {
                            SendClientMessage(i, COLOR_RED, "[!] Izbaceni ste iz kuce od strane vlasnika!");
                            PlayerKeys[i][pRentKey] = INVALID_HOUSE_ID;
                        }
                    }
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Izbacili ste sve podstanare iz kuce ((Koji su trenutno online))!");
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_EVICT:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_RENTERS, DIALOG_STYLE_LIST, "IZBACI PODSTANARE", "Izbaci jednog\nIzbaci sve", "Choose", "Back");

            new giveplayerid = strval(inputtext);
            if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izbaciti samog sebe.");
            if(!IsPlayerConnected(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
            if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos id-a!");
            if(PlayerKeys[giveplayerid][pRentKey] == PlayerKeys[playerid][pHouseKey])
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac ne stanuje kod tebe!");
                return 1;
            }

            SendClientMessage(giveplayerid, COLOR_RED, "[!] Izbacen si iz kuce od strane vlasnika!");
            SendClientMessage(playerid, COLOR_RED, "[!] Stanar je uspjesno izbacen na ulicu!");
            PlayerKeys[giveplayerid][pRentKey] = INVALID_HOUSE_ID;
            return 1;
        }
        case DIALOG_HOUSE_STUFF:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            new
                house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds checking
            switch (listitem)
            {
                case 0:
                { // Spremi
                    if(Player_GetGroceriesQuantity(playerid) == 0)
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kupili namirnice u 24/7!");
                        return 1;
                    }
                    if(HouseInfo[house][hGroceries] > 100)
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Frizider vam je pun!");
                        return 1;
                    }

                    HouseInfo[house][hGroceries] += Player_GetGroceriesQuantity(playerid);
                    GameTextForPlayer(playerid, "~g~Namirnice su pospremljene", 1000, 1);
                    Player_SetGroceriesQuantity(playerid, 0);
                }
                case 1: // Jelo
                {
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_FRIDGE, DIALOG_STYLE_LIST, "Odaberi sto zelis uzeti iz frizidera!","Pivo\nSprunk\nVino\nCips","Choose","Back");
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_FRIDGE:
        {
            if(!response)
            {
                ShowPlayerDialog(
                    playerid,
                    DIALOG_HOUSE_STUFF,
                    DIALOG_STYLE_LIST,
                    "KUCA - KUHINJA",
                    "Spremi namirnice u kucu\nOtvori hladnjak i uzmi nesto za jesti",
                    "Choose",
                    "Back"
               );
                return 1;
            }
            new
                house       = PlayerKeys[playerid][pHouseKey],
                drunklevel  = GetPlayerDrunkLevel(playerid),
                Float:health,
                string[70];

            // TODO: house bounds checking
            GetPlayerHealth(playerid, health);
            if(HouseInfo[house][hGroceries] < 1)
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno namirnica u frizideru!");
                return 1;
            }
            switch (listitem)
            {
                case 0:
                {
                    HouseInfo[house][hGroceries]--;
                    format(string, sizeof(string), "* %s uzima Twist Off iz hladnjaka i otvara ga.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    format(string, sizeof(string), "* %s naginje flasu te pocinje piti.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

                    if(PlayerHealth[playerid][pHunger] < 4.8)
                    {
                        PlayerHealth[playerid][pHunger] += 0.2;
                        SetPlayerDrunkLevel(playerid, drunklevel + 100);

                        if(drunklevel > 2000)
                            GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
                    }
                    else
                    {
                        PlayerHealth[playerid][pHunger] = 5.0;
                        SetPlayerDrunkLevel(playerid, drunklevel + 100);

                        if(drunklevel > 2000)
                            GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
                    }
                }
                case 1:
                {
                    HouseInfo[house][hGroceries]--;
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
                    format(string, sizeof(string), "* %s uzima Sprunk iz hladnjaka i otvara ga.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    format(string, sizeof(string), "* %s naginje tetrapak te pocinje piti.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;
                }
                case 2:
                {
                    HouseInfo[house][hGroceries]--;
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

                    format(string, sizeof(string), "* %s uzima crno vino iz hladnjaka i otvara ga.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    format(string, sizeof(string), "* %s naginje flasu te pocinje piti.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(PlayerHealth[playerid][pHunger] < 4.8)
                    {
                        PlayerHealth[playerid][pHunger] += 0.2;
                        SetPlayerDrunkLevel(playerid, drunklevel + 200);

                        if(drunklevel > 2000)
                            GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
                    }
                    else
                    {
                        PlayerHealth[playerid][pHunger] = 5.0;
                        SetPlayerDrunkLevel(playerid, drunklevel + 200);

                        if(drunklevel > 2000)
                            GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
                    }
                }
                case 3:
                {
                    HouseInfo[house][hGroceries] -= 1;
                    format(string, sizeof(string), "* %s uzima cips te pocinje jesti.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0, 1, 0);

                    if(PlayerHealth[playerid][pHunger] < 4.6)
                        PlayerHealth[playerid][pHunger] += 0.4;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_SELL:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            switch (listitem)
            {
                case 0: return 1;
                case 1:
                {
                    new
                        house   = PlayerKeys[playerid][pHouseKey];
                    // house bounds checking
                    new
                        sellprice = HouseInfo[house][hValue] / 2;

                    HouseInfo[house][hLock]     = 1;
                    HouseInfo[house][hSafe]     = 0;
                    HouseInfo[house][hOrmar]    = 0;
                    HouseInfo[house][hOwnerID]  = 0;

                    mysql_fquery(g_SQL,
                        "UPDATE houses SET ownerid = '%d', safe = '%d', ormar = '%d' WHERE id = '%d'",
                        HouseInfo[house][hOwnerID],
                        HouseInfo[house][hSafe],
                        HouseInfo[house][hOrmar],
                        HouseInfo[house][hSQLID]
                   );

                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    va_SendClientMessage(playerid, COLOR_RED, "[!] Prodali ste svoju kucu drzavi. Dobili ste %d$ iz sefa i %d$ od drzave!", HouseInfo[house][hTakings], sellprice);

                    BudgetToPlayerMoney(playerid, sellprice); // Igrac dobiva pola vrijednosti kuce od drzave
                    HouseToPlayerMoney(playerid, house, HouseInfo[house][hTakings]); // Dobiva sav novac iz house takingsa

                    PlayerKeys[playerid][pHouseKey] = INVALID_HOUSE_ID;
                    PlayerInfo[playerid][pExtraFurniture] = 0;

                    PlayerInfo[playerid][pSpawnChange] = 0;
                    mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                        PlayerInfo[playerid][pSpawnChange],
                        PlayerInfo[playerid][pSQLID]
                   );
                    SetPlayerSpawnInfo(playerid);

                    if(GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                        SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]);
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_ORMAR:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

            new
                house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds checking
            switch (listitem)
            {
                case 0:
                { // Stavi skin
                    if(HouseInfo[house][hSkin1] != 0 && HouseInfo[house][hSkin2] != 0 && HouseInfo[house][hSkin3] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je pun!");

                    if(HouseInfo[house][hSkin1] == 0)
                    {
                        HouseInfo[house][hSkin1] = GetPlayerSkin(playerid);
                        SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste spremili skin u Slot 1!");

                        mysql_fquery(g_SQL, "UPDATE houses SET skin1 = '%d' WHERE id = '%d'", 
                            HouseInfo[house][hSkin1], 
                            HouseInfo[house][hSQLID]
                       );
                    }
                    else if(HouseInfo[house][hSkin2] == 0)
                    {
                        HouseInfo[house][hSkin2] = GetPlayerSkin(playerid);
                        SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste spremili skin u slot 2!");
                        
                        mysql_fquery(g_SQL, "UPDATE houses SET skin2 = '%d' WHERE id = '%d'", 
                            HouseInfo[house][hSkin2], 
                            HouseInfo[house][hSQLID]
                       );
                    }
                    else if(HouseInfo[house][hSkin3] == 0)
                    {
                        HouseInfo[house][hSkin3] = GetPlayerSkin(playerid);
                        SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste spremili skin u slot 3!");

                        mysql_fquery(g_SQL, "UPDATE houses SET skin3 = '%d' WHERE id = '%d'", 
                            HouseInfo[house][hSkin3], 
                            HouseInfo[house][hSQLID]
                       );
                    }
                }
                case 1:
                { // Udi u ormar
                    if(!HouseInfo[house][hSkin1] && !HouseInfo[house][hSkin2] && !HouseInfo[house][hSkin3]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je prazan!");

                    GetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
                    tmpInterior[playerid] = GetPlayerInterior(playerid);
                    tmpViwo[playerid]     = GetPlayerVirtualWorld(playerid);

                    new string[128];
                    if(HouseInfo[house][hSkin1] != 0)
                    {
                        // TODO: shouldn't this just be strcat, why are you appending to string if string is initially null
                        format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin1]);
                    }
                    if(HouseInfo[house][hSkin2] != 0)
                    {
                        // TODO: just use strcat
                        format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin2]);
                    }
                    if(HouseInfo[house][hSkin3] != 0)
                    {
                        format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin3]);
                    }
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINCHOOSE, DIALOG_STYLE_LIST, "ORMAR - ODABIR", string, "Choose", "Abort");
                }
                case 2:
                { // Izbaci
                    if(!HouseInfo[house][hSkin1] && !HouseInfo[house][hSkin2] && !HouseInfo[house][hSkin3]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je prazan!");

                    ShowPlayerDialog(
                        playerid,
                        DIALOG_HOUSE_REMOVESKIN,
                        DIALOG_STYLE_LIST,
                        "KUCA-IZBACIVANJE SKINA",
                        "Slot 1\nSlot 2\nSlot 3", "Choose", "Abort"
                   );
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_REMOVESKIN:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid,
                    DIALOG_HOUSE_ORMAR,
                    DIALOG_STYLE_LIST,
                    "KUCA - ORMAR",
                    "Stavi trenutni skin u ormar\nUdji u ormar\nIzbaci skin iz ormara",
                    "Choose",
                    "Back"
               );
                return 1;
            }

            new house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds checking
            switch (listitem)
            {
                case 0:
                {
                    if(!HouseInfo[house][hSkin1])
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 1 je prazan!");
                        return 1;
                    }
                    HouseInfo[house][hSkin1] = 0;
                    SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali skin iz slota 1!");

                    mysql_fquery(g_SQL, "UPDATE houses SET skin1 = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hSkin1], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 1:
                {
                    if(!HouseInfo[house][hSkin2])
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 2 je prazan!");
                        return 1;
                    }
                    HouseInfo[house][hSkin2] = 0;
                    SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali skin iz slota 2!");

                    mysql_fquery(g_SQL, "UPDATE houses SET skin2 = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hSkin2], 
                        HouseInfo[house][hSQLID]
                   );
                }
                case 2:
                {
                    if(!HouseInfo[house][hSkin3])
                    {
                        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 3 je prazan!");
                        return 1;
                    }
                    HouseInfo[house][hSkin3] = 0;
                    SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali skin iz slota 3!");

                    mysql_fquery(g_SQL, "UPDATE houses SET skin3 = '%d' WHERE id = '%d'", 
                        HouseInfo[house][hSkin3], 
                        HouseInfo[house][hSQLID]
                   );
                }
            }
            return 1;
        }
        case DIALOG_HOUSE_SKINSURE:
        {
            new
                string[128],
                house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds checking
            if(!response)
            {
                if(HouseInfo[house][hSkin1] != 0)
                {
                    // TODO: shouldn't this just be strcat, why are you appending to string if string is initially null
                    format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin1]);
                }
                if(HouseInfo[house][hSkin2] != 0)
                {
                    // TODO: just use strcat
                    format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin2]);
                }
                if(HouseInfo[house][hSkin3] != 0)
                {
                    format(string, sizeof(string), "%s%d\n", string, HouseInfo[house][hSkin3]);
                }
                ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINCHOOSE, DIALOG_STYLE_LIST, "ORMAR - ODABIR", string, "Choose", "Abort");
                return 1;
            }

            new skin;
            switch (SkinSlot[playerid])
            {
                case 1: skin = HouseInfo[house][hSkin1];
                case 2: skin = HouseInfo[house][hSkin2];
                case 3: skin = HouseInfo[house][hSkin3];
            }

            PlayerAppearance[playerid][pTmpSkin] = skin;
            SetPlayerSkin(playerid, skin);
            SetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
            SetPlayerInterior(playerid, tmpInterior[playerid]);
            SetPlayerVirtualWorld(playerid, tmpViwo[playerid]);
            SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, true);
            ClearAnimations(playerid);

            SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste se presvukli!");
            format(string, sizeof(string), "* %s se presvlaci.", GetName(playerid, true));
            ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            return 1;
        }
        case DIALOG_HOUSE_SKINCHOOSE:
        {
            if(!response)
            {
                SetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
                SetPlayerInterior(playerid, tmpInterior[playerid]);
                SetPlayerVirtualWorld(playerid, tmpViwo[playerid]);
                SetCameraBehindPlayer(playerid);
                TogglePlayerControllable(playerid, true);
                ClearAnimations(playerid);

                SendClientMessage(playerid, COLOR_RED, "[!] Odustali ste od odabira skina!");
                return 1;
            }

            new
                house = PlayerKeys[playerid][pHouseKey];
            // TODO: house bounds check
            switch (listitem)
            {
                case 0:
                { // Slot1
                    if(HouseInfo[house][hSkin1])
                    {
                        tmpSkin[playerid] = GetPlayerSkin(playerid);
                        SkinSlot[playerid] = 1;
                        SetPlayerSkin(playerid, HouseInfo[house][hSkin1]);

                        CreatePlayerClosedScene(playerid);
                    }
                }
                case 1:
                { // Slot2
                    if(HouseInfo[house][hSkin2])
                    {
                        tmpSkin[playerid] = GetPlayerSkin(playerid);
                        SkinSlot[playerid] = 2;
                        SetPlayerSkin(playerid, HouseInfo[house][hSkin2]);

                        CreatePlayerClosedScene(playerid);
                    }
                }
                case 2:
                { // Slot3
                    if(HouseInfo[house][hSkin3])
                    {
                        tmpSkin[playerid] = GetPlayerSkin(playerid);
                        SkinSlot[playerid] = 3;
                        SetPlayerSkin(playerid, HouseInfo[house][hSkin3]);

                        CreatePlayerClosedScene(playerid);
                    }
                }
            }
            return 1;
        }
        case DIALOG_VIWO_PICK:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_VIWO_PICK, DIALOG_STYLE_INPUT, "Odabir Virtual Worlda", "Molimo Vas unesite Virtual World(viwo) u kojem je kuca namappana:", "Input", "Exit");

            new viwo = strval(inputtext);
            if(viwo < 0) return SendErrorMessage(playerid, "Virtual Wold kuce ne moze biti manji od 0!");
            new houseid = CreatingHouseID[playerid];
            if(houseid == INVALID_HOUSE_ID) return SendErrorMessage(playerid, "Niste u procesu stvaranja kuce!");

            HouseInfo[houseid][hVirtualWorld] = viwo;
            UpdateHouseVirtualWorld(houseid);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Virtual World kuce %d[SQLID: %d] je uspjesno postavljen na %d te je stvaranje kuce dovrseno!", houseid, HouseInfo[houseid][hSQLID], viwo);
            return 1;
        }
    }
    return 0;
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

CMD:buyhouse(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");

    new house = Player_InfrontHouse(playerid);
    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu kuce!");
    if(HouseInfo[house][hOwnerID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca mora biti na prodaju!");
    if(PlayerInfo[playerid][pLevel] < HouseInfo[house][hLevel])
    {
        SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level %d da bi ste kupili ovu kucu!", HouseInfo[house][hLevel]);
        return 1;
    }
    if(PlayerKeys[playerid][pHouseKey] < 0)
        return 1;

    if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID && HouseInfo[PlayerKeys[playerid][pHouseKey]][hOwnerID] == PlayerInfo[playerid][pSQLID])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete kucu!");

    if(CalculatePlayerBuyMoney(playerid, BUY_TYPE_HOUSE) < HouseInfo[house][hValue])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za kupovinu ove kuce!");

    Player_SetBuyPrice(playerid, HouseInfo[house][hValue]);
    GetPlayerPaymentOption(playerid, BUY_TYPE_HOUSE);
    return 1;
}

CMD:houseentrance(playerid, params[])
{
    new houseid;
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
    if(sscanf(params, "i", houseid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /houseentrance [houseid]");
    if(!Iter_Contains(House, houseid)) return SendClientMessage(playerid, COLOR_RED, "Morate unijeti valjani houseid!");

    va_SendClientMessage(playerid, COLOR_RED, "[!] Premjestili ste ulaz od kuce %d na ovo mjesto!",houseid);

    new string[128], Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    format(string, sizeof(string), "[ADMIN]: %s je premjestio kucu: [%d] na [%.2f - %.2f - %.2f].", GetName(playerid,false), houseid, X, Y, Z);
    ABroadCast(COLOR_LIGHTRED,string, 5);

    HouseInfo[houseid][hEnterX] = X;
    HouseInfo[houseid][hEnterY] = Y;
    HouseInfo[houseid][hEnterZ] = Z-0.8;
    HouseInfo[houseid][h3dViwo] = GetPlayerVirtualWorld(playerid);

    CreateHouseEnter(houseid);

    mysql_fquery(g_SQL, 
        "UPDATE houses SET enterX = '%f', enterY = '%f', enterZ = '%f', viwoexit = '%d' WHERE id = '%d'",
        HouseInfo[houseid][hEnterX],
        HouseInfo[houseid][hEnterY],
        HouseInfo[houseid][hEnterZ],
        HouseInfo[houseid][h3dViwo],
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

CMD:customhouseint(playerid, params[])
{
    new
        Float:iX, Float:iY, Float:iZ,
        houseid, hint;

    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "iifff", houseid, hint, iX, iY, iZ)) {
        SendClientMessage(playerid, COLOR_RED, "[?]: /custombizint [houseid][int][X][Y][Z]");
        SendClientMessage(playerid, COLOR_GREY, "NOTE: Taj ID MORA biti u skripti!");
        return 1;
    }
    if(!Iter_Contains(House, houseid)) return SendClientMessage(playerid, COLOR_RED, "Morate unijeti valjani houseid!");

    HouseInfo[houseid][hExitX]      = iX;
    HouseInfo[houseid][hExitY]      = iY;
    HouseInfo[houseid][hExitZ]      = iZ;
    HouseInfo[houseid][hInt]        = hint;

    mysql_fquery(g_SQL, 
        "UPDATE houses SET exitX = '%f', exitY = '%f', exitZ = '%f', int = '%d' WHERE id = '%d'",
        HouseInfo[houseid][hExitX],
        HouseInfo[houseid][hExitY],
        HouseInfo[houseid][hExitZ],
        HouseInfo[houseid][hInt],
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

CMD:houseint(playerid, params[])
{
    new 
        houseid, 
        int;
    if(PlayerInfo[playerid][pAdmin] < 1338) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Head Administrator!");
    if(sscanf(params, "ii", houseid, int)) 
        return SendClientMessage(playerid, COLOR_RED, "[?]: /houseint [houseid][id (1-42)]");
    if(!Iter_Contains(House, houseid)) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "House with that ID doesn't exist");
    if(int < 0 || int > sizeof(HouseInts)) 
    {
        return SendFormatMessage(playerid, 
            MESSAGE_TYPE_ERROR, 
            "Interior ID's can't go below 0 or above %d!", 
            sizeof(HouseInts)
       );
    }
    HouseInfo[houseid][hExitX] = HouseInts[int][iEnterX];
    HouseInfo[houseid][hExitY] = HouseInts[int][iEnterY];
    HouseInfo[houseid][hExitZ] = HouseInts[int][iEnterZ];
    HouseInfo[houseid][hInt] = HouseInts[int][iInterior];    
    
    SendFormatMessage(playerid, 
        MESSAGE_TYPE_INFO, 
        "Interior(House ID %d): %s.", 
        houseid,
        HouseInts[int][iDescription]
   );

    mysql_fquery(g_SQL,
        "UPDATE houses SET exitX = '%f', exitY = '%f', exitZ= '%f', int= '%d' WHERE id = '%d'",
        HouseInfo[houseid][hExitX],
        HouseInfo[houseid][hExitY],
        HouseInfo[houseid][hExitZ],
        HouseInfo[houseid][hInt],
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

CMD:ring(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce ili garaze (niste u checkpointu)!");
    if(Player_InfrontHouse(playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce ili garaze (niste u checkpointu)!");

    new
        houseid = Player_InfrontHouse(playerid);
    if(houseid != INVALID_HOUSE_ID)
    {
        PlaySoundForPlayersInRange(20801, 80.0, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY], HouseInfo[houseid][hExitZ]);
        PlaySoundForPlayersInRange(20801, 50.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);
    }
    return 1;
}

CMD:knock(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
    if(Player_InfrontHouse(playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");

    new
        house = Player_InfrontHouse(playerid),
        string[45];

    if(IsPlayerInRangeOfPoint(playerid,2.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ])
        && HouseInfo[house][h3dViwo] == GetPlayerVirtualWorld(playerid))
    {
        format(string, sizeof(string), "* %s kuca po vratima.", GetName(playerid, true));
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

        foreach(new p : Player)
        {
            if(IsPlayerInRangeOfPoint(p, 30.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]))
            SendClientMessage(p, COLOR_PURPLE, "* Netko kuca na ulazna vrata.");
        }
    }
    return 1;
}

CMD:doorshout(playerid, params[])
{
    if(AntiSpamInfo[playerid][asDoorShout] > gettimestamp()) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_DOOR_SHOUT);
    if(Player_InfrontHouse(playerid) == INVALID_HOUSE_ID && Player_InHouse(playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce/u kuci!");

    new
        result[100],
        house;

    if(sscanf(params, "s[100]", result)) return SendClientMessage(playerid, COLOR_RED, "[?]: /doorshout [text]");

    // TODO: this is code duplication. try to refactor it.
    if(Player_InfrontHouse(playerid) != INVALID_HOUSE_ID)
    {
        house = Player_InfrontHouse(playerid);
        // TODO: bounds checking
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]) && HouseInfo[house][h3dViwo] == GetPlayerVirtualWorld(playerid))
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti vrlo blizu vrata od kuce!");
            return 1;
        }

        AntiSpamInfo[playerid][asDoorShout] = gettimestamp() + ANTI_SPAM_DOOR_SHOUT;

        new
            string[144],
            color = COLOR_FADE1;
        if(Admin_OnDuty(playerid))
        {
            format(string, sizeof(string), "(( Admin %s se dere[VRATA]: %s))", GetName(playerid, true), result);
            ProxDetector(30.0, playerid, string, COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE);
            color = COLOR_ORANGE;
        }
        if(Helper_OnDuty(playerid))
        {
            format(string, sizeof(string), "(( Helper %s se dere[VRATA]: %s))", GetName(playerid, true), result);
            ProxDetector(30.0, playerid, string, COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
            color = COLOR_ORANGE;
        }
        if(Player_UsingMask(playerid) && !Admin_OnDuty(playerid))
        {
            format(string, sizeof(string), "Maska_%d se dere[VRATA]: %s !!", PlayerInventory[playerid][pMaskID], result);
            ProxDetector(30.0, playerid, string, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            color = COLOR_FADE1;
        }
        if(!Admin_OnDuty(playerid) && !Player_UsingMask(playerid))
        {
            format(string, sizeof(string), "%s se dere[VRATA]: %s !!", GetName(playerid, true), result);
            ProxDetector(30.0, playerid, string, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            color = COLOR_FADE1;
        }

        foreach(new i : Player)
        {
            if(IsPlayerInRangeOfPoint(i, 30.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerInterior(i) == HouseInfo[house][hInt] &&  GetPlayerVirtualWorld(i) == HouseInfo[house][hVirtualWorld])
            {
                SendClientMessage(i, color, string);
                continue;
            }
        }
    }
    else
    {
        if(Player_InHouse(playerid) != INVALID_HOUSE_ID)
        {
            house = Player_InHouse(playerid);
            // TODO: bounds checking
            if(!IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && HouseInfo[house][hVirtualWorld] == GetPlayerVirtualWorld(playerid))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti vrlo blizu vrata od kuce!");
                return 1;
            }

            AntiSpamInfo[playerid][asDoorShout] = gettimestamp() + ANTI_SPAM_DOOR_SHOUT;

            new
                string[144],
                color = COLOR_FADE1;
            if(Admin_OnDuty(playerid))
            {
                format(string, sizeof(string), "(( Admin %s se dere[VRATA]: %s))", GetName(playerid, true), result);
                ProxDetector(30.0, playerid, string, COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE);
                color = COLOR_ORANGE;
            }
            if(Helper_OnDuty(playerid))
            {
                format(string, sizeof(string), "(( Helper %s se dere[VRATA]: %s))", GetName(playerid, true), result);
                ProxDetector(30.0, playerid, string, COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
                color = COLOR_ORANGE;
            }
            if(Player_UsingMask(playerid) && !Admin_OnDuty(playerid))
            {
                format(string, sizeof(string), "Maska_%d se dere[VRATA]: %s !!", PlayerInventory[playerid][pMaskID], result);
                ProxDetector(30.0, playerid, string, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                color = COLOR_FADE1;
            }
            if(!Admin_OnDuty(playerid) && !Player_UsingMask(playerid))
            {
                format(string, sizeof(string), "%s se dere[VRATA]: %s !!", GetName(playerid, true), result);
                ProxDetector(30.0, playerid, string, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
                color = COLOR_FADE1;
            }

            foreach(new i : Player)
            {
                if(IsPlayerInRangeOfPoint(i, 30.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
                {
                    SendClientMessage(i, color, string);
                    continue;
                }
            }
        }
    }
    return 1;
}

CMD:rent(playerid, params[])
{
    new pick[11];
    if(sscanf(params, "s[11]", pick)) return SendClientMessage(playerid, COLOR_WHITE, "[?]: /rent [house/vehicle]");

    if(!strcmp(pick, "house", true))
    {
        new hpick[11];
        if(sscanf(params, "s[11]s[11]", pick, hpick))
        {
            SendClientMessage(playerid, COLOR_RED, "[?]: /rent house [odabir]");
            SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: start - stop");
            return 1;
        }

        if(!strcmp(hpick, "start", true))
        {
            if((PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID) || (PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Posjedujete kucu ili rentate kucu!");
                return 1;
            }

            new
                houseid = Player_InfrontHouse(playerid);
            if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid)) || houseid == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
            if(!HouseInfo[houseid][hRentabil]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nije na rent!");
            if(AC_GetPlayerMoney(playerid) < HouseInfo[houseid][hRent]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");

            PlayerKeys[playerid][pRentKey] = houseid;
            PlayerInfo[playerid][pSpawnChange] = 1;
            PlayerToHouseMoneyTAX(playerid, houseid, HouseInfo[houseid][hRent]);

            new
                string[96];
            format(string, sizeof(string), "[!] Sada ste u najmu kuce i oduzeta vam je cijena najamnine u vrijednosti od "COL_GREEN"%d$",
                HouseInfo[houseid][hRent]
           );
            SendClientMessage(playerid, COLOR_GREEN, string);
            PlayerInfo[playerid][pSpawnChange] = 1;

            mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
                PlayerInfo[playerid][pSpawnChange],
                PlayerInfo[playerid][pSQLID]
           );

            SetPlayerSpawnInfo(playerid);
            SendClientMessage(playerid, COLOR_RED, "[!] Spawn Vam je automatski prebacen na iznajmljenu kucu.");
        }
        else if(!strcmp(hpick, "stop", true))
        {
            if((PlayerKeys[playerid][pRentKey] == INVALID_HOUSE_ID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne iznajmljujete kucu!");

            new house = PlayerKeys[playerid][pRentKey];
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prestali ste iznajmljivati kucu na adresi %s.", HouseInfo[house][hAdress]);
            PlayerKeys[playerid][pRentKey] = INVALID_HOUSE_ID;
            PlayerInfo[playerid][pSpawnChange] = 0;
            SetPlayerSpawnInfo(playerid);
        }
    }
    // TODO: "vehicle" case not implemented
    return 1;
}

CMD:house(playerid, params[])
{
    if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 2+ da mozes koristiti ovu komandu!");

    new house = PlayerKeys[playerid][pHouseKey];
    if(house == INVALID_HOUSE_ID || HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID])
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujes kucu!");
        return 1;
    }

    ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
    return 1;
}

// TODO: bool
stock IsOwnerOfHouseOnline(houseid)
{
    foreach(new playerid : Player)
    {
        if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID])
            return 1;
    }
    return 0;
}

CMD:picklock(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");

    new
        pick[6],
        house = Player_InfrontHouse(playerid);
    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce(u checkpointu)!");
    if(!IsOwnerOfHouseOnline(house)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mozete provaljivati samo kada je vlasnik online!");

    if(sscanf(params, "s[6]", pick))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /picklock [odabir]");
        SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: card, tools");
        return 1;
    }

    if(!strcmp(pick, "card", true))
    {
        if(HouseInfo[house][hLockLevel] > 1) return SendClientMessage(playerid, COLOR_RED, "[!] Brava je precvrsta da biste mogli rabiti karticu!");
        if(!HouseInfo[house][hLock])         return SendClientMessage(playerid, COLOR_RED, "[!] Vrata su otkljucana!");

        new rand = random(50) + 1;
        if(rand > 10)
        {
            SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste otkljucali vrata!");
            HouseInfo[house][hLock] = 0;
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "[!] Niste uspjeli otkljucati vrata!");
        }
        return 1;
    }
    else if(!strcmp(pick, "tools", true))
    {
        if(PickingLock[playerid])
        {
            ResetLockPickVars(playerid);
            TogglePlayerControllable(playerid, true);
            return 1;
        }
        if(!HouseInfo[house][hLock]) return SendClientMessage(playerid, COLOR_RED, "[!] Vrata su otkljucana!");
        if(HouseInfo[house][hLockLevel] > 2)
        {
            SendClientMessage(playerid, COLOR_RED, "[!] Brava je precvrsta da biste mogli rabiti picklock!");
        }

        SetPlayerPickLock(playerid);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prebacivanje slota koristite ~k~~CONVERSATION_YES~ ili ~k~~CONVERSATION_NO~. Za podizanje kombinacije koristite ~k~~PED_SPRINT~!");
        ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_nod", 3.1, 1, 0, 0, 1, 0, 1, 0);
    }
    return 1;
}

CMD:doorram(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");

    new
        param[8],
        house = Player_InfrontHouse(playerid);
    if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce(u checkpointu)!");
    if(!HouseInfo[house][hLock]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su otkljucana!");
    if(!IsOwnerOfHouseOnline(house)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mozete provaljivati samo kada je vlasnik online!");
    if(sscanf(params, "s[8]", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /doorram [foot/crowbar]");

    if(!strcmp("foot", param, true))
    {
        /*if(Player_GetRammingDoor(playerid) == DOOR_RAM_FOOT)
        {
            TogglePlayerControllable(playerid, true);
            ResetDoorKickingVars(playerid);
            return 1;
        }*/
        if(Player_GetRammingDoor(playerid) == DOOR_RAM_FOOT)
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec razvaljujete vrata!");
            return 1;
        }
        if(HouseInfo[house][hDoorLevel] > 3)
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su precvrsta da biste ih mogli razvaliti nogom!");
            return 1;
        }

        SendMessage(playerid, MESSAGE_TYPE_INFO, "Za udaranje nogom u vrata koristite tipku ~k~~PED_SPRINT~, a za prestak koristite /doorram foot!");
        SetPlayerFootEntering(playerid);
    }
    if(!strcmp("crowbar", param, true))
    {
        if(Player_GetRammingDoor(playerid) == DOOR_RAM_CROWBAR)
        {
            DisablePlayerKeyInput(playerid);
            TogglePlayerControllable(playerid, true);
            Player_SetRammingDoor(playerid, DOOR_RAM_NONE);
            return 1;
        }

        #if defined MODULE_OBJECTS
        new
            object = IsObjectAttached(playerid, 18634);
        if(object == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pajser u rukama!");
        if(5 <= PlayerObject[playerid][object][poBoneId] <= 6)
        {
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Pricekajte tipke koje morate unijeti, za prekid probijanja kucajte /doorram crowbar!");
            SetPlayerCrowbarBreaking(playerid);
        }
        else
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pajser mora biti u rukama!");
        }
        #endif
    }
    return 1;
}

CMD:unrenthouse(playerid, params[])
{
    new house = PlayerKeys[playerid][pRentKey];
    if(house == INVALID_HOUSE_ID) return SendClientMessage(playerid, COLOR_RED, "Ne iznajmljujete kucu!");

    va_SendClientMessage(playerid, COLOR_RED, "[!] Prestao si iznajmljivati kucu na adresi %s.", HouseInfo[house][hAdress]);
    PlayerKeys[playerid][pRentKey] = INVALID_HOUSE_ID;
    return 1;
}

CMD:createhouse(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");

    new
        level, price, address[32], interior;
    if(sscanf(params, "iiis[32]", level, price, interior, address))
    {
        for (new i = 0; i < sizeof(HouseInts); i++)
        {
            va_SendClientMessage(playerid, COLOR_GRAD2, "Interior: [%d] %s", i, HouseInts[i][iDescription]);
        }
        SendClientMessage(playerid, COLOR_RED, "[?]: /createhouse [level][price][interior][address]");
        return 1;
    }

    if(strlen(address) <= 0 || strlen(address) > 32)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Adresa moze imati minimalno 1, a maksimalno 32 znaka!");

    new Float:x, Float:y, Float:z, freeslot;
    GetPlayerPos(playerid, x, y, z);

    va_SendClientMessage(playerid, COLOR_RED, "[!] Kreirao si kucu level [%i], cijena[%i], adresa[%s]", level, price, address);
    va_SendClientMessage(playerid, COLOR_RED, "[!] interior [%s]. ", HouseInts[interior][iDescription]);

    freeslot = Iter_Free(House);
    HouseInfo[freeslot][hLevel] = level;
    HouseInfo[freeslot][hValue] = price;
    format(HouseInfo[freeslot][hAdress], 32, "%s", address);
    HouseInfo[freeslot][hEnterX] = x;
    HouseInfo[freeslot][hEnterY] = y;
    HouseInfo[freeslot][hEnterZ] = z;
    HouseInfo[freeslot][hExitX] = HouseInts[interior][iEnterX];
    HouseInfo[freeslot][hExitY] = HouseInts[interior][iEnterY];
    HouseInfo[freeslot][hExitZ] = HouseInts[interior][iEnterZ];
    HouseInfo[freeslot][hInt] = HouseInts[interior][iInterior];

    CreatingHouseID[playerid] = freeslot;
    Iter_Add(House, freeslot);
    InsertHouseInDB(freeslot, playerid);
    CreateHouseEnter(freeslot);
    return 1;
}
