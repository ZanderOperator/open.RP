/*
=============================================================================================

	open.RP Role Play v0.5.5.
	Authors: v1rtuality, Zander Operator, cofi, Woo, B-Matt, kiddo, ShadY, hodza, Runner, Khawaja
	Web: https://open.mp/

=============================================================================================
*/

// Disable const correctness warnings on the community compiler
#pragma warning disable 239
#pragma warning disable 214

#include <a_samp>
#include <a_http>

/*

	88888888ba                                 88               ad88 88                                   
	88      "8b                                88              d8"   ""                                   
	88      ,8P                                88              88                                         
	88aaaaaa8P' 8b,dPPYba,  ,adPPYba,  ,adPPYb,88  ,adPPYba, MM88MMM 88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
	88""""""'   88P'   "Y8 a8P_____88 a8"    `Y88 a8P_____88   88    88 88P'   `"8a a8P_____88 I8[    ""  
	88          88         8PP""""""" 8b       88 8PP"""""""   88    88 88       88 8PP"""""""  `"Y8ba,   
	88          88         "8b,   ,aa "8a,   ,d88 "8b,   ,aa   88    88 88       88 "8b,   ,aa aa    ]8I  
	88          88          `"Ybbd8"'  `"8bbdP"Y8  `"Ybbd8"'   88    88 88       88  `"Ybbd8"' `"YbbdP"'  

*/

// Server Players, NPC's and Vehicle Config
#define MAX_NPCS 								(1)
#undef MAX_PLAYERS
#define MAX_PLAYERS 							(100)
#undef MAX_VEHICLES
#define MAX_VEHICLES                      		(1000)

//#define MODULE_LOGS											// Player/Game Admin Command/Actions logging feature 

// MySQL inline query functions
#define MYSQL_USE_YINLINE						true

// #define COA_UCP

// GMT Zone
#define GMT_ZONE_DIFFERENCE						(0)

// 0.3DL
#define NEGATIVE_MODEL_ID 						-40000 

// Server Restart Configuration
//#define AUTO_RESTART_SEQ							// Uncomment for automatic restarts if you have restart
// 														API on your VPS/server
												
#define HTTP_RESTART_REQUEST 					"SERVER_RESTART_API_REQUEST_LINK"

// Server Afterload Unlock
#define SERVER_UNLOCK_TIME						(60)

// Fixes.inc
#define FIXES_GetMaxPlayersMsg 		0
#define FIXES_ServerVarMsg 			0
#define FIX_OnPlayerEnterVehicle 	0
#define FIX_OnPlayerEnterVehicle_2 	0
#define FIX_OnPlayerEnterVehicle_3 	0
#define FIX_OnDialogResponse		0
#define FIX_GetPlayerDialog			0
#define	MAX_IP_CONNECTS 			3
#define FIX_file_inc 				0

/*
																			
	88                        88                      88                       
	88                        88                      88                       
	88                        88                      88                       
	88 8b,dPPYba,   ,adPPYba, 88 88       88  ,adPPYb,88  ,adPPYba, ,adPPYba,  
	88 88P'   `"8a a8"     "" 88 88       88 a8"    `Y88 a8P_____88 I8[    ""  
	88 88       88 8b         88 88       88 8b       88 8PP"""""""  `"Y8ba,   
	88 88       88 "8a,   ,aa 88 "8a,   ,a88 "8a,   ,d88 "8b,   ,aa aa    ]8I  
	88 88       88  `"Ybbd8"' 88  `"YbbdP'Y8  `"8bbdP"Y8  `"Ybbd8"' `"YbbdP"'  
																			
*/

// Fixes
#include <fixes>

// sscanf by Y-Less
#include <sscanf2>

// New SA-MP callbacks by Emmet
#include <callbacks> 

// SA-MP Map Zones by kristoisberg
#include <map-zones> 

// Modern Pawn library for working with dates and times - TimeFormat
#include <chrono> 

// Aim Anti-Cheat by Yashas
#include <BustAim>

// Streamer
#include <streamer>
#define OBJECT_STREAM_LIMIT		(700)

// YSI by Y_Less
#define YSI_NO_HEAP_MALLOC

// After sampctl p ensure check: CGEN_MEMORY(needs to be 90000) and MAX_COMMANDS(needs to be 1024) 
#define CGEN_MEMORY				(90000)		// Internal Define - code parser/generator memory
#define MAX_COMMANDS			(1024)		// Internal Define - y_commands

#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_inline>
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_va>
#include <YSI_Data\y_iterate>
#include <YSI_Server\y_flooding>
#include <YSI_Visual\y_commands>
#include <YSI_Game\y_vehicledata>

// bcrypt encription & inline support
#include <bcrypt>
#include <YSI_Extra\y_inline_bcrypt>
#define BCRYPT_COST 12

// Other includes
#include <OnPlayerSlowUpdate>
#include <animsfix> // legacy
#include <rBits> // legacy
#include <progress2>
#include <mapandreas>
#include <fSelection>
#include <color_menu> // legacy

