/*

			88   ,ad8888ba,   88888888ba   ad88888ba   
			88  d8"'    `"8b  88      "8b d8"     "8b  
			88 d8'        `8b 88      ,8P Y8,          
			88 88          88 88aaaaaa8P' `Y8aaaaa,    
			88 88          88 88""""""8b,   `"""""8b,  
			88 Y8,        ,8P 88      `8b         `8b  
	88,   ,d88  Y8a.    .a8P  88      a8P Y8a     a8P  
	"Y8888P"    `"Y8888Y"'   88888888P"   "Y88888P"   

 */

enum
{
	JOB_SWEEPER 	= 1,
	JOB_MECHANIC,
	JOB_CRAFTER,
	JOB_TAXI,
	JOB_FARMER,
	JOB_LOGGER,
	JOB_GARBAGE,
	JOB_IMPOUNDER,
	JOB_JACKER,
	JOB_BURGLAR,
	MAX_JOBS
};

/*      

	88888888ba  88                 db   8b        d8 88888888888 88888888ba   
	88      "8b 88                d88b   Y8,    ,8P  88          88      "8b  
	88      ,8P 88               d8'`8b   Y8,  ,8P   88          88      ,8P  
	88aaaaaa8P' 88              d8'  `8b   "8aa8"    88aaaaa     88aaaaaa8P'  
	88""""""'   88             d8YaaaaY8b   `88'     88"""""     88""""88'    
	88          88            d8""""""""8b   88      88          88    `8b    
	88          88           d8'        `8b  88      88          88     `8b   
	88          88888888888 d8'          `8b 88      88888888888 88      `8b  
                                                                       
*/

enum E_PLAYER_DATA
{
	pSQLID,
	pIP[MAX_PLAYER_IP],
	pRegistered,
	bool:pMustRead,
	pTeamPIN[BCRYPT_HASH_LENGTH],
	pForumName[24],
	pEmail[MAX_PLAYER_MAIL],
	pPassword[BCRYPT_HASH_LENGTH],
	pSAMPid[128],
	pSecQuestion,
	pSecQuestAnswer[31],
	pBanned,
	pSpawnChange,
	pWarns,
	pLevel,
	pLastLogin[24],
	pLastUpdateVer[24],
	pLastLoginTimestamp,
	pTempRank[2],
	pAdmin,
	pHelper,
	pConnectTime,
	bool:pMuted,
	pRespects,
	pSex,
	pAge,
	pChangenames,
	pChangeTimes,
	pMoney,
	pBank,
	pExtraFurniture,
	pVoted
}
new 
	PlayerInfo[MAX_PLAYERS][E_PLAYER_DATA];

enum E_P_COOLDOWN_INFO
{
	pCasinoCool,
	pJackerCool,
	pAmmuCool
}
new 
	PlayerCoolDown[MAX_PLAYERS][E_P_COOLDOWN_INFO];

enum E_PLAYER_INVENTORY
{
	pMaskID,
	pToolkit, 
	pWatch,
	pCiggaretes,
	pLighter,
	pParts,
	pRope,
	pBoomBox
}
new 	
	PlayerInventory[MAX_PLAYERS][E_PLAYER_INVENTORY];

enum E_PLAYER_APPEARANCE
{
	pTmpSkin,
	pSkin,
	pWalkStyle,
	pAccent[19],
	pLook[120]
}
new 
	PlayerAppearance[MAX_PLAYERS][E_PLAYER_APPEARANCE];

enum E_P_KEYS_INFO
{
	pHouseKey,
	pRentKey,
	pBizzKey,
	pComplexKey,
	pComplexRoomKey,
	pWarehouseKey,
	pGarageKey,
	pIllegalGarageKey,
	pVehicleKey
}
new 
	PlayerKeys[MAX_PLAYERS][E_P_KEYS_INFO];

enum E_P_DEATH_INFO
{
	pKilled,
	Float:pDeathX,
	Float:pDeathY,
	Float:pDeathZ,
	pDeathInt,
	pDeathVW
}
new 
	PlayerDeath[MAX_PLAYERS][E_P_DEATH_INFO];

enum E_P_CRASH_INFO
{
	pCrashId,
	pCrashVW,
	pCrashInt,
	Float:pCrashArmour,
	Float:pCrashHealth,
	Float:pCrashX,
	Float:pCrashY,
	Float:pCrashZ
}
new 
	PlayerCrash[MAX_PLAYERS][E_P_CRASH_INFO];

