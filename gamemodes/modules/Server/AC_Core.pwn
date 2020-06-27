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


// Anti Vehicle Teleport
new Float: SAMP_AC_VEHICLE_POSITION[MAX_VEHICLES];

enum E_PLAYER_CHEAT_WEAPONS
{
	pwSQLID[13],
	pwWeaponId[13],
	pwAmmo[13],
	pwHidden[13]
}
new
	PlayerWeapons[MAX_PLAYERS][E_PLAYER_CHEAT_WEAPONS];

enum E_PLAYER_ANTI_CHEAT_DATA {
	Float:acLastFootPos[ 3 ],
	acLastVehicle,
	bool:acKicked,
	bool:acLoginDialog
}
new
	AntiCheatData[ MAX_PLAYERS ][ E_PLAYER_ANTI_CHEAT_DATA ];

enum E_PLAYER_CHEAT_COUNTS
{
	ccAmmo,
	ccWeapon,
	ccAirBreak,
	ccGoC,
	ccRemoteJacking,
	ccFoxHeaven,
	ccFloodCar,
	ccSafeLogin
}
new
	PlayerCountings[ MAX_PLAYERS ][ E_PLAYER_CHEAT_COUNTS ];

enum {
	ANTI_CHEAT_TYPE_WEAPON = 1,
	ANTI_CHEAT_TYPE_AMMO,
	ANTI_CHEAT_TYPE_REMOTE,
	ANTI_CHEAT_TYPE_CAR_CONTROL,
	ANTI_CHEAT_TYPE_CARFLOOD,
	ANTI_CHEAT_TYPE_FOX
};

/*
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
*/

#define MAX_AUTOBULLET_INFRACTIONS          (3)
#define AUTOBULLET_RESET_DELAY              (30)
#define POTENTIAL_SPEED_DROP 				(5.0)


/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// Vehicles
static stock
	vehicleTick[MAX_VEHICLES],
	Float:VehicleHealth[MAX_VEHICLES],
	Float:VehicleSpeed[MAX_VEHICLES],
	g_DamageStatus[MAX_VEHICLES][3 char];

new
	VehicleColor1[MAX_VEHICLES],
	VehicleColor2[MAX_VEHICLES],
	DamageStatusTick[MAX_PLAYERS];

//CLEO
static stock
	AutoBulletInfractions[MAX_PLAYERS char],
	LastInfractionTime[MAX_PLAYERS char];

// Controling
new
	acVehicleDriver[MAX_VEHICLES] = { INVALID_PLAYER_ID, ... },
	acPlayerVehicle[MAX_PLAYERS]  = { 0, ... };

new
	godEntry[MAX_PLAYERS],
	acPlayerState[ MAX_PLAYERS ],
	LastPullingVehicle[MAX_VEHICLES],
	ABH_Online = 0;

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

stock static ShowAdminACInterface(playerid)
{
	new
		string[ 168 ];
	format(string, 128, "God of Cars:\t %s\n"COL_WHITE"Ultimate Troll:\t %s\n"COL_WHITE"Foxheaven:\t %s\n"COL_WHITE"Anti BH:\t %s",
		GoC_Online 		? (""COL_GREEN"Online") : (""COL_RED"Offline"),
		Troll_Online 	? (""COL_GREEN"Online") : (""COL_RED"Offline"),
		Fox_Online 		? (""COL_GREEN"Online") : (""COL_RED"Offline"),
		ABH_Online 		? (""COL_GREEN"Online") : (""COL_RED"Offline")
	);
	ShowPlayerDialog(playerid, DIALOG_ADMIN_AC, DIALOG_STYLE_LIST, "Anti-Cheat Interface", string, "Odaberi", "Odustani");
	return 1;
}

