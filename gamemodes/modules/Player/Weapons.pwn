#include <YSI_Coding\y_hooks>

/*
	######## ##    ## ##     ## ##     ##
	##       ###   ## ##     ## ###   ###
	##       ####  ## ##     ## #### ####
	######   ## ## ## ##     ## ## ### ##
	##       ##  #### ##     ## ##     ##
	##       ##   ### ##     ## ##     ##
	######## ##    ##  #######  ##     ##
*/

static
	Iterator:P_Weapons[MAX_PLAYERS]<MAX_PLAYER_WEAPON_SLOTS>;

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


static 
	PrimaryWeapon[MAX_PLAYERS],
	SecondaryWeapon[MAX_PLAYERS],
	AimWarns[MAX_PLAYERS],
	AimWarnStamp[MAX_PLAYERS]; 


/*
	##      ## ########    ###    ########   #######  ##    ##  ######
	##  ##  ## ##         ## ##   ##     ## ##     ## ###   ## ##    ##
	##  ##  ## ##        ##   ##  ##     ## ##     ## ####  ## ##
	##  ##  ## ######   ##     ## ########  ##     ## ## ## ##  ######
	##  ##  ## ##       ######### ##        ##     ## ##  ####       ##
	##  ##  ## ##       ##     ## ##        ##     ## ##   ### ##    ##
	 ###  ###  ######## ##     ## ##         #######  ##    ##  ######
 */

GetWeaponNameEx(weaponid)
{
	new 
		weaponName[32];

	switch(weaponid) 
	{
		case 0:  strcpy(weaponName, "Fists", sizeof(weaponName));
		case 1 .. 17: GetWeaponName(weaponid, weaponName, sizeof(weaponName));
		case 18: strcpy(weaponName, "Molotov Cocktail", sizeof(weaponName));
		case 22..38: GetWeaponName(weaponid, weaponName, sizeof(weaponName)); // Vatrena oruzja
		case 39: strcpy(weaponName, "Detonated Bomb", sizeof(weaponName));
		case 40: strcpy(weaponName, "Detonated Bomb", sizeof(weaponName));
		case 41: strcpy(weaponName, "Spray Can", sizeof(weaponName));
		case 42: strcpy(weaponName, "Fire Extinguisher", sizeof(weaponName));
		case 43: strcpy(weaponName, "Camera", sizeof(weaponName));
		case 44: strcpy(weaponName, "Night Vision Goggles", sizeof(weaponName));
		case 45: strcpy(weaponName, "Thermal Goggles", sizeof(weaponName));
		case 49: strcpy(weaponName, "Vehicle", sizeof(weaponName));
		case 50: strcpy(weaponName, "Helicopter Blades", sizeof(weaponName));
		case 51: strcpy(weaponName, "Explosion", sizeof(weaponName));
		case 53: strcpy(weaponName, "Drowning", sizeof(weaponName));
		case 54: strcpy(weaponName, "Falling Death", sizeof(weaponName));
		case KEVLAR_VEST: strcpy(weaponName, "Kevlar Vest", sizeof(weaponName));
		case 255: strcpy(weaponName, "Suicide", sizeof(weaponName));
		default: strcpy(weaponName, "Empty", sizeof(weaponName));
	}
	return weaponName;
}

GetWeaponSlot(weaponid)
{
	new 
		slot;
	switch(weaponid) 
	{
		case 0,1: 			slot = 0;
		case 2 .. 9: 		slot = 1;
		case 10 .. 15: 		slot = 10;
		case 16 .. 18, 39: 	slot = 8;
		case 22 .. 24: 		slot = 2;
		case 25 .. 27: 		slot = 3;
		case 28, 29, 32:	slot = 4;
		case 30, 31: 		slot = 5;
		case 33, 34: 		slot = 6;
		case 35 .. 38: 		slot = 7;
		case 40: 			slot = 12;
		case 41 .. 43: 		slot = 9;
		case 44 .. 46: 		slot = 11;
	}
	return slot;
}


IsCrounching(playerid) 
	return (GetPlayerAnimationIndex(playerid) == 1159 || GetPlayerAnimationIndex(playerid) == 1274 ? true : false);  

