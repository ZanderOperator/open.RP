#if defined MODULE_LSPD_EVLS
    #endinput
#endif
#define MODULE_LSPD_EVLS

// EVLS - Emergency Vehicle Lights System
// TODO: Virtual1ty - stavit kao rotirke na vozila (imam ja vec gotov sistem)

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
    bool:BlinkerEnabled[MAX_PLAYERS]  = {false, ...},
    FlashCounter       [MAX_VEHICLES] = {0, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

static VehicleBlinker(playerid)
{
    if(!BlinkerEnabled[playerid])
    {
        return 1;
    }

    static Keys, ud, lr, panels, doors, lights, tires, vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);

    if(!IsPlayerInAnyVehicle(playerid) || vehicleid != Player_GetLastVehicle(playerid))
    {
        vehicleid = Player_GetLastVehicle(playerid);
        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        lights = encode_lights(0, 0, 0, 0);
        UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

        BlinkerEnabled[playerid] = false;
        FlashCounter[vehicleid] = 0;
        return 1;
    }

    GetPlayerKeys(playerid, Keys, ud, lr);
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

    switch (FlashCounter[vehicleid])
    {
        case 0: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
        case 1: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
        case 2: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
        case 3: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
        case 4: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
        case 5: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
    }

    FlashCounter[vehicleid]++;
    if(FlashCounter[vehicleid] >= 5)
    {
        FlashCounter[vehicleid] = 0;
    }
    return 1;
}

Public:OnPlayerSlowUpdate(playerid)
{
    VehicleBlinker(playerid);
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

// None, for now

/*
    ##     ##  #######   #######  ##    ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ## ##     ## ##     ## ##  ##
    ######### ##     ## ##     ## #####
    ##     ## ##     ## ##     ## ##  ##
    ##     ## ##     ## ##     ## ##   ##
    ##     ##  #######   #######  ##    ##
*/

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
    if(!(IsACop(playerid) || IsFDMember(playerid) || IsAGov(playerid) || IsADoC(playerid)))
    {
        return 1;
    }

    if(newstate)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return 1;

        if(!IsInStateVehicle(playerid))
            return 1;

        if(BlinkerEnabled[playerid] == false)
        {
            BlinkerEnabled[playerid] = true;
            FlashCounter[vehicleid] = 0;
        }
    }

    if(!newstate)
    {
        new panels, doors, lights, tires;
        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);

        if(BlinkerEnabled[playerid])
        {
            BlinkerEnabled[playerid] = false;
            FlashCounter[vehicleid] = 0;
        }
    }

    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_CROUCH)
    {
        if(!(IsACop(playerid) || IsFDMember(playerid) || IsAGov(playerid) || IsADoC(playerid)))
            return 1;

        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return 1;

        if(!IsInStateVehicle(playerid))
            return 1;

        if(BlinkerEnabled[playerid])
        {
            // Turn off blinkers
            new panels, doors, lights, tires;
            new carid = GetPlayerVehicleID(playerid);
            GetVehicleDamageStatus(carid, panels, doors, lights, tires);
            lights = encode_lights(0, 0, 0, 0);
            UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);

            FlashCounter[carid] = 0;
        }
        BlinkerEnabled[playerid] = !BlinkerEnabled[playerid]; // toggle
    }
    return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{
    BlinkerEnabled[playerid] = false;
    return 1;
}
