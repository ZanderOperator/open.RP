/* www.cityofangels-roleplay.com - Last Team Standing - Event system - by L3o 
			Created for CoA 7th. anniversary. - L3o 
			
 
	Provijere: 
		Modul: coarp.pwn (public OnPlayerDeath)
		Modul: Inventory (CMD: /inventory);
		Modul: CreateObjects (CMD: /createobject & /editobject)
		Modul: LSPD Core (CMD: /tazer)
		Modul: WeaponAttach (CMD: /weapon)
		Modul: CMD (CMD: /give)
		
*/
#include <YSI\y_hooks>

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (defines)
#define LSM_MATCH_COUNTER 	(20) 	// Koliko sekundi se ceka da zapocne match.
#define EVENT_WORLD_ID 	  	(99) 	// ID svijeta u kojem se nalazi event.	- ukoliko ces mjenjat, promijeni i vw mape u taj world (ServerMaps.pwn)

#define MAX_E_ITEMS		  	(120)	// Maximalno item-a na eventu.
#define MAX_EVENT_CARS	  	(3)		// Maximalno vozila na eventu.

#define SUPPLY_DROP_SPEED	(13.0)	// Kojom brzinom ce se kretati supply drop.
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (vars)

enum {
	// settings
	MAX_EVENT_TEAMS = 6,
	MAX_PLAYERS_IN_TEAM = 5,
	
	// teams id.
	TEAM_RED 			= 1,
	TEAM_BLUE			= 2,
	TEAM_GREEN 			= 3,
	TEAM_YELLOW 		= 4,
	TEAM_WHITE 			= 5,
	TEAM_BLACK 			= 6,
	
	// item_type
	E_ITEM_TYPE_NONE	= 0,
	E_ITEM_TYPE_WEAPON	= 1,
	E_ITEM_TYPE_AMMO	= 2,
	E_ITEM_TYPE_HEALTH	= 3,
	E_ITEM_TYPE_HELMET	= 4,
	E_ITEM_TYPE_VEST	= 5,
	E_ITEM_TYPE_OTHER	= 6,
	
	// Attachments
	E_OBJECT_SLOT_HELMET 	= 1,
	E_OBJECT_SLOT_VEST	 	= 2,
	E_OBJECT_SLOT_CANISTER 	= 3
}

enum EVENT_DATA_LTS
{
    Item_ID,
	Item_Amount,
	Item_Name[20],
	Item_Weapon,
	Item_Type,
	Item_Object,
    Float:Item_PosX,
    Float:Item_PosY,
    Float:Item_PosZ,
	Text3D:Item_Text3D
};
new EVENT_ENUM[MAX_E_ITEMS][EVENT_DATA_LTS];


enum EVENT_PLAYER_DATA {
	bool: Helmet,
	bool: Vest,
	bool: Canister
}
new PLAYER_EVENT[MAX_PLAYERS][EVENT_PLAYER_DATA];


new	
	// Player Vars
	bool: lts_Joined[MAX_PLAYERS] 		= (false),
	bool: lts_Alive[MAX_PLAYERS]		= (false),
	lts_PlayerTeam[MAX_PLAYERS] 		= -1,
	lts_LeaderTeam[MAX_PLAYERS]			= -1,
	lts_KillCounter[MAX_PLAYERS]		= 0,
	PlayerText:KillCounter[MAX_PLAYERS] 	,
	lsm_roundtimer[MAX_PLAYERS][2]			,
	lts_playerdead[MAX_PLAYERS]				,
	PlayerText:DeathTD[MAX_PLAYERS]			,
	
	Float:JoinPos[MAX_PLAYERS][3]			, // x,y,z 
	JoinSettings[MAX_PLAYERS][2]			, // vw, interior
	
	// Server Vars
	bool: lsm_created 					= (false),
	bool: lsm_locked					= (false),
	bool:lsm_started 					= (false),
	lsm_player_counter 					= 0,
	lsm_starttimer[MAX_PLAYERS] 		= -1,
	lsm_counter[MAX_PLAYERS] 			= LSM_MATCH_COUNTER,
	lsm_tipstimer 						= -1,
	PlayerText:LTSHUD[MAX_PLAYERS][8]	,
	lsm_countertimer[MAX_PLAYERS]			,
	
	lts_veh[MAX_EVENT_CARS]					,
	
	// Supply Drop
	supply_counter						= 0,
	supply_type							= 0,
	supply_object[3]					= INVALID_OBJECT_ID,
	
	// Items
	ITEMS_PICKUP[MAX_PLAYERS][10]			,
	Iterator: E_ITEMS 					<MAX_E_ITEMS>;


new 
	lsm_eventTips[4][] = {
    "[EVENT TIPS]: Oruzje koje pronadjete na podu, mozete pokupiti sa 'Y'.",
    "[EVENT TIPS]: Ukoliko prvi dodjete do supply-a drop-a, mozete pokupiti odlicne stvari.",
	"[EVENT TIPS]: Svakih nekoliko minuta pada supply drop na razlicite lokacije.",
    "[EVENT TIPS]: Da razgovarate sa svojim prijateljima u team-u, koristite /lts tc [poruka]."
};


