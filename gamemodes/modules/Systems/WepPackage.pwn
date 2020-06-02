/*
*	  Weapon Package - Gun Dealing
*			player + vehicle
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o
	  Revamped and fixed by Khawaja
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI\y_hooks>

/*
	- defines & enumerator
*/
#define MAX_LISTED_WEAPONS	(11)	// maximalno oruzja za kupnju - /warehouse getgun.
#define MAX_PACKAGE_AMOUNT	(200)	// maximalno municije u jednom paketu.
#define MAX_PLAYER_PACKAGES (10)	// maximalno koliko jedan igrac moze imati paketa.
#define MAX_PACKAGES		(10)	// maximalno narucenih paketa.
#define PACKAGE_COOLDOWN	(120)	// Svakih '?' koliko ce se moci narucit paket.
#define MINUTES_TILL_PACKAGE_ARRIVE (10) // Koliko minuta treba da paket dodje u warehouse.
#define INVALID_PACKAGE_ID	(-1)	// Invalid ID
#define PACKAGE_PANCIR		(6969)	// Pancir Package (random id)

enum E_WEAPON_PACKAGE {
	wep_ID,
	wep_Name[16],
	wep_Price
}

enum E_PACKAGE_DATA {
	faction_ID,
	PackageAmount,
	PackageWeapon
}

enum E_PLAYER_PACKAGES {
	p_SQLID,
	packExists,
	p_weapon,
	p_amount
}

new
	show_WeaponList[MAX_LISTED_WEAPONS][E_WEAPON_PACKAGE] = {
	{24, 			"DEAGLE", 			70},
	{22,		    "COLT",		        45},
	{29,		    "MP5",		        85},
	{23,		    "SILENCED",		    60},
	{25,		    "SHOTGUN",		    90},
	{32,    		"TEC9",		        60},
	{28,		    "UZI",		        60},
	{30,		    "AK47",		        110},
	{31,		    "M4",		      	125},
	{34,	    	"SNIPER",         	900},
	{33,		    "RIFLE",		    130}
};

enum E_ORDERLOCATION_DATA
{
	Float:LocationX,
	Float:LocationY,
	Float:LocationZ
}

static const PossibleDropSpots[][E_ORDERLOCATION_DATA] = {
	{2424.8503,-2510.8821,13.6549},
	{1391.8441,-1898.1373,13.4993},
	{815.4924,-1105.4757,25.7900},
	{1645.7418,-1203.1865,19.7800},
	{1549.8967,-31.6534,21.3314},
	{1231.2700,215.0536,19.5547},
	{1606.3379,602.3615,7.7802},
	{1583.7024,1963.8127,10.8203},
	{2409.8606,2798.7266,10.8203},
	{1066.3962,2912.5288,47.8231},
	{-545.6984,2571.1699,53.5156},
	{-1206.0120,1838.6991,41.7244},
	{-2473.6475,2290.0630,4.9844},
	{-2443.1155,1040.1559,50.3906},
	{-2113.3818,-2280.3872,30.6250},
	{-1216.1965,-2625.8608,10.1196},
	{21.7193,-2635.5833,40.4120},
	{-1432.3746, -964.3013, 200.9599},
	{2268.3137, -2570.4019, 8.3603},
	{-1977.8420, 455.9144, 28.3573},
	{-1805.8313, 1304.8137, 50.4453}
};


new WeaponOrderSpot[MAX_PLAYERS];
new WeaponOrderArea[MAX_PLAYERS];

/*
	- vars & iters
*/

new
	get_PackageWeapon[MAX_PLAYERS] = 0,
	get_PackageAmount[MAX_PLAYERS] = 0,
	get_PackagePrice[MAX_PLAYERS] = 0,
	timer_Package[MAX_PLAYERS] = 0,
	timer_unpacking[MAX_PLAYERS] = 0,
	get_PackageID[MAX_PLAYERS] = INVALID_PACKAGE_ID,

	bool: PlayerUnpacking[MAX_PLAYERS] = false,
	bool: PackageOrdered[MAX_PLAYERS] = false,
	Float: get_PlayerPos[MAX_PLAYERS][3],

	WarehouseActor[MAX_PLAYERS],
	WarehousePackage[MAX_PLAYERS][1],

	quickw_timer[MAX_PLAYERS],

	PackageCooldown,
	PackageData[MAX_PACKAGES][E_PACKAGE_DATA],
	PlayerPackage[MAX_PLAYERS][E_PLAYER_PACKAGES][MAX_PACKAGES],

	Iterator:PACKAGES<MAX_PACKAGES>,
	Iterator:P_PACKAGES[MAX_PLAYERS]<MAX_PLAYER_PACKAGES>,
	Iterator:V_PACKAGES[MAX_VEHICLES]<MAX_PACKAGE_VEHICLE>;

/*
	- mySQL
*/

