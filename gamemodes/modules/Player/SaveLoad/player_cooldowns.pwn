#include <YSI_Coding\y_hooks>

LoadPlayerCooldowns(playerid)
{
    inline LoadingPlayerCooldowns()
    {
        if(!cache_num_rows())
        {
            mysql_fquery(SQL_Handle(), 
                "INSERT INTO \n\
                    player_cooldowns \n\
                (sqlid, casinocooldown, jackercooldown, ammucooldown) \n\
                VALUES \n\
                    ('%d', '0', '0', '0')",
                PlayerInfo[playerid][pSQLID]
        );
            return 1;
        }
        cache_get_value_name_int(0, "casinocooldown"		, PlayerCoolDown[playerid][pCasinoCool]);
        cache_get_value_name_int(0, "jackercooldown"		, PlayerCoolDown[playerid][pJackerCool]);
        cache_get_value_name_int(0, "ammucooldown"		    , PlayerCoolDown[playerid][pAmmuCool]);  
        return 1;
    }
    MySQL_TQueryInline(SQL_Handle(),
        using inline LoadingPlayerCooldowns, 
        va_fquery(SQL_Handle(), "SELECT * FROM player_cooldowns WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
    );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerCooldowns(playerid);
	return continue(playerid);
}

SavePlayerCoolDowns(playerid)
{
    mysql_fquery(SQL_Handle(),
        "UPDATE player_cooldowns SET casinocooldown = '%d', jackercooldown = '%d', ammucooldown = '%d' \n\
            WHERE sqlid = '%d'",
        PlayerCoolDown[playerid][pCasinoCool],
        PlayerCoolDown[playerid][pJackerCool],
        PlayerCoolDown[playerid][pAmmuCool],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerCoolDowns(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerCoolDown[playerid][pCasinoCool] = 10;
    PlayerCoolDown[playerid][pJackerCool] = 0;
    PlayerCoolDown[playerid][pAmmuCool] = 0;
	return continue(playerid);
}
