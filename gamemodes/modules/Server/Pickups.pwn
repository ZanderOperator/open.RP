/*
	######## ##    ## ##     ## ##     ## 
	##       ###   ## ##     ## ###   ### 
	##       ####  ## ##     ## #### #### 
	######   ## ## ## ##     ## ## ### ## 
	##       ##  #### ##     ## ##     ## 
	##       ##   ### ##     ## ##     ## 
	######## ##    ##  #######  ##     ## 
*/
enum E_PICKUP_INFO
{
	epSQLID,
	epID,
	epPickupModel,
	epPickupType,
	epCanEnter,
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
stock	
	PickupInfo[MAX_PICKUP][E_PICKUP_INFO];

// Vars
new
	NewPickupID[MAX_PLAYERS];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ###### 
*/
stock LoadPickups()
{
	mysql_tquery(g_SQL, "SELECT * FROM server_pickups WHERE 1", "OnPickupsLoad");
	return 1;
}

forward OnPickupCreate(pickupid);
public OnPickupCreate(pickupid)
	PickupInfo[pickupid][epSQLID] = cache_insert_id();

forward OnPickupsLoad();
public OnPickupsLoad() 
{
	new
		value[ 64 ],
		count;	
	cache_get_row_count(count);
	if( !count ) return printf("MySQL Report: No pickups exist to load.");
 	for(new b = 0; b < count; b++) {
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
		cache_get_value_name(b, "enterdiscription", value); 		
		format(PickupInfo[b][epEnterDiscription], 64, value);
		cache_get_value_name(b, "discription", value); 						
		format(PickupInfo[b][epDiscription], 64, value);
		cache_get_value_name_int(b, "viwo"				, PickupInfo[b][epViwo]);
		cache_get_value_name_int(b, "organizations"		, PickupInfo[b][epOrganizations]);
		cache_get_value_name_int(b, "job"				, PickupInfo[b][epJob]);
		cache_get_value_name_int(b, "pint"				, PickupInfo[b][epInt]);
		cache_get_value_name_int(b, "enterInt"			, PickupInfo[b][epEnterInt]);
		cache_get_value_name_int(b, "enterViwo"			, PickupInfo[b][epEnterViwo]);

		PickupInfo[b][epID] = CreateDynamicPickup(PickupInfo[b][epPickupModel], PickupInfo[b][epPickupType], PickupInfo[b][epEntrancex], PickupInfo[b][epEntrancey], PickupInfo[b][epEntrancez], -1, -1, -1, 80.0);
		Iter_Add(Pickups, b);
	}
	printf("MySQL Report: Pickups Loaded (%d)!", Iter_Count(Pickups));
	return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	foreach(new b : Pickups)
	{
		if( PickupInfo[b][epID] == pickupid ) {
			GameTextForPlayer(playerid, PickupInfo[b][epEnterDiscription], 3100, 5);
			break;
		}
	}
	return 1;
}

//Pickups
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
}

stock static CreateNewPickup(playerid, pickup)
{
	new
		bigquery[556];
	mysql_tquery(g_SQL, "BEGIN", "");
	
	format(bigquery, sizeof(bigquery), "INSERT INTO server_pickups (`pickupmodel`,`pickuptype`,`canenter`,`entrancex`, `entrancey`, `entrancez`,`exitx`,`exity`,`exitz`,`enterdiscription`, `discription`, `viwo`, `organizations`, `job`, `pint`) VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%q', '%q', '%d', '%d', '%d', '%d')",
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
	);
	mysql_tquery(g_SQL, bigquery, "OnPickupCreate", "i", pickup);
	mysql_tquery(g_SQL, "COMMIT", "");
		
    PickupInfo[pickup][ epID ] = CreateDynamicPickup(PickupInfo[pickup][epPickupModel], PickupInfo[pickup][epPickupType], PickupInfo[pickup][epEntrancex], PickupInfo[pickup][epEntrancey], PickupInfo[pickup][epEntrancez], -1, -1, -1);
	Iter_Add(Pickups, pickup);
    NewPickupID[playerid] = 0;
    return 1;
}

