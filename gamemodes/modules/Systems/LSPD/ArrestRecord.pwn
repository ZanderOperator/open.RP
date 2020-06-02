#include <YSI\y_hooks>

#define MAX_AR_SLOTS 		(2000)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

enum E_AR_DATA
{
	arSQLID,
	arSuspect[MAX_PLAYER_NAME],
	arCop[MAX_PLAYER_NAME],
	arDescription[128],
	arTime[32]
}
new ARInfo[ MAX_AR_SLOTS ][ E_AR_DATA ];

new SlotInUse[MAX_AR_SLOTS];
	
static stock
	Bit8:gr_ARSlot<MAX_PLAYERS> = {Bit8:0,...};


/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

stock LoadARData()
{
	mysql_tquery(g_SQL, "SELECT * FROM arrestrecords WHERE id >= 0", "OnARLoaded");
	return 1;
}

forward OnARLoaded();
public OnARLoaded()
{
	new
		rows = cache_num_rows(),
		arstring[ 2048 ],
		tmp[ 64 ];
	if(rows) {
	    for(new slotid = 0; slotid < rows; slotid++) {
			cache_get_value_name_int(slotid, "id", ARInfo[ slotid ][ arSQLID ]);
			cache_get_value_name(slotid, "suspect", tmp);
			format(ARInfo[ slotid ][ arSuspect ], MAX_PLAYER_NAME, tmp);
			cache_get_value_name(slotid, "cop", tmp);
			format(ARInfo[ slotid ][ arCop ], MAX_PLAYER_NAME, tmp);
			cache_get_value_name(slotid, "description", arstring);
			format(ARInfo[ slotid ][ arDescription ], 128, arstring);
			cache_get_value_name(slotid, "time", tmp);
			format(ARInfo[ slotid ][ arTime ], MAX_PLAYER_NAME, tmp);
		}
		printf("MySQL Report: Arrest Record data loaded (%d)!", rows);
	} else print("MySQL Report: No Arrest Record data exist to load.");
	return 1;
}

