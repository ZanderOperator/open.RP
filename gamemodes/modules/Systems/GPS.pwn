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

const MAX_GPS_LOCATIONS = 80;

/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

enum PLAYER_GPS_DATA
{
    gGPSID,
    Float:gX,
    Float:gY,
    Float:gZ
};

enum ENUM_GPS_DATA
{
    gpsExists,
    gpsID,
    Float:gpsPosX,
    Float:gpsPosY,
    Float:gpsPosZ,
    gpsName[32],
    gpsMapIcon,
    gpsAdmin
};

static
    GPS_data[MAX_GPS_LOCATIONS][ENUM_GPS_DATA],
    GPSInfo[MAX_PLAYERS][PLAYER_GPS_DATA],
    GPSToList[MAX_PLAYERS][MAX_GPS_LOCATIONS],
    PlayerText:gps_Meters[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    bool:GPSActivated[MAX_PLAYERS] = {false, ...},
    GPS_PortPlayer[MAX_PLAYERS],
    Iterator:GPS_location<MAX_GPS_LOCATIONS>;


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

bool:Player_GpsActivated(playerid)
{
    return GPSActivated[playerid];
}

Player_SetGpsActivated(playerid, bool:v)
{
    GPSActivated[playerid] = v;
}

static GPS_Load()
{
    Iter_Clear(GPS_location);
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM gps"), 
        "GPS_Loaded", 
        ""
   );
    return 1;
}

forward GPS_Loaded();
public GPS_Loaded()
{
    new rows = cache_num_rows();
    if(!rows) 
        return print("MySQL Report: There are no GPS Locations in database to load!");

    for (new i = 0; i < rows; i++)
    {
        GPS_data[i][gpsExists] = true;

        cache_get_value_name_int  (i,    "id"        ,    GPS_data[i][gpsID]);
        cache_get_value_name      (i,    "gpsName"   ,    GPS_data[i][gpsName], 32);
        cache_get_value_name_float(i,    "gpsPosX"   ,    GPS_data[i][gpsPosX]);
        cache_get_value_name_float(i,    "gpsPosY"   ,    GPS_data[i][gpsPosY]);
        cache_get_value_name_float(i,    "gpsPosZ"   ,    GPS_data[i][gpsPosZ]);
        cache_get_value_name_int  (i,    "gpsMapIcon",    GPS_data[i][gpsMapIcon]);
        cache_get_value_name_int  (i,    "admin_gps" ,    GPS_data[i][gpsAdmin]);

        Iter_Add(GPS_location, i);
    }
    printf("MySQL Report: GPS Locations Loaded. [%d/%d]", Iter_Count(GPS_location), MAX_GPS_LOCATIONS);
    return 1;
}

static GPS_Save(gpsid)
{
    mysql_fquery(g_SQL, 
        "UPDATE gps SET gpsName = '%e', gpsPosX = '%.4f', gpsPosY = '%.4f', gpsPosZ = '%.4f',\n\
            gpsMapIcon = '%d', admin_gps = '%d' WHERE id = '%d'",
        GPS_data[gpsid][gpsName],
        GPS_data[gpsid][gpsPosX],
        GPS_data[gpsid][gpsPosY],
        GPS_data[gpsid][gpsPosZ],
        GPS_data[gpsid][gpsMapIcon],
        GPS_data[gpsid][gpsAdmin],
        GPS_data[gpsid][gpsID]
   );
    return 1;
}

static GPS_Create(gps_name[], Float:X, Float:Y, Float:Z)
{
    new 
        free_id = Iter_Free(GPS_location);
    if(free_id == -1)
        return -1;

    GPS_data[free_id][gpsExists] = true;
    GPS_data[free_id][gpsPosX]   = X;
    GPS_data[free_id][gpsPosY]   = Y;
    GPS_data[free_id][gpsPosZ]   = Z;
    GPS_data[free_id][gpsMapIcon]  = -1;
    GPS_data[free_id][gpsAdmin]    = 0;

    strcpy(GPS_data[free_id][gpsName], gps_name);
    mysql_tquery(g_SQL, 
        "INSERT INTO gps (gpsCreated) VALUES(1)", 
        "GPS_Created", 
        "i", 
        free_id
   );
    return free_id;
}

