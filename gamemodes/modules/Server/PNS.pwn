#include <YSI\y_hooks>

#define 		MAX_PAYNSPRAYS				(25)

enum pnsInfo
{
	pnsSQLId,
	pnsStatus,
	Float: pnsPosX,
	Float: pnsPosY,
	Float: pnsPosZ,
	pnsVW,
	pnsInt,
	pnsPickupID,
	Text3D: pnsTextID,
	pnsMapIconID,
	pnsGroupCost,
	pnsRegCost
}

new PayNSprays[MAX_PAYNSPRAYS][pnsInfo];
new szMiscArray[120];
forward PayNSpray(playerid, sprayid, vehicleid);
public PayNSpray(playerid, sprayid, vehicleid)
{
	if(AC_GetPlayerMoney(playerid) >= PayNSprays[sprayid][pnsRegCost])
	{
		PlayerToBudgetMoney(playerid, PayNSprays[sprayid][pnsRegCost]);
	}
	else
	{
		SendClientMessage(playerid, COLOR_WHITE, "You don't have enough money to pay for this!");
		TogglePlayerControllable(playerid, 1);
		return 1;
	}
	RepairVehicle(vehicleid);
	SendClientMessage(playerid, COLOR_WHITE, "Your vehicle has been repaired!");
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

stock number_format(number)
{
	new i, string[15];
	FIXES_valstr(string, number);
	if(strfind(string, "-") != -1) i = strlen(string) - 4;
	else i = strlen(string) - 3;
	while (i >= 1)
 	{
		if(strfind(string, "-") != -1) strins(string, ",", i + 1);
		else strins(string, ",", i);
		i -= 3;
	}
	return string;
}

CMD:pnsedit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
	{
		va_SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
		return 1;
	}

	new string[128], choice[32], sprayid, amount;
	if(sscanf(params, "s[32]dD", choice, sprayid, amount))
	{
		va_SendClientMessage(playerid, COLOR_GREY, "USAGE: /pnsedit [name] [sprayid] [amount]");
		va_SendClientMessage(playerid, COLOR_GREY, "Available names: Position, GroupCost, RegCost, Delete");
		return 1;
	}

	if(sprayid >= MAX_PAYNSPRAYS)
	{
		va_SendClientMessage(playerid, COLOR_WHITE, "Invalid Pay N' Spray ID!");
		return 1;
	}

	if(strcmp(choice, "position", true) == 0)
	{
		if(PayNSprays[sprayid][pnsStatus] == 0)
		{
			PayNSprays[sprayid][pnsStatus] = 1;
		}
		GetPlayerPos(playerid, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ]);
		PayNSprays[sprayid][pnsInt] = GetPlayerInterior(playerid);
		PayNSprays[sprayid][pnsVW] = GetPlayerVirtualWorld(playerid);
		format(string, sizeof(string), "You have changed the position on Pay N' Spray #%d.", sprayid);
		va_SendClientMessage(playerid, COLOR_WHITE, string);
		DestroyDynamicPickup(PayNSprays[sprayid][pnsPickupID]);
		DestroyDynamic3DTextLabel(PayNSprays[sprayid][pnsTextID]);
		DestroyDynamicMapIcon(PayNSprays[sprayid][pnsMapIconID]);
		format(string, sizeof(string), "/repaircar\nRepair Cost -- Regular: $%s | Faction: $%s\nID: %d", number_format(PayNSprays[sprayid][pnsRegCost]), number_format(PayNSprays[sprayid][pnsGroupCost]), sprayid);
		PayNSprays[sprayid][pnsTextID] = CreateDynamic3DTextLabel(string, COLOR_RED, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ]+0.5,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, PayNSprays[sprayid][pnsVW], PayNSprays[sprayid][pnsInt], -1);
		PayNSprays[sprayid][pnsPickupID] = CreateDynamicPickup(1239, 23, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ], PayNSprays[sprayid][pnsVW]);
		PayNSprays[sprayid][pnsMapIconID] = CreateDynamicMapIcon(PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ], 63, 0, PayNSprays[sprayid][pnsVW], PayNSprays[sprayid][pnsInt], -1, 500.0);
		SavePayNSpray(sprayid);
		return 1;
	}
	else if(strcmp(choice, "groupcost", true) == 0)
	{
		if(PayNSprays[sprayid][pnsStatus] == 0)
		{
			format(string, sizeof(string), "Pay N' Spray #%d does not exist.", sprayid);
			va_SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
		PayNSprays[sprayid][pnsGroupCost] = amount;
		format(string, sizeof(string), "You have changed the group cost for Pay N' Spray #%d to $%s.", sprayid, number_format(amount));
		va_SendClientMessage(playerid, COLOR_WHITE, string);
		DestroyDynamic3DTextLabel(PayNSprays[sprayid][pnsTextID]);
		format(string, sizeof(string), "/repaircar\nRepair Cost -- Regular: $%s | Faction: $%s\nID: %d", number_format(PayNSprays[sprayid][pnsRegCost]), number_format(PayNSprays[sprayid][pnsGroupCost]), sprayid);
		PayNSprays[sprayid][pnsTextID] = CreateDynamic3DTextLabel(string, COLOR_RED, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ]+0.5,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, PayNSprays[sprayid][pnsVW], PayNSprays[sprayid][pnsInt], -1);
		SavePayNSpray(sprayid);
		return 1;
	}
	else if(strcmp(choice, "regcost", true) == 0)
	{
		if(PayNSprays[sprayid][pnsStatus] == 0)
		{
			format(string, sizeof(string), "Pay N' Spray #%d does not exist.", sprayid);
			va_SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
		PayNSprays[sprayid][pnsRegCost] = amount;
		format(string, sizeof(string), "You have changed the regular cost for Pay N' Spray #%d to $%s.", sprayid, number_format(amount));
		va_SendClientMessage(playerid, COLOR_WHITE, string);
		DestroyDynamic3DTextLabel(PayNSprays[sprayid][pnsTextID]);
		format(string, sizeof(string), "/repaircar\nRepair Cost -- Regular: $%s | Faction: $%s\nID: %d", number_format(PayNSprays[sprayid][pnsRegCost]), number_format(PayNSprays[sprayid][pnsGroupCost]), sprayid);
		PayNSprays[sprayid][pnsTextID] = CreateDynamic3DTextLabel(string, COLOR_RED, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ]+0.5,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, PayNSprays[sprayid][pnsVW], PayNSprays[sprayid][pnsInt], -1);
		SavePayNSpray(sprayid);
		return 1;
	}
	else if(strcmp(choice, "delete", true) == 0)
	{
		if(PayNSprays[sprayid][pnsStatus] == 0)
		{
			format(string, sizeof(string), "Pay N' Spray #%d does not exist.", sprayid);
			va_SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
   	  	DestroyDynamicPickup(PayNSprays[sprayid][pnsPickupID]);
	    DestroyDynamic3DTextLabel(PayNSprays[sprayid][pnsTextID]);
		DestroyDynamicMapIcon(PayNSprays[sprayid][pnsMapIconID]);
		PayNSprays[sprayid][pnsStatus] = 0;
		PayNSprays[sprayid][pnsPosX] = 0.0;
		PayNSprays[sprayid][pnsPosY] = 0.0;
		PayNSprays[sprayid][pnsPosZ] = 0.0;
		PayNSprays[sprayid][pnsVW] = 0;
		PayNSprays[sprayid][pnsInt] = 0;
		PayNSprays[sprayid][pnsGroupCost] = 0;
		PayNSprays[sprayid][pnsRegCost] = 0;
		SavePayNSpray(sprayid);
		format(string, sizeof(string), "You have deleted Pay N' Spray #%d.", sprayid);
		va_SendClientMessage(playerid, COLOR_WHITE, string);
		return 1;
	}
	return 1;
}

