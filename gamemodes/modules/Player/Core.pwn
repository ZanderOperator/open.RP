#include <YSI\y_hooks>

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
#define PlayerNewUser_Set(%0,%1) \
		Bit1_Set(gr_NewUser,%0,%1)

//Provjera dali je igrac novi na serveru
#define IsANewUser(%0) \
	Bit1_Get(gr_NewUser,%0)

#define COLOR_RADIO		(0xFFEC8BFF)
#define COLOR_RADIOEX	(0xB5AF8FFF)

#define CP_JOB_GPS		(150)

/*
	######## #### ##     ## ######## ########   ######     ##     ##    ###    ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ##    ##     ##   ## ##   ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##          ##     ##  ##   ##  ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######     ##     ## ##     ## ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ##     ##   ##  ######### ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ##      ## ##   ##     ## ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######        ###    ##     ## ##     ##  ######  
*/

new LoginCheckTimer[MAX_PLAYERS],
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

new
	AdoLabels[MAX_ADO_LABELS][E_ADO_LABEL_INFO],
	Bit1:	gr_BlockedLIVE			<MAX_PLAYERS>,
	Bit1:	gr_BlockedOOC			<MAX_PLAYERS>;
	
new
	PlayerGPS[MAX_PLAYERS],
	PlayerDrunkLevel[MAX_PLAYERS],
    PlayerFPS[MAX_PLAYERS],
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

forward KickPlayer(playerid);
public KickPlayer(playerid)
	return Kick(playerid);
	
forward BanPlayer(playerid);
public BanPlayer(playerid)
	return Ban(playerid);

stock ResetGPSVars(playerid)
{
	DisablePlayerCheckpoint(playerid);
	PlayerGPS[playerid] = 0;
}
stock GetAdoFreeLabelSlot() {
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
      		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali prikvaceni opis.");
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
				    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali prikvaceni opis.");
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
			expamount = ( PlayerInfo[playerid][pLevel] + 1 ) * 4;
		if (PlayerInfo[playerid][pRespects] < expamount) {
			return 0;
		}

		PlayerInfo[playerid][pLevel]++;
		if(PlayerInfo[playerid][pDonateRank] > 0)
		{
			PlayerInfo[playerid][pRespects] -= expamount;
			new total = PlayerInfo[playerid][pRespects];
			if(total > 0) PlayerInfo[playerid][pRespects] = total;
			else
				PlayerInfo[playerid][pRespects] = 0;
		}
		else
			PlayerInfo[playerid][pRespects] = 0;

		new levelUpUpdate[90];
		format(levelUpUpdate, 90, "UPDATE `accounts` SET `levels` = '%d', `respects` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pLevel],
			PlayerInfo[playerid][pRespects],
			PlayerInfo[playerid][pSQLID]
		);
		mysql_pquery(g_SQL, levelUpUpdate);

		SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	}
	return 1;
}
 
stock BankTransferMoney(playerid, giveplayerid, MoneyAmmount)
{
	new
		btmpString[ 128 ],
		bankTransferQuery[128];
	PlayerInfo[ playerid ][ pBank ] -= MoneyAmmount;
	PlayerInfo[ giveplayerid ][ pBank ] += MoneyAmmount;
	va_SendInfoMessage(playerid, "Prebacili ste $%d na racun %s!", MoneyAmmount, GetName(giveplayerid,true));
	va_SendInfoMessage(giveplayerid, "%s vam je prebacio $%d na bankovni racun.", GetName(playerid,true), MoneyAmmount);
	format(bankTransferQuery, sizeof(bankTransferQuery), "UPDATE `accounts` SET `bankmoney` = '%d' WHERE sqlid = '%d'",
			PlayerInfo[ playerid ][ pBank ],
			PlayerInfo[ playerid ][ pSQLID]
		);
	mysql_tquery(g_SQL, bankTransferQuery, "");
	format(bankTransferQuery, sizeof(bankTransferQuery), "UPDATE `accounts` SET `bankmoney` = '%d' WHERE sqlid = '%d'",
			PlayerInfo[ giveplayerid ][ pBank ],
			PlayerInfo[ giveplayerid ][ pSQLID]
		);
	mysql_tquery(g_SQL, bankTransferQuery, "");
		
	if(MoneyAmmount >= 1000) {
		format(btmpString, sizeof(btmpString), "[A] Bank transfer: %s je prebacio $%d igracu %s", GetName(playerid, false), MoneyAmmount, GetName(giveplayerid, false));
		ABroadCast(COLOR_YELLOW,btmpString,1);
	}

	new
		balog[128];
	format(balog, sizeof(balog), "(%s) %s[%d] je prebacio $%d igracu %s[%d]",
		ReturnDate(),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		MoneyAmmount,
		GetName(giveplayerid, false),
		PlayerInfo[giveplayerid][pSQLID]
	);
	BankLog(balog);
	return 1;
}

/*SendRadioPoruku(radioChan, color, sstring[])
{
	foreach (new i : Player)
	{
		for(new s = 1 ; s < 3 ; s ++)
		{
			if(PlayerInfo[i][pRadio][s] == radioChan && PlayerInfo[i][pHasRadio] && Bit1_Get( gr_PlayerRadio, i ) )
			SendClientMessage(i, color, sstring);
		}
	}
}*/

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

Function: LoginCheck(playerid)
{
	if( !IsPlayerLogged(playerid) && IsPlayerConnected(playerid) )
	{
		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobio si kick nakon 60 sekundi!");
		KickMessage(playerid);
	}
	return 1;
}

