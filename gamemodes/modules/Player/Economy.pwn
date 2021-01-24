#include <YSI_Coding\y_hooks>

/* 
#########################################################
Money Transactions module
Functions by Woo & Logan
######################################################### */
/*

- Functions with TAX suffix are directly taxable money transactions.
- Transaction module is used internally for managing money, tax and instant database storage.

PlayerToPlayerMoney ( playerid, giveplayerid, money) 
PlayerToPlayerMoneyTAX ( playerid, giveplayerid, money) 

PlayerToBusinessMoneyTAX ( playerid, bizid, money) 
PlayerToBusinessMoney ( playerid, bizid, money) 
BusinessToPlayerMoneyTAX ( playerid, bizid, money) 
BusinessToPlayerMoney ( playerid, bizid, money) 

PlayerToBudgetMoney ( playerid, money) 
BudgetToPlayerMoney ( playerid, money)

PlayerToComplexMoney ( playerid, complexid, money) 
PlayerToComplexMoneyTAX ( playerid, complexid, money)
PlayerBankToComplexMoney ( playerid, complexid, money)
PlayerBankToComplexMoneyTAX ( playerid, complexid, money)  
ComplexToPlayerMoney ( playerid, complexid, money)
ComplexToPlayerMoneyTAX ( playerid, complexid, money) 

PlayerToHouseMoney ( playerid, houseid, money)
PlayerToHouseMoneyTAX ( playerid, houseid, money)  
PlayerBankToHouseMoneyTAX ( playerid, houseid, money)
HouseToPlayerMoney ( playerid, houseid, money) 
HouseToPlayerMoneyTAX ( playerid, houseid, money) 

FactionToPlayerMoneyTAX ( playerid, ftype, money) 
FactionToPlayerBankMoney ( playerid, ftype, money)

PlayerToIllegalBudgetMoney ( playerid, money)
IllegalBudgetToPlayerMoney ( playerid, money)
WarehouseToIllegalBudgetMoney ( whid, money)

BudgetToPlayerBankMoney (playerid, money)

BankToPlayerMoney (playerid, money)
PlayerToBankMoney (playerid, money)

PlayerBankToBudgetMoney ( playerid, money) 
BudgetToPlayerBankMoney ( playerid, money) 

BusinessToBudgetMoney ( bizid, money)

BudgetToFactionMoney ( ftype, money) 
FactionToBudgetMoney ( ftype, money) 

IllegalToLegalBudgetMoney (money) 

*/

/*
	Function for evidenting transasctions of valuable estate
		- vehicles, houses, businesses, 
		complexes, garages etc.
*/

stock LogTransaction ( playerid, giveplayerid, money, logtype)
{
	new desc[64];
	switch(logtype)
	{
		case LOG_TYPE_BIZSELL: 
		{
			new biznis = PlayerKeys[playerid][pBizzKey];
			format(desc, sizeof(desc), "Naziv firme: %s", BizzInfo[biznis][bMessage]);
		}
		case LOG_TYPE_HOUSESELL: 
		{
			new house = PlayerKeys[playerid][pHouseKey];
			format(desc, sizeof(desc), "Adresa kuce: %s", HouseInfo[house][hAdress]);
		}
		case LOG_TYPE_VEHICLESELL: 
		{
			new vehid 	= PlayerKeys[playerid][pVehicleKey], vehicleName[MAX_VEHICLE_NAME];
			GetVehicleNameById(vehid, vehicleName, MAX_VEHICLE_NAME);
			if(!strcmp(VehicleInfo[vehid][vNumberPlate],"0",true)) 
				format(desc, sizeof(desc), "Model: %s | Broj tablice: Neregist.", vehicleName);
			else
				format(desc, sizeof(desc), "Model: %s | Broj tablice: %s", vehicleName, VehicleInfo[vehid][vNumberPlate]);
		}
		case LOG_TYPE_COMPLEXSELL: 
		{
			new complex = PlayerKeys[playerid][pComplexKey];
			format(desc, sizeof(desc), "Naziv kompleksa: %s", ComplexInfo[complex][cName]);
		}
		case LOG_TYPE_GARAGESELL: 
		{
			new garage = PlayerKeys[playerid][pGarageKey];
			format(desc, sizeof(desc), "Adresa garaze: %s", GarageInfo[garage][gAdress]);
		}
	}
	mysql_fquery_ex(g_SQL, 
		"INSERT INTO server_transactions (sendername, recievername, money, logtype, date, description) \n\
			VALUES ('%e','%e','%d','%d','%e','%e')",
		GetName(playerid, false),
		GetName(giveplayerid, false),
		money,
		logtype,
		ReturnDate(),
		desc
	);
	return 1;
}

stock PlayerToPlayerMoney ( playerid, giveplayerid, money)
{
	new safemoney = floatround(floatabs(money)); 		
	
	AC_GivePlayerMoney(playerid, -safemoney); 				
	AC_GivePlayerMoney(giveplayerid, safemoney); 			
	return 1;
}

