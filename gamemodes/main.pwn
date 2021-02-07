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

#include <crashdetect>
#include <a_samp>
#include <a_http>

/*
==============================================================================
	Preinclude defines
==============================================================================
*/

// Server Players, NPC's and Vehicle Config
#define MAX_NPCS 								(1)
#undef MAX_PLAYERS
#define MAX_PLAYERS 							(100)
#undef MAX_VEHICLES
#define MAX_VEHICLES                      		(1000)

//#define 	MODULE_LOGS											// Player/Game Admin Command/Actions logging feature 

// MySQL inline query functions
#define MYSQL_USE_YINLINE						true

// #define COA_UCP

// GMT Zone
#define GMT_ZONE_DIFFERENCE						(3600)			// GMT + 1

// 0.3DL
#define NEGATIVE_MODEL_ID 						-40000 // Negativna vrijednost radi Custom Object Modela koji su u minusu

// Server Restart Configuration
//#define AUTO_RESTART_SEQ							// Uncomment for automatic restarts if you have restart API on your VPS/server
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
	#### ##    ##  ######  ##       ##     ## ########  ########  ######
	 ##  ###   ## ##    ## ##       ##     ## ##     ## ##       ##    ##
	 ##  ####  ## ##       ##       ##     ## ##     ## ##       ##
	 ##  ## ## ## ##       ##       ##     ## ##     ## ######    ######
	 ##  ##  #### ##       ##       ##     ## ##     ## ##             ##
	 ##  ##   ### ##    ## ##       ##     ## ##     ## ##       ##    ##
	#### ##    ##  ######	########  #######  ########  ########  ######
*/


// Fixes
#include <fixes>

// bcrypt encription
#include <bcrypt>
#define BCRYPT_COST 12

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

// Other pre-includes
#include <OnPlayerSlowUpdate>
#include <animsfix> // legacy
#include <rBits> // legacy
#include <sscanf2>
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
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
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

// The rest of the defines
#include "modules/Preincludes/Defines.inc"
// Enumerator Declarations
#include "modules/Preincludes/Enumerators.inc"
// Globally used Arrays declarations
#include "modules/Arrays/Core.inc"
// Main Header file - purpose is bypassing the include order
#include "modules/Preincludes/Header.inc"
// Custom Functions Declaration file - purpose is declaring custom funcs that will be hooked
#include "modules/Preincludes/CustomHooks.inc"
	

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/


new
	ghour 					= 0,
	GMX 					= 0,
	WeatherTimer 			= 0,
	WeatherSys 				= 10,
	HappyHours				= 0,
	HappyHoursLVL			= 0;

// Players 32 bit
new
	Float:PlayerTrunkPos[MAX_PLAYERS][3],
	GlobalSellingPlayerID[MAX_PLAYERS] = { 0, ... },
	GlobalSellingPrice[MAX_PLAYERS] = { 0, ... },
	PlayerExName[MAX_PLAYERS][MAX_PLAYER_NAME],
	VehicleEquipment[MAX_PLAYERS],
	VehicleTrunk[MAX_PLAYERS],
	bool:BoomBoxPlanted[MAX_PLAYERS],
	BoomBoxObject[MAX_PLAYERS],
	PlayerAction[MAX_PLAYERS],
	bool:PlayerWounded[MAX_PLAYERS],
	PlayerWoundedSeconds[MAX_PLAYERS],
	PlayerWTripTime[MAX_PLAYERS],
	bool:SafeSpawned[MAX_PLAYERS],
	bool:PlayerCrashed[MAX_PLAYERS],
	bool:PlayerSyncs[MAX_PLAYERS],
	bool:Frozen[MAX_PLAYERS],
	bool:PlayerBlocked[MAX_PLAYERS],
	bool:PlayerWoundedAnim[MAX_PLAYERS],
	bool:rob_started[MAX_PLAYERS] = false,
	KilledBy[MAX_PLAYERS],
	WoundedBy[MAX_PLAYERS],
	KilledReason[MAX_PLAYERS],
	gStartedWork[MAX_PLAYERS],
	InjectPlayer[MAX_PLAYERS];


