/* 
*	  		  Job System
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*		 credits: CoA dev team.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI\y_hooks>

/*
	- enumerator & defines
*/	

enum {
	NORMAL_JOBS_EMPLOYERS = (25),  /* OOC POSLOVI */
	OFFICIAL_JOBS_EMPLOYERS = (20), /* IC POSLOVI */
	
	NORMAL_FREE_WORKS 		  	= (15),
	BRONZE_DONATOR_FREE_WORKS 	= (20),
	SILVER_DONATOR_FREE_WORKS 	= (25),
	GOLD_DONATOR_FREE_WORKS   	= (30),
	PLATINUM_DONATOR_FREE_WORKS	= (50)
};

enum E_JOBS_DATA {
	SWEEPER,    /* [id:1] */
	MECHANIC,   /* [id:3] */
	CRAFTER,    /* [id:5] */
	TAXI, 	    /* [id:6] */
	FARMER,     /* [id:7] */
	LOGGER,     /* [id:14] */
	TRUCKER,    /* [id:15] */
	GARBAGE,    /* [id:16] */
	IMPOUNDER,  /* [id:17] */
	TRANSPORTER /* [id:18] */
}
new JobData[E_JOBS_DATA];

/*
	- mySQL
*/

SaveJobData() {
	new query[300];
	format(query, sizeof(query), "UPDATE `server_jobs` SET `Sweeper` = '%d', `Mechanic` = '%d', `Crafter` = '%d', `Taxi` = '%d', `Farmer` = '%d', `Logger` = '%d', `Garbage` = '%d', `Impounder` = '%d', `Transporter` = '%d' WHERE 1",
		JobData[SWEEPER],
		JobData[MECHANIC],
		JobData[CRAFTER],
		JobData[TAXI],
		JobData[FARMER],
		JobData[LOGGER],
		JobData[GARBAGE],
		JobData[IMPOUNDER],
		JobData[TRANSPORTER]
	);
	return mysql_tquery(g_SQL, query);
}

LoadServerJobs() {
	mysql_tquery(g_SQL, "SELECT * FROM server_jobs WHERE 1", "OnServerJobsLoaded");
	return 1;
}

forward OnServerJobsLoaded();
public OnServerJobsLoaded() {
	new rows = cache_num_rows();
	if(!rows) return printf( "MySQL Report: No Server Jobs exist to load.");
	
	cache_get_value_name_int(0, "Sweeper", JobData[SWEEPER]);
	cache_get_value_name_int(0, "Mechanic", JobData[MECHANIC]);
	cache_get_value_name_int(0, "Crafter", JobData[CRAFTER]);
	cache_get_value_name_int(0, "Taxi", JobData[TAXI]);
	cache_get_value_name_int(0, "Farmer", JobData[FARMER]);
	cache_get_value_name_int(0, "Logger", JobData[LOGGER]);
	cache_get_value_name_int(0, "Trucker", JobData[TRUCKER]);
	cache_get_value_name_int(0, "Garbage", JobData[GARBAGE]);
	cache_get_value_name_int(0, "Impounder", JobData[IMPOUNDER]);
	cache_get_value_name_int(0, "Transporter", JobData[TRANSPORTER]);
	return (true);
}

/*
	- Functions
*/

SetPlayerJob(playerid, job_id) {
	switch(job_id) {
		case 1: JobData[SWEEPER] ++;
		case 3: JobData[MECHANIC] ++;
		case 5: JobData[CRAFTER] ++;
		case 6: JobData[TAXI] ++;
		case 7: JobData[FARMER] ++;
		case 14: JobData[LOGGER] ++;
		case 15: JobData[TRUCKER] ++;
		case 16: JobData[GARBAGE] ++;
		case 17: JobData[IMPOUNDER] ++;
		case 18: JobData[TRANSPORTER] ++;
	}
	PlayerInfo[playerid][pJob] = job_id;
	PlayerInfo[playerid][pContractTime] = 0;
	SaveJobData();
	return (true);
}

RemovePlayerJob(playerid) {
	switch(PlayerInfo[playerid][pJob]) {
		case 1: JobData[SWEEPER] --;
		case 3: JobData[MECHANIC] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
		case 18: JobData[TRANSPORTER] --;
	}
	PlayerInfo[playerid][pJob] 	= 0;
	PlayerInfo[playerid][pContractTime] = 0;
	SaveJobData();
	return (true);
}

