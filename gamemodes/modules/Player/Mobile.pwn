#include <YSI_Coding\y_hooks>

#if defined MODULE_MOBILE
	#endinput
#endif
#define MODULE_MOBILE

/*
	DEFINES
*/
#define MOBILE_OBJECT_SLOT	9

#define MAX_MOBILE_CONTACTS 10
#define MAX_CONTACT_LEN		11

#define SPEED_MUL   0.1
#define MAX_Z_VEL 0.02

#define SELFIE_RADIUS		1.5
#define SELFIE_DISTANCE		1.14
#define SELFIE_HEIGHT		0.7

#define PHONE_TEXTDRAWS 	104

#define MAX_TOWERS          100

#define PHONE_HIDE 			0
#define PHONE_SHOW 			1
#define PHONE_NEXT 			2
#define PHONE_ON 			3
#define PHONE_OFF 			4

#define PTD_ACTION_HOME 	0
#define PTD_ACTION_CALL 	1
#define PTD_ACTION_SMS	 	2
#define PTD_ACTION_CONT	 	3

#define SMS_TYPE_SENT       1
#define SMS_TYPE_REC        2

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

enum E_SMS_DATA
{
	sType,
	sNumber,
	sText[128],
	sTime[32],
	sRead
}
new
	SMSInfo[MAX_PLAYERS][5][E_SMS_DATA];

enum E_TOWER_DATA
{
	twSQLID,
	twNetwork[24],
	Float:twPosX,
	Float:twPosY,
	Float:twPosZ,
	Float:twPosRX,
	Float:twPosRY,
	Float:twPosRZ,
	Float:twRadius,
	twObject
}
new
	TowerInfo[MAX_TOWERS][E_TOWER_DATA];

new ContactEditing[MAX_PLAYERS];

new BackgroundColors[][] =
{
	{ 0xFFFFFFFF , "Default"},
	{ 0xFF0000FF , "Red"},
	{ 0x00FFFFFF , "Cyan"},
	{ 0xC0C0C0FF , "Silver"},
	{ 0x0000FFFF , "Blue"},
	{ 0x808080FF , "Grey"},
	{ 0x0000A0FF , "DarkBlue"},
	{ 0x000000FF , "Black"},
	{ 0xADD8E6FF , "LightBlue"},
	{ 0xFFA500FF , "Orange"},
	{ 0x800080FF , "Purple"},
	{ 0xA52A2AFF , "Brown"},
	{ 0xFFFF00FF , "Yellow"},
	{ 0x800000FF , "Maroon"},
	{ 0x00FF00FF , "Lime"},
	{ 0x008000FF , "Green"},
	{ 0xFF00FFFF , "Fuchsia"},
	{ 0x808000FF , "Olive"}
};

new MaskColors[][] =
{
	{ 0xFFFFFFFF , "Skini maskicu"},
	{ 0xFF0000FF , "Red"},
	{ 0x00FFFFFF , "Cyan"},
	{ 0xC0C0C0FF , "Silver"},
	{ 0x0000FFFF , "Blue"},
	{ 0x808080FF , "Grey"},
	{ 0x0000A0FF , "DarkBlue"},
	{ 0x000000FF , "Black"},
	{ 0xADD8E6FF , "LightBlue"},
	{ 0xFFA500FF , "Orange"},
	{ 0x800080FF , "Purple"},
	{ 0xA52A2AFF , "Brown"},
	{ 0xFFFF00FF , "Yellow"},
	{ 0x800000FF , "Maroon"},
	{ 0x00FF00FF , "Lime"},
	{ 0x008000FF , "Green"},
	{ 0xFF00FFFF , "Fuchsia"},
	{ 0x808000FF , "Olive"}
};

enum E_PHONE_MODEL_INFO
{
	phModelID,
	phModelName[30],
	phModelPrice
}

new	PhoneModels[10][E_PHONE_MODEL_INFO] = {
	{-2022, "Samsung Galaxy S6"				, 350},
	{-2027, "Samsung Galaxy Note"			, 330},
	{18867, "Nokia 5210"					, 79},
	{18868, "Sony Ericsson T18"				, 50},
	{-2025, "iPhone 6s"						, 350},
	{-2023, "iPhone 7"						, 400},
	{-2024, "Motorola StarPhone"			, 300},
	{-2026, "Huaweii G7"					, 350},
	{18873, "Motorola StarTAC Rainbow"		, 175},
	{18873, "Nokia 3210"					, 89}
};

new 
	PlayerContactSQL[MAX_PLAYERS][MAX_MOBILE_CONTACTS],
	PlayerContactName[MAX_PLAYERS][MAX_MOBILE_CONTACTS][MAX_CONTACT_LEN],
	PlayerContactNumber[MAX_PLAYERS][MAX_MOBILE_CONTACTS];

static
    bool:MobileOn[MAX_PLAYERS] = {true, ...};

// rBits
new
	Bit1:	gr_CanHangup			<MAX_PLAYERS>  	= { Bit1: true, ...},
	Bit1: 	gr_PlayerTakingSelfie 	<MAX_PLAYERS>	= { Bit1: false, ... },
	Bit1:	gr_PlayerUsingPhonebooth		<MAX_PLAYERS>	= { Bit1: false, ... },
	Bit8: 	gr_RingingTime			<MAX_PLAYERS>	= { Bit8: 0, ... },
	Bit8:	gr_MobileContactSlot 	<MAX_PLAYERS> 	= { Bit8: 0, ... };

static
	Float:SelfieAngle[MAX_PLAYERS],
	Float:SelfieHeight[MAX_PLAYERS],
	Timer:PlayerMobileRingTimer[MAX_PLAYERS],
	StartCallTimestamp[MAX_PLAYERS] = { 0, ... },
	PlayerCallPlayer[MAX_PLAYERS],
	CallingId[MAX_PLAYERS],
	bool:SpeakerPhone[MAX_PLAYERS],
	DialogInputNumber[MAX_PLAYERS][11],
	PhoneTDAction[MAX_PLAYERS],
	TDPhoneDial[PHONE_TEXTDRAWS],
	PlayerTextDrawCreated[MAX_PLAYERS][PHONE_TEXTDRAWS],
	PlayerText:PhoneTD[MAX_PLAYERS][PHONE_TEXTDRAWS],
	PhoneStatus[MAX_PLAYERS],
	PhoneLine[MAX_PLAYERS],
	TowerEditingObj[MAX_PLAYERS],
	Float:TowerEditingRadius[MAX_PLAYERS],
	PhoneUpdateTick[MAX_PLAYERS],
	TowerEditingNetwork[MAX_PLAYERS][24];

static 
	Iterator: MobileContacts[MAX_PLAYERS]<MAX_MOBILE_CONTACTS>;


/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/

bool:Player_MobileSpeaking(playerid)
{
	return (CallingId[playerid] != 999 || PlayerCallPlayer[playerid] != INVALID_PLAYER_ID);
}

stock Player_PhoneStatus(playerid)
{
	return PhoneStatus[playerid];
}

stock Player_SetPhoneStatus(playerid, status)
{
	PhoneStatus[playerid] = status;
}

stock bool:Player_MobileOn(playerid)
{
    return MobileOn[playerid];
}

stock Player_SetMobileOn(playerid, bool:v)
{
    MobileOn[playerid] = v;
}

stock Player_PhoneLine(playerid)
{
    return PhoneLine[playerid];
}

stock Player_SetPhoneLine(playerid, v)
{
    PhoneLine[playerid] = v;
}

static LoadTowerData()
{
	inline OnTowerLoaded()
	{
		new
			rows = cache_num_rows();

		if(!rows)
			return print("MySQL Report: No Signal Tower data exist to load.");
		
		for(new twslotid = 0; twslotid < rows; twslotid++) 
		{
			cache_get_value_name_int(twslotid, "id", TowerInfo[twslotid][twSQLID]);
			cache_get_value_name(twslotid, "network", TowerInfo[twslotid][twNetwork], 24);
			cache_get_value_name_float(twslotid, "posx", TowerInfo[twslotid][twPosX]);
			cache_get_value_name_float(twslotid, "posy", TowerInfo[twslotid][twPosY]);
			cache_get_value_name_float(twslotid, "posz", TowerInfo[twslotid][twPosZ]);
			cache_get_value_name_float(twslotid, "posrx", TowerInfo[twslotid][twPosRX]);
			cache_get_value_name_float(twslotid, "posry", TowerInfo[twslotid][twPosRY]);
			cache_get_value_name_float(twslotid, "posrz", TowerInfo[twslotid][twPosRZ]);
			cache_get_value_name_float(twslotid, "radius", TowerInfo[twslotid][twRadius]);
			CreateTowerObject(twslotid);
		}
		printf("MySQL Report: Signal Towers Loaded. [%d/%d]", rows, MAX_TOWERS);
		return 1;
	}
	MySQL_PQueryInline(SQL_Handle(), 
		using inline OnTowerLoaded,
		va_fquery(SQL_Handle(), "SELECT * FROM signaltowers WHERE 1"), 
		""
	);
	return 1;
}

stock LoadPlayerContacts(playerid)
{
	inline OnPlayerContactsLoad()
	{
		new 
			rows = cache_num_rows();
		if(!rows)
			return 1;
		
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "title",  PlayerContactName[playerid][i], MAX_CONTACT_LEN);
			cache_get_value_name_int(i, "number", PlayerContactNumber[playerid][i]);
			Iter_Add(MobileContacts[playerid], i);
		}
		return 1;
	}
	MySQL_PQueryInline(SQL_Handle(),
		using inline OnPlayerContactsLoad,
		va_fquery(SQL_Handle(), "SELECT * FROM player_mobile_contacts WHERE player_id = '%d' LIMIT %d", 
			PlayerInfo[playerid][pSQLID],
			MAX_MOBILE_CONTACTS
		), 
		""
	);
	return 1;
}

stock DeletePlayerContacts(playerid)
{
	mysql_fquery(SQL_Handle(), "DELETE FROM player_mobile_contacts WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]);
	return 1;
}

stock SavePlayerContact(playerid, slotid)
{
	mysql_fquery(SQL_Handle(), "UPDATE player_mobile_contacts SET title = '%e', number = '%d' WHERE sqlid = '%d'",
		PlayerContactName[playerid][slotid],
		PlayerContactNumber[playerid][slotid],
		PlayerContactSQL[playerid][slotid]
	);
	return 1;
}

static InsertMobileContact(playerid, slotid)
{
	inline OnMobileContactInsert()
	{
		PlayerContactSQL[playerid][slotid] = cache_insert_id();
		Iter_Add(MobileContacts[playerid], slotid);
		return 1;
	}
	MySQL_PQueryInline(SQL_Handle(),
		using inline OnMobileContactInsert,
		va_fquery(SQL_Handle(), 
			"INSERT INTO player_mobile_contacts(player_id, title, number) VALUES ('%d', '%e', '%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerContactName[playerid][slotid],
			PlayerContactNumber[playerid][slotid]
		),
		"ii",
		playerid,
		slotid
	);
	return 1;
}

stock DeleteMobileContact(sqlid)
{
	mysql_fquery(SQL_Handle(), "DELETE FROM player_mobile_contacts WHERE sqlid = '%d'", sqlid);
	return 1;
}

stock SavePlayerMobile(playerid, type=1)
{
	if(type == 1)
	{
		mysql_fquery(SQL_Handle(), "DELETE FROM player_phones WHERE player_id = '%d' AND type = '1'",
			PlayerInfo[playerid][pSQLID]
		);

		mysql_fquery_ex(SQL_Handle(), 
			"INSERT INTO \n\
				player_phones \n\
			(player_id, type, model, number, money, background, mask, time) \n\
			VALUES \n\
				('%d','%d','%d','%d','%d','%d','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			type,
			PlayerMobile[playerid][pMobileModel],
			PlayerMobile[playerid][pMobileNumber],
			PlayerMobile[playerid][pMobileCost],
			PlayerMobile[playerid][pPhoneBG],
			PlayerMobile[playerid][pPhoneMask],
			gettimestamp()
		);
	}
	else if(type == 2)
	{
		mysql_fquery(SQL_Handle(), "DELETE FROM player_phones WHERE player_id = '%d' AND type = '2'",
			PlayerInfo[playerid][pSQLID]
		);

		mysql_fquery_ex(SQL_Handle(), 
			"INSERT INTO \n\
				player_phones(player_id, type, model, number, money, background, mask, time, cryptonumber) \n\
			VALUES \n\
				('%d','%d','%d','%d','%d','%d','%d','%d','%d')",
			PlayerInfo[playerid][pSQLID],
			type,
			0,
			PlayerMobile[playerid][pMobileNumber],
			0,
			0,
			0,
			gettimestamp(),
			PlayerMobile[playerid][pCryptoNumber]
		);
	}
	return 1;
}

GetMobileNumberFromSQL(sqlid)
{
    new
		dest = 0;
	
	if(sqlid > 0) 
	{
	    new	Cache:result;
		result = mysql_query(SQL_Handle(), 
					va_fquery(SQL_Handle(), "SELECT number FROM player_phones WHERE player_id = '%d' AND type = '1'", sqlid)
				);
  		cache_get_value_index_int(0, 0, dest);
		cache_delete(result);
	} 
	return dest;
}

stock ListPhonesForSale()
{
	new dMobileString[1024],
		motd[64];
		
	for(new i = 0; i < sizeof(PhoneModels); i++)
	{
		if(i == (sizeof(PhoneModels)-1))
			format(motd, 64, "%s - %d$", PhoneModels[i][phModelName], PhoneModels[i][phModelPrice]);
		else format(motd, 64, "%s - %d$\n", PhoneModels[i][phModelName], PhoneModels[i][phModelPrice]);
		strcat(dMobileString, motd, 1024);
	}
	return dMobileString;
}

stock GetMobileName(modelid)
{
	new mobilename[30],
		bool:found = false;
		
	for(new i = 0; i < sizeof(PhoneModels); i++)
	{
		if(PhoneModels[i][phModelID] == modelid)
		{
			strcpy(mobilename, PhoneModels[i][phModelName], 30);
			found = true;
			break;
		}
	}
	
	if(modelid == 0 || !found)
		format(mobilename, 30, "Nema mobitel");
	
	return mobilename;
}

stock BuyPlayerPhone(playerid, listid)
{
	if(AC_GetPlayerMoney(playerid) < PhoneModels[listid][phModelPrice]) 
		return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca da kupis %s(%d$)!", 
					PhoneModels[listid][phModelName], 
					PhoneModels[listid][phModelPrice]
				);

	PlayerToBudgetMoney(playerid, PhoneModels[listid][phModelPrice]); // Novac ide u proracun jer je Verona Mall
	PlayerMobile[playerid][pMobileModel] = PhoneModels[listid][phModelID];
	PlayerMobile[playerid][pMobileNumber] = 100000 + random(899999);
	va_SendClientMessage(playerid, COLOR_RED,  "[!]  Vas novi broj mobilnog telefona je %d.", PlayerMobile[playerid][pMobileNumber]);
	va_SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste kupili %s!", PhoneModels[listid][phModelName]);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	PlayerMobile[playerid][pMobileCost] = 0;
	PlayerMobile[playerid][pPhoneBG] = -1263225696;
	PlayerMobile[playerid][pPhoneMask] = 0;
	
	ResetMobileContacts(playerid);
	SavePlayerMobile(playerid);
	return 1;
}

UpdatePlayerMobile(playerid)
{
	if(PlayerMobile[playerid][pMobileNumber] != 0)
	{
		mysql_fquery(SQL_Handle(), 
			"UPDATE player_phones SET model= '%d', number = '%d', money = '%d' WHERE player_id = '%d' AND type = '1'",
			PlayerMobile[playerid][pMobileModel],
			PlayerMobile[playerid][pMobileNumber],
			PlayerMobile[playerid][pMobileCost],
			PlayerInfo[playerid][pSQLID]
		);
	}
	if(PlayerMobile[playerid][pCryptoNumber] != 0)
	{
		mysql_fquery(SQL_Handle(), "UPDATE player_phones SET cryptonumber = '%d' WHERE player_id = '%d' AND type = '2'",
			PlayerMobile[playerid][pCryptoNumber],
			PlayerInfo[playerid][pSQLID]
		);
	}
	return 1;
}

hook function SavePlayerStats(playerid)
{
	UpdatePlayerMobile(playerid);
	return continue(playerid);
}

