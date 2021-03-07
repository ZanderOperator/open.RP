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
#define REST_TYPE_NONE			(0)
#define REST_TYPE_PIZZA			(1)
#define REST_TYPE_BURG			(2)
#define REST_TYPE_CLUCK			(3)

#define MEAL_OBJECT_INDEX		(8)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
enum E_MEAL_DATA {
	mdModel,
	mdName[16],
	Float:mdHunger,
	mdPrice
}
static stock
	MealInfo[][E_MEAL_DATA] = {
		{2218,"Buster", 0.2, 5}, // Pizza Stack
		{2219,"Double D-Luxe", 0.4, 10},
		{2220,"Full Rack", 0.8, 15},
		{2355,"Salad Meal", 0.75, 15},
		{2213,"Moo Kids Meal", 0.2, 4}, // Burger Shot
		{2214,"Beef Tower Meal", 0.4, 7},
		{2212,"Meat Stack Meal", 0.8, 15},
		{2354,"Salad Meal", 0.75, 15},
		{2215,"Little Meal", 0.2, 5}, // Cluckin' Bell
		{2216,"Big Meal", 0.4, 8},
		{2216,"Huge Meal", 0.8, 14},
		{2353,"Salad Meal", 0.75, 15}
	};

new
	PizzaActor,
	BurgerActor,
	CluckinActor,
	PublicMealObject[MAX_PLAYERS],
	MealPreviewObj[MAX_PLAYERS],
	MealTimestamp[MAX_PLAYERS];
	
new
	Bit1: r_CarryMeal		<MAX_PLAYERS> = {Bit1:false, ... },
	Bit1: r_PlayerBoughtMeal<MAX_PLAYERS> = {Bit1:false, ... },
	Bit1: r_PlayerEditMeal  <MAX_PLAYERS> = {Bit1:false, ... },
	Bit4: r_PlayerRestoran 	<MAX_PLAYERS> = {Bit4:0, ... },
	Bit8: r_MealIndex		<MAX_PLAYERS> = {Bit8:0, ... };

