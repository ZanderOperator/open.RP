/* 
*	  	  Business - Workers
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI_Coding\y_hooks>

/*
	- Defines & Enums
*/

#define MAX_WORKERS (5)
#define DEFUALT_WORK_TIME (5)

/*
	- Vars
*/

new Iterator: BIZ_WORKERS[MAX_BIZZS] <MAX_WORKERS>,
	_WorkerID[MAX_PLAYERS] = {0,...},
	_WorkerSalary[MAX_PLAYERS] = {0,...},
	_WorkerWorkTime[MAX_PLAYERS] = {0, ...},
	_WorkerOwner[MAX_PLAYERS] = {0, ...},
	_WorkerSlot[MAX_PLAYERS] = {0, ...},
	_WorkerRole[MAX_PLAYERS][32];

/*
	- mySQL
*/
Public:StoreWorkerInDB(playerid, biznis, slot) {
	BizzInfo[biznis][b_WorkerSQL][slot] = cache_insert_id();
	SaveBiznisWorkers(biznis, BizzInfo[biznis][b_WorkerSQL][slot], slot);
	return (true);
}

stock SaveBiznisWorkers(biznis, workerSQL, slot) {
	new query[ 1024 ];
	if(slot == 1) {
		format(query, sizeof(query), "UPDATE server_biznis_workers SET Worker = '%s', Role = '%s', Salary = '%d', Earned = '%d', Time = '%d'  WHERE ID = '%d'",
			BizzInfo[biznis][b_Worker1],
			BizzInfo[biznis][b_Wrole1],
			BizzInfo[biznis][b_Wsalary][0], 
			BizzInfo[biznis][b_Wearned][0], 
			BizzInfo[biznis][b_WTime][0], 
			workerSQL
		);
	}
	else if(slot == 2) {
		format(query, sizeof(query), "UPDATE server_biznis_workers SET Worker = '%s', Role = '%s', Salary = '%d', Earned = '%d', Time = '%d'  WHERE ID = '%d'",
			BizzInfo[biznis][b_Worker2],
			BizzInfo[biznis][b_Wrole2],
			BizzInfo[biznis][b_Wsalary][1], 
			BizzInfo[biznis][b_Wearned][1], 
			BizzInfo[biznis][b_WTime][1], 
			workerSQL
		);
	}
	else if(slot == 3) {
		format(query, sizeof(query), "UPDATE server_biznis_workers SET Worker = '%s', Role = '%s', Salary = '%d', Earned = '%d', Time = '%d'  WHERE ID = '%d'",
			BizzInfo[biznis][b_Worker3],
			BizzInfo[biznis][b_Wrole3],
			BizzInfo[biznis][b_Wsalary][2], 
			BizzInfo[biznis][b_Wearned][2], 
			BizzInfo[biznis][b_WTime][2], 
			workerSQL
		);
	}
	else if(slot == 4) {
		format(query, sizeof(query), "UPDATE server_biznis_workers SET Worker = '%s', Role = '%s', Salary = '%d', Earned = '%d', Time = '%d'  WHERE ID = '%d'",
			BizzInfo[biznis][b_Worker4],
			BizzInfo[biznis][b_Wrole4],
			BizzInfo[biznis][b_Wsalary][3], 
			BizzInfo[biznis][b_Wearned][3], 
			BizzInfo[biznis][b_WTime][3], 
			workerSQL
		);
	}
	else if(slot == 5) {
		format(query, sizeof(query), "UPDATE server_biznis_workers SET Worker = '%s', Role = '%s', Salary = '%d', Earned = '%d', Time = '%d'  WHERE ID = '%d'",
			BizzInfo[biznis][b_Worker5],
			BizzInfo[biznis][b_Wrole5],
			BizzInfo[biznis][b_Wsalary][4], 
			BizzInfo[biznis][b_Wearned][4], 
			BizzInfo[biznis][b_WTime][4], 
			workerSQL
		);
	}
	return mysql_tquery(g_SQL, query, "", "");
}

/*
	- Functions
*/

stock GetWorkerByID(worker_name[]) {
	foreach(new i : Player) {
		if(strcmp(GetName(i), worker_name, false, strlen(worker_name)) == 0)
			return i;
	}
  	return INVALID_PLAYER_ID;
}

