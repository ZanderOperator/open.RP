#include <YSI_Coding\y_hooks>

// Core Table Save/Load Functions
#include "modules/Player\SaveLoad/player_vip_status.pwn"
#include "modules/Player\SaveLoad/player_licenses.pwn"
#include "modules/Player\SaveLoad/player_jail.pwn"
#include "modules/Player\SaveLoad/player_job.pwn"
#include "modules/Player\SaveLoad/player_taxi.pwn"
#include "modules/Player\SaveLoad/player_payday.pwn"
#include "modules/Player\SaveLoad/player_savings.pwn"
#include "modules/Player\SaveLoad/player_credits.pwn"
#include "modules/Player\SaveLoad/player_faction.pwn"
#include "modules/Player\SaveLoad/player_radio.pwn"
#include "modules/Player\SaveLoad/player_admin_msg.pwn"

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	##   ##  #########  ##   ##         ## 
	 ## ##   ##     ##  ##    ##  ##    ## 
	  ###    ##     ##  ##     ##  ######  
*/
static stock 
			dialogtext[MAX_DIALOG_TEXT],
			Timer:LoginCheckTimer[MAX_PLAYERS];

/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
*/
// Timers
timer FinishPlayerSpawn[5000](playerid)
{
	if(Bit1_Get(gr_PlayerLoggedIn, playerid))
		SafeSpawnPlayer(playerid);
	
	return 1;
}

timer SafeHealPlayer[250](playerid)
{
	SetPlayerHealth(playerid, 100);
	return 1;
}

timer SetPlayerCrash[6000](playerid)
{
	if(PlayerInfo[playerid][pKilled] <= 0)
		TogglePlayerControllable(playerid, true);
	
	if(PlayerInfo[playerid][pCrashPos][0] != 0.0 && PlayerInfo[playerid][pCrashInt] != -1)
	{
		if( PlayerJail[playerid][pJailed] )
		{
			mysql_fquery(g_SQL, "DELETE FROM player_crashes WHERE id = '%d'", PlayerInfo[playerid][pCrashId]);

			PlayerInfo[playerid][pCrashId] 		= -1;
			PlayerInfo[playerid][pCrashArmour]	= 0.0;
			PlayerInfo[playerid][pCrashHealth]	= 0.0;
			PlayerInfo[playerid][pCrashVW]		= -1;
			PlayerInfo[playerid][pCrashInt] 	= -1;
			PlayerInfo[playerid][pCrashPos][0]	= 0.0;
			PlayerInfo[playerid][pCrashPos][1]	= 0.0;
			PlayerInfo[playerid][pCrashPos][2]	= 0.0;

			SafeSpawned[ playerid ] = true;
			return 1;
		}
		//Sets
		SetPlayerPosEx(playerid,  PlayerInfo[playerid][pCrashPos][0], PlayerInfo[playerid][pCrashPos][1], PlayerInfo[playerid][pCrashPos][2], PlayerInfo[playerid][pCrashVW], PlayerInfo[playerid][pCrashInt], true);
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		SetPlayerArmour(playerid, 		PlayerInfo[playerid][pCrashArmour]);

		if( 0.0 <= PlayerInfo[playerid][pCrashHealth] <= 6.0 )
			SetPlayerHealth(playerid, 100);
		else
			SetPlayerHealth(playerid, PlayerInfo[playerid][pCrashHealth]);

		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vraceni na prijasnju poziciju.");

		mysql_fquery(g_SQL, "DELETE FROM player_crashes WHERE id = '%d'", PlayerInfo[playerid][pCrashId]);
	
		//Resets
		PlayerInfo[playerid][pCrashId] 		= -1;
		PlayerInfo[playerid][pCrashArmour]	= 0.0;
		PlayerInfo[playerid][pCrashHealth]	= 0.0;
		PlayerInfo[playerid][pCrashVW]		= -1;
		PlayerInfo[playerid][pCrashInt] 	= -1;
		PlayerInfo[playerid][pCrashPos][0]	= 0.0;
		PlayerInfo[playerid][pCrashPos][1]	= 0.0;
		PlayerInfo[playerid][pCrashPos][2]	= 0.0;
		crash_checker[playerid] 	= true;
	}
	if(PlayerInfo[playerid][pMustRead] == true)
	{
		GetPlayerPreviousInfo(playerid);
		LearnPlayer(playerid, 1);
	}
	if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && !isnull(PlayerAdminMessage[playerid][pAdminMsg]) && !PlayerAdminMessage[playerid][pAdmMsgConfirm])
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[City of Angels]: "COL_WHITE"Server je updatean na verziju "COL_LIGHTBLUE"%s"COL_WHITE", za vise informacija - /update.", SCRIPT_VERSION);
		ShowAdminMessage(playerid);
		goto spawn_end;
	}
	else if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && (PlayerAdminMessage[playerid][pAdmMsgConfirm] || isnull(PlayerAdminMessage[playerid][pAdminMsg])))
	{
		if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0)
			PlayerReward[playerid] = true;
		ShowPlayerUpdateList(playerid);
		goto spawn_end;
	}
	else if(!isnull(PlayerAdminMessage[playerid][pAdminMsg]) && !PlayerAdminMessage[playerid][pAdmMsgConfirm] && strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) == 0)
	{
		ShowAdminMessage(playerid);
		goto spawn_end;
	}

	spawn_end:	
	SafeSpawned[ playerid ] = true;

	AC_SetPlayerWeapons(playerid);

	// Player Checks
	CheckPlayerVehicle(playerid);
	CheckPlayerInteriors(playerid);
	CheckPlayerInactivity(playerid);
	CheckPlayerMasks(playerid);
	return 1;
}

//Forwards
forward CheckPlayerInBase(playerid);
forward LoadPlayerStats(playerid);
forward LoadPlayerData(playerid);
forward SavePlayerData(playerid);
forward RegisterPlayer(playerid);
forward OnAccountFinish(playerid);


