#include <YSI_Coding\y_hooks>

#define MAX_PLAYER_OBJECTS 					(20)
#define PO_DRAW_DIST 						(100.0)
#define OBJECT_FROM_PLAYER_Y				(10.0)

enum E_PLACED_OBJECTS_DATA
{
	bool:poPlaced,
	poModelid,
	Float:poPos[3],
	Float:poRot[3],
	poViwo,
	poInterior,
	poObjectid
};
static stock
	PlayerObjectsInfo[MAX_PLAYERS][MAX_PLAYER_OBJECTS][E_PLACED_OBJECTS_DATA];

static stock
	Bit4: r_PlayerObjectEditState<MAX_PLAYERS>  = {Bit4:0, ... };
	
static
	bool:CreateObjReq[MAX_PLAYERS],
	chosenpObject[MAX_PLAYERS],
	chosenpID[MAX_PLAYERS],
	PlayerEditPOObject[MAX_PLAYERS],
	PlayerPrwsPOObject[MAX_PLAYERS],
	PlayerPrwsPOIndex[MAX_PLAYERS],
	PlayerPrwsPOModel[MAX_PLAYERS],
	PlayerEditPOIndex[MAX_PLAYERS];

static 
	Iterator:PlayerCreateObjects[MAX_PLAYERS]<MAX_PLAYER_OBJECTS>;
	
static objects[] =
{
    964, 2359, 1520, 1951, 1778, 2628, 1594, 1827, 2173, 2346, 1985, 928, 1265,
    1334, 1572, 2629, 1348, 1851, 1664, 1666, 1481, 2002, 2629, 1670, 1896, 2125,
    933, 1328, 1337, 1369, 2628, 1362, 2188, 1486, 1665, 1667, 1581, 2595, 1671,
    1825, 910, 1227, 1327, 1339, 19470, 2630, 1685, 3632, 1509, 1669, 2630, 1280,
    1704, 1998, 2166, 851, 1236, 1332, 1363, 944, 2358, 3633, 1871, 1950, 2627,
    1281, 1726, 2027, 2198, 926, 1264, 1333, 1450, 2047, 2048, 2714, 11738, 11712,
    11736, 11747, 11737, 11745, 11699, 11705, 11717, 11738, 11706, 11715, 11743,
    19811, 19831, 19835, 19845, 19638, 19636, 2654, 2215, 2881, 19470, 19578,
    19580,  19632, 11733, 19793, 18632, 2768, 1271, 1279, 1310, 1328, 1329, 1330,
    1338, 1340, 1341, 1342, 1347, 1356, 1362, 1414, 1426, 1428, 1436, 1437,
    1441, 1451, 1458, 1463, 1464, 1465, 1481, 1484, 1485, 1510, 1550, 1570, 1572,
    1575, 1582, 1598, 1616, 1640, 1644, 1650, 1667, 1668, 1669, 1707, 1711,
    1712, 1736, 1946, 1950, 1962, 2043, 2045, 2146, 2212, 2213, 2214, 2215, 2216,
    2217, 2218, 2219, 2220, 2221, 2222, 2223, 2228, 2237, 2353, 2354, 2355, 2359,
    2404, 2405, 2406, 2410, 2469, 2814, 2838, 2857, 2860, 2880, 2894, 2897, 2900,
    2901, 2905, 2906, 2907, 2908, 2912, 2914, 2919, 2945, 2973, 3129, 19893, 19894,
    19078, 19582, 19630, 3098, 321, 1575, 352, 372, 1543, 1546, 1512, 1766,
    1793, 1810, 1840, 2102, 1209, 19897, 2342, 2673, 2840, 1212, 1280, 1302, 1347,
    1762, 19578, 1667, 19835, 2703, 2702, 3800, 1491, 643, 869, 19525, 19616,
    19614, 19608, 19836, 19824, 14490, 1576, 1577, 2670, 2671, 1645, 1954, 1575, 1081,
    1083, 1084, 1086, 1096, 3035, 2654, 917, 3861, 18694, 18690, 18691,
    1455, 1484, 1487, 1512, 1520, 1541, 19824, 1491, 643, 1671, 1720, 1716, 1641, 2803,
    18648, 18649, 18651, 18647, 18652, 18650, 19121, 2763, 2121, 348, 19815 , 19583,
    1646, 1669, 3798, 19471, 8406, 1649, 1892, 19094, 19587, 19621, 2370, 19146,
    19152, 19154, 19144, 2491, 19610, 19611, 19366, 2984, 1571, 8674, 11245, 1959, 1776,
    1255, 2860, 19587, 1291, 3468, 2868, 1211, 11686, 3039, 947, 642, 1223, 2241,
    2773, 2391, 19128, 18275, 1764, 10575, 3077, 2310, 2207, 1639, 2372, 2531, 2631,
    2632, 3041, 19339, 2063, -2061, -2046, -2034, -2121, -2134, -2033, -2076, -2039
};

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/////////////////////////////////////////////////////////////
stock UpdateStreamerAroundPlayer(playerid)
{
	new
	    Float: x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
   		if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
			Streamer_Update(i);
	}
	return 1;
}

