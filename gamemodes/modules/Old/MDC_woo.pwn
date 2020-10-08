/* 
                                                     
              |         |                            
,-.-.,---.,---|,---.    |---.,   .    . . .,---.,---.
| | |,---||   ||---'    |   ||   |    | | ||   ||   |
` ' '`---^`---'`---'    `---'`---|    `-'-'`---'`---'
                             `---'
APB % MDC							 
NOTES:
OBRISATI U COARP LoadAPBData()
ISKOMENTIRATI U COARP Modul apb.pwn
TRUNCATE U PHPMYADMIN APB TABLICU
ISKOMENTRATI U COARP MODUL arrestrecords.pwn
APB suspect i pdname prebaciti u VARCHAR 24
 */
#include <YSI\y_hooks>

#if defined MODULE_MDC
	#endinput
#endif
#define MODULE_MDC

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

enum E_JAIL_DATA
{
	jSuspectName[ MAX_PLAYER_NAME ],
	jPoliceName[ MAX_PLAYER_NAME ],
	jSQLID,
	jReason[24],
	jTime,
	jDate[ 32 ]	
}
new
	JailInfo[ MAX_PLAYERS ][ E_JAIL_DATA ];
	
new 
	PlayerText:MDCBg1[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... };
	
static stock
	PlayerText:MDCBg2[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCHeader[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCSkin[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCText1[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCProfileText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCText2[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCOtherText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCRecordButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCVehButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCTicketsButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCGeneralButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCAPBButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCloseButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };
	
new
	TargetName[ MAX_PLAYERS ][MAX_PLAYER_NAME],
	DeletingRecordID[ MAX_PLAYERS ],
	DeletingTicketID[ MAX_PLAYERS ];

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
// MySQL Callbacks

// Player GENERAL
stock static OnPlayerMDCDataLoad(playerid, const playername[])
{
	new mysqlQuery[128];
	
	format(mysqlQuery, 128, "SELECT * FROM accounts WHERE `name` = '%e' LIMIT 0,1", playername);
	inline OnPlayerMDCLoad()
	{
		if(!cache_num_rows()) 
			return va_SendClientMessage( playerid, COLOR_RED, "[GRESKA]: Korisnik %s ne postoji!", playername);
			
		new 
			loadInfo[ E_PLAYER_DATA ];

		// Load Accounts
		cache_get_value_name_int(0, "sqlid"			, loadInfo[ pSQLID ]);
		cache_get_value_name_int(0, "playaSkin"		, loadInfo[ pSkin ]);
		cache_get_value_name_int(0, "sex"			, loadInfo[ pSex ]);
		cache_get_value_name_int(0, "age"			, loadInfo[ pAge ]);
		cache_get_value_name_int(0, "jailed"		, loadInfo[ pJailed ]);
		cache_get_value_name_int(0, "jailtime"		, loadInfo[ pJailTime ]);
		cache_get_value_name_int(0, "arrested"		, loadInfo[ pArrested ]);
		cache_get_value_name_int(0, "carlic"		, loadInfo[ pCarLic ]);
		cache_get_value_name_int(0, "gunlic"		, loadInfo[ pGunLic ]);
		cache_get_value_name_int(0, "boatlic"		, loadInfo[ pBoatLic ]);
		cache_get_value_name_int(0, "fishlic"		, loadInfo[ pFishLic ]);
		cache_get_value_name_int(0, "flylic"		, loadInfo[ pFlyLic ]);
		cache_get_value_name(0, "look", loadInfo[ pLook ]);
		
		// Load House Key
		foreach(new house : Houses)
		{
			if(HouseInfo[house][hOwnerID] == loadInfo[ pSQLID ]) {
				loadInfo[pHouseKey] = house;
				break;
			}
		}
		
		new
			mdcString[ 512 ],
			mdcString2[ 2048 ],
			tmpString[ 64 ],
			tmpAddress[ 32 ],
			tmpLook[60],
			tmpLook2[60],
			tmpGunLic[12];
			
		( loadInfo[ pHouseKey ] != INVALID_HOUSE_ID ) && format(tmpAddress, 32, HouseInfo[ loadInfo[ pHouseKey ] ][ hAdress ] ) || format(tmpAddress, 32, "N/A");
		if(strlen(loadInfo[ pLook ]) > 60)
		{
			format(tmpLook, sizeof(tmpLook), "%.60s", loadInfo[ pLook ]);
			format(tmpLook2, sizeof(tmpLook2), "%s", loadInfo[ pLook ][60]);
		}
		else
		{
			format(tmpLook, sizeof(tmpLook), "%s", loadInfo[ pLook ]);
			format(tmpLook2, sizeof(tmpLook2), "\n", loadInfo[ pLook ][60]);
		}
		tmpGunLic = (loadInfo[ pGunLic ] == 1) ? ("~b~CCW~l~") : ((loadInfo[ pGunLic ] == 2) ? ("~g~CCW~l~") : ("~r~No~l~"));
		format(mdcString, sizeof(mdcString),
			"Profile: %s~n~Address: %s~n~Sex: %s~n~Age: %d~n~~g~Desc.:~l~ ~n~%s~n~%s~n~",
			playername,
			tmpAddress,
			loadInfo[ pSex ] == 1 ? ("~h~~b~Male~l~") : ("~h~~p~Female~l~"),
			loadInfo[ pAge ],
			tmpLook,
			tmpLook2
		);
		
		format(mdcString2, sizeof(mdcString2),
			"~b~CURRENT STATUS~l~~n~Jailed: %s~n~Jail time: %d h~n~Arrested: %d~n~~n~~b~LICENSES~l~~n~Drivers: %s~n~Weapon: %s~n~Boat: %s~n~Fish: %s~n~Pilot: %s",
			loadInfo[ pJailed ] == 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
			loadInfo[ pJailTime ],
			loadInfo[ pArrested ],
			loadInfo[ pCarLic ]  >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
			tmpGunLic,
			loadInfo[ pBoatLic ] >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
			loadInfo[ pFishLic ] >= 1 ? ("~g~Yes~l~") : ("~r~No~l~"),
			loadInfo[ pFlyLic ]  >= 1 ? ("~g~Yes~l~") : ("~r~No~l~")
		);
			
		CreateMDCTextDraws(playerid, loadInfo[ pSkin ], false);
		PlayerTextDrawSetString(playerid, MDCProfileText[playerid], mdcString);
		PlayerTextDrawSetString(playerid, MDCOtherText[playerid], mdcString2);
		format(tmpString, 64, "MDC_PROFILE-_%s", playername);
		PlayerTextDrawSetString(playerid, MDCHeader[playerid], tmpString);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnPlayerMDCLoad, "");
	return 1;
}

stock static OnPlayerArrestDataLoad(playerid, const playername[])
{
	new mysqlQuery[128];
	
	format(mysqlQuery, 128, "SELECT * FROM jail WHERE `suspect` = '%e'", playername);
	inline OnArrestLoad()
	{
		new 
			tmpJail[ E_JAIL_DATA ],
			buffer[ 2048 ],
			tmp[ 32 ];
		format(buffer, sizeof(buffer), "~g~ID_-_OFFICER_-_REASON_-_TIME_-_DATE~n~~l~");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", tmpJail[ jSQLID ]);
			cache_get_value_name(i,"policeman"	, tmp, sizeof(tmp));
			format( tmpJail[ jPoliceName ], MAX_PLAYER_NAME, tmp );
			cache_get_value_name(i,"reason"	, tmp, sizeof(tmp));
			format( tmpJail[ jReason ], MAX_PLAYER_NAME, tmp );
			cache_get_value_name_int(i, "jailtime", tmpJail[ jTime ]);

			cache_get_value_name(i, "date" , tmp, sizeof(tmp));
			format( tmpJail[ jDate ], 30, tmp );
			
			format(buffer, sizeof(buffer), "%s#%d_-_%s_-_%s_-_%d_-_%s~n~", 
				buffer,
				tmpJail[ jSQLID ],
				tmpJail[ jPoliceName ],
				tmpJail[ jReason ],
				tmpJail[ jTime ],
				tmpJail[ jDate ]
			);
		}
		if(!cache_num_rows()) 
			format(buffer, sizeof(buffer), "~g~There_are_no_criminal_records!");
		new
			tmpString[ 64 ];

		UpdateMDCTextDraws(playerid);
		format(tmpString, 64, "CRIMINAL_RECORD", playername);
		PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnArrestLoad, "");
	return 1;
}

// PLAYER TICKETS
stock static OnPlayerTicketsLoad(playerid, const playername[])
{
	new mysqlQuery[128];
	
	format(mysqlQuery, 128, "SELECT * FROM tickets WHERE `primatelj` = '%e' LIMIT 10", playername);
	inline OnTicketsLoad()
	{
		new 
			tmpID,
			tmpOfficer[MAX_PLAYER_NAME],
			tmpRazlog[32],
			tmpNovac,
			tmpDatum[30],
			buffer[ 2048 ],
			tmp[ 32 ];
			
		format(buffer, sizeof(buffer), "~g~ID_-_OFFICER_-_REASON_-_MONEY_-_DATE~n~~l~");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", tmpID);
			
			cache_get_value_name(i,"officer"	, tmp, sizeof(tmp));
			format( tmpOfficer, MAX_PLAYER_NAME, tmp );
			
			cache_get_value_name(i,"razlog"	, tmp, sizeof(tmp));
			format( tmpRazlog, 32, tmp );

			cache_get_value_name_int(i, "novac", tmpNovac);

			cache_get_value_name(i, "datum" , tmp, sizeof(tmp));
			format( tmpDatum, 30, tmp );
			
			format(buffer, sizeof(buffer), "%s#%d_-_%s_-_%s_-_%d_-_%s~n~", 
				buffer,
				tmpID,
				tmpOfficer,
				tmpRazlog,
				tmpNovac,
				tmpDatum
			);		
		}
		if(!cache_num_rows()) 
			format(buffer, sizeof(buffer), "~g~There_are_no_traffic_tickets!");
		new
			tmpString[ 32 ];

		UpdateMDCTextDraws(playerid);
		format(tmpString, 32, "PERSONAL_TRAFFIC_TICKETS", playername);
		PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnTicketsLoad, "");
	return 1;
}

// PLAYER VEHS
stock static OnPlayerCoVehsLoad(playerid, playersqlid)
{
	new mysqlQuery[128];
	format(mysqlQuery, 128, "SELECT * FROM cocars WHERE `ownerid` = '%d' AND numberplate != '' AND numberplate != '0' LIMIT 10", playersqlid);
	inline OnCoVehicleLoad()
	{
		new 
			tmpModelID,
			tmpNumberPlate[ 8 ],
			tmpColor1,
			tmpColor2,
			tmpImpounded,
			buffer[ 2048 ],
			vehName[ 32 ],
			tmp[ 32 ],
			VehModel[ 32 ];
		format(buffer, sizeof(buffer), "~g~MODEL_-_PLATES_-_COL1_-_COL2_-_IMPOUNDED~n~~l~");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "modelid", tmpModelID);
			
			cache_get_value_name(i,"numberplate", tmp, sizeof(tmp));
			format( tmpNumberPlate, sizeof(tmp), tmp );
		
			cache_get_value_name_int(i, "color1", tmpColor1);
			cache_get_value_name_int(i, "color2", tmpColor2);
			cache_get_value_name_int(i, "impounded", tmpImpounded);
			
			strunpack(vehName, Model_Name(tmpModelID) );
			format(VehModel, sizeof(VehModel), "%s", vehName);
			format(buffer, sizeof(buffer), "%s#_%s_-_~b~%s~l~_-_%d_-_%d_-_%s~n~", 
				buffer,
				VehModel,
				tmpNumberPlate,
				tmpColor1,
				tmpColor2,
				tmpImpounded ? ("~g~Yes~l~") : ("~r~No~l~")
			);	
			
		}
		if(!cache_num_rows()) 
			format(buffer, sizeof(buffer), "~g~There_are_no_CO-Vehicles!");
		new
			tmpString[ 64 ];

		UpdateMDCTextDraws(playerid);
		format(tmpString, 64, "CO-VEHICLES_LIST");
		PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnCoVehicleLoad, "");
	return 1;
}
// Player APB load
stock static OnPlayerAPBLoad(playerid, const playername[])
{
	new mysqlQuery[128];
	
	format(mysqlQuery, 128, "SELECT * FROM apb WHERE `suspect` = '%e'", playername);
	inline OnAPBLoad()
	{
		new 
			aSqlId,
			aPDname[MAX_PLAYER_NAME],
			aDiscription[57],
			aType,
			buffer[ 2048 ],
			tmp[ 64 ];
		format(buffer, sizeof(buffer), "~r~ID_-_OFFICER_-_DESCRIPTION_-_CAUTION~n~~l~");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", aSqlId);
			
			cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
			format( aPDname, MAX_PLAYER_NAME, tmp );
			
			cache_get_value_name(i,"description"	, tmp, sizeof(tmp));
			format( aDiscription, 57, tmp );
			
			cache_get_value_name_int(i, "type", aType);
			
			if(!cache_num_rows()) 
				format(buffer, sizeof(buffer), "~g~Person_is_not_wanted!");
			else format(buffer, sizeof(buffer), "%s#%d_-_%s_-_%s_-_%s~n~", 
				buffer,
				aSqlId,
				aPDname,
				aDiscription,
				GetAPBType(aType)
			);
		}
		new
			tmpString[ 64 ];

		UpdateMDCTextDraws(playerid);
		format(tmpString, 64, "ALL_POINTS_BULLETIN", playername);
		PlayerTextDrawSetString(playerid, MDCText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCOtherText[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnAPBLoad, "");
	return 1;
}

// GLOBAL VEHICLE
stock static GetVehicleMDCInfo(playerid, vehicleid)
{
	new
		mdcString[ 512 ],
		mdcString2[ 2048 ],
		VehOwner[MAX_PLAYER_NAME],
		tmpString[ 32 ];
	
	if(strlen(VehicleInfo[ vehicleid ][ vNumberPlate ]) > 1)
		format( VehOwner, sizeof(VehOwner), GetPlayerNameFromSQL(VehicleInfo[ vehicleid ][ vOwnerID ]));
	else
		format( VehOwner, sizeof(VehOwner), "Unknown");
		
	strunpack(tmpString, Model_Name(GetVehicleModel(vehicleid)) );
	format(tmpString, 32, "%s", tmpString);
	
	format( mdcString, sizeof(mdcString), "Model: %s~n~Plates_number: %s~n~Owner: %s~n~Colors: %d %d~n~Impounded: %s",
		tmpString,
		VehicleInfo[ vehicleid ][ vNumberPlate ],
		VehOwner,
		VehicleInfo[ vehicleid ][ vColor1 ],
		VehicleInfo[ vehicleid ][ vColor2 ],
		VehicleInfo[ vehicleid ][ vImpounded ] ? ("~g~Yes~l~") : ("~r~No~l~")

	);
	
	format( mdcString2, sizeof(mdcString2), 
		"Ticket #1: %s - %d$~n~ Ticket #2: %s - %d$~n~ Ticket #3: %s - %d$~n~ Ticket #4: %s - %d$~n~ Ticket #5: %s - %d$",
		VehicleInfo[ vehicleid ][ vTicketsReason ][ 0 ],
		VehicleInfo[ vehicleid ][ vTickets ][ 0 ],
		VehicleInfo[ vehicleid ][ vTicketsReason ][ 1 ],
		VehicleInfo[ vehicleid ][ vTickets ][ 1 ],
		VehicleInfo[ vehicleid ][ vTicketsReason ][ 2 ],
		VehicleInfo[ vehicleid ][ vTickets ][ 2 ],
		VehicleInfo[ vehicleid ][ vTicketsReason ][ 3 ],
		VehicleInfo[ vehicleid ][ vTickets ][ 3 ],
		VehicleInfo[ vehicleid ][ vTicketsReason ][ 4 ],
		VehicleInfo[ vehicleid ][ vTickets ][ 4 ]
	);

	SelectTextDraw(playerid, 0x427AF4FF);
	CreateMDCTextDraws(playerid, GetVehicleModel(vehicleid), false);
	
	/* PlayerTextDrawSetPreviewRot(playerid, MDCSkin[playerid], -15.0, 0.0, 0.0);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCSkin[playerid], VehicleInfo[ vehicleid ][ vColor1 ], VehicleInfo[ vehicleid ][ vColor2 ]); */
	PlayerTextDrawSetString(playerid, MDCHeader[playerid], "MDC_VEHICLE_CHECK");
	PlayerTextDrawSetString(playerid, MDCProfileText[playerid], mdcString);
	PlayerTextDrawSetString(playerid, MDCText2[playerid], "TICKETS_LIST");
	PlayerTextDrawSetString(playerid, MDCOtherText[playerid], mdcString2);
	return 1;
}


// Stocks
stock InsertPlayerMDCCrime(playerid, giveplayerid, reason[], jailtime)
{
	format( JailInfo[ giveplayerid ][ jSuspectName ], MAX_PLAYER_NAME, GetName(giveplayerid, false) );
	format( JailInfo[ giveplayerid ][ jPoliceName ] , MAX_PLAYER_NAME, GetName(playerid, false) );
	format( JailInfo[ giveplayerid ][ jReason ], 24, reason ); 
	JailInfo[ giveplayerid ][ jTime ] = jailtime;
	
	new
		Day, Month, Year, Hours, Mins, Secs;
	
	getdate(Year, Month, Day);
	gettime(Hours, Mins, Secs);
	
	format( JailInfo[ giveplayerid ][ jDate ], 32, "%02d/%02d/%d, %02d:%02d:%02d", 
		Day, 
		Month, 
		Year,
		Hours,
		Mins,
		Secs
	);
	
	new
		tmpQuery[ 512 ];
	mysql_tquery(g_SQL, "BEGIN");
	
	format(tmpQuery, sizeof(tmpQuery), "INSERT INTO `jail` (`suspect`, `policeman`, `reason`, `jailtime`, `date`) VALUES ('%e', '%e', '%e', '%d', '%e')",
		JailInfo[ giveplayerid ][ jSuspectName ],
		JailInfo[ giveplayerid ][ jPoliceName ],
		JailInfo[ giveplayerid ][ jReason ],
		JailInfo[ giveplayerid ][ jTime ],
		JailInfo[ giveplayerid ][ jDate ]
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	mysql_tquery(g_SQL, "COMMIT");
}

stock static DeletePlayerMDCCrime(playerid, sqlid) 
{
	new
		destroyQuery[ 256 ];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM jail WHERE `id` = '%d'", sqlid);
	mysql_tquery(g_SQL, destroyQuery, "");
	va_SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Uspjesno ste obrisali dosje #%d!", sqlid);
}

stock static InsertAPBInfo(playerid, const suspect[], const description[], type)
{
	new
		tmpQuery[ 256 ];
	format(tmpQuery, 256, "INSERT INTO `apb`(`suspect`, `description`, `type`, `pdname`) VALUES ('%e','%e','%d','%e')",
		suspect,
		description,
		type,
		GetName(playerid, true)
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

stock static RemoveAPBInfo(sqlid)
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "DELETE FROM apb WHERE id = '%d' LIMIT 1",
		sqlid
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	return 1;
}

stock static GetAPBType(type)
{
	new
		string[ 26 ];
	switch(type) {
		case 1: format(string, 26, "Ne naoruzan i nije opasan");
		case 2: format(string, 26, "Srednje opasan");
		case 3: format(string, 26, "Naoruzan i opasan");
		default: format(string, 26, "None");
	}
	return string;
}

stock GetPlayerMDCRecord(playerid, const playername[])
{
	new 
		tmpJail[ E_JAIL_DATA ],
		buffer[ 1024 ],
		tmp[ 32 ],
		mysqlQuery[ 128 ];
	
	format(mysqlQuery, 256, "SELECT * FROM jail WHERE `suspect` = '%e'", playername);
		
	inline OnSuspectLoad() {		
		format(buffer, sizeof(buffer), "{A4BDDE}ID | IME/PREZIME | OFFICER | RAZLOG | VRIJEME KAZNE | DATUM UHICENJA"COL_WHITE"\n");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", tmpJail[ jSQLID ]);
			cache_get_value_name(i,"suspect"	, tmp, sizeof(tmp));
			format( tmpJail[ jSuspectName ], MAX_PLAYER_NAME, tmp );
			
			cache_get_value_name(i,"policeman"	, tmp, sizeof(tmp));
			format( tmpJail[ jPoliceName ], MAX_PLAYER_NAME, tmp );

			cache_get_value_name(i,"reason"	, tmp, sizeof(tmp));
			format( tmpJail[ jReason ], MAX_PLAYER_NAME, tmp );
			cache_get_value_name_int(i, "jailtime", tmpJail[ jTime ]);

			cache_get_value_name(i, "date" , tmp, sizeof(tmp));
			format( tmpJail[ jDate ], 30, tmp );
			
			format(buffer, sizeof(buffer), "%s#%d | %s | %s | %s | %d | %s\n", 
				buffer,
				tmpJail[ jSQLID ],
				tmpJail[ jSuspectName ],
				tmpJail[ jPoliceName ],
				tmpJail[ jReason ],
				tmpJail[ jTime ],
				tmpJail[ jDate ]
			);		
		}
		
		new tmpString[ 64 ];
		format(tmpString, 64, "%s-DOSJE", tmpJail[ jSuspectName ]);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, tmpString, buffer, "Close", "");
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnSuspectLoad, "");
	return 1;
}

stock static UpdateMDCTextDraws(playerid)
{
	DestroyUpdatedMDCTextDraws(playerid);
	
	MDCOtherText[playerid] = CreatePlayerTextDraw(playerid, 165.333343, 201.888565, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCOtherText[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawColor(playerid, MDCOtherText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCOtherText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCOtherText[playerid], 255);
	PlayerTextDrawFont(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawShow(playerid, MDCOtherText[playerid]);
	
	MDCText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
	PlayerTextDrawLetterSize(playerid, MDCText2[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCText2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCText2[playerid], 35071);
	PlayerTextDrawSetShadow(playerid, MDCText2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCText2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCText2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCText2[playerid], 1);
	PlayerTextDrawShow(playerid, MDCText2[playerid]);
}

stock static DestroyUpdatedMDCTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, MDCOtherText[ playerid ] );
	MDCOtherText[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCText2[ playerid ] );
	MDCText2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
}

stock DestroyMDCTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, MDCBg1[ playerid ] );
	MDCBg1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCBg2[ playerid ] );
	MDCBg2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCHeader[ playerid ] );
	MDCHeader[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCSkin[ playerid ] );
	MDCSkin[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCText1[ playerid ] );
	MDCText1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCText2[ playerid ] );
	MDCText2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCOtherText[ playerid ] );
	MDCOtherText[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCProfileText[ playerid ] );
	MDCProfileText[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCRecordButton[ playerid ] );
	MDCRecordButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCVehButton[ playerid ] );
	MDCVehButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCTicketsButton[ playerid ] );
	MDCTicketsButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCGeneralButton[ playerid ] );
	MDCGeneralButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCAPBButton[ playerid ] );
	MDCAPBButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCloseButton[ playerid ] );
	MDCCloseButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
}