stock static GetPickupID()
{
	new
	    index = -1;
	for(new i=1; i<MAX_PICKUP;i++)
	{
	    if( !PickupInfo[i][epSQLID] ) {
		    index = i;
		    break;
		}
	}
	return index;
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

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid ) 
	{
		case DIALOG_DYN_PEDISC: {
			if(!response) ClearInputsPick(playerid);
			if(strlen(inputtext) < 2) return SendClientMessage(playerid, COLOR_WHITE, "Enter discription koje ste unijeli nije valjano! (Premalo znakova)");

			format(PickupInfo[ NewPickupID[playerid] ][ epEnterDiscription ], 128, inputtext);
			ShowPlayerDialog(playerid, DIALOG_DYN_PDISC, DIALOG_STYLE_INPUT, "PICKUP DESCRIPTION", "Unesi pickup description:", "Unesi", "Odustani");
			return 1;
		}
		case DIALOG_DYN_PDISC: {
			if(!response) ShowPlayerDialog(playerid, DIALOG_DYN_PEDISC, DIALOG_STYLE_INPUT, "Enter discription", "Unesi enter discription:", "Unesi", "Odustani");
			if(strlen(inputtext) < 2)
			{
				SendClientMessage(playerid, COLOR_WHITE, "Enter discription koje ste unijeli nije valjano! (Premalo znakova)");
				return 1;
			}

			format(PickupInfo[ NewPickupID[playerid] ][ epDiscription ], 128, inputtext);
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
	    viwo,org,job,interior)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /createpickup [model][type][canenter][exitx][exity][exitz][viwo][org][job][int]");
    NewPickupID[playerid] = GetPickupID();
	if(NewPickupID[playerid] >= (MAX_PICKUP-1)) {
		SendClientMessage(playerid, COLOR_RED, "MySQL: Baza je puna! Povecajte MAX_PICKUP u 'defines.inc'!");
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
 	
	ShowPlayerDialog(playerid, DIALOG_DYN_PEDISC, DIALOG_STYLE_INPUT, "Enter discription", "Unesi enter discription:", "Unesi", "Odustani");
	return 1;
}
CMD:deletepickup(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi ovlasten za koristenje komande!");
	new 
		pickup = -1;
	foreach(new i:Pickups) {
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, PickupInfo[i][epEntrancex], PickupInfo[i][epEntrancey], PickupInfo[i][epEntrancez])) {
			pickup = i;
			break;
		}
	}
	if(pickup == -1) return SendClientMessage(playerid, COLOR_RED, "Nema pickupova u tvojoj blizini!");
	
	PickupInfo[pickup][epPickupModel] 	= 0;
	PickupInfo[pickup][epEntrancex] 	= 0.0;
	PickupInfo[pickup][epEntrancey] 	= 0.0;
	PickupInfo[pickup][epEntrancez] 	= 0.0;
	PickupInfo[pickup][epExitx] 		= 0.0;
	PickupInfo[pickup][epExity] 		= 0.0;
	PickupInfo[pickup][epExitz] 		= 0.0;
	
	new
		bigquery[128];
	format(bigquery, sizeof(bigquery), "DELETE FROM server_pickups WHERE `id` = '%d'", PickupInfo[pickup][epSQLID]);
	mysql_tquery(g_SQL,bigquery,"");
	
	DestroyDynamicPickup(PickupInfo[pickup][epID]);
	return 1;
}
CMD:pickupint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
	
	new 
		pickup, viwo,
		Float:X, Float:Y, Float:Z;
    if(sscanf(params, "ifffi", pickup, X, Y, Z, viwo)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /pickupint [pickup][x][y][z][viwo]");
	
	PickupInfo[pickup][epExitx] = X;
	PickupInfo[pickup][epExity] = Y;
	PickupInfo[pickup][epExitz] = Z;
	PickupInfo[pickup][epViwo] = viwo;
	
	new
		bigquery[ 512 ];
	format(bigquery, sizeof(bigquery), "UPDATE server_pickups SET `exitx` = '%f', `exity` = '%f', `exitz` = '%f', `viwo` = '%d' WHERE `id` = '%d'",
		PickupInfo[pickup][epExitx],
		PickupInfo[pickup][epExity],
		PickupInfo[pickup][epExitz],
		PickupInfo[pickup][epViwo],
		PickupInfo[pickup][epSQLID]
	);

	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si promjenio interier na odabranom pickupu!");
	return 1;
}