LoadPlayerPackage(playerid) {
	new query[128];

	format(query, sizeof(query), "SELECT * FROM `player_wpackages` WHERE `playerSQL` = '%d' LIMIT 0,10",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_pquery(g_SQL, query, "LoadingPlayerPackages", "i", playerid);
	return (true);
}

LoadVehiclePackage(vehicleid) {
	new
		query[128];
	format(query, sizeof(query), "SELECT * FROM `cocars_wpackages` WHERE `vehicleid` = '%d' LIMIT 0,15",
		VehicleInfo[vehicleid][vSQLID]
	);
	mysql_pquery(g_SQL, query, "LoadingVehiclePackages", "i", vehicleid);
	return (true);
}

Function: StorePackageInDB(vehicleid, slot) {
	VehicleInfo[vehicleid][packSQLID][slot] = cache_insert_id();
	return (true);
}

Function: StorePPackageInDB(playerid, slot) {
	PlayerPackage[playerid][p_SQLID][slot] = cache_insert_id();
	return (true);
}

forward LoadingPlayerPackages(playerid);
public LoadingPlayerPackages(playerid) {
	if(cache_num_rows()) {
		for(new i = 0; i < cache_num_rows(); i++) {
			cache_get_value_name_int(i, "id", PlayerPackage[playerid][p_SQLID][i]);
			cache_get_value_name_int(i, "weap", PlayerPackage[playerid][p_weapon][i]);
			cache_get_value_name_int(i, "ammo", PlayerPackage[playerid][p_amount][i]);

			Iter_Add(P_PACKAGES[playerid], i);
			PlayerPackage[playerid][packExists][i] = 1;
		}
	}
	return (true);
}

forward LoadingVehiclePackages(vehicleid);
public LoadingVehiclePackages(vehicleid) {
	if(cache_num_rows()) {
	    for(new i = 0; i < cache_num_rows(); i++) {
			cache_get_value_name_int(i, "id", VehicleInfo[vehicleid][packSQLID][i]);
			cache_get_value_name_int(i, "weap", VehicleInfo[vehicleid][packWepID][i]);
			cache_get_value_name_int(i, "ammo", VehicleInfo[vehicleid][packAmmo][i]);

			Iter_Add(V_PACKAGES[vehicleid], i);
		}
	}
	return (true);
}

/*
	- functions
*/
stock LogWpackages(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/weapon_packages.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

SavePlayerPackages(playerid, slot) {
	new query[ 164 ];
	format(query, sizeof(query), "INSERT INTO `player_wpackages`(`playerSQL`, `weap`, `ammo`) VALUES ('%d', '%d', '%d')",
		PlayerInfo[playerid][pSQLID],
		PlayerPackage[playerid][p_weapon][slot],
		PlayerPackage[playerid][p_amount][slot]
	);
	mysql_tquery(g_SQL, query, "StorePPackageInDB", "ii", playerid, slot);
	return (true);
}

SaveVehiclePackages(vehicleid, slot) {
	new query[ 164 ];
	format(query, sizeof(query), "INSERT INTO `cocars_wpackages`(`vehicleid`, `weap`, `ammo`) VALUES ('%d','%d','%d')",
		VehicleInfo[vehicleid][vSQLID],
		VehicleInfo[vehicleid][packWepID][slot],
		VehicleInfo[vehicleid][packAmmo][slot]
	);
	mysql_tquery(g_SQL, query, "StorePackageInDB", "ii", vehicleid, slot);
	return (true);
}

ResetVehiclePackages(vehicleid) {
	foreach(new slots: V_PACKAGES[vehicleid]) {
		VehicleInfo[vehicleid][packSQLID] = -1;
		VehicleInfo[vehicleid][packWepID][slots] = 0;
		VehicleInfo[vehicleid][packAmmo][slots] = 0;
	}
	Iter_Clear(V_PACKAGES[vehicleid]);
	return (true);
}

ResetPlayerPackages(playerid) {
	foreach(new slots: P_PACKAGES[playerid]) {
		PlayerPackage[playerid][p_SQLID][slots] = -1;
		PlayerPackage[playerid][p_weapon][slots] = 0;
		PlayerPackage[playerid][p_amount][slots] = 0;
	}
	Iter_Clear(P_PACKAGES[playerid]);
	return (true);
}

PutPackageVehicle(playerid, vehicleid, vslot, pslot) {
	VehicleInfo[vehicleid][packWepID][vslot] = PlayerPackage[playerid][p_weapon][pslot];
	VehicleInfo[vehicleid][packAmmo][vslot] = PlayerPackage[playerid][p_amount][pslot];

	// Logs
	new tmpLog[128], weapon_name[16];
	GetWeaponName(VehicleInfo[vehicleid][packWepID][vslot], weapon_name, 16);

	format( tmpLog, sizeof(tmpLog), "[VEHICLE-PUT] %s je ostavio oruzije u vozilo(sql_id: %d) (w_name: %s / w_amount: %d).",
		GetName(playerid, false),
		vehicleid,
		weapon_name,
		VehicleInfo[vehicleid][packAmmo][vslot]
	);
	LogWpackages(tmpLog);

	SaveVehiclePackages(vehicleid, vslot);
	Iter_Add(V_PACKAGES[vehicleid], vslot);
	DeletePlayerPackage(playerid, pslot);
	Iter_Remove(P_PACKAGES[playerid], pslot);
	return (true);
}

TakePackageVehicle(playerid, vehicleid, vslot, pslot) {
	PlayerPackage[playerid][packExists][pslot] = 1;
	PlayerPackage[playerid][p_weapon][pslot] = VehicleInfo[vehicleid][packWepID][vslot];
	PlayerPackage[playerid][p_amount][pslot] = VehicleInfo[vehicleid][packAmmo][vslot];
	SavePlayerPackages(playerid, pslot);

	// Logs
	new tmpLog[128], weapon_name[16];
	GetWeaponName(VehicleInfo[vehicleid][packWepID][vslot], weapon_name, 16);

	format( tmpLog, sizeof(tmpLog), "[VEHICLE-TAKE] %s je uzeo oruzije iz vozila(sql_id: %d) (w_name: %s / w_amount: %d).",
		GetName(playerid, false),
		vehicleid,
		weapon_name,
		VehicleInfo[vehicleid][packAmmo][vslot]
	);
	LogWpackages(tmpLog);

	Iter_Add(P_PACKAGES[playerid], pslot);
	DeleteVehiclePackage(vehicleid, vslot);
	return (true);
}

DeleteVehiclePackage(vehicleid, slot) {
	new query[ 128 ];

	VehicleInfo[vehicleid][packWepID][slot] = 0;
	VehicleInfo[vehicleid][packAmmo][slot] = 0;

	format(query, sizeof(query), "DELETE FROM `cocars_wpackages` WHERE `id` = '%d'",
		VehicleInfo[vehicleid][packSQLID][slot]
	);
	mysql_tquery(g_SQL, query, "", "");

	Iter_Remove(V_PACKAGES[vehicleid], slot);
	return (true);
}

DeletePlayerPackage(playerid, package_id) {
	new query[ 128 ];

	PlayerPackage[playerid][p_weapon][package_id] = 0;
	PlayerPackage[playerid][p_amount][package_id] = 0;
	PlayerPackage[playerid][packExists][package_id] = 0;

	format(query, sizeof(query), "DELETE FROM `player_wpackages` WHERE `id` = '%d'",
		PlayerPackage[playerid][p_SQLID][package_id]
	);
	mysql_tquery(g_SQL, query, "", "");
	return (true);
}

ResetPackageSettings(playerid) {

	DisablePlayerCheckpoint(playerid);
	KillTimer(timer_Package[playerid]);
	PackageOrdered[playerid] = (false);

	get_PackageWeapon[playerid] = 0;
	get_PackageID[playerid] = INVALID_PACKAGE_ID;
	get_PackagePrice[playerid] = 0;
	get_PackageAmount[playerid] = 0;

	DestroyDynamicObject(WarehousePackage[playerid][0]);
	DestroyActor(WarehouseActor[playerid]);
	return (true);
}

GivePlayerPackage(playerid, targetid, package_id, wep, amount) {
	PlayerPackage[targetid][p_weapon][package_id] = wep;
	PlayerPackage[targetid][p_amount][package_id] = amount;
	PlayerPackage[targetid][packExists][package_id] = 1;

	SavePlayerPackages(targetid, package_id);
	Iter_Add(P_PACKAGES[targetid], package_id);

	// Logs
	new tmpLog[128], weapon_name[16];
	GetWeaponName(wep, weapon_name, 16);

	format( tmpLog, sizeof(tmpLog), "[PLAYER-GIVE] %s je dao igracu %s paket sa oruzijem (w_name: %s / w_amount: %d).",
		GetName(playerid, false),
		GetName(targetid, false),
		weapon_name,
		amount
	);
	LogWpackages(tmpLog);
	return (true);
}

/*
	- timers
*/

Function: UnpackPackage(playerid, package_id) {
	new crouch = IsCrounching(playerid), Float: get_armor;
	GetPlayerArmour(playerid, get_armor);

	if(PlayerPackage[playerid][p_weapon][package_id] != PACKAGE_PANCIR) {
		SetAnimationForWeapon(playerid, PlayerPackage[playerid][p_weapon][package_id], crouch);
		AC_GivePlayerWeapon(playerid, PlayerPackage[playerid][p_weapon][package_id], PlayerPackage[playerid][p_amount][package_id], true, true);
	}
	PlayerUnpacking[playerid] = false;
	get_PlayerPos[playerid][0] = 0.0,
	get_PlayerPos[playerid][1] = 0.0,
	get_PlayerPos[playerid][2] = 0.0;

	GameTextForPlayer(playerid, "~b~PACKAGE UNPACKED", 5000, 4);

	// Logs
	new tmpLog[128], weapon_name[32];
	if(PlayerPackage[playerid][p_weapon][package_id] != PACKAGE_PANCIR)
		GetWeaponName(PlayerPackage[playerid][p_weapon][package_id], weapon_name, 32);

	format( tmpLog, sizeof(tmpLog), "[UNPACKAGE] %s je raspakovo(unpackage) paket. (w_name: %s / w_amount: %d).",
		GetName(playerid, false),
		weapon_name,
		PlayerPackage[playerid][p_amount][package_id]
	);
	LogWpackages(tmpLog);
	DeletePlayerPackage(playerid, package_id);
	Iter_Remove(P_PACKAGES[playerid], package_id);
	return (true);
}

Function: CreatePackage(playerid, factionID, packageID, int, vw) {

	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

    new
		id, str[128];

	id = random(sizeof(PossibleDropSpots));
	WeaponOrderSpot[playerid] = id;
	WeaponOrderArea[playerid] = CreateDynamicCircle(PossibleDropSpots[id][LocationX], PossibleDropSpots[id][LocationY], 20.0, 0, 0, playerid);

	format(str, sizeof(str), "SMS: Koordinate: %.4f, %.4f. stvori se tu., Posiljatelj: 32715", PossibleDropSpots[id][LocationX], PossibleDropSpots[id][LocationY]);
	SendClientMessage(playerid, COLOR_RED, str);

    WarehousePackage[playerid][0] = CreateDynamicObject(1340, PossibleDropSpots[id][LocationX]-3.0, PossibleDropSpots[id][LocationY], PossibleDropSpots[id][LocationZ], 0.00000, 0.00000, 0.00000, -1, -1, -1, 300.00, 300.00);
    WarehouseActor[playerid] = CreateActor(119, PossibleDropSpots[id][LocationX]-4.0, PossibleDropSpots[id][LocationY], PossibleDropSpots[id][LocationZ], -90.0);

	SetPlayerCheckpoint(playerid, PossibleDropSpots[id][LocationX], PossibleDropSpots[id][LocationY], PossibleDropSpots[id][LocationZ], 2.0);
	KillTimer(timer_Package[playerid]);
	return (true);
}

/*
	- hooks
*/
hook OnPlayerEnterCheckpoint(playerid) {
	if(PackageOrdered[playerid] == true) {
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, PossibleDropSpots[WeaponOrderSpot[playerid]][LocationX], PossibleDropSpots[WeaponOrderSpot[playerid]][LocationY], PossibleDropSpots[WeaponOrderSpot[playerid]][LocationZ]))
			return (true);

		new buffer[300], weapon_name[16],
			package_id = get_PackageID[playerid];

		if(PackageOrdered[playerid] == false || package_id == INVALID_PACKAGE_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Nemate narucenu posiljku, prvo je morate naruciti da bi ju provijerili.");

		GetWeaponName(PackageData[package_id][PackageWeapon], weapon_name, 16);
		if(PackageData[package_id][PackageWeapon] != PACKAGE_PANCIR) {
			format(buffer, sizeof(buffer), "{FA5656}[ WAREHOUSE - WEAPON ORDER ]\n\nWeapon: %s.\nPackage Ammo: %d (ammo).\nPackage Price: %s.\nFaction: %s.\n\nZelite li preuzeti ovaj paket?",
				weapon_name,
				PackageData[package_id][PackageAmount],
				FormatNumber(get_PackagePrice[playerid]),
				ReturnPlayerFactionName(playerid)
			);
		}	ShowPlayerDialog(playerid, DIALOG_TAKE_PACKAGE, DIALOG_STYLE_MSGBOX, "{FA5656}* PACKAGE - Confirmation", buffer, "(confirm)", "(x)");
	}
	return (true);
}

hook OnPlayerDeath(playerid, killerid, reason) {
	foreach(new i : P_PACKAGES[playerid]) {
		if(PlayerPackage[playerid][p_weapon][i] != 0) {
			DeletePlayerPackage(playerid, i);
		}
	}
	Iter_Clear(P_PACKAGES[playerid]);
	return (true);
}


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)  {
		case DIALOG_PACKAGE_ORDER: {
			if(!response){
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): �ta me drka� koju picku materinu, daj odjebi!");
                PlayerHangup(playerid);
				return 0;
			}
			new buffer[164];
			get_PackageWeapon[playerid] = listitem;
			if(get_PackageWeapon[playerid] != 11) {
				format(buffer, sizeof(buffer), "\nSada unesite koliko metaka zalite da dobijete u paketu.\n{3C95C2}[NAPOMENA]:Maximalno mozete naruciti %d metaka.", MAX_PACKAGE_AMOUNT);
				ShowPlayerDialog(playerid, DIALOG_PACKAGE_AMOUNT, DIALOG_STYLE_INPUT, "{3C95C2}* Package - Ammo", buffer, "(order)", "(x)");
			}
			return (true);
		}
		case DIALOG_PACKAGE_AMOUNT: {
			if(!response){
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): �ta me drka� koju picku materinu, daj odjebi!");
                PlayerHangup(playerid);
				return 0;
			}
			new ammo_amount = strval(inputtext),
				package_wep = get_PackageWeapon[playerid],
				package_amount = floatround(floatabs(ammo_amount)),
				package_price = show_WeaponList[package_wep][wep_Price] * package_amount,
				buffer[284];

			if(ammo_amount == 0){
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Ne prodajem prazne kartonske kutije.");
                PlayerHangup(playerid);
				return 0;
			}

			if(ammo_amount > MAX_PACKAGE_AMOUNT)
				return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise od %d metaka naruciti u jednom paketu.", MAX_PACKAGE_AMOUNT);

			get_PackageAmount[playerid] = package_amount;

			format(buffer, sizeof(buffer), "{3C95C2}[ WAREHOUSE - WEAPON PACKAGE ]\n\nWeapon: %s.\nPackage Ammo: %d (ammo).\nPackage Price: %s.\nFaction: %s.\n",
				show_WeaponList[ package_wep ][ wep_Name ],
				package_amount,
				FormatNumber(package_price),
				ReturnPlayerFactionName(playerid)
			);
			ShowPlayerDialog(playerid, DIALOG_PACKAGE_CONFIRM, DIALOG_STYLE_MSGBOX, "{3C95C2}* Package - Informations", buffer, "(order)", "(x)");
			return true;
		}
		case DIALOG_PACKAGE_CONFIRM: {
			if(!response){
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): �ta me drka� koju picku materinu, daj odjebi!");
                PlayerHangup(playerid);
				return 0;
			}
			new
				package_amount = get_PackageAmount[playerid],
				package_wep = get_PackageWeapon[ playerid ],
				package_price = show_WeaponList[package_wep][wep_Price] * (package_amount);

			if( Iter_Count(PACKAGES) == 10 )
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno je aktivno previse posiljka, pricekajte neko vrijeme da mozete naruciti posiljku.");
			if( AC_GetPlayerMoney(playerid) < package_price ){
				SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Nema� ni centa, a u neke bi vece �eme, hah.");
				PlayerHangup(playerid);
				return 0;
			}
			if(gettimestamp() < PackageCooldown)
			{
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Morate sacekati %d sekundi kako bi narucili paket.", PACKAGE_COOLDOWN);
                PlayerHangup(playerid);
				return 0;
			}
			if(PackageOrdered[playerid] == true)
					return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vi vec imate narucenu posiljku, da pogledate vasu posiljku kucajte /package checkorder.");
			PlayerToIllegalBudgetMoney(playerid, package_price); // Ilegalni Budget dobiva novce

			new free_id = Iter_Free(PACKAGES), weapon_name[16];
			GetWeaponName(show_WeaponList[package_wep][wep_ID], weapon_name, 16);

			PackageCooldown = gettimestamp() + PACKAGE_COOLDOWN;
			get_PackagePrice[playerid] = package_price;
			get_PackageID[playerid] = free_id;
			PackageOrdered[playerid] = true;

			PackageData[free_id][faction_ID]	= PlayerInfo[playerid][pMember];
			PackageData[free_id][PackageAmount] = package_amount;
			PackageData[free_id][PackageWeapon] = show_WeaponList[package_wep][wep_ID];
			Iter_Add(PACKAGES, free_id);
			
			va_SendClientMessage(playerid, COLOR_YELLOW, "%s (mobitel): Uredu treba mi %s, sa %d metaka. Nemoj �tedjeti na meni!", GetName(playerid, false), weapon_name, package_amount);
            SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Dogovoreno. Kroz par minuta ces dobiti koordinate gdje da dodjes.");
			PlayerHangup(playerid);

			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste narucili paket %s sa %d metaka, cijena: %s.", weapon_name, package_amount, FormatNumber(package_price));
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Kroz par minuta cete dobiti poziv sa informacijama u vezi vase posiljke.");

			timer_Package[playerid] = SetTimerEx("CreatePackage", 30000*MINUTES_TILL_PACKAGE_ARRIVE, (false), "iiiii",
				playerid,
				PackageData[free_id][faction_ID],
				free_id,
				GetPlayerInterior(playerid),
				GetPlayerVirtualWorld(playerid)
			);


			// Logs
			new tmpLog[128];

			format( tmpLog, sizeof(tmpLog), "[ORDER-PACKAGE] %s je narucio paket oruzja za %s. (w_name: %s / w_amount: %d).",
				GetName(playerid, false),
				FormatNumber(package_price),
				weapon_name,
				package_amount
			);
			LogWpackages(tmpLog);
		}
		case DIALOG_TAKE_PACKAGE: {
			if(!response)
				return SendClientMessage(playerid, COLOR_YELLOW, "Maska 64361 kaze (mobitel): Ej kume daj se sa sobom dogovorili, jel hoces ili neces?!");
			if(response) {
				if( Iter_Count(P_PACKAGES[playerid]) == MAX_PLAYER_PACKAGES )
					return va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Vi vec imate maximum(%d) broj paketa kod sebe.", MAX_PLAYER_PACKAGES);
				if( PlayerInfo[playerid][pLevel] == 1 )
					return SendMessage(playerid, COLOR_RED, "[ ! ] Ne mozete naruciti package jer ste level 1!");

				new i = Iter_Free(P_PACKAGES[playerid]),
					pack_id = get_PackageID[playerid],
					weapon_name[16];

				PlayerPackage[playerid][p_weapon][i] = PackageData[pack_id][PackageWeapon];
				PlayerPackage[playerid][p_amount][i] = PackageData[pack_id][PackageAmount];
				PlayerPackage[playerid][packExists][i] = 1;

				SavePlayerPackages(playerid, i);
				Iter_Add(P_PACKAGES[playerid], i);

				Iter_Remove(PACKAGES, pack_id);
				ResetPackageSettings(playerid);

				GetWeaponName(PlayerPackage[playerid][p_weapon][i], weapon_name, 16);
				if(PlayerPackage[playerid][p_weapon][i] != PACKAGE_PANCIR)
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste preuzeli vasu posiljku (%s | %d ammo).", weapon_name, PlayerPackage[playerid][p_amount][i]);
     			SendClientMessage(playerid, COLOR_RED, "[ ! ] Za pregled paketa /package stats, za otpakiravanje /package unpackage");

				// Logs
				new tmpLog[128];

				format( tmpLog, sizeof(tmpLog), "[TAKE-PACKAGE] %s je preuzeo paket iz warehouse-a. (w_name: %s / w_amount: %d).",
					GetName(playerid, false),
					weapon_name,
					PlayerPackage[playerid][p_amount][i]
				);
				LogWpackages(tmpLog);
			}
		}
	}
	return (true);
}

