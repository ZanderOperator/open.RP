#if defined MODULE_PLAYER_TRACKING
    #endinput
#endif
#define MODULE_PLAYER_TRACKING

// TODO: this may be expanded for all kinds of player state tracking, such as:
// Last weapon, last virtual world, etc
/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>

/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static LastVehicle[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock Player_SetLastVehicle(playerid, v)
{
    LastVehicle[playerid] = v;
}

stock Player_GetLastVehicle(playerid)
{
    return LastVehicle[playerid];
}


/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) 
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        Player_SetLastVehicle(playerid, vehicleid);
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    Player_SetLastVehicle(playerid, INVALID_VEHICLE_ID);
	return continue(playerid);
}