#include <YSI\y_hooks>

#if defined MODULE_PAY_DAY
	#endinput
#endif
#define MODULE_PAY_DAY
#define SOCIAL_HELP 		(1000) // Taggano sa SOCIAL_HELP
#define PD_SD_SALARY 		(700) // Glavnica za PD/SD placu
#define FD_LSN_SALARY 		(800) // Glavnica za FD/LSN placu
#define GOV_SALARY	 		(1000) // Glavnica za GOV placu


/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
*/
GivePlayerPayCheck(playerid)
{
	//CheckCityBudget(); // Provjera stanja legalnog i ilegalnog proracuna
	new
		houselost 			= 0,
		rentlost 			= 0,
		complexlost			= 0,
		kreditlost			= 0,
		complexroomlost 	= 0,
		orgsalary			= 400, // minimalna placa
		orgbonus			= 0,
		p_dialog[2048],
		f_dialog[256];

	PlayerInfo[playerid][pPayDayDate][0] = EOS;
	strcat(PlayerInfo[playerid][pPayDayDate], ReturnDate(), 32);
	
	format(p_dialog, sizeof(p_dialog), "\t %s - Financijsko izvjesce - %s", PlayerInfo[playerid][pPayDayDate], GetName(playerid));
	
	// Pretplata na CRYPTO 50 dolara
	if(PlayerInfo[playerid][pCryptoNumber] != 0 || PlayerInfo[playerid][pMobileCost] > 0)
	{
		format(f_dialog,sizeof(f_dialog), "\n{3C95C2}Troskovi pretplate:");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if(PlayerInfo[playerid][pCryptoNumber] != 0){

		format(f_dialog,sizeof(f_dialog), "\n\tCrypto pretplata: -50$");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		PlayerToIllegalBudgetMoney(playerid, 50);
	}
	// Mobilna pretplata - 1$ po SMS-u, 2$ po minuti poziva
	if(PlayerInfo[playerid][pMobileCost] > 0)
	{
		format(f_dialog, sizeof(f_dialog), "\n\tMobilna pretplata: -%d$", PlayerInfo[playerid][pMobileCost]); 
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		PlayerToBudgetMoney(playerid, PlayerInfo[playerid][pMobileCost]);
		PlayerInfo[playerid][pMobileCost] = 0;
		
		new	moneyUpdate[100];
		format(moneyUpdate, 100, "UPDATE `player_phones` SET `money` = '%d' WHERE `player_id` = '%d' AND `type` = '1'",
			PlayerInfo[playerid][pMobileCost],
			PlayerInfo[playerid][pSQLID]
		);
		mysql_tquery(g_SQL, moneyUpdate);
	}
	format(f_dialog,sizeof(f_dialog), "\n{3C95C2}Imovina:");
	strcat(p_dialog,f_dialog, sizeof(p_dialog));
	// Posjeduje kucu -> bills
	if(PlayerInfo[playerid][pHouseKey] != INVALID_HOUSE_ID && PlayerInfo[playerid][pHouseKey] > 0) {
		new house = PlayerInfo[playerid][pHouseKey];

		houselost += floatround( 0.001 * HouseInfo[ house ][ hValue ] );
		format(f_dialog,sizeof(f_dialog), "\n\tTroskovi kuce: %s", FormatNumber(houselost));
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		PlayerBankToBudgetMoney(playerid, houselost); // u proracun novac od kuce
	}
	// Ako kod nekoga renta
	if( PlayerInfo[ playerid ][ pRentKey ] != INVALID_HOUSE_ID && PlayerInfo[ playerid ][ pRentKey ] >= 0 )  {
		new house = PlayerInfo[ playerid ][ pRentKey ];
		if(PlayerInfo[playerid][pBank] >= HouseInfo[ house ][ hRent ])
		{
			rentlost += HouseInfo[ house ][ hRent ];
			format(f_dialog,sizeof(f_dialog), "\n\tTroskovi najma kuce: %s", FormatNumber(rentlost));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
			PlayerBankToHouseMoneyTAX(playerid, house, HouseInfo[ house ][ hRent ]); // Novac iz banke igraca ide u kucu vlasnika kuce koji renta
		}
		else {
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Izbaceni ste iz podstanarstva jer nemate za najamninu na bankovnom racunu.");
			PlayerInfo[ playerid ][ pRentKey ] = 9999;
			PlayerInfo[ playerid ][ pRentKey ] = INVALID_HOUSE_ID;
			PlayerInfo[ playerid ][ pSpawnChange ] = 0;
			SetPlayerSpawnInfo(playerid);
		}
	}
	//Rentroom complex - ako igra? renta kompleks room (**oporezivo**)
	if(PlayerInfo[playerid][pComplexRoomKey] != INVALID_COMPLEX_ID)
	{
		new price = ComplexRoomInfo[PlayerInfo[playerid][pComplexRoomKey]][cValue];
		complexroomlost += price;
		foreach(new c : Complex)
		{
		    if(ComplexInfo[c][cSQLID] == ComplexRoomInfo[PlayerInfo[playerid][pComplexRoomKey]][cComplexID])
		    {
				PlayerBankToComplexMoneyTAX(playerid, c, complexroomlost);
				format(f_dialog,sizeof(f_dialog), "\n\tNajam complex sobe: %s", FormatNumber(complexroomlost));
				strcat(p_dialog,f_dialog, sizeof(p_dialog));
				break;
		    }
		}
	}
	// Posjeduje kompleks
    if(PlayerInfo[playerid][pComplexKey] != INVALID_COMPLEX_ID) {
        //complexlost += floatround( 25 * PlayerInfo[ playerid ][ pLevel ] );
		// pogurati malo komplekse da ih ljudi kupuju
		complexlost += minrand(200, 1000);
		format(f_dialog,sizeof(f_dialog), "\n\tDobit complexa: +%s", FormatNumber(complexlost)); // Troskovi prebaceni u dobit
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		BudgetToPlayerBankMoney(playerid, complexlost);
    }
	// Ako posjeduje biznis
	if( PlayerInfo[ playerid ][ pBizzKey ] != INVALID_BIZNIS_ID ) {
		new bizid = PlayerInfo[ playerid ][ pBizzKey ],
			possibility = minrand(0, 800);
		if (possibility >= 200) {
			BudgetToBusinessMoney ( bizid, possibility);
			format(f_dialog,sizeof(f_dialog), "\n\tPoslovanja biznisa: +%s", FormatNumber(possibility));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
		else {
			BusinessToBudgetMoney ( bizid, possibility); // novac iz blagajne biznisa ide u proracun
			format(f_dialog,sizeof(f_dialog), "\n\tPoslovanja biznisa: -%s", FormatNumber(possibility));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
	}
	// Troskovi kredita
	if(PlayerInfo[playerid][pCreditType] > 0) {
		switch(PlayerInfo[playerid][pCreditType])
		{
			case 1:  {
				if(PlayerInfo[playerid][pRate] >= 1 && PlayerInfo[playerid][pRate] <= 250)
					kreditlost += 50;
			}
			case 2:  {
				if(PlayerInfo[playerid][pRate] >= 1 && PlayerInfo[playerid][pRate] <= 250)
					kreditlost += 100;
			}
			case 3:  {
				if(PlayerInfo[playerid][pRate] >= 1 && PlayerInfo[playerid][pRate] <= 250)
					kreditlost += 250;
			}
			case 4:  {
				if(PlayerInfo[playerid][pRate] >= 1 && PlayerInfo[playerid][pRate] <= 250)
					kreditlost += 300;
			}
		}
		format(f_dialog,sizeof(f_dialog), "\n{3C95C2}Banka:");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		PlayerInfo[ playerid ][ pRate ] += 1; // dodaje mu ratu kredita za jedan
		format(f_dialog,sizeof(f_dialog), "\n\tRata kredita: -%s", FormatNumber(kreditlost));
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		PlayerBankToBudgetMoney(playerid, kreditlost); // Novac od rate kredita ide u proracun
		if( PlayerInfo[ playerid ][ pRate ] >= 251 ) { //ako je rata kredita 251, kredit mu je otplacen
			PlayerInfo[ playerid ][ pRate ] 		= 0;
			PlayerInfo[ playerid ][ pCreditType ] 	= 0;
			format(f_dialog,sizeof(f_dialog), "\n\tOtplatili ste zadnju ratu kredita!");
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
	}
	// Savings
	if(PlayerInfo[playerid][pSavingsType] > 0)
	{
		PlayerInfo[playerid][pSavingsTime]--;
		if(PlayerInfo[playerid][pSavingsTime] > 0)
			mysql_fquery(g_SQL, "UPDATE `accounts` SET `savings_time` = '%d' WHERE `sqlid` = '%d' LIMIT 1", PlayerInfo[playerid][pSavingsTime], PlayerInfo[playerid][pSQLID]);

		if(PlayerInfo[playerid][pSavingsTime] <= 0)
		{
			new	Float:savingsmoneyfloat = PlayerInfo[playerid][pSavingsMoney] * floatdiv(PlayerInfo[playerid][pSavingsType], 100), 	// izracunava ulozen novac * stopa
				savingsmoney = floatround(savingsmoneyfloat), // zaokruzuje ga
				totalmoney = PlayerInfo[playerid][pSavingsMoney] + savingsmoney; // dodaje stopu na glavnicu

			// savings = PlayerInfo[playerid][pSavingsMoney] + floatround( PlayerInfo[playerid][pSavingsMoney] * (PlayerInfo[playerid][pSavingsType] / 100) );

			// Novac iz prora?una dolazi igra?u na bankovni racun
			BudgetToPlayerBankMoney(playerid, totalmoney);

			// Clear
			PlayerInfo[playerid][pSavingsCool] = 30;
			PlayerInfo[playerid][pSavingsTime] = 0;
			PlayerInfo[playerid][pSavingsType] = 0;
			PlayerInfo[playerid][pSavingsMoney] = 0;

			new savingsQuery[170];
			format(savingsQuery, 170, "UPDATE `accounts` SET `bankMoney` = '%d', `savings_cool` = '30', `savings_time` = '0', `savings_type` = '0', `savings_money` = '0' WHERE `sqlid` = '%d'",
				PlayerInfo[playerid][pBank],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_pquery(g_SQL, savingsQuery);

			// Poruke
			format(f_dialog,sizeof(f_dialog), "\n\t{3C95C2}Stednja:");
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
			format(f_dialog,sizeof(f_dialog), "\nProslo je vase vrijeme orocene stednje, te se primili %s na svoj bankovni racun!", FormatNumber(totalmoney));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
	}
	if(PlayerInfo[playerid][pSavingsCool] > 0)
	{
		PlayerInfo[playerid][pSavingsCool] -= 1;
		if(PlayerInfo[playerid][pSavingsCool] < 0)
			PlayerInfo[playerid][pSavingsCool] = 0;

		new savingsQuery[96];
		format(savingsQuery, 96, "UPDATE `accounts` SET `savings_cool` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[playerid][pSavingsCool],
			PlayerInfo[playerid][pSQLID]
		);
		mysql_tquery(g_SQL, savingsQuery);
	}
	format(f_dialog,sizeof(f_dialog), "\n{3C95C2}Prihodi:");
	strcat(p_dialog,f_dialog, sizeof(p_dialog));
	// Dobitak ako je u organizaciji I AKO NIJE
	if(PlayerInfo[playerid][pMember] > 0 )
	{
		new
			factionbank = FactionInfo[PlayerInfo[playerid][pMember]][fFactionBank], //dohvati koliko novaca ima fakcija u kojoj je igrac
			orgranks = FactionInfo[PlayerInfo[playerid][pMember]][fRanks], 					//dohvati koliko rankova ima fakcija u kojoj je igrac
			Float:salarypercent = 0.01;

		switch (PlayerInfo[playerid][pMember] ) {
			case 1, 3: { //LSPD i SASD
				for( new i = 0; i <= PlayerInfo[playerid][pRank]; i++ )
					orgsalary += floatround(PD_SD_SALARY/orgranks);
			}
			case 2, 5: { //LSFD i LSN
				for( new i = 0; i <= PlayerInfo[playerid][pRank]; i++ )
					orgsalary += floatround(FD_LSN_SALARY/orgranks);
			}
			case 4: { //GOV 1400
				for( new i = 0; i <= PlayerInfo[playerid][pRank]; i++ )
					orgsalary += floatround(GOV_SALARY/orgranks);
			}
			default: {
				orgsalary = 200;
			}
		}

		orgbonus = floatround(factionbank * salarypercent); 											// 0.01$% od FactionBanke organizacije
		BudgetToPlayerBankMoney(playerid, orgsalary); 													// Novac iz prora?una igra?u na bank. racun
		OrgToPlayerBankMoney( playerid, FactionInfo[PlayerInfo[playerid][pMember]][fType], orgbonus); 		// Novac iz factionbanke igra?u na bank.ra?un.
		orgsalary += orgbonus;
		format(f_dialog,sizeof(f_dialog), "\n\tPlaca: +%s (Bonus: %s)", FormatNumber(orgsalary), FormatNumber(orgbonus));
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	else { // Ako nema posao dobiva socijalnu pomoc
		new levelrespect = ( PlayerInfo[playerid][pLevel] + 1 ) * 4; // Trenutni respekti za njegov level
		if ( PlayerInfo[playerid][pRespects] <= levelrespect ) { // Ako ima manje respekata od za trenutni level
			new level = PlayerInfo[playerid][pLevel],
				fsalary = 1000 / level, // SOCIAL_HELP
				bsalary = floatround(floatabs(fsalary));

			switch(PlayerInfo[playerid][pDonateRank])
			{
				case 1,2,3:
				{
					if(bsalary < 200)
						bsalary = 200;
				}
				case 4:
				{
					if(bsalary < 300)
						bsalary = 300;
				}
			}
			BudgetToPlayerBankMoney(playerid, bsalary); // treba prebaciti na bankovni racun
			format(f_dialog,sizeof(f_dialog), "\n\tSocijalna pomoc: %s", FormatNumber(bsalary));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
	}
	if(PlayerInfo[playerid][pJob] == PLAYER_JOB_TAXI || PlayerInfo[playerid][pJob] == MECHANIC_ID) { // IC POSLOVI
		if(PlayerInfo[playerid][pJob] == PLAYER_JOB_TAXI) {
			new taxi_job = PlayerInfo[playerid][pContractTime] * 8, calculate = 0;
			if(taxi_job > 700)
				taxi_job = 700;

			calculate = taxi_job + PlayerInfo[playerid][pPayDayMoney];

			BudgetToPlayerBankMoney(playerid, taxi_job);  // bonus
			BusinessToPlayerMoney(playerid, 128, PlayerInfo[playerid][pPayDayMoney]); // koliko je zaradio IC.

			format(f_dialog,sizeof(f_dialog), "\n\tTaxi Company bonus: %s", FormatNumber(calculate));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
			PlayerInfo[playerid][pPayDayMoney] = 0;
		}
		else if(PlayerInfo[playerid][pJob] == MECHANIC_ID) {
			new workingbonus = PlayerInfo[playerid][pContractTime] * 8;
			if(workingbonus > 700)
				workingbonus = 700;

			BudgetToPlayerBankMoney(playerid, workingbonus); // bonus
			format(f_dialog,sizeof(f_dialog), "\n\tMechanic Company bonus: %s", FormatNumber(workingbonus));
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
		}
	}
	if(PlayerInfo[playerid][pJob] > 0 && PlayerInfo[playerid][pContractTime] >= 1) // OOC poslovi
	{
		if(PlayerInfo[playerid][pJob] != 9 && PlayerInfo[playerid][pJob] != 10 && PlayerInfo[playerid][pJob] != 12 && PlayerInfo[playerid][pJob] != 13 && PlayerInfo[playerid][pJob] != PLAYER_JOB_TAXI && PlayerInfo[playerid][pJob] != MECHANIC_ID)
		{
			if(PlayerInfo[playerid][pBusinessJob] == -1) {
				new workingbonus;
				workingbonus = PlayerInfo[playerid][pContractTime] * 10;
				if(workingbonus > 500)
					workingbonus = 500; // Maksimum je 500$ po paydayu
				BudgetToPlayerBankMoney(playerid, workingbonus); // treba prebaciti na bankovni racun
				format(f_dialog,sizeof(f_dialog), "\n\tPoticaj na radni staz: %s", FormatNumber(workingbonus));
				strcat(p_dialog,f_dialog, sizeof(p_dialog));
			}
		}
	}
	// HAPPY HOURS
	if( HappyHours )
		PlayerInfo[playerid][pRespects] += ( PlayerInfo[playerid][pLevel] < HappyHoursLVL ) ? 2 : 1;
	else {
	    PlayerInfo[playerid][pTempConnectTime]++;
	    if( PlayerInfo[playerid][pTempConnectTime] > 5 )
	        PlayerInfo[playerid][pRespects] += PlayerInfo[playerid][pTempConnectTime];
		else
			PlayerInfo[playerid][pRespects]++;
 	}

	// OSTALO
	PlayerInfo[playerid][pPayDayHad]++;
	PlayerInfo[playerid][pPayDay] 		= 0; 	// resetiranje payday minuta na 0

	if(PlayerInfo[playerid][pLijekTimer] > 0)
		PlayerInfo[playerid][pLijekTimer]--;
	else if(PlayerInfo[playerid][pLijekTimer] < 0)
		PlayerInfo[playerid][pLijekTimer] = 0;	// Skidanje 1 sata za timer koristenja Aspirina/Metadona/Naltrexona

	PlayerInfo[playerid][pConnectTime]++; 		// sati igranja
	PlayerInfo[playerid][pGymTimes]		= 0; 	// resetiranje GYM varijable
	if(PlayerInfo[playerid][pDonateRank] == 0)
		PlayerInfo[playerid][pFreeWorks] 	= 15;
	else if(PlayerInfo[playerid][pDonateRank] == 1)
		PlayerInfo[playerid][pFreeWorks] 	= 25;
	else if(PlayerInfo[playerid][pDonateRank] == 2)
		PlayerInfo[playerid][pFreeWorks] 	= 25;
	else if(PlayerInfo[playerid][pDonateRank] == 3)
		PlayerInfo[playerid][pFreeWorks] 	= 30;
	else if(PlayerInfo[playerid][pDonateRank] == 4)
		PlayerInfo[playerid][pFreeWorks] 	= 50;

	PlayerInfo[playerid][pFishWorks] 	= 0;
	PlayerInfo[playerid][pCasinoCool]	= 10;	// resetiranje kasino varijabli
	PlayerInfo[ playerid ][ pAdminHours ]++;	// dodavanje admin satnice

	// Dodavanje sati ugvora za posao
	if(PlayerInfo[playerid][pJob] != 0)
		PlayerInfo[playerid][pContractTime]++;


	// GYM izgled
	if( ++PlayerInfo[ playerid ][ pGymCounter ] >= 6 ) {
		PlayerInfo[ playerid ][ pMuscle ]--;
		if( PlayerInfo[ playerid ][ pMuscle ] <= 0 ) PlayerInfo[ playerid ][ pMuscle ] = 0;
		else
		{
			format(f_dialog,sizeof(f_dialog), "\n{3C95C2}(MUSCLE) Zbog nemara vas se muscle level spustio na %d!", PlayerInfo[ playerid ][ pMuscle ]);
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
			PlayerInfo[ playerid ][ pGymCounter ] = 0;
		}
	}
	if( PlayerInfo[ playerid ][ pHunger ] == 5.0 ) {
		PlayerInfo[ playerid ][ pGymCounter ] += 2;
		if( PlayerInfo[ playerid ][ pGymCounter ] >= 6 ) {
			PlayerInfo[ playerid ][ pMuscle ]--;
			format(f_dialog,sizeof(f_dialog), "\n{3C95C2}(MUSCLE) Zbog nemara vas se muscle level spustio na %d!\n", PlayerInfo[ playerid ][ pMuscle ]);
			strcat(p_dialog,f_dialog, sizeof(p_dialog));
			PlayerInfo[ playerid ][ pGymCounter ] = 0;
		}
	}
	new expamount = (PlayerInfo[playerid][pLevel] + 1) * 4;
	if (PlayerInfo[playerid][pRespects] == expamount) {
		LevelUp(playerid);
		va_GameTextForPlayer(playerid,"~g~LEVEL UP!~n~%s -> %s",5000,1, PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pLevel]+1);
	}
	ResetBH_Script(playerid);
	PlayerInfo[playerid][JackerCoolDown] = 0;
	// Experience
	new currentday, day;
	stamp2datetime(gettimestamp(), _, _, currentday, _, _, _);
	stamp2datetime(ExpInfo[playerid][eLastPayDayStamp], _, _, day, _, _, _);
	ExpInfo[playerid][eLastPayDayStamp] = gettimestamp();
	ExpInfo[playerid][eMonthPayDays]++;
	if((ExpInfo[playerid][eMonthPayDays] % 2) == 0)
		PlayerInfo[playerid][pLastLoginTimestamp] = gettimestamp();

	if(currentday == day)
	{
		PlayerInfo[playerid][pLastLoginTimestamp] = gettimestamp();
		ExpInfo[playerid][eDayPayDays] ++;
	}
	else
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 1;
	}
	if(PlayerInfo[playerid][pLevel] >= HappyHoursLVL && HappyHours && ExpInfo[playerid][eDayPayDays] >= MIN_GIVER_EXP_PAYDAYS && ExpInfo[playerid][eGivenEXP])
	{
		ExpInfo[playerid][eGivenEXP] = false;
		ExpInfo[playerid][eDayPayDays] = 1;
		format(f_dialog,sizeof(f_dialog), "\n[EXP]: Posto su aktivirani Happy Hoursi. fali vam jos 1 payday da nagradite EXP-om omiljenog igraca dana sa /exp give.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if(ExpInfo[playerid][eDayPayDays] >= MIN_GIVER_EXP_PAYDAYS && !ExpInfo[playerid][eGivenEXP])
	{
		format(f_dialog,sizeof(f_dialog), "\n[EXP]: Posto Vam je %d. payday za redom, nagradite EXP-om omiljenog igraca dana sa /exp give.", ExpInfo[playerid][eDayPayDays]);
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		va_SendClientMessage(playerid, COLOR_ORANGE, "[EXP]: Posto Vam je %d. payday za redom, nagradite EXP-om omiljenog igraca dana sa /exp give.", ExpInfo[playerid][eDayPayDays]);
	}
	SavePlayerExperience(playerid);
	
	// Dialog - Payday
	new title[64];
	if(!IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) {
		format(title, sizeof(title), "* Placa");
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, title, p_dialog, "Zatvori", "");
	}
	else if(IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) {
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Stigao vam je PayDay (( /payday ))");
	}
	PlayerInfo[playerid][pPayDayDialog] 	= EOS;
	strcat(PlayerInfo[playerid][pPayDayDialog], p_dialog, 2048);
	return 1;
}