stock PlayerToPlayerMoneyTAX ( playerid, giveplayerid, money, bool:log = false, logtype = 0)
{
	new 
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 								
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;										
	
	AC_GivePlayerMoney(playerid, -safemoney); 				 							
	AC_GivePlayerMoney(giveplayerid, finalmoney); 			
	
	CityInfo[cBudget] += taxmoney;
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	if(log) 
		LogTransaction ( playerid, giveplayerid, safemoney, logtype);
	return 1;
}

stock PlayerToBusinessMoneyTAX ( playerid, bizid, money)
{
	new 
		safemoney = floatround(floatabs(money)), 			
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;
		
	AC_GivePlayerMoney(playerid, -safemoney); 				 							

	CityInfo[cBudget] += taxmoney;
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	BizzInfo[bizid][bTill] += finalmoney;
	mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock PlayerToBusinessMoney ( playerid, bizid, money)
{
	new safemoney = floatround(floatabs(money));
	
	AC_GivePlayerMoney(playerid, -safemoney); 			
	
	BizzInfo[bizid][bTill] += safemoney;				
	mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock BusinessToPlayerMoneyTAX ( playerid, bizid, money)
{
	new
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;
						
	AC_GivePlayerMoney(playerid, finalmoney); 				

	CityInfo[cBudget] += taxmoney;
	mysql_fquery(g_SQL,"UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	BizzInfo[bizid][bTill] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock BusinessToPlayerMoney ( playerid, bizid, money)
{
	new safemoney = money;
					
	AC_GivePlayerMoney(playerid, safemoney); 			

	BizzInfo[bizid][bTill] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock PlayerToBudgetMoney(playerid, money)
{
	new safemoney = money;
	
	AC_GivePlayerMoney(playerid, -safemoney); 				
	
	CityInfo[cBudget] += safemoney; 
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);
	return 1;
}

stock BudgetToPlayerMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));

	AC_GivePlayerMoney(playerid, safemoney);

	CityInfo[cBudget] -= safemoney; 
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);
	return 1;
}

stock BudgetToPlayerBankMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));

	CityInfo[cBudget] -= safemoney; 
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);
	
	PlayerInfo[playerid][pBank] += safemoney; 
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'", 
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock PlayerBankToBudgetMoney ( playerid, money)
{
	new safemoney = floatround(floatabs(money));

	CityInfo[cBudget] += safemoney;
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	PlayerInfo[playerid][pBank] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock PlayerToComplexMoney (playerid, complexid, money)
{
	new safemoney = floatround(floatabs(money));

	AC_GivePlayerMoney(playerid, -safemoney); 		

	ComplexInfo[complexid][cTill] += safemoney;
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);
	return 1;
}

stock PlayerToComplexMoneyTAX ( playerid, complexid, money)
{
	new 
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;

	AC_GivePlayerMoney(playerid, -safemoney); 	

	CityInfo[cBudget] += taxmoney; 				
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	ComplexInfo[complexid][cTill] += finalmoney;
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);
	return 1;
}

stock PlayerBankToComplexMoney ( playerid, complexid, money)
{
	new safemoney = floatround(floatabs(money));
					
	ComplexInfo[complexid][cTill] += safemoney;				
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);

	PlayerInfo[playerid][pBank] -= safemoney; 
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock PlayerBankToComplexMoneyTAX ( playerid, complexid, money)
{
	new
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 								
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	
		taxmoney = floatround(taxmoneyfloat),				
		finalmoney = safemoney - taxmoney;	
						
	CityInfo[cBudget] += taxmoney;
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	ComplexInfo[complexid][cTill] += finalmoney;			
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);

	PlayerInfo[playerid][pBank] -= safemoney; 
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);

	
	return 1;
}

stock ComplexToPlayerMoney (playerid, complexid, money)
{
	new safemoney = floatround(floatabs(money));
				
	AC_GivePlayerMoney(playerid, safemoney); 				

	ComplexInfo[complexid][cTill] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);
	return 1;
}

stock ComplexToPlayerMoneyTAX ( playerid, complexid, money)
{
	new 
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;
						
	AC_GivePlayerMoney(playerid, finalmoney); 

	CityInfo[cBudget] += taxmoney; 
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);
	
	ComplexInfo[complexid][cTill] -= safemoney;	
	mysql_fquery(g_SQL, "UPDATE server_complex SET till = '%d' WHERE id = '%d'",
		ComplexInfo[complexid][cTill],
		ComplexInfo[complexid][cSQLID]
	);
	return 1;
}
stock PlayerToHouseMoney ( playerid, houseid, money)
{
	new safemoney = floatround(floatabs(money));	
	AC_GivePlayerMoney(playerid, -safemoney); 

	HouseInfo[houseid][hTakings] += safemoney;	
	mysql_fquery(g_SQL, "UPDATE houses SET bank = '%d' WHERE id = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
	);
	return 1;
}

