#include <YSI_Coding\y_hooks>

// Defines
#define MAX_DUMPED_GOODS		(75)

#define DIALOG_TYPE_MONEY		(1)
#define DIALOG_TYPE_WATCH       (2)
#define DIALOG_TYPE_MOBILE      (3)
#define DIALOG_TYPE_CRYPTO       (4)
#define DIALOG_TYPE_MASK        (5)
#define DIALOG_TYPE_RADIO		(6)
#define DIALOG_TYPE_TV          (7)
#define DIALOG_TYPE_MICRO       (8)
#define DIALOG_TYPE_PHONE	    (9)
	
#define GOOD_MONEY_WATCH		(50)//(7)
#define GOOD_MONEY_MOBILE       (215)//(115)
#define GOOD_MONEY_CRYPTO       (22)//(22)
#define GOOD_MONEY_MASK         (700)//(350)
#define GOOD_MONEY_RADIO		(600)//(242)
#define GOOD_MONEY_TV           (900)//(450)
#define GOOD_MONEY_MICRO        (250)//(125)
#define GOOD_MONEY_PHONE        (400)//(190)


/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/

enum E_ROBBER_GOODS_DATA 
{
	rbSlotsGoods[5]
}
new
	RobbingInfo[MAX_PLAYERS][E_ROBBER_GOODS_DATA];
	
enum E_GOODS_POSITION
{
	gModel,
	Float:gPosX,
	Float:gPosY,
	Float:gPosZ,
	Float:gRotX,
	Float:gRotY,
	Float:gRotZ
}
new
	GoodPos[][E_GOODS_POSITION] = {	
		{ 2226, 0.083000, 	0.005000, 0.092999, 	108.999946, 179.299942, -67.700004 },
		{ 1781, -0.267000, 	0.036999, 0.105999, 	-79.099929, 4.000000, 	105.699981 },
		{ 2149, 0.093000, 	0.131999, 0.221999, 	-68.600036, -10.000000, 103.300033 }
	};
	
enum E_SAFE_BREAKING_DATA {
	sbLeft,
	sbRight,
	sbJump,
	sbLeftTop,
	sbRightTop,
	sbJumpTop,
	sbTick
}
static stock 
	SafeBreaking[MAX_PLAYERS][E_SAFE_BREAKING_DATA];

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/

// 32 bit
static stock
	PickPocketPlayer[MAX_PLAYERS],
	PickPocketCool[MAX_PLAYERS],
	PocketDialog[MAX_PLAYERS][5],
	VehicleItems[MAX_VEHICLES][5],
	DumpedGoods[MAX_DUMPED_GOODS] = { -1, ... };
	
// TDs
static stock
	PlayerText:SafeBcg1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeBcg2[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeLock1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeLock2[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeLock3[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeLeft[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeRight[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:SafeUp[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };
	
// rBits
new
	Bit8: gr_ActiveGoodSlot <MAX_PLAYERS>;
	

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/*
	.88b  d88.  .d8b.  d888888b d8b   db 
	88'YbdP88 d8' 8b   88'   888o  88 
	88  88  88 88ooo88    88    88V8o 88 
	88  88  88 88~~~88    88    88 V8o88 
	88  88  88 88   88   .88.   88  V888 
	YP  YP  YP YP   YP Y888888P VP   V8P
*/

static GetStolenGoodName(type)
{
	new
		buffer[64];
		
	switch( type ) 
	{
		case DIALOG_TYPE_WATCH:     buffer = "Watch";
		case DIALOG_TYPE_MOBILE:    buffer = "Cellphone";
		case DIALOG_TYPE_CRYPTO:    buffer = "Crypto";
		case DIALOG_TYPE_MASK:      buffer = "Mask";
		default:					buffer = "Empty";
	}
	return buffer;
}

static EmptyPlayerInventory(playerid)
{
	RobbingInfo[playerid][rbSlotsGoods][0] = 0;
	RobbingInfo[playerid][rbSlotsGoods][1] = 0;
	RobbingInfo[playerid][rbSlotsGoods][2] = 0;
	RobbingInfo[playerid][rbSlotsGoods][3] = 0;
	RobbingInfo[playerid][rbSlotsGoods][4] = 0;
}

static ListStolenGoods(playerid)
{
	new
		buffer[256],
		i = 0;
		
	while( i < 5 ) 
	{
		format( buffer, sizeof(buffer), "%s#%d %s\n",
			buffer,
			i + 1,
			GetStolenGoodName(RobbingInfo[playerid][rbSlotsGoods][i])
		);
		i++;
	}
	return buffer;
}

static CalculateGoodsMoney(playerid)
{
	new
		count = 0;
	for(new i = 0; i < 5; i++) 
	{
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_WATCH )
			count += GOOD_MONEY_WATCH;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_MOBILE )
			count += GOOD_MONEY_MOBILE;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_CRYPTO )
			count += GOOD_MONEY_CRYPTO;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_MASK )
			count += GOOD_MONEY_MASK;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_RADIO )
			count += GOOD_MONEY_RADIO;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_TV )
			count += GOOD_MONEY_TV;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_MICRO )
			count += GOOD_MONEY_MICRO;
		if(RobbingInfo[playerid][rbSlotsGoods][i] == DIALOG_TYPE_PHONE )
			count += GOOD_MONEY_PHONE;
	}
	return count;
}