enum E_P_DRUG_INFO
{
	pDrugUsed,
	pDrugSeconds,
	pDrugOrder
}
new 
	PlayerDrugStatus[MAX_PLAYERS][E_P_DRUG_INFO];

enum E_PAYDAY_INFO
{
	pPayDay,
	pPayDayMoney,
	pProfit,
	pPayDayHad,
	pPayDayDialog[1536],
	pPayDayDate[32]
}
new 
	PaydayInfo[MAX_PLAYERS][E_PAYDAY_INFO];

enum E_P_JOB_INFO
{
	pJob,
	pContractTime,
	pFreeWorks
}
new 
	PlayerJob[MAX_PLAYERS][E_P_JOB_INFO];

enum E_P_MOBILE_INFO
{
	pPhoneBG, 
	pPhoneMask,
	pMobileCost,
	pMobileNumber,
	pMobileModel,
	pCryptoNumber
}
new 
	PlayerMobile[MAX_PLAYERS][E_P_MOBILE_INFO];

enum E_VIP_INFO
{
	pDonateRank,
	pDonateTime,
	pDonatorVehPerms,
}
new 	
	PlayerVIP[MAX_PLAYERS][E_VIP_INFO];

enum E_LICENSES_INFO
{
	pCarLic,
	pGunLic,
	pBoatLic,
	pFishLic,
	pFlyLic,
	pPassport
}
new 
	LicenseInfo[MAX_PLAYERS][E_LICENSES_INFO];

enum E_P_JAIL_INFO
{
	pJailed,
	pJailTime,
	pArrested,
	pBailPrice,
	pJailJob
}
new 	
	PlayerJail[MAX_PLAYERS][E_P_JAIL_INFO];

enum E_SAVINGS_INFO
{
	pSavingsCool,
	pSavingsTime,
	pSavingsType,
	pSavingsMoney,
} 
new 
	PlayerSavings[MAX_PLAYERS][E_SAVINGS_INFO];

enum E_CREDIT_INFO
{
	cCreditType,
	cRate,
	cAmount,
	cUnpaid,
	bool:cUsed,
	cTimestamp
}
new 
	CreditInfo[MAX_PLAYERS][E_CREDIT_INFO];

enum E_PLAYER_FACTION_INFO
{
	pLeader,
	pMember,
	pRank
}
new 
	PlayerFaction[MAX_PLAYERS][E_PLAYER_FACTION_INFO];

enum E_P_RADIO_INFO
{
	pHasRadio,
	pRadio[4],
	pRadioSlot[4],
	pMainSlot
}
new 
	PlayerRadio[MAX_PLAYERS][E_P_RADIO_INFO];

enum E_P_ADMIN_MSG
{
	pAdminMsg[1536],
	pAdminMsgBy[60],
	bool:pAdmMsgConfirm,
}
new 
	PlayerAdminMessage[MAX_PLAYERS][E_P_ADMIN_MSG];

enum E_PLAYER_HEALTH
{
	Float:pHealth,
	Float:pArmour,
	Float:pHunger
}
new 	
	PlayerHealth[MAX_PLAYERS][E_PLAYER_HEALTH];

enum E_PLAYER_GYM_INFO
{
	pMuscle,
	pGymTimes,
	pGymCounter,
	pFightStyle
}
new 	
	PlayerGym[MAX_PLAYERS][E_PLAYER_GYM_INFO];

enum E_PLAYER_FISH_INFO
{
	pFishWorks,
	pFishWeight,
	pFishingSkill,	
}
new 
	PlayerFish[MAX_PLAYERS][E_PLAYER_FISH_INFO];

enum E_EXP_INFO
{
	bool:eGivenEXP,
	eAllPoints,
	ePoints,
	eLastPayDayStamp,
	eDayPayDays,
	eMonthPayDays
}
new 
	ExpInfo[MAX_PLAYERS][E_EXP_INFO];

enum E_OLDPOS_INFO
{
	Float:oPosX,
	Float:oPosY,
	Float:oPosZ,
	oInt,
	oViwo
}
new 
	PlayerPrevInfo[MAX_PLAYERS][E_OLDPOS_INFO];

enum E_HIDDEN_WEAPON
{
	pwSQLID,
	pwWeaponId,
	pwAmmo
}
new 
	HiddenWeapon[MAX_PLAYERS][E_HIDDEN_WEAPON];

enum E_PLAYER_TICKS 
{
	ptReport,
	ptMoney,
	ptKill,
	ptHelperHelp,
	ptMainTimer
}
new 
	PlayerTick[MAX_PLAYERS][E_PLAYER_TICKS];

