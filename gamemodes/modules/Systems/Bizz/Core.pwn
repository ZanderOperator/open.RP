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

#define MAX_NEAR_BIZZ_RANGE                 (25.0)

#define CP_TYPE_BIZZ_VIP_ENTRANCE           (3)

// Ints
#define MAX_BIZZ_ARTICLES                   (10)
#define MAX_BIZZ_PRODUCTS                   (100)
#define INVALID_PRODUCT_ID                  (0)


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
    Iterator:Business<MAX_BIZZES>;

enum
{
    PRODUCT_WATER = 100,
    PRODUCT_BEER,
    PRODUCT_PEPSI,
    PRODUCT_COLA,
    PRODUCT_WINE,
    PRODUCT_CIGARS,
    PRODUCT_BURGERS,
    PRODUCT_CAKE,
    PRODUCT_HOTDOG,
    PRODUCT_PIZZA,
    PRODUCT_GROCERIES,
    PRODUCT_MASK,
    PRODUCT_FLOWERS,
    PRODUCT_CAMERA,
    PRODUCT_BAT,
    PRODUCT_SPRAY,
    PRODUCT_TOOLKIT,
    PRODUCT_BOOMBOX,
    PRODUCT_PCREDIT,
    PRODUCT_CLOCK,
    PRODUCT_DICE,
    PRODUCT_LIGHTER,
    PRODUCT_ROPE,
    PRODUCT_RADIO
}

enum
{
    // REGULAR
    DRINKS_WATER = 100,
    DRINKS_BEER,
    // BEZ ALKOHOLA
    DRINKS_PEPSI,
    DRINKS_COCA_COLA,
    DRINKS_SPRITE,
    DRINKS_SODA,
    // VODKA
    DRINKS_SVEDKAFLAVORS,
    DRINKS_KETELONE,
    DRINKS_GREYGOOSE,
    DRINKS_BELVEDERE,
    // RUM
    DRINKS_BACARDISILVER,
    DRINKS_CAPTAINMORGAN,
    // VISKI
    DRINKS_JAMESON,
    DRINKS_JACK_DANIELS,
    DRINKS_JOHNNIE_WALKER_BLACK,
    // TEKILA
    DRINKS_DOBEL_TEQUILA,
    DRINKS_AVION,
    DRINKS_PATRON_SILVER,
    // SAMPANJAC
    DRINKS_KORBEL_BRUT,
    DRINKS_VEUVE_CLICQUOT,
    DRINKS_DOM_PERIGNON,
    // KOKTELI
    DRINKS_RASPBERRY_DAIQUIRI,
    DRINKS_MOJITO,
    DRINKS_WILD_LATINA,
    DRINKS_ILLUSION,
    DRINKS_TROPICAL_DELIGHT,
    DRINKS_MIDORI_SPLICE,
    DRINKS_MARGARITA,
    DRINKS_COSMOPOLITAN,
    DRINKS_CHICHI,
    DRINKS_PINA_COLADA,
    DRINKS_KAMIKAZE,
    DRINKS_BLUE_LAGOON,
    DRINKS_VIAGRA,
    DRINKS_BLOOD_MARY
}

enum E_BIZNIS_PRODUCTS_DATA
{
    bpSQLID,
    bpType,
    bpPrice,
    bpAmount
}
static BiznisProducts[MAX_BIZZES][E_BIZNIS_PRODUCTS_DATA][MAX_BIZZ_ARTICLES];

static
    PlayerText:BiznisBcg1  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:BiznisBcg2  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:BizzInfoText[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:BizzInfoTD  [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
    PlayerText:BiznisCMDTD [MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

static
    VeronaSkinRectangle,
    bool:IsDJ[MAX_PLAYERS],
    DJBizzKey[MAX_PLAYERS],
    ArticleSlot[MAX_PLAYERS],
    ArticleIdInput[MAX_PLAYERS],
    PlayerSkinId[MAX_PLAYERS],
    PlayerSkinPrice[MAX_PLAYERS],
    PlayerSkinStore[MAX_PLAYERS],
    FreeBizzID[MAX_PLAYERS],
    InBusiness[MAX_PLAYERS],
    BizzCP[MAX_PLAYERS],
    InfrontBizz[MAX_PLAYERS];

static const BizzTypesNames[MAX_BIZZ_TYPES][20] =
{
    "Other",            // BIZZ_TYPE_OTHER
    "Bar",              // BIZZ_TYPE_BAR
    "Striptiz Klub",    // BIZZ_TYPE_STRIP
    "Restoran",         // BIZZ_TYPE_RESTORAN
    "Burger",           // BIZZ_TYPE_BURGER
    "Stacked Pizza",    // BIZZ_TYPE_PIZZA
    "Cluckin' Bell",    // BIZZ_TYPE_CLUCKIN
    "Donut Shop",       // BIZZ_TYPE_DONUT
    "24/7",             // BIZZ_TYPE_DUCAN - TODO: grocery/supermarket
    "Sex Shop",         // BIZZ_TYPE_SEXSHOP TODO: these can all be one - clothes
    "Binco",            // BIZZ_TYPE_BINCO
    "ZIP",              // BIZZ_TYPE_ZIP
    "Pro Laps",         // BIZZ_TYPE_PROLAPS
    "Suburban",         // BIZZ_TYPE_SUBURBAN - TODO: ^
    "Grad",             // BIZZ_TYPE_BYCITY - TODO: government or similar
    "Rent a veh",       // BIZZ_TYPE_RENTVEH
    "Kasino",           // BIZZ_TYPE_CASINO
    "Ljekarna",         // BIZZ_TYPE_DRUGSTORE
    "Benzinska"         // BIZZ_TYPE_GASSTATION
};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/

bool: Bizz_Exists(bizzid)
{
    return Iter_Contains(Business, bizzid);
}

Player_InBusiness(playerid)
{
    return InBusiness[playerid];
}

Player_SetInBusiness(playerid, v)
{
    InBusiness[playerid] = v;
}

Player_InfrontBizz(playerid)
{
    return InfrontBizz[playerid];
}

Player_SetInfrontBizz(playerid, v)
{
    InfrontBizz[playerid] = v;
}

Player_GetBizzCP(playerid)
{
    return BizzCP[playerid];
}

Player_SetBizzCP(playerid, v)
{
    BizzCP[playerid] = v;
}

stock bool:Player_IsDJ(playerid)
{
    return IsDJ[playerid];
}

stock Player_SetIsDJ(playerid, bool:v)
{
    IsDJ[playerid] = v;
}

stock Player_GetDJBizzKey(playerid)
{
    return DJBizzKey[playerid];
}

stock Player_SetDJBizzKey(playerid, v)
{
    DJBizzKey[playerid] = v;
}
stock GetNearestBizz(playerid, BIZZ_TYPE = -1)
{
	new 
		bizzid = INVALID_BIZNIS_ID,
		slotid = 0,
		Float:bX, Float:bY, Float:bZ,
		close_bizzes[MAX_SUBJECTS_IN_RANGE][E_CLOSEST_SUBJECTS];
	
	foreach(new i : Business)
	{
		if(slotid >= MAX_SUBJECTS_IN_RANGE)
			break;
		
        if(BIZZ_TYPE != -1)
		{
			if(BizzInfo[i][bType] != BIZZ_TYPE)
				continue;
		}
		if(IsPlayerInRangeOfPoint(playerid, MAX_NEAR_BIZZ_RANGE, BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ]))
		{
			close_bizzes[slotid][cDistance] = GetPlayerDistanceFromPoint(playerid, bX, bY, bZ);
			close_bizzes[slotid][cID] = i;
			slotid++;
		}
	}
	SortNearestRangeID(close_bizzes, slotid);
	bizzid = close_bizzes[0][cID];	
	return bizzid;
}

stock IsAt247(playerid)
{
    if(!SafeSpawned[playerid])
    {
        return false;
    }

    new bool:value = false;
    foreach(new bizzid: Business)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bizzid][bExitX], BizzInfo[bizzid][bExitY], BizzInfo[bizzid][bExitZ])
           && GetPlayerInterior(playerid) == BizzInfo[bizzid][bInterior]
           && GetPlayerVirtualWorld(playerid) == BizzInfo[bizzid][bVirtualWorld])
        {
            value = true;
            break;
        }
    }
    return value;
}

stock LoadBizzes()
{
    Iter_Init(Business);
    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM bizzes WHERE 1"), 
        "OnServerBizzesLoad", 
        ""
   );
    return 1;
}

forward OnServerBizzesLoad();
public OnServerBizzesLoad()
{
    new num_rows = cache_num_rows();
    if(!num_rows)
    {
        printf("MySQL Report: No bizes exist to load.");
        return 0;
    }

    for (new b = 0; b < num_rows; b++)
    {
        cache_get_value_name_int  (b,    "id"            , BizzInfo[b][bSQLID]);
        cache_get_value_name_int  (b,    "ownerid"       , BizzInfo[b][bOwnerID]);
        cache_get_value_name      (b,    "message"       , BizzInfo[b][bMessage], 16);
        cache_get_value_name_int  (b,    "canenter"      , BizzInfo[b][bCanEnter]);
        cache_get_value_name_float(b,    "entrancex"     , BizzInfo[b][bEntranceX]);
        cache_get_value_name_float(b,    "entrancey"     , BizzInfo[b][bEntranceY]);
        cache_get_value_name_float(b,    "entrancez"     , BizzInfo[b][bEntranceZ]);
        cache_get_value_name_float(b,    "exitx"         , BizzInfo[b][bExitX]);
        cache_get_value_name_float(b,    "exity"         , BizzInfo[b][bExitY]);
        cache_get_value_name_float(b,    "exitz"         , BizzInfo[b][bExitZ]);
        cache_get_value_name_int  (b,    "levelneeded"   , BizzInfo[b][bLevelNeeded]);
        cache_get_value_name_int  (b,    "buyprice"      , BizzInfo[b][bBuyPrice]);
        cache_get_value_name_int  (b,    "till"          , BizzInfo[b][bTill]);
        cache_get_value_name_int  (b,    "locked"        , BizzInfo[b][bLocked]);
        cache_get_value_name_int  (b,    "interior"      , BizzInfo[b][bInterior]);
        cache_get_value_name_int  (b,    "maxproducts"   , BizzInfo[b][bMaxProducts]);
        cache_get_value_name_int  (b,    "priceprod"     , BizzInfo[b][bPriceProd]);
        cache_get_value_name_int  (b,    "virtualworld"  , BizzInfo[b][bVirtualWorld]);
        cache_get_value_name_int  (b,    "type"          , BizzInfo[b][bType]);
        cache_get_value_name_int  (b,    "entrancecost"  , BizzInfo[b][bEntranceCost]);
        cache_get_value_name_int  (b,    "destroyed"     , BizzInfo[b][bDestroyed]);
        cache_get_value_name_int  (b,    "fur_slots"     , BizzInfo[b][bFurSlots]);
        cache_get_value_name_int  (b,    "gasprice"      , BizzInfo[b][bGasPrice]);

        LoadBiznisProducts(b);
        LoadBiznisVips(b);
        LoadBiznisFurnitureObjects(b);
        CreateBizzEnter(b);

        if(BizzInfo[b][bVipEnter][0] != 0.0 && BizzInfo[b][bVipEnter][1] != 0.0)
            BizzInfo[b][bVipCP] = CreateDynamicCP(BizzInfo[b][bVipEnter][0], BizzInfo[b][bVipEnter][1], BizzInfo[b][bVipEnter][2]-1, 3.0, BizzInfo[b][bVirtualWorld], BizzInfo[b][bInterior], -1, 5.0);

        BizzInfo[b][bEnterPickup] = CreateDynamicPickup(1272, 2, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ], -1, -1, -1, 100.0);
        Iter_Add(Business, b);
    }

    printf("MySQL Report: Businesses Loaded. [%d/%d]!", Iter_Count(Business), MAX_BIZZES);
    return 1;
}

stock LoadBiznisProducts(bizz_id)
{
    if(!Iter_Contains(Business, bizz_id))
        return 0;

    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "SELECT * FROM server_biznis_products WHERE biznis_id = '%d'", BizzInfo[bizz_id][bSQLID]), 
        "OnServerBiznisProductsLoad", 
        "i", 
        bizz_id
   );
    return 1;
}

stock LoadBiznisVips(bizz_id)
{
    if(!Iter_Contains(Business, bizz_id))
        return 1;

    mysql_pquery(g_SQL,
        va_fquery(g_SQL, "SELECT * FROM server_biznis_vips WHERE biznis_id = '%d'", BizzInfo[bizz_id][bSQLID]),
        "OnServerVipsLoad",
        "i",
        bizz_id
   );
    return 1;
}

forward OnServerBiznisProductsLoad(bizz_id);
public OnServerBiznisProductsLoad(bizz_id)
{
    new num_rows = cache_num_rows();
    if(!num_rows)
    {
        return 0;
    }

    for (new i = 0; i < num_rows; i++)
    {
        cache_get_value_name_int(i,    "id"        , BiznisProducts[bizz_id][bpSQLID][i]);
        cache_get_value_name_int(i,    "type"      , BiznisProducts[bizz_id][bpType][i]);
        cache_get_value_name_int(i,    "price"     , BiznisProducts[bizz_id][bpPrice][i]);
        cache_get_value_name_int(i,    "amount"    , BiznisProducts[bizz_id][bpAmount][i]);
    }
    return 1;
}

forward OnServerVipsLoad(bizz_id);
public OnServerVipsLoad(bizz_id)
{
    if(!cache_num_rows())
    {
        return 1;
    }

    cache_get_value_name_int  (0,    "type"    , BizzInfo[bizz_id][bVipType]);
    cache_get_value_name_float(0,    "x"       , BizzInfo[bizz_id][bVipEnter][0]);
    cache_get_value_name_float(0,    "y"       , BizzInfo[bizz_id][bVipEnter][1]);
    cache_get_value_name_float(0,    "z"       , BizzInfo[bizz_id][bVipEnter][2]);
    cache_get_value_name_float(0,    "exit_x"  , BizzInfo[bizz_id][bVipExit][0]);
    cache_get_value_name_float(0,    "exit_y"  , BizzInfo[bizz_id][bVipExit][1]);
    cache_get_value_name_float(0,    "exit_z"  , BizzInfo[bizz_id][bVipExit][2]);
    return 1;
}

// TODO: rename GetBizzType or GetBusinessType
static stock GetBiznisType(type)
{
    if(type >= sizeof(BizzTypesNames))
    {
        return BizzTypesNames[0];
    }

    return BizzTypesNames[type % sizeof(BizzTypesNames)];
}

static stock GetBiznisTypeList()
{
    new string[20];
    new typestring[1028];
    typestring[0] = EOS;

    for (new i = 0; i < MAX_BIZZ_TYPES; i++)
    {
        format(string, sizeof(string), (i == MAX_BIZZ_TYPES-1) ? ("%s") : ("%s\n"), BizzTypesNames[i]);
        strcat(typestring, string, sizeof(typestring));
    }
    return typestring;
}

static stock PrintBizInfo(playerid, bizz)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    SendClientMessage(playerid, COLOR_LIGHTBLUE,"_______________________________________");
    va_SendClientMessage(playerid, COLOR_WHITE, "Naziv biznisa: %s | Vlasnik: %s", BizzInfo[bizz][bMessage], ConvertSQLIDToName(BizzInfo[bizz][bOwnerID]));
    va_SendClientMessage(playerid, COLOR_WHITE, "Novac u Blagajni: %d | Cijena usluge: %d", BizzInfo[bizz][bTill], BizzInfo[bizz][bEntranceCost]);
    va_SendClientMessage(playerid, COLOR_WHITE, "Cijena: %d | Level: %d", BizzInfo[bizz][bBuyPrice],BizzInfo[bizz][bLevelNeeded]);
    va_SendClientMessage(playerid, COLOR_WHITE, "Vrata: %s", (BizzInfo[bizz][bLocked]) ? ("Zakljucano") : ("Otkljucano"));

    // List all the business products
    new bizz_type = BizzInfo[bizz][bType];
    if(bizz_type == BIZZ_TYPE_DUCAN || bizz_type == BIZZ_TYPE_BAR || bizz_type == BIZZ_TYPE_STRIP)
    {
        for (new i = 0; i < MAX_BIZZ_ARTICLES; i++)
        {
            va_SendClientMessage(playerid, COLOR_WHITE, "Artikl #%d: %s [%d/%d]",
                i,
                GetStoreProductName(BiznisProducts[bizz][bpType][i]),
                BiznisProducts[bizz][bpAmount][i],
                BizzInfo[bizz][bMaxProducts]
          );
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_WHITE, "Ovaj biznis nema artikala.");
    }

    va_SendClientMessage(playerid, COLOR_WHITE, "Cijena produkta: %d", BizzInfo[bizz][bPriceProd]);

    // Rename to something like bStatus, not bDestroyed
    switch (BizzInfo[bizz][bDestroyed])
    {
        case 0: SendClientMessage(playerid, COLOR_RED, "Status: Radi normalno");
        case 1: SendClientMessage(playerid, COLOR_RED, "Status: Unisteni izlozi i prozori.");
        case 2: SendClientMessage(playerid, COLOR_RED, "Status: Unisteni izlozi, prozori i cjelokupan interijer.");
        case 3: SendClientMessage(playerid, COLOR_RED, "Status: Totalno unisten!");
    }
    return 1;
}

