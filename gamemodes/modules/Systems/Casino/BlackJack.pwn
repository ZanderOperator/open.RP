#include <YSI_Coding\y_hooks>

// Defines
#define CARD_WIDTH			52.00
#define CARD_HEIGHT			84.00

#define GETTING_DEALER_CARDS	( 0 )
#define GETTING_PLAYER_CARDS	( 1 )

#define DEAL_CARDS_NUM (5)
//#define CASINO_GAIN_INDEX		0.3

enum E_BLACK_JACK_DATA
{
	Float:bjPosX,
	Float:bjPosY,
	Float:bjPosZ,
	bjMin,
	bjMax,
	bjPickupid
}
static const
	BlackJack[][ E_BLACK_JACK_DATA ] = {
		{ 793.6000, 423.5000, 1070.9000, 10, 		100 		},
		{ 793.6000, 428.4000, 1070.9000, 10, 		100 		},
		{ 791.4000, 423.6000, 1070.9000, 100, 		1000 		},
		{ 791.5000, 428.3000, 1070.9000, 100, 		1000 		}
	};

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

enum E_BLACK_JACK_CARDS
{
	bjcName[6],
	bjcScore
}

static const
	PlayingCards[][E_BLACK_JACK_CARDS] = {
		{ "cd1s", 	1 },
		{ "cd1h", 	1 },
		{ "cd1d", 	1 },
		{ "cd1c", 	1 },
		{ "cd2s", 	2 },
		{ "cd2h", 	2 },
		{ "cd2d", 	2 },
		{ "cd2c", 	2 },
		{ "cd3s", 	3 },
		{ "cd3h", 	3 },
		{ "cd3d", 	3 },
		{ "cd3c", 	3 },
		{ "cd4s", 	4 },
		{ "cd4h", 	4 },
		{ "cd4d", 	4 },
		{ "cd4c", 	4 },
		{ "cd5s", 	5 },
		{ "cd5h", 	5 },
		{ "cd5d", 	5 },
		{ "cd5c", 	5 },
		{ "cd6s", 	6 },
		{ "cd6h", 	6 },
		{ "cd6d", 	6 },
		{ "cd6c", 	6 },
		{ "cd7s", 	7 },
		{ "cd7h", 	7 },
		{ "cd7d", 	7 },
		{ "cd7c", 	7 },
		{ "cd8s", 	8 },
		{ "cd8h", 	8 },
		{ "cd8d", 	8 },
		{ "cd8c", 	8 },
		{ "cd9s", 	9 },
		{ "cd9h", 	9 },
		{ "cd9d", 	9 },
		{ "cd9c", 	9 },
		{ "cd10s", 	10},
		{ "cd10h", 	10},
		{ "cd10d", 	10},
		{ "cd10c", 	10},
		{ "cd11s", 	11},
		{ "cd11h", 	11},
		{ "cd11d", 	11},
		{ "cd11c", 	11},
		{ "cd12s", 	12},
		{ "cd12h", 	12},
		{ "cd12d", 	12},
		{ "cd12c", 	12},
		{ "cd13s", 	13},
		{ "cd13h", 	13},
		{ "cd13d", 	13},
		{ "cd13c", 	13}
	};

static
	BlackJackWager[ MAX_PLAYERS ],
	LastPlayerBJCard[ MAX_PLAYERS ],
	LastDealerBJCard[ MAX_PLAYERS ],
	BlackJackTable[ MAX_PLAYERS ],
	PlayerBJCard[ MAX_PLAYERS ][ 6 ],
	DealerBJCard[ MAX_PLAYERS ][ 6 ],
	// TODO: split this into two 2D arrays: one holding the card index, and other with the card name
	// Alternatively, just use the two arrays above, and just get the card name when needed.
	// A cards index is enough to identify the card.
	PlayerBJTDCard[ MAX_PLAYERS ][ 6 ][ 33 ],
	DealerBJTDCard[ MAX_PLAYERS ][ 6 ][ 33 ],
	PlayerBlackjackState[MAX_PLAYERS],
	DealerCardExpose[MAX_PLAYERS],
	// TODO: no need for these two last variables as all information is already contained
	// in the arrays Player/DealerBJCard. Just loop through the indices and check if its a valid card num.
	PlayerDealtCardsNum[MAX_PLAYERS],
	DealerDealtCardsNum[MAX_PLAYERS];

