#if defined MODULE_FLARE
    #endinput
#endif
#define MODULE_FLARE

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
    ########  ######## ######## #### ##    ## ######## 
    ##     ## ##       ##        ##  ###   ## ##       
    ##     ## ##       ##        ##  ####  ## ##       
    ##     ## ######   ######    ##  ## ## ## ######   
    ##     ## ##       ##        ##  ##  #### ##       
    ##     ## ##       ##        ##  ##   ### ##       
    ########  ######## ##       #### ##    ## ######## 
*/

#define MAX_FLARES                  (20)


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum flInfo
{
    flCreated,
    Float:flX,
    Float:flY,
    Float:flZ,
    flObject
}

static FlareInfo[MAX_FLARES][flInfo];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

static CreateFlare(Float:x, Float:y, Float:z, Float:Angle)
{
    for (new i = 0; i < sizeof(FlareInfo); i++)
    {
        if(FlareInfo[i][flCreated] == 0)
        {
            FlareInfo[i][flCreated] = 1;
            FlareInfo[i][flX] = x;
            FlareInfo[i][flY] = y;
            FlareInfo[i][flZ] = z-0.5;
            FlareInfo[i][flObject] = CreateDynamicObject(18728, x, y, z-2.8, 0, 0, Angle-90, -1, -1, -1, 800.0);
            break;
        }
    }
}

static DeleteAllFlare()
{
    for (new i = 0; i < sizeof(FlareInfo); i++)
    {
        if(FlareInfo[i][flCreated] == 1)
        {
            FlareInfo[i][flCreated] = 0;
            FlareInfo[i][flX] = 0;
            FlareInfo[i][flY] = 0;
            FlareInfo[i][flZ] = 0;
            DestroyDynamicObject(FlareInfo[i][flObject]);
        }
    }
}

static DeleteClosestFlare(playerid)
{
    for (new i = 0; i < sizeof(FlareInfo); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, FlareInfo[i][flX], FlareInfo[i][flY], FlareInfo[i][flZ]))
        {
            if(FlareInfo[i][flCreated] == 1)
            {
                FlareInfo[i][flCreated] = 0;
                FlareInfo[i][flX] = 0;
                FlareInfo[i][flY] = 0;
                FlareInfo[i][flZ] = 0;
                DestroyDynamicObject(FlareInfo[i][flObject]);
                break;
            }
        }
    }
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

CMD:flares(playerid, params[])
{
    if(!(IsACop(playerid) || IsASD(playerid) || PlayerInfo[playerid][pAdmin] >= 2 || IsFDMember(playerid)))
    {
        return 1;
    }

    new Float:x, Float:y, Float:z, Float:Angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid,Angle);
    CreateFlare(x, y, z, Angle);
    GameTextForPlayer(playerid, "Bacio si baklju!", 1000, 1);
    return 1;
}

CMD:dflares(playerid, params[])
{
    if(!(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid)))
    {
        return 1;
    }

    if(PlayerFaction[playerid][pRank] >= 2)
    {
        DeleteClosestFlare(playerid);
    }
    return 1;
}

CMD:daflares(playerid, params[])
{
    if(!(IsACop(playerid) || IsASD(playerid) || PlayerInfo[playerid][pAdmin] >= 2 || IsFDMember(playerid)))
    {
        return 1;
    }

    if(PlayerFaction[playerid][pRank] >= 1 || PlayerInfo[playerid][pAdmin] >= 2)
    {
        DeleteAllFlare();
    }
    return 1;
}