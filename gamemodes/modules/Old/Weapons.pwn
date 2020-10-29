// Weapons ordering illegal v1.1 by Woo
// ## BETA ## BETA ## BETA ## BETA ## BETA ## BETA ## BETA 
// ######################################

#include <YSI_Coding\y_hooks>

#define MAX_PLAYER_WORDERS		(6)
#define MAX_WORDER_CRATES		(30) // 4 igraca po tri kutije u minimalnom slucaju igraca 
#define MAX_WORDER_BULLETS		(50)
#define DEALER_ID				(12)
// invalidi
#define INVALID_WOCRATE_ID		(999)
// ------------ ENUMS -------------------
new 
	PlayerGunPick[ MAX_PLAYERS ],
	PlayerAmmoPick[ MAX_PLAYERS ];

enum E_WOCRATE_DATA {
	cSQLID,
	cPlayerSQLID,
	cOpened,
	cLocation,
	cTime,
	cWeaponId,
	cWeaponAmmo,
	cVehId,
	Float:cX,
	Float:cY,
	Float:cZ,
	cObject
}

new WOCrateInfo[ MAX_WORDER_CRATES ][ E_WOCRATE_DATA ],
	Iterator:WOCrates<MAX_WORDER_CRATES>;

// ---  pawn shop --- ***
enum E_MELEE_WEAPONS
{
	mwWeaponId,
	mwName[16],
	mwPrice
}
static stock
	MeleeWeapons[][E_MELEE_WEAPONS] = {
		{WEAPON_BRASSKNUCKLE	, "Brass Knuckles"	, 12},
		{WEAPON_GOLFCLUB		, "Golf Club"		, 20},
		{WEAPON_KNIFE			, "Knife"			, 50},
		{WEAPON_BAT				, "Bat"				, 10},
		{WEAPON_BAT				, "Bat"				, 10},
		{WEAPON_SHOVEL			, "Shovel"			, 16},
		{WEAPON_POOLSTICK		, "Pool Cue"		, 18},
		{WEAPON_KATANA			, "Katana"			, 100},
		{WEAPON_DILDO			, "Purpule Dildo"	, 150}
	};

// ----------------
// Lokacije

enum E_WORDER_DELIVERS
{
	Float:woPosX,
	Float:woPosY,
	Float:woPosZ
}

static
	WoDeliver[3][E_WORDER_DELIVERS] = {
		{2794.9851,		-2373.4485,		13.6319}, 	// LS 
		{-1745.9355,	167.6474,		3.5496}, 	// SF
		{1043.7640,		2178.7869,		10.8203} 	// LV	
};

// Oruzja

/*
*** LS oruzja ***

COLT, TEC, SHOTGUN, SNIPER

 *** SF oruzja ***

DEAGLE, MP5, UZI

*** LV oruzja ***

AK-47, M4, SILENCER

*/

enum E_ORDER_WEAPONS
{
	wLocation, // lokacija (ls,sf,lv)
	wModelId, // gun ID
	wName[16], // gun Name
	wBulletPrice, // cijena po metku
	wWaitTime // koliko se minuta ceka za isporuku
}

static
	WOListInfo[10][E_ORDER_WEAPONS] = {
	{0,	22, "COLT 45",		56,		20}, // 20
	{0,	25, "SHOTGUN",		100,	25}, 
	{0,	32, "TEC-9",		60,		22}, 
	{0,	34, "SNIPER",		1000,	120}, 
	{1,	24, "DEAGLE",		90,		30}, // 30
	{1,	28, "UZI",			60,		30}, // 30
	{1,	29, "MP5",			112,	30},
	{2,	23, "SILENCER",		56,		20},
	{2,	30, "AK-47",		150,	30},
	{2,	31, "M4",			170,	30} // 3
};

static stock
		Bit16:   gr_PlayerCanManagePackage   <MAX_PLAYERS>  = Bit16: INVALID_PLAYER_ID,
		Bit16: 	 gr_PlayerCarryPackage 		 <MAX_PLAYERS>  = Bit16: INVALID_WOCRATE_ID;

// ------------- FUNCTIONS -------------