static
	PlayerText:PlayerBlackCards[ MAX_PLAYERS ][ 5 ],
	PlayerText:DealerBlackCards[ MAX_PLAYERS ][ 5 ],
	PlayerText:PlayerBlackBcg[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:DealerBlackBcg[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageBcg[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageTitle[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageWholet[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageWholen[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageDealert[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWageDealers[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWagePlayert[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:BlackWagePlayers[ MAX_PLAYERS ]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:WagerHelpBcg[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:WagerHelpText[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:PlayHelpBcg[MAX_PLAYERS]			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:PlayHelpText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };

static
	Iterator:JackTables<4>;
/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
/*stock InitBlackJackDealers()
{	
	BlackJackDealer[0] = CreateActor(171, 793.2108, 423.5000, 1070.9000, 270.0);
	BlackJackDealer[1] = CreateActor(171, 793.2108, 428.4000, 1070.9000, 270.0);	
	BlackJackDealer[2] = CreateActor(171, 791.7794, 423.4688, 1070.9000, 90.0);
	BlackJackDealer[3] = CreateActor(171, 791.8743, 428.3210, 1070.8688, 90.0);
}

stock DestoryBlackJackWorkers()
{
	DestroyActor(BlackJackDealer[0]);
	DestroyActor(BlackJackDealer[1]);
	DestroyActor(BlackJackDealer[2]);
	DestroyActor(BlackJackDealer[3]);
}*/

static stock DestroyBlackJackWagerHelpTDs(playerid)
{
	if (WagerHelpBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, WagerHelpBcg[playerid]);
		WagerHelpBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if (WagerHelpText[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, WagerHelpText[playerid]);
		WagerHelpText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}

static stock CreateBlackJackWagerHelpTDs(playerid)
{
	DestroyBlackJackWagerHelpTDs(playerid);

	WagerHelpBcg[playerid] = CreatePlayerTextDraw(playerid, 618.700073, 110.027999, "usebox");
	PlayerTextDrawLetterSize(playerid, WagerHelpBcg[playerid], 0.000000, 4.837780);
	PlayerTextDrawTextSize(playerid, WagerHelpBcg[playerid], 487.900054, 0.000000);
	PlayerTextDrawAlignment(playerid, WagerHelpBcg[playerid], 1);
	PlayerTextDrawColor(playerid, WagerHelpBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, WagerHelpBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, WagerHelpBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, WagerHelpBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WagerHelpBcg[playerid], 0);
	PlayerTextDrawFont(playerid, WagerHelpBcg[playerid], 0);
	PlayerTextDrawShow(playerid, WagerHelpBcg[playerid]);

	WagerHelpText[playerid] = CreatePlayerTextDraw(playerid, 494.199951, 114.015975, "~k~~PED_JUMPING~ povisi ulog~n~~k~~SNEAK_ABOUT~ smanji ulog~n~~k~~PED_SPRINT~ igraj");
	PlayerTextDrawLetterSize(playerid, WagerHelpText[playerid], 0.327000, 1.155359);
	PlayerTextDrawAlignment(playerid, WagerHelpText[playerid], 1);
	PlayerTextDrawColor(playerid, WagerHelpText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WagerHelpText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WagerHelpText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WagerHelpText[playerid], 51);
	PlayerTextDrawFont(playerid, WagerHelpText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WagerHelpText[playerid], 1);
	PlayerTextDrawShow(playerid, WagerHelpText[playerid]);
	return 1;
}

static stock DestroyBlackJackPlayHelpTDs(playerid)
{
	if (PlayHelpBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, PlayHelpBcg[playerid]);
		PlayHelpBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if (PlayHelpText[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, PlayHelpText[playerid]);
		PlayHelpText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}

static stock CreateBlackJackPlayHelpTDs(playerid)
{
	DestroyBlackJackPlayHelpTDs(playerid);
	
	PlayHelpBcg[playerid] = CreatePlayerTextDraw(playerid, 619.249938, 110.027999, "usebox");
	PlayerTextDrawLetterSize(playerid, PlayHelpBcg[playerid], 0.000000, 5.422783);
	PlayerTextDrawTextSize(playerid, PlayHelpBcg[playerid], 487.900054, 0.000000);
	PlayerTextDrawAlignment(playerid, PlayHelpBcg[playerid], 1);
	PlayerTextDrawColor(playerid, PlayHelpBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, PlayHelpBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, PlayHelpBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, PlayHelpBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PlayHelpBcg[playerid], 0);
	PlayerTextDrawFont(playerid, PlayHelpBcg[playerid], 0);
	PlayerTextDrawShow(playerid, PlayHelpBcg[playerid]);

	PlayHelpText[playerid] = CreatePlayerTextDraw(playerid, 494.199951, 114.015975, "~k~~CONVERSATION_NO~ za izlazak iz igre~n~~k~~PED_FIREWEAPON~ igraj~n~~k~~PED_DUCK~ stick~n~~k~~VEHICLE_ENTER_EXIT~ izlaz");
	PlayerTextDrawLetterSize(playerid, PlayHelpText[playerid], 0.326999, 1.155359);
	PlayerTextDrawAlignment(playerid, PlayHelpText[playerid], 1);
	PlayerTextDrawColor(playerid, PlayHelpText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PlayHelpText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PlayHelpText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayHelpText[playerid], 51);
	PlayerTextDrawFont(playerid, PlayHelpText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayHelpText[playerid], 1);
	PlayerTextDrawShow(playerid, PlayHelpText[playerid]);
}

static stock DestroyBlackJackWagerTDs(playerid)
{
	PlayerTextDrawDestroy( playerid, BlackWageBcg[playerid]		);
	PlayerTextDrawDestroy( playerid, BlackWageTitle[playerid]	);
	PlayerTextDrawDestroy( playerid, BlackWageWholet[playerid]	);
	PlayerTextDrawDestroy( playerid, BlackWageWholen[playerid]	);
	PlayerTextDrawDestroy( playerid, BlackWageDealert[playerid] );
	PlayerTextDrawDestroy( playerid, BlackWageDealers[playerid] );
	PlayerTextDrawDestroy( playerid, BlackWagePlayert[playerid] );
	PlayerTextDrawDestroy( playerid, BlackWagePlayers[playerid] );

	BlackWageBcg[playerid]		= PlayerText:INVALID_TEXT_DRAW;
	BlackWageTitle[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWageWholet[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWageWholen[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWageDealert[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWageDealers[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWagePlayert[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	BlackWagePlayers[playerid]	= PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

static stock CreateBlackJackWagerTDs(playerid)
{
	DestroyBlackJackWagerTDs(playerid);

	BlackWageBcg[playerid] = CreatePlayerTextDraw(playerid, 135.050033, 181.166671, "usebox");
	PlayerTextDrawLetterSize(playerid, BlackWageBcg[playerid], 0.000000, 13.992408);
	PlayerTextDrawTextSize(playerid, BlackWageBcg[playerid], 35.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, BlackWageBcg[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, BlackWageBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, BlackWageBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, BlackWageBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BlackWageBcg[playerid], 0);
	PlayerTextDrawFont(playerid, BlackWageBcg[playerid], 0);
	PlayerTextDrawShow(playerid, BlackWageBcg[playerid]);

	BlackWageTitle[playerid] = CreatePlayerTextDraw(playerid, 44.449977, 162.283294, "Ulog");
	PlayerTextDrawLetterSize(playerid, BlackWageTitle[playerid], 0.893349, 2.892082);
	PlayerTextDrawAlignment(playerid, BlackWageTitle[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, BlackWageTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BlackWageTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BlackWageTitle[playerid], 51);
	PlayerTextDrawFont(playerid, BlackWageTitle[playerid], 0);
	PlayerTextDrawSetProportional(playerid, BlackWageTitle[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWageTitle[playerid]);

	BlackWageWholet[playerid] = CreatePlayerTextDraw(playerid, 41.750011, 204.458251, "Cijeli Ulog");
	PlayerTextDrawLetterSize(playerid, BlackWageWholet[playerid], 0.434849, 1.405749);
	PlayerTextDrawAlignment(playerid, BlackWageWholet[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageWholet[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, BlackWageWholet[playerid], 1);
	PlayerTextDrawSetOutline(playerid, BlackWageWholet[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, BlackWageWholet[playerid], 255);
	PlayerTextDrawFont(playerid, BlackWageWholet[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWageWholet[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWageWholet[playerid]);

	BlackWageWholen[playerid] = CreatePlayerTextDraw(playerid, 44.550010, 219.391754, "$100");
	PlayerTextDrawLetterSize(playerid, BlackWageWholen[playerid], 0.415300, 1.343916);
	PlayerTextDrawAlignment(playerid, BlackWageWholen[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageWholen[playerid], -1);
	PlayerTextDrawSetShadow(playerid, BlackWageWholen[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BlackWageWholen[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BlackWageWholen[playerid], 51);
	PlayerTextDrawFont(playerid, BlackWageWholen[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWageWholen[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWageWholen[playerid]);

	BlackWageDealert[playerid] = CreatePlayerTextDraw(playerid, 41.750011, 236.250015, "Diler");
	PlayerTextDrawLetterSize(playerid, BlackWageDealert[playerid], 0.434849, 1.405749);
	PlayerTextDrawAlignment(playerid, BlackWageDealert[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageDealert[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, BlackWageDealert[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BlackWageDealert[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BlackWageDealert[playerid], 51);
	PlayerTextDrawFont(playerid, BlackWageDealert[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWageDealert[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWageDealert[playerid]);

	BlackWageDealers[playerid] = CreatePlayerTextDraw(playerid, 44.550010, 251.999954, "???");
	PlayerTextDrawLetterSize(playerid, BlackWageDealers[playerid], 0.415300, 1.343916);
	PlayerTextDrawAlignment(playerid, BlackWageDealers[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWageDealers[playerid], -1);
	PlayerTextDrawSetShadow(playerid, BlackWageDealers[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BlackWageDealers[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BlackWageDealers[playerid], 51);
	PlayerTextDrawFont(playerid, BlackWageDealers[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWageDealers[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWageDealers[playerid]);
	
	BlackWagePlayert[playerid] = CreatePlayerTextDraw(playerid, 41.750011, 270.258239, "Vi");
	PlayerTextDrawLetterSize(playerid, BlackWagePlayert[playerid], 0.434849, 1.405749);
	PlayerTextDrawAlignment(playerid, BlackWagePlayert[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWagePlayert[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, BlackWagePlayert[playerid], 1);
	PlayerTextDrawSetOutline(playerid, BlackWagePlayert[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, BlackWagePlayert[playerid], 255);
	PlayerTextDrawFont(playerid, BlackWagePlayert[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWagePlayert[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWagePlayert[playerid]);

	BlackWagePlayers[playerid] = CreatePlayerTextDraw(playerid, 44.550010, 285.833374, "21");
	PlayerTextDrawLetterSize(playerid, BlackWagePlayers[playerid], 0.415300, 1.343916);
	PlayerTextDrawAlignment(playerid, BlackWagePlayers[playerid], 1);
	PlayerTextDrawColor(playerid, BlackWagePlayers[playerid], -1);
	PlayerTextDrawSetShadow(playerid, BlackWagePlayers[playerid], 1);
	PlayerTextDrawSetOutline(playerid, BlackWagePlayers[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, BlackWagePlayers[playerid], 255);
	PlayerTextDrawFont(playerid, BlackWagePlayers[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackWagePlayers[playerid], 1);
	PlayerTextDrawShow(playerid, BlackWagePlayers[playerid]);
}

static stock CreateBlackJackBackground(playerid)
{
	DestroyPlayerBlackBcg(playerid);

	PlayerBlackBcg[playerid] = CreatePlayerTextDraw(playerid, 478.249816, 340.467529, "usebox");
	PlayerTextDrawLetterSize(playerid, PlayerBlackBcg[playerid], 0.000000, 9.954999);
	PlayerTextDrawTextSize(playerid, PlayerBlackBcg[playerid], 197.499984, 0.000000);
	PlayerTextDrawAlignment(playerid, PlayerBlackBcg[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerBlackBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, PlayerBlackBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, PlayerBlackBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, PlayerBlackBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBlackBcg[playerid], 0);
	PlayerTextDrawFont(playerid, PlayerBlackBcg[playerid], 0);
	PlayerTextDrawShow(playerid, PlayerBlackBcg[playerid]);

	DealerBlackBcg[playerid] = CreatePlayerTextDraw(playerid, 478.249816, 17.684036, "usebox");
	PlayerTextDrawLetterSize(playerid, 	DealerBlackBcg[playerid], 0.000000, 9.763334);
	PlayerTextDrawTextSize(playerid, 	DealerBlackBcg[playerid], 197.499984, 0.000000);
	PlayerTextDrawAlignment(playerid, 	DealerBlackBcg[playerid], 1);
	PlayerTextDrawColor(playerid,		DealerBlackBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, 		DealerBlackBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, 	DealerBlackBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 	DealerBlackBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 	DealerBlackBcg[playerid], 0);
	PlayerTextDrawFont(playerid, 		DealerBlackBcg[playerid], 0);
	PlayerTextDrawShow(playerid,		DealerBlackBcg[playerid]);
	return 1;
}

stock PlayerText:CreateBlackJackCard(playerid, Float:PosX, Float:PosY, card[])
{
	new
		PlayerText:tmpBlackCard = va_CreatePlayerTextDraw(playerid, PosX, PosY, "%s", card);
	PlayerTextDrawLetterSize(playerid, 	tmpBlackCard, 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, 	tmpBlackCard, CARD_WIDTH, CARD_HEIGHT);
	PlayerTextDrawAlignment(playerid, 	tmpBlackCard, 1);
	PlayerTextDrawColor(playerid, 		tmpBlackCard, -1);
	PlayerTextDrawSetShadow(playerid, 	tmpBlackCard, 0);
	PlayerTextDrawSetOutline(playerid, 	tmpBlackCard, 0);
	PlayerTextDrawFont(playerid, 		tmpBlackCard, 4);
	PlayerTextDrawShow(playerid, 		tmpBlackCard);
	return tmpBlackCard;
}

static stock DestroyPlayerBlackBcg(playerid)
{
	if (PlayerBlackBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, PlayerBlackBcg[playerid]);
		PlayerBlackBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}

	if (DealerBlackBcg[playerid] != PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid, DealerBlackBcg[playerid]);
		DealerBlackBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

static stock DestroyPlayerBlackCards(playerid)
{
	for (new i = 0; i != DEAL_CARDS_NUM; i++)
	{
		if (PlayerBlackCards[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
		{
			PlayerTextDrawDestroy(playerid, PlayerBlackCards[playerid][i]);
			PlayerBlackCards[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}

		if (DealerBlackCards[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
		{
			PlayerTextDrawDestroy(playerid, DealerBlackCards[playerid][i]);
			DealerBlackCards[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

static stock ShowBlackJackCards(playerid)
{
	new
		Float:PosX	= 202.55,
		Float:PosY	= 342.72,
		Float:DPosX	= 202.55,
		Float:DPosY = 19.88;
	
	DestroyPlayerBlackCards(playerid);	
	PlayerPlaySound( playerid, 5600, 0.0, 0.0, 0.0 );
	
	for (new i = 0; i < DEAL_CARDS_NUM; i++)
	{
		if (i < PlayerDealtCardsNum[playerid])
		{
			PlayerBlackCards[ playerid ][ i ] = CreateBlackJackCard(playerid, PosX, PosY, PlayerBJTDCard[ playerid ][ i ] );
			
			new
				tmpString[ 16 ],
				result = GetPlayerBlackJackScore(playerid);
			format(tmpString, 16, "%d",
				result
			);
			
			// Winner?
			if( result == 21 ) {
				PlayerPlaySound( playerid, 5812, 0.0, 0.0, 0.0 );
				new
					tmpTxt[ 25 ],
					money = BlackJackWager[ playerid ];
					
				format( tmpTxt, 25, "~g~Winner~n~~w~%d$",
					money
				);
				GameTextForPlayer( playerid, tmpTxt, 1500, 6 );
				BusinessToPlayerMoney(playerid, 104, money); // Novac iz kasina ide igracu
				
				DestroyBlackJackPlayHelpTDs(playerid);
				ResetBlackJack(playerid);
			}
			
			// Busting?
			if( result > 21 ) {
				PlayerPlaySound( playerid, 5813, 0.0, 0.0, 0.0 );
				new
					tmpTxt[ 25 ];
				format( tmpTxt, 25, "~r~Busting~n~~w~%d$",
					BlackJackWager[ playerid ]
				);
				GameTextForPlayer( playerid, tmpTxt, 1500, 6 );
				PlayerToBusinessMoney(playerid, 104, BlackJackWager[ playerid ]); // Novac od igraca ide kasinu (bizid: 104)
				DestroyBlackJackPlayHelpTDs(playerid);
				ResetBlackJack(playerid);
			}
			// TD
			PlayerTextDrawSetString( playerid, BlackWagePlayers[playerid], tmpString );			
			PosX 	+= CARD_WIDTH + 2.0;
		}

		if (i < DealerDealtCardsNum[playerid])
		{
			if (i == 0 && !DealerCardExpose[playerid])
				DealerBlackCards[ playerid ][ i ] = CreateBlackJackCard(playerid, DPosX, DPosY, "LD_CARD:cdback");
			else 	
				DealerBlackCards[ playerid ][ i ] = CreateBlackJackCard(playerid, DPosX, DPosY, DealerBJTDCard[ playerid ][ i ] );

			DPosX 	+= CARD_WIDTH + 2.0;
		}
	}
	return 1;
}

static stock GetDealerBlackJackScore(playerid)
{
	new
		count = 0;
	for( new i = 0; i < DEAL_CARDS_NUM; i++ ) {
		if( DealerBJCard[ playerid ][ i ] != -1 ) {
			if( PlayingCards[ DealerBJCard[ playerid ][ i ] ][ bjcScore ] == 1 ) {
				if( 0 <= count <= 9 )
					count += PlayingCards[ DealerBJCard[ playerid ][ i ] ][ bjcScore ] + 10;
				else
					count += PlayingCards[ DealerBJCard[ playerid ][ i ] ][ bjcScore ] + 1;
			}
			else
				count += PlayingCards[ DealerBJCard[ playerid ][ i ] ][ bjcScore ];
		}
	}
	return count;
}

static stock GetPlayerBlackJackScore(playerid)
{
	new
		count = 0;
	for( new i = 0; i < DEAL_CARDS_NUM; i++ ) {
		if( PlayerBJCard[ playerid ][ i ] != -1 ) {
			if( PlayingCards[ PlayerBJCard[ playerid ][ i ] ][ bjcScore ] == 1 ) {
				if( 0 <= count <= 9 )
					count += PlayingCards[ PlayerBJCard[ playerid ][ i ] ][ bjcScore ] + 10;
				else
					count += PlayingCards[ PlayerBJCard[ playerid ][ i ] ][ bjcScore ] + 1;
			}
			else
				count += PlayingCards[ PlayerBJCard[ playerid ][ i ] ][ bjcScore ];
		}
	}
	return count;
}

static stock GetBlackJackCard(playerid, type)
{
	loop_start:
	
	new
		cardid = random(random(51));	
	if( type == GETTING_DEALER_CARDS ) {
		if( cardid < 50 )
			cardid ++;
			
		if( PlayerBJCard[playerid][0] != cardid && PlayerBJCard[playerid][1] != cardid && PlayerBJCard[playerid][2] != cardid && PlayerBJCard[playerid][3] != cardid && PlayerBJCard[playerid][4] != cardid ) {
			if( DealerBJCard[playerid][0] != cardid && DealerBJCard[playerid][1] != cardid ) {
				DealerBJCard[ playerid ][ LastDealerBJCard[playerid] ] = cardid;
				printf("DEBUG: score(%d)", PlayingCards[ DealerBJCard[ playerid ][ LastDealerBJCard[playerid] ] ][ bjcScore ]);
				
				format( DealerBJTDCard[ playerid ][ LastDealerBJCard[playerid] ], 32, "LD_CARD:%s", PlayingCards[cardid][bjcName] );
				LastDealerBJCard[playerid]++;
			}
			else 
				goto loop_start;
		}
		else 
			goto loop_start;
		return 1;
	}
	else if( type == GETTING_PLAYER_CARDS ) {
		if( cardid > 2 && random(3) == 2 )
			cardid--;
		
		if (DealerBJCard[playerid][0] != cardid && DealerBJCard[playerid][1] != cardid)
		{
			if (PlayerBJCard[playerid][0] != cardid && PlayerBJCard[playerid][1] != cardid &&
				PlayerBJCard[playerid][2] != cardid && PlayerBJCard[playerid][3] != cardid &&
				PlayerBJCard[playerid][4] != cardid )
			{
				PlayerBJCard[ playerid ][ LastPlayerBJCard[playerid] ] = cardid;
				format( PlayerBJTDCard[ playerid ][ LastPlayerBJCard[playerid] ], 32, "LD_CARD:%s", PlayingCards[ cardid ][ bjcName ] );
				LastPlayerBJCard[playerid]++;
			}
			else 
				goto loop_start;
		}
		else 
			goto loop_start;
		return 1;
	}
	return 1;
}

stock ResetBlackJack(playerid)
{
	// TextDraws
	DestroyBlackJackWagerTDs(playerid);
	DestroyPlayerBlackBcg(playerid);
	DestroyPlayerBlackCards(playerid);

	BlackJackWager[ playerid ] 				= 0;
	LastPlayerBJCard[ playerid ]			= 0;
	LastDealerBJCard[ playerid ]			= 0;
	BlackJackTable[ playerid ]				= -1;

	for (new i = 0; i != DEAL_CARDS_NUM; i++)
	{
		DealerBJCard[playerid][i] = -1;
		PlayerBJCard[playerid][i] = -1;

		PlayerBJTDCard[playerid][i][0] = EOS;
		DealerBJTDCard[playerid][i][0] = EOS;
	}

	DealerCardExpose[playerid] = false;
	PlayerBlackjackState[playerid] = 0;
	PlayerDealtCardsNum[playerid] = 0;
	DealerDealtCardsNum[playerid] = 0;
	
	TogglePlayerControllable(playerid, true);
	return 1;
}

static stock CheckPlayerBlackJackWinner(playerid)
{
	new
		dealerScore = GetDealerBlackJackScore(playerid), 
		playerScore = GetPlayerBlackJackScore(playerid),
		money = BlackJackWager[ playerid ] + floatround( BlackJackWager[ playerid ] * 0.8 ),
		tmpString[ 25 ];

	DestroyBlackJackWagerTDs(playerid);
	DestroyPlayerBlackBcg(playerid);
	DestroyPlayerBlackCards(playerid);
	DestroyBlackJackPlayHelpTDs(playerid);
	
	if( dealerScore == playerScore ) { 											// Push
		PlayerPlaySound(playerid, 5815, 0.0, 0.0, 0.0);
		GameTextForPlayer( playerid, "~w~Push", 1200, 6 );
	}
	else if( dealerScore == 21 && playerScore == 21 ) {							// Push
		PlayerPlaySound(playerid, 5816, 0.0, 0.0, 0.0);
		GameTextForPlayer( playerid, "~w~Push", 1200, 6 );
	}
	else if( dealerScore > playerScore ) {	// Dealer
		if( 1 <= dealerScore <= 21 ) {
			format( tmpString, 25, "~r~Loser~n~~w~%d$",
				BlackJackWager[ playerid ]
			);
			GameTextForPlayer( playerid, tmpString, 1500, 6 );
			PlayerToBusinessMoney(playerid, 104, BlackJackWager[ playerid ]); // Novac od igraca ide kasinu (bizid: 104)
			switch(random(random(3))) {
				case 0: PlayerPlaySound(playerid, 5816, 0.0, 0.0, 0.0);
				case 1: PlayerPlaySound(playerid, 5817, 0.0, 0.0, 0.0);
				case 2: PlayerPlaySound(playerid, 5818, 0.0, 0.0, 0.0);
			}
		} else {
			format( tmpString, 25, "~g~Winner~n~~w~%d$",
				money
			);
			GameTextForPlayer( playerid, tmpString, 1500, 6 );
			BusinessToPlayerMoney(playerid, 104, money); // Novac iz kasina ide igracu
			PlayerPlaySound(playerid, 5818, 0.0, 0.0, 0.0);
			
			if( dealerScore == 21 ) {
				switch( random(random(2)) ) {
					case 0: PlayerPlaySound(playerid, 	5811, 0.0, 0.0, 0.0);
					case 1: PlayerPlaySound(playerid, 	5812, 0.0, 0.0, 0.0);
					default: PlayerPlaySound(playerid, 	5811, 0.0, 0.0, 0.0);
				}
			} else {
				switch( random(random(3)) ) {
					case 0: PlayerPlaySound(playerid, 5848, 0.0, 0.0, 0.0);
					case 1: PlayerPlaySound(playerid, 5849, 0.0, 0.0, 0.0);
					case 2: PlayerPlaySound(playerid, 5856, 0.0, 0.0, 0.0);
				}
			}
		}
	}
	else if( ( playerScore > dealerScore ) ) {	// Player
		if( 1 <= playerScore <= 21 ) {
			format( tmpString, 25, "~g~Winner~n~~w~%d$",
				money
			);
			GameTextForPlayer( playerid, tmpString, 1500, 6 );
			BusinessToPlayerMoney(playerid, 104, money); // Novac iz kasina ide igracu
			
			if( dealerScore == 21 ) {
				switch( random(random(2)) ) {
					case 0: PlayerPlaySound(playerid, 	5811, 0.0, 0.0, 0.0);
					case 1: PlayerPlaySound(playerid, 	5812, 0.0, 0.0, 0.0);
					default: PlayerPlaySound(playerid, 	5811, 0.0, 0.0, 0.0);
				}
			} else {
				switch( random(random(3)) ) {
					case 0: PlayerPlaySound(playerid, 5848, 0.0, 0.0, 0.0);
					case 1: PlayerPlaySound(playerid, 5849, 0.0, 0.0, 0.0);
					case 2: PlayerPlaySound(playerid, 5856, 0.0, 0.0, 0.0);
				}
			}
		} else {
			format( tmpString, 25, "~r~Loser~n~~w~%d$",
				BlackJackWager[ playerid ]
			);
			GameTextForPlayer( playerid, tmpString, 1500, 6 );
			PlayerToBusinessMoney(playerid, 104, BlackJackWager[ playerid ]); // Novac od igraca ide kasinu (bizid: 104)
			
			switch( random(3) ) {
				case 0: PlayerPlaySound(playerid, 5816, 0.0, 0.0, 0.0);
				case 1: PlayerPlaySound(playerid, 5817, 0.0, 0.0, 0.0);
				case 2: PlayerPlaySound(playerid, 5818, 0.0, 0.0, 0.0);
			}
		}
	}
}

stock InitBlackJackTables()
{
	BlackJack[ 0 ][ bjPickupid ] = CreateDynamicPickup(19300, 2, BlackJack[ 0 ][ bjPosX ] + 1.3799, BlackJack[ 0 ][ bjPosY ], BlackJack[ 0 ][ bjPosZ ], 0, 5, -1, 10.0);
	Iter_Add( JackTables, 0 );

	BlackJack[ 1 ][ bjPickupid ] = CreateDynamicPickup(19300, 2, BlackJack[ 1 ][ bjPosX ] + 1.3799, BlackJack[ 1 ][ bjPosY ], BlackJack[ 1 ][ bjPosZ ], 0, 5, -1, 10.0);
	Iter_Add( JackTables, 1 );

	BlackJack[ 2 ][ bjPickupid ] = CreateDynamicPickup(19300, 2, BlackJack[ 2 ][ bjPosX ] - 1.4708, BlackJack[ 2 ][ bjPosY ], BlackJack[ 2 ][ bjPosZ ], 0, 5, -1, 10.0);
	Iter_Add( JackTables, 2 );

	BlackJack[ 3 ][ bjPickupid ] = CreateDynamicPickup(19300, 2, BlackJack[ 3 ][ bjPosX ] - 1.4708, BlackJack[ 3 ][ bjPosY ], BlackJack[ 3 ][ bjPosZ ], 0, 5, -1, 10.0);
	Iter_Add( JackTables, 3 );
	
	printf("Script Report: %d blackjack tables loaded!", Iter_Count(JackTables));
}

static stock IsPlayerNearBlackJackTable(playerid)
{
	new
		tableid = -1;
	foreach(new i : JackTables) {
		if( IsPlayerInRangeOfPoint( playerid, 2.5, BlackJack[ i ][ bjPosX ], BlackJack[ i ][ bjPosY ], BlackJack[ i ][ bjPosZ ] ) ) {
			tableid = i;
			break;
		}
	}
	return tableid;
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

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{ 
	foreach(new tableid : JackTables)
	{
		if( pickupid == BlackJack[ tableid ][ bjPickupid ] )
		{
			ShowRuletPickupTDs(playerid);
			new	
				tmpString[ 50 ];
			
			format( tmpString, 50, "   Blackjack %d",
				tableid+1
			);
			// TODO: RuletTitle text draw should be made private to the "Rulet.pwn" module.
			PlayerTextDrawSetString(playerid, RuletTitle[playerid], tmpString);
			
			format( tmpString, 50, "Min. Ulog: %d$~n~Max. Ulog: %d$",
				BlackJack[ tableid ][ bjMin ],
				BlackJack[ tableid ][ bjMax ]
			);
			// TODO: all these text draws should be made private to the "Rulet.pwn" module.
			// Make your own text draws for this module and DO NOT introduce coupling.
			// If something is to be shared by multiple modules, extract that functionality
			// into a higher level module that shall be used by both via a API.
			PlayerTextDrawSetString(playerid, RuletWages[playerid], tmpString);
			PlayerTextDrawSetString(playerid, RuletNote[playerid], "Kucajte /blackjack za igru");
			
			defer FadeRuletWagesTD(playerid);
			break;
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// KEY_SECONDARY_ATTACK		- Gasi cijeli blackjack
	// KEY_JUMP 				- Povisuje ulog
	// KEY_WALK					- Smanjuje ulog
	// KEY_SPRINT 				- Pocinje play faza
	// KEY_NO					- Predaje se i dobije polovicu uloga (samo u prvoj ruci!)
	// KEY_FIRE					- Hit
	// KEY_CROUCH				- Stay

	if (PlayerBlackjackState[playerid] < 1)
	{
		return 1;
	}

	if ((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT))
	{
		if (AC_GetPlayerMoney(playerid) < BlackJackWager[playerid])
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have enough money!");

			// TODO: PlayRandomDeniedSound(playerid)
			switch (random(2))
			{
				case 0:  PlayerPlaySound(playerid, 5823, 0.0, 0.0, 0.0);
				case 1:  PlayerPlaySound(playerid, 5824, 0.0, 0.0, 0.0);
				case 2:  PlayerPlaySound(playerid, 5825, 0.0, 0.0, 0.0);
				default: PlayerPlaySound(playerid, 5823, 0.0, 0.0, 0.0);
			}
			return 1;
		}

		// TODO: this should be a general purpose per-player or per-module cooldown variable
		PlayerCoolDown[playerid][pCasinoCool]--;

		// Postavke karata
		PlayerDealtCardsNum[playerid] = DealerDealtCardsNum[playerid] = 2;

		CreateBlackJackBackground(playerid);
		DestroyBlackJackWagerTDs(playerid);
		CreateBlackJackWagerTDs(playerid);

		DestroyBlackJackWagerHelpTDs(playerid);
		CreateBlackJackPlayHelpTDs(playerid);

		GetBlackJackCard(playerid, GETTING_PLAYER_CARDS);
		GetBlackJackCard(playerid, GETTING_PLAYER_CARDS);

		GetBlackJackCard(playerid, GETTING_DEALER_CARDS);
		GetBlackJackCard(playerid, GETTING_DEALER_CARDS);
		ShowBlackJackCards(playerid);

		// TODO: this should become a helper function UpdatePlayerWager or sth
		new str[9];
		format(str, sizeof(str), "$%d", BlackJackWager[playerid]);
		PlayerTextDrawSetString(playerid, BlackWageWholen[playerid], str);

		PlayerBlackjackState[playerid] = 2;
		return 1;
	}

	if ((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP))
	{
		if (BlackJackWager[playerid] >= BlackJack[BlackJackTable[playerid]][bjMax])
			return 1;

		BlackJackWager[playerid]++;
		// TODO: code repetition
		new str[9];
		format(str, sizeof(str), "$%d", BlackJackWager[playerid]);
		PlayerTextDrawSetString(playerid, BlackWageWholen[playerid], str);
	}

	if ((newkeys & KEY_WALK) && !(oldkeys & KEY_WALK))
	{
		if (PlayerBlackjackState[playerid] != 1)
		{
			return 1;
		}

		if (BlackJackWager[playerid] <= BlackJack[BlackJackTable[playerid]][bjMin])
			return 1;

		BlackJackWager[playerid]--;

		new str[9];
		format(str, sizeof(str), "$%d", BlackJackWager[playerid]);
		PlayerTextDrawSetString(playerid, BlackWageWholen[playerid], str);
	}

	if ((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
	{
		DestroyBlackJackWagerTDs(playerid);
		DestroyPlayerBlackBcg(playerid);
		DestroyPlayerBlackCards(playerid);
		DestroyBlackJackPlayHelpTDs(playerid);
		DestroyBlackJackWagerHelpTDs(playerid);

		if (PlayerBlackjackState[playerid] == 2)
		{
			PlayerToBusinessMoney(playerid, 104, BlackJackWager[playerid]); // Novac od igraca ide kasinu (bizid: 104)
		}
		ResetBlackJack(playerid);
	}

	if ((newkeys & KEY_NO) && !(oldkeys & KEY_NO))
	{
		if (PlayerBlackjackState[playerid] == 2)
		{
			DestroyBlackJackWagerTDs(playerid);
			DestroyPlayerBlackBcg(playerid);
			DestroyPlayerBlackCards(playerid);

			GameTextForPlayer(playerid, "~w~Odustali ste i vraceno vam je pola uloga!", 1300, 1);
			PlayerToBusinessMoney(playerid, 104, BlackJackWager[playerid] / 2); // Novac od igraca ide kasinu (bizid: 104)

			ResetBlackJack(playerid);
		}
		else
		{
			GameTextForPlayer(playerid, "Niste u prvoj ruci!", 900, 1);
		}
	}

	if ((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE))
	{
		if (PlayerBlackjackState[playerid] != 2)
		{
			return 1;
		}
		if (PlayerDealtCardsNum[playerid] < 5)
		{
			GetBlackJackCard(playerid, GETTING_PLAYER_CARDS);
			// TODO: this variable should be increased in a function that deals in the cards
			PlayerDealtCardsNum[playerid] = PlayerDealtCardsNum[playerid] + 1;

			ShowBlackJackCards(playerid);
		}
	}

	if ((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH))
	{
		if (PlayerBlackjackState[playerid] == 2)
		{
			return 1;
		}

		DealerCardExpose[playerid] = true;

		ShowBlackJackCards(playerid);
		printf("DEBUG: score(%d)", GetDealerBlackJackScore(playerid));

		new str[6];
		format(str, sizeof(str), "%d", GetDealerBlackJackScore(playerid));
		PlayerTextDrawSetString(playerid, BlackWageDealers[playerid], str);
		defer OnBlackJackCardExpose(playerid);
	}
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

timer OnBlackJackCardExpose[1500](playerid)
{
	CheckPlayerBlackJackWinner(playerid);
	ResetBlackJack(playerid);
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
/*
CMD:blackjack(playerid, params[])
{
	if( !PlayerCoolDown[playerid][pCasinoCool] ) return SendClientMessage(playerid, COLOR_RED, "[ANTI-ABUSE]: Pricekajte do iduceg paydaya za novo igranje!");
	if( PlayerInfo[playerid][pLevel] < 4 ) return SendClientMessage(playerid, COLOR_RED, "[ANTI-ABUSE]: Morate biti level 4+ za igranje u kasinu!");
	if( BizzInfo[ 104 ][ bTill ] <= 1000 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kasino nema dovoljno novaca za nastavak!");
	new
		tableid = IsPlayerNearBlackJackTable(playerid);
	
	if( tableid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu stola za Black Jack!");
	ResetBlackJack(playerid);
	
	BlackJackTable[ playerid ] = tableid;
	TogglePlayerControllable(playerid, false);
	CreateBlackJackWagerTDs(playerid);
	
	// Pomoc
	DestroyRuletPickupTDs(playerid);
	
	// Wager	
	BlackJackWager[ playerid ] = BlackJack[ tableid ][ bjMin ];
	new
		tmpString[ 9 ];
	format( tmpString, 9, "$%d", BlackJackWager[ playerid ] );
	PlayerTextDrawSetString( playerid, BlackWageWholen[playerid], tmpString );	
	
	PlayerTextDrawSetString( playerid, BlackWageDealert[playerid], "Min Ulog");

	format( tmpString, sizeof( tmpString ), "$%d", BlackJack[ tableid ][ bjMin ] );
	PlayerTextDrawSetString( playerid, BlackWageDealers[playerid], tmpString );

	PlayerTextDrawSetString( playerid, BlackWagePlayert[playerid], "Max Ulog");

	format( tmpString, sizeof( tmpString ), "$%d", BlackJack[ tableid ][ bjMax ] );
	PlayerTextDrawSetString( playerid, BlackWagePlayers[playerid], tmpString );
	
	CreateBlackJackWagerHelpTDs(playerid);
	
	PlayerBlackjackState[playerid] = 1;
	return 1;
}*/