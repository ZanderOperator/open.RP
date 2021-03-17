#include <YSI_Coding\y_hooks>

/*
	##     ##    ###     ######  ########   #######   ######  
	###   ###   ## ##   ##    ## ##     ## ##     ## ##    ## 
	#### ####  ##   ##  ##       ##     ## ##     ## ##       
	## ### ## ##     ## ##       ########  ##     ##  ######   
	##     ## ######### ##       ##   ##   ##     ##       ## 
	##     ## ##     ## ##    ## ##    ##  ##     ## ##    ## 
	##     ## ##     ##  ######  ##     ##  #######   ######  
*/

//Igrac je novi na serveru ili je stari
#define MAX_ADO_LABELS  200

// Player Module Includes at the bottom


/*
	######## #### ##     ## ######## ########   ######     ##     ##    ###    ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ##    ##     ##   ## ##   ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##          ##     ##  ##   ##  ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######     ##     ## ##     ## ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ##     ##   ##  ######### ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ##      ## ##   ##     ## ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######        ###    ##     ## ##     ##  ######  
*/

static 
	ADOText[MAX_PLAYERS],
	PlayerText:BlindTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	 ######   ##        #######  ########     ###    ##          ##     ##    ###    ########   ######  
	##    ##  ##       ##     ## ##     ##   ## ##   ##          ##     ##   ## ##   ##     ## ##    ## 
	##        ##       ##     ## ##     ##  ##   ##  ##          ##     ##  ##   ##  ##     ## ##       
	##   #### ##       ##     ## ########  ##     ## ##          ##     ## ##     ## ########   ######  
	##    ##  ##       ##     ## ##     ## ######### ##           ##   ##  ######### ##   ##         ## 
	##    ##  ##       ##     ## ##     ## ##     ## ##            ## ##   ##     ## ##    ##  ##    ## 
	 ######   ########  #######  ########  ##     ## ########       ###    ##     ## ##     ##  ######  
*/
enum E_ADO_LABEL_INFO
{
	labelid,
	Text3D:label,
	Float:lablpos[3]
}

static
    bool:BlockedOOC[MAX_PLAYERS],
    bool:HasDice[MAX_PLAYERS],
    bool:HasDrink[MAX_PLAYERS],
    bool:HasFood[MAX_PLAYERS],
    bool:FakeGunLic[MAX_PLAYERS],
    PlayerGroceries[MAX_PLAYERS],
	bool:PlayerGlobalTaskTimer[MAX_PLAYERS],
	Timer:PlayerTask[MAX_PLAYERS];

new
    AdoLabels[MAX_ADO_LABELS][E_ADO_LABEL_INFO];

new
    PlayerDrunkLevel[MAX_PLAYERS],
    PlayerFPSUnix[MAX_PLAYERS];


	
/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
*/

stock bool:Player_HasBlockedOOCChat(playerid)
{
    return BlockedOOC[playerid];
}

stock Player_SetHasBlockedOOCChat(playerid, bool:v)
{
    BlockedOOC[playerid] = v;
}

stock bool:Player_HasDice(playerid)
{
    return HasDice[playerid];
}

stock Player_SetHasDice(playerid, bool:v)
{
    HasDice[playerid] = v;
}

stock bool:Player_HasFakeGunLicense(playerid)
{
    return FakeGunLic[playerid];
}

stock Player_SetHasFakeGunLicense(playerid, bool:v)
{
    FakeGunLic[playerid] = v;
}

stock Player_GetGroceriesQuantity(playerid)
{
    return PlayerGroceries[playerid];
}

stock Player_SetGroceriesQuantity(playerid, v)
{
    PlayerGroceries[playerid] = v;
}

stock bool:Player_HasDrink(playerid)
{
    return HasDrink[playerid];
}

stock Player_SetHasDrink(playerid, bool:v)
{
    HasDrink[playerid] = v;
}

stock bool:Player_HasFood(playerid)
{
    return HasFood[playerid];
}

stock Player_SetHasFood(playerid, bool:v)
{
    HasFood[playerid] = v;
}

static ResetPlayerEnumerator()
{
	for(new p=0; p<MAX_PLAYERS; p++)
		ResetPlayerVariables(p);

	return 1;
}

GetName(playerid, bool:replace=true)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	
	if(replace) {
		if(Player_UsingMask(playerid))
			format(name, sizeof(name), "Maska_%d", PlayerInventory[playerid][pMaskID]);
		else 
			strreplace(name, '_', ' ');
	}
	return name;
}

CheckPlayerInteriors(playerid)
{
	new interior = -1, virtualworld = -1;
	interior = GetPlayerInterior(playerid);
	virtualworld = GetPlayerVirtualWorld(playerid);

	CheckPlayerHouseInt(playerid, interior, virtualworld);
	CheckPlayerBizzInt(playerid, interior, virtualworld);
	CheckPlayerGarageInt(playerid);
	CheckPlayerPickupInt(playerid, interior, virtualworld);
	CheckPlayerComplexInt(playerid, interior, virtualworld);
	CheckPlayerComplexRoomInt(playerid, interior, virtualworld);
	return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid)
{
	defer KickTimer(playerid);
	return 1;
}
	
