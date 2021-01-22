#include <YSI_Coding\y_hooks>

stock IsAtATM(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(IsPlayerInRangeOfPoint(playerid,5.0,1153.35,-1455.98,15.79)      ||
            IsPlayerInRangeOfPoint(playerid,5.0,1137.12,-1630.50,13.88)      ||
            IsPlayerInRangeOfPoint(playerid,5.0,603.15,-1247.18,18.40)       ||
            IsPlayerInRangeOfPoint(playerid,5.0,-1981.71,120.82,27.67)       ||
            IsPlayerInRangeOfPoint(playerid,5.0,1009.1937,-930.2321,42.3281) ||
            IsPlayerInRangeOfPoint(playerid,5.0,1210.2834,-906.1295,43.0210) ||
			IsPlayerInRangeOfPoint(playerid,5.0,760.4859,-2593.2859,4.4650)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,2109.2551,-1790.0688,13.5547)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,1971.1931,-2143.8120,13.5469)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,370.1422,167.3989,1008.3828)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,2357.7942,-1984.3076,13.5469)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,1532.0973,-1171.6371,24.0781)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,1141.9521,-1761.4376,13.6098)  ||
			IsPlayerInRangeOfPoint(playerid,5.0,-2130.7778,-2321.4685,30.6250) || 
			IsPlayerInRangeOfPoint(playerid, 2.0, 2114.9590, -1790.7034, 13.1799) ||
			IsPlayerInRangeOfPoint(playerid, 4.0, 1915.7863, -1765.8585, 13.1875) ||
			IsPlayerInRangeOfPoint(playerid,5.0,1155.4810, -1464.6891, 15.4300)) 
		{ 
			return 1;
		}
 	}
	return 0;
}

CMD:atm(playerid, params[])
{
	if(!IsAtATM(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu ATM te nemozes koristiti ovu komandu!");
	new option[9], amount, string[77];
    if(sscanf(params, "s[9] ", option))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /atm [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[!] withdraw, status");
		return 1;
	}
	
	if(!strcmp(option, "status", true))
    {
		format(string, sizeof(string), "ATM: Trenutno stanje na vasem racunu je: %d$!", PlayerInfo[playerid][pBank]);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	else if(!strcmp(option, "withdraw", true))
	{
		if(sscanf(params, "s[9]i", option, amount)) return SendClientMessage(playerid, COLOR_RED, "[?]: /atm withdraw [iznos]");
		if(amount > PlayerInfo[playerid][pBank] || amount < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca!");
		BankToPlayerMoney(playerid, amount); // novac dolazi igracu na ruke iz banke
		format(string, sizeof(string), "Uzeli ste %d$ s vaseg racuna! Preostalo vam je %d$ na vasem racunu!", amount, PlayerInfo[playerid][pBank]);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	return 1;
}
