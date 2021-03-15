#include <YSI_Coding\y_hooks>

// Save/Load Player related func. modules - named after adjacent database tables
#include "modules/Player\SaveLoad/player_admin_msg.pwn"
#include "modules/Player\SaveLoad/player_inventory.pwn"
#include "modules/Player\SaveLoad/player_crashes.pwn"
#include "modules/Player\SaveLoad/player_health.pwn"
#include "modules/Player\SaveLoad/player_appearance.pwn"
#include "modules/Player\SaveLoad/player_jail.pwn"
#include "modules/Player\SaveLoad/player_cooldowns.pwn"

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	##   ##  #########  ##   ##         ## 
	 ## ##   ##     ##  ##    ##  ##    ## 
	  ###    ##     ##  ##     ##  ######  
*/
static  
		dialogtext[MAX_DIALOG_TEXT],
		Timer:LoginCheckTimer[MAX_PLAYERS],
		bool:SigningIn[MAX_PLAYERS],
		bool:FirstSaving[MAX_PLAYERS],
		bool:SecurityBreach[MAX_PLAYERS];

/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
*/

stock bool:Player_SecurityBreach(playerid)
{
	return SecurityBreach[playerid];
}

stock Player_SetSecurityBreach(playerid, bool:v)
{
	SecurityBreach[playerid] = v;
}

// Timers
timer LoginCheck[60000](playerid)
{
	if(!IsPlayerLogged(playerid) && IsPlayerConnected(playerid))
	{
		va_SendClientMessage(playerid, 
			COLOR_RED, 
			"[%s]: You got kicked for not logging in after 60 seconds!",
			SERVER_NAME
		);
		KickMessage(playerid);
	}
	return 1;
}

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


forward LoadPlayerData(playerid);

