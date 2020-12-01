#include <YSI_Coding\y_hooks>

LoadPlayerVIP(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_vip_status WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerVIP", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerVIP(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_vip_status(sqlid, vipRank, vipTime, donateveh, dvehperms) \n\
                VALUES('%d', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0, "vipRank"		, PlayerVIP[playerid][pDonateRank]);
    cache_get_value_name_int(0,	"vipTime"		, PlayerVIP[playerid][pDonateTime]);
    cache_get_value_name_int(0,	"donateveh"		, PlayerVIP[playerid][pDonatorVehicle]);
    cache_get_value_name_int(0,	"dvehperms"		, PlayerVIP[playerid][pDonatorVehPerms]);
    return 1;
}

SavePlayerVIP(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_vip_status SET vipRank = '%d', vipTime = '%d', donateveh = '%d', dvehperms = '%d WHERE sqlid = '%d'",
        PlayerVIP[playerid][pDonateRank],
        PlayerVIP[playerid][pDonateTime],
        PlayerVIP[playerid][pDonatorVehicle],
        PlayerVIP[playerid][pDonatorVehPerms],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerVIP(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PlayerVIP[playerid][pDonateRank]		= 0;
    PlayerVIP[playerid][pDonateTime]		= 0;
    PlayerVIP[playerid][pDonatorVehicle] 	= 0;
	PlayerVIP[playerid][pDonatorVehPerms] 	= 0;
    return 1;
}
