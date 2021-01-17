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
    Iterator:BizzFurniture[MAX_BIZZES]<MAX_BIZNIS_FURNITURE_SLOTS>;

enum E_BLANK_BIZZ_INTERIORS
{
    iName[23],
    iPrice,
    Float:iPosX,
    Float:iPosY,
    Float:iPosZ
}

static const BlankBiznisInts[][E_BLANK_BIZZ_INTERIORS] =
{
    {"Alhambra"     , 32000, 1401.2118, -601.8583, 1085.2982},
    {"Striptiz Klub", 15000, 1455.9713, -625.7620, 1083.7324},
    {"Bar #1"       , 10000, 1528.0566, -604.3051, 1081.5253},
    {"Bar #2"       , 10000, 1572.4071, -612.9453, 1085.1899},
    {"Dounat Shop"  , 18000, 1419.8278, -577.4178, 1085.9323},
    {"Burger King"  , 15000, 1444.1023, -576.2524, 1083.9142},
    {"Cluckin' Bell", 15000, 1476.6700, -565.7532, 1081.9666},
    {"Pizza Stack"  , 15000, 1523.1014, -573.5550, 1079.8257}
};

static
    texture_buffer          [10256],
    BizzEditState           [MAX_PLAYERS] = {-1, ...},
    BizzViewingInterior     [MAX_PLAYERS] = {-1, ...},

    BizzFurObjectSection    [MAX_PLAYERS],
    BizzFurnObjectsType     [MAX_PLAYERS],
    BizzPlayerPrwsObject    [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    BizzPlayerPrwsIndex     [MAX_PLAYERS],
    BizzPlayerPrwsModel     [MAX_PLAYERS],
    BizzPlayerEditIndex     [MAX_PLAYERS],
    BizzPlayerEditObject    [MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    BizzPlayerEditType      [MAX_PLAYERS],
    BizzPlayerEditTxtIndex  [MAX_PLAYERS],
    BizzPlayerEditTxtSlot   [MAX_PLAYERS],
    PlayerEditingBiznis     [MAX_PLAYERS] = {INVALID_BIZNIS_ID, ...},
    BizzPlayerEditClsIndex  [MAX_PLAYERS],
    LastBizzTextureListIndex[MAX_PLAYERS],
    BizzTextureDialogItem   [MAX_PLAYERS][16];

static
    PlayerText:IntBcg1 [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntTitle[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntBcg2 [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntName [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:IntPrice[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

// Forwards
forward OnBizzFurnitureObjectsLoad(biznisid);
forward OnBizzFurnitureObjectCreate(biznisid, index);

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
    if (IntBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntBcg1[playerid]);
        IntBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if (IntBcg2[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntBcg2[playerid]);
        IntBcg2[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if (IntTitle[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntTitle[playerid]);
        IntTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if (IntName[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, IntName[playerid]);
        IntName[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    if (IntPrice[playerid] != PlayerText:INVALID_TEXT_DRAW)
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
    if (playerid == INVALID_PLAYER_ID) return 0;
    // TODO: proper bounds check
    if (interior > sizeof(BlankBiznisInts)) return 0;

    BizzViewingInterior[playerid] = interior;

    va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Trenutno pregledavate interijer %s. Za kupnju kucajte /bint buy!", BlankBiznisInts[interior][iName]);
    CreateFurnitureBlankIntTDs(playerid, BlankBiznisInts[interior][iName], BlankBiznisInts[interior][iPrice]);
    SetPlayerPosEx(playerid, BlankBiznisInts[interior][iPosX], BlankBiznisInts[interior][iPosY], BlankBiznisInts[interior][iPosZ], playerid, 1, true);
    return 1;
}

static stock BuyBlankInterior(playerid, biznisid)
{
    new interior = BizzViewingInterior[playerid];
    // TODO: bounds check
    if (AC_GetPlayerMoney(playerid) < BlankBiznisInts[interior][iPrice])
    {
        va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate dovoljno novaca za kupovinu enterijera (%d$)!", BlankBiznisInts[interior][iPrice]);
        return 1;
    }

    BizzInfo[biznisid][bExitX] = BlankBiznisInts[interior][iPosX];
    BizzInfo[biznisid][bExitY] = BlankBiznisInts[interior][iPosY];
    BizzInfo[biznisid][bExitZ] = BlankBiznisInts[interior][iPosZ];

    mysql_fquery(g_SQL, 
        "UPDATE bizzes SET exitx = '%f', exity = '%f', exitz = '%f', interior = '%d', virtualworld = '%d' WHERE id = '%d'",
        BizzInfo[biznisid][bExitX],
        BizzInfo[biznisid][bExitY],
        BizzInfo[biznisid][bExitZ],
        BizzInfo[biznisid][bInterior],
        BizzInfo[biznisid][bVirtualWorld],
        BizzInfo[biznisid][bSQLID]
    );

    DestroyFurnitureBlankIntTDs(playerid);
    PlayerToBudgetMoney(playerid, BlankBiznisInts[interior][iPrice]); // Novac ide u proracun

    va_SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Uspjesno ste kupili interijer %s za %d$!",
        BlankBiznisInts[interior][iName],
        BlankBiznisInts[interior][iPrice]
    );
    DestroyAllFurnitureObjects(playerid, biznisid);
    SetPlayerPosEx(playerid, BizzInfo[biznisid][bExitX], BizzInfo[biznisid][bExitY], BizzInfo[biznisid][bExitZ], BizzInfo[biznisid][bVirtualWorld], BizzInfo[biznisid][bInterior], true);
    return 1;
}

static stock ExitBlankInteriorPreview(playerid)
{
    if (playerid == INVALID_PLAYER_ID) return 0;
    if (BizzViewingInterior[playerid] == -1) return 0;

    DestroyFurnitureBlankIntTDs(playerid);

    new biznisid = PlayerKeys[playerid][pBizzKey];
    // TODO: bounds check
    SetPlayerPosEx(playerid, BizzInfo[biznisid][bEntranceX], BizzInfo[biznisid][bEntranceY], BizzInfo[biznisid][bEntranceZ], 0, 0, true);
    SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Uspjesno ste izasli iz pregleda interijera!");
    BizzViewingInterior[playerid] = -1;
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
public OnBizzFurnitureObjectsLoad(biznisid)
{
    new objectCount = cache_num_rows();
    if (!objectCount) return 1;
    if (objectCount > BIZZ_FURNITURE_VIP_GOLD_OBJCTS)
        objectCount = BIZZ_FURNITURE_VIP_GOLD_OBJCTS;

    for (new i = 0; i < objectCount; i++)
    {
        cache_get_value_name_int(i,     "sqlid"         , BizzInfo[biznisid][bFurSQL][i]);
        cache_get_value_name_int(i,     "modelid"       , BizzInfo[biznisid][bFurModelid][i]);
        cache_get_value_name_int(i,     "door"          , BizzInfo[biznisid][bFurDoor][i]);
        cache_get_value_name_float(i,   "door_z"        , BizzInfo[biznisid][bFurDoorZ][i]);
        cache_get_value_name_int(i,     "locked_door"   , BizzInfo[biznisid][bFurDoorLckd][i]);
        cache_get_value_name_float(i,   "pos_x"         , BizzInfo[biznisid][bFurPosX][i]);
        cache_get_value_name_float(i,   "pos_y"         , BizzInfo[biznisid][bFurPosY][i]);
        cache_get_value_name_float(i,   "pos_z"         , BizzInfo[biznisid][bFurPosZ][i]);
        cache_get_value_name_float(i,   "rot_x"         , BizzInfo[biznisid][bFurRotX][i]);
        cache_get_value_name_float(i,   "rot_y"         , BizzInfo[biznisid][bFurRotY][i]);
        cache_get_value_name_float(i,   "rot_z"         , BizzInfo[biznisid][bFurRotZ][i]);
        cache_get_value_name_int(i,     "texture_1"     , BizzInfo[biznisid][bFurTxtId][i][0]);
        cache_get_value_name_int(i,     "texture_2"     , BizzInfo[biznisid][bFurTxtId][i][1]);
        cache_get_value_name_int(i,     "texture_3"     , BizzInfo[biznisid][bFurTxtId][i][2]);
        cache_get_value_name_int(i,     "texture_4"     , BizzInfo[biznisid][bFurTxtId][i][3]);
        cache_get_value_name_int(i,     "texture_5"     , BizzInfo[biznisid][bFurTxtId][i][4]);
        cache_get_value_name_int(i,     "color_1"       , BizzInfo[biznisid][bFurColId][i][0]);
        cache_get_value_name_int(i,     "color_2"       , BizzInfo[biznisid][bFurColId][i][1]);
        cache_get_value_name_int(i,     "color_3"       , BizzInfo[biznisid][bFurColId][i][2]);
        cache_get_value_name_int(i,     "color_4"       , BizzInfo[biznisid][bFurColId][i][3]);
        cache_get_value_name_int(i,     "color_5"       , BizzInfo[biznisid][bFurColId][i][4]);

        BizzInfo[biznisid][bFurObjectid][i] = CreateDynamicObject(BizzInfo[biznisid][bFurModelid][i], BizzInfo[biznisid][bFurPosX][i], BizzInfo[biznisid][bFurPosY][i], BizzInfo[biznisid][bFurPosZ][i], BizzInfo[biznisid][bFurRotX][i], BizzInfo[biznisid][bFurRotY][i], BizzInfo[biznisid][bFurRotZ][i], BizzInfo[biznisid][bVirtualWorld], BizzInfo[biznisid][bInterior], -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);

        new colorid;
        for (new slot = 0; slot < MAX_COLOR_TEXT_SLOTS; slot++)
        {
            if (BizzInfo[biznisid][bFurColId][i][slot] > -1)
            {
                sscanf(ColorList[ BizzInfo[biznisid][bFurColId][i][slot] ][clRGB], "h", colorid);
                SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][i], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tName], colorid);
            }
            else
            {
                SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][i], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][i][slot] ][tName], 0);
            }
        }
        Iter_Add(BizzFurniture[biznisid], i);
    }
    return 1;
}

stock InsertBizzFurnitureObject(biznisid, index)
{
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, 
            "INSERT INTO biznis_furniture (biznisid,modelid,door,door_z,locked_door,pos_x,pos_y,pos_z,rot_x,rot_y,rot_z,\n\
                texture_1,texture_2,texture_3,texture_4,texture_5,color_1,color_2,color_3,color_4,color_5) \n\
                VALUES ('%d','%d','%d','%f','%d','%f','%f','%f','%f','%f','%f','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d')",
            BizzInfo[biznisid][bSQLID],
            BizzInfo[biznisid][bFurModelid][index],
            BizzInfo[biznisid][bFurDoor][index],
            BizzInfo[biznisid][bFurDoorZ][index],
            BizzInfo[biznisid][bFurDoorLckd][index],
            BizzInfo[biznisid][bFurPosX][index],
            BizzInfo[biznisid][bFurPosY][index],
            BizzInfo[biznisid][bFurPosZ][index],
            BizzInfo[biznisid][bFurRotX][index],
            BizzInfo[biznisid][bFurRotY][index],
            BizzInfo[biznisid][bFurRotZ][index],
            BizzInfo[biznisid][bFurTxtId][index][0],
            BizzInfo[biznisid][bFurTxtId][index][1],
            BizzInfo[biznisid][bFurTxtId][index][2],
            BizzInfo[biznisid][bFurTxtId][index][3],
            BizzInfo[biznisid][bFurTxtId][index][4],
            BizzInfo[biznisid][bFurColId][index][0],
            BizzInfo[biznisid][bFurColId][index][1],
            BizzInfo[biznisid][bFurColId][index][2],
            BizzInfo[biznisid][bFurColId][index][3],
            BizzInfo[biznisid][bFurColId][index][4]
        ), 
        "OnBizzFurnitureObjectCreate", 
        "ii", 
        biznisid, 
        index
    );
    return 1;
}

public OnBizzFurnitureObjectCreate(biznisid, index)
{
    BizzInfo[biznisid][bFurSQL][index] = cache_insert_id();
    Iter_Add(BizzFurniture[biznisid], index);
    return 1;
}

// Stocks
stock LoadBiznisFurnitureObjects(biznisid)
{
    if(biznisid == INVALID_BIZNIS_ID) return 1;

    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM biznis_furniture WHERE biznisid = '%d'", BizzInfo[biznisid][bSQLID]), 
        "OnBizzFurnitureObjectsLoad", 
        "i", 
        biznisid
    );
    return 1;
}

static stock GetPlayerFurnitureBiznis(playerid)
{
    if (PlayerEditingBiznis[playerid] != INVALID_BIZNIS_ID)
    {
        new bizz = PlayerEditingBiznis[playerid];
        // TODO: bounds check
        if (IsPlayerInRangeOfPoint(playerid, 500.0, BizzInfo[bizz][bExitX], BizzInfo[bizz][bExitY], BizzInfo[bizz][bExitZ])
            && GetPlayerInterior(playerid) == BizzInfo[bizz][bInterior])
        {
            return PlayerEditingBiznis[playerid];
        }
    }
    if (PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID)
    {
        new bizz = PlayerKeys[playerid][pBizzKey];
        // TODO: bounds check
        if (IsPlayerInRangeOfPoint(playerid, 500.0, BizzInfo[bizz][bExitX], BizzInfo[bizz][bExitY], BizzInfo[bizz][bExitZ])
            && GetPlayerInterior(playerid) == BizzInfo[bizz][bInterior])
        {
            return PlayerKeys[playerid][pBizzKey];
        }
    }
    return INVALID_BIZNIS_ID;
}

static stock GetFurnitureObjectName(playerid, index)
{
    // TODO: index bounds check
    new name[50];
    // TODO: replace strcat with strcpy
    switch (BizzFurnObjectsType[playerid])
    {
        case 1:
        { // Bars & Disco
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  strcat(name, ObjectsCouch[index][ceName]);
                case 1:  strcat(name, ObjectsArmChair[index][armName]);
                case 2:  strcat(name, ObjectsTables[index][tablName]);
                case 3:  strcat(name, ObjectsCabinets[index][cabName]);
                case 4:  strcat(name, ObjectsTelevision[index][tvName]);
                case 5:  strcat(name, ObjectsHiFi[index][hfName]);
                case 6:  strcat(name, ObjectsStereo[index][stName]);
                case 7:  strcat(name, ObjectsRugs[index][rName]);
                case 8:  strcat(name, ObjectsLights[index][lgtName]);
                case 9:  strcat(name, ObjectsDoor[index][doorName]);
                case 10: strcat(name, ObjectsRefrigerators[index][refName]);
                case 11: strcat(name, ObjectsBarDrinks[index][bardName]);
                case 12: strcat(name, ObjectsFun[index][fnName]);
            }
        }
        case 2:     // 24/7
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: strcat(name, Objects247Fridge[index][sfrName]);
                case 1: strcat(name, ObjectsDrinks[index][drnksName]);
                case 2: strcat(name, ObjectsFood[index][foodName]);
                case 3: strcat(name, ObjectsCashRegister[index][crName]);
                case 4: strcat(name, ObjectsLights[index][lgtName]);
                case 5: strcat(name, ObjectsTrashCan[index][tcName]);
                case 6: strcat(name, Objects247Misc[index][smiscName]);
            }
        }
        case 3:     // Restoran
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  strcat(name, ObjectsTables[index][tablName]);
                case 1:  strcat(name, ObjectsCouch[index][ceName]);
                case 2:  strcat(name, ObjectsArmChair[index][armName]);
                case 3:  strcat(name, ObjectsRefrigerators[index][refName]);
                case 4:  strcat(name, ObjectsDrinks[index][drnksName]);
                case 5:  strcat(name, ObjectsFood[index][foodName]);
                case 6:  strcat(name, ObjectsCashRegister[index][crName]);
                case 7:  strcat(name, ObjectsKitchenDishes[index][dishName]);
                case 8:  strcat(name, ObjectsMicroWave[index][mwName]);
                case 9:  strcat(name, ObjectsStove[index][stName]);
                case 10: strcat(name, ObjectsKitchenCabinets[index][kcName]);
                case 11: strcat(name, ObjectsSink[index][snkName]);
            }
        }
        case 4: // Clothing
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: strcat(name, ObjectsShelfs[index][shelfName]);
                case 1: strcat(name, ObjectsCashRegister[index][crName]);
                case 2: strcat(name, ObjectsClothes[index][cloName]);
            }
        }
        case 5: // Ostalo
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: strcat(name, ObjectsWareHouse[index][whName]);
                case 1: strcat(name, ObjectsParticles[index][partName]);
                case 2: strcat(name, ObjectsWalls[index][wlName]);
                case 3: strcat(name, ObjectsSecurity[index][secName]);
            }
        }
    }
    return name;
}

