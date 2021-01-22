
#if defined MODULE_SIREN
    #endinput
#endif
#define MODULE_SIREN

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

enum E_SIRENS_INFO
{
    SirenForModel,
    Float:SPosX,
    Float:SPosY,
    Float:SPosZ
}

static const g_SirenPresets[][E_SIRENS_INFO] =
{
    {596, 0.0, -1.75, 0.35}, //LSPD
    {598, 0.0, -1.5, 0.35}, //LVPD
    {490, -0.5, 0.5, 1.15}, //FBI RANCHER
    {560, 0.000000, -1.400000, 0.399999}, //SULTAN
    {426, 0.000000, -1.700000, 0.400000}, //PREMIER
    {402, -0.000000, -1.800000, 0.299999}, //BUFFALO
    {597, 0.0, -1.75, 0.35}, //SFPD
    {544, 0.0, 2.850001, 1.500000}, //FIRETRUCK LADDER
    {416, 0.0, -3.525001, 1.350000} //AMBULANCE
};


enum E_ABOVESIREN_INFO
{
    SirenForAbove,
    Float:APosX,
    Float:APosY,
    Float:APosZ
}

static const g_AbovePresets[][E_ABOVESIREN_INFO] =
{
    {596, 0.000000, -0.399999, 0.899999}, //LSPD
    {598, 0.000000, -0.300000, 0.900000}, //LVPD
    {599, 0.000000, 1.100000, 0.000000}, //FBI RANCHER
    {490, 0.799999, 0.200000, 0.899999},
    {597, 0.000000, -0.399999, 0.900000}, //SFPD
    {560, 0.500000, 0.100000, 0.870000}, //SULTAN
    {402, 0.400000, -0.500000, 0.819999}, //BUFFALO
    {541, 0.400000, -0.000000, 0.700000}, //BULLET
    {415, 0.400000, -0.399999, 0.700000}, //CHEETAH
    {405, 0.400000, 0.700000, 0.300000}, //SENTINEL
    {579, 0.600000, 0.500000, 0.700000}, //HUNTLEY
    {426, 0.600000, -0.100000, 0.920000}, //PREMIER
    {407, -0.0, -3.01, 1.350000} //FIRETRUCK
};

static SirenObject[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

DestroyVehicleSiren(vehicleid)
{
	if(SirenObject[vehicleid] != INVALID_OBJECT_ID ) 
    {
		DestroyDynamicObject(SirenObject[vehicleid]);
		SirenObject[vehicleid] = INVALID_OBJECT_ID;
	}
	return 1;
}

hook function ResetVehicleInfo(vehicleid)
{
    DestroyVehicleSiren(vehicleid);
    return continue(vehicleid);
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

CMD:siren(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid) && !IsAGov(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni.");
        return 1;
    }

    new
        type[7],
        vehicleid = GetPlayerVehicleID(playerid);

    if(sscanf(params, "s[7]", type))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /siren [opcija]");
        SendClientMessage(playerid, COLOR_RED, "[!] front, rear, above, off");
        return 1;
    }

    if(vehicleid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Niste u vozilu.");
        return 1;
    }

    // TODO: YSI YHash instead of strcmp
    if(strcmp(type, "front", true) == 0)
    {
        if(SirenObject[vehicleid] != INVALID_OBJECT_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Na ovom vozilu je vec postavljena sirena!");

        // TODO: helper function, AttachSirenToVehicle(vehicleid, siren_type)
        SirenObject[vehicleid] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0, -1, -1, -1, 50.0);
        AttachDynamicObjectToVehicle(SirenObject[vehicleid], vehicleid, 0.0, 0.75, 0.275, 0.0, 0.1, 0.0);
        GameTextForPlayer(playerid, "~g~SIRENA JE UKLJUCENA", 3000, 4);
    }
    if(strcmp(type, "rear", true) == 0)
    {
        if(SirenObject[vehicleid] != INVALID_OBJECT_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Na ovom vozilu je vec postavljena sirena!");

        // TODO: helper function, AttachSirenToVehicle(vehicleid, siren_type)
        new
            model = GetVehicleModel(vehicleid),
            preset = -1;
        for (new i = 0; i < sizeof(g_SirenPresets); i++)
        {
            if(model == g_SirenPresets[i][SirenForModel])
            {
                preset = i;
            }
        }
        if(preset == -1) return SendClientMessage(playerid, COLOR_RED, "SERVER: Sirene nisu kompatibilne sa vozilom!");

        SirenObject[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 20.0);
        AttachDynamicObjectToVehicle(SirenObject[vehicleid], vehicleid, g_SirenPresets[preset][SPosX], g_SirenPresets[preset][SPosY], g_SirenPresets[preset][SPosZ], 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, "~g~SIRENA JE UKLJUCENA", 3000, 4);
    }
    if(strcmp(type, "above", true) == 0)
    {
        if(SirenObject[vehicleid] != INVALID_OBJECT_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Na ovom vozilu je vec postavljena sirena!");

        // TODO: helper function, AttachSirenToVehicle(vehicleid, siren_type)
        new
            model = GetVehicleModel(vehicleid),
            preset = -1;
        for (new i = 0; i < sizeof(g_AbovePresets); i++)
        {
            if(model == g_AbovePresets[i][SirenForAbove])
            {
                preset = i;
            }
        }
        if(preset == -1) return SendClientMessage(playerid, COLOR_RED, "SERVER: Sirene nisu kompatibilne sa vozilom!");

        SirenObject[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 20.0);
        AttachDynamicObjectToVehicle(SirenObject[vehicleid], vehicleid, g_AbovePresets[preset][APosX], g_AbovePresets[preset][APosY], g_AbovePresets[preset][APosZ], 0.0, 0.0, 0.0);
        GameTextForPlayer(playerid, "~g~SIRENA JE UKLJUCENA", 3000, 4);
    }
    if(strcmp(type, "off", true) == 0)
    {
        if(SirenObject[vehicleid] == INVALID_OBJECT_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nema ugradjene sirene u ovom vozilu!");

        // TODO: helper function, DestroyVehicleSiren(vehicleid)
        DestroyDynamicObject(SirenObject[vehicleid]);
        SirenObject[vehicleid] = INVALID_OBJECT_ID;
    }

    return 1;
}
