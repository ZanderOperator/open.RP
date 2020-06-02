/*-------------------------------------------------------------------------------------------------
 *	Author: 			Hodza
 *	Name: 				Sprunk.pwn
 *	Started: 			10.08.2016.
 *	Last time edited: 	22.08.2016.
 *	-----------------------------------------------------------------------------------------------
 *	Komande:
 *	- /machine: check, repair, refill, remove, steal, edit, info
 *	- /gotomachine 		(admin)
 *	- /acreatemachine 	(admin)
 *	- /refillmachines 	(admin)
 *------------------------------------------------------------------------------------------------*/
 
/*
				########  ######## ######## #### ##    ## ########  ######
				##     ## ##       ##        ##  ###   ## ##       ##    ##
				##     ## ##       ##        ##  ####  ## ##       ##
				##     ## ######   ######    ##  ## ## ## ######    ######
				##     ## ##       ##        ##  ##  #### ##             ##
				##     ## ##       ##        ##  ##   ### ##       ##    ##
				########  ######## ##       #### ##    ## ########  ######
*/
 
#include <YSI\y_hooks>

#define SPRUNK_HEALTH		(180)
#define OBJECT_SPRUNK 		(955)
#define OBJECT_SNACK 		(956)
#define OBJECT_SODA			(1302)

#define DIALOG_MACHINE_REMOVE (778) //IZMJENI
/*
						##     ##    ###    ########   ######
						##     ##   ## ##   ##     ## ##    ##
						##     ##  ##   ##  ##     ## ##
						##     ## ##     ## ########   ######
						 ##   ##  ######### ##   ##         ##
						  ## ##   ##     ## ##    ##  ##    ##
						   ###    ##     ## ##     ##  ######
*/
enum P_SPRUNK_INFO
{
	psTaken,
	psCandrink,
	psSip
}
enum E_SPRUNK_INFO
{
	spSQLID,
	spID,
	Text3D:spLabelID,
	Float:spPos[3],
	Float:spRot[3],
	spAmount,
	spWorldID,
	spIntID,
	spDestroyed,
	spMoney,
	spHealth,
	spType
}
new
	PlayerText:SprunkTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	SprunkType[MAX_PLAYERS],
	PlayerPlacedMachine[MAX_PLAYERS],
	SprunkTimer[MAX_PLAYERS],
	TempObjectID[MAX_PLAYERS],
	PlayerEditing[MAX_PLAYERS],
	SprunkSeconds[MAX_PLAYERS],
	SprunkInfo[MAX_SPRUNKS][E_SPRUNK_INFO],
	PlayerSprunkInfo[MAX_PLAYERS][P_SPRUNK_INFO];

//-------------------------------------------------------------------------------------------------

