/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

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

// TODO: use Gang/Organisation not Faction naming throughout this file. Or unite the two "Faction" systems

// Ints
#define MAX_GRAFS                           (500)
#define MAX_TAGS                            (100)
#define MAX_GRAFFIT_INPUT                   (32)

// Tagids
#define GROVE_TAG                           18659
#define SEVILLE_TAG                         18660
#define VARRIORS_TAG                        18661
#define KILO_TAG                            18662
#define AZTECA_TAG                          18663
#define TEMPLE_TAG                          18664
#define VAGOS_TAG                           18665
#define BALLAS_TAG                          18666
#define RBALLAS_TAG                         18667

// Floats
#define GRAFFIT_DRAW_DISTANCE               70.0
#define GRAFFIT_CHECKPOINT_SIZE             1.5
#define GRAFFIT_SPRAYING_UP                 5.5

// Editing index
#define EDIT_GRAFFIT                        (1)
#define EDIT_SPRAYTAG                       (2)


/*
    ##     ##    ###    ########   ######  
    ##     ##   ## ##   ##     ## ##    ## 
    ##     ##  ##   ##  ##     ## ##       
    ##     ## ##     ## ########   ######  
     ##   ##  ######### ##   ##         ## 
      ## ##   ##     ## ##    ##  ##    ## 
       ###    ##     ## ##     ##  ######  
*/

enum E_GRAFFITI_DATA
{
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
static
    GraffitInfo[MAX_GRAFS][E_GRAFFITI_DATA];

enum E_GRAFFITI_CP_DATA
{
    gCPId,
    Float:gCPX,
    Float:gCPY,
    Float:gCPZ,
    Float:gProgress
}

static
    GraffitCPInfo[MAX_PLAYERS][E_GRAFFITI_CP_DATA];

enum E_FACTION_TAGS_DATA
{
    ftTagCount
}
static
    FactionTagCount[MAX_FACTIONS][E_FACTION_TAGS_DATA];

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
static
    TagInfo[MAX_TAGS][E_TAG_DATA];

enum E_TAG_CP_DATA
{
    tCPId,
    Float:tCPX,
    Float:tCPY,
    Float:tCPZ,
    Float:tProgress
}
static
    TagCPInfo[MAX_TAGS][E_TAG_CP_DATA];

static
    Iterator:Graffits<MAX_GRAFS>,
    Iterator:SprayTags<MAX_TAGS>;

static
    bool:GrafCreateStarted[MAX_PLAYERS] = {false, ...},
    bool:TagCreateStarted [MAX_PLAYERS] = {false, ...},
    bool:TagEditStarted   [MAX_PLAYERS] = {false, ...},
    bool:GrafEditStarted  [MAX_PLAYERS] = {false, ...},
    bool:GrafApproved     [MAX_PLAYERS] = {false, ...},

