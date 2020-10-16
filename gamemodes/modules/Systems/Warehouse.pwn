// Dynamic Warehouse System by Logan

#include <YSI\y_hooks>

new Iterator: Warehouses<MAX_FACTIONS>,
	Iterator: WhWeapons[MAX_FACTIONS]<MAX_WAREHOUSE_WEAPONS>,
	Iterator: Robbers<MAX_PLAYERS>;
/*	
enum { // U coarp.amx
	// Move to coarp.pwn
	WAREHOUSE_PUT_MENU,
	WAREHOUSE_TAKE_MENU,
	WAREHOUSE_MONEY_PUT,
	WAREHOUSE_MONEY_TAKE,
	DIALOG_TAKE_WEAPON_LIST,
	DIALOG_WAREHOUSE_INFO
}; */

	
new	Bit2:	gr_PlayerInWarehouse	<MAX_PLAYERS>  = Bit2: -1;

enum whInfo
{
	whFactionSQLID, // SQL ID of Faction that warehouse belongs to (( FactionInfo[factionid][fID] ))
	Float:whEnter[3],
	Float:whExit[3],
	Float:whVault[3],
	bool:whLocked,
	whInt,
	whViwo,
	whPickupID,
	whMoney
}
new WarehouseInfo[MAX_FACTIONS][whInfo];
	
enum WH_WEAPON_INFO
{
	whWeaponSQL,
	whFactionSQLID,	// SQL ID of Faction that weapon belongs to (( FactionInfo[factionid][fID] ))
	whWeaponId,
	whAmmo
}
new WarehouseWeapons[MAX_FACTIONS][MAX_WAREHOUSE_WEAPONS][WH_WEAPON_INFO];

enum E_ROBBERY_INFO
{
	bool:whActive,
	whDuration,
	bool:whSuceeded,
	whExtractionArea,
	whMainRobberSQL,
	whRobberFaction,
	whRobberWarehouse,
	whVictimFaction,
	whVictimWarehouse,
}
new RobberyInfo[E_ROBBERY_INFO];

stock ResetWarehouseEnum(wh)
{
	DestroyDynamicPickup(WarehouseInfo[wh][whPickupID]);	
	WarehouseInfo[wh][whFactionSQLID] = -1;
	WarehouseInfo[wh][whEnter][0] = 0.0;
	WarehouseInfo[wh][whEnter][1] = 0.0;
	WarehouseInfo[wh][whEnter][2] = 0.0;
	WarehouseInfo[wh][whExit][0] = 0.0;
	WarehouseInfo[wh][whExit][1] = 0.0;
	WarehouseInfo[wh][whExit][2] = 0.0;
	WarehouseInfo[wh][whVault][0] = 0.0;
	WarehouseInfo[wh][whVault][1] = 0.0;
	WarehouseInfo[wh][whVault][2] = 0.0;
	WarehouseInfo[wh][whLocked] = false;
	WarehouseInfo[wh][whInt] = 0;
	WarehouseInfo[wh][whViwo] = 0;
	WarehouseInfo[wh][whPickupID] = -1;
	WarehouseInfo[wh][whMoney] = 0;
	return 1;
}

stock LoadFactionWarehouse(factionid)
{
	new loadFactionWh[128];
	format(loadFactionWh, 128, "SELECT * FROM `server_warehouses` WHERE `fid` = '%d'", 
		FactionInfo[factionid][fID]
	);
	mysql_tquery(g_SQL, loadFactionWh, "OnWarehouseLoaded", "i", factionid);
}

Function: OnWarehouseLoaded(factionid)
{
	if( !cache_num_rows() ) return 0;
	new freeslot = Iter_Free(Warehouses);
	WarehouseInfo[freeslot][whFactionSQLID] = FactionInfo[factionid][fID];
	cache_get_value_name_float(0, "enterX"			, WarehouseInfo[freeslot][whEnter][0]);
	cache_get_value_name_float(0, "enterY"			, WarehouseInfo[freeslot][whEnter][1]);
	cache_get_value_name_float(0, "enterZ"			, WarehouseInfo[freeslot][whEnter][2]);
	cache_get_value_name_float(0, "exitX"			, WarehouseInfo[freeslot][whExit][0]);
	cache_get_value_name_float(0, "exitY"			, WarehouseInfo[freeslot][whExit][1]);
	cache_get_value_name_float(0, "exitZ"			, WarehouseInfo[freeslot][whExit][2]);
	cache_get_value_name_float(0, "vaultX"			, WarehouseInfo[freeslot][whVault][0]);
	cache_get_value_name_float(0, "vaultY"			, WarehouseInfo[freeslot][whVault][1]);
	cache_get_value_name_float(0, "vaultZ"			, WarehouseInfo[freeslot][whVault][2]);
	cache_get_value_name_int(0,   "int"				, WarehouseInfo[freeslot][whInt]);
	cache_get_value_name_int(0,   "viwo"			, WarehouseInfo[freeslot][whViwo]);
	cache_get_value_name_int(0,   "lock"			, WarehouseInfo[freeslot][whLocked]);
	WarehouseInfo[freeslot][whPickupID] =  CreateDynamicPickup(1239, 1, WarehouseInfo[freeslot][whVault][0], WarehouseInfo[freeslot][whVault][1], WarehouseInfo[freeslot][whVault][2], WarehouseInfo[freeslot][whViwo], WarehouseInfo[freeslot][whInt], -1);
	cache_get_value_name_int(0,   "money"			, WarehouseInfo[freeslot][whMoney]);
	Iter_Add(Warehouses, freeslot);
	
	LoadWarehouseWeapons(WarehouseInfo[freeslot][whFactionSQLID]);
	return 1;
}

stock LoadWarehouseWeapons(factid)
{
	new loadWhWeapons[128],
		whid = FetchWarehouseEnumFromFaction(factid);
		
	format(loadWhWeapons, 128, "SELECT * FROM `warehouse_weapons` WHERE `fid` = '%d'", 
		factid
	);

	mysql_tquery(g_SQL, loadWhWeapons, "OnWarehouseWeaponsLoaded", "i", whid);
}

Function: OnWarehouseWeaponsLoaded(whid)
{
	if( !cache_num_rows() ) return 0;
	for( new i = 0; i < cache_num_rows(); i++ ) 
	{
		cache_get_value_name_int(i, "id"		, WarehouseWeapons[whid][i][whWeaponSQL]);
		cache_get_value_name_int(i, "fid"		, WarehouseWeapons[whid][i][whFactionSQLID]);
		cache_get_value_name_int(i, "weaponid"	, WarehouseWeapons[whid][i][whWeaponId]);
		cache_get_value_name_int(i, "ammo"		, WarehouseWeapons[whid][i][whAmmo]);
		Iter_Add(WhWeapons[whid], i);
	}
	return 1;
}

