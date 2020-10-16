#define MINIMAL_LEGAL_BUDGET		(1000000)
#define MINIMAL_ILLEGAL_BUDGET		(100000)

/* #########################################################
City of Angels Economy module
Functions by Woo & Logan
Update accounts tablice sto se tice novaca ne treba jer se automatski odraduje na AC_GivePlayerMoney
######################################################### */
/*
// IGRAc / IGRAc

PlayerToPlayerMoney ( playerid, giveplayerid, money ) //  transakcija IGRAc - IGRAc (NEOPOREZIVA)
PlayerToPlayerMoneyTAX ( playerid, giveplayerid, money ) //  transakcija IGRAc - IGRAc (OPOREZIVA)

// IGRAc / BIZNIS

PlayerToBusinessMoneyTAX ( playerid, bizid, money ) //  transakcija IGRAc - BIZNIS (OPOREZIVA)
PlayerToBusinessMoney ( playerid, bizid, money ) //  transakcija IGRAc - BIZNIS (NEOPOREZIVA)
BusinessToPlayerMoneyTAX ( playerid, bizid, money ) // transakcija BIZNIS - IGRAc (OPOREZIVA)
BusinessToPlayerMoney ( playerid, bizid, money ) // transakcija BIZNIS - IGRAc (NEOPOREZIVA)

// IGRAc i PRORAcUN

PlayerToBudgetMoney ( playerid, money ) // transakcija IGRAc - PRORAcUN (svaka je NEOPOREZIV kao takva)
BudgetToPlayerMoney ( playerid, money ) // transakcija PRORAcUN - IGRAc (NEOPOREZIV)

// IGRAc i COMPLEX

PlayerToComplexMoney ( playerid, complexid, money ) // transakcija IGRAc - COMPLEX (NEOPOREZIV)
PlayerToComplexMoneyTAX ( playerid, complexid, money ) // transakcija IGRAc - COMPLEX (OPOREZIVA)
PlayerBankToComplexMoney ( playerid, complexid, money )// PLAYER BANKA - COMPLEX (NEOPOREZIVA)
PlayerBankToComplexMoneyTAX ( playerid, complexid, money )  // PLAYER BANKA - COMPLEX (OPOREZIVA)
ComplexToPlayerMoney ( playerid, complexid, money ) // transakcija COMPLEX - IGRAc (NEOPOREZIV)
ComplexToPlayerMoneyTAX ( playerid, complexid, money ) // transakcija COMPLEX - IGRAc (OPOREZIVA)

// IGRAc i KUcA

PlayerToHouseMoney ( playerid, houseid, money ) // transakcija IGRAc - KUcA (NEOPOREZIV)
PlayerToHouseMoneyTAX ( playerid, houseid, money )  // transakcija IGRAc - KUcA (OPOREZIVA)
PlayerBankToHouseMoneyTAX ( playerid, houseid, money )// PLAYER BANKA - KUcA 	(OPOREZIVA)
HouseToPlayerMoney ( playerid, houseid, money ) // transakcija KUcA - IGRAc (NEOPOREZIV)
HouseToPlayerMoneyTAX ( playerid, houseid, money ) // transakcija KUcA - IGRAc (OPOREZIVA)

// IGRAc i ORGANIZACIJA

PlayerToOrgMoney ( playerid, ftype, money ) // transakcija IGRAc - ORGANIZACIJA (NEOPOREZIV)
PlayerToOrgMoneyTAX ( playerid, ftype, money ) // transakcija IGRAc - ORGANIZACIJA (OPOREZIVA)
OrgToPlayerMoney ( playerid, ftype, money ) // transakcija ORGANIZACIJA - IGRAc (NEOPOREZIV)
OrgToPlayerMoneyTAX ( playerid, ftype, money ) // transakcija ORGANIZACIJA - IGRAc (OPOREZIVA)
OrgToPlayerBankMoney ( playerid, ftype, money ) // transakcija ORGANIZACIJA - IGRAc BANKA (NEOPOREZIV)

// NOVAC U ILLEGALNI BUDGET (kasnije se prebacuje i LEGAL budget)

PlayerToIllegalBudgetMoney ( playerid, money )
IllegalBudgetToPlayerMoney ( playerid, money )
WarehouseToIllegalBudgetMoney ( whid, money )

// RADNA KNJIZICA IGRAcA i PRORACUN 

PayDayToBudgetMoney (playerid, money )
BudgetToPlayerBankMoney (playerid, money )

// RADNA KNJIZICA i IGRAc

PayDayToPlayerMoney (playerid, money )

// IGRAc BANKA i IGRAc

BankToPlayerMoney (playerid, money )
PlayerToBankMoney (playerid, money )

// IGRAc BANKA i PRORAcUN

PlayerBankToBudgetMoney ( playerid, money ) // PLAYER BANKA - PRORACUN (NEOPOREZIVA)
BudgetToPlayerBankMoney ( playerid, money ) // PRORAcUN - PLAYER BANKA (NEOPOREZIVA)

// BIZNIS i PRORAcUN

BusinessToBudgetMoney ( bizid, money ) // BIZNIS - PRORACUN 	(NEOPOREZIVA)

// ORGANIZACIJA i PRORAcUN

BudgetToOrgMoney ( ftype, money ) // PRORACUN - ORGANIZACIJA 	(NEOPOREZIVA)
OrgToBudgetMoney ( ftype, money ) // ORGANIZACIJA - PRORACUN	(NEOPOREZIVA)

// ILEGALNI PRORACUN U LEGALNI

IllegalToLegalBudgetMoney (money) // Ilegalni proracun u legalni

*/
#include <YSI\y_hooks>

