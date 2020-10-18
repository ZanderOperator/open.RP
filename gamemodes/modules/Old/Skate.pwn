#include <YSI_Coding\y_hooks>

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
new
	Bit1: r_SkateArmed 		<MAX_PLAYERS> = { Bit1:false, ...},
	Bit1: r_SkateActive 	<MAX_PLAYERS> = { Bit1:false, ...},
	Bit16: r_SkateObjectId	<MAX_PLAYERS> = { Bit16:0, ...},
	skateBoard[ MAX_PLAYERS ] = { INVALID_OBJECT_ID, ... };

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
	Bit1_Set(r_SkateArmed, playerid, false);
	Bit1_Set(r_SkateActive, playerid, false);
	Bit16_Set(r_SkateObjectId, playerid, 0);
	
	if( IsValidDynamicObject(skateBoard[playerid]) || skateBoard[playerid] != INVALID_OBJECT_ID ) {
		DestroyDynamicObject(skateBoard[ playerid ]);
		skateBoard[ playerid ] = INVALID_OBJECT_ID;
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/*if ((newkeys & KEY_SPRINT) && (newkeys & KEY_YES)) {
		if( Bit1_Get( r_SkateActive, playerid ) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT )
			ApplyAnimation(playerid, "SKATE","skate_sprint",4.1,1,1,1,1,1,1);
	}
	else */
	if( ( newkeys & KEY_SPRINT ) ) {
		if( Bit1_Get( r_SkateActive, playerid ) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT )
			ApplyAnimation(playerid, "SKATE","skate_run",4.1,1,1,1,1,1,1);
	}
	
	if( ( oldkeys & KEY_SPRINT ) ) {
		if( Bit1_Get( r_SkateActive, playerid ) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT )
			ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
	}
	if( ( newkeys & KEY_YES ) && !(oldkeys & KEY_YES) ) {
		if( Bit1_Get( r_SkateActive, playerid ) && Bit16_Get(r_SkateObjectId, playerid) ) {
			if( IsValidDynamicObject(skateBoard[ playerid ]) ) {
				DestroyDynamicObject(skateBoard[ playerid ]);
				skateBoard[ playerid ] = INVALID_OBJECT_ID;
			}
			ClearAnimations(playerid, 1);
			ApplyAnimation(playerid, "CARRY","null",0,0,0,0,0,0,0);
			ApplyAnimation(playerid, "SKATE","null",0,0,0,0,0,0,0);
			ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
			
			SetPlayerArmedWeapon(playerid,0);
			new
				index = Bit16_Get(r_SkateObjectId, playerid);
			SetPlayerAttachedObject(playerid, index, PlayerObject[playerid][index][poModelid], PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],PlayerObject[playerid][index][poColor1],PlayerObject[playerid][index][poColor2]); 
			Bit1_Set( r_SkateArmed, playerid, true );
			Bit1_Set( r_SkateActive, playerid, false );
			Bit16_Set(r_SkateObjectId, playerid, 0);
		}
		else if( Bit1_Get( r_SkateArmed, playerid ) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT ) {
			new
				index = IsObjectAttached(playerid, 19878);
			if( index == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate prikacen objekt skejta!");
			RemovePlayerAttachedObject(playerid, index);
			
			if( IsValidDynamicObject(skateBoard[ playerid ]) ) {
				DestroyDynamicObject(skateBoard[ playerid ]);
				skateBoard[ playerid ] = INVALID_OBJECT_ID;
			}
			
			skateBoard[ playerid ] = CreateDynamicObject(19878,0,0,0,0,0,0);
			AttachDynamicObjectToPlayer(skateBoard[ playerid ], playerid, -0.1678, 0.0086, -0.95, 0.0000, 0.0000, 90.0000);
			Bit1_Set(r_SkateArmed, playerid, false);
			Bit1_Set(r_SkateActive, playerid, true);
			Bit16_Set(r_SkateObjectId, playerid, index);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sa tipkom ~k~~PED_SPRINT~ mozete voziti skejt!");
		}
	}
	return 1;
}

CMD:skate(playerid, params[])
{
	if( GetPlayerState(playerid) != PLAYER_STATE_ONFOOT ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti na nogama!");
	if( IsObjectAttached(playerid, 19878) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati prikacen skejt za sebe (/objects attach)!");
	if( !Bit1_Get( r_SkateArmed, playerid ) ) {
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Sa tipkom ~k~~CONVERSATION_YES~ mozete koristiti skejt!");
		Bit1_Set(r_SkateArmed, playerid, true );
	}
	else if( Bit1_Get( r_SkateArmed, playerid ) || Bit1_Get( r_SkateActive, playerid ) ) {
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Vise ne koristite skejt. Sa ponovnim unosom komande ga mozete opet koristiti!");
		if( IsValidDynamicObject(skateBoard[ playerid ]) ) {
			DestroyDynamicObject(skateBoard[ playerid ]);
			skateBoard[ playerid ] = INVALID_OBJECT_ID;
		}
		ClearAnimations(playerid, 1);
		ApplyAnimation(playerid, "CARRY","null",0,0,0,0,0,0,0);
		ApplyAnimation(playerid, "SKATE","null",0,0,0,0,0,0,0);
		ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
		
		SetPlayerArmedWeapon(playerid,0);
		new
			index = Bit16_Get(r_SkateObjectId, playerid);
		SetPlayerAttachedObject(playerid, index, PlayerObject[playerid][index][poModelid], PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],PlayerObject[playerid][index][poColor1],PlayerObject[playerid][index][poColor2]); 
		Bit1_Set(r_SkateArmed, playerid, false);
		Bit1_Set(r_SkateActive, playerid, false);
		Bit16_Set(r_SkateObjectId, playerid, 0);
	}
	return 1;
}