forward BanPlayer(playerid);
public BanPlayer(playerid)
{
	defer BanTimer(playerid);
	return 1;
}

stock GetAdoFreeLabelSlot() 
{
	for(new i = 0; i < MAX_ADO_LABELS; i++)
	{
	    if(!AdoLabels[i][label])
	    {
	        return i;
	    }
	}
	return -1;
}

stock ResetAdoLabelSlot(playerid, type, value)
{
	switch(type)
	{
	    //slot
		case 1:
		{
		    ADOText[AdoLabels[value][labelid]] = 0;
		    AdoLabels[value][labelid] = 0;
      		DestroyDynamic3DTextLabel(AdoLabels[value][label]);
		    AdoLabels[value][lablpos][0] = 0;
		    AdoLabels[value][lablpos][1] = 0;
		    AdoLabels[value][lablpos][2] = 0;
      		SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali prikvaceni opis.");
			return 1;
		}
		//playerid
		case 2:
		{
		    for(new i = 0; i < MAX_ADO_LABELS; i++)
		    {
		        if(AdoLabels[i][labelid] == value)
		        {
		            ADOText[AdoLabels[i][labelid]] = 0;
		            AdoLabels[i][labelid] = -1;
		      		DestroyDynamic3DTextLabel(AdoLabels[i][label]);
				    AdoLabels[i][lablpos][0] = 0;
				    AdoLabels[i][lablpos][1] = 0;
				    AdoLabels[i][lablpos][2] = 0;
				    SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali prikvaceni opis.");
				    return 1;
		        }
		    }
		}
	}
	return 0;
}

stock LevelUp(playerid)
{
	if(PlayerInfo[playerid][pLevel] > 0)
	{
		new
			expamount = ( PlayerInfo[playerid][pLevel] + 1) * 4;
		if(PlayerInfo[playerid][pRespects] < expamount) {
			return 0;
		}

		PlayerInfo[playerid][pLevel]++;
		if(PlayerVIP[playerid][pDonateRank] > 0)
		{
			PlayerInfo[playerid][pRespects] -= expamount;
			new total = PlayerInfo[playerid][pRespects];
			if(total > 0) PlayerInfo[playerid][pRespects] = total;
			else
				PlayerInfo[playerid][pRespects] = 0;
		}
		else
			PlayerInfo[playerid][pRespects] = 0;

		mysql_fquery(SQL_Handle(), "UPDATE accounts SET levels = '%d', respects = '%d' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pLevel],
			PlayerInfo[playerid][pRespects],
			PlayerInfo[playerid][pSQLID]
		);

		SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	}
	return 1;
}

ConvertNameToSQLID(const playername[])
{
	new 
		sqlid = -1,
		Cache:result = mysql_query(SQL_Handle(), 
							va_fquery(SQL_Handle(), 
								"SELECT sqlid FROM accounts WHERE name = '%e'", 
								playername
							)),
		rows;

	cache_get_row_count(rows);
	if(!rows)
		return -1;

	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	return sqlid;
}

