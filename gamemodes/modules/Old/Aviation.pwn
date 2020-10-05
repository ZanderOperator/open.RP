#include <YSI\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

#define MAX_AVIATION_INFO	 				200

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
///////////////////////////////////////////////////////////////////

enum E_AV_DATA
{
	avPilot[MAX_PLAYER_NAME],
	avAcceptedBy[MAX_PLAYER_NAME],
	avVehicle,
	avRoute[128],
	avTaken,
	avTimer
}
new AviationInfo[ MAX_AVIATION_INFO ][ E_AV_DATA ];

enum E_PLAYER_AV_DATA
{
    FlightApprove,
	FlightApproveTimer,
	FlightRequested,
	FlightVehicle,
	FlightRoute[128]
}
new FlightInfo[ MAX_PLAYERS ][ E_PLAYER_AV_DATA ];

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

hook OnPlayerDisconnect(playerid, reason)
{
	FlightInfo[playerid][FlightApprove] = 1;
	FlightInfo[playerid][FlightRequested] = 0;
	FlightInfo[playerid][FlightVehicle] = -1;
	format(FlightInfo[playerid][FlightRoute], 128, "N/A");
	if(FlightInfo[playerid][FlightApprove] == 0) KillTimer(FlightInfo[playerid][FlightApproveTimer]);
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
    foreach(new i : Player)
    {
        if(FlightInfo[i][FlightVehicle] != -1 && FlightInfo[i][FlightVehicle] == vehicleid)
        {
			FlightInfo[i][FlightRequested] = 0;
			FlightInfo[i][FlightVehicle] = -1;
			format(FlightInfo[i][FlightRoute], 128, "N/A");
			SendInfoMessage(i, "Vas zahtjev za let je otkazan zbog unistenja vozila u kojemu ste ga prijavili!");
        }
    }
	for(new i = 0; i < MAX_AVIATION_INFO; i++)
	{
	    if(AviationInfo[i][avVehicle] == vehicleid)
	    {
		    AviationInfo[i][avTaken] = 0;
	        break;
	    }
	}
	return 1;
}

forward DeleteFlightReport(flightid);
public DeleteFlightReport(flightid)
{
	AviationInfo[flightid][avTaken] = 0;
	return 1;
}

forward PlayerFlightApprove(playerid);
public PlayerFlightApprove(playerid)
{
	FlightInfo[playerid][FlightApprove] = 1;
	return 1;
}

stock SendFlightMessage(color, string[])
{
	new
		fvehiclemodel;
	foreach (new i : Player)
	{
	    if(IsPlayerInAnyVehicle(i))
	    {
		    fvehiclemodel = GetVehicleModel(GetPlayerVehicleID(i));
			if(IsAPlane(fvehiclemodel) || IsAHelio(fvehiclemodel))
				SendClientMessage(i, color, string);
		}
	}
}

/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/
///////////////////////////////////////////////////////////////////