CMD:pnsstatus(playerid, params[])
{
	new sprayid;
	if(sscanf(params, "i", sprayid))
	{
		va_SendClientMessage(playerid, COLOR_GREY, "USAGE: /pnsstatus [sprayid]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 4)
	{
		new string[128];
		format(string,sizeof(string),"|___________ Pay N' Spray Status (ID: %d) ___________|", sprayid);
		va_SendClientMessage(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "[Position] X: %f | Y: %f | Z: %f | VW: %d | Int: %d", PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ], PayNSprays[sprayid][pnsVW], PayNSprays[sprayid][pnsInt]);
		va_SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Group Cost: $%s | Regular Cost: $%s", number_format(PayNSprays[sprayid][pnsGroupCost]), number_format(PayNSprays[sprayid][pnsRegCost]));
		va_SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:pnsnext(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		va_SendClientMessage(playerid, COLOR_RED, "* Listing next available Pay N' Spray...");
		for(new x = 0; x < MAX_PAYNSPRAYS; x++)
		{
			if(PayNSprays[x][pnsStatus] == 0)
		    {
		        new string[128];
		        format(string, sizeof(string), "%d is available to use.", x);
		        va_SendClientMessage(playerid, COLOR_WHITE, string);
		        break;
			}
		}
	}
	else
	{
	    va_SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
		return 1;
	}
	return 1;
}

CMD:gotopaynspray(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new sprayid;
		if(sscanf(params, "d", sprayid)) return va_SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotopaynspray [sprayid]");

		SetPlayerPos(playerid, PayNSprays[sprayid][pnsPosX], PayNSprays[sprayid][pnsPosY], PayNSprays[sprayid][pnsPosZ]);
		SetPlayerInterior(playerid, PayNSprays[sprayid][pnsInt]);
		PlayerInfo[playerid][pInt] = PayNSprays[sprayid][pnsInt];
		SetPlayerVirtualWorld(playerid, PayNSprays[sprayid][pnsVW]);
	}
	return 1;
}

CMD:repaircar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		for(new i; i < MAX_PAYNSPRAYS; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, PayNSprays[i][pnsPosX], PayNSprays[i][pnsPosY], PayNSprays[i][pnsPosZ]) && GetPlayerVirtualWorld(playerid) == PayNSprays[i][pnsVW] && GetPlayerInterior(playerid) == PayNSprays[i][pnsInt])
			{
				if(PayNSprays[i][pnsStatus] > 0)
				{
					SetTimerEx("PayNSpray", 5000, false, "iii", playerid, i, GetPlayerVehicleID(playerid));
					TogglePlayerControllable(playerid, 0);
					GameTextForPlayer(playerid, "Repairing...", 5000, 5);
					return 1;
				}
			}
		}
		SendClientMessage(playerid, COLOR_WHITE, "You are not at a Pay N' Spray!");
	}
	else SendClientMessage(playerid, COLOR_WHITE, "You are not in a car!");
	return 1;
}