stock ResetAntiCheatCountings(playerid)
{
	PlayerCountings[ playerid ][ ccAmmo ]			= 0;
	PlayerCountings[ playerid ][ ccWeapon ]         = 0;
	PlayerCountings[ playerid ][ ccAirBreak ]  		= 0;
	PlayerCountings[ playerid ][ ccGoC ]  			= 0;
	PlayerCountings[ playerid ][ ccRemoteJacking ]  = 0;
	PlayerCountings[ playerid ][ ccFoxHeaven ]  	= 0;
	PlayerCountings[ playerid ][ ccFloodCar ]  		= 0;
	PlayerCountings[ playerid ][ ccSafeLogin ]		= 0;

	// Vars
	AntiCheatData[ playerid ][ acLastFootPos ][ 0 ] = 0.0;
	AntiCheatData[ playerid ][ acLastFootPos ][ 1 ] = 0.0;
	AntiCheatData[ playerid ][ acLastFootPos ][ 2 ] = 0.0;
	AntiCheatData[ playerid ][ acLastVehicle ] 		= 0;
	AntiCheatData[ playerid ][ acLoginDialog ] 		= false;

	PlayerWeapons[playerid][pwWeaponId][0]	= 0;
	PlayerWeapons[playerid][pwAmmo][0]		= 0;

	PlayerWeapons[playerid][pwWeaponId][1]	= 0;
	PlayerWeapons[playerid][pwAmmo][1]		= 0;

	PlayerWeapons[playerid][pwWeaponId][2]	= 0;
	PlayerWeapons[playerid][pwAmmo][2]		= 0;

	PlayerWeapons[playerid][pwWeaponId][3]	= 0;
	PlayerWeapons[playerid][pwAmmo][3]		= 0;

	PlayerWeapons[playerid][pwWeaponId][4]	= 0;
	PlayerWeapons[playerid][pwAmmo][4]		= 0;

	PlayerWeapons[playerid][pwWeaponId][5]	= 0;
	PlayerWeapons[playerid][pwAmmo][5]		= 0;

	PlayerWeapons[playerid][pwWeaponId][6]	= 0;
	PlayerWeapons[playerid][pwAmmo][6]		= 0;

	PlayerWeapons[playerid][pwWeaponId][7]	= 0;
	PlayerWeapons[playerid][pwAmmo][7]		= 0;

	PlayerWeapons[playerid][pwWeaponId][8]	= 0;
	PlayerWeapons[playerid][pwAmmo][8]		= 0;

	PlayerWeapons[playerid][pwWeaponId][9]	= 0;
	PlayerWeapons[playerid][pwAmmo][9]		= 0;

	PlayerWeapons[playerid][pwWeaponId][10]	= 0;
	PlayerWeapons[playerid][pwAmmo][10]		= 0;

	PlayerWeapons[playerid][pwWeaponId][11]	= 0;
	PlayerWeapons[playerid][pwAmmo][11]		= 0;

	PlayerWeapons[playerid][pwWeaponId][12]	= 0;
	PlayerWeapons[playerid][pwAmmo][12]		= 0;
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
forward LoadPlayerWeapons(playerid);
public LoadPlayerWeapons(playerid)
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

forward OnWeaponInsertQuery(playerid, slotid);
public OnWeaponInsertQuery(playerid, slotid)
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
		format(weaponUpdate, 149, "UPDATE `player_weapons` SET `player_id` = '%d', `weapon_id` = '%d', `weapon_ammo` = '%d', `hidden` = '%d' WHERE `sqlid` = '%d'",
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
		format(weaponUpdate, 149, "INSERT INTO `player_weapons` (`player_id`, `weapon_id`, `weapon_ammo`, `hidden`) VALUES ('%d', '%d', '%d', '%d')",
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
		Log_Write("logfiles/packageloss_kick.txt", "(%s) %s(IP: %s) je kickan radi Package Loss-a(%.2f posto).",
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

stock AC_WeaponDetect(playerid)
{
	new
		weaponid 		= GetPlayerWeapon(playerid),
		serverweapid 	= AC_GetPlayerWeapon(playerid);

	if(ForbiddenWeapons(weaponid))
	{
		AC_ResetPlayerWeapons(playerid);

		#if defined MODULE_BANS
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Cheat", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Cheat!");
		BanMessage(playerid);
		#endif
		return 1;
	}
	if( ( weaponid && PlayerInfo[playerid][pLevel] < 2 ) && weaponid != WEAPON_PARACHUTE )
	{
		if(Bit1_Get( gr_OnEvent, playerid)) return (true);

		AC_ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Cheat!");

		#if defined MODULE_BANS
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Cheat", -1,  true);
		BanMessage(playerid);
		#endif
		return 1;
	}
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Jetpack Cheat!");

		#if defined MODULE_BANS
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Jetpack Cheat", -1,  true);
		BanMessage(playerid);
		#endif
		return 1;
	}
	if(1 <= weaponid <= 43)
	{
		if( weaponid == serverweapid )
		{
			new ammo 		= GetPlayerAmmo(playerid),
				serverammo	= AC_GetPlayerAmmo(playerid);

			if(!ammo) {
				AC_ResetPlayerWeapon(playerid, weaponid);
				return 1;
			}
			if(Bit1_Get( gr_OnEvent, playerid)) return (true);

			else {
				#if defined MODULE_FACTIONS
				if( IsACop(playerid) && IsFDMember(playerid) && GetPlayerWeapon(playerid) == 23 )
					return 1;
				#endif

                if( ammo > ( serverammo + 2 ) && GetWeaponSlot( weaponid ) != 1 ) // nema pravu municiju
					CallLocalFunction("OnPlayerCheat", "iii", playerid, GetPlayerWeapon(playerid), ANTI_CHEAT_TYPE_AMMO);

				if(serverammo <= 0) {
					AC_ResetPlayerWeapon(playerid, weaponid);
					SetPlayerAmmo(playerid, weaponid, 0);
				}
				else if(ammo < serverammo)
					SetPlayerAmmo(playerid, weaponid, serverammo);
			}
		}
	}
	return 1;
}

/*
	   ###    ##     ## ########  #######  ########  ##     ## ##       ##       ######## ########
	  ## ##   ##     ##    ##    ##     ## ##     ## ##     ## ##       ##       ##          ##
	 ##   ##  ##     ##    ##    ##     ## ##     ## ##     ## ##       ##       ##          ##
	##     ## ##     ##    ##    ##     ## ########  ##     ## ##       ##       ######      ##
	######### ##     ##    ##    ##     ## ##     ## ##     ## ##       ##       ##          ##
	##     ## ##     ##    ##    ##     ## ##     ## ##     ## ##       ##       ##          ##
	##     ##  #######     ##     #######  ########   #######  ######## ######## ########    ##
*/

static CheckSpeed(playerid)
{
    new Keys,ud,lr;
    GetPlayerKeys(playerid,Keys,ud,lr);

    if(ud == KEY_UP && lr != KEY_LEFT && lr != KEY_RIGHT)
    {
        new Float:Velocity[3];
        GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
        Velocity[0] = floatsqroot( (Velocity[0]*Velocity[0])+(Velocity[1]*Velocity[1])+(Velocity[2]*Velocity[2]));
        if(Velocity[0] >= 0.11 && Velocity[0] <= 0.13) return 1;
    }
    return 0;
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
stock GetVehicleDriver(vehicleid)
{
	new
		playerid = INVALID_PLAYER_ID;

	foreach(new i : Player) {
		if( IsPlayerInVehicle(i, vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ) {
			playerid = i;
			break;
		}
	}
	return playerid;
}

stock DoesVehicleHavePlayers(vehicleid)
{
	foreach(new i:  Player)
	{
		if(IsPlayerInVehicle(i, vehicleid))
			return 1;
	}
	return 0;
}


stock AC_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay = -1, sirenon = 0)
{
	new
		id = CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, sirenon);

	if(!Iter_Contains(Vehicles, id))
		Iter_Add(Vehicles, id);

	VehicleInfo[id][vModel] = vehicletype;
	VehicleInfo[id][vSpawned] = 1;
	VehicleInfo[id][vRespawn] = respawn_delay;
	VehicleInfo[id][vServerTeleport] = false;
	VehicleInfo[id][vViwo] = GetVehicleVirtualWorld(id);
	VehicleHealth[id] = 1000.0;
	VehicleColor1[id] = color1;
	VehicleColor2[id] = color2;

	VehiclePrevInfo[id][vPosX] = x;
	VehiclePrevInfo[id][vPosY] = y;
	VehiclePrevInfo[id][vPosZ] = z;
	VehiclePrevInfo[id][vRotZ] = rotation;

	CheckVehicleObjects(id);
	return id;
}

stock AC_DestroyVehicle(vehicleid)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 		return 0;
	if( !Iter_Contains(Vehicles, vehicleid) ) 	return 0;

	RemoveAllVehicleTuning(vehicleid);
	VehicleObjectCheck(vehicleid);
	ResetVehicleAlarm(vehicleid);
	ClearVehicleMusic(vehicleid);
	RemoveTrunkObjects(vehicleid);
	if(VehicleInfo[vehicleid][vUsage] == 5) // VEHICLE_USAGE_RENT
		DestroyRentVehicle(vehicleid);

	VehicleHealth[ vehicleid ]		= 0.0;
	VehicleSpeed[ vehicleid ]		= 0;
	g_DamageStatus[ vehicleid ]{0}	= 0;
	g_DamageStatus[ vehicleid ]{1}	= 0;
	g_DamageStatus[ vehicleid ]{2}	= 0;
	VehicleColor1[ vehicleid ]		= -1;
	VehicleColor2[ vehicleid ]		= -1;
	VehicleInfo[vehicleid][vEngineRunning] = 0;
	Bit1_Set(gr_VehicleAlarmStarted, vehicleid, false);
	DestroyVehicle(vehicleid);

	Iter_Remove(Vehicles, vehicleid);
	return 1;
}

/*
	########  ######## ##     ##  #######  ######## ########               ##    ###     ######  ##    ## #### ##    ##  ######
	##     ## ##       ###   ### ##     ##    ##    ##                     ##   ## ##   ##    ## ##   ##   ##  ###   ## ##    ##
	##     ## ##       #### #### ##     ##    ##    ##                     ##  ##   ##  ##       ##  ##    ##  ####  ## ##
	########  ######   ## ### ## ##     ##    ##    ######   #######       ## ##     ## ##       #####     ##  ## ## ## ##   ####
	##   ##   ##       ##     ## ##     ##    ##    ##               ##    ## ######### ##       ##  ##    ##  ##  #### ##    ##
	##    ##  ##       ##     ## ##     ##    ##    ##               ##    ## ##     ## ##    ## ##   ##   ##  ##   ### ##    ##
	##     ## ######## ##     ##  #######     ##    ########          ######  ##     ##  ######  ##    ## #### ##    ##  ######
*/
stock CheckPlayerRemoteJacking( playerid )
{
    new iVehicle = GetPlayerVehicleID( playerid );

    if( !IsPlayerInAnyVehicle( playerid ) || Bit1_Get( gr_SafeRemoting, playerid ) )
        GetPlayerPos( playerid, AntiCheatData[ playerid ] [ acLastFootPos ][ 0 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 1 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 2 ] );

	if( PlayerInfo[ playerid ][ pAdmin ] || PlayerInfo[ playerid ][ pHelper ] )
		return 1;

    if( ( iVehicle != AntiCheatData[ playerid ] [ acLastVehicle ] ) && ( iVehicle != 0 ) && ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) ) {
        new
            Float: fDistance = GetVehicleDistanceFromPoint( iVehicle, AntiCheatData[ playerid ] [ acLastFootPos ][ 0 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 1 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 2 ] ),
            Float: fOffset = 15.0;

        if( ( GetVehicleModel( iVehicle ) == 577 ) || ( GetVehicleModel( iVehicle ) == 592 )) fOffset = 25.0; // Andromanda | AT-400

        if( fDistance > fOffset )
			CallLocalFunction("OnPlayerCheat", "iii", playerid, 0, ANTI_CHEAT_TYPE_REMOTE);

        GetPlayerPos( playerid, AntiCheatData[ playerid ] [ acLastFootPos ][ 0 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 1 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 2 ] );
        AntiCheatData[ playerid ] [ acLastVehicle ] = iVehicle;
    }
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

stock AC_SetPlayerHealth(playerid, Float:health)
{
	PlayerInfo[playerid][pHealth] = health;
	return SetPlayerHealth(playerid, health);
}
#if defined _ALS_SetPlayerHealth
    #undef SetPlayerHealth
#else
    #define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth AC_SetPlayerHealth

stock AC_SetPlayerArmour(playerid, Float:armour)
{
	PlayerInfo[playerid][pArmour] = armour;
	return SetPlayerArmour(playerid, armour);
}
#if defined _ALS_SetPlayerArmour
    #undef SetPlayerArmour
#else
    #define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour AC_SetPlayerArmour

stock AC_RemovePlayerFromVehicle(playerid)
{
	GetPlayerPos( playerid, AntiCheatData[ playerid ] [ acLastFootPos ][ 0 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 1 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 2 ] );
	AntiCheatData[ playerid ] [ acLastVehicle ] = 0;
	Bit1_Set( gr_SafeRemoting, playerid, true );
	RemovePlayerFromVehicle(playerid);
	return 1;
}
#if defined _ALS_RemovePlayerFromVehicle
    #undef RemovePlayerFromVehicle
#else
    #define _ALS_RemovePlayerFromVehicle
#endif
#define RemovePlayerFromVehicle AC_RemovePlayerFromVehicle

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
	VehicleInfo[vehicleid][vSpawned] = 1;
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

stock AC_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	GetPlayerPos( playerid, AntiCheatData[ playerid ] [ acLastFootPos ][ 0 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 1 ], AntiCheatData[ playerid ] [ acLastFootPos ][ 2 ] );
	AntiCheatData[ playerid ] [ acLastVehicle ] = vehicleid;
	Bit1_Set( gr_SafeRemoting, playerid, true );
	PutPlayerInVehicle(playerid, vehicleid, seatid);
	return 1;
}
#if defined _ALS_PutPlayerInVehicle
    #undef PutPlayerInVehicle