ConvertSQLIDToName(id)
{
	new 
		nick[MAX_PLAYER_NAME];
		
	new 
		Cache:result = 	mysql_query(SQL_Handle(), 
							va_fquery(SQL_Handle(), "SELECT name FROM accounts WHERE sqlid = '%d'", id)
						);
	
	if(cache_num_rows() == 0)
		strcpy(nick, "None", MAX_PLAYER_NAME);
	else
	{
		cache_get_value_name(0, "name", nick, MAX_PLAYER_NAME);
		cache_delete(result);
	}
	return nick;
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

timer KickTimer[50](playerid)
{
	Kick(playerid);
	return 1;
}

timer BanTimer[50](playerid)
{
	Kick(playerid);
	return 1;
}

timer StopPlayerTrackSound[5000](playerid)
{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
}

timer InstantStreamerUpdate[4000](playerid)
{
	Streamer_ToggleIdleUpdate(playerid, 0);
	TogglePlayerControllable(playerid, 1);
}

PlayerMinuteTask(playerid)
{
	PlayerTick[playerid][ptMainTimer] = gettimestamp() + 60;
	
	if((CreditInfo[playerid][cCreditType] == 5 || CreditInfo[playerid][cCreditType] == 6 || CreditInfo[playerid][cCreditType] == 7) && !CreditInfo[playerid][cUsed] && gettimestamp() >= CreditInfo[playerid][cTimestamp]) 
	{
		ResetCreditVars(playerid);
		SavePlayerCredit(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "[SMS]: Automatski vam je ponisten namjenski kredit radi neobavljanja kupovne obveze.");
	}
	PaydayInfo[playerid][pPayDay] += 1;
	if(PaydayInfo[playerid][pPayDay] >= 60)
		GivePlayerPayCheck(playerid);
		
	if(PlayerJail[playerid][pJailTime] > 0)
		PlayerJail[playerid][pJailTime] -= 1;
	else if(PlayerJail[playerid][pJailTime] == 0)
	{
		if(PlayerJail[playerid][pJailed] == 1)
		{
			SetPlayerPosEx(playerid, 90.6552, -236.3789, 1.5781, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Slobodni ste, platili ste svoj dug drustvu!");
		}
		else if(PlayerJail[playerid][pJailed] == 2)
		{
			SetPlayerPosEx(playerid, 1482.7426, -1740.1372, 13.7500, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pusten si iz Fort DeMorgana, pripazi na ponasanje i server pravila!");
		}
		else if(PlayerJail[playerid][pJailed] == 3)
		{
			SetPlayerPosEx(playerid, 636.7744,-601.3240,16.3359, 0, 0, false);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Slobodni ste, platili ste svoj dug drustvu!");
		}
		else if(PlayerJail[playerid][pJailed] == 5) // Treatment
		{
			TogglePlayerControllable(playerid, 1);
			ClearAnim(playerid);
			SetPlayerPosEx(playerid, 1185.4681,-1323.8542,13.5720, 0, 0, false);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Zavrsilo je vase lijecenje, otpusteni ste iz bolnice!");
		}
		PlayerJail[playerid][pJailed] = 0;
		PlayerJail[playerid][pJailTime] = 0;
	}
	else if(PlayerJail[playerid][pJailTime] < 0)
		PlayerJail[playerid][pJailTime] = 0;
		
		
	if(PlayerDrugStatus[playerid][pDrugUsed] != 0)
	{
		if(-- PlayerDrugStatus[playerid][pDrugSeconds] <= 0)
		{
			PlayerDrugStatus[playerid][pDrugSeconds] = 0;
			PlayerDrugStatus[playerid][pDrugUsed] = 0;
		}
	}
	if(PlayerDrugStatus[playerid][pDrugOrder] > 0)
	{
		-- PlayerDrugStatus[playerid][pDrugOrder];
	}
	
	HungerCheck(playerid);
	AFKCheck(playerid);
	AC_SavePlayerWeapons(playerid);
	return 1;	
}

timer PlayerGlobalTask[1000](playerid)
{
	if(!Player_SafeSpawned(playerid) || !IsPlayerConnected(playerid)) 
		return 1;
	
	if(gettimestamp() >= PlayerTick[playerid][ptMainTimer])
		PlayerMinuteTask(playerid);	
	
	new tmphour,tmpmins,tmpsecs;
	GetServerTime(tmphour,tmpmins,tmpsecs);
	SetPlayerTime(playerid,tmphour,tmpmins);
	
	static
		pcar = INVALID_VEHICLE_ID;
	
	if((pcar = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static
			Float:vhealth;

		GetVehicleHealth(pcar, vhealth);
		
		if(vhealth < 250.0)
		{
			AC_SetVehicleHealth(pcar, 260.0);
			CallLocalFunction("OnPlayerCrashVehicle", "idf", playerid, pcar, 0.0);
			
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			
			GetVehicleParamsEx(pcar, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(pcar, 0, lights, alarm, doors, bonnet, boot, objective);
			
			VehicleInfo[pcar][vEngineRunning] = false;
		}
	}	
	return 1;
}

/*
	                                                                                         
		88888888888                                        88                                    
		88                                           ,d    ""                                    
		88                                           88                                          
		88aaaaa 88       88 8b,dPPYba,   ,adPPYba, MM88MMM 88  ,adPPYba,  8b,dPPYba,  ,adPPYba,  
		88""""" 88       88 88P'   `"8a a8"     ""   88    88 a8"     "8a 88P'   `"8a I8[   ""  
		88      88       88 88       88 8b           88    88 8b       d8 88       88  `"Y8ba,   
		88      "8a,   ,a88 88       88 "8a,   ,aa   88,   88 "8a,   ,a8" 88       88 aa   ]8I  
		88       `"YbbdP'Y8 88       88  `"Ybbd8"'   "Y888 88  `"YbbdP"'  88       88 `"YbbdP"'  

*/

ChangePlayerName(playerid, newname[], type, bool:admin_cn = false)
{	
	new	Cache:result,
		counts;
	
	result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT sqlid FROM accounts WHERE name = '%e'", newname));
	counts = cache_num_rows();
	cache_delete(result);
	
	if(counts) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That nickname already exists!");
	
	new
		oldname[MAX_PLAYER_NAME];
	format( oldname, MAX_PLAYER_NAME, GetName(playerid, false));
	
	SendAdminMessage(COLOR_RED, "AdmWarn: [ChangeName Report] - Old Nick: %s, New Nick: %s", oldname, newname);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/namechange.txt", "(%s) {%d} Old nickname: %s | New nickname: %s",
		ReturnDate(),
		PlayerInfo[playerid][pSQLID],
		oldname,
		newname
	);
	#endif
	
	mysql_fquery(SQL_Handle(), "UPDATE accounts SET name = '%e', sex = '%d', age = '%d' WHERE sqlid = '%d'",
		newname,
		PlayerInfo[playerid][pSex],
		PlayerInfo[playerid][pAge],
		PlayerInfo[playerid][pSQLID]
	);
	
	PlayerJail[playerid][pArrested] = 0;
	LicenseInfo[playerid][pGunLic] 	= 0;
	
	if(admin_cn == (false)) {
		if(!PlayerVIP[playerid][pDonateRank])
			PlayerToBudgetMoney(playerid, 10000);
	}
	if(type == 1)
	{
		if(PlayerInfo[playerid][pLevel] < 10)
			PlayerInfo[playerid][pChangenames] = gettimestamp() + 172800; 
		else if(PlayerInfo[playerid][pLevel] >= 10 && PlayerInfo[playerid][pLevel] < 20)
			PlayerInfo[playerid][pChangenames] = gettimestamp() + 86400; 
	}
	else if(type == 2)
		PlayerInfo[playerid][pChangeTimes]--;
	
	va_SendClientMessage( playerid, 
		COLOR_RED, 
		"[!]: You sucessfully changed your nickname to %s, please relog with new nickname!", 
		newname
	);
	if(PlayerVIP[playerid][pDonateRank] > 0)
	{
		va_SendClientMessage( playerid, COLOR_RED, "[!]: You have %d free changenames left.", 
			PlayerInfo[playerid][pChangeTimes]
		);
	}
	KickMessage(playerid);
	return 1;
}

static HungerCheck(playerid)
{
	if(Player_IsWounded(playerid) || PlayerDeath[playerid][pKilled] > 0)
		return 1;
		
	new 
		Float:health;	
	if(PlayerHealth[playerid][pHunger] < 0.0) {
		if(PlayerGym[playerid][pMuscle] > 10) {
			PlayerHealth[playerid][pHunger] -= 0.001;
		} else PlayerHealth[playerid][pHunger] -= 0.006;
		
		if(PlayerHealth[playerid][pHunger] < -5.0) 
			PlayerHealth[playerid][pHunger] = -5.0;
	}
	else PlayerHealth[playerid][pHunger] -= 0.002;

	GetPlayerHealth(playerid, health);
	if(health < 100.0)
		SetPlayerHealth(playerid, health + PlayerHealth[playerid][pHunger]);
	else if(PlayerHealth[playerid][pHunger] < 0.0)
		SetPlayerHealth(playerid, health + PlayerHealth[playerid][pHunger]);
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if(GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

ReturnPlayerIP(playerid)
	return PlayerInfo[playerid][pIP];

IsValidName(name[])
{
	new length = strlen(name),
		namesplit[2][MAX_PLAYER_NAME],
		FirstLetterOfFirstname,
		FirstLetterOfLastname,
		ThirdLetterOfLastname,
		Underscore;

	split(name, namesplit, '_');
    if(strlen(namesplit[0]) > 1 && strlen(namesplit[1]) > 1)
    {
        // Firstname and Lastname contains more than 1 character + it there are separated with '_' char. Continue...
    }
    else return 0; // No need to continue...

    FirstLetterOfFirstname = namesplit[0][0];
	if(FirstLetterOfFirstname >= 'A' && FirstLetterOfFirstname <= 'Z')
	{
        // First letter of Firstname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	FirstLetterOfLastname = namesplit[1][0];
    if(FirstLetterOfLastname >= 'A' && FirstLetterOfLastname <= 'Z')
    {
		// First letter of Lastname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	ThirdLetterOfLastname = namesplit[1][2];
    if(ThirdLetterOfLastname >= 'A' && ThirdLetterOfLastname <= 'Z' || ThirdLetterOfLastname >= 'a' && ThirdLetterOfLastname <= 'z')
    {
		// Third letter of Lastname can be uppercase and lowercase (uppercase for Lastnames like McLaren). Continue...
	}
	else return 0; // No need to continue...

    for(new i = 0; i < length; i++)
	{
		if(name[i] != FirstLetterOfFirstname && name[i] != FirstLetterOfLastname && name[i] != ThirdLetterOfLastname && name[i] != '_')
		{
			if(name[i] >= 'a' && name[i] <= 'z')
			{
				// Name contains only letters and that letters are lowercase (except the first letter of the Firstname, first letter of Lastname and third letter of Lastname). Continue...
			}
			else return 0; // No need to continue...
		}

		// This checks that '_' char can be used only one time (to prevent names like this Firstname_Lastname_Something)...
		if(name[i] == '_')
		{
			Underscore++;
			if(Underscore > 1) return 0; // No need to continue...
		}
	}
	return 1; // All check are ok, Name is valid...
}

PrintAccent(playerid)
{
	new 
		string[64];
	
	if(!isnull(PlayerAppearance[playerid][pAccent]) || PlayerAppearance[playerid][pAccent][0] == EOS)
		format(string, 64, "");
	else if(strcmp(PlayerAppearance[playerid][pAccent], "None", true))
		format(string, 64, "[%s] ", PlayerAppearance[playerid][pAccent]);
    return string;
}

ClearPlayerChat(playerid)
{
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
}

ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5, bool:isDualChat = false)
{

	new Float:posx,
		Float:posy,
		Float:posz,
		Float:oldposx,
		Float:oldposy,
		Float:oldposz,
		Float:tempposx,
		Float:tempposy,
		Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

	foreach (new i : Player)
	{
		if(isDualChat == true && i == playerid)
			continue;

		
		if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)) {
			GetPlayerPos(i, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
			{
				SendClientMessage(i, col1, string);
			}
			else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
			{
				SendClientMessage(i, col2, string);
			}
			else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
			{
				SendClientMessage(i, col3, string);
			}
			else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
			{
				SendClientMessage(i, col4, string);
			}
			else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				SendClientMessage(i, col5, string);
			}
		}
	}
	return 1;
}

RealProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx,
		    Float:posy,
			Float:posz,
		    Float:oldposx,
		    Float:oldposy,
			Float:oldposz,
		    Float:tempposx,
			Float:tempposy,
			Float:tempposz,
			vehicleid = GetPlayerVehicleID(playerid),
			modelid = GetVehicleModel(vehicleid),
			vehicleid2,
			modelid2;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach (new i : Player)
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);

				if(IsPlayerInAnyVehicle(playerid) && !IsACabrio(modelid) && !Vehicle_Windows(vehicleid))
				{
					if(IsPlayerInVehicle(i, vehicleid))
					{
						SendClientMessage(i,col1,string); //skoci
					}
				}
				else
				{
					vehicleid2 = GetPlayerVehicleID(i);
					modelid2 = GetVehicleModel(vehicleid2);

					if(!IsPlayerInAnyVehicle(i) || IsACabrio(modelid2) || Vehicle_Windows(vehicleid2)) 
					{
						if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SendClientMessage(i, col1, string);
						}
						else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SendClientMessage(i, col2, string);
						}
						else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SendClientMessage(i, col3, string);
						}
						else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SendClientMessage(i, col4, string);
						}
						else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SendClientMessage(i, col5, string);
						}
					}
				}
			}
		}
	}
	return 1;
}