#define MAX_PHONE_LINES								10
enum E_PHONE_NEWS_DATA 
{
	npPlayerID,
	npNumber
}
new 
	NewsPhone[MAX_PHONE_LINES][E_PHONE_NEWS_DATA];

enum E_CRIME_DATA
{
	pBplayer[32],
	pAccusing[32],
	pAccusedof[32],
	pVictim[32],
	pLocation[100]
};
new 
	PlayerCrime[MAX_PLAYERS][E_CRIME_DATA];

enum E_SAFE_EXIT 
{
	Float:giX,
	Float:giY,
	Float:giZ,
	Float:giRZ
}
new 
	PlayerSafeExit[MAX_PLAYERS][E_SAFE_EXIT];

enum E_PLAYER_PACKAGES 
{
	p_SQLID,
	packExists,
	p_weapon,
	p_amount
}
new 
	PlayerPackage[MAX_PLAYERS][E_PLAYER_PACKAGES][MAX_PLAYER_PACKAGES];

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
new 
	PlayerObject[MAX_PLAYERS][MAX_CUSTOMIZED_OBJECTS][PLAYER_OBJECT_DATA];

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

/*

	88888888ba,   88888888ba  88        88   ,ad8888ba,   ad88888ba   
	88      `"8b  88      "8b 88        88  d8"'    `"8b d8"     "8b  
	88        `8b 88      ,8P 88        88 d8'           Y8,          
	88         88 88aaaaaa8P' 88        88 88            `Y8aaaaa,    
	88         88 88""""88'   88        88 88      88888   `"""""8b,  
	88         8P 88    `8b   88        88 Y8,        88         `8b  
	88      .a8P  88     `8b  Y8a.    .a8P  Y8a.    .a88 Y8a     a8P  
	88888888Y"'   88      `8b  `"Y8888Y"'    `"Y88888P"   "Y88888P"   

*/

enum E_DRUG_INFO
{
	dName[10],
	dEffect,
	dPayDayT,
	dUseTime,
	dPricePG
}

