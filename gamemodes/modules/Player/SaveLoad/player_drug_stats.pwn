#include <YSI_Coding\y_hooks>

LoadPlayerDrugStats(playerid)
{
	inline LoadingPlayerDrugStats()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO player_drug_stats(sqlid, drugused, drugsecond, drugorder) \n\
					VALUES ('%d', '0', '0', '0')",
				PlayerInfo[ playerid ][ pSQLID ]
			);
			return 1;
		}
		cache_get_value_name_int(0, "drugused"		, PlayerDrugStatus[playerid][pDrugUsed]);
		cache_get_value_name_int(0, "drugseconds"	, PlayerDrugStatus[playerid][pDrugSeconds]);
		cache_get_value_name_int(0, "drugorder"		, PlayerDrugStatus[playerid][pDrugOrder]);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline LoadingPlayerDrugStats, 
		va_fquery(g_SQL, "SELECT * FROM player_drug_stats WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
		"i", 
		playerid
	);
	return 1;
}

hook LoadPlayerStats(playerid)
{
	LoadPlayerDrugStats(playerid);
	return 1;
}

SavePlayerDrugStats(playerid)
{
	mysql_fquery_ex(g_SQL, 
		"UPDATE player_drug_stats SET drugused = '%d', drugseconds = '%d', drugorder = '%d' \n\
			WHERE sqlid = '%d'",
		PlayerDrugStatus[playerid][pDrugUsed],
        PlayerDrugStatus[playerid][pDrugSeconds],
        PlayerDrugStatus[playerid][pDrugOrder],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

hook SavePlayerStats(playerid)
{
	SavePlayerDrugStats(playerid);
	return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerDrugStatus[playerid][pDrugUsed] = 0;
    PlayerDrugStatus[playerid][pDrugSeconds] = 0;
    PlayerDrugStatus[playerid][pDrugOrder] = 0;
    return 1;
}

