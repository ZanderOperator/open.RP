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
#define JACKER_JOB_ID			(13)

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
	Iterator:IllegalGarage<MAX_ILEGAL_GARAGES>;

enum 
{
	ENGINE_TYPE_NONE		= 0,
	ENGINE_TYPE_DIESEL,
	ENGINE_TYPE_PETROL
}

enum E_JACKER_LAND_VEHS 
{
	viModelid,
	viName[18],
	viPrice,
	viCarJackerPrice,
	viSeats,
	Float:viFuel,
	viEngineType,
	viPremium,
	viSlots
};

static
   LandVehicles[123][E_JACKER_LAND_VEHS] = {
	{ 400, "Landstalker",      72500, 7050,   4,   65.0,    ENGINE_TYPE_PETROL, 0, 4 },
	{ 401, "Bravura",          33437,    3698,   2,   40.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 402, "Buffalo",          129625, 8241,   2,   70.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 404, "Perrenial",         6000,    2222,    4,   40.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 405, "Sentinel",         64500,    6759,   4,   55.0,    ENGINE_TYPE_DIESEL, 0, 4 },
	{ 408, "Trashmaster",      4875,    0,      2,   85.0,    ENGINE_TYPE_PETROL, 0, 0  },
	{ 409, "Stretch",          300752, 8969,   4,   50.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 410, "Manana",         10250,    2329,    2,   45.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 411, "Infernus",         0,      9955,   2,    70.0,    ENGINE_TYPE_PETROL, 3, 1  },//{ 411, "Infernus",          0,      9955,   2,    70.0,    ENGINE_TYPE_PETROL, 3, 1  },
	{ 412, "Voodoo",          12500,    2420,   2,   55.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 413, "Pony",             18500,    2826,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 7  },
	{ 414, "Mule",             15300,    2818,   2,   60.0,    ENGINE_TYPE_PETROL, 0,  8 },
	{ 415, "Cheetah",          0,     9824,   2,   60.0,    ENGINE_TYPE_PETROL, 3, 1  },
	{ 418, "Moonbeam",          14000,    2500,   4,   55.0,    ENGINE_TYPE_DIESEL, 0, 6  },
	{ 419, "Esperanto",         16750,    2690,   2,   58.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 420, "Taxi",             14750,    2805,   4,   47.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 421, "Washington",      40250,    4283,    4,    58.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 422, "Bobcat",          12500,    2404,   2,   65.0,    ENGINE_TYPE_PETROL, 0, 6  },
	{ 423, "Mr Whoopee",       13500,    2398,   2,    65.0,    ENGINE_TYPE_DIESEL, 0, 3 },
	{ 424, "BF Injection",       84062, 7589,    2,   20.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 426, "Premier",          89200, 7779,   4,   50.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 429, "Banshee",          281500, 8690,   2,   60.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 434, "Hotknife",          20250, 2904,   2,   56.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 436, "Previon",          14000,    2474,   2,   50.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 438, "Cabbie",          13500,    2391,   4,   47.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 439, "Stallion",          45587,    5405,   2,   49.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 440, "Rumpo",          13500,    2381,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 7  },
	{ 442, "Romero",          17750,    2792,   4,   40.0,    ENGINE_TYPE_DIESEL, 0, 5  },
	{ 445, "Admiral",          28250,    2960,   4,   55.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 448, "Pizzaboy",         7000,    0,       1,   5.0,     ENGINE_TYPE_DIESEL, 0, 1  },
	{ 451, "Turismo",          0,       9728,    2,   60.0,    ENGINE_TYPE_PETROL, 2, 1  },
	{ 456, "Yankee",          25750,    2933,    2,   68.0,    ENGINE_TYPE_PETROL, 0, 9  },
	{ 458, "Solair",          27800,    2960,   4,   40.0,    ENGINE_TYPE_DIESEL, 0, 6 },
	{ 459, "Berkley's Van",      15000,    0,       2,   55.0,    ENGINE_TYPE_PETROL, 0, 7   },
	{ 461, "PCJ-600",          61693,    0,      2,   7.0,     ENGINE_TYPE_PETROL, 0, 1  },
	{ 462, "Faggio",          8500,    0,       1,   5.0,     ENGINE_TYPE_DIESEL, 0, 1  },
	{ 463, "Freeway",          7500,    0,      2,   7.0,     ENGINE_TYPE_PETROL, 0, 1   },
	{ 466, "Glendale",          14250,    2455,    4,   47.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 467, "Oceanic",          17250,    2687,   4,   48.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 468, "Sanchez",          11250,    0,      2,   5.0,     ENGINE_TYPE_PETROL, 0, 1  },
	{ 470, "Patriot",          0,       9668,   4,   80.0,    ENGINE_TYPE_PETROL, 1, 6  },
	{ 471, "Quad",             16250,    0,       1,   6.0,     ENGINE_TYPE_PETROL, 0, 1   },
	{ 474, "Hermes",          17250,    2658,    2,   50.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 475, "Sabre",          41500,    4642,   2,   80.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 477, "ZR-350",          0,       9634,   2,   105.0,    ENGINE_TYPE_PETROL, 1, 2  },
	{ 478, "Walton",          13500,    2362,    2,   40.0,    ENGINE_TYPE_DIESEL, 0, 6   },
	{ 479, "Regina",          7500,    2259,    4,   43.0,    ENGINE_TYPE_DIESEL, 0, 5  },
	{ 480, "Comet",          180250, 8247,   2,   96.0,    ENGINE_TYPE_PETROL, 0, 1   },
	{ 481, "BMX",             500,    2017,     1,   0.0 ,    ENGINE_TYPE_NONE  , 0, 1   },
	{ 482, "Burrito",          26750,    2936,    2,   73.0,    ENGINE_TYPE_PETROL, 0, 7   },
	{ 483, "Camper",          25800,    2936,   2,   51.0,    ENGINE_TYPE_PETROL, 0, 8  },
	{ 489, "Rancher",          38500,    3958,   2,   62.0,    ENGINE_TYPE_PETROL, 0, 4  },
	{ 491, "Virgo",          24100,    2930,    2,   30.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 492, "Greenwood",         14800,    2617,   4,   42.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 496, "Blista Compact",   17750,    2774,    2,   40.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 498, "Boxville",          16500,    0,   2,      46.0,    ENGINE_TYPE_PETROL, 0, 8  },
	{ 499, "Benson",          30000,    0,     2,   40.0,    ENGINE_TYPE_PETROL, 0, 8  },
	{ 500, "Mesa",             35750,    3906,   2,   54.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 505, "Rancher",          36500,    0,     2,   69.0,    ENGINE_TYPE_PETROL, 0,  4 },
	{ 506, "Super GT",          405187, 9078,   2,   81.0,    ENGINE_TYPE_PETROL, 0, 1 },
	{ 507, "Elegant",          44750,    5252,   4,   78.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 508, "Journey",          33500,    3332,   2,   60.0,    ENGINE_TYPE_PETROL, 0,  9 },
	{ 509, "Bike",             500,    2000,     1,   0.0,    ENGINE_TYPE_NONE  , 0, 1  },
	{ 510, "Mountain Bike",      750,    2069,     1,   0.0,    ENGINE_TYPE_NONE  , 0, 1  },
	{ 516, "Nebula",          17037,    2691,   4,   72.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 517, "Majestic",          20500,    2921,   2,   44.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 518, "Buccaneer",         16500,    2591,   2,   30.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 521, "FCR-900",          280750,   0,      2,   10.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 522, "NRG-500",          0, 0,      2,   11.0,    ENGINE_TYPE_PETROL, 4, 1   },
	{ 524, "Cement Truck",      9750,    0,        2,   66.0,    ENGINE_TYPE_PETROL, 0, 5 },
	{ 525, "Tow Truck",         6000,   2198,   2,   50.0,    ENGINE_TYPE_PETROL, 0, 5 },
	{ 526, "Fortune",          19500,   2905,    2,   63.0,    ENGINE_TYPE_DIESEL, 0, 2 },
	{ 527, "Cadrona",          15600,   2504,   2,   56.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 529, "Willard",          20250,   2893,    4,   60.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 530, "Forklift",         4500,    0,      1,   25.0,    ENGINE_TYPE_DIESEL, 0, 1  },
	{ 531, "Tractor",          4500,    0,      1,   26.0,    ENGINE_TYPE_DIESEL, 0, 1  },
	{ 532, "Combine",          9750,    0,      1,   40.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 533, "Feltzer",          40250,    4168,   2,    55.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 534, "Remington",         13160,    2369,    2,    64.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 535, "Slamvan",          50700,    5426,   2,    58.0,    ENGINE_TYPE_PETROL, 0, 3  },
	{ 536, "Blade",          13500,    2376,    4,    45.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 540, "Vincent",          21400,    2910,    4,    40.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 541, "Bullet",          0,      9459,   2,   67.0,    ENGINE_TYPE_PETROL, 2, 1  },
	{ 542, "Clover",          16000,    2653,    2,    40.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 543, "Sadler",          12750,    2340,    2,    45.0,    ENGINE_TYPE_PETROL, 0 , 5   },
	{ 545, "Hustler",          59250,    6151,   2,    43.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 546, "Intruder",          13000,    2433,    4,   40.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 547, "Primo",          21000,    2928,    4,    40.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 549, "Tampa",          7500,    2257,    2,    37.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 550, "Sunrise",          25325,    2934,    4,    46.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 551, "Merit",          26785,    2939,   4,    42.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 552, "Utility",          24750,    2930,    2,    74.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 554, "Yosemite",          35000,    3787,    2,    70.0,    ENGINE_TYPE_PETROL, 0, 5  },
	{ 555, "Windsor",          126500, 8229,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 558, "Uranus",          188750, 8608,   2,   58.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 559, "Jester",          289875, 8894,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 560, "Sultan",          402820, 9031,   4,   60.0,    ENGINE_TYPE_PETROL, 0, 4  },
	{ 561, "Stratum",          40750,    4619,   4,   58.0,    ENGINE_TYPE_PETROL, 0, 4   },
	{ 562, "Elegy",          212700, 8616,   2,   64.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 565, "Flash",          110375, 8041,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 566, "Tahoma",          14750,    2524,    4,   42.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 567, "Savanna",          14500,    2501,    4,    43.0,    ENGINE_TYPE_DIESEL, 0, 4   },
	{ 568, "Bandito",          80750, 7312,   1,    30.0,    ENGINE_TYPE_PETROL, 0, 1   },
	{ 572, "Mower",          4500,    2094,    1,    10.0,    ENGINE_TYPE_DIESEL, 0, 1   },
	{ 574, "Sweeper",          3750,    2085,    1,    20.0,    ENGINE_TYPE_DIESEL, 0, 1   },
	{ 575, "Broadway",          19000,    2851,    2,    43.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 576, "Tornado",          7500,    2236,    2,    43.0,    ENGINE_TYPE_DIESEL, 0, 2  },
	{ 578, "DFT-30",          44000,    0,      2,    101.0,    ENGINE_TYPE_PETROL, 0, 6 },
	{ 579, "Huntley",          51500,    5655,   4,    75.0,    ENGINE_TYPE_PETROL, 0, 5  },
	{ 580, "Stafford",          32500,    3175,   4,    50.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 581, "BF-400",          53500,    0,       2,    6.0,     ENGINE_TYPE_PETROL, 0, 1  },
	{ 585, "Emperor",          20250,    2869,    4,    45.0,    ENGINE_TYPE_DIESEL, 0, 4  },
	{ 586, "Wayfarer",          11200,  0,       2,   7.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 587, "Euros",          60500,    5972,   2,    60.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 588, "Hotdog",          9500,    0,      2,    45.0,    ENGINE_TYPE_DIESEL, 0, 5  },
	{ 589, "Club",             20900,    2921,   2,    44.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 600, "Picador",          6000,    2165,    2,    20.0,    ENGINE_TYPE_DIESEL, 0, 2 },
	{ 602, "Alpha",          91875, 7786,   2,   55.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 603, "Phoenix",         89500, 7669,   2,   60.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 609, "Boxville",          17750,    0,      2,  70.0,    ENGINE_TYPE_PETROL, 0, 8  },
	{ 403, "Linerunner",       75000, 6812,   2,  100.0,    ENGINE_TYPE_PETROL, 0, 1  },
	{ 514, "Tanker",          60000,    6105,   2,  100.0,    ENGINE_TYPE_PETROL, 0, 2  },
	{ 515, "Roadtrain",       61750,    6392,   2,  100.0,    ENGINE_TYPE_PETROL, 0, 1   }
};