forward GPS_Created(gps_id);
public GPS_Created(gps_id)
{
    if(gps_id == -1 || !GPS_data[gps_id][gpsExists])
        return 1;

    GPS_data[gps_id][gpsID] = cache_insert_id();
    Iter_Add(GPS_location, gps_id);

    GPS_Save(gps_id);
    return 1;
}

static GPS_Delete(gpsid)
{
    foreach(new i : Player)
    {
        if(GPS_data[gpsid][gpsMapIcon] != -1)
            RemovePlayerMapIcon(gpsid, GPS_data[i][gpsMapIcon]);
    }

    mysql_fquery(g_SQL, "DELETE FROM gps WHERE id = '%d'", GPS_data[gpsid][gpsID]);

    strcpy(GPS_data[gpsid][gpsName], "None");
    GPS_data[gpsid][gpsMapIcon] = -1;
    GPS_data[gpsid][gpsExists] = false;
    GPS_data[gpsid][gpsID] = 0;
    Iter_Remove(GPS_location, gpsid);
    return 1;
}

static GPS_Disable(playerid)
{
    if(Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        GPS_DistanceTD(playerid, bool:false);
        Player_SetGpsActivated(playerid, false);

        foreach(new i : GPS_location)
        {
            if(GPS_data[i][gpsMapIcon] != -1)
                RemovePlayerMapIcon(playerid, GPS_data[i][gpsMapIcon]);
            GPS_ResetList(playerid);
        }
    }
    return 1;
}

static GPS_ResetList(playerid)
{
    for (new i = 0; i < MAX_GPS_LOCATIONS; i++)
    {
        GPSToList[playerid][i] = -1;
    }
    return 1;
}