//Publics
CheckPlayerInactivity(playerid)
{
	inline OnPlayerInactivityCheck()
	{
		if(!cache_num_rows())
			return 1;
		
		mysql_fquery(g_SQL, "DELETE FROM inactive_accounts WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]);
		SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: Neaktivnost koju ste imali prijavljenu u bazi podataka je deaktivirana.");		
		return 1;
	}
	MySQL_TQueryInline(g_SQL,  
		using inline OnPlayerInactivityCheck, 
		va_fquery(g_SQL, "SELECT sqlid FROM inactive_accounts WHERE sqlid = '%d'", 
			PlayerInfo[playerid][pSQLID]), 
		"i", 
		playerid
	);
	return 1;
}

Public: OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
	if(match)
	{
		mysql_pquery(g_SQL, 
			va_fquery(g_SQL, "SELECT * FROM accounts WHERE name = '%e'", GetName(playerid, false)),
			"LoadPlayerData", 
			"i", 
			playerid
		);
	}
	else
	{
		Bit8_Set(gr_LoginInputs, playerid, Bit8_Get(gr_LoginInputs, playerid) + 1);
		if( !( MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid) ) )
		{
			//Kick
			SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobili ste IP ban radi pogresnih pokusaja ulaska u racun!");
			BanMessage(playerid);
			return 1;
		}
		if(Bit8_Get(gr_LoginInputs, playerid) < 3) 
		{
			format(dialogtext, sizeof(dialogtext), ""COL_RED"Krivo ste unijeli podatke za login!\n\
													"COL_WHITE"Provjerite velika i mala slova, te unesite valjanu sifru.\n\
													Imate jos "COL_LIGHTBLUE"%d"COL_WHITE"pokusaja za unos valjane sifre!\n\n\n\
													"COL_RED"Ukoliko ne unesete dobru sifru onda cete dobiti kick!", MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""COL_WHITE"PRIJAVA", dialogtext, "Sign In", "Abort");
		}
	}
	return 1;
}

public CheckPlayerInBase(playerid)
{
	if(cache_num_rows()) { //Registriran
		// Player Camera
		TogglePlayerControllable(playerid, false);
		SetCameraBehindPlayer(playerid);
		RandomPlayerCameraView(playerid);
		// Show Dialog
		format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Srdacan pozdrav "COL_LIGHTBLUE"%s!\n\n\
			"COL_WHITE"Lijepo vas je vidjeti na nasem serveru opet.\n\
			Molimo da unesete lozinku vaseg korisnickog\n\
			racuna i da se prijavite. Imate "COL_LIGHTBLUE"%d"COL_WHITE"sekundi da se\n\
			prijavite, ili cete biti odspojeni sa Servera.\n\n\
			Hvala i uzivajte i dalje u igranju na City of Angels!",GetName(playerid),MAX_LOGIN_TIME
		);					
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""COL_WHITE"PRIJAVA", dialogtext, "Sign In", "Abort");
		
		Bit8_Set(gr_LoginInputs, playerid, 0);
		Bit1_Set(gr_LoginChecksOn, playerid, true);
		LoginCheckTimer[playerid] = defer LoginCheck(playerid);
	} 
	else 
	{ //Nije Registriran
		if(regenabled)
		{
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "U toku je ucitavanje registracije, pricekajte par trenutaka.");
			
			new
				playaIP[16];
				
			GetPlayerIp(playerid, playaIP, 16);
			
			//VPN_RegisterIPCheck(playerid, playaIP); // provjerava IP zbog VPN-a te onda izbaci registraciju ako nije VPN
			
			#if defined COA_UCP
				SendClientMessage(playerid, COLOR_RED, "Niste registrirali svoj racun na ucp.cityofangels-roleplay.com!");
				KickMessage(playerid);
			#else
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Dobrodosao "COL_LIGHTBLUE"%s!\n\n\
													"COL_WHITE"Vas racun nije registriran, ukoliko\n\
													se zelite registrirati kliknite na gumb \"Register\"\n\
													U protivnome cete biti kickani sa servera!",GetName(playerid));
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_MSGBOX, ""COL_WHITE"REGISTRACIJA (1/6)", dialogtext, "Register", "Abort");
			#endif
		}
		else
		{
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Administrator je trenutno onemogucio registraciju na serveru, pokusajte kasnije.");
			SendClientMessage(playerid, COLOR_RED, "Administrator je trenutno onemogucio registraciju na serveru, pokusajte kasnije.");
			KickMessage(playerid);
		}
	}
	return 1;
}

public LoadPlayerStats(playerid)
{
	// Crashes
	LoadPlayerCrashes(playerid);
	return 1;
}