// Enums
enum E_ILEGAL_GARAGES {
	igSQLID,
	igName[ 32 ],
	igOwner,	// Spremamo njegov MySQL ID
	igVehicleIds[ 6 ],
	igBoard,
	igText[ 6 ],
	igCarsJacked,
	igWantedLevel,
	Text3D:ig3dText,
	Float:ig3dTextPos[ 3 ],
	Float:igCameraPos[ 3 ],
	Float:igCameraLookAt[ 3 ]
}
new
	IlegalGarage[ MAX_ILEGAL_GARAGES ][ E_ILEGAL_GARAGES ];
	
// rBits
static stock
	Bit1: r_CarDestroyed 		<MAX_PLAYERS> = { Bit1:false, ... },
	Bit8: r_DestroyingCarSecs 	<MAX_PLAYERS> = { Bit8:0, ... };

// 32bit
static stock
	PlayerText:JackerTD[MAX_PLAYERS] = { PlayerText:INVALID_TEXT_DRAW, ... },
	DestroyedCar[ MAX_PLAYERS ],
	JackerMoney[ MAX_PLAYERS ],
	JackerIlegalGarage[ MAX_PLAYERS ],
	Timer:DestroyingCarTimer[ MAX_PLAYERS ],
	PlayerBribeMoney[ MAX_PLAYERS ];

