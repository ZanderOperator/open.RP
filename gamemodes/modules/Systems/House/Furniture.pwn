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
    ########  ######## ######## #### ##    ## ######## 
    ##     ## ##       ##        ##  ###   ## ##       
    ##     ## ##       ##        ##  ####  ## ##       
    ##     ## ######   ######    ##  ## ## ## ######   
    ##     ## ##       ##        ##  ##  #### ##       
    ##     ## ##       ##        ##  ##   ### ##       
    ########  ######## ##       #### ##    ## ######## 
*/

#define FURNITURE_OBJECT_DRAW_DISTANCE      (120.0)

// States
#define EDIT_STATE_PREVIEW                  (1)
#define EDIT_STATE_EDIT                     (2)


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static
    Iterator:HouseFurInt[MAX_HOUSES]<MAX_FURNITURE_SLOTS>;


static 
    FreeFurniture_Slot[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...};

enum E_BLANK_INTERIORS
{
    iName[23],
    iPrice,
    Float:iPosX,
    Float:iPosY,
    Float:iPosZ
}
new const BlankInts[][E_BLANK_INTERIORS] =
{
    {"Srednja kuca s 6 soba",    10000,    685.4221,      1553.4869,     1729.0823},
    {"Moderna kuca s 6 soba",    15000,    691.7216,      1801.3673,     1714.5059},
    {"Velika kuca s 8 soba",     25000,    702.0678,      2182.2925,     1732.3959},
    {"Moderna vila s 9 soba",    32000,    1168.3671,     2590.7131,     1725.4221},
    {"Velika kuca s 10 soba",    34000,    1193.6765,     2298.6533,     1724.3921},
    {"Moderna kuca s 12 soba",   13000,    1202.5499,     2007.8064,     1726.9103},
    {"Srednja kuca s 4 sobe",    10000,    1084.6836,     1869.2913,     1730.4631},
    {"Mala kuca s 4 sobe",       6000 ,    953.5984,      1419.1592,     1728.2208},
    {"Srednja kuca s 5 soba",    14000,    1200.3730,     1276.1937,     1727.9141},
    {"Srednja kuca s 5 soba",    14000,    1289.1748,     980.4117,      1727.4069},
    {"Srednja kuca s 6 soba",    15000,    1576.3699,     767.9655,      1727.3361},
    {"Mala kuca s 4 sobe",       6000 ,    1701.8140,     1087.3695,     1727.9139},
    {"Mala kuca s 4 sobe",       6000 ,    1789.2803,     1405.4039,     1749.2513},
    {"Moderna kuca s 5 soba",    20100,    1814.2644,     1595.2542,     1755.7681},
    {"Moderna kuca s 6 soba",    22000,    1770.1731,     1814.9844,     1753.0352},
    {"Velika kuca s 9 soba",     31000,    1866.7985,     2070.1890,     1752.0594},
    {"Srednja kuca s 4 sobe",    12000,    2036.5237,     2179.6602,     1755.2616},
    {"Srednja kuca s 4 sobe",    12000,    2235.9199,     1995.4877,     1753.9019},
    {"Srednja vila s 7 soba",    18000,    2474.0833,     1810.4570,     1752.0149},
    {"Velika kuca s 5 soba",     26000,    2442.6047,     2159.5417,     1795.0295},
    {"Srednja kuca s 7 soba",    23500,    -1096.0370,    402.0725,      1712.0914},
    {"Mala kuca s 2 sobe",       3000 ,    -1499.4155,    266.1354,      1712.1105},
    {"Srednja kuca s 4 sobe",    9000 ,    -1796.3438,    115.4369,      1775.8989},
    {"Velika kuca s 8 soba",     26000,    -1957.7827,    -397.4623,     1736.2277},
    {"Srednja kuca s 4 sobe",    13000,    -1859.5167,    -1033.6658,    1636.2637},
    {"Michelle room",            16000,    718.5154,      1566.5236,     1725.6801},
    {"CJ House",                 18000,    740.5174,      1625.1530,     1731.6100},
    {"Denise room",              7000,     228.7219,       304.0953,     1699.2080},
    {"Colonel Furhberger's",     15000,    2808.0779,     -1198.2340,    1725.6674},
    {"Skladiste",                50000,    1411.7208,     -73.7321,      1377.6754}
};


static
    texture_buffer      [10256],
    PreviewingInterior  [MAX_PLAYERS] = {-1, ...},
    EditState           [MAX_PLAYERS] = {-1, ...},

    FurObjectSection    [MAX_PLAYERS],
    FurnObjectsType     [MAX_PLAYERS],
    PlayerPrwsObject    [MAX_PLAYERS] = { INVALID_OBJECT_ID, ... },
    PlayerPrwsIndex     [MAX_PLAYERS],
    PlayerPrwsModel     [MAX_PLAYERS],
    PlayerEditIndex     [MAX_PLAYERS],
    PlayerEditObject    [MAX_PLAYERS] = { INVALID_OBJECT_ID, ... },
    PlayerEditType      [MAX_PLAYERS],
    PlayerEditTxtIndex  [MAX_PLAYERS],
    PlayerEditTxtSlot   [MAX_PLAYERS],
    PlayerEditingHouse  [MAX_PLAYERS] = { INVALID_HOUSE_ID, ... },
    PlayerEditClsIndex  [MAX_PLAYERS],
    LastTextureListIndex[MAX_PLAYERS],
    TextureDialogItem   [MAX_PLAYERS][16];

