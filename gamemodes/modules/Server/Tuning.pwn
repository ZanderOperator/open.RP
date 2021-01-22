#include <YSI_Coding\y_hooks>

#define D_TOP       	"Car Tuning"
#define D_OK 			"Ok"
#define D_CANCEL 		"Back"
#define D_TEXT			"Paintjobs\nAuspuh\nPrednji branik\nStraznji branik\nKrov\nSpoiler\nBocni branici\nFelge\nHidraulika\nNitro"

#define REMOVE_PRICE			200


static 
	PlayerText:TuningBuy[MAX_PLAYERS][14] = { PlayerText:INVALID_TEXT_DRAW, ... },
	bool:ClickedTuningTD[MAX_PLAYERS] = false,
	PlayerTuningVehicle[MAX_PLAYERS] = INVALID_VEHICLE_ID;

enum vPaintjobInfo 
{
	vehID,
	pNumber,
	pPrice,
	ppName[12]
};
#define NUMBER_TYPE_PAINTJOB 	36
static const
	pjInfo[NUMBER_TYPE_PAINTJOB][vPaintjobInfo] = {
	{ 483, 0, 15000, "Paintjob 1"},
	{ 534, 0, 15000, "Paintjob 1"},
	{ 534, 1, 15000, "Paintjob 2"},
	{ 534, 2, 15000, "Paintjob 3"},
	{ 535, 0, 15000, "Paintjob 1"},
	{ 535, 1, 15000, "Paintjob 2"},
	{ 535, 2, 15000, "Paintjob 3"},
	{ 536, 0, 15000, "Paintjob 1"},
	{ 536, 1, 15000, "Paintjob 2"},
	{ 536, 2, 15000, "Paintjob 3"},
	{ 558, 0, 15000, "Paintjob 1"},
	{ 558, 1, 15000, "Paintjob 2"},
	{ 558, 2, 15000, "Paintjob 3"},
	{ 559, 0, 15000, "Paintjob 1"},
	{ 559, 1, 15000, "Paintjob 2"},
	{ 559, 2, 15000, "Paintjob 3"},
	{ 560, 0, 15000, "Paintjob 1"},
	{ 560, 1, 15000, "Paintjob 2"},
	{ 560, 2, 15000, "Paintjob 3"},
	{ 561, 0, 15000, "Paintjob 1"},
	{ 561, 1, 15000, "Paintjob 2"},
	{ 561, 2, 15000, "Paintjob 3"},
	{ 562, 0, 15000, "Paintjob 1"},
	{ 562, 1, 15000, "Paintjob 2"},
	{ 562, 2, 15000, "Paintjob 3"},
	{ 565, 0, 15000, "Paintjob 1"},
	{ 565, 1, 15000, "Paintjob 2"},
	{ 565, 2, 15000, "Paintjob 3"},
	{ 567, 0, 15000, "Paintjob 1"},
	{ 567, 1, 15000, "Paintjob 2"},
	{ 567, 2, 15000, "Paintjob 3"},
	{ 575, 0, 15000, "Paintjob 1"},
	{ 575, 1, 15000, "Paintjob 2"},
	{ 576, 0, 15000, "Paintjob 1"},
	{ 576, 1, 15000, "Paintjob 2"},
	{ 576, 2, 15000, "Paintjob 3"}
};

enum ComponentsInfo 
{
	cID,
	cName[40],
	cPrice,
	cType
};

#define MAX_COMPONENTS				(194)
#define MAX_COMPONENT_SLOTS			(14)

