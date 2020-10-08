/* 
*	 	Inventory & Item System
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI\y_hooks>

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (enumerator)

enum e_inventory_data {
	invExists,
	invID,
	invType,
	invItem[32],
	invModel,
	invQuantity
};
new inventory_data[MAX_PLAYERS][MAX_INVENTORY_SLOTS][e_inventory_data];


enum e_dropped_items {
	//invdrop_ID,
	invdrop_Item[32],
	invdrop_Owner[24],
	invdrop_Type,
	invdrop_Model,
	invdrop_Quantity,
	Float:invdrop_Pos[3],
	invdrop_Int,
	invdrop_World,
	invdrop_ObjectID,
	Text3D:invdrop_Text3D
};

new inventory_items[MAX_INV_DROPPED_ITEMS][e_dropped_items];
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (vars & iters)
new 
	inventory_itemID[MAX_PLAYERS] 		= (INVALID_PLAYER_ID),
	inventory_GetGiveID[MAX_PLAYERS] 	= (INVALID_PLAYER_ID);
	
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (load & save)
/*Load_InventoryDrop() {
	mysql_tquery(g_SQL, "SELECT * FROM `inventory_dropitem`", "Load_InvDrop", "");
	return (true);
}

Function: Load_InvDrop() {
	new 
		rows = cache_num_rows(), counter = 0, buffer[64];
	if(rows == 0) return (true);
	
	for (new i = 0; i < rows; i++)
	{	
		cache_get_value_name_int(i, "ID",inventory_items[i][invdrop_ID]);
		cache_get_value_name(i, "itemName",  inventory_items[i][invdrop_Item]);
		cache_get_value_name(i, "itemPlayer",  inventory_items[i][invdrop_Owner]);
		
		cache_get_value_name_int(i, "itemModel",inventory_items[i][invdrop_Model]);
		cache_get_value_name_int(i, "itemQuantity",inventory_items[i][invdrop_Quantity]);
		cache_get_value_name_int(i, "itemInt",inventory_items[i][invdrop_Int]);
		cache_get_value_name_int(i, "itemWorld",inventory_items[i][invdrop_World]);
		cache_get_value_name_int(i, "itemType",inventory_items[i][invdrop_Type]);
		
		cache_get_value_name_float(i, "itemX", inventory_items[i][invdrop_Pos][0]);
		cache_get_value_name_float(i, "itemY", inventory_items[i][invdrop_Pos][1]);
		cache_get_value_name_float(i, "itemZ", inventory_items[i][invdrop_Pos][2]);
		
		format(buffer, sizeof(buffer), "{C3C3C3}[ %s ]\n'Y'", inventory_items[i][invdrop_Item]);
		inventory_items[i][invdrop_ObjectID] = CreateDynamicObject(inventory_items[i][invdrop_Model], inventory_items[i][invdrop_Pos][0], inventory_items[i][invdrop_Pos][1], inventory_items[i][invdrop_Pos][2], 0.0, 0.0, 0.0, inventory_items[i][invdrop_World], inventory_items[i][invdrop_Int]);
		inventory_items[i][invdrop_Text3D] = CreateDynamic3DTextLabel(buffer, -1, inventory_items[i][invdrop_Pos][0], inventory_items[i][invdrop_Pos][1], inventory_items[i][invdrop_Pos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, inventory_items[i][invdrop_World], inventory_items[i][invdrop_Int]);
		
		counter++;
	}
	printf("[INVENTORY - DROP ITEMS] - Loaded %d/%d dropped items.", counter, MAX_INV_DROPPED_ITEMS);
	return (true);
}
*/

LoadPlayerInventory(playerid, sql_id) {
	new query[128];
	format(query, sizeof(query), "SELECT * FROM `player_inventory` WHERE `owner_sqlID` = '%d'", sql_id);
	mysql_tquery(g_SQL, query, "Load_PlayerInventory", "i", playerid);
	return (true);
}

