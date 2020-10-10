#include <YSI\y_hooks>

#if defined MODULE_AC
	#endinput
#endif
#define MODULE_AC

#define AC_MIN_TIME_RECONNECT				(15)			// seconds

// Anti Vehicle Teleport
#define MAX_VEHICLE_DISTANCE_TO_TRAILER 	(15.0)
#define MAX_VEHICLE_DISTANCE_CHANGE			(40.0)


/*
	######## ##    ## ##     ## ##     ##
	##       ###   ## ##     ## ###   ###
	##       ####  ## ##     ## #### ####
	######   ## ## ## ##     ## ## ### ##
	##       ##  #### ##     ## ##     ##
	##       ##   ### ##     ## ##     ##
	######## ##    ##  #######  ##     ##
*/
enum E_PLAYER_WEAPONS
{
	pwSQLID[13],
	pwWeaponId[13],
	pwAmmo[13],
	pwHidden[13]
}
new
	PlayerWeapons[MAX_PLAYERS][E_PLAYER_WEAPONS];




/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// BustAim
new AimWarns[MAX_PLAYERS] = 0,
	AimWarnStamp[MAX_PLAYERS] = 0; //Needs to be reset on OnPlayerConnect

/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/

timer ResetVehicleSafeTeleport[60](vehicleid)
{
	VehicleInfo[vehicleid][vServerTeleport] = false;
	return 1;
}

timer ResetVehicleSafeDelete[100](vehicleid)
{
	VehicleInfo[vehicleid][vDeleted] = false;
	return 1;
}

