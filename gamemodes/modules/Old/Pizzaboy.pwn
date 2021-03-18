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

// Pizza Object
static stock
		Float:PizzaPos[][3] = {
			{ 0.00, 0.53, -0.00 },
			{ 0.07, 0.53, -0.00 },
			{ 0.14, 0.53, -0.00 }
	};

// rBits
stock
		Bit1: 	gr_UsingPizzaSkin	<MAX_PLAYERS>,
		Bit1:	gr_FirstUsing		<MAX_PLAYERS>,
		Bit8: 	gr_PlayerPizzas 	<MAX_PLAYERS>,
		Bit8:	gr_PlayerPizzasTotal<MAX_PLAYERS>,
		Bit16:	gr_LastPizzaCrib 	<MAX_PLAYERS>;

// Vars
stock
		PizzaCP,
		Float:PizzaHousePos[MAX_PLAYERS][3],
		PizzaHouseCP[MAX_PLAYERS char];
		
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

CreatePlayerPizzas(playerid)
{
	SetPlayerArmedWeapon(playerid,0);
	switch( Bit8_Get( gr_PlayerPizzas, playerid ) ) {
		case 1:
			SetPlayerAttachedObject(playerid, 9, 1582, 1, PizzaPos[ 0 ][ 0 ], PizzaPos[ 0 ][ 1 ], PizzaPos[ 0 ][ 2 ], 0.0, 90.0, 0.0);
		case 2: {
			SetPlayerAttachedObject(playerid, 9, 1582, 1, PizzaPos[ 0 ][ 0 ], PizzaPos[ 0 ][ 1 ], PizzaPos[ 0 ][ 2 ], 0.0, 90.0, 0.0);
			SetPlayerAttachedObject(playerid, 8, 1582, 1, PizzaPos[ 1 ][ 0 ], PizzaPos[ 1 ][ 1 ], PizzaPos[ 1 ][ 2 ], float(random(10)), 90.0, 0.0);
		}
		case 3 .. 8: {
			SetPlayerAttachedObject(playerid, 9, 1582, 1, PizzaPos[ 0 ][ 0 ], PizzaPos[ 0 ][ 1 ], PizzaPos[ 0 ][ 2 ], 0.0, 90.0, 0.0);
			SetPlayerAttachedObject(playerid, 8, 1582, 1, PizzaPos[ 1 ][ 0 ], PizzaPos[ 1 ][ 1 ], PizzaPos[ 1 ][ 2 ], float(random(10)), 90.0, 0.0);
			SetPlayerAttachedObject(playerid, 7, 1582, 1, PizzaPos[ 2 ][ 0 ], PizzaPos[ 2 ][ 1 ], PizzaPos[ 2 ][ 2 ], float(random(10)), 90.0, 0.0);
		}
	}
	
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}

PizzaRandom(playerid) {
	new cp;
    loop_start:
    cp = Iter_Random(Houses);

	if( Bit16_Get( gr_LastPizzaCrib, playerid ) == cp )
	    goto loop_start;
	else
		return cp;
	return 1;
}

CheckPlayerPizzas(playerid) {
	Bit8_Set( gr_PlayerPizzas, playerid, Bit8_Get( gr_PlayerPizzas, playerid ) - 1 );
	
	if( !Bit8_Get( gr_PlayerPizzas, playerid ) ) {
		DisablePlayerCheckpoint(playerid);
		PizzaHouseCP{playerid} =  0;
		Bit16_Set( gr_LastPizzaCrib, playerid, INVALID_HOUSE_ID );
		
		PizzaHousePos[playerid][0] = 0.0;
		PizzaHousePos[playerid][1] = 0.0;
		PizzaHousePos[playerid][2] = 0.0;
		
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Zavrsio si s dostavljanjem pizza!");
		new money = (Bit8_Get( gr_PlayerPizzasTotal, playerid ) * 60) + (GetPlayerSkillLevel(playerid, 1) * 25);	
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Zaradio si $%d, placa ti je sjela na racun.", money);
		BudgetToPlayerBankMoney(playerid, money); // dobiva novac na knjizicu iz proracuna
		PlayerInfo[playerid][pPayDayMoney] += money;
		Bit1_Set( gr_IsWorkingJob, playerid, false );
		
		UpgradePlayerSkill(playerid, 1);
        Bit8_Set( gr_PlayerPizzas, playerid, 0 );
		Bit8_Set( gr_PlayerPizzasTotal, playerid, 0 );
        PlayerInfo[playerid][pFreeWorks] -= 5;
		
		foreach(new i : Houses) {
			TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], true);
		}
		TogglePlayerAllDynamicCPs(playerid, true);
		return 1;
	}
	Create_PizzaCheckpoint(playerid);
	return (true);
}