#else
    #define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle AC_PutPlayerInVehicle

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

stock DriveByOrExplosion(weaponid)
{
	new value = 0;
	switch(weaponid)
	{
		case 50: value = DAMAGE_DRIVEBY_HELI; // Rezanje na snicle helikopterom
		case 51: value = DAMAGE_EXPLOSION;
	}
	return value;
}

stock CheckVehicleRespawn(playerid, issuerid)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(LastVehicle[issuerid] != INVALID_VEHICLE_ID)
		{
			new vehicleid = LastVehicle[issuerid];
			if(VehicleInfo[vehicleid][vSpawned] == 1 || VehicleInfo[vehicleid][vServerTeleport] == true)
				return 0;
			AC_SetVehicleToRespawn(vehicleid);
		}
	}
	if(LastVehicle[playerid] != INVALID_VEHICLE_ID)
	{
		new vehicleid = LastVehicle[playerid];
		if(VehicleInfo[vehicleid][vSpawned] == 1 || VehicleInfo[vehicleid][vServerTeleport] == true)
			return 0;

		SetVehiclePreviousInfo(vehicleid);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] [ANTI-CHEAT]: Zbog protekcije od cheatera, staro vozilo je vraceno u vasu blizinu.");
	}
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

	if(ForbiddenWeapons(weaponid))
	{
		AC_ResetPlayerWeapons(playerid);
		#if defined MODULE_BANS
		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Cheat", -1,  true);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Cheat!");
		BanMessage(playerid);
		#endif
		if(hittype == 1)
		{
			if(hitid > -1 && hitid < MAX_PLAYERS)
				Iter_Add(DamagedByCheater, hitid);
		}
		return 1;
	}
	if (weaponid == WEAPON_SILENCED && Bit1_Get(gr_Taser, playerid) && ( IsACop(playerid) || IsASD(playerid) ) ) {
		//if( gettimestamp() < _QuickTimer[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate sacekati 3 sekundi kako bi ponovo koristili tazer.");
		//QuickTimer[playerid] = gettimestamp() + 3;
		ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0);
		SetTimerEx("OnTaserShoot", 1100, false, "i", playerid);
	}
	new
		Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	if(!(-20000.0 <= z <= 20000.0))
		return 0;

	if(hittype != BULLET_HIT_TYPE_NONE)
	{
        if((fX <= -1000.0 || fX >= 1000.0) || (fY <= -1000.0 || fY >= 1000.0) || (fZ <= -1000.0 || fZ >= 1000.0) || ((hittype != BULLET_HIT_TYPE_PLAYER) && (hittype != BULLET_HIT_TYPE_VEHICLE) && (hittype != BULLET_HIT_TYPE_OBJECT) && (hittype != BULLET_HIT_TYPE_PLAYER_OBJECT))) {
            SendClientMessage( playerid, COLOR_RED, "Anti-Cheat: Dobili ste kick iz igre radi koristenja Weapon Crashera!" );
			KickMessage(playerid);
            return 0;
        }
    }
	new slot = GetWeaponSlot(weaponid);
	if( PlayerWeapons[playerid][pwWeaponId][slot] != weaponid && GetPlayerAmmo(playerid) != PlayerWeapons[playerid][pwAmmo][slot] )
	{
		if( IsACop(playerid) && IsFDMember(playerid) ) return 1;
		if(Bit1_Get( gr_OnEvent, playerid)) return (true);


		printf("ANTI-CHEAT: %s je moguci cheater jer ima oruzje i ammo koji nisu serverom stavljeni (W:%d | A:%d)!", GetName(playerid, false), GetPlayerWeapon(playerid), GetPlayerAmmo(playerid));
		AC_ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Cheat!");

		HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Cheat", -1,  true);
		BanMessage(playerid);
		return 0;
	}
	AC_DecreasePlayerWeaponAmmo(playerid, weaponid, 1);
	if( !IsPlayerInAnyVehicle(playerid) )  {
        switch(weaponid) {
            case 27, 23, 25, 29, 30, 31, 33, 24, 38:  {
                if(CheckSpeed(playerid)) {
                    if(gettimestamp() - LastInfractionTime{playerid} >= AUTOBULLET_RESET_DELAY) AutoBulletInfractions{playerid} = 1;
                    else AutoBulletInfractions{playerid}++;
                    LastInfractionTime{playerid} = gettimestamp();

                    if(AutoBulletInfractions{playerid} == MAX_AUTOBULLET_INFRACTIONS)  {
                        AutoBulletInfractions{playerid} = 0;

						new
							tmpString[86];
                        format(tmpString, sizeof(tmpString), "Anti-Cheat: %s[%d] je moguci cheater, razlog: Autobullet Hack.",
							GetName(playerid,false),
							playerid);
						ABroadCast(COLOR_RED,tmpString,2);
                        return 0;
                    }
                }
            }
        }
    }
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
	AntiCheatData[playerid][acKicked] = false;
	return 1;
}

