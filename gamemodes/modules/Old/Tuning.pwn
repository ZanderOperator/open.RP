#include <YSI_Coding\y_hooks>

#if defined MODULE_TUNING
	#endinput
#endif
#define MODULE_TUNING

// Main
#define INVALID_TUNING_SLOT		( 7 )
#define TUNE_PREVIEW_TIME		( 3500 )

// Vehicle tuning ID
#define TUNE_ID_WHEELSARCH		( 0 )
#define TUNE_ID_LOCOLOW			( 1 )
#define TUNE_ID_TRANSFEN       	( 2 )

/*
	######## ##    ## ##     ## ##     ## 
	##       ###   ## ##     ## ###   ### 
	##       ####  ## ##     ## #### #### 
	######   ## ## ## ##     ## ## ### ## 
	##       ##  #### ##     ## ##     ## 
	##       ##   ### ##     ## ##     ## 
	######## ##    ##  #######  ##     ## 
*/

enum E_TUNING_DATA
{
	tdComponent[ 7 ],
	tdPaintJob
}
new
	TuningInfo[ MAX_VEHICLES ][ E_TUNING_DATA ];
	
enum E_CAR_MOD_DATA {
	modName[ 64 ],
	modPrice
}
new 
	ComponentInfo[ ][ E_CAR_MOD_DATA ] = {
	{"Pro Spoiler",                            	5000 },//1000
	{"Win Spoiler",                            	5000 },//1001
	{"Drag Spoiler",                           	5000 },//1002
	{"Alpha Spoiler",                          	5000 },//1003
	{"Champ Scoop Hood",                       	2500 },//1004
	{"Fury Scoop Hood",                        	2700 },//1005
	{"Roof Scoop",                             	6000 },//1006
	{"Right Sideskirt",                        	1500 },//1007
	{"5x Nitro",                               	40000 },//1008
	{"2x Nitro",                               	25000 },//1009
	{"10x Nitro",                              	60000 },//1010
	{"Race Scoop Hood",                        	3000 },//1011
	{"Worx Scoop Hood",                        	3100 },//1012
	{"Round Fog Lamps",                        	1500 },//1013
	{"Champ Spoiler",                          	5500 },//1014
	{"Race Spoiler",                           	5500 },//1015
	{"Worx Spoiler",                           	5500 },//1016
	{"Left Sideskirt",                         	1700 },//1017
	{"Upswept Exhaust",                        	6500 },//1018
	{"Twin Exhaust",                           	6900 },//1019
	{"Large Exhaust",                          	7200 },//1020
	{"Medium Exhaust",                         	6250 },//1021
	{"Small Exhaust",                          	5950 },//1022
	{"Fury Spoiler",                           	5550 },//1023
	{"Square Fog Lamps",                       	1500 },//1024
	{"Offroad Wheels",                         	3000 },//1025
	{"Right Alien Sideskirt",                 	1850 },//1026
	{"Left Alien Sideskirt",                  	1850 },//1027
	{"Alien Exhaust",                         	7500 },//1028
	{"X-Flow Exhaust",                        	7800 },//1029
	{"Left X-Flow Sideskirt",                 	1880 },//1030
	{"Right X-Flow Sideskirt",                	1880 },//1031
	{"Alien Roof Vent",                       	6300 },//1032
	{"X-Flow Roof Vent",                      	6300 },//1033
	{"Alien Exhaust",                          	7250 },//1034
	{"X-Flow Roof Vent",                       	6150 },//1035
	{"Right Alien Sideskirt",                  	1800 },//1036
	{"X-Flow Exhaust",                         	7250 },//1037
	{"Alien Roof Vent",                        	6150 },//1038
	{"Right X-Flow Sideskirt",                 	1800 },//1039
	{"Left Alien Sideskirt",                   	1800 },//1040
	{"Right X-Flow Sideskirt",                 	1800 },//1041
	{"Right Chrome Sideskirt",              	1500 },//1042
	{"Slamin Exhaust",                      	5500 },//1043
	{"Chrome Exhaust",                      	5550 },//1044
	{"X-Flow Exhaust",                       	6800 },//1045
	{"Alien Exhaust",                        	6850 },//1046
	{"Right Alien Sideskirt",                	1750 },//1047
	{"Right X-Flow Sideskirt",               	1750 },//1048
	{"Alien Spoiler",                        	1550 },//1049
	{"X-Flow Spoiler",                       	1550 },//1050
	{"Left Alien Sideskirt",                 	1750 },//1051
	{"Left X-Flow Sideskirt",                	1750 },//1052
	{"X-Flow Roof",                          	6200 },//1053
	{"Alien Roof",                           	6200 },//1054
	{"Alien Roof",                           	6200 },//1055
	{"Right Alien Sideskirt",                	2350 },//1056
	{"Right X-Flow Sideskirt",               	2350 },//1057
	{"Alien Spoiler",                        	1600 },//1058
	{"X-Flow Exhaust",                       	6900 },//1059
	{"X-Flow Spoiler",                       	1650 },//1060
	{"X-Flow Roof",                          	6220 },//1061
	{"Left Alien Sideskirt",                 	2350 },//1062
	{"Left X-Flow Sideskirt",                	2300 },//1063
	{"Alien Exhaust",                        	6950 },//1064
	{"Alien Exhaust",							7150 },
	{"X-Flow Exhaust",							7180 },
	{"Alien Roof",                             	6500 },
	{"X-Flow Roof",                            	6500 },
	{"Right Alien Sideskirt",					2350 },
	{"Right X-Flow Sideskirt",                	2350 },//1070
	{"Left Alien Sideskirt",					2350 },
	{"Left X-Flow Sideskirt",                  	2350 },
	{"Shadow Wheels",							6500 },				
	{"Mega Wheels",                            	6500 },
	{"Rimshine Wheels",                        	6500 },
	{"Wires Wheels",                           	6500 },
	{"Classic Wheels",                         	6500 },
	{"Twist Wheels",                           	6500 },
	{"Cutter Wheels",                          	6500 },
	{"Switch Wheels",                     		6500 },//1080
	{"Grove Wheels",                           	6500 },
	{"Import Wheels",                          	6500 },
	{"Dollar Wheels",                          	6500 },
	{"Trance Wheels",                          	6500 },
	{"Atomic Wheels",                          	6500 },
	{"Stereo Sound",							0 },
	{"Hydraulics",								9000 },
	{"Alien Roof",								6700 },
	{"X-Flow Exhaust",							7300 },
	{"Right Alien Sideskirt",					1790 },//1090
	{"X-Flow Roof",								6750 },
	{"Alien Exhaust",							7360 },
	{"Right X-Flow Sideskirt",                 	1790 },
	{"Left Alien Sideskirt",                   	1790 },
	{"Right X-Flow Sideskirt",					1790 },
	{"Ahab Wheels",								5100 },
	{"Virtual Wheels",                         	5100 },
	{"Access Wheels",                          	5100 },
	{"Left Chrome Sideskirt",					1500 },
	{"Chrome Grill Bullbar",     				9500 },//1100
	{"Chrome Flames Sideskirt",					2000 },
	{"Chrome Strip Sideskirt",                 	1900 },
	{"Corvetible Roof",							10000 },
	{"Chrome Exhaust",							6450 },
	{"Slamin Exhaust",							6500 },
	{"Chrome Arches Sideskirt",					1900 },
	{"Chrome Strip Sideskirt",					1700 },
	{"Chrome Strip Sideskirt",                	1700 },
	{"Chrome Rear Bullbars",					9000 },
	{"Slamin Rear Bullbars",                 	9050 },//1110
	{"Little Front Sign",						1500 },
	{"Little Front Sign",                      	1500 },
	{"Chrome Exhaust",							6600 },
	{"Slamin Exhaust",							6600 },
	{"Chrome Front Bullbars",					9100 },
	{"Slamin Front Bullbars",					9150 },
	{"Chrome Front Bumper",						9100 },
	{"Chrome Trim Sideskirt",					2350 },
	{"Wheelcovers Sideskirt",					2350 },
	{"Chrome Trim Sideskirt",         			2350 },//1120
	{"Wheelcovers Sideskirt",					1800 },
	{"Chrome Flames Sideskirt",					1850 },
	{"Bullbar Chrome Bars",						9000 },
	{"Chrome Arches Sideskirt",					1800 },
	{"Bullbar Chrome Lights",					10000 },
	{"Chrome Exhaust",							6700 },
	{"Slamin Exhaust",							6750 },
	{"Vinyl Hardtop",							9950 },
	{"Chrome Exhaust",							7000 },
	{"Hardtop Roof",                         	10100 },//1130
	{"Softtop Roof",							9980 },
	{"Slamin Exhaust",							7100 },
	{"Chrome Strip Sideskirt",					1850 },
	{"Chrome Strip Sideskirt",					1600 },
	{"Slamin Exhaust",							6550 },
	{"Chrome Exhaust",							6600 },
	{"Chrome Strip Sideskirt",					1650 },
	{"Alien Spoiler",							1850 },
	{"X-Flow Spoiler",							1900 },
	{"X-Flow Rear Bumper",                    	9350 },//1140
	{"Alien Rear Bumper",						9400 },
	{"Left Oval Vents",							1500 },
	{"Right Oval Vents",						1500 },
	{"Left Square Vents",						1550 },
	{"Right Square Vents",						1550 },
	{"X-Flow Spoiler",							1750 },
	{"Alien Spoiler",							1800 },
	{"X-Flow Rear Bumper",						9100 },
	{"Alien Rear Bumper",						9150 },
	{"Alien Rear Bumper",                      	9000 },//1150
	{"X-Flow Rear Bumper",						9000 },
	{"X-Flow Front Bumper",						9000 },
	{"Alien Front Bumper",						9000 },
	{"Alien Rear Bumper",                      	9000 },
	{"Alien Front Bumper",						9000 },
	{"X-Flow Rear Bumper",						9000 },
	{"X-Flow Front Bumper",						9000 },
	{"X-Flow Spoiler",							1850 },
	{"Alien Rear Bumper",						13000 },
	{"Alien Front Bumper",                    	14000 },//1160
	{"X-Flow Rear Bumper",						8950 },
	{"Alien Spoiler",							1900 },
	{"X-Flow Spoiler",                         	1850 },
	{"Alien Spoiler",							1900 },
	{"X-Flow Front Bumper",						8950 },
	{"Alien Front Bumper",     					8950 },
	{"X-Flow Rear Bumper",     					8950 },
	{"Alien Rear Bumper",      					8950 },
	{"Alien Front Bumper",						9300 },
	{"X-Flow Front Bumper",                   	9250 },//1170
	{"Alien Front Bumper",						9200 },
	{"X-Flow Front Bumper",                    	9150 },
	{"X-Flow Front Bumper",						9000 },
	{"Chrome Front Bumper",						8550 },
	{"Slamin Front Bumper",	                	8550 },
	{"Chrome Rear Bumper",	                    8550 },
	{"Slamin Rear Bumper",	                    8550 },
	{"Slamin Rear Bumper",						8260 },
	{"Chrome Front Bumper",                    	8260 },
	{"Chrome Rear Bumper",                 		8260 },//1180
	{"Slamin Front Bumper",                    	8150 },
	{"Chrome Front Bumper",                    	8150 },
	{"Slamin Rear Bumper",                     	8150 },
	{"Chrome Rear Bumper",						8150 },
	{"Slamin Front Bumper",						8260 },
	{"Slamin Rear Bumper",						8360 },
	{"Chrome Rear Bumper",                     	8360 },
	{"Slamin Front Bumper",                    	8360 },
	{"Chrome Front Bumper",						8360 },
	{"Slamin Front Bumper",                  	8050 },//1190
	{"Chrome Front Bumper",                    	8050 },
	{"Chrome Rear Bumper",                     	8050 },
	{"Slamin Rear Bumper",                      8050 }
};