static
    PlayerText:IntBcg1 [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntTitle[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntBcg2 [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntName [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntPrice[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

// Forwards
forward OnFurnitureObjectsLoad(houseid);
forward OnFurnitureObjectCreates(houseid, index);

/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

/*
    d888888b d8b   db d888888b d88888b d8888b. d888888b  .d88b.  d8888b.
      88'   888o  88 ~~88~~' 88'     88  8D   88'   .8P  Y8. 88  8D
       88    88V8o 88    88    88ooooo 88oobY'    88    88    88 88oobY'
       88    88 V8o88    88    88~~~~~ 888b      88    88    88 888b
      .88.   88  V888    88    88.     88 88.   .88.   8b  d8' 88 88.
    Y888888P VP   V8P    YP    Y88888P 88   YD Y888888P  Y88P'  88   YD
*/

static stock DestroyFurnitureBlankIntTDs(playerid)
{
    if(IntBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntBcg1[playerid]);
        IntBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(IntBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntBcg2[playerid]);
        IntBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(IntTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntTitle[playerid]);
        IntTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(IntName[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntName[playerid]);
        IntName[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if(IntPrice[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntPrice[playerid]);
        IntPrice[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

static stock CreateFurnitureBlankIntTDs(playerid, name[], price)
{
    DestroyFurnitureBlankIntTDs(playerid);

    IntBcg1[playerid] = CreatePlayerTextDraw(playerid, 469.150146, 333.244110, "usebox");
    PlayerTextDrawLetterSize(playerid,      IntBcg1[playerid], 0.000000, 8.961110);
    PlayerTextDrawTextSize(playerid,        IntBcg1[playerid], 603.249877, 0.000000);
    PlayerTextDrawAlignment(playerid,       IntBcg1[playerid], 1);
    PlayerTextDrawColor(playerid,           IntBcg1[playerid], 0);
    PlayerTextDrawUseBox(playerid,          IntBcg1[playerid], true);
    PlayerTextDrawBoxColor(playerid,        IntBcg1[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       IntBcg1[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      IntBcg1[playerid], 0);
    PlayerTextDrawFont(playerid,            IntBcg1[playerid], 0);
    PlayerTextDrawShow(playerid,            IntBcg1[playerid]);

    IntTitle[playerid] = CreatePlayerTextDraw(playerid, 535.578063, 336.365112, "~y~] ~w~Interijeri ~y~]");
    PlayerTextDrawLetterSize(playerid,      IntTitle[playerid], 0.336248, 1.180559);
    PlayerTextDrawAlignment(playerid,       IntTitle[playerid], 2);
    PlayerTextDrawColor(playerid,           IntTitle[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       IntTitle[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      IntTitle[playerid], 1);
    PlayerTextDrawFont(playerid,            IntTitle[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, IntTitle[playerid], 51);
    PlayerTextDrawSetProportional(playerid, IntTitle[playerid], 1);
    PlayerTextDrawShow(playerid,            IntTitle[playerid]);

    IntBcg2[playerid] = CreatePlayerTextDraw(playerid, 607.449829, 333.188018, "usebox");
    PlayerTextDrawLetterSize(playerid,      IntBcg2[playerid], 0.000000, 2.004439);
    PlayerTextDrawTextSize(playerid,        IntBcg2[playerid], 465.500305, 0.000000);
    PlayerTextDrawAlignment(playerid,       IntBcg2[playerid], 1);
    PlayerTextDrawColor(playerid,           IntBcg2[playerid], 0);
    PlayerTextDrawUseBox(playerid,          IntBcg2[playerid], true);
    PlayerTextDrawBoxColor(playerid,        IntBcg2[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       IntBcg2[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      IntBcg2[playerid], 0);
    PlayerTextDrawFont(playerid,            IntBcg2[playerid], 0);
    PlayerTextDrawShow(playerid,            IntBcg2[playerid]);

    IntName[playerid] = va_CreatePlayerTextDraw(playerid, 473.499755, 358.175964, "~y~Naziv:~w~~n~   %s", name);
    PlayerTextDrawLetterSize(playerid,      IntName[playerid], 0.273249, 1.023760);
    PlayerTextDrawAlignment(playerid,       IntName[playerid], 1);
    PlayerTextDrawColor(playerid,           IntName[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       IntName[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      IntName[playerid], 1);
    PlayerTextDrawFont(playerid,            IntName[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, IntName[playerid], 51);
    PlayerTextDrawSetProportional(playerid, IntName[playerid], 1);
    PlayerTextDrawShow(playerid,            IntName[playerid]);

    IntPrice[playerid] = va_CreatePlayerTextDraw(playerid, 491.399902, 383.768005, "~y~Cijena:~w~~n~     %d~g~$", price);
    PlayerTextDrawLetterSize(playerid,      IntPrice[playerid], 0.308898, 1.188400);
    PlayerTextDrawAlignment(playerid,       IntPrice[playerid], 2);
    PlayerTextDrawColor(playerid,           IntPrice[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       IntPrice[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      IntPrice[playerid], 1);
    PlayerTextDrawFont(playerid,            IntPrice[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, IntPrice[playerid], 51);
    PlayerTextDrawSetProportional(playerid, IntPrice[playerid], 1);
    PlayerTextDrawShow(playerid,            IntPrice[playerid]);
}

static stock SetPlayerInteriorPreview(playerid, interior)
{
    if(playerid == INVALID_PLAYER_ID) return 0;
    if(interior > sizeof(BlankInts)) return 0;

    PreviewingInterior[playerid] = interior;
    va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno pregledavate interijer %s. Za kupnju kucajte /bint buy!", BlankInts[interior][iName]);
    CreateFurnitureBlankIntTDs(playerid, BlankInts[interior][iName], BlankInts[interior][iPrice]);
    SetPlayerPosEx(playerid, BlankInts[interior][iPosX], BlankInts[interior][iPosY], BlankInts[interior][iPosZ], playerid, 1, true);
    return 1;
}

static stock BuyBlankInterior(playerid, house)
{
    // TODO: house bounds check
    new interior = PreviewingInterior[playerid];

    if(AC_GetPlayerMoney(playerid) < BlankInts[interior][iPrice]) va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za kupovinu enterijera (%d$)!", BlankInts[interior][iPrice]);

    HouseInfo[house][hExitX] = BlankInts[interior][iPosX];
    HouseInfo[house][hExitY] = BlankInts[interior][iPosY];
    HouseInfo[house][hExitZ] = BlankInts[interior][iPosZ];

    mysql_fquery(g_SQL, "UPDATE houses SET exitX = '%f', exitY = '%f', exitZ = '%f' WHERE id = '%d'",
        HouseInfo[house][hExitX],
        HouseInfo[house][hExitY],
        HouseInfo[house][hExitZ],
        HouseInfo[house][hSQLID]
   );

    DestroyFurnitureBlankIntTDs(playerid);
    PlayerToBudgetMoney(playerid, BlankInts[interior][iPrice]); // Novac ide u proracun

    va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili interijer %s za %d$!",
        BlankInts[interior][iName],
        BlankInts[interior][iPrice]
   );
    DestroyAllFurnitureObjects(playerid, house);
    Storage_DeleteHouseRacks(playerid);
    SpawnPlayer(playerid);
    return 1;
}

static stock ExitBlankInteriorPreview(playerid)
{
    if(playerid == INVALID_PLAYER_ID) return 0;
    if(PreviewingInterior[playerid] == -1) return 0;

    DestroyFurnitureBlankIntTDs(playerid);

    new 
        house = PlayerKeys[playerid][pHouseKey];
    if(!House_Exists(house))
        return 1;

    SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ], 0, 0, true);
    SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste izasli iz pregleda interijera!");
    PreviewingInterior[playerid] = -1;
    return 1;
}

GetHouseFurnitureSlot(playerid, houseid)
{
    FreeFurniture_Slot[playerid] = Iter_Free(HouseFurInt[houseid]);
    return FreeFurniture_Slot[playerid];
}

GetFurnitureSlots(playerid, donator_level)
{
    if(PlayerInfo[playerid][pExtraFurniture] == 1)
        return FURNITURE_PREMIUM_OBJECTS;

    switch (donator_level)
    {
        case 0:
            return FURNITURE_VIP_NONE;
        case 1:
            return FURNITURE_VIP_BRONZE_OBJCTS;
        case 2:
            return FURNITURE_VIP_SILVER_OBJCTS;
        case 3,4:
            return FURNITURE_VIP_GOLD_OBJCTS;
    }
    return FURNITURE_VIP_NONE;
}

UpdatePremiumHouseFurSlots(playerid, admin_name = -1, houseid)
{
    if(!House_Exists(houseid))
        return 1;

    HouseInfo[houseid][hFurSlots] = GetFurnitureSlots(playerid, PlayerVIP[playerid][pDonateRank]);

    mysql_fquery(g_SQL, "UPDATE houses SET fur_slots = '%d' WHERE id = '%d'", 
        HouseInfo[houseid][hFurSlots], 
        HouseInfo[houseid][hSQLID]
   );

    if(admin_name != -1)
        va_SendClientMessage(playerid, COLOR_RED, "[!] Game Admin %s adjusted your House Furniture Slots, now you have %d slots available.", GetName(admin_name, true), HouseInfo[houseid][hFurSlots]);
    return 1;
}

SetPlayerPremiumFurniture(playerid, houseid)
{
    if(!House_Exists(houseid))
        return 1;

    HouseInfo[houseid][hFurSlots] = (FURNITURE_PREMIUM_OBJECTS);
    PlayerInfo[playerid][pExtraFurniture] = 1;

    mysql_fquery(g_SQL, "UPDATE houses SET fur_slots = '%d' WHERE id = '%d'", 
        HouseInfo[houseid][hFurSlots], 
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

/*
     .d88b.  d8888b.    d88b d88888b  .o88b. d888888b .d8888.
    .8P  Y8. 88  8D    8P' 88'     d8P  Y8 ~~88~~' 88'  YP
    88    88 88oooY'     88  88ooooo 8P         88    8bo.
    88    88 88~~~b.     88  88~~~~~ 8b         88      Y8b.
    8b  d8' 88   8D db. 88  88.     Y8b  d8    88    db   8D
     Y88P'  Y8888P' Y8888P  Y88888P  Y88P'    YP    8888Y'
*/

public OnFurnitureObjectsLoad(houseid)
{
    // TODO: houseid bounds check
    if(!cache_num_rows())
        return 0;

    new objectCount = cache_num_rows();
    if(objectCount > MAX_FURNITURE_SLOTS)
        objectCount = MAX_FURNITURE_SLOTS;

    new i;
    for (i = 0; i < objectCount; i++)
    {
        HouseInfo[houseid][hExists][i] = 1; // 1 = created.
        HouseInfo[houseid][hFurCounter]++;

        cache_get_value_name_int  (i,    "sqlid"      ,    HouseInfo[houseid][hFurSQL][i]);
        cache_get_value_name_int  (i,    "modelid"    ,    HouseInfo[houseid][hFurModelid][i]);
        cache_get_value_name_int  (i,    "door"       ,    HouseInfo[houseid][hFurDoor][i]);
        cache_get_value_name_float(i,    "door_z"     ,    HouseInfo[houseid][hFurDoorZ][i]);
        cache_get_value_name_int  (i,    "locked_door",    HouseInfo[houseid][hFurDoorLckd][i]);
        cache_get_value_name_float(i,    "pos_x"      ,    HouseInfo[houseid][hFurPosX][i]);
        cache_get_value_name_float(i,    "pos_y"      ,    HouseInfo[houseid][hFurPosY][i]);
        cache_get_value_name_float(i,    "pos_z"      ,    HouseInfo[houseid][hFurPosZ][i]);
        cache_get_value_name_float(i,    "rot_x"      ,    HouseInfo[houseid][hFurRotX][i]);
        cache_get_value_name_float(i,    "rot_y"      ,    HouseInfo[houseid][hFurRotY][i]);
        cache_get_value_name_float(i,    "rot_z"      ,    HouseInfo[houseid][hFurRotZ][i]);
        cache_get_value_name_int  (i,    "texture_1"  ,    HouseInfo[houseid][hFurTxtId][i][0]);
        cache_get_value_name_int  (i,    "texture_2"  ,    HouseInfo[houseid][hFurTxtId][i][1]);
        cache_get_value_name_int  (i,    "texture_3"  ,    HouseInfo[houseid][hFurTxtId][i][2]);
        cache_get_value_name_int  (i,    "texture_4"  ,    HouseInfo[houseid][hFurTxtId][i][3]);
        cache_get_value_name_int  (i,    "texture_5"  ,    HouseInfo[houseid][hFurTxtId][i][4]);
        cache_get_value_name_int  (i,    "color_1"    ,    HouseInfo[houseid][hFurColId][i][0]);
        cache_get_value_name_int  (i,    "color_2"    ,    HouseInfo[houseid][hFurColId][i][1]);
        cache_get_value_name_int  (i,    "color_3"    ,    HouseInfo[houseid][hFurColId][i][2]);
        cache_get_value_name_int  (i,    "color_4"    ,    HouseInfo[houseid][hFurColId][i][3]);
        cache_get_value_name_int  (i,    "color_5"    ,    HouseInfo[houseid][hFurColId][i][4]);
        Iter_Add(HouseFurInt[houseid], i);
    }

    for (i = 0; i < objectCount; i++)
    {
        HouseInfo[houseid][hFurObjectid][i] = CreateDynamicObject(HouseInfo[houseid][hFurModelid][i], HouseInfo[houseid][hFurPosX][i], HouseInfo[houseid][hFurPosY][i], HouseInfo[houseid][hFurPosZ][i], HouseInfo[houseid][hFurRotX][i], HouseInfo[houseid][hFurRotY][i], HouseInfo[houseid][hFurRotZ][i], HouseInfo[houseid][hVirtualWorld], HouseInfo[houseid][hInt], -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);

        // TODO: repetitive code
        new
            colorid;
        for (new colslot = 0; colslot < MAX_COLOR_TEXT_SLOTS; colslot++)
        {
            if(HouseInfo[houseid][hFurColId][i][colslot] > -1)
            {
                sscanf(ColorList[HouseInfo[houseid][hFurColId][i][colslot]][clRGB], "h", colorid);
                SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][i], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tName], colorid);
            }
            else
            {
                SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][i], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][i][colslot]][tName], 0);
            }
        }
    }
    HouseInfo[houseid][hFurLoaded] = true;
    return 1;
}

static stock InsertFurnitureObject(houseid, index)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, 
            "INSERT INTO furniture(houseid, modelid, door, door_z, locked_door, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z,\n\
                texture_1, texture_2, texture_3, texture_4, texture_5, color_1, color_2, color_3, color_4, color_5) \n\
                VALUES ('%d', '%d', '%d', '%f', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d','%d',\n\
                '%d', '%d', '%d', '%d', '%d')",
            HouseInfo[houseid][hSQLID],
            HouseInfo[houseid][hFurModelid][index],
            HouseInfo[houseid][hFurDoor][index],
            HouseInfo[houseid][hFurDoorZ][index],
            HouseInfo[houseid][hFurDoorLckd][index],
            HouseInfo[houseid][hFurPosX][index],
            HouseInfo[houseid][hFurPosY][index],
            HouseInfo[houseid][hFurPosZ][index],
            HouseInfo[houseid][hFurRotX][index],
            HouseInfo[houseid][hFurRotY][index],
            HouseInfo[houseid][hFurRotZ][index],
            HouseInfo[houseid][hFurTxtId][index][0],
            HouseInfo[houseid][hFurTxtId][index][1],
            HouseInfo[houseid][hFurTxtId][index][2],
            HouseInfo[houseid][hFurTxtId][index][3],
            HouseInfo[houseid][hFurTxtId][index][4],
            HouseInfo[houseid][hFurColId][index][0],
            HouseInfo[houseid][hFurColId][index][1],
            HouseInfo[houseid][hFurColId][index][2],
            HouseInfo[houseid][hFurColId][index][3],
            HouseInfo[houseid][hFurColId][index][4]
       ), 
        "OnFurnitureObjectCreates", 
        "ii", 
        houseid, 
        index
   );
    return 1;
}

public OnFurnitureObjectCreates(houseid, index)
{
    HouseInfo[houseid][hFurSQL][index] = cache_insert_id();
    Iter_Add(HouseFurInt[houseid], index);
}

stock LoadHouseFurnitureObjects(houseid)
{
    if(!House_Exists(houseid))
        return 1;
   
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM furniture WHERE houseid = '%d'", HouseInfo[houseid][hSQLID]), 
        "OnFurnitureObjectsLoad", 
        "i", 
        houseid
   );
    return 1;
}

stock ResetHouseFurnitureEnum(houseid)
{
    // TODO: houseid bounds check
    foreach(new index: HouseFurInt[houseid])
    {
        if(IsValidDynamicObject(HouseInfo[houseid][hFurObjectid][index]))
        {
            DestroyDynamicObject(HouseInfo[houseid][hFurObjectid][index]);
            HouseInfo[houseid][hFurObjectid][index] = INVALID_OBJECT_ID;
        }
        HouseInfo[houseid][hFurSQL][index]        = 0;
        HouseInfo[houseid][hFurModelid][index]    = -1;
        HouseInfo[houseid][hExists][index]        = 0;
        HouseInfo[houseid][hFurCounter]          = 0;
        HouseInfo[houseid][hFurObjectid][index]   = INVALID_OBJECT_ID;
        HouseInfo[houseid][hFurPosX][index]       = 0.0;
        HouseInfo[houseid][hFurPosY][index]       = 0.0;
        HouseInfo[houseid][hFurPosZ][index]       = 0.0;
        HouseInfo[houseid][hFurRotX][index]       = 0.0;
        HouseInfo[houseid][hFurRotY][index]       = 0.0;
        HouseInfo[houseid][hFurRotZ][index]       = 0.0;
        HouseInfo[houseid][hFurColId][index][0]   = -1;
        HouseInfo[houseid][hFurColId][index][1]   = -1;
        HouseInfo[houseid][hFurColId][index][2]   = -1;
        HouseInfo[houseid][hFurColId][index][3]   = -1;
        HouseInfo[houseid][hFurColId][index][4]   = -1;
        HouseInfo[houseid][hFurTxtId][index][0]   = 0;
        HouseInfo[houseid][hFurTxtId][index][1]   = 0;
        HouseInfo[houseid][hFurTxtId][index][2]   = 0;
        HouseInfo[houseid][hFurTxtId][index][3]   = 0;
        HouseInfo[houseid][hFurTxtId][index][4]   = 0;
    }
    HouseInfo[houseid][hFurLoaded] = false;
    return 1;
}

static stock GetPlayerFurnitureHouse(playerid)
{
    new 
        houseid = INVALID_HOUSE_ID;
    if(PlayerEditingHouse[playerid] != INVALID_HOUSE_ID)
    {
        if(Player_InHouse(playerid) == PlayerEditingHouse[playerid])
            houseid = PlayerEditingHouse[playerid];
    }
    else if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
    {
        if(Player_InHouse(playerid) == PlayerKeys[playerid][pHouseKey])
            houseid = PlayerKeys[playerid][pHouseKey];
    }
    return houseid;
}

static stock GetFurnitureObjectName(playerid, index)
{
    // TODO: use strcpy
    // TODO: index bounds check
    new name[50];
    switch (FurnObjectsType[playerid])
    {
        case 1:
        { // Dnevna
            switch (FurObjectSection[playerid])
            {
                case 0: format(name, sizeof(name), ObjectsCouch[index][ceName]);
                case 1: format(name, sizeof(name), ObjectsArmChair[index][armName]);
                case 2: format(name, sizeof(name), ObjectsTables[index][tablName]);
                case 3: format(name, sizeof(name), ObjectsCabinets[index][cabName]);
                case 4: format(name, sizeof(name), ObjectsTelevision[index][tvName]);
                case 5: format(name, sizeof(name), ObjectsVideo[index][vidName]);
                case 6: format(name, sizeof(name), ObjectsHiFi[index][hfName]);
                case 7: format(name, sizeof(name), ObjectsStereo[index][stName]);
                case 8: format(name, sizeof(name), ObjectsRugs[index][rName]);
                case 9: format(name, sizeof(name), ObjectsLights[index][lgtName]);
                case 10: format(name, sizeof(name), ObjectsDoor[index][doorName]);
            }
        }
        case 2:
        { // Kuhinja
            switch (FurObjectSection[playerid])
            {
                case 0: format(name, sizeof(name), ObjectsFridge[index][frName]);
                case 1: format(name, sizeof(name), ObjectsKitchenCabinets[index][kcName]);
                case 2: format(name, sizeof(name), ObjectsSink[index][snkName]);
                case 3: format(name, sizeof(name), ObjectsStove[index][stName]);
                case 4: format(name, sizeof(name), ObjectsMicroWave[index][mwName]);
                case 5: format(name, sizeof(name), ObjectsTrashCan[index][tcName]);
                case 6: format(name, sizeof(name), ObjectsLights[index][lgtName]);
                case 7: format(name, sizeof(name), ObjectsKitchenDishes[index][dishName]);
            }
        }
        case 3:
        { // Kupaona
            switch (FurObjectSection[playerid])
            {
                case 0: format(name, sizeof(name), ObjectsToilet[index][toName]);
                case 1: format(name, sizeof(name), ObjectsBath[index][baName]);
                case 2: format(name, sizeof(name), ObjectsMirror[index][miName]);
            }
        }
        case 4:
        { // Soba
            switch (FurObjectSection[playerid])
            {
                case 0: format(name, sizeof(name), ObjectsBed[index][bdName]);
                case 1: format(name, sizeof(name), ObjectsNightStand[index][nsName]);
                case 2: format(name, sizeof(name), ObjectsChest[index][cName]);
                case 3: format(name, sizeof(name), ObjectsClothes[index][cloName]);
                case 4: format(name, sizeof(name), ObjectsPlants[index][plntName]);
                case 5: format(name, sizeof(name), ObjectsPaint[index][pntName]);
                case 6: format(name, sizeof(name), ObjectsLights[index][lgtName]);
                case 7: format(name, sizeof(name), ObjectsTables[index][tablName]);
                case 8: format(name, sizeof(name), ObjectsChair[index][chName]);
                case 9: format(name, sizeof(name), ObjectsHeater[index][htrName]);
                case 10: format(name, sizeof(name), ObjectsCurtains[index][crtName]);
                case 11: format(name, sizeof(name), ObjectsWindows[index][wnName]);
            }
        }
        case 5:
        { // Ostalo
            switch (FurObjectSection[playerid])
            {
                case 0: format(name, sizeof(name), ObjectsFun[index][fnName]);
                case 1: format(name, sizeof(name), ObjectsDrinks[index][drnksName]);
                case 2: format(name, sizeof(name), ObjectsSports[index][gmName]);
                case 3: format(name, sizeof(name), ObjectsRest[index][etcName]);
                case 4: format(name, sizeof(name), ObjectsWalls[index][wlName]);
                case 5: format(name, sizeof(name), ObjectsAnimals[index][amName]);
                case 6: format(name, sizeof(name), ObjectsOffice[index][ofName]);
                case 7: format(name, sizeof(name), FurnitureM[index][fmName]);
                case 8: format(name, sizeof(name), ObjectsFood[index][foodName]);
            }
        }
    }
    return name;
}

static stock GetFurnitureObjectPrice(playerid, index)
{
    new price = 0;
    // TODO: index bounds check
    switch (FurnObjectsType[playerid])
    {
        case 1:
        { // Dnevna
            switch (FurObjectSection[playerid])
            {
                case 0: price = ObjectsCouch[index][cePrice];
                case 1: price = ObjectsArmChair[index][armPrice];
                case 2: price = ObjectsTables[index][tablPrice];
                case 3: price = ObjectsCabinets[index][cabPrice];
                case 4: price = ObjectsTelevision[index][tvPrice];
                case 5: price = ObjectsVideo[index][vidPrice];
                case 6: price = ObjectsHiFi[index][hfPrice];
                case 7: price = ObjectsStereo[index][stPrice];
                case 8: price = ObjectsRugs[index][rPrice];
                case 9: price = ObjectsLights[index][lgtPrice];
                case 10: price = ObjectsDoor[index][doorPrice];
            }
        }
        case 2:
        { // Kuhinja
            switch (FurObjectSection[playerid])
            {
                case 0: price = ObjectsFridge[index][frPrice];
                case 1: price = ObjectsKitchenCabinets[index][kcPrice];
                case 2: price = ObjectsSink[index][snkPrice];
                case 3: price = ObjectsStove[index][stPrice];
                case 4: price = ObjectsMicroWave[index][mwPrice];
                case 5: price = ObjectsTrashCan[index][tcPrice];
                case 6: price = ObjectsLights[index][lgtPrice];
                case 7: price = ObjectsKitchenDishes[index][dishPrice];
            }
        }
        case 3:
        { // Kupaona
            switch (FurObjectSection[playerid])
            {
                case 0: price = ObjectsToilet[index][toPrice];
                case 1: price = ObjectsBath[index][baPrice];
                case 2: price = ObjectsMirror[index][miPrice];
            }
        }
        case 4:
        { // Soba
            switch (FurObjectSection[playerid])
            {
                case 0:  price = ObjectsBed[index][bdPrice];
                case 1:  price = ObjectsNightStand[index][nsPrice];
                case 2:  price = ObjectsChest[index][cPrice];
                case 3:  price = ObjectsClothes[index][cloPrice];
                case 4:  price = ObjectsPlants[index][plntPrice];
                case 5:  price = ObjectsPaint[index][pntPrice];
                case 6:  price = ObjectsLights[index][lgtPrice];
                case 7:  price = ObjectsTables[index][tablPrice];
                case 8:  price = ObjectsChair[index][chPrice];
                case 9:  price = ObjectsHeater[index][htrPrice];
                case 10: price = ObjectsCurtains[index][crtPrice];
                case 11: price = ObjectsWindows[index][wnPrice];
            }
        }
        case 5:
        { // Ostalo
            switch (FurObjectSection[playerid])
            {
                case 0: price = ObjectsFun[index][fnPrice];
                case 1: price = ObjectsDrinks[index][drnksPrice];
                case 2: price = ObjectsSports[index][gmPrice];
                case 3: price = ObjectsRest[index][etcPrice];
                case 4: price = ObjectsWalls[index][wlPrice];
                case 5: price = ObjectsAnimals[index][amPrice];
                case 6: price = ObjectsOffice[index][ofPrice];
                case 7: price = FurnitureM[index][fmPrice];
                case 8: price = ObjectsFood[index][foodPrice];
            }
        }
    }
    return price;
}

static stock GetFurnitureObjectModel(playerid, index)
{
    new modelid;
    // TODO: index bounds check
    switch (FurnObjectsType[playerid])
    {
        case 1:
        { // Dnevna
            switch (FurObjectSection[playerid])
            {
                case 0: modelid = ObjectsCouch[index][ceId];
                case 1: modelid = ObjectsArmChair[index][armId];
                case 2: modelid = ObjectsTables[index][tablId];
                case 3: modelid = ObjectsCabinets[index][cabId];
                case 4: modelid = ObjectsTelevision[index][tvId];
                case 5: modelid = ObjectsVideo[index][vidId];
                case 6: modelid = ObjectsHiFi[index][hfId];
                case 7: modelid = ObjectsStereo[index][stId];
                case 8: modelid = ObjectsRugs[index][rId];
                case 9: modelid = ObjectsLights[index][lgtId];
                case 10: modelid = ObjectsDoor[index][doorId];
            }
        }
        case 2:
        { // Kuhinja
            switch (FurObjectSection[playerid])
            {
                case 0: modelid = ObjectsFridge[index][frId];
                case 1: modelid = ObjectsKitchenCabinets[index][kcId];
                case 2: modelid = ObjectsSink[index][snkId];
                case 3: modelid = ObjectsStove[index][stId];
                case 4: modelid = ObjectsMicroWave[index][mwId];
                case 5: modelid = ObjectsTrashCan[index][tcId];
                case 6: modelid = ObjectsLights[index][lgtId];
                case 7: modelid = ObjectsKitchenDishes[index][dishId];
            }
        }
        case 3:
        { // Kupaona
            switch (FurObjectSection[playerid])
            {
                case 0: modelid = ObjectsToilet[index][toId];
                case 1: modelid = ObjectsBath[index][baId];
                case 2: modelid = ObjectsMirror[index][miId];
            }
        }
        case 4:
        { // Soba
            switch (FurObjectSection[playerid])
            {
                case 0:  modelid = ObjectsBed[index][bdId];
                case 1:  modelid = ObjectsNightStand[index][nsId];
                case 2:  modelid = ObjectsChest[index][cId];
                case 3:  modelid = ObjectsClothes[index][cloId];
                case 4:  modelid = ObjectsPlants[index][plntId];
                case 5:  modelid = ObjectsPaint[index][pntId];
                case 6:  modelid = ObjectsLights[index][lgtId];
                case 7:  modelid = ObjectsTables[index][tablId];
                case 8:  modelid = ObjectsChair[index][chId];
                case 9:  modelid = ObjectsHeater[index][htrId];
                case 10: modelid = ObjectsCurtains[index][crtId];
                case 11: modelid = ObjectsWindows[index][wnId];
            }
        }
        case 5:
        { // Ostalo
            switch (FurObjectSection[playerid])
            {
                case 0: modelid = ObjectsFun[index][fnId];
                case 1: modelid = ObjectsDrinks[index][drnksId];
                case 2: modelid = ObjectsSports[index][gmId];
                case 3: modelid = ObjectsRest[index][etcId];
                case 4: modelid = ObjectsWalls[index][wlId];
                case 5: modelid = ObjectsAnimals[index][amId];
                case 6: modelid = ObjectsOffice[index][ofId];
                case 7: modelid = FurnitureM[index][fmId];
                case 8: modelid = ObjectsFood[index][foodId];
            }
        }
    }
    return modelid;
}

RotateHouseFurDoor(houseid, playerid)
{
    foreach(new i: HouseFurInt[houseid])
    {
        if(HouseInfo[houseid][hFurDoor][i])
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[houseid][hFurPosX][i], HouseInfo[houseid][hFurPosY][i], HouseInfo[houseid][hFurPosZ][i]))
            {
                SetFurnitureDoorRotation(houseid, i);
                break;
            }
        }
    }
}

// TODO: Erm, I think I saw this exact pieces of code somewhere else...
// Code duplication (3 functions below)
static stock ShowPlayerTextureList(playerid)
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastTextureListIndex[playerid] - 1) ? 1 : ((LastTextureListIndex[playerid] - 1) * 15),
        max_amount = LastTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        format(motd, sizeof(motd), "%d\t%s\t%s\n",
            ObjectTextures[i][tModel],
            ObjectTextures[i][tTXDName],
            ObjectTextures[i][tName]
       );
        strcat(texture_buffer, motd);

        if(ObjectTextures[i][tModel] == 1319)
            break;

        TextureDialogItem[playerid][dialogPos] = i;
        dialogPos++;
    }
    format(motd, sizeof(motd), "Potrazi teksturu\n%s%s", (LastTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    strcat(texture_buffer, motd);
    return texture_buffer;
}

static stock ShowSearchedTextureList(playerid, string[])
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastTextureListIndex[playerid] - 1) ? 1 : ((LastTextureListIndex[playerid] - 1) * 15),
        max_amount = LastTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        if(strfind(ObjectTextures[i][tTXDName], string, true) != -1)
        {
            format(motd, sizeof(motd), "%d\t%s\t%s\n",
                ObjectTextures[i][tModel],
                ObjectTextures[i][tTXDName],
                ObjectTextures[i][tName]
           );
            strcat(texture_buffer, motd);

            if(ObjectTextures[i][tModel] == 1319)
                break;

            TextureDialogItem[playerid][dialogPos] = i;
            dialogPos++;
        }
    }
    format(motd, sizeof(motd), "Potrazi teksturu\n%s%s", texture_buffer, (LastTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    strcat(texture_buffer, motd);
    return texture_buffer;
}

static stock ShowModelSearchedTextureList(playerid, modelid)
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastTextureListIndex[playerid] - 1) ? 1 : ((LastTextureListIndex[playerid] - 1) * 15),
        max_amount = LastTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        if(ObjectTextures[i][tModel] == modelid)
        {
            format(motd, sizeof(motd), "%d\t%s\t%s\n",
                ObjectTextures[i][tModel],
                ObjectTextures[i][tTXDName],
                ObjectTextures[i][tName]
           );
            strcat(texture_buffer, motd);

            if(ObjectTextures[i][tModel] == 1319)
                break;

            TextureDialogItem[playerid][dialogPos] = i;
            dialogPos++;
        }
    }
    format(motd, sizeof(motd), "Potrazi teksturu\n%s%s", texture_buffer, (LastTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    strcat(texture_buffer, motd);
    return texture_buffer;
}

static stock GetPlayerTextureItem(playerid, listitem)
{
    new
        index = 1,
        i     = 0;

    while (i < 15)
    {
        if(i == listitem)
        {
            index = TextureDialogItem[playerid][i];
            break;
        }
        i++;
    }
    return index;
}

static stock CreateFurniturePreviewObject(playerid, modelid, index)
{
    if(playerid == INVALID_PLAYER_ID) return 0;

    new
        Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    GetXYInFrontOfPlayer(playerid, X, Y, 5.0);
    PlayerPrwsObject[playerid]    = CreatePlayerObject(playerid, modelid, X, Y, Z, 0.0, 0.0, 0.0);
    EditPlayerObject(playerid, PlayerPrwsObject[playerid]);

    PlayerPrwsIndex[playerid]     = index;
    PlayerPrwsModel[playerid]     = modelid;

    SendMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno uredjujete objekt. Kliknite na save ikonicu za kupovinu objekta!");
    EditState[playerid] = EDIT_STATE_PREVIEW;
    return 1;
}

static stock CreateFurnitureObject(playerid, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bool:doors)
{
    if(playerid == INVALID_PLAYER_ID) return 0;

    new 
        houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    new 
        index = GetHouseFurnitureSlot(playerid, houseid);
    if(index == -1)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno mjesta za objekte!");
    if(HouseInfo[houseid][hFurCounter] >= GetFurnitureSlots(playerid, PlayerVIP[playerid][pDonateRank]))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno mjesta za objekte!");
    
    HouseInfo[houseid][hFurModelid][index]  = modelid;
    HouseInfo[houseid][hFurPosX][index]     = x;
    HouseInfo[houseid][hFurPosY][index]     = y;
    HouseInfo[houseid][hFurPosZ][index]     = z;
    HouseInfo[houseid][hFurRotX][index]     = rx;
    HouseInfo[houseid][hFurRotY][index]     = ry;
    HouseInfo[houseid][hFurRotZ][index]     = rz;
    HouseInfo[houseid][hFurTxtId][index][0] = 0;
    HouseInfo[houseid][hFurTxtId][index][1] = 0;
    HouseInfo[houseid][hFurTxtId][index][2] = 0;
    HouseInfo[houseid][hFurTxtId][index][3] = 0;
    HouseInfo[houseid][hFurTxtId][index][4] = 0;
    HouseInfo[houseid][hFurColId][index][0] = -1;
    HouseInfo[houseid][hFurColId][index][1] = -1;
    HouseInfo[houseid][hFurColId][index][2] = -1;
    HouseInfo[houseid][hFurColId][index][3] = -1;
    HouseInfo[houseid][hFurColId][index][4] = -1;
    HouseInfo[houseid][hExists][index]      = 1;
    HouseInfo[houseid][hFurCounter]++;

    if(doors)
    {
        HouseInfo[houseid][hFurDoor][index]     = 1;
        HouseInfo[houseid][hFurDoorZ][index]    = -1.0;
        HouseInfo[houseid][hFurDoorLckd][index] = 0;
    }

    if(IsValidPlayerObject(playerid, PlayerPrwsObject[playerid]))
    {
        DestroyPlayerObject(playerid, PlayerPrwsObject[playerid]);
        PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
    }

    InsertFurnitureObject(houseid, index);

    HouseInfo[houseid][hFurObjectid][index] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, HouseInfo[houseid][hVirtualWorld], HouseInfo[houseid][hInt], -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);

    new price = GetFurnitureObjectPrice(playerid, PlayerPrwsIndex[playerid]);
    va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupili ste objekt za %d$ i stavili ga u slot %d!", price, index + 1);
    PlayerToBudgetMoney(playerid, price); // novac ide u proracun
    EditState[playerid] = 0;

    #if defined MODULE_LOGS
    Log_Write("/logfiles/furniture_buy.txt", "(%s) Player %s bought an object(modelid: %d) for %d$ in House Furniture and placed it into slot %d.",
        ReturnDate(),
        GetName(playerid, false),
        modelid,
        price,
        index
   );
    #endif
    PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
    PlayerPrwsIndex [playerid] = -1;
    PlayerPrwsModel [playerid] = -1;
    FurObjectSection[playerid] = 0;
    FurnObjectsType [playerid] = 0;
    Streamer_Update(playerid);

    return index;
}

static stock CopyFurnitureObject(playerid, copyid)
{
    if(playerid == INVALID_PLAYER_ID) return 0;

    new houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    new index = Iter_Free(HouseFurInt[houseid]);
    if(HouseInfo[houseid][hFurCounter] == GetFurnitureSlots(playerid, PlayerVIP[playerid][pDonateRank]))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno mjesta za objekte!");

    HouseInfo[houseid][hFurCounter]++;
    HouseInfo[houseid][hExists][index]      = 1;
    HouseInfo[houseid][hFurModelid][index]  = HouseInfo[houseid][hFurModelid][copyid];
    HouseInfo[houseid][hFurPosX][index]     = HouseInfo[houseid][hFurPosX][copyid];
    HouseInfo[houseid][hFurPosY][index]     = HouseInfo[houseid][hFurPosY][copyid];
    HouseInfo[houseid][hFurPosZ][index]     = HouseInfo[houseid][hFurPosZ][copyid];
    HouseInfo[houseid][hFurRotX][index]     = HouseInfo[houseid][hFurRotX][copyid];
    HouseInfo[houseid][hFurRotY][index]     = HouseInfo[houseid][hFurRotY][copyid];
    HouseInfo[houseid][hFurRotZ][index]     = HouseInfo[houseid][hFurRotZ][copyid];
    HouseInfo[houseid][hFurTxtId][index][0] = HouseInfo[houseid][hFurTxtId][copyid][0];
    HouseInfo[houseid][hFurTxtId][index][1] = HouseInfo[houseid][hFurTxtId][copyid][1];
    HouseInfo[houseid][hFurTxtId][index][2] = HouseInfo[houseid][hFurTxtId][copyid][2];
    HouseInfo[houseid][hFurTxtId][index][3] = HouseInfo[houseid][hFurTxtId][copyid][3];
    HouseInfo[houseid][hFurTxtId][index][4] = HouseInfo[houseid][hFurTxtId][copyid][4];
    HouseInfo[houseid][hFurColId][index][0] = HouseInfo[houseid][hFurColId][copyid][0];
    HouseInfo[houseid][hFurColId][index][1] = HouseInfo[houseid][hFurColId][copyid][1];
    HouseInfo[houseid][hFurColId][index][2] = HouseInfo[houseid][hFurColId][copyid][2];
    HouseInfo[houseid][hFurColId][index][3] = HouseInfo[houseid][hFurColId][copyid][3];
    HouseInfo[houseid][hFurColId][index][4] = HouseInfo[houseid][hFurColId][copyid][4];

    HouseInfo[houseid][hFurObjectid][index] = CreateDynamicObject(HouseInfo[houseid][hFurModelid][index], HouseInfo[houseid][hFurPosX][index], HouseInfo[houseid][hFurPosY][index], HouseInfo[houseid][hFurPosZ][index], HouseInfo[houseid][hFurRotX][index], HouseInfo[houseid][hFurRotY][index], HouseInfo[houseid][hFurRotZ][index], HouseInfo[houseid][hVirtualWorld], HouseInfo[houseid][hInt], -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);

    // TODO: helper function, this is repetitive code, I saw it somewhere else...
    new 
        colorid;
    for (new colslot = 0; colslot < MAX_COLOR_TEXT_SLOTS; colslot++)
    {
        if(HouseInfo[houseid][hFurColId][index][colslot] > -1)
        {
            sscanf(ColorList[HouseInfo[houseid][hFurColId][index][colslot]][clRGB], "h", colorid);
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][index], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tName], colorid);
        }
        else
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][index], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tName], 0);
    }

    InsertFurnitureObject(houseid, index);

    Streamer_Update(playerid);
    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kopirali odabrani objekt! Sada ga postavite gdje zelite.");
    return 1;
}