//Players Vars
//(rBits)
new
	Bit1: 	gr_SafeBreaking			<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggedIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggingIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_NewUser				<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_VehicleWindows 		<MAX_VEHICLES> = Bit1: false,
	Bit1:	gr_VehicleAttachedBomb	<MAX_VEHICLES> = Bit1: false,
	Bit1: 	gr_PlayerTimeOut		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_BlockedPM			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerAlive			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MobileSpeaker		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_SmokingCiggy			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_HasRubber			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerRadio			<MAX_PLAYERS>  = Bit1: true,
	Bit1:	gr_TrunkOffer			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerInTrunk		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerOnTutorial		<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_animchat             <MAX_PLAYERS>  = Bit1: false,
    // TODO: should be part of Player/Char module
	Bit1:   gr_Blind                <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_BlindFold            <MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTrunkEdit		<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_ImpoundApproval      <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_HaveOffer        	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_UsingMechanic 		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MallPreviewActive	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	r_ColorSelect			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerInTuningMode	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	PlayingBBall			<MAX_PLAYERS>  = Bit1: false,
	//Bit1: 	gr_DrivingStarted		<MAX_PLAYERS>  = Bit1: false,
	Bit2:	gr_BikeBunnyHop			<MAX_PLAYERS>  = Bit2: 0,
	Bit2:	gr_TipEdita				<MAX_PLAYERS>  = Bit2: 0,
	Bit2:	gr_PlayerJumps			<MAX_PLAYERS>  = Bit2: 0,
	Bit4:	gr_WeaponTrunkEditSlot	<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_MusicCircle			<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	r_ColorSlotId			<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_AttachmentIndexSel	<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_TipUsluge			<MAX_PLAYERS>  = Bit4: 0,
    // TODO: misspelled, SpectateId
	Bit4: 	gr_SpecateId 			<MAX_PLAYERS>  = Bit4: 0,
	Bit8:	gr_MechanicSecs			<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_HandleItem			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_ObjectPrice			<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_MallType				<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_LoginInputs			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_RegisterInputs		<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_ShakeStyle			<MAX_PLAYERS>  = Bit8: 0,
	Bit16:	gr_IdMehanicara			<MAX_PLAYERS>  = Bit16: INVALID_PLAYER_ID,
	Bit16:	gr_ShakeOffer			<MAX_PLAYERS>  = Bit16: 0,
	Bit16: 	gr_LastPMId				<MAX_PLAYERS>  = Bit16: 0;

new
    secquestattempt[MAX_PLAYERS] = 3,
	EditingWeapon[MAX_PLAYERS] = 0,
	ServicePrice[MAX_PLAYERS] = 0,
	WeaponListID[MAX_PLAYERS],
	WeaponToList[MAX_PLAYERS][MAX_WAREHOUSE_WEAPONS],
	regenabled = false;


/*
	##     ##  #######  ########  ##     ## ##       ########  ######
	###   ### ##     ## ##     ## ##     ## ##       ##       ##    ##
	#### #### ##     ## ##     ## ##     ## ##       ##       ##
	## ### ## ##     ## ##     ## ##     ## ##       ######    ######
	##     ## ##     ## ##     ## ##     ## ##       ##             ##
	##     ## ##     ## ##     ## ##     ## ##       ##       ##    ##
	##     ##  #######  ########   #######  ######## ########  ######
*/


#include "modules/Server/Core.inc"
#include "modules/Systems/Core.inc"
#include "modules/Admin/Core.inc"
#include "modules/Player/Core.inc"
#include "modules/Char/Core.inc"


/*
	########    ###     ######  ##    ##  ######
	   ##      ## ##   ##    ## ##   ##  ##    ##
	   ##     ##   ##  ##       ##  ##   ##
	   ##    ##     ##  ######  #####     ######
	   ##    #########       ## ##  ##         ##
	   ##    ##     ## ##    ## ##   ##  ##    ##
	   ##    ##     ##  ######  ##    ##  ######
*/


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
	GMX = 1;
	new rconstring[100];
	format(rconstring, sizeof(rconstring), "hostname %s [Database Saving in Process]", SERVER_NAME);
	SendRconCommand(rconstring);
	SendRconCommand("password devtest");
	SendClientMessageToAll(COLOR_RED, "[SERVER]: Server Restart procedure initiated. Please stay in game until server stores your data...");
	SaveAll();
	return 1;
}
#endif

