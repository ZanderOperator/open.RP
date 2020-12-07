#include <YSI_Coding\y_hooks>

LoadPlayerFishes(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_fishes WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerFishes", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerFishes(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_fishes(sqlid, fishworks, fishweight, fishingskill) \n\
                VALUES('%d', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,  "fishworks"	    , PlayerFish[playerid][pFishWorks]);
    cache_get_value_name_int(0,  "fishweight"	    , PlayerFish[playerid][pFishWeight]);
    cache_get_value_name_int(0,  "fishingskill"     , PlayerFish[playerid][pFishingSkill]);
    return 1;
}

hook LoadPlayerStats(playerid)
{
    LoadPlayerFishes(playerid);
    return 1;
}

SavePlayerFishes(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_fishes SET fishworks = '%d', fishweight = '%d', fishingskill = '%d' WHERE sqlid = '%d'",
        PlayerFish[playerid][pFishWorks],
        PlayerFish[playerid][pFishWeight],
        PlayerFish[playerid][pFishingSkill],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerStats(playerid)
{
    SavePlayerFishes(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerFish[playerid][pFishWorks] = 0;
    PlayerFish[playerid][pFishWeight] = 0;
    PlayerFish[playerid][pFishingSkill] = 0;
    return 1;
}
