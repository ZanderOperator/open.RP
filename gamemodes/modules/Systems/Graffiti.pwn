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
// Ints
#define MAX_GRAFS							(500)
#define MAX_TAGS							(100)
#define MAX_GRAFFIT_INPUT					(32)

// Tagids
#define GROVE_TAG   						18659
#define SEVILLE_TAG							18660
#define VARRIORS_TAG						18661
#define KILO_TAG							18662
#define AZTECA_TAG 							18663
#define TEMPLE_TAG							18664
#define VAGOS_TAG							18665
#define BALLAS_TAG  						18666
#define RBALLAS_TAG                 		18667

// Floats
#define GRAFFIT_DRAW_DISTANCE				70.0
#define GRAFFIT_CHECKPOINT_SIZE				1.5
#define GRAFFIT_SPRAYING_UP					5.5

// Editing index
#define EDIT_GRAFFIT						(1)
#define EDIT_SPRAYTAG						(2)
/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/

enum E_GRAFFITI_DATA {
	gId,
	gObject,
	gText[32],
	gFont,
	gFontSize,
	gColor,
	Float:gPosX,
	Float:gPosY,
	Float:gPosZ,
	Float:gRotX,
	Float:gRotY,
	Float:gRotZ,
	gAuthor[MAX_PLAYER_NAME]
}
static stock 
	GraffitInfo[MAX_GRAFS][E_GRAFFITI_DATA];

enum E_GRAFFITI_CP_DATA {
	gCPId,
	Float:gCPX,
	Float:gCPY,
	Float:gCPZ,
	Float:gProgress
}

static stock 
	GraffitCPInfo[MAX_PLAYERS][E_GRAFFITI_CP_DATA];

enum E_FACTION_TAGS_DATA {
	ftTagCount
}
static stock 
	FactionTagCount[ MAX_FACTIONS ][E_FACTION_TAGS_DATA];

enum E_TAG_DATA
{
	tId,
	tModelid,
	tgObject,
	Float:tPosX,
	Float:tPosY,
	Float:tPosZ,
	Float:tRotX,
	Float:tRotY,
	Float:tRotZ,
	tFaction,
	tAuthor[MAX_PLAYER_NAME]
}
static stock
	TagInfo[MAX_TAGS][E_TAG_DATA];

enum E_TAG_CP_DATA
{
	tCPId,
	Float:tCPX,
	Float:tCPY,
	Float:tCPZ,
	Float:tProgress
}
static stock
	TagCPInfo[MAX_TAGS][E_TAG_CP_DATA];
	
/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
	
// Iters
new
	Iterator:Graffits<MAX_GRAFS>,
	Iterator:SprayTags<MAX_TAGS>;	

// rBits
new
	Bit1:  r_GrafCreateStarted 	<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1:  r_TaggCreateStarted 	<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1:  r_TagEditStarted 	<MAX_PLAYERS> = { Bit1: false, ... },
	Bit1:  r_GraffitEditStarted <MAX_PLAYERS> = { Bit1: false, ... },
	Bit1:  r_GrafApprove 		<MAX_PLAYERS> = { Bit1: false, ... };
	
// 32 bit
new
	LastPlayerTag[ MAX_PLAYERS ],
	LastPlayerGraffiti[ MAX_PLAYERS ],
	GraffitiObjectEdit[ MAX_PLAYERS ],
	EditingGraffitiIndex[ MAX_PLAYERS ],
	PlayerBar:gProgressBar[ MAX_PLAYERS ],
	PlayerBar:tProgressBar[ MAX_PLAYERS ];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
//Grafiti
stock LoadGraffits()
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "SELECT * FROM graffiti WHERE 1 LIMIT 0,%d", MAX_GRAFS);
	mysql_tquery(g_SQL, tmpQuery, "OnGraffitsLoad");
	return 1;
}

