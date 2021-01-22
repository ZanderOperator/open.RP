#if defined MODULE_ROADBLOCKS
    #endinput
#endif
#define MODULE_ROADBLOCKS

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

#define MAX_ROADBLOCKS                (50)


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum E_ROADBLOCK_DATA
{
    sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject
}

static
    Iterator:Roadblocks<MAX_ROADBLOCKS>,
    Roadblocks[MAX_ROADBLOCKS][E_ROADBLOCK_DATA];

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock CreateRoadblock(Object, Float:x, Float:y, Float:z, Float:Angle)
{
    new i = Iter_Free(Roadblocks);
    Roadblocks[i][sCreated] = 1;
    Roadblocks[i][sX] = x;
    Roadblocks[i][sY] = y;
    Roadblocks[i][sZ] = z-0.7;
    Roadblocks[i][sObject] = CreateDynamicObject(Object, x, y, z-0.9, 0, 0, Angle);
    return 1;
}

stock DeleteAllRoadblocks(playerid)
{
    foreach(new i: Roadblocks)
    {
        if(IsPlayerInRangeOfPoint(playerid, 100.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
            if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0;
                Roadblocks[i][sY] = 0;
                Roadblocks[i][sZ] = 0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
            }
        }
    }
    Iter_Clear(Roadblocks);
    return 1;
}

stock DeleteClosestRoadblock(playerid)
{
    new drb = -1;
    foreach(new i: Roadblocks)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
            if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0;
                Roadblocks[i][sY] = 0;
                Roadblocks[i][sZ] = 0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
                drb = i;
                return 1;
            }
        }
    }
    if(drb != -1)
        Iter_Remove(Roadblocks, drb);
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

CMD:rb(playerid, params[])
{
    new
        Float:plocx, Float:plocy, Float:plocz, Float:ploca,
        rb;

    if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac/SD/FD!");
    if(PlayerFaction[playerid][pRank] >= 2)
    {
        if(sscanf(params, "i", rb))
        {
            SendClientMessage(playerid, COLOR_WHITE, "[?]: /roadblock(/rb) [Roadblock ID]");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Dostupne blokade:");
            SendClientMessage(playerid, COLOR_GRAD1, " 1: Mala blokada | 2: Velika blokada | 3: Cunj | 4: Znak usmjeravanja");
            SendClientMessage(playerid, COLOR_GRAD1, " 5: Znak upozorenja| 6: Blokada usmjeravanja | 7: Veliki cunj | 8: Duga ograda");
            SendClientMessage(playerid, COLOR_GRAD1, " 9: Semafor | 10: STOP | 11: Jednosmjer | 12: Road Closed | 13: Work Zone | 14: Pol. Traka");
            return 1;
        }

        // TODO: make a helper function to reduce code duplication and to eliminate the switch statement
        // you can make an array of player position offsets for each type of roadblock
        // and an array of messages (gametext) to send
        switch (rb)
        {
            case 1:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(1459,plocx,plocy,plocz,ploca))
                    GameTextForPlayer(playerid,"~w~Mala blokada ~b~postavljena!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 2:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(978,plocx,plocy,plocz+0.6,ploca))
                    GameTextForPlayer(playerid,"~w~Velika blokada ~b~postavljena!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 3:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(1238,plocx,plocy,plocz+0.2,ploca))
                    GameTextForPlayer(playerid,"~w~Cunj ~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 4:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(1425,plocx,plocy,plocz+0.6,ploca))
                    GameTextForPlayer(playerid,"~w~Znak usmjeravanja ~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 5:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(3265,plocx,plocy,plocz-0.5,ploca))
                    GameTextForPlayer(playerid,"~w~Znak upozorenja ~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 6:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(3091,plocx,plocy,plocz+0.5,ploca+180))
                    GameTextForPlayer(playerid,"~w~Blokada usmjeravanja ~g~postavljena!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 7:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(1237,plocx,plocy,plocz,ploca))
                    GameTextForPlayer(playerid,"~w~Veliki Cunj ~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 8:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19313,plocx,plocy,plocz,ploca))
                    GameTextForPlayer(playerid,"~w~Ograda ~g~postavljena!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 9:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(1352,plocx,plocy,plocz-1,ploca))
                    GameTextForPlayer(playerid,"~w~Semafor ~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 10:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19966,plocx,plocy,plocz-1,ploca))
                    GameTextForPlayer(playerid,"~w~Znak STOP~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 11:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19967,plocx,plocy,plocz-1,ploca))
                    GameTextForPlayer(playerid,"~w~Znak jednosmjera~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 12:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19972,plocx,plocy,plocz-1,ploca))
                    GameTextForPlayer(playerid,"~w~Znak road closed~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 13:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19975,plocx,plocy,plocz-1,ploca))
                    GameTextForPlayer(playerid,"~w~Znak work zone~g~postavljen!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
            case 14:
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                if(CreateRoadblock(19834,plocx,plocy,plocz+0.8,ploca))
                    GameTextForPlayer(playerid,"~w~Traka~g~postavljena!",3000,1);
                else
                    GameTextForPlayer(playerid,"~w~Limit je dosegnut!",3000,1);
            }
        }
    }
    else SendClientMessage(playerid, COLOR_WHITE, "Nisi Rank 2!");
    return 1;
}

CMD:rrb(playerid, params[])
{
    // TODO: reduce level of nesting
    if(IsACop(playerid) || IsFDMember(playerid) || IsASD(playerid))
    {
        if(PlayerFaction[playerid][pRank] >= 2)
        {
            DeleteClosestRoadblock(playerid);
            GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
        }
        else SendClientMessage(playerid, COLOR_RED, "Nisi Rank 3!");
    }
    return 1;
}

CMD:removeall(playerid, params[])
{
    // TODO: reduce level of nesting
    if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || PlayerInfo[playerid][pAdmin] >= 2)
    {
        if(PlayerFaction[playerid][pRank] >= 1 || PlayerInfo[playerid][pAdmin] >= 2)
        {
            if(PlayerFaction[playerid][pMember] == 1 && PlayerFaction[playerid][pRank] < 1) return SendClientMessage(playerid, COLOR_RED, "Suspendirani ste!");

            DeleteAllRoadblocks(playerid);

            new
                string[84];
            format(string, sizeof(string),"[HQ]: Officer %s je maknuo sve blokade u ovom podrucju, over.", GetName(playerid));
            SendRadioMessage(1, COLOR_LIGHTBLUE, string);
            GameTextForPlayer(playerid,"~b~All ~w~Roadblocks ~r~Removed!",3000,1);
        }
    }
    return 1;
}