SetAnimationForWeapon(playerid, weaponid, crounch=false) 
{ 
     switch(weaponid) 
     { 
		case 22: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "COLT45", "python_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 23: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "SILENCED", "CrouchReload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "SILENCED", "Silence_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 24: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "PYTHON", "python_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "PYTHON", "python_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 25, 27: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "BUDDY", "buddy_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 26: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "COLT45", "colt45_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 29..31, 33, 34: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "RIFLE", "RIFLE_crouchload", 8.2,0,0,0,0,0, 1, 0); 
            else ApplyAnimationEx(playerid, "RIFLE", "rifle_load", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 28, 32: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "TEC", "TEC_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "TEC", "tec_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
    }
} 

ListPlayerWeapons(playerid, forplayerid)
{
	SendClientMessage(forplayerid, COLOR_LIGHTBLUE, "*_________________________ ORUZJA _________________________*");
	foreach(new slot: P_Weapons[playerid])
	{
		if(PlayerWeapons[playerid][pwWeaponId][slot] > 0 && PlayerWeapons[playerid][pwAmmo][slot] > 0)
			va_SendClientMessage(forplayerid, COLOR_WHITE, 
				"	Oruzje: %s, Metaka: %d.", 
				WeapNames[PlayerWeapons[playerid][pwWeaponId][slot]], 
				PlayerWeapons[playerid][pwAmmo][slot]
			);
	}
	if(HiddenWeapon[playerid][pwWeaponId] != 0)
		va_SendClientMessage(forplayerid, COLOR_WHITE, 
			"	[Sakriveno ispod odjece]: %s, Metaka: %d.", 
			WeapNames[HiddenWeapon[playerid][pwWeaponId]], 
			HiddenWeapon[playerid][pwAmmo]
		);
}

static AC_LoadPlayerWeapons(playerid)
{
	inline LoadPlayerWeapons()
	{
		if(cache_num_rows())
		{
			new
				sqlid = -1,
				weaponid = 0,
				ammo = 0,
				hidden = 0;

			for( new i = 0; i < cache_num_rows(); i++)
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
				PlayerWeapons[playerid][pwSQLID][GetWeaponSlot(weaponid)] = sqlid;
				AC_GivePlayerWeapon(playerid, weaponid, ammo, false, false);
			}
		}
		return 1;
	}
	MySQL_TQueryInline(SQL_Handle(),
		using inline LoadPlayerWeapons,
		va_fquery(SQL_Handle(), "SELECT * FROM player_weapons WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]), 
		"i", 
		playerid
	);
	return 1;
}

hook function LoadPlayerStats(playerid)
{
	AC_LoadPlayerWeapons(playerid);
	return continue(playerid);
}

stock AC_SavePlayerWeapon(playerid, slotid)
{
	if(PlayerWeapons[playerid][pwAmmo][slotid] <= 0 || PlayerWeapons[playerid][pwWeaponId][slotid] <= 0) 
		return 1;
	if(!Player_SafeSpawned(playerid))  
		return 1;

	if(PlayerWeapons[playerid][pwSQLID][slotid] != -1 && PlayerWeapons[playerid][pwAmmo][slotid] > 0)
	{
		mysql_fquery(SQL_Handle(), 
			"UPDATE player_weapons SET player_id = '%d', weapon_id = '%d', weapon_ammo = '%d', hidden = '%d'\n\
				WHERE sqlid = '%d'",
			PlayerInfo[playerid][pSQLID],
			PlayerWeapons[playerid][pwWeaponId][slotid],
			PlayerWeapons[playerid][pwAmmo][slotid],
			PlayerWeapons[playerid][pwHidden][slotid],
			PlayerWeapons[playerid][pwSQLID][slotid]
		);
	}
	else if(PlayerWeapons[playerid][pwSQLID][slotid] == -1 && PlayerWeapons[playerid][pwAmmo][slotid] > 0)
	{
		inline OnWeaponInsertQuery()
		{
			PlayerWeapons[playerid][pwSQLID][slotid] = cache_insert_id();
			Iter_Add(P_Weapons[playerid], slotid);
			return 1;
		}
		MySQL_TQueryInline(SQL_Handle(),
			using inline OnWeaponInsertQuery, 
			va_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					player_weapons \n\
				(player_id, weapon_id, weapon_ammo, hidden) \n\
				VALUES \n\
					('%d', '%d', '%d', '%d')",
				PlayerInfo[playerid][pSQLID],
				PlayerWeapons[playerid][pwWeaponId][slotid],
				PlayerWeapons[playerid][pwAmmo][slotid],
				PlayerWeapons[playerid][pwHidden][slotid]
			), 
			"ii", 
			playerid, 
			slotid
		);
	}
	return 1;
}

AC_SavePlayerWeapons(playerid)
{
	foreach(new wslot: P_Weapons[playerid])
	{
		AC_SavePlayerWeapon(playerid, wslot);
	}
	return 1;
}