stock PutWeaponInWarehouse(playerid, weaponid, ammo)
{
	AC_ResetPlayerWeapon(playerid, weaponid);
	new putWeaponQuery[128],
		fid = PlayerInfo[playerid][pMember],
		whid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]),
		wslot = Iter_Free(WhWeapons[whid]);
		
	WarehouseWeapons[whid][wslot][whFactionSQLID] = FactionInfo[fid][fID];
	WarehouseWeapons[whid][wslot][whWeaponId] = weaponid;
	WarehouseWeapons[whid][wslot][whAmmo] = ammo;
	
	format(putWeaponQuery, sizeof(putWeaponQuery), "INSERT INTO `warehouse_weapons`(`fid`, `weaponid`, `ammo`) VALUES ('%d','%d','%d')",
		FactionInfo[fid][fID],
		weaponid,
		ammo
	);
	mysql_tquery(g_SQL, putWeaponQuery, "OnWarehouseWeaponInsert", "ii", whid, wslot);
	Iter_Add(WhWeapons[whid], wslot);
	new wname[32];
	GetWeaponName(weaponid, wname, sizeof(wname));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste pohranili %s(%d) u Warehouse %s.", wname, ammo, FactionInfo[fid][fName]);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/warehouse_put.txt", "(%s) %s[SQL:%d] stored %s(%d) in Warehouse %s[SQL:%d].",
		ReturnDate(),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		wname,
		ammo,
		FactionInfo[fid][fName],
		FactionInfo[fid][fID]
	);
	#endif
	
	return 1;
}

Function: OnWarehouseWeaponInsert(warehouseid, wslot)
{
	WarehouseWeapons[warehouseid][wslot][whWeaponSQL] = cache_insert_id();
	return 1;
}

stock ListPlayerWarehouseWeapons(playerid, whid)
{
	new buffer[1744], motd[64], wname[32], counter = 0;
	foreach(new wslot: WhWeapons[whid])
	{
		GetWeaponName(WarehouseWeapons[whid][wslot][whWeaponId], wname, 32);
		
		if(wslot == Iter_Last(WhWeapons[whid]))
			format(motd, sizeof(motd), ""COL_WHITE"%s(%d)", wname, WarehouseWeapons[whid][wslot][whAmmo]);
		else format(motd, sizeof(motd), ""COL_WHITE"%s(%d)\n", wname, WarehouseWeapons[whid][wslot][whAmmo]);
		
		strcat(buffer, motd, sizeof(buffer));
		WeaponToList[playerid][counter] = wslot;
		counter++;
	}
	return buffer;
}
stock ListWarehouseWeapons(whid)
{
	new winfo[512],
		motd[64],
		weaponid,
		ammo,
		guns = 0,
		gunsammo = 0,
		shotguns = 0,
		shotgunammo = 0,
		smgs = 0,
		smgammo = 0,
		assualts = 0,
		assualtammo = 0,
		rifles = 0,
		rifleammo = 0;
		
	format(motd, sizeof(motd), "Stanje zaliha oruzja:\n");
	strcat(winfo, motd, sizeof(winfo));
	
	if(!Iter_Count(WhWeapons[whid]))
	{
		format(motd, sizeof(motd), "\tNema uskladistenog oruzja.\n");
		strcat(winfo, motd, sizeof(winfo));
		return winfo;
	}
	
	foreach(new wslot: WhWeapons[whid])
	{
		weaponid = WarehouseWeapons[whid][wslot][whWeaponId];
		ammo = WarehouseWeapons[whid][wslot][whAmmo];
		switch(weaponid)
		{
			case 22,24: {
				guns++; gunsammo += ammo; 
			}
			case 25: {
				shotguns++; shotgunammo += ammo;
			}
			case 28,29,32: {
				smgs++; smgammo += ammo;
			}
			case 30,31: {
				assualts++; assualtammo += ammo;
			}
			case 33,34:  {
				rifles++; rifleammo += ammo; 
			}
			default: continue;
		}
	}
	if(guns > 0)
	{
		format(motd, sizeof(winfo), "\tPistolji: %d | ~ metaka po pistolju: %d\n", guns, (gunsammo/guns));
		strcat(winfo, motd, sizeof(winfo));
	}
	if(shotguns > 0)
	{
		format(motd, sizeof(motd), "\tPuske: %d | ~ metaka po puski: %d\n", shotguns, (shotgunammo/shotguns));
		strcat(winfo, motd, sizeof(winfo));
	}
	if(smgs > 0)
	{
		format(motd, sizeof(motd), "\tSMGovi: %d | ~ metaka po SMG-u: %d\n", smgs, (smgammo/smgs));
		strcat(winfo, motd, sizeof(winfo));
	}
	if(assualts > 0)
	{
		format(motd, sizeof(motd), "\tAutom.puske: %d | ~ metaka po puski: %d\n", assualts, (assualtammo/assualts));
		strcat(winfo, motd, sizeof(winfo));
	}
	if(rifles > 0)
	{
		format(motd, sizeof(motd), "\tRifleovi: %d | ~ metaka po rifleu: %d", rifles, (rifleammo/rifles));
		strcat(winfo, motd, sizeof(winfo));
	}
	return winfo;
}

stock RemoveWeaponFromWarehouse(whid, weaponslot)
{
	new
		tmpQuery[ 84 ];
	format(tmpQuery, sizeof(tmpQuery), "DELETE FROM `warehouse_weapons` WHERE `id` = '%d'", WarehouseWeapons[whid][weaponslot][whWeaponSQL]);
	mysql_tquery(g_SQL, tmpQuery, "");
	
	WarehouseWeapons[whid][weaponslot][whWeaponSQL] = -1;
	WarehouseWeapons[whid][weaponslot][whFactionSQLID] = -1;
	WarehouseWeapons[whid][weaponslot][whWeaponId] = 0;
	WarehouseWeapons[whid][weaponslot][whAmmo] = 0;
	
	Iter_Remove(WhWeapons[whid], weaponslot);
	return 1;
}

stock RemoveWeaponsFromWarehouse(whid)
{
	new
		tmpQuery[ 84 ];
	foreach(new weaponslot: WhWeapons[whid])
	{
		format(tmpQuery, sizeof(tmpQuery), "DELETE FROM `warehouse_weapons` WHERE `id` = '%d'", WarehouseWeapons[whid][weaponslot][whWeaponSQL]);
		mysql_tquery(g_SQL, tmpQuery, "");
		
		WarehouseWeapons[whid][weaponslot][whWeaponSQL] = -1;
		WarehouseWeapons[whid][weaponslot][whFactionSQLID] = -1;
		WarehouseWeapons[whid][weaponslot][whWeaponId] = 0;
		WarehouseWeapons[whid][weaponslot][whAmmo] = 0;
	}
	Iter_Clear(WhWeapons[whid]);
	return 1;
}

