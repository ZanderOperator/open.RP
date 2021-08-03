#include <YSI_Coding\y_hooks>

static ResetMonthPaydays()
{
	mysql_fquery(SQL_Handle(), "UPDATE experience SET monthpaydays = '0' WHERE 1");
	return 1;
}

CheckAccountsForInactivity()
{	
	new 
		currentday, 
		currentmonth, 
		logString[1536],
		inactivetimestamp = gettimestamp() - MAX_JOB_INACTIVITY_TIME,
		min_month_predicate[80];

	format(min_month_predicate, 80, "OR exp.monthpaydays < %d", MIN_MONTH_PAYDAYS);

	// Inactivity check based on last login timestamp
	inline OnInactiveAccsLoad()
	{
		new 
			rows;
		cache_get_row_count(rows);
		if(rows == 0)
		{
			Log_Write("logfiles/inactive_players.txt", 
				"(%s) - Accounts for property/job removal due to inactivity currently don't exist.", 
				ReturnDate()
			);
			return 1;
		}	
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

			// player_admin_msg table
			cache_get_value_name(i, 	"AdminMessage"	, logString, 1536);
			
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
			
			if(jobkey != 0 && loginstamp <= (gettimestamp() - MAX_JOB_INACTIVITY_TIME)) 
			{
				mysql_fquery(SQL_Handle(), "UPDATE player_jobs SET jobkey = '0', contracttime = '0' WHERE sqlid = '%d'", sqlid);				
				RemoveOfflineJob(jobkey);
				
				Log_Write("logfiles/inactive_players.txt", 
					"(%s) %s[SQLID: %d] due to inactivity lost his %s[Job ID:%d] job i %d hours of job contract.",
					ReturnDate(),
					playername,
					sqlid,
					ReturnJob(jobkey),
					jobkey,
					contracttime
				);

				format(motd, sizeof(motd), "%s[%s] - You have lost your job (%s) and %d contract hours because of inactivity.",
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
						
					mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);					
					
					mysql_fquery(SQL_Handle(), "UPDATE houses SET ownerid = '0', takings = '0' WHERE id = '%d'",
						 HouseInfo[houseid][hSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", 
						"(%s) %s[SQLID: %d] due to inactivity lost his house %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						HouseInfo[houseid][hAdress],
						HouseInfo[houseid][hSQLID],
						(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);
					
					format(motd, sizeof(motd), 
						"%s[%s] - You've lost your house (%s) because of inactivity and got %s refunded on your bank account.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						HouseInfo[houseid][hAdress], 
						FormatNumber(HouseInfo[houseid][hValue] + HouseInfo[houseid][hTakings])
					);		
					strcat(logString, motd, 1536);
					d = true;
				}
				if(garageid != INVALID_HOUSE_ID)
				{
					bankmoney = GarageInfo[garageid][gPrice];
					mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					
					mysql_fquery(SQL_Handle(), "UPDATE server_garages SET ownerid = '0' WHERE id = '%d'", 
						GarageInfo[garageid][gSQLID]
					);
					
					Log_Write("logfiles/inactive_players.txt", 
						"(%s) %s[SQLID: %d] due to inactivity lost his garage %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						GarageInfo[garageid][gAdress],
						GarageInfo[garageid][gSQLID],
						GarageInfo[garageid][gPrice]
					);
					
					format(motd, sizeof(motd), 
						"%s[%s] - You've lost your garage (%s) because of inactivity and got %d$ refunded on your bank account.",
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						GarageInfo[garageid][gAdress],
						FormatNumber(GarageInfo[garageid][gPrice])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(bizzid != INVALID_BIZNIS_ID)
				{
					bankmoney = BizzInfo[bizzid][bBuyPrice];
					if(BizzInfo[bizzid][bTill] > 0)
						bankmoney += BizzInfo[bizzid][bTill];
						
					mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);					
					
					mysql_fquery(SQL_Handle(), "UPDATE bizzes SET ownerid = '0' WHERE id = '%d'", BizzInfo[bizzid][bSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", 
						"(%s) %s[SQLID: %d] due to inactivity lost Business %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						BizzInfo[bizzid][bMessage],
						BizzInfo[bizzid][bSQLID],
						(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					
					format(motd, sizeof(motd), 
					"%s[%s] - You've lost your business %s because of inactivity %s refunded on your bank account.", 
						(!d) ? ("") : ("\n"),
						ReturnDate(),
						BizzInfo[bizzid][bMessage],
						FormatNumber(BizzInfo[bizzid][bBuyPrice] + BizzInfo[bizzid][bTill])
					);
					strcat(logString, motd, 1536);
					d = true;
				}
				if(cid != INVALID_COMPLEX_ID)
				{
					bankmoney = ComplexInfo[cid][cPrice];
					if(ComplexInfo[cid][cTill] > 0)
						bankmoney += ComplexInfo[cid][cTill];
					
					mysql_fquery(SQL_Handle(), "UPDATE accounts SET bankMoney = bankMoney + '%d' WHERE sqlid = '%d'", bankmoney, sqlid);
					mysql_fquery(SQL_Handle(), "UPDATE server_complex SET owner_id = '0' WHERE id = '%d'", ComplexInfo[cid][cSQLID]);
					
					Log_Write("logfiles/inactive_players.txt", 
						"(%s) %s[SQLID: %d] due to inactivity lost his Complex %s[SQLID: %d] and got %d$ refunded.",
						ReturnDate(),
						playername,
						sqlid,
						ComplexInfo[cid][cName],
						ComplexInfo[cid][cSQLID],
						ComplexInfo[cid][cPrice]
					);
					
					format(motd, sizeof(motd), 
						"%s[%s] - You've lost Complex %s because of inactivity and got %s refunded on your bank account.",
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
					mysql_fquery(SQL_Handle(), "UPDATE server_complex_rooms SET ownerid = '0' WHERE id = '%d'",
						ComplexRoomInfo[crid][cSQLID]
					);					

					Log_Write("logfiles/inactive_players.txt", 
						"(%s) %s[SQLID: %d] due to inactivity lost his Complex Room %s [SQLID: %d].",
						ReturnDate(),
						playername,
						sqlid,
						ComplexRoomInfo[crid][cAdress],
						ComplexRoomInfo[crid][cSQLID]
					);
					
					format(motd, sizeof(motd), 
						"%s[%s] - You've lost rent on Complex Room (%s) in Complex %s because of your inactivity.", 
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
	getdate(_, currentmonth, currentday);

	MySQL_TQueryInline(SQL_Handle(),  
		using inline OnInactiveAccsLoad, 
		va_fquery(SQL_Handle(),
			"SELECT \n\
				acc.sqlid, acc.name, acc.lastloginstamp, \n\
				pvs.vipRank, \n\
				pj.jobkey, pj.contracttime, \n\
				exp.monthpaydays, \n\
				pam.AdminMessage \n\
			FROM \n\
				accounts AS acc \n\
					INNER JOIN player_vip_status AS pvs \n\
						ON acc.sqlid = pvs.sqlid \n\
					INNER JOIN player_job AS pj \n\
						ON acc.sqlid = pvs.sqlid \n\
					INNER JOIN player_admin_msg AS pam \n\
						ON acc.sqlid = pam.sqlid \n\
					INNER JOIN experience AS exp \n\
						ON acc.sqlid = exp.sqlid \n\
			WHERE \n\
				acc.lastloginstamp <= '%d' \n\
			%s \n\
			AND NOT EXISTS\n\
				(SELECT * \n\
				FROM \n\
					inactive_accounts AS ia\n\
				WHERE acc.sqlid = ia.sqlid)",
			inactivetimestamp,
			(currentday == 1) ? min_month_predicate : ""
		),
		""
	);
		
	// Monthly EXP rewards for top 5 players with most paydays in previous month
	inline OnRewardActivePlayers()
	{
		new  
			rewardEXP = 0, 
			sql,
			playername[MAX_PLAYER_NAME],
			monthpaydays;

		for(new i = 1; i < 6; i++)
		{
			logString[0] = EOS;
			
			// accounts table
			cache_get_value_name_int(i, "sqlid", sql);
			cache_get_value_name(i, 	"name"	, playername, 24);
			
			// experience table
			cache_get_value_name_int(i, "monthpaydays", monthpaydays);

			rewardEXP = PREMIUM_GOLD_EXP / i;

			RewardPlayerForActivity(sql, rewardEXP);

			Log_Write("logfiles/rewarded_players.txt", 
				"(%s) - %s got awarded with %d EXP as %d. most active player of %d. month with %d paydays.", 
				ReturnDate(),
				playername,
				rewardEXP,
				i,
				(currentmonth - 1),
				monthpaydays
			);
			format(logString, sizeof(logString), 
				"\n[%s] - You got %d EXP as %d. most active player of %d. month with %d PayDays.\n\
					With this award you can buy various possesions \n\
					which server offers you with command /exp buy.\n\
					Congrats from %s Team!",
				ReturnDate(),
				rewardEXP,
				i,
				(currentmonth - 1),
				monthpaydays, 
				SERVER_NAME
			);
			SendServerMessage(sql, logString);
		}
		ResetMonthPaydays();
		return 1;
	}
	if(currentday == 1)
	{
		MySQL_TQueryInline(SQL_Handle(),  
			using inline OnRewardActivePlayers, 
			va_fquery(SQL_Handle(),
				"SELECT \n\
					acc.sqlid, \n\
					acc.name, \n\
					exp.monthpaydays\n\
				FROM \n\
					accounts AS acc, \n\
					INNER JOIN experience AS exp \n\
						ON acc.sqlid = exp.sqlid \n\
				WHERE \n\
					acc.playaBanTime == '0' \n\
				AND (acc.adminLvl = '0' AND acc.helper = '0')\n\
				ORDER BY exp.monthpaydays DESC \n\
				LIMIT 5"
			),
			""
		);
	}
	return 1;
}