CarProxDetector(vehicleid, playerid, const string[], color)
{
	foreach(new i : Player) {
		if(IsPlayerInVehicle( i, vehicleid) && i != playerid)
			SendClientMessage( playerid, color, string);
	}
	return 1;
}

ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		if(( GetPlayerVehicleID(playerid) == GetPlayerVehicleID(targetid)) && GetPlayerVehicleID(playerid) != 0) 
			return 1;
			
	    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid))
		{
			new Float:posx,
			    Float:posy,
				Float:posz,
			    Float:oldposx,
				Float:oldposy,
				Float:oldposz,
			    Float:tempposx,
				Float:tempposy,
				Float:tempposz;

			GetPlayerPos(playerid, oldposx, oldposy, oldposz);

			GetPlayerPos(targetid, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				return 1;
		}
	}
	return 0;
}

OOCProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx,
		    Float:posy,
			Float:posz,
		    Float:oldposx,
		    Float:oldposy,
			Float:oldposz,
		    Float:tempposx,
			Float:tempposy,
			Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach (new i : Player)
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				if(!Player_HasBlockedOOCChat(i))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else if(Player_HasBlockedOOCChat(i) && (PlayerInfo[playerid][pAdmin] || PlayerInfo[playerid][pHelper]))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
			}
		}
	}
	return 1;
}