static stock CreateBizzInfoTD(playerid)
{
    // TODO: boolean flag indicating whether TD have already been destroyed. for extra safety.
    // or just check for INVALID_TEXTDRAW_ID
    DestroyBizzInfoTD(playerid);

    BiznisBcg1[playerid] = CreatePlayerTextDraw(playerid, 639.612121, 116.752761, "usebox");
    PlayerTextDrawLetterSize(playerid,      BiznisBcg1[playerid], 0.000000, 10.236042);
    PlayerTextDrawTextSize(playerid,        BiznisBcg1[playerid], 497.499877, 0.000000);
    PlayerTextDrawAlignment(playerid,       BiznisBcg1[playerid], 1);
    PlayerTextDrawColor(playerid,           BiznisBcg1[playerid], 0);
    PlayerTextDrawUseBox(playerid,          BiznisBcg1[playerid], true);
    PlayerTextDrawBoxColor(playerid,        BiznisBcg1[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       BiznisBcg1[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      BiznisBcg1[playerid], 0);
    PlayerTextDrawFont(playerid,            BiznisBcg1[playerid], 0);
    PlayerTextDrawShow(playerid,            BiznisBcg1[playerid]);

    BiznisBcg2[playerid] = CreatePlayerTextDraw(playerid, 639.575012, 116.860000, "usebox");
    PlayerTextDrawLetterSize(playerid,      BiznisBcg2[playerid], 0.000000, 1.238053);
    PlayerTextDrawTextSize(playerid,        BiznisBcg2[playerid], 497.500000, 0.000000);
    PlayerTextDrawAlignment(playerid,       BiznisBcg2[playerid], 1);
    PlayerTextDrawColor(playerid,           BiznisBcg2[playerid], 0);
    PlayerTextDrawUseBox(playerid,          BiznisBcg2[playerid], true);
    PlayerTextDrawBoxColor(playerid,        BiznisBcg2[playerid], 102);
    PlayerTextDrawSetShadow(playerid,       BiznisBcg2[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      BiznisBcg2[playerid], 0);
    PlayerTextDrawFont(playerid,            BiznisBcg2[playerid], 0);
    PlayerTextDrawShow(playerid,            BiznisBcg2[playerid]);

    BizzInfoText[playerid] = CreatePlayerTextDraw(playerid, 501.850006, 117.488006, "BIZNIS INFO");
    PlayerTextDrawLetterSize(playerid,      BizzInfoText[playerid], 0.336050, 1.023200);
    PlayerTextDrawAlignment(playerid,       BizzInfoText[playerid], 1);
    PlayerTextDrawColor(playerid,           BizzInfoText[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       BizzInfoText[playerid], 0);
    PlayerTextDrawSetOutline(playerid,      BizzInfoText[playerid], 1);
    PlayerTextDrawFont(playerid,            BizzInfoText[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, BizzInfoText[playerid], 51);
    PlayerTextDrawSetProportional(playerid, BizzInfoText[playerid], 1);
    PlayerTextDrawShow(playerid,            BizzInfoText[playerid]);

    BizzInfoTD[playerid] = CreatePlayerTextDraw(playerid, 503.999877, 134.456085, "Vlasnik: Richard Collins~n~Cijena: 10.000~g~$~n~~w~Rent: 10~g~$~n~~w~Level: 16");
    PlayerTextDrawLetterSize(playerid,      BizzInfoTD[playerid], 0.282599, 0.967758);
    PlayerTextDrawAlignment(playerid,       BizzInfoTD[playerid], 1);
    PlayerTextDrawColor(playerid,           BizzInfoTD[playerid], -1);
    PlayerTextDrawSetShadow(playerid,       BizzInfoTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      BizzInfoTD[playerid], 0);
    PlayerTextDrawFont(playerid,            BizzInfoTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, BizzInfoTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, BizzInfoTD[playerid], 1);
    PlayerTextDrawShow(playerid,            BizzInfoTD[playerid]);

    BiznisCMDTD[playerid] = CreatePlayerTextDraw(playerid, 503.550079, 190.175903, "Raspolozive komande:~n~      /enter");
    PlayerTextDrawLetterSize(playerid,      BiznisCMDTD[playerid], 0.240599, 0.879841);
    PlayerTextDrawAlignment(playerid,       BiznisCMDTD[playerid], 1);
    PlayerTextDrawColor(playerid,           BiznisCMDTD[playerid], -5963521);
    PlayerTextDrawSetShadow(playerid,       BiznisCMDTD[playerid], 1);
    PlayerTextDrawSetOutline(playerid,      BiznisCMDTD[playerid], 0);
    PlayerTextDrawFont(playerid,            BiznisCMDTD[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, BiznisCMDTD[playerid], 255);
    PlayerTextDrawSetProportional(playerid, BiznisCMDTD[playerid], 1);
    PlayerTextDrawShow(playerid,            BiznisCMDTD[playerid]);
    return 1;
}

Public:DestroyBizzInfoTD(playerid)
{
    PlayerTextDrawDestroy(playerid, BiznisBcg1[playerid]);
    PlayerTextDrawDestroy(playerid, BiznisBcg2[playerid]);
    PlayerTextDrawDestroy(playerid, BizzInfoText[playerid]);
    PlayerTextDrawDestroy(playerid, BizzInfoTD[playerid]);
    PlayerTextDrawDestroy(playerid, BiznisCMDTD[playerid]);

    BiznisBcg1  [playerid] = PlayerText:INVALID_TEXT_DRAW;
    BiznisBcg2  [playerid] = PlayerText:INVALID_TEXT_DRAW;
    BizzInfoText[playerid] = PlayerText:INVALID_TEXT_DRAW;
    BizzInfoTD  [playerid] = PlayerText:INVALID_TEXT_DRAW;
    BiznisCMDTD [playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}

UpdateBizzFurnitureSlots(playerid)
{
    foreach(new biznisid: Business)
    {
        if(PlayerInfo[playerid][pSQLID] == BizzInfo[biznisid][bOwnerID])
        {
            BizzInfo[biznisid][bFurSlots] = GetPlayerBizzFurSlots(playerid);
            mysql_fquery(g_SQL, "UPDATE bizzes SET fur_slots = '%d' WHERE id = '%d'", 
                BizzInfo[biznisid][bFurSlots], 
                BizzInfo[biznisid][bSQLID]
           );
            return 1;
        }
    }
    return 1;
}

stock BuyBiznis(playerid, bool:credit_activated = false)
{
    new 
        bizz = Player_InfrontBizz(playerid);
    if(!Bizz_Exists(bizz)) 
        return 0;

    PlayerKeys[playerid][pBizzKey] = bizz;
    //BizzInfo[bizz][bTill]        = 0;
    BizzInfo[bizz][bOwnerID]       = PlayerInfo[playerid][pSQLID];
    PlayerPlayTrackSound(playerid);

    // Money
    new price = BizzInfo[bizz][bBuyPrice];
    if(credit_activated)
        price -= CreditInfo[playerid][cAmount];
    PlayerToBudgetMoney(playerid, price);

    mysql_fquery(g_SQL, "UPDATE bizzes SET ownerid = '%d', till = '%d' WHERE id = '%d'",
        PlayerInfo[playerid][pSQLID],
        BizzInfo[bizz][bTill],
        BizzInfo[bizz][bSQLID]
   );

    #if defined MODULE_LOGS
    Log_Write("/logfiles/buy_biznis.txt", "(%s) %s bought business %s[SQLID: %d] for %d$. (%s).",
        ReturnDate(),
        GetName(playerid, false),
        BizzInfo[bizz][bMessage],
        BizzInfo[bizz][bSQLID],
        BizzInfo[bizz][bBuyPrice],
        ReturnPlayerIP(playerid)
   );
    #endif

    SendClientMessage(playerid, COLOR_RED, "[!]  Kupili ste biznis, koristite /help za vise informacija!");
    return 1;
}

stock GetStoreProductName(product)
{
    // TODO: sjebi array
    new
        prodname[22];
    switch (product)
    {
        case PRODUCT_COLA:          format(prodname, 22, "Coca Cola"             );
        case PRODUCT_PEPSI:         format(prodname, 22, "Pepsi"                 );
        case PRODUCT_WINE:          format(prodname, 22, "Vino"                  );
        case PRODUCT_BEER:          format(prodname, 22, "Pivo"                  );
        case PRODUCT_WATER:         format(prodname, 22, "Voda"                  );
        case PRODUCT_CIGARS:        format(prodname, 22, "Cigarete"              );
        case PRODUCT_BURGERS:       format(prodname, 22, "Burgeri"               );
        case PRODUCT_CAKE:          format(prodname, 22, "Torta"                 );
        case PRODUCT_HOTDOG:        format(prodname, 22, "Hot Dog"               );
        case PRODUCT_PIZZA:         format(prodname, 22, "Pizza"                 );
        case PRODUCT_GROCERIES:     format(prodname, 22, "Namirnice"             );
        case PRODUCT_MASK:          format(prodname, 22, "Maska"                 );
        case PRODUCT_FLOWERS:       format(prodname, 22, "Cvijece"               );
        case PRODUCT_CAMERA:        format(prodname, 22, "Fotoaparat"            );
        case PRODUCT_BAT:           format(prodname, 22, "Palica"                );
        case PRODUCT_SPRAY:         format(prodname, 22, "Spray"                 );
        case PRODUCT_TOOLKIT:       format(prodname, 22, "Toolkit"               );
        case PRODUCT_BOOMBOX:       format(prodname, 22, "Kazetofon"             );
        case PRODUCT_PCREDIT:       format(prodname, 22, "Bon za mobitel"        );
        case PRODUCT_CLOCK:         format(prodname, 22, "Sat"                   );
        case PRODUCT_DICE:          format(prodname, 22, "Kocka"                 );
        case PRODUCT_LIGHTER:       format(prodname, 22, "Upaljac"               );
        case PRODUCT_ROPE:          strcat( prodname, "Konop", 22);
        case PRODUCT_RADIO:         strcat( prodname, "Radio", 22);
        default:                    format(prodname, 22, "Nema artikla"          );
    }
    return prodname;
}

stock GetDrinkName(drinkid)
{
    // TODO: sjebi array
    new
        string[33];
    switch (drinkid)
    {
        case DRINKS_WATER:                      format(string, 33, "Voda"                    );
        case DRINKS_BEER:                       format(string, 33, "Pivo"                    );
        case DRINKS_PEPSI:                      format(string, 33, "Pepsi"                   );
        case DRINKS_COCA_COLA:                  format(string, 33, "Coca Cola"               );
        case DRINKS_SPRITE:                     format(string, 33, "Sprite"                  );
        case DRINKS_SODA:                       format(string, 33, "Sok"                     );
        case DRINKS_SVEDKAFLAVORS:              format(string, 33, "Svedka Flavors"          );
        case DRINKS_KETELONE:                   format(string, 33, "Ketel One"               );
        case DRINKS_GREYGOOSE:                  format(string, 33, "Grey Goose"              );
        case DRINKS_BELVEDERE:                  format(string, 33, "Belveredere"             );
        case DRINKS_BACARDISILVER:              format(string, 33, "Bacardi Silver"          );
        case DRINKS_CAPTAINMORGAN:              format(string, 33, "Captain Morgan"          );
        case DRINKS_JAMESON:                    format(string, 33, "Jameson"                 );
        case DRINKS_JACK_DANIELS:               format(string, 33, "Jack Daniels"            );
        case DRINKS_JOHNNIE_WALKER_BLACK:       format(string, 33, "Johnnie Walker Black"    );
        case DRINKS_DOBEL_TEQUILA:              format(string, 33, "Dobel Tequila"           );
        case DRINKS_AVION:                      format(string, 33, "Avion"                   );
        case DRINKS_PATRON_SILVER:              format(string, 33, "Patron Silver"           );
        case DRINKS_KORBEL_BRUT:                format(string, 33, "Korbel Brut"             );
        case DRINKS_VEUVE_CLICQUOT:             format(string, 33, "Veuve Clicquot"          );
        case DRINKS_DOM_PERIGNON:               format(string, 33, "Dom Perignon"            );
        case DRINKS_RASPBERRY_DAIQUIRI:         format(string, 33, "aspberry Daiquiri"       );
        case DRINKS_MOJITO:                     format(string, 33, "Mojito"                  );
        case DRINKS_WILD_LATINA:                format(string, 33, "Wild Latina"             );
        case DRINKS_ILLUSION:                   format(string, 33, "Illusion"                );
        case DRINKS_TROPICAL_DELIGHT:           format(string, 33, "Tropical Delight"        );
        case DRINKS_MIDORI_SPLICE:              format(string, 33, "Midori Splice"           );
        case DRINKS_MARGARITA:                  format(string, 33, "Margarita "              );
        case DRINKS_COSMOPOLITAN:               format(string, 33, "Cosmopolitan"            );
        case DRINKS_CHICHI:                     format(string, 33, "Chi Chi "                );
        case DRINKS_PINA_COLADA:                format(string, 33, "Pina Colada"             );
        case DRINKS_KAMIKAZE:                   format(string, 33, "Kamikaze "               );
        case DRINKS_BLUE_LAGOON:                format(string, 33, "Blue Lagoon"             );
        case DRINKS_VIAGRA:                     format(string, 33, "Viagra "                 );
        case DRINKS_BLOOD_MARY:                 format(string, 33, "Blood Mary"              );
        default: strcpy(string, "Prazno", sizeof(string));
    }
    return string;
}

static stock GetArticleList(bizz)
{
    new buffer[1744];

    new bizz_type = BizzInfo[bizz][bType];
    if(bizz_type == BIZZ_TYPE_DUCAN)
    {
        // TODO: replace hardcoded limits with defines
        for (new x = 100; x <= 121; x++)
        {
            format(buffer, sizeof(buffer), "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")\n",
                buffer,
                GetStoreProductName(x),
                500
          );
        }
    }
    else if(bizz_type == BIZZ_TYPE_BAR || BIZZ_TYPE_STRIP)
    {
        for (new x = 100; x <= 134; x++)
        {
            format(buffer, sizeof(buffer), "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")\n",
                buffer,
                GetDrinkName(x),
                500
          );
        }
    }
    return buffer;
}

static stock IsValidArticle(bizz, article)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    if(article < 0 || article >= MAX_BIZZ_ARTICLES) return 0;

    for (new i = 0; i < MAX_BIZZ_ARTICLES; i++)
    {
        if(BiznisProducts[bizz][bpType][i] == article)
        {
            return 0;
        }
    }
    return 1;
}

static stock RemoveStoreArticle(bizz, article)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    if(article < 0 || article >= MAX_BIZZ_ARTICLES) return 0;

    mysql_fquery(g_SQL, "DELETE FROM server_biznis_products WHERE biznis_id = '%d' AND id = '%d' AND type='%d'",
        BizzInfo[bizz][bSQLID],
        BiznisProducts[bizz][bpSQLID][article],
        BiznisProducts[bizz][bpType][article]
   );

    BiznisProducts[bizz][bpSQLID][article]  = -1;
    BiznisProducts[bizz][bpType][article]   = INVALID_PRODUCT_ID;
    BiznisProducts[bizz][bpPrice][article]  = 0;
    BiznisProducts[bizz][bpAmount][article] = 0;
    return 1;
}

static stock GetEmptyProductSlot(bizz)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    for (new i = 0 ; i < MAX_BIZZ_ARTICLES; i++)
    {
        if(BiznisProducts[bizz][bpType][i] == INVALID_PRODUCT_ID)
        {
            return i;
        }
    }
    return -1;
}

static stock SetStoreProductOnSale(bizz, product, price)
{
    if(!Bizz_Exists(bizz)) 
        return 0;
    if(product == INVALID_PRODUCT_ID || product < 100) return 0;

    new id = GetEmptyProductSlot(bizz);
    if(id == -1) return 0;

    BiznisProducts[bizz][bpType][id]   = product;
    BiznisProducts[bizz][bpPrice][id]  = price;
    BiznisProducts[bizz][bpAmount][id] = 100;

    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, "INSERT INTO server_bizz_products(biznis_id, type, price, amount) \n\
            VALUES ('%d', '%d', '%d', '%d')",
            BizzInfo[bizz][bSQLID],
            BiznisProducts[bizz][bpType][id],
            BiznisProducts[bizz][bpPrice][id],
            BiznisProducts[bizz][bpAmount][id]
       ), 
        "OnBiznisProductInsert", 
        "ii", 
        bizz, 
        id
   );
    return 1;
}

static stock UpdateBizzProduct(bizz, productid)
{
    if(!Iter_Contains(Business, bizz)) 
        return 1;

    mysql_fquery(g_SQL, 
        "UPDATE server_biznis_products SET type = '%d', price = '%d', amount = '%d' WHERE id = '%d'",
        BiznisProducts[bizz][bpType][productid],
        BiznisProducts[bizz][bpPrice][productid],
        BiznisProducts[bizz][bpAmount][productid],
        BiznisProducts[bizz][bpSQLID][productid]
   );
    return 1;
}

Public:OnBiznisProductInsert(bizz, id)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    BiznisProducts[bizz][bpSQLID][id] = cache_insert_id();
    return 1;
}

CheckPlayerBizzInt(playerid, interior, viwo)
{
    foreach(new b: Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, 250.0, BizzInfo[b][bExitX], BizzInfo[b][bExitY], BizzInfo[b][bExitZ]) 
            && BizzInfo[b][bInterior] == interior
            && BizzInfo[b][bVirtualWorld] == viwo)
		{
			Player_SetInBusiness(playerid, b);
			return 1;
		}
	}
    return 1;
}

GetBizzFromSQL(sqlid)
{
    new 
        bizzid = INVALID_BIZNIS_ID;
    foreach(new bizz : Business) 
	{
		if(BizzInfo[bizz][bOwnerID] == sqlid) 
		{
			bizzid = bizz;
			break;
		}
	}
    return bizzid;
}

stock CP_GetBizzID(checkpointid)
{
    new bizzid = INVALID_BIZNIS_ID;
    foreach(new bizz: Business)
    {
        if(BizzInfo[bizz][bEnterCP] == checkpointid)
        {
            bizzid = bizz;
            break;
        }
    }
    return bizzid;
}