Public:SaveAll()
{
	printf("[SERVER]: Automatic scheduled restart initiated. Storing data into MySQL database.");
	if(Iter_Count(Player) > 0)
	{
		foreach (new i : Player) 
		{
			if(Bit1_Get(gr_PlayerLoggedIn, i) != 0)
				Kick(i);
		}
	}
}

Public:GlobalServerTimer()
{
	new
		tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);

	if((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
		SetWorldTime(tmphour);
		ghour = tmphour;
	}
	if(GMX != 1 && tmphour == 5 && tmpmins == 5 && tmpsecs < 10)
	{
		CheckAccountsForInactivity();
		#if defined AUTO_RESTART_SEQ
		GMX = 1;
		StartGMX();
		#endif
	}
	return 1;
}

Public:DynamicWeather()
{
	if(gettimestamp() >= WeatherTimer)
	{
		WeatherTimer = gettimestamp() + 6000;
		new tmphour,
			tmpminute,
			tmpsecond;

		gettime(tmphour, tmpminute, tmpsecond);

		if(tmphour >= 6 && tmphour <= 20)
		{
			new RandomWeather;
			RandomWeather = randomEx(0,6);
			switch(RandomWeather)
			{
				case 0:
				{
					SetWeather(1);
					WeatherSys = 1;
				}
				case 1:
				{
					SetWeather(7);
					WeatherSys = 7;
				}
				case 2:
				{
					SetWeather(8);
					WeatherSys = 8;
				}
				case 3:
				{
					SetWeather(13);
					WeatherSys = 13;
				}
				case 4:
				{
					SetWeather(15);
					WeatherSys = 15;
				}
				case 5:
				{
					SetWeather(17);
					WeatherSys = 17;
				}
				case 6:
				{
					SetWeather(10);
					WeatherSys = 10;
				}
			}
		}
		else if(tmphour >= 21 && tmphour <= 5)
		{
			SetWeather(10);
			WeatherSys = 10;
		}
	}
	return 1;
}

