#include <YSI_Coding\y_hooks>

LoadPlayerJailStats(playerid)
{
    inline LoadingPlayerJailStats()
    {
        if(!cache_num_rows())
        {
            mysql_fquery(SQL_Handle(), 
                "INSERT INTO \n\
                    player_jail \n\
                (sqlid, jailed, jailtime, arrested, bailprice) \n\
                VALUES \n\
                    ('%d', '0', '0', '0', '0')",
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
    MySQL_TQueryInline(SQL_Handle(),
        using inline LoadingPlayerJailStats, 
        va_fquery(SQL_Handle(), "SELECT * FROM player_jail WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
    );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerJailStats(playerid);
	return continue(playerid);
}

SavePlayerJailStats(playerid)
{
    mysql_fquery(SQL_Handle(),
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
