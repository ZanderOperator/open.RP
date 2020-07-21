#include <mSelection>
#include <YSI\y_hooks>

#if defined MODULE_BIZNIS
	#endinput
#endif
#define MODULE_BIZNIS
#define CP_TYPE_BIZZ_VIP_ENTRANCE	(3)

/*
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
*/
///////////////////////////////////////////////////////////////////

// Ints
#define MAX_BIZNIS_PRODS					(100)
#define INVALID_PRODUCT_ID					(0)

/*
	######## ##    ## ##     ## ##     ##  ######
	##       ###   ## ##     ## ###   ### ##    ##
	##       ####  ## ##     ## #### #### ##
	######   ## ## ## ##     ## ## ### ##  ######  / Defines...
	##       ##  #### ##     ## ##     ##       ##
	##       ##   ### ##     ## ##     ## ##    ##
	######## ##    ##  #######  ##     ##  ######
*/
///////////////////////////////////////////////////////////////////

#define PRODUCT_WATER  		(100)
#define	PRODUCT_BEER  		(101)
#define	PRODUCT_PEPSI 	 	(102)
#define	PRODUCT_COLA 		(103)
#define	PRODUCT_WINE 		(104)
#define	PRODUCT_CIGARS 		(105)
#define	PRODUCT_BURGERS 	(106)
#define	PRODUCT_CAKE 	 	(107)
#define	PRODUCT_HOTDOG 		(108)
#define	PRODUCT_PIZZA 		(109)
#define	PRODUCT_GROCERIES   (110)
#define	PRODUCT_MASK 	    (111)
#define	PRODUCT_FLOWERS 	(112)
#define	PRODUCT_CAMERA 	 	(113)
#define	PRODUCT_BAT   		(114)
#define	PRODUCT_SPRAY 		(115)
#define	PRODUCT_TOOLKIT 	(116)
#define	PRODUCT_BOOMBOX 	(117)
#define	PRODUCT_PCREDIT 	(118)
#define	PRODUCT_CLOCK 		(119)
#define	PRODUCT_DICE 		(120)
#define	PRODUCT_LIGHTER 	(121)
#define	PRODUCT_ROPE		(122)
#define	PRODUCT_RADIO		(123)

enum {
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

enum {
	BIZZ_TYPE_OTHER   	= 0,
	BIZZ_TYPE_BAR,
	BIZZ_TYPE_STRIP,
	BIZZ_TYPE_RESTORAN,
	BIZZ_TYPE_BURGER,
	BIZZ_TYPE_PIZZA,
	BIZZ_TYPE_CLUCKIN,
	BIZZ_TYPE_DONUT,
	BIZZ_TYPE_DUCAN,
	BIZZ_TYPE_SEXSHOP,
	BIZZ_TYPE_BINCO,
	BIZZ_TYPE_ZIP,
	BIZZ_TYPE_PROLAPS,
	BIZZ_TYPE_SUBURBAN,
	BIZZ_TYPE_BYCITY,
	BIZZ_TYPE_RENTVEH,
	BIZZ_TYPE_CASINO,
	BIZZ_TYPE_DRUGSTORE,
	BIZZ_TYPE_GASSTATION
}
#define MAX_BIZZ_TYPES	(19)
/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/
///////////////////////////////////////////////////////////////////

// TextDraws
static stock
		PlayerText:BiznisBcg1[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:BiznisBcg2[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:BizzInfoText[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:BizzInfoTD[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ...},
		PlayerText:BiznisCMDTD[ MAX_PLAYERS ]		= { PlayerText:INVALID_TEXT_DRAW, ...};

// Player vars
static stock
		Timer:PlayerTDTimer[ MAX_PLAYERS ],
		VeronaSkinRectangle;

// Regular vars
stock
		MODEL_LIST_SKINS = mS_INVALID_LISTID;

// rBits
static stock
		Bit1:	gr_IsADJ				<MAX_PLAYERS>,
		Bit2:	gr_DerivatSlot			<MAX_PLAYERS>,
		Bit4:	gr_ArticleSlot			<MAX_PLAYERS>,
		Bit8:	gr_PlayerSkinPrice		<MAX_PLAYERS>,
		Bit8:	gr_PlayerSkinStore		<MAX_PLAYERS>,
		Bit16:	gr_ArticleIdInput		<MAX_PLAYERS>,
		Bit16:	gr_DJBizKey				<MAX_PLAYERS>,
		Bit16:	gr_PlayerSkinId			<MAX_PLAYERS>;

/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/
///////////////////////////////////////////////////////////////////
/*
	 d888b  d88888b d8b   db d88888b d8888b.  .d8b.  db
	88' Y8b 88'     888o  88 88'     88  `8D d8' `8b 88
	88      88ooooo 88V8o 88 88ooooo 88oobY' 88ooo88 88
	88  ooo 88~~~~~ 88 V8o88 88~~~~~ 88`8b   88~~~88 88
	88. ~8~ 88.     88  V888 88.     88 `88. 88   88 88booo.
	 Y888P  Y88888P VP   V8P Y88888P 88   YD YP   YP Y88888P
*/
stock IsAtBar(playerid)
{
	if( IsPlayerInRangeOfPoint(playerid,25.0,497.7613,-79.9566,998.7651)   		||  // Bar (Large)
		IsPlayerInRangeOfPoint(playerid,25.0,-466.9822,2189.4441,1501.0850)  	||  // Bar (Small-Textured)
		IsPlayerInRangeOfPoint(playerid,25.0,1206.2334,-29.3733,1000.9531) 		||  // Small Strip Club
		IsPlayerInRangeOfPoint(playerid,45.0,502.3909,-19.8775,1000.6797)  		||  // Alhambra
		IsPlayerInRangeOfPoint(playerid,45.0,1215.4012,-15.2610,1000.9219) 		||  // Pig Pen
		IsPlayerInRangeOfPoint(playerid,25.0,-223.3076,1405.6151,27.7734)  		||  // Bar (Small)
		IsPlayerInRangeOfPoint(playerid,25.0,681.4567,-455.4606,-25.6099)  		||  // Zbugani Bar
		IsPlayerInRangeOfPoint(playerid,25.0,-2659.0117,1410.1823,906.277)  	||  // JIZZY
		IsPlayerInRangeOfPoint(playerid,25.0,505.2372,-196.5106,998.8359) 		||  // LITTLE NAPLES
		IsPlayerInRangeOfPoint(playerid,25.0,98.5275,227.0853,1197.0959) 		||  // Turkish Coffee
		IsPlayerInRangeOfPoint(playerid,25.0,2496.2830,999.0912,9201.0859) 		||  // Nocni klub
		IsPlayerInRangeOfPoint(playerid,25.0,1162.6226, -1535.3922, 21.7394) 	||  // Mall Bar
		IsPlayerInRangeOfPoint(playerid,25.0,1197.1238,-904.0923,51.9605) 		||  // BURG GORE
		IsPlayerInRangeOfPoint(playerid,25.0,1002.4330, -1559.1761, 2066.5969) 	||  // The Tune
		IsPlayerInRangeOfPoint(playerid,25.0,985.0701,-1552.1790,21.5078) 		||  // The Tune
		IsPlayerInRangeOfPoint(playerid,25.0,318.5311,1830.4390,1496.1759) 		||
		IsPlayerInRangeOfPoint(playerid,25.0,318.5357,1834.8458,1496.1759) 		||
		IsPlayerInRangeOfPoint(playerid,25.0,968.7755,-46.5383,1001.1172) 		||
		IsPlayerInRangeOfPoint(playerid,25.0,352.9546,1852.4523,1232.3059) 		||  // Regller Disko
		IsPlayerInRangeOfPoint(playerid,25.0,712.2067,186.2624,1000.6660) 		||  // Bar (North Hollywood)
		IsPlayerInRangeOfPoint(playerid,25.0,90.5280, -208.8320, 1603.2111))		// TGB
			return 1;

	return 0;
}

stock IsAt247(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if (IsPlayerInRangeOfPoint(playerid,3.0,-29.0667,-185.1301,1003.54693) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,-23.3532,-55.6378,1003.5469) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,-30.9976,-29.0243,1003.5573) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,2.0486,-29.0126,1003.5494) 		||
			IsPlayerInRangeOfPoint(playerid,3.0,-28.2082,-89.9542,1003.5469) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,1158.1842,-1436.3953,15.7981) 	||
			IsPlayerInRangeOfPoint(playerid,3.0,-491.2163,-52.7071,73.0915)){
			return 1;
		}
 	}
	return 0;
}

stock LoadBizz()
{
	new loadQuery[64];
	format(loadQuery, 64, "SELECT * FROM `bizzes` WHERE 1");
	mysql_tquery(g_SQL, loadQuery, "OnServerBizzesLoad", "");
	return 1;
}

forward OnServerBizzesLoad();
public OnServerBizzesLoad()
{
	if( !cache_num_rows() ) return printf( "MySQL Report: No bizes exist to load." );
	for( new b=0; b < cache_num_rows(); b++ )
	{
		cache_get_value_name_int( b, 	"id"			, BizzInfo[ b ][ bSQLID ]);
		cache_get_value_name_int( b, 	"ownerid"		, BizzInfo[ b ][ bOwnerID ]);
		cache_get_value_name( b,		"message"		, BizzInfo[ b ][bMessage], 16 );
		cache_get_value_name_int( b, 	"canenter"		, BizzInfo[ b ][ bCanEnter ] );
		cache_get_value_name_float( b, 	"entrancex"		, BizzInfo[ b ][ bEntranceX ]);
		cache_get_value_name_float( b, 	"entrancey"		, BizzInfo[ b ][ bEntranceY ]);
		cache_get_value_name_float( b, 	"entrancez"		, BizzInfo[ b ][ bEntranceZ ]);
		cache_get_value_name_float( b, 	"exitx"			, BizzInfo[ b ][ bExitX ]);
		cache_get_value_name_float( b, 	"exity"			, BizzInfo[ b ][ bExitY ]);
		cache_get_value_name_float( b, 	"exitz"			, BizzInfo[ b ][ bExitZ ]);
		cache_get_value_name_int( b, 	"levelneeded"	, BizzInfo[ b ][ bLevelNeeded ]);
		cache_get_value_name_int( b, 	"buyprice"		, BizzInfo[ b ][ bBuyPrice ]);
		cache_get_value_name_int( b, 	"till"			, BizzInfo[ b ][ bTill ]);
		cache_get_value_name_int( b, 	"locked"		, BizzInfo[ b ][ bLocked ]);
		cache_get_value_name_int( b, 	"interior"		, BizzInfo[ b ][ bInterior ]);
		cache_get_value_name_int( b, 	"maxproducts"	, BizzInfo[ b ][ bMaxProducts ]);
		cache_get_value_name_int( b, 	"priceprod"		, BizzInfo[ b ][ bPriceProd ]);
		cache_get_value_name_int( b, 	"virtualworld"	, BizzInfo[ b ][ bVirtualWorld ]);
		cache_get_value_name_int( b, 	"type"			, BizzInfo[ b ][ bType ]);
		cache_get_value_name_int( b, 	"entrancecost"	, BizzInfo[ b ][ bEntranceCost ]);
		cache_get_value_name_int( b, 	"destroyed"		, BizzInfo[ b ][ bDestroyed ]);
		cache_get_value_name_int( b, 	"fur_slots"		, BizzInfo[ b ][ bFurSlots ]);
   		cache_get_value_name_int( b, 	"gasprice"		, BizzInfo[ b ][ bGasPrice ]);

		// External Loads
		LoadBiznisProducts(b);
		LoadBiznisVips(b);
		LoadBiznisFurnitureObjects(b);

		if( BizzInfo[ b ][ bVipEnter ][ 0 ] != 0.0 && BizzInfo[ b ][ bVipEnter ][ 1 ] != 0.0 )
		{
			BizzInfo[  b  ][ bVipCP ] = CreateDynamicCP( BizzInfo[ b ][ bVipEnter ][ 0 ], BizzInfo[ b ][ bVipEnter ][ 1 ], BizzInfo[ b ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ b ][ bVirtualWorld ], BizzInfo[ b ][ bInterior ], -1, 5.0 );
		}

		BizzInfo[ b ][ bEnterPICK ] = CreateDynamicPickup( 1272, 2, BizzInfo[ b ][bEntranceX], BizzInfo[ b ][bEntranceY], BizzInfo[ b ][bEntranceZ], -1, -1, -1, 100.0 );
		Iter_Add(Bizzes, b);
	}
	printf("MySQL Report: Businesses Loaded (%d)!", Iter_Count(Bizzes));
	return 1;
}

stock LoadBiznisProducts(biznisid)
{
	new
		loadProductsQuery[128];
	format(loadProductsQuery, 128, "SELECT * FROM `server_biznis_products` WHERE `biznis_id` = '%d'", BizzInfo[biznisid][bSQLID]);
	mysql_pquery(g_SQL, loadProductsQuery, "OnServerBiznisProductsLoad", "i", biznisid);
	return 1;
}

stock LoadBiznisVips(biznisid)
{
	new
		loadProductsQuery[128];
	format(loadProductsQuery, 128, "SELECT * FROM `server_biznis_vips` WHERE `biznis_id` = '%d' LIMIT 0,1", BizzInfo[biznisid][bSQLID]);
	mysql_pquery(g_SQL, loadProductsQuery, "OnServerVipsLoad", "i", biznisid);
	return 1;
}

forward OnServerBiznisProductsLoad(biznisid);
public OnServerBiznisProductsLoad(biznisid)
{
	if(!cache_num_rows())
		return 0;

	for(new i = 0; i < cache_num_rows(); i++)
	{
		cache_get_value_name_int(i, "id"		, BiznisProducts[biznisid][bpSQLID][i]);
		cache_get_value_name_int(i, "type"		, BiznisProducts[biznisid][bpType][i]);
		cache_get_value_name_int(i, "price"		, BiznisProducts[biznisid][bpPrice][i]);
		cache_get_value_name_int(i, "amount"	, BiznisProducts[biznisid][bpAmount][i]);
	}
	return 1;
}

forward OnServerVipsLoad(biznisid);
public OnServerVipsLoad(biznisid)
{
	if(!cache_num_rows())
		return 0;

	cache_get_value_name_int(0, "type"		, BizzInfo[ biznisid ][ bVipType ]);
	cache_get_value_name_float(0, "x"		, BizzInfo[ biznisid ][ bVipEnter ][ 0 ]);
	cache_get_value_name_float(0, "y"		, BizzInfo[ biznisid ][ bVipEnter ][ 1 ]);
	cache_get_value_name_float(0, "z"		, BizzInfo[ biznisid ][ bVipEnter ][ 2 ]);
	cache_get_value_name_float(0, "exit_x"	, BizzInfo[ biznisid ][ bVipExit ][ 0 ]);
	cache_get_value_name_float(0, "exit_y"	, BizzInfo[ biznisid ][ bVipExit ][ 1 ]);
	cache_get_value_name_float(0, "exit_z"	, BizzInfo[ biznisid ][ bVipExit ][ 2 ]);
	return 1;
}

stock static GetBiznisType(type)
{
	new string[ 14 ];
	switch( type )
	{
		case BIZZ_TYPE_OTHER: 		format(string, 14, "Other" 			);
		case BIZZ_TYPE_BAR:			format(string, 14, "Bar" 			);
		case BIZZ_TYPE_STRIP:   	format(string, 14, "Striptiz Klub" 	);
		case BIZZ_TYPE_RESTORAN:	format(string, 14, "Restoran" 		);
		case BIZZ_TYPE_BURGER:      format(string, 14, "Burger"			);
		case BIZZ_TYPE_PIZZA:       format(string, 14, "Stacked Pizza" 	);
		case BIZZ_TYPE_CLUCKIN:     format(string, 14, "Cluckin' Bell" 	);
		case BIZZ_TYPE_DONUT:       format(string, 14, "Dounat Shop" 	);
		case BIZZ_TYPE_DUCAN:       format(string, 14, "24/7"			);
		case BIZZ_TYPE_SEXSHOP:     format(string, 14, "Sex Shop" 		);
		case BIZZ_TYPE_BINCO:       format(string, 14, "Binco" 			);
		case BIZZ_TYPE_ZIP:	        format(string, 14, "ZIP" 			);
		case BIZZ_TYPE_PROLAPS:     format(string, 14, "Pro Laps" 		);
		case BIZZ_TYPE_SUBURBAN:    format(string, 14, "Suburban" 		);
		case BIZZ_TYPE_BYCITY:      format(string, 14, "Grad" 			);
		case BIZZ_TYPE_RENTVEH:     format(string, 14, "Rent a veh" 	);
		case BIZZ_TYPE_CASINO:      format(string, 14, "Kasino" 		);
		case BIZZ_TYPE_DRUGSTORE:   format(string, 14, "Ljekarna" 		);
		case BIZZ_TYPE_GASSTATION:  format(string, 14, "Benzinska" 		);
		default:
			format(string, 14, "Other" );
	}
	return string;
}

stock static GetBiznisTypeList()
{
	new string[ 20 ];
	new typestring[1028];
	for(new i = 0; i < MAX_BIZZ_TYPES; i++)
	{
		switch( i )
		{
			case BIZZ_TYPE_OTHER: 		format(string, 20, "Other\n" 			);
			case BIZZ_TYPE_BAR:			format(string, 20, "Bar\n" 				);
			case BIZZ_TYPE_STRIP:   	format(string, 20, "Striptiz Klub\n" 	);
			case BIZZ_TYPE_RESTORAN:	format(string, 20, "Restoran\n" 		);
			case BIZZ_TYPE_BURGER:      format(string, 20, "Burger\n"			);
			case BIZZ_TYPE_PIZZA:       format(string, 20, "Stacked Pizza\n" 	);
			case BIZZ_TYPE_CLUCKIN:     format(string, 20, "Cluckin' Bell\n" 	);
			case BIZZ_TYPE_DONUT:       format(string, 20, "Dounat Shop\n"	 	);
			case BIZZ_TYPE_DUCAN:       format(string, 20, "24/7\n"				);
			case BIZZ_TYPE_SEXSHOP:     format(string, 20, "Sex Shop\n" 		);
			case BIZZ_TYPE_BINCO:       format(string, 20, "Binco\n" 			);
			case BIZZ_TYPE_ZIP:	        format(string, 20, "ZIP\n" 				);
			case BIZZ_TYPE_PROLAPS:     format(string, 20, "Pro Laps\n"	 		);
			case BIZZ_TYPE_SUBURBAN:    format(string, 20, "Suburban\n" 		);
			case BIZZ_TYPE_BYCITY:      format(string, 20, "Grad\n" 			);
			case BIZZ_TYPE_RENTVEH:     format(string, 20, "Rent a veh\n"	 	);
			case BIZZ_TYPE_CASINO:      format(string, 20, "Kasino\n"	 		);
			case BIZZ_TYPE_DRUGSTORE:   format(string, 20, "Ljekarna\n"			);
			case BIZZ_TYPE_GASSTATION:  format(string, 20, "Benzinska"		);
		}
		strcat(typestring, string, sizeof(typestring));
	}
	return typestring;
}