new const drugs[][E_DRUG_INFO] = 
{
	{"Prazno", 		DRUG_TYPE_NONE,   0, 0, 0},
	{"Marijuana", 	DRUG_TYPE_SMOKE,  8, 25, 70},
	{"Cocaine", 	DRUG_TYPE_SNORT,  12, 30, 110},
	{"Heroine", 	DRUG_TYPE_INJECT, 15, 35, 90},
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
new 
	PlayerDrugs[MAX_PLAYERS][E_DRUG_DATA];

/*
																						
	,ad8888ba,        db        88888888ba         db        ,ad8888ba,  88888888888  
	d8"'    `"8b      d88b       88      "8b       d88b      d8"'    `"8b 88           
	d8'               d8'`8b      88      ,8P      d8'`8b    d8'           88           
	88               d8'  `8b     88aaaaaa8P'     d8'  `8b   88            88aaaaa      
	88      88888   d8YaaaaY8b    88""""88'      d8YaaaaY8b  88      88888 88"""""      
	Y8,        88  d8""""""""8b   88    `8b     d8""""""""8b Y8,        88 88           
	Y8a.    .a88 d8'        `8b  88     `8b   d8'        `8b Y8a.    .a88 88           
	`"Y88888P" d8'          `8b 88      `8b d8'          `8b `"Y88888P"  88888888888  
  
  */

enum E_GARAGE_DATA 
{
	gSQLID,
	gOwnerID,
	gAdress[16],
	gEnterPck,
	gAreaID,
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
	GarageInfo[MAX_GARAGES][E_GARAGE_DATA];

/*

	88        88   ,ad8888ba,   88        88  ad88888ba  88888888888  
	88        88  d8"'    `"8b  88        88 d8"     "8b 88           
	88        88 d8'        `8b 88        88 Y8,         88           
	88aaaaaaaa88 88          88 88        88 `Y8aaaaa,   88aaaaa      
	88""""""""88 88          88 88        88   `"""""8b, 88"""""      
	88        88 Y8,        ,8P 88        88         `8b 88           
	88        88  Y8a.    .a8P  Y8a.    .a8P Y8a     a8P 88           
	88        88   `"Y8888Y"'    `"Y8888Y"'   "Y88888P"  88888888888  

*/

enum E_HOUSES_INFO 
{
	hSQLID,
	Float:hEnterX,
	Float:hEnterY,
	Float:hEnterZ,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	hEnterCP,
	hAreaID,
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
	hExists[MAX_FURNITURE_SLOTS],
	bool:hFurLoaded,
	hFurCounter,
	hFurSlots,
	hFurSQL[MAX_FURNITURE_SLOTS],
	hFurModelid[MAX_FURNITURE_SLOTS],
	hFurObjectid[MAX_FURNITURE_SLOTS],
	hFurDoor[MAX_FURNITURE_SLOTS],
	Float:hFurDoorZ[MAX_FURNITURE_SLOTS],
	hFurDoorLckd[MAX_FURNITURE_SLOTS],
	Float:hFurPosX[MAX_FURNITURE_SLOTS],
	Float:hFurPosY[MAX_FURNITURE_SLOTS],
	Float:hFurPosZ[MAX_FURNITURE_SLOTS],
	Float:hFurRotX[MAX_FURNITURE_SLOTS],
	Float:hFurRotY[MAX_FURNITURE_SLOTS],
	Float:hFurRotZ[MAX_FURNITURE_SLOTS],
	hFurTxtId[MAX_FURNITURE_SLOT_FIELDS],
	hFurColId[MAX_FURNITURE_SLOT_FIELDS]
}
new 
	HouseInfo[MAX_HOUSES][E_HOUSES_INFO];

 // Hacking the compiler to have HouseInfo[houseid][hFurXXX][0][0]
#define hFurTxtId][%1][%2] hFurTxtId][((%1)*MAX_COLOR_TEXT_SLOTS)+(%2)] 
#define hFurColId][%1][%2] hFurColId][((%1)*MAX_COLOR_TEXT_SLOTS)+(%2)]

/*

	,ad8888ba,   ,ad8888ba,   88b           d88 88888888ba  88          88888888888 8b        d8  
	d8"'    `"8b d8"'    `"8b  888b         d888 88      "8b 88          88           Y8,    ,8P   
	d8'          d8'        `8b 88`8b       d8'88 88      ,8P 88          88            `8b  d8'    
	88           88          88 88 `8b     d8' 88 88aaaaaa8P' 88          88aaaaa         Y88P      
	88           88          88 88  `8b   d8'  88 88""""""'   88          88"""""         d88b      
	Y8,          Y8,        ,8P 88   `8b d8'   88 88          88          88            ,8P  Y8,    
	Y8a.    .a8P Y8a.    .a8P  88    `888'    88 88          88          88           d8'    `8b   
	`"Y8888Y"'   `"Y8888Y"'   88     `8'     88 88          88888888888 88888888888 8P        Y8  

*/

enum E_COMPLEX_INFO
{
	cSQLID,
	cPickup,
	cEnterCP,
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

enum E_COMPLEX_ROOM_INFO 
{
	cSQLID,
	cRPickup,
	cEnterCP,
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

/*

	88888888ba  88        88  ad88888ba  88 888b      88 88888888888 ad88888ba   ad88888ba   
	88      "8b 88        88 d8"     "8b 88 8888b     88 88         d8"     "8b d8"     "8b  
	88      ,8P 88        88 Y8,         88 88 `8b    88 88         Y8,         Y8,          
	88aaaaaa8P' 88        88 `Y8aaaaa,   88 88  `8b   88 88aaaaa    `Y8aaaaa,   `Y8aaaaa,    
	88""""""8b, 88        88   `"""""8b, 88 88   `8b  88 88"""""      `"""""8b,   `"""""8b,  
	88      `8b 88        88         `8b 88 88    `8b 88 88                 `8b         `8b  
	88      a8P Y8a.    .a8P Y8a     a8P 88 88     `8888 88         Y8a     a8P Y8a     a8P  
	88888888P"   `"Y8888Y"'   "Y88888P"  88 88      `888 88888888888 "Y88888P"   "Y88888P"   

*/

enum E_BIZNIS_INFO
{
	bSQLID,
	bType,
	bOwnerID,
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
	bEnterPickup,
	bEnterCP,	
	bFurSlots,
	bFurSQL[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	bFurModelid[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	bFurObjectid[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	bFurDoor[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurDoorZ[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	bFurDoorLckd[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurPosX[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurPosY[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurPosZ[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurRotX[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurRotY[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	Float:bFurRotZ[BIZZ_FURNITURE_VIP_GOLD_OBJCTS],
	bFurTxtId[MAX_BIZNIS_FURNITURE_SLOTS],
	bFurColId[MAX_BIZNIS_FURNITURE_SLOTS],
	bool:bFurLoaded,
    bGasPrice
}
new 
	BizzInfo[MAX_BIZZES][E_BIZNIS_INFO];

#define bFurTxtId][%1][%2] bFurTxtId][((%1)*5)+(%2)]
#define bFurColId][%1][%2] bFurColId][((%1)*5)+(%2)]

enum
{
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
	BIZZ_TYPE_GASSTATION,
	BIZZ_TYPE_MAX
}
#define MAX_BIZZ_TYPES					(BIZZ_TYPE_MAX)

/*

88888888ba  88   ,ad8888ba,  88      a8P 88        88 88888888ba   ad88888ba   
88      "8b 88  d8"'    `"8b 88    ,88'  88        88 88      "8b d8"     "8b  
88      ,8P 88 d8'           88  ,88"    88        88 88      ,8P Y8,          
88aaaaaa8P' 88 88            88,d88'     88        88 88aaaaaa8P' `Y8aaaaa,    
88""""""'   88 88            8888"88,    88        88 88""""""'     `"""""8b,  
88          88 Y8,           88P   Y8b   88        88 88                  `8b  
88          88  Y8a.    .a8P 88     "88, Y8a.    .a8P 88          Y8a     a8P  
88          88   `"Y8888Y"'  88       Y8b `"Y8888Y"'  88           "Y88888P"   
                                                                               
*/

enum
{
	PICKUP_TYPE_NON_ENTERABLE = 0,
	PICKUP_TYPE_ENTERABLE,
	PICKUP_TYPE_MAX
}
#define MAX_PICKUP_TYPES				(PICKUP_TYPE_MAX)

/*

	ad88888ba  88      a8P  88 888b      88  ad88888ba   
	d8"     "8b 88    ,88'   88 8888b     88 d8"     "8b  
	Y8,         88  ,88"     88 88 `8b    88 Y8,          
	`Y8aaaaa,   88,d88'      88 88  `8b   88 `Y8aaaaa,    
	`"""""8b, 8888"88,     88 88   `8b  88   `"""""8b,  
			`8b 88P   Y8b    88 88    `8b 88         `8b  
	Y8a     a8P 88     "88,  88 88     `8888 Y8a     a8P  
	"Y88888P"  88       Y8b 88 88      `888  "Y88888P"  

 */

enum E_SERVER_SKINS
{
	sSkinID,
	sPrice
}
new 
	ServerSkins[E_SERVER_SKINS][MAX_SERVER_SKINS];

/*

8b           d8 88888888888 88        88 88   ,ad8888ba,  88          88888888888 ad88888ba   
`8b         d8' 88          88        88 88  d8"'    `"8b 88          88         d8"     "8b  
 `8b       d8'  88          88        88 88 d8'           88          88         Y8,          
  `8b     d8'   88aaaaa     88aaaaaaaa88 88 88            88          88aaaaa    `Y8aaaaa,    
   `8b   d8'    88"""""     88""""""""88 88 88            88          88"""""      `"""""8b,  
    `8b d8'     88          88        88 88 Y8,           88          88                 `8b  
     `888'      88          88        88 88  Y8a.    .a8P 88          88         Y8a     a8P  
      `8'       88888888888 88        88 88   `"Y8888Y"'  88888888888 88888888888 "Y88888P"   

*/

new 
	vTireHP[MAX_VEHICLES][4];

enum E_VEHICLE_DATA
{
	vSQLID,
	vModel,
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
	bool:vTicketShown[MAX_VEHICLE_TICKETS],
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
new 
	VehicleInfo[MAX_VEHICLES][E_VEHICLE_DATA];

enum 
{
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

enum
{
	VEHICLE_TYPE_CAR		= 10,
	VEHICLE_TYPE_MOTOR		= 11,
	VEHICLE_TYPE_BIKE		= 12,
	VEHICLE_TYPE_BOAT		= 13,
	VEHICLE_TYPE_PLANE		= 14,
	VEHICLE_TYPE_TRAIN		= 15
}

enum 
{
	ENGINE_TYPE_NONE		= 0,
	ENGINE_TYPE_DIESEL,
	ENGINE_TYPE_PETROL
}

/*

	88888888888 db        ,ad8888ba, 888888888888 88   ,ad8888ba,   888b      88  ad88888ba   
	88         d88b      d8"'    `"8b     88      88  d8"'    `"8b  8888b     88 d8"     "8b  
	88        d8'`8b    d8'               88      88 d8'        `8b 88 `8b    88 Y8,          
	88aaaaa  d8'  `8b   88                88      88 88          88 88  `8b   88 `Y8aaaaa,    
	88""""" d8YaaaaY8b  88                88      88 88          88 88   `8b  88   `"""""8b,  
	88     d8""""""""8b Y8,               88      88 Y8,        ,8P 88    `8b 88         `8b  
	88    d8'        `8b Y8a.    .a8P     88      88  Y8a.    .a8P  88     `8888 Y8a     a8P  
	88   d8'          `8b `"Y8888Y"'      88      88   `"Y8888Y"'   88      `888  "Y88888P"   

*/

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

/*

	,ad8888ba,  88 888888888888 8b        d8  
	d8"'    `"8b 88      88       Y8,    ,8P   
	d8'           88      88        Y8,  ,8P    
	88            88      88         "8aa8"     
	88            88      88          `88'      
	Y8,           88      88           88       
	Y8a.    .a8P 88      88           88       
	`"Y8888Y"'  88      88           88       

*/

enum E_CITY_DATA
{
	cBudget,
	cIllegalBudget,
	cTax
}
new 
	CityInfo[E_CITY_DATA];

/*

	88888888ba,   88        db        88          ,ad8888ba,     ,ad8888ba,   ad88888ba   
	88      `"8b  88       d88b       88         d8"'    `"8b   d8"'    `"8b d8"     "8b  
	88        `8b 88      d8'`8b      88        d8'        `8b d8'           Y8,          
	88         88 88     d8'  `8b     88        88          88 88            `Y8aaaaa,    
	88         88 88    d8YaaaaY8b    88        88          88 88      88888   `"""""8b,  
	88         8P 88   d8""""""""8b   88        Y8,        ,8P Y8,        88         `8b  
	88      .a8P  88  d8'        `8b  88         Y8a.    .a8P   Y8a.    .a88 Y8a     a8P  
	88888888Y"'   88 d8'          `8b 88888888888 `"Y8888Y"'     `"Y88888P"   "Y88888P"   

*/

enum 
{
	// SaveLoad
	DIALOG_LOGIN			= 10001,
	DIALOG_REGISTER,
	DIALOG_REG_AGREE,
	DIALOG_REG_PASS,
	DIALOG_REG_MAIL,
	DIALOG_REG_SEX,
	DIALOG_REG_AGE,
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

	// SaveLoad/player_admin_msg
	DIALOG_ADMIN_MSG,

	// GPS
	DIALOG_CREATEGPS,
    DIALOG_DELETEGPS,
    DIALOG_LOCATIONSGPS,
    DIALOG_ALOCATIONSGPS,
    DIALOG_GPSMAPICON,
    DIALOG_MOVEGPS,

	// Jobs/Funcs
	DIALOG_IJOBS,
	DIALOG_JOBS,

	// Taxi
	DIALOG_TAXI_RATING,

	// Report
	DIALOG_CONFIRM_SYS,
	DIALOG_REPORTS,

	// Jail
	DIALOG_JAILJOB,

	// Complex
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

	// Racing
	DIALOG_RACE_MAIN,
	DIALOG_RACE_DCP,
	DIALOG_RACE_DCPS,
	DIALOG_RACE_CALL,

	// Bank
	DIALOG_CREDIT,
	DIALOG_ACCEPT_SAVINGS,
	DIALOG_VEH_PAYMENT,
	DIALOG_HOUSE_PAYMENT,
	DIALOG_BIZZ_PAYMENT,

    // Poker
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

	// Furniture
	DIALOG_BLANK_INTS_LIST,
	DIALOG_FURNITURE_BINT_SURE,
	DIALOG_FURNITURE_MENU,
	DIALOG_FURNITURE_BUY,
	DIALOG_FURNITURE_OBJCS,
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

	// Business Furniture
	DIALOG_BIZZ_BLANK_INTS_LIST,
	DIALOG_BIZZ_FURN_BINT_SURE,
	DIALOG_BIZZ_FURN_MENU,
	DIALOG_BIZZ_FURN_BUY,
	DIALOG_BIZZ_FURN_OBJCS,
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

	// House Exterior Furniture
	DIALOG_EXTERIOR_MENU,
	DIALOG_EXTERIOR_SURE,
	DIALOG_HFUR_EXT_BUY_TYPE,
	DIALOG_HFUR_EXT_DELETE,

	// Grafiti
	DIALOG_GRAF_COLOR,
	DIALOG_GRAF_FONT,
	DIALOG_GRAF_SIZE,
	DIALOG_GRAF_TEXT,

	// Bomb
	DIALOG_BOMB,

	// Casino
	DIALOG_CASINO_RULET,
	DIALOG_CASINO_RNUMBERS,
	DIALOG_CASINO_RCOLOR,
	DIALOG_CASINO_R12,
	DIALOG_CASINO_RBET,
	DIALOG_CASINO_PAIR,
	DIALOG_CASINO_COLUMN,

	// Elections
	DIALOG_FOR_ELECTIONS,
	DIALOG_ELECTIONS_VOTE,

	// Music
	DIALOG_MUSIC_BUY,
	DIALOG_MUSIC_MAIN,
	DIALOG_MUSIC_PLAY,

	// PawnShop
	DIALOG_WEAPONS_MELEE,

	// Weapon Package
	DIALOG_PACKAGE_AMOUNT,
	DIALOG_PACKAGE_ARMOR,
	DIALOG_PACKAGE_ORDER,
	DIALOG_PACKAGE_CONFIRM,
	DIALOG_TAKE_PACKAGE,

	// Drugs
	DRUG_ORDER_PACKAGE,
	DRUG_ORDER_AMOUNT,
	DRUG_ORDER_CONFIRM,

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
	DIALOG_HOUSE_SAFE,
	DIALOG_HOUSE_BANK,
	DIALOG_HOUSE_WITHDRAW,
	DIALOG_HOUSE_UNLOCK,
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

	// HouseStorage
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
	DIALOG_OBJECTS_BUY,
	DIALOG_OBJECT_BONE_SELECTION,
	DIALOG_NEWCLOTHING,
	DIALOG_DELETECLOTHING,

	// Tuning
	DIALOG_TUNING,
	DIALOG_TUNING_REMOVE,

	// CarOwnership
	DIALOG_VEH_GET,
	DIALOG_VEH_UPGRADE,
	DIALOG_VEH_INSURANCE,
	DIALOG_VEH_BATTERY,
	DIALOG_VEH_LOCK,
	DIALOG_VEH_IMMOB,
	DIALOG_VEH_ALARM,
	DIALOG_VEH_TAKEGUN,
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

	// Factions/LSPD
	DIALOG_PD_EQUIP,
	DIALOG_PD_EQUIP_DUTY,
	DIALOG_PD_SKIN,
	DIALOG_SD_SKIN,
	DIALOG_PD_BUYGUN,

	// Factions/LSPD/Gunrack
    DIALOG_GUNRACK,

	// Factions/FD
	DIALOG_FD_EQUIP,
	DIALOG_FD_EQUIP_DUTY,
	DIALOG_FD_EQUIP_SKIN,
	DIALOG_FD_EQUIP_MD,
	DIALOG_FD_EQUIP_FD,
	DIALOG_FD_EQUIP_RADNICI,
	DIALOG_FD_EQUIP_MISC,

	// Factions/GOV
	DIALOG_GOV_EQUIP,
	DIALOG_GOV_EQUIP_DUTY,
	DIALOG_GOV_SKIN,

	// Pickups
	DIALOG_DYN_PEDISC,
	DIALOG_DYN_PDISC,

	// Rentveh
	DIALOG_RENT_V,

	// Prison
	DIALOG_CELLS,
	DIALOG_CELL,
	DIALOG_CLOSECELL,
	DIALOG_PRISONGATE,

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
	DIALOG_APB_CHECK,

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

	// Burglar
	DIALOG_ROB_POCKET,
	DIALOG_ROB_SELL,

	// Jacker
	DIALOG_JACKER_PICK,
	DIALOG_JACKER_SURE_1,
	DIALOG_JACKER_SURE_2,
	DIALOG_JACKER_BRIBE,

	// Teretana
	DIALOG_GYM_TRAIN,

	// Rest
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

	// Admin
	DIALOG_NETWORK_STATS,
	DIALOG_JAIL_GETHERE,

	// Budget & IRS
	DIALOG_PLAYER_TRANSACTIONS,
	DIALOG_LIST_TRANSACTIONS,
	DIALOG_TRANSACTIONS_INPUT,
	DIALOG_GOVMDC,

	// City/Faction Budget
	DIALOG_FACTION_PICK,
	DIALOG_FACTION_DEPOSIT,
	DIALOG_FACTION_WITHDRAW,

	// WeaponAttach
	DIALOG_WEAPON_BONE,

	// Warehouse
	WAREHOUSE_PUT_MENU,
	WAREHOUSE_TAKE_MENU,
	DIALOG_TAKE_WEAPON_LIST,
	DIALOG_WAREHOUSE_INFO,
	WAREHOUSE_MONEY_PUT,
	WAREHOUSE_MONEY_TAKE,
	
	// Licenses
	DIALOG_LICENSE,
	DIALOG_LICENSE_CONFIRM,
	DIALOG_DRIVINGTEST,
	DIALOG_DRIVING_QUEST1,
	DIALOG_DRIVING_QUEST2,
	DIALOG_DRIVING_QUEST3,
	DIALOG_DRIVING_QUEST4,

	// Help
	DIALOG_HELP,
	DIALOG_HELPER_HELP,
	DIALOG_ADMHELP,
	DIALOG_ANIMS,
	DIALOG_HELPACC,
	DIALOG_BANK,
	DIALOG_HOBI,
	DIALOG_KASINO,
	DIALOG_JOBHELP,
	DIALOG_FARMERHELP,

	// Basketball
	DIALOG_BASKET_CHOOSE,
	DIALOG_BASKET_TEAM,

	// Death.pwn
	PLAYER_DAMAGES_DIALOG,

	// RobStorage
	DIALOG_ROB_STORAGE,
	DIALOG_ROB_DSTORAGE,
	DIALOG_PICKUP_ITEM,

    // Experience
	DIALOG_EXPERIENCE_BUY,
	DIALOG_EXP_CHOOSE,
	DIALOG_MOST_TEMPEXP,
	DIALOG_MOST_OVERALLEXP,
	
	// Account Inactivity
	DIALOG_INACTIVITY_LIST,
	DIALOG_INACTIVITY_CHECK,

	// Updates
	DIALOG_UPDATE_LIST
};

/*

88b           d88                      88            88     ad88888ba             88      
888b         d888                      88            88    d8"     "8b            88      
88`8b       d8'88                      88            88    Y8,                    88      
88 `8b     d8' 88  ,adPPYba,   ,adPPYb,88  ,adPPYba, 88    `Y8aaaaa,    ,adPPYba, 88      
88  `8b   d8'  88 a8"     "8a a8"    `Y88 a8P_____88 88      `"""""8b, a8P_____88 88      
88   `8b d8'   88 8b       d8 8b       88 8PP""""""" 88            `8b 8PP""""""" 88      
88    `888'    88 "8a,   ,a8" "8a,   ,d88 "8b,   ,aa 88    Y8a     a8P "8b,   ,aa 88 888  
88     `8'     88  `"YbbdP"'   `"8bbdP"Y8  `"Ybbd8"' 88     "Y88888P"   `"Ybbd8"' 88 888  

*/
enum
{
	// Faction Skins
	ms_FDSKIN 		= 5001,
	ms_GOVSKIN, 
	ms_LAWSKIN,
	ms_SDSKIN,
	
	// CreateObjects
	ms_EDIT_COBJECT,
	ms_CREATE_COBJECT,
	ms_ADMIN_DEL_COBJECT,
	ms_DEL_COBJECT,

	// Rentveh
	ms_RENTCARS,

	// Objects
	ms_CLOTHES,

	// Bizz
	ms_SKINS,

	// BizzFurniture
	ms_BIZFUR_BUY,
	ms_BIZFUR_EDIT,

	// House Furniture
	ms_HFUR_BUY,
	ms_HFUR_EDIT,

	// House Exterior Furniture
	ms_HFUR_EXT_BUY,
	ms_HFUR_EXT_EDIT,
	ms_HFUR_EXT_DELETE,
};

/*
                                                                                              
I8,        8        ,8I 88888888888        db        88888888ba    ,ad8888ba,   888b      88  
`8b       d8b       d8' 88                d88b       88      "8b  d8"'    `"8b  8888b     88  
 "8,     ,8"8,     ,8"  88               d8'`8b      88      ,8P d8'        `8b 88 `8b    88  
  Y8     8P Y8     8P   88aaaaa         d8'  `8b     88aaaaaa8P' 88          88 88  `8b   88  
  `8b   d8' `8b   d8'   88"""""        d8YaaaaY8b    88""""""'   88          88 88   `8b  88  
   `8a a8'   `8a a8'    88            d8""""""""8b   88          Y8,        ,8P 88    `8b 88  
    `8a8'     `8a8'     88           d8'        `8b  88           Y8a.    .a8P  88     `8888  
     `8'       `8'      88888888888 d8'          `8b 88            `"Y8888Y"'   88      `888  

*/

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

enum E_WEAPON_PACKAGE 
{
	wep_ID,
	wep_Name[16],
	wep_Price
}
new 
	show_WeaponList[MAX_LISTED_WEAPONS][E_WEAPON_PACKAGE] = 
{
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