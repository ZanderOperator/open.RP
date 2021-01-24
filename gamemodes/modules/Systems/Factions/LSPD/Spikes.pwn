#if defined MODULE_SPIKES
    #endinput
#endif
#define MODULE_SPIKES

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

#define MAX_SPIKES 10


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum PD_SPIKES
{
    spiType,
    spiObject,
    Float:spiPosX,
    Float:spiPosY,
    Float:spiPosZ
}

static
    Spikes             [MAX_SPIKES][PD_SPIKES],
    VehicleOnSpikeDelay[MAX_VEHICLES],
    Timer:VOSTimer     [MAX_VEHICLES];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

static GetFreeSpikeID()
{
    for (new spike = 0; spike < MAX_SPIKES; spike++)
    {
        if(Spikes[spike][spiType] == 0)
        {
            return spike;
        }
    }
    return -1;
}

static GetPlayerNearestSpike(playerid)
{
    for (new spike = 0; spike < MAX_SPIKES; spike++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 4.0, Spikes[spike][spiPosX], Spikes[spike][spiPosY], Spikes[spike][spiPosZ]))
        {
            return spike;
        }
    }
    return -1;
}

static ResetSpikeData(spike)
{
    Spikes[spike][spiPosX]   = 0;
    Spikes[spike][spiPosY]   = 0;
    Spikes[spike][spiPosZ]   = 0;
    Spikes[spike][spiObject] = 0;
    Spikes[spike][spiType]   = 0;
}

timer VOSDelay[2000](vehicleid)
{
    VehicleOnSpikeDelay[vehicleid] = 0;
    return 1;
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

// TODO: reduce level of nesting
hook OnPlayerUpdate(playerid) // maknit stavit onplayerenterdynamicrectangle
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        for (new spike = 0; spike < MAX_SPIKES; spike++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, Spikes[spike][spiPosX], Spikes[spike][spiPosY], Spikes[spike][spiPosZ]))
            {
                if(Spikes[spike][spiType] == 1 || Spikes[spike][spiType] == 2)
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][vTireArmor] == 1)
                    {
                        if(VehicleOnSpikeDelay[GetPlayerVehicleID(playerid)] < 1)
                        {
                            for (new vehtires = 0; vehtires < 4; vehtires++)
                            {
                                if(vTireHP[GetPlayerVehicleID(playerid)][vehtires] >= 35) vTireHP[GetPlayerVehicleID(playerid)][vehtires] -= 35;
                                else vTireHP[GetPlayerVehicleID(playerid)][vehtires] = 0;
                                if(vTireHP[GetPlayerVehicleID(playerid)][vehtires] <= 0)
                                {
                                    new panels, doors, lights, tires, t1s, t2s, t3s, t4s;
                                    new vehicleid = GetPlayerVehicleID(playerid);
                                    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                                    decode_tires(tires, t1s, t2s, t3s, t4s);
                                    if(vehtires == 0) t1s = 1;
                                    else if(vehtires == 1) t2s = 1;
                                    else if(vehtires == 2) t3s = 1;
                                    else if(vehtires == 3) t4s = 1;
                                    tires = encode_tires(t1s, t2s, t3s, t4s);
                                    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                                }
                            }
                            VehicleOnSpikeDelay[GetPlayerVehicleID(playerid)] = 1;
                            VOSTimer[GetPlayerVehicleID(playerid)] = defer VOSDelay(GetPlayerVehicleID(playerid));
                        }
                        break;
                    }
                    else
                    {
                        new panels, doors, lights, tires;
                        new vehicleid = GetPlayerVehicleID(playerid);
                        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                        tires = encode_tires(1, 1, 1, 1);
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                        break;
                    }
                }
            }
        }
    }
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

CMD:putspike(playerid, params[])
{
    new type;
    if(sscanf(params,"i", type)) return SendClientMessage(playerid, COLOR_RED, "[?]: /putspike [type] (1 | 2).");
    if(type < 1 || type > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pogresan tip spikea!");

    if(!IsACop(playerid) || !IsASD(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste u organizaciji LSPD/SASD.");
        return 1;
    }

    new Float:pos[3], Float:rot;
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerFacingAngle(playerid, rot);

    // TODO: from all of this code below, make a helper function PlaceSpikestrip(Float:x,Float:y,Float:z,Float:rot)
    new id = GetFreeSpikeID();
    if(id == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smije biti postavljeno vise od 10 spajkova.");

    switch (type)
    {
        case 1:
        {
            Spikes[id][spiObject] = CreateDynamicObject(2899, pos[0], pos[1], pos[2]-0.9, 0.00000000, 0.00000000, rot);
            Spikes[id][spiType] = 1;
            Spikes[id][spiPosX] = pos[0];
            Spikes[id][spiPosY] = pos[1];
            Spikes[id][spiPosZ] = pos[2];
            SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste postavile spike.");
        }
        case 2:
        {
            Spikes[id][spiObject] = CreateDynamicObject(2892, pos[0], pos[1], pos[2]-0.9, 0.00000000, 0.00000000, rot);
            Spikes[id][spiType] = 2;
            Spikes[id][spiPosX] = pos[0];
            Spikes[id][spiPosY] = pos[1];
            Spikes[id][spiPosZ] = pos[2];
            SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste postavile spike.");
        }
    }
    return 1;
}

CMD:removespike(playerid, params[])
{
    if(!IsACop(playerid) || !IsASD(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste u organizaciji LSPD/SASD.");
        return 1;
    }

    new id = GetPlayerNearestSpike(playerid); 
    if(id == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini postavljenih siljaka!");

    // TODO: helper function RemoveSpikestrip(spike_id)
    DestroyDynamicObject(Spikes[id][spiObject]);
    ResetSpikeData(id);
    //
    SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste maknuli siljke.");
    return 1;
}