hook function SavePlayerStats(playerid)
{
    AC_SavePlayerWeapons(playerid);
	return continue(playerid);
}

stock AC_DecreasePlayerWeaponAmmo(playerid, weaponid, amount)
{
	new
		slot = GetWeaponSlot(weaponid);
	PlayerWeapons[playerid][pwAmmo][slot] -= amount;
	if(PlayerWeapons[playerid][pwAmmo][slot] <= 0)
		AC_ResetPlayerWeapon(playerid, weaponid);
	return 1;
}

stock AC_GivePlayerWeapon(playerid, weaponid, ammo, bool:base_update=true, bool:hidden=false)
{
	if(playerid == INVALID_PLAYER_ID) return 0;
	if(!weaponid) return 0;
	if(!ammo) 	return 0;
	if(PlayerInfo[playerid][pLevel] < 2) return 0;

	new
		slot = GetWeaponSlot(weaponid);
	//Setting weapon in correct slot
	if(hidden)
		PlayerWeapons[playerid][pwSQLID][slot] = HiddenWeapon[playerid][pwSQLID];

	PlayerWeapons[playerid][pwWeaponId][slot] 	= weaponid;
	PlayerWeapons[playerid][pwAmmo][slot] 		+= ammo;
	PlayerWeapons[playerid][pwHidden][slot] 	= 0;

	Iter_Add(P_Weapons[playerid], slot);

	//Real Give Func
	if(Player_SafeSpawned(playerid))
		GivePlayerWeapon(playerid, weaponid, ammo);

	if(base_update && Player_SafeSpawned(playerid))
		AC_SavePlayerWeapon(playerid, slot);

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
		case 1: PrimaryWeapon[playerid] = 0;
		case 2: SecondaryWeapon[playerid] = 0;
	}
	return 1;
}

stock ResetWeaponSlots(playerid)
{
	PrimaryWeapon[playerid] = 0;
	SecondaryWeapon[playerid] = 0;
	return 1;
}

stock CheckPlayerWeapons(playerid, weaponid, bool:hidden_fetch=false)
{
	new bool:value = false,
		order = SortWeaponSlot(weaponid);

	if(HiddenWeapon[playerid][pwWeaponId] == weaponid && !hidden_fetch)
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate sakriven ovaj tip oruzja. (( /weapon hide)).");
		return 0;
	}
	switch(order)
	{
		case 0: value = true;
		case 1:
		{
			if(PrimaryWeapon[playerid] != 0 && PrimaryWeapon[playerid] != weaponid)
			{
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "Primary Weapon Slot Vam je zauzet. Oslobodite ga da bi mogli uzeti novi Shotgun/Assuault/Rifle/SMG.");
				value = false;
			}
			else if(PrimaryWeapon[playerid] == 0)
			{
				PrimaryWeapon[playerid] = weaponid;
				value = true;
			}
			else if(PrimaryWeapon[playerid] == weaponid)
				value = true;
		}
		case 2:
		{
			if(!Player_HasTaserGun(playerid))
			{
				if(SecondaryWeapon[playerid] != 0 && SecondaryWeapon[playerid] != weaponid)
				{
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Secondary Weapon Slot Vam je zauzet. Oslobodite ga da bi mogli uzeti novi sidearm pistolj.");
					value = false;
				}
				else if(SecondaryWeapon[playerid] == 0)
				{
					SecondaryWeapon[playerid] = weaponid;
					value = true;
				}
				else if(SecondaryWeapon[playerid] == weaponid)
					value = true;
			}
			else if(weaponid == WEAPON_SILENCED)
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
	return 1;
}

stock AC_SetPlayerWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	foreach(new i: P_Weapons[playerid])
	{
		if(PlayerWeapons[playerid][pwAmmo][i] <= 0) continue;
		GivePlayerWeapon(playerid, PlayerWeapons[playerid][pwWeaponId][i], PlayerWeapons[playerid][pwAmmo][i]);
	}
	SetPlayerArmedWeapon(playerid, 0);
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
	foreach(new slot: P_Weapons[playerid])
	{
		if(base_reset)
			PlayerWeapons[playerid][pwSQLID][slot] = -1;
		PlayerWeapons[playerid][pwWeaponId][slot] 	= 0;
		PlayerWeapons[playerid][pwAmmo][slot] 		= 0;
	}
	SetPlayerArmedWeapon(playerid, 0);

	if(base_reset)
	{
		Iter_Clear(P_Weapons[playerid]);
		mysql_fquery(SQL_Handle(), "DELETE FROM player_weapons WHERE player_id = '%d'", PlayerInfo[playerid][pSQLID]);
	}
	return 1;
}