CMD:clearacveh(playerid, params[]) // test
{
	acVehicleDriver[ strval(params) ] = INVALID_PLAYER_ID;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePreviousInfo(vehicleid);
	}
	if(acPlayerVehicle[playerid])
	{
		acVehicleDriver[ acPlayerVehicle[ playerid ] ] = INVALID_PLAYER_ID;
		acPlayerVehicle[ playerid ] = 0;
	}
	DamageStatusCountings[ playerid ] = 0;
	AntiCheatData[playerid][acKicked ] = false;
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	if(issuerid != INVALID_PLAYER_ID && PlayerInfo[issuerid][pBanned] == 0)
	{
		if(DriveByOrExplosion(weaponid) > 0)
		{
			new reason = DriveByOrExplosion(weaponid),
				Float:oldhealth,
				Float:oldarmour;

			GetPlayerHealth(playerid, oldhealth);
			if((reason == DAMAGE_DRIVEBY_HELI && oldhealth > 15.0) || GetPlayerState(issuerid) != PLAYER_STATE_DRIVER)
				return 0;

			GetPlayerArmour(playerid, oldarmour);
			SetPlayerHealth(playerid, oldhealth + 10.0);
			SetPlayerArmour(playerid, oldarmour);

			new banreason[18];
			CheckVehicleRespawn(playerid, issuerid);
			switch(reason)
			{
				case DAMAGE_DRIVEBY_HELI:
				{
					format(banreason, 18, "DriveBy");
					HOOK_Ban(issuerid, INVALID_PLAYER_ID, banreason, -1,  true);
					va_SendClientMessage(issuerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: %s!", banreason);
					BanMessage(issuerid);
					return 1;
				}
				case DAMAGE_EXPLOSION:
				{
					if(ForbiddenWeapons(weaponid))
					{
						format(banreason, 18, "Weapon Cheat");
						HOOK_Ban(issuerid, INVALID_PLAYER_ID, banreason, -1,  true);
						va_SendClientMessage(issuerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: %s!", banreason);
						BanMessage(issuerid);
						return 1;
					}
				}
			}
		}
		else if(IsWeaponWearable(weaponid))
		{
			if(PlayerWeapons[issuerid][pwSQLID][GetWeaponSlot(weaponid)] == -1)
			{
				if(Bit1_Get(gr_BeanBagShotgun, issuerid) || Bit1_Get(gr_Taser, issuerid))
					return 1;
				if(Bit1_Get( gr_OnEvent, playerid)) return (true);
				new Float:oldhealth,
					Float:oldarmour;

				GetPlayerHealth(playerid, oldhealth);
				GetPlayerArmour(playerid, oldarmour);
				SetPlayerHealth(playerid, oldhealth);
				SetPlayerArmour(playerid, oldarmour);
				HOOK_Ban(issuerid, INVALID_PLAYER_ID, "Weapon Cheat", -1,  true);
				SendClientMessage(issuerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Cheat!");
				BanMessage(issuerid);
				return 1;
			}
		}
	}
	return 0;
}

stock IsWithTeamStaff(playerid)
{
	new Float:x, Float:y, Float:z,
		bool:value = false;
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pAdmin] < 1 || PlayerInfo[i][pHelper] < 1)
			continue;
		GetPlayerPos(i, x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
		{
			value = true;
			break;
		}
	}
	return value;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	godEntry[playerid] = GetTickCount();
	EnteringVehicle[playerid] = vehicleid;
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	GetVehiclePreviousInfo(vehicleid);
	return 1;
}

