#include <YSI_Coding\y_hooks>

LoadPlayerFaction(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_faction WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerFaction", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerFaction(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_faction(sqlid, facLeadId, facMemId, facRank) \n\
                VALUES('%d', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,  "facLeadId"	, PlayerFaction[playerid][pLeader]);
    cache_get_value_name_int(0,  "facMemId"		, PlayerFaction[playerid][pMember]);
    cache_get_value_name_int(0,  "facRank"		, PlayerFaction[playerid][pRank]);
    return 1;
}

SavePlayerFaction(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_savings SET facLeadId = '%d', facMemId = '%d', facRank = '%d' WHERE sqlid = '%d'",
        PlayerFaction[playerid][pLeader],
        PlayerFaction[playerid][pMember],
        PlayerFaction[playerid][pRank],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerFaction(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerFaction[playerid][pLeader] = 0;
    PlayerFaction[playerid][pMember] = 0;
    PlayerFaction[playerid][pRank] = 0;
    return 1;
}