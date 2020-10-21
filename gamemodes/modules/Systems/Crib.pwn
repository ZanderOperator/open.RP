#include <YSI_Coding\y_hooks>

#define ZONE_WIDTH			150.0
#define ZONE_HEIGHT			195.0

#define CP_TYPE_HOUSE 		(1)


/*
	######## ##    ## ##     ## ##     ##
	##       ###   ## ##     ## ###   ###
	##       ####  ## ##     ## #### ####
	######   ## ## ## ##     ## ## ### ##
	##       ##  #### ##     ## ##     ##
	##       ##   ### ##     ## ##     ##
	######## ##    ##  #######  ##     ##
*/
///////////////////////////////////////////////////////////////////
enum E_HOUSE_INTS
{
	Float:iEnterX,
	Float:iEnterY,
	Float:iEnterZ,
	iInterior,
	iDescription[42]
}
new
	HouseInts[42][E_HOUSE_INTS] = {
		{ 235.3054, 	1186.6835, 		1080.2578, 		3, 		"Large/2 story/3 bedrooms"					},
		{ 225.756989,	1240.000000,	1082.149902, 	2, 		"Medium/1 story/1 bedroom"					},
		{ 223.1929,		1287.0780,		1082.1406,		1, 		"Small/1 story/1 bedroom"					},
		{ 225.630997, 	1022.479980, 	1084.069946, 	7, 		"Very Large/2 story/4 bedrooms"				},
		{ 295.138977, 	1474.469971, 	1080.519897, 	15, 	"Small/1 story/2 bedrooms"					},
		{ 328.1066,		1478.0106,		1084.4375,		15,		"Small/1 story/2 bedrooms"					},
		{ 385.803986, 	1471.769897, 	1080.209961, 	15, 	"Small/1 story/1 bedroom/no bathroom"		},
		{ 375.971985, 	1417.269897, 	1081.409912, 	15, 	"Small/1 story/1 bedroom"					},
		{ 490.810974, 	1401.489990, 	1080.339966, 	2, 		"Large/2 story/3 bedrooms"            		},
		{ 446.8264, 	1397.3435, 		1084.3047, 		5, 		"Medium/1 story/2 bedrooms"           		},
		{ 227.722992, 	1114.389893, 	1081.189941, 	4, 		"Large/2 story/4 bedrooms"            		},
		{ 260.983978, 	1286.549927, 	1080.299927, 	4, 		"Small/1 story/1 bedroom"					},
		{ 221.7330, 	1140.5146, 		1082.6094, 		10,		"Small/1 story/1 bedroom/NO BATHROOM"		},
		{ 23.9878, 		1340.3865, 		1084.3750, 		4, 		"Medium/2 story/1 bedroom"                    },
		{ -262.601990, 	1456.619995, 	1084.449951, 	5, 		"Large/2 story/1 bedroom/NO BATHROOM"         },
		{ 22.778299, 	1404.959961, 	1084.449951, 	5, 		"Medium/1 story/2 bedrooms/NO BATHROOM"	      },
		{ 140.2267, 	1365.9246, 		1083.8594, 		6, 		"Large/2 story/4 bedrooms/NO BATHROOM"        },
		{ 234.045990, 	1064.879883, 	1084.309937, 	6, 		"Large/2 story/3 bedrooms"                    },
		{ -68.294098, 	1353.469971, 	1080.279907, 	15,		"Small/1 story/NO BEDROOM"                    },
		{ -285.548981, 	1470.979980, 	1084.449951, 	8, 		"1 bedroom/living room/kitchen/NO BATHROOM"   },
		{ -42.581997, 	1408.109985, 	1084.449951, 	9, 		"Small/1 story/NO BEDROOM"                    },
		{ 83.345093, 	1324.439941, 	1083.889893, 	9, 		"Medium/2 story/2 bedrooms"                   },
		{ 260.941986, 	1238.509888, 	1084.259888, 	1, 		"Small/1 story/1 bedroom"                     },
		{ 244.411987, 	305.032990, 	999.231995, 	2, 		"Denise's Bedroom"                            },
		{ 266.4986, 	305.0700,		999.1484, 		3, 		"Katie's Bedroom"                             },
		{ 291.282990, 	310.031982, 	999.154968, 	4, 		"Helena's Bedroom (barn)"                     },
		{ 302.181000, 	300.722992, 	999.231995, 	5, 		"Michelle's Bedroom"                          },
		{ 322.197998, 	302.497986, 	999.231995, 	6, 		"Barbara's Bedroom"                           },
		{ 343.7173, 	304.9440, 		999.1484, 		3, 		"Millie's Bedroom"                            },
		{ 2495.6416, 	-1692.2361, 	1014.7422, 		5, 		"CJ's Mom's House"                            },
		{ 1263.079956, 	-785.308960, 	1091.959961, 	2, 		"Madd Dogg's Mansion (West door)"             },
		{ 2468.450, 	-1698.4801,		1013.5078, 		1, 		"Ryder's house"                               },
		{ 2526.459961, 	-1679.089966, 	1015.500000, 	2, 		"Sweet's House"                               },
		{ 2543.659912, 	-1303.629883, 	1025.069946, 	6, 		"Big Smoke's Crack Factory (Ground Floor)"    },
		{ 744.542969, 	1437.669922, 	1102.739990, 	3, 		"Fanny Batter's Whore House"                  },
		{ 964.106995, 	-53.205498, 	1001.179993, 	5, 		"Tiger Skin Rug Brothel"                      },
		{ 2350.339844, 	-1181.649902, 	1028.000000, 	8, 		"Burning Desire Gang House"                   },
		{ 2807.9172, 	-1174.4333, 	1025.5703, 		5, 		"Colonel Furhberger's House"                  },
		{ 318.6453, 	1114.4795, 		1083.8828, 		12,		"Crack Den"                                   },
		{ 2324.3267, 	-1149.1440, 	1050.7101, 		12,		"Unused Safe House"                           },
		{ 446.5014, 	507.0295, 		1001.4195, 		15,		"Budget Inn Motel Room"                       },
		{ 2216.3398, 	-1150.5099, 	1025.7969, 		11,		"Jefferson Motel"                             }
};

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/
///////////////////////////////////////////////////////////////////
// Vars
static stock
		HouseAlarmZone[MAX_HOUSES],
		GlobalZoneT[MAX_HOUSES],
		GlobalMapIconT[MAX_HOUSES],
		Float:PickLockMaxValue[MAX_PLAYERS][3],
		PlayerBar:PickLockBars[MAX_PLAYERS][3],
		PlayerBar:FootKickingBar[MAX_PLAYERS],
		Float:tmpPos[MAX_PLAYERS][3],
		tmpInterior[MAX_PLAYERS],
		tmpSkin[MAX_PLAYERS],
		tmpViwo[MAX_PLAYERS],
		CreatingHouseID[MAX_PLAYERS],
		PickLockTimeC[MAX_PLAYERS],
		PickLockTimer[MAX_PLAYERS],
		PlayerPickLockTimer[MAX_PLAYERS],
		Timer:PlayerClosedTimer[MAX_PLAYERS],
		AlarmEffect[3] = { 41800, 3401, 42801 };
new
	PlayerHouseCP[MAX_PLAYERS];


new wooGate[3],
	wooGateStatus[3];

// rBits
stock
		Bit1:	gr_HouseAlarm			<MAX_HOUSES>,
		Bit1: 	r_PlayerDoorPeek		<MAX_PLAYERS>,
		Bit1:	gr_CrowbarBreaking		<MAX_PLAYERS>,
		Bit1:	gr_PlayerPickLocking	<MAX_PLAYERS>,
		Bit1: 	gr_PlayerFootKicking	<MAX_PLAYERS>,
		Bit2:	gr_SkinSlot				<MAX_PLAYERS>,
		Bit2:	gr_PlayerPickSlot		<MAX_PLAYERS>,
		Bit16: 	gr_DynamicHouseID		<MAX_PLAYERS>,
		Bit16:	gr_SefInputAmmo			<MAX_PLAYERS>;

