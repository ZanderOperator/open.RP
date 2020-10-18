#include <YSI_Coding\y_hooks>

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

new
	NewsText[ 5 ][ 97 ],
	Text:NewsLineTextDraw[ 5 ],
	NewsLineNumber		= 0,
	SendNewsT 			= 0,
	NoNews				= 0;


/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

task NewsLineTask[1000]()
{
	NewsLineCheck();
	return 1;
}

stock NewsLineCheck()
{
	if( NewsLineNumber > 0 )
	{
		if( ++NoNews >= 60 ) {
			ClearNews();
			NoNews = 0;
	    }
	}
}

stock SendNews(string[])
{
	if( NewsLineNumber < 5 ) NewsLineNumber++;
	else return 0;

    for(new i = 5-1; i > 0; i--) {
	    TextDrawSetString(NewsLineTextDraw[i], NewsText[i-1]);
    	strmid(NewsText[i], NewsText[i-1], 0, strlen(NewsText[i-1]), 97);
	}
	TextDrawSetString(NewsLineTextDraw[0], string);
    strmid(NewsText[0], string, 0, strlen(string), 97);
	return 1;
}

stock SendWalkieTalkieMessage(member, color, sstring[])
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pMember] == member)
		{
			SendClientMessage(i, color, sstring);
			PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
		}
	}
}
stock ClearNews()
{
	if( ( NewsLineNumber - 1 ) < 0 ) return 0;

	NewsLineNumber--;
	TextDrawSetString(NewsLineTextDraw[ NewsLineNumber ], "\n");
	format(NewsText[ NewsLineNumber ], 97, "\n");
	return 1;
}

