#include <YSI_Coding\y_hooks>

#if defined MODULE_ADMIN_CONNECTIONS
	#endinput
#endif
#define MODULE_ADMIN_CONNECTIONS

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock SaveAdminConnectionTime(playerid)
{
	if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pHelper])
		return 1;

	new Cache:result;
	
	result = mysql_query(SQL_Handle(), 
				va_fquery(SQL_Handle(), 
					"SELECT * FROM stats_admins WHERE sqlid = '%d' AND \n\
						EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM CURDATE())", 
					PlayerInfo[playerid][pSQLID]
				)
			);
	
	if(cache_num_rows()) 
	{
		mysql_fquery(SQL_Handle(), "UPDATE stats_admins SET times = '%d' WHERE sqlid = '%d'", 
			ExpInfo[playerid][eMonthPayDays], 
			PlayerInfo[playerid][pSQLID] 
		);
	} 
	else 
	{
		mysql_fquery(SQL_Handle(), "INSERT INTO stats_admins (sqlid, date, times) VALUES ('%d',CURDATE(),'%d')", 
			PlayerInfo[playerid][pSQLID],
			ExpInfo[playerid][eMonthPayDays]
		);
	}
	cache_delete(result);
	return 1;
}

stock static GetAdminConnectionTime(playerid, giveplayerid)
{
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "Nevaljan unos playerid!");
	va_SendClientMessage(playerid, COLOR_RED, "[!] Game Admin spent %d hours of gameplay on server this month.",  
		ExpInfo[playerid][eMonthPayDays]
	);
	return 1;
}

stock static GetAdminConnectionTimeEx(playerid, sqlid)
{
	mysql_tquery(SQL_Handle(), 
		va_fquery(SQL_Handle(), 
			"SELECT * FROM stats_admins WHERE sqlid = '%d' AND EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM CURDATE())",
			 sqlid
		), 
		"OnAdminConnectionTimeExLoad", 
		"i", 
		playerid
	);
	return 1;
}


Public:OnAdminConnectionTimeExLoad(playerid)
{
	if(cache_num_rows())
	{
		new
			hours;
		cache_get_value_index_int(0, 0, hours);
		va_SendClientMessage(playerid, COLOR_RED, "[!]: Game Admin spent %d hours of gameplay on server.",  hours);
	}
	else
		SendClientMessage(playerid, COLOR_RED, "[!]: Game Admin doesn't exist/didn't spend time on server this month!");
	return 1;
}

hook function SavePlayerStats(playerid)
{
	SaveAdminConnectionTime(playerid);
	return continue(playerid);
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
CMD:admactivity(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Game Admin Level 4+!");
		
	new
		giveplayerid;
	if(sscanf( params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /admactivity [dio imena/playerid]");
	GetAdminConnectionTime(playerid, giveplayerid);
	return 1;
}
CMD:admactivityex(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Game Admin Level 4+!");
		
	new
		sqlid;
	if(sscanf( params, "s[24]", sqlid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /admactivityex [sqlid]");
	GetAdminConnectionTimeEx(playerid, sqlid);
	return 1;
}