static CreateBizzEnter(bizzid)
{
    if(IsValidDynamicCP(BizzInfo[bizzid][bEnterCP]))
        DestroyDynamicCP(BizzInfo[bizzid][bEnterCP]);
    
    BizzInfo[bizzid][bEnterCP] = CreateDynamicCP(BizzInfo[bizzid][bEntranceX], BizzInfo[bizzid][bEntranceY], BizzInfo[bizzid][bEntranceZ]-1.0, 2.0, -1, -1, -1, 5.0);
    return 1;
}

static stock GetStoreProducts(bizz)
{
    new buffer[870];

    if(bizz < 0 || bizz >= MAX_BIZZES)
    {
        return buffer;
    }

    new bizz_type = BizzInfo[bizz][bType];
    if(bizz_type == BIZZ_TYPE_DUCAN || bizz_type == BIZZ_TYPE_BAR || bizz_type == BIZZ_TYPE_STRIP)
    {
        for (new i = 0; i < MAX_BIZZ_ARTICLES; i++)
        {
            if(BiznisProducts[bizz][bpType][i] > INVALID_PRODUCT_ID)
            {
                format(buffer, sizeof(buffer), "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")  "COL_WHITE"[%d/%d]\n",
                    buffer,
                    GetStoreProductName(BiznisProducts[bizz][bpType][i]),
                    BiznisProducts[bizz][bpPrice][i],
                    BiznisProducts[bizz][bpAmount][i],
                    BizzInfo[bizz][bMaxProducts]
              );
            }
            else
            {
                format(buffer, sizeof(buffer), "%s"COL_RED"Prazno\n", buffer);
            }
        }
    }
    return buffer;
}

stock ResetBizzInfo(bizz, bool:server_startup = false)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    BizzInfo[bizz][bOwnerID] = 0;
    BizzInfo[bizz][bMessage][0] = EOS;
    BizzInfo[bizz][bCanEnter] = 0;
    BizzInfo[bizz][bLevelNeeded] = 0;
    BizzInfo[bizz][bEntranceX] = 0.0;
    BizzInfo[bizz][bEntranceY] = 0.0;
    BizzInfo[bizz][bEntranceZ] = 0.0;
    BizzInfo[bizz][bExitX] = 0.0;
    BizzInfo[bizz][bExitY] = 0.0;
    BizzInfo[bizz][bExitZ] = 0.0;
    BizzInfo[bizz][bInterior] = 0;
    BizzInfo[bizz][bVirtualWorld] = 0;
    BizzInfo[bizz][bBuyPrice] = 0;
    if(server_startup)
    {
        if(BizzInfo[bizz][bTill] > 0)
        {
            BusinessToBudgetMoney(bizz, BizzInfo[bizz][bTill]);
        }
    }
    BizzInfo[bizz][bTill] = 0;
    BizzInfo[bizz][bLocked] = 0;
    BizzInfo[bizz][bEntranceCost] = 0;
    BizzInfo[bizz][bDestroyed] = 0;
    BizzInfo[bizz][bFurSlots] = 0;
    BizzInfo[bizz][bGasPrice] = 0;
    if(IsValidDynamicPickup(BizzInfo[bizz][bEnterPickup]))
        DestroyDynamicPickup(BizzInfo[bizz][bEnterPickup]);
    
    if(IsValidDynamicCP(BizzInfo[bizz][bEnterCP]))
        DestroyDynamicCP(BizzInfo[bizz][bEnterCP]);

    return 1;
}

static ResetBizzEnumerator()
{
    for (new i = 0; i < MAX_BIZZES; i++)
        ResetBizzInfo(i, true);

    return 1;
}

stock InsertNewBizz(playerid, bizz)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    mysql_pquery(g_SQL, 
        va_fquery(g_SQL, 
            "INSERT INTO bizzes(id, message, canenter,entrancex, entrancey, entrancez,\n\
            levelneeded, buyprice, type, fur_slots) VALUES (null, '%e','%d','%f','%f','%f','%d','%d','%d','%d')",
            BizzInfo[bizz][bMessage],
            BizzInfo[bizz][bCanEnter],
            BizzInfo[bizz][bEntranceX],
            BizzInfo[bizz][bEntranceY],
            BizzInfo[bizz][bEntranceZ],
            BizzInfo[bizz][bLevelNeeded],
            BizzInfo[bizz][bBuyPrice],
            BizzInfo[bizz][bType],
            BizzInfo[bizz][bFurSlots],
            BizzInfo[bizz][bGasPrice]
       ),
        "OnBizzInsertQuery", 
        "ii", 
        playerid, 
        bizz
   );
    return 1;
}

Public:OnBizzInsertQuery(playerid, bizz)
{
    if(!Bizz_Exists(bizz)) 
        return 0;

    BizzInfo[bizz][bSQLID] = cache_insert_id();

    va_SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste stvorili biznis tipa %s pod nazivom %s[ID: %d | SQLID: %d].",
        GetBiznisType(BizzInfo[bizz][bType]),
        BizzInfo[bizz][bMessage],
        bizz,
        BizzInfo[bizz][bSQLID]
   );
    SendClientMessage(playerid, COLOR_YELLOW, "[!]  Da bi ste postavili interijer biznisu, koristite /bizint | /custombizint.");
    return 1;
}

stock DeleteBiznis(bizz)
{
    if(!Iter_Contains(Business, bizz)) return 1;
    mysql_fquery(g_SQL, "DELETE FROM bizzes WHERE id = '%d'", BizzInfo[bizz][bSQLID]);
    ResetBizzInfo(bizz);
    Iter_Remove(Business, bizz);
    return 1;
}

static stock SetPlayerPosFinish(playerid)
{
    // TODO: better name this function, do bizz bounds checking, remove the switch
    // and make a static array with player positions, ints etc and use that
    new bizz = Player_InBusiness(playerid);

    switch (PlayerSkinStore[playerid])
    {
        case 1: // Zip
        {
            TogglePlayerControllable(playerid, true);
            SetPlayerPos(playerid, 161.4544,-87.6469,1001.8047);
            SetPlayerFacingAngle(playerid, 180.7717);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, BizzInfo[bizz][bVirtualWorld]);
            SetPlayerInterior(playerid, 18);
        }
        case 2: // Binco
        {
            TogglePlayerControllable(playerid, true);
            SetPlayerPos(playerid, 207.5897,-107.3457,1005.1328);
            SetPlayerFacingAngle(playerid, 181.3984);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, BizzInfo[bizz][bVirtualWorld]);
            SetPlayerInterior(playerid, 15);
        }
        case 3: // ProLaps
        {
            TogglePlayerControllable(playerid, true);
            SetPlayerPos(playerid, 206.8714,-135.4684,1002.8744);
            SetPlayerFacingAngle(playerid, 179.5183);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, BizzInfo[bizz][bVirtualWorld]);
            SetPlayerInterior(playerid, 3);
        }
        case 4: // Suburban
        {
            TogglePlayerControllable(playerid, true);
            SetPlayerPos(playerid, 203.8152,-47.4227,1001.8047);
            SetPlayerFacingAngle(playerid, 174.8182);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, BizzInfo[bizz][bVirtualWorld]);
            SetPlayerInterior(playerid, 1);
        }
        case 5: // Mall
        {
            TogglePlayerControllable(playerid, true);
            SetPlayerPos(playerid, 1097.5392, -1442.8313, 15.1654);
            SetPlayerFacingAngle(playerid, 90.0);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld( playerid, 0);
            SetPlayerInterior(playerid, 0);
        }
    }
    return 1;
}

Public:ResetBuySkin(playerid)
{
    SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);

    PlayerSkinId[playerid] = 0;
    PlayerSkinPrice[playerid] = 0;
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
    LoadBizzes();
	return continue();
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    new bizz = CP_GetBizzID(checkpointid);
    if(!Iter_Contains(Business, bizz))
        return 1;

    new string[128];
    CreateBizzInfoTD(playerid);
    if(BizzInfo[bizz][bOwnerID] != 0)
    {
        format(string, sizeof(string), "Naziv: %s~n~Vlasnik: %s~n~Tip: %s~n~Vrata: %s~n~~w~Cijena ulaza: %d~g~$~n~~w~Unisten: %s",
            BizzInfo[bizz][bMessage],
            ConvertSQLIDToName(BizzInfo[bizz][bOwnerID]),
            GetBiznisType(BizzInfo[bizz][bType]),
            BizzInfo[bizz][bLocked] == 1 ? ("~r~ZAKLJUCANA") : ("~g~OTKLJUCANA"),
            BizzInfo[bizz][bEntranceCost],
            BizzInfo[bizz][bDestroyed] ? ("Da") : ("Ne")
       );
    }
    else
    {
        format(string, sizeof(string), "Biznis je na prodaju~n~Naziv: %s~n~Tip: %s~n~Cijena: %d~g~$~n~~w~Level: %d~n~Unisten: %s",
            BizzInfo[bizz][bMessage],
            GetBiznisType(BizzInfo[bizz][bType]),
            BizzInfo[bizz][bBuyPrice],
            BizzInfo[bizz][bLevelNeeded],
            BizzInfo[bizz][bDestroyed] ? ("Da") : ("Ne")
       );
        PlayerTextDrawSetString(playerid, BiznisCMDTD[playerid], "Raspolozive komande:~n~      /enter, /buybiznis");
    }
    PlayerTextDrawSetString(playerid, BizzInfoTD[playerid], string);
    
    Player_SetBizzCP(playerid, checkpointid);
    Player_SetInfrontBizz(playerid, bizz);
    return 1;
}

hook OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
    new 
        bizz = CP_GetBizzID(checkpointid);
    
    if(!Iter_Contains(Business, bizz) || Player_GetBizzCP(playerid) != bizz)
        return 1;

    DestroyBizzInfoTD(playerid);
    Player_SetBizzCP(playerid, -1);
    Player_SetInfrontBizz(playerid, INVALID_BIZNIS_ID);
    return 1;
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
    if(fselectid == ms_SKINS)
    {
        if(!response)
            return SetPlayerPosFinish(playerid);

        new skin_index = Player_ModelToIndex(playerid, modelid);
        if(AC_GetPlayerMoney(playerid) < ServerSkins[sPrice][skin_index])
        {
            va_SendClientMessage(playerid,COLOR_RED, "Nemas dovoljno novca za kupnju skina %d ($%d)!", ServerSkins[sSkinID][skin_index], ServerSkins[sPrice][skin_index]);
            SetPlayerPosFinish(playerid);
            return 1;
        }
        PlayerSkinId   [playerid] = ServerSkins[sSkinID][skin_index];
        PlayerSkinPrice[playerid] = ServerSkins[sPrice][skin_index];

        SetPlayerSkin(playerid, ServerSkins[sSkinID][skin_index]);

        va_SendClientMessage(playerid, COLOR_RED, "[!] Izabrao si skin ID %d ($%d)! Koristi /buyskin za kupovinu!", ServerSkins[sSkinID][skin_index], ServerSkins[sPrice][skin_index]);

        SetPlayerPosFinish(playerid);
    }
    return 1;
}

hook OnGameModeInit()
{
    ResetBizzEnumerator();
    VeronaSkinRectangle = CreateDynamicRectangle(1092.39172, -1431.54944, 1101.95300, -1449.16431);
    return 1;
}

