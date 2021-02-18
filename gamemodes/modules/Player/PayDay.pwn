#include <YSI_Coding\y_hooks>

const MAX_SOCIAL_HELP_LEVEL	= 5;
const SOCIAL_HELP 			= 1000;
const MAX_JOB_BONUS			= 500;
const MIN_FACTION_SALARY	= 400;
const PD_SD_SALARY 			= 700;
const FD_LSN_SALARY 		= 800; 
const GOV_SALARY	 		= 100; 

/*
                                                                      
	88b           d88              ad88888ba    ,ad8888ba,   88           
	888b         d888             d8"     "8b  d8"'    `"8b  88           
	88`8b       d8'88             Y8,         d8'        `8b 88           
	88 `8b     d8' 88 8b       d8 `Y8aaaaa,   88          88 88           
	88  `8b   d8'  88 `8b     d8'   `"""""8b, 88          88 88           
	88   `8b d8'   88  `8b   d8'          `8b Y8,    "88,,8P 88           
	88    `888'    88   `8b,d8'   Y8a     a8P  Y8a.    Y88P  88           
	88     `8'     88     Y88'     "Y88888P"    `"Y8888Y"Y8a 88888888888  
						d8'                                             
						d8'                             

*/

LoadPlayerPayday(playerid)
{
	inline LoadingPlayerPayday()
	{
		if(!cache_num_rows())
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO player_payday(sqlid, payday, paydaymoney, paydayhad, profit, dialog, date) \n\
					VALUES('%d', '0', '0', '0', '0', ' ', ' ')",
				PlayerInfo[playerid][pSQLID]
		);
			return 1;
		}
		cache_get_value_name_int(0, "payday"	    , PaydayInfo[playerid][pPayDay]);	
		cache_get_value_name_int(0, "paydaymoney"	, PaydayInfo[playerid][pPayDayMoney]);
		cache_get_value_name_int(0, "paydayhad"	    , PaydayInfo[playerid][pPayDayHad]);
		cache_get_value_name_int(0, "profit"		, PaydayInfo[playerid][pProfit]);
		cache_get_value_name(0, 	"dialog"	    , PaydayInfo[playerid][pPayDayDialog], 1536);
		cache_get_value_name(0, 	"date"	        , PaydayInfo[playerid][pPayDayDate], 32);
		return 1;
	}
    MySQL_PQueryInline(g_SQL, 
		using inline LoadingPlayerPayday,
		va_fquery(g_SQL, "SELECT * FROM player_payday WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "i", 
        playerid
   );
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerPayday(playerid);
	return continue(playerid);
}

SavePlayerPayday(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_payday SET payday = '%d', paydaymoney = '%d', paydayhad = '%d', profit = '%d',\n\
            dialog = '%e', date = '%e' WHERE sqlid = '%d'",
        PaydayInfo[playerid][pPayDay],
        PaydayInfo[playerid][pPayDayMoney],
        PaydayInfo[playerid][pPayDayHad],
        PaydayInfo[playerid][pProfit],
        PaydayInfo[playerid][pPayDayDialog],
        PaydayInfo[playerid][pPayDayDate],
        PlayerInfo[playerid][pSQLID]
   );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerPayday(playerid);
	return continue(playerid);
}

hook function ResetPlayerVariables(playerid)
{
    PaydayInfo[playerid][pPayDay] = 0;
    PaydayInfo[playerid][pPayDayMoney] = 0;
    PaydayInfo[playerid][pPayDayHad] = 0;
    PaydayInfo[playerid][pProfit] = 0;
    PaydayInfo[playerid][pPayDayDialog][0] = EOS;
    PaydayInfo[playerid][pPayDayDate][0] = EOS;
	return continue(playerid);
}

/*
														
	88888888888                                           
	88                                                    
	88                                                    
	88aaaaa 88       88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
	88""""" 88       88 88P'   `"8a a8"     "" I8[    ""  
	88      88       88 88       88 8b          `"Y8ba,   
	88      "8a,   ,a88 88       88 "8a,   ,aa aa    ]8I  
	88       `"YbbdP'Y8 88       88  `"Ybbd8"' `"YbbdP"'  

*/

