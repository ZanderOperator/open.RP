#include <YSI_Coding\y_hooks>

enum E_PLAYER_DATA
{
	pSQLID,
	bool:pOnline,
	pRegistered,
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

#define hFurTxtId][%1][%2] hFurTxtId][((%1)*MAX_COLOR_TEXT_SLOTS)+(%2)] // Hacking the compiler to have HouseInfo[ houseid ][ hFurTxtId ][ 0 ][ 0 ]
#define hFurColId][%1][%2] hFurColId][((%1)*MAX_COLOR_TEXT_SLOTS)+(%2)] // // Hacking the compiler to have HouseInfo[ houseid ][ hFurColId ][ 0 ][ 0 ]

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
	bEnterPickup,
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

	// UPDATES.pwn
	DIALOG_UPDATE_LIST
};

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