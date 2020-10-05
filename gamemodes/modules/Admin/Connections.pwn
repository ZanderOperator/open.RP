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
	new
		adminConnQuery[ 128 ],
		Cache:result;
	format( adminConnQuery, 128, "SELECT * FROM `stats_admins` WHERE `sqlid` = '%d' AND EXTRACT(MONTH FROM `date`) = EXTRACT(MONTH FROM CURDATE()) LIMIT 0,1", PlayerInfo[ playerid ][ pSQLID ] );
	result = mysql_query(g_SQL, adminConnQuery);
	
	if( cache_num_rows() ) {
		format(adminConnQuery, 128, "UPDATE `stats_admins` SET times = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[ playerid ][ pAdminHours ], 
			PlayerInfo[ playerid ][ pSQLID ] 
		);
		mysql_tquery(g_SQL, adminConnQuery, "", "");
	} else {
		format(adminConnQuery, 128, "INSERT INTO `stats_admins` (`sqlid`, `date`, `times`) VALUES ('%d',CURDATE(),'%d')", 
			PlayerInfo[ playerid ][ pSQLID ],
			PlayerInfo[ playerid ][ pAdminHours ]
		);
		mysql_tquery(g_SQL, adminConnQuery, "", "");
	}
	cache_delete(result);
	return 1;
}

stock LoadAdminConnectionTime(playerid)
{
	new
		tmpQuery[ 128 ];
	format( tmpQuery, 128, "SELECT * FROM `stats_admins` WHERE `sqlid` = '%d' AND EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM CURDATE())", PlayerInfo[ playerid ][ pSQLID ] );
	mysql_tquery(g_SQL, tmpQuery, "OnAdminConnectionTimeLoaded", "i", playerid);
	return 1;
}

stock static GetAdminConnectionTime(playerid, giveplayerid)
{
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage(playerid, COLOR_RED, "Nevaljan unos playerid!");
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Game Admin spent %d hours of gameplay on server this month.",  PlayerInfo[ playerid ][ pAdminHours ]);
	return 1;
}

stock static GetAdminConnectionTimeEx(playerid, sqlid)
{
	new
		tmpQuery[ 128 ];
	format( tmpQuery, 128, "SELECT * FROM `stats_admins` WHERE `sqlid` = '%d' AND EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM CURDATE())", sqlid );
	mysql_tquery(g_SQL, tmpQuery, "OnAdminConnectionTimeExLoad", "i", playerid);
	return 1;
}

//////
Function: OnAdminConnectionTimeLoaded(playerid)
{
	if( !cache_num_rows() ) 
		PlayerInfo[ playerid ][ pAdminHours ] = 0;
	else
		cache_get_value_name_int(0, "times", PlayerInfo[ playerid ][ pAdminHours ] );
	return 1;
}

Function: OnAdminConnectionTimeExLoad(playerid)
{
	if( cache_num_rows() )
	{
		new
			hours;
		cache_get_value_index_int(0, 0, hours);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: Game Admin spent %d hours of gameplay on server.",  hours);
	}
	else
		SendClientMessage(playerid, COLOR_RED, "[ ! ]: Game Admin doesn't exist/didn't spend time on server this month!");
	return 1;
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
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /admactivity [dio imena/playerid]");
	GetAdminConnectionTime(playerid, giveplayerid);
	return 1;
}
CMD:admactivityex(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Game Admin Level 4+!");
		
	new
		sqlid;
	if( sscanf( params, "s[24]", sqlid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /admactivityex [sqlid]");
	GetAdminConnectionTimeEx(playerid, sqlid);
	return 1;
}