Public:GMXTimer()
{
	#if defined AUTO_RESTART_SEQ
	if(GMX == 1)
	{
		cseconds--;
		new string[10];
		format(string, sizeof(string), "%d", cseconds);
		GameTextForAll(string, 1000, 4);
		if(cseconds < 1)
		{
			GMX = 0;
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
	if(GMX == 2)
	{
		cseconds--;
		if(cseconds < 1)
		{
			GMX = 0;
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


/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
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

	// Global config
	WeatherSys 	= 10;
	cseconds        = 0;
	regenabled		= 1;

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
	new gstring[64];
	format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
	SendRconCommand(gstring);
 	SetGameModeText(SCRIPT_VERSION);
	print("Report: Server Info Loaded.");

	// Auto Unlock Settings
	GMX = 2;
	cseconds = SERVER_UNLOCK_TIME; 

	printf("Report: GameMode Time Set on %s", 
		ReturnTime(),
		SERVER_NAME
	);
	return 1;
}

task GlobalServerTask[1000]() // izvodi se svakih sekundu
{
	GMXTimer();
	GlobalServerTimer();
	DynamicWeather();
	return 1;
}

timer SafeResetPlayerVariables[3000](playerid)
{
	ResetPlayerVariables(playerid);
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

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(ispassenger)
    {
        if(VehicleInfo[vehicleid][vLocked])
        {
            RemovePlayerFromVehicle(playerid);

            if(GetPlayerAnimationIndex(playerid))
            {
                new
                    animlib[32],
                    animname[32];

                GetAnimationName(GetPlayerAnimationIndex(playerid), animlib,
                                 sizeof(animlib), animname, sizeof(animname));

                if(strfind(animname, "fall", true) != -1)
                    return 1;
            }

            new
                Float:x,
                Float:y,
                Float:z;

            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x, y, z);
        }
    }
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!cmdtext[0])
    {
        Kick(playerid); // because it's impossible to send valid NULL command
        return 0;
    }
    return 1;
}

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	if(strlen(cmdtext) > 128)
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Command can't be more than 128 chars long!");
		return COMMAND_ZERO_RET;
	}
	switch(success)
	{
		case COMMAND_OK:
		{
			if(!IsPlayerConnected(playerid))
				return COMMAND_ZERO_RET;

			if(!SafeSpawned[playerid] || Player_SecurityBreach(playerid))
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR,"You're not safely spawned, you can't use commands!");
				return COMMAND_ZERO_RET;
			}
			if(!cmdtext[0])
			{
				Kick(playerid); // Because it's impossible to send valid NULL command
				return COMMAND_ZERO_RET;
			}

			#if defined MODULE_LOGS
			if(!IsPlayerAdmin(playerid))
			{
				Log_Write("logfiles/cmd_timestamp.txt", "(%s)Player %s[%d]{%d}(%s) used command '%s'.",
					ReturnDate(),
					GetName(playerid, false),
					playerid,
					PlayerInfo[playerid][pSQLID],
					ReturnPlayerIP(playerid),
					cmdtext
				);
			}
			#endif
			
			return COMMAND_OK;
		}
		case COMMAND_UNDEFINED:
		{
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Command '%s' does not exist!", cmdtext);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/cmd_unknown.txt", "(%s)Player %s[%d]{%d}(%s) used non-existing command '%s'.",
				ReturnDate(),
				GetName(playerid, false),
				playerid,
				PlayerInfo[playerid][pSQLID],
				ReturnPlayerIP(playerid),
				cmdtext
			);
			#endif
			
			return COMMAND_ZERO_RET;
		}
		case COMMAND_NO_PLAYER:
		{
			#if defined MODULE_LOGS
			Log_Write("logfiles/cmd_timestamp.txt", "(%s)Player %s unsucessfuly used command %s [Error: He shouldn't exist?].",
				ReturnDate(),
				GetName(playerid, false),
				cmdtext
			);
			#endif
			return COMMAND_ZERO_RET;
		}
		case COMMAND_BAD_PREFIX, COMMAND_INVALID_INPUT:
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR,"You have entered wrong prefix / format of the command!");
			return COMMAND_ZERO_RET;
		}
	}
	if(!success)
	{
		#if defined MODULE_LOGS
		Log_Write("logfiles/cmd_timestamp.txt", "(%s)Player %s used a command %s and it wasn't executed.",
			ReturnDate(),
			GetName(playerid, false),
			cmdtext
		);
		#endif
		return COMMAND_ZERO_RET;
	}
	return COMMAND_OK;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(weaponid == WEAPON_FIREEXTINGUISHER)
    {
        new Float: oldHealth;
        GetPlayerHealth(playerid, oldHealth);
        SetPlayerHealth(playerid, oldHealth);
        return 0;
    }
    return 0;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    return 0;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(KilledBy[playerid] == INVALID_PLAYER_ID && killerid == INVALID_PLAYER_ID || playerid == INVALID_PLAYER_ID || !SafeSpawned[playerid])
		return 1;

	if(!SafeSpawned[KilledBy[playerid]]) 
		return SendClientMessage(KilledBy[playerid], COLOR_RED, "[ANTI-CHEAT]: You are not safely spawned, therefore, banned!"), BanMessage(KilledBy[playerid]), 0;

	if(IsPlayerInAnyVehicle(playerid))
		RemovePlayerFromVehicle(playerid);
	
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	if(!text[0])
		return Kick(playerid);
	
	if(strlen(text) > 128)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Chatbox input can't be longer than 128 chars!");

	if(DeathCountStarted_Get(playerid))
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't talk, you are dead!");
		return 0;
	}
	if(PlayerInfo[playerid][pMuted]) 
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't talk while being muted!");
		return 0;
	}
	if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid))
		return 0;

	if(!SafeSpawned[playerid] || Player_SecurityBreach(playerid))
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR,"You can't use chat if you're not safely spawned!");
		return 0;
	}
	
	new tmpString[180];
	text[0] = toupper(text[0]);
	
	if(!Player_MobileSpeaking(playerid))
	{
		
		if(IsPlayerInAnyVehicle(playerid)) {
			format(tmpString, sizeof(tmpString), "%s says%s(vehicle): %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		else
		{
			format(tmpString, sizeof(tmpString), "%s says%s: %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		if(Bit1_Get( gr_animchat, playerid) && !PlayerAnim[playerid])
		{
			TogglePlayerControllable(playerid, 1);
			if(strlen(text) > 0 && strlen(text) < 10) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,500,1,0);
			else if(strlen(text) >= 10 && strlen(text) < 20) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,1000,1,0);
			else if(strlen(text) >= 20 && strlen(text) < 30) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,1500,1,0);
			else if(strlen(text) >= 30 && strlen(text) < 40) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,2000,1,0);
			else if(strlen(text) >= 40 && strlen(text) < 50) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,2500,1,0);
			else if(strlen(text) >= 50 && strlen(text) < 61) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,3000,1,0);
			else if(strlen(text) >= 61 && strlen(text) < 71) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,3500,1,0);
			else if(strlen(text) >= 71 && strlen(text) < 81) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,4000,1,0);
			else if(strlen(text) >= 81 && strlen(text) < 91) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,4500,1,0);
			else if(strlen(text) >= 91 && strlen(text) < 101) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,5000,1,0);
			else if(strlen(text) >= 101 && strlen(text) < 111) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,5500,1,0);
			else if(strlen(text) >= 111 && strlen(text) < 121) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,6000,1,0);
			else if(strlen(text) >= 121 && strlen(text) < 131) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,6500,1,0);
			else if(strlen(text) >= 131 && strlen(text) < 141) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,7000,1,0);
			else if(strlen(text) >= 141 && strlen(text) < 151) ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,0,0,0,7500,1,0);
		}
	}
	return 0;
}

