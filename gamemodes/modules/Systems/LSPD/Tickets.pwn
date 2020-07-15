// Woo ticket system
// enums

enum E_TICKET_DATA
{
	tkID,
	tkPrimatelj[ MAX_PLAYER_NAME ],
	tkOfficer[ MAX_PLAYER_NAME ],
	tkNovac,
	tkRazlog[ 100 ],
	tkDatum[ 30 ]	
}
new
	TicketInfo[ MAX_PLAYERS ][ E_TICKET_DATA ];
	
	
// STOCKS

stock GetVehicleTicketReason(ticketsql)
{
    new
		reason[64],
		Cache:result,
		ticketQuery[ 128 ];

	format(ticketQuery, sizeof(ticketQuery), "SELECT `reason` FROM `cocars_tickets` WHERE `id` = '%d'", ticketsql);
	result = mysql_query(g_SQL, ticketQuery);
	if(result == MYSQL_INVALID_CACHE)
		format(reason, sizeof(reason), "None");
	else
		cache_get_value_index(0, 0, reason);
	cache_delete(result);
	return reason;
}

stock InsertPlayerTicket(playerid, giveplayerid, money, const reason[])
{
	format( TicketInfo[ giveplayerid ][ tkPrimatelj ], MAX_PLAYER_NAME, GetName(giveplayerid, false));
	format( TicketInfo[ giveplayerid ][ tkOfficer ] , MAX_PLAYER_NAME, GetName(playerid, false));
	TicketInfo[ giveplayerid ][ tkNovac ] = money;
	format( TicketInfo[ giveplayerid ][ tkRazlog ],	100, reason);
	
	new Day, Month, Year;
	getdate(Year, Month, Day);
	
	format( TicketInfo[ giveplayerid ][ tkDatum ], 32, "%02d.%02d.%d.", Day, Month, Year);
	
	new tmpQuery[ 512 ];
	mysql_tquery(g_SQL, "BEGIN");
	
	mysql_format(g_SQL, tmpQuery, sizeof(tmpQuery), "INSERT INTO tickets (`primatelj`, `officer`, `novac`, `razlog`, `datum`) VALUES ('%e', '%e', '%d', '%e', '%e')",
		TicketInfo[ giveplayerid ][ tkPrimatelj ],
		TicketInfo[ giveplayerid ][ tkOfficer ],
		TicketInfo[ giveplayerid ][ tkNovac ],
		TicketInfo[ giveplayerid ][ tkRazlog ],
		TicketInfo[ giveplayerid ][ tkDatum ]
	);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si dao kaznu %s! ", TicketInfo[ giveplayerid ][ tkPrimatelj ]);
	mysql_tquery(g_SQL, tmpQuery, "");
	mysql_tquery(g_SQL, "COMMIT");
}

Function: OnVehicleTicketInsert(vehicleid, slot)
{
	VehicleInfo[vehicleid][vTicketsSQLID][slot] = cache_insert_id();
	return 1;
}

stock DeletePlayerTicket(playerid, sqlid) 
{
	new
		destroyQuery[ 256 ];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM tickets WHERE `id` = '%d'", sqlid);
	mysql_tquery(g_SQL, destroyQuery, "");
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] ", sqlid);
	mysql_tquery(g_SQL, "COMMIT");
}

stock LoadVehicleTickets(vehicleid)
{
	new
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `cocars_tickets` WHERE `vehicle_id` = '%d' LIMIT 0,%d",
		VehicleInfo[vehicleid][vSQLID],
		MAX_VEHICLE_TICKETS
	);
	mysql_pquery(g_SQL, tmpQuery, "LoadingVehicleTickets", "i", vehicleid);
	return 1;
}