Function: Load_PlayerInventory(playerid)
{
	new rows = cache_num_rows();
	if(rows == 0) return (true);
	if(rows)
	{
		for (new i = 0; i < rows && i < MAX_INVENTORY_SLOTS; i ++) {
            inventory_data[playerid][i][invExists] = 1;
	  
			cache_get_value_name_int(i, "invID", inventory_data[playerid][i][invID]);
			cache_get_value_name_int(i, "invModel", inventory_data[playerid][i][invModel]);
			cache_get_value_name_int(i, "invQuantity", inventory_data[playerid][i][invQuantity]);
			cache_get_value_name_int(i, "InvType", inventory_data[playerid][i][invType]);
			
			cache_get_value_name(i, "invItem", inventory_data[playerid][i][invItem]);
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (inventory functions)
Function: StorePitemInDB(playerid, itemid) {
	inventory_data[playerid][itemid][invID] = cache_insert_id();
	return (true);
}

inventory_remove(playerid, item[], quantity = 1) {
    new itemid = inventory_get_item(playerid, item), query[256];

    if (itemid != (-1)) {
        if (inventory_data[playerid][itemid][invQuantity] > 0) {
			inventory_data[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || inventory_data[playerid][itemid][invQuantity] < 1) {
            inventory_data[playerid][itemid][invExists] = 0;
			inventory_data[playerid][itemid][invModel] = 0;
			inventory_data[playerid][itemid][invQuantity] = 0;
			inventory_data[playerid][itemid][invType] = ITEM_TYPE_NONE;
			
			
			format(query, sizeof(query), "DELETE FROM `player_inventory` WHERE `owner_sqlID` = '%d' AND `invID` = '%d'",PlayerInfo[playerid][pSQLID],inventory_data[playerid][itemid][invID]);
			mysql_tquery(g_SQL, query);
				       
            inventory_data[playerid][itemid][invID] = 0;	    
		}
		else if (quantity != -1 && inventory_data[playerid][itemid][invQuantity] > 0) {
				
			format(query, sizeof(query), "UPDATE `player_inventory` SET `invQuantity` = `invQuantity` - %d WHERE `owner_sqlID` = '%d' AND `invID` = '%d'",quantity,PlayerInfo[playerid][pSQLID],inventory_data[playerid][itemid][invID]);
			mysql_tquery(g_SQL, query);
		}
		return (true);
	}
	return (false);
}

CheckInventoryItem(playerid, ITEM_TYPE, const itemname[])
{
	new bool:check = false;
	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) 
	{
 		if (inventory_data[playerid][i][invType] == ITEM_TYPE) 
   		{
			if(strcmp(inventory_data[playerid][i][invItem], itemname ,true) == 0) 
			{
				check = true;
				break;
			}
		}
	}
	return check;
}

inventory_check(playerid, targetid) {
	new counter_items[MAX_INVENTORY_SLOTS], counter_amount[MAX_INVENTORY_SLOTS], buffer[MAX_PLAYER_NAME + 15];

	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) {
 		if (inventory_data[targetid][i][invExists] == 1) {
   			counter_items[i] = inventory_data[targetid][i][invModel];
   			counter_amount[i] = inventory_data[targetid][i][invQuantity];
		}
		else {
		    counter_items[i] = -1;
		    counter_amount[i] = -1;
		}
	}
	format(buffer, sizeof(buffer), "%s - Inventory", GetName(targetid));
	ShowModelESelectionMenu(playerid, buffer, MODEL_SELECTION_CHECK_INVENTORY, counter_items, sizeof(counter_items), 0.0, 0.0, 0.0, 1.0, -1, true, counter_amount);
	return (true);
}

inventory_open(playerid) {
	new counter_items[MAX_INVENTORY_SLOTS], counter_amount[MAX_INVENTORY_SLOTS];

	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) {
 		if (inventory_data[playerid][i][invExists] == 1) {
   			counter_items[i] = inventory_data[playerid][i][invModel];
   			counter_amount[i] = inventory_data[playerid][i][invQuantity];
		}
		else {
		    counter_items[i] = -1;
		    counter_amount[i] = -1;
		}
	}
	ShowModelESelectionMenu(playerid, "Inventory", MODEL_SELECTION_INVENTORY, counter_items, sizeof(counter_items), 0.0, 0.0, 0.0, 1.0, -1, true, counter_amount);
	return (true);
}

inventory_counteritems(playerid) {
    new count;
    for (new i = 0; i != MAX_INVENTORY_SLOTS; i ++) {
		if (inventory_data[playerid][i][invExists]) {
	        count ++;
		}
	}
	return (count);
}

inventory_get_item(playerid, item[]) {
	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) {
	    if (!inventory_data[playerid][i][invExists])
	        continue;
		if (!strcmp(inventory_data[playerid][i][invItem], item)) return (i);
	}
	return (-1);
}

Inventory_GetFreeID(playerid) {
	if (inventory_counteritems(playerid) >= 30)
		return (-1);

	for (new i = 0; i < MAX_INVENTORY_SLOTS; i ++) {
	    if (!inventory_data[playerid][i][invExists])
	        return (i);
	}
	return (-1);
}

inventory_add(playerid, item[], model, itemtype, quantity = 1) {
	new itemid = inventory_get_item(playerid, item), insertQuery[256];

	if (itemid == (-1))
	{
		itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
            inventory_data[playerid][itemid][invID] = itemid;
            inventory_data[playerid][itemid][invExists] = true;
		    inventory_data[playerid][itemid][invModel] = model;
			inventory_data[playerid][itemid][invQuantity] = quantity;
			inventory_data[playerid][itemid][invType] = itemtype;

			SetString(inventory_data[playerid][itemid][invItem], item);
			
			format(insertQuery, sizeof(insertQuery), "INSERT INTO `player_inventory` (`owner_sqlID`, `invItem`, `InvType`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d', '%d')", PlayerInfo[playerid][pSQLID], item, itemtype, model, quantity);
			mysql_tquery(g_SQL, insertQuery, "StorePitemInDB", "dd", playerid, itemid); 
			return (itemid);
	    }
	    return (-1);
	}
	else
	{
		format(insertQuery, sizeof(insertQuery), "UPDATE `player_inventory` SET `invQuantity` = `invQuantity` + %d WHERE `owner_sqlID` = '%d' AND `invID` = '%d'", quantity, PlayerInfo[playerid][pSQLID], inventory_data[playerid][itemid][invID]);
	    mysql_tquery(g_SQL, insertQuery);
		
		inventory_data[playerid][itemid][invQuantity] += quantity;
	}
	return (itemid);
}

