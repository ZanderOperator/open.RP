#include <YSI\y_hooks>

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
#define RUDAR_ID			(8)

enum E_MINING_DATA {
	PlayerBar:MiningBar,
	Float:Progress,
	CrowBarObj,
	PickUpArrow,
	MiningRepetition,
	RandomGoldWeight,
	GoldGrams
};
new 
	MiningInfo[MAX_PLAYERS][E_MINING_DATA];

// Timers

new XSignExpiresTimer[ MAX_PLAYERS ],
	DelayTimer[ MAX_PLAYERS ],
	LoadingTimer[ MAX_PLAYERS ];


// Stock varijable
	
stock static
		// rBits
		Bit1: gr_IsPlayerMining < MAX_PLAYERS >,
		Bit1: gr_Minerwork <MAX_PLAYERS>,
		Bit1: gr_IsPlayerSpacePressing < MAX_PLAYERS >,
		RandomArrowPos[ MAX_PLAYERS ],
		ClothesPickUp;

stock static
	PlayerText:MainPicture[	MAX_PLAYERS	]                	= { PlayerText:INVALID_TEXT_DRAW, ...}, // 0
	PlayerText:ProgressBck[	MAX_PLAYERS	]					= { PlayerText:INVALID_TEXT_DRAW, ...}, // 1
	PlayerText:ProgressText[ MAX_PLAYERS ]					= { PlayerText:INVALID_TEXT_DRAW, ...};
			
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static CreateRandomMovingTextDraw(playerid)
{
	new Float:x = random( 600 );
	new Float:y = random( 430 );
    MainPicture[playerid] = CreatePlayerTextDraw(playerid, x, y, "ld_beat:cross");
	PlayerTextDrawLetterSize(playerid, 		MainPicture[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, 		MainPicture[playerid], 30.000000, 28.622222);
	PlayerTextDrawAlignment(playerid, 		MainPicture[playerid], 1);
	PlayerTextDrawColor(playerid, 			MainPicture[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		MainPicture[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		MainPicture[playerid], 0);
	PlayerTextDrawFont(playerid, 			MainPicture[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, 	MainPicture[playerid], true);
	PlayerTextDrawShow(playerid, 			MainPicture[playerid]);
	
	XSignExpiresTimer[playerid] = SetTimerEx("XSignExpires", 1500, false, "i", playerid);
}		
	
stock static CreateProgressBarBackGround(playerid)
{
	ProgressBck[playerid] = CreatePlayerTextDraw( playerid, 44.666625, 288.544448, "usebox");
	PlayerTextDrawLetterSize(playerid,		ProgressBck[playerid], 1.000000, 1.901440);
	PlayerTextDrawTextSize(playerid, 		ProgressBck[playerid], 107.333343, 0.000000);
	PlayerTextDrawAlignment(playerid, 		ProgressBck[playerid], 1);
	PlayerTextDrawColor(playerid, 			ProgressBck[playerid], 102);
	PlayerTextDrawUseBox(playerid, 			ProgressBck[playerid], true);
	PlayerTextDrawBoxColor(playerid, 		ProgressBck[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 		ProgressBck[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		ProgressBck[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, ProgressBck[playerid], 255);
	PlayerTextDrawFont(playerid, 			ProgressBck[playerid], 0);
	PlayerTextDrawShow(playerid, 			ProgressBck[playerid]);
	
	ProgressText[playerid] = CreatePlayerTextDraw( playerid, 52.000039, 288.680053, "Progress");
	PlayerTextDrawLetterSize(playerid, 		ProgressText[playerid], 0.432800, 0.946960);
	PlayerTextDrawAlignment(playerid, 		ProgressText[playerid], 1);
	PlayerTextDrawColor(playerid, 			ProgressText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		ProgressText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		ProgressText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ProgressText[playerid], 51);
	PlayerTextDrawFont(playerid, 			ProgressText[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ProgressText[playerid], 1);
	PlayerTextDrawShow(playerid, 			ProgressText[playerid]);
	
}
	
forward Delay(playerid);
public Delay(playerid)
{
	CreateRandomMovingTextDraw( playerid );
}

forward XSignExpires(playerid);
public XSignExpires(playerid)
{
    PlayerTextDrawDestroy( playerid, MainPicture[ playerid ] );
    SetTimerEx( "Delay", random( 1000 ), false, "i", playerid );
 	MiningInfo[ playerid ][ Progress ]	= GetPlayerProgressBarValue( playerid, MiningInfo[ playerid ][ MiningBar ] );
 	SetPlayerProgressBarValue( playerid, MiningInfo[ playerid ][ MiningBar ], MiningInfo[ playerid ][ Progress ] - 0.5 );
}

forward GoldLoading(playerid);
public GoldLoading(playerid)
{
	new
		money = MiningInfo[playerid][GoldGrams] * 2;
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);

	ClearAnimations(playerid);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
	BudgetToPayDayMoney(playerid, money); // dobiva novac na knjizicu iz proracuna
	PlayerInfo[playerid][pFreeWorks] 	-= 5;
	Bit1_Set(gr_Minerwork, playerid, false);
	MiningInfo[playerid][GoldGrams] = 0;
	MiningInfo[playerid][RandomGoldWeight] = 0;
	MiningInfo[playerid][MiningRepetition] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
	Bit1_Set ( gr_IsPlayerMining, playerid, false );
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
	ClothesPickUp = CreateDynamicPickup(1275, 1, 1993.6105, -265.2902, 966.2910, -1, -1, -1, 50.0);
	CreateDynamic3DTextLabel("/loadgold", -1, 1993.6583, -260.7966, 966.2866, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 50.0);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( newkeys & KEY_YES && PlayerInfo[playerid][pJob] == RUDAR_ID )
	{
		if(IsPlayerInRangeOfPoint( playerid, 10.0, 283.7016, -592.9161, 1702.4358 ) ) // /startmining koordinate
		{
			if ( Bit1_Get( gr_IsPlayerMining, playerid )) return GameTextForPlayer(playerid, "~r~Vec ste podigli kramp i poceli s poslom", 3000, 3);
			if ( MiningInfo[ playerid ][ MiningRepetition ] == 4 ) return GameTextForPlayer(playerid, "~g~Vec ste iskopali zlato. Koristite /loadgold", 3000, 3); 
			//ShowPlayerDialog( playerid, DIALOG_MINER, DIALOG_STYLE_LIST, "Nacin rada", "Pritiskanje random TD-a\nRapid space press", "Kreni", "Odustani");
			ApplyAnimationEx( playerid, "BASEBALL", "Bat_1", 4.1, 0, 0, 0, 0, 0, 1, 0 );
			
			if( IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]) )
				DestroyDynamicObject( MiningInfo[ playerid ][ PickUpArrow ] );
			
			SetPlayerAttachedObject( playerid, 1, 18634, 6, 0.0, 0.0, 0.0, 90 );
			Bit1_Set ( gr_IsPlayerMining, playerid, true );
			Bit1_Set ( gr_IsPlayerSpacePressing, playerid, true );
			CreateProgressBarBackGround( playerid );
			MiningInfo[ playerid ][ MiningBar ] = CreatePlayerProgressBar( playerid, 50.0, 300.0, 55.5, 4.2, -1429936641, 100.0 );
			ShowPlayerProgressBar( playerid, MiningInfo[ playerid ][ MiningBar ] );
			PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
		}
	}
	if( newkeys & KEY_SPRINT  && PlayerInfo[playerid][pJob] == RUDAR_ID ) {
		if ( Bit1_Get( gr_IsPlayerSpacePressing, playerid)) {
			if (MiningInfo[playerid][Progress] < 98.0) {
				MiningInfo[playerid][Progress]	= GetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar]);
				SetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar], MiningInfo[playerid][Progress] + 0.5);
				ApplyAnimationEx( playerid, "BASEBALL", "Bat_1", 4.1, 0, 0, 0, 0, 0, 1, 0 );
			} else {
				new string[13];
				SetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar], 0.0);
				DestroyPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]);
				PlayerTextDrawDestroy(playerid, ProgressBck[playerid]);
				PlayerTextDrawDestroy(playerid, ProgressText[playerid]);
				
				MiningInfo[playerid][Progress] = 0.0;
				ClearAnimations(playerid);
				ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
				MiningInfo[playerid][RandomGoldWeight] = minrand(55, 65);
				MiningInfo[playerid][GoldGrams] = MiningInfo[playerid][GoldGrams] + MiningInfo[playerid][RandomGoldWeight];
				format(string, sizeof(string), "~w~+%i gram", MiningInfo[playerid][RandomGoldWeight]);
				GameTextForPlayer(playerid, string, 4000, 6);
				
				// RandomArrowPos[ playerid ] = random( 18 );
				if(!IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]))
					MiningInfo[ playerid ][ PickUpArrow ] = CreateDynamicObject( 1318, 1508.6656,-777.5751,1081.0875, 0, 0, 0, -1, -1, playerid );
				MiningInfo[ playerid ][ MiningRepetition ] ++;
				Bit1_Set ( gr_IsPlayerMining, playerid, false );
				Bit1_Set ( gr_IsPlayerSpacePressing, playerid, false );
				
				if( MiningInfo[ playerid ][ MiningRepetition ] == 4 ) {
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno si dovrsio s kopanjem zlata. Koristi /loadgold kod pickupa da bi zavrsio posao.");
					return 1;
				}
				else SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno si zavrsio s ovim komadom zlata, kreni do drugog grumena zlata.");
			}
		}
	}
	return 1;
}
	