CMD:fr(playerid, params[])
{
	#if defined EVENTSTARTED
	SendClientMessage( playerid, COLOR_RED, "** Static **");
	return 1;
	#endif
	new frString[128], frInput[90];
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Ne nalazite se u vozilu koje posjeduje radio prijemnik spojen na frekvenciju kontrolnog tornja!");
	if(!IsAPlane(GetVehicleModel(GetPlayerVehicleID(playerid))) && !IsAHelio(GetVehicleModel(GetPlayerVehicleID(playerid)))) return SendErrorMessage(playerid, "Ne nalazite se u vozilu koje posjeduje radio prijemnik spojen na frekvenciju kontrolnog tornja!");
	if( sscanf( params, "s[90]", frInput ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fr [text]");
	format(frString, sizeof(frString), "** [AIR] %s: %s **", GetName(playerid, false), frInput);
	SendFlightMessage(TEAM_BLUE_COLOR, frString);
	return 1;
}

CMD:flight(playerid, params[])
{
	new pick[ 16 ];
	if( sscanf( params, "s[16]  ", pick ) )
	{
		if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight [report/cancel]");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight [report/cancel/view/accept/decline/all]");
		return 1;
	}
	if( !strcmp(pick, "report", true) )
	{
	    new avOpisStr[128], tmpString[256];
	    if(FlightInfo[playerid][FlightRequested] != 0) return SendErrorMessage(playerid, "Vec imate prijavljen let. Prvo ga otkazite ako zelite prijaviti novi!");
	    if(FlightInfo[playerid][FlightApprove] == 0) return SendErrorMessage(playerid, "Morate pricekati malo prije prijavljivanja drugog leta!");
	    if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Ne nalazite se u vozilu koje posjeduje radio prijemnik spojen na frekvenciju kontrolnog tornja!");
	    if(!IsAPlane(GetVehicleModel(GetPlayerVehicleID(playerid))) && !IsAHelio(GetVehicleModel(GetPlayerVehicleID(playerid)))) return SendErrorMessage(playerid, "Ne nalazite se u vozilu koje posjeduje radio prijemnik spojen na frekvenciju kontrolnog tornja!");
	    if( sscanf(params, "s[16]s[128]", pick, avOpisStr ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight report [opis rute i destinacije]");
	    if(strlen(avOpisStr) < 20 || strlen(avOpisStr) > 120) return SendErrorMessage(playerid, "Opis rute i destinacije mora biti izmedju 20 i 120 znakvova!");
	    FlightInfo[playerid][FlightRequested] = 1;
		FlightInfo[playerid][FlightVehicle] = GetPlayerVehicleID(playerid);
		format(FlightInfo[playerid][FlightRoute], 128, avOpisStr);
		FlightInfo[playerid][FlightApprove] = 0;
		FlightInfo[playerid][FlightApproveTimer] = SetTimerEx("PlayerFlightApprove", 5*1000*60, true, "i", playerid);
		format(tmpString, sizeof(tmpString), "[HQ] %s zahtjeva dozvolu za polijetanje i izvrsavanje leta.", GetName(playerid, false));
		SendRadioMessage(1, COLOR_SKYBLUE, tmpString);
		SendRadioMessage(5, COLOR_SKYBLUE, tmpString);
		SendRadioMessage(4, COLOR_SKYBLUE, tmpString);
		SendInfoMessage(playerid, "Zatrazili ste dozvolu za let. Vas zahtjev je na cekanju!");
	}
	else if( !strcmp(pick, "cancel", true) )
	{
	    if(FlightInfo[playerid][FlightRequested] == 0) return SendErrorMessage(playerid, "Nemate prijavljen let ili je let koji ste prijavili vec odobren!");
	    FlightInfo[playerid][FlightRequested] = 0;
		SendInfoMessage(playerid, "Otkazali ste zahtjev za dozvolu za let.");
	}
	else if( !strcmp(pick, "view", true) )
    {
	    if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendErrorMessage(playerid, "Niste clan LSPD/SASD/GOV!");
		new
			slotid,
			Float:vhPosX,
			Float:vhPosY,
			Float:vhPosZ;
		if( sscanf(params, "s[16]i", pick, slotid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight view [id]");
		if( slotid < 0 && slotid > MAX_AVIATION_INFO ) return va_SendErrorMessage(playerid, "Nevaljan flight ID (0-%d).", MAX_AVIATION_INFO-1 );
		if(AviationInfo[slotid][avTaken] == 0) return SendErrorMessage(playerid, "Nevaljan flight ID. Ne postoji prijavljen let pod tim ID-om!");
		new FlightInfoString[512], avVehicleModel[128], avFlightDescription[128], avFDOne[64], avFDTwo[64];
		strunpack( avVehicleModel, Model_Name(GetVehicleModel(AviationInfo[slotid][avVehicle])) );
		GetVehiclePos(AviationInfo[slotid][avVehicle], vhPosX, vhPosY, vhPosZ);
	 	if( strlen(AviationInfo[slotid][avRoute]) >= 64 )
	    {
			strmid(avFDOne, AviationInfo[slotid][avRoute], 0, 64);
			strmid(avFDTwo, AviationInfo[slotid][avRoute], 63, strlen(AviationInfo[slotid][avRoute]));
			format(avFlightDescription, 128, "%s\n%s", avFDOne, avFDTwo);
		}
		else format(avFlightDescription, 128, AviationInfo[slotid][avRoute]);
		format(FlightInfoString, sizeof(FlightInfoString), "Flight NO: 585/%d\nPilot: %s\nFlight approval: %s\nVehicle model: %s\nCurrent flight-radar location: %s\n\nFlight description:\n%s", slotid, AviationInfo[slotid][avPilot], AviationInfo[slotid][avAcceptedBy], avVehicleModel, GetStreetNamePos(vhPosX, vhPosY, vhPosZ), avFlightDescription);
		ShowPlayerDialog( playerid, 5000, DIALOG_STYLE_MSGBOX, "FLIGHT INFO", FlightInfoString, "OK", "");
	}
	else if( !strcmp(pick, "accept", true) )
	{
	    if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendErrorMessage(playerid, "Niste clan LSPD/SASD/GOV!");
	    if( PlayerInfo[ playerid ][ pRank ] < 5 ) SendErrorMessage(playerid, "Niste rank 5!");
		new
			playvid,
			flighttime,
			tmpString[256],
			avPickID = -1;
		if( sscanf(params, "s[16]ii", pick, playvid, flighttime ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight accept [playerid] [vrijeme do isteka dozvole (minute)");
		if(flighttime < 10 || flighttime > 120) return SendErrorMessage(playerid, "Vrijeme do isteka dozvole za letenje moze biti izmedu 10 i 120 minuta!");
		if(!IsPlayerConnected(playvid)) return SendErrorMessage(playerid, "Taj igrac nije na serveru!");
		if(FlightInfo[playvid][FlightRequested] == 0) return SendErrorMessage(playerid, "Taj igrac nije prijavio let!");
		for(new i; i < MAX_AVIATION_INFO; i++)
	    {
	        if(AviationInfo[i][avTaken] == 0)
			{
				avPickID = i;
				break;
			}
	    }
	    if(avPickID == -1) return SendErrorMessage(playerid, "Kontrolni toranj ne dopusta vise letova. Pokusajte kasnije.");
	    GetPlayerName(playvid, AviationInfo[avPickID][avPilot], MAX_PLAYER_NAME);
	    AviationInfo[avPickID][avVehicle] = FlightInfo[playvid][FlightVehicle];
	    AviationInfo[avPickID][avTaken] = 1;
	    GetPlayerName(playerid, AviationInfo[avPickID][avAcceptedBy], MAX_PLAYER_NAME);
	    format(AviationInfo[avPickID][avRoute], 128, FlightInfo[playvid][FlightRoute]);
		FlightInfo[playvid][FlightRequested] = 0;
		AviationInfo[avPickID][avTimer] = SetTimerEx("DeleteFlightReport", flighttime*1000*60, true, "i", avPickID);
		format(tmpString, sizeof(tmpString), "[HQ] %s %s je prihvatio zahtjev za let 585/%d.", ReturnPlayerRankName(playerid), GetName(playerid, false), avPickID);
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_SKYBLUE, tmpString);
		va_SendInfoMessage(playerid, "Prihvatili ste zahtjev za let 585/%d.", avPickID);
		va_SendInfoMessage(playvid, "Vas zahtjev za let je prihvacen. Broj leta je 585/%d", avPickID);
	}
	else if( !strcmp(pick, "decline", true) )
	{
	    if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendErrorMessage(playerid, "Niste clan LSPD/SASD/GOV!");
	    if( PlayerInfo[ playerid ][ pRank ] < 5 ) SendErrorMessage(playerid, "Niste rank 5!");
		new
			playvid;
		if( sscanf(params, "s[16]i", pick, playvid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight decline [playerid]");
		if(!IsPlayerConnected(playvid)) return SendErrorMessage(playerid, "Taj igrac nije na serveru!");
		if(FlightInfo[playvid][FlightRequested] == 0) return SendErrorMessage(playerid, "Taj igrac nije prijavio let!");
		FlightInfo[playerid][FlightRequested] = 0;
		va_SendInfoMessage(playerid, "Otkazali ste zahtjev za let od %s.", GetName(playvid, false));
		SendInfoMessage(playvid, "Vas zahtjev za let je odbijen!");
	}
	else if( !strcmp(pick, "all", true) )
	{
	    if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendErrorMessage(playerid, "Niste clan LSPD/SASD/GOV!");
		new flightCount = 0;
		for(new i = 0; i < MAX_AVIATION_INFO; i++)
		{
            if(AviationInfo[i][avTaken] == 1)
            {
                new tmpString[ 128 ];
				format(tmpString, sizeof(tmpString), "- FLIGHT NO: 585/%d (Accepted by: %s)", i, AviationInfo[ i ][ avAcceptedBy ]);
				SendClientMessage(playerid, COLOR_ORANGE, tmpString);
				flightCount++;
            }
		}
		if(flightCount <= 0) return SendErrorMessage(playerid, "Nije pronaden nijedan prijavljen let!");
	}
	else
	{
		if( !IsACop(playerid) && !IsASD(playerid) && !IsAGov(playerid) ) return SendClientMessage( playerid, -1, "KORISTENJE /flight [report]");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /flight [report/cancel/view/accept/all]");
		return 1;
	}
	return 1;
}
