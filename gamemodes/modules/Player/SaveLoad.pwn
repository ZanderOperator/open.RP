#include <YSI_Coding\y_hooks>

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
		if( PlayerInfo[playerid][pJailed] )
		{
			new crashDelete[128];
			format(crashDelete, 128, "DELETE FROM `player_crashes` WHERE `id` = '%d'", PlayerInfo[playerid][pCrashId]);
			mysql_tquery(g_SQL, crashDelete);

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

		new crashDelete[128];
		format(crashDelete, 128, "DELETE FROM `player_crashes` WHERE `id` = '%d'", PlayerInfo[playerid][pCrashId]);
		mysql_tquery(g_SQL, crashDelete);
	
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
	if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && !isnull(PlayerInfo[playerid][pAdminMsg]) && PlayerInfo[playerid][pAdmMsgConfirm] == 0)
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[City of Angels]: "COL_WHITE"Server je updatean na verziju "COL_LIGHTBLUE"%s"COL_WHITE", za vise informacija - /update.", SCRIPT_VERSION);
		ShowAdminMessage(playerid);
		goto spawn_end;
	}
	else if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && (PlayerInfo[playerid][pAdmMsgConfirm] || isnull(PlayerInfo[playerid][pAdminMsg])))
	{
		if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0)
			PlayerReward[playerid] = true;
		ShowPlayerUpdateList(playerid);
		goto spawn_end;
	}
	else if(!isnull(PlayerInfo[playerid][pAdminMsg]) && PlayerInfo[playerid][pAdmMsgConfirm] == 0 && strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) == 0)
	{
		ShowAdminMessage(playerid);
		goto spawn_end;
	}

	spawn_end:	
	SafeSpawned[ playerid ] = true;
	AC_SetPlayerWeapons(playerid);
	LoadPlayerSkills(playerid);
	LoadPlayerObjects(playerid);
	LoadPlayerCredit(playerid);
	CheckPlayerInteriors(playerid);
	CheckPlayerInactivity(playerid);
	CheckPlayerMasks(playerid);
	return 1;
}

//Forwards
forward CheckPlayerInBase(playerid);
forward PasswordForQuery(playerid, const inputtext[]);
forward LoadPlayerData(playerid);
forward RegisterPlayer(playerid);
forward OnAccountFinish(playerid);


//Publics
CheckPlayerInactivity(playerid)
{
	new tmpQuery[128], rows;
	format(tmpQuery, sizeof(tmpQuery), "SELECT * FROM `inactive_accounts` WHERE `sqlid` = '%d' LIMIT 0,1", PlayerInfo[playerid][pSQLID]);
	inline OnPlayerInactivityCheck()
	{
		rows = cache_num_rows();
		if(!rows)
			return 1;
		
		new deleteQuery[128];
		format(deleteQuery, sizeof(deleteQuery), "DELETE FROM `inactive_accounts` WHERE `sqlid` = '%d'", PlayerInfo[playerid][pSQLID]);
		mysql_tquery(g_SQL, deleteQuery);
		SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER]: Neaktivnost koju ste imali prijavljenu u bazi podataka je deaktivirana.");
		
		return 1;
	}
	mysql_tquery_inline_new(g_SQL, tmpQuery, using inline OnPlayerInactivityCheck, "i", playerid);
	return 1;
}