stock SavePayNSpray(sprayid)
{
	new string[1024];
	format(string, sizeof(string), "UPDATE `paynsprays` SET \
		`Status`=%d, \
		`PosX`=%f, \
		`PosY`=%f, \
		`PosZ`=%f, \
		`VW`=%d, \
		`Int`=%d, \
		`GroupCost`=%d, \
		`RegCost`=%d WHERE `id`=%d",
		PayNSprays[sprayid][pnsStatus],
		PayNSprays[sprayid][pnsPosX],
		PayNSprays[sprayid][pnsPosY],
		PayNSprays[sprayid][pnsPosZ],
		PayNSprays[sprayid][pnsVW],
		PayNSprays[sprayid][pnsInt],
		PayNSprays[sprayid][pnsGroupCost],
		PayNSprays[sprayid][pnsRegCost],
  		sprayid
	);

	mysql_tquery(g_SQL, string, "OnQueryFinish", "i");
}

stock SavePayNSprays()
{
	for(new i = 0; i < MAX_PAYNSPRAYS; i++)
	{
		SavePayNSpray(i);
	}
	return 1;
}

stock RehashPayNSpray(sprayid)
{
	DestroyDynamicPickup(PayNSprays[sprayid][pnsPickupID]);
	DestroyDynamic3DTextLabel(PayNSprays[sprayid][pnsTextID]);
	DestroyDynamicMapIcon(PayNSprays[sprayid][pnsMapIconID]);
	PayNSprays[sprayid][pnsSQLId] = -1;
	PayNSprays[sprayid][pnsStatus] = 0;
	PayNSprays[sprayid][pnsPosX] = 0.0;
	PayNSprays[sprayid][pnsPosY] = 0.0;
	PayNSprays[sprayid][pnsPosZ] = 0.0;
	PayNSprays[sprayid][pnsVW] = 0;
	PayNSprays[sprayid][pnsInt] = 0;
	PayNSprays[sprayid][pnsGroupCost] = 0;
	PayNSprays[sprayid][pnsRegCost] = 0;
	LoadPayNSpray(sprayid);
}

