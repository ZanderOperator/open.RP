#include <YSI_Coding\y_hooks>

static
	PlayerText:ZoneInfoTextDraw[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

ptask MapZoneCheck[1000](playerid)
{
	if(!SafeSpawned[playerid])
		return 1;

	new 
		MapZone:zone_id = GetPlayerMapZone(playerid),
		zone_name[MAX_MAP_ZONE_NAME];

	if(zone_id == INVALID_MAP_ZONE_ID)
		format(zone_name, MAX_MAP_ZONE_NAME, "San Andreas");
	else
		GetMapZoneName(zone_id, zone_name, MAX_MAP_ZONE_NAME);

	PlayerTextDrawSetString(playerid, ZoneInfoTextDraw[playerid], zone_name);
	PlayerTextDrawShow(playerid, ZoneInfoTextDraw[playerid]);
	return 1;
}

stock CreateZonesTD(playerid)
{
	DestroyZonesTD(playerid);
	ZoneInfoTextDraw[playerid] = CreatePlayerTextDraw(playerid, 88.0,430.0, "San Andreas");
	PlayerTextDrawFont(playerid, ZoneInfoTextDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ZoneInfoTextDraw[playerid], 0.249, 1.040);
	PlayerTextDrawSetShadow(playerid, ZoneInfoTextDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ZoneInfoTextDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ZoneInfoTextDraw[playerid], 1);
	PlayerTextDrawAlignment(playerid, ZoneInfoTextDraw[playerid], 2);
	PlayerTextDrawShow(playerid, ZoneInfoTextDraw[playerid]);
}

stock DestroyZonesTD(playerid)
{
	if(ZoneInfoTextDraw[playerid] != PlayerText:INVALID_TEXT_DRAW) 
	{
		PlayerTextDrawDestroy(playerid, ZoneInfoTextDraw[playerid]);
		ZoneInfoTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	CreateZonesTD(playerid);
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	DestroyZonesTD(playerid);
	return continue(playerid);
}

GetPlayerZone(playerid)
{
	new 
		MapZone: zone_id = GetPlayerMapZone(playerid),
		zone_name[MAX_MAP_ZONE_NAME];
		
	if(zone_id == INVALID_MAP_ZONE_ID)
		format(zone_name, MAX_MAP_ZONE_NAME, "San Andreas");
	else
		GetMapZoneName(zone_id, zone_name, MAX_MAP_ZONE_NAME);

	return zone_name;
}

GetVehicleZone(vehicleid)
{
	new 
		MapZone: zone_id = GetVehicleMapZone(vehicleid),
		zone_name[MAX_MAP_ZONE_NAME];

	if(zone_id == INVALID_MAP_ZONE_ID)
		format(zone_name, MAX_MAP_ZONE_NAME, "San Andreas");
	else
		GetMapZoneName(zone_id, zone_name, MAX_MAP_ZONE_NAME);

	return zone_name;
}

GetZoneFromXYZ(Float:x, Float:y, Float:z)
{
	new
		MapZone: zone_id = GetMapZoneAtPoint(x, y, z),
		zone_name[MAX_MAP_ZONE_NAME];

	if(zone_id == INVALID_MAP_ZONE_ID)
		format(zone_name, MAX_MAP_ZONE_NAME, "San Andreas");
	else
		GetMapZoneName(zone_id, zone_name, MAX_MAP_ZONE_NAME);

	return zone_name;
}