stock VehicleCrasherCheck(vehicleid, playerid)
{
	if( IsACop(playerid) || IsFDMember(playerid) ) return 1;
	if( ( DamageStatusTick[ playerid ] - tickcount() < 1 ) && ++DamageStatusCountings[ playerid ] >= 5 ) {
		CallLocalFunction("OnPlayerCheat", "iii", playerid, vehicleid, ANTI_CHEAT_TYPE_CARFLOOD);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			RemovePlayerFromVehicle(playerid);
	}
	DamageStatusTick[playerid] = tickcount();
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( (acPlayerState[ playerid ] == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_DRIVER) ||  (acPlayerState[ playerid ] == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_PASSENGER)) { // 99.9% citer
		CallLocalFunction("OnPlayerCheat", "iii", playerid, 0, ANTI_CHEAT_TYPE_CAR_CONTROL);
		return 1;
	}
	acPlayerState[ playerid ] = newstate;

	if( newstate == PLAYER_STATE_DRIVER )
	{
		new
			vehicleid = GetPlayerVehicleID(playerid);
		if( acVehicleDriver[ vehicleid ] != INVALID_PLAYER_ID ) { // 99.9% citer
			CallLocalFunction("OnPlayerCheat", "iii", playerid, 0, ANTI_CHEAT_TYPE_CAR_CONTROL);
			return 1;
		}

		if( vehicleid && acVehicleDriver[ vehicleid ] == INVALID_PLAYER_ID )
			acVehicleDriver[ vehicleid ] 	= playerid;
		acPlayerVehicle[ playerid ] 	= vehicleid;

		if( !GoC_Online ) return 1;
		if( ( GetTickCount() - godEntry[ playerid ] ) < 5 )
		{
			static
				dest[22],
				tmpString[115];

			NetStats_GetIpPort(playerid, dest, sizeof(dest));
			format(tmpString, sizeof(tmpString), "Anti-Cheat: %s[%d] je moguci cheater, razlog: God of Cars CLEO [IP: %s].",
					GetName(playerid,false),
					playerid,
					dest
			);
			ABroadCast(COLOR_RED,tmpString,2);
			if( ++PlayerCountings[ playerid ][ ccGoC ] >= 3 )
			{
			    new
			        banreason[30],
			        Float:packetLoss;

          		GetPlayerPacketloss(playerid, packetLoss);

				SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: GoC CLEO!");
				format(banreason, sizeof(banreason), "GoC CLEO, Packet Loss: %f%", packetLoss);

				#if defined MODULE_BANS
				HOOK_Ban(playerid, INVALID_PLAYER_ID, banreason, -1,  true);
				BanMessage(playerid);
				#endif
				return 1;
			}
		}
		//SetPlayerArmedWeapon(playerid, 0); - Ako vrati� ovo razjebat ae� Gunrack skriptu.
		/*if(GetPlayerWeapon(playerid) == WEAPON_DEAGLE || GetPlayerWeapon(playerid) == WEAPON_SNIPER ||
		GetPlayerWeapon(playerid) == WEAPON_TEC9 ||  GetPlayerWeapon(playerid) == WEAPON_UZI)
			SetPlayerArmedWeapon(playerid, 0);*/
	}
	if( oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER ) {
		if( oldstate == PLAYER_STATE_DRIVER )
			acVehicleDriver[ acPlayerVehicle[ playerid ] ] 	= INVALID_PLAYER_ID;
		acPlayerVehicle[ playerid ] 	= 0;
	}
	if(newstate==PLAYER_STATE_PASSENGER || newstate==PLAYER_STATE_DRIVER) // deag/sniper
    {
        if(/*GetPlayerWeapon(playerid) == WEAPON_DEAGLE || */GetPlayerWeapon(playerid) == WEAPON_SNIPER )
			SetPlayerArmedWeapon(playerid, 0);
    }
	if( newstate == PLAYER_STATE_PASSENGER ) {
		acPlayerVehicle[ playerid ] 	= GetPlayerVehicleID(playerid);
	}
	if( newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT )
		PlayerTick[playerid][ptWeapon] = gettimestamp() + 3;
	if( newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER )
	{
		PlayerTick[playerid][ptWeapon] = gettimestamp() + 2;
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_ADMIN_AC: {
			if(!response) return 1;
			switch(listitem) {
				case 0: {
					SendClientMessage(playerid, COLOR_WHITE, GoC_Online ? (""COL_GREEN"[GoC]: Online") : (""COL_RED"[GoC]: Offline"));
					GoC_Online = GoC_Online ? 0 : 1;
				}
				case 1: {
					SendClientMessage(playerid, COLOR_WHITE, Troll_Online ? (""COL_GREEN"[uTroll]: Online") : (""COL_RED"[uTroll]: Offline"));
					Troll_Online = Troll_Online ? 0 : 1;
				}
				case 2: {
					SendClientMessage(playerid, COLOR_WHITE, Fox_Online ? (""COL_GREEN"[Foxheaven]: Online") : (""COL_RED"[Foxheaven]: Offline"));
					Fox_Online = Fox_Online ? 0 : 1;
				}
				case 3: {
					SendClientMessage(playerid, COLOR_WHITE, ABH_Online ? (""COL_GREEN"[Bunny Hop]: Online") : (""COL_RED"[Bunny Hop]: Offline"));
					ABH_Online = ABH_Online ? 0 : 1;
				}
			}
			return 1;
		}
	}
	return 0;
}

