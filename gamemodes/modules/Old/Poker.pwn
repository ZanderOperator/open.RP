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
#define MAX_TABLES          				5

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
enum E_POKER_DATA {
	pokSQLID,
	Float:pokX,
	Float:pokY,
	Float:pokZ,
	Viwo,
	Dealer,
	Players,
	Pot,
	Round,
	Chips[3]
}
static stock 
	PokerInfo[MAX_TABLES][E_POKER_DATA];
	
enum E_POKER_CHIPS_DATA {
	Float:chipX,
	Float:chipY,
	Float:chipZ,
	chipModelid
}
static stock
	PokerChips[][E_POKER_CHIPS_DATA] = {
		{-0.0786, -0.0659, -0.1000, 1904}, // 100   
		{-0.0786, -0.0659, -0.0150, 1904}, // 200   
		{-0.0786, -0.0659, -0.0150, 1901}, // 500   
		{-0.0786, -0.0659, -0.0150, 1902}, // 1000   
		{-0.0124, -0.1108, -0.0150, 1901}, // 10000 
		{-0.0786, -0.0659, -0.0150, 1902}, // 10000  
		{-0.0857, -0.1500, -0.1000, 1903}, // 100000 
		{-0.0124, -0.1108, -0.0150, 1901}, // 100000 
		{-0.0786, -0.0659, -0.0150, 1902}, // 100000 
		{-0.0857, -0.1500, -0.0800, 1903}, // 1000000
		{-0.0124, -0.1108, -0.0150, 1901}, // 1000000
		{-0.0786, -0.0659, -0.0150, 1902}, // 1000000
		{-0.0857, -0.1500, -0.0400, 1903}, // 10000000
		{-0.0124, -0.1108, -0.0150, 1901}, // 10000000
		{-0.0786, -0.0659, -0.0150, 1902}  // 10000000
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

// rBits
static stock
	Bit1: r_DCardsHiden<MAX_PLAYERS>		= {Bit1:false},
	Bit1: r_DCardText1<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_DCardText2<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_PCardText1<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_PCardText2<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_PCardText3<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_PCardText4<MAX_PLAYERS> 		= {Bit1:false},
	Bit1: r_PCardText5<MAX_PLAYERS> 		= {Bit1:false},
	Bit16: r_PlayingPoker<MAX_PLAYERS> 		= {Bit16:9999, ...},
	Bit16: r_PlayerPokerDealer<MAX_PLAYERS> = {Bit16:9999, ...};

// 32 bit
static stock
	Iterator:PokerTables<MAX_TABLES>,
	PokerPlayerCards[MAX_PLAYERS][3],
	PokerDealerCards[MAX_PLAYERS][5];
	
// TextDraws
static stock
	PlayerText:PokerCard1[MAX_PLAYERS] 		= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:PokerCard2[MAX_PLAYERS] 		= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:PokerCard3[MAX_PLAYERS] 		= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:PokerCard4[MAX_PLAYERS] 		= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:PokerCard5[MAX_PLAYERS] 		= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:DealerCard1[MAX_PLAYERS] 	= {PlayerText:INVALID_TEXT_DRAW,...},
	PlayerText:DealerCard2[MAX_PLAYERS] 	= {PlayerText:INVALID_TEXT_DRAW,...};

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock LoadPokerTables() {
	mysql_tquery(g_SQL, "SELECT * FROM pokertables WHERE 1", "OnPokerTablesLoad");
}

stock static GetCardNameByID(cardid) {
	new
		tmpString[ 14 ];
	switch(cardid) {
		case 0: format(tmpString, sizeof(tmpString), "LD_CARD:cd2s");
		case 1: format(tmpString, sizeof(tmpString), "LD_CARD:cd3s");
		case 2: format(tmpString, sizeof(tmpString), "LD_CARD:cd4s");
		case 3: format(tmpString, sizeof(tmpString), "LD_CARD:cd5s");
		case 4: format(tmpString, sizeof(tmpString), "LD_CARD:cd6s");
		case 5: format(tmpString, sizeof(tmpString), "LD_CARD:cd7s");
		case 6: format(tmpString, sizeof(tmpString), "LD_CARD:cd8s");
		case 7: format(tmpString, sizeof(tmpString), "LD_CARD:cd9s");
		case 8: format(tmpString, sizeof(tmpString), "LD_CARD:cd10s");
		case 9: format(tmpString, sizeof(tmpString), "LD_CARD:cd11s");
		case 10: format(tmpString, sizeof(tmpString), "LD_CARD:cd12s");
		case 11: format(tmpString, sizeof(tmpString), "LD_CARD:cd13s");
		case 12: format(tmpString, sizeof(tmpString), "LD_CARD:cd1s");
		case 13: format(tmpString, sizeof(tmpString), "LD_CARD:cd2d");
		case 14: format(tmpString, sizeof(tmpString), "LD_CARD:cd3d");
		case 15: format(tmpString, sizeof(tmpString), "LD_CARD:cd4d");
		case 16: format(tmpString, sizeof(tmpString), "LD_CARD:cd5d");
		case 17: format(tmpString, sizeof(tmpString), "LD_CARD:cd6d");
		case 18: format(tmpString, sizeof(tmpString), "LD_CARD:cd7d");
		case 19: format(tmpString, sizeof(tmpString), "LD_CARD:cd8d");
		case 20: format(tmpString, sizeof(tmpString), "LD_CARD:cd9d");
		case 21: format(tmpString, sizeof(tmpString), "LD_CARD:cd10d");
		case 22: format(tmpString, sizeof(tmpString), "LD_CARD:cd11d");
		case 23: format(tmpString, sizeof(tmpString), "LD_CARD:cd12d");
		case 24: format(tmpString, sizeof(tmpString), "LD_CARD:cd13d");
		case 25: format(tmpString, sizeof(tmpString), "LD_CARD:cd1d");
		case 26: format(tmpString, sizeof(tmpString), "LD_CARD:cd2c");
		case 27: format(tmpString, sizeof(tmpString), "LD_CARD:cd3c");
		case 28: format(tmpString, sizeof(tmpString), "LD_CARD:cd4c");
		case 29: format(tmpString, sizeof(tmpString), "LD_CARD:cd5c");
		case 30: format(tmpString, sizeof(tmpString), "LD_CARD:cd6c");
		case 31: format(tmpString, sizeof(tmpString), "LD_CARD:cd7c");
		case 32: format(tmpString, sizeof(tmpString), "LD_CARD:cd8c");
		case 33: format(tmpString, sizeof(tmpString), "LD_CARD:cd9c");
		case 34: format(tmpString, sizeof(tmpString), "LD_CARD:cd10c");
		case 35: format(tmpString, sizeof(tmpString), "LD_CARD:cd11c");
		case 36: format(tmpString, sizeof(tmpString), "LD_CARD:cd12c");
		case 37: format(tmpString, sizeof(tmpString), "LD_CARD:cd13c");
		case 38: format(tmpString, sizeof(tmpString), "LD_CARD:cd1c");
		case 39: format(tmpString, sizeof(tmpString), "LD_CARD:cd2h");
		case 40: format(tmpString, sizeof(tmpString), "LD_CARD:cd3h");
		case 41: format(tmpString, sizeof(tmpString), "LD_CARD:cd4h");
		case 42: format(tmpString, sizeof(tmpString), "LD_CARD:cd5h");
		case 43: format(tmpString, sizeof(tmpString), "LD_CARD:cd6h");
		case 44: format(tmpString, sizeof(tmpString), "LD_CARD:cd7h");
		case 45: format(tmpString, sizeof(tmpString), "LD_CARD:cd8h");
		case 46: format(tmpString, sizeof(tmpString), "LD_CARD:cd9h");
		case 47: format(tmpString, sizeof(tmpString), "LD_CARD:cd10h");
		case 48: format(tmpString, sizeof(tmpString), "LD_CARD:cd11h");
		case 49: format(tmpString, sizeof(tmpString), "LD_CARD:cd12h");
		case 50: format(tmpString, sizeof(tmpString), "LD_CARD:cd13h");
		case 51: format(tmpString, sizeof(tmpString), "LD_CARD:cd1h");
		default: format(tmpString, sizeof(tmpString), "LD_CARD:cd1h");
	}
	return tmpString;
}

stock static GetCardNameForMes(cardid) {
	new
		tmpString[ 32 ];
	switch(cardid) {
		case 0: format(tmpString, sizeof(tmpString), "2 {808080}PIK");
		case 1: format(tmpString, sizeof(tmpString), "3 {808080}PIK");
		case 2: format(tmpString, sizeof(tmpString), "4 {808080}PIK");
		case 3: format(tmpString, sizeof(tmpString), "5 {808080}PIK");
		case 4: format(tmpString, sizeof(tmpString), "6 {808080}PIK");
		case 5: format(tmpString, sizeof(tmpString), "7 {808080}PIK");
		case 6: format(tmpString, sizeof(tmpString), "8 {808080}PIK");
		case 7: format(tmpString, sizeof(tmpString), "9 {808080}PIK");
		case 8: format(tmpString, sizeof(tmpString), "10 {808080}PIK");
		case 9: format(tmpString, sizeof(tmpString), "J {808080}PIK");
		case 10: format(tmpString, sizeof(tmpString), "Q {808080}PIK");
		case 11: format(tmpString, sizeof(tmpString), "K {808080}PIK");
		case 12: format(tmpString, sizeof(tmpString), "A {808080}PIK");
		case 13: format(tmpString, sizeof(tmpString), "2 {B22222}KARA");
		case 14: format(tmpString, sizeof(tmpString), "3 {B22222}KARA");
		case 15: format(tmpString, sizeof(tmpString), "4 {B22222}KARA");
		case 16: format(tmpString, sizeof(tmpString), "5 {B22222}KARA");
		case 17: format(tmpString, sizeof(tmpString), "6 {B22222}KARA");
		case 18: format(tmpString, sizeof(tmpString), "7 {B22222}KARA");
		case 19: format(tmpString, sizeof(tmpString), "8 {B22222}KARA");
		case 20: format(tmpString, sizeof(tmpString), "9 {B22222}KARA");
		case 21: format(tmpString, sizeof(tmpString), "10 {B22222}KARA");
		case 22: format(tmpString, sizeof(tmpString), "J {B22222}KARA");
		case 23: format(tmpString, sizeof(tmpString), "Q {B22222}KARA");
		case 24: format(tmpString, sizeof(tmpString), "K {B22222}KARA");
		case 25: format(tmpString, sizeof(tmpString), "A {B22222}KARA");
		case 26: format(tmpString, sizeof(tmpString), "2 {808080}TREF");
		case 27: format(tmpString, sizeof(tmpString), "3 {808080}TREF");
		case 28: format(tmpString, sizeof(tmpString), "4 {808080}TREF");
		case 29: format(tmpString, sizeof(tmpString), "5 {808080}TREF");
		case 30: format(tmpString, sizeof(tmpString), "6 {808080}TREF");
		case 31: format(tmpString, sizeof(tmpString), "7 {808080}TREF");
		case 32: format(tmpString, sizeof(tmpString), "8 {808080}TREF");
		case 33: format(tmpString, sizeof(tmpString), "9 {808080}TREF");
		case 34: format(tmpString, sizeof(tmpString), "10 {808080}TREF");
		case 35: format(tmpString, sizeof(tmpString), "J {808080}TREF");
		case 36: format(tmpString, sizeof(tmpString), "Q {808080}TREF");
		case 37: format(tmpString, sizeof(tmpString), "K {808080}TREF");
		case 38: format(tmpString, sizeof(tmpString), "A {808080}TREF");
		case 39: format(tmpString, sizeof(tmpString), "2 {B22222}SRCE");
		case 40: format(tmpString, sizeof(tmpString), "3 {B22222}SRCE");
		case 41: format(tmpString, sizeof(tmpString), "4 {B22222}SRCE");
		case 42: format(tmpString, sizeof(tmpString), "5 {B22222}SRCE");
		case 43: format(tmpString, sizeof(tmpString), "6 {B22222}SRCE");
		case 44: format(tmpString, sizeof(tmpString), "7 {B22222}SRCE");
		case 45: format(tmpString, sizeof(tmpString), "8 {B22222}SRCE");
		case 46: format(tmpString, sizeof(tmpString), "9 {B22222}SRCE");
		case 47: format(tmpString, sizeof(tmpString), "10 {B22222}SRCE");
		case 48: format(tmpString, sizeof(tmpString), "J {B22222}SRCE");
		case 49: format(tmpString, sizeof(tmpString), "Q {B22222}SRCE");
		case 50: format(tmpString, sizeof(tmpString), "K {B22222}SRCE");
		case 51: format(tmpString, sizeof(tmpString), "A {B22222}SRCE");
		default: format(tmpString, sizeof(tmpString), "A {B22222}SRCE");
	}
	return tmpString;
}

stock static DestroyAllCards(playerid)
{
	if(Bit1_Get(r_PCardText1, playerid) == 1) {
        Bit1_Set(r_PCardText1, playerid, false);
        PlayerTextDrawDestroy(playerid, PokerCard1[playerid]);
	}
	if(Bit1_Get(r_PCardText2, playerid) == 1) {
        Bit1_Set(r_PCardText2, playerid, false);
        PlayerTextDrawDestroy(playerid, PokerCard2[playerid]);
	}
	if(Bit1_Get(r_PCardText3, playerid) == 1) {
        Bit1_Set(r_PCardText3, playerid, false);
        PlayerTextDrawDestroy(playerid, PokerCard3[playerid]);
	}
	if(Bit1_Get(r_PCardText4, playerid) == 1) {
        Bit1_Set(r_PCardText4, playerid, false);
        PlayerTextDrawDestroy(playerid, PokerCard4[playerid]);
	}
	if(Bit1_Get(r_PCardText5, playerid) == 1) {
        Bit1_Set(r_PCardText5, playerid, false);
        PlayerTextDrawDestroy(playerid, PokerCard5[playerid]);
	}
	if(Bit1_Get(r_DCardText1, playerid) == 1) {
        Bit1_Set(r_DCardText1, playerid, false);
        PlayerTextDrawDestroy(playerid, DealerCard1[playerid]);
	}
	if(Bit1_Get(r_DCardText2, playerid) == 1) {
        Bit1_Set(r_DCardText2, playerid, false);
        PlayerTextDrawDestroy(playerid, DealerCard2[playerid]);
	}
}

stock static CardRandom(playerid, numberofcards)
{
	new cardid;
    loop_start:
    cardid = random(numberofcards);
    foreach (new i : Player) 
	{
		if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayerPokerDealer, playerid)) 
		{
			if(cardid != PokerPlayerCards[i][0] && cardid != PokerPlayerCards[i][1] && cardid != PokerDealerCards[playerid][0] 
			&& cardid != PokerDealerCards[playerid][1] && cardid != PokerDealerCards[playerid][2] && cardid != PokerDealerCards[playerid][3] 
			&& cardid != PokerDealerCards[playerid][4])
				continue;
			else
				goto loop_start;
		}
	}
	return cardid;
}

