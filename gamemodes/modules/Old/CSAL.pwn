/*
	 ######  ##     ## ########  
	##    ## ###   ### ##     ## 
	##       #### #### ##     ## 
	##       ## ### ## ##     ## 
	##       ##     ## ##     ## 
	##    ## ##     ## ##     ## 
	 ######  ##     ## ########  
*/
CMD:badge(playerid, params[])
{
	if( !IsACSAL(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik CSAL agencije!");
	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /badge [dio imena/playerid]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos playerida!");
	if( !ProxDetectorS(5.0, playerid, giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	va_ShowPlayerDialog(giveplayerid, 0, DIALOG_STYLE_MSGBOX, "CSAL", ""COL_CYAN"Central Security Agency of Los Santos\n"COL_WHITE"Ime agenta: %s", "Uredu", "",GetName(playerid, true));
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Pokazali ste %s svoju znacku!", GetName(giveplayerid, false));
	return 1;
}