/*
	##     ##  #######  ##    ## ######## ##    ##
	###   ### ##     ## ###   ## ##        ##  ##
	#### #### ##     ## ####  ## ##         ####
	## ### ## ##     ## ## ## ## ######      ##
	##     ## ##     ## ##  #### ##          ##
	##     ## ##     ## ##   ### ##          ##
	##     ##  #######  ##    ## ########    ##
*/
stock AC_GivePlayerMoney(playerid, amount)
{
    PlayerInfo[playerid][pMoney] += amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();

	new str[20], Float:x, Float:y, Float:z, tmpQuery[128];
	GetPlayerPos(playerid, x,y,z);
	if(amount < 0)
	    format(str, 20, "~r~%d$", amount);
	else
 		format(str, 20, "~g~+%d$", amount);
    GameTextForPlayer(playerid, str, 1000, 1);
    PlayerPlaySound(playerid, 1054 ,x,y,z);
	// Update u tablice odma --------------------
	format( tmpQuery, sizeof(tmpQuery), "UPDATE `accounts` SET `handMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, tmpQuery, "", "");
	// ---------------------------------
	return PlayerInfo[playerid][pMoney];
}

stock AC_SetPlayerMoney(playerid, amount)
{
	new tmpQuery[128];
	PlayerInfo[playerid][pMoney] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();
	// Update u tablice odma --------------------
	format( tmpQuery, sizeof(tmpQuery), "UPDATE `accounts` SET `handMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, tmpQuery, "", "");
	// ---------------------------------
	return PlayerInfo[playerid][pMoney];
}

stock AC_GetPlayerMoney(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	return PlayerInfo[playerid][pMoney];
}

stock AC_ResetPlayerMoney(playerid)
{
	PlayerInfo[playerid][pMoney] = 0;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	PlayerTick[playerid][ptMoney] = gettimestamp();
	return 1;
}

stock AC_MoneyDetect(playerid)
{
	//Anti-Money
	new serverMoney = AC_GetPlayerMoney(playerid),
		realMoney 	= GetPlayerMoney(playerid);

	if(realMoney > serverMoney) {
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	}
	else if(realMoney < serverMoney) {
		if(((serverMoney - realMoney) == 1) && (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT))
			PlayerInfo[playerid][pMoney]--;

		AC_SetPlayerMoney(playerid, serverMoney);
	}
	return 1;
}

/*
	##      ## ########    ###    ########   #######  ##    ##  ######
	##  ##  ## ##         ## ##   ##     ## ##     ## ###   ## ##    ##
	##  ##  ## ##        ##   ##  ##     ## ##     ## ####  ## ##
	##  ##  ## ######   ##     ## ########  ##     ## ## ## ##  ######
	##  ##  ## ##       ######### ##        ##     ## ##  ####       ##
	##  ##  ## ##       ##     ## ##        ##     ## ##   ### ##    ##
	 ###  ###  ######## ##     ## ##         #######  ##    ##  ######
 */
 
Function: LoadPlayerWeapons(playerid)
{
	if(cache_num_rows())
	{
		new
			sqlid = -1,
			weaponid = 0,
			ammo = 0,
			hidden = 0;

	    for( new i = 0; i < cache_num_rows(); i++ )
		{
			cache_get_value_name_int( i, "sqlid", sqlid);
			cache_get_value_name_int( i, "weapon_id", weaponid);
			cache_get_value_name_int( i, "weapon_ammo", ammo);
			cache_get_value_name_int( i, "hidden", hidden);
			if(hidden == 1)
			{
				HiddenWeapon[playerid][pwSQLID] = sqlid;
				HiddenWeapon[playerid][pwWeaponId] = weaponid;
				HiddenWeapon[playerid][pwAmmo] = ammo;
				continue;
			}
			PlayerWeapons[playerid][pwSQLID][GetWeaponSlot(weaponid)] 		= sqlid;
			AC_GivePlayerWeapon(playerid, weaponid, ammo, false, false);

			#if defined MOD_DEBUG
				printf("[DEBUG] WEAPONS: i(%d) | sqlid(%d) | weaponid(%d) | ammo(%d)", i, PlayerWeapons[playerid][pwSQLID][GetWeaponSlot(weaponid)], PlayerWeapons[playerid][pwWeaponId][GetWeaponSlot(weaponid)], PlayerWeapons[playerid][pwAmmo][GetWeaponSlot(weaponid)]);
			#endif
		}
	}
	return 1;
}

Function: OnWeaponInsertQuery(playerid, slotid)
{
	PlayerWeapons[playerid][pwSQLID][slotid] = cache_insert_id();
	return 1;
}

stock AC_LoadPlayerWeapons(playerid)
{
	new
		loadPlayaWeapons[72];
	format(loadPlayaWeapons, 72, "SELECT * FROM `player_weapons` WHERE `player_id` = '%d'",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_pquery(g_SQL, loadPlayaWeapons, "LoadPlayerWeapons", "i", playerid);
	return 1;
}

stock AC_SavePlayerWeapon(playerid, slotid)
{
	if(PlayerWeapons[playerid][pwAmmo][slotid] <= 0 || PlayerWeapons[playerid][pwWeaponId][slotid] <= 0) return 1;
	new weapons[13][2];
	for (new i = 0; i <= 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
		if(weapons[i][0] == PlayerWeapons[playerid][pwWeaponId][slotid] && (PlayerWeapons[playerid][pwAmmo][slotid] + 5) <= weapons[i][1]) // + 5 bullets in case of lagg
			return 1;
	}
	if( !SafeSpawned[playerid] )  return 1;

	new
		weaponUpdate[160];
	if(PlayerWeapons[playerid][pwSQLID][slotid] != -1 && PlayerWeapons[playerid][pwAmmo][slotid] > 0)
	{
		format(weaponUpdate, 160, "UPDATE `player_weapons` SET `player_id` = '%d', `weapon_id` = '%d', `weapon_ammo` = '%d', `hidden` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pSQLID],
			PlayerWeapons[playerid][pwWeaponId][slotid],
			PlayerWeapons[playerid][pwAmmo][slotid],
			PlayerWeapons[playerid][pwHidden][slotid],
			PlayerWeapons[playerid][pwSQLID][slotid]
		);
		mysql_tquery(g_SQL, weaponUpdate, "", "");
	}
	else if(PlayerWeapons[playerid][pwSQLID][slotid] == -1 && PlayerWeapons[playerid][pwAmmo][slotid] > 0)
	{
		format(weaponUpdate, 160, "INSERT INTO `player_weapons` (`player_id`, `weapon_id`, `weapon_ammo`, `hidden`) VALUES ('%d', '%d', '%d', '%d')",
			PlayerInfo[playerid][pSQLID],
			PlayerWeapons[playerid][pwWeaponId][slotid],
			PlayerWeapons[playerid][pwAmmo][slotid],
			PlayerWeapons[playerid][pwHidden][slotid]
		);
		mysql_tquery(g_SQL, weaponUpdate, "OnWeaponInsertQuery", "ii", playerid, slotid);
	}
	return 1;
}

stock AC_SavePlayerWeapons(playerid)
{
	AC_SavePlayerWeapon(playerid, 0);
	AC_SavePlayerWeapon(playerid, 1);
	AC_SavePlayerWeapon(playerid, 2);
	AC_SavePlayerWeapon(playerid, 3);
	AC_SavePlayerWeapon(playerid, 4);
	AC_SavePlayerWeapon(playerid, 5);
	AC_SavePlayerWeapon(playerid, 6);
	AC_SavePlayerWeapon(playerid, 7);
	AC_SavePlayerWeapon(playerid, 8);
	AC_SavePlayerWeapon(playerid, 9);
	AC_SavePlayerWeapon(playerid, 10);
	AC_SavePlayerWeapon(playerid, 11);
	AC_SavePlayerWeapon(playerid, 12);

}

stock AC_DecreasePlayerWeaponAmmo(playerid, weaponid, amount)
{
	new
		slot = GetWeaponSlot(weaponid);
	PlayerWeapons[playerid][pwAmmo][slot] -= amount;
	if( PlayerWeapons[playerid][pwAmmo][slot] <= 0 )
		AC_ResetPlayerWeapon(playerid, weaponid);
	return 1;
}

stock AC_GivePlayerWeapon(playerid, weaponid, ammo, bool:base_update=true, bool:hidden=false)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	if( !weaponid ) return 0;
	if( !ammo ) 	return 0;
	if( PlayerInfo[playerid][pLevel] < 2 ) return 0;

	new
		slot = GetWeaponSlot(weaponid);
	//Setting weapon in correct slot
	if(hidden)
		PlayerWeapons[playerid][pwSQLID][slot] = HiddenWeapon[playerid][pwSQLID];

	PlayerWeapons[playerid][pwWeaponId][slot] 	= weaponid;
	PlayerWeapons[playerid][pwAmmo][slot] 		+= ammo;
	PlayerWeapons[playerid][pwHidden][slot] 	= 0;

	
	//Real Give Func
	if(SafeSpawned[playerid])
		GivePlayerWeapon(playerid, weaponid, ammo);

	if(base_update && SafeSpawned[playerid])
		AC_SavePlayerWeapon(playerid, slot);

	//Tick 3sec
	PlayerTick[playerid][ptWeapon] = gettimestamp() + 2;
	return 1;
}

stock SortWeaponSlot(weaponid)
{
	new value = 0;
	switch(weaponid)
	{
		case 22,23,24: value = 2;
		case 25,26,27,28,29,30,31,32,33,34: value = 1;
		default: value = 0;
	}
	return value;
}

stock ResetWeaponSlot(playerid, weaponid)
{
	new slot = SortWeaponSlot(weaponid);
	switch (slot)
	{
		case 1: PlayerInfo[playerid][pPrimaryWeapon] = 0;
		case 2: PlayerInfo[playerid][pSecondaryWeapon] = 0;
	}
	return 1;
}

stock ResetWeaponSlots(playerid)
{
	PlayerInfo[playerid][pPrimaryWeapon] = 0;
	PlayerInfo[playerid][pSecondaryWeapon] = 0;
	return 1;
}

stock CheckPlayerWeapons(playerid, weaponid, bool:hidden_fetch=false)
{
	new bool:value = false,
		order = SortWeaponSlot(weaponid);

	if(HiddenWeapon[playerid][pwWeaponId] == weaponid && !hidden_fetch)
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate sakriven ovaj tip oruzja. (( /weapon hide )).");
		return 0;
	}
	switch(order)
	{
		case 0: value = true;
		case 1:
		{
			if(PlayerInfo[playerid][pPrimaryWeapon] != 0 && PlayerInfo[playerid][pPrimaryWeapon] != weaponid)
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "Primary Weapon Slot Vam je zauzet. Oslobodite ga da bi mogli uzeti novi Shotgun/Assuault/Rifle/SMG.");
				value = false;
			}
			else if(PlayerInfo[playerid][pPrimaryWeapon] == 0)
			{
				PlayerInfo[playerid][pPrimaryWeapon] = weaponid;
				value = true;
			}
			else if(PlayerInfo[playerid][pPrimaryWeapon] == weaponid)
				value = true;
		}
		case 2:
		{
			if( !Bit1_Get(gr_Taser, playerid) )
			{
				if(PlayerInfo[playerid][pSecondaryWeapon] != 0 && PlayerInfo[playerid][pSecondaryWeapon] != weaponid)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Secondary Weapon Slot Vam je zauzet. Oslobodite ga da bi mogli uzeti novi sidearm pistolj.");
					value = false;
				}
				else if(PlayerInfo[playerid][pSecondaryWeapon] == 0)
				{
					PlayerInfo[playerid][pSecondaryWeapon] = weaponid;
					value = true;
				}
				else if(PlayerInfo[playerid][pSecondaryWeapon] == weaponid)
					value = true;
			}
			else if( weaponid == WEAPON_SILENCED )
				value = true;
		}
	}
	return value;
}

