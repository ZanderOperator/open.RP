#include <YSI_Coding\y_hooks>

static ResetMonthPaydays()
{
	mysql_fquery(g_SQL, "UPDATE experience SET monthpaydays = '0' WHERE 1");
	return 1;
}

CheckAccountsForInactivity()
{	
	new 
		currentday, 
		currentmonth, 
		logString[1536],
		inactivetimestamp = gettimestamp() - MAX_JOB_INACTIVITY_TIME;
	
	// Inactivity check based on last login timestamp
	inline OnInactiveAccsLoad()
	{
		new 
			rows;
		cache_get_row_count(rows);
		if(rows == 0) 
			return Log_Write("logfiles/inactive_players.txt", "(%s) - Accounts for property/job removal due to inactivity currently don't exist.", ReturnDate());
			
		new 
			sqlid, 
			jobkey, 
			contracttime, 
			loginstamp,
			propertytimestamp, 
			playername[24], 
			motd[256],
			bool:d = false,
			donaterank = 0,
			bool:skip = false,
			monthpaydays = 0,
			bankmoney = 0,
			houseid = INVALID_HOUSE_ID,
			bizzid = INVALID_BIZNIS_ID, 
			cid = INVALID_COMPLEX_ID, 
			crid = INVALID_COMPLEX_ID,
			garageid = INVALID_HOUSE_ID;
			
		for( new i=0; i < rows; i++) 
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

			// accounts table
			cache_get_value_name_int(i, "sqlid", sqlid);
			cache_get_value_name(i, 	"name"	, playername, 24);
			cache_get_value_name_int(i, "lastloginstamp", loginstamp);

			// player_vip_status table
			cache_get_value_name_int(i, "vipRank", donaterank);

			// player_job_table
			cache_get_value_name_int(i, "jobkey", jobkey);
			cache_get_value_name_int(i, "contracttime", contracttime);

			// experience table
			cache_get_value_name_int(i, "monthpaydays", monthpaydays);
			
			// inactivity table
			if(IsValidInactivity(sqlid)) // If there's registered inactivity in database
				continue;
			
			// player_admin_msg table
			strcpy(logString, GetAdminMessage(sqlid), sizeof(logString)); 

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
					if(BizzInfo[bizzid][bTill] > 0)
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
		return 1;
	}
	MySQL_PQueryInline(g_SQL,  
		using inline OnInactiveAccsLoad, 
		va_fquery(g_SQL,  
			"SELECT \n\
				accounts.sqlid, accounts,name, accounts.lastloginstamp, \n\
				player_vip_status.vipRank, \n\
				player_job.jobkey, player_job.contracttime, \n\
				experience.monthpaydays \n\
			FROM \n\
				accounts, \n\
				player_vip_status, \n\
				player_job, \n\
				experience \n\
			WHERE \n\
				accounts.lastloginstamp <= '%d' \n\
			AND \n\
				accounts.sqlid = player_vip_status.sqlid = player_job.sqlid = experience.sqlid",
			inactivetimestamp
		),
		""
	);
	
	// Inactivity check based on minimal amount of paydays per month required to maintain property
	getdate(_, currentmonth, currentday);
	if(currentday == 1) 
	{
		inline OnMinPayDayAccsLoad()
		{
			new 
				rows;
			cache_get_row_count(rows);

			new 
				sqlid,
				playername[24],
				motd[256],
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
			
				// accounts table
				cache_get_value_name_int(i, "sqlid", sqlid);
				cache_get_value_name(i, "name", playername);

				// player_vip_status table
				cache_get_value_name_int(i, "vipRank", donaterank);
				
				// player_admin_msg table
				strcpy(logString, GetAdminMessage(sqlid), sizeof(logString)); 

				if(isnull(logString))
					d = false;
				else d = true;

				if(IsValidInactivity(sqlid)) // Ukoliko postoji prijavljena neaktivnost koja jos uvijek traje
					continue;
						
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
					if(BizzInfo[bizzid][bTill] > 0)
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
			return 1;
		}
		MySQL_PQueryInline(g_SQL,  
			using inline OnMinPayDayAccsLoad, 
			va_fquery(g_SQL, 
				"SELECT \n\
					experience.sqlid, \n\
					accounts.name, \n\
					player_vip_status.vipRank \n\
				FROM \n\
					experience, \n\
					accounts, \n\
					player_vip_status \n\
				WHERE \n\
					experience.monthpaydays < '%d' \n\
				AND experience.sqlid = accounts.sqlid = player_vip_status.sqlid", 
				MIN_MONTH_PAYDAYS
			),
			""
		);
		
		// Monthly EXP rewards for top 5 players with most paydays in previous month
		inline OnRewardActivePlayers()
		{
			new 
				rows, 
				rewarded= 0, 
				sql,
				playername[MAX_PLAYER_NAME],
				monthpaydays;

			cache_get_row_count(rows);
			for(new i = 0; i < rows; i++)
			{
				if(rewarded == 5)
					break; 

				logString[0] = EOS;
				
				// accounts table
				cache_get_value_name_int(i, "sqlid", sql);
				cache_get_value_name(i, 	"name"	, playername, 24);
				
				// experience table
				cache_get_value_name_int(i, "monthpaydays", monthpaydays);

				
				rewarded++;
				switch(rewarded)
				{
					case 1: 
					{
						RewardPlayerForActivity(sql, PREMIUM_GOLD_EXP);
						Log_Write("logfiles/rewarded_players.txt", 
							"(%s) - %s got awarded with %d EXP as most active player of %d. month with %d paydays.", 
							ReturnDate(),
							playername,
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
						Log_Write("logfiles/rewarded_players.txt", 
							"(%s) - %s got awarded 100 EXP (2. most active player of %d. month with %d paydays)", 
							ReturnDate(),
							playername,
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
						Log_Write("logfiles/rewarded_players.txt", 
							"(%s) - %s got awarded with 75 EXP (3. most active player of %d. month with %d paydays)", 
							ReturnDate(),
							playername,
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
						Log_Write("logfiles/rewarded_players.txt", 
							"(%s) - %s got awarded with 50 EXP (4. most active player of %d. month with %d paydays)", 
							ReturnDate(),
							playername,
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
						Log_Write("logfiles/rewarded_players.txt", 
							"(%s) - %s got awarded with 25 EXP (5. most active player of %d. month with %d paydays)", 
							ReturnDate(),
							playername,
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
			ResetMonthPaydays();
			return 1;
		}

		MySQL_PQueryInline(g_SQL,  
			using inline OnRewardActivePlayers, 
			va_fquery(g_SQL,
				"SELECT \n\
					accounts.sqlid, \n\
					accounts.name, \n\
					experience.monthpaydays\n\
				FROM \n\
					accounts, \n\
					experience \n\
				WHERE \n\
					accounts.playaBanTime == '0' \n\
					AND (accounts.adminLvl = '0' AND accounts.helper = '0')\n\
					AND accounts.sqlid = monthpaydays.sqlid \n\
				ORDER BY \n\
					experience.monthpaydays DESC \n\
				LIMIT 0 , 30"
			),
			""
		);
		return 1;
	}
	return 1;
}
