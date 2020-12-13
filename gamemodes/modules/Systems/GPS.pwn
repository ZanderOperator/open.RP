/*
*            GPS System
*    www.cityofangels-roleplay.com
*       created and coded by L3o.
*         All rights reserved.
*              (c) 2019
*/

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

#define MAX_GPS_LOCATIONS       (80)
#define PLAYER_NEARBY_LOCATION  (10.0)


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
    Float:gpsPos[3],
    gpsName[32],
    gpsMapIcon,
    gpsAdmin
};

enum
{
    DIALOG_CREATEGPS    =   4000,
    DIALOG_DELETEGPS,
    DIALOG_LOCATIONSGPS,
    DIALOG_ALOCATIONSGPS,
    DIALOG_GPSMAPICON,
    DIALOG_MOVEGPS
}

new
    GPS_data[MAX_GPS_LOCATIONS][ENUM_GPS_DATA],
    GPSInfo[MAX_PLAYERS][PLAYER_GPS_DATA],
    GPSToList[MAX_PLAYERS][MAX_GPS_LOCATIONS],

    PlayerText:gps_Meters[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},

    Iterator:GPS_location<MAX_GPS_LOCATIONS>;

static bool:GPSActivated[MAX_PLAYERS] = {false, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

stock bool:Player_GpsActivated(playerid)
{
    return GPSActivated[playerid];
}

stock Player_SetGpsActivated(playerid, bool:v)
{
    GPSActivated[playerid] = v;
}

// TODO: horrible naming, keep it consistent
forward on_GPScreate(gps_id);
public on_GPScreate(gps_id)
{
    if (gps_id == -1 || !GPS_data[gps_id][gpsExists])
        return 1;

    GPS_data[gps_id][gpsID] = cache_insert_id();
    Iter_Add(GPS_location, gps_id);

    GPS_Save(gps_id);
    return 1;
}

LoadGPS()
{
    Iter_Clear(GPS_location);
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM gps WHERE 1"), 
        "GPS_Load", 
        ""
    );
    return 1;
}

Public: GPS_Load()
{
    new rows = cache_num_rows();
    if (rows == 0) return 1;

    for (new i = 0; i < rows; i++)
    {
        GPS_data[i][gpsExists] = true;

        cache_get_value_name_int  (i,    "id"        ,    GPS_data[i][gpsID]);
        cache_get_value_name      (i,    "gpsName"   ,    GPS_data[i][gpsName], 32);
        cache_get_value_name_float(i,    "gpsPosX"   ,    GPS_data[i][gpsPos][0]);
        cache_get_value_name_float(i,    "gpsPosY"   ,    GPS_data[i][gpsPos][1]);
        cache_get_value_name_float(i,    "gpsPosZ"   ,    GPS_data[i][gpsPos][2]);
        cache_get_value_name_int  (i,    "gpsMapIcon",    GPS_data[i][gpsMapIcon]);
        cache_get_value_name_int  (i,    "admin_gps" ,    GPS_data[i][gpsAdmin]);

        Iter_Add(GPS_location, i);
    }
    printf("MySQL Report: GPS Locations Loaded: %d.", Iter_Count(GPS_location));
    return 1;
}

GPS_Save(gpsid)
{
    mysql_fquery(g_SQL, 
        "UPDATE gps SET gpsName = '%e', gpsPosX = '%.4f', gpsPosY = '%.4f', gpsPosZ = '%.4f',\n\
            gpsMapIcon = '%d', admin_gps = '%d' WHERE id = '%d'",
        GPS_data[gpsid][gpsName],
        GPS_data[gpsid][gpsPos][0],
        GPS_data[gpsid][gpsPos][1],
        GPS_data[gpsid][gpsPos][2],
        GPS_data[gpsid][gpsMapIcon],
        GPS_data[gpsid][gpsAdmin],
        GPS_data[gpsid][gpsID]
    );
    return 1;
}

Create_GPS(gps_name[], Float:X, Float:Y, Float:Z)
{
    new free_id = Iter_Free(GPS_location);
    GPS_data[free_id][gpsExists] = true;

    GPS_data[free_id][gpsPos][0]   = X;
    GPS_data[free_id][gpsPos][1]   = Y;
    GPS_data[free_id][gpsPos][2]   = Z;
    GPS_data[free_id][gpsMapIcon]  = -1;
    GPS_data[free_id][gpsAdmin]    = 0;

    SetString(GPS_data[free_id][gpsName], gps_name);
    mysql_tquery(g_SQL, 
        "INSERT INTO gps (gpsCreated) VALUES(1)", 
        "on_GPScreate", 
        "i", 
        free_id
    );
    return free_id;
}