stock PlayerToHouseMoneyTAX ( playerid, houseid, money)
{
	new
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	
		taxmoney = floatround(taxmoneyfloat),				
		finalmoney = safemoney - taxmoney;
							
	AC_GivePlayerMoney(playerid, -safemoney); 					
	
	CityInfo[cBudget] += taxmoney; 	
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	HouseInfo[houseid][hTakings] += finalmoney;
	mysql_fquery(g_SQL, "UPDATE houses SET bank = '%d' WHERE id = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
	);
	return 1;
}
stock PlayerBankToHouseMoneyTAX ( playerid, houseid, money)
{
	new
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 	
		taxmoney = floatround(taxmoneyfloat),				
		finalmoney = safemoney - taxmoney; 					
	
	CityInfo[cBudget] += taxmoney; 								
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	PlayerInfo[playerid][pBank] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);

	HouseInfo[houseid][hTakings] += finalmoney;
	mysql_fquery(g_SQL, "UPDATE houses SET bank = '%d' WHERE id = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
	);
	return 1;
}

stock HouseToPlayerMoney ( playerid, houseid, money)
{
	new safemoney = floatround(floatabs(money));
				
	AC_GivePlayerMoney(playerid, safemoney); 				
	
	HouseInfo[houseid][hTakings] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE houses SET bank = '%d' WHERE id = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
	);
	return 1;
}

stock HouseToPlayerMoneyTAX ( playerid, houseid, money)
{
	new 
		safemoney = floatround(floatabs(money)), 				
		TAX = CityInfo[cTax], 									
		Float:taxmoneyfloat =  safemoney * floatdiv(TAX,100), 
		taxmoney = floatround(taxmoneyfloat),					
		finalmoney = safemoney - taxmoney;			
							
	AC_GivePlayerMoney(playerid, finalmoney); 				

	CityInfo[cBudget] += taxmoney; 	
	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	HouseInfo[houseid][hTakings] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE houses SET bank = '%d' WHERE id = '%d'",
		HouseInfo[houseid][hTakings],
		HouseInfo[houseid][hSQLID]
	);
	return 1;
}

stock PlayerToIllegalBudgetMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));
	
	AC_GivePlayerMoney(playerid, -safemoney); 

	CityInfo[cIllegalBudget] += safemoney; 
	mysql_fquery(g_SQL, "UPDATE city SET illegalbudget = '%d'", CityInfo[cIllegalBudget]);
	return 1;
}

stock IllegalBudgetToPlayerMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));
	
	CityInfo[cIllegalBudget] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE city SET illegalbudget = '%d'", CityInfo[cIllegalBudget]);

	AC_GivePlayerMoney(playerid, safemoney);
	return 1;
}

stock WarehouseToIllegalBudgetMoney(whid, money)
{
	new safemoney = floatround(floatabs(money));
	
	CityInfo[cIllegalBudget] += safemoney;
	mysql_fquery(g_SQL, "UPDATE city SET illegalbudget = '%d'", CityInfo[cIllegalBudget]);
	
	WarehouseInfo[whid][whMoney] -= money;
	UpdateWarehouseMoney(whid);
	return 1;
}

stock BankToPlayerMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));		
	
	AC_GivePlayerMoney(playerid, safemoney);

	PlayerInfo[playerid][pBank] -= safemoney;
	mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'", 
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock PlayerToBankMoney (playerid, money)
{
	new safemoney = floatround(floatabs(money));
		
	AC_GivePlayerMoney(playerid, -safemoney); 				
	
	PlayerInfo[playerid][pBank] += safemoney;		
	mysql_fquery(g_SQL,  "UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'", 
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock BusinessToBudgetMoney ( bizid, money)
{
	new safemoney = floatround(floatabs(money));

	CityInfo[cBudget] += safemoney; 						
	mysql_fquery(g_SQL,  "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	BizzInfo[bizid][bTill] -= safemoney; 
	mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock BudgetToBusinessMoney ( bizid, money)
{
	new safemoney = floatround(floatabs(money));
		
	CityInfo[cBudget] -= safemoney;
	mysql_fquery(g_SQL,  "UPDATE city SET budget = '%d'", CityInfo[cBudget]);

	BizzInfo[bizid][bTill] += safemoney;
	mysql_fquery(g_SQL,  "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
		BizzInfo[bizid][bTill],
		BizzInfo[bizid][bSQLID]
	);
	return 1;
}

stock IllegalToLegalBudgetMoney (money)
{
	new safemoney = floatround(floatabs(money));
	
	CityInfo[cIllegalBudget] -= safemoney; 	
	CityInfo[cBudget] += safemoney; 

	mysql_fquery(g_SQL, "UPDATE city SET budget = '%d', illegalbudget = '%d'", 
		CityInfo[cBudget],
		CityInfo[cIllegalBudget]
	);
	return 1;
}