stock AC_ResetPlayerWeapon(playerid, weaponid, bool:base_update=true)
{
	//Uzimamo vrijednosti oruzja
	new Weapon[13][2];
	foreach(new i: P_Weapons[playerid])
	{
		if(PlayerWeapons[playerid][pwAmmo][i] <= 0)
			continue;
		if(PlayerWeapons[playerid][pwWeaponId][i] == weaponid) 
		{
			if(base_update)
				PlayerWeapons[playerid][pwSQLID][i] = -1;
				
			PlayerWeapons[playerid][pwWeaponId][i] 	= 0;
			PlayerWeapons[playerid][pwAmmo][i] 		= 0;
			new next;
			Iter_SafeRemove(P_Weapons[playerid], i, next);
		}
		else 
		{
			Weapon[i][0] = PlayerWeapons[playerid][pwWeaponId][i];
			Weapon[i][1] = PlayerWeapons[playerid][pwAmmo][i];
		}
	}
	ResetWeaponSlots(playerid);
	AC_ResetPlayerWeapons(playerid, false);

	foreach(new i: P_Weapons[playerid])
	{
		if(Weapon[i][1] <= 0)
			continue;
		if(!CheckPlayerWeapons(playerid, Weapon[i][0]))
			continue;
		AC_GivePlayerWeapon(playerid, Weapon[i][0], Weapon[i][1], false);
	}

	// MySQL Query
	if(base_update)
	{
		mysql_fquery(SQL_Handle(),  "DELETE FROM player_weapons WHERE player_id = '%d' AND weapon_id = '%d'", 
			PlayerInfo[playerid][pSQLID], 
			weaponid
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

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(playerid == INVALID_PLAYER_ID)
    {
        Kick(playerid);
        return 0;
    }
    if(!IsPlayerLogged(playerid) || !IsPlayerConnected(playerid))
    {
        return 0;
    }
    if(weaponid <= 0 || weaponid > 46)
    {
        Kick(playerid);
        return 0;
    }
    if(weaponid < 22 || weaponid > 38)
    {
        return 0;
    }

    AC_DecreasePlayerWeaponAmmo(playerid, weaponid, 1);
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
	AC_ResetPlayerWeapons(playerid, false);
	Iter_Clear(P_Weapons[playerid]);
	
	PrimaryWeapon[playerid] = 0;
	SecondaryWeapon[playerid] = 0;

	AimWarns[playerid] = 0;
	AimWarnStamp[playerid] = 0;

	for(new wslot = 0; wslot < MAX_PLAYER_WEAPON_SLOTS; wslot++)
	{
		PlayerWeapons[playerid][pwSQLID][wslot] = -1;
		PlayerWeapons[playerid][pwWeaponId][wslot] = 0;
		PlayerWeapons[playerid][pwAmmo][wslot] = 0;
		PlayerWeapons[playerid][pwHidden][wslot] = 0;
	}
	HiddenWeapon[playerid][pwSQLID] = -1;
	HiddenWeapon[playerid][pwWeaponId] = 0;
	HiddenWeapon[playerid][pwAmmo] = 0;
	
	return continue(playerid);
}

public OnPlayerSuspectedForAimbot(playerid, hitid, weaponid, warnings)
{
	new str[144];
	
	AimWarns[playerid]++;
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je ispucao metak izvan dometa oruzja %s. (Normal Range:%f)",
			AimWarns[playerid],
			GetName(playerid,false),
			playerid,
			GetWeaponNameEx(weaponid),
			BustAim::GetNormalWeaponRange(weaponid)
		);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je potencijalni korisnik ProAima (Teleport detektiran)",
			AimWarns[playerid],
			GetName(playerid,false),
			playerid
		);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je potencijalni korisnik AimBota (Random Aim pogodak sa %s).",
			AimWarns[playerid],
			GetName(playerid,false),
			playerid,
			GetWeaponNameEx(weaponid)
		);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    format(str,sizeof(str),"[%d. warn]%s(%d) je ispucao 10 metaka za redom koji su pogodili %s(%d) sa %s.", 
			AimWarns[playerid],
			GetName(playerid,false),
			playerid, 
			GetName(hitid, false), 
			hitid, 
			GetWeaponNameEx(weaponid)
		);
		if(gettimestamp() >= AimWarnStamp[playerid])
			ABroadCast(COLOR_YELLOW,str,1);
		AimWarnStamp[playerid] = gettimestamp() + 5;
		Log_Write("logfiles/suspected_aimbot.txt", "%s - %s", ReturnDate(), str);
	}
	return 0;
}