hook OnGameModeExit()
{
    DestroyDynamicArea(VeronaSkinRectangle);
    return 1;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
    if(VeronaSkinRectangle == areaid)
    {
        if(PlayerSkinId[playerid] != 0 && PlayerSkinPrice[playerid] != 0 && !Player_OnLawDuty(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "[!] Odustali ste od kupovine skina!");
            ResetBuySkin(playerid);
        }
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    DestroyBizzInfoTD(playerid);

    FreeBizzID     [playerid] = INVALID_BIZNIS_ID;
    ArticleSlot    [playerid] = 0;
    ArticleIdInput [playerid] = 0;
    PlayerSkinId   [playerid] = 0;
    PlayerSkinPrice[playerid] = 0;
    Player_SetIsDJ(playerid, false);
    Player_SetDJBizzKey(playerid, INVALID_BIZNIS_ID);

    Player_SetBizzCP(playerid, INVALID_BIZNIS_ID);
    Player_SetInfrontBizz(playerid, INVALID_BIZNIS_ID);
    Player_SetInBusiness(playerid, INVALID_BIZNIS_ID);
	return continue(playerid);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_SECONDARY_ATTACK) // ENTER
    {
        foreach(new i : Business)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[i][bVipEnter][0], BizzInfo[i][bVipEnter][1], BizzInfo[i][bVipEnter][2])
                && BizzInfo[i][bVipType] != 0
                && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld])
            {
                SetPlayerPosEx(playerid, BizzInfo[i][bVipExit][0], BizzInfo[i][bVipExit][1], BizzInfo[i][bVipExit][2], BizzInfo[i][bVirtualWorld], BizzInfo[i][bInterior], true);
                return 1;
            }
            else if(IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[i][bVipExit][0], BizzInfo[i][bVipExit][1], BizzInfo[i][bVipExit][2])
                    && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld])
            {
                SetPlayerPosEx(playerid, BizzInfo[i][bVipEnter][0], BizzInfo[i][bVipEnter][1], BizzInfo[i][bVipEnter][2],BizzInfo[i][bVirtualWorld],BizzInfo[i][bInterior],true);
                return 1;
            }
        }
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    // TODO: wtf is "bouse", rename to something meaningful
    new bouse = PlayerKeys[playerid][pBizzKey];
    switch (dialogid)
    {
        case DIALOG_NEWBIZNIS_NAME:
        {
            new bizz = FreeBizzID[playerid];
            if(bizz == INVALID_BIZNIS_ID) return 1;

            if(!response)
            {
                ResetBizzInfo(bizz);
                return SendClientMessage(playerid, COLOR_LIGHTRED, "[!]  Prekinuli ste stvaranje biznisa.");
            }
            if(strlen(inputtext) < 3 || strlen(inputtext) > 16)
            {
                ResetBizzInfo(bizz);
                return SendClientMessage(playerid, COLOR_RED, "Ime koje ste unesli nije valjano (3-16)!");
            }
            // TODO: no magic numbers
            format(BizzInfo[bizz][bMessage], 16, inputtext);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Ime biznisa promjenjeno u %s.", inputtext);
            ShowPlayerDialog(playerid, DIALOG_BIZNIS_TYPE, DIALOG_STYLE_LIST, "Odaberite tip novostvorenog biznisa:", GetBiznisTypeList(), "Choose", "Exit");
            return 1;
        }
        case DIALOG_BIZNIS_TYPE:
        {
            new bizz = FreeBizzID[playerid];
            if(bizz == INVALID_BIZNIS_ID) return 1;

            if(!response)
            {
                ResetBizzInfo(bizz);
                SendClientMessage(playerid, COLOR_LIGHTRED, "[!]  Prekinuli ste stvaranje biznisa.");
                return 1;
            }

            BizzInfo[bizz][bType] = listitem;
            Iter_Add(Business, bizz);
            InsertNewBizz(playerid, bizz);
            FreeBizzID[playerid] = INVALID_BIZNIS_ID;
            return 1;
        }
        case DIALOG_REMOVE_BIZNIS:
        {
            new bizz = FreeBizzID[playerid];
            if(bizz == INVALID_BIZNIS_ID) return 1;

            if(!response)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "[!]  Odustali ste od brisanja biznisa.");
                return 1;
            }

            va_SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste izbrisali %s %s[ID: %d | SQLID: %d].",
                GetBiznisType(BizzInfo[bizz][bType]),
                BizzInfo[bizz][bMessage],
                bizz,
                BizzInfo[bizz][bSQLID]
           );
            DeleteBiznis(bizz);
            FreeBizzID[playerid] = INVALID_BIZNIS_ID;
            return 1;
        }
        // TODO: refactor this dialog, to reduce code duplication
        case DIALOG_BIZNIS_MAIN:
        {
            if(!response) return 1;
            if(bouse < 0 || bouse >= 999) return 1;

            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                {
                    switch (listitem)
                    {
                        case 0:
                        {   // Info
                            PrintBizInfo(playerid, bouse);
                        }
                        case 1:
                        {   // Postavi artikl
                            if(GetEmptyProductSlot(bouse) == -1)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Vasa polica je puna!");
                                return 1;
                            }
                            new string[1744];
                            // TODO: strcpy
                            format(string, sizeof(string), "%s", GetArticleList(bouse));
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", string, "Choose", "Abort");
                        }
                        case 2:
                        {   // Skini artikl
                            new string[870];
                            // TODO: strcpy
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE ARTIKLA", string, "Choose", "Abort");
                        }
                        case 3:
                        {   // Postavi cijenu
                            new string[870];
                            // TODO: strcpy
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", string, "Choose", "Abort");
                        }
                        case 4:
                        {   // Vrata
                            if(!IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ]) ||
                                !IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ]))
                            {
                                SendClientMessage(playerid, COLOR_RED, "Niste blizu vrata od biznisa!");
                                return 1;
                            }
                            BizzInfo[bouse][bLocked] ^= 1; // toggle
                            GameTextForPlayer(playerid, (BizzInfo[bouse][bLocked]) ? ("~g~Zakljucano") : ("~g~Otkljucano"), 1000, 5);

                            mysql_fquery(g_SQL, "UPDATE bizzes SET locked = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bLocked], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 5:
                        {   // Rekonstrukcija
                            if(!BizzInfo[bouse][bDestroyed])
                            {
                                SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
                                return 1;
                            }
                            switch (BizzInfo[bouse][bDestroyed])
                            {
                                case 1: //Izlog
                                {
                                    if(AC_GetPlayerMoney(playerid) < 2000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
                                }
                                case 2: //Interier
                                {
                                    if(AC_GetPlayerMoney(playerid) < 8000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
                                }
                                case 3:
                                {
                                    if(AC_GetPlayerMoney(playerid) < 20000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
                                }
                            }
                            mysql_fquery(g_SQL, "UPDATE bizzes SET destroyed = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bDestroyed], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 6:
                        {   // Cijena produkta
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Input", "Abort");
                        }
                        case 7:
                        {   // Ime biznisa
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Next", "Back");
                        }
                        case 8:
                        {
                            ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Sell", "Close");
                        }
                        case 9:
                        {
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEREFF, DIALOG_STYLE_LIST, "MOJ BIZNIS - REFILL ARTIKLA", string, "Choose", "Abort");
                        }
                    }
                }
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                {
                    switch (listitem)
                    {
                        case 0:
                        {   // Info
                            PrintBizInfo(playerid, bouse);
                        }
                        case 1:
                        {   // Cijena ulaza
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ENTRANCE, DIALOG_STYLE_INPUT, "BIZNIS - CIJENA ULAZA/USLUGE", "Unesite iznos nove cijene ulaza\nCijena mora biti izmedju 0 i 1.000$!", "Next", "Back");
                        }
                        case 2:
                        {   // Postavi artikl
                            if(GetEmptyProductSlot(bouse) == -1) return SendClientMessage(playerid, COLOR_RED, "Vasa polica je puna!");

                            new string[1744];
                            format(string, sizeof(string), "%s", GetArticleList(bouse));
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA PICA", string, "Choose", "Abort");
                        }
                        case 3:
                        {   // Skini artikl
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE PICA S MENUA", string, "Choose", "Abort");
                        }
                        case 4:
                        {   // Postavi cijenu
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - POSTAVI CIJENU PICA", string, "Choose", "Abort");
                        }
                        case 5:
                        {   // Vrata
                            if(!IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ]) ||
                                !IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ]))
                            {
                                SendClientMessage(playerid, COLOR_RED, "Niste blizu vrata od biznisa!");
                                return 1;
                            }
                            BizzInfo[bouse][bLocked] ^= 1; // toggle
                            GameTextForPlayer(playerid, (BizzInfo[bouse][bLocked]) ? ("~g~Zakljucano") : ("~g~Otkljucano"), 1000, 5);

                            mysql_fquery(g_SQL, "UPDATE bizzes SET locked= '%d' WHERE id= '%d'", 
                                BizzInfo[bouse][bLocked], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 6:
                        {   // Rekonstrukcija
                            if(!BizzInfo[bouse][bDestroyed]) return SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");

                            switch (BizzInfo[bouse][bDestroyed])
                            {
                                case 1:
                                {   // Izlog
                                    if(AC_GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");

                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
                                }
                                case 2:
                                {   // Interier
                                    if(AC_GetPlayerMoney(playerid) < 8000) return SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");

                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
                                }
                                case 3:
                                {   // Komplet
                                    if(AC_GetPlayerMoney(playerid) < 20000) return SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");

                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
                                }
                            }
                            mysql_fquery(g_SQL, "UPDATE bizzes SET destroyed = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bDestroyed], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 7:
                        {   // Cijena produkta
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Input", "Abort");
                        }
                        case 8:
                        {
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Next", "Back");
                        }
                        case 9:
                        {
                            ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Sell", "Close");
                        }
                        case 10:
                        {
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEREFF, DIALOG_STYLE_LIST, "MOJ BIZNIS - REFILL ARTIKLA", string, "Choose", "Abort");
                        }
                    }
                }
                case BIZZ_TYPE_GASSTATION:
                {
                    switch (listitem)
                    {
                        case 0:
                        {   // Info
                            PrintBizInfo(playerid, bouse);
                        }
                        case 1:
                        {   // Postavi artikl
                            if(GetEmptyProductSlot(bouse) == -1) return SendClientMessage(playerid, COLOR_RED, "Vasa polica je puna!");

                            new string[1744];
                            format(string, sizeof(string), "%s", GetArticleList(bouse));
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", string, "Choose", "Abort");
                        }
                        case 2:
                        {   // Skini artikl
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE ARTIKLA", string, "Choose", "Abort");
                        }
                        case 3:
                        {   // Postavi cijenu
                            new string[870];
                            format(string, sizeof(string), "%s", GetStoreProducts(bouse));
                            if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!");

                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", string, "Choose", "Abort");
                        }
                        case 4:
                        {   // Vrata
                            if(!IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ]) ||
                                !IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ]))
                            {
                                SendClientMessage(playerid, COLOR_RED, "Niste blizu vrata od biznisa!");
                                return 1;
                            }
                            BizzInfo[bouse][bLocked] ^= 1; // toggle
                            GameTextForPlayer(playerid, (BizzInfo[bouse][bLocked]) ? ("~g~Zakljucano") : ("~g~Otkljucano"), 1000, 5);

                            mysql_fquery(g_SQL, "UPDATE bizzes SET locked = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bLocked], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 5:
                        {   // Rekonstrukcija
                            if(!BizzInfo[bouse][bDestroyed])
                            {
                                SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
                                return 1;
                            }
                            switch (BizzInfo[bouse][bDestroyed])
                            {
                                case 1: //Izlog
                                {
                                    if(AC_GetPlayerMoney(playerid) < 2000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
                                }
                                case 2: //Interier
                                {
                                    if(AC_GetPlayerMoney(playerid) < 8000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
                                }
                                case 3:
                                {
                                    if(AC_GetPlayerMoney(playerid) < 20000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
                                }
                            }
                            mysql_fquery(g_SQL, "UPDATE bizzes SET destroyed = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bDestroyed], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 6:
                        {   // Ime biznisa
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Next", "Back");
                        }
                        case 7:
                        {
                            ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Sell", "Close");
                        }
                    }
                }
                default:
                {
                    switch (listitem)
                    {
                        case 0:
                        {   // Info
                            PrintBizInfo(playerid, bouse);
                        }
                        case 1:
                        {   // Vrata
                            if(!IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ]) ||
                                !IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ]))
                            {
                                SendClientMessage(playerid, COLOR_RED, "Niste blizu vrata od biznisa!");
                                return 1;
                            }
                            BizzInfo[bouse][bLocked] ^= 1; // toggle
                            GameTextForPlayer(playerid, (BizzInfo[bouse][bLocked]) ? ("~g~Zakljucano") : ("~g~Otkljucano"), 1000, 5);

                            mysql_fquery(g_SQL, "UPDATE bizzes SET locked = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bLocked], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 2:
                        {   // Rekonstrukcija
                            if(!BizzInfo[bouse][bDestroyed])
                            {
                                SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
                                return 1;
                            }
                            switch (BizzInfo[bouse][bDestroyed])
                            {
                                case 1: //Izlog
                                {
                                    if(AC_GetPlayerMoney(playerid) < 2000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
                                }
                                case 2: //Interier
                                {
                                    if(AC_GetPlayerMoney(playerid) < 8000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
                                }
                                case 3:
                                {
                                    if(AC_GetPlayerMoney(playerid) < 20000)
                                    {
                                        SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
                                        return 1;
                                    }
                                    SendClientMessage(playerid, COLOR_RED, "[!]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
                                    BizzInfo[bouse][bDestroyed] = 0;
                                    PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
                                }
                            }
                            mysql_fquery(g_SQL, "UPDATE bizzes SET destroyed = '%d' WHERE id = '%d'", 
                                BizzInfo[bouse][bDestroyed], 
                                BizzInfo[bouse][bSQLID]
                           );
                        }
                        case 3:
                        {   // Postavljanje cijene produkta
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Input", "Abort");
                        }
                        case 4:
                        {   // Ime biznisa
                            ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Next", "Back");
                        }
                        case 5:
                        {
                            ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Sell", "Close");
                        }
                    }
                }
            }
            return 1;
        }
        case DIALOG_SELL_BIZ:
        {
            if(!response)
            {
                return 1;
            }
            new
                gplayerid = strval(inputtext),
                bizz = PlayerKeys[playerid][pBizzKey];

            if(bizz < 0 || bizz >= MAX_BIZZES) return 1;

            if(!IsPlayerInRangeOfPoint(playerid, 10.0, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]))
            {
                SendClientMessage(playerid, COLOR_RED, "Morate biti blizu vaseg biznisa!");
                return 1;
            }
            if(!ProxDetectorS(5.0, playerid, gplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas!");
            if(PlayerKeys[gplayerid][pBizzKey] != INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "Taj igrac vec ima biznis!");

            GlobalSellingPlayerID[playerid] = gplayerid;
            ShowPlayerDialog(playerid, DIALOG_SELL_BIZ_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "Unesite cijenu vaseg biznisa", "Input", "Close");
            return 1;
        }
        case DIALOG_SELL_BIZ_PRICE:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Sell", "Close");

            new
                bizzPrice = strval(inputtext),
                pID = GlobalSellingPlayerID[playerid];
            if(pID < 0 || pID == INVALID_PLAYER_ID)
            {
                SendClientMessage(playerid, COLOR_RED, "Nitko vam nije ponudio prodaju biznisa!");
                return 1;
            }
            if(bizzPrice < 1 || bizzPrice > 9999999) return ShowPlayerDialog(playerid, DIALOG_SELL_BIZ_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "Unesite cijenu vaseg biznisa>\nCijena biznisa ne moze biti manja od 1$, a veca od 9.999.999$", "Input", "Close");
            if(AC_GetPlayerMoney(pID) < bizzPrice) return SendClientMessage(playerid, COLOR_RED, "Osoba nema toliko novaca kod sebe!");

            GlobalSellingPrice   [pID] = bizzPrice;
            GlobalSellingPlayerID[pID] = playerid;

            va_SendClientMessage(playerid, COLOR_YELLOW, "[!]  Uspjesno ste ponudili vas biznis igracu %s za %d$", GetName(pID), bizzPrice);
            va_ShowPlayerDialog(pID, DIALOG_SELL_BIZ_2, DIALOG_STYLE_MSGBOX, "PONUDA ZA KUPOVINU BIZNISA", "Igrac %s vam je ponudio da kupite biznis za %d", "Buy", "Close", GetName(playerid), bizzPrice);
            return 1;
        }
        case DIALOG_SELL_BIZ_2:
        {
            if(!response)
            {
                return 1;
            }
            new
                pID       = GlobalSellingPlayerID[playerid],
                bizzPrice = GlobalSellingPrice[playerid];

            if(pID < 0 || pID == INVALID_PLAYER_ID)
            {
                SendClientMessage(playerid, COLOR_RED, "Nitko vam nije ponudio prodaju biznisa!");
                return 1;
            }
            PlayerKeys[playerid][pBizzKey] = PlayerKeys[pID][pBizzKey];
            PlayerKeys[pID][pBizzKey]      = INVALID_BIZNIS_ID;

            new
                bizz = PlayerKeys[playerid][pBizzKey];

            mysql_fquery(g_SQL, "UPDATE bizzes SET ownerid = '%d' WHERE id = '%d'",
                PlayerInfo[playerid][pSQLID],
                BizzInfo[bizz][bSQLID]
           );

            BizzInfo[bizz][bOwnerID] = PlayerInfo[playerid][pSQLID];

            // Money
            PlayerToPlayerMoneyTAX(playerid, pID, bizzPrice, true, LOG_TYPE_BIZSELL);

            va_SendClientMessage(playerid, COLOR_YELLOW, "[!]  Uspjesno ste kupili biznis %s od %s za %d$", BizzInfo[bizz][bMessage], GetName(pID), bizzPrice);
            va_SendClientMessage(pID, COLOR_YELLOW, "[!]  Igrac %s je kupio od vas biznis %s za %d", GetName(playerid), BizzInfo[bizz][bMessage], bizzPrice);

            GlobalSellingPlayerID[playerid] = INVALID_PLAYER_ID;
            GlobalSellingPrice   [playerid] = 0;

            #if defined MODULE_LOGS
            Log_Write("/logfiles/buy_biznis.txt", "(%s) %s(%s) bought business %s[SQLID: %d] from %s(%s) for %d$.",
                ReturnDate(),
                GetName(playerid, false),
                ReturnPlayerIP(playerid),
                BizzInfo[bizz][bMessage],
                BizzInfo[bizz][bSQLID],
                GetName(pID, false),
                ReturnPlayerIP(pID),
                bizPrice
           );
            #endif

            return 1;
        }
        case DIALOG_BIZNIS_ARTICLELIST:
        {
            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }

            new article_nr = listitem + 100;
            if(!IsValidArticle(bouse, article_nr)) return SendClientMessage(playerid, COLOR_RED, "Taj je artikl vec na policama!");

            ArticleIdInput[playerid] = article_nr;
            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Input", "Abort");
            return 1;
        }
        case DIALOG_BIZNIS_ARTICLEPRICE:
        {
            //new
            //  bizz = PlayerKeys[playerid][pBizzKey];
            if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", GetArticleList(bouse), "Choose", "Abort");

            new price = strval(inputtext);
            if(price < 5 || price > 1000)
            {
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\n"COL_RED"Ona mora biti izmedju 5 i 1000$!", "Input", "Abort");
                return 1;
            }
            if(AC_GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, COLOR_RED, "Nemate 500$ u djepu!");

            // Polica
            SetStoreProductOnSale(bouse, ArticleIdInput[playerid], price);

            new bizz_type = BizzInfo[bouse][bType];
            if(bizz_type == BIZZ_TYPE_DUCAN)
            {
                PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun

                va_SendClientMessage(playerid, COLOR_RED, "[!]  Artikl %s ste stavili na svoje police!",
                    GetStoreProductName(ArticleIdInput[playerid])
               );
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            else if(bizz_type == BIZZ_TYPE_BAR || bizz_type == BIZZ_TYPE_STRIP)
            {
                PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun

                va_SendClientMessage(playerid, COLOR_RED, "[!]  Pice %s je sada u ponudi pica!",
                    GetDrinkName(ArticleIdInput[playerid])
               );
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_BIZNIS_ARTICLEINV:
        {
            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }

            ArticleSlot[playerid] = listitem;
            ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLESETPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Input", "Abort");
            return 1;
        }
        case DIALOG_BIZNIS_ARTICLESETPRICE:
        {
            //new
                //bizz = PlayerKeys[playerid][pBizzKey];
            if(!response) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", GetStoreProducts(bouse), "Choose", "Abort");

            new price = strval(inputtext);
            if(price < 5 || price > 1000)
            {
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_ARTICLESETPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Input", "Abort");
                return 1;
            }
            // Polica
            new slot = ArticleSlot[playerid];
            BiznisProducts[bouse][bpPrice][slot] = price;
            UpdateBizzProduct(bouse, slot);

            new bizz_type = BizzInfo[bouse][bType];
            if(bizz_type == BIZZ_TYPE_DUCAN)
            {
                va_SendClientMessage(playerid, COLOR_RED, "[!]  Stavili ste novu cijenu na artikl %s!",
                    GetStoreProductName(BiznisProducts[bouse][bpType][slot])
               );
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            else if(bizz_type == BIZZ_TYPE_BAR || bizz_type == BIZZ_TYPE_STRIP)
            {
                va_SendClientMessage(playerid, COLOR_RED, "[!]  Stavili ste novu cijenu na artikl %s!",
                    GetDrinkName(BiznisProducts[bouse][bpType][slot])
               );
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_BIZNIS_ARTICLEREM:
        {
            if(!response || !BiznisProducts[bouse][bpAmount][listitem])
            {
                switch (BizzInfo[bouse][bType])
                {
                    case BIZZ_TYPE_DUCAN:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                    case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                }
                return 1;
            }

            RemoveStoreArticle(bouse, listitem);
            SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste maknuli artikl s polica!");

            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nStavi pice na menu\nSkini pice s menua\nPostavi cijenu pica\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_BIZNIS_ARTICLEREFF:
        {
            if(!response)
            {
                switch (BizzInfo[bouse][bType])
                {
                    case BIZZ_TYPE_DUCAN:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                    case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                }
                return 1;
            }

            if(AC_GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, COLOR_RED, "Nemate 500$!");

            BiznisProducts[bouse][bpAmount][listitem] = BizzInfo[bouse][bMaxProducts];
            PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun
            SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste refillali odabrani artikl!");
            UpdateBizzProduct(bouse, listitem);

            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nStavi pice na menu\nSkini pice s menua\nPostavi cijenu pica\nVrata\nRekonstrukcija biznisa($20.000)\nIme Biznisa\nProdaj biznis igracu\nRefill pica\nRefill pica", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_BIZNIS_NAME:
        {
            if(!response)
            {
                switch (BizzInfo[bouse][bType])
                {
                    case BIZZ_TYPE_DUCAN:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                    case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                }
                return 1;
            }

            if(strlen(inputtext) < 3 || strlen(inputtext) > 15)
            {
                SendClientMessage(playerid, COLOR_RED, "Ime koje ste unesli nije valjano (3-15)!");
                return 1;
            }

            // TODO: strcpy
            format(BizzInfo[bouse][bMessage], 16, inputtext);
            va_SendClientMessage(playerid, COLOR_RED, "[!]  Ime biznisa promjenjeno u %s.", BizzInfo[bouse][bMessage]);

            mysql_fquery(g_SQL, "UPDATE bizzes SET message = '%e' WHERE id = '%d'", 
                BizzInfo[bouse][bMessage], 
                BizzInfo[bouse][bSQLID]
           );

            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_BIZNIS_BUYING:
        {
            if(!response) return 1;

            new
                bizz = Player_InBusiness(playerid),
                bizz_type = BizzInfo[bizz][bType];

            if(!Iter_Contains(Business, bizz)) return 1;

            if(bizz_type == BIZZ_TYPE_DUCAN)
            {
                if(BiznisProducts[bizz][bpAmount][listitem] < 1) return SendClientMessage(playerid, COLOR_RED, "Artikl nije na policama!");
                if(AC_GetPlayerMoney(playerid) < BiznisProducts[bizz][bpPrice][listitem]) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko novca!");

                switch (BiznisProducts[bizz][bpType][listitem])
                {
                    case PRODUCT_BURGERS, PRODUCT_CAKE, PRODUCT_HOTDOG, PRODUCT_PIZZA:
                        Player_SetHasFood(playerid, true);
                    case PRODUCT_COLA, PRODUCT_PEPSI, PRODUCT_WINE, PRODUCT_WATER, PRODUCT_BEER:
                        Player_SetHasDrink(playerid, true);
                    case PRODUCT_CIGARS:
                    {
                        if(PlayerInfo[playerid][pAge] < 18) return SendClientMessage(playerid, COLOR_YELLOW, "Prodavacica: Ne prodajemo cigarete mladima od 18 godina.");
                        PlayerInventory[playerid][pCiggaretes] += 20;
                    }
                    case PRODUCT_GROCERIES:
                    {
                        if(Player_GetGroceriesQuantity(playerid) == 20) return SendClientMessage(playerid, COLOR_RED, "Vec imate namirnice, spremite ih!");
                        Player_SetGroceriesQuantity(playerid, 20);
                    }
                    case PRODUCT_MASK:
                    {
                        if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, COLOR_RED, "Level 3+ igraci mogu kupovati maske!");

                        PlayerInventory[playerid][pMaskID] = 100000 + random(899999);

                        #if defined MODULE_LOGS
                        Log_Write("/logfiles/masks.txt", "(%s) %s(%s), Mask ID: %d.",
                            ReturnDate(),
                            GetName(playerid, false),
                            ReturnPlayerIP(playerid),
                            PlayerInventory[playerid][pMaskID]
                       );
                        #endif
                    }
                    case PRODUCT_FLOWERS:
                    {
                        if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                        AC_GivePlayerWeapon(playerid, WEAPON_FLOWER, 2);
                    }
                    case PRODUCT_CAMERA:
                    {
                        if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                        AC_GivePlayerWeapon(playerid, WEAPON_CAMERA, 100);
                    }
                    case PRODUCT_BAT:
                    {
                        if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                        AC_GivePlayerWeapon(playerid, WEAPON_BAT, 2);
                    }
                    case PRODUCT_SPRAY:
                    {
                        if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                        AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 100);
                    }
                    case PRODUCT_TOOLKIT:
                    {
                        if(PlayerInventory[playerid][pToolkit]) return SendClientMessage(playerid, COLOR_RED, "Vec imate tool kit!");
                        PlayerInventory[playerid][pToolkit] = 1;
                    }
                    case PRODUCT_BOOMBOX:
                    {
                        if(PlayerInventory[playerid][pBoomBox]) return SendClientMessage(playerid, COLOR_RED, "Vec imate kazetofon!");
                        PlayerInventory[playerid][pBoomBox] = 1;
                    }
                    case PRODUCT_PCREDIT:
                    {
                        PlayerMobile[playerid][pMobileCost] += 20;

                        mysql_fquery(g_SQL, "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
                            PlayerMobile[playerid][pMobileCost],
                            PlayerInfo[playerid][pSQLID]
                       );
                    }
                    case PRODUCT_CLOCK:
                    {
                        if(PlayerInventory[playerid][pWatch]) return SendClientMessage(playerid, COLOR_RED, "Vec posjedujete sat!");
                        PlayerInventory[playerid][pWatch] = 1;
                    }
                    case PRODUCT_DICE:
                        Player_SetHasDice(playerid, true);
                    case PRODUCT_LIGHTER:
                        PlayerInventory[playerid][pLighter] = 1;
                    case PRODUCT_ROPE:
                        PlayerInventory[playerid][pRope] = 1;
                    case PRODUCT_RADIO:
                    {
                        if(PlayerRadio[playerid][pHasRadio]) return SendClientMessage(playerid, COLOR_RED, "Vec posjedujete radio!");
                        PlayerRadio[playerid][pHasRadio] = 1;

                        mysql_fquery(g_SQL, "UPDATE player_radio SET HasRadio = '%d' WHERE sqlid = '%d'",
                            PlayerRadio[playerid][pHasRadio],
                            PlayerInfo[playerid][pSQLID]
                       );
                    }
                }

                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                PlayerToBusinessMoneyTAX(playerid, bizz, BiznisProducts[bizz][bpPrice][listitem]); // Novac od igraca ide u biznis, ali se oporezuje
                UpdateBizzProduct(bizz, listitem);

                BiznisProducts[bizz][bpAmount][listitem]--;
                if(!BiznisProducts[bizz][bpAmount][listitem])
                {
                    BiznisProducts[bizz][bpAmount][listitem] = MAX_BIZZ_PRODUCTS;
                    BusinessToBudgetMoney(bizz, 500); // Novac iz biznisa ide u proracun
                    UpdateBizzProduct(bizz, listitem);
                }

                va_SendClientMessage(playerid, COLOR_RED, "[!]  Kupili ste %s za %d$",
                    GetStoreProductName(BiznisProducts[bizz][bpType][listitem]),
                    BiznisProducts[bizz][bpPrice][listitem]
               );
            }
            else if(bizz_type == BIZZ_TYPE_BAR || bizz_type == BIZZ_TYPE_STRIP)
            {
                if(BiznisProducts[bizz][bpAmount][listitem] < 1) return SendClientMessage(playerid, COLOR_RED, "Pice nije na menu-u!");
                if(AC_GetPlayerMoney(playerid) < BiznisProducts[bizz][bpPrice][listitem]) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko novca!");

                BiznisProducts[bizz][bpAmount][listitem]--;
                PlayerToBusinessMoneyTAX(playerid, bizz, BiznisProducts[bizz][bpPrice][listitem]); // Stavka koja se kupuje se oporezuje..

                UpdateBizzProduct(bizz, listitem);

                if(!BiznisProducts[bizz][bpAmount][listitem])
                {
                    BiznisProducts[bizz][bpAmount][listitem] = MAX_BIZZ_PRODUCTS;
                    BusinessToBudgetMoney (bizz, 500); // Novac ide u proracun iz biznisa
                    UpdateBizzProduct(bizz, listitem);
                }

                va_GameTextForPlayer(playerid, "~g~Pijete %s...", 1000, 1,
                    GetDrinkName(BiznisProducts[bizz][bpType][listitem])
               );
                SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 250);
            }
            return 1;
        }
        case DIALOG_BIZNIS_CRYPTOORMOBILE:
        {
            if(!response)
                return 1;

            switch (listitem)
            {
                case 0: ShowPlayerDialog(playerid, DIALOG_BIZNIS_MOBILEBUY, DIALOG_STYLE_LIST, "Odaberite mobitel", ListPhonesForSale(), "Buy", "Exit");
                case 1: ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOBUY, DIALOG_STYLE_LIST, "Odaberite crypto...", "Motorola T-900 Crypto - 50$\nAppollo Gold T25 - 70$\nX3 Crypto - 100$", "Choose", "Abort");
                case 2:
                {
                    if(!PlayerMobile[playerid][pMobileNumber]) return SendErrorMessage(playerid, "Nemate mobitel!");
                    PhoneMaskMenu(playerid);
                }
            }
        }
        case DIALOG_BIZNIS_MOBILEBUY:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo", "Choose", "Abort");

            BuyPlayerPhone(playerid, listitem);
            return 1;
        }
        case DIALOG_BIZNIS_CRYPTOBUY:
        {
            if(!response)
                return ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo", "Choose", "Abort");

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 50)
                        return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(50$)!");

                    PlayerToBudgetMoney(playerid, 50); // Novac ide u proracun jer je Verona Mall
                    SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste kupili Motorola T-900 Crypto!");
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 70)
                        return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(70$)!");

                    PlayerToBudgetMoney(playerid, 70); // Novac ide u proracun jer je Verona Mall
                    SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste kupili Appollo Gold Crypto!");
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 100)
                        return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(100$)!");

                    PlayerToBudgetMoney(playerid, 100); // Novac ide u proracun jer je Verona Mall
                    SendClientMessage(playerid, COLOR_RED, "[!]  Uspjesno ste kupili X3 Crypto!");
                }
            }

            PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            PlayerMobile[playerid][pCryptoNumber] = 100000 + random(899999);

            va_SendClientMessage(playerid, COLOR_RED, "[!]  Vas novi broj cryptoa je %d",
                PlayerMobile[playerid][pCryptoNumber]
           );
            SendClientMessage(playerid, COLOR_YELLOW, "[!]  Koristite /cryptotext!");
            SavePlayerMobile(playerid, 2);
            return 1;
        }
        case DIALOG_BIZNIS_ENTRANCE:
        {
            //new
            //  bizz = PlayerKeys[playerid][pBizzKey];
            new value = strval(inputtext);
            if(!response || (value < 0 || value > 200))
            {
                switch (BizzInfo[bouse][bType])
                {
                    case BIZZ_TYPE_DUCAN:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                    case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                }
                return 1;
            }

            BizzInfo[bouse][bEntranceCost] = value;
            SendClientMessage(playerid, COLOR_RED, "[!]  Postavili ste novu cijenu ulaza!");

            mysql_fquery(g_SQL, "UPDATE bizzes SET entrancecost = '%d' WHERE id = '%d'", 
                BizzInfo[bouse][bEntranceCost], 
                BizzInfo[bouse][bSQLID]
           );

            switch (BizzInfo[bouse][bType])
            {
                case BIZZ_TYPE_DUCAN:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
                case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
                    ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
            }
            return 1;
        }
        case DIALOG_CHICKENMENU:
        {
            if(!response) return 1;

            new
                string[47],
                bizz = Player_InBusiness(playerid);

            if(bizz < 0 || bizz >= MAX_BIZZES) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
                    if(PlayerHealth[playerid][pHunger] < 3.5)
                        PlayerHealth[playerid][pHunger] += 1.5;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 5); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede topli sendvic.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede cevape.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede filete.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
                    if(PlayerHealth[playerid][pHunger] < 4.2)
                        PlayerHealth[playerid][pHunger] += 0.8;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 2); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede vocnu salatu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede kebab.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s pije sprite.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                }
                case 6:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 1); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s pije vodu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            return 1;
        }
        case DIALOG_PIZZAMENU:
        {
            if(!response) return 1;

            new
                string[48],
                bizz = Player_InBusiness(playerid);

            if(bizz < 0 || bizz >= MAX_BIZZES) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 3.5)
                        PlayerHealth[playerid][pHunger] += 1.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede pizzetu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED, "Nemas 6$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 6); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede veliku pizzu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
                    if(PlayerHealth[playerid][pHunger] < 3.5) {
                        PlayerHealth[playerid][pHunger] += 1.5;
                    }
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 5); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede topli sendvic.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
                    if(PlayerHealth[playerid][pHunger] < 4.5)
                        PlayerHealth[playerid][pHunger] += 0.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 2); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede salatu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED, "Nemas 10$!");
                    if(PlayerHealth[playerid][pHunger] < 1.5)
                        PlayerHealth[playerid][pHunger] += 3.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 10); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede Jumbo Pizzu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s pije Sprite.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                }
                case 6:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 1); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s pije vodu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            return 1;
        }
        case DIALOG_BURGERMENU:
        {
            if(!response) return 1;

            new
                string[51],
                bizz = Player_InBusiness(playerid);

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED, "Nemas 6$!");
                    if(PlayerHealth[playerid][pHunger] < 3.5)
                        PlayerHealth[playerid][pHunger] += 1.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede Big Mac.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 6); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 6); // Ako nije biznis ide u proracun
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 8) return SendClientMessage(playerid, COLOR_RED, "Nemas 8$!");
                    if(PlayerHealth[playerid][pHunger] < 3.2)
                        PlayerHealth[playerid][pHunger] += 1.8;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede Burger Menu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 8); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 8); // Ako nije biznis ide u proracun
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede tost.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun
                }
                case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
                    if(PlayerHealth[playerid][pHunger] < 4.2)
                        PlayerHealth[playerid][pHunger] += 0.8;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede francusku salatu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 2); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 2); // Ako nije biznis ide u proracun
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede sendvic sa sunkom.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun
                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije Sprite.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun
                }
                case 6:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
                    if(PlayerHealth[playerid][pHunger] < 4.9)
                        PlayerHealth[playerid][pHunger] += 0.1;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije vodu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 1); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 1); // Ako nije biznis ide u proracun
                }
            }
            return 1;
        }
        case DIALOG_RESTORANMENU:
        {
            new
                string[64],
                bizz = Player_InBusiness(playerid);

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede juhu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede piletinu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 5); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 5); // Ako nije biznis ide u proracun
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 7) return SendClientMessage(playerid, COLOR_RED, "Nemas 7$!");
                    if(PlayerHealth[playerid][pHunger] < 2.5)
                        PlayerHealth[playerid][pHunger] += 2.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede pecenog morskog psa na salatu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 7); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 7); // Ako nije biznis ide u proracun
                }
                case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 3.0)
                        PlayerHealth[playerid][pHunger] += 2.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede spaghetti.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
                    if(PlayerHealth[playerid][pHunger] < 4.5)
                        PlayerHealth[playerid][pHunger] += 0.5;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede kolac.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 2); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 2); // Ako nije biznis ide u proracun
                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije Coca Colu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun
                }
                case 6:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije vodu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

                    if(bizz != INVALID_BIZNIS_ID)
                        PlayerToBusinessMoney(playerid, bizz, 1); // Novac ide u blagajnu ali se oporezuje
                    else
                        PlayerToBudgetMoney(playerid, 1); // Ako nije biznis ide u proracun
                }
            }
            return 1;
        }
        case DIALOG_DONUTMENU:
        {
            new
                string[51],
                bizz = Player_InBusiness(playerid);

            if(bizz < 0 || bizz >= MAX_BIZZES) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede krofnu s visnjom.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    PlayerToBusinessMoney(playerid, bizz, 2); // Novac ide u blagajnu ali se oporezuje
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede punjenu krofnu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje

                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s jede krofnu s kokosom.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    PlayerToBusinessMoney(playerid, bizz, 4); // Novac ide u blagajnu ali se oporezuje
                }
                case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.0)
                        PlayerHealth[playerid][pHunger] += 1.0;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                    format(string, sizeof(string), "* %s jede cokoladnu krofnu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije Coca Colu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    PlayerToBusinessMoney(playerid, bizz, 3); // Novac ide u blagajnu ali se oporezuje
                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
                    if(PlayerHealth[playerid][pHunger] < 4.8)
                        PlayerHealth[playerid][pHunger] += 0.2;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s pije vodu.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    PlayerToBusinessMoney(playerid, bizz, 1); // Novac ide u blagajnu ali se oporezuje
                }
            }
            return 1;
        }
        case DIALOG_JAILMENU:
        {
            if(!response) return 1;

            new string[86];
            switch (listitem)
            {
                case 0:
                {
                    if(PlayerHealth[playerid][pHunger] < 4.9)
                        PlayerHealth[playerid][pHunger] += 0.1;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s uzima mahune.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 1:
                {
                    if(PlayerHealth[playerid][pHunger] < 4.9)
                        PlayerHealth[playerid][pHunger] += 0.1;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s uzima grah.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2:
                {
                    if(PlayerHealth[playerid][pHunger] < 4.9)
                        PlayerHealth[playerid][pHunger] += 0.1;
                    else
                        PlayerHealth[playerid][pHunger] = 5.0;

                    format(string, sizeof(string), "* %s uzima poriluk.", GetName(playerid, true));
                    ProxDetector(8.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
            }
            return 1;
        }
        case DIALOG_FAKE_BUY:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if(Player_HasFakeGunLicense(playerid)) return SendClientMessage(playerid, COLOR_RED, "Vec imas dozvolu");

                    SendClientMessage(playerid, COLOR_RED, "[!] Kupi ste laznu dozvolu za oruzje.");
                    Player_SetHasFakeGunLicense(playerid, true);
                }
                case 1:
                {
                    // TODO: looks like unfinished implementation to me
                    SendClientMessage(playerid, COLOR_RED, "Uskoro!");
                }
            }
            return 1;
        }
        case DIALOG_MALL_BUY:
        {
            if(!response) return 1;
            // TODO: refactor this switch-case with generic impl. and by returning data from an array
            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemate 1$!");

                    PlayerToBudgetMoney(playerid, 1); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljena kockica! [1$]");
                    Player_SetHasDice(playerid, true);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemate 5$!");
                    if(Player_HasDrink(playerid)) return SendClientMessage(playerid, COLOR_RED, "Vec imate neko pice u inventoryu! Koristite /drink!");

                    PlayerToBudgetMoney(playerid, 5); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljena Coca Cola! [5$]");
                    Player_SetHasDrink(playerid, true);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED, "Nemate 10$!");
                    if(PlayerInventory[playerid][pWatch]) return SendClientMessage(playerid, COLOR_RED, "Vec imate sat, koristite /time!");

                    PlayerToBudgetMoney(playerid, 10); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljen sat! [10$]");
                    PlayerInventory[playerid][pWatch] = 1;
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, COLOR_RED, "Level 3+ igraci mogu kupovati maske!");
                    if(AC_GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, COLOR_RED, "Nemate 500$!");
                    if(PlayerInventory[playerid][pMaskID] > 0) return SendClientMessage(playerid, COLOR_RED, "Vec imate masku!");

                    PlayerToBudgetMoney(playerid, 500); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljena maska! [500$]");
                    PlayerInventory[playerid][pMaskID] = 100000 + random(899999);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED, "Nemate 10$!");

                    PlayerToBudgetMoney(playerid, 10); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljene cigarete! [10$]. Koristite /usecigarette da bi zapalili cigaretu.");
                    PlayerInventory[playerid][pCiggaretes] += 20;
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemate 5$!");
                    if(PlayerInventory[playerid][pLighter]) return SendClientMessage(playerid, COLOR_RED, "Vec posjedujete upaljac!");

                    PlayerToBudgetMoney(playerid, 5); // APosto je VERONA MALL novac ide u budget

                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljen upaljac! [5$]");
                    PlayerInventory[playerid][pLighter] = 1;
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 6:
                {
                    ShowPlayerDialog(playerid, DIALOG_MUSIC_BUY, DIALOG_STYLE_LIST, "KUPOVINA KAZETOFONA", "Red Fire (100$)\nSilver King (100$)", "Choose", "Abort");
                }
                case 7:
                {
                    if(AC_GetPlayerMoney(playerid) < 100) return SendClientMessage(playerid, COLOR_RED, "Nemate 100$!");

                    PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget

                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    PlayerInventory[playerid][pRope] = 1;
                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljen konop! [100$]");
                }
                case 8:
                {
                    if(AC_GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED, "Nemate 50$!");
                    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                    PlayerToBudgetMoney(playerid, 50); // APosto je VERONA MALL novac ide u budget

                    AC_GivePlayerWeapon(playerid, WEAPON_BAT, 2);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 9:
                {
                    if(AC_GetPlayerMoney(playerid) < 100) return SendClientMessage(playerid, COLOR_RED, "Nemate 100$!");
                    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                    PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget

                    AC_GivePlayerWeapon(playerid, WEAPON_CAMERA, 100);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                }
                case 10:
                {
                    if(AC_GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED, "Nemate 50$!");
                    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!");

                    PlayerToBudgetMoney(playerid, 50); // APosto je VERONA MALL novac ide u budget

                    AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 100);
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljen SprayCan! [50$]");

                }
                case 11:
                {
                    if(AC_GetPlayerMoney(playerid) < 25) return SendClientMessage(playerid, COLOR_RED, "Nemate 25$!");

                    PlayerToBudgetMoney(playerid, 25); // APosto je VERONA MALL novac ide u budget

                    PlayerMobile[playerid][pMobileCost] += 25;
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    SendClientMessage(playerid, COLOR_RED, "[!]  Kupljen bon za mobitel! [25$]");

                    mysql_fquery(g_SQL, "UPDATE player_phones SET money = '%d' WHERE player_id = '%d' AND type = '1'",
                        PlayerMobile[playerid][pMobileCost],
                        PlayerInfo[playerid][pSQLID]
                   );
                }
                case 12:
                {
                    if(PlayerRadio[playerid][pHasRadio] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete radio!");
                    if(AC_GetPlayerMoney(playerid) < 1500) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 1500$!");

                    PlayerToBudgetMoney(playerid, 1500); // APosto je VERONA MALL novac ide u budget

                    PlayerRadio[playerid][pHasRadio] = 1;
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupljen radio [1500$]");

                    mysql_fquery(g_SQL, "UPDATE player_radio SET HasRadio = '%d' WHERE sqlid = '%d'",
                        PlayerRadio[playerid][pHasRadio],
                        PlayerInfo[playerid][pSQLID]
                   );
                }
                case 13:
                {
                    if(PlayerInventory[playerid][pToolkit] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete toolkit!");
                    if(AC_GetPlayerMoney(playerid) < 300) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 300$!");

                    PlayerToBudgetMoney(playerid, 300); // APosto je VERONA MALL novac ide u budget

                    PlayerInventory[playerid][pToolkit] = 1;
                    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupljen toolkit [300$]");
                }
            }
            return 1;
        }
        case DIALOG_MUSIC_BUY:
        {
            if(!response) return 1;

            switch (listitem)
            {
                case 0:
                {
                    if(AC_GetPlayerMoney(playerid) < 100) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko novca (100$)!");
                    PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget
                    PlayerInventory[playerid][pBoomBox]     = 1;
                }
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 100) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko novca (100$)!");
                    PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget
                    PlayerInventory[playerid][pBoomBox]     = 2;
                }
            }
            return 1;
        }
        case DIALOG_BIZNIS_PRODUCTPRICE:
        {
            if(!response) return 1;

            if(!(20 <= strval(inputtext) <= 1000))
            {
                ShowPlayerDialog(playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\n"COL_RED"Ona mora biti izmedju 20 i 1000$!", "Input", "Abort");
                return 1;
            }
            BizzInfo[bouse][bPriceProd] = strval(inputtext);
            SendClientMessage(playerid, COLOR_RED, "Uspjesno ste promjenili cijene produkta.");

            mysql_fquery(g_SQL, "UPDATE bizzes SET priceprod = '%d' WHERE id = '%d'", 
                BizzInfo[bouse][bPriceProd], 
                BizzInfo[bouse][bSQLID]
           );

            return 1;
        }
        case DIALOG_BIZNIS_MUSIC:
        {
            if(!response) return 1;

            if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MUSIC, DIALOG_STYLE_INPUT, "BIZNIS MUSIC", "Unesite live streaming link.\nNPR. shoutcast, listen2myradio, ...", "Input", "Abort");

            new bizz = Player_IsDJ(playerid) ? Player_GetDJBizzKey(playerid) : bouse;
            if(bizz < 0 || bizz >= MAX_BIZZES) return 1;
            // TODO: strcpy
            format(BizzInfo[bizz][bMusicURL], 96, inputtext);

            foreach(new i : Player)
            {
                if(!IsPlayerInRangeOfPoint(i, 80.0, BizzInfo[bizz][bExitX], BizzInfo[bizz][bExitY], BizzInfo[bizz][bExitZ]))
                    continue;

                StopAudioStreamForPlayer(i);
                PlayAudioStreamForPlayer(i, BizzInfo[bizz][bMusicURL]);
            }
            SendClientMessage(playerid, COLOR_YELLOW, "[!]  Uspjesno si ukljucio radio!");
            return 1;
        }
        case DIALOG_SKINSURE:
        {
            new
                bizz        = Player_InBusiness(playerid),
                player_skin = PlayerSkinId[playerid],
                skin_price  = PlayerSkinPrice[playerid];

            if(!response)
            {
                SetPlayerSkin(playerid, player_skin);
                ResetBuySkin(playerid);
                return 1;
            }

            if(AC_GetPlayerMoney(playerid) < skin_price)
            {
                SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca (%d$)!", skin_price);
                SetPlayerSkin(playerid, player_skin);

                PlayerSkinId   [playerid] = 0;
                PlayerSkinPrice[playerid] = 0;

                //SetPlayerPosFinish(playerid);
                return 1;
            }

            PlayerSkinId[playerid] = GetPlayerSkin(playerid);

            va_GameTextForPlayer(playerid, "~r~-%d$", 1000, 1,
                skin_price
           );

            // Raspodjela novca Biznis ili Proracun
            if(bizz != INVALID_BIZNIS_ID && bizz < MAX_BIZZES)
                PlayerToBusinessMoneyTAX(playerid, bizz, skin_price); // Ako je igrac u biznisu, novac ide u biznis
            else
                PlayerToBudgetMoney(playerid, skin_price); // Posto je VERONA MALL novac ide u budget

            PlayerAppearance[playerid][pSkin] = PlayerSkinId[playerid];
            ResetBuySkin(playerid);
            //SetPlayerPosFinish(playerid);

            ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Legs", 4.1, 0, 0, 0, 0, 0, 1, 0);

            mysql_fquery(g_SQL, "UPDATE player_appearance SET skin = '%d' WHERE sqlid = '%d'",
                PlayerAppearance[playerid][pSkin],
                PlayerInfo[playerid][pSQLID]
           );

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

CMD:buyskin(playerid, params[])
{
    if(PlayerSkinId[playerid] == 0 || PlayerSkinPrice[playerid] == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne mozete koristiti ovu komandu jer niste izabrali skin na /buy!");
        return 1;
    }

    va_ShowPlayerDialog(playerid, DIALOG_SKINSURE, DIALOG_STYLE_MSGBOX, "Kupovina skina",
        "Zelite li kupiti ovaj skin?\n\tINFO:\nSkinid: %d\nCijena: %d"COL_GREEN"$", "Buy", "Abort",
        GetPlayerSkin(playerid),
        PlayerSkinPrice[playerid]
   );
    return 1;
}

CMD:createvip(playerid, params[])
{
    new
        pick,
        bizz = Player_InBusiness(playerid);

    if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");
    if(bizz == INVALID_BIZNIS_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se unutar biznisa!");
    if(sscanf( params, "i", pick)) return SendClientMessage(playerid, -1, "[?]: /createvip [0-9] (0 za micanje sobe)");
    if(pick < 0 || pick > 9) 
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Input can't be lesser than 0, or larger than 9!");
    
    new
        Float:X, Float:Y,Float:Z;
    GetPlayerPos(playerid, X, Y, Z);

    switch (pick)
    {
        case 0:
        {
            BizzInfo[bizz][bVipType]     = 0;
            BizzInfo[bizz][bVipEnter][0] = 0.0;
            BizzInfo[bizz][bVipEnter][1] = 0.0;
            BizzInfo[bizz][bVipEnter][2] = 0.0;
            BizzInfo[bizz][bVipExit][0]  = 0.0;
            BizzInfo[bizz][bVipExit][1]  = 0.0;
            BizzInfo[bizz][bVipExit][2]  = 0.0;
            
            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
           
            mysql_fquery(g_SQL, "DELETE FROM server_biznis_vips WHERE biznis_id = '%d'", BizzInfo[bizz][bSQLID]);           
            return 1;
        }
        case 1:
        {
            BizzInfo[bizz][bVipType]      = 1;
            BizzInfo[bizz][bVipEnter][0]  = X;
            BizzInfo[bizz][bVipEnter][1]  = Y;
            BizzInfo[bizz][bVipEnter][2]  = Z;
            BizzInfo[bizz][bVipExit][0]   = 1181.6576;
            BizzInfo[bizz][bVipExit][1]   = 7681.1011;
            BizzInfo[bizz][bVipExit][2]   = 2980.4;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);

            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 2:
        {
            BizzInfo[bizz][bVipType]       = 2;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 3324.3752;
            BizzInfo[bizz][bVipExit][1]    = 4321.5127;
            BizzInfo[bizz][bVipExit][2]    = 1000.5;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);

            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 3:
        {
            BizzInfo[bizz][bVipType]       = 3;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 2171.5098;
            BizzInfo[bizz][bVipExit][1]    = -1103.7739;
            BizzInfo[bizz][bVipExit][2]    = 3000.5;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 4:
        {
            BizzInfo[bizz][bVipType]       = 4;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 470.0588;
            BizzInfo[bizz][bVipExit][1]    = -369.2497;
            BizzInfo[bizz][bVipExit][2]    = 998.8359;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 5:
        {
            BizzInfo[bizz][bVipType]       = 5;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 492.3246;
            BizzInfo[bizz][bVipExit][1]    = -36.3570;
            BizzInfo[bizz][bVipExit][2]    = 999.87;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 6:
        {
            BizzInfo[bizz][bVipType]       = 6;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 2085.8906;
            BizzInfo[bizz][bVipExit][1]    = 1303.9072;
            BizzInfo[bizz][bVipExit][2]    = 1501.0859;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 7:
        {
            BizzInfo[bizz][bVipType]       = 7;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 88.1736526;
            BizzInfo[bizz][bVipExit][1]    = 138.5768127;
            BizzInfo[bizz][bVipExit][2]    = 131.1377106;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 8:
        {
            BizzInfo[bizz][bVipType]         = 8;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]      = 136.8911133;
            BizzInfo[bizz][bVipExit][1]      = 173.4578400;
            BizzInfo[bizz][bVipExit][2]      = 75.8140030;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
        case 9:
        {
            BizzInfo[bizz][bVipType]       = 9;
            BizzInfo[bizz][bVipEnter][0]   = X;
            BizzInfo[bizz][bVipEnter][1]   = Y;
            BizzInfo[bizz][bVipEnter][2]   = Z;
            BizzInfo[bizz][bVipExit][0]    = 1529.9977;
            BizzInfo[bizz][bVipExit][1]    = -1617.9247;
            BizzInfo[bizz][bVipExit][2]    = 2000.5590;

            if(IsValidDynamicCP(BizzInfo[bizz][bVipCP]))
                DestroyDynamicCP(BizzInfo[bizz][bVipCP]);
            
            BizzInfo[bizz][bVipCP] = CreateDynamicCP(BizzInfo[bizz][bVipEnter][0], BizzInfo[bizz][bVipEnter][1], BizzInfo[bizz][bVipEnter][2]-1, 3.0, BizzInfo[bizz][bVirtualWorld], BizzInfo[bizz][bInterior], -1, 5.0);
        }
    }
    mysql_fquery_ex(g_SQL, 
        "INSERT INTO server_biznis_vips(biznis_id, type, x, y, z, exit_x, exit_y, exit_z) \n\
            VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
        BizzInfo[bizz][bSQLID],
        BizzInfo[bizz][bVipType],
        BizzInfo[bizz][bVipEnter][0],
        BizzInfo[bizz][bVipEnter][1],
        BizzInfo[bizz][bVipEnter][2],
        BizzInfo[bizz][bVipExit][0],
        BizzInfo[bizz][bVipExit][1],
        BizzInfo[bizz][bVipExit][2]
   );
    return 1;
}

CMD:setfuelprice(playerid, params[])
{
    new bizz, fuelprice;
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "ii", bizz, fuelprice)) return SendClientMessage(playerid, COLOR_RED, "[?]: /setfuelprice [biznisid][naftaprice]");
    if(!Iter_Contains(Business, bizz)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis sa ID-em %d ne postoji na serveru!", bizz);
    if(BizzInfo[bizz][bType] != BIZZ_TYPE_GASSTATION) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis %s[ID %d] nije benzinska postaja!", BizzInfo[bizz][bMessage], bizz);
    if(fuelprice < 1 || fuelprice > 10) return SendClientMessage(playerid, COLOR_RED, "Krivi odabir (1-10)!");

    va_SendClientMessage(playerid, COLOR_RED, "[!] Uspjesno ste postavili cijenu nafte na - "COL_WHITE"%i"COL_YELLOW".", fuelprice);

    BizzInfo[bizz][bGasPrice] = fuelprice;

    mysql_fquery(g_SQL, "UPDATE bizzes SET gasprice = '%d' WHERE id = '%d'", fuelprice, BizzInfo[bizz][bSQLID]);
    return 1;
}

CMD:bizint(playerid, params[])
{
    new pick, bizz;
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "ii", bizz, pick)) return SendClientMessage(playerid, COLOR_WHITE, "[?]: /bizint [biznisid][pick] (0 - brisanje)");
    if(pick < 0 || pick > 37) return SendClientMessage(playerid, COLOR_RED, "Krivi odabir (1-37)!");
    if(!Iter_Contains(Business, bizz)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!", bizz);
    // TODO: remove redundant check below, if statement above this check will stop this one from executing if true
    if(bizz > sizeof(BizzInfo) || bizz <= 0) return SendClientMessage(playerid, COLOR_RED, "Pogresan biznis ID!");

    switch (pick)
    {
        case 0:
        {
            BizzInfo[bizz][bExitX] = 0.0;
            BizzInfo[bizz][bExitY] = 0.0;
            BizzInfo[bizz][bExitZ] = 0.0;
            BizzInfo[bizz][bInterior] = 0;
        }
        case 1:
        {
            BizzInfo[bizz][bExitX] = 454.973937;
            BizzInfo[bizz][bExitY] = -110.104995;
            BizzInfo[bizz][bExitZ] = 1000.077209;
            BizzInfo[bizz][bInterior] = 5;
        }
        case 2:
        {
            BizzInfo[bizz][bExitX] = 457.304748;
            BizzInfo[bizz][bExitY] = -88.428497;
            BizzInfo[bizz][bExitZ] = 999.554687;
            BizzInfo[bizz][bInterior] = 4;
        }
        case 3:
        {
            BizzInfo[bizz][bExitX] = 375.962463;
            BizzInfo[bizz][bExitY] = -65.816848;
            BizzInfo[bizz][bExitZ] = 1001.507812;
            BizzInfo[bizz][bInterior] = 10;
        }
        case 4:
        {
            BizzInfo[bizz][bExitX] = 369.579528;
            BizzInfo[bizz][bExitY] = -4.487294;
            BizzInfo[bizz][bExitZ] = 1001.858886;
            BizzInfo[bizz][bInterior] = 9;
        }
        case 5:
        {
            BizzInfo[bizz][bExitX] = 373.825653;
            BizzInfo[bizz][bExitY] = -117.270904;
            BizzInfo[bizz][bExitZ] = 1001.499511;
            BizzInfo[bizz][bInterior] = 5;
        }
        case 6:
        {
            BizzInfo[bizz][bExitX] = 381.169189;
            BizzInfo[bizz][bExitY] = -188.803024;
            BizzInfo[bizz][bExitZ] = 1000.632812;
            BizzInfo[bizz][bInterior] = 17;
        }
        case 7:
        {
            BizzInfo[bizz][bExitX] = -794.806396;
            BizzInfo[bizz][bExitY] = 497.738037;
            BizzInfo[bizz][bExitZ] = 1376.195312;
            BizzInfo[bizz][bInterior] = 1;
        }
        case 8:
        {
            BizzInfo[bizz][bExitX] = 501.980987;
            BizzInfo[bizz][bExitY] = -69.150199;
            BizzInfo[bizz][bExitZ] = 998.757812;
            BizzInfo[bizz][bInterior] = 11;
        }
        case 9:
        {
            BizzInfo[bizz][bExitX] = -227.027999;
            BizzInfo[bizz][bExitY] = 1401.229980;
            BizzInfo[bizz][bExitZ] = 27.765625;
            BizzInfo[bizz][bInterior] = 18;
        }
        case 10:
        {
            BizzInfo[bizz][bExitX] = 681.557861;
            BizzInfo[bizz][bExitY] = -455.680053;
            BizzInfo[bizz][bExitZ] = -25.609874;
            BizzInfo[bizz][bInterior] = 1;
        }
        case 11:
        {
            BizzInfo[bizz][bExitX] = 1212.019897;
            BizzInfo[bizz][bExitY] = -28.663099;
            BizzInfo[bizz][bExitZ] = 1000.953125;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 12:
        {
            BizzInfo[bizz][bExitX] = 761.412963;
            BizzInfo[bizz][bExitY] = 1440.191650;
            BizzInfo[bizz][bExitZ] = 1102.703125;
            BizzInfo[bizz][bInterior] = 6;
        }
        case 13:
        {
            BizzInfo[bizz][bExitX] = 1204.809936;
            BizzInfo[bizz][bExitY] = -11.586799;
            BizzInfo[bizz][bExitZ] = 1000.921875;
            BizzInfo[bizz][bInterior] = 2;
        }
        case 14:
        {
            BizzInfo[bizz][bExitX] = 942.171997;
            BizzInfo[bizz][bExitY] = -16.542755;
            BizzInfo[bizz][bExitZ] = 1000.929687;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 15:
        {
            BizzInfo[bizz][bExitX] = 964.106994;
            BizzInfo[bizz][bExitY] = -53.205497;
            BizzInfo[bizz][bExitZ] = 1001.124572;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 16:
        {
            BizzInfo[bizz][bExitX] = -2640.762939;
            BizzInfo[bizz][bExitY] = 1406.682006;
            BizzInfo[bizz][bExitZ] = 906.460937;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 17:
        {
            BizzInfo[bizz][bExitX] = 493.390991;
            BizzInfo[bizz][bExitY] = -22.722799;
            BizzInfo[bizz][bExitZ] = 1000.679687;
            BizzInfo[bizz][bInterior] = 17;
        }
        case 18:
        {
            BizzInfo[bizz][bExitX] = -25.884498;
            BizzInfo[bizz][bExitY] = -185.868988;
            BizzInfo[bizz][bExitZ] = 1003.546875;
            BizzInfo[bizz][bInterior] = 17;
        }
        case 19:
        {
            BizzInfo[bizz][bExitX] = -27.312299;
            BizzInfo[bizz][bExitY] = -29.277599;
            BizzInfo[bizz][bExitZ] = 1003.557250;
            BizzInfo[bizz][bInterior] = 4;
        }
        case 20:
        {
            BizzInfo[bizz][bExitX] = -103.559165;
            BizzInfo[bizz][bExitY] = -24.225606;
            BizzInfo[bizz][bExitZ] = 1000.718750;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 21:
        {
            BizzInfo[bizz][bExitX] = -2240.468505;
            BizzInfo[bizz][bExitY] = 137.060440;
            BizzInfo[bizz][bExitZ] = 1035.414062;
            BizzInfo[bizz][bInterior] = 6;
        }
        case 22:
        {
            BizzInfo[bizz][bExitX] = 663.836242;
            BizzInfo[bizz][bExitY] = -575.605407;
            BizzInfo[bizz][bExitZ] = 16.343263;
            BizzInfo[bizz][bInterior] = 0;
        }
        case 23:
        {
            BizzInfo[bizz][bExitX] = 772.111999;
            BizzInfo[bizz][bExitY] = -3.898649;
            BizzInfo[bizz][bExitZ] = 1000.728820;
            BizzInfo[bizz][bInterior] = 5;
        }
        case 24:
        {
            BizzInfo[bizz][bExitX] = 773.579956;
            BizzInfo[bizz][bExitY] = -77.096694;
            BizzInfo[bizz][bExitZ] = 1000.655029;
            BizzInfo[bizz][bInterior] = 7;
        }
        case 25:
        {
            BizzInfo[bizz][bExitX] = 774.213989;
            BizzInfo[bizz][bExitY] = -48.924297;
            BizzInfo[bizz][bExitZ] = 1000.585937;
            BizzInfo[bizz][bInterior] = 6;
        }
        case 26:
        {
            BizzInfo[bizz][bExitX] = -204.439987;
            BizzInfo[bizz][bExitY] = -26.453998;
            BizzInfo[bizz][bExitZ] = 1002.273437;
            BizzInfo[bizz][bInterior] = 16;
        }
        case 27:
        {
            BizzInfo[bizz][bExitX] = -204.439987;
            BizzInfo[bizz][bExitY] = -8.469599;
            BizzInfo[bizz][bExitZ] = 1002.273437;
            BizzInfo[bizz][bInterior] = 17;
        }
        case 28:
        {
            BizzInfo[bizz][bExitX] = -204.439987;
            BizzInfo[bizz][bExitY] = -43.652496;
            BizzInfo[bizz][bExitZ] = 1002.273437;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 29:
        {
            BizzInfo[bizz][bExitX] = 411.625976;
            BizzInfo[bizz][bExitY] = -21.433298;
            BizzInfo[bizz][bExitZ] = 1001.804687;
            BizzInfo[bizz][bInterior] = 2;
        }
        case 30:
        {
            BizzInfo[bizz][bExitX] = 418.652984;
            BizzInfo[bizz][bExitY] = -82.639793;
            BizzInfo[bizz][bExitZ] = 1001.804687;
            BizzInfo[bizz][bInterior] = 3;
        }
        case 31:
        {
            BizzInfo[bizz][bExitX] = 412.021972;
            BizzInfo[bizz][bExitY] = -52.649898;
            BizzInfo[bizz][bExitZ] = 1001.898437;
            BizzInfo[bizz][bInterior] = 12;
        }
        case 32:
        {
            BizzInfo[bizz][bExitX] = 412.021972;
            BizzInfo[bizz][bExitY] = -52.649898;
            BizzInfo[bizz][bExitZ] = 1001.898437;
            BizzInfo[bizz][bInterior] = 12;
        }
        case 33:
        {
            BizzInfo[bizz][bExitX] = 396.4576;
            BizzInfo[bizz][bExitY] = -1793.2319;
            BizzInfo[bizz][bExitZ] = -54.7219;
            BizzInfo[bizz][bInterior] = 66;
        }
        case 34:
        {
            BizzInfo[bizz][bExitX] = 88.9655;
            BizzInfo[bizz][bExitY] = -233.9642;
            BizzInfo[bizz][bExitZ] = 1603.6210;
            BizzInfo[bizz][bInterior] = 66;
        }
        case 35:
        {
            BizzInfo[bizz][bExitX] = -455.9629;
            BizzInfo[bizz][bExitY] = 2189.4355;
            BizzInfo[bizz][bExitZ] = 1501.0890;
            BizzInfo[bizz][bInterior] = 66;
        }
        case 36:
        {
            BizzInfo[bizz][bExitX] = 2844.3787;
            BizzInfo[bizz][bExitY] = 126.7354;
            BizzInfo[bizz][bExitZ] = 809.6970;
            BizzInfo[bizz][bInterior] = 66;
        }
        case 37:
        {
            BizzInfo[bizz][bExitX] = 86.6998;
            BizzInfo[bizz][bExitY] = 213.6764;
            BizzInfo[bizz][bExitZ] = 1201.2959;
            BizzInfo[bizz][bInterior] = 66;
        }
    }

    va_SendClientMessage(playerid, COLOR_YELLOW, "[!]  Uspjesno ste postavili id interiora, biznis id - "COL_WHITE"%i"COL_YELLOW".", bizz);

    BizzInfo[bizz][bVirtualWorld] = BizzInfo[bizz][bInterior] + BizzInfo[bizz][bSQLID];
    BizzInfo[bizz][bCanEnter] = 1;

    mysql_fquery(g_SQL, "UPDATE bizzes SET exitx = '%f', exity = '%f', exitz = '%f',\n\
        interior = '%d', virtualworld = '%d', canenter = '%d' WHERE id = '%d'",
        BizzInfo[bizz][bExitX],
        BizzInfo[bizz][bExitY],
        BizzInfo[bizz][bExitZ],
        BizzInfo[bizz][bInterior],
        BizzInfo[bizz][bVirtualWorld],
        BizzInfo[bizz][bCanEnter],
        BizzInfo[bizz][bSQLID]
   );

    return 1;
}

CMD:custombizint(playerid, params[])
{
    new
        bizz, bint, bviwo,
        Float:iX, Float:iY, Float:iZ;
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "iiifff", bizz, bint, bviwo, iX, iY, iZ))
    {
        SendClientMessage(playerid, COLOR_WHITE, "[?]: /custombizint [bizid][Interior ID][Virtual World ID][X][Y][Z]");
        return 1;
    }
    if(!Iter_Contains(Business, bizz)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!", bizz);

    BizzInfo[bizz][bExitX] = iX;
    BizzInfo[bizz][bExitY] = iY;
    BizzInfo[bizz][bExitZ] = iZ;
    BizzInfo[bizz][bInterior] = bint;
    BizzInfo[bizz][bVirtualWorld] = bviwo;

    if(!BizzInfo[bizz][bCanEnter])
        BizzInfo[bizz][bCanEnter] = 1;

    mysql_fquery(g_SQL, "UPDATE bizzes SET exitx = '%f', exity = '%f', exitz = '%f',\n\ 
        interior = '%d', virtualworld = '%d', canenter = '%d' WHERE id = '%d'",
        BizzInfo[bizz][bExitX],
        BizzInfo[bizz][bExitY],
        BizzInfo[bizz][bExitZ],
        BizzInfo[bizz][bInterior],
        BizzInfo[bizz][bVirtualWorld],
        BizzInfo[bizz][bCanEnter],
        BizzInfo[bizz][bSQLID]
   );

    return 1;
}

CMD:biznis(playerid, params[])
{
    new
        bizz = PlayerKeys[playerid][pBizzKey];
    if(bizz == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujete biznis!");
    if(!IsPlayerInRangeOfPoint(playerid, 20.0, BizzInfo[bizz][bEntranceX], BizzInfo[bizz][bEntranceY], BizzInfo[bizz][bEntranceZ]))
        return va_SendClientMessage(playerid, COLOR_RED, "Niste blizu svoga biznisa (%s)!", BizzInfo[bizz][bMessage]);

    if(BizzInfo[bizz][bType] == BIZZ_TYPE_DUCAN)
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
    else if(BizzInfo[bizz][bType] == BIZZ_TYPE_BAR || BizzInfo[bizz][bType] == BIZZ_TYPE_STRIP)
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
    else if(BizzInfo[bizz][bType] == BIZZ_TYPE_GASSTATION)
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
    else
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nVrata\nRekonstrukcija biznisa($20.000)\nCijena produkta\nIme Biznisa\nProdaj biznis igracu", "Choose","Exit");
    return 1;
}

CMD:menu(playerid, params[])
{
    if(AntiSpamInfo[playerid][asBuying] > gettime()) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BUY_TIME);

    new
        bizz = Player_InBusiness(playerid);
    if(bizz != INVALID_BIZNIS_ID && BizzInfo[bizz][bType] == BIZZ_TYPE_BAR)
    {
        va_ShowPlayerDialog(playerid, DIALOG_BIZNIS_BUYING, DIALOG_STYLE_LIST, "PONUDA PICA", "%s", "Popij", "Abort", GetStoreProducts(bizz));
        AntiSpamInfo[playerid][asBuying] = gettime() + ANTI_SPAM_BUY_TIME;
    }
    else
    {
        if(IsPlayerInRangeOfPoint(playerid, 30.0, 368.9718,-6.6316,1001.8516))                          // Cluckin' Bell
            ShowPlayerDialog(playerid,DIALOG_CHICKENMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Topli sendvic 5$\nCevapi 4$\nFileti 4$\nVocna salata 2$\nKebab 4$\nSprite 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 1009.3359,172.7221,5101.7158))
            ShowPlayerDialog(playerid,DIALOG_CHICKENMENU, DIALOG_STYLE_LIST, "PONUDA JELA","Topli sendvic 5$\nCevapi 4$\nFileti 4$\nVocna salata 2$\nKebab 4$\nSprite 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 375.3066,-118.8028,1001.4995))                     // Well Stacked Pizza
            ShowPlayerDialog(playerid,DIALOG_PIZZAMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Pizzeta 3$\nVelika Pizza 6$\nTopli Sendvic 5$\nSalata 2$\nJumbo Pizza 10$\nSprite 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 376.5994,-67.4428,1001.5078) || IsPlayerInRangeOfPoint(playerid,5,1083.3365,-1455.3883,15.7981))                 // Burgershot
            ShowPlayerDialog(playerid,DIALOG_BURGERMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Big Mac 6$\nBurger Menu 8$\nToast 4$\nFrancuska salata 2$\nSendvic-Sunka 4$\nSprite 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 445.0006,-87.1238,999.5547) || IsPlayerInRangeOfPoint(playerid,15.0,98.5248,226.6844,1197.0959))                         // Restaurant 1
            ShowPlayerDialog(playerid,DIALOG_RESTORANMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Juha 3$\nPiletina 5$\nMorski pas 7$\nSpageti 4$\nKolac 2$\nCoca Cola 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, -786.0226,500.5655,1371.7422) || IsPlayerInRangeOfPoint(playerid,10.0,1086.3999, -1526.8717, 21.9457)) // Restaurant 2
            ShowPlayerDialog(playerid,DIALOG_RESTORANMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Juha 3$\nPiletina 5$\nMorski pas 7$\nSpageti 4$\nKolac 2$\nCoca Cola 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 376.7064,-186.0483,1000.6328) || IsPlayerInRangeOfPoint(playerid,5,1086.1937,-1526.4916,22.7417))                                                                                        // Donut Shop
            ShowPlayerDialog(playerid,DIALOG_DONUTMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Krofna s visnjom 2$\nPunjena krofna 4$\nKrofna s kokosom 4$\nCokoladna krofna 3$\nCoca Cola 3$\nVoda 1$","Buy","Exit");

        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 1840.8169,-1563.9172,2001.2463))                                                                                     // Donut Shop
            ShowPlayerDialog(playerid,DIALOG_JAILMENU,DIALOG_STYLE_LIST,"ZATVORSKA KUHINJA","Mahune\nGrah\nPoriluk","Uzmi","Exit");

        AntiSpamInfo[playerid][asBuying] = gettime() + ANTI_SPAM_BUY_TIME;
    }
    return 1;
}

CMD:buybiznis(playerid, params[])
{
    if(PlayerKeys[playerid][pBizzKey] != INVALID_BIZNIS_ID) 
        return SendClientMessage(playerid, COLOR_RED, "Vec posjedujete biznis!");
    new bizz = Player_InfrontBizz(playerid);
    if(bizz == INVALID_BIZNIS_ID)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not near any business!");

    if(PlayerInfo[playerid][pLevel] < BizzInfo[bizz][bLevelNeeded])
        return va_SendClientMessage(playerid, COLOR_LIGHTRED, "Moras biti level %d da bi kupio biznis!", BizzInfo[bizz][bLevelNeeded]);
    if(BizzInfo[bizz][bType] == BIZZ_TYPE_BYCITY)
        return SendClientMessage(playerid, COLOR_RED, "Ne mozete kupiti biznis jer je u posjedu grada!");
    if(CalculatePlayerBuyMoney(playerid, BUY_TYPE_BIZZ) < BizzInfo[bizz][bBuyPrice])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za kupovinu ovog biznisa!");

    Player_SetBuyPrice(playerid, BizzInfo[bizz][bBuyPrice]);
    GetPlayerPaymentOption(playerid, BUY_TYPE_BIZZ);
    return 1;
}

CMD:buy(playerid, params[])
{
    if(IsPlayerInRangeOfPoint( playerid, 10.0, 1094.0679, -1453.3447, 14.7900))
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo\nMaskice za mobitel", "Choose", "Abort");
    else if(IsPlayerInRangeOfPoint(playerid, 15.0, 1158.3975, -1444.1554, 14.7425))
        ShowPlayerDialog(playerid, DIALOG_MALL_BUY, DIALOG_STYLE_LIST, "VERONA MALL 24/7", "Kockica (1$)\nCoca Cola (5$)\nSat (10$)\nMaska (500$)\nCigarete (10$)\nUpaljac(5$)\nKazetofon\nKonop\nPalica (50$)\nFotoaparat (100$)\nSpray (50$)\nBon za mobitel (25$)\nRadio (1500$)\nToolkit (300$)", "Choose", "Abort");
    else if(IsPlayerInRangeOfPoint(playerid, 15.0, 2294.9822, -2042.7246, 12.6173)) // ne valja ovo!! stara mehanicarska je ovo 24/7
        ShowPlayerDialog(playerid, DIALOG_MALL_BUY, DIALOG_STYLE_LIST, "MECHANIC 24/7", "Kockica (1$)\nCoca Cola (5$)\nSat (10$)\nMaska (500$)\nCigarete (10$)\nUpaljac(5$)\nKazetofon\nKonop\nPalica (50$)\nFotoaparat (100$)\nSpray (50$)\nBon za mobitel (25$)\nRadio (1500$)\nToolkit (300$)", "Choose", "Abort");
    else if(IsPlayerInRangeOfPoint(playerid, 15, 2521.7654, -1323.6298, 33.6071))
        ShowPlayerDialog(playerid, DIALOG_FAKE_BUY, DIALOG_STYLE_LIST, "Fake goods", "Fake weapon license\nFake ID", "Choose", "Abort");
    else if(IsPlayerInRangeOfPoint(playerid, 15.0, 1096.0909, -1440.6428, 14.7926))
    {
        SetPlayerPos(playerid, 1093.4979, -1436.0308, 15.7300);
        SetPlayerFacingAngle(playerid, 25.9367);
        SetPlayerCameraPos(playerid, 1093.4749, -1438.1703, 15.7253);
        SetPlayerCameraLookAt(playerid, 1093.4979, -1436.0308, 15.7300);
        TogglePlayerControllable(playerid, 0);
        SetPlayerVirtualWorld(playerid, playerid);
        PlayerSkinStore[playerid] = 5;
        ShowSkinModelDialog(playerid);
    }
    else
    {
        new 
            bizz = Player_InBusiness(playerid);
        if(!Iter_Contains(Business, bizz))
        {
            SendClientMessage(playerid, COLOR_RED, "Niste u biznisu!");
            return 1;
        }

        // TODO: All of this can be made more dynamic... load a business type, load business articles...
        // save positions/angles/ints/camera pos to a table and load that...
        // then, based on bizz type, ofc, execute "hardcoded" things in gamemode, but make it as generic as possible
        switch (BizzInfo[bizz][bType])
        {
            case BIZZ_TYPE_DUCAN:
            {

                if(AntiSpamInfo[playerid][asBuying] > gettime()) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BUY_TIME);

                new string[870];
                format(string, sizeof(string), "%s", GetStoreProducts(Player_InBusiness(playerid)));
                if(isnull(string)) return SendClientMessage(playerid, COLOR_RED, "[!]  Prodavaonica nije napravila ponudu artikala!");

                ShowPlayerDialog(playerid, DIALOG_BIZNIS_BUYING, DIALOG_STYLE_LIST, "KUPOVINA", string, "Buy", "Abort");
                AntiSpamInfo[playerid][asBuying] = gettime() + ANTI_SPAM_BUY_TIME;
            }
            case BIZZ_TYPE_SUBURBAN, BIZZ_TYPE_PROLAPS, BIZZ_TYPE_ZIP, BIZZ_TYPE_BINCO:
            {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, 161.4402,-84.7554,1001.8047))
                {   // Zip
                    SetPlayerPos(playerid, 154.9184,-76.7528,1001.8047);
                    SetPlayerFacingAngle(playerid, 25.9367);
                    SetPlayerCameraPos(playerid, 156.5948,-78.3780,1001.8047);
                    SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
                    TogglePlayerControllable(playerid, 0);
                    SetPlayerVirtualWorld(playerid, playerid);
                    PlayerSkinStore[playerid] = 1;
                    ShowSkinModelDialog(playerid);
                }
                else if(IsPlayerInRangeOfPoint(playerid, 3.0, 207.5430,-101.4424,1005.2578))
                {   // Binco
                    SetPlayerPos(playerid, 203.3475,-102.3842,1005.2578);
                    SetPlayerFacingAngle(playerid, 49.7479);
                    SetPlayerCameraPos(playerid, 204.4864,-99.6000,1006.3055);
                    SetPlayerCameraLookAt(playerid, 202.9444,-101.8738,1005.2578);
                    //SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
                    TogglePlayerControllable(playerid, 0);
                    SetPlayerVirtualWorld(playerid, playerid);
                    PlayerSkinStore[playerid] = 2;
                    ShowSkinModelDialog(playerid);
                }
                else if(IsPlayerInRangeOfPoint(playerid, 3.0, 207.0127,-129.8306,1003.5078))
                {   // ProLaps
                    SetPlayerPos(playerid, 214.9582,-128.5536,1003.5078);
                    SetPlayerFacingAngle(playerid, 245.5129);
                    SetPlayerCameraPos(playerid, 214.2465,-130.9473,1003.5078);
                    SetPlayerCameraLookAt(playerid, 215.7756,-128.8572,1003.5078);
                    //SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
                    TogglePlayerControllable(playerid, 0);
                    SetPlayerVirtualWorld(playerid, playerid);
                    PlayerSkinStore[playerid] = 3;
                    ShowSkinModelDialog(playerid);
                }
                else if(IsPlayerInRangeOfPoint(playerid, 3.0, 203.8190,-43.9678,1001.8047))
                {   // Suburban
                    SetPlayerPos(playerid, 209.0007,-43.0058,1001.8047);
                    SetPlayerFacingAngle(playerid, 137.1454);
                    SetPlayerCameraPos(playerid, 206.1449,-42.4522,1001.8047);
                    SetPlayerCameraLookAt(playerid, 208.1828,-43.6250,1001.8047);
                    //SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
                    TogglePlayerControllable(playerid, 0);
                    SetPlayerVirtualWorld(playerid, playerid);
                    PlayerSkinStore[playerid] = 4;
                    ShowSkinModelDialog(playerid);
                }
                else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u clothing shopu!");
            }
        }
    }
    return 1;
}

CMD:bmusic(playerid, params[])
{
    if(PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID && !Player_IsDJ(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis/nisi DJ!");
        return 1;
    }

    // TODO: why not just reuse PlayerKeys[playerid][pBizzKey] as the index to BizzInfo array?
    new bouse;
    foreach(new i : Business)
    {
        if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
            bouse = i;
    }

    new
        bizz = Player_IsDJ(playerid) ? Player_GetDJBizzKey(playerid) : bouse;

    if(bizz == INVALID_BIZNIS_ID || bizz > MAX_BIZZES)
    {
        return 1;
    }

    if(isnull(BizzInfo[bizz][bMusicURL]))
    {
        ShowPlayerDialog(playerid, DIALOG_BIZNIS_MUSIC, DIALOG_STYLE_INPUT, "BIZNIS MUSIC", "Unesite live streaming link.\nNPR. shoutcast, listen2myradio, ...", "Input", "Abort");
    }
    else
    {
        foreach(new i : Player)
        {
            if(IsPlayerInRangeOfPoint(i, 80.0, BizzInfo[bizz][bExitX], BizzInfo[bizz][bExitY], BizzInfo[bizz][bExitZ]))
                StopAudioStreamForPlayer(i);
        }
        BizzInfo[bizz][bMusicURL][0] = '\0';
    }
    return 1;
}

CMD:makedj(playerid, params[])
{
    if(PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis!");

    new
        bizz = Player_InBusiness(playerid),
        giveplayerid;

    // TODO: why not just reuse PlayerKeys[playerid][pBizzKey] as the index to BizzInfo array?
    new bouse;
    foreach(new i : Business)
    {
        if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
        bouse = i;
    }

    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "[?]: /makedj [DioImena/Playerid]");
    if(bizz == INVALID_BIZNIS_ID || bizz != bouse) return SendClientMessage(playerid, COLOR_RED, "Niste unutar svojeg biznisa!");

    // TODO: DJ variable is not saved anywhere. Remove this from businesses and instead make DJ a profession/job
    // Then, link that profession to a business (this might need extending the "Player/Char" enumerator/system)
    if(Player_IsDJ(giveplayerid))
    {
        Player_SetIsDJ(giveplayerid, false);
        Player_SetDJBizzKey(giveplayerid, INVALID_BIZNIS_ID);
        SendClientMessage(giveplayerid, COLOR_RED, "[!]  Vise niste zaposleni kao DJ!");
    }
    else
    {
        Player_SetIsDJ(giveplayerid, true);
        Player_SetDJBizzKey(giveplayerid, bizz);

        va_SendClientMessage(playerid, COLOR_YELLOW, "[!]  Zaposlio si %s kao novog DJ-a!", GetName(giveplayerid, true));
        va_SendClientMessage(giveplayerid, COLOR_YELLOW, "[!]  %s te je zaposlio kao svoga DJ-a!", GetName(playerid, true));
    }
    return 1;
}

CMD:bizentrance(playerid, params[])
{
    new proplev;
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi 1338!");
    if(sscanf(params, "i", proplev)) return SendClientMessage(playerid, COLOR_WHITE, "[?]: /bizentrance [bizid] - izmjena ulaza biznisa");
    if(!Iter_Contains(Business, proplev))
        return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!", proplev);

    new
        Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid,X,Y,Z);

    BizzInfo[proplev][bEntranceX] = X;
    BizzInfo[proplev][bEntranceY] = Y;
    BizzInfo[proplev][bEntranceZ] = Z;

    DestroyDynamicPickup(BizzInfo[proplev][bEnterPickup]);
    BizzInfo[proplev][bEnterPickup] = CreateDynamicPickup(1272, 2, BizzInfo[proplev][bEntranceX], BizzInfo[proplev][bEntranceY], BizzInfo[proplev][bEntranceZ], -1, -1, -1, 100.0);

    Streamer_SetFloatData(STREAMER_TYPE_CP, BizzInfo[proplev][bEnterCP], E_STREAMER_X, BizzInfo[proplev][bEntranceX]);
    Streamer_SetFloatData(STREAMER_TYPE_CP, BizzInfo[proplev][bEnterCP], E_STREAMER_Y, BizzInfo[proplev][bEntranceY]);
    Streamer_SetFloatData(STREAMER_TYPE_CP, BizzInfo[proplev][bEnterCP], E_STREAMER_Z, BizzInfo[proplev][bEntranceZ]);
    Streamer_Update(playerid);

    new
        string[92];

    format(string,sizeof(string),"[ADMIN]: %s je premjestio biznis [%d] na [%f - %f - %f].",
        GetName(playerid, false),
        proplev,
        X,
        Y,
        Z
   );
    ABroadCast(COLOR_LIGHTRED, string, 4);

    mysql_fquery(g_SQL, "UPDATE bizzes SET entrancex = '%f', entrancey = '%f', entrancez = '%f' WHERE id = '%d'",
        X,
        Y,
        Z,
        BizzInfo[proplev][bSQLID]
   );

    return 1;
}

CMD:bizinfo(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Nisi administrator!");

    new bizz = Player_InfrontBizz(playerid);
    if(bizz == INVALID_BIZNIS_ID) 
        return SendClientMessage(playerid, COLOR_RED, "You are not near any business!");

    va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Bizz ID: %d | Bizz MySQL ID: %d", bizz, BizzInfo[bizz][bSQLID]);
    va_SendClientMessage(playerid, COLOR_RED, "[INFO] Stanje u blagajni biznisa: %d$", BizzInfo[bizz][bTill]);

    if(BizzInfo[bizz][bPriceProd] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Biznis nema definiranu cijenu produkata.");

    va_SendClientMessage(playerid, COLOR_WHITE, "Cijena po produktu: %d", BizzInfo[bizz][bPriceProd]);

    new
        Float:product_ammount = BizzInfo[bizz][bTill] / BizzInfo[bizz][bPriceProd],
        receiving_packages = floatround(product_ammount, floatround_floor);

    if(receiving_packages == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "[INFO] Biznis nije spreman primiti nove produkte (Financijska kriza).");
    }
    else
    {
        va_SendClientMessage(playerid, COLOR_WHITE, "[INFO] Biznis je spreman primiti %d paketa produkata.", receiving_packages);
    }

    if(BizzInfo[bizz][bLocked])
        SendClientMessage(playerid, COLOR_RED, "Zakljucano");
    else
        SendClientMessage(playerid, COLOR_GREEN, "Otkljucano");
    return 1;
}

CMD:bizwithdraw(playerid, params[])
{
    new
        bouse,
        cashdeposit;

    if(PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis.");
        return 1;
    }

    // TODO: why not just reuse PlayerKeys[playerid][pBizzKey] as the index to BizzInfo array?
    foreach(new i : Business)
    {
        if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
        {
            bouse = i;
            break;
        }
    }
    if(sscanf(params, "i", cashdeposit))
    {
        va_SendClientMessage(playerid, COLOR_WHITE, "Imate $%d u vasem biznisu.", BizzInfo[bouse][bTill]);
        SendClientMessage(playerid, COLOR_ORANGE, "[?]: /bizwithdraw [Iznos koliko zelite podici iz biznisa]");
        return 1;
    }
    if(cashdeposit > BizzInfo[bouse][bTill] || cashdeposit < 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Nemate toliko novaca");
        return 1;
    }
    if(!IsPlayerInRangeOfPoint(playerid, 100.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ])
        && BizzInfo[bouse][bCanEnter] == 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Previse si udaljen od biznisa");
        return 1;
    }
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY], BizzInfo[bouse][bEntranceZ])
        && BizzInfo[bouse][bCanEnter] == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Previse si udaljen od biznisa");
        return 1;
    }

    BusinessToPlayerMoney(playerid, bouse, cashdeposit); //Novac iz biznisa ide igraï¿½u

    va_SendClientMessage(playerid, COLOR_RED, "[!]  Podigli ste $%d sa vaseg biznisa. Ukupno: $%d.",
        cashdeposit,
        BizzInfo[bouse][bTill]
   );

    #if defined MODULE_LOGS
    Log_Write("/logfiles/a_biznis.txt", "(%s) %s(%s) took %d$ from Business %s[SQLID: %d].",
        ReturnDate(),
        GetName(playerid, false),
        ReturnPlayerIP(playerid),
        cashdeposit,
        BizzInfo[bouse][bMessage],
        BizzInfo[bouse][bSQLID]
   );
    #endif
    return 1;
}