public LoadPlayerData(playerid)
{
	new rows;
    cache_get_row_count(rows);
    if(rows)
	{
		stop LoginCheckTimer[playerid];
		Bit1_Set(gr_LoginChecksOn, playerid, false);

	    new string[20];
		cache_get_value_name_int(0, "sqlid"			, PlayerInfo[playerid][pSQLID]);
		cache_get_value_name_int(0, "levels"		, PlayerInfo[playerid][pLevel]);
		cache_get_value_name_int(0, "connecttime"	, PlayerInfo[playerid][pConnectTime]);
		
		cache_get_value_name(0, 	"teampin"		, PlayerInfo[playerid][pTeamPIN]		, BCRYPT_HASH_LENGTH);
		cache_get_value_name_int(0, "secquestion"	, PlayerInfo[playerid][pSecQuestion]);
		cache_get_value_name(0, 	"secawnser"		, PlayerInfo[playerid][pSecQuestAnswer]	, 31);
		cache_get_value_name(0, 	"email"			, PlayerInfo[playerid][pEmail]			, MAX_PLAYER_MAIL);
		cache_get_value_name(0, 	"SAMPid"		, PlayerInfo[playerid][pSAMPid]			, 128);
		cache_get_value_name(0, 	"lastlogin"		, PlayerInfo[playerid][pLastLogin]		, 24);
		cache_get_value_name_int(0, "lastloginstamp", PlayerInfo[playerid][pLastLoginTimestamp]);
		cache_get_value_name(0, 	"lastip"		, PlayerInfo[playerid][pLastIP]			, 24);
		
		cache_get_value_name(0, 	"password"		, PlayerInfo[playerid][pPassword]		, BCRYPT_HASH_LENGTH);
		cache_get_value_name(0, 	"lastupdatever"	, PlayerInfo[playerid][pLastUpdateVer]	, 24);
		cache_get_value_name_int(0, "spawnchange"	, PlayerInfo[playerid][pSpawnChange]);
		
		cache_get_value_name_int(0, "registered"	, PlayerInfo[playerid][pRegistered]);
		cache_get_value_name(0, "forumname"			, PlayerInfo[playerid][pForumName], 24);

		cache_get_value_name_int(0, "adminLvl"		, PlayerInfo[playerid][pTempRank][0]);
		cache_get_value_name_int(0, "helper"		, PlayerInfo[playerid][pTempRank][1]);
		cache_get_value_name_int(0, "playaWarns"	, PlayerInfo[playerid][pWarns]);

		cache_get_value_name_int(0, "muted"			, PlayerInfo[playerid][pMuted]);
		cache_get_value_name_int(0, "respects"		, PlayerInfo[playerid][pRespects]);

		cache_get_value_name_int(0,  "sex"			, PlayerInfo[playerid][pSex]);
		cache_get_value_name_int(0,  "age"			, PlayerInfo[playerid][pAge]);
		cache_get_value_name_int(0,  "changenames"	, PlayerInfo[playerid][pChangenames]);
		cache_get_value_name_int(0,  "changetimes"	, PlayerInfo[playerid][pChangeTimes]);
		cache_get_value_name_int(0,  "handMoney"	, PlayerInfo[playerid][pMoney]);
		cache_get_value_name_int(0,  "bankMoney"	, PlayerInfo[playerid][pBank]);

		cache_get_value_name_int(0,  "fishworks"	, PlayerInfo[playerid][pFishWorks]);
		cache_get_value_name_int(0,  "parts"		, PlayerInfo[playerid][pParts]);
        cache_get_value_name_float(0,"health"		, PlayerInfo[playerid][pHealth]);

        cache_get_value_name_int(0,  "playaSkin"	, PlayerInfo[playerid][pChar]);
		format(PlayerInfo[playerid][pAccent]		, sizeof(string), string);
		
		cache_get_value_name_int(0,  "rentkey"		, PlayerInfo[playerid][pRentKey]);
		cache_get_value_name_int(0,  "maskid"		, PlayerInfo[playerid][pMaskID]);
		cache_get_value_name_int(0,  "spawnedcar"	, PlayerInfo[playerid][pSpawnedCar]);
		cache_get_value_name_float(0, "hunger"		, PlayerInfo[playerid][pHunger]);

		cache_get_value_name_float(0,"armour"		, PlayerInfo[playerid][pArmour]);
		cache_get_value_name_int(0, "muscle"		, PlayerInfo[playerid][pMuscle]);
		cache_get_value_name_int(0,	"fightstyle"	, PlayerInfo[playerid][pFightStyle]);

		cache_get_value_name_int(0, "clock"			, PlayerInfo[playerid][pClock]);
		cache_get_value_name_int(0, "rope"			, PlayerInfo[playerid][hRope]);
		cache_get_value_name_int(0, "cigaretes"		, PlayerInfo[playerid][pCiggaretes]);	
		cache_get_value_name_int(0, "lighter"		, PlayerInfo[playerid][pLighter]);		

		cache_get_value_name_int(0, "lijektimer"	, PlayerInfo[playerid][pLijekTimer]);
		cache_get_value_name_int(0,	"gymtimes"		, PlayerInfo[playerid][pGymTimes]);
		cache_get_value_name_int(0,	"gymcounter"	, PlayerInfo[playerid][pGymCounter]);
		cache_get_value_name_int(0,	"boombox"		, PlayerInfo[playerid][pBoomBox]);
		cache_get_value_name_int(0,	"boomboxtype"	, PlayerInfo[playerid][pBoomBoxType]);
		
		cache_get_value_name(0,	"look"				, PlayerInfo[playerid][pLook], 120);
		cache_get_value_name_int(0,	"playaUnbanTime", PlayerInfo[playerid][pUnbanTime]);
		cache_get_value_name(0, "playaBanReason"	, PlayerInfo[playerid][pBanReason], 32);
		
		cache_get_value_name_int(0,	"casinocool"	, PlayerInfo[playerid][pCasinoCool]);
		cache_get_value_name_int(0,	"news"			, PlayerInfo[playerid][pNews]);
		cache_get_value_name_int(0,	"voted"			, PlayerInfo[playerid][pVoted]);
		
		cache_get_value_name_int(0,	"ammutime"		, PlayerInfo[playerid][pAmmuTime]);
		cache_get_value_name_int(0,	"warekey"		, PlayerInfo[playerid][pWarehouseKey]);
		
		cache_get_value_name_int(0,	"mustread"		, PlayerInfo[playerid][pMustRead]);
		cache_get_value_name_int(0, "JackerCoolDown", PlayerInfo[playerid][JackerCoolDown]);
		cache_get_value_name_int(0, "pBusinessJob", PlayerInfo[playerid][pBusinessJob]);
		cache_get_value_name_int(0, "pBusinessWorkTime", PlayerInfo[playerid][pBusinessWorkTime]);
		cache_get_value_name_int(0, "FurnPremium"	, PlayerInfo[playerid][FurnPremium]);
		
		cache_get_value_name_int(0, "drugused", PlayerInfo[playerid][pDrugUsed]);
		cache_get_value_name_int(0, "drugseconds", PlayerInfo[playerid][pDrugSeconds]);
		cache_get_value_name_int(0, "lastdrug", PlayerInfo[playerid][pDrugOrder]);
		
		//Fisher
		cache_get_value_name_int(0, "FishingSkill", PlayerInfo[playerid][pFishingSkill]);
		
		if( PlayerInfo[ playerid ][ pUnbanTime ] == -1 )
		{
			SendClientMessage( playerid, COLOR_RED, "[CoA-RP Server]: Dobili ste dozivotnu zabranu igranja na ovome serveru! Ukoliko mislite da niste zasluzili zalite se na forumu! www.cityofangels-roleplay.com");
			BanMessage(playerid);
			return 1;
		}
		else if( PlayerInfo[ playerid ][ pUnbanTime ] == -3)
		{
		    SendClientMessage( playerid, COLOR_RED, "[CoA-RP Server]: Vas korisnicki racun je trenutno zakljucan od strane sigurnosnog sistema!");
		    SendClientMessage( playerid, COLOR_RED, "[CoA-RP Server]: Postavite zahtjev za unban na forumu kako bi otkljucali vas account! (forum.cityofangels-roleplay.com)");
		    KickMessage(playerid);
		    return 1;
		}

		if( PlayerInfo[ playerid ][ pUnbanTime ] == -2 ) {
			SendClientMessage( playerid, COLOR_RED, "[CoA-RP Server]: Vas racun je blokiran od strane sustava! Morate uvesti racun na User Control Panel (ucp.cityofangels-roleplay.com) da biste mogli ponovno igrati!");
			KickMessage(playerid);
			return 1;
		}

		if( PlayerInfo[ playerid ][ pUnbanTime ] < gettimestamp() ) 
		{
			mysql_fquery(g_SQL, "UPDATE accounts SET playaUnbanTime = '0' WHERE sqlid = '%d'", 
				PlayerInfo[playerid][pSQLID]
			);
			
			PlayerInfo[ playerid ][ pUnbanTime ] 		= 0;
			PlayerInfo[ playerid ][ pBanReason ][ 0 ] 	= EOS;
		} 
		else 
		{
			new date[12], time[12];
			TimeFormat(Timestamp:PlayerInfo[ playerid ][ pUnbanTime ], HUMAN_DATE, date);
			TimeFormat(Timestamp:PlayerInfo[ playerid ][ pUnbanTime ], ISO6801_TIME, time);
	
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "[CoA-RP Server]: Vasa zabrana igranja zavrsava "COL_SERVER"%s %s.", date, time);
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "Razlog bana: %s", PlayerInfo[ playerid ][ pBanReason ]);

			KickMessage(playerid);
			return 1;
		}

		LoadPlayerStats(playerid);
		
		// Biznis & house & complex keys
		PlayerInfo[playerid][pBizzKey] 	= INVALID_BIZNIS_ID;
		PlayerInfo[playerid][pBusiness] = INVALID_BIZNIS_ID;
		PlayerInfo[playerid][BizCoOwner] = false;
		PlayerInfo[playerid][pHouseKey] = INVALID_HOUSE_ID;
		PlayerInfo[playerid][pComplexKey] = INVALID_COMPLEX_ID;
		PlayerInfo[playerid][pComplexRoomKey] = INVALID_COMPLEX_ID;
		
		foreach(new biznis : Bizzes) 
		{
			if(BizzInfo[biznis][bOwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pBizzKey] = biznis;
				PlayerInfo[playerid][pBusiness] = biznis;
				ReloadBizzFurniture(biznis);
				break;
			}
		}
		
		foreach(new biznis : Bizzes)
		{
			if(BizzInfo[biznis][bco_OwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pBusiness] = biznis;
				PlayerInfo[playerid][BizCoOwner] = true;
				break;
			}
		}
		
		foreach(new complex : Complex)
		{
			if(ComplexInfo[complex][cOwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pComplexKey] = complex;
				break;
			}
		}
		
		foreach(new house : Houses)
		{
			if(HouseInfo[house][hOwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pHouseKey] = house;
				break;
			}
		}
		
		foreach(new complexr : ComplexRooms)
		{
			if(ComplexRoomInfo[complexr][cOwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pComplexRoomKey] = complexr;
				break;
			}
		}
		
		foreach(new igarage : IllegalGarages)
		{
			if(IlegalGarage[ igarage ][ igOwner ] == PlayerInfo[playerid][pSQLID])
			{
				PlayerInfo[playerid][pIllegalGarageKey] = igarage;
				break;
			}
		}
		foreach(new garage : Garages)
		{
			if(GarageInfo[garage][gOwnerID] == PlayerInfo[playerid][pSQLID]) {
				PlayerInfo[playerid][pGarageKey] = garage;
				break;
			}
		}
		
		Bit1_Set( gr_PlayerLoggingIn, playerid, true );
  		SetPlayerSpawnInfo(playerid);
        Bit1_Set( gr_FristSpawn, playerid, true );

        if(!isnull(PlayerInfo[playerid][pSAMPid]) && PlayerInfo[playerid][pSecQuestion] != 1 && !isnull(PlayerInfo[playerid][pSecQuestAnswer]))
        {
            new
                n_gpci[128];
            gpci(playerid, n_gpci, 128);
            if(strcmp(n_gpci, PlayerInfo[playerid][pSAMPid])) {
                OnSecurityBreach[playerid] = true;
                SendClientMessage(playerid, COLOR_RED, "[SERVER]  Izgleda da se logirate s novog racunala koji je nepoznat nasem serveru! Upisite sigurnosni odgovor kako bi nastavili.");
                va_ShowPlayerDialog(playerid, DIALOG_SEC_SAMPID, DIALOG_STYLE_PASSWORD, ""#COL_RED"SECURITY BREACH", ""#COL_WHITE"Molimo odgovorite na sigurnosno pitanje kako bi nastavili:\n%s", "Answer", "Abort", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
                return 1;
            }
        }

        Bit1_Set(gr_PlayerLoggedIn, playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "U toku je ucitavanje podataka. Pricekajte 5 sekundi.");
		defer FinishPlayerSpawn(playerid);
    }
    return 1;
}

