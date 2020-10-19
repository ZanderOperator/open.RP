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
//
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
#define FIXES_ServerVarMsg 0

// GMT Zone
#define GMT_ZONE_DIFFERENCE						(7200)		// GMT + 2

// 0.3DL
#define NEGATIVE_MODEL_ID 						-40000 // Negativna vrijednost radi Custom Object Modela koji su u minusu

// Server Restart Configuration
//#define AUTO_RESTART_SEQ							// Uncomment for automatic restarts if you have restart API on your VPS/server
#define HTTP_RESTART_REQUEST 					"SERVER_RESTART_API_REQUEST_LINK"

// Fixes.inc
#define FIX_OnPlayerEnterVehicle 	0
#define FIX_OnPlayerEnterVehicle_2 	0
#define FIX_OnPlayerEnterVehicle_3 	0
#define FIX_OnDialogResponse		0
#define FIX_GetPlayerDialog			0
#define	MAX_IP_CONNECTS 			3
#define FIX_file_inc 				0
#define FIX_OnRconCommand			0
#define FIX_OnClientCheckResponse   0


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

// During sampctl p ensure check: CGEN_MEMORY(needs to be 90000) and MAX_COMMANDS(needs to be 1024) 
#define CGEN_MEMORY				(90000)		// Internal Define - code parser/generator memory
#define MAX_COMMANDS			(1024)		// Internal Define - y_commands

//#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>
#include <YSI_Data\y_iterate>
#include <YSI_Visual\y_commands>
#include <YSI_Game\y_vehicledata>
#include <YSI_Server\y_flooding>
#include <YSI_Coding\y_va>

// Other pre-includes
#include <OnPlayerSlowUpdate>
#include <animsfix> // legacy
#include <rBits> // legacy
#include <sscanf2>
#include <progress2>
#include <mapandreas>
#include <color_menu> // legacy

#include <vSync>
#include <fly> // legacy

// Whirlpool Hasher
native WP_Hash(buffer[], len, const str[]);

// MySQL
#include <a_mysql>
#include <YSI_Coding\y_inline>
#define mysql_tquery_inline_new(%0,%1,%2,%3) MySQL_TQueryInline(%0,%2,%1,%3)

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
#define SCRIPT_VERSION							"CoA RP v18.5.5."
#define DEV_NAME   								"Woo-Logan"

// -Macros
#define Public:%0(%1) \
		forward %0(%1); \
		public %0(%1)

#define IsANewUser(%0) \
	Bit1_Get(gr_NewUser,%0)

// KickEx
#define KickMessage(%0) \
	SetTimerEx("KickPlayer",55,false,"d",%0)
// BanEx
#define BanMessage(%0) \
	SetTimerEx("BanPlayer",55,false,"d",%0)

// Key Status
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// rBits
#define IsPlayerLogged(%0) 						Bit1_Get(gr_PlayerLoggedIn,%0)
#define IsPlayerLogging(%0) 					Bit1_Get(gr_PlayerLoggingIn,%0)
#define IsPlayerAlive(%0) 						Bit1_Get(gr_PlayerAlive, %0)
#define IsPlayerSafeBreaking(%0)				Bit1_Get( gr_SafeBreaking, playerid )
#define IsPlayerReconing(%0) 					Bit4_Get(gr_SpecateId, %0)

// Limits - https://www.open.mp/docs/scripting/resources/limits
#define EX_SPLITLENGTH 							(90) // Define when to split SendClientMessage into another line!
#define DIALOG_UPDATE_LIST_CHAR					(1280) // How many chars can fit into 1/4 pages of Update Info Dialog
#define MAX_DIALOG_TEXT                 		(756)
#define MAX_LOGIN_TRIES							(3)
#define MAX_PLAYER_MAIL							(32)
#define MAX_PLAYER_IP							(24)
#define MAX_ZONE_NAME                   		(28)
#define MAX_LOGIN_TIME							(60)
#define MAX_PLAYER_PASSWORD             		(129)
#define MAX_PLAYER_CIDR							(32)
#define MAX_SKILLS								(9)
#define MAX_WARNS								(3)
#define MAX_PICKUP								(500)
#define MAX_HOUSES                      		(1500)
#define	MAX_COMPLEX_ROOMS                       (50)
#define MAX_COMPLEX                             (10)
#define MAX_BIZZS         						(500)
#define MAX_SALE_PRODUCTS						(10)
#define MAX_PLANTS								(200)
#define MAX_CUSTOMIZED_OBJECTS          		(7)
#define MAX_SERVER_FLAMES						(200)
#define MAX_STARTED_FLAMES						(30)
#define MAX_FACTIONS							(21)
#define MAX_APARTMENTS							(500)
#define MAX_VEHICLE_TICKETS						(5)
#define MAX_GARAGES                 			(1500)
#define MAX_SERVER_SKINS						(800)
#define MAX_ILEGAL_GARAGES						(10)

// Max Inactivity Time & Minimum Month PayDays before Job/Property Removal
#define MAX_JOB_INACTIVITY_TIME					(864000) // 10 days
#define MAX_INACTIVITY_TIME						(2592000) // 30 days
#define MIN_MONTH_PAYDAYS						(10)

// Experience.pwn
#define MIN_GIVER_EXP_PAYDAYS					(2) 
#define MIN_RECIEVER_EXP_PAYDAYS				(1) 
#define LEVEL_UP_EXP							(25) 
#define MAX_FURSLOTS_EXP						(100) 
#define PREMIUM_BRONZE_EXP						(150) 
#define PREMIUM_SILVER_EXP						(200) 
#define PREMIUM_GOLD_EXP						(250)

// Furniture Texture Enum Slots 
#define MAX_TEXTURE_SLOTS						(5) //  1 Furniture Object - 5 Textures

// Furniture
#define FURNITURE_PREMIUM_OBJECTS				(700) // => CMD: /afurniture setpremium [player_id] [house_id]
#define FURNITURE_VIP_GOLD_OBJCTS				(500)
#define FURNITURE_VIP_SILVER_OBJCTS				(400)
#define FURNITURE_VIP_BRONZE_OBJCTS				(300)
#define FURNITURE_VIP_NONE						(200)
#define MAX_FURNITURE_SLOTS						(700)
#define MAX_FURNITURE_SLOT_FIELDS				(FURNITURE_PREMIUM_OBJECTS * MAX_TEXTURE_SLOTS)

// Bizz Furniture
#define BIZZ_FURNITURE_VIP_GOLD_OBJCTS			(500)
#define BIZZ_FURNITURE_VIP_SILVER_OBJCTS		(400)
#define BIZZ_FURNITURE_VIP_BRONZE_OBJCTS		(300)
#define BIZZ_FURNITURE_VIP_NONE					(200)
#define MAX_BIZNIS_FURNITURE_SLOTS  			(BIZZ_FURNITURE_VIP_GOLD_OBJCTS * MAX_TEXTURE_SLOTS)

// Trunk - Slot Limits
#define MAX_WEAPON_SLOTS						(10)
#define MAX_PACKAGE_VEHICLE						(15) 

// Weapon Packages
#define MAX_PLAYER_PACKAGES 					(10)
#define MAX_LISTED_WEAPONS						(11)	// maximalno oruzja za kupnju - /warehouse getgun.
#define MAX_PACKAGE_AMOUNT						(200)	// maximalno municije u jednom paketu.
#define MAX_PACKAGES							(10)	// maximalno narucenih paketa.
#define PACKAGE_COOLDOWN						(120)	// Svakih '?' koliko ce se moci narucit paket.
#define MINUTES_TILL_PACKAGE_ARRIVE			 	(10) // Koliko minuta treba da paket dodje u warehouse.
#define INVALID_PACKAGE_ID						(-1)	// Invalid ID
#define PACKAGE_PANCIR							(6969)	// Pancir Package (random id)

// Drugs
#define MAX_PLAYER_DRUGS						(5)
#define MAX_VEHICLE_DRUGS 						(10)
#define MAX_DRUG_AMOUNT 						(1000)
#define DRUG_DAYS_QUALITY						(86400)

#define DRUG_TYPE_NONE 							(0)
#define DRUG_TYPE_SMOKE 						(1)
#define DRUG_TYPE_SNORT 						(2)
#define DRUG_TYPE_INJECT 						(3)
#define DRUG_TYPE_TABLET						(4)

// Private Vehicles - CarOwnership.pwn
#define MAX_PLAYER_CARS							(10)

// Invalids
#define INVALID_BIZNIS_ID     					(999)
#define INVALID_HOUSE_ID						(9999)
#define INVALID_COMPLEX_ID                      (999)

// Streaming
#define PRISON_DRAW_DISTANCE            		(250.0)

// Newly Registered User
#define NEW_PLAYER_BANK 						(2500)
#define NEW_PLAYER_MONEY 						(500)

// Economy
#define INFLATION_INDEX							(3)

// Bank - Credits
#define BUY_TYPE_VEHICLE						(1)
#define BUY_TYPE_HOUSE							(2)
#define BUY_TYPE_BIZZ							(3)

// Spawn Coordinates
#define SPAWN_X									(1107.3832)
#define SPAWN_Y									(-1389.9144)
#define SPAWN_Z									(13.6500)

// Vehicle Tire Defines
#define F_L_TIRE 0
#define B_L_TIRE 1
#define F_R_TIRE 2
#define B_R_TIRE 3

// Anti-Spam
#define ANTI_SPAM_PRIVATE_MESSAGE 				(5)
#define ANTI_SPAM_BANK_CREDITPAY 				(5)
#define ANTI_SPAM_CRIB_WEAPON					(5)
#define ANTI_SPAM_CAR_WEAPON					(5)
#define ANTI_SPAM_STEAL_MONEY					(60)
#define ANTI_SPAM_BUY_TIME						(5)
#define ANTI_SPAM_DOOR_SHOUT					(3)

// IRS Tax Logs - CheckPlayerTransactions
#define LOG_TYPE_BIZSELL 						1
#define LOG_TYPE_HOUSESELL 						2
#define LOG_TYPE_VEHICLESELL					3
#define LOG_TYPE_COMPLEXSELL    				4
#define LOG_TYPE_GARAGESELL     				5

// Warehouse
#define MAX_WAREHOUSE_WEAPONS					(100)
#define ROBBERY_DURATION						(1500) // SEKUNDE
#define MIN_ROBBERS								(5) // Minimalni broj pljackasa(clanova suparnicke fakcije) koja je potrebna da se pokrene pljacka
#define MIN_DEFENDERS							(5) // Minimalni broj clanova fakcije koji trebaju biti online da bi se pokrenula pljacka

/*
	######## ##    ## ##     ## ##     ##  ######
	##       ###   ## ##     ## ###   ### ##    ##
	##       ####  ## ##     ## #### #### ##
	######   ## ## ## ##     ## ## ### ##  ######
	##       ##  #### ##     ## ##     ##       ##
	##       ##   ### ##     ## ##     ## ##    ##
	######## ##    ##  #######  ##     ##  ######
*/

// Main Database Connection Handler
new MySQL:g_SQL;

// Iterators
new Iterator:COVehicles<MAX_VEHICLES>,
	Iterator:Vehicles<MAX_VEHICLES>,
	Iterator:Pickups<MAX_PICKUP>,
	Iterator:Factions<MAX_FACTIONS>,
	Iterator:Houses<MAX_HOUSES>,
	Iterator:Bizzes<MAX_BIZZS>,
	Iterator:Complex<MAX_COMPLEX>,
	Iterator:ComplexRooms<MAX_COMPLEX_ROOMS>,
	Iterator:Garages<MAX_GARAGES>,
	Iterator:IllegalGarages<MAX_ILEGAL_GARAGES>,
	Iterator:COWObjects	[MAX_VEHICLES]<MAX_WEAPON_SLOTS>,
	Iterator:P_PACKAGES[MAX_PLAYERS]<MAX_PLAYER_PACKAGES>,
	Iterator:V_PACKAGES[MAX_VEHICLES]<MAX_PACKAGE_VEHICLE>;

new texture_buffer[10256];
new PlayerUpdatePage[MAX_PLAYERS] = 0;

