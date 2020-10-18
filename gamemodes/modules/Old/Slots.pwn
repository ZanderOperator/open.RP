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

#define SLOTS_CHANGE_INTERVAL		(55) 	// Brzina mijenjanja slicica
#define SLOTS_FADE_INTERVAL			(4500)	// Vrijeme za koje ce se TDovi maknuti sa ekrana
#define SLOTS_DURATION				(5)		// Vrijeme trajanja mijenjanja slotova

// Money
#define SLOTS_2BARS					(1000)
#define SLOTS_BAR					(500)
#define SLOTS_BELL					(250)
#define SLOTS_CHERRY				(175)
#define SLOTS_GRAPES				(100)
#define SLOTS_69					(50)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
// 32bit
static stock
	SlotsTimestamp[ MAX_PLAYERS ],
	playerSlots[ MAX_PLAYERS ][ 3 ],
	SlotsTimer[ MAX_PLAYERS ],
	PlayerSlotsBet[ MAX_PLAYERS ];

// rBits
static stock
	Bit1:r_PlayerPlaySlots<MAX_PLAYERS> = { Bit1:false, ... };

// TextDraws
static stock 
	PlayerText:SlotsBcg[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SlotsFirst[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SlotsSecond[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SlotsThird[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SlotsTitle[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SlotsPot[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static DestroyPlayerSlotsTD(playerid)
{
	if( SlotsBcg[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsBcg[ playerid ]);
		SlotsBcg[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( SlotsFirst[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsFirst[ playerid ]);
		SlotsFirst[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( SlotsSecond[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsSecond[ playerid ]);
		SlotsSecond[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( SlotsThird[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsThird[ playerid ]);
		SlotsThird[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( SlotsTitle[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsTitle[ playerid ]);
		SlotsTitle[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( SlotsPot[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SlotsPot[ playerid ]);
		SlotsPot[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
}

stock static CreatePlayerSlotsTD(playerid, pot)
{
	DestroyPlayerSlotsTD(playerid);
	SlotsBcg[playerid] = CreatePlayerTextDraw(playerid, 429.879943, 319.082702, "usebox");
	PlayerTextDrawLetterSize(playerid, SlotsBcg[playerid], 0.000000, 6.788763);
	PlayerTextDrawTextSize(playerid, SlotsBcg[playerid], 219.079895, 0.000000);
	PlayerTextDrawAlignment(playerid, SlotsBcg[playerid], 1);
	PlayerTextDrawColor(playerid, SlotsBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, SlotsBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, SlotsBcg[playerid], 255);
	PlayerTextDrawSetShadow(playerid, SlotsBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsBcg[playerid], 0);
	PlayerTextDrawFont(playerid, SlotsBcg[playerid], 0);
	PlayerTextDrawShow(playerid, SlotsBcg[playerid]);

	SlotsFirst[playerid] = CreatePlayerTextDraw(playerid, 229.5, 337.75, "LD_SLOT:r_69");
	PlayerTextDrawLetterSize(playerid, SlotsFirst[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SlotsFirst[playerid], 63.4, 41.7);
	PlayerTextDrawAlignment(playerid, SlotsFirst[playerid], 1);
	PlayerTextDrawColor(playerid, SlotsFirst[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SlotsFirst[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsFirst[playerid], 0);
	PlayerTextDrawFont(playerid, SlotsFirst[playerid], 4);
	PlayerTextDrawShow(playerid, SlotsFirst[playerid]);

	SlotsSecond[playerid] = CreatePlayerTextDraw(playerid, 294.9, 337.75, "LD_SLOT:r_69");
	PlayerTextDrawLetterSize(playerid, SlotsSecond[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SlotsSecond[playerid], 63.4, 41.7);
	PlayerTextDrawAlignment(playerid, SlotsSecond[playerid], 1);
	PlayerTextDrawColor(playerid, SlotsSecond[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SlotsSecond[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsSecond[playerid], 0);
	PlayerTextDrawFont(playerid, SlotsSecond[playerid], 4);
	PlayerTextDrawShow(playerid, SlotsSecond[playerid]);

	SlotsThird[playerid] = CreatePlayerTextDraw(playerid, 357.3, 337.75, "LD_SLOT:r_69");
	PlayerTextDrawLetterSize(playerid, SlotsThird[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SlotsThird[playerid], 63.4, 41.7);
	PlayerTextDrawAlignment(playerid, SlotsThird[playerid], 1);
	PlayerTextDrawColor(playerid, SlotsThird[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SlotsThird[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsThird[playerid], 0);
	PlayerTextDrawFont(playerid, SlotsThird[playerid], 4);
	PlayerTextDrawShow(playerid, SlotsThird[playerid]);

	SlotsTitle[playerid] = CreatePlayerTextDraw(playerid, 228.199966, 308.422912, "Automati");
	PlayerTextDrawLetterSize(playerid, SlotsTitle[playerid], 0.485119, 1.852373);
	PlayerTextDrawAlignment(playerid, SlotsTitle[playerid], 1);
	PlayerTextDrawColor(playerid, SlotsTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SlotsTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SlotsTitle[playerid], 51);
	PlayerTextDrawFont(playerid, SlotsTitle[playerid], 3);
	PlayerTextDrawSetProportional(playerid, SlotsTitle[playerid], 1);
	PlayerTextDrawShow(playerid, SlotsTitle[playerid]);

	SlotsPot[playerid] = va_CreatePlayerTextDraw(playerid, 382.279785, 321.663940, "~y~Ulog: %d~g~$", pot);
	PlayerTextDrawLetterSize(playerid, SlotsPot[playerid], 0.357120, 1.318755);
	PlayerTextDrawAlignment(playerid, SlotsPot[playerid], 2);
	PlayerTextDrawColor(playerid, SlotsPot[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SlotsPot[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SlotsPot[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SlotsPot[playerid], 51);
	PlayerTextDrawFont(playerid, SlotsPot[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SlotsPot[playerid], 1);
	PlayerTextDrawShow(playerid, SlotsPot[playerid]);
}

stock static RandomSlotsById(id)
{
	new
		tmpString[ 15 ];
	switch( id ) {
		case 0: format(tmpString, 15, "LD_SLOT:r_69");
		case 1: format(tmpString, 15, "LD_SLOT:grapes");
		case 2: format(tmpString, 15, "LD_SLOT:cherry");
		case 3: format(tmpString, 15, "LD_SLOT:bell");
		case 4: format(tmpString, 15, "LD_SLOT:bar2_o");
		case 5: format(tmpString, 15, "LD_SLOT:bar1_o");
	}
	return tmpString;
}

stock static IsPlayerInRangeOfSlots(playerid)
{
	return ( IsPlayerInRangeOfPoint(playerid, 5.0, 792.12799, 450.82059, 1070.82971) || IsPlayerInRangeOfPoint(playerid, 5.0, 794.33789, 406.42499, 1070.82971) || 
		IsPlayerInRangeOfPoint(playerid, 5.0, 791.86206, 400.82361, 1070.82971) || IsPlayerInRangeOfPoint(playerid, 5.0, 787.55286, 396.25815, 1070.82971) || 
		IsPlayerInRangeOfPoint(playerid, 5.0, 794.48218, 445.20663, 1070.82971) || IsPlayerInRangeOfPoint(playerid, 5.0, 787.37622, 455.29886, 1070.82971) );
}

stock static GetPlayerSlotsWin(playerid)
{
	new
		money = 0;
	if( playerSlots[playerid][0] == SLOTS_2BARS && playerSlots[playerid][1] == SLOTS_2BARS && playerSlots[playerid][2] == SLOTS_2BARS )
		money = floatround(SLOTS_2BARS * ( PlayerSlotsBet[playerid] / 100 ));
	else if( ( playerSlots[playerid][0] == SLOTS_2BARS && playerSlots[playerid][1] == SLOTS_BAR && playerSlots[playerid][2] == SLOTS_2BARS ) ||
		( playerSlots[playerid][0] == SLOTS_BAR && playerSlots[playerid][1] == SLOTS_2BARS && playerSlots[playerid][2] == SLOTS_2BARS ) ||
		( playerSlots[playerid][0] == SLOTS_2BARS && playerSlots[playerid][1] == SLOTS_2BARS && playerSlots[playerid][2] == SLOTS_BAR ) )
		money = floatround( ( ( SLOTS_2BARS + SLOTS_BAR ) / 2 ) * ( PlayerSlotsBet[playerid] / 100 ));
	else if( playerSlots[playerid][0] == SLOTS_BAR && playerSlots[playerid][1] == SLOTS_BAR && playerSlots[playerid][2] == SLOTS_BAR )
		money = floatround(SLOTS_BAR * ( PlayerSlotsBet[playerid] / 100 ));
	else if( ( playerSlots[playerid][0] == SLOTS_BELL && playerSlots[playerid][1] == SLOTS_BAR && playerSlots[playerid][2] == SLOTS_BELL ) ||
		( playerSlots[playerid][0] == SLOTS_BAR && playerSlots[playerid][1] == SLOTS_BELL && playerSlots[playerid][2] == SLOTS_BELL ) ||
		( playerSlots[playerid][0] == SLOTS_BELL && playerSlots[playerid][1] == SLOTS_BELL && playerSlots[playerid][2] == SLOTS_BAR ) )
		money = floatround( ( ( SLOTS_BAR + SLOTS_BELL ) / 2 ) * ( PlayerSlotsBet[playerid] / 100 ));
	else if( playerSlots[playerid][0] == SLOTS_BELL && playerSlots[playerid][1] == SLOTS_BELL && playerSlots[playerid][2] == SLOTS_BELL )
		money = floatround(SLOTS_BELL * ( PlayerSlotsBet[playerid] / 100 ));
	else if( playerSlots[playerid][0] == SLOTS_CHERRY && playerSlots[playerid][1] == SLOTS_CHERRY && playerSlots[playerid][2] == SLOTS_CHERRY )
		money = floatround(SLOTS_CHERRY * ( PlayerSlotsBet[playerid] / 100 ));
	else if( playerSlots[playerid][0] == SLOTS_GRAPES && playerSlots[playerid][1] == SLOTS_GRAPES && playerSlots[playerid][2] == SLOTS_GRAPES )
		money = floatround(SLOTS_GRAPES * ( PlayerSlotsBet[playerid] / 100 ));
	else if( playerSlots[playerid][0] == SLOTS_69 && playerSlots[playerid][1] == SLOTS_69 && playerSlots[playerid][2] == SLOTS_69 )
		money = floatround(SLOTS_69 * ( PlayerSlotsBet[playerid] / 100 ));
	else money -= PlayerSlotsBet[playerid];
	return money;
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
// Custom
forward OnPlayerPlaysSlots(playerid);
public OnPlayerPlaysSlots(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) 
		return 0;
		
	playerSlots[playerid][0] = random(5);
	playerSlots[playerid][1] = random(5);
	playerSlots[playerid][2] = random(5);
	
	PlayerTextDrawSetString(playerid, SlotsFirst[playerid], RandomSlotsById(playerSlots[playerid][0]));
	PlayerTextDrawSetString(playerid, SlotsSecond[playerid], RandomSlotsById(playerSlots[playerid][1]));
	PlayerTextDrawSetString(playerid, SlotsThird[playerid], RandomSlotsById(playerSlots[playerid][2]));
	
	if( SlotsTimestamp[playerid] < gettimestamp() ) {
		KillTimer(SlotsTimer[playerid]);
		SlotsTimestamp[playerid] = 0;
		SetTimerEx("RemovePlayerSlots", SLOTS_FADE_INTERVAL, false, "i", playerid);
		new	
			moneyWin = GetPlayerSlotsWin(playerid);
		va_SendClientMessage(playerid, ( moneyWin > 0 ? COLOR_GREEN : COLOR_RED ), "[ ! ] %s ste %d$ na aparatima! Za ponovno koristenje koristite ~k~~VEHICLE_ENTER_EXIT~!", ( moneyWin > 0 ? ("Zaradili") : ("Izgubili") ), moneyWin);
		// Woo edit
		if (moneyWin > 0)
			BusinessToPlayerMoney(playerid, 104, moneyWin);
		else
			PlayerToBusinessMoney(playerid, 104, moneyWin);
		 
		Bit1_Set(r_PlayerPlaySlots, playerid, false);
		PlayerSlotsBet[playerid] = 0;
		playerSlots[playerid][0] = 0;
		playerSlots[playerid][1] = 0;
		playerSlots[playerid][2] = 0;
	}
	return 1;
}

forward RemovePlayerSlots(playerid);
public RemovePlayerSlots(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) 
		return;
	DestroyPlayerSlotsTD(playerid);
	Bit1_Set(r_PlayerPlaySlots, playerid, false);
}

// Rest
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_CASINO_SLOTS: {
			if( !response ) return Bit1_Set(r_PlayerPlaySlots, playerid, true), 1;
			if( strval(inputtext) < 1 ) return ShowPlayerDialog(playerid, DIALOG_CASINO_SLOTS, DIALOG_STYLE_INPUT, "Aparati - Unos iznosa", "Unesite koliko novaca zelite uloziti u aparat:", "Input", "Abort");
			if( strval(inputtext) > AC_GetPlayerMoney(playerid) ) return ShowPlayerDialog(playerid, DIALOG_CASINO_SLOTS, DIALOG_STYLE_INPUT, "Aparati - Unos iznosa", "Unesite koliko novaca zelite uloziti u aparat:\n"COL_RED"Nemate toliko novaca!", "Input", "Abort");
			PlayerSlotsBet[playerid] = strval(inputtext);
			new
				tmpString[ 512 ];
			format(tmpString, 512, ""COL_WHITE"Moguce nagrade su:\n\n"COL_MAGENTA"2BARS x 2BARS x 2BARS"COL_WHITE"- %d$\n"COL_MAGENTA"BAR x 2BARS x BAR"COL_WHITE"- %d$ (1+2)\n"COL_MAGENTA"BAR x BAR x BAR"COL_WHITE"- %d$\n"COL_MAGENTA"BELL x BAR x BELL"COL_WHITE"- %d$ (1+2)\n"COL_MAGENTA"BELL x BELL x BELL"COL_WHITE"- %d$\n"COL_MAGENTA"CHERRY x CHERRY x CHERRY"COL_WHITE"- %d$\n"COL_MAGENTA"GRAPES x GRAPES x GRAPES"COL_WHITE"- %d$\n"COL_MAGENTA"69 x 69 x 69"COL_WHITE"- %d$\n\n\n", 
				floatround(floatdiv( strval(inputtext), 100 ) * SLOTS_2BARS),
				floatround( floatdiv( ( SLOTS_2BARS + SLOTS_BAR ), 2 ) * floatdiv( strval(inputtext), 100 )),
				floatround(SLOTS_BAR * floatdiv( strval(inputtext), 100 )),
				floatround( floatdiv( ( SLOTS_BAR + SLOTS_BELL ), 2 ) * floatdiv( strval(inputtext), 100 )),
				floatround(SLOTS_BELL * floatdiv( strval(inputtext), 100 )),
				floatround(SLOTS_CHERRY * floatdiv( strval(inputtext), 100 )),
				floatround(SLOTS_GRAPES * floatdiv( strval(inputtext), 100 )),
				floatround(SLOTS_69 * floatdiv( strval(inputtext), 100 ))
			);
			
			ShowPlayerDialog(playerid, DIALOG_CASINO_SLOTS_ACC, DIALOG_STYLE_MSGBOX, "Aparati - Spremni zaigrati?", tmpString, "Ok", "Nazad");
			return 1;
		}
		case DIALOG_CASINO_SLOTS_ACC: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_CASINO_SLOTS, DIALOG_STYLE_INPUT, "Aparati - Unos iznosa", "Unesite koliko novaca zelite uloziti u aparat:", "Input", "Abort");
			CreatePlayerSlotsTD(playerid, PlayerSlotsBet[playerid]);
			SlotsTimer[playerid] = SetTimerEx("OnPlayerPlaysSlots", SLOTS_CHANGE_INTERVAL, true, "i", playerid);
			SlotsTimestamp[playerid] = gettimestamp() + SLOTS_DURATION;
			return 1;
		}
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( PRESSED(KEY_SECONDARY_ATTACK) ) {
		if( !Bit1_Get(r_PlayerPlaySlots, playerid) ) {
			if( IsPlayerInRangeOfSlots(playerid) ) {
				if( AC_GetPlayerMoney(playerid) < 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati novaca!");
				ShowPlayerDialog(playerid, DIALOG_CASINO_SLOTS, DIALOG_STYLE_INPUT, "Aparati - Unos iznosa", "Unesite koliko novaca zelite uloziti u aparat:", "Input", "Abort");
				Bit1_Set(r_PlayerPlaySlots, playerid, true);
			}
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit1_Get(r_PlayerPlaySlots, playerid ) ) {
		Bit1_Set(r_PlayerPlaySlots, playerid, false);
		PlayerSlotsBet[playerid] = 0;
		playerSlots[playerid][0] = 0;
		playerSlots[playerid][1] = 0;
		playerSlots[playerid][2] = 0;
	}
	return 1;
}