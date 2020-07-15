#include <YSI\y_hooks>

#define MAX_REPORTS (100)

enum E_REPORT_DATA
{
	bool:reportExists,
	reportBy[MAX_PLAYER_NAME],
	reportReason[128],
	reportTime
}
new ReportData[MAX_REPORTS][E_REPORT_DATA];

new PlayerReport[MAX_PLAYERS][128];

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_CONFIRM_SYS:{
            ConfirmDialog_Response(playerid, response);
        }
		case DIALOG_REPORTS:
        {
            if(response)
            {
                new
                    primary_str[300],
                    sub_str[128];

                format(sub_str, sizeof(sub_str), "Report ID: %i\n", listitem + 1);
                strcat(primary_str, sub_str);

                format(sub_str, sizeof(sub_str), "Reporter: %s\n", ReportData[listitem + 1][reportBy]);
                strcat(primary_str, sub_str);

                format(sub_str, sizeof(sub_str), "Detalji: %s\n", ReportData[listitem + 1][reportReason]);
                strcat(primary_str, sub_str);

                format(sub_str, sizeof(sub_str), "Cekanje: %d sekundi\n\n",  gettime() - ReportData[listitem + 1][reportTime]);
                strcat(primary_str, sub_str);

                strcat(primary_str, "{5CD2FE}Preuzmite, ili proslijedite ovaj report.");

                ConfirmDialog(playerid, "{5CD2FE}Preuzmi Report", primary_str, "OnSelectReport", listitem + 1);
				return 1;
            }
            return 1;
        }
	}
	return 0;
}

hook OnPlayerDisconnect(playerid)
{
    if(playeReport[playerid] != -1)
	{
		ClearReport(playeReport[playerid]);
		playeReport[playerid] = -1;
	}
    return 1;
}

forward OnPlayerReport(playerid, response);
public OnPlayerReport(playerid, response)
{
	if(response)
	{
		new
			id = -1,
			str[128];

		for(new i = 1; i < sizeof(ReportData); i++) if(!ReportData[i][reportExists])
		{
			id = i;
			break;
		}

		if(id == -1)
			return SendClientMessage(playerid, COLOR_RED, "Na�alost dogodila se gre�ka. Poku�ajte kontaktirati admina putem /pma.");

		ReportData[id][reportExists] = true;
		GetPlayerName(playerid, ReportData[id][reportBy], 24);

		format(ReportData[id][reportReason], 128, "%s", PlayerReport[playerid]);
		ReportData[id][reportTime] = gettime();

  		if(strlen(PlayerReport[playerid]) > 67)
		{
			format(str, sizeof(str), "[REPORT: %d] %s(%d): %.75s", id, GetName(playerid, false), playerid, PlayerReport[playerid]);
			SendAdminMessage(COLOR_SKYBLUE, str);

			format(str, sizeof(str), "[REPORT: %d] %s(%d): ...%s", id, GetName(playerid, false), playerid, PlayerReport[playerid][75]);
			SendAdminMessage(COLOR_SKYBLUE, str);
		}
		else
		{
			format(str, sizeof(str), "[REPORT: %d] %s(%d): %s", id, GetName(playerid, false), playerid, PlayerReport[playerid]);
			SendAdminMessage(COLOR_SKYBLUE, str);
		}

		if(strfind(PlayerReport[playerid], "hack", true) != -1 || strfind(PlayerReport[playerid], "cheat", true) != -1 || strfind(PlayerReport[playerid], "hax", true) != -1 || strfind(PlayerReport[playerid], "cheater", true) != -1  || strfind(PlayerReport[playerid], "citer", true) != -1)
		{

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pAdmin]) GameTextForPlayer(i, "~y~~h~PRIORITY REPORT", 4000, 1);
			}
		}
		//PlayerTick[playerid][ptReport] = gettimestamp() + 120;
        playeReport[playerid] = id;
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Vas upit je poslan svim administratorima.");
	}
	return 1;
}
forward OnSelectReport(playerid, response, id);
public OnSelectReport(playerid, response, id)
{
	new str[18];

	if(response)
	{
		format(str, sizeof(str), "/acceptreport %d", id);
        Command_ReProcess(playerid, str, 0);
	}
	return 1;
}