stock static CreateMDCTextDraws(playerid, skin, bool:type=false)
{
	DestroyMDCTextDraws(playerid);
	
	MDCBg1[playerid] = CreatePlayerTextDraw(playerid, 158.999938, 60.162940, "blue_bg");
	PlayerTextDrawLetterSize(playerid, MDCBg1[playerid], 0.000000, 37.633335);
	PlayerTextDrawTextSize(playerid, MDCBg1[playerid], 466.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCBg1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCBg1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCBg1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCBg1[playerid], 9471);
	PlayerTextDrawSetShadow(playerid, MDCBg1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCBg1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCBg1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCBg1[playerid], 1);
	PlayerTextDrawShow(playerid, MDCBg1[playerid]);

	MDCHeader[playerid] = CreatePlayerTextDraw(playerid, 309.599945, 64.966629, "POLICE_MDC");
	PlayerTextDrawLetterSize(playerid, MDCHeader[playerid], 0.326332, 1.376001);
	PlayerTextDrawTextSize(playerid, MDCHeader[playerid], 0.000000, 101.000000);
	PlayerTextDrawAlignment(playerid, MDCHeader[playerid], 2);
	PlayerTextDrawColor(playerid, MDCHeader[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCHeader[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCHeader[playerid], 255);
	PlayerTextDrawFont(playerid, MDCHeader[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCHeader[playerid], 1);
	PlayerTextDrawShow(playerid, MDCHeader[playerid]);

	MDCBg2[playerid] = CreatePlayerTextDraw(playerid, 163.266708, 86.481460, "box");
	PlayerTextDrawLetterSize(playerid, MDCBg2[playerid], 0.000000, 34.100013);
	PlayerTextDrawTextSize(playerid, MDCBg2[playerid], 461.599975, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCBg2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCBg2[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCBg2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCBg2[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCBg2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCBg2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCBg2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCBg2[playerid], 1);
	PlayerTextDrawShow(playerid, MDCBg2[playerid]);

	MDCSkin[playerid] = CreatePlayerTextDraw(playerid, 165.566406, 89.277763, "");
	PlayerTextDrawTextSize(playerid, MDCSkin[playerid], 84.679931, 95.000000);
	PlayerTextDrawAlignment(playerid, MDCSkin[playerid], 1);
	PlayerTextDrawColor(playerid, MDCSkin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCSkin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCSkin[playerid], -2139062017);
	PlayerTextDrawFont(playerid, MDCSkin[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDCSkin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCSkin[playerid], skin);
	PlayerTextDrawSetPreviewRot(playerid, MDCSkin[playerid], 0.000000, 0.000000, 20.000000, 0.899999);
	PlayerTextDrawShow(playerid, MDCSkin[playerid]);

	MDCText1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 87.833366, "PROFILE");
	PlayerTextDrawLetterSize(playerid, MDCText1[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCText1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCText1[playerid], 35071);
	PlayerTextDrawSetShadow(playerid, MDCText1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCText1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCText1[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCText1[playerid], 1);
	PlayerTextDrawShow(playerid, MDCText1[playerid]);

	MDCProfileText[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 100.133178, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCProfileText[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCProfileText[playerid], 1);
	PlayerTextDrawColor(playerid, MDCProfileText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCProfileText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCProfileText[playerid], 255);
	PlayerTextDrawFont(playerid, MDCProfileText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCProfileText[playerid], 1);
	PlayerTextDrawShow(playerid, MDCProfileText[playerid]);

	MDCText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
	PlayerTextDrawLetterSize(playerid, MDCText2[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCText2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCText2[playerid], 35071);
	PlayerTextDrawSetShadow(playerid, MDCText2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCText2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCText2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCText2[playerid], 1);
	PlayerTextDrawShow(playerid, MDCText2[playerid]);

	MDCOtherText[playerid] = CreatePlayerTextDraw(playerid, 165.333343, 201.888565, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCOtherText[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawColor(playerid, MDCOtherText[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCOtherText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCOtherText[playerid], 255);
	PlayerTextDrawFont(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCOtherText[playerid], 1);
	PlayerTextDrawShow(playerid, MDCOtherText[playerid]);
	
	if (!type)
	{
		MDCRecordButton[playerid] = CreatePlayerTextDraw(playerid, 195.566970, 382.118652, "CRIMINAL_RECORD");
		PlayerTextDrawLetterSize(playerid, MDCRecordButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCRecordButton[playerid], 18.000000, 63.000000);
		PlayerTextDrawAlignment(playerid, MDCRecordButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCRecordButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCRecordButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCRecordButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCRecordButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCRecordButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCRecordButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCRecordButton[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, MDCRecordButton[playerid], true);
		PlayerTextDrawShow(playerid, MDCRecordButton[playerid]);

		MDCVehButton[playerid] = CreatePlayerTextDraw(playerid, 250.234573, 382.108551, "VEHICLES");
		PlayerTextDrawLetterSize(playerid, MDCVehButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCVehButton[playerid], 18.000000, 35.000000);
		PlayerTextDrawAlignment(playerid, MDCVehButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCVehButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCVehButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCVehButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCVehButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCVehButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCVehButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCVehButton[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, MDCVehButton[playerid], true);
		PlayerTextDrawShow(playerid, MDCVehButton[playerid]);

		MDCTicketsButton[playerid] = CreatePlayerTextDraw(playerid, 304.066436, 382.157867, "TRAFFIC_TICKETS");
		PlayerTextDrawLetterSize(playerid, MDCTicketsButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCTicketsButton[playerid], 18.000000, 62.000000);
		PlayerTextDrawAlignment(playerid, MDCTicketsButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCTicketsButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCTicketsButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCTicketsButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCTicketsButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCTicketsButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCTicketsButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCTicketsButton[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, MDCTicketsButton[playerid], true);
		PlayerTextDrawShow(playerid, MDCTicketsButton[playerid]);
		
		MDCGeneralButton[playerid] = CreatePlayerTextDraw(playerid, 357.269683, 382.157867, "GENERAL");
		PlayerTextDrawLetterSize(playerid, MDCGeneralButton[playerid], 0.178000, 1.139554);
		PlayerTextDrawTextSize(playerid, MDCGeneralButton[playerid], 18.000000, 34.000000);
		PlayerTextDrawAlignment(playerid, MDCGeneralButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCGeneralButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCGeneralButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCGeneralButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCGeneralButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCGeneralButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCGeneralButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCGeneralButton[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, MDCGeneralButton[playerid], true);
		PlayerTextDrawShow(playerid, MDCGeneralButton[playerid]);
		
		MDCAPBButton[playerid] = CreatePlayerTextDraw(playerid, 391.271759, 382.157867, "APB");
		PlayerTextDrawLetterSize(playerid, MDCAPBButton[playerid], 0.178000, 1.139554);
		PlayerTextDrawTextSize(playerid, MDCAPBButton[playerid], 18.000000, 24.000000);
		PlayerTextDrawAlignment(playerid, MDCAPBButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCAPBButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCAPBButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCAPBButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCAPBButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCAPBButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCAPBButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCAPBButton[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, MDCAPBButton[playerid], true);
		PlayerTextDrawShow(playerid, MDCAPBButton[playerid]);
	}
	
	MDCCloseButton[playerid] = CreatePlayerTextDraw(playerid, 449.633178, 381.828002, "CLOSE");
	PlayerTextDrawLetterSize(playerid, MDCCloseButton[playerid], 0.178000, 1.139555);
	PlayerTextDrawTextSize(playerid, MDCCloseButton[playerid], 18.000000, 22.000000);
	PlayerTextDrawAlignment(playerid, MDCCloseButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCloseButton[playerid], -2147483393);
	PlayerTextDrawUseBox(playerid, MDCCloseButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCloseButton[playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, MDCCloseButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCloseButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCloseButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCloseButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MDCCloseButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCloseButton[playerid]);
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

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(_:playertextid != INVALID_TEXT_DRAW) {
		if( playertextid == MDCCloseButton[playerid] ) {
			DestroyMDCTextDraws(playerid);
			CancelSelectTextDraw(playerid);
		}
		if( playertextid == MDCGeneralButton[playerid] ) {
			OnPlayerMDCDataLoad(playerid, TargetName[playerid]);
		}
		if( playertextid == MDCTicketsButton[playerid] ) {
			OnPlayerTicketsLoad(playerid, TargetName[playerid]);
		}
		if( playertextid == MDCAPBButton[playerid] ) {
			OnPlayerAPBLoad(playerid, TargetName[playerid]);
		}
		if( playertextid == MDCVehButton[playerid] ) { // Mora od upisanog imena izvuci SQLID jer spremanje nije po imenu
			new 
				Cache:result,
				//counts,
				player_sqlid,
				sqlstring[128];
	
			format(sqlstring, sizeof(sqlstring), "SELECT sqlid FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", TargetName[playerid]);
			result = mysql_query(g_SQL, sqlstring);
			//counts = cache_num_rows();
			cache_get_value_name_int(0, "sqlid"	, player_sqlid);
			cache_delete(result);
			//if( !counts ) return 1;	
			OnPlayerCoVehsLoad(playerid, player_sqlid);
		}
		if( playertextid == MDCRecordButton[playerid] ) {
			OnPlayerArrestDataLoad(playerid, TargetName[playerid]);
		}
	}
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_MDC_MAIN: {
			if(!response) return 1;
			
			switch(listitem) {
				case 0: // Player
					ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "MDC - PERSON", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
				case 1: // Vehicle
					ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Da biste dobili vehicleid koristite komandu /dl!", "Input", "Abort");
				case 2: // Dosije
					ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_LIST, "MDC - DOSJE", "Provjera dosjea\nObrisi dosje", "Choose", "Abort");
				case 3: // Kazne
					ShowPlayerDialog(playerid, DIALOG_MDC_TICKET, DIALOG_STYLE_LIST, "MDC - TICKET", "Provjera kazni\nObrisi kaznu", "Choose", "Abort");
			}
			
			return 1;
		}
		case DIALOG_MDC_PLAYER: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
			
			if( strfind(inputtext, "_", true) == -1 ) return ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
			format(TargetName[playerid], 24, "%s", inputtext);
			OnPlayerMDCDataLoad(playerid, TargetName[playerid]);			
			return 1;
		}
		case DIALOG_MDC_VEHICLE: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
			
			if( 1 <= strval(inputtext) <= MAX_VEHICLES ) {
				if( !Iter_Contains(COVehicles, strval(inputtext)) ) return ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Vozilo mora biti CO!", "Input", "Abort");
				GetVehicleMDCInfo(playerid, strval(inputtext));
			} else ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Da biste dobili vehicleid koristite komandu /dl!", "Input", "Abort");
			return 1;
		}
		case DIALOG_MDC_RECORD: {
			if( !response ) return 1;
			switch(listitem) {
				case 0: {	// Provjera
					ShowPlayerDialog(playerid, DIALOG_MDC_CRECORD, DIALOG_STYLE_INPUT, "MDC - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
				}
				case 1: { // Brisanje
					if( PlayerInfo[ playerid ][ pRank ] < 4 ) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Samo PD officeri rank 4+ mogu ovdje!");
					ShowPlayerDialog(playerid, DIALOG_MDC_DRECORD_ID, DIALOG_STYLE_INPUT, "MDC - PLAYER", "Unesite ID dosjea kojeg zelite obrisati:", "Input", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_MDC_CRECORD: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
			if( 1 <= strlen( inputtext ) <= MAX_PLAYER_NAME ) {
				if( strfind(inputtext, "_", true) == -1 ) return ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort"); 
				GetPlayerMDCRecord(playerid, inputtext);
			} else ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort"); 
			return 1;
		}
		case DIALOG_MDC_DRECORD_ID: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_RECORD, DIALOG_STYLE_LIST, "MDC - PLAYER", "Provjera dosjea\nObrisi dosje", "Choose", "Abort");
			DeletingRecordID[ playerid ] = strval(inputtext);
			va_ShowPlayerDialog(playerid, DIALOG_MDC_DRECORD, DIALOG_STYLE_MSGBOX, "MDC - PLAYER", "Zelite li obrisati dosje ID %d?", "Da", "Ne", DeletingRecordID[ playerid ]);
			return 1;
		}
		case DIALOG_MDC_DRECORD: {
			if( !response ) return 1;
			DeletePlayerMDCCrime(playerid, DeletingRecordID[ playerid ]);
			return 1;
		}
		//kazne
		case DIALOG_MDC_TICKET: {
			if( !response ) return 1;
			switch(listitem) {
				case 0: {	// Provjera
					ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
				}
				case 1: { // Brisanje
					if( PlayerInfo[ playerid ][ pRank ] < 4 ) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Samo PD officeri rank 4+ mogu ovdje!");
					ShowPlayerDialog(playerid, DIALOG_MDC_DTICKET_ID, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ID dosjea kojeg zelite obrisati:", "Input", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_MDC_CTICKET: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
			if( 1 <= strlen( inputtext ) <= MAX_PLAYER_NAME ) {
				if( strfind(inputtext, "_", true) == -1 ) return ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "MDC - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort"); 
				LoadPlayerTicket(playerid, inputtext);
			} else ShowPlayerDialog(playerid, DIALOG_MDC_CTICKET, DIALOG_STYLE_INPUT, "Mobile Data Computer - TICKET", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort"); 
			return 1;
		}
		case DIALOG_MDC_DTICKET_ID: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_MDC_TICKET, DIALOG_STYLE_LIST, "MDC - TICKET", "Provjera kazni\nObrisi kaznu", "Choose", "Abort");
			DeletingTicketID[ playerid ] = strval(inputtext);
			va_ShowPlayerDialog(playerid, DIALOG_MDC_DTICKET, DIALOG_STYLE_MSGBOX, "MDC - TICKET", "Zelite li obrisati ticket ID %d?", "Da", "Ne", DeletingTicketID[ playerid ]);
			return 1;
		}
		case DIALOG_MDC_DTICKET: {
			if( !response ) return 1;
			DeletePlayerTicket(playerid, DeletingTicketID[playerid]);
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
CMD:mdc(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendClientMessage( playerid, COLOR_RED, "[GRESKA]: Niste policajac!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if( vehicleid == INVALID_VEHICLE_ID ) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Niste unutar sluzbenog vozila!");
	ShowPlayerDialog(playerid, DIALOG_MDC_MAIN, DIALOG_STYLE_LIST, "Mobile Data Computer - HOME", "Pretrazi osobu\nPretrazi vozilo\nProvjera dosjea\nProvjera kazni", "Choose", "Abort");
	return 1;
}

CMD:apb(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) )	return SendClientMessage( playerid, COLOR_RED, "[GRESKA]: Niste policajac!" );
	new vehicleid = GetPlayerVehicleID(playerid);
	if( vehicleid == INVALID_VEHICLE_ID ) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Niste unutar sluzbenog vozila!");
	
	new
		pick[ 7 ],
		suspect[24],
		desc[57],
		type;
	if( sscanf( params, "s[7] ", pick ) ) return SendClientMessage( playerid, -1, "KORISTENJE /apb [add / delete / list]" );
	if( !strcmp(pick, "add", true) ) 
	{
		if( sscanf( params, "s[7]is[24]s[57]", pick, type, suspect, desc ) )
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTI: /apb add [tip 1/2/3] [Ime_Prezime] [PenalCode-Zlocin]");
			SendClientMessage(playerid, COLOR_WHITE, "Tip: 1. Ne naoruzan i nije opasan | 2. Srednje opasan | 3. Naoruzan i opasan");
			return 1;
		}
		if( 1 <= strlen( suspect ) <= MAX_PLAYER_NAME )
		{
			if( strfind(suspect, "_", true) == -1 ) return SendClientMessage(playerid, COLOR_RED, "NAPOMENA: Mora biti s znakom '_'! ");
			InsertAPBInfo(playerid, suspect, desc, type);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "*** APB RECORD ADDED ***");
			va_SendClientMessage(playerid, COLOR_WHITE, "Name: %s", suspect);
			va_SendClientMessage(playerid, COLOR_WHITE, "Type: %s", GetAPBType(type));
			va_SendClientMessage(playerid, COLOR_WHITE, "Description: %s", desc);
			// salje radio message
			new string[128];
			format(string, sizeof(string), "** [HQ] ** APB ** %s je dodao APB zapis na %s **" , GetName(playerid,true), suspect);
			SendRadioMessage(PlayerInfo[playerid][pMember], TEAM_YELLOW_COLOR, string);
		}
	}
	else if( !strcmp(pick, "delete", true) ) {
	
		new
			sqlid;
		if( sscanf(params, "s[7]i", pick, sqlid ) ) return SendClientMessage( playerid, -1, "[ ? ]: /apb delete [id]" );
		RemoveAPBInfo(sqlid);
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[APB] Obrisali ste APB slot %d!", sqlid);

	}
	return 1;
}