public RegisterPlayer(playerid)
{
	format(PlayerInfo[playerid][pLastLogin], 24, ReturnDate());
    mysql_pquery(g_SQL,
		va_fquery(g_SQL, 
			"INSERT INTO accounts (registered,register_date,name,password,teampin,email,\n\
				secawnser,expdate,levels,age,sex,handMoney,bankMoney,playaSkin,casinocool) \n\
				VALUES ('0','%e','%e','%e','','%e','','','%d','%d','%d','%d','%d','%d','%d')",
			ReturnDate(),
			GetName(playerid, false),
			PlayerInfo[playerid][pPassword],
			PlayerInfo[playerid][pEmail],
			1,
			PlayerInfo[playerid][pAge],
			PlayerInfo[playerid][pSex],
			NEW_PLAYER_MONEY,
			NEW_PLAYER_BANK,
			29,
			5), 
		"OnAccountFinish", 
		"i", 
		playerid
	);
	return 1;
}

public OnAccountFinish(playerid)
{	
	//Enum set
	PlayerInfo[playerid][pSQLID] 			= cache_insert_id();
	PlayerInfo[playerid][pRegistered] 		= 0;
	PlayerInfo[playerid][pLevel] 			= 1;
	PlayerInfo[playerid][pChar] 			= 29;
	PaydayInfo[playerid][pPayDayMoney] 		= 0;
	PaydayInfo[playerid][pProfit]			= 0;
	PlayerJob[playerid][pFreeWorks] 		= 15;
	PlayerInfo[playerid][pMuted] 			= true;
	PlayerInfo[playerid][pAdmin] 			= 0;
	PlayerInfo[playerid][pHelper] 			= 0; 
	PlayerInfo[playerid][pCasinoCool]		= 5;
	PlayerInfo[playerid][pCasinoCool]		= 5;
	PlayerInfo[playerid][pHouseKey]			= 9999;
	PlayerInfo[playerid][pBizzKey]			= 999;
	PlayerInfo[playerid][pBusiness]			= 999;
	PlayerInfo[playerid][pComplexRoomKey]	= 999;
	PlayerInfo[playerid][pComplexKey]		= 999;
	PlayerInfo[playerid][pSpawnedCar]		= -1;
	
	UpdateRegisteredPassword(playerid);
	
	//Player Functions
	TogglePlayerSpectating(playerid, 0);
	SetCameraBehindPlayer(playerid);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	
	PlayerNewUser_Set(playerid,true);
	Bit1_Set(gr_PlayerLoggedIn, playerid, true);
	DestroyLoginTextdraws(playerid);
	
	CreateLogoTD(playerid);
	
	//Tutorial
	SpawnPlayer(playerid);
    return 1;
}

//Stocks
stock IsEMailInDB(const email[])
{
	new 
		Cache:result,
		counts;
	
	result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE email = '%e'", email));
	counts = cache_num_rows();
	cache_delete(result);
	return counts;
}

