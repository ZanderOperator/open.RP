// Ammunation v1.2 by Woo
// ##################################################
// koristi pAmmuTime, MySQL bazu "ammunation_weapons"

#include <YSI\y_hooks>

#define MAX_AMMU_SLOTS				(44)

// ------------ ENUMS -------------------


enum E_AMMUNATION_DATA {
	aiSQLID,
	aiName[ 20 ],
	aiWeapon,
	aiPrice,
	aiLicense,
	aiMaxBullets
}
new AmmuInfo[ MAX_AMMU_SLOTS ][ E_AMMUNATION_DATA ],
	Iterator:AMMU<MAX_AMMU_SLOTS>;

new PlayerWeapPick[ MAX_PLAYERS ];

// ------------ FORWARDS -------------------

Function: OnAmmuWeaponInsert(slot)
{
	AmmuInfo[ slot ][ aiSQLID ] = cache_insert_id();
	return 1;
}

forward OnAmmuWeaponsLoaded();
public OnAmmuWeaponsLoaded()
{
	new
		rows = cache_num_rows(),
		tmp[ 64 ];
	if(rows) {
	    for(new slotid = 0; slotid < rows; slotid++) {
			cache_get_value_name_int(slotid, "id", AmmuInfo[ slotid ][ aiSQLID ]);
			cache_get_value_name(slotid, "name", tmp);
			format(AmmuInfo[ slotid ][ aiName ], 64, tmp);
			cache_get_value_name_int(slotid, "weapon", AmmuInfo[ slotid ][ aiWeapon ]);
			cache_get_value_name_int(slotid, "price", AmmuInfo[ slotid ][ aiPrice ]);
			cache_get_value_name_int(slotid, "license", AmmuInfo[ slotid ][ aiLicense ]);
			cache_get_value_name_int(slotid, "maxbullets", AmmuInfo[ slotid ][ aiMaxBullets ]);
			Iter_Add(AMMU, slotid);
			
		}
		printf("MySQL Report: Ammunation weapons loaded (%d)!", rows);
	} else print("MySQL Report: No Ammunation weapons data exist to load.");
	return 1;
}

// ------------ STOCKS -------------------

stock LoadAmmuData() // Loadanje cijele baze
{
	mysql_tquery(g_SQL, "SELECT * FROM ammunation_weapons", "OnAmmuWeaponsLoaded");
	return 1;
}