forward OnSprunkMachinesLoad();
forward OnSprunkMachineCreated(slot);
forward SetSprunkObject(playerid);
forward SprunkTimeCounter(playerid, slot);
//-------------------------------------------------------------------------------------------------
/*
				 ######  ########  #######   ######  ##    ##  ######
				##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
				##          ##    ##     ## ##       ##  ##   ##
				 ######     ##    ##     ## ##       #####     ######
					  ##    ##    ##     ## ##       ##  ##         ##
				##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
				 ######     ##     #######   ######  ##    ##  ######
*/
stock SaveSprunks()
{
	new 
		updateQuery[256];
	for(new i = 0; i < MAX_SPRUNKS; i++)
	{
		format(updateQuery, sizeof(updateQuery), "UPDATE `sprunks` SET `money` = '%i', `destroyed` = '%i', `amount` = '%i' WHERE `id` = '%i'",
			SprunkInfo[ i ] [ spMoney ],
			SprunkInfo[ i ] [ spDestroyed ],
			SprunkInfo[ i ] [ spAmount ],
			SprunkInfo[ i ] [ spSQLID ]
		);
		mysql_tquery(g_SQL, updateQuery, "", "");
	}
	return 1;
}
stock Update3dLabelPos(slot)
{
	Delete3DTextLabel(SprunkInfo[ slot ][ spLabelID ]);
	SprunkInfo[ slot ][ spLabelID ] = Create3DTextLabel("MASINA UNISTENA", 0xFF000077, SprunkInfo[ slot ][ spPos ][ 0 ], SprunkInfo[ slot ][ spPos ][ 1 ], SprunkInfo[ slot ][ spPos ][ 2 ], 25.0, SprunkInfo[ slot ][ spWorldID ]);
	return 1;
}
stock LoadSprunkMachines()
{
	mysql_tquery(g_SQL, "SELECT * FROM sprunks WHERE 1", "OnSprunkMachinesLoad");
	return 1;
}
stock GetSprunkTypeName(type)
{
	new 
		string[ 7 ];
	switch(type)
	{
		case OBJECT_SPRUNK:		format(string, 7, "Sprunk");
		case OBJECT_SNACK:		format(string, 7, "Snack");
		case OBJECT_SODA:		format(string, 7, "Soda");
	}
	return string;
}
stock GetSprunkFreeSlot()
{
	for(new i = 0; i < MAX_SPRUNKS; i++)
	{
		if(SprunkInfo[ i ] [spID] == 0 )
		{
			return i;
		}
	}
	return -1;
}
stock GetNearSprunk(playerid)
{
	for(new i = 0; i < MAX_SPRUNKS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, SprunkInfo[ i ] [ spPos ] [ 0 ], SprunkInfo[ i ] [ spPos ] [ 1 ],  SprunkInfo[ i ] [ spPos ] [ 2 ]))
			return i;
	}
	return -1;
}
stock DeleteSprunkMachine(slot)
{
	SprunkInfo[ slot ][ spPos ][ 0 ] 	= 0;
	SprunkInfo[ slot ][ spPos ][ 1 ] 	= 0;
	SprunkInfo[ slot ][ spPos ][ 2 ] 	= 0;
	SprunkInfo[ slot ][ spRot ][ 0 ] 	= 0;
	SprunkInfo[ slot ][ spRot ][ 1 ] 	= 0;
	SprunkInfo[ slot ][ spRot ][ 2 ] 	= 0;
	SprunkInfo[ slot ][ spIntID ]		= 0;
	SprunkInfo[ slot ][ spWorldID ]		= 0;
	SprunkInfo[ slot ][ spDestroyed ]	= 0;
	SprunkInfo[ slot ][ spAmount ]		= 0;
	SprunkInfo[ slot ][ spType ]		= 0;
	SprunkInfo[ slot ][ spMoney ]		= 0;
	SprunkInfo[ slot ][ spHealth ]		= 0;
	if( IsValidDynamicObject( SprunkInfo[ slot ][ spID ] ) ) {
		DestroyDynamicObject( SprunkInfo[ slot ][ spID ] );
	}
	Delete3DTextLabel(SprunkInfo[ slot ][ spLabelID ]);
	SprunkInfo[ slot ][ spID ] 			= 0;
	SprunkInfo[ slot ][ spSQLID ]		= 0;
}
stock DestroySprunkTD(playerid)
{
	if( SprunkTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, SprunkTD[playerid] );
		SprunkTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 0;	
}