stock static CreatePlayerObjectsObject(playerid, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(playerid == INVALID_PLAYER_ID) return 0;
	new
		index 	= GetFreeObjectSlot(playerid);
	if(index == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno mjesta za objekte!");
	PlayerObjectsInfo[playerid][index][poPlaced] 		= true;
	PlayerObjectsInfo[playerid][index][poModelid] 	= modelid;
	PlayerObjectsInfo[playerid][index][poPos][0]		= x;
	PlayerObjectsInfo[playerid][index][poPos][1]		= y;
	PlayerObjectsInfo[playerid][index][poPos][2]		= z;
	PlayerObjectsInfo[playerid][index][poRot][0]		= rx;
	PlayerObjectsInfo[playerid][index][poRot][1]		= ry;
	PlayerObjectsInfo[playerid][index][poRot][2]		= rz;
	PlayerObjectsInfo[playerid][index][poViwo] 		= GetPlayerVirtualWorld(playerid);
	PlayerObjectsInfo[playerid][index][poInterior] 	= GetPlayerInterior(playerid);

	PlayerObjectsInfo[playerid][index][poObjectid] 	= CreateDynamicObject(modelid, x, y, z, rx, ry, rz, PlayerObjectsInfo[playerid][index][poViwo], PlayerObjectsInfo[playerid][index][poInterior], -1, 150.0, PO_DRAW_DIST);
	Iter_Add(PlayerCreateObjects[playerid], index);	
	UpdateStreamerAroundPlayer(playerid);

	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste objekat ID: %d. Ukoliko Zelite promjeniti poziciju koristite /editobject.", modelid);
	return index;
}

stock static SetPlayerObjectsObjectPos(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(playerid == INVALID_PLAYER_ID) 								return 0;
	if(!IsValidPlayerObject(playerid, PlayerEditPOObject[playerid])) 	return 0;

	new
		index = PlayerEditPOIndex[playerid];	
	CancelEdit(playerid);
	DestroyPlayerObject(playerid, PlayerEditPOObject[playerid]);
	
	PlayerObjectsInfo[playerid][index][poObjectid] = CreateDynamicObject(PlayerObjectsInfo[playerid][index][poModelid], x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, PO_DRAW_DIST, PO_DRAW_DIST);
	PlayerObjectsInfo[playerid][index][poPos][0]	= x;
	PlayerObjectsInfo[playerid][index][poPos][1]	= y;
	PlayerObjectsInfo[playerid][index][poPos][2]	= z;
	PlayerObjectsInfo[playerid][index][poRot][0]	= rx;
	PlayerObjectsInfo[playerid][index][poRot][1]	= ry;
	PlayerObjectsInfo[playerid][index][poRot][2]	= rz;
	
	UpdateStreamerAroundPlayer(playerid);
	Bit4_Set( r_PlayerObjectEditState, playerid, 0);
	
	PlayerEditPOObject[playerid] 	= INVALID_OBJECT_ID;
	PlayerEditPOIndex[playerid]		= -1;
	return 1;
}

stock static EditPOObject(playerid, index)
{
	if(playerid == INVALID_PLAYER_ID || index == -1) return 0;
	
	if(IsValidDynamicObject(PlayerObjectsInfo[playerid][index][poObjectid])) {
		DestroyDynamicObject(PlayerObjectsInfo[playerid][index][poObjectid]);
		PlayerObjectsInfo[playerid][index][poObjectid] = INVALID_OBJECT_ID;
		PlayerEditPOIndex[playerid] = index;
		
		PlayerEditPOObject[playerid] 	= CreatePlayerObject(
			playerid, 
			PlayerObjectsInfo[playerid][index][poModelid], 
			PlayerObjectsInfo[playerid][index][poPos][0], 
			PlayerObjectsInfo[playerid][index][poPos][1],
			PlayerObjectsInfo[playerid][index][poPos][2],
			PlayerObjectsInfo[playerid][index][poRot][0], 
			PlayerObjectsInfo[playerid][index][poRot][1], 
			PlayerObjectsInfo[playerid][index][poRot][2]
		);
		Bit4_Set(r_PlayerObjectEditState, playerid, EDIT_STATE_EDIT);
		EditPlayerObject(playerid, PlayerEditPOObject[playerid]);
	} else {
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se greska s uredjivanjem objekta!");
		printf("[DEBUG] PLAYER OBJECT EDIT: index(%d) | objectid(%d)", index, PlayerObjectsInfo[playerid][index][poObjectid]);
	}
	return 1;
}

stock IsAPlayerSpawnedObject(modelid, Float:x, Float:y, Float:z)
{
	foreach(new i : Player)
	{
	    foreach(new po: PlayerCreateObjects[i])
	    {
	        if(x == PlayerObjectsInfo[i][po][poPos][0] && y == PlayerObjectsInfo[i][po][poPos][1] && z == PlayerObjectsInfo[i][po][poPos][2] && modelid == PlayerObjectsInfo[i][po][poModelid])
       		{
       		    return i;
       		}
	    }
	}
	return -1;
}

stock DeletePlayerObjectsObject( playerid, slot_id, bool:iterdel = true)
{
	PlayerObjectsInfo[playerid][slot_id][poPlaced] = false;
	
	PlayerObjectsInfo[playerid][slot_id][poPos][0] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poPos][1] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poPos][2] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poRot][0] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poRot][1] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poRot][2] = 0.0;
	PlayerObjectsInfo[playerid][slot_id][poViwo] = 0;
	PlayerObjectsInfo[playerid][slot_id][poInterior] = 0;

	if(IsValidDynamicObject( PlayerObjectsInfo[playerid][slot_id][poObjectid])) {
		DestroyDynamicObject( PlayerObjectsInfo[playerid][slot_id][poObjectid]);
	}
	PlayerObjectsInfo[playerid][slot_id][poModelid] = -1;
	if(iterdel)
		Iter_Remove(PlayerCreateObjects[playerid], slot_id);

	return 1;
}

