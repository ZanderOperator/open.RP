#include <YSI_Coding\y_hooks>

#if defined MODULE_BANS
	#endinput
#endif
#define MODULE_BANS

/*

 ,ad8888ba,                                                       
 d8"'    `"8b                                     ,d               
d8'                                               88               
88             ,adPPYba,  8b,dPPYba,  ,adPPYba, MM88MMM ,adPPYba,  
88            a8"     "8a 88P'   `"8a I8[    ""   88    I8[    ""  
Y8,           8b       d8 88       88  `"Y8ba,    88     `"Y8ba,   
 Y8a.    .a8P "8a,   ,a8" 88       88 aa    ]8I   88,   aa    ]8I  
  `"Y8888Y"'   `"YbbdP"'  88       88 `"YbbdP"'   "Y888 `"YbbdP"'  

*/

const MIN_REASON_LEN		= 1;
const MAX_REASON_LEN		= 22;

/*

88888888888                                           
88                                                    
88                                                    
88aaaaa 88       88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
88""""" 88       88 88P'   `"8a a8"     "" I8[    ""  
88      88       88 88       88 8b          `"Y8ba,   
88      "8a,   ,a88 88       88 "8a,   ,aa aa    ]8I  
88       `"YbbdP'Y8 88       88  `"Ybbd8"' `"YbbdP"'  
                                                      
*/

stock HOOK_Ban(playerid, adminid, const reason[], days = -1)
{
	new
		forumname[MAX_PLAYER_NAME],
		banString[128];

	if(adminid == INVALID_PLAYER_ID) 
	{
		if(days != -3)
		{
			format(banString, 128, "AdmCMD: %s is banned by Anti-Cheat. Reason: %s",
				GetName(playerid, false),
				reason
			);
			format(forumname, MAX_PLAYER_NAME, "Anti-Cheat");
		}
		else
		{
		    format(banString, 128, "AdmCMD: Account %s is automatically locked by the server. Reason: %s",
				GetName(playerid, false),
				reason
			);
			format(forumname, MAX_PLAYER_NAME, "AutoServerLock");
		}
	}
	else if(adminid != INVALID_PLAYER_ID) 
	{
		if(strlen(reason) > MAX_REASON_LEN || strlen(reason) < MIN_REASON_LEN) 
		{
			va_SendMessage(adminid, 
				MESSAGE_TYPE_ERROR, 
				"Invalid reason input (%d[min]-%d[max] chars required).", 
				MIN_REASON_LEN, 
				MAX_REASON_LEN
			);
			return 1;
		}
		format(banString, 128, "AdmCMD: %s is banned by Game Admin %s(%s). Reason: %s",
			GetName(playerid, false),
			PlayerInfo[adminid][pForumName],
			GetName(adminid, false),
			reason
		);
	}
	SendClientMessageToAll(COLOR_RED, banString);

	new
		unban_time;
	if(days == -1)
		unban_time = -1;
	else if(days == -3)
	    unban_time = -3;
	else 
	{
		unban_time = days * 86400; // 86400 is one day in seconds
		unban_time += gettimestamp();
	}

	mysql_fquery(SQL_Handle(), "UPDATE accounts SET playaUnbanTime = '%d', playaBanReason = '%e' WHERE sqlid = '%d'",
		unban_time,
		reason,
		PlayerInfo[playerid][pSQLID]
	);

	mysql_fquery_ex(SQL_Handle(), 
		"INSERT INTO bans (player_id, name, player_ip, forumname, reason, date, unban) \n\
			VALUES ('%d', '%e', '%e', '%e', '%e', '%e', '%d')",
		PlayerInfo[playerid][pSQLID],
		GetName(playerid, false),
		ReturnPlayerIP(playerid),
		PlayerInfo[playerid][pForumName],
		reason,
		ReturnDate(),
		unban_time
	);

    ExpInfo[playerid][ePoints] = 0;
	ExpInfo[playerid][eAllPoints] = 0;

	PlayerInfo[playerid][pBanned] 	= 1;
	BanMessage(playerid);
	return 1;
}

stock HOOK_BanEx(playerid, const playername[], const playerip[], adminid, const reason[], days=-1)
{
	if(strlen(reason) > MAX_REASON_LEN || strlen(reason) < MIN_REASON_LEN) 
	{
		va_SendMessage(adminid, 
			MESSAGE_TYPE_ERROR, 
			"Invalid reason input (%d[min]-%d[max] chars required).", 
			MIN_REASON_LEN, 
			MAX_REASON_LEN
		);
		return 1;
	}
	va_SendClientMessageToAll( COLOR_RED,"AdmCMD: %s is banned by Game Admin %s(%s). Reason: %s",
		GetName(playerid, false),
		PlayerInfo[adminid][pForumName],
		GetName(adminid, false),
		reason
	);

	new
		unban_time;
	if(days == -1)
		unban_time = -1;
	else 
	{
		unban_time = days * 60 * 60 * 24;
		unban_time += gettimestamp();
	}

	inline BanAccount()
	{
		if(!cache_num_rows())
			return SendMessage(adminid, MESSAGE_TYPE_ERROR, "That account doesn't exist.");

		cache_get_value_name_int(0, "sqlid", sqlid);

		mysql_fquery(SQL_Handle(), "UPDATE accounts SET playaUnbanTime = '%d', playaBanReason = '%e' WHERE name = '%e'",
			unban_time,
			reason,
			playername
		);

		mysql_fquery(SQL_Handle(), "UPDATE experience SET points = '0', allpoints = '0' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pSQLID]
		);

		mysql_fquery_ex(SQL_Handle(), 
			"INSERT INTO bans (player_id, name, player_ip, forumname, reason, date, unban) \n\
				VALUES ('%d', '%e', '%e', '%e', '%e', '%e', '%d')",
			sqlid,
			playername,
			playerip,
			PlayerInfo[playerid][pForumName],
			reason,
			ReturnDate(),
			unban_time
		);
		return 1;
	}
	MySQL_PQueryInline(SQL_Handle(),
		using inline BanAccount, 
		va_fquery(SQL_Handle(), "SELECT sqlid FROM accounts WHERE name = '%e'", playername),
		""
	);
	return 1;
}

stock UnbanPlayerName(const playername[], adminid)
{
	mysql_fquery(SQL_Handle(), "UPDATE accounts SET playaUnbanTime = '0', playaBanReason = '' WHERE name = '%e'", playername);
	va_SendClientMessage(adminid, COLOR_RED, "[!]: You have sucesfully unbanned account %s!", playername);

	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_unban.txt", "[%s] Game Admin %s[%s](%s) unbanned account %s.",
		ReturnDate(),
		PlayerInfo[adminid][pForumName],
		GetName( adminid, false),
		ReturnPlayerIP( adminid),
		playername
	);
	#endif
	return 1;
}


stock UnbanPlayerIP(const playerip[], adminid)
{
	new 
		dformat[64];
	format(dformat,sizeof dformat,"unbanip %s",playerip);

	// Ensuring proper IP unban
	SendRconCommand(dformat);
	SendRconCommand(dformat);
	SendRconCommand(dformat);
	
	va_SendClientMessage( adminid, COLOR_RED, "[!]: You have sucessfully unbanned IP %s", playerip);

	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_unban.txt", "[%s] Game Admin %s(%s) unbanned IP %s",
		ReturnDate(),
		GetName(adminid, false),
		ReturnPlayerIP(adminid),
		playerip
	);
	#endif
	return 1;
}