forward OnGraffitsLoad();
public OnGraffitsLoad()
{
	new rows  = cache_num_rows();	
	if( rows ) {
		new 
			tmp[ 32 ];
		for(new b = 0; b < rows; b++) {
			cache_get_value_name_int(b, 		"id",		GraffitInfo[ b ][ gId ]);
			cache_get_value_name(b, "text", tmp );
			format(GraffitInfo[ b ][ gText ] , 32, tmp);
			cache_get_value_name_int(b, 		"font"		, GraffitInfo[ b ][ gFont ]);
			cache_get_value_name_int(b, 		"fontsize"	, GraffitInfo[ b ][ gFontSize ]);
			cache_get_value_name_int(b, 		"fontcolor"	, GraffitInfo[ b ][ gColor ]);
			cache_get_value_name_float(b, 		"posx"		, GraffitInfo[ b ][ gPosX ]);
			cache_get_value_name_float(b, 		"posy"		, GraffitInfo[ b ][ gPosY ]);
			cache_get_value_name_float(b, 		"posz"		, GraffitInfo[ b ][ gPosZ ]);
			cache_get_value_name_float(b, 		"rotx"		, GraffitInfo[ b ][ gRotX ]);
			cache_get_value_name_float(b, 		"roty"		, GraffitInfo[ b ][ gRotY ]);
			cache_get_value_name_float(b, 		"rotz"		, GraffitInfo[ b ][ gRotZ ]);
			cache_get_value_name(b, "author", tmp);
			format( GraffitInfo[ b ][ gAuthor ] , 32, tmp );
			
			GraffitInfo[b][gObject] = CreateDynamicObject(GROVE_TAG,GraffitInfo[b][gPosX],GraffitInfo[b][gPosY],GraffitInfo[b][gPosZ],GraffitInfo[b][gRotX],GraffitInfo[b][gRotY],GraffitInfo[b][gRotZ],0,0,-1,GRAFFIT_DRAW_DISTANCE);
			SetDynamicObjectMaterialText(GraffitInfo[b][gObject], 0, GraffitInfo[b][gText], OBJECT_MATERIAL_SIZE_512x256, GetGrafFont(GraffitInfo[b][gFont]), GraffitInfo[b][gFontSize], 0, GetGrafColor(GraffitInfo[b][gColor]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			Iter_Add(Graffits, b);
		}
		printf("MySQL Report: Graffits Loaded (%d)!", Iter_Count(Graffits));
	} else printf("MySQL Report: No graffits exist to load.");
	return 1;
}

forward OnGraffitCreate(grafid);
public OnGraffitCreate(grafid)
	GraffitInfo[ grafid ][ gId ] = cache_insert_id();

stock GetGraffitIdFromPlaya(playerid, Float:radius)
{
	new id = -1;
	foreach(new i : Graffits) {
		if( GetPlayerDistanceFromPoint(playerid, GraffitInfo[i][gPosX], GraffitInfo[i][gPosY], GraffitInfo[i][gPosZ]) <= radius) {
			id = i;
			break;
		}
	}
	return id;
}
stock GetPlayersGraffit(playerid, objectid, Float:radius)
{
	new 
		Float:X, Float:Y, Float:Z,
		id = -1;
	GetDynamicObjectPos(objectid, X, Y, Z);
	
	foreach(new i : Graffits) {
		if(GetPlayerDistanceFromPoint(playerid, X,Y,Z) <= radius) {
			id = i;
			break;
		}
	}
	return id;
}
stock GetPlayersSprayTag(playerid, objectid, Float:radius)
{
	new 
		Float:X, Float:Y, Float:Z,
		id = -1;
	GetDynamicObjectPos(objectid, X, Y, Z);
	
	foreach(new i : SprayTags) {
		if(GetPlayerDistanceFromPoint(playerid, X,Y,Z) <= radius) {
			id = i;
			break;
		}
	}
	return id;
}
stock GetGrafFont(fontid)
{
	new font[26];
	switch(fontid) {
		case 1:
			format(font, 26, "Arial");
		case 2:
			format(font, 26, "a dripping marker");
		case 3:
			format(font, 26, "Sick Capital Vice");
		case 4:
			format(font, 26, "Eastside Motel");
		case 5:
			format(font, 26, "Whoa!");
		case 6:
			format(font, 26, "juanalzada");
		case 7:
			format(font, 26, "URBAN HOOK-UPZ");
		case 8:
			format(font, 26, "Amsterdam graffiti");
		case 9:
			format(font, 26, "Old English Text MT");
		case 10:
			format(font, 26, "Stylin' BRK");
		case 11:
			format(font, 26, "Painterz");
		case 12:
			format(font, 26, "Freight Train Gangsta");
	}
	return font;
}
stock GetGrafColor(colorid)
{
	new color;
	switch(colorid) {
		case 1:
			color = 0xFF000000;
		case 2:
			color = 0xFFFFFFFF;
		case 3:
			color = 0xFF0500FF;
		case 4:
			color = 0xFF3C82FF;
		case 5:
			color = 0xFF329D32;
		case 6:
			color = 0xFFBE0A0A;
		case 7:
			color = 0xFF502800;
		case 8:
			color = 0xFFFF732D;
		case 9:
			color = 0xFFFFD700;
		case 10:
			color = 0xFFC0C0C0;
	}
	return color;
}
stock InsertGraffitIntoDB(grafid)
{
    mysql_tquery(g_SQL, "BEGIN", "");
	new
		tmpQuery[ 256 ];
	mysql_format(g_SQL, tmpQuery, 256, "INSERT INTO `graffiti` (`text`,`font`,`fontsize`,`fontcolor`,`posx`,`posy`,`posz`,`rotx`,`roty`,`rotz`,`author`) VALUES ('%e','%d','%d','%d','%f','%f','%f','%f','%f','%f','%e')",
		GraffitInfo[grafid][gText],
		GraffitInfo[grafid][gFont],
		GraffitInfo[grafid][gFontSize],
		GraffitInfo[grafid][gColor],
		GraffitInfo[grafid][gPosX],
		GraffitInfo[grafid][gPosY],
		GraffitInfo[grafid][gPosZ],
		GraffitInfo[grafid][gRotX],
		GraffitInfo[grafid][gRotY],
		GraffitInfo[grafid][gRotZ],
		GraffitInfo[grafid][gAuthor]
	);
	mysql_tquery(g_SQL, tmpQuery, "OnGraffitCreate", "i", grafid);
	mysql_tquery(g_SQL, "COMMIT", "");
	return 1;
}
stock CreateGraffitCheckpoint(playerid, Float:X, Float:Y, Float:Z, Float:size = GRAFFIT_CHECKPOINT_SIZE)
{
	GraffitCPInfo[playerid][gCPX] = X;
	GraffitCPInfo[playerid][gCPY] = Y;
	GraffitCPInfo[playerid][gCPZ] = Z;
	GraffitCPInfo[playerid][gProgress] = 0.0;
	
	GraffitCPInfo[playerid][gCPId] = CreateDynamicCP(X,Y,Z-1,size,0,0,playerid,30.0);
	return 1;
}
stock DestroyGraffitCheckpoint(playerid)
{
	if( IsValidDynamicCP(GraffitCPInfo[playerid][gCPId]) )
		DestroyDynamicCP(GraffitCPInfo[playerid][gCPId]);
	
	GraffitCPInfo[playerid][gCPX] = 0.0;
	GraffitCPInfo[playerid][gCPY] = 0.0;
	GraffitCPInfo[playerid][gCPZ] = 0.0;
	GraffitCPInfo[playerid][gCPId] = -1;
	return 1;
}
stock FixText(text[])
{
	new len = strlen(text);
	if(len > 1)
	{
		for(new i = 0; i < len; i++)
		{
			if(text[i] == 92)
			{
				// New line
			    if(text[i+1] == 'n')
			    {
					text[i] = '\n';
					for(new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Tab
			    if(text[i+1] == 't')
			    {
					text[i] = '\t';
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Literal
			    if(text[i+1] == 92)
			    {
					text[i] = 92;
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
			    }
			}
		}
	}
	return 1;
}
stock CreateGraffit(playerid=INVALID_PLAYER_ID, grafid=-1, text[], Float:X, Float:Y, Float:Z, Float:RotX, Float:RotY, Float:RotZ)
{
	if(grafid == -1) grafid = Iter_Free(Graffits);
	if(grafid != -1) {
		//Enum set
		format(GraffitInfo[grafid][gText], 32, "%s", text);
		
		GraffitInfo[grafid][gPosX] = X;
		GraffitInfo[grafid][gPosY] = Y;
		GraffitInfo[grafid][gPosZ] = Z;
		
		GraffitInfo[grafid][gRotX] = RotX;
		GraffitInfo[grafid][gRotY] = RotY;
		GraffitInfo[grafid][gRotZ] = RotZ;

		format(GraffitInfo[grafid][gAuthor], 24, "%s", GetName(playerid, false));
		
		GraffitInfo[grafid][gObject] = CreateDynamicObject(GROVE_TAG,X,Y,Z,RotX,RotY,RotZ,0,0,-1,GRAFFIT_DRAW_DISTANCE);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, GraffitInfo[grafid][gObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
		new
			tmpString[ MAX_GRAFFIT_INPUT ];
		strcat(tmpString, GraffitInfo[grafid][gText], MAX_GRAFFIT_INPUT);
		FixText(tmpString);
		SetDynamicObjectMaterialText(GraffitInfo[grafid][gObject], 0, tmpString, OBJECT_MATERIAL_SIZE_512x512, GetGrafFont(GraffitInfo[grafid][gFont]), GraffitInfo[grafid][gFontSize], 0, GetGrafColor(GraffitInfo[grafid][gColor]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		Streamer_UpdateEx(playerid, GraffitInfo[grafid][gPosX],GraffitInfo[grafid][gPosY],GraffitInfo[grafid][gPosZ],0);
		
		if(playerid != INVALID_PLAYER_ID)
			LastPlayerGraffiti[playerid] = GraffitInfo[grafid][gObject];
			
		DestroyGraffitCheckpoint(playerid);
	}
	return 1;
}
stock EditGraffit(grafid, Float:newX, Float:newY, Float:newZ, Float:newRotX, Float:newRotY, Float:newRotZ)
{
	//Enum Sets
	GraffitInfo[grafid][gPosX] = newX;
	GraffitInfo[grafid][gPosY] = newY;
	GraffitInfo[grafid][gPosZ] = newZ;
	
	GraffitInfo[grafid][gRotX] = newRotX;
	GraffitInfo[grafid][gRotY] = newRotY;
	GraffitInfo[grafid][gRotZ] = newRotZ;

	//SQL Update
	new
		grafUpdateString[512];
		
	format(grafUpdateString, sizeof(grafUpdateString), "UPDATE `graffiti` SET `posx` = '%f', `posy` = '%f', `posz` = '%f', `rotx` = '%f', `roty` = '%f', `rotz` = '%f' WHERE `id` = '%d'",
		GraffitInfo[grafid][gPosX],
		GraffitInfo[grafid][gPosY],
		GraffitInfo[grafid][gPosZ],
		GraffitInfo[grafid][gRotX],
		GraffitInfo[grafid][gRotY],
		GraffitInfo[grafid][gRotZ],
		GraffitInfo[grafid][gId]
	);
	mysql_tquery(g_SQL, grafUpdateString, "");
	//Streamer
	
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, GraffitInfo[grafid][gObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
}
stock DestroyGraffit(grafid)
{
	if( grafid == -1 ) return 0;
	new DeleteString[256];
	format(DeleteString, sizeof(DeleteString), "DELETE FROM `graffiti` WHERE `id` = '%i'", GraffitInfo[grafid][gId]);
	mysql_tquery(g_SQL, DeleteString, "");

	//Destroys
	if( IsValidDynamicObject(GraffitInfo[grafid][gObject]) )
		DestroyDynamicObject(GraffitInfo[grafid][gObject]);
	
	//Enum sets
	new tmpobject[E_GRAFFITI_DATA];
	GraffitInfo[grafid] = tmpobject; 
	
	//Iter
	new next;
	Iter_SafeRemove(Graffits, grafid, next);
	return 1;
}
stock UpdateGraffitProgress(playerid, grafid)
{
	if( !GraffitCPInfo[playerid][gProgress] && Bit1_Get(r_GrafCreateStarted, playerid) ) {
		new 
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		
		CreateGraffitCheckpoint(playerid,X,Y,Z);
		GraffitCPInfo[playerid][gProgress] += GRAFFIT_SPRAYING_UP;
	}
	else if(GraffitCPInfo[playerid][gProgress] > 0) {
		GraffitCPInfo[playerid][gProgress] += GRAFFIT_SPRAYING_UP;
		SetPlayerProgressBarValue(playerid, gProgressBar[playerid], GraffitCPInfo[playerid][gProgress]);

		if(GraffitCPInfo[playerid][gProgress] >= 100) {	
			GraffitCPInfo[playerid][gProgress] = 0.0;
			
			new 
				Float:X, Float:Y, Float:Z, Float:angle,
				Float:distance = 0.49;
				
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, angle);
			
			angle += 90.0;
			GetXYInFrontOfPlayer(playerid, X, Y, distance);
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK )
				CreateGraffit(playerid,grafid,GraffitInfo[grafid][gText],X,Y,Z-0.3,0.0,0.0,angle);
			else 
				CreateGraffit(playerid,grafid,GraffitInfo[grafid][gText],X,Y,Z+0.7,0.0,0.0,angle);
			Bit1_Set(r_GrafCreateStarted, playerid, false);
			DestroyGraffitCheckpoint(playerid);
			DestroyPlayerProgressBar(playerid, gProgressBar[playerid]);
			InsertGraffitIntoDB(grafid);
			
		}
	}
	return 1;
}
/*
										  __                        
	  ________________________  ___.__. _/  |______     ____  ______
	 /  ___/\____ \_  __ \__  \<   |  | \   __\__  \   / ___\/  ___/
	 \___ \ |  |_> >  | \// __ \\___  |  |  |  / __ \_/ /_/  >___ \ 
	/____  >|   __/|__|  (____  / ____|  |__| (____  /\___  /____  >
		 \/ |__|              \/\/                 \//_____/     \/ 
*/
forward OnTagsLoaded();
public OnTagsLoaded()
{
	new rows  = cache_num_rows();	
	if( rows ) {
		new 
			tmp[ 32 ];
		for(new b = 0; b < rows; b++) {
			cache_get_value_name_int(b, 	"id"		, TagInfo[ b ][ tId ]);
			cache_get_value_name_int(b, 	"modelid"	, TagInfo[ b ][ tModelid ]);
			cache_get_value_name_float(b, 	"posx"		, TagInfo[ b ][ tPosX ]);
			cache_get_value_name_float(b, 	"posy"		, TagInfo[ b ][ tPosY ]);
			cache_get_value_name_float(b, 	"posz"		, TagInfo[ b ][ tPosZ ]);
			cache_get_value_name_float(b, 	"rotx"		, TagInfo[ b ][ tRotX ]);
			cache_get_value_name_float(b, 	"roty"		, TagInfo[ b ][ tRotY ]);
			cache_get_value_name_float(b, 	"rotz"		, TagInfo[ b ][ tRotZ ]);
			cache_get_value_name_int(b, 	"faction"	, TagInfo[ b ][ tFaction ]);
			cache_get_value_name(b, "author", tmp);
			format( TagInfo[ b ][ tAuthor ] , 32, tmp );		
			
			SetFactionTagCount(TagInfo[b][tFaction], 1);
			TagInfo[b][tgObject] = CreateDynamicObject(TagInfo[b][tModelid],TagInfo[b][tPosX],TagInfo[b][tPosY],TagInfo[b][tPosZ],TagInfo[b][tRotX],TagInfo[b][tRotY],TagInfo[b][tRotZ],0,0,-1,GRAFFIT_DRAW_DISTANCE);
			Iter_Add(SprayTags, b);
		}
		printf("MySQL Report: Spray Tags Loaded (%d)!", Iter_Count(SprayTags));
	} else printf("MySQL Report: No spray tags exist to load.");
	return 1;
}

stock LoadTags()
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "SELECT * FROM spraytags WHERE 1 LIMIT 0,%d", MAX_TAGS);
	mysql_tquery(g_SQL, tmpQuery, "OnTagsLoaded");
	return 1;
}

stock GetSprayTagIdFromPlaya(playerid, Float:radius)
{
	foreach(new i : SprayTags)
	{
		if(GetPlayerDistanceFromPoint(playerid, TagInfo[i][tPosX], TagInfo[i][tPosY], TagInfo[i][tPosZ]) <= radius)
			return i;
	}
	return 0;
}

stock GetPlayerOrganisation(playerid)
{
	new porg = 0;
	if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLeader] == 1) 		porg = 1;
	else if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLeader] == 2) 	porg = 2;
	else if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 3) 	porg = 3;
	else if(PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLeader] == 4) 	porg = 4;
	else if(PlayerInfo[playerid][pMember] == 5 || PlayerInfo[playerid][pLeader] == 5) 	porg = 5;	//MS-13
	else if(PlayerInfo[playerid][pMember] == 6 || PlayerInfo[playerid][pLeader] == 6) 	porg = 6;	//Eastsiderz
	else if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLeader] == 7) 	porg = 7;
	else if(PlayerInfo[playerid][pMember] == 8 || PlayerInfo[playerid][pLeader] == 8) 	porg = 8;	
	else if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLeader] == 9) 	porg = 9;	//Bloods
	else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLeader] == 10) porg = 10;
	else if(PlayerInfo[playerid][pMember] == 11 || PlayerInfo[playerid][pLeader] == 11) porg = 11;
	else if(PlayerInfo[playerid][pMember] == 12 || PlayerInfo[playerid][pLeader] == 12) porg = 12;
	else if(PlayerInfo[playerid][pMember] == 13 || PlayerInfo[playerid][pLeader] == 13) porg = 13;
	return porg;
}