stock GetPlayerObjectsOwner(playerid, &modelid, &ownerid, &slotid)
{
	foreach(new i : Player)
	{
	  	foreach(new po: PlayerCreateObjects[i])
	    {
	        if(IsPlayerInRangeOfPoint(playerid, 2.5, PlayerObjectsInfo[i][po][poPos][0], PlayerObjectsInfo[i][po][poPos][1], PlayerObjectsInfo[i][po][poPos][2]))
       		{
       		    modelid = PlayerObjectsInfo[i][po][poModelid];
       		    ownerid = i;
       		    slotid = po;
       		    return 1;
       		}
	    }
	}
	return 0;
}

stock IsAValidPlObject(objectid)
{
	for(new so = 0; so != sizeof(objects); ++so)
	{
		if(objects[so] == objectid)
			return 1;
	}
	return 0;
}

stock AreAllPObjectSlotsEmpty( playerid)
{
    foreach(new i: PlayerCreateObjects[playerid])
	{
        if(PlayerObjectsInfo[playerid][i][poPlaced])
			return 0;
	}
	return 1;
}

stock GetFreeObjectSlot( playerid) 
{
    foreach(new i: PlayerCreateObjects[playerid])
	{

        if(!PlayerObjectsInfo[playerid][i][poPlaced]) 
		{ 
			return i; 
		}
	}
	return -1;
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
/////////////////////////////////////////////////////////////

hook function ResetPlayerVariables(playerid)
{
	foreach(new cobjid: PlayerCreateObjects[playerid])
	{
		if(IsValidDynamicObject( PlayerObjectsInfo[playerid][cobjid][poObjectid]) && PlayerObjectsInfo[playerid][cobjid][poPlaced]) 
			DeletePlayerObjectsObject(playerid, cobjid, false);
	}
	
	Bit4_Set(r_PlayerObjectEditState, playerid, 0);
	
	CreateObjReq[playerid]			= false;
	chosenpObject[playerid]			= 0;
	chosenpID[playerid] 			= 0;
	PlayerEditPOObject[playerid] 	= 0;
	PlayerPrwsPOObject[playerid] 	= 0;
	PlayerPrwsPOIndex[playerid] 	= 0;
	PlayerPrwsPOModel[playerid] 	= 0;
	PlayerEditPOIndex[playerid] 	= 0;

	Iter_Clear(PlayerCreateObjects[playerid]);
    return continue(playerid);
}


hook OnPlayerSelectDynObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	if(IsAValidPlObject(modelid))
	{
		new
 			co_pid = -1;
		if((co_pid = IsAPlayerSpawnedObject(modelid, x, y, z)) != -1)
		{
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Vlasnik tog objekta je %s[%d]!", GetName(co_pid, false), co_pid);
		}
	}
	return 1;
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
	switch(fselectid)
	{
		case ms_CREATE_COBJECT:
		{
			if(!response)
				return 1;
				
			new
				Float:x,
				Float:y,
				Float:z;
			GetPlayerPos(playerid, x, y, z);
			GetXYInFrontOfPlayer(playerid, x, y, 3.0);
			CreatePlayerObjectsObject(playerid, modelid, x, y, z, 0.0, 0.0, 0.0);
		}
		case ms_ADMIN_DEL_COBJECT:
		{
			if(response && chosenpID[playerid] != -1)
			{
				if(!IsPlayerConnected(chosenpID[playerid]))
					return SendMessage(playerid, MESSAGE_TYPE_ERROR, "igrac je otisao offline!"), chosenpID[playerid] = -1;
					
				new
					name[24],
					index = Player_ModelToIndex(playerid, modelid);
					
				GetPlayerName(chosenpID[playerid], name, 24);
				chosenpObject[playerid] = index; 
				va_ShowPlayerDialog(playerid, 3556, DIALOG_STYLE_MSGBOX, "Brisanje objekta", "Jeste li sigurni da zelite izbrisati objekat igracu\n%s\nObjekt: %d u slotu: %d?", "Yes", "No", name, modelid, index);
			}
			else
			{
				ResetModelShuntVar(playerid);
				chosenpID[playerid] = -1;
			}
		}
		case ms_DEL_COBJECT:
		{
			if(!response)
				return 1;
			
			DeletePlayerObjectsObject(playerid, Player_ModelToIndex(playerid, modelid));
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Obrisali ste izabrani objekat.");
		}
		case ms_EDIT_COBJECT:
		{	  
			new index = Player_ModelToIndex(playerid, modelid);
			if(IsValidDynamicObject(PlayerObjectsInfo[playerid][index][poObjectid]) && response)
				EditPOObject(playerid, index);
		}
	}
	return 1;
}