stock GetFurnitureObjectPrice(playerid, index)
{
    // TODO: index bounds check
    new price = 0;
    switch (BizzFurnObjectsType[playerid])
    {
        case 1:
        { // Bars & Disco
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  price = ObjectsCouch[index][cePrice];
                case 1:  price = ObjectsArmChair[index][armPrice];
                case 2:  price = ObjectsTables[index][tablPrice];
                case 3:  price = ObjectsCabinets[index][cabPrice];
                case 4:  price = ObjectsTelevision[index][tvPrice];
                case 5:  price = ObjectsHiFi[index][hfPrice];
                case 6:  price = ObjectsStereo[index][stPrice];
                case 7:  price = ObjectsRugs[index][rPrice];
                case 8:  price = ObjectsLights[index][lgtPrice];
                case 9:  price = ObjectsDoor[index][doorPrice];
                case 10: price = ObjectsRefrigerators[index][refPrice];
                case 11: price = ObjectsBarDrinks[index][bardPrice];
                case 12: price = ObjectsFun[index][fnPrice];
            }
        }
        case 2:     // 24/7
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: price = Objects247Fridge[index][sfrPrice];
                case 1: price = ObjectsDrinks[index][drnksPrice];
                case 2: price = ObjectsFood[index][foodPrice];
                case 3: price = ObjectsCashRegister[index][crPrice];
                case 4: price = ObjectsLights[index][lgtPrice];
                case 5: price = ObjectsTrashCan[index][tcPrice];
                case 6: price = Objects247Misc[index][smiscPrice];
            }
        }
        case 3:     // Restoran
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  price = ObjectsTables[index][tablPrice];
                case 1:  price = ObjectsCouch[index][cePrice];
                case 2:  price = ObjectsArmChair[index][armPrice];
                case 3:  price = ObjectsRefrigerators[index][refPrice];
                case 4:  price = ObjectsDrinks[index][drnksPrice];
                case 5:  price = ObjectsFood[index][foodPrice];
                case 6:  price = ObjectsCashRegister[index][crPrice];
                case 7:  price = ObjectsKitchenDishes[index][dishPrice];
                case 8:  price = ObjectsMicroWave[index][mwPrice];
                case 9:  price = ObjectsStove[index][stPrice];
                case 10: price = ObjectsKitchenCabinets[index][kcPrice];
                case 11: price = ObjectsSink[index][snkPrice];
            }
        }
        case 4: // Clothing
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: price = ObjectsShelfs[index][shelfPrice];
                case 1: price = ObjectsCashRegister[index][crPrice];
                case 2: price = ObjectsClothes[index][cloPrice];
            }
        }
        case 5: // Ostalo
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: price = ObjectsWareHouse[index][whPrice];
                case 1: price = ObjectsParticles[index][partPrice];
                case 2: price = ObjectsWalls[index][wlPrice];
                case 3: price = ObjectsSecurity[index][secPrice];
            }
        }
    }
    return price;
}

static stock GetFurnitureObjectModel(playerid, index)
{
    // TODO: index bounds check
    new modelid;
    switch (BizzFurnObjectsType[playerid])
    {
        case 1:
        { // Bars & Disco
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  modelid = ObjectsCouch[index][ceId];
                case 1:  modelid = ObjectsArmChair[index][armId];
                case 2:  modelid = ObjectsTables[index][tablId];
                case 3:  modelid = ObjectsCabinets[index][cabId];
                case 4:  modelid = ObjectsTelevision[index][tvId];
                case 5:  modelid = ObjectsHiFi[index][hfId];
                case 6:  modelid = ObjectsStereo[index][stId];
                case 7:  modelid = ObjectsRugs[index][rId];
                case 8:  modelid = ObjectsLights[index][lgtId];
                case 9:  modelid = ObjectsDoor[index][doorId];
                case 10: modelid = ObjectsRefrigerators[index][refId];
                case 11: modelid = ObjectsBarDrinks[index][bardId];
                case 12: modelid = ObjectsFun[index][fnId];
            }
        }
        case 2:     // 24/7
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: modelid = Objects247Fridge[index][sfrId];
                case 1: modelid = ObjectsDrinks[index][drnksId];
                case 2: modelid = ObjectsFood[index][foodId];
                case 3: modelid = ObjectsCashRegister[index][crId];
                case 4: modelid = ObjectsLights[index][lgtId];
                case 5: modelid = ObjectsTrashCan[index][tcId];
                case 6: modelid = Objects247Misc[index][smiscId];
            }
        }
        case 3:     // Restoran
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0:  modelid = ObjectsTables[index][tablId];
                case 1:  modelid = ObjectsCouch[index][ceId];
                case 2:  modelid = ObjectsArmChair[index][armId];
                case 3:  modelid = ObjectsRefrigerators[index][refId];
                case 4:  modelid = ObjectsDrinks[index][drnksId];
                case 5:  modelid = ObjectsFood[index][foodId];
                case 6:  modelid = ObjectsCashRegister[index][crId];
                case 7:  modelid = ObjectsKitchenDishes[index][dishId];
                case 8:  modelid = ObjectsMicroWave[index][mwId];
                case 9:  modelid = ObjectsStove[index][stId];
                case 10: modelid = ObjectsKitchenCabinets[index][kcId];
                case 11: modelid = ObjectsSink[index][snkId];
            }
        }
        case 4: // Clothing
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: modelid = ObjectsShelfs[index][shelfId];
                case 1: modelid = ObjectsCashRegister[index][crId];
                case 2: modelid = ObjectsClothes[index][cloId];
            }
        }
        case 5: // Ostalo
        {
            switch (BizzFurObjectSection[playerid])
            {
                case 0: modelid = ObjectsWareHouse[index][whId];
                case 1: modelid = ObjectsParticles[index][partId];
                case 2: modelid = ObjectsWalls[index][wlId];
                case 3: modelid = ObjectsSecurity[index][secId];
            }
        }
    }
    return modelid;
}

GetPlayerBizzFurSlots(playerid)
{
    switch (PlayerVIP[playerid][pDonateRank])
    {
        case 1: return BIZZ_FURNITURE_VIP_BRONZE_OBJCTS;
        case 2: return BIZZ_FURNITURE_VIP_SILVER_OBJCTS;
        case 3: return BIZZ_FURNITURE_VIP_GOLD_OBJCTS;
    }
    return BIZZ_FURNITURE_VIP_NONE;
}

// TODO: these 3 functions below seem like code duplication, make a generic function (if possible)
static stock ShowPlayerTextureList(playerid)
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastBizzTextureListIndex[playerid] - 1) ? 1 : ((LastBizzTextureListIndex[playerid] - 1) * 15),
        max_amount = LastBizzTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        format(motd, sizeof(motd), "%d\t%s\t%s\n",
            ObjectTextures[i][tModel],
            ObjectTextures[i][tTXDName],
            ObjectTextures[i][tName]
        );
        strcat(texture_buffer, motd, sizeof(texture_buffer));

        if (ObjectTextures[i][tModel] == 1319)
            break;

        BizzTextureDialogItem[playerid][dialogPos] = i;
        dialogPos++;
    }
    format(texture_buffer, sizeof(texture_buffer), "%sPotrazi teksturu\n%s%s", texture_buffer, (LastBizzTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastBizzTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    return texture_buffer;
}

static stock ShowSearchedTextureList(playerid, string[])
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastBizzTextureListIndex[playerid] - 1) ? 1 : ((LastBizzTextureListIndex[playerid] - 1) * 15),
        max_amount = LastBizzTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        if (strfind(ObjectTextures[i][tTXDName], string, true) != -1)
        {
            format(motd, sizeof(motd), "%d\t%s\t%s\n",
                ObjectTextures[i][tModel],
                ObjectTextures[i][tTXDName],
                ObjectTextures[i][tName]
            );
            strcat(texture_buffer, motd, sizeof(texture_buffer));

            if (ObjectTextures[i][tModel] == 1319)
                break;

            BizzTextureDialogItem[playerid][dialogPos] = i;
            dialogPos++;
        }
    }
    format(texture_buffer, sizeof(texture_buffer), "%sPotrazi teksturu\n%s%s", texture_buffer, (LastBizzTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastBizzTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    return texture_buffer;
}

static stock ShowModelSearchedTextureList(playerid, modelid)
{
    new motd[64],
        dialogPos = 0,
        amount = !(LastBizzTextureListIndex[playerid] - 1) ? 1 : ((LastBizzTextureListIndex[playerid] - 1) * 15),
        max_amount = LastBizzTextureListIndex[playerid] * 15;

    texture_buffer[0] = EOS;
    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
    for (new i = amount; i < max_amount; i++)
    {
        if (ObjectTextures[i][tModel] == modelid)
        {
            format(motd, sizeof(motd), "%d\t%s\t%s\n",
                ObjectTextures[i][tModel],
                ObjectTextures[i][tTXDName],
                ObjectTextures[i][tName]
            );
            strcat(texture_buffer, motd, sizeof(texture_buffer));

            if (ObjectTextures[i][tModel] == 1319)
                break;

            BizzTextureDialogItem[playerid][dialogPos] = i;
            dialogPos++;
        }
    }
    format(texture_buffer, sizeof(texture_buffer), "%sPotrazi teksturu\n%s%s", texture_buffer, (LastBizzTextureListIndex[playerid] < 39) ? ("Dalje\n") : ("\n"), (LastBizzTextureListIndex[playerid] == 0) ? ("") : ("\nNazad"));
    return texture_buffer;
}

static stock GetPlayerTextureItem(playerid, listitem)
{
    new
        index   = 1,
        i       = 0;

    while (i < 15)
    {
        if (i == listitem)
        {
            index = BizzTextureDialogItem[playerid][i];
            break;
        }
        i++;
    }
    return index;
}

static stock CreateFurniturePreviewObject(playerid, modelid, index)
{
    if (playerid == INVALID_PLAYER_ID) return 0;

    new
        Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    GetXYInFrontOfPlayer(playerid, X, Y, 5.0);
    BizzPlayerPrwsObject[playerid]    = CreatePlayerObject(playerid, modelid, X, Y, Z, 0.0, 0.0, 0.0);
    EditPlayerObject(playerid, BizzPlayerPrwsObject[playerid]);

    BizzPlayerPrwsIndex[playerid]     = index;
    BizzPlayerPrwsModel[playerid]     = modelid;

    SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Trenutno uredjujete objekt. Kliknite na save ikonicu za kupovinu objekta!");
    BizzEditState[playerid] = EDIT_STATE_PREVIEW;
    return 1;
}

static stock GetBiznisFurnitureSlot(biznisid)
{
    return Iter_Free(BizzFurniture[biznisid]);
}

static stock CreateBiznisFurnitureObject(playerid, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bool:doors)
{
    if (playerid == INVALID_PLAYER_ID) 
        return 0;
    new
        biznisid = GetPlayerFurnitureBiznis(playerid),
        index   = GetBiznisFurnitureSlot(biznisid);

    if (index <= -1) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate dovoljno mjesta za objekte!");

    if (IsValidPlayerObject(playerid, BizzPlayerPrwsObject[playerid]))
    {
        DestroyPlayerObject(playerid, BizzPlayerPrwsObject[playerid]);
        BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
    }

    BizzInfo[biznisid][bFurModelid][index]    = modelid;
    BizzInfo[biznisid][bFurPosX][index]       = x;
    BizzInfo[biznisid][bFurPosY][index]       = y;
    BizzInfo[biznisid][bFurPosZ][index]       = z;
    BizzInfo[biznisid][bFurRotX][index]       = rx;
    BizzInfo[biznisid][bFurRotY][index]       = ry;
    BizzInfo[biznisid][bFurRotZ][index]       = rz;

    for (new i = 0; i < MAX_COLOR_TEXT_SLOTS; i++)
    {
        BizzInfo[biznisid][bFurTxtId][index][i] = 0;
        BizzInfo[biznisid][bFurColId][index][i] = -1;
    }

    if (doors)
    {
        BizzInfo[biznisid][bFurDoor][index]       = 1;
        BizzInfo[biznisid][bFurDoorZ][index]      = -1.0;
        BizzInfo[biznisid][bFurDoorLckd][index]   = 0;
    }
    
    InsertBizzFurnitureObject(biznisid, index);
    BizzInfo[biznisid][bFurObjectid][index] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);
    new 
        price = GetFurnitureObjectPrice(playerid, BizzPlayerPrwsIndex[playerid]);
    PlayerToBudgetMoney(playerid, price); // Novac ide u proracun

    va_SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Kupili ste objekt za %d$ i stavili ga u slot %d!", price, index + 1);

    #if defined MODULE_LOGS
    Log_Write("/logfiles/furniture_buy.txt", "(%s) Player %s bought an object(modelid: %d) for %d$ in Business Furniture and placed it into slot %d.",
        ReturnDate(),
        GetName(playerid, false),
        modelid,
        price,
        index
    );
    #endif

    BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
    BizzPlayerPrwsIndex [playerid] = -1;
    BizzPlayerPrwsModel [playerid] = 0;
    BizzFurObjectSection[playerid] = 0;
    BizzFurnObjectsType [playerid] = 0;
    BizzEditState[playerid] = -1;
    
    Streamer_Update(playerid);
    return index;
}