Function: PlayerMinuteTask(playerid)
{
	PlayerTaskTStamp[playerid] = gettimestamp() + 60;
	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && LastVehicle[playerid] != INVALID_VEHICLE_ID) 
	{
		LastVehicleDriver[LastVehicle[playerid]] = INVALID_PLAYER_ID;
		LastVehicle[playerid] = INVALID_VEHICLE_ID;
	}
	PlayerInfo[playerid][pPayDay] += 1;
	if(PlayerInfo[playerid][pPayDay] >= 60)
		GivePlayerPayCheck(playerid);
		
	if(PlayerInfo[playerid][pJailTime] > 0)
		PlayerInfo[playerid][pJailTime] -= 1;
	else if(PlayerInfo[playerid][pJailTime] == 0 )
	{
		if( PlayerInfo[playerid][pJailed] == 1 )
		{
			SetPlayerPosEx(playerid, 90.6552, -236.3789, 1.5781, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Slobodni ste, platili ste svoj dug drustvu!");
		}
		else if( PlayerInfo[playerid][pJailed] == 2 )
		{
			SetPlayerPosEx(playerid, 1482.7426, -1740.1372, 13.7500, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pusten si iz Fort DeMorgana, pripazi na ponasanje i server pravila!");
		}
		else if( PlayerInfo[playerid][pJailed] == 3 )
		{
			SetPlayerPosEx(playerid, 636.7744,-601.3240,16.3359, 0, 0, false);
			GameTextForPlayer(playerid, "Slobodni ste, platili ste svoj dug drustvu!", 4000, 1);
		}
		PlayerInfo[playerid][pJailed] = 0;
		PlayerInfo[playerid][pJailTime] = 0;
	}
	else if(PlayerInfo[playerid][pJailTime] < 0)
		PlayerInfo[playerid][pJailTime] = 0;
		
		
	if(PlayerInfo[playerid][pDrugUsed] != 0)
	{
		if(-- PlayerInfo[playerid][pDrugSeconds] <= 0)
		{
			PlayerInfo[playerid][pDrugSeconds] = 0;
			PlayerInfo[playerid][pDrugUsed] = 0;
		}
	}
	if(PlayerInfo[playerid][pDrugOrder] > 0)
	{
		-- PlayerInfo[playerid][pDrugOrder];
	}
	
	HungerCheck(playerid);
	AFKCheck(playerid);
	AC_SavePlayerWeapons(playerid);
	return 1;	
}

/*new
	timercheck = 0;
*/
timer PlayerGlobalTask[1000](playerid)
{
	/*printf("PlayerGlobalTask took %d miliseconds!", tickcount() - timercheck);
	timercheck = tickcount();*/
	
	if ( !SafeSpawned[playerid] || !IsPlayerConnected(playerid) ) return 1;
	if( gettimestamp() >= PlayerTaskTStamp[playerid] )
		PlayerMinuteTask(playerid);	
	
	if(TaxiData[playerid][eTaxiActive] == true) {
		_TaximeterCount(playerid);
	}
	
	PlayerSyncs[ playerid ] = false;
	new tmphour,tmpmins,tmpsecs;
	GetServerTime(tmphour,tmpmins,tmpsecs);
	SetPlayerTime(playerid,tmphour,tmpmins);
	// Anti-Cheat
	if(PlayerTick[playerid][ptWeapon] < gettimestamp())
	{
		if( !IsPlayerAdmin(playerid) && !IsACop(playerid) && !PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pHelper] && !Bit1_Get( gr_PlayerACSafe, playerid ) )
		{
			AC_WeaponDetect(playerid);
			PlayerTick[playerid][ptWeapon] = gettimestamp();
			return 1;
		}
		if( Bit1_Get( gr_PlayerACSafe, playerid ) )
			Bit1_Set( gr_PlayerACSafe, playerid, false );
	}
	
	static
		pcar = INVALID_VEHICLE_ID;
	
	if((pcar = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		LastVehicle[playerid] = GetPlayerVehicleID(playerid);
		LastVehicleDriver[LastVehicle[playerid]] = playerid;
		GetVehiclePreviousInfo(LastVehicle[playerid]);
		
		static
			Float:vhealth;

		GetVehicleHealth(pcar, vhealth);
		
		if(vhealth < 250.0)
		{
			AC_SetVehicleHealth(pcar, 254.0);
			CallLocalFunction("OnPlayerCrashVehicle", "idf", playerid, pcar, 0.0);
			
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			
			GetVehicleParamsEx(pcar, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(pcar, 0, lights, alarm, doors, bonnet, boot, objective);
			
			VehicleInfo[pcar][vEngineRunning] = false;
		}
	}
	if(Bit1_Get(gps_Activated, playerid))
		gps_GetDistance(playerid, GPSInfo[playerid][gGPSID], GPSInfo[playerid][gX], GPSInfo[playerid][gY], GPSInfo[playerid][gZ]);
	
	CheckHouseInfoTextDraws(playerid); // House Info Textdraw removal if not in checkpoint 
	CheckWoundedPlayer(playerid);
	
	if(PlayerCarTow[playerid])
		VehicleTowTimer(PlayerInfo[playerid][pSpawnedCar], playerid);
	
	SprayingBarChecker(playerid);
	SprayingTaggTimer(playerid);
	
	PacketLossCheck(playerid);
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/**
    <summary>
        Funkcija za promjenu imena igracu.
    </summary>
	
	<param name="playerid">
        ID igraca kojem mijenjamo ime.
    </param>
	
	<param name="newname">
        Novo ime.
    </param>

    <returns>
        /
    </returns>

    <remarks>
        -
    </remarks>
*/

stock ChangePlayerName(playerid, newname[], type, bool:admin_cn = false)
{	
	new	Cache:result,
		counts,
		cnQuery[ 200 ];
	
	format(cnQuery, sizeof(cnQuery), "SELECT * FROM `accounts` WHERE `name` = '%q' LIMIT 0,1", newname);
	result = mysql_query(g_SQL, cnQuery);
	counts = cache_num_rows();
	cache_delete(result);
	
	if( counts ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj nick vec postoji!");
	
	new
		oldname[MAX_PLAYER_NAME];
	format( oldname, MAX_PLAYER_NAME, GetName(playerid, false) );
	
	new log[100];
	format( log, sizeof(log), "[ChangeName Report]: Stari nick: %s, novi nick: %s", oldname, newname);
	SendAdminMessage(COLOR_RED, log);
	
	Log_Write("logfiles/namechange.txt", "(%s) {%d} Stari nick: %s, novi nick: %s",
		ReturnDate(),
		PlayerInfo[ playerid ][ pSQLID ],
		oldname,
		newname
	);
	
	// MySQL
	format(cnQuery, sizeof(cnQuery), "INSERT INTO `player_changenames`(`player_id`, `old_name`, `new_name`) VALUES ('%d','%q','%q')",
		PlayerInfo[ playerid ][ pSQLID ],
		oldname,
		newname
	);
	mysql_pquery(g_SQL, cnQuery, "");
	
	format(cnQuery, sizeof(cnQuery), "UPDATE `accounts` SET `name` = '%q', `sex` = '%d' WHERE `sqlid` = '%d'",
		newname,
		PlayerInfo[ playerid ][pAge],
		PlayerInfo[ playerid ][ pSQLID ]
	);
	mysql_pquery(g_SQL, cnQuery, "");
	
	PlayerInfo[ playerid ][ pArrested ] = 0;
	PlayerInfo[ playerid ][ pGunLic ] 	= 0;
	SavePlayerData(playerid);
	
	if(admin_cn == (false)) {
		if( !PlayerInfo[ playerid ][ pDonateRank ] )
			PlayerToBudgetMoney( playerid, 10000);
	}
	if(type == 1)
	{
		if(PlayerInfo[playerid][pLevel] < 10)
			PlayerInfo[ playerid ][ pChangenames ] = gettimestamp() + 172800; // 2 dana
		else if(PlayerInfo[playerid][pLevel] >= 10 && PlayerInfo[playerid][pLevel] < 20)
			PlayerInfo[ playerid ][ pChangenames ] = gettimestamp() + 86400; // 1 dan
	}
	else if(type == 2)
		PlayerInfo[playerid][pChangeTimes]--;
	
	// Poruka
	va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste promjenili ime u %s, ponovno se logirajte s novim imenom!", newname);
	if(PlayerInfo[playerid][pDonateRank] > 0)
		va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Preostalo Vam je %d besplatnih changenameova.", PlayerInfo[playerid][pChangeTimes]);
	KickMessage(playerid);
	return 1;
}

/**
    <summary>
        Provjera za hunger sistem.
    </summary>
	
	<param name="playerid">
        ID igraca na kojem ce se vrSiti provjera.
    </param>

    <returns>
        /
    </returns>

    <remarks>
        -
    </remarks>
*/
stock static HungerCheck(playerid)
{
	if(PlayerWounded[playerid] || PlayerInfo[playerid][pKilled] > 0)
		return 1;
		
	new 
		Float:health;	
	if( PlayerInfo[ playerid ][ pHunger ] < 0.0 ) {
		if( PlayerInfo[ playerid ][ pMuscle ] > 10 ) {
			PlayerInfo[playerid][pHunger] -= 0.001;
		} else PlayerInfo[playerid][pHunger] -= 0.006;
		
		if( PlayerInfo[ playerid ][ pHunger ] < -5.0 ) 
			PlayerInfo[ playerid ][ pHunger ] = -5.0;
	}
	else PlayerInfo[ playerid ][ pHunger ] -= 0.002;

	GetPlayerHealth(playerid, health);
	if(health < 100.0)
		SetPlayerHealth(playerid, health + PlayerInfo[playerid][pHunger]);
	else if(PlayerInfo[playerid][pHunger] < 0.0)
		SetPlayerHealth(playerid, health + PlayerInfo[playerid][pHunger]);
	return 1;
}
/**
    <summary>
		Dobavlja igracevo ime te po potrebi mice "_"iz njega.
    </summary>
	
	<param name="playerid">
        Samo objaSnjivo.
    </param>
	
	<param name="replace">
        Bool vrijednost koja pita dali cemo micati '_' ili ne.
    </param>

    <returns>
        Igracev nick bez '_'
    </returns>

    <remarks>
        -
    </remarks>
*/
stock GetName(playerid, bool:replace=true)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	
	if( replace ) {
		if( Bit1_Get( gr_MaskUse, playerid ) )
			format(name, 24, "Maska_%d", PlayerInfo[ playerid ][ pMaskID ] );
		else 
			strreplace(name, '_', ' ');
	}
	return name;
}

/**
    <summary>
        Uzimamo igracev IP.
    </summary>
	
	<param name="playerid">
        Samo objaSnjivo.
    </param>

    <returns>
        Igracev IP.
    </returns>

    <remarks>
        -
    </remarks>
*/
		
/*GetPlayerIP(playerid)
{
	new 
		dest[24];
	GetPlayerIp(playerid, dest, 24);
    return dest;
}*/

/**
    <summary>
        Provjerava dali je igracev nick po RP pravilima (Ime_Prezime)
    </summary>
	
	<param name="name">
        Ime od igraca
    </param>

    <returns>
        1 - Nick po pravilima, 0 - Nick nije po pravilima
    </returns>

    <remarks>
        -
    </remarks>
*/
IsValidName(name[])
{
	new length = strlen(name),
		namesplit[2][MAX_PLAYER_NAME],
		FirstLetterOfFirstname,
		FirstLetterOfLastname,
		ThirdLetterOfLastname,
		Underscore;

	split(name, namesplit, '_');
    if (strlen(namesplit[0]) > 1 && strlen(namesplit[1]) > 1)
    {
        // Firstname and Lastname contains more than 1 character + it there are separated with '_' char. Continue...
    }
    else return 0; // No need to continue...

    FirstLetterOfFirstname = namesplit[0][0];
	if (FirstLetterOfFirstname >= 'A' && FirstLetterOfFirstname <= 'Z')
	{
        // First letter of Firstname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	FirstLetterOfLastname = namesplit[1][0];
    if (FirstLetterOfLastname >= 'A' && FirstLetterOfLastname <= 'Z')
    {
		// First letter of Lastname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	ThirdLetterOfLastname = namesplit[1][2];
    if (ThirdLetterOfLastname >= 'A' && ThirdLetterOfLastname <= 'Z' || ThirdLetterOfLastname >= 'a' && ThirdLetterOfLastname <= 'z')
    {
		// Third letter of Lastname can be uppercase and lowercase (uppercase for Lastnames like McLaren). Continue...
	}
	else return 0; // No need to continue...

    for(new i = 0; i < length; i++)
	{
		if (name[i] != FirstLetterOfFirstname && name[i] != FirstLetterOfLastname && name[i] != ThirdLetterOfLastname && name[i] != '_')
		{
			if(name[i] >= 'a' && name[i] <= 'z')
			{
				// Name contains only letters and that letters are lowercase (except the first letter of the Firstname, first letter of Lastname and third letter of Lastname). Continue...
			}
			else return 0; // No need to continue...
		}

		// This checks that '_' char can be used only one time (to prevent names like this Firstname_Lastname_Something)...
		if (name[i] == '_')
		{
			Underscore++;
			if (Underscore > 1) return 0; // No need to continue...
		}
	}
	return 1; // All check are ok, Name is valid...
}

/**
    <summary>
        Daje informacije o igracevu FPSu.
    </summary>
	
	<param name="playerid">
        Playerid od igraca.
    </param>

    <returns>
        Igracev FPS.
    </returns>

    <remarks>
        -
    </remarks>
*/
stock GetPlayerFPS(playerid)
	return PlayerFPS[playerid];

/**
    <summary>
        Daje igracev nick od njegovog MySQL IDa
    </summary>
	
	<param name="sqlid">
        MySQL ID od igraca
    </param>

    <returns>
        Igracev nick
    </returns>

    <remarks>
        -
    </remarks>
*/
stock GetPlayerNameFromSQL(sqlid)
{
    new
		dest[MAX_PLAYER_NAME];
	if( sqlid > 0 ) {
	    new	Cache:result,
			playerQuery[ 128 ];

		format(playerQuery, sizeof(playerQuery), "SELECT `name` FROM `accounts` WHERE `sqlid` = '%d'", sqlid);
		result = mysql_query(g_SQL, playerQuery);
		cache_get_value_index(0, 0, dest);
		cache_delete(result);
	} else {
		format(dest, MAX_PLAYER_NAME, "None");
	}
	return dest;
}

/**
    <summary>
        Daje igracev broj od njegovog MySQL IDa
    </summary>
	
	<param name="sqlid">
        MySQL ID od igraca
    </param>

    <returns>
        Igracev broj
    </returns>

    <remarks>
        -
    </remarks>
*/
stock GetPlayerMobileNumberFromSQL(sqlid)
{
    new
		dest = 0;
	if( sqlid > 0 ) {
	    new	Cache:result,
			mobileQuery[ 128 ];

		format(mobileQuery, sizeof(mobileQuery), "SELECT `number` FROM `player_phones` WHERE `player_id` = '%d' AND `type` = '1'", sqlid);
		result = mysql_query(g_SQL, mobileQuery);
  		cache_get_value_index_int(0, 0, dest);
		cache_delete(result);
	} 
	return dest;
}

////////
PrintAccent(playerid)
{
	new 
		string[64];
	
	if(!isnull(PlayerInfo[playerid][pAccent]) || PlayerInfo[playerid][pAccent][0] == EOS)
		format(string, 64, "");
	else if( strcmp(PlayerInfo[playerid][pAccent], "None", true) )
		format(string, 64, "[%s] ", PlayerInfo[playerid][pAccent]);
    return string;
}

stock ClearPlayerChat(playerid)
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

stock OOCProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
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
				if( !Bit1_Get(gr_BlockedOOC, i) )
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else if(Bit1_Get(gr_BlockedOOC, i) && (PlayerInfo[playerid][pAdmin] || PlayerInfo[playerid][pHelper]))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
			}
		}
	}
	return 1;
}

stock ReportMessage(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && !Bit1_Get( a_TogReports, i ) )
			SendClientMessage(i, color, string);
		else if( PlayerInfo[i][pHelper] )
			SendClientMessage(i, color, string);
	}
	return 1;
}

