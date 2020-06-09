/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

#define SCRAMBLING_HOUSE			(1)

new
	ScrambleWordInfo[20][16 char] =
{
	!"avijacija" 	,
	!"puska"		,
	!"glazbalo"		,
	!"prijestolje" 	,
	!"predsjednik" 	,
	!"parlament" 	,
	!"pneumatika"	,
	!"govornik"		,
	!"svecenik" 	,
	!"razgovori"	,
	!"zrakoplovstvo",
	!"hurmasice" 	,
	!"baklava"		,
	!"snicla"		,
	!"stomatolog"	,
	!"vinjak"		,
	!"buhtla"		,
	!"podpresjednik",
	!"ministrice"	,
	!"zemlja"		
};
	
static stock
	scrambleTimer[ MAX_PLAYERS ],
	scrambleTimes[ MAX_PLAYERS ],
	scrambleType[ MAX_PLAYERS ],
	scrambleCounter[ MAX_PLAYERS ],
	lastScrambleId[ MAX_PLAYERS ];
	
// TextDraws
static stock
	PlayerText:ScrambleBcg1[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ScrambleBcg2[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ScrambleTitle[ MAX_PLAYERS ]	 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ScrambleNote[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ScrambledWord[ MAX_PLAYERS ]	 	= { PlayerText:INVALID_TEXT_DRAW, ... };

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
forward ScramblingTimer(playerid);
public ScramblingTimer(playerid)
{
	static
		tmpString[ 26 ];
	format(tmpString, sizeof(tmpString), "Unscramble u %d", scrambleTimes[ playerid ] - 1);
	PlayerTextDrawSetString(playerid, ScrambleTitle[ playerid ], tmpString);
	
	if( --scrambleTimes[ playerid ] <= 0 ) {
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Vase vrijeme je isteklo! Rijesili ste %d slagalica.", scrambleCounter[ playerid ] % 10);
		if( scrambleType[ playerid ] == SCRAMBLING_HOUSE ) {
			PlayHouseAlarm( Bit16_Get( gr_PlayerInfrontHouse, playerid ) );
			StopScrambling(playerid);
		}
	}
}

hook OnPlayerDisconecct(playerid){
    StopScrambling(playerid);
	lastScrambleId[playerid] = -1;
	return (true);
}	

stock static DestroyScramblingTDs(playerid)
{
	if( ScrambleBcg1[ playerid ]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, ScrambleBcg1[ playerid ]	);
		ScrambleBcg1[ playerid ]	= PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( ScrambleBcg2[ playerid ]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, ScrambleBcg2[ playerid ]  );
		ScrambleBcg2[ playerid ]	= PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( ScrambleTitle[ playerid ]  != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, ScrambleTitle[ playerid ] );
		ScrambleTitle[ playerid ]  = PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( ScrambleNote[ playerid ]	!= PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, ScrambleNote[ playerid ]  );
		ScrambleNote[ playerid ]	= PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( ScrambledWord[ playerid ]  != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, ScrambledWord[ playerid ] );
		ScrambledWord[ playerid ]  = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static ShowScramblingTDs(playerid)
{
	DestroyScramblingTDs(playerid);
	
	ScrambleBcg1[playerid] = CreatePlayerTextDraw(playerid, 615.900390, 111.260002, "usebox");
	PlayerTextDrawLetterSize(playerid, ScrambleBcg1[playerid], 0.000000, 7.437777);
	PlayerTextDrawTextSize(playerid, ScrambleBcg1[playerid], 490.049987, 0.000000);
	PlayerTextDrawAlignment(playerid, ScrambleBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, ScrambleBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, ScrambleBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, ScrambleBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, ScrambleBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ScrambleBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, ScrambleBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, ScrambleBcg1[playerid]);

	ScrambleBcg2[playerid] = CreatePlayerTextDraw(playerid, 616.349731, 110.868003, "usebox");
	PlayerTextDrawLetterSize(playerid, ScrambleBcg2[playerid], 0.000000, 1.173887);
	PlayerTextDrawTextSize(playerid, ScrambleBcg2[playerid], 490.100006, 0.000000);
	PlayerTextDrawAlignment(playerid, ScrambleBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, ScrambleBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, ScrambleBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, ScrambleBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, ScrambleBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ScrambleBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, ScrambleBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, ScrambleBcg2[playerid]);

	ScrambleTitle[playerid] = CreatePlayerTextDraw(playerid, 552.950012, 111.327980, "Unscramble u 5000");
	PlayerTextDrawLetterSize(playerid, ScrambleTitle[playerid], 0.281200, 0.966640);
	PlayerTextDrawAlignment(playerid, ScrambleTitle[playerid], 2);
	PlayerTextDrawColor(playerid, ScrambleTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ScrambleTitle[playerid], 1);
	PlayerTextDrawSetOutline(playerid, ScrambleTitle[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, ScrambleTitle[playerid], 255);
	PlayerTextDrawFont(playerid, ScrambleTitle[playerid], 2);
	PlayerTextDrawSetProportional(playerid, ScrambleTitle[playerid], 1);
	PlayerTextDrawShow(playerid, ScrambleTitle[playerid]);

	ScrambleNote[playerid] = CreatePlayerTextDraw(playerid, 499.449951, 168.448089, "Kucajte /unscramble za unos");
	PlayerTextDrawLetterSize(playerid, ScrambleNote[playerid], 0.216349, 0.780160);
	PlayerTextDrawAlignment(playerid, ScrambleNote[playerid], 1);
	PlayerTextDrawColor(playerid, ScrambleNote[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ScrambleNote[playerid], 1);
	PlayerTextDrawSetOutline(playerid, ScrambleNote[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, ScrambleNote[playerid], 255);
	PlayerTextDrawFont(playerid, ScrambleNote[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ScrambleNote[playerid], 1);
	PlayerTextDrawShow(playerid, ScrambleNote[playerid]);

	ScrambledWord[playerid] = CreatePlayerTextDraw(playerid, 552.100402, 140.392044, "Bmatt Car");
	PlayerTextDrawLetterSize(playerid, ScrambledWord[playerid], 0.394149, 1.304319);
	PlayerTextDrawAlignment(playerid, ScrambledWord[playerid], 2);
	PlayerTextDrawColor(playerid, ScrambledWord[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ScrambledWord[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ScrambledWord[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ScrambledWord[playerid], 51);
	PlayerTextDrawFont(playerid, ScrambledWord[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ScrambledWord[playerid], 1);
	PlayerTextDrawShow(playerid, ScrambledWord[playerid]);
}

stock static ScrambleWord(word[])
{
	new
		temp_word[ 16 ];
		
	strunpack(temp_word, word);
	for(new i = 0; temp_word[i] != EOS; i++) {
		new index1 = random(strlen(temp_word));
		new index2 = random(strlen(temp_word));
		new temp = temp_word[index1];
		
		temp_word[index1] = temp_word[index2];
		temp_word[index2] = temp;
	}
	return temp_word;
}

stock static UnscrambleWord(playerid, const input_word[])
{
	new
		tmp_word[ 16 ];
	strunpack(tmp_word, ScrambleWordInfo[ lastScrambleId[ playerid ] ]);
	return ( !strcmp(tmp_word, input_word, false ) ) ? 1 : 0;
}

stock InitScrambling(playerid, const countings, const time, type)
{
	scrambleTimes[ playerid ]	= time;
	scrambleTimer[ playerid ] 	= SetTimerEx("ScramblingTimer", 1000, true, "i", playerid);
	scrambleCounter[ playerid ] = countings;
	scrambleType[ playerid ]	= type;
	
	lastScrambleId[ playerid ] 	= random(sizeof(ScrambleWordInfo));
	
	new
		scrambled_word[ 16 ],
		tmpString[ 26 ];
	format(scrambled_word, 16, ScrambleWord(ScrambleWordInfo[ lastScrambleId[ playerid ] ]));	
	ShowScramblingTDs(playerid);
	
	PlayerTextDrawSetString(playerid, ScrambledWord[playerid], scrambled_word);
	
	format(tmpString, 26, "Unscramble u %d", scrambleTimes[ playerid ]);
	PlayerTextDrawSetString(playerid, ScrambleTitle[playerid], tmpString);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukoliko zelite prestati scrambling kucajte /scramble_stop");
	TogglePlayerControllable(playerid, false);
	return 1;
}

stock StopScrambling(playerid)
{
	KillTimer( scrambleTimer[ playerid ] );
	scrambleCounter[ playerid ] = 0;
	lastScrambleId[ playerid ] 	= -1;
	DestroyScramblingTDs(playerid);
	TogglePlayerControllable(playerid, true);
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
CMD:unscramble(playerid, params[])
{
	if( lastScrambleId[ playerid ] == -1 )  return SendClientMessage( playerid, COLOR_RED, "Nemate pokrenuti scramble sistem!");
	new
		word[ 16 ];
	if( sscanf( params, "s[16]", word ) ) return SendClientMessage(playerid, COLOR_RED, "USAGE: /unscramble [rijec]");
	if( 1 <= strlen(word) <= 15 ) {
		if( UnscrambleWord(playerid, word) ) {			
			if( --scrambleCounter[ playerid ] == 0 ) {
				
				if( scrambleType[ playerid ] == SCRAMBLING_HOUSE )  {
					Bit1_Set( gr_PlayerHouseAlarmOff, playerid, true );
					GameTextForPlayer(playerid, "~w~Alarm ~g~ugasen", 1500, 2);
				}
				StopScrambling(playerid);
			}
			
			SCRAMBLING:
			new
				scramble_id = random(sizeof(ScrambleWordInfo));
			
			if( scramble_id == lastScrambleId[ playerid ] ) goto SCRAMBLING;
			lastScrambleId[ playerid ] = scramble_id;
			
			new
				scrambled_word[ 16 ],
				tmpString[ 26 ];
			format(scrambled_word, 16, ScrambleWord(ScrambleWordInfo[ scramble_id ]) );
			
			PlayerTextDrawSetString(playerid, ScrambledWord[playerid], scrambled_word);
			format(tmpString, 26, "Unscramble u %d", scrambleTimes[ playerid ]);
			PlayerTextDrawSetString(playerid, ScrambleTitle[playerid], tmpString);
			
			KillTimer( scrambleTimer[ playerid ] );
			scrambleTimer[ playerid ] 	= SetTimerEx("ScramblingTimer", 1000, true, "i", playerid);	
		} else GameTextForPlayer(playerid, "~r~Krivi unos rijeci!", 1800, 1);
	} else SendClientMessage(playerid, COLOR_RED, "Raspon znakova u rijeci mora biti izmedju 1 i 15!");	
	return 1;
}

CMD:scramble_stop(playerid, params[])
{
	StopScrambling(playerid);
	return 1;
}