stock LoadPlayerMobile(playerid)
{
	mysql_tquery(SQL_Handle(), 
		va_fquery(SQL_Handle(), "SELECT * FROM player_phones WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]), 
		"OnPlayerMobileLoad", 
		"i", 
		playerid
	);
	return 1;
}

forward OnPlayerMobileLoad(playerid);
public OnPlayerMobileLoad(playerid)
{
	if(cache_num_rows())
	{
	    for( new i = 0; i < cache_num_rows(); i++)
		{
			new
				mobileType;
			cache_get_value_name_int(i, "type"			, mobileType);

			if(mobileType == 1)
			{
				cache_get_value_name_int(i, "model"			, PlayerMobile[playerid][pMobileModel]);
				cache_get_value_name_int(i, "number"		, PlayerMobile[playerid][pMobileNumber]);
				cache_get_value_name_int(i, "money"			, PlayerMobile[playerid][pMobileCost]);
				cache_get_value_name_int(i, "background"	, PlayerMobile[playerid][pPhoneBG]);
				cache_get_value_name_int(i, "mask"			, PlayerMobile[playerid][pPhoneMask]);
				
				LoadPlayerContacts(playerid);
			}
			else if(mobileType == 2)
			{
				cache_get_value_name_int(i, "cryptonumber", PlayerMobile[playerid][pCryptoNumber]);
			}
		}
	}
	return 1;
}


hook function LoadPlayerStats(playerid)
{
	LoadPlayerMobile(playerid);
	return continue(playerid);
}

stock PhoneMessage(playerid, phonestring[])
{
	foreach (new i : Player)
	{
	    if(ProxDetectorS(5.0, playerid, i) && playerid != i)
	    {
	    	SendClientMessage(i, COLOR_FADE1, phonestring);
	    }
    }
    return 1;
}

stock CreateTowerObject(towerid)
{
    TowerInfo[towerid][twObject] = CreateDynamicObject(3763, TowerInfo[towerid][twPosX], TowerInfo[towerid][twPosY], TowerInfo[towerid][twPosZ], TowerInfo[towerid][twPosRX], TowerInfo[towerid][twPosRY], TowerInfo[towerid][twPosRZ]);
    return 1;
}

forward GetFreeTowerID();
public GetFreeTowerID()
{
	for(new i = 0; i < MAX_TOWERS; i++)
	{
	    if(TowerInfo[i][twPosX] == 0.0 && TowerInfo[i][twPosY] == 0.0 && TowerInfo[i][twPosZ] == 0.0)
		{
		    return i;
		}
	}
	return -1;
}

stock CreateTower(towerid)
{
	inline OnTowerCreated()
	{
		TowerInfo[towerid][twSQLID] = cache_insert_id();
		return 1;
	}
	MySQL_PQueryInline(SQL_Handle(), 
		using inline OnTowerCreated,
		va_fquery(SQL_Handle(), 
			"INSERT INTO \n\
				signaltowers \n\
			(network, posx, posy, posz, posrx, posry, posrz, radius) \n\
			VALUES \n\
				('%e', '%f', '%f', '%f', '%f', '%f', '%f', '%f')",
			TowerInfo[towerid][twNetwork],
			TowerInfo[towerid][twPosX],
			TowerInfo[towerid][twPosY],
			TowerInfo[towerid][twPosZ],
			TowerInfo[towerid][twPosRX],
			TowerInfo[towerid][twPosRY],
			TowerInfo[towerid][twPosRZ],
			TowerInfo[towerid][twRadius]
		),  
		"i", 
		towerid
	);
	return 1;
}

stock DeleteTower(towerid)
{
	if(TowerInfo[towerid][twPosX] == 0.0 && TowerInfo[towerid][twPosY] == 0.0 && TowerInfo[towerid][twPosZ] == 0.0) return 0;
	
	
	DestroyDynamicObject(TowerInfo[towerid][twObject]);
	format(TowerInfo[towerid][twNetwork], 24, "");
	TowerInfo[towerid][twPosX] = 0.0;
	TowerInfo[towerid][twPosY] = 0.0;
	TowerInfo[towerid][twPosZ] = 0.0;
	TowerInfo[towerid][twPosRX] = 0.0;
	TowerInfo[towerid][twPosRY] = 0.0;
	TowerInfo[towerid][twPosRZ] = 0.0;
	TowerInfo[towerid][twRadius] = 0.0;

	mysql_fquery(SQL_Handle(), "DELETE FROM signaltowers WHERE id = '%d' LIMIT 1", TowerInfo[towerid][twSQLID]);
	return 1;
}

stock HidePlayerMobile(playerid)
{
	PhoneAction(playerid, PHONE_HIDE);
	Player_SetPhoneStatus(playerid, PHONE_HIDE);
	CancelSelectTextDraw(playerid);
	PhoneTDAction[playerid] = PTD_ACTION_HOME;
	return 1;
}

stock RemovePlayerMobile(playerid)
{
	PlayerMobile[playerid][pMobileModel] = 0;
	PlayerMobile[playerid][pMobileNumber] = 0;
	PlayerMobile[playerid][pMobileCost] = 0;

	HidePlayerMobile(playerid);

	DeletePlayerContacts(playerid);
	
	mysql_fquery(SQL_Handle(),
		 "DELETE FROM player_phones WHERE player_id = '%d' AND type = '1'", 
		 PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock PrintAllTowers(playerid)
{
	new stpCount = 0;
	for(new i; i < MAX_TOWERS; i++)
	{
		if(TowerInfo[i][twPosX] != 0.0 && TowerInfo[i][twPosY] != 0.0 && TowerInfo[i][twPosZ] != 0.0)
		{
			va_SendClientMessage(playerid, -1, "- Tower %d - Network: %s - SQLID: %d", i, TowerInfo[i][twNetwork], TowerInfo[i][twSQLID]);
			stpCount++;
		}
	}
	if(stpCount == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nema napravljenih signalnih tornjeva!");
	return 1;
}

forward Float:DistanceFromTower(playerid, towerid);
public Float:DistanceFromTower(playerid, towerid)
{
	new Float:DistFromTower = GetPlayerDistanceFromPoint(playerid, TowerInfo[towerid][twPosX], TowerInfo[towerid][twPosY], TowerInfo[towerid][twPosZ]);
	return DistFromTower;
}

stock SignalStrength(playerid, towerid)
{
	new Float:TowerDistance = DistanceFromTower(playerid, towerid);
	new Float:TWRadius = TowerInfo[towerid][twRadius];
	new
		houseid  = Player_InHouse(playerid),
		bizzid   = Player_InBusiness(playerid),
		garageid = Player_InGarage(playerid);
	
	if(House_Exists(houseid))
	{
		return 5;
	}
	if(Bizz_Exists(bizzid))
	{
		return 5;
	}
	if(Garage_Exists(garageid))
	{
		return 5;
	}
	if(GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0)
	{
		return 5;
	}

	if((TowerDistance >= 0) && (TowerDistance < (TWRadius/5)))
		return 5;
	else if((TowerDistance >= (TWRadius/5)) && (TowerDistance < (TWRadius/5)*2))
		return 4;
	else if((TowerDistance >= (TWRadius/5)*2) && (TowerDistance < ((TWRadius/5)*3)))
		return 3;
	else if((TowerDistance >= (TWRadius/5)*3) && (TowerDistance < (TWRadius/5)*4))
		return 2;
	else if((TowerDistance >= (TWRadius/5)*4) && (TowerDistance < (TWRadius)))
		return 1;
	return 0;
}

forward ConnectedSignalTower(playerid);
public ConnectedSignalTower(playerid)
{
	new CSTower = -1, CSSignal = 0;
	for(new i = 0; i < MAX_TOWERS; i++)
	{
	    if(SignalStrength(playerid, i) > CSSignal)
	    {
	        CSTower = i;
	        CSSignal = SignalStrength(playerid, i);
	    }
	}
	return CSTower;
}

forward PhoneAction(playerid, phaction);
public PhoneAction(playerid, phaction)
{
	if(phaction == PHONE_SHOW)
	{
	    PhoneAction(playerid, PHONE_NEXT);

	    PhoneTD[playerid][0] = CreatePlayerTextDraw(playerid, 455.000000, 309.137481, "LD_DUAL:tvcorn"); //Ljevo crno kuciste
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][0], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][0], 69.000000, 167.000000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][0], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][0], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][0], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][0], 0);

		PhoneTD[playerid][1] = CreatePlayerTextDraw(playerid, 578.300048, 309.211364, "LD_DUAL:tvcorn"); //Desno crno kuciste
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][1], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][1], -69.000000, 167.000000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][1], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][1], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][1], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][1], 0);

		PhoneTD[playerid][2] = CreatePlayerTextDraw(playerid, 459.599975, 318.524993, "LD_DUAL:black"); //Crni LCD zaslon
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][2], 114.000000, 130.000000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][2], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][2], 0);

		PhoneTD[playerid][3] = CreatePlayerTextDraw(playerid, 568.599121, 312.712646, "LD_DUAL:shoot"); //Kamera - Krug
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][3], 3.909954, 3.200000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][3], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][3], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][3], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][3], 0);

		PhoneTD[playerid][4] = CreatePlayerTextDraw(playerid, 568.599121, 312.512634, "LD_DUAL:light"); //Notifikacijsko svijetlo
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][4], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][4], 3.909954, 3.200000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][4], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][4], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][4], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][4], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][4], 0);

		PhoneTD[playerid][5] = CreatePlayerTextDraw(playerid, 459.899902, 309.138763, "LD_SPAC:Health"); //Crveno svijetlo - UgaSen
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][5], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PhoneTD[playerid][5], 12.000000, 3.000000);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][5], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][5], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][5], 4);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][5], 0);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][5], 0);

		PhoneTD[playerid][6] = CreatePlayerTextDraw(playerid, 499.000000, 309.437500, "LSTech"); //Logo
		PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][6], 0.355999, 0.777499);
		PlayerTextDrawAlignment(playerid, PhoneTD[playerid][6], 1);
		PlayerTextDrawColor(playerid, PhoneTD[playerid][6], -76);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][6], 255);
		PlayerTextDrawFont(playerid, PhoneTD[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][6], 0);


		for(new i = 0; i < 7; i++)
		{
    		PlayerTextDrawCreated[playerid][i] = 1;
    	}

	    if(Player_MobileOn(playerid))
	    {
			PhoneTD[playerid][7] = CreatePlayerTextDraw(playerid, 460.000000, 318.625000, "LD_BUM:blkdot"); //Osvjetljeni LCD zaslon #1
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][7], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][7], 114.000000, 132.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][7], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][7], PlayerMobile[playerid][pPhoneBG]); //Boja pozadine
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][7], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][7], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][7], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][7], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][7], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][7], 0);

			PhoneTD[playerid][8] = CreatePlayerTextDraw(playerid, 459.599975, 318.187500, "LD_OTB2:butnA"); //Notifikacijska traka
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][8], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][8], 115.000000, 8.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][8], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][8], -1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][8], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][8], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][8], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][8], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][8], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][8], 0);

			PhoneTD[playerid][9] = CreatePlayerTextDraw(playerid, 462.500000, 318.450897, "-----"); //Signal
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][9], 0.219499, 0.550000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][9], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][9], 255);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][9], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][9], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][9], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][9], 1);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][9], 1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][9], 0);

			PhoneTD[playerid][10] = CreatePlayerTextDraw(playerid, 459.899902, 309.138763, "LD_DUAL:power"); //Zeleno svijetlo - Upaljen #1
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][10], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][10], 12.000000, 3.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][10], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][10], -1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][10], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][10], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][10], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][10], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][10], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][10], 0);

			PhoneTD[playerid][11] = CreatePlayerTextDraw(playerid, 560.399536, 319.937500, "LD_DUAL:power"); //Zeleno svijetlo - Upaljen #2
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][11], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][11], 7.000000, 2.810000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][11], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][11], -1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][11], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][11], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][11], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][11], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][11], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][11], 0);

			PhoneTD[playerid][12] = CreatePlayerTextDraw(playerid, 565.098388, 319.837493, "LD_PLAN:blkdot"); //Osvjetljeni LCD zaslon #2
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][12], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][12], 2.000000, 3.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][12], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][12], -1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][12], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][12], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][12], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][12], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][12], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][12], 0);

			PhoneTD[playerid][13] = CreatePlayerTextDraw(playerid, 540.000061, 317.549987, "00:00");
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][13], 0.200000, 0.676875);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][13], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][13], 255);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][13], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][13], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][13], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][13], 1);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][13], 1);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][13], 0);

			SetTDTime(playerid);

			for(new i = 7; i < 14; i++)
    		{
        		PlayerTextDrawCreated[playerid][i] = 1;
        	}

	        if(PhoneTDAction[playerid] == PTD_ACTION_HOME)
	        {
				PhoneTD[playerid][14] = CreatePlayerTextDraw(playerid, 480.598449, 333.526336, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][14], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][14], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][14], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][14], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][14], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][14], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][14], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][14], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][14], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][14], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][14], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][14], 0);

				PhoneTD[playerid][15] = CreatePlayerTextDraw(playerid, 517.098937, 333.588867, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][15], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][15], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][15], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][15], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][15], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][15], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][15], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][15], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][15], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][15], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][15], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][15], 0);

				PhoneTD[playerid][16] = CreatePlayerTextDraw(playerid, 553.098449, 333.026306, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][16], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][16], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][16], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][16], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][16], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][16], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][16], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][16], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][16], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][16], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][16], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][16], 0);

				PhoneTD[playerid][17] = CreatePlayerTextDraw(playerid, 480.598449, 365.401306, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][17], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][17], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][17], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][17], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][17], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][17], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][17], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][17], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][17], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][17], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][17], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][17], 0);

				PhoneTD[playerid][18] = CreatePlayerTextDraw(playerid, 517.398498, 364.963806, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][18], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][18], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][18], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][18], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][18], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][18], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][18], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][18], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][18], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][18], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][18], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][18], 0);

				PhoneTD[playerid][19] = CreatePlayerTextDraw(playerid, 553.398498, 364.963806, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][19], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][19], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][19], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][19], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][19], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][19], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][19], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][19], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][19], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][19], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][19], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][19], 0);

				PhoneTD[playerid][20] = CreatePlayerTextDraw(playerid, 480.698486, 396.951202, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][20], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][20], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][20], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][20], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][20], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][20], 180);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][20], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][20], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][20], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][20], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][20], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][20], 0);

				PhoneTD[playerid][21] = CreatePlayerTextDraw(playerid, 517.198608, 396.926361, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][21], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][21], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][21], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][21], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][21], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][21], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][21], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][21], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][21], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][21], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][21], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][21], 0);

				PhoneTD[playerid][22] = CreatePlayerTextDraw(playerid, 553.398925, 396.876251, "box");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][22], 0.000000, 1.749997);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][22], 0.000000, 22.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][22], 2);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][22], -1);
				PlayerTextDrawUseBox(playerid, PhoneTD[playerid][22], 1);
				PlayerTextDrawBoxColor(playerid, PhoneTD[playerid][22], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][22], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][22], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][22], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][22], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][22], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][22], 0);

				PhoneTD[playerid][23] = CreatePlayerTextDraw(playerid, 508.000000, 331.750000, "LD_CHAT:goodcha"); //App SMS
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][23], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][23], 17.000000, 13.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][23], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][23], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][23], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][23], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][23], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][23], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][23], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][23], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][23], 1);

				PhoneTD[playerid][24] = CreatePlayerTextDraw(playerid, 459.000000, 327.375000, ""); //App Call
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][24], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][24], 51.000000, 23.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][24], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][24], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][24], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][24], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][24], -256);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][24], 5);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][24], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][24], 0);
				PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][24], 330);
				PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][24], 0.000000, 0.000000, 0.000000, 1.000000);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][24], 1);

				PhoneTD[playerid][25] = CreatePlayerTextDraw(playerid, 542.000000, 331.750000, "LD_RCE4:race18"); //App GPS
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][25], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][25], 22.000000, 15.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][25], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][25], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][25], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][25], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][25], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][25], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][25], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][25], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][25], 1);

				PhoneTD[playerid][26] = CreatePlayerTextDraw(playerid, 464.800048, 350.325012, ""); //App Menu
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][26], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][26], 32.000000, 39.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][26], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][26], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][26], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][26], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][26], 0);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][26], 5);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][26], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][26], 0);
				PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][26], 19627);
				PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][26], 90.000000, 0.000000, 19.000000, 1.000000);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][26], 1);

				PhoneTD[playerid][27] = CreatePlayerTextDraw(playerid, 500.000000, 362.375000, ""); //App ADs
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][27], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][27], 33.000000, 13.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][27], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][27], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][27], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][27], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][27], 0);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][27], 5);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][27], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][27], 0);
				PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][27], 1274);
				PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][27], 0.000000, 0.000000, 180.000000, 1.000000);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][27], 1);

				PhoneTD[playerid][28] = CreatePlayerTextDraw(playerid, 541.899902, 362.375000, ""); //App Cam
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][28], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][28], 21.000000, 15.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][28], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][28], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][28], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][28], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][28], 0);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][28], 5);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][28], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][28], 0);
				PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][28], 1253);
				PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][28], 0.000000, 0.000000, 180.000000, 1.000000);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][28], 1);

				PhoneTD[playerid][29] = CreatePlayerTextDraw(playerid, 460.500000, 385.125000, ""); //App Contacts
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][29], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][29], 38.000000, 32.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][29], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][29], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][29], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][29], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][29], 0);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][29], 5);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][29], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][29], 0);
				PlayerTextDrawSetPreviewModel(playerid, PhoneTD[playerid][29], 19776);
				PlayerTextDrawSetPreviewRot(playerid, PhoneTD[playerid][29], 90.000000, 180.000000, 0.000000, 1.000000);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][29], 1);

				PhoneTD[playerid][30] = CreatePlayerTextDraw(playerid, 469.000000, 348.375000, "CALL");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][30], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][30], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][30], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][30], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][30], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][30], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][30], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][30], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][30], 0);

				PhoneTD[playerid][31] = CreatePlayerTextDraw(playerid, 507.000000, 348.375000, "SMS");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][31], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][31], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][31], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][31], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][31], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][31], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][31], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][31], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][31], 0);

				PhoneTD[playerid][32] = CreatePlayerTextDraw(playerid, 543.199951, 348.375000, "GPS");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][32], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][32], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][32], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][32], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][32], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][32], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][32], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][32], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][32], 0);

				PhoneTD[playerid][33] = CreatePlayerTextDraw(playerid, 467.699859, 380.962646, "MENU");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][33], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][33], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][33], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][33], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][33], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][33], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][33], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][33], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][33], 0);

				PhoneTD[playerid][34] = CreatePlayerTextDraw(playerid, 509.499938, 380.962646, "ADs");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][34], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][34], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][34], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][34], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][34], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][34], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][34], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][34], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][34], 0);

				PhoneTD[playerid][35] = CreatePlayerTextDraw(playerid, 543.499938, 380.962646, "CAM");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][35], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][35], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][35], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][35], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][35], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][35], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][35], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][35], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][35], 0);

				PhoneTD[playerid][36] = CreatePlayerTextDraw(playerid, 466.499938, 412.900146, "CONT.");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][36], 0.283000, 0.532500);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][36], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][36], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][36], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][36], 1);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][36], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][36], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][36], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][36], 0);

				for(new i = 14; i < 37; i++)
	    		{
	        		PlayerTextDrawCreated[playerid][i] = 1;
	        	}
			}
	        else if(PhoneTDAction[playerid] == PTD_ACTION_CALL)
	        {
				PhoneTD[playerid][37] = CreatePlayerTextDraw(playerid, 470.500000, 332.187500, "");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][37], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][37], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][37], 150);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][37], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][37], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][37], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][37], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][37], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][37], 0);

				PhoneTD[playerid][38] = CreatePlayerTextDraw(playerid, 471.000000, 418.812500, "LD_SPAC:white"); //X
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][38], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][38], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][38], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][38], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][38], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][38], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][38], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][38], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][38], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][38], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][38], 1);

				PhoneTD[playerid][39] = CreatePlayerTextDraw(playerid, 540.095642, 418.375000, "LD_SPAC:white"); //C
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][39], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][39], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][39], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][39], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][39], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][39], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][39], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][39], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][39], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][39], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][39], 1);

				PhoneTD[playerid][40] = CreatePlayerTextDraw(playerid, 505.602111, 418.375000, "LD_SPAC:white"); //0
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][40], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][40], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][40], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][40], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][40], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][40], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][40], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][40], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][40], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][40], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][40], 1);

				PhoneTD[playerid][41] = CreatePlayerTextDraw(playerid, 539.595642, 396.973693, "LD_SPAC:white"); //9
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][41], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][41], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][41], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][41], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][41], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][41], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][41], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][41], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][41], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][41], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][41], 1);

				PhoneTD[playerid][42] = CreatePlayerTextDraw(playerid, 505.595855, 396.798736, "LD_SPAC:white"); //8
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][42], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][42], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][42], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][42], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][42], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][42], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][42], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][42], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][42], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][42], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][42], 1);

				PhoneTD[playerid][43] = CreatePlayerTextDraw(playerid, 470.695831, 397.236236, "LD_SPAC:white"); //7
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][43], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][43], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][43], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][43], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][43], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][43], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][43], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][43], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][43], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][43], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][43], 1);

				PhoneTD[playerid][44] = CreatePlayerTextDraw(playerid, 471.196166, 375.273864, "LD_SPAC:white"); //4
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][44], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][44], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][44], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][44], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][44], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][44], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][44], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][44], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][44], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][44], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][44], 1);

				PhoneTD[playerid][45] = CreatePlayerTextDraw(playerid, 505.696380, 375.098907, "LD_SPAC:white"); //5
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][45], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][45], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][45], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][45], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][45], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][45], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][45], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][45], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][45], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][45], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][45], 1);

				PhoneTD[playerid][46] = CreatePlayerTextDraw(playerid, 539.596252, 374.961425, "LD_SPAC:white"); //6
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][46], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][46], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][46], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][46], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][46], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][46], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][46], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][46], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][46], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][46], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][46], 1);

				PhoneTD[playerid][47] = CreatePlayerTextDraw(playerid, 539.096252, 353.436340, "LD_SPAC:white"); //3
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][47], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][47], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][47], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][47], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][47], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][47], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][47], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][47], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][47], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][47], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][47], 1);

				PhoneTD[playerid][48] = CreatePlayerTextDraw(playerid, 505.596252, 353.436340, "LD_SPAC:white"); //2
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][48], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][48], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][48], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][48], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][48], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][48], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][48], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][48], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][48], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][48], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][48], 1);

				PhoneTD[playerid][49] = CreatePlayerTextDraw(playerid, 471.296295, 353.436340, "LD_SPAC:white"); //1
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][49], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][49], 21.000000, 19.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][49], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][49], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][49], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][49], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][49], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][49], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][49], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][49], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][49], 1);

				PhoneTD[playerid][50] = CreatePlayerTextDraw(playerid, 479.800079, 354.500000, "1");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][50], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][50], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][50], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][50], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][50], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][50], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][50], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][50], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][50], 0);

				PhoneTD[playerid][51] = CreatePlayerTextDraw(playerid, 512.500122, 354.500000, "2");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][51], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][51], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][51], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][51], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][51], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][51], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][51], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][51], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][51], 0);

				PhoneTD[playerid][52] = CreatePlayerTextDraw(playerid, 546.000122, 354.474945, "3");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][52], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][52], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][52], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][52], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][52], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][52], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][52], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][52], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][52], 0);

				PhoneTD[playerid][53] = CreatePlayerTextDraw(playerid, 478.100280, 376.375000, "4");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][53], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][53], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][53], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][53], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][53], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][53], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][53], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][53], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][53], 0);

				PhoneTD[playerid][54] = CreatePlayerTextDraw(playerid, 512.600280, 376.412475, "5");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][54], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][54], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][54], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][54], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][54], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][54], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][54], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][54], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][54], 0);

				PhoneTD[playerid][55] = CreatePlayerTextDraw(playerid, 546.000183, 376.274993, "6");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][55], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][55], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][55], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][55], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][55], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][55], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][55], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][55], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][55], 0);

				PhoneTD[playerid][56] = CreatePlayerTextDraw(playerid, 479.000183, 398.149993, "7");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][56], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][56], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][56], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][56], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][56], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][56], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][56], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][56], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][56], 0);

				PhoneTD[playerid][57] = CreatePlayerTextDraw(playerid, 512.100524, 397.812500, "8");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][57], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][57], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][57], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][57], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][57], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][57], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][57], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][57], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][57], 0);

				PhoneTD[playerid][58] = CreatePlayerTextDraw(playerid, 546.700500, 397.912506, "9");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][58], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][58], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][58], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][58], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][58], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][58], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][58], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][58], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][58], 0);

				PhoneTD[playerid][59] = CreatePlayerTextDraw(playerid, 512.900329, 419.188751, "0");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][59], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][59], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][59], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][59], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][59], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][59], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][59], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][59], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][59], 0);

				PhoneTD[playerid][60] = CreatePlayerTextDraw(playerid, 478.198486, 419.188751, "X");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][60], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][60], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][60], -16777086);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][60], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][60], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][60], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][60], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][60], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][60], 0);

				PhoneTD[playerid][61] = CreatePlayerTextDraw(playerid, 546.792053, 419.188751, "C");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][61], 0.400000, 1.600000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][61], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][61], 16711810);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][61], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][61], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][61], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][61], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][61], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][61], 0);

				PhoneTD[playerid][62] = CreatePlayerTextDraw(playerid, 553.500000, 336.125000, "LD_BEAT:left"); //Dial - delete
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][62], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][62], 18.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][62], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][62], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][62], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][62], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][62], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][62], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][62], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][62], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][62], 1);

	            format(DialogInputNumber[playerid], 11, "");
		        PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogInputNumber[playerid]);
				for(new i = 37; i < 63; i++)
	    		{
	        		PlayerTextDrawCreated[playerid][i] = 1;
	        	}
	        }
	        else if(PhoneTDAction[playerid] == PTD_ACTION_SMS)
	        {
				PhoneTD[playerid][63] = CreatePlayerTextDraw(playerid, 462.799743, 331.299438, "LD_SPAC:white"); //SMS 1
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][63], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][63], 108.000000, 18.300006);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][63], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][63], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][63], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][63], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][63], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][63], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][63], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][63], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][63], 1);

				PhoneTD[playerid][64] = CreatePlayerTextDraw(playerid, 462.799743, 351.900695, "LD_SPAC:white"); //SMS 2
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][64], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][64], 108.000000, 18.300006);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][64], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][64], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][64], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][64], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][64], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][64], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][64], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][64], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][64], 1);

				PhoneTD[playerid][65] = CreatePlayerTextDraw(playerid, 462.799743, 372.901977, "LD_SPAC:white"); //SMS 3
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][65], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][65], 108.000000, 18.300006);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][65], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][65], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][65], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][65], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][65], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][65], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][65], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][65], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][65], 1);

				PhoneTD[playerid][66] = CreatePlayerTextDraw(playerid, 462.799743, 394.003265, "LD_SPAC:white"); //SMS 4
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][66], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][66], 108.000000, 18.300006);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][66], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][66], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][66], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][66], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][66], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][66], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][66], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][66], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][66], 1);

				PhoneTD[playerid][67] = CreatePlayerTextDraw(playerid, 462.799743, 414.804534, "LD_SPAC:white"); //SMS 5
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][67], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][67], 108.000000, 18.300006);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][67], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][67], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][67], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][67], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][67], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][67], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][67], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][67], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][67], 1);

				PhoneTD[playerid][68] = CreatePlayerTextDraw(playerid, 526.199035, 435.154815, "LD_SPAC:white"); //BACK
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][68], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][68], 42.000000, 18.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][68], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][68], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][68], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][68], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][68], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][68], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][68], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][68], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][68], 1);

				PhoneTD[playerid][69] = CreatePlayerTextDraw(playerid, 540.799987, 438.537475, "BACK");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][69], 0.178999, 0.794998);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][69], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][69], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][69], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][69], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][69], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][69], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][69], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][69], 0);

				PhoneTD[playerid][70] = CreatePlayerTextDraw(playerid, 466.000000, 333.062500, "Sender:_686932~n~Jel_dolazis_brate?");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][70], 0.277999, 0.738125);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][70], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][70], 140);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][70], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][70], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][70], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][70], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][70], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][70], 0);

				PhoneTD[playerid][71] = CreatePlayerTextDraw(playerid, 466.200042, 354.062500, "Sender:_686932~n~Jel_dolazis_brate?");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][71], 0.277999, 0.738125);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][71], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][71], 140);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][71], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][71], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][71], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][71], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][71], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][71], 0);

				PhoneTD[playerid][72] = CreatePlayerTextDraw(playerid, 466.100097, 374.625000, "Sender:_686932~n~Jel_dolazis_brate?");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][72], 0.277999, 0.738125);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][72], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][72], 140);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][72], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][72], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][72], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][72], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][72], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][72], 0);

				PhoneTD[playerid][73] = CreatePlayerTextDraw(playerid, 466.300048, 395.650054, "Sender:_686932~n~Jel_dolazis_brate?");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][73], 0.277999, 0.738125);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][73], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][73], 140);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][73], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][73], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][73], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][73], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][73], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][73], 0);

				PhoneTD[playerid][74] = CreatePlayerTextDraw(playerid, 466.000030, 416.175079, "Sender:_686932~n~Jel_dolazis_brate?");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][74], 0.277999, 0.738125);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][74], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][74], 140);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][74], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][74], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][74], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][74], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][74], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][74], 0);

				PhoneTD[playerid][75] = CreatePlayerTextDraw(playerid, 462.999542, 435.154815, "LD_SPAC:white"); //NEW SMS
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][75], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][75], 42.000000, 18.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][75], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][75], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][75], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][75], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][75], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][75], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][75], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][75], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][75], 1);

				PhoneTD[playerid][76] = CreatePlayerTextDraw(playerid, 470.799987, 438.537475, "NEW_SMS");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][76], 0.178999, 0.794998);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][76], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][76], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][76], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][76], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][76], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][76], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][76], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][76], 0);

				LoadSMS(playerid);

				for(new i = 63; i < 77; i++)
	    		{
	        		PlayerTextDrawCreated[playerid][i] = 1;
	        	}
	        }
	        else if(PhoneTDAction[playerid] == PTD_ACTION_CONT)
	        {
				PhoneTD[playerid][77] = CreatePlayerTextDraw(playerid, 462.199707, 326.999176, "LD_SPAC:white"); //Kontakt 1
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][77], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][77], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][77], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][77], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][77], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][77], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][77], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][77], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][77], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][77], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][77], 1);

				PhoneTD[playerid][78] = CreatePlayerTextDraw(playerid, 462.199707, 337.061676, "LD_SPAC:white"); //Kontakt 2
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][78], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][78], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][78], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][78], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][78], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][78], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][78], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][78], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][78], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][78], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][78], 1);

				PhoneTD[playerid][79] = CreatePlayerTextDraw(playerid, 462.199707, 347.024169, "LD_SPAC:white"); //Kontakt 3
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][79], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][79], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][79], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][79], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][79], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][79], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][79], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][79], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][79], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][79], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][79], 1);

				PhoneTD[playerid][80] = CreatePlayerTextDraw(playerid, 462.199737, 357.086669, "LD_SPAC:white"); //Kontakt 4
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][80], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][80], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][80], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][80], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][80], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][80], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][80], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][80], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][80], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][80], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][80], 1);

				PhoneTD[playerid][81] = CreatePlayerTextDraw(playerid, 462.199737, 367.149169, "LD_SPAC:white"); //Kontakt 5
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][81], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][81], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][81], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][81], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][81], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][81], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][81], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][81], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][81], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][81], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][81], 1);

				PhoneTD[playerid][82] = CreatePlayerTextDraw(playerid, 462.199737, 377.349151, "LD_SPAC:white"); //Kontakt 6
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][82], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][82], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][82], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][82], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][82], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][82], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][82], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][82], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][82], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][82], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][82], 1);

				PhoneTD[playerid][83] = CreatePlayerTextDraw(playerid, 462.499725, 387.886627, "LD_SPAC:white"); //Kontakt 7
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][83], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][83], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][83], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][83], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][83], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][83], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][83], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][83], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][83], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][83], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][83], 1);

				PhoneTD[playerid][84] = CreatePlayerTextDraw(playerid, 462.299743, 398.424102, "LD_SPAC:white"); //Kontakt 8
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][84], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][84], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][84], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][84], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][84], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][84], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][84], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][84], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][84], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][84], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][84], 1);

				PhoneTD[playerid][85] = CreatePlayerTextDraw(playerid, 462.299743, 409.061584, "LD_SPAC:white"); //Kontakt 9
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][85], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][85], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][85], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][85], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][85], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][85], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][85], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][85], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][85], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][85], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][85], 1);

				PhoneTD[playerid][86] = CreatePlayerTextDraw(playerid, 462.199768, 419.561584, "LD_SPAC:white"); //Kontakt 10
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][86], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][86], 111.000000, 9.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][86], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][86], -126);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][86], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][86], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][86], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][86], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][86], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][86], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][86], 1);

				PhoneTD[playerid][87] = CreatePlayerTextDraw(playerid, 465.500000, 326.500000, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][87], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][87], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][87], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][87], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][87], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][87], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][87], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][87], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][87], 0);

				PhoneTD[playerid][88] = CreatePlayerTextDraw(playerid, 465.500000, 336.562500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][88], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][88], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][88], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][88], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][88], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][88], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][88], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][88], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][88], 0);

				PhoneTD[playerid][89] = CreatePlayerTextDraw(playerid, 466.000000, 346.625000, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][89], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][89], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][89], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][89], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][89], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][89], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][89], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][89], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][89], 0);

				PhoneTD[playerid][90] = CreatePlayerTextDraw(playerid, 466.000000, 356.687500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][90], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][90], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][90], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][90], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][90], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][90], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][90], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][90], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][90], 0);

				PhoneTD[playerid][91] = CreatePlayerTextDraw(playerid, 466.000000, 366.750000, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][91], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][91], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][91], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][91], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][91], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][91], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][91], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][91], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][91], 0);

				PhoneTD[playerid][92] = CreatePlayerTextDraw(playerid, 466.000000, 376.812500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][92], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][92], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][92], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][92], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][92], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][92], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][92], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][92], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][92], 0);

				PhoneTD[playerid][93] = CreatePlayerTextDraw(playerid, 465.500000, 387.312500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][93], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][93], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][93], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][93], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][93], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][93], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][93], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][93], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][93], 0);

				PhoneTD[playerid][94] = CreatePlayerTextDraw(playerid, 465.500000, 397.812500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][94], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][94], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][94], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][94], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][94], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][94], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][94], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][94], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][94], 0);

				PhoneTD[playerid][95] = CreatePlayerTextDraw(playerid, 466.000000, 407.875000, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][95], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][95], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][95], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][95], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][95], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][95], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][95], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][95], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][95], 0);

				PhoneTD[playerid][96] = CreatePlayerTextDraw(playerid, 466.000000, 418.812500, "Ime_kontakta");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][96], 0.282500, 0.886875);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][96], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][96], 255);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][96], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][96], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][96], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][96], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][96], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][96], 0);

				PhoneTD[playerid][97] = CreatePlayerTextDraw(playerid, 462.999542, 435.154815, "LD_SPAC:white"); //NEW CONTACT
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][97], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][97], 42.000000, 18.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][97], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][97], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][97], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][97], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][97], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][97], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][97], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][97], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][97], 1);

				PhoneTD[playerid][98] = CreatePlayerTextDraw(playerid, 470.799987, 438.537475, "NEW_C.");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][98], 0.178999, 0.794998);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][98], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][98], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][98], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][98], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][98], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][98], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][98], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][98], 0);

				PhoneTD[playerid][99] = CreatePlayerTextDraw(playerid, 526.199035, 435.154815, "LD_SPAC:white"); //BACK
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][99], 0.000000, 0.000000);
				PlayerTextDrawTextSize(playerid, PhoneTD[playerid][99], 42.000000, 18.000000);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][99], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][99], 130);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][99], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][99], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][99], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][99], 4);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][99], 0);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][99], 0);
				PlayerTextDrawSetSelectable(playerid, PhoneTD[playerid][99], 1);

				PhoneTD[playerid][100] = CreatePlayerTextDraw(playerid, 540.799987, 438.537475, "BACK");
				PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][100], 0.178999, 0.794998);
				PlayerTextDrawAlignment(playerid, PhoneTD[playerid][100], 1);
				PlayerTextDrawColor(playerid, PhoneTD[playerid][100], -1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][100], 0);
				PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][100], 0);
				PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][100], 255);
				PlayerTextDrawFont(playerid, PhoneTD[playerid][100], 1);
				PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][100], 1);
				PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][100], 0);

				for(new i = 77; i < 101; i++)
	    		{
	        		PlayerTextDrawCreated[playerid][i] = 1;
	        	}

	        	SetContactVars(playerid);
	        }
		}

		if(PlayerMobile[playerid][pPhoneMask] != 0)
		{
	        PhoneTD[playerid][101] = CreatePlayerTextDraw(playerid, 454.800140, 307.637603, "LD_SPAC:white");
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][101], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][101], 124.000000, 2.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][101], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][101], PlayerMobile[playerid][pPhoneMask]);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][101], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][101], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][101], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][101], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][101], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][101], 0);

			PhoneTD[playerid][102] = CreatePlayerTextDraw(playerid, 453.600067, 307.637603, "LD_SPAC:white");
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][102], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][102], 2.000000, 156.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][102], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][102], PlayerMobile[playerid][pPhoneMask]);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][102], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][102], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][102], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][102], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][102], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][102], 0);

			PhoneTD[playerid][103] = CreatePlayerTextDraw(playerid, 578.199829, 307.637603, "LD_SPAC:white");
			PlayerTextDrawLetterSize(playerid, PhoneTD[playerid][103], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, PhoneTD[playerid][103], 2.000000, 156.000000);
			PlayerTextDrawAlignment(playerid, PhoneTD[playerid][103], 1);
			PlayerTextDrawColor(playerid, PhoneTD[playerid][103], PlayerMobile[playerid][pPhoneMask]);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][103], 0);
			PlayerTextDrawSetOutline(playerid, PhoneTD[playerid][103], 0);
			PlayerTextDrawBackgroundColor(playerid, PhoneTD[playerid][103], 255);
			PlayerTextDrawFont(playerid, PhoneTD[playerid][103], 4);
			PlayerTextDrawSetProportional(playerid, PhoneTD[playerid][103], 0);
			PlayerTextDrawSetShadow(playerid, PhoneTD[playerid][103], 0);

			for(new i = 101; i < PHONE_TEXTDRAWS; i++)
			{
	    		PlayerTextDrawCreated[playerid][i] = 1;
	    	}
    	}

	    for(new i = 0; i < PHONE_TEXTDRAWS; i++)
	    {
	        if(PlayerTextDrawCreated[playerid][i] == 1) PlayerTextDrawShow(playerid, PhoneTD[playerid][i]);
	    }
	}
	else if(phaction == PHONE_HIDE)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBILE_OBJECT_SLOT))
			RemovePlayerAttachedObject( playerid, MOBILE_OBJECT_SLOT);
	    for(new i = 0; i < PHONE_TEXTDRAWS; i++)
	    {
	        PlayerTextDrawHide(playerid, PhoneTD[playerid][i]);
	        PlayerTextDrawDestroy(playerid, PhoneTD[playerid][i]);
	        PlayerTextDrawCreated[playerid][i] = 0;
			PhoneTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	    }
	}
	else if(phaction == PHONE_NEXT)
	{
		Player_SetPhoneStatus(playerid, PHONE_NEXT);
		for(new i = 0; i < PHONE_TEXTDRAWS; i++)
	    {
	        PlayerTextDrawHide(playerid, PhoneTD[playerid][i]);
	        PlayerTextDrawDestroy(playerid, PhoneTD[playerid][i]);
	        PlayerTextDrawCreated[playerid][i] = 0;
			PhoneTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	    }
	}
	else if(phaction == PHONE_ON || phaction == PHONE_OFF)
	{
	    if(Player_PhoneStatus(playerid) == PHONE_SHOW) 
			PhoneAction(playerid, PHONE_SHOW);
	}
	return 1;
}