stock GetPlayerNameFromID(mysqlid)
{
	new 
		name[MAX_PLAYER_NAME];
		
	if(mysqlid == 9999) {
		format(name, MAX_PLAYER_NAME, "None");
		return name;
	}
	
	new
		nameQuery[ 128 ],
		Cache:result;
	
	format(nameQuery, 128, "SELECT `name` FROM `accounts` WHERE `sqlid` = '%d'", mysqlid);
	result = mysql_query(g_SQL, nameQuery);
	
	cache_get_value_name(0, "name",  name);
	cache_delete(result);
	return name;
}

// Pokazuje stats dialog igracu (targetid-u).
stock ShowPlayerStats(playerid, targetid)
{
	new
		tmpString[ 20 ],
		motd[ 256 ], gender[15+1], b_coowner[4];

	switch(PlayerInfo[targetid][pSex])	{
		case 0: format(gender, sizeof(gender), "Musko"); // re-bug
		case 1: format(gender, sizeof(gender), "Musko");
		case 2: format(gender, sizeof(gender), "Zensko");
	}
	if(PlayerInfo[playerid][BizCoOwner] == true)
		format(b_coowner, sizeof(b_coowner), "Da");
	else if(PlayerInfo[playerid][BizCoOwner] == false)
		format(b_coowner, sizeof(b_coowner), "Ne");
		
    new pDialog[1500];
	format(motd, sizeof(motd),"\t\t\t\t\t%s\n"COL_COABLUE"IC STATS:\n\n"COL_WHITE"%s | Spol: [%s] | Godina: [%d] | Crypto broj: [%d] | Novac: [$%d]\nBanka: [$%d] | Broj telefona: [%d]\n",
		ReturnDate(),
		GetName(targetid,true),
		gender,
		PlayerInfo[targetid][pAge],
		PlayerInfo[targetid][pCryptoNumber],
		PlayerInfo[targetid][pMoney],
		PlayerInfo[targetid][pBank],
		PlayerInfo[targetid][pMobileNumber]
	);
    strcat(pDialog,motd, sizeof(pDialog));

	switch(PlayerInfo[targetid][pJob])  {
         case 1:  format(tmpString, 11, "Cistac ulica");
         case 2:  format(tmpString, 11, "Pizza Boy");
         case 3:  format(tmpString, 11, "Mehanicar");
         case 4:  format(tmpString, 13, "Kosac trave");
         case 5:  format(tmpString, 18, "Tvornicki radnik");
         case 6:  format(tmpString, 11, "Taksist");
         case 7:  format(tmpString, 11, "Farmer");
		 case 8:  format(tmpString, 11, "Nepoznato");
         case 9:  format(tmpString, 11, "Nepoznato");
         case 12: format(tmpString, 12, "Gun Dealer");
         case 13: format(tmpString, 12, "Car Jacker");
         case 14: strcat(tmpString, "Drvosjeca", 12);
         case 15: format(tmpString, 12, "Nepoznato");
         case 16: format(tmpString, 11, "Smetlar");
         case 17: format(tmpString, 11, "Vehicle Impounder");
         case 18: format(tmpString, 11, "Transporter");
         case 19: format(tmpString, 11, "Nepoznato");
         case 20: format(tmpString, 11, "Nepoznato");
         case 21: format(tmpString, 11, "Nepoznato");
		 case 22: format(tmpString, 11, "Nepoznato");
		 case 23: format(tmpString, 11, "Nepoznato");
         case 24: format(tmpString, 11, "Nepoznato");
         case 25: format(tmpString, 11, "Nepoznato");
         default: format(tmpString, 11, "Nezaposlen");
    }
	/*new
		tmpMarried[MAX_PLAYER_NAME];
	if(!isnull(PlayerInfo[targetid][pMarriedTo]))
		format( tmpMarried, MAX_PLAYER_NAME, PlayerInfo[targetid][pMarriedTo] );
	else
		format( tmpMarried, MAX_PLAYER_NAME, "Nikim");*/
	//ispred Posao: fali Ozenjen s: %s
    format(motd, sizeof(motd),""COL_WHITE"Posao: [%s] | Ugovor: [%d/%d] | Uhicen: [%d] | Iznos na deviznom racunu: [$%d] | Organizacija: [%s] | Rank u organizaciji: [%s (%d)] | Hunger: [%.2f]\n",
		//tmpMarried,
		tmpString,
		PlayerInfo[targetid][pContractTime],
		PlayerInfo[targetid][pDonateRank] ? 1 : 5,
		PlayerInfo[targetid][pArrested],
		PlayerInfo[targetid][pPayDayMoney],
		ReturnPlayerFactionName(targetid),
		ReturnPlayerRankName(targetid),
		PlayerInfo[targetid][pRank],
		PlayerInfo[targetid][pHunger]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Bankovna stednja: [%dh / %dh] | Ulozeno novaca: [%d$] | Zabrana stednje: [%dh]\n\n\n",
		PlayerInfo[targetid][pSavingsTime],
		PlayerInfo[targetid][pSavingsType],
		PlayerInfo[targetid][pSavingsMoney],
		PlayerInfo[targetid][pSavingsCool]
	);
	strcat(pDialog,motd, sizeof(pDialog));

	switch( PlayerInfo[targetid][pDonateRank] ) {
		case 1: format(tmpString, 11, "Bronze");
		case 2:	format(tmpString, 11, "Silver");
		case 3:	format(tmpString, 11, "Gold");
		case 4: format(tmpString, 11, "Platinum");
		default:
			format(tmpString, 11, "Nista");
	}

    format(motd, sizeof(motd),""COL_COABLUE"OOC STATS:\n\n"COL_WHITE"SQL ID: [%d] | Level: [%d] | Premium Account: [%s] | Sati igranja: [%d] | Respekti: [%d/%d]\n",
		PlayerInfo[targetid][pSQLID],
		PlayerInfo[targetid][pLevel],
		tmpString,
		PlayerInfo[targetid][pConnectTime],
		PlayerInfo[targetid][pRespects],
		( PlayerInfo[targetid][pLevel] + 1 ) * 4
	);
    strcat(pDialog,motd, sizeof(pDialog));

    format(motd, sizeof(motd),""COL_WHITE"Muscle lvl: [%d] | Warnings: [%d/3] | Vrijeme do place: [%d minuta] | VIP Vozilo: [%d] | Donator Veh Perms: [%d] | Mobile Credits: [%d$]\n",
		PlayerInfo[targetid][pMuscle],
		PlayerInfo[targetid][pWarns],
		( 60 - PlayerInfo[targetid][pPayDay] ),
		PlayerInfo[targetid][pDonatorVehicle],
		PlayerInfo[targetid][pDonatorVehPerms],
		PlayerInfo[targetid][pMobileCost]
	);
    strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Zadnji puta IG: [%s]\n",
		PlayerInfo[targetid][pLastLogin]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"House key: [%d] | Biznis key: [%d] | Garage key: [%d] | RentKey[%d] | CarKey: [%d] | Job Key: [%d] | ComplexKey [%d] | ComplexRoomKey [%d] | Biznis Co-Owner [%s/%d]\n\n\n",
		PlayerInfo[targetid][pHouseKey],
		PlayerInfo[targetid][pBizzKey],
		PlayerInfo[targetid][pGarageKey],
		PlayerInfo[targetid][pRentKey],
		PlayerInfo[targetid][pSpawnedCar],
		PlayerInfo[targetid][pJob],
		PlayerInfo[targetid][pComplexKey],
		PlayerInfo[targetid][pComplexRoomKey],
		b_coowner,
		PlayerInfo[targetid][pBusiness]	
	);
	strcat(pDialog,motd, sizeof(pDialog));
	if( PlayerInfo[playerid][pAdmin] >= 1 )
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
    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, ""COL_COABLUE"City of Angels Stats", pDialog, "U redu", "");
	return 1;
}

