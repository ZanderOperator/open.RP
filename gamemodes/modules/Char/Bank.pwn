#include <YSI\y_hooks>

#define PROPERTY_TYPE_HOUSE			(1)
#define PROPERTY_TYPE_BIZZ			(2)

static stock Bit16:r_SavingsMoney<MAX_PLAYERS> = {Bit16:0, ...};

/*
	####  ######     ###    ######## 
	 ##  ##    ##   ## ##      ##    
	 ##  ##        ##   ##     ##    
	 ##   ######  ##     ##    ##    
	 ##        ## #########    ##    
	 ##  ##    ## ##     ##    ##    
	####  ######  ##     ##    ##    
*/
stock IsAtBank(playerid) {
	return IsPlayerInRangeOfPoint(playerid, 50.0, 1396.864900, -23.823700, 1001.003800);
}

/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##  	 ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

LoadPlayerCredit(playerid)
{
	new tmpQuery[150], rows;
	mysql_format(g_SQL, tmpQuery, sizeof(tmpQuery), "SELECT * FROM `player_credits` WHERE `sqlid` = '%d' LIMIT 0,1", PlayerInfo[playerid][pSQLID]);
	inline OnPlayerCreditLoad()
	{
		rows = cache_num_rows();
		if(!rows)
		{
			mysql_format(g_SQL, tmpQuery, sizeof(tmpQuery), "INSERT INTO `player_credits`(`sqlid`, `type`, `rate`, `amount`, `unpaid`, `used`) VALUES ('%d', '0', '0', '0', '0', '0')",
				PlayerInfo[ playerid ][ pSQLID ]
			);
			mysql_tquery(g_SQL, tmpQuery, "");
			return 1;
		}
			
		cache_get_value_name_int(0, "type"	, CreditInfo[playerid][cCreditType]);
		cache_get_value_name_int(0, "rate"	, CreditInfo[playerid][cRate]);
		cache_get_value_name_int(0, "amount", CreditInfo[playerid][cAmount]);
		cache_get_value_name_int(0, "unpaid", CreditInfo[playerid][cUnpaid]);
		cache_get_value_name_int(0, "used"	, CreditInfo[playerid][cUsed]);
		return 1;
	}
	mysql_tquery_inline(g_SQL, tmpQuery, using inline OnPlayerCreditLoad, "i", playerid);
	return 1;
}

SavePlayerCredit(playerid)
{
	new mysqlQuery[150];
	format(mysqlQuery, sizeof(mysqlQuery), "UPDATE `player_credits` SET `rate` = '%d', `type` = '%d', `amount` = '%d', `unpaid` = '%d', `used` = '%d' WHERE `sqlid` = '%d' LIMIT 1",
		CreditInfo[playerid][cRate],
		CreditInfo[playerid][cCreditType],
		CreditInfo[playerid][cAmount],
		CreditInfo[playerid][cUnpaid],
		CreditInfo[playerid][cUsed],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, mysqlQuery, "", "");
	return 1;
}

