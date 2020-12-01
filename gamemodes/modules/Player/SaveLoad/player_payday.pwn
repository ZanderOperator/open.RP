#include <YSI_Coding\y_hooks>

LoadPlayerPayday(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_job WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerPayday", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerPayday(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_job(sqlid, payday, paydaymoney, paydayhad, profit, dialog, date) \n\
                VALUES('%d', '0', '0', '0', '0', ' ', ' ')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0, "payday"	    , PaydayInfo[playerid][pPayDay]);	
    cache_get_value_name_int(0, "paydaymoney"	, PaydayInfo[playerid][pPayDayMoney]);
    cache_get_value_name_int(0, "paydayhad"	    , PaydayInfo[playerid][pPayDayHad]);
    cache_get_value_name_int(0, "profit"		, PaydayInfo[playerid][pProfit]);
    cache_get_value_name(0, 	"dialog"	    , PaydayInfo[playerid][pPayDayDialog], 2048);
    cache_get_value_name(0, 	"date"	        , PaydayInfo[playerid][pPayDayDate], 32);
    return 1;
}

SavePlayerPayday(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_payday SET payday = '%d', paydaymoney = '%d', paydayhad = '%d', profit = '%d',\n\
            dialog = '%e', date = '%e' WHERE sqlid = '%d'",
        PaydayInfo[playerid][pPayDay],
        PaydayInfo[playerid][pPayDayMoney],
        PaydayInfo[playerid][pPayDayHad],
        PaydayInfo[playerid][pProfit],
        PaydayInfo[playerid][pPayDayDialog],
        PaydayInfo[playerid][pPayDayDate],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook SavePlayerData(playerid)
{
    SavePlayerPayday(playerid);
    return 1;
}

hook ResetPlayerVariables(playerid)
{
    PaydayInfo[playerid][pPayDay] = 0;
    PaydayInfo[playerid][pPayDayMoney] = 0;
    PaydayInfo[playerid][pPayDayHad] = 0;
    PaydayInfo[playerid][pProfit] = 0;
    PaydayInfo[playerid][pPayDayDialog][0] = EOS;
    PaydayInfo[playerid][pPayDayDate][0] = EOS;
    return 1;
}
