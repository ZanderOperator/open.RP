#include <YSI_Coding\y_hooks>

const PROPERTY_TYPE_HOUSE			= 1;
const PROPERTY_TYPE_BIZZ			= 2;
const PROPERTY_TYPE_VEHICLE			= 3;
const MAX_CREDIT_USAGE_TIME			= (3600*3); // 3h
const MAX_SAVINGS_AMOUNT			= (200000); // Maximum of 200.000$ can be put on bank savings at once
const MAX_SAVINGS_TIME				= 100; // 100 hours = 100% interest rate | 1 hour = 1% interest rate

static 
	PaymentBuyPrice[MAX_PLAYERS];

Player_SetBuyPrice(playerid, amount)
{
	PaymentBuyPrice[playerid] = amount;
}
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

LoadPlayerCredit(playerid)
{
	inline OnPlayerCreditLoad()
	{
		if(!cache_num_rows())
		{
			mysql_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					player_credits \n\
				(sqlid, type, rate, amount, unpaid, used, timestamp) \n\
				VALUES \n\
					('%d', '0', '0', '0', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name_int(0, "type"		, CreditInfo[playerid][cCreditType]);
		cache_get_value_name_int(0, "rate"		, CreditInfo[playerid][cRate]);
		cache_get_value_name_int(0, "amount"	, CreditInfo[playerid][cAmount]);
		cache_get_value_name_int(0, "unpaid"	, CreditInfo[playerid][cUnpaid]);
		cache_get_value_name_int(0, "used"		, CreditInfo[playerid][cUsed]);
		cache_get_value_name_int(0, "timestamp"	, CreditInfo[playerid][cTimestamp]);
		return 1;
	}
	MySQL_TQueryInline(SQL_Handle(),  
		using inline OnPlayerCreditLoad, 
		va_fquery(SQL_Handle(), "SELECT * FROM player_credits WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
		"i", 
		playerid
	);
	return 1;
}

SavePlayerCredit(playerid)
{
	mysql_fquery(SQL_Handle(), 
		"UPDATE player_credits SET rate = '%d', type = '%d', amount = '%d',\n\
			unpaid = '%d', used = '%d', timestamp = '%d' WHERE sqlid = '%d'",
		CreditInfo[playerid][cRate],
		CreditInfo[playerid][cCreditType],
		CreditInfo[playerid][cAmount],
		CreditInfo[playerid][cUnpaid],
		CreditInfo[playerid][cUsed],
		CreditInfo[playerid][cTimestamp],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

LoadPlayerSavings(playerid)
{
	inline LoadingPlayerSavings()
	{
		if(!cache_num_rows())
		{
			mysql_fquery(SQL_Handle(), 
				"INSERT INTO \n\
					player_savings \n\
				(sqlid, savings_cool, savings_time, savings_type, savings_money) \n\
				VALUES \n\
					('%d', '0', '0', '0', '0')",
				PlayerInfo[playerid][pSQLID]
			);
			return 1;
		}
		cache_get_value_name_int(0,	"savings_cool"	, PlayerSavings[playerid][pSavingsCool]);
		cache_get_value_name_int(0,	"savings_time"	, PlayerSavings[playerid][pSavingsTime]);
		cache_get_value_name_int(0,	"savings_type"	, PlayerSavings[playerid][pSavingsType]);
		cache_get_value_name_int(0,	"savings_money"	, PlayerSavings[playerid][pSavingsMoney]);
		return 1;
	}

    MySQL_TQueryInline(SQL_Handle(), 
		using inline LoadingPlayerSavings,
        va_fquery(SQL_Handle(), "SELECT * FROM player_savings WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "i", 
        playerid
   	);
    return 1;
}


SavePlayerSavings(playerid)
{
    mysql_fquery(SQL_Handle(),
        "UPDATE player_savings SET savings_cool = '%d', savings_time = '%d', savings_type = '%d',\n\
            savings_money = '%d' WHERE sqlid = '%d'",
        PlayerSavings[playerid][pSavingsCool],
        PlayerSavings[playerid][pSavingsTime],
        PlayerSavings[playerid][pSavingsType],
        PlayerSavings[playerid][pSavingsMoney],
        PlayerInfo[playerid][pSQLID]
   	);
    return 1;
}


/*

	88                  db              88888888ba                         88         
	88                 d88b       ,d    88      "8b                        88         
	88                d8'`8b      88    88      ,8P                        88         
	88 ,adPPYba,     d8'  `8b   MM88MMM 88aaaaaa8P' ,adPPYYba, 8b,dPPYba,  88   ,d8   
	88 I8[    ""    d8YaaaaY8b    88    88""""""8b, ""     `Y8 88P'   `"8a 88 ,a8"    
	88  `"Y8ba,    d8""""""""8b   88    88      `8b ,adPPPPP88 88       88 8888[      
	88 aa    ]8I  d8'        `8b  88,   88      a8P 88,    ,88 88       88 88`"Yba,   
	88 `"YbbdP"' d8'          `8b "Y888 88888888P"  `"8bbdP"Y8 88       88 88   `Y8a                                                                              
*/


stock IsAtBank(playerid) 
{
	if(!Bizz_Exists(Player_InBusiness(playerid)))
		return 0;
	new 
		bizzid = Player_InBusiness(playerid);
	if(BizzInfo[bizzid][bType] == BIZZ_TYPE_BANK)
		return 1;
	return 0; 
}

/*
                                                          
	88        88                         88                   
	88        88                         88                   
	88        88                         88                   
	88aaaaaaaa88  ,adPPYba,   ,adPPYba,  88   ,d8  ,adPPYba,  
	88""""""""88 a8"     "8a a8"     "8a 88 ,a8"   I8[    ""  
	88        88 8b       d8 8b       d8 8888[      `"Y8ba,   
	88        88 "8a,   ,a8" "8a,   ,a8" 88`"Yba,  aa    ]8I  
	88        88  `"YbbdP"'   `"YbbdP"'  88   `Y8a `"YbbdP"'  

*/


hook function LoadPlayerStats(playerid)
{
	LoadPlayerCredit(playerid);
	LoadPlayerSavings(playerid);
	return continue(playerid);
}

hook function SavePlayerStats(playerid)
{
	SavePlayerCredit(playerid);
	SavePlayerSavings(playerid);
	return continue(playerid);
}


hook function ResetPlayerVariables(playerid)
{
	ResetCreditVars(playerid);
	ResetSavingsVars(playerid);
	PaymentBuyPrice[playerid] = 0;
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{	
		case DIALOG_CREDIT:
		{	
			if(!response) 
				return 1;

			new 
				string[144];
			switch(listitem) 
			{
				case 0: 
				{	// Small Loan(10.000$)
					if(PlayerInfo[playerid][pLevel] < 5) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 5 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 10000)) 
						return 1;
					
					BudgetToPlayerMoney(playerid, 10000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Congratulations, you just got an 10.000$ loan from bank.");
					format(string, sizeof(string), "* %s takes 10.000$ from the bank counter.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cCreditType] = 1;
					CreditInfo[playerid][cAmount] = 10000;
				}
				case 1: 
				{ 	// Medium Loan(25.000$)
					if(PlayerInfo[playerid][pLevel] < 7) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 7 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 25000)) 
						return 1;
				
					BudgetToPlayerMoney(playerid, 25000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Congratulations, you just got an 25.000$ loan from bank.");
					format(string, sizeof(string), "* %s takes 25.000$ from the bank counter.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cCreditType] = 2;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 25000;
				}
				case 2:  
				{	// Big Loan(50.000$)
					if(PlayerInfo[playerid][pLevel] < 10) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 10 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 50000)) 
						return 1;

					BudgetToPlayerMoney(playerid, 50000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Congratulations, you just got an 50.000$ loan from bank.");
					format(string, sizeof(string), "* %s takes 50.000$ from the bank counter.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cCreditType] = 3;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 50000;
				}
				case 3:  
				{	// Largest Cash Loan(100.000$)
					if(PlayerInfo[playerid][pLevel] < 15) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 15 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 100000)) return 1;

					BudgetToPlayerMoney(playerid, 100000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Congratulations, you just got an 100.000$ loan from bank.");
					format(string, sizeof(string), "* %s takes 100.000$ from the bank counter.", GetName(playerid, true));
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cCreditType] = 4;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
				}
				case 4: 
				{	// Vehicle Buyment(up to 50.000$)
					if(PlayerInfo[playerid][pLevel] < 5) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 5 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 50000)) 
						return 1;

					va_ShowPlayerDialog(playerid, 
						0,
						DIALOG_STYLE_MSGBOX,
						"Vehicle Buyment Contract",
						"\n"COL_WHITE"You just signed a vehicle buyment contract.\n\n\
							Contract covers up to 50.000$ expenses in buying vehicle.\n\
							You have "COL_YELLOW"%d "COL_WHITE"hours to fulfill your vehicle buying obligation.\n\n\
							If you "COL_RED"fail "COL_WHITE"to buy new vehicle in %d hours,\n\
							"COL_RED"Vehicle Buyment Contract becomes invalid!",
						"Okay",
						"",
						(MAX_CREDIT_USAGE_TIME/3600),
						(MAX_CREDIT_USAGE_TIME/3600)
					);
					format(string, 
						sizeof(string), 
						"* %s takes his pencil and signs Vehicle Buyment contract with bank.", 
						GetName(playerid, true)
					);
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cCreditType] = 5;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 50000;
					CreditInfo[playerid][cUsed] = false;
					CreditInfo[playerid][cTimestamp] = gettimestamp() + MAX_CREDIT_USAGE_TIME;
				}
				case 5: 
				{	// Vehicle Buyment(up to 100.000$)
					if(PlayerInfo[playerid][pLevel] < 5) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 5 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 100000)) 
						return 1;
					
					va_ShowPlayerDialog(playerid, 
						0,
						DIALOG_STYLE_MSGBOX,
						"House Buyment Contract",
						"\n"COL_WHITE"You just signed a house buyment contract.\n\n\
							Contract covers up to 100.000$ expenses in buying house.\n\
							You have "COL_YELLOW"%d "COL_WHITE"hours to fulfill your house buying obligation.\n\n\
							If you "COL_RED"fail "COL_WHITE"to buy new house in %d hours,\n\
							"COL_RED"House Buyment Contract becomes invalid!",
						"Okay",
						"",
						(MAX_CREDIT_USAGE_TIME/3600),
						(MAX_CREDIT_USAGE_TIME/3600)
					);
					format(string, 
						sizeof(string), 
						"* %s takes his pencil and signs House Leasing contract with bank.", 
						GetName(playerid, true)
					);
					ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					CreditInfo[playerid][cCreditType] = 6;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
					CreditInfo[playerid][cUsed] = false;
					CreditInfo[playerid][cTimestamp] = gettimestamp() + MAX_CREDIT_USAGE_TIME;
				}
				case 6: // Namjenski kredit za biznis 
				{
					if(PlayerInfo[playerid][pLevel] < 10) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at least Level 10 to raise this credit.");
					if(CreditInfo[playerid][cCreditType] >= 1) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "To get this credit, you need to pay off previous one first.");
					if(!IsPlayerCredible(playerid, 100000)) 
						return 1;

					va_ShowPlayerDialog(playerid, 
						0,
						DIALOG_STYLE_MSGBOX,
						"Business Buyment Contract",
						"\n"COL_WHITE"You just signed a business buyment contract.\n\n\
							Contract covers up to 100.000$ expenses in buying business.\n\
							You have "COL_YELLOW"%d "COL_WHITE"hours to fulfill your business buying obligation.\n\n\
							If you "COL_RED"fail "COL_WHITE"to buy new business in %d hours,\n\
							"COL_RED"Business Buyment Contract becomes invalid!",
						"Okay",
						"",
						(MAX_CREDIT_USAGE_TIME/3600),
						(MAX_CREDIT_USAGE_TIME/3600)
					);
					format(string, 
						sizeof(string), 
						"* %s takes his pencil and signs Business Leasing contract with bank.", 
						GetName(playerid, true)
					);
					
					CreditInfo[playerid][cCreditType] = 7;	
					CreditInfo[playerid][cRate] = 1;
					CreditInfo[playerid][cAmount] = 100000;
					CreditInfo[playerid][cUsed] = false;
					CreditInfo[playerid][cTimestamp] = gettimestamp() + MAX_CREDIT_USAGE_TIME;
				}
			}
			SavePlayerCredit(playerid);
			return 1;
		}
		case DIALOG_ACCEPT_SAVINGS: 
		{
			if(!response)
			{ 
				ResetSavingsVars(playerid);
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have refused to put money on savings.");
			}

			PlayerSavings[playerid][pSavingsCool] = 0;
			PlayerSavings[playerid][pSavingsType] = PlayerSavings[playerid][pSavingsTime];
			PlayerInfo[playerid][pBank] -= PlayerSavings[playerid][pSavingsMoney];
						
			mysql_fquery(SQL_Handle(), 
				"UPDATE accounts SET bankMoney = '%d' WHERE sqlid = '%d'",
				PlayerInfo[playerid][pBank],
				PlayerInfo[playerid][pSQLID]
			);
			SavePlayerSavings(playerid);
			
			// Message
			va_SendMessage(playerid, 
				MESSAGE_TYPE_INFO, 
				"You've invested %s from bank account to term savings lasting %d hours with %d% of interest.", 
				FormatNumber(PlayerSavings[playerid][pSavingsMoney]), 
				PlayerSavings[playerid][pSavingsTime], 
				PlayerSavings[playerid][pSavingsTime]
			);
			
			#if defined MODULE_LOGS
			Log_Write("logfiles/bank_savings.txt", 
				"(%s) Player %s[%d] started savings in bank for %dh(Interest rate at the end of savings: %d%) and invested %d$.", 
				ReturnDate(), 
				GetName(playerid), 
				PlayerInfo[playerid][pSQLID], 
				PlayerSavings[playerid][pSavingsTime],
				PlayerSavings[playerid][pSavingsTime],
				FormatNumber(PlayerSavings[playerid][pSavingsMoney])
			);
			#endif
			return 1;
		}
		case DIALOG_VEH_PAYMENT:
		{
			if(!response) // Creditless purchase method
			{
				if(AC_GetPlayerMoney(playerid) < PaymentBuyPrice[playerid])
				{
					return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"You don't have enough money on you to buy this vehicle. ~r~(%s)", 
						FormatNumber(PaymentBuyPrice[playerid])
					);
				}
				else return BuyVehicle(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"Input can't be smaller than 1$ or larger than %s!", 
					FormatNumber(CreditInfo[playerid][cAmount])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_VEH_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Vehicle Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via VBC(credit).\n\
						Please input how much from the vehicle(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			new 
				creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= PaymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				
			 	BuyVehicle(playerid, true);
				PaymentBuyPrice[playerid] = 0;
				SavePlayerCredit(playerid);

				va_SendMessage(playerid, 
					MESSAGE_TYPE_SUCCESS, 
					"You have sucessfully used %s from VSC credit. The rest of the price (%s) you paid from your hands!", 
					FormatNumber(creditamount), 
					FormatNumber(PaymentBuyPrice[playerid] - creditamount)
				);
			}
			else
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"%s credit with %s that you have in hands is not enough to cover expenses of vehicle(%s)!", 
					FormatNumber(creditamount), 
					FormatNumber(AC_GetPlayerMoney(playerid)), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_VEH_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Vehicle Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via VBC(credit).\n\
						Please input how much from the vehicle(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			return 1;
		}
		case DIALOG_HOUSE_PAYMENT:
		{
			if(!response) // Creditless purchase method
			{
				if(AC_GetPlayerMoney(playerid) < PaymentBuyPrice[playerid])
				{
					return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"You don't have enough money on you to buy this house. ~r~(%s)", 
						FormatNumber(PaymentBuyPrice[playerid])
					);
				}
				else return BuyHouse(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"Credit amount can't be smaller than 1$, or larger than %d$!", 
					FormatNumber(CreditInfo[playerid][cAmount])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_HOUSE_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"House Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via HBC(credit).\n\
						Please input how much from the house(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			new 
				creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= PaymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				BuyHouse(playerid, true);
				PaymentBuyPrice[playerid] = 0;
				SavePlayerCredit(playerid);

				va_SendMessage(playerid, 
					MESSAGE_TYPE_SUCCESS, 
					"You have sucessfully used %s from HBC credit. The rest of the price (%s) you paid from your hands!", 
					FormatNumber(creditamount), 
					FormatNumber(PaymentBuyPrice[playerid] - creditamount)
				);
			}
			else
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"%s credit with %s that you have in hands is not enough to cover expenses of house. (%s)", 
					FormatNumber(creditamount), 
					FormatNumber(AC_GetPlayerMoney(playerid)), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_HOUSE_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"House Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via HBC(credit).\n\
						Please input how much from the house(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			return 1;
		}
		case DIALOG_BIZZ_PAYMENT:
		{
			if(!response) // Creditless purchase method
			{
				if(AC_GetPlayerMoney(playerid) < PaymentBuyPrice[playerid])
				{
					return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"You don't have enough money on you to buy this business. ~r~(%s)", 
						FormatNumber(PaymentBuyPrice[playerid])
					);
				}
				else return BuyBiznis(playerid);
			}
			if(strval(inputtext) < 1 || strval(inputtext) > CreditInfo[playerid][cAmount])
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"Input can't be smaller than 1$ or larger than %s!", 
					FormatNumber(CreditInfo[playerid][cAmount])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_BIZZ_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Business Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via BBC(credit).\n\
						Please input how much from the business(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			new 
				creditamount = strval(inputtext);
			if((AC_GetPlayerMoney(playerid) + creditamount) >= PaymentBuyPrice[playerid])
			{
				CreditInfo[playerid][cAmount] = creditamount;
				CreditInfo[playerid][cUsed] = true;
				BuyBiznis(playerid, true);
				PaymentBuyPrice[playerid] = 0;
				SavePlayerCredit(playerid);

				va_SendMessage(playerid, 
					MESSAGE_TYPE_SUCCESS, 
					"You have sucessfully used %s from 	BBC credit. The rest of the price (%s) you paid from your hands!", 
					FormatNumber(creditamount), 
					FormatNumber(PaymentBuyPrice[playerid] - creditamount)
				);
			}
			else
			{
				va_SendMessage(playerid, 
					MESSAGE_TYPE_ERROR, 
					"%s credit with %s that you have in hands is not enough to cover expenses of business. (%s)", 
					FormatNumber(creditamount), 
					FormatNumber(AC_GetPlayerMoney(playerid)), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
				return va_ShowPlayerDialog(playerid, 
					DIALOG_BIZZ_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Business Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via BBC(credit).\n\
						Please input how much from the business(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			return 1;
		}
	}
	return 0;
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

static BankTransferMoney(playerid, giveplayerid, amount)
{
	PlayerInfo[playerid][pBank] -= amount;
	PlayerInfo[giveplayerid][pBank] += amount;

	va_SendClientMessage(playerid, 
		COLOR_YELLOW, 
		"You have transferred "COL_LIGHTBLUE"%s "COL_YELLOW"on bank account of %s.", 
		FormatNumber(amount), 
		GetName(giveplayerid,true)
	);
	va_SendClientMessage(giveplayerid, 
		COLOR_YELLOW, 
		"%s transferred "COL_LIGHTBLUE"%s "COL_YELLOW"on your bank account.",
		GetName(giveplayerid,true),
		FormatNumber(amount)
	);
	
	mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankmoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pSQLID]
	);

	mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankmoney = '%d' WHERE sqlid = '%d'",
		PlayerInfo[giveplayerid][pBank],
		PlayerInfo[giveplayerid][pSQLID]
	);
		
	if(amount >= 1000) 
	{
		new
			btmpString[128];
		format(btmpString, 
			sizeof(btmpString), 
			"[A] - Bank Transfer: %s transferred "COL_LIGHTBLUE"%s "COL_YELLOW" to player %s", 
			GetName(playerid, false), 
			FormatNumber(amount), 
			GetName(giveplayerid, false)
		);
		ABroadCast(COLOR_YELLOW,btmpString,1);
	}
	#if defined MODULE_LOGS
	Log_Write("/logfiles/bank.txt", "(%s) %s[SQLID: %d] transferred %s to %s[SQLID: %d]",
		ReturnDate(),
		GetName(playerid, false),
		PlayerInfo[playerid][pSQLID],
		FormatNumber(amount),
		GetName(giveplayerid, false),
		PlayerInfo[giveplayerid][pSQLID]
	);
	#endif
	return 1;
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
			{
				va_ShowPlayerDialog(playerid, 
					DIALOG_VEH_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Vehicle Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via VBC(credit).\n\
						Please input how much from the vehicle(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			else return BuyVehicle(playerid);
		}
		case BUY_TYPE_HOUSE:
		{
			if(CreditInfo[playerid][cCreditType] == 6 && !CreditInfo[playerid][cUsed])
			{
				va_ShowPlayerDialog(playerid, 
					DIALOG_HOUSE_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"House Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via HBC(credit).\n\
						Please input how much from the house(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			else BuyHouse(playerid);
		}
		case BUY_TYPE_BIZZ:
		{
			if(CreditInfo[playerid][cCreditType] == 7 && !CreditInfo[playerid][cUsed])
			{
				va_ShowPlayerDialog(playerid, 
					DIALOG_BIZZ_PAYMENT, 
					DIALOG_STYLE_INPUT, 
					"Business Buyment Contract", 
					"\n"COL_WHITE"You have "COL_LIGHTBLUE"%s"COL_WHITE" available via BBC(credit).\n\
						Please input how much from the business(%s) you wish to pay via credit:", 
					"Input", 
					"No credit", 
					FormatNumber(CreditInfo[playerid][cAmount]), 
					FormatNumber(PaymentBuyPrice[playerid])
				);
			}
			else BuyBiznis(playerid);
		}
	}
	return 1;
}

static IsPlayerCredible(playerid, amount)
{
	new 
		bool:value = false;
	if(PlayerFaction[playerid][pMember] > 0)
	{
		new fid = PlayerFaction[playerid][pMember];
		if(FactionInfo[fid][fType] != FACTION_TYPE_LAW && FactionInfo[fid][fType] != FACTION_TYPE_LAW2 && FactionInfo[fid][fType] != FACTION_TYPE_FD && FactionInfo[fid][fType] != FACTION_TYPE_NEWS) 	
			value = false;
		else 
			value = true;
	}
	// Legal Employment
	if(PlayerJob[playerid][pJob] >= 0 && !IsIllegalJob(playerid))
	{
		if(PlayerJob[playerid][pContractTime] > 15)
			value = true;
	}
	if(!value)
	{
		SendClientMessage(playerid, 
			COLOR_LIGHTRED, 
			"You don't meet the terms for credit raising - Legal job with 15+ hour contract or legal faction employment."
		);
		return 0;
	}	
	new 
		ratevalue = amount / 250;
	if((PaydayInfo[playerid][pProfit] + 100) < ratevalue && PlayerInfo[playerid][pBank] < (amount * 0.7))
	{
		va_SendClientMessage(playerid, 
			COLOR_LIGHTRED, 
			"You should have profit above %s per hour/70% of credit(%s) on bank account to be credible for this credit.", 
			FormatNumber(ratevalue + 100),
			FormatNumber(amount)
		);
		value = false;
	}
	return value;
}

static GetValuablePropertyType(playerid)
{
	new 
		housevalue = 0, 
		bizvalue = 0,
		vehvalue = 0;

	if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
	{
		new 
			houseid = PlayerKeys[playerid][pHouseKey];
		housevalue = HouseInfo[houseid][hValue];
	}
	if(PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID)
	{
		new 
			bizzid = PlayerKeys[playerid][pBizzKey];
		bizvalue = BizzInfo[bizzid][bBuyPrice];
	}
	if(PlayerKeys[playerid][pVehicleKey] != -1)
	{
		new
			vehicleid = PlayerKeys[playerid][pVehicleKey];
		vehvalue = GetVehicleByModel(VehicleInfo[vehicleid][vModel], true);  
	}
	if(housevalue > bizvalue && housevalue > vehvalue)
		return PROPERTY_TYPE_HOUSE;	
	else if(bizvalue > housevalue && bizvalue > vehvalue)
		return PROPERTY_TYPE_BIZZ;
	else if(vehvalue > housevalue && vehvalue > bizvalue)
		return PROPERTY_TYPE_VEHICLE;
	return 0;
}

TakePlayerProperty(playerid)
{
	
	if(PlayerKeys[playerid][pHouseKey] == INVALID_HOUSE_ID 
		&& PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID
		&& PlayerKeys[playerid][pVehicleKey] == -1)
		return 0;
	new 
		type = GetValuablePropertyType(playerid);
		
	switch(type)
	{
		case 0: return 0;	// No House/Business/vehicle
		case PROPERTY_TYPE_HOUSE:
		{
			new 
				house = PlayerKeys[playerid][pHouseKey];

			va_SendClientMessage(playerid, 
				COLOR_LIGHTRED, 
				"[BANK]: Your house on adress %s has been seized by bank. \n\
					Reason: %s credit debt", 
				HouseInfo[house][hAdress],
				FormatNumber(CreditInfo[playerid][cAmount])
			);
			
			HouseInfo[house][hOwnerID]		= 0;
			HouseInfo[house][hLock] 		= 1;
			HouseInfo[house][hSafePass] 	= 0;
			HouseInfo[house][hSafeStatus] 	= 0;
			HouseInfo[house][hOrmar] 		= 0;
				
			mysql_fquery(SQL_Handle(), 
				"UPDATE houses SET ownerid = '0' WHERE ownerid = '%d'", 
				PlayerInfo[playerid][pSQLID]
			);
			PlayerKeys[playerid][pHouseKey] = INVALID_HOUSE_ID;

			PlayerInfo[playerid][pSpawnChange] = 0;
			mysql_fquery(SQL_Handle(), "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'",
				PlayerInfo[playerid][pSpawnChange],
				PlayerInfo[playerid][pSQLID]
			);
			SetPlayerSpawnInfo(playerid);
		}
		case PROPERTY_TYPE_BIZZ:
		{
			new 
				biz = PlayerKeys[playerid][pBizzKey];
			
			va_SendClientMessage(playerid, 
				COLOR_LIGHTRED, 
				"[BANK]: Your business %s has been seized by bank. Reason: %s credit debt.", 
				BizzInfo[biz][bMessage],
				FormatNumber(CreditInfo[playerid][cAmount])
			);
			
			BizzInfo[biz][bLocked] 	= 1;
			BizzInfo[biz][bOwnerID] = 0;

			PlayerKeys[playerid][pBizzKey] = INVALID_BIZNIS_ID;
			mysql_fquery(SQL_Handle(), 
				"UPDATE bizzes SET ownerid = '0' WHERE id = '%d'", 
				BizzInfo[biz][bSQLID]
			);
		}
		case PROPERTY_TYPE_VEHICLE:
		{
			new 
				vehicleid = PlayerKeys[playerid][pVehicleKey];
			va_SendClientMessage(playerid, 
				COLOR_RED, 
				"[!]: The Bank seized your %s as payment of credit costs (%s).", 
				ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
				FormatNumber(CreditInfo[playerid][cAmount])
			);
				
			DeleteVehicleFromBase(VehicleInfo[vehicleid][vSQLID]);

			#if defined MODULE_LOGS
			Log_Write("/logfiles/car_delete.txt", 
				"(%s) %s lost his %s because of credit loan debt(%s).",
				ReturnDate(),
				GetName(playerid,false),
				ReturnVehicleName(VehicleInfo[vehicleid][vModel]),
				FormatNumber(CreditInfo[playerid][cAmount])
			);
			#endif

			DestroyFarmerObjects(playerid);
			AC_DestroyVehicle(PlayerKeys[playerid][pVehicleKey]);
			PlayerKeys[playerid][pVehicleKey] = -1;

			ResetVehicleList(playerid);
			GetPlayerVehicleList(playerid);
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
	CreditInfo[playerid][cTimestamp]	= 0;
	PaymentBuyPrice[playerid] 			= 0;
	return 1;
}

static ResetSavingsVars(playerid)
 {
	PlayerSavings[playerid][pSavingsCool] = 0;
	PlayerSavings[playerid][pSavingsTime] = 0;
	PlayerSavings[playerid][pSavingsType] = 0;
	PlayerSavings[playerid][pSavingsMoney] = 0;
	return 1;
}

/*
                                               
  ,ad8888ba,  88b           d88 88888888ba,    
 d8"'    `"8b 888b         d888 88      `"8b   
d8'           88`8b       d8'88 88        `8b  
88            88 `8b     d8' 88 88         88  
88            88  `8b   d8'  88 88         88  
Y8,           88   `8b d8'   88 88         8P  
 Y8a.    .a8P 88    `888'    88 88      .a8P   
  `"Y8888Y"'  88     `8'     88 88888888Y"'    

*/

CMD:bank(playerid, params[])
{
	if(!IsAtBank(playerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be in bank to use this command!");
	if(PlayerDeath[playerid][pKilled])
		 return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't use this command if you're Wounded/DeathMode!");
	
	new
		pick[15];
	if(sscanf(params, "s[15] ", pick)) 
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /bank [option]");
		SendClientMessage(playerid, COLOR_RED, "[!] withdraw - deposit - transfer");
		SendClientMessage(playerid, COLOR_RED, "[!] credit - checkcredit - paycredit - savings - savingsinfo");
		return 1;
	}
	if(!strcmp(pick, "withdraw", true)) 
	{
		new
			moneys;
		if(sscanf( params, "s[15]i", pick, moneys)) 
			return SendClientMessage(playerid, COLOR_RED, "[?]: /bank withdraw [amount of $]");
		if(moneys > PlayerInfo[playerid][pBank] || moneys < 1) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have %s on your bank account!", FormatNumber(moneys));
		
		BankToPlayerMoney(playerid, moneys);
		
		va_SendMessage(playerid, 
			MESSAGE_TYPE_SUCCESS, 
			"[BANK]: You have withdrawn %s from your bank account.~n~Amount left: %s",
			FormatNumber(moneys), 
			FormatNumber(PlayerInfo[playerid][pBank]) 
		);
		
	}
	else if(!strcmp(pick, "deposit", true)) 
	{
		new
			moneys;
		if(sscanf(params, "s[15]i", pick, moneys)) 
			return SendClientMessage(playerid, COLOR_RED, "[?]:  /bank deposit [amount of $]");
		if(moneys > AC_GetPlayerMoney(playerid) || moneys < 1) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have %s with you!", FormatNumber(moneys));
		
		PlayerToBankMoney(playerid, moneys);
		
		va_SendMessage(playerid, 
			MESSAGE_TYPE_SUCCESS, 
			"[BANK]: You've sucessfully deposited %s on your bank account.~n~New balance: %s", 
			FormatNumber(moneys), 
			FormatNumber(PlayerInfo[playerid][pBank])
		);
		
		#if defined MODULE_LOGS
		Log_Write("logfiles/bank_deposit.txt", 
			"(%s) Player %s[%d] deposited %d$ in his bank account. [Old state]: %d$ | [New state]: %d$ ", 
			ReturnDate(), 
			GetName(playerid), 
			PlayerInfo[playerid][pSQLID], 
			moneys,
			(PlayerInfo[playerid][pBank] - moneys),
			PlayerInfo[playerid][pBank]
		);
		#endif
	}
	else if(!strcmp(pick, "transfer", true)) 
	{
		new
			moneys, 
			giveplayerid;
		if(sscanf(params, "s[15]ui", pick, giveplayerid, moneys)) 
			return SendClientMessage(playerid, COLOR_RED, "[?]:  /bank transfer [Playerid / Part of name][amount]");
		if(PlayerInfo[playerid][pLevel] < 2) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be Level 2+!");
		if(giveplayerid == INVALID_PLAYER_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That player isn't online.");
		if(moneys > PlayerInfo[playerid][pBank]|| moneys < 1) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have %s on your bank account!", FormatNumber(moneys));
		
		BankTransferMoney(playerid, giveplayerid, moneys);
	}
	else if(!strcmp(pick, "credit", true))
	{
		if(!IsAtBank(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at the bank if you want to use this command!");
		ShowPlayerDialog(playerid, 
			DIALOG_CREDIT, 
			DIALOG_STYLE_LIST, 
			"Choose your credit:", 
			"Credit [10.000{088A08}$] (Level required: {F29A0C}5+)\n\
				Credit [25.000{088A08}$] (Level required: {F29A0C}7+)\n\
				Credit [50.000{088A08}$] (Level required: {F29A0C}10+)\n\
				Credit [100.000{088A08}$] (Level required: {F29A0C}15+)\n\
				Vehicle Buyment Contract[Up to 50.000{088A08}$] (Level required: {F29A0C}5+)\n\
				House Buyment Contract[Up to 100.000{088A08}$] (Level required: {F29A0C}5+)\n\
				Business Buyment Contract[Up to100.000{088A08}$] (Level required: {F29A0C}10+)", 
			"Choose", 
			"Exit"
		);
	}
	else if(!strcmp(pick, "checkcredit", true))
	{
		if(!IsAtBank(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at the bank if you want to use this command!");
		if(CreditInfo[playerid][cCreditType] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an active credit.");

		new 
			rest = 250 - CreditInfo[playerid][cRate];
		va_SendMessage(playerid, 
			MESSAGE_TYPE_INFO, 
			"[BANK]: You have %d(%d in debt/owed) rates of credit(Total %d) to pay off credit.~n~Credit amount: %s.", 
			rest, 
			CreditInfo[playerid][cUnpaid], 
			FormatNumber(CreditInfo[playerid][cAmount])
		);
		return 1;
	}
	else if(!strcmp(pick, "savings", true))
	{
		if(!IsAtBank(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You have to be at the bank if you want to use this command!");
		new 
			money, 
			time;
		if(sscanf(params, "s[15]ii", pick, time, money)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /bank savings [time in hours][amount]");
			va_SendClientMessage(playerid, 
				COLOR_RED, "Time: 10 - %d In Game hours(1 hour = 1% interest rate) | Amount: 1$ - %s$",
				MAX_SAVINGS_TIME,
				FormatNumber(MAX_SAVINGS_AMOUNT)
			);
			return 1;
		}
		if(CreditInfo[playerid][cCreditType] != 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You haven't paid your current credit off, you can't start term savings.");
		if(PlayerInfo[playerid][pLevel] < 3) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be Level 3+ to use this command");
		if(PlayerSavings[playerid][pSavingsType] > 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Your current Term Savings must end before investing more money!");
		if(PlayerSavings[playerid][pSavingsCool])
		{
			return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"You have to wait %d hours to start new savings!", 
						PlayerSavings[playerid][pSavingsCool]
			);
		}
		if(money > PlayerInfo[playerid][pBank]|| money < 1) 
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have %s on your bank account!", FormatNumber(money));
		if(money > (MAX_SAVINGS_AMOUNT))
		{ 
			return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"You can't invest more than %s in savings!", 
						FormatNumber(MAX_SAVINGS_AMOUNT)
			);
		}
		if(time < 10 || time > MAX_SAVINGS_TIME) 
		{
			return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"Duration of savings can't be less than 10, or more than %d!", 
						MAX_SAVINGS_TIME
			);
		}
		va_ShowPlayerDialog(playerid, 
			DIALOG_ACCEPT_SAVINGS, 
			DIALOG_STYLE_MSGBOX, 
			"Bank Term Savings", 
			"\nAre you sure you want to put %s on your bank term savings for %d hours?", 
			"Yes", 
			"No",
			FormatNumber(money),
			time
		);
		
		PlayerSavings[playerid][pSavingsTime] = time;
		PlayerSavings[playerid][pSavingsMoney] = money;
	}
	else if(!strcmp(pick, "savingsinfo", true))
	{
		if(PlayerInfo[playerid][pLevel] < 3) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You must be Level 3+ to use this command");
		if(PlayerSavings[playerid][pSavingsType] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an active term savings!");

		va_SendMessage(playerid,
			MESSAGE_TYPE_INFO,
			"[BANK]: Balance on Term Savings: [%s] | [%d] hours untill end | Interest rate: [%d%]", 
			FormatNumber(PlayerSavings[playerid][pSavingsMoney]),
			PlayerSavings[playerid][pSavingsTime], 
			PlayerSavings[playerid][pSavingsType]
		);
		return 1;
	}
	else if(!strcmp(pick, "paycredit", true))
	{
		if(PlayerDeath[playerid][pKilled])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't use this command if you're Wounded/DeathMode!");
		if(CreditInfo[playerid][cCreditType] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have an active credit!");
		if(CreditInfo[playerid][cCreditType] > 4 && !CreditInfo[playerid][cUsed]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You didn't fulfill your purchasement obligation!");
		
		new 
			rest = (250 - CreditInfo[playerid][cRate]), 
			money, 
			cashdeposit;
			
		if(sscanf(params, "s[15]i", pick, cashdeposit)) 
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /bank paycredit [amount of rates]");
			if(CreditInfo[playerid][cUnpaid] > 0)
			{
				va_SendClientMessage(playerid, 
					COLOR_LIGHTRED, 
					"[BANK]: You have %d unpaid(owed) credit rates, so paying will be prioritized on settling that debt.", 
					CreditInfo[playerid][cUnpaid]
				);
			}
			va_SendClientMessage(playerid, COLOR_RED, "[!]: You have %d credit rates to pay off.", rest);
			return 1;
		}
		if(AntiSpamInfo[playerid][asCreditPay] > gettimestamp())
		{
			return va_SendMessage(playerid, 
						MESSAGE_TYPE_ERROR, 
						"[ANTI-SPAM]: Don't spamm with the command. Wait for %d seconds to continue!", 
						ANTI_SPAM_BANK_CREDITPAY
			);
		}
		if(cashdeposit > rest || cashdeposit < 1) 
		{
			return va_SendMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"Amount of rates can't be smaller than 1, or larger than %d!",
				rest
			);
		}
		if(CreditInfo[playerid][cUnpaid] > 0)
		{
			if(cashdeposit > CreditInfo[playerid][cUnpaid] || cashdeposit < 1) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have that many credit rates left!");

			money = cashdeposit * (CreditInfo[playerid][cAmount] / 250);
			if(AC_GetPlayerMoney(playerid) >= money) 
			{
				PlayerToBudgetMoney(playerid, money); 
				CreditInfo[playerid][cUnpaid] -= cashdeposit;

				va_SendMessage(playerid, 
					MESSAGE_TYPE_INFO, 
					"You paid for %d rates that you owed %s.", 
					FormatNumber(cashdeposit), 
					FormatNumber(money)
				);
				if(CreditInfo[playerid][cUnpaid] == 0)
				{
					SendClientMessage(playerid, 
						COLOR_LIGHTBLUE, 
						"[BANK]: You have sucessfully paid off all your owed credit rates."
					);
				}	
				goto mysql_save;
			}
			else return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You need %s to pay off %d rates!", FormatNumber(money), cashdeposit);
		}
		switch(CreditInfo[playerid][cCreditType])
		{
			case 1: money = cashdeposit * 50;
			case 2: money = cashdeposit * 100;
			case 3: money = cashdeposit * 250;
			case 4: money = cashdeposit * 500;
			case 5 .. 7: money = cashdeposit * (CreditInfo[playerid][cAmount] / 250);
		}
		if(AC_GetPlayerMoney(playerid) < money)
			return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "You need %s to pay off %d rates!", FormatNumber(money), cashdeposit);

		PlayerToBudgetMoney(playerid, money);
		CreditInfo[playerid][cRate] += cashdeposit;
		va_SendMessage(playerid, MESSAGE_TYPE_INFO, "You have paid %d rates of credit %s.", cashdeposit, FormatNumber(money));

		if(CreditInfo[playerid][cRate] >= 250)
		{
			ResetCreditVars(playerid);
			SendClientMessage(playerid, COLOR_RED, "[!]: You have just paid last of your credit! You can raise new one again.");
		}

		mysql_save:
		SavePlayerCredit(playerid);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/credit_pay.txt", 
			"(%s) %s paid %d credit rates for %s",  
			ReturnDate(), 
			GetName(playerid, false), 
			cashdeposit, 
			FormatNumber(money)
		);
		#endif
		AntiSpamInfo[playerid][asCreditPay] = gettimestamp() + ANTI_SPAM_BANK_CREDITPAY;
		return 1;
	}
	return 1;
}