hook ResetPlayerVariables(playerid)
{
	Bit16_Set(r_SavingsMoney, playerid, 0);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{	
		case DIALOG_CREDIT:
		{	
			if( !response ) return 1;
			new 
				string[61];
			switch(listitem) {
				case 0: {	// mali kredit
					if(PlayerInfo[playerid][pLevel] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 5 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 10000)) return 1;
					BudgetToPlayerMoney(playerid, 10000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 10 000$.");
					format(string, sizeof(string), "* %s otvara kofer potom sprema 10.000$ u njega.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cCreditType] = 1;
					CreditInfo[playerid][cAmount] = 10000;
				}
				case 1: { 	// srednji kredit
					if(PlayerInfo[playerid][pLevel] < 7) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 7 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 25000)) return 1;
				
					BudgetToPlayerMoney(playerid, 25000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 25 000$.");
					format(string, sizeof(string), "* %s otvara kofer potom sprema 25.000$ u njega.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 2;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 25000;
				}
				case 2:  {	// veliki kredit
					if(PlayerInfo[playerid][pLevel] < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 10 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 50000)) return 1;

					BudgetToPlayerMoney(playerid, 50000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 50 000$.");
					format(string, sizeof(string), "* %s otvara kofer potom sprema 50.000$ u njega.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 3;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 50000;
				}
				case 3:  {	// veliki kredit v2
					if(PlayerInfo[playerid][pLevel] < 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 15 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 100000)) return 1;

					BudgetToPlayerMoney(playerid, 100000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 100 000$.");
					format(string, sizeof(string), "* %s otvara kofer potom sprema 100.000$ u njega.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 4;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
				}
				case 4: // Namjenski kredit za vozilo 
				{
					if(PlayerInfo[playerid][pLevel] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 4 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 100000)) return 1;

					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste potpisali namjenski kredit za kupovinu vozila do iznosa od 100 000$. Naplata se pokrece od trenutka kupovine!");
					format(string, sizeof(string), "* %s uzima penkalu te potpisuje namjenski kredit za kupovinu vozila.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 5;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
					CreditInfo[playerid][cUsed] = false;
				}
				case 5: // Namjenski kredit za kucu 
				{
					if(PlayerInfo[playerid][pLevel] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 4 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 100000)) return 1;

					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste potpisali namjenski kredit za kupovinu kuce do iznosa od 100 000$. Naplata se pokrece od trenutka kupovine!");
					format(string, sizeof(string), "* %s uzima penkalu te potpisuje namjenski kredit za kupovinu kuce.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 6;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
					CreditInfo[playerid][cUsed] = false;
				}
				case 6: // Namjenski kredit za biznis 
				{
					if(PlayerInfo[playerid][pLevel] < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 4 da biste mogli podici ovaj tip kredita.");
					if(CreditInfo[playerid][cCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
					if(!IsPlayerCredible(playerid, 100000)) return 1;

					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste potpisali namjenski kredit za kupovinu biznisa do iznosa od 100 000$. Naplata se pokrece od trenutka kupovine!");
					format(string, sizeof(string), "* %s uzima penkalu te potpisuje namjenski kredit za kupovinu biznisa.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					CreditInfo[playerid][cCreditType] = 7;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
					CreditInfo[playerid][cUsed] = false;
				}
			}
			SavePlayerCredit(playerid);
			return 1;
		}
		case DIALOG_ACCEPT_SAVINGS: 
		{
			if( !response ) return ResetSavingsVars(playerid), SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Odbili ste staviti novac na stedni racun.");
			if(response) {
			
				PlayerInfo[playerid][pSavingsCool] = 0;
				PlayerInfo[playerid][pSavingsType] = PlayerInfo[playerid][pSavingsTime];
				PlayerInfo[playerid][pBank] -= PlayerInfo[playerid][pSavingsMoney];
				
				// MySQL update
				
				new savingsQuery[256];
				format(savingsQuery, 256, "UPDATE `accounts` SET `bankMoney` = '%d', `savings_cool` = '%d', `savings_time` = '%d', `savings_type` = '%d', `savings_money` = '%d' WHERE `sqlid` = '%d'",
					PlayerInfo[playerid][pBank],
					PlayerInfo[playerid][pSavingsCool],
					PlayerInfo[playerid][pSavingsTime],
					PlayerInfo[playerid][pSavingsType],
					PlayerInfo[playerid][pSavingsMoney],
					PlayerInfo[playerid][pSQLID]
				);
				mysql_pquery(g_SQL, savingsQuery);
				
				// Message
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Orocio si %d$ na %d h po kamatnoj stopi od %d%! Novac je prebacen sa bankovnog racuna na orocenje.", FormatNumber(PlayerInfo[playerid][pSavingsMoney]), PlayerInfo[playerid][pSavingsTime], PlayerInfo[playerid][pSavingsTime]);
				
				// Log
				Log_Write("logfiles/bank_savings.txt", "(%s) Igrac %s[%d] je uzeo orocenje na %d h(Kamatna stopa: %d) i ulozio %d$.", 
					ReturnDate(), 
					GetName(playerid), 
					PlayerInfo[playerid][pSQLID], 
					PlayerInfo[playerid][pSavingsTime],
					PlayerInfo[playerid][pSavingsTime],
					PlayerInfo[playerid][pSavingsMoney]
				);
			}	
		}
		case DIALOG_VEH_PAYMENT:
		{
			if(!response) // Metoda placanja bez kredita
			{
				if(GetPlayerMoney(playerid) < paymentBuyPrice[playerid])
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca u rukama za kupovinu ovog vozila(%d$)!", paymentBuyPrice[playerid]);
				else return BuyVehicle(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Iznos kredita ne moze biti manji od 1$, ni veci od %d$!", CreditInfo[playerid][cAmount]);
				return va_ShowPlayerDialog(playerid, DIALOG_VEH_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene vozila(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
			new creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= paymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste iskoristili %d$ namjenskog kredita te ste ga aktivirali. Ostatak od %d$ ce Vam se naplatiti iz ruku!", creditamount, (paymentBuyPrice[playerid] - creditamount));
				BuyVehicle(playerid, true);
				paymentBuyPrice[playerid] = 0;
				SavePlayerCredit(playerid);
			}
			else
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Kredit od %d$ sa %d$ iz ruku nije dostatan da se namiri vrijednost vozila(%d$)!", creditamount, AC_GetPlayerMoney(playerid), paymentBuyPrice[playerid]);
				return va_ShowPlayerDialog(playerid, DIALOG_VEH_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene vozila(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
		}
		case DIALOG_HOUSE_PAYMENT:
		{
			if(!response) // Metoda placanja bez kredita
			{
				if(GetPlayerMoney(playerid) < paymentBuyPrice[playerid])
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca u rukama za kupovinu ove kuce(%d$)!", paymentBuyPrice[playerid]);
				else return BuyHouse(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Iznos kredita ne moze biti manji od 1$, ni veci od %d$!", CreditInfo[playerid][cAmount]);
				return va_ShowPlayerDialog(playerid, DIALOG_HOUSE_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene kuce(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
			new creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= paymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste iskoristili %d$ namjenskog kredita te ste ga aktivirali. Ostatak od %d$ ce Vam se naplatiti iz ruku!", creditamount, (paymentBuyPrice[playerid] - creditamount));
				BuyHouse(playerid, true);
				paymentBuyPrice[playerid] = 0;
				SavePlayerCredit(playerid);
			}
			else
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Kredit od %d$ sa %d$ iz ruku nije dostatan da se namiri vrijednost kuce(%d$)!", creditamount, AC_GetPlayerMoney(playerid), paymentBuyPrice[playerid]);
				return va_ShowPlayerDialog(playerid, DIALOG_HOUSE_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene vozila(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
		}
		case DIALOG_BIZZ_PAYMENT:
		{
			if(!response) // Metoda placanja bez kredita
			{
				if(GetPlayerMoney(playerid) < paymentBuyPrice[playerid])
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca u rukama za kupovinu ovog biznisa(%d$)!", paymentBuyPrice[playerid]);
				else return BuyHouse(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Iznos kredita ne moze biti manji od 1$, ni veci od %d$!", CreditInfo[playerid][cAmount]);
				return va_ShowPlayerDialog(playerid, DIALOG_BIZZ_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene biznisa(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
			new creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= paymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste iskoristili %d$ namjenskog kredita te ste ga aktivirali. Ostatak od %d$ ce Vam se naplatiti iz ruku!", creditamount, (paymentBuyPrice[playerid] - creditamount));
				BuyBiznis(playerid, true);
				paymentBuyPrice[playerid] = 0;
				buyBizID[playerid] = -1;
				SavePlayerCredit(playerid);
			}
			else
			{
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Kredit od %d$ sa %d$ iz ruku nije dostatan da se namiri vrijednost biznisa(%d$)!", creditamount, AC_GetPlayerMoney(playerid), paymentBuyPrice[playerid]);
				return va_ShowPlayerDialog(playerid, DIALOG_BIZZ_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene biznisa(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			}
		}
	}
	return (true);
}

CalculatePlayerBuyMoney(playerid, type)
{
	new availablemoney = 0;
	switch(type)
	{
		case BUY_TYPE_VEHICLE:
		{
			if(CreditInfo[playerid][cCreditType] == 5 && !CreditInfo[playerid][cUsed])
				availablemoney += CreditInfo[playerid][cAmount];
			availablemoney += AC_GetPlayerMoney(playerid);
		}
		case BUY_TYPE_HOUSE:
		{
			if(CreditInfo[playerid][cCreditType] == 6 && !CreditInfo[playerid][cUsed])
				availablemoney += CreditInfo[playerid][cAmount];
			availablemoney += AC_GetPlayerMoney(playerid);
		}
		case BUY_TYPE_BIZZ:
		{
			if(CreditInfo[playerid][cCreditType] == 7 && !CreditInfo[playerid][cUsed])
				availablemoney += CreditInfo[playerid][cAmount];
			availablemoney += AC_GetPlayerMoney(playerid);
		}
	}
	return availablemoney;
}

GetPlayerPaymentOption(playerid, type)
{
	switch(type)
	{
		case BUY_TYPE_VEHICLE:
		{
			if(CreditInfo[playerid][cCreditType] == 5 && !CreditInfo[playerid][cUsed])
				va_ShowPlayerDialog(playerid, DIALOG_VEH_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene vozila(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			else BuyVehicle(playerid);
		}
		case BUY_TYPE_HOUSE:
		{
			if(CreditInfo[playerid][cCreditType] == 5 && !CreditInfo[playerid][cUsed])
				va_ShowPlayerDialog(playerid, DIALOG_HOUSE_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene kuce(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			else BuyHouse(playerid);
		}
		case BUY_TYPE_BIZZ:
		{
			if(CreditInfo[playerid][cCreditType] == 5 && !CreditInfo[playerid][cUsed])
				va_ShowPlayerDialog(playerid, DIALOG_BIZZ_PAYMENT, DIALOG_STYLE_INPUT, "Iznos namjenskog kredita", "Imate dostupan kredit od %d$. Unesite koliki iznos od cijene biznisa(%d$) zelite da se naplati iz kredita:", "Unos", "Bez krede", CreditInfo[playerid][cAmount], paymentBuyPrice[playerid]);
			else BuyBiznis(playerid);
		}
	}
	return 1;
}

IsPlayerCredible(playerid, amount)
{
	new bool:value = false;
	if(PlayerInfo[playerid][pMember] > 0)
	{
		new fid = PlayerInfo[playerid][pMember];
		if(FactionInfo[fid][fType] != FACTION_TYPE_LAW && FactionInfo[fid][fType] != FACTION_TYPE_LAW2 && FactionInfo[fid][fType] != FACTION_TYPE_FD && FactionInfo[fid][fType] != FACTION_TYPE_NEWS) 	
			value = false;
		else 
		{
			value = true;
			goto end_point;
		}
	}
	if((PlayerInfo[playerid][pJob] >= 1 && PlayerInfo[playerid][pJob] <= 7) || (PlayerInfo[playerid][pJob] >= 14 && PlayerInfo[playerid][pJob] <= 18))
	{
		if(PlayerInfo[playerid][pContractTime] > 15)
		{
			value = true;
			goto end_point;
		}
		else value = false;
	}
	if(!value)
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne ispunjujete uvjete potrebne za uzimanje kredita - Posao sa +15h ugovorom ili clanstvo u legalnoj fakciji.");
	
	end_point:
	if(value)
	{
		new ratevalue = amount / 250;
		if( (PlayerInfo[playerid][pProfit] + 100) < ratevalue && PlayerInfo[playerid][pBank] < (amount * 0.7) )
		{
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati barem %d$ profita po placi/70% iznosa kredita na banci da bi mogli redovno placati kredit.", (ratevalue + 100));
			value = false;
		}
	}
	return value;
}

GetValuablePropertyType(playerid)
{
	new housevalue = 0, bizvalue = 0;
	if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID)
	{
		new houseid = PlayerInfo[playerid][pHouseKey];
		housevalue = HouseInfo[houseid][hValue];
	}
	if(PlayerInfo[playerid][pBizzKey] != INVALID_HOUSE_ID)
	{
		new bizzid = PlayerInfo[playerid][pBizzKey];
		bizvalue = BizzInfo[bizzid][bBuyPrice];
	}
	if(housevalue > bizvalue)
		return PROPERTY_TYPE_HOUSE;	
		
	return PROPERTY_TYPE_BIZZ;
}

TakePlayerProperty(playerid)
{
	if(PlayerInfo[playerid][pHouseKey] == INVALID_HOUSE_ID && PlayerInfo[playerid][pBizzKey] == INVALID_BIZNIS_ID)
		return 1;
	
	new TmpQuery[128],
		type = GetValuablePropertyType(playerid);
		
	switch(type)
	{
		case PROPERTY_TYPE_HOUSE:
		{
			new house = PlayerInfo[playerid][pHouseKey];
			
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "[BANKA]: Oduzeta vam je kuca na adresi %s zbog potrazivanja banke od %d$ radi neplacanja kredita.", 
				HouseInfo[house][hAdress],
				CreditInfo[playerid][cAmount]
			);
			PlayerInfo[playerid][pHouseKey] = INVALID_HOUSE_ID;
			
			HouseInfo[house][hOwnerID]		= 0;
			HouseInfo[house][hLock] 		= 1;
			HouseInfo[house][hSafePass] 	= 0;
			HouseInfo[house][hSafeStatus] 	= 0;
			HouseInfo[house][hOrmar] 		= 0;
				
			// Update houses table
			format(TmpQuery, 128, "UPDATE `houses` SET `ownerid` = '0' WHERE `ownerid` = '%d'", PlayerInfo[playerid][pSQLID]);
			mysql_tquery(g_SQL, TmpQuery, "", "");

			SetPlayerSpawnInfo(playerid);
			
		}
		case PROPERTY_TYPE_BIZZ:
		{
			new biz = PlayerInfo[playerid][pBizzKey];
			
			va_SendClientMessage(playerid, COLOR_LIGHTRED, "[BANKA]: Oduzet vam je biznis %s zbog potrazivanja banke od %d$ radi neplacanja kredita.", 
				BizzInfo[biz][bMessage],
				CreditInfo[playerid][cAmount]
			);
			PlayerInfo[playerid][pBizzKey] = INVALID_BIZNIS_ID;
			
			BizzInfo[biz][bLocked] 	= 1;
			BizzInfo[biz][bOwnerID] = 0;
			BizzInfo[biz][bco_OwnerID] = 0;
			
			// Update bizzes table
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `bizzes` SET `ownerid` = '0', `co_ownerid` = '0' WHERE `id` = '%d'", 
				BizzInfo[ biz ][bSQLID]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
		}
	}
	return 1;
}

ResetCreditVars(playerid)
{
	CreditInfo[playerid][cCreditType] 	= 0;
	CreditInfo[playerid][cRate] 		= 0;
	CreditInfo[playerid][cAmount] 		= 0;
	CreditInfo[playerid][cUnpaid] 		= 0;
	CreditInfo[playerid][cUsed]			= false;
	paymentBuyPrice[playerid] 			= 0;
	buyBizID[playerid] 					= -1;
	return 1;
}

ResetSavingsVars(playerid)
 {
	PlayerInfo[playerid][pSavingsCool] = 0;
	PlayerInfo[playerid][pSavingsTime] = 0;
	PlayerInfo[playerid][pSavingsType] = 0;
	PlayerInfo[playerid][pSavingsMoney] = 0;
	return (true);
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
CMD:bank(playerid, params[])
{
	if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristiti ovu komandu !");
	if( PlayerInfo[ playerid ][ pKilled ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
	
	new
		pick[ 15 ];
	if( sscanf( params, "s[15] ", pick ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /bank [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] withdraw - deposit - transfer");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] credit - checkcredit - paycredit - savings - savingsinfo");
		return 1;
	}
	if( !strcmp( pick, "withdraw", true ) ) {
		new
			moneys;
		if( sscanf( params, "s[15]i", pick, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /bank withdraw [kolicina novca]");
		if( moneys > PlayerInfo[ playerid ][ pBank ] || moneys < 1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca  na banci!");
		
		BankToPlayerMoney(playerid, moneys);
		
		new
			tmpString[ 128 ];
		format(tmpString, sizeof(tmpString), "[BANKA]: Podigli ste %d$ s vaseg racuna, Ukupno preostalo: %d$",
			moneys, 
			PlayerInfo[ playerid ][ pBank ] 
		);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, tmpString);
		
	}
	else if( !strcmp( pick, "deposit", true ) ) {
		new
			moneys, 
			curfunds = PlayerInfo[ playerid ][ pBank ];
			
		if( sscanf( params, "s[15]i", pick, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /bank deposit [kolicina novca]");
		if( moneys > AC_GetPlayerMoney(playerid) || moneys < 1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca");
		
		PlayerToBankMoney(playerid, moneys);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "[BANKA]: Uspjesno ste stavili %d$ na bankovni racun. Novi iznos: %d$", moneys, PlayerInfo[playerid][pBank]);
		// Log
		Log_Write("logfiles/bank_deposit.txt", "(%s) Igrac %s[%d] je stavio %d$ na banku. [Stara bilanca]: %d$ | [Nova bilanca]: %d$ ", 
			ReturnDate(), 
			GetName(playerid), 
			PlayerInfo[playerid][pSQLID], 
			moneys,
			curfunds,
			PlayerInfo[playerid][pBank]
		);
	}
	else if( !strcmp( pick, "transfer", true ) ) {
		new
			moneys, giveplayerid;
		if( sscanf( params, "s[15]ui", pick, giveplayerid, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /bank transfer [Playerid/DioImena][iznos]");
		if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 2+!");
		if( giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online.");
		if( moneys > 0 && PlayerInfo[ playerid ][ pBank ] >= moneys ) {

			BankTransferMoney(playerid, giveplayerid, moneys);
		
		} 
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi iznos transakcije!");
	}
	else if(!strcmp(pick, "credit", true))
	{
		if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristit ovu komandu !");
		ShowPlayerDialog(playerid, DIALOG_CREDIT, DIALOG_STYLE_LIST, "Odabir kredita:", "Kredit [10.000{088A08}$] (Potreban level: {F29A0C}5+)\nKredit [25.000{088A08}$] (Potreban level: {F29A0C}7+)\nKredit [50.000{088A08}$] (Potreban level: {F29A0C}10+)\nKredit [100.000{088A08}$] (Potreban level: {F29A0C}15+)\nKredit za vozilo[Do 100.000{088A08}$] (Potreban level: {F29A0C}5+)\nKredit za kucu[Do 100.000{088A08}$] (Potreban level: {F29A0C}5+)\nKredit za Biznis [100.000{088A08}$] (Potreban level: {F29A0C}10+)", "Izaberi", "Izadji");
	}
	else if(!strcmp(pick, "checkcredit", true))
	{
		new 
			ostatak = (251) - (CreditInfo[playerid][cRate]);
		if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristit ovu komandu !");
		
		if(CreditInfo[playerid][cCreditType] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas podignut kredit.");
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "[BANKA]: Preostalo vam je %d rata od %d za otplatu kredita.", ostatak);
		return 1;
	}
	else if(!strcmp(pick, "savings", true))
	{
		if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristit ovu komandu !");
		new money, time, buffer[128];
		if(sscanf(params, "s[15]ii", pick, time, money)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /bank savings [vrijeme] [svota]");
			SendClientMessage(playerid, COLOR_RED, "OPTION: Vrijeme: 10 - 100 In Game sati(1 sat = 1% kamate) | Svota: 1$ - 200 000$");
			return 1;
		}
		if(CreditInfo[playerid][cCreditType] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Jos niste otplatili svoj kredit te ne mozete zapoceti stednju.");
		if(PlayerInfo[playerid][pLevel] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 3+ da koristite ovu komandu!");
		if(PlayerInfo[playerid][pSavingsType] > 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati kraj stednje!");
		if(PlayerInfo[playerid][pSavingsCool]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati jos %d paydayeva da uzmete novu stednju!", PlayerInfo[playerid][pSavingsCool]);
		if((PlayerInfo[playerid][pBank] - money) < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca na bankovnom racunu!");
		if(money > 200001) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete stavljati vece svote od 200 000$!");
		if(time < 10 || time > 101) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrijeme stednje ne moze biti manje od 1h, ni vece od 100h!");
		
		format(buffer, 128, "\nJeste li sigurni da zelite staviti %s na vas stedni racun?", FormatNumber(money));
		ShowPlayerDialog(playerid, DIALOG_ACCEPT_SAVINGS, DIALOG_STYLE_MSGBOX, "* Savings - Confirm", buffer, "(da)", "(x)");
		
		PlayerInfo[playerid][pSavingsTime] = time;
		PlayerInfo[playerid][pSavingsMoney] = money;
	}
	else if(!strcmp(pick, "savingsinfo", true))
	{
		if(PlayerInfo[playerid][pLevel] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 3+ da koristite ovu komandu!");
		if(PlayerInfo[playerid][pSavingsType] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate aktivnu stednju!");
		new bankstring[128];

		format(bankstring, sizeof(bankstring), "[BANKA]: Iznos orocene stednje: [%d$] | [%d] paydaya do kraja orocene stednje | Kamatna stopa: [%d %]", 
			PlayerInfo[playerid][pSavingsMoney],
			PlayerInfo[playerid][pSavingsTime], 
			PlayerInfo[playerid][pSavingsType]);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, bankstring);
		return 1;
	}
	else if(!strcmp(pick, "paycredit", true))
	{
		if( PlayerInfo[ playerid ][ pKilled ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
		new 
			rest = (251 - CreditInfo[playerid][cRate]), 
			money, 
			cashdeposit;
			
		if (sscanf(params, "s[15]i", pick, cashdeposit)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /bank paycredit [kolicina rata]");
			if(CreditInfo[playerid][cUnpaid] > 0)
				va_SendClientMessage(playerid, COLOR_LIGHTRED, "[BANKA]: Imate %d neplacenih rata kredita, tako da se prvo ona podmiruju!", CreditInfo[playerid][cUnpaid]);
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Imate jos %d rata za otplatiti.", rest);
			return 1;
		}

		if(CreditInfo[playerid][cCreditType] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ti nemas dignut kredit");
		if( AntiSpamInfo[ playerid ][ asCreditPay ] > gettimestamp() ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BANK_CREDITPAY);
		if (cashdeposit > rest || cashdeposit < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko rata !");
		
		if(CreditInfo[playerid][cUnpaid] > 0)
		{
			if (cashdeposit > CreditInfo[playerid][cUnpaid] || cashdeposit < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko neplacenih rata !");
			money = cashdeposit * (CreditInfo[playerid][cAmount] / 250);
			if(AC_GetPlayerMoney(playerid) >= money) 
			{
				PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
				CreditInfo[playerid][cUnpaid] -= cashdeposit;
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata koje ste dugovali za $%d.", cashdeposit, money);
				if(CreditInfo[playerid][cUnpaid] == 0)
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "[BANKA]: Uspjesno ste otplatili sve neplacene rate kredita. Nemojte se dovesti opet u istu situaciju.");
					
				goto mysql_save;
			}
			else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata !", money, cashdeposit);
		}
		switch(CreditInfo[playerid][cCreditType])
		{
			case 1:
			{
				money = cashdeposit * 50;
				if(AC_GetPlayerMoney(playerid) >= money) {
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					CreditInfo[playerid][cRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(CreditInfo[playerid][cRate] >= 251) {
						CreditInfo[playerid][cRate] = 0;
						CreditInfo[playerid][cCreditType] = 0;
						SendClientMessage(playerid, COLOR_NICERED, "Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata !", money, cashdeposit);
			}
			case 2:
			{
				money = cashdeposit * 100;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					CreditInfo[playerid][cRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(CreditInfo[playerid][cRate] >= 251)
					{
						CreditInfo[playerid][cRate] = 0;
						CreditInfo[playerid][cCreditType] = 0;
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata !", money, cashdeposit);
			}
			case 3:
			{
				money = cashdeposit * 250;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					CreditInfo[playerid][cRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(CreditInfo[playerid][cRate] >= 251) {
						ResetCreditVars(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata !", money, cashdeposit);
			}
			case 4:
			{
				money = cashdeposit * 500;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					CreditInfo[playerid][cRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(CreditInfo[playerid][cRate] >= 251) {
						ResetCreditVars(playerid);
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata !", money, cashdeposit);
			}
			case 5 .. 7:
			{
				if (cashdeposit > CreditInfo[playerid][cRate] || cashdeposit < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko rata kredita !");
				money = cashdeposit * (CreditInfo[playerid][cAmount] / 250);
				if(AC_GetPlayerMoney(playerid) >= money) 
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					CreditInfo[playerid][cUnpaid] -= cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata namjenskog kredita za $%d.", cashdeposit, money);
				}
				else return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebate imati %d$ da bi otplatili %d rata kredita!", money, cashdeposit);
			}
		}
		mysql_save:
		
		
		SavePlayerCredit(playerid);
		
		new log[86];
		format( log, 86, "%s je platio %d rata kredita za $%d", GetName(playerid, false), cashdeposit, money);
		LogCreditPay(log);
		
		AntiSpamInfo[ playerid ][ asCreditPay ] = gettimestamp() + ANTI_SPAM_BANK_CREDITPAY;
		return 1;
	}
	return 1;
}