// TextDraws
new
		PlayerText:HouseBcg1[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:HouseBcg2[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:HouseInfoText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:HouseInfoTD[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:HouseCMDTD[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:PicklockBcg[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:Picklock1Done[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:Picklock2Done[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:Picklock3Done[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:PickLockTimeTitle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:PickLockTime[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:FootKickingBcg1[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:FootKickingBcg2[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:LoadingObjectsTXD[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
		PlayerText:FootKickingText[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... };

hook OnGameModeInit()
{
	wooGate[0] = CreateObject(980, 785.585754, -1152.468017, 25.328947, 0.000000, 0.000000, 90.000000, 300.00);
	wooGate[1] = CreateObject(980, 659.517700, -1227.184692, 16.826818, 0.000000, 0.000000, 62.700065, 300.00);
	wooGate[2] = CreateObject(980, 664.907043, -1309.447631, 15.290976, 0.000000, 0.000000, 0.000000, 300.00);
	return 1;
}


/*

	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/
///////////////////////////////////////////////////////////////////
_LoadingObjects(playerid, bool:status) {
	if(status == false) 
		PlayerTextDrawHide(playerid, LoadingObjectsTXD[playerid]), LoadingObjectsTXD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	else if(status == true) {
		PlayerTextDrawHide(playerid, LoadingObjectsTXD[playerid]);
		
		LoadingObjectsTXD[playerid] = CreatePlayerTextDraw(playerid, 296.333343, 418.148223, "[!] Loading_Objects...");
		PlayerTextDrawLetterSize(playerid, LoadingObjectsTXD[playerid], 0.195000, 1.151999);
		PlayerTextDrawAlignment(playerid, LoadingObjectsTXD[playerid], 1);
		PlayerTextDrawColor(playerid, LoadingObjectsTXD[playerid], -2147483393);
		PlayerTextDrawSetShadow(playerid, LoadingObjectsTXD[playerid], 0);
		PlayerTextDrawSetOutline(playerid, LoadingObjectsTXD[playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, LoadingObjectsTXD[playerid], 255);
		PlayerTextDrawFont(playerid, LoadingObjectsTXD[playerid], 1);
		PlayerTextDrawSetProportional(playerid, LoadingObjectsTXD[playerid], 1);
		PlayerTextDrawSetShadow(playerid, LoadingObjectsTXD[playerid], 0);
		PlayerTextDrawShow(playerid, LoadingObjectsTXD[playerid]);
	}
	return (true);
}

Public:LoadingObjects(playerid, bool: status) {
	if(status == false) 
		_LoadingObjects(playerid, false);
	if(status == true) {	
		SetTimerEx("LoadingObjects", 6000, (false), "ib", playerid, false);
		TogglePlayerControllable(playerid, true);
		PlayerTextDrawSetString(playerid, LoadingObjectsTXD[playerid], "[!] Objects Loaded!");
	}
	return (true);
}

Public:OnHouseInsertInDB(houseid, playerid)
{
	HouseInfo[houseid][hSQLID] = cache_insert_id();
	if(HouseInfo[houseid][hInt] > 0)
	{
		HouseInfo[houseid][hVirtualWorld] = HouseInfo[houseid][hSQLID];
		UpdateHouseVirtualWorld(houseid);
	}
	else ShowPlayerDialog(playerid, DIALOG_VIWO_PICK, DIALOG_STYLE_INPUT, "Odabir Virtual Worlda", "Molimo Vas unesite Virtual World(viwo) u kojem je kuca namappana:", "Input", "Exit");
	return 1;
}

stock Float:GetDistanceBetweenPoints3D(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2){
    return VectorSize(x1-x2,y1-y2,z1-z2);
}  

stock UpdateHouseVirtualWorld(houseid)
{
	new viwoString[70];
	format(viwoString, sizeof(viwoString), "UPDATE `houses` SET `viwo` = '%d' WHERE `id` = '%d'",
		HouseInfo[houseid][hVirtualWorld],
		HouseInfo[houseid][hSQLID]
	);
	mysql_tquery(g_SQL, viwoString);
	return 1;
}

stock CheckHouseInfoTextDraws(playerid)
{
	new houseid = Bit16_Get(gr_PlayerInfrontHouse, playerid);
	if(!Iter_Contains(Houses, houseid))
		return 1;
		
	if(!IsPlayerInDynamicCP(playerid, HouseInfo[houseid][hEnterCP]))
	{
		DestroyHouseInfoTD(playerid);
		PlayerHouseCP[playerid] 		= -1;
		Bit16_Set(gr_PlayerInfrontHouse, playerid, INVALID_HOUSE_ID);
	}
    return 1;
}

// Timers
forward PicklockTime(playerid, houseid);
public PicklockTime(playerid, houseid)
{
	new
		tmpString[10];
	valstr(tmpString, PickLockTimeC[playerid] - 1, false);
	PlayerTextDrawSetString(playerid, PickLockTime[playerid], tmpString);
	if(--PickLockTimeC[playerid] == 0) {
		ResetLockPickVars(playerid);
		if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
			PlayHouseAlarm(houseid);
	}
}

forward DestroyGlobalZone(houseid);
public DestroyGlobalZone(houseid)
{
	foreach(new i : Player) {
		if(PlayerInfo[i][pHouseKey] == houseid || IsACop(i) ) {
			GangZoneDestroy(HouseAlarmZone[houseid]);
			HouseAlarmZone[houseid] = -1;
			break;
		}
	}
	KillTimer(GlobalZoneT[houseid]);
	return 1;
}

forward DestroyGlobalMapIcon(houseid);
public DestroyGlobalMapIcon(houseid)
{
	foreach(new i : Player) {
		if(IsValidDynamicMapIcon(GlobalMapIcon[i]))
			DestroyDynamicMapIcon(GlobalMapIcon[i]);
	}
	KillTimer(GlobalMapIconT[houseid]);
	return 1;
}

// STOCKS
stock ResetHouseVariables(playerid)
{
	// Floats
	tmpPos[playerid][0]		= 0.0;
	tmpPos[playerid][1]		= 0.0;
	tmpPos[playerid][2]		= 0.0;

	// Vars
	tmpInterior[playerid]		= 0;
	tmpSkin[playerid]			= 1;
	tmpViwo[playerid]			= 0;
	CreatingHouseID[playerid] = INVALID_HOUSE_ID;

	// Misc
	DestroyHouseInfoTD(playerid);
	stop PlayerClosedTimer[playerid];

	// Lockpicking
	ResetLockPickVars(playerid);
	ResetDoorKickingVars(playerid);

	// rBits
	Bit1_Set(gr_CrowbarBreaking, 		playerid, false);
	Bit1_Set(r_PlayerDoorPeek,			playerid, false);
	Bit2_Set(gr_SkinSlot, 				playerid, 0);
	Bit2_Set(gr_PlayerPickSlot,		playerid, 3);
	Bit16_Set(gr_PlayerInHouse, 		playerid, INVALID_HOUSE_ID);
	Bit16_Set(gr_PlayerInfrontHouse, 	playerid, INVALID_HOUSE_ID);
	Bit16_Set(gr_DynamicHouseID, 		playerid, INVALID_HOUSE_ID);
	return 1;
}

stock TogglePlayerHouseCPs(playerid, bool:toggle)
{
	// Streamer
	TogglePlayerAllDynamicCPs(playerid, toggle);
	foreach(new i : Houses) 
	{
		TogglePlayerDynamicCP(playerid, HouseInfo[i][hEnterCP], toggle);
	}
}

stock CreateHouseInfoTD(playerid)
{
	DestroyHouseInfoTD(playerid);
	HouseBcg1[playerid] = CreatePlayerTextDraw(playerid, 639.612121, 116.752761, "usebox");
	PlayerTextDrawLetterSize(playerid, 		HouseBcg1[playerid], 0.000000, 10.236042);
	PlayerTextDrawTextSize(playerid, 		HouseBcg1[playerid], 497.499877, 0.000000);
	PlayerTextDrawAlignment(playerid, 		HouseBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, 			HouseBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, 			HouseBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, 		HouseBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 		HouseBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		HouseBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, 			HouseBcg1[playerid], 0);
	PlayerTextDrawShow(playerid,			HouseBcg1[playerid]);

	HouseBcg2[playerid] = CreatePlayerTextDraw(playerid, 639.575012, 116.860000, "usebox");
	PlayerTextDrawLetterSize(playerid, 		HouseBcg2[playerid], 0.000000, 1.238053);
	PlayerTextDrawTextSize(playerid, 		HouseBcg2[playerid], 497.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, 		HouseBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, 			HouseBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, 			HouseBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, 		HouseBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 		HouseBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		HouseBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, 			HouseBcg2[playerid], 0);
	PlayerTextDrawShow(playerid,			HouseBcg2[playerid]);

	HouseInfoText[playerid] = CreatePlayerTextDraw(playerid, 501.850006, 117.488006, "HOUSE INFO");
	PlayerTextDrawLetterSize(playerid, 		HouseInfoText[playerid], 0.336050, 1.023200);
	PlayerTextDrawAlignment(playerid, 		HouseInfoText[playerid], 1);
	PlayerTextDrawColor(playerid, 			HouseInfoText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		HouseInfoText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		HouseInfoText[playerid], 1);
	PlayerTextDrawFont(playerid, 			HouseInfoText[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, HouseInfoText[playerid], 51);
	PlayerTextDrawSetProportional(playerid, HouseInfoText[playerid], 1);
	PlayerTextDrawShow(playerid,			HouseInfoText[playerid]);

	HouseInfoTD[playerid] = CreatePlayerTextDraw(playerid, 503.999877, 134.456085, "Vlasnik: Richard Collins~n~Cijena: 10.000~g~$~n~~w~Rent: 10~g~$~n~~w~Level: 16");
	PlayerTextDrawLetterSize(playerid, 		HouseInfoTD[playerid], 0.282599, 0.967758);
	PlayerTextDrawAlignment(playerid, 		HouseInfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, 			HouseInfoTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		HouseInfoTD[playerid], 1);
	PlayerTextDrawSetOutline(playerid, 		HouseInfoTD[playerid], 0);
	PlayerTextDrawFont(playerid, 			HouseInfoTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, HouseInfoTD[playerid], 255);
	PlayerTextDrawSetProportional(playerid, HouseInfoTD[playerid], 1);
	PlayerTextDrawShow(playerid,			HouseInfoTD[playerid]);

	HouseCMDTD[playerid] = CreatePlayerTextDraw(playerid, 503.550079, 190.175903, "Raspolozive komande:~n~      /doorshout, /ring, /enter");
	PlayerTextDrawLetterSize(playerid, 		HouseCMDTD[playerid], 0.240599, 0.879841);
	PlayerTextDrawAlignment(playerid, 		HouseCMDTD[playerid], 1);
	PlayerTextDrawColor(playerid, 			HouseCMDTD[playerid], -5963521);
	PlayerTextDrawSetShadow(playerid, 		HouseCMDTD[playerid], 1);
	PlayerTextDrawSetOutline(playerid, 		HouseCMDTD[playerid], 0);
	PlayerTextDrawFont(playerid, 			HouseCMDTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, HouseCMDTD[playerid], 255);
	PlayerTextDrawSetProportional(playerid, HouseCMDTD[playerid], 1);
	PlayerTextDrawShow(playerid,			HouseCMDTD[playerid]);
	return 1;
}

stock DestroyHouseInfoTD(playerid)
{
	PlayerTextDrawDestroy(playerid, 	HouseBcg1[playerid]);
	PlayerTextDrawDestroy(playerid, 	HouseBcg2[playerid]);
	PlayerTextDrawDestroy(playerid, 	HouseInfoText[playerid]);
	PlayerTextDrawDestroy(playerid, 	HouseInfoTD[playerid]);
	PlayerTextDrawDestroy(playerid, 	HouseCMDTD[playerid]);

	HouseBcg1[playerid]				= PlayerText:INVALID_TEXT_DRAW;
	HouseBcg2[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	HouseInfoText[playerid] 		= PlayerText:INVALID_TEXT_DRAW;
	HouseInfoTD[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	HouseCMDTD[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock LoadHouses()
{
	mysql_pquery(g_SQL, "SELECT * FROM houses", "OnServerHousesLoad");
	return 1;
}

forward OnServerHousesLoad();
public OnServerHousesLoad()
{
	if(!cache_num_rows()) return printf("MySQL Report: No houses exist to load.");
 	for(new row = 0; row < cache_num_rows(); row++) {
		cache_get_value_name_int(row, 		"id"		, 	HouseInfo[row][hSQLID]);
		cache_get_value_name_float(row, 	"enterX"	, 	HouseInfo[row][hEnterX]);
		cache_get_value_name_float(row, 	"enterY"	, 	HouseInfo[row][hEnterY]);
		cache_get_value_name_float(row, 	"enterZ"	, 	HouseInfo[row][hEnterZ]);
		cache_get_value_name_float(row, 	"exitX"	, 	HouseInfo[row][hExitX]);
		cache_get_value_name_float(row, 	"exitY"	, 	HouseInfo[row][hExitY]);
		cache_get_value_name_float(row, 	"exitZ"	, 	HouseInfo[row][hExitZ]);
		cache_get_value_name(row, 			"adress"	, 	HouseInfo[row][hAdress], 32);
		cache_get_value_name_int(row, 		"ownerid"	, 	HouseInfo[row][hOwnerID]);
        cache_get_value_name_int(row, 		"value"		, 	HouseInfo[row][hValue]);
        cache_get_value_name_int(row, 		"int"		, 	HouseInfo[row][hInt]);
        cache_get_value_name_int(row, 		"viwo"		, 	HouseInfo[row][hVirtualWorld]);
        cache_get_value_name_int(row, 		"lock"		, 	HouseInfo[row][hLock]);
		cache_get_value_name_int(row, 		"rentabil"	, 	HouseInfo[row][hRentabil]);
        cache_get_value_name_int(row, 		"takings"	, 	HouseInfo[row][hTakings]);
        cache_get_value_name_int(row, 		"level"	, 	HouseInfo[row][hLevel]);
        cache_get_value_name_int(row, 		"freeze"	, 	HouseInfo[row][hFreeze]);
        cache_get_value_name_int(row, 		"viwoexit"	, 	HouseInfo[row][h3dViwo]);
        cache_get_value_name_int(row, 		"opensafe"	,	HouseInfo[row][hSafeStatus]);
		cache_get_value_name_int(row, 		"safepass"	,	HouseInfo[row][hSafePass]	);
        cache_get_value_name_int(row, 		"safe"		,	HouseInfo[row][hSafe] 		);
        cache_get_value_name_int(row, 		"ormar"	,	HouseInfo[row][hOrmar] 		);
        cache_get_value_name_int(row, 		"skin1"	,	HouseInfo[row][hSkin1] 		);
        cache_get_value_name_int(row, 		"skin2"	,	HouseInfo[row][hSkin2] 		);
        cache_get_value_name_int(row, 		"skin3"	,	HouseInfo[row][hSkin3] 		);
        cache_get_value_name_int(row, 		"groceries",	HouseInfo[row][hGroceries]);
        cache_get_value_name_int(row, 		"doorlevel"	, HouseInfo[row][hDoorLevel]);
        cache_get_value_name_int(row, 		"alarm"		, HouseInfo[row][hAlarm]);
        cache_get_value_name_int(row, 		"locklevel"	, HouseInfo[row][hLockLevel]);
		cache_get_value_name_int(row, 		"moneysafe"	, HouseInfo[row][hMoneySafe]);
		cache_get_value_name_int(row, 		"radio"		, HouseInfo[row][hRadio]);
		cache_get_value_name_int(row, 		"tv"			, HouseInfo[row][hTV]);
		cache_get_value_name_int(row, 		"microwave"	, HouseInfo[row][hMicrowave]);
		cache_get_value_name_int(row, 		"storage_alarm", HouseInfo[row][hStorageAlarm]);
		cache_get_value_name_int(row, 		"bank"		 	, HouseInfo[row][hTakings]);
		cache_get_value_name_int(row, 		"fur_slots"	, HouseInfo[row][hFurSlots]);

		HouseInfo[row][hFurLoaded] = false;
		CreateHouseEnter(row);
		LoadHouseExterior(row);
		Iter_Add(Houses, row);
	}
	printf("MySQL Report: Houses Loaded (%d)!", Iter_Count(Houses));
	return 1;
}

stock static InsertHouseInDB(houseid, playerid) // Dodavanje nove kuce
{
	new insertQuery[512];
	mysql_format(g_SQL, insertQuery, sizeof(insertQuery), "INSERT INTO houses (`level`, `value`, `adress`, `enterX`, `enterY`, `enterZ`, `exitX`, `exitY`, `exitZ`, `ownerid`, `owned`, `int`) VALUES ('%d', '%d', '%e', '%f', '%f', '%f', '%f', '%f', '%f', '0', '0', '%d')",
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
	);
	mysql_tquery(g_SQL, insertQuery, "OnHouseInsertInDB", "ii", houseid, playerid);
	return 1;
}

stock SaveHouses()
{
	new
		saveString[1300];
	mysql_tquery(g_SQL, "BEGIN");
	foreach(new b : Houses) {
		mysql_format(g_SQL, saveString, 1300, "UPDATE `houses` SET `enterX` = '%f', `enterY` = '%f', `enterZ` = '%f', `exitX` = '%f', `exitY` = '%f', `exitZ` = '%f', `adress` = '%e', `value` = '%d', `int` = '%d', `viwo` = '%d', `lock` = '%d', `rent` = '%d', `rentabil` = '%d', `takings` = '%d', `level` = '%d', `freeze` = '%d', `viwoexit` = '%d', `safestatus` = '%d', `safepass` = '%d', `safe` = '%d', `ormar` = '%d', `skin1` = '%d', `skin2` = '%d', `skin3` = '%d', `groceries` = '%d', `doorlevel` = '%d', `alarm` = '%d', `locklevel` = '%d', `phone` = '%d', `phonenumber` = '%d', `moneysafe` = '%d', `radio` = '%d', `tv` = '%d', `microwave` = '%d', `storage_alarm` = '%d' WHERE `id` = '%d'",
			HouseInfo[b][hEnterX],
			HouseInfo[b][hEnterY],
			HouseInfo[b][hEnterZ],
			HouseInfo[b][hExitX],
			HouseInfo[b][hExitY],
			HouseInfo[b][hExitZ],
			HouseInfo[b][hAdress],
			HouseInfo[b][hValue],
			HouseInfo[b][hInt],
			HouseInfo[b][hVirtualWorld],
			HouseInfo[b][hLock],
			HouseInfo[b][hRent],
			HouseInfo[b][hRentabil],
			HouseInfo[b][hTakings],
			HouseInfo[b][hLevel],
			HouseInfo[b][hFreeze],
			HouseInfo[b][h3dViwo],
			HouseInfo[b][hSafeStatus],
			HouseInfo[b][hSafePass],
			HouseInfo[b][hSafe],
			HouseInfo[b][hOrmar],
			HouseInfo[b][hSkin1],
			HouseInfo[b][hSkin2],
			HouseInfo[b][hSkin3],
			HouseInfo[b][hGroceries],
			HouseInfo[b][hDoorLevel],
			HouseInfo[b][hAlarm],
			HouseInfo[b][hLockLevel],
			HouseInfo[b][hMoneySafe],
			HouseInfo[b][hRadio],
			HouseInfo[b][hTV],
			HouseInfo[b][hMicrowave],
			HouseInfo[b][hStorageAlarm],
			HouseInfo[b][hSQLID]
		);
		mysql_tquery(g_SQL, saveString);
	}
	mysql_tquery(g_SQL, "COMMIT");
	return 1;
}

stock static CreateHouseEnter(houseid)
{
	if(houseid == INVALID_HOUSE_ID) return 0;

	if(HouseInfo[houseid][h3dViwo] > 0)
		HouseInfo[houseid][hEnterCP] = CreateDynamicCP(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]-1.0, 2.0, HouseInfo[houseid][h3dViwo], 5, -1, 5.0);
	else
		HouseInfo[houseid][hEnterCP] = CreateDynamicCP(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]-1.0, 2.0, -1, -1, -1, 5.0);
	return 1;
}

stock static ShowHouseInfo(playerid, house)
{
	new
		infoString[64];
    format(infoString, sizeof(infoString), "Vlasnik: %s", GetPlayerNameFromSQL(HouseInfo[house][hOwnerID]));
    SendClientMessage(playerid, -1, infoString);
    if(HouseInfo[house][hSafe])
        SendClientMessage(playerid, -1, "Sef: "COL_GREEN"DA");
    else
        SendClientMessage(playerid, -1, "Sef: "COL_RED"NE");
    if(!HouseInfo[house][hAlarm])
        SendClientMessage(playerid, -1, "Alarm: "COL_RED"NE");
    else
    {
        format(infoString, sizeof(infoString), "Alarm Level: %d", HouseInfo[house][hAlarm]);
    	SendClientMessage(playerid, -1, infoString);
    }
    if(HouseInfo[house][hDoorLevel] == 0)
        SendClientMessage(playerid, -1, "Vrata: "COL_RED"Jako losa kvaliteta");
    else
    {
        format(infoString, sizeof(infoString), "Vrata Level: %d", HouseInfo[house][hDoorLevel]);
    	SendClientMessage(playerid, -1, infoString);
    }
    if(HouseInfo[house][hLockLevel] == 0)
        SendClientMessage(playerid, -1, "Brava: "COL_RED"Jako losa kvaliteta");
    else
    {
        format(infoString, sizeof(infoString), "Brava Level: %d", HouseInfo[house][hLockLevel]);
    	SendClientMessage(playerid, -1, infoString);
    }
}

stock static CreatePlayerClosedScene(playerid)
{
	// Camera pos
	Streamer_UpdateEx(playerid, 		255.3966, -39.9467, 1002.5233);
	SetPlayerCameraPos(playerid, 		255.3966, -39.9467, 1002.5233);
	SetPlayerCameraLookAt(playerid, 	258.5737, -41.8325, 1002.0000);

	// Player sets
	SetPlayerPos(playerid, 258.5737, -41.8325, 1002.0000);
	SetPlayerFacingAngle(playerid, -123.9000);
	SetPlayerVirtualWorld(playerid, playerid+100);
	SetPlayerInterior(playerid, 1000);
	TogglePlayerControllable(playerid, false);
	ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Legs", 4.1, 1, 0, 0, 0, 0, 1, 0);

	PlayerClosedTimer[playerid] = defer ClosedPlayerTimer(playerid);
	return 1;
}

stock static StopHouseAlarm(houseid)
{
	if(IsValidGangZone(HouseAlarmZone[houseid])) {
		GangZoneDestroy(HouseAlarmZone[houseid]);
		KillTimer(GlobalZoneT);
	}
	foreach(new i : Player) {
		if(IsACop(i) && IsASD(i)) {
			if(IsValidDynamicMapIcon(GlobalMapIcon[i]))
				DestroyDynamicMapIcon(GlobalMapIcon[i]);
		}
	}
	Bit1_Set(gr_HouseAlarm, houseid, false);
}

stock PlayHouseAlarm(houseid)
{
	if(houseid == INVALID_HOUSE_ID) return 1;
	new
		tmpString[64];
	if(Bit1_Get(gr_HouseAlarm, houseid)) return 1;
	switch(HouseInfo[houseid][hAlarm]) {
		case 1: { // Salje samo poruku onima oko kuce
			format(tmpString, sizeof(tmpString), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
			HouseProxDetector(houseid, 60.0, tmpString, COLOR_PURPLE);
			PlaySoundForPlayersInRange(AlarmEffect[0], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);
		}
		case 2:	{ // Salje samo poruku onima oko kuce & SMS-a ownera (ako je online)
			/************ LEVEL 1 ************/
			format(tmpString, sizeof(tmpString), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
			HouseProxDetector(houseid, 60.0, tmpString, COLOR_PURPLE);
			PlaySoundForPlayersInRange(AlarmEffect[1], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

			/************ LEVEL 2 ************/
			new
				ownerid = INVALID_PLAYER_ID;
			foreach(new i : Player) {
				if(houseid == PlayerInfo[i][pHouseKey]) {
					ownerid = i;
					break;
				}
			}
			if(ownerid == INVALID_PLAYER_ID) 	return 1;
			if(!IsPlayerAlive(ownerid)) 		return 1;

			SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
		}
		case 3: { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD
			/************ LEVEL 1 ************/
			format(tmpString, sizeof(tmpString), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
			HouseProxDetector(houseid, 60.0, tmpString, COLOR_PURPLE);
			PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

			/************ LEVEL 3 ************/
			SendPoliceMessage(COLOR_LIGHTBLUE, "*__________ EMERGENCY CALL (911) __________*");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
			format(tmpString, sizeof(tmpString), "Location: %s || Adress: %s",
				GetXYZZoneName(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
				HouseInfo[houseid][hAdress]
			);
			SendPoliceMessage(COLOR_LIGHTBLUE, tmpString);
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* __________________________________________ *");

			/************ LEVEL 2 ************/
			new
				ownerid = INVALID_PLAYER_ID;
			foreach(new i : Player) {
				if(houseid == PlayerInfo[i][pHouseKey]) {
					ownerid = i;
					break;
				}
			}
			if(ownerid == INVALID_PLAYER_ID) 	return 1;
			if(!IsPlayerAlive(ownerid)) 		return 1;

			SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
		}
		case 4: { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD & kreira mapicon za PD i vlasnika
			/************ LEVEL 1 ************/
			format(tmpString, sizeof(tmpString), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
			HouseProxDetector(houseid, 60.0, tmpString, COLOR_PURPLE);
			PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

			/************ LEVEL 3 ************/
			SendPoliceMessage(COLOR_LIGHTBLUE, "*__________ EMERGENCY CALL (911) __________*");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
			format(tmpString, sizeof(tmpString), "Location: %s || Adress: %s",
				GetXYZZoneName(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
				HouseInfo[houseid][hAdress]
			);
			SendPoliceMessage(COLOR_LIGHTBLUE, tmpString);
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* __________________________________________ *");

			/************ LEVEL 4 ************/
			new gang_zone = CreateGangZoneAroundPoint(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], ZONE_WIDTH, ZONE_HEIGHT);

			foreach(new i : Player) {
				if(IsACop(i) || PlayerInfo[i][pHouseKey] == houseid ) {
					GangZoneShowForPlayer(i,	gang_zone, COLOR_YELLOW);
					GangZoneFlashForPlayer(i, 	gang_zone, COLOR_RED);
				}
			}
			HouseAlarmZone[houseid] = gang_zone;
			GlobalZoneT[houseid] = SetTimerEx("DestroyGlobalZone", 480000, false, "i", houseid);

			/************ LEVEL 2 ************/
			new
				ownerid = INVALID_PLAYER_ID;
			foreach(new i : Player) {
				if(houseid == PlayerInfo[i][pHouseKey]) {
					ownerid = i;
					break;
				}
			}
			if(ownerid == INVALID_PLAYER_ID) 	return 1;
			if(!IsPlayerAlive(ownerid)) 		return 1;

			SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
		}
		case 5: { // Salje poruku onima oko kuce & SMS vlasniku (ako je online) & kontaktira PD & gang zone oko kuce & kreira mapicon za PD i vlasnika
			/************ LEVEL 1 ************/
			format(tmpString, sizeof(tmpString), "** [KUCA %s]: BEEP BEEP BEEP! **", HouseInfo[houseid][hAdress]);
			HouseProxDetector(houseid, 60.0, tmpString, COLOR_PURPLE);
			PlaySoundForPlayersInRange(AlarmEffect[2], 60.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);

			/************ LEVEL 3 ************/
			SendPoliceMessage(COLOR_LIGHTBLUE, "*____________ EMERGENCY CALL (911) ____________*");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Pozivatelj: Osiguravajuca kompanija || Locirani broj: 555-6935");
			format(tmpString, sizeof(tmpString), "Location: %s || Adress: %s",
				GetXYZZoneName(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]),
				HouseInfo[houseid][hAdress]
			);
			SendPoliceMessage(COLOR_LIGHTBLUE, tmpString);
			SendPoliceMessage(COLOR_LIGHTBLUE, "* Incident: Provala u kucu!");
			SendPoliceMessage(COLOR_LIGHTBLUE, "* ______________________________________________ *");

			/************ LEVEL 4 ************/
			new gang_zone = CreateGangZoneAroundPoint(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], ZONE_WIDTH, ZONE_HEIGHT);

			foreach(new i : Player) {
				if(IsACop(i) || PlayerInfo[i][pHouseKey] == houseid ) {
					GangZoneShowForPlayer(i,	gang_zone, COLOR_YELLOW);
					GangZoneFlashForPlayer(i, 	gang_zone, COLOR_RED);
				}
			}
			HouseAlarmZone[houseid] = gang_zone;
			GlobalZoneT[houseid] = SetTimerEx("DestroyGlobalZone", 480000, false, "i", houseid);

			/************ LEVEL 5 ************/
			foreach(new i : Player) {
				if(IsACop(i)) {
					GlobalMapIcon[i] = CreateDynamicMapIcon(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], 16, -1, -1, -1, i, 9000.0, MAPICON_GLOBAL);
				}
			}
			GlobalMapIconT[houseid] = SetTimerEx("DestroyGlobalMapIcon", 480000, false, "i", houseid);

			/************ LEVEL 2 ************/
			new
				ownerid = INVALID_PLAYER_ID;
			foreach(new i : Player) {
				if(houseid == PlayerInfo[i][pHouseKey]) {
					ownerid = i;
					break;
				}
			}
			if(ownerid == INVALID_PLAYER_ID) 	return 1;
			if(!IsPlayerAlive(ownerid)) 		return 1;

			SendClientMessage(ownerid, COLOR_YELLOW, "[SMS] Netko obija Vasu kucu! Pozurite se do nje i sprijecite provalu, poslao: Kucni alarm");
		}
	}
	Bit1_Set(gr_HouseAlarm, houseid, true);
	return 1;
}

stock ResetHouseInfo(houseid)
{
	HouseInfo[houseid][hSQLID]				= -1;
	HouseInfo[houseid][hEnterX]				= 0.0;
	HouseInfo[houseid][hEnterY]				= 0.0;
	HouseInfo[houseid][hEnterZ]				= 0.0;
	HouseInfo[houseid][hExitX] 				= 0.0;
	HouseInfo[houseid][hExitY] 				= 0.0;
	HouseInfo[houseid][hExitZ] 				= 0.0;
	HouseInfo[houseid][hEnterCP] 			= -1;
 	HouseInfo[houseid][hOwnerID]            = 0;
	format(HouseInfo[houseid][hAdress], 	32, "None");
	HouseInfo[houseid][hValue]				= 0;
	HouseInfo[houseid][hInt]				= 0;
	HouseInfo[houseid][hVirtualWorld] 		= 0;
	HouseInfo[houseid][hLock] 				= 0;
	HouseInfo[houseid][hRent]				= 0;
	HouseInfo[houseid][hRentabil] 			= 0;
	HouseInfo[houseid][hTakings] 			= 0;
	HouseInfo[houseid][hLevel] 				= 0;
	HouseInfo[houseid][hFreeze	] 			= 0;
	HouseInfo[houseid][h3dViwo] 			= 0;
	HouseInfo[houseid][hSafeStatus] 		= 0;
	HouseInfo[houseid][hSafePass] 			= 0;
	HouseInfo[houseid][hSafe]				= 0;
	HouseInfo[houseid][hOrmar]				= 0;
	HouseInfo[houseid][hSkin1] 				= 0;
	HouseInfo[houseid][hSkin2] 				= 0;
	HouseInfo[houseid][hSkin3] 				= 0;
	HouseInfo[houseid][hGroceries] 			= 0;
	HouseInfo[houseid][hDoorLevel]			= 0;
	HouseInfo[houseid][hAlarm]				= 0;
	HouseInfo[houseid][hLockLevel] 			= 0;

	if(Bit1_Get(gr_HouseAlarm, houseid)) {
		GangZoneDestroy(HouseAlarmZone[houseid]);
		KillTimer(GlobalZoneT[houseid]);
		Bit1_Set(gr_HouseAlarm, houseid, false);
	}
	KillTimer(GlobalMapIconT[houseid]);
}

Public: ResetHouseEnumerator()
{
	for(new i=0; i<MAX_HOUSES; i++)
		ResetHouseInfo(i);
	return 1;
}

stock BuyHouse(playerid, bool:credit_activated = false)
{
	new house =  Bit16_Get(gr_PlayerInfrontHouse, playerid);
	// Houses Sets
	PlayerInfo[playerid][pHouseKey] = house;
	PlayerInfo[playerid][pSpawnChange] = 1;
	HouseInfo[house][hOwnerID] 		= PlayerInfo[playerid][pSQLID];
	//BizzInfo[2][bTill] += HouseInfo[house][hValue];

	// MySQL
	new tmpQuery[128];
	format(tmpQuery, 128, "UPDATE `houses` SET `ownerid` = '%d' WHERE `id` = '%d'",
		HouseInfo[house][hOwnerID],
		HouseInfo[house][hSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery);
	
	format(tmpQuery, 128, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
		PlayerInfo[playerid][pSpawnChange],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Spawn Vam je automatski prebacen na kupljenu kucu.");
	
	// Money
	new price = HouseInfo[house][hValue];
	if(credit_activated)
		price -= CreditInfo[playerid][cAmount];
	PlayerToBudgetMoney(playerid, price); // Novac ide u proracun od kupnje kuce na /buy
	SetPlayerSpawnInfo(playerid);

	// Player Sets
	SetPlayerPos(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]);
	SetPlayerInterior(playerid, HouseInfo[house][hInt]);
	SetPlayerVirtualWorld(playerid, HouseInfo[house][hVirtualWorld]);
	Bit16_Set(gr_PlayerInHouse, playerid, house);
	PlayerInfo[playerid][pSpawnChange] = 1;
	
	format(tmpQuery, 128, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
		PlayerInfo[playerid][pSpawnChange],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery);

	// Message
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukucajte /help da bi ste vidjeli sve komande vezane uz kucu !");
	return 1;
}

stock static GetLastHouseSQLID()
{
	new id = -1;
	foreach(new h : Houses)
	{
		if(HouseInfo[h][hSQLID] == 0) return id;
	}
	return id;
}

stock static RemoveHouse(houseid)
{
	if(houseid == INVALID_HOUSE_ID) return 0;
	// MySQL
	new
		tmpQuery[64];
	format(tmpQuery, 64, "DELETE FROM `houses` WHERE `id` = '%d'", HouseInfo[houseid][hSQLID]);
	mysql_tquery(g_SQL, tmpQuery);
	// Iter & Enum
	ResetHouseInfo(houseid);
	Iter_Remove(Houses, houseid);
	return 1;
}

/*
	d8888b. d888888b  .o88b. db   dD      db       .d88b.   .o88b. db   dD
	88  `8D   `88'   d8P  Y8 88 ,8P'      88      .8P  Y8. d8P  Y8 88 ,8P'
	88oodD'    88    8P      88,8P        88      88    88 8P      88,8P
	88~~~      88    8b      88`8b        88      88    88 8b      88`8b
	88        .88.   Y8b  d8 88 `88.      88booo. `8b  d8' Y8b  d8 88 `88.
	88      Y888888P  `Y88P' YP   YD      Y88888P  `Y88P'   `Y88P' YP   YD
*/
stock static ResetLockPickVars(playerid)
{
	if(!Bit1_Get(gr_PlayerPickLocking, playerid)) return 1;

	// Floats
	PickLockMaxValue[playerid][0] = 0.0;
	PickLockMaxValue[playerid][1] = 0.0;
	PickLockMaxValue[playerid][2] = 0.0;

	// Ints
	PickLockTimeC[playerid] = 0;

	// Rest
	KillTimer(PickLockTimer[playerid]);
	KillTimer(PlayerPickLockTimer[playerid]);
	DestroyPickLockTDs(playerid);

	Bit1_Set(gr_PlayerPickLocking, 	playerid, false);
	Bit2_Set(gr_SkinSlot, 				playerid, 0);
	Bit2_Set(gr_PlayerPickSlot,		playerid, 3);

	DestroyPlayerProgressBar(playerid, 	PickLockBars[playerid][0]);
	DestroyPlayerProgressBar(playerid, 	PickLockBars[playerid][1]);
	DestroyPlayerProgressBar(playerid, 	PickLockBars[playerid][2]);
	return 1;
}

stock static DestroyPickLockTDs(playerid)
{
	if(PicklockBcg[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PicklockBcg[playerid]);
		PicklockBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(Picklock1Done[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, Picklock1Done[playerid]);
		Picklock1Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(Picklock2Done[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, Picklock2Done[playerid]);
		Picklock2Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(Picklock3Done[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, Picklock3Done[playerid]);
		Picklock3Done[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(PickLockTimeTitle[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PickLockTimeTitle[playerid]);
		PickLockTimeTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(PickLockTime[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PickLockTime[playerid]);
		PickLockTime[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreatePickLockTDs(playerid)
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

stock static UpdatePickLockTD(playerid, slot, result)
{
	new
		tmpString[8];
	if(slot == 0) {
		format(tmpString, 8, "%d", result);
		PlayerTextDrawSetString(playerid, Picklock1Done[playerid], tmpString);
	}
	else if(slot == 1) {
		format(tmpString, 8, "%d", result);
		PlayerTextDrawSetString(playerid, Picklock2Done[playerid], tmpString);
	}
	else if(slot == 2) {
		format(tmpString, 8, "%d", result);
		PlayerTextDrawSetString(playerid, Picklock3Done[playerid], tmpString);
	}
	return 1;
}

stock static IsDoorUnlocked(playerid)
{
	if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][0]) >= PickLockMaxValue[playerid][0] &&
		GetPlayerProgressBarValue(playerid, PickLockBars[playerid][1]) >= PickLockMaxValue[playerid][1] &&
		GetPlayerProgressBarValue(playerid, PickLockBars[playerid][2]) >= PickLockMaxValue[playerid][2])
		return 1;
	return 0;
}

stock static SetPlayerPickLock(playerid)
{
	TogglePlayerControllable(playerid, false);
	CreatePickLockTDs(playerid);

	new
		value,
		time,
		house = Bit16_Get(gr_PlayerInfrontHouse, playerid);

	switch(HouseInfo[house][hLockLevel]) {
		case 2: { value = 40; time = 85; }
		case 3: { value = 60; time = 100; }
	}

	Bit2_Set(gr_PlayerPickSlot, 	playerid, 0		);
	Bit1_Set(gr_PlayerPickLocking, playerid, true 	);

	PickLockMaxValue[playerid][0] = float(random(value)) + 1.5;
	PickLockMaxValue[playerid][1] = float(random(value)) + 1.0;
	PickLockMaxValue[playerid][2] = float(random(value)) + 1.5;

	PickLockTimeC[playerid] = time;
	PickLockTimer[playerid] = SetTimerEx("PicklockTime", 1000, true, "ii", playerid, house);

	new
		tmpString[10];
	valstr(tmpString, time, false);
	PlayerTextDrawSetString(playerid, PickLockTime[playerid], tmpString);

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

	PlayerPickLockTimer[playerid] = SetTimerEx("PickLockTimerFunction", 800, true, "i", playerid);
	return 1;
}

/*
	d88888b  .d88b.   .d88b.  d888888b      d88888b d8b   db d888888b d88888b d8888b.
	88'     .8P  Y8. .8P  Y8. `~~88~~'      88'     888o  88 `~~88~~' 88'     88  `8D
	88ooo   88    88 88    88    88         88ooooo 88V8o 88    88    88ooooo 88oobY'
	88~~~   88    88 88    88    88         88~~~~~ 88 V8o88    88    88~~~~~ 88`8b
	88      `8b  d8' `8b  d8'    88         88.     88  V888    88    88.     88 `88.
	YP       `Y88P'   `Y88P'     YP         Y88888P VP   V8P    YP    Y88888P 88   YD
*/
stock static ResetDoorKickingVars(playerid)
{
	DestroyFootEnterTDs(playerid);
	DestroyPlayerProgressBar(playerid, FootKickingBar[playerid]);
	Bit1_Set(gr_PlayerFootKicking, playerid, false);
}

stock static DestroyFootEnterTDs(playerid)
{
	if(FootKickingBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, FootKickingBcg1[playerid]);
		FootKickingBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(FootKickingBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, FootKickingBcg2[playerid]);
		FootKickingBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(FootKickingText[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, FootKickingText[playerid]);
		FootKickingText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreateFootEnterTDs(playerid)
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

stock static SetPlayerFootEntering(playerid)
{
	// Text
	CreateFootEnterTDs(playerid);
	FootKickingBar[playerid] = CreatePlayerProgressBar(playerid, 246.000000, 330.0, 158.0, 15.0, COLOR_GREEN, 100.0, BAR_DIRECTION_RIGHT);
	ShowPlayerProgressBar(playerid, FootKickingBar[playerid]);

	// Var sets
	Bit1_Set(gr_PlayerFootKicking, playerid, true);

	// Player sets
	TogglePlayerControllable(playerid, false);
	ApplyAnimationEx(playerid, "POLICE", "Door_Kick", 3.1, 0, 1, 1, 1, 0, 1, 0);
	return 1;
}
/*
	 .o88b. d8888b.  .d88b.  db   d8b   db d8888b.  .d8b.  d8888b.
	d8P  Y8 88  `8D .8P  Y8. 88   I8I   88 88  `8D d8' `8b 88  `8D
	8P      88oobY' 88    88 88   I8I   88 88oooY' 88ooo88 88oobY'
	8b      88`8b   88    88 Y8   I8I   88 88~~~b. 88~~~88 88`8b
	Y8b  d8 88 `88. `8b  d8' `8b d8'8b d8' 88   8D 88   88 88 `88.
	 `Y88P' 88   YD  `Y88P'   `8b8' `8d8'  Y8888P' YP   YP 88   YD
*/
		
stock IsPlayerNearHouse(playerid)
{
	foreach(new houseid: Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]))
			return houseid;
	}
	return 0;
}
	
stock SetPlayerCrowbarBreaking(playerid)
{
	// Vars
	Bit1_Set(gr_CrowbarBreaking, playerid, true);

	new
		keyTime,
		wholeTime,
		result;

	switch(HouseInfo[Bit16_Get(gr_PlayerInfrontHouse, playerid)][hDoorLevel]) {
		case 0 .. 3: 	{ keyTime = 1500; 	wholeTime = 125;  result = 50; }
		case 4: 		{ keyTime = 1000; 	wholeTime = 145;  result = 80; }
		case 5: 		{ keyTime = 800; 	wholeTime = 170;  result = 100; }
	}

	SetPlayerKeyInput(playerid, result, keyTime, wholeTime, 1);
	TogglePlayerControllable(playerid, false);
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
///////////////////////////////////////////////////////////////////
forward PickLockTimerFunction(playerid);
public PickLockTimerFunction(playerid)
{
	if(!Bit1_Get(gr_PlayerPickLocking, playerid))
		KillTimer(PlayerPickLockTimer[playerid]);

	new
		slot = Bit2_Get(gr_PlayerPickSlot, playerid);

	if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) < 0.0) return 1;
	if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot]) return 1;

	SetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot], GetPlayerProgressBarValue(playerid, PickLockBars[playerid][Bit2_Get(gr_PlayerPickSlot, playerid)]) - 0.15);

	new
		result = floatround(PickLockMaxValue[playerid][slot] - GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]));
	UpdatePickLockTD(playerid, slot, result);
	return 1;
}

timer ClosedPlayerTimer[2000](playerid)
{
	ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINSURE, DIALOG_STYLE_MSGBOX, "ODABIR SKINA", "Zelite li obuci ovaj skin?", "Pick", "Abort");
	stop PlayerClosedTimer[playerid];
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
hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new
		house = (checkpointid - 1);

	if(Iter_Contains(Houses, house)) {
		new
			textString[128];
		CreateHouseInfoTD(playerid);
		if(HouseInfo[house][hOwnerID] != 0) {
			if(HouseInfo[house][hRentabil])
				format(textString, 128, "ID: %d~n~Vlasnik: %s~n~Adresa: %s~n~Cijena: %d~g~$~n~~w~Rent: %d~g~$~n~~w~Level: %d",
					house,
					GetPlayerNameFromSQL(HouseInfo[house][hOwnerID]),
					HouseInfo[house][hAdress],
					HouseInfo[house][hValue],
					HouseInfo[house][hRent],
					HouseInfo[house][hLevel]
				);
			else
				format(textString, 128, "ID: %d~n~Vlasnik: %s~n~Adresa: %s~n~Cijena: %d~g~$~n~~w~Level: %d",
					house,
					GetPlayerNameFromSQL(HouseInfo[house][hOwnerID]),
					HouseInfo[house][hAdress],
					HouseInfo[house][hValue],
					HouseInfo[house][hLevel]
				);
		}
		else {
			format(textString, 128, "ID: %d~n~Kuca je na prodaju~n~Cijena: %d~g~$~n~~w~Level: %d~n~Alarm: %d~n~Vrata: %d",
				house,
				HouseInfo[house][hValue],
				HouseInfo[house][hLevel],
				HouseInfo[house][hAlarm],
				HouseInfo[house][hDoorLevel]
			);
			PlayerTextDrawSetString(playerid, HouseCMDTD[playerid], "Raspolozive komande:~n~      /enter, /buyhouse");
		}

		PlayerTextDrawSetString(playerid, HouseInfoTD[playerid], textString);
		PlayerHouseCP[playerid] 		= checkpointid;
		Bit16_Set(gr_PlayerInfrontHouse, playerid, house);
	}
	return 1;
}

hook OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	new
		house = (checkpointid - 1);
	if(1 <= house <= Iter_Count(Houses))
	{
		DestroyHouseInfoTD(playerid);
		PlayerHouseCP[playerid] 		= -1;
		Bit16_Set(gr_PlayerInfrontHouse, playerid, INVALID_HOUSE_ID);
	}
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/*if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE))
	{
		if(Bit1_Get(gr_PlayerRamDoor, playerid)) {
			if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return 1;
			Bit8_Set(gr_PlayerRamDoorCnt, playerid, Bit8_Get(gr_PlayerRamDoorCnt, playerid) + 1);
			ApplyAnimationEx(playerid, "CHAINSAW","WEAPON_csawlo", 4.1, 0, 0 ,0 , 0, 0, 1, 0);

			if(Bit8_Get(gr_PlayerRamDoorCnt, playerid) == 25) {
				GameTextForPlayer(playerid, "~g~Vrata su pala na pod!", 2000, 1);
				HouseInfo[Bit16_Get(gr_PlayerInfrontHouse, playerid)][hDoorCrashed] = false;
				Bit1_Set(gr_PlayerRamDoor, playerid, false);
				Bit8_Set(gr_PlayerRamDoorCnt, playerid, 0);
			}
		}
	}*/
	// Kapija za teniske terene
	// Trenutni ID: 411 - Woo, 5701 Dania Barton
 	if(newkeys == KEY_CROUCH)
    {
   		if (IsPlayerInRangeOfPoint( playerid, 10.0, 785.585754, -1152.468017, 25.328947))
		{
      		if(PlayerInfo[playerid][pSQLID] != 411 && PlayerInfo[playerid][pSQLID] != 5701)
				return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni");
		    if(wooGateStatus[0] == 0){
				MoveObject(wooGate[0], 785.585754, -1152.468017, 19.598951, 3.00);
				wooGateStatus[0] = 1;
			}
			else if(wooGateStatus[0] == 1){
				MoveObject(wooGate[0], 785.585754, -1152.468017, 25.328947, 3.00);
				wooGateStatus[0] = 0;
			}
			return true;
		}
		if (IsPlayerInRangeOfPoint( playerid, 10.0, 659.517700, -1227.184692, 16.826818))
		{
		    if(PlayerInfo[playerid][pSQLID] != 411 && PlayerInfo[playerid][pSQLID] != 5701)
				return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni");
		    if(wooGateStatus[1] == 0){
				MoveObject(wooGate[1], 659.517700, -1227.184692, 12.176794, 3.00);
				wooGateStatus[1] = 1;
			}
			else if(wooGateStatus[1] == 1){
				MoveObject(wooGate[1], 659.517700, -1227.184692, 16.826818, 3.00);
				wooGateStatus[1] = 0;
			}
			return true;
		}
		if (IsPlayerInRangeOfPoint( playerid, 10.0, 664.907043, -1309.447631, 15.290976))
		{
		    if(PlayerInfo[playerid][pSQLID] != 411 && PlayerInfo[playerid][pSQLID] != 5701)
				return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni");
		    if(wooGateStatus[2] == 0){
				MoveObject(wooGate[2], 664.907043, -1309.447631, 9.630944, 3.00);
				wooGateStatus[2] = 1;
			}
			else if(wooGateStatus[2] == 1){
				MoveObject(wooGate[2], 664.907043, -1309.447631, 15.290976, 3.00);
				wooGateStatus[2] = 0;
			}
			return true;
		}
	}
	
    if( PRESSED(KEY_NO) )
	{
		if(entering[playerid] == 1)
		{
		    entering[playerid] = 0;
		    TogglePlayerControllable(playerid, true);
		    return 1;
		}
		else if(onexit[playerid] == 1)
		{
		    onexit[playerid] = 0;
		    TogglePlayerControllable(playerid, true);
		    return 1;
		}
	}
	
	if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT)) {
		if(Bit1_Get(gr_PlayerFootKicking, playerid)) {
			if(GetPlayerAnimationIndex(playerid) == 1189) return 1;

			new
				house = Bit16_Get(gr_PlayerInfrontHouse, playerid),
				Float:tmpHealth;

			ApplyAnimationEx(playerid, "POLICE", "Door_Kick", 3.1, 0, 1, 1, 1, 0, 1, 0);
			GetPlayerHealth(playerid, tmpHealth);

			new
				Float:healthDed 	= 0.0,
				Float:progressBar 	= 0.0;
			if(HouseInfo[house][hLockLevel] == 2) {
				healthDed 	= 0.00000001;
				progressBar = 0.10;
			}
			else if(HouseInfo[house][hLockLevel] == 3) {
				healthDed 	= 0.0000001;
				progressBar = 0.07;
			}

			SetPlayerHealth(playerid, tmpHealth - healthDed);
			SetPlayerProgressBarValue(playerid, FootKickingBar[playerid], GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) + progressBar);
			if(GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) >= 50.0) {
				if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
					PlayHouseAlarm(house);
			}

			if(GetPlayerProgressBarValue(playerid, FootKickingBar[playerid]) == 100.0) {
				HouseInfo[house][hLock] = 0;
				GameTextForPlayer(playerid, "~g~Vrata su otkljucana", 2500, 1);
				ResetDoorKickingVars(playerid);
				TogglePlayerControllable(playerid, true);
			}
			return 1;
		}
		if(Bit1_Get(gr_PlayerPickLocking, playerid)) {
			new
				slot = Bit4_Get(gr_PlayerPickSlot, playerid),
				result = floatround(PickLockMaxValue[playerid][slot] - GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]));
			UpdatePickLockTD(playerid, slot, result);

			if(GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) >= PickLockMaxValue[playerid][slot]) {
				SetPlayerProgressBarColour(playerid, PickLockBars[playerid][slot], COLOR_RED);
				HidePlayerProgressBar(playerid, PickLockBars[playerid][slot]);
				ShowPlayerProgressBar(playerid, PickLockBars[playerid][slot]);

				if(IsDoorUnlocked(playerid)) {
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste otkljucali vrata!");
					HouseInfo[Bit16_Get(gr_PlayerInfrontHouse, playerid)][hLock] = 0;
					ResetLockPickVars(playerid);
					TogglePlayerControllable(playerid, true);
				}
				return 1;
			}
			SetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot], GetPlayerProgressBarValue(playerid, PickLockBars[playerid][slot]) + 0.20);
		}
	}
	else if((newkeys & KEY_YES) && !(oldkeys & KEY_YES)) {
		if(Bit1_Get(gr_PlayerPickLocking, playerid)) {
			new
				slot = Bit4_Get(gr_PlayerPickSlot, playerid);
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

			Bit4_Set(gr_PlayerPickSlot, playerid, slot);
		}
	}
	else if((newkeys & KEY_NO) && !(oldkeys & KEY_NO)) {
		if(Bit1_Get(gr_PlayerPickLocking, playerid)) {
			new
				slot = Bit4_Get(gr_PlayerPickSlot, playerid);
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
			Bit4_Set(gr_PlayerPickSlot, playerid, slot);
		}
	}
	return 1;
}