// TextDraws
/*static stock
	PlayerText:JackerArrow1[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... }, // Arrows
	PlayerText:JackerArrow2[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow3[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow4[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow5[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerArrow6[ MAX_PLAYERS ] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickBcg1[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... }, // Picking
	PlayerText:JackerPickBcg2[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickTitle[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickVehicle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickText[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickInfo[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickTake[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:JackerPickLeave[MAX_PLAYERS]		= { PlayerText:INVALID_TEXT_DRAW, ... };*/

// Globals
new
	// 32 bit
	PlayerJackingCar[ MAX_PLAYERS ];

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/
/*
	   _____ ______ _   _ ______ _____            _      
	  / ____|  ____| \ | |  ____|  __ \     /\   | |     
	 | |  __| |__  |  \| | |__  | |__) |   /  \  | |     
	 | | |_ |  __| | .  |  __| |  _  /   / /\ \ | |     
	 | |__| | |____| |\  | |____| | \ \  / ____ \| |____ 
	  \_____|______|_| \_|______|_|  \_\/_/    \_\______|
*/
/////////////////////////////////////////////////////
GetIllegalGarageFromSQL(sqlid)
{
	new
		garageid = -1;
	foreach(new igarage : IllegalGarage)
	{
		if(IlegalGarage[ igarage ][ igOwner ] == sqlid)
		{
			garageid = igarage;
			break;
		}
	}
	return garageid;
}

stock LoadIlegalGarages()
{
	mysql_pquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM ilegal_garages WHERE 1"), 
		"OnServerIlegalGaragesLoad",
		""
	);
	return 1;
}

forward OnServerIlegalGaragesLoad();
public OnServerIlegalGaragesLoad()
{
	if( !cache_num_rows() ) return printf( "MySQL Report: No ilegal garages exist to load.");
	for( new row = 0; row < cache_num_rows(); row++ ) 
	{
		cache_get_value_name_int( row, "id"		, IlegalGarage[ row ][ igSQLID ]);
		cache_get_value_name_int( row, "owner"		, IlegalGarage[ row ][ igOwner ]);
		cache_get_value_name( row, "name"			, IlegalGarage[ row ][ igName ], 32 );
		cache_get_value_name_int( row, "jackedcars", IlegalGarage[ row ][ igCarsJacked ]);
		cache_get_value_name_int( row, "jackedcars", IlegalGarage[ row ][ igWantedLevel ]);
		cache_get_value_name_float( row, "3dtextX"	, IlegalGarage[ row ][ ig3dTextPos ][ 0 ]);
		cache_get_value_name_float( row, "3dtextY"	, IlegalGarage[ row ][ ig3dTextPos ][ 1 ]);
		cache_get_value_name_float( row, "3dtextZ"	, IlegalGarage[ row ][ ig3dTextPos ][ 2 ]);
		cache_get_value_name_float( row, "cameraX"	, IlegalGarage[ row ][ igCameraPos ][ 0 ]);
		cache_get_value_name_float( row, "cameraY"	, IlegalGarage[ row ][ igCameraPos ][ 1 ]);
		cache_get_value_name_float( row, "cameraZ"	, IlegalGarage[ row ][ igCameraPos ][ 2 ]);
		cache_get_value_name_float( row, "lookX"	, IlegalGarage[ row ][ igCameraLookAt ][ 0 ]);
		cache_get_value_name_float( row, "lookY"	, IlegalGarage[ row ][ igCameraLookAt ][ 1 ]);
		cache_get_value_name_float( row, "lookZ"	, IlegalGarage[ row ][ igCameraLookAt ][ 2 ]);
		
		InitIlegalGarage(row);
		Iter_Add(IllegalGarage, row);
	}
	printf("MySQL Report: Ilegal Garages Loaded. [%d/%d]", cache_num_rows(), MAX_ILEGAL_GARAGES);
	return 1;
}

