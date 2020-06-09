#include <YSI\y_hooks>

new 
	bool:lockvotes = true;
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_FOR_ELECTIONS:
		{
			if(!response) return 1;
			ShowPlayerDialog(playerid, DIALOG_ELECTIONS_VOTE, DIALOG_STYLE_LIST, "Glasanje", "Za\nProtiv", "Zaokruzi", "Izadji");
			return 1;
		}
		case DIALOG_ELECTIONS_VOTE:
		{
			if(!response) return 1;
			switch(listitem) 
			{
				case 0:
				{
					new 
						Query[256],
						glasovi,
						string[72];
					
					format(Query, sizeof(Query), "SELECT `glasovi` FROM `elections` WHERE `opcija` = 'Za'");
					mysql_query(g_SQL, Query);
					
					cache_get_value_name_int(0, "glasovi", glasovi);
					glasovi++;
					PlayerInfo[playerid][pVoted] = 1;
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si dao svoj glas, trenutno je %d glasova ZA.", glasovi);
					format(string, sizeof(string), "%s ubacuje svoj listic u glasacku kutiju.", GetName(playerid, false));
					ProxDetector(25.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(Query, sizeof(Query), "UPDATE `elections` SET `glasovi` = '%d' WHERE `opcija` = 'Za'", glasovi);
					mysql_tquery(g_SQL, Query, "", "");
				}
				case 1:
					{
					new 
						Query[256], 
						temp[50],
						glasovi,
						string[72];
					format(Query, sizeof(Query), "SELECT `glasovi` FROM `elections` WHERE `opcija` = 'Protiv'");
					
					mysql_query(g_SQL, Query);
					cache_get_value_name(0,"glasovi", temp); 	glasovi 			= strval(temp);
					glasovi++;
					PlayerInfo[playerid][pVoted] = 1;
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si dao svoj glas, trenutno je %d glasova PROTIV.", glasovi);
					format(string, sizeof(string), "%s ubacuje svoj listic u glasacku kutiju.", GetName(playerid, false));
					ProxDetector(25.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					format(Query, sizeof(Query), "UPDATE `elections` SET `glasovi` = '%d' WHERE `opcija` = 'Protiv'", glasovi);
					mysql_tquery(g_SQL, Query, "", "");
					}
			}
			return 1;
		}
	}
	return 0;
}
CMD:vote(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3, 1299.5887, 764.5737, -98.6427)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazis se pored kutije za glasanje.(vijecnica)");
	if(PlayerInfo[playerid][pLevel] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 3+ da bi mogao koristiti ovu komandu");
	if(lockvotes == true) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Glasanje je trenutno zatvoreno.");
	if(PlayerInfo[playerid][pVoted] == 1) return SendClientMessage(playerid,COLOR_RED, "Vec si dao svoj glas");
	ShowPlayerDialog(playerid, DIALOG_FOR_ELECTIONS, DIALOG_STYLE_MSGBOX, "Glasanje", "Referendumom Los Santos vrsi zadnji korak prema ocjepljenju od\n drzave San Andreas, ukoliko podrzavate referendum zaokruzite 'Za'\n a ukoliko ste protiv ocjepljenja zaokruzite 'Protiv'.", "Ok", "Izadji");
	return 1;
}
CMD:votes(playerid, params[])
{
	new option[32];
	if(sscanf(params, "s[32]", option)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTENJE: /votes [lock, check]");
	if(strcmp(option,"lock",true) == 0)
	{
		if(PlayerInfo[playerid][pLeader] != 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo gradonacelnik moze koristiti ovu komunadu.");
		if(lockvotes == true)
		{
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si otkljucao glasanja.");
			lockvotes = false;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si zakljucao glasanja.");
			lockvotes = true;
		}
	}
	else if(strcmp(option,"check",true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 4) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
		new 
			Query[256], 
			temp[50],
			glasovi;
		//=======================================================ZA=======================================================	
		format(Query, sizeof(Query), "SELECT `glasovi` FROM `elections` WHERE `opcija` = 'Za'");
					
		mysql_query(g_SQL, Query);
		cache_get_value_name(0,"glasovi", temp); 	glasovi 			= strval(temp);
		SendClientMessage(playerid, COLOR_ORANGE, "*__________________________VOTE STATUS__________________________");
		va_SendClientMessage(playerid, COLOR_GREY, "Glasovi ZA: %d", glasovi);
		//=====================================================PROTIV=====================================================
					
		format(Query, sizeof(Query), "SELECT `glasovi` FROM `elections` WHERE `opcija` = 'Protiv'");
					
		mysql_query(g_SQL, Query);
		cache_get_value_name(0,"glasovi", temp); 	glasovi 			= strval(temp);
		SendClientMessage(playerid, COLOR_ORANGE, "*__________________________VOTE STATUS__________________________");
		va_SendClientMessage(playerid, COLOR_GREY, "Glasovi PROTIV: %d", glasovi);
					
	}
	return 1;
}