stock UpdateWarehouseLock(wh)
{
	new
		whUpdateQuery[84];
	format(whUpdateQuery, 84, "UPDATE `server_warehouses` SET `lock`='%d' WHERE `fid`='%d'", 
		WarehouseInfo[wh][whLocked],
		WarehouseInfo[wh][whFactionSQLID]
	);
	mysql_tquery(g_SQL, whUpdateQuery, "", "");
	return 1;
}

stock UpdateWarehouseMoney(wh)
{
	new
		whUpdateQuery[84];
	format(whUpdateQuery, 84, "UPDATE `server_warehouses` SET `money`='%d' WHERE `fid`='%d'", 
		WarehouseInfo[wh][whMoney],
		WarehouseInfo[wh][whFactionSQLID]
	);
	mysql_tquery(g_SQL, whUpdateQuery, "", "");
	return 1;
}

stock MoveWarehouse(wh, Float:x, Float:y, Float:z)
{
	WarehouseInfo[wh][whEnter][0] = x;
	WarehouseInfo[wh][whEnter][1] = y;
	WarehouseInfo[wh][whEnter][2] = z;
	
	new
		whUpdateQuery[180];
	format(whUpdateQuery, 180, "UPDATE `server_warehouses` SET `enterX`='%f', `enterY`='%f', `enterZ`='%f' WHERE `fid`='%d'", 
		x,
		y,
		z,
		WarehouseInfo[wh][whFactionSQLID]
	);
	mysql_tquery(g_SQL, whUpdateQuery, "", "");
	return 1;
}

stock AddWarehouse(wh, factionid, Float:x, Float:y, Float:z)
{
	WarehouseInfo[wh][whFactionSQLID] = FactionInfo[factionid][fID];	
	WarehouseInfo[wh][whEnter][0] = x;
	WarehouseInfo[wh][whEnter][1] = y;
	WarehouseInfo[wh][whEnter][2] = z;
	WarehouseInfo[wh][whExit][0] = 1302.519897;
	WarehouseInfo[wh][whExit][1] = -1.787510;
	WarehouseInfo[wh][whExit][2] = 1001.028259;
	WarehouseInfo[wh][whVault][0] = 1307.0762;
	WarehouseInfo[wh][whVault][1] = -45.4601;
	WarehouseInfo[wh][whVault][2] = 1001.0313;
	WarehouseInfo[wh][whInt] = 18;
	WarehouseInfo[wh][whViwo] = FactionInfo[factionid][fID];
	WarehouseInfo[wh][whLocked] = true;
	WarehouseInfo[wh][whMoney] = 0;
	WarehouseInfo[wh][whPickupID] =  CreateDynamicPickup(1239, 1, WarehouseInfo[wh][whVault][0], WarehouseInfo[wh][whVault][1], WarehouseInfo[wh][whVault][2], WarehouseInfo[wh][whViwo], WarehouseInfo[wh][whInt], -1);
	
	new whInsertQuery[350];
	
	format(whInsertQuery, sizeof(whInsertQuery), "INSERT INTO `server_warehouses`(`fid`, `enterX`, `enterY`, `enterZ`, `exitX` , `exitY` , `exitZ`, `vaultX`, `vaultY`, `vaultZ`, `int`, `viwo`, `lock`, `money`) VALUES ('%d','%f','%f','%f','%f','%f','%f','%f','%f','%f','%d','%d','%d','%d')",
		WarehouseInfo[wh][whFactionSQLID],
		WarehouseInfo[wh][whEnter][0],
		WarehouseInfo[wh][whEnter][1],
		WarehouseInfo[wh][whEnter][2],
		WarehouseInfo[wh][whExit][0],
		WarehouseInfo[wh][whExit][1],
		WarehouseInfo[wh][whExit][2],
		WarehouseInfo[wh][whVault][0],
		WarehouseInfo[wh][whVault][1],
		WarehouseInfo[wh][whVault][2],
		WarehouseInfo[wh][whInt], 
		WarehouseInfo[wh][whViwo],
		WarehouseInfo[wh][whLocked],
		WarehouseInfo[wh][whMoney]
	);
	mysql_tquery(g_SQL, whInsertQuery, "", "");
	Iter_Add(Warehouses, wh);
	return 1;
}

stock RemoveWarehouse(wh)
{
	new
		tmpQuery[ 84 ];
	format(tmpQuery, sizeof(tmpQuery), "DELETE FROM `server_warehouses` WHERE `fid` = '%d'", WarehouseInfo[wh][whFactionSQLID]);
	mysql_tquery(g_SQL, tmpQuery, "");
	RemoveWeaponsFromWarehouse(wh);
	Iter_Remove(Warehouses, wh);
	ResetWarehouseEnum(wh);
	return 1;
}

static stock IsAtWarehouseEntrance(playerid)
{
	new whid = -1;
	foreach(new wh: Warehouses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, WarehouseInfo[wh][whEnter][0], WarehouseInfo[wh][whEnter][1], WarehouseInfo[wh][whEnter][2]))
		{
			whid = wh;
			break;
		}
	}
	return whid;
}

static stock IsAtWarehouseExit(playerid)
{
	new whid = -1;
	foreach(new wh: Warehouses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, WarehouseInfo[wh][whExit][0], WarehouseInfo[wh][whExit][1], WarehouseInfo[wh][whExit][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WarehouseInfo[wh][whViwo])
			{
				whid = wh;
				break;
			}
		}
	}
	return whid;
}

static stock IsAtWarehouseVault(playerid)
{
	new whid = -1;
	foreach(new wh: Warehouses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, WarehouseInfo[wh][whVault][0], WarehouseInfo[wh][whVault][1], WarehouseInfo[wh][whVault][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WarehouseInfo[wh][whViwo])
			{
				whid = wh;
				break;
			}
		}
	}
	return whid;
}

stock FetchFactionEnumFromWarehouse(warehouseid)
{
	new facid;
	foreach(new f: Factions)
	{
		if(WarehouseInfo[warehouseid][whFactionSQLID] == FactionInfo[f][fID])
		{
			facid = f;
			break;
		}
	}
	return facid;
}

stock FetchFactionEnumFromSQLID(factionid)
{
	new fid = -1;
	foreach(new f: Factions)
	{
		if(FactionInfo[f][fID] == factionid)
		{
			fid = f;
			break;
		}
	}
	return fid;
}

stock CountOnlineMembers(fSQLID)
{
	new fid = FetchFactionEnumFromSQLID(fSQLID),
		count = 0;
	foreach (new i : Player) 
		if (PlayerInfo[i][pMember] == fid) 
			count++;
	return count;
}

