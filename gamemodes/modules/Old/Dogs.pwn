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

// Dog System
#define BALL_OBJECT          						(1974)
#define DOG_SPEED             						(4.5)
#define BALL_DISTANCE         						(15.0)
#define BALL_SPEED            						(6.0)

#define DOG_STOP_FOLLOW_DST							(1.3)
#define DOG_FOLLOW_DST								(30.0)

#define MIN_DOG_DISTANCE   							(10)
#define MAX_DOG_DISTANCE   							(350.0)

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
enum E_PET_SHOP_DATA
{
    psModel,
	psName[ 10 ],
    psPrice
}

static stock
	PetShop[ ][ E_PET_SHOP_DATA ] = {
	 // DOG OBJECT ID    DOG NAME       DOG PRICE
		{ -2001, "Dog #1", 100 },
		{ -2002, "Dog #2", 100 },
		{ -2003, "Dog #3", 100 },
		{ -2004, "Dog #4", 100 },
		{ -2005, "Dog #5", 100 }
};

enum E_PLAYER_DOG_DATA
{
	pdSQLID,
	pdModelId,
	pdObjectId,
	pdInterior,
	pdViwo,
    Float:pdPosX,
    Float:pdPosY,
    Float:pdPosZ,
	Float:pdSpawnPosX,
	Float:pdSpawnPosY,
	Float:pdSpawnPosZ
}
static stock
	PlayerDog[MAX_PLAYERS][E_PLAYER_DOG_DATA];
	
/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// Dog Follow
static stock
	DogFollowTimer[MAX_PLAYERS],
    DogFollowPlayer[MAX_PLAYERS];

