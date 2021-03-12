#include <YSI_Coding\y_hooks>

LoadPlayerInventory(playerid)
{
    inline LoadingPlayerInventory()
    {
        if(!cache_num_rows())
        {
            mysql_fquery_ex(SQL_Handle(), 
                "INSERT INTO \n\
                    player_inventory \n\
                (sqlid, mask, toolkit, watch, ciggaretes, lighter, parts, rope, boombox) \n\
                VALUES \n\
                    ('%d', '0', '0', '0', '0', '0', '0', '0', '0')",
                PlayerInfo[playerid][pSQLID]
            );
            return 1;
        }
        cache_get_value_name_int(0, "mask"		    , PlayerInventory[playerid][pMaskID]);
        cache_get_value_name_int(0, "toolkit"		, PlayerInventory[playerid][pToolkit]);
        cache_get_value_name_int(0, "watch"		    , PlayerInventory[playerid][pWatch]);
        cache_get_value_name_int(0, "ciggaretes"	, PlayerInventory[playerid][pCiggaretes]);
        cache_get_value_name_int(0, "lighter"		, PlayerInventory[playerid][pLighter]);
        cache_get_value_name_int(0, "parts"		    , PlayerInventory[playerid][pParts]);
        cache_get_value_name_int(0, "rope"		    , PlayerInventory[playerid][pRope]);
        cache_get_value_name_int(0, "boombox"		, PlayerInventory[playerid][pBoomBox]);
        return 1;
    }
    MySQL_PQueryInline(SQL_Handle(),
        using inline LoadingPlayerInventory,
        va_fquery(SQL_Handle(), "SELECT * FROM player_inventory WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        ""
    );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerInventory(playerid);
	return continue(playerid);
}

SavePlayerInventory(playerid)
{
    mysql_fquery_ex(SQL_Handle(),
        "UPDATE player_inventory SET mask = '%d', toolkit = '%d', watch = '%d', ciggaretes = '%d', lighter = '%d', \n\
            parts = '%d', rope = '%d', boombox = '%d' WHERE sqlid = '%d'",
        PlayerInventory[playerid][pMaskID],
        PlayerInventory[playerid][pToolkit],
        PlayerInventory[playerid][pWatch],
        PlayerInventory[playerid][pCiggaretes],
        PlayerInventory[playerid][pLighter],
        PlayerInventory[playerid][pParts],
        PlayerInventory[playerid][pRope],
        PlayerInventory[playerid][pBoomBox],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerInventory(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerInventory[playerid][pMaskID] = -1;
    PlayerInventory[playerid][pToolkit] = 0;
    PlayerInventory[playerid][pWatch] = 0;
    PlayerInventory[playerid][pCiggaretes] = 0;
    PlayerInventory[playerid][pLighter] = 0;
    PlayerInventory[playerid][pParts] = 0;
    PlayerInventory[playerid][pRope] = 0;
    PlayerInventory[playerid][pBoomBox] = 0;
	return continue(playerid);
}