stock static PrintBizInfo(playerid,targetid)
{
    new
		infoString[ 68 ];

	SendClientMessage(playerid, COLOR_LIGHTBLUE,"_______________________________________");
	format(infoString, sizeof(infoString), "Naziv biznisa: %s | Vlasnik: %s", BizzInfo[targetid][bMessage], GetPlayerNameFromSQL(BizzInfo[targetid][bOwnerID]));
	SendClientMessage(playerid, -1,infoString);

	format(infoString, sizeof(infoString), "Novac u Blagajni: %d | Cijena usluge: %d", BizzInfo[targetid][bTill], BizzInfo[targetid][bEntranceCost]);
	SendClientMessage(playerid, -1,infoString);
	format(infoString, sizeof(infoString), "Cijena: %d | Level: %d", BizzInfo[targetid][bBuyPrice],BizzInfo[targetid][bLevelNeeded]);
	SendClientMessage(playerid, -1,infoString);

	if( BizzInfo[targetid][bLocked] )
		SendClientMessage(playerid, COLOR_RED, "Zakljucano");
	else
		SendClientMessage(playerid, COLOR_RED, "Otkljucano");


	switch(BizzInfo[ targetid ][ bType ])
	{
		case BIZZ_TYPE_DUCAN:
		{
			format(infoString, sizeof(infoString), "Artikl #1: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 0 ] ),
				BiznisProducts[targetid][bpAmount][ 0 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #2: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 1 ] ),
				BiznisProducts[targetid][bpAmount][ 1 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #3: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 2 ] ),
				BiznisProducts[targetid][bpAmount][ 2 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #4: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 3 ] ),
				BiznisProducts[targetid][bpAmount][ 3 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #5: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 4 ] ),
				BiznisProducts[targetid][bpAmount][ 4 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #6: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 5 ] ),
				BiznisProducts[targetid][bpAmount][ 5 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #7: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 6 ] ),
				BiznisProducts[targetid][bpAmount][ 6 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #8: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 7 ] ),
				BiznisProducts[targetid][bpAmount][ 7 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #9: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 8 ] ),
				BiznisProducts[targetid][bpAmount][ 8 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #10: %s [%d/%d]",
				GetStoreProductName( BiznisProducts[targetid][bpType][ 9 ] ),
				BiznisProducts[targetid][bpAmount][ 9 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
		}
		case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
		{
			format(infoString, sizeof(infoString), "Artikl #1: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 0 ] ),
				BiznisProducts[targetid][bpAmount][ 0 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #2: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 1 ] ),
				BiznisProducts[targetid][bpAmount][ 1 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #3: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 2 ] ),
				BiznisProducts[targetid][bpAmount][ 2 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #4: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 3 ] ),
				BiznisProducts[targetid][bpAmount][ 3 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #5: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 4 ] ),
				BiznisProducts[targetid][bpAmount][ 4 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #6: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 5 ] ),
				BiznisProducts[targetid][bpAmount][ 5 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #7: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 6 ] ),
				BiznisProducts[targetid][bpAmount][ 6 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #8: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 7 ] ),
				BiznisProducts[targetid][bpAmount][ 7 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #9: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 8 ] ),
				BiznisProducts[targetid][bpAmount][ 8 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
			format(infoString, sizeof(infoString), "Artikl #10: %s [%d/%d]",
				GetDrinkName( BiznisProducts[targetid][bpType][ 9 ] ),
				BiznisProducts[targetid][bpAmount][ 9 ],
				BizzInfo[ targetid ][ bMaxProducts ] );
			SendClientMessage(playerid, -1,infoString);
		}
		default: SendClientMessage(playerid, -1, "Ovaj biznis nema artikala.");

	}
	format(infoString, sizeof(infoString), "Cijena produkta: %d", BizzInfo[targetid][bPriceProd]);
	SendClientMessage(playerid, -1,infoString);

	switch( BizzInfo[ targetid ][ bDestroyed ] ) {
		case 0: SendClientMessage(playerid, COLOR_RED, 		"Status: Radi normalno");
		case 1: SendClientMessage(playerid, COLOR_RED, 	"Status: Unisteni izlozi i prozori.");
		case 2: SendClientMessage(playerid, COLOR_RED, 	"Status: Unisteni izlozi, prozori i cjelokupan interijer.");
		case 3: SendClientMessage(playerid, COLOR_RED, 	"Status: Totalno unisten!");
	}
}

stock static CreateBizzInfoTD(playerid)
{
	DestroyBizzInfoTD(playerid);
	BiznisBcg1[playerid] = CreatePlayerTextDraw(playerid, 639.612121, 116.752761, "usebox");
	PlayerTextDrawLetterSize(playerid, 		BiznisBcg1[playerid], 0.000000, 10.236042);
	PlayerTextDrawTextSize(playerid, 		BiznisBcg1[playerid], 497.499877, 0.000000);
	PlayerTextDrawAlignment(playerid, 		BiznisBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, 			BiznisBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, 			BiznisBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, 		BiznisBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 		BiznisBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		BiznisBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, 			BiznisBcg1[playerid], 0);
	PlayerTextDrawShow(playerid,			BiznisBcg1[playerid]);

	BiznisBcg2[playerid] = CreatePlayerTextDraw(playerid, 639.575012, 116.860000, "usebox");
	PlayerTextDrawLetterSize(playerid, 		BiznisBcg2[playerid], 0.000000, 1.238053);
	PlayerTextDrawTextSize(playerid, 		BiznisBcg2[playerid], 497.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, 		BiznisBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, 			BiznisBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, 			BiznisBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, 		BiznisBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, 		BiznisBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		BiznisBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, 			BiznisBcg2[playerid], 0);
	PlayerTextDrawShow(playerid,			BiznisBcg2[playerid]);

	BizzInfoText[playerid] = CreatePlayerTextDraw(playerid, 501.850006, 117.488006, "BIZNIS INFO");
	PlayerTextDrawLetterSize(playerid, 		BizzInfoText[playerid], 0.336050, 1.023200);
	PlayerTextDrawAlignment(playerid, 		BizzInfoText[playerid], 1);
	PlayerTextDrawColor(playerid, 			BizzInfoText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		BizzInfoText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		BizzInfoText[playerid], 1);
	PlayerTextDrawFont(playerid, 			BizzInfoText[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, BizzInfoText[playerid], 51);
	PlayerTextDrawSetProportional(playerid, BizzInfoText[playerid], 1);
	PlayerTextDrawShow(playerid,			BizzInfoText[playerid]);

	BizzInfoTD[playerid] = CreatePlayerTextDraw(playerid, 503.999877, 134.456085, "Vlasnik: Richard Collins~n~Cijena: 10.000~g~$~n~~w~Rent: 10~g~$~n~~w~Level: 16");
	PlayerTextDrawLetterSize(playerid, 		BizzInfoTD[playerid], 0.282599, 0.967758);
	PlayerTextDrawAlignment(playerid, 		BizzInfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, 			BizzInfoTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, 		BizzInfoTD[playerid], 1);
	PlayerTextDrawSetOutline(playerid, 		BizzInfoTD[playerid], 0);
	PlayerTextDrawFont(playerid, 			BizzInfoTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BizzInfoTD[playerid], 255);
	PlayerTextDrawSetProportional(playerid, BizzInfoTD[playerid], 1);
	PlayerTextDrawShow(playerid,			BizzInfoTD[playerid]);

	BiznisCMDTD[playerid] = CreatePlayerTextDraw(playerid, 503.550079, 190.175903, "Raspolozive komande:~n~      /enter");
	PlayerTextDrawLetterSize(playerid, 		BiznisCMDTD[playerid], 0.240599, 0.879841);
	PlayerTextDrawAlignment(playerid, 		BiznisCMDTD[playerid], 1);
	PlayerTextDrawColor(playerid, 			BiznisCMDTD[playerid], -5963521);
	PlayerTextDrawSetShadow(playerid, 		BiznisCMDTD[playerid], 1);
	PlayerTextDrawSetOutline(playerid, 		BiznisCMDTD[playerid], 0);
	PlayerTextDrawFont(playerid, 			BiznisCMDTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, BiznisCMDTD[playerid], 255);
	PlayerTextDrawSetProportional(playerid, BiznisCMDTD[playerid], 1);
	PlayerTextDrawShow(playerid,			BiznisCMDTD[playerid]);
	return 1;
}

stock DestroyBizzInfoTD(playerid)
{
	stop PlayerTDTimer[ playerid ];
	PlayerTextDrawDestroy( playerid, 	BiznisBcg1[playerid] );
	PlayerTextDrawDestroy( playerid, 	BiznisBcg2[playerid] );
	PlayerTextDrawDestroy( playerid, 	BizzInfoText[playerid] );
	PlayerTextDrawDestroy( playerid, 	BizzInfoTD[playerid] );
	PlayerTextDrawDestroy( playerid, 	BiznisCMDTD[playerid] );

	BiznisBcg1[playerid]			= PlayerText:INVALID_TEXT_DRAW;
	BiznisBcg2[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	BizzInfoText[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	BizzInfoTD[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	BiznisCMDTD[playerid] 			= PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

stock BuyBiznis(playerid, bool:credit_activated = false)
{
	new biznis = buyBizID[playerid];

	PlayerInfo[ playerid ][ pBizzKey ] 	= biznis;
	//BizzInfo[ biznis ][ bTill ] 		= 0;
	BizzInfo[ biznis ][ bOwnerID ]		= PlayerInfo[ playerid ][ pSQLID ];
	PlayerPlayTrackSound(playerid);
	
	// Money
	new price = BizzInfo[ biznis ][ bBuyPrice ];
	if(credit_activated)
		price -= CreditInfo[playerid][cAmount];
	PlayerToBudgetMoney(playerid, price); 
	
	// SQL
	new
		buybizQuery[ 158 ];
	format( buybizQuery, sizeof(buybizQuery), "UPDATE `bizzes` SET `ownerid` = '%d', `till` = '%d' WHERE `id` = '%d'",
		PlayerInfo[ playerid ][ pSQLID ],
		BizzInfo[ biznis ][ bTill ],
		BizzInfo[ biznis ][bSQLID]
	);
	mysql_tquery( g_SQL, buybizQuery, "", "" );

	SendClientMessage( playerid, COLOR_RED, "[ ! ]  Kupili ste biznis, koristite /help za vise informacija!" );

	// Log
	new log[128];
	format(log, sizeof(log), "%s je kupio biznis %d($%d) (%s).",
		GetName(playerid, false),
		biznis,
		BizzInfo[ biznis ][bBuyPrice],
		GetPlayerIP(playerid)
	);
	LogBuyBiznis(log);
}

/*
	d8888b. db    db  .o88b.  .d8b.  d8b   db
	88  `8D 88    88 d8P  Y8 d8' `8b 888o  88
	88   88 88    88 8P      88ooo88 88V8o 88
	88   88 88    88 8b      88~~~88 88 V8o88
	88  .8D 88b  d88 Y8b  d8 88   88 88  V888
	Y8888D' ~Y8888P'  `Y88P' YP   YP VP   V8P
*/

stock GetStoreProductName(product)
{
	new
		prodname[22];
	switch( product ) {
		case PRODUCT_COLA:			format( prodname, 22, "Coca Cola" 				);
		case PRODUCT_PEPSI:			format( prodname, 22, "Pepsi"					);
		case PRODUCT_WINE:			format( prodname, 22, "Vino" 					);
		case PRODUCT_BEER:      	format( prodname, 22, "Pivo" 					);
		case PRODUCT_WATER:			format( prodname, 22, "Voda"					);
		case PRODUCT_CIGARS:    	format( prodname, 22, "Cigarete" 				);
		case PRODUCT_BURGERS:   	format( prodname, 22, "Burgeri" 				);
		case PRODUCT_CAKE:   		format( prodname, 22, "Torta" 					);
		case PRODUCT_HOTDOG:   		format( prodname, 22, "Hot Dog" 				);
		case PRODUCT_PIZZA:     	format( prodname, 22, "Pizza" 					);
		case PRODUCT_GROCERIES: 	format( prodname, 22, "Namirnice" 				);
		case PRODUCT_MASK:      	format( prodname, 22, "Maska" 					);
		case PRODUCT_FLOWERS:   	format( prodname, 22, "Cvijece" 				);
		case PRODUCT_CAMERA:    	format( prodname, 22, "Fotoaparat" 				);
		case PRODUCT_BAT:       	format( prodname, 22, "Palica" 					);
		case PRODUCT_SPRAY:   		format( prodname, 22, "Spray" 					);
		case PRODUCT_TOOLKIT:   	format( prodname, 22, "Toolkit" 				);
		case PRODUCT_BOOMBOX:   	format( prodname, 22, "Kazetofon" 				);
		case PRODUCT_PCREDIT:   	format( prodname, 22, "Bon za mobitel" 			);
		case PRODUCT_CLOCK:     	format( prodname, 22, "Sat"						);
		case PRODUCT_DICE:      	format( prodname, 22, "Kocka" 					);
		case PRODUCT_LIGHTER:   	format( prodname, 22, "Upaljac" 				);
		case PRODUCT_ROPE:          strcat( prodname, "Konop", 22);
		case PRODUCT_RADIO:         strcat( prodname, "Radio", 22);
		default:					format( prodname, 22, "Nema artikla" 			);
	}
	return prodname;
}

stock GetDrinkName(drinkid)
{
	new
		string[ 33 ];

	switch( drinkid ) {
		case DRINKS_WATER:						format( string, 33, "Voda" 						);
		case DRINKS_BEER:						format( string, 33, "Pivo" 						);
		case DRINKS_PEPSI:          			format( string, 33, "Pepsi"						);
		case DRINKS_COCA_COLA:      			format( string, 33, "Coca Cola" 				);
		case DRINKS_SPRITE:         			format( string, 33, "Sprite" 					);
		case DRINKS_SODA:           			format( string, 33, "Sok" 						);
		case DRINKS_SVEDKAFLAVORS:  			format( string, 33, "Svedka Flavors" 			);
		case DRINKS_KETELONE:       			format( string, 33, "Ketel One" 				);
		case DRINKS_GREYGOOSE:      			format( string, 33, "Grey Goose" 				);
		case DRINKS_BELVEDERE:      			format( string, 33, "Belveredere" 				);
		case DRINKS_BACARDISILVER:  			format( string, 33, "Bacardi Silver" 			);
		case DRINKS_CAPTAINMORGAN:  			format( string, 33, "Captain Morgan" 			);
		case DRINKS_JAMESON:        			format( string, 33, "Jameson" 					);
		case DRINKS_JACK_DANIELS:   			format( string, 33, "Jack Daniels" 				);
		case DRINKS_JOHNNIE_WALKER_BLACK:		format( string, 33, "Johnnie Walker Black" 		);
		case DRINKS_DOBEL_TEQUILA:              format( string, 33, "Dobel Tequila" 			);
		case DRINKS_AVION:                      format( string, 33, "Avion" 					);
		case DRINKS_PATRON_SILVER:              format( string, 33, "Patron Silver"				);
		case DRINKS_KORBEL_BRUT:                format( string, 33, "Korbel Brut" 				);
		case DRINKS_VEUVE_CLICQUOT:             format( string, 33, "Veuve Clicquot" 			);
		case DRINKS_DOM_PERIGNON:               format( string, 33, "Dom Perignon" 				);
		case DRINKS_RASPBERRY_DAIQUIRI:			format( string, 33, "aspberry Daiquiri" 		);
		case DRINKS_MOJITO:                     format( string, 33, "Mojito" 					);
		case DRINKS_WILD_LATINA:                format( string, 33, "Wild Latina" 				);
		case DRINKS_ILLUSION:                   format( string, 33, "Illusion" 					);
		case DRINKS_TROPICAL_DELIGHT:           format( string, 33, "Tropical Delight" 			);
		case DRINKS_MIDORI_SPLICE:              format( string, 33, "Midori Splice" 			);
		case DRINKS_MARGARITA:                  format( string, 33, "Margarita " 				);
		case DRINKS_COSMOPOLITAN:               format( string, 33, "Cosmopolitan" 				);
		case DRINKS_CHICHI:                     format( string, 33, "Chi Chi " 					);
		case DRINKS_PINA_COLADA:                format( string, 33, "Pina Colada" 				);
		case DRINKS_KAMIKAZE:                   format( string, 33, "Kamikaze " 				);
		case DRINKS_BLUE_LAGOON:                format( string, 33, "Blue Lagoon" 				);
		case DRINKS_VIAGRA:						format( string, 33, "Viagra " 					);
		case DRINKS_BLOOD_MARY:                 format( string, 33, "Blood Mary" 				);
		default: strcat(string, "Prazno", sizeof(string));
	}
	return string;
}

stock static GetArticleList(biznis)
{
	new buffer[ 1744 ];
	switch( BizzInfo[ biznis ][ bType ] )
	{
		case BIZZ_TYPE_DUCAN: {
			for( new x = 100; x <= 121; x++ ) {
				format(buffer, 1744, "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")\n",
					buffer,
					GetStoreProductName( x ),
					500
				);
			}
		}
		case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP: {
			for( new x = 100; x <= 134; x++ ) {
				format(buffer, 1744, "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")\n",
					buffer,
					GetDrinkName( x ),
					500
				);
			}
		}
	}
	return buffer;
}

stock static IsValidArticle(biznis, article)
{
	for( new i=0; i <= 9; i++ ) {
		if( BiznisProducts[biznis][bpType][ i ] == article )
			return 0;
	}
	return 1;
}

stock static RemoveStoreArticle(biznis, article)
{
	if( biznis == INVALID_BIZNIS_ID ) return 0;
	// MySQL Query
	new
		deleteArticleQuery[128];
	format(deleteArticleQuery, 128, "DELETE FROM `server_biznis_products` WHERE `biznis_id` = '%d' AND `id` = '%d' AND `type`='%d'",
		BizzInfo[biznis][bSQLID],
		BiznisProducts[biznis][bpSQLID][article],
		BiznisProducts[biznis][bpType][article]
	);
	mysql_tquery(g_SQL, deleteArticleQuery, "", "");

	// Enum Reset
	BiznisProducts[ biznis ][ bpSQLID ][ article ] 	= -1;
	BiznisProducts[ biznis ][ bpType ][ article ] 	= INVALID_PRODUCT_ID;
	BiznisProducts[ biznis ][ bpPrice ][ article ] 	= 0;
	BiznisProducts[ biznis ][ bpAmount ][ article ]	= 0;
	return 1;
}

stock static GetEmptyProductSlot(biznis)
{
	for( new i = 0 ; i < 10; i++ ) {
		if( BiznisProducts[biznis][bpType][ i ] == INVALID_PRODUCT_ID )
			return i;
	}
	return -1;
}

stock static SetStoreProductOnSale(biznis, product, price)
{
	if( biznis == INVALID_BIZNIS_ID ) 						return 0;
	if( product == INVALID_PRODUCT_ID || product < 100 ) 	return 0;

	new
		id = GetEmptyProductSlot(biznis);

	if( id == -1) return 0;
	BiznisProducts[biznis][bpType][id] 		= product;
	BiznisProducts[biznis][bpPrice][ id ] 	= price;
	BiznisProducts[biznis][bpAmount][ id ]	= 0;

	//MySQL Query
	new
		insetProductQuery[128];
	format(insetProductQuery, 128, "INSERT INTO `server_biznis_products`(`biznis_id`, `type`, `price`, `amount`) VALUES ('%d', '%d', '%d', '%d')",
		BizzInfo[biznis][bSQLID],
		BiznisProducts[biznis][bpType][id],
		BiznisProducts[biznis][bpPrice][id],
		BiznisProducts[biznis][bpAmount][id]
	);
	mysql_tquery(g_SQL, insetProductQuery, "OnBiznisProductInsert", "ii", biznis, id);
	return 1;
}

stock static UpdateBiznisProducts(biznis, product, productid)
{
	if( biznis == INVALID_BIZNIS_ID ) 						return 0;
	if( product == INVALID_PRODUCT_ID || product < 100 ) 	return 0;

	//MySQL Query
	new
		updtProductQuery[135];
	format(updtProductQuery, 135, "UPDATE `server_biznis_products` SET `type` = '%d', `price` = '%d', `amount` = '%d' WHERE `id` = '%d' AND `type` = '%d'",
		BiznisProducts[biznis][bpType][productid],
		BiznisProducts[biznis][bpPrice][productid],
		BiznisProducts[biznis][bpAmount][productid],
		BiznisProducts[biznis][bpSQLID][productid],
		BiznisProducts[biznis][bpType][productid]
	);
	mysql_tquery(g_SQL, updtProductQuery);
	return 1;
}

Function: OnBiznisProductInsert(biznis, id)
{
	BiznisProducts[biznis][bpSQLID][id] = cache_insert_id();
	return 1;
}

stock static GetStoreProducts(biznis)
{
	new
		buffer[ 870 ];
	switch( BizzInfo[ biznis ][ bType ]  )
	{
		case BIZZ_TYPE_DUCAN:
		{
			for( new i=0; i <= 9; ++i)
			{
				if( BiznisProducts[biznis][bpType][ i ] > INVALID_PRODUCT_ID)
				{
					format(buffer, 870, "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")  "COL_WHITE"[%d/%d]\n",
						buffer,
						GetStoreProductName( BiznisProducts[biznis][bpType][ i ] ),
						BiznisProducts[biznis][bpPrice][ i ],
						BiznisProducts[biznis][bpAmount][ i ],
						BizzInfo[ biznis ][ bMaxProducts ]
					);
				}
				else
				{
					format(buffer, 870, "%s"COL_RED"Prazno\n",
						buffer
					);
				}
			}
		}
		case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
		{
			for( new i=0; i <= 9; i++ )
			{
				if( BiznisProducts[biznis][bpType][ i ] > INVALID_PRODUCT_ID)
				{
					format(buffer, 870, "%s"COL_WHITE"%s (%d"COL_GREEN"$"COL_WHITE")  "COL_WHITE"[%d/%d]\n",
						buffer,
						GetDrinkName( BiznisProducts[biznis][bpType][ i ] ),
						BiznisProducts[biznis][bpPrice][ i ],
						BiznisProducts[biznis][bpAmount][ i ],
						BizzInfo[ biznis ][ bMaxProducts ]
					);
				}
				else
				{
					format(buffer, 870, "%s"COL_RED"Prazno\n",
						buffer
					);
				}
			}
		}
	}
	return buffer;
}
/*
	d88888b db    db d88888b db
	88'     88    88 88'     88
	88ooo   88    88 88ooooo 88
	88~~~   88    88 88~~~~~ 88
	88      88b  d88 88.     88booo.
	YP      ~Y8888P' Y88888P Y88888P
*/

stock
	Float:FuelStations[][3] = {
	{ 1004.0070,	-939.3102,	42.1797 	},
	{ 1944.3260,	-1772.9254,	13.3906 	},
	{ -90.5515,		-1169.4578,	2.4079		},
	{ -1609.7958,	-2718.2048,	48.5391		},
	{ -2029.4968,	156.4366,	28.9498		},
	{ -2408.7590,	976.0934,	45.4175		},
	{ -2243.9629,	-2560.6477,	31.8841		},
	{ -1676.6323,	414.0262,	6.9484		},
	{ 2202.2349,	2474.3494,	10.5258		},
	{ 614.9333,		1689.7418,	6.6968		},
	{ -1328.8250,	2677.2173,	49.7665		},
	{ 70.3882,		1218.6783,	18.5165		},
	{ 2113.7390,	920.1079,	10.5255		},
	{ -1327.7218,	2678.8723,	50.0625		},
	{ 1488.67, 		-2400.87, 	14.12		},
	{ 1765.69, 		-2287.06, 	27.29		},
	{ 655.6758, 	-565.4126, 	15.33		},
	{ 1545.19, 		-1352.68, 	329.97		},
	{ 2287.2417,	-2055.3201, 12.5479		},
	{ -203.2578,	2595.1746,	62.7031     },
	{ -244.0873,	-2151.0396,	29.7099     },
	{ 1381.6085,	457.7586,	19.9545		}
};

stock IsPlayerNearGasStation(playerid)
{
	for(new i = 0; i<sizeof(FuelStations); i++)
	{
	    if( IsPlayerInRangeOfPoint( playerid, 6.5, FuelStations[i][0],  FuelStations[i][1],  FuelStations[i][2]))
	        return 1;
	}
	/*
	if( IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[0][0],  FuelStations[0][1],  FuelStations[0][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[1][0],  FuelStations[1][1],  FuelStations[1][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[2][0],  FuelStations[2][1],  FuelStations[2][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[3][0],  FuelStations[3][1],  FuelStations[3][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[4][0],  FuelStations[4][1],  FuelStations[4][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[5][0],  FuelStations[5][1],  FuelStations[5][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[6][0],  FuelStations[6][1],  FuelStations[6][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[7][0],  FuelStations[7][1],  FuelStations[7][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[8][0],  FuelStations[8][1],  FuelStations[8][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[9][0],  FuelStations[9][1],  FuelStations[9][2]  ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[10][0], FuelStations[10][1], FuelStations[10][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[11][0], FuelStations[11][1], FuelStations[11][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[12][0], FuelStations[12][1], FuelStations[12][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[13][0], FuelStations[13][1], FuelStations[13][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[14][0], FuelStations[14][1], FuelStations[14][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[15][0], FuelStations[15][1], FuelStations[15][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[16][0], FuelStations[16][1], FuelStations[16][2] ) ||
		IsPlayerInRangeOfPoint( playerid, 5.0, FuelStations[17][0], FuelStations[17][1], FuelStations[17][2] ) )
		return 1;
		*/
	return 0;
}

/*
	.d8888. db   dD d888888b d8b   db .d8888.
	88'  YP 88 ,8P'   `88'   888o  88 88'  YP
	`8bo.   88,8P      88    88V8o 88 `8bo.
	  `Y8b. 88`8b      88    88 V8o88   `Y8b.
	db   8D 88 `88.   .88.   88  V888 db   8D
	`8888Y' YP   YD Y888888P VP   V8P `8888Y'
*/
stock GetPlayerNearestBiznis(playerid)
{
	new value = INVALID_BIZNIS_ID;
	foreach(new b: Bizzes)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, BizzInfo[b][bEntranceX], BizzInfo[b][bEntranceY], BizzInfo[b][bEntranceZ]))
			value = b;
	}
	return value;
}

stock ResetBizzInfo(biz)
{
	BizzInfo[ biz ][ bOwnerID ] = 0;
	BizzInfo[ biz ][ bMessage ][0] = EOS;
	BizzInfo[ biz ][ bCanEnter ] = 0;
	BizzInfo[ biz ][ bLevelNeeded ] = 0;
	BizzInfo[ biz ][ bEntranceX ] = 0.0;
	BizzInfo[ biz ][ bEntranceY ] = 0.0;
	BizzInfo[ biz ][ bEntranceZ ] = 0.0;
	BizzInfo[biz][bExitX] = 0.0;
	BizzInfo[biz][bExitY] = 0.0;
	BizzInfo[biz][bExitZ] = 0.0;
	BizzInfo[biz][bInterior] = 0;
	BizzInfo[biz][bVirtualWorld] = 0;
	BizzInfo[ biz ][ bBuyPrice ] = 0;
	if(BizzInfo[ biz ][ bTill ] > 0)
		BusinessToBudgetMoney(biz, BizzInfo[biz][bTill]);
	BizzInfo[ biz ][ bTill ] = 0;
	BizzInfo[ biz ][ bLocked ] = 0;
	BizzInfo[ biz ][ bEntranceCost ] = 0;
	BizzInfo[ biz ][ bDestroyed ] = 0;
	BizzInfo[ biz ][ bFurSlots ] = 0;
	BizzInfo[ biz][ bGasPrice ] = 0;
	if(IsValidDynamicPickup(BizzInfo[ biz ][ bEnterPICK ]))
		DestroyDynamicPickup(BizzInfo[ biz ][ bEnterPICK ]);
	return 1;
}
stock InsertNewBizz(playerid, biz)
{
	new bizInsertQuery[256];
	mysql_format(g_SQL, bizInsertQuery, 256, "INSERT INTO `bizzes`(`id`, `message`, `canenter`,`entrancex`, `entrancey`, `entrancez`, `levelneeded`, `buyprice`, `type`, `fur_slots`) VALUES (null, '%e','%d','%f','%f','%f','%d','%d','%d','%d')",
		BizzInfo[biz][bMessage],
		BizzInfo[biz][bCanEnter],
		BizzInfo[biz][bEntranceX],
		BizzInfo[biz][bEntranceY],
		BizzInfo[biz][bEntranceZ],
		BizzInfo[biz][bLevelNeeded],
		BizzInfo[biz][bBuyPrice],
		BizzInfo[biz][bType],
		BizzInfo[biz][bFurSlots],
		BizzInfo[biz][bGasPrice]
	);
	mysql_tquery(g_SQL, bizInsertQuery, "OnBizzInsertQuery", "ii", playerid, biz);
	return 1;
}

Function: OnBizzInsertQuery(playerid, bizid)
{
	BizzInfo[bizid][bSQLID] = cache_insert_id();
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uspjesno ste stvorili biznis tipa %s pod nazivom %s[ID: %d | SQLID: %d].",
		GetBiznisType(BizzInfo[bizid][bType]),
		BizzInfo[bizid][bMessage],
		bizid,
		BizzInfo[bizid][bSQLID]);
	SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Da bi ste postavili interijer biznisu, koristite /bizint | /custombizint.");
	return 1;
}

stock DeleteBiznis(biz)
{
	new bizDeleteQuery[64];
	format(bizDeleteQuery, 64, "DELETE FROM `bizzes` WHERE id = '%d'",
		BizzInfo[biz][bSQLID]
	);
	mysql_tquery(g_SQL, bizDeleteQuery, "", "");

	ResetBizzInfo(biz);
	Iter_Remove(Bizzes, biz);
	return 1;
}

stock static SetPlayerPosFinish(playerid)
{
	new biznis = Bit16_Get( gr_PlayerInBiznis, playerid );
	switch( Bit8_Get( gr_PlayerSkinStore, playerid ) ) {
		case 1: // Zip
		{
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 161.4544,-87.6469,1001.8047);
			SetPlayerFacingAngle(playerid, 180.7717);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld( playerid, BizzInfo[ biznis ][ bVirtualWorld ] );
			SetPlayerInterior(playerid, 18);
		}
		case 2: // Binco
		{
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 207.5897,-107.3457,1005.1328);
			SetPlayerFacingAngle(playerid, 181.3984);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld( playerid, BizzInfo[ biznis ][ bVirtualWorld ] );
			SetPlayerInterior(playerid, 15);
		}
		case 3: // ProLaps
		{
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 206.8714,-135.4684,1002.8744);
			SetPlayerFacingAngle(playerid, 179.5183);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld( playerid, BizzInfo[ biznis ][ bVirtualWorld ] );
			SetPlayerInterior(playerid, 3);
		}
		case 4: // Suburban
		{
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 203.8152,-47.4227,1001.8047);
			SetPlayerFacingAngle(playerid, 174.8182);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld( playerid, BizzInfo[ biznis ][ bVirtualWorld ] );
			SetPlayerInterior(playerid, 1);
		}
		case 5: // Mall
		{
			TogglePlayerControllable(playerid, true);
			SetPlayerPos(playerid, 1097.5392, -1442.8313, 15.1654);
			SetPlayerFacingAngle(playerid, 90.0);
			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld( playerid, 0 );
			SetPlayerInterior(playerid, 0);
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
///////////////////////////////////////////////////////////////////

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	foreach(new biznis : Bizzes) {
		if( BizzInfo[ biznis ][ bEnterPICK ] == pickupid ) {
			new
				textString[ 128 ];

			CreateBizzInfoTD( playerid );
			if( BizzInfo[ biznis ][ bOwnerID ] != 0 ) {
				format( textString, 128, "Naziv: %s~n~Vlasnik: %s~n~Tip: %s~n~Vrata: %s~n~~w~Cijena ulaza: %d~g~$~n~~w~Unisten: %s",
					BizzInfo[ biznis ][ bMessage ],
					GetPlayerNameFromSQL(BizzInfo[ biznis ][ bOwnerID ]),
					GetBiznisType( BizzInfo[ biznis ][ bType ] ),
					BizzInfo[ biznis ][ bLocked ] == 1 ? ("~r~ZAKLJUCANA") : ("~g~OTKLJUCANA"),
					BizzInfo[ biznis ][ bEntranceCost ],
					BizzInfo[ biznis ][ bDestroyed ] ? ("Da") : ("Ne")
				);

			}
			else {
				format( textString, 128, "Biznis je na prodaju~n~Naziv: %s~n~Tip: %s~n~Cijena: %d~g~$~n~~w~Level: %d~n~Unisten: %s",
					BizzInfo[ biznis ][ bMessage ],
					GetBiznisType( BizzInfo[ biznis ][ bType ] ),
					BizzInfo[ biznis ][ bBuyPrice ],
					BizzInfo[ biznis ][ bLevelNeeded ],
					BizzInfo[ biznis ][ bDestroyed ] ? ("Da") : ("Ne")
					);
				PlayerTextDrawSetString( playerid, BiznisCMDTD[ playerid ], "Raspolozive komande:~n~      /enter, /buybiznis" );
			}

			PlayerTextDrawSetString( playerid, BizzInfoTD[ playerid ], textString );
			PlayerTDTimer[ playerid ] = defer PlayerBiznisInfo(playerid);
			break;
		}
	}
	#if defined BIZ_OnPlayerPickUpDynamicPickup
        BIZ_OnPlayerPickUpDynamicPickup(playerid, pickupid);
    #endif
    return 1;
}

#if defined _H_OnPlayerPickUpDynamicPickup
    #undef OnPlayerPickUpDynamicPickup
#else
    #define _H_OnPlayerPickUpDynamicPickup
#endif
#define OnPlayerPickUpDynamicPickup BIZ_OnPlayerPickUpDynamicPickup
#if defined BIZ_OnPlayerPickUpDynamicPickup
    forward BIZ_OnPlayerPickUpDynamicPickup(playerid, pickupid);
#endif


CMD:buyskin(playerid, params[])
{
	if(Bit16_Get(gr_PlayerSkinId, playerid) == 0 || Bit16_Get(gr_PlayerSkinPrice, playerid) == 0)
		return SendClientMessage(playerid, COLOR_RED, "Ne mozete koristiti ovu komandu jer niste izabrali skin na /buy!");

	new
			dialogString[ 71 ];

	format(dialogString, 71, "Zelite li kupiti ovaj skin?\n\tINFO:\nSkinid: %d\nCijena: %d"COL_GREEN"$",
		GetPlayerSkin(playerid),
		Bit16_Get(gr_PlayerSkinPrice, playerid)
	);
	ShowPlayerDialog( playerid, DIALOG_SKINSURE, DIALOG_STYLE_MSGBOX, "Kupovina skina", dialogString, "Kupi", "Odustani");
	return 1;
}


public OnPlayerModelSelection(playerid, response, listid, modelid, price)
{
	if( listid == MODEL_LIST_SKINS)
	{
		if(!response)
			return SetPlayerPosFinish(playerid);

		if(AC_GetPlayerMoney(playerid) < price)
		{
			va_SendClientMessage(playerid,COLOR_RED, "Nemas dovoljno novca za kupnju skina %d ($%d)!", modelid, price);
			SetPlayerPosFinish(playerid);

			return 1;
		}
		Bit16_Set(gr_PlayerSkinId, playerid, GetPlayerSkin(playerid));
		Bit16_Set(gr_PlayerSkinPrice, playerid, price);

		SetPlayerSkin(playerid, modelid);

		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Izabrao si skin ID %d ($%d)! Koristi /buyskin za kupovinu!", modelid, price);

		SetPlayerPosFinish(playerid);
	}
	#if defined BIZ_OnPlayerModelSelection
        BIZ_OnPlayerModelSelection(playerid, response, listid, modelid, price);
    #endif
    return 1;
}

#if defined _H_OnPlayerModelSelection
    #undef OnPlayerModelSelection
#else
    #define _H_OnPlayerModelSelection
#endif
#define OnPlayerModelSelection BIZ_OnPlayerModelSelection
#if defined BIZ_OnPlayerModelSelection
    forward BIZ_OnPlayerModelSelection(playerid, response, listid, modelid);
#endif

hook OnGameModeInit()
{
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
		if(Bit16_Get(gr_PlayerSkinId, playerid) != 0 && Bit16_Get(gr_PlayerSkinPrice, playerid) != 0 && !PlayerInfo[playerid][pLawDuty])
		{
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Odustali ste od kupovine skina!");
			ResetBuySkin(playerid);
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyBizzInfoTD( playerid );
	stop PlayerTDTimer[ playerid ];

	FreeBizzID[playerid] = INVALID_BIZNIS_ID;
	Bit1_Set( gr_IsADJ				, 	playerid, false );
	Bit2_Set( gr_DerivatSlot		,	playerid, 0 );
	Bit4_Set( gr_ArticleSlot		,	playerid, 0 );
	Bit16_Set( gr_ArticleIdInput	,	playerid, 0 );
	Bit16_Set( gr_PlayerSkinId		, 	playerid, 0 );
	Bit16_Set( gr_PlayerSkinPrice	, 	playerid, 0 );
	Bit16_Set( gr_DJBizKey			, 	playerid, INVALID_BIZNIS_ID );
	Bit16_Set( gr_PlayerInBiznis	,	playerid, INVALID_BIZNIS_ID );
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & 16) // ENTER
	{
	    foreach(new i : Bizzes) {
			if( IsPlayerInRangeOfPoint(playerid,3.0,BizzInfo[i][bVipEnter][0], BizzInfo[i][bVipEnter][1], BizzInfo[i][bVipEnter][2]) && BizzInfo[i][bVipType] != 0 && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld]) {
    			SetPlayerPosEx(playerid, BizzInfo[i][bVipExit][0],BizzInfo[i][bVipExit][1],BizzInfo[i][bVipExit][2],BizzInfo[i][bVirtualWorld],BizzInfo[i][bInterior],true);
				return 1;
			}
			else if( IsPlayerInRangeOfPoint(playerid,3.0,BizzInfo[i][bVipExit][0],BizzInfo[i][bVipExit][1],BizzInfo[i][bVipExit][2]) && GetPlayerVirtualWorld(playerid) == BizzInfo[i][bVirtualWorld]) {
    			SetPlayerPosEx(playerid, BizzInfo[i][bVipEnter][0], BizzInfo[i][bVipEnter][1], BizzInfo[i][bVipEnter][2],BizzInfo[i][bVirtualWorld],BizzInfo[i][bInterior],true);
				return 1;
			}
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new
		bouse = PlayerInfo[playerid][pBizzKey];
	switch( dialogid ) {
		case DIALOG_NEWBIZNIS_NAME:
		{
			new b = FreeBizzID[playerid];
			if(!response)
			{
				ResetBizzInfo(b);
				return SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]  Prekinuli ste stvaranje biznisa.");
			}
			if( strlen( inputtext ) < 3 || strlen( inputtext ) > 16 )
			{
				ResetBizzInfo(b);
				return SendClientMessage( playerid, COLOR_RED, "Ime koje ste unesli nije valjano (3-16)!" );
			}
			format( BizzInfo[ b ][ bMessage ], 16, inputtext );
			va_SendClientMessage( playerid, COLOR_RED, "[ ! ]  Ime biznisa promjenjeno u %s.", inputtext );
			ShowPlayerDialog(playerid, DIALOG_BIZNIS_TYPE, DIALOG_STYLE_LIST, "Odaberite tip novostvorenog biznisa:", GetBiznisTypeList(), "Odaberi", "Izlaz");
		}
		case DIALOG_BIZNIS_TYPE:
		{
			new bizid = FreeBizzID[playerid];
			if(!response)
			{
				ResetBizzInfo(bizid);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]  Prekinuli ste stvaranje biznisa.");
				return 1;
			}
			BizzInfo[bizid][bType] = listitem;
			Iter_Add(Bizzes, bizid);
			InsertNewBizz(playerid, bizid);
			FreeBizzID[playerid] = INVALID_BIZNIS_ID;
			return 1;
		}
		case DIALOG_REMOVE_BIZNIS:
		{
			new bizid = FreeBizzID[playerid];
			if(!response)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]  Odustali ste od brisanja biznisa.");
				return 1;
			}
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uspjesno ste izbrisali %s %s[ID: %d | SQLID: %d].",
				GetBiznisType(BizzInfo[bizid][bType]),
				BizzInfo[bizid][bMessage],
				bizid,
				BizzInfo[bizid][bSQLID]
			);
			DeleteBiznis(bizid);
			FreeBizzID[playerid] = INVALID_BIZNIS_ID;
			return 1;
		}
		case DIALOG_BIZNIS_MAIN: {
			if( !response ) return 1;

			switch( BizzInfo[ bouse ][ bType ] )
			{
				case BIZZ_TYPE_DUCAN: {
					switch( listitem ) {
						case 0:		// Info
							PrintBizInfo( playerid, bouse );
						case 1:	{	// Postavi artikl
							if( GetEmptyProductSlot(bouse) == -1 ) return SendClientMessage( playerid, COLOR_RED, "Vasa polica je puna!" );
							new tmpString[ 1744 ];
							format(tmpString, 1744, GetArticleList( bouse ) );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", tmpString, "Odaberi", "Odustani" );
						}
						case 2: {	// Skini artikl
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE ARTIKLA", string, "Odaberi", "Odustani" );
						}
						case 3: {	// Postavi cijenu
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", string, "Odaberi", "Odustani" );
						}
						case 4: {	// Vrata
							if( IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bEntranceX ], BizzInfo[ bouse ][ bEntranceY ], BizzInfo[ bouse ][ bEntranceZ ] ) || IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bExitX ], BizzInfo[ bouse ][ bExitY ], BizzInfo[ bouse ][ bExitZ ] ) ) {
								if( BizzInfo[ bouse ][ bLocked ] ) {
									BizzInfo[ bouse ][ bLocked ] = 0;
									GameTextForPlayer( playerid, "~g~Otkljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '0' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								} else {
									BizzInfo[ bouse ][ bLocked ] = 1;
									GameTextForPlayer( playerid, "~g~Zakljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '1' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
							} else SendClientMessage( playerid, COLOR_RED, "Niste blizu vrata od biznisa!" );
						}
						case 5: {	// Rekonstrukcija
							if( !BizzInfo[ bouse ][ bDestroyed ] ) return SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
							new
								bigquery[ 128 ];
							switch( BizzInfo[ bouse ][ bDestroyed ] )
							{
								case 1: //Izlog
								{
									if(AC_GetPlayerMoney(playerid) >= 2000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
								}
								case 2: //Interier
								{
									if(AC_GetPlayerMoney(playerid) >= 8000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
								}
								case 3:
								{
									if(AC_GetPlayerMoney(playerid) >= 20000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
								}
							}
						}
						case 6: 	// Cijena produkta
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Unesi", "Odustani" );
						case 7:		// Ime biznisa
							ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Dalje", "Natrag");
						case 8:
				    		ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Prodaj", "Ponisti");
						case 9: {
							if( bouse == -1 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEREFF, DIALOG_STYLE_LIST, "MOJ BIZNIS - REFILL ARTIKLA", string, "Odaberi", "Odustani" );
						}
					}
				}
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
				{
					switch( listitem )
					{
						case 0: 	// Info
							PrintBizInfo( playerid, bouse );
						case 1: 	// Cijena ulaza
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ENTRANCE, DIALOG_STYLE_INPUT, "BIZNIS - CIJENA ULAZA/USLUGE", "Unesite iznos nove cijene ulaza\nCijena mora biti izmedju 0 i 1.000$!", "Dalje", "Natrag" );
						case 2:	{	// Postavi artikl
							if( GetEmptyProductSlot(bouse) == -1 ) return SendClientMessage( playerid, COLOR_RED, "Vasa polica je puna!" );
							new tmpString[ 1744 ];
							format(tmpString, 1744, GetArticleList( bouse ) );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA PICA", tmpString, "Odaberi", "Odustani" );
						}
						case 3: {	// Skini artikl
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE PICA S MENUA", string, "Odaberi", "Odustani" );
						}
						case 4: {	// Postavi cijenu
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - POSTAVI CIJENU PICA", string, "Odaberi", "Odustani" );
						}
						case 5: {	// Vrata
							if( IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bEntranceX ], BizzInfo[ bouse ][ bEntranceY ], BizzInfo[ bouse ][ bEntranceZ ] ) || IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bExitX ], BizzInfo[ bouse ][ bExitY ], BizzInfo[ bouse ][ bExitZ ] ) ) {
								if( BizzInfo[ bouse ][ bLocked ] ) {
									BizzInfo[ bouse ][ bLocked ] = 0;
									GameTextForPlayer( playerid, "~g~Otkljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '0' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								} else {
									BizzInfo[ bouse ][ bLocked ] = 1;
									GameTextForPlayer( playerid, "~g~Zakljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '1' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
							} else SendClientMessage( playerid, COLOR_RED, "Niste blizu vrata od biznisa!" );
						}
						case 6: {	// Rekonstrukcija
							if( !BizzInfo[ bouse ][ bDestroyed ] ) return SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
							new
								bigquery[ 128 ];
							switch( BizzInfo[ bouse ][ bDestroyed ] ) {
								case 1: {	// Izlog
									if( AC_GetPlayerMoney(playerid) < 2000 ) return SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");

									SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
									BizzInfo[bouse][bDestroyed] = 0;
									PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
								case 2: {	// Interier
									if( AC_GetPlayerMoney(playerid) < 8000 ) return SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");

									SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
									BizzInfo[bouse][bDestroyed] = 0;
									PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
								case 3: {	// Komplet
									if( AC_GetPlayerMoney(playerid) < 20000 ) return SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");

									SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
									BizzInfo[bouse][bDestroyed] = 0;
									PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
							}
						}
						case 7: 	// Cijena produkta
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Unesi", "Odustani" );
						case 8:
							ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Dalje", "Natrag");
						case 9:
				    		ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Prodaj", "Ponisti");
						case 10: {
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEREFF, DIALOG_STYLE_LIST, "MOJ BIZNIS - REFILL ARTIKLA", string, "Odaberi", "Odustani" );
						}
					}
				}
				case BIZZ_TYPE_GASSTATION: {
					switch( listitem ) {
						case 0:		// Info
							PrintBizInfo( playerid, bouse );
						case 1:	{	// Postavi artikl
							if( GetEmptyProductSlot(bouse) == -1 ) return SendClientMessage( playerid, COLOR_RED, "Vasa polica je puna!" );
							new tmpString[ 1744 ];
							format(tmpString, 1744, GetArticleList( bouse ) );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", tmpString, "Odaberi", "Odustani" );
						}
						case 2: {	// Skini artikl
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEREM, DIALOG_STYLE_LIST, "MOJ BIZNIS - BRISANJE ARTIKLA", string, "Odaberi", "Odustani" );
						}
						case 3: {	// Postavi cijenu
							if( bouse >= 999 ) return 1;
							new
								string[ 870 ];
							format( string, 870, GetStoreProducts( bouse ) );
							if( isnull( string ) ) return SendClientMessage(playerid, COLOR_RED, "Nemate niti jedan artikl na policama!" );
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", string, "Odaberi", "Odustani" );
						}
						case 4: {	// Vrata
							if( IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bEntranceX ], BizzInfo[ bouse ][ bEntranceY ], BizzInfo[ bouse ][ bEntranceZ ] ) || IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bExitX ], BizzInfo[ bouse ][ bExitY ], BizzInfo[ bouse ][ bExitZ ] ) ) {
								if( BizzInfo[ bouse ][ bLocked ] ) {
									BizzInfo[ bouse ][ bLocked ] = 0;
									GameTextForPlayer( playerid, "~g~Otkljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '0' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								} else {
									BizzInfo[ bouse ][ bLocked ] = 1;
									GameTextForPlayer( playerid, "~g~Zakljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '1' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
							} else SendClientMessage( playerid, COLOR_RED, "Niste blizu vrata od biznisa!" );
						}
						case 5: {	// Rekonstrukcija
							if( !BizzInfo[ bouse ][ bDestroyed ] ) return SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
							new
								bigquery[ 128 ];
							switch( BizzInfo[ bouse ][ bDestroyed ] )
							{
								case 1: //Izlog
								{
									if(AC_GetPlayerMoney(playerid) >= 2000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
								}
								case 2: //Interier
								{
									if(AC_GetPlayerMoney(playerid) >= 8000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
								}
								case 3:
								{
									if(AC_GetPlayerMoney(playerid) >= 20000)
									{
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									}
									else SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
								}
							}
						}
						case 6:		// Ime biznisa
							ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Dalje", "Natrag");
						case 7:
				    		ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Prodaj", "Ponisti");
					}
				}
				default: {
					switch( listitem ) {
						case 0:		// Info
							PrintBizInfo( playerid, bouse );
						case 1: {	// Vrata
							if( IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bEntranceX ], BizzInfo[ bouse ][ bEntranceY ], BizzInfo[ bouse ][ bEntranceZ ] ) || IsPlayerInRangeOfPoint( playerid, 3.0, BizzInfo[ bouse ][ bExitX ], BizzInfo[ bouse ][ bExitY ], BizzInfo[ bouse ][ bExitZ ] ) ) {
								if( BizzInfo[ bouse ][ bLocked ] ) {
									BizzInfo[ bouse ][ bLocked ] = 0;
									GameTextForPlayer( playerid, "~g~Otkljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '0' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								} else {
									BizzInfo[ bouse ][ bLocked ] = 1;
									GameTextForPlayer( playerid, "~g~Zakljucano", 1000, 5 );
									new bigquery[128];
									format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `locked` = '1' WHERE `id` = '%d'", BizzInfo[bouse][bSQLID]);
									mysql_tquery(g_SQL, bigquery);
								}
							} else SendClientMessage( playerid, COLOR_RED, "Niste blizu vrata od biznisa!" );
						}
						case 2: {	// Rekonstrukcija
							if( !BizzInfo[ bouse ][ bDestroyed ] ) return SendClientMessage(playerid, COLOR_RED, "Vas biznis nije unisten!");
							new
								bigquery[ 128 ];
							switch( BizzInfo[ bouse ][ bDestroyed ] )
							{
								case 1: { // Izlog
									if(AC_GetPlayerMoney(playerid) >= 2000) {
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti izloge i prozore na vasem biznisu za 2.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 2000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									} else SendClientMessage(playerid, COLOR_RED, "Nemate 2.000$ za renoviranje!");
								}
								case 2: { // Interier
									if(AC_GetPlayerMoney(playerid) >= 8000) {
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste popraviti interier u vasem biznisu za 8.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 8000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									} else SendClientMessage(playerid, COLOR_RED, "Nemate 8.000$ za renoviranje!");
								}
								case 3: { // Kompletna renovacija
									if(AC_GetPlayerMoney(playerid) >= 20000) {
										SendClientMessage(playerid, COLOR_RED, "[ ! ]  Odlucili ste napraviti kompletnu renovaciju na vasem biznisu za 20.000$. Od sada ce ponovo normalno raditi.");
										BizzInfo[bouse][bDestroyed] = 0;
										PlayerToBudgetMoney(playerid, 20000); // novac dolazi u budget
										format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `destroyed` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bDestroyed], BizzInfo[bouse][bSQLID]);
										mysql_tquery(g_SQL, bigquery);
									} else SendClientMessage(playerid, COLOR_RED, "Nemate 20.000$ za renoviranje!");
								}
							}
						}
						case 3:		// Postavljanje cijene produkta
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\nOna mora biti izmedju 20 i 1000$!", "Unesi", "Odustani" );
						case 4:		// Ime biznisa
							ShowPlayerDialog(playerid, DIALOG_BIZNIS_NAME, DIALOG_STYLE_INPUT, "BIZNIS - IME BIZNISA", "Unesite novi naziv za vas biznis!", "Dalje", "Natrag");
						case 5:
				    		ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Prodaj", "Ponisti");
					}
				}
			}
			return 1;
		}
		case DIALOG_SELL_BIZ:
		{
			if(response) {
				new
					gplayerid = strval(inputtext),
				    biznis = PlayerInfo[playerid][pBizzKey];

				if(!IsPlayerInRangeOfPoint(playerid, 10.0, BizzInfo[ biznis ][ bEntranceX ], BizzInfo[ biznis ][ bEntranceY ], BizzInfo[ biznis ][ bEntranceZ ])) return SendClientMessage(playerid, COLOR_RED, "Morate biti blizu vaseg biznisa!");
				if( !ProxDetectorS(5.0, playerid, gplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas!");
				if( PlayerInfo[ gplayerid ][ pBizzKey ] != 999 ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac vec ima biznis!");
				GlobalSellingPlayerID[playerid] = gplayerid;
				ShowPlayerDialog(playerid, DIALOG_SELL_BIZ_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "Unesite cijenu vaseg biznisa", "Unesi", "Ponisti");
			}
			return 1;
		}
		case DIALOG_SELL_BIZ_PRICE: {
			if( !response ) return ShowPlayerDialog(playerid, DIALOG_SELL_BIZ, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "U prazni prostor ispod unesite ID igraca i cijenu biznisa", "Prodaj", "Ponisti");

			new
				biznisPrice = strval(inputtext),
				pID = GlobalSellingPlayerID[playerid];

			if( biznisPrice < 1 || biznisPrice > 9999999 ) return ShowPlayerDialog(playerid, DIALOG_SELL_BIZ_PRICE, DIALOG_STYLE_INPUT, "PRODAJA VASEG BIZNISA IGRACU", "Unesite cijenu vaseg biznisa>\nCijena biznisa ne moze biti manja od 1$, a veca od 9.999.999$", "Unesi", "Ponisti");
			if(AC_GetPlayerMoney(pID) < biznisPrice) return SendClientMessage(playerid,COLOR_RED,"Osoba nema toliko novaca kod sebe!");

			GlobalSellingPrice[pID] 	= biznisPrice;
			GlobalSellingPlayerID[pID] 	= playerid;
			va_SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Uspjesno ste ponudili vas biznis igracu %s za %d$", GetName(pID), biznisPrice);

			va_ShowPlayerDialog(pID, DIALOG_SELL_BIZ_2, DIALOG_STYLE_MSGBOX, "PONUDA ZA KUPOVINU BIZNISA", "Igrac %s vam je ponudio da kupite biznis za %d", "Kupi", "Ponisti", GetName(playerid), biznisPrice);
			return 1;
		}
		case DIALOG_SELL_BIZ_2:
		{
			if(response) {
				new
					pID 		= GlobalSellingPlayerID[playerid],
					bizPrice 	= GlobalSellingPrice[playerid];

				if( pID == INVALID_PLAYER_ID ) return SendClientMessage( playerid, COLOR_RED, "Nitko vam nije ponudio prodaju biznisa!" );
				PlayerInfo[ playerid ][ pBizzKey ] 	= PlayerInfo[ pID ][ pBizzKey ];
				PlayerInfo[ pID ][ pBizzKey ]		= INVALID_BIZNIS_ID;

				new
					biznis = PlayerInfo[ playerid ][ pBizzKey ],
					buybizQuery[ 64 ];
				format( buybizQuery, sizeof(buybizQuery), "UPDATE `bizzes` SET `ownerid` = '%d' WHERE `id` = '%d'",
					PlayerInfo[ playerid ][ pSQLID ],
					BizzInfo[ biznis ][bSQLID]
				);
				mysql_tquery(g_SQL, buybizQuery, "", "");

				BizzInfo[biznis][bOwnerID] = PlayerInfo[ playerid ][ pSQLID ];

				// Money
				PlayerToPlayerMoneyTAX ( playerid, pID, bizPrice, true, LOG_TYPE_BIZSELL );

				va_SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Uspjesno ste kupili biznis %s od %s za %d$", BizzInfo[biznis][bMessage], GetName(pID), bizPrice);
				va_SendClientMessage(pID, COLOR_YELLOW, "[ ! ]  Igrac %s je kupio od vas biznis %s za %d", GetName(playerid), BizzInfo[biznis][bMessage],  bizPrice);

				GlobalSellingPlayerID[playerid]		= INVALID_PLAYER_ID;
				GlobalSellingPrice[playerid]		= 0;

				new
					log[ 256 ];
				format( log, sizeof(log), "%s(%s) je kupio biznis %d od %s(%s) za %d$",
					GetName(playerid, false),
					GetPlayerIP(playerid),
					biznis,
					GetName(pID, false),
					GetPlayerIP(pID),
					bizPrice
				);

				LogBuyBiznis(log);

				// Stats save - Buyer
				new
					query[512];
				format(query, 512, "UPDATE `accounts` SET `levels` = '%d', `respects` = '%d', `handMoney` = '%d', `bankMoney` = '%d' WHERE `sqlid` = '%d' LIMIT 1",
					PlayerInfo[playerid][pLevel],
					PlayerInfo[playerid][pRespects],
					PlayerInfo[playerid][pMoney],
					PlayerInfo[playerid][pBank],
					PlayerInfo[playerid][pSQLID]
				);
				mysql_tquery(g_SQL, query, "", "");

				// Stats save - Seller
				format(query, 512, "UPDATE `accounts` SET `levels` = '%d', `respects` = '%d', `handMoney` = '%d', `bankMoney` = '%d' WHERE `sqlid` = '%d' LIMIT 1",
					PlayerInfo[pID][pLevel],
					PlayerInfo[pID][pRespects],
					PlayerInfo[pID][pMoney],
					PlayerInfo[pID][pBank],
					PlayerInfo[pID][pSQLID]
				);
				mysql_tquery(g_SQL, query, "", "");
			}
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLELIST: {

			switch( BizzInfo[ bouse ][ bType ] ) {
				case BIZZ_TYPE_DUCAN:
					if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
					if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
			}

			if( !IsValidArticle( bouse, (listitem+100) ) ) return SendClientMessage( playerid, COLOR_RED, "Taj je artikl vec na policama!" );

			Bit16_Set( gr_ArticleIdInput, playerid, (listitem+100) );

			ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Unesi", "Odustani" );
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLEPRICE: {
			//new
			//	biznis = PlayerInfo[ playerid ][ pBizzKey ];
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLELIST, DIALOG_STYLE_LIST, "MOJ BIZNIS - LISTA ARTIKLA", GetArticleList( bouse ), "Odaberi", "Odustani" );
			if( 5 <= strval(inputtext) <= 1000 )
			{
				if( AC_GetPlayerMoney( playerid ) < 500 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 500$ u djepu!" );
				// Polica
				SetStoreProductOnSale( bouse, Bit16_Get( gr_ArticleIdInput, playerid ), strval(inputtext) );
				new
					prodString[ 67 ];
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN: {
						// Money & poruka
						PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun
						format( prodString, 128, "[ ! ]  Artikl %s ste stavili na svoje police!",
							GetStoreProductName( Bit16_Get( gr_ArticleIdInput, playerid ) )
						);
						SendClientMessage( playerid, COLOR_RED, prodString );
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					}
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP: {
						// Money & poruka
						PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun
						format( prodString, 128, "[ ! ]  Pice %s je sada u ponudi pica!",
							GetDrinkName( Bit16_Get( gr_ArticleIdInput, playerid ) )
						);
						SendClientMessage( playerid, COLOR_RED, prodString );

						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					}
				}
			}
			else ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\n"COL_RED"Ona mora biti izmedju 5 i 1000$!", "Unesi", "Odustani" );
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLEINV: {
			switch( BizzInfo[ bouse ][ bType ] ) {
				case BIZZ_TYPE_DUCAN:
					if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
					if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
			}

			Bit4_Set( gr_ArticleSlot, playerid, listitem );
			ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLESETPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Unesi", "Odustani" );
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLESETPRICE: {
			//new
				//biznis = PlayerInfo[ playerid ][ pBizzKey ];
			if( !response ) return ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLEINV, DIALOG_STYLE_LIST, "MOJ BIZNIS - ARTIKLI", GetStoreProducts( bouse ), "Odaberi", "Odustani" );

			if( 5 <= strval(inputtext) <= 1000 ) {
				new
					slot = Bit4_Get( gr_ArticleSlot, playerid );
				// Polica
				BiznisProducts[bouse][bpPrice][ slot ] = strval(inputtext);

				// Poruka
				new
					prodString[ 66 ];
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						format( prodString, 66, "[ ! ]  Stavili ste novu cijenu na artikl %s!",
							GetStoreProductName( BiznisProducts[bouse][bpType][ slot ] )
						);
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						format( prodString, 66, "[ ! ]  Stavili ste novu cijenu na artikl %s!",
							GetDrinkName( BiznisProducts[bouse][bpType][ slot ])
						);
				}
				SendClientMessage( playerid, COLOR_RED, prodString );

				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
			}
			else ShowPlayerDialog( playerid, DIALOG_BIZNIS_ARTICLESETPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA ARTIKLA", "Unesite cijenu artikla\nOna mora biti izmedju 5 i 1000$!", "Unesi", "Odustani" );
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLEREM: {
			if( !response ) {
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
				return 1;
			}
			if( !BiznisProducts[bouse][bpAmount][ listitem ] ) {
				if( !response ) {
					switch( BizzInfo[ bouse ][ bType ] ) {
						case BIZZ_TYPE_DUCAN:
							 ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
						case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
							ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					}
					return 1;
				}
			}
			RemoveStoreArticle( bouse, listitem );
			SendClientMessage( playerid, COLOR_RED, "[ ! ]  Uspjesno ste maknili artikl s polica!" );

			switch( BizzInfo[ bouse ][ bType ] ) {
				case BIZZ_TYPE_DUCAN:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nStavi pice na menu\nSkini pice s menua\nPostavi cijenu pica\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
			}
			return 1;
		}
		case DIALOG_BIZNIS_ARTICLEREFF: {
			if( !response ) {
				switch( BizzInfo[bouse][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
				return 1;
			}
			if( AC_GetPlayerMoney(playerid) < 500 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 500$!");

			BiznisProducts[bouse][bpAmount][ listitem ] = BizzInfo[ bouse ][ bMaxProducts ];
			PlayerToBudgetMoney(playerid, 500); // Novac od igraca ide u proracun
			SendClientMessage( playerid, COLOR_RED, "[ ! ]  Uspjesno ste refillali odabrani artikl!" );

			switch( BizzInfo[ bouse ][ bType ] ) {
				case BIZZ_TYPE_DUCAN:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nStavi pice na menu\nSkini pice s menua\nPostavi cijenu pica\nVrata\nRekonstrukcija biznisa($20.000)\nIme Biznisa\nProdaj biznis igracu\nRefill pica\nRefill pica", "Odaberi","Izlaz" );
			}

			return 1;
		}
		case DIALOG_BIZNIS_NAME: {
			if( !response ) {
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
				return 1;
			}
			if( strlen( inputtext ) < 3 || strlen( inputtext ) > 15 ) return SendClientMessage( playerid, COLOR_RED, "Ime koje ste unesli nije valjano (3-15)!" );
			format( BizzInfo[ bouse ][ bMessage ], 16, inputtext );
			va_SendClientMessage( playerid, COLOR_RED, "[ ! ]  Ime biznisa promjenjeno u %s.", inputtext );

			new
				tmpBizQuery[128];
			mysql_format(g_SQL, tmpBizQuery, sizeof( tmpBizQuery ), "UPDATE `bizzes` SET `message` = '%e' WHERE `id` = '%d' LIMIT 1", inputtext, BizzInfo[ bouse ][ bSQLID ] );
			mysql_tquery( g_SQL, tmpBizQuery, "", "" );

			switch( BizzInfo[ bouse ][ bType ] ) {
				case BIZZ_TYPE_DUCAN:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
					ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
			}
			return 1;
		}
		case DIALOG_BIZNIS_BUYING: {
			if( !response ) return 1;
			new
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
				tmpString[ 49 ];

			switch( BizzInfo[ biznis ][ bType ] ) {
				case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP: {
					if( BiznisProducts[biznis][bpAmount][ listitem ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Pice nije na menu-u!" );
					if( AC_GetPlayerMoney(playerid) < BiznisProducts[biznis][bpPrice][ listitem ] ) return SendClientMessage( playerid, COLOR_RED, "Nemate toliko novca!" );

					BiznisProducts[biznis][bpAmount][ listitem ]--;
					PlayerToBusinessMoneyTAX(playerid, biznis, BiznisProducts[biznis][bpPrice][ listitem ]); // Stavka koja se kupuje se oporezuje..

					UpdateBiznisProducts(biznis, BiznisProducts[biznis][bpType][ listitem ], listitem);

					if( !BiznisProducts[biznis][bpAmount][ listitem ] ) {
						BiznisProducts[biznis][bpAmount][ listitem ] =  MAX_BIZNIS_PRODS;
						BusinessToBudgetMoney (biznis, 500); // Novac ide u proracun iz biznisa
						UpdateBiznisProducts(biznis, BiznisProducts[biznis][bpType][ listitem ], listitem);
					}

					format( tmpString, 49, "~g~Pijete %s...",
						GetDrinkName( BiznisProducts[biznis][bpType][ listitem ] )
					);
					GameTextForPlayer( playerid, tmpString, 1000, 1 );
					SetPlayerDrunkLevel (playerid, GetPlayerDrunkLevel(playerid) + 250 );
				}
				case BIZZ_TYPE_DUCAN: {
					if( BiznisProducts[biznis][bpAmount][ listitem ] < 1 ) return SendClientMessage( playerid, COLOR_RED, "Artikl nije na policama!" );
					if( AC_GetPlayerMoney(playerid) < BiznisProducts[biznis][bpPrice][ listitem ] ) return SendClientMessage( playerid, COLOR_RED, "Nemate toliko novca!" );

					switch( BiznisProducts[biznis][bpType][ listitem ] ) {
						case PRODUCT_BURGERS, PRODUCT_CAKE, PRODUCT_HOTDOG, PRODUCT_PIZZA:
							Bit1_Set( gr_Food, playerid, true );
						case PRODUCT_COLA, PRODUCT_PEPSI, PRODUCT_WINE, PRODUCT_WATER, PRODUCT_BEER:
							Bit1_Set( gr_Drink, playerid, true );
						case PRODUCT_CIGARS: {
							if(PlayerInfo[playerid][pAge] < 18) return SendClientMessage(playerid, COLOR_YELLOW, "Prodavacica: Ne prodajemo cigarete mladima od 18 godina.");
							PlayerInfo[playerid][pCiggaretes] += 20;
						}
						case PRODUCT_GROCERIES: {
							if( Bit8_Get( gr_Groceries, playerid ) == 20 ) return SendClientMessage( playerid, COLOR_RED, "Vec imate namirnice, spremite ih!" );
							Bit8_Set( gr_Groceries, playerid, 20 );
						}
						case PRODUCT_MASK: {
							if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendClientMessage( playerid, COLOR_RED, "Level 3+ igraci mogu kupovati maske!" );

							PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);

							new log[128],
								playerip[MAX_PLAYER_IP];
							GetPlayerIp(playerid, playerip, sizeof(playerip));

							format(log, sizeof(log), "%s(%s), maskid %d.",
								GetName(playerid, false),
								playerip,
								PlayerInfo[ playerid ][ pMaskID ]
							);
							LogMask(log);
						}
						case PRODUCT_FLOWERS: {
							if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );

							AC_GivePlayerWeapon( playerid, WEAPON_FLOWER, 2 );
						}
						case PRODUCT_CAMERA: {
							if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );

							AC_GivePlayerWeapon( playerid, WEAPON_CAMERA, 100 );
						}
						case PRODUCT_BAT: {
							if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );

							AC_GivePlayerWeapon( playerid, WEAPON_BAT, 2 );
						}
						case PRODUCT_SPRAY: {
							if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );

							AC_GivePlayerWeapon( playerid, WEAPON_SPRAYCAN, 100 );
						}
						case PRODUCT_TOOLKIT: {
							if( PlayerInfo[ playerid ][ pToolkit ] ) return SendClientMessage( playerid, COLOR_RED, "Vec imate tool kit!" );
							PlayerInfo[ playerid ][ pToolkit ] = 1;
						}
						case PRODUCT_BOOMBOX: {
							if( PlayerInfo[ playerid ][ pBoomBox ] ) return SendClientMessage( playerid, COLOR_RED, "Vec imate kazetofon!" );
							PlayerInfo[ playerid ][ pBoomBox ] = 1;
						}
						case PRODUCT_PCREDIT:
						{
							PlayerInfo[playerid][pMobileCost] += 20;
							new	moneyUpdate[128];
							format(moneyUpdate, 128, "UPDATE `player_phones` SET `money` = '%d' WHERE `player_id` = '%d' AND `type` = '1'",
								PlayerInfo[playerid][pMobileCost],
								PlayerInfo[playerid][pSQLID]
							);
							mysql_tquery(g_SQL, moneyUpdate);
						}
						case PRODUCT_CLOCK: {
							if( PlayerInfo[ playerid ][ pClock ] ) return SendClientMessage( playerid, COLOR_RED, "Vec posjedujete sat!" );
							PlayerInfo[ playerid ][ pClock ] = 1;
						}
						case PRODUCT_DICE:
							Bit1_Set( gr_Dice, playerid, true );
						case PRODUCT_LIGHTER:
							PlayerInfo[ playerid ][ pLighter ] = 1;
						case PRODUCT_ROPE:
						    PlayerInfo[ playerid ][ hRope ] = 1;
						case PRODUCT_RADIO: {
						    if( PlayerInfo[ playerid ][ pToolkit ] ) return SendClientMessage( playerid, COLOR_RED, "Vec posjedujete toolkit!" );
						    PlayerInfo[ playerid ] [ pToolkit ] = 1;
						}
					}

					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerToBusinessMoneyTAX(playerid, biznis, BiznisProducts[biznis][bpPrice][ listitem ]); // Novac od igraca ide u biznisi, ali se oporezuje
					UpdateBiznisProducts(biznis, BiznisProducts[biznis][bpType][ listitem ], listitem);

					BiznisProducts[biznis][bpAmount][ listitem ]--;
					if( !BiznisProducts[biznis][bpAmount][ listitem ] ) {
						BiznisProducts[biznis][bpAmount][ listitem ] =  MAX_BIZNIS_PRODS;
						BusinessToBudgetMoney(biznis, 500); // Novac iz biznisa ide u proracun
						UpdateBiznisProducts(biznis, BiznisProducts[biznis][bpType][ listitem ], listitem);
					}

					format( tmpString, 49, "[ ! ]  Kupili ste %s za %d$",
						GetStoreProductName( BiznisProducts[biznis][bpType][ listitem ] ),
						BiznisProducts[biznis][bpPrice][ listitem ]
					);
					SendClientMessage(playerid, COLOR_RED, tmpString );
				}
			}
			return 1;
		}
		case DIALOG_BIZNIS_CRYPTOORMOBILE:
		{
		    if(!response)
		        return 1;

			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid,DIALOG_BIZNIS_MOBILEBUY,DIALOG_STYLE_LIST,"Odaberite mobitel", ListPhonesForSale(), "Kupi", "Izlaz");
				case 1: ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOBUY, DIALOG_STYLE_LIST, "Odaberite crypto...", "Motorola T-900 Crypto - 50$\nAppollo Gold T25 - 70$\nX3 Crypto - 100$", "Odaberi", "Odustani");
				case 2:
				{
					if( !PlayerInfo[playerid][pMobileNumber] ) return SendErrorMessage(playerid, "Nemate mobitel!");
					PhoneMaskMenu(playerid);
				}
			}
		}
		case DIALOG_BIZNIS_MOBILEBUY:
		{
			if( !response )
				return ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo", "Odaberi", "Odustani");

			BuyPlayerPhone(playerid, listitem);
			return 1;
		}
		case DIALOG_BIZNIS_CRYPTOBUY:
		{
		    if( !response )
				return ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo", "Odaberi", "Odustani");
			new
				string[ 51 ];

			switch(listitem)
			{
			    case 0:
			    {
					if(AC_GetPlayerMoney(playerid) < 50)
						return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(50$)!");

					PlayerToBudgetMoney(playerid, 50); // Novac ide u proracun jer je Verona Mall
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uspjesno ste kupili Motorola T-900 Crypto!");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

					PlayerInfo[playerid][pCryptoNumber] = 100000 + random(899999);

					format(string, sizeof(string), "[ ! ]  Vas novi broj cryptoa je %d", PlayerInfo[playerid][pCryptoNumber]);
					SendClientMessage(playerid, COLOR_RED, string);
					SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Koristite /cryptotext!");
					SavePlayerMobile(playerid, 2);
				}
				case 1:
				{
					if(AC_GetPlayerMoney(playerid) < 70)
						return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(70$)!");

					PlayerToBudgetMoney(playerid, 70); // Novac ide u proracun jer je Verona Mall
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uspjesno ste kupili Appollo Gold Crypto!");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

					PlayerInfo[playerid][pCryptoNumber] = 100000 + random(899999);

					format(string, sizeof(string), "[ ! ]  Vas novi broj cryptoa je %d", PlayerInfo[playerid][pCryptoNumber]);
					SendClientMessage(playerid, COLOR_RED, string);
					SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Koristite /cryptotext!");
					SavePlayerMobile(playerid, 2);
				}
				case 2:
				{
					if(AC_GetPlayerMoney(playerid) < 100)
						return SendClientMessage(playerid, COLOR_WHITE, "Nemas dovoljno novca da kupis ovaj crypto(100$)!");

					PlayerToBudgetMoney(playerid, 100); // Novac ide u proracun jer je Verona Mall
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Uspjesno ste kupili X3 Crypto!");
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

					PlayerInfo[playerid][pCryptoNumber] = 100000 + random(899999);

					format(string, sizeof(string), "[ ! ]  Vas novi broj cryptoa je %d", PlayerInfo[playerid][pCryptoNumber]);
					SendClientMessage(playerid, COLOR_RED, string);
					SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Koristite /cryptotext!");
					SavePlayerMobile(playerid, 2);
				}
			}
		}
		case DIALOG_BIZNIS_ENTRANCE: {
			//new
			//	biznis = PlayerInfo[ playerid ][ pBizzKey ];
			if( !response ) {
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
				return 1;
			}

			if( 0 <= strval(inputtext) <= 200 ) {

				BizzInfo[ bouse ][ bEntranceCost ] = strval(inputtext);

				SendClientMessage( playerid, COLOR_RED, "[ ! ]  Postavili ste novu cijenu ulaza!" );
				new bigquery[128];
				format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `entrancecost` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bEntranceCost], BizzInfo[bouse][bSQLID]);
				mysql_tquery(g_SQL, bigquery);
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}

			} else {
				switch( BizzInfo[ bouse ][ bType ] ) {
					case BIZZ_TYPE_DUCAN:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
					case BIZZ_TYPE_BAR, BIZZ_TYPE_STRIP:
						ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
				}
			}
			return 1;
		}
		case DIALOG_CHICKENMENU: {
			if( !response ) return 1;
			new
				tmpString[ 47 ],
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid );
			switch (listitem) {
                case 0: {
					if( AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
					if(PlayerInfo[playerid][pHunger] < 3.5)
						PlayerInfo[playerid][pHunger] += 1.5;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 5); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede topli sendvic.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

        		}
                case 1: {
                    if( AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
						PlayerInfo[playerid][pHunger] += 2.0;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede cevape.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 2: {
                    if( AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
						PlayerInfo[playerid][pHunger] += 2.0;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede filete.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 3: {
                    if( AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
					if(PlayerInfo[playerid][pHunger] < 4.2)
						PlayerInfo[playerid][pHunger] += 0.8;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 2); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede vocnu salatu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 4: {
					if( AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
						PlayerInfo[playerid][pHunger] += 2.0;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede kebab.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

				}
				case 5: {
					if( AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
						PlayerInfo[playerid][pHunger] += 0.2;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s pije sprite.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

				}
				case 6: {
					if( AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
						PlayerInfo[playerid][pHunger] += 0.2;
					else PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 1); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s pije vodu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString,  COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
            }
			return 1;
		}
		case DIALOG_PIZZAMENU: {
			if( !response ) return 1;
			new
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
				tmpString[ 48 ];
			switch (listitem)
            {
                case 0:
                {
					if( AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 3.5)
						PlayerInfo[playerid][pHunger] += 1.5;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede pizzetu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
        		}
                case 1:
                {
                    if( AC_GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED, "Nemas 6$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
						PlayerInfo[playerid][pHunger] += 2.0;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 6); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede veliku pizzu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 2:
                {
                    if( AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
					if(PlayerInfo[playerid][pHunger] < 3.5) {
						PlayerInfo[playerid][pHunger] += 1.5;
					}
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 5); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede topli sendvic.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 3:
                {
                    if( AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
					if(PlayerInfo[playerid][pHunger] < 4.5)
						PlayerInfo[playerid][pHunger] += 0.5;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 2); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede salatu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 4:
                {
                    if( AC_GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED, "Nemas 10$!");
					if(PlayerInfo[playerid][pHunger] < 1.5)
						PlayerInfo[playerid][pHunger] += 3.5;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 10); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede Jumbo Pizzu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 5:
                {
                    if( AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
						PlayerInfo[playerid][pHunger] += 0.2;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s pije Sprite.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

				}
				case 6:
                {
					if( AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
						PlayerInfo[playerid][pHunger] += 0.2;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 1); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s pije vodu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
            }
			return 1;
		}
		case DIALOG_BURGERMENU: {
			if( !response ) return 1;
			new
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
				tmpString[ 51 ];

			switch( listitem )
            {
                case 0:
                {
					if( AC_GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED, "Nemas 6$!");
					if(PlayerInfo[playerid][pHunger] < 3.5)
						PlayerInfo[playerid][pHunger] += 1.5;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede Big Mac.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 6); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 6); // Ako nije biznis ide u proracun
        		}
                case 1:
                {
                    if( AC_GetPlayerMoney(playerid) < 8) return SendClientMessage(playerid, COLOR_RED, "Nemas 8$!");
					if(PlayerInfo[playerid][pHunger] < 3.2)
						PlayerInfo[playerid][pHunger] += 1.8;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede Burger Menu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 8); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 8); // Ako nije biznis ide u proracun
				}
				case 2:
                {
                    if( AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
						PlayerInfo[playerid][pHunger] += 1.0;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede tost.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun

				}
				case 3:
                {
                    if( AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
					if(PlayerInfo[playerid][pHunger] < 4.2)
						PlayerInfo[playerid][pHunger] += 0.8;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede francusku salatu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 2); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 2); // Ako nije biznis ide u proracun

				}
				case 4:
                {
                    if( AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
						PlayerInfo[playerid][pHunger] += 2.0;
		            else
						PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede sendvic sa sunkom.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun
				}
				case 5:
                {
                    if( AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
		            	PlayerInfo[playerid][pHunger] += 0.2;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije Sprite.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun
				}
				case 6:
                {
					if( AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
					if(PlayerInfo[playerid][pHunger] < 4.9)
		            	PlayerInfo[playerid][pHunger] += 0.1;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije vodu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 1); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 1); // Ako nije biznis ide u proracun

				}
            }
			return 1;
		}
		case DIALOG_RESTORANMENU: {
			new
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
				tmpString[ 64 ];

			switch( listitem ) {
                case 0:
                {
					if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
		            	PlayerInfo[playerid][pHunger] += 1.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede juhu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun

        		}
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED, "Nemas 5$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
		            	PlayerInfo[playerid][pHunger] += 2.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede Piletinu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 5); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 5); // Ako nije biznis ide u proracun

				}
				case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 7) return SendClientMessage(playerid, COLOR_RED, "Nemas 7$!");
					if(PlayerInfo[playerid][pHunger] < 2.5)
		            	PlayerInfo[playerid][pHunger] += 2.5;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede pecenog morskog psa na salatu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 7); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 7); // Ako nije biznis ide u proracun
				}
				case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 3.0)
		            	PlayerInfo[playerid][pHunger] += 2.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede Spagete.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 4); // Ako nije biznis ide u proracun
				}
				case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
					if(PlayerInfo[playerid][pHunger] < 4.5)
		            	PlayerInfo[playerid][pHunger] += 0.5;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede kolac.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 2); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 2); // Ako nije biznis ide u proracun
				}
				case 5:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
		            	PlayerInfo[playerid][pHunger] += 0.2;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije Coca Colu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 3); // Ako nije biznis ide u proracun
				}
				case 6:
                {
					if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
		            	PlayerInfo[playerid][pHunger] += 0.2;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije vodu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );

					if( biznis != INVALID_BIZNIS_ID )
						PlayerToBusinessMoney(playerid, biznis, 1); // Novac ide u blagajnu ali se oporezuje
					else
						PlayerToBudgetMoney(playerid, 1); // Ako nije biznis ide u proracun
				}
            }
			return 1;
		}
		case DIALOG_DONUTMENU: {
			new
				biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
				tmpString[ 51 ];

			switch( listitem )  {
                case 0:
                {
					if(AC_GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COLOR_RED, "Nemas 2$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
		            	PlayerInfo[playerid][pHunger] += 1.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede krofnu s visnjom.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
					PlayerToBusinessMoney(playerid, biznis, 2); // Novac ide u blagajnu ali se oporezuje
        		}
                case 1:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
		            	PlayerInfo[playerid][pHunger] += 1.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede punjenu krofnu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
					PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje

				}
				case 2:
                {
                    if(AC_GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COLOR_RED, "Nemas 4$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
		            	PlayerInfo[playerid][pHunger] += 1.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s jede krofnu s kokosom.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
					PlayerToBusinessMoney(playerid, biznis, 4); // Novac ide u blagajnu ali se oporezuje
				}
				case 3:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.0)
		            	PlayerInfo[playerid][pHunger] += 1.0;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
					format(tmpString, sizeof(tmpString), "** %s jede cokoladnu krofnu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 4:
                {
                    if(AC_GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COLOR_RED, "Nemas 3$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
		            	PlayerInfo[playerid][pHunger] += 0.2;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije Coca Colu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
					PlayerToBusinessMoney(playerid, biznis, 3); // Novac ide u blagajnu ali se oporezuje
				}
				case 5:
                {
					if(AC_GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED, "Nemas 1$!");
					if(PlayerInfo[playerid][pHunger] < 4.8)
		            	PlayerInfo[playerid][pHunger] += 0.2;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s pije vodu.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
					PlayerToBusinessMoney(playerid, biznis, 1); // Novac ide u blagajnu ali se oporezuje
				}
            }
			return 1;
		}
		case DIALOG_JAILMENU: {
			if( !response ) return 1;

			new
				tmpString[ 86 ];
			switch( listitem ) {
				case 0: {
					if(PlayerInfo[playerid][pHunger] < 4.9)
		            	PlayerInfo[playerid][pHunger] += 0.1;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s uzima mahune.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 1: {
					if(PlayerInfo[playerid][pHunger] < 4.9)
		            	PlayerInfo[playerid][pHunger] += 0.1;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s uzima grah.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
				case 2: {
					if(PlayerInfo[playerid][pHunger] < 4.9)
		            	PlayerInfo[playerid][pHunger] += 0.1;
		            else
		                PlayerInfo[playerid][pHunger] = 5.0;

					format(tmpString, sizeof(tmpString), "** %s uzima poriluk.", GetName( playerid, true ) );
					ProxDetector(8.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE );
				}
			}
		}
		case DIALOG_FAKE_BUY:{
			if(!response) return 1;
			switch( listitem )
			{
				case 0: {
					if(Bit1_Get( gr_FakeGunLic, playerid)) return SendClientMessage(playerid, COLOR_RED, "Vec imas dozvolu");
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Kupi ste laznu dozvolu za oruzje.");
					Bit1_Set( gr_FakeGunLic, playerid, true );
				}
				case 1: {
					SendClientMessage(playerid, COLOR_RED, "Uskoro!");
				}
			}
		}
		case DIALOG_MALL_BUY: {
			if( !response ) return 1;
			switch( listitem )
			{
				case 0: {
					if( AC_GetPlayerMoney(playerid) < 1 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 1$!");
					PlayerToBudgetMoney(playerid, 1); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljena kockica! [1$]" );
					Bit1_Set( gr_Dice, playerid, true );
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 1: {
					if( AC_GetPlayerMoney(playerid) < 5 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 5$!");
					if( Bit1_Get( gr_Drink, playerid ) ) return SendClientMessage(playerid, COLOR_RED, "Vec imate neko pice u inventoryu! Koristite /drink!" );

					PlayerToBudgetMoney(playerid, 5); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljena Coca Cola! [5$]" );
					Bit1_Set( gr_Drink, playerid, true );
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 2: {
					if( AC_GetPlayerMoney(playerid) < 10 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 10$!");
					if( PlayerInfo[playerid][pClock] ) return SendClientMessage(playerid, COLOR_RED, "Vec imate sat, koristite /time!" );

					PlayerToBudgetMoney(playerid, 10); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljen sat! [10$]" );
					PlayerInfo[playerid][pClock] = 1;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 3: {
				    if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendClientMessage( playerid, COLOR_RED, "Level 3+ igraci mogu kupovati maske!" );
					if( AC_GetPlayerMoney(playerid) < 500 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 500$!");
					if( PlayerInfo[playerid][pMaskID] > 0 ) return SendClientMessage(playerid, COLOR_RED, "Vec imate masku!" );

					PlayerToBudgetMoney(playerid, 500); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljena maska! [500$]" );
					PlayerInfo[ playerid ][ pMaskID ] = 100000 + random(899999);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 4: {
					if( AC_GetPlayerMoney(playerid) < 10 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 10$!");

					PlayerToBudgetMoney(playerid, 10); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljene cigarete! [10$]. Koristite /usecigarette da bi zapalili cigaretu." );
					PlayerInfo[playerid][pCiggaretes] += 20;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 5: {
					if( AC_GetPlayerMoney(playerid) < 5 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 5$!");
					if( PlayerInfo[playerid][pLighter] ) return SendClientMessage( playerid, COLOR_RED, "Vec posjedujete upaljac!" );

					PlayerToBudgetMoney(playerid, 5); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljen upaljac! [5$]" );
					PlayerInfo[playerid][pLighter] = 1;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				case 6: {
					ShowPlayerDialog( playerid, DIALOG_MUSIC_BUY, DIALOG_STYLE_LIST, "KUPOVINA KAZETOFONA", "Red Fire (100$)\nSilver King (100$)", "Odaberi", "Odustani");
				}
				case 7:
				{
					if( AC_GetPlayerMoney(playerid) < 100 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 100$!");
				    PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerInfo[playerid][hRope] = 1;
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljen konop! [100$]" );
				}

				case 8:
				{
					if( AC_GetPlayerMoney(playerid) < 50 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 50$!");
					if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );
					AC_GivePlayerWeapon( playerid, WEAPON_BAT, 2 );
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerToBudgetMoney(playerid, 50); // APosto je VERONA MALL novac ide u budget

				}
				case 9:
				{
					if( AC_GetPlayerMoney(playerid) < 100 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 100$!");
					if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );
					AC_GivePlayerWeapon( playerid, WEAPON_CAMERA, 100 );
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget
				}
				case 10:
				{
					if( AC_GetPlayerMoney(playerid) < 50 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 50$!");
					if( PlayerInfo[ playerid ][ pLevel ] < 2 ) return SendClientMessage( playerid, COLOR_RED, "Level 2+ igraci mogu kupovati oruzja!" );
					AC_GivePlayerWeapon( playerid, WEAPON_SPRAYCAN, 100 );
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerToBudgetMoney(playerid, 50); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljen SprayCan! [50$]" );

				}
				case 11:
				{
					if( AC_GetPlayerMoney(playerid) < 25 ) return SendClientMessage( playerid, COLOR_RED, "Nemate 25$!");
					PlayerInfo[playerid][pMobileCost] += 25;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					new	moneyUpdate[128];
					format(moneyUpdate, 128, "UPDATE `player_phones` SET `money` = '%d' WHERE `player_id` = '%d' AND `type` = '1'",
						PlayerInfo[playerid][pMobileCost],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, moneyUpdate);
					PlayerToBudgetMoney(playerid, 25); // APosto je VERONA MALL novac ide u budget
					SendClientMessage(playerid, COLOR_RED, "[ ! ]  Kupljen bon za mobitel! [25$]" );
				}
				case 12:
				{
				    if(PlayerInfo[playerid][pHasRadio] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete radio!");
					if( AC_GetPlayerMoney(playerid) < 1500 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 1500$!");
					PlayerInfo[playerid][pHasRadio] = 1;
					new	radios[128];
					format(radios, 128, "UPDATE `accounts` SET `HasRadio` = '%d' WHERE `sqlid` = '%d'",
						PlayerInfo[playerid][pHasRadio],
						PlayerInfo[playerid][pSQLID]
					);
					mysql_tquery(g_SQL, radios);
					PlayerToBudgetMoney(playerid, 1500); // APosto je VERONA MALL novac ide u budget
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupljen radio [1500$]");
				}
				case 13:
				{
				    if(PlayerInfo[playerid][pToolkit] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete toolkit!");
					if( AC_GetPlayerMoney(playerid) < 300 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 300$!");
					PlayerInfo[playerid][pToolkit] = 1;
					PlayerToBudgetMoney(playerid, 300); // APosto je VERONA MALL novac ide u budget
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Kupljen toolkit [300$]");
				}
			}
			return 1;
		}
		case DIALOG_MUSIC_BUY: {
			if( !response ) return 1;
			switch( listitem )
			{
				case 0: {
					if( AC_GetPlayerMoney(playerid) < 100 ) return SendClientMessage( playerid, COLOR_RED, "Nemate toliko novca (100$)!" );
					PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget
					PlayerInfo[playerid][pBoomBox]		= 1;
					PlayerInfo[playerid][pBoomBoxType] 	= 0;
				}
				case 1: {
					if( AC_GetPlayerMoney(playerid) < 100 ) return SendClientMessage( playerid, COLOR_RED, "Nemate toliko novca (100$)!" );
					PlayerToBudgetMoney(playerid, 100); // APosto je VERONA MALL novac ide u budget
					PlayerInfo[playerid][pBoomBox]		= 1;
					PlayerInfo[playerid][pBoomBoxType] 	= 1;
				}
			}
		}
		case DIALOG_BIZNIS_PRODUCTPRICE: {
			if( !response ) return 1;

			if( 20 <= strval(inputtext) <= 1000 ) {
				BizzInfo[ bouse ][ bPriceProd ] = strval(inputtext);
				SendClientMessage(playerid, COLOR_RED, "Uspjesno ste promjenili cijene produkta.");
				new bigquery[128];
				format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `priceprod` = '%d' WHERE `id` = '%d'", BizzInfo[bouse][bPriceProd], BizzInfo[bouse][bSQLID]);
				mysql_tquery(g_SQL, bigquery);
			} else return ShowPlayerDialog( playerid, DIALOG_BIZNIS_PRODUCTPRICE, DIALOG_STYLE_INPUT, "MOJ BIZNIS - CIJENA PRODUKTA", "Unesite cijenu produkta za vas biznis,\n"COL_RED"Ona mora biti izmedju 20 i 1000$!", "Unesi", "Odustani" );
			return 1;
		}
		case DIALOG_BIZNIS_MUSIC: {
			if(!response) return 1;
			if( isnull(inputtext) ) return ShowPlayerDialog(playerid, DIALOG_BIZNIS_MUSIC, DIALOG_STYLE_INPUT, "BIZNIS MUSIC", "Unesite live streaming link.\nNPR. shoutcast, listen2myradio, ...", "Unesi", "Odustani");

			new biznis = Bit1_Get(gr_IsADJ, playerid) ? Bit16_Get( gr_DJBizKey, playerid ) : (bouse);
			format( BizzInfo[ biznis ][ bMusicURL ], 96, inputtext );

			foreach(new i : Player) {
				if(IsPlayerInRangeOfPoint( i, 80.0, BizzInfo[ biznis ][ bExitX ], BizzInfo[ biznis ][ bExitY ], BizzInfo[ biznis ][ bExitZ ] ) ) {
					StopAudioStreamForPlayer( i );
					PlayAudioStreamForPlayer( i, BizzInfo[ biznis ][ bMusicURL ] );
				}
			}
			SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Uspjesno si ukljucio radio!");
			return 1;
		}
				case DIALOG_SKINSURE: {
			if( !response ) return SetPlayerSkin(playerid, Bit16_Get(gr_PlayerSkinId, playerid)), ResetBuySkin(playerid);
			// Pare
			if( AC_GetPlayerMoney(playerid) < Bit16_Get( gr_PlayerSkinPrice, playerid ) ) {
				SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca (%d$)!", Bit16_Get( gr_PlayerSkinPrice, playerid ) );
				SetPlayerSkin(playerid, Bit16_Get(gr_PlayerSkinId, playerid));

				Bit16_Set(gr_PlayerSkinId, playerid, 0);
				Bit16_Set(gr_PlayerSkinPrice, playerid, 0);

				//SetPlayerPosFinish(playerid);
				return 1;
			}

			Bit16_Set(gr_PlayerSkinId, playerid, GetPlayerSkin(playerid));

			new
				priceString[ 7 ];
			format( priceString, sizeof( priceString ), "~r~-%d$", Bit16_Get( gr_PlayerSkinPrice, playerid ) );
			GameTextForPlayer( playerid, priceString, 1000, 1 );

			// Raspodjela novca Biznis ili Proracun
			if( Bit16_Get( gr_PlayerInBiznis, playerid ) != INVALID_BIZNIS_ID && Bit16_Get( gr_PlayerInBiznis, playerid ) < MAX_BIZZS)
				PlayerToBusinessMoneyTAX(playerid, Bit16_Get( gr_PlayerInBiznis, playerid ), Bit16_Get(gr_PlayerSkinPrice, playerid)); // Ako je igrac u biznisu, novac ide u biznis
			else
				PlayerToBudgetMoney(playerid, Bit16_Get(gr_PlayerSkinPrice, playerid)); // Posto je VERONA MALL novac ide u budget

			// Skin & Pos
			PlayerInfo[playerid][pChar] = Bit16_Get(gr_PlayerSkinId, playerid);
			//SetPlayerSkin( playerid, Bit16_Get( gr_PlayerSkinId, playerid ) );

			// Animacija
			//SetPlayerPosFinish(playerid);
			ApplyAnimationEx( playerid, "CLOTHES", "CLO_Pose_Legs", 4.1, 0, 0, 0, 0, 0, 1, 0 );

			Bit16_Set(gr_PlayerSkinId, playerid, 0);
			Bit16_Set(gr_PlayerSkinPrice, playerid, 0);

			// MySQL Query
			new skinUpdateQuery[128];
			format(skinUpdateQuery, 128, "UPDATE `accounts` SET `playaSkin` = '%d' WHERE `sqlid` = '%d'",
				PlayerInfo[playerid][pChar],
				PlayerInfo[playerid][pSQLID]
			);
			mysql_tquery(g_SQL, skinUpdateQuery);
			return 1;
		}
	}
	return 0;
}

ResetBuySkin(playerid)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]);

	Bit16_Set(gr_PlayerSkinId, playerid, 0);
	Bit16_Set(gr_PlayerSkinPrice, playerid, 0);
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
///////////////////////////////////////////////////////////////////

timer PlayerBiznisInfo[5000](playerid)
{
	stop PlayerTDTimer[ playerid ];
	DestroyBizzInfoTD( playerid );
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

CMD:createvip(playerid, params[])
{
	new
		pick,
		biz = Bit16_Get( gr_PlayerInBiznis, playerid );
	if( PlayerInfo[ playerid ][ pAdmin ] < 1337 ) return SendClientMessage( playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!" );
	if( biz == INVALID_BIZNIS_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se unutar biznisa!");
	if( sscanf( params, "i", pick ) ) return SendClientMessage( playerid, -1, "[ ? ]: /createvip [0-9] (0 za micanje sobe)" );

	new
		Float:X, Float:Y,Float:Z;
	GetPlayerPos( playerid, X, Y, Z );

	switch( pick ) {
	    case 0: {
			BizzInfo[ biz ][ bVipType ] 		= 0;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= 0.0;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= 0.0;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= 0.0;
			BizzInfo[ biz ][bVipExit][ 0 ] 		= 0.0;
			BizzInfo[ biz ][bVipExit][ 1 ] 		= 0.0;
			BizzInfo[ biz ][bVipExit][ 2 ] 		= 0.0;

			new
				vipDeleteQuery[128];
			format(vipDeleteQuery, 128, "DELETE FROM `server_biznis_vips` WHERE `biznis_id` = '%d'", BizzInfo[biz][bSQLID]);
			mysql_tquery(g_SQL, vipDeleteQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
		}
		case 1: {
			BizzInfo[ biz ][ bVipType ]			= 1;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 1181.6576;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= 7681.1011;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 2980.4;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 2: {
			BizzInfo[ biz ][ bVipType ] 		= 2;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 3324.3752;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= 4321.5127;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 1000.5;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 3: {
			BizzInfo[ biz ][ bVipType ] 		= 3;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 2171.5098;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= -1103.7739;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 3000.5;

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 4: {
			BizzInfo[ biz ][ bVipType ] 		= 4;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 470.0588;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= -369.2497;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 998.8359;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 5: {
			BizzInfo[ biz ][ bVipType ] 		= 5;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ]	= 492.3246;
			BizzInfo[ biz ][ bVipExit ][ 1 ]	= -36.3570;
			BizzInfo[ biz ][ bVipExit ][ 2 ]	= 999.87;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 6: {
		    BizzInfo[ biz ][ bVipType ] 		= 6;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ]	= 2085.8906;
			BizzInfo[ biz ][ bVipExit ][ 1 ]	= 1303.9072;
			BizzInfo[ biz ][ bVipExit ][ 2 ]	= 1501.0859;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 7: {
		    BizzInfo[ biz ][ bVipType ] 		= 7;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 88.1736526;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= 138.5768127;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 131.1377106;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 8: {
		    BizzInfo[ biz ][ bVipType ] 		= 8;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][0] 		= 136.8911133;
			BizzInfo[ biz ][ bVipExit ][1] 		= 173.4578400;
			BizzInfo[ biz ][ bVipExit ][2] 		= 75.8140030;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		case 9: {
		    BizzInfo[ biz ][ bVipType ] 		= 9;
			BizzInfo[ biz ][ bVipEnter ][ 0 ] 	= X;
			BizzInfo[ biz ][ bVipEnter ][ 1 ] 	= Y;
			BizzInfo[ biz ][ bVipEnter ][ 2 ] 	= Z;
			BizzInfo[ biz ][ bVipExit ][ 0 ] 	= 1529.9977;
			BizzInfo[ biz ][ bVipExit ][ 1 ] 	= -1617.9247;
			BizzInfo[ biz ][ bVipExit ][ 2 ] 	= 2000.5590;

			new
				vipInsertQuery[256];
			format(vipInsertQuery, 256, "INSERT INTO `server_biznis_vips`(`biznis_id`, `type`, `x`, `y`, `z`, `exit_x`, `exit_y`, `exit_z`) VALUES ('%d','%d','%f','%f','%f','%f','%f','%f')",
				BizzInfo[biz][bSQLID],
				BizzInfo[ biz ][ bVipType ],
				BizzInfo[ biz ][ bVipEnter ][ 0 ],
				BizzInfo[ biz ][ bVipEnter ][ 1 ],
				BizzInfo[ biz ][ bVipEnter ][ 2 ],
				BizzInfo[ biz ][ bVipExit ][ 0 ],
				BizzInfo[ biz ][ bVipExit ][ 1 ],
				BizzInfo[ biz ][ bVipExit ][ 2 ]
			);
			mysql_tquery(g_SQL, vipInsertQuery, "", "");

			if(IsValidDynamicCP(BizzInfo[ biz ][ bVipCP ])) {
				DestroyDynamicCP( BizzInfo[ biz ][ bVipCP ] );
			}
			BizzInfo[ biz ][ bVipCP ] = CreateDynamicCP( BizzInfo[ biz ][ bVipEnter ][ 0 ], BizzInfo[ biz ][ bVipEnter ][ 1 ], BizzInfo[ biz ][ bVipEnter ][ 2 ]-1, 3.0, BizzInfo[ biz ][ bVirtualWorld ], BizzInfo[ biz ][ bInterior ], -1, 5.0 );
		}
		default:
			SendClientMessage(playerid, COLOR_RED, "Broj sobe ne moze biti manji od 0 ili veci od 9!");
	}
	return 1;
}

CMD:setfuelprice(playerid, params[]){
	new biz, fuelprice;
 	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "ii", biz, fuelprice)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setfuelprice [biznisid][naftaprice]");
	if(!Iter_Contains(Bizzes, biz)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis sa ID-em %d ne postoji na serveru!", biz);
	if(BizzInfo[biz][bType] != BIZZ_TYPE_GASSTATION) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis %s[ID %d] nije benzinska postaja!", BizzInfo[biz][bMessage], biz);
    if(fuelprice < 1 || fuelprice > 10) return SendClientMessage(playerid, COLOR_RED, "Krivi odabir (1-10)!");

    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste cijenu nafte na - "COL_WHITE"%i"COL_YELLOW".", fuelprice);

	BizzInfo[biz][bGasPrice] = fuelprice;
    new TmpQuery[128];
	format(TmpQuery, 128, "UPDATE `bizzes` SET `gasprice` = '%d' WHERE `id` = '%d'", fuelprice, BizzInfo[biz][bSQLID]);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

CMD:bizint(playerid, params[])
{
	new pick, biz;
    if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
    if(sscanf(params, "ii", biz, pick)) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /bizint [biznisid][pick] (0 - brisanje)");
    if(pick < 0 || pick > 37) return SendClientMessage(playerid, COLOR_RED, "Krivi odabir (1-37)!");
	if(!Iter_Contains(Bizzes, biz)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!");
    if(biz > sizeof(BizzInfo) || biz <= 0) return SendClientMessage(playerid, COLOR_RED, "Pogresan biznis ID!");
	switch(pick)
    {
        case 0:
		{
		    BizzInfo[biz][bExitX] = 0.0;
            BizzInfo[biz][bExitY] = 0.0;
            BizzInfo[biz][bExitZ] = 0.0;
            BizzInfo[biz][bInterior] = 0;
		}
        case 1:
        {
			BizzInfo[biz][bExitX] = 454.973937;
            BizzInfo[biz][bExitY] = -110.104995;
            BizzInfo[biz][bExitZ] = 1000.077209;
            BizzInfo[biz][bInterior] = 5;
        }
        case 2:
        {
            BizzInfo[biz][bExitX] = 457.304748;
            BizzInfo[biz][bExitY] = -88.428497;
            BizzInfo[biz][bExitZ] = 999.554687;
            BizzInfo[biz][bInterior] = 4;
        }
        case 3:
        {
            BizzInfo[biz][bExitX] = 375.962463;
            BizzInfo[biz][bExitY] = -65.816848;
            BizzInfo[biz][bExitZ] = 1001.507812;
            BizzInfo[biz][bInterior] = 10;
        }
        case 4:
        {
            BizzInfo[biz][bExitX] = 369.579528;
            BizzInfo[biz][bExitY] = -4.487294;
            BizzInfo[biz][bExitZ] = 1001.858886;
            BizzInfo[biz][bInterior] = 9;
        }
        case 5:
        {
            BizzInfo[biz][bExitX] = 373.825653;
            BizzInfo[biz][bExitY] = -117.270904;
            BizzInfo[biz][bExitZ] = 1001.499511;
            BizzInfo[biz][bInterior] = 5;
        }
        case 6:
        {
            BizzInfo[biz][bExitX] = 381.169189;
            BizzInfo[biz][bExitY] = -188.803024;
            BizzInfo[biz][bExitZ] = 1000.632812;
            BizzInfo[biz][bInterior] = 17;
        }
        case 7:
        {
            BizzInfo[biz][bExitX] = -794.806396;
            BizzInfo[biz][bExitY] = 497.738037;
            BizzInfo[biz][bExitZ] = 1376.195312;
            BizzInfo[biz][bInterior] = 1;
        }
        case 8:
        {
            BizzInfo[biz][bExitX] = 501.980987;
            BizzInfo[biz][bExitY] = -69.150199;
            BizzInfo[biz][bExitZ] = 998.757812;
            BizzInfo[biz][bInterior] = 11;
        }
        case 9:
        {
            BizzInfo[biz][bExitX] = -227.027999;
            BizzInfo[biz][bExitY] = 1401.229980;
            BizzInfo[biz][bExitZ] = 27.765625;
            BizzInfo[biz][bInterior] = 18;
		}
		case 10:
        {
            BizzInfo[biz][bExitX] = 681.557861;
            BizzInfo[biz][bExitY] = -455.680053;
            BizzInfo[biz][bExitZ] = -25.609874;
            BizzInfo[biz][bInterior] = 1;
		}
		case 11:
		{
		    BizzInfo[biz][bExitX] = 1212.019897;
            BizzInfo[biz][bExitY] = -28.663099;
            BizzInfo[biz][bExitZ] = 1000.953125;
            BizzInfo[biz][bInterior] = 3;
		}
		case 12:
		{
		    BizzInfo[biz][bExitX] = 761.412963;
            BizzInfo[biz][bExitY] = 1440.191650;
            BizzInfo[biz][bExitZ] = 1102.703125;
            BizzInfo[biz][bInterior] = 6;
		}
		case 13:
		{
		    BizzInfo[biz][bExitX] = 1204.809936;
            BizzInfo[biz][bExitY] = -11.586799;
            BizzInfo[biz][bExitZ] = 1000.921875;
            BizzInfo[biz][bInterior] = 2;
		}
		case 14:
		{
		    BizzInfo[biz][bExitX] = 942.171997;
            BizzInfo[biz][bExitY] = -16.542755;
            BizzInfo[biz][bExitZ] = 1000.929687;
            BizzInfo[biz][bInterior] = 3;
		}
		case 15:
		{
		    BizzInfo[biz][bExitX] = 964.106994;
            BizzInfo[biz][bExitY] = -53.205497;
            BizzInfo[biz][bExitZ] = 1001.124572;
            BizzInfo[biz][bInterior] = 3;
		}
		case 16:
		{
		    BizzInfo[biz][bExitX] = -2640.762939;
            BizzInfo[biz][bExitY] = 1406.682006;
            BizzInfo[biz][bExitZ] = 906.460937;
            BizzInfo[biz][bInterior] = 3;
		}
		case 17:
		{
		    BizzInfo[biz][bExitX] = 493.390991;
            BizzInfo[biz][bExitY] = -22.722799;
            BizzInfo[biz][bExitZ] = 1000.679687;
            BizzInfo[biz][bInterior] = 17;
		}
		case 18:
		{
		    BizzInfo[biz][bExitX] = -25.884498;
            BizzInfo[biz][bExitY] = -185.868988;
            BizzInfo[biz][bExitZ] = 1003.546875;
            BizzInfo[biz][bInterior] = 17;
		}
		case 19:
		{
		    BizzInfo[biz][bExitX] = -27.312299;
            BizzInfo[biz][bExitY] = -29.277599;
            BizzInfo[biz][bExitZ] = 1003.557250;
            BizzInfo[biz][bInterior] = 4;
		}
		case 20:
		{
		    BizzInfo[biz][bExitX] = -103.559165;
            BizzInfo[biz][bExitY] = -24.225606;
            BizzInfo[biz][bExitZ] = 1000.718750;
            BizzInfo[biz][bInterior] = 3;
		}
		case 21:
		{
		    BizzInfo[biz][bExitX] = -2240.468505;
            BizzInfo[biz][bExitY] = 137.060440;
            BizzInfo[biz][bExitZ] = 1035.414062;
            BizzInfo[biz][bInterior] = 6;
		}
		case 22:
		{
		    BizzInfo[biz][bExitX] = 663.836242;
            BizzInfo[biz][bExitY] = -575.605407;
            BizzInfo[biz][bExitZ] = 16.343263;
            BizzInfo[biz][bInterior] = 0;
		}
		case 23:
		{
		    BizzInfo[biz][bExitX] = 772.111999;
            BizzInfo[biz][bExitY] = -3.898649;
            BizzInfo[biz][bExitZ] = 1000.728820;
            BizzInfo[biz][bInterior] = 5;
		}
		case 24:
		{
		    BizzInfo[biz][bExitX] = 773.579956;
            BizzInfo[biz][bExitY] = -77.096694;
            BizzInfo[biz][bExitZ] = 1000.655029;
            BizzInfo[biz][bInterior] = 7;
		}
		case 25:
		{
            BizzInfo[biz][bExitX] = 774.213989;
            BizzInfo[biz][bExitY] = -48.924297;
            BizzInfo[biz][bExitZ] = 1000.585937;
            BizzInfo[biz][bInterior] = 6;
		}
		case 26:
		{
		    BizzInfo[biz][bExitX] = -204.439987;
            BizzInfo[biz][bExitY] = -26.453998;
            BizzInfo[biz][bExitZ] = 1002.273437;
            BizzInfo[biz][bInterior] = 16;
		}
		case 27:
		{
		    BizzInfo[biz][bExitX] = -204.439987;
            BizzInfo[biz][bExitY] = -8.469599;
            BizzInfo[biz][bExitZ] = 1002.273437;
            BizzInfo[biz][bInterior] = 17;
		}
		case 28:
		{
		    BizzInfo[biz][bExitX] = -204.439987;
            BizzInfo[biz][bExitY] = -43.652496;
            BizzInfo[biz][bExitZ] = 1002.273437;
            BizzInfo[biz][bInterior] = 3;
		}
		case 29:
		{
		    BizzInfo[biz][bExitX] = 411.625976;
            BizzInfo[biz][bExitY] = -21.433298;
            BizzInfo[biz][bExitZ] = 1001.804687;
            BizzInfo[biz][bInterior] = 2;
        }
        case 30:
		{
		    BizzInfo[biz][bExitX] = 418.652984;
            BizzInfo[biz][bExitY] = -82.639793;
            BizzInfo[biz][bExitZ] = 1001.804687;
            BizzInfo[biz][bInterior] = 3;
        }
        case 31:
		{
		    BizzInfo[biz][bExitX] = 412.021972;
            BizzInfo[biz][bExitY] = -52.649898;
            BizzInfo[biz][bExitZ] = 1001.898437;
            BizzInfo[biz][bInterior] = 12;
        }
        case 32:
        {
            BizzInfo[biz][bExitX] = 412.021972;
            BizzInfo[biz][bExitY] = -52.649898;
            BizzInfo[biz][bExitZ] = 1001.898437;
            BizzInfo[biz][bInterior] = 12;
        }
        case 33:
        {
            BizzInfo[biz][bExitX] = 396.4576;
            BizzInfo[biz][bExitY] = -1793.2319;
            BizzInfo[biz][bExitZ] = -54.7219;
            BizzInfo[biz][bInterior] = 66;
        }
        case 34:
        {
            BizzInfo[biz][bExitX] = 88.9655;
            BizzInfo[biz][bExitY] = -233.9642;
            BizzInfo[biz][bExitZ] = 1603.6210;
            BizzInfo[biz][bInterior] = 66;
        }
		case 35:
        {
            BizzInfo[biz][bExitX] = -455.9629;
            BizzInfo[biz][bExitY] = 2189.4355;
            BizzInfo[biz][bExitZ] = 1501.0890;
            BizzInfo[biz][bInterior] = 66;
        }
 		case 36:
        {
            BizzInfo[biz][bExitX] = 2844.3787;
            BizzInfo[biz][bExitY] = 126.7354;
            BizzInfo[biz][bExitZ] = 809.6970;
            BizzInfo[biz][bInterior] = 66;
        }
 		case 37:
        {
            BizzInfo[biz][bExitX] = 86.6998;
            BizzInfo[biz][bExitY] = 213.6764;
            BizzInfo[biz][bExitZ] = 1201.2959;
            BizzInfo[biz][bInterior] = 66;
        }
        default:
            SendClientMessage(playerid, COLOR_RED, "Krivi unos!");
    }
    va_SendClientMessage(playerid, COLOR_YELLOW, "[ ! ]  Uspjesno ste postavili id interiora, biznis id - "COL_WHITE"%i"COL_YELLOW".", biz);
	BizzInfo[biz][bVirtualWorld] = BizzInfo[biz][bInterior] + BizzInfo[biz][bSQLID];
	BizzInfo[biz][bCanEnter] = 1;
    new
		bigquery[ 300 ];
    format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `exitx` = '%f', `exity` = '%f', `exitz` = '%f', `interior` = '%d', `virtualworld` = '%d', `canenter` = '%d' WHERE `id` = '%d'",
		BizzInfo[biz][bExitX],
		BizzInfo[biz][bExitY],
		BizzInfo[biz][bExitZ],
		BizzInfo[biz][bInterior],
		BizzInfo[biz][bVirtualWorld],
		BizzInfo[biz][bCanEnter],
		BizzInfo[biz][bSQLID]
	);
	mysql_tquery(g_SQL, bigquery, "");

	return 1;
}

CMD:custombizint(playerid, params[])
{
	new
	    bizid, bint, bviwo,
	    Float:iX, Float:iY, Float:iZ;
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "  GRESKA: Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "iiifff", bizid, bint, bviwo, iX, iY, iZ)) {
		SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /custombizint [bizid][Interior ID][Virtual World ID][X][Y][Z]");
		return 1;
	}
	if(!Iter_Contains(Bizzes, bizid)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!");
		
	BizzInfo[bizid][bExitX] = iX;
	BizzInfo[bizid][bExitY] = iY;
	BizzInfo[bizid][bExitZ] = iZ;
	BizzInfo[bizid][bInterior] = bint;
	BizzInfo[bizid][bVirtualWorld] = bviwo;

	if( !BizzInfo[bizid][bCanEnter] )
		BizzInfo[bizid][bCanEnter] = 1;

	new
		bigquery[ 300 ];
	format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `exitx` = '%f', `exity` = '%f', `exitz` = '%f', `interior` = '%d', `virtualworld` = '%d', `canenter` = '%d' WHERE `id` = '%d'",
		BizzInfo[bizid][bExitX],
		BizzInfo[bizid][bExitY],
		BizzInfo[bizid][bExitZ],
		BizzInfo[bizid][bInterior],
		BizzInfo[bizid][bVirtualWorld],
		BizzInfo[bizid][bCanEnter],
		BizzInfo[bizid][bSQLID]
	);
	mysql_tquery(g_SQL, bigquery, "");
	return 1;
}


CMD:biznis(playerid, params[])
{
	new
		biznis = PlayerInfo[playerid][pBizzKey];
	if( biznis == INVALID_BIZNIS_ID ) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujete biznis!");
	if( !IsPlayerInRangeOfPoint(playerid, 20.0, BizzInfo[biznis][bEntranceX], BizzInfo[biznis][bEntranceY], BizzInfo[biznis][bEntranceZ]) )
		return va_SendClientMessage(playerid, COLOR_RED, "Niste blizu svoga biznisa (%s)!", BizzInfo[biznis][bMessage]);

	if( BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_DUCAN )
		ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
	else if( BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_BAR || BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_STRIP )
		ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nCijena ulaza\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nPostavi cijenu produkata\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
	else if( BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_GASSTATION )
		ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nPostavi artikl\nSkini artikl\nPostavi cijenu artikla\nVrata\nRekonstrukcija biznisa($20.000)\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
	else
		ShowPlayerDialog( playerid, DIALOG_BIZNIS_MAIN, DIALOG_STYLE_LIST, "MOJ BIZNIS", "Info\nVrata\nRekonstrukcija biznisa($20.000)\nCijena produkta\nIme Biznisa\nProdaj biznis igracu", "Odaberi","Izlaz" );
	return 1;
}

CMD:menu(playerid, params[])
{
	if( AntiSpamInfo[ playerid ][ asBuying ] > gettime() ) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BUY_TIME);

	new
		biznis = Bit16_Get( gr_PlayerInBiznis, playerid );
	if(biznis != INVALID_BIZNIS_ID && BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_BAR)
	{
		va_ShowPlayerDialog(playerid, DIALOG_BIZNIS_BUYING, DIALOG_STYLE_LIST, "PONUDA PICA", "%s", "Popij", "Odustani", GetStoreProducts( biznis ));
		AntiSpamInfo[ playerid ][ asBuying ] = gettime() + ANTI_SPAM_BUY_TIME;
	}
	else
	{
		if( IsPlayerInRangeOfPoint( playerid,30,368.9718,-6.6316,1001.8516 ) ) 							// Cluckin' Bell
			ShowPlayerDialog( playerid,DIALOG_CHICKENMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Topli sendvic 5$\nCevapi 4$\nFileti 4$\nVocna salata 2$\nKebab 4$\nSprite 3$\nVoda 1$","Kupi","Izlaz" );

		else if( IsPlayerInRangeOfPoint( playerid,30,1009.3359,172.7221,5101.7158 ) )
			ShowPlayerDialog( playerid,DIALOG_CHICKENMENU, DIALOG_STYLE_LIST, "PONUDA JELA","Topli sendvic 5$\nCevapi 4$\nFileti 4$\nVocna salata 2$\nKebab 4$\nSprite 3$\nVoda 1$","Kupi","Izlaz" );

		else if(IsPlayerInRangeOfPoint(playerid,30,375.3066,-118.8028,1001.4995 ) ) 					// Well Stacked Pizza
			ShowPlayerDialog(playerid,DIALOG_PIZZAMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Pizzeta 3$\nVelika Pizza 6$\nTopli Sendvic 5$\nSalata 2$\nJumbo Pizza 10$\nSprite 3$\nVoda 1$","Kupi","Izlaz");

		else if(IsPlayerInRangeOfPoint(playerid,30,376.5994,-67.4428,1001.5078) || IsPlayerInRangeOfPoint(playerid,5,1083.3365,-1455.3883,15.7981))					// Burgershot
			ShowPlayerDialog(playerid,DIALOG_BURGERMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Big Mac 6$\nBurger Menu 8$\nToast 4$\nFrancuska salata 2$\nSendvic-Sunka 4$\nSprite 3$\nVoda 1$","Kupi","Izlaz");

		else if(IsPlayerInRangeOfPoint(playerid,30,445.0006,-87.1238,999.5547) || IsPlayerInRangeOfPoint(playerid,15.0,98.5248,226.6844,1197.0959))							// Restaurant 1
			ShowPlayerDialog(playerid,DIALOG_RESTORANMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Juha 3$\nPiletina 5$\nMorski pas 7$\nSpageti 4$\nKolac 2$\nCoca Cola 3$\nVoda 1$","Kupi","Izlaz");

		else if(IsPlayerInRangeOfPoint(playerid,30,-786.0226,500.5655,1371.7422) || IsPlayerInRangeOfPoint(playerid,10.0,1086.3999, -1526.8717, 21.9457)) // Restaurant 2
			ShowPlayerDialog(playerid,DIALOG_RESTORANMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Juha 3$\nPiletina 5$\nMorski pas 7$\nSpageti 4$\nKolac 2$\nCoca Cola 3$\nVoda 1$","Kupi","Izlaz");

		else if(IsPlayerInRangeOfPoint(playerid,30,376.7064,-186.0483,1000.6328) || IsPlayerInRangeOfPoint(playerid,5,1086.1937,-1526.4916,22.7417))																						// Donut Shop
			ShowPlayerDialog(playerid,DIALOG_DONUTMENU,DIALOG_STYLE_LIST,"PONUDA JELA","Krofna s visnjom 2$\nPunjena krofna 4$\nKrofna s kokosom 4$\nCokoladna krofna 3$\nCoca Cola 3$\nVoda 1$","Kupi","Izlaz");

		else if(IsPlayerInRangeOfPoint(playerid,30,1840.8169,-1563.9172,2001.2463))																						// Donut Shop
			ShowPlayerDialog(playerid,DIALOG_JAILMENU,DIALOG_STYLE_LIST,"ZATVORSKA KUHINJA","Mahune\nGrah\nPoriluk","Uzmi","Izlaz");
		AntiSpamInfo[ playerid ][ asBuying ] = gettime() + ANTI_SPAM_BUY_TIME;
	}
	return 1;
}

CMD:buybiznis(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pBizzKey ] != INVALID_BIZNIS_ID ) return SendClientMessage( playerid, COLOR_RED, "Vec posjedujete biznis!" );
	foreach(new biznis : Bizzes) 
	{
		if( IsPlayerInRangeOfPoint( playerid, 5.0, BizzInfo[ biznis ][ bEntranceX ], BizzInfo[ biznis ][ bEntranceY ], BizzInfo[ biznis ][ bEntranceZ ] ) && !BizzInfo[ biznis ][ bOwnerID ] )
		{
			if( PlayerInfo[ playerid ][ pLevel ] < BizzInfo[ biznis ][ bLevelNeeded ] ) 
				return va_SendClientMessage(playerid, COLOR_LIGHTRED, "Moras biti level %d da bi kupio biznis!", BizzInfo[ biznis ][bLevelNeeded]);
			if( BizzInfo[ biznis ][ bType ] == BIZZ_TYPE_BYCITY ) 
				return SendClientMessage( playerid, COLOR_RED, "Ne mozete kupiti biznis jer je u posjedu grada!" );
			if(CalculatePlayerBuyMoney(playerid, BUY_TYPE_BIZZ) < BizzInfo[ biznis ][ bBuyPrice ]) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novca za kupovinu ovog biznisa!");

			buyBizID[playerid] = biznis;
			paymentBuyPrice[playerid] = BizzInfo[ biznis ][ bBuyPrice ];
			GetPlayerPaymentOption(playerid, BUY_TYPE_BIZZ);
			break;
		}
	}
	return 1;
}

CMD:buy(playerid, params[])
{
	if( IsPlayerInRangeOfPoint( playerid, 10.0, 1094.0679, -1453.3447, 14.7900 ) )
		ShowPlayerDialog(playerid, DIALOG_BIZNIS_CRYPTOORMOBILE, DIALOG_STYLE_LIST, "Odaberite proizvod..", "Mobiteli\nCrypto i ostalo\nMaskice za mobitel", "Odaberi", "Odustani");
	else if( IsPlayerInRangeOfPoint(playerid, 15.0, 1158.3975, -1444.1554, 14.7425) )
		ShowPlayerDialog(playerid, DIALOG_MALL_BUY, DIALOG_STYLE_LIST, "VERONA MALL 24/7", "Kockica (1$)\nCoca Cola (5$)\nSat (10$)\nMaska (500$)\nCigarete (10$)\nUpaljac(5$)\nKazetofon\nKonop\nPalica (50$)\nFotoaparat (100$)\nSpray (50$)\nBon za mobitel (25$)\nRadio (1500$)\nToolkit (300$)", "Odaberi", "Odustani");
	else if( IsPlayerInRangeOfPoint(playerid, 15.0, 2294.9822, -2042.7246, 12.6173 ) ) // ne valja ovo!! stara mehanicarska je ovo 24/7
		ShowPlayerDialog(playerid, DIALOG_MALL_BUY, DIALOG_STYLE_LIST, "MECHANIC 24/7", "Kockica (1$)\nCoca Cola (5$)\nSat (10$)\nMaska (500$)\nCigarete (10$)\nUpaljac(5$)\nKazetofon\nKonop\nPalica (50$)\nFotoaparat (100$)\nSpray (50$)\nBon za mobitel (25$)\nRadio (1500$)\nToolkit (300$)", "Odaberi", "Odustani");
	else if(IsPlayerInRangeOfPoint(playerid, 15, 2521.7654, -1323.6298, 33.6071) )
		ShowPlayerDialog(playerid, DIALOG_FAKE_BUY, DIALOG_STYLE_LIST, "Fake goods", "Fake weapon license\nFake ID", "Odaberi", "Odustani");
	else if( IsPlayerInRangeOfPoint(playerid, 15.0, 1096.0909, -1440.6428, 14.7926 ) )
	{
		SetPlayerPos(playerid, 1093.4979, -1436.0308, 15.7300);
		SetPlayerFacingAngle(playerid, 25.9367);
		SetPlayerCameraPos(playerid, 1093.4749, -1438.1703, 15.7253);
		SetPlayerCameraLookAt(playerid, 1093.4979, -1436.0308, 15.7300);
		TogglePlayerControllable(playerid, 0);
		SetPlayerVirtualWorld(playerid, playerid);
		Bit8_Set( gr_PlayerSkinStore, playerid, 5 );
		ShowModelSelectionMenu(playerid, MODEL_LIST_SKINS, "Kupovina odjece", 0x0d0c0cBB, 0x2a2a2a99, 0x3d3d3dAA);
	}
	else {
		if( Bit16_Get( gr_PlayerInBiznis, playerid ) == INVALID_BIZNIS_ID || Bit16_Get( gr_PlayerInBiznis, playerid ) > MAX_BIZZS) return SendClientMessage( playerid, COLOR_RED, "Niste u biznisu!" );

		switch( BizzInfo[ Bit16_Get( gr_PlayerInBiznis, playerid ) ][ bType ] )
		{
			case BIZZ_TYPE_DUCAN:
			{
				if( IsAt247(playerid)) {
					if( AntiSpamInfo[ playerid ][ asBuying ] > gettime() ) return va_SendClientMessage(playerid, COLOR_RED, "[ANTI-SPAM]: Ne spamajte sa komandom! Pricekajte %d sekundi pa nastavite!", ANTI_SPAM_BUY_TIME);
					new
						string[ 870 ];
					format( string, 870, GetStoreProducts( Bit16_Get( gr_PlayerInBiznis, playerid ) ) );
					if( isnull( string ) ) return SendClientMessage( playerid, COLOR_RED, "[ ! ]  Prodavaonica nije napravila ponudu artikala!" );
					ShowPlayerDialog(playerid, DIALOG_BIZNIS_BUYING, DIALOG_STYLE_LIST, "KUPOVINA", string, "Kupi", "Odustani");
					AntiSpamInfo[ playerid ][ asBuying ] = gettime() + ANTI_SPAM_BUY_TIME;
				}
			}
		 	case BIZZ_TYPE_SUBURBAN, BIZZ_TYPE_PROLAPS,  BIZZ_TYPE_ZIP,	BIZZ_TYPE_BINCO: {
				if(IsPlayerInRangeOfPoint(playerid, 3.0, 161.4402,-84.7554,1001.8047)) {	// Zip
					SetPlayerPos(playerid, 154.9184,-76.7528,1001.8047);
					SetPlayerFacingAngle(playerid, 25.9367);
					SetPlayerCameraPos(playerid, 156.5948,-78.3780,1001.8047);
					SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
					TogglePlayerControllable(playerid, 0);
					SetPlayerVirtualWorld(playerid, playerid);
					Bit8_Set( gr_PlayerSkinStore, playerid, 1 );
					ShowModelSelectionMenu(playerid, MODEL_LIST_SKINS, "Kupovina odjece", 0x0d0c0cBB, 0x2a2a2a99, 0x3d3d3dAA);
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.0, 207.5430,-101.4424,1005.2578)) {	// Binco
					SetPlayerPos(playerid, 203.3475,-102.3842,1005.2578);
					SetPlayerFacingAngle(playerid, 49.7479);
					SetPlayerCameraPos(playerid, 204.4864,-99.6000,1006.3055);
					SetPlayerCameraLookAt(playerid, 202.9444,-101.8738,1005.2578);
					//SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
					TogglePlayerControllable(playerid, 0);
					SetPlayerVirtualWorld(playerid, playerid);
					Bit8_Set( gr_PlayerSkinStore, playerid, 2 );
					ShowModelSelectionMenu(playerid, MODEL_LIST_SKINS, "Kupovina odjece", 0x0d0c0cBB, 0x2a2a2a99, 0x3d3d3dAA);
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.0, 207.0127,-129.8306,1003.5078)) {	// ProLaps
					SetPlayerPos(playerid, 214.9582,-128.5536,1003.5078);
					SetPlayerFacingAngle(playerid, 245.5129);
					SetPlayerCameraPos(playerid, 214.2465,-130.9473,1003.5078);
					SetPlayerCameraLookAt(playerid, 215.7756,-128.8572,1003.5078);
					//SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
					TogglePlayerControllable(playerid, 0);
					SetPlayerVirtualWorld(playerid, playerid);
					Bit8_Set( gr_PlayerSkinStore, playerid, 3 );
					ShowModelSelectionMenu(playerid, MODEL_LIST_SKINS, "Kupovina odjece", 0x0d0c0cBB, 0x2a2a2a99, 0x3d3d3dAA);
				}
				else if(IsPlayerInRangeOfPoint(playerid, 3.0, 203.8190,-43.9678,1001.8047)) {	// Suburban
					SetPlayerPos(playerid, 209.0007,-43.0058,1001.8047);
					SetPlayerFacingAngle(playerid, 137.1454);
					SetPlayerCameraPos(playerid, 206.1449,-42.4522,1001.8047);
					SetPlayerCameraLookAt(playerid, 208.1828,-43.6250,1001.8047);
					//SetPlayerCameraLookAt(playerid, 155.4923,-75.8575,1001.8047);
					TogglePlayerControllable(playerid, 0);
					SetPlayerVirtualWorld(playerid, playerid);
					Bit8_Set( gr_PlayerSkinStore, playerid, 4 );
					ShowModelSelectionMenu(playerid, MODEL_LIST_SKINS, "Kupovina odjece", 0x0d0c0cBB, 0x2a2a2a99, 0x3d3d3dAA);
				}
				else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u clothing shopu!");
			}
		}
	}
	return 1;
}


CMD:bmusic(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pBizzKey ] == INVALID_BIZNIS_ID && !Bit1_Get( gr_IsADJ, playerid ) ) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis/nisi DJ!");

	new bouse;
	foreach(new i : Bizzes)
	{
		if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
			bouse = i;
	}

	new
		biznis = Bit1_Get(gr_IsADJ, playerid) ? Bit16_Get( gr_DJBizKey, playerid ) : (bouse);

	if( isnull(BizzInfo[ biznis ][ bMusicURL ]) )
		ShowPlayerDialog(playerid, DIALOG_BIZNIS_MUSIC, DIALOG_STYLE_INPUT, "BIZNIS MUSIC", "Unesite live streaming link.\nNPR. shoutcast, listen2myradio, ...", "Unesi", "Odustani");
	else {
		foreach(new i:Player) {
			if(IsPlayerInRangeOfPoint( i, 80.0, BizzInfo[ biznis ][ bExitX ], BizzInfo[ biznis ][ bExitY ], BizzInfo[ biznis ][ bExitZ ] ) )
				StopAudioStreamForPlayer( i );
		}
		BizzInfo[ biznis ][ bMusicURL ][0] = '\0';
	}
	return 1;
}

CMD:makedj(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pBizzKey ] == INVALID_BIZNIS_ID ) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis!");

	new
		biznis = Bit16_Get( gr_PlayerInBiznis, playerid ),
		djString[ 64 ],
		giveplayerid;

	new bouse;
	foreach(new i : Bizzes)
	{
		if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
		bouse = i;
	}

	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "[ ? ]: /makedj [DioImena/Playerid]");
	if( biznis == INVALID_BIZNIS_ID || biznis != bouse ) return SendClientMessage(playerid, COLOR_RED, "Niste unutar svojeg biznisa!" );

	if( Bit1_Get( gr_IsADJ, giveplayerid ) ) {
		Bit1_Set(	gr_IsADJ, 	giveplayerid, false);
		Bit16_Set(	gr_DJBizKey, giveplayerid, INVALID_BIZNIS_ID);
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ]  Vise niste zaposleni kao DJ!" );
	} else {
		Bit1_Set(gr_IsADJ, giveplayerid, true);
		Bit16_Set(gr_DJBizKey, giveplayerid, biznis);

		format(djString, 64, "[ ! ]  Zaposlio si %s kao novog DJ-a!", GetName(giveplayerid, true) );
		SendClientMessage( playerid, COLOR_YELLOW, djString );
		format(djString, 64, "[ ! ]  %s te je zaposlio kao svoga DJ-a!", GetName(playerid, true) );
		SendClientMessage( giveplayerid, COLOR_YELLOW, djString );
	}
	return 1;
}

CMD:bizentrance(playerid, params[])
{
	new proplev;
	if(PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Nisi 1338!");
	if (sscanf(params, "i", proplev)) return SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /bizentrance [bizid] - izmjena ulaza biznisa");
	if(!Iter_Contains(Bizzes, proplev))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Biznis ID %d ne postoji na serveru!", proplev);

	new
		Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);

	BizzInfo[proplev][bEntranceX] = X;
	BizzInfo[proplev][bEntranceY] = Y;
	BizzInfo[proplev][bEntranceZ] = Z;

	DestroyDynamicPickup(BizzInfo[ proplev ][ bEnterPICK ]);
	BizzInfo[ proplev ][ bEnterPICK ] = CreateDynamicPickup( 1272, 2, BizzInfo[ proplev ][bEntranceX], BizzInfo[ proplev ][bEntranceY], BizzInfo[ proplev ][bEntranceZ], -1, -1, -1, 100.0 );

	new
		tmpString[ 92 ];
	format(tmpString,sizeof(tmpString),"[ADMIN]: %s je premjestio biz [%d] na [%f - %f - %f].",
		GetName(playerid, false),
		proplev,
		X,
		Y,
		Z
	);
	ABroadCast(COLOR_LIGHTRED,tmpString, 4);
	new
		bigquery[ 256 ];
	format(bigquery, sizeof(bigquery), "UPDATE `bizzes` SET `entrancex` = '%f', `entrancey` = '%f', `entrancez` = '%f' WHERE `id` = '%d'",
		X,
		Y,
		Z,
		BizzInfo[proplev][ bSQLID ]
	);
	mysql_tquery(g_SQL, bigquery, "");
    return 1;
}

CMD:bizinfo(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Nisi administrator!");
	new biznis = INVALID_BIZNIS_ID;
	foreach(new i : Bizzes) {
		if( IsPlayerInRangeOfPoint( playerid, 8.0, BizzInfo[ i ][ bEntranceX ], BizzInfo[ i ][ bEntranceY ], BizzInfo[ i ][ bEntranceZ ] ) ) {
			biznis = i;
			break;
		}
	}
	if(biznis == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED,"Ne nalazis se ispred ulaza biznisa.");

	va_SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Bizz ID: %d | Bizz MySQL ID: %d", biznis, BizzInfo[biznis][bSQLID]);
	va_SendClientMessage(playerid, COLOR_RED, "[INFO] Stanje u blagajni biznisa: %d$", BizzInfo[biznis][bTill]);

	new
		infoString[68];
	if(BizzInfo[biznis][bPriceProd] == 0)
		return SendClientMessage(playerid, COLOR_RED, "[INFO] Biznis nema definiranu cijenu produkata.");

	format(infoString, sizeof(infoString), "Cijena po produktu: %d", BizzInfo[biznis][bPriceProd]);
	SendClientMessage(playerid, -1,infoString);

	new
		Float:prodammount = BizzInfo[biznis][bTill] / BizzInfo[biznis][bPriceProd],
		RecievingPackages = floatround(prodammount, floatround_floor);
	if(RecievingPackages == 0)
		SendClientMessage(playerid, COLOR_RED, "[INFO] Biznis nije spreman primiti nove produkte (Financijska kriza).");
	else
	{
		format(infoString, sizeof(infoString), "[INFO] Bizins je spreman primiti %d paketa produkata.", RecievingPackages);
		SendClientMessage(playerid, -1,infoString);
	}
	if( BizzInfo[biznis][bLocked] )
		SendClientMessage(playerid, COLOR_RED, "Zakljucano");
	else
		SendClientMessage(playerid, COLOR_GREEN, "Otkljucano");
    return 1;
}
CMD:bizwithdraw(playerid, params[])
{
	new
		bouse,
		cashdeposit,
		string[64];

	if (PlayerInfo[playerid][pBizzKey] == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis.");

	foreach(new i : Bizzes)
	{
		if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
			bouse = i;
	}
	if (sscanf(params, "i", cashdeposit))
	{
		format(string, sizeof(string), "Imate $%d u vasem biznisu.", BizzInfo[bouse][bTill]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		SendClientMessage(playerid, COLOR_ORANGE, "[ ? ]: /bizwithdraw [Iznos koliko zelite podici iz biznisa]");
		return 1;
    }
	if( cashdeposit > BizzInfo[bouse][bTill] || cashdeposit < 1 ) return SendClientMessage(playerid, COLOR_RED, "Nemate toliko novaca");
	if( !IsPlayerInRangeOfPoint(playerid, 100.0, BizzInfo[bouse][bExitX], BizzInfo[bouse][bExitY], BizzInfo[bouse][bExitZ]) && BizzInfo[bouse][bCanEnter] == 1) return SendClientMessage(playerid, COLOR_RED, "Previse si udaljen od biznisa");
	if( !IsPlayerInRangeOfPoint(playerid,3,BizzInfo[bouse][bEntranceX], BizzInfo[bouse][bEntranceY],BizzInfo[bouse][bEntranceZ]) && BizzInfo[bouse][bCanEnter] == 0) return SendClientMessage(playerid, COLOR_RED, "Previse si udaljen od biznisa");

	BusinessToPlayerMoney(playerid, bouse, cashdeposit); //Novac iz biznisa ide igra�u

	format(string, sizeof(string), "[ ! ]  Podigli ste $%d sa vaseg biznisa. Ukupno: $%d.",
		cashdeposit,
		BizzInfo[bouse][bTill]
	);
	SendClientMessage(playerid, COLOR_RED, string);

	new
		log[128];
	format(log, sizeof(log), "%s(%s) je uzeo %d$ iz biznisa %d.",
		GetName(playerid, false),
		GetPlayerIP(playerid),
		cashdeposit,
		bouse
	);
	LogBizBank(log);
	return 1;
}
CMD:bizbank(playerid, params[])
{
	new
		bouse,
		cashdeposit,
		string[59];

	if (PlayerInfo[playerid][pBizzKey] == INVALID_BIZNIS_ID) return SendClientMessage(playerid, COLOR_RED, "Ne posjedujes biznis.");
	foreach(new i : Bizzes)
	{
		if(PlayerInfo[playerid][pSQLID] == BizzInfo[i][bOwnerID])
			bouse = i;
	}
	if( sscanf(params, "i", cashdeposit))
	{
		format(string, sizeof(string), "  Imate $%d u vasem biznisu.", BizzInfo[bouse][bTill]);
		SendClientMessage(playerid, COLOR_GREY, string);
	    SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /bizbank [iznos]");
		return 1;
    }
	if( cashdeposit > AC_GetPlayerMoney(playerid) || cashdeposit < 1 ) return SendClientMessage(playerid, COLOR_RED, "Nemas toliko novaca");

	PlayerToBusinessMoney(playerid, bouse, cashdeposit); // Novac od igra�a ide u biznis

	format(string, sizeof(string), "[ ! ]  Stavio si $%d u tvoj biznis. Ukupno: $%d.",
		cashdeposit,
		BizzInfo[bouse][bTill]
	);
	SendClientMessage(playerid, COLOR_RED, string);

	new
		log[128];
	format(log, sizeof(log), "%s(%s) je stavio %d$ na biznis %d.",
		GetName(playerid, false),
		GetPlayerIP(playerid),
		cashdeposit,
		bouse
	);
	LogBizBank(log);
	return 1;
}

CMD:createbiz(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		level, canenter, price;
	if(sscanf(params, "iii", level, canenter, price)){
		SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /createbiz [level][ulaz][cijena]");
		return 1;
	}
	new Float:x, Float:y, Float:z, freeslot;
	GetPlayerPos(playerid, x, y, z);

	freeslot = Iter_Free(Bizzes);
	FreeBizzID[playerid] = freeslot;
	BizzInfo[ freeslot ][ bOwnerID ] = 0;
	BizzInfo[ freeslot ][ bCanEnter ] = canenter;
	BizzInfo[ freeslot ][ bLevelNeeded ] = level;
	BizzInfo[ freeslot ][ bEntranceX ] = x;
	BizzInfo[ freeslot ][ bEntranceY ] = y;
	BizzInfo[ freeslot ][ bEntranceZ ] = z;
	BizzInfo[ freeslot ][ bBuyPrice ] = price;
	BizzInfo[ freeslot ][ bTill ] = 0;
	BizzInfo[ freeslot ][ bLocked ] = 1;
	BizzInfo[ freeslot ][ bEntranceCost ] = 0;
	BizzInfo[ freeslot ][ bDestroyed ] = 0;
	BizzInfo[ freeslot ][ bFurSlots ] = BIZZ_FURNITURE_VIP_NONE;
	BizzInfo[ freeslot][ bGasPrice ] = 3;
	BizzInfo[ freeslot ][ bEnterPICK ] = CreateDynamicPickup( 1272, 2, BizzInfo[ freeslot ][bEntranceX], BizzInfo[ freeslot ][bEntranceY], BizzInfo[ freeslot ][bEntranceZ], -1, -1, -1, 100.0 );

	ShowPlayerDialog(playerid, DIALOG_NEWBIZNIS_NAME, DIALOG_STYLE_INPUT, "Unos imena biznisa:", "Molimo Vas unesite ime novog biznisa.", "Unesi", "Izlaz");
	return 1;
}
CMD:deletebiz(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338)
		return SendClientMessage(playerid, COLOR_RED, "Niste Administrator Level 1338");
	new biznis = GetPlayerNearestBiznis(playerid);
	if(biznis == INVALID_BIZNIS_ID)
		return SendClientMessage(playerid, COLOR_RED, "Niste u blizini nijednog biznisa!");
	new removebizstring[128];
	FreeBizzID[playerid] = biznis;
	format(removebizstring, sizeof(removebizstring), "Jeste li sigurni da zelite izbrisati %s %s[SQLID: %d]?", GetBiznisType(BizzInfo[biznis][bType]), BizzInfo[biznis][bMessage], BizzInfo[biznis][bSQLID]);
	ShowPlayerDialog(playerid, DIALOG_REMOVE_BIZNIS, DIALOG_STYLE_MSGBOX, "Potvrda brisanja biznisa", removebizstring, "Da", "Ne");
	return 1;
}
CMD:microphone(playerid, params[]){

	if( PlayerInfo[ playerid ][ pBizzKey ] == INVALID_BIZNIS_ID && !Bit1_Get( gr_IsADJ, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujes biznis/nisi DJ!");

	new motd[256],playername[MAX_PLAYER_NAME];
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: (/mic)rophone  [text]");
	if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, COLOR_RED, "Nemozete pricati, usutkani ste");
	GetPlayerName(playerid,playername,sizeof(playername));

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(!IsPlayerInRangeOfPoint(i, 20, x, y, z)) continue;
		PlayerPlaySound(i, 15800, 0, 0, 0);
 	}
	format(motd, sizeof(motd), "[Deejay %s:o< %s]", playername, params);
	ProxDetector(60.0, playerid, motd,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
	return 1;
}