static stock CopyFurnitureObject(playerid, copyid)
{
    if (playerid == INVALID_PLAYER_ID) return 0;

    new
        biznisid = GetPlayerFurnitureBiznis(playerid);
    if (biznisid == INVALID_BIZNIS_ID) return 0;

    new
        index   = GetBiznisFurnitureSlot(biznisid);
    if (index == -1) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate dovoljno mjesta za objekte!");

    BizzInfo[biznisid][bFurModelid][index]      = BizzInfo[biznisid][bFurModelid][copyid];
    BizzInfo[biznisid][bFurPosX][index]         = BizzInfo[biznisid][bFurPosX][copyid];
    BizzInfo[biznisid][bFurPosY][index]         = BizzInfo[biznisid][bFurPosY][copyid];
    BizzInfo[biznisid][bFurPosZ][index]         = BizzInfo[biznisid][bFurPosZ][copyid];
    BizzInfo[biznisid][bFurRotX][index]         = BizzInfo[biznisid][bFurRotX][copyid];
    BizzInfo[biznisid][bFurRotY][index]         = BizzInfo[biznisid][bFurRotY][copyid];
    BizzInfo[biznisid][bFurRotZ][index]         = BizzInfo[biznisid][bFurRotZ][copyid];

    for (new i = 0; i < MAX_COLOR_TEXT_SLOTS; i++)
    {
        BizzInfo[biznisid][bFurTxtId][index][i] = BizzInfo[biznisid][bFurTxtId][copyid][i];
        BizzInfo[biznisid][bFurColId][index][i] = BizzInfo[biznisid][bFurColId][copyid][i];
    }

    BizzInfo[biznisid][bFurObjectid][index]     = CreateDynamicObject(BizzInfo[biznisid][bFurModelid][index], BizzInfo[biznisid][bFurPosX][index], BizzInfo[biznisid][bFurPosY][index], BizzInfo[biznisid][bFurPosZ][index], BizzInfo[biznisid][bFurRotX][index], BizzInfo[biznisid][bFurRotY][index], BizzInfo[biznisid][bFurRotZ][index], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);

    new colorid;
    for (new slot = 0; slot < MAX_COLOR_TEXT_SLOTS; slot++)
    {
        if (BizzInfo[biznisid][bFurColId][index][slot] > -1)
        {
            sscanf(ColorList[ BizzInfo[biznisid][bFurColId][index][slot] ][clRGB], "h", colorid);
            SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][index], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tName], colorid);
        }
        else
        {
            SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][index], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tName], 0);
        }
    }

    InsertBizzFurnitureObject(biznisid, index);

    Streamer_Update(playerid);
    SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Uspjesno ste kopirali odabrani objekt! Sada ga postavite gdje zelite.");
    return 1;
}

static stock EditFurnitureObject(playerid, index)
{
    // TODO: proper bounds checking
    if (playerid == INVALID_PLAYER_ID || index == -1) return 0;

    new
        biznisid = GetPlayerFurnitureBiznis(playerid);
    if (biznisid == INVALID_BIZNIS_ID) return 0;

    if (IsValidDynamicObject(BizzInfo[biznisid][bFurObjectid][index]))
    {
        DestroyDynamicObject(BizzInfo[biznisid][bFurObjectid][index]);
        BizzInfo[biznisid][bFurObjectid][index] = INVALID_OBJECT_ID;

        BizzPlayerEditObject[playerid] = CreatePlayerObject(playerid, BizzInfo[biznisid][bFurModelid][index], BizzInfo[biznisid][bFurPosX][index], BizzInfo[biznisid][bFurPosY][index], BizzInfo[biznisid][bFurPosZ][index], BizzInfo[biznisid][bFurRotX][index], BizzInfo[biznisid][bFurRotY][index], BizzInfo[biznisid][bFurRotZ][index]);
        BizzEditState[playerid] = EDIT_STATE_EDIT;
        EditPlayerObject(playerid, BizzPlayerEditObject[playerid]);
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dogodila se greska s uredjivanjem objekta!");
        printf("[DEBUG] FURNITURE EDIT: biznisid(%d) | index(%d) | objectid(%d)", biznisid, index, BizzInfo[biznisid][bFurObjectid][index]);
    }
    return 1;
}

static stock SetFurnitureObjectPos(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if (playerid == INVALID_PLAYER_ID) return 0;
    if (!IsValidPlayerObject(playerid, BizzPlayerEditObject[playerid])) return 0;

    new
        index = BizzPlayerEditIndex[playerid],
        biznisid = GetPlayerFurnitureBiznis(playerid);

    if (biznisid == INVALID_BIZNIS_ID) return 0;

    CancelEdit(playerid);
    if (IsValidPlayerObject(playerid, BizzPlayerEditObject[playerid]))
    {
        DestroyPlayerObject(playerid, BizzPlayerEditObject[playerid]);
        BizzPlayerEditObject[playerid] = INVALID_OBJECT_ID;
    }

    BizzInfo[biznisid][bFurObjectid][index]   = CreateDynamicObject(BizzInfo[biznisid][bFurModelid][index], x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, FURNITURE_OBJECT_DRAW_DISTANCE, FURNITURE_OBJECT_DRAW_DISTANCE);
    BizzInfo[biznisid][bFurPosX][index]       = x;
    BizzInfo[biznisid][bFurPosY][index]       = y;
    BizzInfo[biznisid][bFurPosZ][index]       = z;
    BizzInfo[biznisid][bFurRotX][index]       = rx;
    BizzInfo[biznisid][bFurRotY][index]       = ry;
    BizzInfo[biznisid][bFurRotZ][index]       = rz;

    mysql_fquery(g_SQL, 
        "UPDATE biznis_furniture SET pos_x = '%f',pos_y = '%f',pos_z = '%f',\n\
            rot_x = '%f',rot_y = '%f',rot_z = '%f' WHERE sqlid = '%d'",
        x,
        y,
        z,
        rx,
        ry,
        rz,
        BizzInfo[biznisid][bFurSQL][index]
    );

    // TODO: this is repetitive code, extract it to a helper function
    new colorid;
    for (new slot = 0; slot < MAX_COLOR_TEXT_SLOTS; slot++)
    {
        if (BizzInfo[biznisid][bFurColId][index][slot] > -1)
        {
            sscanf(ColorList[ BizzInfo[biznisid][bFurColId][index][slot] ][clRGB], "h", colorid);
            SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][index], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tName], colorid);
        }
        else
        {
            SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][index], slot, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slot] ][tName], 0);
        }
    }

    Streamer_Update(playerid);

    BizzEditState       [playerid] = 0;
    BizzPlayerEditObject[playerid] = INVALID_OBJECT_ID;
    BizzPlayerEditIndex [playerid] = -1;
    return 1;
}

static stock SetFurnitureObjectTexture(playerid, slot, index, slotid)
{
    if (playerid == INVALID_PLAYER_ID) return 0;
    // TODO: proper bounds checking
    if (index > sizeof(ObjectTextures)) return 0;

    new
        biznisid = GetPlayerFurnitureBiznis(playerid);
    if (biznisid == INVALID_BIZNIS_ID) return 0;

    SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][slotid], slot, ObjectTextures[index][tModel], ObjectTextures[index][tTXDName], ObjectTextures[index][tName], 0);
    BizzPlayerEditTxtSlot[playerid]               = -1;
    BizzPlayerEditTxtIndex[playerid]              = -1;
    BizzInfo[biznisid][bFurTxtId][slotid][slot] = index;

    mysql_fquery(g_SQL, "UPDATE biznis_furniture SET texture_%d = '%d' WHERE sqlid = '%d'",
        slot + 1,
        BizzInfo[biznisid][bFurTxtId][slotid][slot],
        BizzInfo[biznisid][bFurSQL][slotid]
    );
    return 1;
}

static stock SetFurnitureObjectColor(playerid, slot, index, slotid)
{
    if (playerid == INVALID_PLAYER_ID) return 0;
    if (index > sizeof(ObjectTextures)) return 0;

    new
        biznisid = GetPlayerFurnitureBiznis(playerid),
        txtId   = BizzInfo[biznisid][bFurTxtId][slotid],
        colorid;

    sscanf(ColorList[index][clRGB], "h", colorid);
    if (biznisid == INVALID_BIZNIS_ID) return 0;

    SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][slotid], slot, ObjectTextures[txtId][tModel], ObjectTextures[txtId][tTXDName], ObjectTextures[txtId][tName], colorid);
    BizzPlayerEditTxtSlot[playerid]               = -1;
    BizzPlayerEditTxtIndex[playerid]              = -1;
    BizzInfo[biznisid][bFurColId][slotid][slot] = index;

    mysql_fquery(g_SQL, "UPDATE biznis_furniture SET color_%d = '%d' WHERE sqlid = '%d'",
        slot + 1,
        BizzInfo[biznisid][bFurColId][slotid][slot],
        BizzInfo[biznisid][bFurSQL][slotid]
    );
    return 1;
}

static stock DeleteFurnitureObject(biznisid, index, playerid)
{
    // TODO: bounds checking, biznisid, index
    if (biznisid == INVALID_BIZNIS_ID) return 0;

    mysql_fquery(g_SQL, "DELETE FROM biznis_furniture WHERE sqlid = '%d'", BizzInfo[biznisid][bFurSQL][index]);
    DestroyDynamicObject(BizzInfo[biznisid][bFurObjectid][index]);

    // TODO: helper function, this is repeated more than once
    BizzInfo[biznisid][bFurObjectid][index] = INVALID_OBJECT_ID;
    BizzInfo[biznisid][bFurSQL][index]        = -1;
    BizzInfo[biznisid][bFurModelid][index]    = 0;
    BizzInfo[biznisid][bFurPosX][index]       = 0.0;
    BizzInfo[biznisid][bFurPosY][index]       = 0.0;
    BizzInfo[biznisid][bFurPosZ][index]       = 0.0;
    BizzInfo[biznisid][bFurRotX][index]       = 0.0;
    BizzInfo[biznisid][bFurRotY][index]       = 0.0;
    BizzInfo[biznisid][bFurRotZ][index]       = 0.0;
    // TODO: helper function, this is repeated more than once
    for (new i = 0; i < MAX_COLOR_TEXT_SLOTS; i++)
    {
        BizzInfo[biznisid][bFurTxtId][index][i] = 0;
        BizzInfo[biznisid][bFurColId][index][i] = -1;
    }
    BizzInfo[biznisid][bFurSlots]--;
    Iter_Remove(BizzFurniture[biznisid], index);

    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste obrisali objekt[Model ID: %d - Slot Index: %d].", BizzInfo[biznisid][bFurObjectid][index], index);
    return 1;
}