static GPS_DistanceTD(playerid, bool:show)
{
    if(show)
    {
        gps_Meters[playerid] = CreatePlayerTextDraw(playerid, 321.333984, 410.838531, "");
        PlayerTextDrawLetterSize(playerid, gps_Meters[playerid], 0.123666, 1.110517);
        PlayerTextDrawAlignment(playerid, gps_Meters[playerid], 2);
        PlayerTextDrawColor(playerid, gps_Meters[playerid], -1);
        PlayerTextDrawSetShadow(playerid, gps_Meters[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, gps_Meters[playerid], 255);
        PlayerTextDrawFont(playerid, gps_Meters[playerid], 2);
        PlayerTextDrawSetProportional(playerid, gps_Meters[playerid], 1);
        PlayerTextDrawSetShadow(playerid, gps_Meters[playerid], 0);
        PlayerTextDrawShow(playerid, gps_Meters[playerid]);
    }
    else
    {
        PlayerTextDrawHide(playerid, gps_Meters[playerid]);
        PlayerTextDrawDestroy(playerid, gps_Meters[playerid]);
        gps_Meters[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

static GPS_GetDistance(playerid, gpsid, Float:X, Float:Y, Float:Z)
{
    if(!Player_GpsActivated(playerid))
        GPS_DistanceTD(playerid, false);
    
    new 
        Float:gpsLocation = GetPlayerDistanceFromPoint(playerid, X, Y, Z), 
        buffer[64];

    format(buffer, sizeof(buffer), 
        "~w~(GPS)_~y~%s - %0.2f_meters...", 
        GPS_data[gpsid][gpsName], 
        gpsLocation
   );
    PlayerTextDrawSetString(playerid, gps_Meters[playerid], buffer);
    return 1;
}

ptask NavigationTimer[1000](playerid)
{
    if(!SafeSpawned[playerid] || !Player_GpsActivated(playerid))
        return 1;

    GPS_GetDistance(playerid, 
        GPSInfo[playerid][gGPSID], 
        GPSInfo[playerid][gX], 
        GPSInfo[playerid][gY], 
        GPSInfo[playerid][gZ]
   );
    return 1;
}

GPS_DialogShow(playerid, bool:admin = false)
{
    new
        motd[44],
        buff[44 * MAX_GPS_LOCATIONS],
        counter = 0;

    foreach(new i : GPS_location)
    {
        if(i == 0)
            format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
        else
            format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);

        strcat(buff, motd);
        GPSToList[playerid][counter] = i;
        counter++;
    }

    if(admin)
    {
        ShowPlayerDialog(playerid, 
            DIALOG_ALOCATIONSGPS, 
            DIALOG_STYLE_LIST, 
            "{3C95C2}* PORT - LOCATIONS", 
            buff, 
            "Port", 
            "Close"
       );
    }
    else
    {
        ShowPlayerDialog(playerid, 
            DIALOG_LOCATIONSGPS, 
            DIALOG_STYLE_LIST, 
            "{3C95C2}* GPS", 
            buff, 
            "Pick", 
            "Exit"
       );
    }
    return 1;
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

hook function LoadServerData()
{
    GPS_Load();
	return continue();
}

hook function ResetPlayerVariables(playerid)
{
    GPS_Disable(playerid);
    GPS_PortPlayer[playerid] = INVALID_PLAYER_ID;
    return continue(playerid);
}

hook OnPlayerSpawn(playerid)
{
    foreach(new i : GPS_location)
    {
        if(GPS_data[i][gpsMapIcon] != -1)
        {
            SetPlayerMapIcon(playerid, 
                GPS_data[i][gpsID],     
                GPS_data[i][gpsPosX], 
                GPS_data[i][gpsPosY], 
                GPS_data[i][gpsPosZ], 
                GPS_data[i][gpsMapIcon], 
                0, 
                MAPICON_LOCAL
           );
        }
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        GPS_DistanceTD(playerid, false);
        Player_SetGpsActivated(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "You have reached your destination!");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch (dialogid)
    {
        case DIALOG_CREATEGPS:
        {
            if(strlen(inputtext) < 3 || strlen(inputtext) > 32)
            {
                ShowPlayerDialog(playerid, 
                    DIALOG_CREATEGPS, 
                    DIALOG_STYLE_INPUT, 
                    "{3C95C2}* Create GPS.", 
                    "\nPlease input location name that'll be shown on /gps.\n\
                        {3C95C2}[!]: Location name can't be longer than 32 chars.",
                    "Create", 
                    "Close"
               );
                return 1;
            }

            new 
                free_id = -1, 
                Float:X, 
                Float:Y, 
                Float:Z, 
                gpsname[32];

            GetPlayerPos(playerid, X, Y, Z);
            strcpy(gpsname, inputtext);
            free_id = GPS_Create(gpsname, X, Y, Z);
            if(free_id == -1)
            {
                va_SendMessage(playerid, 
                    MESSAGE_TYPE_ERROR, 
                    "Maximum number of GPS locations reached (%d)!",
                    MAX_GPS_LOCATIONS
               );
                return 1;
            }

            SendAdminMessage(COLOR_RED, 
                "AdmCMD: %s created new GPS Location: %s [ID %d].",
                gpsname,
                free_id
           );
            va_SendMessage(playerid, 
                MESSAGE_TYPE_SUCCESS, 
                "You have sucessfully created new GPS Location: %s - ID %d.",
                gpsname, 
                free_id
           );
            return 1;
        }
        case DIALOG_DELETEGPS:
        {
            new 
                gpsid = strval(inputtext);
            if(!Iter_Contains(GPS_location, gpsid))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "That GPS ID doesn't exist!");
                return 1;
            }

            SendAdminMessage(COLOR_RED, 
                "AdmCMD: %s deleted GPS Location: %s [ID %d].",
                GPS_data[gpsid][gpsName],
                gpsid
           );
            va_SendMessage(playerid, 
                MESSAGE_TYPE_SUCCESS, 
                "You have sucessfully deleted GPS Location: %s - ID %d.",                
                GPS_data[gpsid][gpsName],
                gpsid
           );
            GPS_Delete(gpsid);
            return 1;
        }
        case DIALOG_LOCATIONSGPS:
        {
            new 
                enum_id = GPSToList[playerid][listitem];
            Player_SetGpsActivated(playerid, true);
            GPS_DistanceTD(playerid, true);

            GPSInfo[playerid][gGPSID] = enum_id;
            GPSInfo[playerid][gX] = GPS_data[enum_id][gpsPosX];
            GPSInfo[playerid][gY] = GPS_data[enum_id][gpsPosY];
            GPSInfo[playerid][gZ] = GPS_data[enum_id][gpsPosZ];

            SetPlayerCheckpoint(playerid, 
                GPS_data[enum_id][gpsPosX], 
                GPS_data[enum_id][gpsPosY], 
                GPS_data[enum_id][gpsPosZ], 
                5.0
           );
            va_SendMessage(playerid, 
                MESSAGE_TYPE_SUCCESS, 
                "GPS on location %s sucessfully marked on radar.", 
                GPS_data[enum_id][gpsName]
           );
            GPS_ResetList(playerid);
            return 1;
        }
        case DIALOG_ALOCATIONSGPS:
        {
            new 
                portedid = GPS_PortPlayer[playerid];
            if(portedid == INVALID_PLAYER_ID)
                portedid = playerid;
            
            if(!IsPlayerInAnyVehicle(portedid))
                SetPlayerPosEx(portedid, GPS_data[listitem][gpsPosX], GPS_data[listitem][gpsPosY], GPS_data[listitem][gpsPosZ]);
            
            if(GetPlayerState(portedid) == PLAYER_STATE_DRIVER)
                AC_SetVehiclePos(GetPlayerVehicleID(portedid), GPS_data[listitem][gpsPosX], GPS_data[listitem][gpsPosY], GPS_data[listitem][gpsPosZ]);
                        
            if(portedid != playerid)
            {		        
                SendAdminMessage(COLOR_RED, 
                    "AdmCMD: %s has teleported %s on location %s.", 
                    GetName(playerid,false), 
                    GetName(portedid,false),
                    GPS_data[listitem][gpsName]
               );
            }
            va_SendMessage(portedid, 
                MESSAGE_TYPE_SUCCESS, 
                "You have been teleported to %s.", 
                GPS_data[listitem][gpsName]
           );
            return 1;
        }
        case DIALOG_GPSMAPICON:
        {
            new 
                gpsid, 
                mapicon;
            if(sscanf(inputtext, "ii", gpsid, mapicon))
            {
                ShowPlayerDialog(playerid, 
                    DIALOG_GPSMAPICON, 
                    DIALOG_STYLE_INPUT, 
                    "{3C95C2}* Map Icon GPS.", 
                    "\nPlease input GPS ID(/gps) and Map Icon ID. \n\
                        {3C95C2}[!] EXAMPLE: 1(GPS ID) 56(Map Icon) \n\
                        Please input -1 if you want to remove Map Icon from GPS.", 
                    "Input", 
                    "Close"
               );
                return 1;
            }
            if(!Iter_Contains(GPS_location, gpsid))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "That GPS ID doesn't exist!");
                return 1;
            }

            GPS_data[gpsid][gpsMapIcon] = mapicon;
            GPS_Save(gpsid);

            if(mapicon != -1)
            {
                foreach(new i: Player)
                    SetPlayerMapIcon(i, GPS_data[gpsid][gpsID], GPS_data[gpsid][gpsPosX], GPS_data[gpsid][gpsPosY], GPS_data[gpsid][gpsPosZ], GPS_data[gpsid][gpsMapIcon], 0, MAPICON_LOCAL);
                
                va_SendMessage(playerid,
                    MESSAGE_TYPE_SUCCESS,
                    "You have sucessfully set Map Icon ID %d on location %s.", 
                    mapicon,
                    GPS_data[gpsid][gpsName]
               );
            }
            else
            {
                foreach(new i: Player)
                    RemovePlayerMapIcon(playerid, GPS_data[gpsid][gpsID]);

                va_SendMessage(playerid,
                    MESSAGE_TYPE_SUCCESS,
                    "You have sucessfully removed Map Icon on location %s.", 
                    mapicon,
                    GPS_data[gpsid][gpsName]
               );
            }
            return 1;
        }
        case DIALOG_MOVEGPS:
        {
            new gpsid = strval(inputtext);
            if(!Iter_Contains(GPS_location, gpsid))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "That GPS ID doesn't exist!");            
                return 1;
            }
            new 
                Float:X, 
                Float:Y, 
                Float:Z;

            GetPlayerPos(playerid, X, Y, Z);
            GPS_data[gpsid][gpsPosX] = X;
            GPS_data[gpsid][gpsPosY] = Y;
            GPS_data[gpsid][gpsPosZ] = Z;
            GPS_Save(gpsid);

            va_SendMessage(playerid,
                MESSAGE_TYPE_SUCCESS,
                "You have sucessfully changed position of GPS location %s.",
                GPS_data[gpsid][gpsName]
           );
            return 1;
        }
    }
    return 0;
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

