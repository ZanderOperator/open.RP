#include <YSI_Coding\y_hooks>

static 
	Iterator:Pickup[MAX_PICKUP_TYPES] <MAX_DYNAMIC_PICKUPS>;


enum E_PICKUP_INFO
{
	epSQLID,
	epID,
	epPickupModel,
	epPickupType,
	epCanEnter,
	epEnterCP,
	Float:epEntrancex,
	Float:epEntrancey,
	Float:epEntrancez,
	Float:epExitx,
	Float:epExity,
	Float:epExitz,
	epEnterDiscription[128],
	epDiscription[128],
	epViwo,
	epOrganizations,
	epJob,
	epInt,
	epEnterInt,
	epEnterViwo
}
new	
	PickupInfo[MAX_DYNAMIC_PICKUPS][E_PICKUP_INFO];

static
	Iterator:PickupsIter<MAX_DYNAMIC_PICKUPS>,
	NewPickupID[MAX_PLAYERS],
	InPickup[MAX_PLAYERS] = {-1, ...},
	InfrontPickup[MAX_PLAYERS] = {-1, ...},
	PickupCP[MAX_PLAYERS] = {-1, ...};

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ###### 
*/

bool:Pickup_Exists(type, pickupid)
{
	return Iter_Contains(Pickup[type], pickupid);
}

Player_InPickup(playerid)
{
    return InPickup[playerid];
}

Player_SetInPickup(playerid, v)
{
    InPickup[playerid] = v;
}

Player_InfrontPickup(playerid)
{
    return InfrontPickup[playerid];
}

Player_SetInfrontPickup(playerid, v)
{
    InfrontPickup[playerid] = v;
}

Player_GetPickupCP(playerid)
{
    return PickupCP[playerid];
}

Player_SetPickupCP(playerid, v)
{
    PickupCP[playerid] = v;
}

stock LoadPickups()
{
	mysql_pquery(g_SQL, "SELECT * FROM server_pickups WHERE 1", "OnPickupsLoad");
	return 1;
}

forward OnPickupCreate(pickupid);
public OnPickupCreate(pickupid)
	PickupInfo[pickupid][epSQLID] = cache_insert_id();

forward OnPickupsLoad();
public OnPickupsLoad() 
{
	new
		count = cache_num_rows();	

	if(!count ) 
		return print("MySQL Report: No pickups exist to load.");

 	for(new b = 0; b < count; b++) 
	 {
		cache_get_value_name_int(b, 	"id"			, PickupInfo[b][epSQLID]);
		cache_get_value_name_int(b, 	"pickupmodel"	, PickupInfo[b][epPickupModel]);
		cache_get_value_name_int(b, 	"pickuptype"	, PickupInfo[b][epPickupType]);
		cache_get_value_name_int(b, 	"canenter"		, PickupInfo[b][epCanEnter]);
		cache_get_value_name_float(b, 	"entrancex"		, PickupInfo[b][epEntrancex]);
		cache_get_value_name_float(b, 	"entrancey"		, PickupInfo[b][epEntrancey]);
		cache_get_value_name_float(b, 	"entrancez"		, PickupInfo[b][epEntrancez]);
		cache_get_value_name_float(b, 	"exitx"			, PickupInfo[b][epExitx]);
		cache_get_value_name_float(b, 	"exity"			, PickupInfo[b][epExity]);
		cache_get_value_name_float(b, 	"exitz"			, PickupInfo[b][epExitz]);
		cache_get_value_name(b, "enterdiscription", PickupInfo[b][epEnterDiscription], 64); 		
		cache_get_value_name(b, "discription", PickupInfo[b][epDiscription], 64); 						
		cache_get_value_name_int(b, "viwo"				, PickupInfo[b][epViwo]);
		cache_get_value_name_int(b, "organizations"		, PickupInfo[b][epOrganizations]);
		cache_get_value_name_int(b, "job"				, PickupInfo[b][epJob]);
		cache_get_value_name_int(b, "pint"				, PickupInfo[b][epInt]);
		cache_get_value_name_int(b, "enterInt"			, PickupInfo[b][epEnterInt]);
		cache_get_value_name_int(b, "enterViwo"			, PickupInfo[b][epEnterViwo]);

		PickupInfo[b][epID] = CreateDynamicPickup(PickupInfo[b][epPickupModel], PickupInfo[b][epPickupType], PickupInfo[b][epEntrancex], PickupInfo[b][epEntrancey], PickupInfo[b][epEntrancez], -1, -1, -1, 80.0);
		Iter_Add(PickupsIter, b);
		if(PickupInfo[b][epCanEnter])
		{
			CreatePickupEnter(b);
			Iter_Add(Pickup[PICKUP_TYPE_ENTERABLE], b);
		}
		else Iter_Add(Pickup[PICKUP_TYPE_NON_ENTERABLE], b);
	}
	printf("MySQL Report: Pickups Loaded. [%d/%d]", Iter_Count(PickupsIter), MAX_PICKUPS);
	return 1;
}