stock static CheckForGarageWantedLevel(garage, bool:save=false)
{
	new
		tmpStars[ 5 ];
	tmpStars = "None";
	switch( IlegalGarage[ garage ][ igCarsJacked ] ) {
		case 55 .. 95:   { IlegalGarage[ garage ][ igWantedLevel ] 	= 1; tmpStars = "*";   }
		case 96 .. 136:  { IlegalGarage[ garage ][ igWantedLevel ] 	= 2; tmpStars = "**";  }
		case 137 .. 177: { IlegalGarage[ garage ][ igWantedLevel ]	= 3; tmpStars = "***"; }
	}
	if( !save ) 
	{
		mysql_fquery(g_SQL, "UPDATE ilegal_garages SET wanted = '%d' WHERE id = '%d'", 
			IlegalGarage[ garage ][ igWantedLevel ], 
			IlegalGarage[ garage ][ igSQLID ]
		);
	}
	new
		tmpString[ 135 ];		
	format(tmpString, 135, ""COL_LIGHTBLUE"%s\n===============\n"COL_WHITE"%s"COL_LIGHTBLUE"\n===============\n"COL_LIGHTBLUE"%d$\n===============\n"COL_WHITE"%s", 
		IlegalGarage[ garage ][ igName ],
		tmpStars,
		CityInfo[cIllegalBudget],
		( IlegalGarage[ garage ][ igOwner ] != 0 ? (GetPlayerNameFromID(IlegalGarage[ garage ][ igOwner ])) : ("Na prodaju (/garage buy)") )
	);
	UpdateDynamic3DTextLabelText(IlegalGarage[ garage ][ ig3dText ], -1, tmpString);
}

bool: IsVehicleJackable(carid)
{
	new bool: value = true;
	if(!LandVehicles[carid][viCarJackerPrice])
		value = false;
	return value;
}

stock static IsVehicleOnList(garage, index)
{
	new
		returning = 0;
	for( new i=0; i < 6; i++ ) 
	{
		if( IlegalGarage[ garage ][ igVehicleIds ][ i ] == index ) 
		{
			returning = 1;
			break;
		}
	}
	return returning;
}

stock GetVehiclesForIlegalGarages(garage)
{
	new vehkinds = CountVehicleModels();
	if(vehkinds >= 6) 
	{
		new vehid, carid;
		for( new i=0; i < 6; i++ ) 
		{
			CARID_GET:
			
			vehid = Vehicle_Random(VEHICLE_USAGE_PRIVATE),
			carid = GetVehicleByModel(GetVehicleModel(vehid));
				
			if( carid == -1 ) goto CARID_GET;
			if( IsABike(GetVehicleModel(vehid)) || IsABoat(GetVehicleModel(vehid)) || IsAMotorBike(GetVehicleModel(vehid)) || IsAPlane(GetVehicleModel(vehid)) || IsAHelio(GetVehicleModel(vehid)) ) goto CARID_GET;
			if( !LandVehicles[ carid ][ viCarJackerPrice ] ) goto CARID_GET;
			if( IsVehicleOnList(garage, carid) ) goto CARID_GET;
			IlegalGarage[ garage ][ igVehicleIds ][ i ] = carid;
		}
	}
	else 
	{
		new carid, model, caridmodel;
		for( new i=0; i < 6; i++ ) 
		{
			CARID1_GET:
			
			carid = random(random(119)),
			model = carid + 400,
			caridmodel = GetVehicleByModel(model);
				
			if( carid > 119 ) goto CARID1_GET;
			if( caridmodel == -1 ) goto CARID1_GET;
			if( IsABike(model) || IsABoat(model) || IsAMotorBike(model) || IsAPlane(model) || IsAHelio(model) ) goto CARID1_GET;
			if( !LandVehicles[ caridmodel ][ viCarJackerPrice ] ) goto CARID1_GET;
			if( IsVehicleOnList(garage, caridmodel) ) goto CARID1_GET;
			IlegalGarage[ garage ][ igVehicleIds ][ i ] = caridmodel;
		}	
	}
	return 1;
}

stock UpdateIlegalGarages(garage)
{
	for( new i=0; i < 6; i++ )
		IlegalGarage[ garage ][ igVehicleIds ][ i ] = 0;

	new vehicleName[MAX_VEHICLE_NAME];
	GetVehiclesForIlegalGarages(garage);

	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 0 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 0 ]);
		IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.969,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 1 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 1 ]);
		IlegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.519,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 1 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 2 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 2 ]);
		IlegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 2 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 3 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 3 ]);
		IlegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 3 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 4 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 4 ]);
		IlegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.509,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 4 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
	
	if( IsValidDynamicObject(IlegalGarage[ garage ][ igText ][ 5 ]) ) {
		DestroyDynamicObject(IlegalGarage[ garage ][ igText ][ 5 ]);
		IlegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.959,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 5 ], 0, vehicleName, 140, "courier", 38, 1, -1, 0, 1);
	}
}