hook OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	switch( Bit4_Get( r_PlayerObjectEditState, playerid)) 
	{
		case EDIT_STATE_PREVIEW: 
		{
			switch( response) 
			{
				case EDIT_RESPONSE_FINAL: {
					new Float:playaX, Float:playaY, Float:playaZ;
					GetPlayerPos(playerid, playaX, playaY, playaZ);
					if(floatabs(playaY - fY) > OBJECT_FROM_PLAYER_Y) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijete u visinu stavljati objekte!");
					CreatePlayerObjectsObject(playerid, PlayerPrwsPOModel[playerid], fX, fY, fZ, fRotX, fRotY, fRotZ);
				}
				case EDIT_RESPONSE_CANCEL: {
					if(!IsValidPlayerObject(playerid, objectid) || playerid == INVALID_PLAYER_ID) return 0;
					DestroyPlayerObject(playerid, objectid);
					CancelEdit(playerid);

					PlayerPrwsPOObject[playerid]	= INVALID_OBJECT_ID;
					PlayerPrwsPOIndex[playerid]		= -1;
					PlayerPrwsPOModel[playerid]		= 0;
					Bit4_Set( r_PlayerObjectEditState, playerid, 0);
				}
			}
		}
		case EDIT_STATE_EDIT:
		{
			switch( response)
			{
				case EDIT_RESPONSE_FINAL: SetPlayerObjectsObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
				case EDIT_RESPONSE_CANCEL: {
					if(!IsValidPlayerObject(playerid, objectid) || playerid == INVALID_PLAYER_ID) return 0;
					SetPlayerObjectsObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
					Bit4_Set( r_PlayerObjectEditState, playerid, 0);
				}
			}
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 3556)
    {
        if(response)
        {
            if(!IsPlayerConnected(chosenpID[playerid]))
			    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac je otisao offline!"), chosenpID[playerid] = -1, chosenpObject[playerid] = -1;

			DeletePlayerObjectsObject(chosenpID[playerid], chosenpObject[playerid]);
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Objekt uspjesno obrisan!");
            
            chosenpID[playerid] = -1;
			chosenpObject[playerid] = -1;
            return 1;
        }
        else
        {
			chosenpID[playerid] = -1;
			chosenpObject[playerid] = -1;
			return 0;
        }
    }
    return 0;
}