new 
	PlayerText:MealBcg[MAX_PLAYERS],
	PlayerText:MealTitle[MAX_PLAYERS],
	PlayerText:MealText[MAX_PLAYERS];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock static DestroyMealTextDraws(playerid)
{
	if(MealBcg[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, MealBcg[playerid]);
		MealBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(MealTitle[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, MealTitle[playerid]);
		MealTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(MealText[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, MealText[playerid]);
		MealText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
}

stock static CreateMealTextDraws(playerid)
{
	DestroyMealTextDraws(playerid);
	MealBcg[playerid] = CreatePlayerTextDraw(playerid, 424.239990, 322.566711, "usebox");
	PlayerTextDrawLetterSize(playerid, MealBcg[playerid], 0.000000, 8.396468);
	PlayerTextDrawTextSize(playerid, MealBcg[playerid], 251.199966, 0.000000);
	PlayerTextDrawAlignment(playerid, MealBcg[playerid], 1);
	PlayerTextDrawColor(playerid, MealBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, MealBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, MealBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, MealBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MealBcg[playerid], 0);
	PlayerTextDrawFont(playerid, MealBcg[playerid], 0);
	PlayerTextDrawShow(playerid, MealBcg[playerid]);

	MealTitle[playerid] = CreatePlayerTextDraw(playerid, 317.200195, 312.106689, "Cluckin' Bell");
	PlayerTextDrawLetterSize(playerid, MealTitle[playerid], 0.518319, 1.938488);
	PlayerTextDrawAlignment(playerid, MealTitle[playerid], 2);
	PlayerTextDrawColor(playerid, MealTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MealTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MealTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MealTitle[playerid], 51);
	PlayerTextDrawFont(playerid, MealTitle[playerid], 3);
	PlayerTextDrawSetProportional(playerid, MealTitle[playerid], 1);
	PlayerTextDrawShow(playerid, MealTitle[playerid]);

	MealText[playerid] = CreatePlayerTextDraw(playerid, 336.159820, 334.854858, "Buster Menu~n~Cijena: 10$~n~+0.2 hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak");
	PlayerTextDrawLetterSize(playerid, MealText[playerid], 0.416759, 1.246577);
	PlayerTextDrawAlignment(playerid, MealText[playerid], 2);
	PlayerTextDrawColor(playerid, MealText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MealText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MealText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MealText[playerid], 51);
	PlayerTextDrawFont(playerid, MealText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MealText[playerid], 1);
	PlayerTextDrawShow(playerid, MealText[playerid]);
}

stock static InitPlayerMealMenu(playerid, restoran)
{
	switch(restoran) {
		case REST_TYPE_PIZZA: {
			CreateMealTextDraws(playerid);
			new
				mealIndex = 0,
				tmpString[121];
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Pizza Stack");
			
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 375.9601, -118.0569, 1001.6000, -24.0000, 20.0000, 73.2000);
			InterpolateCameraPos(playerid, 375.6654, -119.0627, 1002.0000, 375.6654, -119.0627, 1002.0000, 10000000);
			InterpolateCameraLookAt(playerid, 375.6654, -117.9716, 1001.6000, 375.6654, -117.9716, 1001.6000, 10000000);
			SetPlayerPos(playerid, 375.7114, -119.5164, 1001.5000);
			ApplyActorAnimation(PizzaActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			ApplyActorAnimation(PizzaActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
		case REST_TYPE_BURG: {
			CreateMealTextDraws(playerid);
			new
				mealIndex = 4,
				tmpString[121];
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Burger Shoot");
			
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 375.8304, -66.7443, 1001.6000, -24.0000, 16.0000, 69.0000);
			InterpolateCameraPos(playerid, 375.8065, -68.1410, 1002.2000, 375.8065, -68.1410, 1002.2000, 10000000);
			InterpolateCameraLookAt(playerid, 375.9679, -66.6702, 1001.6814, 375.9679, -66.6702, 1001.6814, 10000000);
			SetPlayerPos(playerid, 376.5536, -68.1503, 1001.5000);
			ApplyActorAnimation(BurgerActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			ApplyActorAnimation(BurgerActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
		case REST_TYPE_CLUCK: {
			CreateMealTextDraws(playerid);
			new
				mealIndex = 8,
				tmpString[121];
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Cluckin' Bell");
			
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 369.3603, -5.3709, 1002.0000, -22.0000, 16.0000, 73.2000);
			InterpolateCameraPos(playerid, 369.2495, -6.4070, 1002.5000, 369.2495, -6.4070, 1002.5000, 10000000);
			InterpolateCameraLookAt(playerid, 369.3603, -5.3709, 1002.0000, 369.3603, -5.3709, 1002.0000, 10000000);
			SetPlayerPos(playerid, 368.0232, -6.4187, 1001.9000);
			ApplyActorAnimation(CluckinActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			ApplyActorAnimation(CluckinActor, "SHOP","SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 0);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
	}
	Bit4_Set(r_PlayerRestoran, playerid, restoran);
	return 1;
}

stock static ChangePlayerMealPreview(playerid)
{
	switch(Bit4_Get(r_PlayerRestoran, playerid)) {
		case REST_TYPE_PIZZA: {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid),
				tmpString[121];
			CreateMealTextDraws(playerid);
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Pizza Stack");
			
			if(IsValidPlayerObject(playerid, MealPreviewObj[playerid])) {
				DestroyPlayerObject(playerid,MealPreviewObj[playerid]);
				MealPreviewObj[playerid] = INVALID_OBJECT_ID;
			}
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 375.9601, -118.0569, 1001.6000, -24.0000, 20.0000, 73.2000);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
		case REST_TYPE_BURG: {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid),
				tmpString[121];
			CreateMealTextDraws(playerid);
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Burger Shoot");
			
			if(IsValidPlayerObject(playerid, MealPreviewObj[playerid])) {
				DestroyPlayerObject(playerid,MealPreviewObj[playerid]);
				MealPreviewObj[playerid] = INVALID_OBJECT_ID;
			}
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 375.8304, -66.7443, 1001.6000, -24.0000, 16.0000, 69.0000);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
		case REST_TYPE_CLUCK: {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid),
				tmpString[121];
			CreateMealTextDraws(playerid);
			format(tmpString, 121, "%s~n~Cijena: %d$~n~+%.1f hunger~n~~y~~k~~PED_SPRINT~ za kupnju~n~~r~~k~~PED_JUMPING~ za odustanak",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice],
				MealInfo[mealIndex][mdHunger]
			);
			PlayerTextDrawSetString(playerid, MealText[playerid], tmpString);
			PlayerTextDrawSetString(playerid, MealTitle[playerid], "Pizza Stack");
			
			if(IsValidPlayerObject(playerid, MealPreviewObj[playerid])) {
				DestroyPlayerObject(playerid,MealPreviewObj[playerid]);
				MealPreviewObj[playerid] = INVALID_OBJECT_ID;
			}
			MealPreviewObj[playerid] = CreatePlayerObject(playerid, MealInfo[mealIndex][mdModel], 369.3603, -5.3709, 1002.0000, -22.0000, 16.0000, 73.2000);
			Bit8_Set(r_MealIndex, playerid, mealIndex);
		}
	}
	return 1;
}

stock static IsPlayerInRangeOfGarbage(playerid, Float:radius) 
{
	if(0 <= Bit8_Get(r_MealIndex, playerid) <= 3)
		return ( IsPlayerInRangeOfPoint(playerid, radius, 2094.0000, -1789.0000, 13.2000) || IsPlayerInRangeOfPoint(playerid, radius, 2128.1716, -1785.8097, 13.2000) || IsPlayerInRangeOfPoint(playerid, radius, 373.6988, -133.4180, 1000.4883) || IsPlayerInRangeOfPoint(playerid, radius, 371.2730, -118.9202, 1000.4883));
	else if(4 <= Bit8_Get(r_MealIndex, playerid) <= 7) // Burg
		return ( IsPlayerInRangeOfPoint(playerid, radius, 369.8281, -70.1641, 1000.5078) || IsPlayerInRangeOfPoint(playerid, radius, 361.9844, -73.4844, 1000.5078) || IsPlayerInRangeOfPoint(playerid, radius, 379.9219, -73.7813, 1000.5078));
	else if(8 <= Bit8_Get(r_MealIndex, playerid) <= 11)
		return ( IsPlayerInRangeOfPoint(playerid, radius, 367.2500, -10.3203, 1001.4766) || IsPlayerInRangeOfPoint(playerid, radius, 363.6172, -6.0859, 1001.4766) || IsPlayerInRangeOfPoint(playerid, radius, 373.2422, -6.0703, 1001.4766)); 
	return 0;
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
	PizzaActor = CreateActor(155, 375.6232, -117.4190, 1001.5200, 180.0);
	ApplyActorAnimation(PizzaActor, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	
	CluckinActor = CreateActor(167, 367.9953, -4.1758, 1001.8200, 180.0);
	ApplyActorAnimation(CluckinActor, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	
	BurgerActor = CreateActor(205, 376.4394, -65.6999, 1001.5200, 180.0);
	ApplyActorAnimation(BurgerActor, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	
	// Pizza bin izvana
	CreateDynamicObject(1359, 2094.00000, -1789.00000, 13.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11706, 371.27298, -118.92024, 1000.48828,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(11706, 373.69879, -133.41800, 1000.48828,   0.00000, 0.00000, 180.00000);
	return 1;
}

hook OnGameModeExit()
{
	DestroyActor(PizzaActor);
	DestroyActor(CluckinActor);
	DestroyActor(BurgerActor);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	// Cluckin' Bell
	RemoveBuildingForPlayer(playerid, 2770, 366.4219, -6.0703, 1001.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 2770, 377.9609, -7.1563, 1001.4766, 0.25);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsValidDynamicObject(PublicMealObject[playerid])) {
		DestroyDynamicObject(PublicMealObject[playerid]);
		PublicMealObject[playerid] = INVALID_OBJECT_ID;
		MealTimestamp[playerid] = 0;
	}
	else if(IsValidPlayerObject(playerid, PublicMealObject[playerid])) {
		DestroyPlayerObject(playerid, PublicMealObject[playerid]);
		PublicMealObject[playerid] = INVALID_OBJECT_ID;
		MealTimestamp[playerid] = 0;
	}
	
	Bit1_Set(r_CarryMeal,		playerid, false);
	Bit1_Set(r_PlayerBoughtMeal,playerid, false);
	Bit1_Set(r_PlayerEditMeal,	playerid, false);
	Bit4_Set(r_PlayerRestoran, 	playerid, 0);
	Bit8_Set(r_MealIndex,		playerid, 0);
	return 1;
}

hook OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(response == EDIT_RESPONSE_FINAL) 
	{
		if(playerobject && PublicMealObject[playerid] == objectid) 
		{
		    if(Bit1_Get(r_PlayerEditMeal, playerid))
			{
				if(IsValidPlayerObject(playerid, PublicMealObject[playerid])) {
					DestroyPlayerObject(playerid, PublicMealObject[playerid]);
					PublicMealObject[playerid] = INVALID_OBJECT_ID;
					MealTimestamp[playerid] = 0;
				}
				PublicMealObject[playerid] = CreateDynamicObject(MealInfo[Bit8_Get(r_MealIndex, playerid)][mdModel], fX, fY, fZ, fRotX, fRotY, fRotZ, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 45.0, 45.0);
				MealTimestamp[playerid] = gettimestamp() + 1800;
				Bit1_Set(r_PlayerEditMeal,	playerid, false);
			}
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP)) { // Odustaje
		if(REST_TYPE_PIZZA <= Bit4_Get(r_PlayerRestoran, playerid) <= REST_TYPE_CLUCK) {
			if(IsValidPlayerObject(playerid, MealPreviewObj[playerid])) {
				DestroyPlayerObject(playerid,MealPreviewObj[playerid]);
				MealPreviewObj[playerid] = INVALID_OBJECT_ID;
			}
			DestroyMealTextDraws(playerid);		
			Bit4_Set(r_PlayerRestoran, playerid, REST_TYPE_NONE);
			Bit8_Set(r_MealIndex, playerid, 12);
			TogglePlayerSpectating(playerid, false);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, true);
		}
	}
	if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT)) { // Kupuje?
		if(REST_TYPE_PIZZA <= Bit4_Get(r_PlayerRestoran, playerid) <= REST_TYPE_CLUCK) {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid);
			va_ShowPlayerDialog(playerid, DIALOG_MEAL_BUY, DIALOG_STYLE_MSGBOX, "Restoran", "Zelite li kupiti %s za %d$?", "Buy", "Abort", 
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice]
			);
		}
	}
	if((newkeys & KEY_ANALOG_RIGHT) && !(oldkeys & KEY_ANALOG_RIGHT)) { // Ide naprijed sa jelom
		if(REST_TYPE_PIZZA <= Bit4_Get(r_PlayerRestoran, playerid) <= REST_TYPE_CLUCK) {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid);
			if(( mealIndex + 1) > ( Bit4_Get(r_PlayerRestoran, playerid) * 4) - 1) return PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
			mealIndex++;
			Bit8_Set(r_MealIndex, playerid, mealIndex);
			ChangePlayerMealPreview(playerid);
		}
	}
	if((newkeys & KEY_ANALOG_LEFT) && !(oldkeys & KEY_ANALOG_LEFT)) { // Ide unatrag sa jelom
		if(REST_TYPE_PIZZA <= Bit4_Get(r_PlayerRestoran, playerid) <= REST_TYPE_CLUCK) {
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid);
			if(( mealIndex - 1) < ( Bit4_Get(r_PlayerRestoran, playerid) - 1) * 4) return PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
			mealIndex--;
			Bit8_Set(r_MealIndex, playerid, mealIndex);
			ChangePlayerMealPreview(playerid);
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case DIALOG_MEAL_BUY: {
			if(!response) return 1;
			new
				mealIndex = Bit8_Get(r_MealIndex, playerid);
			if(AC_GetPlayerMoney(playerid) < MealInfo[mealIndex][mdPrice]) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za kupovinu jela (%d$)!", MealInfo[mealIndex][mdPrice]);
			PlayerToBudgetMoney(playerid, MealInfo[mealIndex][mdPrice]);
			
			// Clear
			if(IsValidPlayerObject(playerid, MealPreviewObj[playerid])) {
				DestroyPlayerObject(playerid,MealPreviewObj[playerid]);
				MealPreviewObj[playerid] = INVALID_OBJECT_ID;
			}
			
			TogglePlayerControllable(playerid, true);
			DestroyMealTextDraws(playerid);		
			Bit4_Set(r_PlayerRestoran, playerid, REST_TYPE_NONE);
			SetCameraBehindPlayer(playerid);
			
			// Objekt
			if(IsValidDynamicObject(PublicMealObject[playerid])) {
				DestroyDynamicObject(PublicMealObject[playerid]);
				PublicMealObject[playerid] = INVALID_OBJECT_ID;
				MealTimestamp[playerid] = 0;
			}
			SetPlayerArmedWeapon(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, MEAL_OBJECT_INDEX, MealInfo[mealIndex][mdModel], 5, 0.037000, 0.017999, 0.431999, 76.599922, 156.700042, 178.499969);
			EditAttachedObject(playerid, MEAL_OBJECT_INDEX);
			va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili %s za %d$, sada namjestite objekt za drzanje i koristite /meal za vise komandi!",
				MealInfo[mealIndex][mdName],
				MealInfo[mealIndex][mdPrice]
			);
			Bit1_Set(r_PlayerBoughtMeal, playerid, true);
			Bit1_Set(r_CarryMeal, playerid, true);
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
CMD:order(playerid, params[])
{
	if(Bit1_Get(r_PlayerBoughtMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste kupili jelo u restoranu (Pizza/Burg/Cluckin')! Odlozite ga sa /meal dump!");
	if(IsPlayerInRangeOfPoint(playerid,15.0,375.3066,-118.8028,1001.4995)) { // Pizza
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Za biranje jela koristite tipke NUM 4 i NUM 6.");
		TogglePlayerControllable(playerid, false);
		InitPlayerMealMenu(playerid, REST_TYPE_PIZZA);
	}
	else if(IsPlayerInRangeOfPoint( playerid,15.0,368.9718,-6.6316,1001.8516)) { // Cluckin'
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Za biranje jela koristite tipke NUM 4 i NUM 6.");
		TogglePlayerControllable(playerid, false);
		InitPlayerMealMenu(playerid, REST_TYPE_CLUCK);
	}
	else if(IsPlayerInRangeOfPoint(playerid,15.0,376.5994,-67.4428,1001.5078)) { // Burger
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Za biranje jela koristite tipke NUM 4 i NUM 6.");
		TogglePlayerControllable(playerid, false);
		InitPlayerMealMenu(playerid, REST_TYPE_BURG);
	}
	return 1;
}

CMD:meal(playerid, params[])
{
	if(!Bit1_Get(r_PlayerBoughtMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kupili jelo u restoranu (Pizza/Burg/Cluckin')!");
	new
		param[5];
	if(sscanf( params, "s[5] ", param)) return SendClientMessage(playerid, COLOR_RED, "[?]: /meal [edit/put/take/dump]");
	if(!strcmp(param, "edit", true)) {
		if(!Bit1_Get(r_CarryMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nosite jelo u rukama!");
		EditAttachedObject(playerid, MEAL_OBJECT_INDEX);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uredjujete tacnu na svome liku za pomicanje kamere koristite tipku ~k~~PED_SPRINT~!");
	}
	else if(!strcmp(param, "put", true)) {
		if(!Bit1_Get(r_CarryMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nosite jelo u rukama!");
		RemovePlayerAttachedObject(playerid, MEAL_OBJECT_INDEX);
		new
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
        Bit1_Set(r_PlayerEditMeal,	playerid, true);
		PublicMealObject[playerid] = CreatePlayerObject(playerid, MealInfo[Bit8_Get(r_MealIndex, playerid)][mdModel], X, Y, Z, -156.500091, -158.700027, 70.200035);
		EditPlayerObject(playerid, PublicMealObject[playerid]);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		Bit1_Set(r_CarryMeal, playerid, false);
	}
	else if(!strcmp(param, "take", true)) {
		if(Bit1_Get(r_CarryMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec nosite jelo u rukama!");
		new
			Float:X, Float:Y, Float:Z;
		GetDynamicObjectPos(PublicMealObject[playerid], X, Y, Z);
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, X, Y, Z)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svojega jela!");
		if(IsValidDynamicObject(PublicMealObject[playerid])) {
			DestroyDynamicObject(PublicMealObject[playerid]);
			PublicMealObject[playerid] = INVALID_OBJECT_ID;
			MealTimestamp[playerid] = 0;
		}
		SetPlayerArmedWeapon(playerid, 0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, MEAL_OBJECT_INDEX, MealInfo[0][mdModel], 5, 0.037000, 0.017999, 0.431999, 76.599922, 156.700042, 178.499969);
		EditAttachedObject(playerid, MEAL_OBJECT_INDEX);
		Bit1_Set(r_PlayerEditMeal,	playerid, false);
		Bit1_Set(r_CarryMeal, playerid, true);
	}
	else if(!strcmp(param, "dump", true)) {
		if(!Bit1_Get(r_CarryMeal, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nosite jelo u rukama!");
		if(!IsPlayerInRangeOfGarbage(playerid, 2.5)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mjesta za odlaganje odstataka!");
		SetPlayerArmedWeapon(playerid, 0);
		RemovePlayerAttachedObject(playerid, MEAL_OBJECT_INDEX);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		Bit1_Set(r_PlayerBoughtMeal, playerid, false);
		Bit1_Set(r_PlayerEditMeal,	playerid, false);
		Bit1_Set(r_CarryMeal, playerid, false);
		Bit8_Set(r_MealIndex, playerid, 12);
	}
	return 1;
}