stock static SaveARInfo(slotid)
{
	new
		tmpQuery[ 2300 ];
	format(tmpQuery, sizeof(tmpQuery), "UPDATE arrestrecords SET suspect = '%q', cop = '%q', description = '%q', time = '%s' WHERE id = '%d'",
		ARInfo[ slotid ][ arSuspect ],
		ARInfo[ slotid ][ arCop ],
		ARInfo[ slotid ][ arDescription ],
		ARInfo[ slotid ][ arTime ],
		ARInfo[ slotid ][ arSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
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
		case DIALOG_AR_NAME: {
		    new slotid = Bit8_Get( gr_ARSlot, playerid );
			if( !response ) return SlotInUse[slotid] = 0;
			if( strlen(inputtext) > MAX_PLAYER_NAME || strlen(inputtext) < 6 ) return ShowPlayerDialog( playerid, DIALOG_AR_NAME, DIALOG_STYLE_INPUT, "UNOS OSUMLJICENOG", "** Minimalno 6, a maksimalno 24 slova **\n\nUnesite naziv u AR", "Unesi", "Odustani");
			format( ARInfo[ slotid ][ arSuspect ], MAX_PLAYER_NAME, inputtext );
			format( ARInfo[ slotid ][ arCop ], MAX_PLAYER_NAME, GetName(playerid,false) );
			ShowPlayerDialog( playerid, DIALOG_AR_OPIS, DIALOG_STYLE_INPUT, "UNESITE ARREST RECORD", "N/A", "Sacuvaj", "Dodaj jos");
			return 1;
		}
		case DIALOG_AR_OPIS: {
		    new slotid = Bit8_Get( gr_ARSlot, playerid );
			if( !response )
		 	{
		 		format(ARInfo[slotid][arDescription], 128, "%s\n%s", ARInfo[slotid][arDescription], inputtext);
				ShowPlayerDialog( playerid, DIALOG_AR_OPIS, DIALOG_STYLE_INPUT, "UNESITE ARREST RECORD", ARInfo[slotid][arDescription], "Sacuvaj", "Dodaj jos");
				return 1;
			}
			new arHour, arMinute, arSecond, arDay, arMonth, arYear;
			gettime(arHour, arMinute, arSecond);
			getdate(arYear, arMonth, arDay);
		 	format(ARInfo[slotid][arDescription], 128, "%s%s", ARInfo[slotid][arDescription], inputtext);
		 	format(ARInfo[slotid][arTime], 32, "%d/%d/%d %d:%dh", arDay, arMonth, arYear, arHour, arMinute);
		 	ARInfo[slotid][arSQLID] = slotid;
			SaveARInfo(slotid);
			new tmpString[ 256 ];
			format(tmpString, sizeof(tmpString), "[ ! ] Napisali ste Arrest Record za osobu %s. [AR ID: %d]", ARInfo[ slotid ][ arSuspect ], slotid );
			SendClientMessage(playerid, COLOR_RED, tmpString);
			SlotInUse[slotid] = 0;
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
CMD:ar(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	new pick[ 8 ], arSlot = -1;
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage( playerid, -1, "KORISTENJE /ar [add/view/delete/search]");
	if( !strcmp(pick, "add", true) ) {
		for(new i; i < MAX_AR_SLOTS; i++)
		{
		    if(!strcmp(ARInfo[ i ][ arCop ], "None", true) || !strcmp(ARInfo[ i ][ arSuspect ], "None", true) || !strcmp(ARInfo[ i ][ arDescription ], "", true))
		    {
		        arSlot = i;
		        Bit8_Set( gr_ARSlot, playerid, i );
		        break;
		    }
		}
		if(arSlot < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " AR je pun, zamolite r5+ da obrise stare Arrest Recorde!");
        SlotInUse[arSlot] = 1;
		ShowPlayerDialog( playerid, DIALOG_AR_NAME, DIALOG_STYLE_INPUT, "UNOS OSUMLJICENOG", "Unesite naziv u AR", "Unesi", "Odustani");
	}
	else if( !strcmp(pick, "view", true) ) {
		new
			slotid;
		if( sscanf(params, "s[8]i", pick, slotid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ar view [slotid]");
		if( slotid < 0 && slotid > MAX_AR_SLOTS ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID (0-%d).", MAX_AR_SLOTS-1 );
		if(!strcmp(ARInfo[ slotid ][ arDescription ], "", true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID. Arrest record ne postoji pod tim ID-om!");
		if(!strcmp(ARInfo[ slotid ][ arSuspect ], "None", true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID. Arrest record ne postoji pod tim ID-om!");
		if(!strcmp(ARInfo[ slotid ][ arCop ], "None", true)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID. Arrest record ne postoji pod tim ID-om!");
		new ARString[2300];
		format(ARString, sizeof(ARString), "%s\n=> Officer signature: %s\n=> Suspect: %s\n=> Arrest record: \n%s", ARInfo[ slotid ][ arTime ], ARInfo[ slotid ][ arCop ], ARInfo[ slotid ][ arSuspect ], ARInfo[ slotid ][ arDescription ]);
		ShowPlayerDialog( playerid, 5000, DIALOG_STYLE_MSGBOX, "ARREST RECORD", ARString, "OK", "");
	}
	else if( !strcmp(pick, "delete", true) ) {
	    if( PlayerInfo[ playerid ][ pRank ] < 5 ) SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste rank 5!");
		new
			slotid;
		if( sscanf(params, "s[8]i", pick, slotid ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ar delete [slotid]");
		if( slotid < 0 && slotid > MAX_AR_SLOTS ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan slot ID (0-%d).", MAX_AR_SLOTS-1 );
		format(ARInfo[ slotid ][ arSuspect ], 24, "None");
		format(ARInfo[ slotid ][ arCop ], 24, "None");
		format(ARInfo[ slotid ][ arDescription ], 128, "");
		format(ARInfo[ slotid ][ arTime ], 24, "");
		SaveARInfo(slotid);
	}
	else if( !strcmp(pick, "search", true) ) {
		new searchnick[24], arCount = 0;
		if( sscanf(params, "s[8]s[24]", pick, searchnick ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /ar search [Ime i prezime]");
		if(strlen(searchnick) < 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Prekratko ime i prezime!");
		for(new i = 0; i < MAX_AR_SLOTS; i++)
		{
            if(!strcmp(searchnick, ARInfo[ i ][ arSuspect ], false, strlen(searchnick)))
            {
                new tmpString[ 128 ];
				format(tmpString, sizeof(tmpString), "[AR ID: %d] %s (Officer: %s)", i, ARInfo[ i ][ arSuspect ], ARInfo[ i ][ arCop ] );
				SendClientMessage(playerid, COLOR_RED, tmpString);
				arCount++;
            }
		}
		if(arCount <= 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nije pronaden arrest record sa tim imenom!");
	}
	return 1;
}
