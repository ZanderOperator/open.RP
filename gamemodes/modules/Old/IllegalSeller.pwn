// Weapons ordering illegal v0.1 by Woo
// ######################################

#include <YSI_Coding\y_hooks>

#define MAX_ILLEGAL_TOOLS		(12) 
#define MAX_PLAYER_TOOLS		(3) 
#define DEALER_ID				(12)
// ------------ ENUMS -------------------
new 
	PlayerToolPick[ MAX_PLAYERS ];

enum E_ILLEGAL_TOOLS_DATA {
	itdSQLID,
	itdPlayerSQLID,
	itdTime,
	itdWeaponId,
}
new PlayerITInfo[ MAX_ILLEGAL_TOOLS ][ E_ILLEGAL_TOOLS_DATA ],
	Iterator:Itools<MAX_WORDER_CRATES>;
	
// Lokacije

enum E_ILLEGAL_TOOLS
{
	itWeaponId,
	itName,
	itPrice
}
new
	IllegalTools[7][ E_ILLEGAL_TOOLS ] = {	
		{ 1, 	"Bokser", 				20},
		{ 4, 	"Noz", 					20},
		{ 5, 	"Palica", 				20},
		{ 18, 	"Molotovljev koktel", 	20},
		{ 42, 	"Protupozarni aparat", 	20}
	};


// ------------- FUNCTIONS -------------

forward OnIllegalWeaponsLoaded();
public OnIllegalWeaponsLoaded()
{
	new
		rows = cache_num_rows();
	if(rows) 
	{
	    for(new slotid = 0; slotid < rows; slotid++) 
		{
			cache_get_value_name_int(slotid, "id", PlayerITInfo[ slotid ][ itdSQLID ]);
			cache_get_value_name_int(slotid, "playerid", PlayerITInfo[ slotid ][ itdPlayerSQLID ]);
			cache_get_value_name_int(slotid, "time", PlayerITInfo[ slotid ][ itdTime ]);
			cache_get_value_name_int(slotid, "weaponid", PlayerITInfo[ slotid ][ itdWeaponId ]);
			Iter_Add(ITools, slotid);
		}
		printf("MySQL Report: Ilegal tools loaded (%d)!", rows);
	} else print("MySQL Report: No Ilegal tools data exist to load.");
	return 1;
}

static stock CheckPlayerIllegalTools(playerid)
{
	new sum = 0;
    foreach (new i : Itools) {
		if( PlayerITInfo[i][itdPlayerSQLID] == PlayerInfo[playerid][pSQLID] ) {
			sum += 1;
		}
	}
	return sum;
}

static stock ResetIToolsVars(playerid)
{
	PlayerToolPick[ playerid ] = -1;
	return 1;
}

static stock CheckPlayerITools(playerid)
{
	new date[6],
		location[32];
		
    foreach (new i : ITools) {
		if( PlayerITInfo[i][itdPlayerSQLID] == PlayerInfo[playerid][pSQLID] )
		{
			va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "ID [%d] %s / %s ( %d ) / ETA: %02d/%02d/%02d %02d:%02d",
				i,
				IllegalTools[PlayerITInfo[i][itdSQLID]],
				PlayerITInfo[i][cWeaponAmmo],
				date[2],
				date[1],
				date[0],
				date[3],
				date[4]
			);
		}
	}
	return 1;
}

stock LoadITools() // Loadanje cijele baze
{
	mysql_tquery(g_SQL, 
		"SELECT * FROM weapon_order_crates", 
		"OnOrderedWeaponsLoaded");
	return 1;
}

stock static UpdateWOCrate(slotid) // Updateanje package crate
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, sizeof(tmpQuery), "UPDATE weapon_order_crates SET playerid = '%d', location = '%d', time = '%d', weaponid = '%d', ammo = '%d' WHERE id = '%d'",
		PlayerITInfo[ slotid ][ itdPlayerSQLID ],
		PlayerITInfo[ slotid ][ cLocation ],
		PlayerITInfo[ slotid ][ itdTime ],
		PlayerITInfo[ slotid ][ itdSQLID ],
		PlayerITInfo[ slotid ][ cWeaponAmmo ],
		PlayerITInfo[ slotid ][ cSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery);
	return 1;
}

