#include <YSI\y_hooks>

new MDC[MAX_PLAYERS];

new cctvcam[MAX_PLAYERS];

new
	CCTVCar[MAX_PLAYERS] = 0,
	CCTVSeat[MAX_PLAYERS] = 0;

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
	PlayerText:MDCK1[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... };

static stock
    PlayerText:MDCK2[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCK3[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCK4[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCK5[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCK6[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCkhawajaheader[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCMainButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCCitizenButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCVehicleButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCPrisonersButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCRosterButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCHouseLocator[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCCCTVsButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	//CTVS
	PlayerText:MDCKCCTV[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCVeronaMall[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCRodeo[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCMarketStreet[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCDowntownLS[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCMainStreet[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCVinewoodBlvd[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCVerdantBluffs[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCStarStreet[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCIdlewood[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCJefferson[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCGlenPark[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCDBLaneRoad[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCGanton[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCTVOFF[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	//
 	PlayerText:MDCK8[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCK7[MAX_PLAYERS]				= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKSkin[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKhawajarank[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKhawajaIme[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKCheckCText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKProfileLine[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKProfSkin[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCKProfile[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
    PlayerText:MDCKText2[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKUpdated[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
 	PlayerText:MDCKCitizenTitle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCKVehTitle[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	//Check citizen buttons
	PlayerText:MDCCRecordButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCVehButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCTicketsButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCGeneralButton[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MDCCAPBButton[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	//
	PlayerText:MDCKClose[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },



	bool: house_spot[MAX_PLAYERS] = {false, ...};
new
	TargetName[ MAX_PLAYERS ][MAX_PLAYER_NAME];



stock GetPlayerPhoneNumber(sqlid)
{
	new	Cache:result,
		playerQuery[ 128 ],
		number = 0,
		numberstr[12];

	format(playerQuery, sizeof(playerQuery), "SELECT `number` FROM `player_phones` WHERE `player_id` = '%d' AND `type` = '1'", sqlid);
	result = mysql_query(g_SQL, playerQuery);
	cache_get_value_index_int(0, 0, number);
	cache_delete(result);

	if(number == 0)
		format(numberstr, sizeof(numberstr), "Ne postoji");
	else format(numberstr, sizeof(numberstr), "%d", number);
	return numberstr;
}


stock static OnPlayerKhawajaDataLoad(playerid, const playername[])
{
	new mysqlQuery[128];

	format(mysqlQuery, 128, "SELECT * FROM accounts WHERE `name` = '%e' LIMIT 0,1", playername);
	inline OnPlayerMDCLoad()
	{
		if(!cache_num_rows())
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Korisnik %s ne postoji!", playername);

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
		cache_get_value_name_int(0, "flylic"		, loadInfo[ pFlyLic ]);
		cache_get_value_name(0, 	"look", 		loadInfo[ pLook ]);

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
			"Profile: %s~n~Address: %s (%d)~n~Phone Number: %s~n~Sex: %s~n~Age: %d~n~~g~Desc.:~l~ ~n~%s~n~%s~n~",
			playername,
			tmpAddress,
			loadInfo[pHouseKey],
			GetPlayerPhoneNumber(loadInfo[ pSQLID ]),
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

		CreateKhawajaProfile(playerid, loadInfo[ pSkin ], false);
		PlayerTextDrawSetString(playerid, MDCKProfile[playerid], mdcString);
		PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], mdcString2);
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
		new buffer[ 2048];
		if(!cache_num_rows())
			format(buffer, sizeof(buffer), "~g~There_are_no_criminal_records!");
		else
		{
			new
				tmpJail[ E_JAIL_DATA ],
				motd[ 256 ],
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

				cache_get_value_name(i, "date", tmp, sizeof(tmp));
				format( tmpJail[ jDate ], 30, tmp );

				format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%d_-_%s~n~",
					tmpJail[ jSQLID ],
					tmpJail[ jPoliceName ],
					tmpJail[ jReason ],
					tmpJail[ jTime ],
					tmpJail[ jDate ]
				);
				strcat(buffer, motd, sizeof(buffer));
			}
		}
		new
			tmpString[ 64 ];

		UpdateKHAWAJATextDraws(playerid);
		format(tmpString, 32, "Criminal Record", playername);
		PlayerTextDrawSetString(playerid, MDCKText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnArrestLoad, "");
	return 1;
}

stock static OnPlayerTicketsLoad(playerid, const playername[])
{
	new mysqlQuery[128];

	format(mysqlQuery, 128, "SELECT * FROM tickets WHERE `primatelj` = '%e' LIMIT 10", playername);
	inline OnTicketsLoad()
	{
		new buffer[ 2048 ];
		if(!cache_num_rows())
			format(buffer, sizeof(buffer), "~g~There_are_no_traffic_tickets!");
		else
		{
			new
				tmpID,
				tmpOfficer[MAX_PLAYER_NAME],
				tmpRazlog[32],
				tmpNovac,
				tmpDatum[30],
				motd[ 256 ],
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

				cache_get_value_name(i, "datum", tmp, sizeof(tmp));
				format( tmpDatum, 30, tmp );

				format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%d_-_%s~n~",
					tmpID,
					tmpOfficer,
					tmpRazlog,
					tmpNovac,
					tmpDatum
				);
				strcat(buffer, motd, sizeof(buffer));
			}
		}
		new
			tmpString[ 32 ];

		UpdateKHAWAJATextDraws(playerid);
		format(tmpString, 32, "PERSONAL_TRAFFIC_TICKETS", playername);
		PlayerTextDrawSetString(playerid, MDCKText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnTicketsLoad, "");
	return 1;
}

stock static OnPlayerCoVehsLoad(playerid, playersqlid)
{
	new mysqlQuery[128];
	format(mysqlQuery, 128, "SELECT * FROM cocars WHERE `ownerid` = '%d' AND numberplate != '' AND numberplate != '0' LIMIT 10", playersqlid);
	inline OnCoVehicleLoad()
	{
		new buffer[ 2048 ];
		if(!cache_num_rows())
			format(buffer, sizeof(buffer), "~g~There_are_no_CO-Vehicles!");
		else
		{
			new
				tmpModelID,
				tmpNumberPlate[ 8 ],
				tmpColor1,
				tmpColor2,
				tmpImpounded,
				motd[ 256 ],
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
				format(motd, sizeof(motd), "#_%s_-_~b~%s~l~_-_%d_-_%d_-_%s~n~",
					VehModel,
					tmpNumberPlate,
					tmpColor1,
					tmpColor2,
					tmpImpounded ? ("~g~Yes~l~") : ("~r~No~l~")
				);
				strcat(buffer, motd, sizeof(buffer));
			}
		}
		new
			tmpString[ 64 ];

		UpdateKHAWAJATextDraws(playerid);
		format(tmpString, 64, "CO-VEHICLES_LIST");
		PlayerTextDrawSetString(playerid, MDCKText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnCoVehicleLoad, "");
	return 1;
}

stock static OnPlayerAPBLoad(playerid, const playername[])
{
	new mysqlQuery[128];

	format(mysqlQuery, 128, "SELECT * FROM apb WHERE `suspect` = '%e'", playername);
	inline OnAPBLoad()
	{
		new buffer[ 2048 ];
		if(!cache_num_rows())
			format(buffer, sizeof(buffer), "~g~Person_is_not_wanted!");
		else
		{
			new
				aSqlId,
				aPDname[MAX_PLAYER_NAME],
				aDiscription[57],
				aType,
				motd[ 256 ],
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


				format(motd, sizeof(motd), "#%d_-_%s_-_%s_-_%s~n~",
					aSqlId,
					aPDname,
					aDiscription,
					GetAPBType(aType)
				);
				strcat(buffer, motd, sizeof(motd));
			}
		}
		new
			tmpString[ 64 ];

		UpdateKHAWAJATextDraws(playerid);
		format(tmpString, 64, "ALL_POINTS_BULLETIN", playername);
		PlayerTextDrawSetString(playerid, MDCKText2[playerid], tmpString);
		PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], buffer);
		SelectTextDraw(playerid, 0x427AF4FF);
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnAPBLoad, "");
	return 1;
}

stock GetAPBList(playerid)
{
	new mysqlQuery[128];

	format(mysqlQuery, 128, "SELECT * FROM apb ORDER BY `id` DESC");
	inline OnAPBListLoad()
	{
		if(!cache_num_rows())
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "APB lista je prazna!");
		new
			aSqlId,
			aPDname[MAX_PLAYER_NAME],
			aSuspect[MAX_PLAYER_NAME],
			aDiscription[57],
			aType,
			buffer[ 4096 ],
			motd[ 256 ],
			tmp[ 64 ],
			lenleft;

		for( new i = 0; i < cache_num_rows(); i++)
		{
			lenleft = sizeof(buffer) - strlen(buffer);
			if(lenleft < sizeof(motd))
				break;

			cache_get_value_name_int(i, "id", aSqlId);

			cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
			format( aPDname, MAX_PLAYER_NAME, tmp );

			cache_get_value_name(i,"suspect", tmp, sizeof(tmp));
			format( aSuspect, MAX_PLAYER_NAME, tmp );

			cache_get_value_name(i,"description"	, tmp, sizeof(tmp));
			format( aDiscription, 57, tmp );

			cache_get_value_name_int(i, "type", aType);

			format(motd, sizeof(motd), "{FF8000}APB ID: #%d | {FF8000}Suspect: %s | {FF8000}Created by: %s | {FF8000}Description: %s | {FF8000}APB Type: %s\n",
				aSqlId,
				aSuspect,
				aPDname,
				aDiscription,
				GetAPBType(aType)
			);
			strcat(buffer, motd, 4096);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "[APB List]", buffer, "Close", "");
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnAPBListLoad, "");
	return 1;
}

stock GetSuspectAPB(playerid, const playername[])
{
	new mysqlQuery[128];

	format(mysqlQuery, 128, "SELECT * FROM apb WHERE `suspect` = '%e'", playername);
	inline OnAPBLoad()
	{
		if(!cache_num_rows())
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unesena osoba nije pronadjena u databazi.");
		new
			aSqlId,
			aPDname[MAX_PLAYER_NAME],
			aDiscription[57],
			aType,
			buffer[ 2048 ],
			tmp[ 64 ],
			motd[ 256 ],
			lenleft;

		format(buffer, sizeof(buffer), "\n");
		for( new i = 0; i < cache_num_rows(); i++)
		{
			lenleft = sizeof(buffer) - strlen(buffer);
			if(lenleft < sizeof(motd))
				break;

			cache_get_value_name_int(i, "id", aSqlId);

			cache_get_value_name(i,"pdname", tmp, sizeof(tmp));
			format( aPDname, MAX_PLAYER_NAME, tmp );

			cache_get_value_name(i,"description"	, tmp, sizeof(tmp));
			format( aDiscription, 57, tmp );

			cache_get_value_name_int(i, "type", aType);

			format(motd, sizeof(motd), "{FF8000}APB ID #%d\n{FF8000}Created by: %s\n{FF8000}Description: %s\n{FF8000}APB Type: %s\n",
				aSqlId,
				aPDname,
				aDiscription,
				GetAPBType(aType)
			);
			strcat(buffer, motd, 4096);
		}

		new tmpString[ 12+MAX_PLAYER_NAME ];
		format(tmpString, 64, "[APB - %s]", playername);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, tmpString, buffer, "Close", "");
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
		" Ticket #1: %s - %d$~n~ Ticket #2: %s - %d$~n~ Ticket #3: %s - %d$~n~ Ticket #4: %s - %d$~n~ Ticket #5: %s - %d$",
		GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][0]),
		VehicleInfo[ vehicleid ][ vTickets ][ 0 ],
		GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][1]),
		VehicleInfo[ vehicleid ][ vTickets ][ 1 ],
		GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][2]),
		VehicleInfo[ vehicleid ][ vTickets ][ 2 ],
		GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][3]),
		VehicleInfo[ vehicleid ][ vTickets ][ 3 ],
		GetVehicleTicketReason(VehicleInfo[vehicleid][vTicketsSQLID][4]),
		VehicleInfo[ vehicleid ][ vTickets ][ 4 ]
	);

	SelectTextDraw(playerid, 0x427AF4FF);
	CreateVehMDCTextDraws(playerid, GetVehicleModel(vehicleid), VehicleInfo[ vehicleid ][ vColor1 ], VehicleInfo[ vehicleid ][ vColor2 ]);

	format(TargetName[playerid], 24, "%s", VehOwner);
	PlayerTextDrawSetString(playerid, MDCKProfile[playerid], mdcString);
	PlayerTextDrawSetString(playerid, MDCKText2[playerid], "TICKETS_LIST");
	PlayerTextDrawSetString(playerid, MDCKUpdated[playerid], mdcString2);
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
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali dosje #%d!", sqlid);
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

			cache_get_value_name(i, "date", tmp, sizeof(tmp));
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

forward CCTVExit(playerid);
public CCTVExit(playerid)
{
    SendClientMessage(playerid, -1, "'Vraceni ste u vozilo nakon napu�tanja CCTVa.");
	PutPlayerInVehicle(playerid, CCTVCar[playerid], CCTVSeat[playerid]);
	SetCameraBehindPlayer(playerid);
    KillTimer(cctvcam[playerid]);
    return 1;
}

stock static UpdateKHAWAJATextDraws(playerid)
{
	DestroyUpdatedKHAWAJATextDraws(playerid);

	MDCKUpdated[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 285.133178, "N/A");
	PlayerTextDrawLetterSize(playerid, MDCKUpdated[playerid], 0.262998, 1.045622);
	PlayerTextDrawAlignment(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKUpdated[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKUpdated[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKUpdated[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKUpdated[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKUpdated[playerid]);
	
	MDCKText2[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 275.133178, "DESCRIPTION");
	PlayerTextDrawLetterSize(playerid, MDCKText2[playerid], 0.262998, 1.045622);
	PlayerTextDrawAlignment(playerid, MDCKText2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKText2[playerid],  255);
	PlayerTextDrawSetShadow(playerid, MDCKText2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKText2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKText2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKText2[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKText2[playerid]);

}

stock static DestroyUpdatedKHAWAJATextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, MDCKUpdated[ playerid ] );
	MDCKUpdated[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKText2[ playerid ] );
	MDCKText2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
}

stock DestroyKhawaja(playerid)
{
    PlayerTextDrawDestroy(playerid, MDCK1[ playerid ] );
	MDCK1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK2[ playerid ] );
	MDCK2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK3[ playerid ] );
	MDCK3[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK4[ playerid ] );
	MDCK4[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK5[ playerid ] );
	MDCK5[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK6[ playerid ] );
	MDCK6[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCkhawajaheader[ playerid ] );
	MDCkhawajaheader[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
 	PlayerTextDrawDestroy(playerid, MDCKSkin[ playerid ] );
	MDCKSkin[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKhawajarank[ playerid ] );
	MDCKhawajarank[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKhawajaIme[ playerid ] );
	MDCKhawajaIme[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCK7[ playerid ] );
	MDCK7[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCK8[ playerid ] );
	MDCK8[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCMainButton[ playerid ] );
	MDCMainButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCitizenButton[playerid] );
	MDCCitizenButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCVehicleButton[ playerid ] );
	MDCVehicleButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCPrisonersButton[ playerid ] );
	MDCPrisonersButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCRosterButton[ playerid ] );
	MDCRosterButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCHouseLocator[ playerid ] );
	MDCHouseLocator[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCCTVsButton[ playerid ] );
	MDCCCTVsButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKCCTV[ playerid ] );
	MDCKCCTV[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKCitizenTitle[ playerid ] );
	MDCKCitizenTitle[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKVehTitle[ playerid ] );
	MDCKVehTitle[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCVeronaMall[ playerid ] );
	MDCVeronaMall[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCRodeo[ playerid ] );
	MDCRodeo[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCMarketStreet[ playerid ] );
	MDCMarketStreet[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCDowntownLS[ playerid ] );
	MDCDowntownLS[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCMainStreet[ playerid ] );
	MDCMainStreet[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCVinewoodBlvd[ playerid ] );
	MDCVinewoodBlvd[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCVerdantBluffs[ playerid ] );
	MDCVerdantBluffs[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCStarStreet[ playerid ] );
	MDCStarStreet[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCIdlewood[ playerid ] );
	MDCIdlewood[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCJefferson[ playerid ] );
	MDCJefferson[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCGlenPark[ playerid ] );
	MDCGlenPark[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCDBLaneRoad[ playerid ] );
	MDCDBLaneRoad[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCGanton[ playerid ] );
	MDCGanton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCTVOFF[ playerid ] );
	MDCCTVOFF[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	//Profiles
	PlayerTextDrawDestroy(playerid, MDCKProfSkin[ playerid ] );
	MDCKProfSkin[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKProfile[ playerid ] );
	MDCKProfile[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKText2[ playerid ] );
	MDCKText2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKUpdated[ playerid ] );
	MDCKUpdated[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
    PlayerTextDrawDestroy(playerid, MDCKCheckCText[ playerid ] );
	MDCKCheckCText[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCKProfileLine[ playerid ] );
	MDCKProfileLine[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	//Buttons on the buttom
	PlayerTextDrawDestroy(playerid, MDCCRecordButton[ playerid ] );
	MDCCRecordButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCVehButton[ playerid ] );
	MDCCVehButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCTicketsButton[ playerid ] );
	MDCCTicketsButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCGeneralButton[playerid] );
	MDCCGeneralButton[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PlayerTextDrawDestroy(playerid, MDCCAPBButton[ playerid ] );
	MDCCAPBButton[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	//
	PlayerTextDrawDestroy(playerid, MDCKClose[ playerid ] );
	MDCKClose[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
}


stock static CreateKhawaja(playerid)
{
    DestroyKhawaja(playerid);

	MDCK1[playerid]  = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "box");
	PlayerTextDrawLetterSize(playerid, MDCK1[playerid], 0.000000, 26.500009);
	PlayerTextDrawTextSize(playerid, MDCK1[playerid], 516.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK1[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK1[playerid]);

	MDCkhawajaheader[playerid]  = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "Los_Santos_Police_Department~n~");
	PlayerTextDrawLetterSize(playerid, MDCkhawajaheader[playerid], 0.185999, 1.110000);
	PlayerTextDrawTextSize(playerid, MDCkhawajaheader[playerid], 515.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawColor(playerid, MDCkhawajaheader[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawFont(playerid, MDCkhawajaheader[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawShow(playerid, MDCkhawajaheader[playerid]);

	MDCK3[playerid]  = CreatePlayerTextDraw(playerid, 160.500000, 309.875000, "");
	PlayerTextDrawLetterSize(playerid, MDCK3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCK3[playerid], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, MDCK3[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK3[playerid], 0);
	PlayerTextDrawFont(playerid, MDCK3[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCK3[playerid], 597);
	PlayerTextDrawSetPreviewRot(playerid, MDCK3[playerid], 0.000000, 0.000000, 35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCK3[playerid], 1, 1);
	PlayerTextDrawShow(playerid, MDCK3[playerid]);

	MDCK4[playerid]  = CreatePlayerTextDraw(playerid, 251.000000, 148.875000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK4[playerid], 0.000000, 25.249992);
	PlayerTextDrawTextSize(playerid, MDCK4[playerid], 248.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK4[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK4[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK4[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK4[playerid]);

	MDCK5[playerid] = CreatePlayerTextDraw(playerid, 276.000000, 215.375000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK5[playerid], 0.000000, 14.100005);
	PlayerTextDrawTextSize(playerid, MDCK5[playerid], 509.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK5[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK5[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK5[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK5[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK5[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK5[playerid]);

    MDCKSkin[ playerid ] = CreatePlayerTextDraw(playerid, 180.500000, 129.625000, "");
	PlayerTextDrawLetterSize(playerid, MDCKSkin[ playerid ], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCKSkin[ playerid ], 385.000000, 238.000000);
	PlayerTextDrawAlignment(playerid, MDCKSkin[ playerid ], 1);
	PlayerTextDrawColor(playerid, MDCKSkin[ playerid ], -1);
	PlayerTextDrawSetShadow(playerid, MDCKSkin[ playerid ], 0);
	PlayerTextDrawSetOutline(playerid, MDCKSkin[ playerid ], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKSkin[ playerid ], 0);
	PlayerTextDrawFont(playerid, MDCKSkin[ playerid ], 5);
	PlayerTextDrawSetProportional(playerid, MDCKSkin[ playerid ], 0);
	PlayerTextDrawSetShadow(playerid, MDCKSkin[ playerid ], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCKSkin[ playerid ], GetPlayerSkin(playerid));
	PlayerTextDrawSetPreviewRot(playerid, MDCKSkin[ playerid ], 0.000000, 0.000000, 0.000000, 1.000000);
 	PlayerTextDrawShow(playerid, MDCKSkin[ playerid ]);

	MDCK7[playerid] = CreatePlayerTextDraw(playerid, 283.500000, 221.500000, "blue_bg");
	PlayerTextDrawLetterSize(playerid, MDCK7[playerid], 0.000000, 15.000000);
	PlayerTextDrawTextSize(playerid, MDCK7[playerid], 503.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK7[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK7[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK7[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK7[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK7[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK7[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK7[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK7[playerid], 1);
	PlayerTextDrawShow(playerid, MDCK7[playerid]);
	
	MDCK8[playerid] = CreatePlayerTextDraw(playerid, 251.500000, 221.500000, "blue_bg");
	PlayerTextDrawLetterSize(playerid, MDCK8[playerid], 0.000000, -0.300000);
	PlayerTextDrawTextSize(playerid, MDCK8[playerid], 516.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK8[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK8[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK8[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK8[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK8[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK8[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK8[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK8[playerid], 1);
	PlayerTextDrawShow(playerid, MDCK8[playerid]);

	MDCKhawajarank[ playerid ] = CreatePlayerTextDraw(playerid, 372.500000, 220.625000, "_");
	PlayerTextDrawLetterSize(playerid, MDCKhawajarank[ playerid ], 0.500000, 2.164374);
	PlayerTextDrawAlignment(playerid, MDCKhawajarank[ playerid ], 2);
	PlayerTextDrawColor(playerid, MDCKhawajarank[ playerid ], 255);
	PlayerTextDrawSetShadow(playerid, MDCKhawajarank[ playerid ], 0);
	PlayerTextDrawSetOutline(playerid, MDCKhawajarank[ playerid ], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKhawajarank[ playerid ], 255);
	PlayerTextDrawFont(playerid, MDCKhawajarank[ playerid ], 2);
	PlayerTextDrawSetProportional(playerid, MDCKhawajarank[ playerid ], 1);
	PlayerTextDrawSetShadow(playerid, MDCKhawajarank[ playerid ], 0);
	PlayerTextDrawShow(playerid, MDCKhawajarank[ playerid ]);

	MDCKhawajaIme[ playerid ] = CreatePlayerTextDraw(playerid, 372.500000, 239.437500, "_");
	PlayerTextDrawLetterSize(playerid, MDCKhawajaIme[ playerid ], 0.387499, 1.770625);
	PlayerTextDrawAlignment(playerid, MDCKhawajaIme[ playerid ], 2);
	PlayerTextDrawColor(playerid, MDCKhawajaIme[ playerid ], 255);
	PlayerTextDrawSetShadow(playerid, MDCKhawajaIme[ playerid ], 0);
	PlayerTextDrawSetOutline(playerid, MDCKhawajaIme[ playerid ], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKhawajaIme[ playerid ], 255);
	PlayerTextDrawFont(playerid, MDCKhawajaIme[ playerid ], 2);
	PlayerTextDrawSetProportional(playerid, MDCKhawajaIme[ playerid ], 1);
	PlayerTextDrawSetShadow(playerid, MDCKhawajaIme[ playerid ], 0);
	PlayerTextDrawShow(playerid, MDCKhawajaIme[playerid]);

	MDCVehicleButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 181.250000, "check_vehicle");
	PlayerTextDrawLetterSize(playerid, MDCVehicleButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCVehicleButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVehicleButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVehicleButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCVehicleButton[playerid]);

	MDCPrisonersButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 194.812500, "prisoners");
	PlayerTextDrawLetterSize(playerid, MDCPrisonersButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCPrisonersButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCPrisonersButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCPrisonersButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCPrisonersButton[playerid]);

	MDCMainButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 154.125000, "main_screen");
	PlayerTextDrawLetterSize(playerid, MDCMainButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCMainButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMainButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMainButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCMainButton[playerid]);

	MDCCitizenButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 167.687500, "check_citizen");
	PlayerTextDrawLetterSize(playerid, MDCCitizenButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCitizenButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCitizenButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCitizenButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCitizenButton[playerid]);

	MDCRosterButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 208.375000, "DUTY_ROSTER");
	PlayerTextDrawLetterSize(playerid, MDCRosterButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCRosterButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCRosterButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCRosterButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCRosterButton[playerid]);

	MDCHouseLocator[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 221.937500, "HOUSE_LOCATOR");
	PlayerTextDrawLetterSize(playerid, MDCHouseLocator[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCHouseLocator[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawColor(playerid, MDCHouseLocator[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawFont(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCHouseLocator[playerid], true);
	PlayerTextDrawShow(playerid, MDCHouseLocator[playerid]);

	MDCCCTVsButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 235.500000, "CCTVS");
	PlayerTextDrawLetterSize(playerid, MDCCCTVsButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCCTVsButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCCTVsButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCCTVsButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCCTVsButton[playerid]);


	MDCKClose[playerid] = CreatePlayerTextDraw(playerid, 502.500000, 136.187500, "X");
	PlayerTextDrawLetterSize(playerid, MDCKClose[playerid], 0.421499, 1.258749);
	PlayerTextDrawAlignment(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKClose[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKClose[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCKClose[playerid], true);
	PlayerTextDrawShow(playerid, MDCKClose[playerid]);
	
}

stock static CreateKhawajaProfile(playerid, skin, bool:type=false)
{
    DestroyKhawaja(playerid);

	MDCK1[playerid] = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "box");
	PlayerTextDrawLetterSize(playerid, MDCK1[playerid], 0.000000, 26.500009);
	PlayerTextDrawTextSize(playerid, MDCK1[playerid], 516.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK1[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK1[playerid]);

	MDCkhawajaheader[playerid]  = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "Los_Santos_Police_Department~n~");
	PlayerTextDrawLetterSize(playerid, MDCkhawajaheader[playerid], 0.185999, 1.110000);
	PlayerTextDrawTextSize(playerid, MDCkhawajaheader[playerid], 515.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawColor(playerid, MDCkhawajaheader[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawFont(playerid, MDCkhawajaheader[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawShow(playerid, MDCkhawajaheader[playerid]);

	MDCK3[playerid]  = CreatePlayerTextDraw(playerid, 160.500000, 309.875000, "");
	PlayerTextDrawLetterSize(playerid, MDCK3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCK3[playerid], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, MDCK3[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK3[playerid], 0);
	PlayerTextDrawFont(playerid, MDCK3[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCK3[playerid], 597);
	PlayerTextDrawSetPreviewRot(playerid, MDCK3[playerid], 0.000000, 0.000000, 35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCK3[playerid], 1, 1);
	PlayerTextDrawShow(playerid, MDCK3[playerid]);

	MDCK4[playerid]  = CreatePlayerTextDraw(playerid, 251.000000, 148.875000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK4[playerid], 0.000000, 25.249992);
	PlayerTextDrawTextSize(playerid, MDCK4[playerid], 248.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK4[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK4[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK4[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK4[playerid]);

	MDCK5[playerid] = CreatePlayerTextDraw(playerid, 276.000000, 215.375000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK5[playerid], 0.000000, 14.100005);
	PlayerTextDrawTextSize(playerid, MDCK5[playerid], 509.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK5[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK5[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK5[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK5[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK5[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK5[playerid]);

	MDCVehicleButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 181.250000, "check_vehicle");
	PlayerTextDrawLetterSize(playerid, MDCVehicleButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCVehicleButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVehicleButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVehicleButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCVehicleButton[playerid]);

	MDCPrisonersButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 194.812500, "prisoners");
	PlayerTextDrawLetterSize(playerid, MDCPrisonersButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCPrisonersButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCPrisonersButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCPrisonersButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCPrisonersButton[playerid]);

	MDCMainButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 154.125000, "main_screen");
	PlayerTextDrawLetterSize(playerid, MDCMainButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCMainButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMainButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMainButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCMainButton[playerid]);

	MDCCitizenButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 167.687500, "check_citizen");
	PlayerTextDrawLetterSize(playerid, MDCCitizenButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCitizenButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCitizenButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCitizenButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCitizenButton[playerid]);

	MDCRosterButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 208.375000, "DUTY_ROSTER");
	PlayerTextDrawLetterSize(playerid, MDCRosterButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCRosterButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCRosterButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCRosterButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCRosterButton[playerid]);

	MDCHouseLocator[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 221.937500, "HOUSE_LOCATOR");
	PlayerTextDrawLetterSize(playerid, MDCHouseLocator[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCHouseLocator[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawColor(playerid, MDCHouseLocator[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawFont(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCHouseLocator[playerid], true);
	PlayerTextDrawShow(playerid, MDCHouseLocator[playerid]);

	MDCCCTVsButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 235.500000, "CCTVS");
	PlayerTextDrawLetterSize(playerid, MDCCCTVsButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCCTVsButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCCTVsButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCCTVsButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCCTVsButton[playerid]);
	
	MDCKCitizenTitle[playerid] = CreatePlayerTextDraw(playerid, 303.500000, 152.812500, "CHECK_CITIZEN");
	PlayerTextDrawLetterSize(playerid, MDCKCitizenTitle[playerid], 0.410499, 1.809999);
	PlayerTextDrawAlignment(playerid, MDCKCitizenTitle[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKCitizenTitle[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKCitizenTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKCitizenTitle[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKCitizenTitle[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKCitizenTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKCitizenTitle[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKCitizenTitle[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKCitizenTitle[playerid]);
	
	MDCKProfileLine[playerid] = CreatePlayerTextDraw(playerid, 267.500000, 178.187500, "box");
	PlayerTextDrawLetterSize(playerid, MDCKProfileLine[playerid], 0.000000, -0.449999);
	PlayerTextDrawTextSize(playerid, MDCKProfileLine[playerid], 495.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKProfileLine[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCKProfileLine[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKProfileLine[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKProfileLine[playerid]);
	
	MDCKProfSkin[playerid] = CreatePlayerTextDraw(playerid, 418.000000, 186.062500, "");
	PlayerTextDrawLetterSize(playerid, MDCKProfSkin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCKProfSkin[playerid], 79.000000, 86.000000);
	PlayerTextDrawAlignment(playerid, MDCKProfSkin[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKProfSkin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCKProfSkin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKProfSkin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKProfSkin[playerid], 1616928864);
	PlayerTextDrawFont(playerid, MDCKProfSkin[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, MDCKProfSkin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDCKProfSkin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCKProfSkin[playerid], skin);
	PlayerTextDrawSetPreviewRot(playerid, MDCKProfSkin[playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawShow(playerid, MDCKProfSkin[playerid]);


	MDCKProfile[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 180.133178, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCKProfile[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKProfile[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKProfile[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKProfile[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKProfile[playerid]);

	MDCKText2[playerid] = CreatePlayerTextDraw(playerid, 165.599960, 188.866073, "DESCRIPTION");
	PlayerTextDrawLetterSize(playerid, MDCKText2[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKText2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKText2[playerid], 35071);
	PlayerTextDrawSetShadow(playerid, MDCKText2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKText2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKText2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKText2[playerid], 1);

    MDCKUpdated[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 256.133178, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCKUpdated[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKUpdated[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKUpdated[playerid]);
	
    if (!type)
	{
		MDCCRecordButton[playerid] = CreatePlayerTextDraw(playerid, 309.566970, 365.157867, "CRIMINAL_RECORD");
		PlayerTextDrawLetterSize(playerid, MDCCRecordButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCCRecordButton[playerid], 18.000000, 63.000000);
		PlayerTextDrawAlignment(playerid, MDCCRecordButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCCRecordButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCCRecordButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCCRecordButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCCRecordButton[playerid], 0);
		PlayerTextDrawSetOutline(playerid, MDCCRecordButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCCRecordButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCCRecordButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCCRecordButton[playerid], 1);
		PlayerTextDrawSetShadow(playerid, MDCCRecordButton[playerid], 0);
		PlayerTextDrawSetSelectable(playerid, MDCCRecordButton[playerid], true);
	    PlayerTextDrawShow(playerid, MDCCRecordButton[playerid]);

		MDCCVehButton[playerid] = CreatePlayerTextDraw(playerid, 363.234573, 365.157867, "VEHICLES");
		PlayerTextDrawLetterSize(playerid, MDCCVehButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCCVehButton[playerid], 18.000000, 35.000000);
		PlayerTextDrawAlignment(playerid, MDCCVehButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCCVehButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCCVehButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCCVehButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCCVehButton[playerid], 0);
		PlayerTextDrawSetOutline(playerid, MDCCVehButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCCVehButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCCVehButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCCVehButton[playerid], 1);
		PlayerTextDrawSetShadow(playerid, MDCCVehButton[playerid], 0);
		PlayerTextDrawSetSelectable(playerid, MDCCVehButton[playerid], true);
	    PlayerTextDrawShow(playerid, MDCCVehButton[playerid]);

		MDCCTicketsButton[playerid] = CreatePlayerTextDraw(playerid, 416.066436, 365.157867, "TRAFFIC_TICKETS");
		PlayerTextDrawLetterSize(playerid, MDCCTicketsButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCCTicketsButton[playerid], 18.000000, 62.000000);
		PlayerTextDrawAlignment(playerid, MDCCTicketsButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCCTicketsButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCCTicketsButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCCTicketsButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCCTicketsButton[playerid], 0);
		PlayerTextDrawSetOutline(playerid, MDCCTicketsButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCCTicketsButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCCTicketsButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCCTicketsButton[playerid], 1);
		PlayerTextDrawSetShadow(playerid, MDCCTicketsButton[playerid], 0);
		PlayerTextDrawSetSelectable(playerid, MDCCTicketsButton[playerid], true);
	    PlayerTextDrawShow(playerid, MDCCTicketsButton[playerid]);

		MDCCGeneralButton[playerid] = CreatePlayerTextDraw(playerid, 469.269683, 365.157867, "GENERAL");
		PlayerTextDrawLetterSize(playerid, MDCCGeneralButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCCGeneralButton[playerid], 18.000000, 34.000000);
		PlayerTextDrawAlignment(playerid, MDCCGeneralButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCCGeneralButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCCGeneralButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCCGeneralButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCCGeneralButton[playerid], 0);
		PlayerTextDrawSetOutline(playerid, MDCCGeneralButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCCGeneralButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCCGeneralButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCCGeneralButton[playerid], 1);
		PlayerTextDrawSetShadow(playerid, MDCCGeneralButton[playerid], 0);
		PlayerTextDrawSetSelectable(playerid, MDCCGeneralButton[playerid], true);
	    PlayerTextDrawShow(playerid, MDCCGeneralButton[playerid]);

		MDCCAPBButton[playerid] = CreatePlayerTextDraw(playerid, 503.271759, 365.157867, "APB");
		PlayerTextDrawLetterSize(playerid, MDCCAPBButton[playerid], 0.178000, 1.139555);
		PlayerTextDrawTextSize(playerid, MDCCAPBButton[playerid], 18.000000, 24.000000);
		PlayerTextDrawAlignment(playerid, MDCCAPBButton[playerid], 2);
		PlayerTextDrawColor(playerid, MDCCAPBButton[playerid], -1);
		PlayerTextDrawUseBox(playerid, MDCCAPBButton[playerid], 1);
		PlayerTextDrawBoxColor(playerid, MDCCAPBButton[playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, MDCCAPBButton[playerid], 0);
		PlayerTextDrawSetOutline(playerid, MDCCAPBButton[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, MDCCAPBButton[playerid], 255);
		PlayerTextDrawFont(playerid, MDCCAPBButton[playerid], 2);
		PlayerTextDrawSetProportional(playerid, MDCCAPBButton[playerid], 1);
		PlayerTextDrawSetShadow(playerid, MDCCAPBButton[playerid], 0);
		PlayerTextDrawSetSelectable(playerid, MDCCAPBButton[playerid], true);
	    PlayerTextDrawShow(playerid, MDCCAPBButton[playerid]);
	}

	MDCKClose[playerid] = CreatePlayerTextDraw(playerid, 502.500000, 136.187500, "X");
	PlayerTextDrawLetterSize(playerid, MDCKClose[playerid], 0.421499, 1.258749);
	PlayerTextDrawAlignment(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKClose[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKClose[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCKClose[playerid], true);
	PlayerTextDrawShow(playerid, MDCKClose[playerid]);

}

stock static CreateVehMDCTextDraws(playerid, model, color1, color2)
{
    DestroyKhawaja(playerid);

	MDCK1[playerid] = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "box");
	PlayerTextDrawLetterSize(playerid, MDCK1[playerid], 0.000000, 26.500009);
	PlayerTextDrawTextSize(playerid, MDCK1[playerid], 516.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK1[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK1[playerid]);

	MDCkhawajaheader[playerid] = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "Los_Santos_Police_Department~n~");
	PlayerTextDrawLetterSize(playerid, MDCkhawajaheader[playerid], 0.185999, 1.110000);
	PlayerTextDrawTextSize(playerid, MDCkhawajaheader[playerid], 515.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawColor(playerid, MDCkhawajaheader[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawFont(playerid, MDCkhawajaheader[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawShow(playerid, MDCkhawajaheader[playerid]);

	MDCK3[playerid] = CreatePlayerTextDraw(playerid, 160.500000, 309.875000, "");
	PlayerTextDrawLetterSize(playerid, MDCK3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCK3[playerid], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, MDCK3[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK3[playerid], 0);
	PlayerTextDrawFont(playerid, MDCK3[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCK3[playerid], 597);
	PlayerTextDrawSetPreviewRot(playerid, MDCK3[playerid], 0.000000, 0.000000, 35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCK3[playerid], 1, 1);
	PlayerTextDrawShow(playerid, MDCK3[playerid]);

	MDCK4[playerid] = CreatePlayerTextDraw(playerid, 251.000000, 148.875000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK4[playerid], 0.000000, 25.249992);
	PlayerTextDrawTextSize(playerid, MDCK4[playerid], 248.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK4[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK4[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK4[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK4[playerid]);

	MDCK5[playerid] = CreatePlayerTextDraw(playerid, 276.000000, 215.375000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK5[playerid], 0.000000, 14.100005);
	PlayerTextDrawTextSize(playerid, MDCK5[playerid], 509.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK5[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK5[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK5[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK5[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK5[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK5[playerid]);

	MDCVehicleButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 181.250000, "check_vehicle");
	PlayerTextDrawLetterSize(playerid, MDCVehicleButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCVehicleButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVehicleButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVehicleButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCVehicleButton[playerid]);

	MDCPrisonersButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 194.812500, "prisoners");
	PlayerTextDrawLetterSize(playerid, MDCPrisonersButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCPrisonersButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCPrisonersButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCPrisonersButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCPrisonersButton[playerid]);

	MDCMainButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 154.125000, "main_screen");
	PlayerTextDrawLetterSize(playerid, MDCMainButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCMainButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMainButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMainButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCMainButton[playerid]);

	MDCCitizenButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 167.687500, "check_citizen");
	PlayerTextDrawLetterSize(playerid, MDCCitizenButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCitizenButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCitizenButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCitizenButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCitizenButton[playerid]);

	MDCRosterButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 208.375000, "DUTY_ROSTER");
	PlayerTextDrawLetterSize(playerid, MDCRosterButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCRosterButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCRosterButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCRosterButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCRosterButton[playerid]);

	MDCHouseLocator[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 221.937500, "HOUSE_LOCATOR");
	PlayerTextDrawLetterSize(playerid, MDCHouseLocator[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCHouseLocator[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawColor(playerid, MDCHouseLocator[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawFont(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCHouseLocator[playerid], true);
	PlayerTextDrawShow(playerid, MDCHouseLocator[playerid]);

	MDCCCTVsButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 235.500000, "CCTVS");
	PlayerTextDrawLetterSize(playerid, MDCCCTVsButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCCTVsButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCCTVsButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCCTVsButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCCTVsButton[playerid]);

    MDCKVehTitle[playerid] = CreatePlayerTextDraw(playerid, 303.500000, 152.812500, "CHECK_VEHICLE");
	PlayerTextDrawLetterSize(playerid, MDCKVehTitle[playerid], 0.410499, 1.809999);
	PlayerTextDrawAlignment(playerid, MDCKVehTitle[playerid], 2);
	PlayerTextDrawColor(playerid, MDCKVehTitle[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKVehTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKVehTitle[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKVehTitle[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKVehTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKVehTitle[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKVehTitle[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKVehTitle[playerid]);

	MDCKProfileLine[playerid] = CreatePlayerTextDraw(playerid, 267.500000, 178.187500, "box");
	PlayerTextDrawLetterSize(playerid, MDCKProfileLine[playerid], 0.000000, -0.449999);
	PlayerTextDrawTextSize(playerid, MDCKProfileLine[playerid], 495.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKProfileLine[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCKProfileLine[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKProfileLine[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKProfileLine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKProfileLine[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKProfileLine[playerid]);

    MDCKSkin[playerid] = CreatePlayerTextDraw(playerid, 418.000000, 186.062500, "");
    PlayerTextDrawLetterSize(playerid, MDCKSkin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCKSkin[playerid], 79.000000, 86.000000);
	PlayerTextDrawAlignment(playerid, MDCKSkin[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKSkin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCKSkin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKSkin[playerid], 1616928864);
	PlayerTextDrawFont(playerid, MDCKSkin[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, MDCKSkin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCKSkin[playerid], model);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCKSkin[playerid], color1, color2);
	PlayerTextDrawSetPreviewRot(playerid, MDCKSkin[playerid], 0.000000, 0.000000, 30.000000, 0.899999);
	PlayerTextDrawShow(playerid, MDCKSkin[playerid]);

	MDCKProfile[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 180.133178, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCKProfile[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKProfile[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKProfile[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKProfile[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKProfile[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKProfile[playerid]);

	MDCKText2[playerid] = CreatePlayerTextDraw(playerid, 271.000000, 243.866073, "DESCRIPTION");
	PlayerTextDrawLetterSize(playerid, MDCKText2[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKText2[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKText2[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCKText2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKText2[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKText2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKText2[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKText2[playerid]);

    MDCKUpdated[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 256.133178, "N-A");
	PlayerTextDrawLetterSize(playerid, MDCKUpdated[playerid], 0.191999, 1.093927);
	PlayerTextDrawAlignment(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKUpdated[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKUpdated[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKUpdated[playerid], 1);
	PlayerTextDrawShow(playerid, MDCKUpdated[playerid]);


	MDCKClose[playerid] = CreatePlayerTextDraw(playerid, 502.500000, 136.187500, "X");
	PlayerTextDrawLetterSize(playerid, MDCKClose[playerid], 0.421499, 1.258749);
	PlayerTextDrawAlignment(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKClose[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKClose[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCKClose[playerid], true);
	PlayerTextDrawShow(playerid, MDCKClose[playerid]);

}

stock static CreateKhawajaCCTV(playerid)
{
    DestroyKhawaja(playerid);

	MDCK1[playerid] = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "box");
	PlayerTextDrawLetterSize(playerid, MDCK1[playerid], 0.000000, 26.500009);
	PlayerTextDrawTextSize(playerid, MDCK1[playerid], 516.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK1[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK1[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK1[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK1[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK1[playerid]);

	MDCkhawajaheader[playerid]  = CreatePlayerTextDraw(playerid, 177.000000, 137.062500, "Los_Santos_Police_Department~n~");
	PlayerTextDrawLetterSize(playerid, MDCkhawajaheader[playerid], 0.185999, 1.110000);
	PlayerTextDrawTextSize(playerid, MDCkhawajaheader[playerid], 515.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawColor(playerid, MDCkhawajaheader[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCkhawajaheader[playerid], 255);
	PlayerTextDrawFont(playerid, MDCkhawajaheader[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCkhawajaheader[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCkhawajaheader[playerid], 0);
	PlayerTextDrawShow(playerid, MDCkhawajaheader[playerid]);

	MDCK3[playerid] = CreatePlayerTextDraw(playerid, 160.500000, 309.875000, "");
	PlayerTextDrawLetterSize(playerid, MDCK3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDCK3[playerid], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, MDCK3[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK3[playerid], 0);
	PlayerTextDrawFont(playerid, MDCK3[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDCK3[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDCK3[playerid], 597);
	PlayerTextDrawSetPreviewRot(playerid, MDCK3[playerid], 0.000000, 0.000000, 35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDCK3[playerid], 1, 1);
	PlayerTextDrawShow(playerid, MDCK3[playerid]);

	MDCK4[playerid] = CreatePlayerTextDraw(playerid, 251.000000, 148.875000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK4[playerid], 0.000000, 25.249992);
	PlayerTextDrawTextSize(playerid, MDCK4[playerid], 248.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK4[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK4[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK4[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK4[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK4[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK4[playerid]);

	MDCK5[playerid] = CreatePlayerTextDraw(playerid, 276.000000, 215.375000, "box");
	PlayerTextDrawLetterSize(playerid, MDCK5[playerid], 0.000000, 14.100005);
	PlayerTextDrawTextSize(playerid, MDCK5[playerid], 509.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK5[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK5[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK5[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCK5[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK5[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCK5[playerid], 0);
	PlayerTextDrawShow(playerid, MDCK5[playerid]);

	MDCK8[playerid] = CreatePlayerTextDraw(playerid, 261.000000, 170.750000, "blue_bg");
	PlayerTextDrawLetterSize(playerid, MDCK8[playerid], 0.000000, -0.300000);
	PlayerTextDrawTextSize(playerid, MDCK8[playerid], 501.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDCK8[playerid], 1);
	PlayerTextDrawColor(playerid, MDCK8[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCK8[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCK8[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCK8[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCK8[playerid], 255);
	PlayerTextDrawFont(playerid, MDCK8[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCK8[playerid], 1);
	PlayerTextDrawShow(playerid, MDCK8[playerid]);

	MDCVehicleButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 181.250000, "check_vehicle");
	PlayerTextDrawLetterSize(playerid, MDCVehicleButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCVehicleButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVehicleButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVehicleButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVehicleButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVehicleButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVehicleButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVehicleButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCVehicleButton[playerid]);

	MDCPrisonersButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 194.812500, "prisoners");
	PlayerTextDrawLetterSize(playerid, MDCPrisonersButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCPrisonersButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCPrisonersButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCPrisonersButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCPrisonersButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCPrisonersButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCPrisonersButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCPrisonersButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCPrisonersButton[playerid]);

	MDCMainButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 154.125000, "main_screen");
	PlayerTextDrawLetterSize(playerid, MDCMainButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCMainButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMainButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMainButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMainButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMainButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMainButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMainButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCMainButton[playerid]);

	MDCCitizenButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 167.687500, "check_citizen");
	PlayerTextDrawLetterSize(playerid, MDCCitizenButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCitizenButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCitizenButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCitizenButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCitizenButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCitizenButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCitizenButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCitizenButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCitizenButton[playerid]);

	MDCRosterButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 208.375000, "DUTY_ROSTER");
	PlayerTextDrawLetterSize(playerid, MDCRosterButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCRosterButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCRosterButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCRosterButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCRosterButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCRosterButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCRosterButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCRosterButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCRosterButton[playerid]);

	MDCHouseLocator[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 221.937500, "HOUSE_LOCATOR");
	PlayerTextDrawLetterSize(playerid, MDCHouseLocator[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCHouseLocator[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawColor(playerid, MDCHouseLocator[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCHouseLocator[playerid], 255);
	PlayerTextDrawFont(playerid, MDCHouseLocator[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCHouseLocator[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCHouseLocator[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCHouseLocator[playerid], true);
	PlayerTextDrawShow(playerid, MDCHouseLocator[playerid]);

	MDCCCTVsButton[playerid] = CreatePlayerTextDraw(playerid, 212.000000, 235.500000, "CCTVS");
	PlayerTextDrawLetterSize(playerid, MDCCCTVsButton[playerid], 0.158996, 0.974372);
	PlayerTextDrawTextSize(playerid, MDCCCTVsButton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCCTVsButton[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCCTVsButton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCCTVsButton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCCTVsButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCCTVsButton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCCTVsButton[playerid], true);
	PlayerTextDrawShow(playerid, MDCCCTVsButton[playerid]);

    MDCKCCTV[playerid] = CreatePlayerTextDraw(playerid, 264.000000, 151.937500, "closed_circuit_television");
	PlayerTextDrawLetterSize(playerid, MDCKCCTV[playerid], 0.410499, 1.809999);
	PlayerTextDrawAlignment(playerid, MDCKCCTV[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKCCTV[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCKCCTV[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKCCTV[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKCCTV[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKCCTV[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCKCCTV[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKCCTV[playerid], 0);
	PlayerTextDrawShow(playerid, MDCKCCTV[playerid]);
	
	MDCVeronaMall[playerid] = CreatePlayerTextDraw(playerid, 371.000000, 174.687500, "verona_mall");
	PlayerTextDrawLetterSize(playerid, MDCVeronaMall[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCVeronaMall[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVeronaMall[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVeronaMall[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCVeronaMall[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVeronaMall[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVeronaMall[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVeronaMall[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVeronaMall[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVeronaMall[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVeronaMall[playerid], true);
	PlayerTextDrawShow(playerid, MDCVeronaMall[playerid]);
	
	MDCRodeo[playerid] = CreatePlayerTextDraw(playerid, 369.500000, 188.687500, "Rodeo");
	PlayerTextDrawLetterSize(playerid, MDCRodeo[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCRodeo[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCRodeo[playerid], 2);
	PlayerTextDrawColor(playerid, MDCRodeo[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCRodeo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCRodeo[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCRodeo[playerid], 255);
	PlayerTextDrawFont(playerid, MDCRodeo[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCRodeo[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCRodeo[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCRodeo[playerid], true);
	PlayerTextDrawShow(playerid, MDCRodeo[playerid]);
	
	MDCMarketStreet[playerid] = CreatePlayerTextDraw(playerid, 369.500000, 202.250000, "market_street");
	PlayerTextDrawLetterSize(playerid, MDCMarketStreet[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCMarketStreet[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMarketStreet[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMarketStreet[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCMarketStreet[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMarketStreet[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMarketStreet[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMarketStreet[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMarketStreet[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMarketStreet[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMarketStreet[playerid], true);
	PlayerTextDrawShow(playerid, MDCMarketStreet[playerid]);
	
	MDCDowntownLS[playerid] = CreatePlayerTextDraw(playerid, 369.500000, 215.812500, "downtown_ls");
	PlayerTextDrawLetterSize(playerid, MDCDowntownLS[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCDowntownLS[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCDowntownLS[playerid], 2);
	PlayerTextDrawColor(playerid, MDCDowntownLS[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCDowntownLS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCDowntownLS[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCDowntownLS[playerid], 255);
	PlayerTextDrawFont(playerid, MDCDowntownLS[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCDowntownLS[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCDowntownLS[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCDowntownLS[playerid], true);
	PlayerTextDrawShow(playerid, MDCDowntownLS[playerid]);
	
	MDCMainStreet[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 229.375000, "main_street");
	PlayerTextDrawLetterSize(playerid, MDCMainStreet[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCMainStreet[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCMainStreet[playerid], 2);
	PlayerTextDrawColor(playerid, MDCMainStreet[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCMainStreet[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCMainStreet[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCMainStreet[playerid], 255);
	PlayerTextDrawFont(playerid, MDCMainStreet[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCMainStreet[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCMainStreet[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCMainStreet[playerid], true);
	PlayerTextDrawShow(playerid, MDCMainStreet[playerid]);
	
	MDCVinewoodBlvd[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 242.937500, "vinewood_blvd.");
	PlayerTextDrawLetterSize(playerid, MDCVinewoodBlvd[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCVinewoodBlvd[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVinewoodBlvd[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVinewoodBlvd[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCVinewoodBlvd[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVinewoodBlvd[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVinewoodBlvd[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVinewoodBlvd[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVinewoodBlvd[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVinewoodBlvd[playerid], 0);
 	PlayerTextDrawSetSelectable(playerid, MDCVinewoodBlvd[playerid], true);
	PlayerTextDrawShow(playerid, MDCVinewoodBlvd[playerid]);
	
	MDCVerdantBluffs[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 256.525054, "verdant_bluffs");
	PlayerTextDrawLetterSize(playerid, MDCVerdantBluffs[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCVerdantBluffs[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCVerdantBluffs[playerid], 2);
	PlayerTextDrawColor(playerid, MDCVerdantBluffs[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCVerdantBluffs[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCVerdantBluffs[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCVerdantBluffs[playerid], 255);
	PlayerTextDrawFont(playerid, MDCVerdantBluffs[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCVerdantBluffs[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCVerdantBluffs[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCVerdantBluffs[playerid], true);
	PlayerTextDrawShow(playerid, MDCVerdantBluffs[playerid]);
	
	MDCStarStreet[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 269.425842, "star_steet");
	PlayerTextDrawLetterSize(playerid, MDCStarStreet[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCStarStreet[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCStarStreet[playerid], 2);
	PlayerTextDrawColor(playerid, MDCStarStreet[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCStarStreet[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCStarStreet[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCStarStreet[playerid], 255);
	PlayerTextDrawFont(playerid, MDCStarStreet[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCStarStreet[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCStarStreet[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCStarStreet[playerid], true);
	PlayerTextDrawShow(playerid, MDCStarStreet[playerid]);
	
	MDCIdlewood[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 282.126617, "idlewood");
	PlayerTextDrawLetterSize(playerid, MDCIdlewood[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCIdlewood[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCIdlewood[playerid], 2);
	PlayerTextDrawColor(playerid, MDCIdlewood[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCIdlewood[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCIdlewood[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCIdlewood[playerid], 255);
	PlayerTextDrawFont(playerid, MDCIdlewood[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCIdlewood[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCIdlewood[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCIdlewood[playerid], true);
	PlayerTextDrawShow(playerid, MDCIdlewood[playerid]);
	
	MDCJefferson[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 295.027404, "jefferson");
	PlayerTextDrawLetterSize(playerid, MDCJefferson[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCJefferson[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCJefferson[playerid], 2);
	PlayerTextDrawColor(playerid, MDCJefferson[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCJefferson[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCJefferson[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCJefferson[playerid], 255);
	PlayerTextDrawFont(playerid, MDCJefferson[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCJefferson[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCJefferson[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCJefferson[playerid], true);
	PlayerTextDrawShow(playerid, MDCJefferson[playerid]);

    MDCGlenPark[playerid] = CreatePlayerTextDraw(playerid, 370.000000, 307.428161, "glen_park");
	PlayerTextDrawLetterSize(playerid, MDCGlenPark[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCGlenPark[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCGlenPark[playerid], 2);
	PlayerTextDrawColor(playerid, MDCGlenPark[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCGlenPark[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCGlenPark[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCGlenPark[playerid], 255);
	PlayerTextDrawFont(playerid, MDCGlenPark[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCGlenPark[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCGlenPark[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCGlenPark[playerid], true);
	PlayerTextDrawShow(playerid, MDCGlenPark[playerid]);

    MDCDBLaneRoad[playerid] = CreatePlayerTextDraw(playerid, 371.500000, 319.728912, "double_lane_road");
	PlayerTextDrawLetterSize(playerid, MDCDBLaneRoad[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCDBLaneRoad[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCDBLaneRoad[playerid], 2);
	PlayerTextDrawColor(playerid, MDCDBLaneRoad[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCDBLaneRoad[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCDBLaneRoad[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCDBLaneRoad[playerid], 255);
	PlayerTextDrawFont(playerid, MDCDBLaneRoad[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCDBLaneRoad[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCDBLaneRoad[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCDBLaneRoad[playerid], true);
	PlayerTextDrawShow(playerid, MDCDBLaneRoad[playerid]);
	
	MDCGanton[playerid] = CreatePlayerTextDraw(playerid, 371.399993, 332.629699, "ganton");
	PlayerTextDrawLetterSize(playerid, MDCGanton[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCGanton[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCGanton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCGanton[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCGanton[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCGanton[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCGanton[playerid], 255);
	PlayerTextDrawFont(playerid, MDCGanton[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCGanton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCGanton[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCGanton[playerid], true);
	PlayerTextDrawShow(playerid, MDCGanton[playerid]);
	
	MDCCTVOFF[playerid] = CreatePlayerTextDraw(playerid, 371.399993, 360.000000, "TURN_OFF");
	PlayerTextDrawLetterSize(playerid, MDCCTVOFF[playerid], 0.280499, 1.228124);
	PlayerTextDrawTextSize(playerid, MDCCTVOFF[playerid], 3.400000, 65.000000);
	PlayerTextDrawAlignment(playerid, MDCCTVOFF[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCTVOFF[playerid], 255);
	PlayerTextDrawSetShadow(playerid, MDCCTVOFF[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCCTVOFF[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCCTVOFF[playerid], 255);
	PlayerTextDrawFont(playerid, MDCCTVOFF[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDCCTVOFF[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCTVOFF[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCCTVOFF[playerid], true);
	PlayerTextDrawShow(playerid, MDCCTVOFF[playerid]);

	MDCKClose[playerid] = CreatePlayerTextDraw(playerid, 502.500000, 136.187500, "X");
	PlayerTextDrawLetterSize(playerid, MDCKClose[playerid], 0.421499, 1.258749);
	PlayerTextDrawAlignment(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawColor(playerid, MDCKClose[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDCKClose[playerid], 255);
	PlayerTextDrawFont(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCKClose[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCKClose[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDCKClose[playerid], true);
	PlayerTextDrawShow(playerid, MDCKClose[playerid]);
	
	
}

hook OnPlayerDisconnect(playerid, reason)
{
	MDC[playerid] = 0;

	DestroyKhawaja(playerid);
	DestroyUpdatedKHAWAJATextDraws(playerid);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_MDC_HLOCATOR:
		{
		    if(response)
			{
			    new house;
				house = strval(inputtext);
                va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste pokrenuli tra�enje kuce ID: %d", house);
				SetPlayerCheckpoint(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 2);
                house_spot[playerid] = true;
			}
		}
		case DIALOG_MDC_PLAYER: {
			if( !response ) return 1;

			if( strfind(inputtext, "_", true) == -1 ) return ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
			format(TargetName[playerid], 24, "%s", inputtext);
			OnPlayerKhawajaDataLoad(playerid, TargetName[playerid]);
			DestroyKhawaja(playerid);
			return 1;
		}
		case DIALOG_MDC_VEHICLE: {
			if( !response ) return 1;

			if( 1 <= strval(inputtext) <= MAX_VEHICLES ) {
				if( !Iter_Contains(COVehicles, strval(inputtext)) ) return ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Vozilo mora biti CO!", "Input", "Abort");
				GetVehicleMDCInfo(playerid, strval(inputtext));
			} else ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Da biste dobili vehicleid koristite komandu /dl!", "Input", "Abort");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(house_spot[playerid] == true)
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "~g~Uspjesno ste prona�li kucu.", 2000, 1);
		house_spot[playerid] = false;
	}
	return 1;
}

CMD:mdc(playerid, params[])
{
    if(!IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	if(!IsInStateVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");
	if(MDC[playerid] == 1)
	{
	    DestroyKhawaja(playerid);
		MDC[playerid] = 0;
  		CancelSelectTextDraw(playerid);
	    return true;
	}
	MDC[playerid] = 1;
	CreateKhawaja(playerid);
	
	PlayerTextDrawSetString(playerid, MDCKhawajarank[playerid], ReturnPlayerRankName(playerid));
	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    PlayerTextDrawSetString(playerid, MDCKhawajaIme[playerid], name);
	SelectTextDraw(playerid, 0xA3B4C5FF);
	return true;
}


hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(_:playertextid != INVALID_TEXT_DRAW) {
		if( playertextid == MDCKClose[playerid] ) {
			DestroyKhawaja(playerid);
            CancelSelectTextDraw(playerid);
            MDC[playerid] = 0;
		}
		if( playertextid == MDCMainButton[playerid] ) {
			CreateKhawaja(playerid);
		}
		if( playertextid == MDCCitizenButton[playerid] ) {
			ShowPlayerDialog(playerid, DIALOG_MDC_PLAYER, DIALOG_STYLE_INPUT, "Mobile Data Computer - PLAYER", "Unesite ime i prezime osobe\nNAPOMENA: Mora biti s znakom '_'!", "Input", "Abort");
            DestroyKhawaja(playerid);
            CancelSelectTextDraw(playerid);
		}
		if( playertextid == MDCVehicleButton[playerid] ) {
			ShowPlayerDialog(playerid, DIALOG_MDC_VEHICLE, DIALOG_STYLE_INPUT, "MDC - VEHICLE", "Unesite vehicleid od vozila\nNAPOMENA: Vozilo mora biti CO!", "Input", "Abort");
			DestroyKhawaja(playerid);
			CancelSelectTextDraw(playerid);
		}
		if( playertextid == MDCHouseLocator[playerid] ) { // Mora od upisanog imena izvuci SQLID jer spremanje nije po imenu
			ShowPlayerDialog(playerid, DIALOG_MDC_HLOCATOR, DIALOG_STYLE_INPUT, "*MDC - HOUSE LOCATOR", "Unesite ID kuce", "Spawn", "Close");
		}
		if( playertextid == MDCCCTVsButton[playerid] ) {
			DestroyKhawaja(playerid);
		    CreateKhawajaCCTV(playerid);

		    CCTVCar[playerid] = GetPlayerVehicleID(playerid);
			CCTVSeat[playerid] = GetPlayerVehicleSeat(playerid);
		}
		if( playertextid == MDCRosterButton[playerid] ) {
   			new
  				primary[900], sub[128],
  				callsign[128], bool:found;

			foreach(new i : Player)
      		{
         		if(Bit1_Get(gr_PDOnDuty, playerid))
         		{
         		    format(callsign, 128, "- %s", PlayerInfo[i][pCallsign]);

					format(sub, sizeof(sub), "%s %s {0964db} %s\n", ReturnPlayerRankName(i), GetName(i), (strlen(PlayerInfo[i][pCallsign]) > 1) ? (callsign) : (""));
					strcat(primary, sub);

					found = true;
				}
 			}
 			if(!found)
		 		return ShowPlayerDialog(playerid, DIALOG_MDC_CALLSIGNS, DIALOG_STYLE_MSGBOX, "MDC - DUTY ROSTER", "Nema officera na duznosti", ">>", "<<");

			ShowPlayerDialog(playerid, DIALOG_MDC_CALLSIGNS, DIALOG_STYLE_LIST, "MDC - DUTY ROSTER", primary, ">>", "<<");
		}
		if( playertextid == MDCPrisonersButton[playerid] ) {
			new
   				primary[500], sub[128], tmp[74];
   			new tmpJail[ E_JAIL_DATA ];

			if(PlayerInfo[playerid][pJailed] > 1)
   				return ShowPlayerDialog(playerid, DIALOG_MDC_PRISONERS, DIALOG_STYLE_MSGBOX, "MDC - PRISONERS", "Trenutno niko nije u zatvoru", "<<", "");

			foreach(new i : Player)
   			{
      			if(PlayerInfo[i][pJailed] == 1 || PlayerInfo[i][pJailed] == 3)
         		{
           			format(sub, sizeof(sub), "%s\n", ReturnName(i));
              		strcat(primary, sub);
              		cache_get_value_name(i,"reason"	, tmp, sizeof(tmp));
					format( tmpJail[ jReason ], MAX_PLAYER_NAME, tmp );
              	}
         	}

			ShowPlayerDialog(playerid, DIALOG_MDC_PRISONERS, DIALOG_STYLE_LIST, "MDC - PRISONERS", primary, tmp, ">>", "<<");
		}
		if( playertextid == MDCVeronaMall[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1214.4321,-1414.1563,21.5728);
   			SetPlayerCameraLookAt(playerid, 1170.7333,-1389.8752,13.5857);
		}
		if( playertextid == MDCRodeo[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 633.1311,-1191.9984,31.0443);
   			SetPlayerCameraLookAt(playerid, 614.0802,-1227.1838,19.2601);
		}
		if( playertextid == MDCMarketStreet[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 676.5728,-1385.5846,22.0300);
   			SetPlayerCameraLookAt(playerid, 713.2880,-1413.8009,13.5252);
		}
		if( playertextid == MDCDowntownLS[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1560.6653,-1169.4833,30.1000);
   			SetPlayerCameraLookAt(playerid, 1532.6934,-1155.9747,23.9063);
		}
		if( playertextid == MDCMainStreet[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1327.2209,-1536.7815,19.4297);
   			SetPlayerCameraLookAt(playerid, 1291.1997,-1559.5361,14.3732);
		}
		if( playertextid == MDCVinewoodBlvd[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1036.0162,-944.0582,49.3620);
   			SetPlayerCameraLookAt(playerid, 1099.6786,-962.1936,42.5966);
		}
		if( playertextid == MDCVerdantBluffs[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1364.0010,-1881.5579,22.6577);
   			SetPlayerCameraLookAt(playerid, 1421.0405,-1865.3901,13.5469);
		}
		if( playertextid == MDCStarStreet[playerid] ) {
	 		TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 1190.5790,-1131.9811,32.7055);
   			SetPlayerCameraLookAt(playerid, 1252.1139,-1154.8678,23.8189);
		}
		if( playertextid == MDCIdlewood[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 2117.4463,-1733.9705,21.3844);
   			SetPlayerCameraLookAt(playerid, 2073.0601,-1759.6062,13.5567);
		}
		if( playertextid == MDCJefferson[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 2252.6265,-1314.3149,51.7956);
   			SetPlayerCameraLookAt(playerid, 2308.5483,-1341.5957,23.8774);
		}
		if( playertextid == MDCGlenPark[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 2019.3241,-1272.1060,37.5837);
   			SetPlayerCameraLookAt(playerid, 1972.4698,-1229.2362,24.7738);
		}
		if(playertextid == MDCDBLaneRoad[playerid])
		{
		    TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 2711.9673,-1301.6371,62.9426);
   			SetPlayerCameraLookAt(playerid, 2739.8796,-1353.2852,45.7410);
  		}
		if( playertextid == MDCGanton[playerid] ) {
			TogglePlayerSpectating(playerid, true);
			SetPlayerCameraPos(playerid, 2711.9673,-1301.6371,62.9426);
   			SetPlayerCameraLookAt(playerid, 2739.8796,-1353.2852,45.7410);
		}
		if(playertextid == MDCCTVOFF[playerid])
		{
		    TogglePlayerSpectating(playerid, false);
		    
	     	SetTimerEx("CCTVExit", 2000, false, "i", playerid);
  		}
  		if( playertextid == MDCCGeneralButton[playerid]) {
			OnPlayerKhawajaDataLoad(playerid, TargetName[playerid]);
		}
		if( playertextid == MDCCTicketsButton[playerid]) {
			OnPlayerTicketsLoad(playerid, TargetName[playerid]);
		}
		if( playertextid == MDCCAPBButton[playerid]) {
			OnPlayerAPBLoad(playerid, TargetName[playerid]);
		}
  		if( playertextid == MDCCVehButton[playerid]) { // Mora od upisanog imena izvuci SQLID jer spremanje nije po imenu
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
  		else if(playertextid == MDCCRecordButton[playerid])
		{
		    OnPlayerArrestDataLoad(playerid, TargetName[playerid]);
  		}
	}
    return 1;
}

CMD:apb(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) )	return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	if(!IsInStateVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");

	new
		pick[ 7 ],
		suspect[24],
		desc[57],
		type;
	if( sscanf( params, "s[7] ", pick ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /apb [ list / add / delete / check]");

	if( !strcmp(pick, "list", true) )
	{
		return GetAPBList(playerid);
	}
	if( !strcmp(pick, "add", true) )
	{
		if( sscanf( params, "s[7]is[24]s[57]", pick, type, suspect, desc ) )
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /apb add [tip 1/2/3] [Ime_Prezime] [PenalCode-Zlocin]");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Tip: 1. Ne naoruzan i nije opasan | 2. Srednje opasan | 3. Naoruzan i opasan");
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
			format(string, sizeof(string), "** [HQ] ** APB ** %s je dodao APB zapis na %s **", GetName(playerid,true), suspect);
			SendRadioMessage(PlayerInfo[playerid][pMember], TEAM_YELLOW_COLOR, string);
		}
	}
	else if( !strcmp(pick, "check", true) )
		ShowPlayerDialog( playerid, DIALOG_APB_CHECK, DIALOG_STYLE_INPUT, "* APB - CHECK", "Ispod unesite ime osobe kojoj zelite provijeriti APB\n[WARNING]: Ime mora biti napisano Ime_Prezime.", "Input", "Abort");
	else if( !strcmp(pick, "delete", true) ) {

		new
			sqlid;
		if( sscanf(params, "s[7]i", pick, sqlid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /apb delete [id]");
		RemoveAPBInfo(sqlid);
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "[APB] Obrisali ste APB slot %d!", sqlid);

	}
	return 1;
}

CMD:exitcctv(playerid, params[]){

 	if(IsACop(playerid)) return SendClientMessage(playerid, COLOR_RED, "Niste Officer.");

    TogglePlayerSpectating(playerid, false);
    
    SetTimerEx("CCTVExit", 2000, false, "i", playerid);
	return 1;
}