stock AC_SetPlayerAmmo(playerid, weaponid, ammo)
{
	//Setting weapon in correct slot
	new
		slot = GetWeaponSlot(weaponid);

	PlayerWeapons[playerid][pwAmmo][slot] 		= ammo;

	//Real Give Func
	SetPlayerAmmo(playerid, weaponid, ammo);

	//Tick
	PlayerTick[playerid][ptWeapon] = gettimestamp() + 1;
	return 1;
}

stock AC_SetPlayerWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	for (new i = 0; i <= 12; i++) 
	{
		if(PlayerWeapons[playerid][pwAmmo][i] <= 0)
			continue;
		GivePlayerWeapon(playerid, PlayerWeapons[playerid][pwWeaponId][i], PlayerWeapons[playerid][pwAmmo][i]);
	}
	SetPlayerArmedWeapon(playerid, 0);
	UpdatePlayerWeaponSettings(playerid);
	//Tick
	PlayerTick[playerid][ptWeapon] = gettimestamp() + 5;
	return 1;
}

stock AC_GetPlayerWeapon(playerid) {
	//if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) maknuto zbog gunrack
	//	return 0;

	return PlayerWeapons[playerid][pwWeaponId][GetWeaponSlot(GetPlayerWeapon(playerid))];
}

stock AC_GetPlayerAmmo(playerid) {
	//if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) gunrack
	//	return 0;

	return PlayerWeapons[playerid][pwAmmo][GetWeaponSlot(GetPlayerWeapon(playerid))];
}