Public:OnWOCrateInsert(slot)
{
	PlayerITInfo[ slot ][ cSQLID ] = cache_insert_id();
	return 1;
}

stock static InsertWOCrate(slotid) // Dodavanje package crate
{
	new insertQuery[ 256 ];
	format(insertQuery, sizeof(insertQuery), "INSERT INTO weapon_order_crates (playerid, location, time, weaponid, ammo) VALUES ('%d', '%d', '%d', '%d', '%d')",
		PlayerITInfo[ slotid ][ itdPlayerSQLID ],
		PlayerITInfo[ slotid ][ cLocation ],
		PlayerITInfo[ slotid ][ itdTime ],
		PlayerITInfo[ slotid ][ itdSQLID ],
		PlayerITInfo[ slotid ][ cWeaponAmmo ]
	);
	mysql_tquery( g_SQL, insertQuery, "OnWOCrateInsert", "i", slotid);
	return 1;
}

stock static DeleteWOCrate(slotid) // Delete package crate
{
	new destroyQuery[ 64];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM weapon_order_crates WHERE id = '%d' LIMIT 1", PlayerITInfo[ slotid ][ cSQLID ]);
	mysql_tquery(g_SQL, destroyQuery);
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
			PlayerToolPick[ playerid ] = listitem;
			ShowPlayerDialog(playerid, DIALOG_WORDER_BULLETS, DIALOG_STYLE_INPUT, "Weapon order ammo", "Koliko metaka da posaljem?", "Order", "Cancel");
			return 1;
		}
		case DIALOG_WORDER_BULLETS: //Igrac bira kolicinu metaka
		{
			if( !response ) return SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Nista onda, kad se odlucis, javi! **Hangup**");
			new	
				ammo = strval(inputtext),
				safe_ammo = floatround(floatabs(ammo)),
				gunslot = PlayerToolPick[ playerid ],
				money = IllegalTools[ gunslot ][ wBulletPrice ] * safe_ammo,
				dialogString[256],
				location[32];
				
			PlayerAmmoPick[playerid] = safe_ammo;
		
			switch( IllegalTools[ gunslot ][ wLocation ])
			{
				case 0: format(location, sizeof(location), "L.S Docks Container Terminal");
				case 1: format(location, sizeof(location), "San Fierro Port of Discharge");
				case 2: format(location, sizeof(location), "Las Venturas Cargo Warehouse");
			}
			SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Evo ti informacije, potvrdi da saljem ili ne?");
			format(dialogString, sizeof(dialogString), "{f4bc42}Oruzje: %s\nMunicija: %d\nLokacija: %s\nCijena: %d $",
				IllegalTools[ gunslot ][ wName ],
				safe_ammo,
				location,
				money
			);
			ShowPlayerDialog(playerid, DIALOG_WORDER_FINISH, DIALOG_STYLE_MSGBOX, "Weapon order package information", dialogString, "Yes", "No");
			return 1;
		}
		case DIALOG_WORDER_FINISH: //Igrac bira kolicinu metaka
		{
			if( !response ) return SendClientMessage( playerid, COLOR_YELLOW, "**Nepoznat** (govornica): Nemoj mi trositi vrijeme! Kada se odlucis, javi se!");
			new	
				safe_ammo = PlayerAmmoPick[playerid],
				index = PlayerToolPick[ playerid ],
				money = IllegalTools[ index ][ wBulletPrice ] * (safe_ammo),
				wotime = gettimestamp() + (IllegalTools[ index ][ wWaitTime ] * 60); // Minute * 60

			if( safe_ammo == 0 || safe_ammo > MAX_WORDER_BULLETS) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalni broj metaka za jednu narudzbu je %d!", MAX_WORDER_BULLETS); 
			if( AC_GetPlayerMoney(playerid) < money ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");
			
			new freeiter = Iter_Free(ITools);
			PlayerITInfo[ freeiter ][ itdPlayerSQLID ] = PlayerInfo[playerid][pSQLID];
			PlayerITInfo[ freeiter ][ cLocation ] = IllegalTools[index][wLocation];
			PlayerITInfo[ freeiter ][ itdTime ] = wotime;
			PlayerITInfo[ freeiter ][ itdSQLID ] = IllegalTools[index][wModelId];
			PlayerITInfo[ freeiter ][ cWeaponAmmo ] = safe_ammo;
			Iter_Add(ITools, freeiter);
			InsertWOCrate(freeiter); // dodavanje u bazu
			
			PlayerToIllegalBudgetMoney(playerid, money); // Ilegalni Budget dobiva novce
			ResetIToolsVars(playerid);
				
			#if defined MODULE_LOGS
			Log_Write("/logfiles/weapon_orders.txt", "(%s) %s ordered %s (%d ammo) for %d$",
				ReturnDate(),
				GetName(playerid),
				IllegalTools[ index ][ wName ],
				safe_ammo,
				money
			);
			#endif


			SendClientMessage(playerid, COLOR_YELLOW, "** Nepoznat ** (govornica): Paket poslan. ** LINIJA PREKINUTA **!");
			return 1;
		}
	}
	return 0;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerToolPick[ playerid ] = -1;
	PlayerAmmoPick[ playerid ] = -1;
	return 1;
}

