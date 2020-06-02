#include <YSI\y_hooks>

#define MAX_APB_SLOTS 		(21)

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

enum E_APB_DATA
{
	aSQLID,
	aName[MAX_PLAYER_NAME],
	aDiscription[64],
	aType,
	aPDName[MAX_PLAYER_NAME]
}
stock
	APBInfo[ MAX_APB_SLOTS ][ E_APB_DATA ],
	Iterator:APB<MAX_APB_SLOTS>;

static stock
	Bit8:gr_APBSlot<MAX_PLAYERS> = {Bit8:0,...};


/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

stock LoadAPBData()
{
	mysql_tquery(g_SQL, "SELECT * FROM apb WHERE 1", "OnAPBLoaded");
	return 1;
}

forward OnAPBLoaded();
public OnAPBLoaded()
{
	new
		rows = cache_num_rows(),
		tmp[ 64 ];
	if(rows) {
	    for(new slotid = 0; slotid < rows; slotid++) {
			cache_get_value_name_int(slotid, 	"id"		, APBInfo[ slotid ][ aSQLID ]);
			cache_get_value_name(slotid, 		"suspect"	, tmp);
			format(APBInfo[ slotid ][ aName ], MAX_PLAYER_NAME, tmp);
			cache_get_value_name(slotid, 		"description", tmp);
			format(APBInfo[ slotid ][ aDiscription ], 64, tmp);
			cache_get_value_name_int(slotid, 	"type"		, APBInfo[ slotid ][ aType ]);
			cache_get_value_name(slotid, "pdname", tmp);
			format(APBInfo[ slotid ][ aPDName ], MAX_PLAYER_NAME, tmp);

			if( APBInfo[ slotid ][ aType ] )
				Iter_Add(APB, slotid);
		}
		printf("MySQL Report: APB data loaded (%d)!", rows);
	} else print("MySQL Report: No APB data exist to load.");
	return 1;
}