CheckPlayerInactivity(playerid)
{
	inline OnPlayerInactivityCheck()
	{
		if(!cache_num_rows())
			return 1;
		
		mysql_fquery(SQL_Handle(), "DELETE FROM inactive_accounts WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]);
		va_SendClientMessage(playerid, COLOR_LIGHTRED, 
			"[%s]: Registered inactivity on current account has been deactivated.",
			SERVER_NAME
		);		
		return 1;
	}
	MySQL_TQueryInline(SQL_Handle(),  
		using inline OnPlayerInactivityCheck, 
		va_fquery(SQL_Handle(), "SELECT sqlid FROM inactive_accounts WHERE sqlid = '%d'", 
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
		mysql_pquery(SQL_Handle(), 
			va_fquery(SQL_Handle(), "SELECT * FROM accounts WHERE name = '%e'", GetName(playerid, false)),
			"LoadPlayerData", 
			"i", 
			playerid
		);
	}
	else
	{
		Bit8_Set(gr_LoginInputs, playerid, Bit8_Get(gr_LoginInputs, playerid) + 1);
		if(!( MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid)))
		{
			va_SendClientMessage(playerid, COLOR_RED, 
				"[%s]: You have reached maximum(%d) attempts, you got an IP ban!",
				SERVER_NAME,
				MAX_LOGIN_TRIES
			);
			BanMessage(playerid);
			return 1;
		}
		if(Bit8_Get(gr_LoginInputs, playerid) < 3) 
		{
			format(dialogtext, sizeof(dialogtext), 
				""COL_RED"You have entered wrong password!\n\
					"COL_WHITE"Check your upper/lower case sensitivity and try again.\n\
					You have "COL_LIGHTBLUE"%d "COL_WHITE"attempts to input valid password!\n\n\n\
					"COL_RED"If you exceed max attempt limit, you will be kicked!", 
				MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid)
			);

			ShowPlayerDialog(playerid, 
				DIALOG_LOGIN, 
				DIALOG_STYLE_PASSWORD, 
				""COL_WHITE"Login", 
				dialogtext, 
				"Proceed", 
				"Abort"
			);
		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 0;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerLogged(playerid) || SafeSpawned[playerid])
		return 1;

	if(GMX == 1) 
	{
		va_SendClientMessage(playerid,
			COLOR_RED, 
			"%s is currently in data storing pre-restart process. You have been automatically kicked.",
			SERVER_NAME
		);
		KickMessage(playerid);
		return 1;
	}
	if(!IsPlayerLogged(playerid) || IsPlayerConnected(playerid))
	{
		ResetPlayerVariables(playerid);

		if(IsPlayerNPC(playerid)) 
		{
			SpawnPlayer(playerid);
			return 1;
		}
        ClearPlayerChat(playerid);
		
		new
			tmpname[24];
		GetPlayerName(playerid, tmpname, MAX_PLAYER_NAME);
		if(!IsValidNick(tmpname))
		 {
			SendClientMessage(playerid, COLOR_SAMP_GREEN, "ERROR: Invalid RolePlay nickname, please visit "WEB_URL" for more info!");
			KickMessage(playerid);
			return 0;
		}
		new
			hour, minute;
		GetServerTime(hour, minute);
		SetPlayerTime(playerid,hour,minute);
		SetPlayerColor(playerid, 	COLOR_PLAYER);
		SetPlayerWeather(playerid, 	WeatherSys);
		TogglePlayerSpectating(playerid, true);
		SetPlayerVirtualWorld(playerid, playerid);
		SetPlayerInterior(playerid, 0);
		TogglePlayerControllable(playerid, false);
		GetPlayerIp(playerid, PlayerInfo[playerid][pIP], 24);

		inline CheckPlayerInBase()
		{
			if(cache_num_rows()) 
			{
				TogglePlayerControllable(playerid, false);
				SetCameraBehindPlayer(playerid);
				RandomPlayerCameraView(playerid);					
				
				va_ShowPlayerDialog(playerid, 
					DIALOG_LOGIN, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Login", 
					""COL_WHITE"Greetings "COL_LIGHTBLUE"%s!\n\n\
						"COL_WHITE"It's nice to see you again on our server.\n\
						Please enter your account's password and log in.\n\
						You have "COL_LIGHTBLUE"%d"COL_WHITE" seconds to\n\
						sign in, otherwise you'll be kicked out.\n\n\
						Thank you and we hope you'll enjoy your gameplay on "COL_LIGHTBLUE"%s"COL_WHITE"!", 
					"Proceed", 
					"Abort",
					GetName(playerid),
					MAX_LOGIN_TIME,
					SERVER_NAME
				);
				
				Bit8_Set(gr_LoginInputs, playerid, 0);
				SigningIn[playerid] = true;
				LoginCheckTimer[playerid] = defer LoginCheck(playerid);
			} 
			else 
			{
				if(regenabled)
				{				
					#if defined COA_UCP
						va_SendClientMessage(playerid, COLOR_RED, "You haven't registered your account on %s!",
							WEB_URL
						);
						KickMessage(playerid);
					#else
						format(dialogtext, 
							sizeof(dialogtext), 
							""COL_WHITE"Welcome "COL_LIGHTBLUE"%s!\n\n\
								"COL_WHITE"Your account isn't registered on our server.\n\
								If you want to Sign Up, please press \"Register\".\n\
								Otherwise, you'll be kicked out of the server!",GetName(playerid)
						);
						ShowPlayerDialog(playerid, 
							DIALOG_REGISTER, 
							DIALOG_STYLE_MSGBOX, 
							""COL_WHITE"Sign Up (1/6)", 
							dialogtext, 
							"Register", 
							"Abort"
						);
					#endif
				}
				else
				{
					SendClientMessage(playerid, COLOR_RED, 
						"Administrator currently disabled registration on server. Please try again later.");
					KickMessage(playerid);
				}
			}
			return 1;
		}

		MySQL_TQueryInline(SQL_Handle(),  
			using inline CheckPlayerInBase,
			va_fquery(SQL_Handle(), "SELECT sqlid FROM accounts WHERE name = '%e'", tmpname), 
			"i",
			playerid
		);
	}
	return 1;
}



public LoadPlayerData(playerid)
{
	new 
		rows, 
		ban_reason[32],
		unban_time = 0;
    cache_get_row_count(rows);
    if(rows)
	{
		stop LoginCheckTimer[playerid];
		SigningIn[playerid] = false;

		cache_get_value_name_int(0, "sqlid"			, PlayerInfo[playerid][pSQLID]);
		cache_get_value_name(0, 	"password"		, PlayerInfo[playerid][pPassword]		, BCRYPT_HASH_LENGTH);
		cache_get_value_name(0, 	"teampin"		, PlayerInfo[playerid][pTeamPIN]		, BCRYPT_HASH_LENGTH);
		cache_get_value_name(0, 	"lastlogin"		, PlayerInfo[playerid][pLastLogin]		, 24);
		cache_get_value_name_int(0, "lastloginstamp", PlayerInfo[playerid][pLastLoginTimestamp]);
		cache_get_value_name_int(0, "spawnchange"	, PlayerInfo[playerid][pSpawnChange]);
		cache_get_value_name_int(0, "secquestion"	, PlayerInfo[playerid][pSecQuestion]);
		cache_get_value_name(0, 	"secawnser"		, PlayerInfo[playerid][pSecQuestAnswer]	, 31);
		cache_get_value_name(0, 	"forumname"		, PlayerInfo[playerid][pForumName]		, 24);
		cache_get_value_name(0, 	"email"			, PlayerInfo[playerid][pEmail]			, MAX_PLAYER_MAIL);
		cache_get_value_name(0, 	"SAMPid"		, PlayerInfo[playerid][pSAMPid]			, 128);
		cache_get_value_name(0, 	"lastupdatever"	, PlayerInfo[playerid][pLastUpdateVer]	, 32);
		cache_get_value_name_int(0, "registered"	, PlayerInfo[playerid][pRegistered]);
		cache_get_value_name_int(0, "adminLvl"		, PlayerInfo[playerid][pTempRank][0]);
		cache_get_value_name_int(0, "helper"		, PlayerInfo[playerid][pTempRank][1]);
		cache_get_value_name_int(0, "playaWarns"	, PlayerInfo[playerid][pWarns]);
		cache_get_value_name_int(0, "levels"		, PlayerInfo[playerid][pLevel]);
		cache_get_value_name_int(0, "connecttime"	, PlayerInfo[playerid][pConnectTime]);
		cache_get_value_name_int(0, "muted"			, PlayerInfo[playerid][pMuted]);
		cache_get_value_name_int(0, "respects"		, PlayerInfo[playerid][pRespects]);
		cache_get_value_name_int(0,  "sex"			, PlayerInfo[playerid][pSex]);
		cache_get_value_name_int(0,  "age"			, PlayerInfo[playerid][pAge]);
		cache_get_value_name_int(0,  "changenames"	, PlayerInfo[playerid][pChangenames]);
		cache_get_value_name_int(0,  "changetimes"	, PlayerInfo[playerid][pChangeTimes]);
		cache_get_value_name_int(0,  "handMoney"	, PlayerInfo[playerid][pMoney]);
		cache_get_value_name_int(0,  "bankMoney"	, PlayerInfo[playerid][pBank]);
		cache_get_value_name_int(0,  "rentkey"		, PlayerKeys[playerid][pRentKey]);
		cache_get_value_name_int(0,	"playaUnbanTime", unban_time);
		cache_get_value_name(0, 	"playaBanReason", ban_reason							, 32);
		cache_get_value_name_int(0,	"voted"			, PlayerInfo[playerid][pVoted]);
		cache_get_value_name_int(0, "FurnPremium"	, PlayerInfo[playerid][pExtraFurniture]); 
		cache_get_value_name_int(0,	"mustread"		, PlayerInfo[playerid][pMustRead]);
				
		if(unban_time == -1)
		{
			va_SendClientMessage( playerid, COLOR_RED, 
				"[%s]: You have been banned for life on this server!\n\
					If you think your ban was unfair/a mistake, please post an unban request on\n\
					\n%s",
				SERVER_NAME,
				WEB_URL
			);
			BanMessage(playerid);
			return 1;
		}
		else if(unban_time == -2) 
		{
			va_SendClientMessage( playerid, COLOR_RED, 
				"[%s]: Your user account has been blocked by the system!\n\
					You must create it on User Control Panel (%s) in order for it to be playable!",
				SERVER_NAME,
				WEB_URL
			);
			KickMessage(playerid);
			return 1;
		}
		else if(unban_time == -3)
		{
		    va_SendClientMessage( playerid, COLOR_RED, 
				"[%s]: Your account has been locked by security system!",
				SERVER_NAME
			);
		    va_SendClientMessage( playerid, COLOR_RED,
				"[%s]: Please post an unban request on our pages! (%s)",
				SERVER_NAME,
				WEB_URL
			);
		    KickMessage(playerid);
		    return 1;
		}

		if(unban_time < gettimestamp()) 
		{
			mysql_fquery(SQL_Handle(), "UPDATE accounts SET playaUnbanTime = '0' WHERE sqlid = '%d'", 
				PlayerInfo[playerid][pSQLID]
			);
		} 
		else 
		{
			new 
				date[12], 
				time[12];
			TimeFormat(Timestamp:unban_time, HUMAN_DATE, date);
			TimeFormat(Timestamp:unban_time, ISO6801_TIME, time);
	
			va_SendClientMessage(playerid, COLOR_LIGHTRED, 
				"[%s]: Your ban expires on date: "COL_SERVER"%s %s.", 
				SERVER_NAME,
				date, 
				time
			);
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "Ban reason: %s", ban_reason);

			KickMessage(playerid);
			return 1;
		}

		LoadPlayerStats(playerid); // // Loading data non-related to 'accounts' database table.
		
		PlayerKeys[playerid][pHouseKey] = GetHouseFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pBizzKey] = GetBizzFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pGarageKey] = GetGarageFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pIllegalGarageKey] = GetIllegalGarageFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pComplexKey] = GetComplexFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pComplexRoomKey] = GetComplexRoomFromSQL(PlayerInfo[playerid][pSQLID]);
		PlayerKeys[playerid][pVehicleKey] = GetPlayerPrivateVehicle(playerid);
		
		Bit1_Set( gr_PlayerLoggingIn, playerid, true);
  		SetPlayerSpawnInfo(playerid);

        if(!isnull(PlayerInfo[playerid][pSAMPid]) && PlayerInfo[playerid][pSecQuestion] != 1 
			&& !isnull(PlayerInfo[playerid][pSecQuestAnswer]))
        {
            new
                n_gpci[128];
            gpci(playerid, n_gpci, 128);
            if(strcmp(n_gpci, PlayerInfo[playerid][pSAMPid])) 
			{
                Player_SetSecurityBreach(playerid, true);
                
				va_SendClientMessage(playerid, 
					COLOR_RED, 
					"[%s]: Semms to be you are using unknown computer to log in to our server! \n\
						Please input security answer to continue.",
					SERVER_NAME
				);

                va_ShowPlayerDialog(playerid, 
					DIALOG_SEC_SAMPID, 
					DIALOG_STYLE_PASSWORD, 
					""COL_RED"SECURITY BREACH", 
					""COL_WHITE"Please answer your security question to continue:\n%s", 
					"Answer", 
					"Abort", 
					secQuestions[PlayerInfo[playerid][pSecQuestion]]
				);
                return 1;
            }
        }

        Bit1_Set(gr_PlayerLoggedIn, playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Please wait for 5 seconds. Loading in progres...");
		defer FinishPlayerSpawn(playerid);
    }
    return 1;
}

