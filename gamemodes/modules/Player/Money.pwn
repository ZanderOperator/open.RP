#include <YSI_Coding\y_hooks>

/*
	##     ##  #######  ##    ## ######## ##    ##
	###   ### ##     ## ###   ## ##        ##  ##
	#### #### ##     ## ####  ## ##         ####
	## ### ## ##     ## ## ## ## ######      ##
	##     ## ##     ## ##  #### ##          ##
	##     ## ##     ## ##   ### ##          ##
	##     ##  #######  ##    ## ########    ##
*/

stock AC_GivePlayerMoney(playerid, amount)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();

	new 
		str[20], 
		Float:x, 
		Float:y, 
		Float:z;

	GetPlayerPos(playerid, x,y,z);
	if(amount < 0)
	    format(str, 20, "~r~%d$", amount);
	else
 		format(str, 20, "~g~+%d$", amount);
    GameTextForPlayer(playerid, str, 1000, 1);
    PlayerPlaySound(playerid, 1054 ,x,y,z);

	PlayerInfo[playerid][pMoney] += amount;
	mysql_fquery(g_SQL, "UPDATE accounts SET handMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pSQLID]
	);
	// ---------------------------------
	return PlayerInfo[playerid][pMoney];
}

stock AC_SetPlayerMoney(playerid, amount)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();

	PlayerInfo[playerid][pMoney] = amount;
	mysql_fquery(g_SQL, "UPDATE accounts SET handMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pSQLID]
	);
	return PlayerInfo[playerid][pMoney];
}

stock AC_GetPlayerMoney(playerid)
{
	if(playerid == INVALID_PLAYER_ID) return 0;
	return PlayerInfo[playerid][pMoney];
}

stock AC_ResetPlayerMoney(playerid)
{
	PlayerInfo[playerid][pMoney] = 0;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();
	return 1;
}

stock AC_MoneyDetect(playerid)
{
	//Anti-Money
	new serverMoney = AC_GetPlayerMoney(playerid),
		realMoney 	= GetPlayerMoney(playerid);

	if(realMoney > serverMoney) {
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	}
	else if(realMoney < serverMoney) {
		if(((serverMoney - realMoney) == 1) && (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT))
			PlayerInfo[playerid][pMoney]--;

		AC_SetPlayerMoney(playerid, serverMoney);
	}
	return 1;
}