stock GetContactNumberName(playerid, numberstring[])
{
    new 
		ContactNo = strval(numberstring),
		CntNumbSTR[MAX_CONTACT_LEN];

    foreach(new i: MobileContacts[playerid])
	{
	    if(PlayerContactNumber[playerid][i] == ContactNo) 
			return PlayerContactName[playerid][i];
	}
	format(CntNumbSTR, MAX_CONTACT_LEN, "%d", ContactNo);
	return CntNumbSTR;
}

stock GetContactNumberNameEx(playerid, ContactNo)
{
	new 
		CntNumbSTR[MAX_CONTACT_LEN],
		bool:found = false;

    foreach(new i: MobileContacts[playerid])
	{
	    if(PlayerContactNumber[playerid][i] == ContactNo)
		{
			strreplace(PlayerContactName[playerid][i], '_', ' ');
			format(CntNumbSTR, MAX_CONTACT_LEN, "%s", PlayerContactName[playerid][i]);
			strreplace(PlayerContactName[playerid][i], ' ', '_');
			found = true;
			break;
		}
	}
	if(!found)
		format(CntNumbSTR, sizeof(CntNumbSTR), "%d", ContactNo);
	return CntNumbSTR;
}

stock ReloadSMS(playerid)
{
    for(new i = 0; i < 5; i++)
	{
		format(SMSInfo[playerid][i][sText], 128, "");
		format(SMSInfo[playerid][i][sTime], 32, "");
		SMSInfo[playerid][i][sType] = -1;
		SMSInfo[playerid][i][sNumber] = -1;
		SMSInfo[playerid][i][sRead] = 0;
	}
	return 1;
}