ShowPlayerStats(playerid, targetid)
{
	new
		tmpString[20],
		gender[10],
		motd[256],
		pDialog[1536];

	switch(PlayerInfo[targetid][pSex])
	{
		case 0: format(gender, sizeof(gender), "Musko"); // re-bug
		case 1: format(gender, sizeof(gender), "Musko");
		case 2: format(gender, sizeof(gender), "Zensko");
	}
		
	format(motd, sizeof(motd),"Datum: %s\n\n"COL_COABLUE"IC STATS:\n\n"COL_WHITE"%s | Spol: [%s] | Godina: [%d] | Mobile Nr.: [%d] | Crypto Nr.: [%d] | Novac: [$%d] | Banka: [$%d]\n",
		ReturnDate(),
		GetName(targetid,true),
		gender,
		PlayerInfo[targetid][pAge],
		PlayerMobile[targetid][pMobileNumber],
		PlayerMobile[targetid][pCryptoNumber],
		PlayerInfo[targetid][pMoney],
		PlayerInfo[targetid][pBank]
	);
    strcat(pDialog,motd, sizeof(pDialog));

    format(motd, sizeof(motd),""COL_WHITE"Posao: [%s] | Ugovor: [%d/%d] | Uhicen: [%d] | Profit po PayDayu: [$%d] | Organizacija: [%s] | Rank u organizaciji: [%s (%d)] | Hunger: [%.2f]\n",
		ReturnJob(PlayerJob[targetid][pJob]),
		PlayerJob[targetid][pContractTime],
		PlayerVIP[targetid][pDonateRank] ? 1 : 5,
		PlayerJail[targetid][pArrested],
		PaydayInfo[targetid][pPayDayMoney],
		ReturnPlayerFactionName(targetid),
		ReturnPlayerRankName(targetid),
		PlayerFaction[targetid][pRank],
		PlayerHealth[targetid][pHunger]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Bankovna stednja: [%dh / %dh] | Ulozeno novaca: [%d$] | Zabrana stednje: [%dh]\n\n\n",
		PlayerSavings[playerid][pSavingsTime],
		PlayerSavings[playerid][pSavingsType],
		PlayerSavings[playerid][pSavingsMoney],
		PlayerSavings[playerid][pSavingsCool]
	);
	strcat(pDialog,motd, sizeof(pDialog));

	switch( PlayerVIP[targetid][pDonateRank]) 
	{
		case PREMIUM_BRONZE: 	format(tmpString, 20, "Bronze");
		case PREMIUM_SILVER:	format(tmpString, 20, "Silver");
		case PREMIUM_GOLD:		format(tmpString, 20, "Gold");
		case PREMIUM_PLATINUM:	format(tmpString, 20, "Platinum");
		default:
			format(tmpString, 20, "Nista");
	}

    format(motd, sizeof(motd),""COL_COABLUE"OOC STATS:\n\n"COL_WHITE"SQL ID: [%d] | Level: [%d] | Premium Account: [%s] | Sati igranja: [%d] | Respekti: [%d/%d]\n",
		PlayerInfo[targetid][pSQLID],
		PlayerInfo[targetid][pLevel],
		tmpString,
		PlayerInfo[targetid][pConnectTime],
		PlayerInfo[targetid][pRespects],
		( PlayerInfo[targetid][pLevel] + 1) * 4
	);
    strcat(pDialog,motd, sizeof(pDialog));

    format(motd, sizeof(motd),""COL_WHITE"Muscle lvl: [%d] | Warnings: [%d/3] | Vrijeme do place: [%d minuta] | Donator Veh Perms: [%d] | Mobile Bill: [%d$]\n",
		PlayerGym[targetid][pMuscle],
		PlayerInfo[targetid][pWarns],
		( 60 - PaydayInfo[targetid][pPayDay]),
		PlayerVIP[targetid][pDonatorVehPerms],
		PlayerMobile[targetid][pMobileCost]
	);
    strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Zadnji puta IG: [%s]\n",
		PlayerInfo[targetid][pLastLogin]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"House key: [%d] | Biznis key: [%d] | Garage key: [%d] | RentKey[%d] | CarKey: [%d] | Job Key: [%d] | ComplexKey [%d] | ComplexRoomKey [%d]\n\n\n",
		PlayerKeys[targetid][pHouseKey],
		PlayerKeys[targetid][pBizzKey],
		PlayerKeys[targetid][pGarageKey],
		PlayerKeys[targetid][pRentKey],
		PlayerKeys[targetid][pVehicleKey],
		PlayerJob[targetid][pJob],
		PlayerKeys[targetid][pComplexKey],
		PlayerKeys[targetid][pComplexRoomKey]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{

		format(motd, sizeof(motd), ""COL_COABLUE"WEAPONS STATS:\n\n"COL_WHITE"Gun #1: [%d] | Gun #2: [%d] | Gun #3: [%d] | Gun #4: [%d] | Gun #5: [%d]\nGun #6: [%d] | Gun #7: [%d] | Gun #8: [%d] | Gun #9: [%d] | Gun #10: [%d]\n",
			PlayerWeapons[targetid][pwWeaponId][1],
			PlayerWeapons[targetid][pwWeaponId][2],
			PlayerWeapons[targetid][pwWeaponId][3],
			PlayerWeapons[targetid][pwWeaponId][4],
			PlayerWeapons[targetid][pwWeaponId][5],
			PlayerWeapons[targetid][pwWeaponId][6],
			PlayerWeapons[targetid][pwWeaponId][7],
			PlayerWeapons[targetid][pwWeaponId][8],
			PlayerWeapons[targetid][pwWeaponId][9],
			PlayerWeapons[targetid][pwWeaponId][10]
		);
		strcat(pDialog,motd, sizeof(pDialog));

		format(motd, sizeof(motd), "\n\n"COL_WHITE"Ammo #1: [%d] | Ammo #2: [%d] | Ammo #3: [%d] | Ammo #4: [%d] | Ammo #5: [%d]\nAmmo #6: [%d] | Ammo #7: [%d] | Ammo #8: [%d] | Ammo #9: [%d] | Ammo #10: [%d]\n",
			PlayerWeapons[targetid][pwAmmo][1],
			PlayerWeapons[targetid][pwAmmo][2],
			PlayerWeapons[targetid][pwAmmo][3],
			PlayerWeapons[targetid][pwAmmo][4],
			PlayerWeapons[targetid][pwAmmo][5],
			PlayerWeapons[targetid][pwAmmo][6],
			PlayerWeapons[targetid][pwAmmo][7],
			PlayerWeapons[targetid][pwAmmo][8],
			PlayerWeapons[targetid][pwAmmo][9],
			PlayerWeapons[targetid][pwAmmo][10]
		);
		strcat(pDialog,motd, sizeof(pDialog));
	}
    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, ""COL_COABLUE"Your Stats", pDialog, "OK", "");
	return 1;
}