Function: SayHelloToPlayer(playerid)
{
	//Hello Message
	new 
		string[85];
	format(string, 85, "~w~Dobro dosli~n~~h~~h~~b~%s", GetName(playerid));
	GameTextForPlayer(playerid, string, 2500, 1);
	Bit1_Set( gr_FristSpawn, playerid, false );
	return 1;
}

stock SetPlayerScreenFade(playerid)
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

stock RemovePlayerScreenFade(playerid)
{
	PlayerTextDrawHide(playerid, BlindTD[playerid]);
	PlayerTextDrawDestroy(playerid, BlindTD[playerid]);
	BlindTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
stock IllegalFactionJobCheck(factionid, jobid)
{
    new	Cache:result,
		counts,
		tmpQuery[256];

	format(tmpQuery, sizeof(tmpQuery), "SELECT * FROM `accounts` WHERE `jobkey` = '%d' AND (`facMemId` = '%d' OR `facLeadId` = '%d')", jobid, factionid, factionid);
	result = mysql_query(g_SQL, tmpQuery);
	counts = cache_num_rows();
	cache_delete(result);
	
	return counts;
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
hook OnPlayerConnect(playerid) 
{
    PlayerDrunkLevel[playerid]	= 0;
    PlayerFPS[playerid]       	= 0;
	PlayerFPSUnix[playerid]		= gettimestamp();
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(SafeSpawned[playerid])
	{
		stop PlayerTask[playerid];
		PlayerGlobalTaskTimer[playerid] = false;
	}
	
	RemovePlayerScreenFade(playerid);
	DisablePlayerCheckpoint(playerid);
	PlayerGPS[playerid] 		= 0;
    PlayerDrunkLevel[playerid]	= 0;
    PlayerFPS[playerid]       	= 0;
	PlayerFPSUnix[playerid]		= 0;
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
	return 1;
}
/*
public OnPlayerPause(playerid)
{
	if(SafeSpawned[playerid])
	{
		stop PlayerTask[playerid];
		PlayerGlobalTaskTimer[playerid] = false;
	}
	return 1;
}*/

hook OnPlayerUpdate(playerid) 
{
	if(!PlayerGlobalTaskTimer[playerid] && SafeSpawned[playerid])
	{
		PlayerGlobalTaskTimer[playerid] = true;
		PlayerTask[playerid] = repeat PlayerGlobalTask(playerid);
	}
		
	if( PlayerFPSUnix[playerid] < gettimestamp() ) 
	{
		new drunkLevel = GetPlayerDrunkLevel(playerid);
		if( drunkLevel < 100 ) {
			SetPlayerDrunkLevel(playerid, 2000);
		} else {
			if( PlayerDrunkLevel[playerid] != drunkLevel ) {
				new 
					restFPS = PlayerDrunkLevel[playerid] - drunkLevel;
				if( ( restFPS > 0 ) && ( restFPS < 200 ) )
					PlayerFPS[playerid] = restFPS;
				PlayerDrunkLevel[playerid] = drunkLevel;
			}
		}
		PlayerFPSUnix[playerid] = gettimestamp();
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_RULES: {
			if( !response ) return 1;
			switch(listitem) {
				case 0: {
					new string[835];
					strcat(string,"Metagaming - Metagaming najcesce predstavlja mijesanje Out Of Characted (OOC) i In Character (IC) stvari. Naravno,\n takav vid krsenja pravila se moze ispoljiti na vise nacina ali najcesci su:\n 1.) Citanje nametaga iznad igraca te dozivanje istoga IC iako ga ne poznajete ili nikada niste ni culi njegovo ime", sizeof(string));
					strcat(string,"\n 2.) Koristenje /pm komande kako bi se nasli negdje radi neke IC stvari,\n tipa prodaja oruzja, droge ili jednostavno radi neke price. U ovaj vid krsenja pravila se takodje ubraja i\n koristenje 3rd party programa kako bi se nasli negdje IC.", sizeof(string));
					strcat(string,"\n 3.) Koristenje informacija koje ste saznali OOC za IC svrhe je takodje zabranjeno.\n Primjer, ako ste culi da dolazi policija da vas uhapsi OOC i iskoristite to IC kako bi pobjegli daleko od njih kako vas ne mogu naci.", sizeof(string));
					strcat(string,"\n Sve ovo je kaznjivo i strogo zabranjeno na nasem serveru.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Metagaming", string, "Zatvori", "");
					return 1;
				}
				case 1: {
					new string[860];
					strcat(string, "Powergaming - Powergaming je, u najcescim slucajevima, roleplay radnje koja u tom trenutku nije moguca ili uopste nije moguca, za ljudsko tijelo ili slicno.\n Naravno, i powergaming kao metagaming moze biti na vise nacina uradjen. Takodje kaznjih. Najcesce radnje su:\n 1. Skakanje sa neke odredjene visine koja je dovoljna da vas povrijedi pri padu i udari o tlo a da se povreda na roleplaya nego igrac jednostavno ustane i nastavi dalje.", sizeof(string));
					strcat(string, "\n 2. Zavezani ste lisicama a onda roleplayate da jednostavno lomite lisice. To u, barem toj situaciji, nije nikako moguce.", sizeof(string));
					strcat(string, "\n 3. Drzi vas jedan lik sa ledja dok vas drugi udara sprijeda, vi se okrenete i prebacite jednoga preko ledja a drugoga kung-fu potezom udarite u glavu i pobjegnete.\n Velika je vjerovatnoca da ovo nikako ne mozete izvesti, tako da se i ovo smatra powergamingom. Svaki vid powergaminga je kaznjiv.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Powergaming", string, "Zatvori", "");
					return 1;
				}
				case 2: {
					new string[720];
					strcat(string, "RP2WIN - RP2WIN je roleplay sa nekom drugom osobom u kojem forsirate, bukvalno, da sve ide u vasu korist.\n Nesto sto moze da vam priblizi ovu radnju je sledeci me: / me sutira Ime_Prezime ta ga obara na pod izazivajuci mu nesvijest.\n Ovo je zabranjeno raditi jer u roleplayu treba svakome dati pravednu sansu da odradi svoju stranu RP-a.\n Pravilan me bi trebao glasiti: / me pokusava udariti Ime_Prezime kako bi ga oborio na pod.", sizeof(string));
					strcat(string, "\n Tek kada vidite da li je igrac pao, odatle mozete nove situacije RPati. Naravno, RP2WIN moze da se izrazi i kada se branite.\n Ukoliko neko iskoristi nesto slicno drugom me-u, a vi samo napisete da vas je promasio ili da ste se izmakli takodje moze biti vid RP2WINa ali takodje i PGa.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "RP2WIN", string, "Zatvori", "");
					return 1;
				}
				case 3: {
					new string[480];
					strcat(string, "Revenge Kill - Revenge Kill kao sto samo ime kaze je ubojstvo iz osvete.\n Kada se dogodi ubojstvo, vi morate zaboraviti SVE u vezi tog dogadjaja. Mjesto ubojstva, pocinjitela, ucesnike.", sizeof(string));
					strcat(string, "Sve.\n Jednostavno nastavljate RPati kao da se to nikada nije dogodilo ali ako ste prezivjeli, naravno,\n imate svako pravo da RPate da se to dogodilo i imate pravo juriti toga koji vas je pokusao ubiti, onda ne bi bio revenge kill\n vec pokusaj ubojstva koji nije uspio.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Revenge Kill", string, "Zatvori", "");
					return 1;
				}
				case 4: {
					new string[320];
					strcat(string, "Deathmatch - Vjerovatno znate o cemu se radi. DM je ubijanje ljudi bez ikakvog ili bez dovoljno dobrog IC razloga.\n Nedovoljno dobar razlog moze predstavljati to", sizeof(string));
					strcat(string, "sto vas je igrac mrko pogledao a vi ste ispraznili citav sarzer u njega.\n Ovo je STROGO zabranjeno na nasem serveru i isto tako je kaznjivo.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Deathmatch", string, "Zatvori", "");
					return 1;
				}
				case 5: {
					new string[640];
					strcat(string, "-/me koristite kako bi prikazali radnju koju vas karakter izvrsava u odredjenom trenutku.\n Nema pisanja predugackih /me emotesa sa 5 priloski odredbi za nacin koje zavrsavaju na -ci.\n To je bespotrebno i niste bolji rper ako napisete kilometarski /me.", sizeof(string));
					strcat(string, "\n Ali i ako dodjete u situaciju da napisete sve u jedan /me probajte da tu ne budu\n vise od 3 radnje/glagola jer je onda to PG. Dakle,trudite se citljive i jednostavne\n emotese pisati da vas ljudi koji rpaju sa vama razumiju.", sizeof(string));
					strcat(string, "\n Imenko_Prezimenko vadi kutiju cigareta i lijevog dzepa. \n Imenko_Prezimenko uzima jednu cigaretu te ju pali.\n Ovo su primjeri dobrog koristenja /me emotesa.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/me komanda", string, "Zatvori", "");
					return 1;
				}
				case 6: {
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/ame komanda", "-/ame je ustvari isto sto i /me samo ce se tekst koji upisete ispisati vama iznad glave.\nDakle ako upisete /ame gleda kako Johnny jede, ono sto ce iznad vase glave pisati je Imenko_Prezimenko gleda kako Johnny jede.\n/ame jos mozete koristiti za izrazavanje emocija vaseg lika, kao npr /ame se smije. Takodjer se moze koristiti da opisete svoj izgled tj. izgled svoga lika.", "Zatvori", "");
					return 1;
				}
				case 7: {
					new string[660];
					strcat(string, "/Do emotes koristite kako bi opisali ono sto se desava oko vas, tj okolinu u kojoj se vas karakter nalazi.\n /Do emotes ne KORISTITE da bi prikazali sta vas karakter radi jer je za to /me. Nema smisla pisati /do Rukujemo se, /do Izgledam kao da imam 15 godina.\n Znaci trudite se da ga ne koristite ni da opisete svog karaktera tako cesto, jer za to mozete koristiti i /ame.\n /ame izgleda kao da ima 15 godina, crne hlace i duks.", sizeof(string));
					strcat(string, "Evo par primjera ispravnog koristenja /do komande:\n /Do Iz pravca mehanicarske radnje bi dolazio miris ulja radi vozila koja sa tamo popravljaju.\n /Do Kafic bi bio sav u neredu, stolice su prevrnute kao i stolovi.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/do komanda", string, "Zatvori", "");
					return 1;
				}
			}
			return 1;
		}
		case DIALOG_GPS: {
			if( !response ) return 1;
			
			if(Bit1_Get(gr_IsWorkingJob, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
			if( PlayerGPS[playerid] == 1 ) 
			{
				PlayerGPS[playerid] = 0;
				DisablePlayerCheckpoint(playerid);
			}
			switch( listitem )
			{
				case 0: // Oglasnik
					SetPlayerCheckpoint(playerid, 644.3640, -1356.4607, 12.5537, 6.0);
				case 1:  // Smetlar
					SetPlayerCheckpoint(playerid, 1633.6230, -1897.1713, 12.5388, 6.0);
				case 2: 
					SetPlayerCheckpoint(playerid, 1861.2922, -1055.9939, 22.8179, 6.0);
				case 3:
					SetPlayerCheckpoint(playerid, 2273.4934, -2038.6593, 12.5455, 6.0);
				case 4:
					SetPlayerCheckpoint(playerid, 1482.3052, -1768.5254, 17.7344, 6.0);
				case 5: // Bolnica
					SetPlayerCheckpoint(playerid, 2002.0333,-1445.8385,13.5613, 6.0);
				case 6: // Pizza Stack
					SetPlayerCheckpoint(playerid, 2089.2891, -1806.2827, 12.5446, 6.0);
				case 7:  // Verona Mall
					SetPlayerCheckpoint(playerid, 1131.4037, -1413.3622, 12.6116, 6.0);
				case 8: // Wang Cars
					SetPlayerCheckpoint(playerid,1695.8186, -1767.6010, 12.5412, 6.0);
				case 9:
					SetPlayerCheckpoint(playerid, 1829.1669, -1682.2930, 12.5409, 6.0);
				case 10: 
					SetPlayerCheckpoint(playerid, 2011.3667,-2025.3188,13.5469, 6.0);
				case 11: 
					SetPlayerCheckpoint(playerid, 2274.6538,-1106.4972,37.9766, 6.0);
				case 12: 
					SetPlayerCheckpoint(playerid, -222.6235,2609.8589,62.7031, 6.0);
				case 13: 
					SetPlayerCheckpoint(playerid,-276.1619,-2186.8630,28.7437, 6.0);
				case 14: 
				{ // Ugasi
					PlayerGPS[playerid] = 0;
					DisablePlayerCheckpoint(playerid);
					GameTextForPlayer(playerid, "~g~GPS je ugasen!", 1500, 1);
					return 1;
				}
			}	
			PlayerGPS[playerid] = 1;
			return 1;
		}
	}
	return 0;
 }

hook OnPlayerEnterCheckpoint(playerid)
{
	if( PlayerGPS[playerid] == 1 )
	{
		DisablePlayerCheckpoint(playerid);
		PlayerGPS[playerid] = 0;
		GameTextForPlayer(playerid, "~g~Stigli ste na odrediste!", 1500, 1);
	}
    return 1;
}

stock GetChannelSlot(playerid, channel)
{
	if(channel == PlayerInfo[playerid][pRadio][1])return 1;
	if(channel == PlayerInfo[playerid][pRadio][2])return 2;
	if(channel == PlayerInfo[playerid][pRadio][3])return 3;

	return false;
}

CMD:checkfreq(playerid, params[])
{
	new channel;
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
	if(sscanf(params, "i", channel))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /checkfreq [frequency]");

	if(channel < 1 || channel > 100000)return SendClientMessage(playerid, COLOR_RED, "Pogrešna frekvencija.");

	va_SendClientMessage(playerid, COLOR_RED, "Igraci na frekvenciji %d:", channel);

	foreach(new i : Player)
	{
		for(new x = 0; x < 3; x++) if(PlayerInfo[i][pRadio][x] == channel)
		{
			va_SendClientMessage(playerid, COLOR_GREY, "- %s [ID: %i]", GetName(i, false), i);
		}
	}
	return 1;
}

CMD:playerfreq(playerid, params[])
{
    new giveplayerid;
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(A3+)!");
	if(sscanf(params, "u", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /checkfreq [playerid]");
		
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac %s se nalazi na frekvencijama %d, %d, %d.",
		GetName(giveplayerid, false),
		PlayerInfo[giveplayerid][pRadio][1],
		PlayerInfo[giveplayerid][pRadio][2],
		PlayerInfo[giveplayerid][pRadio][3]
	);
	return 1;
}

CMD:setslot(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128], slotid;

	if(!PlayerInfo[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
	if(sscanf(params, "d", slotid))return SendClientMessage(playerid, COLOR_RED, "USAGE: /setslot [slotid]");
	if(slotid < 1 || slotid > 3)return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");

	format(string, sizeof(string), "Lokalni kanal setovan na slot %d!", slotid);
	SendClientMessage(playerid, COLOR_RED, string);
	
	PlayerInfo[playerid][pMainSlot] = slotid;
	return true;
}

CMD:setchannel(playerid, params[])
{
    if (!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid)) return SendErrorMessage(playerid, "Niste ulogirani!");

    new channel, slotid, query[90];
    if(!PlayerInfo[playerid][pHasRadio]) return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
    if(sscanf(params, "dd", channel, slotid))return SendClientMessage(playerid, COLOR_RED, "USAGE: /setchannel [frekvencija][slot]");
    if(channel < 1 || channel > 100000)return SendClientMessage(playerid, COLOR_RED, "Samo kanali izmedju 1 - 100000 su podrzani.");
	if(slotid < 1 || slotid > 3)return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-3.");
	if(PlayerInfo[playerid][pRadio][1] == channel || PlayerInfo[playerid][pRadio][2] == channel || PlayerInfo[playerid][pRadio][3] == channel)  return SendClientMessage(playerid, COLOR_RED, "[ ! ] Jedan od vasih slotova vec je na tom kanalu.");
    if(!IsACop(playerid) && (channel == 911 || channel == 9030 || channel == 9040))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
	if(!IsASD(playerid) && (channel == 999 || channel == 9930 || channel == 9940))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
    if(!IsFDMember(playerid) && (channel == 471 || channel == 4030 || channel == 4040))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
	if(!IsAGov(playerid) && (channel == 651))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
	if(!IsANews(playerid) && (channel == 340))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");
	if(!IsAFM(playerid) && (channel == 770))
		return SendClientMessage(playerid, COLOR_RED, "Kanal nije za javnost");

	PlayerInfo[playerid][pRadio][slotid] = channel;
	PlayerInfo[playerid][pRadioSlot][slotid] = slotid;
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Sada ce te slusati kanal broj %d pod slotom %d.", channel, slotid);

	format(query, sizeof(query), "UPDATE accounts SET Radio%d = '%d', Slot%d = '%d' WHERE sqlid = '%d'",
		slotid,
		PlayerInfo[playerid][pRadio][slotid],
		slotid,
		PlayerInfo[playerid][pRadioSlot][slotid],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, query);

    return 1;
}


CMD:radio(playerid, params[])
{
	if (!PlayerInfo[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new string[128], radioChan = PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if (PlayerInfo[i][pRadio][s] == radioChan && PlayerInfo[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
			{
				if (s != PlayerInfo[i][pMainSlot])
				{
					if(strlen(params) > 75)
					{
						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %.75s...", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
						SendClientMessage(i, COLOR_RADIOEX, string);

						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: ...%s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params[75]);
						SendClientMessage(i, COLOR_RADIOEX, string);
					}
					else
					{
						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
						SendClientMessage(i, COLOR_RADIOEX, string);
					}
				}
				else
				{
					if(strlen(params) > 75)
					{
						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %.75s...", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
						SendClientMessage(i, COLOR_RADIO, string);

						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: ...%s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params[75]);
						SendClientMessage(i, COLOR_RADIO, string);
					}
					else
					{
						format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
						SendClientMessage(i, COLOR_RADIO, string);
					}
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

    REarsBroadCast(0xFFD1D1FF,string,1);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, false), params);
 			SendClientMessage(i, COLOR_FADE1, string);
		}
	}


	return true;
}

CMD:radiolow(playerid, params[])
{
	if (!PlayerInfo[playerid][pHasRadio])
		return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
	
	if(!PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]])
		return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "USAGE: /radio [text] {FF6346}, /rlow [text] {FF6346}, /r2 [text] {FF6346}ili /r3 ");

	new string[128], radioChan = PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]];

	foreach (new i : Player)
	{
		for (new s = 1 ; s < 3 ; s ++)
		{
			if (PlayerInfo[i][pRadio][s] == radioChan && PlayerInfo[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i))
			{
				if (s != PlayerInfo[i][pMainSlot])
				{
					format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else
				{
					format (string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[i][pRadio][s], GetChannelSlot(i, radioChan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIO, string);
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s says[Low]: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_FADE1, string);
		}
	}


	return true;
}

CMD:r2(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	if(!PlayerInfo[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerInfo[playerid][pRadio][2])return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))return SendClientMessage(playerid, COLOR_RED, "USAGE: /r2 [radio text]");

	new chan;
	chan = PlayerInfo[playerid][pRadio][2];

	foreach(new i : Player){
		for(new r = 0; r < 4; r++){
			if(PlayerInfo[i][pRadio][r] == PlayerInfo[playerid][pRadio][2] && PlayerInfo[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i)){
				if(r != PlayerInfo[i][pMainSlot]){
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[playerid][pRadio][2], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[playerid][pRadio][2], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIO, string);
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_WHITE, string);
		}
	}

	return true;
}

CMD:r3(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	if(!PlayerInfo[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");

	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");

	if(!PlayerInfo[playerid][pRadio][3])return SendClientMessage(playerid, COLOR_RED, "Niste u radio kanalu.");
	if(isnull(params))return SendClientMessage(playerid, COLOR_RED, "USAGE: /r3 [radio text]");

	new chan;
	chan = PlayerInfo[playerid][pRadio][3];

	foreach(new i : Player){
		for(new r = 0; r < 4; r++){
			if(PlayerInfo[i][pRadio][r] == PlayerInfo[playerid][pRadio][3] && PlayerInfo[i][pHasRadio] && Bit1_Get(gr_PlayerRadio, i)){
				if(r != PlayerInfo[i][pMainSlot]){
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[playerid][pRadio][3], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIOEX, string);
				}
				else{
					format(string, sizeof(string), "**[CH: %d, S: %d] %s kaze: %s", PlayerInfo[playerid][pRadio][3], GetChannelSlot(i, chan), GetName(playerid, true), params);
					SendClientMessage(i, COLOR_RADIO, string);
				}
			}
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			format(string, sizeof(string), "(Radio) %s kaze: %s", GetName(playerid, true), params);
 			SendClientMessage(i, COLOR_WHITE, string);
		}
	}

	return true;
}

CMD:togradio(playerid, params[])
{
	#pragma unused params

 	if(!PlayerInfo[playerid][pHasRadio])return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
	if( !Bit1_Get(gr_PlayerRadio, playerid))
	{
		Bit1_Set(gr_PlayerRadio, playerid, true);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste radio!");
	} else {
		Bit1_Set(gr_PlayerRadio, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "[ ! ] Iskljucili ste radio!");
	}
    return 1;
}

CMD:leaver(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128], slotid;

	if(!PlayerInfo[playerid][pHasRadio]) return SendClientMessage(playerid, COLOR_RED, "Nemate radio.");
	if(!Bit1_Get(gr_PlayerRadio, playerid))
		return SendClientMessage(playerid, COLOR_RED, "Iskljucen vam je radio! Koristite /togradio.");
	if(sscanf(params, "d", slotid)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /leaver [slotid]");
	if(slotid < 1 || slotid > 3) return SendClientMessage(playerid, COLOR_RED, "Slotovi moraju biti izmedju 1-5.");

	PlayerInfo[playerid][pRadio][slotid] = 0;
	PlayerInfo[playerid][pRadioSlot][slotid] = 0;

    new
		channelLeave[128];
	format(channelLeave, sizeof(channelLeave), "DELETE FROM `accounts` WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pRadio][slotid],
		PlayerInfo[playerid][pRadioSlot][slotid],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, channelLeave);
	
	format(string, sizeof(string), "Napustili ste radio na slotu %d.", slotid);
	SendClientMessage(playerid, COLOR_RED, string);

	return true;
}

CMD:radiohelp(playerid, params[])
{
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Niste ulogirani!");

	new string[128];

	new slot1 = PlayerInfo[playerid][pRadio][1];
	new slot2 = PlayerInfo[playerid][pRadio][2];
	new slot3 = PlayerInfo[playerid][pRadio][3];


	SendClientMessage(playerid, COLOR_RED, "|__________________Radio help_________________|");
	SendClientMessage(playerid, COLOR_RED, "HINT: Radio mozete kupiti u 24/7 marketu!");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] /setchannel - Setuje koji kanal zelite u kojem slotu.");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] /setslot - Podesava trenutni slot na kojem slusate.");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] /r - Pricanje preko kanala. {FFFF00}HINT: Takodjer mozete upotrjebiti /r1, /r2, /r3 za slotove.");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] /leaver [slotid] - Dio iz radio kanal iz tog slota.");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] /togradio - Paljenje i gasenje radia.");
	format(string, sizeof(string), "Vasi trenutni kanali:{33AA33}[Slot 1: %d][Slot 2: %d][Slot 3: %d]", slot1, slot2, slot3);
	SendClientMessage(playerid, COLOR_RED, string);

	return true;
}