stock PhoneMaskMenu(playerid)
{
    new phmaskstr[1024];
	for(new i = 0; i < sizeof(MaskColors); i++)
	{
		format(phmaskstr, sizeof(phmaskstr), "%s{%06x}%s\n", phmaskstr, MaskColors[i][0] >>> 8, MaskColors[i][1]);
	}
	ShowPlayerDialog(playerid, DIALOG_MOBILE_MASKS, DIALOG_STYLE_LIST, "MOBITEL - POZADINA", phmaskstr, "Choose", "Exit");
	return 1;
}

stock PhoneTDVars()
{
	TDPhoneDial[49] = 1;
	TDPhoneDial[48] = 2;
	TDPhoneDial[47] = 3;
	TDPhoneDial[44] = 4;
	TDPhoneDial[45] = 5;
	TDPhoneDial[46] = 6;
	TDPhoneDial[43] = 7;
	TDPhoneDial[42] = 8;
	TDPhoneDial[41] = 9;
	TDPhoneDial[40] = 0;
	return 1;
}

stock ShowGPS(playerid)
{
	if(Player_IsWorkingJob(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
	if(Player_GpsActivated(playerid))
	{
		DisablePlayerCheckpoint(playerid);

		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Deaktivirali ste stari GPS.");
		Player_SetGpsActivated(playerid, false);
		return 1;
	}
	GPS_DialogShow(playerid);
	return (true);
}

stock SetContactVars(playerid)
{
	for(new i = 0; i < MAX_MOBILE_CONTACTS; i++)
	{
	    strreplace(PlayerContactName[playerid][i], ' ', '_');
		strreplace(PlayerContactName[playerid][i], '~', '-');

		if(PlayerContactNumber[playerid][i] != 0) 
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][87+i], PlayerContactName[playerid][i]);
		else PlayerTextDrawSetString(playerid, PhoneTD[playerid][87+i], "N/A");
	}
	return 1;
}

stock ResetMobileVariables(playerid)
{
	stop PlayerMobileRingTimer[playerid];

	SelfieAngle[playerid]		= 0.0;
	SelfieHeight[playerid]	= 0.0;
	CallingId[playerid] 		= 999;
	StartCallTimestamp[playerid] = 0;
	PlayerCallPlayer[playerid] 	= INVALID_PLAYER_ID;
	SpeakerPhone[playerid] 		= false;
	ContactEditing[playerid]  = -1;
	PhoneUpdateTick[playerid]	= 0;

	HidePlayerMobile(playerid);

	ReloadSMS(playerid);

    Player_SetMobileOn(playerid, true);
	Bit1_Set( gr_PlayerTakingSelfie , playerid, false);
	Bit1_Set( gr_PlayerUsingPhonebooth		, playerid, false);
	Bit8_Set( gr_RingingTime		, playerid, 0);
	Bit8_Set( gr_MobileContactSlot 	, playerid, 0);
	return 1;
}

stock ResetMobileContacts(playerid)
{
	for(new i = 0; i < MAX_MOBILE_CONTACTS; i++)
	{
		PlayerContactSQL[playerid][i] = -1;
		PlayerContactName[playerid][i][0] = EOS;
		PlayerContactNumber[playerid][i] = 0;
	}
	Iter_Clear(MobileContacts[playerid]);
	return 1;
}

stock static GetPlayerTalkingOnPhone(extradata = -1)
{
	new
		playerid = -1;
	if(extradata == -1)
		return -1;

	if(CallingId[extradata] != 999 || PlayerCallPlayer[extradata] != INVALID_PLAYER_ID)
		playerid = extradata;
	return playerid;
}

stock IsAtGovornica(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(IsPlayerInRangeOfPoint(playerid,3.0,	1723.0785,-1721.2642,13.5469) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	1808.5774,-1599.2645,13.5469) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	1804.7942,-1571.2401,13.4530) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	2069.4841,-1766.6123,13.5627) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	638.0044,-1227.5542,18.1385) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	523.1611,-1524.7767,14.6955) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	302.1201,-1592.7273,32.8109) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	1546.0200,-1667.7655,13.5659) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	2109.9226, -1790.7629, 13.2324) ||
			IsPlayerInRangeOfPoint(playerid,3.0,	2109.9324,-1790.2938,13.5547) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,	1711.4021,-1605.5591,13.5469))	{
			return 1;
		}
 	}
	return 0;
}

stock IsPlayerInWater(playerid)
{
    new Float:waterZ;
    GetPlayerPos(playerid, waterZ, waterZ, waterZ);
    if(waterZ < 0.7) switch(GetPlayerAnimationIndex(playerid)) { case 1543,1538,1539: return 1; }
    if(GetPlayerDistanceFromPoint(playerid,-965,2438,42) <= 700 && waterZ < 45) return 1;
    new Float:water_places[][] =
    {
        {25.0,  2313.0, -1417.0,        23.0},
        {15.0,  1280.0, -773.0,         1082.0},
        {15.0,  1279.0, -804.0,         86.0},
        {20.0,  1094.0, -674.0,         111.0},
        {26.0,  194.0,  -1232.0,        76.0},
        {25.0,  2583.0, 2385.0,         15.0},
        {25.0,  225.0,  -1187.0,        73.0},
        {50.0,  1973.0, -1198.0,        17.0}
    };
    for(new wt = 0; wt < sizeof water_places; wt++)
            if(GetPlayerDistanceFromPoint(playerid, water_places[wt][1], water_places[wt][2], water_places[wt][3]) <= water_places[wt][0]) return 1;
    return 0;
}

stock SendSMS(playerid, recnumber, smsmessage[])
{
	if(GetPlayerSignal(playerid) < 1) return SendMessage( playerid, MESSAGE_TYPE_ERROR, "** No signal **");
	//if(PlayerInfo[playerid][pMobileMoney] <= 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate dovoljno novaca na racunu!");

    new gplayerid = INVALID_PLAYER_ID;
	if(recnumber == PlayerMobile[playerid][pMobileNumber]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Ne mozete poslati poruku sami sebi!");
	foreach(new i : Player)
	{
		if(PlayerMobile[i][pMobileNumber]) 
		{
			if(PlayerMobile[i][pMobileNumber] == recnumber) 
			{
				gplayerid = i;
				break;
			}
		}
	}
	if(gplayerid == INVALID_PLAYER_ID) return SendMessage( playerid, MESSAGE_TYPE_ERROR, "** Linija je zauzeta (( Igrac je offline)) **");
	if(GetPlayerSignal(gplayerid) < 1) return SendMessage( playerid, MESSAGE_TYPE_ERROR, "** Povratna poruka (( Primatelj nema signala)) **");

	new
		Float:mobPos[3];
	GetPlayerPos(gplayerid, mobPos[0], mobPos[1], mobPos[2]);
	PlayerPlaySound(gplayerid, 5205, mobPos[0], mobPos[1], mobPos[2]);
	SendInfoMessage(gplayerid, "Dobili ste novu SMS poruku!");

	PlayerMobile[playerid][pMobileCost] ++;
	mysql_fquery(SQL_Handle(), "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
		PlayerMobile[playerid][pMobileCost],
		PlayerInfo[playerid][pSQLID]
	);

	new
	    sms_string[42];

	format(sms_string, 42, "> %s salje poruku.", GetName(playerid));
	SetPlayerChatBubble(playerid, sms_string, COLOR_PURPLE, 20, 10000);
	new NewSMSSlot = -1;
	new smsHour, smsMinute, smsSecond, smsDay, smsMonth, smsYear;
	gettime(smsHour, smsMinute, smsSecond);
	getdate(smsYear, smsMonth, smsDay);

	for(new i = 0; i < 5; i++)
	{
	    if(SMSInfo[playerid][i][sNumber] == -1 || SMSInfo[playerid][i][sType] == -1)
	    {
			NewSMSSlot = i;
			break;
	    }
	}
	if(NewSMSSlot == -1)
	{
		format(SMSInfo[playerid][4][sText], 128, SMSInfo[playerid][3][sText]);
		format(SMSInfo[playerid][4][sTime], 32, SMSInfo[playerid][3][sTime]);
		SMSInfo[playerid][4][sType] = SMSInfo[playerid][3][sType];
		SMSInfo[playerid][4][sNumber] = SMSInfo[playerid][3][sNumber];
		format(SMSInfo[playerid][3][sText], 128, SMSInfo[playerid][2][sText]);
		format(SMSInfo[playerid][3][sTime], 32, SMSInfo[playerid][2][sTime]);
		SMSInfo[playerid][3][sType] = SMSInfo[playerid][2][sType];
		SMSInfo[playerid][3][sNumber] = SMSInfo[playerid][2][sNumber];
		format(SMSInfo[playerid][2][sText], 128, SMSInfo[playerid][1][sText]);
		format(SMSInfo[playerid][2][sTime], 32, SMSInfo[playerid][1][sTime]);
		SMSInfo[playerid][2][sType] = SMSInfo[playerid][1][sType];
		SMSInfo[playerid][2][sNumber] = SMSInfo[playerid][1][sNumber];
		format(SMSInfo[playerid][1][sText], 128, SMSInfo[playerid][0][sText]);
		format(SMSInfo[playerid][1][sTime], 32, SMSInfo[playerid][0][sTime]);
		SMSInfo[playerid][1][sType] = SMSInfo[playerid][0][sType];
		SMSInfo[playerid][1][sNumber] = SMSInfo[playerid][0][sNumber];
		NewSMSSlot = 0;
	}
	SMSInfo[playerid][NewSMSSlot][sNumber] = PlayerMobile[gplayerid][pMobileNumber];
	SMSInfo[playerid][NewSMSSlot][sType] = SMS_TYPE_SENT;
 	format(SMSInfo[playerid][NewSMSSlot][sTime], 32, "%d/%d/%d %d:%dh", smsDay, smsMonth, smsYear, smsHour, smsMinute);
 	format(SMSInfo[playerid][NewSMSSlot][sText], 128, smsmessage);
 	LoadSMS(playerid);

	for(new i = 0; i < 5; i++)
	{
	    if(SMSInfo[gplayerid][i][sNumber] == -1 || SMSInfo[gplayerid][i][sType] == -1)
	    {
			NewSMSSlot = i;
			break;
	    }
	}
	if(NewSMSSlot == -1)
	{
		format(SMSInfo[gplayerid][4][sText], 128, SMSInfo[gplayerid][3][sText]);
		format(SMSInfo[gplayerid][4][sTime], 32, SMSInfo[gplayerid][3][sTime]);
		SMSInfo[gplayerid][4][sType] = SMSInfo[gplayerid][3][sType];
		SMSInfo[gplayerid][4][sNumber] = SMSInfo[gplayerid][3][sNumber];
		format(SMSInfo[gplayerid][3][sText], 128, SMSInfo[gplayerid][2][sText]);
		format(SMSInfo[gplayerid][3][sTime], 32, SMSInfo[gplayerid][2][sTime]);
		SMSInfo[gplayerid][3][sType] = SMSInfo[gplayerid][2][sType];
		SMSInfo[gplayerid][3][sNumber] = SMSInfo[gplayerid][2][sNumber];
		format(SMSInfo[gplayerid][2][sText], 128, SMSInfo[gplayerid][1][sText]);
		format(SMSInfo[gplayerid][2][sTime], 32, SMSInfo[gplayerid][1][sTime]);
		SMSInfo[gplayerid][2][sType] = SMSInfo[gplayerid][1][sType];
		SMSInfo[gplayerid][2][sNumber] = SMSInfo[gplayerid][1][sNumber];
		format(SMSInfo[gplayerid][1][sText], 128, SMSInfo[gplayerid][0][sText]);
		format(SMSInfo[gplayerid][1][sTime], 32, SMSInfo[gplayerid][0][sTime]);
		SMSInfo[gplayerid][1][sType] = SMSInfo[gplayerid][0][sType];
		SMSInfo[gplayerid][1][sNumber] = SMSInfo[gplayerid][0][sNumber];
		NewSMSSlot = 0;
	}
	SMSInfo[gplayerid][NewSMSSlot][sNumber] = PlayerMobile[playerid][pMobileNumber];
	SMSInfo[gplayerid][NewSMSSlot][sType] = SMS_TYPE_REC;
 	format(SMSInfo[gplayerid][NewSMSSlot][sTime], 32, "%d/%d/%d %d:%dh", smsDay, smsMonth, smsYear, smsHour, smsMinute);
 	format(SMSInfo[gplayerid][NewSMSSlot][sText], 128, smsmessage);

	// SMS notify

	va_SendClientMessage(gplayerid, COLOR_YELLOW, "[SMS]: %s [Kontakt: %s - %s]", smsmessage, GetContactNumberNameEx(gplayerid, PlayerMobile[playerid][pMobileNumber]), ReturnDate());
	
 	LoadSMS(gplayerid);
	return 1;
}

stock ShowSMS(playerid, smsslotid)
{
	if(smsslotid < 0 || smsslotid > 4) return 1;
	new SMSShowStr[256];
    if(SMSInfo[playerid][smsslotid][sNumber] != -1 && SMSInfo[playerid][smsslotid][sType] != -1)
    {
		if(SMSInfo[playerid][smsslotid][sType] == SMS_TYPE_SENT) format(SMSShowStr, sizeof(SMSShowStr), "Receiver: %d\nTime: %s\n\n%s", SMSInfo[playerid][smsslotid][sNumber], SMSInfo[playerid][smsslotid][sTime], SMSInfo[playerid][smsslotid][sText]);
		else if(SMSInfo[playerid][smsslotid][sType] == SMS_TYPE_REC) format(SMSShowStr, sizeof(SMSShowStr), "Sender: %d\nTime: %s\n\n%s", SMSInfo[playerid][smsslotid][sNumber], SMSInfo[playerid][smsslotid][sTime], SMSInfo[playerid][smsslotid][sText]);
		else return 1;
	    ShowPlayerDialog( playerid, 5002, DIALOG_STYLE_MSGBOX, "MOBILE - SMS", SMSShowStr, "OK", "");
	    if(SMSInfo[playerid][smsslotid][sRead] != 1) SMSInfo[playerid][smsslotid][sRead] = 1;
    }
    else SelectTextDraw(playerid, 0xA3B4C5FF);
	return 1;
}

stock LoadSMS(playerid)
{
	new smsFormat[256], smsTextFormat[128];
	for(new i = 0; i < 5; i++)
	{
	    if(SMSInfo[playerid][i][sNumber] != -1 && SMSInfo[playerid][i][sType] != -1)
	    {
	        format(smsTextFormat, sizeof(smsTextFormat), SMSInfo[playerid][i][sText]);
	        strreplace(smsTextFormat, ' ', '_');
			strreplace(smsTextFormat, '~', '-');
	        strdel(smsTextFormat, 17, strlen(smsTextFormat));
	        format(smsTextFormat, sizeof(smsTextFormat), "%s...", smsTextFormat);
	        if(SMSInfo[playerid][i][sType] == SMS_TYPE_REC) format(smsFormat, sizeof(smsFormat), "Sender:_%d~n~%s", SMSInfo[playerid][i][sNumber], smsTextFormat);
	        else if(SMSInfo[playerid][i][sType] == SMS_TYPE_SENT) format(smsFormat, sizeof(smsFormat), "Receiver:_%d~n~%s", SMSInfo[playerid][i][sNumber], smsTextFormat);
	        if(i == 0) PlayerTextDrawSetString(playerid, PhoneTD[playerid][70], smsFormat);
	        else if(i == 1) PlayerTextDrawSetString(playerid, PhoneTD[playerid][71], smsFormat);
	        else if(i == 2) PlayerTextDrawSetString(playerid, PhoneTD[playerid][72], smsFormat);
	        else if(i == 3) PlayerTextDrawSetString(playerid, PhoneTD[playerid][73], smsFormat);
	        else if(i == 4) PlayerTextDrawSetString(playerid, PhoneTD[playerid][74], smsFormat);
	    }
	    else
	    {
			format(smsFormat, sizeof(smsFormat), "N/A");
	        if(i == 0) PlayerTextDrawSetString(playerid, PhoneTD[playerid][70], smsFormat);
	        else if(i == 1) PlayerTextDrawSetString(playerid, PhoneTD[playerid][71], smsFormat);
	        else if(i == 2) PlayerTextDrawSetString(playerid, PhoneTD[playerid][72], smsFormat);
	        else if(i == 3) PlayerTextDrawSetString(playerid, PhoneTD[playerid][73], smsFormat);
	        else if(i == 4) PlayerTextDrawSetString(playerid, PhoneTD[playerid][74], smsFormat);
	    }
	}
	return 1;
}

stock PhoneCall(playerid, callnumber)
{
    new PTDTextString[12],
		callstr[8];

	if(!Bit1_Get( gr_PlayerUsingPhonebooth, playerid))
	{
		if(!PlayerMobile[playerid][pMobileNumber]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate mobitel!");
		if(GetPlayerSignal(playerid) < 1 && callnumber != 911) return SendMessage( playerid, MESSAGE_TYPE_ERROR, "** No signal **");
	}
	if(callnumber == 911) 
	{ // FD/PD
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

		SendClientMessage(playerid, COLOR_WHITE, "HINT: Sada mozete koristiti T da bi ste razgovarali na telefon, ukucajte /hangup da bi ste prekinuli poziv");
		SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Za policiju recite 'police'{FF8282},a za Hitnu pomoc/Vatrogasce recite 'ambulance'");
		CallingId[playerid] =  911;
		Bit1_Set( gr_CanHangup, playerid, true);
		return 1;
	}
	if(callnumber == 444) 
	{ // Taxisti
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SendClientMessage(playerid, COLOR_RED, "Taxi Dispatcher: Pozdrav, recite nam vasu lokaciju?");
		CallingId[playerid] =  444;
		Bit1_Set( gr_CanHangup, playerid, true);
		return 1;
	}
	if(callnumber == 555) 
	{ // Mehanicari
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SendClientMessage(playerid, COLOR_RED, "Dispatcher: Pozdrav, recite tip vaseg kvara.?");
		CallingId[playerid] =  555;
		Bit1_Set( gr_CanHangup, playerid, true);
		return 1;
	}
	if(callnumber == 32715) // Weapon Package Order
	{ 
		if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid))
			return SendClientMessage(playerid, COLOR_RED, "[!] Ne smijete to koristiti!");

	    if(!IsAtGovornica(playerid)) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nisi kod telefonske govornice!");
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Los Santos Sanitary, izvolite?");
		CallingId[playerid] =  32715;
		Bit1_Set( gr_CanHangup, playerid, true);
		return 1;
	}
	if(callnumber == 222) 
	{
		new
			lineIndex = -1;
		for( new i = 0; i < 10; i++) 
		{
			if(!NewsPhone[i][npNumber]) 
			{
				lineIndex = i;
				break;
			}
		}
		if(lineIndex == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sve su linije zauzte!");
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SendClientMessage(playerid, COLOR_RED, "Tajnica: Trenutno cekate svoj red za eter!");
		CallingId[playerid] = 222;
		NewsPhone[lineIndex][npNumber] 		= PlayerMobile[playerid][pMobileNumber];
		NewsPhone[lineIndex][npPlayerID] 	= playerid;
		PhoneLine[playerid] = lineIndex;
		return 1;
	}
	valstr(callstr, callnumber);
	if(strlen(callstr) == 6) 
	{
		new
			gplayerid = INVALID_PLAYER_ID;

		if(callnumber == PlayerMobile[playerid][pMobileNumber]) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete zvati sami sebe!");
		
		foreach(new i : Player) 
		{
			if(PlayerMobile[i][pMobileNumber] == callnumber && callnumber != 0) 
			{
				gplayerid = i;

				if(PlayerJail[gplayerid][pJailed] != 0) 
					return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Osoba se ne moze javiti.");
				if(GetPlayerSignal(gplayerid) < 1 || IsPlayerReconing(gplayerid) || GetPlayerTalkingOnPhone(gplayerid) != -1 || !Player_MobileOn(gplayerid))
				{
					format(PTDTextString, sizeof(PTDTextString), "~r~ZAUZETO");
					PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], PTDTextString);
					DialogInputNumber[playerid] = "ZAUZETO";
					PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
					PlayerTextDrawCreated[playerid][62] = 0;
					return 1;
				}

				// Var set
				PlayerCallPlayer[playerid] = gplayerid;
				PlayerCallPlayer[gplayerid] = playerid;
				Bit8_Set( gr_RingingTime, gplayerid, 15);
				Bit1_Set( gr_CanHangup, playerid, true);
				PlayerMobileRingTimer[gplayerid] = repeat MobileRinging(gplayerid);
				new tmpString[70];

				if(Bit1_Get( gr_PlayerUsingPhonebooth, playerid))
				{
					format(tmpString, 70, "* %s uzima slusalicu sa govornice i stavlja na uho.", GetName( playerid, true));
					ProxDetector(30.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(tmpString, 70, "Vas mobitel zvoni, ukucajte (/Pickup) Broj: Govornica");
					SendClientMessage(gplayerid, COLOR_YELLOW, tmpString);
				}
				else {
					format(tmpString, 70, "* %s vadi mobitel i stavlja ga na uho.", GetName( playerid, true));
					ProxDetector(30.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(tmpString, 70, "Vas mobitel zvoni, ukucajte (/Pickup) | Kontakt: %s", GetContactNumberNameEx(gplayerid, PlayerMobile[playerid][pMobileNumber]));
					SendClientMessage(gplayerid, COLOR_YELLOW, tmpString);
				}

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				// Chat Bubble
				format( tmpString, 70, "** Mobitel zvoni **");
				SetPlayerChatBubble(gplayerid, tmpString, COLOR_PURPLE, 20, 10000);

				new Float:mobPos[3];
				GetPlayerPos(gplayerid, mobPos[0], mobPos[1], mobPos[2]);
				PlaySoundForPlayersInRange(20600, 10.0, mobPos[0], mobPos[1], mobPos[2]);
				return 1;
			}
		}
		SendClientMessage( playerid, COLOR_RED, "**(mobitel) ...Zauzeto.. **");
		format(PTDTextString, sizeof(PTDTextString), "~r~ZAUZETO");
		PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], PTDTextString);
		DialogInputNumber[playerid] = "ZAUZETO";
		PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
		PlayerTextDrawCreated[playerid][62] = 0;
	}
	return 1;
}

