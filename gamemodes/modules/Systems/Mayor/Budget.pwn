#include <YSI\y_hooks>

#if defined MODULE_CITY
	#endinput
#endif
#define MODULE_CITY




/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/
	
// Passanje imena za OnDialogRespone
new gPersonChecked[MAX_PLAYER_NAME];

// Passanje  listitem odabira za factionbank dialog mayora
new FactionListID[MAX_PLAYERS];

// Varijabla koja sprema u kojoj pod kojim listitemom je koja fakcija (NPR ako je 2 ilegalna onda ce ovako izgledat)
// [0] [1] -> PD
// [1] [3] -> FD
new FactionToList[MAX_PLAYERS][10];


/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

stock LoadCityStuff()
{
	mysql_tquery(g_SQL, "SELECT * FROM city WHERE 1", "OnCityLoaded");
	return 1;
}

forward OnCityLoaded();
public OnCityLoaded()
{
	new 
		rows = cache_num_rows();
	if(!rows) return printf( "MySQL Report: No city info exist to load.");

	cache_get_value_name_int(0, "budget", CityInfo[ cBudget ]);
	cache_get_value_name_int(0, "illegalbudget", CityInfo[ cIllegalBudget ]);
	cache_get_value_name_int(0, "tax"	, CityInfo[ cTax ]);
	
	print("MySQL Report: City info loaded!");
	return 1;
}

