#include <YSI_Coding\y_hooks>

LoadPlayerAppearance(playerid)
{
    inline LoadingPlayerAppearance()
    {
        if(!cache_num_rows())
        {
            mysql_fquery_ex(SQL_Handle(), 
                "INSERT INTO \n\
                    player_appearance \n\
                (sqlid, skin, walkstyle, accent, look) \n\
                VALUES \n\
                    ('%d', '21', '0', '', '')",
                PlayerInfo[playerid][pSQLID]
            );
            return 1;
        }
        cache_get_value_name_int(0, "skin"		    , PlayerAppearance[playerid][pSkin]);
        cache_get_value_name_int(0, "walkstyle"		, PlayerAppearance[playerid][pWalkStyle]);
        cache_get_value_name(0, 	"accent"		, PlayerAppearance[playerid][pAccent], 19);
        cache_get_value_name(0, 	"look"		    , PlayerAppearance[playerid][pLook], 120);
        return 1;
    }
    MySQL_PQueryInline(SQL_Handle(),
        using inline LoadingPlayerAppearance,
        va_fquery(SQL_Handle(), "SELECT * FROM player_appearance WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
    );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerAppearance(playerid);
	return continue(playerid);
}

SavePlayerAppearance(playerid)
{
    mysql_fquery_ex(SQL_Handle(),
        "UPDATE player_appearance SET skin = '%d', walkstyle = '%d', \n\
            accent = '%e', look = '%e' WHERE sqlid = '%d'",
        PlayerAppearance[playerid][pSkin],
        PlayerAppearance[playerid][pWalkStyle],
        PlayerAppearance[playerid][pAccent],
        PlayerAppearance[playerid][pLook],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerAppearance(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerAppearance[playerid][pTmpSkin] = 0;
    PlayerAppearance[playerid][pSkin] = 0;
    PlayerAppearance[playerid][pWalkStyle] = 0;
    PlayerAppearance[playerid][pAccent][0] = EOS;
    PlayerAppearance[playerid][pLook][0] = EOS;
	return continue(playerid);
}
