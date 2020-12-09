/*
=============================================================================================

	City of Angels Role Play v18.5.5.
	Authors:  cofi(Jacob_Williams), Logan, Woo, B-Matt, kiddo, ShadY, hodza, Runner, Khawaja
	(c) 2020 City of Angels - All Rights Reserved.
	Web: www.cityofangels-roleplay.com
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
//#define	WC_DEBUG								false
//#define 	_DEBUG									0 			// YSI
//#define 	MOD_DEBUG								true  		// Gamemode Debug

// MySQL inline query functions
#define MYSQL_USE_YINLINE						true

// #define COA_UCP

// GMT Zone
#define GMT_ZONE_DIFFERENCE						(7200)		// GMT + 2

// 0.3DL
#define NEGATIVE_MODEL_ID 						-40000 // Negativna vrijednost radi Custom Object Modela koji su u minusu

// Server Restart Configuration
//#define AUTO_RESTART_SEQ							// Uncomment for automatic restarts if you have restart API on your VPS/server
#define HTTP_RESTART_REQUEST 					"SERVER_RESTART_API_REQUEST_LINK"

// Server Afterload Unlock
#define SERVER_UNLOCK_TIME						(60)

// Fixes.inc
#define FIXES_ServerVarMsg 0
#define FIX_OnPlayerEnterVehicle 	0
#define FIX_OnPlayerEnterVehicle_2 	0
#define FIX_OnPlayerEnterVehicle_3 	0
#define FIX_OnDialogResponse		0
#define FIX_GetPlayerDialog			0
#define	MAX_IP_CONNECTS 			3
#define FIX_file_inc 				0

// Script Mode settings
//#define COA_TEST

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

// New SA-MP callbacks by Emmet
#include <callbacks> // legacy

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
#include <YSI_Coding\y_timers>
#include <YSI_Data\y_iterate>
#include <YSI_Visual\y_commands>
#include <YSI_Game\y_vehicledata>
#include <YSI_Server\y_flooding>
#include <YSI_Coding\y_va>

// Bcrypt by lassir
#include <bcrypt>
#define BCRYPT_COST 12

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

// MySQL
#include <a_mysql>
#include <YSI_Coding\y_inline>

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

// Server Informations - When chaning SCRIPT_VERSION, you MUST upload new "Changelog.txt" in /scriptfiles
#define HOSTNAME 								"CoA.RP [0.3DL] - Summer Update"
#define SERVER_NAME								"City of Angels"
#define COPYRIGHT                           	"Copyright (c) 2020 City of Angels Roleplay"
#define WEB_URL									"forum.cityofangels-roleplay.com"
#define SCRIPT_VERSION							"CoA RP v18.6.0.-"#GIT_REV
#define DEV_NAME   								"Woo-Logan"

// The rest of the defines
#include "modules/Preincludes/Defines.inc"

// Main Database Connection Handler
new MySQL:g_SQL;

// Server Iterators
new
	Iterator:Vehicles[MAX_VEHICLE_TYPES]<MAX_VEHICLES>,
	Iterator:Skins<MAX_MENU_ITEMS>,
	Iterator:Pickups<MAX_PICKUP>,
	Iterator:Factions<MAX_FACTIONS>,
	Iterator:Houses<MAX_HOUSES>,
	Iterator:HouseFurInt[MAX_HOUSES]<MAX_FURNITURE_SLOTS>,
	Iterator:HouseFurExt[MAX_HOUSES]<EXTERIOR_OBJS_VIP_GOLD>,
	Iterator:BizzFurniture[MAX_BIZZS]<MAX_BIZNIS_FURNITURE_SLOTS>,
	Iterator:Bizzes<MAX_BIZZS>,
	Iterator:Complex<MAX_COMPLEX>,
	Iterator:ComplexRooms<MAX_COMPLEX_ROOMS>,
	Iterator:Garages<MAX_GARAGES>,
	Iterator:IllegalGarages<MAX_ILEGAL_GARAGES>,
	Iterator:V_PACKAGES[MAX_VEHICLES]<MAX_PACKAGE_VEHICLE>;

// Player Iterators
new 
	Iterator:P_PACKAGES[MAX_PLAYERS]<MAX_PLAYER_PACKAGES>,
	Iterator:P_Weapons[MAX_PLAYERS]<MAX_PLAYER_WEAPON_SLOTS>;

// Global Enumerators
#include "modules/Preincludes/Enumerators.inc"

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

new adminfly[MAX_PLAYERS];

new texture_buffer[10256];
new PlayerUpdatePage[MAX_PLAYERS] = 0;

new playeReport[MAX_PLAYERS] = { -1, ... };

new entering[MAX_PLAYERS];
new onexit[MAX_PLAYERS];

new
	ghour 					= 0,
	GMX 					= 0,
	WeatherTimer 			= 0,
	WeatherSys 				= 10,
	HappyHours				= 0,
	HappyHoursLVL			= 0,
	PlayerText:GlobalForumLink[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MechanicTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	bool:PlayerCarTow	[MAX_PLAYERS];

//FLY
new Float:ACPosX[MAX_PLAYERS], Float:ACPosY[MAX_PLAYERS], Float:ACPosZ[MAX_PLAYERS];

// Players 32 bit
new
	//_QuickTimer[MAX_PLAYERS] = 0,
	GlobalMapIcon[MAX_PLAYERS],
	bool:OnSecurityBreach[MAX_PLAYERS] = false,
	bool:FDArrived[MAX_PLAYERS],
	Float:PlayerTrunkPos[MAX_PLAYERS][3],
	GlobalSellingPlayerID[ MAX_PLAYERS ] = { 0, ... },
	GlobalSellingPrice[ MAX_PLAYERS ] = { 0, ... },
	PlayerExName[ MAX_PLAYERS ][ MAX_PLAYER_NAME ],
	VehicleEquipment[ MAX_PLAYERS ],
	VehicleTrunk[ MAX_PLAYERS ],
	bool:BoomBoxPlanted[ MAX_PLAYERS ],
	BoomBoxObject[ MAX_PLAYERS ],
	PlayerAction[MAX_PLAYERS],
	bool:PlayerWounded[ MAX_PLAYERS ],
	PlayerWoundedSeconds[ MAX_PLAYERS ],
	PlayerWTripTime[ MAX_PLAYERS ],
	Timer:PlayerTask[ MAX_PLAYERS ],
	bool:PlayerGlobalTaskTimer[ MAX_PLAYERS ],
	bool:SafeSpawning[ MAX_PLAYERS ],
	bool:SafeSpawned[ MAX_PLAYERS ],
	bool:PlayerReward[ MAX_PLAYERS ],
	bool:PlayerCrashed[ MAX_PLAYERS ],
	bool:PlayerSyncs[ MAX_PLAYERS ],
	bool:Frozen[ MAX_PLAYERS ],
	bool:PlayerBlocked[MAX_PLAYERS],
	bool:PlayerWoundedAnim[MAX_PLAYERS],
	bool:rob_started[MAX_PLAYERS] = false,
	bool:blockedNews[MAX_PLAYERS] = false,
	PlayerSprayID[MAX_PLAYERS],
	PlayerSprayTimer[MAX_PLAYERS],
	PlayerSprayPrice[MAX_PLAYERS],
	PlayerSprayVID[MAX_PLAYERS],
	KilledBy[MAX_PLAYERS],
	WoundedBy[MAX_PLAYERS],
	KilledReason[MAX_PLAYERS],
	gStartedWork[MAX_PLAYERS],
	MarriagePartner[ MAX_PLAYERS ],
	InjectPlayer[MAX_PLAYERS],
	CallingId[ MAX_PLAYERS ] = { 999, ... },
	//PlayerCallPlayer[ MAX_PLAYERS ] = {	INVALID_PLAYER_ID, ... },
	PlayerAFK[MAX_PLAYERS],
	LastVehicle[MAX_PLAYERS] = INVALID_VEHICLE_ID,
	PlayerTuningVehicle[ MAX_PLAYERS ] = INVALID_VEHICLE_ID,
	Text3D:DoorHealth3DText[MAX_VEHICLES],
	Text3D:TrunkHealth3DText[MAX_VEHICLES];
	//bool:aprilfools[MAX_PLAYERS] = true;

//fisher
new GotRod[MAX_PLAYERS];

// Bank Credits
new paymentBuyPrice[MAX_PLAYERS],
	buyBizID[MAX_PLAYERS];

// Vehicles
new
	rentedVehID[MAX_PLAYERS],
	LastVehicleDriver[ MAX_VEHICLES ] = INVALID_PLAYER_ID,
	SirenObject[MAX_VEHICLES]	= { INVALID_OBJECT_ID, ... };

//Players Vars
//(rBits)
new
	Bit1:	gr_LoginChecksOn		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_SaveArmour 			<MAX_PLAYERS>,
	Bit1: 	gr_PlayerPickingJack 	<MAX_PLAYERS> =  Bit1: false,
	Bit1:	gr_PlayerJackSure 		<MAX_PLAYERS> =  Bit1: false,
	Bit1:	gr_CreateObject			<MAX_PLAYERS> =	 Bit1: false,
	Bit1:	gr_PlayerDownloading	<MAX_PLAYERS>  = Bit1: false,
	// TODO: misspelled, FirstSpawn
	Bit1:	gr_FristSpawn			<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_SafeBreaking			<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggedIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggingIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_NewUser				<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_VehicleWindows 		<MAX_VEHICLES> = Bit1: false,
	Bit1:	gr_VehicleAttachedBomb	<MAX_VEHICLES> = Bit1: false,
	Bit1: 	gr_PlayerTimeOut		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_ForbiddenPM			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_BlockedPM			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerAlive			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MobileSpeaker		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_SmokingCiggy			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_HasRubber			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerSendKill		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerRadio			<MAX_PLAYERS>  = Bit1: true,
	Bit1:	gr_TrunkOffer			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerInTrunk		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerOnTutorial		<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_animchat             <MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_Blockedreport		<MAX_PLAYERS>  = Bit1: false,
    // TODO: should be part of Player/Char module
	Bit1:   gr_Blind                <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_BlindFold            <MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTrunkEdit		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerUsingSpeedo	<MAX_PLAYERS>  = Bit1: false,
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
	EnteringVehicle[MAX_PLAYERS] = -1,
	FreeBizzID[MAX_PLAYERS] = INVALID_BIZNIS_ID,
	ServicePrice[MAX_PLAYERS] = 0,
	WeaponListID[MAX_PLAYERS],
	WeaponToList[MAX_PLAYERS][MAX_WAREHOUSE_WEAPONS],
	regenabled = false;


new
	WeapNames[][32] = {
		"Unarmed",
		"Brass Knuckles",
		"Golf Club",
		"Night Stick",
		"Knife",
		"Baseball Bat",
		"Shovel",
		"Pool Cue",
		"Katana",
		"Chainsaw",
		"Purple Dildo",
		"Big White Vibrator",
		"Medium White Vibrator",
		"Small White Vibrator",
		"Flowers",
		"Cane",
		"Grenade",
		"Tear Gas",
		"Molotov",
		"Invalid Weapon",
		"Invalid Weapon",
		"Invalid Weapon",
		"Colt 45",
		"Silenced Colt 45",
		"Desert Eagle",
		"Shotgun",
		"Sawnoff Shotgun",
		"Combat Shotgun",
		"Micro SMG",
		"SMG",
		"AK47",
		"M4",
		"Tec9",
		"Country Rifle",
		"Sniper Rifle",
		"Rocket Launcher",
		"HS Rocket Launcher",
		"Flamethrower",
		"Minigun",
		"Satchel Charge",
		"Detonator",
		"Spray Can",
		"Fire Extinguisher",
		"Camera",
		"Night Vision Goggles",
		"Infrared Vision Goggles",
		"Parachute",
		"Fake Pistol"
};

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
	foreach (new i : Player) {
		// Player Camera
		TogglePlayerControllable(i, false);
		SetPlayerPos(i, 1433.4633, -974.7463, 58.0000);
		InterpolateCameraPos(i, 1431.9108, -895.1843, 73.9480, 1431.9108, -895.1843, 73.9480, 100000, CAMERA_MOVE);
		InterpolateCameraLookAt(i, 1431.8031, -894.1859, 74.0085, 1431.8031, -894.1859, 74.0085, 100000, CAMERA_MOVE);
		cseconds += 3;
	}
	GMX = 1;
	new rconstring[100];
	format(rconstring, sizeof(rconstring), "hostname CoA.RP [Pohrana podataka u MySQL bazu]");
	SendRconCommand(rconstring);
	SendRconCommand("password devtest");
	SendClientMessageToAll(COLOR_RED, "[SERVER]: Server Restart procedure initiated. Please stay in game until server stores your data...");
	SaveAll();
	return 1;
}
#endif

RegisterPlayerDeath(playerid, killerid) // funkcija
{
	new
		tmpString[135];
	format(tmpString, 135, "KillWarn: Player %s[%d] killed player %s[%d] with %s!",
		GetName( killerid, false ),
		killerid,
		GetName( playerid, false ),
		playerid,
		GetWeaponNameEx(killerid)
	);
	DMERSBroadCast(COLOR_RED, tmpString, 1);

	mysql_fquery(g_SQL, "INSERT INTO server_deaths (killer_id, death_id, weaponid, date) \n\
		VALUES ('%d','%d','%d','%d')",
		PlayerInfo[ KilledBy[playerid] ][ pSQLID ],
		PlayerInfo[ playerid ][ pSQLID ],
		KilledReason[playerid],
		gettimestamp()
	);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/kills.txt", "(%s) %s{%d}(%s) has killed %s{%d}(%s) with %s(%d).",
		ReturnDate(),
		GetName(killerid, false),
		PlayerInfo[killerid][pSQLID],
		ReturnPlayerIP(killerid),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		ReturnPlayerIP(playerid),
		GetWeaponNameEx(KilledReason[playerid]),
		KilledReason[playerid]
	);
	#endif
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	PlayerDeath[playerid][pDeathX] 	= X;
	PlayerDeath[playerid][pDeathY] 	= Y;
	PlayerDeath[playerid][pDeathZ] 	= Z;
	PlayerDeath[playerid][pDeathInt] 	= GetPlayerInterior( playerid );
	PlayerDeath[playerid][pDeathVW] 		= GetPlayerVirtualWorld( playerid );

	// FIRST DEATH
	if( DeathData[ playerid ][ ddOverall ] > 0)
	{
		DeathTime[playerid] = gettimestamp() + 60;
		//DropPlayerMoney(playerid); // Gubitak novca

		//DropPlayerWeapons(playerid, X, Y);
		//DropPlayerDrugs(playerid, X, Y, true);

		mysql_fquery_ex(g_SQL, "INSERT INTO player_deaths(player_id, killed, pos_x, pos_y, pos_z, interior, viwo, time) \n\
			VALUES ('%d','%f','%f','%f','%d','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerDeath[playerid][pKilled],
			PlayerDeath[playerid][pDeathX],
			PlayerDeath[playerid][pDeathY],
			PlayerDeath[playerid][pDeathZ],
			PlayerDeath[playerid][pDeathInt],
			PlayerDeath[playerid][pDeathVW],
			gettimestamp()
		);
	}
	AC_ResetPlayerWeapons(playerid);

	HiddenWeapon[playerid][pwSQLID] = -1;
	HiddenWeapon[playerid][pwWeaponId] = 0;
	HiddenWeapon[playerid][pwAmmo] = 0;

	// Mobile Dissapear
	PhoneAction(playerid, PHONE_HIDE);
	PhoneStatus[playerid] = PHONE_HIDE;
	CancelSelectTextDraw(playerid);

	if (Player_UsingMask(playerid) && IsValidDynamic3DTextLabel(NameText[playerid]))
	{
		DestroyDynamic3DTextLabel(NameText[playerid]);
		NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
		Player_SetUsingMask(playerid, false);
	}
	KilledBy[playerid] = INVALID_PLAYER_ID;
	WoundedBy[playerid] = INVALID_PLAYER_ID;
	KilledReason[playerid] = -1;

	PlayerDeath[playerid][pKilled] = 0;

	Bit1_Set(gr_PlayerAlive, 	playerid, true);
	return 1;
}

stock ResetPlayerEnumerator()
{
	for(new p=0; p<MAX_PLAYERS; p++)
		ResetPlayerVariables(p);

	return 1;
}

Public:ResetIterators()
{
	Iter_Clear(Player);
	Iter_Clear(Pickups);
	Iter_Clear(Factions);
	Iter_Clear(Houses);
	Iter_Clear(Bizzes);
	Iter_Clear(Complex);
	Iter_Clear(ComplexRooms);
	Iter_Clear(Garages);
	Iter_Clear(IllegalGarages);
	return 1;
}

// TODO: should be a part of Player module
ResetPlayerVariables(playerid)
{	
	//aprilfools[playerid] = false;
	PlayerUpdatePage[playerid] = 0;
    entering[playerid] = 0;
    onexit[playerid] = 0;
   	TWorking[playerid] = 0;
	ResetPlayerExperience(playerid);
	ResetPlayerWounded(playerid);
	adminfly[playerid] = 0;
	playeReport[playerid] = -1;
	PlayerInfo[playerid][pAddingRoadblock] = 0;
    GotRod[playerid] = 0;
	//
	PhoneStatus[playerid] = 0;
	//PD Callsign
	format(PlayerInfo[playerid][pCallsign], 60, "");
	//rBits
	Bit1_Set( gr_PlayerDownloading		, playerid, false );
	Bit1_Set( gr_FristSpawn				, playerid, false );
	Bit1_Set( gr_PlayerLoggingIn 		, playerid, false );
	Bit1_Set( gr_PlayerLoggedIn 		, playerid, false );
	Bit1_Set( gr_NewUser				, playerid, false );
	Bit1_Set( gr_PlayerTimeOut			, playerid, false );
	Bit1_Set( gr_ForbiddenPM			, playerid, false );
	Bit1_Set( gr_BlockedPM				, playerid, false );
	Bit1_Set( gr_CreateObject			, playerid, false );
	Bit1_Set( gr_Blockedreport			, playerid, false );
	Bit1_Set( gr_PlayerAlive			, playerid, true  );
	Bit1_Set( gr_MobileSpeaker			, playerid, false );
	Bit1_Set( gr_SmokingCiggy			, playerid, false );
	Bit1_Set( gr_HasRubber				, playerid, false );
	Bit1_Set( gr_PlayerSendKill			, playerid, false );
	Bit1_Set( gr_animchat               , playerid, false );
	Bit1_Set( gr_PlayerRadio			, playerid, true );
	Bit1_Set( gr_TrunkOffer				, playerid, false );
	Bit1_Set( gr_PlayerTrunkEdit        , playerid, false );
	Bit1_Set( gr_PlayerInTrunk			, playerid, false );
	// TODO: Player/Char module
	Bit1_Set( gr_Blind					, playerid, false );
	Bit1_Set( gr_BlindFold				, playerid, false );
	Player_SetIsTied(playerid, false);
	Bit1_Set( gr_ImpoundApproval		, playerid, false );
	Bit2_Set( gr_BikeBunnyHop			, playerid, 0 );
	Bit2_Set( gr_PlayerJumps			, playerid, 0 );
	Bit4_Set( gr_WeaponTrunkEditSlot	, playerid, 0 );
	Bit4_Set( gr_MusicCircle			, playerid, 0 );
	Bit4_Set( gr_SpecateId				, playerid, 0 );
	Bit8_Set( gr_LoginInputs			, playerid, 0 );
	Bit8_Set( gr_RegisterInputs			, playerid, 0 );
	Bit8_Set( gr_ShakeStyle				, playerid, 0 );
	Bit16_Set( gr_ShakeOffer			, playerid, 999 );
	Player_SetLastVehicle(playerid, INVALID_VEHICLE_ID);
	Bit16_Set( gr_LastPMId				, playerid, 999 );
	Player_SetAmbulanceId(playerid, INVALID_VEHICLE_ID);

    // TODO: these should be moved to their own modules and hooking ResetPlayerVariables
    Player_SetInBusiness        (playerid, INVALID_BIZNIS_ID);
    Player_SetInApartmentComplex(playerid, INVALID_COMPLEX_ID);
    Player_SetInApartmentRoom   (playerid, INVALID_COMPLEX_ID);
    Player_SetInHouse           (playerid, INVALID_HOUSE_ID);
    Player_SetInfrontHouse      (playerid, INVALID_HOUSE_ID);
    Player_SetInGarage          (playerid, INVALID_HOUSE_ID);
    Player_SetInPickup          (playerid, -1);


	blockedNews[playerid] = false;
	
	// Mobile
	ResetMobileVariables(playerid);
	ResetMobileContacts(playerid);

	// Exiting Vars
	PlayerSafeExit[playerid][giX] = 0;
	PlayerSafeExit[playerid][giY] = 0;
	PlayerSafeExit[playerid][giZ] = 0;
	PlayerSafeExit[playerid][giRZ] = 0;

	// Weapons
	AC_ResetPlayerWeapons(playerid, false);

	strdel(PlayerContactName[playerid][0], 0, 11);
	strdel(PlayerContactName[playerid][1], 0, 11);
	strdel(PlayerContactName[playerid][2], 0, 11);
	strdel(PlayerContactName[playerid][3], 0, 11);
	strdel(PlayerContactName[playerid][4], 0, 11);
	strdel(PlayerContactName[playerid][5], 0, 11);
	strdel(PlayerContactName[playerid][6], 0, 11);
	strdel(PlayerContactName[playerid][7], 0, 11);
	strdel(PlayerContactName[playerid][8], 0, 11);
	strdel(PlayerContactName[playerid][9], 0, 11);

	PlayerContactNumber[playerid][0]   		= 0;
	PlayerContactNumber[playerid][1]   		= 0;
	PlayerContactNumber[playerid][2]   		= 0;
	PlayerContactNumber[playerid][3]   		= 0;
	PlayerContactNumber[playerid][4]   		= 0;
	PlayerContactNumber[playerid][5]   		= 0;
	PlayerContactNumber[playerid][6]   		= 0;
	PlayerContactNumber[playerid][7]   		= 0;
	PlayerContactNumber[playerid][8]   		= 0;
	PlayerContactNumber[playerid][9]   		= 0;

	Bit1_Set( gr_PlayerUsingPhonebooth			, playerid, false );
	Bit1_Set( gr_PlayerTakingSelfie		, playerid, false );
	Bit8_Set( gr_RingingTime			, playerid, 0 );

	// Admin
	Bit1_Set(gr_SaveArmour, 	playerid, false);

	// Administrator
	Bit1_Set(a_AdminChat, 		playerid, true);
	Bit1_Set(a_PlayerReconed,	playerid, false);
	Bit1_Set(a_PMears, 			playerid, false);
	Bit1_Set(a_AdNot, 			playerid, true);
	Bit1_Set(a_DMCheck, 		playerid, true);
	
	Bit1_Set(a_AdminOnDuty, 	playerid, false);
	Bit1_Set(a_BlockedHChat, 	playerid, false);
	Bit1_Set(a_NeedHelp,		playerid, false);
	Bit1_Set(a_TogReports, 		playerid, false );
	

	// Anti Spam
	AntiSpamInfo[ playerid ][ asPrivateMsg ] 	= 0;
	AntiSpamInfo[ playerid ][ asCreditPay ] 	= 0;
	AntiSpamInfo[ playerid ][ asCarTrunk ] 		= 0;
	AntiSpamInfo[ playerid ][ asHouseWeapon ] 	= 0;
	AntiSpamInfo[ playerid ][ asBuying ] 		= 0;
	AntiSpamInfo[ playerid ][ asDoorShout ] 	= 0;


	PlayerInfo[playerid][pPhoneBG] = -1263225696;
	PlayerInfo[playerid][pPhoneMask] = 0;

	// Ulice
	DestroyZonesTD(playerid);
	LastPlayerZone[playerid] = -1;
	g_ZoneUpdateTick[playerid] = gettimestamp();

	// Fire
	// ResetFireArrays(playerid);
	PlayerTextDrawDestroy(playerid, GlobalForumLink[playerid]);
	GlobalForumLink[playerid] = PlayerText:INVALID_TEXT_DRAW;

	// Tut
	if( Bit1_Get( gr_PlayerOnTutorial, playerid ) ) {
		Bit1_Set(gr_PlayerOnTutorial, playerid, false);
		stop TutTimer[playerid];
	}


	// Rent Veh
	rentedVehicle[playerid] 	= false;
	rentedVehID[playerid] 		= -1;
	locatedRentedVeh[playerid] 	= false;
	EnteringVehicle[playerid] = -1;
	FreeBizzID[playerid] = INVALID_BIZNIS_ID,

	// Ticks
	PlayerTick[playerid][ptReport]			= gettimestamp();
	PlayerTick[playerid][ptMoney]			= gettimestamp();
	PlayerTick[playerid][ptHelperHelp]		= gettimestamp();
	PlayerTick[playerid][ptKill]			= gettimestamp();
	PlayerTick[playerid][ptMainTimer] 		= gettimestamp();

	//Enums	
	PlayerInfo[playerid][pForumName] 		= EOS;
	PlayerInfo[playerid][pLastLogin] 		= EOS;
	PlayerInfo[playerid][pSAMPid] 			= EOS;
	PlayerInfo[playerid][pEmail][0] 		= EOS;

	PlayerInfo[playerid][pSecQuestAnswer][0]= EOS;
	PlayerInfo[playerid][pLastUpdateVer] 	= EOS;

	PlayerInfo[playerid][pSQLID] 			= 0; 	//Integer
	PlayerInfo[playerid][pLastLoginTimestamp] = 0;
	PlayerInfo[playerid][pRegistered] 		= 0;
	PlayerInfo[playerid][pTempConnectTime]	= 0;
	PlayerInfo[playerid][pSecQuestion] 		= -1;
	PlayerInfo[playerid][pBanned]			= 0;
	PlayerInfo[playerid][pWarns]			= 0;
	PlayerInfo[playerid][pLevel]			= 0;
	PlayerInfo[playerid][pAdmin]			= 0;
	PlayerInfo[playerid][pTempRank][0]		= 0;
	PlayerInfo[playerid][pTempRank][1]		= 0;
	PlayerInfo[playerid][pAdminHours]		= 0;
	PlayerInfo[playerid][pHelper]			= 0;
	PlayerInfo[playerid][pConnectTime]		= 0;
	PlayerInfo[playerid][pMuted]			= 0;
	PlayerInfo[playerid][pRespects]			= 0;
	PlayerInfo[playerid][pSex]				= 0;
	PlayerInfo[playerid][pAge]				= 0;
	PlayerInfo[playerid][pChangenames]		= 0;
	PlayerInfo[playerid][pChangeTimes]		= 0;
	PlayerInfo[playerid][pMoney]			= 0;
	PlayerInfo[playerid][pBank]				= 0;

	PlayerInfo[playerid][pTempConnectTime]	= 0;
	PlayerInfo[playerid][pLawDuty]          = 0;
	

	PlayerMobile[playerid][pCryptoNumber]		= 0;
	PlayerMobile[playerid][pMobileNumber]		= 0;
	PlayerMobile[playerid][pMobileModel]		= 0;
	PlayerMobile[playerid][pMobileCost] 		= 0;

	PlayerDeath[playerid][pKilled]			= 0;
	PlayerDeath[playerid][pDeathInt] 		= 0;
	PlayerDeath[playerid][pDeathVW] 			= 0;

	PlayerInfo[playerid][pMaskID]			= -1;
	
	PlayerKeys[playerid][pHouseKey]			= INVALID_HOUSE_ID;
	PlayerKeys[playerid][pRentKey]			= INVALID_HOUSE_ID;
	PlayerKeys[playerid][pBizzKey]			= INVALID_BIZNIS_ID;
	PlayerKeys[playerid][pComplexKey]		= INVALID_COMPLEX_ID;
	PlayerKeys[playerid][pComplexRoomKey]	= INVALID_COMPLEX_ID;
	PlayerKeys[playerid][pGarageKey]		= -1;
	PlayerKeys[playerid][pIllegalGarageKey]	= -1;
	PlayerKeys[playerid][pVehicleKey]		= -1;

	PlayerInfo[playerid][pToolkit]			= 0;
	PlayerInfo[playerid][pParts]			= 0;
	PlayerInfo[playerid][pBoomBox] 			= 0;

	PlayerInfo[playerid][pCasinoCool]		= 0;
	PlayerInfo[playerid][pNews]				= 0;
	PlayerInfo[playerid][pCanisterLiters] 	= 0;
	PlayerInfo[playerid][pCanisterType] 	= -1;
	PlayerInfo[playerid][pGrafID]			= -1;
	PlayerInfo[playerid][pTagID]			= -1;
	PlayerInfo[playerid][hRope] 			= 0;
	PlayerInfo[playerid][pAmmuTime]			= 0;

	PlayerInfo[playerid][pPrimaryWeapon] 	= 0;
	PlayerInfo[playerid][pSecondaryWeapon] 	= 0;
	PlayerKeys[playerid][pWarehouseKey] 	= -1;
	PlayerInfo[playerid][pMustRead]			= false;
	
	//Floats
	PlayerInfo[playerid][pMarker1][0]		= 0.0;
	PlayerInfo[playerid][pMarker1][1]		= 0.0;
	PlayerInfo[playerid][pMarker1][2]		= 0.0;
	PlayerInfo[playerid][pMarker2][0]		= 0.0;
	PlayerInfo[playerid][pMarker2][1]		= 0.0;
	PlayerInfo[playerid][pMarker2][2]		= 0.0;
	PlayerInfo[playerid][pMarker3][0]		= 0.0;
	PlayerInfo[playerid][pMarker3][1]		= 0.0;
	PlayerInfo[playerid][pMarker3][2]		= 0.0;
	PlayerInfo[playerid][pMarker4][0]		= 0.0;
	PlayerInfo[playerid][pMarker4][1]		= 0.0;
	PlayerInfo[playerid][pMarker4][2]		= 0.0;
	PlayerInfo[playerid][pMarker5][0]		= 0.0;
	PlayerInfo[playerid][pMarker5][1]		= 0.0;
	PlayerInfo[playerid][pMarker5][2]		= 0.0;
	PlayerTrunkPos[playerid][0] 			= 0.0;
	PlayerTrunkPos[playerid][1] 			= 0.0;
	PlayerTrunkPos[playerid][2] 			= 0.0;
	PlayerDeath[playerid][pDeathX] 		= 0.0;
	PlayerDeath[playerid][pDeathY] 		= 0.0;
	PlayerDeath[playerid][pDeathZ] 		= 0.0;

	// Previous Info(/learn, etc.)
	ResetPlayerPreviousInfo(playerid);

	// Objects
	for(new i = 0; i < MAX_CUSTOMIZED_OBJECTS; i++)
	{
		PlayerObject[ playerid ][i][poSQLID]		= -1;
		PlayerObject[ playerid ][i][ poModelid ]	= -1;
		PlayerObject[ playerid ][i][ poBoneId ]		= 0;
		PlayerObject[ playerid ][i][ poPlaced ]		= false;
		PlayerObject[ playerid ][i][ poPosX ]   	= 0.0;
		PlayerObject[ playerid ][i][ poPosY ]		= 0.0;
		PlayerObject[ playerid ][i][ poPosZ ]		= 0.0;
		PlayerObject[ playerid ][i][ poRotX ]		= 0.0;
		PlayerObject[ playerid ][i][ poRotY ]		= 0.0;
		PlayerObject[ playerid ][i][ poRotZ ]		= 0.0;
		PlayerObject[ playerid ][i][ poScaleX ]		= 1.0;
		PlayerObject[ playerid ][i][ poScaleY ]		= 1.0;
		PlayerObject[ playerid ][i][ poScaleZ ]		= 1.0;
		PlayerObject[ playerid ][i][ poColor1 ] 	= 0;
		PlayerObject[ playerid ][i][ poColor2 ] 	= 0;

		if( IsPlayerAttachedObjectSlotUsed(playerid, i) )
			RemovePlayerAttachedObject( playerid, i );
	}
	if( IsPlayerAttachedObjectSlotUsed(playerid, 7) )
		RemovePlayerAttachedObject( playerid, 7 );
	if( IsPlayerAttachedObjectSlotUsed(playerid, 8) )
		RemovePlayerAttachedObject( playerid, 8 );
	if( IsPlayerAttachedObjectSlotUsed(playerid, 9) )
		RemovePlayerAttachedObject( playerid, 9 );

	// Weapon Enum reset
	for(new wslot = 0; wslot < MAX_PLAYER_WEAPON_SLOTS; wslot++)
	{
		PlayerWeapons[playerid][pwSQLID][wslot] = -1;
		PlayerWeapons[playerid][pwWeaponId][wslot] = 0;
		PlayerWeapons[playerid][pwAmmo][wslot] = 0;
		PlayerWeapons[playerid][pwHidden][wslot] = 0;
	}
	HiddenWeapon[playerid][pwSQLID] = -1;
	HiddenWeapon[playerid][pwWeaponId] = 0;
	HiddenWeapon[playerid][pwAmmo] = 0;

	// 32bit
	PlayerExName[ playerid ][ 0 ] 	= '\0';
	VehicleEquipment[ playerid ]	= INVALID_VEHICLE_ID;
	MarriagePartner[ playerid ]     = INVALID_PLAYER_ID;
	InjectPlayer[ playerid ]     	= INVALID_PLAYER_ID;
	LastVehicle[playerid]			= INVALID_VEHICLE_ID;
	ServicePrice[playerid]			= 0;
	KilledBy[playerid]				= INVALID_PLAYER_ID;
	WoundedBy[playerid]				= INVALID_PLAYER_ID;
	KilledReason[playerid]			= -1;
	if(PlayerSprayVID[playerid] != 0)
	{
		SetVehicleVirtualWorld(PlayerSprayVID[playerid], 0);
		SetVehicleToRespawn(PlayerSprayVID[playerid]);
	}
	PlayerSprayID[playerid]			= -1;
	PlayerSprayTimer[playerid]		= 0;
	PlayerSprayPrice[playerid]		= 0;
	PlayerSprayVID[playerid]		= 0;
	PlayerAction[playerid]			= 0;

	PlayerInfo[playerid][cIP] = EOS;

	//Transporter
	TCarry[playerid] = 0;
	TDone[playerid] = 0;
	TWorking[playerid] = 0;
	carjob[playerid]= 0;

	// Bools
	PlayerGlobalTaskTimer[ playerid ] = false;
	PlayerCrashed[ playerid ] 	= false;
	SafeSpawned[ playerid ] 	= false;
	OnSecurityBreach[ playerid ] = false;
	FDArrived[ playerid ] 		= false;
	PlayerReward[ playerid ] 	= false;
	SafeSpawning[ playerid ] 	= false;
	PlayerSyncs[ playerid ] 	= false;
	PlayerBlocked[ playerid ] 	= false;

	ResetFactoryVariables(playerid);
	ResetHouseVariables(playerid);
	ResetTaxiVariables(playerid);
	DestroySpeedoTextDraws(playerid);
	//ResetPlayerDrivingVars(playerid);
	DisablePlayerKeyInput(playerid);

	ResetRuletArrays(playerid);
	ResetRuletTable(playerid);
	//ResetBlackJack(playerid);
	
	foreach(new i : Player)
	{
		CanPMAdmin[playerid][i] = 0;
	}
	return 1;
}

Public:SaveAll()
{
	printf("[SERVER]: Automatic scheduled restart initiated. Storing data into MySQL database.");
	if(Iter_Count(Player) > 0)
	{
		foreach (new i : Player) {
			if (Bit1_Get(gr_PlayerLoggedIn, i) != 0)
				Kick(i);
		}
	}
}

Public:GlobalServerTimer()
{
	new
		tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);

	if( (tmphour > ghour) || (tmphour == 0 && ghour == 23) )
	{
		UpdateIlegalGarages(0);
		//SetWorldTime(tmphour);
		ghour = tmphour;
	}
	if(GMX != 1 && tmphour == 5 && tmpmins == 5 && tmpsecs < 10)//if(tmphour == 5 && tmpmins == 5 && tmpsecs == 10)
	{
		CheckAccountsForInactivity(); // Skidanje posla i imovine neaktivnim igracima
		#if defined AUTO_RESTART_SEQ
		GMX = 1;
		StartGMX();
		#endif
	}
	return 1;
}

Public:DynamicWeather()
{
	if( gettimestamp() >= WeatherTimer )
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
			foreach(new i : Player) {
				if(PlayerInfo[i][pAdmin] >= 1338) {
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
	AntiDeAMX();
}

// Database Load Function used for hooking in OnGameModeInit callback
forward LoadServerData();
public LoadServerData() 
{
	return 1;
}

public OnGameModeInit()
{
	SendRconCommand("password 6325234hbbzfg12312313gz313"); // Server Lock while everything loads

	ResetIterators();
	ResetVehicleEnumerator();
	ResetHouseEnumerator();
	ResetBizzEnumerator();
	ResetPlayerEnumerator();
	print("Report: Iterators And Enumerators Cleared.");

	 // Loading of custom models derives from artconfig.pwn module(artconfig.txt alternative)
	LoadCustomModels();
	print("Report: Custom Models Loaded.");

	// SQL stuff
	g_SQL = mysql_connect_file();
	if(g_SQL == MYSQL_INVALID_HANDLE)
	{
		print("[SERVER ERROR]: Failed to connect MySQL Database!");
		return 1;
	}
	mysql_log(ERROR | WARNING);
	print("Report: MySQL Connection & Log Mode Established.");

	MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL, "scriptfiles/SAmin.hmap");
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
	for(new i = 0; i < 312; i++) {
        if(IsValidSkin(i))
            AddPlayerClass(i,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
    }
	print("Report: Server Info Loaded.");

	// Auto Unlock Settings
	GMX = 2;
	cseconds = SERVER_UNLOCK_TIME; 

	// Global Loads - Database Load Functions
	print("Report: MySQL Loading Stage Initialized.");
	LoadServerData();
	print("Report: MySQL Loading Stage Finished.");

	printf("Report: GameMode Time Set on %s. %s Loaded Sucessfully!", 
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
    // Actors
    //DestroyRuletWorkers();

    // SQL stuff
    mysql_close();

    for (new i; i < MAX_OBJECTS; i++)
    {
        if (IsValidDynamicObject(i))
            DestroyDynamicObject(i);

        if (IsValidObject(i))
            DestroyObject(i);
    }

    return 1;
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
    new backtrace[2048];
    GetAmxBacktrace(backtrace, sizeof(backtrace));
    Log_Write("logfiles/AMX_Query_Log.txt", "\n[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s\n%s", ReturnDate(), errorid, error, callback, query, backtrace);
    printf("[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s\n%s", ReturnDate(), errorid, error, callback, query, backtrace);
    return 1;
}

// TODO: should be a part of Poker module, hooked
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    PokerTableEdit(playerid, objectid, response, x, y, z, rx, ry, rz);
    StorageObjectEdit(playerid, objectid, response, x, y, z, rx, ry, rz);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (ispassenger)
    {
        if (VehicleInfo[vehicleid][vLocked])
        {
            RemovePlayerFromVehicle(playerid);

            if (GetPlayerAnimationIndex(playerid))
            {
                new
                    animlib[32],
                    animname[32];

                GetAnimationName(GetPlayerAnimationIndex(playerid), animlib,
                                 sizeof(animlib), animname, sizeof(animname));

                if (strfind(animname, "fall", true) != -1)
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
    if (!cmdtext[0])
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

			if(!SafeSpawned[playerid] || OnSecurityBreach[playerid])
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR,"You're not safely spawned, you can't use commands!");
				return COMMAND_ZERO_RET;
			}
			if(!cmdtext[0])
			{
				Kick(playerid); // Because it's impossible to send valid NULL command
				return COMMAND_ZERO_RET;
			}
			PlayerAFK[playerid] = 0;

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

hook OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, COLOR_PLAYER);
	return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerDisconnect(playerid, reason)
{
	entering[playerid] = 0;
	onexit[playerid] = 0;
	if(IsPlayerLogging(playerid))
		stop FinishPlayerSpawn(playerid);
	// Login Time && IP fetch
	format(PlayerInfo[playerid][pLastLogin], 24, ReturnDate());

	GotRod[playerid] = 0;
	RemovePlayerFromVehicle(playerid);
	new Float:armour;
 	GetPlayerArmour(playerid, armour);
	PlayerHealth[playerid][pArmour] 	= armour;

	new
		szString[ 73 ];
	new szDisconnectReason[3][] = {
        "Timeout/Crash",
        "Quit",
        "Kick/Ban"
    };

	if( !IsPlayerReconing(playerid) && GMX == 0) {
		format( szString, sizeof szString, "(( %s[%d] just left the server. (%s) ))",
			GetName(playerid, false ),
			playerid,
			szDisconnectReason[ reason ]
		);
		ProxDetector(10.0, playerid, szString, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}

	//PM
	foreach (new i : Player)
	{
		if(CanPMAdmin[i][playerid] == 1)
		{
			CanPMAdmin[i][playerid] = 0;
		}
	}

	if( !isnull(PlayerExName[playerid]) ) SetPlayerName(playerid, PlayerExName[playerid]);
	if(IsValidDynamic3DTextLabel(NameText[playerid]))
	{
		DestroyDynamic3DTextLabel(NameText[playerid]);
		NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
	}
	if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0)
		SaveAdminConnectionTime(playerid);

	CheckPlayerCrash(playerid, reason);

	// Offline query
	mysql_fquery(g_SQL, "UPDATE accounts SET online = '0' WHERE sqlid = '%d'", PlayerInfo[ playerid ][ pSQLID ]);

	// Tuning
	if( Bit1_Get( gr_PlayerInTuningMode	, playerid ) )
		SetVehicleToRespawn(PlayerTuningVehicle[playerid]);

	// Main Player Account Save Func.
	SavePlayerData(playerid);
	
	// Player Sets
	secquestattempt[playerid] = 3;
	if(GMX == 1) 
	{
		SendClientMessage(playerid, COLOR_RED, "[OBAVIJEST] Spremljeni su Vasi podaci. Server Vas je automatski kickao.");
		KickMessage(playerid);
	}
	
	defer SafeResetPlayerVariables(playerid);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerLogged(playerid) || SafeSpawned[playerid])
		return 1;

	if(GMX == 1) 
	{
		SendClientMessage(playerid,COLOR_RED, "ERROR: Server is currently in data storing pre-restart process. You have been automatically kicked.");
		KickMessage(playerid);
		return 1;
	}
	if (!IsPlayerLogged(playerid) || IsPlayerConnected(playerid))
	{
		//Resets
		ResetPlayerVariables(playerid);

		if( IsPlayerNPC(playerid) ) {
			SpawnPlayer(playerid);
			return 1;
		}
        ClearPlayerChat(playerid);

		//Invalid name?
		
		new
			tmpname[24];

		GetPlayerName(playerid, tmpname, MAX_PLAYER_NAME);
		if(!IsValidNick(tmpname)) {
			SendClientMessage(playerid, COLOR_SAMP_GREEN, "ERROR: Invalid RolePlay nickname, please visit "WEB_URL" for more info!");
			KickMessage(playerid);
			return 0;
		}
		SafeSpawning[ playerid ] = true;

		//PlayerSets
		SetPlayerColor(playerid, 	COLOR_PLAYER);
		SetPlayerWeather(playerid, 	WeatherSys);

		new
			hour, minute;
		GetServerTime(hour, minute);
		SetPlayerTime(playerid,hour,minute);

		// Player login
		TogglePlayerSpectating(playerid, true);
		SetPlayerVirtualWorld(playerid, playerid);
		SetPlayerInterior(playerid, 0);

		// Player Camera
		TogglePlayerControllable(playerid, false);

		GetPlayerIp(playerid, PlayerInfo[playerid][cIP], 24);

		mysql_tquery(g_SQL, 
			va_fquery(g_SQL, "SELECT sql FROM accounts WHERE name = '%e'", tmpname), 
			"CheckPlayerInBase", 
			"i", 
			playerid
		);
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 0;
}

// TODO: should be a part of 0.3DL Download module
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!Bit1_Get(gr_PlayerDownloading, playerid))
	{
		Bit1_Set(gr_PlayerLoggedIn, playerid, false);
		Bit1_Set(gr_PlayerDownloading, playerid, true);
		SafeSpawning[playerid] = true;
	}

	new fullurl[256+1];
	new dlfilename[64+1];
	new foundfilename=0;
	new SERVER_DOWNLOAD[] = "http://51.77.200.63/samp_models/"; // Models Redirect Download Link for faster download speed

	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE) {
		foundfilename = FindTextureFileNameFromCRC(crc,dlfilename,64);
	}
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE) {
		foundfilename = FindModelFileNameFromCRC(crc,dlfilename,64);
	}

	if(foundfilename) {
		format(fullurl,256,"%s/%s", SERVER_DOWNLOAD, dlfilename);
		RedirectDownload(playerid,fullurl);
	}
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	Bit1_Set(gr_PlayerDownloading, playerid, false);
	return 1;
}

hook OnPlayerSpawn(playerid)
{	
	// Player Sets
    StopAudioStreamForPlayer(playerid);
    ResetPlayerMoney(playerid);
    SetCameraBehindPlayer(playerid);
    SetPlayerFightingStyle(playerid, PlayerGym[playerid][pFightStyle]);
	
    // Player Skill
    SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47,             999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_M4,               999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5,              999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN,          999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN,   999);

    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL,           1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI,        1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN,  1);
    AC_SetPlayerMoney(playerid, PlayerInfo[playerid][pMoney]);

   	SetPlayerArmour(playerid, PlayerHealth[playerid][pArmour]);

	if(PlayerVIP[playerid][pDonateRank] != 0)
		SetPlayerHealth(playerid, 99.0);
	else SetPlayerHealth(playerid, 50.0);

	// Streamer
	TogglePlayerAllDynamicCPs(playerid, true);
	foreach(new i : Houses)
	{
		TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], true);
	}

	new
		hour, minute;
	gettime(hour, minute);
	hour += 1;
	minute -= 1;
	SetPlayerTime(playerid,hour,minute);

	if( Bit1_Get( gr_FristSpawn, playerid ) )
	{
		CreateZonesTD(playerid);
		g_ZoneUpdateTick[playerid] = gettimestamp();

		SafeSpawning[ playerid ] = true;
		Bit1_Set( gr_FristSpawn, playerid, false );
	}
	SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);

    if(IsANewUser(playerid))
	{
        // Tutorial
        SendPlayerOnFirstTimeTutorial(playerid, 1);
        TogglePlayerSpectating(playerid, 1);
    }
	else
	{
        TogglePlayerSpectating(playerid, 0);
        Bit1_Set(gr_PlayerAlive, playerid, true);

		if(PlayerDeath[playerid][pKilled] == 1)
		{
			SetPlayerInterior(playerid, PlayerDeath[playerid][pDeathInt]);
			SetPlayerVirtualWorld(playerid, PlayerDeath[playerid][pDeathVW]);
			SetPlayerPos(playerid, PlayerDeath[playerid][pDeathX] , PlayerDeath[playerid][pDeathY] , PlayerDeath[playerid][pDeathZ] );
			Streamer_UpdateEx(playerid, PlayerDeath[playerid][pDeathX], PlayerDeath[playerid][pDeathY], PlayerDeath[playerid][pDeathZ], PlayerDeath[playerid][pDeathVW], PlayerDeath[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "** You are returned to position where you were wounded. **");
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Player_SetUsingMask(playerid, false);
			if( PlayerInfo[ playerid ][ pMaskID ])
			{
				if( PlayerVIP[playerid][pDonateRank] < 2)
					PlayerInfo[ playerid ][ pMaskID ] = 0;
			}

			TogglePlayerControllable(playerid, 0);
			CreateDeathInfos(playerid);
			SetPlayerHealth(playerid,10.0);
			PlayerWoundedAnim[playerid] = true;
			ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0,1);
			return 1;
		}
		else if(PlayerDeath[playerid][pKilled] == 2)
		{
			SetPlayerInterior(playerid, PlayerDeath[playerid][pDeathInt]);
			SetPlayerVirtualWorld(playerid, PlayerDeath[playerid][pDeathVW]);
			SetPlayerPos(playerid, PlayerDeath[playerid][pDeathX] , PlayerDeath[playerid][pDeathY] , PlayerDeath[playerid][pDeathZ] );
			Streamer_UpdateEx(playerid, PlayerDeath[playerid][pDeathX], PlayerDeath[playerid][pDeathY], PlayerDeath[playerid][pDeathZ], PlayerDeath[playerid][pDeathVW], PlayerDeath[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "You are in Death Mode. You have been returned to location of your death.**");
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Player_SetUsingMask(playerid, false);
			if( PlayerInfo[ playerid ][ pMaskID ])
			{
				if( PlayerVIP[playerid][pDonateRank] < 2)
					PlayerInfo[ playerid ][ pMaskID ] = 0;
			}

			TogglePlayerControllable(playerid, 0);
			CreateDeathInfos(playerid);
			SetPlayerHealth(playerid,10.0);
   			PlayerWoundedAnim[playerid] = true;
			ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0,1);
			return 1;
		}
		else if(PlayerDeath[playerid][pKilled] == 0)
		{
			if( PlayerJail[playerid][pJailed] > 0)
			{
				PutPlayerInJail(playerid, PlayerJail[playerid][pJailTime], PlayerJail[playerid][pJailed]);
				SetPlayerHealth(playerid, 100);
				return 1;
			}
			else 
			{
				if(SafeSpawned[playerid])
					AC_SetPlayerWeapons(playerid);
					
				switch( PlayerInfo[ playerid ][ pSpawnChange ] )
				{
					case 0: 
					{
						SetPlayerPosEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, false);
						SetPlayerFacingAngle(playerid, 90.00);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerHealth(playerid, 100);
					}
					case 1: 
					{
						if( PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID || PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID ) {
							new
								house;
							if(  PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID )
								house = PlayerKeys[playerid][pHouseKey];
							else if( PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID )
								house = PlayerKeys[playerid][pRentKey];

							// TODO: this logic is probably wrong, if setting player outside int
							// set their int and vw to 0
							SetPlayerInterior( playerid, HouseInfo[ house ][ hInt ] );
							SetPlayerVirtualWorld( playerid, HouseInfo[ house ][ hVirtualWorld ]);
							//Player_SetInHouse(playerid, house); - da probamo napravit hoce li portat pred kucu
							SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 0, 0, true);
							SetPlayerHealth(playerid, 100);
							return 1;
						}
					}
					case 2:
					{
						if(PlayerFaction[playerid][pMember] > 0)
						{
							switch(PlayerFaction[playerid][pMember])
							{
								case 1:
								{
									SetPlayerFacingAngle(playerid, 90.00);
								}
								case 2:
								{
									SetPlayerFacingAngle(playerid, 134.4510);
								}
								case 3:
								{
									SetPlayerFacingAngle(playerid, 270.0);
								}
								case 4:
								{
									SetPlayerFacingAngle(playerid, 293.4950);
								}
								case 5:
								{
									SetPlayerFacingAngle(playerid, 47.8250);
								}
							}
							SetPlayerInterior(playerid, 0);
							SetPlayerVirtualWorld(playerid, 0);
							SetPlayerHealth(playerid, 100);
						}
						else
						{
							SetPlayerInterior(playerid, 0);
							SetPlayerVirtualWorld(playerid, 0);
							SetPlayerHealth(playerid, 100);
						}
						return 1;
					}
					case 3:
					{
						if(PlayerKeys[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
						{
							//printf("%s{%d}(%d) >> COMPLEX >> %d", GetName(playerid, true), playerid, PlayerKeys[playerid][pComplexRoomKey]);
							new complex = PlayerKeys[playerid][pComplexRoomKey];
							SetPlayerPosEx(playerid, ComplexRoomInfo[ complex ][ cExitX ], ComplexRoomInfo[ complex ][ cExitY ], ComplexRoomInfo[ complex ][ cExitZ ], 0, 0, true);
							SetPlayerInterior( playerid, ComplexRoomInfo[ complex ][ cInt ] );
							SetPlayerVirtualWorld( playerid, ComplexRoomInfo[ complex ][ cViwo ]);
							Player_SetInApartmentRoom(playerid, complex);
							SetPlayerHealth(playerid, 100);
							return 1;
						}
					}
					case 4:
					{
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerHealth(playerid, 100);
					}
				}
				if( Bit1_Get( gr_PlayerInTrunk, playerid ) )
				{
					Bit1_Set( gr_PlayerInTrunk, playerid, false );
					VehicleTrunk[ playerid ] = INVALID_VEHICLE_ID;

					SetPlayerPosEx(playerid, PlayerTrunkPos[playerid][0], PlayerTrunkPos[playerid][1], PlayerTrunkPos[playerid][2], 0, 0, false);
					TogglePlayerControllable( playerid, 1 );
					SendClientMessage( playerid, COLOR_RED, "[ ! ]: You exited the trunk.");
					SetPlayerHealth(playerid, 100);
				}
			}
		}
	}
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if (weaponid == WEAPON_FIREEXTINGUISHER)
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

	if( !SafeSpawned[ KilledBy[playerid] ] ) 
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
	if(PlayerInfo[playerid][pMuted]) {
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't talk while being muted!");
		return 0;
	}
	if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) )
		return 0;

	if(!SafeSpawned[playerid] || OnSecurityBreach[playerid])
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR,"You can't use chat if you're not safely spawned!");
		return 0;
	}
	
	new tmpString[180];
	text[0] = toupper(text[0]);
	
	if(CallingId[playerid] == 999 && PlayerCallPlayer[playerid] == INVALID_PLAYER_ID) // Igrac nije u pozivu
	{
		
		if( IsPlayerInAnyVehicle(playerid) ) {
			format(tmpString, sizeof(tmpString), "%s says%s(vehicle): %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		else
		{
			format(tmpString, sizeof(tmpString), "%s says%s: %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		if(Bit1_Get( gr_animchat, playerid) && !PlayerAnim[playerid] )
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

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( PRESSED(KEY_SECONDARY_ATTACK) ) {
        if( Bit1_Get( gr_SmokingCiggy, playerid ) )
		{
	        SetPlayerSpecialAction(playerid,0);
	        Bit1_Set( gr_SmokingCiggy, playerid, false );

			new
				tmpString[ 50 ];
		  	format(tmpString, sizeof(tmpString), "* %s puts out a cigarette.",
				GetName(playerid, true)
			);
		  	ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		if(Player_HasDrink(playerid))
		{
	        SetPlayerSpecialAction(playerid,0);
	        Player_SetHasDrink(playerid, false);

			new
				tmpString[ 50 ];
		  	format(tmpString, sizeof(tmpString), "* %s puts his drink aside.",
				GetName(playerid, true)
			);
		  	ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	if(PlayerAppearance[playerid][pWalkStyle])
	{
		if(((newkeys & KEY_UP) && (newkeys & KEY_WALK)) || ((newkeys & KEY_DOWN) && (newkeys & KEY_WALK) || ((newkeys & KEY_WALK) && (newkeys & KEY_LEFT)) || ((newkeys & KEY_WALK) && (newkeys & KEY_RIGHT))))
  		{
   		    switch(PlayerAppearance[playerid][pWalkStyle])
			{
			    case 1:
			        ApplyAnimationEx(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1,1,0);
  			  	case 2:
  			  	    ApplyAnimationEx(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1,1,0);
			    case 3:
			        ApplyAnimationEx(playerid,"PED","WALK_civi",4.1,1,1,1,1,1,1,0);
			    case 4:
			        ApplyAnimationEx(playerid,"PED","WALK_armed",4.1,1,1,1,1,1,1,0);
			    case 5:
			        ApplyAnimationEx(playerid,"PED","WALK_csaw",4.1,1,1,1,1,1,1,0);
			    case 6:
			        ApplyAnimationEx(playerid,"PED","Walk_DoorPartial",4.1,1,1,1,1,1,1,0);
			    case 7:
			        ApplyAnimationEx(playerid,"PED","WALK_fat",4.1,1,1,1,1,1,1,0);
			    case 8:
			        ApplyAnimationEx(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1,1,0);
			    case 9:
			        ApplyAnimationEx(playerid,"PED","WALK_old",4.1,1,1,1,1,1,1,0);
			    case 10:
			        ApplyAnimationEx(playerid,"PED","WALK_player",4.1,1,1,1,1,1,1,0);
			    case 11:
			        ApplyAnimationEx(playerid,"PED","WALK_rocket",4.1,1,1,1,1,1,1,0);
			    case 12:
			        ApplyAnimationEx(playerid,"PED","WALK_shuffle",4.1,1,1,1,1,1,1,0);
			    case 13:
			        ApplyAnimationEx(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1,1,0);
			    case 14:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1,1,0);
			    case 15:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1,1,0);
			    case 16:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1,1,0);
			    case 17:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1,1,0);
			    case 18:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1,1,0);
			    case 19:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkshop",4.1,1,1,1,1,1,1,0);
			    case 20:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkfatold",4.1,1,1,1,1,1,1,0);
			    case 21:
			        ApplyAnimationEx(playerid,"MUSCULAR","Mscle_rckt_walkst",4.1,1,1,1,1,1,1,0);
			    case 22:
			        ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk",4.1,1,1,1,1,1,1,0);
			    case 23:
			        ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk_armed",4.1,1,1,1,1,1,1,0);
			    case 24:
			        ApplyAnimationEx(playerid,"MUSCULAR","Musclewalk_Csaw",4.1,1,1,1,1,1,1,0);
			    case 25:
			        ApplyAnimationEx(playerid,"PED","Player_Sneak_walkstart",4.1,1,1,1,1,1,1,0);
			    case 26:
			        ApplyAnimationEx(playerid,"POOL","POOL_Walk",4.1,1,1,1,1,1,1,0);
			    case 27:
			        ApplyAnimationEx(playerid,"ROCKET","walk_rocket",4.1,1,1,1,1,1,1,0);
			    case 28:
			        ApplyAnimationEx(playerid,"PED","WALK_shuffle",4.1,1,1,1,1,1,1,0);
                case 29:
                    ApplyAnimationEx(playerid,"WUZI","Wuzi_Walk",4.1,1,1,1,1,1,1,0);
			}
		}
		else if(RELEASED(KEY_WALK))
		{
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
			//ClearAnimations(playerid);
		}
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if( IsPlayerAlive(playerid) )
	{
		if(PlayerTick[playerid][ptMoney] < gettimestamp()) 
		{
			PlayerTick[playerid][ptMoney] = gettimestamp();
			AC_MoneyDetect(playerid);
			if( !PlayerSyncs[ playerid ] ) {
				PlayerSyncs[ playerid ] = true;
			}
			return 1;
		}
	}
	// TODO: remove this as it's wasting sync ticks, there's no need
	// to constantly update player int & vw. If they're hacking, just
	// punish them when they change ints/vw in a small amount of time

	// Int & ViWo Sync Check
	new
		complexid = Player_InApartmentComplex(playerid),
		roomid    = Player_InApartmentRoom(playerid),
		houseid   = Player_InHouse(playerid),
		bizzid    = Player_InBusiness(playerid),
		pickupid  = Player_InPickup(playerid);

	if(PlayerInfo[playerid][pAdmin] == 0)
	{
		if(complexid == INVALID_COMPLEX_ID && roomid == INVALID_COMPLEX_ID && houseid == INVALID_HOUSE_ID && bizzid == INVALID_BIZNIS_ID && pickupid == -1)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

// TODO: should be a part of mask module
public OnPlayerStreamIn(playerid, forplayerid)
{
    if (Player_UsingMask(forplayerid))
    {
        if (PlayerInfo[playerid][pAdmin] > 0 && Bit1_Get(a_AdminOnDuty, playerid))
        {
            ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
        }
        else
        {
            ShowPlayerNameTagForPlayer(playerid, forplayerid, false);
        }
    }
    else
    {
        ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
    }
    return 1;
}