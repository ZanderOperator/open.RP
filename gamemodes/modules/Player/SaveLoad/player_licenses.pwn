#include <YSI_Coding\y_hooks>

LoadPlayerLicenses(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_licenses WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerLicenses", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerLicenses(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_licenses(sqlid, carlic, gunlic, boatlic, fishlic, flylic, passport) \n\
                VALUES('%d', '0', '0', '0', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    
    cache_get_value_name_int(0,  "carlic"		, LicenseInfo[playerid][pCarLic]);
    cache_get_value_name_int(0,  "gunlic"		, LicenseInfo[playerid][pGunLic]);
    cache_get_value_name_int(0,	 "boatlic"		, LicenseInfo[playerid][pBoatLic]);
    cache_get_value_name_int(0,	 "fishlic"		, LicenseInfo[playerid][pFishLic]);
    cache_get_value_name_int(0,	 "flylic"		, LicenseInfo[playerid][pFlyLic]);
    cache_get_value_name_int(0,  "passport"		, LicenseInfo[playerid][pPassport]);
   
    return 1;
}

hook LoadPlayerStats(playerid)
{
    LoadPlayerLicenses(playerid);
    return 1;
}

SavePlayerLicenses(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_licenses SET carlic = '%d', gunlic = '%d', boatlic = '%d', fishlic = '%d', \n\
            flylic = '%d', passport = '%d' WHERE sqlid = '%d'",
        LicenseInfo[playerid][pCarLic],
        LicenseInfo[playerid][pGunLic],
        LicenseInfo[playerid][pBoatLic],
        LicenseInfo[playerid][pFishLic],
        LicenseInfo[playerid][pFlyLic],
        LicenseInfo[playerid][pPassport],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerStats(playerid)
{
    SavePlayerLicenses(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    LicenseInfo[playerid][pCarLic] = 0;
    LicenseInfo[playerid][pGunLic] = 0;
    LicenseInfo[playerid][pBoatLic] = 0;
    LicenseInfo[playerid][pFishLic] = 0;
    LicenseInfo[playerid][pFlyLic] = 0,
    LicenseInfo[playerid][pPassport] = 0;
    return 1;
}