CheckPlayerPickupInt(playerid, int, viwo)
{
	foreach(new pickup: Pickup[PICKUP_TYPE_ENTERABLE])
	{
		if(IsPlayerInRangeOfPoint(playerid, 250.0, PickupInfo[pickup][epExitx],PickupInfo[pickup][epExity],PickupInfo[pickup][epExitz]) 
			&& PickupInfo[pickup][epInt] == int 
			&& PickupInfo[pickup][epViwo] == viwo)
		{
			Player_SetInPickup(playerid, pickup);
			break;
		}
	}
	return 1;
}

stock CP_GetPickupID(checkpointid)
{
    new pickupid = -1;
    foreach(new pickup: Pickup[PICKUP_TYPE_ENTERABLE])
    {
        if(PickupInfo[pickup][epEnterCP] == checkpointid)
        {
            pickupid = pickup;
            break;
        }
    }
    return pickupid;
}

static CreatePickupEnter(pid)
{
	if(!PickupInfo[pid][epCanEnter])
		return 1;

    if(IsValidDynamicCP(PickupInfo[pid][epEnterCP]))
        DestroyDynamicCP(PickupInfo[pid][epEnterCP]);
    
	PickupInfo[pid][epEnterCP] = CreateDynamicCP(PickupInfo[pid][epEntrancex], PickupInfo[pid][epEntrancey], PickupInfo[pid][epEntrancez]-1.0, 2.0, -1, -1, -1, 5.0);
    return 1;
}

stock static ClearInputsPick(playerid)
{
    new
	    pickup = NewPickupID[playerid];
		
    PickupInfo[pickup][epPickupModel] 		= 0;
	PickupInfo[pickup][epPickupType]		= 0;
	PickupInfo[pickup][epCanEnter] 			= 0;
	PickupInfo[pickup][epExitx] 			= 0;
	PickupInfo[pickup][epExity] 			= 0;
	PickupInfo[pickup][epExitz] 			= 0;
	PickupInfo[pickup][epViwo] 				= 0;
	PickupInfo[pickup][epOrganizations] 	= 0;
	PickupInfo[pickup][epJob] 				= 0;
	PickupInfo[pickup][epInt] 				= 0;
 	PickupInfo[pickup][epEntrancex] 		= 0.0;
	PickupInfo[pickup][epEntrancey] 		= 0.0;
	PickupInfo[pickup][epEntrancez] 		= 0.0;
	NewPickupID[playerid] = 0;
	return 1;
}

