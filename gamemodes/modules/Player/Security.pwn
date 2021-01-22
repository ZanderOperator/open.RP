#include <YSI_Coding\y_hooks>

#define MAX_SECURITY_QUESTIONS	(8)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	##   ##  #########  ##   ##         ## 
	 ## ##   ##     ##  ##    ##  ##    ## 
	  ###    ##     ##  ##     ##  ######  
*/

//Enums
enum
{
	MAIL_TYPE_CHANGEPASS = 0,
	MAIL_TYPE_CHANGENICK,
	MAIL_TYPE_CHANGEMAIL
};

//Defined variables
new	
	secQuestions[MAX_SECURITY_QUESTIONS][63] = {
		"U koju ste osnovnu skolu isli u sestome razredu (naziv skole)?",
		"Kako vam se zvala vasa prva plisana igracka?",
		"Kako se zove vas rodni grad?",
		"Kako se zvala vas(a) prvi/a ucitelj(ica)?",
		"Koji vam je bio nadimak u mladosti?",
		"Kako ste zvali svoju prvu curu?",
		"Koje je ime vaseg prvog ljubimca?",
		"Kako zovete svog najdrazeg clana familije od milja?"
};

stock const
	mailTexts[][350] = {		
		//Changepassword
		"Pozdrav %s, \n\
		Netko je promjenio sifru na vasem racunu s ove IP adrese: %s.\n\
		Novi password glasi %s\n\
		Ukoliko to niste vi odmah kontaktirajte administraciju da vam vrate vase podatke!\n\n\n\
		NAPOMENA: Na ovu poruku se ne odgovara jer je automatski poslana od strane sistema!",
		
		//Nick
		"Pozdrav %s, \n\
		Netko je promjenio ime na vasem racunu s ove IP adrese: %s.\n\
		Novo ime glasi %s\n\
		Ukoliko to niste vi odmah kontaktirajte administraciju da vam vrate vase podatke!\n\n\n\
		NAPOMENA: Na ovu poruku se ne odgovara jer je automatski poslana od strane sistema!",
		
		//Mail
		"Pozdrav %s, \n\
		Netko je promjenio e-mail na vasem racunu s ove IP adrese: %s.\n\
		Novi e-mail glasi %s\n\
		Ukoliko to niste vi odmah kontaktirajte administraciju da vam vrate vase podatke!\n\n\n\
		NAPOMENA: Na ovu poruku se ne odgovara jer je automatski poslana od strane sistema!"
};

//rBits
static 
	Bit2: gr_QuestionType	<MAX_PLAYERS>;

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######    & funcs
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