/*hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == MainPicture[playerid])
	{
        PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
        DelayTimer[playerid] = SetTimerEx("Delay", random(1000), false, "i", playerid);
        KillTimer(XSignExpiresTimer[playerid]);
        if(MiningInfo[playerid][Progress] < 98.0) {
        	MiningInfo[playerid][Progress]	= GetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar]);
        	SetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar], MiningInfo[playerid][Progress] + 1.3);
 		} else {
			new string[13];
	 	    SetPlayerProgressBarValue(playerid, MiningInfo[playerid][MiningBar], 0.0); 
			DestroyPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]);
			PlayerTextDrawDestroy(playerid, ProgressBck[playerid]);
			PlayerTextDrawDestroy(playerid, ProgressText[playerid]);
			KillTimer(DelayTimer[playerid]);
			KillTimer(XSignExpiresTimer[playerid]);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno si zavrsio s poslom, kreni do drugog grumena zlata.");
			PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
			PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
			MiningInfo[playerid][Progress] = 0.0;
			CancelSelectTextDraw(playerid);
			ClearAnimations(playerid);
			MiningInfo[playerid][RandomGoldWeight] = minrand(100, 150);
			MiningInfo[playerid][GoldGrams] = MiningInfo[playerid][GoldGrams] + MiningInfo[playerid][RandomGoldWeight];
			format(string, sizeof(string), "~w~+%i gram", MiningInfo[playerid][RandomGoldWeight]);
			GameTextForPlayer(playerid, string, 4000, 6);
			
			if(MiningInfo[playerid][MiningRepetition] == 4) return;
			
			RandomArrowPos[playerid] = random(18);
			MiningInfo[playerid][PickUpArrow] = CreateDynamicObject(1318, 1508.6656,-777.5751,1081.0875, 0, 0, 0, -1, -1, playerid);
			MiningInfo[playerid][MiningRepetition] ++;
			Bit1_Set ( gr_IsPlayerMining, playerid, false );
			Bit1_Set ( gr_IsPlayerSpacePressing, playerid, false );
		}
	}
	return 1;	
}*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) {
		case DIALOG_MINER: {
			if( response ) {
				switch( listitem ) {
					case 0: {
						SelectTextDraw( playerid, 0x878787FF );
						CreateRandomMovingTextDraw( playerid );
						SetPlayerAttachedObject( playerid, 1, 18634, 6, 0.0, 0.0, 0.0, 90 );
						ApplyAnimationEx( playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1, 0 );
						
						if( IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]) ) {
							DestroyDynamicObject( MiningInfo[ playerid ][ PickUpArrow ] );
							MiningInfo[ playerid ][ PickUpArrow ] = INVALID_OBJECT_ID;
						}
						
						Bit1_Set ( gr_IsPlayerMining, playerid, true );
						CreateProgressBarBackGround( playerid );
						MiningInfo[ playerid ][ MiningBar ] = CreatePlayerProgressBar( playerid, 50.0, 300.0, 55.5, 4.2, -1429936641, 100.0 );
						ShowPlayerProgressBar( playerid, MiningInfo[ playerid ][ MiningBar ] );
					}
					case 1: {
						ApplyAnimationEx( playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1, 0 );
												
						if( IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]) ) {
							DestroyDynamicObject( MiningInfo[ playerid ][ PickUpArrow ] );
							MiningInfo[ playerid ][ PickUpArrow ] = INVALID_OBJECT_ID;
						}
						
						SetPlayerAttachedObject( playerid, 1, 18634, 6, 0.0, 0.0, 0.0, 90 );
						Bit1_Set ( gr_IsPlayerMining, playerid, true );
						Bit1_Set ( gr_IsPlayerSpacePressing, playerid, true );
						CreateProgressBarBackGround( playerid );
						MiningInfo[ playerid ][ MiningBar ] = CreatePlayerProgressBar( playerid, 50.0, 300.0, 55.5, 4.2, -1429936641, 100.0 );
						ShowPlayerProgressBar( playerid, MiningInfo[ playerid ][ MiningBar ] );
					}
				}
			}
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	KillTimer(XSignExpiresTimer[playerid]);
	KillTimer(DelayTimer[playerid]);
	MiningInfo[playerid][Progress] = 0.0;
	MiningInfo[playerid][MiningRepetition] = 0;
	MiningInfo[playerid][RandomGoldWeight] = 0;
	MiningInfo[playerid][GoldGrams] = 0;
	RemovePlayerAttachedObject(playerid, 1);
	Bit1_Set ( gr_IsPlayerMining, playerid, false );
	Bit1_Set ( gr_IsPlayerSpacePressing, playerid, false );
	PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
							
	if( IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]) ) {
		DestroyDynamicObject( MiningInfo[ playerid ][ PickUpArrow ] );
		MiningInfo[ playerid ][ PickUpArrow ] = INVALID_OBJECT_ID;
	}
	
	if( IsValidPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]) )
		DestroyPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]);
		
	KillTimer(LoadingTimer[playerid]);
    ClearAnimations(playerid);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1, 0);
	PlayerTextDrawDestroy(playerid, ProgressText[playerid]);
	PlayerTextDrawDestroy(playerid, ProgressBck[playerid]);
	return 1;
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

CMD:startmining(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pJob ] != RUDAR_ID ) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rudar!");
	if( !IsPlayerInRangeOfPoint( playerid, 15.0,  283.7016, -592.9161, 1702.4358 ) ) return SendClientMessage( playerid, COLOR_RED, "Ne nalazis se na mjestu za uzimanje odore.");
	if(Bit1_Get(gr_Minerwork, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec radis posao rudara.");
	if( MiningInfo[ playerid ][ MiningRepetition ] > 0) return SendClientMessage( playerid, COLOR_RED, "Prvo istovarite sto se iskoristili pa onda nastavite!");
	if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 )		return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
	MiningInfo[ playerid ][ PickUpArrow ] = CreateDynamicObject( 1318, 283.5029, -592.5479, 1701.8474, 0, 0, 0, -1, -1, playerid );
	SendClientMessage( playerid, COLOR_RED, "[ ! ] Krenuli ste s poslom, nadjite prvi upotrebljivi komad zlata za obradu.");
	SendClientMessage( playerid, COLOR_RED, "[ ! ] Kada dodjete do obradivog grumena pritisnite Y.");
	Bit1_Set(gr_Minerwork, playerid, true);
	return 1;
}
CMD:stopmining(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pJob ] != RUDAR_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rudar!");
	if(!Bit1_Get(gr_Minerwork, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne radis posao rudara!");
	KillTimer(XSignExpiresTimer[playerid]);
	KillTimer(DelayTimer[playerid]);
	MiningInfo[playerid][Progress] = 0.0;
	MiningInfo[playerid][MiningRepetition] = 0;
	MiningInfo[playerid][RandomGoldWeight] = 0;
	MiningInfo[playerid][GoldGrams] = 0;
	RemovePlayerAttachedObject(playerid, 1);
	Bit1_Set ( gr_Minerwork, playerid, false );
	Bit1_Set ( gr_IsPlayerMining, playerid, false );
	Bit1_Set ( gr_IsPlayerSpacePressing, playerid, false );
	PlayerTextDrawDestroy(playerid, MainPicture[playerid]);
							
	if( IsValidDynamicObject(MiningInfo[ playerid ][ PickUpArrow ]) ) {
		DestroyDynamicObject( MiningInfo[ playerid ][ PickUpArrow ] );
		MiningInfo[ playerid ][ PickUpArrow ] = INVALID_OBJECT_ID;
	}
	
	if( IsValidPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]) )
		DestroyPlayerProgressBar(playerid, MiningInfo[playerid][MiningBar]);
		
	KillTimer(LoadingTimer[playerid]);
    ClearAnimations(playerid);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1, 0);
	PlayerTextDrawDestroy(playerid, ProgressText[playerid]);
	PlayerTextDrawDestroy(playerid, ProgressBck[playerid]);
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste prekinuli turu posla rudara.");
	return 1;
}
CMD:loadgold(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pJob ] != RUDAR_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rudar!");
	if( MiningInfo[ playerid ][ MiningRepetition ] < 4 ) return SendClientMessage( playerid, COLOR_RED, "Ne mozete istovariti zlato jer niste odradili do kraja!");
	if( !IsPlayerInRangeOfPoint( playerid, 5.0, 268.7209, -590.4112, 1702.4358 ) ) return SendClientMessage( playerid, COLOR_RED, "Ne nalazis se na mjestu za utovar zlata (kod kolica)!");
	if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 )		return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
	new LoadingRandomTime = minrand(30000, 60000 );
	GameTextForPlayer( playerid, "~w~Utovar zlata je u tijeku, pricekajte...", LoadingRandomTime, 6 );
	LoadingTimer[ playerid ] = SetTimerEx( "GoldLoading", LoadingRandomTime, false, "i", playerid );
	ApplyAnimationEx( playerid, "CARRY", "putdwn", 4.1, 1, 0, 0, 0, 0, 1, 0);
	return 1;
}