// LOG funkcije
stock LogTransaction ( playerid, giveplayerid, money, logtype )
{
	new TmpQuery[384], desc[64];
	switch(logtype)
	{
		case LOG_TYPE_BIZSELL: {
			new biznis = PlayerInfo[ playerid ][ pBizzKey ];
			format(desc, sizeof(desc), "Naziv firme: %s", BizzInfo[biznis][bMessage]);
		}
		case LOG_TYPE_HOUSESELL: {
			new house = PlayerInfo[ playerid ][ pHouseKey ];
			format(desc, sizeof(desc), "Adresa kuce: %s", HouseInfo[house][hAdress]);
		}
		case LOG_TYPE_VEHICLESELL: {
			new vehid 	= PlayerInfo[ playerid ][ pSpawnedCar ], vehicleName[MAX_VEHICLE_NAME];
			GetVehicleNameById(vehid, vehicleName, MAX_VEHICLE_NAME);
			if( !strcmp(VehicleInfo[vehid][vNumberPlate],"0",true) ) 
				format(desc, sizeof(desc), "Model: %s | Broj tablice: Neregist.", vehicleName);
			else
				format(desc, sizeof(desc), "Model: %s | Broj tablice: %s", vehicleName, VehicleInfo[vehid][vNumberPlate]);
		}
		case LOG_TYPE_COMPLEXSELL: {
			new complex = PlayerInfo[ playerid ][ pComplexKey ];
			format(desc, sizeof(desc), "Naziv kompleksa: %s", ComplexInfo[complex][cName]);
		}
		case LOG_TYPE_GARAGESELL: {
			new garage = PlayerInfo[ playerid ][ pGarageKey ];
			format(desc, sizeof(desc), "Adresa garaze: %s", GarageInfo[garage][gAdress]);
		}
	}
	mysql_format(g_SQL, TmpQuery, 384, "INSERT INTO `server_transactions` (`sendername`, `recievername`, `money`, `logtype`, `date`, `description`) VALUES ('%e','%e','%d','%d','%e','%e')",
		GetName(playerid, false),
		GetName(giveplayerid, false),
		money,
		logtype,
		ReturnDate(),
		desc
	);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// ########################## STOCKS 1884 ###########################################
// IGRAc - IGRAc (NEOPOREZIVA) --------------------------------------------------------
stock PlayerToPlayerMoney ( playerid, giveplayerid, money )
{
	new safemoney = floatround(floatabs(money)); 			// Apsolutna vrijednost inputa money
	
	AC_GivePlayerMoney(playerid, -safemoney); 				// jednom igracu se oduzima novac
	AC_GivePlayerMoney(giveplayerid, safemoney); 			// drugom se dodaje novac
	return 1;
}
// IGRAc - IGRAc (OPOREZIVA) ---------------------------------------------------------------------
stock PlayerToPlayerMoneyTAX ( playerid, giveplayerid, money, bool:log=false, logtype=0 )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128];											// Stringovi za mysql_tquery
	
	AC_GivePlayerMoney(playerid, -safemoney); 				// Prodavacu se oduzima cijeli iznos
	CityInfo[cBudget] += taxmoney; 							// OporeZen novac ide u proracun
	AC_GivePlayerMoney(giveplayerid, finalmoney); 			// Kupac dobiva razliku punog iznosa od kojeg se oduzeo porez
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Ako je je bool:log 1 onda se sprema u tablicu
	if(log) 
		LogTransaction ( playerid, giveplayerid, safemoney, logtype );
	return 1;
}
// IGRAc - BIZNIS (OPOREZIVA) --------------------------------------------------------------------
stock PlayerToBusinessMoneyTAX ( playerid, bizid, money)
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128], 
		TmpQuery2[128];											// Stringovi za mysql_tquery
		
	AC_GivePlayerMoney(playerid, -safemoney); 				// Igracu se oduzima puni iznos
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	BizzInfo[ bizid ][ bTill ] += finalmoney;				// Biznis dobiva razliku punog iznosa i poreza
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
		
	// Update biznisa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc - BIZNIS (NEOPOREZIVA) --------------------------------------------------------------------