new 
	Float:TEAM_RED_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2616.7524,2325.8428,8.1759}, {-2615.0518,2325.8674,8.2053}, {-2612.5728,2325.6804,8.2095}, {-2616.0356,2323.8987,8.1885}, {-2613.7793,2324.3047,8.2075}},
	Float:TEAM_BLUE_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2444.0276,2482.2375,15.3203}, {-2443.6533,2484.9233,15.3203}, {-2443.1816,2488.2375,15.3203}, {-2433.2629,2488.5063,13.7817}, {-2437.6379,2488.9507,13.7817}},
	Float:TEAM_GREEN_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2235.2373,2365.4016,4.9862}, {-2237.8804,2368.1360,4.9863}, {-2242.4731,2370.5691,4.9919}, {-2251.2603,2358.9329,4.9824}, {-2253.2393,2362.0938,4.9857}},
	Float:TEAM_YELLOW_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2461.8315,2232.4082,4.8438}, {-2463.3542,2233.3921,4.8438}, {-2464.5840,2231.9197,4.8438}, {-2465.6978,2233.6440,4.8058}, {-2467.6218,2232.6580,4.8089}},
	Float:TEAM_WHITE_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2512.6379,2354.6853,11.0610}, {-2514.4314,2355.6338,11.0610}, {-2516.9146,2354.9177,11.0610}, {-2519.1790,2354.5642,11.0610}, {-2521.8215,2355.2795,11.0610}},
	Float:TEAM_BLACK_RANDOM_SPAWN[MAX_PLAYERS_IN_TEAM][3] 	= { {-2405.9878,2383.9514,7.6246}, {-2406.7048,2385.7310,7.8609}, {-2405.7312,2381.1965,7.2423}, {-2408.1274,2379.3267,7.0692}, {-2405.9634,2377.7583,6.7862}}
	;

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (Last Team Standing Map by Carlos)
Removeltsmap(playerid) {
	RemoveBuildingForPlayer(playerid, 1315, -2729.219, 2365.770, 74.171, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, -2724.159, 2342.129, 74.367, 0.250);
	RemoveBuildingForPlayer(playerid, 1315, -2729.300, 2343.260, 74.257, 0.250);
	RemoveBuildingForPlayer(playerid, 9245, -2235.550, 2361.770, 15.804, 0.250);
	RemoveBuildingForPlayer(playerid, 9381, -2235.550, 2361.770, 15.804, 0.250);
	RemoveBuildingForPlayer(playerid, 1635, -2226.060, 2360.830, 6.398, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2360.050, 2372.229, 12.132, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2300.919, 2394.620, 12.632, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2281.110, 2380.229, 12.695, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2311.770, 2410.239, 12.562, 0.250);
	RemoveBuildingForPlayer(playerid, 1619, -2476.209, 2309.520, 7.468, 0.250);
	RemoveBuildingForPlayer(playerid, 1619, -2476.209, 2307.909, 7.468, 0.250);
	RemoveBuildingForPlayer(playerid, 9302, -2488.090, 2280.280, 11.187, 0.250);
	RemoveBuildingForPlayer(playerid, 9371, -2488.090, 2280.280, 11.187, 0.250);
	RemoveBuildingForPlayer(playerid, 1617, -2517.840, 2291.120, 12.023, 0.250);
	RemoveBuildingForPlayer(playerid, 9303, -2512.129, 2282.540, 9.257, 0.250);
	RemoveBuildingForPlayer(playerid, 9372, -2512.129, 2282.540, 9.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1617, -2504.719, 2291.120, 12.023, 0.250);
	RemoveBuildingForPlayer(playerid, 9300, -2512.229, 2309.040, 10.453, 0.250);
	RemoveBuildingForPlayer(playerid, 9370, -2512.229, 2309.040, 10.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1689, -2496.750, 2303.260, 15.875, 0.250);
	RemoveBuildingForPlayer(playerid, 1689, -2519.949, 2300.540, 13.679, 0.250);
	RemoveBuildingForPlayer(playerid, 1689, -2535.590, 2300.540, 13.679, 0.250);
	RemoveBuildingForPlayer(playerid, 1227, -2531.909, 2295.030, 4.757, 0.250);
	RemoveBuildingForPlayer(playerid, 1227, -2526.949, 2295.030, 4.757, 0.250);
	RemoveBuildingForPlayer(playerid, 1440, -2539.439, 2294.709, 4.390, 0.250);
	RemoveBuildingForPlayer(playerid, 1346, -2550.370, 2320.479, 5.320, 0.250);
	RemoveBuildingForPlayer(playerid, 1346, -2553.050, 2320.479, 5.320, 0.250);
	RemoveBuildingForPlayer(playerid, 1624, -2509.330, 2322.199, 13.617, 0.250);
	RemoveBuildingForPlayer(playerid, 1227, -2480.879, 2295.030, 4.757, 0.250);
	RemoveBuildingForPlayer(playerid, 1617, -2498.229, 2287.449, 7.679, 0.250);
	RemoveBuildingForPlayer(playerid, 1440, -2500.820, 2273.969, 4.460, 0.250);
	RemoveBuildingForPlayer(playerid, 1367, -2477.399, 2274.189, 4.601, 0.250);
	RemoveBuildingForPlayer(playerid, 1440, -2476.290, 2294.709, 4.390, 0.250);
	RemoveBuildingForPlayer(playerid, 1315, -2474.050, 2326.159, 7.164, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, -2473.010, 2325.060, 7.375, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 790.359, 371.445, 20.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1689, -2480.010, 2285.780, 18.859, 0.250);
	RemoveBuildingForPlayer(playerid, 9270, -2588.479, 2303.520, 11.218, 0.250);
	RemoveBuildingForPlayer(playerid, 9420, -2588.479, 2303.520, 11.218, 0.250);
	RemoveBuildingForPlayer(playerid, 9324, -2477.260, 2455.959, 21.539, 0.250);
	RemoveBuildingForPlayer(playerid, 9412, -2477.260, 2455.959, 21.539, 0.250);
	RemoveBuildingForPlayer(playerid, 9221, -2527.709, 2238.209, 6.273, 0.250);
	RemoveBuildingForPlayer(playerid, 9387, -2527.709, 2238.209, 6.273, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2454.949, 2404.659, 21.921, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2463.020, 2380.620, 17.289, 0.250);
	RemoveBuildingForPlayer(playerid, 647, -2461.860, 2407.820, 16.953, 0.250);
	RemoveBuildingForPlayer(playerid, 1223, -2609.449, 2324.020, 7.335, 0.250);
	RemoveBuildingForPlayer(playerid, 1408, -2606.050, 2355.239, 8.210, 0.250);
	RemoveBuildingForPlayer(playerid, 1408, -2606.060, 2349.810, 8.085, 0.250);
	RemoveBuildingForPlayer(playerid, 715, -2549.330, 2420.320, 23.859, 0.250);
	RemoveBuildingForPlayer(playerid, 767, -2531.679, 2426.770, 16.218, 0.250);
	return (true);
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (LTS textdraws)
ShowKillCounter(playerid, bool: show) {
	if(show == false) {
		PlayerTextDrawHide(playerid, KillCounter[playerid]);
		PlayerTextDrawDestroy(playerid, KillCounter[playerid]);
		KillCounter[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	else if(show == true) {
		KillCounter[playerid] = CreatePlayerTextDraw(playerid, 294.300201, 3.629623, "0");
		PlayerTextDrawLetterSize(playerid, KillCounter[playerid], 0.296666, 1.060741);
		PlayerTextDrawAlignment(playerid, KillCounter[playerid], 2);
		PlayerTextDrawColor(playerid, KillCounter[playerid], -1);
		PlayerTextDrawSetShadow(playerid, KillCounter[playerid], 0);
		PlayerTextDrawSetOutline(playerid, KillCounter[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, KillCounter[playerid], 255);
		PlayerTextDrawFont(playerid, KillCounter[playerid], 3);
		PlayerTextDrawSetProportional(playerid, KillCounter[playerid], 1);
		PlayerTextDrawSetShadow(playerid, KillCounter[playerid], 0);
		PlayerTextDrawShow(playerid, KillCounter[playerid]);
	}
	return (true);
}

ShowPlayerDeath(playerid, bool:show) {
	if(show == false) {
		PlayerTextDrawHide(playerid, DeathTD[playerid]);
		PlayerTextDrawDestroy(playerid, DeathTD[playerid]);
		DeathTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(show == true) {
		DeathTD[playerid] = CreatePlayerTextDraw( playerid, 325.000000, 175.000000, "you are dead~n~~w~respawning..." );
		PlayerTextDrawAlignment( playerid, DeathTD[playerid], 2 );
		PlayerTextDrawBackgroundColor( playerid, DeathTD[playerid], 255 );
		PlayerTextDrawFont( playerid, DeathTD[playerid], 3 );
		PlayerTextDrawLetterSize( playerid, DeathTD[playerid], 0.500000, 2.000000 );
		PlayerTextDrawColor( playerid, DeathTD[playerid], -8750337 );
		PlayerTextDrawSetOutline( playerid, DeathTD[playerid], 0 );
		PlayerTextDrawSetProportional( playerid, DeathTD[playerid], 1 );
		PlayerTextDrawSetShadow( playerid, DeathTD[playerid], 1 );
		PlayerTextDrawSetSelectable( playerid, DeathTD[playerid], 0 );
		PlayerTextDrawShow(playerid, DeathTD[playerid]);
	}
	return (true);
}


ShowLTShud(playerid, bool: status) {
	if(status == false) {
		for(new i = 0; i < 8; i++) {
			PlayerTextDrawHide(playerid, LTSHUD[playerid][i]);
			PlayerTextDrawDestroy(playerid, LTSHUD[playerid][i]);
			LTSHUD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	else if(status == true) {
		LTSHUD[playerid][0] = CreatePlayerTextDraw(playerid, 288.898345, 3.700100, "box");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][0], 0.000000, 1.316660);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][0], 300.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][0], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][0], 170);
		PlayerTextDrawUseBox(playerid, LTSHUD[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, LTSHUD[playerid][0], 170);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][0], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][0], 0);

		LTSHUD[playerid][1] = CreatePlayerTextDraw(playerid,273.797424, 3.600100, "box");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][1], 0.000000, 1.316660);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][1], 285.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][1], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][1], 170);
		PlayerTextDrawUseBox(playerid, LTSHUD[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, LTSHUD[playerid][1], 170);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][1], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][1], 0);

		LTSHUD[playerid][2] = CreatePlayerTextDraw(playerid,335.601196, 3.700100, "box");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][2], 0.000000, 1.316660);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][2], 346.702850, 0.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][2], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][2], 170);
		PlayerTextDrawUseBox(playerid, LTSHUD[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, LTSHUD[playerid][2], 170);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][2], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][2], 0);

		LTSHUD[playerid][3] = CreatePlayerTextDraw(playerid,270.299194, 1.770354, "");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][3], 18.000000, 14.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][3], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][3], 0);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, LTSHUD[playerid][3], 1313);
		PlayerTextDrawSetPreviewRot(playerid, LTSHUD[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		LTSHUD[playerid][4] = CreatePlayerTextDraw(playerid,351.302154, 3.700100, "box");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][4], 0.000000, 1.316660);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][4], 362.403808, 0.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][4], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][4], 170);
		PlayerTextDrawUseBox(playerid, LTSHUD[playerid][4], 1);
		PlayerTextDrawBoxColor(playerid, LTSHUD[playerid][4], 170);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][4], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][4], 0);

		LTSHUD[playerid][5] = CreatePlayerTextDraw(playerid,332.002960, 1.770354, "");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][5], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, LTSHUD[playerid][5], 18.000000, 14.000000);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][5], 1);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][5], 0);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][5], 5);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][5], 0);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][5], 0);
		PlayerTextDrawSetPreviewModel(playerid, LTSHUD[playerid][5], 1314);
		PlayerTextDrawSetPreviewRot(playerid, LTSHUD[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

		LTSHUD[playerid][6] = CreatePlayerTextDraw(playerid,357.366607, 4.188863, "20");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][6], 0.238666, 0.986074);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][6], 2);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][6], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][6], 3);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][6], 0);

		LTSHUD[playerid][7] = CreatePlayerTextDraw(playerid,317.400695, 2.988895, "00:00");
		PlayerTextDrawLetterSize(playerid, LTSHUD[playerid][7], 0.223333, 1.131259);
		PlayerTextDrawAlignment(playerid, LTSHUD[playerid][7], 2);
		PlayerTextDrawColor(playerid, LTSHUD[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, LTSHUD[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, LTSHUD[playerid][7], 255);
		PlayerTextDrawFont(playerid, LTSHUD[playerid][7], 1);
		PlayerTextDrawSetProportional(playerid, LTSHUD[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, LTSHUD[playerid][7], 0);
		
		for(new i = 0; i < 8; i++) {
			PlayerTextDrawShow(playerid, LTSHUD[playerid][i]);
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (simple functions)
GetTeamName(team_id) {
	new team_name[20];
	switch(team_id) {
		case 1: // TEAM 1
			team_name = "Red";
		case 2: // TEAM 2
			team_name = "Blue";
		case 3: // TEAM 3
			team_name = "Green";
		case 4: // TEAM 3
			team_name = "Yellow";
		case 5: // TEAM 3
			team_name = "White";
		case 6: // TEAM 3
			team_name = "Black";
		default:
			team_name = "N/A";
	}
	return team_name;
}

GetTeamColor(team_id) {
	switch(team_id) {
		case 1: // TEAM 1
			return COLOR_LIGHTRED;
		case 2: // TEAM 2
			return 0x8D8DFF00;
		case 3: // TEAM 3
			return COLOR_GREEN;
		case 4: // TEAM 4
			return COLOR_YELLOW;
		case 5: // TEAM 5
			return COLOR_WHITE;		
		case 6: // TEAM 6
			return COLOR_GREY;			
		default:
			return COLOR_WHITE;
	}
	return COLOR_WHITE;
}

ResetServerVars_lts() {
	// Reset Server Vars
	lsm_player_counter				= (0);
	lsm_created 					= (false);
	lsm_started 					= (false);
	lsm_locked						= (false);
	
	RemoveLTS_items();	
	supply_counter					= 0;
	supply_type						= 0;
	
	DestroyDynamicObject(supply_object[0]);
	DestroyDynamicObject(supply_object[1]);
	DestroyDynamicObject(supply_object[2]);
	
	supply_object[0]				= INVALID_OBJECT_ID;
	supply_object[1]				= INVALID_OBJECT_ID;
	supply_object[2]				= INVALID_OBJECT_ID;
	
	// Reset Server Timers
	KillTimer(lsm_tipstimer);
	
	// Reset Vehicles
	for(new i = 0; i < MAX_EVENT_CARS; i++) {
		AC_DestroyVehicle(lts_veh[i]);
		ResetVehicleInfo(lts_veh[i]);
	}
	return (true);
}

ResetPlayerVars_lts(playerid) {	
	if(lts_Joined[playerid] == true) {
		lsm_player_counter--;
	}
	
	if(lsm_started == true) {
		foreach(new i : Player) {
			if(lts_Joined[i] == true) {
				new buffer[5];
				
				format(buffer, sizeof(buffer), "%d", lsm_player_counter);
				PlayerTextDrawSetString(i, LTSHUD[i][6], buffer); 
			}
		}
	}
	// Reset Player Vars	
	lts_PlayerTeam[playerid]		= (-1);
	lts_LeaderTeam[playerid]		= (-1);
	
	lts_Alive[playerid]				= (false);
	lts_Joined[playerid] 			= (false);
	lts_KillCounter[playerid]		= 0;
	lsm_roundtimer[playerid][0]		= 0;
	lsm_roundtimer[playerid][1]		= 0;
	lsm_counter[playerid]			= (0);
	
	PLAYER_EVENT[playerid][Helmet] 		= (false);
	PLAYER_EVENT[playerid][Vest]		= (false);
	PLAYER_EVENT[playerid][Canister] 	= (false);
	Bit1_Set(gr_OnEvent, playerid, false);
	
	for (new i = 0; i < 10; i ++) {
		ITEMS_PICKUP[playerid][i] = -1;
	}

	RemovePlayerAttachedObject(playerid, E_OBJECT_SLOT_HELMET);
	RemovePlayerAttachedObject(playerid, E_OBJECT_SLOT_VEST);
	RemovePlayerAttachedObject(playerid, E_OBJECT_SLOT_CANISTER);
	KillTimer(lsm_countertimer[playerid]);
	KillTimer(lsm_starttimer[playerid]);

	// Reset Textdraws
	ShowKillCounter(playerid, false);
	ShowLTShud(playerid, false);
	ShowPlayerDeath(playerid, false);
	return (true);
}

SendTeamMessage(team_id, team_color, message[]) {
	foreach(new i : Player) {
		if(lts_PlayerTeam[i] == team_id) {
			SendClientMessage(i, team_color, message);
			PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (LTS functions)
Createlts() { //main.
	new vehicle_type 	= minrand(1,2),
		randomfuel 		= minrand(15, 30),
		randomcol 		= minrand(0, 250),
		randomhp		= minrand(400, 800),
		
		random_ammo	    = minrand(4, 15),
		
		ammo_box_small	= minrand(5, 15),
		ammo_box_medium = minrand(15,30),
		ammo_box_big 	= minrand(30,50);
	
	if(vehicle_type == 1) {
		lts_veh[0] = AC_CreateVehicle(500, -2256.6694,2293.2380,4.9340,88.9233, randomcol, randomcol, 60000,0);
		lts_veh[1] = AC_CreateVehicle(605, -2375.3406,2216.6743,4.8050,357.4649, randomcol, randomcol, 60000,0);
		lts_veh[2] = AC_CreateVehicle(604, -2626.6216,2496.7837,27.7578,351.4949, randomcol, randomcol, 60000,0);
		
		Createlts_vehicles(lts_veh[0], 500, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
		Createlts_vehicles(lts_veh[1], 605, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
		Createlts_vehicles(lts_veh[2], 604, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
		
	}
	else if(vehicle_type == 2) {
		lts_veh[0] = AC_CreateVehicle(500, -2433.8076,2316.8071,5.0817,179.7349, randomcol, randomcol, 60000,0);
		lts_veh[1] = AC_CreateVehicle(605, -2619.8284,2241.5945,4.7988,86.9852, randomcol, randomcol, 60000,0);
		lts_veh[2] = AC_CreateVehicle(604, -2287.6621,2579.4070,21.9063,286.2194, randomcol, randomcol, 60000,0);
		
		Createlts_vehicles(lts_veh[0], 500, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
		Createlts_vehicles(lts_veh[1], 605, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
		Createlts_vehicles(lts_veh[2], 604, randomfuel, VEHICLE_USAGE_EVENT, randomhp, EVENT_WORLD_ID);
	}
	
	// Weapons
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2526.13232, 2355.05933, 3.97690,   94.51981, -246.81877, -133.00000); // ak47
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2446.26123, 2305.36157, 3.98540,   94.51980, -246.81880, -258.39981);
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2576.00732, 2387.44214, 11.46910,   93.00000, -245.00000, -157.00000);
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2183.81665, 2417.94897, 3.96640,   97.00000, -247.00000, -108.00022);
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2716.08228, 2359.85303, 70.48390,   94.51980, -246.81880, -134.86099);
	Createlts_items(355, "AK47", random_ammo,E_ITEM_TYPE_WEAPON,(30), 	-2307.25879, 2390.75757, 9.02470,   97.00000, -247.00000, -135.00000);
	
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2491.77539, 2356.91382, 9.09870,   94.51980, -246.81880, -202.83968); // mp5
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2573.74268, 2281.97217, 5.07100,   88.00000, -247.00000, -135.00000);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2534.07520, 2312.12549, 3.79110,   94.51980, -246.81880, -181.36040);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2597.87109, 2352.18481, 9.80810,   94.51980, -246.81880, -134.86099);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2435.87817, 2400.28906, 12.12350,   94.51980, -246.81880, -134.86099);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2367.29199, 2377.42188, 4.05560,   99.00000, -245.00000, -135.00000);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2610.68555, 2536.69360, 26.79700,   89.00000, -247.00000, -135.00000);
	Createlts_items(353, "MP5", random_ammo,E_ITEM_TYPE_WEAPON,(29),	-2534.23169, 2459.68018, 18.02650,   89.00000, -247.00000, -55.00000);
	
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2490.17310, 2300.47559, 0.22670,   94.51980, -246.81880, -134.86099); // shotgun
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2510.95313, 2399.69604, 15.86210,   94.51980, -246.81880, -134.86099);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2428.42627, 2277.21167, 3.97810,   94.51980, -246.81880, -134.86099);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2337.91309, 2346.13574, 3.95060,   97.00000, -245.00000, -129.00000);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2511.50854, 2529.50610, 17.89730,   97.00000, -247.00000, -135.00000);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2473.78052, 2404.71289, 15.63470,   97.00000, -247.00000, -135.00000);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2353.02905, 2458.86084, 5.92340,   97.00000, -247.00000, -135.00000);
	Createlts_items(349, "SHOTGUN", random_ammo,E_ITEM_TYPE_WEAPON,(25),	-2633.94165, 2422.48511, 12.96710,   99.00000, -247.00000, -183.17986);
	
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2426.67993, 2333.13989, 3.83090,   94.51980, -246.81880, -134.86099); // deagle
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2496.67603, 2278.91772, 9.33000,   94.51980, -246.81880, -180.75970);
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2604.86499, 2263.44116, 7.47810,   94.51980, -246.81880, -28.48110);
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2377.22900, 2215.72607, 3.96570,   94.51980, -246.81880, -191.98039);
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2537.30566, 2421.91284, 22.34260,   113.00000, -247.00000, -135.00000);
	Createlts_items(348, "DESERT EAGLE", random_ammo,E_ITEM_TYPE_WEAPON,(24),	-2336.80688, 2433.31934, 6.30590,   94.51980, -246.81880, -134.86099);
	
	Createlts_items(357, "COUNTY RIFLE", random_ammo,E_ITEM_TYPE_WEAPON,(33),	-2251.98926, 2567.50659, 3.71920,   87.00000, -247.00000, -135.00000); // sniper
	Createlts_items(357, "COUNTY RIFLE", random_ammo,E_ITEM_TYPE_WEAPON,(33),	-2630.16870, 2483.74707, 44.40210,   94.51980, -246.81880, -134.86099);
	Createlts_items(357, "COUNTY RIFLE", random_ammo,E_ITEM_TYPE_WEAPON,(33),	-2296.58179, 2225.66577, 3.96400,   99.00000, -247.00000, -135.00000);

	// Ammo boxes
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2526.97339, 2355.16748, 4.08520,   0.00000, 0.00000, 18.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2490.32202, 2299.91382, 0.34390,   0.00000, 0.00000, 0.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2496.06421, 2279.03955, 9.39670,   0.00000, 0.00000, 0.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2490.32202, 2299.91382, 0.34390,   0.00000, 0.00000, 0.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2496.06421, 2279.03955, 9.39670,   0.00000, 0.00000, 0.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2573.92676, 2281.56226, 5.26080,   0.00000, 0.00000, 37.38002);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2511.40063, 2399.39795, 15.94370,   0.00000, 0.00000, 0.00000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2337.02026, 2346.40942, 4.07870,   0.00000, 0.00000, 18.54000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2716.07373, 2360.69824, 70.57570,   0.00000, 0.00000, -39.77999);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2510.85327, 2529.64600, 18.01720,   0.00000, 0.00000, -0.30000);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2473.98315, 2405.45386, 15.76130,   0.00000, 0.00000, -83.69995);
	Createlts_items(2043, "MEDIUM AMMO BOX", ammo_box_medium,E_ITEM_TYPE_AMMO,(-1), -2633.92725, 2423.40503, 13.08890,   0.00000, 0.00000, 0.00000);
	
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2492.29126, 2356.92725, 9.16150,   0.00000, 0.00000, 44.21996);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2446.09619, 2304.82788, 4.03360,   0.00000, 0.00000, -85.08000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2533.65942, 2312.03174, 3.83920,   0.00000, 0.00000, 0.00000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2604.85522, 2263.13135, 7.53450,   0.00000, 0.00000, 43.14000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2428.77417, 2276.81860, 4.03130,   0.00000, 0.00000, 0.00000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2435.21240, 2400.15381, 12.18300,   0.00000, 0.00000, 0.00000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2629.24292, 2483.66113, 44.48420,   0.00000, 0.00000, -95.22002);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2251.34863, 2567.53955, 3.78870,   7.20000, 7.62000, 0.00000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2296.68604, 2225.22437, 4.04830,   0.00000, 0.00000, 0.00000);
	Createlts_items(2039, "SMALL AMMO BOX", ammo_box_small,E_ITEM_TYPE_AMMO,(-1),	 -2436.07324, 2446.95654, 28.53970,   0.00000, 0.00000, 0.00000);

	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2427.24561, 2333.24854, 3.94690,   0.00000, 0.00000, -81.66004);
	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2551.75708, 2344.14233, 4.10100,   0.00000, 0.00000, -46.80005);
	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2377.09253, 2216.21875, 4.10960,   0.00000, 0.00000, -53.82000);
	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2184.43799, 2418.65674, 4.11050,   0.00000, 0.00000, -54.84000);
	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2307.97412, 2391.29077, 9.16890,   0.00000, 0.00000, -68.09997);
	Createlts_items(2358, "BIG AMMO BOX", ammo_box_big,E_ITEM_TYPE_AMMO,(-1),	 -2264.56030, 2383.93335, 4.09110,   0.00000, 0.00000, -46.38002);

	
	// Health
	Createlts_items(11738, "HEALTH BOX",  minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2343.61328, 2441.00952, 6.33850,   0.00000, 0.00000, -66.18005);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2344.44019, 2388.43335, 5.00450,   0.00000, 0.00000, 0.00000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2331.07715, 2290.55298, 2.53220,   0.00000, 0.00000, -41.46004);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2533.00220, 2265.07544, 4.01320,   0.00000, 0.00000, 36.90003);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2544.97876, 2347.94897, 11.97700,   0.00000, 0.00000, 38.10000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2505.07129, 2417.15894, 15.62840,   0.00000, 0.00000, 19.26000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2451.16748, 2352.84790, 3.99280,   0.00000, 0.00000, 41.70000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2434.41602, 2281.47559, 5.09670,   0.00000, 0.00000, 28.50000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2376.31763, 2457.36743, 9.04820,   -10.00000, 0.00000, 0.00000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2229.60645, 2467.08667, 4.03240,   0.00000, 0.00000, -59.04002);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2618.05566, 2423.18213, 13.45520,   -2.00000, -6.00000, 0.00000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2497.82031, 2282.48926, 16.50560,   -6.00000, 14.00000, 0.00000);
	Createlts_items(11738, "HEALTH BOX",   minrand(30, 80), E_ITEM_TYPE_HEALTH, (-1), -2623.05249, 2242.74316, 4.02990,   0.00000, 0.00000, 49.02000);
	
	
	// Helmet			  			   Armour
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2429.20679, 2494.14697, 12.69090,   185.00000, 76.00000, 273.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2335.68677, 2478.61523, 0.22990,   4.00000, -105.00000, 0.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2200.28027, 2411.88184, 1.47320,   193.00000, 69.00000, -40.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2183.51416, 2416.07642, 4.25900,   207.00000, 91.00000, -4.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2272.11768, 2285.31348, 4.09340,   0.00000, -105.00000, 0.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2433.91064, 2223.97754, 4.51180,   -4.00000, -98.00000, 0.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2468.22681, 2225.71973, 19.46790,   -11.00000, -105.00000, -84.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2496.93237, 2278.37769, 9.35680,   4.00000, -105.00000, 0.00000);
	Createlts_items(19141, "HELMET",    (48), E_ITEM_TYPE_HELMET, (-1), -2518.95020, 2235.06152, 4.00300,   4.00000, -91.00000, -55.00000);
	
	// Vest
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2434.80078, 2445.08594, 28.78291,   0.00000, -91.00000, 11.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2321.47070, 2366.15894, 5.19450,   0.00000, -91.00000, 69.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2331.41040, 2304.32813, 2.73850,   0.00000, -91.00000, 360.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2290.80347, 2287.04639, 4.42880,   0.00000, -91.00000, 200.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2227.92700, 2292.81494, 5.71590,   0.00000, -91.00000, 265.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2186.02441, 2419.49487, 4.28671,   0.00000, -91.00000, 316.00000);
	Createlts_items(19515, 	"VEST",    	(50), E_ITEM_TYPE_VEST,   (-1), -2274.05786, 2366.17578, 4.66590,   0.00000, -91.00000, 1.90901);
	
	// Canister
	Createlts_items(1650, 	"CANISTER",    	(-1), E_ITEM_TYPE_OTHER,   (-1), -2266.88965, 2368.85156, 5.08590,   0.00000, 0.00000, 98.00000);
	Createlts_items(1650, 	"CANISTER",    	(-1), E_ITEM_TYPE_OTHER,   (-1), -2251.41626, 2334.58716, 4.33890,   0.00000, 0.00000, 0.00000);
	Createlts_items(1650, 	"CANISTER",    	(-1), E_ITEM_TYPE_OTHER,   (-1), -2447.52197, 2514.00928, 15.01560,   0.00000, 0.00000, 89.00000);
	Createlts_items(1650, 	"CANISTER",    	(-1), E_ITEM_TYPE_OTHER,   (-1), -2628.19189, 2423.70117, 13.34350,   0.00000, 0.00000, 171.53880);
	return (true);
}

