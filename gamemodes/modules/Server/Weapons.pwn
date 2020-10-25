#include <YSI_Coding\y_hooks>
#include "modules/Systems/LSPD/LSPD_h.pwn"

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
	##      ## ########    ###    ########   #######  ##    ##  ######
	##  ##  ## ##         ## ##   ##     ## ##     ## ###   ## ##    ##
	##  ##  ## ##        ##   ##  ##     ## ##     ## ####  ## ##
	##  ##  ## ######   ##     ## ########  ##     ## ## ## ##  ######
	##  ##  ## ##       ######### ##        ##     ## ##  ####       ##
	##  ##  ## ##       ##     ## ##        ##     ## ##   ### ##    ##
	 ###  ###  ######## ##     ## ##         #######  ##    ##  ######
 */
 
Public:LoadPlayerWeapons(playerid)
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
		}
	}
	return 1;
}

Public:OnWeaponInsertQuery(playerid, slotid)
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
			if (!Player_HasTaserGun(playerid))
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


/*
	##     ##  #######   #######  ##    ##  ######
	##     ## ##     ## ##     ## ##   ##  ##    ##
	##     ## ##     ## ##     ## ##  ##   ##
	######### ##     ## ##     ## #####     ######
	##     ## ##     ## ##     ## ##  ##         ##
	##     ## ##     ## ##     ## ##   ##  ##    ##
	##     ##  #######   #######  ##    ##  ######
*/

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (playerid == INVALID_PLAYER_ID)
    {
        Kick(playerid);
        return 0;
    }
    if (!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid))
    {
        return 0;
    }
    if (weaponid <= 0 || weaponid > 46)
    {
        Kick(playerid);
        return 0;
    }
    if (weaponid < 22 || weaponid > 38)
    {
        return 0;
    }

    AC_DecreasePlayerWeaponAmmo(playerid, weaponid, 1);
    return 1;
}

hook OnPlayerConnect(playerid)
{
	AimWarns[playerid] = 0;
	AimWarnStamp[playerid] = 0;
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