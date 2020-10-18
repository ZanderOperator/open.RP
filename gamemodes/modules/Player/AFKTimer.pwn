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
new 
	Float:PlayerCurrentPos[MAX_PLAYERS][3],
	MaxPlayerAFK[MAX_PLAYERS];

	
/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/

hook OnPlayerConnect(playerid)
{
	MaxPlayerAFK[playerid] = 10;
    PlayerAFK[playerid] = 0;
    PlayerCurrentPos[playerid][0] = 0;
	PlayerCurrentPos[playerid][1] = 0;
	PlayerCurrentPos[playerid][2] = 0;
	return 1;
}

hook OnPlayerText(playerid, text[])
{
 	PlayerAFK[playerid] = 0;
	return 0;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	PlayerAFK[playerid] = 0;
	return 1;
}

hook OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	PlayerAFK[playerid] = 0;
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
	switch(PlayerInfo[playerid][pDonateRank])
	{
	    case 1: MaxPlayerAFK[playerid] = 12;
	    case 2: MaxPlayerAFK[playerid] = 13;
		case 3: MaxPlayerAFK[playerid] = 15;
		case 4:	MaxPlayerAFK[playerid] = 20;
		default: MaxPlayerAFK[playerid] = 10;    
	}
	return 1;
}

stock AFKCheck(playerid)
{
	if( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) )
		return 0;
		
	if(IsPlayerAdmin(playerid))
		return 1;
		
    GetPlayerPos(playerid, PlayerCurrentPos[playerid][0], PlayerCurrentPos[playerid][1], PlayerCurrentPos[playerid][2]);
    if(!floatcmp(PlayerCurrentPos[playerid][0], PlayerLastPos[playerid][plpX]) && !floatcmp(PlayerCurrentPos[playerid][1], PlayerLastPos[playerid][plpY]))
	{
        PlayerAFK[playerid]++;
	}
	else
	{
        PlayerAFK[playerid] = 0;
	}
	
 	PlayerLastPos[playerid][plpX] = PlayerCurrentPos[playerid][0];
	PlayerLastPos[playerid][plpY] = PlayerCurrentPos[playerid][1];
	PlayerLastPos[playerid][plpZ] = PlayerCurrentPos[playerid][2];

	if(PlayerAFK[playerid] >= MaxPlayerAFK[playerid])
	{
		va_SendClientMessage(playerid, COLOR_RED, "[SERVER] Predugo ste bili AFK (%d minuta), stoga ste dobili kick!", MaxPlayerAFK[playerid]);
		KickMessage(playerid);
	}
	return 1;
}