CMD:bizbank(playerid, params[])
{
    new
        bouse = PlayerKeys[playerid][pBizzKey],
        cashdeposit;

    if(bouse == INVALID_BIZNIS_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis.");
        return 1;
    }
    if(sscanf(params, "i", cashdeposit))
    {
        va_SendClientMessage(playerid, COLOR_GREY, "  Imate $%d u vasem biznisu.", BizzInfo[bouse][bTill]);
        SendClientMessage(playerid, COLOR_WHITE, "[?]: /bizbank [iznos]");
        return 1;
    }
    if(cashdeposit > AC_GetPlayerMoney(playerid) || cashdeposit < 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Nemas toliko novaca");
        return 1;
    }

    PlayerToBusinessMoney(playerid, bouse, cashdeposit); // Novac od igraï¿½a ide u biznis

    va_SendClientMessage(playerid, COLOR_RED, "[!]  Stavio si $%d u tvoj biznis. Ukupno: $%d.",
        cashdeposit,
        BizzInfo[bouse][bTill]
   );

    #if defined MODULE_LOGS
    Log_Write("/logfiles/a_biznis.txt", "(%s) %s(%s) deposited %d$ in Business %s[SQLID: %d].",
        ReturnDate(),
        GetName(playerid, false),
        ReturnPlayerIP(playerid),
        cashdeposit,
        BizzInfo[bouse][bMessage],
        BizzInfo[bouse][bSQLID]
   );
    #endif
    return 1;
}