stock CountMembersInRadius(warehouseid, fid)
{
	new count = 0;
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pMember] == fid) 
		{
			if(IsPlayerInRangeOfPoint(i, 20.0, WarehouseInfo[warehouseid][whVault][0], WarehouseInfo[warehouseid][whVault][1], WarehouseInfo[warehouseid][whVault][2]))
				count++;
		}
	}
	return count;
}

stock CheckRobbersInRadius(warehouseid, fid)
{
	new robber = 0;
	foreach (new i : Player)
	{
		robber = Iter_Contains(Robbers, i);
		if (PlayerInfo[i][pMember] == fid && GetPlayerVirtualWorld(i) == WarehouseInfo[warehouseid][whViwo] && !robber) 
		{
			if(IsPlayerInRangeOfPoint(i, 20.0, WarehouseInfo[warehouseid][whVault][0], WarehouseInfo[warehouseid][whVault][1], WarehouseInfo[warehouseid][whVault][2]))
				Iter_Add(Robbers, i);
		}
		else if(robber && (!IsPlayerInRangeOfPoint(i, 20.0, WarehouseInfo[warehouseid][whVault][0], WarehouseInfo[warehouseid][whVault][1], WarehouseInfo[warehouseid][whVault][2]) || GetPlayerVirtualWorld(i) != WarehouseInfo[warehouseid][whViwo]))
		{
			Iter_Remove(Robbers, i);
			if(PlayerInfo[i][pSQLID] == RobberyInfo[whMainRobberSQL])
			{
				SendRobbersMessage("[ ! ] Radi neuspjelog pokusaja, pljacka je obustavljena.");
				SendClientMessage(i, COLOR_RED, "[ ! ] Radi neuspjelog pokusaja, pljacka je obustavljena.");
				StopWarehouseRobbery();
				return 1;
			}
		}
	}
	return 1;
}

stock CheckAliveRobbers()
{
	if(Iter_Count(Robbers) == 0)
	{
		foreach(new i: Player)
		{
			if(PlayerInfo[i][pSQLID] == RobberyInfo[whMainRobberSQL])
				SendClientMessage(i, COLOR_RED, "[ ! ] Radi neuspjelog pokusaja, pljacka je obustavljena.");
		}
		StopWarehouseRobbery();
	}
}

task CheckWarehouseRobbery[1000]()
{
	if(RobberyInfo[whActive] == true)
	{
		if(RobberyInfo[whDuration] >= ROBBERY_DURATION)
			RobberyInfo[whSuceeded] = true;
		
		CheckAliveRobbers();
		if(RobberyInfo[whSuceeded] == false)
		{
			new fid = RobberyInfo[whRobberFaction],
				warehouseid = RobberyInfo[whVictimWarehouse];
			CheckRobbersInRadius(warehouseid, fid);
			if(Iter_Count(Robbers) == 0)
			{
				SendMainRobberMessage("[ ! ] Radi neuspjelog pokusaja, pljacka je obustavljena.");
				StopWarehouseRobbery();
				return 1;
			}
			RobberyInfo[whDuration]++;
		}
		else if(RobberyInfo[whSuceeded] == true && RobberyInfo[whExtractionArea] == -1)
		{
			new whid = RobberyInfo[whRobberWarehouse];
			RobberyInfo[whExtractionArea] = CreateDynamicCircle(WarehouseInfo[whid][whEnter][0], WarehouseInfo[whid][whEnter][1], 20.0);
			SendRobbersMessage("[ ! ] Prva faza pljacke je uspjesna. Trk sa robom do svog Warehousea!");
		}
	}
	return 1;
}

stock StartWarehouseRobbery(playerid, warehouseid)
{
	new fid = PlayerInfo[playerid][pMember],
		startmessage[128],
		vfid;
	
	RobberyInfo[whActive] = true;
	RobberyInfo[whDuration] = 0;
	RobberyInfo[whSuceeded] = false;
	RobberyInfo[whMainRobberSQL] = PlayerInfo[playerid][pSQLID];
	RobberyInfo[whExtractionArea] = -1;
	RobberyInfo[whRobberFaction] = fid;
	RobberyInfo[whRobberWarehouse] = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]);
	RobberyInfo[whVictimFaction] = FetchFactionEnumFromWarehouse(warehouseid);
	RobberyInfo[whVictimWarehouse] = warehouseid;
	
	CheckRobbersInRadius(warehouseid, fid);
	new robduration = ROBBERY_DURATION / 60;
	format(startmessage, sizeof(startmessage), "[ ! ] Pljacka %s Warehousea je zapocela. Ostanite u krugu %d minuta da bi dovrsili pljacku!", robduration);
	SendRobbersMessage(startmessage);
	
	vfid = RobberyInfo[whVictimFaction];
	format(startmessage, sizeof(startmessage), "AdmWarn: %s[ID:%d][%s] je zapoceo pljacku %s Warehousea. (/recon)", GetName(playerid,false), playerid, FactionInfo[fid][fName], FactionInfo[vfid][fName]);
    ABroadCast(COLOR_LIGHTRED,startmessage,1);
	
	WarehouseRobAlarm(warehouseid, RobberyInfo[whVictimFaction]);
	return 1;
}

stock StopWarehouseRobbery()
{
	Iter_Clear(Robbers);
	
	RobberyInfo[whActive] = false;
	RobberyInfo[whDuration] = 0;
	RobberyInfo[whSuceeded] = false;
	RobberyInfo[whMainRobberSQL] = -1;
	RobberyInfo[whRobberFaction] = -1;
	RobberyInfo[whRobberWarehouse] = -1;
	RobberyInfo[whVictimFaction] = -1;
	RobberyInfo[whVictimWarehouse] = -1;
	return 1;
}	

stock SendRobbersMessage(const string[])
{
	foreach(new i: Robbers)
		SendClientMessage(i, COLOR_YELLOW, string);
	return 1;
}

stock WarehouseRobAlarm(warehouseid, factionid)
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pWarehouseKey] == warehouseid || PlayerInfo[i][pLeader] == factionid)
			SendClientMessage(i, COLOR_YELLOW, "SMS: Tihi alarm Warehousea se oglasio na znakove provale.");
	}
	return 1;
}

stock SendMainRobberMessage(const string[])
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pSQLID] == RobberyInfo[whMainRobberSQL])
		{
			SendClientMessage(i, COLOR_RED, string);
			return 1;
		}
	}
	return 1;
}
	
