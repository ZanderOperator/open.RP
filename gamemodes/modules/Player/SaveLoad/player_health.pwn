#include <YSI_Coding\y_hooks>

LoadPlayerHealth(playerid)
{
    inline LoadingPlayerHealth()
    {
        if(!cache_num_rows())
        {
            mysql_fquery_ex(SQL_Handle(), 
                "INSERT INTO \n\
                    player_health \n\
                (sqlid, health, armour, hunger) \n\
                VALUES \n\
                    ('%d', '100.0', '0.0', '5.0')",
                PlayerInfo[playerid][pSQLID]
            );
            return 1;
        }
        cache_get_value_name_float(0,	"health"	, PlayerHealth[playerid][pHealth]);
        cache_get_value_name_float(0,	"armour"	, PlayerHealth[playerid][pArmour]);
        cache_get_value_name_float(0,	"hunger"	, PlayerHealth[playerid][pHunger]);
        return 1;
    }
    MySQL_PQueryInline(SQL_Handle(),
        using inline LoadingPlayerHealth,
        va_fquery(SQL_Handle(), "SELECT * FROM player_health WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
    );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerHealth(playerid);
	return continue(playerid);
}

SavePlayerHealth(playerid)
{
    mysql_fquery_ex(SQL_Handle(),
        "UPDATE player_health SET health = '%d', armour = '%d', hunger = '%d' WHERE sqlid = '%d'",
        PlayerHealth[playerid][pHealth],
        PlayerHealth[playerid][pArmour],
        PlayerHealth[playerid][pHunger],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerHealth(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerHealth[playerid][pHealth] = 100.0;
    PlayerHealth[playerid][pArmour] = 0.0;
    PlayerHealth[playerid][pHunger] = 5.0;
	return continue(playerid);
}