stock CreateNewsTextDraws()
{
    for(new i = 0; i < 5; i++)
    	format(NewsText[i], 97, "\n");

    NewsLineTextDraw[0] = TextDrawCreate(340.0, 415.0, NewsText[0]);
    NewsLineTextDraw[1] = TextDrawCreate(340.0, 404.0, NewsText[1]);
    NewsLineTextDraw[2] = TextDrawCreate(340.0, 393.0, NewsText[2]);
    NewsLineTextDraw[3] = TextDrawCreate(340.0, 382.0, NewsText[3]);
    NewsLineTextDraw[4] = TextDrawCreate(340.0, 371.0, NewsText[4]);

    for(new i = 0; i < 5; i++) {
        TextDrawLetterSize(NewsLineTextDraw[i], 0.249, 1.040);
	    TextDrawFont(NewsLineTextDraw[i], 1);
	    TextDrawSetShadow(NewsLineTextDraw[i], 0);
        TextDrawSetOutline(NewsLineTextDraw[i], 1);
        TextDrawSetProportional(NewsLineTextDraw[i], 1);
        TextDrawAlignment(NewsLineTextDraw[i], 2);
	}
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

hook OnPlayerSpawn(playerid)
{
	if(!IsANewUser(playerid))
	{
		TextDrawShowForPlayer( playerid, NewsLineTextDraw[ 0 ] );
        TextDrawShowForPlayer( playerid, NewsLineTextDraw[ 1 ] );
        TextDrawShowForPlayer( playerid, NewsLineTextDraw[ 2 ] );
        TextDrawShowForPlayer( playerid, NewsLineTextDraw[ 3 ] );
        TextDrawShowForPlayer( playerid, NewsLineTextDraw[ 4 ] );
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit8_Get(gr_PhoneLine, playerid) != 15 ) {
		new
			lineIndex = Bit8_Get(gr_PhoneLine, playerid);
		NewsPhone[ lineIndex ][ npNumber ] 		= 0;
		NewsPhone[ lineIndex ][ npPlayerID ] 	= -1;
		Bit8_Set(gr_PhoneLine, playerid, 15);
	}
	return 1;
}

hook OnPlayerConnect(playerid) {
	// garaza LSN by L3o
	RemoveBuildingForPlayer(playerid, 1294, 1380.5938, -1145.6406, 27.3359, 0.25);
	return (true);
}

hook OnGameModeInit() 
{
	CreateNewsTextDraws();
	
	// LSN garaza - novo - by L3o
	CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 8, -1, -1, 100.00); // world 8
	CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 8, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 8, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 8, -1, -1, 100.00);

	// garaza LSN by L3o
	CreateDynamicObject(9093, 1379.02710, -1159.67566, 24.54300,   0.00000, 0.00000, 90.10710);

	// Pickup
	CreateDynamicPickup(19133, 2, 284.846497, -1540.948486, 24.596806, 8, -1, -1, 80.0); // garaza
	return (true);
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
CMD:lsncamera(playerid, params[])
{
	if( !IsANews(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
	if( AC_GetPlayerWeapon(playerid) == WEAPON_CAMERA ) return SendClientMessage( playerid, COLOR_RED, "[ANTI-BAN]: Vec imate kameru u rukama!");
	if( IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti izvan vozila!");

	AC_GivePlayerWeapon(playerid, WEAPON_CAMERA, 50);
	return 1;
}

CMD:live(playerid, params[])
{
	if( !IsANews(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
	new giveplayerid, playerName[MAX_PLAYER_NAME], newsName[MAX_PLAYER_NAME];
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /live [playerid/dio imena]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi ste ID unijeli!");

	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, newsName, MAX_PLAYER_NAME);

	if( Bit1_Get(gr_OnLive, giveplayerid) ) {
		Bit1_Set(gr_OnLive, giveplayerid, false);
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Skinuli ste %s, dozvolu gostu za pricanje u eter.", playerName);
		va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: Izgubili ste dozvolu za govor u eteru od novinara %s!", newsName);
	} else {
		Bit1_Set(gr_OnLive, giveplayerid, true);
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dali ste %s, dozvolu gostu za ulazak u eter. Da skines dozvolu koristi /live.", playerName);
		va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: Dobili ste dozvolu za govor u eteru od novinara %s!", newsName);
	}
	return 1;
}

CMD:news(playerid, params[])
{
	if( !IsANews(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste novinar!");
	new
		vehicleid = GetPlayerVehicleID(playerid);
	if( GetVehicleModel( vehicleid ) != 582 && GetVehicleModel( vehicleid ) != 488 && !IsPlayerInRangeOfPoint(playerid, 10.0, 1409.6332,-1195.5559,88.4888) )
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu ili unutar studija!");
	if( SendNewsT > gettimestamp() ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate cekati 5 sekundi!");

	if( !IsSafeForTextDraw(params) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Upisani tekst nije prikladan za news!");
	if( strlen(params) < 1 || strlen(params) > 64 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan unos rijeci (1-64)!");

	new
		message[ 128 ];
	format( message, 128, "~y~%s: ~w~%s", GetName(playerid, false), params );
	if( !SendNews(message) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte da se tekst obrise!");

	BudgetToOrgMoney( FACTION_TYPE_NEWS, 100); // dobivaju novac iz proracuna
	PlayerInfo[playerid][pNews]++;
	SendNewsT = gettimestamp() + 5;
	return 1;
}

CMD:tognews(playerid,params[])
{
	if(blockedNews[playerid] == false) {
		blockedNews[playerid] = true;
		for(new i = 0; i < 5; i++) {
			TextDrawHideForPlayer(playerid, NewsLineTextDraw[i]);
		}
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Iskljucio si vidljivost LSN-a!");
	}
	else if(blockedNews[playerid] == true) {
		blockedNews[playerid] = false;
		for(new i = 0; i < 5; i++) {
			TextDrawShowForPlayer(playerid, NewsLineTextDraw[i]);
		}
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Ukljucio si vidljivost LSN-a!");
	}
	return 1;
}

CMD:lsnstat(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pLeader ] != 5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
	new
		param[7],
		giveplayerid;
	if( sscanf( params, "s[7] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lsnstat [check/delete]");

	if( !strcmp(param, "check", true ) ) {
		if( sscanf( params, "s[7]u", param, giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lsnstat check [dio imena/playerid]");
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
		if( !IsANews(giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije novinar!");
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Igrac je poslao %d poruka i zaradio %d$!", PlayerInfo[ giveplayerid ][ pNews ], ( PlayerInfo[ giveplayerid ][ pNews ] * 15 )  );
	}
	else if( !strcmp(param, "delete", true ) ) 	{
		if( sscanf( params, "s[7]u", param, giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lsnstat check [dio imena/playerid]");
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije online!");
		if( !IsANews(giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Igrac nije novinar!");
		PlayerInfo[ giveplayerid ][ pNews ]	= 0;
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali LSN statse clanu %s", GetName(giveplayerid));
	}
	return 1;
}

CMD:lsnup(playerid, params[])
{
	if( !IsANews(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
	if( !IsPlayerInRangeOfPoint( playerid, 5.0, 1431.0470,-1183.8474,88.4837 ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu ulaza u hodnik!");

	SetPlayerPosEx(playerid, 1401.2340,-1187.0062,187.2153, 0, 0, false);
	return 1;
}

CMD:lsndown(playerid, params[])
{
	if( !IsANews(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");
	if( !IsPlayerInRangeOfPoint( playerid, 5.0, 1401.2340,-1187.0062,187.2153 ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu ulaza u hodnik!");

	SetPlayerPosEx(playerid, 1431.0470,-1183.8474,88.4837, 0, 0, false);
	return 1;
}

CMD:reset_news(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 4 && PlayerInfo[ playerid ][ pLeader ] != 5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Leader/Admin Lvl 4+!");
	for( new i = 0; i < 5; i++ ) {
		TextDrawSetString(NewsLineTextDraw[ i ], "\n");
		format(NewsText[ i ], 97, "\n");
	}
	NewsLineNumber = 0;
	return 1;
}

CMD:callnews(playerid,params[])
{
	if( !PlayerInfo[ playerid ][ pMobileNumber ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate mobitel!");
	if( PlayerInfo[ playerid ][ pMobileCost ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate novca na mobitelnom racunu da biste pozvali taxi!");

	new string[256], result[128];
	if( sscanf( params, "s[128]",result ) ) return SendClientMessage(playerid,-1,"KORISTI: /callnews [opis stanja]");

	format(string, sizeof(string), "** [REDAKCIJA - POZIV] Mobitel broj: %d - Stanje: %s",
		PlayerInfo[playerid][pMobileNumber],
		result
	);
	SendWalkieTalkieMessage(5, 0x42C8F5FF, string);

	format(string, sizeof(string), "* %s vadi mobitel i stavlja ga na uho.", GetName(playerid));
	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 5000);
	SendClientMessage(playerid, COLOR_YELLOW, "* Poslao si poziv u LSN ured!");

	PlayerInfo[playerid][pMobileCost] -= 3;

	new	moneyUpdate[128];
	format(moneyUpdate, 128, "UPDATE `player_phones` SET `money` = '%d' WHERE `player_id` = '%d' AND `type` = '1'",
		PlayerInfo[playerid][pMobileCost],
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, moneyUpdate);
	return 1;
}

CMD:lsngarage(playerid, params[]) {
	if( !IsANews(playerid) )
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste novinar!");

	if(IsPlayerInRangeOfPoint(playerid, 15.0, 1378.6362,-1155.7634,23.8321) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 284.8465,-1540.9485,24.5968, 8, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 287.2799,-1537.8717,24.5278);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 8);
				}
			}

			SetPlayerVirtualWorld(playerid, 8);
			SetVehicleVirtualWorld(vehicleid, 8);
			SetVehicleZAngle(vehicleid, 325.2156);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0, 284.8465,-1540.9485,24.5968) && GetPlayerVirtualWorld(playerid) == 8)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 1378.6362,-1155.7634,23.8321, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 1379.3405,-1150.7832,23.7682);
			SetVehicleVirtualWorld(vehicleid, 0);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleZAngle(vehicleid, 358.9041);
		}
	}
	return (true);
}

