#include <YSI_Coding\y_hooks>

LoadPlayerTaxiStats(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_savings WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerSavings", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerTaxiStats(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_taxi(sqlid, taxiPoints, taxiVoted) \n\
                VALUES('%d', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0, "taxiPoints"	, TaxiInfo[playerid][pTaxiPoints]);
	cache_get_value_name_int(0, "taxiVoted"		, TaxiInfo[playerid][pTaxiVoted]);
   
    return 1;
}

hook LoadPlayerStats(playerid)
{
    LoadPlayerTaxiStats(playerid);
    return 1;
}

SavePlayerTaxiStats(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_taxi SET taxiPoints = '%d', taxiVoted = '%d' WHERE sqlid = '%d'",
        TaxiInfo[playerid][pTaxiPoints],
        TaxiInfo[playerid][pTaxiVoted],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerStats(playerid)
{
    SavePlayerTaxiStats(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    TaxiInfo[playerid][pTaxiPoints] = 0;
    TaxiInfo[playerid][pTaxiVoted] = 0;
    return 1;
}