static SetStolenGoodInInventory(playerid, type)
{
	new
		i = 0;
	while( i < 5 ) 
	{
		if(!RobbingInfo[playerid][rbSlotsGoods][i] ) {
			RobbingInfo[playerid][rbSlotsGoods][i] = type;
			Bit8_Set( gr_ActiveGoodSlot, playerid, i );
			break;
		}
		i++;
	}
	return 1;
}

/*
	.d8888. db   dD d888888b db      db        db 
	88'  YP 88 ,8P'   88'   88      88       o88 
	8bo.   88,8P      88    88      88        88 
	  Y8b. 888b      88    88      88        88 
	db   8D 88 88.   .88.   88booo. 88booo.   88 
	8888Y' YP   YD Y888888P Y88888P Y88888P   VP
*/

static GetPocketDialogLists(playerid, listitem)
{
	if(playerid == INVALID_PLAYER_ID ) 
		return -1;
	
	new
		type = -1,
		i = 0;
	
	while( i < 5 ) 
	{
		if(i == listitem ) 
		{
			type = PocketDialog[playerid][i];
			break;
		}
		i++;
	}
	return type;
}

static InitPlayerPocket(playerid, targetid)
{
	if(targetid == INVALID_PLAYER_ID ) 
		return 0;
	
	new
		buffer[256],
		dialogPos = 0;
		
	if(AC_GetPlayerMoney(targetid) >  50 ) {
		format( buffer, 256, "Novac (%d$)\n", AC_GetPlayerMoney(targetid));
		PocketDialog[playerid][dialogPos] = DIALOG_TYPE_MONEY;
		dialogPos++;
	}
	if(PlayerInfo[targetid][pClock] ) {
		format( buffer, 256, "%sSat\n", buffer );
		PocketDialog[playerid][dialogPos] = DIALOG_TYPE_WATCH;
		dialogPos++;
	}
	if(PlayerInfo[targetid][pMobileNumber] ) {
		format( buffer, 256, "%sMobitel\n", buffer );
		PocketDialog[playerid][dialogPos] = DIALOG_TYPE_MOBILE;
		dialogPos++;
	}
	if(PlayerInfo[targetid][pCryptoNumber] ) {
		format( buffer, 256, "%sCrypto\n", buffer );
		PocketDialog[playerid][dialogPos] = DIALOG_TYPE_CRYPTO;
		dialogPos++;
	}
	if(PlayerInfo[targetid][pMaskID] > 0 ) {
		format( buffer, 256, "%sMaska\n", buffer );
		PocketDialog[playerid][dialogPos] = DIALOG_TYPE_MASK;
		dialogPos++;
	}
	if(!strlen(buffer)) return SendClientMessage( playerid, COLOR_RED, "Odabrani gradjanin nema nista u dzepovima!");
	
	new
		caption[MAX_PLAYER_NAME + 9];
	
	format( caption, sizeof(caption), "DZEP OD %s", 
		GetName(targetid, false)
	);
	ShowPlayerDialog(playerid, DIALOG_ROB_POCKET, DIALOG_STYLE_LIST, caption, buffer, "Choose", "Abort");
	PickPocketPlayer[playerid] = targetid;
	return 1;
}