stock AC_ResetPlayerWeapons(playerid, bool:base_reset=true)
{
	ResetPlayerWeapons(playerid);
	ResetWeaponSlots(playerid);
	for (new slot = 0; slot <= 12; slot++)
	{
		if(base_reset)
			PlayerWeapons[playerid][pwSQLID][slot] = -1;
		PlayerWeapons[playerid][pwWeaponId][slot] 	= 0;
		PlayerWeapons[playerid][pwAmmo][slot] 		= 0;
	}
	SetPlayerArmedWeapon(playerid, 0);
	PlayerTick[playerid][ptWeapon] = gettimestamp() + 5;

	if(base_reset)
	{
		// MySQL Query
		new
			weapDeleteQuery[128];
		format(weapDeleteQuery, 128, "DELETE FROM `player_weapons` WHERE `player_id` = '%d'", PlayerInfo[playerid][pSQLID]);
		mysql_tquery(g_SQL, weapDeleteQuery, "", "");
	}
	return 1;
}

stock AC_ResetPlayerWeapon(playerid, weaponid, bool:base_update=true)
{
	//Uzimamo vrijednosti oruzja
	new Weapon[13][2];
	for (new i = 0; i <= 12; i++)
	{
		if(PlayerWeapons[playerid][pwAmmo][i] <= 0)
			continue;
		if(PlayerWeapons[playerid][pwWeaponId][i] == weaponid) 
		{
			if(base_update)
				PlayerWeapons[playerid][pwSQLID][i] = -1;
				
			PlayerWeapons[playerid][pwWeaponId][i] 	= 0;
			PlayerWeapons[playerid][pwAmmo][i] 		= 0;
		}
		else {
			Weapon[i][0] = PlayerWeapons[playerid][pwWeaponId][i];
			Weapon[i][1] = PlayerWeapons[playerid][pwAmmo][i];
		}
	}
	ResetWeaponSlots(playerid);
	AC_ResetPlayerWeapons(playerid, false);

	for (new i = 0; i <= 12; i++) {

		if(Weapon[i][1] <= 0)
			continue;
		if(!CheckPlayerWeapons(playerid, Weapon[i][0]))
			continue;
		AC_GivePlayerWeapon(playerid, Weapon[i][0], Weapon[i][1], false);
	}

	// MySQL Query
	if(base_update)
	{
		new
			weapDeleteQuery[128];
		format(weapDeleteQuery, 128, "DELETE FROM `player_weapons` WHERE `player_id` = '%d' AND `weapon_id` = '%d'", PlayerInfo[playerid][pSQLID], weaponid);
		mysql_tquery(g_SQL, weapDeleteQuery, "", "");
	}
	//Tick
	PlayerTick[playerid][ptWeapon] = gettimestamp() + 5;
	return 1;
}