inventory_process(playerid, cmdtext[]) {	
	new buffer[128];
	if(strcmp(cmdtext,"Boombox",true) == 0) {
		new Float:x, Float:y, Float:z; 
		
		if(BoomBoxPlanted[playerid] == false) {
			format(buffer, sizeof(buffer), "*%s stavlja svoj boombox na pod.", GetName(playerid, true));
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 30.0, 10000);
			
			GetPlayerPos(playerid, x, y, z);
			MusicInfo[playerid][mX] = x;
			MusicInfo[playerid][mY] = y;
			MusicInfo[playerid][mZ] = z;
			switch(PlayerInfo[playerid][pBoomBoxType]) {
				case 0: { 
					BoomBoxObject[playerid] = CreateDynamicObject(2226, x, y, z-0.9, 0, 0, random(100), -1, -1, -1, 200.0);
					BoomBoxPlanted[playerid] = true;
				}
				case 1: { 
					BoomBoxObject[playerid] = CreateDynamicObject(2103, x, y, z-0.9, 0, 0, random(100), -1, -1, -1, 200.0);
					BoomBoxPlanted[playerid] = true;
				}
			}
		}
	}
	else if(strcmp(cmdtext,"Mask",true) == 0) {
		if( !Bit1_Get(gr_MaskUse, playerid)) {	
			/*foreach(new i : Player) {
				ShowPlayerNameTagForPlayer(i, playerid, 0);
			}*/
			SendClientMessage(playerid, COLOR_RED, "[INVENTORY]: Stavili ste masku na glavu, da ju maknete odaberite opet 'koristi' u inventory-u.");
			Bit1_Set( gr_MaskUse, playerid, true);
			/*format(buffer, sizeof(buffer), "* %s stavlja masku na glavu.", GetName(playerid, true));
			SendClientMessage(playerid, COLOR_PURPLE, buffer);
			SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 20, 10000);*/
			
			GameTextForPlayer(playerid, "~b~STAVILI STE MASKU", 5000, 4);
				
			if(PlayerInfo[ playerid ][ pMaskID ] == 0) {
				new log[64], playerip[MAX_PLAYER_IP]; 
				GetPlayerIp(playerid, playerip, sizeof(playerip));
				PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);
				format(log, sizeof(log), "%s(%s), maskid %d.", 
					GetName(playerid, false),
					playerip, 
					PlayerInfo[ playerid ][ pMaskID ]
				);
				LogMask(log);				
			}
			new
				maskName[24];
			format(maskName, sizeof(maskName), "Maska_%d", PlayerInfo[playerid][pMaskID]);
			
			new
				maskName[24];
			format(maskName, sizeof(maskName), "Maska_%d", PlayerInfo[playerid][pMaskID]);
			if(IsValidDynamic3DTextLabel(NameText[playerid]))
			{
				DestroyDynamic3DTextLabel(NameText[playerid]);
				NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
			}
			NameText[playerid] = CreateDynamic3DTextLabel(maskName, 0xB2B2B2AA, 0, 0, -20, 25, playerid, INVALID_VEHICLE_ID, 1);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameText[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
			return (true);
		}
		else {
			foreach(new i : Player) {
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}
					
			Bit1_Set( gr_MaskUse, playerid, false );
			format(buffer, sizeof(buffer), "* %s skida masku sa glave.", GetName(playerid, true));
			SendClientMessage(playerid, COLOR_PURPLE, buffer);
			SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 20, 10000);
			
			GameTextForPlayer(playerid, "~b~SKINULI STE MASKU", 5000, 4);
			RemovePlayerAttachedObject(playerid, MASK_SLOT);
				
			if(IsValidDynamic3DTextLabel(NameText[playerid]))
			{
				DestroyDynamic3DTextLabel(NameText[playerid]);
				NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
			}
			return (true);
		}
	}
	else if(strcmp(cmdtext,"usecigarette",true) == 0) {
		ApplyAnimationEx(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0,1,0);
		SetPlayerSpecialAction(playerid, 21);
		
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Stisni lijevu tipku misa da pocnes pusiti.");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Koristi tipku ENTER da bacis cigaretu.");
		
		new
			tmpString[ 50 ];
		format(tmpString, sizeof(tmpString), "** %s pali cigaretu i pusi.", 
			GetName(playerid, true)
		);
		ProxDetector(30.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		Bit1_Set( gr_SmokingCiggy, playerid, true );
		PlayerInfo[playerid][pCiggaretes] -= 1;
	}
	else if(strcmp(cmdtext,"fillcar",true) == 0) {
		if( !PlayerInfo[ playerid ][ pCanisterLiters ] || PlayerInfo[ playerid ][ pCanisterType ] == -1 ) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste usipali nista u svoj kanister!");
		new
			vehicleid = GetPlayerVehicleID(playerid);
		if( ( vehicleid == 0 || vehicleid == INVALID_VEHICLE_ID ) || IsABike( GetVehicleModel( vehicleid ) ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilno vozilo!");
		if( VehicleInfo[ vehicleid ][ vFuel ] >= 75 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vase vozilo moze voziti!");
		
		if( PlayerInfo[ playerid ][ pCanisterType ] == ENGINE_TYPE_PETROL ) {
			if( VehicleInfo[ vehicleid ][ vEngineType ] == ENGINE_TYPE_DIESEL )
				VehicleInfo[ vehicleid ][ vEngineLife ] -= 25.0;
		}
		else if( PlayerInfo[ playerid ][ pCanisterType ] == ENGINE_TYPE_DIESEL ) {
			if( VehicleInfo[ vehicleid ][ vEngineType ] == ENGINE_TYPE_PETROL )
				VehicleInfo[ vehicleid ][ vEngineLife ] -= 25.0;
		}
		VehicleInfo[ vehicleid ][ vFuel ] += PlayerInfo[ playerid ][ pCanisterLiters ];
		PlayerInfo[ playerid ][ pCanisterLiters ] 	= 0;
		PlayerInfo[ playerid ][ pCanisterType ] 	= -1;
		inventory_remove(playerid, "Canister", -1);
	}
	return (true);
}

inventory_useitem(playerid, itemid, item_name[]) {
	if(inventory_data[playerid][itemid][invType] == ITEM_TYPE_FOOD) {
		if( PlayerInfo[ playerid ][ pHunger ] >= 5.0 ) return SendClientMessage( playerid, COLOR_RED, "[ ! ] Ne mozes vise piti/jesti!");
		if(PlayerInfo[playerid][pHunger] < 3.0) 
			PlayerInfo[playerid][pHunger] += 2.0;
		else PlayerInfo[playerid][pHunger] = 5.0;
	
		if (!IsPlayerAttachedObjectSlotUsed(playerid, 9)) {
			if(inventory_data[playerid][itemid][invModel] == 2702) // sve pizze
				SetPlayerAttachedObject(playerid, INVENTORY_ATTACHED_OBJECT, 2702, 6, 0.173041, 0.049197, 0.056789, 0.000000, 274.166107, 299.057983, 1.000000, 1.000000, 1.000000);
			if(inventory_data[playerid][itemid][invModel] == 2703) // svi burgeri
				SetPlayerAttachedObject(playerid, INVENTORY_ATTACHED_OBJECT, 2703, 6, 0.078287, 0.019677, -0.001004, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			SetTimerEx("inventory_attached", 3000, false, "dd", playerid, 9);
		}

		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
		inventory_remove(playerid, item_name); 
	}
	else if(inventory_data[playerid][itemid][invType] == ITEM_TYPE_DRINK) {
		if( PlayerInfo[ playerid ][ pHunger ] >= 5.0 ) return SendClientMessage( playerid, COLOR_RED, "[ ! ] Ne mozes vise piti/jesti!");
	
		if(PlayerInfo[playerid][pHunger] < 4.8) 
			PlayerInfo[playerid][pHunger] += 0.2;
		else PlayerInfo[playerid][pHunger] = 5.0;
				
		if (!IsPlayerAttachedObjectSlotUsed(playerid, 9)) {
		    SetPlayerAttachedObject(playerid, 9, inventory_data[playerid][itemid][invModel], 6, 0.173041, 0.049197, 0.056789, 0.000000, 274.166107, 299.057983, 1.000000, 1.000000, 1.000000);
			SetTimerEx("inventory_attached", 3000, false, "dd", playerid, 9);
		}

		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
		inventory_remove(playerid, item_name); 
	}
	else if(inventory_data[playerid][itemid][invType] == ITEM_TYPE_OTHER) {
		if (!strcmp(item_name, "Sat", true)) {
			new mtext[20],year, month,day,
			timeString[91];
			getdate(year, month, day);
			
			switch(month) {
				case 1:   mtext = "sij/jan"; 
				case 2:   mtext = "velj/feb"; 
				case 3:   mtext = "ozu/mar"; 
				case 4:   mtext = "tra/apr"; 
				case 5:   mtext = "svi/maj"; 
				case 6:   mtext = "lip/jun"; 
				case 7:   mtext = "srp/jul"; 
				case 8:   mtext = "kol/aug"; 
				case 9:   mtext = "ruj/sept"; 
				case 10:  mtext = "list/okt"; 
				case 11:  mtext = "stud/nov"; 
				case 12:  mtext = "pro/dec";
			}
			
			new hour,minuite,second;
			GetServerTime(hour,minuite,second);
			
			if (minuite < 10)
			{
				if (PlayerInfo[playerid][pJailTime] > 0) 
					format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%d:0%d~g~|~n~~w~Vrijeme pritvora: %d min", 
						day, 
						mtext, 
						hour,
						minuite, 
						PlayerInfo[playerid][pJailTime]
					);
				else 
					format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%d:0%d~g~|", 
						day, 
						mtext, 
						hour,
						minuite
					);
			}
			else
			{
				if (PlayerInfo[playerid][pJailTime] > 0) 
					format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%d:%d~g~|~n~~w~Vrijeme pritvora: %d min", 
						day, 
						mtext, 
						hour,
						minuite, 
						PlayerInfo[playerid][pJailTime]
					);
				else format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%d:%d~g~|", 
					day, 
					mtext, 
					hour,
					minuite
				);
			}
			
			GameTextForPlayer(playerid, timeString, 5000, 1);
			format(timeString, sizeof(timeString), "** %s gleda koliko je sati.", GetName(playerid,true));
			ProxDetector(30.0, playerid, timeString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(!IsPlayerInAnyVehicle(playerid))
				ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,0,0,0,0,1,0);
		}
		else if (!strcmp(item_name, "Upaljac", true)) {		
			inventory_process(playerid, "usecigarette");
			inventory_remove(playerid, "Cigarete"); 
		}
		else if (!strcmp(item_name, "Boombox", true)) {
			inventory_process(playerid, "Boombox");
		}
		else if (!strcmp(item_name, "Mask", true)) {
			inventory_process(playerid, "Mask");
		}
		else if (!strcmp(item_name, "Cigarete", true)) {
			inventory_process(playerid, "usecigarette");
			inventory_remove(playerid, "Cigarete"); 
		}
		else if (!strcmp(item_name, "Mobitel", true)) {
			Command_ReProcess(playerid, "/phone", 0);
		}
		else if (!strcmp(item_name, "Canister", true)) {
			inventory_process(playerid, "fillcar");
		}
		else if (!strcmp(item_name, "Kockica", true)) {
			Command_ReProcess(playerid, "/dice", 0);
		}
	}
	return (true);
}