stock static SaveAPBInfo(slotid)
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, 256, "UPDATE apb SET suspect = '%q', description = '%q', type = '%d', pdname = '%q' WHERE id = '%d'",
		APBInfo[ slotid ][ aName ],
		APBInfo[ slotid ][ aDiscription ],
		APBInfo[ slotid ][ aType ],
		APBInfo[ slotid ][ aPDName ],
		APBInfo[ slotid ][ aSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

stock static RemoveAPBInfo(slotid)
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "UPDATE apb SET suspect = 'None', description = 'None', type = '0', pdname = 'None' WHERE id = '%d' LIMIT 1",
		APBInfo[ slotid ][ aSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

stock static GetAPBType(type)
{
	new
		string[ 26 ];
	switch(type) {
		case 0: format(string, 26, "None");
		case 1: format(string, 26, "Ne naoruzan i nije opasan");
		case 2: format(string, 26, "Srednje opasan");
		case 3: format(string, 26, "Naoruzan i opasan");
	}
	return string;
}

/*
	##     ##  #######   #######  ##    ##
	##     ## ##     ## ##     ## ##   ##
	##     ## ##     ## ##     ## ##  ##
	######### ##     ## ##     ## #####
	##     ## ##     ## ##     ## ##  ##
	##     ## ##     ## ##     ## ##   ##
	##     ##  #######   #######  ##    ##
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_APB_NAME: {
			if( !response ) return 1;
			if( strlen(inputtext) > MAX_PLAYER_NAME ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalan unos naziva je 24!");
			new
				slotid = Bit8_Get( gr_APBSlot, playerid );
			format( APBInfo[ slotid ][ aName ], MAX_PLAYER_NAME, inputtext );
			ShowPlayerDialog( playerid, DIALOG_APB_OPIS, DIALOG_STYLE_INPUT, "UNOS OPISA U APB", "Unesite opis u APB (velicina unosa 1-63!)", "Unesi", "Odustani");
			return 1;
		}
		case DIALOG_APB_OPIS: {
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_APB_NAME, DIALOG_STYLE_INPUT, "UNOS OSUMLJICENOG", "Unesite naziv u APB", "Unesi", "Odustani");
			if( 1 <= strlen(inputtext) <= 63 ) {
				new
					slotid = Bit8_Get( gr_APBSlot, playerid );
				format( APBInfo[ slotid ][ aDiscription ], 	64, inputtext );
				ShowPlayerDialog(playerid, DIALOG_APB_TYPE, DIALOG_STYLE_INPUT, "UNOS VRSTE OPASNOSTI", "1 - Ne naoruzan i nije opasan, 2 - Srednje opasan, 3 - Naoruzan i opasan", "Unesi", "Odustani");
			} else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Maksimalan unos opisa je 63!");
			return 1;
		}
		case DIALOG_APB_CHECK: {
			new apb_id;
		    apb_id = strval(inputtext);

			apb_id--;
			if( !Iter_Contains(APB, apb_id) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trazeni APB slot je prazan!");

			new
				tmpName[ 35 ],
				dialogString[ 182 ];
			format( tmpName, sizeof(tmpName), "APB #%d - %s",
				apb_id,
				APBInfo[ apb_id ][ aName ]
			);
			format(dialogString, 128, "\tIme: "COL_GREEN"%s\n"COL_WHITE"\tOpis: %s\n\tOpasnost: %d\n\tPostavio: %s",
				APBInfo[ apb_id ][ aName ],
				APBInfo[ apb_id ][ aDiscription ],
				APBInfo[ apb_id ][ aType ],
				APBInfo[ apb_id ][ aPDName ]
			);
			ShowPlayerDialog( playerid, 0, DIALOG_STYLE_MSGBOX, tmpName, dialogString, "Uredu", "");
		}
		case DIALOG_APB_TYPE: {
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_APB_OPIS, DIALOG_STYLE_INPUT, "UNOS OPISA U APB", "Unesite opis u APB (velicina unosa 1-63!)", "Unesi", "Odustani");
			new
				input = strval(inputtext);
			if( 1 <= input <= 3 ) {
				new
					slotid = Bit8_Get( gr_APBSlot, playerid );
				APBInfo[ slotid ][ aType ] = input;
				format( APBInfo[ slotid ][ aPDName ], 		MAX_PLAYER_NAME, 	GetName(playerid,false)	);

				SaveAPBInfo(slotid);
				Iter_Add(APB, slotid);

				new
					tmpString[ 51 ];
				format( tmpString, 51, "[ ! ] Uspjesno ste unijeli APB pod slotom %d!",
					slotid
				);
				SendClientMessage( playerid, COLOR_GREEN, tmpString );

			} else ShowPlayerDialog(playerid, DIALOG_APB_TYPE, DIALOG_STYLE_INPUT, "UNOS VRSTE OPASNOSTI", "1 - Ne naoruzan i nije opasan, 2 - Srednje opasan, 3 - Naoruzan i opasan", "Unesi", "Odustani");
			return 1;
		}
	}
	return 0;
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
CMD:apb(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	if( !IsPlayerInAnyVehicle(playerid) ) 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste u vozilu!");

	new
		pick[ 16 ];
	if( sscanf( params, "s[16] ", pick ) ) return SendClientMessage( playerid, -1, "KORISTENJE /apb [add/remove/check/list]");
	if( !strcmp(pick, "add", true) ) {
		if( Iter_Count(APB) == ( MAX_APB_SLOTS - 1) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " APB je pun, zamolite r5+ da obrise stare APBove!");
		Bit8_Set( gr_APBSlot, playerid, Iter_Free(APB) );
		ShowPlayerDialog( playerid, DIALOG_APB_NAME, DIALOG_STYLE_INPUT, "UNOS OSUMLJICENOG", "Unesite naziv u APB", "Unesi", "Odustani");
	}
	else if( !strcmp(pick, "remove", true) ) {
		if( IsACop(playerid) && IsASD(playerid) && PlayerInfo[playerid][pRank] < 5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste u LAW fakciji i rank 5!");
		if( Iter_Count(APB) == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " APB je vec prazan!");

		new
			slotid;
		if( sscanf(params, "s[16]i", pick, slotid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /apb remove [slotid]");
		if( slotid < 0 && slotid > MAX_APB_SLOTS ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID (0-%d).", MAX_APB_SLOTS-1 );

		RemoveAPBInfo(slotid);

		APBInfo[ slotid ][ aSQLID ] 				= 0;
		APBInfo[ slotid ][ aName ][ 0 ] 			= EOS;
		APBInfo[ slotid ][ aDiscription ][ 0 ] 		= EOS;
		APBInfo[ slotid ][ aType ] 					= 0;
		APBInfo[ slotid ][ aPDName ][ 0 ] 			= EOS;

		Iter_Remove(APB, slotid);
	}
	else if( !strcmp(pick, "list", true) ) {
		if( !Iter_Count(APB) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Baza je prazna!");
			new
				tmpString[ 1024 ];
		foreach(new i : APB) {
			format( tmpString, 1024, "%s"COL_EASY"#%d\t%s\t%s\n",
				tmpString,
				i + 1,
				APBInfo[ i ][ aName ],
				GetAPBType(APBInfo[ i ][ aType ])
			);
		}
		ShowPlayerDialog( playerid, 0, DIALOG_STYLE_TABLIST, "APB - LIST (ALL)", tmpString, "Uredu", "");
	}
	else if( !strcmp(pick, "check", true) ) {
		if( !Iter_Count(APB) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Baza je prazna!");
		ShowPlayerDialog( playerid, DIALOG_APB_CHECK, DIALOG_STYLE_INPUT, "* APB CHECK - ID", "Unesite ID APB-a kojeg zelite provijeriti.", "Unesi", "Odustani");
	}
	return 1;
}