stock TransferWarehouseGoods(rwhid, vwhid)
{
	new robberfid = RobberyInfo[whRobberFaction],
		victimfid = RobberyInfo[whVictimFaction],
		weaponUpdateQuery[100],
		rinfo[1024],
		motd[64],
		sqlid=-1,
		weaponid=0,
		ammo=0,
		guns = 0,
		gunsammo = 0,
		shotguns = 0,
		shotgunammo = 0,
		smgs = 0,
		smgammo = 0,
		assualts = 0,
		assualtammo = 0,
		rifles = 0,
		rifleammo = 0,
		nwslot = 0;

	format(motd, sizeof(motd), "%s Warehouse\n     Ukradene droge:\n", FactionInfo[victimfid][fName]);
	strcat(rinfo, motd, sizeof(rinfo));
	if(Iter_Count(WhWeapons[vwhid]) > 0)
	{
		foreach(new wslot: WhWeapons[vwhid])
		{
			format(weaponUpdateQuery, 100, "UPDATE `warehouse_weapons` SET `fid`='%d' WHERE `id`='%d'", 
				FactionInfo[robberfid][fID],
				WarehouseWeapons[vwhid][wslot][whWeaponSQL]
			);
			mysql_tquery(g_SQL, weaponUpdateQuery, "", "");
			
			nwslot = Iter_Free(WhWeapons[rwhid]);
			sqlid = WarehouseWeapons[vwhid][wslot][whWeaponSQL];
			weaponid = WarehouseWeapons[vwhid][wslot][whWeaponId];
			ammo = WarehouseWeapons[vwhid][wslot][whAmmo];
			
			WarehouseWeapons[rwhid][nwslot][whWeaponSQL] 	= sqlid;
			WarehouseWeapons[rwhid][nwslot][whFactionSQLID] = FactionInfo[robberfid][fID];
			WarehouseWeapons[rwhid][nwslot][whWeaponId] 	= weaponid;
			WarehouseWeapons[rwhid][nwslot][whAmmo] 		= ammo;
			Iter_Add(WhWeapons[rwhid], nwslot);
			
			WarehouseWeapons[vwhid][wslot][whWeaponSQL] 	= -1;
			WarehouseWeapons[vwhid][wslot][whFactionSQLID] = -1;
			WarehouseWeapons[vwhid][wslot][whWeaponId] 	= 0;
			WarehouseWeapons[vwhid][wslot][whAmmo] 		= 0;
			
			switch(weaponid)
			{
				case 22,24: {
					guns++; gunsammo += ammo; 
				}
				case 25: {
					shotguns++; shotgunammo += ammo;
				}
				case 28,29,32: {
					smgs++; smgammo += ammo;
				}
				case 30,31: {
					assualts++; assualtammo += ammo;
				}
				case 33,34:  {
					rifles++; rifleammo += ammo; 
				}
			}
		}
	}
	Iter_Clear(WhWeapons[vwhid]);
	format(motd, sizeof(motd), "   Ukradena oruzja:\n");
	strcat(rinfo, motd, sizeof(rinfo));
	if(guns > 0)
	{
		format(motd, sizeof(motd), "\tPistolji: %d | ~ metaka po pistolju: %d\n", guns, (gunsammo/guns));
		strcat(rinfo, motd, sizeof(rinfo));
	}
	if(shotguns > 0)
	{
		format(motd, sizeof(motd), "\tPuske: %d | ~ metaka po puski: %d\n", shotguns, (shotgunammo/shotguns));
		strcat(rinfo, motd, sizeof(rinfo));
	}
	if(smgs > 0)
	{
		format(motd, sizeof(motd), "\tSMGovi: %d | ~ metaka po SMG-u: %d\n", smgs, (smgammo/smgs));
		strcat(rinfo, motd, sizeof(rinfo));
	}
	if(assualts > 0)
	{
		format(motd, sizeof(motd), "\tAutom.puske: %d | ~ metaka po puski: %d\n", assualts, (assualtammo/assualts));
		strcat(rinfo, motd, sizeof(rinfo));
	}
	if(rifles > 0)
	{
		format(motd, sizeof(motd), "\tRifleovi: %d | ~ metaka po rifleu: %d", rifles, (rifleammo/rifles));
		strcat(rinfo, motd, sizeof(rinfo));
	}
	WarehouseInfo[rwhid][whMoney] += WarehouseInfo[vwhid][whMoney];
	if(WarehouseInfo[vwhid][whMoney] > 0)
	{
		format(motd, sizeof(motd), "\n     Ukradeno novaca: %d$", WarehouseInfo[vwhid][whMoney]);
		strcat(rinfo, motd, sizeof(rinfo));
	}
	WarehouseInfo[vwhid][whMoney] = 0;
	UpdateWarehouseMoney(rwhid);
	UpdateWarehouseMoney(vwhid);
	
	foreach(new i: Robbers)
	{
		ShowPlayerDialog(i, DIALOG_WAREHOUSE_INFO, DIALOG_STYLE_MSGBOX, "Plijen pljacke", rinfo, "Close", "");
		SendClientMessage(i, COLOR_RED, "[ ! ] Sva ukradena dobra su pohranjena u skladiste vase fakcije. Cestitke na uspjesnoj pljacki!");
	}
	StopWarehouseRobbery();
	return 1;
}

stock DoesWarehouseExist(factionid)
{
	new value = false;
	foreach(new wh: Warehouses)
	{
		if(WarehouseInfo[wh][whFactionSQLID] == factionid)
		{
			value = true;
			break;
		}
	}
	return value;
}

stock FetchWarehouseEnumFromFaction(factionid)
{
	new whid;
	foreach(new wh: Warehouses)
	{
		if(factionid == WarehouseInfo[wh][whFactionSQLID])
		{
			whid = wh;
			break;
		}
	}
	return whid;
}

static stock IsAtValidWarehouse(playerid, whid) // Provjerava da li igrac pred warehouseom SVOJE fakcije
{
	new fid = PlayerInfo[playerid][pMember];
	if( FactionInfo[fid][fID] == WarehouseInfo[whid][whFactionSQLID])
		return true;
	else return false;
}