hook OnPlayerUpdate(playerid) {
    if(PlayerUnpacking[playerid]) {
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);

        if(get_PlayerPos[playerid][0] != x && get_PlayerPos[playerid][1] != y && get_PlayerPos[playerid][2] != z) {
            SendClientMessage(playerid, COLOR_LIGHTRED,"[ ! ] - Pomjerili ste se tokom obavljanja funkcije, ista je automatski prekinuta.");
			PlayerUnpacking[playerid] = false;
			KillTimer(timer_unpacking[playerid]);
		}
	}
	return (true);
}

hook OnPlayerDisconnect(playerid, reason) {
	if(PackageOrdered[playerid] == (true)) {
		Iter_Remove(PACKAGES, get_PackageID[playerid]);
		ResetPackageSettings(playerid);
	}
	ResetPlayerPackages(playerid);
	return (true);
}

/*
	- COMMANDS
*/
CMD:package(playerid, params[]) {
	new action[25], weapon_name[16], carname[36];

	if(sscanf(params, "s[25] ", action)) {
		SendClientMessage(playerid, COLOR_RED, "USAGE: /package [option].");
		SendClientMessage(playerid, COLOR_RED, "(options): stats, checkorder, unpackage, give");
		SendClientMessage(playerid, COLOR_RED, "(vehicle): vehstats, vehput, vehtake");
		if(PlayerInfo[playerid][pAdmin] != 0)
			SendClientMessage(playerid, COLOR_RED, "(admin): checkplayer, resetpackages, givepackage, checkveh, vresetpackages");
		return (true);
	}

	if(strcmp(action, "givepackage", true) == 0) {
		new targetid, weapon_id, ammo_amount;
		if(PlayerInfo[playerid][pAdmin] < 1337)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

		if(sscanf(params, "s[25]iii", action, targetid, weapon_id, ammo_amount)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package givepackage [targetid] [weapon_id] [ammo_amount].");
			return (true);
		}
		if( Iter_Count(P_PACKAGES[targetid]) == MAX_PLAYER_PACKAGES )
			return va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac vec ima maximum(%d) broj paketa kod sebe.", MAX_PLAYER_PACKAGES);

		new i = Iter_Free(P_PACKAGES[targetid]);

		PlayerPackage[targetid][packExists][i] = 1;
		PlayerPackage[targetid][p_weapon][i] = weapon_id;
		PlayerPackage[targetid][p_amount][i] = ammo_amount;
		SavePlayerPackages(targetid, i);
		Iter_Add(P_PACKAGES[targetid], i);

		GetWeaponName(weapon_id, weapon_name, 16);
		va_SendClientMessage(targetid, COLOR_RED, "[ ! ] Administrator {FA5656}%s vam je dao paket sa oruzjem %s - ammo: %d.", GetName(playerid), weapon_name, ammo_amount);
		SendFormatMessage(playerid, COLOR_RED, "[ ! ] Dali ste igracu %s paket sa oruzjem %s - ammo: %d.", GetName(targetid), weapon_name, ammo_amount);

	}

	if(strcmp(action, "vresetpackages", true) == 0) {
		new vehicleid, d_query[128];
		if(PlayerInfo[playerid][pAdmin] < 3)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

		if(sscanf(params, "s[25]i", action, vehicleid)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package vresetpackages [vehicleid].");
			return (true);
		}
		foreach(new i : V_PACKAGES[vehicleid]) {
			if(VehicleInfo[vehicleid][packWepID][i] != 0) {
				VehicleInfo[vehicleid][packWepID][i] = 0;
				VehicleInfo[vehicleid][packAmmo][i] = 0;

				format(d_query, 128, "DELETE FROM `cocars_wpackages` WHERE `id` = '%d'",
					VehicleInfo[vehicleid][packSQLID][i]
				);
				mysql_tquery(g_SQL, d_query, "", "");
			}
		}
		SendFormatMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste vozilu id %d obrisali sve weapon pakete.", vehicleid);

		Iter_Clear(V_PACKAGES[vehicleid]);
	}

	if(strcmp(action, "checkveh", true) == 0) {
		new vehicleid;
		if(PlayerInfo[playerid][pAdmin] < 3)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 3+).");

		if(sscanf(params, "s[25]i", action, vehicleid)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package checkveh [vehicleid].");
			return (true);
		}
		strunpack(carname, Model_Name(VehicleInfo[vehicleid][vModel]));

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] |________ [ %s - Weapon Packages ] ________|", carname);
		foreach(new i : V_PACKAGES[vehicleid]) {
			if(VehicleInfo[vehicleid][packWepID][i] != 0) {
				GetWeaponName(VehicleInfo[vehicleid][packWepID][i], weapon_name, 16);
				if(VehicleInfo[vehicleid][packWepID][i] != PACKAGE_PANCIR)
					va_SendClientMessage(playerid, COLOR_WHITE, "(%d). %s (%d/%d).", i, weapon_name, VehicleInfo[vehicleid][packAmmo][i], MAX_PACKAGE_AMOUNT);
			}
		}
	}

	/*if(strcmp(action, "vehstats", true) == 0) {
		new vehicleid = PlayerInfo[playerid][pSpawnedCar];
		strunpack(carname, Model_Name(VehicleInfo[vehicleid][vModel]));

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] |________ [ %s - Weapon Packages ] ________|", carname);
		foreach(new i : V_PACKAGES[vehicleid]) {
			if(VehicleInfo[vehicleid][packWepID][i] != 0) {
				GetWeaponName(VehicleInfo[vehicleid][packWepID][i], weapon_name, 16);
				if(VehicleInfo[vehicleid][packWepID][i] != PACKAGE_PANCIR)
					va_SendClientMessage(playerid, COLOR_WHITE, "(%d). %s (%d/%d).", i, weapon_name, VehicleInfo[vehicleid][packAmmo][i], MAX_PACKAGE_AMOUNT);
			}
		}
	}*/

    if(strcmp(action, "vehstats", true) == 0) {
		SendClientMessage(playerid, COLOR_RED, "[ DEV ] Komanda je izbacena!");
	}

	if(strcmp(action, "vehtake", true) == 0) {
		new package_id, vehicleid = GetPlayerNearestPrivateVehicle(playerid),
			Float:X, Float:Y, Float:Z;
		GetVehiclePos(vehicleid, X, Y, Z);

		if(sscanf(params, "s[25]i", action, package_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package vehtake [package_id].");
			SendClientMessage(playerid, 0xAFAFAFAA, "[=>] package_id provijeravate na /package vehstats.");
			return (true);
		}
		if( vehicleid == INVALID_VEHICLE_ID )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu privatnog vozila!");
		if( !IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoga vozila!");
		if( VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prtljaznik nije otvoren!");
		if(!IsPlayerNearTrunk(playerid, vehicleid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti kod prtljaznika vozila.");
		if( IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete to koristiti!");
		if(!Iter_Contains(V_PACKAGES[vehicleid], package_id))
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Unijeli ste pogresan package_id, na /package vehstats provijeravate vase pakete.");

		// message
		GetWeaponName(VehicleInfo[vehicleid][packWepID][package_id], weapon_name, 16);
		if(VehicleInfo[vehicleid][packWepID][package_id] != PACKAGE_PANCIR) {
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uzeli ste vas paket sa %s(ammo: %d) iz vaseg vozila.",
				weapon_name,
				VehicleInfo[vehicleid][packAmmo][package_id]
			);
		}
		new i = Iter_Free(P_PACKAGES[playerid]);
		TakePackageVehicle(playerid, vehicleid, package_id, i);
	}

	if(strcmp(action, "vehput", true) == 0) {
		new package_id, vehicleid = GetPlayerNearestPrivateVehicle(playerid),
			Float:X, Float:Y, Float:Z;
		GetVehiclePos(vehicleid, X, Y, Z);

		if(sscanf(params, "s[25]i", action, package_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package vehput [package_id].");
			SendClientMessage(playerid, 0xAFAFAFAA, "[=>] package_id provijeravate na /package stats.");
			return (true);
		}
		if( vehicleid == INVALID_VEHICLE_ID )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu privatnog vozila!");
		if( !IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila!");
		if( VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prtljaznik nije otvoren!");
		if(!IsPlayerNearTrunk(playerid, vehicleid))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti kod prtljaznika vozila.");
		if( IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) )
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete to koristiti!");
		if(!Iter_Contains(P_PACKAGES[playerid], package_id))
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Unijeli ste pogresan package_id, na /package stats provijeravate vase pakete.");

		// message
		GetWeaponName(PlayerPackage[playerid][p_weapon][package_id], weapon_name, 16);
		if(PlayerPackage[playerid][p_weapon][package_id] != PACKAGE_PANCIR) {
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Ostavili ste vas paket sa %s(ammo: %d) u vase vozilo.",
				weapon_name,
				PlayerPackage[playerid][p_amount][package_id]
			);
		}
		new i = Iter_Free(V_PACKAGES[vehicleid]);
		PutPackageVehicle(playerid, vehicleid, i, package_id);
	}

	if(strcmp(action, "give", true) == 0) {
		new targetid, package_id;

		if(sscanf(params, "s[25]ii", action, targetid, package_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package give [playerid] [package_id].");
			SendClientMessage(playerid, 0xAFAFAFAA, "[=>] package_id provijeravate na /package stats.");
			return (true);
		}
		if( !Iter_Contains(P_PACKAGES[playerid], package_id))
			return SendClientMessage(playerid, COLOR_RED, "[ ! ]Unijeli ste pogresan package_id, na /package stats provjeravate vase pakete.");
		if( PlayerPackage[playerid][packExists][package_id] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Dogodila se greska, pokusajte ponovo kasnije ili se obratite administraciji."), DeletePlayerPackage(playerid, package_id), Iter_Remove(P_PACKAGES[playerid], package_id);
		if( targetid == playerid)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Ne mozete sebi dati paket oruzja.");
		if( !ProxDetectorS(5.0, playerid, targetid) )
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Taj igrac nije blizu vas !");
		if(PlayerUnpacking[playerid] == true)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Ne mozete to sada, vec raspakujete paket.");
		if( PlayerInfo[targetid][pLevel] == 1 )
			return SendMessage(playerid, COLOR_RED, "[ ! ] Ne mozete dati package osobi koja je level 1!");
		if( Iter_Count(P_PACKAGES[targetid]) == MAX_PLAYER_PACKAGES )
			return va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac vec ima maximum broj(%d) paketa kod sebe.", MAX_PLAYER_PACKAGES);
		if( gettimestamp() < quickw_timer[playerid])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate sacekati 2 sekundi.");

		// message
		GetWeaponName(PlayerPackage[playerid][p_weapon][package_id], weapon_name, 16);
		if(PlayerPackage[playerid][p_weapon][package_id] != PACKAGE_PANCIR) {
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s vas paket(id: %d) u kojem se nalazi %s(ammo: %d).",
				GetName(targetid),
				package_id,
				weapon_name,
				PlayerPackage[playerid][p_amount][package_id]
			);
			va_SendClientMessage(targetid, COLOR_RED, "[ ! ] %s vam je dao paket u kojem se nalazi %s(ammo: %d).",
				GetName(playerid),
				weapon_name,
				PlayerPackage[playerid][p_amount][package_id]
			);
		}
		new i = Iter_Free(P_PACKAGES[targetid]);
		GivePlayerPackage(playerid, targetid, i, PlayerPackage[playerid][p_weapon][package_id], PlayerPackage[playerid][p_amount][package_id]);
		DeletePlayerPackage(playerid, package_id);
		Iter_Remove(P_PACKAGES[playerid], package_id);
		quickw_timer[playerid] = gettimestamp() + 2;
	}


	if(strcmp(action, "unpackage", true) == 0) {
		new package_id, seconds, buffer[64],
			Float:x,Float:y,Float:z, Float: get_armor;
		GetPlayerArmour(playerid, get_armor);

		if(sscanf(params, "s[25]i", action, package_id)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package unpackage [package_id].");
			SendClientMessage(playerid, COLOR_GRAD2, "[=>] package_id provijeravate na /package stats.");
			return (true);
		}
		if(!Iter_Contains(P_PACKAGES[playerid], package_id) || PlayerPackage[playerid][packExists][package_id] == 0)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Unijeli ste pogresan package_id, na /package stats provijeravate vase pakete.");
		if(PlayerUnpacking[playerid] == true)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Vec raspakujete paket.");
		// take_position
		GetPlayerPos(playerid,x,y,z);
		get_PlayerPos[playerid][0] = x,
		get_PlayerPos[playerid][1] = y,
		get_PlayerPos[playerid][2] = z;
		PlayerUnpacking[playerid] = true;

		// take_seconds
		switch(PlayerPackage[playerid][p_weapon][package_id]) {
			case 24,22,23: seconds = 3; // DEAGLE, SILENCED, COLT
			case 25,28,29,32: seconds = 5; // SHOTGUN, MP5, TEC9, UZI
			case 30,31,33,34: seconds = 8; // AK47, M4, RIFLE, SNIPER
		}

		// message
		if(PlayerPackage[playerid][p_weapon][package_id] != PACKAGE_PANCIR)
			format(buffer, sizeof(buffer), "> %s pocinje da sklapa oruzje.", GetName(playerid)), SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "[PACKAGE]: Poceli ste da raspakujete paket oruzja, ne pomerajte se %d sekundi.", seconds);

		SendClientMessage(playerid, COLOR_PURPLE, buffer);
		SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 15, 10000);
		
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukolike se pomjerite funkcija koju obavljate ce se prekinuti!");

		// unpack_package
  		ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		timer_unpacking[playerid] = SetTimerEx("UnpackPackage", seconds*1000, (false), "ii", playerid, package_id);
	}

	if(strcmp(action, "checkorder", true) == 0) {
		new buffer[284],
			package_id = get_PackageID[playerid];
		if(PackageOrdered[playerid] == false || package_id == INVALID_PACKAGE_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ ! ] Nemate narucenu posiljku, prvo je morate naruciti da bi ju provijerili.");

		GetWeaponName(PackageData[package_id][PackageWeapon], weapon_name, 16);
		if(PackageData[package_id][PackageWeapon] != PACKAGE_PANCIR) {
			format(buffer, sizeof(buffer), "{3C95C2}[ WAREHOUSE - WEAPON PACKAGE ]\n\nWeapon: %s.\nPackage Ammo: %d (ammo).\nPackage Price: %s.\nFaction: %s.",
				weapon_name,
				PackageData[package_id][PackageAmount],
				FormatNumber(get_PackagePrice[playerid]),
				ReturnPlayerFactionName(playerid)
			);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}* Package - Informations", buffer, "(x)", "");
		}
	}

	if(strcmp(action, "checkplayer", true) == 0) {
		new targetid;
		if(PlayerInfo[playerid][pAdmin] < 3)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 3+).");

		if(sscanf(params, "s[25]i", action, targetid)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package checkplayer [targetid].");
			return (true);
		}
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] |________ [ %s - Weapon Packages ] ________|", GetName(targetid));
		foreach(new i : P_PACKAGES[targetid]) {
			if(PlayerPackage[targetid][p_weapon][i] != 0) {
				GetWeaponName(PlayerPackage[targetid][p_weapon][i], weapon_name, 16);
				if(PlayerPackage[targetid][p_weapon][i] != PACKAGE_PANCIR)
					va_SendClientMessage(playerid, COLOR_WHITE, "(%d). %s (%d/%d).", i, weapon_name, PlayerPackage[targetid][p_amount][i], MAX_PACKAGE_AMOUNT);
			}
		}
	}

	if(strcmp(action, "resetpackages", true) == 0) {
		new targetid;
		if(PlayerInfo[playerid][pAdmin] < 3)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

		if(sscanf(params, "s[25]i", action, targetid)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /package resetpackages [targetid].");
			return (true);
		}
		foreach(new i : P_PACKAGES[targetid])
		{
			if(PlayerPackage[targetid][p_weapon][i] != 0)
				DeletePlayerPackage(targetid, i);
		}
		Iter_Clear(P_PACKAGES[targetid]);
		SendFormatMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste igracu %s obrisali sve weapon pakete.", GetName(targetid));
		va_SendClientMessage(targetid, COLOR_RED, "[ ! ] Administrator %s vam je obrisao sve weapon pakete.", GetName(playerid));
	}

	if(strcmp(action, "stats", true) == 0) {
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] |________ [ %s - Weapon Packages ] ________|", GetName(playerid));
		foreach(new i : P_PACKAGES[playerid]) {
			if(PlayerPackage[playerid][p_weapon][i] != 0) {
				GetWeaponName(PlayerPackage[playerid][p_weapon][i], weapon_name, 16);
				if(PlayerPackage[playerid][p_weapon][i] != PACKAGE_PANCIR)
					va_SendClientMessage(playerid, COLOR_WHITE, "(%d). %s (%d/%d).", i, weapon_name, PlayerPackage[playerid][p_amount][i], MAX_PACKAGE_AMOUNT);
			}
		}
	}
	return (true);
}