RemoveOfflineJob(jobid)
{
	switch(jobid) {
		case 1: JobData[SWEEPER] --;
		case 3: JobData[MECHANIC] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 15: JobData[TRUCKER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
		case 18: JobData[TRANSPORTER] --;
	}
	SaveJobData();
	return (true);
}

JobsList() {
	new buffer[512];
			
	format(buffer, sizeof(buffer), "{3C95C2}Job\t{3C95C2}Workers\nCistac ulica\t[%d/%d]\nMehanicar\t[%d/%d]\nTvornicki radnik\t[%d/%d]\nTaksista\t[%d/%d]\nFarmer\t[%d/%d]\nDrvosjeca\t[%d/%d]\nSmetlar\t[%d/%d]\nVehicle Impounder[%d/%d]\nTransporter[%d/%d]",
		JobData[SWEEPER], NORMAL_JOBS_EMPLOYERS,
		JobData[MECHANIC], OFFICIAL_JOBS_EMPLOYERS,
		JobData[CRAFTER], NORMAL_JOBS_EMPLOYERS,
		JobData[TAXI], OFFICIAL_JOBS_EMPLOYERS,
		JobData[FARMER], NORMAL_JOBS_EMPLOYERS,
		JobData[LOGGER], NORMAL_JOBS_EMPLOYERS,
		JobData[GARBAGE], NORMAL_JOBS_EMPLOYERS,
		JobData[IMPOUNDER], OFFICIAL_JOBS_EMPLOYERS,
		JobData[TRANSPORTER], NORMAL_JOBS_EMPLOYERS
	);
	return (buffer);
}

/*
	- hooks
*/	

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case DIALOG_JOBS: 
		{
			if( !response ) return (true);
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
				case 8:
				{
					if(JobData[GARBAGE] >= NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");
					SetPlayerJob(playerid, 18);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao transporter!");
				}
			}
			// Set FreeWorks
			if(PlayerInfo[playerid][pDonateRank] == 0)
				PlayerInfo[playerid][pFreeWorks] = NORMAL_FREE_WORKS;	
			else if(PlayerInfo[playerid][pDonateRank] == 1)
				PlayerInfo[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 2)
				PlayerInfo[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 3)
				PlayerInfo[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 4)
				PlayerInfo[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
				
			return (true);
		}
		case DIALOG_IJOBS: {
			if(!response) return (true);
			switch(listitem) {
				case 0: {
					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 3+ mogu biti lopovi.");
					PlayerInfo[ playerid ][ pJob ] 			= 9;
					if(PlayerInfo[playerid][pDonateRank] == 0)
						PlayerInfo[playerid][pFreeWorks] = NORMAL_FREE_WORKS;	
					else if(PlayerInfo[playerid][pDonateRank] == 1)
						PlayerInfo[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 2)
						PlayerInfo[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 3)
						PlayerInfo[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 4)
						PlayerInfo[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
					SendClientMessage( playerid, COLOR_RED, "[ ! ] Zaposlili ste se kao lopov!");
				}
			}
		}
	}
	return 1;
}

/*
	- Commands
*/

CMD:takejob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Imate posao, koristite /quitjob!");
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
	if(PlayerInfo[playerid][pJob] == 0) return SendClientMessage( playerid, COLOR_RED, "Nemate posao!");
	if(PlayerInfo[playerid][pFreeWorks] < 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte PayDay i NE radite ture da mozete dati otkaz na svome poslu!");
	switch( PlayerInfo[playerid][pDonateRank]) {
		case 0: {
			if(PlayerInfo[playerid][pContractTime] >= 5) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 5 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 5 - PlayerInfo[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 1: {
			if(PlayerInfo[playerid][pContractTime] >= 2) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 2 sata ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 2 - PlayerInfo[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 2: {
			if(PlayerInfo[playerid][pContractTime] >= 1)
			{
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 1 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
				PlayerInfo[playerid][pContractTime] = 0;
			} else {
				new chours = 2 - PlayerInfo[playerid][pContractTime];
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