SafeSpawnPlayer(playerid)
{
	if(PlayerInfo[playerid][pSQLID] == 0)
	{
		SendClientMessage(playerid, COLOR_RED, "[INFO]: Kickani ste sa servera zbog toga sto server nije pronasao vase podatke! Slikajte ovo i posaljite developerima!");
		printf("<!> WARNING: Igrac %s[%d](%s) je automatski kickan sa servera, razlog: Nepostojeci SQLID!", GetName(playerid), playerid, ReturnPlayerIP(playerid));
		KickMessage(playerid);
		
		return 1;
	}
	new currentday, day;
	TimeFormat(Timestamp:gettimestamp(), DAY_OF_MONTH, "%d", currentday);
	TimeFormat(Timestamp:ExpInfo[playerid][eLastPayDayStamp], DAY_OF_MONTH, "%d", day);
	if(currentday != day)
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 0;
	}

	// Micanje ulaznih textdrawova
	DestroyLoginTextdraws(playerid);
	// Forum URL Textdraw
	CreateLogoTD(playerid);
	// AFK Timer
	SetPlayerAFKLimit(playerid);

	#if defined MODULE_LOGS
	Log_Write("/logfiles/connects.txt", "(%s) %s(%s) sucessfully connected on the server.",
		ReturnDate(),
		GetName(playerid, false),
		GetPlayerIP(playerid)
	);
	#endif
	
	PlayerInfo[playerid][pOnline] = true;
	OnSecurityBreach[playerid] = false;
	
	SafeSpawning[playerid] = true;

	mysql_fquery(g_SQL,
		"INSERT INTO player_connects(player_id, time, aip) VALUES ('%d','%d','%e')",
		PlayerInfo[playerid][pSQLID],
		gettimestamp(),
		GetPlayerIP(playerid)
	);
	
	mysql_fquery(g_SQL,
		 "UPDATE accounts SET online = '1' WHERE sqlid = '%d'",
		 PlayerInfo[ playerid ][ pSQLID ]
	);
	
	if( ( 10 <= PlayerJob[playerid][pJob] <= 12 ) && ( !PlayerFaction[playerid][pMember] && !PlayerFaction[playerid][pLeader])  )
		PlayerJob[playerid][pJob] = 0;

	if( !PlayerInfo[playerid][pRegistered] )
		PlayerNewUser_Set(playerid, true);
		
	// Donacije
	if( PlayerVIP[playerid][pDonateTime] < gettimestamp() && PlayerVIP[playerid][pDonateRank] > 0 ) {
		SendClientMessage( playerid, COLOR_ORANGE, "[CoA Server]: Vrijeme vaseg Premium VIP paketa je isteklo! Ukoliko zelite produziti VIP onda donirajte opet!");
		PlayerVIP[playerid][pDonateTime] = 0;
		PlayerVIP[playerid][pDonateRank] = 0;
		if(PlayerInfo[playerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(playerid);
		if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(playerid, -1, PlayerInfo[ playerid ][ pHouseKey ]);

		SavePlayerVIP(playerid);
	}
	if( isnull(PlayerInfo[playerid][pSecQuestAnswer]) && isnull(PlayerInfo[playerid][pEmail]) )
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Vas racun je nezasticen! Koristite komandu /account i postavite EMail i sigurnosno pitanje!");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukoliko ne upisete ove informacije a izgubite vas account vam nece biti vracen.");
	}
	else if(PlayerInfo[playerid][pSecQuestion] == 1 && isnull(PlayerInfo[playerid][pSecQuestAnswer]))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Postavite ili promjenite vase sadasnje pitanje/odgovor kako ne bi ostali bez pristupa vasem racunu!");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Koristite komandu /account kako bi dodali sigurnosno pitanje.");
		gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
	}
	else if(isnull(PlayerInfo[playerid][pSAMPid]))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Sljedeci put kad se logirate sa drugog racunala server ce vas pitati odgovor na vase sigurnosno pitanje!");
		gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
	}
	
	defer SetPlayerCrash(playerid);
	defer SafeHealPlayer(playerid);
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, playerid);
	Bit1_Set( gr_FristSpawn, playerid, true );
	Bit1_Set(gr_PlayerLoggedIn, playerid, true);
	Bit1_Set(gr_PlayerLoggingIn, playerid, false);
	TogglePlayerSpectating(playerid, 0);
	SetCameraBehindPlayer(playerid);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	TogglePlayerControllable(playerid, false);
	StopAudioStreamForPlayer(playerid);
	va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[City of Angels]: "COL_WHITE"Dobrodosao natrag, "COL_LIGHTBLUE"%s"COL_WHITE"!", GetName(playerid));
	//CallLocalFunction("OnPlayerSpawn", "i", playerid);
	return 1;
}

stock ShowAdminMessage(playerid)
{
	new 
		string[2048];
		
	format(string, sizeof(string), "Obavijest od %s\n%s", PlayerAdminMessage[playerid][pAdminMsgBy], PlayerAdminMessage[playerid][pAdminMsg]);
	ShowPlayerDialog(playerid, DIALOG_ADMIN_MSG, DIALOG_STYLE_MSGBOX, "Admin Message", string, "Ok", "");
	return 1;
}

public SavePlayerData(playerid)
{
    if( !SafeSpawned[playerid] )	
		return 1;
	
	mysql_pquery(g_SQL, "START TRANSACTION");

	mysql_fquery_ex(g_SQL, 
		"UPDATE accounts SET registered = '%d', adminLvl = '%d', helper = '%d', playaWarns = '%d', lastlogin = '%e',\n\
			lastloginstamp = '%d', lastip = '%e', muted = '%d', sex = '%d', age = '%d', changenames = '%d',\n\
			changetimes = '%d', handMoney = '%d', bankMoney = '%d', connecttime = '%d',\n\
			fishworks = '%d', fishsqlid = '%d', levels = '%d', respects = '%d',\n\
			parts = '%d', health = '%f', FishingSkill = '%d',\n\
			rentkey = '%d',\n\
			maskid = '%d', hunger = '%f', spawnedcar = '%d', armour = '%f', muscle = '%d',\n\
			fightstyle = '%d', clock = '%d', rope = '%d', cigaretes = '%d', lighter = '%d',\n\
			SAMPid = '%e', forumname = '%e', gymtimes = '%d', gymcounter = '%d',\n\
			boombox = '%d', boomboxtype = '%d', casinocool = '%d', news = '%d', voted = '%d',\n\
			drugused = '%d', drugseconds = '%d', lastdrug = '%d',\n\
			ammutime = '%d', warekey = '%d', mustread = '%d', lastupdatever = '%e', JackerCoolDown = '%d',\n\
			FurnPremium = '%d',\n\
			WHERE sqlid = '%d'",
		PlayerInfo[playerid][pRegistered],
		PlayerInfo[playerid][pTempRank][0],
		PlayerInfo[playerid][pTempRank][1],
		PlayerInfo[playerid][pWarns],
		PlayerInfo[playerid][pLastLogin],
		PlayerInfo[playerid][pLastLoginTimestamp],
		PlayerInfo[playerid][cIP],
		PlayerInfo[playerid][pMuted],
		PlayerInfo[playerid][pSex],
		PlayerInfo[playerid][pAge],
		PlayerInfo[playerid][pChangenames],
		PlayerInfo[playerid][pChangeTimes],
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pConnectTime],
		PlayerInfo[playerid][pFishWorks],
		PlayerInfo[playerid][pFishSQLID],
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pRespects],
		PlayerInfo[playerid][pParts],
		PlayerInfo[playerid][pHealth],
		PlayerInfo[playerid][pFishingSkill],
		PlayerInfo[playerid][pRentKey],
		PlayerInfo[playerid][pMaskID],
		PlayerInfo[playerid][pHunger],
		PlayerInfo[playerid][pSpawnedCar],
		PlayerInfo[playerid][pArmour],
		PlayerInfo[playerid][pMuscle],
		PlayerInfo[playerid][pFightStyle],
		PlayerInfo[playerid][pClock],
		PlayerInfo[playerid][hRope],
		PlayerInfo[playerid][pCiggaretes],
		PlayerInfo[playerid][pLighter],
		LicenseInfo[playerid][pPassport],
		PlayerInfo[playerid][pSAMPid],
		PlayerInfo[playerid][pForumName],
		PlayerInfo[playerid][pGymTimes],
		PlayerInfo[playerid][pGymCounter],
		PlayerInfo[playerid][pBoomBox],
		PlayerInfo[playerid][pBoomBoxType],
		PlayerInfo[playerid][pCasinoCool],
		PlayerInfo[playerid][pNews],
		PlayerInfo[playerid][pVoted],
		PlayerInfo[playerid][pDrugUsed],
		PlayerInfo[playerid][pDrugSeconds],
		PlayerInfo[playerid][pDrugOrder],
		PlayerInfo[playerid][pAmmuTime],
		PlayerInfo[playerid][pWarehouseKey],
		PlayerInfo[playerid][pMustRead],
		PlayerInfo[playerid][pLastUpdateVer],
		PlayerInfo[playerid][JackerCoolDown],
		PlayerInfo[playerid][FurnPremium],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_pquery(g_SQL, "COMMIT");
	return 1;
}