enum E_PLAYER_DATA
{
	pSQLID,
	bool:pOnline,
	pRegistered,
	pTeamPIN[129],
	pForumName[24],
	pEmail[MAX_PLAYER_MAIL],
	pPassword[MAX_PLAYER_PASSWORD],
	pSAMPid[128],
	pSecQuestion,
	pSecQuestAnswer[31],
	pBanned,
	pSpawnChange,
	pWarns,
	pLevel,
	pLastLogin[24],
	pLastLoginTimestamp,
	pLastIP[MAX_PLAYER_IP],
	cIP[MAX_PLAYER_IP],
	pAdmin,
	pTempRank[2],
	pAdminHours,
	pHelper,
	pDonateRank,
	pDonateTime,
	pDonatorVehicle,
	pDonatorVehPerms,
	pConnectTime,
	pTempConnectTime,
	pMuted,
	pRespects,
	pTeam,
	pSex,
	pAge,
	pChangenames,
	pChangeTimes,
	pMoney,
	pBank,
	pSavingsCool,
	pSavingsTime,
	pSavingsType,
	pSavingsMoney,
	pJob,
	pContractTime,
	pFreeWorks,
	pFishWorks,
	pFishSQLID,
	pDutySystem,
	pPayDay,
	pPayDayMoney,
	pProfit,
	pPayDayHad,
	pPayDayDialog[2048],
	pPayDayDate[32],
	pBizzKey,
	pBusiness,
	pBusinessJob,
	pBusinessWorkTime,
	bool: BizCoOwner,
	pHouseKey,
	pComplexKey,
	pComplexRoomKey,
	pRentKey,
	pLeader,
	pMember,
	pRank,
	Float:pSHealth,
	Float:pHealth,
	Float:pArmour,
	pCrashId,
	pCrashVW,
	pCrashInt,
	Float:pCrashArmour,
	Float:pCrashHealth,
	Float:pCrashPos[3],
	pSkin,
	pMobileCost,
	pMobileNumber,
	pMobileModel,
	pCryptoNumber,
	pMarriedTo[MAX_PLAYER_NAME],
	pAccent[19],
	pKilled,
	pCarLic,
	pGunLic,
	pBoatLic,
	pFishLic,
	pFlyLic,
	Float:pMarker1[3],
	Float:pMarker2[3],
	Float:pMarker3[3],
	Float:pMarker4[3],
	Float:pMarker5[3],
	pJailed,
	pJailTime,
	pBailPrice,
	pJailJob,
	pOdradio,
	pInt,
	pViwo,
	pMaskID,
	pSpawnedCar,
	pVehKey,
	pCDPlayer,
	pGarageKey,
	pIllegalGarageKey,
	pSeeds,
	pToolkit,
	pMuscle,
	pGymTimes,
	pGymCounter,
	Float:pHunger,
	pArrested,
	pFightStyle,
	Float:pDeath[3],
	pDeathInt,
	pDeathVW,
	pClock,
	pCiggaretes,
	pLighter,
	pParts,
	pLawDuty,
	pPDDuty,
	pChar,
	pLijekTimer,
	pDrugUsed,
	pDrugSeconds,
	pDrugOrder,
	bool:pHc,
	bool:pMuAc,
	bool:pHCl,
	pMethAddict,
	pCrackAddict,
	pCokeAddict,
	pBoomBox,
	pBoomBoxType,
	pLook[120],
	pCallsign[60],
	pUnbanTime,
	pBanReason[32],
	pCasinoCool,
	pNews,
	pSentNews,
	pCanisterLiters,
	pCanisterType,
	pGrafID,
	pTagID,
	packageordered,
	ammoamountordered,
	bool:approved,
	hWhistle,
	pVoted,
	pPassport,
	hRope,
	pSkills[MAX_SKILLS],
	pPhoneBG,
	pPhoneMask,
	pAmmuTime,
	pPrimaryWeapon,
	pSecondaryWeapon,
	pWarehouseKey,
	bool:pMustRead,
	pLastUpdateVer[24],
	pRaceSQL,
	bool:pRaceCreator,
	pCurrentZone[MAX_ZONE_NAME],
	pWish,
	JackerCoolDown,
	taxiPoints,
	taxiVoted,
	pNicksToggled,
	FurnPremium,
	pHasRadio,
	pRadio[4],
	pRadioSlot[4],
	pMainSlot,
	pAddingRoadblock,
	pRoadblockObject,
	pRoadblockModel,
	//fisher
	pFishWeight,
	pFishingSkill,
 	//speedo
 	pSpeedo,
	//admin msgs
	pAdminMsg[2048],
	pAdminMsgBy[60],
	pAdmMsgConfirm,
	//pm
	pPMText[128],
	pPMing,
	pSkillTransporter
}
new PlayerInfo[ MAX_PLAYERS ][ E_PLAYER_DATA ];

enum E_CREDIT_INFO
{
	cCreditType,
	cRate,
	cAmount,
	cUnpaid,
	bool:cUsed,
	cTimestamp
}
new CreditInfo[ MAX_PLAYERS ][ E_CREDIT_INFO ];

enum E_GARAGE_DATA {
	gSQLID,
	gOwnerID,
	gAdress[16],
	gEnterPck,
	gPrice,
	gLocked,
	Float:gEnterX,
	Float:gEnterY,
	Float:gEnterZ,
	Float:gExitX,
	Float:gExitY,
	Float:gExitZ,
	gHouseID
}
new
	GarageInfo[ MAX_GARAGES ][ E_GARAGE_DATA ];

#define GetPlayerIP(%0) \
		PlayerInfo[%0][cIP]

#define ReturnPlayerIP(%0) \
		PlayerInfo[%0][cIP]

enum E_EXP_INFO
{
	bool:eGivenEXP,
	eAllPoints,
	ePoints,
	eLastPayDayStamp,
	eDayPayDays,
	eMonthPayDays
}
new ExpInfo[ MAX_PLAYERS ][ E_EXP_INFO ];

enum E_OLDPOS_INFO
{
	Float:oPosX,
	Float:oPosY,
	Float:oPosZ,
	oInt,
	oViwo
}
new PlayerPrevInfo[MAX_PLAYERS][E_OLDPOS_INFO];

enum E_HIDDEN_WEAPON
{
	pwSQLID,
	pwWeaponId,
	pwAmmo
}
new HiddenWeapon[MAX_PLAYERS][E_HIDDEN_WEAPON];

// Weapon Package Order List
enum E_WEAPON_PACKAGE {
	wep_ID,
	wep_Name[16],
	wep_Price
}

new
	show_WeaponList[MAX_LISTED_WEAPONS][E_WEAPON_PACKAGE] = {
	{24, 			"DEAGLE", 			70},
	{22,		    "COLT",		        45},
	{29,		    "MP5",		        85},
	{23,		    "SILENCED",		    60},
	{25,		    "SHOTGUN",		    90},
	{32,    		"TEC9",		        60},
	{28,		    "UZI",		        60},
	{30,		    "AK47",		        110},
	{31,		    "M4",		      	125},
	{34,	    	"SNIPER",         	900},
	{33,		    "RIFLE",		    130}
};

new PhoneStatus[ MAX_PLAYERS ];

enum E_HOUSES_INFO {
	hSQLID,
	Float:hEnterX,
	Float:hEnterY,
	Float:hEnterZ,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	hEnterCP,
	hOwnerID,
	hAdress[32],
	hValue,
	hInt,
	hVirtualWorld,
	hLock,
	hRent,
	hRentabil,
	hTakings,
	hLevel,
	hFreeze,
	h3dViwo,
	hSafeStatus,
	hSafePass,
	hSafe,
	hOrmar,
	hSkin1,
	hSkin2,
	hSkin3,
	hGroceries,
	hDoorLevel,
	hAlarm,
	hLockLevel,
	bool:hDoorCrashed,
	hMoneySafe,
	hStorageAlarm,
	hRadio,
	hTV,
	hMicrowave,
	hExists[ MAX_FURNITURE_SLOTS ],
	bool:hFurLoaded,
	hFurCounter,
	hFurSlots,
	hFurSQL[ MAX_FURNITURE_SLOTS ],
	hFurModelid[ MAX_FURNITURE_SLOTS ],
	hFurObjectid[ MAX_FURNITURE_SLOTS ],
	hFurDoor[ MAX_FURNITURE_SLOTS ],
	Float:hFurDoorZ[ MAX_FURNITURE_SLOTS ],
	hFurDoorLckd[ MAX_FURNITURE_SLOTS ],
	Float:hFurPosX[ MAX_FURNITURE_SLOTS ],
	Float:hFurPosY[ MAX_FURNITURE_SLOTS ],
	Float:hFurPosZ[ MAX_FURNITURE_SLOTS ],
	Float:hFurRotX[ MAX_FURNITURE_SLOTS ],
	Float:hFurRotY[ MAX_FURNITURE_SLOTS ],
	Float:hFurRotZ[ MAX_FURNITURE_SLOTS ],
	hFurTxtId[ MAX_FURNITURE_SLOT_FIELDS ],
	hFurColId[ MAX_FURNITURE_SLOT_FIELDS ]
}
new
	HouseInfo[MAX_HOUSES][E_HOUSES_INFO];

#define hFurTxtId][%1][%2] hFurTxtId][((%1)*MAX_TEXTURE_SLOTS)+(%2)] // Hacking the compiler to have HouseInfo[ houseid ][ hFurTxtId ][ 0 ][ 0 ]
#define hFurColId][%1][%2] hFurColId][((%1)*MAX_TEXTURE_SLOTS)+(%2)] // // Hacking the compiler to have HouseInfo[ houseid ][ hFurColId ][ 0 ][ 0 ]

enum E_COMPLEX_INFO {
	cSQLID,
	cPickup,
	cOwnerID,
	cName[25],
	cTill,
	cPrice,
	cLevel,
	cViwo,
	cInt,
	Float:cEnterX,
	Float:cEnterY,
	Float:cEnterZ,
	Float:cExitX,
	Float:cExitY,
	Float:cExitZ
}
new
	ComplexInfo[MAX_COMPLEX][E_COMPLEX_INFO];

enum E_COMPLEX_ROOM_INFO {
	cSQLID,
	cRPickup,
	cComplexID,
	cActive,
	Float:cEnterX,
	Float:cEnterY,
	Float:cEnterZ,
	Float:cExitX,
	Float:cExitY,
	Float:cExitZ,
	cOwnerID,
	cAdress[25],
	cValue,
	cInt,
	cIntExit,
	cViwo,
	cVWExit,
	cLock,
	cLevel,
	cFreeze,
	cGunSafe[4],
	cGunAmmo[4],
	cSafeStatus,
	cSafePass,
	cSafe,
	cOrmar,
	cSkin1,
	cSkin2,
	cSkin3,
	cQuality,
	cGroceries,
	cDoorLevel,
	cAlarm,
	cLockLevel,
	cPhone,
	cPhoneNumber,
	bool:cDoorCrashed,
	cMoneySafe,
	cRadio,
	cTV,
	cMicrowave
}
new
	ComplexRoomInfo[MAX_COMPLEX_ROOMS][E_COMPLEX_ROOM_INFO];