stock CancelPlayerPhone(playerid)
{
	SetPlayerSpecialAction( playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	if(IsPlayerAttachedObjectSlotUsed(playerid, MOBILE_OBJECT_SLOT))
		RemovePlayerAttachedObject( playerid, MOBILE_OBJECT_SLOT);
	
	HidePlayerMobile(playerid);
	return 1;
}

stock SetTDTime(playerid)
{
    new tdhour, tdminute, tdsecond, tdtimeString[8];
	gettime(tdhour, tdminute, tdsecond);
	if(tdhour < 10)
	{
	    if(tdminute < 10) format(tdtimeString, sizeof(tdtimeString), "0%d:0%d", tdhour, tdminute);
	    else format(tdtimeString, sizeof(tdtimeString), "0%d:%d", tdhour, tdminute);
	}
	else
	{
	    if(tdminute < 10) format(tdtimeString, sizeof(tdtimeString), "%d:0%d", tdhour, tdminute);
	    else format(tdtimeString, sizeof(tdtimeString), "%d:%d", tdhour, tdminute);
	}
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][13], tdtimeString);
	return 1;
}

stock SetTDSignal(playerid)
{
	new ConnTower = ConnectedSignalTower(playerid);
	new TDSignalString[8];
    if(ConnTower == -1) format(TDSignalString, sizeof(TDSignalString), "~r~X");
    else {
	    if(SignalStrength(playerid, ConnTower) == 0) format(TDSignalString, sizeof(TDSignalString), "~r~X");
	    else if(SignalStrength(playerid, ConnTower) == 1) format(TDSignalString, sizeof(TDSignalString), "l----");
	    else if(SignalStrength(playerid, ConnTower) == 2) format(TDSignalString, sizeof(TDSignalString), "ll---");
	    else if(SignalStrength(playerid, ConnTower) == 3) format(TDSignalString, sizeof(TDSignalString), "lll--");
	    else if(SignalStrength(playerid, ConnTower) == 4) format(TDSignalString, sizeof(TDSignalString), "lllll-");
	    else if(SignalStrength(playerid, ConnTower) == 5) format(TDSignalString, sizeof(TDSignalString), "llllll");
    }
	PlayerTextDrawSetString(playerid, PhoneTD[playerid][9], TDSignalString);
	return 1;
}

stock GetPlayerSignal(playerid)
{
    new ConnTower = ConnectedSignalTower(playerid);
    new ConnSignalStr = 0;
	if(ConnTower == -1) return 0;
    ConnSignalStr = SignalStrength(playerid, ConnTower);
	return ConnSignalStr;
}

stock PlayerHangup(playerid)
{
	new giveplayerid = PlayerCallPlayer[playerid];
	
	// pozvatelj
	Bit8_Set( gr_RingingTime, playerid, 0);
	Bit1_Set( gr_CanHangup, playerid, false);
	stop PlayerMobileRingTimer[playerid];
	CallingId[playerid] 	=  999;
	StartCallTimestamp[playerid] = 0;
	SpeakerPhone[playerid] = false;
	CancelPlayerPhone(playerid);
	SendClientMessage( playerid, COLOR_YELLOW, "** Poziv zavrsen **");
	PlayerCallPlayer[playerid] = INVALID_PLAYER_ID;
	Bit1_Set( gr_PlayerUsingPhonebooth		, playerid, false);

	// osoba koju je nazvao
	if(giveplayerid == INVALID_PLAYER_ID) return 1;
	if(!IsPlayerConnected(giveplayerid)) return 1;
	Bit8_Set( gr_RingingTime, giveplayerid, 0);
	Bit1_Set( gr_CanHangup, giveplayerid, false);
	stop PlayerMobileRingTimer[giveplayerid];
	CallingId[giveplayerid] 	=  999;
	StartCallTimestamp[giveplayerid] = 0;
	SpeakerPhone[giveplayerid] = false;
	CancelPlayerPhone(giveplayerid);
	SendClientMessage( giveplayerid, COLOR_YELLOW, "** Poziv zavrsen **");
	PlayerCallPlayer[giveplayerid] = INVALID_PLAYER_ID;
	Bit1_Set( gr_PlayerUsingPhonebooth	, giveplayerid, false);
	return 1;
}