/// -------------- CMDS ----------------

CMD:weapons(playerid, params[])
{
	new
		pick[ 12 ];
	if( PlayerInfo[ playerid ][ pJob ] != DEALER_ID || !PlayerInfo[playerid][pMember] ) return SendClientMessage( playerid, COLOR_RED, "Niste Gun Dealer ili u skriptanoj organizaciji!");
	if( sscanf( params, "s[12] ", pick ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /weapons [odabir]");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: order - view - assembly");
		return 1;
	}
	if( !strcmp( pick, "order") )
	{
		if(!IsAtGovornica(playerid)) return SendClientMessage(playerid,COLOR_RED, "Narucivati mozete samo sa govornice!");
		if( Iter_Count(ITools) == ( MAX_WORDER_CRATES - 1) ) return SendClientMessage( playerid, COLOR_RED, "Sva mjesta su vec pretovarena, pokusajte kasnije!");
		if(CheckPlayerIllegalTools(playerid) >= 3) return SendClientMessage(playerid,COLOR_RED, "Imate maksimalan broj narudzbi!!"); 
		
		new tmpString[256];
		format(tmpString, 256, "Oruzje\tCijena metka\tETA min\n");
		for( new i = 0; i < 10; i++ ) {
			format( tmpString, 256, "%s{f4bc42}%s\t%d$\t%d\n", tmpString, IllegalTools[i][wName], IllegalTools[i][wBulletPrice], IllegalTools[i][wWaitTime]);
		}
		ShowPlayerDialog(playerid, DIALOG_WORDER_WEAPONS, DIALOG_STYLE_TABLIST_HEADERS, "Weapon order packages", tmpString, "OK", "Cancel");
	}
	else if( !strcmp( pick, "view") )
	{
		CheckPlayerITools(playerid);
	}
	else if( !strcmp( pick, "assembly") )
	{
		new slotid,
			ammo;
		if (sscanf(params, "s[12]ii", pick, slotid, ammo))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weapons assembly [ID] [ammo]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Koristite /weapons view da vidite ID kutije!");
			return 1;
		}
		new cratelocation = PlayerITInfo[slotid][cLocation];
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, WoDeliver[cratelocation][woPosX], WoDeliver[cratelocation][woPosY], WoDeliver[cratelocation][woPosZ])) 
			return SendClientMessage( playerid, COLOR_RED, "Niste u blizini narucenog paketa."); 
		if(!AtLeastTwoMembers(playerid, 50.0, WoDeliver[cratelocation][woPosX], WoDeliver[cratelocation][woPosY], WoDeliver[cratelocation][woPosZ]))
			return SendClientMessage( playerid, COLOR_RED, "Ne mozete sami u akciju preuzimanja paketa."); 
		if (PlayerITInfo[slotid][itdPlayerSQLID] != PlayerInfo[playerid][pSQLID]) return SendClientMessage( playerid, COLOR_RED, "To nije vas paket.");
		if (PlayerITInfo[slotid][itdTime] > gettimestamp()) return SendClientMessage( playerid, COLOR_RED, "Paket jos nije stigao.");
		if (ammo <= 0 || ammo > PlayerITInfo[slotid][cWeaponAmmo]) return va_SendClientMessage( playerid, COLOR_RED, "U kutiji nema toliko metaka! min. 1 -  max. %d", PlayerITInfo[slotid][cWeaponAmmo]);
		
		if (! CheckPlayerWeapons(playerid, gun) ) return 1;
		PlayerITInfo[slotid][cWeaponAmmo] -= ammo;
		AC_GivePlayerWeapon(playerid, PlayerITInfo[slotid][itdSQLID], ammo);
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Uzeo si %s sa %d metaka iz paketa, ostalo je jos %d metaka u paketu. **",
			WeapNames[PlayerITInfo[slotid][itdSQLID]],
			ammo,
			PlayerITInfo[slotid][cWeaponAmmo]
		);
		
		UpdateWOCrate(slotid);
		// Ako je 0 metaka, brise se paket
		if(PlayerITInfo[slotid][cWeaponAmmo] == 0)
		{
			va_SendClientMessage(playerid, COLOR_RED, "** Ispraznio si paket ID %d.", slotid);
			DeleteWOCrate(slotid);
			PlayerITInfo[ slotid ][ cSQLID ] = 0;
			PlayerITInfo[ slotid ][ itdPlayerSQLID ] = EOS;
			PlayerITInfo[ slotid ][ cLocation ] = 0;
			PlayerITInfo[ slotid ][ itdTime ] = 0;
			PlayerITInfo[ slotid ][ itdSQLID ] = 0;
			PlayerITInfo[ slotid ][ cWeaponAmmo ] =0;
			Iter_Remove(ITools, slotid);
		}
	}
	return 1;
}
CMD:worders(playerid, params[])
{
	new pick[ 12 ];
	if( PlayerInfo[ playerid ][ pAdmin ] < 4 ) return SendClientMessage( playerid, COLOR_RED, "Nemate ovlasti!");
	if( sscanf( params, "s[12] ", pick ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /weapons [odabir]");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: list - delete");
		return 1;
	}
	if( !strcmp( pick, "list") )
	{
		new date[12], time[12];
		SendClientMessage( playerid, COLOR_GREEN, "---------------Popis narucenih paketa oruzja ---------------");
		foreach (new i : ITools) 
		{
			TimeFormat(Timestamp:PlayerITInfo[i][itdTime], HUMAN_DATE, date);
			TimeFormat(Timestamp:PlayerITInfo[i][itdTime], ISO6801_TIME, time);

			va_SendClientMessage(playerid, COLOR_WHITE, "ID[%d] SQLID igraca: %d / Oruzje: %s ( %d ) / ETA: %s %s",
				i,
				PlayerITInfo[ i ][ itdPlayerSQLID ],
				WeapNames[PlayerITInfo[i][itdSQLID]],
				PlayerITInfo[i][cWeaponAmmo],
				date,
				time
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
		if (1 > slotid > 10) return va_SendClientMessage( playerid, COLOR_RED, "ID je od 0 - 10", PlayerITInfo[slotid][cWeaponAmmo]);
		new string [128];
		format(string, sizeof(string), "[!] Admin %s obrisao weapon order paket pod ID %d", GetName(playerid,false), slotid);
		SendAdminMessage(COLOR_RED, string);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/weapon_orders.txt", string); 
		#endif

		DeleteWOCrate(slotid);
		PlayerITInfo[ slotid ][ cSQLID ] = 0;
		PlayerITInfo[ slotid ][ itdPlayerSQLID ] = EOS;
		PlayerITInfo[ slotid ][ cLocation ] = 0;
		PlayerITInfo[ slotid ][ itdTime ] = 0;
		PlayerITInfo[ slotid ][ itdSQLID ] = 0;
		PlayerITInfo[ slotid ][ cWeaponAmmo ] =0;
		Iter_Remove(ITools, slotid);
		
	}
	return 1;
}