static stock DestroyAllFurnitureObjects(playerid, biznisid)
{
    foreach(new index: BizzFurniture[biznisid])
    {
        if (BizzInfo[biznisid][bFurSQL][index])
        {
            if (IsValidDynamicObject(BizzInfo[biznisid][bFurObjectid][index]))
            {
                DestroyDynamicObject(BizzInfo[biznisid][bFurObjectid][index]);
                BizzInfo[biznisid][bFurObjectid][index] = INVALID_OBJECT_ID;
            }
            // TODO: helper function, this is repeated more than once
            BizzInfo[biznisid][bFurSQL][index]        = 0;
            BizzInfo[biznisid][bFurModelid][index]    = 0;
            BizzInfo[biznisid][bFurPosX][index]       = 0.0;
            BizzInfo[biznisid][bFurPosY][index]       = 0.0;
            BizzInfo[biznisid][bFurPosZ][index]       = 0.0;
            BizzInfo[biznisid][bFurRotX][index]       = 0.0;
            BizzInfo[biznisid][bFurRotY][index]       = 0.0;
            BizzInfo[biznisid][bFurRotZ][index]       = 0.0;
            // TODO: helper function, this is repeated more than once
            for (new i = 0; i < MAX_COLOR_TEXT_SLOTS; i++)
            {
                BizzInfo[biznisid][bFurTxtId][index][i] = 0;
                BizzInfo[biznisid][bFurColId][index][i] = -1;
            }
        }
    }
    BizzInfo[biznisid][bFurSlots] = GetPlayerBizzFurSlots(playerid);

    mysql_pquery(g_SQL, "BEGIN");
    mysql_fquery_ex(g_SQL, "DELETE FROM biznis_furniture WHERE biznisid = '%d'", BizzInfo[biznisid][bSQLID]);
    mysql_pquery(g_SQL, "COMMIT");

    mysql_fquery(g_SQL, "UPDATE bizzes SET fur_slots = '%d' WHERE id = '%d'", 
        BizzInfo[biznisid][bFurSlots], 
        BizzInfo[biznisid][bSQLID]
    );

    Iter_Clear(BizzFurniture[biznisid]);
    return 1;
}

RotateBizzFurDoor(biznisid, playerid)
{
    foreach(new i: BizzFurniture[biznisid])
    {
        if (BizzInfo[biznisid][bFurDoor][i])
        {
            if (IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[biznisid][bFurPosX][i], BizzInfo[biznisid][bFurPosY][i], BizzInfo[biznisid][bFurPosZ][i] ))
            {
                SetFurnitureDoorRotation(biznisid, i);
                return 1;
            }
        }
    }
    return 1;
}

// TODO: rename this function to something more meaningful, make it return a bool
static stock CanDoorOpen(modelid)
{
    switch (modelid)
    {
        case 3093,3089,2959,2970,2924,2949,2948,2911,977,1495,1496,1497,1498,1501,1506,1535,1536,1555,1556,1566,1567,1569,13360: return 1;
        default: return 0;
    }
    return 0;
}

static stock SetFurnitureDoorRotation(biznisid, index)
{
    // TODO: bounds checking for all input variables
    if (CanDoorOpen(BizzInfo[biznisid][bFurModelid][index]))
    {
        if ((-90.0 <= BizzInfo[biznisid][bFurDoorZ][index] <= 90.0) && BizzInfo[biznisid][bFurDoorZ][index] != -1.0)
        { //Vrata zatvorena
            new Float:rot;
            switch (BizzInfo[biznisid][bFurModelid][index])
            {
                // TODO: repetitive code, use "CanDoorOpen"
                case 3089,2924,2911,977,1492,1493,1495,1496,1497,1498,1501,1569,1506,1536,1555,1556,1566,1567,13360: rot = -90.0; //-90.0
                default: rot = 90.0;
            }

            SetDynamicObjectRot(BizzInfo[biznisid][bFurObjectid][index],
                BizzInfo[biznisid][bFurRotX][index],
                BizzInfo[biznisid][bFurRotY][index],
                rot
            );

            BizzInfo[biznisid][bFurDoorZ][index]  = -1.0;
            return 1;
        }

        SetDynamicObjectRot(BizzInfo[biznisid][ bFurObjectid][index],
            BizzInfo[biznisid][bFurRotX][index],
            BizzInfo[biznisid][bFurRotY][index],
            BizzInfo[biznisid][bFurRotZ][index]
        );
        BizzInfo[biznisid][bFurDoorZ][index]  = BizzInfo[biznisid][bFurRotZ][index];
    }
    return 1;
}

