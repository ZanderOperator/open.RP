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
    PlayerInfo[playerid][pMoney] += amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();

	new str[20], Float:x, Float:y, Float:z, tmpQuery[128];
	GetPlayerPos(playerid, x,y,z);
	if(amount < 0)
	    format(str, 20, "~r~%d$", amount);
	else
 		format(str, 20, "~g~+%d$", amount);
    GameTextForPlayer(playerid, str, 1000, 1);
    PlayerPlaySound(playerid, 1054 ,x,y,z);
	// Update u tablice odma --------------------
	format( tmpQuery, sizeof(tmpQuery), "UPDATE accounts SET `handMoney` = '%d' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, tmpQuery);
	// ---------------------------------
	return PlayerInfo[playerid][pMoney];
}

stock AC_SetPlayerMoney(playerid, amount)
{
	new tmpQuery[128];
	PlayerInfo[playerid][pMoney] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();
	// Update u tablice odma --------------------
	format( tmpQuery, sizeof(tmpQuery), "UPDATE accounts SET `handMoney` = '%d' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, tmpQuery);
	// ---------------------------------
	return PlayerInfo[playerid][pMoney];
}

stock AC_GetPlayerMoney(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
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