static SendJobMessage(job, color, string[])
{
	foreach (new i : Player) 
	{
		if(PlayerJob[i][pJob] == job)
			SendClientMessage(i, color, string);
	}
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

hook function LoadServerData()
{
	LoadTowerData();
	return continue();
}

hook OnGameModeInit()
{
	PhoneTDVars();
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	HidePlayerMobile(playerid);
	
	if(PlayerCallPlayer[playerid] != INVALID_PLAYER_ID)
		PlayerHangup(playerid);

	ResetMobileVariables(playerid);
	ResetMobileContacts(playerid);
	
	PlayerMobile[playerid][pCryptoNumber]		= 0;
	PlayerMobile[playerid][pMobileNumber]		= 0;
	PlayerMobile[playerid][pMobileModel]		= 0;
	PlayerMobile[playerid][pMobileCost] 		= 0;
	PlayerMobile[playerid][pPhoneBG] 			= -1263225696;
	PlayerMobile[playerid][pPhoneMask] 			= 0;
	return continue(playerid);
}

hook OnPlayerText(playerid, text[])
{
	if(CallingId[playerid] != 999)
	{
		if(strlen(text) > 100)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Tekst ne smije imati vise od 100 znakova!");
			
		new
			idx,
			tmp[128];
		tmp = strtok(text, idx);
		if(CallingId[playerid] == 911) 
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Oprostite ne razumijem, da li trebate policiju ili hitnu pomoc?");
				return 0;
			}
			else if((strcmp("police", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("police"))) {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Spajam vas sa LSPD-om, ostanite na liniji.");
				CallingId[playerid] =  912;
				SendClientMessage(playerid, COLOR_DBLUE, "HITNA LINIJA: Molimo Vas recite nam svoju lokaciju.");
				return 0;
			}
			else if((strcmp("ambulance", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("ambulance"))) {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Spajam vas sa LSFD-om, ostanite na liniji.");
				CallingId[playerid] =  916;
				SendClientMessage(playerid, 0xFF8282AA, "HITNA LINIJA: Molimo Vas recite nam svoju lokaciju.");
				return 0;
			} else {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Oprostite ne razumijem, da li trebate policiju ili hitnu pomoc?");
				return 0;
			}
		}
		if(CallingId[playerid] == 916) 
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Oprostite ali ne razumijem?");
				return 0;
			}
			strcpy(PlayerCrime[playerid][pLocation], text, 100);
			SendClientMessage(playerid, 0xFF8282AA, "HITNA LINIJA:Molimo vas ukratko opisite incident.");
			CallingId[playerid] =  915;
			return 0;
		}
		if(CallingId[playerid] == 915) 
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, 0xFF8282AA, "HITNA LINIJA: Oprostite ali ne razumijem?");
				return 0;
			}
   			new wanted[128];
		    new turner[MAX_PLAYER_NAME];
		    new zone[100];
		   	format( zone, 100, "%s, %s", GetPlayerStreet(playerid), GetPlayerZone(playerid));
		    GetPlayerName(playerid, turner, sizeof(turner));
			SendClientMessage(playerid, COLOR_WHITE, "HITNA LINIJA: Obavijestili smo sve jedinice.");
			SendClientMessage(playerid, COLOR_WHITE, "Jedinica dolazi u sto kracem mogucem roku!");
			SendRadioMessage(2, COLOR_LIGHTRED,"*__________ EMERGENCY CALL (911) __________*");
			format(wanted, sizeof(wanted), "* Pozivatelj: %s || Locirani broj: %d",turner, ( !IsAtGovornica(playerid) ? PlayerMobile[playerid][pMobileNumber] : 0));
			SendRadioMessage(2, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Incident: %s",text);
			SendRadioMessage(2, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Prijavljena lokacija: %s", PlayerCrime[playerid][pLocation]);
			SendRadioMessage(2, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Lokacija broja: %s", zone);
			SendRadioMessage(2, COLOR_WHITE, wanted);
			SendRadioMessage(2, COLOR_LIGHTRED,"________________________________________");
		    SendClientMessage(playerid, COLOR_GRAD2, "Prekinuli su...");
			PlayerHangup(playerid);
			return 0;
		}
		if(CallingId[playerid] == 913) 
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Oprostite ali ne razumijem?");
				return 0;
			}
			new wanted[128],
				turner[MAX_PLAYER_NAME],
				zone[100];

			format( zone, 100, "%s, %s", GetPlayerStreet(playerid), GetPlayerZone(playerid));
			GetPlayerName(playerid, turner, sizeof(turner));

			strmid(PlayerCrime[playerid][pAccusing], text, 0, strlen(text), 255);
			SendClientMessage(playerid, COLOR_WHITE, "HITNA LINIJA: Obavijestili smo sve jedinice.");
			SendClientMessage(playerid, COLOR_WHITE, "Zahvaljujemo na prijavi zlocina.");
         	SendRadioMessage(1, 0x418BFBFF,"* ________ EMERGENCY CALL (911) __________ *");
			SendRadioMessage(3, 0x418BFBFF,"* ________ EMERGENCY CALL (911) __________ *");
			format(wanted, sizeof(wanted), "* Prijavio: %s || Locirani broj: %d", turner, ( !IsAtGovornica(playerid) ? PlayerMobile[playerid][pMobileNumber] : 0));
			SendRadioMessage(1, COLOR_WHITE, wanted);
			SendRadioMessage(3, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Stanje: %s",PlayerCrime[playerid][pAccusing]);
			SendRadioMessage(1, COLOR_WHITE, wanted);
			SendRadioMessage(3, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Prijavljena lokacija: %s", PlayerCrime[playerid][pLocation]);
			SendRadioMessage(1, COLOR_WHITE, wanted);
			SendRadioMessage(3, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "Lokacija broja: %s", zone);
			SendRadioMessage(1, COLOR_WHITE, wanted);
			SendRadioMessage(3, COLOR_WHITE, wanted);
  	        SendRadioMessage(1, 0x418BFBFF, "* __________________________________________ *");
			SendRadioMessage(3, 0x418BFBFF, "* __________________________________________ *");

			PlayerHangup(playerid);
			return 0;
		}
		if(CallingId[playerid] == 912) 
		{
			if(!strlen(tmp)) 
			{
				SendClientMessage(playerid, COLOR_ALLDEPT, "HITNA LINIJA: Oprostite ali ne razumijem?");
				return 0;
			}
			strcpy(PlayerCrime[playerid][pLocation], text, 100);
			SendClientMessage(playerid, 0xFF8282AA, "HITNA LINIJA:Molimo vas ukratko opisite zlocin.");
			CallingId[playerid] =  913;
			return 0;
		}
		if(CallingId[playerid] == 555) 
		{
			if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "Dispatcher: Oprostite ali ne razumijem?"), 0;
			strmid(PlayerCrime[playerid][pAccusing], text, 0, strlen(text), 255);
			SendClientMessage(playerid, COLOR_YELLOW, "Dispatcher: Uredu. Recite vasu trenutnu lokaciju?");
			CallingId[playerid] = 556;
			return 0;
		}
		if(CallingId[playerid] == 32715) 
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Priblizi se tom telefonu kurca te ne cujem.");
				return 0;
			}
            else if(strfind(tmp, "weapons", true) != -1 || strfind(tmp, "weapon", true) != -1 || strfind(tmp, "gun", true) != -1 || strfind(tmp, "guns", true) != -1)
            {
                new buffer[512],
					motd[64];
				format(buffer, sizeof(buffer), "{3C95C2}Weapon\t{3C95C2}Price per bullet\n");
				for( new i = 0; i < MAX_LISTED_WEAPONS; i++)
				{
					format(motd, sizeof(motd), "%s\t%s\n", show_WeaponList[i][wep_Name], FormatNumber(show_WeaponList[i][wep_Price]));
					strcat(buffer, motd, sizeof(buffer));
				}
				ShowPlayerDialog(playerid, DIALOG_PACKAGE_ORDER, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Package - List", buffer, "Select", "Close");
                SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Reci mi sta trebas od ponudjenog?");
                SendClientMessage(playerid, COLOR_RED, "[!] Potrebno je da kroz dialog odaberes sta zelis da sadrzi tvoja narudzba!");
				CallingId[playerid] =  32715;
				return 0;
			}
			else if(strfind(tmp, "droga", true) != -1 || strfind(tmp, "drug", true) != -1 || strfind(tmp, "drugs", true) != -1)
            {
                if(PlayerDrugStatus[playerid][pDrugOrder] > 0)
				{
					va_SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Nazovi me za %d minuta, nemam sad vremena zauzet sam.", PlayerDrugStatus[playerid][pDrugOrder]);
					PlayerHangup(playerid);
					return 0;
				}
				new 
					buffer[512],
					motd[64];
				
				format(buffer, sizeof(buffer), "{3C95C2}Drugs\t{3C95C2}Price per gram\n");
				for( new i = 1; i < sizeof(drugs); i++)
				{
					format(motd, sizeof(motd), "%s\t%s\n", drugs[i][dName], FormatNumber(drugs[i][dPricePG]));
					strcat(buffer, motd, sizeof(buffer));
				}
				ShowPlayerDialog(playerid, DRUG_ORDER_PACKAGE, DIALOG_STYLE_TABLIST, "{3C95C2}* Package - List", buffer, "Select", "Close");
                SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Reci mi sta trebas od ponudjenog?");
                SendClientMessage(playerid, COLOR_RED, "[!] Potrebno je da kroz dialog odaberes sta zelis da sadrzi tvoja narudzba!");
				CallingId[playerid] =  32715;
				return 0;
			}
			else if(strfind(tmp, "pizza", true) != -1 || strfind(tmp, "oruzje", true) != -1 || strfind(tmp, "vatreno oruzje", true) != -1)
            {
                SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Dobili ste pogresan broj. Ugodna ostatak dana!");
				PlayerHangup(playerid);
			}
		 	else 
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): sta mumlas koju picku materinu, znas li normalno izgovorit?");
                PlayerHangup(playerid);
				return 0;
			}
		}
		if(CallingId[playerid] == 556) {
			if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "Dispatcher: Oprostite ali ne razumijem?"), 0;
			new
				wanted[37];
			SendJobMessage(3, 0x418BFBFF, "* ________ EMERGENCY CALL (555) __________ *");
			format(wanted, sizeof(wanted), "* Prijavio: %s", GetName(playerid, false));
			SendJobMessage(3, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "* Tip kvara: %s", PlayerCrime[playerid][pAccusing]);
			SendJobMessage(3, COLOR_WHITE, wanted);
			format(wanted, sizeof(wanted), "* Lokacija: %s", text);
			SendJobMessage(3, COLOR_WHITE, wanted);
			SendJobMessage(3, 0x418BFBFF, "* __________________________________________ *");

			SendClientMessage(playerid, COLOR_YELLOW, "Dispatcher: Aktivnim mehanicarima je javljen vas poziv. Pricekajte na prijavljenoj lokaciji!");
			PlayerHangup(playerid);
			return 0;
		}
		if(CallingId[playerid] == 444) {
			if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "Dispatcher: Oprostite ali ne razumijem?"), 0;
			new dispatcher[37];
			SendJobMessage(6, COLOR_YELLOW, "* ________ DISPATCHER CALL (444) __________ *");
			format(dispatcher, sizeof(dispatcher), "* Pozivaoc: %s.", GetName(playerid, false));
			SendJobMessage(6, COLOR_WHITE, dispatcher);
			format(dispatcher, sizeof(dispatcher), "* Lokacija: %s.", text);
			SendJobMessage(6, COLOR_WHITE, dispatcher);
			SendJobMessage(6, COLOR_YELLOW, "* __________________________________________ *");

			SendClientMessage(playerid, COLOR_YELLOW, "Aktivnim Taxistama je javljen vas poziv. Pricekajte na prijavljenoj lokaciji!");
			PlayerHangup(playerid);
			return 0;
		}
		new
			gplayerid = CallingId[playerid],
			mobileText[144];

		if(Bit1_Get( gr_PlayerUsingPhonebooth, playerid))
			format( mobileText, 144, "%s %s(govornica): %s",
				GetName( playerid, true),
				PrintAccent( playerid),
				text
			);
		else
			format( mobileText, 144, "%s %s(mobitel): %s",
				GetName( playerid, true),
				PrintAccent( playerid),
				text
			);

		RealProxDetector(5.0, playerid, mobileText,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

		if(Bit1_Get( gr_PlayerUsingPhonebooth, playerid))
		{
			format( mobileText, 144, "%s(govornica): %s",
				PrintAccent( playerid),
				text
			);
		}
		else
		{
			format( mobileText, 144, "[%d] %s(mobitel): %s",
				PlayerMobile[playerid][pMobileNumber],
				PrintAccent( playerid),
				text
			);
		}

        if(Player_TappedBy(playerid) != INVALID_PLAYER_ID)
        {
            SendClientMessage(Player_TappedBy(playerid), COLOR_YELLOW, mobileText);
        }
        else if(Player_TappedBy(gplayerid) != INVALID_PLAYER_ID)
        {
            SendClientMessage(Player_TappedBy(gplayerid), COLOR_YELLOW, mobileText);
        }
		format( mobileText, 144, "[%s] %s(mobitel): %s",
			GetContactNumberNameEx(gplayerid, PlayerMobile[playerid][pMobileNumber]),
			PrintAccent( playerid),
			text
		);
		
		if(!SpeakerPhone[gplayerid])
			SendClientMessage( gplayerid, COLOR_YELLOW, mobileText);
		else RealProxDetector(7.5, gplayerid, mobileText,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	}
	return 0;
}


hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(objectid == TowerEditingObj[playerid] && PlayerInfo[playerid][pAdmin] >= 1338)
	{
	    if(response == 1)
		{
			new newtwid = GetFreeTowerID();
			if(newtwid == -1) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemozete kreirati vise signalnih tornjeva!");
			SetTowerInfo(newtwid, TowerEditingNetwork[playerid], x, y, z, rx, ry, rz, TowerEditingRadius[playerid]);
			CreateTower(newtwid);
		    DestroyDynamicObject(objectid);
			CreateTowerObject(newtwid);
			va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Kreirali ste signalni toranj! [ID:%d | SQLID:%d]", newtwid, TowerSQLID(newtwid));
		}
		else if(response == 0)
		{
		    DestroyDynamicObject(objectid);
			va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Signalni toranj nije napravljen jer ste odbacili izmjene!");
		}
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_ANALOG_RIGHT) && !(oldkeys & KEY_ANALOG_RIGHT))
	{
		if(Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			SelfieAngle[playerid] += 0.5;
			if(SelfieAngle[playerid] >= 360.0)
				SelfieAngle[playerid] = 1.5;

			new
				Float:PlayerX, Float:PlayerY, Float:PlayerZ,
				Float:CameraX, Float:CameraY, Float:CameraZ,
				Float:Turn;
			GetPlayerPos( playerid, PlayerX, PlayerY, PlayerZ);

			Turn = 180.0 - SelfieAngle[playerid];

			CameraX = PlayerX + ( SELFIE_DISTANCE * floatcos(Turn, degrees));
			CameraY = PlayerY + ( SELFIE_DISTANCE * floatsin(Turn, degrees));
			CameraZ = PlayerZ + SelfieHeight[playerid];

			SetPlayerFacingAngle( playerid, 90.0 - SelfieAngle[playerid]);
			InterpolateCameraPos( playerid, 	CameraX, CameraY, CameraZ, CameraX, CameraY, CameraZ, 100000, CAMERA_CUT);
			InterpolateCameraLookAt( playerid, 	PlayerX, PlayerY, PlayerZ + 1.0, PlayerX, PlayerY, PlayerZ + SelfieHeight[playerid], 100000, CAMERA_CUT);
		}
	}
	if((newkeys & KEY_ANALOG_LEFT) && !(oldkeys & KEY_ANALOG_LEFT))
	{
		if(Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			SelfieAngle[playerid] -= 0.5;
			if(SelfieAngle[playerid] <= 0.0)
				SelfieAngle[playerid] = 0.0;

			new
				Float:PlayerX, Float:PlayerY, Float:PlayerZ,
				Float:CameraX, Float:CameraY, Float:CameraZ,
				Float:Turn;
			GetPlayerPos( playerid, PlayerX, PlayerY, PlayerZ);

			Turn = 180.0 - SelfieAngle[playerid];

			CameraX = PlayerX + ( SELFIE_DISTANCE * floatcos(Turn, degrees));
			CameraY = PlayerY + ( SELFIE_DISTANCE * floatsin(Turn, degrees));
			CameraZ = PlayerZ + SelfieHeight[playerid];

			SetPlayerFacingAngle( playerid, 90.0 - SelfieAngle[playerid]);
			InterpolateCameraPos( playerid, 	CameraX, CameraY, CameraZ, CameraX, CameraY, CameraZ, 100000, CAMERA_CUT);
			InterpolateCameraLookAt( playerid, 	PlayerX, PlayerY, PlayerZ + 1.0, PlayerX, PlayerY, PlayerZ + SelfieHeight[playerid], 100000, CAMERA_CUT);
		}
	}
	if(PRESSED(KEY_JUMP))
	{
		if(Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			SelfieHeight[playerid] += 0.05;
			if(SelfieHeight[playerid] >= 2.5)
				SelfieHeight[playerid] = SELFIE_HEIGHT;

			new
				Float:PlayerX, Float:PlayerY, Float:PlayerZ,
				Float:CameraX, Float:CameraY, Float:CameraZ,
				Float:Turn;
			GetPlayerPos( playerid, PlayerX, PlayerY, PlayerZ);

			Turn = 180.0 - SelfieAngle[playerid];

			CameraX = PlayerX + ( SELFIE_DISTANCE * floatcos(Turn, degrees));
			CameraY = PlayerY + ( SELFIE_DISTANCE * floatsin(Turn, degrees));
			CameraZ = PlayerZ + SelfieHeight[playerid];

			SetPlayerFacingAngle( playerid, 90.0 - SelfieAngle[playerid]);
			InterpolateCameraPos( playerid, 	CameraX, CameraY, CameraZ, CameraX, CameraY, CameraZ, 100000, CAMERA_CUT);
			InterpolateCameraLookAt( playerid, 	PlayerX, PlayerY, PlayerZ + 1.0, PlayerX, PlayerY, PlayerZ + SelfieHeight[playerid], 100000, CAMERA_CUT);
		}
	}
	if(PRESSED(KEY_CROUCH))
	{
		if(Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			SelfieHeight[playerid] -= 0.05;
			if(SelfieHeight[playerid] <= 0.0)
				SelfieHeight[playerid] = SELFIE_HEIGHT;

			new
				Float:PlayerX, Float:PlayerY, Float:PlayerZ,
				Float:CameraX, Float:CameraY, Float:CameraZ,
				Float:Turn;
			GetPlayerPos( playerid, PlayerX, PlayerY, PlayerZ);

			Turn = 180.0 - SelfieAngle[playerid];

			CameraX = PlayerX + ( SELFIE_DISTANCE * floatcos(Turn, degrees));
			CameraY = PlayerY + ( SELFIE_DISTANCE * floatsin(Turn, degrees));
			CameraZ = PlayerZ + SelfieHeight[playerid];

			SetPlayerFacingAngle( playerid, 90.0 - SelfieAngle[playerid]);
			InterpolateCameraPos( playerid, 	CameraX, CameraY, CameraZ, CameraX, CameraY, CameraZ, 100000, CAMERA_CUT);
			InterpolateCameraLookAt( playerid, 	PlayerX, PlayerY, PlayerZ + 1.0, PlayerX, PlayerY, PlayerZ + SelfieHeight[playerid], 100000, CAMERA_CUT);
		}
	}
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
	    case DIALOG_MOBILE_SMS_CONTACT: {
	        if(!response) return 1;
	        if(strlen(inputtext) < 3 || strlen(inputtext) > 10) return va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_CONTACT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "** Nevazeci broj **\n\nUpisite broj:", "Next", "Abort");
	        if(!IsNumeric(inputtext)) return va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_CONTACT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "** Nevazeci broj **\n\nUpisite broj:", "Next", "Abort");
	        format(DialogInputNumber[playerid], 11, inputtext);
	        va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_TEXT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "Upisite poruku:", "Send", "Abort");
	    }
	    case DIALOG_MOBILE_SMS_TEXT: {
	        if(!response) return 1;
	        if(strlen(inputtext) < 2 || strlen(inputtext) > 63) return va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_TEXT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "** SMS text mora biti u rasponu od 2 do 63 slova! **\n\nUpisite poruku:", "Send", "Abort");
			new pInputNumber = strval(DialogInputNumber[playerid]);
			if(strlen(DialogInputNumber[playerid]) == 6) SendSMS(playerid, pInputNumber, inputtext);
			else va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste unijeli broj mobitela!");
	    }
	    case DIALOG_MOBILE_CALL_CONTACT: {
	        if(!response) return 1;
	        if(strlen(inputtext) < 3 || strlen(inputtext) > 10) return va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_CONTACT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "** Nevazeci broj **\n\nUpisite broj:", "Send", "Abort");
	        if(!IsNumeric(inputtext)) return va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_CONTACT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "** Nevazeci broj **\n\nUpisite broj:", "Send", "Abort");
			new CallNo = strval(inputtext);
			PhoneCall(playerid, CallNo);
	    }
		case DIALOG_MOBILE_MAIN: {
			if(!response) return 1;
			switch( listitem) {
				case 0:
				{
				    if(!Player_MobileOn(playerid))
				        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "VaS mobitel je trenutno iskljucen!");

					new
						tmpString[42];
					format( tmpString, 42, "Trenutni trosak vaseg racuna je: "COL_RED"%d$!",
						PlayerMobile[playerid][pMobileCost]
					);
					ShowPlayerDialog( playerid, 0, DIALOG_STYLE_MSGBOX, "MOBITEL - STANJE RACUNA", tmpString, "Ok", "");
				}
				case 1:
				{
				    if(!Player_MobileOn(playerid))
      					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "VaS mobitel je trenutno iskljucen!");


					if(Bit1_Get( gr_MobileSpeaker, playerid)) {
						GameTextForPlayer( playerid, "~r~Zvucnik iskljucen!", 1000, 1);
						Bit1_Set( gr_MobileSpeaker, playerid, false);
					} else {
						GameTextForPlayer( playerid, "~g~Zvucnik ukljucen!", 1000, 1);
						Bit1_Set( gr_MobileSpeaker, playerid, true);
					}
				}
				case 2:
				{
					new bgstr[1024];
					for(new i = 0; i < sizeof(BackgroundColors); i++)
					{
						format(bgstr, sizeof(bgstr), "%s{%06x}%s\n", bgstr, BackgroundColors[i][0] >>> 8, BackgroundColors[i][1]);
					}
					ShowPlayerDialog(playerid, DIALOG_MOBILE_BACKGROUND, DIALOG_STYLE_LIST, "MOBITEL - POZADINA", bgstr, "Adjust", "Back");
				}
			}
			return 1;
		}
		case DIALOG_MOBILE_BACKGROUND: {
		    if(!response)
		    {
			    new
					tmpString[52];
				if(Bit1_Get( gr_MobileSpeaker, playerid))
					format( tmpString, sizeof( tmpString), "Stanje racuna\nZvucnik: "COL_GREEN"On\nPozadina");
				else
					format( tmpString, sizeof( tmpString), "Stanje racuna\nZvucnik: "COL_RED"Off\nPozadina");
				return ShowPlayerDialog( playerid, DIALOG_MOBILE_MAIN, DIALOG_STYLE_LIST, "MOBITEL - MENU", tmpString, "Choose", "Abort");
			}
			if(listitem == 0) PlayerMobile[playerid][pPhoneBG] = -1263225696;
			else PlayerMobile[playerid][pPhoneBG] = BackgroundColors[listitem][0];
		    PlayerTextDrawColor(playerid, PhoneTD[playerid][7], PlayerMobile[playerid][pPhoneBG]);
			PhoneAction(playerid, PHONE_SHOW);
			Player_SetPhoneStatus(playerid, PHONE_SHOW);
		}
		case DIALOG_MOBILE_MASKS: {
			if(listitem == 0) PlayerMobile[playerid][pPhoneMask] = 0;
			else PlayerMobile[playerid][pPhoneMask] = MaskColors[listitem][0];
		    PlayerTextDrawColor(playerid, PhoneTD[playerid][101], PlayerMobile[playerid][pPhoneMask]);
		    PlayerTextDrawColor(playerid, PhoneTD[playerid][102], PlayerMobile[playerid][pPhoneMask]);
		    PlayerTextDrawColor(playerid, PhoneTD[playerid][103], PlayerMobile[playerid][pPhoneMask]);
		    if(Player_PhoneStatus(playerid) == PHONE_SHOW) 
				PhoneAction(playerid, PHONE_SHOW);
		}
		case DIALOG_MOBILE_CONTACTS_MAIN: 
		{
			if(!response) return 1;
			switch( listitem) 
			{
				case 0: 
				{
				    new slotid = ContactEditing[playerid];
				    if(PlayerContactNumber[playerid][slotid] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Slot u imeniku je slobodan!");
					PhoneTDAction[playerid] = PTD_ACTION_CALL;
					PhoneAction(playerid, PHONE_SHOW);
				    new DialogDial[32];
					format(DialogInputNumber[playerid], 11, "%d", PlayerContactNumber[playerid][slotid]);
				    if(strlen(DialogInputNumber[playerid]) >= 3 && strlen(DialogInputNumber[playerid]) < 9)
			        {
						CancelSelectTextDraw(playerid);
					    format(DialogDial, sizeof(DialogDial), "~g~Call_%s", GetContactNumberName(playerid, DialogInputNumber[playerid]));
						PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogDial);
						new CallNumb = strval(DialogInputNumber[playerid]);
						PhoneCall(playerid, CallNumb);
					    DialogInputNumber[playerid] = "INCALL";
					    PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
					    PlayerTextDrawCreated[playerid][62] = 0;
					}
					else
					{
					    format(DialogDial, sizeof(DialogDial), "~r~INVALID NO.");
						PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogDial);
					    DialogInputNumber[playerid] = "INVALIDNO";
					    PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
					    PlayerTextDrawCreated[playerid][62] = 0;
					}
				}
				case 1: 
				{
				    new slotid = ContactEditing[playerid];
				    if(PlayerContactNumber[playerid][slotid] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Slot u imeniku je slobodan!");
					PhoneTDAction[playerid] = PTD_ACTION_SMS;
					PhoneAction(playerid, PHONE_SHOW);
					format(DialogInputNumber[playerid], 11, "%d", PlayerContactNumber[playerid][slotid]);
					va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_TEXT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "Upisite poruku:", "Send", "Abort");
				}
				case 2: 
				{
				    new
						slotid = ContactEditing[playerid];

					if(PlayerContactNumber[playerid][slotid] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Slot u imeniku je slobodan!");

					if(slotid < 0)
					    slotid = 0;
					
					DeleteMobileContact(PlayerContactSQL[playerid][slotid]);

					PlayerContactName[playerid][slotid][0] 	= EOS;
					PlayerContactNumber[playerid][slotid] 		= 0;
					PlayerContactSQL[playerid][slotid]			= -1;

					Iter_Remove(MobileContacts[playerid], slotid);

					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali kontakt!");
				}
				case 3: 
				{
				    new
						slotid = ContactEditing[playerid];
				    if(0 <= ContactEditing[playerid] <= 9) {
				        if(PlayerContactNumber[playerid][slotid] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Slot u imeniku je slobodan!");
						Bit8_Set( gr_MobileContactSlot, playerid, ContactEditing[playerid]);
						ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITNAME, DIALOG_STYLE_INPUT, "MOBITEL - KONTAKTI UREDJIVANJE", "Unesite naziv slota:", "Input", "Abort");
					}
				}
			}
			return 1;
		}
		case DIALOG_MOBILE_ADDSLOT: 
		{
			if(!IsNumeric(inputtext) && response) return ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDSLOT, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite slot u koji zelite dodati kontakt:\n"COL_RED"Unos mora biti u brojevima!", "Input", "Abort");
			
			new slotid = strval( inputtext);
			if(1 <= slotid <= MAX_MOBILE_CONTACTS) 
			{
				if(PlayerContactNumber[playerid][(slotid-1)] != 0) va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Slot je popunjen, ako nastavite onda cete obrisati postojece podatke!");
				Bit8_Set( gr_MobileContactSlot, playerid, slotid-1);
				ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDNAME, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite naziv kontakta:", "Input", "Abort");
			} 
			else 
			{
				ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDSLOT, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite slot u koji zelite dodati kontakt:\n"COL_RED"Minimalan unos je 1, a maksimalan 10 znakova!", "Input", "Abort");
			}
			return 1;
		}
		case DIALOG_MOBILE_ADDNAME: 
		{
			if(1 <= strlen( inputtext) <= MAX_CONTACT_LEN)
			{
				format( PlayerContactName[playerid][Bit8_Get( gr_MobileContactSlot, playerid)], MAX_CONTACT_LEN, inputtext);
				ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDNUM, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite telefonski broj u slot:", "Input", "Abort");
			}
			else
			{
				va_ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDNAME, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite naziv kontakta:\n"COL_RED"Minimalan unos je 1, a maksimalan %s!", "Input", "Abort", MAX_CONTACT_LEN);
			}
			return 1;
		}
		case DIALOG_MOBILE_ADDNUM:
		{

			if(!response) return 1;
			if(isnull(inputtext)) return ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDNUM, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI UNOS", "Unesite telefonski broj u slot:", "Input", "Abort");

			new
				slotid = Bit8_Get( gr_MobileContactSlot, playerid);
			PlayerContactNumber[playerid][slotid] = strval(inputtext);
			SendInfoMessage(playerid, "Uspjesno ste dodali kontakt.");
			SetContactVars(playerid);
			InsertMobileContact(playerid, slotid);
			return 1;
		}
		case DIALOG_MOBILE_REMSLOT:
		{
			new slotid = ContactEditing[playerid];

			if(slotid < 0)
			    slotid = 0;
			
			DeleteMobileContact(PlayerContactSQL[playerid][slotid]);

			Iter_Remove(MobileContacts[playerid], slotid);

			PlayerContactSQL[playerid][slotid] 			= -1;
			PlayerContactName[playerid][slotid][0] 	= EOS;
			PlayerContactNumber[playerid][slotid] 		= 0;

			SendInfoMessage(playerid, "Uspjesno ste obrisali kontakt.");
			SetContactVars(playerid);
		}
		case DIALOG_MOBILE_EDITSLOT:
		{
			new slotid = ContactEditing[playerid];
			if(0 <= slotid <= 9) {
				Bit8_Set( gr_MobileContactSlot, playerid, slotid);
				ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITNAME, DIALOG_STYLE_INPUT, "MOBITEL - KONTAKTI UREDJIVANJE", "Unesite naziv slota:", "Input", "Abort");
			} else ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITSLOT, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI UREDJIVANJE", "Unesite slot koji zelite urediti:", "Input", "Abort");
			return 1;
		}
		case DIALOG_MOBILE_EDITNAME: 
		{
			if(isnull(inputtext)) return ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITNAME, DIALOG_STYLE_INPUT, "MOBITEL - KONTAKTI UREDJIVANJE", "Unesite naziv slota:", "Input", "Abort");

			format( PlayerContactName[playerid][Bit8_Get( gr_MobileContactSlot, playerid)], MAX_CONTACT_LEN, inputtext);
			ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITNUM, DIALOG_STYLE_INPUT, "MOBITEL - KONTAKTI UREDJIVANJE", "Unesite telefonski broj:", "Input", "Abort");
			return 1;
		}
		case DIALOG_MOBILE_EDITNUM: 
		{
			if(isnull(inputtext)) return ShowPlayerDialog( playerid, DIALOG_MOBILE_EDITNAME, DIALOG_STYLE_INPUT, "MOBITEL - KONTAKTI UREDJIVANJE", "Unesite naziv slota:", "Input", "Abort");

			new
				slotid = Bit8_Get( gr_MobileContactSlot, playerid);
			PlayerContactNumber[playerid][slotid] = strval(inputtext);
			SetContactVars(playerid);
			SavePlayerContact(playerid, slotid);

			new
				tmpString[60];
			format( tmpString, 60, "%d.\nIme: %s\nBroj: %d",
				slotid+1,
				PlayerContactName[playerid][slotid],
				PlayerContactNumber[playerid][slotid]
			);
			ShowPlayerDialog( playerid, 0, DIALOG_STYLE_MSGBOX, "MOBITEL - KONTAKTI UREDJIVANJE", tmpString, "Ok", "");
			return 1;
		}
		case DIALOG_MOBILE_CONTACTS: 
		{
			if(!response) return 1;
			Bit8_Set( gr_MobileContactSlot, playerid, listitem);
			ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_CALL, DIALOG_STYLE_MSGBOX, "MOBILE - KONTAKTI", "Zelite li nazvati trazenog kontakta?", "Call", "Abort");
			return 1;
		}
		case DIALOG_MOBILE_CONTACTS_CALL: 
		{
			if(!response) return 1;
			new slotid = Bit8_Get( gr_MobileContactSlot, playerid);
			PhoneCall(playerid, PlayerContactNumber[playerid][slotid]);
			return 1;
		}

	}
	return 0;
}
hook OnPlayerUpdate(playerid)
{
	if(Player_PhoneStatus(playerid) == PHONE_SHOW)
	{
		if(IsPlayerAlive(playerid) && PhoneUpdateTick[playerid] < gettimestamp())
		{
			SetTDTime(playerid);
			SetTDSignal(playerid);

			if(IsPlayerInWater(playerid) && Player_MobileOn(playerid))
			{
                Player_SetMobileOn(playerid, false);
				PhoneAction(playerid, PHONE_OFF);
			}

			PhoneUpdateTick[playerid] = gettimestamp();
		}
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(Player_PhoneStatus(playerid) == PHONE_SHOW)
			{
				if(Player_UsingSpeedometer(playerid))
					DestroySpeedoTextDraws(playerid);
				else if(!Player_UsingSpeedometer(playerid))
					CreateSpeedoTextDraws(playerid);
			}
		}
	}
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(Text:INVALID_TEXT_DRAW == clickedid
		&& (Player_PhoneStatus(playerid) == PHONE_SHOW || Player_PhoneStatus(playerid) == PHONE_NEXT) 
		&& PhoneTDAction[playerid] != PTD_ACTION_CALL)
		CancelPlayerPhone(playerid);

	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	new OPCDial[32];
	if(playertextid == PhoneTD[playerid][26] && PlayerTextDrawCreated[playerid][26] == 1) //MENU
	{
		CancelSelectTextDraw(playerid);
		va_ShowPlayerDialog( playerid, DIALOG_MOBILE_MAIN, DIALOG_STYLE_LIST, "MOBITEL - MENU", "Stanje racuna\nZvucnik: %s\nPozadina", "Choose", "Abort",
		Bit1_Get( gr_MobileSpeaker, playerid) ? (""COL_GREEN"On") : (""COL_RED"Off")
		);
	}
	else if(playertextid == PhoneTD[playerid][23] && PlayerTextDrawCreated[playerid][23] == 1) //SMS
	{
		PhoneTDAction[playerid] = PTD_ACTION_SMS;
		PhoneAction(playerid, PHONE_SHOW);
	}
	else if(playertextid == PhoneTD[playerid][75] && PlayerTextDrawCreated[playerid][75] == 1) //New SMS
	{
		CancelSelectTextDraw(playerid);
		va_ShowPlayerDialog( playerid, DIALOG_MOBILE_SMS_CONTACT, DIALOG_STYLE_INPUT, "MOBITEL - SMS", "Upisite broj:", "Next", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][24] && PlayerTextDrawCreated[playerid][24] == 1) //CALL
	{
		PhoneTDAction[playerid] = PTD_ACTION_CALL;
		PhoneAction(playerid, PHONE_SHOW);
		format(DialogInputNumber[playerid], 11, "");
		PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogInputNumber[playerid]);
	}
	else if(playertextid == PhoneTD[playerid][25] && PlayerTextDrawCreated[playerid][25] == 1) //GPS
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
		ShowGPS(playerid);
	}
	else if(playertextid == PhoneTD[playerid][27] && PlayerTextDrawCreated[playerid][27] == 1) //ADs
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
		ShowPlayerDialog(playerid, DIALOG_ADS_MENU, DIALOG_STYLE_LIST, "LS OGLASNIK", "Predaj oglas\nPregledaj oglase", "Choose", "Close");
	}
	else if(playertextid == PhoneTD[playerid][28] && PlayerTextDrawCreated[playerid][28] == 1) //Cam
	{
		if(DeathCountStarted_Get(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete ici selfie dok ste u death stanju!");
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);

		if(!Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			TogglePlayerControllable( playerid, false);
			new
				Float:PlayerX, Float:PlayerY, Float:PlayerZ,
				Float:CameraX, Float:CameraY, Float:CameraZ,
				Float:Turn;
			GetPlayerPos( playerid, PlayerX, PlayerY, PlayerZ);

			SelfieAngle[playerid] = 1.25;
			SelfieHeight[playerid] = SELFIE_HEIGHT;

			Turn = 180.0 - SelfieAngle[playerid];

			CameraX = PlayerX + ( SELFIE_DISTANCE * floatcos(Turn, degrees));
			CameraY = PlayerY + ( SELFIE_DISTANCE * floatsin(Turn, degrees));
			CameraZ = PlayerZ + SelfieHeight[playerid];

			SetPlayerFacingAngle( playerid, 90.0 - SelfieAngle[playerid]);
			InterpolateCameraPos( playerid, 	CameraX, CameraY, CameraZ, CameraX, CameraY, CameraZ, 100000, CAMERA_CUT);
			InterpolateCameraLookAt( playerid, 	PlayerX, PlayerY, PlayerZ + 1.0, PlayerX, PlayerY, PlayerZ + SelfieHeight[playerid], 100000, CAMERA_CUT);

			SendClientMessage(playerid, COLOR_SAMP_GREEN, "[TIP]: Koristite ~k~~GO_FORWARD~, ~k~~PED_DUCK~, ~k~~PED_JUMPING~, ~k~~VEHICLE_LOOKRIGHT~ za micanje kamere, a F8 za slikanje.");

			ApplyAnimationEx( playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1, 0);
			Bit1_Set( gr_PlayerTakingSelfie, playerid, true);
		}
		else if(Bit1_Get( gr_PlayerTakingSelfie, playerid))
		{
			TogglePlayerControllable( playerid, true);
			SetCameraBehindPlayer( playerid);
			ApplyAnimationEx( playerid, "PED", "ATM", 4.1, 0, 1, 1, 0, 1, 1, 0);
			SelfieAngle[playerid] = 0.0;
			Bit1_Set( gr_PlayerTakingSelfie, playerid, false);
		}
	}
	else if(playertextid == PhoneTD[playerid][29] && PlayerTextDrawCreated[playerid][29] == 1) //Contacts
	{
		PhoneTDAction[playerid] = PTD_ACTION_CONT;
		PhoneAction(playerid, PHONE_SHOW);
	}
	else if(playertextid == PhoneTD[playerid][97] && PlayerTextDrawCreated[playerid][97] == 1) //Add Contact
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
		ShowPlayerDialog( playerid, DIALOG_MOBILE_ADDSLOT, DIALOG_STYLE_INPUT, "MOBILE - KONTAKTI DODAVANJE", "Unesite slot u koji zelite dodati kontakt:", "Input", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][77] && PlayerTextDrawCreated[playerid][77] == 1) //Contact 1
	{
	    if(PlayerContactNumber[playerid][0] == 0) return 1;
	    ContactEditing[playerid] = 0;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][78] && PlayerTextDrawCreated[playerid][78] == 1) //Contact 2
	{
	    if(PlayerContactNumber[playerid][1] == 0) return 1;
	    ContactEditing[playerid] = 1;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][79] && PlayerTextDrawCreated[playerid][79] == 1) //Contact 3
	{
	    if(PlayerContactNumber[playerid][2] == 0) return 1;
	    ContactEditing[playerid] = 2;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][80] && PlayerTextDrawCreated[playerid][80] == 1) //Contact 4
	{
	    if(PlayerContactNumber[playerid][3] == 0) return 1;
	    ContactEditing[playerid] = 3;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][81] && PlayerTextDrawCreated[playerid][81] == 1) //Contact 5
	{
	    if(PlayerContactNumber[playerid][4] == 0) return 1;
	    ContactEditing[playerid] = 4;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][82] && PlayerTextDrawCreated[playerid][82] == 1) //Contact 6
	{
	    if(PlayerContactNumber[playerid][5] == 0) return 1;
	    ContactEditing[playerid] = 5;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][83] && PlayerTextDrawCreated[playerid][83] == 1) //Contact 7
	{
	    if(PlayerContactNumber[playerid][6] == 0) return 1;
	    ContactEditing[playerid] = 6;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][84] && PlayerTextDrawCreated[playerid][84] == 1) //Contact 8
	{
	    if(PlayerContactNumber[playerid][7] == 0) return 1;
	    ContactEditing[playerid] = 7;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][85] && PlayerTextDrawCreated[playerid][85] == 1) //Contact 9
	{
	    if(PlayerContactNumber[playerid][8] == 0) return 1;
	    ContactEditing[playerid] = 8;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if(playertextid == PhoneTD[playerid][86] && PlayerTextDrawCreated[playerid][86] == 1) //Contact 10
	{
	    if(PlayerContactNumber[playerid][9] == 0) return 1;
	    ContactEditing[playerid] = 9;
	    ShowPlayerDialog( playerid, DIALOG_MOBILE_CONTACTS_MAIN, DIALOG_STYLE_LIST, "MOBILE - KONTAKT", "Nazovi\nPosalji poruku\nObrisi kontakt\nUredi kontakt", "Choose", "Abort");
	}
	else if((playertextid == PhoneTD[playerid][38] && PlayerTextDrawCreated[playerid][38] == 1) || (playertextid == PhoneTD[playerid][68] && PlayerTextDrawCreated[playerid][68] == 1) || (playertextid == PhoneTD[playerid][99] && PlayerTextDrawCreated[playerid][99] == 1)) //DIAL - IZLAZ
	{
		PhoneTDAction[playerid] = PTD_ACTION_HOME;
		PhoneAction(playerid, PHONE_SHOW);
	}
	else if(playertextid == PhoneTD[playerid][39] && PlayerTextDrawCreated[playerid][39] == 1) //DIAL - ZOVI
	{
        if(strlen(DialogInputNumber[playerid]) >= 3 && strlen(DialogInputNumber[playerid]) < 9)
        {
			CancelSelectTextDraw(playerid);
			PhoneAction(playerid, PHONE_NEXT);
		    format(OPCDial, sizeof(OPCDial), "~g~Call_%s", GetContactNumberName(playerid, DialogInputNumber[playerid]));
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], OPCDial);
			new CallNum = strval(DialogInputNumber[playerid]);
			PhoneCall(playerid, CallNum);
		    DialogInputNumber[playerid] = "INCALL";
		    PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
		    PlayerTextDrawCreated[playerid][62] = 0;
		}
		else
		{
		    format(OPCDial, sizeof(OPCDial), "~r~INVALID NO.");
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], OPCDial);
		    DialogInputNumber[playerid] = "INVALIDNO";
		    PlayerTextDrawHide(playerid, PhoneTD[playerid][62]);
		    PlayerTextDrawCreated[playerid][62] = 0;
		}
	}
	else if(playertextid == PhoneTD[playerid][62] && PlayerTextDrawCreated[playerid][62] == 1) //DIAL - OBRISI
	{
	    new VelicinaInputa = strlen(DialogInputNumber[playerid]);
        if(VelicinaInputa >= 0 && IsNumeric(DialogInputNumber[playerid]))
        {
            strdel(DialogInputNumber[playerid], VelicinaInputa-1, VelicinaInputa);
			PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogInputNumber[playerid]);
		}
	}
	else if(playertextid == PhoneTD[playerid][63] && PlayerTextDrawCreated[playerid][63] == 1) //SMS 1
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
	    ShowSMS(playerid, 0);
	}
	else if(playertextid == PhoneTD[playerid][64] && PlayerTextDrawCreated[playerid][64] == 1) //SMS 1
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
	    ShowSMS(playerid, 1);
	}
	else if(playertextid == PhoneTD[playerid][65] && PlayerTextDrawCreated[playerid][65] == 1) //SMS 1
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
	    ShowSMS(playerid, 2);
	}
	else if(playertextid == PhoneTD[playerid][66] && PlayerTextDrawCreated[playerid][66] == 1) //SMS 1
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
	    ShowSMS(playerid, 3);
	}
	else if(playertextid == PhoneTD[playerid][67] && PlayerTextDrawCreated[playerid][67] == 1) //SMS 1
	{
		CancelSelectTextDraw(playerid);
		PhoneAction(playerid, PHONE_NEXT);
	    ShowSMS(playerid, 4);
	}
	for(new i = 40; i < 50; i++) //DIAL - TIPKOVNICA
	{
	    if(playertextid == PhoneTD[playerid][i] && PlayerTextDrawCreated[playerid][i] == 1)
	    {
	        if(strlen(DialogInputNumber[playerid]) < 8)
	        {
	            if(!IsNumeric(DialogInputNumber[playerid]) || strlen(DialogInputNumber[playerid]) < 1) format(DialogInputNumber[playerid], 11, "%d", TDPhoneDial[i]);
		        else format(DialogInputNumber[playerid], 11, "%s%d", DialogInputNumber[playerid], TDPhoneDial[i]);
		        PlayerTextDrawSetString(playerid, PhoneTD[playerid][37], DialogInputNumber[playerid]);
			    PlayerTextDrawShow(playerid, PhoneTD[playerid][62]);
			    PlayerTextDrawCreated[playerid][62] = 1;
	        }
	        break;
	    }
	}
	return 1;
}