#include <vSync>

// MySQL & Inline Query Callbacks/Funcs
#include <a_mysql>
#include <YSI_Extra\y_inline_mysql>

// SHA-1 of latest commit - GIT_REV define
#include "revision.inc"

/*
																		
	88888888ba,                 ad88 88                                   
	88      `"8b               d8"   ""                                   
	88        `8b              88                                         
	88         88  ,adPPYba, MM88MMM 88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
	88         88 a8P_____88   88    88 88P'   `"8a a8P_____88 I8[    ""  
	88         8P 8PP"""""""   88    88 88       88 8PP"""""""  `"Y8ba,   
	88      .a8P  "8b,   ,aa   88    88 88       88 "8b,   ,aa aa    ]8I  
	88888888Y"'    `"Ybbd8"'   88    88 88       88  `"Ybbd8"' `"YbbdP"'  														
                                                                      
*/


/* 
	Server Informations 
		- When chaning SCRIPT_VERSION, you MUST upload new "Changelog.txt" 
			in /scriptfiles in order for players to see what's new InGame
*/

#define SERVER_NAME								"open.RP"
#define HOSTNAME 								#SERVER_NAME"[0.3DL]"
#define WEB_URL									"https://open.mp/"
#define SCRIPT_VERSION							#SERVER_NAME" v0.5.0.-"#GIT_REV

/*
	The rest of the defines
 	Main Header file - purpose is bypassing the include order
	Enumerator Declarations
	Custom Functions Declaration file - purpose is declaring custom funcs that will be hooked
	Global Variables that are used via Getter/Setter functions
*/
#include <Preincludes>

// Globally used Arrays declarations
#include <Arrays>


/*

	88b           d88                      88             88                       
	888b         d888                      88             88                       
	88`8b       d8'88                      88             88                       
	88 `8b     d8' 88  ,adPPYba,   ,adPPYb,88 88       88 88  ,adPPYba, ,adPPYba,  
	88  `8b   d8'  88 a8"     "8a a8"    `Y88 88       88 88 a8P_____88 I8[    ""  
	88   `8b d8'   88 8b       d8 8b       88 88       88 88 8PP"""""""  `"Y8ba,   
	88    `888'    88 "8a,   ,a8" "8a,   ,d88 "8a,   ,a88 88 "8b,   ,aa aa    ]8I  
	88     `8'     88  `"YbbdP"'   `"8bbdP"Y8  `"YbbdP'Y8 88  `"Ybbd8"' `"YbbdP"'  
                                                                               
*/

#include <Server>
#include <Systems>
#include <Admin>
#include <Player>
#include <Char>

/*

	88888888888                                        88                                    
	88                                           ,d    ""                                    
	88                                           88                                          
	88aaaaa 88       88 8b,dPPYba,   ,adPPYba, MM88MMM 88  ,adPPYba,  8b,dPPYba,  ,adPPYba,  
	88""""" 88       88 88P'   `"8a a8"     ""   88    88 a8"     "8a 88P'   `"8a I8[    ""  
	88      88       88 88       88 8b           88    88 8b       d8 88       88  `"Y8ba,   
	88      "8a,   ,a88 88       88 "8a,   ,aa   88,   88 "8a,   ,a8" 88       88 aa    ]8I  
	88       `"YbbdP'Y8 88       88  `"Ybbd8"'   "Y888 88  `"YbbdP"'  88       88 `"YbbdP"'  
	
*/


main()
{
	
}

public OnGameModeInit()
{
	SendRconCommand("password 6325234hbbzfg12312313gz313"); // Server Lock while everything loads	

	MapAndreas_Init(MAP_ANDREAS_MODE_FULL, "scriptfiles/SAfull.hmap");
	print("Report: MapAndreas Initialised.");

	// Streamer config
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_PICKUP, 3900, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_3D_TEXT_LABEL, 1000, -1);
	print("Report: Streamer Configuration Complete.");

	cseconds = 0;
	Reg_SetEnabled(true); // Enable Account Registration

	// Alternative Commands
	Command_AddAltNamed("whisper"		, 	"w");
	Command_AddAltNamed("hangup"		, 	"h");
	Command_AddAltNamed("speakerphone"	, 	"sf");
	Command_AddAltNamed("doorshout"		, 	"ds");
	Command_AddAltNamed("close"			, 	"c");
	Command_AddAltNamed("shout"			, 	"s");
	Command_AddAltNamed("carwhisper"	, 	"cw");
	Command_AddAltNamed("backup"		, 	"bk");
	Command_AddAltNamed("admin"			, 	"a");
    Command_AddAltNamed("clearchat"		, 	"cc");
	Command_AddAltNamed("pocketsteal"	, 	"psteal");
	Command_AddAltNamed("animations"	, 	"anims");
	Command_AddAltNamed("cryptotext"	, 	"ct");
    Command_AddAltNamed("experience"	, 	"exp");
	Command_AddAltNamed("radio"			, 	"r");
	Command_AddAltNamed("radiolow"		, 	"rlow");
	Command_AddAltNamed("beanbag"		, 	"bb");
	Command_AddAltNamed("tazer"			, 	"ta");
	Command_AddAltNamed("acceptreport"	, 	"ar");
	Command_AddAltNamed("disregardreport", 	"dr");
	Command_AddAltNamed("unblacklist"	, 	"unbl");
	Command_AddAltNamed("blacklist"		, 	"bl");
	print("Report: Alternative Commands Added.");

	// SA-MP gamemode settings
	ShowNameTags(1);
    SetNameTagDrawDistance(15.0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(1);
	ManualVehicleEngineAndLights();
	SetMaxConnections(3, e_FLOOD_ACTION_GHOST);
	SendRconCommand("cookielogging 0");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");
	print("Report: GameMode Settings Loaded.");

	// Server Informations
	new 	
		gstring[64];
	format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
	SendRconCommand(gstring);
 	SetGameModeText(SCRIPT_VERSION);
	print("Report: Server Info Loaded.");

	// Auto Unlock Settings
	GMX_Set(2);
	cseconds = SERVER_UNLOCK_TIME; 

	printf("Report: GameMode Time Set on %s", 
		ReturnTime(),
		SERVER_NAME
	);
	return 1;
}

