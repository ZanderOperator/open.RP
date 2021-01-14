#include <YSI_Coding\y_hooks>

/*
	##     ##    ###     ######  ########   #######   ######  
	###   ###   ## ##   ##    ## ##     ## ##     ## ##    ## 
	#### ####  ##   ##  ##       ##     ## ##     ## ##       
	## ### ## ##     ## ##       ########  ##     ##  ######   
	##     ## ######### ##       ##   ##   ##     ##       ## 
	##     ## ##     ## ##    ## ##    ##  ##     ## ##    ## 
	##     ## ##     ##  ######  ##     ##  #######   ######  
*/

//Igrac je novi na serveru ili je stari
#define MAX_ADO_LABELS  200
#define PlayerNewUser_Set(%0,%1) \
		Bit1_Set(gr_NewUser,%0,%1)

// Player Module Includes at the bottom


/*
	######## #### ##     ## ######## ########   ######     ##     ##    ###    ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ##    ##     ##   ## ##   ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##          ##     ##  ##   ##  ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######     ##     ## ##     ## ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ##     ##   ##  ######### ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ##      ## ##   ##     ## ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######        ###    ##     ## ##     ##  ######  
*/

static 
	ADOText[MAX_PLAYERS],
	PlayerText:BlindTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	 ######   ##        #######  ########     ###    ##          ##     ##    ###    ########   ######  
	##    ##  ##       ##     ## ##     ##   ## ##   ##          ##     ##   ## ##   ##     ## ##    ## 
	##        ##       ##     ## ##     ##  ##   ##  ##          ##     ##  ##   ##  ##     ## ##       
	##   #### ##       ##     ## ########  ##     ## ##          ##     ## ##     ## ########   ######  
	##    ##  ##       ##     ## ##     ## ######### ##           ##   ##  ######### ##   ##         ## 
	##    ##  ##       ##     ## ##     ## ##     ## ##            ## ##   ##     ## ##    ##  ##    ## 
	 ######   ########  #######  ########  ##     ## ########       ###    ##     ## ##     ##  ######  
*/
enum E_ADO_LABEL_INFO
{
	labelid,
	Text3D:label,
	Float:lablpos[3]
}

static
    bool:BlockedOOC[MAX_PLAYERS],
    bool:HasDice[MAX_PLAYERS],
    bool:HasDrink[MAX_PLAYERS],
    bool:HasFood[MAX_PLAYERS],
    bool:FakeGunLic[MAX_PLAYERS],
    PlayerGroceries[MAX_PLAYERS],
	bool:PlayerGlobalTaskTimer[ MAX_PLAYERS ],
	Timer:PlayerTask[ MAX_PLAYERS ];

new
    AdoLabels[MAX_ADO_LABELS][E_ADO_LABEL_INFO];

new
    PlayerDrunkLevel[MAX_PLAYERS],
    PlayerFPSUnix[MAX_PLAYERS];


	
/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
*/

stock bool:Player_HasBlockedOOCChat(playerid)
{
    return BlockedOOC[playerid];
}

stock Player_SetHasBlockedOOCChat(playerid, bool:v)
{
    BlockedOOC[playerid] = v;
}

stock bool:Player_HasDice(playerid)
{
    return HasDice[playerid];
}

stock Player_SetHasDice(playerid, bool:v)
{
    HasDice[playerid] = v;
}

stock bool:Player_HasFakeGunLicense(playerid)
{
    return FakeGunLic[playerid];
}

stock Player_SetHasFakeGunLicense(playerid, bool:v)
{
    FakeGunLic[playerid] = v;
}

stock Player_GetGroceriesQuantity(playerid)
{
    return PlayerGroceries[playerid];
}

stock Player_SetGroceriesQuantity(playerid, v)
{
    PlayerGroceries[playerid] = v;
}

stock bool:Player_HasDrink(playerid)
{
    return HasDrink[playerid];
}

stock Player_SetHasDrink(playerid, bool:v)
{
    HasDrink[playerid] = v;
}

stock bool:Player_HasFood(playerid)
{
    return HasFood[playerid];
}

stock Player_SetHasFood(playerid, bool:v)
{
    HasFood[playerid] = v;
}

ResetMonthPaydays()
{
	mysql_fquery(g_SQL, "UPDATE experience SET monthpaydays = '0' WHERE 1");
	return 1;
}