stock WorkerSlot(playerid, biznis) {
	if (!strcmp(BizzInfo[biznis][b_Worker1], GetName(playerid), true)) 
		_WorkerSlot[playerid] = 0;
	else if (!strcmp(BizzInfo[biznis][b_Worker2], GetName(playerid), true)) 
		_WorkerSlot[playerid] = 1;
	else if (!strcmp(BizzInfo[biznis][b_Worker3], GetName(playerid), true)) 
		_WorkerSlot[playerid] = 2;
	else if (!strcmp(BizzInfo[biznis][b_Worker4], GetName(playerid), true))
		_WorkerSlot[playerid] = 3;
	else if (!strcmp(BizzInfo[biznis][b_Worker5], GetName(playerid), true)) 
		_WorkerSlot[playerid] = 4;
	return _WorkerSlot[playerid];
}

stock WorkerCheck(biznis) {
	new buffer[700];
			
	format(buffer, sizeof(buffer), "{3C95C2}Worker\t{3C95C2}Role\t{3C95C2}Salary\t{3C95C2}Work Time\n%s\t%s\t%s\t%dh\n%s\t%s\t%s\t%dh\n%s\t%s\t%s\t%dh\n%s\t%s\t%s\t%dh\n%s\t%s\t%s\t%dh", 
		BizzInfo[biznis][b_Worker1], BizzInfo[biznis][b_Wrole1], FormatNumber(BizzInfo[biznis][b_Wsalary][0]), BizzInfo[biznis][b_WTime][0],
		BizzInfo[biznis][b_Worker2], BizzInfo[biznis][b_Wrole2], FormatNumber(BizzInfo[biznis][b_Wsalary][1]), BizzInfo[biznis][b_WTime][1],
		BizzInfo[biznis][b_Worker3], BizzInfo[biznis][b_Wrole3], FormatNumber(BizzInfo[biznis][b_Wsalary][2]), BizzInfo[biznis][b_WTime][2],
		BizzInfo[biznis][b_Worker4], BizzInfo[biznis][b_Wrole4], FormatNumber(BizzInfo[biznis][b_Wsalary][3]), BizzInfo[biznis][b_WTime][3],
		BizzInfo[biznis][b_Worker5], BizzInfo[biznis][b_Wrole5], FormatNumber(BizzInfo[biznis][b_Wsalary][4]), BizzInfo[biznis][b_WTime][4]
	);
	return (buffer);
}

stock WorkerList(biznis) {
	new buffer[700];
			
	format(buffer, sizeof(buffer), "{3C95C2}Worker\t{3C95C2}Role\t{3C95C2}Earned\n%s\t%s\t%s\n%s\t%s\t%s\n%s\t%s\t%s\n%s\t%s\t%s\n%s\t%s\t%s", 
		BizzInfo[biznis][b_Worker1], BizzInfo[biznis][b_Wrole1], FormatNumber(BizzInfo[biznis][b_Wearned][0]),
		BizzInfo[biznis][b_Worker2], BizzInfo[biznis][b_Wrole2], FormatNumber(BizzInfo[biznis][b_Wearned][1]),
		BizzInfo[biznis][b_Worker3], BizzInfo[biznis][b_Wrole3], FormatNumber(BizzInfo[biznis][b_Wearned][2]),
		BizzInfo[biznis][b_Worker4], BizzInfo[biznis][b_Wrole4], FormatNumber(BizzInfo[biznis][b_Wearned][3]),
		BizzInfo[biznis][b_Worker5], BizzInfo[biznis][b_Wrole5], FormatNumber(BizzInfo[biznis][b_Wearned][4])
	);
	return (buffer);
}

stock WorkerQuit(playerid, biznis, slot) {
	new query[164];
	format(query, sizeof(query), "DELETE FROM server_biznis_workers WHERE ID = '%d'", BizzInfo[biznis][b_WorkerSQL][slot]);
	mysql_tquery(g_SQL, query, "", "");
	
	format(query, sizeof(query), "UPDATE accounts SET pBusinessJob = '-1', pBusinessWorkTime = '0' WHERE sqlid = '%d'",
		PlayerInfo[playerid][pSQLID]);
	mysql_pquery(g_SQL, query);
	
	PlayerInfo[playerid][pBusinessJob] = (-1);
	BizzInfo[biznis][b_Wsalary][slot] = (0);
	BizzInfo[biznis][b_WTime][slot] = (0);
	
	Iter_Remove(BIZ_WORKERS[biznis], slot);
	return (true);
}