Function: LoadingVehicleTickets(vehicleid)
{
	#if defined MOD_DEBUG
		printf("DEBUG CAR WEAPONS: count(%d)", cache_num_rows());
	#endif

	if(cache_num_rows()) 
	{
	    for(new i = 0; i < cache_num_rows(); i++) 
		{
			cache_get_value_name_int(i,  "id"			, VehicleInfo[vehicleid][vTicketsSQLID][i]);
			cache_get_value_name_int(i,  "isShown"		, VehicleInfo[vehicleid][vTicketShown][i]);
			cache_get_value_name_int(i,  "price"		, VehicleInfo[vehicleid][vTickets][i]);
			cache_get_value_name_int(i,  "time"		, VehicleInfo[vehicleid][vTicketStamp][i]);
			
			#if defined MOD_DEBUG
				printf("DEBUG CAR TICKETS: i(%d) | sqlid(%d) | isShown(%d) | price(%d) | time(%d)", 
					i, 
					VehicleInfo[vehicleid][vSQLID], 
					VehicleInfo[vehicleid][vTicketShown][i],
					VehicleInfo[vehicleid][vTickets][i],
					VehicleInfo[vehicleid][vTicketStamp][i]
				);
			#endif
		}
	}
	return 1;
}


stock LoadPlayerTickets(playerid, const playername[])
{
	new
		mysqlQuery[ 128 ];
	
	mysql_format(g_SQL, mysqlQuery, 256, "SELECT * FROM tickets WHERE `primatelj` = '%e'", playername);
		
	inline OnTicketLoad() 
	{
		if(!cache_num_rows())
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nikakvih kazni!");
		
		new 
			buffer[ 2048 ],
			tmp[ 128 ],
			motd[ 256 ];
			
		for( new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i, "id", TicketInfo[i][ tkID ]);
			cache_get_value_name(i,"primatelj"	, tmp, sizeof(tmp));
			format( TicketInfo[i][ tkPrimatelj ], MAX_PLAYER_NAME, tmp );
			cache_get_value_name(i,"officer"	, tmp, sizeof(tmp));
			format( TicketInfo[i][ tkOfficer ], MAX_PLAYER_NAME, tmp );
			cache_get_value_name_int(i, "novac", TicketInfo[i][ tkNovac ]);
			cache_get_value_name(i, "razlog", tmp, sizeof(tmp));
			format( TicketInfo[i][ tkRazlog ], 100, tmp );
			cache_get_value_name(i, "datum", tmp, sizeof(tmp));
			format( TicketInfo[i][ tkDatum ], 30, tmp );
			
			format(motd, sizeof(motd), "ID #%d | Datum: %s | Primatelj: %s | Officer: %s | Iznos kazne: %d$ | Razlog: %s\n",
				TicketInfo[i][ tkID ],
				TicketInfo[i][ tkDatum ],
				TicketInfo[i][ tkPrimatelj ],
				TicketInfo[i][ tkOfficer ],
				TicketInfo[i][ tkNovac ],
				TicketInfo[i][ tkRazlog ]
			);
			strcat(buffer, motd, sizeof(buffer));
		}
		new tmpString[64];
		format(tmpString, 64, "[%s - KAZNE]", playername);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, tmpString, buffer, "Zatvori", "");
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnTicketLoad, "");
	return 1;
}

