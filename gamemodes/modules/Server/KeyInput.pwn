/*
		KEY INPUT SDK
		Made by: B-Matt
		Date: 14.11.2014.
		Purpose: Igrac unosi Y ili N tipku putem tipkovnice i odraduje odredenu radnju.
*/

#include <YSI_Coding\y_hooks>


#define	INPUT_TYPE_BURGLAR			(1)
#define INPUT_TYPE_EGGS				(2)
#define INPUT_TYPE_MILK             (3)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

forward OnPlayerKeyInputEnds(playerid, type, succeeded);
public OnPlayerKeyInputEnds(playerid, type, succeeded)
	return 1;

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
enum E_PLAYER_INPUT_DATA
{
	piKey,
	bool:piInputed,
	piTotalScore,
	piTempScore,
	piKeyTime,
	piWholeTime,
	piTask
}
new
	InputInfo[MAX_PLAYERS][E_PLAYER_INPUT_DATA];
	
static stock 
	Bit1:PlayerUsingKeyInput<MAX_PLAYERS>,
	PlayerText:KeyInputBcg[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:KeyInputBcg1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:KeyInputBcg2[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:KeyInputTimeTD[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:KeyInputScoreTD[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ...};

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/
ptask WholeKeyInputTimer[1000](playerid)
{
	if(Bit1_Get(PlayerUsingKeyInput, playerid)) {
		if(--InputInfo[playerid][piWholeTime] == 0 ) {
			CallLocalFunction("OnPlayerKeyInputEnds", "iii", playerid, InputInfo[playerid][piTask], 0);
			DisablePlayerKeyInput(playerid);
			return 1;
		}
		
		new
			tmpString[32];
		format(tmpString, 32, "VRIJEME: %d", InputInfo[playerid][piWholeTime]);
		PlayerTextDrawSetString(playerid, KeyInputTimeTD[playerid], tmpString);
	}
	return 1;
}

timer KeyInputTimer[100](playerid)
{		
	if(Bit1_Get(PlayerUsingKeyInput, playerid))
	{
		ChangePlayerInputKey(playerid);
		// Showkey
		GameTextForPlayer(playerid, InputInfo[playerid][piKey] ? ("~g~~k~~CONVERSATION_YES~") : ("~r~~k~~CONVERSATION_NO~"), InputInfo[playerid][piKeyTime], 4);
		return 1;
	}
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
stock static DestroyKeyInputTDs(playerid)
{
	if(KeyInputBcg[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, KeyInputBcg[playerid]);
		KeyInputBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(KeyInputBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, KeyInputBcg1[playerid]);
		KeyInputBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(KeyInputBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, KeyInputBcg2[playerid]);
		KeyInputBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(KeyInputTimeTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, KeyInputTimeTD[playerid]);
		KeyInputTimeTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(KeyInputScoreTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, KeyInputScoreTD[playerid]);
		KeyInputScoreTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}
	
stock static CreateKeyInputTDs(playerid)
{
	DestroyKeyInputTDs(playerid);
	KeyInputBcg[playerid] = CreatePlayerTextDraw(playerid, 141.499557, 292.980041, "usebox");
	PlayerTextDrawLetterSize(playerid, KeyInputBcg[playerid], 0.000000, 4.547784);
	PlayerTextDrawTextSize(playerid, KeyInputBcg[playerid], 30.200096, 0.000000);
	PlayerTextDrawAlignment(playerid, KeyInputBcg[playerid], 1);
	PlayerTextDrawColor(playerid, KeyInputBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, KeyInputBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, KeyInputBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, KeyInputBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, KeyInputBcg[playerid], 0);
	PlayerTextDrawFont(playerid, KeyInputBcg[playerid], 0);
	PlayerTextDrawShow(playerid, KeyInputBcg[playerid]);

	KeyInputBcg1[playerid] = CreatePlayerTextDraw(playerid, 141.399948, 296.956024, "usebox");
	PlayerTextDrawLetterSize(playerid, KeyInputBcg1[playerid], 0.000000, 1.243888);
	PlayerTextDrawTextSize(playerid, KeyInputBcg1[playerid], 30.700000, 0.000000);
	PlayerTextDrawAlignment(playerid, KeyInputBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, KeyInputBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, KeyInputBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, KeyInputBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, KeyInputBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, KeyInputBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, KeyInputBcg1[playerid], 2);
	PlayerTextDrawShow(playerid, KeyInputBcg1[playerid]);

	KeyInputBcg2[playerid] = CreatePlayerTextDraw(playerid, 141.350051, 318.067901, "usebox");
	PlayerTextDrawLetterSize(playerid, KeyInputBcg2[playerid], 0.000000, 1.299444);
	PlayerTextDrawTextSize(playerid, KeyInputBcg2[playerid], 30.750001, 0.000000);
	PlayerTextDrawAlignment(playerid, KeyInputBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, KeyInputBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, KeyInputBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, KeyInputBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, KeyInputBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, KeyInputBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, KeyInputBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, KeyInputBcg2[playerid]);

	KeyInputTimeTD[playerid] = CreatePlayerTextDraw(playerid, 86.249961, 297.192016, "VRIJEME: 5000");
	PlayerTextDrawLetterSize(playerid, KeyInputTimeTD[playerid], 0.315449, 1.009759);
	PlayerTextDrawAlignment(playerid, KeyInputTimeTD[playerid], 2);
	PlayerTextDrawColor(playerid, KeyInputTimeTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, KeyInputTimeTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, KeyInputTimeTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, KeyInputTimeTD[playerid], 51);
	PlayerTextDrawFont(playerid, KeyInputTimeTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, KeyInputTimeTD[playerid], 1);
	PlayerTextDrawShow(playerid, KeyInputTimeTD[playerid]);

	KeyInputScoreTD[playerid] = CreatePlayerTextDraw(playerid, 86.699981, 317.631988, "POGODAKA: 200");
	PlayerTextDrawLetterSize(playerid, KeyInputScoreTD[playerid], 0.288399, 1.089280);
	PlayerTextDrawAlignment(playerid, KeyInputScoreTD[playerid], 2);
	PlayerTextDrawColor(playerid, KeyInputScoreTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, KeyInputScoreTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, KeyInputScoreTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, KeyInputScoreTD[playerid], 51);
	PlayerTextDrawFont(playerid, KeyInputScoreTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, KeyInputScoreTD[playerid], 1);
	PlayerTextDrawShow(playerid, KeyInputScoreTD[playerid]);
}

stock DisablePlayerKeyInput(playerid)
{
	DestroyKeyInputTDs(playerid);

	InputInfo[playerid][piKey] = -1;
	InputInfo[playerid][piInputed] = false;
	InputInfo[playerid][piTotalScore] = 0;
	InputInfo[playerid][piTempScore] = 0;
	InputInfo[playerid][piKeyTime] = 0;
	InputInfo[playerid][piWholeTime] = 0;
	InputInfo[playerid][piTask] = 0;
	
	Bit1_Set(PlayerUsingKeyInput, playerid, false);
	return 1;
}

stock SetPlayerKeyInput(playerid, total_score, key_time, whole_time, type)
{
	// Vars
	InputInfo[playerid][piKey]			= random(2); // 1 - YES, 0 - NO
	InputInfo[playerid][piTotalScore]	= total_score;
	InputInfo[playerid][piTempScore]	= 0;
	InputInfo[playerid][piKeyTime]		= key_time;
	InputInfo[playerid][piWholeTime]	= whole_time;
	InputInfo[playerid][piTask] 		= type;
	// Timers
	defer KeyInputTimer[key_time](playerid);
	Bit1_Set(PlayerUsingKeyInput, playerid, true);
	
	// Showkey
	CreateKeyInputTDs(playerid);
	new
		tmpString[32];
	format(tmpString, 32, "VRIJEME: %d", whole_time);
	PlayerTextDrawSetString(playerid, KeyInputTimeTD[playerid], tmpString);
	
	format(tmpString, 32, "SCORE: %d/%d", InputInfo[playerid][piTempScore], InputInfo[playerid][piTotalScore]);
	PlayerTextDrawSetString(playerid, KeyInputScoreTD[playerid], tmpString);
	return 1;
}

stock ChangePlayerInputKey(playerid)
{
	InputInfo[playerid][piInputed] 	= false;
	InputInfo[playerid][piKey]		= random(2); // 1 - YES, 0 - NO
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

public OnPlayerDisconnect(playerid, reason)
{
	if(Bit1_Get(PlayerUsingKeyInput, playerid))
		DisablePlayerKeyInput(playerid);
			
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new key_time = InputInfo[playerid][piKeyTime];
	if(PRESSED(KEY_YES)) { 
		if(Bit1_Get(PlayerUsingKeyInput, playerid)) {
			if(InputInfo[playerid][piKey] != -1 ) {
				if(InputInfo[playerid][piInputed] ) return 1;
				
				if(InputInfo[playerid][piKey] ) { // KEY_YES
					GameTextForPlayer(playerid, "~n~", 2, 4);
					InputInfo[playerid][piKey] = -1;
					InputInfo[playerid][piInputed] = false;
					
					if(++InputInfo[playerid][piTempScore] == InputInfo[playerid][piTotalScore] ) {
						CallLocalFunction("OnPlayerKeyInputEnds", "iii", playerid, InputInfo[playerid][piTask], 1);
						DisablePlayerKeyInput(playerid);
					} else
						defer KeyInputTimer[key_time](playerid);
						
					new
						tmpString[32];
					format(tmpString, 32, "SCORE: %d/%d", InputInfo[playerid][piTempScore], InputInfo[playerid][piTotalScore]);
					PlayerTextDrawSetString(playerid, KeyInputScoreTD[playerid], tmpString);
				}
				else {
					GameTextForPlayer(playerid, "~n~", 2, 4);
					InputInfo[playerid][piKey] = -1;
					InputInfo[playerid][piInputed] = false;

					if(InputInfo[playerid][piTempScore] > 0)
						InputInfo[playerid][piTempScore]--;

					defer KeyInputTimer[key_time](playerid);
					
					new
						tmpString[32];
					format(tmpString, 32, "SCORE: %d/%d", InputInfo[playerid][piTempScore], InputInfo[playerid][piTotalScore]);
					PlayerTextDrawSetString(playerid, KeyInputScoreTD[playerid], tmpString);
				}
			}
		}
	}
	if(PRESSED(KEY_NO)) {
		if(Bit1_Get(PlayerUsingKeyInput, playerid)) {
			if(InputInfo[playerid][piKey] != -1 ) {
				if(InputInfo[playerid][piInputed] ) return 1;
				
				if(!InputInfo[playerid][piKey] ) { // KEY_NO
					GameTextForPlayer(playerid, "~n~", 2, 4);
					InputInfo[playerid][piKey] = -1;
					InputInfo[playerid][piInputed] = false;
					
					if(++InputInfo[playerid][piTempScore] == InputInfo[playerid][piTotalScore] ) {
						CallLocalFunction("OnPlayerKeyInputEnds", "iii", playerid, InputInfo[playerid][piTask], 1);
						DisablePlayerKeyInput(playerid);
					} else
						defer KeyInputTimer[key_time](playerid);
					
					new
						tmpString[32];
					format(tmpString, 32, "SCORE: %d/%d", InputInfo[playerid][piTempScore], InputInfo[playerid][piTotalScore]);
					PlayerTextDrawSetString(playerid, KeyInputScoreTD[playerid], tmpString);
				}
				else {
					GameTextForPlayer(playerid, "~n~", 2, 4);
					InputInfo[playerid][piKey] = -1;
					InputInfo[playerid][piInputed] = false;
					if(InputInfo[playerid][piTempScore] > 0)
						InputInfo[playerid][piTempScore]--;
					defer KeyInputTimer[key_time](playerid);

					new
						tmpString[32];
					format(tmpString, 32, "SCORE: %d/%d", InputInfo[playerid][piTempScore], InputInfo[playerid][piTotalScore]);
					PlayerTextDrawSetString(playerid, KeyInputScoreTD[playerid], tmpString);
				}
			}
		}
	}
    return 1;
}