inventory_drop(playerid, itemid, quantity = 1) {
	if (itemid == -1 || !inventory_data[playerid][itemid][invExists])
		return (false);

	if(inventory_data[playerid][itemid][invType] == ITEM_TYPE_OTHER) {
		if(strcmp(inventory_data[playerid][itemid][invItem],"Mobitel",true) == 0) {
			SendErrorMessage(playerid, "Ne mozete baciti mobitel.");
			return (false);
		}
	}
	
	new Float:Pos[4],string[32];

	strunpack(string, inventory_data[playerid][itemid][invItem]);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]); GetPlayerFacingAngle(playerid, Pos[3]);

	item_drop(string, GetName(playerid), inventory_data[playerid][itemid][invModel], inventory_data[playerid][itemid][invType], quantity, Pos[0], Pos[1], Pos[2] - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	if(Bit1_Get(gr_MaskUse, playerid))
	{
		foreach(new i : Player) {
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}
		
		new buffer[128];				
		Bit1_Set( gr_MaskUse, playerid, false );
		format(buffer, sizeof(buffer), "* %s skida masku sa glave i baca ju na pod.", GetName(playerid, true));
		SendClientMessage(playerid, COLOR_PURPLE, buffer);
		SetPlayerChatBubble(playerid, buffer, COLOR_PURPLE, 20, 10000);
		RemovePlayerAttachedObject(playerid, MASK_SLOT);
					
		if(IsValidDynamic3DTextLabel(NameText[playerid])) {
			DestroyDynamic3DTextLabel(NameText[playerid]);
			NameText[playerid] = Text3D:INVALID_3DTEXT_ID;
		}
	}
	inventory_remove(playerid, string, quantity);

	ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1); 
	return (true);
}