Createlts_vehicles(vehicleid, modelid, Fuelv, veh_type = VEHICLE_USAGE_EVENT, Float: veh_hp, vw = EVENT_WORLD_ID) {
	new engine, lights, alarm, doors, bonnet, boot, objective;
	ResetVehicleInfo(vehicleid);
	
	VehicleInfo[ vehicleid ][ vModel ] 		= modelid;
	VehicleInfo[ vehicleid ][ vHealth ]		= veh_hp;
	VehicleInfo[ vehicleid ][ vType ]		= veh_type;
	VehicleInfo[ vehicleid ][ vUsage ] 		= VEHICLE_USAGE_NORMAL;
	VehicleInfo[ vehicleid ][ vInt ]		= 0;
	VehicleInfo[ vehicleid ][ vViwo ]		= 0;
	VehicleInfo[ vehicleid ][ vFuel ] 		= Fuelv;
	VehicleInfo[ vehicleid ][ vViwo ]		= vw;
	
	AC_SetVehicleHealth(vehicleid, veh_hp);
	SetVehicleVirtualWorld(vehicleid, vw);
	GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	return (true);
}

Createlts_items(item_id, item_name[], item_amount, item_type = E_ITEM_TYPE_NONE, WEAPON_ID = -1, Float: X, Float: Y, Float: Z, Float: RotX, Float: RotY, Float: RotZ) {
	new i = Iter_Free(E_ITEMS), buffer[30];
	
	EVENT_ENUM[i][Item_ID] 			= item_id; // model.
	EVENT_ENUM[i][Item_Weapon]		= WEAPON_ID;
	EVENT_ENUM[i][Item_Type]		= item_type;
    EVENT_ENUM[i][Item_Amount] 		= item_amount;
    EVENT_ENUM[i][Item_PosX] 		= X;
    EVENT_ENUM[i][Item_PosY] 		= Y;
    EVENT_ENUM[i][Item_PosZ] 		= Z;

	SetString(EVENT_ENUM[i][Item_Name], item_name);
	
	// spawn object.
	format(buffer, sizeof(buffer), "{C3C3C3}[ %s ]\n 'Y'", item_name);
    EVENT_ENUM[i][Item_Object] = CreateDynamicObject(item_id, X, Y, Z, RotX, RotY, RotZ, EVENT_WORLD_ID);
	EVENT_ENUM[i][Item_Text3D] = CreateDynamic3DTextLabel(buffer, -1, X, Y, Z, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, EVENT_WORLD_ID, 0);
	
	Iter_Add(E_ITEMS, i); 
	return (true);
}