stock ClearFactionTagCount()
{
	for(new i=0; i<12; i++)
	{
		FactionTagCount[i][ftTagCount] = 0;
	}
}

stock GetFactionTagCount(factionid)
{
	return FactionTagCount[factionid-1][ftTagCount];
}

stock SetFactionTagCount(factionid, amount)
{
	if(factionid == 1) {
		FactionTagCount[0][ftTagCount] += amount;
	}
	else if(factionid == 2) {
		FactionTagCount[1][ftTagCount] += amount;
	}
	else if(factionid == 3) {
		FactionTagCount[2][ftTagCount] += amount;
	}
	else if(factionid == 4) {
		FactionTagCount[3][ftTagCount] += amount;
	}
	else if(factionid == 5) {
		FactionTagCount[4][ftTagCount] += amount;
	}
	else if(factionid == 6) {
		FactionTagCount[5][ftTagCount] += amount;
	}
	else if(factionid == 7) {
		FactionTagCount[6][ftTagCount] += amount;
	}
	else if(factionid == 8) {
		FactionTagCount[7][ftTagCount] += amount;
	}
	else if(factionid == 9) {
		FactionTagCount[8][ftTagCount] += amount;
	}
	else if(factionid == 10) {
		FactionTagCount[9][ftTagCount] += amount;
	}
	else if(factionid == 11) {
		FactionTagCount[10][ftTagCount] += amount;
	}
	else if(factionid == 12) {
		FactionTagCount[11][ftTagCount] += amount;
	}
	else if(factionid == 13) {
		FactionTagCount[12][ftTagCount] += amount;
	}
	return 1;
}