stock WorkerRemove(playerid, slot, worker, biznis) {	
	
	if (!strcmp(BizzInfo[biznis][b_Worker1], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Worker1], "None");
		SetString(BizzInfo[biznis][b_Wrole1], "None");
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker2], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Worker2], "None");
		SetString(BizzInfo[biznis][b_Wrole2], "None");
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker3], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Worker3], "None");
		SetString(BizzInfo[biznis][b_Wrole3], "None");
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker4], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Worker4], "None");
		SetString(BizzInfo[biznis][b_Wrole4], "None");
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker5], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Worker5], "None");
		SetString(BizzInfo[biznis][b_Wrole5], "None");
	}
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali otkaz %s u vasoj firmi.", GetName(worker));
	SendFormatMessage(worker, MESSAGE_TYPE_SUCCESS, "%s vam je dao otkaz u %s.", GetName(playerid), BizzInfo[biznis][bMessage]);
	
	PlayerInfo[worker][pBusinessJob] = (-1);
	PlayerInfo[worker][pBusinessWorkTime] = (0);
	BizzInfo[biznis][b_Wsalary][slot] = (0);
	BizzInfo[biznis][b_WTime][slot] = (0);
	BizzInfo[biznis][b_Wearned][slot] = (0);
	
	// mysql
	new query[64];
	format(query, sizeof(query), "DELETE FROM server_biznis_workers WHERE ID = '%d'", BizzInfo[biznis][b_WorkerSQL][slot]);
	mysql_tquery(g_SQL, query, "", "");
	
	format(query, sizeof(query), "UPDATE accounts SET pBusinessJob = '%d', pBusinessWorkTime = '%d' WHERE sqlid = '%d'",
		PlayerInfo[worker][pBusinessJob],
		PlayerInfo[worker][pBusinessWorkTime],
		PlayerInfo[worker][pSQLID]
	);
	mysql_pquery(g_SQL, query);
	
	Iter_Remove(BIZ_WORKERS[biznis], slot);
	return (true);
}

stock WorkerSalary(playerid, workerid, biznis, slot, salary) {

	BizzInfo[biznis][b_Wsalary][slot] = (salary);
	SaveBiznisWorkers(biznis, BizzInfo[biznis][b_WorkerSQL][slot], slot);
	
	// message.
	SendFormatMessage(workerid, MESSAGE_TYPE_SUCCESS, "%s vam je promjenio primanja/placu, nova plata: %s.", GetName(playerid), FormatNumber(salary));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili primanja/placu osobi %s, nova plata: %s.", GetName(workerid), FormatNumber(salary));
	return (true);
} 

stock WorkerRole(playerid, worker, biznis, role[]) {	
	new slot = -1;
	if (!strcmp(BizzInfo[biznis][b_Worker1], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Wrole1], role), slot = 0;
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker2], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Wrole2], role), slot = 1;
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker3], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Wrole3], role), slot = 2;
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker4], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Wrole4], role), slot = 3;
	}
	else if (!strcmp(BizzInfo[biznis][b_Worker5], GetName(worker), true)) { 
		SetString(BizzInfo[biznis][b_Wrole5], role), slot = 4;
	}
	SaveBiznisWorkers(biznis, BizzInfo[biznis][b_WorkerSQL][slot], slot);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili role/ulogu osobi %s u vasoj firmi u %s.", GetName(worker), role);
	SendFormatMessage(worker, MESSAGE_TYPE_SUCCESS, "%s vam je promjenio role/ulogu u firmi %s u %s.", GetName(playerid), BizzInfo[biznis][bMessage], role);
	return (true);
}