static stock EditFurnitureObject(playerid, index)
{
    // TODO: proper index bounds checking
    if(playerid == INVALID_PLAYER_ID || index == -1) return 0;

    new houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    if(IsValidDynamicObject(HouseInfo[houseid][hFurObjectid][index]))
    {
        DestroyDynamicObject(HouseInfo[houseid][hFurObjectid][index]);
        HouseInfo[houseid][hFurObjectid][index] = INVALID_OBJECT_ID;

        PlayerEditObject[playerid] = CreatePlayerObject(playerid, HouseInfo[houseid][hFurModelid][index], HouseInfo[houseid][hFurPosX][index], HouseInfo[houseid][hFurPosY][index], HouseInfo[houseid][hFurPosZ][index], HouseInfo[houseid][hFurRotX][index], HouseInfo[houseid][hFurRotY][index], HouseInfo[houseid][hFurRotZ][index]);
        EditState[playerid] = EDIT_STATE_EDIT;
        EditPlayerObject(playerid, PlayerEditObject[playerid]);
    }
    else
    {
        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se greska s uredjivanjem objekta!");
        printf("[DEBUG] FURNITURE EDIT: houseid(%d) | index(%d) | objectid(%d)", houseid, index, HouseInfo[houseid][hFurObjectid][index]);
    }
    return 1;
}