forward OnOrderedWeaponsLoaded();
public OnOrderedWeaponsLoaded()
{
	new rows = cache_num_rows();
	if(rows) 
	{
	    for(new slotid = 0; slotid < rows; slotid++) {
			cache_get_value_name_int(slotid, "id", WOCrateInfo[ slotid ][ cSQLID ]);
			cache_get_value_name_int(slotid, "playerid", WOCrateInfo[ slotid ][ cPlayerSQLID ]);
			cache_get_value_name_int(slotid, "opened", WOCrateInfo[ slotid ][ cOpened ]);
			cache_get_value_name_int(slotid, "location", WOCrateInfo[ slotid ][ cLocation ]);
			cache_get_value_name_int(slotid, "time", WOCrateInfo[ slotid ][ cTime ]);
			cache_get_value_name_int(slotid, "weaponid", WOCrateInfo[ slotid ][ cWeaponId ]);
			cache_get_value_name_int(slotid, "ammo", WOCrateInfo[ slotid ][ cWeaponAmmo ]);
			cache_get_value_name_int(slotid, "vehid", WOCrateInfo[ slotid ][ cVehId ]);
			cache_get_value_name_float(slotid, "xpos", WOCrateInfo[ slotid ][ cX ]);
			cache_get_value_name_float(slotid, "ypos", WOCrateInfo[ slotid ][ cY ]);
			cache_get_value_name_float(slotid, "zpos", WOCrateInfo[ slotid ][ cZ ]);
			cache_get_value_name_int(slotid, "object", WOCrateInfo[ slotid ][ cObject ]);
			Iter_Add(WOCrates, slotid);
			CreateWoCrateObject(slotid);
			
		}
		printf("MySQL Report: Weapon order crates loaded (%d)!", rows);
	} else print("MySQL Report: No Weapon order crates data exist to load.");
	return 1;
}

stock CreateWoCrateObject(crateid)
{
	if(WOCrateInfo[crateid][cOpened] != 0 && WOCrateInfo[crateid][cVehId] != INVALID_VEHICLE_ID)
		WOCrateInfo[crateid][cObject] = CreateDynamicObject(2912, WOCrateInfo[crateid][cX], WOCrateInfo[crateid][cY], WOCrateInfo[crateid][cZ]-0.78, 0.0, 0.0, 0.0, -1, -1, -1, 90.0, 50.0);
    return 1;
}

static stock CheckPlayerMaxCrates(playerid)
{
	new sum = 0;
    foreach (new i : WOCrates) {
		if( WOCrateInfo[i][cPlayerSQLID] == PlayerInfo[playerid][pSQLID] ) {
			sum += 1;
		}
	}
	return sum;
}

static stock ResetWorderVars(playerid)
{
	PlayerGunPick[ playerid ] = -1;
	PlayerAmmoPick[ playerid ] = -1;
	return 1;
}

static stock AtLeastTwoMembers(playerid, Float:range, Float:x, Float:y, Float:z)
{
	new check = 0;
	
    foreach(new m : Player)
	{
		if(IsPlayerInRangeOfPoint(m, range, x, y, z) && (PlayerInfo[m][pMember] == PlayerInfo[playerid][pMember])) check += 1;
		if(check == 2) return 1;
	}
	return 0;
}

static stock CheckPlayerOrderedCrates(playerid)
{
	new date[6],
		location[3],
		status[40];
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "|------------------ WEAPON PACKAGES ------------------|");
    foreach (new i : WOCrates) {
		if( WOCrateInfo[i][cPlayerSQLID] == PlayerInfo[playerid][pSQLID] || WOCrateInfo[i][cPlayerSQLID] == Bit16_Get( gr_PlayerCanManagePackage, playerid ))
		{
			switch( WOCrateInfo[ i ][ cLocation ])
			{
				case 0: format(location, sizeof(location), "LS");
				case 1: format(location, sizeof(location), "SF");
				case 2: format(location, sizeof(location), "LV");
			}
			stamp2datetime(WOCrateInfo[i][cTime], date[0], date[1] ,date[2], date[3], date[4], date[5]);
			if(WOCrateInfo[i][cTime] < gettimestamp())
				format(status, sizeof(status), "Stigao");
			else
				format(status, sizeof(status), "%02d/%02d/%02d %02d:%02d", date[2], date[1], date[0], date[3], date[4]);
			va_SendClientMessage(playerid, COLOR_GREY, "PackageID: [%d] %s / %s ( %d ) / Otvoren: %s / ETA: %s / Veh: %d",
				i,
				location,
				WeapNames[WOCrateInfo[i][cWeaponId]],
				WOCrateInfo[i][cWeaponAmmo],
				WOCrateInfo[i][cOpened] ? ("Da") : ("Ne"),
				status,
				WOCrateInfo[i][cVehId]
			);
		}
	}
	return 1;
}

stock LoadWOCrates() // Loadanje cijele baze
{
	mysql_tquery(g_SQL, "SELECT * FROM weapon_order_crates", "OnOrderedWeaponsLoaded");
	return 1;
}