Function: inventory_attached(playerid, slot)
{
	if (IsPlayerAttachedObjectSlotUsed(playerid, slot)) {
	    RemovePlayerAttachedObject(playerid, slot);
	}
	return (true);
}

//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (item functions)
/*Function: StoreItemInDB(itemid) {
   if (itemid == -1 || !inventory_items[itemid][invdrop_Model])
	    return (false);

   inventory_items[itemid][invdrop_ID] = cache_insert_id();
   return (true);
}*/

item_drop(item[], playere[], model, type_item, quantity, Float:x, Float:y, Float:z, interior, world) {
	for (new i = 0; i != MAX_INV_DROPPED_ITEMS; i ++) if (!inventory_items[i][invdrop_Model]) {
		new buffer[64];
		format(inventory_items[i][invdrop_Item], 32, item);
	    format(inventory_items[i][invdrop_Owner], 24, playere);

		inventory_items[i][invdrop_Model] = model;
		inventory_items[i][invdrop_Quantity] = quantity;
		inventory_items[i][invdrop_Pos][0] = x;
		inventory_items[i][invdrop_Pos][1] = y;
		inventory_items[i][invdrop_Pos][2] = z;
		
		inventory_items[i][invdrop_Int] = interior;
		inventory_items[i][invdrop_World] = world;
		inventory_items[i][invdrop_Type] = type_item;
		
		inventory_items[i][invdrop_ObjectID] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);
		format(buffer, sizeof(buffer), "{C3C3C3}[ %s ]\n'Y'", item);
		inventory_items[i][invdrop_Text3D] = CreateDynamic3DTextLabel(buffer, -1, x, y, z, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior);
		
		/*format( insertQuery, sizeof(insertQuery), "INSERT INTO `inventory_dropitem` (`itemName`, `itemPlayer`, `itemModel`, `itemType`, `itemQuantity`, `itemX`, `itemY`, `itemZ`, `itemInt`, `itemWorld`) VALUES('%s', '%s', '%d', '%d', '%d', '%.4f', '%.4f', '%.4f', '%d', '%d')",
			item, playere, model, type_item, quantity, x, y, z, interior, world);
		mysql_tquery(g_SQL, insertQuery, "StoreItemInDB", "d", i);*/
		return (i);
	}
	return (-1);
}

item_nearest(playerid) {
	for (new i = 0; i != MAX_INV_DROPPED_ITEMS; i ++) if (inventory_items[i][invdrop_Model] && IsPlayerInRangeOfPoint(playerid, 1.5, inventory_items[i][invdrop_Pos][0], inventory_items[i][invdrop_Pos][1], inventory_items[i][invdrop_Pos][2])) {
	    if (GetPlayerInterior(playerid) == inventory_items[i][invdrop_Int] && GetPlayerVirtualWorld(playerid) == inventory_items[i][invdrop_World])
			return (i);
	}
	return (-1);
}

item_pickup(playerid, itemid) {
	if (itemid != -1 && inventory_items[itemid][invdrop_Model]) {
	    new save_item = inventory_add(playerid, inventory_items[itemid][invdrop_Item], inventory_items[itemid][invdrop_Model], inventory_items[itemid][invdrop_Type], inventory_items[itemid][invdrop_Quantity]);
				  
	    if (save_item == -1)
	        return va_SendClientMessage(playerid, COLOR_LIGHTRED, "[GREKSA]: Nemate slobodnih slotova u inventaru!");

	    item_droprefresh(itemid);
	}
	return (true);
}