stock ShowVehicleTickets(playerid, vehicleid)
{
	new model = GetVehicleByModel(VehicleInfo[vehicleid][vModel]),
		caption[50],
		motd[256],
		buffer[2048];
		
	for(new i = 0; i < MAX_VEHICLE_TICKETS; i++)
	{
		if(VehicleInfo[vehicleid][vTicketsSQLID][i] != 0)
		{
			format(motd, sizeof(motd), "ID #%d | Iznos kazne: %d$ | Razlog: %s\n",
				(i+1),
				VehicleInfo[vehicleid][vTickets][i],
				GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][i])
			);
			strcat(buffer, motd, sizeof(buffer));
		}
	}
	format(caption, sizeof(caption), "[%s - KAZNE]", LandVehicles[model][viName]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, caption, buffer, "Zatvori", "");
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
CMD:ticket(playerid, params[])
{
	new param[ 12 ], id;
	if( sscanf( params, "s[12] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket [show / vehicleshow / pay / vehiclepay ]");
	
	if( !strcmp(param, "show", true ) )
	{
		LoadPlayerTickets(playerid, GetName(playerid, false));
	}
	if( !strcmp(param, "vehicleshow", true ) )
	{
		new vehicleid;
		if( PlayerInfo[playerid][pSpawnedCar] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano svoje vozilo!");
		vehicleid = PlayerInfo[playerid][pSpawnedCar];
		if( !VehicleInfo[ vehicleid ][ vTickets ][ 0 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 1 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 2 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 3 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 4 ] ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno vozilo nema kazna na sebi!");
		ShowVehicleTickets(playerid, vehicleid);
	}
	if( !strcmp(param, "pay", true ) )
	{
		if( !IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar City Hall-a!");
		if( sscanf( params, "s[12]i", param, id ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ticket pay [ID kazne]");
		
		new 
			ticketsQuery[ 62 ], 
			tmp[64], 
			prima[MAX_PLAYER_NAME], 
			Cache:result;
			
		format(ticketsQuery, 62, "SELECT id, primatelj, novac FROM tickets WHERE id = '%d'", id);
		result = mysql_query(g_SQL, ticketsQuery);
		if(!cache_num_rows()) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate kazne u bazi podataka!");
		
		new ticketId, moneys;	
		cache_get_value_name(0, "primatelj", tmp, sizeof(tmp));
		format(prima, MAX_PLAYER_NAME, tmp );
		cache_get_value_name_int(0, "id"		, ticketId);
		cache_get_value_name_int(0, "novac"		, moneys);
		
		if(!strcmp(prima, GetName(playerid,false),true) && ticketId == id) {
			if(AC_GetPlayerMoney(playerid) < moneys) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca, fali vam %d$.", moneys-AC_GetPlayerMoney(playerid));

			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, moneys); // Novac dolazi u faction bank
			DeletePlayerTicket(playerid, id);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Platili ste kaznu #%d (%d$).", id, moneys);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, " To nije vasa kazna!"); // provjera ima li sta u bazi
		cache_delete(result);
	}
	else if( !strcmp(param, "vehiclepay", true ) ) 
	{
		if( !IsPlayerInRangeOfPoint(playerid, 30.0, 1301.4661, 764.3820, -98.6427) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar City Hall-a!");
		new
			vehicleid, slot;
		if( sscanf( params, "s[12]i", param, slot ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /payticket vehicle [slot (1-5)]");
		if( PlayerInfo[playerid][pSpawnedCar] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate spawnano svoje vozilo!");
		vehicleid = PlayerInfo[playerid][pSpawnedCar];
		if( !VehicleInfo[ vehicleid ][ vTickets ][ 0 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 1 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 2 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 3 ] && !VehicleInfo[ vehicleid ][ vTickets ][ 4 ] ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno vozilo nema kazna na sebi!");
			
		if( 1 <= slot <= 5 ) {
			new
				tmpSlot = slot - 1;
			if( !VehicleInfo[ vehicleid ][ vTickets ][ tmpSlot ] ) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, " U tome slotu nemate kaznu!");
		
			PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, VehicleInfo[ vehicleid ][ vTickets ][ tmpSlot ]); // Novac dolazi u faction bank
			
			va_SendClientMessage(playerid, COLOR_RED, "Sluzbenica: Platili ste kaznu #%d vaseg vozila za %d$.",
				slot,
				VehicleInfo[ vehicleid ][ vTickets ][ tmpSlot ]
			);
			
			// MySQL Query
			new deleteTicketQuery[55];
			format(deleteTicketQuery, 55, "DELETE FROM `cocars_tickets` WHERE `id` = '%d'", VehicleInfo[vehicleid][vTicketsSQLID][tmpSlot]);
			mysql_tquery(g_SQL, deleteTicketQuery, "", "");
			
			// Enum Clear
			VehicleInfo[ vehicleid ][ vTicketsSQLID ][ tmpSlot ] 	= 0;
			VehicleInfo[ vehicleid ][ vTickets ][ tmpSlot ] 		= 0;
			VehicleInfo[ vehicleid ][ vTicketShown ][ tmpSlot ]		= 0;
			VehicleInfo[ vehicleid ][ vTicketStamp ][ tmpSlot ] 	= 0;
		} 
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Slot mora biti izmedju 1 i 5!");
	}
	return 1;
}

CMD:giveticket(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste autorizovani!");
	if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Niste na du�nosti!");
	if( IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti izvan vozila!");
	
	new giveplayerid, pick[8];
		
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket [person/vehicle]");
		
		
	new reason[ 100 ], moneys;
	if( !strcmp(pick, "person", true) )
	{
		if( sscanf( params, "s[8]uis[99]", pick, giveplayerid, moneys, reason ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket person [playerid/dio imena] [novci] [razlog]");
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
		if( !ProxDetectorS(5.0, playerid, giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije blizu vas!");
		if (strlen(reason) >= 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Razlog moze imati max 100 znakova!");
		if (49 > moneys > 20001) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalno 20000$, minimalno 50$!");
		
		InsertPlayerTicket(playerid, giveplayerid, moneys, reason);
		
 		new
			tmpString[ 120 ];
		format(tmpString, sizeof(tmpString), "*[HQ] %s %s je izdao kaznu %s, od %d$ za %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid,false), moneys, reason);
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ]  Officer %s vam je dao kaznu u iznosu od %d$, razlog: %s", GetName(playerid,false), moneys, reason);	
		SendClientMessage(giveplayerid, COLOR_RED, "(( Koristite /ticket za pregled i placanje kazni ))");	
	}
	else if( !strcmp(pick, "vehicle", true) )
	{
		new vehicleid;
		if( sscanf( params, "s[8]iis[64]", pick, vehicleid, moneys, reason ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveticket vehicle [vehicleid ((/DL))][iznos kazne][razlog]");
		if( vehicleid == INVALID_VEHICLE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo nije spawnano! (( ID vozila na /DL! ))");
			
		new
			Float:vx,
			Float:vy,
			Float:vz;
			
		GetVehiclePos(vehicleid, vx, vy, vz);
		
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, vx, vy, vz))
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu vozila!");
			
		if( VehicleInfo[vehicleid][vUsage] != VEHICLE_USAGE_PRIVATE ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Mozete kazniti samo privatna vozila!");
		if( 1 <= strlen(reason) <= 63 ) 
		{
			if( 1 <= moneys <= 10000 ) 
			{
				new
					tkts = -1;
				
				for(new t = 0; t <= 4; ++t)
				{
					if(!VehicleInfo[vehicleid][vTickets][t])
					{
						VehicleInfo[vehicleid][vTickets][t] = moneys;
						VehicleInfo[vehicleid][vTicketShown][t]	= 0;
						VehicleInfo[vehicleid][vTicketStamp][t] = gettime();
					
						// MySQL Query
						new
							ticketInsertQuery[256];
						mysql_format(g_SQL, ticketInsertQuery, 256, "INSERT INTO `cocars_tickets`(`vehicle_id`, `isShown`, `price`, `reason`, `time`) VALUES ('%d','0','%d','%e','%d')",
							VehicleInfo[vehicleid][vSQLID],
							VehicleInfo[vehicleid][vTickets][t],
							reason,
							gettime()
						);
						mysql_tquery(g_SQL, ticketInsertQuery, "OnVehicleTicketInsert", "ii" , vehicleid, t);
						tkts = t;
						break;
					}
				}
				if(tkts != -1)
				{
					new
						tmpString[120];

					format(tmpString, sizeof(tmpString), "*[HQ] %s %s je izdao %d kaznu na vozilo (ID: %d) od %d$ za: %s.", ReturnPlayerRankName(playerid), GetName(playerid), tkts+1, vehicleid, moneys, reason);
					SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
				}
				else return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vozilo vec ima previse ne placenih kazni!");
			} 
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Kazna mora biti izmedju 1 i 10.000$!");
		} 
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, " Duzina razloga mora biti izmedju 1 i 63 znaka!");
	}
	return 1;
}