stock static CreateNewPickup(playerid, pickup)
{
	mysql_pquery(g_SQL, "BEGIN");

	mysql_pquery(g_SQL,
		va_fquery(g_SQL,
			"INSERT INTO server_pickups (pickupmodel,pickuptype,canenter,\n\
				entrancex, entrancey, entrancez,exitx,exity,exitz,enterdiscription, discription, viwo, organizations, job, pint) \n\
				VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%e', '%e', '%d', '%d', '%d', '%d')",
			PickupInfo[pickup][epPickupModel],
			PickupInfo[pickup][epPickupType],
			PickupInfo[pickup][epCanEnter],
			PickupInfo[pickup][epEntrancex],
			PickupInfo[pickup][epEntrancey],
			PickupInfo[pickup][epEntrancez],
			PickupInfo[pickup][epExitx],
			PickupInfo[pickup][epExity],
			PickupInfo[pickup][epExitz],
			PickupInfo[pickup][epEnterDiscription],
			PickupInfo[pickup][epDiscription],
			PickupInfo[pickup][epViwo],
			PickupInfo[pickup][epOrganizations],
			PickupInfo[pickup][epJob],
			PickupInfo[pickup][epInt]
		),
	 	"OnPickupCreate", 
		"i", 
		pickup
	);
	mysql_pquery(g_SQL, "COMMIT");
		
    PickupInfo[pickup][epID] = CreateDynamicPickup(PickupInfo[pickup][epPickupModel], PickupInfo[pickup][epPickupType], PickupInfo[pickup][epEntrancex], PickupInfo[pickup][epEntrancey], PickupInfo[pickup][epEntrancez], -1, -1, -1);
	
	Iter_Add(PickupsIter, pickup);
	if(PickupInfo[pickup][epCanEnter])
	{
		CreatePickupEnter(pickup);
		Iter_Add(Pickup[PICKUP_TYPE_ENTERABLE], pickup);
	}
	else Iter_Add(Pickup[PICKUP_TYPE_NON_ENTERABLE], pickup);

    NewPickupID[playerid] = 0;
    return 1;
}

stock static GetPickupID()
{	
	return Iter_Free(PickupsIter);
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

hook function LoadServerData()
{
	LoadPickups();
	return continue();

}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    new pickupid = CP_GetPickupID(checkpointid);
    if(!Iter_Contains(Pickup[PICKUP_TYPE_ENTERABLE], pickupid))
        return 1;

	GameTextForPlayer(playerid, PickupInfo[pickupid][epEnterDiscription], 3100, 5);

    Player_SetPickupCP(playerid, checkpointid);
    Player_SetInfrontPickup(playerid, pickupid);
    return 1;
}

hook OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
    new 
        pickupid = CP_GetBizzID(checkpointid);
    
    if(!Iter_Contains(Pickup[PICKUP_TYPE_ENTERABLE], pickupid))
        return 1;

    Player_SetPickupCP(playerid, -1);
    Player_SetInfrontPickup(playerid, -1);
    return 1;
}