stock GetOfficialGangTag(playerid)
{
	#pragma unused playerid
	new
		//porg = GetPlayerOrganisation(playerid),
		tagid = 0;
		
	/*if(porg == 5) 		tagid = VAGOS_TAG;
	else if(porg == 6) 	tagid = TEMPLE_TAG;
	else if(porg == 9) 	tagid = KILO_TAG;*/
	tagid = 0;
	return tagid;
}

stock InsertSprayTagIntoDB(tagid)
{
	new 
		insertSprayString[1024];	
	mysql_format(g_SQL, insertSprayString, 1024, "INSERT INTO spraytags (`modelid`,`posx`,`posy`,`posz`,`rotx`,`roty`,`rotz`,`faction`,`author`) VALUES ('%d','%f','%f','%f','%f','%f','%f','%d','%e')",
		TagInfo[tagid][tModelid],
		TagInfo[tagid][tPosX],
		TagInfo[tagid][tPosY],
		TagInfo[tagid][tPosZ],
		TagInfo[tagid][tRotX],
		TagInfo[tagid][tRotY],
		TagInfo[tagid][tRotZ],
		TagInfo[tagid][tFaction],
		TagInfo[tagid][tAuthor]
	);
	mysql_tquery(g_SQL, insertSprayString, "");
	return 1;
}