item_droprefresh(itemid) {
	if (itemid != -1 && inventory_items[itemid][invdrop_Model]) {
		inventory_items[itemid][invdrop_Model] = 0;
		inventory_items[itemid][invdrop_Quantity] = 0;
	    inventory_items[itemid][invdrop_Pos][0] = 0.0;
	    inventory_items[itemid][invdrop_Pos][1] = 0.0;
	    inventory_items[itemid][invdrop_Pos][2] = 0.0;
	    inventory_items[itemid][invdrop_Int] = 0;
	    inventory_items[itemid][invdrop_World] = 0;
		inventory_items[itemid][invdrop_Type] = 0;
		
		//format(query, sizeof(query), "DELETE FROM `inventory_dropitem` WHERE `ID` = '%d'", inventory_items[itemid][invdrop_ID]);
		//mysql_tquery(g_SQL, query, "", "");

	    DestroyDynamicObject(inventory_items[itemid][invdrop_ObjectID]);
		DestroyDynamic3DTextLabel(inventory_items[itemid][invdrop_Text3D]);
	}
	return (true);
}

Function: Reprocess_PlayerInv(playerid)
{
	if(PlayerInfo[playerid][pBoomBox]) {
		inventory_remove(playerid, "Boombox", -1);
		switch(PlayerInfo[playerid][pBoomBoxType]) {
			case 0: { 
				inventory_add(playerid, "Boombox", 2226, ITEM_TYPE_OTHER);
			}
			case 1: { 
				inventory_add(playerid, "Boombox", 2103, ITEM_TYPE_OTHER);
			}
		}
	}
	if(PlayerInfo[playerid][pMobileNumber] != 0) {
		inventory_remove(playerid, "Mobitel", -1);
		inventory_add(playerid, "Mobitel", PlayerInfo[playerid][pMobileModel], ITEM_TYPE_OTHER);
	}
	if(PlayerInfo[playerid][pMaskID] > 0) {
		inventory_remove(playerid, "Mask", -1);
		inventory_add(playerid, "Mask", 19036, ITEM_TYPE_OTHER);
	}
	if(PlayerInfo[playerid][pClock]) {
		inventory_remove(playerid, "Sat", -1);
		inventory_add(playerid, "Sat", 19043, ITEM_TYPE_OTHER);
	}
	if(PlayerInfo[playerid][pCiggaretes] != 0) {
		inventory_remove(playerid, "Cigarete", -1);
		inventory_add(playerid, "Cigarete", 19897, ITEM_TYPE_OTHER, PlayerInfo[playerid][pCiggaretes]);
	}
	if(PlayerInfo[playerid][pLighter]) {
		inventory_remove(playerid, "Upaljac", -1);
		inventory_add(playerid, "Upaljac", 19998, ITEM_TYPE_OTHER);
	}
	if(PlayerInfo[ playerid ][ pCanisterLiters ] != 0) {
		inventory_add(playerid, "Canister", 1650, ITEM_TYPE_OTHER);
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (hooks)
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if( newkeys == KEY_YES ) {
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK) {
        	new load_items = item_nearest(playerid), buffer[32], string[128], log[128], playerip[MAX_PLAYER_IP];

        	if (load_items != (-1)) {
                for (new i = 0; i < MAX_INV_DROPPED_ITEMS; i ++) {
					if(IsPlayerInRangeOfPoint(playerid, 1.5, inventory_items[i][invdrop_Pos][0], inventory_items[i][invdrop_Pos][1], inventory_items[i][invdrop_Pos][2]) && GetPlayerInterior(playerid) == inventory_items[i][invdrop_Int] && GetPlayerVirtualWorld(playerid) == inventory_items[i][invdrop_World]) {
						ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);

						format(buffer, sizeof(buffer), "~g~INVENTORY~n~+ %s", inventory_items[load_items][invdrop_Item]);
						format(string, sizeof(string), "* %s saginje se i podize nesto sa poda..", GetName(playerid));
						
						GameTextForPlayer(playerid, buffer, 5000, 4);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
						SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 10.0, 5000);
							
						if(inventory_items[i][invdrop_Model] == 19036) {
							GetPlayerIp(playerid, playerip, sizeof(playerip));
							PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);	
							format(log, sizeof(log), "%s(%s), maskid %d.", 
								GetName(playerid, false),
								playerip, 
								PlayerInfo[ playerid ][ pMaskID ]
							);
							LogMask(log); 
						}
						item_pickup(playerid, load_items);
						break; // ukoliko ima vise itema oko sebe, pronade/uzme samo jedan i automatski zaustavlja skriptu da ostale pronalazi/uzima.
					}	
                }  
			}
		}    
    }
	return (true);
}