Public: OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
	if(match)
	{
		new
			loginCheck[256];
		mysql_format(g_SQL, loginCheck, sizeof(loginCheck),"SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", GetName(playerid, false));
		mysql_tquery(g_SQL, loginCheck, "LoadPlayerData", "i", playerid);
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

public PasswordForQuery(playerid, const inputtext[])
{
	new rows;
    cache_get_row_count(rows);
    if(rows)
	{
		new sqlid, input_password[12], sql_password[BCRYPT_HASH_LENGTH];
		strcat(input_password, inputtext, 12);

		cache_get_value_name_int(0, "sqlid", sqlid);
        cache_get_value_name(0, "password", sql_password, BCRYPT_HASH_LENGTH);
		
		bcrypt_check(input_password, sql_password,  "OnPasswordChecked", "d", playerid);
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
		
		cache_get_value_name(0, 	"teampin"		, PlayerInfo[playerid][pTeamPIN]		, 129);
		cache_get_value_name_int(0, "secquestion"	, PlayerInfo[playerid][pSecQuestion]);
		cache_get_value_name(0, 	"secawnser"		, PlayerInfo[playerid][pSecQuestAnswer]	, 31);
		cache_get_value_name(0, 	"email"			, PlayerInfo[playerid][pEmail]			, MAX_PLAYER_MAIL);
		cache_get_value_name(0, 	"SAMPid"		, PlayerInfo[playerid][pSAMPid]			, 128);
		cache_get_value_name(0, 	"lastlogin"		, PlayerInfo[playerid][pLastLogin]		, 24);
		cache_get_value_name_int(0, "lastloginstamp", PlayerInfo[playerid][pLastLoginTimestamp]);
		cache_get_value_name(0, 	"lastip"		, PlayerInfo[playerid][pLastIP]			, 24);
		
		cache_get_value_name(0, 	"password"		, PlayerInfo[playerid][pPassword]		, 129);
		cache_get_value_name_int(0, "spawnchange"	, PlayerInfo[playerid][pSpawnChange]);
		
		cache_get_value_name_int(0, "registered"	, PlayerInfo[playerid][pRegistered]);
		cache_get_value_name(0, "forumname"			, PlayerInfo[playerid][pForumName], 24);

		cache_get_value_name_int(0, "adminLvl"		, PlayerInfo[playerid][pTempRank][0]);
		cache_get_value_name_int(0, "helper"		, PlayerInfo[playerid][pTempRank][1]);
		cache_get_value_name_int(0, "playaWarns"	, PlayerInfo[playerid][pWarns]);

		cache_get_value_name_int(0, "vipRank"		, PlayerInfo[playerid][pDonateRank]);
		cache_get_value_name_int(0,	"vipTime"		, PlayerInfo[playerid][pDonateTime]);
		cache_get_value_name_int(0,	"donateveh"		, PlayerInfo[playerid][pDonatorVehicle]);
		cache_get_value_name_int(0,	"dvehperms"		, PlayerInfo[playerid][pDonatorVehPerms]);
		cache_get_value_name_int(0, "muted"			, PlayerInfo[playerid][pMuted]);
		cache_get_value_name_int(0, "respects"		, PlayerInfo[playerid][pRespects]);

		cache_get_value_name_int(0,  "sex"			, PlayerInfo[playerid][pSex]);
		cache_get_value_name_int(0,  "age"			, PlayerInfo[playerid][pAge]);
		cache_get_value_name_int(0,  "changenames"	, PlayerInfo[playerid][pChangenames]);
		cache_get_value_name_int(0,  "changetimes"	, PlayerInfo[playerid][pChangeTimes]);
		cache_get_value_name_int(0,  "handMoney"	, PlayerInfo[playerid][pMoney]);
		cache_get_value_name_int(0,  "bankMoney"	, PlayerInfo[playerid][pBank]);

		cache_get_value_name_int(0,  "jobkey"		, PlayerInfo[playerid][pJob]);
		cache_get_value_name_int(0,  "freeworks"	, PlayerInfo[playerid][pFreeWorks]);
		cache_get_value_name_int(0,  "fishworks"	, PlayerInfo[playerid][pFishWorks]);
		cache_get_value_name_int(0,  "parts"		, PlayerInfo[playerid][pParts]);
		cache_get_value_name_int(0,  "contracttime"	, PlayerInfo[playerid][pContractTime]);
		cache_get_value_name_int(0,  "facLeadId"	, PlayerInfo[playerid][pLeader]);
		cache_get_value_name_int(0,  "facMemId"		, PlayerInfo[playerid][pMember]);
		cache_get_value_name_int(0,  "facRank"		, PlayerInfo[playerid][pRank]);
        cache_get_value_name_float(0,"health"		, PlayerInfo[playerid][pHealth]);

        cache_get_value_name_int(0,  "playaSkin"	, PlayerInfo[playerid][pChar]);
		format(PlayerInfo[playerid][pAccent]		, sizeof(string), string);
		cache_get_value_name(0,		 "marriedto"	, PlayerInfo[playerid][pMarriedTo]	, MAX_PLAYER_NAME);

		cache_get_value_name_int(0,  "carlic"		, PlayerInfo[playerid][pCarLic]);
		cache_get_value_name_int(0,  "gunlic"		, PlayerInfo[playerid][pGunLic]);
		cache_get_value_name_int(0,	 "boatlic"		, PlayerInfo[playerid][pBoatLic]);
		cache_get_value_name_int(0,	 "fishlic"		, PlayerInfo[playerid][pFishLic]);
		cache_get_value_name_int(0,	 "flylic"		, PlayerInfo[playerid][pFlyLic]);

		cache_get_value_name_int(0,  "jailed"		, PlayerInfo[playerid][pJailed]);		
		cache_get_value_name_int(0,  "jailtime"		, PlayerInfo[playerid][pJailTime]); 
		cache_get_value_name_int(0,  "bailprice"		, PlayerInfo[playerid][pBailPrice]);
		
		cache_get_value_name_int(0,  "rentkey"		, PlayerInfo[playerid][pRentKey]);
		cache_get_value_name_int(0,  "maskid"		, PlayerInfo[playerid][pMaskID]);
		cache_get_value_name_int(0,  "spawnedcar"	, PlayerInfo[playerid][pSpawnedCar]);
		cache_get_value_name_float(0, "hunger"		, PlayerInfo[playerid][pHunger]);

		cache_get_value_name_float(0,"armour"		, PlayerInfo[playerid][pArmour]);
		cache_get_value_name_int(0, "muscle"		, PlayerInfo[playerid][pMuscle]);
		cache_get_value_name_int(0, "arrested"		, PlayerInfo[playerid][pArrested]);
		cache_get_value_name_int(0,	"fightstyle"	, PlayerInfo[playerid][pFightStyle]);

		cache_get_value_name_int(0, "clock"			, PlayerInfo[playerid][pClock]);
		cache_get_value_name_int(0, "rope"			, PlayerInfo[playerid][hRope]);
		cache_get_value_name_int(0, "cigaretes"		, PlayerInfo[playerid][pCiggaretes]);	
		cache_get_value_name_int(0, "lighter"		, PlayerInfo[playerid][pLighter]);		
		cache_get_value_name_int(0, "playaPayDay"	, PlayerInfo[playerid][pPayDay]);	
		cache_get_value_name_int(0, "playaPDMoney"	, PlayerInfo[playerid][pPayDayMoney]);
		cache_get_value_name_int(0, "profit"		, PlayerInfo[playerid][pProfit]);
		cache_get_value_name(0, 	"paydayDialog"	, PlayerInfo[playerid][pPayDayDialog], 2048);
		cache_get_value_name(0, 	"paydaydate"	, PlayerInfo[playerid][pPayDayDate], 32);

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
		cache_get_value_name_int(0,	"passport"		, PlayerInfo[playerid][pPassport]);
		
		cache_get_value_name_int(0,	"savings_cool"	, PlayerInfo[playerid][pSavingsCool]);
		cache_get_value_name_int(0,	"savings_time"	, PlayerInfo[playerid][pSavingsTime]);
		cache_get_value_name_int(0,	"savings_type"	, PlayerInfo[playerid][pSavingsType]);
		cache_get_value_name_int(0,	"savings_money"	, PlayerInfo[playerid][pSavingsMoney]);
		
		cache_get_value_name_int(0,	"ammutime"		, PlayerInfo[playerid][pAmmuTime]);
		cache_get_value_name_int(0,	"warekey"		, PlayerInfo[playerid][pWarehouseKey]);
		cache_get_value_name_int(0, "taxiPoints"	, PlayerInfo[playerid][taxiPoints]);
		cache_get_value_name_int(0, "taxiVoted"		, PlayerInfo[playerid][taxiVoted]);
		cache_get_value_name_int(0,	"mustread"		, PlayerInfo[playerid][pMustRead]);
		cache_get_value_name(0, 	"lastupdatever"	, PlayerInfo[playerid][pLastUpdateVer], 24);
		cache_get_value_name_int(0, "JackerCoolDown", PlayerInfo[playerid][JackerCoolDown]);
		cache_get_value_name_int(0, "pBusinessJob", PlayerInfo[playerid][pBusinessJob]);
		cache_get_value_name_int(0, "pBusinessWorkTime", PlayerInfo[playerid][pBusinessWorkTime]);
		cache_get_value_name_int(0, "FurnPremium"	, PlayerInfo[playerid][FurnPremium]);
		
		cache_get_value_name_int(0,	"HasRadio"		, PlayerInfo[playerid][pHasRadio]);
		cache_get_value_name_int(0, "MainSlot"      , PlayerInfo[playerid][pMainSlot]);
		

		cache_get_value_name_int(0, "Radio1", PlayerInfo[playerid][pRadio][1]);
		cache_get_value_name_int(0, "Radio2", PlayerInfo[playerid][pRadio][2]);
		cache_get_value_name_int(0, "Radio3", PlayerInfo[playerid][pRadio][3]);

		cache_get_value_name_int(0, "Slot1", PlayerInfo[playerid][pRadioSlot][1]);
		cache_get_value_name_int(0, "Slot2", PlayerInfo[playerid][pRadioSlot][2]);
		cache_get_value_name_int(0, "Slot3", PlayerInfo[playerid][pRadioSlot][3]);
		
		cache_get_value_name_int(0, "drugused", PlayerInfo[playerid][pDrugUsed]);
		cache_get_value_name_int(0, "drugseconds", PlayerInfo[playerid][pDrugSeconds]);

		cache_get_value_name_int(0, "lastdrug", PlayerInfo[playerid][pDrugOrder]);
		
		//Adminmsg
		cache_get_value_name(0, "AdminMessage", PlayerInfo[playerid][pAdminMsg], 2048);
		cache_get_value_name(0, "AdminMessageBy", PlayerInfo[playerid][pAdminMsgBy], 60);
		cache_get_value_name_int(0, "AdmMessageConfirm", PlayerInfo[playerid][pAdmMsgConfirm]);
		
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
			new
				player_name[ 49 ],
				mysqlQuery[ 112 ];

			GetPlayerName( playerid, player_name, MAX_PLAYER_NAME );

			mysql_format(g_SQL, mysqlQuery, 112, "UPDATE `accounts` SET `playaUnbanTime` = '0' WHERE `name` = '%e'",
				player_name
			);
			mysql_tquery( g_SQL, mysqlQuery, "", "");

			PlayerInfo[ playerid ][ pUnbanTime ] 		= 0;
			PlayerInfo[ playerid ][ pBanReason ][ 0 ] 	= EOS;
		} else 
		{
			new date[12], time[12];
			TimeFormat(Timestamp:PlayerInfo[ playerid ][ pUnbanTime ], HUMAN_DATE, date);
			TimeFormat(Timestamp:PlayerInfo[ playerid ][ pUnbanTime ], ISO6801_TIME, time);
	
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "[CoA-RP Server]: Vasa zabrana igranja zavrsava "COL_SERVER"%s %s.", date, time);
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "Razlog bana: %s", PlayerInfo[ playerid ][ pBanReason ]);

			KickMessage(playerid);
			return 1;
		}
		// Weapons & Drugs
		LoadPlayerWeaponSettings(playerid);
		AC_LoadPlayerWeapons(playerid);
		LoadPlayerPackage(playerid);
		
		LoadPlayerDrugs(playerid);
		
		// Car Ownership list
		CheckPlayerVehicle(playerid);
		GetPlayerVehicleList(playerid);
		
		// Crashes
		LoadPlayerCrashes(playerid);
		
		// Roleplay Experience(EXP)
		LoadPlayerExperience(playerid);
		
		// Mobile
		LoadPlayerMobile(playerid);
		LoadPlayerDeath(playerid);
		
		//Fish	
		//LoadPlayerFishes(playerid);
		
		// Rest of preload
		if( PlayerInfo[ playerid ][ pAdmin ] || PlayerInfo[ playerid ][ pHelper ] )
			LoadAdminConnectionTime(playerid);
			
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
	new
		tmpName[MAX_PLAYER_NAME],
		mysqlquery[512];
	format(tmpName, MAX_PLAYER_NAME, "%s", GetName(playerid, false));
	format(PlayerInfo[playerid][pLastLogin], 24, ReturnDate());

	mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "INSERT INTO `accounts` (`registered`,`register_date`,`name`,`password`,`teampin`,`email`,`secawnser`,`expdate`,`levels`,`age`,`sex`,`handMoney`,`bankMoney`,`jobkey`,`playaSkin`,`casinocool`) VALUES ('0','%e','%e','%e','','%e','','','%d','%d','%d','%d','%d','%d','%d','%d')",
		ReturnDate(),
		tmpName,
		PlayerInfo[playerid][pPassword],
		PlayerInfo[playerid][pEmail],
		1,
		PlayerInfo[playerid][pAge],
		PlayerInfo[playerid][pSex],
		NEW_PLAYER_MONEY,
		NEW_PLAYER_BANK,
		0,
		29,
		5);
	
    mysql_tquery(g_SQL,mysqlquery, "OnAccountFinish", "i", playerid);
	return 1;
}

