#include <YSI_Coding\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

#define MAX_RACING_CPS					(15)
#define MAX_RACING_CONTESTERS			(5)
#define RACING_CP_SIZE					6.5

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
enum E_RACING_DATA {
	rdContesters[ MAX_RACING_CONTESTERS ],
	Float:rdPosX[ MAX_RACING_CPS ],
	Float:rdPosY[ MAX_RACING_CPS ],
	Float:rdPosZ[ MAX_RACING_CPS ],
	rdFinished[ MAX_RACING_CONTESTERS ],
	rdCounter,
	bool:rdStarted,
	rdEndCP,
	Timer:rdTimer,
	rdFnsdRacers
}
static stock
	RacingInfo[ MAX_PLAYERS ][ E_RACING_DATA ];
	
// 32bit vars
static stock
	RacingDialogID[ MAX_PLAYERS ],
	RaceAuthor[ MAX_PLAYERS ],
	RacingCallID[ MAX_PLAYERS ],
	RacerSlot[ MAX_PLAYERS ],
	CurrentRaceCP[ MAX_PLAYERS ];
	
// rBits
static stock
	Bit1:gr_PlayerInRace<MAX_PLAYERS>,
	Bit1:gr_PlayerRaceCreated<MAX_PLAYERS>;
	
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static GetFreeRacingCPSlot(playerid) 
{
	new
		index = -1;
	for(new i=0; i < MAX_RACING_CPS; i++) {
		if( RacingInfo[ playerid ][ rdPosX ][ i ] == 0.0 ) {
			index = i;
			break;
		}
	}
	return index;
}
stock static GetLastRacingCPSlot(playerid)
{
	new
		index = 0;
	for(new i=0; i < MAX_RACING_CPS; i++) {
		if( RacingInfo[ playerid ][ rdPosX ][ i ] != 0.0 ) {
			index = i;
		}
	}
	return index;
}
stock static GetContestantFromPool(playerid)
{
	new
		index = -1;
	for(new i=0; i < MAX_RACING_CONTESTERS; i++) {
		if( RacingInfo[ playerid ][ rdContesters ][ i ] == -1 ) {
			index = i;
			break;
		}
	}
	return index;
}
stock static GetTotalContesters(playerid)
{
	new
		count = -1;
	for(new i=0; i < MAX_RACING_CONTESTERS; i++) {
		if( RacingInfo[ playerid ][ rdContesters ][ i ] != -1 ) {
			count++;
		}
	}
	return count;
}
stock static GetRacingCpPool(playerid)
{
	new
		count = 0;
	for(new i=0; i < MAX_RACING_CPS; i++) {
		if( RacingInfo[ playerid ][ rdPosX ][ i ] != 0.0 ) {
			count++;
		}
	}
	return count;
}
stock static SendRacingMessage(playerid, const message[])
{
	for(new i=0; i < MAX_RACING_CONTESTERS; i++) {
		if( Bit1_Get( gr_PlayerInRace, RacingInfo[ playerid ][ rdContesters ][ i ] ) ) {
			SendClientMessage(RacingInfo[ playerid ][ rdContesters ][ i ], COLOR_YELLOW, message);
		}
	}
	return 1;
}
stock static CreateRacingCP(playerid, Float:x, Float:y, Float:z)
{
	if( !IsPlayerConnected(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste se spojili na server!");
	new 
		index = GetFreeRacingCPSlot(playerid);	
	RacingInfo[ playerid ][ rdPosX ][ index ] = x;
	RacingInfo[ playerid ][ rdPosY ][ index ] = y;
	RacingInfo[ playerid ][ rdPosZ ][ index ] = z;
	return index;
}
stock static CallRaceContestant(playerid, giveplayerid)
{
	if( !IsPlayerConnected(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste se spojili na server!");
	if( !IsPlayerConnected(giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pozvani igrac nije na serveru!");
	new
		index = GetContestantFromPool(playerid);
	if( index == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise zvati igrace na svoju utrku!");
	RacingCallID[ giveplayerid ] = playerid;
	va_ShowPlayerDialog(giveplayerid, DIALOG_RACE_CALL, DIALOG_STYLE_MSGBOX, "RACING SYSTEM", "%s te poziva da dodjes u njegovu utrku. Zelite li uci?", "Yes", "No", GetName(playerid, false));
	return 1;
}
stock static StartPlayerRace(playerid)
{
	RacingInfo[ playerid ][ rdStarted ] = true;
	RacingInfo[ playerid ][ rdEndCP ]	= GetLastRacingCPSlot(playerid);
	RaceAuthor[ playerid ]				= playerid;
	RacerSlot[ playerid ]				= 0;
	RacingInfo[ playerid ][ rdCounter ] = 5;
	RacingInfo[ playerid ][ rdFnsdRacers ] = 0;
	for( new i=0; i < MAX_RACING_CONTESTERS; i++) {
		if( RacingInfo[ playerid ][ rdContesters ][ i ] != -1 ) {
			va_GameTextForPlayer(RacingInfo[ playerid ][ rdContesters ][ i ], "~y~%d", 1000, 4, RacingInfo[ playerid ][ rdCounter ]);
			PlayerPlaySound(RacingInfo[ playerid ][ rdContesters ][ i ], 1056, 0.0, 0.0, 0.0);
			TogglePlayerAllDynamicCPs(RacingInfo[ playerid ][ rdContesters ][ i ], false);
		}
	}
	RacingInfo[ playerid ][ rdTimer ] = repeat RacingCounter(playerid);
	return 1;
}
stock static ResetPlayerRaceCP(playerid, index)
{
	RacingInfo[ playerid ][ rdPosX ][ index ] = 0.0;
	RacingInfo[ playerid ][ rdPosY ][ index ] = 0.0;
	RacingInfo[ playerid ][ rdPosZ ][ index ] = 0.0;
}
stock ResetPlayerRace(playerid, bool:reset=false)
{
	RacingInfo[ playerid ][ rdContesters ][ 0 ] = -1;
	RacingInfo[ playerid ][ rdContesters ][ 1 ] = -1;
	RacingInfo[ playerid ][ rdContesters ][ 2 ] = -1;
	RacingInfo[ playerid ][ rdContesters ][ 3 ] = -1;

	RacingInfo[ playerid ][ rdFinished ][ 0 ] 	= -1;
	RacingInfo[ playerid ][ rdFinished ][ 1 ] 	= -1;
	RacingInfo[ playerid ][ rdFinished ][ 2 ] 	= -1;
	RacingInfo[ playerid ][ rdFinished ][ 3 ] 	= -1;
	
	RacingInfo[ playerid ][ rdCounter ] 		= 0;
	RacingInfo[ playerid ][ rdStarted ] 		= false;
	RacingInfo[ playerid ][ rdFnsdRacers ] 		= 0;

	Bit1_Set( gr_PlayerRaceCreated, playerid, false );

	if( reset ) {
		for( new i=0; i < MAX_RACING_CPS; i++ ) {
			if( RacingInfo[ playerid ][ rdPosX ][ i ] != 0.0 )
				ResetPlayerRaceCP(playerid, i);
		}
	}
}
stock ResetPlayerRacing(playerid)
{
	RacingDialogID[ playerid ]	= -1;
	RaceAuthor[ playerid ]		= -1;
	RacingCallID[ playerid ]	= -1;
	RacerSlot[ playerid ]		= -1;
	CurrentRaceCP[ playerid ]	= -1;
	Bit1_Set(gr_PlayerInRace, playerid, false);
	return 1;
}

// Timers

timer StopRacingSound[8000](playerid) 
{
	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
	return 1;
}

timer RacingCounter[1000](playerid) 
{
	for( new i=0; i < MAX_RACING_CONTESTERS; i++) 
	{
		if( RacingInfo[ playerid ][ rdContesters ][ i ] != -1 ) 
		{
			va_GameTextForPlayer(RacingInfo[ playerid ][ rdContesters ][ i ], "~y~%d", 1000, 4, RacingInfo[ playerid ][ rdCounter ]-1);
			PlayerPlaySound(RacingInfo[ playerid ][ rdContesters ][ i ], 1056, 0.0, 0.0, 0.0);
		}
	}
	
	RacingInfo[ playerid ][ rdCounter ]--;
	if( !RacingInfo[ playerid ][ rdCounter ] ) 
	{
		RacingInfo[ playerid ][ rdFinished ][ 0 ] 	= -1;
		RacingInfo[ playerid ][ rdFinished ][ 1 ] 	= -1;
		RacingInfo[ playerid ][ rdFinished ][ 2 ] 	= -1;
		RacingInfo[ playerid ][ rdFinished ][ 3 ] 	= -1;
	
		for( new i=0; i < MAX_RACING_CONTESTERS; i++) {
			if( RacingInfo[ playerid ][ rdContesters ][ i ] != -1 ) {
				GameTextForPlayer(RacingInfo[ playerid ][ rdContesters ][ i ], "~g~GO GO GO", 2500, 4);
				PlayerPlaySound(RacingInfo[ playerid ][ rdContesters ][ i ], 1057, 0.0, 0.0, 0.0);
				CurrentRaceCP[ RacingInfo[ playerid ][ rdContesters ][ i ] ] = 0;
				SetPlayerRaceCheckpoint(RacingInfo[ playerid ][ rdContesters ][ i ], 0, RacingInfo[ playerid ][ rdPosX ][ 0 ], RacingInfo[ playerid ][ rdPosY ][ 0 ], RacingInfo[ playerid ][ rdPosZ ][ 0 ], RacingInfo[ playerid ][ rdPosX ][ 1 ], RacingInfo[ playerid ][ rdPosY ][ 1 ], RacingInfo[ playerid ][ rdPosZ ][ 1 ], RACING_CP_SIZE);
			}
		}
		stop RacingInfo[ playerid ][ rdTimer ];
	}
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
hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit1_Get(gr_PlayerInRace, playerid) ) 
		Bit1_Set(gr_PlayerInRace, playerid, false);
	if( Bit1_Get( gr_PlayerRaceCreated, playerid ) ) 
	{
		SendRacingMessage(playerid, "[ ! ] Trka je zavrsila!");
		ResetPlayerRace(playerid, true);
		ResetPlayerRacing(playerid);
	}
	return 1;
}
hook OnPlayerEnterRaceCP(playerid)
{
	if( Bit1_Get( gr_PlayerInRace, playerid ) ) {
		new
			giveplayerid 	= RaceAuthor[ playerid ],
			currentCP 		= CurrentRaceCP[ playerid ];
		if( currentCP != RacingInfo[ giveplayerid ][ rdEndCP ] ) {
			PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
			currentCP++;
			if( currentCP == RacingInfo[ giveplayerid ][ rdEndCP ] ) {
				SetPlayerRaceCheckpoint(playerid, 1, RacingInfo[ giveplayerid ][ rdPosX ][ currentCP ], RacingInfo[ giveplayerid ][ rdPosY ][ currentCP ], RacingInfo[ giveplayerid ][ rdPosZ ][ currentCP ], 0.0, 0.0, 0.0, RACING_CP_SIZE);
			} else {
				SetPlayerRaceCheckpoint(playerid, 0, RacingInfo[ giveplayerid ][ rdPosX ][ currentCP ], RacingInfo[ giveplayerid ][ rdPosY ][ currentCP ], RacingInfo[ giveplayerid ][ rdPosZ ][ currentCP ], RacingInfo[ giveplayerid ][ rdPosX ][ currentCP+1 ], RacingInfo[ giveplayerid ][ rdPosY ][ currentCP+1 ], RacingInfo[ giveplayerid ][ rdPosZ ][ currentCP+1 ], RACING_CP_SIZE);
			}
			CurrentRaceCP[ playerid ] = currentCP;
		} else {
			
			printf("DEBUG: finish1(%d) | finish2(%d) | finish3(%d) | finish4(%d)", RacingInfo[ giveplayerid ][ rdFinished ][ 0 ], RacingInfo[ giveplayerid ][ rdFinished ][ 1 ], RacingInfo[ giveplayerid ][ rdFinished ][ 2 ], RacingInfo[ giveplayerid ][ rdFinished ][ 3 ]);
			
			if( RacingInfo[ giveplayerid ][ rdFinished ][ 0 ] == -1 ) {
				RacingInfo[ giveplayerid ][ rdFinished ][ 0 ] = playerid;
				
				new
					tmpString[ 54 ];
				format( tmpString, 54, "[ ! ] %s je zavrsio kao prvi!", GetName(playerid, false));
				SendRacingMessage(giveplayerid, tmpString);
			}
			else if( RacingInfo[ giveplayerid ][ rdFinished ][ 1 ] == -1 ) {
				RacingInfo[ giveplayerid ][ rdFinished ][ 1 ] = playerid;
				
				new
					tmpString[ 54 ];
				format( tmpString, 54, "[ ! ] %s je zavrsio kao drugi!", GetName(playerid, false));
				SendRacingMessage(giveplayerid, tmpString);
			}
			else if( RacingInfo[ giveplayerid ][ rdFinished ][ 2 ] == -1 ) {
				RacingInfo[ giveplayerid ][ rdFinished ][ 2 ] = playerid;
				
				new
					tmpString[ 54 ];
				format( tmpString, 54, "[ ! ] %s je zavrsio kao treci!", GetName(playerid, false));
				SendRacingMessage(giveplayerid, tmpString);
			}
			else if( RacingInfo[ giveplayerid ][ rdFinished ][ 3 ] == -1 ) {
				RacingInfo[ giveplayerid ][ rdFinished ][ 3 ] = playerid;
				
				new
					tmpString[ 54 ];
				format( tmpString, 54, "[ ! ] %s je zavrsio kao cetvrti!", GetName(playerid, false));
				SendRacingMessage(giveplayerid, tmpString);
			}	

			if( ++RacingInfo[ giveplayerid ][ rdFnsdRacers ] == GetTotalContesters(giveplayerid) ) {
				SendRacingMessage(giveplayerid, "[ ! ] Trka je zavrsila!");
				ResetPlayerRace(giveplayerid, true);
			}
			
			ResetPlayerRacing(playerid);
			Bit1_Set(gr_PlayerInRace, playerid, false);	
			TogglePlayerAllDynamicCPs(playerid, true);
			PlayerPlaySound(playerid, 1097, 0.0, 0.0, 0.0);
			defer StopRacingSound(playerid);
			DisablePlayerRaceCheckpoint(playerid);
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_RACE_MAIN: {
			if( !response ) return 1;
			switch( listitem ) {
				case 0: { // Dodaj
					new
						Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					new 
						index = GetFreeRacingCPSlot(playerid);
					if( index == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Popunili ste vas inventory!");
					SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dodali ste CP u slot %d!", CreateRacingCP(playerid, X, Y, Z)+1);
					Bit1_Set( gr_PlayerRaceCreated, playerid, true );
					if( RacingInfo[ playerid ][ rdContesters ][ 0 ] <= 0 ) {
						RacingInfo[ playerid ][ rdContesters ][ 0 ] = playerid;
						RacingInfo[ playerid ][ rdContesters ][ 1 ] = -1;
						RacingInfo[ playerid ][ rdContesters ][ 2 ] = -1;
						RacingInfo[ playerid ][ rdContesters ][ 3 ] = -1;
						
						RacingInfo[ playerid ][ rdFinished ][ 0 ] 	= -1;
						RacingInfo[ playerid ][ rdFinished ][ 1 ] 	= -1;
						RacingInfo[ playerid ][ rdFinished ][ 2 ] 	= -1;
						RacingInfo[ playerid ][ rdFinished ][ 3 ] 	= -1;
						RacingInfo[ playerid ][ rdStarted ]			= false;
					}
				}
				case 1: { // ObriSi
					new
						buffer[ 512 ];
					for( new i = 0; i < MAX_RACING_CPS; i++ ) {
						if( RacingInfo[ playerid ][ rdPosX ][ i ] != 0.0 )
							format(buffer, 512, "%s#%d | %s (%.2f, %.2f, %.2f)\n", buffer,i+1,GetXYZZoneName(RacingInfo[ playerid ][ rdPosX ][ i ],RacingInfo[ playerid ][ rdPosY ][ i ],RacingInfo[ playerid ][ rdPosZ ][ i ]),RacingInfo[ playerid ][ rdPosX ][ i ],RacingInfo[ playerid ][ rdPosY ][ i ],RacingInfo[ playerid ][ rdPosZ ][ i ]);
					}
					ShowPlayerDialog(playerid, DIALOG_RACE_DCP, DIALOG_STYLE_LIST, "RACING SYSTEM", buffer, "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_RACE_DCP: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_RACE_MAIN, DIALOG_STYLE_LIST, "RACING SYSTEM", "Dodaj checkpoint\nObrisi checkpoint", "Choose", "Abort");
			RacingDialogID[ playerid ] = listitem;
			va_ShowPlayerDialog(playerid, DIALOG_RACE_DCPS, DIALOG_STYLE_MSGBOX, "RACING SYSTEM - BRISANJE CPa", "Zelite li obrisati checkpoint u slotu %d?", "Yes", "No");
			return 1;
		}
		case DIALOG_RACE_DCPS: {
			if( !response ) {
				new
					buffer[ 512 ];
				for( new i = 0; i < MAX_RACING_CPS; i++ ) {
					if( RacingInfo[ playerid ][ rdPosX ][ i ] != 0.0 )
						format(buffer, 512, "%s#%d | %s (%.2f, %.2f, %.2f)\n", buffer,i+1,GetXYZZoneName(RacingInfo[ playerid ][ rdPosX ][ i ],RacingInfo[ playerid ][ rdPosY ][ i ],RacingInfo[ playerid ][ rdPosZ ][ i ]),RacingInfo[ playerid ][ rdPosX ][ i ],RacingInfo[ playerid ][ rdPosY ][ i ],RacingInfo[ playerid ][ rdPosZ ][ i ]);
				}
				ShowPlayerDialog(playerid, DIALOG_RACE_DCP, DIALOG_STYLE_LIST, "RACING SYSTEM", buffer, "Choose", "Abort");
				return 1;
			}
			ResetPlayerRaceCP(playerid, RacingDialogID[ playerid ]);
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Obrisali ste checkpoint u slotu #%d!", RacingDialogID[ playerid ]+1);
			RacingDialogID[ playerid ] = -1;
			
			if( !GetRacingCpPool(playerid) )
				Bit1_Set( gr_PlayerRaceCreated, playerid, false );
			return 1;
		}
		case DIALOG_RACE_CALL: {
			if( !response ) return 1;
			new
				giveplayerid = RacingCallID[ playerid ],
				index = GetContestantFromPool(giveplayerid);
			if( index == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je puna!");
			if( RacingInfo[ giveplayerid ][ rdStarted ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je vec pocela!");
			RacingInfo[ giveplayerid ][ rdContesters ][ index ] = playerid;
			RacerSlot[ playerid ] = index;
			va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] %s je prihvatio vas poziv za utrku! Za pokretanje utrke idite /race start.", GetName(playerid, true));
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Prihvatili ste poziv za trku od %s!", GetName(giveplayerid, true));
			Bit1_Set(gr_PlayerInRace, playerid, true);
			RaceAuthor[ playerid ] = giveplayerid;
			CurrentRaceCP[ playerid ] = 0;
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
CMD:race(playerid, params[])
{
	if( IsARacer(playerid) && PlayerInfo[playerid][pRank] >= FactionInfo[PlayerInfo[playerid][pMember]][rRace] ) {
		new
			param[ 8 ];
		if( sscanf( params, "s[8] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /race [menu/invite/start]");
		if( !strcmp(param, "menu", true) ) {
			ShowPlayerDialog(playerid, DIALOG_RACE_MAIN, DIALOG_STYLE_LIST, "RACING SYSTEM", "Dodaj checkpoint\nObrisi checkpoint", "Choose", "Abort");
		}
		else if( !strcmp(param, "invite", true) ) {
			new
				giveplayerid;
			if( sscanf( params, "s[8]i", param, giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /race invite [playerid/dio imena]");
			if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unijeli ste nevaljan playerid!");
			if( giveplayerid == playerid ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe zvati, vase je mjesto osigurano!");
			CallRaceContestant(playerid, giveplayerid);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste pozvali %s u utrku!", GetName(giveplayerid,true));
		}
		else if( !strcmp(param, "start", true) ) {
			if( RacingInfo[ playerid ][ rdPosX ][ 1 ] == 0.0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate dodati minimalno 2 CPa da mozete pokreniti trku!");
			if( RacingInfo[ playerid ][ rdStarted ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Utrka je vec pocela!");
			StartPlayerRace(playerid);
			Bit1_Set(gr_PlayerInRace, playerid, true);
		}
	} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik rejsera");
	return 1;

}