/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/
/////////////////////////////////////////
CMD:findobjectowner(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni sa koristenje ove komande.");

	new
	    option;

	if(sscanf(params, "d", option))
	    return SendClientMessage(playerid, -1, "KORISTI: /findobjectowner [opcija]"), SendClientMessage(playerid, COLOR_RED, "[!] 0) Klikni na objekat i na�i vlasnika 1) Na�i vlasnika objekta koji se nalazi pokraj tebe");

	if(option > 1 || option < 0)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Opcija mora biti ili 0 ili 1!");
	    
	switch(option)
	{
		case 0:
		{
			SendClientMessage(playerid, -1, "MiSom odaberite objekat od kojeg Zelite izvu�i ime vlasnika i playerid!");
			SelectObject(playerid);
			SendClientMessage(playerid, -1, "MoZete koristiti tipku 'SPACE' kako bi pomicali pogled.");
		}
		case 1:
		{
			new
				po_modelid,
				po_ownerid,
				po_slotid;

			if(GetPlayerObjectsOwner(playerid, po_modelid, po_ownerid, po_slotid))
		    {
		        if(AreAllPObjectSlotsEmpty(po_ownerid))
			    	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi slotovi su prazni!");
				va_SendClientMessage(playerid, COLOR_RED, "[!] Vlasnik ovog objekta [%d] je: %s[%d] i nalazi se u slotu %d!", po_modelid, GetName(po_ownerid, false), po_ownerid, po_slotid);
		    }
		    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu nikojeg objekta!");
		}
	}
	return 1;
}

