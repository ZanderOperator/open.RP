#include <YSI_Coding\y_hooks>

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
enum E_AFK_TIMER_DATA
{
    Float:plpX,
    Float:plpY,
    Float:plpZ,
}
new 
	PlayerLastPos[MAX_PLAYERS][E_AFK_TIMER_DATA];

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

static 
	Float:PlayerCurrentPos[MAX_PLAYERS][3],
	MaxPlayerAFK[MAX_PLAYERS],
	PlayerAFK[MAX_PLAYERS];

Player_GetAFK(playerid)
{
	return PlayerAFK[playerid];
}

Player_SetAFK(playerid, amount)
{
	PlayerAFK[playerid] = amount;
}

	
/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/

hook function ResetPlayerVariables(playerid)
{
	MaxPlayerAFK[playerid] = 10;
    Player_SetAFK(playerid, 0);
    PlayerCurrentPos[playerid][0] = 0;
	PlayerCurrentPos[playerid][1] = 0;
	PlayerCurrentPos[playerid][2] = 0;
	return continue(playerid);
}

hook OnPlayerText(playerid, text[])
{
 	Player_SetAFK(playerid, 0);
	return 0;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	Player_SetAFK(playerid, 0);
	return 1;
}

hook OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	Player_SetAFK(playerid, 0);
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock SetPlayerAFKLimit(playerid)
{
	switch(PlayerVIP[playerid][pDonateRank])
	{
	    case PREMIUM_BRONZE: 	MaxPlayerAFK[playerid] = 12;
	    case PREMIUM_SILVER: 	MaxPlayerAFK[playerid] = 13;
		case PREMIUM_GOLD: 		MaxPlayerAFK[playerid] = 15;
		case PREMIUM_PLATINUM:	MaxPlayerAFK[playerid] = 20;
		default: 				MaxPlayerAFK[playerid] = 10;    
	}
	return 1;
}

stock AFKCheck(playerid)
{
	if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid))
		return 0;
		
	if(IsPlayerAdmin(playerid))
		return 1;
		
    GetPlayerPos(playerid, PlayerCurrentPos[playerid][0], PlayerCurrentPos[playerid][1], PlayerCurrentPos[playerid][2]);
    if(!floatcmp(PlayerCurrentPos[playerid][0], PlayerLastPos[playerid][plpX]) && !floatcmp(PlayerCurrentPos[playerid][1], PlayerLastPos[playerid][plpY]))
		Player_SetAFK(playerid, (Player_GetAFK(playerid) + 1));
	else
        Player_SetAFK(playerid, 0);
	
 	PlayerLastPos[playerid][plpX] = PlayerCurrentPos[playerid][0];
	PlayerLastPos[playerid][plpY] = PlayerCurrentPos[playerid][1];
	PlayerLastPos[playerid][plpZ] = PlayerCurrentPos[playerid][2];

	if(Player_GetAFK(playerid) >= MaxPlayerAFK[playerid])
	{
		va_SendClientMessage(playerid, COLOR_RED, "[SERVER] Predugo ste bili AFK (%d minuta), stoga ste dobili kick!", MaxPlayerAFK[playerid]);
		KickMessage(playerid);
	}
	return 1;
}