hook OnPlayerUpdate(playerid)
{
	if(GetPlayerCameraMode(playerid) == 53)
    {
        new Float:kLibPos[3];
        GetPlayerCameraPos(playerid, kLibPos[0], kLibPos[1], kLibPos[2]);
        if ( kLibPos[2] < -50000.0 || kLibPos[2] > 50000.0 )
        {
			HOOK_Ban(playerid, INVALID_PLAYER_ID, "Weapon Crasher Hack", -1,  true);
			SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Weapon Crasher Hack!");
			BanMessage(playerid);
            return 0;
        }
    }
	if(AntiCheatData[playerid][acKicked])
		return 0;

	if( Fox_Online ) {
		if( IsPlayerNPC(playerid) ) 	return 1;
		if( !IsPlayerAlive(playerid) ) 	return 1;

		new
			vehicleid = GetPlayerVehicleID(playerid);
		if( vehicleid && acPlayerVehicle[ playerid ] != vehicleid ) { // 99.9 cheater
			RemovePlayerFromVehicle(playerid);
			SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
			CallLocalFunction("OnPlayerCheat", "iii", playerid, GetPlayerWeapon(playerid), ANTI_CHEAT_TYPE_FOX);
			return 1;
		}
	}

	if( IsPlayerAlive(playerid) &&
		( GetPlayerAnimationIndex(playerid) == 1538 ||
		GetPlayerAnimationIndex(playerid) == 1539 ||
		GetPlayerAnimationIndex(playerid) == 1543 ))
	{
	    new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(PlayerTick[ playerid ][ ptFlyHack ] < gettimestamp()) {

			if((z >= 10) && (!IsPlayerInRangeOfPoint(playerid, 29, 2313.3032, -1416.9933, 27.5538) && !IsPlayerInRangeOfPoint(playerid, 45, 1964.5123,-1201.0264,20.9248)))
			{
				if(IsPlayerSwimming(playerid))
					return 0;
				new str[84];
				format(str, sizeof(str), "Anti-Cheat: %s je dobio kick sa servera, razlog: Fly hack.", GetName(playerid, true));
				SendClientMessageToAll(COLOR_RED, str);
				SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobili ste kick sa servera zbog koristenja Fly hack-a.");
				KickMessage(playerid);
			}
		}
		PlayerTick[ playerid ][ ptFlyHack] = gettimestamp();
	}
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    if(passenger_seat == 1 && PlayerInfo[playerid][pBanned] == 0) // made by runner Discord: Runner#2944
    {
        if(floatround(new_x) == 0 && floatround(new_y) == 3 && floatround(new_z) == 0)
        {
            if(GetPlayerVehicleID(playerid) == vehicleid)
            {
                new
                    Float:v_x,
                    Float:v_y,
                    Float:v_z;

                GetVehiclePos(vehicleid, v_x, v_y, v_z);

                HOOK_Ban(playerid, INVALID_PLAYER_ID, "Player Crasher", -1,  true);
                SendClientMessage(playerid, COLOR_RED, "Dobio si ban, razlog: Player Crasher");

                Log_Write("logfiles/ac_playercrasher.txt", "(%s) Igrac %s{%d}(%s) je pokusao premjestiti vozilo sa lokacije x: %f y: %f z: %f na lokaciju x: %f y: %f z: %f te dobio ban!",
                    ReturnDate(),
                    GetName(playerid, false),
                    PlayerInfo[playerid][pSQLID],
                    GetPlayerIP(playerid),
                    v_x,
                    v_y,
                    v_z,
                    new_x,
                    new_y,
                    new_z
                );
                BanMessage(playerid);
            }
            return 0;
        }
    }
	if(passenger_seat == 0)
	{
		new
			Float: SAMP_AC_POS_VX, Float: SAMP_AC_POS_VZ,
			Float: SAMP_AC_POS_VY, Float: SAMP_AC_POS_VR;

		new Float: SAMP_AC_DISTANCE = GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z);

		GetVehiclePos(vehicleid, SAMP_AC_POS_VX, SAMP_AC_POS_VY, SAMP_AC_POS_VZ);
		GetVehicleZAngle(vehicleid, SAMP_AC_POS_VR);

		if(SAMP_AC_DISTANCE > 15.0 && SAMP_AC_POS_VZ > -70.0 && SAMP_AC_DISTANCE > SAMP_AC_VEHICLE_POSITION[vehicleid] + ((SAMP_AC_DISTANCE / 3) * 1.6))
		{
			SetVehiclePos(vehicleid, SAMP_AC_POS_VX, SAMP_AC_POS_VY, SAMP_AC_POS_VZ);
			SetVehicleZAngle(vehicleid, SAMP_AC_POS_VR);
			return false;
		}
		SAMP_AC_VEHICLE_POSITION[vehicleid] = SAMP_AC_DISTANCE;
	}
    return 1;
}


