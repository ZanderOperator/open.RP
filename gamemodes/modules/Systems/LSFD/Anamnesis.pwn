#include <YSI_Coding\y_hooks>

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

// Stocks
stock InsertPlayerCarton(playerid, giveplayerid, const disease[])
{
	new Day,
		Month,
		Year,
		date[24];

	getdate(Year, Month, Day);
	format( date, 24, "%02d.%02d.%d.", Day, Month, Year);
	
	mysql_fquery_ex(g_SQL, "INSERT INTO anamnesis (patient, disease, doctor, date) VALUES ('%e', '%e', '%e', '%e')",
		GetName(giveplayerid,false),
		disease,
		GetName(playerid,false),
		date
	);

	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si dodao zapis u karton za %s.", GetName(giveplayerid,true));
    return 1;
}

stock static DeletePlayerCarton(playerid, sqlid) 
{
	va_fquery(g_SQL, "DELETE FROM anamnesis WHERE id = '%d'", sqlid);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali karton broj: #%d!", sqlid);
    return 1;
}

stock CheckPlayerCarton(playerid, const name[])
{
	mysql_tquery(g_SQL, 
    	va_fquery(g_SQL, "SELECT * FROM anamnesis WHERE patient = '%e' ORDER BY id DESC", name), 
        "OnPlayerCartonFinish", 
        "is", 
        playerid, 
        name
    );
	return 1;
}

forward OnPlayerCartonFinish(playerid, const playername[]);
public OnPlayerCartonFinish(playerid, const playername[])
{
	new rows = cache_num_rows();
	if(!rows) return SendClientMessage(playerid,COLOR_RED, "U bazi nije pronadjena trazena osoba.");

	new 
		buffer[2056],
		motd[256],
		sqlid,
		doctor[MAX_PLAYER_NAME],
		disease[128],
		date[24];
	
	format(buffer, sizeof(buffer), "{DEA4A4}RBR.\tBOLEST\tDOKTOR\tDATUM"COL_WHITE"\n");
	
	for( new i = 0; i < cache_num_rows(); i++ ) 
	{
	
		cache_get_value_name_int(i, "id"			, sqlid);
		cache_get_value_name(i, 	"disease"		, disease,	128);
		cache_get_value_name(i, 	"doctor"		, doctor,	30);
		cache_get_value_name(i, 	"date"			, date, 24);
		
		format(motd, sizeof(motd), "%d\t%s\t%s\t%s\n",
			sqlid,
			disease,
			doctor,
			date
		);
		strcat(buffer, motd, sizeof(buffer));		
	}
	new tmpString[46];
	format(tmpString, 46, "anamnesis - Karton: %s", playername);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, tmpString, buffer, "Close", "");
	return 1;
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
CMD:anamnesis(playerid, params[])
{
	new opcija[20], patient[30], disease[128], giveplayerid, ID;
    if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste doktor!");
	if(PlayerFaction[playerid][pRank] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti rank 1 ili vise da bi koristio ovo !");
	if(sscanf( params, "s[20] ", opcija ))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /anamnesis [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[!] check - insert - delete");
		return 1;
	}
	if(strcmp(opcija,"check",true) == 0) // check
	{
		if(sscanf( params, "s[20]s[30]", opcija, patient )) return SendClientMessage(playerid, COLOR_RED, "[?]: /anamnesis [opcija][Ime_Prezime]");
		if(1 <= strlen( patient ) <= MAX_PLAYER_NAME )
        {
            if(strfind(patient, "_", true) == -1 ) 
                return SendClientMessage(playerid, COLOR_RED, "NAPOMENA: Mora biti s znakom '_'! ");
            CheckPlayerCarton(playerid, patient);
        }
	}
	else if(strcmp(opcija,"insert",true) == 0) //  insert
	{
		if(sscanf( params, "s[20]us[100]", opcija, giveplayerid, disease )) return SendClientMessage(playerid, COLOR_RED, "[?]: /anamnesis insert [ID/Ime_Prezime][Opis bolesti]");
		if(strlen(disease) >= 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Opis bolesti moze imati max 100 znakova!");
		if(giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
		InsertPlayerCarton(playerid, giveplayerid, disease);
	}
	else if(strcmp(opcija,"delete",true) == 0) // delete
	{
		if(sscanf( params, "s[20]i", opcija, ID )) return SendClientMessage(playerid, COLOR_RED, "[?]: /anamnesis delete [rbr]");
		if(PlayerFaction[playerid][pRank] < 6 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo doktori sa vecom pozicijom! ((r6+))");
		DeletePlayerCarton(playerid, ID);
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznato ime za odabir!");
    return 1;
}
