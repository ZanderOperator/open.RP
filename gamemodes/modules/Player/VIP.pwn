#include <YSI_Coding\y_hooks>

LoadPlayerVIP(playerid)
{
	inline LoadingPlayerVIP()
	{
		if(!cache_num_rows())
		{
			mysql_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					player_vip_status \n\
				(sqlid, vipRank, vipTime, dvehperms) \n\
				VALUES \n\
					('%d', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name_int(0, "vipRank"		, PlayerVIP[playerid][pDonateRank]);
		cache_get_value_name_int(0,	"vipTime"		, PlayerVIP[playerid][pDonateTime]);
		cache_get_value_name_int(0,	"dvehperms"		, PlayerVIP[playerid][pDonatorVehPerms]);
		return 1;
	}
    MySQL_TQueryInline(SQL_Handle(),
		using inline LoadingPlayerVIP, 
        va_fquery(SQL_Handle(), "SELECT * FROM player_vip_status WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "i", 
        playerid
   );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerVIP(playerid);
	return continue(playerid);
}

SavePlayerVIP(playerid)
{
    mysql_fquery(SQL_Handle(),
        "UPDATE player_vip_status SET vipRank = '%d', vipTime = '%d', dvehperms = '%d' WHERE sqlid = '%d'",
        PlayerVIP[playerid][pDonateRank],
        PlayerVIP[playerid][pDonateTime],
        PlayerVIP[playerid][pDonatorVehPerms],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerVIP(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PlayerVIP[playerid][pDonateRank]		= 0;
    PlayerVIP[playerid][pDonateTime]		= 0;
	PlayerVIP[playerid][pDonatorVehPerms] 	= 0;
	return continue(playerid);
}

SetPlayerPremiumVIP(playerid, level)
{
    if(level == 1)
	{
		ExpInfo[playerid][ePoints] += BRONZE_EXP_POINTS;
		ExpInfo[playerid][eAllPoints] += BRONZE_EXP_POINTS;

	    PlayerInventory[playerid][pMaskID] = 100000 + random(899999);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			PlayerInventory[playerid][pMaskID]
		);
		#endif
		
		PlayerJob[playerid][pFreeWorks] 	    = 25;
		PlayerInfo[playerid][pRespects] 	    += 10;
		PlayerInfo[playerid][pChangeTimes] 	    += 2;
		PlayerInfo[playerid][pLevel] 		    += 1;

		PlayerVIP[playerid][pDonateRank]    	= PREMIUM_BRONZE;
		PlayerVIP[playerid][pDonatorVehPerms]   = 2;
		PlayerVIP[playerid][pDonateTime]	    = gettimestamp() + 2592000;
    }
    else if(level == 2)
	{
		ExpInfo[playerid][ePoints] += SILVER_EXP_POINTS;
		ExpInfo[playerid][eAllPoints] += SILVER_EXP_POINTS;

	    PlayerInventory[playerid][pMaskID] = 100000 + random(899999);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			PlayerInventory[playerid][pMaskID]
		);
		#endif

		PlayerJob[playerid][pFreeWorks] 	    = 25;
		PlayerInfo[playerid][pRespects] 	    += 20;
		PlayerInfo[playerid][pLevel] 	    	+= 2;
		PlayerInfo[playerid][pChangeTimes]  	+= 3;

		PlayerVIP[playerid][pDonateRank] 	    = PREMIUM_SILVER;
		PlayerVIP[playerid][pDonatorVehPerms] 	= 2;		
		PlayerVIP[playerid][pDonateTime]	    = gettimestamp() + 2592000;
    }
    else if(level == 3)
	{
		ExpInfo[playerid][ePoints] += GOLD_EXP_POINTS;
		ExpInfo[playerid][eAllPoints] += GOLD_EXP_POINTS;

	    PlayerInventory[playerid][pMaskID] = 100000 + random(899999);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			PlayerInventory[playerid][pMaskID]
		);
		#endif

		PlayerJob[playerid][pFreeWorks] 	    = 30;
		PlayerInfo[playerid][pRespects] 	    += 30;
		PlayerInfo[playerid][pLevel] 		    += 3;
		PlayerInfo[playerid][pChangeTimes] 	    += 5;
		if(PlayerInfo[playerid][pWarns] >= 1)
			PlayerInfo[playerid][pWarns] 		-= 1;
		
		PlayerVIP[playerid][pDonateRank] 		= PREMIUM_GOLD;
		PlayerVIP[playerid][pDonatorVehPerms] 	= 2;	
		PlayerVIP[playerid][pDonateTime]		= gettimestamp() + 2592000;

		LicenseInfo[playerid][pCarLic] 	= 1;
		LicenseInfo[playerid][pFlyLic] 	= 1;
		LicenseInfo[playerid][pBoatLic] = 1;
		LicenseInfo[playerid][pFishLic] = 1;
		LicenseInfo[playerid][pGunLic]	= 1;
    }
	else if(level == 4)
	{
		ExpInfo[playerid][ePoints] += PLATINUM_EXP_POINTS;
		ExpInfo[playerid][eAllPoints] += PLATINUM_EXP_POINTS;

	    PlayerInventory[playerid][pMaskID] = 100000 + random(899999);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			PlayerInventory[playerid][pMaskID]
		);
		#endif

		PlayerJob[playerid][pFreeWorks] 		= 50;
		PlayerInfo[playerid][pRespects] 		+= 50;
		PlayerInfo[playerid][pLevel] 			+= 4;
		PlayerInfo[playerid][pChangeTimes] 		+= 7;
		PlayerInfo[playerid][pWarns]			= 0;

		PlayerVIP[playerid][pDonateRank] 		= PREMIUM_PLATINUM;
		PlayerVIP[playerid][pDonatorVehPerms] 	= 2;
		PlayerVIP[playerid][pDonateTime]		= gettimestamp() + 3888000; // 45 dana

		LicenseInfo[playerid][pCarLic] 	= 1;
		LicenseInfo[playerid][pFlyLic] 	= 1;
		LicenseInfo[playerid][pBoatLic] = 1;
		LicenseInfo[playerid][pFishLic] = 1;
		LicenseInfo[playerid][pGunLic] 	= 2;
    }

	if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
		UpdatePremiumHouseFurSlots(playerid, -1, PlayerKeys[playerid][pHouseKey]);
	if(PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID)
		UpdateBizzFurnitureSlots(playerid);
	
	SavePlayerExperience(playerid);
	SavePlayerInventory(playerid);
	SavePlayerLicenses(playerid);
	SavePlayerVIP(playerid);
    return 1;
}