Delete_GPS(gpsid)
{
    foreach(new i : Player)
    {
        if (GPS_data[gpsid][gpsMapIcon] != -1)
            RemovePlayerMapIcon(gpsid, GPS_data[i][gpsMapIcon]);
    }

    mysql_fquery(g_SQL, "DELETE FROM gps WHERE id = '%d'", GPS_data[gpsid][gpsID]);

    // TODO: SetString?! use strcpy
    SetString(GPS_data[gpsid][gpsName], "None");
    GPS_data[gpsid][gpsMapIcon] = -1;
    GPS_data[gpsid][gpsExists] = false;
    GPS_data[gpsid][gpsID] = 0;
    Iter_Remove(GPS_location, gpsid);
    return 1;
}

DisableGPS(playerid)
{
    if (Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        gps_DistanceTD(playerid, bool:false);
        Player_SetGpsActivated(playerid, false);

        foreach(new i : GPS_location)
        {
            if (GPS_data[i][gpsMapIcon] != -1)
            {
                RemovePlayerMapIcon(playerid, GPS_data[i][gpsMapIcon]);
            }
            ResetPlayerGPSList(playerid);
        }
    }
    return 1;
}

GPS_Active_Check(playerid)
{
    return Player_GpsActivated(playerid);
}

// TODO: delete
SetString(obj[], string[]) // credits samp
{
    strmid(obj, string, 0, strlen(string), 255);
    return 1;
}

ResetPlayerGPSList(playerid)
{
    for (new i = 0; i < MAX_GPS_LOCATIONS; i++)
    {
        GPSToList[playerid][i] = -1;
    }
    return 1;
}