// Throwing Ball
static stock
	BallObject[MAX_PLAYERS],
	bool: dog_spot[MAX_PLAYERS] = {false, ...},
    ThrowBall[MAX_PLAYERS],
	bool: BallThrown[MAX_PLAYERS] = {false, ...};

	
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
stock LoadPlayerDog(playerid)
{
	new
		tmpQuery[128];
	format(tmpQuery, 128, "SELECT * FROM `player_dogs` WHERE `player_id` = '%d' LIMIT 0,1",
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(g_SQL, tmpQuery, "LoadingPlayerDogs", "i", playerid);
	return 1;
}

stock static PlayerBuyDog(playerid, listitem)
{
	if( AC_GetPlayerMoney(playerid) < PetShop[listitem][psPrice] ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca (%d$)!", PetShop[listitem][psPrice]);
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	GetXYInFrontOfPlayer(playerid, X, Y, 3.0);
	
	PlayerDog[playerid][pdModelId] 	= PetShop[listitem][psModel];
	PlayerDog[playerid][pdPosX] 	= X;
	PlayerDog[playerid][pdPosY] 	= Y;
	PlayerDog[playerid][pdPosZ] 	= Z + 0.5;
	PlayerDog[playerid][pdInterior]	= GetPlayerInterior(playerid);
	PlayerDog[playerid][pdViwo]		= GetPlayerVirtualWorld(playerid);
	PlayerDog[playerid][pdObjectId] = CreateDynamicObject(PlayerDog[playerid][pdModelId], PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ], 0,0,0);
	
	// MySQL
	new
		dogBuyQuery[256];
	format(dogBuyQuery, 256, "INSERT INTO `player_dogs`(`player_id`, `modelid`, `interior`, `viwo`, `spawn_x`, `spawn_y`, `spawn_z`) VALUES ('%d','%d','%d','%d','%f','%f','%f')",
		PlayerInfo[playerid][pSQLID],
		PlayerDog[playerid][pdModelId],
		PlayerDog[playerid][pdInterior],
		PlayerDog[playerid][pdViwo],
		PlayerDog[playerid][pdPosX],
		PlayerDog[playerid][pdPosY],
		PlayerDog[playerid][pdPosZ]
	);
	mysql_tquery(g_SQL, dogBuyQuery, "OnPlayerBuysDog", "i", playerid);
	
	// Streamer
	Streamer_Update(playerid);
	PlayerToBusinessMoneyTAX(playerid, 55, PetShop[listitem][psPrice]); // Biznis ID 55 dobiva novce
	SendMessage(playerid, MESSAGE_TYPE_INFO, "UspijeSno ste kupili kucnog ljubimca, za viSe opcija kucajte komandu /dog.");
	return 1;
}

/*
	 ######     ###    ##       ##       ########     ###     ######  ##    ##  ######  
	##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##  ##    ## 
	##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##   ##       
	##       ##     ## ##       ##       ########  ##     ## ##       #####     ######  
	##       ######### ##       ##       ##     ## ######### ##       ##  ##         ## 
	##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##  ##    ## 
	 ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##  ######  
*/
forward LoadingPlayerDogs(playerid);
public LoadingPlayerDogs(playerid)
{
	if(!cache_num_rows())
		return 1;
	
	// Load	
	cache_get_value_name_int(0,		"id"			, PlayerDog[playerid][pdSQLID]);
	cache_get_value_name_int(0,		"modelid"		, PlayerDog[playerid][pdModelId]);
	cache_get_value_name_int(0,		"interior"		, PlayerDog[playerid][pdInterior]);
	cache_get_value_name_int(0,		"viwo"			, PlayerDog[playerid][pdViwo]);
	cache_get_value_name_float(0, 	"spawn_x"		, PlayerDog[playerid][pdSpawnPosX]);
	cache_get_value_name_float(0, 	"spawn_y"		, PlayerDog[playerid][pdSpawnPosY]);
	cache_get_value_name_float(0, 	"spawn_z"		, PlayerDog[playerid][pdSpawnPosZ]);
	return 1;
}

forward OnPlayerBuysDog(playerid);
public OnPlayerBuysDog(playerid)
{
	PlayerDog[playerid][pdSQLID] = cache_insert_id();
	return 1;
}

forward DogStartFollowing(playerid);
public DogStartFollowing(playerid)
{
	new Float:playerDstFromDog = GetPlayerDistanceFromPoint(playerid, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]);
	if(playerDstFromDog > MAX_DOG_DISTANCE)
	{
		if(DogFollowPlayer[playerid]) 
		{
			if(GetPlayerInterior(playerid) != PlayerDog[playerid][pdInterior])
			{
				StopDynamicObject(PlayerDog[playerid][pdObjectId]);
				SetTimerEx("SetDogNextToOwner", 800, false, "i", playerid);
			}
			else
			{
				KillTimer(DogFollowTimer[playerid]);
				StopDynamicObject(PlayerDog[playerid][pdObjectId]);
				DogFollowPlayer[playerid] = 0;
				
				new Float:X, Float:Y, Float:Z;
				GetDynamicObjectPos(PlayerDog[playerid][pdObjectId], X, Y, Z);
				PlayerDog[playerid][pdPosX] = X;
				PlayerDog[playerid][pdPosY] = Y;
				PlayerDog[playerid][pdPosZ] = Z;
				
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Pas vas je prestao pratiti jer ste udaljeni vise od %1.f metara od njega!", MAX_DOG_DISTANCE);
			}
		}
		return 1;
	}
	if(playerDstFromDog >= DOG_FOLLOW_DST)
	{
		new Float:X, Float:Y, Float:Z;
		GetDynamicObjectPos(PlayerDog[playerid][pdObjectId], X, Y, Z);
		StopDynamicObject(PlayerDog[playerid][pdObjectId]);
		
		PlayerDog[playerid][pdPosX] = X;
		PlayerDog[playerid][pdPosY] = Y;
		PlayerDog[playerid][pdPosZ] = Z;
			
		GetPlayerPos(playerid, X, Y, Z);
		SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], X, Y, Z, 0.0, 270.0, 90.0);
		MoveDynamicObject(PlayerDog[playerid][pdObjectId], X, Y + DOG_STOP_FOLLOW_DST, Z, DOG_SPEED);
	}
	else
	{
		new Float:X, Float:Y, Float:Z;
		GetDynamicObjectPos(PlayerDog[playerid][pdObjectId], X, Y, Z);
		StopDynamicObject(PlayerDog[playerid][pdObjectId]);
		
		PlayerDog[playerid][pdPosX] = X;
		PlayerDog[playerid][pdPosY] = Y;
		PlayerDog[playerid][pdPosZ] = Z;
	}
	return 1;
}