stock PlayerToBusinessMoney ( playerid, bizid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
	
	AC_GivePlayerMoney( playerid, -safemoney ); 			// Igracu se oduzima puni iznos
	BizzInfo[ bizid ][ bTill ] += safemoney;				// Biznis dobiva puni iznos
	
	// Update biznisa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// BIZNIS - IGRAc (OPOREZIVA) -----------------------------------------------------------------------------
stock BusinessToPlayerMoneyTAX ( playerid, bizid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[128];
	BizzInfo[ bizid ][ bTill ] -= safemoney;				// Biznisu se oduizima puni iznos
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	AC_GivePlayerMoney(playerid, finalmoney); 				// Igrac dobiva razliku punog iznosa i poreza 
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update biznisa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}

// BIZNIS - IGRAc (NEOPOREZIVA) -----------------------------------------------------------------------------
stock BusinessToPlayerMoney ( playerid, bizid, money )
{
	new safemoney = money,//floatround(floatabs(money)),			// Puni iznos
		TmpQuery[128];
	BizzInfo[ bizid ][ bTill ] -= safemoney;				// Biznisu se oduizima puni iznos
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva puni izos
	
	// Update biznisa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// IGRAc - PRORACUN (NEOPOREZIVA) -----------------------------------------------------------------------------
stock PlayerToBudgetMoney(playerid, money )
{
	if(money == 0)
		return 0;

	new 
		safemoney = money, 			// Puni iznos
		TmpQuery[64];
	
	AC_GivePlayerMoney(playerid, -safemoney); 				// Novac se oduzima igracu
	CityInfo[cBudget] += safemoney; 						// Novac ide u proracun
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// PRORAcUN - IGRAc (NEOPOREZIVA) -----------------------------------------------------------------------------
stock BudgetToPlayerMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	CityInfo[cBudget] -= safemoney; 						// Novac se oduzima iz proracuna
	AC_GivePlayerMoney(playerid, safemoney); 				// Novac se daje igracu
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// PRORAcUN - IGRAc BANKA (NEOPOREZIVA) -----------------------------------------------------------------------------
stock BudgetToPlayerBankMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
	CityInfo[cBudget] -= safemoney; 						// Novac se oduzima iz proracuna
	PlayerInfo[playerid][pBank] += safemoney; 		//  Novac sjeda na radnu knjizicu igrac
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc BANKA - PRORACUN (NEOPOREZIVA) -------------------------------------------------------
stock PlayerBankToBudgetMoney ( playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
	PlayerInfo[ playerid ][ pBank ] -= safemoney;
	CityInfo[ cBudget ] += safemoney;
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update bank money
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc - COMPLEX (NEOPOREZIVA) -----------------------------------------------------------------------------
stock PlayerToComplexMoney (playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
	AC_GivePlayerMoney(playerid, -safemoney); 				// Novac se oduzima igracu
	ComplexInfo[ complexid ][ cTill ] += safemoney;
	
	// Update complexa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// IGRAc - COMPLEX (OPOREZIVA) --------------------------------------------------------------------
stock PlayerToComplexMoneyTAX ( playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[64],
		TmpQuery2[128];		
	AC_GivePlayerMoney(playerid, -safemoney); 				// Igracu se oduzima puni iznos
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	ComplexInfo[ complexid ][ cTill ] += finalmoney;		// Complex dobiva razliku punog iznosa i poreza
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update complexa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc BANKA - COMPLEX (NEOPOREZIVA) -------------------------------------------------------
stock PlayerBankToComplexMoney ( playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 					// Puni iznos
		TmpQuery[128],
		TmpQuery2[150];
	PlayerInfo[ playerid ][ pBank ] -= safemoney; 					// Novac se oduzima igracu s bank. racuna
	ComplexInfo[ complexid ][ cTill ] += safemoney;					// Novac ide u kompleks
	// Update complexa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update bank money accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc BANKA - COMPLEX (OPOREZIVA) -------------------------------------------------------
stock PlayerBankToComplexMoneyTAX ( playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[64],
		TmpQuery2[128],
		TmpQuery3[128];
		
	PlayerInfo[ playerid ][ pBank ] -= safemoney; 					// Novac se oduzima igracu s bank. racuna
	CityInfo[cBudget] += taxmoney; 									// Oporezivi dio ide u proracun
	ComplexInfo[ complexid ][ cTill ] += finalmoney;				// Oporezivi novac ide u kompleks
	// Update complexa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update bank money accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	// Update proracuna
	format( TmpQuery3, sizeof(TmpQuery3), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery3, "", "");
	return 1;
}
// COMPLEX - IGRAc (NEOPOREZIVA) ----------------------------------------------------------------------------
stock ComplexToPlayerMoney (playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
	ComplexInfo[ complexid ][ cTill ] -= safemoney;			// Complex gubi novac
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva novac
	// Update complexa
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

// COMPLEX - IGRAc (OPOREZIVA) --------------------------------------------------------------------
stock ComplexToPlayerMoneyTAX ( playerid, complexid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[64],
		TmpQuery2[128];
	ComplexInfo[ complexid ][ cTill ] -= safemoney;			// Complexu se oduzima puni iznos
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	AC_GivePlayerMoney(playerid, finalmoney); 				// Igracu dobiva novac poslije oporezivanja
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update complexa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `server_complex` SET `till` = '%d' WHERE `id` = '%d'",
			ComplexInfo[complexid][cTill],
			ComplexInfo[complexid][cSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc - KUcA (NEOPOREZIVA) --------------------------------------------------------------------
stock PlayerToHouseMoney ( playerid, houseid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	AC_GivePlayerMoney(playerid, -safemoney); 				// Igracu se oduzima puni iznos
	HouseInfo[ houseid ][ hTakings ] += safemoney;			// Kuca dobiva puni iznos
	// Update kuce
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `houses` SET `bank` = '%d' WHERE `id` = '%d'",
			HouseInfo[houseid][hTakings],
			HouseInfo[houseid][hSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// IGRAc - KUcA (OPOREZIVA) --------------------------------------------------------------------
stock PlayerToHouseMoneyTAX ( playerid, houseid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[64],
		TmpQuery2[128];
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	AC_GivePlayerMoney(playerid, -safemoney); 				// Igracu se oduzima puni iznos
	HouseInfo[ houseid ][ hTakings ] += finalmoney;			// Kuca dobiva razliku punog iznosa i poreza
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update kuce
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `houses` SET `bank` = '%d' WHERE `id` = '%d'",
			HouseInfo[houseid][hTakings],
			HouseInfo[houseid][hSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// PLAYER BANKA - KUCA (OPOREZIVA) -------------------------------------------------------
stock PlayerBankToHouseMoneyTAX ( playerid, houseid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[150],
		TmpQuery3[128];
	PlayerInfo[playerid][pBank] -= safemoney; 					// Igracu se oduzima puni iznos iz banke
	CityInfo[cBudget] += taxmoney; 								// Oporezivi dio ide u proracun
	HouseInfo[ houseid ][ hTakings ] += finalmoney;				// Kuca dobiva razliku punog iznosa i poreza
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update bank money accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	// Update kuce
	format( TmpQuery3, sizeof(TmpQuery3), "UPDATE `houses` SET `bank` = '%d' WHERE `id` = '%d'",
			HouseInfo[houseid][hTakings],
			HouseInfo[houseid][hSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery3, "", "");
	return 1;
}
// KUcA - IGRAc (NEOPOREZIVA) -----------------------------------------------------------------------------
stock HouseToPlayerMoney ( playerid, houseid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	
	HouseInfo[ houseid ][ hTakings ] -= safemoney;			// Kuci se oduzima puni iznos
	AC_GivePlayerMoney( playerid, safemoney ); 				// Igrac dobiva puni izos
	
	// Update kuce
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `houses` SET `bank` = '%d' WHERE `id` = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// KUcA - IGRAc (OPOREZIVA) -----------------------------------------------------------------------------
stock HouseToPlayerMoneyTAX ( playerid, houseid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[64],
		TmpQuery2[64];
	HouseInfo[ houseid ][ hTakings ] -= safemoney;			// Kuci se oduizima puni iznos
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	AC_GivePlayerMoney(playerid, finalmoney); 				// Igrac dobiva razliku punog iznosa i poreza 
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update kuce
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `houses` SET `bank` = '%d' WHERE `id` = '%d'",
			HouseInfo[houseid][hTakings],
			HouseInfo[houseid][hSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc - ORGANIZACIJA (NEOPOREZIVA) -----------------------------------------FACTIONBANK----------------------
stock PlayerToOrgMoney ( playerid, ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[128];
	AC_GivePlayerMoney(playerid, -safemoney); 					// Igracu se oduzima puni iznos
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[i][ fFactionBank ] += safemoney;		// Org factionbank dobiva puni iznos
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	return 1;
}
// IGRAc - ORGANIZACIJA (OPOREZIVA) ----------------------------------FACTIONBANK----------------------
stock PlayerToOrgMoneyTAX ( playerid, ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[64];
	
	AC_GivePlayerMoney(playerid, -safemoney); 					// Igracu se oduzima puni iznos
	CityInfo[cBudget] += taxmoney; 								// Oporezivi dio ide u proracun
	foreach(new i : Factions) 									// trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[ i ][ fFactionBank ] += finalmoney;		// Org factionbank dobiva razliku
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// ORGANIZACIJA - IGRAc (NEOPOREZIVA) -------------------------------------FACTIONBANK----------------------
stock OrgToPlayerMoney ( playerid, ftype, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[ i ][ fFactionBank ] -= safemoney;		// Org factionbank se oduzima puni iznos
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva puni izos
	return 1;
}
// ORGANIZACIJA - IGRAc (OPOREZIVA) -------------------------------------------FACTIONBANK----------------------
stock OrgToPlayerMoneyTAX ( playerid, ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[64];
		
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[ i ][ fFactionBank ] -= safemoney;		// Org factionbank se oduzima puni iznos
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	AC_GivePlayerMoney(playerid, finalmoney); 				// Igrac dobiva razliku punog iznosa i poreza 
	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// ORGANIZACIJA - IGRAc BANKA (NEOPOREZIVA) -------------------------------------FACTIONBANK----------------------
stock OrgToPlayerBankMoney ( playerid, ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[100],
		TmpQuery2[100];
		
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[ i ][ fFactionBank ] -= safemoney;		// Org factionbank se oduzima puni iznos
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	PlayerInfo[playerid][pBank] += safemoney; 					// Igrac dobiva puni izos na banku
	
	// Update accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// IGRAc - ILEGALNI PRORACUN (NEOPOREZIVA) -----------------------------------------------------------------------------
stock PlayerToIllegalBudgetMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	
	AC_GivePlayerMoney(playerid, -safemoney); 				// Novac se oduzima igracu
	CityInfo[cIllegalBudget] += safemoney; 					// Novac ide u ilegalni proracun
	// Update illegal budget
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `illegalbudget` = '%d'", 
			CityInfo[cIllegalBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// ILEGALNI PRORACUN - IGRAc (NEOPOREZIVA) -----------------------------------------------------------------------------
stock IllegalBudgetToPlayerMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	
	CityInfo[cIllegalBudget] -= safemoney; 					// Novac ide iz ilegalnog proracuna
	AC_GivePlayerMoney(playerid, safemoney); 				// Novac se daje igracu
	
	// Update illegal budget
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `illegalbudget` = '%d'", 
			CityInfo[cIllegalBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// WAREHOUSE - ILEGALNI PRORACUN (NEOPOREZIVA) -----------------------------------------------------------------------------
stock WarehouseToIllegalBudgetMoney(whid, money)
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64];
	
	WarehouseInfo[whid][whMoney] -= money;				// Novac se oduzima warehouseu
	CityInfo[cIllegalBudget] += safemoney; 					// Novac ide u ilegalni proracun
	// Update illegal budget
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `illegalbudget` = '%d'", 
			CityInfo[cIllegalBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	UpdateWarehouseMoney(whid);
	return 1;
}
// IGRAc RADNA KNJIZICA - PRORACUN (NEOPOREZIVA) -----------------------------------------------------------------------------
/*stock PayDayToBudgetMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
	
	PlayerInfo[playerid][pPayDayMoney] -= safemoney; 		//  Novac se oduzima igracu s radne knjiZice
	CityInfo[cBudget] += safemoney; 						// Novac ide u proracun
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	// Update accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `playaPDMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pPayDayMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// PRORAcUN - IGRAc RADNA KNJIZICA (NEOPOREZIVA) -----------------------------------------------------------------------------
stock BudgetToPlayerBankMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
	
	CityInfo[cBudget] -= safemoney; 						// Novac se oduzima iz proracuna
	PlayerInfo[playerid][pPayDayMoney] += safemoney; 		//  Novac sjeda na radnu knjizicu igraca
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	// Update accounts
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `accounts` SET `playaPDMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pPayDayMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// RADNA KNJIZICA - IGRAc (OPOREZIVA) -----------------------------------------------------------------------------
stock PayDayToPlayerMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];

	PlayerInfo[ playerid ][ pPayDayMoney ] -= safemoney;	// Radnoj knjizici se oduzima puni iznos
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva novac na ruke 

	
	// Update accounts (ne treba update handmoney jer se to radi u AC_GivePlayerMoney)
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `playaPDMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pPayDayMoney],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}*/
// BANKA - IGRAc (NEOPOREZIVA) -----------------------------------------------------------------------------
stock BankToPlayerMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];

	PlayerInfo[ playerid ][ pBank ] -= safemoney;			// sa bankovnog racuna se mice novac
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva novac na ruke 

	// Update accounts (ne treba update handmoney jer se to radi u AC_GivePlayerMoney)
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// IGRAc - BANKA (NEOPOREZIVA) -----------------------------------------------------------------------------
stock PlayerToBankMoney (playerid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
		
	AC_GivePlayerMoney(playerid, -safemoney); 				// Igracu se oduzima novac iz ruke
	PlayerInfo[ playerid ][ pBank ] += safemoney;			// igrac dobiva novac na banku

	// Update accounts (ne treba update handmoney jer se to radi u AC_GivePlayerMoney)
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `bankMoney` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// BIZNIS - PRORACUN (NEOPOREZIVA) -------------------------------------------------------
stock BusinessToBudgetMoney ( bizid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
		
	BizzInfo[ bizid ][ bTill ] -= safemoney; 					// Biznisu se oduzima puni iznos
	CityInfo[cBudget] += safemoney; 							// Novac ide u proracun
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update biznisa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// PRORACUN - BIZNIS (NEOPOREZIVA) -------------------------------------------------------
stock BudgetToBusinessMoney ( bizid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[64],
		TmpQuery2[128];
		
	CityInfo[cBudget] -= safemoney; 							// Novac ide u proracun
	BizzInfo[ bizid ][ bTill ] += safemoney; 					// Biznisu se oduzima puni iznos
	
	// Update proracuna
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	// Update biznisa
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'",
			BizzInfo[bizid][bTill],
			BizzInfo[bizid][bSQLID]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// PRORACUN - ORGANIZACIJA (NEOPOREZIVA)
stock BudgetToOrgMoney ( ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[128],
		TmpQuery2[64];
	
	CityInfo[cBudget] -= safemoney; 							// Puni iznos izlazi iz proracuna
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[i][ fFactionBank ] += safemoney;		// Org factionbank dobiva puni iznos
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// ORGANIZACIJA - PRORACUN(NEOPOREZIVA)
stock OrgToBudgetMoney ( ftype, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[128],
		TmpQuery2[64];
	
	
	foreach(new i : Factions) // trazi organizaciju po ftypeu
	{
		if(FactionInfo[i][fType] == ftype)
		{
			FactionInfo[i][ fFactionBank ] -= safemoney;		// Org factionbank se oduzima novac
			// Update fakcije
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
					FactionInfo[ i ][ fFactionBank ],
					FactionInfo[ i ][ fID ]
				);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			break;
		}
	}
	CityInfo[cBudget] += safemoney; 							// Iznos dolazi u proracun
	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// ILEGALNI PRORACUN - LEGALNI 
stock IllegalToLegalBudgetMoney (money)
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[82];
	
	CityInfo[cIllegalBudget] -= safemoney; 					// Novac ide iz ilegalnog proracuna
	CityInfo[cBudget] += safemoney; 						// Novac dolazi u legalni proracun

	// Update illegal budget
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = '%d', `illegalbudget` = '%d'", 
			CityInfo[cBudget],
			CityInfo[cIllegalBudget]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

// ########################## CMDS ###########################################
// Komanda za kalkulaciju poreza prebacena u PLAYER CMDS mapu
/*
#### ORGANIZACIJSKI NOVAC PO IDu A NE PO FTYPE KAKO JE SADA!!! VVVVVVV
// IGRAc - ORGANIZACIJA (NEOPOREZIVA) -----------------------------------------FACTIONBANK----------------------
stock PlayerToOrgMoney ( playerid, orgid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TmpQuery[128];
	
	AC_GivePlayerMoney(playerid, -safemoney); 					// Igracu se oduzima puni iznos
	FactionInfo[orgid][ fFactionBank ] += safemoney;
	
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
		FactionInfo[ orgid ][ fFactionBank ],
		FactionInfo[ orgid ][ fID ]
	);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

// IGRAc - ORGANIZACIJA (OPOREZIVA) ----------------------------------FACTIONBANK----------------------
stock PlayerToOrgMoneyTAX ( playerid, orgid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[64];
	
	AC_GivePlayerMoney(playerid, -safemoney); 					// Igracu se oduzima puni iznos
	CityInfo[cBudget] += taxmoney; 								// Oporezivi dio ide u proracun
	FactionInfo[ orgid ][ fFactionBank ] += finalmoney;			// Org factionbank dobiva razliku
	
	// Update fakcije
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
			FactionInfo[ i ][ fFactionBank ],
			FactionInfo[ i ][ fID ]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");

	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
// ORGANIZACIJA - IGRAc (NEOPOREZIVA) -------------------------------------FACTIONBANK----------------------
stock OrgToPlayerMoney ( playerid, orgid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		TmpQuery[128];
		
	FactionInfo[ i ][ fFactionBank ] -= safemoney;			// Org factionbank se oduzima puni iznos
	AC_GivePlayerMoney(playerid, safemoney); 				// Igrac dobiva puni izos
	
	// Update fakcije
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
			FactionInfo[ orgid ][ fFactionBank ],
			FactionInfo[ orgid ][ fID ]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}
// ORGANIZACIJA - IGRAc (OPOREZIVA) -------------------------------------------FACTIONBANK----------------------
stock OrgToPlayerMoneyTAX ( playerid, orgid, money )
{
	new safemoney = floatround(floatabs(money)), 				// Puni iznos
		TAX = CityInfo[cTax], 									// Porez
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	// Kalkulacija poreza
		taxmoney = floatround(taxmoneyfloat),					// Zaokrizivanje kalkulacija poreza
		finalmoney = safemoney - taxmoney, 						// Razlika punog iznosa i poreza
		TmpQuery[128],
		TmpQuery2[64];
		
	CityInfo[cBudget] += taxmoney; 							// Oporezivi dio ide u proracun
	FactionInfo[orgid][fFactionBank] -= safemoney;		// Org factionbank se oduzima puni iznos
	AC_GivePlayerMoney(playerid, finalmoney); 				// Igrac dobiva razliku punog iznosa i poreza 
	
	// Update fakcije
	format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_factions` SET `factionbank` = '%d' WHERE `id` = '%d'",
			FactionInfo[orgid][fFactionBank],
			FactionInfo[orgid][fID]
		);
	mysql_tquery(g_SQL, TmpQuery, "", "");

	// Update proracuna
	format( TmpQuery2, sizeof(TmpQuery2), "UPDATE `city` SET `budget` = '%d'", 
			CityInfo[cBudget]
		);
	mysql_tquery(g_SQL, TmpQuery2, "", "");
	return 1;
}
*/