public OnAccountFinish(playerid)
{	
	//Enum set
	PlayerInfo[playerid][pSQLID] 			= cache_insert_id();
	PlayerInfo[playerid][pRegistered] 		= 0;
	PlayerInfo[playerid][pLevel] 			= 1;
	PlayerInfo[playerid][pChar] 			= 29;
	PlayerInfo[playerid][pPayDayMoney] 		= 0;
	PlayerInfo[playerid][pProfit]			= 0;
	PlayerInfo[playerid][pFreeWorks] 		= 15;
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
		emailQuery[128],
		Cache:result,
		counts;
	
	mysql_format(g_SQL, emailQuery, sizeof(emailQuery), "SELECT * FROM `accounts` WHERE `email` = '%e'", email);
	result = mysql_query(g_SQL, emailQuery);
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
	new connectQuery[105];
	mysql_format(g_SQL, connectQuery, 105, "INSERT INTO `player_connects`(`player_id`, `time`, `aip`) VALUES ('%d','%d','%e')",
		PlayerInfo[playerid][pSQLID],
		gettimestamp(),
		GetPlayerIP(playerid)
	);
	mysql_pquery(g_SQL, connectQuery);
	
	new loginQuery[128];
	
	format(loginQuery, 128, "UPDATE `accounts` SET `online` = '1' WHERE `sqlid` = '%d'", PlayerInfo[ playerid ][ pSQLID ]);
	mysql_tquery(g_SQL, loginQuery);
	
	if( ( 10 <= PlayerInfo[ playerid ][ pJob ] <= 12 ) && ( !PlayerInfo[playerid][pMember] && !PlayerInfo[playerid][pLeader])  )
		PlayerInfo[ playerid ][ pJob ] = 0;

	if( !PlayerInfo[playerid][pRegistered] )
		PlayerNewUser_Set(playerid, true);
		
	// Donacije
	if( PlayerInfo[playerid][pDonateTime] < gettimestamp() && PlayerInfo[playerid][pDonateRank] > 0 ) {
		SendClientMessage( playerid, COLOR_ORANGE, "[CoA Server]: Vrijeme vaseg Premium VIP paketa je isteklo! Ukoliko zelite produziti VIP onda donirajte opet!");
		PlayerInfo[playerid][pDonateTime] = 0;
		PlayerInfo[playerid][pDonateRank] = 0;
		if(PlayerInfo[playerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(playerid);
		if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(playerid, -1, PlayerInfo[ playerid ][ pHouseKey ]);
			
		format(loginQuery, 128, "UPDATE `accounts` SET `vipRank` = '0', `vipTime` = '0' WHERE `sqlid` = '%d'", PlayerInfo[ playerid ][ pSQLID ]); //Svaki put kad bi nekon isteka donator skripta bi sve ovo iznad radila iako je isteka jer prikazuje bivsim donatorima ovaj tekst (neko nije stavia da se sejva donatorrank i time) mislin da je nepotrebno stavljat u save query kad igrac izlazi jer je napravljeno kad se daje donator da odmah sprema
		mysql_tquery(g_SQL, loginQuery);
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
	CallLocalFunction("OnPlayerSpawn", "i", playerid);
	return 1;
}

stock ShowAdminMessage(playerid)
{
	new 
		string[2048];
		
	format(string, sizeof(string), "Obavijest od %s\n%s", PlayerInfo[playerid][pAdminMsgBy], PlayerInfo[playerid][pAdminMsg]);
	ShowPlayerDialog(playerid, DIALOG_ADMIN_MSG, DIALOG_STYLE_MSGBOX, "Admin Message", string, "Ok", "");
	return 1;
}

stock SavePlayerData(playerid)
{
    if( !SafeSpawned[playerid] )	
		return 1;
	
	SavePlayerCredit(playerid);
	SavePlayerExperience(playerid);
	UpdatePlayerMobile(playerid);
	AC_SavePlayerWeapons(playerid);
	SavePlayerSkill(playerid);
	//SavePlayerFishes(playerid);
	
	#if defined MODULE_ADMIN_CONNECTIONS
	if( PlayerInfo[ playerid ][ pAdmin ] || PlayerInfo[ playerid ][ pHelper ] )
		SaveAdminConnectionTime(playerid);
	#endif
	
	new 
		mysqlUpdate[4096];
	mysql_tquery(g_SQL, "START TRANSACTION");
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `online` = '0',`registered` = '%d',`adminLvl` = '%d',`helper` = '%d',`playaWarns` = '%d',`lastlogin` = '%e',`lastloginstamp` = '%d', `lastip` = '%e'  WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pRegistered],
		PlayerInfo[playerid][pTempRank][0],
		PlayerInfo[playerid][pTempRank][1],
		PlayerInfo[playerid][pWarns],
		PlayerInfo[playerid][pLastLogin],
		PlayerInfo[playerid][pLastLoginTimestamp],
		PlayerInfo[playerid][cIP],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `muted` = '%d', `sex` = '%d', `age` = '%d', `changenames` = '%d', `changetimes` = '%d', `handMoney` = '%d', `bankMoney` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pMuted],
		PlayerInfo[playerid][pSex],
		PlayerInfo[playerid][pAge],
		PlayerInfo[playerid][pChangenames],
		PlayerInfo[playerid][pChangeTimes],
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `connecttime` = '%d', `contracttime` = '%d', `freeworks` = '%d', `fishworks` = '%d', `fishsqlid` = '%d', `levels` = '%d', `respects` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pConnectTime],
		PlayerInfo[playerid][pContractTime],
		PlayerInfo[playerid][pFreeWorks],
		PlayerInfo[playerid][pFishWorks],
		PlayerInfo[playerid][pFishSQLID],
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pRespects],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_pquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `jobkey` = '%d',  `parts` = '%d', `contracttime` = '%d', `health` = '%f', `FishingSkill` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pJob],
		PlayerInfo[playerid][pParts],
		PlayerInfo[playerid][pContractTime],
		PlayerInfo[playerid][pHealth],
		PlayerInfo[playerid][pFishingSkill],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `jailed` = '%d', `jailtime` = '%d', `bailprice` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pJailed],
		PlayerInfo[playerid][pJailTime],
		PlayerInfo[playerid][pBailPrice],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `carlic` = '%d', `gunlic` = '%d', `boatlic` = '%d', `fishlic` = '%d', `flylic` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pCarLic],
		PlayerInfo[playerid][pGunLic],
		PlayerInfo[playerid][pBoatLic],
		PlayerInfo[playerid][pFishLic],
		PlayerInfo[playerid][pFlyLic],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);
		
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `rentkey` = '%d', `maskid` = '%d', `hunger` = '%f' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pRentKey],
		PlayerInfo[playerid][pMaskID],
		PlayerInfo[playerid][pHunger],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `spawnedcar` = '%d', `armour` = '%f', `muscle` = '%d', `arrested` = '%d', `fightstyle` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pSpawnedCar],
		PlayerInfo[playerid][pArmour],
		PlayerInfo[playerid][pMuscle],
		PlayerInfo[playerid][pArrested],
		PlayerInfo[playerid][pFightStyle],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);

	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `clock` = '%d', `rope` = '%d', `cigaretes` = '%d', `lighter` = '%d', `playaPayDay` = '%d', `playaPDMoney` = '%d', `profit` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pClock],
		PlayerInfo[playerid][hRope],
		PlayerInfo[playerid][pCiggaretes],
		PlayerInfo[playerid][pLighter],
		PlayerInfo[playerid][pPayDay],
		PlayerInfo[playerid][pPayDayMoney],
		PlayerInfo[playerid][pProfit],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `lijektimer` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pLijekTimer],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);	
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `passport` = '%d', `SAMPid` = '%e', `forumname` = '%e' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pPassport],
		PlayerInfo[playerid][pSAMPid],
		PlayerInfo[playerid][pForumName],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `gymtimes` = '%d', `gymcounter` = '%d', `boombox` = '%d', `boomboxtype` = '%d', `casinocool` = '%d', news = '%d', `HasRadio` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pGymTimes],
		PlayerInfo[playerid][pGymCounter],
		PlayerInfo[playerid][pBoomBox],
		PlayerInfo[playerid][pBoomBoxType],
		PlayerInfo[playerid][pCasinoCool],
		PlayerInfo[playerid][pNews],
		PlayerInfo[playerid][pHasRadio],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `voted` = '%d', `drugused` = '%d', `drugseconds` = '%d', `lastdrug` = '%d'   WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pVoted],
		PlayerInfo[playerid][pDrugUsed],
		PlayerInfo[playerid][pDrugSeconds],
		PlayerInfo[playerid][pDrugOrder],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `savings_cool` = '%d', `savings_time` = '%d', `savings_type` = '%d', `savings_money` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pSavingsCool],
		PlayerInfo[playerid][pSavingsTime],
		PlayerInfo[playerid][pSavingsType],
		PlayerInfo[playerid][pSavingsMoney],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `ammutime` = '%d', `warekey` = '%d', `mustread` = '%d', `lastupdatever` = '%e', `JackerCoolDown` = '%d', `FurnPremium` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pAmmuTime],
		PlayerInfo[playerid][pWarehouseKey],
		PlayerInfo[playerid][pMustRead],
		PlayerInfo[playerid][pLastUpdateVer],
		PlayerInfo[playerid][JackerCoolDown],
		PlayerInfo[playerid][FurnPremium],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `paydayDialog` = '%e', `paydaydate` = '%e' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pPayDayDialog],
		PlayerInfo[playerid][pPayDayDate],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `Radio1` = '%d', `Slot1` = '%d', `Radio2` = '%d', `Slot2` = '%d', `Radio3` = '%d', `Slot3` = '%d' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pRadio][1], PlayerInfo[playerid][pRadioSlot][1],
		PlayerInfo[playerid][pRadio][2], PlayerInfo[playerid][pRadioSlot][2],
		PlayerInfo[playerid][pRadio][3], PlayerInfo[playerid][pRadioSlot][3],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_format(g_SQL, mysqlUpdate, sizeof(mysqlUpdate), "UPDATE `accounts` SET `AdmMessageConfirm` = '%d', `AdminMessage` = '%e', `AdminMessageBy` = '%e' WHERE `sqlid` = '%d'",
		PlayerInfo[playerid][pAdmMsgConfirm],
		PlayerInfo[playerid][pAdminMsg],
		PlayerInfo[playerid][pAdminMsgBy],
		PlayerInfo[playerid][pSQLID]);
	mysql_tquery(g_SQL, mysqlUpdate);
	
	mysql_tquery(g_SQL, "COMMIT");
	return 1;
}

stock SetPlayerSpawnInfo(playerid)
{
	if(PlayerInfo[playerid][pJailed] == 2)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pChar], -10.9639, 2329.3030, 24.4, 0, 0, 0, 0, 0, 0, 0);
		Streamer_UpdateEx(playerid,  -10.9639, 2329.3030, 24.4);
	}
	else if(PlayerInfo[playerid][pJailed] == 3)
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
				switch(PlayerInfo[playerid][pMember])
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
	new
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `player_crashes` WHERE `player_id` = '%d' LIMIT 0,1",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery, "LoadingPlayerCrashes", "i", playerid);
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
			new loginCheckQuery[256];
			mysql_format(g_SQL, loginCheckQuery, sizeof(loginCheckQuery),"SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", GetName(playerid, false));
			mysql_tquery(g_SQL, loginCheckQuery, "PasswordForQuery", "is", playerid, inputtext);
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
					format(PlayerInfo[playerid][pPassword], 129, inputtext);
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