GivePlayerPayCheck(playerid)
{
	new
		profit 				= 0,
		p_dialog[2048],
		f_dialog[256];
		
	format(p_dialog, sizeof(p_dialog), "\t{3C95C2}Financial Report - %s", GetName(playerid));
	
	if(PlayerMobile[playerid][pCryptoNumber] != 0 || PlayerMobile[playerid][pMobileCost] > 0)
	{
		format(f_dialog, sizeof(f_dialog), "\n{3C95C2}Subscription:");
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
	}
	if(PlayerMobile[playerid][pCryptoNumber] != 0)
	{
		format(f_dialog, sizeof(f_dialog), "\n\tCrypto Telecom Subscription: "COL_RED"-25$");
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		PlayerToIllegalBudgetMoney(playerid, 25);
		profit -= 50;
	}

	if(PlayerMobile[playerid][pMobileCost] > 0)
	{
		format(f_dialog, sizeof(f_dialog), "\n\tMobile expenses: "COL_RED"-%d$", PlayerMobile[playerid][pMobileCost]); 
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		PlayerToBudgetMoney(playerid, PlayerMobile[playerid][pMobileCost]);
		PlayerMobile[playerid][pMobileCost] = 0;
		profit -= PlayerMobile[playerid][pMobileCost];
		
		mysql_fquery(g_SQL, "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
			PlayerMobile[playerid][pMobileCost],
			PlayerInfo[playerid][pSQLID]
		);
	}

	format(f_dialog, sizeof(f_dialog), "\n{3C95C2}Property:");
	strcat(p_dialog, f_dialog, sizeof(p_dialog));

	if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID && PlayerKeys[playerid][pHouseKey] > 0) 
	{
		new 
			house = PlayerKeys[playerid][pHouseKey],
			houselost = 0;

		houselost += floatround( 0.001 * HouseInfo[house][hValue]);
		format(f_dialog, sizeof(f_dialog), "\n\tHouse expenses + tax: "COL_RED"-%s", FormatNumber(houselost));
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		PlayerBankToBudgetMoney(playerid, houselost);
		profit -= houselost;
	}

	if(PlayerKeys[playerid][pRentKey] != INVALID_HOUSE_ID && PlayerKeys[playerid][pRentKey] >= 0)  
	{
		new
			house = PlayerKeys[playerid][pRentKey],
			rentlost = 0;

		if(PlayerInfo[playerid][pBank] >= HouseInfo[house][hRent])
		{
			rentlost += HouseInfo[house][hRent];
			profit -= HouseInfo[house][hRent];

			PlayerBankToHouseMoneyTAX(playerid, house, HouseInfo[house][hRent]);

			format(f_dialog, sizeof(f_dialog), "\n\tHouse rent: "COL_RED"-%s", FormatNumber(rentlost));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
		else 
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "You have been evicted because your bank account can't cover rent expenses.");
			PlayerKeys[playerid][pRentKey] = INVALID_HOUSE_ID;
			PlayerKeys[playerid][pRentKey] = INVALID_HOUSE_ID;
			PlayerInfo[playerid][pSpawnChange] = 0;
			SetPlayerSpawnInfo(playerid);
		}
	}

	if(PlayerKeys[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
	{
		new 
			price = ComplexRoomInfo[PlayerKeys[playerid][pComplexRoomKey]][cValue],
			complex_id = GetComplexEnumID(PlayerKeys[playerid][pComplexRoomKey]),
			complexroomlost = 0;
		
		complexroomlost += price;
		profit -= complexroomlost;
		
		PlayerBankToComplexMoneyTAX(playerid, complex_id, complexroomlost);
		
		format(f_dialog, sizeof(f_dialog), "\n\tComplex Room Rent: "COL_RED"-%s", FormatNumber(complexroomlost));
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
	}

    if(PlayerKeys[playerid][pComplexKey] != INVALID_COMPLEX_ID) 
	{
		new 
			complex_profit = minrand(200, 1000);

		format(f_dialog, sizeof(f_dialog), "\n\t:Complex Profit "COL_GREEN"+%s", FormatNumber(complex_profit)); // Troskovi prebaceni u dobit
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		BudgetToPlayerBankMoney(playerid, complex_profit);
		profit += complex_profit;
    }

	if(PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID) 
	{
		new bizid = PlayerKeys[playerid][pBizzKey],
			possibility = minrand(0, 800);

		if(possibility >= 200) 
		{
			BudgetToBusinessMoney ( bizid, possibility);
			format(f_dialog, sizeof(f_dialog), "\n\tBusiness Profit: "COL_GREEN"+%s", FormatNumber(possibility));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
			profit += possibility;
		}
		else 
		{
			BusinessToBudgetMoney ( bizid, possibility); 
			format(f_dialog, sizeof(f_dialog), "\n\tBusiness Profit: "COL_RED"-%s", FormatNumber(possibility));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
			profit -= possibility;
		}
	}

	format(f_dialog, sizeof(f_dialog), "\n{3C95C2}Bank:");
	strcat(p_dialog, f_dialog, sizeof(p_dialog));

	if(CreditInfo[playerid][cCreditType] > 0) 
	{
		new
			creditlost = 0;
		switch(CreditInfo[playerid][cCreditType])
		{
			case 1:  
			{
				if(CreditInfo[playerid][cRate] >= 1 && CreditInfo[playerid][cRate] <= 250)
					creditlost += 50;
			}
			case 2:  
			{
				if(CreditInfo[playerid][cRate] >= 1 && CreditInfo[playerid][cRate] <= 250)
					creditlost += 100;
			}
			case 3:  
			{
				if(CreditInfo[playerid][cRate] >= 1 && CreditInfo[playerid][cRate] <= 250)
					creditlost += 250;
			}
			case 4:  
			{
				if(CreditInfo[playerid][cRate] >= 1 && CreditInfo[playerid][cRate] <= 250)
					creditlost += 400;
			}
			case 5 .. 7:  
			{
				if(CreditInfo[playerid][cUsed])
				{
					new 
						amount = CreditInfo[playerid][cAmount] / 250;
					if(CreditInfo[playerid][cRate] >= 1 && CreditInfo[playerid][cRate] <= 250)
						creditlost += amount;
				}
			}
		}
		if(PlayerInfo[playerid][pBank] < creditlost)
		{
			CreditInfo[playerid][cUnpaid]++;
			if(CreditInfo[playerid][cUnpaid] > 3) 
			{	
				if(TakePlayerProperty(playerid))
				{
					ResetCreditVars(playerid);
					SavePlayerCredit(playerid);
				}
			}
			else
			{
				format(f_dialog, sizeof(f_dialog), 
					"\n\tYou don't have enough money on bank to cover %s credit rate expense. \n\
						This is your %d. owed credit rate.\n\
						If you posess more than 3 owed credit rate obligations,\n\
						The Bank is allowed to seize "COL_RED"your properties.",
					FormatNumber(creditlost),
					CreditInfo[playerid][cUnpaid]
				);
				strcat(p_dialog, f_dialog, sizeof(p_dialog));
			}
		}
		else 
		{
			PlayerBankToBudgetMoney(playerid, creditlost); 
			CreditInfo[playerid][cRate] += 1; 
			format(f_dialog, sizeof(f_dialog), "\n\tCredit Rate: "COL_RED"-%s", FormatNumber(creditlost));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
		if(CreditInfo[playerid][cRate] >= 250) 
		{ 
			CreditInfo[playerid][cRate] 		= 0;
			CreditInfo[playerid][cCreditType] 	= 0;
			format(f_dialog, sizeof(f_dialog), "\n\tYou have sucessfully paid off your whole credit debt!");
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
		SavePlayerCredit(playerid);
	}

	if(PlayerSavings[playerid][pSavingsCool] > 0)
	{
		PlayerSavings[playerid][pSavingsCool] -= 1;
		if(PlayerSavings[playerid][pSavingsCool] < 0)
			PlayerSavings[playerid][pSavingsCool] = 0;
	}
	if(PlayerSavings[playerid][pSavingsType] > 0)
	{
		PlayerSavings[playerid][pSavingsTime]--;
		if(PlayerSavings[playerid][pSavingsTime] <= 0)
		{
			new	
				Float:savingsmoneyfloat = PlayerSavings[playerid][pSavingsMoney] 
						* floatdiv(PlayerSavings[playerid][pSavingsType], 100), 	
				savingsmoney = floatround(savingsmoneyfloat), 
				totalmoney = PlayerSavings[playerid][pSavingsMoney] + savingsmoney; 

			BudgetToPlayerBankMoney(playerid, totalmoney);

			PlayerSavings[playerid][pSavingsCool] = 30;
			PlayerSavings[playerid][pSavingsTime] = 0;
			PlayerSavings[playerid][pSavingsType] = 0;
			PlayerSavings[playerid][pSavingsMoney] = 0;

			mysql_fquery(g_SQL, 
				"UPDATE accounts SET bankMoney = '%d'WHERE sqlid = '%d'",
				PlayerInfo[playerid][pBank],
				PlayerInfo[playerid][pSQLID]
			);

			format(f_dialog, sizeof(f_dialog), "\n\t{3C95C2}Bank Savings:");
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
			format(f_dialog,
				sizeof(f_dialog), 
				"\nTerm Savings has been completed, you recieved %s on your bank account!", 
				FormatNumber(totalmoney)
			);
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
		SavePlayerSavings(playerid);
	}

	format(f_dialog, sizeof(f_dialog), "\n{3C95C2}Incomes:");
	strcat(p_dialog, f_dialog, sizeof(p_dialog));

	if(PlayerFaction[playerid][pMember] > 0)
	{
		new
			orgsalary = MIN_FACTION_SALARY,
			orgbonus = 0,
			factionbank = FactionInfo[PlayerFaction[playerid][pMember]][fFactionBank], 
			orgranks = FactionInfo[PlayerFaction[playerid][pMember]][fRanks], 					
			Float:salarypercent = 0.01;

		switch (PlayerFaction[playerid][pMember]) 
		{
			case 1, 3: 
			{ 
				for( new i = 0; i <= PlayerFaction[playerid][pRank]; i++)
					orgsalary += floatround(PD_SD_SALARY/orgranks);
			}
			case 2, 5: 
			{
				for( new i = 0; i <= PlayerFaction[playerid][pRank]; i++)
					orgsalary += floatround(FD_LSN_SALARY/orgranks);
			}
			case 4: 
			{ 
				for( new i = 0; i <= PlayerFaction[playerid][pRank]; i++)
					orgsalary += floatround(GOV_SALARY/orgranks);
			}
			default: orgsalary = 200;
		}
		BudgetToPlayerBankMoney(playerid, orgsalary);
		profit += orgsalary; 			
		orgbonus = floatround(factionbank * salarypercent);
		FactionToPlayerBankMoney(playerid, FactionInfo[PlayerFaction[playerid][pMember]][fType], orgbonus);
		orgsalary += orgbonus;

		format(f_dialog, sizeof(f_dialog), "\n\tSalary: "COL_GREEN"+%s (Bonus: %s)", FormatNumber(orgsalary), FormatNumber(orgbonus));
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
	}
	if(PaydayInfo[playerid][pPayDayMoney] > 0)
	{
		format(f_dialog, sizeof(f_dialog), "\n\tCash earned on job: "COL_GREEN"+%s", FormatNumber(PaydayInfo[playerid][pPayDayMoney]));
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		profit += PaydayInfo[playerid][pPayDayMoney];
	}
	if(PlayerVIP[playerid][pDonateRank] > 0)
	{
		new 
			vipmoney = 0;
		switch(PlayerVIP[playerid][pDonateRank])
		{
			case PREMIUM_BRONZE, PREMIUM_SILVER, PREMIUM_GOLD: 
				vipmoney = 200;
			case PREMIUM_PLATINUM: 
				vipmoney = 300;
		}
		BudgetToPlayerBankMoney(playerid, vipmoney); 
		profit += vipmoney;
		format(f_dialog, sizeof(f_dialog), "\n\tCity Office of Demography Sponsorship: "COL_GREEN"+%s", FormatNumber(vipmoney));
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
	}
	if(PlayerInfo[playerid][pLevel] < MAX_SOCIAL_HELP_LEVEL && !PlayerJob[playerid][pJob])
	{
		new 
			levelrespect = (PlayerInfo[playerid][pLevel] + 1) * 4;
		if(PlayerInfo[playerid][pRespects] <= levelrespect) 
		{ 
			new 
				level = PlayerInfo[playerid][pLevel],
				fsalary = SOCIAL_HELP / level, 
				bsalary = floatround(floatabs(fsalary));

			BudgetToPlayerBankMoney(playerid, bsalary); 
			profit += bsalary;
			format(f_dialog, sizeof(f_dialog), "\n\tSocial Help: "COL_GREEN"+%s", FormatNumber(bsalary));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
	}
	if(PlayerJob[playerid][pJob] > 0 && PlayerJob[playerid][pContractTime] >= 1)
	{
		if(!IsIllegalJob(playerid))	
		{
			new 
				workingbonus;
			workingbonus = PlayerJob[playerid][pContractTime] * 10;
			if(workingbonus > MAX_JOB_BONUS)
				workingbonus = MAX_JOB_BONUS; 
			BudgetToPlayerBankMoney(playerid, workingbonus);
			profit += workingbonus;
			format(f_dialog, sizeof(f_dialog), "\n\tJob Contract Bonus: "COL_GREEN"+%s", FormatNumber(workingbonus));
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
	}
	if(HappyHours)
		PlayerInfo[playerid][pRespects] += ( PlayerInfo[playerid][pLevel] < HappyHoursLVL) ? 2 : 1;
	else 
	{
	    if(ExpInfo[playerid][eDayPayDays] > 5)
	        PlayerInfo[playerid][pRespects] += ExpInfo[playerid][eDayPayDays];
		else
			PlayerInfo[playerid][pRespects]++;
 	}

	format(f_dialog,
		sizeof(f_dialog), 
		"\nTotal profit: %s%s "COL_YELLOW"(Izracun ne sadrzi troskove kredita i dobitke stednje)", 
		(profit > 0) ? (""COL_GREEN"+") : (""COL_LRED"-"),
		FormatNumber(profit)
	);
	strcat(p_dialog, f_dialog, sizeof(p_dialog));
	PaydayInfo[playerid][pProfit] = profit;

	PaydayInfo[playerid][pPayDayHad]++;
	PaydayInfo[playerid][pPayDay] = 0; 	

	PlayerInfo[playerid][pConnectTime]++;

	switch(PlayerVIP[playerid][pDonateRank])
	{
		case 0: 				
			PlayerJob[playerid][pFreeWorks] = NORMAL_FREE_WORKS;
		case PREMIUM_BRONZE: 	
			PlayerJob[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
		case PREMIUM_SILVER: 	
			PlayerJob[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
		case PREMIUM_GOLD: 		
			PlayerJob[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
		case PREMIUM_PLATINUM: 	
			PlayerJob[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
	}

	PlayerFish[playerid][pFishWorks] 	= 0;

	if(PlayerJob[playerid][pJob] != 0)
		PlayerJob[playerid][pContractTime]++;


	if(++PlayerGym[playerid][pGymCounter] >= 6) 
	{
		PlayerGym[playerid][pMuscle]--;
		if(PlayerGym[playerid][pMuscle] <= 0) 
			PlayerGym[playerid][pMuscle] = 0;
		else
		{
			format(f_dialog, 
				sizeof(f_dialog), 
				"\n{3C95C2}[MUSCLE]: Muscle Atrophy has reduced your Musle Level to %d!", 
				PlayerGym[playerid][pMuscle]
			);
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
			PlayerGym[playerid][pGymCounter] = 0;
		}
	}
	if(PlayerHealth[playerid][pHunger] == 5.0) 
	{
		PlayerGym[playerid][pGymCounter] += 2;
		if(PlayerGym[playerid][pGymCounter] >= 6) 
		{
			PlayerGym[playerid][pMuscle]--;
			format(f_dialog, 
				sizeof(f_dialog), 
				"\n{3C95C2}[MUSCLE]: Your Muscle Level has dropped on %d because of poor nutritional and working out habbits!", 
				PlayerGym[playerid][pMuscle]
			);
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
			PlayerGym[playerid][pGymCounter] = 0;
		}
	}
	if(PlayerGym[playerid][pGymTimes] > 0) 
	{
		PlayerGym[playerid][pGymTimes]++;
		if(PlayerGym[playerid][pGymTimes] == 4)
		{
			PlayerGym[playerid][pGymTimes] = 0;
			format(f_dialog, 
				sizeof(f_dialog), 
				"\n{3C95C2}[GYM]: You can attend a workout in gym again. Do in frequently if you want to perserve Muscle Level!", 
				PlayerGym[playerid][pMuscle]
			);
			strcat(p_dialog, f_dialog, sizeof(p_dialog));
		}
	}

	new 
		expamount = (PlayerInfo[playerid][pLevel] + 1) * 4;
	if(PlayerInfo[playerid][pRespects] == expamount) 
	{
		LevelUp(playerid);
		va_GameTextForPlayer(playerid,
			"~g~LEVEL UP!~n~%s -> %s",
			5000,
			1, 
			PlayerInfo[playerid][pLevel], 
			PlayerInfo[playerid][pLevel] + 1
		);
	}
	
	PlayerCoolDown[playerid][pCasinoCool] = 10;	
		
	new currentday, day;
	TimeFormat(Timestamp:gettimestamp(), DAY_OF_MONTH, "%d", currentday);
	TimeFormat(Timestamp:ExpInfo[playerid][eLastPayDayStamp], DAY_OF_MONTH, "%d", day);
	ExpInfo[playerid][eLastPayDayStamp] = gettimestamp();
	ExpInfo[playerid][eMonthPayDays]++;

	if(currentday == day)
		ExpInfo[playerid][eDayPayDays] ++;
	else
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 1;
	}
	if(HappyHours && PlayerInfo[playerid][pLevel] >= HappyHoursLVL && ExpInfo[playerid][eDayPayDays] >= MIN_GIVER_EXP_PAYDAYS 
		&& ExpInfo[playerid][eGivenEXP])
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 1;
		format(f_dialog, 
			sizeof(f_dialog), 
			"\n[EXP]: Since Happy Hours are activated, you are 1 PayDay away from rewarding your favourite player with /exp give."
		);
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
	}
	if(ExpInfo[playerid][eDayPayDays] >= MIN_GIVER_EXP_PAYDAYS && !ExpInfo[playerid][eGivenEXP])
	{
		format(f_dialog, 
			sizeof(f_dialog), 
			"\n[EXP]: Since this is your %d. payday today, reward your favourite player with EXP(/exp give).", 
			ExpInfo[playerid][eDayPayDays]
		);
		strcat(p_dialog, f_dialog, sizeof(p_dialog));
		va_SendClientMessage(playerid, 
			COLOR_ORANGE, 
			"[EXP]: Since this is your %d. payday today, reward your favourite player with EXP(/exp give)", 
			ExpInfo[playerid][eDayPayDays]
		);
	}
	SavePlayerExperience(playerid);
	
	strcpy(PaydayInfo[playerid][pPayDayDate], ReturnDate(), 32);

	if(!IsPlayerInAnyVehicle(playerid))
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, PaydayInfo[playerid][pPayDayDate], p_dialog, "Close", "");
	else 
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Your PayDay has arrived. (( /payday ))");

	strcpy(PaydayInfo[playerid][pPayDayDialog], p_dialog, 1536);
	PaydayInfo[playerid][pPayDayMoney] = 0;
	return 1;
}

CMD:payday(playerid, params[])
{
	ShowPlayerDialog(playerid, 
		0, 
		DIALOG_STYLE_MSGBOX, 
		PaydayInfo[playerid][pPayDayDate], 
		PaydayInfo[playerid][pPayDayDialog], 
		"Close", 
		""
	);
	return 1;
}