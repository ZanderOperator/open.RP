#include <YSI\y_hooks>

static stock Bit16:r_SavingsMoney<MAX_PLAYERS> = {Bit16:0, ...};
/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##  	 ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/
hook ResetPlayerVariables(playerid)
{
	Bit16_Set(r_SavingsMoney, playerid, 0);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_CREDIT)
    {	
		if( !response ) return 1;
		new 
			string[61];
		switch(listitem) {
			case 0: {	// mali kredit
				if(PlayerInfo[playerid][pLevel] < 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 5 da biste mogli podici ovaj tip kredita.");
				if(PlayerInfo[playerid][pCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
			
				BudgetToPlayerMoney(playerid, 10000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 10 000$.");
				format(string, sizeof(string), "* %s otvara kofer potom sprema 10.000$ u njega.", GetName(playerid, true));
				ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerInfo[playerid][pRate] = 1;
				PlayerInfo[playerid][pCreditType] = 1;
		    }
		    case 1: { 	// srednji kredit
				if(PlayerInfo[playerid][pLevel] < 7) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 7 da biste mogli podici ovaj tip kredita.");
				if(PlayerInfo[playerid][pCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");
			
				BudgetToPlayerMoney(playerid, 25000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 25 000$.");
				format(string, sizeof(string), "* %s otvara kofer potom sprema 25.000$ u njega.", GetName(playerid, true));
				ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerInfo[playerid][pCreditType] = 2;	
				PlayerInfo[playerid][pRate] = 1;
		    }
		    case 2:  {	// veliki kredit
				if(PlayerInfo[playerid][pLevel] < 10) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 10 da biste mogli podici ovaj tip kredita.");
				if(PlayerInfo[playerid][pCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");

				BudgetToPlayerMoney(playerid, 50000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 50 000$.");
				format(string, sizeof(string), "* %s otvara kofer potom sprema 50.000$ u njega.", GetName(playerid, true));
				ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerInfo[playerid][pCreditType] = 3;	
				PlayerInfo[playerid][pRate] = 1;
		    }
			case 3:  {	// veliki kredit v2
				if(PlayerInfo[playerid][pLevel] < 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 15 da biste mogli podici ovaj tip kredita.");
				if(PlayerInfo[playerid][pCreditType] >= 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi ste podigli novi kredit, predhodni morate otplatiti.");

				BudgetToPlayerMoney(playerid, 100000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste podigli kredit u iznosu od 100 000$.");
				format(string, sizeof(string), "* %s otvara kofer potom sprema 100.000$ u njega.", GetName(playerid, true));
				ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				PlayerInfo[playerid][pCreditType] = 4;	
				PlayerInfo[playerid][pRate] = 1;
		    }
		}
		return 1;
	}
	if(dialogid == DIALOG_ACCEPT_SAVINGS) {
		if( !response ) return ResetSavingsVars(playerid), SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Odbili ste stavit novac na stednji racun.");
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
	return (true);
}

ResetSavingsVars(playerid) {
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
		SendClientMessage(playerid, COLOR_RED, "USAGE: /bank [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] withdraw - deposit - transfer");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] credit - checkcredit - paycredit - savings - savingsinfo");
		return 1;
	}
	if( !strcmp( pick, "withdraw", true ) ) {
		new
			moneys;
		if( sscanf( params, "s[15]i", pick, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /bank withdraw [kolicina novca]");
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
			
		if( sscanf( params, "s[15]i", pick, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE:  /bank deposit [kolicina novca]");
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
		if( sscanf( params, "s[15]ui", pick, giveplayerid, moneys ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE:  /bank transfer [Playerid/DioImena][iznos]");
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
		ShowPlayerDialog(playerid, DIALOG_CREDIT, DIALOG_STYLE_LIST, "Credit", "Kredit [10.000{088A08}$] (Potreban level: {F29A0C}5+)\nKredit [25.000{088A08}$] (Potreban level: {F29A0C}7+)\nKredit [50.000{088A08}$] (Potreban level: {F29A0C}10+)\nKredit [100.000{088A08}$] (Potreban level: {F29A0C}15+)", "Izaberi", "Izadji");
	}
	else if(!strcmp(pick, "checkcredit", true))
	{
		new 
			ostatak = (251) - (PlayerInfo[playerid][pRate]);
		if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristit ovu komandu !");
		
		if(PlayerInfo[playerid][pCreditType] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas podignut kredit.");
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "[BANKA]: Preostalo vam je %d rata za otplatu kredita.", ostatak);
		return 1;
	}
	else if(!strcmp(pick, "savings", true))
	{
		if(!IsAtBank(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u banci da bi ste mogli koristit ovu komandu !");
		new money, time, buffer[128];
		if(sscanf(params, "s[15]ii", pick, time, money)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /bank savings [vrijeme] [svota]");
			SendClientMessage(playerid, COLOR_RED, "OPTION: Vrijeme: 10 - 100 In Game sati(1 sat = 1% kamate) | Svota: 1$ - 200 000$");
			return 1;
		}
		if(PlayerInfo[playerid][pCreditType] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Jos niste otplatili svoj kredit te ne mozete zapoceti stednju.");
		if(PlayerInfo[playerid][pLevel] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti level 3+ da koristite ovu komandu!");
		if(PlayerInfo[playerid][pSavingsType] > 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati kraj stednje!");
		if(PlayerInfo[playerid][pSavingsCool]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati jos %d paydayeva da uzmete novu stednju!", PlayerInfo[playerid][pSavingsCool]);
		if((PlayerInfo[playerid][pBank] - money) < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca na bankovnom racunu!");
		if(money > 200001) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete stavljati vece svote od 200 000$!");
		if(time < 10 || time > 101) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrijeme stednje ne moze biti manje od 1h, ni vece od 100h!");
		
		format(buffer, 128, "\nJeste li sigurni da zelite staviti %s na vas stednji racun?", FormatNumber(money));
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
			rest = (251 - PlayerInfo[playerid][pRate]), 
			money, 
			cashdeposit;
			
		if (sscanf(params, "s[15]i", pick, cashdeposit)) {
			SendClientMessage(playerid, COLOR_RED, "USAGE: /bank paycredit [kolicina rata]");
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Imate jos %d rata za otplatiti.", rest);
			return 1;
		}

		if(PlayerInfo[playerid][pCreditType] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ti nemas dignut kredit");
		if( AntiSpamInfo[ playerid ][ asCreditPay ] > gettimestamp() ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BANK_CREDITPAY);
		if (cashdeposit > rest || cashdeposit < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko rata !");
		
		switch(PlayerInfo[playerid][pCreditType])
		{
			case 1:
			{
				money = cashdeposit * 50;
				if(AC_GetPlayerMoney(playerid) >= money) {
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					PlayerInfo[playerid][pRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(PlayerInfo[playerid][pRate] >= 251) {
						PlayerInfo[playerid][pRate] = 0;
						PlayerInfo[playerid][pCreditType] = 0;
						SendClientMessage(playerid, COLOR_NICERED, "Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca da bi otplatiti rate !");
			}
			case 2:
			{
				money = cashdeposit * 100;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					PlayerInfo[playerid][pRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(PlayerInfo[playerid][pRate] >= 251)
					{
						PlayerInfo[playerid][pRate] = 0;
						PlayerInfo[playerid][pCreditType] = 0;
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca da bi otplatiti rate !");
			}
			case 3:
			{
				money = cashdeposit * 250;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					PlayerInfo[playerid][pRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(PlayerInfo[playerid][pRate] >= 251) {
						PlayerInfo[playerid][pRate] = 0;
						PlayerInfo[playerid][pCreditType] = 0;
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca da bi otplatiti rate !");
			}
			case 4:
			{
				money = cashdeposit * 500;
				if(AC_GetPlayerMoney(playerid) >= money)
				{
					PlayerToBudgetMoney(playerid, money); // novac dolazi u proracun
					PlayerInfo[playerid][pRate] += cashdeposit;
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Platili ste %d rata za $%d.", cashdeposit, money);
					if(PlayerInfo[playerid][pRate] >= 251) {
						PlayerInfo[playerid][pRate] = 0;
						PlayerInfo[playerid][pCreditType] = 0;
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Upravo ste otplatili zadnju ratu kredita! Mozete dignuti novi kredit!");
					}
				}
				else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca da bi otplatiti rate !");
			}
		}
		new
			mysqlUpdate[96],
			log[86];
			
		format(mysqlUpdate, 96, "UPDATE `accounts` SET `rate` = '%d', `credittype` = '%d' WHERE `sqlid` = '%d' LIMIT 1",
			PlayerInfo[playerid][pRate],
			PlayerInfo[playerid][pSQLID]
		);
		mysql_tquery(g_SQL, mysqlUpdate, "", "");
		
		format( log, 86, "%s je platio %d rata kredita za $%d", GetName(playerid, false), cashdeposit, money);
		LogCreditPay(log);
		
		AntiSpamInfo[ playerid ][ asCreditPay ] = gettimestamp() + ANTI_SPAM_BANK_CREDITPAY;
		return 1;
	}
	return 1;
}