/*
	 ######     ###    ##       ##       ########     ###     ######  ##    ##  ######
	##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##  ##    ##
	##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##   ##
	##       ##     ## ##       ##       ########  ##     ## ##       #####     ######
	##       ######### ##       ##       ##     ## ######### ##       ##  ##         ##
	##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##  ##    ##
	 ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##  ######
*/

timer MobileRinging[15000](playerid)
{
	if(CallingId[playerid] == 999) {
		Bit8_Set( gr_RingingTime, playerid, 0);
		stop PlayerMobileRingTimer[playerid];
		return;
	}
	Bit8_Set( gr_RingingTime, playerid, Bit8_Get( gr_RingingTime, playerid) - 1);

	new
		tmpString[70];
	format( tmpString, 70, "** Mobitel bi zvonio u djepu od hlaca (( %s))", GetName(playerid,true));
	ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	static
		Float:mobPos[3];
	GetPlayerPos(playerid, mobPos[0], mobPos[1], mobPos[2]);
	PlayerPlaySound(playerid, 20600, mobPos[0], mobPos[1], mobPos[2]);

	if(Bit8_Get( gr_RingingTime, playerid) <= 0) {
		Bit8_Set( gr_RingingTime, playerid, 0);
		new
			gplayerid = CallingId[playerid];
		stop PlayerMobileRingTimer[playerid];
		stop PlayerMobileRingTimer[gplayerid];

		SendClientMessage( gplayerid, COLOR_RED, "** (mobitel) Ne javlja se.**");
		SetPlayerSpecialAction( gplayerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		CallingId[gplayerid] = 999;
		if(IsPlayerAttachedObjectSlotUsed(gplayerid, MOBILE_OBJECT_SLOT))
			RemovePlayerAttachedObject( gplayerid, MOBILE_OBJECT_SLOT);
		return;
	}
}

stock HexBoja( hexsstring[])
{
	if(hexsstring[0] == 0) return ( 0);

	new hxcur = 1;
	new hxres = 0;
	for( new i = strlen( hexsstring); i > 0; i --)
	{
		if(hexsstring[i - 1] < 58)
		{
			hxres = hxres + hxcur * ( hexsstring[i - 1] - 48);
		}
		else
		{
			hxres = hxres + hxcur * ( hexsstring[i - 1] - 65 + 10);
			hxcur = hxcur * 16;
		}
	}

	return ( hxres);
}

forward TowerSQLID(towerid);
public TowerSQLID(towerid)
{
	new trSQLID = TowerInfo[towerid][twSQLID];
    return trSQLID;
}

forward SetTowerInfo(towerid, tiNetwork[], Float:tiX, Float:tiY, Float:tiZ, Float:tiRX, Float:tiRY, Float:tiRZ, Float:tiRadius);
public SetTowerInfo(towerid, tiNetwork[], Float:tiX, Float:tiY, Float:tiZ, Float:tiRX, Float:tiRY, Float:tiRZ, Float:tiRadius)
{
    format(TowerInfo[towerid][twNetwork], 24, tiNetwork);
    TowerInfo[towerid][twPosX] = tiX;
    TowerInfo[towerid][twPosY] = tiY;
    TowerInfo[towerid][twPosZ] = tiZ;
    TowerInfo[towerid][twPosRX] = tiRX;
    TowerInfo[towerid][twPosRY] = tiRY;
    TowerInfo[towerid][twPosRZ] = tiRZ;
    TowerInfo[towerid][twRadius] = tiRadius;
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
CMD:createtower(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	new ctnetwork[24], Float:ctradius;
	if(sscanf(params, "s[24]f", ctnetwork, ctradius)) return SendClientMessage(playerid, COLOR_RED, "[?]: /createtower [network name][radius]");
	new
		Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	TowerEditingRadius[playerid] = ctradius;
	format(TowerEditingNetwork[playerid], 24, ctnetwork);
	TowerEditingObj[playerid] = CreateDynamicObject(3763, x, y, z, 0.0, 0.0, 0.0);
	EditDynamicObject(playerid, TowerEditingObj[playerid]);
	SendInfoMessage(playerid, "Namjestite objekt signalnog tornja i sacuvajte ga kako bi kreirali toranj!");
	return 1;
}

CMD:destroytower(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	new dtowerid;
	if(sscanf(params, "i", dtowerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /destroytower [id]");
	if(!DeleteTower(dtowerid)) va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Taj toranj ne postoji u bazi podataka (koristite IG id, a ne SQLID)!");
	va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Unistili ste toranj ID %d!", dtowerid);
	return 1;
}

CMD:viewtowers(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	PrintAllTowers(playerid);
	return 1;
}

CMD:togphone(playerid, params[])
{
    if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
    if(!PlayerMobile[playerid][pMobileNumber]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate mobitel!");
    if(IsPlayerInWater(playerid)) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemozete upaliti mobitel u vodi!");

    if(!Player_MobileOn(playerid))
    {
        PhoneTDAction[playerid] = PTD_ACTION_HOME;
        PhoneAction(playerid, PHONE_ON);
    }
    else
    {
        PhoneTDAction[playerid] = PTD_ACTION_HOME;
        PhoneAction(playerid, PHONE_OFF);
    }
    Player_SetMobileOn(playerid, !Player_MobileOn(playerid));
    return 1;
}

CMD:ph(playerid, params[])
{
    if(Player_PhoneStatus(playerid) == PHONE_HIDE) 
		return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Prvo izvadite mobitel!");
    SelectTextDraw(playerid, 0xA3B4C5FF);
	return 1;
}

CMD:phone(playerid, params[])
{
	if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
	if(!PlayerMobile[playerid][pMobileNumber]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate mobitel!");
	PhoneTDAction[playerid] = PTD_ACTION_HOME;
	if(Player_PhoneStatus(playerid) == PHONE_SHOW || Player_PhoneStatus(playerid) == PHONE_NEXT)
	{
		CancelPlayerPhone(playerid);
		return 1;
	}
	else if(Player_PhoneStatus(playerid) == PHONE_HIDE)
	{
		PhoneAction(playerid, PHONE_SHOW);
		Player_SetPhoneStatus(playerid, PHONE_SHOW);
	    SelectTextDraw(playerid, 0xA3B4C5FF);
		if(!IsPlayerAttachedObjectSlotUsed(playerid, MOBILE_OBJECT_SLOT))
			SetPlayerAttachedObject(playerid, MOBILE_OBJECT_SLOT, PlayerMobile[playerid][pMobileModel], 6, 0.101469, 0.000639, -0.008395, 73.051651, 171.894165, 0.000000, 1.000000, 1.000000, 1.000000);
		return 1;
	}
	return 1;
}

CMD:pcall(playerid, params[])
{
	if(!IsAtGovornica(playerid)) 			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nisi kod telefonske govornice!");
	if(AC_GetPlayerMoney(playerid) < 10) 	return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate 10$!");
	new
		number;

	if(sscanf( params, "i", number)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /pcall [broj]");
		SendClientMessage(playerid, COLOR_GREY, "HITNI POZIVI: 555 (mehanicari), 911 (LSPD/LSFD), 444 (taxi)");
		return 1;
	}
	Bit1_Set( gr_PlayerUsingPhonebooth	, playerid, true);
	PhoneCall(playerid, number);
	PlayerToBudgetMoney(playerid, 10);
	return 1;
}

CMD:call(playerid, params[])
{
    new number;
    if(!Player_MobileOn(playerid))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas mobitel je trenutno iskljucen!");

    if(PlayerDeath[playerid][pKilled])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");

    if(sscanf(params, "i", number))
    {
        SendClientMessage(playerid, -1, "[COMMAND]: /call [number].");
        SendClientMessage(playerid, COLOR_GREY, "(emergency): 444 (taxi), 555 (mehanicari), 911 (LSPD/LSFD).");
        return 1;
    }
    PhoneCall(playerid, number);
    return 1;
}

CMD:pickup(playerid, params[])
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, 6)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Imate objekt u desnoj ruci!");
	if(CallingId[playerid] != 999) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Vec ste u razogovu!");

	foreach(new i : Player)
	{
		if(IsPlayerLogged( i)  && IsPlayerConnected(playerid))
		{
			if(PlayerCallPlayer[i] == playerid)
			{
				Bit8_Set( gr_RingingTime, playerid, 0);
				stop PlayerMobileRingTimer[playerid];
				stop PlayerMobileRingTimer[i];
				Bit1_Set( gr_CanHangup, playerid, true);

				CallingId[i] 			= playerid;
				CallingId[playerid] 	=  i;
				StartCallTimestamp[i]	= gettimestamp();

				SetPlayerAttachedObject(playerid, MOBILE_OBJECT_SLOT, PlayerMobile[playerid][pMobileModel], 6, 0.101469, 0.000639, -0.008395, 73.051651, 171.894165, 0.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				stop PlayerMobileRingTimer[playerid];
				SendClientMessage( i, COLOR_RED, "[!] Javio se!");
				SendClientMessage( playerid, COLOR_YELLOW, "[HINT]: Pricate pritiskom na tipku T i unosom teksta - prekid poziva /hangup - postavljanje poziva na zvucnik /speakerphone!");
				break;
			}
		}
	}
	return 1;
}

CMD:sms(playerid, params[])
{
	if(PlayerDeath[playerid][pKilled])
		return SendClientMessage(playerid,COLOR_RED, "ERROR: Ne mozes koristiti ovu komandu dok imas opciju /die!");
	if(!PlayerMobile[playerid][pMobileNumber])
		return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate mobitel!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /sms  [broj][tekst]");
	if(strlen(params) > 110) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prevelika poruka (max. 110 znakova)!");

	new
		number,
		string[8],
		smsText[110];

	if(sscanf( params, "is[110]", number, smsText)) return SendClientMessage(playerid, COLOR_RED, "[?]: /sms [broj][text]");
	if(strlen(smsText) < 2 || strlen(smsText) > 110) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"SMS text mora biti u rasponu od 2 do 110 slova!");
	valstr(string, number);
	if(strlen(string) == 6)
	{
		SendSMS(playerid, number, smsText);
		va_SendClientMessage(playerid, COLOR_YELLOW, "SMS poslan! [%s]: %s", GetContactNumberNameEx(playerid, number), smsText);
		// SMS trace by PD
		foreach(new follower : Player)
		{
			if(Player_TappingSMS(follower))
			{
				va_SendClientMessage(follower, COLOR_YELLOW, "** SMS TRACE ** %d >> %d: %s",  PlayerMobile[playerid][pMobileNumber], number, smsText);
			}
		}
		// kraj SMS tracea
	}
	else va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste unijeli broj mobitela!");
	return 1;
}

CMD:speakerphone(playerid, params[])
{
	if(!PlayerMobile[playerid][pMobileNumber])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate mobitel!");
	if(CallingId[playerid] == 999) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste u razgovoru!");
	
	new
		globalstring[80];
		
	if(!SpeakerPhone[playerid])
	{
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Ukljucili ste zvucnik na mobitelu, svi u krugu 10 metara ce cuti vas razgovor.");
		SpeakerPhone[playerid] = true;
		
		format(globalstring, sizeof(globalstring), "> %s ukljucuje zvucnik usred poziva.", GetName(playerid));
		SetPlayerChatBubble(playerid, globalstring, COLOR_PURPLE, 20, 6000);
	}
	else
	{
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Iskljucili ste zvucnik na mobitelu, samo vi vidite vas razgovor.");
		SpeakerPhone[playerid] = false;
		
		format(globalstring, sizeof(globalstring), "> %s iskljucuje zvucnik usred poziva.", GetName(playerid));
		SetPlayerChatBubble(playerid, globalstring, COLOR_PURPLE, 20, 6000);
	}
	return 1;
}

CMD:hangup(playerid, params[])
{
	if(!Bit1_Get( gr_CanHangup, playerid)) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Ne razgovaras na telefon.");
	if(PlayerVIP[playerid][pDonateRank] == 0)
	{
		if(StartCallTimestamp[playerid] != 0)
		{
			new cost = floatround((gettimestamp() - StartCallTimestamp[playerid]) / 60, floatround_round) * 2;
			PlayerMobile[playerid][pMobileCost] += cost;
			va_SendClientMessage(playerid, COLOR_RED, "[!] Poziv je naplacen %d$", cost);

			mysql_fquery(SQL_Handle(), "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
				PlayerMobile[playerid][pMobileCost],
				PlayerInfo[playerid][pSQLID]
			);
		}
	}
	PlayerHangup(playerid); // unutra ima i za giveplayerid
	return 1;
}

CMD:cryptotext(playerid, params[])
{
	new
		cryptonumber, inputstring[80];

    if(sscanf(params, "is[80]", cryptonumber, inputstring)) return SendClientMessage(playerid, COLOR_RED, "[?]: /cryptotext [crypto number][text]");
 	if(PlayerMobile[playerid][pCryptoNumber] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate crypto.");
	if(PlayerJail[playerid][pJailed] != 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemozete trenutno poslati poruku!");
    if(strlen(inputstring) > 80) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Poruka je preduga,nemoze imati vise od 80 znakova!");
	new
		globalstring[128];
	format(globalstring, sizeof(globalstring), "> %s pise poruku na mobitel.", GetName(playerid));
	SetPlayerChatBubble(playerid, globalstring, COLOR_PURPLE, 20, 6000);

	foreach (new i : Player)
	{
		if(PlayerMobile[i][pCryptoNumber] == cryptonumber && cryptonumber != 0)
		{
			if(i != INVALID_PLAYER_ID)
			{
				va_SendClientMessage(playerid, 0x3E87A2FF, "** CRYPTO-PGP ** Sent To: %d - %s", cryptonumber, inputstring);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				va_SendClientMessage(i, 0x3EAED6FF, "** CRYPTO-PGP ** From: %d - %s", PlayerMobile[playerid][pCryptoNumber], inputstring);
				PlayerPlaySound(i, 21001, 0.0, 0.0, 0.0);
				return 1;
			}
		}
	}
	SendClientMessage(playerid, COLOR_RED, "** CRYPTO ERROR ** No connection!");
	return 1;
}

CMD:cryptonumber(playerid, params[]) 
{
	new _crypt;
    if(sscanf(params, "i", _crypt)) return SendClientMessage(playerid, COLOR_RED, "[?]: /cryptonumber [crypto number]");
 	if(PlayerMobile[playerid][pCryptoNumber] == 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemate crypto.");
	if(PlayerJail[playerid][pJailed] != 0) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemozete trenutno poslati poruku!");
	if(_crypt < 100 || _crypt > 999999) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR,"Broj moze biti izmedju 100 i 999999!");

	new	Cache:result;
	
	result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT * FROM player_phones WHERE type = '2' AND cryptonumber = '%d'", _crypt));
	if(cache_num_rows()) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj broj CRYPTOa vec postoji!");
	cache_delete(result);
	
	PlayerMobile[playerid][pCryptoNumber] = _crypt;
	mysql_fquery(SQL_Handle(), "UPDATE player_phones SET cryptonumber = '%d' WHERE player_id = '%d' AND type = '2' ORDER BY id DESC LIMIT 1",
		PlayerMobile[playerid][pCryptoNumber],
		PlayerInfo[playerid][pSQLID]
	);

	va_SendClientMessage(playerid, COLOR_RED, "Promijenili ste svoj broj cryptoa! Novi broj: %d", _crypt);
	return 1;
}