hook OnModelSelResponse( playerid, extraid, index, modelid, response ) {
	if((extraid == MODEL_SELECTION_INVENTORY && response)) {
		new dialog_title[50], buffer[256];
        inventory_itemID[playerid] = (index);
        
		format(dialog_title, sizeof(dialog_title), "[ITEM - %s ]", inventory_data[playerid][index][invItem]);
		format(buffer, sizeof(buffer), "(1). - Koristi.\n(2). - Baci.\n(3). - Daj igracu.\n(!) Kolicina: %d.", inventory_data[playerid][index][invQuantity]);
		ShowPlayerDialog(playerid, DIALOG_INVENTORY_MENU, DIALOG_STYLE_LIST, dialog_title, buffer, "(odaberi)", "Close");
	}
	return (true);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch( dialogid )
	{
		case DIALOG_INVENTORY_MENU: {
			if(response)
			{
				new itemid = inventory_itemID[playerid];
				switch (listitem)
				{
					case 0:
						inventory_useitem(playerid, itemid, inventory_data[playerid][itemid][invItem]);
						
					case 1: {
						if(inventory_data[playerid][itemid][invQuantity] == 1)
					          inventory_drop(playerid, itemid);
						else {
							new buffer[276], dialog_title[50];
							
							format(dialog_title, sizeof(dialog_title), "[DROP ITEM - %s ]", inventory_data[playerid][itemid][invItem]);
							format(buffer, sizeof(buffer), "\nIspod unesite kolicinu '%s' kojeg zelite izbaciti iz vaseg inventorya.\nNapomena, nakon sto izbacite objekat stvoriti ce se na podu i mozete ga\nponovo pokupiti pritiskom na 'Y'.\n \nTrenutna kolicina: %d.", inventory_data[playerid][itemid][invItem], inventory_data[playerid][itemid][invQuantity]);
							
							ShowPlayerDialog(playerid, DIALOG_INVENTORY_DROP, DIALOG_STYLE_INPUT, dialog_title,  buffer, "(input)", "Close");
						}
					}
					case 2: {
						new dialog_title[50];
						format(dialog_title, sizeof(dialog_title), "[GIVE ITEM - %s ]", inventory_data[playerid][itemid][invItem]);
						
						ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, dialog_title, "\nIspod unesite ID igraca i kolicinu item-a koju zelite dati igracu.\n[PRIMJER]: 1(id igraca) 20(kolicina).", "(input)", "Close");
					}
				}
			}
		}
		case DIALOG_INVENTORY_DROP: {
			if (response)
			{
				new itemid = inventory_itemID[playerid], buffer[276], dialog_title[50];
				format(dialog_title, sizeof(dialog_title), "[DROP ITEM - %s ]", inventory_data[playerid][itemid][invItem]);
				format(buffer, sizeof(buffer), "\nIspod unesite kolicinu '%s' kojeg zelite izbaciti iz vaseg inventorya.\nNapomena, nakon sto izbacite objekat stvoriti ce se na podu i mozete ga\nponovo pokupiti pritiskom na 'Y'.\n \nTrenutna kolicina: %d.", inventory_data[playerid][itemid][invItem],inventory_data[playerid][itemid][invItem], inventory_data[playerid][itemid][invQuantity]);
							
				if (isnull(inputtext))
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_DROP, DIALOG_STYLE_INPUT, dialog_title,  buffer, "(input)", "Close");
				
				if (strval(inputtext) < 1 || strval(inputtext) > inventory_data[playerid][itemid][invQuantity])
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_DROP, DIALOG_STYLE_INPUT, dialog_title,  buffer, "(input)", "Close");

				inventory_drop(playerid, itemid, strval(inputtext));
			}
		}
		case DIALOG_INVENTORY_GIVE: {
			if (response)
			{
				new itemid = inventory_itemID[playerid], dialog_title[50], string[32];
				format(dialog_title, sizeof(dialog_title), "[GIVE ITEM - %s ]", inventory_data[playerid][itemid][invItem]);
				
				if (strval(inputtext) == INVALID_PLAYER_ID)
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, dialog_title, "\nIspod unesite ID igraca i kolicinu item-a koju zelite dati igracu.\n[PRIMJER]: 1(id igraca) 20(kolicina).", "(input)", "Close");
				
				if (strval(inputtext) == playerid)
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE, DIALOG_STYLE_INPUT, dialog_title, "\nIspod unesite ID igraca i kolicinu item-a koju zelite dati igracu.\n[PRIMJER]: 1(id igraca) 20(kolicina).", "(input)", "Close");
				
				if (itemid == -1)
					return (false);

				strunpack(string, inventory_data[playerid][itemid][invItem]);
				
				if(inventory_data[playerid][itemid][invType] == ITEM_TYPE_OTHER) {
					if(strcmp(inventory_data[playerid][itemid][invItem],"Mobitel",true) == 0) {
						SendErrorMessage(playerid, "Ne mozete dati mobitel.");
						return (false);
					}
				}
				
				if( !ProxDetectorS(5.0, playerid, strval(inputtext)) )
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu igraca!");

				if (inventory_data[playerid][itemid][invQuantity] == 1)
				{
					new add_to = inventory_add(strval(inputtext), string, inventory_data[playerid][itemid][invModel], inventory_data[playerid][itemid][invType]);
					
					if (add_to == -1)
						return SendErrorMessage(playerid,"Igracu kojem zelite dati item ima full slotove.");
					  
					va_SendClientMessage(strval(inputtext), COLOR_RED,"[ ! ] %s vam je dao %s, kolicina 1.",GetName(playerid), string);
					va_SendClientMessage(playerid, COLOR_RED,"[ ! ] Dali ste igracu %s, item %s, kolicina 1.",GetName(strval(inputtext)), string);
					inventory_remove(playerid, string);		 
				}
				else
				{
					ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_QUANTITY, DIALOG_STYLE_INPUT, dialog_title, "\nSada kada ste odabrali kome zelite dati item, morate unesti kolicinu\nkoju zelite dat igracu. Primjer ukoliko zelite nekome dat jednu cigaretu(primjer) ispod upisite 1.", "(give)", "Close");
					inventory_GetGiveID[playerid] = strval(inputtext);
				}
			}
		}
		case DIALOG_INVENTORY_GIVE_QUANTITY: {
			if (response && inventory_GetGiveID[playerid] != INVALID_PLAYER_ID)
			{
				new targetid = inventory_GetGiveID[playerid], itemid = inventory_itemID[playerid], string[32], dialog_title[50];
				format(dialog_title, sizeof(dialog_title), "[GIVE ITEM - %s ]", inventory_data[playerid][itemid][invItem]);
				strunpack(string, inventory_data[playerid][itemid][invItem]);
				
				if (isnull(inputtext))
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_QUANTITY, DIALOG_STYLE_INPUT, dialog_title, "\nSada kada ste odabrali kome zelite dati item, morate unesti kolicinu\nkoju zelite dat igracu. Primjer ukoliko zelite nekome dat jednu cigaretu(primjer) ispod upisite 1.", "(give)", "Close");
				if (strval(inputtext) < 1 || strval(inputtext) > inventory_data[playerid][itemid][invQuantity])
					return ShowPlayerDialog(playerid, DIALOG_INVENTORY_GIVE_QUANTITY, DIALOG_STYLE_INPUT, dialog_title, "\nSada kada ste odabrali kome zelite dati item, morate unesti kolicinu\nkoju zelite dat igracu. Primjer ukoliko zelite nekome dat jednu cigaretu(primjer) ispod upisite 1.", "(give)", "Close");

				new add_to = inventory_add(targetid, string, inventory_data[playerid][itemid][invModel], inventory_data[playerid][itemid][invType], strval(inputtext));
				if (add_to == -1)
						return SendErrorMessage(playerid,"Igracu kojem zelite dati item ima full slotove.");
  
				va_SendClientMessage(targetid, COLOR_YELLOW,"[INVENTORY]: %s vam je dao %s, kolicina %d.", GetName(playerid), string, strval(inputtext));
				va_SendClientMessage(playerid, COLOR_RED,"[INVENTORY]: Dali ste %s, item %s, kolicina %d.", GetName(targetid), string, strval(inputtext));
			  
				inventory_remove(playerid, string, strval(inputtext));
			}
		}
	}
	return (true);
}
//=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~ (commands)
CMD:inventory(playerid,params[]) {
	if(lts_Joined[playerid] == true)
		return SendErrorMessage(playerid, "Ne mozete koristiti ovu komandu dok ste na Last Man Standing event-u.");
	inventory_open(playerid);		
	return (true);
}