stock SetPlayerSpawnInfo(playerid)
{
	if(PlayerJail[playerid][pJailed] == 2)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], -10.9639, 2329.3030, 24.4, 0, 0, 0, 0, 0, 0, 0);
		Streamer_UpdateEx(playerid,  -10.9639, 2329.3030, 24.4);
	}
	else if(PlayerJail[playerid][pJailed] == 3)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar],  1199.1404,1305.8285,-54.7172, 0, 0, 0, 0, 0, 0, 0);
		SetPlayerInterior(playerid, 17);
		Streamer_UpdateEx(playerid,  1199.1404,1305.8285,-54.7172);
	}
	else if(PlayerInfo[playerid][pKilled] == 1) 
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar],PlayerInfo[ playerid ][ pDeath ][ 0 ], PlayerInfo[ playerid ][ pDeath ][ 1 ], PlayerInfo[ playerid ][ pDeath ][ 2 ], 0, 0, 0, 0, 0, 0, 0);
		Streamer_UpdateEx(playerid, PlayerInfo[ playerid ][ pDeath ][ 0 ], PlayerInfo[ playerid ][ pDeath ][ 1 ], PlayerInfo[ playerid ][ pDeath ][ 2 ]);
	}
	else
	{
		switch( PlayerInfo[ playerid ][ pSpawnChange ] ) 
		{
			case 0: 
			{
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
			}
			case 1:
			{
				if( ( PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID  ) ||  ( PlayerInfo[playerid][pRentKey] != INVALID_HOUSE_ID ) )
				{
					new
						house;
					if(  PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID  )
					{
						house = PlayerInfo[playerid][pHouseKey];
						if(!HouseInfo[house][hFurLoaded])
							ReloadHouseFurniture(house);
						ReloadHouseExterior(house);
					}
					else if( PlayerInfo[playerid][pRentKey] != INVALID_HOUSE_ID )
					{
						house = PlayerInfo[playerid][pRentKey];
						if(!HouseInfo[house][hFurLoaded])
							ReloadHouseFurniture(house);
						ReloadHouseExterior(house);
					}
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY], HouseInfo[ house ][ hEnterZ ], 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid,HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY], HouseInfo[ house ][ hEnterZ ], HouseInfo[ house ][ hVirtualWorld ], HouseInfo[ house ][ hInt ]);
				}
				else
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
				}
			}
			case 2:
			{
				switch(PlayerFaction[playerid][pMember])
				{
					case 1:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 1543.1218,-1675.8065,13.5558, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1543.1218,-1675.8065,13.5558);
					}
					case 2:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 1179.1440, -1324.0720, 13.9063, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1179.1440, -1324.0720, 13.9063); 
					}
					case 3:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 635.5733,-572.5349,16.3359, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 635.5733,-572.5349,16.3359);
					}
					case 4:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 1481.0284,-1766.5795,18.7958, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1481.0284,-1766.5795,18.7958);
					}
					case 5:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 1415.0668,-1177.3187,25.9922, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1466.6505,-1172.4191,23.8956);
					}
					default:
					{
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
					}
				}
			} 
			case 3:
			{
				if( PlayerInfo[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID )
				{
					new
						complex = PlayerInfo[playerid][pComplexRoomKey];
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], ComplexRoomInfo[complex][cExitX], ComplexRoomInfo[complex][cExitY], ComplexRoomInfo[complex][cExitZ], 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid, ComplexRoomInfo[complex][cExitX], ComplexRoomInfo[complex][cExitY], ComplexRoomInfo[complex][cExitZ], ComplexRoomInfo[complex][cViwo], ComplexRoomInfo[complex][cInt]);
				}
				else
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
				}
			}
			
			case 4:
			{
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 738.8747,-1415.2773,13.5168, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, 738.8747,-1415.2773,13.5168);
			}
			case 5:
			{
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], 2139.9543,-2167.1189,13.5469, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, 2139.9543,-2167.1189,13.5469);
			}
			default:
			{
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
			}
		}
	}
}

stock LoadPlayerCrashes(playerid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM player_crashes WHERE player_id = '%d'", 
			PlayerInfo[playerid][pSQLID]), 
		"LoadingPlayerCrashes", 
		"i", 
		playerid
	);
	return 1;
}