    GraffitiID[MAX_PLAYERS],
    TagID[MAX_PLAYERS],
    LastPlayerTag[MAX_PLAYERS],
    LastPlayerGraffiti[MAX_PLAYERS],
    GraffitiObjectEdit[MAX_PLAYERS],
    EditingGraffitiIndex[MAX_PLAYERS],
    PlayerBar:gProgressBar[MAX_PLAYERS],
    PlayerBar:tProgressBar[MAX_PLAYERS];


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

// TODO: bad spelling. LoadGraffiti
stock LoadGraffits()
{
    inline OnGraffitsLoad()
    {
        new 
            rows  = cache_num_rows();
        if(!rows)
        {
            printf("MySQL Report: No graffits exist to load.");
            return 1;
        }

        for (new b = 0; b < rows; b++)
        {
            cache_get_value_name_int(b,         "id"        , GraffitInfo[b][gId]);
            cache_get_value_name(b,             "text"      , GraffitInfo[b][gText], 32);
            cache_get_value_name_int(b,         "font"      , GraffitInfo[b][gFont]);
            cache_get_value_name_int(b,         "fontsize"  , GraffitInfo[b][gFontSize]);
            cache_get_value_name_int(b,         "fontcolor" , GraffitInfo[b][gColor]);
            cache_get_value_name_float(b,       "posx"      , GraffitInfo[b][gPosX]);
            cache_get_value_name_float(b,       "posy"      , GraffitInfo[b][gPosY]);
            cache_get_value_name_float(b,       "posz"      , GraffitInfo[b][gPosZ]);
            cache_get_value_name_float(b,       "rotx"      , GraffitInfo[b][gRotX]);
            cache_get_value_name_float(b,       "roty"      , GraffitInfo[b][gRotY]);
            cache_get_value_name_float(b,       "rotz"      , GraffitInfo[b][gRotZ]);
            cache_get_value_name(b,             "author"    , GraffitInfo[b][gAuthor], MAX_PLAYER_NAME);

            GraffitInfo[b][gObject] = CreateDynamicObject(GROVE_TAG,GraffitInfo[b][gPosX],GraffitInfo[b][gPosY],GraffitInfo[b][gPosZ],GraffitInfo[b][gRotX],GraffitInfo[b][gRotY],GraffitInfo[b][gRotZ], 0, 0, -1, GRAFFIT_DRAW_DISTANCE);
            SetDynamicObjectMaterialText(GraffitInfo[b][gObject], 0, GraffitInfo[b][gText], OBJECT_MATERIAL_SIZE_512x256, GetGrafFont(GraffitInfo[b][gFont]), GraffitInfo[b][gFontSize], 0, GetGrafColor(GraffitInfo[b][gColor]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
            Iter_Add(Graffits, b);
        }
        printf("MySQL Report: Graffitis Loaded. [%d/%d]", Iter_Count(Graffits), MAX_GRAFS);
        return 1;
    }
    MySQL_TQueryInline(SQL_Handle(),
        using inline OnGraffitsLoad,
        va_fquery(SQL_Handle(), "SELECT * FROM graffiti WHERE 1 LIMIT 0, %d", MAX_GRAFS), 
        ""
    );
    return 1;
}

stock GetGraffitIdFromPlaya(playerid, Float:radius)
{
    new id = -1;
    foreach(new i : Graffits)
    {
        if(GetPlayerDistanceFromPoint(playerid, GraffitInfo[i][gPosX], GraffitInfo[i][gPosY], GraffitInfo[i][gPosZ]) <= radius)
        {
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
    foreach(new i : Graffits)
    {
        if(GetPlayerDistanceFromPoint(playerid, X, Y, Z) <= radius)
        {
            id = i;
            break;
        }
    }
    return id;
}

// TODO: use singular for function name, "GetNearestSprayTagForPlayer"
stock GetPlayersSprayTag(playerid, objectid, Float:radius)
{
    new
        Float:X, Float:Y, Float:Z,
        id = -1;

    GetDynamicObjectPos(objectid, X, Y, Z);
    foreach(new i : SprayTags)
    {
        if(GetPlayerDistanceFromPoint(playerid, X,Y,Z) <= radius)
        {
            id = i;
            break;
        }
    }
    return id;
}

stock GetGrafFont(fontid)
{
    // TODO: make an array of const strings and directly return the string with fontid as
    // index to the array. Make appropriate bounds checking beforehand and be wary of the
    // PAWN bug of returning the string directly -- might want to pass it by reference!

    new font[26];
    switch (fontid) {
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
    // Same here, make a const array of integers, index into the array and return
    // the integer directly.
    new color;
    switch (colorid) {
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

static InsertGraffitIntoDB(grafid)
{    
    inline OnGraffitCreate()
    {
        GraffitInfo[grafid][gId] = cache_insert_id();
        return 1;
    }
    MySQL_TQueryInline(SQL_Handle(), 
        using inline OnGraffitCreate,
        va_fquery(SQL_Handle(), 
            "INSERT INTO \n\
                graffiti \n\
            (text,font,fontsize,fontcolor,posx,posy,posz,rotx,roty,rotz,author) \n\
            VALUES \n\
                ('%e','%d','%d','%d','%f','%f','%f','%f','%f','%f','%e')",
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
        ), 
        "i", 
        grafid
    );    
    return 1;
}

stock CreateGraffitCheckpoint(playerid, Float:X, Float:Y, Float:Z, Float:size = GRAFFIT_CHECKPOINT_SIZE)
{
    GraffitCPInfo[playerid][gCPX] = X;
    GraffitCPInfo[playerid][gCPY] = Y;
    GraffitCPInfo[playerid][gCPZ] = Z;
    GraffitCPInfo[playerid][gProgress] = 0.0;

    GraffitCPInfo[playerid][gCPId] = CreateDynamicCP(X, Y, Z -1, size, 0, 0, playerid, 30.0);
    return 1;
}

stock DestroyGraffitCheckpoint(playerid)
{
    if(IsValidDynamicCP(GraffitCPInfo[playerid][gCPId]))
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
    if(len < 1)
    {
        return 1;
    }

    for (new i = 0; i < len; i++)
    {
        if(text[i] == 92) // backslash
        {
            // New line
            if(text[i+1] == 'n')
            {
                text[i] = '\n';
                for (new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
                continue;
            }

            // Tab
            if(text[i+1] == 't')
            {
                text[i] = '\t';
                for (new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
                continue;
            }

            // Literal
            if(text[i+1] == 92)
            {
                text[i] = 92;
                for (new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
            }
        }
    }
    return 1;
}

stock CreateGraffit(playerid=INVALID_PLAYER_ID, grafid=-1, text[], Float:X, Float:Y, Float:Z, Float:RotX, Float:RotY, Float:RotZ)
{
    // Try to find an empty slot
    if(grafid == -1)
    {
        grafid = Iter_Free(Graffits);
    }
    // No empty slot - exit
    if(grafid == -1)
    {
        return 1;
    }

    // TODO: strcpy for copying strings
    format(GraffitInfo[grafid][gText], 32, "%s", text);

    GraffitInfo[grafid][gPosX] = X;
    GraffitInfo[grafid][gPosY] = Y;
    GraffitInfo[grafid][gPosZ] = Z;

    GraffitInfo[grafid][gRotX] = RotX;
    GraffitInfo[grafid][gRotY] = RotY;
    GraffitInfo[grafid][gRotZ] = RotZ;

    // Use strcpy
    format(GraffitInfo[grafid][gAuthor], 24, "%s", GetName(playerid, false));

    GraffitInfo[grafid][gObject] = CreateDynamicObject(GROVE_TAG, X, Y, Z, RotX, RotY, RotZ, 0, 0, -1, GRAFFIT_DRAW_DISTANCE);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, GraffitInfo[grafid][gObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);

    new string[MAX_GRAFFIT_INPUT];
    strcpy(string, GraffitInfo[grafid][gText], MAX_GRAFFIT_INPUT);
    FixText(string);
    SetDynamicObjectMaterialText(GraffitInfo[grafid][gObject], 0, string, OBJECT_MATERIAL_SIZE_512x512, GetGrafFont(GraffitInfo[grafid][gFont]), GraffitInfo[grafid][gFontSize], 0, GetGrafColor(GraffitInfo[grafid][gColor]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
    Streamer_UpdateEx(playerid, GraffitInfo[grafid][gPosX], GraffitInfo[grafid][gPosY], GraffitInfo[grafid][gPosZ], 0);

    if(playerid != INVALID_PLAYER_ID)
        LastPlayerGraffiti[playerid] = GraffitInfo[grafid][gObject];

    DestroyGraffitCheckpoint(playerid);
    return 1;
}

stock EditGraffit(grafid, Float:newX, Float:newY, Float:newZ, Float:newRotX, Float:newRotY, Float:newRotZ)
{
    GraffitInfo[grafid][gPosX] = newX;
    GraffitInfo[grafid][gPosY] = newY;
    GraffitInfo[grafid][gPosZ] = newZ;

    GraffitInfo[grafid][gRotX] = newRotX;
    GraffitInfo[grafid][gRotY] = newRotY;
    GraffitInfo[grafid][gRotZ] = newRotZ;

    mysql_fquery(SQL_Handle(), 
        "UPDATE graffiti SET posx = '%f', posy = '%f', posz = '%f', rotx = '%f', roty = '%f', rotz = '%f' WHERE id = '%d'",
        GraffitInfo[grafid][gPosX],
        GraffitInfo[grafid][gPosY],
        GraffitInfo[grafid][gPosZ],
        GraffitInfo[grafid][gRotX],
        GraffitInfo[grafid][gRotY],
        GraffitInfo[grafid][gRotZ],
        GraffitInfo[grafid][gId]
   );

    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, GraffitInfo[grafid][gObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
}

stock DestroyGraffit(grafid)
{
    if(grafid == -1) return 0;

    mysql_fquery(SQL_Handle(), "DELETE FROM graffiti WHERE id = '%i'", GraffitInfo[grafid][gId]);

    if(IsValidDynamicObject(GraffitInfo[grafid][gObject]))
        DestroyDynamicObject(GraffitInfo[grafid][gObject]);

    new tmpobject[E_GRAFFITI_DATA];
    GraffitInfo[grafid] = tmpobject;

    new next;
    Iter_SafeRemove(Graffits, grafid, next);
    return 1;
}

stock UpdateGraffitProgress(playerid, grafid)
{
    if(!GraffitCPInfo[playerid][gProgress] && GrafCreateStarted[playerid])
    {
        new
            Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);

        CreateGraffitCheckpoint(playerid,X,Y,Z);
        GraffitCPInfo[playerid][gProgress] += GRAFFIT_SPRAYING_UP;
    }
    else if(GraffitCPInfo[playerid][gProgress] > 0)
    {
        GraffitCPInfo[playerid][gProgress] += GRAFFIT_SPRAYING_UP;
        SetPlayerProgressBarValue(playerid, gProgressBar[playerid], GraffitCPInfo[playerid][gProgress]);

        if(GraffitCPInfo[playerid][gProgress] >= 100)
        {
            GraffitCPInfo[playerid][gProgress] = 0.0;

            new
                Float:X, Float:Y, Float:Z, Float:angle,
                Float:distance = 0.49;

            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, angle);

            angle += 90.0;
            GetXYInFrontOfPlayer(playerid, X, Y, distance);

            new bool:is_crouching = GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK;
            Z += (is_crouching) ? (-0.3) : 0.7;
            CreateGraffit(playerid, grafid, GraffitInfo[grafid][gText], X, Y, Z, 0.0, 0.0, angle);
            GrafCreateStarted[playerid] = false;
            DestroyGraffitCheckpoint(playerid);
            DestroyPlayerProgressBar(playerid, gProgressBar[playerid]);
            InsertGraffitIntoDB(grafid);
        }
    }
    return 1;
}

stock LoadTags()
{
    inline OnTagsLoaded()
    {
        new rows  = cache_num_rows();
        if(!rows)
        {
            printf("MySQL Report: No spray tags exist to load.");
            return 1;
        }

        for (new b = 0; b < rows; b++)
        {
            cache_get_value_name_int  (b,   "id"        , TagInfo[b][tId]);
            cache_get_value_name_int  (b,   "modelid"   , TagInfo[b][tModelid]);
            cache_get_value_name_float(b,   "posx"      , TagInfo[b][tPosX]);
            cache_get_value_name_float(b,   "posy"      , TagInfo[b][tPosY]);
            cache_get_value_name_float(b,   "posz"      , TagInfo[b][tPosZ]);
            cache_get_value_name_float(b,   "rotx"      , TagInfo[b][tRotX]);
            cache_get_value_name_float(b,   "roty"      , TagInfo[b][tRotY]);
            cache_get_value_name_float(b,   "rotz"      , TagInfo[b][tRotZ]);
            cache_get_value_name_int  (b,   "faction"   , TagInfo[b][tFaction]);
            cache_get_value_name(b,         "author"    , TagInfo[b][tAuthor], MAX_PLAYER_NAME);

            SetFactionTagCount(TagInfo[b][tFaction], 1);
            TagInfo[b][tgObject] = CreateDynamicObject(TagInfo[b][tModelid], TagInfo[b][tPosX], TagInfo[b][tPosY], TagInfo[b][tPosZ],
                                                    TagInfo[b][tRotX], TagInfo[b][tRotY], TagInfo[b][tRotZ], 0, 0, -1, GRAFFIT_DRAW_DISTANCE);
            Iter_Add(SprayTags, b);
        }
        printf("MySQL Report: Spray Tags Loaded. [%d/%d]", Iter_Count(SprayTags), MAX_TAGS);
        return 1;
    }
    MySQL_TQueryInline(SQL_Handle(), 
        using inline OnTagsLoaded,
        va_fquery(SQL_Handle(), "SELECT * FROM spraytags WHERE 1 LIMIT 0,%d", MAX_TAGS), 
        ""
    );
    return 1;
}

stock GetSprayTagIdFromPlaya(playerid, Float:radius)
{
    new id = -1;
    foreach(new i : SprayTags)
    {
        if(GetPlayerDistanceFromPoint(playerid, TagInfo[i][tPosX], TagInfo[i][tPosY], TagInfo[i][tPosZ]) <= radius)
        {
            id = i;
            break;
        }
    }
    return id;
}

stock GetPlayerOrganisation(playerid)
{
    // TODO:
    // Organisation sounds like this is some general orgs system. Call it GetPlayerAssociatedGang or sth.
    // Might also want to move this function to a file that deals with factions/organisations.
    new porg = 0;
    // also wtf is this function, just return pMember/pLeader directly....
    // be sure to make an array of gang/organisation names if you'd like. like player was invited to join org Blabla
    // etc
    if(PlayerFaction[playerid][pMember] == 1 || PlayerFaction[playerid][pLeader] == 1)        porg = 1;
    else if(PlayerFaction[playerid][pMember] == 2 || PlayerFaction[playerid][pLeader] == 2)   porg = 2;
    else if(PlayerFaction[playerid][pMember] == 3 || PlayerFaction[playerid][pLeader] == 3)   porg = 3;
    else if(PlayerFaction[playerid][pMember] == 4 || PlayerFaction[playerid][pLeader] == 4)   porg = 4;
    else if(PlayerFaction[playerid][pMember] == 5 || PlayerFaction[playerid][pLeader] == 5)   porg = 5;   //MS-13
    else if(PlayerFaction[playerid][pMember] == 6 || PlayerFaction[playerid][pLeader] == 6)   porg = 6;   //Eastsiderz
    else if(PlayerFaction[playerid][pMember] == 7 || PlayerFaction[playerid][pLeader] == 7)   porg = 7;
    else if(PlayerFaction[playerid][pMember] == 8 || PlayerFaction[playerid][pLeader] == 8)   porg = 8;
    else if(PlayerFaction[playerid][pMember] == 9 || PlayerFaction[playerid][pLeader] == 9)   porg = 9;   //Bloods
    else if(PlayerFaction[playerid][pMember] == 10 || PlayerFaction[playerid][pLeader] == 10) porg = 10;
    else if(PlayerFaction[playerid][pMember] == 11 || PlayerFaction[playerid][pLeader] == 11) porg = 11;
    else if(PlayerFaction[playerid][pMember] == 12 || PlayerFaction[playerid][pLeader] == 12) porg = 12;
    else if(PlayerFaction[playerid][pMember] == 13 || PlayerFaction[playerid][pLeader] == 13) porg = 13;
    return porg;
}

stock ClearFactionTagCount()
{
    for (new i = 0; i < MAX_FACTIONS; i++)
    {
        FactionTagCount[i][ftTagCount] = 0;
    }
}

stock GetFactionTagCount(factionid)
{
    if(factionid < 1 || factionid > MAX_FACTIONS)
        return 0;

    return FactionTagCount[factionid-1][ftTagCount];
}

stock SetFactionTagCount(factionid, amount)
{
    if(factionid < 1 || factionid > MAX_FACTIONS)
        return 0;

    FactionTagCount[factionid-1][ftTagCount] += amount;
    return 1;
}

// TODO: I like this naming, graffiti are (usually) gang related
// TODO: this seems like unused/dead code, finish it or remove it
stock GetOfficialGangTag(playerid)
{
    #pragma unused playerid
    new
        //porg = GetPlayerOrganisation(playerid),
        tagid = 0;

    /*if(porg == 5)         tagid = VAGOS_TAG;
    else if(porg == 6)  tagid = TEMPLE_TAG;
    else if(porg == 9)  tagid = KILO_TAG;*/
    tagid = 0;
    return tagid;
}

stock InsertSprayTagIntoDB(tagid)
{
    mysql_fquery(SQL_Handle(),
        "INSERT INTO \n\
            spraytags \n\
        (modelid,posx,posy,posz,rotx,roty,rotz,faction,author) \n\
        VALUES \n\
            ('%d','%f','%f','%f','%f','%f','%f','%d','%e')",
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
    return 1;
}

stock CreateSprayTagCheckpoint(playerid, tagid, Float:X, Float:Y, Float:Z, Float:size = GRAFFIT_CHECKPOINT_SIZE)
{
    TagCPInfo[tagid][tCPX] = X;
    TagCPInfo[tagid][tCPY] = Y;
    TagCPInfo[tagid][tCPZ] = Z;
    TagCPInfo[tagid][tProgress] = 0.0;

    TagCPInfo[tagid][tCPId] = CreateDynamicCP(X, Y, Z, size, 0, 0, playerid, 30.0);
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
    // Try to find an empty slot
    if(tagid == -1)
    {
        tagid = Iter_Free(SprayTags);
    }
    // No empty slot - exit
    if(tagid == -1)
    {
        return 1;
    }

    Iter_Add(SprayTags, tagid);

    TagInfo[tagid][tId] = tagid;
    TagInfo[tagid][tModelid] = modelid;
    TagInfo[tagid][tFaction] = faction;

    TagInfo[tagid][tPosX] = X;
    TagInfo[tagid][tPosY] = Y;
    TagInfo[tagid][tPosZ] = Z;

    TagInfo[tagid][tRotX] = RotX;
    TagInfo[tagid][tRotY] = RotY;
    TagInfo[tagid][tRotZ] = RotZ;

    TagInfo[tagid][tgObject] = CreateDynamicObject(modelid, X, Y, Z, RotX, RotY, RotZ, 0, 0, -1, GRAFFIT_DRAW_DISTANCE);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagInfo[tagid][tgObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);

    if(playerid != INVALID_PLAYER_ID)
    {
        LastPlayerTag[playerid] = TagInfo[tagid][tgObject];
        // TODO: use strcpy
        format(TagInfo[tagid][tAuthor], 24, "%s", GetName(playerid, false));
    }

    InsertSprayTagIntoDB(tagid);
    DestroySprayTagCheckpoint(tagid);
    return 1;
}

stock EditSprayTag(tagid, Float:newX, Float:newY, Float:newZ, Float:newRotX, Float:newRotY, Float:newRotZ)
{
    TagInfo[tagid][tPosX] = newX;
    TagInfo[tagid][tPosY] = newY;
    TagInfo[tagid][tPosZ] = newZ;

    TagInfo[tagid][tRotX] = newRotX;
    TagInfo[tagid][tRotY] = newRotY;
    TagInfo[tagid][tRotZ] = newRotZ;

    mysql_fquery(SQL_Handle(), 
        "UPDATE spraytags SET posx = '%f', posy = '%f', posz = '%f', rotx = '%f', roty = '%f', rotz = '%f' WHERE id = '%d'",
        TagInfo[tagid][tPosX],
        TagInfo[tagid][tPosY],
        TagInfo[tagid][tPosZ],
        TagInfo[tagid][tRotX],
        TagInfo[tagid][tRotY],
        TagInfo[tagid][tRotZ],
        TagInfo[tagid][tId]
   );

    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagInfo[tagid][tgObject], E_STREAMER_DRAW_DISTANCE, GRAFFIT_DRAW_DISTANCE);
}

stock DestroySprayTag(tagid)
{
    if(IsValidDynamicObject(TagInfo[tagid][tgObject]))
        DestroyDynamicObject(TagInfo[tagid][tgObject]);

    mysql_fquery(SQL_Handle(), "DELETE FROM spraytags WHERE id = '%d'", TagInfo[tagid][tId]);

    TagInfo[tagid][tId]         = -1;
    TagInfo[tagid][tModelid]    = -1;
    TagCPInfo[tagid][tProgress] = 0;
    TagInfo[tagid][tFaction]    = -1;
    TagInfo[tagid][tgObject]    = -1;

    TagInfo[tagid][tPosX]       = 0.0;
    TagInfo[tagid][tPosY]       = 0.0;
    TagInfo[tagid][tPosZ]       = 0.0;

    TagInfo[tagid][tRotX]       = 0.0;
    TagInfo[tagid][tRotY]       = 0.0;
    TagInfo[tagid][tRotZ]       = 0.0;

    DestroySprayTagCheckpoint(tagid);
}

stock UpdateSprayTagProgress(playerid, tagid)
{
    if(!TagCPInfo[tagid][tProgress])
    {
        new
            Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);

        CreateSprayTagCheckpoint(playerid,tagid,X,Y,Z);
        TagID[playerid] = tagid;
        TagCPInfo[tagid][tProgress] += GRAFFIT_SPRAYING_UP;
        TagCreateStarted[playerid] = true;
    }
    else if(TagCPInfo[tagid][tProgress] > 0)
    {
        TagCPInfo[tagid][tProgress] += GRAFFIT_SPRAYING_UP;
        SetPlayerProgressBarValue(playerid, tProgressBar[playerid], TagCPInfo[tagid][tProgress]);

        if(TagCPInfo[tagid][tProgress] >= 100)
        {
            TagCreateStarted[playerid] = false;
            DestroySprayTagCheckpoint(tagid);
            DestroyPlayerProgressBar(playerid, tProgressBar[playerid]);

            new
                Float:X, Float:Y, Float:Z, Float:angle,
                Float:distance = 0.49;

            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, angle);

            angle += 90.0;
            GetXYInFrontOfPlayer(playerid, X, Y, distance);

            new bool:is_crouching = GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK;
            Z += (is_crouching) ? (-0.3) : 0.7;
            new
                org = GetPlayerOrganisation(playerid),
                string[64];
            CreateSprayTag(playerid, tagid, GetOfficialGangTag(playerid), X, Y, Z, 0.0, 0.0, angle, org);

            SetFactionTagCount(org, 1);
            format(string, sizeof(string), "] %d]", FactionTagCount[org-1][ftTagCount]);
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

ptask GraffitiTimer[1000](playerid)
{
    if(!SafeSpawned[playerid])
        return 1;
        
    SprayingBarChecker(playerid);
    SprayingTaggTimer(playerid);
    return 1;
}

static SprayingBarChecker(playerid)
{
    if(GrafCreateStarted[playerid])
    {
        if(!IsPlayerInRangeOfPoint(playerid, 2.5, GraffitCPInfo[playerid][gCPX], GraffitCPInfo[playerid][gCPY], GraffitCPInfo[playerid][gCPZ]))
            HidePlayerProgressBar(playerid, gProgressBar[playerid]);
    }
    else if(TagCreateStarted[playerid])
    {
        new tagid = TagID[playerid];
        if(!IsPlayerInRangeOfPoint(playerid, 2.5, TagCPInfo[tagid][tCPX], TagCPInfo[tagid][tCPY], TagCPInfo[tagid][tCPZ]))
            HidePlayerProgressBar(playerid, tProgressBar[playerid]);
    }
    return 1;
}

static SprayingTaggTimer(playerid)
{
    new newkeys, ud, lf; // lf = left-right=lr
    GetPlayerKeys(playerid, newkeys, ud, lf);

    if(HOLDING(KEY_FIRE))
    {
        if(AC_GetPlayerWeapon(playerid) == 41)
        {
            if(TagCreateStarted[playerid] && !GrafCreateStarted[playerid])
            {
                new tagid = TagID[playerid];
                if(!IsPlayerInRangeOfPoint(playerid, 1.5, TagCPInfo[tagid][tCPX], TagCPInfo[tagid][tCPY], TagCPInfo[tagid][tCPZ])) return 1;
                UpdateSprayTagProgress(playerid, tagid);
                SetPlayerProgressBarValue(playerid, tProgressBar[playerid], TagCPInfo[tagid][tProgress]);
                ShowPlayerProgressBar(playerid, tProgressBar[playerid]);
            }
            else if(!TagCreateStarted[playerid] && !GrafCreateStarted[playerid])
            {
                if(!GetOfficialGangTag(playerid)) return 1;
                if(GetFactionTagCount(GetPlayerOrganisation(playerid)) == 100) return 1;

                new tagid = Iter_Free(SprayTags);
                tProgressBar[playerid] = CreatePlayerProgressBar(playerid, 55.0, 319.0, _, _, 0x1932AAFF, 100.0);
                SetPlayerProgressBarValue(playerid, tProgressBar[playerid], 0.0);
                ShowPlayerProgressBar(playerid, tProgressBar[playerid]);
                UpdateSprayTagProgress(playerid, tagid);
            }
            if(GrafCreateStarted[playerid])
            {
                new grafid = GraffitiID[playerid];
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

hook function LoadServerData()
{
    LoadGraffits();
	LoadTags();
	return continue();

}

hook function ResetPlayerVariables(playerid)
{
    GraffitiID[playerid]	= -1;
	TagID[playerid] = -1;
	return continue(playerid);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(GrafCreateStarted[playerid])
    {
        GrafCreateStarted[playerid] = false;
        DestroyGraffitCheckpoint(playerid);
    }
    if(TagCreateStarted[playerid])
    {
        TagCreateStarted[playerid] = false;
        DestroySprayTagCheckpoint(TagID[playerid]);
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_GRAF_COLOR:
        {
            if(!response)
            {
                new next;
                Iter_SafeRemove(Graffits, GraffitiID[playerid], next);
                GraffitiID[playerid] = -1;
                return 1;
            }
            if(listitem < 0 || listitem > 9/*sizeof graffiti_colours*/)
            {
                // TODO: print not in range or silently fail?
                return 1;
            }
            new grafid = GraffitiID[playerid];
            // TODO: grafid limits check
            static const graffiti_colours[][20] =
            {
                {"Crnu"},
                {"Bijelu"},
                {"Tamno Plavu"},
                {"Svijetlo Plavu"},
                {"Zelenu"},
                {"Crvenu"},
                {"Smedu"},
                {"Narancastu"},
                {"Zlatnu"},
                {"Srebrnu"}
            };
            GraffitInfo[grafid][gColor] = listitem + 1;
            va_SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si %s boju za grafit! Sada odaberi font.", graffiti_colours[listitem]);
            SendClientMessage(playerid, 0xC70000FF, "Upamti: Da bi vidio font na grafitu moras imati taj font u racunalu, preuzmi ga sa foruma!");
            ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
            return 1;
        }
        case DIALOG_GRAF_FONT:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_GRAF_COLOR, DIALOG_STYLE_LIST, "Odaberi boju", "{141414}Crna\nBijela\n{0000A1}Tamno plava\n{3C82FF}Svijetlo plava\n{329D32}Zelena\n{BE0A0A}Crvena\n{502800}Smeda", "Choose", "Abort");
                return 1;
            }
            if(listitem < 0 || listitem > 11/*sizeof graffiti_fonts*/)
            {
                // TODO: print not in range or silently fail?
                return 1;
            }
            new grafid = GraffitiID[playerid];
            // TODO: grafid limits check
            static const graffiti_fonts[][22] =
            {
                {"Arial"},
                {"Dripping Marker"},
                {"Sick Capital Vice"},
                {"East Side Motel"},
                {"Whoa"},
                {"Juanalzada"},
                {"Urban Hook"},
                {"Amsterdam graffiti"},
                {"Old English"},
                {"Stylin'"},
                {"Painterz"},
                {"Freight Train Gangsta"}
            };
            GraffitInfo[grafid][gFont] = listitem + 1;
            va_SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si %s font.", graffiti_fonts[listitem]);
            ShowPlayerDialog(playerid, DIALOG_GRAF_SIZE, DIALOG_STYLE_LIST, "Velicina slova", "80\n90\n100\n110\n", "Choose", "Abort");
            return 1;
        }
        case DIALOG_GRAF_SIZE:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
                return 1;
            }
            if(listitem < 0 || listitem >4/*sizeof graffiti_fontsizes*/)
            {
                // TODO: print not in range or silently fail?
                return 1;
            }
            new grafid = GraffitiID[playerid];
            // TODO: grafid limits check
            static const graffiti_fontsizes[] =
            {
                60, 80, 90, 100, 110
            };
            GraffitInfo[grafid][gFontSize] =  graffiti_fontsizes[listitem];
            va_SendClientMessage(playerid, 0xFFE65AAA, "Odabrao si velicinu fonta: %d.", graffiti_fontsizes[listitem]);
            ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
            return 1;
        }
        case DIALOG_GRAF_TEXT:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_GRAF_FONT, DIALOG_STYLE_LIST, "Odaberi font", "Arial\nDripping Marker\nSick Capital Vice\nEast Side Motel\nWhoa\nJuanalzada\nUrban Hook\nAmsterdam graffiti\nOld English\nStylin'\nPainterz\nFreight Train Gangsta", "Choose", "Abort");
                return 1;
            }
            if(isnull(inputtext))
            {
                SendClientMessage(playerid, 0xFA5555AA, "Moras unijeti neki tekst!");
                ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
                return 1;
            }
            if(strlen(inputtext) > MAX_GRAFFIT_INPUT - 1)
            {
                va_SendClientMessage(playerid, 0xFA5555AA, "Prevelik text (1-%d znamenki)!",  MAX_GRAFFIT_INPUT - 1);
                ShowPlayerDialog(playerid, DIALOG_GRAF_TEXT, DIALOG_STYLE_INPUT, "Tekst", "Upisi tekst za grafit.", "Choose", "Abort");
                return 1;
            }

            new grafid = GraffitiID[playerid];
            // TODO: grafid limits check
            // TODO: use strcpy
            format(GraffitInfo[grafid][gText], 32, "%s", inputtext);
            GameTextForPlayer(playerid, "~w~Spraying time", 1000, 1);

            GrafCreateStarted[playerid] = true;
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
    if(!GrafApproved[playerid])
    {
        return 1;
    }

    new index = EditingGraffitiIndex[playerid];
    if(index == -1 /* TODO: or index out of bounds */)
    {
        return 1;
    }

    switch (GraffitiObjectEdit[playerid])
    {
        case EDIT_GRAFFIT:
        {
            if(response == EDIT_RESPONSE_FINAL)
            {
                SetDynamicObjectPos(GraffitInfo[index][gObject], x, y, z);
                SetDynamicObjectRot(GraffitInfo[index][gObject], rx, ry, rz);
                EditGraffit(index, x, y, z, rx, ry, rz);

                EditingGraffitiIndex[playerid] = 999;
                GraffitiObjectEdit[playerid]   = -1;
            }
            else if(response == EDIT_RESPONSE_CANCEL)
            {
                SetDynamicObjectPos(GraffitInfo[index][gObject], GraffitInfo[index][gPosX], GraffitInfo[index][gPosY], GraffitInfo[index][gPosZ]);
                SetDynamicObjectRot(GraffitInfo[index][gObject], GraffitInfo[index][gRotX], GraffitInfo[index][gRotY], GraffitInfo[index][gRotZ]);

                EditingGraffitiIndex[playerid] = 999;
                GraffitiObjectEdit[playerid]   = -1;
            }
        }
        case EDIT_SPRAYTAG:
        {
            if(response == EDIT_RESPONSE_FINAL)
            {
                SetDynamicObjectPos(TagInfo[index][tgObject], x, y, z);
                SetDynamicObjectRot(TagInfo[index][tgObject], rx, ry, rz);
                EditSprayTag(index, x, y, z, rx, ry, rz);

                EditingGraffitiIndex[playerid] = 999;
                GraffitiObjectEdit[playerid]   = -1;
            }
            else if(response == EDIT_RESPONSE_CANCEL)
            {
                SetDynamicObjectPos(TagInfo[index][tgObject], TagInfo[index][tPosX], TagInfo[index][tPosY], TagInfo[index][tPosZ]);
                SetDynamicObjectRot(TagInfo[index][tgObject], TagInfo[index][tRotX], TagInfo[index][tRotY], TagInfo[index][tRotZ]);

                EditingGraffitiIndex[playerid] = 999;
                GraffitiObjectEdit[playerid]   = -1;
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
    if(sscanf(params, "s[8] ", pick))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /spraytag [odabir]");
        SendClientMessage(playerid, COLOR_WHITE, "[Odabir]: edit, delete, adelete, author");
        return 1;
    }

    if(!strcmp(pick, "edit", true))
    {
        if(TagEditStarted[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec uredjujete jedan grafit!");

        if(PlayerInfo[playerid][pAdmin] >= 1)
        {
            new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
            if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");

            TagEditStarted[playerid] = true;
            EditDynamicObject(playerid, TagInfo[tagid][tgObject]);
            GraffitiObjectEdit[playerid] = EDIT_SPRAYTAG;
        }
        else
        {
            new tagid = GetPlayersSprayTag(playerid, LastPlayerTag[playerid], 5.0);
            if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");

            TagEditStarted[playerid] = true;
            EditDynamicObject(playerid, LastPlayerTag[playerid]);
            GraffitiObjectEdit[playerid] = EDIT_SPRAYTAG;
        }
    }
    else if(!strcmp(pick, "delete", true))
    {
        new tagid = GetPlayersSprayTag(playerid, LastPlayerTag[playerid], 2.0);
        if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");

        DestroySprayTag(tagid);
        SetFactionTagCount(GetPlayerOrganisation(playerid), -1);
    }
    else if(!strcmp(pick, "adelete", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
        new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
        if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog spray taga!");

        DestroySprayTag(tagid);
        SetFactionTagCount(TagInfo[tagid][tFaction], -1);
    }
    else if(!strcmp(pick, "author", true))
    {
        new tagid = GetSprayTagIdFromPlaya(playerid, 2.0);
        if(!tagid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog spray taga!");

        va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Autor grafita je: %s", TagInfo[tagid][tAuthor]);
    }
    return 1;
}

CMD:graffiti(playerid, params[])
{
    new pick[9];
    if(sscanf(params, "s[9] ", pick))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /graffiti [odabir] (create)");
        SendClientMessage(playerid, COLOR_WHITE, "[Odabir]: create, edit, delete, adelete, author, approve");
        return 1;
    }

    if(!strcmp(pick, "create", false, 6))
    {
        if(!GrafApproved[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dozvolu za grafite!");
        if(GetGraffitIdFromPlaya(playerid, 5.0) != -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne smijes postavljati tako blizu grafite!");

        GraffitiID[playerid] = Iter_Free(Graffits);
        Iter_Add(Graffits, GraffitiID[playerid]);
        ShowPlayerDialog(playerid, DIALOG_GRAF_COLOR, DIALOG_STYLE_LIST, "Odaberi boju", "{141414}Crna\nBijela\n{0000A1}Tamno plava\n{3C82FF}Svijetlo plava\n{329D32}Zelena\n{BE0A0A}Crvena\n{502800}Smeda\n{FF732D}Narandasta\n{FFD700}Zlatna\n{C0C0C0}Srebrna", "Choose", "Abort");
        return 1;
    }
    else if(!strcmp(pick, "edit", true))
    {
        if(GrafEditStarted[playerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec uredjujete jedan grafit!");

        if(PlayerInfo[playerid][pAdmin] >= 1)
        {
            new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
            if(grafid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");

            EditingGraffitiIndex[playerid] = grafid;
            GraffitiObjectEdit[playerid] = EDIT_GRAFFIT;
            EditDynamicObject(playerid,  GraffitInfo[grafid][gObject]);
        }
        else
        {
            new grafid = GetPlayersGraffit(playerid, LastPlayerGraffiti[playerid], 5.0);
            if(grafid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi u blizini svojega tagga!");

            EditingGraffitiIndex[playerid] = grafid;
            GraffitiObjectEdit[playerid] = EDIT_GRAFFIT;
            EditDynamicObject(playerid, LastPlayerGraffiti[playerid]);
        }
        return 1;
    }
    else if(!strcmp(pick, "delete", true))
    {
        new grafid = GetPlayersGraffit(playerid, LastPlayerGraffiti[playerid], 5.0);
        if(grafid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini svojega grafita!");

        if(!DestroyGraffit(grafid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se pogreska prilikom brisanja grafita!");
        return 1;
    }
    else if(!strcmp(pick, "adelete", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

        new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
        if(grafid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");

        if(!DestroyGraffit(grafid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se pogreska prilikom brisanja grafita!");
        return 1;
    }
    else if(!strcmp(pick, "author", true))
    {
        new grafid = GetGraffitIdFromPlaya(playerid, 2.0);
        if(grafid == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini niti jednog grafita!");

        va_SendClientMessage(playerid, COLOR_WHITE, "Autor grafita je: %s", GraffitInfo[grafid][gAuthor]);
        return 1;
    }
    else if(!strcmp(pick, "approve", true))
    {
        new giveplayerid;
        if(PlayerInfo[playerid][pAdmin] < 3) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
        if(sscanf(params, "s[9]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /graffit aprove [playerid / Part of name]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid!");

        GrafApproved[giveplayerid] = true;
        va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Admin %s ti je dao dozvolu za pravljenje grafita!", GetName(playerid, false));
        va_SendClientMessage(playerid, COLOR_RED, "[!] Dao si %s dozvolu za pravljenje grafita!", GetName(giveplayerid, false));
        return 1;
    }
    return 1;
}