// Functions
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

stock AC_AttachTrailerToVehicle(trailerid,vehicleid)
{
	LastPullingVehicle[trailerid] = vehicleid;
	return AttachTrailerToVehicle(trailerid, vehicleid);
}
#if defined _ALS_AttachTrailerToVehicle
	#undef AttachTrailerToVehicle
#else
	#define _ALS_AttachTrailerToVehicle
#endif
#define AttachTrailerToVehicle AC_AttachTrailerToVehicle

stock AC_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
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

stock AC_Kick(playerid)
{
    AntiCheatData[playerid][acKicked] = true;
    Kick(playerid);
	return 1;
}
#if defined _ALS_Kick
    #undef Kick
#else
    #define _ALS_Kick
#endif
#define Kick AC_Kick

stock AC_Ban(playerid)
{
	AntiCheatData[playerid][acKicked] = true;
	Ban(playerid);
	return 1;
}
#if defined _ALS_Ban
    #undef Ban
#else
    #define _ALS_Ban
#endif
#define Ban AC_Ban


/*
	 ######  ##     ##  ######  ########  #######  ##     ##
	##    ## ##     ## ##    ##    ##    ##     ## ###   ###
	##       ##     ## ##          ##    ##     ## #### ####
	##       ##     ##  ######     ##    ##     ## ## ### ##
	##       ##     ##       ##    ##    ##     ## ##     ##
	##    ## ##     ## ##    ##    ##    ##     ## ##     ##
	 ######   #######   ######     ##     #######  ##     ##
*/

forward SAMP_AC_SEND_WARNING_FOR_MODE(CALLERID, const SAMP_AC_NAME[], SAMP_AC_CODE, SAMP_AC_DOOM);
public SAMP_AC_SEND_WARNING_FOR_MODE(CALLERID, const SAMP_AC_NAME[], SAMP_AC_CODE, SAMP_AC_DOOM)
{
	/*CALLERID == Player suspected of using cheats.
	SAMP_AC_NAME == The name of the anti-cheat that suspects the player of cheating.
	SAMP_AC_CODE == Anti-cheat code that suspects a player of cheating.
	SAMP_AC_DOOM == Punishment by anti-cheat settings. (0 - Kick | 1 - Warning)*/

	printf("Igrac %s[%d] koristi %s cheat! AC_CODE:%d, AC_DOOM:%d (IP: %s)", GetName(CALLERID), CALLERID, SAMP_AC_NAME, SAMP_AC_CODE, SAMP_AC_DOOM, GetPlayerIP(CALLERID));
	va_ABroadCast(COLOR_RED, "(%s) Igrac %s[%d] koristi %s cheat! AC_CODE:%d, AC_DOOM:%d (IP: %s)", 1, ReturnDate(), GetName(CALLERID), CALLERID, SAMP_AC_NAME, SAMP_AC_CODE, SAMP_AC_DOOM, GetPlayerIP(CALLERID));
    return true;
}

