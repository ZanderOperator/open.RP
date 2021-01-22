#if defined MODULE_PLAYER_ROPE
    #endinput
#endif
#define MODULE_PLAYER_ROPE

// TODO: complete the implementation, buying rope etc

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

static
    bool:bPlayerTied[MAX_PLAYERS] = {false, ...};

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_IsTied(playerid)
{
    return bPlayerTied[playerid];
}

stock Player_SetIsTied(playerid, bool:v)
{
    bPlayerTied[playerid] = v;
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

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT)
    {
        if(Player_IsTied(playerid))
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(Player_IsTied(playerid))
    {
        TogglePlayerControllable(playerid, 1);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    Player_SetIsTied(playerid, false);
	return continue(playerid);
}


/*
     ######  ##     ## ########
    ##    ## ###   ### ##     ##
    ##       #### #### ##     ##
    ##       ## ### ## ##     ##
    ##       ##     ## ##     ##
    ##    ## ##     ## ##     ##
     ######  ##     ## ########
*/

CMD:tie(playerid, params[])
{
    new
        giveplayerid;
    if(sscanf(params, "u", giveplayerid))
         return SendClientMessage(playerid, COLOR_RED, "[?]: /tie [Playerid / Part of name]");

    if(!ProxDetectorS(3.0, playerid, giveplayerid))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije dovoljno blizu vas!");

    if(giveplayerid == playerid)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete zavezati samog sebe!");

    if(giveplayerid == INVALID_PLAYER_ID)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");

    if(GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete zavezati igraca koji vozi!");

    if(!PlayerInventory[playerid][pRope])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate konop!");

    if(!Player_IsTied(giveplayerid))
    {
        va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "%s vas je zavezao!", GetName(playerid));
        va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Zavezao si %s!", GetName(giveplayerid));

        if(!IsPlayerInAnyVehicle(giveplayerid))
            SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
    }
    else
    {
        va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "%s vas je odvezao!", GetName(playerid));
        va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Odvezao si %s!", GetName(giveplayerid));

        if(!IsPlayerInAnyVehicle(giveplayerid))
            SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
    }
    Player_SetIsTied(playerid, !Player_IsTied(playerid));
    return 1;
}