stock CreateSprayTagCheckpoint(playerid, tagid, Float:X, Float:Y, Float:Z, Float:size = GRAFFIT_CHECKPOINT_SIZE)
{
	TagCPInfo[tagid][tCPX] = X;
	TagCPInfo[tagid][tCPY] = Y;
	TagCPInfo[tagid][tCPZ] = Z;
	TagCPInfo[tagid][tProgress] = 0.0;
	
	TagCPInfo[tagid][tCPId] = CreateDynamicCP(X,Y,Z,size,0,0,playerid,30.0);
	return 1;
}

stock DestroySprayTagCheckpoint(tagid)
{
	DestroyDynamicCP(TagCPInfo[tagid][tCPId]);
	
	TagCPInfo[tagid][tCPX]  = 0.0;
	TagCPInfo[tagid][tCPY]  = 0.0;
	TagCPInfo[tagid][tCPZ]  = 0.0;
	TagCPInfo[tagid][tCPId] = -1;
	return 1;
}

stock CreateSprayTag(playerid, tagid=-1, modelid, Float:X, Float:Y, Float:Z, Float:RotX, Float:RotY, Float:RotZ, faction)
{
	if(tagid == -1) tagid = Iter_Free(SprayTags);
	if(tagid != -1) {
		//Iter
		Iter_Add(SprayTags, tagid);
		
		//Enum Sets
		TagInfo[tagid][tId] = tagid;
		TagInfo[tagid][tModelid] = modelid;
		TagInfo[tagid][tFaction] = faction;
		
		TagInfo[tagid][tPosX] = X;
		TagInfo[tagid][tPosY] = Y;
		TagInfo[tagid][tPosZ] = Z;
		
		TagInfo[tagid][tRotX] = RotX;
		TagInfo[tagid][tRotY] = RotY;
		TagInfo[tagid][tRotZ] = RotZ;
		
		TagInfo[tagid][tgObject] = CreateDynamicObject(modelid,X,Y,Z,RotX,RotY,RotZ,0,0,-1,GRAFFIT_DRAW_DISTANCE);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagInfo[tagid][tgObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
		
		if(playerid != INVALID_PLAYER_ID) {
			LastPlayerTag[playerid] = TagInfo[tagid][tgObject];
			format(TagInfo[tagid][tAuthor], 24, "%s", GetName(playerid, false));
		}
		
		InsertSprayTagIntoDB(tagid);
		DestroySprayTagCheckpoint(tagid);
	}
	return 1;
}

stock EditSprayTag(tagid, Float:newX, Float:newY, Float:newZ, Float:newRotX, Float:newRotY, Float:newRotZ)
{
	//Enum Sets
	TagInfo[tagid][tPosX] = newX;
	TagInfo[tagid][tPosY] = newY;
	TagInfo[tagid][tPosZ] = newZ;
	
	TagInfo[tagid][tRotX] = newRotX;
	TagInfo[tagid][tRotY] = newRotY;
	TagInfo[tagid][tRotZ] = newRotZ;
	
	//SQL Update
	new
		updateSprayString[512];
	format(updateSprayString, 512, "UPDATE spraytags SET `posx` = '%f', `posy` = '%f', `posz` = '%f', `rotx` = '%f', `roty` = '%f', `rotz` = '%f' WHERE `id` = '%d'",
		TagInfo[tagid][tPosX],
		TagInfo[tagid][tPosY],
		TagInfo[tagid][tPosZ],
		TagInfo[tagid][tRotX],
		TagInfo[tagid][tRotY],
		TagInfo[tagid][tRotZ],
		TagInfo[tagid][tId]
	);
	mysql_tquery(g_SQL, updateSprayString, "");
	
	//Streamer
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagInfo[tagid][tgObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
}

stock DestroySprayTag(tagid)
{
	if( IsValidDynamicObject(TagInfo[tagid][tgObject]) )
		DestroyDynamicObject(TagInfo[tagid][tgObject]);
	
	new
		deleteTags[ 256 ];
	format(deleteTags, sizeof(deleteTags), "DELETE FROM spraytags WHERE `id` = '%d'", TagInfo[tagid][tId]);
	mysql_tquery(g_SQL, deleteTags, "");
	
	TagInfo[tagid][tId] 		= -1;
	TagInfo[tagid][tModelid] 	= -1;
	TagCPInfo[tagid][tProgress] = 0;
	TagInfo[tagid][tFaction] 	= -1;
	TagInfo[tagid][tgObject] 	= -1;
	
	TagInfo[tagid][tPosX] 		= 0.0;
	TagInfo[tagid][tPosY] 		= 0.0;
	TagInfo[tagid][tPosZ] 		= 0.0;
	
	TagInfo[tagid][tRotX] 		= 0.0;
	TagInfo[tagid][tRotY] 		= 0.0;
	TagInfo[tagid][tRotZ] 		= 0.0;
	
	DestroySprayTagCheckpoint(tagid);
}

stock UpdateSprayTagProgress(playerid, tagid)
{
	if( !TagCPInfo[tagid][tProgress] ) {
		new 
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		
		CreateSprayTagCheckpoint(playerid,tagid,X,Y,Z);
		PlayerInfo[playerid][pTagID] = tagid;
		TagCPInfo[tagid][tProgress] += GRAFFIT_SPRAYING_UP;
		Bit1_Set(r_TaggCreateStarted, playerid, true);
	}
	else if(TagCPInfo[tagid][tProgress] > 0)
	{
		TagCPInfo[tagid][tProgress] += GRAFFIT_SPRAYING_UP;
		SetPlayerProgressBarValue(playerid, tProgressBar[playerid], TagCPInfo[tagid][tProgress]);
				
		if(TagCPInfo[tagid][tProgress] >= 100)
		{	
			Bit1_Set(r_TaggCreateStarted, playerid, false);
			DestroySprayTagCheckpoint(tagid);
			DestroyPlayerProgressBar(playerid, tProgressBar[playerid]);
			new 
				Float:X, Float:Y, Float:Z, Float:angle,
				Float:distance = 0.49;
				
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, angle);
			
			angle += 90.0;
			GetXYInFrontOfPlayer(playerid, X, Y, distance);
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK )
				CreateSprayTag(playerid,tagid,GetOfficialGangTag(playerid),X,Y,Z-0.3,0.0,0.0,angle,GetPlayerOrganisation(playerid));
			else 
				CreateSprayTag(playerid,tagid,GetOfficialGangTag(playerid),X,Y,Z+0.7,0.0,0.0,angle,GetPlayerOrganisation(playerid));
			
			new org = GetPlayerOrganisation(playerid),
				string[64];
				
			SetFactionTagCount(org,1);
			format(string, sizeof(string), "] %d ]", FactionTagCount[org-1][ftTagCount]);
			GameTextForPlayer(playerid, string, 3000, 4);
		}
	}
	return 1;
}

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