CMD:createbiz(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not authorized to use this command!");

    new
        level, canenter, price;
    if(sscanf(params, "iii", level, canenter, price))
    {
        SendClientMessage(playerid, COLOR_WHITE, "[?]: /createbiz [level][ulaz][cijena]");
        return 1;
    }
    new Float:x, Float:y, Float:z, freeslot;
    GetPlayerPos(playerid, x, y, z);

    freeslot = Iter_Free(Business);
    FreeBizzID[playerid] = freeslot;
    BizzInfo[freeslot][bOwnerID] = 0;
    BizzInfo[freeslot][bCanEnter] = canenter;
    BizzInfo[freeslot][bLevelNeeded] = level;
    BizzInfo[freeslot][bEntranceX] = x;
    BizzInfo[freeslot][bEntranceY] = y;
    BizzInfo[freeslot][bEntranceZ] = z;
    BizzInfo[freeslot][bBuyPrice] = price;
    BizzInfo[freeslot][bTill] = 0;
    BizzInfo[freeslot][bLocked] = 1;
    BizzInfo[freeslot][bEntranceCost] = 0;
    BizzInfo[freeslot][bDestroyed] = 0;
    BizzInfo[freeslot][bFurSlots] = BIZZ_FURNITURE_VIP_NONE;
    BizzInfo[freeslot][bGasPrice] = 3;
    BizzInfo[freeslot][bEnterPickup] = CreateDynamicPickup(1272, 2, BizzInfo[freeslot][bEntranceX], BizzInfo[freeslot][bEntranceY], BizzInfo[freeslot][bEntranceZ], -1, -1, -1, 100.0);
    CreateBizzEnter(freeslot);

    ShowPlayerDialog(playerid, DIALOG_NEWBIZNIS_NAME, DIALOG_STYLE_INPUT, "Unos imena biznisa:", "Molimo Vas unesite ime novog biznisa.", "Input", "Exit");
    return 1;
}

