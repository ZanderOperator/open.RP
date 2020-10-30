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

#define IsPlayerAfk(%0) 		(MowTick[%0] < gettimestamp())
#define GRASSMOWER_ID 			(4)
#define MAX_MOWING_METERS		(100)

new MowTick[MAX_PLAYERS];

/*
	##     ##    ###    ########  
	##     ##   ## ##   ##     ## 
	##     ##  ##   ##  ##     ## 
	##     ## ##     ## ########  
	 ##   ##  ######### ##   ##   
	  ## ##   ##     ## ##    ##  
	   ###    ##     ## ##     ## 
*/

// TextDraws
static stock
	PlayerText:MowingBcg1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MowingBcg2[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MowingTitle[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:MowingText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };

// Player (32 bit)
static stock
	Timer:PlayerMowingAreaTimer[ MAX_PLAYERS ],
	PlayerMowingMeters[ MAX_PLAYERS ],
	Timer:PlayerMowingTask[ MAX_PLAYERS ],
	PlayerMowingIcon[ MAX_PLAYERS ];
	
// Player (rBits)
static stock
	Bit1: gr_PlayerWorkingMower <MAX_PLAYERS>,
	Bit1: gr_FirstEnter	<MAX_PLAYERS>;
	

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

stock static DestroyMowingTDs(playerid)
{
	if( MowingBcg1[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, MowingBcg1[ playerid ] );
		MowingBcg1[ playerid ]		= PlayerText:INVALID_TEXT_DRAW;
	}
	if( MowingBcg2[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, MowingBcg2[ playerid ] );
		MowingBcg2[ playerid ]		= PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( MowingTitle[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, MowingTitle[ playerid ] );
		MowingTitle[ playerid ]		= PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( MowingText[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, MowingText[ playerid ] );
		MowingText[ playerid ]		= PlayerText:INVALID_TEXT_DRAW;
	}
}

stock static CreateMowingTDs(playerid)
{
	DestroyMowingTDs(playerid);
	MowingBcg1[playerid] = CreatePlayerTextDraw(playerid, 627.549804, 101.907981, "usebox");
	PlayerTextDrawLetterSize(playerid, MowingBcg1[playerid], 0.000000, 4.738887);
	PlayerTextDrawTextSize(playerid, MowingBcg1[playerid], 492.599975, 0.000000);
	PlayerTextDrawAlignment(playerid, MowingBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, MowingBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, MowingBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, MowingBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, MowingBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MowingBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, MowingBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, MowingBcg1[playerid]);

	MowingBcg2[playerid] = CreatePlayerTextDraw(playerid, 628.000122, 100.843994, "usebox");
	PlayerTextDrawLetterSize(playerid, MowingBcg2[playerid], 0.000000, 1.674444);
	PlayerTextDrawTextSize(playerid, MowingBcg2[playerid], 492.699951, 0.000000);
	PlayerTextDrawAlignment(playerid, MowingBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, MowingBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, MowingBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, MowingBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, MowingBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MowingBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, MowingBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, MowingBcg2[playerid]);

	MowingTitle[playerid] = CreatePlayerTextDraw(playerid, 500.100158, 102.872001, "KOSNJA");
	PlayerTextDrawLetterSize(playerid, MowingTitle[playerid], 0.368449, 1.070799);
	PlayerTextDrawAlignment(playerid, MowingTitle[playerid], 1);
	PlayerTextDrawColor(playerid, MowingTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MowingTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MowingTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MowingTitle[playerid], 51);
	PlayerTextDrawFont(playerid, MowingTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MowingTitle[playerid], 1);
	PlayerTextDrawShow(playerid, MowingTitle[playerid]);

	MowingText[playerid] = CreatePlayerTextDraw(playerid, 499.899993, 124.935997, "Metara pokoseno: 50m");
	PlayerTextDrawLetterSize(playerid, MowingText[playerid], 0.284099, 1.013680);
	PlayerTextDrawAlignment(playerid, MowingText[playerid], 1);
	PlayerTextDrawColor(playerid, MowingText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MowingText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MowingText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MowingText[playerid], 51);
	PlayerTextDrawFont(playerid, MowingText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MowingText[playerid], 1);
	PlayerTextDrawShow(playerid, MowingText[playerid]);
}

stock InitMowerJob(playerid)
{
	if( GetVehicleModel( GetPlayerVehicleID(playerid) ) != 572 ) return SendClientMessage( playerid, COLOR_RED, "Morate biti unutar Mowera!");
	
	Bit1_Set( gr_PlayerWorkingMower, playerid, true );
	PlayerMowingMeters[ playerid ] = 0;
	Bit1_Set( gr_FirstEnter, playerid, false );
	
	SendClientMessage( playerid, COLOR_RED, "[ ! ] Udjite u prostor Glen Parka za pocetak!");
	PlayerMowingAreaTimer[ playerid ] = defer IsPlayerInMowingArea(playerid);
	return 1;
}

stock DestroyMowerVars(playerid)
{
	DestroyMowingTDs(playerid);
	DestroyDynamicMapIcon( PlayerMowingIcon[ playerid ] );
	
	Bit1_Set( gr_PlayerWorkingMower, playerid, false );
	Bit1_Set( gr_FirstEnter, playerid, false );
	PlayerMowingMeters[ playerid ] = 0;
	
	stop PlayerMowingAreaTimer[ playerid ];
	stop PlayerMowingTask[ playerid ];
	return 1;
}

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

timer IsPlayerInMowingArea[600](playerid)
{
	if( !IsPlayerInRangeOfPoint(playerid, 100.0, 1974.7498, -1199.3864, 17.9950) ) 
	{
		stop PlayerMowingAreaTimer[ playerid ] );
		PlayerMowingIcon[ playerid ] = CreateDynamicMapIcon(1969.8916, -1197.4928, 24.6977, 11, COLOR_WHITE, -1, -1, playerid);
		Streamer_Update(playerid);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Imate 30 sekundi da udjete u prostor Glen Parka!");
		defer OnPlayerIsntInMowingArea(playerid);
	} 
	else 
	{
		if( !Bit1_Get( gr_FirstEnter, playerid ) ) {
			if( GetVehicleModel( GetPlayerVehicleID(playerid) ) != 572 ) return SendClientMessage( playerid, COLOR_RED, "Morate biti unutar Mowera!");
			DestroyDynamicMapIcon(PlayerMowingIcon[ playerid ]);
			CreateMowingTDs(playerid);
			
			new
				tmpString[ 32 ];
			format( tmpString, 32, "Metara pokoseno: %dm", 
				PlayerMowingMeters[ playerid ]
			);
			PlayerTextDrawSetString( playerid, MowingText[playerid], tmpString );
			
			GameTextForPlayer(playerid, "~y~Krenite s kosnjom", 2500, 1);
			stop PlayerMowingAreaTimer[ playerid ];
			PlayerMowingTask[ playerid ] = repeat OnPlayerMowing(playerid);
			Bit1_Set( gr_FirstEnter, playerid, true );
		}
	}
	return 1;
}

timer OnPlayerIsntInMowingArea[30000](playerid)
{
	if( !IsPlayerInRangeOfPoint(playerid, 100.0, 1974.7498, -1199.3864, 17.9950) ) 
	{
		Bit1_Set( gr_PlayerWorkingMower, playerid, false );
		
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste usli u predvidjen prostor za kosnju unutar 30 sekundi i prestali ste raditi posao!");
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		
		DestroyMowingTDs(playerid);
		PlayerInfo[playerid][pFreeWorks] -= 5;
	} 
	else PlayerMowingAreaTimer[ playerid ] = defer IsPlayerInMowingArea(playerid);
}

timer OnPlayerMowing[2000](playerid)
{
	/*if( IsPlayerPaused(playerid) || GetPlayerPausedTime(playerid) < 0 )
		return 1;
	*/
	if( IsPlayerInRangeOfPoint(playerid, 100.0, 1974.7498, -1199.3864, 17.9950) && 
		GetVehicleModel( GetPlayerVehicleID(playerid) ) == 572 ) {
		if( GetPlayerSpeed(playerid, true) > 0.5 ) {
			if(!IsPlayerAfk(playerid)) {
				PlayerMowingMeters[ playerid ]++;
				new
					tmpString[ 32 ];
				format( tmpString, 32, "Metara pokoseno: %dm", 
					PlayerMowingMeters[ playerid ]
				);
				PlayerTextDrawSetString( playerid, MowingText[playerid], tmpString );
				
				if( PlayerMowingMeters[ playerid ] >= MAX_MOWING_METERS ) 
				{
					// Placa
					new money = (PlayerMowingMeters[ playerid ] * 3) + (GetPlayerSkillLevel(playerid, 4) * 25);
					va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);
					BudgetToPlayerBankMoney(playerid, money);  // dobiva novac na knjizicu iz proracuna
					PlayerInfo[playerid][pPayDayMoney] += money;
					PlayerInfo[playerid][pFreeWorks] -= 5;
					
					UpgradePlayerSkill(playerid,4);
					DestroyMowerVars(playerid);
					SetVehicleToRespawn( GetPlayerVehicleID(playerid) );
				}
			}
		}
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
hook OnPlayerUpdate(playerid)
{
	if(Bit1_Get( gr_PlayerWorkingMower, playerid ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			MowTick[playerid] = gettimestamp();
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if( oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT ) {
		if( Bit1_Get( gr_PlayerWorkingMower, playerid ) ) {
			DestroyMowerVars(playerid);
			SendClientMessage( playerid, COLOR_RED, "[ ! ] Izasli ste iz vozila i prestali raditi posao!");
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
CMD:mow(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pJob ] != GRASSMOWER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni kao kosac trave!");
	if( !Bit1_Get( gr_PlayerWorkingMower, playerid ) ) {		// Ne radi kao kosac
		new
			vehicleid = GetPlayerVehicleID(playerid);
			
		if( VehicleInfo[ vehicleid ][ vJob ] != GRASSMOWER_ID || GetVehicleModel(vehicleid) != 572 ) return SendClientMessage( playerid, COLOR_RED, "Morate biti u kosilici!");
		if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi, pricekajte Pay Day!");
		InitMowerJob(playerid);
	} else {
		DestroyMowingTDs(playerid);
				
		// Placa
		new money = ( PlayerMowingMeters[ playerid ] * 3 ) + (GetPlayerSkillLevel(playerid,4) * 25);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);
		
		BudgetToPlayerBankMoney(playerid, money); // dobiva novac na knjizicu iz proracuna
		PlayerInfo[playerid][pPayDayMoney] += money;
		PlayerInfo[playerid][pFreeWorks] 	-= 5;
		UpgradePlayerSkill(playerid,4);
		// Area
		Bit1_Set( gr_PlayerWorkingMower, playerid, false );
		
		// Podaci
		PlayerMowingMeters[ playerid ] = 0;
		stop PlayerMowingAreaTimer[ playerid ];
		stop PlayerMowingTask[ playerid ];
		SetVehicleToRespawn( GetPlayerVehicleID(playerid) );
	}
	return 1;
}