Public:SprayingBarChecker(playerid)
{
	if(Bit1_Get(r_GrafCreateStarted, playerid)) {
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, GraffitCPInfo[playerid][gCPX], GraffitCPInfo[playerid][gCPY], GraffitCPInfo[playerid][gCPZ]))
			HidePlayerProgressBar(playerid, gProgressBar[playerid]);
	}
	else if(Bit1_Get(r_TaggCreateStarted, playerid)) {
		new tagid = PlayerInfo[playerid][pTagID];
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, TagCPInfo[tagid][tCPX], TagCPInfo[tagid][tCPY], TagCPInfo[tagid][tCPZ]))
			HidePlayerProgressBar(playerid, tProgressBar[playerid]);
	}
	return 1;
}

Public:SprayingTaggTimer(playerid)
{
	new newkeys,ud,lf;
	GetPlayerKeys(playerid, newkeys, ud, lf);
	if(HOLDING(KEY_FIRE)) {
		if(AC_GetPlayerWeapon(playerid) == 41) {
			if(Bit1_Get(r_TaggCreateStarted, playerid) && !Bit1_Get(r_GrafCreateStarted, playerid)) {	
				new tagid = PlayerInfo[playerid][pTagID];
				if(!IsPlayerInRangeOfPoint(playerid, 1.5, TagCPInfo[tagid][tCPX], TagCPInfo[tagid][tCPY], TagCPInfo[tagid][tCPZ])) return 1;
				UpdateSprayTagProgress(playerid, tagid);
				SetPlayerProgressBarValue(playerid, tProgressBar[playerid], TagCPInfo[tagid][tProgress]);
				ShowPlayerProgressBar(playerid, tProgressBar[playerid]);
			}
			else if(!Bit1_Get(r_TaggCreateStarted, playerid) && !Bit1_Get(r_GrafCreateStarted, playerid)) {
				if(!GetOfficialGangTag(playerid)) return 1;
				if(GetFactionTagCount(GetPlayerOrganisation(playerid)) == 100) return 1;
				new tagid = Iter_Free(SprayTags);
				tProgressBar[playerid] = CreatePlayerProgressBar(playerid, 55.0, 319.0, _, _, 0x1932AAFF, 100.0);
				SetPlayerProgressBarValue(playerid, tProgressBar[playerid], 0.0);
				ShowPlayerProgressBar(playerid, tProgressBar[playerid]);
				UpdateSprayTagProgress(playerid, tagid);
			}
			if(Bit1_Get(r_GrafCreateStarted, playerid)) {	
				new grafid = PlayerInfo[playerid][pGrafID];
				if(!IsPlayerInRangeOfPoint(playerid, 1.5, GraffitCPInfo[playerid][gCPX], GraffitCPInfo[playerid][gCPY], GraffitCPInfo[playerid][gCPZ])) return 1;
				UpdateGraffitProgress(playerid, grafid);
				SetPlayerProgressBarValue(playerid, gProgressBar[playerid], GraffitCPInfo[playerid][gProgress]);
				ShowPlayerProgressBar(playerid, gProgressBar[playerid]);
			}
		}
	}
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
	
hook OnPlayerDisconnect(playerid, reason)
{
	if( Bit1_Get(r_GrafCreateStarted, playerid) ) {
		Bit1_Set(r_GrafCreateStarted, playerid, false);
		DestroyGraffitCheckpoint(playerid);
	}
	if( Bit1_Get(r_TaggCreateStarted, playerid) ) {
		Bit1_Set(r_TaggCreateStarted, playerid, false);
		DestroySprayTagCheckpoint(PlayerInfo[playerid][pTagID]);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_GRAF_COLOR: {
			if(!response) {
				//Iter
				new next;
				Iter_SafeRemove(Graffits, PlayerInfo[playerid][pGrafID], next);
				PlayerInfo[playerid][pGrafID] = -1;
				return 1;
			}
			new grafid = PlayerInfo[playerid][pGrafID];
			switch(listitem) {
				case 0: {//crna
					GraffitInfo[grafid][gColor] =  1;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Crnu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 1: { //bijela
					GraffitInfo[grafid][gColor] =  2;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Bijelu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta\nPainterz\nFreight Train Gangsta", "Choose", "Abort"); 
				}
				case 2: { //plava (tamna)
					GraffitInfo[grafid][gColor] =  3;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Tamno Plavu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 3: { //plava (svijetla)
					GraffitInfo[grafid][gColor] =  4;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Svijetlo Plavu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 4: { //zelena
					GraffitInfo[grafid][gColor] =  5;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Zelenu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 5: { //crvena
					GraffitInfo[grafid][gColor] =  6;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Crvenu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 6: { //smeda
					GraffitInfo[grafid][gColor] =  7;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Smedu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 7: { //narandasta
					GraffitInfo[grafid][gColor] =  8;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Narandjastu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 8: { //zlatna 
					GraffitInfo[grafid][gColor] =  9;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Zlatnu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
				case 9: { //srebrna 
					GraffitInfo[grafid][gColor] =  10;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Srebrnu boju za grafit! Sada odaberi font.");
					SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bih vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
					ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_GRAF_FONT: {
			if(!response) ShowPlayerDialog(playerid, DIALOG_GRAF_COLOR, DIALOG_STYLE_LIST, "Odaberi boju", "{141414}Crna\nBijela\n{0000A1}Tamno plava\n{3C82FF}Svijetlo plava\n{329D32}Zelena\n{BE0A0A}Crvena\n{502800}Smeda", "Choose", "Abort");
			new grafid = PlayerInfo[playerid][pGrafID];
			switch(listitem) {
				case 0: { //Arial
					GraffitInfo[grafid][gFont] =  1;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Arial font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 1: { //Dripping Marker
					GraffitInfo[grafid][gFont] =  2;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Dripping Marker font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 2: { //Sick Capital Vice
					GraffitInfo[grafid][gFont] =  3;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Sick Capital Vice font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 3: { //East Side Motel
					GraffitInfo[grafid][gFont] =  4;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si East Side Motel font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 4: { //Whoa
					GraffitInfo[grafid][gFont] =  5;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Whoa font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 5: { //Juanalzada
					GraffitInfo[grafid][gFont] =  6;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Juanalzada font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 6: { //URBAN HOOK-UPZ
					GraffitInfo[grafid][gFont] =  7;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Urban Hook font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 7: {//Amsterdam graffiti
					GraffitInfo[grafid][gFont] =  8;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Amsterdam graffiti font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 8: { //Old English
					GraffitInfo[grafid][gFont] =  9;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Old English font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "60\n80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 9: { //Stylin' BRK
					GraffitInfo[grafid][gFont] =  10;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Stylin' font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "60\n80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 10: { // Painterz
					GraffitInfo[grafid][gFont] =  11;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Painterz font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "60\n80\n90\n100\n110\n", "Choose", "Abort");
				}
				case 11: { // Freight Train Gangsta
					GraffitInfo[grafid][gFont] =  12;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si Painterz font.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "60\n80\n90\n100\n110\n", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_GRAF_SIZE: {
			if(!response) ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
			new grafid = PlayerInfo[playerid][pGrafID];
			switch(listitem) {
				case 0: { //60
					GraffitInfo[grafid][gFontSize] =  60;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: 60.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				}
				case 1: { //80
					GraffitInfo[grafid][gFontSize] =  80;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: 80.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				}
				case 2: { //90
					GraffitInfo[grafid][gFontSize] =  90;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: 90.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				}
				case 3: { //100
					GraffitInfo[grafid][gFontSize] =  100;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: 100.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				}
				case 4: { //110
					GraffitInfo[grafid][gFontSize] =  110;
					SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: 110.");
					ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				}
			}
			return 1;
		}
		case DIALOG_GRAF_TEXT: {
			if(!response) ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
			if(strlen(inputtext) == 0) {
				SendClientMessage(playerid, 0xfa5555AA, "Moras unijeti neki tekst!");
				ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				return 1;
			}
			if(strlen(inputtext) > MAX_GRAFFIT_INPUT - 1) {
				SendClientMessage(playerid, 0xfa5555AA, "Prevelik text (1-31 znamenki)!");
				ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
				return 1;
			}
			new grafid = PlayerInfo[playerid][pGrafID];
			
			format(GraffitInfo[grafid][gText], 32, "%s", inputtext);
			GameTextForPlayer(playerid, "~w~Spraying time", 1000, 1);
			
			Bit1_Set(r_GrafCreateStarted, playerid, true);
			UpdateGraffitProgress(playerid, grafid);
			gProgressBar[playerid] = CreatePlayerProgressBar(playerid, 55.0, 319.0, _, _, 0x1932AAFF, 100.0);
			SetPlayerProgressBarValue(playerid, gProgressBar[playerid], 0.0);
			ShowPlayerProgressBar(playerid, gProgressBar[playerid]);
			return 1;
		}
	}
	return 0;
}

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Bit1_Get(r_GrafApprove, playerid))
	{
		switch(GraffitiObjectEdit[ playerid ] ) {
			case EDIT_GRAFFIT: {
				switch(response) {
					case EDIT_RESPONSE_FINAL: {
						new index = EditingGraffitiIndex[playerid];
						SetDynamicObjectPos(GraffitInfo[index][gObject], x, y, z);
						SetDynamicObjectRot(GraffitInfo[index][gObject], rx, ry, rz);
						EditGraffit(index, x, y, z, rx, ry, rz);

						EditingGraffitiIndex[playerid] 	= 999;
						GraffitiObjectEdit[playerid] 	= -1;
					}
					case EDIT_RESPONSE_CANCEL: {
						new index = EditingGraffitiIndex[playerid];
						SetDynamicObjectPos(GraffitInfo[index][gObject], GraffitInfo[index][gPosX], GraffitInfo[index][gPosY], GraffitInfo[index][gPosZ]);
						SetDynamicObjectRot(GraffitInfo[index][gObject], GraffitInfo[index][gRotX], GraffitInfo[index][gRotY], GraffitInfo[index][gRotZ]);

						EditingGraffitiIndex[playerid] 	= 999;
						GraffitiObjectEdit[playerid] 	= -1;
					}
				}
			}
			case EDIT_SPRAYTAG: {
				switch(response) {
					case EDIT_RESPONSE_FINAL: {
						new index = EditingGraffitiIndex[playerid];
						SetDynamicObjectPos(TagInfo[index][tgObject], x, y, z);
						SetDynamicObjectRot(TagInfo[index][tgObject], rx, ry, rz);
						EditSprayTag(index, x, y, z, rx, ry, rz);

						EditingGraffitiIndex[playerid] 	= 999;
						GraffitiObjectEdit[playerid] 	= -1;
					}
					case EDIT_RESPONSE_CANCEL: {
						new index = EditingGraffitiIndex[playerid];
						SetDynamicObjectPos(TagInfo[index][tgObject], TagInfo[index][tPosX], TagInfo[index][tPosY], TagInfo[index][tPosZ]);
						SetDynamicObjectRot(TagInfo[index][tgObject], TagInfo[index][tRotX], TagInfo[index][tRotY], TagInfo[index][tRotZ]);

						EditingGraffitiIndex[playerid] 	= 999;
						GraffitiObjectEdit[playerid] 	= -1;
					}
				}
			}
		}
	}
	return 1;
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
CMD:spraytag(playerid, params[])
{
	new pick[8];
	if(sscanf(params, "s[8] ", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /spraytag [odabir]");
		SendClientMessage(playerid, -1, "[Odabir]: edit, delete, adelete, author");
		return 1;
	}
	if(!strcmp(pick, "edit", true)) {
		if(Bit1_Get(r_TagEditStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec uredjujete jedan grafit!");
		if(PlayerInfo[playerid][pAdmin] >= 1) {
			new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
			if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");
			Bit1_Set(r_TagEditStarted, playerid, true);
			EditDynamicObject(playerid, TagInfo[tagid][tgObject]);
			GraffitiObjectEdit[ playerid ] = EDIT_SPRAYTAG;
		} else {
			new tagid = GetPlayersSprayTag(playerid, LastPlayerTag[playerid], 5.0);
			if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");
			Bit1_Set(r_TagEditStarted, playerid, true);
			EditDynamicObject(playerid, LastPlayerTag[playerid]);
			GraffitiObjectEdit[ playerid ] = EDIT_SPRAYTAG;
		}
	}	
	else if(!strcmp(pick, "delete", true)) {
		new tagid = GetPlayersSprayTag(playerid, LastPlayerTag[playerid], 2.0);
		if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");
		DestroySprayTag(tagid);
		SetFactionTagCount(GetPlayerOrganisation(playerid), -1);
	}
	else if(!strcmp(pick, "adelete", true)) {
		if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
		new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
		if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog spray taga!");
		DestroySprayTag(tagid);
		SetFactionTagCount(TagInfo[tagid][tFaction], -1);
	}
	else if(!strcmp(pick, "author", true)) {
		new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
		if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog spray taga!");
		new string[64];
		format(string, sizeof(string), "* Autor grafita je: %s", TagInfo[tagid][tAuthor]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	}
	return 1;
}
CMD:graffit(playerid, params[])
{
	new pick[9];
	if(sscanf(params, "s[9] ", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /graffit [odabir] (create)");
		SendClientMessage(playerid, -1, "[Odabir]: create, edit, delete, adelete, author, approve");
		return 1;
	}
	if(!strcmp(pick, "create", false, 6)) {
		if(!Bit1_Get(r_GrafApprove, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dozvolu za grafite!");
		if( GetGraffitIdFromPlaya(playerid, 5.0) != -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijes postavljati tako blizu grafite!");
		
		PlayerInfo[playerid][pGrafID] = Iter_Free(Graffits);
		Iter_Add(Graffits, PlayerInfo[playerid][pGrafID]);
		ShowPlayerDialog(playerid, DIALOG_GRAF_COLOR, DIALOG_STYLE_LIST, "Odaberi boju", "{141414}Crna\nBijela\n{0000A1}Tamno plava\n{3C82FF}Svijetlo plava\n{329D32}Zelena\n{BE0A0A}Crvena\n{502800}Smeda\n{FF732D}Narandasta\n{FFD700}Zlatna\n{C0C0C0}Srebrna", "Choose", "Abort");
	}
	else if(!strcmp(pick, "edit", true)) {
		if(Bit1_Get(r_GraffitEditStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec uredjujete jedan grafit!");
		if(PlayerInfo[playerid][pAdmin] >= 1) {
			new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
			if( grafid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");
			EditingGraffitiIndex[playerid] = grafid;
			EditDynamicObject(playerid,  GraffitInfo[grafid][gObject]);
			GraffitiObjectEdit[ playerid ] = EDIT_GRAFFIT;
		} else {
			new grafid = GetPlayersGraffit(playerid, LastPlayerGraffiti[playerid], 5.0);
			if( grafid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");
			EditingGraffitiIndex[playerid] = grafid;
			EditDynamicObject(playerid, LastPlayerGraffiti[playerid]);
			GraffitiObjectEdit[ playerid ] = EDIT_GRAFFIT;
		}
	}
	else if(!strcmp(pick, "delete", true)) {
		new grafid = GetPlayersGraffit(playerid, LastPlayerGraffiti[playerid], 5.0);
		if( grafid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini svojega grafita!");
		if( !DestroyGraffit(grafid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se pogreska prilikom brisanja grafita!");
	}
	else if(!strcmp(pick, "adelete", true)) {
		if( PlayerInfo[ playerid ][ pAdmin ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
		new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
		if( grafid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");
		if( !DestroyGraffit(grafid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se pogreska prilikom brisanja grafita!");
	}
	else if(!strcmp(pick, "author", true)) {
		new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
		if( grafid == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");
		new string[64];
		format(string, sizeof(string), "Autor grafita je: %s", GraffitInfo[grafid][gAuthor]);
		SendClientMessage(playerid, -1, string);
	}
	else if(!strcmp(pick, "approve", true)) {
		new gplayerid;
		if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
		if(sscanf(params, "s[9]u", pick, gplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /graffit aprove [playerid/dio imena]");
		if(gplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid!");
		
		Bit1_Set(r_GrafApprove, gplayerid, true);
		va_SendClientMessage(gplayerid, COLOR_RED, "[ ! ] Admin %s ti je dao dozvolu za pravljenje grafita!", GetName(playerid, false));
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dao si %s dozvolu za pravljenje grafita!", GetName(gplayerid, false));
	}
	return 1;
}