CMD:deletebiz(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338)
        return SendClientMessage(playerid, COLOR_RED, "Niste Administrator Level 1338");

    new bizz = Player_InfrontBizz(playerid);
    if(bizz == INVALID_BIZNIS_ID)
        return SendClientMessage(playerid, COLOR_RED, "Niste u blizini nijednog biznisa!");

    // TODO: rename, EditingBizzID[playerid]
    FreeBizzID[playerid] = bizz;
    // TODO: va_ShowPlayerDialog
    new removebizstring[128];
    format(removebizstring, sizeof(removebizstring), "Jeste li sigurni da zelite izbrisati %s %s[SQLID: %d]?", GetBiznisType(BizzInfo[bizz][bType]), BizzInfo[bizz][bMessage], BizzInfo[bizz][bSQLID]);
    ShowPlayerDialog(playerid, DIALOG_REMOVE_BIZNIS, DIALOG_STYLE_MSGBOX, "Potvrda brisanja biznisa", removebizstring, "Da", "Ne");
    return 1;
}

CMD:microphone(playerid, params[])
{
    if(PlayerKeys[playerid][pBizzKey] == INVALID_BIZNIS_ID && !Player_IsDJ(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujes biznis/nisi DJ!");

    if(isnull(params))
    {
        SendClientMessage(playerid, COLOR_RED, "[?]: (/mic)rophone  [text]");
        return 1;
    }

    if(PlayerInfo[playerid][pMuted])
    {
        SendClientMessage(playerid, COLOR_RED, "Nemozete pricati, usutkani ste");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    foreach(new i : Player)
    {
        if(!IsPlayerInRangeOfPoint(i, 20.0, x, y, z)) continue;

        PlayerPlaySound(i, 15800, 0, 0, 0);
    }

    new string[256];
    format(string, sizeof(string), "[Deejay %s:o< %s]", GetName(playerid, false), params);
    ProxDetector(60.0, playerid, string,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
    return 1;
}