Public:CheckAccountsForInactivity()
{	
	new 
		currentday, 
		currentmonth, 
		logString[1536],
		inactivetimestamp = gettimestamp() - MAX_JOB_INACTIVITY_TIME;
	
	// Inactivity check based on last login timestamp
	inline OnInactiveAccsLoad()
	{
		new rows;
		cache_get_row_count(rows);
		if( rows == 0 ) 
			return Log_Write("logfiles/inactive_players.txt", "(%s) - Accounts for property/job removal due to inactivity currently don't exist.", ReturnDate());
			
		new 
			sqlid, 
			jobkey, 
			contracttime, 
			loginstamp,
			propertytimestamp, 
			playername[24], 
			motd[256];
			
		new 
			bool:d = false,
			donaterank = 0,
			bool:skip = false,
			monthpaydays = 0,
			bankmoney = 0,
			houseid = INVALID_HOUSE_ID,
			bizzid = INVALID_BIZNIS_ID, 
			cid = INVALID_COMPLEX_ID, 
			crid = INVALID_COMPLEX_ID,
			garageid = INVALID_HOUSE_ID,
			Cache:Data;
			
		Data = cache_save();
			
		for( new i=0; i < rows; i++ ) 
		{
			d = false;
			donaterank = 0;
			skip = false;
			monthpaydays = 0;
			bankmoney = 0;
			houseid = INVALID_HOUSE_ID;
			bizzid = INVALID_BIZNIS_ID;
			cid = INVALID_COMPLEX_ID;
			crid = INVALID_COMPLEX_ID;
			garageid = INVALID_HOUSE_ID;

			cache_get_value_name_int(i, "sqlid", sqlid);
			cache_get_value_name(i, 	"name"	, playername, 24);
			cache_get_value_name_int(i, "lastloginstamp", loginstamp);
			
			if(IsValidInactivity(sqlid)) // Ukoliko postoji prijavljena neaktivnost koja jos uvijek traje
				continue;

			jobkey = GetPlayerJobKey(sqlid);
			contracttime = GetPlayerContractTime(sqlid);
			monthpaydays = GetPlayerPaydayCount(sqlid);
			donaterank = GetPlayerVIP(sqlid);
			
			cache_set_active(Data); // Povratak cachea nakon provjere u bazi

			switch(donaterank)
			{
				case 1: loginstamp += (5 * 24 * 3600);
				case 2: loginstamp += (10 * 24 * 3600);
				case 3,4: skip = true;
			}
			if(skip)
			{
				skip = false;
				continue;
			}
			
			strcpy(logString, GetAdminMessage(sqlid), sizeof(logString)); 
			if(isnull(logString))
				d = false;
			else d = true;
			
			if(jobkey != 0 && loginstamp <= (gettimestamp() - MAX_JOB_INACTIVITY_TIME) && monthpaydays < 3) // 
			{
				mysql_fquery(g_SQL, "UPDATE player_jobs SET jobkey = '0', contracttime = '0' WHERE sqlid = '%d'", sqlid);				
				RemoveOfflineJob(jobkey);
				
				Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his %s[Job ID:%d] job i %d hours of job contract.",
					ReturnDate(),
					playername,
					sqlid,
					ReturnJob(jobkey),
					jobkey,
					contracttime
				);

				format(motd, sizeof(motd), "%s[%s] - Izgubili ste	posao %s i %d sati ugovora radi nedovoljne aktivnosti.",
					(!d) ? ("") : ("\n"),
					ReturnDate(),
					ReturnJob(jobkey),
					contracttime
				);
				strcat(logString, motd, 1536);
				d = true;
			}
			// Property Inactivity Check
			propertytimestamp = gettimestamp() - MAX_INACTIVITY_TIME;
			if(loginstamp <= propertytimestamp)
			{				
				houseid = GetHouseFromSQL(sqlid);
				bizzid = GetBizzFromSQL(sqlid);
				garageid = GetGarageFromSQL(sqlid);
				cid = GetComplexFromSQL(sqlid);
				crid = GetComplexRoomFromSQL(sqlid);

				if(houseid != INVALID_HOUSE_ID)
				{
					bankmoney = HouseInfo[houseid][hValue];
					if(HouseInfo[houseid][hTakings] > 0)
						bankmoney += HouseInfo[houseid][hTakings];
						
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);					
					
					mysql_fquery(g_SQL, "UPDATE houses SET ownerid = '0', takings = '0' WHERE id = '%d'",
						 HouseInfo[houseid][hSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his house %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						HouseInfo[houseid][hAdress],
						HouseInfo[houseid][hSQLID],
						(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste kucu na adresi %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						HouseInfo[houseid][hAdress], 
						(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);		
					strcat(logString, motd, 1536);
					d = true;
				}
				if(garageid != INVALID_HOUSE_ID)
				{
					bankmoney = GarageInfo[garageid][gPrice];
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(g_SQL, "UPDATE server_garages SET ownerid = '0' WHERE id = '%d'", 
						GarageInfo[garageid][gSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his garage %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						GarageInfo[garageid][gAdress],
						GarageInfo[garageid][gSQLID],
						GarageInfo[garageid][gPrice]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste garazu %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						GarageInfo[garageid][gAdress],
						GarageInfo[garageid][gPrice]
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(bizzid != INVALID_BIZNIS_ID)
				{
					bankmoney = BizzInfo[bizzid][bBuyPrice];
					if(BizzInfo[ bizzid ][ bTill ] > 0)
						bankmoney += BizzInfo[bizzid][bTill];
						
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);					
					
					mysql_fquery(g_SQL, "UPDATE bizzes SET ownerid = '0' WHERE id = '%d'", BizzInfo[bizzid][bSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost Business %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						BizzInfo[bizzid][bMessage],
						BizzInfo[bizzid][bSQLID],
						(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste biznis %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.", 
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						BizzInfo[bizzid][bMessage],
						(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(cid != INVALID_COMPLEX_ID)
				{
					bankmoney = ComplexInfo[cid][cPrice];
					if(ComplexInfo[cid][cTill] > 0)
						bankmoney += ComplexInfo[cid][cTill];
					
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id = '0' WHERE id = '%d'", ComplexInfo[cid][cSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his Complex %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						ComplexInfo[cid][cName],
						ComplexInfo[cid][cSQLID],
						ComplexInfo[cid][cPrice]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste complex %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						ComplexInfo[cid][cName],
						(ComplexInfo[cid][cPrice] + ComplexInfo[cid][cTill])
					);	
					strcat(logString, motd, 1536);
					d = true;
				}
				if(crid != INVALID_COMPLEX_ID)
				{	
					mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'",
						ComplexRoomInfo[crid][cSQLID]
					);					

					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his Complex Room %s [SQLID: %d].",
						ReturnDate(),
						playername,
						sqlid,
						ComplexRoomInfo[crid][cAdress],
						ComplexRoomInfo[crid][cSQLID]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste sobu %s u Complexu %s radi nedovoljne aktivnosti.", 
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						ComplexRoomInfo[crid][cAdress],
						ComplexInfo[GetComplexEnumID(crid)][cName]
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				SendServerMessage(sqlid, logString);
			}
		}
		cache_delete(Data);
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline OnInactiveAccsLoad, 
		va_fquery(g_SQL,  
			"SELECT sqlid, name, lastloginstamp FROM accounts WHERE lastloginstamp <= '%d'",
			inactivetimestamp),
		""
	);
	
	// Inactivity check based on minimal amount of paydays per month required to maintain property
	getdate(_, currentmonth, currentday);
	if(currentday == 1) 
	{
		inline OnMinPayDayAccsLoad()
		{
			new rows, Cache:QueryData;
			QueryData = cache_save();
			cache_get_row_count(rows);

			new 
				sqlid,
				playername[24],
				motd[256];
				
			new 
				bool:d = false,
				donaterank = 0,
				bool:skip = false,
				bankmoney = 0,
				houseid = INVALID_HOUSE_ID,
				bizzid = INVALID_BIZNIS_ID, 
				cid = INVALID_COMPLEX_ID, 
				crid = INVALID_COMPLEX_ID,
				garageid = INVALID_HOUSE_ID;

			for(new i = 0; i < rows; i++)
			{
				d = false;
				donaterank = 0;
				skip = false;
				bankmoney = 0;
				houseid = INVALID_HOUSE_ID;
				bizzid = INVALID_BIZNIS_ID;
				cid = INVALID_COMPLEX_ID;
				crid = INVALID_COMPLEX_ID;
				garageid = INVALID_HOUSE_ID;
			
				cache_get_value_name_int(i, "sqlid", sqlid);

				format(playername, sizeof(playername), "%s", ConvertSQLIDToName(sqlid));
				donaterank = GetPlayerVIP(sqlid);
				
				strcpy(logString, GetAdminMessage(sqlid), sizeof(logString)); 
				if(isnull(logString))
					d = false;
				else d = true;

				if(IsValidInactivity(sqlid)) // Ukoliko postoji prijavljena neaktivnost koja jos uvijek traje
					continue;
			
				cache_set_active(QueryData); // Povratak cachea nakon provjere u bazi
			
				switch(donaterank)
				{
					case 1 .. 4: skip = true;
				}
				if(skip)
				{
					skip = false;
					continue;
				}
				
				houseid = GetHouseFromSQL(sqlid);
				bizzid = GetBizzFromSQL(sqlid);
				garageid = GetGarageFromSQL(sqlid);
				cid = GetComplexFromSQL(sqlid);
				crid = GetComplexRoomFromSQL(sqlid);

				if(houseid != INVALID_HOUSE_ID)
				{
					bankmoney = HouseInfo[houseid][hValue];
					if(HouseInfo[houseid][hTakings] > 0)
						bankmoney += HouseInfo[houseid][hTakings];
						
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney +'%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(g_SQL, "UPDATE houses SET ownerid = '0', takings = '0' WHERE id = '%d'", 
						HouseInfo[houseid][hSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his house on adress %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						HouseInfo[houseid][hAdress],
						HouseInfo[houseid][hSQLID],
						(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);
					
				
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste kucu na adresi %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						HouseInfo[houseid][hAdress], 
						(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(garageid != INVALID_HOUSE_ID)
				{
					bankmoney = GarageInfo[garageid][gPrice];
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney +'%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(g_SQL, "UPDATE server_garages SET ownerid = '0' WHERE id = '%d'", 
						GarageInfo[garageid][gSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his garage %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						GarageInfo[garageid][gAdress],
						GarageInfo[garageid][gSQLID],
						GarageInfo[garageid][gPrice]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste garazu %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						GarageInfo[garageid][gAdress],
						GarageInfo[garageid][gPrice]
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(bizzid != INVALID_BIZNIS_ID)
				{
					bankmoney = BizzInfo[bizzid][bBuyPrice];
					if(BizzInfo[ bizzid ][ bTill ] > 0)
						bankmoney += BizzInfo[bizzid][bTill];
						
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney +'%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(g_SQL, "UPDATE bizzes SET ownerid = '0' WHERE id = '%d'", BizzInfo[bizzid][bSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his Business %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						BizzInfo[bizzid][bMessage],
						BizzInfo[bizzid][bSQLID],
						(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste biznis %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.", 
						(!d) ? ("") : ("\n"),
						BizzInfo[bizzid][bMessage],
						(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(cid != INVALID_COMPLEX_ID)
				{
					bankmoney = ComplexInfo[cid][cPrice];
					if(ComplexInfo[cid][cTill] > 0)
						bankmoney += ComplexInfo[cid][cTill];
					
					mysql_fquery(g_SQL, "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(g_SQL, "UPDATE server_complex SET owner_id = '0' WHERE id = '%d'", ComplexInfo[cid][cSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his Complex %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						ComplexInfo[cid][cName],
						ComplexInfo[cid][cSQLID],
						ComplexInfo[cid][cPrice]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste complex %s radi nedovoljne aktivnosti i dobili %d$ naknade na bankovni racun.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						ComplexInfo[cid][cName],
						(ComplexInfo[cid][cPrice] + ComplexInfo[cid][cTill])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(crid != INVALID_COMPLEX_ID)
				{	
					mysql_fquery(g_SQL, "UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'", 
						ComplexRoomInfo[crid][cSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", "(%s) %s[SQLID: %d] due to inactivity lost his Complex Room on adress %s[SQLID: %d].",
						ReturnDate(),
						playername,
						sqlid,
						ComplexRoomInfo[crid][cAdress],
						ComplexRoomInfo[crid][cSQLID]
					);
					
					format(motd, sizeof(motd), "%s[%s] - Izgubili ste sobu %s u Complexu %s radi nedovoljne aktivnosti.", 
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						ComplexRoomInfo[crid][cAdress],
						ComplexInfo[GetComplexEnumID(crid)][cName]
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				SendServerMessage(sqlid, logString);
			}
			cache_delete(QueryData);
			return 1;
		}
		MySQL_PQueryInline(g_SQL,  
			using inline OnMinPayDayAccsLoad, 
			va_fquery(g_SQL, "SELECT * FROM experience WHERE monthpaydays < '%d'", MIN_MONTH_PAYDAYS),
			""
		);

		// Monthly EXP rewards for top 5 players with most paydays in previous month
		inline OnRewardActivePlayers()
		{
			new rows, rewarded= 0, sql, monthpaydays, Cache:RewardQueryData;
			RewardQueryData = cache_save();
			cache_get_row_count(rows);
			for(new i = 0; i < rows; i++)
			{
				if(rewarded == 5)
					break; 

				logString[0] = EOS;
				cache_get_value_name_int(i, "sqlid", sql);
				cache_get_value_name_int(i, "monthpaydays", monthpaydays);

				if(IsAccountTeamStaff(sql))
					continue;
				
				cache_set_active(RewardQueryData); // Povratak cachea nakon provjere u bazi
				rewarded++;
				switch(rewarded)
				{
					case 1: 
					{
						RewardPlayerForActivity(sql, PREMIUM_GOLD_EXP);
						Log_Write("logfiles/rewarded_players.txt", "(%s) - %s got awarded with %d EXP as most active player of %d. month with %d paydays.", 
							ReturnDate(),
							ConvertSQLIDToName(sql),
							PREMIUM_GOLD_EXP,
							(currentmonth - 1),
							monthpaydays
						);
						format(logString, sizeof(logString), 
							"[%s] - Dobili ste %d EXP-a kao najaktivniji igrac %d. mjeseca \n\
								sa %d paydayova.\nOvom nagradom mozete iskoristiti brojne pogodnosti \n\
								koje Vam server nudi sa komandom /exp buy.\n\
								Velike cestitke od %s Teama!",
							ReturnDate(),
							PREMIUM_GOLD_EXP,
							(currentmonth - 1),
							monthpaydays, 
							SERVER_NAME
						);
						SendServerMessage(sql, logString);
					}
					case 2: 
					{
						RewardPlayerForActivity(sql, 100);
						Log_Write("logfiles/rewarded_players.txt", "(%s) - %s got awarded 100 EXP as an award for second most active player of %d. month with %d paydays.", 
							ReturnDate(),
							ConvertSQLIDToName(sql),
							(currentmonth - 1),
							monthpaydays
						);
						format(logString, sizeof(logString), 
							"[%s] - Dobili ste %d EXP-a kao 2. najaktivniji igrac %d. mjeseca \n\
								sa %d paydayova.\nOvom nagradom mozete iskoristiti brojne pogodnosti \n\
								koje Vam server nudi sa komandom /exp buy.\n\
								Velike cestitke od %s Teama!",
							ReturnDate(),
							100,
							(currentmonth - 1),
							monthpaydays, 
							SERVER_NAME
						);
						SendServerMessage(sql, logString);
					}
					case 3: 
					{
						RewardPlayerForActivity(sql, 75);
						Log_Write("logfiles/rewarded_players.txt", "(%s) - %s got awarded with 75 EXP as an award for third most active player of %d. month with %d paydays.", 
							ReturnDate(),
							ConvertSQLIDToName(sql),
							(currentmonth - 1),
							monthpaydays
						);
						format(logString, sizeof(logString), 
							"[%s] - Dobili ste %d EXP-a kao 3. najaktivniji igrac %d. mjeseca \n\
								sa %d paydayova.\nOvom nagradom mozete iskoristiti brojne pogodnosti \n\
								koje Vam server nudi sa komandom /exp buy.\n\
								Velike cestitke od %s Teama!",
							ReturnDate(),
							75,
							(currentmonth - 1),
							monthpaydays, 
							SERVER_NAME
						);
						SendServerMessage(sql, logString);
					}
					case 4: 
					{
						RewardPlayerForActivity(sql, 50);
						Log_Write("logfiles/rewarded_players.txt", "(%s) - %s got awarded with 50 EXP as an award for fourth most active player of %d. month with %d paydays.", 
							ReturnDate(),
							ConvertSQLIDToName(sql),
							(currentmonth - 1),
							monthpaydays
						);
						format(logString, sizeof(logString), 
							"[%s] - Dobili ste %d EXP-a kao 4. najaktivniji igrac %d. mjeseca \n\
								sa %d paydayova.\nOvom nagradom mozete iskoristiti brojne pogodnosti \n\
								koje Vam server nudi sa komandom /exp buy.\n\
								Velike cestitke od %s Teama!",
							ReturnDate(),
							50,
							(currentmonth - 1),
							monthpaydays, 
							SERVER_NAME
						);
						SendServerMessage(sql, logString);
					}
					case 5: 
					{
						RewardPlayerForActivity(sql, 25);
						Log_Write("logfiles/rewarded_players.txt", "(%s) - %s got awarded with 25 EXP as an award for fifth most active player of %d. month with %d paydays.", 
							ReturnDate(),
							ConvertSQLIDToName(sql),
							(currentmonth - 1),
							monthpaydays
						);
						format(logString, sizeof(logString), 
							"[%s] - Dobili ste %d EXP-a kao 5. najaktivniji igrac %d. mjeseca \n\
								sa %d paydayova.\nOvom nagradom mozete iskoristiti brojne pogodnosti \n\
								koje Vam server nudi sa komandom /exp buy.\n\
								Velike cestitke od %s Teama!",
							ReturnDate(),
							25,
							(currentmonth - 1),
							monthpaydays, 
							SERVER_NAME
						);
						SendServerMessage(sql, logString);
					}
				}
			}
			cache_delete(RewardQueryData);
			ResetMonthPaydays();
			return 1;
		}

		MySQL_PQueryInline(g_SQL,  
			using inline OnRewardActivePlayers, 
			va_fquery(g_SQL, "SELECT * FROM  experience ORDER BY experience.monthpaydays DESC LIMIT 0 , 30"),
			""
		);
		return 1;
	}
	return 1;
}

stock CheckPlayerInteriors(playerid)
{
	new interior = -1, virtualworld = -1;
	interior = GetPlayerInterior(playerid);
	virtualworld = GetPlayerVirtualWorld(playerid);

	CheckPlayerHouseInt(playerid, interior, virtualworld);
	CheckPlayerBizzInt(playerid, interior, virtualworld);
	CheckPlayerGarageInt(playerid);
	CheckPlayerPickupInt(playerid, interior, virtualworld);
	CheckPlayerComplexInt(playerid, interior, virtualworld);
	CheckPlayerComplexRoomInt(playerid, interior, virtualworld);
	return 1;
}
		
timer KickTimer[50](playerid)
{
	Kick(playerid);
	return 1;
}

timer BanTimer[50](playerid)
{
	Kick(playerid);
	return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid)
{
	defer KickTimer(playerid);
	return 1;
}
	
forward BanPlayer(playerid);
public BanPlayer(playerid)
{
	defer BanTimer(playerid);
	return 1;
}

stock GetAdoFreeLabelSlot() 
{
	for(new i = 0; i < MAX_ADO_LABELS; i++)
	{
	    if(!AdoLabels[i][label])
	    {
	        return i;
	    }
	}
	return -1;
}

stock ResetAdoLabelSlot(playerid, type, value)
{
	switch(type)
	{
	    //slot
		case 1:
		{
		    ADOText[AdoLabels[value][labelid]] = 0;
		    AdoLabels[value][labelid] = 0;
      		DestroyDynamic3DTextLabel(AdoLabels[value][label]);
		    AdoLabels[value][lablpos][0] = 0;
		    AdoLabels[value][lablpos][1] = 0;
		    AdoLabels[value][lablpos][2] = 0;
      		SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali prikvaceni opis.");
			return 1;
		}
		//playerid
		case 2:
		{
		    for(new i = 0; i < MAX_ADO_LABELS; i++)
		    {
		        if(AdoLabels[i][labelid] == value)
		        {
		            ADOText[AdoLabels[i][labelid]] = 0;
		            AdoLabels[i][labelid] = -1;
		      		DestroyDynamic3DTextLabel(AdoLabels[i][label]);
				    AdoLabels[i][lablpos][0] = 0;
				    AdoLabels[i][lablpos][1] = 0;
				    AdoLabels[i][lablpos][2] = 0;
				    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali prikvaceni opis.");
				    return 1;
		        }
		    }
		}
	}
	return 0;
}

stock LevelUp(playerid)
{
	if(PlayerInfo[playerid][pLevel] > 0)
	{
		new
			expamount = ( PlayerInfo[playerid][pLevel] + 1 ) * 4;
		if (PlayerInfo[playerid][pRespects] < expamount) {
			return 0;
		}

		PlayerInfo[playerid][pLevel]++;
		if(PlayerVIP[playerid][pDonateRank] > 0)
		{
			PlayerInfo[playerid][pRespects] -= expamount;
			new total = PlayerInfo[playerid][pRespects];
			if(total > 0) PlayerInfo[playerid][pRespects] = total;
			else
				PlayerInfo[playerid][pRespects] = 0;
		}
		else
			PlayerInfo[playerid][pRespects] = 0;

		mysql_fquery(g_SQL, "UPDATE accounts SET levels = '%d', respects = '%d' WHERE sqlid = '%d'",
			PlayerInfo[playerid][pLevel],
			PlayerInfo[playerid][pRespects],
			PlayerInfo[playerid][pSQLID]
		);

		SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	}
	return 1;
}

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

timer LoginCheck[60000](playerid)
{
	if( !IsPlayerLogged(playerid) && IsPlayerConnected(playerid) )
	{
		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobio si kick nakon 60 sekundi!");
		KickMessage(playerid);
	}
	return 1;
}

Public:PlayerMinuteTask(playerid)
{
	PlayerTick[playerid][ptMainTimer] = gettimestamp() + 60;
	
	if( (CreditInfo[playerid][cCreditType] == 5 || CreditInfo[playerid][cCreditType] == 6 || CreditInfo[playerid][cCreditType] == 7) && !CreditInfo[playerid][cUsed] && gettimestamp() >= CreditInfo[playerid][cTimestamp]) 
	{
		ResetCreditVars(playerid);
		SavePlayerCredit(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "[SMS]: Automatski vam je ponisten namjenski kredit radi neobavljanja kupovne obveze.");
	}
	PaydayInfo[playerid][pPayDay] += 1;
	if(PaydayInfo[playerid][pPayDay] >= 60)
		GivePlayerPayCheck(playerid);
		
	if(PlayerJail[playerid][pJailTime] > 0)
		PlayerJail[playerid][pJailTime] -= 1;
	else if(PlayerJail[playerid][pJailTime] == 0 )
	{
		if( PlayerJail[playerid][pJailed] == 1 )
		{
			SetPlayerPosEx(playerid, 90.6552, -236.3789, 1.5781, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Slobodni ste, platili ste svoj dug drustvu!");
		}
		else if( PlayerJail[playerid][pJailed] == 2 )
		{
			SetPlayerPosEx(playerid, 1482.7426, -1740.1372, 13.7500, 0, 0, false);
			SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
			SetPlayerColor(playerid, COLOR_PLAYER);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pusten si iz Fort DeMorgana, pripazi na ponasanje i server pravila!");
		}
		else if( PlayerJail[playerid][pJailed] == 3 )
		{
			SetPlayerPosEx(playerid, 636.7744,-601.3240,16.3359, 0, 0, false);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Slobodni ste, platili ste svoj dug drustvu!");
		}
		else if( PlayerJail[playerid][pJailed] == 5 ) // Treatment
		{
			TogglePlayerControllable(playerid, 1);
			ClearAnim(playerid);
			SetPlayerPosEx(playerid, 1185.4681,-1323.8542,13.5720, 0, 0, false);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Zavrsilo je vase lijecenje, otpusteni ste iz bolnice!");
		}
		PlayerJail[playerid][pJailed] = 0;
		PlayerJail[playerid][pJailTime] = 0;
	}
	else if(PlayerJail[playerid][pJailTime] < 0)
		PlayerJail[playerid][pJailTime] = 0;
		
		
	if(PlayerDrugStatus[playerid][pDrugUsed] != 0)
	{
		if(-- PlayerDrugStatus[playerid][pDrugSeconds] <= 0)
		{
			PlayerDrugStatus[playerid][pDrugSeconds] = 0;
			PlayerDrugStatus[playerid][pDrugUsed] = 0;
		}
	}
	if(PlayerDrugStatus[playerid][pDrugOrder] > 0)
	{
		-- PlayerDrugStatus[playerid][pDrugOrder];
	}
	
	HungerCheck(playerid);
	AFKCheck(playerid);
	AC_SavePlayerWeapons(playerid);
	return 1;	
}

timer PlayerGlobalTask[1000](playerid)
{
	if ( !SafeSpawned[playerid] || !IsPlayerConnected(playerid) ) 
		return 1;
	
	if( gettimestamp() >= PlayerTick[playerid][ptMainTimer] )
		PlayerMinuteTask(playerid);	
	
	PlayerSyncs[ playerid ] = false;
	new tmphour,tmpmins,tmpsecs;
	GetServerTime(tmphour,tmpmins,tmpsecs);
	SetPlayerTime(playerid,tmphour,tmpmins);
	
	static
		pcar = INVALID_VEHICLE_ID;
	
	if((pcar = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static
			Float:vhealth;

		GetVehicleHealth(pcar, vhealth);
		
		if(vhealth < 250.0)
		{
			AC_SetVehicleHealth(pcar, 260.0);
			CallLocalFunction("OnPlayerCrashVehicle", "idf", playerid, pcar, 0.0);
			
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			
			GetVehicleParamsEx(pcar, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(pcar, 0, lights, alarm, doors, bonnet, boot, objective);
			
			VehicleInfo[pcar][vEngineRunning] = false;
		}
	}	
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock ChangePlayerName(playerid, newname[], type, bool:admin_cn = false)
{	
	new	Cache:result,
		counts;
	
	result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", newname));
	counts = cache_num_rows();
	cache_delete(result);
	
	if( counts ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That nickname already exists!");
	
	new
		oldname[MAX_PLAYER_NAME];
	format( oldname, MAX_PLAYER_NAME, GetName(playerid, false) );
	
	SendAdminMessage(COLOR_RED, "AdmWarn: [ChangeName Report] - Old Nick: %s, New Nick: %s", oldname, newname);
	
	#if defined MODULE_LOGS
	Log_Write("logfiles/namechange.txt", "(%s) {%d} Old nickname: %s | New nickname: %s",
		ReturnDate(),
		PlayerInfo[ playerid ][ pSQLID ],
		oldname,
		newname
	);
	#endif
	
	mysql_fquery(g_SQL, "UPDATE accounts SET name = '%e', sex = '%d', age = '%d' WHERE sqlid = '%d'",
		newname,
		PlayerInfo[ playerid ][ pSex ],
		PlayerInfo[ playerid ][ pAge ],
		PlayerInfo[ playerid ][ pSQLID ]
	);
	
	PlayerJail[ playerid ][ pArrested ] = 0;
	LicenseInfo[playerid][pGunLic] 	= 0;
	
	if(admin_cn == (false)) {
		if( !PlayerVIP[playerid][pDonateRank] )
			PlayerToBudgetMoney( playerid, 10000);
	}
	if(type == 1)
	{
		if(PlayerInfo[playerid][pLevel] < 10)
			PlayerInfo[ playerid ][ pChangenames ] = gettimestamp() + 172800; 
		else if(PlayerInfo[playerid][pLevel] >= 10 && PlayerInfo[playerid][pLevel] < 20)
			PlayerInfo[ playerid ][ pChangenames ] = gettimestamp() + 86400; 
	}
	else if(type == 2)
		PlayerInfo[playerid][pChangeTimes]--;
	
	va_SendClientMessage( playerid, 
		COLOR_RED, 
		"[ ! ]: You sucessfully changed your nickname to %s, please relog with new nickname!", 
		newname
	);
	if(PlayerVIP[playerid][pDonateRank] > 0)
	{
		va_SendClientMessage( playerid, COLOR_RED, "[ ! ]: You have %d free changenames left.", 
			PlayerInfo[playerid][pChangeTimes]
		);
	}
	KickMessage(playerid);
	return 1;
}

stock static HungerCheck(playerid)
{
	if(PlayerWounded[playerid] || PlayerDeath[playerid][pKilled] > 0)
		return 1;
		
	new 
		Float:health;	
	if( PlayerHealth[playerid][pHunger] < 0.0 ) {
		if( PlayerGym[playerid][pMuscle] > 10 ) {
			PlayerHealth[playerid][pHunger] -= 0.001;
		} else PlayerHealth[playerid][pHunger] -= 0.006;
		
		if( PlayerHealth[playerid][pHunger] < -5.0 ) 
			PlayerHealth[playerid][pHunger] = -5.0;
	}
	else PlayerHealth[playerid][pHunger] -= 0.002;

	GetPlayerHealth(playerid, health);
	if(health < 100.0)
		SetPlayerHealth(playerid, health + PlayerHealth[playerid][pHunger]);
	else if(PlayerHealth[playerid][pHunger] < 0.0)
		SetPlayerHealth(playerid, health + PlayerHealth[playerid][pHunger]);
	return 1;
}

ReturnPlayerIP(playerid)
	return PlayerInfo[playerid][pIP];

/**
    <summary>
        Provjerava dali je igracev nick po RP pravilima (Ime_Prezime)
    </summary>
	
	<param name="name">
        Ime od igraca
    </param>

    <returns>
        1 - Nick po pravilima, 0 - Nick nije po pravilima
    </returns>

    <remarks>
        -
    </remarks>
*/
IsValidName(name[])
{
	new length = strlen(name),
		namesplit[2][MAX_PLAYER_NAME],
		FirstLetterOfFirstname,
		FirstLetterOfLastname,
		ThirdLetterOfLastname,
		Underscore;

	split(name, namesplit, '_');
    if (strlen(namesplit[0]) > 1 && strlen(namesplit[1]) > 1)
    {
        // Firstname and Lastname contains more than 1 character + it there are separated with '_' char. Continue...
    }
    else return 0; // No need to continue...

    FirstLetterOfFirstname = namesplit[0][0];
	if (FirstLetterOfFirstname >= 'A' && FirstLetterOfFirstname <= 'Z')
	{
        // First letter of Firstname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	FirstLetterOfLastname = namesplit[1][0];
    if (FirstLetterOfLastname >= 'A' && FirstLetterOfLastname <= 'Z')
    {
		// First letter of Lastname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	ThirdLetterOfLastname = namesplit[1][2];
    if (ThirdLetterOfLastname >= 'A' && ThirdLetterOfLastname <= 'Z' || ThirdLetterOfLastname >= 'a' && ThirdLetterOfLastname <= 'z')
    {
		// Third letter of Lastname can be uppercase and lowercase (uppercase for Lastnames like McLaren). Continue...
	}
	else return 0; // No need to continue...

    for(new i = 0; i < length; i++)
	{
		if (name[i] != FirstLetterOfFirstname && name[i] != FirstLetterOfLastname && name[i] != ThirdLetterOfLastname && name[i] != '_')
		{
			if(name[i] >= 'a' && name[i] <= 'z')
			{
				// Name contains only letters and that letters are lowercase (except the first letter of the Firstname, first letter of Lastname and third letter of Lastname). Continue...
			}
			else return 0; // No need to continue...
		}

		// This checks that '_' char can be used only one time (to prevent names like this Firstname_Lastname_Something)...
		if (name[i] == '_')
		{
			Underscore++;
			if (Underscore > 1) return 0; // No need to continue...
		}
	}
	return 1; // All check are ok, Name is valid...
}

////////
PrintAccent(playerid)
{
	new 
		string[64];
	
	if(!isnull(PlayerAppearance[playerid][pAccent]) || PlayerAppearance[playerid][pAccent][0] == EOS)
		format(string, 64, "");
	else if( strcmp(PlayerAppearance[playerid][pAccent], "None", true) )
		format(string, 64, "[%s] ", PlayerAppearance[playerid][pAccent]);
    return string;
}

stock ClearPlayerChat(playerid)
{
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
}

stock OOCProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx,
		    Float:posy,
			Float:posz,
		    Float:oldposx,
		    Float:oldposy,
			Float:oldposz,
		    Float:tempposx,
			Float:tempposy,
			Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach (new i : Player)
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				if(!Player_HasBlockedOOCChat(i))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else if(Player_HasBlockedOOCChat(i) && (PlayerInfo[playerid][pAdmin] || PlayerInfo[playerid][pHelper]))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);

					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
			}
		}
	}
	return 1;
}

stock ReportMessage(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && !Bit1_Get( a_TogReports, i ) )
			SendClientMessage(i, color, string);
		else if( PlayerInfo[i][pHelper] )
			SendClientMessage(i, color, string);
	}
	return 1;
}

stock GetPlayerNameFromID(mysqlid)
{
	new 
		name[MAX_PLAYER_NAME];
		
	if(mysqlid == 9999) {
		format(name, MAX_PLAYER_NAME, "None");
		return name;
	}
	
	new Cache:result;
	result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT name FROM accounts WHERE sqlid = '%d'", mysqlid));
	
	cache_get_value_name(0, "name",  name);
	cache_delete(result);
	return name;
}

// Pokazuje stats dialog igracu (targetid-u).
stock ShowPlayerStats(playerid, targetid)
{
	new
		tmpString[ 20 ],
		motd[ 256 ], gender[15+1];

	switch(PlayerInfo[targetid][pSex])	{
		case 0: format(gender, sizeof(gender), "Musko"); // re-bug
		case 1: format(gender, sizeof(gender), "Musko");
		case 2: format(gender, sizeof(gender), "Zensko");
	}
		
    new pDialog[1500];
	format(motd, sizeof(motd),"Datum: %s\n\n"COL_COABLUE"IC STATS:\n\n"COL_WHITE"%s | Spol: [%s] | Godina: [%d] | Mobile Nr.: [%d] | Crypto Nr.: [%d] | Novac: [$%d] | Banka: [$%d] n",
		ReturnDate(),
		GetName(targetid,true),
		gender,
		PlayerInfo[targetid][pAge],
		PlayerMobile[targetid][pMobileNumber],
		PlayerMobile[targetid][pCryptoNumber],
		PlayerInfo[targetid][pMoney],
		PlayerInfo[targetid][pBank]
	);
    strcat(pDialog,motd, sizeof(pDialog));

    format(motd, sizeof(motd),""COL_WHITE"Posao: [%s] | Ugovor: [%d/%d] | Uhicen: [%d] | Profit po PayDayu: [$%d] | Organizacija: [%s] | Rank u organizaciji: [%s (%d)] | Hunger: [%.2f]\n",
		ReturnJob(PlayerJob[targetid][pJob]),
		PlayerJob[targetid][pContractTime],
		PlayerVIP[targetid][pDonateRank] ? 1 : 5,
		PlayerJail[targetid][pArrested],
		PaydayInfo[targetid][pPayDayMoney],
		ReturnPlayerFactionName(targetid),
		ReturnPlayerRankName(targetid),
		PlayerFaction[targetid][pRank],
		PlayerHealth[targetid][pHunger]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Bankovna stednja: [%dh / %dh] | Ulozeno novaca: [%d$] | Zabrana stednje: [%dh]\n\n\n",
		PlayerSavings[playerid][pSavingsTime],
		PlayerSavings[playerid][pSavingsType],
		PlayerSavings[playerid][pSavingsMoney],
		PlayerSavings[playerid][pSavingsCool]
	);
	strcat(pDialog,motd, sizeof(pDialog));

	switch( PlayerVIP[targetid][pDonateRank] ) 
	{
		case PREMIUM_BRONZE: 	format(tmpString, 20, "Bronze");
		case PREMIUM_SILVER:	format(tmpString, 20, "Silver");
		case PREMIUM_GOLD:		format(tmpString, 20, "Gold");
		case PREMIUM_PLATINUM:	format(tmpString, 20, "Platinum");
		default:
			format(tmpString, 20, "Nista");
	}

    format(motd, sizeof(motd),""COL_COABLUE"OOC STATS:\n\n"COL_WHITE"SQL ID: [%d] | Level: [%d] | Premium Account: [%s] | Sati igranja: [%d] | Respekti: [%d/%d]\n",
		PlayerInfo[targetid][pSQLID],
		PlayerInfo[targetid][pLevel],
		tmpString,
		PlayerInfo[targetid][pConnectTime],
		PlayerInfo[targetid][pRespects],
		( PlayerInfo[targetid][pLevel] + 1 ) * 4
	);
    strcat(pDialog,motd, sizeof(pDialog));

    format(motd, sizeof(motd),""COL_WHITE"Muscle lvl: [%d] | Warnings: [%d/3] | Vrijeme do place: [%d minuta] | VIP Vozilo: [%d] | Donator Veh Perms: [%d] | Mobile Bill: [%d$]\n",
		PlayerGym[targetid][pMuscle],
		PlayerInfo[targetid][pWarns],
		( 60 - PaydayInfo[targetid][pPayDay] ),
		PlayerVIP[targetid][pDonatorVehicle],
		PlayerVIP[targetid][pDonatorVehPerms],
		PlayerMobile[targetid][pMobileCost]
	);
    strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"Zadnji puta IG: [%s]\n",
		PlayerInfo[targetid][pLastLogin]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	
	format(motd, sizeof(motd),""COL_WHITE"House key: [%d] | Biznis key: [%d] | Garage key: [%d] | RentKey[%d] | CarKey: [%d] | Job Key: [%d] | ComplexKey [%d] | ComplexRoomKey [%d]\n\n\n",
		PlayerKeys[targetid][pHouseKey],
		PlayerKeys[targetid][pBizzKey],
		PlayerKeys[targetid][pGarageKey],
		PlayerKeys[targetid][pRentKey],
		PlayerKeys[targetid][pVehicleKey],
		PlayerJob[targetid][pJob],
		PlayerKeys[targetid][pComplexKey],
		PlayerKeys[targetid][pComplexRoomKey]
	);
	strcat(pDialog,motd, sizeof(pDialog));
	if( PlayerInfo[playerid][pAdmin] >= 1 )
	{

		format(motd, sizeof(motd), ""COL_COABLUE"WEAPONS STATS:\n\n"COL_WHITE"Gun #1: [%d] | Gun #2: [%d] | Gun #3: [%d] | Gun #4: [%d] | Gun #5: [%d]\nGun #6: [%d] | Gun #7: [%d] | Gun #8: [%d] | Gun #9: [%d] | Gun #10: [%d]\n",
			PlayerWeapons[targetid][pwWeaponId][1],
			PlayerWeapons[targetid][pwWeaponId][2],
			PlayerWeapons[targetid][pwWeaponId][3],
			PlayerWeapons[targetid][pwWeaponId][4],
			PlayerWeapons[targetid][pwWeaponId][5],
			PlayerWeapons[targetid][pwWeaponId][6],
			PlayerWeapons[targetid][pwWeaponId][7],
			PlayerWeapons[targetid][pwWeaponId][8],
			PlayerWeapons[targetid][pwWeaponId][9],
			PlayerWeapons[targetid][pwWeaponId][10]
		);
		strcat(pDialog,motd, sizeof(pDialog));

		format(motd, sizeof(motd), "\n\n"COL_WHITE"Ammo #1: [%d] | Ammo #2: [%d] | Ammo #3: [%d] | Ammo #4: [%d] | Ammo #5: [%d]\nAmmo #6: [%d] | Ammo #7: [%d] | Ammo #8: [%d] | Ammo #9: [%d] | Ammo #10: [%d]\n",
			PlayerWeapons[targetid][pwAmmo][1],
			PlayerWeapons[targetid][pwAmmo][2],
			PlayerWeapons[targetid][pwAmmo][3],
			PlayerWeapons[targetid][pwAmmo][4],
			PlayerWeapons[targetid][pwAmmo][5],
			PlayerWeapons[targetid][pwAmmo][6],
			PlayerWeapons[targetid][pwAmmo][7],
			PlayerWeapons[targetid][pwAmmo][8],
			PlayerWeapons[targetid][pwAmmo][9],
			PlayerWeapons[targetid][pwAmmo][10]
		);
		strcat(pDialog,motd, sizeof(pDialog));
	}
    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, ""COL_COABLUE"Your Stats", pDialog, "OK", "");
	return 1;
}

Public:SayHelloToPlayer(playerid)
{
	//Hello Message
	new 
		string[85];
	format(string, 85, "~w~Dobro dosli~n~~h~~h~~b~%s", GetName(playerid));
	GameTextForPlayer(playerid, string, 2500, 1);
	Bit1_Set( gr_FristSpawn, playerid, false );
	return 1;
}

stock SetPlayerScreenFade(playerid)
{
    BlindTD[playerid] = CreatePlayerTextDraw(playerid, -20.000000, 0.000000, "_");
	PlayerTextDrawUseBox(playerid, BlindTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, BlindTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, BlindTD[playerid], 3);
	PlayerTextDrawLetterSize(playerid, BlindTD[playerid], 1.0, 100.0);
	PlayerTextDrawColor(playerid, BlindTD[playerid], 0x000000FF);
	PlayerTextDrawShow(playerid, BlindTD[playerid]);
	return 1;
}

stock RemovePlayerScreenFade(playerid)
{
	PlayerTextDrawHide(playerid, BlindTD[playerid]);
	PlayerTextDrawDestroy(playerid, BlindTD[playerid]);
	BlindTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock IllegalFactionJobCheck(factionid, jobid) 
{
    new	Cache:result,
		counts;

	result = mysql_query(g_SQL, 
				va_fquery(g_SQL, 
					"SELECT sqlid \n\
						FROM player_jobs, player_faction \n\
						WHERE player_jobs.jobkey = '%d' \n\
						AND (player_faction.facMemId = '%d' OR player_faction.facLeadId = '%d')", 
					jobid, 
					factionid, 
					factionid
				)
			);

	counts = cache_num_rows();
	cache_delete(result);
	return counts;
}

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/

hook OnPlayerDisconnect(playerid, reason)
{
	if(SafeSpawned[playerid])
	{
		stop PlayerTask[playerid];
		PlayerGlobalTaskTimer[playerid] = false;
	}
	
	RemovePlayerScreenFade(playerid);
	DisablePlayerCheckpoint(playerid);
    PlayerDrunkLevel[playerid]	= 0;
	PlayerFPSUnix[playerid]		= 0;
	if(ADOText[playerid])
	{
		for(new i = 0; i < MAX_ADO_LABELS; i++)
		{
		    if(AdoLabels[i][labelid] == playerid)
		    {
		        AdoLabels[i][labelid] = 0;
                DestroyDynamic3DTextLabel(AdoLabels[i][label]);
		        ADOText[playerid] = 0;
		        break;
		    }
		}
	}
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	PlayerGlobalTaskTimer[ playerid ] = false;
	
	PlayerDrunkLevel[playerid]	= 0;
	PlayerFPSUnix[playerid]		= gettimestamp();

    BlockedOOC[playerid] = false;

    HasDice[playerid] = false;
    HasDrink[playerid] = false;
    HasFood[playerid] = false;
    FakeGunLic[playerid] = false;
    PlayerGroceries[playerid] = 0;
	return continue(playerid);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerAppearance[playerid][pWalkStyle])
	{
		if(((newkeys & KEY_UP) && (newkeys & KEY_WALK)) || ((newkeys & KEY_DOWN) && (newkeys & KEY_WALK) || ((newkeys & KEY_WALK) && (newkeys & KEY_LEFT)) || ((newkeys & KEY_WALK) && (newkeys & KEY_RIGHT))))
  		{
   		    switch(PlayerAppearance[playerid][pWalkStyle])
			{
			    case 1:
			        ApplyAnimationEx(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1,1,0);
  			  	case 2:
  			  	    ApplyAnimationEx(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1,1,0);
			    case 3:
			        ApplyAnimationEx(playerid,"PED","WALK_civi",4.1,1,1,1,1,1,1,0);
			    case 4:
			        ApplyAnimationEx(playerid,"PED","WALK_armed",4.1,1,1,1,1,1,1,0);
			    case 5:
			        ApplyAnimationEx(playerid,"PED","WALK_csaw",4.1,1,1,1,1,1,1,0);
			    case 6:
			        ApplyAnimationEx(playerid,"PED","Walk_DoorPartial",4.1,1,1,1,1,1,1,0);
			    case 7:
			        ApplyAnimationEx(playerid,"PED","WALK_fat",4.1,1,1,1,1,1,1,0);
			    case 8:
			        ApplyAnimationEx(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1,1,0);
			    case 9:
			        ApplyAnimationEx(playerid,"PED","WALK_old",4.1,1,1,1,1,1,1,0);
			    case 10:
			        ApplyAnimationEx(playerid,"PED","WALK_player",4.1,1,1,1,1,1,1,0);
			    case 11:
			        ApplyAnimationEx(playerid,"PED","WALK_rocket",4.1,1,1,1,1,1,1,0);
			    case 12:
			        ApplyAnimationEx(playerid,"PED","WALK_shuffle",4.1,1,1,1,1,1,1,0);
			    case 13:
			        ApplyAnimationEx(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1,1,0);
			    case 14:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1,1,0);
			    case 15:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1,1,0);
			    case 16:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1,1,0);
			    case 17:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1,1,0);
			    case 18:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1,1,0);
			    case 19:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkshop",4.1,1,1,1,1,1,1,0);
			    case 20:
			        ApplyAnimationEx(playerid,"PED","WOMAN_walkfatold",4.1,1,1,1,1,1,1,0);
			    case 21:
			        ApplyAnimationEx(playerid,"MUSCULAR","Mscle_rckt_walkst",4.1,1,1,1,1,1,1,0);
			    case 22:
			        ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk",4.1,1,1,1,1,1,1,0);
			    case 23:
			        ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk_armed",4.1,1,1,1,1,1,1,0);
			    case 24:
			        ApplyAnimationEx(playerid,"MUSCULAR","Musclewalk_Csaw",4.1,1,1,1,1,1,1,0);
			    case 25:
			        ApplyAnimationEx(playerid,"PED","Player_Sneak_walkstart",4.1,1,1,1,1,1,1,0);
			    case 26:
			        ApplyAnimationEx(playerid,"POOL","POOL_Walk",4.1,1,1,1,1,1,1,0);
			    case 27:
			        ApplyAnimationEx(playerid,"ROCKET","walk_rocket",4.1,1,1,1,1,1,1,0);
			    case 28:
			        ApplyAnimationEx(playerid,"PED","WALK_shuffle",4.1,1,1,1,1,1,1,0);
                case 29:
                    ApplyAnimationEx(playerid,"WUZI","Wuzi_Walk",4.1,1,1,1,1,1,1,0);
			}
		}
		else if(RELEASED(KEY_WALK))
		{
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
			//ClearAnimations(playerid);
		}
	}
	return 1;
}

hook OnPlayerUpdate(playerid) 
{
	if(!PlayerGlobalTaskTimer[playerid] && SafeSpawned[playerid])
	{
		PlayerGlobalTaskTimer[playerid] = true;
		PlayerTask[playerid] = repeat PlayerGlobalTask(playerid);
	}
		
	if( PlayerFPSUnix[playerid] < gettimestamp() ) 
	{
		new 
			drunkLevel = GetPlayerDrunkLevel(playerid);
		if( drunkLevel < 100 ) 
			SetPlayerDrunkLevel(playerid, 2000);
		else 
		{
			if( PlayerDrunkLevel[playerid] != drunkLevel ) 
				PlayerDrunkLevel[playerid] = drunkLevel;
		}
		PlayerFPSUnix[playerid] = gettimestamp();
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_RULES: 
		{
			if( !response ) return 1;
			switch(listitem) 
			{
				case 0: 
				{
					new string[835];
					strcat(string,"Metagaming - Metagaming najcesce predstavlja mijesanje Out Of Characted (OOC) i In Character (IC) stvari. Naravno,\n takav vid krsenja pravila se moze ispoljiti na vise nacina ali najcesci su:\n 1.) Citanje nametaga iznad igraca te dozivanje istoga IC iako ga ne poznajete ili nikada niste ni culi njegovo ime", sizeof(string));
					strcat(string,"\n 2.) Koristenje /pm komande kako bi se nasli negdje radi neke IC stvari,\n tipa prodaja oruzja, droge ili jednostavno radi neke price. U ovaj vid krsenja pravila se takodje ubraja i\n koristenje 3rd party programa kako bi se nasli negdje IC.", sizeof(string));
					strcat(string,"\n 3.) Koristenje informacija koje ste saznali OOC za IC svrhe je takodje zabranjeno.\n Primjer, ako ste culi da dolazi policija da vas uhapsi OOC i iskoristite to IC kako bi pobjegli daleko od njih kako vas ne mogu naci.", sizeof(string));
					strcat(string,"\n Sve ovo je kaznjivo i strogo zabranjeno na nasem serveru.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Metagaming", string, "Close", "");
					return 1;
				}
				case 1: 
				{
					new string[860];
					strcat(string, "Powergaming - Powergaming je, u najcescim slucajevima, roleplay radnje koja u tom trenutku nije moguca ili uopste nije moguca, za ljudsko tijelo ili slicno.\n Naravno, i powergaming kao metagaming moze biti na vise nacina uradjen. Takodje kaznjih. Najcesce radnje su:\n 1. Skakanje sa neke odredjene visine koja je dovoljna da vas povrijedi pri padu i udari o tlo a da se povreda na roleplaya nego igrac jednostavno ustane i nastavi dalje.", sizeof(string));
					strcat(string, "\n 2. Zavezani ste lisicama a onda roleplayate da jednostavno lomite lisice. To u, barem toj situaciji, nije nikako moguce.", sizeof(string));
					strcat(string, "\n 3. Drzi vas jedan lik sa ledja dok vas drugi udara sprijeda, vi se okrenete i prebacite jednoga preko ledja a drugoga kung-fu potezom udarite u glavu i pobjegnete.\n Velika je vjerovatnoca da ovo nikako ne mozete izvesti, tako da se i ovo smatra powergamingom. Svaki vid powergaminga je kaznjiv.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Powergaming", string, "Close", "");
					return 1;
				}
				case 2: 
				{
					new string[720];
					strcat(string, "RP2WIN - RP2WIN je roleplay sa nekom drugom osobom u kojem forsirate, bukvalno, da sve ide u vasu korist.\n Nesto sto moze da vam priblizi ovu radnju je sledeci me: / me sutira Ime_Prezime ta ga obara na pod izazivajuci mu nesvijest.\n Ovo je zabranjeno raditi jer u roleplayu treba svakome dati pravednu sansu da odradi svoju stranu RP-a.\n Pravilan me bi trebao glasiti: / me pokusava udariti Ime_Prezime kako bi ga oborio na pod.", sizeof(string));
					strcat(string, "\n Tek kada vidite da li je igrac pao, odatle mozete nove situacije RPati. Naravno, RP2WIN moze da se izrazi i kada se branite.\n Ukoliko neko iskoristi nesto slicno drugom me-u, a vi samo napisete da vas je promasio ili da ste se izmakli takodje moze biti vid RP2WINa ali takodje i PGa.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "RP2WIN", string, "Close", "");
					return 1;
				}
				case 3: 
				{
					new string[480];
					strcat(string, "Revenge Kill - Revenge Kill kao sto samo ime kaze je ubojstvo iz osvete.\n Kada se dogodi ubojstvo, vi morate zaboraviti SVE u vezi tog dogadjaja. Mjesto ubojstva, pocinjitela, ucesnike.", sizeof(string));
					strcat(string, "Sve.\n Jednostavno nastavljate RPati kao da se to nikada nije dogodilo ali ako ste prezivjeli, naravno,\n imate svako pravo da RPate da se to dogodilo i imate pravo juriti toga koji vas je pokusao ubiti, onda ne bi bio revenge kill\n vec pokusaj ubojstva koji nije uspio.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Revenge Kill", string, "Close", "");
					return 1;
				}
				case 4: 
				{
					new string[320];
					strcat(string, "Deathmatch - Vjerovatno znate o cemu se radi. DM je ubijanje ljudi bez ikakvog ili bez dovoljno dobrog IC razloga.\n Nedovoljno dobar razlog moze predstavljati to", sizeof(string));
					strcat(string, "sto vas je igrac mrko pogledao a vi ste ispraznili citav sarzer u njega.\n Ovo je STROGO zabranjeno na nasem serveru i isto tako je kaznjivo.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Deathmatch", string, "Close", "");
					return 1;
				}
				case 5: 
				{
					new string[640];
					strcat(string, "-/me koristite kako bi prikazali radnju koju vas karakter izvrsava u odredjenom trenutku.\n Nema pisanja predugackih /me emotesa sa 5 priloski odredbi za nacin koje zavrsavaju na -ci.\n To je bespotrebno i niste bolji rper ako napisete kilometarski /me.", sizeof(string));
					strcat(string, "\n Ali i ako dodjete u situaciju da napisete sve u jedan /me probajte da tu ne budu\n vise od 3 radnje/glagola jer je onda to PG. Dakle,trudite se citljive i jednostavne\n emotese pisati da vas ljudi koji rpaju sa vama razumiju.", sizeof(string));
					strcat(string, "\n Imenko_Prezimenko vadi kutiju cigareta i lijevog dzepa. \n Imenko_Prezimenko uzima jednu cigaretu te ju pali.\n Ovo su primjeri dobrog koristenja /me emotesa.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/me komanda", string, "Close", "");
					return 1;
				}
				case 6: 
				{
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/ame komanda", "-/ame je ustvari isto sto i /me samo ce se tekst koji upisete ispisati vama iznad glave.\nDakle ako upisete /ame gleda kako Johnny jede, ono sto ce iznad vase glave pisati je Imenko_Prezimenko gleda kako Johnny jede.\n/ame jos mozete koristiti za izrazavanje emocija vaseg lika, kao npr /ame se smije. Takodjer se moze koristiti da opisete svoj izgled tj. izgled svoga lika.", "Close", "");
					return 1;
				}
				case 7: 
				{
					new string[660];
					strcat(string, "/do koristite kako bi opisali ono sto se desava oko vas, tj okolinu u kojoj se vas karakter nalazi.\n /Do emotes ne KORISTITE da bi prikazali sta vas karakter radi jer je za to /me. Nema smisla pisati /do Rukujemo se, /do Izgledam kao da imam 15 godina.\n Znaci trudite se da ga ne koristite ni da opisete svog karaktera tako cesto, jer za to mozete koristiti i /ame.\n /ame izgleda kao da ima 15 godina, crne hlace i duks.", sizeof(string));
					strcat(string, "Par primjera ispravnog koristenja /do komande:\n /do Iz pravca mehanicarske radnje bi dolazio miris ulja radi vozila koja sa tamo popravljaju.\n /Do Kafic bi bio sav u neredu, stolice su prevrnute kao i stolovi.", sizeof(string));
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "/do komanda", string, "Close", "");
					return 1;
				}
			}
			return 1;
		}
	}
	return 0;
 }

stock GetChannelSlot(playerid, channel)
{
	if(channel == PlayerRadio[playerid][pRadio][1])return 1;
	if(channel == PlayerRadio[playerid][pRadio][2])return 2;
	if(channel == PlayerRadio[playerid][pRadio][3])return 3;

	return false;
}