static stock SetFurnitureObjectPos(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(playerid == INVALID_PLAYER_ID) return 0;
    if(!IsValidPlayerObject(playerid, PlayerEditObject[playerid])) return 0;

    // TODO: index bounds check
    new index = PlayerEditIndex[playerid];
    new houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    CancelEdit(playerid);
    if(IsValidPlayerObject(playerid, PlayerEditObject[playerid]))
    {
        DestroyPlayerObject(playerid, PlayerEditObject[playerid]);
        PlayerEditObject[playerid] = INVALID_OBJECT_ID;
    }

    HouseInfo[houseid][hFurObjectid][index] = CreateDynamicObject(HouseInfo[houseid][hFurModelid][index], x, y, z, rx, ry, rz, HouseInfo[houseid][hVirtualWorld], HouseInfo[houseid][hInt], -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);
    HouseInfo[houseid][hFurPosX][index]     = x;
    HouseInfo[houseid][hFurPosY][index]     = y;
    HouseInfo[houseid][hFurPosZ][index]     = z;
    HouseInfo[houseid][hFurRotX][index]     = rx;
    HouseInfo[houseid][hFurRotY][index]     = ry;
    HouseInfo[houseid][hFurRotZ][index]     = rz;

    mysql_fquery(g_SQL,
        "UPDATE furniture SET pos_x = '%f',pos_y = '%f',pos_z = '%f',rot_x = '%f',rot_y = '%f',rot_z = '%f' WHERE sqlid = '%d'",
        x,
        y,
        z,
        rx,
        ry,
        rz,
        HouseInfo[houseid][hFurSQL][index]
   );

    // TODO: repetitive code, helper function
    new colorid;
    for (new colslot = 0; colslot < MAX_COLOR_TEXT_SLOTS; colslot++)
    {
        if(HouseInfo[houseid][hFurColId][index][colslot] > -1)
        {
            sscanf(ColorList[HouseInfo[houseid][hFurColId][index][colslot]][clRGB], "h", colorid);
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][index], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tName], colorid);
        }
        else
        {
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][index], colslot, ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tModel], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tTXDName], ObjectTextures[HouseInfo[houseid][hFurTxtId][index][colslot]][tName], 0);
        }
    }

    Streamer_Update(playerid);

    EditState       [playerid] = -1;
    PlayerEditObject[playerid] = INVALID_OBJECT_ID;
    PlayerEditIndex [playerid] = -1;
    return 1;
}

static stock SetFurnitureObjectTexture(playerid, slot, index, slotid)
{
    if(playerid == INVALID_PLAYER_ID) return 0;
    // TODO: proper index bounds check
    if(index > sizeof(ObjectTextures)) return 0;

    new houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][slotid], slot, ObjectTextures[index][tModel], ObjectTextures[index][tTXDName], ObjectTextures[index][tName], 0);
    PlayerEditTxtSlot[playerid]                 = -1;
    PlayerEditTxtIndex[playerid]                = -1;
    HouseInfo[houseid][hFurTxtId][slotid][slot] = index;

    mysql_fquery(g_SQL, "UPDATE furniture SET texture_%d = '%d' WHERE sqlid = '%d'",
        (slot+1),
        HouseInfo[houseid][hFurTxtId][slotid][slot],
        HouseInfo[houseid][hFurSQL][slotid]
   );

    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili texturu na vas namjestaj.");
    return 1;
}

static stock SetFurnitureObjectColor(playerid, slot, index, slotid)
{
    if(playerid == INVALID_PLAYER_ID) return 0;
    // TODO: proper index bounds check
    // TODO: slot, slotid bounds check
    if(index > sizeof(ObjectTextures)) return 0;

    new houseid = GetPlayerFurnitureHouse(playerid);
    if(houseid == INVALID_HOUSE_ID)
        return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

    new txtId = HouseInfo[houseid][hFurTxtId][slotid],
        colorid;
    sscanf(ColorList[index][clRGB], "h", colorid);
    SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][slotid], slot, ObjectTextures[txtId][tModel], ObjectTextures[txtId][tTXDName], ObjectTextures[txtId][tName], colorid);

    PlayerEditTxtSlot[playerid]                 = -1;
    PlayerEditTxtIndex[playerid]                = -1;
    HouseInfo[houseid][hFurColId][slotid][slot] = index;

    mysql_fquery(g_SQL, "UPDATE furniture SET color_%d = '%d' WHERE sqlid = '%d'",
        (slot + 1),
        HouseInfo[houseid][hFurColId][slotid][slot],
        HouseInfo[houseid][hFurSQL][slotid]
   );
    return 1;
}

static stock DeleteFurnitureObject(houseid, playerid, index)
{
    if(houseid == INVALID_HOUSE_ID) return 0;
    // TODO: houseid, index bounds check

    mysql_fquery(g_SQL, "DELETE FROM furniture WHERE sqlid = '%d'", HouseInfo[houseid][hFurSQL][index]);

    va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste obrisali objekt[Model ID: %d - Slot Index: %d].", HouseInfo[houseid][hFurModelid][index], index);

    DestroyDynamicObject(HouseInfo[houseid][hFurObjectid][index]);

    HouseInfo[houseid][hFurObjectid][index]   = INVALID_OBJECT_ID;
    HouseInfo[houseid][hFurSQL][index]        = -1;
    HouseInfo[houseid][hFurModelid][index]    = -1;
    HouseInfo[houseid][hFurPosX][index]       = 0.0;
    HouseInfo[houseid][hFurPosY][index]       = 0.0;
    HouseInfo[houseid][hFurPosZ][index]       = 0.0;
    HouseInfo[houseid][hFurRotX][index]       = 0.0;
    HouseInfo[houseid][hFurRotY][index]       = 0.0;
    HouseInfo[houseid][hFurRotZ][index]       = 0.0;
    HouseInfo[houseid][hFurTxtId][index][0]   = 0;
    HouseInfo[houseid][hFurTxtId][index][1]   = 0;
    HouseInfo[houseid][hFurTxtId][index][2]   = 0;
    HouseInfo[houseid][hFurTxtId][index][3]   = 0;
    HouseInfo[houseid][hFurTxtId][index][4]   = 0;
    HouseInfo[houseid][hFurColId][index][0]   = -1;
    HouseInfo[houseid][hFurColId][index][1]   = -1;
    HouseInfo[houseid][hFurColId][index][2]   = -1;
    HouseInfo[houseid][hFurColId][index][3]   = -1;
    HouseInfo[houseid][hFurColId][index][4]   = -1;

    HouseInfo[houseid][hFurCounter]--;
    HouseInfo[houseid][hExists][index] = 0;

    Iter_Remove(HouseFurInt[houseid], index);
    return 1;
}

static stock DestroyAllFurnitureObjects(playerid, houseid)
{
    // TODO: houseid bounds check
    foreach(new index: HouseFurInt[houseid])
    {
        if(HouseInfo[houseid][hFurSQL][index])
        {
            if(IsValidDynamicObject(HouseInfo[houseid][hFurObjectid][index]))
            {
                DestroyDynamicObject(HouseInfo[houseid][hFurObjectid][index]);
                HouseInfo[houseid][hFurObjectid][index] = INVALID_OBJECT_ID;
            }

            HouseInfo[houseid][hFurSQL][index]      = 0;
            HouseInfo[houseid][hFurModelid][index]  = -1;
            HouseInfo[houseid][hExists][index]      = 0;
            HouseInfo[houseid][hFurCounter]         = 0;
            HouseInfo[houseid][hFurPosX][index]     = 0.0;
            HouseInfo[houseid][hFurPosY][index]     = 0.0;
            HouseInfo[houseid][hFurPosZ][index]     = 0.0;
            HouseInfo[houseid][hFurRotX][index]     = 0.0;
            HouseInfo[houseid][hFurRotY][index]     = 0.0;
            HouseInfo[houseid][hFurRotZ][index]     = 0.0;
            HouseInfo[houseid][hFurTxtId][index][0] = 0;
            HouseInfo[houseid][hFurTxtId][index][1] = 0;
            HouseInfo[houseid][hFurTxtId][index][2] = 0;
            HouseInfo[houseid][hFurTxtId][index][3] = 0;
            HouseInfo[houseid][hFurTxtId][index][4] = 0;
            HouseInfo[houseid][hFurColId][index][0] = -1;
            HouseInfo[houseid][hFurColId][index][1] = -1;
            HouseInfo[houseid][hFurColId][index][2] = -1;
            HouseInfo[houseid][hFurColId][index][3] = -1;
            HouseInfo[houseid][hFurColId][index][4] = -1;
        }
    }
    HouseInfo[houseid][hFurSlots]  = GetFurnitureSlots(playerid, PlayerVIP[playerid][pDonateRank]);
    HouseInfo[houseid][hFurLoaded] = false;

    Iter_Clear(HouseFurInt[houseid]);

    mysql_pquery(g_SQL, "BEGIN");
    mysql_fquery_ex(g_SQL, "DELETE FROM furniture WHERE houseid = '%d'", HouseInfo[houseid][hSQLID]);
    mysql_pquery(g_SQL, "COMMIT");

    mysql_fquery(g_SQL, "UPDATE houses SET fur_slots = '%d' WHERE id = '%d'", 
        HouseInfo[houseid][hFurSlots], 
        HouseInfo[houseid][hSQLID]
   );
    return 1;
}

// TODO: bool, also I believe there is already a function with similar or the same name defined somewhere else
// Either unite the two implementations or make one generic function
static stock CanDoorOpen(modelid)
{
    switch (modelid)
    {
        case 3093,3089,2959,2970,2924,2949,2948,2911,977,1495,1496,1497,1498,1501,1506,1535,1536,1555,1556,1566,1567,1569,13360: return 1;
    }
    return 0;
}

static stock SetFurnitureDoorRotation(houseid, index)
{
    // TODO: houseid bounds check
    if(!CanDoorOpen(HouseInfo[houseid][hFurModelid][index]))
    {
        return 1;
    }
    // TODO: repetitive code, already saw something similar somewhere else. reuse functions, don't copy paste code
    if((-90.0 <= HouseInfo[houseid][hFurDoorZ][index] <= 90.0) && HouseInfo[houseid][hFurDoorZ][index] != -1.0)
    { //Vrata zatvorena
        new Float:rot;
        switch (HouseInfo[houseid][hFurModelid][index])
        {
            case 3089,2924,2911,977,1492,1493,1495,1496,1497,1498,1501,1569,1506,1536,1555,1556,1566,1567,13360: rot = -90.0; //-90.0
            default: rot = 90.0;
        }

        SetDynamicObjectRot(HouseInfo[houseid][hFurObjectid][index],
            HouseInfo[houseid][hFurRotX][index],
            HouseInfo[houseid][hFurRotY][index],
            rot
       );
        HouseInfo[houseid][hFurDoorZ][index] = -1.0;
        return 1;
    }

    SetDynamicObjectRot(HouseInfo[houseid][hFurObjectid][index],
        HouseInfo[houseid][hFurRotX][index],
        HouseInfo[houseid][hFurRotY][index],
        HouseInfo[houseid][hFurRotZ][index]
   );
    HouseInfo[houseid][hFurDoorZ][index] = HouseInfo[houseid][hFurRotZ][index];
    return 1;
}

