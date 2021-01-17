#include <YSI_Coding\y_hooks>
/*
	- enumerator & defines
*/

#define MAX_JOB_NAME_LEN		(20)

enum 
{
	NORMAL_JOBS_EMPLOYERS 		= (25),  /* OOC POSLOVI */
	OFFICIAL_JOBS_EMPLOYERS 	= (20), /* IC POSLOVI */
	
	NORMAL_FREE_WORKS 		  	= (15),
	BRONZE_DONATOR_FREE_WORKS 	= (20),
	SILVER_DONATOR_FREE_WORKS 	= (25),
	GOLD_DONATOR_FREE_WORKS   	= (30),
	PLATINUM_DONATOR_FREE_WORKS	= (50)
};

enum E_JOB_NAME_INFO
{
	jID,
	jName[MAX_JOB_NAME_LEN]
}
static
   JobNames[][E_JOB_NAME_INFO] = {
	{ 0, "Unemployed" },
	{ 1, "Sweeper" },
	{ 2, "Pizza Boy" }, 
	{ 3, "Mechanic" }, 
	{ 4, "Mower" },
	{ 5, "Fabric Worker" },
	{ 6, "Taxi Driver" },
	{ 7, "Farmer" },
	{ 13, "Car Jacker" },
	{ 14, "Lumberjack" },
	{ 16, "Trashman" },
	{ 17, "Vehicle Impounder" }
};

enum E_JOBS_DATA 
{
	SWEEPER,    /* [id:1] */
	MECHANIC,   /* [id:3] */
	CRAFTER,    /* [id:5] */
	TAXI, 	    /* [id:6] */
	FARMER,     /* [id:7] */
	LOGGER,     /* [id:14] */
	GARBAGE,    /* [id:16] */
	IMPOUNDER,  /* [id:17] */
}
static 
	JobData[E_JOBS_DATA];

static bool:IsWorkingJob[MAX_PLAYERS] = {false, ...};


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

LoadPlayerJob(playerid)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM player_job WHERE sqlid = '%d'", PlayerInfo[playerid][pSQLID]),
        "LoadingPlayerJob", 
        "i", 
        playerid
    );
    return 1;
}

Public: LoadingPlayerJob(playerid)
{
    if(!cache_num_rows())
    {
        mysql_fquery_ex(g_SQL, 
            "INSERT INTO player_job(sqlid, jobkey, contracttime, freeworks) \n\
                VALUES('%d', '0', '0', '0')",
            PlayerInfo[playerid][pSQLID]
        );
        return 1;
    }
    cache_get_value_name_int(0,  "jobkey"		, PlayerJob[playerid][pJob]);
    cache_get_value_name_int(0,  "contracttime"	, PlayerJob[playerid][pContractTime]);
    cache_get_value_name_int(0,  "freeworks"	, PlayerJob[playerid][pFreeWorks]);
    return 1;
}

hook function LoadPlayerStats(playerid)
{
    LoadPlayerJob(playerid);
	return continue(playerid);
}

SavePlayerJob(playerid)
{
    mysql_fquery_ex(g_SQL,
        "UPDATE player_job SET jobkey = '%d', contracttime = '%d', freeworks = '%d' WHERE sqlid = '%d'",
        PlayerJob[playerid][pJob],
        PlayerJob[playerid][pContractTime],
        PlayerJob[playerid][pFreeWorks],
        PlayerInfo[playerid][pSQLID]
    );
    return 1;
}

hook function SavePlayerStats(playerid)
{
    SavePlayerJob(playerid);
	return continue(playerid);
}

SaveJobData() 
{
	mysql_fquery(g_SQL, 
		"UPDATE server_jobs SET Sweeper = '%d', Mechanic = '%d', Crafter = '%d', Taxi = '%d', Farmer = '%d',\n\
		Logger = '%d', Garbage = '%d', Impounder = '%d' WHERE 1",
		JobData[SWEEPER],
		JobData[MECHANIC],
		JobData[CRAFTER],
		JobData[TAXI],
		JobData[FARMER],
		JobData[LOGGER],
		JobData[GARBAGE],
		JobData[IMPOUNDER]
	);
	return 1;
}

LoadServerJobs() 
{
	mysql_pquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM server_jobs WHERE 1"), 
		"OnServerJobsLoaded",
		""
	);
	return 1;
}