static stock LogWOCrates(string[]) // Log crates
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/weapon_orders.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock static UpdateWOCrate(slotid) // Updateanje package crate
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, sizeof(tmpQuery), "UPDATE weapon_order_crates SET playerid = '%d', opened = '%d', location = '%d', time = '%d', weaponid = '%d', ammo = '%d', vehid = '%d', xpos = '%.2f', ypos = '%.2f', zpos = '%.2f', object = '%d' WHERE id = '%d'",
		WOCrateInfo[ slotid ][ cPlayerSQLID ],
		WOCrateInfo[ slotid ][ cOpened ],
		WOCrateInfo[ slotid ][ cLocation ],
		WOCrateInfo[ slotid ][ cTime ],
		WOCrateInfo[ slotid ][ cWeaponId ],
		WOCrateInfo[ slotid ][ cWeaponAmmo ],
		WOCrateInfo[ slotid ][ cVehId ],
		WOCrateInfo[ slotid ][ cX ],
		WOCrateInfo[ slotid ][ cY ],
		WOCrateInfo[ slotid ][ cZ ],
		WOCrateInfo[ slotid ][ cObject ],
		WOCrateInfo[ slotid ][ cSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

Public:OnWOCrateInsert(slot)
{
	WOCrateInfo[ slot ][ cSQLID ] = cache_insert_id();
	return 1;
}

stock static InsertWOCrate(slotid) // Dodavanje package crate
{
	new insertQuery[ 256 ];
	format(insertQuery, sizeof(insertQuery), "INSERT INTO weapon_order_crates (playerid, opened, location, time, weaponid, ammo, vehid, xpos, ypos, zpos, object) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%.2f', '%.2f', '%.2f', '%d')",
		WOCrateInfo[ slotid ][ cPlayerSQLID ],
		WOCrateInfo[ slotid ][ cOpened ],
		WOCrateInfo[ slotid ][ cLocation ],
		WOCrateInfo[ slotid ][ cTime ],
		WOCrateInfo[ slotid ][ cWeaponId ],
		WOCrateInfo[ slotid ][ cWeaponAmmo ],
		WOCrateInfo[ slotid ][ cVehId ],
		WOCrateInfo[ slotid ][ cX ],
		WOCrateInfo[ slotid ][ cY ],
		WOCrateInfo[ slotid ][ cZ ],
		WOCrateInfo[ slotid ][ cObject ]
	);
	mysql_tquery( g_SQL, insertQuery, "OnWOCrateInsert", "i", slotid);
	return 1;
}

stock static DeleteWOCrate(slotid) // Delete package crate
{
	new destroyQuery[ 64];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM weapon_order_crates WHERE `id` = '%d' LIMIT 1", WOCrateInfo[ slotid ][ cSQLID ]);
	mysql_tquery(g_SQL, destroyQuery, "");
	return 1;
}

stock static IsPlayerInRangeOfWeaponCrate(playerid, Float:range) //Ako je igrac blizu cratea
{
	foreach(new x : WOCrates) 
	{ // AKO je igrac u blizini kutije I AKO objekt kutije POSTOJI (ako je u necijim rukama onda ne postoji)
		if( IsPlayerInRangeOfPoint(playerid, range, WOCrateInfo[ x ][ cX ], WOCrateInfo[ x ][ cY ], WOCrateInfo[ x ][ cZ ] ) && WOCrateInfo[x][cObject] != INVALID_OBJECT_ID)
			return x;
	}
	return -1;
}

stock static IsPlayerInRangeOfWOCrateByID(playerid, crateid, Float:range) //Ako je igrac blizu cratea
{
	if( IsPlayerInRangeOfPoint(playerid, range, WOCrateInfo[ crateid ][ cX ], WOCrateInfo[ crateid ][ cY ], WOCrateInfo[ crateid ][ cZ ] ) )
		return 1;
	return -1;
}

stock static TakeWeaponCrateFromFloor(playerid)
{
	if( IsPlayerAttachedObjectSlotUsed(playerid, 9) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec nesto nosite!");
	if( AC_GetPlayerWeapon(playerid) != 0 ) return SendClientMessage(playerid,COLOR_RED, "Drzite oruzje u rukama, ne mozete nositi kutiju!");
	if( IsPlayerInRangeOfWeaponCrate(playerid, 5.0) != -1 ) {
		new crate = IsPlayerInRangeOfWeaponCrate(playerid, 5.0);
		/* foreach(new i : Player) // provjera nosi li tko tu kutiju vec?
		{
			if(Bit16_Get( gr_PlayerCarryPackage, i) == crate)
				return va_SendClientMessage(playerid,COLOR_RED, "%s nosi tu kutiju!", GetName(i, true));
		} */
		if( IsValidDynamicObject(WOCrateInfo[ crate ][ cObject ]) ) {
			DestroyDynamicObject( WOCrateInfo[ crate ][ cObject ] );
			WOCrateInfo[ crate ][ cObject ] = INVALID_OBJECT_ID;
		}
		Bit16_Set( gr_PlayerCarryPackage, playerid, crate );
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Podigli ste paket %d s poda.  >> %s << **", crate, WeapNames[WOCrateInfo[crate][cWeaponId]]);
		SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.38, 0.53, -0.35, 0.0, 0.0, 0.0);
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 1, 1, 1, 0);
		return 1;
	}
	return 1;
}