SetPlayerScreenFade(playerid)
{
    BlindTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000, 0.000000, "_");
	PlayerTextDrawUseBox(playerid, BlindTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, BlindTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, BlindTD[playerid], 3);
	PlayerTextDrawLetterSize(playerid, BlindTD[playerid], 1.0, 100.0);
	PlayerTextDrawColor(playerid, BlindTD[playerid], 0x000000FF);
	PlayerTextDrawShow(playerid, BlindTD[playerid]);
	return 1;
}

RemovePlayerScreenFade(playerid)
{
	PlayerTextDrawHide(playerid, BlindTD[playerid]);
	PlayerTextDrawDestroy(playerid, BlindTD[playerid]);
	BlindTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}


GetPlayerPreviousInfo(playerid)
{
	GetPlayerPos(playerid, PlayerPrevInfo[playerid][oPosX], PlayerPrevInfo[playerid][oPosY], PlayerPrevInfo[playerid][oPosZ]);
	PlayerPrevInfo[playerid][oInt] = GetPlayerInterior(playerid);
	PlayerPrevInfo[playerid][oViwo] = GetPlayerVirtualWorld(playerid);
	return 1;
}

SetPlayerPreviousInfo(playerid)
{
	SetPlayerPos(playerid, PlayerPrevInfo[playerid][oPosX], PlayerPrevInfo[playerid][oPosY], PlayerPrevInfo[playerid][oPosZ]);
	SetPlayerInterior(playerid, PlayerPrevInfo[playerid][oInt]);
	SetPlayerVirtualWorld(playerid, PlayerPrevInfo[playerid][oViwo]);
	SetCameraBehindPlayer(playerid);
	ResetPlayerPreviousInfo(playerid);
	return 1;
}