static RegisterPlayer(playerid)
{
	strcpy(PlayerInfo[playerid][pLastLogin], ReturnDate());
	
	inline OnAccountFinish()
	{	
		PlayerInfo[playerid][pSQLID] 			= cache_insert_id();
		PlayerInfo[playerid][pRegistered] 		= 0;
		PlayerInfo[playerid][pLevel] 			= 1;
		PlayerAppearance[playerid][pSkin] 		= 29;
		PaydayInfo[playerid][pPayDayMoney] 		= 0;
		PaydayInfo[playerid][pProfit]			= 0;
		PlayerJob[playerid][pFreeWorks] 		= 15;
		PlayerInfo[playerid][pMuted] 			= true;
		PlayerInfo[playerid][pAdmin] 			= 0;
		PlayerInfo[playerid][pHelper] 			= 0; 
		PlayerCoolDown[playerid][pCasinoCool]	= 5;
		PlayerCoolDown[playerid][pCasinoCool]	= 5;

		PlayerKeys[playerid][pHouseKey]			= INVALID_HOUSE_ID;
		PlayerKeys[playerid][pRentKey]			= INVALID_HOUSE_ID;
		PlayerKeys[playerid][pBizzKey]			= INVALID_BIZNIS_ID;
		PlayerKeys[playerid][pComplexRoomKey]	= INVALID_COMPLEX_ID;
		PlayerKeys[playerid][pComplexKey]		= INVALID_COMPLEX_ID;
		PlayerKeys[playerid][pVehicleKey]		= -1;
		
		UpdateRegisteredPassword(playerid);
		FirstSaving[playerid] = true; 
		SavePlayerData(playerid);
		
		TogglePlayerSpectating(playerid, 0);
		SetCameraBehindPlayer(playerid);
		SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
		
		PlayerNewUser_Set(playerid,true);
		Bit1_Set(gr_PlayerLoggedIn, playerid, true);
		
		DestroyLoginTextdraws(playerid);
		CreateWebTD(playerid);
		
		SpawnPlayer(playerid);
		return 1;
	}
    MySQL_TQueryInline(SQL_Handle(),
		using inline OnAccountFinish,
		va_fquery(SQL_Handle(), 
			"INSERT INTO \n\
				accounts \n\
			(online, registered, register_date, name, password, teampin, email,\n\
				secawnser, levels, age, sex, handMoney, bankMoney) \n\
			VALUES \n\
				('1', '0', '%e', '%e', '%e', '', '%e', '', '%d', '%d', '%d', '%d', '%d')",
			PlayerInfo[playerid][pLastLogin],
			GetName(playerid, false),
			PlayerInfo[playerid][pPassword],
			PlayerInfo[playerid][pEmail],
			1,
			PlayerInfo[playerid][pAge],
			PlayerInfo[playerid][pSex],
			NEW_PLAYER_MONEY,
			NEW_PLAYER_BANK
		), 
		"i", 
		playerid
	);
	return 1;
}