// CONFIRM DIALOG by mmartin // NE DIRAJ SJEBAT CES SVE
stock ConfirmDialog(playerid, caption[], info[], callback[], ...){
	new n = numargs(), 		// number of arguments, static + optional
		szParamHash[64];	// variable where the passed arguments will be stored
	for(new arg = 4; arg < n; arg++){	// loop all additional arguments
		format(szParamHash, sizeof(szParamHash), "%s%d|", szParamHash, getarg(arg)); // store them in szParamHash
	}
	SetPVarInt(playerid, "confDialogArgs", n -4);			// store the amount of additional arguments
	SetPVarString(playerid, "confDialCallback", callback);	// store the callback that needs to be called after response
	SetPVarString(playerid, "confDialog_arg", szParamHash);	// store the additional arguments

	ShowPlayerDialog(playerid, DIALOG_CONFIRM_SYS, DIALOG_STYLE_MSGBOX, caption, info, "Da", "Ne"); // display the dialog message itself

	return;
}

stock ConfirmDialog_Response(playerid, response){
	new szCallback[33],		// variable to fetch our callback to
		szParamHash[64], 	// variable to check raw compressed argument string
		n,					// variable to fetch the amount of additional arguments
		szForm[12];			// variable to generate the CallLocalFunction() "format" argument

	n = GetPVarInt(playerid, "confDialogArgs");	// Fetch the amount of additional arguments
	GetPVarString(playerid, "confDialCallback", szCallback, sizeof(szCallback));	// fetch the callback
	GetPVarString(playerid, "confDialog_arg", szParamHash, sizeof(szParamHash));	// fetch the raw compressed additional arguments

	new hashDecoded[12];	// variable to store extracted additional arguments from the ConfirmDialog() generated string

	sscanf(szParamHash, "p<|>A<d>(0)[12]", hashDecoded);	// extraction of the additional arguments

	new args, 	// amount of cells passed to CallLocalFunction
		addr, 	// pointer address variable for later use
		i;		// i

	format(szForm, sizeof(szForm), "dd");	// static parameters for the callback, "playerid" and "response"

	#emit ADDR.pri hashDecoded	// get pointer address of the extracted additional arguments
	#emit STOR.S.pri addr		// store the pointer address in variable 'addr'
	if(n){	// if there's any additional arguments
		for(i = addr + ((n-1) * 4); i >= addr; i-=4){ // loops all additional arguments by their addresses
			format(szForm, sizeof(szForm), "%sd", szForm); // adds an aditional specifier to the "format" parameter of CallLocalFunction
			#emit load.s.pri i	// load the argument at the current address
			#emit push.pri		// push it to the CallLocalFunction argument list
			args+=4;			// increase used cell number by 4
		}
	}


	args+=16;	// preserve 4 more arguments for CallLocalFunction (16 cause 4 args by 4 cells (4*4))

	#emit ADDR.pri response				// fetch "response" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list

	#emit ADDR.pri playerid				// fetch "playerid" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list

	#emit push.adr szForm				// push the szForm ("format") to the argument list by its referenced address
	#emit push.adr szCallback			// push the szCallback (custom callback) to the argument list by its referenced address
	#emit push.s args					// push the amount of arguments
	#emit sysreq.c CallLocalFunction	// call the function

	// Clear used data
	#emit LCTRL 4
	#emit LOAD.S.ALT args
	#emit ADD.C 4
	#emit ADD
	#emit SCTRL 4

	// Clear used PVars
	DeletePVar(playerid, "confDialCallback");
	DeletePVar(playerid, "confDialog_arg");
	DeletePVar(playerid, "confDialogArgs");

	return;
}
//NE DIRAJ

ClearReport(id)
{
	new
		pid = -1;
		
	sscanf(ReportData[id][reportBy], "u", pid);

	if(pid != INVALID_PLAYER_ID || IsPlayerConnected(pid))
	{
		if(pid != -1)
			playeReport[pid] = -1;
	}
	ReportData[id][reportExists] = false;
	ReportData[id][reportBy] = EOS;

	ReportData[id][reportTime] = 0;
	format(ReportData[id][reportReason], 128, " ");
	return 1;
}