stock ReloadBizzFurniture(biznisid)
{
    foreach(new index: BizzFurniture[biznisid])
    {
        if (BizzInfo[biznisid][bFurSQL][index])
        {
            if (IsValidDynamicObject(BizzInfo[biznisid][bFurObjectid][index]))
            {
                DestroyDynamicObject(BizzInfo[biznisid][bFurObjectid][index]);
                BizzInfo[biznisid][bFurObjectid][index] = INVALID_OBJECT_ID;
            }
            // TODO: I've seen similiar code to this in a few places now.
            // Reduce code duplication by extracting to a helper function
            BizzInfo[biznisid][bFurSQL][index]        = 0;
            BizzInfo[biznisid][bFurModelid][index]    = 0;
            BizzInfo[biznisid][bFurPosX][index]       = 0.0;
            BizzInfo[biznisid][bFurPosY][index]       = 0.0;
            BizzInfo[biznisid][bFurPosZ][index]       = 0.0;
            BizzInfo[biznisid][bFurRotX][index]       = 0.0;
            BizzInfo[biznisid][bFurRotY][index]       = 0.0;
            BizzInfo[biznisid][bFurRotZ][index]       = 0.0;

            for (new i = 0; i < MAX_COLOR_TEXT_SLOTS; i++)
            {
                BizzInfo[biznisid][bFurTxtId][index][i] = 0;
                BizzInfo[biznisid][bFurColId][index][i] = -1;
            }
        }
    }
    LoadBiznisFurnitureObjects(biznisid);
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

hook function ResetIterators()
{
    for(new i = 0; i < MAX_BIZZES; i++)
    {
        Iter_Clear(BizzFurniture[i]);
    }
    return continue();
}

hook OnGameModeInit()
{
    // Interiori
    new bizfurobjid;
    bizfurobjid = CreateObject(1508, 1474.712158, -566.563720, 1082.593750, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 8391, "ballys01", "vgncorpdoor1_512", 0x00000000);
    CreateObject(18056, 1407.699951, -574.478332, 1086.713500, 0.000000, 0.000000, 0.000000);
    CreateObject(18020, 1452.446411, -568.421752, 1084.906372, 0.000000, 0.000000, 0.000000);
    CreateObject(18022, 1484.095825, -561.991455, 1082.896240, 0.000000, 0.000000, 0.000000);
    CreateObject(18023, 1524.420043, -564.278442, 1080.942871, 0.000000, 0.000000, 0.000000);
    CreateObject(18021, 1556.609863, -565.752746, 1078.805541, 0.000000, 0.000000, 0.000000);
    CreateObject(1532, 1443.733520, -577.696411, 1082.908447, 0.000000, 0.000000, 135.000000);
    CreateObject(2515, 1451.604248, -564.456176, 1083.943481, 0.000000, 0.000000, 180.000000);
    CreateObject(2515, 1449.945190, -564.456176, 1083.943481, 0.000000, 0.000000, 180.000000);
    CreateObject(2515, 1448.286254, -564.456176, 1083.943481, 0.000000, 0.000000, 180.000000);
    CreateObject(2515, 1446.548217, -564.456176, 1083.943481, 0.000000, 0.000000, 180.000000);
    CreateObject(2521, 1447.459350, -558.916625, 1082.899902, 0.000000, 0.000000, 0.000000);
    CreateObject(2521, 1451.533447, -558.916625, 1082.899902, 0.000000, 0.000000, 0.000000);
    CreateObject(19466, 1447.466552, -564.912719, 1085.535888, 0.000000, 0.000000, 90.000000);
    CreateObject(19466, 1450.866577, -564.912719, 1085.535888, 0.000000, 0.000000, 90.000000);
    CreateObject(2644, 1483.677734, -565.955810, 1081.353271, 0.000000, 0.000000, 0.000000);
    CreateObject(2644, 1486.127685, -565.955810, 1081.353271, 0.000000, 0.000000, 0.000000);
    CreateObject(2644, 1489.067749, -565.955810, 1081.353271, 0.000000, 0.000000, 0.000000);
    CreateObject(2644, 1491.762695, -565.955810, 1081.353271, 0.000000, 0.000000, 0.000000);
    CreateObject(2644, 1480.982666, -565.955810, 1081.353271, 0.000000, 0.000000, 0.000000);
    CreateObject(1532, 1522.346557, -574.992187, 1078.819946, 0.000000, 0.000000, 0.000000);
    CreateObject(1532, 1555.540039, -573.283569, 1076.674682, 0.000000, 0.000000, 0.000000);

    bizfurobjid = CreateObject(1508, 1401.573120, -600.114807, 1085.758666, 0.000000, 0.000000, 90.000022);
    SetObjectMaterial(bizfurobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    bizfurobjid = CreateObject(19379, 1388.371704, -620.458618, 1084.210327, 0.000000, 89.999969, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14832, "lee_stripclub", "Strip_ceiling", 0x00000000);
    bizfurobjid = CreateObject(19387, 1393.535888, -618.613769, 1086.049560, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
    bizfurobjid = CreateObject(19449, 1393.535034, -625.036071, 1086.049438, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
    bizfurobjid = CreateObject(19449, 1388.587768, -624.314697, 1086.049438, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14548, "ab_cargo_int", "ab_planeBoby", 0x00000000);
    bizfurobjid = CreateObject(19449, 1387.640991, -621.658630, 1086.049438, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14548, "ab_cargo_int", "ab_planeBoby", 0x00000000);
    bizfurobjid = CreateObject(19449, 1388.501953, -616.948120, 1086.049438, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14548, "ab_cargo_int", "ab_planeBoby", 0x00000000);
    bizfurobjid = CreateObject(19379, 1388.030273, -620.486816, 1087.258911, 0.000000, 90.000000, 0.059999);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
    bizfurobjid = CreateObject(19929, 1388.043457, -621.943176, 1084.334594, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
    SetObjectMaterial(bizfurobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    bizfurobjid = CreateObject(19929, 1388.044555, -619.081176, 1084.334594, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
    SetObjectMaterial(bizfurobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    bizfurobjid = CreateObject(11707, 1390.057373, -617.107727, 1085.604736, 0.000000, 0.000000, 360.000000);
    SetObjectMaterial(bizfurobjid, 0, 14548, "ab_cargo_int", "ab_planeBoby", 0x00000000);
    bizfurobjid = CreateObject(19437, 1392.463867, -619.879577, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(2024, 1387.205932, -622.279968, 1087.106323, 0.000000, 90.000045, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
    bizfurobjid = CreateObject(19437, 1392.463867, -621.478576, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1390.860839, -619.879577, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1390.857910, -621.478576, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1390.857910, -621.656616, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1392.463867, -621.656616, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1390.857910, -623.321594, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1392.463867, -623.321594, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 4101, "stapl", "sl_laexpowall1", 0x00000000);
    bizfurobjid = CreateObject(19437, 1390.857910, -623.497619, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
    bizfurobjid = CreateObject(19437, 1392.463867, -623.497619, 1085.154541, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
    bizfurobjid = CreateObject(1491, 1390.182006, -621.481201, 1084.366577, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    bizfurobjid = CreateObject(1491, 1390.182006, -623.217224, 1084.366577, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    bizfurobjid = CreateObject(2024, 1387.205932, -619.329528, 1087.096191, 0.000000, 90.000045, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
    bizfurobjid = CreateObject(19437, 1471.652099, -608.945922, 1084.408203, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(1491, 1393.563476, -619.361816, 1084.284545, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    bizfurobjid = CreateObject(19387, 1466.760986, -609.822509, 1084.484375, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14832, "lee_stripclub", "Strip_bar_wall1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1470.116821, -609.821777, 1084.164062, 90.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14832, "lee_stripclub", "Strip_bar_wall1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1469.965209, -602.809082, 1084.164062, 180.000000, 180.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19449, 1466.904785, -609.815795, 1091.032104, 90.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14832, "lee_stripclub", "Strip_bar_wall1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1465.094970, -604.918212, 1084.162109, 180.000000, 180.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19449, 1474.139038, -604.918212, 1084.162109, 180.000000, 180.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1473.253051, -608.945922, 1084.408203, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1470.051269, -608.945922, 1084.408203, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1469.238403, -608.933227, 1084.408203, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19379, 1470.436035, -605.056701, 1082.647949, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14537, "pdomebar", "club_floor2_sfwTEST", 0x00000000);
    bizfurobjid = CreateObject(19379, 1470.439941, -605.056701, 1085.782958, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    bizfurobjid = CreateObject(1491, 1465.979980, -609.807434, 1082.725952, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    bizfurobjid = CreateObject(19449, 1470.116821, -609.645812, 1084.164062, 90.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19387, 1466.762451, -609.645629, 1084.484375, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19449, 1393.525268, -620.214904, 1089.549438, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
    bizfurobjid = CreateObject(19929, 1470.754150, -608.567626, 1082.736083, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    SetObjectMaterial(bizfurobjid, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19929, 1473.615112, -608.567626, 1082.736083, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    SetObjectMaterial(bizfurobjid, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1465.234863, -603.695007, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
    bizfurobjid = CreateObject(19437, 1465.235839, -605.300598, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1471.005126, -608.936523, 1085.302246, 0.000000, 90.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    bizfurobjid = CreateObject(19437, 1474.505126, -608.936523, 1085.302246, 0.000000, 90.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
    bizfurobjid = CreateObject(19437, 1471.042968, -608.197204, 1086.018188, 89.000000, 270.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1474.535034, -608.197204, 1086.018188, 89.000000, 270.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1466.829956, -603.695007, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1466.829956, -605.297973, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(1491, 1465.315551, -605.981079, 1083.045654, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(1491, 1466.848632, -606.038085, 1083.045654, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1468.413940, -605.297973, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1468.413940, -603.692016, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(1491, 1468.472656, -606.038085, 1083.045654, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1469.901977, -605.299377, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1469.901855, -603.693969, 1084.487060, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    bizfurobjid = CreateObject(19437, 1387.943481, -618.586425, 1087.057617, 0.000000, 90.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    bizfurobjid = CreateObject(19437, 1387.943481, -622.085388, 1087.057617, 0.000000, 90.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    bizfurobjid = CreateObject(19437, 1387.943481, -625.585388, 1087.057617, 0.000000, 90.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    bizfurobjid = CreateObject(2024, 1471.179321, -609.366271, 1085.165649, -90.300018, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
    bizfurobjid = CreateObject(19449, 1534.131347, -619.890380, 1082.479003, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1534.131347, -619.890380, 1085.977050, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1537.760498, -618.285522, 1082.479003, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1537.760498, -618.285522, 1085.977050, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1530.623535, -618.285522, 1082.479003, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1530.623535, -618.285522, 1085.978027, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19379, 1535.913818, -618.291198, 1080.713012, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    bizfurobjid = CreateObject(19379, 1535.913818, -618.291198, 1084.772949, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_concFloor", 0x00000000);
    bizfurobjid = CreateObject(19387, 1532.278442, -613.383789, 1082.253051, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10370, "alleys_sfs", "ws_sandstone1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1538.699218, -613.382019, 1082.250976, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10370, "alleys_sfs", "ws_sandstone1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1535.214233, -613.383972, 1085.748046, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 10370, "alleys_sfs", "ws_sandstone1", 0x00000000);
    bizfurobjid = CreateObject(1491, 1531.495849, -613.414184, 1080.486694, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 2589, "ab_ab", "ab_sheetSteel", 0x00000000);
    bizfurobjid = CreateObject(19449, 1538.699218, -613.564025, 1082.250976, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19387, 1532.277221, -613.565124, 1082.253051, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19449, 1535.214233, -613.562988, 1085.748046, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19387, 1576.974121, -606.726196, 1085.522460, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1570.551025, -606.726196, 1085.516357, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
    bizfurobjid = CreateObject(19449, 1571.096679, -601.838195, 1085.516357, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 6404, "beafron1_law2", "compfence7_LAe", 0x00000000);
    bizfurobjid = CreateObject(19449, 1578.546752, -601.838195, 1085.516357, 0.000000, 0.000000, 180.000000);
    SetObjectMaterial(bizfurobjid, 0, 6404, "beafron1_law2", "compfence7_LAe", 0x00000000);
    bizfurobjid = CreateObject(19449, 1575.475585, -602.346374, 1085.516357, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 6404, "beafron1_law2", "compfence7_LAe", 0x00000000);
    bizfurobjid = CreateObject(19379, 1573.505493, -601.815490, 1084.203857, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 3080, "adjumpx", "planks64", 0x00000000);
    bizfurobjid = CreateObject(19379, 1573.505493, -601.815490, 1087.272949, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_concFloor", 0x00000000);
    bizfurobjid = CreateObject(19449, 1620.446289, -614.372924, 1083.850341, 0.000000, 0.000000, 270.000000);
    SetObjectMaterial(bizfurobjid, 0, 14794, "ab_vegasgymmain", "bbar_wall3", 0x00000000);
    bizfurobjid = CreateObject(19387, 1617.304565, -608.790222, 1083.850952, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14652, "ab_trukstpa", "bbar_wall4", 0x00000000);
    bizfurobjid = CreateObject(19449, 1623.726562, -608.789672, 1083.850341, 0.000000, 0.000000, 270.000000);
    SetObjectMaterial(bizfurobjid, 0, 14652, "ab_trukstpa", "bbar_wall4", 0x00000000);
    bizfurobjid = CreateObject(19449, 1620.277343, -613.695678, 1083.850341, 0.000000, 0.000000, 360.000000);
    SetObjectMaterial(bizfurobjid, 0, 14794, "ab_vegasgymmain", "bbar_wall3", 0x00000000);
    bizfurobjid = CreateObject(19449, 1620.548339, -608.789794, 1087.347290, 0.000000, 0.000000, 270.000000);
    SetObjectMaterial(bizfurobjid, 0, 14652, "ab_trukstpa", "bbar_wall4", 0x00000000);
    bizfurobjid = CreateObject(19449, 1615.877075, -613.675781, 1083.850341, 0.000000, 0.000000, 360.000000);
    SetObjectMaterial(bizfurobjid, 0, 14794, "ab_vegasgymmain", "bbar_wall3", 0x00000000);
    bizfurobjid = CreateObject(19449, 1623.726562, -608.931701, 1083.850341, 0.000000, 0.000000, 270.000000);
    SetObjectMaterial(bizfurobjid, 0, 14794, "ab_vegasgymmain", "bbar_wall3", 0x00000000);
    bizfurobjid = CreateObject(19387, 1617.304565, -608.932189, 1083.850952, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14794, "ab_vegasgymmain", "bbar_wall3", 0x00000000);
    bizfurobjid = CreateObject(19379, 1619.635864, -613.846374, 1082.035522, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14786, "ab_sfgymbeams", "gym_floor5", 0x00000000);
    bizfurobjid = CreateObject(19379, 1619.635864, -613.846374, 1085.301513, 0.000000, 90.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 14652, "ab_trukstpa", "bbar_wall1", 0x00000000);
    bizfurobjid = CreateObject(1491, 1576.191284, -606.610473, 1084.181640, 0.000000, 0.000000, 0.000000);
    SetObjectMaterial(bizfurobjid, 0, 2589, "ab_ab", "ab_sheetSteel", 0x00000000);
    bizfurobjid = CreateObject(19387, 1576.974121, -606.568176, 1085.522460, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 6404, "beafron1_law2", "compfence7_LAe", 0x00000000);
    bizfurobjid = CreateObject(19449, 1571.197631, -606.569702, 1085.516357, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 6404, "beafron1_law2", "compfence7_LAe", 0x00000000);
    bizfurobjid = CreateObject(19437, 1536.862670, -619.713623, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19437, 1535.258666, -619.713623, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19437, 1536.862670, -618.255615, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19437, 1535.258666, -618.255615, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(1491, 1534.518920, -618.184082, 1081.275512, 0.000000, 0.000000, -90.000000);
    SetObjectMaterial(bizfurobjid, 0, 2589, "ab_ab", "ab_sheetSteel", 0x00000000);
    bizfurobjid = CreateObject(1491, 1534.518920, -616.650085, 1081.275512, 0.000000, 0.000000, -90.000000);
    SetObjectMaterial(bizfurobjid, 0, 2589, "ab_ab", "ab_sheetSteel", 0x00000000);
    bizfurobjid = CreateObject(19437, 1535.258666, -616.544616, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    bizfurobjid = CreateObject(19437, 1536.862670, -616.544616, 1082.548706, 0.000000, 0.000000, 90.000000);
    SetObjectMaterial(bizfurobjid, 0, 14584, "ab_abbatoir01", "ab_tiles", 0x00000000);
    CreateObject(18018, 1401.726806, -610.220458, 1084.290405, 0.000000, 0.000000, 0.000000);
    CreateObject(14838, 1463.645019, -615.134216, 1084.279296, 0.000000, 0.000000, 0.000000);
    CreateObject(18028, 1525.832031, -613.183471, 1082.704956, 0.000000, 0.000000, 0.000000);
    CreateObject(16150, 1574.872314, -607.798767, 1084.189941, 0.000000, 0.000000, 0.000000);
    CreateObject(14655, 1613.560913, -609.742858, 1084.156005, 0.000000, 0.000000, 0.000000);
    CreateObject(19325, 1417.981933, -610.428344, 1090.157958, 0.000000, 0.000000, 0.000000);
    CreateObject(19144, 1413.095581, -609.559326, 1089.344116, 0.000000, 0.000000, 90.999946);
    CreateObject(19145, 1413.114379, -611.155151, 1089.354614, 0.000000, 0.000000, 91.599952);
    CreateObject(19146, 1413.134277, -612.923278, 1089.350830, 0.000000, 0.000000, 89.799987);
    CreateObject(19147, 1411.491577, -614.362976, 1089.386108, 0.000000, 0.000000, 0.000000);
    CreateObject(19148, 1409.689575, -614.526916, 1089.315429, 0.000000, 0.000000, 0.000000);
    CreateObject(19149, 1407.819335, -614.529907, 1089.290039, 0.000000, 0.000000, 0.000000);
    CreateObject(19144, 1406.191162, -614.523681, 1089.293701, 0.000000, 0.000000, 0.000000);
    CreateObject(19145, 1404.261840, -614.536865, 1089.313598, 0.000000, 0.000000, 0.000000);
    CreateObject(19146, 1402.503540, -614.532043, 1089.332275, 0.000000, 0.000000, 0.000000);
    CreateObject(19387, 1393.355957, -618.613769, 1086.049560, 0.000000, 0.000000, 0.000000);
    CreateObject(19449, 1393.357055, -625.036071, 1086.049438, 0.000000, 0.000000, 0.000000);
    CreateObject(19449, 1393.357055, -620.164123, 1089.549438, 0.000000, 0.000000, 0.000000);
    CreateObject(19146, 1403.615356, -607.223999, 1089.332275, 0.000000, 0.000000, 180.000000);
    CreateObject(19145, 1405.740234, -607.215087, 1089.331542, 0.000000, 0.000000, 180.000000);
    CreateObject(19144, 1407.770996, -607.231811, 1089.333740, 0.000000, 0.000000, 180.000000);
    CreateObject(19149, 1409.715698, -607.215087, 1089.326049, 0.000000, 0.000000, 180.000000);
    CreateObject(19147, 1411.581542, -607.224975, 1089.318115, 0.000000, 0.000000, 180.000000);
    CreateObject(19147, 1413.114257, -607.798095, 1089.331420, 0.000000, 0.000000, 90.000000);
    CreateObject(19147, 1402.260864, -612.720581, 1089.359008, 0.000000, 0.000000, -90.000000);
    CreateObject(19148, 1402.260864, -610.938598, 1089.359008, 0.000000, 0.000000, -90.000000);
    CreateObject(19150, 1402.260864, -609.288574, 1089.359008, 0.000000, 0.000000, -90.000000);
    CreateObject(19128, 1405.292968, -612.929626, 1084.230102, 0.000000, 0.000000, 0.000000);
    CreateObject(19128, 1409.233032, -612.931579, 1084.230102, 0.000000, 0.000000, 0.000000);
    CreateObject(19128, 1405.301025, -608.989624, 1084.230102, 0.000000, 0.000000, 0.000000);
    CreateObject(19128, 1409.233520, -608.990600, 1084.230102, 0.000000, 0.000000, 0.000000);
    CreateObject(2515, 1388.087402, -622.561889, 1085.379150, 0.000000, 0.000000, 90.000000);
    CreateObject(2515, 1388.087402, -620.791870, 1085.379150, 0.000000, 0.000000, 90.000000);
    CreateObject(2515, 1388.087402, -618.844909, 1085.379150, 0.000000, 0.000000, 90.000000);
    CreateObject(2528, 1392.558227, -620.759155, 1084.282958, 0.000000, 0.000000, -90.000000);
    CreateObject(19874, 1387.903442, -622.324584, 1085.386474, 0.000000, 0.000000, 31.000000);
    CreateObject(19874, 1387.934204, -621.018981, 1085.386474, 0.000000, 0.000000, 31.000000);
    CreateObject(19874, 1387.942626, -618.570129, 1085.386474, 0.000000, 0.000000, 31.000000);
    CreateObject(3785, 1391.671752, -619.652893, 1085.933227, 0.000000, 0.000000, 90.000000);
    CreateObject(19449, 1469.965209, -602.809082, 1087.665039, 180.000000, 180.000000, 90.000000);
    CreateObject(19449, 1465.094970, -604.918212, 1087.662109, 180.000000, 180.000000, 180.000000);
    CreateObject(19449, 1474.139038, -604.918212, 1087.662109, 180.000000, 180.000000, 180.000000);
    CreateObject(19362, 1472.449584, -608.946716, 1087.986450, 0.000000, 0.000000, 90.000000);
    CreateObject(19437, 1470.041259, -608.945922, 1087.906250, 0.000000, 0.000000, 90.000000);
    CreateObject(19437, 1469.238403, -608.933227, 1087.908203, 0.000000, 0.000000, 180.000000);
    CreateObject(14835, 1463.790283, -615.069396, 1084.184082, 0.000000, 0.000000, 0.000000);
    CreateObject(19449, 1393.525268, -629.845886, 1089.549438, 0.000000, 0.000000, 0.000000);
    CreateObject(2515, 1472.829711, -608.495788, 1083.776855, 0.000000, 0.000000, 180.000000);
    CreateObject(2515, 1470.437744, -608.495788, 1083.776855, 0.000000, 0.000000, 180.000000);
    CreateObject(19874, 1470.173095, -608.701171, 1083.785156, 0.000000, 0.000000, 135.000000);
    CreateObject(19874, 1472.514038, -608.617492, 1083.785156, 0.000000, 0.000000, 135.000000);
    CreateObject(2528, 1466.025268, -603.465942, 1082.724975, 0.000000, 0.000000, 0.000000);
    CreateObject(2528, 1467.690307, -603.465881, 1082.724975, 0.000000, 0.000000, 0.000000);
    CreateObject(2528, 1469.133300, -603.465881, 1082.724975, 0.000000, 0.000000, 0.000000);
    CreateObject(11707, 1473.969970, -605.658447, 1084.154907, 0.000000, 0.000000, 270.000000);
    CreateObject(2707, 1388.282592, -623.358520, 1086.946044, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1388.282592, -621.618530, 1086.946044, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1388.282592, -619.878479, 1086.946044, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1388.282592, -617.964477, 1086.946044, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1473.162719, -608.582702, 1085.192260, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1471.596679, -608.582702, 1085.202270, 0.000000, 0.000000, 0.000000);
    CreateObject(2707, 1469.856689, -608.582702, 1085.182250, 0.000000, 0.000000, 0.000000);
    CreateObject(1533, 1456.925292, -626.923278, 1082.728149, 0.000000, 0.000000, 180.000000);
    CreateObject(3785, 1470.098632, -604.467529, 1084.790893, 0.000000, 0.000000, 0.000000);
    CreateObject(2523, 1533.989746, -614.144775, 1080.864990, 0.000000, 0.000000, 0.000000);
    CreateObject(2523, 1536.182617, -614.205566, 1080.864990, 0.000000, 0.000000, 0.000000);
    CreateObject(19874, 1536.478881, -613.754333, 1081.799682, 0.000000, 0.000000, 0.000000);
    CreateObject(19874, 1534.687744, -613.674682, 1081.799682, 0.000000, 0.000000, 0.000000);
    CreateObject(1494, 1527.144165, -602.557006, 1080.514282, 0.000000, 0.000000, 0.000000);
    CreateObject(19449, 1620.446289, -614.372924, 1087.350341, 0.000000, 0.000000, 270.000000);
    CreateObject(19449, 1620.277343, -613.695678, 1087.347290, 0.000000, 0.000000, 360.000000);
    CreateObject(19449, 1615.875244, -613.695678, 1087.347290, 0.000000, 0.000000, 360.000000);
    CreateObject(1491, 1616.523193, -608.940490, 1082.089599, 0.000000, 0.000000, 0.000000);
    CreateObject(2525, 1536.936767, -618.949462, 1080.796875, 0.000000, 0.000000, -90.000000);
    CreateObject(2525, 1536.936767, -617.356506, 1080.796875, 0.000000, 0.000000, -90.000000);
    CreateObject(11707, 1537.607177, -615.135620, 1081.693847, 0.000000, 0.000000, -90.000000);
    CreateObject(1494, 1570.910278, -614.059814, 1084.188354, 0.000000, 0.000000, 90.000000);
    CreateObject(2523, 1577.911254, -602.394287, 1084.291748, 0.000000, 0.000000, -90.000000);
    CreateObject(2523, 1577.911254, -603.734313, 1084.291748, 0.000000, 0.000000, -90.000000);
    CreateObject(2523, 1577.911254, -605.078308, 1084.291748, 0.000000, 0.000000, -90.000000);
    CreateObject(2602, 1574.912719, -606.094970, 1084.816162, 0.000000, 0.000000, 180.000000);
    CreateObject(2602, 1573.113647, -606.094970, 1084.816162, 0.000000, 0.000000, 180.000000);
    CreateObject(2524, 1617.245239, -613.606384, 1082.115112, 0.000000, 0.000000, 180.000000);
    CreateObject(2524, 1618.673217, -613.606384, 1082.115112, 0.000000, 0.000000, 180.000000);
    CreateObject(2524, 1620.101196, -613.606384, 1082.115112, 0.000000, 0.000000, 180.000000);
    CreateObject(2602, 1619.828002, -610.121520, 1082.645629, 0.000000, 0.000000, -90.000000);
    CreateObject(2602, 1619.828002, -611.993530, 1082.645629, 0.000000, 0.000000, -90.000000);
    CreateObject(1778, 1615.988891, -609.520385, 1082.123657, 0.000000, 0.000000, 120.000000);
    CreateObject(11707, 1616.056518, -611.679687, 1083.102172, 0.000000, 0.000000, 90.000000);
    CreateObject(1778, 1571.743652, -602.659179, 1084.292236, 0.000000, 0.000000, 18.000000);
    CreateObject(3785, 1575.273437, -602.561706, 1086.501708, 0.000000, 0.000000, -80.000000);
    CreateObject(3785, 1581.815063, -601.103210, 1086.327758, 0.000000, 0.000000, -80.000000);
    CreateObject(3785, 1580.771118, -601.625183, 1086.327758, 0.000000, 0.000000, -80.000000);
    CreateObject(3785, 1572.489379, -602.561706, 1086.501708, 0.000000, 0.000000, -80.000000);
    CreateObject(3785, 1616.070556, -610.698120, 1084.234130, 0.000000, 0.000000, 0.000000);
    CreateObject(1502, 1612.854736, -593.285827, 1082.101806, 0.000000, 0.000000, 0.000000);
    CreateObject(2528, 1392.558227, -622.541198, 1084.282958, 0.000000, 0.000000, -90.000000);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyFurnitureBlankIntTDs(playerid);

    if (BizzEditState[playerid] != -1)
    {
        if (IsValidPlayerObject(playerid, BizzPlayerPrwsObject[playerid]))
        {
            CancelEdit(playerid);
            DestroyPlayerObject(playerid, BizzPlayerPrwsObject[playerid]);
            BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
        }
        BizzEditState[playerid] = -1;
    }

    BizzFurObjectSection[playerid]     = -1;
    BizzFurnObjectsType[playerid]      = -1;
    BizzPlayerPrwsObject[playerid]     = -1;
    BizzPlayerPrwsIndex[playerid]      = -1;
    BizzPlayerPrwsModel[playerid]      = -1;
    BizzPlayerEditIndex[playerid]      = -1;
    BizzPlayerEditObject[playerid]     = -1;
    BizzPlayerEditType[playerid]       = -1;
    BizzPlayerEditTxtIndex[playerid]   = -1;
    BizzPlayerEditTxtSlot[playerid]    = -1;
    PlayerEditingBiznis[playerid]      = INVALID_BIZNIS_ID;
    BizzPlayerEditClsIndex[playerid]   = -1;
    LastBizzTextureListIndex[playerid] = 1;
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_BIZZ_BLANK_INTS_LIST:
        {
            if (!response) return 1;

            if (!SetPlayerInteriorPreview(playerid, listitem)) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nekakva se pogreska dogodila, ponovno kucajte /bint test!");
            return 1;
        }
        case DIALOG_BIZZ_FURN_MENU:
        {
            if (!response) return 1;

            new
                biznisid = GetPlayerFurnitureBiznis(playerid);
            if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne posjedujete biznis ili ju ne uredjujete!");

            switch (listitem)
            {
                case 0:
                { // Kupi
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_BUY, DIALOG_STYLE_LIST, "Furniture - Kategorije", "Nocni klub/bar\n24/7\nRestoran\nClothing Shop\nOstalo\n", "Choose", "Abort");
                }
                case 1:
                { // Uredi
                    foreach(new i: BizzFurniture[biznisid])
                    {
                        Player_ModelToIndexSet(playerid, i, BizzInfo[biznisid][bFurModelid][i]);
                        fselection_add_item(playerid, BizzInfo[biznisid][bFurModelid][i]);
                    }
                    fselection_show(playerid, DIALOG_BIZZ_FURN_EDIT, "Furniture Edit");
                }
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_BUY:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");
            // TODO: I would extract this to a helper function and set BizzFurnObjectsType[playerid] = listitem + 1;
            switch (listitem)
            {
                case 0:
                { // Nocni klub/bar
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Bars & Clubs", "Kauci\nFotelje\nStolovi\nOrmarici\nTelevizori\nHi-Fi\nZvucnici\nTepisi\nSvijetla\nVrata\nFrizideri\nPica\nFun\n", "Choose", "Abort");
                    BizzFurnObjectsType[playerid] = 1;
                }
                case 1:
                { // 24/7
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - 24/7", "Frizideri\nPica\nHrana\nBlagajna\nSvjetla\nKatne\nOstalo", "Choose", "Abort");
                    BizzFurnObjectsType[playerid] = 2;
                }
                case 2:
                { // Restoran
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Restoran", "Stolovi\nKauci\nFotelje\nFrizideri\nPica\nHrana\nBlagajna\nPosudje\nMirkovalna\nPeci\nKuhinjski elementi\nSudoper", "Choose", "Abort");
                    BizzFurnObjectsType[playerid] = 3;
                }
                case 3:
                { // Clothing
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Clothing", "Police\nBlagajna\nOdjeca", "Choose", "Abort");
                    BizzFurnObjectsType[playerid] = 4;
                }
                case 4:
                { // Ostalo
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Ostalo", "Skladiste\nParticles\nZidovi\nSigurnost", "Choose", "Abort");
                    BizzFurnObjectsType[playerid] = 5;
                }
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_OBJCS:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_BUY, DIALOG_STYLE_LIST, "Furniture - Kategorije", "Nocni klub/bar\n24/7\nRestoran\nClothing Shop\nOstalo\n", "Choose", "Abort");

            switch (BizzFurnObjectsType[playerid])
            {
                case 1: // Bars & Clubs
                {
                    switch (listitem)
                    {
                        case 0:
                        {
                            for (new i = 0; i < sizeof(ObjectsCouch); i++)
                            {
                                if (ObjectsCouch[i][ceId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCouch[i][ceId]);
                                    fselection_add_item(playerid, ObjectsCouch[i][ceId]);
                                }
                            }
                        }
                        case 1:
                        { // Fotelje
                            for (new i = 0; i < sizeof(ObjectsArmChair); i++)
                            {
                                if (ObjectsArmChair[i][armId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsArmChair[i][armId]);
                                    fselection_add_item(playerid, ObjectsArmChair[i][armId]);
                                }
                            }
                        }
                        case 2:
                        { // Stolovi
                            for (new i = 0; i < sizeof(ObjectsTables); i++)
                            {
                                if (ObjectsTables[i][tablId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsTables[i][tablId]);
                                    fselection_add_item(playerid, ObjectsTables[i][tablId]);
                                }
                            }
                        }
                        case 3:
                        { // Ormarici
                            for (new i = 0; i < sizeof(ObjectsCabinets); i++)
                            {
                                if (ObjectsCabinets[i][cabId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCabinets[i][cabId]);
                                    fselection_add_item(playerid, ObjectsCabinets[i][cabId]);
                                }
                            }
                        }
                        case 4:
                        { // Televizori
                            for (new i = 0; i < sizeof(ObjectsTelevision); i++)
                            {
                                if (ObjectsTelevision[i][tvId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsTelevision[i][tvId]);
                                    fselection_add_item(playerid, ObjectsTelevision[i][tvId]);
                                }
                            }
                        }
                        case 5:
                        { // Hi-Fi
                            for (new i = 0; i < sizeof(ObjectsHiFi); i++)
                            {
                                if (ObjectsHiFi[i][hfId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsHiFi[i][hfId]);
                                    fselection_add_item(playerid, ObjectsHiFi[i][hfId]);
                                }
                            }
                        }
                        case 6:
                        { // Zvucnici
                            for (new i = 0; i < sizeof(ObjectsStereo); i++)
                            {
                                if (ObjectsStereo[i][stId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsStereo[i][stId]);
                                    fselection_add_item(playerid, ObjectsStereo[i][stId]);
                                }
                            }
                        }
                        case 7:
                        { // Tepisi
                            for (new i = 0; i < sizeof(ObjectsRugs); i++)
                            {
                                if (ObjectsRugs[i][rId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsRugs[i][rId]);
                                    fselection_add_item(playerid, ObjectsRugs[i][rId]);
                                }
                            }
                        }
                        case 8:
                        { // Svijetla
                            for (new i = 0; i < sizeof(ObjectsLights); i++)
                            {
                                if (ObjectsLights[i][lgtId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsLights[i][lgtId]);
                                    fselection_add_item(playerid, ObjectsLights[i][lgtId]);
                                }
                            }
                        }
                        case 9:
                        { // Vrata
                            for (new i = 0; i < sizeof(ObjectsDoor); i++)
                            {
                                if (ObjectsDoor[i][doorId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsDoor[i][doorId]);
                                    fselection_add_item(playerid, ObjectsDoor[i][doorId]);
                                }
                            }
                        }
                        case 10:
                        { // Hladnjace
                            for (new i = 0; i < sizeof(ObjectsRefrigerators); i++)
                            {
                                if (ObjectsRefrigerators[i][refId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsRefrigerators[i][refId]);
                                    fselection_add_item(playerid, ObjectsRefrigerators[i][refId]);
                                }
                            }
                        }
                        case 11:
                        { // Pica
                            for (new i = 0; i < sizeof(ObjectsBarDrinks); i++)
                            {
                                if (ObjectsBarDrinks[i][bardId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsBarDrinks[i][bardId]);
                                    fselection_add_item(playerid, ObjectsBarDrinks[i][bardId]);
                                }
                            }
                        }
                        case 12:
                        { // Fun
                            for (new i = 0; i < sizeof(ObjectsFun); i++)
                            {
                                if (ObjectsFun[i][fnId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsFun[i][fnId]);
                                    fselection_add_item(playerid, ObjectsFun[i][fnId]);
                                }
                            }
                        }
                    }
                    BizzFurObjectSection[playerid] = listitem;
                }
                case 2:     // 24/7
                {
                    switch (listitem)
                    {
                        case 0:
                        { // Frizider
                            for (new i = 0; i < sizeof(Objects247Fridge); i++)
                            {
                                if (Objects247Fridge[i][sfrId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, Objects247Fridge[i][sfrId]);
                                    fselection_add_item(playerid, Objects247Fridge[i][sfrId]);
                                }
                            }
                        }
                        case 1:
                        { // Pica
                            for (new i = 0; i < sizeof(ObjectsDrinks); i++)
                            {
                                if (ObjectsDrinks[i][drnksId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsDrinks[i][drnksId]);
                                    fselection_add_item(playerid, ObjectsDrinks[i][drnksId]);
                                }
                            }
                        }
                        case 2:
                        { // Hrana
                            for (new i = 0; i < sizeof(ObjectsFood); i++)
                            {
                                if (ObjectsFood[i][foodId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsFood[i][foodId]);
                                    fselection_add_item(playerid, ObjectsFood[i][foodId]);
                                }
                            }
                        }
                        case 3:
                        { // Blagajna
                            for (new i = 0; i < sizeof(ObjectsCashRegister); i++)
                            {
                                if (ObjectsCashRegister[i][crId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCashRegister[i][crId]);
                                    fselection_add_item(playerid, ObjectsCashRegister[i][crId]);
                                }
                            }
                        }
                        case 4:
                        { // Svijetla
                            for (new i = 0; i < sizeof(ObjectsLights); i++)
                            {
                                if (ObjectsLights[i][lgtId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsLights[i][lgtId]);
                                    fselection_add_item(playerid, ObjectsLights[i][lgtId]);
                                }
                            }
                        }
                        case 5:
                        { // Kante
                            for (new i = 0; i < sizeof(ObjectsTrashCan); i++)
                            {
                                if (ObjectsTrashCan[i][tcId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsTrashCan[i][tcId]);
                                    fselection_add_item(playerid, ObjectsTrashCan[i][tcId]);
                                }
                            }
                        }
                        case 6:
                        { // Ostalo
                            for (new i = 0; i < sizeof(Objects247Misc); i++)
                            {
                                if (Objects247Misc[i][smiscId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, Objects247Misc[i][smiscId]);
                                    fselection_add_item(playerid, Objects247Misc[i][smiscId]);
                                }
                            }
                        }
                    }
                    BizzFurObjectSection[playerid] = listitem;
                }
                case 3:     // Restoran
                {
                    switch (listitem)
                    {
                        case 0:
                        { // Stolovi
                            for (new i = 0; i < sizeof(ObjectsTables); i++)
                            {
                                if (ObjectsTables[i][tablId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsTables[i][tablId]);
                                    fselection_add_item(playerid, ObjectsTables[i][tablId]);
                                }
                            }
                        }
                        case 1:
                        { // Kauci
                            for (new i = 0; i < sizeof(ObjectsCouch); i++)
                            {
                                if (ObjectsCouch[i][ceId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCouch[i][ceId]);
                                    fselection_add_item(playerid, ObjectsCouch[i][ceId]);
                                }
                            }
                        }
                        case 2:
                        { // Fotelje
                            for (new i = 0; i < sizeof(ObjectsArmChair); i++)
                            {
                                if (ObjectsArmChair[i][armId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsArmChair[i][armId]);
                                    fselection_add_item(playerid, ObjectsArmChair[i][armId]);
                                }
                            }
                        }
                        case 3:
                        { // Frizider
                            for (new i = 0; i < sizeof(ObjectsRefrigerators); i++)
                            {
                                if (ObjectsRefrigerators[i][refId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsRefrigerators[i][refId]);
                                    fselection_add_item(playerid, ObjectsRefrigerators[i][refId]);
                                }
                            }
                        }
                        case 4:
                        { // Pica
                            for (new i = 0; i < sizeof(ObjectsDrinks); i++)
                            {
                                if (ObjectsDrinks[i][drnksId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsDrinks[i][drnksId]);
                                    fselection_add_item(playerid, ObjectsDrinks[i][drnksId]);
                                }
                            }
                        }
                        case 5:
                        { // Hrana
                            for (new i = 0; i < sizeof(ObjectsFood); i++)
                            {
                                if (ObjectsFood[i][foodId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsFood[i][foodId]);
                                    fselection_add_item(playerid, ObjectsFood[i][foodId]);
                                }
                            }
                        }
                        case 6:
                        { // Kasa
                            for (new i = 0; i < sizeof(ObjectsCashRegister); i++)
                            {
                                if (ObjectsCashRegister[i][crId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCashRegister[i][crId]);
                                    fselection_add_item(playerid, ObjectsCashRegister[i][crId]);
                                }
                            }
                        }
                        case 7:
                        { // Posudje
                            for (new i = 0; i < sizeof(ObjectsKitchenDishes); i++)
                            {
                                if (ObjectsKitchenDishes[i][dishId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsKitchenDishes[i][dishId]);
                                    fselection_add_item(playerid, ObjectsKitchenDishes[i][dishId]);
                                }
                            }
                        }
                        case 8:
                        { // Mikrovalna
                            for (new i = 0; i < sizeof(ObjectsMicroWave); i++)
                            {
                                if (ObjectsMicroWave[i][mwId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsMicroWave[i][mwId]);
                                    fselection_add_item(playerid, ObjectsMicroWave[i][mwId]);
                                }
                            }
                        }
                        case 9:
                        { // Peci
                            for (new i = 0; i < sizeof(ObjectsStove); i++)
                            {
                                if (ObjectsStove[i][stId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsStove[i][stId]);
                                    fselection_add_item(playerid, ObjectsStove[i][stId]);
                                }
                            }
                        }
                        case 10:
                        { // Elementi
                            for (new i = 0; i < sizeof(ObjectsKitchenCabinets); i++)
                            {
                                if (ObjectsKitchenCabinets[i][kcId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsKitchenCabinets[i][kcId]);
                                    fselection_add_item(playerid, ObjectsKitchenCabinets[i][kcId]);
                                }
                            }
                        }
                        case 11:
                        { // Sudoper
                            for (new i = 0; i < sizeof(ObjectsSink); i++)
                            {
                                if (ObjectsSink[i][snkId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsSink[i][snkId]);
                                    fselection_add_item(playerid, ObjectsSink[i][snkId]);
                                }
                            }
                        }
                    }
                    BizzFurObjectSection[playerid] = listitem;
                }
                case 4: // Clothing
                {
                    switch (listitem)
                    {
                        case 0:
                        {
                            for (new i = 0; i < sizeof(ObjectsShelfs); i++)
                            {
                                if (ObjectsShelfs[i][shelfId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsShelfs[i][shelfId]);
                                    fselection_add_item(playerid, ObjectsShelfs[i][shelfId]);
                                }
                            }
                        }
                        case 1:
                        {
                            for (new i = 0; i < sizeof(ObjectsCashRegister); i++)
                            {
                                if (ObjectsCashRegister[i][crId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsCashRegister[i][crId]);
                                    fselection_add_item(playerid, ObjectsCashRegister[i][crId]);
                                }
                            }
                        }
                        case 2:
                        {
                            for (new i = 0; i < sizeof(ObjectsClothes); i++)
                            {
                                if (ObjectsClothes[i][cloId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsClothes[i][cloId]);
                                    fselection_add_item(playerid, ObjectsClothes[i][cloId]);
                                }
                            }
                        }

                    }
                    BizzFurObjectSection[playerid] = listitem;
                }
                case 5: // Ostalo
                {
                    switch (listitem)
                    {
                        case 0:
                        {
                            for (new i = 0; i < sizeof(ObjectsWareHouse); i++)
                            {
                                if (ObjectsWareHouse[i][whId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsWareHouse[i][whId]);
                                    fselection_add_item(playerid, ObjectsWareHouse[i][whId]);
                                }
                            }
                        }
                        case 1:
                        {
                            for (new i = 0; i < sizeof(ObjectsParticles); i++)
                            {
                                if (ObjectsParticles[i][partId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsParticles[i][partId]);
                                    fselection_add_item(playerid, ObjectsParticles[i][partId]);
                                }
                            }
                        }
                        case 2:
                        {
                            for (new i = 0; i < sizeof(ObjectsWalls); i++)
                            {
                                if (ObjectsWalls[i][wlId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsWalls[i][wlId]);
                                    fselection_add_item(playerid, ObjectsWalls[i][wlId]);
                                }
                            }
                        }
                        case 3:
                        {
                            for (new i = 0; i < sizeof(ObjectsSecurity); i++)
                            {
                                if (ObjectsSecurity[i][secId] != 0)
                                {
                                    Player_ModelToIndexSet(playerid, i, ObjectsSecurity[i][secId]);
                                    fselection_add_item(playerid, ObjectsSecurity[i][secId]);
                                }
                            }
                        }
                    }
                    BizzFurObjectSection[playerid] = listitem;
                }
            }
            fselection_show(playerid, DIALOG_BIZZ_FURN_BUY, "Furniture - Catalog");
            return 1;
        }
        case DIALOG_BIZZ_FURN_EDIT_LIST:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");

            switch (listitem)
            {
                case 0:
                {   // UI Edit
                    EditFurnitureObject(playerid, BizzPlayerEditIndex[playerid]);
                }
                case 1:
                {   // Texture
                    LastBizzTextureListIndex[playerid] = 1;

                    new
                        motd[64],
                        dialogPos = 0;

                    // TODO: replace this with strcpy
                    texture_buffer[0] = EOS;
                    format(texture_buffer, sizeof(texture_buffer), "Model\tTXD\tIme\n");
                    // TODO: why is this hardcoded and why ObjectTextures indices start from 1?
                    for (new i = 1; i < 16; i++)
                    {
                        format(motd, sizeof(motd), "%d\t%s\t%s\n",
                            ObjectTextures[i][tModel],
                            ObjectTextures[i][tTXDName],
                            ObjectTextures[i][tName]
                        );
                        strcat(texture_buffer, motd, sizeof(texture_buffer));
                        BizzTextureDialogItem[playerid][dialogPos] = i;
                        dialogPos++;
                    }
                    strcat(texture_buffer, "Potrazi teksturu\nDalje");
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", texture_buffer, "Choose", "Abort");
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
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_LIST, DIALOG_STYLE_LIST, "Furniture - Odabir boja", buffer, "Choose", "Abort");
                }
                case 3:
                {   // Kopiraj
                    new
                        biznisid = GetPlayerFurnitureBiznis(playerid),
                        index   = BizzPlayerEditIndex[playerid];

                    if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne posjedujete biznis ili ju ne uredjujete!");
                    if (!CopyFurnitureObject(playerid, index)) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dogodila se pogreska! Ponovno pokusajte kopirati objekt!");
                }
                case 4:
                {   // Obrisi
                    va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_DELETE, DIALOG_STYLE_MSGBOX, "Furniture - Brisanje", "Zelite li obrisati objekt u slotu %d?", "Yes", "No", BizzPlayerEditIndex[playerid]);
                }
                case 5:
                { // Obrisi boju i teksturu
                    ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura (0-4):", "Input", "Abort");
                }
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_DELETE:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            DeleteFurnitureObject(GetPlayerFurnitureBiznis(playerid), BizzPlayerEditIndex[playerid], playerid);
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            // TODO: hardcoding listitems -- love it
            if (listitem == 15) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
            if (listitem == 16 && LastBizzTextureListIndex[playerid] < 40)
            {
                LastBizzTextureListIndex[playerid]++;
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
                return 1;
            }
            if (listitem == 17 && LastBizzTextureListIndex[playerid] > 0)
            {
                if (--LastBizzTextureListIndex[playerid] <= 0)
                    LastBizzTextureListIndex[playerid] = 1;

                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
                return 1;
            }

            BizzPlayerEditTxtIndex[playerid] = GetPlayerTextureItem(playerid, listitem);
            ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti teksturu (0-4)!", "Input", "Abort");
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS_SRCH_1:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");

            switch (listitem)
            {
                case 0: return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_2, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite znak ili djelomican naziv teksture koju trazite (TXDName (MINIMUM 3 ZNAKA)):", "Input", "Abort");
                case 1: return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_3, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite modelid teksture:", "Input", "Abort");
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS_SRCH_2:
        {
            if (!response) return va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            if (strlen(inputtext) < 3)
            {
                SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate unijeti minimalno 3 znaka kao ime TXD-a!");
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_1, DIALOG_STYLE_INPUT, "Furniture - Trazilica", "Unesite znak ili djelomican naziv teksture koju trazite (ime ili ime TXD-a):", "Input", "Abort");
                return 1;
            }
            ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Pronadjene Teksture", ShowSearchedTextureList(playerid, inputtext), "Choose", "Abort");
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS_SRCH_3:
        {
            if (!response) return va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            if (strlen(inputtext) < 4)
            {
                SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate unijeti minimalno 4 znaka kao modelid TXD-a!");
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
                return 1;
            }
            if (!IsNumeric(inputtext))
            {
                SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Unos mora biti numericki!");
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SRCH_1, DIALOG_STYLE_LIST, "Furniture - Pretrazivanje Tekstura", "Preko TXD Namea\nPreko TXD Modelida", "Choose", "Abort");
                return 1;
            }
            ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Pronadjene Teksture", ShowModelSearchedTextureList(playerid, strval(inputtext)), "Choose", "Abort");
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS_SLOT:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");

            new slot = strval(inputtext);
            if (0 <= slot <= 3)
            {
                va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Teksture", "Zelite li staviti odabranu teksturu na objekt u slot %d?", "Yes", "No", slot);
                BizzPlayerEditTxtSlot[playerid] = slot;

                new index = BizzPlayerEditTxtIndex[playerid];
                SetDynamicObjectMaterial(BizzInfo[ GetPlayerFurnitureBiznis(playerid) ][bFurObjectid][ BizzPlayerEditIndex[playerid] ], slot, ObjectTextures[index][tModel], ObjectTextures[index][tTXDName], ObjectTextures[index][tName], 0);

            }
            else
            {
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti teksturu "COL_RED"(0-3)", "Input", "Abort");
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_TXTS_SURE:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_TXTS, DIALOG_STYLE_TABLIST_HEADERS, "Furniture - Teksture", ShowPlayerTextureList(playerid), "Choose", "Abort");
            if (!SetFurnitureObjectTexture(playerid, BizzPlayerEditTxtSlot[playerid], BizzPlayerEditTxtIndex[playerid], BizzPlayerEditIndex[playerid])) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Doslo je do greske. Pokusajte ponovno!");
            return 1;
        }
        case DIALOG_BIZZ_FURN_COL_LIST:
        {
            if (!response) return 1;

            BizzPlayerEditTxtIndex[playerid] = listitem;
            ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Texture Slots", "Unesite slot u koji zelite staviti odabranu boju (0-4)!", "Input", "Abort");
            return 1;
        }
        case DIALOG_BIZZ_FURN_COL_SLOT:
        {
            if (!response)
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
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_LIST, DIALOG_STYLE_LIST, "Furniture - Odabir boja", buffer, "Choose", "Abort");
                return 1;
            }

            new slotid = strval(inputtext);
            if (1 <= slotid <= MAX_COLOR_TEXT_SLOTS)
            {
                va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Boje", "Zelite li staviti odabranu boju u slot %d?", "Yes", "No", slotid);
                BizzPlayerEditTxtSlot[playerid] = slotid - 1;

                new
                    colorid,
                    index = BizzPlayerEditIndex[playerid],
                    biznisid = GetPlayerFurnitureBiznis(playerid);
                // TODO: bounds checking
                sscanf(ColorList[ BizzPlayerEditTxtIndex[playerid] ][clRGB], "h", colorid);
                SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][ BizzPlayerEditIndex[playerid] ], slotid, ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slotid] ][tModel], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slotid] ][tTXDName], ObjectTextures[ BizzInfo[biznisid][bFurTxtId][index][slotid] ][tName], colorid);

            }
            else
            {
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Color Slots", "Unesite slot u koji zelite staviti odabranu boju (1-5)!", "Input", "Abort");
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_COL_SURE:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_COL_SLOT, DIALOG_STYLE_INPUT, "Furniture - Color Slots", "Unesite slot u koji zelite staviti odabranu boju (1-5)!", "Input", "Abort");

            if (!SetFurnitureObjectColor(playerid, BizzPlayerEditTxtSlot[playerid], BizzPlayerEditTxtIndex[playerid], BizzPlayerEditIndex[playerid])) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Doslo je do greske. Pokusajte ponovno!");
            return 1;
        }
        case DIALOG_BIZZ_FURN_SLOT_DELETE:
        {
            if (!response) return  ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");

            new slot = strval(inputtext);
            if (1 <= slot <= MAX_COLOR_TEXT_SLOTS)
            {
                BizzPlayerEditClsIndex[playerid] = slot - 1;
                va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_SLOT_SURE, DIALOG_STYLE_MSGBOX, "Furniture - Brisanje tekstura i boja", "Zelite li obrisati teksture i boje na slotu %d?", "Yes", "No", slot);
            }
            else
            {
                ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura "COL_YELLOW"(0-4)", "Input", "Abort");
            }
            return 1;
        }
        case DIALOG_BIZZ_FURN_SLOT_SURE:
        {
            if (!response) return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_SLOT_DELETE, DIALOG_STYLE_INPUT, "Furniture - Brisanje tekstura i boja", "Unesite slot koji zelite ocistiti od boja i tekstura "COL_YELLOW"(0-4)", "Input", "Abort");

            new
                biznisid = GetPlayerFurnitureBiznis(playerid),
                slot    = BizzPlayerEditClsIndex[playerid];
            // TODO: bounds checking
            BizzInfo[biznisid][bFurTxtId][ BizzPlayerEditIndex[playerid] ][slot] = 0;
            BizzInfo[biznisid][bFurColId][ BizzPlayerEditIndex[playerid] ][slot] = 0;

            mysql_fquery(g_SQL, "UPDATE furniture SET texture_%d = '0', color_%d = '0' WHERE sqlid = '%d'",
                slot + 1,
                slot + 1,
                BizzInfo[biznisid][bFurSQL][slot]
            );

            SetDynamicObjectMaterial(BizzInfo[biznisid][bFurObjectid][ BizzPlayerEditIndex[playerid] ], slot, -1, "none", "none", 0);

            BizzPlayerEditIndex[playerid] = -1;
            BizzPlayerEditClsIndex[playerid] = -1;
            return 1;
        }
        case DIALOG_BIZZ_FURN_BINT_SURE:
        {
            if (!response) return 1;

            new biznisid = PlayerKeys[playerid][pBizzKey];
            if (!BuyBlankInterior(playerid, biznisid)) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dogodila se nekakva pogreska, ponovno kucajte /bint buy!");
            return 1;
        }
    }
    return 0;
}

hook OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    if (!playerobject)
    {
        return 1;
    }
    switch (BizzEditState[playerid])
    {
        case EDIT_STATE_PREVIEW:
        {
            if (response == EDIT_RESPONSE_FINAL)
            {
                CreateBiznisFurnitureObject(playerid, BizzPlayerPrwsModel[playerid], fX, fY, fZ, fRotX, fRotY, fRotZ, (BizzFurObjectSection[playerid] == 10) ? true : false);
            }
            else if (response == EDIT_RESPONSE_CANCEL)
            {
                if (IsValidPlayerObject(playerid, objectid))
                {
                    DestroyPlayerObject(playerid, BizzPlayerPrwsObject[playerid]);
                    BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
                    CancelEdit(playerid);
                }
                BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
                BizzPlayerPrwsIndex [playerid] = -1;
                BizzPlayerPrwsModel [playerid] = 0;
                BizzFurObjectSection[playerid] = 0;
                BizzFurnObjectsType [playerid] = 0;
                BizzEditState[playerid] = -1;
            }
        }
        case EDIT_STATE_EDIT:
        {
            if (BizzPlayerEditObject[playerid] != objectid)
            {
                return 1;
            }

            if (response == EDIT_RESPONSE_FINAL)
            {
                SetFurnitureObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
            }
            else if (response == EDIT_RESPONSE_CANCEL)
            {
                if (IsValidPlayerObject(playerid, objectid))
                {
                    SetFurnitureObjectPos(playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
                    BizzEditState[playerid] = -1;
                }
            }
        }
    }
    return 1;
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    switch (fselectid)
    {
        case DIALOG_BIZZ_FURN_EDIT:
        {
            if (!response)
                return ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_MENU, DIALOG_STYLE_LIST, "Furniture", "Kupi objekt\nUredi", "Choose", "Abort");

            BizzPlayerEditIndex[playerid] = Player_ModelToIndex(playerid, modelid);
            va_ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_EDIT_LIST, DIALOG_STYLE_LIST, "Furniture - Uredjivanje", "Uredjivanje (UI)\nTeksture\nBoje\nKopiraj objekt\nObrisi objekt\nObrisi teksture i boje", "Choose", "Abort");
            ResetModelShuntVar(playerid);
        }
        case DIALOG_BIZZ_FURN_OBJS_BUY:
        {
            new index = Player_ModelToIndex(playerid, modelid);
            new bool:moneycheck = (AC_GetPlayerMoney(playerid) < GetFurnitureObjectPrice(playerid, index));
            if (!response || moneycheck)
            {
                if (moneycheck)
                {
                    va_SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate dovoljno novaca za kupovinu objekta (%d$)!", GetFurnitureObjectPrice(playerid, index));
                }
                switch (BizzFurnObjectsType[playerid])
                {
                    case 1: ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Bars & Clubs", "Kauci\nFotelje\nStolovi\nOrmarici\nTelevizori\nHi-Fi\nZvucnici\nTepisi\nSvijetla\nVrata\nFrizideri\nPica\nFun\n", "Choose", "Abort");
                    case 2: ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - 24/7", "Frizideri\nPica\nHrana\nBlagajna\nSvjetla\nKatne\nOstalo", "Choose", "Abort");
                    case 3: ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Restoran", "Stolovi\nKauci\nFotelje\nFrizideri\nPica\nHrana\nBlagajna\nPosudje\nMirkovalna\nPeci\nKuhinjski elementi\nSudoper", "Choose", "Abort");
                    case 4: ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Clothing", "Police\nBlagajna\nOdjeca", "Choose", "Abort");
                    case 5: ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_OBJCS, DIALOG_STYLE_LIST, "Biznis Furniture - Ostalo", "SkladiSte\nParticles\nZidovi\nSigurnost", "Choose", "Abort");
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
CMD:biznis_bint(playerid, params[])
{
    //if (!PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Niste ovlasteni!");
    if (PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate posjedovati biznis.");

    new param[6];
    if (sscanf(params, "s[6]", param)) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /biznis_bint [test/buy/exit]");
    if (!strcmp(param, "test", true))
    {
        new biznisid = GetPlayerFurnitureBiznis(playerid);
        if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate posjedovati/uredjivati biznis.");
        if (!IsPlayerInRangeOfPoint(playerid, 10000.0, BizzInfo[biznisid][bExitX], BizzInfo[biznisid][bExitY], BizzInfo[biznisid][bExitZ]))
        {
            // TODO: instead of this long range check maybe check if player is in interior, or if his interior matches
            // the business interior ID
            SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate biti unutar biznisa!");
            return 1;
        }

        new buffer[512], row[32];
        // TODO: strcpy
        buffer[0] = EOS;
        strcat(buffer, "Naziv\tCijena\n");
        for (new i = 0; i < sizeof(BlankBiznisInts); i++)
        {
            format(row, sizeof(row), "%s\t%d$\n",
                BlankBiznisInts[i][iName],
                BlankBiznisInts[i][iPrice]
            );
            strcat(buffer, row);
        }
        ShowPlayerDialog(playerid, DIALOG_BIZZ_BLANK_INTS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Blank Interiors", buffer, "Choose", "Abort");
    }
    else if (!strcmp(param, "buy", true))
    {
        if (BizzViewingInterior[playerid] == -1) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate prvo uci i pregledati prazan interijer!");

        ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_BINT_SURE, DIALOG_STYLE_MSGBOX, "Blank Interiors", "Zelite li kupiti prazan interijer?\n"COL_RED"Svi prijasnji objekti ce se obrisati!", "Yes", "No");
    }
    else if (!strcmp(param, "exit", true))
    {
        if (BizzViewingInterior[playerid] == -1) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ne gledate prazne interijere!");
        if (!ExitBlankInteriorPreview(playerid)) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Dogodila se nekakva pogreska, ponovno kucajte /bint exit!");
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
CMD:biznis_furniture(playerid, params[])
{
    new param[8];
    if (sscanf(params, "s[8]", param))
    {
        SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /biznis_furniture [approve/menu]");
        return 1;
    }

    if (!strcmp(param, "menu", true))
    {
        new biznisid = GetPlayerFurnitureBiznis(playerid);
        if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate posjedovati/uredjivati biznis.");

        if (!IsPlayerInRangeOfPoint(playerid, 10000.0, BizzInfo[biznisid][bExitX], BizzInfo[biznisid][bExitY], BizzInfo[biznisid][bExitZ]))
        {
            // TODO: Interior check if bizzes are interiors
            SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate biti unutar biznisa!");
            return 1;
        }

        if (BizzEditState[playerid] != -1)
        {
            if (IsValidPlayerObject(playerid, BizzPlayerPrwsObject[playerid]))
            {
                CancelEdit(playerid);
                DestroyPlayerObject(playerid, BizzPlayerPrwsObject[playerid]);
                BizzPlayerPrwsObject[playerid] = INVALID_OBJECT_ID;
            }
            BizzEditState[playerid] = -1;
        }
        ShowPlayerDialog(playerid, DIALOG_BIZZ_FURN_MENU, DIALOG_STYLE_LIST, "Biznis Furniture - Menu", "Kupi objekt\nUredi", "Choose", "Abort");
    }
    else if (!strcmp(param, "approve", true))
    {
        new biznisid = GetPlayerFurnitureBiznis(playerid);
        if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate posjedovati/uredjivati biznis.");

        if (!IsPlayerInRangeOfPoint(playerid, 10000.0, BizzInfo[biznisid][bExitX], BizzInfo[biznisid][bExitY], BizzInfo[biznisid][bExitZ]))
        {
            // TODO: interior check
            SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Morate biti unutar biznisa!");
            return 1;
        }

        new giveplayerid;
        if (sscanf(params, "s[8]u", param, giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /biznis_furniture approve [dio imena/playerid]");
        if (giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Krivi unos playerida!");
        if (!ProxDetectorS(10.0, playerid, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Taj igrac nije blizu vas!");

        if (PlayerEditingBiznis[giveplayerid] == PlayerKeys[playerid][pBizzKey])
        {
            PlayerEditingBiznis[giveplayerid] = INVALID_BIZNIS_ID;
            va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Skinuli ste %s dopustenje za uredjivanje biznisa!", GetName(giveplayerid, false));
            va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: %s vam je skinio dopustenje za uredjivanje njegove biznisa!", GetName(playerid, false));
            return 1;
        }
        PlayerEditingBiznis[giveplayerid] = PlayerKeys[playerid][pBizzKey];
        va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO]: Dopustili ste %s da vam uredjuje biznis!", GetName(giveplayerid, false));
        va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO]: %s vam je dopustio da mu uredjujete biznis. Kucajte /biznis_furniture menu!", GetName(playerid, false));
    }
    return 1;
}

CMD:reload_bfurniture(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Niste ovlasteni!");

    new biznisid;
    if (sscanf(params, "i", biznisid)) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /reload_furniture [biznisid]");
    if (biznisid == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Krivi biznisid!");

    ReloadBizzFurniture(biznisid);
    SendClientMessage(playerid, COLOR_GREEN, "[INFO]: Svi furniture objekti su reloadani!");
    return 1;
}