stock WorkerAdd(playerid, workerid, biznis, salary, role[], work_time, slot) {
	Iter_Add(BIZ_WORKERS[biznis], slot);
	new query[524];
	
	// worker
	BizzInfo[biznis][b_WTime][slot] = (work_time);
	BizzInfo[biznis][b_Wsalary][slot] = (salary);
	BizzInfo[biznis][b_Wearned][slot] = (0);
	PlayerInfo[workerid][pBusinessJob] = (biznis);
	PlayerInfo[workerid][pBusinessWorkTime] = (work_time);
	
	if (strcmp(BizzInfo[biznis][b_Worker1], "None", true) == 0) {
		SetString(BizzInfo[biznis][b_Worker1],GetName(workerid));
		SetString(BizzInfo[biznis][b_Wrole1],role);
	}
	else if (strcmp(BizzInfo[biznis][b_Worker2], "None", true) == 0) {
		SetString(BizzInfo[biznis][b_Worker2],GetName(workerid));
		SetString(BizzInfo[biznis][b_Wrole2],role);
	}
	else if (strcmp(BizzInfo[biznis][b_Worker3], "None", true) == 0) {
		SetString(BizzInfo[biznis][b_Worker3],GetName(workerid));
		SetString(BizzInfo[biznis][b_Wrole3],role);
	}
	else if (strcmp(BizzInfo[biznis][b_Worker4], "None", true) == 0) {
		SetString(BizzInfo[biznis][b_Worker4],GetName(workerid));
		SetString(BizzInfo[biznis][b_Wrole4],role);
	}
	else if (strcmp(BizzInfo[biznis][b_Worker5], "None", true) == 0) {
		SetString(BizzInfo[biznis][b_Worker5],GetName(workerid));
		SetString(BizzInfo[biznis][b_Wrole5],role);
	}
	format(query, sizeof(query), "INSERT INTO server_biznis_workers (biznis_id, Worker, Role, Salary, Time, Earned) VALUES ('%d', '%s', '%s', '%d', '%d', '0')",
		BizzInfo[biznis][bSQLID],
		GetName(workerid),
		role,
		salary,
		work_time
	);
	mysql_tquery(g_SQL, query, "StoreWorkerInDB", "iii", playerid, biznis, slot);	
	
	format(query, sizeof(query), "UPDATE accounts SET pBusinessJob = '%d', pBusinessWorkTime = '%d' WHERE sqlid = '%d'",
		PlayerInfo[workerid][pBusinessJob],
		PlayerInfo[workerid][pBusinessWorkTime],
		PlayerInfo[workerid][pSQLID]
	);
	mysql_pquery(g_SQL, query);
	
	// message.
	SendFormatMessage(workerid, MESSAGE_TYPE_SUCCESS, "%s vas je zaposlio kao %s u svom biznisu, plata: %s.", GetName(playerid), role, FormatNumber(salary));
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zaposlili %s kao %s, plata: %s.", GetName(workerid), role, FormatNumber(salary));
	return (true);
}