stock LogAmmu(string[]) // Log
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/ammunation_buy.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock static UpdateAmmuWeapon(slotid) // Updateanje ourzja u listi
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, sizeof(tmpQuery), "UPDATE ammunation_weapons SET name = '%q', weapon = '%d', price = '%d', license = '%d', maxbullets = '%d' WHERE id = '%d'",
		AmmuInfo[ slotid ][ aiName ],
		AmmuInfo[ slotid ][ aiWeapon ],
		AmmuInfo[ slotid ][ aiPrice ],
		AmmuInfo[ slotid ][ aiLicense ],
		AmmuInfo[ slotid ][ aiMaxBullets ],
		AmmuInfo[ slotid ][ aiSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

stock static DeleteAmmuWeapon(slotid) // Delete oruzja iz liste
{
	new destroyQuery[ 128 ];
	
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM ammunation_weapons WHERE `id` = '%d' LIMIT 1", AmmuInfo[ slotid ][ aiSQLID ]);
	mysql_tquery(g_SQL, destroyQuery, "");
	return 1;
}

stock static InsertAmmuWeapon(slotid) // Dodavanje novog oruzja
{
	new insertQuery[ 256 ];
	format(insertQuery, sizeof(insertQuery), "INSERT INTO ammunation_weapons (name, weapon, price, license, maxbullets) VALUES ('%q', '%d', '%d', '%d', '%d')",
		AmmuInfo[ slotid ][ aiName ],
		AmmuInfo[ slotid ][ aiWeapon ],
		AmmuInfo[ slotid ][ aiPrice ],
		AmmuInfo[ slotid ][ aiLicense ],
		AmmuInfo[ slotid ][ aiMaxBullets ]
	);
	mysql_tquery( g_SQL, insertQuery, "OnAmmuWeaponInsert", "i", slotid);
	return 1;
}

stock static PlayerAmmunationBuyTime(playerid, days)
{
	new	ammutime, date[ 6 ];
	ammutime = days * 79200; // days su dani zadani, a 86400 su sekunde po danu, za promjenu dana zabrane promjenti samo brojku 7 ? // 79200 -2 sata jer gospodinu iz solina triba udovoljit degen
	ammutime += gettimestamp(); // dodaje se trenutno vrijeme
	PlayerInfo[ playerid ][ pAmmuTime] = ammutime; // igracu se u varijablu dodaje vrijeme
	stamp2datetime(ammutime, date[0], date[1] ,date[2], date[3], date[4], date[5], 1); // formatiranje vremena iz unixa u normalno
	
	va_SendClientMessage(playerid, COLOR_RED, "[AMMUNATION INFO]: Sljedeci put mozete kupovati nakon %d dana (%02d/%02d/%02d %02d:%02d:%02d)",
		days,
		date[2],
		date[1],
		date[0],
		date[3],
		date[4],
		date[5]
	);
}

// ------------------- HOOKS ----------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_AMMUNATION_MENU: // Igrac bira oruzje
		{
			if( !response ) return 1;
			PlayerWeapPick[ playerid ] = listitem;
			ShowPlayerDialog(playerid, DIALOG_AMMUNATION_BUY, DIALOG_STYLE_INPUT, "MUNICIJA", "Koliko metaka?", "Kupi", "Cancel");

			return 1;
		}
		case DIALOG_AMMUNATION_BUY: //Igrac bira metke
		{
			if( !response ) return 1;
			new	
				bullets = strval(inputtext),
				safe_bullets = floatround(floatabs(bullets)),
				index = PlayerWeapPick[ playerid ],
				money = AmmuInfo[ index ][ aiPrice ] * (safe_bullets);
			
			if( safe_bullets == 0 || safe_bullets > AmmuInfo[ index ][ aiMaxBullets ]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalni broj metaka za %s je %d!", AmmuInfo[ index ][ aiName ], AmmuInfo[ index ][ aiMaxBullets ]); 
			if( AC_GetPlayerMoney(playerid) < money ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");
			if( PlayerInfo[playerid][pGunLic] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate lincesu za oruzje!");
			
			if (! CheckPlayerWeapons(playerid, AmmuInfo[index][aiWeapon]) ) return 1;
			AC_GivePlayerWeapon(playerid, AmmuInfo[ index ][ aiWeapon ], safe_bullets);
			PlayerToBudgetMoney(playerid, money); // Budget dobiva novce
			PlayerWeapPick[ playerid ] = -1;
			switch(PlayerInfo[playerid][pDonateRank])
			{
				case 0: PlayerAmmunationBuyTime(playerid, 7); // Postavljanje igracu zabranu na 7 dana kupovanja
				case 1: PlayerAmmunationBuyTime(playerid, 5); // Postavljanje igracu zabranu na 7 dana kupovanja
				case 2: PlayerAmmunationBuyTime(playerid, 3); // Postavljanje igracu zabranu na 3 dana kupovanja
				case 3,4: PlayerAmmunationBuyTime(playerid, 1); // Postavljanje igracu zabranu na 1 dan kupovanja
			}
				
			// ---------- spremanje u ammunation log ----------
			new log[ 128 ]; // -----
			format( log, 128, "%s je kupio %s sa %d metaka za %d$.",
				GetName(playerid),
				AmmuInfo[ index ][ aiName ],
				safe_bullets,
				money
			);
			LogAmmu(log); 
			// -------------------------------------
		
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupili ste %s sa %d metaka za %d$!", 
				AmmuInfo[ index ][ aiName ],
				safe_bullets,
				money
			);
			return 1;
		}
	}
	return 0;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerWeapPick[ playerid ] = -1;
	return 1;
}

// -------------------------------- CMDS -----------------------------------------

CMD:buyweapon(playerid, params[])
{
	//if( !BiznisProducts[ Bit16_Get( gr_PlayerInBiznis, playerid ) ][ bpAmount ][ 0 ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete ovdje kupovati jer biznis nema produkta!");
	if ( !IsPlayerInRangeOfPoint(playerid, 4.0, 295.0016,-38.3526,1001.5156)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne nalazite se na mjestu za kupovinu oruzja.");
	
	// --- Provjera je li igracu isteklo vrijeme za kupnju  ------------
	if( PlayerInfo[ playerid ][ pAmmuTime ] < gettimestamp() ) {
		new
			tmpString[ 256 ];
		format(tmpString, 256, "Oruzje\tCijena\tMaxAmmo\n");
		foreach(new i : AMMU) {
			format( tmpString, 256, "%s{EBD7A9}%s\t%d$\t%d\n", tmpString, AmmuInfo[ i ][ aiName ], AmmuInfo[ i ][ aiPrice ], AmmuInfo[ i ][ aiMaxBullets ] );
		}
		ShowPlayerDialog(playerid, DIALOG_AMMUNATION_MENU, DIALOG_STYLE_TABLIST_HEADERS, "AMMUNATION", tmpString, "Odaberi", "Odustani");
	}
	else {
		new datum = PlayerInfo[ playerid ][ pAmmuTime ],
			date[ 6 ];
		stamp2datetime(datum, date[0], date[1] ,date[2], date[3], date[4], date[5], 1);
		va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Nije vam dozvoljena kupnja do %d.%d.%d. - %d:%d",
			date[2],
			date[1],
			date[0],
			date[3],
			date[4]
		);
	}
	return 1;
}

CMD:ammunation(playerid, params[])
{
	if( PlayerInfo[playerid][pAdmin] < 1338 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste ovlasteni!");
	new pick[ 8 ], id, weapon, price, license, maxbullets, name[ 32 ], freeslot;
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage( playerid, -1, "KORISTENJE /ammunation [list/add/edit/delete/rpt (resetplayertime)]");
	if( !strcmp(pick, "add", true) ) {
		if( sscanf(params, "s[8]iiiis[32]", pick, weapon, price, license, maxbullets, name ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ammu add [weapon_id] [cijena po metku] [licenca (1/2)] [max bullets] [ime oruzja]");
		if( 1 > weapon > 44 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Krivi weapon ID!");
		if( 1 > price > 9999 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Cijena po metku moze biti od 1 - 9999");
		if( 1 > license > 2 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Licenca moze biti 1 (CCW) ili 2 (OCW)!");
		if( 1 > maxbullets > 9999 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalno metaka po kupovini u 7 dana je 1 - 9999");
		
		freeslot = Iter_Free(AMMU);
		
		format(AmmuInfo[ freeslot ][ aiName ], 32, name);
		AmmuInfo[ freeslot ][ aiWeapon ] = weapon;
		AmmuInfo[ freeslot ][ aiPrice ] = price;
		AmmuInfo[ freeslot ][ aiLicense ] = license;
		AmmuInfo[ freeslot ][ aiMaxBullets ] = maxbullets;
		Iter_Add(AMMU, freeslot);
		InsertAmmuWeapon(freeslot);
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] (ADD) SlotID [%d] - %s[%d] | %d$ | license: %d | maxbullets: %d", 
			freeslot,
			name,
			weapon,
			price,
			license,
			maxbullets
		);
	}
	else if( !strcmp(pick, "delete", true) ) {
		new slotid;
		if( sscanf(params, "s[8]i", pick, slotid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ammunation delete [slotid]");
		if( slotid < 0 && slotid > MAX_AMMU_SLOTS ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID (0-%d).", MAX_AMMU_SLOTS-1 );
	
		AmmuInfo[ slotid ][ aiSQLID ] = 0;
        AmmuInfo[ slotid ][ aiName ] = EOS;
        AmmuInfo[ slotid ][ aiWeapon ] = 0;
        AmmuInfo[ slotid ][ aiPrice ] = 0;
        AmmuInfo[ slotid ][ aiLicense ] = 0;
        AmmuInfo[ slotid ][ aiMaxBullets ] =0;
		Iter_Remove(AMMU, slotid);
		DeleteAmmuWeapon(slotid);
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] (DELETE) Obrisali ste ID[%d] %s!", slotid, name);
	}
	else if( !strcmp(pick, "edit", true) ) {
		if( sscanf(params, "s[8]iiiiis[32]", pick, id, weapon, price, license, maxbullets, name ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ammunation edit [slotID] [weapon_id] [cijena po metku] [licenca (1/2)] [max bullets] [ime oruzja]");
		if( 1 > weapon > 44 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Krivi weapon ID!");
		if( 1 > price > 9999 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Cijena po metku moze biti od 1 - 9999");
		if( 1 > license > 2 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Licenca moze biti 1 (CCW) ili 2 (OCW)!");
		if( 1 > maxbullets > 9999 )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalno metaka po kupovini u 7 dana je 1 - 9999");
		if( !Iter_Contains(AMMU, id) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Taj slot je prazan!");
		
		format(AmmuInfo[ id ][ aiName ], 32, name);
		AmmuInfo[ id ][ aiWeapon ] = weapon;
		AmmuInfo[ id ][ aiPrice ] = price;
		AmmuInfo[ id ][ aiLicense ] = license;
		AmmuInfo[ id ][ aiMaxBullets ] = maxbullets;
		UpdateAmmuWeapon(id);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] (EDIT) SlotID [%d] - %s[%d] | %d$ | license: %d | maxbullets: %d", 
			id,
			name,
			weapon,
			price,
			license,
			maxbullets
		);
	}
	else if( !strcmp(pick, "list", true) ) {
		if( sscanf(params, "s[8]", pick ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ammunation list");
		if( Iter_Count(AMMU) == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Baza je prazna!");
		SendClientMessage( playerid, COLOR_SAMP_BLUE, "--------- AMMUNATION LISTA ORUZJA --------");
		foreach(new i : AMMU) {
			va_SendClientMessage(playerid, -1, "SlotID: [%d]: %s[%d] Cijena: %d  Licenca: %d  MaxBullets: %d",
				i,
				AmmuInfo[ i ][ aiName ],
				AmmuInfo[ i ][ aiWeapon ],
				AmmuInfo[ i ][ aiPrice ],
				AmmuInfo[ i ][ aiLicense ],
				AmmuInfo[ i ][ aiMaxBullets ]
			);
		}
	}
	else if( !strcmp(pick, "rpt", true) ) {
		new giveplayerid;
		if( sscanf(params, "s[8]u", pick, giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ammunation rpt [ID/PlayerName]");
		PlayerInfo[giveplayerid][pAmmuTime] = 0;
		new rQuery[ 128 ];
		format( rQuery, sizeof(rQuery), "UPDATE `accounts` SET `ammutime` = '0' WHERE `sqlid` = '%d'", PlayerInfo[giveplayerid][pSQLID]);
		mysql_tquery(g_SQL, rQuery, "");
		
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Admin %s ti je resetirao vrijeme kupovine oruzja u Ammunationu!", GetName(playerid));
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Resetirao si igracu %s vrijeme kupovine oruzja u Ammunationu!", GetName(giveplayerid));
		return 1;
	}
	else {
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznat izbor!");
	}
	return 1;
}

CMD:buyarmour(playerid, params[])
{
    if ( !IsPlayerInRangeOfPoint(playerid, 4.0, 295.0016,-38.3526,1001.5156)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne nalazite se na mjestu za kupovinu armoura.");
    if( PlayerInfo[playerid][pGunLic] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate lincesu za oruzje!");
	if( AC_GetPlayerMoney(playerid) < 6000 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca!");

	PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	SetPlayerArmour(playerid, 50);
	PlayerInfo[playerid][pCrashArmour] 	= 50;
	PlayerToBudgetMoney(playerid, 6000);
	
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Kupili ste pancirku!");
	return 1;
}

//Player online
CMD:issueweaplic(playerid, params[])
{
	new giveplayerid;
    if (sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_RED, "USAGE: /issueweaplicense [playerid/name]");
		return 1;
	}
	if(PlayerInfo[giveplayerid][pGunLic] == 1) return SendClientMessage(playerid, COLOR_RED, "ERROR: Osoba vec ima dozvolu za oruzje!");
	if((IsACop(playerid) && PlayerInfo[playerid][pRank] > 5) || PlayerInfo[playerid][pLeader] == 1)
	{
	    PlayerInfo[giveplayerid][pGunLic] = 1;
        PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
    	new
			tmpString[ 120 ];
		format(tmpString, sizeof(tmpString), "*[HQ] %s %s je izdao weapon licensu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
    }
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	return 1;
}

CMD:revokeweaplic(playerid, params[])
{
    new giveplayerid;
    if (sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_RED, "USAGE: /revokeweaplic [playerid/name]");
		return 1;
	}
	if(PlayerInfo[giveplayerid][pGunLic] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR: Osoba nema dozvolu za oruzje!");
	if(IsACop(playerid))
	{
	    PlayerInfo[giveplayerid][pGunLic] = 0;
        PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
    	new
			tmpString[ 120 ];
		format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo weapon licensu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
    }
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	return 1;
}