CMD:gps(playerid, params[])
{
    if(Player_IsWorkingJob(playerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't use GPS while you work!");
        return 1;
    }
    if(Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        GPS_DistanceTD(playerid, bool:false);
        Player_SetGpsActivated(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "You have deactivated GPS from your radar.");
        return 1;
    }
    GPS_DialogShow(playerid);
    return 1;
}

CMD:portplayer(playerid, params[])
{
	new 
        giveplayerid;

	if(PlayerInfo[playerid][pAdmin] < 1) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not Game Admin 1+!");
	if(sscanf(params, "u", giveplayerid))
	 	return SendClientMessage(playerid, COLOR_RED, "[?]: /portplayer [playerid / Part of name]");
	if(IsPlayerConnected(playerid))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That player ID isn't connected!");
    
    GPS_PortPlayer[playerid] = giveplayerid;
    GPS_DialogShow(playerid, true);

    va_SendMessage(playerid,
        MESSAGE_TYPE_INFO, 
        "You chose to teleport %s. Please pick a location.", 
        GetName(giveplayerid, false)
   );
	return 1;
}

CMD:port(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
        return 1;
    }
    GPS_PortPlayer[playerid] = INVALID_PLAYER_ID;
    GPS_DialogShow(playerid, true);
    return 1;
}

