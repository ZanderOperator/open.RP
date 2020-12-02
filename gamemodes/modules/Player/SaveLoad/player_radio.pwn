#include <YSI_Coding\y_hooks>

LoadPlayerRadio(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_radio WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadPlayerRadio", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerRadio(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_radio(sqlid, HasRadio, MainSlot, Radio1, Slot1, Radio2, Slot2, Radio3, Slot3) \n\
                VALUES('%d', '0', '0', '0', '0', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,	"HasRadio"	, PlayerRadio[playerid][pHasRadio]);
	cache_get_value_name_int(0, "MainSlot"  , PlayerRadio[playerid][pMainSlot]);
    cache_get_value_name_int(0, "Radio1"    , PlayerRadio[playerid][pRadio][1]);
    cache_get_value_name_int(0, "Slot1"     , PlayerRadio[playerid][pRadioSlot][1]);
    cache_get_value_name_int(0, "Radio2"    , PlayerRadio[playerid][pRadio][2]);
    cache_get_value_name_int(0, "Slot2"     , PlayerRadio[playerid][pRadioSlot][2]);
    cache_get_value_name_int(0, "Radio3"    , PlayerRadio[playerid][pRadio][3]);
    cache_get_value_name_int(0, "Slot3"     , PlayerRadio[playerid][pRadioSlot][3]);
    return 1;
}

SavePlayerRadio(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_radio SET HasRadio = '%d', MainSlot = '%d', \n\
            Radio1 = '%d', Slot1 = '%d', \n\
            Radio2 = '%d', Slot2 = '%d', \n\
            Radio3 = '%d', Slot3 = '%d' \n\
            WHERE sqlid = '%d'",
        PlayerRadio[playerid][pHasRadio],
        PlayerRadio[playerid][pMainSlot],
        PlayerRadio[playerid][pRadio][1], PlayerRadio[playerid][pRadioSlot][1],
        PlayerRadio[playerid][pRadio][2], PlayerRadio[playerid][pRadioSlot][2],
        PlayerRadio[playerid][pRadio][3], PlayerRadio[playerid][pRadioSlot][3],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerRadio(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerRadio[playerid][pHasRadio] = 0;
    PlayerRadio[playerid][pMainSlot] = 0;
    PlayerRadio[playerid][pRadio][1] = 0; 
    PlayerRadio[playerid][pRadioSlot][1] = 0;
    PlayerRadio[playerid][pRadio][2] = 0;
    PlayerRadio[playerid][pRadioSlot][2] = 0;
    PlayerRadio[playerid][pRadio][3] = 0; 
    PlayerRadio[playerid][pRadioSlot][3] = 0;
    return 1;
}