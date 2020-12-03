#include <YSI_Coding\y_hooks>

LoadPlayerJob(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_job WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerJob", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerJob(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_job(sqlid, jobkey, contracttime, freeworks) \n\
                VALUES('%d', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,  "jobkey"		, PlayerJob[playerid][pJob]);
    cache_get_value_name_int(0,  "contracttime"	, PlayerJob[playerid][pContractTime]);
    cache_get_value_name_int(0,  "freeworks"	, PlayerJob[playerid][pFreeWorks]);
    return 1;
}

hook LoadPlayerStats(playerid)
{
    LoadPlayerJob(playerid);
    return 1;
}

SavePlayerJob(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_job SET jobkey = '%d', contracttime = '%d', freeworks = '%d' WHERE sqlid = '%d'",
        PlayerJob[playerid][pJob],
        PlayerJob[playerid][pContractTime],
        PlayerJob[playerid][pFreeWorks],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerJob(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerJob[playerid][pJob] = 0;
    PlayerJob[playerid][pContractTime] = 0;
    PlayerJob[playerid][pFreeWorks] = 0;
    return 1;
}
