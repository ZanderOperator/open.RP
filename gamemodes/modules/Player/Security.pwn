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
	Bit2: gr_QuestionType	<MAX_PLAYERS>,
	_VarGetPass[MAX_PLAYERS][MAX_PLAYER_PASSWORD];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock UpdateRegisteredPassword(playerid)
{
	new pass[32], password[129];
	StringReverse(PlayerInfo[playerid][pPassword], pass);
	PlayerInfo[playerid][pPassword][0]		= EOS;
	format(password, sizeof(password), "COA%s%d", pass, PlayerInfo[playerid][pSQLID]);
	WP_Hash(PlayerInfo[playerid][pPassword], 129, password);
	
	new
		updatePasswordQuery[256];
	format(updatePasswordQuery, sizeof(updatePasswordQuery), "UPDATE `accounts` SET `password` = '%q' WHERE `sqlid` = '%d' LIMIT 1",
		PlayerInfo[playerid][pPassword],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, updatePasswordQuery, "", "");
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
*/
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_SEC_MAIN: {
			if(!response) return 1;
			switch(listitem)
			{
				case 0: { //E-Mail
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uneseno sigurnosno pitanje! Sigurnosno pitanje MORA biti uneseno ako zelite nesto mjenjati!");
					
					Bit2_Set(gr_QuestionType, playerid, 1);
					ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", secQuestions[PlayerInfo[playerid][pSecQuestion]], "Unesi", "Odustani");
				}
				case 1: { //Password
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uneseno sigurnosno pitanje! Sigurnosno pitanje MORA biti uneseno ako zelite nesto mjenjati!");
					
					Bit2_Set(gr_QuestionType, playerid, 2);
					ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", secQuestions[PlayerInfo[playerid][pSecQuestion]], "Unesi", "Odustani");
				}
				case 2: { //Sigurnosno Pitanje
					if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) {
						new motd[68],
							tmpstring[504];
						for(new i = 0; i < MAX_SECURITY_QUESTIONS; i++)
						{
							if(i != (MAX_SECURITY_QUESTIONS - 1))
								format(motd, sizeof(motd), "%s\n", secQuestions[i]);
							else format(motd, sizeof(motd), "%s", secQuestions[i]);
							strcat(tmpstring, motd);
						}
						ShowPlayerDialog(playerid, DIALOG_SEC_SECQUEST, DIALOG_STYLE_LIST, "SIGURNOSNO PITANJE", tmpstring, "Odaberi", "Odustani");
					}
				}
			}
			return 1;
		}
		case DIALOG_SEC_SECQUEST: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1)
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			
			PlayerInfo[playerid][pSecQuestion] = listitem;
			new 
				tmpString[165];
			format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\nNAPOMENA: Duzina odgovora MORA biti izmedju 3-30 znakova!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
			ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Unesi", "Odustani");
			return 1;
		}
		case DIALOG_SEC_QUESTANSWER: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			if(isnull(inputtext))
			{
				new 
					tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"Ostavili ste prazno polje na mjestu odgovora!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Unesi", "Odustani");
				return 1;
			}
			if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
			{
				new 
					tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"Nedozvoljeni znakovi u sigurnosnom odgovoru!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Unesi", "Odustani");
				return 1;
			}
			if(strlen(inputtext) < 3 || strlen(inputtext) > 30) {
				new 
					tmpString[175];
				format(tmpString, 165, "Unesite odgovor na sigurnosno pitanje:\n%s\n\n"COL_RED"NAPOMENA: Duzina odgovora MORA biti izmedju 3-30 znakova!", secQuestions[PlayerInfo[playerid][pSecQuestion]]);
				ShowPlayerDialog(playerid, DIALOG_SEC_QUESTANSWER, DIALOG_STYLE_PASSWORD, "UNOS ODGOVORA NA PITANJE", tmpString, "Unesi", "Odustani");
				return 1;
			}
			if(isnull(inputtext)) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			
			format(PlayerInfo[playerid][pSecQuestAnswer], 31, inputtext);
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste postavili odgovor na sigurnosno pitanje! Zapisite ga negdje jer ce vam trebati!");
			
			new
				tmpQuery[ 512 ];
			format(tmpQuery, sizeof(tmpQuery), "UPDATE `accounts` SET `secquestion` = '%d', `secawnser` = '%q' WHERE `sqlid` = '%d' LIMIT 1",
				PlayerInfo[playerid][pSecQuestion],
				PlayerInfo[playerid][pSecQuestAnswer],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_pquery(g_SQL, tmpQuery, "", "");
			
			format(tmpQuery, 512, "%s(%s) je promjenio svoje sigurnosno pitanje u %s.", GetName(playerid,false), GetPlayerIP(playerid), secQuestions[PlayerInfo[playerid][pSecQuestion]]);
			LogSecurity(tmpQuery);
			return 1;
		}
		case DIALOG_SEC_MAIL: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Ostavili ste prazno polje novog E-Maila!", "Unesi", "Odustani");
			if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
				return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Nedozvoljeni znakovi u E-Mailu!", "Unesi", "Odustani");
			if(strlen(inputtext) > MAX_PLAYER_MAIL-1) return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Prevelik unos e-mail adrese!", "Unesi", "Odustani");
			if(!IsValidEMail(inputtext)) return ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu.\n"COL_RED"Tu adresu netko koristi ili nije po standardima (obrati se adminima)!", "Unesi", "Odustani");
			format(PlayerInfo[playerid][pEmail], MAX_PLAYER_MAIL, inputtext);
			
			new
				tmpQuery[ 512 ];
			format(tmpQuery, sizeof(tmpQuery), "UPDATE `accounts` SET `email` = '%q' WHERE `sqlid` = '%d' LIMIT 1",
				PlayerInfo[playerid][pEmail],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_tquery(g_SQL, tmpQuery, "", "");
			
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "USPJESAN UNOS E-MAIL ADRESE", "Uspjesno ste unijeli e-mail adresu!\nZapisite ju negdje jer ce vam trebati!", "Uredu", "");
			return 1;
		}
		case DIALOG_SEC_PASS: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Ostavili ste prazno polje!\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Unesi", "Odustani");
			
			if( strfind(inputtext, "%", true) != -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, "=", true) != -1 || strfind(inputtext, "+", true) != -1 || strfind(inputtext, "'", true) != -1 || strfind(inputtext, ">", true) != -1 || strfind(inputtext, "^", true) != -1 || strfind(inputtext, "|", true) != -1 || strfind(inputtext, "?", true) != -1 || strfind(inputtext, "*", true) != -1 || strfind(inputtext, "#", true) != -1 || strfind(inputtext, "!", true) != -1 || strfind(inputtext, "$", true) != -1 )
				return ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Nedozvoljeni znakovi u unesenoj sifri!\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Unesi", "Odustani");
			
			if(strlen(inputtext) < 3) { //Mala Sifra
				ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Premali unos sifre (manji od 3)\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Unesi", "Odustani");
				return 1;
			}
			else if(strlen(inputtext) > 15) { //Prevelika
				ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n"COL_RED"Prevelik unos sifre (veca od 10)\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Unesi", "Odustani");
				return 1;
			}
			
			new pass[32], password[128];
			StringReverse(inputtext, pass);
			format(password, sizeof(password), "COA%s%d", pass, PlayerInfo[playerid][pSQLID]);
			WP_Hash(PlayerInfo[playerid][pPassword], 129, password);
			
			new
				updatePasswordQuery[256];
			format(updatePasswordQuery, sizeof(updatePasswordQuery), "UPDATE `accounts` SET `password` = '%q' WHERE `sqlid` = '%d' LIMIT 1",
				PlayerInfo[playerid][pPassword],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_tquery(g_SQL, updatePasswordQuery, "", "");

			SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste promjenili svoj password.");
			return 1;
		}
		case DIALOG_SEC_NEWS: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}
			return 1;
		}
		case DIALOG_SEC_INPUTQ: {
			if(!response) {
				new tmpString[81];
				if(PlayerInfo[playerid][pSecQuestion] == -1) 
					format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
				else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
				ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
				return 1;
			}

			if(!strcmp(inputtext, PlayerInfo[playerid][pSecQuestAnswer], true, 31))
			{
				switch(Bit2_Get(gr_QuestionType, playerid))
				{
					case 1: {
						Bit2_Set(gr_QuestionType, playerid, 0);
						ShowPlayerDialog(playerid, DIALOG_SEC_MAIL, DIALOG_STYLE_INPUT, "UNOS E-MAIL ADRESE", "Unesite novu e-mail adresu:", "Unesi", "Odustani");
					}
					case 2: {
						Bit2_Set(gr_QuestionType, playerid, 0);
						ShowPlayerDialog(playerid, DIALOG_SEC_PASS, DIALOG_STYLE_PASSWORD, "UNOS NOVE SIFRE", "Unesite novu sifru:\n\n"COL_RED"NAPOMENA: Dobro spremite svoju sifru, ako ju izgubite obratite se administraciji!", "Unesi", "Odustani");
					}
				}
			} else {
				new
					tmpString[ 128 ];
				format( tmpString, sizeof(tmpString), "%s\n"COL_RED"Niste unijeli valjani odgovor na sigurnosno pitanje!", secQuestions[PlayerInfo[playerid][pSecQuestion]] );
				ShowPlayerDialog(playerid, DIALOG_SEC_INPUTQ, DIALOG_STYLE_INPUT, "UNOS ODGOVORA NA SIGURNOSNO PITANJE", tmpString, "Unesi", "Odustani");
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
	new 
		tmpString[81];
	if(isnull(PlayerInfo[playerid][pSecQuestAnswer])) 
		format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru\n"COL_RED"Unesi sigurnosno pitanje");
	else format(tmpString, sizeof(tmpString), "Izmjeni e-mail\nIzmjeni sifru");
	
	Bit2_Set(gr_QuestionType, playerid, 0);
	ShowPlayerDialog(playerid, DIALOG_SEC_MAIN, DIALOG_STYLE_LIST, "User Control Panel", tmpString, "Odaberi", "Odustani");
	return 1;
}


CMD:changepass(playerid, params[]) {

	new Cache: mysql_search, usersql, mysql_buffer[128], usernick[MAX_PLAYER_NAME],
		reversepass[32], finalpassword[128], updquery[256], passnew[32];
	
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] < 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "s[24]s[32]", usernick, passnew)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /changepass [Ime_Prezime] [password].");
	
	// mysql search
	format(mysql_buffer, sizeof(mysql_buffer), "SELECT sqlid FROM `accounts` WHERE `name` = '%q' LIMIT 0,1", usernick);
	mysql_search = mysql_query(g_SQL, mysql_buffer);
	if(!cache_num_rows())
		return va_SendClientMessage(playerid,COLOR_RED, "Account %s ne postoji!", usernick), cache_delete(mysql_search);
	cache_get_value_name_int(0, "sqlid"	, usersql);
	cache_delete(mysql_search);
	
	// hash password
	SetString(_VarGetPass[playerid], "");
	StringReverse(passnew, reversepass);
	format(finalpassword, sizeof(finalpassword), "COA%s%d", reversepass, usersql);
	WP_Hash(_VarGetPass[playerid], 129, finalpassword);

	// save
	format(updquery, sizeof(updquery), "UPDATE `accounts` SET `password` = '%q' WHERE `sqlid` = '%d' LIMIT 1",
		_VarGetPass[playerid],
		usersql
	);
	mysql_tquery(g_SQL, updquery, "", "");
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste igracu %s postavili novu lozinku: %s", usernick, passnew);
	return (true);
}