SetPlayerOnlineStatus(playerid, status)
{
	mysql_fquery(SQL_Handle(), 
		"UPDATE accounts set online = '%d' WHERE sqlid = '%d'", 
		status,
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock IsEMailInDB(const email[])
{
	new 
		Cache:result,
		counts;
	
	result = mysql_query(SQL_Handle(), va_fquery(SQL_Handle(), "SELECT sqlid FROM accounts WHERE email = '%e'", email));
	counts = cache_num_rows();
	cache_delete(result);
	return counts;
}

Public: SafeSpawnPlayer(playerid)
{
	new currentday, day;
	TimeFormat(Timestamp:gettimestamp(), DAY_OF_MONTH, "%d", currentday);
	TimeFormat(Timestamp:ExpInfo[playerid][eLastPayDayStamp], DAY_OF_MONTH, "%d", day);
	
	if(currentday != day)
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 0;
	}

	SetPlayerAFKLimit(playerid);

	#if defined MODULE_LOGS
	Log_Write("/logfiles/connects.txt", "(%s) %s(%s) sucessfully connected on the server.",
		ReturnDate(),
		GetName(playerid, false),
		ReturnPlayerIP(playerid)
	);
	#endif
	
	Player_SetSecurityBreach(playerid, false);
	
	mysql_fquery(SQL_Handle(),
		"INSERT INTO player_connects(player_id, time, aip) VALUES ('%d','%d','%e')",
		PlayerInfo[playerid][pSQLID],
		gettimestamp(),
		ReturnPlayerIP(playerid)
	);
	
	
	if(PlayerJob[playerid][pJob] == JOB_JACKER 
		&& (!PlayerFaction[playerid][pMember] && !PlayerFaction[playerid][pLeader]))
		PlayerJob[playerid][pJob] = 0;

	if(!PlayerInfo[playerid][pRegistered])
		PlayerNewUser_Set(playerid, true);
		
	if(PlayerVIP[playerid][pDonateTime] < gettimestamp() && PlayerVIP[playerid][pDonateRank] > 0) 
	{
		va_SendClientMessage( playerid, COLOR_ORANGE, 
			"[%s]: Your InGame Premium VIP status has expired. Please donate again if you want to extend it!",
			SERVER_NAME
		);
		
		PlayerVIP[playerid][pDonateTime] = 0;
		PlayerVIP[playerid][pDonateRank] = 0;
		if(PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdateBizzFurnitureSlots(playerid);
		if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(playerid, -1, PlayerKeys[playerid][pHouseKey]);
		SavePlayerVIP(playerid);
	}

	if(isnull(PlayerInfo[playerid][pSecQuestAnswer]) && isnull(PlayerInfo[playerid][pEmail]))
	{
		SendClientMessage(playerid, COLOR_RED, 
			"[!]: Your account is unprotected. Please setup your e-mail and security question & answer! (/account)");
		va_SendClientMessage(playerid, COLOR_RED, 
			"[!]: If you don't fill up your e-mail and security question & answer, \n\
				%s won't be responsible for your account loss.",
			SERVER_NAME
		);
	}
	else if(PlayerInfo[playerid][pSecQuestion] == 1 && isnull(PlayerInfo[playerid][pSecQuestAnswer]))
	{
		SendClientMessage(playerid, COLOR_RED, "[!]: Please setup your security question and answer! (/account)");
		gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
	}
	else if(isnull(PlayerInfo[playerid][pSAMPid]))
	{
		SendClientMessage(playerid, COLOR_RED, 
			"[!]: Next time you login from different computer, the server will require answer to safety question!");
		gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
	}

	defer SafeHealPlayer(playerid);
	FinalPlayerCheck(playerid); // Crash, Private Vehicle, Mask, Interiors and Inactivity Check 

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, playerid);
	Bit1_Set(gr_PlayerLoggedIn, playerid, true);
	Bit1_Set(gr_PlayerLoggingIn, playerid, false);
	TogglePlayerSpectating(playerid, 0);
	SetCameraBehindPlayer(playerid);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	TogglePlayerControllable(playerid, false);
	StopAudioStreamForPlayer(playerid);
	
	va_SendClientMessage(playerid, COLOR_LIGHTBLUE, 
		"[%s]: "COL_WHITE"Welcome back, "COL_LIGHTBLUE"%s"COL_WHITE"!", 
		SERVER_NAME,
		GetName(playerid)
	);
	return 1;
}

SavePlayerData(playerid)
{
	// When newly registered player isn't safely spawned, FirstSaving it is.
    if(!SafeSpawned[playerid] && !FirstSaving[playerid])	
		return 1;

	mysql_pquery(SQL_Handle(), "START TRANSACTION");

	mysql_fquery(SQL_Handle(), 
		"UPDATE accounts SET lastlogin = '%e', lastloginstamp = '%d', lastip = '%e', forumname = '%e', \n\
			lastupdatever = '%e', registered = '%d', playaWarns = '%d', levels = '%d', connecttime = '%d', \n\
			muted = '%d', respects = '%d', changenames = '%d', changetimes = '%d', \n\
			mustread = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pLastLogin],
		PlayerInfo[playerid][pLastLoginTimestamp],
		PlayerInfo[playerid][pIP],
		PlayerInfo[playerid][pForumName],
		PlayerInfo[playerid][pLastUpdateVer],
		PlayerInfo[playerid][pRegistered],
		PlayerInfo[playerid][pWarns],
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pConnectTime],
		PlayerInfo[playerid][pMuted],
		PlayerInfo[playerid][pRespects],
		PlayerInfo[playerid][pChangenames],
		PlayerInfo[playerid][pChangeTimes],
		PlayerInfo[playerid][pMustRead],
		PlayerInfo[playerid][pSQLID]
	);

	SavePlayerStats(playerid); // Saving data non-related to 'accounts' table.

	mysql_pquery(SQL_Handle(), "COMMIT");
	FirstSaving[playerid] = false;
	return 1;
}

#include <YSI_Coding\y_hooks>
hook function ResetPlayerVariables(playerid)
{
	PlayerInfo[playerid][pForumName] 		= EOS;
	PlayerInfo[playerid][pLastLogin] 		= EOS;
	PlayerInfo[playerid][pSAMPid] 			= EOS;
	PlayerInfo[playerid][pEmail][0] 		= EOS;
	PlayerInfo[playerid][pIP][0] = EOS;

	PlayerInfo[playerid][pSecQuestAnswer][0]= EOS;
	PlayerInfo[playerid][pLastUpdateVer] 	= EOS;

	PlayerInfo[playerid][pSQLID] 			= 0; 	
	PlayerInfo[playerid][pLastLoginTimestamp] = 0;
	PlayerInfo[playerid][pRegistered] 		= 0;
	PlayerInfo[playerid][pSecQuestion] 		= -1;
	PlayerInfo[playerid][pBanned]			= 0;
	PlayerInfo[playerid][pWarns]			= 0;
	PlayerInfo[playerid][pLevel]			= 0;
	PlayerInfo[playerid][pAdmin]			= 0;
	PlayerInfo[playerid][pTempRank][0]		= 0;
	PlayerInfo[playerid][pTempRank][1]		= 0;
	PlayerInfo[playerid][pHelper]			= 0;
	PlayerInfo[playerid][pConnectTime]		= 0;
	PlayerInfo[playerid][pMuted]			= false;
	PlayerInfo[playerid][pRespects]			= 0;
	PlayerInfo[playerid][pSex]				= 0;
	PlayerInfo[playerid][pAge]				= 0;
	PlayerInfo[playerid][pChangenames]		= 0;
	PlayerInfo[playerid][pChangeTimes]		= 0;
	PlayerInfo[playerid][pMoney]			= 0;
	PlayerInfo[playerid][pBank]				= 0;
	PlayerInfo[playerid][pVoted]	 		= false;
	PlayerInfo[playerid][pMustRead]			= false;	
	
	PlayerKeys[playerid][pHouseKey]			= INVALID_HOUSE_ID;
	PlayerKeys[playerid][pRentKey]			= INVALID_HOUSE_ID;
	PlayerKeys[playerid][pBizzKey]			= INVALID_BIZNIS_ID;
	PlayerKeys[playerid][pComplexKey]		= INVALID_COMPLEX_ID;
	PlayerKeys[playerid][pComplexRoomKey]	= INVALID_COMPLEX_ID;
	PlayerKeys[playerid][pGarageKey]		= -1;
	PlayerKeys[playerid][pIllegalGarageKey]	= -1;
	PlayerKeys[playerid][pVehicleKey]		= -1;
	PlayerKeys[playerid][pWarehouseKey] 	= -1;
	
	return continue(playerid);
}