stock static InitIlegalGarage(garage)
{
	IlegalGarage[ garage ][ igBoard ] = CreateDynamicObject(3077,2534.141,-2412.661,12.619,0.000,0.000,1.799,-1,-1,-1,300.000,300.000);
	IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2534.196,-2412.609,15.439,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, "Wanted List", 140, "courier", 42, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 0 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.969,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 0 ], 0, "1", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 1 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.519,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 1 ], 0, "2", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 2 ] = CreateDynamicObject(18659,2535.047,-2412.577,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 2 ], 0, "3", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 3 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.019,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 3 ], 0, "6", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 4 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.509,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 4 ], 0, "5", 140, "courier", 38, 1, -1, 0, 1);
	IlegalGarage[ garage ][ igText ][ 5 ] = CreateDynamicObject(18659,2533.346,-2412.641,14.959,0.000,0.000,-87.900,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(IlegalGarage[ garage ][ igText ][ 5 ], 0, "4", 140, "courier", 38, 1, -1, 0, 1);
	UpdateIlegalGarages(garage);
	
	IlegalGarage[ garage ][ ig3dText ] = CreateDynamic3DTextLabel("*", -1, IlegalGarage[ garage ][ ig3dTextPos ][ 0 ], IlegalGarage[ garage ][ ig3dTextPos ][ 1 ], IlegalGarage[ garage ][ ig3dTextPos ][ 2 ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 30.0);
	CheckForGarageWantedLevel(garage);
	return 1;
}

/*
		 __               __                 
		|__|____    ____ |  | __ ___________ 
		|  \__  \ _/ ___\|  |/ // __ \_  __ \
		|  |/ __ \\  \___|    <\  ___/|  | \/
	/\__|  (____  /\___  >__|_ \\___  >__|   
	\______|    \/     \/     \/    \/       
*/
stock static ResetCarJackerVariables(playerid)
{
	// rBits
	Bit1_Set(r_CarDestroyed, 			playerid, false);
	Bit1_Set(gr_PlayerPickingJack, 		playerid, false);
	Bit1_Set(gr_PlayerJackSure, 		playerid, false);
	Bit8_Set(r_DestroyingCarSecs, 		playerid, 0);

	DestroyJackerTextDraw(playerid);
	
	// 32bit
	DestroyedCar[ playerid ]			= 0;
	PlayerJackingCar[ playerid ]		= -1;
	JackerIlegalGarage[ playerid ]		= -1;
	JackerMoney[ playerid ]				= 0;
	stop DestroyingCarTimer[ playerid ];
	return 1;
}

stock static IsVehicleMission(playerid, modelid)
	return ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ] == modelid ? 1 : 0 );

stock static IsVehicleOnJackingList(garage, playercar)
{
	new
		index = 0;
	for( new i=0; i < 6; i++ ) {
		if( IlegalGarage[ garage ][ igVehicleIds ][ i ] == playercar ) {
			index = 1;
			break;
		}
	}
	return index;
}
	
timer DestroyingCar[1000](playerid, vehicleid)
{
	if(JackerIlegalGarage[playerid] == -1)
	{
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta zbog greske!");
		return 0;
	}
	if( !IsPlayerInRangeOfVehicle(playerid, vehicleid, 18.0) ) 
	{
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radnja je prekinuta jer niste blizu vozila!");
		return 1;			
	}
	
	Bit8_Set( r_DestroyingCarSecs, playerid, Bit8_Get( r_DestroyingCarSecs, playerid )-1 );
	
	new
		tmpString[ 69 ];
	format(tmpString, 69, "~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~%d", Bit8_Get( r_DestroyingCarSecs, playerid ));
	PlayerTextDrawSetString(playerid, JackerTD[playerid], tmpString);
	
	if( !Bit8_Get( r_DestroyingCarSecs, playerid ) ) {
		new 
			panels, doors, lights, tires,
			front_left_panel, front_right_panel, rear_left_panel, rear_right_panel, windshield, front_bumper, rear_bumper,
			bonnet, boot, 
			driver_door, passenger_door, light1, light2, 
			light3, light4, tire1, tire2, tire3, tire4;
		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		
		decode_panels(panels,front_left_panel, front_right_panel, rear_left_panel, rear_right_panel, windshield, front_bumper, rear_bumper);
		decode_doors(doors, bonnet, boot, driver_door, passenger_door);
		decode_lights(lights, light1, light2, light3, light4);
		decode_tires(tires, tire1, tire2, tire3, tire4);
	
		// Money
		new
			skillmoney = ((GetPlayerSkillLevel(playerid, 6) + 2) * 10),
			garage = JackerIlegalGarage[ playerid ],
			decrease = front_left_panel + front_right_panel + rear_left_panel + rear_right_panel + windshield + front_bumper + rear_bumper + bonnet + boot + driver_door + passenger_door + light1 + light2 + light3 + light4 + tire1 + tire2 + tire3 + tire4,
			value = ( ( LandVehicles[ PlayerJackingCar[ playerid ] ][ viCarJackerPrice ] + skillmoney )  - ( decrease * 15 ) );
		
		IlegalGarage[ garage ][ igCarsJacked ]++;
		
		// Damage
		VehicleInfo[ vehicleid ][ vPanels ]		= encode_panels(1, 1, 1, 1, 3, 3, 3); 
		VehicleInfo[ vehicleid ][ vDoors ]		= encode_doors(4, 4, 4, 4, 0, 0);
		VehicleInfo[ vehicleid ][ vLights ]		= encode_lights(1, 1, 1, 1);
		VehicleInfo[ vehicleid ][ vTires ]		= encode_tires(1, 1, 1, 1);
		UpdateVehicleDamageStatus(vehicleid, VehicleInfo[ vehicleid ][ vPanels ], VehicleInfo[ vehicleid ][ vDoors ], VehicleInfo[ vehicleid ][ vLights ], VehicleInfo[ vehicleid ][ vTires ]);
		VehicleInfo[ vehicleid][ vTrunk ] = VEHICLE_PARAMS_ON;
		SetVehicleHealth(vehicleid, 388);
	
		// Finish
		JackerMoney[ playerid ] = value; // priprema novca koji pise sa leave
		//SendPoliceAlertMessage(vehicleid, garage);
		DestroyedCar[playerid] = GetVehicleModel(vehicleid);
		Bit1_Set(r_CarDestroyed, playerid, true);
		DestroyJackerTextDraw(playerid);
		stop DestroyingCarTimer[playerid];
		
		SendClientMessage(playerid,COLOR_RED, "Uspjesno ste rastavili vozilo. Sakrijte ga da biste dobili svoj novac! (/jacker leave)");
	}
	return 1;
}