hook OnGameModeExit()
{
    for (new i; i < MAX_OBJECTS; i++)
    {
        if(IsValidDynamicObject(i))
            DestroyDynamicObject(i);

        if(IsValidObject(i))
            DestroyObject(i);
    }
    return 1;
}

task GlobalServerTask[1000]()
{
	GMXTimer();
	GlobalServerTimer();
	return 1;
}

#if defined AUTO_RESTART_SEQ
StartGMX()
{
	for (new a = 1; a <= 20; a++)
	{
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
	}
	cseconds = 30;
	foreach (new i : Player) 
	{
		// Player Camera
		TogglePlayerControllable(i, false);
		SetPlayerPos(i, 1433.4633, -974.7463, 58.0000);
		InterpolateCameraPos(i, 1431.9108, -895.1843, 73.9480, 1431.9108, -895.1843, 73.9480, 100000, CAMERA_MOVE);
		InterpolateCameraLookAt(i, 1431.8031, -894.1859, 74.0085, 1431.8031, -894.1859, 74.0085, 100000, CAMERA_MOVE);
		cseconds += 3;
	}
	GMX_Set(1);
	new rconstring[100];
	format(rconstring, sizeof(rconstring), "hostname %s [Database Saving in Process]", SERVER_NAME);
	SendRconCommand(rconstring);
	SendRconCommand("password devtest");
	SendClientMessageToAll(COLOR_RED, "[SERVER]: Server Restart procedure initiated. Please stay in game until server stores your data...");
	SaveAll();
	return 1;
}
SaveAll()
{
	printf("[SERVER]: Automatic scheduled restart initiated. Storing data into MySQL database.");
	if(Iter_Count(Player) > 0)
	{
		foreach (new i : Player) 
		{
			if(Player_SafeSpawned(i))
				Kick(i);
		}
	}
}
#endif

GlobalServerTimer()
{
	new
		tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);

	if((tmphour > Hour_Get()) || (tmphour == 0 && Hour_Get() == 23))
	{
		SetWorldTime(tmphour);
		Hour_Set(tmphour);
	}
	if(GMX_Get() != 1 && tmphour == 5 && tmpmins == 5 && tmpsecs < 10)
	{
		CheckAccountsForInactivity();
		#if defined AUTO_RESTART_SEQ
		GMX_Set(1);
		StartGMX();
		#endif
	}
	return 1;
}

GMXTimer()
{
	#if defined AUTO_RESTART_SEQ
	if(GMX_Get() == 1)
	{
		cseconds--;
		new string[10];
		format(string, sizeof(string), "%d", cseconds);
		GameTextForAll(string, 1000, 4);
		if(cseconds < 1)
		{
			GMX_Set(0);
			stop CountingTimer;
			foreach(new i : Player) 
			{
				if(PlayerInfo[i][pAdmin] >= 1338) 
				{
					SendClientMessage(i, COLOR_RED, "[INFO]: Storing the data in server is done. Restarting Server...");
					KickMessage(i);
				}
			}
			HTTP(0, HTTP_HEAD, HTTP_RESTART_REQUEST, "", "ServerRestartRequest");
			return 1;
		}
	}
	#endif
	if(GMX_Get() == 2)
	{
		cseconds--;
		if(cseconds < 1)
		{
			GMX_Set(0);
			cseconds = 0;
			SendRconCommand("password 0");
			return 1;
		}
	}
	return 1;
}

forward ServerRestartRequest(index, response_code, data[]);
public ServerRestartRequest(index, response_code, data[])
{
    if(response_code != 200)
        printf("[ERROR]: Automatic Server Restart via API was unsucessful! Response Code: %d", response_code);
}