static const
	cInfo[MAX_COMPONENTS][ComponentsInfo] = {
	{ 1000, "Pro Spoiler", 5000, CARMODTYPE_SPOILER },
	{ 1001, "Win Spoiler", 5000, CARMODTYPE_SPOILER },
	{ 1002, "Drag Spoiler", 5000, CARMODTYPE_SPOILER },
	{ 1003, "Alpha Spoiler", 5000, CARMODTYPE_SPOILER },
	{ 1004, "Champ Scoop Hood", 4000, CARMODTYPE_HOOD },
	{ 1005, "Fury Scoop Hood", 4000, CARMODTYPE_HOOD },
	{ 1006, "Roof Scoop Roof", 4000, CARMODTYPE_ROOF },
	{ 1007, "Right Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1008, "5x Nitrous", 10000, CARMODTYPE_NITRO },
	{ 1009, "2x Nitrous", 6000, CARMODTYPE_NITRO },
	{ 1010, "10x Nitrous", 20000, CARMODTYPE_NITRO },
	{ 1011, "Race Scoop Hood", 4000, CARMODTYPE_HOOD },
	{ 1012, "Worx Scoop Hood", 4000, CARMODTYPE_HOOD },
	{ 1013, "Round Fog Lamp", 1800, CARMODTYPE_LAMPS },
	{ 1014, "Champ Spoiler", 4000, CARMODTYPE_SPOILER },
	{ 1015, "Race Spoiler", 4000, CARMODTYPE_SPOILER },
	{ 1016, "Worx Spoiler", 4000, CARMODTYPE_SPOILER },
	{ 1017, "Left Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1018, "Upswept Exhaust", 1200, CARMODTYPE_EXHAUST },
	{ 1019, "Twin Exhaust", 1200, CARMODTYPE_EXHAUST },
	{ 1020, "Large Exhaust", 1200, CARMODTYPE_EXHAUST },
	{ 1021, "Medium Exhaust", 1200, CARMODTYPE_EXHAUST },
	{ 1022, "Small Exhaust", 1200, CARMODTYPE_EXHAUST },
	{ 1023, "Fury Spoiler", 4000, CARMODTYPE_SPOILER },
	{ 1024, "Square Fog Lamp", 1800, CARMODTYPE_LAMPS },
	{ 1025, "Offroad Wheels", 2000, CARMODTYPE_WHEELS },
	{ 1026, "Right Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1027, "Left Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1028, "Alien Exhaust", 3500, CARMODTYPE_EXHAUST },
	{ 1029, "X-Flow Exhaust", 3500, CARMODTYPE_EXHAUST },
	{ 1030, "Left X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1031, "Right X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1032, "Alien Roof Vent", 2000, CARMODTYPE_ROOF },
	{ 1033, "X-Flow Roof Vent", 2000, CARMODTYPE_ROOF },
	{ 1034, "Alien Exhaust", 3500, CARMODTYPE_EXHAUST },
	{ 1035, "X-Flow Roof Vent", 4000, CARMODTYPE_ROOF },
	{ 1036, "Right Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1037, "X-Flow Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1038, "Alien Roof Vent", 4000, CARMODTYPE_ROOF },
	{ 1039, "Left X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1040, "Left Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1041, "Right X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1042, "Right Chrome Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1043, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1044, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1045, "X-Flow Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1046, "Alien Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1047, "Right Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1048, "Right X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1049, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1050, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1051, "Left Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1052, "Left X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1053, "X-Flow Roof", 4000, CARMODTYPE_ROOF },
	{ 1054, "Alien Roof", 4000, CARMODTYPE_ROOF },
	{ 1055, "Alien Roof", 4000, CARMODTYPE_ROOF },
	{ 1056, "Right Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1057, "Right X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1058, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1059, "X-Flow Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1060, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1061, "X-Flow Roof", 4000, CARMODTYPE_ROOF },
	{ 1062, "Left Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1063, "Left X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1064, "Alien Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1065, "Alien Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1066, "X-Flow Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1067, "Alien Roof", 4000, CARMODTYPE_ROOF },
	{ 1068, "X-Flow Roof", 4000, CARMODTYPE_ROOF },
	{ 1069, "Right Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1070, "Right X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1071, "Left Alien Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1072, "Left X-Flow Sideskirt", 2100, CARMODTYPE_SIDESKIRT },
	{ 1073, "Shadow Wheels", 7500, CARMODTYPE_WHEELS },
	{ 1074, "Mega Wheels", 12800, CARMODTYPE_WHEELS },
	{ 1075, "Rimshine Wheels", 10200, CARMODTYPE_WHEELS },
	{ 1076, "Wires Wheels", 3600, CARMODTYPE_WHEELS },
	{ 1077, "Classic Wheels", 5800, CARMODTYPE_WHEELS },
	{ 1078, "Twist Wheels", 6800, CARMODTYPE_WHEELS },
	{ 1079, "Cutter Wheels", 9800, CARMODTYPE_WHEELS },
	{ 1080, "Switch Wheels", 13000, CARMODTYPE_WHEELS },
	{ 1081, "Grove Wheels", 10000, CARMODTYPE_WHEELS },
	{ 1082, "Import Wheels", 8800, CARMODTYPE_WHEELS },
	{ 1083, "Dollar Wheels", 5300, CARMODTYPE_WHEELS },
	{ 1084, "Trance Wheels", 4800, CARMODTYPE_WHEELS },
	{ 1085, "Atomic Wheels", 8800, CARMODTYPE_WHEELS },
	{ 1086, "Stereo Wheels", 5800, CARMODTYPE_STEREO },
	{ 1087, "Hydraulics", 7000, CARMODTYPE_HYDRAULICS },
	{ 1088, "Alien Roof", 4000, CARMODTYPE_ROOF },
	{ 1089, "X-Flow Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1090, "Right Alien Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1091, "X-Flow Roof", 4000, CARMODTYPE_ROOF },
	{ 1092, "Alien Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1093, "Right X-Flow Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1094, "Left Alien Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1095, "Right X-Flow Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1096, "Ahab Wheels", 6000, CARMODTYPE_WHEELS },
	{ 1097, "Virtual Wheels", 7000, CARMODTYPE_WHEELS },
	{ 1098, "Access Wheels", 4800, CARMODTYPE_WHEELS },
	{ 1099, "Left Chrome Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1100, "Chrome Grill", 2800, -1 }, // Bullbar
	{ 1101, "Left Chrome Flames Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1102, "Left Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1103, "Covertible Roof", 4000, CARMODTYPE_ROOF },
	{ 1104, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1105, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1106, "Right Chrome Arches", 2800, CARMODTYPE_SIDESKIRT },
	{ 1107, "Left Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1108, "Right Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1109, "Chrome", 2800, -1 }, // Bullbar
	{ 1110, "Slamin", 2800, -1 }, // Bullbar
	{ 1111, "Little Sign", 100, -1 }, // sig
	{ 1112, "Little Sign", 100, -1 }, // sig
	{ 1113, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1114, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1115, "Chrome", 2800, -1 }, // Bullbar
	{ 1116, "Slamin", 2800, -1 }, // Bullbar
	{ 1117, "Chrome Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1118, "Right Chrome Trim Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1119, "Right Wheelcovers Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1120, "Left Chrome Trim Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1121, "Left Wheelcovers Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1122, "Right Chrome Flames Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1123, "Bullbar Chrome Bars", 2800, -1 }, // Bullbar
	{ 1124, "Left Chrome Arches Sideskirt", 28000, CARMODTYPE_SIDESKIRT },
	{ 1125, "Bullbar Chrome Lights", 2800, -1 }, // Bullbar
	{ 1126, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1127, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1128, "Vinyl Hardtop", 4000, CARMODTYPE_ROOF },
	{ 1129, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1130, "Hardtop Roof", 4000, CARMODTYPE_ROOF },
	{ 1131, "Softtop Roof", 4000, CARMODTYPE_ROOF },
	{ 1132, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1133, "Right Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1134, "Right Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1135, "Slamin Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1136, "Chrome Exhaust", 7000, CARMODTYPE_EXHAUST },
	{ 1137, "Left Chrome Strip Sideskirt", 2800, CARMODTYPE_SIDESKIRT },
	{ 1138, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1139, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1140, "X-Flow Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1141, "Alien Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1142, "Left Oval Vents", 8000, CARMODTYPE_VENT_LEFT },
	{ 1143, "Right Oval Vents", 8000, CARMODTYPE_VENT_RIGHT },
	{ 1144, "Left Square Vents", 8000, CARMODTYPE_VENT_LEFT },
	{ 1145, "Right Square Vents", 8000, CARMODTYPE_VENT_RIGHT },
	{ 1146, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1147, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1148, "X-Flow Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1149, "Alien Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1150, "Alien Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1151, "X-Flow Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1152, "X-Flow Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1153, "Alien Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1154, "Alien Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1155, "Alien Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1156, "X-Flow Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1157, "X-Flow Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1158, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1159, "Alien Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1160, "Alien Front Bumper", 8000, CARMODTYPE_FRONT_BUMPER },
	{ 1161, "X-Flow Rear Bumper", 8000, CARMODTYPE_REAR_BUMPER },
	{ 1162, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1163, "X-Flow Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1164, "Alien Spoiler", 7000, CARMODTYPE_SPOILER },
	{ 1165, "X-Flow Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1166, "Alien Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1167, "X-Flow Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1168, "Alien Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1169, "Alien Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1170, "X-Flow Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1171, "Alien Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1172, "X-Flow Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1173, "X-Flow Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1174, "Chrome Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1175, "Slamin Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1176, "Chrome Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1177, "Slamin Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1178, "Slamin Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1179, "Chrome Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1180, "Chrome Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1181, "Slamin Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1182, "Chrome Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1183, "Slamin Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1184, "Chrome Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1185, "Slamin Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1186, "Slamin Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1187, "Chrome Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1188, "Slamin Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1189, "Chrome Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1190, "Slamin Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1191, "Chrome Front Bumper", 4000, CARMODTYPE_FRONT_BUMPER },
	{ 1192, "Chrome Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER },
	{ 1193, "Slamin Rear Bumper", 4000, CARMODTYPE_REAR_BUMPER }
};


enum tp_Info 
{
	tID,
	tType,
	bool:tPaintjob
};
static 
	TPInfo[MAX_PLAYERS][tp_Info];

stock CreatePlayerTuningTextDraws( playerid) 
{

	TuningBuy[playerid][0] = CreatePlayerTextDraw(playerid, 425.125000, 338.666687, "usebox");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][0], 0.000000, 8.627778);
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid][0], 216.125000, 0.000000);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][0], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TuningBuy[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, TuningBuy[playerid][0], 102);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][0], 0);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][0], 0);

	TuningBuy[playerid][1] = CreatePlayerTextDraw(playerid, 319.375000, 337.749847, "Hydraulics");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][1], 0.386249, 1.156664);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][1], 2);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][1], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid][1], false);

	TuningBuy[playerid][2] = CreatePlayerTextDraw(playerid, 198.375000, 361.583282, "-");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][2], 18.981874, 0.514999);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][2], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][2], -10092289);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][2], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][2], 1);

	TuningBuy[playerid][3] = CreatePlayerTextDraw(playerid, 222.500000, 352.916656, "Left Chrome Flames Sideskirt");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][3], 0.244999, 1.092499);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][3], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][3], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][3], 1);

	TuningBuy[playerid][4] = CreatePlayerTextDraw(playerid, 222.500000, 365.000000, "Cijena: ~w~10000$");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][4], 0.244999, 1.092499);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][4], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][4], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][4], 1);

	TuningBuy[playerid][5] = CreatePlayerTextDraw(playerid, 215.125000, 372.999877, "-");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][5], 6.743125, 0.444999);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][5], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][5], -10092289);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][5], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][5], 1);

	TuningBuy[playerid][6] = CreatePlayerTextDraw(playerid, 206.750000, 347.166564, "-");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][6], 18.981874, 0.514999);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][6], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][6], -10092289);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][6], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][6], 1);

	TuningBuy[playerid][7] = CreatePlayerTextDraw(playerid, 385.000000, 381.500000, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][7], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid][7], 27.500000, 13.416657);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][7], 2);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, TuningBuy[playerid][7], true);
	PlayerTextDrawBoxColor(playerid, TuningBuy[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][7], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid][7], true);

	TuningBuy[playerid][8] = CreatePlayerTextDraw(playerid, 230.375000, 381.916473, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][8], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid][8], 27.500000, 13.416657);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][8], 2);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, TuningBuy[playerid][8], true);
	PlayerTextDrawBoxColor(playerid, TuningBuy[playerid][8], 255);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][8], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid][8], true);

	TuningBuy[playerid][9] = CreatePlayerTextDraw(playerid, 320.000000, 381.499938, "Buy");
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid][9], 23.000000, 13.000000);
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][9], 0.421249, 1.360832);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][9], 2);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][9], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid][9], true);

	TuningBuy[playerid][10] = CreatePlayerTextDraw(playerid, 200.000000, 396.416656, "-");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][10], 18.981874, 0.514999);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][10], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][10], -10092289);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][10], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][10], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][10], 1);

	TuningBuy[playerid][11] = CreatePlayerTextDraw(playerid, 225.000000, 401.916595, "Los Santos Car Tunes");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][11], 0.258749, 0.987497);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][11], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][11], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][11], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][11], 1);

	TuningBuy[playerid][12] = CreatePlayerTextDraw(playerid, 203.500000, 411.416839, "-");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][12], 18.981874, 0.514998);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][12], 1);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][12], -10092289);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][12], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][12], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][12], 1);

	TuningBuy[playerid][13] = CreatePlayerTextDraw(playerid, 404.500000, 337.999877, "ld_beat:cross");
	PlayerTextDrawLetterSize(playerid, TuningBuy[playerid][13], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, TuningBuy[playerid][13], 17.500000, 8.749991);
	PlayerTextDrawAlignment(playerid, TuningBuy[playerid][13], 2);
	PlayerTextDrawColor(playerid, TuningBuy[playerid][13], -1);
	PlayerTextDrawUseBox(playerid, TuningBuy[playerid][13], true);
	PlayerTextDrawBoxColor(playerid, TuningBuy[playerid][13], 255);
	PlayerTextDrawSetShadow(playerid, TuningBuy[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, TuningBuy[playerid][13], 1);
	PlayerTextDrawBackgroundColor(playerid, TuningBuy[playerid][13], 51);
	PlayerTextDrawFont(playerid, TuningBuy[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, TuningBuy[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, TuningBuy[playerid][13], true);
}

stock DeletePlayerTuningTD(playerid)
{
	for( new i = 0; i < MAX_COMPONENT_SLOTS; i ++) 
	{
		PlayerTextDrawHide( playerid, TuningBuy[playerid][i]);
		PlayerTextDrawDestroy( playerid, TuningBuy[playerid][i]);
		TuningBuy[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	Bit1_Set( gr_PlayerInTuningMode, playerid, false);
	ClickedTuningTD[playerid] = false;
	PlayerTuningVehicle[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

stock LoadVehicleTuning(vehicleid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM vehicle_tuning WHERE vehid = '%d'", VehicleInfo[vehicleid][vSQLID]),
	 	"OnVehicleTuningLoad", 
	 	"ii", 
		 vehicleid, 
	 	false
	);
	return 1;
}


stock DeleteVehicleTuning(vehicleid)
{
	mysql_fquery(g_SQL, "DELETE FROM vehicle_tuning WHERE vehid ='%d'", VehicleInfo[vehicleid][vSQLID]);
	return 1;
}

stock SaveVehicleTuning(vehicleid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM vehicle_tuning WHERE vehid = '%d'", VehicleInfo[vehicleid][vSQLID]), 
		"OnVehicleTuningLoad", 
		"ii", 
		vehicleid, 
		true
	);
	return 1;
}

Public:OnVehicleTuningLoad(vehicleid, bool:save)
{
	if(save) 
	{
		if(cache_num_rows()) 
		{
			mysql_fquery(g_SQL,
			 	"UPDATE vehicle_tuning SET spoiler = '%d', hood = '%d', roof = '%d', skirt = '%d', lamps = '%d',\n\
					nitro = '%d', exhaust = '%d', wheels = '%d', hydraulic = '%d', fbumper = '%d', rbumper = '%d',\n\
					rvent = '%d', lvent = '%d', paintjob = '%d' WHERE vehid = '%d'",
				VehicleInfo[vehicleid][vSpoiler],
				VehicleInfo[vehicleid][vHood],
				VehicleInfo[vehicleid][vRoof],
				VehicleInfo[vehicleid][vSkirt],
				VehicleInfo[vehicleid][vLamps],
				VehicleInfo[vehicleid][vNitro],
				VehicleInfo[vehicleid][vExhaust],
				VehicleInfo[vehicleid][vWheels],
				VehicleInfo[vehicleid][vHydraulics],
				VehicleInfo[vehicleid][vFrontBumper],
				VehicleInfo[vehicleid][vRearBumper],
				VehicleInfo[vehicleid][vRightVent],
				VehicleInfo[vehicleid][vLeftVent],
				VehicleInfo[vehicleid][vPaintJob],
				VehicleInfo[vehicleid][vSQLID]
			);
		} 
		else 
		{
			mysql_fquery_ex(g_SQL, 
				"INSERT INTO vehicle_tuning(vehid, spoiler, hood, roof, skirt, lamps, nitro, exhaust, wheels,\n\
					hydraulic, fbumper, rbumper, rvent, lvent, paintjob) \n\
					VALUES ('%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d')",
				VehicleInfo[vehicleid][vSQLID],
				VehicleInfo[vehicleid][vSpoiler],
				VehicleInfo[vehicleid][vHood],
				VehicleInfo[vehicleid][vRoof],
				VehicleInfo[vehicleid][vSkirt],
				VehicleInfo[vehicleid][vLamps],
				VehicleInfo[vehicleid][vNitro],
				VehicleInfo[vehicleid][vExhaust],
				VehicleInfo[vehicleid][vWheels],
				VehicleInfo[vehicleid][vHydraulics],
				VehicleInfo[vehicleid][vFrontBumper],
				VehicleInfo[vehicleid][vRearBumper],
				VehicleInfo[vehicleid][vRightVent],
				VehicleInfo[vehicleid][vLeftVent],
				VehicleInfo[vehicleid][vPaintJob]
			);
		}
		mysql_fquery(g_SQL, "UPDATE cocars SET tuned = '%d' WHERE id = '%d'",
			VehicleInfo[vehicleid][vTuned],
			VehicleInfo[vehicleid][vSQLID]
		);
		return 1;
	} 
	else 
	{
		if(!cache_num_rows()) return 1;
		cache_get_value_name_int(0, "spoiler"	, VehicleInfo[vehicleid][vSpoiler]);
		cache_get_value_name_int(0, "hood"		, VehicleInfo[vehicleid][vHood]);
		cache_get_value_name_int(0, "roof"		, VehicleInfo[vehicleid][vRoof]);
		cache_get_value_name_int(0, "skirt"		, VehicleInfo[vehicleid][vSkirt]);
		cache_get_value_name_int(0, "lamps"		, VehicleInfo[vehicleid][vLamps]);
		cache_get_value_name_int(0, "nitro"		, VehicleInfo[vehicleid][vNitro]);
		cache_get_value_name_int(0, "exhaust"	, VehicleInfo[vehicleid][vExhaust]);
		cache_get_value_name_int(0, "wheels"	, VehicleInfo[vehicleid][vWheels]);
		cache_get_value_name_int(0, "hydraulic"	, VehicleInfo[vehicleid][vHydraulics]);
		cache_get_value_name_int(0, "fbumper"	, VehicleInfo[vehicleid][vFrontBumper]);
		cache_get_value_name_int(0, "rbumper"	, VehicleInfo[vehicleid][vRearBumper]);
		cache_get_value_name_int(0, "rvent"		, VehicleInfo[vehicleid][vRightVent]);
		cache_get_value_name_int(0, "lvent"		, VehicleInfo[vehicleid][vLeftVent]);
		cache_get_value_name_int(0, "paintjob"	, VehicleInfo[vehicleid][vPaintJob]);
		SetVehicleTuning(vehicleid);
	}
	return 1;
}

stock RemoveAllVehicleTuning(vehicleid)
{
	new componentid;
	for (new i; i < 14; i++)
	{
		componentid = GetVehicleComponentInSlot(vehicleid, i);
		if(componentid != 0)
			RemoveVehicleComponent(vehicleid, componentid);
	}
	return 1;
}

stock SetVehicleTuning(vehicleid) 
{
    if(VehicleInfo[vehicleid][vTuned]) 
	{
	    if(VehicleInfo[vehicleid][vPaintJob] != 255)
		{
			ChangeVehicleColor(vehicleid, 1, 1);
			ChangeVehiclePaintjob( vehicleid, VehicleInfo[vehicleid][vPaintJob]);
		}
		if(VehicleInfo[vehicleid][vSpoiler] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vSpoiler]);
		if(VehicleInfo[vehicleid][vHood] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vHood]);
		if(VehicleInfo[vehicleid][vRoof] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vRoof]);
		if(VehicleInfo[vehicleid][vSkirt] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vSkirt]);
		if(VehicleInfo[vehicleid][vLamps] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vLamps]);
		if(VehicleInfo[vehicleid][vNitro] != -1) 
		{
			if(IsVehicleInvalidForNos(vehicleid))
			{
				VehicleInfo[vehicleid][vNitro] = -1;
				SaveVehicleTuning(vehicleid);
			}
		}		
		if(VehicleInfo[vehicleid][vExhaust] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vExhaust]);
		if(VehicleInfo[vehicleid][vWheels] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vWheels]);
		if(VehicleInfo[vehicleid][vHydraulics] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vHydraulics]);
		if(VehicleInfo[vehicleid][vFrontBumper] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vFrontBumper]);
		if(VehicleInfo[vehicleid][vRearBumper] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vRearBumper]);
		if(VehicleInfo[vehicleid][vRightVent] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vRightVent]);
		if(VehicleInfo[vehicleid][vLeftVent] != -1) 
			AddVehicleComponent( vehicleid, VehicleInfo[vehicleid][vLeftVent]);
    }
	return 1;
}
//==============================================================================
stock AddComponentToVehicle( vehicleid, componentid) {
	if(VehicleInfo[vehicleid][vTuned]) {
		if(GetVehicleComponentType( componentid) == CARMODTYPE_SPOILER) {
		    VehicleInfo[vehicleid][vSpoiler] = componentid;
			if(VehicleInfo[vehicleid][vSpoiler] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_HOOD) {
		    VehicleInfo[vehicleid][vHood] = componentid;
			if(VehicleInfo[vehicleid][vHood] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_ROOF) {
		    VehicleInfo[vehicleid][vRoof] = componentid;
			if(VehicleInfo[vehicleid][vRoof] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_SIDESKIRT) {
		    VehicleInfo[vehicleid][vSkirt] = componentid;
			if(VehicleInfo[vehicleid][vSkirt] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_LAMPS) {
		    VehicleInfo[vehicleid][vLamps] = componentid;
			if(VehicleInfo[vehicleid][vLamps] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_NITRO) {
		    VehicleInfo[vehicleid][vNitro] = componentid;
			if(VehicleInfo[vehicleid][vNitro] != -1)
			{
				AddVehicleComponent( vehicleid, componentid);
				VehicleInfo[vehicleid][vNOSCap] = 100;
				foreach(new i : Player)
				{
					if(GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
					{
						CreateNosTextdraws(i);
						break;
					}
				}
			}
		}
		else if(GetVehicleComponentType( componentid) == CARMODTYPE_HYDRAULICS) {
		    VehicleInfo[vehicleid][vHydraulics] = componentid;
			if(VehicleInfo[vehicleid][vHydraulics] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_EXHAUST) {
		    VehicleInfo[vehicleid][vExhaust] = componentid;
			if(VehicleInfo[vehicleid][vExhaust] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_WHEELS) {
		    VehicleInfo[vehicleid][vWheels] = componentid;
			if(VehicleInfo[vehicleid][vWheels] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_HYDRAULICS) {
		    VehicleInfo[vehicleid][vHydraulics] = componentid;
			if(VehicleInfo[vehicleid][vHydraulics] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_FRONT_BUMPER) {
		    VehicleInfo[vehicleid][vFrontBumper] = componentid;
			if(VehicleInfo[vehicleid][vFrontBumper] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_REAR_BUMPER) {
		    VehicleInfo[vehicleid][vRearBumper] = componentid;
			if(VehicleInfo[vehicleid][vRearBumper] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_VENT_RIGHT) {
		    VehicleInfo[vehicleid][vRightVent] = componentid;
			if(VehicleInfo[vehicleid][vRightVent] != -1) AddVehicleComponent( vehicleid, componentid);
		}
	    else if(GetVehicleComponentType( componentid) == CARMODTYPE_VENT_LEFT) {
		    VehicleInfo[vehicleid][vLeftVent] = componentid;
			if(VehicleInfo[vehicleid][vLeftVent] != -1) AddVehicleComponent( vehicleid, componentid);
		}
		SaveVehicleTuning(vehicleid);
	}
}

stock RemoveComponentFromVehicle(playerid, vehicleid, listitem) 
{	
	Bit1_Set( gr_PlayerInTuningMode, playerid, false);
	if(VehicleInfo[vehicleid][vTuned]) 
	{
		if(AC_GetPlayerMoney(playerid) < REMOVE_PRICE)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Da bi uklonili tuniranu komponentu, potrebno Vam je %d$!", REMOVE_PRICE);
		
		switch(listitem)
		{
			case 0:
			{
				if(VehicleInfo[vehicleid][vPaintJob] == 255)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje PaintJob!");
				VehicleInfo[vehicleid][vPaintJob] = 255;
				ChangeVehiclePaintjob( vehicleid, 3);
				ChangeVehicleColor( vehicleid, VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2]);
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli PaintJob sa vozila za %d$.", REMOVE_PRICE);
			}
			case 1:
			{
				if(VehicleInfo[vehicleid][vExhaust] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani auspuh!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vExhaust]);
				VehicleInfo[vehicleid][vExhaust] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli auspuh sa vozila za %d$.", REMOVE_PRICE);
			}
			case 2:
			{
				if(VehicleInfo[vehicleid][vFrontBumper] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani prednji branik!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vFrontBumper]);
				VehicleInfo[vehicleid][vFrontBumper] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli prednji branik sa vozila za %d$.", REMOVE_PRICE);
			}
			case 3:
			{
				if(VehicleInfo[vehicleid][vRearBumper] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani straznji branik!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vRearBumper]);
				VehicleInfo[vehicleid][vRearBumper] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli straznji branik sa vozila za %d$.", REMOVE_PRICE);
			}
			case 4:
			{
				if(VehicleInfo[vehicleid][vRoof] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani krov!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vRoof]);
				VehicleInfo[vehicleid][vRoof] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli krov sa vozila za %d$.", REMOVE_PRICE);
			}
			case 5:
			{
				if(VehicleInfo[vehicleid][vSpoiler] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani spoiler!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vSpoiler]);
				VehicleInfo[vehicleid][vSpoiler] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli spoiler sa vozila za %d$.", REMOVE_PRICE);
			}
			case 6:
			{
				if(VehicleInfo[vehicleid][vSkirt] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani bocni branik!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vSkirt]);
				VehicleInfo[vehicleid][vSkirt] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli bocne branike sa vozila za %d$.", REMOVE_PRICE);
			}
			case 7:
			{
				if(VehicleInfo[vehicleid][vWheels] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirane felge!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vWheels]);
				VehicleInfo[vehicleid][vWheels] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli felge sa vozila za %d$.", REMOVE_PRICE);
			}
			case 8:
			{
				if(VehicleInfo[vehicleid][vHydraulics] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tuniranu hidrauliku!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vHydraulics]);
				VehicleInfo[vehicleid][vHydraulics] = -1;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli hidrauliku sa vozila za %d$.", REMOVE_PRICE);
			}
			case 9:
			{
				if(VehicleInfo[vehicleid][vNitro] == -1)
					return SendErrorMessage(playerid, "Vozilo ne posjeduje tunirani nitro!");
				RemoveVehicleComponent(vehicleid, VehicleInfo[vehicleid][vNitro]);
				VehicleInfo[vehicleid][vNitro] = -1;
				VehicleInfo[vehicleid][vNOSCap] = 0;
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste maknuli nitro sa vozila za %d$.", REMOVE_PRICE);
				DestroyNOSTD(playerid); // maknuto
			}
		}
		PlayerToBudgetMoney(playerid, REMOVE_PRICE); // Novac ide u proracun
		SaveVehicleTuning(vehicleid);
	}
	else SendErrorMessage(playerid, "Vase vozilo nema inkorporiran tuning!");
	return 1;
}

stock IsComponentidCompatible( modelid, componentid) 
{
    if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
		componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
        componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
        componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086) 
        return componentid;

    switch( modelid) 
	{
        case 400: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 401: if(componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 402: if(componentid == 1009 || componentid == 1009 || componentid == 1010) return componentid;
        case 404: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 405: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000) return componentid;
        case 409: if(componentid == 1009) return componentid;
        case 410: if(componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 411: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 412: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 415: if(componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 418: if(componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016) return componentid;
        case 419: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 420: if(componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003) return componentid;
        case 421: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000) return componentid;
        case 422: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007) return componentid;
        case 426: if(componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003) return componentid;
        case 429: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 436: if(componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 438: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 439: if(componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013) return componentid;
        case 442: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 445: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 451: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 458: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 466: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 467: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 474: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 475: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 477: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007) return componentid;
        case 478: if(componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 479: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 480: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 489: if(componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000) return componentid;
        case 491: if(componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 492: if(componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000) return componentid;
        case 496: if(componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020) return componentid;
        case 500: if(componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 506: if(componentid == 1009) return componentid;
        case 507: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 516: if(componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 517: if(componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 518: if(componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 526: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 527: if(componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007) return componentid;
        case 529: if(componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 533: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 534: if(componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106) return componentid;
        case 535: if(componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119) return componentid;
        case 536: if(componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108) return componentid;
        case 540: if(componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 541: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 542: if(componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015) return componentid;
        case 545: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 546: if(componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 547: if(componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000) return componentid;
        case 549: if(componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 550: if(componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003) return componentid;
        case 551: if(componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003) return componentid;
        case 555: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 558: if(componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093) return componentid;
        case 559: if(componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009) return componentid;
        case 560: if(componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031) return componentid;
        case 561: if(componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057) return componentid;
        case 562: if(componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039) return componentid;
        case 565: if(componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048) return componentid;
        case 566: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 567: if(componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133) return componentid;
        case 575: if(componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042) return componentid;
        case 576: if(componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134) return componentid;
        case 579: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 580: if(componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
        case 585: if(componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007) return componentid;
        case 587: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 589: if(componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007) return componentid;
        case 600: if(componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007) return componentid;
        case 602: if(componentid == 1008 || componentid == 1009 || componentid == 1010) return componentid;
        case 603: if(componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007) return componentid;
    }
    return 0;
}

stock IsPlayerInInvalidNosVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	#define MAX_INVALID_NOS_VEHICLES 52
	new InvalidNosVehicles[MAX_INVALID_NOS_VEHICLES] =
	{
		581,523,462,521,463,522,461,448,468,586,417,425,469,487,512,520,563,593,
		509,481,510,472,473,493,520,595,484,430,453,432,476,497,513,533,577,
		452,446,447,454,590,569,537,538,570,449,519,460,488,511,519,548,592
	};
	if(IsPlayerInAnyVehicle(playerid))
	{
		for(new i = 0; i < MAX_INVALID_NOS_VEHICLES; i++)
		{
			if(GetVehicleModel(vehicleid) == InvalidNosVehicles[i]) 
				return true;
		}
	}
	return false;
}

stock IsVehicleInvalidForNos(vehicleid)
{
	#define MAX_INVALID_NOS_VEHICLES 52
	new InvalidNosVehicles[MAX_INVALID_NOS_VEHICLES] =
	{
		581,523,462,521,463,522,461,448,468,586,417,425,469,487,512,520,563,593,
		509,481,510,472,473,493,520,595,484,430,453,432,476,497,513,533,577,
		452,446,447,454,590,569,537,538,570,449,519,460,488,511,519,548,592
	};
	for(new i = 0; i < MAX_INVALID_NOS_VEHICLES; i++)
	{
		if(GetVehicleModel(vehicleid) == InvalidNosVehicles[i]) 
			return true;
	}
	return false;
}
	
//==============================================================================
stock GetVehicleCameraPos( vehicleid, &Float:x, &Float:y, &Float:z, Float:xoff=0.0, Float:yoff=0.0, Float:zoff=0.0)
{
    new Float:rot;
    GetVehicleZAngle( vehicleid, rot);
    rot = 360 - rot;
    GetVehiclePos( vehicleid, x, y, z);
    x = floatsin( rot, degrees) * yoff + floatcos( rot, degrees) * xoff + x;
    y = floatcos( rot, degrees) * yoff - floatsin( rot, degrees) * xoff + y;
    z = zoff + z;
}

stock TuningTDControl( playerid, bool:show) 
{
	if(show == true) 
	{
        for( new i = 0; i < MAX_COMPONENT_SLOTS; i ++) 
			PlayerTextDrawShow( playerid, TuningBuy[playerid][i]);
		ClickedTuningTD[playerid] = true;
		
	}
	else if(show == false) 
	{
		for( new i = 0; i < MAX_COMPONENT_SLOTS; i ++) 
			PlayerTextDrawHide( playerid, TuningBuy[playerid][i]);
		ClickedTuningTD[playerid] = false;
	}
}

ResetTuningInfo( playerid) 
{
	TPInfo[playerid][tID] = -1;
	TPInfo[playerid][tType] = -1;
	TPInfo[playerid][tPaintjob] = false;
	Bit1_Set( gr_PlayerInTuningMode, playerid, false);
	PlayerTuningVehicle[playerid] = INVALID_VEHICLE_ID;
}

stock ResetVehicleTuning(vehid) 
{
	if(VehicleInfo[vehid][vTuned]) 
	{
	    VehicleInfo[vehid][vTuned] = false;
		VehicleInfo[vehid][vSpoiler] = -1;
		VehicleInfo[vehid][vHood] = -1;
		VehicleInfo[vehid][vRoof] = -1;
		VehicleInfo[vehid][vSkirt] = -1;
		VehicleInfo[vehid][vLamps] = -1;
		VehicleInfo[vehid][vNitro] = -1;
		VehicleInfo[vehid][vNOSCap] = -1;
		VehicleInfo[vehid][vExhaust] = -1;
		VehicleInfo[vehid][vWheels] = -1;
		VehicleInfo[vehid][vHydraulics] = -1;
		VehicleInfo[vehid][vFrontBumper] = -1;
		VehicleInfo[vehid][vRearBumper] = -1;
		VehicleInfo[vehid][vRightVent] = -1;
		VehicleInfo[vehid][vLeftVent] = -1;
		VehicleInfo[vehid][vPaintJob] = 255;
	}
	new componentid;
	ChangeVehiclePaintjob( vehid, 3);
	for( new i; i < MAX_COMPONENT_SLOTS; i++) 
	{
		componentid = GetVehicleComponentInSlot( vehid, i);
		if(componentid != 0)
			RemoveVehicleComponent( vehid, componentid);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(Bit1_Get( gr_PlayerInTuningMode	, playerid))
		SetVehicleToRespawn(PlayerTuningVehicle[playerid]);

	return 1;
}

hook function ResetPlayerVariables( playerid) 
{
    ResetTuningInfo( playerid);
	return continue(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	switch( dialogid) 
	{
	    case DIALOG_TUNING: 
		{
			new tuningstring[128];
	        if(response) 
			{
				new vehicleid = GetPlayerVehicleID( playerid), Float:Pos[6];
	            TPInfo[playerid][tID] = -1;
				switch( listitem) 
				{
	                case 0: 
					{
						for( new i = 0; i < NUMBER_TYPE_PAINTJOB; i++) 
						{
			                if(pjInfo[i][vehID] == GetVehicleModel( vehicleid)) 
							{
				            	TPInfo[playerid][tID] = i;
								break;
							}
			           	}
						if(TPInfo[playerid][tID] == -1)
						{
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema kompatibilnih paintjobova za vase vozilo.");
						}
						new pid = TPInfo[playerid][tID];
						TPInfo[playerid][tPaintjob] = true;
						
						TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

                        ChangeVehicleColor( vehicleid, 1, 1);
                        ChangeVehiclePaintjob( vehicleid, pjInfo[pid][pNumber]);

						format( tuningstring, sizeof( tuningstring), "Paintjobs");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", pjInfo[pid][ppName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", pjInfo[pid][pPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);
						
						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 4, 0, 5);
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
						
						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 1: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_EXHAUST) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_EXHAUST;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Auspuh");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], -2, -5, 0);
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 2: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_FRONT_BUMPER) 
							{
			                   	if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
							   	{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
						if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_FRONT_BUMPER;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Prednji branik");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, 6, 0.5); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 3: 
					{ 
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_REAR_BUMPER) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
						if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_REAR_BUMPER;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Straznji branik");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, -6, 0.5); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 4: 
					{

	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_ROOF) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_ROOF;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Roof vent");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, 6, 2); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 5: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_SPOILER) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_SPOILER;
						TPInfo[playerid][tPaintjob] = false;
	                
	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);
						
						format( tuningstring, sizeof( tuningstring), "Spoiler");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);
						
						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, -6, 2); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);
						
						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
						
						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 6: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_SIDESKIRT) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_SIDESKIRT;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Bocni branik");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 4, 0, 0.5);
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
						
						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 7: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_WHEELS)
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_WHEELS;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Felge");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 4, 0, 0.5); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 8: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_HYDRAULICS) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_HYDRAULICS;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Hidraulika");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 2, 2, 2);
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);

						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	                case 9: 
					{
	                    for( new i = 0; i < MAX_COMPONENTS; i++) 
						{
			                if(cInfo[i][cType] == CARMODTYPE_NITRO) 
							{
			                    if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
								{
				                    TPInfo[playerid][tID] = i;
									break;
								}
			                }
						}
	                    if(TPInfo[playerid][tID] == -1)
						{	
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
						}
						if(IsPlayerInInvalidNosVehicle(playerid))
						{
							DeletePlayerTuningTD(playerid);
							return SendErrorMessage( playerid, "Na vase vozilo se ne moze staviti nitro!");
						}
						new cid = TPInfo[playerid][tID];
						TPInfo[playerid][tType] = CARMODTYPE_NITRO;
						TPInfo[playerid][tPaintjob] = false;

	                    TogglePlayerControllable( playerid, false);
	                    TuningTDControl( playerid, true);

						format( tuningstring, sizeof( tuningstring), "Nitro");
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][1], tuningstring);
	                    format( tuningstring, sizeof( tuningstring), "%s", cInfo[cid][cName]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
						format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[cid][cPrice]);
						PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

                        AddVehicleComponent( vehicleid, cInfo[cid][cID]);

						GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, -6, 2); // done
						SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

						GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
						SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
						
						SelectTextDraw( playerid, COLOR_ORANGE);
	                }
	            }
	        }
	        else if(!response) 
			{
	            SetCameraBehindPlayer( playerid);
				DeletePlayerTuningTD(playerid);
	        }
	    }
		case DIALOG_TUNING_REMOVE:
		{
			if(!response)
			{
				Bit1_Set( gr_PlayerInTuningMode, playerid, false);
				return 1;
			}
			else
			{
				new vehicleid = GetPlayerVehicleID( playerid);
				if(!IsPlayerInAnyVehicle( playerid)) 
					return SendErrorMessage( playerid, "Morate biti u vozilu.");
				if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
					return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");
				RemoveComponentFromVehicle(playerid, vehicleid, listitem);
			}
		}		
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid != PlayerText:INVALID_TEXT_DRAW) 
	{
        if(playertextid == TuningBuy[playerid][7]) // Right
		{
            if(!IsPlayerInAnyVehicle( playerid)) 
				return SendErrorMessage( playerid, "Morate biti u vozilu.");
	        if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
				return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");
            if(TPInfo[playerid][tPaintjob] == false) 
			{
				new 
					compid = -1, 
					vehicleid = GetPlayerVehicleID( playerid);
            
	            for( new i = ( TPInfo[playerid][tID]+1); i < MAX_COMPONENTS; i++) 
				{
					if(cInfo[i][cType] == TPInfo[playerid][tType]) 
					{
						if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
						{
							compid = i;
							break;
						}
					}
				}
				if(compid == -1) return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
				
	            RemoveVehicleComponent( vehicleid, cInfo[TPInfo[playerid][tID]][cID]);

	            TPInfo[playerid][tID] = compid;

				new 
					tuningstring[128];
	            format( tuningstring, sizeof( tuningstring), "%s", cInfo[compid][cName]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
				format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[compid][cPrice]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

				AddVehicleComponent( vehicleid, cInfo[compid][cID]);

				SelectTextDraw( playerid, COLOR_ORANGE);
			}
			else if(TPInfo[playerid][tPaintjob] == true)
			{
			    new 
					paintid = -1, 
					vehicleid = GetPlayerVehicleID( playerid);
			    
			    for( new i = ( TPInfo[playerid][tID]+1); i < NUMBER_TYPE_PAINTJOB; i++) 
				{
			    	if(pjInfo[i][vehID] == GetVehicleModel( vehicleid))
					 {
						paintid = i;
						break;
					}
			   	}
				if(paintid == -1) return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");
                TPInfo[playerid][tID] = paintid;
                
				new 
					tuningstring[128];
                format( tuningstring, sizeof( tuningstring), "%s", pjInfo[paintid][ppName]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
				format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", pjInfo[paintid][pPrice]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);
                
                ChangeVehiclePaintjob( vehicleid, pjInfo[paintid][pNumber]);
                
                SelectTextDraw( playerid, COLOR_ORANGE);
			}
			return 1;
        }
        else if(playertextid == TuningBuy[playerid][8]) // Left
		{ 
            if(TPInfo[playerid][tPaintjob] == false) 
			{
	            if(!IsPlayerInAnyVehicle( playerid)) 
					return SendErrorMessage( playerid, "Morate biti u vozilu.");
				if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
					return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");
	            
				new 
					compid = -1, 
					vehicleid = GetPlayerVehicleID( playerid);

	            for( new i = (TPInfo[playerid][tID]-1); i > 0; i--) 
				{
					if(cInfo[i][cType] == TPInfo[playerid][tType]) 
					{
						if(cInfo[i][cID] == IsComponentidCompatible(GetVehicleModel(vehicleid), cInfo[i][cID]))
						{
							compid = i;
							break;
						}
					}
				}
				if(compid == -1) return SendErrorMessage( playerid, "Nema vise kompatibilnih komponenti za vase vozilo.");

				RemoveVehicleComponent( vehicleid, cInfo[TPInfo[playerid][tID]][cID]);

	            TPInfo[playerid][tID] = compid;

				new 
					tuningstring[128];
	            format( tuningstring, sizeof( tuningstring), "%s", cInfo[compid][cName]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
				format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", cInfo[compid][cPrice]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);

				AddVehicleComponent( vehicleid, cInfo[compid][cID]);

				SelectTextDraw( playerid, COLOR_ORANGE);
			}
			else if(TPInfo[playerid][tPaintjob] == true)
			{

			    new 
					paintid = -1, 
					vehicleid = GetPlayerVehicleID( playerid);

			    for( new i = (TPInfo[playerid][tID]-1); i > 0; i--) 
				{
			    	if(pjInfo[i][vehID] == GetVehicleModel( vehicleid)) 
					{
						paintid = i;
						break;
					}
			   	}
				if(paintid == -1) return SendErrorMessage( playerid, "Ne postoji kompatibilni paintjob za vase vozilo.");
				
                TPInfo[playerid][tID] = paintid;

				new 
					tuningstring[128];
                format( tuningstring, sizeof( tuningstring), "%s", pjInfo[paintid][ppName]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][3], tuningstring);
				format( tuningstring, sizeof( tuningstring), "Cijena: ~w~%d$", pjInfo[paintid][pPrice]);
				PlayerTextDrawSetString( playerid, TuningBuy[playerid][4], tuningstring);
				
                ChangeVehiclePaintjob( vehicleid, pjInfo[paintid][pNumber]);

                SelectTextDraw( playerid, COLOR_ORANGE);
			}
        }
        if(playertextid == TuningBuy[playerid][9]) // Buy
		{ 
            if(!IsPlayerInAnyVehicle( playerid)) 
				return SendErrorMessage( playerid, "Morate biti u vozilu.");
	        if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
				return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");
            
			new 
				Float:Pos[6], 
				vehicleid = GetPlayerVehicleID( playerid);

            if(TPInfo[playerid][tPaintjob] == false) 
			{
				new 
					cid = TPInfo[playerid][tID];
				if(cid == -1) return SendErrorMessage(playerid, "Dogodila se greska pri kupnji. Izadjite iz tuning menija sa ESC te pokusajte ponovno.");
				
				if(PlayerVIP[playerid][pDonateRank] < PREMIUM_SILVER)
					if(AC_GetPlayerMoney( playerid) < cInfo[TPInfo[playerid][tID]][cPrice]) return SendErrorMessage( playerid, "Nemate dovoljno novaca.");

		        RemoveVehicleComponent( vehicleid, cInfo[TPInfo[playerid][tID]][cID]);
		        VehicleInfo[vehicleid][vTuned] = true;
		        AddComponentToVehicle( vehicleid, cInfo[cid][cID]);
				
				new vehname[36];
				strunpack( vehname, Model_Name(VehicleInfo[vehicleid][vModel]));
				if(PlayerVIP[playerid][pDonateRank] > PREMIUM_BRONZE)
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Besplatno ste ugradili %s na %s.", cInfo[cid][cName], vehname);
				else
				{
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ugradili %s na %s za %d$.", cInfo[cid][cName], vehname, cInfo[cid][cPrice]);
					PlayerToBudgetMoney(playerid, cInfo[cid][cPrice]); // novac ide u proracun
				}
			}
			else if(TPInfo[playerid][tPaintjob] == true) 
			{
				if(PlayerVIP[playerid][pDonateRank] < PREMIUM_SILVER)
					if(AC_GetPlayerMoney( playerid) < pjInfo[TPInfo[playerid][tID]][pPrice]) return SendErrorMessage( playerid, "Nemate dovoljno novaca.");
			
			    new 
					paintid = TPInfo[playerid][tID];
			
			    VehicleInfo[vehicleid][vTuned] = true;
			    VehicleInfo[vehicleid][vPaintJob] = pjInfo[paintid][pNumber];
			    ChangeVehicleColor( vehicleid, 1, 1);
			    ChangeVehiclePaintjob( vehicleid, pjInfo[paintid][pNumber]);
				
				new vehname[36];
				strunpack( vehname, Model_Name(VehicleInfo[vehicleid][vModel]));
				if(PlayerVIP[playerid][pDonateRank] > PREMIUM_BRONZE)
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Besplatno ste ugradili PaintJob na %s.", vehname);
				else
				{
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste ugradili PaintJob na %s za %d$.", vehname, pjInfo[TPInfo[playerid][tID]][pPrice]);
					PlayerToBudgetMoney(playerid, pjInfo[TPInfo[playerid][tID]][pPrice]); // Novac ide u proracun
				}
				SaveVehicleTuning(vehicleid);
			}
			GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, 6, 2);
			SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

			GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
			SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
			
			CancelSelectTextDraw( playerid);

		    TuningTDControl( playerid, false);
		    TogglePlayerControllable( playerid, true);

			ShowPlayerDialog( playerid, DIALOG_TUNING, DIALOG_STYLE_LIST, D_TOP, D_TEXT, D_OK, D_CANCEL);
			return 1;
        }
        if(playertextid == TuningBuy[playerid][13]) // Close
		{
            if(!IsPlayerInAnyVehicle( playerid)) 
				SendErrorMessage( playerid, "Morate biti u vozilu.");
	        if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
				return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");

			Bit1_Set(gr_PlayerInTuningMode, playerid, false);
            new Float:Pos[6], vehicleid = GetPlayerVehicleID( playerid);

			if(TPInfo[playerid][tPaintjob] == false) 
			{
		        RemoveVehicleComponent( vehicleid, cInfo[TPInfo[playerid][tID]][cID]);
				SetVehicleTuning(vehicleid);
			}
			else if(TPInfo[playerid][tPaintjob] == true)
			 {
				if(VehicleInfo[vehicleid][vPaintJob] == 255)
				{
					ChangeVehiclePaintjob( vehicleid, 3);
					ChangeVehicleColor( vehicleid, VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2]);
				}
				else
				{
					ChangeVehicleColor(vehicleid, 1, 1);
					ChangeVehiclePaintjob( vehicleid, VehicleInfo[vehicleid][vPaintJob]);
				}
			}
			GetVehicleCameraPos( vehicleid, Pos[0], Pos[1], Pos[2], 0, 6, 2);
			SetPlayerCameraPos( playerid, Pos[0], Pos[1], Pos[2]);

			GetVehiclePos( vehicleid, Pos[0],Pos[1],Pos[2]);
			SetPlayerCameraLookAt( playerid, Pos[0],Pos[1],Pos[2]);
			
			CancelSelectTextDraw( playerid);

		    TuningTDControl( playerid, false);
		    TogglePlayerControllable( playerid, true);

			ShowPlayerDialog( playerid, DIALOG_TUNING, DIALOG_STYLE_LIST, D_TOP, D_TEXT, D_OK, D_CANCEL);
        }
    }
    return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(Text:INVALID_TEXT_DRAW == clickedid && Bit1_Get(gr_PlayerInTuningMode, playerid) && ClickedTuningTD[playerid] == true)
	{
		if(!IsPlayerInAnyVehicle( playerid)) 
			return SendErrorMessage( playerid, "Morate biti u vozilu.");
		if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
			return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");

		Bit1_Set(gr_PlayerInTuningMode, playerid, false);
		new vehicleid = GetPlayerVehicleID( playerid);

		if(TPInfo[playerid][tPaintjob] == false) 
		{
			RemoveVehicleComponent( vehicleid, cInfo[TPInfo[playerid][tID]][cID]);
			ChangeVehicleColor( vehicleid, VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2]);
			SetVehicleTuning(vehicleid);
		}
		else if(TPInfo[playerid][tPaintjob] == true) 
		{
			if(VehicleInfo[vehicleid][vPaintJob] == 255)
			{
				ChangeVehiclePaintjob( vehicleid, 3);
				ChangeVehicleColor( vehicleid, VehicleInfo[vehicleid][vColor1], VehicleInfo[vehicleid][vColor2]);
			}
			else
			{
				ChangeVehicleColor(vehicleid, 1, 1);
				ChangeVehiclePaintjob( vehicleid, VehicleInfo[vehicleid][vPaintJob]);
			}
		}
		CancelSelectTextDraw( playerid);
			
		TuningTDControl( playerid, false);
		TogglePlayerControllable( playerid, true);

		SetCameraBehindPlayer( playerid);
		DeletePlayerTuningTD(playerid);
	}
	return 1;
}

hook function ResetPrivateVehicleInfo(vehicleid)
{
	ResetVehicleTuning(vehicleid);
	return continue(vehicleid);
}

CMD:tuning(playerid, params[]) 
{
	new 
		pick[10];
	if(sscanf( params, "s[10] ", pick))
		 return SendClientMessage( playerid, -1, "[?]: /tuning buy | remove");
	
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 2321.9822, -1355.6526, 23.3999)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u mehanicarskoj garazi!");
	
	new 
		vehicleid = GetPlayerVehicleID(playerid);
	if(PlayerKeys[playerid][pVehicleKey] != vehicleid)
		 return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate se nalaziti u svome CO-u!");
	if(GetPlayerState( playerid) != PLAYER_STATE_DRIVER) 
		return SendErrorMessage( playerid, "Morate biti na mjestu vozaca!");
	if(Bit1_Get(gr_PlayerInTuningMode, playerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec namjestate tuning na svom vozilu!");
	
	if(!strcmp(pick, "buy", true)) 
	{
		Bit1_Set( gr_PlayerInTuningMode, playerid, true);
		PlayerTuningVehicle[playerid] = vehicleid;
		CreatePlayerTuningTextDraws(playerid);
		ShowPlayerDialog( playerid, DIALOG_TUNING, DIALOG_STYLE_LIST, D_TOP, D_TEXT, D_OK, D_CANCEL);
	}
	else if(!strcmp(pick, "remove", true)) 
	{
		Bit1_Set( gr_PlayerInTuningMode, playerid, true);
		PlayerTuningVehicle[playerid] = vehicleid;
		ShowPlayerDialog( playerid, DIALOG_TUNING_REMOVE, DIALOG_STYLE_LIST, "Odaberite komponentu koju zelite maknuti", D_TEXT, D_OK, D_CANCEL);
	}
	return 1;
}

CMD:remove_tuning(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni da koristite ovu komandu!");
	
	new
		vehicleid;
	if(sscanf( params, "i", vehicleid)) 
		return SendClientMessage(playerid, COLOR_RED, "[?]: /remove_tuning [vehicleid] (Koristite /dl)");
	if(!vehicleid || vehicleid == INVALID_VEHICLE_ID || !IsVehicleStreamedIn(vehicleid, playerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan unos vehicleida!");
	
	DeleteVehicleTuning(vehicleid);
	ResetVehicleTuning(vehicleid); 
	VehicleInfo[vehicleid][vTuned] = false;
	
	mysql_fquery(g_SQL, "UPDATE cocars SET tuned = '%d' WHERE id = '%d'",
		VehicleInfo[vehicleid][vTuned],
		VehicleInfo[vehicleid][vSQLID]
	);

	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Tuning je uspjesno uklonjen sa %s [SQL ID: %d]", 
		ReturnVehicleName(VehicleInfo[vehicleid][vModel]), 
		VehicleInfo[vehicleid][vSQLID]
	);
	return 1;
}