CMD:item_give(playerid, params[]) {
	new targetid, item_name[32], item_objectid, itemtype;
	
	if (PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params,"is[32]ii", targetid, item_name, item_objectid, itemtype)) 
	{
 		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /item_give (playerid) (item ime) (item objectid) (item type).");
		SendClientMessage(playerid, COLOR_RED, "[ITEM TYPE]: (1-Food) (2-Drink) (3-Other).");
		return (true);
	}
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste igracu %s item %s.", GetName(targetid), item_name);	
	va_SendClientMessage(targetid, COLOR_RED, "[ ! ] Admin %s vam je dao %s.", GetName(playerid), item_name);
	
	inventory_add(targetid, item_name, item_objectid, itemtype);
	return (true);
}

CMD:item_drop(playerid, params[]) {
	new quantity, item_name[32], item_objectid, itemtype, Float:Pos[4];
	if (PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");

	if(sscanf(params,"s[32]iii", item_name, item_objectid, itemtype, quantity)) 
	{
 		SendClientMessage(playerid, -1, "[KORISTI]: /item_drop (item ime) (item objectid) (item type) (quantity).");
		SendClientMessage(playerid, -1, "[ITEM TYPE]: (1-Food) (2-Drink) (3-Other).");
		return (true);
	}
	
	va_SendClientMessage(playerid, COLOR_RED, "[ITEM]: Dropali ste na pod item %s, kolicina %d.", item_name, quantity);	
	
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]); GetPlayerFacingAngle(playerid, Pos[3]);

	item_drop(item_name, GetName(playerid), item_objectid, itemtype, quantity, Pos[0], Pos[1], Pos[2] - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	return (true);
}

CMD:inventory_reload(playerid, params[]) {
    if (PlayerInfo[playerid][pAdmin] < 2) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
		
    if (sscanf(params,"i", giveplayerid)) 
		return SendClientMessage(playerid, -1, "[KORISTI]: /inventory_reload [playerid].");
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspijesno ste osvijezili/refresh inventory od igraca %s.", GetName(giveplayerid));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Administrator %s vam je osvijezio/refresh inventory.", GetName(playerid));
	Reprocess_PlayerInv(giveplayerid);
	return (true);
}

CMD:checkinv(playerid, params[]) {
	if (PlayerInfo[playerid][pAdmin] < 1337)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	
	new targetid;
	if( sscanf(params, "u", targetid)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checkinv [ID/Dio imena]");
    if( !IsPlayerConnected(targetid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igraè nije online!");
	
	inventory_check(playerid, targetid);
	va_SendClientMessage(playerid, COLOR_RED, "[INVENTORY]: Otvorili ste inventory od igraca %s.", GetName(targetid));
	return (true);
}

CMD:item_destroy(playerid, params[]) {
	new load_items = item_nearest(playerid);
		
	if (PlayerInfo[playerid][pAdmin] < 1337) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");

	if (load_items != (-1)) {
		for (new i = 0; i < MAX_INV_DROPPED_ITEMS; i ++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.5, inventory_items[i][invdrop_Pos][0], inventory_items[i][invdrop_Pos][1], inventory_items[i][invdrop_Pos][2]) && GetPlayerInterior(playerid) == inventory_items[i][invdrop_Int] && GetPlayerVirtualWorld(playerid) == inventory_items[i][invdrop_World]) {
				item_droprefresh(load_items);
				va_SendClientMessage(playerid, COLOR_RED, "[ITEM]: Uspijesno ste unistili item (%s) koji se nalazio u vasoj blizini. ", inventory_items[i][invdrop_Item]);	
				break;
			}	
        }  
	}
	return (true);
}
	