stock WorkerPay(playerid, biznis, worker_name[], slot) {
	if((BizzInfo[biznis][bTill] - _WorkerSalary[playerid]) <= 0)
	{
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis nema dovoljno novca u blagajni da isplatite %d$ za placu!", _WorkerSalary[playerid]);
	}
	new workerid = GetWorkerByID(worker_name);
	
	//message.
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste platili radnika %s, iznos: %s.", GetName(workerid), FormatNumber(_WorkerSalary[playerid]));
	SendFormatMessage(workerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dobili placu od vaseg poslodavca u firmi %s, iznos: %s.", BizzInfo[biznis][bMessage], FormatNumber(_WorkerSalary[playerid]));
	
	BizzInfo[biznis][b_Wearned][slot] = (0);
	//BusinessToPlayerMoney(workerid, biznis, _WorkerSalary[playerid]);
	//SaveBiznisWorkers(biznis, BizzInfo[biznis][b_WorkerSQL][slot], slot);
	
	// Log pay
	new string[102];
	format(string, sizeof(string), "%s(%s) je isplatio %d$ svome radniku %s", 
		GetName(playerid),
		BizzInfo[biznis][bMessage],
		_WorkerSalary[playerid],
		GetName(workerid)
	);
	LogWorkerPay(string);
	return (true);
}

stock ResetWorkerSettings(playerid) {
	_WorkerOwner[playerid] = INVALID_PLAYER_ID;
	_WorkerID[playerid] = INVALID_PLAYER_ID;
	_WorkerSalary[playerid] = 0;
	_WorkerWorkTime[playerid] = 0;
	SetString(_WorkerRole[playerid], "None");
	return (true);
}

/*
	- Hooks
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_WORKER_WORKTIME: {
			if(!response)
				ResetWorkerSettings(playerid);
			if(response) {
				new buffer[260+MAX_PLAYER_NAME];
				_WorkerWorkTime[playerid] = strval(inputtext);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ponudili posao osobi %s, work time: %d - salary: %s.", 
					GetName(_WorkerID[playerid]),
					strval(inputtext),
					FormatNumber(_WorkerSalary[playerid])
				);
				
				format(buffer, sizeof(buffer), "\n%s vam je ponudio posao u %s kao %s.\nWork Time: %dh.\nSatnica: %s.\n\n{3C95C2}[!] - Ukoliko zelite prihvatiti posao, stisnite (prihvati), u suprotnom stisnite na (x).",
					GetName(playerid),
					BizzInfo[ PlayerInfo[playerid][pBizzKey] ][bMessage],
					_WorkerRole[playerid],
					_WorkerWorkTime[playerid],
					FormatNumber(_WorkerSalary[playerid])
				);
				ShowPlayerDialog(_WorkerID[playerid], DIALOG_WORK_JOBOFFER, DIALOG_STYLE_MSGBOX, "{3C95C2}* Job Offer", buffer, "(potvrdi)", "Close");	
				
				_WorkerOwner[_WorkerID[playerid]] = playerid;
			}
		}
		case DIALOG_WORK_JOBOFFER: {
			if(!response)
				ResetWorkerSettings(playerid), ResetWorkerSettings(_WorkerOwner[playerid]);
			if(response) {
				new sef = _WorkerOwner[playerid],
					biznis = PlayerInfo[sef][pBizzKey],
					slot = Iter_Free(BIZ_WORKERS[biznis]);
				WorkerAdd(sef, playerid, biznis, _WorkerSalary[sef], _WorkerRole[sef], _WorkerWorkTime[sef], slot);
			}
		}
		case DIALOG_WORKER_PAY: {
			if(!response) return true;
			if(response) {
				new worker_name[32],
					biznis = PlayerInfo[playerid][pBizzKey];
				if(listitem == 0)
					SetString(worker_name, BizzInfo[biznis][b_Worker1]);
				if(listitem == 1)
					SetString(worker_name, BizzInfo[biznis][b_Worker2]);	
				if(listitem == 2)
					SetString(worker_name, BizzInfo[biznis][b_Worker3]);
				if(listitem == 3)
					SetString(worker_name, BizzInfo[biznis][b_Worker4]);
				if(listitem == 4)
					SetString(worker_name, BizzInfo[biznis][b_Worker5]);	
				
				if(GetWorkerByID(worker_name) == INVALID_PLAYER_ID)
                   return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba nije na serveru.");
				   
				if( BizzInfo[biznis][bTill] < BizzInfo[biznis][b_Wearned][listitem] ) 
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca u firmi da isplatite placu (%s).", FormatNumber(BizzInfo[biznis][b_Wearned][listitem])); 
				WorkerPay(playerid, biznis, worker_name, listitem);
				_WorkerSalary[playerid] = BizzInfo[biznis][b_Wearned][listitem];
			}
		}
	}
	return (true);
}

/*
	- Commands
*/

CMD:workers(playerid, params[]) {		
	/*
	new action[18],
		biznis = PlayerInfo[playerid][pBizzKey];
		
	if (sscanf(params, "s[18] ", action)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /workers [opcija].");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] add, remove, check, salary, role, pay");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] stats, quit");
		return (true);
    }
	
	if(strcmp(action,"add",true) == 0) {
		new workerid, uloga[32], salary;
		if(sscanf( params, "s[18]iis[32]", action, workerid, salary, uloga)) 
			return SendClientMessage(playerid, -1, "[KORISTI]: /workers add [workerid] [salary] [uloga].");
			
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		
		if(PlayerInfo[workerid][pBizzKey] != INVALID_BIZNIS_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba je vec poslodavac u nekoj firmi.");
			
		if(PlayerInfo[workerid][pJob] != 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba je vec poslodavac u nekoj firmi.");	
			
		if(PlayerInfo[workerid][pBusinessJob] != -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba je vec poslodavac u nekoj firmi.");		
			
		if(PlayerInfo[workerid][pLevel] == 1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba je level 1.");
			
		ShowPlayerDialog(playerid, DIALOG_WORKER_WORKTIME, DIALOG_STYLE_INPUT, "{3C95C2}* Workers - Time", "\nSada morate ispod unesti na koliko sati zelite zaposliti radnika.\n\
			{3C95C2}[!] - Sati se odbrojavaju kada je igrac aktivan, i svaki njegov payday sati se spustaju.\n", "(confirm)", "Close"
		);	
		_WorkerID[playerid] = (workerid);
		_WorkerSalary[playerid] = (salary);
		SetString(_WorkerRole[playerid], (uloga));	
	}
	
	if(strcmp(action,"salary",true) == 0) {
		new workerid, slot, salary;
		if(sscanf( params, "s[18]iii", action, workerid, slot, salary)) 
			return SendClientMessage(playerid, -1, "[KORISTI]: /workers salary [workerid] [slot] [salary].");
				
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
			
		WorkerSalary(playerid, workerid, biznis, slot, salary);
	}
	
	if(strcmp(action,"role",true) == 0) {
		new workerid, role[32];
		if(sscanf( params, "s[18]is[32]", action, workerid, role)) 
			return SendClientMessage(playerid, -1, "[KORISTI]: /workers role [workerid] [nova_uloga].");
		
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
		
		if( PlayerInfo[workerid][pBusinessJob] != biznis)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ta osoba nije zaposlenik u vasem biznisu!");
			
		WorkerRole(playerid, workerid, biznis, role);
	}
	
	if(strcmp(action,"remove",true) == 0) {
		new worker, slot;
		if(sscanf( params, "s[18]ii", action, slot, worker)) 
			return SendClientMessage(playerid, -1, "[KORISTI]: /workers remove [slot] [workerid].");
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
			
		WorkerRemove(playerid, slot, worker, biznis);
	}
	
	if(strcmp(action,"check",true) == 0) {	
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
			
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Biznis - Workers", WorkerCheck(biznis), "Close", "");
	}
	
	if(strcmp(action,"pay",true) == 0) {	
		if( biznis == INVALID_BIZNIS_ID ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete biznis!");	
			
		ShowPlayerDialog(playerid, DIALOG_WORKER_PAY, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Biznis - Pay", WorkerList(biznis), "(pay)", "Close");
	}
	
	if(strcmp(action,"stats",true) == 0) {
		if(PlayerInfo[playerid][pBusinessJob] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
			
		new buffer[164], bizid = PlayerInfo[playerid][pBusinessJob],
			slot = WorkerSlot(playerid, bizid);
			
		format(buffer, sizeof(buffer), "\n{3C95C2}[ Statistika vaseg rada u %s ]\n\nIme radnik: %s.\nSatnica: %s.\nZarada: %s.\nDo isteka ugovora: %d.", 
			BizzInfo[bizid][bMessage], 
			GetName(playerid),
			FormatNumber(BizzInfo[bizid][b_Wsalary][slot]), 
			FormatNumber(BizzInfo[bizid][b_Wearned][slot]), 
			BizzInfo[bizid][b_WTime][slot]
		);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}* Job - Stats", buffer, "Close", "");
	}
	
	if(strcmp(action,"quit",true) == 0) {	
		if(PlayerInfo[playerid][pBusinessJob] == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni u nekoj firmi.");	
			
		new bizid = PlayerInfo[playerid][pBusinessJob],
			slot = WorkerSlot(playerid, bizid);
			
		if(PlayerInfo[playerid][pBusinessWorkTime] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispunili svoj ugovor do kraja.");	
			
		WorkerQuit(playerid, bizid, slot);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste dali otkaz u %s.", BizzInfo[bizid][bMessage]);
	}*/
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Izbaceno jer je neko retardiran");
	return (true); 
}