forward SAMP_AC_PLAYER_DEATH (playerid, killerid, reason);
public SAMP_AC_PLAYER_DEATH (playerid, killerid, reason)
{
	va_ABroadCast(COLOR_RED, "AC_DEATH: Igrac %s[%d] je ubio igraca %s[%d] razlog %d.", 1, GetName(playerid, false), playerid, GetName(killerid, false), killerid, reason);
	return true;
}

forward OnPlayerCheat(playerid, extraid, type);
public OnPlayerCheat(playerid, extraid, type)
{
	if( playerid == INVALID_PLAYER_ID ) return 1;

	#if defined MODULE_FACTIONS
	if( IsACop(playerid) || IsFDMember(playerid) ) return 1;
	#endif

	if( AntiCheatData[playerid][acKicked] ) {			// NOP Kick(playerid);
		BlockIpAddress(GetPlayerIP(playerid), (AC_MIN_TIME_RECONNECT * 1000) - GetConsoleVarAsInt("playertimeout"));
		return 0;
	}

	new
		tmpString[130],
		banreason[30],
		Float:packetLoss,
		dest[22];

	NetStats_GetIpPort(playerid, dest, sizeof(dest));
    GetPlayerPacketloss(playerid, packetLoss);

	switch( type )
	{
		case ANTI_CHEAT_TYPE_AMMO: {
			new
				ammo 		= GetPlayerAmmo(playerid),
				serverammo	= AC_GetPlayerAmmo(playerid);

			format(tmpString, sizeof(tmpString), "Anti-Cheat [IP: %s]: %s[%d] je moguci cheater, razlog: Ammo Hack (Game: %d | Server: %d).",
				dest,
				GetName(playerid,false),
				playerid,
				ammo,
				serverammo
			);
			ABroadCast(COLOR_RED,tmpString,2);
			PlayerTick[playerid][ptWeapon] = gettimestamp() + 2;

			if( ++PlayerCountings[ playerid ][ ccAmmo ] >= 3 ) {
				va_SendClientMessage( playerid, COLOR_RED, "Anti-Cheat: Dobili ste ban radi koristenja Ammo Hacka(Game: %d | Server: %d).", ammo, serverammo);
				PlayerInfo[playerid][pBanned] = 1;
				AC_ResetPlayerWeapons(playerid);
				format(banreason, sizeof(banreason), "Ammo Hack, Packet Loss: %f%", packetLoss);
				#if defined MODULE_BANS
				HOOK_Ban(playerid, INVALID_PLAYER_ID, banreason, -1,  true);
				#endif
				return 1;
			}
		}
		case ANTI_CHEAT_TYPE_REMOTE: {
			format(tmpString, sizeof(tmpString), "Anti-Cheat [IP: %s]: %s[%d] je moguci cheater, razlog: Remote Jack.",
				dest,
				GetName(playerid,false),
				playerid
			);
			ABroadCast(COLOR_RED,tmpString,2);

			if( ++PlayerCountings[ playerid ][ ccRemoteJacking ] >= 6 ) {

				SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si ban, razlog: Remote Jack!");
				format(banreason, sizeof(banreason), "Remote Jack, Packet Loss: %f%", packetLoss);

				#if defined MODULE_BANS
				HOOK_Ban(playerid, INVALID_PLAYER_ID, banreason, -1,  true);
				BanMessage(playerid);
				#endif
				return 1;
			}
		}
		case ANTI_CHEAT_TYPE_CAR_CONTROL: {
			RemovePlayerFromVehicle(playerid);
			va_SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Izbaceni ste radi moguceg koristenja Car Control CLEOa!");

			format(tmpString, sizeof(tmpString), "Anti-Cheat: %s[%d] je moguci cheater, razlog: Car control CLEO [IP: %s].",
				GetName(playerid,false),
				playerid,
				dest
			);
			ABroadCast(COLOR_RED,tmpString,1);
			acPlayerState[ playerid ] = PLAYER_STATE_ONFOOT;
		}
		case ANTI_CHEAT_TYPE_CARFLOOD: {
			format(tmpString, sizeof(tmpString), "Anti-Cheat [IP: %s]: %s[%d] je moguci cheater, razlog: Car flood CRASHER.",
				dest,
				GetName(playerid,false),
				playerid
			);
			ABroadCast(COLOR_RED,tmpString,1);

			if( ++PlayerCountings[ playerid ][ ccFloodCar ] >= 3 ) {
				SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si kick, razlog: Car flood CRASHER!");
				KickMessage(playerid);
				return 1;
			}
		}
		case ANTI_CHEAT_TYPE_FOX: {
			if( ++PlayerCountings[ playerid ][ ccFoxHeaven ] >= 2 ) {
				SendClientMessage(playerid, COLOR_RED, "Anti-Cheat: Dobio si kick sa servera, razlog: Foxheaven CLEO!");
				KickMessage(playerid);
			}
			format(tmpString, sizeof(tmpString), "Anti-Cheat [IP: %s]: %s[%d] je moguci cheater, razlog: Foxheaven CLEO.",
				dest,
				GetName(playerid,false),
				playerid
			);
			ABroadCast(COLOR_RED,tmpString,1);
			return 1;
		}
	}
	return 1;
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
CMD:anticheat(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	ShowAdminACInterface(playerid);
	return 1;
}