stock PacketLossCheck(playerid)
{
	new Float:packetLoss;
	GetPlayerPacketloss(playerid, packetLoss);
	if(packetLoss >= 40.0)
	{
		Log_Write("logfiles/packageloss_kick.txt", "(%s) %s(IP: %s) is automatically kicked by server. Reason: Package Loss(%.2f percent).",
			ReturnDate(),
			GetName(playerid, false),
			GetPlayerIP(playerid),
			packetLoss
		);
		new kickstring[128];
		format(kickstring, sizeof(kickstring), "[SERVER] %s(IP: %s) je kickan radi Package Loss-a(%.2f posto).",
			GetName(playerid, false),
			GetPlayerIP(playerid),
			packetLoss);

		ABroadCast(COLOR_RED,kickstring,1);

		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobio si automatski kick od servera radi desynca/slabe konekcije. Ponovno se logiraj.");
		KickMessage(playerid);
	}
	return 1;
}

/*
	##     ## ######## ##     ##    ##     ## ########    ###    ##       ######## ##     ##
	##     ## ##       ##     ##    ##     ## ##         ## ##   ##          ##    ##     ##
	##     ## ##       ##     ##    ##     ## ##        ##   ##  ##          ##    ##     ##
	##     ## ######   #########    ######### ######   ##     ## ##          ##    #########
	 ##   ##  ##       ##     ##    ##     ## ##       ######### ##          ##    ##     ##
	  ## ##   ##       ##     ##    ##     ## ##       ##     ## ##          ##    ##     ##
	   ###    ######## ##     ##    ##     ## ######## ##     ## ########    ##    ##     ##
*/

stock AC_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay = -1, sirenon = 0)
{
	new
		id = CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, sirenon);

	if(!Iter_Contains(Vehicles, id))
		Iter_Add(Vehicles, id);

	VehicleInfo[id][vModel] = vehicletype;
	VehicleInfo[id][vRespawn] = respawn_delay;
	VehicleInfo[id][vServerTeleport] = false;
	VehicleInfo[id][vViwo] = GetVehicleVirtualWorld(id);


	VehiclePrevInfo[id][vPosX] = x;
	VehiclePrevInfo[id][vPosY] = y;
	VehiclePrevInfo[id][vPosZ] = z;
	VehiclePrevInfo[id][vRotZ] = rotation;
	VehiclePrevInfo[id][vPosDiff] = 0.0;

	CheckVehicleObjects(id);
	return id;
}

stock AC_DestroyVehicle(vehicleid)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 		return 0;
	if( !Iter_Contains(Vehicles, vehicleid) || !IsValidVehicle(vehicleid) )	
		return 0;

	RemoveAllVehicleTuning(vehicleid);
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	if(VehicleInfo[vehicleid][vUsage] == 5) // VEHICLE_USAGE_RENT
		DestroyRentVehicle(vehicleid);

	VehicleInfo[vehicleid][vDeleted]					= true;
	// Vehicle Previous Info
	VehiclePrevInfo[vehicleid][vPosX] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosY] 					= 0.0;
	VehiclePrevInfo[vehicleid][vPosZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vRotZ] 					= 0.0;
	VehiclePrevInfo[vehicleid][vHealth] 				= 0.0;
	VehiclePrevInfo[vehicleid][vPanels]					= 0;
	VehiclePrevInfo[vehicleid][vDoors]					= 0;
	VehiclePrevInfo[vehicleid][vTires]					= 0;
	VehiclePrevInfo[vehicleid][vLights]					= 0;

	VehicleInfo[vehicleid][vEngineRunning] = 0;
	Bit1_Set(gr_VehicleAlarmStarted, vehicleid, false);
	DestroyVehicle(vehicleid);
	Iter_Remove(Vehicles, vehicleid);
	defer ResetVehicleSafeDelete(vehicleid);
	return 1;
}