enum E_TUNING_CAMERA_DATA
{
	Float:tcCameraX,
	Float:tcCameraY,
	Float:tcCameraZ
}
static stock
	TuneCamera[ 10 ][ E_TUNING_CAMERA_DATA ] = {
		{ 605.9730, -2.6803, 1002.3000 }, 
		{ 607.1622,  1.3903, 1000.6340 }, // Front Bumper
		{ 613.9386,  0.7310, 1000.5500 }, // Skirt
		{ 615.4967, -1.4875, 1000.7200 }, // Rear Bumper
		{ 615.5425, -1.9973, 1000.4500 }, // Exhaust
		{ 616.4401, -1.7012, 1001.5500 }, // Spoiler
		{ 613.4433, -4.2818, 1000.2500 }, // Wheels
		{ 608.5042, -2.1542, 1000.1800 }, // Lamps
		{ 608.9442, -1.3773, 1000.0800 }, // Vents
		{ 609.1279, -1.5637, 1002.0000 } // Roof
	};

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
stock const
	legalWheels[ 3 ][ 11 ] = {
		{ TUNE_ID_WHEELSARCH,  	1079, 1075, 1074, 1081, 1080, 1073, 1085, 1082, 1083, 1077 },
		{ TUNE_ID_LOCOLOW,		1077, 1083, 1078, 1076, 1084, 1079, 1075, 1097, 1098, 0000 },
		{ TUNE_ID_TRANSFEN,		1082, 1085, 1096, 1097, 1098, 1025, 1074, 1081, 1078, 1076 }
	};

