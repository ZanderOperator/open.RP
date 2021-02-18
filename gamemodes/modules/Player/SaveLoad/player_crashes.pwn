
#include <YSI_Coding\y_hooks>

timer SetPlayerCrash[6000](playerid)
{
	if(PlayerDeath[playerid][pKilled] <= 0)
		TogglePlayerControllable(playerid, true);
	
	if(PlayerCrash[playerid][pCrashX] != 0.0 && PlayerCrash[playerid][pCrashInt] != -1)
	{
		if(PlayerJail[playerid][pJailed])
		{
			mysql_fquery(g_SQL, "DELETE FROM player_crashes WHERE id = '%d'", PlayerCrash[playerid][pCrashId]);
			ResetPlayerCrash(playerid);
			SafeSpawned[playerid] = true;
			return 1;
		}
		//Sets
		SetPlayerPosEx(playerid,  
			PlayerCrash[playerid][pCrashX], 
			PlayerCrash[playerid][pCrashY], 
			PlayerCrash[playerid][pCrashZ], 
			PlayerCrash[playerid][pCrashVW], 
			PlayerCrash[playerid][pCrashInt], 
			true
		);

		SetPlayerSkin(playerid, PlayerAppearance[playerid][pTmpSkin]);
		SetPlayerArmour(playerid, PlayerCrash[playerid][pCrashArmour]);

		if(0.0 <= PlayerCrash[playerid][pCrashHealth] <= 6.0)
			SetPlayerHealth(playerid, 100);
		else
			SetPlayerHealth(playerid, PlayerCrash[playerid][pCrashHealth]);

		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vraceni na prijasnju poziciju.");
		mysql_fquery(g_SQL, "DELETE FROM player_crashes WHERE id = '%d'", PlayerCrash[playerid][pCrashId]);
		ResetPlayerCrash(playerid);
	}
	if(PlayerInfo[playerid][pMustRead] == true)
	{
		GetPlayerPreviousInfo(playerid);
		LearnPlayer(playerid, 1);
	}
	if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && !isnull(PlayerAdminMessage[playerid][pAdminMsg]) && !PlayerAdminMessage[playerid][pAdmMsgConfirm])
	{
		va_SendClientMessage(playerid, 
			COLOR_LIGHTBLUE, 
			"[%s]: "COL_WHITE"Server je updatean na verziju "COL_LIGHTBLUE"%s"COL_WHITE", \n\
				za vise informacija - /update.", 
			SERVER_NAME,
			SCRIPT_VERSION
		);
		ShowAdminMessage(playerid);
	}
	else if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0 && (PlayerAdminMessage[playerid][pAdmMsgConfirm] || isnull(PlayerAdminMessage[playerid][pAdminMsg])))
	{
		if(strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) != 0)
			Player_SetReward(playerid, true);
		ShowPlayerUpdateList(playerid);
	}
	else if(!isnull(PlayerAdminMessage[playerid][pAdminMsg])
		 && !PlayerAdminMessage[playerid][pAdmMsgConfirm] 
		 && strcmp(PlayerInfo[playerid][pLastUpdateVer], SCRIPT_VERSION, true) == 0
		)
	{
		ShowAdminMessage(playerid);
	}
	SafeSpawned[playerid] = true;

	AC_SetPlayerWeapons(playerid);

	CheckPlayerInteriors(playerid);
	CheckPlayerInactivity(playerid);
	CheckPlayerMasks(playerid);

	SetPlayerOnlineStatus(playerid, 1);
	return 1;
}

FinalPlayerCheck(playerid)
{
    defer SetPlayerCrash(playerid);
    return 1;
}

static LoadPlayerCrashes(playerid)
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
	
	cache_get_value_name_int(0,			"id"		, PlayerCrash[playerid][pCrashId]);
	cache_get_value_name_float(0,		"pos_x"		, PlayerCrash[playerid][pCrashX]);
	cache_get_value_name_float(0,		"pos_y"		, PlayerCrash[playerid][pCrashY]);
	cache_get_value_name_float(0,		"pos_z"		, PlayerCrash[playerid][pCrashZ]);
	cache_get_value_name_int(0, 		"interior"	, PlayerCrash[playerid][pCrashInt]);
	cache_get_value_name_int(0, 		"viwo"		, PlayerCrash[playerid][pCrashVW]);
	cache_get_value_name_int(0, 		"skin"		, PlayerAppearance[playerid][pTmpSkin]);
	cache_get_value_name_float(0,		"armor"		, PlayerCrash[playerid][pCrashArmour]);
	cache_get_value_name_float(0,		"health"	, PlayerCrash[playerid][pCrashHealth]);
	return 1;
}

CheckPlayerCrash(playerid, reason)
{
    if((reason == 0 || reason == 2) && IsPlayerAlive(playerid) && GMX == 0)
	{
		if(SafeSpawned[playerid])
		{
			new
				Float:health,
				Float:armor;

			GetPlayerHealth(playerid, health);
			PlayerCrash[playerid][pCrashHealth] 	= health;
			GetPlayerArmour(playerid, armor);
			PlayerCrash[playerid][pCrashArmour] 	= armor;

			PlayerCrash[playerid][pCrashVW] 	= GetPlayerVirtualWorld(playerid);
			PlayerCrash[playerid][pCrashInt] = GetPlayerInterior(playerid);
			PlayerAppearance[playerid][pTmpSkin] = GetPlayerSkin(playerid);

			GetPlayerPos(playerid, 
                PlayerCrash[playerid][pCrashX], 
                PlayerCrash[playerid][pCrashY], 
                PlayerCrash[playerid][pCrashZ]
           );

			mysql_fquery_ex(g_SQL, "INSERT INTO player_crashes(player_id,pos_x,pos_y,pos_z,\n\
                interior,viwo,armor,health,skin,time) \n\
                VALUES ('%d','%.2f','%.2f','%.2f','%d','%d','%f','%f','%d','%d')",
				PlayerInfo[playerid][pSQLID],
				PlayerCrash[playerid][pCrashX],
				PlayerCrash[playerid][pCrashY],
				PlayerCrash[playerid][pCrashZ],
				PlayerCrash[playerid][pCrashInt],
				PlayerCrash[playerid][pCrashVW],
				PlayerCrash[playerid][pCrashArmour],
				PlayerCrash[playerid][pCrashHealth],
				PlayerAppearance[playerid][pTmpSkin],
				gettimestamp()
			);
			if(reason == 0)
			{
				new	tmpString[73];
				format(tmpString, sizeof(tmpString), 
                    "AdmWarn: Player %s just had a Client Crash.",
                    GetName(playerid,false)
               );
				ABroadCast(COLOR_LIGHTRED,tmpString,1);
			}
		}
	}
    return 1;
}

ResetPlayerCrash(playerid)
{
    PlayerCrash[playerid][pCrashId] = -1;
    PlayerCrash[playerid][pCrashArmour]	= 0.0;
    PlayerCrash[playerid][pCrashHealth]	= 0.0;
    PlayerCrash[playerid][pCrashVW]	= -1;
    PlayerCrash[playerid][pCrashInt] = -1;
    PlayerCrash[playerid][pCrashX] = 0.0;
    PlayerCrash[playerid][pCrashY] = 0.0;
    PlayerCrash[playerid][pCrashZ] = 0.0;
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerCrashes(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    ResetPlayerCrash(playerid);
	return continue(playerid);
}