stock SetRespawnedVehicleParams(vehicleid)
{
	if( VehicleInfo[vehicleid][vNumberPlate][0] == '0' )
		SetVehicleNumberPlate(vehicleid, " ");
	else
		SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][vNumberPlate]);
	new
		engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(IsABike(VehicleInfo[vehicleid][vModel]) || IsAPlane(VehicleInfo[vehicleid][vModel])) {
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,VEHICLE_PARAMS_OFF,alarm,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,objective);
		VehicleInfo[vehicleid][vEngineRunning] = 1;
	} else {
		if(VehicleInfo[vehicleid][vDestroyed] == true)
		{
			doors = 0;
			VehicleInfo[vehicleid][vLocked] = false;
		}
		else
		{
			if(!VehicleInfo[vehicleid][vLocked])
				doors = 0;
			else
				doors = 1;
		}
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		VehicleInfo[vehicleid][vEngineRunning] = 0;
	}
	return 1;
}

stock GetVehiclePreviousInfo(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 1;
	new Float:x, Float:y, Float:z, Float:rz;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, rz);
	VehiclePrevInfo[vehicleid][vPosX] = x;
	VehiclePrevInfo[vehicleid][vPosY] = y;
	VehiclePrevInfo[vehicleid][vPosZ] = z;
	VehiclePrevInfo[vehicleid][vRotZ] = rz;
	GetVehicleDamageStatus(vehicleid, VehiclePrevInfo[vehicleid][vPanels], VehiclePrevInfo[vehicleid][vDoors], VehiclePrevInfo[vehicleid][vLights], VehiclePrevInfo[vehicleid][vTires]);
	GetVehicleHealth(vehicleid, VehiclePrevInfo[vehicleid][vHealth]);
	return 1;
}

stock SetVehiclePreviousInfo(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID) return 0;
	if(DoesVehicleHavePlayers(vehicleid)) return 0;
	SetVehiclePos(vehicleid, VehiclePrevInfo[vehicleid][vPosX], VehiclePrevInfo[vehicleid][vPosY], VehiclePrevInfo[vehicleid][vPosZ]);
	SetVehicleZAngle(vehicleid, VehiclePrevInfo[vehicleid][vRotZ]);
	UpdateVehicleDamageStatus(vehicleid, VehiclePrevInfo[vehicleid][vPanels], VehiclePrevInfo[vehicleid][vDoors], VehiclePrevInfo[vehicleid][vLights], VehiclePrevInfo[vehicleid][vTires]);
	SetVehicleHealth(vehicleid, VehiclePrevInfo[vehicleid][vHealth]);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	if(VehicleInfo[vehicleid][vServerTeleport] == true)
		defer ResetVehicleSafeTeleport(vehicleid);
	return 1;
}

stock AC_TogglePlayerControllable(playerid, toggle)
{
	if(toggle == 0)
		Frozen[playerid] = true;
	else
		Frozen[playerid] = false;
	return TogglePlayerControllable(playerid, toggle);
}
#if defined _ALS_TogglePlayerControllable
    #undef TogglePlayerControllable
#else
    #define _ALS_TogglePlayerControllable
#endif
#define TogglePlayerControllable AC_TogglePlayerControllable

stock AC_SpawnPlayer(playerid)
{
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, playerid);
	SpawnPlayer(playerid);
	Streamer_Update(playerid);
	CallLocalFunction("OnPlayerSpawn", "d", playerid);
}
#if defined _ALS_SpawnPlayer
    #undef SpawnPlayer
#else
    #define _ALS_SpawnPlayer
#endif
#define SpawnPlayer AC_SpawnPlayer

