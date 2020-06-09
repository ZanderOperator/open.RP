#include "modules/Server/KeyInput.pwn"

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
enum E_FISHING_DATA
{
	fFishing,
	fFishingBait,
	fWeight[4],
	fFishType[4]
}
new 
	FishingInfo[MAX_PLAYERS][E_FISHING_DATA];

enum E_FISHES_DATA
{
	fiName[ 22 ],
	fiPrice
}
new
	FishInfo[][ E_FISHES_DATA ] = {
		{"Sheep Head"			, 1}, // 0 - 2 Male (El Corona)
		{"White Fish"			, 2},
		{"Rockfish"				, 3}, 
		{"Bocaccio"				, 7}, // 3 - 5 Srednje (Glen)
		{"Red Snapper"			, 6},
		{"Salema"				, 5},
		{"Californijska jegulja", 5}, // 6 - 10 Velike (Santa Maria)
		{"Halfmoon smudj"		, 9},
		{"Raza"					, 12},
		{"Lemon shark"			, 15},
		{"Starry rockfish"		, 10}
	};
	
static stock
	Bit4: gr_PlayerFishingSlot <MAX_PLAYERS>;
/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/
forward OnPlayerFishing(playerid);
public OnPlayerFishing(playerid)
{
	new
		rand = random(20);
	/*
	if( IsPlayerInRangeOfPoint(playerid, 40.0, 1242.2506, -2380.6394, 8.8305) ) 		// El Corona (Male)
		rand = random(random(10));
	else if ( IsPlayerInRangeOfPoint(playerid, 40.0, 1970.0155, -1198.7777, 19.0000) ) 	// Glen Park (srednje)
		rand = random(random(15));
	else if( IsPlayerInRangeOfPoint(playerid, 20.0, 383.3947, -2087.6040, 7.8359) ) 	// Santa Maria (velike)
		rand = random(random(20));
	*/

	switch( rand ) {
		case 5, 1, 9, 7, 15, 18, 3, 12, 4, 17 : {
			new
				fishScore,
				fishTime, 
				slot;
			
			if( FishingInfo[ playerid ][ fFishType ][ 0 ] == -1 ) 
				slot = 0;
			else if( FishingInfo[ playerid ][ fFishType ][ 1 ] == -1 ) 
				slot = 1;
			else if( FishingInfo[ playerid ][ fFishType ][ 2 ] == -1 ) 
				slot = 2;
			else if( FishingInfo[ playerid ][ fFishType ][ 3 ] == -1 ) 
				slot = 3;
			
			if( IsPlayerInRangeOfPoint(playerid, 40.0, 1242.2506, -2380.6394, 8.8305) ) { // El Corona (Male)
				FishingInfo[ playerid ][ fFishType ][ slot ] 	= minrand(0,2);
				FishingInfo[ playerid ][ fWeight ][ slot ] 		= minrand(1,10);
			}
			else if ( IsPlayerInRangeOfPoint(playerid, 40.0, 1970.0155, -1198.7777, 19.0000) ) { // Glen Park (srednje)
				FishingInfo[ playerid ][ fFishType ][ slot ] 	= minrand(3,5);
				FishingInfo[ playerid ][ fWeight ][ slot ] 		= minrand(10,20);
			}
			else if( IsPlayerInRangeOfPoint(playerid, 20.0, 383.3947, -2087.6040, 7.8359) ) { // Santa Maria (velike)
				FishingInfo[ playerid ][ fFishType ][ slot ] 	= minrand(6,10);
				FishingInfo[ playerid ][ fWeight ][ slot ] 		= minrand(20,35);
			}		
				
			Bit4_Set( gr_PlayerFishingSlot, playerid, slot );
			
			switch( FishingInfo[ playerid ][ fFishType ][ slot ] ) {
				case 0 .. 2:  { fishScore = 9; fishTime = 15; }
				case 3 .. 5:  { fishScore = 12; fishTime = 20; }
				case 6 .. 10: { fishScore = 14; fishTime = 30; }
			}
			new string[100];
			format(string, sizeof(string), "* %s ima ribu na udici te krece potezati stap i motati rolu.", GetName(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_shake", 4.0999, 1, 0, 0, 1, 0, 1);
			SetPlayerKeyInput(playerid, fishScore, 900 + random(200), fishTime, 3);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Pratite tipke koje vam se pojavljuju na ekranu da bi upecali ribu.");
		}
		default: {
			SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Pukao vam je flaks jer ste zakacili %s.", (minrand(0,1) == 0) ? ("alge") : ("smece") );
			FishingInfo[ playerid ][ fFishing ]		= 0;
			TogglePlayerControllable(playerid, true);
		}
	}
}

stock ResetPlayerFishingVars(playerid)
{
	FishingInfo[ playerid ][ fFishing ]		= 0;
	FishingInfo[ playerid ][ fFishingBait ]	= 0;
	
	FishingInfo[ playerid ][ fFishType ][ 0 ] 	= -1; 
	FishingInfo[ playerid ][ fFishType ][ 1 ] 	= -1; 
	FishingInfo[ playerid ][ fFishType ][ 2 ] 	= -1; 
	FishingInfo[ playerid ][ fFishType ][ 3 ] 	= -1; 
	
	FishingInfo[ playerid ][ fWeight ][ 0 ] = -1; 
	FishingInfo[ playerid ][ fWeight ][ 1 ] = -1; 
	FishingInfo[ playerid ][ fWeight ][ 2 ] = -1; 
	FishingInfo[ playerid ][ fWeight ][ 3 ] = -1;
	
	Bit4_Set( gr_PlayerFishingSlot, playerid, 0 );
}

stock SavePlayerFishes(playerid)
{
	new mysqlUpdate[256];
	if(PlayerInfo[playerid][pFishSQLID] != -1)
	{
		format(mysqlUpdate, 256, "UPDATE `fishes` SET `fishbait` = '%d', `fish1` = '%d', `fish1kg` = '%d', `fish2` = '%d', `fish2kg` = '%d', `fish3` = '%d', `fish3kg` = '%d', `fish4` = '%d', `fish4kg` = '%d' WHERE `id` = '%d'",
			FishingInfo[ playerid ][ fFishingBait ],
			FishingInfo[ playerid ][ fFishType ][ 0 ],
			FishingInfo[ playerid ][ fWeight ][ 0 ],
			FishingInfo[ playerid ][ fFishType ][ 1 ],
			FishingInfo[ playerid ][ fWeight ][ 1 ],
			FishingInfo[ playerid ][ fFishType ][ 2 ],
			FishingInfo[ playerid ][ fWeight ][ 2 ],
			FishingInfo[ playerid ][ fFishType ][ 3 ],
			FishingInfo[ playerid ][ fWeight ][ 3 ],
			PlayerInfo[playerid][pFishSQLID]
		);
		mysql_tquery(g_SQL, mysqlUpdate, "", "");
	}
	else
	{
		format(mysqlUpdate, 256, "INSERT INTO fishes (id,playerid, fishbait, fish1, fish1kg, fish2, fish2kg, fish3, fish3kg, fish4, fish4kg) VALUES (null, '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')",
			PlayerInfo[playerid][pSQLID],
			FishingInfo[ playerid ][ fFishingBait ],
			FishingInfo[ playerid ][ fFishType ][ 0 ],
			FishingInfo[ playerid ][ fWeight ][ 0 ],
			FishingInfo[ playerid ][ fFishType ][ 1 ],
			FishingInfo[ playerid ][ fWeight ][ 1 ],
			FishingInfo[ playerid ][ fFishType ][ 2 ],
			FishingInfo[ playerid ][ fWeight ][ 2 ],
			FishingInfo[ playerid ][ fFishType ][ 3 ],
			FishingInfo[ playerid ][ fWeight ][ 3 ]
		);
		mysql_tquery(g_SQL, mysqlUpdate, "OnFishInsertQuery", "i", playerid);
	}
	return 1;
}

Function: OnFishInsertQuery(playerid)
{
	PlayerInfo[playerid][pFishSQLID] = cache_insert_id();
	return 1;
}

stock LoadPlayerFishes(playerid)
{
	new
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `fishes` WHERE `playerid` = '%d'",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery, "OnPlayerFishesLoad", "i", playerid);
	return 1;
}

Function: OnPlayerFishesLoad(playerid)
{
	if(!cache_num_rows()) return 0;
	cache_get_value_name_int(0,  "id"			, PlayerInfo[playerid][pFishSQLID]);
	cache_get_value_name_int(0,  "fishbait"		, FishingInfo[ playerid ][ fFishingBait ]);
	cache_get_value_name_int(0,  "fish1"		, FishingInfo[ playerid ][ fFishType ][ 0 ]);
	cache_get_value_name_int(0,  "fish1kg"		, FishingInfo[ playerid ][ fWeight ][ 0 ]);
	cache_get_value_name_int(0,  "fish2"		, FishingInfo[ playerid ][ fFishType ][ 1 ]);
	cache_get_value_name_int(0,  "fish2kg"		, FishingInfo[ playerid ][ fWeight ][ 1 ]);
	cache_get_value_name_int(0,  "fish3"		, FishingInfo[ playerid ][ fFishType ][ 2 ]);
	cache_get_value_name_int(0,  "fish3kg"		, FishingInfo[ playerid ][ fWeight ][ 2 ]);
	cache_get_value_name_int(0,  "fish4"		, FishingInfo[ playerid ][ fFishType ][ 3 ]);
	cache_get_value_name_int(0,  "fish4kg"		, FishingInfo[ playerid ][ fWeight ][ 3 ]);
	
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
hook OnPlayerKeyInputEnds(playerid, type, succeeded)
{
	if( type == 3 ) {
		if( succeeded ) {
			TogglePlayerControllable(playerid, 1);
			FishingInfo[ playerid ][ fFishing ]	= 0;
			new
				slot = Bit4_Get( gr_PlayerFishingSlot, playerid );
				
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Upecali ste %s od %i kilograma.", FishInfo[ FishingInfo[ playerid ][ fFishType ][ slot ] ][ fiName ], FishingInfo[ playerid ][ fWeight ][ slot ]);
			new string[80];
			format(string, sizeof(string), "* %s vadi %s od %i kilograma.", GetName(playerid), FishInfo[ FishingInfo[ playerid ][ fFishType ][ slot ] ][ fiName ], FishingInfo[ playerid ][ fWeight ][ slot ]);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		} else {
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Riba se otrgla s udice!");
			new
				slot = Bit4_Get( gr_PlayerFishingSlot, playerid );
			FishingInfo[ playerid ][ fFishType ][ slot ] 	= -1;
			FishingInfo[ playerid ][ fWeight ][ slot ] 		= -1; 
			FishingInfo[ playerid ][ fFishing ]				= 0;
			Bit4_Set( gr_PlayerFishingSlot, playerid, 0 );
			TogglePlayerControllable(playerid, 1);
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
CMD:buybait(playerid, params[])
{
	if(PlayerInfo[playerid][pFishWorks] == 1) return SendClientMessage(playerid,COLOR_RED, "Vec ste kupili 10 mamaca u sat vremena!");
	if(!IsAt247(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar 24/7!");
	if(FishingInfo[playerid][fFishingBait] == 50) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate dovoljan broj mamaca!");
	if(AC_GetPlayerMoney(playerid) < 150) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za mamce!");
	FishingInfo[playerid][fFishingBait] += 10;
	PlayerInfo[playerid][pFishWorks] = 1;
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupili ste 10 mamaca.");
	PlayerToBudgetMoney(playerid, 150);
	return 1;
}
CMD:checkbait(playerid, params[])
{
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Trenutno kod sebe imate %d mamaca.", FishingInfo[playerid][fFishingBait]);
	return 1;
}
CMD:fish(playerid, params[]) 
{
	if( !IsPlayerInRangeOfPoint(playerid, 20.0, 383.3947,-2087.6040,7.8359) && !IsPlayerInRangeOfPoint(playerid, 40.0, 1242.2506, -2380.6394, 8.8305) 
		&& !IsPlayerInRangeOfPoint(playerid, 40.0, 1970.0155, -1198.7777, 19.0000) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu mjesta za pecanje!");
	if( !FishingInfo[playerid][fFishingBait] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nijednog mamca!");
	if( FishingInfo[playerid][fWeight][0] != -1 && FishingInfo[playerid][fWeight][1] != -1 && FishingInfo[playerid][fWeight][2] != -1 && FishingInfo[playerid][fWeight][3] != -1 ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas Fish Inventory je pun!");
	if( FishingInfo[playerid][fFishing] ) {
		DisablePlayerKeyInput(playerid);
		TogglePlayerControllable(playerid, true);
		FishingInfo[playerid][fFishing] = 0;
		return 1;
	}
	
	new
		object = IsObjectAttached(playerid, 18632);
	if( object == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate stap za pecanje u rukama!");
	if( 5 <= PlayerObject[playerid][object][poBoneId] <= 6 ) {
		TogglePlayerControllable(playerid, 0);
		new string[100];
		format(string, sizeof(string), "* %s stavlja mamac na udicu te zabacuje udicu u vodu.", GetName(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Zapoceli ste s pecanjem!");
		FishingInfo[playerid][fFishing] = 1;
		FishingInfo[playerid][fFishingBait]--;
		SetTimerEx("OnPlayerFishing", 1000 + random(800), false, "i", playerid);
	} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Stap za pecanje mora biti u rukama!");
	return 1;
}
CMD:sellfish(playerid, params[])
{
	if(!IsAt247(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar 24/7!");
	if( !FishingInfo[playerid][fWeight][0] && !FishingInfo[playerid][fWeight][1] && !FishingInfo[playerid][fWeight][2] && !FishingInfo[playerid][fWeight][3] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate ribe za prodati!");
	new
		slot;
	if( sscanf( params, "i", slot ) ) {
		SendClientMessage(playerid, COLOR_RED, "USAGE: /sellfish [slot (0-3)]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Za pregled koliko riba imate u inventoryu kucajte /fish_inventory");
		return 1;
	}
	if( 0 <= slot <= 3 ) {
		if( FishingInfo[playerid][fWeight][slot] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot je prazan!");
		new
			payout = FishingInfo[ playerid ][ fWeight ][ slot ] * FishInfo[ FishingInfo[playerid][fFishType][slot] ][ fiPrice ];
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prodali ste %d kilograma ribe za $%d.", FishingInfo[ playerid ][ fWeight ][ slot ], payout);
		BudgetToPlayerMoney(playerid, payout);
		FishingInfo[ playerid ][ fWeight ][ slot ] 		= -1;
		FishingInfo[ playerid ][ fFishType ][ slot ] 	= -1;
		
	} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unos slotova mora biti izmedju 0 i 3!");
	return 1;
}
CMD:fish_inventory(playerid, params[])
{
	if( !FishingInfo[playerid][fWeight][0] && !FishingInfo[playerid][fWeight][1] && !FishingInfo[playerid][fWeight][2] && !FishingInfo[playerid][fWeight][3] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je prazan!");
	
	new
		buffer[ 128 ];
	format( buffer, 128, "#0 - %dkg | #1 - %dkg | #2 - %dkg | #3 - %dkg",
		FishingInfo[playerid][fWeight][0], 
		FishingInfo[playerid][fWeight][1], 
		FishingInfo[playerid][fWeight][2], 
		FishingInfo[playerid][fWeight][3]
	);
	SendClientMessage(playerid, -1, buffer);
	return 1;
}