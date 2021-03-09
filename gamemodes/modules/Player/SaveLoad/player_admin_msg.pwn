#include <YSI_Coding\y_hooks>

LoadPlayerAdminMessage(playerid)
{
	inline LoadingPlayerAdminMessage()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO player_admin_msg(sqlid, AdminMessage, AdminMessageBy, AdmMessageConfirm) \n\
					VALUES('%d', '', '', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name(0, "AdminMessage", PlayerAdminMessage[playerid][pAdminMsg], 1536);
		cache_get_value_name(0, "AdminMessageBy", PlayerAdminMessage[playerid][pAdminMsgBy], 60);
		cache_get_value_name_int(0, "AdmMessageConfirm", PlayerAdminMessage[playerid][pAdmMsgConfirm]);
		return 1;
	}
    MySQL_PQueryInline(g_SQL,
		using inline LoadingPlayerAdminMessage, 
        va_fquery(g_SQL, 
			"SELECT * FROM player_admin_msg WHERE sqlid = '%d'", 
			PlayerInfo[playerid][pSQLID]
		),
        ""
   );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerAdminMessage(playerid);
	return continue(playerid);
}

SavePlayerAdminMessage(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_admin_msg SET AdminMessage = '%e', AdminMessageBy = '%e', AdmMessageConfirm = '%d' \n\
            WHERE sqlid = '%d'",
        PlayerAdminMessage[playerid][pAdminMsg],
        PlayerAdminMessage[playerid][pAdminMsgBy],
        PlayerAdminMessage[playerid][pAdmMsgConfirm],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerAdminMessage(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerAdminMessage[playerid][pAdminMsg][0] = EOS;
    PlayerAdminMessage[playerid][pAdminMsgBy][0] = EOS;
    PlayerAdminMessage[playerid][pAdmMsgConfirm] = false;
	return continue(playerid);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(SafeSpawned[playerid])
    {
        mysql_fquery(g_SQL, "UPDATE player_admin_msg SET AdminMessage = '', AdminMessageBy = '', AdmMessageConfirm = '0' \n\
            WHERE sqlid = '%d'", 
            PlayerInfo[playerid][pSQLID]
       );
    }
    return 1;
}

Public: AddAdminMessage(playerid, user_name[], reason[])
{
	new rows;
	
    cache_get_row_count(rows);
	if(!rows)
	 	return SendClientMessage(playerid, COLOR_RED, "[GRESKA - MySQL]: Ne postoji korisnik s tim nickom!");
	
	new
		on,
		sqlid;
	
	cache_get_value_name_int(0, "sqlid" , sqlid);
	cache_get_value_name_int(0, "online" , on);
	
	if(on)
	{
		sscanf(user_name, "u", on);
		
		if(on != INVALID_PLAYER_ID && IsPlayerConnected(on) && SafeSpawned[on])
		{
			va_SendClientMessage(on, COLOR_NICEYELLOW, "(( PM od %s[%d]: %s))", 
				GetName(playerid, false), 
				playerid, 
				reason
			);
			va_SendClientMessage(playerid, COLOR_RED, "(( PM za %s[%d]: %s))", 
				user_name, 
				on, 
				reason
			);
			SendClientMessage(playerid, COLOR_RED, "[!] Navedeni korisnik je bio in-game te mu je poslana poruka.");
			return 1;
		}
	}	
	mysql_fquery(g_SQL,
		"UPDATE player_admin_msg SET AdminMessage = '%e', AdminMessageBy = '%e', AdmMessageConfirm = '0' WHERE sqlid = '%d'",
		reason, 
		GetName(playerid, true), 
		sqlid
	);

	va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "You have sucessfully left %s a message: %s", user_name, reason);
	return 1;
}

SendServerMessage(sqlid, const reason[])
{
	mysql_fquery(g_SQL, 
		"UPDATE player_admin_msg SET AdminMessage = '%e', AdminMessageBy = '%e', \n\
			AdmMessageConfirm = '0' WHERE sqlid = '%d'",
		reason,
		SERVER_NAME,
		sqlid
	);
	return 1;
}

ShowAdminMessage(playerid)
{
	new 
		string[1600];
		
	format(string, sizeof(string), "Obavijest od %s\n%s", PlayerAdminMessage[playerid][pAdminMsgBy], PlayerAdminMessage[playerid][pAdminMsg]);
	ShowPlayerDialog(playerid, DIALOG_ADMIN_MSG, DIALOG_STYLE_MSGBOX, "Admin Message", string, "Ok", "");
	return 1;
}