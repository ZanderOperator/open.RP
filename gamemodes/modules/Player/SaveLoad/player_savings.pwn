#include <YSI_Coding\y_hooks>

LoadPlayerSavings(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_savings WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerSavings", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerSavings(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_savings(sqlid, savings_cool, savings_time, savings_type, savings_money) \n\
                VALUES('%d', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    
    cache_get_value_name_int(0,	"savings_cool"	, PlayerSavings[playerid][pSavingsCool]);
    cache_get_value_name_int(0,	"savings_time"	, PlayerSavings[playerid][pSavingsTime]);
    cache_get_value_name_int(0,	"savings_type"	, PlayerSavings[playerid][pSavingsType]);
    cache_get_value_name_int(0,	"savings_money"	, PlayerSavings[playerid][pSavingsMoney]);
   
    return 1;
}

SavePlayerSavings(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_savings SET savings_cool = '%d', savings_time = '%d', savings_type = '%d',\n\
            savings_money = '%d' WHERE sqlid = '%d'",
        PlayerSavings[playerid][pSavingsCool],
        PlayerSavings[playerid][pSavingsTime],
        PlayerSavings[playerid][pSavingsType],
        PlayerSavings[playerid][pSavingsMoney],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerSavings(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    ResetSavingsVars(playerid);
    return 1;
}