forward SetDogNextToOwner(playerid);
public SetDogNextToOwner(playerid)
{
	if(!IsValidDynamicObject(PlayerDog[playerid][pdObjectId]))
		return 0;
	
	if(!DogFollowPlayer[playerid]) 
		return 0;
	
	DogFollowPlayer[playerid] = 0;
	
	// Create Object
	new Float:X, Float:Y, Float:Z, Float:zOffset;
	GetPlayerPos(playerid, X, Y, Z);
	
	if(GetPlayerInterior(playerid) == 0)
		zOffset = 0.25;
	else
		zOffset = (-0.1);
	
	PlayerDog[playerid][pdPosX] 	= X;
	PlayerDog[playerid][pdPosY] 	= Y;
	PlayerDog[playerid][pdPosZ] 	= Z + zOffset;
	PlayerDog[playerid][pdInterior] = GetPlayerInterior(playerid);
	PlayerDog[playerid][pdViwo] 	= GetPlayerVirtualWorld(playerid);
	
	DestroyDynamicObject(PlayerDog[playerid][pdObjectId]);
	PlayerDog[playerid][pdObjectId] = INVALID_OBJECT_ID;
	PlayerDog[playerid][pdObjectId] = CreateDynamicObject(PlayerDog[playerid][pdModelId], PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ], 0, 0, 0, -1, -1, -1, 100.0, 100.0);
	SendClientMessage(playerid, -1, "DEBUG: Spawnan je pas pored vas!");
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
	ThrowBall[playerid] = 1;
	DogFollowPlayer[playerid] = 0;
	
	// Enum Reset
	PlayerDog[playerid][pdSQLID]		= -1;
	PlayerDog[playerid][pdModelId]		= 0;
	PlayerDog[playerid][pdObjectId]		= INVALID_OBJECT_ID;
	PlayerDog[playerid][pdInterior]		= 0;
	PlayerDog[playerid][pdViwo]			= 0;
    PlayerDog[playerid][pdPosX]			= 0.0;
    PlayerDog[playerid][pdPosY]			= 0.0;
    PlayerDog[playerid][pdPosZ]			= 0.0;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	// Dog Destroy Object
	if(IsValidDynamicObject(PlayerDog[playerid][pdObjectId]))
	{
		DestroyDynamicObject(PlayerDog[playerid][pdObjectId]);
		PlayerDog[playerid][pdObjectId] = INVALID_OBJECT_ID;
	}
	
	if(DogFollowPlayer[playerid])
	{
		KillTimer(DogFollowTimer[playerid]);
		DogFollowPlayer[playerid] = 0;
	}
	
	if(BallThrown[playerid])
	{
		if(IsValidDynamicObject(BallObject[playerid]))
		{
			DestroyDynamicObject(BallObject[playerid]);
			BallObject[playerid] = INVALID_OBJECT_ID;
		}
		ThrowBall[playerid] = 1;
	}
	
	// Enum Reset
	PlayerDog[playerid][pdSQLID]		= -1;
	PlayerDog[playerid][pdModelId]		= 0;
	PlayerDog[playerid][pdObjectId]		= INVALID_OBJECT_ID;
	PlayerDog[playerid][pdInterior]		= 0;
	PlayerDog[playerid][pdViwo]			= 0;
    PlayerDog[playerid][pdPosX]			= 0.0;
    PlayerDog[playerid][pdPosY]			= 0.0;
    PlayerDog[playerid][pdPosZ]			= 0.0;
	return 1;
}

