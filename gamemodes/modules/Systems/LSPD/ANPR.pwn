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

stock static
	Bit1: gr_ANPRActiveted<MAX_PLAYERS> = { Bit1:false, ... },
	PlayerANPRTimer[MAX_PLAYERS],
	PlayerText:AnprBcg[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:AnprTitle[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:AnprInfo[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

forward ANPRTimer(playerid);
public ANPRTimer(playerid)
{
	static 
		Float:vX, Float:vY, Float:vZ,
		string[86];
		
	foreach(new i : COVehicles) {
		if(!IsPlayerInVehicle(playerid, i) && IsVehicleStreamedIn(i, playerid)) {
			GetVehiclePos(i, vX, vY, vZ);
			if(GetPlayerDistanceFromPoint(playerid, vX, vY, vZ) <= 20.0) {
				static 
					Float:fPX, Float:fPY, Float:fPZ,
					Float:fVX, Float:fVY, Float:fVZ;
				new count = 0;
				GetPlayerCameraPos(playerid, fPX, fPY, fPZ);
				GetPlayerCameraFrontVector(playerid, fVX, fVY, fVZ);
		 
				fPX += floatmul(fVX, 5.0);
				fPY += floatmul(fVY, 5.0);
				
				if(GetPlayerDistanceFromPoint(playerid, fPX, fPY, vZ) <= 15.0) {
					if( VehicleInfo[ i ][ vTickets ][ 0 ] != 0) 
						count++;
					if( VehicleInfo[ i ][ vTickets ][ 1 ] != 0) 
						count++;
					if( VehicleInfo[ i ][ vTickets ][ 2 ]  != 0) 
						count++;
					if( VehicleInfo[ i ][ vTickets ][ 3 ] != 0) 
						count++;
					if( VehicleInfo[ i ][ vTickets ][ 4 ] != 0) 
						count++;

					if(VehicleInfo[i][vNumberPlate][0] != '0')
					{
						format(string, sizeof(string), "~y~Registracija: ~w~%s~n~~y~Owner: ~w~%s~n~~y~Kazne: ~w~%d",
							VehicleInfo[ i ][ vNumberPlate ],
							GetPlayerNameFromSQL(VehicleInfo[ i ][ vOwnerID ]),
							count
						);
					
						PlayerTextDrawSetString(playerid,AnprInfo[playerid], string);
					}
					else
						PlayerTextDrawSetString(playerid,AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
					break;
				}
				else
					PlayerTextDrawSetString(playerid,AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
			}
			else
				PlayerTextDrawSetString(playerid, AnprInfo[playerid], "~y~Registracija: ~w~None~n~~y~Owner: ~w~None~n~~y~Kazne: ~w~0");
		}
	}
}

stock static CreateANPRTextDraw(playerid)
{
	DestroyANPRTextDraw(playerid);
	
	AnprBcg[playerid] = CreatePlayerTextDraw(playerid, 495.679992, 110.774696, "usebox");
	PlayerTextDrawLetterSize(playerid, AnprBcg[playerid], 0.000000, 7.082777);
	PlayerTextDrawTextSize(playerid, AnprBcg[playerid], 612.329895, 0.000000);
	PlayerTextDrawAlignment(playerid, AnprBcg[playerid], 1);
	PlayerTextDrawColor(playerid, AnprBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, AnprBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, AnprBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, AnprBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, AnprBcg[playerid], 0);
	PlayerTextDrawFont(playerid, AnprBcg[playerid], 0);
	PlayerTextDrawShow(playerid, AnprBcg[playerid]);

	AnprTitle[playerid] = CreatePlayerTextDraw(playerid, 555.439636, 109.834625, "~y~ANPR");
	PlayerTextDrawLetterSize(playerid, AnprTitle[playerid], 0.440879, 1.709013);
	PlayerTextDrawAlignment(playerid, AnprTitle[playerid], 2);
	PlayerTextDrawColor(playerid, AnprTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, AnprTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, AnprTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, AnprTitle[playerid], 51);
	PlayerTextDrawFont(playerid, AnprTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, AnprTitle[playerid], 1);
	PlayerTextDrawShow(playerid, AnprTitle[playerid]);

	AnprInfo[playerid] = CreatePlayerTextDraw(playerid, 497.840057, 130.367950, "~y~Registracija: ~w~None~n~~y~Trazen: ~g~Ne~n~~y~Kazne: ~w~0");
	PlayerTextDrawLetterSize(playerid, AnprInfo[playerid], 0.334319, 1.339414);
	PlayerTextDrawAlignment(playerid, AnprInfo[playerid], 1);
	PlayerTextDrawColor(playerid, AnprInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, AnprInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, AnprInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, AnprInfo[playerid], 51);
	PlayerTextDrawFont(playerid, AnprInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, AnprInfo[playerid], 1);
	PlayerTextDrawShow(playerid, AnprInfo[playerid]);
	return 1;
}

stock static DestroyANPRTextDraw(playerid)
{
	if( AnprBcg[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, AnprBcg[ playerid ]);
		AnprBcg[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( AnprTitle[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, AnprTitle[ playerid ]);
		AnprTitle[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( AnprInfo[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, AnprInfo[ playerid ]);
		AnprInfo[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##     ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit1_Get( gr_ANPRActiveted, playerid ) ) {
		DestroyANPRTextDraw(playerid);
		KillTimer(PlayerANPRTimer[playerid]);
		Bit1_Set( gr_ANPRActiveted, playerid, false );
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER ) {
		if( Bit1_Get( gr_ANPRActiveted, playerid ) ) {
			DestroyANPRTextDraw(playerid);
			KillTimer(PlayerANPRTimer[playerid]);
			Bit1_Set( gr_ANPRActiveted, playerid, false );
		}
	}
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
CMD:anpr(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	if( !IsInStateVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar sluzbenog vozila!");
	
	if( !Bit1_Get( gr_ANPRActiveted, playerid ) ) {
		CreateANPRTextDraw(playerid);
		PlayerANPRTimer[playerid] = SetTimerEx("ANPRTimer", 2000, true, "i", playerid);
		GameTextForPlayer(playerid, "~g~ANPR Active", 1500, 1);
		Bit1_Set( gr_ANPRActiveted, playerid, true );
		new
			tmpString[80];
		format(tmpString, sizeof(tmpString), "* %s pokre�e ANPR system.", GetName(playerid, true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if( Bit1_Get( gr_ANPRActiveted, playerid ) ) {
		DestroyANPRTextDraw(playerid);
		KillTimer(PlayerANPRTimer[playerid]);
		GameTextForPlayer(playerid, "~r~ANPR deactivated", 1500, 1);
		Bit1_Set( gr_ANPRActiveted, playerid, false );
		new
			tmpString[80];
		format(tmpString, sizeof(tmpString), "* %s isklju�uje ANPR system.", GetName(playerid, true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