stock SecondsToMinute(seconds)
{
	new
		minutes = 0;

	if(seconds >= 60)
	{
		minutes++;
		seconds-= 60;
	}

	return minutes;
}

CMD:report(playerid, params[])
{
    if(Bit1_Get(gr_Blockedreport, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes slati reporte.");
	if(playeReport[playerid] != -1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec si poslao report! Pricekaj da ti admini odgovore na isti.");

	new	string[678];
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /report [tekst]");
	format(PlayerReport[playerid], 128, "%s", params);

	format(string, sizeof(string), "{5CD2FE}WARNING:\nPoruka koju saljete ce biti prikazana svi online adminima.\n\nRazlog: %s\n\nUkoliko vam je neko nanio stetu predlazemo da prijavite na forumu.\nUkoliko admin nije prisustvovao situaciji on ne mo�e ni�ta uraditi bez valjanih dokaza.\nUkoliko vam je potreban teleport, unfreeze, slap, ili nesto slicno morate navesti valjan razlog.\nGeneralno bi trebali slati reporte u kojima je navedeno sto vise detalja kako bi vam admin mogao sto prije pomoci\n\nforum.cityofangels-roleplay.com", params);
	ConfirmDialog(playerid, "{5CD2FE}REPORT WARNING", string, "OnPlayerReport", params);
	return true;
}

CMD:reports(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni");

    SendMessage(playerid, MESSAGE_TYPE_INFO, "Ukoliko vam se nije prikazao dialog onda nema aktivnih reporta!");
	new
		primary_str[900], sub_str[128];

	for(new i = 1; i < sizeof ReportData; i++) if(ReportData[i][reportExists])
	{
		format(sub_str, sizeof(sub_str), "{5CD2FE}Report ID: %i | %s: %.20s...\n", i, ReportData[i][reportBy], ReportData[i][reportReason]);
		strcat(primary_str, sub_str);
	}

	ShowPlayerDialog(playerid, DIALOG_REPORTS, DIALOG_STYLE_LIST, "{5CD2FE}ACTIVE REPORTS:", primary_str, "Odaberi", "<<");
	return 1;
}


CMD:reportsx(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni");

	SendClientMessage(playerid, COLOR_SKYBLUE, "____________________REPORTS{5CD2FE}____________________");

	for(new i = 1; i < sizeof ReportData; i++) if(ReportData[i][reportExists])
	{
		if(strlen(ReportData[i][reportReason]) > 70)
		{
			va_SendClientMessage(playerid, COLOR_SKYBLUE, "[ ! ] %s | {FA5656}Report ID: %i | Na cekanju: %i Minuta | Report: %.70s", ReportData[i][reportBy], i, SecondsToMinute(gettime() - ReportData[i][reportTime]), ReportData[i][reportReason]);
			va_SendClientMessage(playerid, COLOR_SKYBLUE, "[ ! ] ...%s", ReportData[i][reportReason][70]);
		}
		else va_SendClientMessage(playerid, COLOR_SKYBLUE, "[ ! ] %s | {FA5656}Report ID: %i | Na cekanju: %i Minuta | Report: %s", ReportData[i][reportBy], i, SecondsToMinute(gettime() - ReportData[i][reportTime]), ReportData[i][reportReason]);
	}

	return 1;
}

CMD:acceptreport(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");

	new
		reportid, str[128];

	if(sscanf(params, "d", reportid))return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /acceptreport [report id]");
	if(reportid > MAX_REPORTS || !ReportData[reportid][reportExists]) return SendClientMessage(playerid, COLOR_RED, "Report pod navedenim ID-om ne postoji!");

	format(str, sizeof(str), "[REPORT] %s je preuzeo report ID %d od %s", GetName(playerid, false), reportid, ReportData[reportid][reportBy]);
 	SendAdminNotification(MESSAGE_TYPE_INFO, str);

	ClearReport(reportid);
	return 1;
}