stock LoadWarehouses() // Pod OnGameModeInit()
{
	foreach(new f: Factions)
	{
		new wh = Iter_Free(Warehouses);
		ResetWarehouseEnum(wh);
		for(new i = 0; i < MAX_WAREHOUSE_WEAPONS; i++)
		{	
			WarehouseWeapons[wh][i][whWeaponSQL] 	= -1;
			WarehouseWeapons[wh][i][whFactionSQLID] = -1;
			WarehouseWeapons[wh][i][whWeaponId] 	= 0;
			WarehouseWeapons[wh][i][whAmmo] 		= 0;
		}
		LoadFactionWarehouse(f);
	}
	return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	foreach(new wh: Warehouses)
	{
		if(pickupid == WarehouseInfo[wh][whPickupID])
		{
			GameTextForPlayer( playerid, "~w~Koristite ~g~/warehouse put/take/lock", 4000, 4 );
			break;
		}
	}
	return 1;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	if(areaid == RobberyInfo[whExtractionArea] && Iter_Contains(Robbers, playerid) && PlayerInfo[playerid][pSQLID] == RobberyInfo[whMainRobberSQL])
		TransferWarehouseGoods(RobberyInfo[whRobberWarehouse], RobberyInfo[whVictimWarehouse]);
	
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(RobberyInfo[whActive] == true && Iter_Contains(Robbers, playerid))
		Iter_Remove(Robbers, playerid);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[100];
	switch(dialogid)
	{
		case WAREHOUSE_PUT_MENU:
		{
			if(!response)
				return 1;
			switch(listitem)
			{
				case 0:
				{
					new weaponid = AC_GetPlayerWeapon(playerid),
						ammo = AC_GetPlayerAmmo(playerid);
					if(weaponid == 0 || ammo == 0)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nikakvo oruzje u ruci/oruzje nema municije.");
					else PutWeaponInWarehouse(playerid, weaponid, ammo);
				}
				case 1:
					ShowPlayerDialog(playerid, WAREHOUSE_MONEY_PUT, DIALOG_STYLE_INPUT, "Kolicina novca", "Unesite koliko novaca zelite pohraniti u warehouse.", "Input", "Exit");
			}
		}
		case WAREHOUSE_MONEY_PUT:
		{
			new amount = strval(inputtext);
			if(amount > AC_GetPlayerMoney(playerid))
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nosite unesenu svotu novaca u rukama da bi je mogli pohraniti u warehouse!");
			if(amount <= 0)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kolicina novca ne moze biti manja od 1$!");
			new fid = PlayerInfo[playerid][pMember],
				warehouseid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]);
			WarehouseInfo[warehouseid][whMoney] += amount;
			AC_GivePlayerMoney(playerid, -amount);
			UpdateWarehouseMoney(warehouseid);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste pohranili %d$ u %s warehouse.", amount);
			format( string, sizeof(string), "* %s pohranjuje %d$ u skladiste.", GetName(playerid, true), amount );
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
			ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/warehouse_put.txt", "(%s) %s[SQL:%d] stored %d$ in Warehouse %s[SQL:%d].",
				ReturnDate(),
				GetName(playerid, false),
				PlayerInfo[playerid][pSQLID],
				amount,
				FactionInfo[fid][fName],
				FactionInfo[fid][fID]
			);
			#endif
		}
		case WAREHOUSE_MONEY_TAKE:
		{
			new amount = strval(inputtext),
				fid = PlayerInfo[playerid][pMember],
				warehouseid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]);
			if(amount <= 0)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kolicina novca ne moze biti manja od 1$!");
			if((WarehouseInfo[warehouseid][whMoney] - amount) < 0)
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta kolicina novca se ne nalazi u warehouseu!");
			
			WarehouseInfo[warehouseid][whMoney] -= amount;
			AC_GivePlayerMoney(playerid, amount);
			UpdateWarehouseMoney(warehouseid);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %d$ iz %s warehousea.", amount);
			format( string, sizeof(string), "* %s uzima %d$ iz skladista.", GetName(playerid, true), amount );
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
			ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/warehouse_take.txt", "(%s) %s[SQL:%d] took %d$ from Warehouse %s[SQL:%d].",
				ReturnDate(),
				GetName(playerid, false),
				PlayerInfo[playerid][pSQLID],
				amount,
				FactionInfo[fid][fName],
				FactionInfo[fid][fID]
			);
			#endif
		}
		case WAREHOUSE_TAKE_MENU:
		{
			if(!response)
				return 1;
			switch(listitem)
			{
				case 0:
				{
					new fid = PlayerInfo[playerid][pMember],
						whid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]);
					if(!Iter_Count(WhWeapons[whid]))
						return SendClientMessage(playerid,  COLOR_RED, "Warehouse nema pohranjeno oruzje!");
					ShowPlayerDialog(playerid, DIALOG_TAKE_WEAPON_LIST, DIALOG_STYLE_LIST, "Odaberite oruzje:", ListPlayerWarehouseWeapons(playerid, whid), "Choose", "Exit");
				}
				case 1:
				{
					new fid = PlayerInfo[playerid][pMember],
						whid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]),
						moneyvalue[64];
					format(moneyvalue, sizeof(moneyvalue), "Trenutno stanje: %d$", WarehouseInfo[whid][whMoney]);
					ShowPlayerDialog(playerid, WAREHOUSE_MONEY_TAKE, DIALOG_STYLE_INPUT, moneyvalue, "Unesite koliko novaca zelite uzeti iz warehousea.", "Input", "Exit");
				}
			}
		}
		case DIALOG_TAKE_WEAPON_LIST:
		{
			if(!response)
			{
				ResetPlayerWeaponList(playerid);
				return 1;
			}
			new fid = PlayerInfo[playerid][pMember],
				whid = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]),
				wslot = WeaponToList[playerid][listitem],
				wname[32],
				weaponid = WarehouseWeapons[whid][wslot][whWeaponId],
				ammo = WarehouseWeapons[whid][wslot][whAmmo];

			if (! CheckPlayerWeapons(playerid, weaponid) ) return 1;
			AC_GivePlayerWeapon(playerid, weaponid, ammo);
			GetWeaponName(weaponid, wname, 32);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %s(%d) iz warehousea.", wname, ammo);
			format( string, sizeof(string), "* %s uzima %s iz skladista.", GetName(playerid, true), wname );
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
			new	puzavac = IsCrounching(playerid);
			SetAnimationForWeapon(playerid, weaponid, puzavac);
			RemoveWeaponFromWarehouse(whid, wslot);
			ResetPlayerWeaponList(playerid);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/warehouse_take.txt", "(%s) %s[SQL:%d] took %s(%d) from Warehouse %s[SQL:%d].",
				ReturnDate(),
				GetName(playerid, false),
				PlayerInfo[playerid][pSQLID],
				wname,
				ammo,
				FactionInfo[fid][fName],
				FactionInfo[fid][fID]
			);
			#endif
			return 1;
		}
	}
	return 1;
}