gps_DistanceTD(playerid, bool:show)
{
    if (show)
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

Public:gps_GetDistance(playerid, gpsid, Float:X, Float:Y, Float:Z)
{
    if (Player_GpsActivated(playerid))
    {
        new Float:gpsLocation, buffer[64];
        gpsLocation = GetPlayerDistanceFromPoint(playerid, X, Y, Z);

        format(buffer, sizeof(buffer), "~w~(GPS)_~y~%s - %0.2f_meters...", GPS_data[gpsid][gpsName], gpsLocation);
        PlayerTextDrawSetString(playerid, gps_Meters[playerid], buffer);
    }
    else
    {
        gps_DistanceTD(playerid, false);
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

hook LoadServerData()
{
    LoadGPS();
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DisableGPS(playerid);
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    foreach(new i : GPS_location)
    {
        if (GPS_data[i][gpsMapIcon] != -1)
        {
            SetPlayerMapIcon(playerid, GPS_data[i][gpsID], GPS_data[i][gpsPos][0], GPS_data[i][gpsPos][1], GPS_data[i][gpsPos][2], GPS_data[i][gpsMapIcon], 0, MAPICON_LOCAL);
        }
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if (Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        gps_DistanceTD(playerid, false);
        Player_SetGpsActivated(playerid, false);

        GameTextForPlayer(playerid, "~g~Stigli ste na odrediste!", 1500, 1);
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (!response)
    {
        return 1;
    }

    switch (dialogid)
    {
        case DIALOG_CREATEGPS:
        {
            if (strlen(inputtext) < 3 || strlen(inputtext) > 24)
            {
                ShowPlayerDialog(playerid, DIALOG_CREATEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Create GPS.", "\nIspod morate unesti ime lokacije koja ce se nalazit na /gps.\n{3C95C2}[!]: Naziv mjesta ne smije biti duzi od 24 slova.","Create", "Close");
                return 1;
            }

            new free_id = -1, Float:X, Float:Y, Float:Z, gpsname[24];
            GetPlayerPos(playerid, X, Y, Z);
            strcpy(gpsname, inputtext);
            free_id = Create_GPS(gpsname, X, Y, Z);
            if (free_id == -1)
            {
                SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Na serveru je vec kreirano maximalan broj GPS lokacija.");
                return 1;
            }
            va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kreirali ste novu GPS lokaciju, naziv: %s - ID: %d.", gpsname, free_id);
            return 1;
        }
        case DIALOG_DELETEGPS:
        {
            new gpsid = strval(inputtext);
            if (!Iter_Contains(GPS_location, gpsid))
            {
                SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");
                return 1;
            }

            va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali lokaciju %s[ID: %d] sa GPS-a", GPS_data[gpsid][gpsName], gpsid);
            Delete_GPS(gpsid);
            return 1;
        }
        case DIALOG_LOCATIONSGPS:
        {
            new enum_id = GPSToList[playerid][listitem];
            Player_SetGpsActivated(playerid, true);
            gps_DistanceTD(playerid, true);

            GPSInfo[playerid][gGPSID] = enum_id;
            GPSInfo[playerid][gX] = GPS_data[enum_id][gpsPos][0];
            GPSInfo[playerid][gY] = GPS_data[enum_id][gpsPos][1];
            GPSInfo[playerid][gZ] = GPS_data[enum_id][gpsPos][2];

            SetPlayerCheckpoint(playerid, GPS_data[enum_id][gpsPos][0], GPS_data[enum_id][gpsPos][1], GPS_data[enum_id][gpsPos][2], 5.0);
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Na mapi vam je prikazana lokacija %s crvenim markerom.", GPS_data[enum_id][gpsName]);
            ResetPlayerGPSList(playerid);
            return 1;
        }
        case DIALOG_ALOCATIONSGPS:
        {
            if (!IsPlayerInAnyVehicle(playerid))
            {
                SetPlayerPosEx(playerid, GPS_data[listitem][gpsPos][0], GPS_data[listitem][gpsPos][1], GPS_data[listitem][gpsPos][2]);
            }
            if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                AC_SetVehiclePos(GetPlayerVehicleID(playerid), GPS_data[listitem][gpsPos][0], GPS_data[listitem][gpsPos][1], GPS_data[listitem][gpsPos][2]);
            }
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste portani do %s.", GPS_data[listitem][gpsName]);
            return 1;
        }
        case DIALOG_GPSMAPICON:
        {
            new gpsid, mapicon;
            if (sscanf(inputtext, "ii", gpsid, mapicon))
            {
                ShowPlayerDialog(playerid, DIALOG_GPSMAPICON, DIALOG_STYLE_INPUT, "{3C95C2}* Mapicon GPS.", "\nIspod morate unesti ID lokacije(/gps) i zeljeni id mapicon-a.\n{3C95C2}[!] Primjer: 1(gps id) 56(mapicon) -1(U slucaju da ne zelite mapicon).", "Input", "Close");
                return 1;
            }

            if (!Iter_Contains(GPS_location, gpsid))
            {
                SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");
                return 1;
            }

            GPS_data[gpsid][gpsMapIcon] = mapicon;
            va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste postavili/promjenili mapicon na lokaciji %s u ID %d.", GPS_data[gpsid][gpsName], mapicon);
            GPS_Save(gpsid);
            if (mapicon != -1)
            {
                foreach(new i: Player)
                    SetPlayerMapIcon(i, GPS_data[gpsid][gpsID], GPS_data[gpsid][gpsPos][0], GPS_data[gpsid][gpsPos][1], GPS_data[gpsid][gpsPos][2], GPS_data[gpsid][gpsMapIcon], 0, MAPICON_LOCAL);
            }
            else // -1 = Brisanje postojece map icone
            {
                foreach(new i: Player)
                    RemovePlayerMapIcon(playerid, GPS_data[gpsid][gpsID]);
            }
            return 1;
        }
        case DIALOG_MOVEGPS:
        {
            new gpsid = strval(inputtext);
            if (!Iter_Contains(GPS_location, gpsid))
            {
                SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");
                return 1;
            }

            new Float:X, Float:Y, Float:Z;
            GetPlayerPos(playerid, X, Y, Z);
            GPS_data[gpsid][gpsPos][0] = X;
            GPS_data[gpsid][gpsPos][1] = Y;
            GPS_data[gpsid][gpsPos][2] = Z;
            GPS_Save(gpsid);

            va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promjenili poziciju lokacije %s na vasu trenutnu.", GPS_data[gpsid][gpsName]);
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
    if (Player_IsWorkingJob(playerid))
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
        return 1;
    }

    if (Player_GpsActivated(playerid))
    {
        DisablePlayerCheckpoint(playerid);
        gps_DistanceTD(playerid, bool:false);
        Player_SetGpsActivated(playerid, false);

        SendClientMessage(playerid, COLOR_RED, "[ ! ] Deaktivirali ste stari GPS.");
        return 1;
    }

    new
        buff[MAX_GPS_LOCATIONS*32],
        motd[50],
        counter = 0;
    // TODO: this is repetitive code, extract it to a general helper function
    foreach(new i : GPS_location)
    {
        if (GPS_data[i][gpsAdmin] == 0)
        {
            if (i == 0)
                format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
            else
                format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
            strcat(buff, motd);
            GPSToList[playerid][counter] = i;
            counter++;
        }
    }
    ShowPlayerDialog(playerid, DIALOG_LOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* GPS", buff, "Pick", "Exit");
    return 1;
}

CMD:port(playerid, params[])
{
    new
        buff[MAX_GPS_LOCATIONS*32],
        motd[50],
        counter = 0;

    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2)
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
        return 1;
    }
    // TODO: this is repetitive code, extract it to a general helper function
    foreach(new i : GPS_location)
    {
        if (i == 0)
            format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
        else
            format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
        strcat(buff, motd);
        GPSToList[playerid][counter] = i;
        counter++;
    }
    ShowPlayerDialog(playerid, DIALOG_ALOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* PORT - LOCATIONS", buff, "Port", "Close");
    return 1;
}

CMD:agps(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337)
    {
        SendClientMessage(playerid,COLOR_RED, "Niste ovlasteni za koristenje ove komande.");
        return 1;
    }

    new action[15];
    if (sscanf(params, "s[15] ", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[ ! ] /agps [option].");
        SendClientMessage(playerid, 0xAFAFAFAA, "(options): create, delete, setadmin, mapicon, goto, move, rename.");
        return 1;
    }
    if (!strcmp(action, "create", true))
    {
        ShowPlayerDialog(playerid, DIALOG_CREATEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Create GPS.", "\nIspod morate unesti ime lokacije koja ce se nalazit na /gps.\n{3C95C2}[!]: Naziv mjesta ne smije biti duzi od 24 slova.", "Create", "Close");
        return 1;
    }
    if (!strcmp(action, "move", true))
    {
        ShowPlayerDialog(playerid, DIALOG_MOVEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Move GPS.", "\nIspod morate unesti id lokacije kojoj zelite promijeniti poziciju.\n{3C95C2}[!]: Listu lokacija mozete pronaci na /gps.", "Move", "Close");
        return 1;
    }
    if (!strcmp(action, "goto", true))
    {
        // TODO: this is repetitive code, extract it to a general helper function
        new
            buff[MAX_GPS_LOCATIONS*32],
            motd[50];
        foreach(new i : GPS_location)
        {
            if (i == 0)
                format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
            else
                format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", i, GPS_data[i][gpsName]);
            strcat(buff, motd);
        }
        ShowPlayerDialog(playerid, DIALOG_ALOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* GPS", buff, "Select", "Close");
        return 1;
    }
    if (!strcmp(action, "setadmin", true))
    {
        new gpsid, adminloc;
        if (sscanf(params, "s[15]ii", action, gpsid, adminloc))
        {
            SendClientMessage(playerid, COLOR_RED, "[ ! ] /agps setadmin [gpsid] [0 = za sve igrace | 1 = samo za /agps goto]");
            return 1;
        }
        if (!Iter_Contains(GPS_location, gpsid))
            return SendErrorMessage(playerid, "Krivi GPS ID! Koristite /agps goto da bi vidjeli sve GPS-ove.");

        if (adminloc < 0 || adminloc > 1)
            return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 0 ili veca od 1!");

        GPS_data[gpsid][gpsAdmin] = adminloc;
        GPS_Save(gpsid);
        if (adminloc)
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili vidljivost lokacije %s[ID: %d] samo za Team Staff.", GPS_data[gpsid][gpsName], gpsid);
        else
            SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili vidljivost lokacije %s[ID: %d] za sve.", GPS_data[gpsid][gpsName], gpsid);
        return 1;
    }
    if (!strcmp(action, "mapicon", true))
    {
        ShowPlayerDialog(playerid, DIALOG_GPSMAPICON, DIALOG_STYLE_INPUT, "{3C95C2}* Mapicon GPS.", "\nIspod morate unesti ID lokacije(/agps goto) i zeljeni ID mapicon-a.\n{3C95C2}[!] Format: [GPS ID] [mapicon ID - (56 - zuta tacka)/(-1 ako ne zelite map icon)].", "Input", "Close");
        return 1;
    }
    if (!strcmp(action, "delete", true))
    {
        ShowPlayerDialog(playerid, DIALOG_DELETEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Delete GPS.", "\nIspod morate unesti ID lokacije koja se nalazi na /gps.\n{3C95C2}[!]: Sve ID-ove lokacija mozete pronaci na /agps goto.", "Delete", "Close");
        return 1;
    }
    return 1;
}