stock CreateSprunkTD(playerid)
{
	DestroySprunkTD(playerid);
	SprunkTD[playerid] = CreatePlayerTextDraw(playerid, 100.0, 310.0, "                ");
    PlayerTextDrawFont(playerid, 		SprunkTD[playerid], 2);
    PlayerTextDrawLetterSize(playerid, 	SprunkTD[playerid], 0.249, 1.000000);
    PlayerTextDrawSetShadow(playerid, 	SprunkTD[playerid], 1);
	PlayerTextDrawShow(playerid, 		SprunkTD[playerid]);
	return 1;
}
public SetSprunkObject(playerid)
{
	if(PlayerSprunkInfo[ playerid ][ psTaken ] == 1)
		SetPlayerAttachedObject(playerid, 8, 1546, 5, 0.083, 0.019, 0, 15.50, 150.60, 83.7);
	else if(PlayerSprunkInfo[ playerid ][ psTaken ] == 2)
	{
		PlayerSprunkInfo[ playerid ][ psTaken ] = 0;
		return 1;
	}
	if(PlayerSprunkInfo[ playerid ][ psTaken ] == 1 && PlayerSprunkInfo[ playerid ][ psCandrink ] == 0)
		PlayerSprunkInfo[ playerid ][ psCandrink ] = 1;
	if(PlayerSprunkInfo[ playerid ][ psTaken ] == 1 && PlayerSprunkInfo[ playerid ][ psSip ] > 6)
	{
		RemovePlayerAttachedObject(playerid, 8);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		PlayerSprunkInfo[ playerid ][ psTaken ] = 0;
	}
	return 1;
}
public SprunkTimeCounter(playerid, slot)
{
	if( IsPlayerInAnyVehicle(playerid)) 
	{
		DestroySprunkTD(playerid);
		KillTimer(SprunkTimer[playerid]);
		SprunkTimer[playerid] = -1;
		
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste smjeli bit u vozilu dok popravljate sprunk masinu!");
		return 1;
	}
	if(!IsPlayerInRangeOfPoint(playerid, 8, SprunkInfo[slot][spPos][0], SprunkInfo[slot][spPos][1], SprunkInfo[slot][spPos][2]))
	{
		DestroySprunkTD(playerid);
		KillTimer(SprunkTimer[playerid]);
		
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Otisli ste predaleko od sprunk masine!");
		return 1;
	}
	if(SprunkSeconds[playerid] > 0)
	{
		new
			tmpSecs[ 79 ];
		format(tmpSecs, sizeof(tmpSecs), "~w~Sprunk usluga popravljanja u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d", SprunkSeconds[playerid]-1);
		PlayerTextDrawSetString( playerid, SprunkTD[playerid], tmpSecs );
		PlayerPlaySound( playerid, 		1056, 0.0, 0.0, 0.0 );
		SprunkSeconds[playerid]--;
		return 1;
	}
	else
	{
		new payout = random(25) + 40,
			string[64];
		DestroySprunkTD(playerid);
		KillTimer(SprunkTimer[playerid]);
		switch(SprunkType[playerid])
		{
			case 1:
			{
				SprunkInfo[slot][spDestroyed] = 0;
				Delete3DTextLabel(SprunkInfo[ slot ][ spLabelID ]);
				format(string,sizeof(string),"Uspjesno ste popravili sprunk masinu i zaradili %d$.", payout);
				SendClientMessage(playerid, COLOR_GREEN,string);
				PlayerInfo[ playerid ][ pFreeWorks ] -=2;
				PlayerInfo[playerid][pPayDayMoney] += payout;
			}
			case 2:
			{
				SprunkInfo[slot][spAmount] = 20;
				format(string,sizeof(string),"Uspjesno ste napunili sprunk masinu i zaradili %d$.", payout);
				SendClientMessage(playerid, COLOR_GREEN,string);
				PlayerInfo[ playerid ][ pFreeWorks ] -=2;
				PlayerInfo[playerid][pPayDayMoney] += payout;
			}
		}
		return 1;
	}
}
public OnSprunkMachineCreated(slot)
{
	SprunkInfo[ slot ][ spSQLID ] = cache_insert_id();
}
public OnSprunkMachinesLoad()
{
	if( !cache_num_rows() ) return printf( "MySQL Report: No sprunk machines exist to load.");
	for( new s=0; s < cache_num_rows(); s++ ) 
	{
		cache_get_value_name_int( s, "id", SprunkInfo[ s ][ spSQLID ]);
		cache_get_value_name_float( s, "posX", SprunkInfo[ s ][ spPos ][ 0 ]);
		cache_get_value_name_float( s, "posY", SprunkInfo[ s ][ spPos ][ 1 ]);
		cache_get_value_name_float( s, "posZ", SprunkInfo[ s ][ spPos ][ 2 ]);
		cache_get_value_name_float( s, "rotX", SprunkInfo[ s ][ spRot ][ 0 ]);
		cache_get_value_name_float( s, "rotY", SprunkInfo[ s ][ spRot ][ 1 ]);
		cache_get_value_name_float( s, "rotZ", SprunkInfo[ s ][ spRot ][ 2 ]);
		cache_get_value_name_int( s, "amount", SprunkInfo[ s ][ spAmount ]);
		cache_get_value_name_int( s, "destroyed", SprunkInfo[ s ][ spDestroyed ]);
		cache_get_value_name_int( s, "worldID", SprunkInfo[ s ][ spWorldID ]);
		cache_get_value_name_int( s, "intID", SprunkInfo[ s ][ spIntID ]);
		cache_get_value_name_int( s, "money", SprunkInfo[ s ][ spMoney ]);
		cache_get_value_name_int( s, "type", SprunkInfo[ s ][ spType ]);
			
		SprunkInfo[ s ][ spID ] 					= CreateDynamicObject( SprunkInfo[ s ] [ spType], SprunkInfo[ s ][ spPos ][ 0 ], SprunkInfo[ s ][ spPos ][ 1 ], SprunkInfo[ s ][ spPos ][ 2 ], SprunkInfo[ s ][ spRot ][ 0 ], SprunkInfo[ s ][ spRot ][ 1 ], SprunkInfo[ s ][ spRot ][ 2 ], SprunkInfo[ s ][ spWorldID ], SprunkInfo[ s ][ spIntID], -1, 150.0, 100 ); 
		
		if(!SprunkInfo[ s ][ spDestroyed ])
			SprunkInfo[ s ][ spHealth ]	=	SPRUNK_HEALTH;
		else
			SprunkInfo[ s ][ spLabelID ]	=	Create3DTextLabel("MASINA UNISTENA", 0xFF000077, SprunkInfo[ s ][ spPos ][ 0 ], SprunkInfo[ s ][ spPos ][ 1 ], SprunkInfo[ s ][ spPos ][ 2 ], 25.0, SprunkInfo[ s ][ spWorldID ]);
		Iter_Add(Sprunks, s);
	}
	printf("MySQL Report: Sprunk machines Loaded (%d)!", Iter_Count(Sprunks));
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
hook OnPlayerDisconnect(playerid, reason)
{
	if(SprunkSeconds[playerid] != 0)
	{	
		KillTimer(SprunkTimer[playerid]);
		
		// Player vars clearing
		SprunkType[playerid] 			= 0;
		PlayerPlacedMachine[playerid] 	= 0;
		TempObjectID[playerid] 			= -1;
		PlayerEditing[playerid] 		= 0;
		SprunkSeconds[playerid] 		= 0;
		
		// Clear Enum
		PlayerSprunkInfo[playerid][psTaken] 	= 0;
		PlayerSprunkInfo[playerid][psCandrink] 	= 0;
		PlayerSprunkInfo[playerid][psSip] 		= 0;
		
		// Destroy TDs
		DestroySprunkTD(playerid);
	}
	return 1;
}

public OnPlayerShootDynamicObject(playerid, weaponid, STREAMER_TAG_OBJECT objectid, Float:x, Float:y, Float:z)
{
	if(IsValidDynamicObject(objectid)) 
	{
		new
			slot;
		for(new i = 0; i < MAX_SPRUNKS; i++)
		{
			if(SprunkInfo[ i ][ spID ] == objectid)
			{
				objectid = SprunkInfo[ i ][ spID ];
				slot = i;
				break;
			}
		}
		if(objectid == 0) return 1;
		new 
			weapDMG,
			weapID = GetPlayerWeapon(playerid);
		if(SprunkInfo[ slot ][ spDestroyed ] == 0)
		{
			switch(weapID)
			{
				case 22, 23:				{	weapDMG = 12;	}
				case 28, 29, 32:			{	weapDMG = 7;	}
				case 24, 25, 27, 33:		{	weapDMG = 28;	}
				case 30, 31:				{	weapDMG = 15;	}
				default:					{	weapDMG = 0;	}
			}	
			if(SprunkInfo[ slot ][ spHealth ] >= 0) 
			{
				SprunkInfo[ slot ][ spHealth ] -= (random(4) + weapDMG);
			}
			if(SprunkInfo[ slot ][ spHealth ] <= 0) 
			{
				CreateExplosion(SprunkInfo[ slot ][ spPos ][ 0 ], SprunkInfo[ slot ][ spPos ][ 1 ], SprunkInfo[ slot ][ spPos ][ 2 ], 13, 10.0); 
				new 
					str[64];
				format(str, sizeof(str), "~r~%s masina unistena.", GetSprunkTypeName(SprunkInfo[slot][spType]));
				GameTextForPlayer(playerid, str, 1800, 3);
				SprunkInfo[ slot ][ spDestroyed ] = 1;
				SprunkInfo[ slot ][ spLabelID ]	=	Create3DTextLabel("MASINA UNISTENA", 0xFF000077, SprunkInfo[ slot ][ spPos ][ 0 ], SprunkInfo[ slot ][ spPos ][ 1 ], SprunkInfo[ slot ][ spPos ][ 2 ], 25.0, SprunkInfo[ slot ][ spWorldID ]);
			}
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
	{
		if(PlayerSprunkInfo[ playerid ][ psTaken ])
		{
			RemovePlayerAttachedObject(playerid, 8);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			PlayerSprunkInfo[ playerid ][ psTaken ] = 0;
			return 1;
		}
		if(GetNearSprunk(playerid) != -1)
		{
			new
				slot = GetNearSprunk(playerid);
			if(PlayerSprunkInfo[ playerid ][ psTaken ] || SprunkInfo[ slot ][ spDestroyed ] == 1) return 1;
			if(SprunkInfo[ slot ][ spAmount ] < 1)
			{
				new 
					str[64];
				format(str, sizeof(str), "~r~ masina nema produkata.");
				GameTextForPlayer(playerid, str, 2500, 3);
				return 1;
			}
			if( SprunkInfo[ slot ][ spType ] == OBJECT_SPRUNK || SprunkInfo[ slot ][ spType ] == OBJECT_SODA )
			{
				
				ApplyAnimation(playerid,"VENDING","VEND_Use",1.4,0 ,1,1,0,2600,1); 
				ApplyAnimation(playerid,"VENDING","VEND_Use",1.4,0 ,1,1,0,2600,1);
				PlayerToBudgetMoney(playerid, 2);
				SprunkInfo[ slot ][ spMoney ] += 2;
				SprunkInfo[ slot ][ spAmount ]--;
				GameTextForPlayer(playerid, "Nice drinking", 700, 1);
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Da koristis pice pritisni 'Y', za bacanje 'F'.");
				PlayerSprunkInfo[ playerid ][ psTaken ] = 1;
				PlayerSprunkInfo[ playerid ][ psCandrink ] = 1;
				PlayerSprunkInfo[ playerid ][ psSip ] = 0;	
				SetTimerEx("SetSprunkObject", 2600, false, "i", playerid);
			}
			else
			{
				if(PlayerSprunkInfo[ playerid ][ psTaken ] == 2) return 1;
				ApplyAnimation(playerid,"VENDING","vend_eat1_P",1.4,0 ,1,1,0,1900,1);
				PlayerToBudgetMoney(playerid, 2);
				SprunkInfo[ slot ][ spMoney ]  += 2;
				SprunkInfo[ slot ][ spAmount ]--;
				GameTextForPlayer(playerid, "Bon apetit", 700, 1);
				new 
					Float:H;
				GetPlayerHealth(playerid, H);
				SetPlayerHealth(playerid, H+1.5);
				PlayerSprunkInfo[ playerid ][ psTaken ] = 2;
				SetTimerEx("SetSprunkObject", 2000, false, "i", playerid);
			}
		}
	}
	if ((newkeys & KEY_YES) && !(oldkeys & KEY_YES))
	{
		if(PlayerSprunkInfo[ playerid ][ psTaken] && PlayerSprunkInfo[ playerid ][ psCandrink ])
		{

				new 
					Float:H;
				GetPlayerHealth(playerid, H);
				SetPlayerHealth(playerid, H+2);
				ApplyAnimation(playerid,"VENDING","VEND_Drink2_P",1.4,0 ,1,1,0,1900,1);
				ApplyAnimation(playerid,"VENDING","VEND_Drink2_P",1.4,0 ,1,1,0,1900,1);
				PlayerSprunkInfo[ playerid ][ psSip ]++;
				PlayerSprunkInfo[ playerid ][ psCandrink ] = 0;
				SetTimerEx("SetSprunkObject", 1900, false, "i", playerid);
		}
	}
	return 1;
}
hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if( TempObjectID[playerid] != -1 && PlayerPlacedMachine[playerid] == 1 )
	{
		new
  			slot = TempObjectID[playerid];
		switch(response)
		{
			case EDIT_RESPONSE_FINAL:
			{
				
				SprunkInfo[ slot ][ spPos ][ 0 ] = x;
				SprunkInfo[ slot ][ spPos ][ 1 ] = y;
				SprunkInfo[ slot ][ spPos ][ 2 ] = z;
				SprunkInfo[ slot ][ spRot ][ 0 ] = rx;
				SprunkInfo[ slot ][ spRot ][ 1 ] = ry;
				SprunkInfo[ slot ][ spRot ][ 2 ] = rz;


				SetDynamicObjectPos(SprunkInfo[ slot ][ spID ],
									SprunkInfo[ slot ][ spPos ][ 0 ],
									SprunkInfo[ slot ][ spPos ][ 1 ],
									SprunkInfo[ slot ][ spPos ][ 2 ]);
				SetDynamicObjectRot(SprunkInfo[ slot ][ spID ],
									SprunkInfo[ slot ][ spRot ][ 0 ],
									SprunkInfo[ slot ][ spRot ][ 1 ],
									SprunkInfo[ slot ][ spRot ][ 2 ]);

				TempObjectID[playerid] = -1;
				PlayerPlacedMachine[playerid] = 0;
				if(!PlayerEditing[playerid])
				{
					va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste postavili %s masinu(ID"COL_WHITE"%i"COL_GREEN").",GetSprunkTypeName(SprunkInfo[ slot ] [spType]), slot);
					if(SprunkInfo[ slot ][ spDestroyed ] == 1)
						SprunkInfo[ slot ][ spLabelID ] = Create3DTextLabel("MASINA UNISTENA", 0xFF000077, SprunkInfo[ slot ][ spPos ][ 0 ], SprunkInfo[ slot ][ spPos ][ 1 ], SprunkInfo[ slot ][ spPos ][ 2 ], 25.0, SprunkInfo[ slot ][ spWorldID ]);
					new
						tmpQuery[512];
					format(tmpQuery,sizeof(tmpQuery),"INSERT INTO sprunks  (`posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `destroyed`, `amount`, `money`, `worldID`, `intID`, `type`) VALUES ('%f', '%f', '%f', '%f', '%f', '%f', '%i', '%i', '%i', '%i', '%i', '%i')",
					SprunkInfo[ slot ][ spPos ][ 0 ],
					SprunkInfo[ slot ][ spPos ][ 1 ],
					SprunkInfo[ slot ][ spPos ][ 2 ],	
					SprunkInfo[ slot ][ spRot ][ 0 ],
					SprunkInfo[ slot ][ spRot ][ 1 ],
					SprunkInfo[ slot ][ spRot ][ 2 ],
					SprunkInfo[ slot ][ spDestroyed ],
					SprunkInfo[ slot ][ spAmount ],
					SprunkInfo[ slot ][ spMoney ],
					SprunkInfo[ slot ][ spWorldID ],
					SprunkInfo[ slot ][ spIntID ],
					SprunkInfo[ slot ][ spType ]
					);
					mysql_tquery(g_SQL, tmpQuery, "OnSprunkMachineCreated", "i", slot);
				}	
				else
				{
					va_SendClientMessage(playerid, COLOR_RED, "Uspjesno ste izmjenili %s masinu(ID"COL_WHITE"%i"COL_GREEN").",GetSprunkTypeName(SprunkInfo[ slot ] [spType]), slot);
					if(SprunkInfo[ slot ][ spDestroyed ] == 1)
						Update3dLabelPos(slot);
					new
						tmpQuery[256];
					format(tmpQuery,sizeof(tmpQuery), "UPDATE `sprunks` SET `posX` = '%f', `posY` = '%f', `posZ` = '%f', `rotX` = '%f', `rotY` = '%f', `rotZ` = '%f' WHERE `id` = '%i'", 
					SprunkInfo[ slot ][ spPos ][ 0 ],
					SprunkInfo[ slot ][ spPos ][ 1 ],
					SprunkInfo[ slot ][ spPos ][ 2 ],
					SprunkInfo[ slot ][ spRot ][ 0 ],
					SprunkInfo[ slot ][ spRot ][ 1 ],
					SprunkInfo[ slot ][ spRot ][ 2 ],
					SprunkInfo[ slot ][ spSQLID]
					);
					mysql_tquery(g_SQL, tmpQuery, "", "");
					
					PlayerEditing[playerid] = 0;
				}
				return 1;
			}
			case EDIT_RESPONSE_CANCEL:
			{
				if(!PlayerEditing[playerid])
					DeleteSprunkMachine(slot);
				else
				{
					SetDynamicObjectPos(SprunkInfo[ slot ][ spID ],
										SprunkInfo[ slot ][ spPos ][ 0 ],
										SprunkInfo[ slot ][ spPos ][ 1 ],
										SprunkInfo[ slot ][ spPos ][ 2 ]);
					SetDynamicObjectRot(SprunkInfo[ slot ][ spID ],
										SprunkInfo[ slot ][ spRot ][ 0 ],
										SprunkInfo[ slot ][ spRot ][ 1 ],
										SprunkInfo[ slot ][ spRot ][ 2 ]);
				}
				TempObjectID[playerid] = -1;
				PlayerPlacedMachine[playerid] = 0;
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Odustali ste od postavljanja masine.");
				return 1;
			}
		}
 	}
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_MACHINE_REMOVE:
		{
			if(!response)
			{
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Odustali ste od brisanja masine.");
				return 1;
			}
			else
			{
				new
					deleteQuery[128],
					slot = TempObjectID[playerid];
				format(deleteQuery, sizeof(deleteQuery), "DELETE FROM `sprunks` WHERE `id` = '%i'", SprunkInfo[ slot ][spSQLID]);
				mysql_tquery(g_SQL, deleteQuery, "", "");
				DeleteSprunkMachine(slot);
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste obrisali masinu iz baze podataka.");
				TempObjectID[playerid] = -1;
			}
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
CMD:machine(playerid, params[])
{
	new
		param[10];
	if(sscanf(params, "s[10]", param))
	{	
		SendClientMessage(playerid, COLOR_RED, "USAGE: /machine [pick]");
		SendClientMessage(playerid, COLOR_ORANGE, "PICK(admin): edit, remove, check");
		SendClientMessage(playerid, COLOR_GREY, "PICK: refill, repair, steal");
		return 1;
	}
	if( !strcmp(param, "edit", true) )
	{
		if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
		new
			obj = GetNearSprunk(playerid);
		if(obj < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
		EditDynamicObject(playerid, SprunkInfo[ GetNearSprunk(playerid) ] [ spID ]);
		PlayerEditing[playerid] = 1;
		TempObjectID[playerid] =  obj;
		PlayerPlacedMachine[playerid] = 1;
	}
	else if( !strcmp(param, "check", true) )
	{
		if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
		if(GetNearSprunk(playerid) != -1)
		{
			new 
				slot = GetNearSprunk(playerid);
			SendClientMessage(playerid, -1, "********************MACHINE INFO********************");
			va_SendClientMessage(playerid, COLOR_GREY, "SQLID     - "COL_WHITE"%i", SprunkInfo[ slot ] [spSQLID]);
			va_SendClientMessage(playerid, COLOR_GREY, "ID             - "COL_WHITE"%i", SprunkInfo[ slot ] [spID]);
			va_SendClientMessage(playerid, COLOR_GREY, "Unisten   - "COL_WHITE"%i", SprunkInfo[ slot ] [spDestroyed]);
			va_SendClientMessage(playerid, COLOR_GREY, "Produkti  - "COL_WHITE"%i", SprunkInfo[ slot ] [spAmount]);
			va_SendClientMessage(playerid, COLOR_GREY, "Vrsta         - "COL_WHITE"%s", GetSprunkTypeName(SprunkInfo[ slot ] [spType]));
			va_SendClientMessage(playerid, COLOR_GREY, "Novac         - "COL_WHITE"%i", SprunkInfo[ slot ] [spMoney]);
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
	}
	else if( !strcmp(param, "remove", true) )
	{
		if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
		if(GetNearSprunk(playerid) != -1)
		{
			new 
				string[128],
				slot = GetNearSprunk(playerid);
			format(string, sizeof(string), "*"COL_WHITE"Jeste li sigurni da zelite izbrisati masinu ID"COL_YELLOW"%i"COL_WHITE", Type "COL_YELLOW"%s"COL_WHITE".", slot, GetSprunkTypeName(SprunkInfo[ slot ][ spType]));
			ShowPlayerDialog(playerid, DIALOG_MACHINE_REMOVE, DIALOG_STYLE_MSGBOX,"Confirm", string, "Confirm", "Cancel");
			TempObjectID[playerid] = slot;			
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
	}
	else if( !strcmp(param, "steal", true) )
	{
		new 
			slot = GetNearSprunk(playerid);
		if(slot != -1)
		{
			if(SprunkInfo[ slot ][ spDestroyed] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova masina nije unistena/razvaljena.");
			if(SprunkInfo[ slot ][ spMoney ] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nema kovanica u ovoj masini.");
			AC_GivePlayerMoney(playerid, SprunkInfo[ slot ][ spMoney ]);
			SprunkInfo[ slot ][ spMoney ] = 0;
			new
				string[64];
			format(string, sizeof(string),"** %s uzima kovanice iz masine.", GetName(playerid, true));
			ProxDetector(10.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
	}
	else if( !strcmp(param, "repair", true) )
	{
		if(PlayerInfo[playerid][pJob] != 15) return SendClientMessage(playerid,COLOR_RED, "ERROR: Niste zaposleni kao kamiondzija.");
		if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "ERROR: Ne mozes vise raditi!");
		new 
			slot = GetNearSprunk(playerid);
		if(slot != -1)
		{
			if(SprunkInfo[ slot ][ spDestroyed] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova masina nije unistena/razvaljena.");
			new
				string[83];
			format(string, sizeof(string),"** %s uzima svoj alat te pocinje popravljat masinu.", GetName(playerid, true));
			ProxDetector(10.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			CreateSprunkTD(playerid);
			PlayerTextDrawSetString(playerid, 	SprunkTD[playerid], "~w~Sprunk usluga popravljanja u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~60");
			SprunkTimer[playerid] = SetTimerEx("SprunkTimeCounter", 1000, true, "ii", playerid, slot);
			SprunkSeconds[playerid] = 60;
			SprunkType[playerid]	= 1;
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
	}
	else if( !strcmp(param, "refill", true) )
	{
		if(PlayerInfo[playerid][pJob] != 15) return SendClientMessage(playerid,COLOR_RED, "ERROR: Niste zaposleni kao kamiondzija.");
		if( PlayerInfo[ playerid ][ pFreeWorks ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "ERROR: Ne mozes vise raditi!");
		new 
			slot = GetNearSprunk(playerid);
		if(slot != -1)
		{
			if(SprunkInfo[ slot ][ spAmount] > 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova masina nije ispraznjena");
			new
				string[83];
			format(string, sizeof(string),"** %s pocinje sa procesom punjenja sprunk masine.", GetName(playerid, true));
			ProxDetector(10.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			CreateSprunkTD(playerid);
			PlayerTextDrawSetString(playerid, 	SprunkTD[playerid], "~w~Sprunk usluga popravljanja u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~60");
			SprunkTimer[playerid] 	= SetTimerEx("SprunkTimeCounter", 1000, true, "ii", playerid, slot);
			SprunkSeconds[playerid] = 60;
			SprunkType[playerid]	= 2;
		}
		else
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se blizu masine.");
	}
	return 1;
}
CMD:acreatemachine(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande.");
	new 
		destroyed,
		amount,
		type;
	if(sscanf(params,"iii", destroyed, amount, type)){
		SendClientMessage(playerid, COLOR_RED, "USAGE: /acreatemachine [destroyed] [amount] [type]");
		SendClientMessage(playerid, COLOR_GREY,"Type: 0  - SPRUNK");
		SendClientMessage(playerid, COLOR_GREY,"Type: 1  - SNACK");
		SendClientMessage(playerid, COLOR_GREY,"Type: 2  - SODA");
		return 1;
	}
	if(amount < 0 || amount > 20) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kolicina ne smije biti manja od 0 i veca od 20!");
	if(destroyed < 0 || destroyed > 1) return SendClientMessage(playerid, COLOR_RED, "[KORISTENJE] 'destroyed' 1 - unisten | 0 - nije unisten.");
	if(type < 0 || type > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Tip masine ne moze biti ispod 0 i veci od 3!");
	switch(type)
	{
		case 0:{	type = OBJECT_SPRUNK;	}
		case 1:{	type = OBJECT_SNACK;	}
		case 2:{	type = OBJECT_SODA;		}
	}
	new 
		slot,
		Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	slot = GetSprunkFreeSlot();
	if(slot == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nema vise slobodnih slotova za masine");
	SprunkInfo[ slot ] [ spWorldID ] = GetPlayerVirtualWorld(playerid);
	SprunkInfo[ slot ] [ spIntID ]  = GetPlayerInterior(playerid);
	SprunkInfo[ slot ] [ spType ] = type;
	SprunkInfo[ slot ] [ spID ] = CreateDynamicObject(SprunkInfo[ slot ] [ spType], pos[0], pos[1]+2, pos[2], 0, 0, 0, SprunkInfo[ slot ] [ spWorldID ], SprunkInfo[ slot ] [ spIntID ], -1, 150, 100);
	SprunkInfo[ slot ] [ spDestroyed ] = destroyed;
	SprunkInfo[ slot ] [ spAmount ]    = amount;
	SprunkInfo[	slot ] [ spHealth ] = SPRUNK_HEALTH;
	EditDynamicObject(playerid, SprunkInfo[ slot ] [ spID ]);
	TempObjectID[playerid] =  slot;
	PlayerPlacedMachine[playerid] = 1;
	return 1;
}
CMD:gotomachine(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande!");
	new
		slot;
	if(sscanf(params,"i",slot)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /gotomachine [id]");
	if(slot < 0 || slot > 100) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevazeci slot sprunk masine.");
	if(SprunkInfo[slot][spID] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj slot nema sprunk masinu.");
	SetPlayerPos(playerid, SprunkInfo[slot][spPos][0], SprunkInfo[slot][spPos][1]+1, SprunkInfo[slot][spPos][2]+0.2 );
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Teleportiran si do masine(ID "COL_WHITE"%i"COL_GREEN").", slot);

	return 1;
}
CMD:refillmachines(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "ERROR: Niste ovlasteni za koristenje ove komande!");
	
	for(new i = 0; i < MAX_SPRUNKS; i++)
	{
		SprunkInfo[ i ][ spDestroyed ]		= 0;
		SprunkInfo[ i ][ spAmount ]			= 20;
		SprunkInfo[ i ][ spHealth ]			= SPRUNK_HEALTH;
		Delete3DTextLabel(SprunkInfo[ i ][ spLabelID ]);
	}
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si popravio i refillovao sve sprunk masine.");
	return 1;
}