stock static TakeWeaponCrateFromVehicle(playerid, crateid)
{
	new vehicleid = GetClosestVehicle(playerid);
	if( vehicleid == INVALID_VEHICLE_ID || vehicleid == 0 ) return -1;
	if(WOCrateInfo[crateid][cVehId] != VehicleInfo[vehicleid][vSQLID]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Taj paket nije u vozilu!");
	SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.38, 0.53, -0.35, 0.0, 0.0, 0.0);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 1, 1, 1, 0);
	WOCrateInfo[crateid][cVehId] = INVALID_VEHICLE_ID;
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	WOCrateInfo[crateid][cX] = X;
	WOCrateInfo[crateid][cY] = Y;
	WOCrateInfo[crateid][cZ] = Z;
	WOCrateInfo[crateid][cObject] = INVALID_OBJECT_ID;
	UpdateWOCrate(crateid);
	Bit16_Set( gr_PlayerCarryPackage, playerid, crateid );
	return 1;
}

stock static CheckWeaponsCrateInVehicle(playerid, vehicleid)
{
	foreach ( new i : WOCrates)
	{
		if (WOCrateInfo[i][cVehId] == VehicleInfo[vehicleid][vSQLID])
		{
			va_SendClientMessage(playerid, COLOR_GREY, "PackageID: [%d] %s ( %d )",
				i,
				WeapNames[WOCrateInfo[i][cWeaponId]],
				WOCrateInfo[i][cWeaponAmmo]
			);
		}
	}
}

stock static SpawnWeaponCrate(crateid)
{
	new cratelocation = WOCrateInfo[crateid][cLocation],
		Float:xpos = WoDeliver[cratelocation][woPosX],
		Float:ypos = WoDeliver[cratelocation][woPosY],
		Float:zpos = WoDeliver[cratelocation][woPosZ];
	
	WOCrateInfo[crateid][cOpened] = 1;
	WOCrateInfo[crateid][cX] = xpos;
	WOCrateInfo[crateid][cY] = ypos;
	WOCrateInfo[crateid][cZ] = zpos;
	CreateWoCrateObject(crateid); // cObject stvara
	
	UpdateWOCrate(crateid);
	return 1;
}

stock static DropWeaponCrate(playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		Float:Facing,
		crateid = Bit16_Get( gr_PlayerCarryPackage, playerid);

	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle( playerid, Facing );

	X = ( X + 1.75 * floatsin( -Facing,degrees ) ); 	Y = ( Y + 1.75 * floatcos( -Facing,degrees ) );

	RemovePlayerAttachedObject( playerid, 9 );
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ClearAnimations(playerid);

	// Object stuff
	WOCrateInfo[crateid][cX] = X;
	WOCrateInfo[crateid][cY] = Y;
	WOCrateInfo[crateid][cZ] = Z;
	CreateWoCrateObject(crateid); // cObject stvara
	UpdateWOCrate(crateid);
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	// Message
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Bacili ste paket na pod! ((Package ID: %d))", crateid );
	return 1;
}