// TODO: should be a part of Player module
#include <YSI_Coding\y_hooks>
hook function ResetPlayerVariables(playerid)
{	
	//rBits
	Bit1_Set( gr_PlayerLoggingIn 		, playerid, false);
	Bit1_Set( gr_PlayerLoggedIn 		, playerid, false);
	Bit1_Set( gr_NewUser				, playerid, false);
	Bit1_Set( gr_PlayerTimeOut			, playerid, false);
	Bit1_Set( gr_BlockedPM				, playerid, false);
	Bit1_Set( gr_PlayerAlive			, playerid, true );
	Bit1_Set( gr_MobileSpeaker			, playerid, false);
	Bit1_Set( gr_SmokingCiggy			, playerid, false);
	Bit1_Set( gr_HasRubber				, playerid, false);
	Bit1_Set( gr_animchat               , playerid, false);
	Bit1_Set( gr_PlayerRadio			, playerid, true);
	Bit1_Set( gr_TrunkOffer				, playerid, false);
	Bit1_Set( gr_PlayerTrunkEdit        , playerid, false);
	Bit1_Set( gr_PlayerInTrunk			, playerid, false);
	// TODO: Player/Char module
	Bit1_Set( gr_Blind					, playerid, false);
	Bit1_Set( gr_BlindFold				, playerid, false);
	Bit1_Set( gr_ImpoundApproval		, playerid, false);
	Bit2_Set( gr_BikeBunnyHop			, playerid, 0);
	Bit2_Set( gr_PlayerJumps			, playerid, 0);
	Bit4_Set( gr_WeaponTrunkEditSlot	, playerid, 0);
	Bit4_Set( gr_MusicCircle			, playerid, 0);
	Bit4_Set( gr_SpecateId				, playerid, 0);
	Bit8_Set( gr_LoginInputs			, playerid, 0);
	Bit8_Set( gr_RegisterInputs			, playerid, 0);
	Bit8_Set( gr_ShakeStyle				, playerid, 0);
	Bit16_Set( gr_ShakeOffer			, playerid, 999);
	Bit16_Set( gr_LastPMId				, playerid, 999);

	// Exiting Vars
	PlayerSafeExit[playerid][giX] = 0;
	PlayerSafeExit[playerid][giY] = 0;
	PlayerSafeExit[playerid][giZ] = 0;
	PlayerSafeExit[playerid][giRZ] = 0;

	Bit1_Set( gr_PlayerUsingPhonebooth			, playerid, false);
	Bit1_Set( gr_PlayerTakingSelfie		, playerid, false);
	Bit8_Set( gr_RingingTime			, playerid, 0);

	// Administrator
	Bit1_Set(a_AdminChat, 		playerid, true);
	Bit1_Set(a_PlayerReconed,	playerid, false);
	Bit1_Set(a_PMears, 			playerid, false);
	Bit1_Set(a_AdNot, 			playerid, true);
	Bit1_Set(a_DMCheck, 		playerid, true);
	
	Bit1_Set(a_BlockedHChat, 	playerid, false);
	Bit1_Set(a_TogReports, 		playerid, false);
	

	// Anti Spam
	AntiSpamInfo[playerid][asPrivateMsg] 	= 0;
	AntiSpamInfo[playerid][asCreditPay] 	= 0;
	AntiSpamInfo[playerid][asCarTrunk] 		= 0;
	AntiSpamInfo[playerid][asHouseWeapon] 	= 0;
	AntiSpamInfo[playerid][asBuying] 		= 0;
	AntiSpamInfo[playerid][asDoorShout] 	= 0;

	// Tut
	if(Bit1_Get( gr_PlayerOnTutorial, playerid)) 
	{
		Bit1_Set(gr_PlayerOnTutorial, playerid, false);
		stop TutTimer[playerid];
	}

	// Ticks
	PlayerTick[playerid][ptReport]			= gettimestamp();
	PlayerTick[playerid][ptMoney]			= gettimestamp();
	PlayerTick[playerid][ptHelperHelp]		= gettimestamp();
	PlayerTick[playerid][ptKill]			= gettimestamp();
	PlayerTick[playerid][ptMainTimer] 		= gettimestamp();
	
	
	//Floats
	PlayerTrunkPos[playerid][0] 			= 0.0;
	PlayerTrunkPos[playerid][1] 			= 0.0;
	PlayerTrunkPos[playerid][2] 			= 0.0;
	
	// Previous Info(/learn, etc.)
	ResetPlayerPreviousInfo(playerid);

	// 32bit
	PlayerExName[playerid][0] 	= '\0';
	VehicleEquipment[playerid]	= INVALID_VEHICLE_ID;
	InjectPlayer[playerid]     	= INVALID_PLAYER_ID;
	ServicePrice[playerid]			= 0;
	KilledBy[playerid]				= INVALID_PLAYER_ID;
	WoundedBy[playerid]				= INVALID_PLAYER_ID;
	KilledReason[playerid]			= -1;

	PlayerAction[playerid]			= 0;

	// Bools
	PlayerCrashed[playerid] 	= false;
	SafeSpawned[playerid] 	= false;
	PlayerSyncs[playerid] 	= false;
	PlayerBlocked[playerid] 	= false;

	return continue(playerid);
}

public OnPlayerActionChange(playerid, oldaction, newaction) // Callbacks.inc by Emmet
{
	switch(newaction)
	{
		case 0: PlayerAction[playerid] = PLAYER_ACTION_NONE;
		case 1: PlayerAction[playerid] = PLAYER_ACTION_SHOOTING;
		case 2:	PlayerAction[playerid] = PLAYER_ACTION_SWIMMING;
		case 3:	PlayerAction[playerid] = PLAYER_ACTION_SKYDIVING;
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(IsPlayerAlive(playerid))
	{
		if(PlayerTick[playerid][ptMoney] < gettimestamp()) 
		{
			PlayerTick[playerid][ptMoney] = gettimestamp();
			AC_MoneyDetect(playerid);
			if(!PlayerSyncs[playerid]) {
				PlayerSyncs[playerid] = true;
			}
			return 1;
		}
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}