CMD:editobject(playerid, params[])
{
	if(PlayerJail[playerid][pJailed])
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno ne moZete koristiti ovu komandu!");

	if(AreAllPObjectSlotsEmpty(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi slotovi su prazni!");
		
	foreach(new i: PlayerCreateObjects[playerid])
	{
		if(!PlayerObjectsInfo[playerid][i][poPlaced]) continue;
		fselection_add_item(playerid, PlayerObjectsInfo[playerid][i][poModelid]);
		Player_ModelToIndexSet(playerid, i, PlayerObjectsInfo[playerid][i][poModelid]);
	}
	fselection_show(playerid, ms_EDIT_COBJECT, "Edit object:");
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Odaberi objekat koji zelis editati!");
	return 1;
}

CMD:approveobjects(playerid, params[]) 
{
	if(PlayerInfo[playerid][pAdmin] < 3) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
	new 
		giveplayerid;	
    if(sscanf(params, "u", giveplayerid)) 
		return SendClientMessage(playerid, COLOR_RED, "[?]: /approveobjects [ID / Part of name]");
    if(!IsPlayerConnected(giveplayerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Wrong player ID input!");
	
	CreateObjReq[giveplayerid] = !CreateObjReq[giveplayerid];
	
	SendFormatMessage(giveplayerid, 
		MESSAGE_TYPE_INFO, "Game Admin %s has %s you to use /createobject.", 
		GetName(playerid, false),
		(CreateObjReq[giveplayerid]) ? ("allowed") : ("forbid")
	);
	SendAdminMessage(COLOR_LIGHTBLUE, 
		"AdmCMD: %s has %s %s to use /createobject.", 
		GetName(playerid,false),
		(CreateObjReq[giveplayerid]) ? ("allowed") : ("forbid"),
		GetName(giveplayerid,false)
	);
	return 1;
}

CMD:createobject(playerid, params[])
{
	if(PlayerJail[playerid][pJailed])
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno ne mozete koristiti ovu komandu!");
				
	if(!CreateObjReq[playerid]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dozvolu od admina za /createobject komandu.");

	if(isnull(params))
	{
		for(new i = 0; i < sizeof(objects); i++)
		{
			fselection_add_item(playerid, objects[i]);
		}
		fselection_show(playerid, ms_CREATE_COBJECT, "Create object:");
	}
	else
	{
	    if(!PlayerInfo[playerid][pAdmin]) return 1;

		new
			Float:x,
			Float:y,
			Float:z;
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, 3.0);
		CreatePlayerObjectsObject(playerid, strval(params), x, y, z, 0.0, 0.0, 0.0);
	}
	return 1;
}

CMD:aremoveallplayerobjects(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni sa koristenje ove komande.");

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_RED, "[?]: /aremoveallplayerobjects [playerid]");
	    
	new giveplayerid = strval(params);
	    
	if(!IsPlayerConnected(giveplayerid))
	    return SendClientMessage(playerid,COLOR_RED, "Taj igrac nije online!");
	    
    if(AreAllPObjectSlotsEmpty(giveplayerid))
   		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nema spawnane objekte!");

	foreach(new i: PlayerCreateObjects[giveplayerid])
	{
		if(PlayerObjectsInfo[giveplayerid][i][poPlaced]) 
			DeletePlayerObjectsObject(giveplayerid, i, false);
	}
	Iter_Clear(PlayerCreateObjects[giveplayerid]);

	SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste izbrisali sve spawnane objekte odabranom igracu!");
	va_SendClientMessage(giveplayerid, COLOR_RED, "[!]: Game Admin %s deleted all your created objects.", GetName(playerid, false));
	return 1;
}

CMD:checkplayerobjects(playerid, params[]) {

	if(!PlayerInfo[playerid][pAdmin])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni sa koristenje ove komande.");

	new
		giveplayerid,
		string[128],
		po_name[24];
		
	if(sscanf(params, "u", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /checkplayerobjects [playerid / Part of name]");

	if(!IsPlayerConnected(giveplayerid))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online.");
		
 	if(AreAllPObjectSlotsEmpty(giveplayerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nema spawnanih objekata!");

	GetPlayerName(giveplayerid, po_name, 24);
	
	chosenpID[playerid] = giveplayerid;
	format(string, sizeof(string), "Trenutno gledate spawnane objekte od igraca: %s[%d]!", po_name, giveplayerid);
	SendClientMessage(playerid, COLOR_WHITE, string);

	foreach(new i: PlayerCreateObjects[giveplayerid])
	{
		if(!PlayerObjectsInfo[giveplayerid][i][poPlaced]) continue;
		fselection_add_item(playerid, PlayerObjectsInfo[giveplayerid][i][poModelid]);
		Player_ModelToIndexSet(playerid, i, PlayerObjectsInfo[playerid][i][poModelid]);
	}
	fselection_show(playerid, ms_ADMIN_DEL_COBJECT, "Delete object:");
	return 1;
}

CMD:deleteobject( playerid, params[])
{
	if(AreAllPObjectSlotsEmpty(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi slotovi su prazni!");

	foreach(new i: PlayerCreateObjects[playerid])
	{
		if(!PlayerObjectsInfo[playerid][i][poPlaced]) continue;
		fselection_add_item(playerid, PlayerObjectsInfo[playerid][i][poModelid]);
		Player_ModelToIndexSet(playerid, i, PlayerObjectsInfo[playerid][i][poModelid]);
	}
	fselection_show(playerid, ms_DEL_COBJECT, "Delete object:");
	return 1;
}
