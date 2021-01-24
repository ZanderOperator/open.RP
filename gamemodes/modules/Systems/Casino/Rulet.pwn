#include <YSI_Coding\y_hooks>

#define MAX_RULET_TABLES		( 4)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ###### 
*/

enum
{
	ROULETTE_TYPE_18,
	ROULETTE_TYPE_36,
	ROULETTE_TYPE_NUMBER,
	ROULETTE_TYPE_COLOR,
	ROULETTE_TYPE_TUCET,
	ROULETTE_TYPE_STUPAC,
	ROULETTE_TYPE_PARNEPAR,
};

enum E_RULET_TABLES_DATA
{
	Float:rtPosX,
	Float:rtPosY,
	Float:rtPosZ,
	rtInt,
	rtViwo,
	rtMinWage,
	rtMaxWage,
	rtPickupid
}
static
	RTable[MAX_RULET_TABLES][E_RULET_TABLES_DATA] = {
		{ 794.8000, 416.1000, 1070.9000, 5, 0, 20, 	200,	-1 },
		{ 789.7000, 416.0000, 1070.9000, 5, 0, 500, 5000,	-1 },
		{ 794.8000, 434.9000, 1070.9000, 5, 0, 100, 1000,	-1 },
		{ 789.9000, 435.2000, 1070.9000, 5, 0, 100, 1000,	-1 }
	};
	
enum E_RULET_CHIP_DATA
{
	rcNum,
	Float:rcPosX,
	Float:rcPosY,
	Float:rcPosZ
}
static const
	RChips[][E_RULET_CHIP_DATA] = {
		{ 0, 0.0545, 	0.5675,  -0.3000 },
		{ 1, -0.1935, 	0.4203,  -0.3000 },
		{ 2, 0.0654, 	0.4514,  -0.3000 },
		{ 3, 0.2897, 	0.4103,  -0.3000 },
		{ 4, -0.1733, 	0.2775,  -0.3000 },
		{ 5, 0.0769, 	0.2905,  -0.3000 },
		{ 6, 0.2832, 	0.2581,  -0.3000 },
		{ 7, -0.1892, 	0.1520,  -0.3000 },
		{ 8, 0.0618, 	0.1203,  -0.3000 },
		{ 9, 0.2854, 	0.1240,  -0.3000 },
		{ 10, -0.1776, 	-0.0088, -0.3000 },
		{ 11, 0.0734, 	-0.0405, -0.3000 },
		{ 12, 0.2970, 	-0.0369, -0.3000 },
		{ 13, -0.2107, 	-0.1704, -0.3000 },
		{ 14, 0.0576, 	-0.1660, -0.3000 },
		{ 15, 0.2992, 	-0.1710, -0.3000 },
		{ 16, -0.2172, 	-0.3226, -0.3000 },
		{ 17, 0.0424, 	-0.3362, -0.3000 },
		{ 18, 0.2927, 	-0.3232, -0.3000 },
		{ 19, -0.1970, 	-0.4654, -0.3000 },
		{ 20, 0.0540, 	-0.4970, -0.3000 },
		{ 21, 0.2801,   -0.4968, -0.3000 },
		{ 22, -0.1953,  -0.6310, -0.3000 },
		{ 23, 0.0603,   -0.6481, -0.3000 },
		{ 24, 0.2998,   -0.6233, -0.3000 },
		{ 25, -0.1743,  -0.7858, -0.3000 },
		{ 26, 0.0812,   -0.8028, -0.3000 },
		{ 27, 0.2790,   -0.7941, -0.3000 },
		{ 28, -0.1961,  -0.9611, -0.3000 },
		{ 29, 0.0723,   -0.9628, -0.3000 },
		{ 30, 0.2691,   -0.9551, -0.3000 },
		{ 31, -0.1881,  -1.1132, -0.3000 },
		{ 32, 0.0535,   -1.1058, -0.3000 },
		{ 33, 0.2950,   -1.0983, -0.3000 },
		{ 34, -0.1977,  -1.2656, -0.3000 },
		{ 35, 0.0741,   -1.2543, -0.3000 },
		{ 36, 0.2897,   -1.2365, -0.3000 },
		{ 37, -0.6925,  -0.2498, -0.3000 },	// RED		
		{ 38, -0.6607,  -0.5534, -0.3000 }, // BLACK
		{ 39, -0.4573,  0.1856,  -0.3000 }, // 1st12
		{ 40, -0.4306,  -0.3683, -0.3000 }, // 2nd12
		{ 41, -0.4341,  -0.9789, -0.3000 }, // 3rd12
		{ 42, -0.6877,  0.4039,  -0.3000 }, // 1to18
		{ 43, -0.6936,  -1.1540, -0.3000 },  // 19to36
		{ 44, -0.1977,  -1.3656, -0.3000 },  // stupac 1
		{ 45, 0.0741,   -1.3543, -0.3000 },  // stupac 2
		{ 46, 0.2897,   -1.3365, -0.3000 },  // stupac 3
		{ 47, -0.6936,   0.1540, -0.3000 },  // par
		{ 48, -0.6936,  -0.8122, -0.3000 }  // nepar
	};

static
	RoulettSlot[MAX_PLAYERS],				// Zadnji slot koji igrac stavlja
	RouletteTable[MAX_PLAYERS],			// Stol za kojim igra
	RoulettWholeBet[MAX_PLAYERS], 		// Cijeli unos oklada
	RouletteChipObj[MAX_PLAYERS][47],	// Objekt cipova na stolu
	RoulettBet[MAX_PLAYERS][47],		// Koliko je novca ulozio
	RouletteNumber[MAX_PLAYERS][47],	// Koji je broj uzeo
	RouletteColor[MAX_PLAYERS][47],		// Koju je broju odabrao
	RouletteTucet[MAX_PLAYERS][47],		// Koju je dvanaestinu odabrao
	RouletteStupac[MAX_PLAYERS][47],	// Koji je stupac odabrao
	RouletteParNepar[MAX_PLAYERS][47],	// Koju je par/nepar odabrao
	RouletteType[MAX_PLAYERS][47],		// Tip oklade
	Timer:GlobalRoulette[MAX_PLAYERS],	// Timer za glavni dio ruleta (biranje broja)
	Timer:WaitingRoulette[MAX_PLAYERS],	// Timer koji ceka da igrac odabere okladu
	bool:RuletWaitingForPlayers[MAX_PLAYERS] = {false, ...},
	RuletWaitingTime[MAX_PLAYERS] = {0, ... },
	RouletteCount[MAX_PLAYERS] = {0, ... };