stock SaveCityInfo()
{
	new
		tmpQuery[ 256 ];	
	format( tmpQuery, 256, "UPDATE city SET budget = '%d', illegalbudget = '%d', tax = '%d' WHERE 1",
		CityInfo[ cBudget ],
		CityInfo[ cIllegalBudget ],
		CityInfo[ cTax ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

// ######################## GOV MDC #############################

stock ShowGovMDC(playerid, targetid)
{
	new
		tmpString[ 30 ],
		motd[ 256 ];
		
	switch(PlayerInfo[targetid][pJob])  {
         case 1:  format(tmpString, sizeof(tmpString), "Cistac ulica");
         case 2:  format(tmpString, sizeof(tmpString), "Pizza Boy");
         case 3:  format(tmpString, sizeof(tmpString), "Mehanicar");
         case 4:  format(tmpString, sizeof(tmpString), "Kosac trave");
         case 5:  format(tmpString, sizeof(tmpString), "Tvornicki radnik");
         case 6:  format(tmpString, sizeof(tmpString), "Taksist");
         case 7:  format(tmpString, sizeof(tmpString), "Farmer");
		 case 8:  format(tmpString, sizeof(tmpString), "Nepoznato");
         case 9:  format(tmpString, sizeof(tmpString), "Nepoznato");
         case 10: format(tmpString, sizeof(tmpString), "Nepoznato");
		 case 11: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 12: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 13: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 14: format(tmpString, sizeof(tmpString), "Drvosjeca");
         case 15: format(tmpString, sizeof(tmpString), "Kamiondzija");
         case 16: format(tmpString, sizeof(tmpString), "Smetlar");
         case 17: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 18: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 19: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 20: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 21: format(tmpString, sizeof(tmpString), "Nepoznato");
		 case 22: format(tmpString, sizeof(tmpString), "Nepoznato");
		 case 23: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 24: format(tmpString, sizeof(tmpString), "Nepoznato");
         case 25: format(tmpString, sizeof(tmpString), "Nepoznato");
         default: format(tmpString, sizeof(tmpString), "Nezaposlen");
    }
	
    new govDialog[1024];
	format(motd, sizeof(motd),"{C9C9C9}PERSONAL PROFILE:\n\n{DCE4ED}Ime: %s\nSpol: %s\nGodine: %d\n",
		GetName(targetid,true),
		PlayerInfo[targetid][pSex] == 1 ? ("Musko") : ("Zensko"),
		PlayerInfo[targetid][pAge]
	);
    strcat(govDialog,motd, sizeof(govDialog));
	
	format(motd, sizeof(motd),"{DCE4ED}Broj telefona: %d\nPosao: %s\nUhicivan puta: %d\n\n",
		PlayerInfo[targetid][pMobileNumber],
		tmpString,
		PlayerInfo[targetid][pArrested]
	);
    strcat(govDialog,motd, sizeof(govDialog));
	
	format(motd, sizeof(motd),"{C9C9C9}POSSESIONS:\n\n{DCE4ED}Bank. racun: %d$ \n",
		PlayerInfo[targetid][pBank]
	);
	strcat(govDialog,motd, sizeof(govDialog));
	
	new bool:property = false,
		bool:bizz = false;
	if( PlayerInfo[targetid][pHouseKey] != INVALID_HOUSE_ID )
	{
		format(motd, sizeof(motd),"{DCE4ED}Kuca: %s (( %d )) | Vrijednost nekretnine: %d$\n",
			HouseInfo[PlayerInfo[targetid][pHouseKey]][hAdress],
			PlayerInfo[targetid][pHouseKey],
			HouseInfo[PlayerInfo[targetid][pHouseKey]][hValue]
		);
		strcat(govDialog,motd, sizeof(govDialog));
		property = true;
	}
	if( PlayerInfo[targetid][pComplexRoomKey] != INVALID_COMPLEX_ID )
	{
		format(motd, sizeof(motd),"{DCE4ED}Stan: %s (( %d )) | Iznos najma: %d$\n",
			ComplexRoomInfo[PlayerInfo[targetid][pComplexRoomKey]][cAdress],
			PlayerInfo[targetid][pComplexRoomKey],
			ComplexRoomInfo[PlayerInfo[targetid][pComplexRoomKey]][cValue]
		);
		strcat(govDialog,motd, sizeof(govDialog));
		property = true;
	}
	if( PlayerInfo[targetid][pComplexKey] != INVALID_COMPLEX_ID )
	{
		format(motd, sizeof(motd),"{DCE4ED}Complex stanova: %s (( %d )) | Vrijednost nekretnine: %d$ | Stanje blagajne: %d$\n",
			ComplexInfo[PlayerInfo[targetid][pComplexKey]][cName],
			PlayerInfo[targetid][pComplexKey],
			ComplexInfo[PlayerInfo[targetid][pComplexKey]][cPrice],
			ComplexInfo[PlayerInfo[targetid][pComplexKey]][cTill]
		);
		strcat(govDialog,motd, sizeof(govDialog));
		property = true;
	}
	if( property == false ) 
	{
		format(motd, sizeof(motd),"{DCE4ED}Ne posjeduje nekretninu.\n");
		strcat(govDialog,motd, sizeof(govDialog));
	}
	if( PlayerInfo[targetid][pBizzKey] != INVALID_BIZNIS_ID )
	{
		format(motd, sizeof(motd),"{DCE4ED}Biznis: %s (( %d )) | Vrijednost firme: %d$ | Stanje blagajne u firmi: %d$",
			BizzInfo[PlayerInfo[targetid][pBizzKey]][bMessage],
			PlayerInfo[targetid][pBizzKey],
			BizzInfo[PlayerInfo[targetid][pBizzKey]][bBuyPrice],
			BizzInfo[PlayerInfo[targetid][pBizzKey]][bTill]
		);
		strcat(govDialog,motd, sizeof(govDialog));
		bizz = true;
	}
	if( bizz == false ) 
	{
		format(motd, sizeof(motd),"{DCE4ED}Ne posjeduje biznis.");
		strcat(govDialog,motd, sizeof(govDialog));
	}

    ShowPlayerDialog(playerid, DIALOG_GOVMDC, DIALOG_STYLE_MSGBOX, "{98B5D3}PROFILE ASSIGNED", govDialog, "Transakcije", "Close");
	return 1;
}
// ######################### FACTION BANKE #########################

stock ResetFactionListIDs(playerid)
{
	FactionListID[playerid] = -1;
	return 1;
}

stock SaveFactionBanks()
{
	new saveQuery[128];
	foreach(new fid : Factions) 
	{
		if(FactionInfo[fid][fType] == FACTION_TYPE_LAW || FactionInfo[fid][fType] == FACTION_TYPE_LAW2 || FactionInfo[fid][fType] == FACTION_TYPE_FD || FactionInfo[fid][fType] == FACTION_TYPE_NEWS)  	
		{
			format( saveQuery, sizeof(saveQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'", FactionInfo[fid][fFactionBank], FactionInfo[fid][fID] );
			mysql_tquery(g_SQL, saveQuery, "", "");
		}
	}
	return 1;
}

// ######################### POREZNA STOCKS #########################################

stock CheckPlayerTransactions(playerid, const name[])
{
	new financesQuery[160];
		
	mysql_format(g_SQL, financesQuery, sizeof(financesQuery), "SELECT * FROM `server_transactions` WHERE `sendername` = '%e' OR `recievername` = '%e' ORDER BY `id` DESC",
		name,
		name
	);
	mysql_tquery(g_SQL, financesQuery, "OnPlayerTransactionFinish", "is", playerid, name);
	
	return 1;
}

forward OnPlayerTransactionFinish(playerid, const searchednick[]);
public OnPlayerTransactionFinish(playerid, const searchednick[])
{
	new 
		rows = cache_num_rows();
	if(!rows) return SendClientMessage(playerid,COLOR_RED, "U bazi transakcija nije pronadjena trazena osoba.");
	
	new dialogstring[4096], 
		motd[256],
		typestring[64],
		descstring[64],
		dtitle[60],
		buyer[MAX_PLAYER_NAME],
		seller[MAX_PLAYER_NAME],
		datestring[24],
		amount, 
		ltype,
		sqlid,
		lenleft;
	
	for( new i = 0; i < cache_num_rows(); i++ ) 
	{	
		lenleft = sizeof(dialogstring) - strlen(dialogstring);
		if(lenleft < sizeof(motd))
			break;
			
		cache_get_value_name_int(i, "id"			, sqlid);
		cache_get_value_name(i, 	"sendername"	, buyer, 	24);
		cache_get_value_name(i, 	"recievername"	, seller,	24);
		cache_get_value_name_int(i, "money"			, amount);
		cache_get_value_name_int(i, "logtype"		, ltype);
		cache_get_value_name(i, 	"date"			, datestring, 24);
		cache_get_value_name(i, 	"description"	, descstring, 64);
		
		switch(ltype)
		{
			case LOG_TYPE_BIZSELL:		format(typestring, sizeof(typestring), "Transakcije biznisa");
			case LOG_TYPE_HOUSESELL: 	format(typestring, sizeof(typestring), "Transakcije kuce");
			case LOG_TYPE_VEHICLESELL: 	format(typestring, sizeof(typestring), "Transakcije vozila");
			case LOG_TYPE_COMPLEXSELL: 	format(typestring, sizeof(typestring), "Transakcije kompleksa");
			case LOG_TYPE_GARAGESELL: 	format(typestring, sizeof(typestring), "Transakcije garaza");
		}
		
		format(motd, sizeof(motd), "ID: %d | %s | %s | Kupac: %s | Prodavac: %s | Iznos: %d$ | %s\n",
			sqlid,
			datestring,
			typestring,
			buyer,
			seller,
			amount,
			descstring
		);
		strcat(dialogstring, motd, sizeof(dialogstring));
	}
	format(gPersonChecked, sizeof(gPersonChecked), "%s", searchednick);
	format(dtitle, sizeof(dtitle), "Imovinske transakcije: %s", searchednick);
	ShowPlayerDialog(playerid, DIALOG_PLAYER_TRANSACTIONS, DIALOG_STYLE_MSGBOX, dtitle, dialogstring, "Close", "");
	return 1;
}

stock ListServerTransactions(playerid, type)
{
	new financesQuery[180];
		
	format(financesQuery, sizeof(financesQuery), "SELECT * FROM `server_transactions` WHERE `logtype` = '%d' ORDER BY `id` DESC",
		type
	);
	mysql_tquery(g_SQL, financesQuery, "OnTransListQueryFinish", "ii", playerid, type);
	
	return 1;
}

forward OnTransListQueryFinish(playerid, logtype);
public OnTransListQueryFinish(playerid, logtype)
{
	new 
		rows = cache_num_rows();
	if(!rows) return SendClientMessage(playerid,COLOR_RED, "U bazi transakcija nema nijednog unosa za trazeni upit.");
	
	new dialogstring[4096], 
		motd[256],
		typestring[64],
		descstring[64],
		dtitle[60],
		buyer[MAX_PLAYER_NAME],
		seller[MAX_PLAYER_NAME],
		datestring[24], 
		amount,
		sqlid,
		lenleft;
		
	for( new i = 0; i < rows; i++ ) 
	{
		lenleft = sizeof(dialogstring) - strlen(dialogstring);
		if(lenleft < sizeof(motd))
			break;
			
		cache_get_value_name_int(i, "id"			, sqlid);
		cache_get_value_name(i, 	"sendername"	, buyer, 	24);
		cache_get_value_name(i, 	"recievername"	, seller,	24);
		cache_get_value_name_int(i, "money"			, amount);
		cache_get_value_name(i, 	"date"			, datestring, 24);
		cache_get_value_name(i, 	"description"	, descstring, 64);
		
		switch(logtype)
		{
			case LOG_TYPE_BIZSELL:		format(typestring, sizeof(typestring), "Transakcije biznisa");
			case LOG_TYPE_HOUSESELL: 	format(typestring, sizeof(typestring), "Transakcije kuce");
			case LOG_TYPE_VEHICLESELL: 	format(typestring, sizeof(typestring), "Transakcije vozila");
			case LOG_TYPE_COMPLEXSELL: 	format(typestring, sizeof(typestring), "Transakcije kompleksa");
			case LOG_TYPE_GARAGESELL: 	format(typestring, sizeof(typestring), "Transakcije garaza");
		}

		format(motd, sizeof(motd), "ID: %d | %s | Kupac: %s | Prodavac: %s | Iznos: %d$ | %s\n",
			sqlid,
			datestring,
			buyer,
			seller,
			amount,
			descstring
		);
		strcat(dialogstring, motd, sizeof(dialogstring));
	}
	format(dtitle, sizeof(dtitle), "Lista transakcija: %s", typestring);
	ShowPlayerDialog(playerid, DIALOG_PLAYER_TRANSACTIONS, DIALOG_STYLE_MSGBOX, dtitle, dialogstring, "Close", "");
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

hook OnGameModeInit()
{
	LoadCityStuff();
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	FactionToList[playerid][0] 	= -1;
	FactionToList[playerid][1]	= -1;
	FactionToList[playerid][2] 	= -1;
	FactionToList[playerid][3]	= -1;
	FactionToList[playerid][4] 	= -1;
	FactionToList[playerid][5] 	= -1;
	FactionToList[playerid][6] 	= -1;
	FactionToList[playerid][7] 	= -1;
	FactionToList[playerid][8] 	= -1;
	FactionToList[playerid][9] 	= -1;
	
	FactionListID[playerid] 	= -1;
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_CITY_MAIN: {
			if( !response ) return 1;
			
			switch( listitem ) {
				case 0: { // Proracun
					ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET, DIALOG_STYLE_LIST, "GRADSKI PRORACUN", "Uzmi\nStavi\nStatus", "Choose", "Abort");
				}
				case 1: { // Porez
					new
						tmpString[ 128 ];
					format( tmpString, sizeof(tmpString), "Unesite novi porez za gradjane Los Santosa.\nTrenutni porez iznosi: %d"COL_GREEN"%", 
						CityInfo[ cTax ] 
					);
					ShowPlayerDialog(playerid, DIALOG_CITY_TAX, DIALOG_STYLE_INPUT, "GRADSKI PRORACUN - POREZ", tmpString, "Input", "Abort");
				}
				case 2: { // Faction Bank
					new buffer[512],
						counter = 0;
					
					format(buffer, 512, "Organizacija\tFaction Bank\n");
					foreach(new faciter: Factions)
					{
						if(FactionInfo[faciter][fType] == FACTION_TYPE_LAW || FactionInfo[faciter][fType] == FACTION_TYPE_LAW2 || FactionInfo[faciter][fType] == FACTION_TYPE_FD || FactionInfo[faciter][fType] == FACTION_TYPE_NEWS) 
						{
							format(buffer, sizeof(buffer), "%s%s\t {00E600}%d$\n", buffer, FactionInfo[faciter][fName], FactionInfo[faciter][fFactionBank]);
							FactionToList[playerid][counter] = faciter;
							counter++;
						}
					}
					ShowPlayerDialog(playerid, DIALOG_CITY_FACTIONBANK, DIALOG_STYLE_TABLIST_HEADERS, "PRORACUN ORGANIZACIJA", buffer, "Choose", "Abort");
				}
				case 3: // Mayor Business Regulation ( Info && Deposit/Withdraw)
					ShowPlayerDialog(playerid, DIALOG_CITY_BIZNIS, DIALOG_STYLE_LIST, "Odaberite opciju:", "Biznis Info\nStavi novac u blagajnu\nDigni novac iz blagajne", "Choose", "Exit");
			}
			return 1;
		}
		case DIALOG_CITY_BIZNIS: {
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
			switch(listitem)
			{
				case 0: { // Bizz Info
					new
						biznis = INVALID_BIZNIS_ID;
						
					foreach(new i : Bizzes) {
						if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
							biznis = i;
							break;
						}
					}
					if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa.");
			
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Bizz ID: %d | Bizz MySQL ID: %d", biznis, BizzInfo[biznis][bSQLID]);
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stanje u blagajni biznisa: %d$", BizzInfo[biznis][bTill]);
					
					new
						infoString[68];
					if(BizzInfo[biznis][bPriceProd] == 0) 
						return SendClientMessage(playerid, COLOR_RED, "[ ! ] Biznis nema definiranu cijenu produkata.");
						
					format(infoString, sizeof(infoString), "Cijena po produktu: %d", BizzInfo[biznis][bPriceProd]);
					SendClientMessage(playerid, -1,infoString);
					
					new 
						Float:prodammount = BizzInfo[biznis][bTill] / BizzInfo[biznis][bPriceProd],
						RecievingPackages = floatround(prodammount, floatround_floor);
					if(RecievingPackages == 0) 
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Biznis nije spreman primiti nove produkte (Financijska kriza).");
					else
					{
						format(infoString, sizeof(infoString), "[INFO] Bizins je spreman primiti %d paketa produkata.", RecievingPackages);
						SendClientMessage(playerid, -1,infoString);
					}
					if( BizzInfo[biznis][bLocked] )
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Zakljucano");
					else
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Otkljucano");
				}
				case 1: { // Stavljanje novca na biznis blagajnu
					new
						biznis = INVALID_BIZNIS_ID;
						
					foreach(new i : Bizzes) {
						if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
							biznis = i;
							break;
						}
					}
					if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa.");
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stanje u blagajni biznisa: %d$", BizzInfo[biznis][bTill]);
					ShowPlayerDialog(playerid, DIALOG_CITY_BIZDEPOSIT, DIALOG_STYLE_INPUT, "Stavljanje novca u blagajnu biznisa", "Molimo Vas unesite iznos koji zelite staviti u biznis:", "Input", "Exit");
				}
				case 2: { // Dizanje novca iz biznis blagajne
					new
						biznis = INVALID_BIZNIS_ID;
						
					foreach(new i : Bizzes) {
						if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
							biznis = i;
							break;
						}
					}
					if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa.");
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stanje u blagajni biznisa: %d$", BizzInfo[biznis][bTill]);
					ShowPlayerDialog(playerid, DIALOG_CITY_BIZWITHDRAW, DIALOG_STYLE_INPUT, "Uzimanje novca iz blagajne biznisa", "Molimo Vas unesite iznos koji zelite dignuti iz biznisa:", "Input", "Exit");
				}
			}
			return 1;
		}
		case DIALOG_CITY_BIZDEPOSIT: { // Stavljanje novca na biznis blagajnu
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_CITY_BIZNIS, DIALOG_STYLE_LIST, "Odaberite opciju:", "Biznis Info\nStavi novac u blagajnu\nDigni novac iz blagajne", "Choose", "Exit");
			new
				biznis = INVALID_BIZNIS_ID;
				
			foreach(new i : Bizzes) {
				if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
					biznis = i;
					break;
				}
			}
			if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa.");
			new
				putMoney = strval(inputtext);
				
			if( putMoney > 0 ) 
			{
				if( AC_GetPlayerMoney(playerid) < putMoney ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");
				PlayerToBusinessMoney (playerid, biznis, putMoney); // Novac od Mayora ide u biznis
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste stavili %d$ u blagajnu biznisa %s!", putMoney, BizzInfo[biznis][bMessage]);
				#if defined MODULE_LOGS
				Log_Write("/logfiles/proracun.txt", "(%s) Mayor %s put %d$ in business %s [SQlID: %d].",
					ReturnDate(),
					GetName(playerid),
					putMoney,
					BizzInfo[biznis][bMessage],
					biznis,
					BizzInfo[biznis][bSQLID]
				);
				#endif
			} 
			else {
				ShowPlayerDialog(playerid, DIALOG_CITY_BIZDEPOSIT, DIALOG_STYLE_INPUT, "Stavljanje novca u blagajnu biznisa", "Molimo Vas unesite iznos koji zelite staviti u biznis:", "Input", "Exit");
				return 1;
			}
			return 1;
		}
		case DIALOG_CITY_BIZWITHDRAW: { // Dizanje novca iz biznis blagajne
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_CITY_BIZNIS, DIALOG_STYLE_LIST, "Odaberite opciju:", "Biznis Info\nStavi novac u blagajnu\nDigni novac iz blagajne", "Choose", "Exit");
			new
				biznis = INVALID_BIZNIS_ID;
				
			foreach(new i : Bizzes) {
				if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
					biznis = i;
					break;
				}
			}
			if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid,COLOR_RED, "Ne nalazis se ispred ulaza biznisa.");
			new
				takeMoney = strval(inputtext);
				
			if( takeMoney > 0 ) {
				if( BizzInfo[biznis][bTill] < takeMoney ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "U blagajni biznisa nema toliko novca. Stanje blagajne: %d$", BizzInfo[biznis][bTill]);
				BusinessToPlayerMoney (playerid, biznis, takeMoney); // Novac iz biznisa ide u ruke Mayora
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste digli %d$ iz blagajne biznisa %s!", takeMoney, BizzInfo[biznis][bMessage]);
				#if defined MODULE_LOGS
				Log_Write("/logfiles/proracun.txt", "(%s) Mayor %s took %d$ from business %s [SQlID: %d].",
					ReturnDate(),
					GetName(playerid),
					takeMoney,
					BizzInfo[biznis][bMessage],
					biznis,
					BizzInfo[biznis][bSQLID]
				);
				#endif
			} 
			else {
				ShowPlayerDialog(playerid, DIALOG_CITY_BIZWITHDRAW, DIALOG_STYLE_INPUT, "Uzimanje novca iz blagajne biznisa", "Molimo Vas unesite iznos koji zelite dignuti iz biznisa:", "Input", "Exit");
				return 1;
			}
			return 1;
		}
		case DIALOG_CITY_BUDGET: {
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
			switch(listitem)
			{
				case 0: { // Uzmi
					new
						tmpString[ 86 ];
					format( tmpString, sizeof(tmpString), "Unesite iznos koji zelite uzeti iz proracuna.\nTrenutno stanje proracuna: %d$",
						CityInfo[ cBudget ]
					);
					ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET_TAKE, DIALOG_STYLE_INPUT, "GRADSKI PRORACUN - UZIMANJE", tmpString, "Input", "Abort");
				}
				case 1: { // Stavi
					new
						tmpString[ 86 ];
					format( tmpString, sizeof(tmpString), "Unesite iznos koji zelite staviti u proracun.\nTrenutno stanje proracuna: %d$",
						CityInfo[ cBudget ]
					);
					ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET_PUT, DIALOG_STYLE_INPUT, "GRADSKI PRORACUN - STAVLJANJE", tmpString, "Input", "Abort");
				}
				case 2: { // Status
					new
						tmpString[ 51 ];
					format( tmpString, sizeof(tmpString), "Trenutno stanje proracuna: %d "COL_GREEN"$",
						CityInfo[ cBudget ]
					);
					ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET_STAT, DIALOG_STYLE_MSGBOX, "GRADSKI PRORACUN - STATUS", tmpString, "Input", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_CITY_BUDGET_TAKE: 
		{
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET, DIALOG_STYLE_LIST, "GRADSKI PRORACUN", "Uzmi\nStavi\nStatus", "Choose", "Abort");
			new takeMoney = strval(inputtext);
			if(0 <= takeMoney <= CityInfo[ cBudget ])
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste %d $ iz proracuna!", takeMoney);
				BudgetToPlayerMoney(playerid, takeMoney); // Novac od budgeta ide Mayoru
				#if defined MODULE_LOGS
				Log_Write("/logfiles/proracun.txt", "(%s) Mayor %s took %d$ from city budget.(Left: %d$).",
					ReturnDate(),
					GetName(playerid),
					takeMoney,
					CityInfo[ cBudget ]
				);
				#endif
			}
			else
			{
				new
					tmpString[ 95 ];
				format( tmpString, sizeof(tmpString), "Unesite iznos koji zelite uzeti iz proracuna.\nTrenutno stanje proracuna: "COL_RED"%d$",
					CityInfo[ cBudget ]
				);
				ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET_TAKE, DIALOG_STYLE_INPUT, "GRADSKI PRORACUN - UZIMANJE", tmpString, "Input", "Abort");
				return 1;
			}
			return 1;
		}
		case DIALOG_CITY_BUDGET_PUT: 
		{
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET, DIALOG_STYLE_LIST, "GRADSKI PRORACUN", "Uzmi\nStavi\nStatus", "Choose", "Abort");
			new
				takeMoney = strval(inputtext);
			if( takeMoney > 0 ) {
				if( AC_GetPlayerMoney(playerid) < takeMoney ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");
				PlayerToBudgetMoney(playerid, takeMoney); // Novac od Mayora ide u budget
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Stavili ste %d$ u proracun!", takeMoney);
				#if defined MODULE_LOGS
				Log_Write("/logfiles/proracun.txt", "(%s) Mayor %s put %d$ in city budget.(Current state: %d$).",
					ReturnDate(),
					GetName(playerid),
					takeMoney,
					CityInfo[ cBudget ]
				);
				#endif
			} 
			else 
			{
				new
					tmpString[ 200 ];
				format( tmpString, sizeof(tmpString), "Unesite iznos koji zelite staviti u proracun.\nTrenutno stanje proracuna: "COL_RED"%d$",
					CityInfo[ cBudget ]
				);
				ShowPlayerDialog(playerid, DIALOG_CITY_BUDGET_PUT, DIALOG_STYLE_INPUT, "GRADSKI PRORACUN - STAVLJANJE", tmpString, "Input", "Abort");
				return 1;
			}
			return 1;
		}
		case DIALOG_CITY_TAX: {
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
			
			new
				newTax = strval(inputtext);
			if( 1 <= newTax <= 100  ) {
				CityInfo[ cTax ] = newTax;
				new
					tmpQuery[ 128 ];
				format( tmpQuery, 128, "UPDATE city SET tax = '%d' WHERE 1",
					CityInfo[ cTax ]
				);
				mysql_tquery(g_SQL, tmpQuery, "");
				
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili porez u Los Santosu, sada on iznosi %d posto", 
					CityInfo[ cTax ]
				);
			} 
			else return SendClientMessage(playerid, COLOR_RED, "Porez moze biti od 1 do 100 posto!");
			return 1;
		}
		case DIALOG_CITY_FACTIONBANK: {
			if(!response) {
				ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
				ResetFactionListIDs(playerid);
				return 1;
			}
			else {
				FactionListID[playerid] = listitem;
				new dtitle[50],
				fid = FactionToList[playerid][listitem];
				
				format(dtitle, sizeof(dtitle), "%s Faction Bank | Odaberite opciju", FactionInfo[fid][fName]);
				ShowPlayerDialog(playerid, DIALOG_FACTIONBANK_OPTIONS, DIALOG_STYLE_LIST, dtitle, "Stavi novac u Faction Bank\nPodigni novac iz Faction Banka", "Choose", "Exit");
				
			}
			return 1;
		}
		case DIALOG_FACTIONBANK_OPTIONS: {
			if(!response) {
				ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
				ResetFactionListIDs(playerid);
				return 1;
			}
			else {
				new dtitle[50],
				fid = FactionToList[playerid][FactionListID[playerid]];
				
				switch(listitem) {
					case 0: {
						format(dtitle, sizeof(dtitle), "%s Faction Bank Deposit", FactionInfo[fid][fName]);
						ShowPlayerDialog(playerid, DIALOG_FACTIONBANK_DEPOSIT, DIALOG_STYLE_INPUT, dtitle, "Upisite svotu koju zelite staviti na Faction Banku", "Input", "Exit");
					}
					case 1: {
						format(dtitle, sizeof(dtitle), "%s Faction Bank Withdraw", FactionInfo[fid][fName]);
						ShowPlayerDialog(playerid, DIALOG_FACTIONBANK_WITHDRAW, DIALOG_STYLE_INPUT, dtitle, "Upisite svotu koju zelite podici sa Faction Banka", "Podigni", "Exit");
					}
				}
			}
			return 1;
		}
		case DIALOG_FACTIONBANK_DEPOSIT: {
			if(!response) {
				ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
				ResetFactionListIDs(playerid);
				return 1;
			}
			else {
				new fid = FactionToList[playerid][FactionListID[playerid]],
					money = strval(inputtext);
					
				if(money < 1) return SendClientMessage(playerid,COLOR_RED, "Svota novca ne moze biti manja od 1$");
				if(money > AC_GetPlayerMoney(playerid)) return SendClientMessage(playerid,COLOR_RED, "Nemate toliko novaca u ruci!");
				
				PlayerToOrgMoney(playerid, FactionInfo[fid][fType], money);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste stavili %d$ na %s Faction Bank.", money, FactionInfo[fid][fName]);
				
				// Log
				Log_Write("logfiles/faction_bank.txt", "(%s) Mayor %s (SQLID:%d) deposited %d$ in %s Faction Bank.", // Opet imas 6 varijabli a 5 ispisa
					ReturnDate(), 
					GetName(playerid), 
					PlayerInfo[playerid][pSQLID], 
					money,
					FactionInfo[fid][fName]
				);
				ResetFactionListIDs(playerid);
			}
			return 1;
		}
		case DIALOG_FACTIONBANK_WITHDRAW: {
			if(!response) {
				ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
				ResetFactionListIDs(playerid);
				return 1;
			}
			else {
				new fid = FactionToList[playerid][FactionListID[playerid]],
					money = strval(inputtext);
				if(money < 1) return SendClientMessage(playerid,COLOR_RED, "Svota novca ne moze biti manja od 1$");
				if(money > FactionInfo[fid][fFactionBank]) return SendClientMessage(playerid,COLOR_RED, "Ne postoji tolika svota novaca u tom Faction Banku!");

				OrgToPlayerMoney( playerid, FactionInfo[fid][fType], money);
				va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste digli %d$ sa %s Faction Bank.", money, FactionInfo[fid][fName]);
				
				// Log
				Log_Write("logfiles/faction_bank.txt", "(%s) Mayor %s (SQLID:%d) withdrawed %d$ from %s Faction Bank.", 
					ReturnDate(), 
					GetName(playerid), 
					PlayerInfo[playerid][pSQLID], 
					money,
					FactionInfo[fid][fName]
				);
				ResetFactionListIDs(playerid);
			}
			return 1;
		}
		case DIALOG_PLAYER_TRANSACTIONS: 
		{
			format(gPersonChecked, sizeof(gPersonChecked), "\n");
			return 1;
		}
		case DIALOG_LIST_TRANSACTIONS:
		{
			if(!response) 
				return 1;
			switch(listitem)
			{
				case 0:
					ShowPlayerDialog(playerid, DIALOG_TRANSACTIONS_INPUT, DIALOG_STYLE_INPUT, "Unos imena", "Molimo Vas unesite zeljeno ime", "Input", "Close");
				case 1:
					ListServerTransactions(playerid, LOG_TYPE_HOUSESELL);
				case 2:
					ListServerTransactions(playerid, LOG_TYPE_BIZSELL);
				case 3:
					ListServerTransactions(playerid, LOG_TYPE_VEHICLESELL);
				case 4:
					ListServerTransactions(playerid, LOG_TYPE_COMPLEXSELL);
				case 5:
					ListServerTransactions(playerid, LOG_TYPE_GARAGESELL);
			}
		}
		case DIALOG_TRANSACTIONS_INPUT:
		{
			if(!IsValidNick(inputtext)) return SendClientMessage(playerid,COLOR_RED, "Niste unijeli pravilno ime i prezime osobe!");
			CheckPlayerTransactions(playerid, inputtext);
		}
		case DIALOG_GOVMDC:
		{
			if(response) { // Ako pritisne Pregled transakcija
				CheckPlayerTransactions(playerid, GetName(Bit8_Get( gr_GovMDC, playerid), false));
				Bit8_Set(gr_GovMDC, playerid, INVALID_PLAYER_ID);
			}
			else { // Ako pritisne ESC ili NE
				Bit8_Set(gr_GovMDC, playerid, INVALID_PLAYER_ID);
			}
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

CMD:setcity(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1338 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste ovlasteni!");
	
	new
		pick[ 8 ],
		tmpQuery[ 128 ],
		moneys;
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: : /setcity [budget/ibudget/tax]");
	
	if( !strcmp(pick, "budget", true) ) {
		if( sscanf( params, "s[8]i", pick, moneys ) )  {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: : /setcity budget [money]");
			va_SendClientMessage(playerid, COLOR_GREY, "[PRORACUN]: Stanje: %d$", CityInfo[ cBudget ] );
			return 1;
		}
		CityInfo[ cBudget ] = moneys;

		format( tmpQuery, 128, "UPDATE city SET budget = '%d' WHERE 1",
			CityInfo[ cBudget ]
		);
		mysql_tquery(g_SQL, tmpQuery, "");
	}
	else if( !strcmp(pick, "tax", true) ) {
		if( sscanf( params, "s[8]i", pick, moneys ) )  {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: : /setcity tax [money]");
			va_SendClientMessage(playerid, COLOR_GREY, "[PRORACUN]: Stanje: %d$", CityInfo[ cBudget ] );
			return 1;
		}
		if ( 1 > moneys > 100) return SendClientMessage(playerid, -1, "Porez moze biti 1 - 100 posto");
		CityInfo[ cTax ] = moneys;

		format( tmpQuery, 128, "UPDATE city SET tax = '%d' WHERE 1",
			CityInfo[ cTax ]
		);
		mysql_tquery(g_SQL, tmpQuery, "");
	}
	else if( !strcmp(pick, "ibudget", true) ) {
		if( sscanf( params, "s[8]i", pick, moneys ) )  {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: : /setcity ibudget [money]");
			va_SendClientMessage(playerid, COLOR_GREY, "[ILEGALNI PRORACUN]: Stanje: %d$", CityInfo[ cIllegalBudget ] );
			return 1;
		}
		CityInfo[ cIllegalBudget ] = moneys;

		format( tmpQuery, 128, "UPDATE city SET illegalbudget = '%d' WHERE 1",
			CityInfo[ cIllegalBudget ]
		);
		mysql_tquery(g_SQL, tmpQuery, "");
	}
	return 1;
}

CMD:city(playerid, params[])
{
 	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	// if(!IsAtBank(playerid)) return SendClientMessage(playerid, COLOR_RED, "Morate biti u banci da bi ste mogli koristiti ovu komandu !");
	ShowPlayerDialog( playerid, DIALOG_CITY_MAIN, DIALOG_STYLE_LIST, "GRAD", "Proracun\nPorez\nFaction Bank\nBiznis Info", "Choose", "Abort");
	return 1;
}

CMD:charity(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Samo igraci level 3+ mogu donirati!");
	new
		pay, string[128];
	if( sscanf( params, "i", pay ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /charity [novci]");
	if( pay < 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete donirati manje novca!");
	if( pay > AC_GetPlayerMoney(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete vise donirati nego sto imate novca!");

	PlayerToBudgetMoney(playerid, pay);
	format(string, sizeof(string), "**[GOV FINANCE/ IM] %s je izvrsio uplatu na GP u vrijednosti od %d $", GetName(playerid, true), pay);
	SendRadioMessage(4, TEAM_BLUE_COLOR, string);
	
	#if defined MODULE_LOGS
	Log_Write("/logfiles/charity.txt" "(%s) %s(%s) donated %d$ to city budget.", 
		ReturnDate(),
		GetName( playerid, false ), 
		GetPlayerIP(playerid),
		pay
	);
	#endif
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste donirali %d$ gradu!", pay);
	return 1;
}

CMD:finance(playerid, params[])
{
	new pick[10],
		fid = PlayerInfo[playerid][pMember];
		
	if(FactionInfo[fid][fType] != FACTION_TYPE_LEGAL) return SendClientMessage(playerid,COLOR_RED, "Niste pripadnik Los Santos Govermenta!");
	if(sscanf(params, "s[10] ", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /finance [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] check, delete");
		return 1;
	}
	if( !strcmp(pick,"check",true) ) 
		ShowPlayerDialog(playerid, DIALOG_LIST_TRANSACTIONS, DIALOG_STYLE_LIST, "Odaberite koje transakcije provjeravate", "Osoba\nKuce\nBiznisi\nVozila\nKompleksi\nGaraze", "Choose", "Exit");
	if( !strcmp(pick,"delete",true) )  {
		new id;
		if(sscanf(params, "s[10]i", pick, id)) {
			SendClientMessage(playerid,-1,"[ ? ]: /finance delete [ID transakcije]");
			return 1;
		}
		if(id < 0) return SendClientMessage(playerid,COLOR_RED, "ID transakcije ne moze biti manji od 0!");
		if( PlayerInfo[ playerid ][ pLeader ] != 4 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste Mayor!");
		
		new deleteQuery[90];
		format(deleteQuery, 90, "DELETE FROM `server_transactions` WHERE id = '%d'", id);
		mysql_tquery(g_SQL, deleteQuery);
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali transakciju [ID: %d] iz baze podataka.", id);
	}
	return 1;
}

CMD:govmdc(playerid, params[])
{
    if (PlayerInfo[playerid][pMember] != 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /govmdc [ID/DioImena]");
	if (!IsPlayerLogged(giveplayerid) || !IsPlayerConnected(giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije ulogiran!");
	Bit8_Set(gr_GovMDC, playerid, giveplayerid);
    ShowGovMDC(playerid, giveplayerid);
	return 1;
}