CMD:warehouse(playerid, params[])
{
	new option[16];
	if (sscanf(params, "s[16] ",option)) {
	    SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warehouse [OPCIJA]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] enter - exit - info - put - take - lock - givekeys - rob");
	    return 1;
	}
	if(strcmp(option,"info",true) == 0)
	{
		new wh = IsAtWarehouseEntrance(playerid),
			flid = PlayerInfo[playerid][pLeader];

		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(!IsAtValidWarehouse(playerid, wh))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(PlayerInfo[playerid][pWarehouseKey] != WarehouseInfo[wh][whFactionSQLID] && FactionInfo[flid][fID] != WarehouseInfo[wh][whFactionSQLID])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Popis inventara moze vidjeti samo Leader/osoba kojoj je leader povjerio kljuceve!");
			
		new motd[2048],
			f = FetchFactionEnumFromWarehouse(wh);
			
		format(motd, sizeof(motd), "%s Warehouse\n        Financijsko stanje: %d$\n        %s\n        %s", FactionInfo[f][fName], WarehouseInfo[wh][whMoney], ListWarehouseWeapons(wh));
		ShowPlayerDialog(playerid, DIALOG_WAREHOUSE_INFO, DIALOG_STYLE_MSGBOX, "Popis inventara", motd, "Close", "");
		return 1;
	}
	if(strcmp(option,"enter",true) == 0)
	{
		new wh = IsAtWarehouseEntrance(playerid);
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred warehousea!");
			
		Bit1_Set( gr_PlayerEntering, playerid, true );
		SetPlayerPosEx( playerid, WarehouseInfo[wh][whExit][0], WarehouseInfo[wh][whExit][1], WarehouseInfo[wh][whExit][2], WarehouseInfo[wh][whViwo], WarehouseInfo[wh][whInt], true );
		Bit16_Set( gr_PlayerInWarehouse, playerid, wh );
		return 1;
	}
	/*
	if(strcmp(option,"getgun",true) == 0) {
		new buffer[512],
		motd[64],
			wh = IsAtWarehouseVault(playerid);
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta(pickup-a) warehousea svoje organizacije!");
		if(!IsAtValidWarehouse(playerid, wh))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta(pickup-a) warehousea svoje organizacije!");
		if( IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete to koristiti!");
			
		format(buffer, sizeof(buffer), "{3C95C2}Weapon\t{3C95C2}Bullet Price\n");
		for( new i = 0; i < MAX_LISTED_WEAPONS; i++ ) 
		{
			format(motd, sizeof(motd), "%s\t%s\n", show_WeaponList[i][wep_Name], FormatNumber(show_WeaponList[i][wep_Price]));
			strcat(buffer, motd, sizeof(buffer));
		}
		ShowPlayerDialog(playerid, DIALOG_PACKAGE_ORDER, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Package - List", buffer, "Select", "Close");
	}*/
	if(strcmp(option,"exit",true) == 0)
	{
		new wh = IsAtWarehouseExit(playerid);
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred warehousea!");
			
		Bit1_Set( gr_PlayerExiting, playerid, true );
		SetPlayerPosEx( playerid, WarehouseInfo[wh][whEnter][0], WarehouseInfo[wh][whEnter][1], WarehouseInfo[wh][whEnter][2], 0, 0, false );
		Bit16_Set( gr_PlayerInWarehouse, playerid, INVALID_HOUSE_ID );
		return 1;
	}
	if(strcmp(option,"put",true) == 0)
	{
		new wh = IsAtWarehouseVault(playerid);
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(!IsAtValidWarehouse(playerid, wh))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(WarehouseInfo[wh][whLocked] == true)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sef warehousea je zakljucan!");
		ShowPlayerDialog(playerid, WAREHOUSE_PUT_MENU, DIALOG_STYLE_LIST, "Odaberite sto zelite pohraniti u warehouse:", "Oruzje u ruci\nDroga\nNovac", "Choose", "Exit");
	}
	if(strcmp(option,"take",true) == 0)
	{
		new wh = IsAtWarehouseVault(playerid);
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(!IsAtValidWarehouse(playerid, wh))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(WarehouseInfo[wh][whLocked] == true)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Sef warehousea je zakljucan!");
		ShowPlayerDialog(playerid, WAREHOUSE_TAKE_MENU, DIALOG_STYLE_LIST, "Odaberite sto zelite izvaditi iz warehousea:", "Oruzje\nDroga\nNovac", "Choose", "Exit");
	}
	if(strcmp(option,"lock",true) == 0)
	{
		new wh = IsAtWarehouseVault(playerid),
			flid = PlayerInfo[playerid][pLeader],
			string[64];
		if( wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(!IsAtValidWarehouse(playerid, wh))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred vaulta warehousea svoje organizacije!");
		if(PlayerInfo[playerid][pWarehouseKey] != WarehouseInfo[wh][whFactionSQLID] && FactionInfo[flid][fID] != WarehouseInfo[wh][whFactionSQLID])
			return SendClientMessage(playerid,  COLOR_RED, "Nemate kljuc od sefa warehousea.");
		if(WarehouseInfo[wh][whLocked] == false)
		{
			WarehouseInfo[wh][whLocked] = true;
			GameTextForPlayer( playerid, "~w~Sef ~r~zakljucan", 800, 4 );
			format( string, sizeof(string), "* %s zakljucava sef skladista.", GetName(playerid, true) );
			ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
		}
		else if(WarehouseInfo[wh][whLocked] == true)
		{
			WarehouseInfo[wh][whLocked] = false;
			GameTextForPlayer( playerid, "~w~Sef ~g~otkljucan", 800, 4 );
			format( string, sizeof(string), "* %s otkljucava sef skladista.", GetName(playerid, true) );
			ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,0, 1, 0);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 8000);
		}
		UpdateWarehouseLock(wh);
		return 1;
	}
	if(strcmp(option,"givekeys",true) == 0)
	{
		new fid = PlayerInfo[playerid][pMember],
			flid = PlayerInfo[playerid][pLeader],
			wh = FetchWarehouseEnumFromFaction(FactionInfo[fid][fID]),
			giveplayerid;
		
		if (sscanf(params, "s[16]u", option, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warehouse givekeys [ID/DioImena]");
		if(giveplayerid == playerid)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi dati kljuceve!");
		if(!DoesWarehouseExist(FactionInfo[fid][fID]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa fakcija ne posjeduje warehouse!");
		if(PlayerInfo[playerid][pWarehouseKey] != WarehouseInfo[wh][whFactionSQLID] && FactionInfo[flid][fID] != WarehouseInfo[wh][whFactionSQLID]) 
			return SendClientMessage(playerid,  COLOR_RED, "Nemate kljuc od sefa warehousea / niste leader organizacije.");
		if( !IsPlayerLogged(giveplayerid) || !IsPlayerConnected(giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije ulogiran!");
		if(PlayerInfo[giveplayerid][pMember] != PlayerInfo[playerid][pMember])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije clan vase organizacije da bi mu mogli dati svoje kljuceve skladista!");
		
		if(PlayerInfo[playerid][pWarehouseKey] != -1)
			PlayerInfo[playerid][pWarehouseKey] = -1;
		PlayerInfo[giveplayerid][pWarehouseKey] = WarehouseInfo[wh][whFactionSQLID];
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste dali %s kljuceve od skladista %s.", GetName(giveplayerid, true), FactionInfo[fid][fName]);
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] %s %s vam je dao kljuceve od skladista %s.", ReturnPlayerRankName(playerid), GetName(playerid, true), FactionInfo[fid][fName]);
		return 1;
	}	
	if(strcmp(option,"rob",true) == 0)
	{
		new wh = IsAtWarehouseVault(playerid),	
			fid = PlayerInfo[playerid][pMember];
		if(RobberyInfo[whActive] == true)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pljacka je vec u toku. Pricekajte neko vrijeme pa pokusajte ponovno!");
		if(!DoesWarehouseExist(FactionInfo[fid][fID]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa fakcija ne posjeduje warehouse!");
		if(wh == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred warehouse vaulta!");
		if(IsAtValidWarehouse(playerid, wh))
			return SendClientMessage(playerid, COLOR_RED, "[GREKSA]: Ne mozete opljackati warehouse vlastite fakcije!");
		if(CountOnlineMembers(WarehouseInfo[wh][whFactionSQLID]) < MIN_DEFENDERS)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi opljackali ovaj warehouse, minimalno %d clanova fakcije u vlasnistvu istog trebaju biti online!", MIN_DEFENDERS);
		if(CountMembersInRadius(wh, fid) < MIN_ROBBERS)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi pokrenuli pljacku, minimalno %d clanova vase fakcije trebaju biti u krugu 20m od warehouse sefa!", MIN_ROBBERS);
		
		StartWarehouseRobbery(playerid, wh);
	}	
	return 1;
}

CMD:awarehouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid,COLOR_RED, "Niste ovlasteni za koristenje ove komande.");
	new option[16];
	if (sscanf(params, "s[16] ",option)) {
	    SendClientMessage(playerid, COLOR_RED, "[ ? ]: /awarehouse [OPCIJA]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] list - add - remove - move - goto");
	    return 1;
	}
	if(strcmp(option,"list",true) == 0)
	{
		new buffer[4096],motd[2048];
		foreach(new wh: Warehouses)
		{
			new f = FetchFactionEnumFromWarehouse(wh);
			format(motd, sizeof(motd), "Faction ID: %d | %s Warehouse\n        Financijsko stanje: %d$\n        %s\n        %s", FactionInfo[f][fID], FactionInfo[f][fName], WarehouseInfo[wh][whMoney], ListWarehouseWeapons(wh));
			strcat(buffer, motd, sizeof(buffer));
		}
		ShowPlayerDialog(playerid, DIALOG_WAREHOUSE_INFO, DIALOG_STYLE_MSGBOX, "Popis warehouseova", buffer, "Close", "");
		return 1;
	}
	if(strcmp(option,"add",true) == 0)
	{
		new facID;
		if (sscanf(params, "s[16]i", option, facID)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /awarehouse add [Faction ID]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Da bi dosli do Faction ID-a, koristite /afaction list");
			return 1;
		}
		if(facID < 1 || facID > MAX_FACTIONS) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Faction ID ne moze biti manji od 1 niti veci od %d.", MAX_FACTIONS);
			
		new fcid = FetchFactionEnumFromSQLID(facID);
		
		if(DoesWarehouseExist(FactionInfo[fcid][fID]))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Warehouse pod ID-em %d vec postoji(%s).", FactionInfo[fcid][fID], FactionInfo[fcid][fName]);
			
		new Float:nPos[3];
		GetPlayerPos(playerid, nPos[0], nPos[1], nPos[2]);
		new	freeslot = Iter_Free(Warehouses);
			
		AddWarehouse(freeslot, fcid, nPos[0], nPos[1], nPos[2]);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "%s Warehouse(ID %d) je uspjesno stvoren na vasoj trenutnoj poziciji.", FactionInfo[fcid][fName], FactionInfo[fcid][fID]);
		return 1;
	}
	if(strcmp(option,"remove",true) == 0)
	{
		new facID;
		if (sscanf(params, "s[16]i", option, facID)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: awarehouse remove [Faction ID]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Da bi dosli do Faction ID-a, koristite /afaction list");
			return 1;
		}
		if(facID < 1 || facID > MAX_FACTIONS) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Faction ID ne moze biti manji od 1 niti veci od %d.", MAX_FACTIONS);
			
		new fcid = FetchFactionEnumFromSQLID(facID);
		
		if(!DoesWarehouseExist(FactionInfo[fcid][fID]))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Warehouse pod ID-em %d ne postoji!", FactionInfo[fcid][fID]);
			
		new Float:nPos[3];
		GetPlayerPos(playerid, nPos[0], nPos[1], nPos[2]);
		new	whid = FetchWarehouseEnumFromFaction(FactionInfo[fcid][fID]);
			
		RemoveWarehouse(whid);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "%s Warehouse(ID %d) je uspjesno izbrisan iz baze podataka.", FactionInfo[fcid][fName], FactionInfo[fcid][fID]);
		return 1;
	}
	if(strcmp(option,"move",true) == 0)
	{
		new facID;
		if (sscanf(params, "s[16]i", option, facID)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /awarehouse move [Faction ID]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Da bi dosli do Faction ID-a, koristite /afaction list");
			return 1;
		}
		if(facID < 1 || facID > MAX_FACTIONS) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Faction ID ne moze biti manji od 1 niti veci od %d.", MAX_FACTIONS);
			
		new whid = FetchWarehouseEnumFromFaction(facID),
			fcid = FetchFactionEnumFromSQLID(facID);
			
		if(!Iter_Contains(Warehouses, whid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Organizacija %s ne posjeduje warehouse.", FactionInfo[fcid][fName]);
			
		new Float:nPos[3];
		GetPlayerPos(playerid, nPos[0], nPos[1], nPos[2]);
		MoveWarehouse(whid, nPos[0], nPos[1], nPos[2]);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Ulaz u %s Warehouse je uspjesno premjesten na vasu trenutnu poziciju.", FactionInfo[fcid][fName]);
		return 1;
	}
	if(strcmp(option,"goto",true) == 0)
	{
		new facID, whid;
		if (sscanf(params, "s[16]i", option, facID)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /awarehouse goto [Faction ID]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Da bi dosli do Faction ID-a, koristite /afaction list");
		}
		if(facID < 1 || facID > MAX_FACTIONS) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Warehouse ID ne moze biti manji od 1 niti veci od %d.", MAX_FACTIONS);
		whid = FetchWarehouseEnumFromFaction(facID);
		if(!DoesWarehouseExist(WarehouseInfo[whid][whFactionSQLID]))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Warehouse pod ID-em %d ne postoji!", whid);
		new factionid = FetchFactionEnumFromSQLID(WarehouseInfo[whid][whFactionSQLID]);
		SetPlayerPosEx( playerid, WarehouseInfo[whid][whEnter][0], WarehouseInfo[whid][whEnter][1], WarehouseInfo[whid][whEnter][2], 0, 0, false );
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste portani do %s Warehousea (Faction ID %d)", FactionInfo[factionid][fName], FactionInfo[factionid][fID]);
		return 1;
	}
	return 1;
}