// TODO: make these variables private ("static") when commandments are followed in BlackJack.pwn: ln 791
new
	PlayerText:RuletWages[MAX_PLAYERS]	 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletNote[MAX_PLAYERS]		 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletTitle[MAX_PLAYERS]	 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletColor[MAX_PLAYERS] 		 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletNumber[MAX_PLAYERS] 	 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletBcg1[MAX_PLAYERS]		 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletBcg2[MAX_PLAYERS]		 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotBcg[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotTitle[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotMax[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotMaxInput[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotWhole[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotWholeInput[MAX_PLAYERS]= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotNow[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:RuletPotNowInput[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... };

static
	Iterator:RuletTables<MAX_RULET_TABLES>;

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
////////////////////////////////////////////////////////

stock GetPlayerCasinoID(playerid)
{
	new 
		bizzid = Player_InBusiness(playerid);
	if(BizzInfo[bizzid][bType] == BIZZ_TYPE_CASINO)
		return bizzid;
	return INVALID_BIZNIS_ID;
}

stock InitRuletWorkers()
{
	RuletWorker[0] = CreateActor(11, 795.8344, 416.3900, 1070.8900, 90.0);
	RuletWorker[1] = CreateActor(11, 790.6880, 416.2010, 1070.8900, 90.0);
	RuletWorker[2] = CreateActor(11, 790.8601, 435.5245, 1070.8900, 90.0);
	RuletWorker[3] = CreateActor(11, 795.8755, 435.3174, 1070.8900, 90.0);
}

stock DestroyRuletWorkers()
{
	DestroyActor(RuletWorker[0]);
	DestroyActor(RuletWorker[1]);
	DestroyActor(RuletWorker[2]);
	DestroyActor(RuletWorker[3]);
}

stock ResetRuletTable(playerid)
{
	RouletteTable[playerid] = -1;
}

stock ResetRuletArrays(playerid, bool:autodestruct = false)
{ 
	// TextDraws
	if(!autodestruct)
	{
		DestroyRouletteTDs(playerid);
	}
	DestroyRuletPickupTDs(playerid);
	DestroyRuletPotTDs(playerid);

	// TODO: fk magic numbers
	for(new i = 0; i < 47; i++)
	{
		RoulettBet[playerid][i]			= 0; 
		RouletteNumber[playerid][i]		= -1;
		RouletteColor[playerid][i]		= -1;
		RouletteTucet[playerid][i]		= -1;
		RouletteParNepar[playerid][i]	= -1;
		RouletteStupac[playerid][i]		= -1;
		RouletteType[playerid][i]		= -1;

		DestroyDynamicObject(RouletteChipObj[playerid][i]);
		RouletteChipObj[playerid][i] = INVALID_OBJECT_ID;
	}

	RoulettSlot[playerid]					= 0;
	RoulettWholeBet[playerid]				= 0;

	RuletWaitingForPlayers[playerid] = false;
	RuletWaitingTime[playerid] = 0;
	RouletteCount[playerid] = 0;

	stop GlobalRoulette[playerid];
	stop WaitingRoulette[playerid];
	return 1;
}

stock DestroyRouletteTDs(playerid)
{
	if(RuletColor[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletColor[playerid]);
		RuletColor[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	if(RuletNumber[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletNumber[playerid]);
		RuletNumber[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock CreateRouletteTDs(playerid)
{
	DestroyRouletteTDs(playerid);
	
	RuletColor[playerid] = CreatePlayerTextDraw(playerid, 284.000000, 27.440000, "LD_ROUL:roulbla");
	PlayerTextDrawLetterSize(playerid, 	RuletColor[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, 	RuletColor[playerid], 66.500000, 50.400001);
	PlayerTextDrawAlignment(playerid, 	RuletColor[playerid], 1);
	PlayerTextDrawColor(playerid, 		RuletColor[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 	RuletColor[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 	RuletColor[playerid], 57);
	PlayerTextDrawFont(playerid, 		RuletColor[playerid], 4);
	PlayerTextDrawShow(playerid, 		RuletColor[playerid]);

	RuletNumber[playerid] = CreatePlayerTextDraw(playerid, 316.599884, 30.912029, "32");
	PlayerTextDrawLetterSize(playerid, 		RuletNumber[playerid], 0.656199, 2.876239);
	PlayerTextDrawAlignment(playerid, 		RuletNumber[playerid], 2);
	PlayerTextDrawColor(playerid, 			RuletNumber[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		RuletNumber[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		RuletNumber[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletNumber[playerid], 51);
	PlayerTextDrawFont(playerid, 			RuletNumber[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletNumber[playerid], 1);
	PlayerTextDrawShow(playerid, 			RuletNumber[playerid]);
	return 1;
}

stock PlayerToRouletteMoney(playerid, money)
{
	AC_GivePlayerMoney(playerid, -money);
	RoulettBet[playerid][RoulettSlot[playerid]] = money;
	RoulettWholeBet[playerid] += money;
	PlayerPlaySound( playerid, 1083, 0.0, 0.0, 0.0);
	
	new 
		bizzid = Player_InBusiness(playerid);
	if(bizzid == INVALID_BIZNIS_ID)
		return 1;

	if(BizzInfo[bizzid][bType] == BIZZ_TYPE_CASINO)
	{
		BizzInfo[bizzid][bTill] += money;				

		mysql_fquery(g_SQL, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
			BizzInfo[bizzid][bTill],
			BizzInfo[bizzid][bSQLID]
		);
	}
	return 1;
}

static stock ShowRouletteTD(playerid, number)
{
	switch( number) {
		case 0: {																		// Zelena
			PlayerTextDrawSetString( playerid, RuletColor[playerid], "LD_ROUL:roulgre");
			new
				numString[3];
			valstr(numString, number, false);
			PlayerTextDrawSetString( playerid, RuletNumber[playerid], numString);
		}
		case 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36: { 		// Crvena
			PlayerTextDrawSetString( playerid, RuletColor[playerid], "LD_ROUL:roulred");
			new
				numString[3];
			valstr(numString, number, false);
			PlayerTextDrawSetString( playerid, RuletNumber[playerid], numString);
		}
		case 2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35: {		// Crna
			PlayerTextDrawSetString( playerid, RuletColor[playerid], "LD_ROUL:roulbla");
			new
				numString[3];
			valstr(numString, number, false);
			PlayerTextDrawSetString( playerid, RuletNumber[playerid], numString);
		}
	}
	return 1;
}

stock InitRuletTables()
{
	RTable[0][rtPickupid] = CreateDynamicPickup(19300, 2, 793.0489, 415.1578, 1069.9900, RTable[0][rtViwo], RTable[0][rtInt], -1, 10.0);
	Iter_Add( RuletTables, 0);

	RTable[1][rtPickupid] = CreateDynamicPickup(19300, 2, 787.9941, 415.2599, 1069.9900, RTable[1][rtViwo], RTable[1][rtInt], -1, 10.0);
	Iter_Add( RuletTables, 1);

	RTable[2][rtPickupid] = CreateDynamicPickup(19300, 2, 793.1121, 434.3154, 1069.9900, RTable[2][rtViwo], RTable[2][rtInt], -1, 10.0);
	Iter_Add( RuletTables, 2);

	RTable[3][rtPickupid] = CreateDynamicPickup(19300, 2, 788.2350, 434.6027, 1069.9900, RTable[3][rtViwo], RTable[3][rtInt], -1, 10.0);
	Iter_Add( RuletTables, 3);
	
	printf("Script Report: %d rulet tables loaded!", Iter_Count(RuletTables));
	return 1;
}

static stock IsPlayerInRangeOfRuletTable( playerid)
{
	new
		tableid = -1;
		
	foreach(new i : RuletTables)
	{
		if(IsPlayerInRangeOfPoint( playerid, 2.5, RTable[i][rtPosX], RTable[i][rtPosY], RTable[i][rtPosZ])) {
			tableid = i;
			break;
		}
	}
	return tableid;
}

static stock CreateRuletChips(playerid, slot)
{
	new
		number,
		Float:chip_z;
		
	switch( RouletteType[playerid][slot]) {
		case ROULETTE_TYPE_NUMBER:
			number = RouletteNumber[playerid][slot];
		case ROULETTE_TYPE_COLOR: {
			if(RouletteColor[playerid][slot] == 0)
				number = 37;
			else if(RouletteColor[playerid][slot] == 1)
				number = 38;
		}
		case ROULETTE_TYPE_TUCET: {
			switch( RouletteTucet[playerid][slot])
			{
				case 0: number = 39;
				case 1: number = 40;
				case 2: number = 41;
			}
		}
		case ROULETTE_TYPE_18: {
			number = 42;
		}
		case ROULETTE_TYPE_36: {
			number = 43;
		}
		case ROULETTE_TYPE_STUPAC: {
			switch( RouletteStupac[playerid][slot])
			{
				case 0: number = 44;
				case 1: number = 45;
				case 2: number = 46;
			}
		}
		case ROULETTE_TYPE_PARNEPAR: {
			if(RouletteParNepar[playerid][slot] == 0)
				number = 47;
			else if(RouletteParNepar[playerid][slot] == 1)
				number = 48;
		}
	}
	
	if(100 <= RoulettBet[playerid][slot] <= 200) 			
		chip_z = RChips[number][rcPosZ];
	else if(201 <= RoulettBet[playerid][slot] <= 400) 			
		chip_z = -0.2900;
	else if(401 <= RoulettBet[playerid][slot] <= 600)	
		chip_z = -0.2800;
	else if(601 <= RoulettBet[playerid][slot] <= 800)	
		chip_z = -0.2600;
	else if(801 <= RoulettBet[playerid][slot] <= 1000)	
		chip_z = -0.2400;
	else if(1001 <= RoulettBet[playerid][slot] <= 5000)	
		chip_z = -0.2200;
	else if(5001 <= RoulettBet[playerid][slot] <= 10000)
		chip_z = -0.2000;
	else if(5001 <= RoulettBet[playerid][slot] <= 10000)
		chip_z = -0.1900;
	else if(10001 <= RoulettBet[playerid][slot] <= 30000)
		chip_z = -0.1800;
	else if(30001 <= RoulettBet[playerid][slot] <= 500000)	
		chip_z = -0.1700;
	else if(500001 <= RoulettBet[playerid][slot] <= 1000000)
		chip_z = -0.16700;
	
	RouletteChipObj[playerid][slot] = CreateDynamicObject(1903, RTable[RouletteTable[playerid]][rtPosX] + RChips[number][rcPosX], RTable[RouletteTable[playerid]][rtPosY] + RChips[number][rcPosY], RTable[RouletteTable[playerid]][rtPosZ] + chip_z, 0.0, 0.0, 0.0, -1, -1, playerid);
	Streamer_UpdateEx(playerid, RTable[RouletteTable[playerid]][rtPosX], RTable[RouletteTable[playerid]][rtPosY], RTable[RouletteTable[playerid]][rtPosZ]);
	return 1;
}

static stock IsPlayerWinner(playerid, number)
{
	if(RouletteTable[playerid] == -1) return 0;
	for( new x = 0; x <= RoulettSlot[playerid]; x++) {
		switch( RouletteType[playerid][x]) {
			case ROULETTE_TYPE_NUMBER: {
				if(RouletteNumber[playerid][x] == number) {
					
					PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
					PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
					
					new
						tmpString[25];
					format( tmpString, 25, "~y~Winner~n~~w~%d$",
						RoulettBet[playerid][x] * 36
					);
					GameTextForPlayer( playerid, tmpString, 1500, 6);
					BusinessToPlayerMoney(playerid, 104, RoulettBet[playerid][x] * 36); // Igrac dobiva novce od biznisa
					return 1;
				}
			}
			case ROULETTE_TYPE_COLOR: {
				new
					moneys = RoulettBet[playerid][x] * 2;
				switch( number) {
					case 1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36: { 		// Crvena
						if(RouletteColor[playerid][x] == 0) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
					case 2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35: {		// Crna
						if(RouletteColor[playerid][x] == 1) {
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
				}
			}
			case ROULETTE_TYPE_PARNEPAR: {
				new
					moneys = RoulettBet[playerid][x] * 2;
				switch( number) {
					case 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36: { 		// Parni
						if(RouletteParNepar[playerid][x] == 0) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
					case 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35: {		// Neparni
						if(RouletteParNepar[playerid][x] == 1) {
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
				}
			}
			case ROULETTE_TYPE_TUCET: {
				new
					moneys = floatround(RoulettBet[playerid][x] * 3);
				switch( number)
				{
					case 1 .. 12: {
						if(RouletteTucet[playerid][x] == 0) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}	
					}
					case 13 .. 24: {
						if(RouletteTucet[playerid][x] == 1) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
					case 25 .. 36: {
						if(RouletteTucet[playerid][x] == 2) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
				}
			}
			case ROULETTE_TYPE_STUPAC: {
				new
					moneys = floatround(RoulettBet[playerid][x] * 3);
				switch( number)
				{
					case 1,4,7,10,13,16,19,22,25,28,31,34: {
						if(RouletteStupac[playerid][x] == 0) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}	
					}
					case 2,5,8,11,14,17,20,23,26,29,32,35: {
						if(RouletteStupac[playerid][x] == 1) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
					case 3,6,9,12,15,18,21,24,27,30,33,36: {
						if(RouletteStupac[playerid][x] == 2) {
							
							PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
							PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
							
							new
								tmpString[25];
							format( tmpString, 25, "~y~Winner~n~~w~%d$",
								moneys
							);
							GameTextForPlayer( playerid, tmpString, 1500, 6);
							BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
							return 1;
						}
					}
				}
			}
			case ROULETTE_TYPE_18: {
				switch( number)
				{
					case 1 .. 18: {
						PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
						PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
						
						new
							tmpString[25],
							moneys = floatround(RoulettBet[playerid][x] * 2);
							
						format( tmpString, 25, "~y~Winner~n~~w~%d$",
							moneys
						);
						GameTextForPlayer( playerid, tmpString, 1500, 6);
						BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
						return 1;
					}
				}
			}
			case ROULETTE_TYPE_36: {
				switch( number)
				{
					case 19 .. 36: {
						PlayerPlaySound(playerid,1063,0.0,0.0,0.0); 
						PlayerPlaySound( playerid, 33401,0.0,0.0,0.0); 
						
						new
							tmpString[25],
							moneys = floatround(RoulettBet[playerid][x] * 2);
						format( tmpString, 25, "~y~Winner~n~~w~%d$",
							moneys
						);
						GameTextForPlayer( playerid, tmpString, 1500, 6);
						BusinessToPlayerMoney(playerid, 104, moneys); // Igrac dobiva novce od biznisa
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

stock ShowRuletPickupTDs(playerid)
{
	DestroyRuletPickupTDs(playerid);
	
	RuletBcg1[playerid] = CreatePlayerTextDraw(playerid, 615.900390, 111.260002, "usebox");
	PlayerTextDrawLetterSize(playerid, RuletBcg1[playerid], 0.000000, 7.437777);
	PlayerTextDrawTextSize(playerid, RuletBcg1[playerid], 490.049987, 0.000000);
	PlayerTextDrawAlignment(playerid, RuletBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, RuletBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, RuletBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, RuletBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, RuletBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, RuletBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, RuletBcg1[playerid]);

	RuletBcg2[playerid] = CreatePlayerTextDraw(playerid, 616.349731, 110.868003, "usebox");
	PlayerTextDrawLetterSize(playerid, RuletBcg2[playerid], 0.000000, 1.173887);
	PlayerTextDrawTextSize(playerid, RuletBcg2[playerid], 490.100006, 0.000000);
	PlayerTextDrawAlignment(playerid, RuletBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, RuletBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, RuletBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, RuletBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, RuletBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, RuletBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, RuletBcg2[playerid]);

	RuletTitle[playerid] = CreatePlayerTextDraw(playerid, 532.000000, 112.055999, "Rulet %d");
	PlayerTextDrawLetterSize(playerid, RuletTitle[playerid], 0.350600, 0.853519);
	PlayerTextDrawAlignment(playerid, RuletTitle[playerid], 2);
	PlayerTextDrawColor(playerid, RuletTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletTitle[playerid], 1);
	PlayerTextDrawSetOutline(playerid, RuletTitle[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, RuletTitle[playerid], 255);
	PlayerTextDrawFont(playerid, RuletTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, RuletTitle[playerid], 1);
	PlayerTextDrawShow(playerid, RuletTitle[playerid]);

	RuletNote[playerid] = CreatePlayerTextDraw(playerid, 549.850585, 164.191940, "Kucajte /rulet za igru.");
	PlayerTextDrawLetterSize(playerid, RuletNote[playerid], 0.221450, 0.882799);
	PlayerTextDrawTextSize(playerid, RuletNote[playerid], -23.650007, 144.199920);
	PlayerTextDrawAlignment(playerid, RuletNote[playerid], 2);
	PlayerTextDrawColor(playerid, RuletNote[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletNote[playerid], 1);
	PlayerTextDrawSetOutline(playerid, RuletNote[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, RuletNote[playerid], 255);
	PlayerTextDrawFont(playerid, RuletNote[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletNote[playerid], 1);
	PlayerTextDrawShow(playerid, RuletNote[playerid]);

	RuletWages[playerid] = CreatePlayerTextDraw(playerid, 497.350067, 136.360137, "Min. Ulog: 1.000.000$~n~Max. Ulog: 1.000.000$");
	PlayerTextDrawLetterSize(playerid, RuletWages[playerid], 0.231450, 0.902799);
	PlayerTextDrawAlignment(playerid, RuletWages[playerid], 1);
	PlayerTextDrawColor(playerid, RuletWages[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletWages[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletWages[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletWages[playerid], 51);
	PlayerTextDrawFont(playerid, RuletWages[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletWages[playerid], 1);
	PlayerTextDrawShow(playerid, RuletWages[playerid]);
}

stock DestroyRuletPickupTDs(playerid)
{
	if(RuletBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletBcg1[playerid]);
		RuletBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletBcg2[playerid]);
		RuletBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletTitle[playerid]);
		RuletTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletNote[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletNote[playerid]);
		RuletNote[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletWages[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletWages[playerid]);
		RuletWages[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

static stock DestroyRuletPotTDs(playerid)
{
	if(RuletPotBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotBcg[playerid]);
		RuletPotBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotTitle[playerid]);
		RuletPotTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotMax[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotMax[playerid]);
		RuletPotMax[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotMaxInput[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotMaxInput[playerid]);
		RuletPotMaxInput[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotWhole[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotWhole[playerid]);
		RuletPotWhole[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotWholeInput[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotWholeInput[playerid]);
		RuletPotWholeInput[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotNow[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotNow[playerid]);
		RuletPotNow[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(RuletPotNowInput[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, RuletPotNowInput[playerid]);
		RuletPotNowInput[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

static stock ShowRuletPotTDs(playerid)
{
	DestroyRuletPotTDs(playerid);
	RuletPotBcg[playerid] = CreatePlayerTextDraw(playerid, 137.800018, 143.179992, "usebox");
	PlayerTextDrawLetterSize(playerid, RuletPotBcg[playerid], 0.000000, 14.182225);
	PlayerTextDrawTextSize(playerid, RuletPotBcg[playerid], 26.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, RuletPotBcg[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, RuletPotBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, RuletPotBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, RuletPotBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotBcg[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, RuletPotBcg[playerid], 255);
	PlayerTextDrawFont(playerid, RuletPotBcg[playerid], 0);
	PlayerTextDrawShow(playerid, RuletPotBcg[playerid]);

	RuletPotTitle[playerid] = CreatePlayerTextDraw(playerid, 32.699985, 126.896057, "Ulog");
	PlayerTextDrawLetterSize(playerid, RuletPotTitle[playerid], 0.783649, 2.725599);
	PlayerTextDrawAlignment(playerid, RuletPotTitle[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletPotTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotTitle[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotTitle[playerid], 0);
	PlayerTextDrawSetProportional(playerid, RuletPotTitle[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotTitle[playerid]);

	RuletPotMax[playerid] = CreatePlayerTextDraw(playerid, 34.000000, 163.744049, "Max Ulog");
	PlayerTextDrawLetterSize(playerid, RuletPotMax[playerid], 0.434499, 1.358080);
	PlayerTextDrawAlignment(playerid, RuletPotMax[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotMax[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, RuletPotMax[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotMax[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotMax[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotMax[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotMax[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotMax[playerid]);

	RuletPotMaxInput[playerid] = CreatePlayerTextDraw(playerid, 33.500000, 178.080078, "$100000");
	PlayerTextDrawLetterSize(playerid, RuletPotMaxInput[playerid], 0.382849, 1.407919);
	PlayerTextDrawAlignment(playerid, RuletPotMaxInput[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotMaxInput[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletPotMaxInput[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotMaxInput[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotMaxInput[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotMaxInput[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotMaxInput[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotMaxInput[playerid]);

	RuletPotWhole[playerid] = CreatePlayerTextDraw(playerid, 34.000000, 193.760025, "Cijeli Ulog");
	PlayerTextDrawLetterSize(playerid, RuletPotWhole[playerid], 0.434499, 1.358080);
	PlayerTextDrawAlignment(playerid, RuletPotWhole[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotWhole[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, RuletPotWhole[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotWhole[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotWhole[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotWhole[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotWhole[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotWhole[playerid]);

	RuletPotWholeInput[playerid] = CreatePlayerTextDraw(playerid, 33.500000, 210.000045, "$400");
	PlayerTextDrawLetterSize(playerid, RuletPotWholeInput[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, RuletPotWholeInput[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotWholeInput[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletPotWholeInput[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotWholeInput[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotWholeInput[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotWholeInput[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotWholeInput[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotWholeInput[playerid]);

	RuletPotNow[playerid] = CreatePlayerTextDraw(playerid, 34.000000, 228.983932, "Sadasnji Ulog");
	PlayerTextDrawLetterSize(playerid, RuletPotNow[playerid], 0.434499, 1.358080);
	PlayerTextDrawAlignment(playerid, RuletPotNow[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotNow[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, RuletPotNow[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotNow[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotNow[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotNow[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotNow[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotNow[playerid]);

	RuletPotNowInput[playerid] = CreatePlayerTextDraw(playerid, 33.500000, 244.160003, "$400");
	PlayerTextDrawLetterSize(playerid, RuletPotNowInput[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, RuletPotNowInput[playerid], 1);
	PlayerTextDrawColor(playerid, RuletPotNowInput[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RuletPotNowInput[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RuletPotNowInput[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, RuletPotNowInput[playerid], 51);
	PlayerTextDrawFont(playerid, RuletPotNowInput[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RuletPotNowInput[playerid], 1);
	PlayerTextDrawShow(playerid, RuletPotNowInput[playerid]);
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
/////////////////////////////////////////////////////////////

timer FadeRouletteTD[2000](playerid)
{
	DestroyRouletteTDs(playerid);
	return 1;
}

timer RuletWaitingTimer[1000](playerid)
{
	RuletWaitingTime[playerid]--;

	va_GameTextForPlayer(playerid, "~w~%d", 1000, 4, RuletWaitingTime[playerid]);
	PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	
	if(RuletWaitingTime[playerid] == 2)
	{
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Waiting for other players...");
		PlayerPlaySound(playerid, 5408, 0.0, 0.0, 0.0);
	}
	else if(RuletWaitingTime[playerid] == 0)
	{
		GameTextForPlayer(playerid, "", 100, 4);
		RuletWaitingTime[playerid] = 20;
		RuletWaitingForPlayers[playerid] = false;
		stop WaitingRoulette[playerid];

		CreateRouletteTDs(playerid);

		// TODO: this is called in a million of places, extract to a helper func
		// RuletPlayWinningSounds(playerid)
		PlayerPlaySound(playerid, 1063, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 33400, 0.0, 0.0, 0.0);
		
		GlobalRoulette[playerid] = repeat RouletteTimer(playerid);
	}
}

static stock PlayRouletteNumberSound(playerid, number)
{
	// TODO: make a "static const" array, lose the switch case statement, index into
	// the array, return the number, and make ONE call to PlayerPlaySound.
	switch(number) {
		case 0: 	PlayerPlaySound( playerid, 5438, 0.0, 0.0, 0.0);  // Zero
		case 1: 	PlayerPlaySound( playerid, 5439, 0.0, 0.0, 0.0);  // Red - 1
		case 2: 	PlayerPlaySound( playerid, 5440, 0.0, 0.0, 0.0);  // Black - 2
		case 3: 	PlayerPlaySound( playerid, 5441, 0.0, 0.0, 0.0);  // Red 3
		case 4: 	PlayerPlaySound( playerid, 5442, 0.0, 0.0, 0.0);  // Black - 4
		case 5: 	PlayerPlaySound( playerid, 5443, 0.0, 0.0, 0.0);  // Red - 5
		case 6: 	PlayerPlaySound( playerid, 5444, 0.0, 0.0, 0.0);  // Black - 6
		case 7: 	PlayerPlaySound( playerid, 5445, 0.0, 0.0, 0.0);  // Red, 7
		case 8: 	PlayerPlaySound( playerid, 5446, 0.0, 0.0, 0.0);  // Black, 8
		case 9: 	PlayerPlaySound( playerid, 5447, 0.0, 0.0, 0.0);  // Red - 9
		case 10: 	PlayerPlaySound( playerid, 5411, 0.0, 0.0, 0.0);  // Black - 10
		case 11: 	PlayerPlaySound( playerid, 5412, 0.0, 0.0, 0.0);  // Black 11
		case 12: 	PlayerPlaySound( playerid, 5413, 0.0, 0.0, 0.0);  // Red - 12
		case 13: 	PlayerPlaySound( playerid, 5414, 0.0, 0.0, 0.0);  // Black - 13
		case 14: 	PlayerPlaySound( playerid, 5415, 0.0, 0.0, 0.0);  // Red 14
		case 15: 	PlayerPlaySound( playerid, 5416, 0.0, 0.0, 0.0);  // Black - 15
		case 16: 	PlayerPlaySound( playerid, 5417, 0.0, 0.0, 0.0);  // Red - 16
		case 17: 	PlayerPlaySound( playerid, 5418, 0.0, 0.0, 0.0);  // Black - 17
		case 18: 	PlayerPlaySound( playerid, 5419, 0.0, 0.0, 0.0);  // Red 18
		case 19: 	PlayerPlaySound( playerid, 5420, 0.0, 0.0, 0.0);  // Red - 19
		case 20: 	PlayerPlaySound( playerid, 5421, 0.0, 0.0, 0.0);  // Black - 20
		case 21: 	PlayerPlaySound( playerid, 5422, 0.0, 0.0, 0.0);  // Red - 21
		case 22: 	PlayerPlaySound( playerid, 5423, 0.0, 0.0, 0.0);  // Black - 22
		case 23: 	PlayerPlaySound( playerid, 5424, 0.0, 0.0, 0.0);  // Red - 23
		case 24: 	PlayerPlaySound( playerid, 5425, 0.0, 0.0, 0.0);  // Black - 24
		case 25: 	PlayerPlaySound( playerid, 5426, 0.0, 0.0, 0.0);  // Red - 25
		case 26: 	PlayerPlaySound( playerid, 5427, 0.0, 0.0, 0.0);  // Black - 26
		case 27: 	PlayerPlaySound( playerid, 5428, 0.0, 0.0, 0.0);  // Red - 27
		case 28: 	PlayerPlaySound( playerid, 5429, 0.0, 0.0, 0.0);  // Black - 28
		case 29: 	PlayerPlaySound( playerid, 5430, 0.0, 0.0, 0.0);  // Black - 29
		case 30: 	PlayerPlaySound( playerid, 5431, 0.0, 0.0, 0.0);  // Red - 30
		case 31: 	PlayerPlaySound( playerid, 5432, 0.0, 0.0, 0.0);  // Black - 31
		case 32: 	PlayerPlaySound( playerid, 5433, 0.0, 0.0, 0.0);  // Red - 32
		case 33: 	PlayerPlaySound( playerid, 5434, 0.0, 0.0, 0.0);  // Black - 33
		case 34: 	PlayerPlaySound( playerid, 5435, 0.0, 0.0, 0.0);  // Red - 34
		case 35: 	PlayerPlaySound( playerid, 5436, 0.0, 0.0, 0.0);  // Black, 35
		case 36: 	PlayerPlaySound( playerid, 5437, 0.0, 0.0, 0.0);  // Red - 36
	}
}

timer RouletteTimer[500](playerid)
{
	new
		number = minrand(0, 36);
	ShowRouletteTD(playerid, number);
	RouletteCount[playerid]++;
	
	PlayerPlaySound(playerid, 1063, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 33400, 0.0, 0.0, 0.0);
	
	if(RouletteCount[playerid] == 23)
	{
		PlayerPlaySound(playerid, 33401, 0.0, 0.0, 0.0);
	}
	else if(RouletteCount[playerid] == 25)
	{
		DestroyRuletPotTDs(playerid);
		stop GlobalRoulette[playerid];
		defer FadeRouletteTD(playerid);
		
		PlayRouletteNumberSound(playerid, number);
		if(!IsPlayerWinner(playerid, number))
		{
			va_GameTextForPlayer( playerid, "~r~Loser~n~~w~%d$", 1500, 6, RoulettWholeBet[playerid]);
		}
		else
		{
			PlayerPlaySound(playerid, 5449, 0.0, 0.0, 0.0); 
			//AC_GivePlayerMoney(playerid, RoulettWholeBet[playerid]);
			va_SendClientMessage(playerid, 0xF4D942AA, "RULET: %d", number);
		}
		ResetRuletArrays(playerid, true);
		ResetRuletTable(playerid);
		RouletteCount[playerid] = 0;
	}
	return 1;
}

timer FadeRuletWagesTD[5000](playerid)
{
	DestroyRuletPickupTDs(playerid);
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

hook function ResetPlayerVariables(playerid)
{
	ResetRuletArrays(playerid);
	ResetRuletTable(playerid);
	return continue(playerid);
}

hook OnGameModeInit()
{
	InitRuletTables();
	return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{ 
	foreach(new tableid : RuletTables)
	{
		if(pickupid == RTable[tableid][rtPickupid])
		{
			ShowRuletPickupTDs(playerid);
			new	
				tmpString[50];
			
			format( tmpString, 50, "Rulet %d",
				tableid+1
			);
			PlayerTextDrawSetString(playerid, RuletTitle[playerid], tmpString);
			
			format( tmpString, 50, "Min. Ulog: %d$~n~Max. Ulog: %d$",
				RTable[tableid][rtMinWage],
				RTable[tableid][rtMaxWage]
			);
			PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
			
			defer FadeRuletWagesTD(playerid);
			break;
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid)
	{
		case DIALOG_CASINO_RULET:
		{
			if(!response) return 1;
			new
				ruletString[115];
				//0 Brojevi\n 1 Boje\n 2 Tuceti\n 3 Stupci\ 4 Par-Nepar\n 5- 1-18\n 6 -19-36
			switch( listitem) {
				case 0: ShowPlayerDialog( playerid, DIALOG_CASINO_RNUMBERS, DIALOG_STYLE_LIST, "ODABIR BROJEVA ZA RULET", "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19\n20\n21\n22\n23\n24\n25\n26\n27\n28\n29\n30\n31\n32\n33\n34\n35\n36", "Choose", "Abort");
				case 1: ShowPlayerDialog( playerid, DIALOG_CASINO_RCOLOR, DIALOG_STYLE_LIST, "ODABIR BROJEVA ZA RULET", "Crvena\nCrna", "Choose", "Abort");
				case 2: ShowPlayerDialog( playerid, DIALOG_CASINO_R12, DIALOG_STYLE_LIST, "ODABIR TUCETA ZA RULET", "Prvi\nDrugi\nTreci", "Choose", "Abort");
				case 3: ShowPlayerDialog( playerid, DIALOG_CASINO_COLUMN, DIALOG_STYLE_LIST, "ODABIR STUPCA ZA RULET", "Prvi\nDrugi\nTreci", "Choose", "Abort");
				case 4: ShowPlayerDialog( playerid, DIALOG_CASINO_PAIR, DIALOG_STYLE_LIST, "ODABIR PAR/NEPAR ZA RULET", "Parni brojevi\nNeparni brojevi", "Choose", "Abort");
				case 5: {
					RouletteType[playerid][RoulettSlot[playerid]] = ROULETTE_TYPE_18;
					SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste prvih 18 brojeva kao vasu okladu!");
					format( ruletString, 115, "Unesite koliko novca zelite staviti na prvih 18 brojeva:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
						RTable[RouletteTable[playerid]][rtMinWage],
						RTable[RouletteTable[playerid]][rtMaxWage]
					);
					ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
				}
				case 6: {
					RouletteType[playerid][RoulettSlot[playerid]] = ROULETTE_TYPE_36;
					SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste drugih 18 (19 - 36) brojeva kao vasu okladu!");
					format( ruletString, 115, "Unesite koliko novca zelite staviti na drugih 18 (19 - 36) brojeva:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
						RTable[RouletteTable[playerid]][rtMinWage],
						RTable[RouletteTable[playerid]][rtMaxWage]
					);
					ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
				}
			}
			return 1;
		}
		case DIALOG_CASINO_RNUMBERS:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			
			RouletteType[playerid][RoulettSlot[playerid]] 	= ROULETTE_TYPE_NUMBER;
			RouletteNumber[playerid][RoulettSlot[playerid]] 	= listitem;
			SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste brojeve kao vasu okladu!");
			
			new
				ruletString[115];
			format( ruletString, 115, "Unesite koliko novca zelite staviti broj %d:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
				listitem,
				RTable[RouletteTable[playerid]][rtMinWage],
				RTable[RouletteTable[playerid]][rtMaxWage]
			);
			ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			return 1;
		}
		case DIALOG_CASINO_RCOLOR:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			
			RouletteType[playerid][RoulettSlot[playerid]] 	= ROULETTE_TYPE_COLOR;
			RouletteColor[playerid][RoulettSlot[playerid]] 	= listitem;
			SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste brojeve kao vasu okladu!");
			
			new
				ruletString[115];
			format( ruletString, 115, "Unesite koliko novca zelite staviti broj %d:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
				listitem,
				RTable[RouletteTable[playerid]][rtMinWage],
				RTable[RouletteTable[playerid]][rtMaxWage]
			);
			ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			return 1;
		}
		case DIALOG_CASINO_PAIR:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			
			RouletteType[playerid][RoulettSlot[playerid]] 	= ROULETTE_TYPE_PARNEPAR;
			RouletteParNepar[playerid][RoulettSlot[playerid]] = listitem;
			va_SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste %s brojeve kao vasu okladu!",  listitem ? ("parne") : ("~g~neparne"));
			new
				ruletString[115];
			format( ruletString, 115, "Unesite koliko novca zelite staviti broj %d:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
				listitem,
				RTable[RouletteTable[playerid]][rtMinWage],
				RTable[RouletteTable[playerid]][rtMaxWage]
			);
			ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			return 1;
		}
		case DIALOG_CASINO_R12:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			
			RouletteType[playerid][RoulettSlot[playerid]] 	= ROULETTE_TYPE_TUCET;
			RouletteTucet[playerid][RoulettSlot[playerid]] 	= listitem;
			SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste dvanaestine kao vasu okladu!");
			
			new
				ruletString[115];
			format( ruletString, 115, "Unesite koliko novca zelite staviti %d tucet dvanaestinu:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
				listitem+1,
				RTable[RouletteTable[playerid]][rtMinWage],
				RTable[RouletteTable[playerid]][rtMaxWage]
			);
			ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			return 1;
		}
		case DIALOG_CASINO_COLUMN:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			
			RouletteType[playerid][RoulettSlot[playerid]] 	= ROULETTE_TYPE_STUPAC;
			RouletteStupac[playerid][RoulettSlot[playerid]] 	= listitem;
			SendClientMessage( playerid, COLOR_RED, "[!] Odabrali ste stupce kao vasu okladu!");
			
			new
				ruletString[115];
			format( ruletString, 115, "Unesite koliko novca zelite staviti %d stupac dvanaestinu:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
				listitem+1,
				RTable[RouletteTable[playerid]][rtMinWage],
				RTable[RouletteTable[playerid]][rtMaxWage]
			);
			ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			return 1;
		}
		case DIALOG_CASINO_RBET:
		{
			if(!response) return ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
			new	
				inputWage = strval(inputtext);
			
			if(RouletteTable[playerid] == -1) return SendErrorMessage(playerid, "Dogodila se greska! Koristite rulet ponovno da bi igrali.");
			if(( RoulettWholeBet[playerid] + inputWage) > RTable[RouletteTable[playerid]][rtMaxWage]) {
				new
					ruletString[85];
				format( ruletString, 85, "Unesite koliko novca zelite staviti:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
					RTable[RouletteTable[playerid]][rtMinWage],
					RTable[RouletteTable[playerid]][rtMaxWage]
				);
				ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
				return 1;
			}

			if(RTable[RouletteTable[playerid]][rtMinWage] <= inputWage <= RTable[RouletteTable[playerid]][rtMaxWage])
			{
				if(AC_GetPlayerMoney(playerid) < inputWage) {
					GameTextForPlayer( playerid, "~r~Nemate toliko novca!", 1200, 1);
					PlayerPlaySound( playerid, 1085, 0.0, 0.0, 0.0);
					return 1;
				}
				
				PlayerToRouletteMoney(playerid, inputWage);
				
				// Wager TDs
				ShowRuletPotTDs(playerid);
				CreateRuletChips(playerid, RoulettSlot[playerid]);
				
				new
					tmpString[8];
				format( tmpString, 8, "$%d", 
					RTable[RouletteTable[playerid]][rtMaxWage]
				);
				PlayerTextDrawSetString( playerid, RuletPotMaxInput[playerid], tmpString);
				
				format( tmpString, 8, "$%d", 
					RoulettWholeBet[playerid]
				);
				PlayerTextDrawSetString( playerid, RuletPotWholeInput[playerid], tmpString);
				
				format( tmpString, 8, "$%d", 
					inputWage
				);
				PlayerTextDrawSetString( playerid, RuletPotNowInput[playerid], tmpString);				
				
				if(RuletWaitingForPlayers[playerid])
				{
					PlayerCoolDown[playerid][pCasinoCool]--;
					RuletWaitingTime[playerid] = 15;
					GameTextForPlayer(playerid, "~w~15", 1000, 4);

					WaitingRoulette[playerid] = repeat RuletWaitingTimer(playerid);
					RuletWaitingForPlayers[playerid] = true;
				}
				RoulettSlot[playerid]++;
			} else {
				new
					ruletString[85];
				format( ruletString, 85, "Unesite koliko novca zelite staviti:\n"COL_RED"Min.%d$/%d$ Max. unos novca!",
					RTable[RouletteTable[playerid]][rtMinWage],
					RTable[RouletteTable[playerid]][rtMaxWage]
				);
				ShowPlayerDialog( playerid, DIALOG_CASINO_RBET, DIALOG_STYLE_INPUT, "UNOS NOVCA ZA RULET", ruletString, "Input", "");
			}
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
CMD:rulet(playerid, params[])
{
	if(!PlayerCoolDown[playerid][pCasinoCool]) return SendClientMessage(playerid, COLOR_RED, "[ANTI-ABUSE]: Pricekajte do iduceg paydaya za novo igranje!");
	if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, COLOR_RED, "[ANTI-ABUSE]: Morate biti level 3+ za igranje u kasinu!");
	
	new cbizzid = GetPlayerCasinoID(playerid);
	if(cbizzid == INVALID_BIZNIS_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se u kasinu!");
	if(BizzInfo[cbizzid][bTill] <= 1000) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kasino nema dovoljno novaca za nastavak igre!");
		
	SendClientMessage(playerid, 0xF4D942AA, "Za pomoc upisite /rulethelp");
	new
		tableid = IsPlayerInRangeOfRuletTable( playerid);
	if(tableid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu stolova za rulet!");
	if(!IsPlayerInRangeOfPoint( playerid, 2.5, RTable[tableid][rtPosX], RTable[tableid][rtPosY], RTable[tableid][rtPosZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu svoga stola za rulet!");
	RouletteTable[playerid] = tableid;
	if(AC_GetPlayerMoney(playerid) < RTable[RouletteTable[playerid]][rtMinWage]) 
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money!");
		PlayerPlaySound( playerid, 5406, 0.0, 0.0, 0.0);
		return 1;
	}
	PlayerPlaySound( playerid, 5401, 0.0, 0.0, 0.0);
	ShowPlayerDialog( playerid, DIALOG_CASINO_RULET, DIALOG_STYLE_LIST, "ODABIR TIPA RULETA", "Brojevi\nBoje\nTuceti\nStupci\nPar-Nepar\n1-18\n19-36", "Choose", "Abort");
	return 1;
}

CMD:rulethelp(playerid, params[])
{
	SendClientMessage(playerid, 0xF4D942AA, "Brojevi: Ako pogodite broj ulog se mnozi sa 36. ");
	SendClientMessage(playerid, 0xF4D942AA, "Boje: Ako pogodite boju, ulog se mnozi sa 2.");
	SendClientMessage(playerid, 0xF4D942AA, "Tuceti (vertikalne dvanaestine / 12st):  Ako pogodite ulog se mnozi sa 3.");
	SendClientMessage(playerid, 0xF4D942AA, "Stupci (horizontalne dvanaestine / 3 to 1): Ako pogodite ulog se mnozi sa 3.");
	SendClientMessage(playerid, 0xF4D942AA, "Par-Nepar: Ako pogodite ulog se mnozi sa 2.");
	SendClientMessage(playerid, 0xF4D942AA, "1-18: Ako pogodite ulog se mnozi sa 2.");
	SendClientMessage(playerid, 0xF4D942AA, "19-36: Ako pogodite ulog se mnozi sa 2.");
	return 1;
}