Create_PizzaCheckpoint(playerid) {
	new	
		houseid = PizzaRandom(playerid);
	
	DisablePlayerCheckpoint(playerid);
	PizzaHouseCP{playerid} = 10;
	SetPlayerCheckpoint(playerid,HouseInfo[houseid][hEnterX],HouseInfo[houseid][hEnterY],HouseInfo[houseid][hEnterZ], 6.0);
	
	PizzaHousePos[playerid][0] = HouseInfo[houseid][hEnterX];
	PizzaHousePos[playerid][1] = HouseInfo[houseid][hEnterY];
	PizzaHousePos[playerid][2] = HouseInfo[houseid][hEnterZ];
	Bit16_Set( gr_LastPizzaCrib, playerid, houseid );
	return (true);
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

hook OnGameModeInit()
{
	PizzaCP = CreateDynamicPickup(1275, 2, 368.9829, -114.9067, 1001.5000, -1, 5, -1, 50.0);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DisablePlayerCheckpoint(playerid);
	PizzaHouseCP{playerid} = 0;
	
	Bit1_Set( gr_UsingPizzaSkin, playerid, false );
	Bit1_Set( gr_FirstUsing, playerid, false );
	Bit8_Set( gr_PlayerPizzas, playerid, 0 );
	Bit8_Set( gr_PlayerPizzasTotal, playerid, 0 );
	Bit16_Set( gr_LastPizzaCrib, playerid, INVALID_HOUSE_ID );
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	if( VehicleInfo[ vehicleid ][ vJob ] != 0 ) {
		if( VehicleInfo[ vehicleid ][ vJob ] != PlayerInfo[playerid ][ pJob ] && newstate == PLAYER_STATE_DRIVER ) {			
			new
				engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if( pickupid == PizzaCP )
		GameTextForPlayer( playerid, "~w~/pizza skin", 1000, 0 );
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if( PizzaHouseCP{playerid} == 10 ) {
		GameTextForPlayer(playerid, "/pizza deliver", 1000, 5);
	}
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

CMD:pizza(playerid, params[])
{
	new 
		pick[8];
	if( PlayerInfo[ playerid ][ pJob ] != 2 ) return SendClientMessage( playerid, COLOR_RED, "Niste Pizza Boy!"); 
	if( sscanf( params, "s[8] ", pick ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /pizza [order/take/put/deliver/skin/stop]");
	if( !strcmp( pick, "skin", true ) )
	{
		if( !IsPlayerInRangeOfPoint( playerid, 5.0, 368.9829, -114.9067, 1001.5000 ) ) return SendClientMessage( playerid, COLOR_RED, "Niste u Pizza Stack svlacionici!");
		if( Bit1_Get( gr_UsingPizzaSkin, playerid ) ) {
			SetPlayerSkin(playerid, PlayerInfo[ playerid ][ pChar ] );
			Bit1_Set( gr_UsingPizzaSkin, playerid, false );
		} else {
			SetPlayerSkin(playerid, 155 );
			Bit1_Set( gr_UsingPizzaSkin, playerid, true );
		}
	}
	if( !strcmp( pick, "take", true ) ) {
		
		new 
			vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB);
		if( IsPlayerInAnyVehicle(playerid) ) 				
			return SendClientMessage( playerid, COLOR_RED, "Ne smijete biti u vozilu!");
		if( !Bit8_Get( gr_PlayerPizzas, playerid ) ) 		
			return SendClientMessage( playerid, COLOR_RED, "Niste uzeli pizzu iz Well Stacked Pizze!");
		if( vehicleid == INVALID_VEHICLE_ID ) 
			return SendClientMessage( playerid, COLOR_RED, "Niste blizu pizzaboy motora!");
		if( GetVehicleModel( i ) != 448 ) 
			return SendClientMessage( playerid, COLOR_RED, "Vehicle is not pizzaboy motor!");
		if( IsPlayerAttachedObjectSlotUsed( playerid, 7 ) ) 
			RemovePlayerAttachedObject( playerid, 7 );
		
		SetPlayerAttachedObject(playerid, 7, 1582, 1, PizzaPos[ 0 ][ 0 ], PizzaPos[ 0 ][ 1 ], PizzaPos[ 0 ][ 2 ], 0.0, 90.0, 0.0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Kreni prema checkpointu i kucaj /pizza deliver!");
	}
	if( !strcmp( pick, "deliver", true ) )
	{
		if( IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete biti u vozilu!");
		if( !IsPlayerInCheckpoint(playerid) && IsPlayerInAnyVehicle(playerid) ) return SendClientMessage( playerid, COLOR_RED, "Niste u checkpointu ili se nalazite na motoru!");
		if( !Bit8_Get( gr_PlayerPizzas, playerid ) ) return SendClientMessage( playerid, COLOR_RED, "Nemate kartone pizze u rukama!");
		if( !IsPlayerInRangeOfPoint( playerid, 15.0, PizzaHousePos[playerid][0], PizzaHousePos[playerid][1], PizzaHousePos[playerid][2] ) ) return SendClientMessage( playerid, COLOR_RED, "Nisi blizu kuce koja je narucila pizzu!");
		
		new tmpString[ 14 ];
			
		format( tmpString, 14, "~g~Dostavljene pizze %d", 
			Bit8_Get( gr_PlayerPizzas, playerid ) - 1
		);
		GameTextForPlayer(playerid, tmpString, 1500, 1 );
		
		RemovePlayerAttachedObject( playerid, 7 );
		SetPlayerSpecialAction( playerid, SPECIAL_ACTION_NONE );
		
		PizzaHousePos[playerid][0] = 0.0;
		PizzaHousePos[playerid][1] = 0.0;
		PizzaHousePos[playerid][2] = 0.0;

		CheckPlayerPizzas(playerid);
		Bit1_Set( gr_IsWorkingJob, playerid, true );
	}
	if( !strcmp( pick, "order", true ) )
	{
		if(Bit1_Get( gr_UsingPizzaSkin, playerid ))
		{
			if( !IsPlayerInRangeOfPoint( playerid, 5.0, 373.1682, -119.7975, 1000.4898 ) ) return SendClientMessage( playerid, COLOR_RED, "Niste blizu sanka od Well Stacked Pizze!");

			if(Bit8_Get( gr_PlayerPizzas, playerid ) ) return SendClientMessage( playerid, COLOR_RED, "Vec ste narucili pizzu! Sjednite u vozilo i raznosite ju!");
			if( PizzaHouseCP{playerid} == 10 ) return SendClientMessage( playerid, COLOR_RED, "Vec vam je ukljucen CP!");
			if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
			new
				amount;
			if( sscanf( params, "s[8]i", pick, amount ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /pizza order [kolicina pizza]");
			if( 1 <= amount <= 8 ) {
				Bit8_Set( gr_PlayerPizzas, playerid, amount );
				Bit8_Set( gr_PlayerPizzasTotal, playerid, amount );
				CreatePlayerPizzas(playerid);
				
				new
					tmpString[ 74 ];
				format( tmpString, 74, "[ ! ] Uzeli ste %d pizza, idite do pizzaboy motora i kucajte /pizza put!",
					amount
				);
				SendClientMessage( playerid, COLOR_RED, tmpString );
				Bit1_Set( gr_FirstUsing, playerid, true );
			} else return SendClientMessage( playerid, COLOR_RED, "Morate unijeti kolicinu pizza u rasponu od 1 do 8!");
		}
		else return SendClientMessage( playerid, COLOR_RED, "Niste uzeli odjecu!");
	}
	if( !strcmp( pick, "stop", true ) )
	{
			Bit8_Set( gr_PlayerPizzas, playerid, 0 );
			if( IsPlayerAttachedObjectSlotUsed( playerid, 7 ) )
				RemovePlayerAttachedObject( playerid, 7 );
			if( IsPlayerAttachedObjectSlotUsed( playerid, 8 ) )
				RemovePlayerAttachedObject( playerid, 8 );
			if( IsPlayerAttachedObjectSlotUsed( playerid, 9 ) )
				RemovePlayerAttachedObject( playerid, 9 );

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Bit16_Set( gr_LastPizzaCrib, playerid, INVALID_HOUSE_ID );

			DisablePlayerCheckpoint(playerid);
			PizzaHouseCP{playerid} = 0;

			PizzaHousePos[playerid][0] = 0.0;
			PizzaHousePos[playerid][1] = 0.0;
			PizzaHousePos[playerid][2] = 0.0;

			TogglePlayerAllDynamicCPs(playerid, true);
			foreach(new i : Houses) 
			{
				TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], true);
			}
			Bit1_Set( gr_FirstUsing, playerid, false );

			SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste prestali raditi s poslom!");
			Bit1_Set( gr_IsWorkingJob, playerid, false );
	}
	if( !strcmp( pick, "put", true ) ) {

		if( !Bit8_Get( gr_PlayerPizzas, playerid ) )
			 return SendClientMessage( playerid, COLOR_RED, "Niste narucili pizzu u WSPu! Idite unutra i kucajte /pizza order!");
		new vehicleid;
		if((vehicleid = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB)) == INVALID_VEHICLE_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini poslovnog vozila!");
		if(GetVehicleModel(vehicleid) != 448 ) 
			return SendClientMessage( playerid, COLOR_RED, "Niste blizu pizzaboy motora!");
		if( IsPlayerAttachedObjectSlotUsed( playerid, 7 ) ) 
			RemovePlayerAttachedObject( playerid, 7 );
		if( IsPlayerAttachedObjectSlotUsed( playerid, 8 ) ) 
			RemovePlayerAttachedObject( playerid, 8 );
		if( IsPlayerAttachedObjectSlotUsed( playerid, 9 ) )
			RemovePlayerAttachedObject( playerid, 9 );
		
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste stavili pizze u motor. Idite po checkpointima i kucajte /pizza deliver!");
		if( Bit1_Get( gr_FirstUsing, playerid ) )
		{
			foreach(new i : Houses) 
			{
				TogglePlayerDynamicCP(playerid, HouseInfo[ i ][ hEnterCP ], false);
			}
			TogglePlayerAllDynamicCPs(playerid, false);
			
			Bit1_Set( gr_IsWorkingJob, playerid, true );
			new houseid = PizzaRandom(playerid);
			Bit16_Set( gr_LastPizzaCrib, playerid, houseid );
			
			DisablePlayerCheckpoint(playerid);
			PizzaHouseCP{playerid} = 10;
			SetPlayerCheckpoint(playerid, HouseInfo[houseid][hEnterX],HouseInfo[houseid][hEnterY],HouseInfo[houseid][hEnterZ], 6.0 );
			
			PizzaHousePos[playerid][0] = HouseInfo[houseid][hEnterX];
			PizzaHousePos[playerid][1] = HouseInfo[houseid][hEnterY];
			PizzaHousePos[playerid][2] = HouseInfo[houseid][hEnterZ];
			
			Bit1_Set( gr_FirstUsing, playerid, false );
		}
	}
	return 1;
}