Public: OnServerJobsLoaded() 
{
	new rows = cache_num_rows();
	if(!rows) return printf( "MySQL Report: No Server Jobs exist to load.");
	
	cache_get_value_name_int(0, "Sweeper", JobData[SWEEPER]);
	cache_get_value_name_int(0, "Mechanic", JobData[MECHANIC]);
	cache_get_value_name_int(0, "Crafter", JobData[CRAFTER]);
	cache_get_value_name_int(0, "Taxi", JobData[TAXI]);
	cache_get_value_name_int(0, "Farmer", JobData[FARMER]);
	cache_get_value_name_int(0, "Logger", JobData[LOGGER]);
	cache_get_value_name_int(0, "Garbage", JobData[GARBAGE]);
	cache_get_value_name_int(0, "Impounder", JobData[IMPOUNDER]);
	return 1;
}

hook function LoadServerData()
{
	LoadServerJobs();
	return continue();

}

/*
	- Functions
*/

stock bool:Player_IsWorkingJob(playerid)
{
	return IsWorkingJob[playerid];
}

stock Player_SetIsWorkingJob(playerid, bool:v)
{
	IsWorkingJob[playerid] = v;
}

ReturnJob(job_id)
{
	new 
		id = -1;
	for(new i = 0; i < sizeof(JobNames); i++)
	{
		if(JobNames[i][jID] == job_id)
		{
			id = i;
			break;
		}
	}
	return JobNames[id][jName];
}

SetPlayerJob(playerid, job_id) 
{
	switch(job_id) 
	{
		case 1: JobData[SWEEPER] ++;
		case 3: JobData[MECHANIC] ++;
		case 5: JobData[CRAFTER] ++;
		case 6: JobData[TAXI] ++;
		case 7: JobData[FARMER] ++;
		case 14: JobData[LOGGER] ++;
		case 16: JobData[GARBAGE] ++;
		case 17: JobData[IMPOUNDER] ++;
	}
	PlayerJob[playerid][pJob] = job_id;
	PlayerJob[playerid][pContractTime] = 0;
	SaveJobData();
	return 1;
}

RemovePlayerJob(playerid) 
{
	switch(PlayerJob[playerid][pJob]) 
	{
		case 1: JobData[SWEEPER] --;
		case 3: JobData[MECHANIC] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
	}
	PlayerJob[playerid][pJob] = 0;
	PlayerJob[playerid][pContractTime] = 0;
	SaveJobData();
	return (true);
}

RemoveOfflineJob(jobid)
{
	switch(jobid) 
	{
		case 1: JobData[SWEEPER] --;
		case 3: JobData[MECHANIC] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
	}
	SaveJobData();
	return (true);
}

JobsList() 
{
	new 
		buffer[512];

	format(buffer, sizeof(buffer), "{3C95C2}Job\t{3C95C2}Workers\nCistac ulica\t[%d/%d]\nMehanicar\t[%d/%d]\nTvornicki radnik\t[%d/%d]\nTaksista\t[%d/%d]\nFarmer\t[%d/%d]\nDrvosjeca\t[%d/%d]\nSmetlar\t[%d/%d]\nVehicle Impounder[%d/%d]",
		JobData[SWEEPER], NORMAL_JOBS_EMPLOYERS,
		JobData[MECHANIC], OFFICIAL_JOBS_EMPLOYERS,
		JobData[CRAFTER], NORMAL_JOBS_EMPLOYERS,
		JobData[TAXI], OFFICIAL_JOBS_EMPLOYERS,
		JobData[FARMER], NORMAL_JOBS_EMPLOYERS,
		JobData[LOGGER], NORMAL_JOBS_EMPLOYERS,
		JobData[GARBAGE], NORMAL_JOBS_EMPLOYERS,
		JobData[IMPOUNDER], OFFICIAL_JOBS_EMPLOYERS
	);
	return (buffer);
}

IllegalFactionJobCheck(factionid, jobid) 
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
	- hooks
*/	