hook function ResetPlayerVariables(playerid)
{
	Player_SetInPickup(playerid, -1);
	Player_SetInfrontPickup(playerid, -1);
	Player_SetPickupCP(playerid, -1);
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) 
	{
		case DIALOG_DYN_PEDISC: 
		{
			if(!response) 
				return ClearInputsPick(playerid);
			if(strlen(inputtext) < 2) 
				return SendClientMessage(playerid, COLOR_WHITE, "Enter discription koje ste unijeli nije valjano! (Premalo znakova)");

			format(PickupInfo[NewPickupID[playerid]][epEnterDiscription], 128, inputtext);
			ShowPlayerDialog(playerid, DIALOG_DYN_PDISC, DIALOG_STYLE_INPUT, "PICKUP DESCRIPTION", "Unesi pickup description:", "Input", "Abort");
			return 1;
		}
		case DIALOG_DYN_PDISC: 
		{
			if(!response) 
				return ShowPlayerDialog(playerid, DIALOG_DYN_PEDISC, DIALOG_STYLE_INPUT, "Enter discription", "Unesi enter discription:", "Input", "Abort");
			if(strlen(inputtext) < 2)
			{
				SendClientMessage(playerid, COLOR_WHITE, "Enter discription koje ste unijeli nije valjano! (Premalo znakova)");
				return 1;
			}

			format(PickupInfo[NewPickupID[playerid]][epDiscription], 128, inputtext);
			CreateNewPickup(playerid,NewPickupID[playerid]);
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

CMD:createpickup(playerid, params[])
{
	new
	    model,type,canenter,Float:exitx,Float:exity,Float:exitz,
	    viwo,org,job,interior;
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje komande!");
	if(sscanf(params, "iiifffiiii", model,type,canenter,exitx,exity,exitz, \
	    viwo,org,job,interior)) return SendClientMessage(playerid, COLOR_RED, "[?]: /createpickup [model][type][canenter][exitx][exity][exitz][viwo][org][job][int]");
    
	NewPickupID[playerid] = GetPickupID();

	if(NewPickupID[playerid] >= (MAX_DYNAMIC_PICKUPS-1)) 
	{
		SendClientMessage(playerid, COLOR_RED, "MySQL: Baza je puna! Povecajte MAX_DYNAMIC_PICKUPS u 'defines.inc'!");
		NewPickupID[playerid] = -1;
		return 1;
 	}
	new
	    pickup = NewPickupID[playerid];
    
	PickupInfo[pickup][epPickupModel] 		= model;
	PickupInfo[pickup][epPickupType] 		= type;
	PickupInfo[pickup][epCanEnter] 			= canenter;
	PickupInfo[pickup][epExitx] 			= exitx;
	PickupInfo[pickup][epExity] 			= exity;
	PickupInfo[pickup][epExitz] 			= exitz;
	PickupInfo[pickup][epViwo] 				= viwo;
	PickupInfo[pickup][epOrganizations] 	= org;
	PickupInfo[pickup][epJob] 				= job;
	PickupInfo[pickup][epInt] 				= interior;
 	GetPlayerPos(playerid,PickupInfo[pickup][epEntrancex],PickupInfo[pickup][epEntrancey],PickupInfo[pickup][epEntrancez]);
 	
	ShowPlayerDialog(playerid, DIALOG_DYN_PEDISC, DIALOG_STYLE_INPUT, "Enter discription", "Unesi enter discription:", "Input", "Abort");
	return 1;
}
CMD:deletepickup(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje komande!");
	
	new pickup = Player_InfrontPickup(playerid);
	if(pickup == -1) 
		return SendClientMessage(playerid, COLOR_RED, "Niste blizu pickupa!");

	Iter_Remove(PickupsIter, pickup);
	if(PickupInfo[pickup][epCanEnter])
		Iter_Remove(Pickup[PICKUP_TYPE_ENTERABLE], pickup);
	else Iter_Remove(Pickup[PICKUP_TYPE_NON_ENTERABLE], pickup);

	PickupInfo[pickup][epPickupModel] 	= 0;
	PickupInfo[pickup][epEntrancex] 	= 0.0;
	PickupInfo[pickup][epEntrancey] 	= 0.0;
	PickupInfo[pickup][epEntrancez] 	= 0.0;
	PickupInfo[pickup][epExitx] 		= 0.0;
	PickupInfo[pickup][epExity] 		= 0.0;
	PickupInfo[pickup][epExitz] 		= 0.0;
	
	mysql_fquery(g_SQL, "DELETE FROM server_pickups WHERE id = '%d'", PickupInfo[pickup][epSQLID]);
	
	DestroyDynamicPickup(PickupInfo[pickup][epID]);

	if(IsValidDynamicCP(PickupInfo[pickup][epEnterCP]))
        DestroyDynamicCP(PickupInfo[pickup][epEnterCP]);

	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Pickup je uspjesno unisten!");
	return 1;
}
CMD:pickupint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
	
	new 
		pickup, viwo,
		Float:X, Float:Y, Float:Z;
    if(sscanf(params, "ifffi", pickup, X, Y, Z, viwo)) return SendClientMessage(playerid, COLOR_RED, "[?]: /pickupint [pickup][x][y][z][viwo]");
	
	PickupInfo[pickup][epExitx] = X;
	PickupInfo[pickup][epExity] = Y;
	PickupInfo[pickup][epExitz] = Z;
	PickupInfo[pickup][epViwo] = viwo;
	
	new
		bigquery[512];
	format(bigquery, sizeof(bigquery), "UPDATE server_pickups SET exitx = '%f', exity = '%f', exitz = '%f', viwo = '%d' WHERE id = '%d'",
		PickupInfo[pickup][epExitx],
		PickupInfo[pickup][epExity],
		PickupInfo[pickup][epExitz],
		PickupInfo[pickup][epViwo],
		PickupInfo[pickup][epSQLID]
	);

	SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno si promjenio interier na odabranom pickupu!");
	return 1;
}