Public: OnPasswordUpdateEx(sqlid)
{
	new password[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(password);
	
	mysql_fquery(g_SQL, "UPDATE accounts SET password = '%e' WHERE sqlid = '%d'",
		password,
		sqlid
	);
	return 1;
}

Public: OnPasswordUpdate(playerid)
{
	new password[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(password);
	
	strcpy(PlayerInfo[playerid][pPassword], password, BCRYPT_HASH_LENGTH);
	
	mysql_fquery(g_SQL, "UPDATE accounts SET password = '%e' WHERE sqlid = '%d'",
		password,
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock UpdateRegisteredPassword(playerid)
{
	bcrypt_hash(PlayerInfo[playerid][pPassword], BCRYPT_COST, "OnPasswordUpdate", "d", playerid);
	return 1;
}

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_SEC_MAIN: 
		{
			if(!response)
				return 1;

			switch(listitem)
			{
				case 0: 
				{ //E-Mail
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uneseno sigurnosno pitanje! Sigurnosno pitanje MORA biti uneseno ako zelite nesto mjenjati!");
					
					Bit2_Set(gr_QuestionType, playerid, 1);
					ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", secQuestions[PlayerInfo[playerid][pSecQuestion]], "Input", "Abort");
				}
				case 1: 
				{ //Password
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uneseno sigurnosno pitanje! Sigurnosno pitanje MORA biti uneseno ako zelite nesto mjenjati!");
					
					Bit2_Set(gr_QuestionType, playerid, 2);
					ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", secQuestions[PlayerInfo[playerid][pSecQuestion]], "Input", "Abort");
				}
				case 2: 
				{ //Sigurnosno Pitanje
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) 
					{
						new motd[68],
							tmpstring[504];
						for(new i = 0; i < MAX_SECURITY_QUESTIONS; i++)
						{
							if(i != (MAX_SECURITY_QUESTIONS - 1))
								format(motd, sizeof(motd), "%s\n", secQuestions[i]);
							else format(motd, sizeof(motd), "%s", secQuestions[i]);
							strcat(tmpstring, motd);
						}
						ShowPlayerDialog(playerid, DIALOG_SEC_SECQUEST, DIALOG_STYLE_LIST, "SIGURNOSNO PITANJE", tmpstring, "Choose", "Abort");
					}
				}
			}
			return 1;
		}
		case DIALOG_SEC_SECQUEST: 
		{
			if(!response) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1)
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			
			PlayerInfo[playerid][pSecQuestion] = listitem;
			new tmpString[165];
			format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\nNAPOMENA: Duzina odgovora MORA biti izmedju 3-30 znakova!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
			ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Input", "Abort");
			return 1;
		}
		case DIALOG_SEC_QUESTANSWER: 
		{
			if(!response) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			if(isnull(inputtext))
			{
				new 
					tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"Ostavili ste prazno polje na mjestu odgovora!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Input", "Abort");
				return 1;
			}
			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1)
			{
				new tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"Nedozvoljeni znakovi u sigurnosnom odgovoru!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Input", "Abort");
				return 1;
			}
			if(strlen(inputtext) < 3 || strlen(inputtext) > 30) 
			{
				new tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"NAPOMENA: Duzina odgovora MORA biti izmedju 3-30 znakova!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Input", "Abort");
				return 1;
			}
			if(isnull(inputtext)) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			
			strcpy(PlayerInfo[playerid][pSecQuestAnswer], inputtext, 31);
			
			mysql_fquery(g_SQL, "UPDATE accounts SET secquestion = '%d', secawnser = '%e' WHERE sqlid = '%d'",
				PlayerInfo[playerid][pSecQuestion],
				PlayerInfo[playerid][pSecQuestAnswer],
				PlayerInfo[playerid][pSQLID]
			);
			
			Log_Write("/logfiles/a_security.txt", "(%s) %s(%s) changed his security question into '%s'.", 
				GetName(playerid,false), 
				ReturnPlayerIP(playerid), 
				secQuestions[PlayerInfo[playerid][pSecQuestion]]
			);

			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "USPJESAN UNOS", "Uspjesno ste unijeli odgovor na sigurnosno pitanje!\nZapisite ga negdje jer ce vam trebati!", "Ok", "");
			return 1;
		}
		case DIALOG_SEC_MAIL: 
		{
			if(!response) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Ostavili ste prazno polje novog E-Maila!", "Input", "Abort");
			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1)
				return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Nedozvoljeni znakovi u E-Mailu!", "Input", "Abort");
			if(strlen(inputtext) > MAX_PLAYER_MAIL-1) return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Prevelik unos e-mail adrese!", "Input", "Abort");
			if(!IsValidEMail(inputtext)) return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Tu adresu netko koristi ili nije po standardima (obrati se adminima)!", "Input", "Abort");
			
			strcpy(PlayerInfo[playerid][pEmail], inputtext, MAX_PLAYER_MAIL);
			
			mysql_fquery(g_SQL, "UPDATE accounts SET email = '%e' WHERE sqlid = '%d'",
				PlayerInfo[playerid][pEmail],
				PlayerInfo[playerid][pSQLID]
			);
			
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "USPJESAN UNOS", "Uspjesno ste unijeli e-mail adresu!\nZapisite ju negdje jer ce vam trebati!", "Ok", "");
			return 1;
		}
		case DIALOG_SEC_PASS: 
		{
			if(!response) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Ostavili ste prazno polje!\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Input", "Abort");
			
			if(strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1)
				return ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Nedozvoljeni znakovi u unesenoj sifri!\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Input", "Abort");
			
			if(strlen(inputtext) < 3) 
			{ //Mala Sifra
				ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Premali unos sifre (manji od 3)\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Input", "Abort");
				return 1;
			}
			else if(strlen(inputtext) > 15) 
			{ //Prevelika
				ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Prevelik unos sifre (veca od 10)\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Input", "Abort");
				return 1;
			}

			strcpy(PlayerInfo[playerid][pPassword], inputtext, BCRYPT_COST);
			UpdateRegisteredPassword(playerid);

			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "USPJESAN UNOS", "Uspjesno ste unijeli vas novi password!\nZapisite ga negdje jer ce vam trebati!", "Ok", "");			
			return 1;
		}
		case DIALOG_SEC_NEWS: 
		{
			if(!response) 
			{
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}
			return 1;
		}
		case DIALOG_SEC_INPUTQ: 
		{
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
				return 1;
			}

			if(!strcmp(inputtext, PlayerInfo[playerid][pSecQuestAnswer], true, 31))
			{
				switch(Bit2_Get(gr_QuestionType, playerid))
				{
					case 1: 
					{
						Bit2_Set(gr_QuestionType, playerid, 0);
						ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu:", "Input", "Abort");
					}
					case 2: 
					{
						Bit2_Set(gr_QuestionType, playerid, 0);
						ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Input", "Abort");
					}
				}
			}
			else
			{
				new tmpString[128];
				format( tmpString, sizeof(tmpString), "%s\n"COL_RED"Niste unijeli valjani odgovor na sigurnosno pitanje!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", tmpString, "Input", "Abort");
			}
			return 1;
		}
	}
	return 0;
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

CMD:account(playerid, params[])
{
	#pragma unused params
	new tmpString[81];
	if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) 
		format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
	else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
	
	Bit2_Set(gr_QuestionType, playerid, 0);
	ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Choose", "Abort");
	return 1;
}


CMD:changepass(playerid, params[]) 
{
	new Cache: mysql_search, usersql, usernick[MAX_PLAYER_NAME], passnew[32];
	
	if(!IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	if(sscanf(params, "s[24]s[32]", usernick, passnew)) return SendClientMessage(playerid, COLOR_RED, "[?]: /changepass [Ime_Prezime][password].");
	
	// mysql search
	mysql_search = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT sqlid FROM accounts WHERE name = '%e'", usernick));
	if(!cache_num_rows())
		return va_SendClientMessage(playerid,COLOR_RED, "Account %s ne postoji!", usernick), cache_delete(mysql_search);
	cache_get_value_name_int(0, "sqlid"	, usersql);
	cache_delete(mysql_search);
	
	bcrypt_hash(passnew, BCRYPT_COST, "OnPasswordUpdateEx", "d", usersql);
	va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste igracu %s postavili novu lozinku: %s", usernick, passnew);
	return 1;
}