stock static PutWeaponsCrateInVehicle(playerid, vehicleid)
{
	new crateid = Bit16_Get( gr_PlayerCarryPackage, playerid);
	RemovePlayerAttachedObject( playerid, 9 );
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 1, 1, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ClearAnimations(playerid);
	WOCrateInfo[crateid][cVehId] = VehicleInfo[vehicleid][vSQLID];
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	WOCrateInfo[crateid][cX] = X;
	WOCrateInfo[crateid][cY] = Y;
	WOCrateInfo[crateid][cZ] = Z;
	UpdateWOCrate(crateid);
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	return 1;
}
// --------------- HOOK (ERS) -----------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) 
	{
		case DIALOG_WORDER_WEAPONS:
		{
			if( !response ) return SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Nemoj mi trositi vrijeme! Kada se odlucis, javi se!");
			PlayerGunPick[ playerid ] = listitem;
			ShowPlayerDialog(playerid, DIALOG_WORDER_BULLETS, DIALOG_STYLE_INPUT, "Weapon order ammo", "Koliko metaka da posaljem?", "Naruci", "Cancel");
			return 1;
		}
		case DIALOG_WORDER_BULLETS: //Igrac bira kolicinu metaka
		{
			if( !response ) return SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Nista onda, kad se odlucis, javi! **Hangup**");
			new	
				ammo = strval(inputtext),
				safe_ammo = floatround(floatabs(ammo)),
				gunslot = PlayerGunPick[ playerid ],
				money = WOListInfo[ gunslot ][ wBulletPrice ] * safe_ammo,
				dialogString[256],
				location[32];
				
			PlayerAmmoPick[playerid] = safe_ammo;
		
			switch( WOListInfo[ gunslot ][ wLocation ])
			{
				case 0: format(location, sizeof(location), "L.S Docks Container Terminal");
				case 1: format(location, sizeof(location), "San Fierro Port of Discharge");
				case 2: format(location, sizeof(location), "Las Venturas Cargo Warehouse");
			}
			SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Evo ti informacije, potvrdi da saljem ili ne?");
			format(dialogString, sizeof(dialogString), "{f4bc42}Oruzje: %s\nMunicija: %d\nLokacija: %s\nCijena: %d $",
				WOListInfo[ gunslot ][ wName ],
				safe_ammo,
				location,
				money
			);
			ShowPlayerDialog(playerid, DIALOG_WORDER_FINISH, DIALOG_STYLE_MSGBOX, "Weapon order package information", dialogString, "Da", "Ne");
			return 1;
		}
		case DIALOG_WORDER_FINISH: //Igrac bira kolicinu metaka
		{
			if( !response ) return SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Nemoj mi trositi vrijeme! Kada se odlucis, javi se!");
			new	
				safe_ammo = PlayerAmmoPick[playerid],
				index = PlayerGunPick[ playerid ],
				money = WOListInfo[ index ][ wBulletPrice ] * (safe_ammo),
				wotime = gettimestamp() + (WOListInfo[ index ][ wWaitTime ] * 60), // Minute * 60
				date[6];

			if( safe_ammo == 0 || safe_ammo > MAX_WORDER_BULLETS) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalni broj metaka za jednu narudzbu je %d!", MAX_WORDER_BULLETS); 
			if( AC_GetPlayerMoney(playerid) < money ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");
			
			new freeiter = Iter_Free(WOCrates);
			WOCrateInfo[ freeiter ][ cPlayerSQLID ] = PlayerInfo[playerid][pSQLID];
			WOCrateInfo[ freeiter ][ cOpened ] = 0;
			WOCrateInfo[ freeiter ][ cLocation ] = WOListInfo[index][wLocation];
			WOCrateInfo[ freeiter ][ cTime ] = wotime;
			WOCrateInfo[ freeiter ][ cWeaponId ] = WOListInfo[index][wModelId];
			WOCrateInfo[ freeiter ][ cWeaponAmmo ] = safe_ammo;
			WOCrateInfo[ freeiter ][ cVehId ] = INVALID_VEHICLE_ID;
			WOCrateInfo[ freeiter ][ cX ] = 0;
			WOCrateInfo[ freeiter ][ cY ] = 0;
			WOCrateInfo[ freeiter ][ cZ ] = 0;
			WOCrateInfo[ freeiter ][ cObject ] = INVALID_OBJECT_ID;
			Iter_Add(WOCrates, freeiter);
			InsertWOCrate(freeiter); // dodavanje u bazu
			
			PlayerToIllegalBudgetMoney(playerid, money); // Ilegalni Budget dobiva novce
			ResetWorderVars(playerid);
				
			// ---------- spremanje u log ----------
			new log[ 128 ]; // -----
			format( log, 128, "%s je narucio %s ( %d ammo) za %d$",
				GetName(playerid),
				WOListInfo[ index ][ wName ],
				safe_ammo,
				money
			);
			LogWOCrates(log); 
			// -------------------------------------
			stamp2datetime(wotime, date[0], date[1] ,date[2], date[3], date[4], date[5]);
			SendClientMessage(playerid, COLOR_RED, "**Nepoznat** (govornica): Paket poslan **Hangup**!");
			return 1;
		} 
		// ----  PAWN SHOP ----
		case DIALOG_WEAPONS_MELEE: 
		{
			if(!response) return 1;
			if(AC_GetPlayerMoney(playerid) < MeleeWeapons[listitem][mwPrice]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca (%d$)!", MeleeWeapons[listitem][mwPrice]);
			PlayerToIllegalBudgetMoney(playerid, MeleeWeapons[listitem][mwPrice]);
			AC_GivePlayerWeapon(playerid, MeleeWeapons[listitem][mwWeaponId], 1);
			return 1;
		}
	}
	return 0;
}

hook OnPlayerDisconnect(playerid, reason) {
	PlayerGunPick[ playerid ] = -1;
	PlayerAmmoPick[ playerid ] = -1;
	// Ako igrac kresa ili diskonekta, a imao je kutiju..
	if( Bit16_Get( gr_PlayerCarryPackage, playerid ) != INVALID_WOCRATE_ID)
	{
		DropWeaponCrate(playerid);
		printf("[WORDERS QUIT]: Igrac %s je izasao dok je nosio kutiju!", GetName(playerid,false));
	}
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	Bit16_Set( gr_PlayerCanManagePackage, playerid, INVALID_PLAYER_ID );
	return 1;
}

hook OnPlayerConnect(playerid)
{
	PlayerGunPick[ playerid ] = -1;
	PlayerAmmoPick[ playerid ] = -1;
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	Bit16_Set( gr_PlayerCanManagePackage, playerid, INVALID_PLAYER_ID );
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	PlayerGunPick[ playerid ] = -1;
	PlayerAmmoPick[ playerid ] = -1;
	// Ako igrac kresa ili diskonekta, a imao je kutiju..
	if( Bit16_Get( gr_PlayerCarryPackage, playerid ) != INVALID_WOCRATE_ID)
		DropWeaponCrate(playerid);
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	Bit16_Set( gr_PlayerCanManagePackage, playerid, INVALID_PLAYER_ID );
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	// Ako igrac kresa ili diskonekta, a imao je kutiju..
	if( Bit16_Get( gr_PlayerCarryPackage, playerid ) != INVALID_WOCRATE_ID)
		DropWeaponCrate(playerid);
	Bit16_Set( gr_PlayerCarryPackage, playerid, INVALID_WOCRATE_ID );
	return 1;
}

hook OnGameModeExit()
{
	foreach ( new i : WOCrates)
	{
		if( IsValidDynamicObject(WOCrateInfo[ i ][ cObject ]) ) {
			DestroyDynamicObject( WOCrateInfo[ i ][ cObject ] );
			WOCrateInfo[ i ][ cObject ] = INVALID_OBJECT_ID;
		}
	}
}

/// -------------- CMDS ----------------

CMD:weapons(playerid, params[])
{
	new
		pick[ 12 ];
	if( sscanf( params, "s[12] ", pick ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons [odabir]");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: order - view - pickup - assembly - approve - disapprove");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: take - drop - vehput - vehtake - vehinfo");
		return 1;
	}
	if( !strcmp( pick, "order") )
	{
		if( PlayerInfo[ playerid ][ pJob ] != DEALER_ID || !PlayerInfo[playerid][pMember] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste Gun Dealer ili u skriptanoj organizaciji!");
		if(!IsAtGovornica(playerid)) return SendClientMessage(playerid,COLOR_RED, "Narucivati mozete samo sa govornice!");
		if( Iter_Count(WOCrates) == ( MAX_WORDER_CRATES - 1) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Sva mjesta su vec pretovarena, pokusajte kasnije!");
		if(CheckPlayerMaxCrates(playerid) >= MAX_PLAYER_WORDERS) return SendClientMessage(playerid,COLOR_RED, "Imate maksimalan broj narudzbi!!"); 
		
		new tmpString[256];
		format(tmpString, 256, "Oruzje\tCijena metka\tETA min\n");
		for( new i = 0; i < 10; i++ ) {
			format( tmpString, 256, "%s{f4bc42}%s\t%d$\t%d\n", tmpString, WOListInfo[i][wName], WOListInfo[i][wBulletPrice], WOListInfo[i][wWaitTime]);
		}
		ShowPlayerDialog(playerid, DIALOG_WORDER_WEAPONS, DIALOG_STYLE_TABLIST_HEADERS, "Weapon order packages", tmpString, "U redu", "Cancel");
	}
	else if( !strcmp( pick, "approve") )
	{
		new giveplayerid;
		if (sscanf(params, "s[12]ui", pick, giveplayerid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons approve [ID/Dio Imena]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Dozvolite osobi da moze vaditi oruzje iz paketa, koristite /weapons view da vidite ID paketa!");
			return 1;
		}	
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraca!");
		if( PlayerInfo[ playerid ][ pJob ] != DEALER_ID || !PlayerInfo[playerid][pMember] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste Gun Dealer ili u skriptanoj organizaciji!");
		if(PlayerInfo[ giveplayerid ][ pMember ] != PlayerInfo[playerid][pMember] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Osoba nije u vasoj organizaciji!");
		if (Bit16_Get( gr_PlayerCanManagePackage, giveplayerid ) == INVALID_PLAYER_ID)
		Bit16_Set( gr_PlayerCanManagePackage, giveplayerid, PlayerInfo[playerid][pSQLID] );
		va_SendClientMessage( giveplayerid, COLOR_RED, "[ ! ] %s vam je dao dopustenje za upravljanje paketa.", GetName(playerid, true));
		va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Dao si %s dopustenje za upravljanje paketa.", GetName(giveplayerid, true));

	}
	else if( !strcmp( pick, "disapprove") )
	{
		new giveplayerid;
		if (sscanf(params, "s[12]ui", pick, giveplayerid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons disapprove [ID/Dio Imena]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Dozvolite osobi da moze vaditi oruzje iz paketa, koristite /weapons view da vidite ID paketa!");
			return 1;
		}	
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraca!");
		if( PlayerInfo[ playerid ][ pJob ] != DEALER_ID || !PlayerInfo[playerid][pMember] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste Gun Dealer ili u skriptanoj organizaciji!");
		if(PlayerInfo[ giveplayerid ][ pMember ] != PlayerInfo[playerid][pMember] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Osoba nije u vasoj organizaciji!");
		Bit16_Set( gr_PlayerCanManagePackage, giveplayerid, INVALID_PLAYER_ID);
		va_SendClientMessage( giveplayerid, COLOR_RED, "[ ! ] %s vam je skinuo dopustenje za upravljanje paketa. ", GetName(playerid, true));
		va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Skinuo si %s dopustenje za upravljanje paketa.", GetName(giveplayerid, true));
	}
	else if( !strcmp( pick, "pickup") )
	{
		new slotid;
		if (sscanf(params, "s[12]i", pick, slotid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons pickup [packageID]");
			CheckPlayerOrderedCrates(playerid);
			return 1;
		}
		if(slotid < 0 || slotid > 30)
			return SendErrorMessage(playerid, "ID paketa ne moze biti manji od 0, niti veci od 30.");
		if ( WOCrateInfo[slotid][cPlayerSQLID] != PlayerInfo[playerid][pSQLID] && Bit16_Get( gr_PlayerCanManagePackage, playerid ) != WOCrateInfo[slotid][cPlayerSQLID])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " To nije vas paket.");
		if( WOCrateInfo[ slotid ][ cOpened ] != 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Paket je otvoren i vise nije u kontejneru.");
		
		new cratelocation = WOCrateInfo[slotid][cLocation];
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, WoDeliver[cratelocation][woPosX], WoDeliver[cratelocation][woPosY], WoDeliver[cratelocation][woPosZ])) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste u blizini narucenog paketa."); 
			
		if(!AtLeastTwoMembers(playerid, 50.0, WoDeliver[cratelocation][woPosX], WoDeliver[cratelocation][woPosY], WoDeliver[cratelocation][woPosZ]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete sami u akciju preuzimanja paketa."); 
			
		if (WOCrateInfo[slotid][cTime] > gettimestamp()) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Paket jos nije stigao."); // nije stigao
		SpawnWeaponCrate(slotid); // spawnaj kutiju
		
	}
	else if( !strcmp( pick, "view") )
	{
		CheckPlayerOrderedCrates(playerid);
	}
	else if( !strcmp( pick, "take") )
	{
		TakeWeaponCrateFromFloor(playerid);
	}
	else if( !strcmp( pick, "drop") )
	{
		if( Bit16_Get( gr_PlayerCarryPackage, playerid ) != INVALID_WOCRATE_ID)
			DropWeaponCrate(playerid);
		else
			SendClientMessage(playerid, COLOR_RED, "Greska: Nista ne nosite!");
	}
	else if( !strcmp( pick, "vehtake") )
	{
		new crateid;
		if (sscanf(params, "s[12]ii", pick, crateid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons vehtake [packageID]");
			SendClientMessage(playerid, COLOR_WHITE, "Za ID kutije sjedni u vozilo koristi /weapons vehinfo.");
			return 1;
		}
		TakeWeaponCrateFromVehicle(playerid, crateid);
	}
	else if( !strcmp( pick, "vehput") ) 
	{
		if( !IsPlayerAttachedObjectSlotUsed( playerid, 9 ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne nosite kutiju!");
		new vehicleid = INVALID_VEHICLE_ID;
		foreach(new i : COVehicles)
		{
			new Float:X, Float:Y, Float:Z;
			GetVehiclePos(i, X, Y, Z);
			if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z))
			{
				switch( GetVehicleModel( i ) ) 
				{
					case 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 548, 417, 487, 447, 469, 563, 593, 519, 460, 406, 498, 499, 573, 455, 403, 414, 456, 508, 470, 459, 422, 482, 418, 413, 440, 578, 554:
					{
						vehicleid = i;
						break;
					}
				}
			}
		}
		if( vehicleid == INVALID_VEHICLE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu broda/kombija!");
		if(!Iter_Contains(COVehicles, vehicleid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To vozilo nije CO!");
		PutWeaponsCrateInVehicle( playerid, vehicleid );
	}
	else if( !strcmp( pick, "vehinfo") ) {
		if( !GetPlayerVehicleID( playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar vozila!");
		new vehicleid = GetPlayerVehicleID( playerid );
		CheckWeaponsCrateInVehicle(playerid, vehicleid);
	}
	else if( !strcmp( pick, "assembly") )
	{
		new slotid, ammo;
		if (sscanf(params, "s[12]ii", pick, slotid, ammo))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons assembly [packageID] [ammo]");
			CheckPlayerOrderedCrates(playerid);
			return 1;
		}
		if (WOCrateInfo[slotid][cPlayerSQLID] != PlayerInfo[playerid][pSQLID] && Bit16_Get( gr_PlayerCanManagePackage, playerid ) != WOCrateInfo[slotid][cPlayerSQLID])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, " To nije vas paket.");
		if(IsPlayerInRangeOfWOCrateByID(playerid, slotid, 5.0) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste u blizini tog paketa.");
		if(WOCrateInfo[ slotid ][ cVehId ] != INVALID_VEHICLE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Paket prvo treba istovariti iz vozila.");
		if(WOCrateInfo[ slotid ][ cOpened ] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Paket nije otpakiran.");
		
		if (ammo <= 0 || ammo > WOCrateInfo[slotid][cWeaponAmmo]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " U kutiji nema toliko metaka! min. 1 -  max. %d", WOCrateInfo[slotid][cWeaponAmmo]);
		
		WOCrateInfo[slotid][cWeaponAmmo] -= ammo;
		AC_GivePlayerWeapon(playerid, WOCrateInfo[slotid][cWeaponId], ammo);
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Uzeo si %s sa %d metaka iz paketa, ostalo je jos %d metaka u paketu. **",
			WeapNames[WOCrateInfo[slotid][cWeaponId]],
			ammo,
			WOCrateInfo[slotid][cWeaponAmmo]
		);
		new tmpString[ 64 ];
		format(tmpString, sizeof(tmpString), "** %s vadi oruzje iz kutije s natpisom >>%s<<.",GetName(playerid, true), WeapNames[WOCrateInfo[slotid][cWeaponId]]);
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		UpdateWOCrate(slotid);
		// Ako je 0 metaka, brise se paket
		if(WOCrateInfo[slotid][cWeaponAmmo] == 0)
		{
			if( IsValidDynamicObject(WOCrateInfo[ slotid ][ cObject ]) ) {
				DestroyDynamicObject( WOCrateInfo[ slotid ][ cObject ] );
				WOCrateInfo[ slotid ][ cObject ] = INVALID_OBJECT_ID;
			}
			va_SendClientMessage(playerid, COLOR_RED, "** Ispraznio si paket ID %d.", slotid);
			DeleteWOCrate(slotid);
			WOCrateInfo[ slotid ][ cSQLID ] = 0;
			WOCrateInfo[ slotid ][ cPlayerSQLID ] = INVALID_PLAYER_ID;
			WOCrateInfo[ slotid ][ cOpened ] = 0;
			WOCrateInfo[ slotid ][ cLocation ] = 0;
			WOCrateInfo[ slotid ][ cTime ] = 0;
			WOCrateInfo[ slotid ][ cWeaponId ] = 0;
			WOCrateInfo[ slotid ][ cWeaponAmmo ] =0;
			WOCrateInfo[ slotid ][ cVehId ] = INVALID_VEHICLE_ID;
			WOCrateInfo[ slotid ][ cX ] = 0;
			WOCrateInfo[ slotid ][ cY ] = 0;
			WOCrateInfo[ slotid ][ cZ ] = 0;
			Iter_Remove(WOCrates, slotid);
		}
	}
	return 1;
}
CMD:worders(playerid, params[])
{
	new pick[ 12 ];
	if( PlayerInfo[ playerid ][ pAdmin ] < 4 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate ovlasti!");
	if( sscanf( params, "s[12] ", pick ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons [odabir]");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: list - delete");
		return 1;
	}
	if( !strcmp( pick, "list") )
	{
		new date[6];
		SendClientMessage( playerid, COLOR_GREEN, "---------------Popis narucenih paketa oruzja ---------------");
		foreach (new i : WOCrates) {
			stamp2datetime(WOCrateInfo[i][cTime], date[0], date[1] ,date[2], date[3], date[4], date[5]);
			va_SendClientMessage(playerid, COLOR_WHITE, "[%d] pSQLID: %d-%s (%d) - %02d/%02d/%02d %02d:%02d / VehSQLID: %d / Pos: %.2f, %.2f, %.2f",
				i,
				WOCrateInfo[ i ][ cPlayerSQLID ],
				WeapNames[WOCrateInfo[i][cWeaponId]],
				WOCrateInfo[i][cWeaponAmmo],
				date[2],
				date[1],
				date[0],
				date[3],
				date[4],
				WOCrateInfo[ i ][ cVehId ],
				WOCrateInfo[ i ][ cX ],
				WOCrateInfo[ i ][ cY ],
				WOCrateInfo[ i ][ cZ ]
				
			);
		}
	}
	else if( !strcmp( pick, "delete") )
	{
		new slotid;
		if (sscanf(params, "s[12]i", pick, slotid))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons delete [ID]");
			return 1;
		}
		if (1 > slotid > 10) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " ID je od 0 - 10", WOCrateInfo[slotid][cWeaponAmmo]);
		new string [128];
		format(string, sizeof(string), "[!] Admin %s obrisao weapon order paket pod ID %d", GetName(playerid,false), slotid);
		SendAdminMessage(COLOR_RED, string);
		
		LogWOCrates(string); // spremi u log
		DeleteWOCrate(slotid);
		if( IsValidDynamicObject(WOCrateInfo[ slotid ][ cObject ]) ) {
			DestroyDynamicObject( WOCrateInfo[ slotid ][ cObject ] );
			WOCrateInfo[ slotid ][ cObject ] = INVALID_OBJECT_ID;
		}
		WOCrateInfo[ slotid ][ cSQLID ] = 0;
		WOCrateInfo[ slotid ][ cPlayerSQLID ] = INVALID_PLAYER_ID;
		WOCrateInfo[ slotid ][ cLocation ] = 0;
		WOCrateInfo[ slotid ][ cTime ] = 0;
		WOCrateInfo[ slotid ][ cWeaponId ] = 0;
		WOCrateInfo[ slotid ][ cWeaponAmmo ] =0;
		WOCrateInfo[ slotid ][ cVehId ] = INVALID_VEHICLE_ID;
		WOCrateInfo[ slotid ][ cX ] = 0;
		WOCrateInfo[ slotid ][ cY ] = 0;
		WOCrateInfo[ slotid ][ cZ ] = 0;
		Iter_Remove(WOCrates, slotid);
		
	}
	return 1;
}
// pawn shop