hook OnDynamicObjectMoved(objectid)
{
	foreach(new playerid : Player)
	{
		if(PlayerDog[playerid][pdObjectId] == objectid)
		{
			if(BallThrown[playerid] == true)
			{
				// Player
				ThrowBall[playerid] = 1;
				BallThrown[playerid] = false;

				// Object
				if(IsValidDynamicObject(BallObject[ playerid ])) 
				{
					DestroyDynamicObject(BallObject[ playerid ]);
					BallObject[ playerid ] = INVALID_OBJECT_ID;
				}
				
				new Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X, Y, Z);
				SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], X, Y, Z, 0.0, 270.0, 90.0);
				MoveDynamicObject(PlayerDog[playerid][pdObjectId], X, Y + DOG_STOP_FOLLOW_DST, Z, DOG_SPEED);
			}
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_DOG_BUY)
	{
        if(!response) return 1;
		PlayerBuyDog(playerid, listitem);
	}
	else if(dialogid == DIALOG_DOG_DELETE)
	{
		if(!response) return 1;
		PlayerDog[playerid][pdSQLID] = -1;
		PlayerDog[playerid][pdModelId] 	= 0;
		PlayerDog[playerid][pdPosX] 	= 0.0;
		PlayerDog[playerid][pdPosY] 	= 0.0;
		PlayerDog[playerid][pdPosZ] 	= 0.0;
		PlayerDog[playerid][pdInterior]	= 0;
		PlayerDog[playerid][pdViwo]		= 0;
		if(IsValidDynamicObject(PlayerDog[playerid][pdObjectId]))
		{
			DestroyDynamicObject(PlayerDog[playerid][pdObjectId]);
			PlayerDog[playerid][pdObjectId] = INVALID_OBJECT_ID;
		}
		
		// MySQL
		new
			dogDelQuery[76];
		format(dogDelQuery, 76, "DELETE FROM `player_dogs`WHERE `player_id` = '%d' AND `id` = '%d'",
			PlayerInfo[playerid][pSQLID],
			PlayerDog[playerid][pdSQLID]
		);
		mysql_tquery(g_SQL, dogDelQuery);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste obrisali svoga ljubimca!");
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid, checkpointid) {
	if(dog_spot[playerid] == true)
		return H_DisablePlayerCheckpoint(playerid);
	return (true);
}