stock ReloadHouseFurniture(houseid)
{
    // TODO: houseid bounds check (optional)
    ResetHouseFurnitureEnum(houseid);
    LoadHouseFurnitureObjects(houseid);
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

hook OnGameModeInit()
{
    // Interiori
    CreateObject(14700, 685.49353, 1556.45422, 1729.58228,   0.00000, 0.00000, 0.00000);
    CreateObject(14700, 685.49353, 1556.45422, 1729.58228,   0.00000, 0.00000, 0.00000);
    CreateObject(14701, 691.89319, 1810.34216, 1715.57617,   0.00000, 0.00000, 0.00000);
    CreateObject(14702, 699.37170, 2194.47217, 1735.69275,   0.00000, 0.00000, 0.00000);
    CreateObject(14703, 728.11401, 2687.00830, 1762.83215,   0.00000, 0.00000, 0.00000);
    CreateObject(14706, 1167.95166, 2601.92383, 1727.62524,   0.00000, 0.00000, 0.00000);
    CreateObject(14707, 1205.92285, 2311.76636, 1727.97974,   0.00000, 0.00000, 0.00000);
    CreateObject(14708, 1203.53870, 2015.71228, 1727.67004,   0.00000, 0.00000, 0.00000);
    CreateObject(14709, 1085.55188, 1878.17468, 1730.93188,   0.00000, 0.00000, 0.00000);
    CreateObject(14710, 986.40869, 1714.07593, 1729.41809,   0.00000, 0.00000, 0.00000);
    CreateObject(14711, 945.95239, 1411.58301, 1728.82239,   0.00000, 0.00000, 0.00000);
    CreateObject(14712, 1197.34119, 1282.33972, 1728.48438,   0.00000, 0.00000, 0.00000);
    CreateObject(14713, 1283.96924, 984.01923, 1728.21155,   0.00000, 0.00000, 0.00000);
    CreateObject(14714, 1576.20801, 774.71082, 1728.14075,   0.00000, 0.00000, 0.00000);
    CreateObject(14717, 1699.26831, 1093.15442, 1728.64832,   0.00000, 0.00000, 0.00000);
    CreateObject(14718, 1786.20068, 1408.99707, 1748.24353,   0.00000, 0.00000, 0.00000);
    CreateObject(14748, 1810.29175, 1596.97339, 1756.76807,   0.00000, 0.00000, 0.00000);
    CreateObject(14750, 1773.33154, 1823.28284, 1758.53516,   0.00000, 0.00000, 0.00000);
    CreateObject(14754, 1869.32727, 2077.74487, 1755.00476,   0.00000, 0.00000, 0.00000);
    CreateObject(14755, 2036.68372, 2170.85010, 1755.51160,   0.00000, 0.00000, 0.00000);
    CreateObject(14756, 2236.48706, 1995.51013, 1754.90186,   0.00000, 0.00000, 0.00000);
    CreateObject(14758, 2473.46631, 1808.99219, 1752.88989,   0.00000, 0.00000, 0.00000);
    CreateObject(14760, 2440.26245, 2152.18506, 1796.02954,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 2237.24683, 1996.24756, 1752.90442,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 686.20941, 1552.39966, 1728.08325,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 692.28619, 1800.06653, 1713.50549,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 731.54828, 2673.69141, 1758.51941,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 995.91870, 1711.61316, 1727.90454,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 954.92950, 1419.78674, 1727.20129,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1201.05896, 1274.84912, 1726.91748,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1289.88660, 979.08533, 1726.40796,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1576.95337, 766.69312, 1726.33704,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1704.02844, 1088.08667, 1726.90894,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1789.97107, 1404.11414, 1748.24634,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1815.36084, 1596.17517, 1754.77258,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1770.79041, 1813.97888, 1752.01538,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1867.38855, 2068.66479, 1751.06116,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2037.30530, 2178.20752, 1754.26416,   0.00000, 0.00000, 180.00000);
    CreateObject(1569, 2472.73364, 1808.94470, 1751.01660,   0.00000, 0.00000, 0.00000);
    CreateObject(1569, 2475.73511, 1808.94019, 1751.01660,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2444.16138, 2160.19141, 1794.03162,   0.00000, 0.00000, 270.00000);
    CreateObject(14702, 699.37170, 2194.47217, 1735.69275,   0.00000, 0.00000, 0.00000);
    CreateObject(14703, 728.11401, 2687.00830, 1762.83215,   0.00000, 0.00000, 0.00000);
    CreateObject(14706, 1167.95166, 2601.92383, 1727.62524,   0.00000, 0.00000, 0.00000);
    CreateObject(14707, 1205.92285, 2311.76636, 1727.97974,   0.00000, 0.00000, 0.00000);
    CreateObject(14708, 1203.53870, 2015.71228, 1727.67004,   0.00000, 0.00000, 0.00000);
    CreateObject(14709, 1085.55188, 1878.17468, 1730.93188,   0.00000, 0.00000, 0.00000);
    CreateObject(14710, 986.40869, 1714.07593, 1729.41809,   0.00000, 0.00000, 0.00000);
    CreateObject(14711, 945.95239, 1411.58301, 1728.82239,   0.00000, 0.00000, 0.00000);
    CreateObject(14712, 1197.34119, 1282.33972, 1728.48438,   0.00000, 0.00000, 0.00000);
    CreateObject(14713, 1283.96924, 984.01923, 1728.21155,   0.00000, 0.00000, 0.00000);
    CreateObject(14714, 1576.20801, 774.71082, 1728.14075,   0.00000, 0.00000, 0.00000);
    CreateObject(14717, 1699.26831, 1093.15442, 1728.64832,   0.00000, 0.00000, 0.00000);
    CreateObject(14750, 1773.33154, 1823.28284, 1758.53516,   0.00000, 0.00000, 0.00000);
    CreateObject(14754, 1869.32727, 2077.74487, 1755.00476,   0.00000, 0.00000, 0.00000);
    CreateObject(14755, 2036.68372, 2170.85010, 1755.51160,   0.00000, 0.00000, 0.00000);
    CreateObject(14756, 2236.48706, 1995.51013, 1754.90186,   0.00000, 0.00000, 0.00000);
    CreateObject(14758, 2473.46631, 1808.99219, 1752.88989,   0.00000, 0.00000, 0.00000);
    CreateObject(14760, 2440.26245, 2152.18506, 1796.02954,   0.00000, 0.00000, 0.00000);
    CreateObject(15041, -1087.45276, 398.36539, 1713.09143,   0.00000, 0.00000, 0.00000);
    CreateObject(15042, -1494.46277, 265.59521, 1713.11047,   0.00000, 0.00000, 0.00000);
    CreateObject(15046, -1796.54639, 106.73140, 1776.14893,   0.00000, 0.00000, 0.00000);
    CreateObject(15058, -1954.15356, -389.76410, 1739.16516,   0.00000, 0.00000, 0.00000);
    CreateObject(15059, -1910.79565, -1043.31433, 1737.33813,   0.00000, 0.00000, 0.00000);
    CreateObject(15048, -1911.01880, -1043.30432, 1737.34814,   0.00000, 0.00000, 0.00000);
    CreateObject(15053, -1859.37891, -1029.05151, 1636.51367,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 2237.24683, 1996.24756, 1752.90442,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 686.33563, 1552.39026, 1728.08325,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 692.28619, 1800.06653, 1713.50549,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 731.54828, 2673.69141, 1758.51941,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 995.91870, 1711.61316, 1727.90454,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 954.92950, 1419.78674, 1727.20129,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1201.05896, 1274.84912, 1726.91748,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1289.88660, 979.08533, 1726.40796,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1576.95337, 766.69312, 1726.33704,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1704.02844, 1088.08667, 1726.90894,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1789.97107, 1404.11414, 1748.24634,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1815.36084, 1596.17517, 1754.77258,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1770.79041, 1813.97888, 1752.01538,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1867.38855, 2068.66479, 1751.06116,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2037.30530, 2178.20752, 1754.26416,   0.00000, 0.00000, 180.00000);
    CreateObject(1569, 2472.73364, 1808.94470, 1751.01660,   0.00000, 0.00000, 0.00000);
    CreateObject(1569, 2475.73511, 1808.94019, 1751.01660,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2444.16138, 2160.19141, 1794.03162,   0.00000, 0.00000, 270.00000);
    CreateObject(1506, -1902.01331, -1048.40662, 1733.74756,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1901.95703, -1048.38660, 1733.74756,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, -1100.16553, 404.61530, 1711.07910,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, -1498.75195, 265.05420, 1711.09973,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, -1797.29211, 114.05450, 1774.89758,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1958.71631, -398.86380, 1735.20654,   0.00000, 0.00000, 0.00000);
    CreateObject(1504, 701.29163, 2181.04102, 1731.39575,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, -1096.88745, 403.22830, 1711.07910,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1860.13245, -1032.50391, 1635.26233,   0.00000, 0.00000, 0.00000);
    CreateObject(1567, -1857.26514, -1039.84778, 1635.26221,   0.00000, 0.00000, 270.00000);
    CreateObject(14876, 723.09613, 1560.59814, 1729.80566,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 716.77380, 1565.85107, 1724.73438,   0.00000, 0.00000, 90.00000);
    CreateObject(14877, 724.72601, 1566.69995, 1726.80005,   0.00000, 0.00000, 0.00000);
    CreateObject(14476, 738.71082, 1618.49487, 1730.66418,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 739.87207, 1626.13025, 1730.66418,   0.00000, 0.00000, 0.00000);
    CreateObject(19881, 286.18799, 307.60901, 1002.01001,   0.00000, 0.00000, 0.00000);
    CreateObject(14471, 741.14410, 1608.85156, 1732.40002,   0.00000, 0.00000, 180.00000);
    CreateObject(14472, 742.56000, 1608.73999, 1732.15796,   0.00000, 0.00000, 180.00000);
    CreateObject(19377, 741.77490, 1607.88599, 1730.57605,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 683.37720, 1813.62366, 1713.41699,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1862.56531, -1046.52112, 1635.17395,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1862.54309, -1037.33118, 1635.17395,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1890.87927, -1037.94604, 1733.67102,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1801.56091, 1596.35120, 1754.68506,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1812.19458, 1596.49902, 1754.68396,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1804.70874, 1605.68298, 1754.68506,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1798.30737, 1407.88196, 1748.15796,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1787.76709, 1408.92493, 1748.15796,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1954.85950, -393.97849, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1944.38477, -393.97852, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1944.38477, -384.34671, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1954.89319, -384.34671, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1965.45325, -382.72876, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1944.39941, -374.71448, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1954.90405, -374.69226, 1735.12500,   0.00000, 90.00000, 0.00000);
    CreateObject(14727, -1956.96399, -394.55951, 1736.02002,   0.00000, 0.00000, 0.00000);
    CreateObject(14727, -1956.96399, -391.51309, 1738.26001,   0.00000, 0.00000, 0.00000);
    CreateObject(14700, 685.49353, 1556.45422, 1729.58228,   0.00000, 0.00000, 0.00000);
    CreateObject(14701, 691.89319, 1810.34216, 1715.57617,   0.00000, 0.00000, 0.00000);
    CreateObject(14702, 699.37170, 2194.47217, 1735.69275,   0.00000, 0.00000, 0.00000);
    CreateObject(14703, 728.11401, 2687.00830, 1762.83215,   0.00000, 0.00000, 0.00000);
    CreateObject(14706, 1167.95166, 2601.92383, 1727.62524,   0.00000, 0.00000, 0.00000);
    CreateObject(14707, 1205.92285, 2311.76636, 1727.97974,   0.00000, 0.00000, 0.00000);
    CreateObject(14708, 1203.53870, 2015.71228, 1727.67004,   0.00000, 0.00000, 0.00000);
    CreateObject(14709, 1085.55188, 1878.17468, 1730.93188,   0.00000, 0.00000, 0.00000);
    CreateObject(14710, 986.40869, 1714.07593, 1729.41809,   0.00000, 0.00000, 0.00000);
    CreateObject(14711, 945.95239, 1411.58301, 1728.82239,   0.00000, 0.00000, 0.00000);
    CreateObject(14712, 1197.34119, 1282.33972, 1728.48438,   0.00000, 0.00000, 0.00000);
    CreateObject(14713, 1283.96924, 984.01923, 1728.21155,   0.00000, 0.00000, 0.00000);
    CreateObject(14714, 1576.20801, 774.71082, 1728.14075,   0.00000, 0.00000, 0.00000);
    CreateObject(14717, 1699.26831, 1093.15442, 1728.64832,   0.00000, 0.00000, 0.00000);
    CreateObject(14718, 1786.20068, 1408.99707, 1748.24353,   0.00000, 0.00000, 0.00000);
    CreateObject(14748, 1810.29175, 1596.97339, 1756.76807,   0.00000, 0.00000, 0.00000);
    CreateObject(14750, 1773.33154, 1823.28284, 1758.53516,   0.00000, 0.00000, 0.00000);
    CreateObject(14754, 1869.32727, 2077.74487, 1755.00476,   0.00000, 0.00000, 0.00000);
    CreateObject(14755, 2036.68372, 2170.85010, 1755.51160,   0.00000, 0.00000, 0.00000);
    CreateObject(14756, 2236.48706, 1995.51013, 1754.90186,   0.00000, 0.00000, 0.00000);
    CreateObject(14758, 2473.46631, 1808.99219, 1752.88989,   0.00000, 0.00000, 0.00000);
    CreateObject(14760, 2440.26245, 2152.18506, 1796.02954,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 2237.24683, 1996.24756, 1752.90442,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 686.20941, 1552.39966, 1728.08325,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 692.28619, 1800.06653, 1713.50549,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 731.54828, 2673.69141, 1758.51941,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 995.91870, 1711.61316, 1727.90454,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 954.92950, 1419.78674, 1727.20129,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1201.05896, 1274.84912, 1726.91748,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1289.88660, 979.08533, 1726.40796,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1576.95337, 766.69312, 1726.33704,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1704.02844, 1088.08667, 1726.90894,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1789.97107, 1404.11414, 1748.24634,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1815.36084, 1596.17517, 1754.77258,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1770.79041, 1813.97888, 1752.01538,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1867.38855, 2068.66479, 1751.06116,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2037.30530, 2178.20752, 1754.26416,   0.00000, 0.00000, 180.00000);
    CreateObject(1569, 2472.73364, 1808.94470, 1751.01660,   0.00000, 0.00000, 0.00000);
    CreateObject(1569, 2475.73511, 1808.94019, 1751.01660,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2444.16138, 2160.19141, 1794.03162,   0.00000, 0.00000, 270.00000);
    CreateObject(14702, 699.37170, 2194.47217, 1735.69275,   0.00000, 0.00000, 0.00000);
    CreateObject(14703, 728.11401, 2687.00830, 1762.83215,   0.00000, 0.00000, 0.00000);
    CreateObject(14706, 1167.95166, 2601.92383, 1727.62524,   0.00000, 0.00000, 0.00000);
    CreateObject(14707, 1205.92285, 2311.76636, 1727.97974,   0.00000, 0.00000, 0.00000);
    CreateObject(14708, 1203.53870, 2015.71228, 1727.67004,   0.00000, 0.00000, 0.00000);
    CreateObject(14709, 1085.55188, 1878.17468, 1730.93188,   0.00000, 0.00000, 0.00000);
    CreateObject(14710, 986.40869, 1714.07593, 1729.41809,   0.00000, 0.00000, 0.00000);
    CreateObject(14711, 945.95239, 1411.58301, 1728.82239,   0.00000, 0.00000, 0.00000);
    CreateObject(14712, 1197.34119, 1282.33972, 1728.48438,   0.00000, 0.00000, 0.00000);
    CreateObject(14713, 1283.96924, 984.01923, 1728.21155,   0.00000, 0.00000, 0.00000);
    CreateObject(14714, 1576.20801, 774.71082, 1728.14075,   0.00000, 0.00000, 0.00000);
    CreateObject(14717, 1699.26831, 1093.15442, 1728.64832,   0.00000, 0.00000, 0.00000);
    CreateObject(14750, 1773.33154, 1823.28284, 1758.53516,   0.00000, 0.00000, 0.00000);
    CreateObject(14754, 1869.32727, 2077.74487, 1755.00476,   0.00000, 0.00000, 0.00000);
    CreateObject(14755, 2036.68372, 2170.85010, 1755.51160,   0.00000, 0.00000, 0.00000);
    CreateObject(14756, 2236.48706, 1995.51013, 1754.90186,   0.00000, 0.00000, 0.00000);
    CreateObject(14758, 2473.46631, 1808.99219, 1752.88989,   0.00000, 0.00000, 0.00000);
    CreateObject(14760, 2440.26245, 2152.18506, 1796.02954,   0.00000, 0.00000, 0.00000);
    CreateObject(15041, -1087.45276, 398.36539, 1713.09143,   0.00000, 0.00000, 0.00000);
    CreateObject(15042, -1494.46277, 265.59521, 1713.11047,   0.00000, 0.00000, 0.00000);
    CreateObject(15046, -1796.54639, 106.73140, 1776.14893,   0.00000, 0.00000, 0.00000);
    CreateObject(15058, -1954.15356, -389.76410, 1739.16516,   0.00000, 0.00000, 0.00000);
    CreateObject(15059, -1910.79565, -1043.31433, 1737.33813,   0.00000, 0.00000, 0.00000);
    CreateObject(15048, -1911.01880, -1043.30432, 1737.34814,   0.00000, 0.00000, 0.00000);
    CreateObject(15053, -1859.37891, -1029.05151, 1636.51367,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 2237.24683, 1996.24756, 1752.90442,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 686.33563, 1552.39026, 1728.08325,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 692.28619, 1800.06653, 1713.50549,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 731.54828, 2673.69141, 1758.51941,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 995.91870, 1711.61316, 1727.90454,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 954.92950, 1419.78674, 1727.20129,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1201.05896, 1274.84912, 1726.91748,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1289.88660, 979.08533, 1726.40796,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1576.95337, 766.69312, 1726.33704,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1704.02844, 1088.08667, 1726.90894,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1789.97107, 1404.11414, 1748.24634,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1815.36084, 1596.17517, 1754.77258,   0.00000, 0.00000, 270.00000);
    CreateObject(1498, 1770.79041, 1813.97888, 1752.01538,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 1867.38855, 2068.66479, 1751.06116,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2037.30530, 2178.20752, 1754.26416,   0.00000, 0.00000, 180.00000);
    CreateObject(1569, 2472.73364, 1808.94470, 1751.01660,   0.00000, 0.00000, 0.00000);
    CreateObject(1569, 2475.73511, 1808.94019, 1751.01660,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, 2444.16138, 2160.19141, 1794.03162,   0.00000, 0.00000, 270.00000);
    CreateObject(1506, -1902.01331, -1048.40662, 1733.74756,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1901.95703, -1048.38660, 1733.74756,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, -1100.16553, 404.61530, 1711.07910,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, -1498.75195, 265.05420, 1711.09973,   0.00000, 0.00000, 180.00000);
    CreateObject(1498, -1797.29211, 114.05450, 1774.89758,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1958.71631, -398.86380, 1735.20654,   0.00000, 0.00000, 0.00000);
    CreateObject(1504, 701.29163, 2181.04102, 1731.39575,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, -1096.88745, 403.22830, 1711.07910,   0.00000, 0.00000, 0.00000);
    CreateObject(1506, -1860.13245, -1032.50391, 1635.26233,   0.00000, 0.00000, 0.00000);
    CreateObject(1567, -1857.26514, -1039.84778, 1635.26221,   0.00000, 0.00000, 270.00000);
    CreateObject(14876, 723.09613, 1560.59814, 1729.80566,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 716.77380, 1565.85107, 1724.73438,   0.00000, 0.00000, 90.00000);
    CreateObject(14877, 724.72601, 1566.69995, 1726.80005,   0.00000, 0.00000, 0.00000);
    CreateObject(14476, 738.71082, 1618.49487, 1730.66418,   0.00000, 0.00000, 0.00000);
    CreateObject(1498, 739.87207, 1626.13025, 1730.66418,   0.00000, 0.00000, 0.00000);
    CreateObject(19881, 286.18799, 307.60901, 1002.01001,   0.00000, 0.00000, 0.00000);
    CreateObject(14471, 741.14410, 1608.85156, 1732.40002,   0.00000, 0.00000, 180.00000);
    CreateObject(14472, 742.56000, 1608.73999, 1732.15796,   0.00000, 0.00000, 180.00000);
    CreateObject(19377, 741.77490, 1607.88599, 1730.57605,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 683.37720, 1813.62366, 1713.41699,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1862.56531, -1046.52112, 1635.17395,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1862.54309, -1037.33118, 1635.17395,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, -1890.87927, -1037.94604, 1733.67102,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1801.56091, 1596.35120, 1754.68506,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1812.19458, 1596.49902, 1754.68396,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1804.70874, 1605.68298, 1754.68506,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1798.30737, 1407.88196, 1748.15796,   0.00000, 90.00000, 0.00000);
    CreateObject(19377, 1787.76709, 1408.92493, 1748.15796,   0.00000, 90.00000, 0.00000);
    CreateObject(14727, -1956.96399, -394.55951, 1736.02002,   0.00000, 0.00000, 0.00000);
    CreateObject(14727, -1956.96399, -391.51309, 1738.26001,   0.00000, 0.00000, 0.00000);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 14871, 286.188, 307.609, 1002.01, 250.0); // Barn
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyFurnitureBlankIntTDs(playerid);

    if(EditState[playerid] != -1)
    {
        if(IsValidPlayerObject(playerid, PlayerPrwsObject[playerid]))
        {
            CancelEdit(playerid);
            DestroyPlayerObject(playerid, PlayerPrwsObject[playerid]);
            PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
        }
        EditState[playerid] = -1;
    }

    FreeFurniture_Slot[playerid]   = INVALID_OBJECT_ID;
    FurObjectSection[playerid]     = -1;
    FurnObjectsType[playerid]      = -1;
    PlayerPrwsObject[playerid]     = -1;
    PlayerPrwsIndex[playerid]      = -1;
    PlayerPrwsModel[playerid]      = -1;
    PlayerEditIndex[playerid]      = -1;
    PlayerEditObject[playerid]     = -1;
    PlayerEditType[playerid]       = -1;
    PlayerEditTxtIndex[playerid]   = -1;
    PlayerEditTxtSlot[playerid]    = -1;
    PlayerEditingHouse[playerid]   = INVALID_HOUSE_ID;
    PlayerEditClsIndex[playerid]   = -1;
    LastTextureListIndex[playerid] = 1;
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_BLANK_INTS_LIST:
        {
            if(!response) return 1;

            if(!SetPlayerInteriorPreview(playerid, listitem)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se nekakva pogreska, ponovno kucajte /bint test!");
            return 1;
        }
        case DIALOG_FURNITURE_MENU:
        {
            if(!response) return 1;

            new
                houseid = GetPlayerFurnitureHouse(playerid);
            if(houseid == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete kucu ili ju ne uredjujete!");

            switch (listitem)
            {
                case 0:
                { // Kupi
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_BUY, DIALOG_STYLE_LIST, "Furniture - Kategorije", "Dnevni Boravak\nKuhinja\nKupaonica\nSobe\nOstalo", "Choose", "Abort");
                }
                case 1:
                { // Uredi
                    foreach(new i: HouseFurInt[houseid])
                    {
                        Player_ModelToIndexSet(playerid, i, HouseInfo[houseid][hFurModelid][i]);
                        fselection_add_item(playerid, HouseInfo[houseid][hFurModelid][i]);
                    }
                    fselection_show(playerid, ms_HFUR_EDIT, "Furniture Edit");
                }
            }
            return 1;
        }
        case DIALOG_FURNITURE_BUY:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");

            switch (listitem)
            {
                case 0:
                { // Dnevni
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Dnevni", "Kauci\nFotelje\nStolovi\nOrmarici\nTelevizori\nVidei\nHi-Fi\nZvucnici\nTepisi\nSvijetla\nVrata", "Choose", "Abort");
                    FurnObjectsType[playerid] = 1;
                }
                case 1:
                { // Kuhinja
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kuhinja", "Frizider\nKuhinjski ormarici\nSudoper\nStednjak\nMikrovalna\nKanta za smece\nSvijetla", "Choose", "Abort");
                    FurnObjectsType[playerid] = 2;
                }
                case 2:
                { // Kupaonica
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kupaonica", "WC skoljke\nKade\nOgledalo", "Choose", "Abort");
                    FurnObjectsType[playerid] = 3;
                }
                case 3:
                { // Sobe
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Soba", "Kreveti\nNocni ormarici\nKovcezi\nOdjeca\nBiljke\nSlike\nSvjetla\nStolovi\nStolice\nRadijatori\nZastori\nStaklo", "Choose", "Abort");
                    FurnObjectsType[playerid] = 4;
                }
                case 4:
                { // Ostalo
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Ostalo", "Zabava\nPica\nSport\nOstalo\nZidovi\nZivotinje\nOffice\nFM Objects\nHrana", "Choose", "Abort");
                    FurnObjectsType[playerid] = 5;
                }
            }
            return 1;
        }
        case DIALOG_FURNITURE_OBJCS:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_BUY, DIALOG_STYLE_LIST, "Furniture - Kategorije", "Dnevni Boravak\nKuhinja\nKupaonica\nSobe\nOstalo\n", "Choose", "Abort");

            switch (FurnObjectsType[playerid])
            {
                case 1:
                { // Dnevni
                    switch (listitem)
                    {
                        case 0:
                        { // Kauci
                            for (new i = 0; i < sizeof(ObjectsCouch); i++)
                            {
                                if(ObjectsCouch[i][ceId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsCouch[i][ceId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsCouch[i][ceId]);
                                }
                            }
                        }
                        case 1:
                        { // Fotelje
                            for (new i = 0; i < sizeof(ObjectsArmChair); i++)
                            {
                                if(ObjectsArmChair[i][armId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsArmChair[i][armId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsArmChair[i][armId]);
                                }
                            }
                        }
                        case 2:
                        { // Stolovi
                            for (new i = 0; i < sizeof(ObjectsTables); i++)
                            {
                                if(ObjectsTables[i][tablId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsTables[i][tablId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsTables[i][tablId]);
                                }
                            }
                        }
                        case 3:
                        { // Ormarici
                            for (new i = 0; i < sizeof(ObjectsCabinets); i++)
                            {
                                if(ObjectsCabinets[i][cabId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsCabinets[i][cabId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsCabinets[i][cabId]);
                                }
                            }
                        }
                        case 4:
                        { // Televizori
                            for (new i = 0; i < sizeof(ObjectsTelevision); i++)
                            {
                                if(ObjectsTelevision[i][tvId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsTelevision[i][tvId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsTelevision[i][tvId]);
                                }
                            }
                        }
                        case 5:
                        { // Video
                            for (new i = 0; i < sizeof(ObjectsVideo); i++)
                            {
                                if(ObjectsVideo[i][vidId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsVideo[i][vidId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsVideo[i][vidId]);
                                }
                            }
                        }
                        case 6:
                        { // Hi-Fi
                            for (new i = 0; i < sizeof(ObjectsHiFi); i++)
                            {
                                if(ObjectsHiFi[i][hfId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsHiFi[i][hfId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsHiFi[i][hfId]);
                                }
                            }
                        }
                        case 7:
                        { // Zvucnici
                            for (new i = 0; i < sizeof(ObjectsStereo); i++)
                            {
                                if(ObjectsStereo[i][stId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsStereo[i][stId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsStereo[i][stId]);
                                }
                            }
                        }
                        case 8:
                        { // Tepisi
                            for (new i = 0; i < sizeof(ObjectsRugs); i++)
                            {
                                if(ObjectsRugs[i][rId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsRugs[i][rId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsRugs[i][rId]);
                                }
                            }
                        }
                        case 9:
                        { // Svijetla
                            for (new i = 0; i < sizeof(ObjectsLights); i++)
                            {
                                if(ObjectsLights[i][lgtId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsLights[i][lgtId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsLights[i][lgtId]);
                                }
                            }
                        }
                        case 10:
                        { // Vrata
                            for (new i = 0; i < sizeof(ObjectsDoor); i++)
                            {
                                if(ObjectsDoor[i][doorId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsDoor[i][doorId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsDoor[i][doorId]);
                                }
                            }
                        }
                    }
                    FurObjectSection[playerid] = listitem;
                }
                case 2:
                { // Kuhinja
                    switch (listitem)
                    {
                        case 0:
                        { // Frizider
                            for (new i = 0; i < sizeof(ObjectsFridge); i++)
                            {
                                if(ObjectsFridge[i][frId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsFridge[i][frId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsFridge[i][frId]);
                                }
                            }
                        }
                        case 1:
                        { // Ormarici
                            for (new i = 0; i < sizeof(ObjectsKitchenCabinets); i++)
                            {
                                if(ObjectsKitchenCabinets[i][kcId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsKitchenCabinets[i][kcId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsKitchenCabinets[i][kcId]);
                                }
                            }
                        }
                        case 2:
                        { // Sudoperi
                            for (new i = 0; i < sizeof(ObjectsSink); i++)
                            {
                                if(ObjectsSink[i][snkId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsSink[i][snkId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsSink[i][snkId]);
                                }
                            }
                        }
                        case 3:
                        { // Stednjak
                            for (new i = 0; i < sizeof(ObjectsStove); i++)
                            {
                                if(ObjectsStove[i][stId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsStove[i][stId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsStove[i][stId]);
                                }
                            }
                        }
                        case 4:
                        { // Mikrovalna
                            for (new i = 0; i < sizeof(ObjectsMicroWave); i++)
                            {
                                if(ObjectsMicroWave[i][mwId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsMicroWave[i][mwId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsMicroWave[i][mwId]);
                                }
                            }
                        }
                        case 5:
                        { // Kante
                            for (new i = 0; i < sizeof(ObjectsTrashCan); i++)
                            {
                                if(ObjectsTrashCan[i][tcId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsTrashCan[i][tcId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsTrashCan[i][tcId]);
                                }
                            }
                        }
                        case 6:
                        { // Svijetla
                            for (new i = 0; i < sizeof(ObjectsLights); i++)
                            {
                                if(ObjectsLights[i][lgtId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsLights[i][lgtId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsLights[i][lgtId]);
                                }
                            }
                        }
                        case 7:
                        { // Posudje
                            for (new i = 0; i < sizeof(ObjectsKitchenDishes); i++)
                            {
                                if(ObjectsKitchenDishes[i][dishId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsKitchenDishes[i][dishId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsKitchenDishes[i][dishId]);
                                }
                            }
                        }
                    }
                    FurObjectSection[playerid] = listitem;
                }
                case 3:
                { // Kupaona
                    switch (listitem)
                    {
                        case 0:
                        { // WC
                            for (new i = 0; i < sizeof(ObjectsToilet); i++)
                            {
                                if(ObjectsToilet[i][toId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsToilet[i][toId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsToilet[i][toId]);
                                }
                            }
                        }
                        case 1:
                        { // Kade
                            for (new i = 0; i < sizeof(ObjectsBath); i++)
                            {
                                if(ObjectsBath[i][baId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsBath[i][baId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsBath[i][baId]);
                                }
                            }
                        }
                        case 2:
                        { // Ogledalo
                            for (new i = 0; i < sizeof(ObjectsMirror); i++)
                            {
                                if(ObjectsMirror[i][miId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsMirror[i][miId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsMirror[i][miId]);
                                }
                            }
                        }
                    }
                    FurObjectSection[playerid] = listitem;
                }
                case 4:
                { // Soba
                    switch (listitem)
                    {
                        case 0:
                        {
                            for (new i = 0; i < sizeof(ObjectsBed); i++)
                            {
                                if(ObjectsBed[i][bdId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsBed[i][bdId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsBed[i][bdId]);
                                }
                            }
                        }
                        case 1:
                        {
                            for (new i = 0; i < sizeof(ObjectsNightStand); i++)
                            {
                                if(ObjectsNightStand[i][nsId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsNightStand[i][nsId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsNightStand[i][nsId]);
                                }
                            }
                        }
                        case 2:
                        {
                            for (new i = 0; i < sizeof(ObjectsChest); i++)
                            {
                                if(ObjectsChest[i][cId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsChest[i][cId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsChest[i][cId]);
                                }
                            }
                        }
                        case 3:
                        {
                            for (new i = 0; i < sizeof(ObjectsClothes); i++)
                            {
                                if(ObjectsClothes[i][cloId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsClothes[i][cloId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsClothes[i][cloId]);
                                }
                            }
                        }
                        case 4:
                        {
                            for (new i = 0; i < sizeof(ObjectsPlants); i++)
                            {
                                if(ObjectsPlants[i][plntId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsPlants[i][plntId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsPlants[i][plntId]);
                                }
                            }
                        }
                        case 5:
                        {
                            for (new i = 0; i < sizeof(ObjectsPaint); i++)
                            {
                                if(ObjectsPaint[i][pntId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsPaint[i][pntId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsPaint[i][pntId]);
                                }
                            }
                        }
                        case 6:
                        {
                            for (new i = 0; i < sizeof(ObjectsLights); i++)
                            {
                                if(ObjectsLights[i][lgtId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsLights[i][lgtId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsLights[i][lgtId]);
                                }
                            }
                        }
                        case 7:
                        {
                            for (new i = 0; i < sizeof(ObjectsTables); i++)
                            {
                                if(ObjectsTables[i][tablId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsTables[i][tablId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsTables[i][tablId]);
                                }
                            }
                        }
                        case 8:
                        {
                            for (new i = 0; i < sizeof(ObjectsChair); i++)
                            {
                                if(ObjectsChair[i][chId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsChair[i][chId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsChair[i][chId]);
                                }
                            }
                        }
                        case 9:
                        {
                            for (new i = 0; i < sizeof(ObjectsHeater); i++)
                            {
                                if(ObjectsHeater[i][htrId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsHeater[i][htrId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsHeater[i][htrId]);
                                }
                            }
                        }
                        case 10:
                        {
                            for (new i = 0; i < sizeof(ObjectsCurtains); i++)
                            {
                                if(ObjectsCurtains[i][crtId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsCurtains[i][crtId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsCurtains[i][crtId]);
                                }
                            }
                        }
                        case 11:
                        {
                            for (new i = 0; i < sizeof(ObjectsWindows); i++)
                            {
                                if(ObjectsWindows[i][wnId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsWindows[i][wnId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsWindows[i][wnId]);
                                }
                            }
                        }
                    }
                    FurObjectSection[playerid] = listitem;
                }
                case 5:
                { // Ostalo
                    switch (listitem)
                    {
                        case 0:
                        {
                            for (new i = 0; i < sizeof(ObjectsFun); i++)
                            {
                                if(ObjectsFun[i][fnId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsFun[i][fnId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsFun[i][fnId]);
                                }
                            }
                        }
                        case 1:
                        {
                            for (new i = 0; i < sizeof(ObjectsDrinks); i++)
                            {
                                if(ObjectsDrinks[i][drnksId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsDrinks[i][drnksId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsDrinks[i][drnksId]);
                                }
                            }
                        }
                        case 2:
                        {
                            for (new i = 0; i < sizeof(ObjectsSports); i++)
                            {
                                if(ObjectsSports[i][gmId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsSports[i][gmId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsSports[i][gmId]);
                                }
                            }
                        }
                        case 3:
                        {
                            for (new i = 0; i < sizeof(ObjectsRest); i++)
                            {
                                if(ObjectsRest[i][etcId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsRest[i][etcId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsRest[i][etcId]);
                                }
                            }
                        }
                        case 4:
                        {
                            for (new i = 0; i < sizeof(ObjectsWalls); i++)
                            {
                                if(ObjectsWalls[i][wlId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsWalls[i][wlId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsWalls[i][wlId]);
                                }
                            }
                        }
                        case 5:
                        {
                            if(!PlayerVIP[playerid][pDonateRank])
                            {
                                SendClientMessage(playerid, COLOR_RED, "[!] Samo VIP korisnici mogu ovo koristiti!");
                                ShowPlayerDialog(playerid, DIALOG_FURNITURE_BUY, DIALOG_STYLE_LIST, "Furniture - Kategorije", "Dnevni Boravak\nKuhinja\nKupaonica\nSobe\nOstalo\n", "Choose", "Abort");
                                return 1;
                            }
                            for (new i = 0; i < sizeof(ObjectsAnimals); i++)
                            {
                                if(ObjectsAnimals[i][amId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsAnimals[i][amId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsAnimals[i][amId]);
                                }
                            }
                        }
                        case 6:
                        {
                            for (new i = 0; i < sizeof(ObjectsOffice); i++)
                            {
                                if(ObjectsOffice[i][ofId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsOffice[i][ofId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsOffice[i][ofId]);
                                }
                            }
                        }
                        case 7:
                        {
                            for (new i = 0; i < sizeof(FurnitureM); i++)
                            {
                                if(FurnitureM[i][fmId] != 0)
                                {
                                    fselection_add_item(playerid, FurnitureM[i][fmId]);
                                    Player_ModelToIndexSet(playerid, i, FurnitureM[i][fmId]);
                                }
                            }
                        }
                        case 8:
                        {
                            for (new i = 0; i < sizeof(ObjectsFood); i++)
                            {
                                if(ObjectsFood[i][foodId] != 0)
                                {
                                    fselection_add_item(playerid, ObjectsFood[i][foodId]);
                                    Player_ModelToIndexSet(playerid, i, ObjectsFood[i][foodId]);
                                }
                            }
                        }
                    }
                    FurObjectSection[playerid] = listitem;
                }
            }
            fselection_show(playerid, ms_HFUR_BUY, "Furniture Buy");
            return 1;
        }
        case DIALOG_FURNITURE_EDIT_LIST:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");

            switch (listitem)
            {
                case 0:
                {   // UI Edit
                    EditFurnitureObject(playerid, PlayerEditIndex[playerid]);
                }
                case 1:
                {   // Texture
                    new motd[64],
                        dialogPos = 0;
                    LastTextureListIndex[playerid] = 1;
                    texture_buffer[0] = EOS;
                    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
                    // TODO: why is this hardcoded? array indexes should start at 0, unless it is intentional...
                    for (new i = 1; i < 16; i++)
                    {
                        format(motd, sizeof(motd), "%d\t%s\t%s\n",
                            ObjectTextures[i][tModel],
                            ObjectTextures[i][tTXDName],
                            ObjectTextures[i][tName]
                       );
                        strcat(texture_buffer, motd);

                        TextureDialogItem[playerid][dialogPos] = i;
                        dialogPos++;
                    }
                    strcat(texture_buffer, "Potrazi teksturu\nDalje");
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", texture_buffer, "Choose", "Abort");
                }
                case 2:
                {   // Boje
                    new
                        buffer[4096],
                        motd[64];

                    for (new i = 0; i < sizeof(ColorList); i++)
                    {
                        format(motd, sizeof(motd), "%s%s\n",
                            ColorList[i][clEmbedCol],
                            ColorList[i][clName]
                       );
                        strcat(buffer, motd, sizeof(buffer));
                    }
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_LIST, DIALOG_STYLE_LIST, "Furniture - Odabir boja", buffer, "Choose", "Abort");
                }
                case 3:
                {   // Kopiraj
                    new
                        houseid = GetPlayerFurnitureHouse(playerid),
                        index   = PlayerEditIndex[playerid];

                    if(houseid == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete kucu ili ju ne uredjujete!");
                    if(!CopyFurnitureObject(playerid, index)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se pogreska! Ponovno pokusajte kopirati objekt!");
                }
                case 4:
                {   // Obrisi
                    va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_DELETE, DIALOG_STYLE_MSGBOX, "Furniture - Brisanje", "Zelite li obrisati objekt u slotu %d?", "Yes", "No", PlayerEditIndex[playerid]);
                }
                case 5:
                { // Obrisi boju i teksturu
                    ShowPlayerDialog(playerid, DIALOG_FURNITURE_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura (0-4):", "Input", "Abort");
                }
            }
            return 1;
        }
        case DIALOG_FURNITURE_DELETE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            new 
                houseid = GetPlayerFurnitureHouse(playerid);
            if(houseid == INVALID_HOUSE_ID)
                return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

            DeleteFurnitureObject(houseid, playerid, PlayerEditIndex[playerid]);
            return 1;
        }
        case DIALOG_FURNITURE_TXTS:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            // TODO: why is this hardcoded?
            if(listitem == 15) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
            if(listitem == 16 && LastTextureListIndex[playerid] < 40)
            {
                LastTextureListIndex[playerid]++;
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
                return 1;
            }
            if(listitem == 17 && LastTextureListIndex[playerid] > 0)
            {
                if(--LastTextureListIndex[playerid] <= 0)
                    LastTextureListIndex[playerid] = 1;
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
                return 1;
            }

            PlayerEditTxtIndex[playerid] = GetPlayerTextureItem(playerid, listitem);
            ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti teksturu (0-4)!", "Input", "Abort");
            return 1;
        }
        case DIALOG_FURNITURE_TXTS_SRCH_1:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");

            if(listitem == 0)
            {
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_2, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite znak ili djelomican naziv teksture koju trazite (TXDName (MINIMUM 3 ZNAKA)):", "Input", "Abort");
            }
            else if(listitem == 1)
            {
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_3, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite modelid teksture:", "Input", "Abort");
            }
            return 1;
        }
        case DIALOG_FURNITURE_TXTS_SRCH_2:
        {
            if(!response) return va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            if(strlen(inputtext) < 3)
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate unijeti minimalno 3 znaka kao ime TXD-a!");
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_1, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite znak ili djelomican naziv teksture koju trazite (ime ili ime TXD-a):", "Input", "Abort");
                return 1;
            }

            ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Pronadjene Teksture", ShowSearchedTextureList(playerid, inputtext), "Choose", "Abort");
            return 1;
        }
        case DIALOG_FURNITURE_TXTS_SRCH_3:
        {
            if(!response) return va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            if(strlen(inputtext) < 4)
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate unijeti minimalno 4 znaka kao modelid TXD-a!");
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
                return 1;
            }
            if(!IsNumeric(inputtext))
            {
                SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unos mora biti numericki!");
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
                return 1;
            }

            ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Pronadjene Teksture", ShowModelSearchedTextureList(playerid, strval(inputtext)), "Choose", "Abort");
            return 1;
        }
        case DIALOG_FURNITURE_TXTS_SLOT:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");

            new houseid = GetPlayerFurnitureHouse(playerid);
            if(houseid == INVALID_HOUSE_ID)
                return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

            new slot = strval(inputtext);
            if(slot < 1 || slot > 5)
            {
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti teksturu "COL_RED"(1-5)", "Input", "Abort");
                return 1;
            }
            va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Teksture", "Zelite li staviti odabranu teksturu na objekt u slot %d?", "Yes", "No", slot);
            PlayerEditTxtSlot[playerid] = slot - 1;

            new
                texture_index = PlayerEditTxtIndex[playerid],
                furniture_index = PlayerEditIndex[playerid];
            // TODO: indexes bounds check
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][furniture_index], slot, ObjectTextures[texture_index][tModel], ObjectTextures[texture_index][tTXDName], ObjectTextures[texture_index][tName], 0);
            return 1;
        }
        case DIALOG_FURNITURE_TXTS_SURE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
            if(!SetFurnitureObjectTexture(playerid, PlayerEditTxtSlot[playerid], PlayerEditTxtIndex[playerid], PlayerEditIndex[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Doslo je do greske. Pokusajte ponovno!");
            return 1;
        }
        case DIALOG_FURNITURE_COL_LIST:
        {
            if(!response) return 1;

            PlayerEditTxtIndex[playerid] = listitem;
            ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti odabranu boju (0-4)!", "Input", "Abort");
            return 1;
        }
        case DIALOG_FURNITURE_COL_SLOT:
        {
            if(!response)
            {
                new
                    buffer[4096],
                    motd[64];

                for (new i = 0; i < sizeof(ColorList); i++)
                {
                    format(motd, sizeof(motd), "%s%s\n",
                        ColorList[i][clEmbedCol],
                        ColorList[i][clName]
                   );
                    strcat(buffer, motd, sizeof(buffer));
                }

                ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_LIST, DIALOG_STYLE_LIST, "Furniture - Odabir boja", buffer, "Choose", "Abort");
                return 1;
            }

            new houseid = GetPlayerFurnitureHouse(playerid);
            if(houseid == INVALID_HOUSE_ID)
                return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

            new slotid = strval(inputtext);
            if(slotid < 1 || slotid > 5)
            {
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Color Slots", "Unesite slot u koji zelite staviti odabranu boju (1-5)!", "Input", "Abort");
                return 1;
            }

            PlayerEditTxtSlot[playerid] = slotid - 1;
            // TODO: this logic might be wrong, you're asking the user to confirm the color slot ID here
            // but you're also setting this color immediately? shouldn't this be set on the next step if user clicked "Yes"
            va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Boje", "Zelite li staviti odabranu boju u slot %d?", "Yes", "No", slotid);

            // TODO: bounds checking on all array access indexes!!
            new
                texture_index   = PlayerEditTxtIndex[playerid],
                edit_index      = PlayerEditIndex[playerid],
                furniture_index = HouseInfo[houseid][hFurTxtId][edit_index][slotid],
                colorid;

            sscanf(ColorList[texture_index][clRGB], "h", colorid);
            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][furniture_index], slotid, ObjectTextures[texture_index][tModel], ObjectTextures[texture_index][tTXDName], ObjectTextures[texture_index][tName], colorid);
            return 1;
        }
        case DIALOG_FURNITURE_COL_SURE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Color Slots", "Unesite slot u koji zelite staviti odabranu boju (1-5)!", "Input", "Abort");

            if(!SetFurnitureObjectColor(playerid, PlayerEditTxtSlot[playerid], PlayerEditTxtIndex[playerid], PlayerEditIndex[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Doslo je do greske. Pokusajte ponovno!");
            return 1;
        }
        case DIALOG_FURNITURE_SLOT_DELETE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            new slot = strval(inputtext);
            if(slot < 1 || slot > 5)
            {
                ShowPlayerDialog(playerid, DIALOG_FURNITURE_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura "COL_YELLOW"(1-5)", "Input", "Abort");
                return 1;
            }

            PlayerEditClsIndex[playerid] = slot - 1;
            va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_SLOT_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Brisanje tekstura i boja", "Zelite li obrisati teksture i boje na slotu %d?", "Yes", "No", slot);
            return 1;
        }
        case DIALOG_FURNITURE_SLOT_SURE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_FURNITURE_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura "COL_YELLOW"(0-4)", "Input", "Abort");

            new houseid = GetPlayerFurnitureHouse(playerid);
            if(houseid == INVALID_HOUSE_ID)
                return SendErrorMessage(playerid, "Niste u svojoj kuci / nemate dozvolu za postavljanje namjestaja.");

            // TODO: houseid, slot, edit_index bounds check
            new
                slot       = PlayerEditClsIndex[playerid],
                edit_index = PlayerEditIndex[playerid];

            HouseInfo[houseid][hFurTxtId][edit_index][slot] = 0;
            HouseInfo[houseid][hFurColId][edit_index][slot] = -1;

            mysql_fquery(g_SQL, "UPDATE furniture SET texture_%d = '0', color_%d = '-1' WHERE sqlid = '%d'",
                (slot+1),
                (slot+1),
                HouseInfo[houseid][hFurSQL][edit_index]
           );

            SetDynamicObjectMaterial(HouseInfo[houseid][hFurObjectid][edit_index], slot, -1, "none", "none", 0);
            va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste obrisali teksturu i boju na Slotu %d za odabrani objekt.", slot);

            PlayerEditIndex   [playerid] = -1;
            PlayerEditClsIndex[playerid] = -1;
            return 1;
        }
        case DIALOG_FURNITURE_BINT_SURE:
        {
            if(!response) return 1;

            new houseid = PlayerKeys[playerid][pHouseKey];
            if(!BuyBlankInterior(playerid, houseid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se nekakva pogreska, ponovno kucajte /bint buy!");
            return 1;
        }
    }
    return 0;
}

hook OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    switch (EditState[playerid])
    {
        case EDIT_STATE_PREVIEW:
        {
            if(response == EDIT_RESPONSE_FINAL)
            {
                CreateFurnitureObject(playerid, PlayerPrwsModel[playerid], fX, fY, fZ, fRotX, fRotY, fRotZ, (FurObjectSection[playerid] == 10) ? true : false);
            }
            else if(response == EDIT_RESPONSE_CANCEL)
            {
                if(IsValidPlayerObject(playerid, objectid))
                {
                    DestroyPlayerObject(playerid, PlayerPrwsObject[playerid]);
                    PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
                    CancelEdit(playerid);
                }
                PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
                PlayerPrwsIndex [playerid] = -1;
                PlayerPrwsModel [playerid] = -1;
                FurObjectSection[playerid] = 0;
                FurnObjectsType [playerid] = 0;
                EditState       [playerid] = -1;
            }
        }
        case EDIT_STATE_EDIT:
        {
            if(PlayerEditObject[playerid] != objectid)
            {
                return;
            }

            if(response == EDIT_RESPONSE_FINAL)
            {
                SetFurnitureObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
            }
            else if(response == EDIT_RESPONSE_CANCEL)
            {
                if(IsValidPlayerObject(playerid, objectid))
                {
                    SetFurnitureObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
                    EditState[playerid] = -1;
                }
            }
        }
    }
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    switch (fselectid)
    {
        case ms_HFUR_EDIT:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");

            PlayerEditIndex[playerid] = Player_ModelToIndex(playerid, modelid);
            va_ShowPlayerDialog(playerid, DIALOG_FURNITURE_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            ResetModelShuntVar(playerid);
        }
        case ms_HFUR_BUY:
        {
            if(!response)
            {
                switch (FurnObjectsType[playerid])
                {
                    case 1: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Dnevni", "Kauci\nFotelje\nStolovi\nOrmarici\nTelevizori\nVidei\nHi-Fi\nZvucnici\nTepisi\nSvijetla\nVrata\n", "Choose", "Abort"); // Dnevni
                    case 2: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kuhinja", "Frizider\nKuhinjski ormarici\nSudoper\nStednjak\nMikrovalna\nKanta za smece\nSvijetla\nPosudje\n", "Choose", "Abort"); // Kuhinja
                    case 3: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kupaonica", "WC skoljke\nKade\nOgledalo\n", "Choose", "Abort"); // Kupaonica
                    case 4: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Soba", "Kreveti\nNocni ormarici\nKovcezi\nOdjeca\nBiljke\nSlike\nSvjetla\nStolovi\nStolice\nRadijatori\nZastori\nStaklo", "Choose", "Abort"); // Sobe
                    case 5: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Ostalo", "Zabava\nPica\nSport\nOstalo\nZidovi\nPremium\nOffice\nFM Objects\nHrana", "Choose", "Abort"); // Ostalo
                }
                return 1;
            }

            new index = Player_ModelToIndex(playerid, modelid);
            if(AC_GetPlayerMoney(playerid) < GetFurnitureObjectPrice(playerid, index))
            {
                va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za kupovinu objekta (%d$)!", GetFurnitureObjectPrice(playerid, index));

                switch (FurnObjectsType[playerid])
                {
                    case 1: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Dnevni", "Kauci\nFotelje\nStolovi\nOrmarici\nTelevizori\nVidei\nHi-Fi\nZvucnici\nTepisi\nSvijetla\nVrata\n", "Choose", "Abort"); // Dnevni
                    case 2: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kuhinja", "Frizider\nKuhinjski ormarici\nSudoper\nStednjak\nMikrovalna\nKanta za smece\nSvijetla\nPosudje\n", "Choose", "Abort"); // Kuhinja
                    case 3: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Kupaonica", "WC skoljke\nKade\nOgledalo\n", "Choose", "Abort"); // Kupaonica
                    case 4: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Soba", "Kreveti\nNocni ormarici\nKovcezi\nOdjeca\nBiljke\nSlike\nSvjetla\nStolovi\nStolice\nRadijatori\nZastori\nStaklo", "Choose", "Abort"); // Sobe
                    case 5: ShowPlayerDialog(playerid, DIALOG_FURNITURE_OBJCS, DIALOG_STYLE_LIST, "Market - Ostalo", "Zabava\nPica\nSport\nOstalo\nZidovi\nPremium\nOffice\nFM Objects\nHrana", "Choose", "Abort"); // Ostalo
                }
                return 1;
            }

            CreateFurniturePreviewObject(playerid, GetFurnitureObjectModel(playerid, index), index);
            return 1;
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

/*
    d888888b d8b   db d888888b d88888b d8888b. d888888b  .d88b.  d8888b.
      88'   888o  88 ~~88~~' 88'     88  8D   88'   .8P  Y8. 88  8D
       88    88V8o 88    88    88ooooo 88oobY'    88    88    88 88oobY'
       88    88 V8o88    88    88~~~~~ 888b      88    88    88 888b
      .88.   88  V888    88    88.     88 88.   .88.   8b  d8' 88 88.
    Y888888P VP   V8P    YP    Y88888P 88   YD Y888888P  Y88P'  88   YD
*/

CMD:bint(playerid, params[])
{
    //if(!PlayerInfo[playerid][pAdmin]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
    new param[6];
    if(sscanf(params, "s[6]", param))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /bint [test/buy/exit]");
        return 1;
    }

    if(!strcmp(param, "test", true))
    {
        new houseid = PlayerKeys[playerid][pHouseKey];
        // TODO: why are there some houseids hardcoded here? remove this.
        if(houseid == INVALID_HOUSE_ID || (556 < houseid < 575)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate posjedovati kucu ili posjedujete apartman.");
        if(!IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti ispred kuce!");

        new buffer[1024] = "Naziv\tCijena\n";
        new row[42];
        for (new i = 0; i < sizeof(BlankInts); i++)
        {
            format(row, sizeof(row), "%s\t%d$\n", BlankInts[i][iName], BlankInts[i][iPrice]);
            strcat(buffer, row);
        }
        ShowPlayerDialog(playerid, DIALOG_BLANK_INTS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Blank Interiors", buffer, "Choose", "Abort");
    }
    else if(!strcmp(param, "buy", true))
    {
        if(PreviewingInterior[playerid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate prvo uci i pregledati prazan interijer!");
        new houseid = PlayerKeys[playerid][pHouseKey];
        if(houseid == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate posjedovati kucu!");

        ShowPlayerDialog(playerid, DIALOG_FURNITURE_BINT_SURE, DIALOG_STYLE_MSGBOX, "{3C95C2} [INTERIOR - WARNING]", "Zelite li kupiti prazan interijer?\n"COL_RED"[UPOZORENJE]: Police s oruzjem, droga i trenutni namjestaj u vasoj kuci ce biti obrisan\nNapominjemo Vam da prije nego sto se odlucite za promijenu interiora, izvadite oruzje i drogu.", "Yes", "No");
    }
    else if(!strcmp(param, "exit", true))
    {
        if(PreviewingInterior[playerid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne gledate prazne interijere!");
        if(!ExitBlankInteriorPreview(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Dogodila se nekakva pogreska, ponovno kucajte /bint exit!");
    }
    return 1;
}

/*
     .d88b.  d8888b.    d88b d88888b  .o88b. d888888b .d8888.
    .8P  Y8. 88  8D    8P' 88'     d8P  Y8 ~~88~~' 88'  YP
    88    88 88oooY'     88  88ooooo 8P         88    8bo.
    88    88 88~~~b.     88  88~~~~~ 8b         88      Y8b.
    8b  d8' 88   8D db. 88  88.     Y8b  d8    88    db   8D
     Y88P'  Y8888P' Y8888P  Y88888P  Y88P'    YP    8888Y'
*/

CMD:furniture(playerid, params[])
{
    new
        param[8],
        furhouse = GetPlayerFurnitureHouse(playerid);
    // TODO: why are some house IDs hardcoded here? remove this
    if(furhouse == INVALID_HOUSE_ID || (556 < furhouse < 575)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate posjedovati kucu/imati dozvolu za namjestanje interijera-");
    if(sscanf(params, "s[8]", param))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: /furniture [approve/menu]");
        va_SendClientMessage(playerid, COLOR_RED, "[!] Trenutno imate %d/%d popunjenih slotova u vasoj kuci.", Iter_Count(HouseFurInt[furhouse]), GetFurnitureSlots(playerid, PlayerVIP[playerid][pDonateRank]));
        return 1;
    }

    if(!strcmp("menu", param, true))
    {
        if(EditState[playerid] != -1)
        {
            if(IsValidPlayerObject(playerid, PlayerPrwsObject[playerid]))
            {
                CancelEdit(playerid);
                DestroyPlayerObject(playerid, PlayerPrwsObject[playerid]);
                PlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
            }
            EditState[playerid] = -1;
        }
        new
            houseid = GetPlayerFurnitureHouse(playerid);
        if(houseid == INVALID_HOUSE_ID) 
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate posjedovati kucu ili posjedujete apartman.");

        ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");
        return 1;
    }
    else if(!strcmp("approve", param, true))
    {
        if(PlayerKeys[playerid][pHouseKey] == INVALID_HOUSE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete kucu!");

        new giveplayerid;
        if(sscanf(params, "s[8]u", param, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /furniture approve [dio imena/playerid]");
        if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos playerida!");
        if(!ProxDetectorS(8.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");

        if(PlayerEditingHouse[giveplayerid] == PlayerKeys[playerid][pHouseKey])
        {
            PlayerEditingHouse[giveplayerid] = INVALID_HOUSE_ID;
            va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Skinuli ste %s dopustenje za uredjivanje kuce!", GetName(giveplayerid, false));
            va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je skinio dopustenje za uredjivanje njegove kuce!", GetName(playerid, false));
            return 1;
        }

        foreach (new i : Player)
        {
            if(PlayerEditingHouse[i] == PlayerKeys[playerid][pHouseKey])
                return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste odobrili %s da vam uredjuje kucu!", GetName(i, false));
        }
        PlayerEditingHouse[giveplayerid] = PlayerKeys[playerid][pHouseKey];
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Dopustili ste %s da vam uredjuje kucu!", GetName(giveplayerid, false));
        va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mu uredjujete kucu. Kucajte /furniture menu!", GetName(playerid, false));
        return 1;
    }
    return 1;
}

CMD:door(playerid, params[])
{
    new
        houseid  = Player_InHouse(playerid),
        biznisid = Player_InBusiness(playerid);

    if(houseid != INVALID_HOUSE_ID)
        RotateHouseFurDoor(houseid, playerid);
    else if(biznisid != INVALID_BIZNIS_ID)
        RotateBizzFurDoor(biznisid, playerid);
    
    return 1;
}

CMD:afurniture(playerid, params[])
{ // leo - novo.
    new action[15], target_id, house_id;

    if(PlayerInfo[playerid][pAdmin] < 1)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 1+).");
    if(sscanf(params, "s[15]", action))
    {
        SendClientMessage(playerid, COLOR_RED, "[!] /afurniture [option].");
        va_SendClientMessage(playerid, 0xAFAFAFAA, "(options): reload, checkslots, update(vip), setpremium(%d slots).", FURNITURE_PREMIUM_OBJECTS);
        return 1;
    }

    if(!strcmp(action, "reload", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 3)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 3+).");

        if(sscanf(params, "s[15]i", action, house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[?]: /afurniture reload [house_id].");
            return 1;
        }
        if(!House_Exists(house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Neispravan ID kuce (kuca ne postoji)!");
            return 1;
        }

        ReloadHouseFurniture(house_id);
        SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Svi furniture objekti su reloadani!");
        return 1;
    }
    else if(!strcmp(action, "checkslots", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 4)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 4+).");

        if(sscanf(params, "s[15]ui", action, target_id, house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[?]: /afurniture checkslots [playerid][house_id].");
            return 1;
        }
        if(target_id == INVALID_PLAYER_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Taj igrac nije online!");
            return 1;
        }
        if(!House_Exists(house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Neispravan ID kuce (kuca ne postoji)!");
            return 1;
        }

        GetHouseFurnitureSlot(target_id, house_id);
        va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sljedeci free slot: %d(house: %d).", FreeFurniture_Slot[target_id], house_id);
        return 1;
    }
    else if(!strcmp(action, "setpremium", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1338)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Vi ne mozete koristit ovu komandu.");

        if(sscanf(params, "s[15]ui", action, target_id, house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[?]: /afurniture setpremium [playerid][house_id].");
            return 1;
        }
        if(target_id == INVALID_PLAYER_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Taj igrac nije online!");
            return 1;
        }
        if(!House_Exists(house_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Neispravan ID kuce (kuca ne postoji)!");
            return 1;
        }

        SetPlayerPremiumFurniture(target_id, house_id);
        va_SendMessage(playerid, MESSAGE_TYPE_INFO, "Postavili ste igracu %s (house_id: %d) premium furniture slotove (%d).", GetName(target_id, true), house_id, FURNITURE_PREMIUM_OBJECTS);
        va_SendClientMessage(target_id, COLOR_RED, "[!] Administrator %s vam je postavio premium furniture slotove (%d).", GetName(playerid, true), FURNITURE_PREMIUM_OBJECTS);
        return 1;
    }
    else if(!strcmp(action, "update", true))
    {
        if(PlayerInfo[playerid][pAdmin] < 1337)
            return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande (admin lvl 1337+).");

        if(sscanf(params, "s[15]u", action, target_id))
        {
            SendClientMessage(playerid, COLOR_RED, "[?]: /afurniture update [playerid].");
            return 1;
        }
        if(target_id == INVALID_PLAYER_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "[!]: Taj igrac nije online!");
            return 1;
        }

        va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste refreshali furniture slotove igracu %s.", GetName(target_id, true));
        UpdatePremiumHouseFurSlots(target_id, playerid, PlayerKeys[target_id][pHouseKey]);
        return 1;
    }
    return 1;
}