forward LoadingPlayerCrashes(playerid);
public LoadingPlayerCrashes(playerid)
{
	if(!cache_num_rows()) 
		return 0;
	
	cache_get_value_name_int(0,			"id"		, PlayerInfo[playerid][pCrashId]);
	cache_get_value_name_float(0,		"pos_x"		, PlayerInfo[playerid][pCrashPos][0]);
	cache_get_value_name_float(0,		"pos_y"		, PlayerInfo[playerid][pCrashPos][1]);
	cache_get_value_name_float(0,		"pos_z"		, PlayerInfo[playerid][pCrashPos][2]);
	cache_get_value_name_int(0, 		"interior"	, PlayerInfo[playerid][pCrashInt]);
	cache_get_value_name_int(0, 		"viwo"		, PlayerInfo[playerid][pCrashVW]);
	cache_get_value_name_int(0, 		"skin"		, PlayerInfo[playerid][pSkin]);
	cache_get_value_name_float(0,		"armor"		, PlayerInfo[playerid][pCrashArmour]);
	cache_get_value_name_float(0,		"health"	, PlayerInfo[playerid][pCrashHealth]);
	return 1;
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

#include <YSI_Coding\y_hooks>
hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit1_Get(gr_LoginChecksOn, playerid ) )
		stop LoginCheckTimer[playerid];

	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_LOGIN:
		{
			if(!response) Kick(playerid);
			if(isnull(inputtext))
			{
				format(dialogtext, sizeof(dialogtext), ""COL_RED"Ostavili ste prazno polje za lozinku!\n\
															"COL_WHITE"Provjerite velika i mala slova, te unesite valjanu sifru.\n\
															Imate jos "COL_LIGHTBLUE"%d"COL_WHITE"pokusaja za unos valjane sifre!\n\n\n\
															"COL_RED"Ukoliko ne unesete dobru sifru onda cete dobiti kick!", MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid));
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""COL_WHITE"PRIJAVA", dialogtext, "Sign In", "Abort");
				Bit8_Set(gr_LoginInputs, playerid, Bit8_Get(gr_LoginInputs, playerid) + 1);
				return 1;
			}
			if( !( MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid) ) )
			{
				//Kick
				SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobili ste IP ban radi pogresnih pokusaja ulaska u racun!");
				BanMessage(playerid);
				return 1;
			}
			new input_password[12];
			strcat(input_password, inputtext, 12);
			inline PasswordForQuery()
			{
				new sqlid, sql_password[BCRYPT_HASH_LENGTH];

				cache_get_value_name_int(0, "sqlid", sqlid);
				cache_get_value_name(0, "password", sql_password, BCRYPT_HASH_LENGTH);
				
				bcrypt_check(input_password, sql_password,  "OnPasswordChecked", "d", playerid);
				return 1;
			}
			MySQL_TQueryInline(
				g_SQL, 
				using inline PasswordForQuery,
				va_fquery(g_SQL, "SELECT sqlid, password FROM accounts WHERE name = '%e'", GetName(playerid, false)) 
			);
			return 1;
		}
		case DIALOG_SEC_SAMPID:
		{
		    if(!response)
				return Kick(playerid);

			if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
				return Kick(playerid);
			
			if(isnull(inputtext))
			    return Kick(playerid);
			    
			if(strlen(inputtext) > 31)
			    return Kick(playerid);
			    
            if(!strcmp(inputtext, PlayerInfo[playerid][pSecQuestAnswer]))
            {
				OnSecurityBreach[playerid] = false;

				#if defined MODULE_LOGS
                Log_Write("logfiles/GPCI.txt", "(%s) Player %s[%d]{%d}<%s> logged in with unknown GPCI for his account.", ReturnDate(), GetName(playerid), playerid, PlayerInfo[playerid][pSQLID], ReturnPlayerIP(playerid));
				#endif
				
				new log_gpci[128];
				format(log_gpci, sizeof(log_gpci), "Igrac %s[%d] se ulogirao na racun s nepoznatog kompjutera!", GetName(playerid), playerid);
				ABroadCast(COLOR_LIGHTRED, log_gpci, 1);
				gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
				
				Bit1_Set(gr_PlayerLoggedIn, playerid, true);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "U toku je ucitavanje podataka. Pricekajte 5 sekundi.");
				defer FinishPlayerSpawn(playerid);
				return 1;
            }
            else
			{
			    if(-- secquestattempt[playerid] == 0)
			    {
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        SendClientMessage(playerid, -1, "");
			        
			        SendClientMessage(playerid, COLOR_RED, "Vas account je sada zakljucan od strane security sistema!");
			        SendClientMessage(playerid, COLOR_RED, "Postavite zahtjev za unban na forumu kako bi otklju�ali vas account!");

					#if defined MODULE_BANS
					HOOK_Ban(playerid, INVALID_PLAYER_ID, "Krivi sigurnosni odgovor", -3,  true);
					#endif
					return 1;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_RED, "Ukoliko se ne sjecate vaseg odgovora kontaktirajte developere na forumu kako bi Vam pomogli!");
    				va_ShowPlayerDialog(playerid, DIALOG_SEC_SAMPID, DIALOG_STYLE_PASSWORD, ""#COL_RED"SECURITY BREACH", ""#COL_WHITE"Molimo odgovorite na sigurnosno pitanje kako bi nastavili\nPreostalo pokusaja: "#COL_RED"%d"#COL_WHITE"\n\n%s", "Answer", "Abort", secquestattempt[playerid], secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				}
			}
			return 1;
		}
		case DIALOG_REGISTER:
		{
			#if defined COA_UCP
				SendClientMessage(playerid, COLOR_RED, "Niste registrirali svoj racun na ucp.cityofangels-roleplay.com!");
				KickMessage(playerid);
			#else
				if(response) {
					ShowPlayerDialog(playerid, DIALOG_REG_AGREE, DIALOG_STYLE_MSGBOX, ""COL_WHITE"REGISTRACIJA - AGREEMENT(2/6)", ""COL_WHITE"Prihvacate da, tokom svoga igranja na\n\
					ovom serveru necete krsiti pravila servera, zloupotrebljavati\n\
					bugove, vrijedati druge igrace, lazno se predstavljati,\n\
					koristiti zlonamjerne programe ili na bilo koji drugi nacin\n\
					onemogucavati drugim igracima ugodnu igru na svome serveru\n\n\
					Ukoliko prihvacate kliknite \"I agree\"!", "I agree", "Abort");
				}
				else if(!response) 
					Kick(playerid);
			#endif
			return 1;
		}
		case DIALOG_REG_AGREE:
		{
			if(response) {
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Upisite lozinku kojom ce biti dostupna samo vasa \n\
														 i koja ce vam omoguciti sigurnost vaseg racuna te, lozinka mora\n\
														 sadrzavati 6-12 znakova.");
				ShowPlayerDialog(playerid, DIALOG_REG_PASS, DIALOG_STYLE_PASSWORD, ""COL_WHITE"REGISTRACIJA - PASSWORD(3/6)", dialogtext, "Input", "Abort");
			}
			else if(!response) {
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Dobro dosli "COL_LIGHTBLUE"%s!\n\n\
													"COL_WHITE"Vas racun nije registriran, ukoliko\n\
													se zelite registrirati kliknite na gumb \"Register\"\n\
													Uprotivnome cete biti kickani sa servera!",GetName(playerid));
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_MSGBOX, ""COL_WHITE"REGISTRACIJA (1/6)", dialogtext, "Register", "Abort");
			}
			return 1;
		}
		case DIALOG_REG_PASS:
		{
			if(response) {
				if(isnull(inputtext))
				{
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Upisite lozinku kojom ce biti dostupna samo vama \n\
														 i koja ce vam omoguciti sigurnost vaseg racuna te, lozinka mora\n\
														 sadrzavati "COL_LIGHTBLUE"6-12 znakova"COL_WHITE".\n\
														 "COL_RED"Ostavili ste prazno polje za lozinku!");
					ShowPlayerDialog(playerid, DIALOG_REG_PASS, DIALOG_STYLE_PASSWORD, ""COL_WHITE"REGISTRACIJA - PASSWORD(3/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
				{
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Upisite lozinku kojom ce biti dostupna samo vama \n\
														 i koja ce vam omoguciti sigurnost vaseg racuna te, lozinka mora\n\
														 sadrzavati "COL_LIGHTBLUE"6-12 znakova"COL_WHITE".\n\
														 "COL_RED"Ne smijete upisivati znakove: %+^|?*#!$>' u password!");
					ShowPlayerDialog(playerid, DIALOG_REG_PASS, DIALOG_STYLE_PASSWORD, ""COL_WHITE"REGISTRACIJA - PASSWORD(3/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if(6 <= strlen(inputtext) <= 12) {
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti\n\vaseg racuna:");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					format(PlayerInfo[playerid][pPassword], BCRYPT_HASH_LENGTH, inputtext);
					Bit8_Set(gr_RegisterInputs, playerid, 0);
					return 1;
				}
				if( (Bit8_Get(gr_RegisterInputs, playerid)) > 3 )
				{
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Nedozvoljen broj ponavljanja krivih unosa lozinke.");
					KickMessage(playerid);
					return 1;
				}
				else {
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Upisite lozinku kojom ce biti dostupna samo vama \n\
														 i koja ce vam omoguciti sigurnost vaseg racuna te, lozinka mora\n\
														 sadrzavati "COL_LIGHTBLUE"6-12 znakova"COL_WHITE".");
					ShowPlayerDialog(playerid, DIALOG_REG_PASS, DIALOG_STYLE_PASSWORD, ""COL_WHITE"REGISTRACIJA - PASSWORD(3/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
			}
			else if(!response) {
				ShowPlayerDialog(playerid, DIALOG_REG_AGREE, DIALOG_STYLE_MSGBOX, ""COL_WHITE"REGISTRACIJA - AGREEMENT(2/6)", ""COL_WHITE"Prihvacate da, tokom svoga igranja na\n\
																					ovom serveru necete krsiti pravila servera, zloupotrebljavati\n\
																					bugove, vrijedati druge igrace, lazno se predstavljati,\n\
																					koristiti zlonamjerne programe ili na bilo koji drugi nacin\n\
																					onemogucavati drugim igracima ugodnu igru na svome serveru\n\n\
																					Ukoliko prihvacate kliknite \"Accept\"!", "Accept", "Odustajem");
			}
			return 1;
		}
		case DIALOG_REG_MAIL:
		{
			if(response) {
				if(isnull(inputtext))
				{
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti vaseg racuna:"COL_RED"\nOstavili ste prazno polje pod E-Mailom!\n");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
				{	
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti vaseg racuna:"COL_RED"\nNe smijete upisivati znakove: %+^|?*#!$>' u e-mail!\n");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if(!strlen(inputtext)) {
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti vaseg racuna:");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if(!IsValidEMail(inputtext)) {
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti vaseg racuna.\n{fa5555}Niste unijeli vazecu e-mail adresu!");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if(IsEMailInDB(inputtext)) {
					format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti vaseg racuna.\n{fa5555}Niste unijeli vazecu e-mail adresu!");
					ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
					Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
					return 1;
				}
				if( (Bit8_Get(gr_RegisterInputs, playerid)) > 3 )
				{
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Nedozvoljen broj ponavljanja krivih unosa E-Maila.");
					KickMessage(playerid);
					return 1;
				}
				format(PlayerInfo[playerid][pEmail], MAX_PLAYER_MAIL, "%s", inputtext);
				Bit8_Set(gr_RegisterInputs, playerid, 0);
				ShowPlayerDialog(playerid, DIALOG_REG_SEX, DIALOG_STYLE_LIST, ""COL_WHITE"REGISTRACIJA - Spol(5/6)", "Musko\nZensko", "Input", "Abort");
			}
			else if(!response) {
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Upisite lozinku kojom ce biti dostupna samo vasa \n\
														 i koja ce vam omoguciti sigurnost vaseg racuna te, lozinka mora\n\
														 sadrzavati "COL_LIGHTBLUE"6-12 znakova"COL_WHITE".");
				ShowPlayerDialog(playerid, DIALOG_REG_PASS, DIALOG_STYLE_PASSWORD, ""COL_WHITE"REGISTRACIJA - PASSWORD(3/6)", dialogtext, "Input", "Abort");
			}
			return 1;
		}
		case DIALOG_REG_SEX:
		{
			if(response) {
				switch(listitem)
				{
					case 0: PlayerInfo[playerid][pSex] = 1; //musko
					case 1: PlayerInfo[playerid][pSex] = 2; //zensko
				}
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Koliko imate godina?\n\n "COL_RED"PAZNJA: Minimalno smijete imati 16, a najvise 80!");
				ShowPlayerDialog(playerid, DIALOG_REG_AGE, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - Godine(6/6)", dialogtext, "Input", "Abort");
			}
			else if(!response) {
				format(dialogtext, sizeof(dialogtext), ""COL_WHITE"Unesite svoj vazeci e-mail radi dodatne sigurnosti\nvaseg racuna:");
				ShowPlayerDialog(playerid, DIALOG_REG_MAIL, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - E-MAIL(4/6)", dialogtext, "Input", "Abort");
				return 1;
			}
			return 1;
		}
		case DIALOG_REG_AGE:
		{
			if(response) {
				if (!strlen(inputtext)) // Nothing typed in
				{
					ShowPlayerDialog(playerid, DIALOG_REG_AGE, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - Godine(6/6)", ""COL_WHITE"Koliko imate godina?\n\nPAZNJA: Minimalno smijete imati 16, a najvise 80!", "Input", "Abort");
					return 1;
				}
				if (strval(inputtext) >= 16 && strval(inputtext) <= 80)
				{
					PlayerInfo[playerid][pAge] = strval(inputtext);
					
					RegisterPlayer(playerid);
				}
				else ShowPlayerDialog(playerid, DIALOG_REG_AGE, DIALOG_STYLE_INPUT, ""COL_WHITE"REGISTRACIJA - Godine(6/6)", ""COL_WHITE"Koliko imate godina?\n\nPAZNJA: Minimalno smijete imati 16, a najvise 80!", "Input", "Abort");
			}
			else ShowPlayerDialog(playerid, DIALOG_REG_SEX, DIALOG_STYLE_LIST, ""COL_WHITE"REGISTRACIJA - Spol(5/6)", "Musko\nZensko", "Input", "Abort");
			return 1;
		}
	}
	return 0;
}