hook function ResetPlayerVariables(playerid)
{
    PlayerJob[playerid][pJob] = 0;
    PlayerJob[playerid][pContractTime] = 0;
    PlayerJob[playerid][pFreeWorks] = 0;

	IsWorkingJob[playerid] = false;
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case DIALOG_JOBS: 
		{
			if( !response ) 
				return 1;

			switch( listitem )
			{
				case 0: 
				{
					if(JobData[SWEEPER] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 1);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao cistac ulica!");
				}
				case 1: 
				{
					if(JobData[MECHANIC] >= OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendClientMessage( playerid, COLOR_RED, "Morate biti level 3+ za ovaj posao (treba vozilo)!");

					SetPlayerJob(playerid, 3);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao mehanicar!");
				}
				case 2: 
				{
					if(JobData[CRAFTER] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 5);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao tvornicki radnik!");
				}
				case 3: 
				{
					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 3+ mogu biti taksisti.");
					if(JobData[TAXI] >= OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 6);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao taksista!");
				}
				case 4: 
				{
					if(JobData[FARMER] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 7);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao farmer!");
				}
				case 5: 
				{
					if(JobData[LOGGER] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 14);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao drvosjeca!");
				}
				case 6: 
				{
					if(JobData[GARBAGE] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 16);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao smetlar!");
				}
				case 7:
				{
					if( PlayerInfo[ playerid ][ pLevel ] < 5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 5+ mogu biti veh impounderi.");
					if(JobData[GARBAGE] >= OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");
					
					SetPlayerJob(playerid, 17);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao impounder!");
				}
			}
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
		}
		case DIALOG_IJOBS:
		{
			if(!response) 
				return 1;

			switch(listitem) 
			{
				case 0: 
				{
					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) 
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 3+ mogu biti lopovi.");
					PlayerJob[playerid][pJob] 			= 9;
					if(PlayerVIP[playerid][pDonateRank] == 0)
						PlayerJob[playerid][pFreeWorks] = NORMAL_FREE_WORKS;	
					else if(PlayerVIP[playerid][pDonateRank] == 1)
						PlayerJob[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
					else if(PlayerVIP[playerid][pDonateRank] == 2)
						PlayerJob[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
					else if(PlayerVIP[playerid][pDonateRank] == 3)
						PlayerJob[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
					else if(PlayerVIP[playerid][pDonateRank] == 4)
						PlayerJob[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
					SendClientMessage( playerid, COLOR_RED, "[ ! ] Zaposlili ste se kao lopov!");
				}
			}
			return 1;
		}
	}
	return 0;
}

/*
	- Commands
*/

CMD:takejob(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Imate posao, koristite /quitjob!");
	if( IsACop(playerid) || IsFDMember(playerid) || IsASD(playerid) || IsAGov(playerid) ) return SendClientMessage( playerid, COLOR_RED, "Ne smijete biti u organizaciji!");
	
	if( IsPlayerInRangeOfPoint(playerid, 7.0, 1617.5137,-1560.1582,14.1662) )
		ShowPlayerDialog(playerid, DIALOG_IJOBS, DIALOG_STYLE_LIST, "ILEGALNI POSLOVI", "Lopov", "Choose", "Abort");
	else if( IsPlayerInRangeOfPoint(playerid, 5.0, 1301.4661, 764.3820, -98.6427) )
		ShowPlayerDialog(playerid, DIALOG_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Lista i kvote poslova", JobsList(), "Choose", "Abort");
		
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mjesta za uzimanje posla!");
	return (true);
}

CMD:quitjob(playerid, params[])
{
	if(PlayerJob[playerid][pJob] == 0) return SendClientMessage( playerid, COLOR_RED, "Nemate posao!");
	if(PlayerJob[playerid][pFreeWorks] < 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte PayDay i NE radite ture da mozete dati otkaz na svome poslu!");
	switch( PlayerVIP[playerid][pDonateRank]) {
		case 0: {
			if(PlayerJob[playerid][pContractTime] >= 5) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 5 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 5 - PlayerJob[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 1: {
			if(PlayerJob[playerid][pContractTime] >= 2) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 2 sata ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 2 - PlayerJob[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 2: {
			if(PlayerJob[playerid][pContractTime] >= 1)
			{
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 1 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
				PlayerJob[playerid][pContractTime] = 0;
			} else {
				new chours = 2 - PlayerJob[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 3,4: {
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Dali ste otkaz na poslu.");
			RemovePlayerJob(playerid);
		}
	}
	return (true);
}

CMD:jobduty(playerid, params[]) 
{
	SendClientMessage(playerid, COLOR_RED, "[ ! ] [ Jobs - On Duty ]:");
	SendClientMessage(playerid, COLOR_RED, "[ ! ]  Taxi Company:");
	foreach(new i: Player) 
	{
		if(bool:Player_TaxiDuty(playerid)) 
		{
			new 
				Float: t_overall = float(TaxiInfo[i][pTaxiPoints]) / float(TaxiInfo[i][pTaxiVoted]);
			va_SendClientMessage(playerid, -1, "Ime: %s // Taxi Rating: %.1f // Kontakt broj: %d.", 
				GetName(i), 
				t_overall, 
				PlayerMobile[i][pMobileNumber]
			);
		}
	}
	SendClientMessage(playerid, COLOR_RED, "[ ! ]  ");
	SendClientMessage(playerid, COLOR_RED, "[ ! ]  Mechanic Company:");
	foreach(new i: Player) 
	{
		if(MechanicDuty[i] == true ) 
			va_SendClientMessage(playerid, -1, "Ime: %s // Kontakt broj: %d.", GetName(i), PlayerMobile[i][pMobileNumber]);
		
	}
	return (true);
}