CMD:agps(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1337)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
        return 1;
    }
    new 
        action[15];
    if(sscanf(params, "s[15] ", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[!] /agps [option].");
        SendClientMessage(playerid, -1, "OPTS: create, delete, setadmin, mapicon, goto, move, rename.");
        return 1;
    }
    if(!strcmp(action, "create", true))
    {
        ShowPlayerDialog(playerid, 
            DIALOG_CREATEGPS, 
            DIALOG_STYLE_INPUT, 
            "{3C95C2}* Create GPS.", 
            "\nPlease input location name that'll be shown on /gps.\n\
                {3C95C2}[!]: Location name can't be longer than 32 chars.",
            "Create", 
            "Close"
       );
    }
    if(!strcmp(action, "move", true))
    {
        ShowPlayerDialog(playerid, 
            DIALOG_MOVEGPS, 
            DIALOG_STYLE_INPUT, 
            "{3C95C2}* Move GPS.", 
            "\nPlease enter GPS ID of location that you want to relocate. \n\
                {3C95C2}[!]: List of all GPS ID's can be found on /agps goto.", 
            "Move", 
            "Close"
        );
        return 1;
    }
    if(!strcmp(action, "goto", true))
    {
        GPS_PortPlayer[playerid] = INVALID_PLAYER_ID;
        GPS_DialogShow(playerid, true);
        return 1;
    }
    if(!strcmp(action, "setadmin", true))
    {
        new 
            gpsid, adminloc;
        if(sscanf(params, "s[15]ii", action, gpsid, adminloc))
        {
            SendClientMessage(playerid, 
                COLOR_RED, 
                "[!] /agps setadmin [gpsid] \n\
                    [0 = for all players | 1 = only for Team Staff]"
               );
            return 1;
        }
        if(!Iter_Contains(GPS_location, gpsid))
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That GPS ID doesn't exist!");

        if(adminloc < 0 || adminloc > 1)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Location status can be only 1 or 0!");

        GPS_data[gpsid][gpsAdmin] = adminloc;
        GPS_Save(gpsid);

        va_SendMessage(playerid, 
            MESSAGE_TYPE_SUCCESS, 
            "You have sucessfully set GPS location %s[ID: %d] available %s.", 
            GPS_data[gpsid][gpsName], 
            gpsid,
            (!adminloc) ? ("for everyone") : ("for Team Staff only")
       );
    }
    if(!strcmp(action, "mapicon", true))
    {
       ShowPlayerDialog(playerid, 
            DIALOG_GPSMAPICON, 
            DIALOG_STYLE_INPUT, 
            "{3C95C2}* Map Icon GPS.", 
            "\nPlease input GPS ID(/gps) and Map Icon ID. \n\
                {3C95C2}[!] EXAMPLE: 1(GPS ID) 56(Map Icon) \n\
                Please input -1 if you want to remove Map Icon from GPS.", 
            "Input", 
            "Close"
       );
    }
    if(!strcmp(action, "delete", true))
    {
        ShowPlayerDialog(playerid, 
            DIALOG_DELETEGPS, 
            DIALOG_STYLE_INPUT, 
            "{3C95C2}* Delete GPS.", 
            "\nPlease input GPS ID you wish to delete from /gps.\n\
                {3C95C2}[!]: You can find all GPS ID's on /agps goto(/port).", 
            "Delete", 
            "Close"
       );
    }
    return 1;
}
