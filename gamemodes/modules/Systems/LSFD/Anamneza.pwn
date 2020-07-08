#include <YSI\y_hooks>

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
		date[24],
		tmpQuery[ 258 ];
	getdate(Year, Month, Day);
	format( date, 24, "%02d.%02d.%d.", Day, Month, Year);
	mysql_format(g_SQL, tmpQuery, sizeof(tmpQuery), "INSERT INTO anamneza (`pacient`, `disease`, `doctor`, `date`) VALUES ('%e', '%e', '%e', '%e')",
		GetName(giveplayerid,false),
		disease,
		GetName(playerid,false),
		date
	);
	mysql_tquery(g_SQL, tmpQuery, "");
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si dodao zapis u karton za %s.", GetName(giveplayerid,true));
}

stock static DeletePlayerCarton(playerid, sqlid) 
{
	new
		destroyQuery[ 64 ];
	format( destroyQuery, sizeof(destroyQuery), "DELETE FROM anamneza WHERE `id` = '%d'", sqlid);
	mysql_tquery(g_SQL, destroyQuery, "");
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali karton broj: #%d!", sqlid);
}

stock CheckPlayerCarton(playerid, const name[])
{
	new financesQuery[160];
		
	mysql_format(g_SQL, financesQuery, sizeof(financesQuery), "SELECT * FROM anamneza WHERE `pacient` = '%e' ORDER BY id DESC", name );
	mysql_tquery(g_SQL, financesQuery, "OnPlayerCartonFinish", "is", playerid, name);
	return 1;
}

forward OnPlayerCartonFinish(playerid, const playername[]);
public OnPlayerCartonFinish(playerid, const playername[])
{
	new rows = cache_num_rows();
	if(!rows) return SendClientMessage(playerid,COLOR_RED, "U bazi nije pronadjena trazena osoba.");

	new 
		buffer[ 2056 ],
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
	format(tmpString, 46, "ANAMNEZA - Karton: %s", playername);
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
CMD:anamneza(playerid, params[])
{
	new opcija[20], pacient[30], disease[128], giveplayerid, ID;
    if( !IsFDMember(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste doktor!");
	if(PlayerInfo[playerid][pRank] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti rank 1 ili vise da bi koristio ovo !");
	if( sscanf( params, "s[20] ", opcija ) )
	{
		SendClientMessage(playerid, COLOR_RED, "USAGE: /anamneza [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] check - insert - delete");
		return 1;
	}
	if(strcmp(opcija,"check",true) == 0) // check
	{
		if( sscanf( params, "s[20]s[30]", opcija, pacient ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /anamneza [opcija] [Ime_Prezime]");
		if( 1 <= strlen( pacient ) <= MAX_PLAYER_NAME )
			{
				if( strfind(pacient, "_", true) == -1 ) return SendClientMessage(playerid, COLOR_RED, "NAPOMENA: Mora biti s znakom '_'! ");
				CheckPlayerCarton(playerid, pacient);
			}
	}
	else if(strcmp(opcija,"insert",true) == 0) //  insert
	{
		if( sscanf( params, "s[20]us[100]", opcija, giveplayerid, disease ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /anamneza insert [ID/Ime_Prezime] [Opis bolesti]");
		if (strlen(disease) >= 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Opis bolesti moze imati max 100 znakova!");
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
		InsertPlayerCarton(playerid, giveplayerid, disease);
	}
	else if(strcmp(opcija,"delete",true) == 0) // delete
	{
		if( sscanf( params, "s[20]i", opcija, ID ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /anamneza delete [rbr]");
		if( PlayerInfo[ playerid ][ pRank ] < 6 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo doktori sa vecom pozicijom! ((r6+))");
		DeletePlayerCarton(playerid, ID);
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznato ime za odabir!");
    return 1;
}
