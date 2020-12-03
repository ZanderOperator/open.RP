#include <YSI_Coding\y_hooks>

LoadPlayerCredit(playerid)
{
	inline OnPlayerCreditLoad()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO player_credits(sqlid, type, rate, amount, unpaid, used, timestamp) \n\
					VALUES ('%d', '0', '0', '0', '0', '0', '0')",
				PlayerInfo[ playerid ][ pSQLID ]
			);
			return 1;
		}
			
		cache_get_value_name_int(0, "type"		, CreditInfo[playerid][cCreditType]);
		cache_get_value_name_int(0, "rate"		, CreditInfo[playerid][cRate]);
		cache_get_value_name_int(0, "amount"	, CreditInfo[playerid][cAmount]);
		cache_get_value_name_int(0, "unpaid"	, CreditInfo[playerid][cUnpaid]);
		cache_get_value_name_int(0, "used"		, CreditInfo[playerid][cUsed]);
		cache_get_value_name_int(0, "timestamp"	, CreditInfo[playerid][cTimestamp]);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline OnPlayerCreditLoad, 
		va_fquery(g_SQL, "SELECT * FROM player_credits WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
		"i", 
		playerid
	);
	return 1;
}

hook LoadPlayerStats(playerid)
{
	LoadPlayerCredit(playerid);
	return 1;
}

SavePlayerCredit(playerid)
{
	mysql_fquery_ex(g_SQL, 
		"UPDATE player_credits SET rate = '%d', type = '%d', amount = '%d',\n\
			unpaid = '%d', used = '%d', timestamp = '%d' WHERE sqlid = '%d'",
		CreditInfo[playerid][cRate],
		CreditInfo[playerid][cCreditType],
		CreditInfo[playerid][cAmount],
		CreditInfo[playerid][cUnpaid],
		CreditInfo[playerid][cUsed],
		CreditInfo[playerid][cTimestamp],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

hook SavePlayerData(playerid)
{
	SavePlayerCredit(playerid);
	return 1;
}

hook ResetPlayerVariables(playerid)
{
    ResetCreditVars(playerid);
    return 1;
}