/*
	 ######    ##     ##  ########
	##    ##   ###   ###  ##     ##
	##         #### ####  ##     ##
	##         ## ### ##  ##     ##
	##         ##     ##  ##     ##
	##    ##   ##     ##  ##     ##
	 ######    ##     ##  ########
*/
CMD:dog(playerid, params[])
{
	new option[12];
    if(sscanf(params, "s[12] ", option))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /dog [opcija].");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buy - spawn - follow - throwball, locatespot");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buyspot - sleep - whistle - delete");
		return 1;
	}

	if(strcmp(option,"spawn",true) == 0)
    {
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete psa.");
		if(IsValidDynamicObject(PlayerDog[playerid][pdObjectId])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste pozvali vaseg psa.");
		if (!IsPlayerInRangeOfPoint(playerid, 10.0, PlayerDog[playerid][pdSpawnPosX], PlayerDog[playerid][pdSpawnPosY], PlayerDog[playerid][pdSpawnPosZ]))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR,"Kako bi spawnovali psa morate biti u blizini njegovog spawn mjesta (10m).");
		
		// Create Object
		PlayerDog[playerid][pdPosX] 	= PlayerDog[playerid][pdSpawnPosX];
		PlayerDog[playerid][pdPosY] 	= PlayerDog[playerid][pdSpawnPosY];
		
		new Float:zOffset = 0.0;
		if(PlayerDog[playerid][pdInterior] == 0 && PlayerDog[playerid][pdViwo] == 0)
			zOffset = 0.25;
		else
			zOffset = (-0.1);
		
		PlayerDog[playerid][pdPosZ] 	= PlayerDog[playerid][pdSpawnPosZ] + zOffset;
		PlayerDog[playerid][pdObjectId] = CreateDynamicObject(PlayerDog[playerid][pdModelId], PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ], 0, 0, 0, -1, -1, -1, 100.0, 100.0);
		
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], X, Y, Z, 0.0, 270.0, 90.0);
		Streamer_Update(playerid);
		
    	ProxDetector(15.0, playerid, "** U daljini se cuje lavez psa.", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Vas pas je dosao kod vas.");
    }
	else if(strcmp(option,"sleep",true) == 0)
    {
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete psa.");
		if (!IsPlayerInRangeOfPoint(playerid, 10.0, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas pas nije blizu vas!");	
		if(ThrowBall[playerid] == 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno ne mozete raditi zeljenu akciju.");
			
		if(IsValidDynamicObject(PlayerDog[playerid][pdObjectId]))
		{
			DestroyDynamicObject(PlayerDog[playerid][pdObjectId]);
			PlayerDog[playerid][pdObjectId] = INVALID_OBJECT_ID;
		}
		
		// Create Object
		PlayerDog[playerid][pdPosX] 	= 0.0;
		PlayerDog[playerid][pdPosY] 	= 0.0;
		PlayerDog[playerid][pdPosZ] 	= 0.0;
		
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Vas pas je otisao spavati.");
    }
    else if(strcmp(option,"follow",true) == 0)
    {
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete kucnog ljubimca.");
		if(!IsValidDynamicObject(PlayerDog[playerid][pdObjectId])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas kucni ljubimac nije spawnan.");
		if (!IsPlayerInRangeOfPoint(playerid, 10.0, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas pas nije blizu vas!");	
		if(DogFollowPlayer[playerid]) 
		{
			KillTimer(DogFollowTimer[playerid]);
			StopDynamicObject(PlayerDog[playerid][pdObjectId]);
			DogFollowPlayer[playerid] = 0;
			
			new Float:X, Float:Y, Float:Z;
			GetDynamicObjectPos(PlayerDog[playerid][pdObjectId], X, Y, Z);
			PlayerDog[playerid][pdPosX] 	= X;
			PlayerDog[playerid][pdPosY] 	= Y;
			PlayerDog[playerid][pdPosZ] 	= Z;
			return 1;
		}
		new 
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], X, Y, Z, 0.0, 270.0, 90.0);
		MoveDynamicObject(PlayerDog[playerid][pdObjectId], X, Y + DOG_STOP_FOLLOW_DST, Z, DOG_SPEED);

		DogFollowTimer[playerid] = SetTimer("DogStartFollowing", 1000, true);
		DogFollowPlayer[playerid] = 1;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Vas pas vas krenio pratiti. Ukoliko zelite da stoji na mjestu ponovno kucajte /dog follow!");
    }
    else if(strcmp(option,"buy",true) == 0)
    {
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 859.6218,-1755.3209,1859.3334)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u Pet Shopu!");
		if( PlayerDog[playerid][pdSQLID] != -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete psa!");
		if( PlayerInfo[playerid][pLevel] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo level 3+ mogu kupovati pse!");
		
		new string[ 128 ];
		
		// Petshop menu
		format( string, 128, "Rasa\tCijena\n");
		for( new i = 0; i < sizeof(PetShop); i++ )
		{
			format( string, 128, "%s%s\t%d$\n", string, PetShop[i][psName], PetShop[i][psPrice]);
		}
		ShowPlayerDialog(playerid, DIALOG_DOG_BUY, DIALOG_STYLE_TABLIST_HEADERS, "PETSHOP - Kupovina pasa", string, "Choose", "Abort");
    }
    else if(strcmp(option,"throwball",true) == 0)
    {
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete kucnog ljubimca.");
		if(!IsValidDynamicObject(PlayerDog[playerid][pdObjectId])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas kucni ljubimac nije spawnan, ili nije u vasoj blizini.");
		if(GetPlayerDistanceFromPoint(playerid, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]) > MIN_DOG_DISTANCE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas pas nije blizu vas!");
		if(ThrowBall[playerid] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate lopticu za psa kod sebe.");
		if(DogFollowPlayer[playerid]) 
		{
			KillTimer(DogFollowTimer[playerid]);
			StopDynamicObject(PlayerDog[playerid][pdObjectId]);
			DogFollowPlayer[playerid] = 0;
			
			new Float:X, Float:Y, Float:Z;
			GetDynamicObjectPos(PlayerDog[playerid][pdObjectId], X, Y, Z);
			PlayerDog[playerid][pdPosX] 	= X;
			PlayerDog[playerid][pdPosY] 	= Y;
			PlayerDog[playerid][pdPosZ] 	= Z;
			return 1;
		}

		// Throwing Ball
		new Float:x,  Float:y, Float:z,
			Float:x2, Float:y2, Float:z2;
		   
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, 1.5);
		GetXYInFrontOfPlayer(playerid, x2, y2, BALL_DISTANCE);
		
		GetDynamicObjectPos(BallObject[playerid], x, y, z);
		MapAndreas_FindAverageZ(x2, y2, z2);

		BallObject[playerid] = CreateDynamicObject(BALL_OBJECT, x, y, z, 0,0,0);
		SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], x2, y2, z2, 0.0, 270.0, 90.0);
		MoveDynamicObject(BallObject[playerid], x2, y2, z2, BALL_SPEED);

		// Player
		ThrowBall[playerid] = 0;
		ApplyAnimationEx(playerid,"GRENADE","WEAPON_throw",4.1,0,1,1,0,1,1,0);

		// Dog Follow Ball
		MoveDynamicObject(PlayerDog[playerid][pdObjectId],x2, y2, z, 2.00);
		BallThrown[playerid] = true;
	}
	else if(!strcmp(option, "locatespot", true))
	{
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Vi ne posjedujete kucnog ljubimca.");
		
		SendMessage(playerid, MESSAGE_TYPE_INFO, "[DOG SPOT]: Locirali ste mjesto vaseg 'dog spota' na mapi.");
		dog_spot[playerid] = true;
		H_SetPlayerCheckpoint(playerid, PlayerDog[playerid][pdSpawnPosX], PlayerDog[playerid][pdSpawnPosY], PlayerDog[playerid][pdSpawnPosZ], 5.0);
	}
	else if(!strcmp(option, "buyspot", true))
	{
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete kucnog ljubimca.");
		
		// Spot
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		PlayerDog[playerid][pdSpawnPosX] = X;
		PlayerDog[playerid][pdSpawnPosY] = Y;
		PlayerDog[playerid][pdSpawnPosZ] = Z;
		PlayerDog[playerid][pdInterior]	 = GetPlayerInterior(playerid);
		PlayerDog[playerid][pdViwo]		 = GetPlayerVirtualWorld(playerid);
		
		// MySQL
		new spotQuery[256];
		format(spotQuery, 256, "UPDATE `player_dogs` SET `interior`='%d',`viwo`='%d',`spawn_x`='%f',`spawn_y`='%f',`spawn_z`='%f' WHERE `id` = '%d'",
			PlayerDog[playerid][pdInterior],
			PlayerDog[playerid][pdViwo],
			PlayerDog[playerid][pdSpawnPosX],
			PlayerDog[playerid][pdSpawnPosX],
			PlayerDog[playerid][pdSpawnPosX],
			PlayerDog[playerid][pdSQLID]
		);		
		mysql_pquery(g_SQL, spotQuery);
		
		// Player	
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili spawn point za svoga psa! Odsada ce se on spawnati tu!");
	}
	else if(!strcmp(option, "whistle", true))
	{
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete kucnog ljubimca.");
		if(!IsValidDynamicObject(PlayerDog[playerid][pdObjectId])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas kucni ljubimac nije spawnan, ili nije u vasoj blizini.");
		if(GetPlayerDistanceFromPoint(playerid, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]) > 30.0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pas vas ne cuje, morate biti u njegovoj blizini kako bi vas cuo (30 metara).");	
		new 
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		SetObjectFaceCoords3D(PlayerDog[playerid][pdObjectId], X, Y, Z, 0.0, 270.0, 90.0);
		MoveDynamicObject(PlayerDog[playerid][pdObjectId], X, Y + DOG_STOP_FOLLOW_DST, Z, DOG_SPEED);
		
		new string[64];
		format(string,sizeof(string),"** %s fucka za svojim psom.", GetName(playerid, true));
    	ProxDetector(15.0, playerid,string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if(!strcmp(option, "delete", true))
	{
		if(PlayerDog[playerid][pdSQLID] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne posjedujete kucnog ljubimca.");
		if(!IsValidDynamicObject(PlayerDog[playerid][pdObjectId])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vas kucni ljubimac nije spawnan.");
		if (!IsPlayerInRangeOfPoint(playerid, 30.0, PlayerDog[playerid][pdPosX], PlayerDog[playerid][pdPosY], PlayerDog[playerid][pdPosZ]))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pas vas ne cuje, morate biti u njegovoj blizini kako bi vas cuo (30 metara).");	
		ShowPlayerDialog(playerid, DIALOG_DOG_DELETE, DIALOG_STYLE_MSGBOX, "BRISANJE LJUBIMCA", "Zelite li obrisati svoga ljubimca?\nOn ce biti potpuno obrisano iz databaze!", "Da", "Ne");
	}
	return 1;
}
