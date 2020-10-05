#include <YSI\y_hooks>

#if defined MODULE_BANS
	#endinput
#endif
#define MODULE_BANS

/*
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
*/
///////////////////////////////////////////////////////////////////
#define MIN_REASON_LEN			(1)
#define MAX_REASON_LEN			(22)

/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/
///////////////////////////////////////////////////////////////////
stock HOOK_Ban(playerid, adminid, const reason[], days=-1, bool:anticheat=false)
{
	#pragma unused anticheat
	new
		forumname[ MAX_PLAYER_NAME ],
		banString[ 128 ];

	if( adminid == INVALID_PLAYER_ID ) 
	{
		if(days != -3)
		{
			format( banString, 128, "AdmCMD: %s is banned by Anti-Cheat. Reason: %s",
				GetName( playerid, false ),
				reason
			);
			format( forumname, MAX_PLAYER_NAME, "Anti-Cheat");
		}
		else
		{
		    format( banString, 128, "AdmCMD: Account %s je is automatically locked by the server. Reason: %s",
				GetName( playerid, false ),
				reason
			);
			format( forumname, MAX_PLAYER_NAME, "AutoServerLock");
		}
	}
	else if( adminid != INVALID_PLAYER_ID ) 
	{
		if( strlen(reason) > MAX_REASON_LEN || strlen(reason) < MIN_REASON_LEN ) 
		{
			SendFormatMessage(adminid, MESSAGE_TYPE_ERROR, "Invalid reason input (%d[min]-%d[max] chars required).", MIN_REASON_LEN, MAX_REASON_LEN);
			return 1;
		}
		format( banString, 128, "AdmCMD: %s is banned by Game Admin %s(%s). Reason: %s",
			GetName( playerid, false ),
			PlayerInfo[adminid][pForumName],
			GetName( adminid, false),
			reason
		);
	}
	SendClientMessageToAll( COLOR_RED, banString );

	new
		unban_time;

	if( days == -1 )
		unban_time = -1;
	else if( days == -3)
	    unban_time = -3;
	else {
		unban_time = days * 86400; //86400 je jedan dan u timestampu
		unban_time += gettimestamp();
	}
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);

	PlayerInfo[playerid][pUnbanTime] = unban_time;
	format( PlayerInfo[ playerid ][ pBanReason ], 32, reason );

	new accUpdtQuery[200];
	mysql_format( g_SQL, accUpdtQuery, 200, "UPDATE `accounts` SET `playaUnbanTime` = '%d', `playaBanReason` = '%e' WHERE `sqlid` = '%d'",
		PlayerInfo[ playerid ][ pUnbanTime ],
		reason,
		PlayerInfo[ playerid ][ pSQLID ]
	);
	mysql_tquery(g_SQL, accUpdtQuery);

	new banInsertQuery[256];
	mysql_format( g_SQL, banInsertQuery, 256, "INSERT INTO `bans` (`id_igraca`, `name`, `player_ip`, `forumname`, `reason`, `date`, `unban`) VALUES ('%d', '%e', '%e', '%e', '%e', '%e', '%d')",
		PlayerInfo[playerid][pSQLID],
		GetName( playerid, false ),
		GetPlayerIP( playerid ),
		PlayerInfo[playerid][pForumName],
		reason,
		date,
		unban_time
	);
	mysql_tquery( g_SQL, banInsertQuery, "", "" );

    ExpInfo[playerid][ePoints] = 0;
	ExpInfo[playerid][eAllPoints] = 0;

	PlayerInfo[playerid][pBanned] 	= 1;
	BanMessage( playerid );
	return 1;
}

stock HOOK_BanEx(playerid, const playername[], const playerip[], adminid, const reason[], days=-1)
{
	if( strlen(reason) > MAX_REASON_LEN || strlen(reason) < MIN_REASON_LEN ) 
	{
		SendFormatMessage(adminid, MESSAGE_TYPE_ERROR, "Invalid reason input (%d[min]-%d[max] chars required).", MIN_REASON_LEN, MAX_REASON_LEN);
		return 1;
	}
	va_SendClientMessageToAll( COLOR_RED,"AdmCMD: %s is banned by Game Admin %s(%s). Reason: %s",
		GetName( playerid, false ),
		PlayerInfo[adminid][pForumName],
		GetName( adminid, false),
		reason
	);

	new
		unban_time;

	if( days == -1 )
		unban_time = -1;
	else {
		unban_time = days * 60 * 60 * 24;
		unban_time += gettimestamp();
	}
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);

	new sqlid, banexQuery[128];
	mysql_format( g_SQL, banexQuery, sizeof(banexQuery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", playername);

	new
		Cache:result = mysql_query(g_SQL, banexQuery);
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);

	new accUpdtQuery[200];
	mysql_format(g_SQL, accUpdtQuery, 200, "UPDATE `accounts` SET `playaUnbanTime` = '%d', `playaBanReason` = '%e' WHERE `name` = '%e'",
		unban_time,
		reason,
		playername
	);
	mysql_tquery(g_SQL, accUpdtQuery);

	new banInsertQuery[256];
	mysql_format( g_SQL, banInsertQuery, 256, "INSERT INTO `bans` (`id_igraca`, `name`, `player_ip`, `forumname`, `reason`, `date`, `unban`) VALUES ('%d', '%e', '%e', '%e', '%e', '%e', '%d')",
		sqlid,
		playername,
		playerip,
		PlayerInfo[playerid][pForumName],
		reason,
		date,
		unban_time
	);
	mysql_tquery( g_SQL, banInsertQuery);
	return 1;
}

stock UnbanPlayerName(const playername[], adminid)
{
	new unbanQuery[135];
	mysql_format(g_SQL, unbanQuery, 135, "UPDATE `accounts` SET `playaUnbanTime` = '0', `playaBanReason` = '' WHERE `name` = '%e'",
		playername
	);
	mysql_tquery(g_SQL, unbanQuery);
	va_SendClientMessage(adminid, COLOR_RED, "[ ! ]: You have sucesfully unbanned account %s!", playername);

	#if defined UNBAN_LOGGING
		new
			tmpString[ 128 ],
			days, months, years;

		getdate(years, months, days);
		format( tmpString, sizeof( tmpString ), "[%s] Game Admin %s[%s](%s) je unbanao igraca %s.",
			ReturnDate(),
			PlayerInfo[adminid][pForumName],
			GetName( adminid, false ),
			GetPlayerIP( adminid ),
			playername
		);
		LogAdminBan(tmpString);
	#endif
	return 1;
}


stock UnbanPlayerIP(const playerip[], adminid)
{
	new dformat[64];
	format(dformat,sizeof dformat,"unbanip %s",playerip);
	SendRconCommand(dformat);
	va_SendClientMessage( adminid, COLOR_RED, "[ ! ]: You have sucessfully unbanned IP %s", playerip);

	#if defined UNBAN_LOGGING
		new
			tmpString[ 128 ],
			days, months, years;

		getdate(years, months, days);
		format( tmpString, sizeof( tmpString ), "[%02d/%02d/%d] Game Admin %s(%s) unbanned IP %s",
			days,
			months,
			years,
			GetName( adminid, false ),
			GetPlayerIP( adminid ),
			playerip
		);
		LogAdminBan(tmpString);
	#endif
	return 1;
}