hook OnPlayerKeyInputEnds(playerid, type, succeeded)
{
	if(type == 1 && succeeded == 1){
		new
			house = Bit16_Get(gr_PlayerInfrontHouse, playerid);
		HouseInfo[house][hLock] = 0;
		GameTextForPlayer(playerid, "~g~Vrata su otkljucana", 2500, 1);
		DisablePlayerKeyInput(playerid);
		TogglePlayerControllable(playerid, true);

		new
			rand = random(5);
		if(rand == 5 || rand == 2 || rand == 1) {
			if(!Bit1_Get(gr_PlayerHouseAlarmOff, playerid))
				PlayHouseAlarm(house);
		}
	}
    return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(AC_GetPlayerWeapon(playerid) != 25 && AC_GetPlayerWeapon(playerid) != 27)
		return 1;
	new houseid = IsPlayerNearHouse(playerid);
	if(houseid == 0 || !HouseInfo[houseid][hLock])
		return 1;
	if(GetDistanceBetweenPoints3D(HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], fX, fY, fZ) <= 2.0)
	{
		if(!IsACop(playerid))
			PlayHouseAlarm(houseid);
		new 
			tmpString[80],
			doorbreachstring[100];
		format(tmpString, sizeof(tmpString), "* Vrata su probijena sacmaricom. (( %s ))", GetName(playerid, true));
		ProxDetector(50.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		HouseInfo[houseid][hLock] = false;
		foreach(new i: Player)
		{
			if(Bit16_Get(gr_PlayerInHouse, i) == houseid)
			{
				format(doorbreachstring, sizeof(doorbreachstring), "* Cuje se intenzivni zvuk pucnja sacmarice kod vratiju. (( %s ))", GetName(playerid, true));
				ProxDetector(50.0, i, doorbreachstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				break;
			}
		}
	}
	return 1;
}
			
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_HOUSE_MAIN: {
			if(!response) return 1;
			new
				house = PlayerInfo[playerid][pHouseKey];
				
            switch(listitem)
            {
                case 0: // Weapon
                {
					if(PlayerInfo[playerid][pLevel] == 1) 
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");
					
					if(IsACop(playerid) || IsASD(playerid) ||IsFDMember(playerid)) 
						return SendClientMessage(playerid,COLOR_RED, "Ne mozes koristiti house storage ako si policajac ili FD!");
					
					if(house == INVALID_HOUSE_ID)
						return SendErrorMessage(playerid, "Niste vlasnik kuce!");
					if(HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID]) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo vlasnik kuce/najmoprimac moze uzimati/spremati oruzje!");
                    if(IsPlayerInRangeOfPoint(playerid, 40.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY],HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
                		ShowPlayerDialog(playerid,DIALOG_HOUSE_STORAGE, DIALOG_STYLE_LIST,"{3C95C2}** House Storage","{3C95C2}[1] - Pohrani oruzje\n{3C95C2}[2] - Izvadi oruzje\n{3C95C2}[3] - Kupi Stalak\n{3C95C2}[4] - Statistika\n{3C95C2}[5] - Izbrisi stalak\n{3C95C2}[6] - Sef za novac.","Pick","Exit");
					else
                	    SendClientMessage(playerid, COLOR_RED, "[GRRESKA]: Nisi u svojoj kuci!");
				}
				case 1: // ....
                    ShowPlayerDialog(playerid,DIALOG_HOUSE_UPGRADES,DIALOG_STYLE_LIST,"{3C95C2}** House Upgrades","Sef(500$)\nOrmar(500$)\nAlarm(1000$)\nVrata(1000$)\nBrava(800$)\nTelefon(500$)\nRadio(800$)\nKasa za novce(1550$)\nTV(1000$)\nMikrovalna(300$)\nStorage Alarm","Choose","Back");
				case 2:
                	ShowPlayerDialog(playerid,DIALOG_HOUSE_DOORS,DIALOG_STYLE_LIST,"Otvori/zatvori","Otvori kucu\nZatvori kucu","Choose","Back");
				case 3:
                    ShowPlayerDialog(playerid,DIALOG_HOUSE_RENT,DIALOG_STYLE_LIST,"MOGUCNOST NAJMA","Kuca ima najam\nKuca nema najam\nCijena najma","Choose","Back");
				case 4:
                    ShowPlayerDialog(playerid,DIALOG_HOUSE_RENTERS,DIALOG_STYLE_LIST,"IZBACI PODSTANARE","Izbaci jednog\nIzbaci sve","Choose","Back");
				case 5:
				{
				    if(IsPlayerInRangeOfPoint(playerid, 25.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY],HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
				    {
				        if(HouseInfo[house][hOrmar])
							ShowPlayerDialog(playerid,DIALOG_HOUSE_ORMAR,DIALOG_STYLE_LIST,"KUCA - ORMAR","Stavi trenutni skin u ormar\nUdji u ormar\nIzbaci skin iz ormara","Choose","Back");
						else
							SendClientMessage(playerid, COLOR_RED, "Nemas ormar u kuci!");
                    }
                    else
						SendClientMessage(playerid, COLOR_RED, "Nisi u svojoj kuci!");
                }
                case 6:
                    ShowPlayerDialog(playerid,DIALOG_HOUSE_STUFF,DIALOG_STYLE_LIST,"KUCA - KUHINJA","Spremi namirnice u kucu\nOtvori hladnjak i uzmi nesto za jesti","Choose","Back");
                case 7:
                    ShowHouseInfo(playerid, house);
				case 8:
				    va_ShowPlayerDialog(playerid,DIALOG_HOUSE_SELL,DIALOG_STYLE_LIST,"ZELITE LI STVARNO PRODATI KUCU ZA %d$?","Ne\nDa","Choose","Back", (HouseInfo[house][hValue] / 2));
				case 9:
				    ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PLAYER, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "U prazni prostor ispod unesite ID igraca", "Sell", "Close");
            }
			return 1;
		}
		case DIALOG_SELL_HOUSE_PLAYER:
		{
		    if(response)
		    {
		        new pID = strval(inputtext),
					houseid = PlayerInfo[playerid][pHouseKey];
					
				if(houseid == 9999)
					return 0;

				if(!IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti blizu vase kuce!");
				if(!IsPlayerConnected(pID) || !SafeSpawned[pID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije sigurno spawnan/online!");
				if(!ProxDetectorS(5.0, playerid, pID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
				if(PlayerInfo[pID][pHouseKey] != INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac vec ima kucu!");
				GlobalSellingPlayerID[playerid] 	= pID;
				ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce", "Input", "Close");
		    }
			return 1;
		}
		case DIALOG_SELL_HOUSE_PRICE: {
			if(!response) return 1;

			new
				housePrice = strval(inputtext),
				pID = GlobalSellingPlayerID[playerid];

			if(housePrice > 9999999 || housePrice < 1000) return ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce\nCijena kuce ne moze biti manja od 10000$, a veca od 9999999$", "Input", "Close");

			if(AC_GetPlayerMoney(pID) < housePrice) return ShowPlayerDialog(playerid, DIALOG_SELL_HOUSE_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASE KUCE IGRACU", "Unesite cijenu vase kuce\nIgrac nema dovoljno novca za kupovinu vase kuce", "Input", "Close");

			GlobalSellingPrice[pID] 	= housePrice;
			GlobalSellingPlayerID[pID] 	= playerid;
			va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste ponudili vasu kucu igracu %s za %d$", GetName(pID), housePrice);

			new
				string[85];
			format(string, sizeof(string), "Igrac %s vam je ponudio da kupite njegovu kucu za %d", GetName(playerid), housePrice);
			ShowPlayerDialog(pID, DIALOG_SELL_HOUSE_PLAYER_2, DIALOG_STYLE_MSGBOX, "PONUDA ZA KUPOVINU KUCE", string, "Buy", "Close");
			return 1;
		}
		case DIALOG_SELL_HOUSE_PLAYER_2:
		{
		    if(response)
		    {
		        new pID = GlobalSellingPlayerID[playerid],
		            housePrice = GlobalSellingPrice[playerid];
					
				if(AC_GetPlayerMoney(playerid) < housePrice) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupovinu ove kuce.");	

				PlayerInfo[playerid][pHouseKey] 	= PlayerInfo[pID][pHouseKey];
				PlayerInfo[pID][pHouseKey] 			= INVALID_HOUSE_ID;
				PlayerInfo[playerid][pSpawnChange]	= 1;
				PlayerInfo[pID][pSpawnChange]		= 0;
				PlayerInfo[playerid][FurnPremium] = 0;
				HouseInfo[PlayerInfo[playerid][pHouseKey]][hOwnerID] = PlayerInfo[playerid][pSQLID];

				new tmpQuery[128];
				format(tmpQuery, 128, "UPDATE `houses` SET `ownerid` = '%d' WHERE `id` = '%d'",
					HouseInfo[PlayerInfo[playerid][pHouseKey]][hOwnerID],
					HouseInfo[PlayerInfo[playerid][pHouseKey]][hSQLID]
				);
				mysql_tquery(g_SQL, tmpQuery);
				
				// Spawn Change Seller & Buyer
				format(tmpQuery, 128, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
					PlayerInfo[pID][pSpawnChange],
					PlayerInfo[pID][pSQLID]
				);
				mysql_tquery(g_SQL, tmpQuery);
				SetPlayerSpawnInfo(pID);
				
				format(tmpQuery, 128, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
					PlayerInfo[playerid][pSpawnChange],
					PlayerInfo[playerid][pSQLID]
				);
				mysql_tquery(g_SQL, tmpQuery);
				SetPlayerSpawnInfo(playerid);
				
				// Money
				PlayerToPlayerMoneyTAX (playerid, pID, housePrice, true, LOG_TYPE_HOUSESELL);
				
				
				// Messages
				va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste kupili kucu od %s za %d$", GetName(pID), housePrice);
				va_SendClientMessage(pID, COLOR_YELLOW, "Igrac %s je kupio od vas kucu za %d", "Ok", "", GetName(playerid), housePrice);

				GlobalSellingPrice[playerid] 	= 0;
				GlobalSellingPlayerID[pID] 		= INVALID_PLAYER_ID;

				#if defined MODULE_LOGS
				Log_Write("/logfiles/buy_house.txt", "(%s) %s(%s) bought a house on adress %s[SQLID:%d] from %s(%s) for %d$.",
					ReturnDate(),
					GetName(playerid, false),
					GetPlayerIP(playerid),
					HouseInfo[PlayerInfo[playerid][pHouseKey]][hAdress],
					HouseInfo[PlayerInfo[playerid][pHouseKey]][hSQLID],
					GetName(pID, false),
					GetPlayerIP(pID),
					housePrice
				);
				#endif
		    }
			return 1;
		}
		case DIALOG_HOUSE_SEF: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
			switch (listitem) {
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
				bouse = PlayerInfo[playerid][pHouseKey],
				length = strval(inputtext);

			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
			
			if (length < 1 || length > AC_GetPlayerMoney(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u ruci!");
			if(length > 25000) return SendClientMessage(playerid,COLOR_RED,"Mozes staviti maksimalno 25.000$!");
			if (!IsPlayerInRangeOfPoint(playerid,100,HouseInfo[bouse][hExitX],HouseInfo[bouse][hExitY],HouseInfo[bouse][hExitZ])) return SendClientMessage(playerid, COLOR_RED, "Predaleko ste od kuce !");
			if((HouseInfo[bouse][hTakings] + length) >= 25000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalna kolicina novca je 25.000$!");

			PlayerToHouseMoney(playerid, bouse, length); // Novac ide u kucu od igraca

			new tmpString[68];
			format(tmpString, sizeof(tmpString), "[ ! ] Stavili ste $%d u vasu kucu, sada imate ukupno: $%d.",
				length,
				HouseInfo[bouse][hTakings]
			);
			SendClientMessage(playerid, COLOR_RED, tmpString);
			
			#if defined MODULE_LOGS
			new playerip[MAX_PLAYER_IP];
			GetPlayerIp(playerid, playerip, sizeof(playerip));
			Log_Write("/logfiles/a_house_cash.txt", "(%s) %s(%s) put %d$ in house on adress %s[SQLID: %d].",
				ReturnDate(),
				GetName(playerid, false), 
				playerip, 
				length, 
				HouseInfo[bouse][hAdress],
				HouseInfo[bouse][hSQLID]
			);
			#endif
			return 1;
		}
		case DIALOG_HOUSE_WITHDRAW:
		{
			new bouse = PlayerInfo[playerid][pHouseKey],
				length = strval(inputtext);

			if(!response) return ShowPlayerDialog(playerid,DIALOG_HOUSE_SEF,DIALOG_STYLE_LIST,"KUCNI SEF","Sakrij novac u kucu\nPodigni novac iz kuce","Choose","Back");
			if (length >  HouseInfo[bouse][hTakings] || length < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u kucnom fondu!");
			if (!IsPlayerInRangeOfPoint(playerid,100,HouseInfo[bouse][hExitX],HouseInfo[bouse][hExitY],HouseInfo[bouse][hExitZ])) return SendClientMessage(playerid, COLOR_RED, "Predaleko ste od kuce !");
			HouseToPlayerMoney(playerid, bouse, length); // Novac iz kuce ide igracu

			new
				tmpString[70];

			format(tmpString, sizeof(tmpString), "[ ! ] Uzeli ste  $%d iz vase kuce, sada imate ukupno: $%d.", length,HouseInfo[bouse][hTakings]);
			SendClientMessage(playerid, COLOR_RED, tmpString);
			
			#if defined MODULE_LOGS
			new playerip[MAX_PLAYER_IP];
			GetPlayerIp(playerid, playerip, sizeof(playerip));
			Log_Write("/logfiles/a_house_cash.txt", "(%s) %s(%s) took %d$ from house on adress %s[SQLID: %d].",
				ReturnDate(),
				GetName(playerid, false), 
				playerip, 
				length, 
				HouseInfo[bouse][hAdress],
				HouseInfo[bouse][hSQLID]
			);
			#endif
			return 1;
		}
		case DIALOG_HOUSE_GUNSEF: {
			new
				house = PlayerInfo[playerid][pHouseKey];

			if(!response) return ShowPlayerDialog(playerid,DIALOG_HOUSE_SEF,DIALOG_STYLE_LIST,"KUCNI SEF","Sakrij novac u kucu\nPodigni novac iz kuce","Choose","Back");
			if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema sef!");

            switch(listitem)
            {
                case 0://Otkljucaj sef-izbacuje dialog da upises sifru
                	ShowPlayerDialog(playerid, DIALOG_HOUSE_UNLOCK, DIALOG_STYLE_INPUT, "KUCNI SEF", "Upisi trenutnu sifru da otkljucas sef!", "Next", "Back");
                case 1://Zakljucaj sef-ne treba sifra
                {
			        ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
			        HouseInfo[house][hSafeStatus] = 0;
	              	GameTextForPlayer(playerid, "~g~Sef zakljucan", 1000, 1);
                }
				case 2://info, odmah izbacuje sta ima unutra
				{
                	if(!HouseInfo[house][hSafeStatus]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate prvo otkljucati sef da bi ste mogli viditi njegov sadrzaj.");

                    SendClientMessage(playerid, COLOR_RED, "[ ! ]___________________ {FA5656}KUCNI SEF ___________________|");
					va_SendClientMessage(playerid, COLOR_WHITE, "U sefu je pohranjeno %s.", FormatNumber(HouseInfo[house][hMoneySafe]));
                }
				case 3://izbacuje dialog da upises novu sifru!
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_CHANGEPASS, DIALOG_STYLE_INPUT, "NOVA SIFRA SEFA", "Upisi novu sifru!", "Next", "Back");
            }
			return 1;
		}
		case DIALOG_HOUSE_CHANGEPASS: {
			new
				house = PlayerInfo[playerid][pHouseKey],
				pass = strval(inputtext);

			if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_GUNSEF,DIALOG_STYLE_LIST,"KUCNI SEF","Otkljucaj\nZakljucaj\nInfo\nPromjeni sifru","Choose","Back");

            if(house == INVALID_HOUSE_ID && HouseInfo[house][hOwnerID] != PlayerInfo[playerid][pSQLID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo vlasnik moze mijenjati sifru sefa!");

			if(!IsPlayerInRangeOfPoint(playerid, 20.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Predaleko ste od kuce!");

			if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate sef!");
			if(pass > 999999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sifra mora biti u brojevima i moze se sastojati najvise od 6 znamenki!");
		    if(!IsNumeric(inputtext)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate korisitit samo brojeve!");


			// Enum set
			HouseInfo[house][hSafePass] = pass;

			// MySQL
			new
				cpassQuery[128],
				cpassString[27];

			format(cpassQuery, sizeof(cpassQuery), "UPDATE `houses` SET `safepass` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSafePass], HouseInfo[house][hSQLID]);
			mysql_tquery(g_SQL, cpassQuery);

			// Players
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant",4.1, 0, 0, 0, 0, 0, 1, 0);
			GameTextForPlayer(playerid, "~g~Sifra je promjenjena", 1000, 1);
			format(cpassString, sizeof(cpassString), "[ ! ] Nova sifra: %d", HouseInfo[house][hSafePass]);
			SendClientMessage(playerid, COLOR_RED, cpassString);
			return 1;
		}
		case DIALOG_HOUSE_UNLOCK: {

			new
				house = PlayerInfo[playerid][pHouseKey],
				pass = strval(inputtext);

			if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_GUNSEF,DIALOG_STYLE_LIST,"KUCNI SEF","Otkljucaj\nZakljucaj\nInfo\nPromjeni sifru","Choose","Back");
			if (!IsPlayerInRangeOfPoint(playerid, 20.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Predaleko ste od kuce !");
			if(!HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete sef!");
			if(HouseInfo[house][hSafeStatus]) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Sef je vec otvoren!");
			if(pass != HouseInfo[house][hSafePass]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sifra je pogresna!");

			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1, 0);
			HouseInfo[house][hSafeStatus] = 1;
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Sifra potvrdjena. Sef je otvoren!");
			return 1;
		}
		case DIALOG_HOUSE_UPGRADES: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
			new
				house = PlayerInfo[playerid][pHouseKey],
				huQuery[128];

            switch(listitem)
            {
				case 0: { // Sef
				    if(HouseInfo[house][hSafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca vec ima kupljen sef!");
					if(AC_GetPlayerMoney(playerid) < 500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca.");

					HouseInfo[house][hSafe] = 1;
					PlayerToBudgetMoney(playerid, 500); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Vasa kuca sada ima sef u koji mozete sakriti sirovine, drogu i oruzje.");
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `safe` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSafe], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 1: { // Ormar
				    if(HouseInfo[house][hOrmar]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca vec ima kupljen ormar!");
					if(AC_GetPlayerMoney(playerid) < 500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to.");
					HouseInfo[house][hOrmar] = 1;
					PlayerToBudgetMoney(playerid, 500); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Sada mozete koristiti ormar.");
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `ormar` = '%d' WHERE `id` = '%d'", HouseInfo[house][hOrmar], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 2: { // Alarm
					if(HouseInfo[house][hAlarm] == 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level alarma!");
					if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to.(1000$)");

					HouseInfo[house][hAlarm]++;
					PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Alarm level ++", 1000, 1);
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `alarm` = '%d' WHERE `id` = '%d'", HouseInfo[house][hAlarm], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 3: { // Vrata
					if(HouseInfo[house][hDoorLevel] == 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level vrata! ");
					if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (1000$).");
					HouseInfo[house][hDoorLevel] ++;
					PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Door level ++", 1000, 1);
                    format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `doorlevel` = '%d' WHERE `id` = '%d'", HouseInfo[house][hDoorLevel], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 4: { // Brava
					if(HouseInfo[house][hLockLevel] == 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate najveci moguci level brave!");
					if(AC_GetPlayerMoney(playerid) < 800) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (800$).");
					HouseInfo[house][hLockLevel] ++;
					PlayerToBudgetMoney(playerid, 800); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Lock level ++", 1000, 1);
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `locklevel` = '%d' WHERE `id` = '%d'", HouseInfo[house][hLockLevel], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 5: { // Telefon
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno nedostupno!");
				}
				case 6: { // Radio
					if(HouseInfo[house][hRadio]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete radio!");
					if(AC_GetPlayerMoney(playerid) < 800) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (500$).");
					HouseInfo[house][hRadio] = 1;
					PlayerToBudgetMoney(playerid, 800); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Kupljen novi radio", 1000, 1);
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `radio` = '%d' WHERE `id` = '%d'", HouseInfo[house][hRadio], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 7: { // Kasa za novac
					if(HouseInfo[house][hMoneySafe]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete kasu za novce!");
					if(AC_GetPlayerMoney(playerid) < 1550) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (1550$).");
					HouseInfo[house][hMoneySafe] = 1;
					PlayerToBudgetMoney(playerid, 1550); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Kupljena nova kasa za novac", 1000, 1);
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `moneysafe` = '%d' WHERE `id` = '%d'", HouseInfo[house][hMoneySafe], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 8: { // TV
					if(HouseInfo[house][hTV]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete televiziju!");
					if(AC_GetPlayerMoney(playerid) < 1000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (500$).");
					HouseInfo[house][hTV] = 1;
					PlayerToBudgetMoney(playerid, 1000); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Kupljen novi tv", 1000, 1);
					BizzInfo[85][bTill] += 500;
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `tv` = '%d' WHERE `id` = '%d'", HouseInfo[house][hTV], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 9: { // Mikrovalna
					if(HouseInfo[house][hMicrowave]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete mikrovalnu!");
					if(AC_GetPlayerMoney(playerid) < 300) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupiti to (300$).");
					HouseInfo[house][hMicrowave] = 1;
					PlayerToBudgetMoney(playerid, 300); // Novac ide u proracun
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					GameTextForPlayer(playerid, "~g~Kupljen nova mikrovalna", 1000, 1);
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `microwave` = '%d' WHERE `id` = '%d'", HouseInfo[house][hMicrowave], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
				case 10: { // Storage Alarm -> storage_alarm
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
						
					format(huQuery, sizeof(huQuery), "UPDATE `houses` SET `storage_alarm` = '%d' WHERE `id` = '%d'", HouseInfo[house][hStorageAlarm], HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, huQuery);
				}
            }
			return 1;
		}
		case DIALOG_HOUSE_DOORS: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
			switch(listitem)
            {
                case 0: { // Otkljucaj
                	new
						house = Bit16_Get(gr_PlayerInHouse, playerid);
					if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred ulaznih vrata!");
					if(IsPlayerInRangeOfPoint(playerid, 8.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
					{
						if(PlayerInfo[playerid][pHouseKey] == house) {
							HouseInfo[house][hLock] = 0;
							GameTextForPlayer(playerid, "~w~Vrata ~g~otkljucana", 5000, 6);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							return 1;
						} else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");
					}
					else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
					{
						if(PlayerInfo[playerid][pHouseKey] == house) {
							HouseInfo[house][hLock] = 0;
							GameTextForPlayer(playerid, "~w~Vrata ~g~otkljucana", 5000, 6);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							return 1;
						} else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");
					}
                }
                case 1: { // Zakljucaj
                    new
						house = Bit16_Get(gr_PlayerInHouse, playerid);
					if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred ulaznih vrata!");
					if(IsPlayerInRangeOfPoint(playerid, 8.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
					{
						if(PlayerInfo[playerid][pHouseKey] == house) {
							HouseInfo[house][hLock] = 1;
							GameTextForPlayer(playerid, "~w~Vrata ~r~zakljucana", 5000, 6);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							return 1;
						} else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");
					}
					else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
					{
						if(PlayerInfo[playerid][pHouseKey] == house) {
							HouseInfo[house][hLock] = 1;
							GameTextForPlayer(playerid, "~w~Vrata ~r~zakljucana", 5000, 6);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							return 1;
						} else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kljuc!");
					}
                }
            }
			return 1;
		}
		case DIALOG_HOUSE_RENT: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
				
			new
				house = PlayerInfo[playerid][pHouseKey];
			switch(listitem)
            {
                case 0: { // Mogu iznajmljivati
					HouseInfo[house][hRentabil] = 1;
					
					new
						rentQuery[128];
					format(rentQuery, 128, "UPDATE `houses` SET `rentabil` = '1' WHERE `id` = '%d'", HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, rentQuery, "", "");
					
					GameTextForPlayer(playerid, "~g~Kuca stavljena na iznajmljivanje", 1000, 1);
                }
                case 1:  { // Nece moci iznajmljivati

	                HouseInfo[house][hRentabil] = 0;
					
					new
						rentQuery[128];
					format(rentQuery, 128, "UPDATE `houses` SET `rentabil` = '0' WHERE `id` = '%d'", HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, rentQuery, "", "");
					
	                GameTextForPlayer(playerid, "~r~Kuca maknuta sa iznajmljivanja", 1000, 1);
                }
                case 2:
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_RENTPRICE, DIALOG_STYLE_INPUT, "NAJAM", "Upisi novu cijenu najma!", "Next", "Back");
            }
			return 1;
		}
		case DIALOG_HOUSE_RENTPRICE: {
			if(!response)
				return
					ShowPlayerDialog(
						playerid,
						DIALOG_HOUSE_RENT,
						DIALOG_STYLE_LIST,
						"MOGUCNOST NAJMA",
						"Kuca ima najam\nKuca nema najam\nCijena najma",
						"Choose",
						"Back"
					);

			new
				renting = strval(inputtext),
				house = PlayerInfo[playerid][pHouseKey];

			if(50 <= renting <= 500) {
				HouseInfo[house][hRent] = renting;

				new
					tmpQuery[256];
				format(tmpQuery, 256, "UPDATE `houses` SET `rent` = '%d' WHERE `id` = '%d'", HouseInfo[house][hRent], HouseInfo[house][hSQLID]);
				mysql_tquery(g_SQL, tmpQuery, "", "");
				
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stanarina postavljena na $%d", HouseInfo[house][hRent]);
			} else SendClientMessage(playerid, COLOR_RED, "Minimalna cijena renta je $50, a maksimalna $500.");
			return 1;
		}
		case DIALOG_HOUSE_RENTERS: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

			switch(listitem)
            {
                case 0:
					ShowPlayerDialog(playerid, DIALOG_HOUSE_EVICT, DIALOG_STYLE_INPUT, "KUCA - PODSTANARI", "Upisi ID podstanara kojeg zelis izbacit na ulicu!", "Next", "Back");
                case 1:
                {
                    foreach(new i : Player) {
						if(PlayerInfo[i][pRentKey] == PlayerInfo[playerid][pHouseKey]) {
							SendClientMessage(i, COLOR_RED, "[ ! ] Izbaceni ste iz kuce od strane vlasnika!");
							PlayerInfo[i][pRentKey] = INVALID_HOUSE_ID;
						}
					}
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Izbacili ste sve podstanare iz kuce ((Koji su online trenutno))!");
                }
            }
			return 1;
		}
		case DIALOG_HOUSE_EVICT: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_RENTERS, DIALOG_STYLE_LIST, "IZBACI PODSTANARE", "Izbaci jednog\nIzbaci sve", "Choose", "Back");
			new
				giveplayerid = strval(inputtext);

			if (giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izbaciti samog sebe.");
			if(!IsPlayerConnected(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
			if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos id-a!");
			if(PlayerInfo[giveplayerid][pRentKey] == PlayerInfo[playerid][pHouseKey]) {
				SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Izbacen si iz kuce od strane vlasnika!");
				SendClientMessage(playerid, COLOR_RED, "[ ! ] Stanar je uspjesno izbacen na ulicu!");
				PlayerInfo[giveplayerid][pRentKey] = INVALID_HOUSE_ID;
			} else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac ne stanuje kod tebe!");
			return 1;
		}
		case DIALOG_HOUSE_STUFF: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

			new
				house 		= PlayerInfo[playerid][pHouseKey];
			switch(listitem)
            {
                case 0: { // Spremi
					if(Bit8_Get(gr_Groceries, playerid) != 0) {
					    if(HouseInfo[house][hGroceries] < 100) {
							HouseInfo[house][hGroceries] += Bit8_Get(gr_Groceries, playerid);
							GameTextForPlayer(playerid, "~g~Namirnice su spremite", 1000, 1);
							Bit8_Set(gr_Groceries, playerid, 0);
						} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Frizider vam je pun!");
					} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kupili namirnice u 24/7!");
				}
                case 1: // Jelo
                    ShowPlayerDialog(playerid, DIALOG_HOUSE_FRIDGE, DIALOG_STYLE_LIST, "Odaberi sto zelis uzeti iz frizidera!","Pivo\nSprunk\nVino\nCips","Choose","Back");
            }
			return 1;
		}
		case DIALOG_HOUSE_FRIDGE: {
			if(!response)
				return
					ShowPlayerDialog(
						playerid,
						DIALOG_HOUSE_STUFF,
						DIALOG_STYLE_LIST,
						"KUCA - KUHINJA",
						"Spremi namirnice u kucu\nOtvori hladnjak i uzmi nesto za jesti",
						"Choose",
						"Back"
					);

			new
				house 		= PlayerInfo[playerid][pHouseKey],
				drunklevel 	= GetPlayerDrunkLevel(playerid),
				Float:health,
				groString[70];

			GetPlayerHealth(playerid, health);

			switch(listitem)
			{
				case 0: {
					if(HouseInfo[house][hGroceries] >= 1)
					{
						HouseInfo[house][hGroceries]--;
						format(groString, sizeof(groString), "* %s uzima Twist Off iz hladnjaka i otvara ga.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						format(groString, sizeof(groString), "* %s naginje flasu te pocinje piti.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
						if(PlayerInfo[playerid][pHunger] < 4.8) {
							PlayerInfo[playerid][pHunger] += 0.2;
							SetPlayerDrunkLevel(playerid, drunklevel + 100);
							if(drunklevel > 2000)
								GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
						} else {
							PlayerInfo[playerid][pHunger] = 5.0;
							SetPlayerDrunkLevel(playerid, drunklevel + 100);

							if (drunklevel > 2000)
								GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
						}
					} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno namirnica u frizideru!");
				}
				case 1: {
					if(HouseInfo[house][hGroceries] >= 1)
					{
						HouseInfo[house][hGroceries]--;
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
						format(groString, sizeof(groString), "* %s uzima Sprunk iz hladnjaka i otvara ga.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						format(groString, sizeof(groString), "* %s naginje tetrapak te pocinje piti.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						if(PlayerInfo[playerid][pHunger] < 4.8)
							PlayerInfo[playerid][pHunger] += 0.2;
						else
							PlayerInfo[playerid][pHunger] = 5.0;
					} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno namirnica u frizideru!");
				}
				case 2: {
					if(HouseInfo[house][hGroceries] >= 1)
					{
						HouseInfo[house][hGroceries]--;
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

						format(groString, sizeof(groString), "* %s uzima crno vino iz hladnjaka i otvara ga.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						format(groString, sizeof(groString), "* %s naginje flasu te pocinje piti.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						if(PlayerInfo[playerid][pHunger] < 4.8) {
							PlayerInfo[playerid][pHunger] += 0.2;
							SetPlayerDrunkLevel(playerid, drunklevel + 200);
							if(drunklevel > 2000)
								GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
						} else {
							PlayerInfo[playerid][pHunger] = 5.0;
							SetPlayerDrunkLevel(playerid, drunklevel + 200);
							if(drunklevel > 2000)
								GameTextForPlayer(playerid, "~p~Pijani ste", 3500, 1);
						}
					} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno namirnica u frizideru!");
				}
				case 3: {
					if(HouseInfo[house][hGroceries] >= 1)
					{
						HouseInfo[house][hGroceries] -= 1;
						format(groString, sizeof(groString), "* %s uzima cips te pocinje jesti.", GetName(playerid, true));
						ProxDetector(8.0, playerid, groString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0, 1, 0);

						if(PlayerInfo[playerid][pHunger] < 4.6)
							PlayerInfo[playerid][pHunger] += 0.4;
						else
							PlayerInfo[playerid][pHunger] = 5.0;
					} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno namirnica u frizideru!");
				}
			}
			return 1;
		}
		case DIALOG_HOUSE_SELL: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

			switch (listitem)
            {
                case 0:
					return 1;
				case 1:
				{
					new
						house	= PlayerInfo[playerid][pHouseKey],
						sellQuery[128],
						sellprice = HouseInfo[house][hValue] / 2;

					// House Enum
					HouseInfo[house][hLock] 	= 1;
					HouseInfo[house][hSafe] 	= 0;
					HouseInfo[house][hOrmar] 	= 0;
					HouseInfo[house][hOwnerID]  = 0;

					// MySQL
					format(
						sellQuery,
						sizeof(sellQuery),
						"UPDATE `houses` SET `ownerid` = '%d', `safe` = '%d', `ormar` = '%d' WHERE `id` = '%d'",
						HouseInfo[house][hOwnerID],
						HouseInfo[house][hSafe],
						HouseInfo[house][hOrmar],
						HouseInfo[house][hSQLID]);
					mysql_tquery(g_SQL, sellQuery);


					// Player
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Prodali ste svoju kucu drzavi. Dobili ste %d$ iz sefa i %d$ od drzave!", HouseInfo[house][hTakings], sellprice);
					
					BudgetToPlayerMoney(playerid, sellprice); // Igrac dobiva pola vrijednosti kuce od drzave
					HouseToPlayerMoney(playerid, house, HouseInfo[house][hTakings]); // Dobiva sav novac iz house takingsa
					
					PlayerInfo[playerid][pHouseKey] = INVALID_HOUSE_ID;
					
					// Spawn Change
					PlayerInfo[playerid][pSpawnChange] = 0;
					PlayerInfo[playerid][FurnPremium] = 0;
					new tmpQuery[128];
					format(tmpQuery, 128, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
						PlayerInfo[playerid][pSpawnChange],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, tmpQuery);

					if(GetPlayerVirtualWorld(playerid) == HouseInfo[house][hVirtualWorld])
						SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]);
				}
            }
			return 1;
		}
		case DIALOG_HOUSE_ORMAR: {
			if(!response)
				return ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");

			new	house = PlayerInfo[playerid][pHouseKey],
				skinQuery[64];
			switch(listitem)
			{
				case 0: { // Stavi skin
					if(HouseInfo[house][hSkin1] != 0 && HouseInfo[house][hSkin2] != 0 && HouseInfo[house][hSkin3] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je pun!");

					if(HouseInfo[house][hSkin1] == 0) {
						HouseInfo[house][hSkin1] = GetPlayerSkin(playerid);
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin1` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin1], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste spremili skin u slot 1!");
					}
					else if(HouseInfo[house][hSkin2] == 0) {
						HouseInfo[house][hSkin2] = GetPlayerSkin(playerid);
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin2` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin2], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste spremili skin u slot 2!");
					}
					else if(HouseInfo[house][hSkin3] == 0) {
						HouseInfo[house][hSkin3] = GetPlayerSkin(playerid);
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin3` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin3], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste spremili skin u slot 3!");
					}
				}
				case 1: { // Udi u ormar
					if(!HouseInfo[house][hSkin1] && !HouseInfo[house][hSkin2] && !HouseInfo[house][hSkin3]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je prazan!");

					// Player Gets
					GetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
					tmpInterior[playerid]		= GetPlayerInterior(playerid);
					tmpViwo[playerid]			= GetPlayerVirtualWorld(playerid);

					new
						tmpString[128];
					if(HouseInfo[house][hSkin1] != 0)
						format(tmpString, 128, "%s%d\n",
							tmpString,
							HouseInfo[house][hSkin1]
						);
					if(HouseInfo[house][hSkin2] != 0)
						format(tmpString, 128, "%s%d\n",
							tmpString,
							HouseInfo[house][hSkin2]
						);
					if(HouseInfo[house][hSkin3] != 0)
						format(tmpString, 128, "%s%d\n",
							tmpString,
							HouseInfo[house][hSkin3]
						);
					ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINCHOOSE, DIALOG_STYLE_LIST, "ORMAR - ODABIR", tmpString, "Choose", "Abort");
				}
				case 2: { // Izbaci
					if(!HouseInfo[house][hSkin1] && !HouseInfo[house][hSkin2] && !HouseInfo[house][hSkin3]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas ormar je prazan!");
					ShowPlayerDialog(
						playerid,
						DIALOG_HOUSE_REMOVESKIN,
						DIALOG_STYLE_LIST,
						"KUCA-IZBACIVANJE SKINA",
						"Slot 1\nSlot 2\nSlot 3", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_HOUSE_REMOVESKIN: {
			if(!response)
				return
					ShowPlayerDialog(playerid,
						DIALOG_HOUSE_ORMAR,
						DIALOG_STYLE_LIST,
						"KUCA - ORMAR",
						"Stavi trenutni skin u ormar\nUdji u ormar\nIzbaci skin iz ormara",
						"Choose",
						"Back"
					);

			new	house = PlayerInfo[playerid][pHouseKey],
				skinQuery[64];
			switch(listitem)
			{
				case 0: {
					if(!HouseInfo[house][hSkin1]) {
						SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 1 je prazan!");
					} else {
						HouseInfo[house][hSkin1] = 0;
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin1` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin1], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali skin iz slota 1!");
					}
				}
				case 1: {
					if(!HouseInfo[house][hSkin2]) {
						SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 2 je prazan!");
					} else {
						HouseInfo[house][hSkin2] = 0;
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin2` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin2], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali skin iz slota 1!");
					}
				}
				case 2: {
					if(!HouseInfo[house][hSkin3]) {
						SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot 3 je prazan!");
					} else {
						HouseInfo[house][hSkin3] = 0;
						format(skinQuery, sizeof(skinQuery), "UPDATE `houses` SET `skin3` = '%d' WHERE `id` = '%d'", HouseInfo[house][hSkin3], HouseInfo[house][hSQLID]);
						mysql_tquery(g_SQL, skinQuery, "", "");
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali skin iz slota 1!");
					}
				}
			}
			return 1;
		}
		case DIALOG_HOUSE_SKINSURE: {
			new
				skinString[42],
				house = PlayerInfo[playerid][pHouseKey];
			if(!response) {
				new
					tmpString[128];
				if(HouseInfo[house][hSkin1] != 0)
					format(tmpString, 128, "%s%d\n",
						tmpString,
						HouseInfo[house][hSkin1]
					);
				else if(HouseInfo[house][hSkin2] != 0)
					format(tmpString, 128, "%s%d\n",
						tmpString,
						HouseInfo[house][hSkin2]
					);
				else if(HouseInfo[house][hSkin3] != 0)
					format(tmpString, 128, "%s%d\n",
						tmpString,
						HouseInfo[house][hSkin3]
					);
				ShowPlayerDialog(playerid, DIALOG_HOUSE_SKINCHOOSE, DIALOG_STYLE_LIST, "ORMAR - ODABIR", tmpString, "Choose", "Abort");
				return 1;
			}
			// Player Sets
			new skin;
			switch(Bit2_Get(gr_SkinSlot, playerid)) {
				case 1: skin = HouseInfo[house][hSkin1];
				case 2: skin = HouseInfo[house][hSkin2];
				case 3: skin = HouseInfo[house][hSkin3];
			}
            PlayerInfo[playerid][pSkin] = skin;
			SetPlayerSkin(playerid, skin);
			SetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
			SetPlayerInterior(playerid, 		tmpInterior[playerid]);
			SetPlayerVirtualWorld(playerid,	tmpViwo[playerid]);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, true);
			ClearAnimations(playerid);

			// Message
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste se presvukli!");
			format(skinString, sizeof(skinString), "* %s se presvlaci.", GetName(playerid, true));
			ProxDetector(5.0, playerid, skinString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			return 1;
		}
		case DIALOG_HOUSE_SKINCHOOSE: {
			if(!response) {
				SetPlayerPos(playerid, tmpPos[playerid][0], tmpPos[playerid][1], tmpPos[playerid][2]);
				SetPlayerInterior(playerid, tmpInterior[playerid]);
				SetPlayerVirtualWorld(playerid, tmpViwo[playerid]);
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, true);
				ClearAnimations(playerid);

				SendClientMessage(playerid, COLOR_RED, "[ ! ] Odustali ste od odabira skina!");
				return 1;
			}
			new
				house = PlayerInfo[playerid][pHouseKey];
			switch(listitem) {
				case 0: { // Slot1
					if(HouseInfo[house][hSkin1])	{
						tmpSkin[playerid] = GetPlayerSkin(playerid);
						SetPlayerSkin(playerid, HouseInfo[house][hSkin1]);
						Bit2_Set(gr_SkinSlot, playerid, 1);

						CreatePlayerClosedScene(playerid);
					}
				}
				case 1: { // Slot2
					if(HouseInfo[house][hSkin2])	{
						tmpSkin[playerid] = GetPlayerSkin(playerid);
						SetPlayerSkin(playerid, HouseInfo[house][hSkin2]);
						Bit2_Set(gr_SkinSlot, playerid, 2);

						CreatePlayerClosedScene(playerid);
					}
				}
				case 2: { // Slot3
					if(HouseInfo[house][hSkin3])	{
						tmpSkin[playerid] = GetPlayerSkin(playerid);
						SetPlayerSkin(playerid, HouseInfo[house][hSkin3]);
						Bit2_Set(gr_SkinSlot, playerid, 3);

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
			if(CreatingHouseID[playerid] == INVALID_HOUSE_ID) return SendErrorMessage(playerid, "Niste u procesu stvaranja kuce!");
			new houseid = CreatingHouseID[playerid];
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
///////////////////////////////////////////////////////////////////
CMD:enter(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 366.544769, 158.641189, 1008.382812)) {
		SetPlayerPosEx(playerid, 1122.9961, -2036.8920, 1701.0578, 25, 2, true);
		return 1;
	}
	if(Bit1_Get(r_PlayerDoorPeek, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete uci u kucu dok virite kroz vrata!");
	new
		biznis = INVALID_BIZNIS_ID,
		pickup = -1,
		complex = INVALID_COMPLEX_ID,
		rcomplex = INVALID_COMPLEX_ID,
		viwo = GetPlayerVirtualWorld(playerid),
		interior = GetPlayerInterior(playerid);

	foreach(new i : Bizzes) {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ])) {
			biznis = i;
			break;
		}
	}
	foreach(new c : Complex) {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexInfo[c][cEnterX], ComplexInfo[c][cEnterY], ComplexInfo[c][cEnterZ])) {
			complex = c;
			break;
		}
	}
	foreach(new x : Pickups) {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PickupInfo[x][epEntrancex], PickupInfo[x][epEntrancey], PickupInfo[x][epEntrancez])) {
			pickup = x;
			break;
		}
	}
	foreach(new c : ComplexRooms)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, ComplexRoomInfo[c][cEnterX], ComplexRoomInfo[c][cEnterY], ComplexRoomInfo[c][cEnterZ]) && interior == ComplexRoomInfo[c][cIntExit] && viwo == ComplexRoomInfo[c][cVWExit] ) {
			rcomplex = c;
			break;
		}
	}
	
	if(pickup != -1) 
	{
		if(PickupInfo[pickup][epCanEnter] == 1) 
		{
			if(PlayerInfo[playerid][pMember] == PickupInfo[pickup][epOrganizations] || PlayerInfo[playerid][pLeader] == PickupInfo[pickup][epOrganizations] || PlayerInfo[playerid][pJob] == PickupInfo[pickup][epJob] || PickupInfo[pickup][epOrganizations] == 255 || PickupInfo[pickup][epJob] == 255)
			{
				/*_LoadingObjects(playerid, true); // textdraw.
				SetTimerEx("LoadingObjects", 3000, (false), "ib", playerid, (true));
				TogglePlayerControllable(playerid, (false));*/

				Bit1_Set(gr_PlayerEntering, playerid, true);
				SetPlayerPosEx(playerid,PickupInfo[pickup][epExitx],PickupInfo[pickup][epExity],PickupInfo[pickup][epExitz],PickupInfo[pickup][epViwo],PickupInfo[pickup][epInt],true);
				GameTextForPlayer(playerid, PickupInfo[pickup][epDiscription], 500, 1);
				Bit16_Set(gr_PlayerInPickup, playerid, pickup);
				
				entering[playerid] = 1;
				TogglePlayerControllable(playerid, false);
				SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
				return 1;
			}
			else GameTextForPlayer(playerid, "~r~Zakljucano", 5000, 1);
		}
	}
	else if(biznis != INVALID_BIZNIS_ID) 
	{
		if(!BizzInfo[biznis][bCanEnter]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete uci u biznis bez inta!");
		if(PlayerInfo[playerid][pBizzKey] == biznis || !BizzInfo[biznis][bLocked]) 
		{
			if(BizzInfo[biznis][bEntranceCost] != 0 && PlayerInfo[playerid][pBizzKey] != biznis) 
			{
			    if(AC_GetPlayerMoney(playerid) < BizzInfo[biznis][bEntranceCost]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca da platite ulaz!");

				PlayerToBusinessMoneyTAX(playerid, biznis, BizzInfo[biznis][bEntranceCost]); // Novac ide u blagajnu od biznisa, a oporezivi dio drZavi
			}
			if(!isnull(BizzInfo[biznis][bMusicURL])) 
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, BizzInfo[biznis][bMusicURL]);
			}
			if(BizzInfo[biznis][bFurLoaded] == false) ReloadBizzFurniture(biznis);
			
			/*
			_LoadingObjects(playerid, true); // textdraw.
			SetTimerEx("LoadingObjects", 3000, (false), "ib", playerid, (true));
			TogglePlayerControllable(playerid, (false));*/

			Bit1_Set(gr_PlayerEntering, playerid, true);
			SetPlayerPosEx(playerid, BizzInfo[biznis][bExitX], BizzInfo[biznis][bExitY], BizzInfo[biznis][bExitZ], BizzInfo[biznis][bVirtualWorld], BizzInfo[biznis][bInterior], true);
			Bit16_Set(gr_PlayerInBiznis, playerid, biznis);
			DestroyBizzInfoTD(playerid);
			
			entering[playerid] = 1;
            TogglePlayerControllable(playerid, false);
            SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
			return 1;
		} else return GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
	}
	else if(rcomplex != INVALID_COMPLEX_ID)
	{
	    if(!ComplexRoomInfo[rcomplex][cActive]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Soba nije u funkciji!");
		if(PlayerInfo[playerid][pComplexRoomKey] == rcomplex || IsOnAdminDuty(playerid) || !ComplexRoomInfo[rcomplex][cLock]) 
		{
			Bit1_Set(gr_PlayerEntering, playerid, true);
	        SetPlayerPosEx(playerid, ComplexRoomInfo[rcomplex][cExitX], ComplexRoomInfo[rcomplex][cExitY], ComplexRoomInfo[rcomplex][cExitZ], ComplexRoomInfo[rcomplex][cViwo], ComplexRoomInfo[rcomplex][cInt], true);
            Bit16_Set(gr_PlayerInRoom, playerid, rcomplex);
			if(PlayerInfo[playerid][pComplexRoomKey] == rcomplex)
			    GameTextForPlayer(playerid, "Dobrodosli!", 500, 1);
		}
		else return GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
		return 1;
	}
	else if(complex != INVALID_COMPLEX_ID) 
	{
	/*
		_LoadingObjects(playerid, true); // textdraw.
		SetTimerEx("LoadingObjects", 3000, (false), "ib", playerid, (true));
		TogglePlayerControllable(playerid, (false));*/
		
		Bit1_Set(gr_PlayerEntering, playerid, true);
        SetPlayerPosEx(playerid, ComplexInfo[complex][cExitX], ComplexInfo[complex][cExitY], ComplexInfo[complex][cExitZ], ComplexInfo[complex][cViwo], ComplexInfo[complex][cInt], true);
		Bit16_Set(gr_PlayerInComplex, playerid, complex);
		if(PlayerInfo[playerid][pComplexKey] == complex)
		    GameTextForPlayer(playerid, "Dobrodosli u svoj Complex!", 500, 1);
		    
        entering[playerid] = 1;
		TogglePlayerControllable(playerid, false);
		SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
		return 1;
	}
	else if(rob_started[playerid] == true) {
		PlayStorageAlarm(playerid, false);
	}
	else if(IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) 
	{
		if(Bit16_Get(gr_PlayerInfrontHouse, playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
		new
			house = Bit16_Get(gr_PlayerInfrontHouse, playerid);
		if(HouseInfo[house][h3dViwo] == GetPlayerVirtualWorld(playerid)) 
		{
			if(HouseInfo[house][hDoorCrashed]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su stradala u pozaru, vatrogasac mora koristiti /ramdoors!");
			if(PlayerInfo[playerid][pHouseKey] == house || IsOnAdminDuty(playerid) || !HouseInfo[house][hLock] || PlayerInfo[playerid][pRentKey] == house) 
			{
				if(HouseInfo[house][hOwnerID] == PlayerInfo[playerid][pSQLID]) GameTextForPlayer(playerid, "~w~Dobrodosli kuci", 800, 1);
				if(HouseInfo[house][hFurLoaded] == false) ReloadHouseFurniture(house);
				Bit1_Set(gr_PlayerEntering, playerid, true);
				SetPlayerPosEx(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ], HouseInfo[house][hVirtualWorld], HouseInfo[house][hInt], true);

				Bit16_Set(gr_PlayerInHouse, playerid, house);
				DestroyHouseInfoTD(playerid);
				
				/*
				_LoadingObjects(playerid, true); // textdraw.
				SetTimerEx("LoadingObjects", 3000, (false), "ib", playerid, (true));
				TogglePlayerControllable(playerid, (false));*/
                
				if(IsHousePlayingMusic(house)) 
				{
					StopAudioStreamForPlayer(playerid);
					new url[256];
					format(url, sizeof(url), "%s",ReturnHouseMusicURL(house));
					PlayAudioStreamForPlayer(playerid, url);
				}
				
				entering[playerid] = 1;
                TogglePlayerControllable(playerid, false);
                SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
			} 
			else return GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
		}
		return 1;
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred biznisa ili kuce!");
	return 1;
}

CMD:exit(playerid, params[])
{
	if( IsPlayerInRangeOfPoint(playerid, 10.0, 1122.9961, -2036.8920, 1701.0578 ) )
	{
		SetPlayerPosEx(playerid, 366.544769, 158.641189, 1008.382812, 0, 3, true);
		return 1;
	}
	new
		pickup = -1,
		complex = INVALID_COMPLEX_ID;

	foreach(new x : Pickups)
	{
		if( IsPlayerInRangeOfPoint(playerid,5.0,PickupInfo[x][epExitx], PickupInfo[x][epExity], PickupInfo[x][epExitz])
			&& GetPlayerInterior(playerid) == PickupInfo[x][epInt]
			&& GetPlayerVirtualWorld(playerid) == PickupInfo[x][epViwo]) {
			pickup = x;
			break;
		}
	}
	foreach(new c : Complex)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, ComplexInfo[ c ][ cExitX ], ComplexInfo[ c ][ cExitY ], ComplexInfo[ c ][ cExitZ ] )
		&& GetPlayerInterior(playerid) == ComplexInfo[ c ] [cInt]
		&& GetPlayerVirtualWorld(playerid) == ComplexInfo[ c ] [cViwo] ) {
		    complex = c;
		    break;
		}
	}
	if( pickup != -1 )
	{
		Bit16_Set( gr_PlayerInPickup, playerid, -1);
		Bit1_Set( gr_PlayerExiting, playerid, true );
		SetPlayerPosEx(playerid,PickupInfo[pickup][epEntrancex],PickupInfo[pickup][epEntrancey],PickupInfo[pickup][epEntrancez],PickupInfo[pickup][epEnterViwo],PickupInfo[pickup][epEnterInt],true);

		onexit[playerid] = 1;
		TogglePlayerControllable(playerid, false);
		SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
		return 1;
	}
	else if( complex != INVALID_COMPLEX_ID)
	{
		Bit16_Set( gr_PlayerInComplex, playerid, INVALID_COMPLEX_ID);
		Bit1_Set( gr_PlayerExiting, playerid, true );
		
		/*if(aprilfools[playerid])
			complex = random(MAX_COMPLEX/2);*/
		
		
	    SetPlayerPosEx(playerid, ComplexInfo[complex][cEnterX], ComplexInfo[complex][cEnterY], ComplexInfo[complex][cEnterZ], 0, 0, false);

        onexit[playerid] = 1;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
		return 1;
	}
	else if( Bit16_Get( gr_PlayerInBiznis, playerid ) != INVALID_BIZNIS_ID && Bit16_Get( gr_PlayerInBiznis, playerid ) < MAX_BIZZS)
	{
		new
			biznis = Bit16_Get( gr_PlayerInBiznis, playerid );

		if( IsPlayerInRangeOfPoint( playerid, 2.0, BizzInfo[ biznis ][ bExitX ], BizzInfo[ biznis ][ bExitY ], BizzInfo[ biznis ][ bExitZ ] ) )
		{
			if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pChar] && !PlayerInfo[playerid][pLawDuty])
			{
				new
					biztype = BizzInfo[biznis][bType];
					
				if(biztype == BIZZ_TYPE_SUBURBAN || biztype == BIZZ_TYPE_PROLAPS || biztype == BIZZ_TYPE_ZIP || biztype == BIZZ_TYPE_BINCO)
				{
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Izasli ste iz biznisa te ste odustali od kupnje skina!");
					ResetBuySkin(playerid);
				}
			}
			/*if(aprilfools[playerid])
				biznis = random(MAX_BIZZS/2);*/
			
			SetPlayerPosEx( playerid, BizzInfo[ biznis ][ bEntranceX ], BizzInfo[ biznis ][ bEntranceY ], BizzInfo[ biznis ][ bEntranceZ ], 0, 0, false );
			SetPlayerInterior( playerid, 0 );
			SetPlayerVirtualWorld( playerid, 0 );
			Bit1_Set( gr_PlayerExiting, playerid, true );
			Bit16_Set( gr_PlayerInBiznis, playerid, INVALID_BIZNIS_ID );
			StopAudioStreamForPlayer(playerid);
			
			onexit[playerid] = 1;
        	TogglePlayerControllable(playerid, false);
        	SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
			return 1;
		}
	}
	else if(Bit16_Get( gr_PlayerInRoom, playerid ) != INVALID_COMPLEX_ID && Bit16_Get( gr_PlayerInRoom, playerid) < MAX_COMPLEX_ROOMS)
	{
		new
			rcomplex = Bit16_Get( gr_PlayerInRoom, playerid );
		if( IsPlayerInRangeOfPoint( playerid, 2.0, ComplexRoomInfo[ rcomplex ][ cExitX ], ComplexRoomInfo[ rcomplex ][ cExitY ], ComplexRoomInfo[ rcomplex ][ cExitZ ] ) )
		{
			/*if(aprilfools[playerid])
				rcomplex = random(MAX_COMPLEX_ROOMS/2);*/
			
			SetPlayerPosEx( playerid, ComplexRoomInfo[ rcomplex ][ cEnterX ], ComplexRoomInfo[ rcomplex ][ cEnterY ], ComplexRoomInfo[ rcomplex ][ cEnterZ ], ComplexRoomInfo[ rcomplex ][ cVWExit ], ComplexRoomInfo[ rcomplex ][ cIntExit ] );
			Bit16_Set( gr_PlayerInRoom, playerid, INVALID_COMPLEX_ID );
			Bit1_Set( gr_PlayerExiting, playerid, true );
			StopAudioStreamForPlayer(playerid);
			
			onexit[playerid] = 1;
        	TogglePlayerControllable(playerid, false);
        	SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
		}
		return 1;
	}
	else if( Bit16_Get( gr_PlayerInGarage, playerid ) != INVALID_HOUSE_ID )
	{
		new
			garage = Bit16_Get( gr_PlayerInGarage, playerid );
		if( IsPlayerInRangeOfPoint( playerid, 10.0, GarageInfo[ garage ][ gExitX ], GarageInfo[ garage ][ gExitY ], GarageInfo[ garage ][ gExitZ ] ) )
		{
			/*if(aprilfools[playerid])
				garage = random(MAX_GARAGES/2);*/
			
			StopAudioStreamForPlayer(playerid);
			if( !IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER )
			{
				SetPlayerPosEx( playerid, GarageInfo[ garage ][ gEnterX ], GarageInfo[ garage ][ gEnterY ], GarageInfo[ garage ][ gEnterZ ], 0, 0, true);
			}
			else if( IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) == PLAYER_STATE_DRIVER )
			{
				new vehicleid = GetPlayerVehicleID(playerid);

				SetVehiclePos(vehicleid, PlayerSafeExit[playerid][giX],PlayerSafeExit[playerid][giY],PlayerSafeExit[playerid][giZ]);
				SetVehicleZAngle(vehicleid, PlayerSafeExit[playerid][giRZ]);
				foreach(new i : Player) {
					if(IsPlayerInVehicle(i, vehicleid)){
						SetPlayerVirtualWorld(i, 0);
					}
				}

				PlayerSafeExit[playerid][giX] = 0;
				PlayerSafeExit[playerid][giY] = 0;
				PlayerSafeExit[playerid][giZ] = 0;
				PlayerSafeExit[playerid][giRZ] = 0;

				SetVehicleVirtualWorld(vehicleid, 0);
				LinkVehicleToInterior(vehicleid, 0);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
			}
			Bit16_Set( gr_PlayerInGarage, playerid, INVALID_HOUSE_ID );
			Bit1_Set( gr_PlayerExiting, playerid, true );
		}
		return 1;
	}
	else if( Bit16_Get( gr_PlayerInHouse, playerid ) != INVALID_HOUSE_ID && Bit16_Get( gr_PlayerInHouse, playerid ) >= 0 )
	{
		new
			house = Bit16_Get( gr_PlayerInHouse, playerid );
		if( IsPlayerInRangeOfPoint( playerid, 10.0, HouseInfo[ house ][ hExitX ], HouseInfo[ house ][ hExitY ], HouseInfo[ house ][ hExitZ ] ) )
		{
			if( IsPlayerSafeBreaking(playerid) )
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izaci van dok ne obijete sef!");

			StopAudioStreamForPlayer(playerid);
			
			/*if(aprilfools[playerid])
				house = random(MAX_HOUSES/2);*/
			
			if(HouseInfo[ house ][ h3dViwo ] > 0) { // Apartman
  				Streamer_ToggleIdleUpdate(playerid, 1);
				TogglePlayerControllable(playerid, 0);
				defer InstantStreamerUpdate(playerid);

				SetPlayerVirtualWorld( playerid, HouseInfo[ house ][ h3dViwo ] );
				SetPlayerInterior(playerid, 20);
				SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ]+1.0, HouseInfo[ house ][ hEnterZ ], HouseInfo[ house ][ h3dViwo ], 20, true);

                onexit[playerid] = 1;
        		TogglePlayerControllable(playerid, false);
                SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
			}
			else
			{
			    SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 0, 0, false);
                onexit[playerid] = 1;
        		TogglePlayerControllable(playerid, false);
        		SendMessage(playerid, MESSAGE_TYPE_INFO,"Pritisnite tipku 'N' ukoliko vam se mapa loadala");
			}
				

			Bit16_Set( gr_PlayerInHouse, playerid, INVALID_HOUSE_ID );
			Bit1_Set( gr_PlayerExiting, playerid, true );
			return 1;
		}
	}
	return 1;
}

/*CMD:peek(playerid, params[])
{
	new house = Bit16_Get(gr_PlayerInHouse, playerid);
	if(Bit1_Get(r_PlayerDoorPeek, playerid)) 
	{
		Streamer_UpdateEx(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]);
		SetCameraBehindPlayer(playerid);
		TogglePlayerDynamicCP(playerid, HouseInfo[house][hEnterCP], true);
		Bit1_Set(r_PlayerDoorPeek, playerid, false);
		return 1;
	}
	if(house == INVALID_HOUSE_ID || house < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar kuce/apartmana!");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu izlaza od kuce/apartmana!");	
	if(IsPlayerSafeBreaking(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izaci van dok ne obijete sef!");	
	
	// Streamer Update
	Streamer_UpdateEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]);
	TogglePlayerDynamicCP(playerid, HouseInfo[house][hEnterCP], false);

	// Set Player Pos
	new objectid = CreateDynamicObject(18659, 
						HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ] + 0.35, 
						0.0, 0.0, 0.0, 
						-1, 1, playerid, 10, 10, -1, 0);
	AttachCameraToDynamicObject(playerid, objectid);

	// Set Player Camera
	SetPlayerVirtualWorld(playerid, HouseInfo[house][h3dViwo]);
	SetPlayerInterior(playerid, HouseInfo[house][h3dViwo] > 0 ? 20 : 0);
	Bit1_Set(r_PlayerDoorPeek, playerid, true);
	return 1;
}*/

CMD:buyhouse(playerid, params[])
{
    if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");

	new
		house =  Bit16_Get(gr_PlayerInfrontHouse, playerid);
	if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu kuce!");
	if(HouseInfo[house][hOwnerID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca mora biti na prodaju!");
	if(PlayerInfo[playerid][pLevel] < HouseInfo[house][hLevel]) 
	{
		SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level %d da bi ste kupili ovu kucu!", HouseInfo[house][hLevel]);
		return 1;
	}
	if(PlayerInfo[playerid][pHouseKey] < 0)
		return 1;
	
	if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID && HouseInfo[PlayerInfo[playerid][pHouseKey]][hOwnerID] == PlayerInfo[playerid][pSQLID]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete kucu!");

	if(CalculatePlayerBuyMoney(playerid, BUY_TYPE_HOUSE) < HouseInfo[house][hValue]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za kupovinu ove kuce!");

	paymentBuyPrice[playerid] = HouseInfo[house][hValue];
	GetPlayerPaymentOption(playerid, BUY_TYPE_HOUSE);
	return 1;
}

CMD:houseentrance(playerid, params[])
{
	new houseid;
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
	if(sscanf(params, "i", houseid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /houseentrance [houseid]");
	if(!Iter_Contains(Houses, houseid)) return SendClientMessage(playerid,COLOR_RED, "Morate unijeti valjani houseid!");

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Premjestili ste ulaz od kuce %d na ovo mjesto!",houseid);
	new
		Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	new
		tmpString[128];
	format(tmpString,sizeof(tmpString),"[ADMIN]: %s je premjestio kucu: [%d] na [%.2f - %.2f - %.2f].",GetName(playerid,false),houseid,X,Y,Z);
	ABroadCast(COLOR_LIGHTRED,tmpString, 5);

	HouseInfo[houseid][hEnterX] = X;
	HouseInfo[houseid][hEnterY] = Y;
	HouseInfo[houseid][hEnterZ] = Z-0.8;
	HouseInfo[houseid][h3dViwo] = GetPlayerVirtualWorld(playerid);

	Streamer_SetFloatData(STREAMER_TYPE_CP, HouseInfo[houseid][hEnterCP], E_STREAMER_X			, HouseInfo[houseid][hEnterX]);
	Streamer_SetFloatData(STREAMER_TYPE_CP, HouseInfo[houseid][hEnterCP], E_STREAMER_Y			, HouseInfo[houseid][hEnterY]);
	Streamer_SetFloatData(STREAMER_TYPE_CP, HouseInfo[houseid][hEnterCP], E_STREAMER_Z			, HouseInfo[houseid][hEnterZ]);
	Streamer_SetIntData(STREAMER_TYPE_CP, 	HouseInfo[houseid][hEnterCP], E_STREAMER_WORLD_ID	, HouseInfo[houseid][h3dViwo]);
	Streamer_SetIntData(STREAMER_TYPE_CP, 	HouseInfo[houseid][hEnterCP], E_STREAMER_INTERIOR_ID, GetPlayerInterior(playerid));
	Streamer_Update(playerid);

	new
		bigquery[256];
	format(bigquery, sizeof(bigquery), "UPDATE `houses` SET `enterX` = '%f', `enterY` = '%f', `enterZ` = '%f', `viwoexit` = '%d' WHERE `id` = '%d'",
		HouseInfo[houseid][hEnterX],
		HouseInfo[houseid][hEnterY],
		HouseInfo[houseid][hEnterZ],
		HouseInfo[houseid][h3dViwo],
		HouseInfo[houseid][hSQLID]
	);
	mysql_tquery(g_SQL, bigquery, "");
    return 1;
}

CMD:customhouseint(playerid, params[])
{
	new
		Float:iX, Float:iY, Float:iZ,
		houseid, hint;

	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "iifff", houseid, hint, iX, iY, iZ)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /custombizint [houseid][int][X][Y][Z]");
		SendClientMessage(playerid, COLOR_GREY, "NOTE: Taj ID MORA biti u skripti!");
		return 1;
	}
	if(!Iter_Contains(Houses, houseid)) return SendClientMessage(playerid,COLOR_RED, "Morate unijeti valjani houseid!");

	HouseInfo[houseid][hExitX] 		= iX;
	HouseInfo[houseid][hExitY] 		= iY;
	HouseInfo[houseid][hExitZ] 		= iZ;
	HouseInfo[houseid][hInt] 		= hint;

	new
		bigquery[256];
	format(bigquery, sizeof(bigquery), "UPDATE `houses` SET `exitX` = '%f', `exitY` = '%f', `exitZ` = '%f', `int` = '%d' WHERE `id` = '%d'",
		HouseInfo[houseid][hExitX],
		HouseInfo[houseid][hExitY],
		HouseInfo[houseid][hExitZ],
		HouseInfo[houseid][hInt],
		HouseInfo[houseid][hSQLID]
	);
	mysql_tquery(g_SQL, bigquery, "");
	return 1;
}

CMD:houseint(playerid, params[])
{
	new proplev, id2;
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi 1338!");
	if (sscanf(params, "ii", proplev, id2)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /houseint [houseid] [id (1-42)]");
	if(proplev > sizeof(HouseInfo) || proplev < 0) return SendClientMessage(playerid,COLOR_RED, "House ID mora biti izmedju 0 i 558");
 	if(id2 < 1 || id2 > 42) return SendClientMessage(playerid, COLOR_RED, "[GRESKA:] INTERIORI MOGU BITI OD 1-42.");
	switch(id2) {
		case 1: {
			HouseInfo[proplev][hExitX] = 235.3054;
			HouseInfo[proplev][hExitY] = 1186.6835;
			HouseInfo[proplev][hExitZ] = 1080.2578;
			HouseInfo[proplev][hInt] = 3;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/3 bedrooms/clone of House 9.", proplev);
		}
		case 2: {//225.756989,1240.000000,1082.149902
			HouseInfo[proplev][hExitX] = 225.756989;
			HouseInfo[proplev][hExitY] = 1240.000000;
			HouseInfo[proplev][hExitZ] = 1082.149902;
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Medium/1 story/1 bedroom.", proplev);
	   	}
		case 3: {//223.1929,1287.0780,1082.1406,
			HouseInfo[proplev][hExitX] = 223.1929;
			HouseInfo[proplev][hExitY] = 1287.0780;
			HouseInfo[proplev][hExitZ] = 1082.1406;
			HouseInfo[proplev][hInt] = 1;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom.", proplev);
	  	}
		case 4: {
			HouseInfo[proplev][hExitX] = 225.630997; HouseInfo[proplev][hExitY] = 1022.479980; HouseInfo[proplev][hExitZ] = 1084.069946;
			HouseInfo[proplev][hInt] = 7;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): VERY Large/2 story/4 bedrooms.", proplev);
		}
		case 5: {
			HouseInfo[proplev][hExitX] = 295.138977; HouseInfo[proplev][hExitY] = 1474.469971; HouseInfo[proplev][hExitZ] = 1080.519897;
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/2 bedrooms.", proplev);
		}
		case 6: {
			HouseInfo[proplev][hExitX] = 328.1066; HouseInfo[proplev][hExitY] = 1478.0106; HouseInfo[proplev][hExitZ] = 1084.4375;//328.1066,1478.0106,1084.4375
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/2 bedrooms.", proplev);
		}
		case 7: {
			HouseInfo[proplev][hExitX] = 385.803986; HouseInfo[proplev][hExitY] = 1471.769897; HouseInfo[proplev][hExitZ] = 1080.209961;
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom/NO BATHROOM.", proplev);
		}
		case 8: {
			HouseInfo[proplev][hExitX] = 375.971985; HouseInfo[proplev][hExitY] = 1417.269897; HouseInfo[proplev][hExitZ] = 1081.409912;
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom.", proplev);
		}
		case 9: {
			HouseInfo[proplev][hExitX] = 490.810974; HouseInfo[proplev][hExitY] = 1401.489990; HouseInfo[proplev][hExitZ] = 1080.339966;
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/3 bedrooms.", proplev);
		}
 		case 10: {
			HouseInfo[proplev][hExitX] = 446.8264; HouseInfo[proplev][hExitY] = 1397.3435; HouseInfo[proplev][hExitZ] = 1084.3047;
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Medium/1 story/2 bedrooms.", proplev);
	  	}
		case 11: {
			HouseInfo[proplev][hExitX] = 227.722992; HouseInfo[proplev][hExitY] = 1114.389893; HouseInfo[proplev][hExitZ] = 1081.189941;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/4 bedrooms.", proplev);
		}
		case 12: {
			HouseInfo[proplev][hExitX] = 260.983978; HouseInfo[proplev][hExitY] = 1286.549927; HouseInfo[proplev][hExitZ] = 1080.299927;//260.983978,1286.549927,1080.299927
			HouseInfo[proplev][hInt] = 4;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom.", proplev);
		}
		case 13: {
			HouseInfo[proplev][hExitX] = 221.7330; HouseInfo[proplev][hExitY] = 1140.5146; HouseInfo[proplev][hExitZ] = 1082.6094;//221.7330,1140.5146,1082.6094,
			HouseInfo[proplev][hInt] = 4;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom/NO BATHROOM!", proplev);
		}
		case 14: {
			HouseInfo[proplev][hExitX] = 23.9878; HouseInfo[proplev][hExitY] = 1340.3865; HouseInfo[proplev][hExitZ] = 1084.3750;
			HouseInfo[proplev][hInt] = 10;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Medium/2 story/1 bedroom.", proplev);
		}
		case 15: {
			HouseInfo[proplev][hExitX] = -262.601990; HouseInfo[proplev][hExitY] = 1456.619995; HouseInfo[proplev][hExitZ] = 1084.449951;//-262.601990,1456.619995,1084.449951,
			HouseInfo[proplev][hInt] = 4;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/1 bedroom/NO BATHROOM!", proplev);
		}
		case 16: {//22.778299,1404.959961,1084.449951,
			HouseInfo[proplev][hExitX] = 22.778299; HouseInfo[proplev][hExitY] = 1404.959961; HouseInfo[proplev][hExitZ] = 1084.449951;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Medium/1 story/2 bedrooms/NO BATHROOM or DOORS!", proplev);
		}
		case 17: {
			HouseInfo[proplev][hExitX] = 140.2267; HouseInfo[proplev][hExitY] = 1365.9246; HouseInfo[proplev][hExitZ] = 1083.8594;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/4 bedrooms/NO BATHROOM!", proplev);
		}
		case 18: {
			HouseInfo[proplev][hExitX] = 234.045990; HouseInfo[proplev][hExitY] = 1064.879883; HouseInfo[proplev][hExitZ] = 1084.309937;
			HouseInfo[proplev][hInt] = 6;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Large/2 story/3 bedrooms.", proplev);
		}
		case 19: {//-68.294098,1353.469971,1080.279907,
			HouseInfo[proplev][hExitX] = -68.294098; HouseInfo[proplev][hExitY] = 1353.469971; HouseInfo[proplev][hExitZ] = 1080.279907;
			HouseInfo[proplev][hInt] = 6;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/NO BEDROOM!", proplev);
		}
		case 20: {
			HouseInfo[proplev][hExitX] = -285.548981; HouseInfo[proplev][hExitY] = 1470.979980; HouseInfo[proplev][hExitZ] = 1084.449951;
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): 1 bedroom/living room/kitchen/NO BATHROOM", proplev);
		}
		case 21: {//-42.581997,1408.109985,1084.449951,
			HouseInfo[proplev][hExitX] = -42.581997; HouseInfo[proplev][hExitY] = 1408.109985; HouseInfo[proplev][hExitZ] = 1084.449951;
			HouseInfo[proplev][hInt] = 8;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/NO BEDROOM!", proplev);
		}
		case 22: {
			HouseInfo[proplev][hExitX] = 83.345093; HouseInfo[proplev][hExitY] = 1324.439941; HouseInfo[proplev][hExitZ] = 1083.889893;
			HouseInfo[proplev][hInt] = 9;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Medium/2 story/2 bedrooms", proplev);
		}
		case 23: {//260.941986,1238.509888,1084.259888,
			HouseInfo[proplev][hExitX] = 260.941986; HouseInfo[proplev][hExitY] = 1238.509888; HouseInfo[proplev][hExitZ] = 1084.259888;// INT ZA STAN..
			HouseInfo[proplev][hInt] = 9;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Small/1 story/1 bedroom", proplev);
		}
		case 24: {//244.411987,305.032990,999.231995,
			HouseInfo[proplev][hExitX] = 244.411987; HouseInfo[proplev][hExitY] = 305.032990; HouseInfo[proplev][hExitZ] = 999.231995;
			HouseInfo[proplev][hInt] = 1;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Denise's Bedroom", proplev);
		}
		case 25: {
			HouseInfo[proplev][hExitX] = 266.4986; HouseInfo[proplev][hExitY] = 305.0700; HouseInfo[proplev][hExitZ] = 999.1484;
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Katie's Bedroom", proplev);
		}
		case 26: {
			HouseInfo[proplev][hExitX] = 291.282990; HouseInfo[proplev][hExitY] = 310.031982; HouseInfo[proplev][hExitZ] = 999.154968;
			HouseInfo[proplev][hInt] = 3;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Helena's Bedroom (barn) - limited movement.", proplev);
		}
		case 27: {
			HouseInfo[proplev][hExitX] = 302.181000; HouseInfo[proplev][hExitY] = 300.722992; HouseInfo[proplev][hExitZ] = 999.231995;
			HouseInfo[proplev][hInt] = 4;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Michelle's Bedroom.", proplev);
		}
		case 28: {
			HouseInfo[proplev][hExitX] = 322.197998; HouseInfo[proplev][hExitY] = 302.497986; HouseInfo[proplev][hExitZ] = 999.231995;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Barbara's Bedroom.", proplev);
		}
		case 29: {
			HouseInfo[proplev][hExitX] = 343.7173; HouseInfo[proplev][hExitY] = 304.9440; HouseInfo[proplev][hExitZ] = 999.1484;
			HouseInfo[proplev][hInt] = 6;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Millie's Bedroom.", proplev);
		}
		case 30: {
			HouseInfo[proplev][hExitX] = 2495.6416; HouseInfo[proplev][hExitY] = -1692.2361; HouseInfo[proplev][hExitZ] = 1014.7422;//2495.6416,-1692.2361,1014.7422,
			HouseInfo[proplev][hInt] = 3;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): CJ's Mom's House.", proplev);
		}
		case 31: {
			HouseInfo[proplev][hExitX] = 1263.079956; HouseInfo[proplev][hExitY] = -785.308960; HouseInfo[proplev][hExitZ] = 1091.959961;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Madd Dogg's Mansion (West door).", proplev);
		}
		case 32: {
			HouseInfo[proplev][hExitX] = 2468.4502; HouseInfo[proplev][hExitY] = -1698.4801; HouseInfo[proplev][hExitZ] = 1013.5078;//2468.4502,-1698.4801,1013.5078,
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Ryder's house.", proplev);
		}
		case 33: {
			HouseInfo[proplev][hExitX] = 2526.459961; HouseInfo[proplev][hExitY] = -1679.089966; HouseInfo[proplev][hExitZ] = 1015.500000;
			HouseInfo[proplev][hInt] = 1;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Sweet's House (South side of house is fucked).", proplev);
		}
		case 34: {
			HouseInfo[proplev][hExitX] = 2543.659912; HouseInfo[proplev][hExitY] = -1303.629883; HouseInfo[proplev][hExitZ] = 1025.069946;
			HouseInfo[proplev][hInt] = 2;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Big Smoke's Crack Factory (Ground Floor).", proplev);
		}
		case 35: {
			HouseInfo[proplev][hExitX] = 744.542969; HouseInfo[proplev][hExitY] = 1437.669922; HouseInfo[proplev][hExitZ] = 1102.739990;
			HouseInfo[proplev][hInt] = 6;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Fanny Batter's Whore House.", proplev);
		}
		case 36: {
			HouseInfo[proplev][hExitX] = 964.106995; HouseInfo[proplev][hExitY] = -53.205498; HouseInfo[proplev][hExitZ] = 1001.179993;
			HouseInfo[proplev][hInt] = 3;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Tiger Skin Rug Brothel.", proplev);
		}
		case 37: {
			HouseInfo[proplev][hExitX] = 2350.339844; HouseInfo[proplev][hExitY] = -1181.649902; HouseInfo[proplev][hExitZ] = 1028.000000;
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Burning Desire Gang House.", proplev);
		}
		case 38: {
			HouseInfo[proplev][hExitX] = 2807.9172; HouseInfo[proplev][hExitY] = -1174.4333; HouseInfo[proplev][hExitZ] = 1025.5703;
			HouseInfo[proplev][hInt] = 8;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Colonel Furhberger's House.", proplev);
		}
		case 39: {//CRACK HOUSE
			HouseInfo[proplev][hExitX] = 318.6453; HouseInfo[proplev][hExitY] = 1114.4795; HouseInfo[proplev][hExitZ] = 1083.8828;//318.7010,1114.7716,1083.8828,
			HouseInfo[proplev][hInt] = 5;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Crack Den.", proplev);
		}
		case 40: {
			HouseInfo[proplev][hExitX] = 2324.3267; HouseInfo[proplev][hExitY] = -1149.1440; HouseInfo[proplev][hExitZ] = 1050.7101;
			HouseInfo[proplev][hInt] = 12;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Unused Safe House.", proplev);
		}
		case 41: {
			HouseInfo[proplev][hExitX] = 446.5014; HouseInfo[proplev][hExitY] = 507.0295; HouseInfo[proplev][hExitZ] = 1001.4195;
			HouseInfo[proplev][hInt] = 12;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Budget Inn Motel Room.", proplev);
		}
		case 42: {
			HouseInfo[proplev][hExitX] = 2216.3398; HouseInfo[proplev][hExitY] = -1150.5099; HouseInfo[proplev][hExitZ] = 1025.7969;
			HouseInfo[proplev][hInt] = 15;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Interijer(houseid %d): Jefferson Motel. (REALLY EXPENSIVE)", proplev);
		}
	}
	
	new
		mysqlQuery[128];
	format(mysqlQuery, 128, "UPDATE houses SET `exitX`='%f',`exitY`='%f',`exitZ`='%f',`int`='%d' WHERE `id` = '%d'",
		HouseInfo[proplev][hExitX],
		HouseInfo[proplev][hExitY],
		HouseInfo[proplev][hExitZ],
		HouseInfo[proplev][hInt],
		HouseInfo[proplev][hSQLID]
	);
	mysql_tquery(g_SQL, mysqlQuery, "", "");
    return 1;
}

CMD:ring(playerid, params[])
{
	if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce ili garaze (niste u checkpointu)!");
	if(Bit16_Get(gr_PlayerInfrontHouse, playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce ili garaze (niste u checkpointu)!");

	new
		houseid = Bit16_Get(gr_PlayerInfrontHouse, playerid);
	if(houseid != INVALID_HOUSE_ID) {
		PlaySoundForPlayersInRange(20801, 80.0, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY], HouseInfo[houseid][hExitZ]);
		PlaySoundForPlayersInRange(20801, 50.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ]);
 	}
	return 1;
}

CMD:knock(playerid, params[])
{
	if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
	if(Bit16_Get(gr_PlayerInfrontHouse, playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");

	new
		house = Bit16_Get(gr_PlayerInfrontHouse, playerid),
		knockString[45];

	if(IsPlayerInRangeOfPoint(playerid,2.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]) && HouseInfo[house][h3dViwo] == GetPlayerVirtualWorld(playerid)) {
		format(knockString, sizeof(knockString), "* %s kuca po vratima.", GetName(playerid, true));
		ProxDetector(30.0, playerid, knockString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
	if(Bit16_Get(gr_PlayerInfrontHouse, playerid) == INVALID_HOUSE_ID && Bit16_Get(gr_PlayerInHouse, playerid) == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce/u kuci!");
	new
		result[100],
		house;
		
	if(sscanf(params, "s[100]", result)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /doorshout [text]");
	
	if(Bit16_Get(gr_PlayerInfrontHouse, playerid) != INVALID_HOUSE_ID)
	{
		house = Bit16_Get(gr_PlayerInfrontHouse, playerid);
		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]) && HouseInfo[house][h3dViwo] == GetPlayerVirtualWorld(playerid)) 
		{
			AntiSpamInfo[playerid][asDoorShout] = gettimestamp() + ANTI_SPAM_DOOR_SHOUT;
			new
				tmpString[144],
				color = COLOR_FADE1;
			if(IsOnAdminDuty(playerid))
			{
				format(tmpString, sizeof(tmpString), "(( Admin %s se dere[VRATA]: %s ))", GetName(playerid, true), result);
				ProxDetector(30.0, playerid, tmpString, COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE);
				color = COLOR_ORANGE;
			}
			if(IsOnHelperDuty(playerid))
			{
				format(tmpString, sizeof(tmpString), "(( Helper %s se dere[VRATA]: %s ))", GetName(playerid, true), result);
				ProxDetector(30.0, playerid, tmpString, COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
				color = COLOR_ORANGE;
			}
			if(Bit1_Get(gr_MaskUse, playerid) && !IsOnAdminDuty(playerid))
			{
				format(tmpString, sizeof(tmpString), "Maska_%d se dere[VRATA]: %s !!", PlayerInfo[playerid][pMaskID], result);
				ProxDetector(30.0, playerid, tmpString, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				color = COLOR_FADE1;
			}
			if(!IsOnAdminDuty(playerid) && !Bit1_Get(gr_MaskUse, playerid))
			{
				format(tmpString, sizeof(tmpString), "%s se dere[VRATA]: %s !!", GetName(playerid, true), result);
				ProxDetector(30.0, playerid, tmpString, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				color = COLOR_FADE1;
			}
			foreach(new i : Player)
			{
				if(IsPlayerInRangeOfPoint(i, 30.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && GetPlayerInterior(i) == HouseInfo[house][hInt] &&  GetPlayerVirtualWorld(i) == HouseInfo[house][hVirtualWorld])
				{
					SendClientMessage(i, color, tmpString);
					continue;
				}
			}
		}
		else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti vrlo blizu vrata od kuce!");
	}
	else
	{
		if(Bit16_Get(gr_PlayerInHouse, playerid) != INVALID_HOUSE_ID)
		{
			house = Bit16_Get(gr_PlayerInHouse, playerid);
			if(IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]) && HouseInfo[house][hVirtualWorld] == GetPlayerVirtualWorld(playerid)) 
			{
				AntiSpamInfo[playerid][asDoorShout] = gettimestamp() + ANTI_SPAM_DOOR_SHOUT;
				new
					tmpString[144],
					color = COLOR_FADE1;
				if(IsOnAdminDuty(playerid))
				{
					format(tmpString, sizeof(tmpString), "(( Admin %s se dere[VRATA]: %s ))", GetName(playerid, true), result);
					ProxDetector(30.0, playerid, tmpString, COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE);
					color = COLOR_ORANGE;
				}
				if(IsOnHelperDuty(playerid))
				{
					format(tmpString, sizeof(tmpString), "(( Helper %s se dere[VRATA]: %s ))", GetName(playerid, true), result);
					ProxDetector(30.0, playerid, tmpString, COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
					color = COLOR_ORANGE;
				}
				if(Bit1_Get(gr_MaskUse, playerid) && !IsOnAdminDuty(playerid))
				{
					format(tmpString, sizeof(tmpString), "Maska_%d se dere[VRATA]: %s !!", PlayerInfo[playerid][pMaskID], result);
					ProxDetector(30.0, playerid, tmpString, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					color = COLOR_FADE1;
				}
				if(!IsOnAdminDuty(playerid) && !Bit1_Get(gr_MaskUse, playerid))
				{
					format(tmpString, sizeof(tmpString), "%s se dere[VRATA]: %s !!", GetName(playerid, true), result);
					ProxDetector(30.0, playerid, tmpString, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					color = COLOR_FADE1;
				}
				foreach(new i : Player)
				{
					if(IsPlayerInRangeOfPoint(i, 30.0, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]))
					{
						SendClientMessage(i, color, tmpString);
						continue;
					}
				}
			}
			else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti vrlo blizu vrata od kuce!");
		}
	}
	return 1;
}

/***********  PLAYER CMDS ******************/
CMD:rent(playerid, params[])
{
	new
		pick[11];

	if(sscanf(params, "s[11] ", pick)) return SendClientMessage(playerid, -1, "[ ? ]: /rent [house/vehicle]");

	if(!strcmp(pick, "house", true)) {
		new
			hpick[11];

		if(sscanf(params, "s[11]s[11]", pick, hpick)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rent house [odabir]");
			SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: start - stop");
			return 1;
		}
		if(!strcmp(hpick, "start", true)) {
			if((PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID ) || (PlayerInfo[playerid][pRentKey] != INVALID_HOUSE_ID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Posjedujete kucu ili rentate kucu!");

			new
				houseid = Bit16_Get(gr_PlayerInfrontHouse, playerid);
			if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid]) || houseid == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
			if(!HouseInfo[houseid][hRentabil]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nije na rent!");
			if(AC_GetPlayerMoney(playerid) < HouseInfo[houseid][hRent]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");

			PlayerInfo[playerid][pRentKey] = houseid;
			PlayerInfo[playerid][pSpawnChange] = 1;
			PlayerToHouseMoneyTAX(playerid, houseid, HouseInfo[houseid][hRent]);

			new
				tmpString[96];
			format(tmpString, 96, "[ ! ] Sada ste u najmu kuce i oduzeta vam je cijena najamnine u vrijednosti od "COL_GREEN"%d$",
				HouseInfo[houseid][hRent]
			);
			SendClientMessage(playerid, COLOR_GREEN, tmpString);
			PlayerInfo[playerid][pSpawnChange] = 1;
			
			new scQuery[70];
			format(scQuery, 70, "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
				PlayerInfo[playerid][pSpawnChange],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_tquery(g_SQL, scQuery);
			SetPlayerSpawnInfo(playerid);
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Spawn Vam je automatski prebacen na iznajmljenu kucu.");
		}
		else if(!strcmp(hpick, "stop", true)) {
			if((PlayerInfo[playerid][pRentKey] == INVALID_HOUSE_ID)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne iznajmljujete kucu!");

			new house = PlayerInfo[playerid][pRentKey];
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prestali ste iznajmljivati kucu na adresi %s.", HouseInfo[house][hAdress]);
			PlayerInfo[playerid][pRentKey] = INVALID_HOUSE_ID;
			PlayerInfo[playerid][pSpawnChange] = 0;
			SetPlayerSpawnInfo(playerid);
		}
	}
	return 1;
}

CMD:house(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 2+ da mozes koristiti ovu komandu!");
	
	if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID && HouseInfo[PlayerInfo[playerid][pHouseKey]][hOwnerID] == PlayerInfo[playerid][pSQLID] ) {
		ShowPlayerDialog(playerid, DIALOG_HOUSE_MAIN, DIALOG_STYLE_LIST,"MOJA KUCA","House Storage\nUpgrades\nOtvori/Zatvori\nNajam\nIzbaci podstanare\nOrmar\nKuhinja\nInfo\nProdaj kucu(Polovina vrijednosti kupnje)\nProdaj igracu","Choose","Exit");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujes kucu!");
	return 1;
}

stock IsOwnerOfHouseOnline(houseid)
{
	foreach(new playerid : Player) {
		if(HouseInfo[houseid][hOwnerID] == PlayerInfo[playerid][pSQLID])
			return 1;
	}
	return 0;
}

CMD:picklock(playerid, params[])
{
	if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");
	new
		pick[6],
		house = Bit16_Get(gr_PlayerInfrontHouse, playerid);

	if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce(u checkpointu)!");
	if(!IsOwnerOfHouseOnline(house)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mozete provaljivati samo kada je vlasnik online!");
	if(sscanf(params, "s[6] ", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /picklock [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: card, tools");
		return 1;
	}

	if(!strcmp(pick, "card", true, 4)) {
		if(HouseInfo[house][hLockLevel] > 1) 	return SendClientMessage(playerid, COLOR_RED, "[ ! ] Brava je precvrsta da biste mogli rabiti karticu!");
		if(!HouseInfo[house][hLock]) 			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vrata su otkljucana!");

		new
			rand = random(50) + 1;
		if(rand > 10) {
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste otkljucali vrata!");
			HouseInfo[house][hLock] = 0;
		} else SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste uspjeli otkljucati vrata!");
	}
	else if(!strcmp(pick, "tools", true, 6)) {
		if(Bit1_Get(gr_PlayerPickLocking, playerid)) {
			ResetLockPickVars(playerid);
			TogglePlayerControllable(playerid, true);
			return 1;
		}
		if(!HouseInfo[house][hLock]) 			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vrata su otkljucana!");
		if(HouseInfo[house][hLockLevel] <= 2) {
			SetPlayerPickLock(playerid);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Za prebacivanje slota koristite ~k~~CONVERSATION_YES~ ili ~k~~CONVERSATION_NO~. Za podizanje kombinacije koristite ~k~~PED_SPRINT~!");
			ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_nod", 3.1, 1, 0, 0, 1, 0, 1, 0);
		} else SendClientMessage(playerid, COLOR_RED, "[ ! ] Brava je precvrsta da biste mogli rabiti picklock!");
	}
	return 1;
}

CMD:doorram(playerid, params[])
{
	if(!IsPlayerInDynamicCP(playerid, PlayerHouseCP[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");
	new
		param[8],
		house = Bit16_Get(gr_PlayerInfrontHouse, playerid);

	if(house == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce(u checkpointu)!");
	if(!HouseInfo[house][hLock]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su otkljucana!");
	if(!IsOwnerOfHouseOnline(house)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mozete provaljivati samo kada je vlasnik online!");
	if(sscanf(params, "s[8]", param)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /doorram [foot/crowbar]");

	if(!strcmp("foot", param, true)) {
		if(Bit1_Get(gr_PlayerFootKicking, playerid)) {
			TogglePlayerControllable(playerid, true);
			ResetDoorKickingVars(playerid);
			return 1;
		}
		if(Bit1_Get(gr_PlayerFootKicking, playerid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec razvaljujete vrata!");
		if(HouseInfo[house][hDoorLevel] > 3) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su precvrsta da biste ih mogli razvaliti nogom!");
			
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Za udaranje nogom u vrata koristite tipku ~k~~PED_SPRINT~, a za prestak koristite /doorram foot!");
		SetPlayerFootEntering(playerid); 
	}
	if(!strcmp("crowbar", param, true)) {
		if(Bit1_Get(gr_CrowbarBreaking, playerid)) {
			DisablePlayerKeyInput(playerid);
			TogglePlayerControllable(playerid, true);
			Bit1_Set(gr_CrowbarBreaking, playerid, false);
			return 1;
		}

		#if defined MODULE_OBJECTS
		new
			object = IsObjectAttached(playerid, 18634);
		if(object == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pajser u rukama!");
		if(5 <= PlayerObject[playerid][object][poBoneId] <= 6) {
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Pricekajte tipke koje morate unijeti, za prekid probijanja kucajte /doorram crowbar!");
			SetPlayerCrowbarBreaking(playerid);
		} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pajser mora biti u rukama!");
		#endif
	}
	return 1;
}
CMD:unrenthouse(playerid, params[])
{
	if(PlayerInfo[playerid][pRentKey] == INVALID_HOUSE_ID) return SendClientMessage(playerid,COLOR_RED, "Ne iznajmljujete kucu!");
	new house = PlayerInfo[playerid][pRentKey];
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Prestao si iznajmljivati kucu na adresi %s.",  HouseInfo[house][hAdress]);
	PlayerInfo[playerid][pRentKey] = INVALID_HOUSE_ID;
	return 1;
}

CMD:createhouse(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	new 
		level, price, address[32], interior;
	if(sscanf(params, "iiis[32] ", level, price, interior, address)){
		for(new i = 0; i < sizeof(HouseInts); i++) {
			va_SendClientMessage(playerid, COLOR_GRAD2, "Interior: [%d] %s", i, HouseInts[i][iDescription]);
		}
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /createhouse [level][price][interior][address]");
		return 1;
	}
	if(strlen(address) <= 0 || strlen(address) > 32)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Adresa moze imati minimalno 1, a maksimalno 32 znaka!");
	new 
		Float:x, Float:y, Float:z, freeslot;
	GetPlayerPos(playerid, x, y, z);
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kreirao si kucu level [%i], cijena[%i], adresa[%s]", level, price, address);
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] interior [%s]. ", HouseInts[interior][iDescription]);
	
	freeslot = Iter_Free(Houses);
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
	Iter_Add(Houses, freeslot);
	InsertHouseInDB(freeslot, playerid);
	CreateHouseEnter(freeslot);
	return 1;
} 