stock static GetJackerIlegalGarage(playerid)
{
	new
		index = -1;
	if( IsPlayerInRangeOfPoint(playerid, 10.0, 2534.1411, -2412.6609, 12.6190) ) index = 0;
	return index;
}
/*
stock static SendPoliceAlertMessage(vehicleid, garage)
{
	if( IlegalGarage[ garage ][ igWantedLevel ] < 2 ) {
		switch( random(random(20)) ) {
			case 1, 3, 8, 10, 12, 17: {
				foreach(new playerid : Player) {
					if( IsACop(playerid) ) {
						new vehicleName[MAX_VEHICLE_NAME];
						GetVehicleNameById(vehicleid, vehicleName, MAX_VEHICLE_NAME);

						SendClientMessage( playerid, COLOR_LIGHTBLUE, "*________________________ [ CAR STEAL] ________________________*");
						va_SendClientMessage(playerid, -1, "\tModel vozila: %s", vehicleName);
						va_SendClientMessage(playerid, -1, "\tBoja vozila: %d %d", VehicleColor1[vehicleid], VehicleColor2[vehicleid]);
						va_SendClientMessage(playerid, -1, "\tLokacija vozila: %s", GetVehicleZone( vehicleid ));
						SendClientMessage( playerid, COLOR_LIGHTBLUE, "*____________________________________________________________________*");
					}
				}
			}
		}
	} else {
		foreach(new playerid : Player) {
			if( IsACop(playerid) ) 
			{
				new vehicleName[MAX_VEHICLE_NAME];
				GetVehicleNameById(vehicleid, vehicleName, MAX_VEHICLE_NAME);

				SendClientMessage( playerid, COLOR_LIGHTBLUE, "*________________________ [ CAR STEAL ] ________________________*");
				va_SendClientMessage(playerid, -1, "\tModel vozila: %s", vehicleName);
				va_SendClientMessage(playerid, -1, "\tBoja vozila: %d %d", VehicleColor1[vehicleid], VehicleColor2[vehicleid]);
				va_SendClientMessage(playerid, -1, "\tLokacija vozila: %s", GetVehicleZone( vehicleid ));
				SendClientMessage( playerid, COLOR_LIGHTBLUE, "*____________________________________________________________________*");
			}
		}
	}
	return 1;
}
*/
stock static DestroyJackerTextDraw(playerid)
{
	if( JackerTD[playerid] != PlayerText:INVALID_TEXT_DRAW ) 
	{
		PlayerTextDrawDestroy( playerid, JackerTD[playerid] );
		JackerTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreateJackerTextDraw(playerid)
{
	DestroyJackerTextDraw(playerid);
	JackerTD[playerid] = CreatePlayerTextDraw(playerid, 100.0, 310.0, "              ");
    PlayerTextDrawFont(playerid, 		JackerTD[playerid], 2);
    PlayerTextDrawLetterSize(playerid, 	JackerTD[playerid], 0.249, 1.000000);
    PlayerTextDrawSetShadow(playerid, 	JackerTD[playerid], 1);
	PlayerTextDrawShow(playerid, 		JackerTD[playerid]);
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
	LoadIlegalGarages();
	return continue();

}

hook OnGameModeInit()
{
	CreateDynamicObject(11387,2526.132,-2425.633,15.899,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11390,2530.332,-2407.504,16.910,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11389,2530.364,-2407.572,15.679,0.000,0.000,-43.499,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11393,2530.058,-2414.572,14.176,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11391,2518.897,-2407.879,13.898,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11388,2530.358,-2407.478,19.326,0.000,0.000,-43.500,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11359,2515.739,-2416.442,14.674,0.000,0.000,-43.300,-1,-1,-1,300.000,300.000);
	CreateDynamicObject(11360,2539.552,-2411.309,14.714,0.000,0.000,136.499,-1,-1,-1,300.000,300.000);
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 3707, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2546.046, -2396.593, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2571.164, -2421.132, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3707, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2539.179, -2424.359, 20.492, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2546.046, -2396.593, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2571.164, -2421.132, 13.171, 0.250);
	return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetCarJackerVariables(playerid);
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_JACKER_PICK:
	    {
	        if(!response)
	            return SendClientMessage(playerid, COLOR_RED, "Odustali ste od posla!");
	            
            new
				garage = JackerIlegalGarage[ playerid ],
				vehicleName[MAX_VEHICLE_NAME];

			GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ listitem ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste vozilo %s!", vehicleName);
            
			va_ShowPlayerDialog(playerid, DIALOG_JACKER_SURE_1, DIALOG_STYLE_MSGBOX, "Odabir vozila", "Jeste li sigurni da Zelite zapoceti %s misiju?", "Yes", "No", vehicleName);
            PlayerJackingCar[playerid] = IlegalGarage[garage][igVehicleIds][listitem];
			return 1;
	    }
	    case DIALOG_JACKER_SURE_1:
	    {
     		if(!response)
	            return SendClientMessage(playerid, COLOR_RED, "Odustali ste od posla!"), PlayerJackingCar[ playerid ] = -1;
	    	new vehicleName[MAX_VEHICLE_NAME];
			GetVehicleNameByModel(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
	        SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Odabrali ste %s misiju. Ona se prekida kada odete offline!", vehicleName);
		}
		case DIALOG_JACKER_SURE_2: 
		{
			if( !response ) return 1;			
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uspjesno ste prekinuli Car Jacker misiju!");
			PlayerJackingCar[ playerid ] = -1;
			UpdateIlegalGarages(JackerIlegalGarage[playerid]);
			return 1;
		}
		case DIALOG_JACKER_BRIBE: {
			if( !response ) return 1;
			IlegalGarage[ PlayerKeys[playerid][pIllegalGarageKey] ][ igWantedLevel ]	= 0;
			IlegalGarage[ PlayerKeys[playerid][pIllegalGarageKey] ][ igCarsJacked ]	= 0;
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste spustili wanted level na 0!");
			PlayerToFactionMoney( playerid, FACTION_TYPE_LAW, PlayerBribeMoney[ playerid ]); // Novac dolazi u PD factionbank
			PlayerBribeMoney[ playerid ] = 0;
			return 1;
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

CMD:update_garage(playerid,params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1338 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
	new
		garage;
	if( sscanf(params, "i", garage) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /update_garage [garageid]");
	UpdateIlegalGarages(garage);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste updejtali garazu id %d.", garage);
	return 1;
}

CMD:jacker(playerid, params[])
{
	if( PlayerJob[playerid][pJob] != JACKER_JOB_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste car jacker!");
	new
		param[ 7 ];
	if( sscanf( params, "s[7] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jacker [pick/chop/leave/stop]");
	if( !strcmp(param, "pick", true) ) 
	{
		JackerIlegalGarage[ playerid ] = GetJackerIlegalGarage(playerid);
		if( JackerIlegalGarage[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( PlayerCoolDown[playerid][pJackerCool] <= gettimestamp()) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mora proci 60 minuta od zadnje isporuke za novu misiju!");
		if( PlayerJackingCar[ playerid ] != -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vasa misija i dalje traje! Kucajte /jacker stop za odustanak.");

		new
			garage = JackerIlegalGarage[ playerid ];

		new
			vehicles_str[104],
			vehicleName[6][MAX_VEHICLE_NAME];
				
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 0 ] ][ viModelid ], vehicleName[0], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 1 ] ][ viModelid ], vehicleName[1], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 2 ] ][ viModelid ], vehicleName[2], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 3 ] ][ viModelid ], vehicleName[3], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 4 ] ][ viModelid ], vehicleName[4], MAX_VEHICLE_NAME);
		GetVehicleNameByModel(LandVehicles[ IlegalGarage[ garage ][ igVehicleIds ][ 5 ] ][ viModelid ], vehicleName[5], MAX_VEHICLE_NAME);

		format(vehicles_str, sizeof(vehicles_str), "%s\n%s\n%s\n%s\n%s\n%s",
		    vehicleName[0],
		    vehicleName[1],
		    vehicleName[2],
		    vehicleName[3],
		    vehicleName[4],
		    vehicleName[5]
		);
		ShowPlayerDialog(playerid, DIALOG_JACKER_PICK, DIALOG_STYLE_LIST, "Odaberite vozilo", vehicles_str, "Choose", "Abort");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Odaberite vozilo koje zelite ukrasti!");
	}
	else if( !strcmp(param, "chop", true) ) {
		new
			Float:health,
			vehicleid = GetPlayerVehicleID(playerid);
			//garage = JackerIlegalGarage[ playerid ];
		GetVehicleHealth(vehicleid, health);
		
		if( PlayerJackingCar[ playerid ] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate uzeti misiju!");
		if( vehicleid == PlayerKeys[playerid][pVehicleKey] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete svoje vozilo uzeti!");
		if( !Vehicle_Exists(VEHICLE_USAGE_PRIVATE, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo koje ste ukrali treba biti privatno, a ne iznajmljeno ili organizacijsko!");
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
		if( health < 550.0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo mora biti u boljem stanju (550+ HPa)!");
		
		if( GetJackerIlegalGarage(playerid) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod pickupa za ostavljanje vozila!");
		if( !IsVehicleMission(playerid, GetVehicleModel(vehicleid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo niste uzeli kao misiju!");
		
		new
			money = floatround(( LandVehicles[ PlayerJackingCar[ playerid ] ][ viCarJackerPrice ] + 48 ) * 0.25);
		if( CityInfo[cIllegalBudget] <= money ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nema dovoljno novca (%d$)!", money);
		
		RemovePlayerFromVehicle(playerid);
		SetVehiclePos(vehicleid, 2520.0364, -2412.6516, 13.7);
		Bit8_Set(r_DestroyingCarSecs, playerid, 30);
		CreateJackerTextDraw(playerid);
		PlayerTextDrawSetString(playerid, JackerTD[playerid], "~w~Rastavljanje vozila u tijeku~r~... ~n~~w~Preostalo sekundi: ~r~30");
		DestroyingCarTimer[playerid] = repeat DestroyingCar(playerid, vehicleid);
	}
	else if( !strcmp(param, "leave", true) ) {
		if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
		if( !DestroyedCar[playerid] || DestroyedCar[playerid] != GetVehicleModel(GetPlayerVehicleID(playerid)) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo nije unisteno!");
		if(	PlayerJackingCar[ playerid ] < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste izabrali misiju.");
		if(	IsPlayerInRangeOfPoint(playerid, 200.0, 2535.6685,-2408.7539,13.6301) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste dovoljno daleko sakrili vozilo!");
	
		new
			garage = JackerIlegalGarage[ playerid ],
			vehicleName[MAX_VEHICLE_NAME];	

		IllegalBudgetToPlayerMoney(playerid, JackerMoney[ playerid ]); // ilegalni budget se updatea i igrac dobiva novce
		
		IlegalGarage[ garage ][ igCarsJacked ]++;
		mysql_fquery(g_SQL, "UPDATE ilegal_garages SET jackedcars = '%d' WHERE id = '%d'", 
			IlegalGarage[ garage ][ igCarsJacked ], 
			IlegalGarage[ garage ][ igSQLID ]
		);
				
		GetVehicleNameByModel(LandVehicles[ PlayerJackingCar[ playerid ] ][ viModelid ], vehicleName, MAX_VEHICLE_NAME);
		SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste zavrsili %s jacker misiju i zaradili %i$.", vehicleName, JackerMoney[ playerid ]);
				
		PlayerJackingCar[ playerid ] = -1;
		JackerMoney[ playerid ]	= 0;
		PlayerCoolDown[playerid][pJackerCool] = gettimestamp(); // svakih sat vremena moze odradit jedan posao.
		UpdateIlegalGarages(garage);
		CheckForGarageWantedLevel(garage, true);
		UpgradePlayerSkill(playerid);
	}
	else if( !strcmp(param, "stop", true) ) {
		if( PlayerJackingCar[ playerid ] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate aktivnu misiju!");
		ShowPlayerDialog(playerid, DIALOG_JACKER_SURE_2, DIALOG_STYLE_MSGBOX, "Jacker misija", "Zelite li odustati od misije?\n"COL_RED"NAPOMENA: Ukoliko odustanete cooldown od 45 minuta se primjenuje!", "Quit", "Back");
	}
	return 1;
}

CMD:igarage(playerid, params[])
{
	new
		param[ 8 ];
	if( sscanf( params, "s[8] ", param ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /igarage [options]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buy - info - bribe");
		return 1;
	}
	if( !strcmp(param, "buy", true) ) {
		if( PlayerKeys[playerid][pIllegalGarageKey] != -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate ilegalnu garazu!");
		if( AC_GetPlayerMoney(playerid) < 60000 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca za kupovinu ilegalne garaze (60.000$)!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu car jacker garaze!");
		if( IlegalGarage[ garage ][ igOwner ] != 0 || IlegalGarage[ garage ][ igOwner ] != 9999 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Garaza nije na prodaju!");
		PlayerKeys[playerid][pIllegalGarageKey] = garage;
		IlegalGarage[ garage ][ igOwner ] = PlayerInfo[ playerid ][ pSQLID ];
		CheckForGarageWantedLevel(garage, true);
		PlayerToIllegalBudgetMoney(playerid, 60000); // Novac dolazi u ilegalni proracun
	}
	else if( !strcmp(param, "info", true) ) {
		if( PlayerKeys[playerid][pIllegalGarageKey] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete ilegalnu garazu!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		va_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST, "Ilegal Garage - Info", "Ime:\t%s\nWanted level:\t%d\nAuta ukradeno:\t%d", "OK", "", IlegalGarage[ garage ][ igName ], IlegalGarage[ garage ][ igWantedLevel ], IlegalGarage[ garage ][ igCarsJacked ]);
	}
	else if( !strcmp(param, "bribe", true) ) {
		if( PlayerKeys[playerid][pIllegalGarageKey] == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete ilegalnu garazu!");
		new
			garage = GetJackerIlegalGarage(playerid);
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze/Nemate garazu!");
		if( IlegalGarage[ garage ][ igWantedLevel ] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati 2+ zvjezdica!");
		new
			money = ( IlegalGarage[ garage ][ igWantedLevel ] * ( random(random(250)) + 1 ) ) + ( IlegalGarage[ garage ][ igCarsJacked ] * 1000 );
		PlayerBribeMoney[ playerid ] = money;
		va_ShowPlayerDialog(playerid, DIALOG_JACKER_BRIBE, DIALOG_STYLE_MSGBOX, "Ilegal Garage - Bribe", "Zelite li podmititi policiju da vam spuste wanted level na 0?\nOna ce kostati %d$!", "Bribe", "Abort", money);
	}
	/*else if( !strcmp(param, "money", true) ) {
		new
			garage = GetJackerIlegalGarage(playerid),
			pick[ 4 ],
			money;
		
		if( garage == -1 || IlegalGarage[ garage ][ igOwner ] != PlayerInfo[ playerid ][ pSQLID ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu svoje car jacker garaze ili nemate garazu!");
		if( sscanf( params, "s[8]s[8]i", param, pick, money ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /igarage money [take/put][kolicina]");
		if( !strcmp(pick, "take", true) ) {
			if( money >  IlegalGarage[ garage ][ igMoney ] || money < 1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u garazi!");
			
			IlegalGarage[ garage ][ igMoney ] -= money;
			AC_GivePlayerMoney(playerid, money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste uzeli %d$ iz ilegalne garaze!", money);
		}
		else if( !strcmp(pick, "put", true) ) {
			if( money < 1 || money > AC_GetPlayerMoney(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novaca u ruci!");
			
			IlegalGarage[ garage ][ igMoney ] += money;
			AC_GivePlayerMoney(playerid, -money);
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste stavili %d$ u ilegalnu garazu!", money);
		}
	}*/
	return 1;
}