ResetPlayerPreviousInfo(playerid)
{
	PlayerPrevInfo[playerid][oPosX]			= 0.0;
	PlayerPrevInfo[playerid][oPosY]			= 0.0;
	PlayerPrevInfo[playerid][oPosZ]			= 0.0;
	PlayerPrevInfo[playerid][oInt]			= 0;
	PlayerPrevInfo[playerid][oViwo]			= 0;
	return 1;
}

SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
	//StreamerSettings
	Streamer_ToggleIdleUpdate(playerid, 1);
	// Admin/Helper unfreeze
	if((PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0) && interior == 0 && viwo == 0)
		TogglePlayerControllable(playerid, 1);
	else TogglePlayerControllable(playerid, 0);
	
	//PlayerSets
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);
	
	//SettingPos
	SetPlayerPos(playerid, x, y, z);
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	
	if(update) defer InstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);
	
	return 1;
}

stock SetPlayerLookAt(playerid, Float:X, Float:Y)
{
    new
        Float:Px,
        Float:Py,
        Float:Pa;

    GetPlayerPos(playerid, Px, Py, Pa);

    Pa = floatabs(atan((Y-Py)/(X-Px)));
    if(X <= Px && Y >= Py) Pa = floatsub(180, Pa);
    else if(X < Px && Y < Py) Pa = floatadd(Pa, 180);
    else if(X >= Px && Y <= Py) Pa = floatsub(360.0, Pa);
    Pa = floatsub(Pa, 90.0);
    if(Pa >= 360.0) Pa = floatsub(Pa, 360.0);
    SetPlayerFacingAngle(playerid, Pa);
}

PlayerPlayTrackSound(playerid)
{
	defer StopPlayerTrackSound(playerid);
	PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
}