stock AC_SetPlayerHealth(playerid, Float:health, bool:admin_duty = false)
{
	if(!admin_duty)
		PlayerInfo[playerid][pHealth] = health;
	return SetPlayerHealth(playerid, health);
}
#if defined _ALS_SetPlayerHealth
    #undef SetPlayerHealth
#else
    #define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth AC_SetPlayerHealth

stock AC_SetPlayerArmour(playerid, Float:armour, bool:admin_duty = false)
{
	if(!admin_duty)
		PlayerInfo[playerid][pArmour] = armour;
	return SetPlayerArmour(playerid, armour);
}
#if defined _ALS_SetPlayerArmour
    #undef SetPlayerArmour
#else
    #define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour AC_SetPlayerArmour

stock AC_SetVehicleToRespawn(vehicleid, bool:oldpos = false)
{
	new
		Float:vhealth;

	if(vehicleid == INVALID_VEHICLE_ID)	return 0;
	if( !Iter_Contains(Vehicles, vehicleid) ) return 0;
	VehicleInfo[vehicleid][vServerTeleport] = true;
	RemoveAllVehicleTuning(vehicleid);
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	SetVehicleToRespawn(vehicleid);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][vInt]);
	SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][vViwo]);
	if( VehicleInfo[vehicleid][vUsage] == 2 )  // VEHICLE_USAGE_PRIVATE
	{
		CheckVehicleInsurance(vehicleid);
		SetTune(vehicleid);
		RespawnTrunkObjects(vehicleid);
	}
	if(VehicleInfo[ vehicleid ][ vImpounded ] == 1)
	{
		SetVehiclePos(vehicleid, VehicleInfo[vehicleid][vParkX], VehicleInfo[vehicleid][vParkY], VehicleInfo[vehicleid][vParkZ]);
		SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][vAngle]);
	}
	SetRespawnedVehicleParams(vehicleid);

	if(oldpos == true)
		SetVehiclePreviousInfo(vehicleid);
	else
		defer ResetVehicleSafeTeleport(vehicleid);

	GetVehicleHealth(vehicleid, vhealth);

	if(vhealth <= 250.0)
		AC_SetVehicleHealth(vehicleid, 254.0);
	return 1;
}

#if defined _ALS_SetVehicleToRespawn
    #undef SetVehicleToRespawn
#else
    #define _ALS_SetVehicleToRespawn
#endif
#define SetVehicleToRespawn AC_SetVehicleToRespawn

stock AC_TogglePlayerSpectating(playerid, yon)
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0)
	{
		if(yon)
			Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, false);
	}
	if(!yon)
		Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, true);

	FIXES_TogglePlayerSpectating(playerid, yon);
	return 1;
}
#if defined _ALS_TogglePlayerSpectating
    #undef TogglePlayerSpectating
#else
    #define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating AC_TogglePlayerSpectating

stock AC_AddVehicleComponent(vehicleid, componentid)
{
	if(!IsComponentidCompatible(GetVehicleModel(vehicleid), componentid))
		return 0;
	else AddVehicleComponent(vehicleid, componentid);
	return 1;
}
#if defined _ALS_AddVehicleComponent
    #undef AddVehicleComponent
#else
    #define _ALS_AddVehicleComponent
#endif
#define AddVehicleComponent AC_AddVehicleComponent

stock GetPlayerPacketloss(playerid, &Float:packetloss)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	new
		nstats[401],
		nstats_loss[20],
		start,
		end;

	GetPlayerNetworkStats(playerid, nstats, sizeof(nstats));

	start = strfind(nstats,"packetloss",true);
	end = strfind(nstats,"%",true,start);

	strmid(nstats_loss, nstats, start+12, end, sizeof(nstats_loss));
	packetloss = floatstr(nstats_loss);
	return 1;
}