RandomPlayerCameraView(playerid)
{
	new 
		camview = random(3);
	SetPlayerVirtualWorld(playerid, random(9999));
 	switch(camview)
  	{
  		case 0:
  		{
  		    SetPlayerPos(playerid, 1148.4430,-1344.8217,13.6616);
  		    InterpolateCameraPos(playerid, 927.724792, -1286.564941, 51.656623, 1397.496093, -1415.905517, 32.533592, 30000);
			InterpolateCameraLookAt(playerid, 932.431823, -1288.218383, 51.324836, 1392.709960, -1414.556640, 32.011108, 30000);
       	}
       	case 1:
  		{
  		    SetPlayerPos(playerid, 2275.1340,-1700.6871,13.6479);
  		    InterpolateCameraPos(playerid, 2042.767822, -1470.297851, 54.489799, 2546.400146, -1771.930541, 41.233219, 30000);
			InterpolateCameraLookAt(playerid, 2047.054321, -1472.868164, 54.349193, 2542.777832, -1768.697875, 40.037876, 30000);
       	}
       	case 2:
  		{
  		    SetPlayerPos(playerid, 2411.5686,-1106.1973,40.1652);
  		    InterpolateCameraPos(playerid, 2515.796142, -1008.902709, 88.511833, 2062.358886, -1379.888061, 46.693622, 30000);
			InterpolateCameraLookAt(playerid, 2511.572509, -1011.466735, 87.745338, 2063.165771, -1375.001464, 46.008289, 30000);
       	}
    }
	return 1;
}

SetPlayerSpawnInfo(playerid)
{
	if(PlayerJail[playerid][pJailed] == 2)
	{
		SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], -10.9639, 2329.3030, 24.4, 0, 0, 0, 0, 0, 0, 0);
		Streamer_UpdateEx(playerid,  -10.9639, 2329.3030, 24.4);
	}
	else if(PlayerJail[playerid][pJailed] == 3)
	{
		SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin],  1199.1404,1305.8285,-54.7172, 0, 0, 0, 0, 0, 0, 0);
		SetPlayerInterior(playerid, 17);
		Streamer_UpdateEx(playerid,  1199.1404,1305.8285,-54.7172);
	}
	else if(PlayerDeath[playerid][pKilled] == 1) 
	{
		SetSpawnInfo(playerid, 0, 
			PlayerAppearance[playerid][pSkin],
			PlayerDeath[playerid][pDeathX] , 
			PlayerDeath[playerid][pDeathY] , 
			PlayerDeath[playerid][pDeathZ] , 
			0, 0, 0, 0, 0, 0, 0
		);
		Streamer_UpdateEx(playerid, 
			PlayerDeath[playerid][pDeathX] , 
			PlayerDeath[playerid][pDeathY] , 
			PlayerDeath[playerid][pDeathZ] 
		);
	}
	else
	{
		switch(PlayerInfo[playerid][pSpawnChange]) 
		{
			case 0: 
			{
				SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
			}
			case 1:
			{
				if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID 
					|| PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID)
				{
					new house;
					if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
					{
						house = PlayerKeys[playerid][pHouseKey];
						if(!HouseInfo[house][hFurLoaded])
							ReloadHouseFurniture(house);
						ReloadHouseExterior(house);
					}
					else if(PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID)
					{
						house = PlayerKeys[playerid][pRentKey];
						if(!HouseInfo[house][hFurLoaded])
							ReloadHouseFurniture(house);
						ReloadHouseExterior(house);
					}
					SetSpawnInfo(playerid, 0, 
						PlayerAppearance[playerid][pSkin], 
						HouseInfo[house][hEnterX], 
						HouseInfo[house][hEnterY], 
						HouseInfo[house][hEnterZ], 
						0, 0, 0, 0, 0, 0, 0
					);
					Streamer_UpdateEx(playerid,
						HouseInfo[house][hEnterX], 
						HouseInfo[house][hEnterY], 
						HouseInfo[house][hEnterZ], 
						HouseInfo[house][hVirtualWorld], 
						HouseInfo[house][hInt]
					);
				}
				else
				{
					SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
				}
			}
			case 2:
			{
				switch(PlayerFaction[playerid][pMember])
				{
					case 1:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 1543.1218,-1675.8065,13.5558, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1543.1218,-1675.8065,13.5558);
					}
					case 2:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 1179.1440, -1324.0720, 13.9063, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1179.1440, -1324.0720, 13.9063); 
					}
					case 3:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 635.5733,-572.5349,16.3359, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 635.5733,-572.5349,16.3359);
					}
					case 4:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 1481.0284,-1766.5795,18.7958, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1481.0284,-1766.5795,18.7958);
					}
					case 5:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 1415.0668,-1177.3187,25.9922, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, 1466.6505,-1172.4191,23.8956);
					}
					default:
					{
						SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
						Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
					}
				}
			} 
			case 3:
			{
				if(PlayerKeys[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
				{
					new complex = PlayerKeys[playerid][pComplexRoomKey];
					SetSpawnInfo(playerid, 0, 
						PlayerAppearance[playerid][pSkin], 
						ComplexRoomInfo[complex][cExitX], 
						ComplexRoomInfo[complex][cExitY], 
						ComplexRoomInfo[complex][cExitZ], 
						0, 0, 0, 0, 0, 0, 0
					);
					Streamer_UpdateEx(playerid, 
						ComplexRoomInfo[complex][cExitX], 
						ComplexRoomInfo[complex][cExitY], 
						ComplexRoomInfo[complex][cExitZ], 
						ComplexRoomInfo[complex][cViwo], 
						ComplexRoomInfo[complex][cInt]
					);
				}
				else
				{
					SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
					Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
				}
			}
			
			case 4:
			{
				SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 738.8747,-1415.2773,13.5168, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, 738.8747,-1415.2773,13.5168);
			}
			case 5:
			{
				SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], 2139.9543,-2167.1189,13.5469, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, 2139.9543,-2167.1189,13.5469);
			}
			default:
			{
				SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
				Streamer_UpdateEx(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
			}
		}
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

hook OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, COLOR_PLAYER);
	return 1;
}