enum E_BIZNIS_INFO
{
	bSQLID,
	bType,
	bOwnerID,
	bco_OwnerID,
	bMessage[16],
	bCanEnter,
	Float:bEntranceX,
	Float:bEntranceY,
	Float:bEntranceZ,
	Float:bExitX,
	Float:bExitY,
	Float:bExitZ,
	bLevelNeeded,
	bBuyPrice,
    bTill,
	bLocked,
	bInterior,
	bMaxProducts,
	bPriceProd,
	bVirtualWorld,
	bEntranceCost,
	bDestroyed,
	bVipType,
	Float:bVipEnter[3],
	Float:bVipExit[3],
	bVipCP,
	bMusicOn,
	bMusicURL[96],
	bMusic,
	bActiveParty,
	bEnterPICK,
	bFurSlots,
	bFurSQL[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	bFurModelid[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	bFurObjectid[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	bFurDoor[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurDoorZ[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	bFurDoorLckd[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurPosX[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurPosY[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurPosZ[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurRotX[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurRotY[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	Float:bFurRotZ[ BIZZ_FURNITURE_VIP_GOLD_OBJCTS ],
	bFurTxtId[ MAX_BIZNIS_FURNITURE_SLOTS ],
	bFurColId[ MAX_BIZNIS_FURNITURE_SLOTS ],
	bool:bFurLoaded,
    bGasPrice
}
new BizzInfo[MAX_BIZZS][E_BIZNIS_INFO];

#define bFurTxtId][%1][%2] bFurTxtId][((%1)*5)+(%2)]
#define bFurColId][%1][%2] bFurColId][((%1)*5)+(%2)]

enum E_SERVER_SKINS
{
	sSkinID,
	sPrice
}
new ServerSkins[E_SERVER_SKINS][MAX_SERVER_SKINS];

enum E_PLAYER_TICKS {
	ptReport,
	ptVehicleCrash,
	ptHealth,
	ptWeapon,
	ptMoney,
	ptArmour,
	ptVehHealth,
	ptKill,
	ptFire,
	ptHelperHelp,
	ptAirBrake,
	ptFlyHack,
	ptVehiclePort
}
new PlayerTick[MAX_PLAYERS][E_PLAYER_TICKS];

enum E_VICTIM_DATA
{
	pVictimLocation[100],
}
new PlayerInjured[MAX_PLAYERS][E_VICTIM_DATA];

#define MAX_PHONE_LINES								10
enum E_PHONE_NEWS_DATA 
{
	npPlayerID,
	npNumber
}
new NewsPhone[ MAX_PHONE_LINES ][ E_PHONE_NEWS_DATA ];

enum E_CRIME_DATA
{
	pBplayer[32],
	pAccusing[32],
	pAccusedof[32],
	pVictim[32],
	pLocation[32]
};
new PlayerCrime[MAX_PLAYERS][E_CRIME_DATA];

enum E_SAFE_EXIT {
	Float:giX,
	Float:giY,
	Float:giZ,
	Float:giRZ
}

new PlayerSafeExit[ MAX_PLAYERS ][E_SAFE_EXIT];

enum E_PLAYER_PACKAGES 
{
	p_SQLID,
	packExists,
	p_weapon,
	p_amount
}
new PlayerPackage[MAX_PLAYERS][E_PLAYER_PACKAGES][MAX_PLAYER_PACKAGES];

enum E_DRUG_INFO
{
	dName[10],
	dEffect,
	dPayDayT,
	dUseTime,
	dPricePG
}

new const 
	drugs[][E_DRUG_INFO] = 
{
	{"Prazno", 		DRUG_TYPE_NONE,   0, 0, 0},
	{"Marihuana", 	DRUG_TYPE_SMOKE,  8, 25, 70},
	{"Kokain", 		DRUG_TYPE_SNORT,  12, 30, 110},
	{"Heroin", 		DRUG_TYPE_INJECT, 15, 35, 90},
	{"Xanax",		DRUG_TYPE_TABLET, 15, 40, 145},
	{"LSD", 		DRUG_TYPE_TABLET, 15, 50, 160},
	{"MDMA",		DRUG_TYPE_TABLET, 15, 75, 175}
};

enum E_DRUG_DATA
{
	dSQLID[5],
	dCode[5],
	Float:dAmount[5],
	Float:dEffect[5],
	dTimeStamp[5]
}
new PlayerDrugs[MAX_PLAYERS][E_DRUG_DATA];

enum PLAYER_OBJECT_DATA
{
	poSQLID,
	poModelid,
	poBoneId,
	bool:poPlaced,
	Float:poPosX,
	Float:poPosY,
	Float:poPosZ,
	Float:poRotX,
	Float:poRotY,
	Float:poRotZ,
	Float:poScaleX,
	Float:poScaleY,
	Float:poScaleZ,
	poColor1,
	poColor2
}
new PlayerObject[MAX_PLAYERS][MAX_CUSTOMIZED_OBJECTS][PLAYER_OBJECT_DATA];

new vTireHP[MAX_VEHICLES][4];

enum E_VEHICLE_DATA
{
	vSQLID,
	vModel,
	vSpawned,
	bool:vServerTeleport,
	vOwner[MAX_PLAYER_NAME],
	vOwnerID,
	vNumberPlate[8],
	vColor1,
	vColor2,
	Float:vParkX,
	Float:vParkY,
	Float:vParkZ,
	Float:vAngle,
	vEngineType,
	vEngineLife,
	vEngineScrewed,
	vEngineRunning,
	vCanStart,
	vParts,
	vTimesDestroy,
	Float:vHeat,
	vOverHeated,
	vBatteryType,
	Float:vBatteryLife,
	vFuel,
	vInsurance,
	vPanels,
	vDoors,
	vTires,
	vLights,
	vBonnets,
	Float:vTravel,
	vTrunk,
	vWeaponObjectID[MAX_WEAPON_SLOTS],
	vWeaponSQLID[MAX_WEAPON_SLOTS],
	vWeaponId[MAX_WEAPON_SLOTS],
	vWeaponAmmo[MAX_WEAPON_SLOTS],
	packSQLID[MAX_PACKAGE_VEHICLE],
	packWepID[MAX_PACKAGE_VEHICLE],
	packAmmo[MAX_PACKAGE_VEHICLE],
	vLock,
	vLocked,
	Float:vDoorHealth,
	Float:vTrunkHealth,
	vAlarm,
	vImmob,
	vAudio,
	vDestroys,
	vUsage,
	vType,
	vFaction,
	vJob,
	vInt,
	vViwo,
	Float:vHealth,
	bool:vDestroyed,
	bool:vDeleted,
	vRespawn,
	bool:vGPS,
	bool:vTuned,
	vSpoiler,
	vHood,
	vRoof,
	vSkirt,
	vLamps,
	vNitro,
	vExhaust,
	vWheels,
	vStereo,
	vHydraulics,
	vFrontBumper,
	vRearBumper,
	vRightVent,
	vLeftVent,
	vSirenon,
	vPaintJob,
	vImpounded,
	vText[23],
	Text3D:vFactionText,
 	vFactionTextOn,
	vVehicleAdText[20],
	Text3D:vVehicleAdId,
	vTicketsSQLID[MAX_VEHICLE_TICKETS],
	vTickets[MAX_VEHICLE_TICKETS],
	vTicketShown[MAX_VEHICLE_TICKETS],
	vTicketStamp[MAX_VEHICLE_TICKETS],
	Float:vOffsetx[MAX_WEAPON_SLOTS],
	Float:vOffsety[MAX_WEAPON_SLOTS],
	Float:vOffsetz[MAX_WEAPON_SLOTS],
	Float:vOffsetxR[MAX_WEAPON_SLOTS],
	Float:vOffsetyR[MAX_WEAPON_SLOTS],
	Float:vOffsetzR[MAX_WEAPON_SLOTS],
	vSpareKey1,
	vSpareKey2,
	vTireArmor,
	vBodyArmor,
	vNOSCap
}
new VehicleInfo[MAX_VEHICLES][E_VEHICLE_DATA];

enum E_VEHICLE_PREV_DATA
{
	Float:vPosX,
	Float:vPosY,
	Float:vPosZ,
	Float:vRotZ,
	Float:vPosDiff,
	Float:vHealth,
	vPanels,
	vDoors,
	vTires,
	vLights
}
new VehiclePrevInfo[MAX_VEHICLES][E_VEHICLE_PREV_DATA];

enum E_ANTI_SPAM_DATA
{
	asPrivateMsg,
	asCreditPay,
	asCarTrunk,
	asHouseWeapon,
	stHouseMoney,
	asBuying,
	asDoorShout
}
new
	AntiSpamInfo[MAX_PLAYERS][E_ANTI_SPAM_DATA];

enum E_FACTION_DATA
{
    fID,
    fUsed,
    fName[24],
    fType,
    fRankName1[24],
    fRankName2[24],
    fRankName3[24],
    fRankName4[24],
    fRankName5[24],
    fRankName6[24],
    fRankName7[24],
    fRankName8[24],
    fRankName9[24],
    fRankName10[24],
	fRankName11[24],
	fRankName12[24],
	fRankName13[24],
	fRankName14[24],
	fRankName15[24],
    fRanks,
	fFactionBank,
	rSiren,
	rCarGun,
	rCarSign,
	rABuyGun,
	rBuyGun,
	rASwat,
	rGovRepair,
	rAGovRepair,
	rUnFree,
	rClrTrunk,
	rLstnNumber,
	rLstnSMS,
	rRace,
	rUndercover,
	rAUndercover
}
new
	FactionInfo[MAX_FACTIONS][E_FACTION_DATA];

enum E_CITY_DATA
{
	cBudget,
	cIllegalBudget,
	cTax
}
new
	CityInfo[ E_CITY_DATA ];

enum 
{
	DIALOG_LOGIN			= 10001,
	DIALOG_REGISTER,
	DIALOG_REG_AGREE,
	DIALOG_REG_PASS,
	DIALOG_REG_MAIL,
	DIALOG_REG_SEX,
	DIALOG_REG_AGE,
	DIALOG_FIRST_TIME_TUT,
	DIALOG_STATS,
	DIALOG_CARUPGRADE,
	DIALOG_SEC_MAIN,
	DIALOG_SEC_SECQUEST,
	DIALOG_SEC_MAIL,
	DIALOG_SEC_PASS,
	DIALOG_SEC_NEWS,
	DIALOG_SEC_INPUTQ,
	DIALOG_SEC_QUESTANSWER,
	DIALOG_SEC_SAMPID,
	DIALOG_NETWORK_STATS,
	DIALOG_CREDIT,
	DIALOG_VEH_PAYMENT,
	DIALOG_HOUSE_PAYMENT,
	DIALOG_BIZZ_PAYMENT,
	DIALOG_PORT,
	DIALOG_RULES,
	DIALOG_IJOBS,
	DIALOG_JOBS,
	DIALOG_PD_EQUIP,
	DIALOG_PD_EQUIP_DUTY,
	DIALOG_PD_SKIN,
	DIALOG_SD_SKIN,
	DIALOG_PD_BUYGUN,
	DIALOG_SANG_BUYGUN,
	DIALOG_SANG_SKIN,
	DIALOG_SANG_EQUIP,
	DIALOG_SANG_EQUIP_DUTY,
	DIALOG_GPS,
	DIALOG_ADMIN_AC,
	DIALOG_ALERT,
	//Trailers
	DIALOG_ATRAILER,
	DIALOG_ADRIAPOSAO,
	//Report system
	DIALOG_CONFIRM_SYS,
	DIALOG_REPORTS,

	//adminmsg
	DIALOG_ADMIN_MSG,
	
	//CreateObjects,
	DIALOG_CREATE_COBJECT,
	DIALOG_DELETE_COBJECT,
	DIALOG_ADMIN_DEL_COBJECT,
	DIALOG_EDIT_COBJECT,

	//Pm
	DIALOG_ADMINPM,

	//
    DIALOG_ACTORHELP,
    DIALOG_GUNRACK,

	//COMPLEX
	DIALOG_COMPLEX_MAIN,
	DIALOG_COMPLEX_BANK,
	DIALOG_COMPLEX_CHANGENAME,
	DIALOG_COMPLEX_SELL,
	DIALOG_COMPLEX_SELL_PRICE,
	DIALOG_COMPLEX_SELL_2,
	DIALOG_COMPLEX_ROOMS,
	DIALOG_COMPLEX_ROOM_INFO,
	DIALOG_COMPLEX_ROOM_INFO_2,
	DIALOG_COMPLEX_ROOM_PRICE,

	// DOGS
	DIALOG_DOG_BUY,
	DIALOG_DOG_DELETE,

	DIALOG_SAN_CAMLIST,
	DIALOG_SAN_CAMLIST2,
	DIALOG_SAN_CAMERAMAN,
	DIALOG_SAN_DCAMERAMAN,
	DIALOG_SAN_DIRECTOR,
	DIALOG_SAN_PSTREAM,
	DIALOG_SAN_BSTREAM,
	DIALOG_SAN_VIEWERS,

	//GOV
	DIALOG_GOV_EQUIP,
	DIALOG_GOV_EQUIP_DUTY,
	DIALOG_GOV_SKIN,

	// Racing
	DIALOG_RACE_MAIN,
	DIALOG_RACE_DCP,
	DIALOG_RACE_DCPS,
	DIALOG_RACE_CALL,

    // Poker.pwn
	DIALOG_CGAMESADMINMENU,
	DIALOG_CGAMESSELECTPOKER,
	DIALOG_CGAMESSETUPPOKER,
	DIALOG_CGAMESSETUPPGAME,
	DIALOG_CGAMESSETUPPGAME2,
	DIALOG_CGAMESSETUPPGAME3,
	DIALOG_CGAMESSETUPPGAME4,
	DIALOG_CGAMESSETUPPGAME5,
	DIALOG_CGAMESSETUPPGAME6,
	DIALOG_CGAMESSETUPPGAME7,
	DIALOG_CGAMESBUYINPOKER,
	DIALOG_CGAMESCALLPOKER,
	DIALOG_CGAMESRAISEPOKER,

	// Ammunation
	DIALOG_AMMUNATION_MENU,
	DIALOG_AMMUNATION_BUY,

	// Skins Model Dialog
	MODEL_LIST_SKINS,

	// Furniture
	DIALOG_BLANK_INTS_LIST,
	DIALOG_FURNITURE_BINT_SURE,
	DIALOG_FURNITURE_MENU,
	DIALOG_FURNITURE_BUY,
	DIALOG_FURNITURE_OBJCS,
	DIALOG_FURNITURE_OBJS_BUY,
	DIALOG_FURNITURE_EDIT,
	DIALOG_FURNITURE_EDIT_LIST,
	DIALOG_FURNITURE_TXTS,
	DIALOG_FURNITURE_TXTS_SURE,
	DIALOG_FURNITURE_TXTS_SRCH_1,
	DIALOG_FURNITURE_TXTS_SRCH_2,
	DIALOG_FURNITURE_TXTS_SRCH_3,
	DIALOG_FURNITURE_TXTS_SLOT,
	DIALOG_FURNITURE_DELETE,
	DIALOG_FURNITURE_COL_LIST,
	DIALOG_FURNITURE_COL_SLOT,
	DIALOG_FURNITURE_COL_SURE,
	DIALOG_FURNITURE_SLOT_DELETE,
	DIALOG_FURNITURE_SLOT_SURE,
	
	// Taxi
	DIALOG_TAXI_RATING,

	// Biznis Furniture
	DIALOG_BIZZ_BLANK_INTS_LIST,
	DIALOG_BIZZ_FURN_BINT_SURE,
	DIALOG_BIZZ_FURN_MENU,
	DIALOG_BIZZ_FURN_BUY,
	DIALOG_BIZZ_FURN_OBJCS,
	DIALOG_BIZZ_FURN_OBJS_BUY,
	DIALOG_BIZZ_FURN_EDIT,
	DIALOG_BIZZ_FURN_EDIT_LIST,
	DIALOG_BIZZ_FURN_TXTS,
	DIALOG_BIZZ_FURN_TXTS_SURE,
	DIALOG_BIZZ_FURN_TXTS_SRCH_1,
	DIALOG_BIZZ_FURN_TXTS_SRCH_2,
	DIALOG_BIZZ_FURN_TXTS_SRCH_3,
	DIALOG_BIZZ_FURN_TXTS_SLOT,
	DIALOG_BIZZ_FURN_DELETE,
	DIALOG_BIZZ_FURN_COL_LIST,
	DIALOG_BIZZ_FURN_COL_SLOT,
	DIALOG_BIZZ_FURN_COL_SURE,
	DIALOG_BIZZ_FURN_SLOT_DELETE,
	DIALOG_BIZZ_FURN_SLOT_SURE,
	DIALOG_BIZZ_FURN_NAME,

	// Exteriors
	DIALOG_EXTERIOR_MENU,
	DIALOG_EXTERIOR_BUY_TYPE,
	DIALOG_EXTERIOR_BUY,
	DIALOG_EXTERIOR_SURE,
	DIALOG_EXTERIOR_EDIT,
	DIALOG_EXTERIOR_DELETE,

	// Grafiti
	DIALOG_GRAF_COLOR,
	DIALOG_GRAF_FONT,
	DIALOG_GRAF_SIZE,
	DIALOG_GRAF_TEXT,

	// Hair
	DIALOG_HAIR_BUY,
	DIALOG_HAIR_COLOR,
	DIALOG_BOMB,

	// Kasino
	DIALOG_CASINO_RULET,
	DIALOG_CASINO_RNUMBERS,
	DIALOG_CASINO_RCOLOR,
	DIALOG_CASINO_R12,
	DIALOG_CASINO_RBET,
	DIALOG_CASINO_SLOTS,
	DIALOG_CASINO_SLOTS_ACC,
	DIALOG_CASINO_PARNEPAR,
	DIALOG_CASINO_STUPAC,

	// Elections
	DIALOG_FOR_ELECTIONS,
	DIALOG_ELECTIONS_VOTE,

	// Music
	DIALOG_MUSIC_BUY,
	DIALOG_MUSIC_MAIN,
	DIALOG_MUSIC_PLAY,

	// Talkie Walkie
	DIALOG_TALKIE_WALKIE,

	// Weapons
	DIALOG_WEAPONS_MELEE,

	//Weapon Package
	DIALOG_PACKAGE_AMOUNT,
	DIALOG_PACKAGE_ARMOR,
	DIALOG_PACKAGE_ORDER,
	DIALOG_PACKAGE_CONFIRM,
	DIALOG_TAKE_PACKAGE,

	// House
	DIALOG_HOUSE_MAIN,
	DIALOG_HOUSE_SEF,
	DIALOG_HOUSE_UPGRADES,
	DIALOG_HOUSE_DOORS,
	DIALOG_HOUSE_RENT,
	DIALOG_HOUSE_RENTERS,
	DIALOG_HOUSE_ORMAR,
	DIALOG_HOUSE_STUFF,
	DIALOG_HOUSE_SELL,
	DIALOG_HOUSE_GUNSEF,
	DIALOG_HOUSE_BANK,
	DIALOG_HOUSE_WITHDRAW,
	DIALOG_HOUSE_UNLOCK,
	DIALOG_HOUSE_TAKEGUN,
	DIALOG_HOUSE_CHANGEPASS,
	DIALOG_HOUSE_RENTPRICE,
	DIALOG_HOUSE_EVICT,
	DIALOG_HOUSE_FRIDGE,
	DIALOG_HOUSE_REMOVESKIN,
	DIALOG_HOUSE_SKINSURE,
	DIALOG_HOUSE_SKINCHOOSE,
	DIALOG_VIWO_PICK,
	DIALOG_SELL_HOUSE_PRICE,
	DIALOG_SELL_HOUSE_PLAYER,
	DIALOG_SELL_HOUSE_PLAYER_2,
	DIALOG_HOUSE_STORAGE,
	DIALOG_HOUSE_PUT,
	DIALOG_WSTORAGE_PUT,
	DIALOG_HOUSE_TAKE,
	DIALOG_WSTORAGE_TAKE,
	DIALOG_HSTORAGE_BUYRACK,
	DIALOG_HSTORAGE_INFO,
	DIALOG_HOUSE_DSTORAGE,
	DIALOG_HSTORAGE_EDIT,

	// Objects
	DIALOG_PREVIEW_CLOTHING_BUY,
	DIALOG_OBJECTS_BUY,
	DIALOG_OBJECT_BONE_SELECTION,
	DIALOG_NEWCLOTHING,
	DIALOG_CLOTHING_BUY,
	DIALOG_DELETECLOTHING,

	// CarOwnership
	DIALOG_VEH_GET,
	DIALOG_VEH_UPGRADE,
	DIALOG_VEH_INSURANCE,
	DIALOG_VEH_BATTERY,
	DIALOG_VEH_LOCK,
	DIALOG_VEH_IMMOB,
	DIALOG_VEH_ALARM,
	DIALOG_VEH_PUTGUN,
	DIALOG_VEH_PUTGUN1,
	DIALOG_VEH_TAKEGUN,
	DIALOG_VEH_TAKEGUN1,
	DIALOG_VEH_DELETE,
	DIALOG_VEH_COLORS,
	DIALOG_VEH_SELLING,
	DIALOG_VEH_JUNK_SELL,
	DIALOG_VEH_CHECKTRUNK,

	// Bizzes
	DIALOG_BIZNIS_MAIN,
	DIALOG_BIZNIS_ENTRANCE,
	DIALOG_BIZNIS_PRODUCTS,
	DIALOG_BIZNIS_NAME,
	DIALOG_BIZNIS_ARTICLELIST,
	DIALOG_BIZNIS_ARTICLEPRICE,
	DIALOG_BIZNIS_ARTICLEINV,
	DIALOG_BIZNIS_ARTICLESETPRICE,
	DIALOG_BIZNIS_ARTICLEREM,
	DIALOG_BIZNIS_BUYING,
	DIALOG_BIZNIS_GASLIST,
	DIALOG_BIZNIS_GASPRICE,
	DIALOG_BIZNIS_PRODUCTPRICE,
	DIALOG_BIZNIS_MUSIC,
	DIALOG_BIZNIS_CRYPTOORMOBILE,
	DIALOG_BIZNIS_MOBILEBUY,
	DIALOG_BIZNIS_CRYPTOBUY,
	DIALOG_BIZNIS_ARTICLEREFF,
	DIALOG_CHICKENMENU,
	DIALOG_PIZZAMENU,
	DIALOG_BURGERMENU,
	DIALOG_RESTORANMENU,
	DIALOG_DONUTMENU,
	DIALOG_JAILMENU,
	DIALOG_SKINSURE,
	DIALOG_LIST_SKINS,
	DIALOG_MALL_BUY,
	DIALOG_FAKE_BUY,
	DIALOG_SELL_BIZ,
	DIALOG_SELL_BIZ_2,
	DIALOG_SELL_TO_PLAYER,
	DIALOG_SELL_BIZ_PRICE,
	DIALOG_SELL_TO_STATE,
	DIALOG_NEWBIZNIS_NAME,
	DIALOG_BIZNIS_TYPE,
	DIALOG_REMOVE_BIZNIS,

	// Mobile
	DIALOG_MOBILE_MAIN,
	DIALOG_MOBILE_CONTACTS,
	DIALOG_MOBILE_ADDSLOT,
	DIALOG_MOBILE_ADDNUM,
	DIALOG_MOBILE_REMSLOT,
	DIALOG_MOBILE_EDITSLOT,
	DIALOG_MOBILE_EDITNUM,
	DIALOG_MOBILE_EDITNAME,
	DIALOG_MOBILE_CONTACTS_MAIN,
	DIALOG_MOBILE_CONTACTS_CALL,
	DIALOG_MOBILE_ADDNAME,
	DIALOG_MOBILE_CALL_CONTACT,
	DIALOG_MOBILE_SMS_CONTACT,
	DIALOG_MOBILE_SMS_TEXT,
	DIALOG_MOBILE_BACKGROUND,
	DIALOG_MOBILE_MASKS,

	// Factions
	DIALOG_FACTION_HOME,
	DIALOG_FACTION_TYPE,
	DIALOG_FACTION_NAME,
	DIALOG_FACTION_SNAME,
	DIALOG_FACTION_RANKNAME,
	DIALOG_FACTION_RANKNAMEI,
	DIALOG_FACTION_RANKS,
	DIALOG_FACTION_FINISH,
	DIALOG_FACTION_INFO,

	DIALOG_AFACTIONN,
	DIALOG_AFACTIONC,
	DIALOG_FDELETE,
	DIALOG_FLIST,
	DIALOG_RLIST,

	DIALOG_SWATS,
	DIALOG_PENALCODE,
	DIALOG_CODES,

	//FD
	DIALOG_FD_EQUIP,
	DIALOG_FD_EQUIP_DUTY,
	DIALOG_FD_EQUIP_SKIN,
	DIALOG_FD_EQUIP_MD,
	DIALOG_FD_EQUIP_FD,
	DIALOG_FD_EQUIP_RADNICI,
	DIALOG_FD_EQUIP_MISC,

	// Pickups
	DIALOG_DYN_PEDISC,
	DIALOG_DYN_PDISC,

	DIALOG_RENT_V,

	// Prison
	DIALOG_CELLS,
	DIALOG_CELL,
	DIALOG_CLOSECELL,
	DIALOG_PRISONGATE,

	// License
	DIALOG_DRIVING_QUEST1,
	DIALOG_DRIVING_QUEST2,
	DIALOG_DRIVING_QUEST3,
	DIALOG_DRIVING_QUEST4,

	// APB
	DIALOG_APB_CHECK,
	DIALOG_APB_OPIS,
	DIALOG_APB_TYPE,
	DIALOG_APB_NAME,

	// AR
	DIALOG_AR_NAME,
	DIALOG_AR_OPIS,

	// MDC
	DIALOG_MDC_MAIN,
	DIALOG_MDC_PLAYER,
	DIALOG_MDC_VEHICLE,
	DIALOG_MDC_PHONE,
	DIALOG_MDC_PHONE_INFO,

	DIALOG_MDC_RECORD,
	DIALOG_MDC_CRECORD,
	DIALOG_MDC_DRECORD_ID,
	DIALOG_MDC_DRECORD,

	DIALOG_MDC_TICKET,
	DIALOG_MDC_CTICKET,
	DIALOG_MDC_DTICKET_ID,
	DIALOG_MDC_DTICKET,
	
	DIALOG_ROADBLOCKS,
	DIALOG_ROADBLOCK_LIST,
	DIALOG_ACTIVE_ROADBLOCKS,
	DIALOG_DUTYR_CNF,
	DIALOG_MDC_HLOCATOR,

	DIALOG_MDC_CALLSIGNS,
	DIALOG_MDC_PRISONERS,
	// City
	DIALOG_CITY_MAIN,
	DIALOG_CITY_BUDGET,
	DIALOG_CITY_BUDGET_TAKE,
	DIALOG_CITY_BUDGET_PUT,
	DIALOG_CITY_BUDGET_STAT,
	DIALOG_CITY_TAX,
	DIALOG_CITY_FACTIONBANK,
	DIALOG_CITY_BIZNIS,
	DIALOG_CITY_BIZDEPOSIT,
	DIALOG_CITY_BIZWITHDRAW,
	DIALOG_FACTIONBANK_OPTIONS,
	DIALOG_FACTIONBANK_DEPOSIT,
	DIALOG_FACTIONBANK_WITHDRAW,

	// Tuning
	DIALOG_TUNE_SLOTS,
	DIALOG_TUNE_LIST,
	DIALOG_TUNE_NOS,
	DIALOG_TUNE_SLOT_REPLACE,
	DIALOG_TUNE_WHEELS,
	DIALOG_TUNE_PAINT,
	DIALOG_TUNE_BUYP,
	DIALOG_TUNE_BUYW,
	DIALOG_TUNE_DELETE,
	DIALOG_TUNE_PAINT_DEL,

	// Upgrade(wheels)
	DIALOG_UPGRADE_WHEELS,

	// Lopov
	DIALOG_ROB_POCKET,
	DIALOG_ROB_SELL,

	// Jacker
	DIALOG_JACKER_PICK,
	DIALOG_JACKER_SURE_1,
	DIALOG_JACKER_SURE_2,
	DIALOG_JACKER_BRIBE,

	// Teretana
	DIALOG_GYM_TRAIN,

	// Gun diler
	DIALOG_AFTERORDERW,
	dialog_int,
	dialog_sure,
	dialog_change,
	dialog_delete,

	// Rest
	DIALOG_MINER,
	DIALOG_MEAL_BUY,
	DIALOG_GARAGE_SELL,

	// Ads
	DIALOG_ADS_MENU,
	DIALOG_ADS_CREATE_STYLE,
	DIALOG_ADS_CREATE_TYPE,
	DIALOG_ADS_CREATE_TIMES,
	DIALOG_ADS_CREATE_PRICE,
	DIALOG_ADS_CREATE_BUY,
	DIALOG_ADS_CREATE_SELL,
	DIALOG_ADS_CREATE_CMRC,
	DIALOG_ADS_FINISH,
	DIALOG_ADS_WHOLE,

	//Admin
	DIALOG_JAIL_GETHERE,

	// Trucker
	DIALOG_PRODUCTS_BUY,
	DIALOG_PRODUCTS_DUCAN,
	DIALOG_PRODUCTS_BAR,
	DIALOG_TRUCKER_SELECT_BIZ,
	DIALOG_TRUCKER_SELECT_JOB,
	DIALOG_TRUCKER_SELECT_INFO,
	DIALOG_TRUCKER_OILINFO,
	DIALOG_TRUCKER_HEAVYINFO,
	DIALOG_TRUCKER_FREEZERINFO,
	DIALOG_TRUCKER_FRAGILEINFO,
	DIALOG_TRUCKER_CONSTINFO,

	// Jobhelp
	DIALOG_JOBHELP,
	DIALOG_FARMERHELP,

	// Porezna(proracun.pwn)
	DIALOG_PLAYER_TRANSACTIONS,
	DIALOG_LIST_TRANSACTIONS,
	DIALOG_TRANSACTIONS_INPUT,
	DIALOG_GOVMDC,

	// Orgs.pwn
	DIALOG_FACTION_PICK,
	DIALOG_FACTION_DEPOSIT,
	DIALOG_FACTION_WITHDRAW,

	// WeaponEdit.pwn
	DIALOG_EDIT_BONE,

	// Warehouse.pwn
	WAREHOUSE_PUT_MENU,
	WAREHOUSE_TAKE_MENU,
	DIALOG_TAKE_WEAPON_LIST,
	DIALOG_WAREHOUSE_INFO,
	WAREHOUSE_MONEY_PUT,
	WAREHOUSE_MONEY_TAKE,
	
	// Drug.pwn
	DIALOG_DRUG_ORDER,
	DRUG_ORDER_PACKAGE,
	DRUG_ORDER_AMOUNT,
	DRUG_ORDER_CONFIRM,
	
	// Licenses
	DIALOG_LICENSE,
	DIALOG_LICENSE_CONFIRM,
	DIALOG_DRIVINGTEST,

	//Help.pwn
	DIALOG_HELP,
	DIALOG_HELPER_HELP,
	DIALOG_ADMHELP,
	DIALOG_ANIMS,
	DIALOG_HELPACC,
	DIALOG_BANK,
	DIALOG_HOBI,
	DIALOG_KASINO,

	//RPQuiz.pwn
	DIALOG_TEST_QUESTION,
	DIALOG_TEST_ANSWER,

	// BasketballNew.pwn - UPDATE
	DIALOG_BASKET_CHOOSE,
	DIALOG_BASKET_TEAM,

	// Death.pwn
	PLAYER_DAMAGES_DIALOG,

	// Spraynpay.pwn
	DIALOG_SPRAY_CONFIRM,

	// RobStorage.pwn
	DIALOG_ROB_STORAGE,
	DIALOG_ROB_DSTORAGE,
	DIALOG_PICKUP_ITEM,

	// Savings
	DIALOG_ACCEPT_SAVINGS,

    // Experience.pwn
	DIALOG_EXPERIENCE_BUY,
	DIALOG_EXP_CHOOSE,
	DIALOG_MOST_TEMPEXP,
	DIALOG_MOST_OVERALLEXP,
	
	// Account Inactivity,
	DIALOG_INACTIVITY_LIST,
	DIALOG_INACTIVITY_CHECK,

	// GranTurismo.pwn - Racing Leauge
	DIALOG_RACE_PICK,
	DIALOG_RACE_EDIT,
	DIALOG_RACE_CREATE,
	DIALOG_RACE_CATEGORY,
	DIALOG_CATEGORY_DESC,
	DIALOG_RACE_TYPE,
	DIALOG_CIRCUIT_NUMBERS,
	DIALOG_RACE_CONFIRM,
	DIALOG_RACE_DATE,

	// UPDATES.pwn
	DIALOG_UPDATE_LIST
};

enum {
	BIZZ_TYPE_OTHER   	= 0,
	BIZZ_TYPE_BAR,
	BIZZ_TYPE_STRIP,
	BIZZ_TYPE_RESTORAN,
	BIZZ_TYPE_BURGER,
	BIZZ_TYPE_PIZZA,
	BIZZ_TYPE_CLUCKIN,
	BIZZ_TYPE_DONUT,
	BIZZ_TYPE_DUCAN,
	BIZZ_TYPE_SEXSHOP,
	BIZZ_TYPE_BINCO,
	BIZZ_TYPE_ZIP,
	BIZZ_TYPE_PROLAPS,
	BIZZ_TYPE_SUBURBAN,
	BIZZ_TYPE_BYCITY,
	BIZZ_TYPE_RENTVEH,
	BIZZ_TYPE_CASINO,
	BIZZ_TYPE_DRUGSTORE,
	BIZZ_TYPE_GASSTATION
}
#define MAX_BIZZ_TYPES					(19)

enum {
	VEHICLE_USAGE_NORMAL 	= 1,
	VEHICLE_USAGE_PRIVATE	= 2,
	VEHICLE_USAGE_FACTION	= 3,
	VEHICLE_USAGE_JOB		= 4,
	VEHICLE_USAGE_RENT		= 5,
	VEHICLE_USAGE_PREMIUM	= 6,
	VEHICLE_USAGE_LICENSE	= 7,
	VEHICLE_USAGE_NEWBIES	= 8,
	VEHICLE_USAGE_EVENT		= 9
}

enum {
	VEHICLE_TYPE_CAR		= 10,
	VEHICLE_TYPE_MOTOR		= 11,
	VEHICLE_TYPE_BIKE		= 12,
	VEHICLE_TYPE_BOAT		= 13,
	VEHICLE_TYPE_PLANE		= 14,
	VEHICLE_TYPE_TRAIN		= 15
}

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
	PlayerTaskTStamp[MAX_PLAYERS],
	TaserAnimTimer[MAX_PLAYERS],
	bool:OnSecurityBreach[MAX_PLAYERS] = false,
	bool:FDArrived[MAX_PLAYERS],
	TaserTimer[MAX_PLAYERS],
	Float:PlayerTrunkPos[MAX_PLAYERS][3],
	GlobalSellingPlayerID[ MAX_PLAYERS ] = { 0, ... },
	GlobalSellingPrice[ MAX_PLAYERS ] = { 0, ... },
	PlayerExName[ MAX_PLAYERS ][ MAX_PLAYER_NAME ],
	VehicleEquipment[ MAX_PLAYERS ],
	VehicleTrunk[ MAX_PLAYERS ],
	WalkStyle[MAX_PLAYERS],
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
	bool:crash_checker[MAX_PLAYERS] = false,
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
	Bit1: 	gr_PlayerIsSWAT			<MAX_PLAYERS> =  Bit1: false,
	Bit1:	gr_CreateObject			<MAX_PLAYERS> =	 Bit1: false,
	Bit1:	gr_OnEvent				<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerDownloading	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_BeanBagShotgun		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerExiting		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerEntering		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_ApprovedUndercover	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_FristSpawn			<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_SafeBreaking			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerHouseAlarmOff	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_OnLive				<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggedIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerLoggingIn 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_NewUser				<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_VehicleWindows 		<MAX_VEHICLES> = Bit1: false,
	Bit1:	gr_VehicleAttachedBomb	<MAX_VEHICLES> = Bit1: false,
	Bit1: 	gr_PlayerTimeOut		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_ForbiddenPM			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_BlockedPM			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerAlive			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PDOnDuty				<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_Dice					<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_FakeGunLic			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MaskUse				<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MobileSpeaker		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_Taser				<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerCuffed 		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_SmokingCiggy			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_GovRepair			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_WeaponAllowed		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_HasRubber			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerSendKill		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTazed			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_AcceptSwat			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_DoorsLocked			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_FactionChatTog		<MAX_PLAYERS>  = Bit1: true,
	Bit1:	gr_PlayerRadio			<MAX_PLAYERS>  = Bit1: true,
	Bit1:	gr_TrunkOffer			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerInTrunk		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTraceSomeone	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTraceSMS		<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerOnTutorial		<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_animchat             <MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_Blockedreport		<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_Tied                 <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_Blind                <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_BlindFold            <MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerTrunkEdit		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_PlayerUsingSpeedo	<MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_ImpoundApproval      <MAX_PLAYERS>  = Bit1: false,
	Bit1:   gr_HaveOffer        	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_UsingMechanic 		<MAX_PLAYERS>  = Bit1: false,
	Bit1: 	gr_IsWorkingJob			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_MallPreviewActive	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	r_ColorSelect			<MAX_PLAYERS>  = Bit1: false,
	Bit1:	gr_PlayerInTuningMode	<MAX_PLAYERS>  = Bit1: false,
	Bit1:	PlayingBBall			<MAX_PLAYERS>  = Bit1: false,
	//Bit1: 	gr_DrivingStarted		<MAX_PLAYERS>  = Bit1: false,
	Bit2:	gr_BikeBunnyHop			<MAX_PLAYERS>  = Bit2: 0,
	Bit2:	gr_TipEdita				<MAX_PLAYERS>  = Bit2: 0,
	Bit2:	gr_PlayerJumps			<MAX_PLAYERS>  = Bit2: 0,
	Bit4:	gr_WeaponTrunkEditSlot	<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_Backup				<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_MusicCircle			<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	r_ColorSlotId			<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_AttachmentIndexSel	<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_TipUsluge			<MAX_PLAYERS>  = Bit4: 0,
	Bit4: 	gr_SpecateId 			<MAX_PLAYERS>  = Bit4: 0,
	Bit4:	gr_PDLockedSeat			<MAX_PLAYERS>  = Bit4: 0,
	Bit8:	gr_MechanicSecs			<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_HandleItem			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_ObjectPrice			<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_MallType				<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_PhoneLine			<MAX_PLAYERS>  = Bit8: 15,
	Bit8: 	gr_Groceries			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_LoginInputs			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_RegisterInputs		<MAX_PLAYERS>  = Bit8: 0,
	Bit8:   gr_GovMDC               <MAX_PLAYERS>  = Bit8: INVALID_PLAYER_ID,
	Bit8: 	gr_Food					<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_Drink				<MAX_PLAYERS>  = Bit8: 0,
	Bit8:	gr_ShakeStyle			<MAX_PLAYERS>  = Bit8: 0,
	Bit8: 	gr_PoliceWeapon 		<MAX_PLAYERS>  = Bit8: 0,
	Bit16:	gr_IdMehanicara			<MAX_PLAYERS>  = Bit16: INVALID_PLAYER_ID,
	Bit16: 	gr_PoliceAmmo			<MAX_PLAYERS>  = Bit16: 0,
	Bit16: 	gr_PlayerInfrontHouse	<MAX_PLAYERS>  = Bit16: INVALID_HOUSE_ID,
	Bit16:	gr_ShakeOffer			<MAX_PLAYERS>  = Bit16: 0,
	Bit16:	gr_LastVehicle			<MAX_PLAYERS>  = Bit16: 0,
	Bit16: 	gr_LastPMId				<MAX_PLAYERS>  = Bit16: 0,
	Bit16: 	gr_PlayerInHouse		<MAX_PLAYERS>  = Bit16: 9999,
    Bit16: 	gr_PlayerInGarage		<MAX_PLAYERS>  = Bit16: 9999,
    Bit16: 	gr_PlayerInRoom			<MAX_PLAYERS>  = Bit16: 999,
	Bit16:	gr_PDLockedVeh			<MAX_PLAYERS>  = Bit16: INVALID_VEHICLE_ID,
	Bit16:	gr_PlayerAmbulanceId	<MAX_PLAYERS>  = Bit16: INVALID_VEHICLE_ID,
	Bit16:	gr_PlayerInBiznis		<MAX_PLAYERS>  = Bit16: INVALID_BIZNIS_ID,
	Bit16:	gr_PlayerInComplex		<MAX_PLAYERS>  = Bit16: INVALID_COMPLEX_ID,
	Bit16:	gr_PlayerInPickup		<MAX_PLAYERS>  = Bit16: -1,
	Bit16:	gr_PlayerTracing		<MAX_PLAYERS>  = Bit16: 9999;

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

	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "INSERT INTO `server_deaths` (`killer_id`, `death_id`, `weaponid`, `date`) VALUES ('%d','%d','%d','%d')",
		PlayerInfo[ KilledBy[playerid] ][ pSQLID ],
		PlayerInfo[ playerid ][ pSQLID ],
		KilledReason[playerid],
		gettimestamp()
	);
	mysql_tquery(g_SQL, tmpQuery);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/kills.txt", "(%s) %s{%d}(%s) has killed %s{%d}(%s) with %s(%d).",
		ReturnDate(),
		GetName(killerid, false),
		PlayerInfo[killerid][pSQLID],
		GetPlayerIP(killerid),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		GetPlayerIP(playerid),
		GetWeaponNameEx(KilledReason[playerid]),
		KilledReason[playerid]
	);
	#endif
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	PlayerInfo[ playerid ][ pDeath ][ 0 ] 	= X;
	PlayerInfo[ playerid ][ pDeath ][ 1 ] 	= Y;
	PlayerInfo[ playerid ][ pDeath ][ 2 ] 	= Z;
	PlayerInfo[ playerid ][ pDeathInt ] 	= GetPlayerInterior( playerid );
	PlayerInfo[ playerid ][ pDeathVW ] 		= GetPlayerVirtualWorld( playerid );

	// FIRST DEATH
	if( DeathData[ playerid ][ ddOverall ] > 0)
	{
		DeathTime[playerid] = gettimestamp() + 60;
		//DropPlayerMoney(playerid); // Gubitak novca

		//DropPlayerWeapons(playerid, X, Y);
		//DropPlayerDrugs(playerid, X, Y, true);

		new
			deathQuery[256];
		format(deathQuery, 256, "INSERT INTO `player_deaths`(`player_id`, `pos_x`, `pos_y`, `pos_z`, `interior`, `viwo`, `time`) VALUES ('%d','%f','%f','%f','%d','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerInfo[playerid][pDeath][0],
			PlayerInfo[playerid][pDeath][1],
			PlayerInfo[playerid][pDeath][2],
			PlayerInfo[playerid][pDeathInt],
			PlayerInfo[playerid][pDeathVW],
			gettimestamp()
		);
		mysql_tquery(g_SQL, deathQuery, "", "");
	}
	AC_ResetPlayerWeapons(playerid);

	HiddenWeapon[playerid][pwSQLID] = -1;
	HiddenWeapon[playerid][pwWeaponId] = 0;
	HiddenWeapon[playerid][pwAmmo] = 0;

	// Mobile Dissapear
	PhoneAction(playerid, PHONE_HIDE);
	PhoneStatus[playerid] = PHONE_HIDE;
	CancelSelectTextDraw(playerid);

	if(Bit1_Get( gr_MaskUse, playerid ) && IsValidDynamic3DTextLabel(NameText[playerid]))
	{
		DestroyDynamic3DTextLabel(NameText[playerid]);
		NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
		Bit1_Set(gr_MaskUse, playerid, false);
	}
	KilledBy[playerid] = INVALID_PLAYER_ID;
	WoundedBy[playerid] = INVALID_PLAYER_ID;
	KilledReason[playerid] = -1;

	PlayerInfo[playerid][pKilled] = 0;

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
	Iter_Clear(COVehicles);
	Iter_Clear(Vehicles);
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
	PlayerInfo[playerid][pFishingSkill] = 0;
    GotRod[playerid] = 0;
	//
	PhoneStatus[playerid] = 0;
	//PD Callsign
	format(PlayerInfo[playerid][pCallsign], 60, "");
	//rBits
	Bit1_Set( gr_PlayerDownloading		, playerid, false );
	Bit1_Set( gr_BeanBagShotgun			, playerid, false );
	Bit1_Set( gr_PlayerExiting			, playerid, false );
	Bit1_Set( gr_PlayerEntering			, playerid, false );
	Bit1_Set( gr_ApprovedUndercover		, playerid, false );
	Bit1_Set( gr_PlayerHouseAlarmOff	, playerid, false );
	Bit1_Set( gr_FristSpawn				, playerid, false );
	Bit1_Set( gr_OnLive					, playerid, false );
	Bit1_Set( gr_PlayerLoggingIn 		, playerid, false );
	Bit1_Set( gr_PlayerLoggedIn 		, playerid, false );
	Bit1_Set( gr_NewUser				, playerid, false );
	Bit1_Set( gr_PlayerTimeOut			, playerid, false );
	Bit1_Set( gr_ForbiddenPM			, playerid, false );
	Bit1_Set( gr_BlockedPM				, playerid, false );
	Bit1_Set( gr_OnEvent				, playerid, false );
	Bit1_Set( gr_CreateObject			, playerid, false );
	Bit1_Set( gr_Blockedreport			, playerid, false );
	Bit1_Set( gr_PlayerAlive			, playerid, true  );
	Bit1_Set( gr_PDOnDuty				, playerid, false );
	Bit1_Set( gr_FakeGunLic				, playerid, false );
	Bit1_Set( gr_Dice					, playerid, false );
	Bit1_Set( gr_MaskUse				, playerid, false );
	Bit1_Set( gr_MobileSpeaker			, playerid, false );
	Bit1_Set( gr_Taser					, playerid, false );
	Bit1_Set( gr_PlayerCuffed 			, playerid, false );
	Bit1_Set( gr_SmokingCiggy			, playerid, false );
	Bit1_Set( gr_GovRepair				, playerid, false );
	Bit1_Set( gr_WeaponAllowed			, playerid, false );
	Bit1_Set( gr_HasRubber				, playerid, false );
	Bit1_Set( gr_PlayerSendKill			, playerid, false );
	Bit1_Set( gr_PlayerTazed			, playerid, false );
	Bit1_Set( gr_AcceptSwat				, playerid, false );
	Bit1_Set( gr_DoorsLocked			, playerid, false );
	Bit1_Set( gr_animchat               , playerid, false );
	Bit1_Set( gr_FactionChatTog			, playerid, true );
	Bit1_Set( gr_PlayerRadio			, playerid, true );
	Bit1_Set( gr_TrunkOffer				, playerid, false );
	Bit1_Set( gr_PlayerTrunkEdit        , playerid, false );
	Bit1_Set( gr_PlayerInTrunk			, playerid, false );
	Bit1_Set( gr_PlayerTraceSomeone		, playerid, false );
	Bit1_Set( gr_PlayerTraceSMS			, playerid, false );
	Bit1_Set( gr_Blind					, playerid, false );
	Bit1_Set( gr_BlindFold				, playerid, false );
	Bit1_Set( gr_Tied					, playerid, false );
	Bit1_Set( gr_ImpoundApproval		, playerid, false );
	Bit1_Set( gr_IsWorkingJob			, playerid, false );
	
	Bit2_Set( gr_BikeBunnyHop			, playerid, 0 );
	Bit2_Set( gr_PlayerJumps			, playerid, 0 );
	Bit4_Set( gr_WeaponTrunkEditSlot	, playerid, 0 );
	Bit4_Set( gr_Backup					, playerid, 0 );
	Bit4_Set( gr_MusicCircle			, playerid, 0 );
	Bit4_Set( gr_SpecateId				, playerid, 0 );
	Bit8_Set( gr_GovMDC                 , playerid, INVALID_PLAYER_ID );
	Bit8_Set( gr_LoginInputs			, playerid, 0 );
	Bit8_Set( gr_RegisterInputs			, playerid, 0 );
	Bit8_Set( gr_Groceries				, playerid, 0 );
	Bit8_Set( gr_Food					, playerid, 0 );
	Bit8_Set( gr_Drink					, playerid, 0 );
	Bit8_Set( gr_ShakeStyle				, playerid, 0 );
	Bit8_Set( gr_PoliceWeapon 			, playerid, 0 );
	Bit16_Set( gr_PoliceAmmo			, playerid, 0 );
	Bit16_Set( gr_ShakeOffer			, playerid, 999 );
	Bit16_Set( gr_LastVehicle			, playerid, 0 );
	Bit16_Set( gr_LastPMId				, playerid, 999 );
	Bit16_Set( gr_PlayerInBiznis		, playerid, 999 );
	Bit16_Set( gr_PlayerInRoom          , playerid, 999 );
	Bit16_Set( gr_PlayerInComplex       , playerid, INVALID_COMPLEX_ID );
	Bit16_Set( gr_PlayerInPickup        , playerid, -1 );
	Bit16_Set( gr_PlayerInHouse			, playerid, INVALID_HOUSE_ID );
	Bit16_Set( gr_PlayerInGarage		, playerid, INVALID_HOUSE_ID );
	Bit16_Set( gr_PlayerInfrontHouse	, playerid, INVALID_HOUSE_ID );
	Bit16_Set( gr_PlayerAmbulanceId		, playerid, INVALID_VEHICLE_ID );
	Bit16_Set( gr_PlayerTracing			, playerid, 9999 );
	blockedNews[playerid] = false;
	// Mobile
	ResetMobileVariables(playerid);

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

	Bit1_Set( gr_PlayerUsingGov			, playerid, false );
	Bit1_Set( gr_PlayerTakingSelfie		, playerid, false );
	Bit8_Set( gr_PhoneLine				, playerid, 15 );
	Bit8_Set( gr_RingingTime			, playerid, 0 );

	// Admin
	Bit1_Set(gr_SaveArmour, 	playerid, false);
	Bit1_Set(gr_MaskUse, 		playerid, false);

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
	PlayerTick[playerid][ptVehicleCrash]	= gettimestamp();
	PlayerTick[playerid][ptHealth]			= gettimestamp();
	PlayerTick[playerid][ptWeapon]			= gettimestamp();
	PlayerTick[playerid][ptMoney]			= gettimestamp();
	PlayerTick[playerid][ptArmour]			= gettimestamp();
	PlayerTick[playerid][ptVehHealth]		= gettimestamp();
	PlayerTick[playerid][ptHelperHelp]		= gettimestamp();
	PlayerTick[playerid][ptAirBrake] 		= gettimestamp();
	PlayerTick[playerid][ptKill]			= 0;
	PlayerTick[playerid][ptVehiclePort]		= 0;
	PlayerTaskTStamp[playerid] 				= 0;

	//Enums
	PlayerInfo[playerid][pDrugUsed] = 0;
	PlayerInfo[playerid][pDrugSeconds] = 0; 
	PlayerInfo[playerid][pDrugOrder] = 0;
	
	PlayerInfo[playerid][pForumName] 		= EOS;
	PlayerInfo[playerid][pLastLogin] 		= EOS;
	PlayerInfo[playerid][pLastIP]			= EOS;
	PlayerInfo[playerid][pSAMPid] 			= EOS;
	PlayerInfo[playerid][pEmail][0] 		= EOS;
	PlayerInfo[playerid][pPayDayDialog] 	= EOS;
	PlayerInfo[playerid][pPayDayDate] 		= EOS;	//String

	PlayerInfo[playerid][pSecQuestAnswer][0]= EOS;
	PlayerInfo[playerid][pAccent][0]		= EOS;
	PlayerInfo[playerid][pLook][0]			= EOS;
	PlayerInfo[playerid][pBanReason][0]		= EOS;
	PlayerInfo[playerid][pCurrentZone] 		= EOS;
	PlayerInfo[playerid][pLastUpdateVer] 	= EOS;

	PlayerInfo[playerid][pSQLID] 			= 0; 	//Integer
	PlayerInfo[playerid][pOnline]           = false;
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
	PlayerInfo[playerid][pDonateRank]		= 0;
	PlayerInfo[playerid][pConnectTime]		= 0;
	PlayerInfo[playerid][pMuted]			= 0;
	PlayerInfo[playerid][pRespects]			= 0;
	PlayerInfo[playerid][pSex]				= 0;
	PlayerInfo[playerid][pAge]				= 0;
	PlayerInfo[playerid][pChangenames]		= 0;
	PlayerInfo[playerid][pChangeTimes]		= 0;
	PlayerInfo[playerid][pMoney]			= 0;
	PlayerInfo[playerid][pBank]				= 0;
	PlayerInfo[playerid][pSavingsCool]		= 0;
	PlayerInfo[playerid][pSavingsTime]		= 0;
	PlayerInfo[playerid][pSavingsType]		= 0;
	PlayerInfo[playerid][pSavingsMoney]		= 0;
	PlayerInfo[playerid][pContractTime]		= 0;
	PlayerInfo[playerid][pTempConnectTime]	= 0;
	PlayerInfo[playerid][pFreeWorks]		= 0;
	PlayerInfo[playerid][pFishWorks]		= 0;
	PlayerInfo[playerid][pFishSQLID] 		= -1;
	PlayerInfo[playerid][pLawDuty]          = 0;
	PlayerInfo[playerid][pDutySystem]		= 0;
	PlayerInfo[playerid][pPayDay]			= 0;
	PlayerInfo[playerid][pPayDayMoney]		= 0;
	PlayerInfo[playerid][pProfit]			= 0;
	PlayerInfo[playerid][pPayDayHad]		= 0;
	PlayerInfo[playerid][pHouseKey]			= INVALID_HOUSE_ID;
	PlayerInfo[playerid][pRentKey]			= INVALID_HOUSE_ID;
	PlayerInfo[playerid][pLeader]			= 0;
	PlayerInfo[playerid][pMember]			= 0;
	PlayerInfo[playerid][pRank]				= 0;
	PlayerInfo[playerid][pCrashId]			= -1;
	PlayerInfo[playerid][pCrashVW]			= -1;
	PlayerInfo[playerid][pCrashInt]			= -1;
	PlayerInfo[playerid][pSkin]				= 0;
	PlayerInfo[playerid][pCryptoNumber]		= 0;
	PlayerInfo[playerid][pMobileNumber]		= 0;
	PlayerInfo[playerid][pMobileModel]		= 0;
	PlayerInfo[playerid][pMobileCost] 		= 0;
	PlayerInfo[playerid][pKilled]			= 0;
	PlayerInfo[playerid][pDeathInt] 		= 0;
	PlayerInfo[playerid][pDeathVW] 			= 0;
	PlayerInfo[playerid][pJob]				= 0;
	PlayerInfo[playerid][pCarLic]			= 0;
	PlayerInfo[playerid][pGunLic]			= 0;
	PlayerInfo[playerid][pBoatLic]			= 0;
	PlayerInfo[playerid][pFishLic]			= 0;
	PlayerInfo[playerid][pFlyLic]			= 0;
	PlayerInfo[playerid][pJailed]			= 0;
	PlayerInfo[playerid][pJailTime]			= 0;
	PlayerInfo[playerid][pJailJob] 			= 0;
	PlayerInfo[playerid][pOdradio]          = 0;
	PlayerInfo[playerid][pBailPrice]		= 0;
	PlayerInfo[playerid][pInt]				= 0;
	PlayerInfo[playerid][pViwo]				= 0;
	PlayerInfo[playerid][pMaskID]			= -1;
	PlayerInfo[playerid][pSpawnedCar]		= -1;
	PlayerInfo[playerid][pBizzKey]			= INVALID_BIZNIS_ID;
	PlayerInfo[playerid][pComplexKey]		= INVALID_COMPLEX_ID;
	PlayerInfo[playerid][pComplexRoomKey]	= INVALID_COMPLEX_ID;
	PlayerInfo[playerid][pGarageKey]		= -1;
	PlayerInfo[playerid][pIllegalGarageKey]	= -1;
	PlayerInfo[playerid][pSeeds]			= 0;
	PlayerInfo[playerid][pToolkit]			= 0;
	PlayerInfo[playerid][pMuscle]			= 0;
	PlayerInfo[playerid][pGymCounter]		= 0;
	PlayerInfo[playerid][pGymTimes]			= 0;
	PlayerInfo[playerid][pParts]			= 0;
	PlayerInfo[playerid][pArrested]			= 0;
	PlayerInfo[playerid][pChar]				= 0;
	PlayerInfo[playerid][pBoomBox] 			= 0;
	PlayerInfo[playerid][pBoomBoxType] 		= 0;
	PlayerInfo[playerid][pHasRadio] 		= 0;
	PlayerInfo[playerid][pMainSlot] 		= 0;
	
	ResetCreditVars(playerid);

	PlayerInfo[playerid][pRadio][1] 		= 0;
	PlayerInfo[playerid][pRadio][2] 		= 0;
	PlayerInfo[playerid][pRadio][3] 		= 0;

	PlayerInfo[playerid][pRadioSlot][1] 	= 0;
	PlayerInfo[playerid][pRadioSlot][2] 	= 0;
	PlayerInfo[playerid][pRadioSlot][3] 	= 0;

	PlayerInfo[playerid][pUnbanTime] 		= 0;
	PlayerInfo[playerid][pCasinoCool]		= 0;
	PlayerInfo[playerid][pFightStyle]		= FIGHT_STYLE_NORMAL;
	PlayerInfo[playerid][pNews]				= 0;
	PlayerInfo[playerid][pSentNews]			= 0;
	PlayerInfo[playerid][pCanisterLiters] 	= 0;
	PlayerInfo[playerid][pCanisterType] 	= -1;
	PlayerInfo[playerid][pGrafID]			= -1;
	PlayerInfo[playerid][pTagID]			= -1;
	PlayerInfo[playerid][hRope] 			= 0;
	PlayerInfo[playerid][pAmmuTime]			= 0;
	PlayerInfo[playerid][pDonatorVehicle] 	= 0;
	PlayerInfo[playerid][pDonatorVehPerms] 	= 0;
	PlayerInfo[playerid][pPrimaryWeapon] 	= 0;
	PlayerInfo[playerid][pSecondaryWeapon] 	= 0;
	PlayerInfo[playerid][pWarehouseKey] 	= -1;
	PlayerInfo[playerid][pRaceSQL]			= -1;
	PlayerInfo[playerid][pMustRead]			= false;
	PlayerInfo[playerid][pRaceCreator]		= false;
	
	//Floats
	PlayerInfo[playerid][pHealth]			= 0.0;
	PlayerInfo[playerid][pArmour]			= 0.0;
	PlayerInfo[playerid][pCrashPos][0]		= 0.0;
	PlayerInfo[playerid][pCrashPos][1]		= 0.0;
	PlayerInfo[playerid][pCrashPos][2]		= 0.0;
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
	PlayerInfo[playerid][pHunger]			= 0.0;
	PlayerTrunkPos[playerid][0] 			= 0.0;
	PlayerTrunkPos[playerid][1] 			= 0.0;
	PlayerTrunkPos[playerid][2] 			= 0.0;
	PlayerInfo[playerid][pDeath][0] 		= 0.0;
	PlayerInfo[playerid][pDeath][1] 		= 0.0;
	PlayerInfo[playerid][pDeath][2] 		= 0.0;

	// Previous Info(/learn, etc.)
	ResetPlayerPreviousInfo(playerid);

	PlayerInfo[playerid][pBusiness] 		= -1;
	PlayerInfo[playerid][pBusinessJob]		= -1;
	PlayerInfo[playerid][pBusinessWorkTime]	= 0;

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
	for(new wslot = 0; wslot < 13; wslot++)
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

	PlayerInfo[playerid][cIP] = '\0';

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
	crash_checker[playerid] 	= false;

	ResetFactoryVariables(playerid);
	ResetHouseVariables(playerid);
	ResetTaxiVariables(playerid);
	DestroySpeedoTextDraws(playerid);
	//ResetPlayerDrivingVars(playerid);
	//ResetPlayerFishingVars(playerid);
	DisablePlayerKeyInput(playerid);

	ResetPlayerSkills(playerid);

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
		GMX = 1;
		CheckAccountsForInactivity(); // Skidanje posla i imovine neaktivnim igracima
		#if defined AUTO_RESTART_SEQ
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
			KillTimer(CountingTimer);
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

public OnGameModeInit()
{
	ResetIterators();
	ResetVehicleEnumerator();
	ResetHouseEnumerator();
	ResetPlayerEnumerator();

	 // Loading of custom models derives from artconfig.pwn module(artconfig.txt alternative)
	LoadCustomModels();

	// SQL stuff
	g_SQL = mysql_connect_file();
	if(g_SQL == MYSQL_INVALID_HANDLE)
	{
		print("[SERVER ERROR]: Failed to connect MySQL Database!");
		return 1;
	}
	new gstring[64];
	format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
	SendRconCommand(gstring);
	mysql_log(ERROR | WARNING);
	MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL, "scriptfiles/SAmin.hmap");

	// Streamer config
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_PICKUP, 3900, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_3D_TEXT_LABEL, 1000, -1);

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

	// SA-MP gamemode settings
	ShowNameTags(1);
    SetNameTagDrawDistance(15.0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(1);
	ManualVehicleEngineAndLights();
	SetMaxConnections(3, e_FLOOD_ACTION_GHOST);

	// Server Informations
 	SetGameModeText(SCRIPT_VERSION);
	for(new i = 0; i < 312; i++) {
        if(IsValidSkin(i))
            AddPlayerClass(i,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
    }

	// Global Loads
	
	GMX = 2;
	cseconds = 120; // 2 min
	LoadGPS();
	LoadHstorage(); // House Storage Load
	LoadHouses();
	LoadBizz();
	LoadComplex();
	LoadComplexRooms();
	LoadServerVehicles();
	LoadServerFactions();
	LoadPickups();
	LoadAmmuData();
	LoadTowerData();
	LoadGraffits();
	LoadTags();
	LoadGarages();
    LoadServerGarages();
	InitPokerTables();
	CreateBaskets(); // Update - BasketballNew.pwn
	PhoneTDVars();
	LoadServerJobs();
	LoadUpdateList();
	
	//Initilazing
	//InitRuletTables();
	//InitBlackJackTables();

	// NPCs
	//InitRuletWorkers();
	//InitBlackJackDealers();

	SendRconCommand("cookielogging 0");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");

	new tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);
	SetWorldTime(tmphour);
	return 1;
}

task GlobalServerTask[1000]() // izvodi se svakih sekundu
{
	GMXTimer();
	GlobalServerTimer();
	DynamicWeather();
	return 1;
}

timer SafeEnterCheck[4000](playerid)
{
	Bit1_Set(gr_PlayerEntering, playerid, false);
	return 1;
}

timer SafeExitCheck[4000](playerid)
{
	Bit1_Set(gr_PlayerExiting, playerid, false);
	return 1;
}

timer SafeResetPlayerVariables[3000](playerid)
{
	ResetPlayerVariables(playerid);
	return 1;
}

public OnGameModeExit()
{

	// Actors
	//DestroyRuletWorkers();

	// SQL stuff
	mysql_close();

	for(new i; i<MAX_OBJECTS; i++)
	{
		if(IsValidDynamicObject(i))
			DestroyDynamicObject(i);
     	if(IsValidObject(i))
			DestroyObject(i);
	}

	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	new	count = 1;
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++){
		if(IsPlayerConnected(i) && !strcmp(GetUserIP_Connector(i), ip_address, true)){
			count++;
	    }
	}
	if(count > MAX_IP_CONNECTS){
		Kick(playerid);
    }
    return true;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if ((response) && (extraid == MODEL_SELECTION_COLOR))
	{
		va_SendClientMessage(playerid, COLOR_YELLOW, "[COLOR]: ID %d.", modelid);
	}
	return (true);
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	new backtrace[2048];
	GetAmxBacktrace(backtrace, 2048);
	Log_Write("logfiles/AMX_Query_Log.txt", "\n[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s\n%s", ReturnDate(), errorid, error, callback, query, backtrace);
	printf("[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s\n%s", ReturnDate(), errorid, error, callback, query, backtrace);
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    PokerTableEdit(playerid, objectid, response, x, y, z, rx, ry, rz);
	StorageObjectEdit(playerid, objectid, response, x, y, z, rx, ry, rz);
	return (true);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(Bit1_Get(gr_Tied, playerid))
		TogglePlayerControllable(playerid, 1), SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
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

		        GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);

		        if(strfind(animname, "fall", true) != -1)
					return 1;
			}
			new
			    Float:ep_x,
			    Float:ep_y,
			    Float:ep_z;

			GetPlayerPos(playerid, ep_x, ep_y, ep_z);
			SetPlayerPos(playerid, ep_x, ep_y, ep_z);
		}
	}
 	return 1;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT)
    {
	   	if(Bit1_Get(gr_Tied, playerid))
		    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
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
					GetPlayerIP(playerid),
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
				GetPlayerIP(playerid),
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

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, COLOR_PLAYER);
	return 1;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerDisconnect(playerid, reason)
{
	WalkStyle[playerid] = 0;
	entering[playerid] = 0;
	onexit[playerid] = 0;
	if(IsPlayerLogging(playerid))
		stop FinishPlayerSpawn(playerid);
	// Login Time && IP fetch
	format(PlayerInfo[playerid][pLastLogin], 24, ReturnDate());
	//GetPlayerIp(playerid, PlayerInfo[playerid][pLastIP], MAX_PLAYER_IP);
	PlayerInfo[playerid][pAdmMsgConfirm] = 0;
	GotRod[playerid] = 0;
	RemovePlayerFromVehicle(playerid);
	new Float:armour;
 	GetPlayerArmour(playerid, armour);
	PlayerInfo[playerid][pArmour] 	= armour;

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
	if( (reason == 0 || reason == 2) && IsPlayerAlive(playerid) && GMX == 0)
	{
		if(SafeSpawned[playerid])
		{
			new
				Float:health,
				Float:armor;

			GetPlayerHealth(playerid, health);
			PlayerInfo[playerid][pCrashHealth] 	= health;
			GetPlayerArmour(playerid, armor);
			PlayerInfo[playerid][pCrashArmour] 	= armor;

			PlayerInfo[playerid][pCrashVW] 	= GetPlayerVirtualWorld(playerid);
			PlayerInfo[playerid][pCrashInt] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);

			GetPlayerPos(playerid, PlayerInfo[playerid][pCrashPos][0], PlayerInfo[playerid][pCrashPos][1], PlayerInfo[playerid][pCrashPos][2]);

			new
				crashQuery[256];
			format(crashQuery, 256, "INSERT INTO `player_crashes`(`player_id`,`pos_x`,`pos_y`,`pos_z`,`interior`,`viwo`,`armor`,`health`,`skin`,`time`) VALUES ('%d','%.2f','%.2f','%.2f','%d','%d','%f','%f','%d','%d')",
				PlayerInfo[playerid][pSQLID],
				PlayerInfo[playerid][pCrashPos][0],
				PlayerInfo[playerid][pCrashPos][1],
				PlayerInfo[playerid][pCrashPos][2],
				PlayerInfo[playerid][pCrashInt],
				PlayerInfo[playerid][pCrashVW],
				PlayerInfo[playerid][pCrashArmour],
				PlayerInfo[playerid][pCrashHealth],
				PlayerInfo[playerid][pSkin],
				gettimestamp()
			);
			mysql_tquery(g_SQL, crashQuery, "", "");

			if(reason == 0)
			{
				new	tmpString[ 73 ];
				format(tmpString, sizeof(tmpString), "AdmWarn: Player %s just had a Client Crash.",GetName(playerid,false));
				ABroadCast(COLOR_LIGHTRED,tmpString,1);
			}
		}
	}

	// Timers
	if( Bit8_Get( gr_RingingTime, playerid ) != 0 ) {
		KillTimer(PlayerMobileRingTimer[playerid]);
		Bit8_Set( gr_RingingTime, playerid, 0 );
	}
	if( Bit1_Get( gr_PlayerTazed, playerid ) ) {
		KillTimer(TaserAnimTimer[playerid]);
		KillTimer(TaserTimer[playerid]);
		Bit1_Set( gr_PlayerTazed, playerid, false );
	}
	if( IsPlayerReconing(playerid) ) {
		DestroyReconTextDraws(playerid);
		KillTimer(ReconTimer[playerid]);
		Bit4_Set(gr_SpecateId, playerid, 0);
	}
	// Offline query
	new
	    logUpdate[64];
	format(logUpdate, sizeof(logUpdate), "UPDATE `accounts` SET `online` = '0' WHERE `sqlid` = '%d'", PlayerInfo[ playerid ][ pSQLID ]);
	mysql_tquery(g_SQL, logUpdate, "");

	// Tuning
	if( Bit1_Get( gr_PlayerInTuningMode	, playerid ) )
		SetVehicleToRespawn(PlayerTuningVehicle[playerid]);

	//Tracing
	if( Bit16_Get( gr_PlayerTracing, playerid ) )
		SendClientMessage(Bit16_Get( gr_PlayerTracing, playerid ), COLOR_RED, "[ ! ]: Line is busy (( Player is offline ))!");

	// Main Player Account Save Func.
	SavePlayerData(playerid);
	
	// Player Sets
	secquestattempt[playerid] = 3;
	if(GMX == 1) {
		SendClientMessage(playerid, COLOR_RED, "[OBAVIJEST] Spremljeni su Vasi podaci. Server Vas je automatski kickao.");
		KickMessage(playerid);
	}

	new query[222];
	format( query, sizeof(query), "UPDATE `accounts` SET `AdminMessage` = '', `AdminMessageBy` = '', `AdmMessageConfirm` = '0' WHERE `sqlid` = '%d'", // koji je ovo kurac
    	PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, query, "", "");

	defer SafeResetPlayerVariables(playerid);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(GMX == 1) {
		SendClientMessage(playerid,COLOR_RED, "ERROR: Server is currently in data storing pre-restart process. You have been automatically kicked.");
		KickMessage(playerid);
		return 1;
	}
	ResetPlayerVariables(playerid);
	if (!IsPlayerLogged(playerid) || IsPlayerConnected(playerid))
	{
		//Resets

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

		new
			checkquery[128];

		GetPlayerIp(playerid, PlayerInfo[playerid][cIP], 24);
		mysql_format(g_SQL, checkquery,sizeof(checkquery),"SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", tmpname);
		mysql_tquery(g_SQL, checkquery, "CheckPlayerInBase", "i", playerid);
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 0;
}

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

public OnPlayerSpawn(playerid)
{	
	// Player Sets
    StopAudioStreamForPlayer(playerid);
    ResetPlayerMoney(playerid);
    SetCameraBehindPlayer(playerid);
    SetPlayerFightingStyle(playerid, PlayerInfo[playerid][pFightStyle]);
    InitFly(playerid);
	
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

   	SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

	if(PlayerInfo[playerid][pDonateRank] != 0)
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
	SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]);

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

		if(PlayerInfo[playerid][pKilled] == 1)
		{
			SetPlayerInterior(playerid, PlayerInfo[ playerid ][ pDeathInt ]);
			SetPlayerVirtualWorld(playerid, PlayerInfo[ playerid ][ pDeathVW ]);
			SetPlayerPos(playerid, PlayerInfo[ playerid ][ pDeath ][ 0 ], PlayerInfo[ playerid ][ pDeath ][ 1 ], PlayerInfo[ playerid ][ pDeath ][ 2 ]);
			Streamer_UpdateEx(playerid, PlayerInfo[playerid][pDeath][0], PlayerInfo[playerid][pDeath][1], PlayerInfo[playerid][pDeath][2], PlayerInfo[playerid][ pDeathVW], PlayerInfo[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "** You are returned to position where you were wounded. **");
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Bit1_Set( gr_MaskUse, playerid, false );
			if( PlayerInfo[ playerid ][ pMaskID ])
			{
				if( PlayerInfo[ playerid ][ pDonateRank ] < 2)
					PlayerInfo[ playerid ][ pMaskID ] = 0;
			}

			TogglePlayerControllable(playerid, 0);
			CreateDeathInfos(playerid);
			SetPlayerHealth(playerid,10.0);
			PlayerWoundedAnim[playerid] = true;
			ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0,1);
			return 1;
		}
		else if(PlayerInfo[ playerid ][ pKilled ] == 2)
		{
			SetPlayerInterior(playerid, PlayerInfo[ playerid ][ pDeathInt ]);
			SetPlayerVirtualWorld(playerid, PlayerInfo[ playerid ][ pDeathVW ]);
			SetPlayerPos(playerid, PlayerInfo[ playerid ][ pDeath ][ 0 ], PlayerInfo[ playerid ][ pDeath ][ 1 ], PlayerInfo[ playerid ][ pDeath ][ 2 ]);
			Streamer_UpdateEx(playerid, PlayerInfo[playerid][pDeath][0], PlayerInfo[playerid][pDeath][1], PlayerInfo[playerid][pDeath][2], PlayerInfo[playerid][ pDeathVW], PlayerInfo[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "You are in Death Mode. You have been returned to location of your death.**");
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Bit1_Set( gr_MaskUse, playerid, false );
			if( PlayerInfo[ playerid ][ pMaskID ])
			{
				if( PlayerInfo[ playerid ][ pDonateRank ] < 2)
					PlayerInfo[ playerid ][ pMaskID ] = 0;
			}

			TogglePlayerControllable(playerid, 0);
			CreateDeathInfos(playerid);
			SetPlayerHealth(playerid,10.0);
   			PlayerWoundedAnim[playerid] = true;
			ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.1,0,1,1,1,0,1);
			return 1;
		}
		else if(PlayerInfo[ playerid ][ pKilled ] == 0)
		{
			if( PlayerInfo[playerid][pJailed] > 0)
			{
				PutPlayerInJail(playerid, PlayerInfo[playerid][pJailTime], PlayerInfo[playerid][pJailed]);
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
						if( PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID || PlayerInfo[playerid][pRentKey] != INVALID_HOUSE_ID ) {
							new
								house;
							if(  PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID )
								house = PlayerInfo[playerid][pHouseKey];
							else if( PlayerInfo[playerid][pRentKey] != INVALID_HOUSE_ID )
								house = PlayerInfo[playerid][pRentKey];

							SetPlayerInterior( playerid, HouseInfo[ house ][ hInt ] );
							SetPlayerVirtualWorld( playerid, HouseInfo[ house ][ hVirtualWorld ]);
							//Bit16_Set( gr_PlayerInHouse, playerid, house ); - da probamo napravit hoce li portat pred kucu
							SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 0, 0, true);
							SetPlayerHealth(playerid, 100);
							return 1;
						}
					}
					case 2:
					{
						if(PlayerInfo[playerid][pMember] > 0)
						{
							switch(PlayerInfo[playerid][pMember])
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
						if(PlayerInfo[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
						{
							//printf("%s{%d}(%d) >> COMPLEX >> %d", GetName(playerid, true), playerid, PlayerInfo[playerid][pComplexRoomKey]);
							new complex = PlayerInfo[playerid][pComplexRoomKey];
							SetPlayerPosEx(playerid, ComplexRoomInfo[ complex ][ cExitX ], ComplexRoomInfo[ complex ][ cExitY ], ComplexRoomInfo[ complex ][ cExitZ ], 0, 0, true);
							SetPlayerInterior( playerid, ComplexRoomInfo[ complex ][ cInt ] );
							SetPlayerVirtualWorld( playerid, ComplexRoomInfo[ complex ][ cViwo ]);
							Bit16_Set(gr_PlayerInRoom, playerid, complex);
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

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(VehicleInfo[vehicleid][vLocked] && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && Bit1_Get(gr_PlayerCuffed,playerid))
	{
		new iSeat = GetPlayerVehicleSeat(playerid);
		PutPlayerInVehicle(playerid, vehicleid, iSeat);
		GameTextForPlayer( playerid, "~w~Vehicle ~r~locked~", 3000, 4 );
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if( weaponid == WEAPON_FIREEXTINGUISHER )
	{
		new Float: oldHealth;
		GetPlayerHealth(playerid, oldHealth);
		SetPlayerHealth(playerid, oldHealth);
		return 0;
	}
	if( issuerid != INVALID_PLAYER_ID && Bit1_Get(gr_Taser, issuerid) && ( IsACop(issuerid) || IsASD(issuerid) ) && weaponid == WEAPON_SILENCED && IsPlayerLogged(playerid))
	{
		if( Bit1_Get( gr_PlayerTazed, playerid ) ) return 0;

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
			new
				damageString[ 87 ];

			format(damageString, sizeof(damageString), "* %s shoots %s with tazer and he falls down!",
				GetName(issuerid, true),
				GetName(playerid, true)
			);
		   	ProxDetector(15.0, playerid, damageString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			TogglePlayerControllable(playerid, 0);
			ApplyAnimationEx(playerid,"PED","KO_skid_front", 4.1, 0, 1, 1, 0, 0, 1, 0);
			SetPlayerDrunkLevel(playerid, 10000);

			TaserAnimTimer[playerid] 	= SetTimerEx("OnPlayerTaserAnim", 	100, 	0, "i",playerid);
			TaserTimer[playerid]		= SetTimerEx("OnPlayerTaser", 		10000, 	0, "i",playerid);
			Bit1_Set( gr_PlayerTazed, playerid, true );
		}
	}
	else if( issuerid != INVALID_PLAYER_ID && Bit1_Get(gr_BeanBagShotgun, issuerid) && ( IsACop(issuerid) || IsASD(issuerid) ) && weaponid == WEAPON_SHOTGUN && IsPlayerLogged(playerid) )
	{
		if( Bit1_Get( gr_PlayerTazed, playerid ) ) return 0;
		new Float:bb_h;
		GetPlayerHealth(playerid, bb_h);
		SetPlayerHealth(playerid, bb_h + 1);
		if(ProxDetectorS(15, playerid, issuerid))
		{
			new
				damageString[ 87 ];

			format(damageString, sizeof(damageString), "* %s shoots %s with bean bag bullet and he falls!",
				GetName(issuerid, true),
				GetName(playerid, true)
			);
			ProxDetector(15.0, playerid, damageString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			TogglePlayerControllable(playerid, 0);

			ApplyAnimationEx(playerid,"PED","KO_skid_front",4.1,0,1,1,1,1,1,0);
			SetPlayerDrunkLevel(playerid, 10000);

			TaserAnimTimer[playerid] 	= SetTimerEx("OnPlayerTaserAnim", 	100, 	0, "i",playerid);
			TaserTimer[playerid]		= SetTimerEx("OnPlayerTaser", 		10000, 	0, "i",playerid);
			Bit1_Set( gr_PlayerTazed, playerid, true );
		}
	}
	return 0;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) {
	return 0;
}

public OnPlayerTargetPlayer(playerid, targetid, weaponid)
{
	if( targetid != INVALID_PLAYER_ID ) return 0;
	if( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return 0;
	if( weaponid == WEAPON_SILENCED && Bit1_Get(gr_Taser, playerid) && ( IsACop(playerid) || IsASD(playerid) ) && !ProxDetectorS(6.0, playerid, targetid) )
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(KilledBy[playerid] == INVALID_PLAYER_ID && killerid == INVALID_PLAYER_ID || playerid == INVALID_PLAYER_ID || !SafeSpawned[playerid])
		return 1;

	if( !SafeSpawned[ KilledBy[playerid] ] ) 
		return SendClientMessage(KilledBy[playerid], COLOR_RED, "[ANTI-CHEAT]: You are not safely spawned, therefore, banned!"), BanMessage(KilledBy[playerid]), 0;

	if(IsPlayerInAnyVehicle(playerid))
		RemovePlayerFromVehicle(playerid);
	
	return 1;
}

public OnPlayerText(playerid, text[])
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
		if( Bit1_Get( gr_Drink, playerid ) )
		{
	        SetPlayerSpecialAction(playerid,0);
	        Bit1_Set( gr_Drink, playerid, false );

			new
				tmpString[ 50 ];
		  	format(tmpString, sizeof(tmpString), "* %s puts his drink aside.",
				GetName(playerid, true)
			);
		  	ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	if(WalkStyle[playerid])
	{
		if(((newkeys & KEY_UP) && (newkeys & KEY_WALK)) || ((newkeys & KEY_DOWN) && (newkeys & KEY_WALK) || ((newkeys & KEY_WALK) && (newkeys & KEY_LEFT)) || ((newkeys & KEY_WALK) && (newkeys & KEY_RIGHT))))
  		{
   		    switch(WalkStyle[playerid])
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
	return continue(playerid, newkeys, oldkeys);
}

public OnPlayerUpdate(playerid)
{
	if( Bit1_Get(gr_PlayerExiting, playerid) && GetPlayerInterior(playerid) == 0)
		defer SafeExitCheck(playerid);

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
	// Int & ViWo Sync Check
	new
		complexid = Bit16_Get( gr_PlayerInComplex, playerid ),
		roomid 	= Bit16_Get( gr_PlayerInRoom, playerid ),
		houseid 	= Bit16_Get( gr_PlayerInHouse, playerid ),
		bizzid 	= Bit16_Get( gr_PlayerInBiznis, playerid ),
		pickupid 	= Bit16_Get( gr_PlayerInPickup, playerid );

	if(PlayerInfo[playerid][pAdmin] == 0)
	{
		if(complexid == INVALID_COMPLEX_ID && roomid == INVALID_COMPLEX_ID && houseid == INVALID_HOUSE_ID && bizzid == INVALID_BIZNIS_ID && pickupid == -1)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
		if( ( complexid != INVALID_COMPLEX_ID || roomid != INVALID_COMPLEX_ID || houseid != INVALID_HOUSE_ID || bizzid != INVALID_BIZNIS_ID || pickupid != -1 ) && Bit1_Get(gr_PlayerEntering, playerid) )
			defer SafeEnterCheck(playerid);
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	if(Bit1_Get(gr_MaskUse, forplayerid)) {
	    if(PlayerInfo[playerid][pAdmin] > 0 && Bit1_Get(a_AdminOnDuty, playerid))
	        ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
	    else
	    	ShowPlayerNameTagForPlayer(playerid, forplayerid, false);
	}
	else
	    ShowPlayerNameTagForPlayer(playerid, forplayerid, true);
	return 1;
}