stock const 
	legalmods[48][19] = {		
        {400, 1024,1021,1020,1019,1018,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {401, 1145,1144,1143,1142,1020,1019,1017,1013,1007,1006,1005,1004,1003,1001,0000,0000,0000,0000},
        {404, 1021,1020,1019,1017,1016,1013,1007,1002,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {405, 1023,1021,1020,1019,1018,1014,1001,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {410, 1024,1023,1021,1020,1019,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {415, 1023,1019,1018,1017,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {418, 1021,1020,1016,1006,1002,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {420, 1021,1019,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {421, 1023,1021,1020,1019,1018,1016,1014,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {422, 1021,1020,1019,1017,1013,1007,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {426, 1021,1019,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {436, 1022,1021,1020,1019,1017,1013,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {439, 1145,1144,1143,1142,1023,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {477, 1021,1020,1019,1018,1017,1007,1006,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {478, 1024,1022,1021,1020,1013,1012,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {489, 1024,1020,1019,1018,1016,1013,1006,1005,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {491, 1145,1144,1143,1142,1023,1021,1020,1019,1018,1017,1014,1007,1003,0000,0000,0000,0000,0000},
        {492, 1016,1006,1005,1004,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {496, 1143,1142,1023,1020,1019,1017,1011,1007,1006,1003,1002,1001,0000,0000,0000,0000,0000,0000},
        {500, 1024,1021,1020,1019,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {516, 1021,1020,1019,1018,1017,1016,1015,1007,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {517, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1016,1007,1003,1002,0000,0000,0000,0000,0000},
        {518, 1145,1144,1143,1142,1023,1020,1018,1017,1013,1007,1006,1005,1003,1001,0000,0000,0000,0000},
        {527, 1021,1020,1018,1017,1015,1014,1007,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {529, 1023,1020,1019,1018,1017,1012,1011,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000},
        {534, 1185,1180,1179,1178,1127,1126,1125,1124,1123,1122,1106,1101,1100,0000,0000,0000,0000,0000},
        {535, 1121,1120,1119,1118,1117,1116,1115,1114,1113,1110,1109,0000,0000,0000,0000,0000,0000,0000},
        {536, 1184,1183,1182,1181,1128,1108,1107,1105,1104,1103,0000,0000,0000,0000,0000,0000,0000,0000},
        {540, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1004,1001,0000,0000,0000,0000},
        {542, 1145,1144,1021,1020,1019,1018,1015,1014,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {546, 1145,1144,1143,1142,1024,1023,1019,1018,1017,1007,1006,1004,1002,1001,0000,0000,0000,0000},
        {547, 1143,1142,1021,1020,1019,1018,1016,1003,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {549, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1012,1011,1007,1003,1001,0000,0000,0000,0000},
        {550, 1145,1144,1143,1142,1023,1020,1019,1018,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000},
        {551, 1023,1021,1020,1019,1018,1016,1006,1005,1003,1002,0000,0000,0000,0000,0000,0000,0000,0000},
        {558, 1168,1167,1166,1165,1164,1163,1095,1094,1093,1092,1091,1090,1089,1088,0000,0000,0000,0000},
        {559, 1173,1162,1161,1160,1159,1158,1072,1071,1070,1069,1068,1067,1066,1065,0000,0000,0000,0000},
        {560, 1170,1169,1141,1140,1139,1138,1033,1032,1031,1030,1029,1028,1027,1026,0000,0000,0000,0000},
        {561, 1157,1156,1155,1154,1064,1063,1062,1061,1060,1059,1058,1057,1056,1055,1031,1030,1027,1026},
        {562, 1172,1171,1149,1148,1147,1146,1041,1040,1039,1038,1037,1036,1035,1034,0000,0000,0000,0000},
        {565, 1153,1152,1151,1150,1054,1053,1052,1051,1050,1049,1048,1047,1046,1045,0000,0000,0000,0000},
        {567, 1189,1188,1187,1186,1133,1132,1131,1130,1129,1102,0000,0000,0000,0000,0000,0000,0000,0000},
        {575, 1177,1176,1175,1174,1099,1044,1043,1042,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {576, 1193,1192,1191,1190,1137,1136,1135,1134,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {580, 1023,1020,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {589, 1145,1144,1024,1020,1018,1017,1016,1013,1007,1006,1005,1004,1000,0000,0000,0000,0000,0000},
        {600, 1022,1020,1018,1017,1013,1007,1006,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {603, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000}
    };
	
stock const 
	ComponentTypeName[  ][ 18 ] = {
		"SPOILER",
		"HOOD",
		"ROOF",
		"SIDESKIRT",
		"LAMPS",
		"NITRO",
		"EXHAUST",
		"WHEELS",
		"STEREO",
		"HYDRAULICS",
		"FRONT BUMPER",
		"REAR BUMPER",
		"VENT RIGHT",
		"VENT LEFT"
	};

static stock 
	PlayerText:TuningSlotsMainBcg[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningSlotsPaint[MAX_PLAYERS] 	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningBcg1[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningBcg2[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningTip[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningType[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningTypeBcg[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningName[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningBack[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningNext[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningBcg3[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningPrice[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningBuy[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningQuit[MAX_PLAYERS] 			= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningCancel[MAX_PLAYERS] 		= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:TuningSlotBackground[ MAX_PLAYERS ][ 6 ],
	PlayerText:TuningSlotComponent[ MAX_PLAYERS ][ 6 ],
	PlayerText:TuningSlotName[ MAX_PLAYERS ][ 6 ];

// Player VARS
new
	PlayerUsingGarage			= false,
	
	Bit1:	gr_HaveTuningTDs	<MAX_PLAYERS>,
	Bit1:	gr_HaveSlotsTDs		<MAX_PLAYERS>,
	Bit1:	gr_PlayerInTuningMode<MAX_PLAYERS>,
	Bit1:	gr_PlayerBoughtComp <MAX_PLAYERS>,
	Bit1:	gr_PlayerPaintJobPreview<MAX_PLAYERS>,
	Bit1:	gr_TuningSlotReplace<MAX_PLAYERS>,
	Bit4:	gr_PaintJobId		<MAX_PLAYERS>,
	Bit4:	gr_UsedTuningSlot	<MAX_PLAYERS>;

static stock
	VehicleTuningModel[ MAX_PLAYERS ],
	LastPlayerCamera[ MAX_PLAYERS ],
	TuningComponentType[ MAX_PLAYERS ],
	TuningDialogEnd[ MAX_PLAYERS ],
	TuningLastComponent[ MAX_PLAYERS ],
	TuningLastCompId[ MAX_PLAYERS ],
	DialogItemPos[ MAX_PLAYERS ][ 10 ],
	PlayerTuningPreviewT[ MAX_PLAYERS ];
	
/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/

stock ResetVehicleTuningVars(vehicleid)
{
	TuningInfo[ vehicleid ][ tdComponent ][ 0 ] = 0;
	TuningInfo[ vehicleid ][ tdComponent ][ 1 ] = 0;
	TuningInfo[ vehicleid ][ tdComponent ][ 2 ] = 0;
	TuningInfo[ vehicleid ][ tdComponent ][ 3 ] = 0;
	TuningInfo[ vehicleid ][ tdComponent ][ 4 ] = 0;
	TuningInfo[ vehicleid ][ tdComponent ][ 5 ] = 0;
	TuningInfo[ vehicleid ][ tdPaintJob ]		= 3;
}

stock ResetPlayerTuningVars(playerid)
{
	if( Bit1_Get( gr_PlayerInTuningMode, playerid ) ) {
		// rBits
		Bit1_Set( gr_HaveTuningTDs		, playerid, false );
		Bit1_Set( gr_HaveSlotsTDs		, playerid, false );
		Bit1_Set( gr_PlayerInTuningMode	, playerid, false );
		Bit1_Set( gr_PlayerBoughtComp	, playerid, false );
		Bit1_Set( gr_PlayerPaintJobPreview, playerid, false );
		Bit1_Set( gr_TuningSlotReplace	, playerid, false );
		Bit4_Set( gr_PaintJobId			, playerid, 3 );
		Bit4_Set( gr_UsedTuningSlot		, playerid, INVALID_TUNING_SLOT );
		
		// 32 bit
		KillTimer(PlayerTuningPreviewT[ playerid ]);
		TuningComponentType[ playerid ]		= -1;
		TuningDialogEnd[ playerid ] 		= -1;
		TuningLastComponent[ playerid ]		= 0;
		TuningLastCompId[ playerid ]		= 0;
		LastPlayerCamera[ playerid ] 		= 0;
		PlayerTuningVehicle[ playerid ] 	= -1;
		VehicleTuningModel[ playerid ]		= -1;
		
		DialogItemPos[ playerid ][ 0 ]		= 0;
		DialogItemPos[ playerid ][ 1 ]		= 0;
		DialogItemPos[ playerid ][ 2 ]		= 0;
		DialogItemPos[ playerid ][ 3 ]		= 0;
		DialogItemPos[ playerid ][ 4 ]		= 0;
		DialogItemPos[ playerid ][ 5 ]		= 0;
		DialogItemPos[ playerid ][ 6 ]		= 0;
		DialogItemPos[ playerid ][ 7 ]		= 0;
		DialogItemPos[ playerid ][ 8 ]		= 0;
		DialogItemPos[ playerid ][ 9 ]		= 0;
		
		//DestroySlotsTextDraws(playerid);
		//DestroyTuningTDs(playerid);
	}
	return 1;
}

stock iswheelmodel(modelid) {
 
    new wheelmodels[17] = {1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};
 
    for(new I = 0, b = sizeof(wheelmodels); I != b; ++I) {
        if (modelid == wheelmodels[I])
            return true;
 
    }
 
    return false;
}
 
stock IllegalCarNitroIde(carmodel) {
 
    new illegalvehs[29] = { 581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449 };
 
    for(new I = 0, b = sizeof(illegalvehs); I != b; ++I) {
 
        if (carmodel == illegalvehs[I])
            return true;
 
    }
 
    return false;
}
 
// assumes player is in a car - make sure it is.
stock illegal_nos_vehicle(PlayerID) {
 
    new carid = GetPlayerVehicleID(PlayerID);
    new playercarmodel = GetVehicleModel(carid);
 
    return IllegalCarNitroIde(playercarmodel);
 
}
 
stock IsLegalVehicleMod(vehicleide, componentid) 
{
	if(componentid == 0)
		return true;
    new modok = false;
    // stereo, hydraulics & nos (1x 2x 3x) are special.
    if ( (iswheelmodel(componentid)) || (componentid == 1086) || (componentid == 1087) || ((componentid >= 1008) && (componentid <= 1010))) {
        new nosblocker = IllegalCarNitroIde(vehicleide);
        if (!nosblocker)
            modok = true;
    } else {
 
        // check if the specified model CAN use this particular mod.
        for(new I = 0, b = sizeof(legalmods); I != b; ++I) 
		{
            if (legalmods[I][0] == vehicleide) { // first is car IDE
                for(new J = 1; J < 19; J++) { // start with 1
                    if (legalmods[I][J] == componentid)
                        modok = true;
                }
			}
        }
    }
    return modok;
}

stock CheckVehiclesTuning()
{
	new vehicleid;
	for(new i = 1; i < 2000; i++)
	{
		vehicleid = Iter_Free(Vehicles);
		CheckVehicleTuning(i, vehicleid);
	}
	return 1;
}

stock CheckVehicleTuning(sql, vehicleid)
{
	new	tmpQuery[128],
		mysqlQuery[ 256 ],
		modelid;
	format(tmpQuery, 128, "SELECT * FROM cocars WHERE id = '%d'", sql);
	inline CheckingPlayerVehicle()
	{
		if( !cache_num_rows() ) return 1;
		cache_get_value_name_int(0,  	"modelid"	, modelid);
		format(mysqlQuery, 256, "SELECT * FROM vehicle_tuning WHERE vehid = '%d' LIMIT 0,1", sql );
		mysql_tquery(g_SQL, mysqlQuery, "OnVehicleTuningCheck", "iii", vehicleid, modelid, sql);
	}
	mysql_tquery_inline(g_SQL, tmpQuery, using inline CheckingPlayerVehicle, "ii", vehicleid, sql);
	return 1;
}

Public:OnVehicleTuningCheck(vehicleid, modelid, sql)
{
	if( !cache_num_rows() ) return 1;
	new carname[36];
	strunpack( carname, Model_Name(modelid) );
	cache_get_value_name_int(0, "comp0"		, TuningInfo[ vehicleid ][ tdComponent ][ 0 ]);
	cache_get_value_name_int(0, "comp1"		, TuningInfo[ vehicleid ][ tdComponent ][ 1 ]);
	cache_get_value_name_int(0, "comp2"		, TuningInfo[ vehicleid ][ tdComponent ][ 2 ]);
	cache_get_value_name_int(0, "comp3"		, TuningInfo[ vehicleid ][ tdComponent ][ 3 ]);
	cache_get_value_name_int(0, "comp4"		, TuningInfo[ vehicleid ][ tdComponent ][ 4 ]);
	cache_get_value_name_int(0, "comp5"		, TuningInfo[ vehicleid ][ tdComponent ][ 5 ]);
	cache_get_value_name_int(0, "paintjob"	, TuningInfo[ vehicleid ][ tdPaintJob ]);
	for(new islot = 0; islot<6; islot++)
	{
		if(IsLegalVehicleMod(modelid, TuningInfo[ vehicleid ][ tdComponent ][ islot ]))
		{
			printf("[COTUNING DEBUG]: Vehicle %s[SQL: %d], Legal Component ID: %d",  carname, sql, TuningInfo[ vehicleid ][ tdComponent ][ islot ]);
			continue;
		}
		else 
		{
			printf("[COTUNING DEBUG]: Vehicle %s[SQL: %d], Illegal Component ID: %d",  carname, sql, TuningInfo[ vehicleid ][ tdComponent ][ islot ]);
			RemoveVehicleComponent(vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ islot ]);
			TuningInfo[ vehicleid ][ tdComponent ][ islot ] = 0;
		}
	}
	ResetVehicleTuningVars(vehicleid);
	return 1;
}

/*stock LoadVehicleTuning(vehicleid, playerid)
{
	new
		mysqlQuery[ 256 ];
	format(mysqlQuery, 256, "SELECT * FROM vehicle_tuning WHERE vehid = '%d' LIMIT 0,1", VehicleInfo[ vehicleid ][ vSQLID ] );
	mysql_tquery(g_SQL, mysqlQuery, "OnVehicleTuningLoad", "iii", vehicleid, 0, playerid);
	return 1;
}*/

stock DeleteVehicleTuning(vehicleid)
{
	new	
		tmpString[ 64 ];
	format( tmpString, sizeof(tmpString), "DELETE FROM vehicle_tuning WHERE vehid='%d'", VehicleInfo[ vehicleid ][ vSQLID ] );
	mysql_tquery(g_SQL, tmpString, "");
	return 1;
}

stock SaveVehicleTuning(vehicleid)
{
	new
		tmpQuery[ 128 ];
	format(tmpQuery, 128, "SELECT * FROM vehicle_tuning WHERE vehid = '%d' LIMIT 0,1", VehicleInfo[ vehicleid ][ vSQLID ] );
	mysql_tquery(g_SQL, tmpQuery, "OnVehicleTuningLoad", "iii", vehicleid, 1, GetVehicleInfoOwner(vehicleid));
	return 1;
}

Public:OnVehicleTuningLoad(vehicleid, save, playerid)
{
	new
		tmpQuery[ 256 ];
	if( save ) {
		if( cache_num_rows() ) {
			format(tmpQuery, 256, "UPDATE vehicle_tuning SET comp0 = '%d', comp1 = '%d', comp2 = '%d', comp3 = '%d', comp4 = '%d', comp5 = '%d', paintjob = '%d' WHERE vehid = '%d'",
				TuningInfo[ vehicleid ][ tdComponent ][ 0 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 1 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 2 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 3 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 4 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 5 ],
				TuningInfo[ vehicleid ][ tdPaintJob ],
				VehicleInfo[ vehicleid ][ vSQLID ]
			);
			mysql_tquery(g_SQL, tmpQuery, "");
		} else {
			format(tmpQuery, 256, "INSERT INTO vehicle_tuning(vehid, comp0, comp1, comp2, comp3, comp4, comp5, paintjob) VALUES ('%d','%d','%d','%d','%d','%d','%d','%d')",
				VehicleInfo[ vehicleid ][ vSQLID ],
				TuningInfo[ vehicleid ][ tdComponent ][ 0 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 1 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 2 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 3 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 4 ],
				TuningInfo[ vehicleid ][ tdComponent ][ 5 ],
				TuningInfo[ vehicleid ][ tdPaintJob ]
			);
			mysql_tquery(g_SQL, tmpQuery, "");
		}
	} else {
		if( !cache_num_rows() ) return 1;
		cache_get_value_name_int(0, "comp0"		, TuningInfo[ vehicleid ][ tdComponent ][ 0 ]);
		cache_get_value_name_int(0, "comp1"		, TuningInfo[ vehicleid ][ tdComponent ][ 1 ]);
		cache_get_value_name_int(0, "comp2"		, TuningInfo[ vehicleid ][ tdComponent ][ 2 ]);
		cache_get_value_name_int(0, "comp3"		, TuningInfo[ vehicleid ][ tdComponent ][ 3 ]);
		cache_get_value_name_int(0, "comp4"		, TuningInfo[ vehicleid ][ tdComponent ][ 4 ]);
		cache_get_value_name_int(0, "comp5"		, TuningInfo[ vehicleid ][ tdComponent ][ 5 ]);
		cache_get_value_name_int(0, "paintjob"	, TuningInfo[ vehicleid ][ tdPaintJob ]);
		for(new islot = 0; islot<6; islot++)
		{
			if(IsLegalVehicleMod(GetVehicleModel(vehicleid), TuningInfo[ vehicleid ][ tdComponent ][ islot ]))
				continue;
			else 
			{
				RemoveVehicleComponent(vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ islot ]);
				TuningInfo[ vehicleid ][ tdComponent ][ islot ] = 0;
			}
		}
		TuneVehicle(vehicleid);
	}
	return 1;
}

stock RemoveVehicleTuning(vehicleid)
{
	ResetVehicleTuningVars(vehicleid);
	
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 0 ] );
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 1 ] );
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 2 ] );
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 3 ] );
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 4 ] );
	RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 5 ] );
	ChangeVehiclePaintjob(vehicleid, 3);
	
	SaveVehicleTuning(vehicleid);
	return 1;
}

stock RemoveAllVehicleTuning(vehicleid)
{
	new 
		componentid;
	for (new i; i < 14; i++)
	{
		componentid = GetVehicleComponentInSlot(vehicleid, i);
		if (componentid != 0)
		{
			RemoveVehicleComponent(vehicleid, componentid);
		}
	}
	return 1;
}

stock TuneVehicle(vehicleid)
{
	if( TuningInfo[ vehicleid ][ tdComponent ][ 0 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 0 ] );
	if( TuningInfo[ vehicleid ][ tdComponent ][ 1 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 1 ] );
	if( TuningInfo[ vehicleid ][ tdComponent ][ 2 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 2 ] );
	if( TuningInfo[ vehicleid ][ tdComponent ][ 3 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 3 ] );
	if( TuningInfo[ vehicleid ][ tdComponent ][ 4 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 4 ] );
	if( TuningInfo[ vehicleid ][ tdComponent ][ 5 ] )
		AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ 5 ] );
	ChangeVehiclePaintjob(vehicleid, TuningInfo[ vehicleid ][ tdPaintJob ]);
	return 1;
}

/*
	.d8888. db       .d88b.  d888888b .d8888. 
	88'  YP 88      .8P  Y8. ~~88~~' 88'  YP 
	8bo.   88      88    88    88    8bo.   
	  Y8b. 88      88    88    88      Y8b. 
	db   8D 88booo. 8b  d8'    88    db   8D 
	8888Y' Y88888P  Y88P'     YP    8888Y'
*/
stock DestroySlotsTextDraws(playerid)
{	
	if( TuningSlotsMainBcg[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningSlotsMainBcg[playerid] );
		TuningSlotsMainBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningCancel[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningCancel[playerid] );
		TuningCancel[playerid] = PlayerText:INVALID_TEXT_DRAW;
	} 
	if( TuningSlotsPaint[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningSlotsPaint[playerid] );
		TuningSlotsPaint[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	if( TuningSlotBackground[ playerid ][ 0 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 0 ]);
		TuningSlotBackground[ playerid ][ 0 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotBackground[ playerid ][ 1 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 1 ]);
		TuningSlotBackground[ playerid ][ 1 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotBackground[ playerid ][ 2 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 2 ]);
		TuningSlotBackground[ playerid ][ 2 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotBackground[ playerid ][ 3 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 3 ]);
		TuningSlotBackground[ playerid ][ 3 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotBackground[ playerid ][ 4 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 4 ]);
		TuningSlotBackground[ playerid ][ 4 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotBackground[ playerid ][ 5 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotBackground[ playerid ][ 5 ]);
		TuningSlotBackground[ playerid ][ 5 ] = PlayerText:INVALID_TEXT_DRAW;
	}

	if( TuningSlotComponent[ playerid ][ 0 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 0 ]);
		TuningSlotComponent[ playerid ][ 0 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotComponent[ playerid ][ 1 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 1 ]);
		TuningSlotComponent[ playerid ][ 1 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotComponent[ playerid ][ 2 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 2 ]);
		TuningSlotComponent[ playerid ][ 2 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotComponent[ playerid ][ 3 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 3 ]);
		TuningSlotComponent[ playerid ][ 3 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotComponent[ playerid ][ 4 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 4 ]);
		TuningSlotComponent[ playerid ][ 4 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotComponent[ playerid ][ 5 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotComponent[ playerid ][ 5 ]);
		TuningSlotComponent[ playerid ][ 5 ] = PlayerText:INVALID_TEXT_DRAW;
	}

	if( TuningSlotName[ playerid ][ 0 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 0 ]);
		TuningSlotName[ playerid ][ 0 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotName[ playerid ][ 1 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 1 ]);
		TuningSlotName[ playerid ][ 1 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotName[ playerid ][ 2 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 2 ]);
		TuningSlotName[ playerid ][ 2 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotName[ playerid ][ 3 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 3 ]);
		TuningSlotName[ playerid ][ 3 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotName[ playerid ][ 4 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 4 ]);
		TuningSlotName[ playerid ][ 4 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningSlotName[ playerid ][ 5 ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy( playerid, TuningSlotName[ playerid ][ 5 ]);
		TuningSlotName[ playerid ][ 5 ] = PlayerText:INVALID_TEXT_DRAW;
	}
	Bit1_Set( gr_HaveSlotsTDs, playerid, false );
}

stock static CreateTuningSlotMainBcgTextDraw(playerid) 
{
	if( TuningSlotsMainBcg[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningSlotsMainBcg[playerid] );
		TuningSlotsMainBcg[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningCancel[playerid] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningCancel[playerid] );
		TuningCancel[playerid] = PlayerText:INVALID_TEXT_DRAW;
	} 
	
	TuningSlotsMainBcg[playerid] = CreatePlayerTextDraw(playerid, 138.500000, 111.819999, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningSlotsMainBcg[playerid], 0.000000, 24.012222);
	PlayerTextDrawTextSize(playerid, TuningSlotsMainBcg[playerid], 21.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningSlotsMainBcg[playerid], 1);
	PlayerTextDrawColor(playerid, TuningSlotsMainBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, TuningSlotsMainBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, TuningSlotsMainBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, TuningSlotsMainBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningSlotsMainBcg[playerid], 0);
	PlayerTextDrawFont(playerid, TuningSlotsMainBcg[playerid], 0);
	PlayerTextDrawShow(playerid, TuningSlotsMainBcg[playerid]);
	
	TuningCancel[playerid] = CreatePlayerTextDraw(playerid, 131.050125, 102.031753, "X");
	PlayerTextDrawLetterSize(playerid, 		TuningCancel[playerid], 0.354049, 1.491920);
	PlayerTextDrawTextSize(playerid, 		TuningCancel[playerid], 138.649948, 10.540004);
	PlayerTextDrawAlignment(playerid, 		TuningCancel[playerid], 1);
	PlayerTextDrawColor(playerid, 			TuningCancel[playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, 		TuningCancel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, 		TuningCancel[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningCancel[playerid], 51);
	PlayerTextDrawFont(playerid, 			TuningCancel[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningCancel[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, 	TuningCancel[playerid], true);
	PlayerTextDrawShow(playerid, TuningCancel[playerid]);
}

stock static PlayerText:CreateTuningSlotBcg(playerid, Float:PosX, Float:PosY)
{
	new
		PlayerText:tmpText;
	tmpText = CreatePlayerTextDraw(playerid, PosX, PosY, "usebox");
	PlayerTextDrawLetterSize(playerid, tmpText, 0.000000, 3.043334);
	PlayerTextDrawTextSize(playerid, tmpText, 21.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, tmpText, 1);
	PlayerTextDrawColor(playerid, tmpText, 0);
	PlayerTextDrawUseBox(playerid, tmpText, true);
	PlayerTextDrawBoxColor(playerid, tmpText, 102);
	PlayerTextDrawSetShadow(playerid, tmpText, 0);
	PlayerTextDrawSetOutline(playerid, tmpText, 0);
	PlayerTextDrawFont(playerid, tmpText, 0);
	PlayerTextDrawShow(playerid, tmpText);
	return tmpText;
}

stock static PlayerText:CreateTuningSlotComponent(playerid, Float:PosX, Float:PosY, componentid)
{
	new
		PlayerText:tmpText = CreatePlayerTextDraw(playerid, PosX, PosY, "               ");
	PlayerTextDrawFont(playerid				, tmpText, TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawLetterSize(playerid		, tmpText, 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid			, tmpText, 25.500000, 26.880004);
	PlayerTextDrawAlignment(playerid		, tmpText, 1);
	PlayerTextDrawBackgroundColor(playerid	, tmpText, 0x5E5D5D88);
	PlayerTextDrawColor(playerid			, tmpText, -1);
	PlayerTextDrawSetShadow(playerid		, tmpText, 0);
	PlayerTextDrawSetOutline(playerid		, tmpText, 0);
	PlayerTextDrawSetPreviewModel(playerid	, tmpText, componentid);
	if( GetVehicleComponentType(componentid) == CARMODTYPE_WHEELS )
		PlayerTextDrawSetPreviewRot(playerid	, tmpText, 0.0, 0.0, 55.0, 1.0);
	if( GetVehicleComponentType(componentid) == CARMODTYPE_EXHAUST )
		PlayerTextDrawSetPreviewRot(playerid	, tmpText, 0.0, 0.0, 0.0, 0.01);
	PlayerTextDrawShow(playerid				, tmpText);
	return tmpText;
}


stock static PlayerText:CreateTuningSlotName(playerid, string[], Float:PosX, Float:PosY, Float:LetterX, Float:LetterY)
{
	new PlayerText:tmpText = CreatePlayerTextDraw(playerid, PosX, PosY, string);
	PlayerTextDrawLetterSize(playerid, tmpText, LetterX, LetterY);
	PlayerTextDrawTextSize(playerid, tmpText, 207.249923, 10.708412);
	PlayerTextDrawAlignment(playerid, tmpText, 1);
	PlayerTextDrawColor(playerid, tmpText, -1);
	PlayerTextDrawSetShadow(playerid, tmpText, 0);
	PlayerTextDrawSetOutline(playerid, tmpText, 1);
	PlayerTextDrawBackgroundColor(playerid, tmpText, 51);
	PlayerTextDrawFont(playerid, tmpText, 1);
	PlayerTextDrawSetProportional(playerid, tmpText, 1);
	PlayerTextDrawSetSelectable(playerid, tmpText, true);
	PlayerTextDrawShow(playerid, tmpText);
	return tmpText;
}

stock static CreateTuningPaintjob(playerid, id)
{
	new
		string[ 12 ];
	
	format( string, 12, "Paintjob: %d", id );
	TuningSlotsPaint[playerid] = CreatePlayerTextDraw(playerid, 77.850006, 316.679809, string);
	PlayerTextDrawLetterSize(playerid		, TuningSlotsPaint[playerid], 0.335600, 1.074159);
	PlayerTextDrawAlignment(playerid		, TuningSlotsPaint[playerid], 2);
	PlayerTextDrawColor(playerid			, TuningSlotsPaint[playerid], -1);
	PlayerTextDrawSetShadow(playerid		, TuningSlotsPaint[playerid], 0);
	PlayerTextDrawSetOutline(playerid		, TuningSlotsPaint[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid	, TuningSlotsPaint[playerid], 51);
	PlayerTextDrawFont(playerid				, TuningSlotsPaint[playerid], 1);
	PlayerTextDrawSetProportional(playerid	, TuningSlotsPaint[playerid], 1);
	PlayerTextDrawSetSelectable(playerid	, TuningSlotsPaint[playerid], true);
	PlayerTextDrawShow(playerid				, TuningSlotsPaint[playerid]);
}

stock InitTuningSlots(playerid, vehicleid)
{
	if( vehicleid == INVALID_VEHICLE_ID ) return 0;
	CancelSelectTextDraw(playerid);
	Bit1_Set( gr_PlayerBoughtComp, playerid, false );
	
	new
		buffer[ 1000 ];
	
	for( new i = 0; i < 6; i++ ) {
		if( TuningInfo[ vehicleid ][ tdComponent ][ i ] != 0 ) {
			format( buffer, 1000, "%s#%d %s (%d)\n", 
				buffer, 
				i, 
				GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ i ] ), 
				TuningInfo[ vehicleid ][ tdComponent ][ i ]
			);
		} else {
			format( buffer, 1000, "%s#%d Slobodan (0000)\n", 
				buffer, 
				i
			);
		}
	}
	if( IsVehiclePaintJobable( GetVehicleModel(vehicleid) ) )
		format( buffer, 1000, "%sPaintjob: %d", buffer, TuningInfo[ vehicleid ][ tdPaintJob ]);
	ShowPlayerDialog(playerid, DIALOG_TUNE_SLOTS, DIALOG_STYLE_LIST, "TUNING - SLOTS", buffer, "Choose", "Izadji iz garaze");
	
	/*DestroySlotsTextDraws(playerid);
	CreateTuningSlotMainBcgTextDraw(playerid);
	
	if( IsVehiclePaintJobable( GetVehicleModel(vehicleid) ) )
		CreateTuningPaintjob(playerid, TuningInfo[ vehicleid ][ tdPaintJob ]);
	
	new
		Float:BackX	= 138.349960, 
		Float:BackY = 120.219993,
		
		Float:TextX = 58.249980,
		Float:TextY = 128.520080,
		
		Float:SpriteX = 25.250007,
		Float:SpriteY = 120.500009,

		tmpString[ 32 ];
		
	new const 
		Float:BackHeigh 	= 31.88;
		
	new
		Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom;
		
	TuningSlotBackground[ playerid ][ 0 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 0 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 0 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 0 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 0 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 0 ] ) );
		TuningSlotName[ playerid ][ 0 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 0 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 1 );
		TuningSlotName[ playerid ][ 0 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;

	TuningSlotBackground[ playerid ][ 1 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 1 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 1 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 1 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 1 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 1 ] ) );
		TuningSlotName[ playerid ][ 1 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 1 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 2 );
		TuningSlotName[ playerid ][ 1 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;

	TuningSlotBackground[ playerid ][ 2 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 2 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 2 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 2 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 2 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 2 ] ) );
		TuningSlotName[ playerid ][ 2 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 2 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 3 );
		TuningSlotName[ playerid ][ 2 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;

	TuningSlotBackground[ playerid ][ 3 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 3 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 3 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 3 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 3 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 3 ] ) );
		TuningSlotName[ playerid ][ 3 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 3 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 4 );
		TuningSlotName[ playerid ][ 3 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;

	TuningSlotBackground[ playerid ][ 4 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 4 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 4 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 4 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 4 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 4 ] ) );
		TuningSlotName[ playerid ][ 4 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 4 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 5 );
		TuningSlotName[ playerid ][ 4 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;

	TuningSlotBackground[ playerid ][ 5 ] = CreateTuningSlotBcg(playerid, BackX, BackY);
	BackY += BackHeigh + 1.0;

	if( TuningInfo[ vehicleid ][ tdComponent ][ 5 ] != 0 ) {
		TuningSlotComponent[ playerid ][ 5 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, TuningInfo[ vehicleid ][ tdComponent ][ 5 ]);
		PlayerTextDrawGetPreviewRot(playerid, TuningSlotComponent[ playerid ][ 5 ], fRotX, fRotY, fRotZ, fZoom);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), GetComponentName( TuningInfo[ vehicleid ][ tdComponent ][ 5 ] ) );
		TuningSlotName[ playerid ][ 5 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.182900, 0.979518); 
	} else {	
		TuningSlotComponent[ playerid ][ 5 ] = CreateTuningSlotComponent(playerid, SpriteX, SpriteY, 19382);
		SpriteY += BackHeigh + 0.95;
		
		format( tmpString, sizeof(tmpString), "Slot %d", 6 );
		TuningSlotName[ playerid ][ 5 ] = CreateTuningSlotName(playerid, tmpString, TextX, TextY, 0.336650, 1.206879); 
	}
	TextY += BackHeigh + 0.25;*/
	Bit1_Set( gr_HaveSlotsTDs, playerid, true );
	return 1;
}


/*
	 .o88b.  .d88b.  .88b  d88. d8888b.      .88b  d88. d88888b d8b   db db    db 
	d8P  Y8 .8P  Y8. 88'YbdP88 88  8D      88'YbdP88 88'     888o  88 88    88 
	8P      88    88 88  88  88 88oodD'      88  88  88 88ooooo 88V8o 88 88    88 
	8b      88    88 88  88  88 88~~~        88  88  88 88~~~~~ 88 V8o88 88    88 
	Y8b  d8 8b  d8' 88  88  88 88           88  88  88 88.     88  V888 88b  d88 
	 Y88P'  Y88P'  YP  YP  YP 88           YP  YP  YP Y88888P VP   V8P ~Y8888P'
*/
stock DestroyTuningTDs(playerid)
{
	if( TuningBcg1[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningBcg1[ playerid ]);
		TuningBcg1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningBcg2[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningBcg2[ playerid ]);
		TuningBcg2[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningTip[ playerid ] != PlayerText:INVALID_TEXT_DRAW )  {
		PlayerTextDrawDestroy(playerid, TuningTip[ playerid ]);
		TuningTip[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningType[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningType[ playerid ]);
		TuningType[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningTypeBcg[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningTypeBcg[ playerid ]);
		TuningTypeBcg[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningName[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningName[ playerid ]);
		TuningName[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningBack[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningBack[ playerid ]);
		TuningBack[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningNext[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningNext[ playerid ]);
		TuningNext[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningBcg3[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningBcg3[ playerid ]);
		TuningBcg3[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningPrice[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningPrice[ playerid ]);
		TuningPrice[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningBuy[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningBuy[ playerid ]);
		TuningBuy[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( TuningQuit[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, TuningQuit[ playerid ]);
		TuningQuit[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	Bit1_Set( gr_HaveTuningTDs, playerid, false );
}

stock ShowTuningTDs(playerid)
{
	DestroyTuningTDs(playerid);
	
	Bit1_Set( gr_HaveTuningTDs, playerid, true );
	Bit1_Set( gr_HaveSlotsTDs, playerid, false );
	
	TuningBcg1[playerid] = CreatePlayerTextDraw(playerid, 635.500061, 131.419982, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningBcg1[playerid], 0.000000, 15.534998);
	PlayerTextDrawTextSize(playerid, TuningBcg1[playerid], 511.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, TuningBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, TuningBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, TuningBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, TuningBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, TuningBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, TuningBcg1[playerid]);

	TuningBcg2[playerid] = CreatePlayerTextDraw(playerid, 635.950012, 139.316024, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningBcg2[playerid], 0.000000, 2.918888);
	PlayerTextDrawTextSize(playerid, TuningBcg2[playerid], 511.450012, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningBcg2[playerid], 1);
	PlayerTextDrawColor(playerid, TuningBcg2[playerid], 0);
	PlayerTextDrawUseBox(playerid, TuningBcg2[playerid], true);
	PlayerTextDrawBoxColor(playerid, TuningBcg2[playerid], 102);
	PlayerTextDrawSetShadow(playerid, TuningBcg2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningBcg2[playerid], 0);
	PlayerTextDrawFont(playerid, TuningBcg2[playerid], 0);
	PlayerTextDrawShow(playerid, TuningBcg2[playerid]);

	TuningTip[playerid] = CreatePlayerTextDraw(playerid, 562.350463, 139.384078, "TIP");
	PlayerTextDrawLetterSize(playerid, TuningTip[playerid], 0.403849, 1.056239);
	PlayerTextDrawAlignment(playerid, TuningTip[playerid], 1);
	PlayerTextDrawColor(playerid, TuningTip[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, TuningTip[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningTip[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningTip[playerid], 51);
	PlayerTextDrawFont(playerid, TuningTip[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TuningTip[playerid], 1);
	PlayerTextDrawShow(playerid, TuningTip[playerid]);

	TuningType[playerid] = CreatePlayerTextDraw(playerid, 574.700378, 149.296035, "SPOILER");
	PlayerTextDrawLetterSize(playerid, TuningType[playerid], 0.349999, 1.313839);
	PlayerTextDrawTextSize(playerid, TuningType[playerid], 13.599982, 115.696029);
	PlayerTextDrawAlignment(playerid, TuningType[playerid], 2);
	PlayerTextDrawColor(playerid, TuningType[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TuningType[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningType[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningType[playerid], 51);
	PlayerTextDrawFont(playerid, TuningType[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TuningType[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TuningType[playerid], true);
	PlayerTextDrawShow(playerid, TuningType[playerid]);

	TuningTypeBcg[playerid] = CreatePlayerTextDraw(playerid, 635.900268, 176.611907, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningTypeBcg[playerid], 0.000000, 2.918889);
	PlayerTextDrawTextSize(playerid, TuningTypeBcg[playerid], 511.400238, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningTypeBcg[playerid], 1);
	PlayerTextDrawColor(playerid, TuningTypeBcg[playerid], 0);
	PlayerTextDrawUseBox(playerid, TuningTypeBcg[playerid], true);
	PlayerTextDrawBoxColor(playerid, TuningTypeBcg[playerid], 102);
	PlayerTextDrawSetShadow(playerid, TuningTypeBcg[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningTypeBcg[playerid], 0);
	PlayerTextDrawFont(playerid, TuningTypeBcg[playerid], 0);
	PlayerTextDrawShow(playerid, TuningTypeBcg[playerid]);

	TuningName[playerid] = CreatePlayerTextDraw(playerid, 573.349853, 182.784011, "Champ");
	PlayerTextDrawLetterSize(playerid, TuningName[playerid], 0.144749, 1.412397);
	PlayerTextDrawAlignment(playerid, TuningName[playerid], 2);
	PlayerTextDrawColor(playerid, TuningName[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TuningName[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningName[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningName[playerid], 51);
	PlayerTextDrawFont(playerid, TuningName[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TuningName[playerid], 1);
	PlayerTextDrawShow(playerid, TuningName[playerid]);
	
	TuningBack[playerid] = CreatePlayerTextDraw(playerid, 518.450134, 181.551940, "~<~");
	PlayerTextDrawLetterSize(playerid, TuningBack[playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, TuningBack[playerid], 530.200195, 11.920012);
	PlayerTextDrawAlignment(playerid, TuningBack[playerid], 1);
	PlayerTextDrawColor(playerid, TuningBack[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TuningBack[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningBack[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBack[playerid], 51);
	PlayerTextDrawFont(playerid, TuningBack[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningBack[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBack[playerid], true);
	PlayerTextDrawShow(playerid, TuningBack[playerid]);

	TuningNext[playerid] = CreatePlayerTextDraw(playerid, 615.549133, 181.384017, "~>~");
	PlayerTextDrawLetterSize(playerid, TuningNext[playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, TuningNext[playerid], 625.199951, 11.920012);
	PlayerTextDrawAlignment(playerid, TuningNext[playerid], 1);
	PlayerTextDrawColor(playerid, TuningNext[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TuningNext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningNext[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningNext[playerid], 51);
	PlayerTextDrawFont(playerid, TuningNext[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningNext[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TuningNext[playerid], true);
	PlayerTextDrawShow(playerid, TuningNext[playerid]);

	TuningBcg3[playerid] = CreatePlayerTextDraw(playerid, 631.749938, 214.860000, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningBcg3[playerid], 0.000000, 5.534999);
	PlayerTextDrawTextSize(playerid, TuningBcg3[playerid], 515.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningBcg3[playerid], 1);
	PlayerTextDrawColor(playerid, TuningBcg3[playerid], 0);
	PlayerTextDrawUseBox(playerid, TuningBcg3[playerid], true);
	PlayerTextDrawBoxColor(playerid, TuningBcg3[playerid], 102);
	PlayerTextDrawSetShadow(playerid, TuningBcg3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningBcg3[playerid], 0);
	PlayerTextDrawFont(playerid, TuningBcg3[playerid], 0);
	PlayerTextDrawShow(playerid, TuningBcg3[playerid]);

	TuningPrice[playerid] = CreatePlayerTextDraw(playerid, 572.499755, 221.815963, "CIJENA: 4.000~g~$");
	PlayerTextDrawLetterSize(playerid, TuningPrice[playerid], 0.364250, 1.187280);
	PlayerTextDrawAlignment(playerid, TuningPrice[playerid], 2);
	PlayerTextDrawColor(playerid, TuningPrice[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TuningPrice[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningPrice[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningPrice[playerid], 51);
	PlayerTextDrawFont(playerid, TuningPrice[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningPrice[playerid], 1);
	PlayerTextDrawShow(playerid, TuningPrice[playerid]);

	TuningBuy[playerid] = CreatePlayerTextDraw(playerid, 525.100402, 247.128189, "Buy");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid], 0.360098, 1.477918);
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid], 553.750183, 12.432000);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid], -1);
	PlayerTextDrawUseBox(playerid, TuningBuy[playerid], false);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid], true);
	PlayerTextDrawShow(playerid, TuningBuy[playerid]);
	
	TuningQuit[playerid] = CreatePlayerTextDraw(playerid, 561.399108, 247.071975, "Abort");
	PlayerTextDrawLetterSize(playerid, TuningQuit[playerid], 0.360098, 1.477918);
	PlayerTextDrawTextSize(playerid, TuningQuit[playerid], 624.749938, 11.872005);
	PlayerTextDrawAlignment(playerid, TuningQuit[playerid], 1);
	PlayerTextDrawColor(playerid, TuningQuit[playerid], -1);
	PlayerTextDrawUseBox(playerid, TuningQuit[playerid], false);
	PlayerTextDrawSetShadow(playerid, TuningQuit[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TuningQuit[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningQuit[playerid], 51);
	PlayerTextDrawFont(playerid, TuningQuit[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TuningQuit[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TuningQuit[playerid], true);
	PlayerTextDrawShow(playerid, TuningQuit[playerid]);
}

/*
	.88b  d88.  .d8b.  d888888b d8b   db 
	88'YbdP88 d8' 8b   88'   888o  88 
	88  88  88 88ooo88    88    88V8o 88 
	88  88  88 88~~~88    88    88 V8o88 
	88  88  88 88   88   .88.   88  V888 
	YP  YP  YP YP   YP Y888888P VP   V8P 
*/
stock static GetVehicleModelTuning(modelid)
{
	new
		slot = -1;
	for( new i = 0; i < 48; i++ ) {
		if( legalmods[i][0] == modelid ) {
			slot = i;
			break;
		}
	}
	return slot;
}

stock GetVehicleTuningType(modelid)
{
	switch( modelid ) {
		case 562, 565, 559, 560, 558, 561:
			return TUNE_ID_WHEELSARCH;
		case 536, 575, 534, 567, 535, 576:
			return TUNE_ID_LOCOLOW;
		case 496, 422, 401, 518, 527, 542, 589, 492, 546, 400, 517, 410, 551, 500, 418, 516, 404, 603, 600, 426, 436, 547, 439, 550, 549, 540, 491, 421, 529, 477:
			return TUNE_ID_TRANSFEN;
	}
	return -1;
}

stock static IsVehiclePaintJobable(modelid) {
	switch( modelid ) {
		case 483, 534, 535, 536, 558, 559, 560, 561, 562, 565, 567, 575, 576:
			return 1;
		default:
			return 0;
	}
	return 0;
}

stock static ListAvailablePaintJobs(playerid, modelid)
{	
	new
		buffer[128];
	
	TuningDialogEnd[ playerid ] = -1;
	switch( modelid ) {
		case 483: {
			format( buffer, sizeof( buffer ), "Paintjob #1");
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 1;
		}
		case 534: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 535: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 536: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 558: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 559: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 560: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 561: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 562: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 565: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 567: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sPaintjob #3\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 3;
		}
		case 575: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 2;
		}
		case 576: {
			format( buffer, sizeof( buffer ), "Paintjob #1\n");
			format( buffer, sizeof( buffer ), "%sPaintjob #2\n", buffer );
			format( buffer, sizeof( buffer ), "%sObrisi paintjob\n", buffer);
			TuningDialogEnd[ playerid ] = 2;
		}
	}
	return buffer;
}

stock static GetComponentName(component) {
	new
		buffer[ 64 ];
	format( buffer, 64, ComponentInfo[ component - 1000][ modName ] );
	return buffer;
}

stock static GetComponentPrice(component) 
	return ComponentInfo[ component - 1000][ modPrice ];

stock NOSModelPermission(modelid)
{
	switch( modelid ) { 
		case 480, 562, 560, 602, 429, 496, 402, 589, 565, 559, 603, 506, 451, 558, 477:
			return true;
	}
	return false;
}

stock static GetVehicleComponentCamera(type)
{
	if( type == -1 ) return -1;
	switch( type ) {
		case CARMODTYPE_HOOD, 17:		return 0;
		case CARMODTYPE_FRONT_BUMPER: 	return 1;
		case CARMODTYPE_SIDESKIRT: 		return 2;
		case CARMODTYPE_REAR_BUMPER: 	return 3;
		case CARMODTYPE_EXHAUST: 		return 4;
		case CARMODTYPE_SPOILER, CARMODTYPE_NITRO: 			return 5;
		case CARMODTYPE_WHEELS: 		return 6;
		case CARMODTYPE_LAMPS: 			return 7;
		case CARMODTYPE_VENT_LEFT, CARMODTYPE_VENT_RIGHT: 	return 8;
		case CARMODTYPE_ROOF: 			return 9;
	}
	return -1;
}

stock static InitPlayerCamera(playerid, type)
{
	new
		excam = LastPlayerCamera[ playerid ],
		cam = GetVehicleComponentCamera(type);
	
	if( cam == -1 ) cam = 1;
	InterpolateCameraPos(playerid, 		TuneCamera[ excam ][ tcCameraX ], TuneCamera[ excam ][ tcCameraY ], TuneCamera[ excam ][ tcCameraZ ], TuneCamera[ cam ][ tcCameraX ], TuneCamera[ cam ][ tcCameraY ], TuneCamera[ cam ][ tcCameraZ ], 8000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 	612.1391, -1.4793, 1000.5500,  612.1391, -1.4793, 1000.5500, 4500, CAMERA_MOVE);
	
	LastPlayerCamera[ playerid ] = cam;
	return 1;
}

stock ListTuningWheels(playerid, modelid)
{
	new
		dialogPos = 0,
		buffer[ 256 ],
		type = GetVehicleTuningType(modelid);
	
	for(new i = 1; i < 11; i++ ) {
		if( legalWheels[ type ][ i ] ) {
			format( buffer, sizeof( buffer ), "%s%s (%d$)\n", 
				buffer, 
				GetComponentName( legalWheels[ type ][ i ] ),
				GetComponentPrice(legalWheels[ type ][ i ])
			);
			DialogItemPos[ playerid ][ dialogPos ] = legalWheels[ type ][ i ];
			dialogPos++;
		}
	}
	return buffer;
}

stock static ListAllVehicleMods(playerid, modelid)
{
	new
		buffer[ 128 ],
		tmpPos			= 0,
		bool:haveSpoilers= false,
		bool:haveHood  	= false,
		bool:haveRoof	= false,
		bool:haveSkirts	= false,
		bool:haveLamps 	= false,
		bool:haveExhaust= false,
		bool:haveWheels	= false,
		bool:haveFBumper= false,
		bool:haveRBumper= false,
		bool:haveLVent	= false,
		bool:haveRVent	= false,
		bool:haveNOS	= false;

	
	if( legalmods[ VehicleTuningModel[ playerid ] ][ 0 ] == modelid ) {
		for( new j = 1; j < 18; j++ ) {
			if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 0 && !haveSpoilers ) {
				format( buffer, sizeof(buffer), "%sSpoiler\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 0;
				tmpPos++;
				haveSpoilers = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 1 && !haveHood ) {
				format( buffer, sizeof(buffer), "%sHood\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 1;
				tmpPos++;
				haveHood = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 2 && !haveRoof ) {
				format( buffer, sizeof(buffer), "%sKrov\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 2;
				tmpPos++;
				haveRoof = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 3 && !haveSkirts ) {
				format( buffer, sizeof(buffer), "%sSide Skirt\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 3;
				tmpPos++;
				haveSkirts = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 4 && !haveLamps ) {
				format( buffer, sizeof(buffer), "%sSvijetla\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 4;
				tmpPos++;
				haveLamps = true;
			}
			else if( NOSModelPermission(modelid) && !haveNOS ) {
				format( buffer, sizeof(buffer), "%sNitro\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 5;
				tmpPos++;
				haveNOS = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 6 && !haveExhaust ) {
				format( buffer, sizeof(buffer), "%sAuspuh\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 6;
				tmpPos++;
				haveExhaust = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 10 && !haveFBumper ) {
				format( buffer, sizeof(buffer), "%sPrednji branik\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 10;
				tmpPos++;
				haveFBumper = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 11 && !haveRBumper ) {
				format( buffer, sizeof(buffer), "%sStraznji branik\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 11;
				tmpPos++;
				haveRBumper = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 12 && !haveLVent ) {
				format( buffer, sizeof(buffer), "%sLijevi ventil\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 12;
				tmpPos++;
				haveLVent = true;
			}
			else if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == 13 && !haveRVent ) {
				format( buffer, sizeof(buffer), "%sDesni ventil\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = 13;
				tmpPos++;
				haveRVent = true;
			}
			else if( !haveWheels ) {
				format( buffer, sizeof(buffer), "%sFelge\n", buffer );
				DialogItemPos[ playerid ][ tmpPos ] = CARMODTYPE_WHEELS;
				tmpPos++;
				haveWheels = true;
			}
		}
	}

	format( buffer, sizeof(buffer), "%sObrisi\n", buffer );
	DialogItemPos[ playerid ][ tmpPos ] = 20;
	tmpPos++;
	
	return buffer;
}

stock static GetNextVehicleComponent(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;

	if( legalmods[ VehicleTuningModel[ playerid ] ][ 0 ] == GetVehicleModel(GetPlayerVehicleID(playerid)) ) {
		for( new j = TuningLastCompId[ playerid ]; j < 18; j++ ) {
			if( TuningLastCompId[ playerid ] == j ) continue;
			if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == TuningComponentType[ playerid ] ) {
				TuningLastComponent[ playerid ] = legalmods[ VehicleTuningModel[ playerid ] ][ j ];
				TuningLastCompId[ playerid ] 	= j;
				break;
			}
		}
	}
	return 1;
}

stock static GetPreviousVehicleComponent(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;

	if( legalmods[ VehicleTuningModel[ playerid ] ][ 0 ] == GetVehicleModel(GetPlayerVehicleID(playerid)) ) {
		for( new j = TuningLastCompId[ playerid ]; j > 0; j-- ) {
			if( TuningLastCompId[ playerid ] == j ) continue;
			if( GetVehicleComponentType( legalmods[ VehicleTuningModel[ playerid ] ][ j ] ) == TuningComponentType[ playerid ] ) {
				TuningLastComponent[ playerid ] = legalmods[ VehicleTuningModel[ playerid ] ][ j ];
				TuningLastCompId[ playerid ] 	= j;
				break;
			}
		}
	}
	return 1;
}

stock static GetTuningListItem(playerid, listitem)
{
	if( playerid == INVALID_PLAYER_ID ) return -1;
	new
		componentid = -1,
		i			= 0;
	
	while( i < 10 ) {
		if( i == listitem ) {
			componentid = DialogItemPos[ playerid ][ i ];
			break;
		}
		i++;
	}
	return componentid;
}

stock static InitVehicleTuning(playerid, mod_type)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	
	if( mod_type == CARMODTYPE_STEREO || mod_type == CARMODTYPE_STEREO ) 
		mod_type = CARMODTYPE_FRONT_BUMPER;
	
	TuningComponentType[ playerid ] 	= mod_type;
	TuningLastCompId[ playerid ] 		= 1;
	TuningLastComponent[ playerid ] 	= 0;
	GetNextVehicleComponent(playerid);	
	
	// TextDraws
	new
		tmpString[ 50 ];
	// Types
	format(tmpString, sizeof(tmpString), ComponentTypeName[ TuningComponentType[ playerid ] ] );
	PlayerTextDrawSetString(playerid, TuningType[playerid], tmpString);
	
	// Ime
	format(tmpString, sizeof(tmpString), GetComponentName(TuningLastComponent[ playerid ]) );
	PlayerTextDrawSetString(playerid, TuningName[playerid], tmpString);
	
	// Cijena
	format( tmpString, sizeof(tmpString), "CIJENA: %d~g~$", GetComponentPrice(TuningLastComponent[ playerid ]) );
	PlayerTextDrawSetString(playerid, TuningPrice[playerid], tmpString); 
	
	// Attach
	AddVehicleComponent(GetPlayerVehicleID(playerid), TuningLastComponent[ playerid ]);
	return 1;
}

stock static GetUsedModSlotType(vehicleid, slot)
	return GetVehicleComponentType( TuningInfo[ vehicleid ][ tdComponent ][ slot ] );
	
stock static IsVehicleComponentInstalled(vehicleid, playerid, componentid)
{
	new
		slot = -1;
	for( new i = 0; i < 6; i++ ) {
		if( GetVehicleComponentType( componentid ) == GetVehicleComponentType( TuningInfo[ vehicleid ][ tdComponent ][ i ] ) ) {
			if( Bit1_Get( gr_TuningSlotReplace, playerid ) ) continue;
			slot = i;
			break;
		}
	}
	return slot;
}

stock static RemoveVehicleMod(vehicleid, componentid, slot)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 	return 0;
	
	TuningInfo[ vehicleid ][ tdComponent ][ slot ] = 0;
	RemoveVehicleComponent( vehicleid, componentid );
	return 1;
}

stock RemoveLastInstalledComponent(playerid)
{
	if( playerid == INVALID_PLAYER_ID ) return 0;
	
	new
		vehicleid = GetPlayerVehicleID(playerid);
	if( !vehicleid || vehicleid == INVALID_VEHICLE_ID ) return 0;
	
	RemoveVehicleComponent( vehicleid, TuningLastComponent[ playerid ] );
	return 1;
}

stock static PutVehiclePaintJob(playerid, vehicleid, paintjobid)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 	return 0;
	new
		price = 800;
	if( AC_GetPlayerMoney(playerid) < price) {
		InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
		//SelectTextDraw(playerid, -5963521);

		ChangeVehiclePaintjob(vehicleid, TuningInfo[ vehicleid ][ tdPaintJob ]);
		SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate %d$!", price );
		return 1;
	}
	
	// Enum
	TuningInfo[ vehicleid ][ tdPaintJob ] = paintjobid;
	
	// Player
	PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
	PlayerToBudgetMoney(playerid, price); // novac ide u proracun
	
	va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste obojali svoje vozilo u paintjob #%d za %d$.", 
		TuningInfo[ vehicleid ][ tdPaintJob ], 
		price
	);
	
	// Spraying
	ChangeVehiclePaintjob(vehicleid, paintjobid);
	return 1;
}

stock static InstallVehicleMod(vehicleid, playerid, componentid, price)
{
	if( vehicleid == INVALID_VEHICLE_ID ) 	return 0;
	if( playerid == INVALID_PLAYER_ID ) 	return 0;
	
	new
		slot = IsVehicleComponentInstalled( vehicleid, playerid, componentid );
	RemoveLastInstalledComponent(playerid);
	
	if(!IsLegalVehicleMod(GetVehicleModel(vehicleid), componentid))
	{
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Odabrani mod nije kompatibilan sa vasim vozilom.");
		return 1;
	}
	    
	if( slot != -1 ) {
		SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vec posjedujete isti tip komponente u drugom slotu!");
		AddVehicleComponent(vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ slot ]);
		return 1;
	}
	if( AC_GetPlayerMoney(playerid) < price ) {
		SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, " Nemate %d$!", price );
		return 1;
	}
	
	Bit1_Set( gr_PlayerBoughtComp, playerid, true );
	
	// Tuniranje!
	TuningInfo[ vehicleid ][ tdComponent ][ Bit4_Get( gr_UsedTuningSlot, playerid ) ] = componentid;
	
	// Player
	PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	PlayerToBudgetMoney(playerid, price); // novac ide u proracun			
	
	va_SendClientMessage( playerid, COLOR_RED, "[ ! ] Kupili ste komponentu %s za %d$.", 
		GetComponentName(componentid), 
		GetComponentPrice(componentid)
	);
	
	// Adding
	AddVehicleComponent(vehicleid, componentid);
	return 1;
}

/*
	 ######  ##     ##  ######  ########  #######  ##     ##    ######## ##     ##  ######  
	##    ## ##     ## ##    ##    ##    ##     ## ###   ###    ##       ##     ## ##    ## 
	##       ##     ## ##          ##    ##     ## #### ####    ##       ##     ## ##       
	##       ##     ##  ######     ##    ##     ## ## ### ##    ######   ##     ## ##       
	##       ##     ##       ##    ##    ##     ## ##     ##    ##       ##     ## ##       
	##    ## ##     ## ##    ##    ##    ##     ## ##     ##    ##       ##     ## ##    ## 
	 ######   #######   ######     ##     #######  ##     ##    ##        #######   ######  
*/
forward OnPlayerTuningPreviewEnd(playerid, componentid, mod_type);
public OnPlayerTuningPreviewEnd(playerid, componentid, mod_type) 
{
	KillTimer(PlayerTuningPreviewT[ playerid ]);
	switch( mod_type ) {
		case 1: {	// Wheels
			TuningLastComponent[ playerid ] = componentid;
			ShowPlayerDialog(playerid, DIALOG_TUNE_BUYW, DIALOG_STYLE_MSGBOX, "TUNING - FELGE", "Zelite li instalirati odabranu felgu?", "Da", "Ne");
		}
		case 2: {	// Paintjob
			Bit4_Set( gr_PaintJobId, playerid, componentid );
			ShowPlayerDialog(playerid, DIALOG_TUNE_BUYP, DIALOG_STYLE_MSGBOX, "TUNING - PAINTJOB", "Zelite li obojati svoje vozilo u ovaj paintjob?", "Da", "Ne");
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
hook OnGameModeInit()
{
	new
		tmpString[64];
	format(tmpString, 64, ""COL_ORANGE"Grand's Garage\n"COL_WHITE"Tuning Garage");
	//format(tmpString, 64, "(( NE RADI ))");
	CreateDynamic3DTextLabel(tmpString, COLOR_LIGHTBLUE, 2275.5793, -1104.3652, 38.6000, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
	CreateDynamicMapIcon(2275.5793, -1104.3652, 38.6000, 27, -1, -1, -1, -1, 1000000.0, MAPICON_LOCAL);
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(_:playertextid != INVALID_TEXT_DRAW) {		

		if( playertextid == TuningBack[playerid] ) {
			GetPreviousVehicleComponent(playerid);
			
			// Ime
			new
				tmpString[ 50 ];
			format( tmpString, sizeof(tmpString), "%s", GetComponentName(TuningLastComponent[ playerid ]) );
			PlayerTextDrawSetString(playerid, TuningName[playerid], tmpString);
			
			// Cijena
			format( tmpString, sizeof(tmpString), "CIJENA: %d~g~$", GetComponentPrice(TuningLastComponent[ playerid ]) );
			PlayerTextDrawSetString(playerid, TuningPrice[playerid], tmpString);
			
			// Attach
			new
				vehicleid = GetPlayerVehicleID(playerid);
			RemoveVehicleComponent(vehicleid, GetVehicleComponentInSlot(vehicleid, TuningComponentType[ playerid ]));
			AddVehicleComponent(vehicleid, TuningLastComponent[ playerid ]);
			return 1;
		}
		
		if( playertextid == TuningNext[playerid] ) {
			GetNextVehicleComponent(playerid);
			
			// Ime
			new
				tmpString[ 50 ];
			format( tmpString, sizeof(tmpString), "%s", GetComponentName(TuningLastComponent[ playerid ]) );
			PlayerTextDrawSetString(playerid, TuningName[playerid], tmpString);
			
			// Cijena
			format( tmpString, sizeof(tmpString), "CIJENA: %d~g~$", GetComponentPrice(TuningLastComponent[ playerid ]) );
			PlayerTextDrawSetString(playerid, TuningPrice[playerid], tmpString);
			
			// Attach
			new
				vehicleid = GetPlayerVehicleID(playerid);
			RemoveVehicleComponent(vehicleid, GetVehicleComponentInSlot(vehicleid, TuningComponentType[ playerid ]));
			AddVehicleComponent(vehicleid, TuningLastComponent[ playerid ]);
			return 1;
		}
		
		if( playertextid == TuningBuy[playerid] ) {
			if( Bit1_Get( gr_PlayerInTuningMode, playerid ) ) {								
				InstallVehicleMod(GetPlayerVehicleID(playerid), playerid, TuningLastComponent[ playerid ], GetComponentPrice(TuningLastComponent[ playerid ]));
				
				DestroyTuningTDs(playerid);
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
			}
			return 1;
		}
		
		if( playertextid == TuningType[playerid] ) {
			if( Bit4_Get( gr_UsedTuningSlot, playerid ) == INVALID_TUNING_SLOT ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate odabrati slot za tuning!"), SelectTextDraw(playerid, -5963521);
			
			DestroyTuningTDs(playerid);
			ShowPlayerDialog(playerid, DIALOG_TUNE_LIST, DIALOG_STYLE_LIST, "TUNING - ODABIR VRSTE", ListAllVehicleMods( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), "Choose", "Abort");
			CancelSelectTextDraw(playerid);
			RemoveLastInstalledComponent(playerid);
			return 1;
		}
		
		if( playertextid == TuningQuit[playerid] ) {	
			if( Bit1_Get( gr_PlayerInTuningMode, playerid ) ) {
				if( Bit_Get( gr_HaveTuningTDs, playerid ) ) {
					new
						vehicleid = GetPlayerVehicleID(playerid);
						
					DestroyTuningTDs(playerid);					
					RemoveLastInstalledComponent(playerid);
					AddVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ Bit4_Get( gr_UsedTuningSlot, playerid ) ] );
					
					InitTuningSlots(playerid, vehicleid);
					//SelectTextDraw(playerid, -5963521);
				}
			}
			return 1;
		}
		
		if( playertextid == TuningCancel[playerid] ) {
			if( Bit1_Get( gr_HaveSlotsTDs, playerid ) && ( !Bit1_Get( gr_PlayerBoughtComp, playerid ) || !Bit1_Get( gr_PlayerPaintJobPreview, playerid ) ) ) {
				DestroySlotsTextDraws(playerid);				
				new
					vehicleid = GetPlayerVehicleID(playerid);
				SaveVehicleTuning(vehicleid);
				SetVehiclePos(vehicleid, 2274.6995, -1107.0754, 37.5500);
				SetVehicleZAngle(vehicleid, 157.6800);
				LinkVehicleToInterior(vehicleid, 0);
				SetVehicleVirtualWorld(vehicleid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				
				PlayerUsingGarage = false;
				Bit1_Set( gr_PlayerInTuningMode, playerid, false );
				ResetPlayerTuningVars(playerid);
				
				TogglePlayerControllable(playerid, true);
				SetCameraBehindPlayer(playerid);
				CancelSelectTextDraw(playerid);
			}
			return 1;
		}
		
		/*if( playertextid == TuningSlotsPaint[playerid] ) {
			DestroySlotsTextDraws(playerid);
			Bit1_Set( gr_PlayerPaintJobPreview, playerid, true );
			ShowPlayerDialog(
				playerid, 
				DIALOG_TUNE_PAINT, 
				DIALOG_STYLE_LIST, 
				"TUNING - PAINTJOB", 
				ListAvailablePaintJobs( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), 
				"Choose", 
				"Abort"
			);
			return 1;
		}
		for( new i = 0; i < 6; i++ ) {
			if( playertextid == TuningSlotName[ playerid ][ i ] ) {				
				Bit4_Set( gr_UsedTuningSlot, playerid, i );
				DestroySlotsTextDraws(playerid);
				
				if( TuningInfo[ GetPlayerVehicleID(playerid) ][ tdComponent ][ i ] != 0 ) {
					ShowPlayerDialog( playerid, DIALOG_TUNE_SLOT_REPLACE, DIALOG_STYLE_MSGBOX, "TUNING", "Zelite li iskoristiti ovaj slot?", "Da", "Ne");
					break;
				}
				
				ShowPlayerDialog(playerid, DIALOG_TUNE_LIST, DIALOG_STYLE_LIST, "TUNING - ODABIR VRSTE", ListAllVehicleMods( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), "Choose", "Abort");
				return 1;
			}
		}*/
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid )
	{
		case DIALOG_TUNE_SLOTS: {
			if(!response) {
				Bit1_Set( gr_PlayerInTuningMode, playerid, false );			
				new
					vehicleid = GetPlayerVehicleID(playerid);
				SaveVehicleTuning(vehicleid);
				SetVehiclePos(vehicleid, 2274.6995, -1107.0754, 37.5500);
				SetVehicleZAngle(vehicleid, 157.6800);
				LinkVehicleToInterior(vehicleid, 0);
				SetVehicleVirtualWorld(vehicleid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				TogglePlayerControllable(playerid, true);
				ResetPlayerTuningVars(playerid);
				SetCameraBehindPlayer(playerid);
				PlayerUsingGarage = false;
				return 1;
			}
			if( listitem == 6 ) return ShowPlayerDialog( playerid, DIALOG_TUNE_PAINT, DIALOG_STYLE_LIST, "TUNING - PAINTJOB", ListAvailablePaintJobs( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), "Choose", "Abort");
			
			Bit4_Set( gr_UsedTuningSlot, playerid, listitem );
			if( TuningInfo[ GetPlayerVehicleID(playerid) ][ tdComponent ][ listitem ] != 0 ) {
				ShowPlayerDialog( playerid, DIALOG_TUNE_SLOT_REPLACE, DIALOG_STYLE_MSGBOX, "TUNING", "Zelite li iskoristiti ovaj slot?", "Da", "Ne");
				return 1;
			}
			
			ShowPlayerDialog(playerid, DIALOG_TUNE_LIST, DIALOG_STYLE_LIST, "TUNING - ODABIR VRSTE", ListAllVehicleMods( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), "Choose", "Abort");
			return 1;
		}
		case DIALOG_TUNE_LIST: {
			new
				vehicleid = GetPlayerVehicleID(playerid);
			if( !response ) {
				AddVehicleComponent(vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ Bit4_Get( gr_UsedTuningSlot, playerid ) ]);
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			
			new
				component = GetTuningListItem(playerid, listitem);
			
			if( component == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Dogodila se greska pri odabiru tipa! Probajte opet izmjeniti tip komponente!");
			
			if( component == CARMODTYPE_NITRO ) {
				va_ShowPlayerDialog(playerid, DIALOG_TUNE_NOS, DIALOG_STYLE_LIST, "TUNING - NOS", "2x (%d$)\n5x (%d$)\n10x (%d$)", "Choose", "Abort", GetComponentPrice(1009), GetComponentPrice(1008), GetComponentPrice(1010));
				InitPlayerCamera(playerid, component);
				return 1;
			}
			if( component == CARMODTYPE_WHEELS ) {
				ShowPlayerDialog(playerid, DIALOG_TUNE_WHEELS, DIALOG_STYLE_LIST, "TUNING - FELGE", ListTuningWheels(playerid, GetVehicleModel( vehicleid ) ), "Choose", "Abort");
				InitPlayerCamera(playerid, component);
				return 1;
			}
			if( component == 20 ) return ShowPlayerDialog(playerid, DIALOG_TUNE_DELETE, DIALOG_STYLE_MSGBOX, "TUNING - DELETE", "Zalite li obrisati odabrani model?", "Da", "Ne");
			
			
			InitPlayerCamera(playerid, component);			
			ShowTuningTDs(playerid);
			InitVehicleTuning(playerid, component);
			SelectTextDraw(playerid, -5963521);
			return 1;
		}
		case DIALOG_TUNE_NOS: {
			if( !response ) {
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			
			switch( listitem ) {
				case 0:
					InstallVehicleMod(GetPlayerVehicleID(playerid), playerid, 1009, GetComponentPrice(1009));
				case 1:
					InstallVehicleMod(GetPlayerVehicleID(playerid), playerid, 1008, GetComponentPrice(1008));
				case 2:
					InstallVehicleMod(GetPlayerVehicleID(playerid), playerid, 1010, GetComponentPrice(1010));
			}

			DestroyTuningTDs(playerid);
			InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
			//SelectTextDraw(playerid, -5963521);
			return 1;
		}
		case DIALOG_TUNE_WHEELS: {
			if( !response ) {
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			AddVehicleComponent(GetPlayerVehicleID(playerid), GetTuningListItem(playerid, listitem));
			PlayerTuningPreviewT[ playerid ] = SetTimerEx( "OnPlayerTuningPreviewEnd", TUNE_PREVIEW_TIME, false, "iii", playerid, GetTuningListItem(playerid, listitem), 1 );
			return 1;
		}
		case DIALOG_TUNE_PAINT: {
			if( !response ) {
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			if( TuningDialogEnd[ playerid ] == listitem ) return ShowPlayerDialog(playerid, DIALOG_TUNE_PAINT_DEL, DIALOG_STYLE_MSGBOX, "TUNING - BRISANJE PAINTJOBA", "Zelite li obrisati paintjob sa vaseg vozila?", "Da", "Ne");

			ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), listitem);
			PlayerTuningPreviewT[ playerid ] = SetTimerEx( "OnPlayerTuningPreviewEnd", TUNE_PREVIEW_TIME, false, "iii", playerid, listitem, 2 );
			InitPlayerCamera(playerid, 17);
			return 1;
		}
		case DIALOG_TUNE_PAINT_DEL: {
			if( !response ) {
				InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			
			new
				vehicleid = GetPlayerVehicleID(playerid);
			
			TuningInfo[ vehicleid ][ tdPaintJob ] = 3;
			ChangeVehiclePaintjob(vehicleid, 3);
			
			InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
			//SelectTextDraw(playerid, -5963521);
			return 1;
		}
		case DIALOG_TUNE_BUYP: {
			new
				vehicleid = GetPlayerVehicleID(playerid);
			if(!response) {
				ShowPlayerDialog(playerid, DIALOG_TUNE_PAINT, DIALOG_STYLE_LIST, "TUNING - PAINTJOB", 
					ListAvailablePaintJobs( playerid, GetVehicleModel( GetPlayerVehicleID(playerid) ) ), 
					"Choose", 
					"Abort"
				);
				ChangeVehiclePaintjob(vehicleid, TuningInfo[ vehicleid ][ tdPaintJob ]);
				Bit1_Set( gr_PlayerPaintJobPreview, playerid, false );
				return 1;
			}
		
			PutVehiclePaintJob(playerid, vehicleid, Bit4_Get( gr_PaintJobId, playerid ));
			Bit4_Set( gr_PaintJobId, playerid, 3 );
			Bit1_Set( gr_PlayerPaintJobPreview, playerid, false );
			
			DestroyTuningTDs(playerid);
			InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
			//SelectTextDraw(playerid, -5963521);
			return 1;
		}
		case DIALOG_TUNE_BUYW: {
			new
				vehicleid = GetPlayerVehicleID(playerid);
			if( !response ) {
				ShowPlayerDialog(playerid, DIALOG_TUNE_WHEELS, DIALOG_STYLE_LIST, "TUNING - FELGE", 
					ListTuningWheels(playerid, GetVehicleModel( vehicleid ) ), 
					"Choose", 
					"Abort"
				);
				RemoveVehicleComponent(vehicleid, TuningLastComponent[ playerid ]);
				return 1;
			}
			
			InstallVehicleMod(vehicleid, playerid, TuningLastComponent[ playerid ], GetComponentPrice(TuningLastComponent[ playerid ]));
			
			DestroyTuningTDs(playerid);
			InitTuningSlots(playerid, GetPlayerVehicleID(playerid));
			//SelectTextDraw(playerid, -5963521);
			return 1;
		}
		case DIALOG_TUNE_SLOT_REPLACE: {
			new
				vehicleid = GetPlayerVehicleID(playerid);
			if( !response ) {
				AddVehicleComponent(vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ Bit4_Get( gr_UsedTuningSlot, playerid ) ]);
				InitTuningSlots(playerid, vehicleid);
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}
			
			Bit1_Set( gr_TuningSlotReplace, playerid, true );
			RemoveVehicleComponent( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ Bit4_Get( gr_UsedTuningSlot, playerid ) ] );
			ShowPlayerDialog(playerid, DIALOG_TUNE_LIST, DIALOG_STYLE_LIST, "TUNING - ODABIR VRSTE", ListAllVehicleMods( playerid, GetVehicleModel( vehicleid ) ), "Choose", "Abort");
			return 1;
		}
		case DIALOG_TUNE_DELETE: {
			new
				slot 		= Bit4_Get( gr_UsedTuningSlot, playerid ),
				vehicleid 	= GetPlayerVehicleID(playerid);
			
			if( !response ) {
				InitTuningSlots(playerid, vehicleid);
				//SelectTextDraw(playerid, -5963521);
				return 1;
			}				
			RemoveVehicleMod( vehicleid, TuningInfo[ vehicleid ][ tdComponent ][ slot ], slot );
			
			InitTuningSlots(playerid, vehicleid);
			//SelectTextDraw(playerid, -5963521);
			return 1;
		}
	}
	return 0;
}

stock RemovePassangersFromVehicle(vehicleid)
{
	foreach(new i : Player)
	{
	    if(GetPlayerState(i) == 3 && IsPlayerInVehicle(i, vehicleid))
	    {
			RemovePlayerFromVehicle(i);
			SetPlayerPos(i, 2275.5793, -1104.3652, 38.6000);
			SendClientMessage(i, COLOR_RED, "[ ! ] Izba�eni ste iz vozila zbog toga Sto je voza� istog uSao u tuning garaZu!");
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
/*CMD:tuning(playerid, params[])
{
	if( PlayerUsingGarage ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Netko vec koristi tuning garazu!");
	
	new
		vehicleid = GetPlayerVehicleID(playerid);

	if( !IsPlayerInAnyVehicle( playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar vozila!");
	if( GetVehicleTuningType( GetVehicleModel( vehicleid ) ) == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Vase se vozilo ne moze tunirati!");
	if( !IsPlayerInVehicle( playerid, PlayerInfo[ playerid ][ pSpawnedCar ] ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Mozete tunirati samo vlastito vozilo!");
	if( !IsPlayerInRangeOfPoint(playerid, 10.0, 2275.5793, -1104.3652, 38.6000 ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste blizu Grand's Garage!");

	RemovePassangersFromVehicle(vehicleid);
	VehicleTuningModel[ playerid ] 	= GetVehicleModelTuning( GetVehicleModel(vehicleid) );
	SetVehiclePos(vehicleid, 611.3785, -1.5515, 1001.0000);
	LinkVehicleToInterior(vehicleid, 1);
	SetVehicleVirtualWorld(vehicleid, playerid);
	SetPlayerVirtualWorld(playerid, playerid);
	SetPlayerInterior(playerid, 1);
	SetVehicleZAngle(vehicleid, 90.0);
	TogglePlayerControllable(playerid, false);
	
	InterpolateCameraPos(playerid, 		605.9730, -2.6803, 1002.3000, 605.9730, -2.6803, 1002.3000, 1000000, CAMERA_CUT);
	InterpolateCameraLookAt(playerid, 	612.1391, -1.4793, 1000.5500, 612.1391, -1.4793, 1000.5500, 1000000, CAMERA_CUT);
	LastPlayerCamera[ playerid ] = 0;
	PlayerTuningVehicle[ playerid ] = vehicleid;
	
	InitTuningSlots(playerid, vehicleid);
	//SelectTextDraw(playerid, -5963521);
	
	Bit1_Set( gr_PlayerInTuningMode, playerid, true );
	PlayerUsingGarage = true;
	return 1;
}

CMD:remove_tuning(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 4 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
	new
		vehicleid;
	if( sscanf( params, "i", vehicleid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /remove_tuning [vehicleid]");
	if( !vehicleid || vehicleid == INVALID_VEHICLE_ID || !IsVehicleStreamedIn(vehicleid, playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos vehicleida!");
	RemoveVehicleTuning(vehicleid);
	return 1;
}*/