//#include <YSI_Coding\y_hooks>
hook OnPlayerDisconnect(playerid, reason)
{
	if(SigningIn[playerid])
		stop LoginCheckTimer[playerid];

	SigningIn[playerid] = false;
	FirstSaving[playerid] = false;

	Player_SetSecurityBreach(playerid, false);
	SetPlayerOnlineStatus(playerid, 0);

	if(IsPlayerLogging(playerid))
		stop FinishPlayerSpawn(playerid);

	strcpy(PlayerInfo[playerid][pLastLogin], ReturnDate());
	PlayerInfo[playerid][pLastLoginTimestamp] = gettimestamp();

	RemovePlayerFromVehicle(playerid);

	new
		szString[73],
		szDisconnectReason[3][] = 
		{
			"Timeout/Crash",
			"Quit",
			"Kick/Ban"
		};

	if(!IsPlayerReconing(playerid) && GMX == 0) 
	{
		format( szString, sizeof szString, "(( %s[%d] just left the server. (%s) ))",
			GetName(playerid, false),
			playerid,
			szDisconnectReason[reason]
		);
		ProxDetector(10.0, playerid, szString, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}

	CheckPlayerCrash(playerid, reason);

	// Main Player Data Save Func.
	SavePlayerData(playerid);
	
	// Player Sets
	if(GMX == 1) 
	{
		SendClientMessage(playerid, COLOR_RED, "[!]: Your data has been saved. Server has automatically kicked you out.");
		KickMessage(playerid);
	}
	defer SafeResetPlayerVariables(playerid);
	return 1;
}

hook OnPlayerSpawn(playerid)
{	
    StopAudioStreamForPlayer(playerid);
    ResetPlayerMoney(playerid);
    SetCameraBehindPlayer(playerid);
    SetPlayerFightingStyle(playerid, PlayerGym[playerid][pFightStyle]);
	
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

	TogglePlayerAllDynamicRaceCPs(playerid, false);
	TogglePlayerAllDynamicCPs(playerid, true);

	new
		hour, minute;
	GetServerTime(hour, minute, _);
	SetPlayerTime(playerid,hour,minute);

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
			SetPlayerPos(playerid, PlayerDeath[playerid][pDeathX] , PlayerDeath[playerid][pDeathY] , PlayerDeath[playerid][pDeathZ]);
			Streamer_UpdateEx(playerid, PlayerDeath[playerid][pDeathX], PlayerDeath[playerid][pDeathY], PlayerDeath[playerid][pDeathZ], PlayerDeath[playerid][pDeathVW], PlayerDeath[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "** You are returned to position where you were wounded. **");
			va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Player_SetUsingMask(playerid, false);
			if(PlayerInventory[playerid][pMaskID])
			{
				if(PlayerVIP[playerid][pDonateRank] < PREMIUM_BRONZE)
					PlayerInventory[playerid][pMaskID] = 0;
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
			SetPlayerPos(playerid, PlayerDeath[playerid][pDeathX] , PlayerDeath[playerid][pDeathY] , PlayerDeath[playerid][pDeathZ]);
			Streamer_UpdateEx(playerid, PlayerDeath[playerid][pDeathX], PlayerDeath[playerid][pDeathY], PlayerDeath[playerid][pDeathZ], PlayerDeath[playerid][pDeathVW], PlayerDeath[playerid][pDeathInt]);

			SendClientMessage(playerid, COLOR_LIGHTRED, "You are in Death Mode. You have been returned to location of your death.**");
			va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "** You can't use /l chat and /me command. /c, /ame i /do are allowed during RP **");

			Player_SetUsingMask(playerid, false);
			if(PlayerInventory[playerid][pMaskID])
			{
				if(PlayerVIP[playerid][pDonateRank] < PREMIUM_BRONZE)
					PlayerInventory[playerid][pMaskID] = 0;
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
			if(PlayerJail[playerid][pJailed] > 0)
			{
				PutPlayerInJail(playerid, PlayerJail[playerid][pJailTime], PlayerJail[playerid][pJailed]);
				SetPlayerHealth(playerid, 100);
				return 1;
			}
			else 
			{
				if(SafeSpawned[playerid])
					AC_SetPlayerWeapons(playerid);
					
				switch( PlayerInfo[playerid][pSpawnChange])
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
						if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID || PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID) {
							new
								house;
							if( PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
								house = PlayerKeys[playerid][pHouseKey];
							else if(PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID)
								house = PlayerKeys[playerid][pRentKey];

							SetPlayerInterior( playerid, 0);
							SetPlayerVirtualWorld( playerid, 0);

							SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ], 0, 0, true);
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
							new complex = PlayerKeys[playerid][pComplexRoomKey];
							SetPlayerPosEx(playerid, ComplexRoomInfo[complex][cExitX], ComplexRoomInfo[complex][cExitY], ComplexRoomInfo[complex][cExitZ], 0, 0, true);
							SetPlayerInterior( playerid, ComplexRoomInfo[complex][cInt]);
							SetPlayerVirtualWorld( playerid, ComplexRoomInfo[complex][cViwo]);
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
				if(Bit1_Get( gr_PlayerInTrunk, playerid))
				{
					Bit1_Set( gr_PlayerInTrunk, playerid, false);
					VehicleTrunk[playerid] = INVALID_VEHICLE_ID;

					SetPlayerPosEx(playerid, PlayerTrunkPos[playerid][0], PlayerTrunkPos[playerid][1], PlayerTrunkPos[playerid][2], 0, 0, false);
					TogglePlayerControllable( playerid, 1);
					SendClientMessage( playerid, COLOR_RED, "[!]: You exited the trunk.");
					SetPlayerHealth(playerid, 100);
				}
			}
		}
	}
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_LOGIN:
		{
			if(!response) 
				Kick(playerid);

			if(isnull(inputtext))
			{
				format(dialogtext, sizeof(dialogtext), 
					""COL_RED"You have left empty input password field!\n\
						"COL_WHITE"Check your upper/lower case sensitivity and try again.\n\
						You have "COL_LIGHTBLUE"%d "COL_WHITE"attempts to input valid password!\n\n\n\
						"COL_RED"If you exceed max attempt limit, you will be kicked!", 
					MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid)
				);

				ShowPlayerDialog(playerid, 
					DIALOG_LOGIN, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Login", 
					dialogtext, 
					"Proceed", 
					"Abort"
				);
				Bit8_Set(gr_LoginInputs, playerid, Bit8_Get(gr_LoginInputs, playerid) + 1);
				return 1;
			}
			if(!( MAX_LOGIN_TRIES - Bit8_Get(gr_LoginInputs, playerid)))
			{
				//Kick
				va_SendClientMessage(playerid, COLOR_RED, 
					"[%s]: You reached %d unsucessful login attempts and you got an IP ban!",
					SERVER_NAME,
					MAX_LOGIN_TRIES
				);
				BanMessage(playerid);
				return 1;
			}
			new input_password[12];
			strcpy(input_password, inputtext, 12);
			inline PasswordForQuery()
			{
				new sqlid, sql_password[BCRYPT_HASH_LENGTH];

				cache_get_value_name_int(0, "sqlid", sqlid);
				cache_get_value_name(0, "password", sql_password, BCRYPT_HASH_LENGTH);
			
				bcrypt_check(input_password, sql_password,  "OnPasswordChecked", "d", playerid);
				return 1;
			}
			MySQL_TQueryInline(SQL_Handle(), 
				using inline PasswordForQuery,
				va_fquery(SQL_Handle(), "SELECT sqlid, password FROM accounts WHERE name = '%e'", GetName(playerid, false)) 
			);
			return 1;
		}
		case DIALOG_SEC_SAMPID:
		{
		    if(!response)
				return Kick(playerid);

			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "=", true) != -1 || 
				strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || 
				strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || 
				strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || 
				strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || 
				strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1)
				return Kick(playerid);
			
			if(isnull(inputtext))
			    return Kick(playerid);
			    
			if(strlen(inputtext) > 31)
			    return Kick(playerid);
			    
            if(!strcmp(inputtext, PlayerInfo[playerid][pSecQuestAnswer]))
            {
				Player_SetSecurityBreach(playerid, false);

				#if defined MODULE_LOGS
                Log_Write("logfiles/GPCI.txt", 
					"(%s) Player %s[%d]{%d}<%s> logged in with unknown GPCI for his account.", 
					ReturnDate(), 
					GetName(playerid), 
					playerid, 
					PlayerInfo[playerid][pSQLID], 
					ReturnPlayerIP(playerid)
				);
				#endif
				
				new log_gpci[128];
				format(log_gpci, 
					sizeof(log_gpci), 
					"Player %s[%d] logged in with unknown GPCI for his account!", 
					GetName(playerid), 
					playerid
				);
				ABroadCast(COLOR_LIGHTRED, log_gpci, 1);
				gpci(playerid, PlayerInfo[playerid][pSAMPid], 128);
				
				Bit1_Set(gr_PlayerLoggedIn, playerid, true);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Please wait for 5 seconds. Loading in progres...");
				defer FinishPlayerSpawn(playerid);
				return 1;
            }
            else
			{
			    if(-- secquestattempt[playerid] == 0)
			    {
			        ClearPlayerChat(playerid);
			        
			        SendClientMessage(playerid, COLOR_RED, "You account is now locked by security system!");
			        va_SendClientMessage(playerid, COLOR_RED, "Please post an unban request on %s.", WEB_URL);

					#if defined MODULE_BANS
					HOOK_Ban(playerid, INVALID_PLAYER_ID, "Wrong safety answer", -3);
					#endif
					return 1;
				}
				else
				{
				    va_SendClientMessage(playerid, 
						COLOR_RED, 
						"If you don't remember your safety answer, please contact our Developers on %s!",
						WEB_URL
					);

    				va_ShowPlayerDialog(playerid,
						DIALOG_SEC_SAMPID, 
						DIALOG_STYLE_PASSWORD, 
						""COL_RED"SECURITY BREACH", 
						""COL_WHITE"Please answer the safety question if you want to proceed.\n\
							Attempts left: "COL_RED"%d\n\
							\n"COL_WHITE"%s", 
						"Answer", 
						"Abort", 
						secquestattempt[playerid], 
						secQuestions[PlayerInfo[playerid][pSecQuestion]]
					);
				}
			}
			return 1;
		}
		case DIALOG_REGISTER:
		{
			#if defined COA_UCP
				va_SendClientMessage(playerid, COLOR_RED, "You haven't registered your account on %s!", WEB_URL);
				KickMessage(playerid);
			#else
				if(!response) 
					Kick(playerid);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_AGREE, 
					DIALOG_STYLE_MSGBOX, 
					""COL_WHITE"Sign Up - EULA(2/6)", 
					""COL_WHITE"With accepting, you agree that while gaming on our server\n\
						you won't be breaking server rules, exploiting bugs/glitches,\n\
						insult other players, making false pretenses, use malicious software,\n\
						hacks, cheats, or in any other way obstruct pleasant gaming experience\n\
						to other players on this server.\n\
						"COL_RED"CAUTION: "COL_WHITE"Breaking EULA(End User License Agreement)\n\
						will lead to "COL_RED"serious "COL_WHITE"sanctions.\n\
						If you accept our EULA, please klick "COL_LIGHTBLUE"\"Accept\""COL_WHITE"!",
					"I agree", 
					"Abort"
				);
			#endif
		}
		case DIALOG_REG_AGREE:
		{
			if(!response) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Welcome "COL_LIGHTBLUE"%s!\n\n\
						"COL_WHITE"Your account isn't registered on our server.\n\
						If you want to Sign Up, please press \"Register\".\n\
						Otherwise, you'll be kicked out of the server!",GetName(playerid)
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REGISTER, 
					DIALOG_STYLE_MSGBOX, 
					""COL_WHITE"Sign Up (1/6)", 
					dialogtext, 
					"Register", 
					"Abort"
				);
				return 1;
			}

			format(dialogtext, sizeof(dialogtext), 
				""COL_WHITE"Please enter a password for your account.\n\
					Don't share your account password with anyone!\n\
					\nPassword must be "COL_LIGHTBLUE"6-12 "COL_WHITE"characters long."
			);

			ShowPlayerDialog(playerid, 
				DIALOG_REG_PASS, 
				DIALOG_STYLE_PASSWORD, 
				""COL_WHITE"Sign Up - Password(3/6)", 
				dialogtext, 
				"Input", 
				"Abort"
			);
		}
		case DIALOG_REG_PASS:
		{
			if(!response) 
			{
				ShowPlayerDialog(playerid, 
					DIALOG_REG_AGREE, 
					DIALOG_STYLE_MSGBOX, 
					""COL_WHITE"Sign Up - EULA(2/6)", 
					""COL_WHITE"With accepting, you agree that while gaming on our server\n\
						you won't be breaking server rules, exploiting bugs/glitches,\n\
						insult other players, making false pretenses, use malicious software,\n\
						hacks, cheats, or in any other way obstruct pleasant gaming experience\n\
						to other players on this server.\n\
						"COL_RED"CAUTION: "COL_WHITE"Breaking EULA(End User License Agreement)\n\
						will lead to "COL_RED"serious "COL_WHITE"sanctions.\n\
						If you accept our EULA, please klick "COL_LIGHTBLUE"\"Accept\""COL_WHITE"!",
					"Accept", 
					"Decline"
				);
				return 1;
			}
			
			if(isnull(inputtext) || !strlen(inputtext))
			{
				format(dialogtext, sizeof(dialogtext), 
					""COL_WHITE"Please enter a password for your account.\n\
						Don't share your account password with anyone!\n\
						\nPassword must be "COL_LIGHTBLUE"6-12 "COL_WHITE"characters long.\n\
						"COL_RED"\nYour input password field was empty!\""
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_PASS, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Sign Up - Password(3/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || 
				strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || 
				strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || 
				strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || 
				strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || 
				strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || 
				strfind(inputtext, "$", true) != -1)
			{
				format(dialogtext, sizeof(dialogtext), 
					""COL_WHITE"Please enter a password for your account.\n\
						Don't share your account password with anyone!\n\
						\nPassword must be "COL_LIGHTBLUE"6-12 "COL_WHITE"characters long.\n\
						"COL_RED"\nYour input can't contain: "COL_WHITE"%+^|?*#!$>' "COL_RED"in password!\""
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_PASS, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Sign Up - Password(3/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if(6 <= strlen(inputtext) <= 12) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:"
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-Mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				format(PlayerInfo[playerid][pPassword], BCRYPT_HASH_LENGTH, inputtext);
				Bit8_Set(gr_RegisterInputs, playerid, 0);
				return 1;
			}
			if((Bit8_Get(gr_RegisterInputs, playerid)) > 3)
			{
				SendClientMessage(playerid, COLOR_RED, 
					"[!]: You have reached a maximal limit of wrong register inputs. You have been kicked from server.");
				KickMessage(playerid);
				return 1;
			}
			else 
			{
				format(dialogtext, sizeof(dialogtext), 
					""COL_WHITE"Please enter a password for your account.\n\
						Don't share your account password with anyone!\n\
						\nPassword must be "COL_LIGHTBLUE"6-12 "COL_WHITE"characters long."
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_PASS, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Sign Up - Password(3/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
		}
		case DIALOG_REG_MAIL:
		{
			if(!response) 
			{
				format(dialogtext, sizeof(dialogtext), 
					""COL_WHITE"Please enter a password for your account.\n\
						Don't share your account password with anyone!\n\
						\nPassword must be "COL_LIGHTBLUE"6-12 "COL_WHITE"characters long."
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_PASS, 
					DIALOG_STYLE_PASSWORD, 
					""COL_WHITE"Sign Up - Password(3/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				return 1;
			}
			if(!strlen(inputtext) || isnull(inputtext)) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:\n\
						\n"COL_RED"Your input field was empty!"
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-Mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 
				|| strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 
				|| strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 
				|| strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 
				|| strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 
				|| strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 
				|| strfind(inputtext, "$", true) != -1)
			{	
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:\n\
						"COL_RED"\nYour input can't contain: "COL_WHITE"%+^|?*#!$>' "COL_RED"in E-Mail adress!"
				);
				
				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if(!IsValidEMail(inputtext)) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:\n\
						\n"COL_RED"E-Mail adress you entered isn't valid!"
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-Mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if(IsEMailInDB(inputtext)) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:\n\
						\n"COL_RED"E-Mail is already registered in database!"
				);

				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-Mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				Bit8_Set(gr_RegisterInputs, playerid, Bit8_Get(gr_RegisterInputs, playerid) + 1);
				return 1;
			}
			if((Bit8_Get(gr_RegisterInputs, playerid)) > 3)
			{
				SendClientMessage(playerid, COLOR_RED,
					"[!]: You have reach maximal limit of wrong inputs on registration. You have been kicked."
				);
				KickMessage(playerid);
				return 1;
			}
			format(PlayerInfo[playerid][pEmail], MAX_PLAYER_MAIL, "%s", inputtext);
			Bit8_Set(gr_RegisterInputs, playerid, 0);
			ShowPlayerDialog(playerid, 
				DIALOG_REG_SEX, 
				DIALOG_STYLE_LIST, 
				""COL_WHITE"Sign Up - Spol(5/6)", 
				"Male\nFemale", 
				"Input", 
				"Abort"
			);
		}
		case DIALOG_REG_SEX:
		{
			if(!response) 
			{
				format(dialogtext, 
					sizeof(dialogtext), 
					""COL_WHITE"Please enter valid E-Mail for safety\nof your account:"
				);
				ShowPlayerDialog(playerid, 
					DIALOG_REG_MAIL, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - E-Mail(4/6)", 
					dialogtext, 
					"Input", 
					"Abort"
				);
				return 1;
			}
			switch(listitem)
			{
				case 0: PlayerInfo[playerid][pSex] = 1; // Male
				case 1: PlayerInfo[playerid][pSex] = 2; // Female
			}
			ShowPlayerDialog(playerid, 
				DIALOG_REG_AGE, 
				DIALOG_STYLE_INPUT, 
				""COL_WHITE"SIGN UP - Age(6/6)", 
				""COL_WHITE"How old is your character?\n\
				\n"COL_RED"CAUTION:"COL_WHITE"Minimal age is 16, maximal 80!", 
				"Input", 
				"Abort"
			);
		}
		case DIALOG_REG_AGE:
		{
			if(!response) 
			{
				ShowPlayerDialog(playerid, 
					DIALOG_REG_SEX, 
					DIALOG_STYLE_LIST, 
					""COL_WHITE"Sign Up - Sex(5/6)", 
					"Male\nFemale", 
					"Input", 
					"Abort"
				);
				return 1;
			}
			
			if(!strlen(inputtext))
			{
				ShowPlayerDialog(playerid, 
					DIALOG_REG_AGE, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"SIGN UP - Age(6/6)", 
					""COL_WHITE"How old is your character?\n\
					\n"COL_RED"CAUTION:"COL_WHITE"Minimal age is 16, maximal 80!", 
					"Input", 
					"Abort"
				);
				return 1;
			}
			if(strval(inputtext) >= 16 && strval(inputtext) <= 80)
			{
				PlayerInfo[playerid][pAge] = strval(inputtext);
				RegisterPlayer(playerid);
			}
			else 
			{
				ShowPlayerDialog(playerid, 
					DIALOG_REG_AGE, 
					DIALOG_STYLE_INPUT, 
					""COL_WHITE"Sign Up - Age(6/6)", 
					""COL_WHITE"How old is your character?\n\
					\n"COL_RED"CAUTION:"COL_WHITE"Minimal age is 16, maximal 80!", 
					"Input", 
					"Abort"
				);
				return 1;
			}
		}
	}
	return 0;
}