stock static CreatePokerTableChips(table, pot)
{
	if( !pot ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
	}
	else if( 1 <= pot <= 100 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[0][chipModelid], PokerChips[0][chipX], PokerChips[0][chipY], PokerChips[0][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 101 <= pot <= 200 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[1][chipModelid], PokerChips[1][chipX], PokerChips[1][chipY], PokerChips[1][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 201 <= pot <= 500 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[2][chipModelid], PokerChips[2][chipX], PokerChips[2][chipY], PokerChips[2][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 501 <= pot <= 1000 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[3][chipModelid], PokerChips[3][chipX], PokerChips[3][chipY], PokerChips[3][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 1001 <= pot <= 10000 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[4][chipModelid], PokerChips[4][chipX], PokerChips[4][chipY], PokerChips[4][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][1] = CreateDynamicObject(PokerChips[5][chipModelid], PokerChips[5][chipX], PokerChips[5][chipY], PokerChips[5][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 10001 <= pot <= 100000 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[6][chipModelid], PokerChips[6][chipX], PokerChips[6][chipY], PokerChips[6][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][1] = CreateDynamicObject(PokerChips[7][chipModelid], PokerChips[7][chipX], PokerChips[7][chipY], PokerChips[7][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][2] = CreateDynamicObject(PokerChips[8][chipModelid], PokerChips[8][chipX], PokerChips[8][chipY], PokerChips[8][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 100001 <= pot <= 1000000 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[9][chipModelid], PokerChips[9][chipX], PokerChips[9][chipY], PokerChips[9][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][1] = CreateDynamicObject(PokerChips[10][chipModelid], PokerChips[10][chipX], PokerChips[10][chipY], PokerChips[10][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][2] = CreateDynamicObject(PokerChips[11][chipModelid], PokerChips[11][chipX], PokerChips[11][chipY], PokerChips[11][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
	else if( 1000001 <= pot <= 10000000 ) {
		if( PokerInfo[table][Chips][0] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][0]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][0]);
			PokerInfo[table][Chips][0] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][1] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][1]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][1]);
			PokerInfo[table][Chips][1] = INVALID_OBJECT_ID;
		}
		if( PokerInfo[table][Chips][2] != INVALID_OBJECT_ID || IsValidDynamicObject(PokerInfo[table][Chips][2]) ) {
			DestroyDynamicObject(PokerInfo[table][Chips][2]);
			PokerInfo[table][Chips][2] = INVALID_OBJECT_ID;
		}
		PokerInfo[table][Chips][0] = CreateDynamicObject(PokerChips[12][chipModelid], PokerChips[12][chipX], PokerChips[12][chipY], PokerChips[12][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][1] = CreateDynamicObject(PokerChips[13][chipModelid], PokerChips[13][chipX], PokerChips[13][chipY], PokerChips[13][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
		PokerInfo[table][Chips][2] = CreateDynamicObject(PokerChips[14][chipModelid], PokerChips[14][chipX], PokerChips[14][chipY], PokerChips[14][chipZ], 0.0, 0.0, 0.0, -1, -1, -1, 80.0, 80.0);
	}
}
// --- TRANSAKCIJE BY WOO --------------
static stock PotToPlayerMoney ( giveplayerid, tableid, money )
{
	new safemoney = floatround(floatabs(money)), 			// Puni iznos
		bizudio = floatround( safemoney * 0.1 ),
		playerudio = floatround( safemoney * 0.9 ),
		tillUpdate[60];
	
	PokerInfo[tableid][Pot] -= safemoney;					// Iz pota se oudzima puni iznos
	AC_GivePlayerMoney(giveplayerid, playerudio); 			// Igrac dobiva 90% pota
	
	// Update Casino blagajne
	foreach(new bizzid: Bizzes) 
	{
		if(BizzInfo[bizzid][bType] == BIZZ_TYPE_CASINO && IsPlayerInRangeOfPoint(giveplayerid, 200.0, BizzInfo[bizzid][bExitX], BizzInfo[bizzid][bExitY], BizzInfo[bizzid][bExitZ]) 
		&& GetPlayerInterior(giveplayerid) == BizzInfo[bizzid][bInterior] && GetPlayerVirtualWorld(giveplayerid) == BizzInfo[bizzid][bVirtualWorld])
		{
			BizzInfo[bizzid][bTill] += bizudio;				// Biznis dobiva 10% pota
			
			format(tillUpdate, 60, "UPDATE bizzes SET till = '%d' WHERE id = '%d'",
				BizzInfo[bizzid][bTill],
				BizzInfo[bizzid][bSQLID]
			);
			mysql_tquery(g_SQL, tillUpdate, "");
			break;
		}
	}
	return 1;
}
static stock PlayerToPotMoney ( playerid, tableid, money )
{
	new safemoney = floatround(floatabs(money)); 			// Puni iznos
	AC_GivePlayerMoney(playerid, -safemoney); 			// Igrac daje novac u POT
	PokerInfo[tableid][Pot] += safemoney;					// Pot dobiva iznos ulozen od igraca
	return 1;
}
//----------------------------------
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
	DestroyAllCards(playerid);
	
	Bit16_Set(r_PlayerPokerDealer, playerid, 9999);
	Bit16_Set(r_PlayingPoker, playerid, 9999);
	
	PokerPlayerCards[playerid][0] = 500;
	PokerPlayerCards[playerid][1] = 500;
	
	foreach(new i : PokerTables) {
        if(playerid == PokerInfo[i][Dealer]) {
            PokerInfo[i][Dealer] = 9999;
            break;
		}
		if(Bit16_Get(r_PlayingPoker, playerid) == i) {
   			PokerInfo[i][Players] --;
   			break;
   		}
    }
	return 1;
}

forward OnPokerTablesLoad();
public OnPokerTablesLoad() {
	if( !cache_num_rows() ) return printf( "MySQL Report: No poker tables exist to load.");
	#if defined MOD_DEBUG
		printf("[DEBUG POKER LOAD]: rows(%d)", cache_num_rows());
	#endif
 	for( new row = 0; row < cache_num_rows(); row++ ) {
		cache_get_value_name_int( row, 		"sqlid"	, PokerInfo[ row ][ pokSQLID ]);
		cache_get_value_name_float( row, 	"pos_x"		, PokerInfo[ row ][ pokX ]);
		cache_get_value_name_float( row, 	"pos_y"		, PokerInfo[ row ][ pokY ]);
		cache_get_value_name_float( row, 	"pos_z"		, PokerInfo[ row ][ pokZ ]);
		cache_get_value_name_int( row, 		"viwo"		, PokerInfo[ row ][ Viwo ]);
		PokerInfo[ row ][ Dealer ] 		= 9999;
		PokerInfo[ row ][ Players ]		= 0;
		PokerInfo[ row ][ Pot ]			= 0;
		PokerInfo[ row ][ Round ]		= 1;
		CreatePokerTableChips(row, 0);
		
		Iter_Add(PokerTables, row);
	}
	printf("MySQL Report: Poker Tables Loaded (%d)!", Iter_Count(PokerTables));
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

CMD:poker(playerid, params[])
{
	new item[10], giveplayerid, card1, card2, card3, card4, card5, money;
    if (sscanf(params, "s[10] ", item)) {
		SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker [opcija]");
     	SendClientMessage(playerid, COLOR_WHITE, "[Akcije] dealer, invite, cancel, kick, deal, cards, fold, givepot");
     	SendClientMessage(playerid, COLOR_WHITE, "[Akcije] flop, turn, river, showcards, newgame, pay, checkpot");
        SendClientMessage(playerid, COLOR_SKYBLUE, "___________________________________________________________________");
		return 1;
	}
	if(GetPlayerCasinoID(playerid) == INVALID_BIZNIS_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se u kasinu!");
	
	if( !strcmp(item,"cancel",true) ) {
	    if(Bit16_Get(r_PlayingPoker, playerid) != 9999) {
		    PokerPlayerCards[playerid][0] = 500;
			PokerPlayerCards[playerid][1] = 500;
			
			PokerDealerCards[playerid][0] = 500;
			PokerDealerCards[playerid][1] = 500;
			PokerDealerCards[playerid][2] = 500;
			PokerDealerCards[playerid][3] = 500;
			PokerDealerCards[playerid][4] = 500;
			
			Bit16_Set(r_PlayingPoker, playerid, 9999);
			DestroyAllCards(playerid);
			
			new
				tmpString[58];
			format(tmpString, sizeof(tmpString), "** %s odlucuje da vise nece igrati.", GetName(playerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			
			foreach(new i : PokerTables)
		        PokerInfo[i][Players] --;
		}
		else if(Bit16_Get(r_PlayerPokerDealer, playerid) != 9999) {
            PokerPlayerCards[playerid][0] = 500;
			PokerPlayerCards[playerid][1] = 500;
			
			PokerDealerCards[playerid][0] = 500;
			PokerDealerCards[playerid][1] = 500;
			PokerDealerCards[playerid][2] = 500;
			PokerDealerCards[playerid][3] = 500;
			PokerDealerCards[playerid][4] = 500;
			
			Bit16_Set(r_PlayerPokerDealer, playerid, 9999);
            DestroyAllCards(playerid);
			
			new
				tmpString[62];
            format(tmpString, sizeof(tmpString), "** %s odlucuje da vise nece biti diler.", GetName(playerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            
			foreach(new i : PokerTables) {
		        if(playerid == PokerInfo[i][Dealer]) {
		            PokerInfo[i][Dealer] = 9999;
		            break;
				}
		    }
		}
		else SendClientMessage(playerid,COLOR_RED, "Ne igrate poker trenutno!");
	}
	else if( !strcmp(item,"dealer",true) ) {
        new table = -1;
		foreach(new i : PokerTables) {
	        if(IsPlayerInRangeOfPoint(playerid, 6.0, PokerInfo[i][pokX], PokerInfo[i][pokY], PokerInfo[i][pokZ])) {
                if(PokerInfo[i][Dealer] == 9999) {
		            table = i;
					break;
				}
			}
	    }
		if(table == -1) return SendClientMessage(playerid,COLOR_RED, "Niste blizu poker stola!");
		if(Bit16_Get(r_PlayerPokerDealer, playerid) != 9999) return SendClientMessage(playerid,COLOR_RED, "Vec ste diler!");
		if(Bit16_Get(r_PlayingPoker, playerid) != 9999) return SendClientMessage(playerid,COLOR_RED, "Vec igrate poker!"); 

		PokerInfo[table][Dealer] = playerid;
		Bit16_Set(r_PlayerPokerDealer, playerid, table);
		new
			tmpString[ 53 ];
		format(tmpString, sizeof(tmpString), "** %s sjeda na stolicu dilera.", GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if( !strcmp(item,"invite",true) ) {
		if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if( !IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		if(PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Players] >= 5) return SendClientMessage(playerid,COLOR_RED, "Na vasem stolu vec igra 5 igraca!");
		if(sscanf(params, "s[10]u", item, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker invite [ID/Dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraceva imena ili IDa!");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes biti diler i igrac u isto vrijeme!");
		if(Bit4_Get(gr_SpecateId, playerid) != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas.");
		if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas!");
		if(Bit16_Get(r_PlayerPokerDealer, giveplayerid) == 9999 && Bit16_Get(r_PlayingPoker, giveplayerid) == 9999) {
			Bit16_Set(r_PlayingPoker, giveplayerid, Bit16_Get(r_PlayerPokerDealer, playerid));
			PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Players] ++;
			new
				tmpString[ 76 ];
			format(tmpString, sizeof(tmpString), "** %s daje zetone za igru %s.", GetName(playerid,true), GetName(giveplayerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	else if( !strcmp(item,"kick",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		if(sscanf(params, "s[10]u", item, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker kick [ID/Dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraceva imena ili IDa!");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozes sam sebe izbaciti sa stola!Diler si!");
		if(Bit4_Get(gr_SpecateId, playerid) != 0) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije dovoljno blizu vas.");
		if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije dovoljno blizu vas!");
		if(Bit16_Get(r_PlayerPokerDealer, giveplayerid) == 9999 && Bit16_Get(r_PlayingPoker, giveplayerid) == Bit16_Get(r_PlayerPokerDealer, playerid)) {
			PokerPlayerCards[giveplayerid][0] = 500;
			PokerPlayerCards[giveplayerid][1] = 500;
			
			PokerDealerCards[giveplayerid][0] = 500;
			PokerDealerCards[giveplayerid][1] = 500;
			PokerDealerCards[giveplayerid][2] = 500;
			PokerDealerCards[giveplayerid][3] = 500;
			PokerDealerCards[giveplayerid][4] = 500;
			
			DestroyAllCards(giveplayerid);
			Bit16_Set(r_PlayingPoker, giveplayerid, 9999);
			PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Players] --;
			
			new
				tmpString[ 74 ];
			format(tmpString, sizeof(tmpString), "** %s oduzima zetone za igru %s.", GetName(playerid,true), GetName(giveplayerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else SendClientMessage(playerid,COLOR_RED, "Taj igrac je poker diler na drugom stolu/Ne igra na vasem stolu!");
	}
	else if( !strcmp(item,"deal",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		if(sscanf(params, "s[10]u", item, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker deal [ID/Dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraceva imena ili IDa!");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi podijeliti karte! Diler si!");
		if(Bit4_Get(gr_SpecateId, playerid) != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas.");
		if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas!");
		if(Bit16_Get(r_PlayingPoker, giveplayerid) == Bit16_Get(r_PlayerPokerDealer, playerid)) {
			if(PokerPlayerCards[giveplayerid][0] != 500 && PokerPlayerCards[giveplayerid][1] != 500) return SendClientMessage(playerid, COLOR_RED, "Taj igrac vec ima 2 karte u rukama!");
			new
				tmpString[ 128 ];
				
			card1 = CardRandom(playerid, 52);
			card2 = CardRandom(playerid, 52);

			PokerPlayerCards[giveplayerid][0] = card1;
			PokerPlayerCards[giveplayerid][1] = card2;
			
			format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card1));
			DealerCard1[giveplayerid] = CreateBlackJackCard(giveplayerid, 180.0, 250.0, tmpString);
			Bit1_Set(r_DCardText1, giveplayerid, true);
			Bit1_Set(r_DCardText2, giveplayerid, true);
			
			format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card2));
			DealerCard2[giveplayerid] = CreateBlackJackCard(giveplayerid, 300.0, 250.0, tmpString);
			Bit1_Set(r_DCardsHiden, giveplayerid, false);
			
			format(tmpString, sizeof(tmpString), "** %s daje dvije karte %s.", GetName(playerid,true), GetName(giveplayerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		} else SendClientMessage(playerid,COLOR_RED, "Taj igrac ne igra na vasem stolu!");
	}
	else if( !strcmp(item,"cards",true) ) {
	    if(Bit16_Get(r_PlayingPoker, playerid) == 9999 && Bit16_Get(r_PlayerPokerDealer, playerid) != 9999) return SendClientMessage(playerid,COLOR_RED, "Ne igrate poker trenutno/Diler ste, a oni nemogu koristiti ovu komandu!");
		if(PokerPlayerCards[playerid][0] == 500 || PokerPlayerCards[playerid][1] == 500) return SendClientMessage(playerid, COLOR_RED, "Nemate dvije karte u rukama!!");
		if(Bit1_Get(r_DCardText1, playerid) == 1 && Bit1_Get(r_DCardText2, playerid) == 1) {
			if(Bit1_Get(r_DCardsHiden, playerid) == 1) {
				Bit1_Set(r_DCardsHiden, playerid, false);
				PlayerTextDrawShow(playerid, DealerCard1[playerid]);
				PlayerTextDrawShow(playerid, DealerCard2[playerid]);
				new
					tmpString[ 65 ];
				format(tmpString, sizeof(tmpString), "** %s skica jednim okom pod karte i gleda.", GetName(playerid,true));
				ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			} else {
				Bit1_Set(r_DCardsHiden, playerid, true);
				PlayerTextDrawHide(playerid, DealerCard1[playerid]);
				PlayerTextDrawHide(playerid, DealerCard2[playerid]);
			}
		}
	}
	else if( !strcmp(item,"fold",true) ) {
	    if(Bit16_Get(r_PlayingPoker, playerid) != 9999 && Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) {
	        if(PokerPlayerCards[playerid][0] == 500 || PokerPlayerCards[playerid][1] == 500) return SendClientMessage(playerid, COLOR_RED, "Nemate dvije karte u rukama!!");
            DestroyAllCards(playerid);
            PokerPlayerCards[playerid][0] = 500;
			PokerPlayerCards[playerid][1] = 500;
			new
				tmpString[71];
            format(tmpString, sizeof(tmpString), "** %s odustaje i vraca svoje dvije karte dileru.", GetName(playerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		    if(Bit1_Get(r_DCardsHiden, playerid) ) Bit1_Set(r_DCardsHiden, playerid, true);
		}
		else SendClientMessage(playerid,COLOR_RED, "Ne igrate poker trenutno/Diler ste, a oni nemogu koristiti ovu komandu!");
	}
	else if( !strcmp(item,"givepot",true) ) {
		if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		if(sscanf(params, "s[10]ui", item, giveplayerid, money)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker givepot [ID/Dio imena][novac]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos igraceva imena ili IDa!");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebe izbaciti sa stola!Diler si!");
		if(Bit4_Get(gr_SpecateId, playerid) != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas.");
		if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas!");
		if(Bit16_Get(r_PlayingPoker, giveplayerid) == Bit16_Get(r_PlayerPokerDealer, playerid)) {
			if(money < 1 || money > PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Pot]) return SendClientMessage(playerid, COLOR_RED, "Nema toliko novca u potu!");
			
			PotToPlayerMoney ( giveplayerid, Bit16_Get(r_PlayerPokerDealer, playerid), money ); // Igrac dobiva dio, biznis dobiva dio, sve izlazi iz pota.
			new
				tmpString[100];
			format(tmpString, sizeof(tmpString), "** %s daje novac iz pota %s.", GetName(playerid,true), GetName(giveplayerid,true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			CreatePokerTableChips(Bit16_Get(r_PlayerPokerDealer, playerid), 0);
		}
		else SendClientMessage(playerid,COLOR_RED, "Taj igrac ne igra na vasem stolu!");
	}
	else if( !strcmp(item,"checkpot",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		new
			tmpString[ 54 ];
		format(tmpString, sizeof(tmpString), "* Iznos u potu: %d (( %s ))", PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Pot], GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if( !strcmp(item,"flop",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] != 1) return SendClientMessage(playerid,COLOR_RED,"Flop je vec okrenut/Niste podjelili prve dvije karte.(/poker deal)");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		
		card3 = CardRandom(playerid, 52);
		card4 = CardRandom(playerid, 52);
		card5 = CardRandom(playerid, 52);
		
		new
			tmpString[ 128 ];
		format(tmpString, sizeof(tmpString), "** %s stavlja tri karte na stol(flop).", GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card3));
		PokerCard1[playerid] = CreatePlayerTextDraw(playerid, 100.0, 150.0, tmpString);
		PlayerTextDrawFont(playerid, PokerCard1[playerid], 4);
		PlayerTextDrawTextSize(playerid, PokerCard1[playerid],40.0,60.0);
		PlayerTextDrawShow(playerid, PokerCard1[playerid]);
		
		Bit1_Set(r_PCardText1, playerid, true);
		Bit1_Set(r_PCardText2, playerid, true);
		Bit1_Set(r_PCardText3, playerid, true);
		
		PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] = 2;
		format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card4));
		PokerCard2[playerid] = CreatePlayerTextDraw(playerid, 180.0, 150.0, tmpString);
		PlayerTextDrawFont(playerid, PokerCard2[playerid], 4);
		PlayerTextDrawTextSize(playerid, PokerCard2[playerid],40.0,60.0);
		PlayerTextDrawShow(playerid,PokerCard2[playerid]);

		format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card5));
		PokerCard3[playerid] = CreatePlayerTextDraw(playerid, 260.0, 150.0, tmpString);
		PlayerTextDrawFont(playerid, PokerCard3[playerid], 4);
		PlayerTextDrawTextSize(playerid, PokerCard3[playerid],40.0,60.0);
		PlayerTextDrawShow(playerid, PokerCard3[playerid]);
		foreach (new i : Player) {
			if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayerPokerDealer, playerid) && ProxDetectorS(3.0, playerid, i)) {
				if(PokerDealerCards[i][0] == 500 && PokerDealerCards[i][1] == 500 && PokerDealerCards[i][2] == 500) {
					PokerDealerCards[i][0] = card3;
					PokerDealerCards[i][1] = card4;
					PokerDealerCards[i][2] = card5;
					
					format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card3));
					PokerCard1[i] = CreatePlayerTextDraw(i, 100.0, 150.0, tmpString);
					PlayerTextDrawFont(i, PokerCard1[i], 4);
					PlayerTextDrawTextSize(i, PokerCard1[i],40.0,60.0);
					PlayerTextDrawShow(i, PokerCard1[i]);

					Bit1_Set(r_PCardText1, i, true);
					Bit1_Set(r_PCardText2, i, true);
					Bit1_Set(r_PCardText3, i, true);

					format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card4));
					PokerCard2[i] = CreatePlayerTextDraw(i, 180.0, 150.0, tmpString);
					PlayerTextDrawFont(i, PokerCard2[i], 4);
					PlayerTextDrawTextSize(i, PokerCard2[i],40.0,60.0);
					PlayerTextDrawShow(i, PokerCard2[i]);

					format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card5));
					PokerCard3[i] = CreatePlayerTextDraw(i, 260.0, 150.0, tmpString);
					PlayerTextDrawFont(i, PokerCard3[i], 4);
					PlayerTextDrawTextSize(i, PokerCard3[i],40.0,60.0);
					PlayerTextDrawShow(i, PokerCard3[i]);
				}
			}
		}
	}
	else if( !strcmp(item,"turn",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] != 2) return SendClientMessage(playerid,COLOR_RED, "4.karta je vec na stolu/Niste okrenuli flop(/Poker flop)");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod svoga stola!");
		
		card1 = CardRandom(playerid, 52);
		new
			tmpString[ 128 ];
		format(tmpString, sizeof(tmpString), "** %s stavlja jos jednu kartu na stol(turn).", GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card1));
		PokerCard4[playerid] = CreatePlayerTextDraw(playerid, 340.0, 150.0, tmpString);
		PlayerTextDrawFont(playerid, PokerCard4[playerid], 4);
		PlayerTextDrawTextSize(playerid, PokerCard4[playerid],40.0,60.0);
		PlayerTextDrawShow(playerid, PokerCard4[playerid]);

		Bit1_Set(r_PCardText4, playerid, true);

		PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] = 3;
		foreach (new i : Player) {
			if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayerPokerDealer, playerid) && ProxDetectorS(3.0, playerid, i) && PokerDealerCards[i][3] == 500) {
				PokerDealerCards[i][3] = card1;
				Bit1_Set(r_PCardText4, i, true);

				format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card1));
				PokerCard4[i] = CreatePlayerTextDraw(i, 340.0, 150.0, tmpString);
				PlayerTextDrawFont(i, PokerCard4[i], 4);
				PlayerTextDrawTextSize(i, PokerCard4[i],40.0,60.0);
				PlayerTextDrawShow(i, PokerCard4[i]);
			}
		}
	}
	else if( !strcmp(item,"river",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] != 3) return SendClientMessage(playerid,COLOR_RED, "5.karta je vec na stolu/Niste okrenuli flop ili turn(/Poker flop/turn)");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod svoga stola!");
		
		card1 = CardRandom(playerid, 52);
		new
			tmpString[ 68 ];
		format(tmpString, sizeof(tmpString), "** %s stavlja jos jednu kartu na stol(river).", GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card1));
		PokerCard5[playerid] = CreatePlayerTextDraw(playerid, 420.0, 150.0, tmpString);
		PlayerTextDrawFont(playerid, PokerCard5[playerid], 4);
		PlayerTextDrawTextSize(playerid, PokerCard5[playerid],40.0,60.0);
		PlayerTextDrawShow(playerid, PokerCard5[playerid]);
		Bit1_Set(r_PCardText5, playerid, true);
		PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] = 4;
		
		foreach (new i : Player) {
			if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayerPokerDealer, playerid) && ProxDetectorS(3.0, playerid, i) && PokerDealerCards[i][4] == 500) {
				PokerDealerCards[i][4] = card1;
				Bit1_Set(r_PCardText5, i, true);

				format(tmpString, sizeof(tmpString), "%s", GetCardNameByID(card1));
				PokerCard5[i] = CreatePlayerTextDraw(i, 420.0, 150.0, tmpString);
				PlayerTextDrawFont(i, PokerCard5[i], 4);
				PlayerTextDrawTextSize(i, PokerCard5[i],40.0,60.0);
				PlayerTextDrawShow(i, PokerCard5[i]);
			}
		}
	}
	else if( !strcmp(item,"newgame",true) ) {
        if(Bit16_Get(r_PlayerPokerDealer, playerid) == 9999) return SendClientMessage(playerid,COLOR_RED, "Niste poker diler!");
		if(!IsPlayerInRangeOfPoint(playerid, 4, PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Viwo]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod svoga stola!");
		
		new
			tmpString[ 78 ];
		format(tmpString, sizeof(tmpString), "** %s uzima sve karte te ih pocinje mjesati(nova igra).", GetName(playerid,true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		DestroyAllCards(playerid);
		PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Round] 	= 1;
		PokerInfo[Bit16_Get(r_PlayerPokerDealer, playerid)][Pot] 	= 0;
		CreatePokerTableChips(Bit16_Get(r_PlayerPokerDealer, playerid), 0);
		
		foreach (new i : Player) {
			if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayerPokerDealer, playerid)) {
				PokerPlayerCards[i][0] = 500;
				PokerPlayerCards[i][1] = 500;
				PokerDealerCards[i][0] = 500;
				PokerDealerCards[i][1] = 500;
				PokerDealerCards[i][2] = 500;
				PokerDealerCards[i][3] = 500;
				PokerDealerCards[i][4] = 500;
				DestroyAllCards(i);
				Bit1_Set(r_DCardsHiden, i, true);
			}
		}
	}
	else if( !strcmp(item,"pay",true) ) 
	{
	    if(Bit16_Get(r_PlayingPoker, playerid) == 9999 && Bit16_Get(r_PlayerPokerDealer, playerid) != 9999) return SendClientMessage(playerid,COLOR_RED, "Ne igrate poker trenutno/Diler ste, a oni nemogu koristiti ovu komandu!");
		printf("PAY > %s[%d]: r_PlayingPoker = %d", GetName(playerid), playerid, Bit16_Get(r_PlayingPoker, playerid));
		if(!IsPlayerInRangeOfPoint(playerid, 4.0, PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][pokX], PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][pokY], PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][pokZ]) && GetPlayerVirtualWorld(playerid) != PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][Viwo]) return SendClientMessage(playerid,COLOR_RED, "Niste blizu vaseg poker stola!");
		if(sscanf(params, "s[10]i", item, money)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /poker pay [kolicina novca]");
		if(money < 1 || money > AC_GetPlayerMoney(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca!!");
		
		printf("PAY > %s[%d]: r_PlayingPoker = %d {$ %d}", GetName(playerid), playerid, Bit16_Get(r_PlayingPoker, playerid), money);
		CreatePokerTableChips(Bit16_Get(r_PlayingPoker, playerid), PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][Pot]);
		PlayerToPotMoney(playerid, Bit16_Get(r_PlayingPoker, playerid), money); // Igrac stavlja novce u POT
		new
			tmpString[ 55 ];
		format(tmpString, sizeof(tmpString), "** %s stavlja %d u pot.", GetName(playerid,true), money);
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if( !strcmp(item,"showcards",true) ) {
	    if(Bit16_Get(r_PlayingPoker, playerid) == 9999 && Bit16_Get(r_PlayerPokerDealer, playerid) != 9999) return  SendClientMessage(playerid,COLOR_RED, "Ne igrate poker trenutno/Diler ste, a oni nemogu koristiti ovu komandu!");
		if(PokerPlayerCards[playerid][0] == 500 || PokerPlayerCards[playerid][1] == 500) return SendClientMessage(playerid, COLOR_RED, "Nemate dvije karte u rukama!!");
		if(PokerInfo[Bit16_Get(r_PlayingPoker, playerid)][Round] != 4) return SendClientMessage(playerid,COLOR_RED,"Nisu okrenute sve karte na stolu da bi mogli pokazati svoje karte!");
		new
			tmpString[ 128 ];
		format(tmpString, sizeof(tmpString), "** %s pokazuje svoje 2 karte. (( %s  %s ))", GetName(playerid,true),GetCardNameForMes(PokerPlayerCards[playerid][0]),GetCardNameForMes(PokerPlayerCards[playerid][1]));
		foreach (new i : Player) {
			if(Bit16_Get(r_PlayingPoker, i) == Bit16_Get(r_PlayingPoker, playerid) || Bit16_Get(r_PlayerPokerDealer, i) == Bit16_Get(r_PlayingPoker, playerid) && ProxDetectorS(5.0, playerid, i))
				SendClientMessage(i, COLOR_PURPLE, tmpString);
		}
	}
	return 1;
}