PlaySoundForPlayersInRange(soundid, Float:range, Float:x, Float:y, Float:z)
{
	foreach(new i: Player)
	{
	    if(Player_SafeSpawned(i) && IsPlayerInRangeOfPoint(i,range,x,y,z))
		    PlayerPlaySound(i, soundid, x, y, z);
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

hook OnGameModeInit()
{
	ResetPlayerEnumerator();
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
	if(!Player_SafeSpawned(playerid) || !IsPlayerConnected(playerid))
		return 0;

	if(!Player_SafeSpawned(playerid) || Player_SecurityBreach(playerid))
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR,"You can't use chat if you're not safely spawned!");
		return 0;
	}
	
	new 
		tmpString[144];
	text[0] = toupper(text[0]);
	
	if(!Player_MobileSpeaking(playerid))
	{
		if(IsPlayerInAnyVehicle(playerid)) 
		{
			format(tmpString, sizeof(tmpString), "%s says%s(vehicle): %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		else
		{
			format(tmpString, sizeof(tmpString), "%s says%s: %s", GetName(playerid), PrintAccent(playerid), text);
			RealProxDetector(6.5, playerid, tmpString,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		if(Player_AnimChat(playerid) && !Player_IsPerformingAnim(playerid))
		{
			if(strlen(text) > 0 && strlen(text) < 10) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,500,1,0);
			else if(strlen(text) >= 10 && strlen(text) < 20) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,1000,1,0);
			else if(strlen(text) >= 20 && strlen(text) < 30) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,1500,1,0);
			else if(strlen(text) >= 30 && strlen(text) < 40) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,2000,1,0);
			else if(strlen(text) >= 40 && strlen(text) < 50) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,2500,1,0);
			else if(strlen(text) >= 50 && strlen(text) < 61) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,3000,1,0);
			else if(strlen(text) >= 61 && strlen(text) < 71) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,0,1,1,0,3500,1,0);
			else if(strlen(text) >= 71 && strlen(text) < 81) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,4000,1,0);
			else if(strlen(text) >= 81 && strlen(text) < 91) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,4500,1,0);
			else if(strlen(text) >= 91 && strlen(text) < 101) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,5000,1,0);
			else if(strlen(text) >= 101 && strlen(text) < 111) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,5500,1,0);
			else if(strlen(text) >= 111 && strlen(text) < 121) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,6000,1,0);
			else if(strlen(text) >= 121 && strlen(text) < 131) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,6500,1,0);
			else if(strlen(text) >= 131 && strlen(text) < 141) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,7000,1,0);
			else if(strlen(text) >= 141 && strlen(text) < 151) 
				ApplyAnimationEx(playerid,"PED","IDLE_CHAT",4.0,1,1,1,0,7500,1,0);
		}
	}
	return 0;
}

hook OnPlayerDeath(playerid, reason)
{
	if(Player_InTrunk(playerid))
	{
		Player_SetInTrunk(playerid, false);
		Player_SetVehicleTrunk(playerid, INVALID_VEHICLE_ID);
	}
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	PlayerGlobalTaskTimer[playerid] = false;
	PlayerDrunkLevel[playerid]	= 0;
	PlayerFPSUnix[playerid]		= gettimestamp();
    BlockedOOC[playerid] = false;
    HasDice[playerid] = false;
    HasDrink[playerid] = false;
    HasFood[playerid] = false;
    FakeGunLic[playerid] = false;
    PlayerGroceries[playerid] = 0;

	if(Player_SafeSpawned(playerid))
	{
		stop PlayerTask[playerid];
		PlayerGlobalTaskTimer[playerid] = false;
	}

	RemovePlayerScreenFade(playerid);
	DisablePlayerCheckpoint(playerid);

	if(ADOText[playerid])
	{
		for(new i = 0; i < MAX_ADO_LABELS; i++)
		{
		    if(AdoLabels[i][labelid] == playerid)
		    {
		        AdoLabels[i][labelid] = 0;
                DestroyDynamic3DTextLabel(AdoLabels[i][label]);
		        ADOText[playerid] = 0;
		        break;
		    }
		}
	}
	ResetPlayerPreviousInfo(playerid);
	return continue(playerid);
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

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
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
	if(!PlayerGlobalTaskTimer[playerid] && Player_SafeSpawned(playerid))
	{
		PlayerGlobalTaskTimer[playerid] = true;
		PlayerTask[playerid] = repeat PlayerGlobalTask(playerid);
	}
		
	if(PlayerFPSUnix[playerid] < gettimestamp()) 
	{
		new 
			drunkLevel = GetPlayerDrunkLevel(playerid);
		if(drunkLevel < 100) 
			SetPlayerDrunkLevel(playerid, 2000);
		else 
		{
			if(PlayerDrunkLevel[playerid] != drunkLevel) 
				PlayerDrunkLevel[playerid] = drunkLevel;
		}
		PlayerFPSUnix[playerid] = gettimestamp();
	}
	return 1;
}