static PickPocketTargetPlayer(playerid, type)
{
	if(PickPocketPlayer[playerid] == INVALID_PLAYER_ID ) return 1;
	
	new
		targetid = PickPocketPlayer[playerid];	
	switch( type )
	 {
		case DIALOG_TYPE_MONEY:	
		{
			new
				succeed = 1 + random(5);
				
			if(succeed == 3 ) 
			{
				new
					money = 51;
				PlayerToPlayerMoney( targetid, playerid, money);
				
				new
					tmpString[108];
				format(tmpString, 108, "* %s puts his hands in %s's pocket and grabs his money.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali %d$ iz djepa!", money);
				UpgradePlayerSkill(playerid);
			}
			if(succeed == 1 || succeed == 2 || succeed == 4 || succeed == 5 ) 
			{
				new
					tmpString[114];
				format(tmpString, 114, "* %s zavlaci svoju ruku u %s djep i ne uspjeva uzeti novce iz istog.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				ProxDetector(25.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		case DIALOG_TYPE_WATCH: 
		{
			if(RobbingInfo[playerid][rbSlotsGoods][0] && RobbingInfo[playerid][rbSlotsGoods][1] && RobbingInfo[playerid][rbSlotsGoods][2] && RobbingInfo[playerid][rbSlotsGoods][3] && RobbingInfo[playerid][rbSlotsGoods][4] ) return SendClientMessage( playerid, COLOR_RED, "Vas inventory je pun!");
			
			new
				succeed = 1 + random(5);
			if(succeed == 2 || succeed == 5 ) {
				
				PlayerInfo[targetid][pClock] = 0;
				
				new
					tmpString[108];
				format(tmpString, 108, "* %s zavlaci svoju ruku u %s djep i stavlja sat u svoj djep.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali Sat iz djepa. Prodajte ju u East Los Santosu s /sellgoods!");
				UpgradePlayerSkill(playerid);
				SetStolenGoodInInventory(playerid, DIALOG_TYPE_WATCH);
			}
			if(succeed == 1 || succeed == 3 || succeed == 4 ) {
				new
					tmpString[114];
				format(tmpString, 114, "* %s zavlaci svoju ruku u %s djep i ne uspjeva uzeti sat iz istog.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				ProxDetector(25.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}		
		case DIALOG_TYPE_MOBILE: 
		{
			if(RobbingInfo[playerid][rbSlotsGoods][0] && RobbingInfo[playerid][rbSlotsGoods][1] && RobbingInfo[playerid][rbSlotsGoods][2] && RobbingInfo[playerid][rbSlotsGoods][3] && RobbingInfo[playerid][rbSlotsGoods][4] ) 
				return SendClientMessage( playerid, COLOR_RED, "Vas inventory je pun!");
			
			new
				succeed = 1 + random(5);
			if(succeed == 1 || succeed == 2 ) {
				
				PlayerInfo[targetid][pMobileNumber]		= 0;
				PlayerInfo[targetid][pMobileModel]		= 0;
				PlayerInfo[targetid][pMobileCost]		= 0;
				
				mysql_fquery(g_SQL, "DELETE FROM player_phones WHERE player_id = '%d' AND type = '1'",
					PlayerInfo[targetid][pSQLID]
				);
				ResetMobileContacts(targetid);
				Player_SetTappedBy(playerid, INVALID_PLAYER_ID);
				
				new
					tmpString[110];
				format(tmpString, 110, "* %s zavlaci svoju ruku u %s djep i stavlja mobitel u svoj djep.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali Mobitel iz djepa. Prodajte ga u East Los Santosu s /sellgoods!");
				UpgradePlayerSkill(playerid);
				SetStolenGoodInInventory(playerid, DIALOG_TYPE_MOBILE);
			}
			if(succeed == 3 || succeed == 4 || succeed == 5 ) {
				new
					tmpString[114];
				format(tmpString, 114, "* %s zavlaci svoju ruku u %s djep i ne uspjeva uzeti mobitel iz istog.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				ProxDetector(25.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}		
		case DIALOG_TYPE_CRYPTO: 
		{
			if(RobbingInfo[playerid][rbSlotsGoods][0] && RobbingInfo[playerid][rbSlotsGoods][1] && RobbingInfo[playerid][rbSlotsGoods][2] && RobbingInfo[playerid][rbSlotsGoods][3] && RobbingInfo[playerid][rbSlotsGoods][4] ) return SendClientMessage( playerid, COLOR_RED, "Vas inventory je pun!");
			
			new
				succeed = 1 + random(5);
			if(succeed == 4 || succeed == 5 ) 
			{
				PlayerInfo[targetid][pCryptoNumber]		= 0;
				
				mysql_fquery(g_SQL, "DELETE FROM player_phones WHERE player_id = '%d' AND type = '2'",
					PlayerInfo[targetid][pSQLID]
				);

				new
					tmpString[110];
				format(tmpString, 110, "* %s zavlaci svoju ruku u %s djep i stavlja crypto u svoj djep.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali Crypto iz djepa. Prodajte ju u East Los Santosu s /sellgoods!");
				UpgradePlayerSkill(playerid);
				SetStolenGoodInInventory(playerid, DIALOG_TYPE_CRYPTO);
			}
			if(succeed == 1 || succeed == 2 || succeed == 3 ) {
				new
					tmpString[114];
				format(tmpString, 114, "* %s zavlaci svoju ruku u %s djep i ne uspjeva uzeti crypto iz istog.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				ProxDetector(25.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		case DIALOG_TYPE_MASK: 
		{
			if(RobbingInfo[playerid][rbSlotsGoods][0] && RobbingInfo[playerid][rbSlotsGoods][1] && RobbingInfo[playerid][rbSlotsGoods][2] && RobbingInfo[playerid][rbSlotsGoods][3] && RobbingInfo[playerid][rbSlotsGoods][4] ) return SendClientMessage( playerid, COLOR_RED, "Vas inventory je pun!");
			
			new
				succeed = 1 + random(5);
			if(succeed == 3 || succeed == 2 ) {
				
				PlayerInfo[targetid][pMaskID]		= -1;		
				
				new
					tmpString[110];
				format(tmpString, 110, "* %s zavlaci svoju ruku u %s djep i stavlja crypto u svoj djep.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali Masku iz djepa. Prodajte ju u East Los Santosu s /sellgoods!");
				UpgradePlayerSkill(playerid);
				SetStolenGoodInInventory(playerid, DIALOG_TYPE_MASK);
			}
			if(succeed == 1 || succeed == 4 || succeed == 5 ) {
				new
					tmpString[114];
				format(tmpString, 114, "* %s zavlaci svoju ruku u %s djep i ne uspjeva uzeti crypto iz istog.", 
					GetName(playerid), 
					GetName(targetid) 
				);
				ProxDetector(25.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
	}
	PickPocketCool[playerid] = gettimestamp() + 59;
	return 1;
}
/*
	.d8888. db   dD d888888b db      db           .d888b. 
	88'  YP 88 ,8P'   88'   88      88           VP  8D 
	8bo.   88,8P      88    88      88              odD' 
	  Y8b. 888b      88    88      88            .88'   
	db   8D 88 88.   .88.   88booo. 88booo.      j88.    
	8888Y' YP   YD Y888888P Y88888P Y88888P      888888D
*/
stock static GetDumpedGoodSlot()
{
	new
		index = -1;
	for(new i = 0; i < sizeof(DumpedGoods); i++ ) {
		if(DumpedGoods[i] == -1 ) {
			index = i;
			break;
		}
	}
	return index;
}

stock static DumpStolenGood(playerid, index)
{
	new Float:X, Float:Y, Float:Z,
		model,
		indexes = GetDumpedGoodSlot();
	if(indexes == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete vise bacati stvari na pod!");
	GetPlayerPos(playerid, X, Y, Z);
	
	switch(RobbingInfo[playerid][rbSlotsGoods][index]) {
		case DIALOG_TYPE_TV: 		model = 1781;
		case DIALOG_TYPE_RADIO:    	model = 2226;
		case DIALOG_TYPE_MICRO: 	model = 2149;
	}
	if(IsObjectAttached(playerid, model)) {
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	}
	RobbingInfo[playerid][rbSlotsGoods][Bit8_Get( gr_ActiveGoodSlot, playerid)] = 0;
	ApplyAnimationEx(playerid,"CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1, 0);
	DumpedGoods[indexes] = CreateDynamicObject(model, X, Y, Z-0.85, 0.0, 0.0, 0.0, -1, -1, -1, 50.0, 50.0);
	Bit8_Set( gr_ActiveGoodSlot, playerid, 9);
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste bacili stvar na pod!");
	return 1;
}
stock static PickUpStolenGood(playerid)
{
	new 
		objectid = -1,
		type,
		Float:X, Float:Y, Float:Z;
	for(new indexes = 0; indexes < sizeof(DumpedGoods); indexes++ ) {
		if(DumpedGoods[indexes] != -1 ) {
		
			Streamer_GetFloatData(STREAMER_TYPE_OBJECT, DumpedGoods[indexes], E_STREAMER_X, X);
			Streamer_GetFloatData(STREAMER_TYPE_OBJECT, DumpedGoods[indexes], E_STREAMER_Y, Y);
			Streamer_GetFloatData(STREAMER_TYPE_OBJECT, DumpedGoods[indexes], E_STREAMER_Z, Z);
			
			if(IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z )) {
				objectid = indexes;
				break;
			}
		}
	}
	if(objectid == -1 ) return 0;
	
	switch(Streamer_GetIntData(STREAMER_TYPE_OBJECT, DumpedGoods[objectid], E_STREAMER_MODEL_ID)) {
		case 1781: type = DIALOG_TYPE_TV;
		case 2226: type = DIALOG_TYPE_RADIO;
		case 2149: type = DIALOG_TYPE_MICRO;
	}
	new
		index = type - 6;
	switch(type) {
		case DIALOG_TYPE_RADIO: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli radio! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_RADIO);
		}
		case DIALOG_TYPE_TV: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli televizor! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_TV);
		}
		case DIALOG_TYPE_MICRO: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli mikrovalnu! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_MICRO);
		}
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	
	DestroyDynamicObject(DumpedGoods[objectid]);
	DumpedGoods[objectid] = -1;
	return 1;
}

stock static PickUpVehicleStolenGood(playerid, vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID ) return 0;
	new
		slot;
	for(new i=0; i < 4; i++) {
		if(VehicleItems[vehicleid][i] ) {
			slot = i;
			break;
		}
	}
	
	ApplyAnimationEx(playerid,"GANGS","DEALER_DEAL", 4.0,0,0,0,0,0,1,0);
	new
		index = VehicleItems[vehicleid][slot] - 6;
	switch(VehicleItems[vehicleid][slot]) {
		case DIALOG_TYPE_RADIO: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli radio! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_RADIO);
		}
		case DIALOG_TYPE_TV: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli televizor! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_TV);
		}
		case DIALOG_TYPE_MICRO: {
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli mikrovalnu! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_MICRO);
		}
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	VehicleItems[vehicleid][slot] = 0;
	return 1;
}

/*
	.d8888. db   dD d888888b db      db           d8888b. 
	88'  YP 88 ,8P'   88'   88      88           VP  8D 
	8bo.   88,8P      88    88      88             oooY' 
	  Y8b. 888b      88    88      88             ~~~b. 
	db   8D 88 88.   .88.   88booo. 88booo.      db   8D 
	8888Y' YP   YD Y888888P Y88888P Y88888P      Y8888P' 
*/
stock static DestroySafeLockingTDs(playerid)
{
	if(SafeBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeBcg1[playerid]);
		SafeBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeBcg2[playerid]);
		SafeBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeText[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeText[playerid]);
		SafeText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeLock1[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeLock1[playerid]);
		SafeLock1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeLock2[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeLock2[playerid]);
		SafeLock2[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeLock3[playerid] != PlayerText:INVALID_TEXT_DRAW ) {	
		PlayerTextDrawDestroy(playerid, SafeLock3[playerid]);
		SafeLock3[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeLeft[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeLeft[playerid]);
		SafeLeft[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeRight[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeRight[playerid]);
		SafeRight[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(SafeUp[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, SafeUp[playerid]);
		SafeUp[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static ShowSafeLockingTDs(playerid)
{
	DestroySafeLockingTDs(playerid);
	SafeBcg1[playerid] = CreatePlayerTextDraw(playerid, 619.799682, 119.268188, "usebox");
	PlayerTextDrawLetterSize(playerid, SafeBcg1[playerid], 0.000000, 8.717212);
	PlayerTextDrawTextSize(playerid, SafeBcg1[playerid], 490.649993, 0.000000);
	PlayerTextDrawAlignment(playerid, SafeBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, SafeBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, SafeBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, SafeBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, SafeBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, SafeBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, SafeBcg1[playerid]);

	SafeBcg2[playerid] = CreatePlayerTextDraw(playerid, 619.950683, 118.875991, "usebox");
	PlayerTextDrawLetterSize(playerid, SafeBcg2[playerid], 0.000000, 1.395552);
	PlayerTextDrawTextSize(playerid, SafeBcg2[playerid], 491.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, SafeBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, SafeBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, SafeBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, SafeBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, SafeBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, SafeBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, SafeBcg2[playerid]);

	SafeText[playerid] = CreatePlayerTextDraw(playerid, 497.050018, 119.616035, "Provaljivanje u sef");
	PlayerTextDrawLetterSize(playerid, SafeText[playerid], 0.290149, 1.091518);
	PlayerTextDrawAlignment(playerid, SafeText[playerid], 1);
	PlayerTextDrawColor(playerid, SafeText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeText[playerid], 51);
	PlayerTextDrawFont(playerid, SafeText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SafeText[playerid], 1);
	PlayerTextDrawShow(playerid, SafeText[playerid]);

	SafeLock1[playerid] = CreatePlayerTextDraw(playerid, 524.4, 140.224060, "#1: 10");
	PlayerTextDrawLetterSize(playerid, SafeLock1[playerid], 0.4, 1.4);
	PlayerTextDrawAlignment(playerid, SafeLock1[playerid], 2);
	PlayerTextDrawColor(playerid, SafeLock1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeLock1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeLock1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeLock1[playerid], 51);
	PlayerTextDrawFont(playerid, SafeLock1[playerid], 3);
	PlayerTextDrawSetProportional(playerid, SafeLock1[playerid], 1);
	PlayerTextDrawShow(playerid, SafeLock1[playerid]);

	SafeLock2[playerid] = CreatePlayerTextDraw(playerid, 524.4, 159.319992, "#2: 10");
	PlayerTextDrawLetterSize(playerid, SafeLock2[playerid], 0.4, 1.4);
	PlayerTextDrawAlignment(playerid, SafeLock2[playerid], 2);
	PlayerTextDrawColor(playerid, SafeLock2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeLock2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeLock2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeLock2[playerid], 51);
	PlayerTextDrawFont(playerid, SafeLock2[playerid], 3);
	PlayerTextDrawSetProportional(playerid, SafeLock2[playerid], 1);
	PlayerTextDrawShow(playerid, SafeLock2[playerid]);

	SafeLock3[playerid] = CreatePlayerTextDraw(playerid, 524.4, 177.240005, "#3: 10");
	PlayerTextDrawLetterSize(playerid, SafeLock3[playerid], 0.4, 1.4);
	PlayerTextDrawAlignment(playerid, SafeLock3[playerid], 2);
	PlayerTextDrawColor(playerid, SafeLock3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeLock3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeLock3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeLock3[playerid], 51);
	PlayerTextDrawFont(playerid, SafeLock3[playerid], 3);
	PlayerTextDrawSetProportional(playerid, SafeLock3[playerid], 1);
	PlayerTextDrawShow(playerid, SafeLock3[playerid]);

	SafeLeft[playerid] = CreatePlayerTextDraw(playerid, 581.5, 143.8, "~y~(KLIKNITE ~k~~VEHICLE_TURRETLEFT~)");
	PlayerTextDrawLetterSize(playerid, SafeLeft[playerid], 0.200000, 0.9);
	PlayerTextDrawAlignment(playerid, SafeLeft[playerid], 2);
	PlayerTextDrawColor(playerid, SafeLeft[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeLeft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeLeft[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeLeft[playerid], 51);
	PlayerTextDrawFont(playerid, SafeLeft[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SafeLeft[playerid], 1);
	PlayerTextDrawShow(playerid, SafeLeft[playerid]);

	SafeRight[playerid] = CreatePlayerTextDraw(playerid, 552.9, 161.1, "~y~(KLIKNITE ~k~~VEHICLE_TURRETRIGHT~)");
	PlayerTextDrawLetterSize(playerid, SafeRight[playerid], 0.200000, 0.9);
	PlayerTextDrawAlignment(playerid, SafeRight[playerid], 1);
	PlayerTextDrawColor(playerid, SafeRight[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeRight[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeRight[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeRight[playerid], 51);
	PlayerTextDrawFont(playerid, SafeRight[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SafeRight[playerid], 1);
	PlayerTextDrawShow(playerid, SafeRight[playerid]);

	SafeUp[playerid] = CreatePlayerTextDraw(playerid, 583.2, 180.2, "~y~(KLIKNITE ~k~~PED_JUMPING~)");
	PlayerTextDrawLetterSize(playerid, SafeUp[playerid], 0.200000, 0.9);
	PlayerTextDrawAlignment(playerid, SafeUp[playerid], 2);
	PlayerTextDrawColor(playerid, SafeUp[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SafeUp[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SafeUp[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SafeUp[playerid], 51);
	PlayerTextDrawFont(playerid, SafeUp[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SafeUp[playerid], 1);
	PlayerTextDrawShow(playerid, SafeUp[playerid]);
}

stock static StartPlayerSafeBreaking(playerid)
{
	Bit1_Set( gr_SafeBreaking, playerid, true );
	TogglePlayerControllable(playerid, false);
	
	SafeBreaking[playerid][sbLeft] 	= 0;
	SafeBreaking[playerid][sbRight] = 0;
	SafeBreaking[playerid][sbJump]    = 0;
	
	SafeBreaking[playerid][sbLeftTop]	= minrand(5,95);
	SafeBreaking[playerid][sbRightTop]	= minrand(5,95);
	SafeBreaking[playerid][sbJumpTop]	= minrand(5,95);
	
	ShowSafeLockingTDs(playerid);
	new
		tmpString[16];

	format(tmpString, 16, "#1: %02d", SafeBreaking[playerid][sbLeft]);
	PlayerTextDrawSetString(playerid, SafeLock1[playerid], tmpString);
	
	format(tmpString, 16, "#2: %02d", SafeBreaking[playerid][sbRight]);
	PlayerTextDrawSetString(playerid, SafeLock2[playerid], tmpString);
	
	format(tmpString, 16, "#3: %02d", SafeBreaking[playerid][sbJump]);
	PlayerTextDrawSetString(playerid, SafeLock3[playerid], tmpString);
	return 1;
}

stock StopSafeBreaking(playerid)
{
	SafeBreaking[playerid][sbLeft] 		= 0;
	SafeBreaking[playerid][sbRight] 	= 0;
	SafeBreaking[playerid][sbJump]    	= 0;
	
	SafeBreaking[playerid][sbLeftTop]	= 0;
	SafeBreaking[playerid][sbRightTop]	= 0;
	SafeBreaking[playerid][sbJumpTop]	= 0;
	
	ClearAnimations(playerid);	
	Bit1_Set( gr_SafeBreaking, playerid, false );
	DestroySafeLockingTDs(playerid);
	TogglePlayerControllable(playerid, true);
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
hook OnPlayerConnect(playerid)
{
	PickPocketPlayer[playerid]	= INVALID_PLAYER_ID;
	PickPocketCool[playerid] 		= 0;
	PocketDialog[playerid][0] 	= 0;
	PocketDialog[playerid][1] 	= 0;
	PocketDialog[playerid][2] 	= 0;
	PocketDialog[playerid][3] 	= 0;
	PocketDialog[playerid][4] 	= 0;
	
	StopSafeBreaking(playerid);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) 
	{
		case DIALOG_ROB_POCKET: {
			if(!response ) return 1;
			if(PickPocketCool[playerid] > gettimestamp()) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete jos krasti (cooldown je 1 minutu)!");
			PickPocketTargetPlayer( playerid, GetPocketDialogLists(playerid, listitem));
			return 1;
		}
		case DIALOG_ROB_SELL: {
			if(!response ) return 1;
			if(RobbingInfo[playerid][rbSlotsGoods][0] == 0 && RobbingInfo[playerid][rbSlotsGoods][1] == 0 && RobbingInfo[playerid][rbSlotsGoods][2] == 0 && RobbingInfo[playerid][rbSlotsGoods][3] == 0 && RobbingInfo[playerid][rbSlotsGoods][4] == 0 ) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je prazan!");
			IllegalBudgetToPlayerMoney (playerid, CalculateGoodsMoney(playerid));
			if(Bit8_Get( gr_ActiveGoodSlot, playerid ) == 9 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nista u rukama!");
			new
				model;
			switch(RobbingInfo[playerid][rbSlotsGoods][Bit8_Get( gr_ActiveGoodSlot, playerid )]) {
				case DIALOG_TYPE_RADIO: model = 1781;
				case DIALOG_TYPE_TV:    model = 2226;
				case DIALOG_TYPE_MICRO: model = 2149;
			}
			if(IsObjectAttached(playerid, model)) {
				RemovePlayerAttachedObject(playerid, 9);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			}
			
			EmptyPlayerInventory(playerid);
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
CMD:stolengoods(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_BURGLAR ) return SendClientMessage( playerid, COLOR_RED, "Niste lopov!");
	if(RobbingInfo[playerid][rbSlotsGoods][0] == 0 && RobbingInfo[playerid][rbSlotsGoods][1] == 0 && RobbingInfo[playerid][rbSlotsGoods][2] == 0 && RobbingInfo[playerid][rbSlotsGoods][3] == 0 && RobbingInfo[playerid][rbSlotsGoods][4] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je prazan!");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "POPIS UKRADENE ROBE", ListStolenGoods(playerid), "OK", "");
	return 1;
}

CMD:pocketsteal(playerid, params[])
{
	new
		giveplayerid;
	if(sscanf( params, "u", giveplayerid )) 			return SendClientMessage(playerid, COLOR_RED, "[?]: /pocketsteal [dio imena/playerid]");
	if(giveplayerid == INVALID_PLAYER_ID ) 			return SendClientMessage( playerid, COLOR_RED, "Nevaljan unos playerida!");
	if(giveplayerid == playerid ) 						return SendClientMessage( playerid, COLOR_RED, "Ne mozete pljackati samog sebe!");
	if(!ProxDetectorS(2.0, playerid, giveplayerid)) 	return SendClientMessage( playerid, COLOR_RED, "Niste blizu igraca!");
	InitPlayerPocket(playerid, giveplayerid);
	return 1;
}

CMD:sellgoods(playerid, params[])
{
	if(RobbingInfo[playerid][rbSlotsGoods][0] == 0 && RobbingInfo[playerid][rbSlotsGoods][1] == 0 && RobbingInfo[playerid][rbSlotsGoods][2] == 0 && RobbingInfo[playerid][rbSlotsGoods][3] == 0 && RobbingInfo[playerid][rbSlotsGoods][4] == 0 ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je prazan!");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2562.4329, -1474.9860, 23.1000)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u East Los Santosu na mjestu gdje se prodaju ukradene stvari!");
	
	new
		tmpString[55];
	format(tmpString, sizeof(tmpString), ""COL_WHITE"Zelite li prodati robu za "COL_LIGHTBLUE"%d$"COL_WHITE"?", CalculateGoodsMoney(playerid));
	ShowPlayerDialog(playerid, DIALOG_ROB_SELL, DIALOG_STYLE_MSGBOX, "PRODAJA UKRADENE ROBE", tmpString, "Sell", "Abort");
	return 1;
}

// SKILL 2 - HOUSE
CMD:crack_alarm(playerid, params[])
{
	if(( PlayerJob[playerid][pJob] != JOB_BURGLAR ) || GetPlayerSkillLevel(playerid) < 2) 
		return SendClientMessage( playerid, COLOR_RED, "Niste lopov ili nemate dovoljan skill level!");
	new
		house = Player_InfrontHouse(playerid);
	if(!IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar house checkpointa!");
	if(house == INVALID_HOUSE_ID || house == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce!");
	if(!HouseInfo[house][hAlarm] ) return SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kuca nema alarm!");

	DestroyHouseInfoTD(playerid);
	new
		time,
		words;
		
	switch( HouseInfo[house][hAlarm] ) {
		case 0, 1: 	{ time = 300; words = 20; } // 5 minute
		case 2: 	{ time = 240; words = 16; } // 4 minute
		case 3: 	{ time = 180; words = 14; }	// 3 minute
		case 4: 	{ time = 120; words = 8;  }  // 2 minute
	}
	InitScrambling(playerid, words, time, SCRAMBLING_HOUSE);
	TogglePlayerControllable(playerid, false);
	return 1;
}

CMD:stealitems(playerid, params[])
{
	if(( PlayerJob[playerid][pJob] != JOB_BURGLAR ) || GetPlayerSkillLevel(playerid) < 2 ) 
		return SendClientMessage( playerid, COLOR_RED, "Niste lopov ili nemate dovoljan skill level!");
	new
		house = Player_InHouse(playerid);
	if(house == INVALID_HOUSE_ID || !house ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
	if(house == PlayerKeys[playerid][pHouseKey] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes svoju kucu krasti!");
	new	
		param;
	if(sscanf( params, "i", param )) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /stealitems [odabir]");
		SendClientMessage(playerid, COLOR_GREY, "[ODABIR]: 1 - Radio, 2 - TV, 3 - Mikrovalna");
		return 1;
	}
	new
		index = param - 1;
	switch(param) {
		case 1: {
			if(!HouseInfo[house][hRadio] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema radio!");
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			HouseInfo[house][hRadio] = 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali radio! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_RADIO);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			PlayerJob[playerid][pFreeWorks] 	-= 5;
			UpgradePlayerSkill(playerid);
		}
		case 2: {
			if(!HouseInfo[house][hTV] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema televizor!");
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			HouseInfo[house][hTV] = 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali televizor! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_TV);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			PlayerJob[playerid][pFreeWorks] 	-= 5;
			UpgradePlayerSkill(playerid);
		}
		case 3: {
			if(!HouseInfo[house][hMicrowave] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca nema mikrovalnu!");
			SetPlayerAttachedObject(playerid, 9, GoodPos[index][gModel], 5, GoodPos[index][gPosX], GoodPos[index][gPosY], GoodPos[index][gPosZ], GoodPos[index][gRotX], GoodPos[index][gRotY], GoodPos[index][gRotZ]);
			HouseInfo[house][hMicrowave] = 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali mikrovalnu! Idite do prodavackog mjesta za prodaju.");
			SetStolenGoodInInventory(playerid, DIALOG_TYPE_MICRO);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			PlayerJob[playerid][pFreeWorks] 	-= 5;
			UpgradePlayerSkill(playerid);
		}
	}
	return 1;
}

CMD:dropitem(playerid, params[])
{
	if(RobbingInfo[playerid][rbSlotsGoods][0] == 0 && RobbingInfo[playerid][rbSlotsGoods][1] == 0 && RobbingInfo[playerid][rbSlotsGoods][2] == 0 && RobbingInfo[playerid][rbSlotsGoods][3] == 0 && RobbingInfo[playerid][rbSlotsGoods][4] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je prazan!");
	new
		slot = Bit8_Get( gr_ActiveGoodSlot, playerid);
	if(slot == 9 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nista u rukama!");
	if(!RobbingInfo[playerid][rbSlotsGoods][slot] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nista u tome slotu, koristite /stolengoods za vise infomracija!");
	
	new
		vehicleid = GetNearestVehicle(playerid);
	if(vehicleid == INVALID_VEHICLE_ID ) {
		 // Baci na pod
		DumpStolenGood(playerid, slot);
	} 
	else { // Stavljaj u vozilo
		if(VehicleItems[vehicleid][0] && VehicleItems[vehicleid][1] && VehicleItems[vehicleid][2] && VehicleItems[vehicleid][3] ) return SendClientMessage( playerid, COLOR_RED, "Svi su slotovi puni!");
		
		if(!VehicleItems[vehicleid][0] ) {
			VehicleItems[vehicleid][0] = RobbingInfo[playerid][rbSlotsGoods][slot];
			RobbingInfo[playerid][rbSlotsGoods][slot] = 0;
		}
		else if(!VehicleItems[vehicleid][1] ) { 
			VehicleItems[vehicleid][1] = RobbingInfo[playerid][rbSlotsGoods][slot];
			RobbingInfo[playerid][rbSlotsGoods][slot] = 0;
		}
		else if(!VehicleItems[vehicleid][2] ) {
			VehicleItems[vehicleid][2] = RobbingInfo[playerid][rbSlotsGoods][slot];
			RobbingInfo[playerid][rbSlotsGoods][slot] = 0;
		}		
		else if(!VehicleItems[vehicleid][3] ) {
			VehicleItems[vehicleid][3] = RobbingInfo[playerid][rbSlotsGoods][slot];
			RobbingInfo[playerid][rbSlotsGoods][slot] = 0;
		}
		ApplyAnimationEx(playerid,"GANGS","DEALER_DEAL", 4.0,0,0,0,0,0,1,0);
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ubacili stvar u gepek!");
	}
	return 1;
}

CMD:takeitem(playerid, params[])
{
	if(RobbingInfo[playerid][rbSlotsGoods][0] != 0 && RobbingInfo[playerid][rbSlotsGoods][1] != 0 && RobbingInfo[playerid][rbSlotsGoods][2] != 0 && RobbingInfo[playerid][rbSlotsGoods][3] != 0 && RobbingInfo[playerid][rbSlotsGoods][4] != 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas inventory je pun!");
	new vehicleid = GetNearestVehicle(playerid);
	if(vehicleid == INVALID_VEHICLE_ID ) 
	{ // Uzmi s poda
		if(!PickUpStolenGood(playerid)) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu ukradene stvari!");
	} 
	else 
	{ // Uzmi iz auta
		if(!VehicleItems[vehicleid][0] && !VehicleItems[vehicleid][1] && !VehicleItems[vehicleid][2] && !VehicleItems[vehicleid][3] ) 
			return SendClientMessage( playerid, COLOR_RED, "Svi su slotovi prazni!");
		PickUpVehicleStolenGood(playerid, vehicleid);
	}	
	return 1;
}
// SKILL 3 - HOUSE MONEY
CMD:stealmoney(playerid, params[])
{
	if(( PlayerJob[playerid][pJob] != JOB_BURGLAR ) || GetPlayerSkillLevel(playerid) < 3 ) 
		return SendClientMessage( playerid, COLOR_RED, "Niste lopov ili nemate dovoljan skill level!");
	if(PlayerJob[playerid][pFreeWorks] < 1 ) 	return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise krasti (cekajte payday)!");
	new
		house = Player_InHouse(playerid);
	if(house == INVALID_HOUSE_ID || !house ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
	if(!( IsPlayerInRangeOfPoint(playerid, 15.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY],HouseInfo[house][hExitZ] ) && GetPlayerVirtualWorld( playerid ) == HouseInfo[house][hVirtualWorld] )) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu sefa za novce!");
	if(!HouseInfo[house][hTakings] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "U sefu nema novaca!");
	if(AntiSpamInfo[playerid][stHouseMoney] > gettimestamp()) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_STEAL_MONEY);
	
	new
		rand,
		stolen_money;
	if(HouseInfo[house][hMoneySafe] )
	{
		rand = random(50) + 1;
		if(rand == 4 || rand == 16 || rand == 30 || rand == 42 || rand == 23 ) {
			stolen_money = floatround(( HouseInfo[house][hTakings] ) / 3);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali %d$ iz sefa!", stolen_money);
			HouseToPlayerMoney(playerid, house, stolen_money);
			PlayerJob[playerid][pFreeWorks] 	-= 7;
			UpgradePlayerSkill(playerid);
			#if defined MODULE_LOGS
			Log_Write("/logfiles/job_burglar.txt", "(%s) Player %s(%s) stole %d$ from house safe. (Adress: %s | SQLID: %d)", 
				ReturnDate(), 
				GetName(playerid, false), 
				ReturnPlayerIP(playerid), 
				stolen_money, 
				HouseInfo[house][hAdress], 
				HouseInfo[house][hSQLID]
			);
			#endif
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste uspjeli uzeti novce iz sefa!");
	} 
	else 
	{
		rand = random(20) + 1;
		if(rand == 5 || rand == 18 || rand == 12 )
		{
			stolen_money = floatround(( HouseInfo[house][hTakings] ) / 2);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ukrali %d$ iz sefa!", stolen_money);
			HouseToPlayerMoney(playerid, house, stolen_money);
			PlayerJob[playerid][pFreeWorks] 	-= 7;
			UpgradePlayerSkill(playerid);
			AntiSpamInfo[playerid][stHouseMoney] = gettimestamp() + ANTI_SPAM_STEAL_MONEY;
			#if defined MODULE_LOGS
			Log_Write("/logfiles/job_burglar.txt", "(%s) Player %s(%s) stole %d$ from house safe. (Adress: %s | SQLID: %d)", 
				ReturnDate(), 
				GetName(playerid, false), 
				ReturnPlayerIP(playerid), 
				stolen_money, 
				HouseInfo[house][hAdress], 
				HouseInfo[house][hSQLID]
			);
			#endif
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste uspjeli uzeti novce iz sefa!");
	}
	return 1;
}