stock RehashPayNSprays()
{
	printf("[RehashPayNSprays] Deleting Pay N' Sprays from server...");
	for(new i = 0; i < MAX_PAYNSPRAYS; i++)
	{
		RehashPayNSpray(i);
	}
	LoadPayNSprays();
}

stock LoadPayNSpray(sprayid)
{
	new string[128];
	format(string, sizeof(string), "SELECT * FROM `paynsprays` WHERE `id`=%d", sprayid);
	mysql_tquery(g_SQL, string, "OnLoadPayNSpray", "i", sprayid);
}

stock LoadPayNSprays()
{
	printf("[LoadPayNSprays] Loading data from database...");
	mysql_tquery(g_SQL, "SELECT * FROM `paynsprays`", "OnLoadPayNSprays", "");
}

forward OnLoadPayNSpray(index);
public OnLoadPayNSpray(index)
{
	new rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", PayNSprays[index][pnsSQLId]);
		cache_get_value_name_int(row, "Status", PayNSprays[index][pnsStatus]);
		cache_get_value_name_float(row, "PosX", PayNSprays[index][pnsPosX]);
		cache_get_value_name_float(row, "PosY", PayNSprays[index][pnsPosY]);
		cache_get_value_name_float(row, "PosZ", PayNSprays[index][pnsPosZ]);
		cache_get_value_name_int(row, "VW", PayNSprays[index][pnsVW]);
		cache_get_value_name_int(row, "Int", PayNSprays[index][pnsInt]);
		cache_get_value_name_int(row, "GroupCost", PayNSprays[index][pnsGroupCost]);
		cache_get_value_name_int(row, "RegCost", PayNSprays[index][pnsRegCost]);
		if(PayNSprays[index][pnsStatus] > 0)
		{
			format(szMiscArray, sizeof(szMiscArray), "/repaircar\nRepair Cost -- Regular: $%s | Faction: $%s\nID: %d", number_format(PayNSprays[index][pnsRegCost]), number_format(PayNSprays[index][pnsGroupCost]), index);
			PayNSprays[index][pnsTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_RED, PayNSprays[index][pnsPosX], PayNSprays[index][pnsPosY], PayNSprays[index][pnsPosZ]+0.5,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, PayNSprays[index][pnsVW], PayNSprays[index][pnsInt], -1);
			PayNSprays[index][pnsPickupID] = CreateDynamicPickup(1239, 23, PayNSprays[index][pnsPosX], PayNSprays[index][pnsPosY], PayNSprays[index][pnsPosZ], PayNSprays[index][pnsVW]);
			PayNSprays[index][pnsMapIconID] = CreateDynamicMapIcon(PayNSprays[index][pnsPosX], PayNSprays[index][pnsPosY], PayNSprays[index][pnsPosZ], 63, 0, PayNSprays[index][pnsVW], PayNSprays[index][pnsInt], -1, 500.0);
		}
	}
	return 1;
}

forward OnLoadPayNSprays();
public OnLoadPayNSprays()
{
	new i, rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	while(i < rows)
	{
		LoadPayNSpray(i);
		i++;
	}
}