CreateLTS_Markers(playerid) {
	foreach(new i : Player) {
		if(lts_PlayerTeam[playerid] == lts_PlayerTeam[i]) {
			SetPlayerMarkerForPlayer(playerid, i, GetTeamColor(lts_PlayerTeam[playerid]));
		}
	}
	return (true);
}

CreateLTS_teams(playerid, team_id) {
	// Reset Player Vars
	for(new i = 0; i < 9; i++) {
		RemovePlayerAttachedObject(playerid, i);
	}
	
	new random_spawn;
	if(team_id == TEAM_RED) {
		random_spawn = random(sizeof(TEAM_RED_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_RED_RANDOM_SPAWN[random_spawn][0], TEAM_RED_RANDOM_SPAWN[random_spawn][1], TEAM_RED_RANDOM_SPAWN[random_spawn][2]);			
	}
	else if(team_id == TEAM_BLUE) {
		random_spawn = random(sizeof(TEAM_BLUE_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_BLUE_RANDOM_SPAWN[random_spawn][0], TEAM_BLUE_RANDOM_SPAWN[random_spawn][1], TEAM_BLUE_RANDOM_SPAWN[random_spawn][2]);
	}
	else if(team_id == TEAM_GREEN) {
		random_spawn = random(sizeof(TEAM_GREEN_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_GREEN_RANDOM_SPAWN[random_spawn][0], TEAM_GREEN_RANDOM_SPAWN[random_spawn][1], TEAM_GREEN_RANDOM_SPAWN[random_spawn][2]);
	}
	else if(team_id == TEAM_YELLOW) {
		random_spawn = random(sizeof(TEAM_YELLOW_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_YELLOW_RANDOM_SPAWN[random_spawn][0], TEAM_YELLOW_RANDOM_SPAWN[random_spawn][1], TEAM_YELLOW_RANDOM_SPAWN[random_spawn][2]);
	}
	else if(team_id == TEAM_WHITE) {
		random_spawn = random(sizeof(TEAM_WHITE_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_WHITE_RANDOM_SPAWN[random_spawn][0], TEAM_WHITE_RANDOM_SPAWN[random_spawn][1], TEAM_WHITE_RANDOM_SPAWN[random_spawn][2]);
	}
	else if(team_id == TEAM_BLACK) {
		random_spawn = random(sizeof(TEAM_BLACK_RANDOM_SPAWN));
		SetPlayerPos(playerid, TEAM_BLACK_RANDOM_SPAWN[random_spawn][0], TEAM_BLACK_RANDOM_SPAWN[random_spawn][1], TEAM_BLACK_RANDOM_SPAWN[random_spawn][2]);
	}
	
	// Set Player Vars
	SetPlayerHealth(playerid, 99.0);
	SetPlayerVirtualWorld(playerid, EVENT_WORLD_ID);
	
	PLAYER_EVENT[playerid][Helmet] 		= (false);
	PLAYER_EVENT[playerid][Vest]		= (false);
	PLAYER_EVENT[playerid][Canister] 	= (false);
	lts_Alive[playerid]					= (true);
	
	CreateLTS_Markers(playerid);
	TogglePlayerControllable(playerid, false); 
	return (true);
}

RemoveLTS_items() {
	if(Iter_Count(E_ITEMS) == 0)
		return 1;
		
	foreach(new i: E_ITEMS) {
		DestroyDynamicObject(EVENT_ENUM[i][Item_Object]);
		DestroyDynamic3DTextLabel(EVENT_ENUM[i][Item_Text3D]);
		
		EVENT_ENUM[i][Item_ID] 			= -1;
		EVENT_ENUM[i][Item_Type]		= E_ITEM_TYPE_NONE;
		EVENT_ENUM[i][Item_Weapon]		= -1;
		EVENT_ENUM[i][Item_Amount] 		= -1;
		EVENT_ENUM[i][Item_PosX] 		= 0.0;
		EVENT_ENUM[i][Item_PosY] 		= 0.0;
		EVENT_ENUM[i][Item_PosZ] 		= 0.0;
	}
	Iter_Clear(E_ITEMS);
	return (true);
}

EventItems_Nearest(playerid) {
    for (new i = 0; i != MAX_E_ITEMS; i ++) if (IsPlayerInRangeOfPoint(playerid, 2.0, EVENT_ENUM[i][Item_PosX],EVENT_ENUM[i][Item_PosY],EVENT_ENUM[i][Item_PosZ])) {
	    return (i);
	}
	return (-1);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (supply drop functions)
Create_SDROP(sdrop_type) {
	if(sdrop_type == 1) {
		Createlts_items(358, 	"SNIPER RIFLE", 	minrand(10, 30), 	E_ITEM_TYPE_WEAPON, (34),	-2468.78687, 2330.76611, 3.87280,   -78.80000, 35.54000, 0.00000); 
		Createlts_items(348, 	"DESERT EAGLE", 	minrand(10,20), 	E_ITEM_TYPE_WEAPON, (24), 	-2470.66772, 2333.28125, 3.89320,   -99.00000, -6.00000, 91.00000); 
		Createlts_items(2358, 	"BIG AMMO BOX", 	minrand(30, 60), 	E_ITEM_TYPE_AMMO,  	(-1),	-2469.97119, 2332.56860, 3.95280,   0.00000, 0.00000, 273.00000);
		Createlts_items(2358, 	"BIG AMMO BOX", 	minrand(30,60), 	E_ITEM_TYPE_AMMO, 	(-1), 	-2466.97095, 2332.65186, 3.95280,   0.00000, 0.00000, 91.00000);
		Createlts_items(11738, 	"HEALTH BOX",  		minrand(30, 80), 	E_ITEM_TYPE_HEALTH, (-1), 	-2469.36987, 2334.03003, 3.87310,   0.00000, 0.00000, 0.00000);
		Createlts_items(11738, 	"HEALTH BOX",   	minrand(30, 80), 	E_ITEM_TYPE_HEALTH, (-1), 	-2467.66479, 2334.03711, 3.87310,   0.00000, 0.00000, 0.00000);
		Createlts_items(19141, 	"HELMET",    			(48), 			E_ITEM_TYPE_HELMET, (-1), 	-2467.02393, 2331.82324, 3.87250,   -11.00000, -91.00000, -105.00000);
		Createlts_items(19515, 	"VEST",    				(50), 			E_ITEM_TYPE_VEST, (-1), 	-2469.94043, 2330.93921, 4.09290,   0.00000, -91.00000, 178.00000);
		
		supply_object[1] = CreateDynamicObject(2973, -2468.470458, 2332.377441, 3.788570, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
		supply_object[2] = CreateDynamicObject(18728, -2468.450195, 2332.308593, 4.545934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
	}
	else if(sdrop_type == 2) {
		Createlts_items(356, 	"M4", 				minrand(20, 60), 	E_ITEM_TYPE_WEAPON, (31), 	-2352.72974, 2386.08838, 5.08350,   84.72010, -36.30000, 91.00000);
		Createlts_items(349, 	"SHOTGUN", 			minrand(20, 30), 	E_ITEM_TYPE_WEAPON, (25), 	-2350.83472, 2387.82715, 5.06750,   84.72010, -36.30000, 91.00000);
		Createlts_items(2358, 	"BIG AMMO BOX", 	minrand(30, 60), 	E_ITEM_TYPE_AMMO,  	(-1),	-2352.36499, 2385.44995, 5.19460,   0.00000, 0.00000, 273.00000);
		Createlts_items(2358, 	"BIG AMMO BOX", 	minrand(30, 60), 	E_ITEM_TYPE_AMMO,  	(-1),	-2350.76050, 2384.62671, 5.05510,   0.00000, 0.00000, 0.00000);
		Createlts_items(19515, 	"VEST",    				(50), 			E_ITEM_TYPE_VEST, 	(-1), 	-2349.64624, 2385.71118, 5.24550,   0.00000, -91.00000, -76.00000);
		Createlts_items(19515, 	"VEST",    				(50), 			E_ITEM_TYPE_VEST,	(-1), 	-2349.61157, 2386.85620, 5.24550,   0.00000, -91.00000, -76.00000);
		
		supply_object[1] = CreateDynamicObject(2973, -2350.994628, 2386.139404, 4.969938, 1.800000, 2.499999, 0.000000, -1, -1, -1, 600.00, 600.00); 
		supply_object[2] = CreateDynamicObject(18728, -2350.852050, 2386.115722, 5.876105, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
	}
	else if(sdrop_type == 3) {
		Createlts_items(353, 	"MP5", 				minrand(40, 60), 	E_ITEM_TYPE_WEAPON, (29), 	-2489.47925, 2453.70996, 15.69760,   82.89990, -98.16010, 98.00000);
		Createlts_items(355, 	"AK47", 			minrand(20, 50), 	E_ITEM_TYPE_WEAPON, (30), 	-2488.45947, 2452.42041, 15.58760,   88.70000, -101.71998, 33.00000);
		Createlts_items(19141, 	"HELMET",    			(48), 			E_ITEM_TYPE_HELMET, (-1), 	 -2491.40503, 2452.39209, 15.71470,   0.00000, -91.00000, 84.00000);
		Createlts_items(19141, 	"HELMET",    			(48), 			E_ITEM_TYPE_HELMET, (-1), 	-2491.49683, 2451.39868, 15.71470,   0.00000, -91.00000, 84.00000);
		Createlts_items(2358, 	"BIG AMMO BOX", 	minrand(30, 60), 	E_ITEM_TYPE_AMMO,  	(-1),	-2490.63184, 2450.56665, 15.65740,   0.00000, 0.00000, 0.00000);
		Createlts_items(11738, 	"HEALTH BOX",  		minrand(30, 80), 	E_ITEM_TYPE_HEALTH, (-1), 	-2489.65112, 2450.50293, 15.54440,   0.00000, 0.00000, 0.00000);
		
		supply_object[1] = CreateDynamicObject(2973, -2489.998535, 2451.908935, 15.505872, 0.000000, 2.999999, 0.000000, -1, -1, -1, 600.00, 600.00); 
		supply_object[2] = CreateDynamicObject(18728, -2489.791015, 2451.966308, 16.429660, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	}
	DestroyDynamicObject(supply_object[0]);
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (player / server => functions)
PlayerLootItem(playerid, item_id, item_type = E_ITEM_TYPE_NONE, item_amount) {
	new buffer[64], gunname[32], Float:oldhealth, Float:oldarmour;
	GetWeaponName(EVENT_ENUM[item_id][Item_Weapon], gunname, sizeof(gunname));
		
	if(item_type == E_ITEM_TYPE_AMMO) {
		new weaponid = AC_GetPlayerWeapon(playerid);
		if (!weaponid)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Ne drzite nikakvo oruzje u rukama.");
			
		format(buffer, sizeof(buffer), "~w~%s~n~+~g~%d~w~ ammo", gunname, item_amount);
		new ammo 	= AC_GetPlayerAmmo(playerid),
			total 	= ammo+item_amount;
			
		AC_SetPlayerAmmo(playerid, weaponid, total);
		GameTextForPlayer(playerid, buffer, 5000, 4);
	}
		
	if(item_type == E_ITEM_TYPE_WEAPON) {
		format(buffer, sizeof(buffer), "~w~%s~n~+~g~%d~w~ ammo", gunname, item_amount);
		AC_GivePlayerWeapon(playerid, EVENT_ENUM[item_id][Item_Weapon], item_amount);
		
		GameTextForPlayer(playerid, buffer, 5000, 4);
	}
	
	if(item_type == E_ITEM_TYPE_HEALTH) {
		GetPlayerHealth(playerid, oldhealth);
		if(oldhealth > 90) 
			return SendErrorMessage(playerid, "Ne mozete pokupiti health, vec vam je health visok (90+).");
		format(buffer, sizeof(buffer), "~w~HEALTH~n~+~g~%d", item_amount);
		GetPlayerHealth(playerid, oldhealth);
		SetPlayerHealth(playerid, oldhealth + item_amount);
		
		GameTextForPlayer(playerid, buffer, 5000, 4);
	}
	
	if(item_type == E_ITEM_TYPE_HELMET) {
		GetPlayerArmour(playerid, oldarmour);
		if(oldarmour > 98) 
			return SendErrorMessage(playerid, "Vec imate maximalan armour na sebi.");
			
		if(PLAYER_EVENT[playerid][Helmet] == true)
			return SendErrorMessage(playerid, "Vec imate kacigu na sebi.");
			
		format(buffer, sizeof(buffer), "~w~HELMET - ARMOUR~n~+~g~%d", item_amount);
		SetPlayerArmour(playerid, oldarmour+item_amount);
		Bit1_Set(gr_SaveArmour, playerid, true);
		PLAYER_EVENT[playerid][Helmet] = true;

		GameTextForPlayer(playerid, buffer, 5000, 4);
		SetPlayerAttachedObject( playerid, E_OBJECT_SLOT_HELMET, 19141, 2, 0.094478, 0.007213, 0.000000, 0.000000, 0.000000, 0.000000, 1.200000, 1.200000, 1.200000 );
	}	
	
	if(item_type == E_ITEM_TYPE_VEST) {
		GetPlayerArmour(playerid, oldarmour);
		if(oldarmour > 98) 
			return SendErrorMessage(playerid, "Vec imate maximalan armour na sebi.");
		
		if(PLAYER_EVENT[playerid][Vest] == true)
			return SendErrorMessage(playerid, "Vec imate prsluk na sebi.");
			
		format(buffer, sizeof(buffer), "~w~VEST - ARMOUR~n~+~g~%d", item_amount);
		SetPlayerArmour(playerid, oldarmour+item_amount);
		
		Bit1_Set(gr_SaveArmour, playerid, true);
		PLAYER_EVENT[playerid][Vest] = true;
		
		GameTextForPlayer(playerid, buffer, 5000, 4);
		SetPlayerAttachedObject(playerid, E_OBJECT_SLOT_VEST, 19515, 1, 0.0075, 0.01, -0.02, -12.33, -1.80, 8.79, 1.25, 1.21, 1.24);
	}
	
	if(item_type == E_ITEM_TYPE_OTHER) {
		if(PLAYER_EVENT[playerid][Canister] == true)
			return SendErrorMessage(playerid, "Vec imate kanister u ruci, da ga iskoristite otidjite u vozilo i stisnite 'N'.");
		
		GameTextForPlayer(playerid, "~g~+~w~CANISTER", 5000, 4);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Da iskoristite kanister, otidjite u vozilo i pritisnite 'N'.");
		
		PLAYER_EVENT[playerid][Canister] = true;		
		SetPlayerAttachedObject( playerid, E_OBJECT_SLOT_CANISTER, 1650, 6, 0.145482, 0.035119, 0.040793, 8.881844, 276.183959, 329.795593, 1.561557, 1.177534, 1.265636 );
	}
	
	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
	// Reset Event Enum Vars
	DestroyDynamicObject(EVENT_ENUM[item_id][Item_Object]);
	DestroyDynamic3DTextLabel(EVENT_ENUM[item_id][Item_Text3D]);
	
	EVENT_ENUM[item_id][Item_ID] 			= -1;
	EVENT_ENUM[item_id][Item_Type]			= E_ITEM_TYPE_NONE;
    EVENT_ENUM[item_id][Item_Amount] 		= -1;
	EVENT_ENUM[item_id][Item_PosX] 			= 0.0;
	EVENT_ENUM[item_id][Item_PosY] 			= 0.0;
	EVENT_ENUM[item_id][Item_PosZ] 			= 0.0;
	
	Iter_Remove(E_ITEMS, item_id);
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (timers)
Function: PlayerDiedEvent(playerid) {
	// playerid.
	SetPlayerVirtualWorld(playerid, JoinSettings[playerid][0]);
	SetPlayerInterior(playerid, JoinSettings[playerid][1]);
	SetPlayerPos(playerid, JoinPos[playerid][0], JoinPos[playerid][1], JoinPos[playerid][2]);
	
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	TogglePlayerControllable(playerid, (true));
	ShowPlayerDeath(playerid, false);
	
	lts_Alive[playerid]	= (false);
										
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Spawn-ovali ste se na poziciju na kojoj ste bili prije nego sto ste se pridruzili eventu.");
	
	// Destroy 
	JoinPos[playerid][0] = (0.0);
	JoinPos[playerid][1] = (0.0);
	JoinPos[playerid][2] = (0.0);
	lts_playerdead[playerid] = INVALID_PLAYER_ID;
	KillTimer(lts_playerdead[playerid]);
	return (true);
}

Function: SendEventTimer_LTS(playerid) { 
	new buffer[28];
	lsm_roundtimer[playerid][0]++;
	
	if(lsm_roundtimer[playerid][0] == 60) {
		lsm_roundtimer[playerid][1]++;
		lsm_roundtimer[playerid][0] = 0;
	}
	
	format(buffer, sizeof(buffer), "%02d:%02d", lsm_roundtimer[playerid][1], lsm_roundtimer[playerid][0]);
	PlayerTextDrawSetString(playerid, LTSHUD[playerid][7], buffer);  
	return (true);
}

Function: CounterToStart_LSM(playerid) {
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	va_GameTextForPlayer(playerid, "~g~LAST TEAM STANDING~n~~w~EVENT STARTS IN: ~g~%d s.", 1000, 4, lsm_counter[playerid]);
		
	lsm_counter[playerid]--;
	
	if(lsm_counter[playerid] == 0) {
		new buffer[10];
		GameTextForPlayer(playerid, "~g~Last Team Standing~n~~w~GO GO GO!.", 2000, 4);
		lsm_tipstimer = SetTimer("EventSettings", 60000*3, true);
		KillTimer(lsm_starttimer[playerid]);
				
				
		TogglePlayerControllable(playerid, true); 
		ShowLTShud(playerid, true); 
		ShowKillCounter(playerid, true);
		lsm_countertimer[playerid] = SetTimerEx("SendEventTimer_LTS", 1000, true, "i", playerid);
						
		format(buffer, sizeof(buffer), "%d", lsm_player_counter);
		PlayerTextDrawSetString(playerid, LTSHUD[playerid][6], buffer);
	}
	return (true);
}

Function: EventSettings() {
	new pick_random = random(sizeof(lsm_eventTips));
	foreach(new i : Player) {
		if(lts_Joined[i] == true) {
			SendClientMessage(i, COLOR_GREEN, lsm_eventTips[pick_random]);
			break;
		}
	}
	supply_counter++; // svakih 6 minuta padne supply drop.
	if(supply_counter == 2) {
		supply_counter = 0;
		
		new sDROP_type = minrand(1,3); 
	
		DestroyDynamicObject(supply_object[0]);
		DestroyDynamicObject(supply_object[1]);
		DestroyDynamicObject(supply_object[2]);
		
		if(sDROP_type == 1) {
			supply_object[0] = CreateDynamicObject(18849, -2468.425292, 2332.360107, 341.940826, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2468.470458, 2332.377441, 3.788570, 10.0);
		}
		else if(sDROP_type == 2) {
			supply_object[0] = CreateDynamicObject(18849, -2489.874511, 2451.750244, 352.470550, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2350.994628, 2386.139404, 4.969938, 10.0);
		}
		else if(sDROP_type == 3) {
			supply_object[0] = CreateDynamicObject(18849, -2350.904785, 2386.480224, 342.770538, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2489.998535, 2451.908935, 15.505872, 10.0);
		}
		supply_type = sDROP_type;
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hooks)
hook OnPlayerDisconnect(playerid, reason) {
	if(lts_Joined[playerid] == true) {
		AC_ResetPlayerWeapons(playerid);
		ResetPlayerVars_lts(playerid);
	}
	return (true);
}

hook OnPlayerConnect(playerid) {
	ResetPlayerVars_lts(playerid);
	return (true);
}

hook OnGameModeInit() {
	ResetServerVars_lts();
	return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if( newkeys == KEY_YES ) {
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK) {
			if(lts_Joined[playerid] == true) {
				new items_around = 0, string[256], item_id = EventItems_Nearest(playerid), buffer[256];
				
				if (item_id != -1) {
					for (new i = 0; i < MAX_E_ITEMS; i ++) if (items_around < 10 && IsPlayerInRangeOfPoint(playerid, 2.0, EVENT_ENUM[i][Item_PosX],EVENT_ENUM[i][Item_PosY],EVENT_ENUM[i][Item_PosZ])) {
						ITEMS_PICKUP[playerid][items_around++] = i;
						
						format(buffer, sizeof(buffer), "{3C95C2}[%d]. - %s.", items_around, EVENT_ENUM[i][Item_Name]);
						strcat(string, buffer);
						strcat(string, "\n");
					}
					if (items_around == 1) {
						PlayerLootItem(playerid, item_id, EVENT_ENUM[item_id][Item_Type], EVENT_ENUM[item_id][Item_Amount]);
					}
					else ShowPlayerDialog(playerid, DIALOG_PICKUP_ITEM, DIALOG_STYLE_LIST, "{3C95C2}* [ ITEMS - PICKUP]", string, "(uzmi)", "(x)");
				}
			}
		}
	}
	if( newkeys == KEY_NO ) {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			if(lts_Joined[playerid] == true) {
				if(PLAYER_EVENT[playerid][Canister] == true) {
					new random_fuel = minrand(5, 25);
					
					VehicleInfo[GetPlayerVehicleID(playerid)][vFuel] += random_fuel;
					PLAYER_EVENT[playerid][Canister] = false;
					RemovePlayerAttachedObject(playerid, E_OBJECT_SLOT_CANISTER);
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste nasipali gorivo u vozilu (+%d fuel).", random_fuel);
				}
			}
		}
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
	    case DIALOG_PICKUP_ITEM: {
			if (response) {
				new i = ITEMS_PICKUP[playerid][listitem];

				if (i != -1) {
					PlayerLootItem(playerid, i, EVENT_ENUM[i][Item_Type], EVENT_ENUM[i][Item_Amount]);
				}
			}
		}
	}
	return (true);
}

hook OnDynamicObjectMoved(objectid) {
	if(objectid == supply_object[0]) {
		foreach(new i : Player) {
			if(lts_Joined[i] == true)
				SendClientMessage(i, COLOR_RED, "[ ! ] Upravo je pao supply drop, pozurite da dodjete prvi do njega!");
		}
		Create_SDROP(supply_type);
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)
CMD:lts(playerid, params[]) {
	new action[15], string[128], target_id, team_id, message[128];
			
	if(sscanf(params, "s[15] ", action))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] /lts [option].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): join, quit.");
		if(lts_PlayerTeam[playerid] != -1)
			SendClientMessage(playerid, 0xAFAFAFAA, "(team): tc(chat), members.");
		if(lts_LeaderTeam[playerid] != -1)
			SendClientMessage(playerid, 0xAFAFAFAA, "(team leader): invite, tkick.");	
		if(PlayerInfo[playerid][pAdmin] != 0) {
			SendClientMessage(playerid, 0xAFAFAFAA, "(admin): create, maketeams, start, stop, checkteams, teamleader, createdrop.");
			SendClientMessage(playerid, 0xAFAFAFAA, "(admin): alive, createitem, goto, unlock, kick.");
		}	
		if(lsm_created == true) 
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Trenutno ucestvuje %d/%d osoba.", lsm_player_counter, MAX_EVENT_TEAMS*MAX_PLAYERS_IN_TEAM);
		return (true);
	}  
	
	if(strcmp(action,"alive", true) == 0) {
		SendClientMessage(playerid, COLOR_RED, "[ ! ] |______ [ LTS - ALIVE ] ______|");
		foreach(new i : Player) {	
			if(lts_Joined[i] == true) {
				if(lts_Alive[i] == true) {
					va_SendClientMessage(playerid, 0xAFAFAFAA, "[TEAM %s] %s.", GetTeamName(lts_PlayerTeam[i]), GetName(i, true));
				}
			}
		}
	}
	if(strcmp(action, "goto", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		SetPlayerPos(playerid, -2227.8279, 2326.4094, 7.5486);
		SetPlayerVirtualWorld(playerid, EVENT_WORLD_ID);
	}
	
	if(strcmp(action,"createdrop", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		new sDROP_type = minrand(1,3); 
	
		DestroyDynamicObject(supply_object[0]);
		DestroyDynamicObject(supply_object[1]);
		DestroyDynamicObject(supply_object[2]);
		
		if(sDROP_type == 1) {
			supply_object[0] = CreateDynamicObject(18849, -2468.425292, 2332.360107, 341.940826, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2468.470458, 2332.377441, 3.788570, SUPPLY_DROP_SPEED);
		}
		else if(sDROP_type == 2) {
			supply_object[0] = CreateDynamicObject(18849, -2489.874511, 2451.750244, 352.470550, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2350.994628, 2386.139404, 4.969938, SUPPLY_DROP_SPEED);
		}
		else if(sDROP_type == 3) {
			supply_object[0] = CreateDynamicObject(18849, -2350.904785, 2386.480224, 342.770538, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
			MoveDynamicObject(supply_object[0], -2489.998535, 2451.908935, 15.505872, SUPPLY_DROP_SPEED);
		}
		supply_type = sDROP_type;
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste kreirali supply drop, id dropa: %d.", sDROP_type);
	}
	
	if(strcmp(action,"create", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		if(lsm_created == true)
			return SendErrorMessage(playerid, "Vec ste kreirali Last Team Standing event.");
		
		// Reset 
		foreach(new i : Player) {	
			ResetPlayerVars_lts(i);
		}
		ResetServerVars_lts();
		
		//Create Event
		lsm_created = true;
		lsm_player_counter = 0;
		lsm_locked = false;
		
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste kreirali event, sada otkljucajte event kako bi igraci mogli uci.");
	}
	
	if(strcmp(action,"unlock", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
		if(lsm_locked == true)
			return SendErrorMessage(playerid, "Event je vec otkljucan.");
			
		//Create Event
		lsm_locked = true;
		
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste otkljucali event, sada pozovite igrace da se pridruze!");
	}
	
	if(strcmp(action,"quit", true) == 0) {
		if(lsm_started == true)
			return SendErrorMessage(playerid, "Last Team Standing event je vec pokrenut, ne mozete izaci sa event-a.");
		if(lts_Joined[playerid] == false)
			return SendErrorMessage(playerid, "Niste na Last Team Standing event.");
	
		// quit player.
		AC_ResetPlayerWeapons(playerid);		
		ResetPlayerVars_lts(playerid);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Izasli ste sa event-a.");
	}
	
	if(strcmp(action,"join", true) == 0) {
		new Float: X, Float: Y, Float: Z;
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
		if(lsm_player_counter == MAX_EVENT_TEAMS*MAX_PLAYERS_IN_TEAM)
			return SendErrorMessage(playerid, "Svi slotovi za Last Team Standing event su popunjeni.");
		if(lsm_started == true)
			return SendErrorMessage(playerid, "Last Team Standing event je vec pokrenut, zakansili ste. Vise srece drugi put!");
		if(lts_Joined[playerid] == true)
			return SendErrorMessage(playerid, "Vec ste se prijavili na Last Team Standing event.");
		if(lsm_locked == false)
			return SendErrorMessage(playerid, "Event je trenutno zakljucan.");
		if(PlayerInfo[playerid][pLevel] == 1) 
			return SendClientMessage(playerid,COLOR_RED, "ERROR: Level 1/2 ne mogu uci na ovaj tip event-a.");	
		
		// Prepare player.
		ResetPlayerVars_lts(playerid);
		Removeltsmap(playerid);
		GetPlayerPos(playerid, X, Y, Z);
		
		JoinPos[playerid][0] = X;
		JoinPos[playerid][1] = Y;
		JoinPos[playerid][2] = Z;
		JoinSettings[playerid][0] = GetPlayerVirtualWorld(playerid);
		JoinSettings[playerid][1] = GetPlayerInterior(playerid);
		
		AC_ResetPlayerWeapons(playerid);
		lts_Joined[playerid] = true;
		Bit1_Set(gr_OnEvent, playerid, true);
		
		lsm_player_counter++;
		SetPlayerHealth(playerid, 99);
		
		SetPlayerPos(playerid, -2227.8279, 2326.4094, 7.5486);
		SetPlayerVirtualWorld(playerid, EVENT_WORLD_ID);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste se pridruzili eventu, sada se morate pridruziti nekom od team-ova.");
	}
	
	if(strcmp(action,"stop", true) == 0) {
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
		if(lsm_started == false)
			return SendErrorMessage(playerid, "Last Team Standing event je vec zaustavljen.");
			
		foreach(new i : Player) {	
			if(lts_Joined[i] == true) {
				ResetPlayerVars_lts(i);
				AC_ResetPlayerWeapons(i);
			}
		}
		ResetServerVars_lts();

		va_SendClientMessageToAll(COLOR_RED, "[ ! ] Last Team Standing event je zaustavljen od strane %s.", GetName(playerid, true));
	}
	
	
	if(strcmp(action,"start", true) == 0) {
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
		if(lsm_started == true)
			return SendErrorMessage(playerid, "Last Team Standing event je vec pokrenut.");
		
		lsm_started = true;
		Createlts();
		foreach(new i : Player) {
			if(GetPlayerVirtualWorld(playerid) == EVENT_WORLD_ID) {
				lsm_counter[i] = LSM_MATCH_COUNTER;
				CreateLTS_teams(i, lts_PlayerTeam[i]);
				lsm_starttimer[i] = SetTimerEx("CounterToStart_LSM", 1000, true, "i", i);
			}
		}
	}


	if(strcmp(action,"checkteams", true) == 0) {	
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|_________ [ TEAMS ] _________|");	
		foreach(new i : Player) {
			if(lts_PlayerTeam[i] != -1) {
				if(lts_PlayerTeam[i] == 1)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM RED]: 	 %s.", GetName(i, true));
				if(lts_PlayerTeam[i] == 2)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM BLUE]: 	 %s.", GetName(i, true));	
				if(lts_PlayerTeam[i] == 3)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM GREEN]: 	 %s.", GetName(i, true));		
				if(lts_PlayerTeam[i] == 4)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM YELLOW]: 	 %s.", GetName(i, true));
				if(lts_PlayerTeam[i] == 5)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM WHITE]: 	 %s.", GetName(i, true));
				if(lts_PlayerTeam[i] == 6)
					va_SendClientMessage(playerid, COLOR_GREY, "[TEAM BLACK]: 	 %s.", GetName(i, true));	
			}
		}
	}
	
	if(strcmp(action,"members", true) == 0) {	
		if(lts_PlayerTeam[playerid] == -1)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR]: Kako bi koristili ovu komandu morate biti u team-u.");
			
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "|_________ [ MEMBERS ] _________|");	
		foreach(new i : Player) {
			if(lts_PlayerTeam[i] == lts_PlayerTeam[playerid]) {
				va_SendClientMessage(playerid, COLOR_GREY, "[TEAM %s]: %s.", GetTeamName(lts_PlayerTeam[playerid]), GetName(i, true));
			}		
		}
	}
	
	if(strcmp(action,"tc", true) == 0) {		
		if(lts_PlayerTeam[playerid] == -1)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR]: Kako bi koristili ovu komandu morate biti u team-u.");
			
		if (sscanf(params, "s[25]s[128]",action, message)) 
			return SendClientMessage(playerid,-1,"KORISTI: /lts tc(chat) [message].");
		
		format(string, sizeof(string), "> [TEAM %s] %s: %s.", GetTeamName(lts_PlayerTeam[playerid]), GetName(playerid, true), message);
		SendTeamMessage(lts_PlayerTeam[playerid], GetTeamColor(lts_PlayerTeam[playerid]), string); // Salje poruku njegovim team-mateovima.
	}
	
	if(strcmp(action,"kick", true) == 0) {
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
			
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		if(sscanf(params, "s[25]i", action, target_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts kick [playerid].");
			return (true);
		}
		if(lts_PlayerTeam[target_id] != -1)
			return SendErrorMessage(playerid, "Taj igrac nije na event-u.");
			
		lts_PlayerTeam[target_id] = -1;
		ResetPlayerVars_lts(target_id);
		AC_ResetPlayerWeapons(target_id);
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Izbacili ste igraca %s sa event-a.", GetName(target_id, true));
		va_SendClientMessage(target_id, COLOR_RED, "[ ! ] %s vas je izbacio sa LTS event-a %s.", GetName(playerid, true));
	}
	
	if(strcmp(action,"tkick", true) == 0) {
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
			
		if(lts_LeaderTeam[playerid] == -1)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Morate biti team leader kako bi koristili ovu komandu.");
			
		if(sscanf(params, "s[25]i", action, target_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts tkick [playerid].");
			return (true);
		}
		if(lts_PlayerTeam[target_id] != lts_LeaderTeam[playerid])
			return SendErrorMessage(playerid, "Taj igrac nije u vasem team-u.");
			
		lts_PlayerTeam[target_id] = -1;
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Izbacili ste igraca %s iz team-a %s.", GetName(target_id, true), GetTeamName(team_id));
		va_SendClientMessage(target_id, COLOR_RED, "[ ! ] %s vas je izbacio iz team-a %s.", GetName(playerid, true), GetTeamName(team_id));
	}
	
	if(strcmp(action,"invite", true) == 0) {
		if(lsm_created == false)
			return SendErrorMessage(playerid, "Last Team Standing event nije kreiran trenutno.");
			
		if(lts_LeaderTeam[playerid] == -1)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Morate biti team leader kako bi koristili ovu komandu.");
			
		if(sscanf(params, "s[25]i", action, target_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts invite [playerid].");
			return (true);
		}
		if(lts_PlayerTeam[target_id] != -1)
			return SendErrorMessage(playerid, "Taj igrac se vec nalazi u nekom team-u.");
			
		lts_PlayerTeam[target_id] = lts_LeaderTeam[playerid];
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Ubacili ste igraca %s u team %s.", GetName(target_id, true), GetTeamName(team_id));
		va_SendClientMessage(target_id, COLOR_RED, "[ ! ] %s vas je ubacio u team %s.", GetName(playerid, true), GetTeamName(team_id));
	}
	
	if(strcmp(action,"teamleader", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		if(sscanf(params, "s[25]ii", action, target_id, team_id))
		{
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts teamleader [playerid] [team_id].");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 1]: Red.");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 2]: Blue.");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 3]: Green.");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 4]: Yellow.");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 5]: White.");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 6]: Black.");
			SendClientMessage(playerid, COLOR_GREY, "[REMOVE]: -1.");
			return (true);
		}
		lts_PlayerTeam[target_id] = team_id;
		lts_LeaderTeam[target_id] = team_id;
		lts_Joined[target_id] = true;
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stavili ste igraca %s za leader-a tima %s.", GetName(target_id, true), GetTeamName(team_id));
		va_SendClientMessage(target_id, COLOR_RED, "[ ! ] %s vas je stavio za leader-a tima %s.", GetName(playerid, true), GetTeamName(team_id));
		SendClientMessage(target_id, COLOR_GREEN, "[T-LEADER]: Da vidite opcije team leader-a kucajte /lts.");
	}
	
	if(strcmp(action,"createitem", true) == 0) {
		new type, i_amount, i_name[32], i_wid, Float: X, Float: Y, Float: Z;
		GetPlayerPos(playerid, X,Y,Z);
		
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		if(sscanf(params, "s[25]iiis[32]", action, type, i_wid, i_amount, i_name))
		{
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts createitem [item_type] [item_weaponid(-1 ako nije oruzje)] [item_amount] [item_name].");
			SendClientMessage(playerid, COLOR_GREY, "[TYPE 1]: Weapon");
			SendClientMessage(playerid, COLOR_GREY, "[TYPE 2]: Ammo box");
			SendClientMessage(playerid, COLOR_GREY, "[TYPE 3]: Health Box");
			return (true);
		}
		
		if(type == 1)
			Createlts_items(trunk_WeaponModels(i_wid), i_name, i_amount, E_ITEM_TYPE_WEAPON, i_wid,	X, Y ,Z, 80.0, 0.0, 0.0);
		if(type == 2) 
			Createlts_items(2043, i_name, i_amount, E_ITEM_TYPE_AMMO, (-1), X, Y ,Z, 80.0, 0.0, 0.0);
		if(type == 3) 
			Createlts_items(11738, i_name,  i_amount, E_ITEM_TYPE_HEALTH, (-1), X, Y ,Z, 80.0, 0.0, 0.0);

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kreirali ste Item %s, amount: %d, WeaponID: %d, type: %d.", i_name, i_amount, i_wid, type);
	}
	
	if(strcmp(action,"maketeams", true) == 0) {
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendClientMessage(playerid, COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");
			
		if(sscanf(params, "s[25]ii", action, target_id, team_id))
		{
			SendClientMessage(playerid, COLOR_RED, "USAGE: /lts maketeams [playerid] [team_id].");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 1]: Red");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 2]: Blue");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 3]: Green");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 4]: Yellow");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 5]: White");
			SendClientMessage(playerid, COLOR_GREY, "[TEAM 6]: Black");
			return (true);
		}
		lts_PlayerTeam[target_id] = team_id;
		lts_Joined[target_id] = true;
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stavili ste igraca %s u team %s.", GetName(target_id, true), GetTeamName(team_id));
		va_SendClientMessage(target_id, COLOR_RED, "[ ! ] %s vas je stavio u team %s.", GetName(playerid, true), GetTeamName(team_id));
	}
	return (true);
}