stock OnTaserShoot(playerid)
{
	SetPlayerArmedWeapon(playerid, WEAPON_SILENCED);
	return ClearAnimations(playerid);
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

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(playerid == INVALID_PLAYER_ID)
		return Kick(playerid), 0;

	if( weaponid <= 0 || weaponid > 46 )
		return Kick(playerid), 0;

	if (weaponid < 22 || weaponid > 38)
		return 0;

	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) )
		return 0;

	if (weaponid == WEAPON_SILENCED && Bit1_Get(gr_Taser, playerid) && ( IsACop(playerid) || IsASD(playerid) ) ) {
		//if( gettimestamp() < _QuickTimer[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate sacekati 3 sekundi kako bi ponovo koristili tazer.");
		//QuickTimer[playerid] = gettimestamp() + 3;
		ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0);
		SetTimerEx("OnTaserShoot", 1100, false, "i", playerid);
	}
	AC_DecreasePlayerWeaponAmmo(playerid, weaponid, 1);
	
    #if defined CHEAT_OnPlayerWeaponShot
        CHEAT_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
    #endif
    return 1;
}
#if defined _ALS_OnPlayerWeaponShot
    #undef OnPlayerWeaponShot
#else
    #define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot CHEAT_OnPlayerWeaponShot
#if defined CHEAT_OnPlayerWeaponShot
    forward CHEAT_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif

hook OnPlayerConnect(playerid)
{
	AimWarns[playerid] = 0;
	AimWarnStamp[playerid] = 0;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePreviousInfo(vehicleid);
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	GetVehiclePreviousInfo(vehicleid);
	return 1;
}

public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
	new str[144], wname[32];
	
	AimWarns[playerid]++;
	GetWeaponName(weaponid,wname,sizeof(wname));
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je ispucao metak izvan dometa oruzja %s. (Normal Range:%f)",AimWarns[playerid],GetName(playerid,false),playerid,wname,BustAim::GetNormalWeaponRange(weaponid));
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je potencijalni korisnik ProAima (Teleport detektiran)",AimWarns[playerid],GetName(playerid,false),playerid);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je potencijalni korisnik AimBota (Random Aim pogodak sa %s).",AimWarns[playerid],GetName(playerid,false),playerid,wname);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je ispucao 10 metaka za redom koji su pogodili %s(%d) sa %s.", AimWarns[playerid],GetName(playerid,false),playerid, GetName(hitid, false), hitid, wname);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	return 0;
}

stock AC_SetVehicleHealth(vehicleid, Float:health)
{
	VehicleInfo[vehicleid][vHealth] = health;
	return SetVehicleHealth(vehicleid, health);
}
#if defined _ALS_SetVehicleHealth
    #undef SetVehicleHealth
#else
    #define _ALS_SetVehicleHealth
#endif
#define SetVehicleHealth AC_SetVehicleHealth

stock AC_RepairVehicle(vehicleid)
{
	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
	VehicleInfo[vehicleid][vPanels]		= 0;
	VehicleInfo[vehicleid][vDoors]		= 0;
	VehicleInfo[vehicleid][vLights]		= 0;
	VehicleInfo[vehicleid][vTires]		= 0;
	VehicleInfo[vehicleid][vHealth] 	= 1000.0;
	VehicleInfo[vehicleid][vDestroyed]	= false;
	VehicleInfo[vehicleid][vGPS] = true;
	return RepairVehicle(vehicleid);
}
#if defined _ALS_RepairVehicle
    #undef RepairVehicle
#else
    #define _ALS_RepairVehicle
#endif
#define RepairVehicle AC_RepairVehicle

stock AC_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	if(!Iter_Contains(Vehicles, vehicleid)) return 1;
	VehicleInfo[vehicleid][vServerTeleport] = true;
	VehiclePrevInfo[vehicleid][vPosX] = x;
	VehiclePrevInfo[vehicleid][vPosY] = y;
	VehiclePrevInfo[vehicleid][vPosZ] = z;
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	defer ResetVehicleSafeTeleport(vehicleid);
	return SetVehiclePos(vehicleid, x, y, z);
}
#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else
	#define _ALS_SetVehiclePos
#endif
#define SetVehiclePos AC_SetVehiclePos

stock AC_SetVehicleVelocity(vehicleid, Float:X, Float:Y, Float:Z)
{
	if(!VehicleInfo[vehicleid][vServerTeleport] || DoesVehicleHavePlayers(vehicleid))
		return 1;
	SetVehicleVelocity(vehicleid, X, Y, Z);
	return 1;
}
#if defined _ALS_SetVehicleVelocity
	#undef SetVehicleVelocity
#else
	#define _ALS_SetVehicleVelocity
#endif
#define SetVehicleVelocity AC_SetVehicleVelocity

