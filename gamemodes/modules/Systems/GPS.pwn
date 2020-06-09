/* 
*	 		 GPS System
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI\y_hooks>

/*
	- Defines & Enumerators
*/
#define MAX_GPS_LOCATIONS 		(80) 	
#define PLAYER_NEARBY_LOCATION 	(10.0)  

enum PLAYER_GPS_DATA 
{
	gGPSID,
	Float:gX,
	Float:gY,
	Float:gZ
};


enum ENUM_GPS_DATA {
	gpsExists,
	gpsID,
	Float:gpsPos[3],
	gpsName[32],
	gpsMapIcon,
	gpsAdmin
};

enum {
	DIALOG_CREATEGPS	=	4000,
	DIALOG_DELETEGPS,
	DIALOG_LOCATIONSGPS,
	DIALOG_ALOCATIONSGPS,
	DIALOG_GPSMAPICON,
	DIALOG_MOVEGPS
}

/*
	- vars & rBits
*/
new 
	GPS_data[MAX_GPS_LOCATIONS][ENUM_GPS_DATA],
	GPSInfo[MAX_PLAYERS][PLAYER_GPS_DATA],
	GPSToList[MAX_PLAYERS][MAX_GPS_LOCATIONS],
	
	gps_distance[MAX_PLAYERS] = {0, ...},
	PlayerText:gps_Meters[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	
	Iterator: GPS_location <MAX_GPS_LOCATIONS>,
	Bit1: gps_Activated	<MAX_PLAYERS> = Bit1: (false);

/*
	- mySQL
*/
forward on_GPScreate(gps_id);
public on_GPScreate(gps_id) {
	if (gps_id == -1 || !GPS_data[gps_id][gpsExists])
	    return (true);

	GPS_data[gps_id][gpsID] = cache_insert_id();
	Iter_Add(GPS_location, gps_id);
	
	GPS_Save(gps_id);
	return (true);
}

LoadGPS() 
{
	Iter_Clear(GPS_location);
	mysql_tquery(g_SQL, "SELECT * FROM `gps`", "GPS_Load", "");
	return (true);
}

forward GPS_Load();
public GPS_Load()
{
	new 
		rows = cache_num_rows();
	if(rows == 0) return (true);
	for (new i = 0; i < rows; i++)
	{
		GPS_data[i][gpsExists] = true;

		cache_get_value_name_int(i, "id", GPS_data[i][gpsID]);
		cache_get_value_name(i, "gpsName", GPS_data[i][gpsName], 32);
		cache_get_value_name_float(i, "gpsPosX", GPS_data[i][gpsPos][0]);
		cache_get_value_name_float(i, "gpsPosY", GPS_data[i][gpsPos][1]);
		cache_get_value_name_float(i, "gpsPosZ", GPS_data[i][gpsPos][2]);
		cache_get_value_name_int(i, "gpsMapIcon", GPS_data[i][gpsMapIcon]);
		cache_get_value_name_int(i, "admin_gps", GPS_data[i][gpsAdmin]);

		Iter_Add(GPS_location, i);
	}
	printf("MySQL Report: GPS Locations Loaded: %d.", Iter_Count(GPS_location));
	return (true);
}

GPS_Save(gpsid) {
	new query[ 256 ];	
	format( query, 256, "UPDATE `gps` SET `gpsName` = '%s', `gpsPosX` = '%.4f', `gpsPosY` = '%.4f', `gpsPosZ` = '%.4f', `gpsMapIcon` = '%d', `admin_gps` = '%d' WHERE `id` = '%d'",
		GPS_data[gpsid][gpsName],
		GPS_data[gpsid][gpsPos][0],
		GPS_data[gpsid][gpsPos][1],
		GPS_data[gpsid][gpsPos][2],
		GPS_data[gpsid][gpsMapIcon],
		GPS_data[gpsid][gpsAdmin],
		GPS_data[gpsid][gpsID]
	);
	mysql_tquery(g_SQL, query, "");
	return (true);
}

Create_GPS(gps_name[], Float:X, Float:Y, Float:Z)
{
	new free_id = Iter_Free(GPS_location);
	GPS_data[free_id][gpsExists] = true;

	GPS_data[free_id][gpsPos][0] = X;
	GPS_data[free_id][gpsPos][1] = Y;
	GPS_data[free_id][gpsPos][2] = Z;
	GPS_data[free_id][gpsMapIcon] = -1;
	GPS_data[free_id][gpsAdmin] = 0;

	SetString(GPS_data[free_id][gpsName], gps_name);
	mysql_tquery(g_SQL, "INSERT INTO `gps` (`gpsCreated`) VALUES(1)", "on_GPScreate", "d", free_id);
	return free_id;
}

Delete_GPS(gpsid) {	
	foreach(new i: Player) {
		if(GPS_data[gpsid][gpsMapIcon] != -1)
			RemovePlayerMapIcon(gpsid, GPS_data[i][gpsMapIcon]);
	}
	new query[64];
	format(query, sizeof(query), "DELETE FROM `gps` WHERE `id` = '%d'", GPS_data[gpsid][gpsID]);
	mysql_tquery(g_SQL, query);
	
	SetString(GPS_data[gpsid][gpsName], "None");
	GPS_data[gpsid][gpsMapIcon] = -1;
	GPS_data[gpsid][gpsExists] = false;
	GPS_data[gpsid][gpsID] = 0;
	Iter_Remove(GPS_location, gpsid);
	return (true);
}

DisableGPS(playerid) {
	if(Bit1_Get(gps_Activated, playerid)) {
		Bit1_Set(gps_Activated, playerid, false);
		DisablePlayerCheckpoint(playerid);
		gps_DistanceTD(playerid, bool:false);
		foreach(new i: GPS_location)
		{
			if(GPS_data[i][gpsMapIcon] != -1)
				RemovePlayerMapIcon(playerid, GPS_data[i][gpsMapIcon]);
			ResetPlayerGPSList(playerid);
		}
	}
	return (true);
}

/*
	- functions
*/

SetString(obj[], string[]) // credits samp
{
    strmid(obj, string, 0, strlen(string), 255);
    return (true);
}

ResetPlayerGPSList(playerid) {
	for(new i=0; i < MAX_GPS_LOCATIONS; i++)
		GPSToList[playerid][i] = -1;
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (distance sustav)
gps_DistanceTD(playerid, bool:status)
{	
	if(status == false) {
		PlayerTextDrawHide(playerid, gps_Meters[playerid]);
		PlayerTextDrawDestroy(playerid, gps_Meters[playerid]);
		gps_Meters[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	else if(status == true) {
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
	return (true);
}

Function: gps_GetDistance(playerid, gpsid, Float:X, Float:Y, Float:Z) {
	if(Bit1_Get(gps_Activated, playerid)) {
		new Float:gpsLocation, buffer[64];
		gpsLocation = GetPlayerDistanceFromPoint(playerid, X, Y, Z);

		format(buffer,sizeof(buffer),"~w~(GPS)_~y~%s - %0.2f_meters...", GPS_data[gpsid][gpsName], gpsLocation);
	    PlayerTextDrawSetString(playerid, gps_Meters[playerid], buffer);
	}
	else if(!Bit1_Get(gps_Activated, playerid)) {
		KillTimer(gps_distance[playerid]);
		gps_DistanceTD(playerid, false);
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hooks)

hook OnPlayerDisconnect(playerid, reason) {
	DisableGPS(playerid);
	return (true);
}

hook OnPlayerSpawn(playerid) {
	foreach(new i: GPS_location) {
		if(GPS_data[i][gpsMapIcon] != -1)
			SetPlayerMapIcon(playerid, GPS_data[i][gpsID], GPS_data[i][gpsPos][0], GPS_data[i][gpsPos][1], GPS_data[i][gpsPos][2], GPS_data[i][gpsMapIcon], 0, MAPICON_LOCAL);
	}
	return (true);
}

hook OnPlayerEnterCheckpoint(playerid) {
	if(Bit1_Get(gps_Activated, playerid))  {
		Bit1_Set(gps_Activated, playerid, false);
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "~g~Stigli ste na odrediste!", 1500, 1);
		KillTimer(gps_distance[playerid]);
		gps_DistanceTD(playerid, false);
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
	    case DIALOG_CREATEGPS: {
	    	if(response) {
				new free_id = -1, Float:X, Float:Y, Float:Z, gpsname[24];
	        	
	        	if(strlen(inputtext) < 3 || strlen(inputtext) > 24) 
	        		return ShowPlayerDialog(playerid, DIALOG_CREATEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Create GPS.", "\nIspod morate unesti ime lokacije koja ce se nalazit na /gps.\n{3C95C2}[!]: Naziv mjesta ne smije biti duzi od 24 slova.","(create)", "(x)");
	        	GetPlayerPos(playerid, X, Y, Z);
				strcat(gpsname, inputtext);
				free_id = Create_GPS(gpsname, X, Y, Z);
				if(free_id == -1) 
					return SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Na serveru je vec kreirano maximalan broj GPS lokacija.");
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Kreirali ste novu GPS lokaciju, naziv: %s - ID: %d.", gpsname, free_id);
	    	}
	    }
	    case DIALOG_DELETEGPS: {
	    	if(response)
			{
				new gpsid = strval(inputtext);
				if(!Iter_Contains(GPS_location, gpsid)) 
					return SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");

				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali lokaciju %s[ID: %d] sa GPS-a", GPS_data[gpsid][gpsName], gpsid);
				Delete_GPS(gpsid);
	    	}
	    }
	    case DIALOG_LOCATIONSGPS: {
	    	if(response) {
 				new 
 					enum_id = GPSToList[playerid][listitem];
 				Bit1_Set(gps_Activated, playerid, true);
 				gps_DistanceTD(playerid, true);

				GPSInfo[playerid][gGPSID] = enum_id;
				GPSInfo[playerid][gX] = GPS_data[enum_id][gpsPos][0];
				GPSInfo[playerid][gY] = GPS_data[enum_id][gpsPos][1];
				GPSInfo[playerid][gZ] = GPS_data[enum_id][gpsPos][2];
 				
				SetPlayerCheckpoint(playerid, GPS_data[enum_id][gpsPos][0], GPS_data[enum_id][gpsPos][1], GPS_data[enum_id][gpsPos][2], 5.0);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Na mapi vam je prikazana lokacija %s crvenim markerom.", GPS_data[enum_id][gpsName]);
				ResetPlayerGPSList(playerid);
  			}
	    }
		case DIALOG_ALOCATIONSGPS: {
	    	if(response) {
				if(!IsPlayerInAnyVehicle(playerid))
					SetPlayerPosEx(playerid, GPS_data[listitem][gpsPos][0], GPS_data[listitem][gpsPos][1], GPS_data[listitem][gpsPos][2]);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					AC_SetVehiclePos(GetPlayerVehicleID(playerid), GPS_data[listitem][gpsPos][0], GPS_data[listitem][gpsPos][1], GPS_data[listitem][gpsPos][2]);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste portani do %s.", GPS_data[listitem][gpsName]);
			}
			return (true);
	    } 
	    case DIALOG_GPSMAPICON: {
	    	if(response) {
	        	new gpsid, mapicon;
				if(sscanf( inputtext, "ii", gpsid, mapicon)) 
					return ShowPlayerDialog(playerid, DIALOG_GPSMAPICON, DIALOG_STYLE_INPUT, "{3C95C2}* Mapicon GPS.", "\nIspod morate unesti ID lokacije(/gps) i zeljeni id mapicon-a.\n{3C95C2}[!] Primjer: 1(gps id) 56(mapicon) -1(U slucaju da ne zelite mapicon).", "(input)", "(x)");
			
				if(!Iter_Contains(GPS_location, gpsid)) 
					return SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");

				GPS_data[gpsid][gpsMapIcon] = mapicon;
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste postavili/promjenili mapicon na lokaciji %s u ID %d.", GPS_data[gpsid][gpsName], mapicon);
				GPS_Save(gpsid);
				if(mapicon != -1)
				{
					foreach(new i: Player)
						SetPlayerMapIcon(i, GPS_data[gpsid][gpsID], GPS_data[gpsid][gpsPos][0], GPS_data[gpsid][gpsPos][1], GPS_data[gpsid][gpsPos][2], GPS_data[gpsid][gpsMapIcon], 0, MAPICON_LOCAL);
				}
				else // -1 = Brisanje postojece map icone
				{
					foreach(new i: Player)
						RemovePlayerMapIcon(playerid, GPS_data[gpsid][gpsID]);
				}
			}
		}
		case DIALOG_MOVEGPS: {
	    	if(response) {
 				new Float: X, Float: Y, Float: Z;
				new gpsid = strval(inputtext);
	        	if(!Iter_Contains(GPS_location, gpsid)) 
					return SendClientMessage(playerid, 0xFF6347AA, "[ERROR]: Unijeli ste nepoznati ID lokacije sa GPS-a.");
	        	
	        	GetPlayerPos(playerid, X, Y, Z);
	        	GPS_data[gpsid][gpsPos][0] = X;
	        	GPS_data[gpsid][gpsPos][1] = Y;
	        	GPS_data[gpsid][gpsPos][2] = Z;
	        	GPS_Save(gpsid);

	        	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste promjenili poziciju lokacije %s na vasu trenutnu.", GPS_data[gpsid][gpsName]);
	        }
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)
CMD:gps(playerid, params[]) {
	if(Bit1_Get(gr_IsWorkingJob, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti GPS dok radite!");
	if(Bit1_Get(gps_Activated, playerid)) {
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Deaktivirali ste stari GPS.");
		Bit1_Set(gps_Activated, playerid, false);
		DisablePlayerCheckpoint(playerid);
		gps_DistanceTD(playerid, bool:false);
		return (true);
	}
	new buff[MAX_GPS_LOCATIONS*32],
		motd[50],
		counter = 0;
		
	foreach(new int: GPS_location) {
		if(GPS_data[int][gpsAdmin] == 0) {
			if(int == 0)
				format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
			else
				format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
			strcat(buff, motd);
			GPSToList[playerid][counter] = int;
			counter++;
		}
	}
	ShowPlayerDialog(playerid, DIALOG_LOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* GPS", buff, "Odabir", "Izlaz");
	return (true);
}

CMD:port(playerid, params[]) {
	new buff[MAX_GPS_LOCATIONS*32],
		motd[50],
		counter = 0;
		
	if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[ playerid ][ pHelper ] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	foreach(new int: GPS_location) {
		if(int == 0)
			format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
		else
			format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
		strcat(buff, motd);
		GPSToList[playerid][counter] = int;
		counter++;
	}
	ShowPlayerDialog(playerid, DIALOG_ALOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* PORT - LOCATIONS", buff, "(port)", "(x)");
	return (true);
}

CMD:agps(playerid, params[]) {
	new 
		action[15];
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid,COLOR_RED, "Niste ovlasteni za koristenje ove komande.");	
	if(sscanf(params, "s[15] ", action))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] /agps [option].");
		SendClientMessage(playerid, 0xAFAFAFAA, "(options): create, delete, setadmin, mapicon, goto, move, rename.");
		return (true);
	}
	if(strcmp(action,"create", true) == 0)
		ShowPlayerDialog(playerid, DIALOG_CREATEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Create GPS.", "\nIspod morate unesti ime lokacije koja ce se nalazit na /gps.\n{3C95C2}[!]: Naziv mjesta ne smije biti duzi od 24 slova.","(create)", "(x)");

	if(strcmp(action,"move", true) == 0)
		ShowPlayerDialog(playerid, DIALOG_MOVEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Move GPS.", "\nIspod morate unesti id lokacije kojoj zelite promijeniti poziciju.\n{3C95C2}[!]: Listu lokacija mozete pronaci na /gps..","(move)", "(x)");

	if(strcmp(action,"goto", true) == 0) {
		new buff[MAX_GPS_LOCATIONS*32],
			motd[50];
		foreach(new int: GPS_location)
		{
			if(int == 0)
				format(motd, sizeof(motd), "{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
			else
				format(motd, sizeof(motd), "\n{3C95C2}(%d) - %s.", int, GPS_data[int][gpsName]);
			strcat(buff, motd);
		}
		ShowPlayerDialog(playerid, DIALOG_ALOCATIONSGPS, DIALOG_STYLE_LIST, "{3C95C2}* GPS", buff, "(select)", "(x)");
		return (true);
	}
	
	if(strcmp(action,"setadmin", true) == 0) {
		new gpsid, adminloc;
		if(sscanf(params, "s[15]ii", action, gpsid, adminloc))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ! ] /agps setadmin [gpsid] [0 = za sve igrace | 1 = samo za /agps goto]");
			return (true);
		}
		if(!Iter_Contains(GPS_location, gpsid))
			return SendErrorMessage(playerid, "Krivi GPS ID! Koristite /agps goto da bi vidjeli sve GPS-ove.");
			
		if(adminloc < 0 || adminloc > 1)
			return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 0 ili veca od 1!");
			
		GPS_data[gpsid][gpsAdmin] = adminloc;
		GPS_Save(gpsid);
		if(adminloc)
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili vidljivost lokacije %s[ID: %d] samo za Team Staff.", GPS_data[gpsid][gpsName], gpsid);
		if(!adminloc)
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili vidljivost lokacije %s[ID: %d] za sve.", GPS_data[gpsid][gpsName], gpsid);
		return (true);
	}
	
	if(strcmp(action,"mapicon", true) == 0)
		ShowPlayerDialog(playerid, DIALOG_GPSMAPICON, DIALOG_STYLE_INPUT, "{3C95C2}* Mapicon GPS.", "\nIspod morate unesti ID lokacije(/agps goto) i zeljeni ID mapicon-a.\n{3C95C2}[!] Format: [GPS ID] [mapicon ID - (56 - zuta tacka)/(-1 ako ne zelite map icon)].", "(input)", "(x)");

	if(strcmp(action,"delete", true) == 0)
		ShowPlayerDialog(playerid, DIALOG_DELETEGPS, DIALOG_STYLE_INPUT, "{3C95C2}* Delete GPS.", "\nIspod morate unesti ID lokacije koja se nalazi na /gps.\n{3C95C2}[!]: Sve ID-ove lokacija mozete pronaci na /agps goto.","(delete)", "(x)");

	return (true);
}
