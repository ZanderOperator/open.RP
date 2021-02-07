#include <YSI_Coding\y_hooks>

LoadPlayerJailStats(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_jail WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerJailStats", 
        "i", 
        playerid
   );
    return 1;
}

Public: LoadingPlayerJailStats(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_jail(sqlid, jailed, jailtime, arrested, bailprice) \n\
                VALUES('%d', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
       );
        return 1;
    }
    cache_get_value_name_int(0,  "jailed"		, PlayerJail[playerid][pJailed]);		
    cache_get_value_name_int(0,  "jailtime"		, PlayerJail[playerid][pJailTime]);
    cache_get_value_name_int(0,  "arrested"	    , PlayerJail[playerid][pArrested]); 
    cache_get_value_name_int(0,  "bailprice"	, PlayerJail[playerid][pBailPrice]);
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerJailStats(playerid);
	return continue(playerid);
}

SavePlayerJailStats(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_jail SET jailed = '%d', jailtime = '%d', arrested = '%d', bailprice = '%d' WHERE sqlid = '%d'",
        PlayerJail[playerid][pJailed],
        PlayerJail[playerid][pJailTime],
        PlayerJail[playerid][pArrested],
        PlayerJail[playerid][pBailPrice],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerJailStats(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerJail[playerid][pJailed]		= 0;
    PlayerJail[playerid][pJailTime]		= 0;
    PlayerJail[playerid][pArrested] 	= 0;
	PlayerJail[playerid][pBailPrice] 	= 0;
    PlayerJail[playerid][pJailJob]      = 0;
	return continue(playerid);
}
