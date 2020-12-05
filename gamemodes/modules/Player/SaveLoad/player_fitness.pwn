#include <YSI_Coding\y_hooks>

LoadPlayerFitness(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_fitness WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerFitness", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerFitness(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_health(sqlid, muscle, gymtimes, gymcounter, fightstyle) \n\
                VALUES('%d', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0, "muscle"		, PlayerGym[playerid][pMuscle]);
    cache_get_value_name_int(0,	"gymtimes"		, PlayerGym[playerid][pGymTimes]);
	cache_get_value_name_int(0,	"gymcounter"	, PlayerGym[playerid][pGymCounter]);
    cache_get_value_name_int(0,	"fightstyle"	, PlayerGym[playerid][pFightStyle]);
    return 1;
}

hook LoadPlayerStats(playerid)
{
    LoadPlayerFitness(playerid);
    return 1;
}

SavePlayerFitness(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_fitness SET muscle = '%d', gymtimes = '%d', gymcounter = '%d', fightstyle = '%d' WHERE sqlid = '%d'",
        PlayerGym[playerid][pMuscle],
        PlayerGym[playerid][pGymTimes],
        PlayerGym[playerid][pGymCounter],
        PlayerGym[playerid][pFightStyle],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerStats(playerid)
{
    SavePlayerFitness(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerGym[playerid][pMuscle] = 0;
    PlayerGym[playerid][pGymTimes] = 0;
    PlayerGym[playerid][pGymCounter] = 0;
    PlayerGym[playerid][pFightStyle] = FIGHT_STYLE_NORMAL;
    return 1;
}
