#if defined MODULE_SWAT
    #endinput
#endif
#define MODULE_SWAT

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
// TODO: include Player/Char module header to set Player skin, etc, make more modular

/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static bool:IsSWAT[MAX_PLAYERS] = {false, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_IsSWAT(playerid)
{
    return IsSWAT[playerid];
}

stock Player_SetIsSWAT(playerid, bool:v)
{
    IsSWAT[playerid] = v;
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

hook OnPlayerDisconnect(playerid, reason)
{
    Player_SetIsSWAT(playerid, false);
    return 1;
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

CMD:swat(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid)) return SendClientMessage(playerid, COLOR_RED, "[!] Niste LSPD.");
    if(!Player_OnLawDuty(playerid)) return  SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
    if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete koristiti ovu komandu dok ste level 1!");

    new string[70];
    // TODO: make array of Swat positions and loop through them, and reduce level of nesting
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 2877.2317,-843.6631,-21.6994) ||
        IsPlayerInRangeOfPoint(playerid,5.0,2040.6858,1260.2460,-11.1115) ||
        IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) ||
        IsPlayerInRangeOfPoint(playerid,5.0,2032.1844,2206.1392,-31.4410) ||
        IsPlayerInRangeOfPoint(playerid,5.0,-882.4293,288.5243,535.341))
    {
        Player_SetIsSWAT(playerid, !Player_IsSWAT(playerid)); // toggle
        if(Player_IsSWAT(playerid))
        {
            SetPlayerSkin(playerid, 285);
            SetPlayerArmour(playerid, 150.0);
            SetPlayerHealth(playerid, 150.0);

            format(string, sizeof(string), "*[HQ] SWAT operativac %s je slobodan za pozive.", GetName(playerid,false));
            SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);
        }
        else
        {
            SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);

            new Float:armour;
            GetPlayerArmour(playerid, armour);
            if(armour >= 99.0) SetPlayerArmour(playerid, 99.0);

            format(string, sizeof(string), "*[HQ] SWAT operativac %s je sada van duznosti.", GetName(playerid,false));
            SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);
        }
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi na mjestu za uzimanje SWAT opreme");
    return 1;
}