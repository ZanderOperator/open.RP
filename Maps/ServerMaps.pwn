#include <a_samp>
//#include <zcmd>
#include <streamer>
#include <YSI_Coding\y_timers>
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define GetPlayerFaction(%0) \
	CallRemoteFunction("FetchPlayerFaction", "i", %0)

#define GetPlayerFactionType(%0) \
	CallRemoteFunction("FetchPlayerFactionType", "i", %0)

// Faction Types
#define FACTION_TYPE_NONE				(0)
#define FACTION_TYPE_LAW				(1)
#define FACTION_TYPE_FD					(2)
#define FACTION_TYPE_LEGAL				(3)
#define FACTION_TYPE_MAFIA				(4)
#define FACTION_TYPE_GANG				(5)
#define FACTION_TYPE_RACERS				(6)
#define FACTION_TYPE_NEWS				(7)
#define FACTION_TYPE_LAW2				(8)

//UPDATE
// Include Maps

/* FACTIONS	*/
#include "../Maps/Police.pwn" // Sve mape za Police Department.
#include "../Maps/Hospital.pwn" // Sve mape za Medic
#include "../Maps/FireDepartment.pwn" // Sve mape/kapije za FD
#include "../Maps/LSN.pwn" // Sve mape za Los Santos News.
#include "../Maps/GOV.pwn" // Sve mape za GoV.
#include "../Maps/Gangs.pwn" // Sve mape za Ilegaflne organizacije  (+ hoods).

/*	MISC	*/
#include "../Maps/Events.pwn" // Sve mape za Evente. -
#include "../Maps/Interiors.pwn" // Sve mape kreirane u interior-u.
#include "../Maps/Exteriors.pwn" // Sve mape kreirane za izgled grada(exteriori).
#include "../Maps/Jobs.pwn" // Sve mape kreirane za poslove.
#include "../Maps/Houses.pwn" // Sve mape kreirane za kuce(exteriori & interiori).
#include "../Maps/Business.pwn" // Sve mape kreirane za biznise (klubovi, barovi, restorani, casino...).
#include "../Maps/Other.pwn" // Sve ostale mape koje nemaju kategoriji.
#include "../Maps/newenvmaps.pwn" // Nove mape ubacene 2020. by Khawaja
#include "../Maps/khawajamaps.pwn"
/* #include "../Maps/Sheriffs.pwn" // Ukinute mape zato sto nemaju funkcije bez SDa */
/* #include "../Maps/Backup.pwn" // Sve ostale mape koje ce se mozda koristiti u buducnosti. */


new sddoors1,
	sddoors2,
	sddoors3,
	sddoors4,
	hroom1,
	hroom2,
	hroom3,
	hroom4;

//  OFFICES
new
	officesdoor1,
	officesdoor2,
	officesdoor3,
	security1,
	security2,
	security3;

new rampa,
	rampastatus;

//Hoover
new pdHovDoor[8],
	pdHovDoorStatus[8];

// SASD
new
	sdIntDoors1,
	sdIntDoors2,
	sdIntDoors3,
	sdIntDoors4,
	sdDoorsStatus1 = 0,
	sdDoorsStatus2 = 0,
	sdDoorsStatus3 = 0,
	sdDoorsStatus4 = 0;

//Eaststation
new eastStationDoor[16],
	eastStationDStatus[16];

//FD Interior
new FdIntDoor[6],
	FdIntDoorStatus[6];

//Rollcall
new rollcall[8];
new rollcallStatus[8];

//Daut bike
new daut;
new dautStatus;

//
new dojdoors[14];
new dojdoorsStatus[14];
//bank
new bank_door;
new bankdoorStatus;
// SASD
new
	pdIntDoors1,
	pdIntDoors2,
	pdIntDoors3,
	pdIntDoors4,
	pdIntDoors5,
	pdIntDoors6,
	pdDoorsStatus1 = 0,
	pdDoorsStatus2 = 0,
	pdDoorsStatus3 = 0,
	pdDoorsStatus4 = 0,
	pdDoorsStatus5 = 0,
	pdDoorsStatus6 = 0;

stock CreateMapIcons()
{
	CreateDynamicMapIcon(1481.0137, -1772.4517, 17.7345, 40, 0, -1, -1, -1, 300.0, MAPICON_LOCAL);  // Vjecnica
	CreateDynamicMapIcon(1554.7473, -1675.6938, 16.1953, 30, 0, -1, -1, -1, 500.0, MAPICON_LOCAL);  // LSPD
	CreateDynamicMapIcon(1173.3197, -1323.3169, 15.3934, 22, 0, -1, -1, -1, 400.0, MAPICON_LOCAL);  // HOSPITAL
	CreateDynamicMapIcon(1129.1273, -1490.1561, 21.7366, 17, 0, -1, -1, -1, 500.0, MAPICON_LOCAL);  // Verona Mall
	CreateDynamicMapIcon(110.1072,  -1818.6821, 0.9792,	 9,  0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Boat
	CreateDynamicMapIcon(1958.5725, -2270.2456, 12.5152, 5,  0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Aero
	CreateDynamicMapIcon(2115.0952, -1806.4358, 21.2020, 29, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Pizza
	CreateDynamicMapIcon(2235.4922, -1716.8300, 12.5410, 54, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Gym
	CreateDynamicMapIcon(1199.2405, -919.0047,  42.1115, 10, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Burg
	CreateDynamicMapIcon(592.6005, -1236.4147, 18.5241, 52, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Banka
	CreateDynamicMapIcon(546.5988, -1287.6221, 17.3315, 46, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Wangs
	CreateDynamicMapIcon(327.37140, -620.70010, 8.70690, 11, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); 	// Rudnik
	CreateDynamicMapIcon(1154.2377,-1770.3418,16.5938, 55, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); //DMV
	CreateDynamicMapIcon(1126.3856,-2036.8966,69.8837, 42, 0, -1, -1, -1, 300.0, MAPICON_LOCAL); //GOVERNORS MANSION
	return 1;
}

public OnFilterScriptInit()
{

	//
	tmpobjid = CreateObject(11387, 1613.032592, -1817.345947, 15.791243, -0.000012, 0.000003, -94.999984, 300.00);
	tmpobjid = CreateObject(11390, 1629.835083, -1809.347290, 16.802244, -0.000012, 0.000003, -94.999984, 300.00);
	tmpobjid = CreateObject(11389, 1629.801757, -1809.414672, 15.571244, -0.000012, 0.000003, -94.998985, 300.00);
	tmpobjid = CreateObject(11393, 1624.133056, -1813.532836, 14.068243, -0.000012, 0.000003, -94.999984, 300.00);
	tmpobjid = CreateObject(11391, 1622.423217, -1800.631469, 13.790244, -0.000012, 0.000003, -94.999984, 300.00);
	tmpobjid = CreateObject(11388, 1629.871459, -1809.351440, 19.218244, -0.000012, 0.000003, -94.999984, 300.00);
	tmpobjid = CreateObject(11359, 1613.755859, -1803.490600, 14.566244, -0.000012, 0.000003, -94.799980, 300.00);
	tmpobjid = CreateObject(11360, 1632.596801, -1818.931640, 14.606244, 0.000012, -0.000003, 84.998924, 300.00);

	// Map Icons
	CreateMapIcons();
	//PD Ramp
	rampa = CreateDynamicObject(968, 2163.574462, -2158.066650, 13.286876, 0.000000, 270.000000, -134.399902, -1, -1, -1, 600.00, 600.00);
	//Eaststation
	eastStationDoor[0] = CreateDynamicObject(1569, 2840.729003, -853.287231, -22.709405, 0.000000, 0.000000, 0.000000, 12, 3, -1, 600.00, 600.00);
	eastStationDoor[1] = CreateDynamicObject(1569, 2840.348632, -843.507019, -22.709405, 0.000000, 0.000000, 0.000000, 12, 3, -1, 600.00, 600.00);
	eastStationDoor[2] = CreateDynamicObject(1569, 2846.740234, -843.507019, -22.709405, 0.000000, 0.000000, 0.000000, 12, 3, -1, 600.00, 600.00);
    eastStationDoor[3] = CreateDynamicObject(3089, 2857.778564, -851.530944, -21.609405, 0.000000, 0.000000, 540.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[3], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[3], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[4] = CreateDynamicObject(3089, 2864.160644, -845.110900, -21.609405, 0.000000, 0.000000, 540.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[4], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[4], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[5] = CreateDynamicObject(3089, 2855.417724, -855.451354, -21.609405, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[5], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[5], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[6] = CreateDynamicObject(3089, 2852.416503, -854.191589, -21.609405, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[6], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[6], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[7] = CreateDynamicObject(3089, 2852.416503, -844.611267, -21.609405, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[7], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[7], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[8] = CreateDynamicObject(3089, 2857.998779, -839.790771, -21.609405, 0.000000, 0.000000, 540.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[8], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[8], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[9] = CreateDynamicObject(3089, 2874.582519, -842.920532, -21.609405, 0.000000, 0.000000, 810.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[9], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[9], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
    eastStationDoor[10] = CreateDynamicObject(3089, 2874.582519, -836.530212, -21.609405, 0.000000, 0.000000, 810.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[10], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[10], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[11] = CreateDynamicObject(3089, 2868.307373, -854.201354, -21.609405, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[11], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[11], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[12] = CreateDynamicObject(3089, 2857.778564, -845.100036, -21.609405, 0.000000, 0.000000, 540.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[12], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[12], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);
	eastStationDoor[13] = CreateDynamicObject(3089, 2867.388671, -851.470153, -21.609405, 0.000000, 0.000000, 540.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[13], 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(eastStationDoor[13], 2, 642, "canopy", "weathered wood2 64HV", 0x00000000);

    eastStationDoor[14] = CreateDynamicObject(1495, 2879.107177, -838.282592, -22.719406, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[14], 2, 18250, "cw_junkbuildcs_t", "Was_scrpyd_baler_locker", 0x00000000);
	eastStationDoor[15] = CreateDynamicObject(1495, 2879.107177, -832.352050, -22.719406, 0.000000, 0.000000, 270.000000, 12, 3, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(eastStationDoor[15], 2, 18250, "cw_junkbuildcs_t", "Was_scrpyd_baler_locker", 0x00000000);

	/*/SD
	sdIntDoors1 = CreateDynamicObject(1569, 602.049438, -565.793701, 41.418514, 0.000000, -0.000007, -89.999984, 8, -1, -1, 600.00, 600.00);
	sdIntDoors2 = CreateDynamicObject(1569, 604.469482, -568.015014, 41.418514, 0.000007, 0.000000, 179.999954, 8, -1, -1, 600.00, 600.00);
	sdIntDoors3 = CreateDynamicObject(1569, 617.409057, -560.354003, 44.888515, 0.000000, -0.000007, -89.999984, 8, -1, -1, 600.00, 600.00);
	sdIntDoors4 = CreateDynamicObject(1569, 617.409057, -558.494506, 44.888515, -0.000000, 0.000007, 89.999969, 8, -1, -1, 600.00, 600.00);*/

	// New house int - Putnik
	CreateDynamicObject(19864, 2577.23535, -1300.28516, 1062.48743,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19864, 2551.29639, -1290.59851, 90.00000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19864, 2551.28076, -1290.45349, 1062.48743,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3471, 2546.90088, -1285.02136, 1060.94556,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3525, 2569.01514, -1305.90857, 1059.34216,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1463, 2569.10181, -1306.26099, 1059.98621,   0.00000, 0.00000, 90.00000);
	//Bank
	bank_door = CreateDynamicObject(19859, 1411.693603, -14.584956, 1001.244140, 0.000000, 0.000000, 180.000000, 9, 4, -1, 600.00, 600.00);
	// ATM
	CreateDynamicObject(2942, 1208.9, -904.5, 42.7, 0.00, 0.00, 98.00);
	// noddii - novoubaceni objekti ATM-a koji su falili
	CreateDynamicObject(19324,604.0446800,-1248.2198500,18.0605000,0.0000000,0.0000000,-159.0000000);
	CreateDynamicObject(19324,1155.2985800,-1463.9014900,15.4300000,0.0000000,0.0000000,289.0000000);
	
	//Daut doors
    daut = CreateDynamicObject(1495, 779.223815, 1447.565307, 1471.464843, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);

	//PD Hoover Heliport INT Doors
	pdHovDoor[0] = CreateDynamicObject(1569, 2096.445312, -2127.584228, -45.286499, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[1] = CreateDynamicObject(1569, 2102.835937, -2127.584228, -45.276504, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[2] = CreateDynamicObject(1569, 2098.865722, -2133.225341, -45.236507, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[3] = CreateDynamicObject(1569, 2103.714599, -2129.521728, -41.676513, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[4] = CreateDynamicObject(1569, 2097.364257, -2129.521728, -41.676513, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[5] = CreateDynamicObject(1569, 2098.265136, -2150.105468, -45.236507, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
	pdHovDoor[6] = CreateDynamicObject(1569, 2103.025390, -2150.105468, -45.236507, 0.000000, 0.000000, 0.000000, -1, 4, -1, 600.00, 600.00);
    pdHovDoor[7] = CreateDynamicObject(1569, 2110.802734, -2142.743164, -45.156505, 0.000000, 0.000000, 180.000000, -1, 4, -1, 600.00, 600.00);
	//PD MAIN HQ-Lobby Vrata
	pdIntDoors1 = CreateDynamicObject(19859, 1549.908935, -1669.359619, -19.673768, 0.000000, 0.000000, 630.000000, 7, 2,  -1, 999.00, 999.00);
	pdIntDoors2 = CreateDynamicObject(19859, 1555.919799, -1669.289550, -19.673768, 0.000000, 0.000000, 990.000000, 7, 2,  -1, 999.00, 999.00);
	pdIntDoors3 = CreateDynamicObject(19859, 1555.919799, -1672.481445, -19.673768, 0.000000, 0.000000, 990.000000, 7, 2,  -1, 999.00, 999.00);
	pdIntDoors4 = CreateDynamicObject(19859, 1555.919799, -1681.940429, -19.673768, 0.000000, 0.000000, 990.000000, 7, 2,  -1, 999.00, 999.00);
	pdIntDoors5 = CreateDynamicObject(19859, 1549.999267, -1687.001220, -19.673768, 0.000000, 0.000000, 990.000000, 7, 2,  -1, 999.00, 999.00);
	pdIntDoors6 = CreateDynamicObject(19859, 1547.628662, -1664.198852, -16.093763, 0.000000, 0.000000, 990.000000, 7, 2,  -1, 999.00, 999.00);
	//FD Interior Door
	FdIntDoor[0] = CreateDynamicObject(3089, 1072.102783, -1770.428833, -36.932189, 0.000000, 0.000000, 90.000000, -1, 3, -1, 300.00, 300.00);
	FdIntDoor[1] = CreateDynamicObject(3089, 1072.102783, -1773.619262, -36.932189, 0.000000, 0.000000, 90.000000, -1, 3, -1, 300.00, 300.00);
	FdIntDoor[2] = CreateDynamicObject(3089, 1075.632812, -1774.569824, -36.932189, 0.000000, 0.000000, 180.000000, -1, 3, -1, 300.00, 300.00);
	FdIntDoor[3] = CreateDynamicObject(3089, 1078.192871, -1768.929809, -36.912193, 0.000000, 0.000000, 270.000000, -1, 3, -1, 300.00, 300.00);
    FdIntDoor[4] = CreateDynamicObject(1569, 1078.170288, -1783.308227, -38.242198, 0.000000, 0.000000, 90.000000, -1, 3, -1, 300.00, 300.00);
    FdIntDoor[5] = CreateDynamicObject(1569, 1077.270385, -1784.148925, -38.242198, 0.000000, 0.000000, 180.000000, -1, 3, -1, 300.00, 300.00);

	//DOJ
	dojdoors[0] = CreateDynamicObject(19859, 1412.719604, -22.985584, 1095.300292, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[1] = CreateDynamicObject(19859, 1409.718139, -22.985584, 1095.300292, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[1] = CreateDynamicObject(19859, 1411.948852, -22.965583, 1099.682006, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[2] = CreateDynamicObject(19859, 1410.447509, -4.445575, 1099.682006, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[3] = CreateDynamicObject(19859, 1415.888061, -3.485574, 1099.682006, 0.000000, 0.000000, 810.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[4] = CreateDynamicObject(19859, 1398.275634, -4.395574, 1099.682006, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[5] = CreateDynamicObject(19859, 1384.754394, -4.465575, 1099.682006, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[6] = CreateDynamicObject(19859, 1387.746093, -4.465575, 1099.682006, 0.000000, 0.000000, 900.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[7] = CreateDynamicObject(19859, 1392.026977, 14.604436, 1099.682006, 0.000000, 0.000000, 900.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[8] = CreateDynamicObject(19859, 1380.236938, 14.604436, 1099.682006, 0.000000, 0.000000, 1080.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[9] = CreateDynamicObject(19859, 1378.347534, 8.264427, 1099.682006, 0.000000, 0.000000, 1260.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[10] = CreateDynamicObject(19859, 1386.248657, 17.904453, 1099.682006, 0.000000, 0.000000, 1080.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[11] = CreateDynamicObject(19859, 1399.800048, 17.904453, 1099.682006, 0.000000, 0.000000, 1260.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[12] = CreateDynamicObject(19859, 1400.840087, 8.304452, 1099.682006, 0.000000, 0.000000, 1530.000000, -1, -1, -1, 600.00, 600.00);
	dojdoors[13] = CreateDynamicObject(19859, 1400.840087, 6.594449, 1099.682006, 0.000000, 0.000000, 1710.000000, -1, -1, -1, 600.00, 600.00);
	//PD Rollcall
    rollcall[0] = CreateDynamicObject(19859, 1899.520385, 1324.749267, -16.577264, 0.000000, 0.000000, 0.000000, 7, 2,  -1, 999.00, 999.00);
	rollcall[1] = CreateDynamicObject(19859, 1902.511352, 1324.758789, -16.577264, 0.000000, 0.000000, -179.900039, 7, 2,  -1, 999.00, 999.00);
	rollcall[2] = CreateDynamicObject(19859, 1899.520385, 1351.920043, -16.577264, 0.000000, 0.000000, 0.000000, 7, 2,  -1, 999.00, 999.00);
	rollcall[3] = CreateDynamicObject(19859, 1902.463867, 1351.918823, -16.577264, 0.000000, 0.000000, -179.900039, 7, 2,  -1, 999.00, 999.00);
	rollcall[4] = CreateDynamicObject(19859, 1904.413208, 1327.033325, -16.577264, 0.000000, 0.000000, 90.199951, 7, 2,  -1, 999.00, 999.00);
	rollcall[5] = CreateDynamicObject(19859, 1904.430297, 1344.963378, -16.577264, 0.000000, 0.000000, 90.199951, 7, 2,  -1, 999.00, 999.00);
	rollcall[6] = CreateDynamicObject(19859, 1897.627319, 1345.590087, -16.577264, 0.000000, 0.000000, 90.199951, 7, 2,  -1, 999.00, 999.00);
	rollcall[7] = CreateDynamicObject(19859, 1897.633422, 1335.219604, -16.577264, 0.000000, 0.000000, 90.199951, 7, 2,  -1, 999.00, 999.00);

	// Objekti ispred naplesa
	CreateDynamicObject(2764,2089.19995117,-1912.30004883,13.00000000,0.00000000,0.00000000,359.25000000, -1, -1, -1, 75.0, 0.0); //object(cj_pizza_table03)(1)
	CreateDynamicObject(2764,2089.10009766,-1917.80004883,13.00000000,0.00000000,0.00000000,359.25000000, -1, -1, -1, 75.0, 0.0); //object(cj_pizza_table03)(2)
	CreateDynamicObject(2788,2090.69995117,-1912.30004883,13.10000038,0.00000000,0.00000000,0.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(1)
	CreateDynamicObject(2788,2089.30004883,-1910.80004883,13.10000038,0.00000000,0.00000000,88.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(2)
	CreateDynamicObject(2788,2087.80004883,-1912.30004883,13.10000038,0.00000000,0.00000000,180.25000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(3)
	CreateDynamicObject(2788,2089.19995117,-1913.80004883,13.10000038,0.00000000,0.00000000,269.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(4)
	CreateDynamicObject(2788,2090.60009766,-1917.80004883,13.10000038,0.00000000,0.00000000,0.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(6)
	CreateDynamicObject(2788,2087.69995117,-1917.80004883,13.10000038,0.00000000,0.00000000,180.75000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(7)
	CreateDynamicObject(2788,2089.19995117,-1916.30004883,13.10000038,0.00000000,0.00000000,90.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(8)
	CreateDynamicObject(2788,2089.10009766,-1919.30004883,13.10000038,0.00000000,0.00000000,269.00000000, -1, -1, -1, 75.0, 0.0); //object(cj_burg_chair)(9)


	// Sprjecavaju propadanje
	CreateDynamicObject(2634, 681.5081, -450.9070, -25.2172, 0.0, 0.0, 358.2992, -1, -1, -1, 100.00);
	CreateDynamicObject(2634, 681.5081, -450.9070, -23.2172, 0.0, 0.0, 358.2992, -1, -1, -1, 100.00);
	CreateDynamicObject(2634, 2849.6274, -2260.3918, 1127.0435, 0.0, 0.0, 179.7936, -1, -1, -1, 100.00);

	// Kosilice - Javier
	CreateDynamicObject(994,1851.9000000,-1062.7000000,23.1000000,0.0000000,0.0000000,270.0000000); //object(lhouse_barrier2) (1)
	CreateDynamicObject(994,1851.9000000,-1055.8000000,23.1000000,0.0000000,0.0000000,270.0000000); //object(lhouse_barrier2) (2)
	CreateDynamicObject(994,1851.9000000,-1049.0000000,23.1000000,0.0000000,0.0000000,270.0000000); //object(lhouse_barrier2) (3)
	CreateDynamicObject(994,1851.9000000,-1034.7000000,23.1000000,0.0000000,0.0000000,270.0000000); //object(lhouse_barrier2) (4)
	CreateDynamicObject(994,1851.9000000,-1041.8000000,23.1000000,0.0000000,0.0000000,270.0000000); //object(lhouse_barrier2) (5)
	CreateDynamicObject(994,1976.6000000,-1475.8000000,12.6000000,0.0000000,0.0000000,180.0000000); //object(lhouse_barrier2) (6)
	CreateDynamicObject(994,1970.1000000,-1475.8000000,12.6000000,0.0000000,0.0000000,179.9945100); //object(lhouse_barrier2) (7)
	CreateDynamicObject(994,1963.5000000,-1475.8000000,12.5000000,0.0000000,0.0000000,179.9945100); //object(lhouse_barrier2) (8)
	CreateDynamicObject(994,1837.0000000,-1482.4000000,12.5000000,0.0000000,0.0000000,89.9945070); //object(lhouse_barrier2) (9)
	CreateDynamicObject(994,1861.7002000,-1482.9004000,12.5000000,0.0000000,0.0000000,89.9945070); //object(lhouse_barrier2) (10)
	CreateDynamicObject(673,1859.3000000,-1042.7000000,23.0000000,0.0000000,0.0000000,0.0000000); //object(sm_bevhiltree) (1)
	CreateDynamicObject(673,1868.4000000,-1035.2000000,22.9000000,0.0000000,0.0000000,0.0000000); //object(sm_bevhiltree) (2)
	CreateDynamicObject(673,1854.7000000,-1064.7000000,23.0000000,0.0000000,0.0000000,0.0000000); //object(sm_bevhiltree) (3)
	CreateDynamicObject(673,1855.8000000,-1054.1000000,23.0000000,0.0000000,0.0000000,0.0000000); //object(sm_bevhiltree) (4)
	CreateDynamicObject(673,1879.3000000,-1031.3000000,23.0000000,0.0000000,0.0000000,0.0000000); //object(sm_bevhiltree) (5)
	CreateDynamicObject(822,1863.9000000,-1038.2000000,23.9000000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06) (1)
	CreateDynamicObject(1232,1857.0000000,-1069.0000000,25.5000000,0.0000000,0.0000000,0.0000000); //object(streetlamp1) (1)
	CreateDynamicObject(1232,1859.7000000,-1055.5000000,25.5000000,0.0000000,0.0000000,0.0000000); //object(streetlamp1) (2)
	CreateDynamicObject(1232,1868.3000000,-1042.7000000,25.5000000,0.0000000,0.0000000,0.0000000); //object(streetlamp1) (3)
	CreateDynamicObject(1232,1881.2000000,-1033.9000000,25.6000000,0.0000000,0.0000000,0.0000000); //object(streetlamp1) (4)
	CreateDynamicObject(1232,1893.9000000,-1030.7000000,25.5000000,0.0000000,0.0000000,0.0000000); //object(streetlamp1) (5)

	// Tuning
	CreateDynamicObject(986, 2644.8, -2039.1, 12.2, 0, 0, 0);
	CreateDynamicObject(986, 1042.1, -1026, 32.5, 0, 0, 0);
	CreateDynamicObject(986, -1935.4, 238.60001, 34.9, 0, 0, 0);
	CreateDynamicObject(986, 2386.7002, 1043.4004, 9.8, 0, 0, 0);
	CreateDynamicObject(986, -2716, 217.60001, 3.3, 0, 0, 90);
	CreateDynamicObject(986, 1843.3, -1855.4, 14.3, 0, 180, 90);


	// Pay 'n' Sprays
	CreateDynamicObject(975, 2071.54492, -1831.11218, 14.36484,   0.00000, 0.00000, 90.24015); //Idlewood
	CreateDynamicObject(975, 489.31689, -1735.36963, 12.28431,   0.00000, 0.00000, -9.29999); //Santa Maria
	CreateDynamicObject(975, 1025.51855, -1029.07166, 32.99280,   0.10000, 0.00000, 0.60000); //Temple
	CreateDynamicObject(975, 720.23773, -462.52246, 16.82595,   0.00000, 0.00000, 0.00000); //Dillimore
	CreateDynamicObject(975, -100.14352, 1111.52502, 21.05994,   0.00000, 0.00000, -0.18000); //Fort Carson
	CreateDynamicObject(975, -1420.64014, 2591.10156, 56.81979,   0.00000, 0.00000, 0.00000); // El Qua ...
	CreateDynamicObject(975, -1904.89099, 277.66046, 42.35647,   0.00000, 0.00000, 0.00000); // San Fierro
	return 1;
}

public OnPlayerConnect(playerid) {
	RemovePlayerBuildings(playerid);
	return 1;
}

stock RemovePlayerBuildings(playerid)
{
	// From Main.pwn
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
	
	/*//SD
    RemoveBuildingForPlayer(playerid, 13484, 738.3984, -553.9844, 21.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 13137, 646.1641, -527.8984, 28.0703, 0.25);*/

	//PD Station
	RemoveBuildingForPlayer(playerid, 3622, 2135.739, -2186.449, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3687, 2135.739, -2186.449, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3622, 2150.199, -2172.360, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3687, 2150.199, -2172.360, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 1428, 1981.310, 154.733, 45.031, 0.250);
	RemoveBuildingForPlayer(playerid, 3622, 2162.850, -2159.750, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3687, 2162.850, -2159.750, 15.671, 0.250);
	RemoveBuildingForPlayer(playerid, 1531, 2173.590, -2165.189, 15.304, 0.250);

	// THUGLIFE skola eksterijer 7.12.2018.
	RemoveBuildingForPlayer(playerid, 726, 958.039, -1678.054, 10.742, 0.250);
	RemoveBuildingForPlayer(playerid, 729, 940.929, -1668.859, 11.320, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 930.070, -1649.406, 4.968, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 930.140, -1662.296, 4.968, 0.250);
	RemoveBuildingForPlayer(playerid, 748, 934.343, -1635.867, 12.523, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 933.101, -1634.851, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 943.273, -1640.320, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 951.867, -1639.406, 11.921, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 944.734, -1637.148, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 945.265, -1638.804, 20.898, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 972.335, -1675.539, 11.382, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 975.726, -1705.585, 11.921, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 975.609, -1689.265, 11.382, 0.250);
	RemoveBuildingForPlayer(playerid, 615, 968.226, -1665.687, 12.210, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 975.609, -1662.210, 11.382, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 963.546, -1639.406, 11.921, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 968.906, -1635.210, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 748, 971.000, -1634.781, 12.617, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 968.257, -1634.109, 20.898, 0.250);
	RemoveBuildingForPlayer(playerid, 748, 929.281, -1632.710, 12.617, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 931.273, -1631.921, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 932.101, -1632.898, 20.898, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 949.921, -1624.718, 11.921, 0.250);
	RemoveBuildingForPlayer(playerid, 634, 961.117, -1624.718, 11.921, 0.250);
	RemoveBuildingForPlayer(playerid, 748, 966.562, -1630.789, 12.523, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 967.609, -1632.000, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, 922.882, -1623.757, 15.937, 0.250);

	// Krofinca Spawn - makkion
	RemoveBuildingForPlayer(playerid, 1438, 1015.5313, -1337.1719, 12.5547, 0.25);

	// VineWood - THUGLIFE
	RemoveBuildingForPlayer(playerid, 717, 1038.078, -1155.375, 23.000, 0.250);

	// Verona Mall - Jibbrah
	RemoveBuildingForPlayer(playerid, 6130, 1117.585, -1490.007, 32.718, 0.250);
	RemoveBuildingForPlayer(playerid, 6255, 1117.585, -1490.007, 32.718, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1128.734, -1518.492, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1111.257, -1512.359, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1106.437, -1501.375, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1144.398, -1512.789, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1152.382, -1502.539, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1118.015, -1467.468, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1139.921, -1467.468, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1139.921, -1456.437, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1118.015, -1456.437, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1139.921, -1445.101, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1118.015, -1445.101, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1139.921, -1434.070, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1118.015, -1434.070, 15.210, 0.250);
	RemoveBuildingForPlayer(playerid, 762, 1175.359, -1420.187, 19.882, 0.250);

	// Kasino - Zen
	RemoveBuildingForPlayer(playerid, 620, 1292.000, -1374.300, 12.367, 0.250);
	RemoveBuildingForPlayer(playerid, 1312, 1307.619, -1394.479, 16.500, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, 1309.900, -1390.119, 15.640, 0.250);

	// Smetlar - L3o
	RemoveBuildingForPlayer(playerid, 3723, 2197.7500, -1993.3594, 14.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 3722, 2197.7500, -1993.3594, 14.9922, 0.25);


	// Mayor Bina - Zen
	RemoveBuildingForPlayer(playerid, 1231, 1479.699, -1716.699, 15.625, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.699, -1702.530, 15.625, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.380, -1692.390, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.380, -1682.310, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.770, -1682.670, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.770, -1693.729, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.770, -1704.589, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.770, -1713.699, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.979, -1694.050, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.979, -1682.719, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.979, -1704.640, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.979, -1713.510, 13.453, 0.250);

	// CJ Int - Putnik
	RemoveBuildingForPlayer(playerid, 2304, 2555.6953, -1305.8750, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2556.7031, -1305.8672, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2555.7031, -1304.9063, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2555.7031, -1303.9219, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2555.7031, -1302.9297, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2681, 2548.9375, -1298.2734, 1059.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 2128, 2555.6953, -1298.9609, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2130, 2555.6953, -1301.9219, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2555.7031, -1299.9531, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2294, 2558.6641, -1305.8750, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2294, 2559.6563, -1305.8750, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2129, 2557.6953, -1305.8672, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2127, 2555.7031, -1297.9688, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 937, 2551.3438, -1297.7422, 1060.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 937, 2552.9844, -1298.0469, 1060.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 2681, 2548.9375, -1297.4531, 1059.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 937, 2552.9844, -1296.8047, 1060.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 923, 2553.3984, -1295.2578, 1061.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 14449, 2567.6172, -1294.6328, 1061.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 2681, 2546.7031, -1289.9063, 1060.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 923, 2553.3984, -1293.2969, 1061.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2606, 2546.1563, -1286.0469, 1062.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 2606, 2546.1563, -1286.0469, 1061.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2606, 2546.1563, -1286.0469, 1061.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 2606, 2546.1563, -1286.0469, 1060.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1829, 2546.7813, -1280.6719, 1060.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1788, 2546.3359, -1282.8984, 1060.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 1788, 2546.3359, -1282.8984, 1060.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1703, 2550.1406, -1286.6016, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 2028, 2549.0938, -1283.2188, 1060.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 2104, 2549.4375, -1279.8438, 1060.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2229, 2548.0156, -1279.8750, 1060.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 2229, 2551.0156, -1280.1250, 1060.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1703, 2551.2813, -1283.6875, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 1704, 2551.5000, -1280.3984, 1059.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 14441, 2559.7891, -1285.2500, 1067.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 2672, 2557.0078, -1283.8438, 1060.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 14446, 2573.1641, -1281.7031, 1064.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1775, 2576.7031, -1284.4297, 1061.0938, 0.25);

	// Santa Maria Road - jamesH
	RemoveBuildingForPlayer(playerid, 759, 696.226, -1655.273, 2.492, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 692.507, -1656.070, 2.492, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 701.187, -1646.820, 2.468, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 697.742, -1637.273, 2.468, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 701.179, -1639.640, 2.085, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 701.187, -1632.140, 2.468, 0.250);
	RemoveBuildingForPlayer(playerid, 759, 701.187, -1634.320, 2.468, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 708.914, -1622.742, 5.101, 0.250);

	RemoveBuildingForPlayer(playerid, 3260, -1431.0234, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1437.0391, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1437.9766, -967.2344, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1435.0391, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1433.0313, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1427.0391, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1429.0391, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1425.0391, -968.3203, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1424.0391, -967.2969, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 17074, -1430.1328, -966.2266, 199.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1437.9766, -965.2344, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1437.9766, -963.2344, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1431.0313, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1433.0313, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1435.0391, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1437.0391, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1427.0391, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1429.0313, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1425.0391, -962.1016, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1423.0000, -962.2500, 200.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -1423.2969, -965.4609, 200.8125, 0.25);

	RemoveBuildingForPlayer(playerid, 3421, 2351.8281, -652.9219, 129.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3414, 2351.8281, -652.9219, 129.1875, 0.25);

	//jamesH - MAPA
	RemoveBuildingForPlayer(playerid, 935, 2119.8203, -84.4063, -0.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1369, 2104.0156, -105.2656, 1.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2122.3750, -83.3828, 0.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2119.5313, -82.8906, -0.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2120.5156, -79.0859, 0.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2119.4688, -69.7344, 0.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2119.4922, -73.6172, 0.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 933, 2159.4063, -93.9219, 1.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 933, 2158.1094, -94.1406, 2.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 933, 2155.9141, -121.0391, 0.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 935, 2117.8438, -67.8359, 0.1328, 0.25);


	// Alhambra - Putnik
	RemoveBuildingForPlayer(playerid, 2670, 479.5078, -20.3828, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 478.2188, -19.4141, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 477.2109, -16.1016, 1003.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2173, 476.5313, -14.4453, 1002.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 477.3203, -13.9375, 1003.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 478.6016, -7.6953, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 479.2891, -5.4063, 1001.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 479.8203, -5.8125, 1001.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 501.4141, -7.5547, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 497.1563, -7.1094, 999.7813, 0.25);

	// Semafori - Icco
	RemoveBuildingForPlayer(playerid, 1283, 1193.1328, -1851.4688, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1174.1016, -1835.5000, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1411.2188, -1872.9297, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1405.1563, -1871.6016, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1373.4609, -1872.2266, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1388.3906, -1855.6719, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1442.9375, -1871.4219, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1311.2734, -1746.1172, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1345.7656, -1740.6172, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1325.7109, -1732.8281, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1335.1953, -1731.7813, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1357.5156, -1732.9375, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1441.8594, -1733.0078, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1414.4141, -1731.4297, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1430.1719, -1719.4688, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1513.2344, -1732.9219, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1516.1641, -1591.6563, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1553.9844, -1873.0703, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1568.9297, -1855.1094, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1585.6797, -1871.6719, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1568.8828, -1745.4766, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1545.7656, -1731.6719, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1530.1172, -1717.0078, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1582.6719, -1733.1328, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1688.9141, -1826.5078, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1690.0938, -1796.8516, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1702.9141, -1813.1094, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1762.7891, -1732.8281, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1736.5313, -1731.7969, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1750.2656, -1719.6328, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1528.9531, -1605.8594, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1690.2813, -1607.8438, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1544.6250, -1593.0313, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1664.9063, -1593.1250, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1646.6016, -1591.6875, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1658.5313, -1583.3203, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1676.7813, -1591.6094, 15.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1703.9063, -1593.6719, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1597.0938, -1296.7969, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1611.7344, -1311.2734, 19.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1722.8750, -1302.0391, 15.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1711.9766, -1291.9453, 15.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1479.3047, -1042.0781, 25.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1575.4688, -1152.5859, 26.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1585.8828, -1162.0313, 26.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1490.2969, -1031.6641, 25.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1716.8672, -1169.8672, 25.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1707.0625, -1159.1016, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1810.3125, -2170.2891, 15.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1835.6563, -2162.6719, 15.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1819.5000, -2154.6094, 15.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2216.8281, -1983.3750, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2302.5859, -1975.3516, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2402.5078, -1975.4844, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2410.7656, -1998.8047, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2416.6641, -1983.8672, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2416.6641, -2020.9688, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2210.9297, -1961.2109, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2084.5313, -1905.4922, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2092.9141, -1891.3750, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2078.6328, -1883.3281, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2225.2109, -1969.2500, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2329.5469, -1969.9688, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2311.2266, -1954.4531, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2410.7656, -1961.7031, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2416.6641, -1943.3281, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2425.0469, -2006.8438, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2425.0469, -1929.2031, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2513.6953, -1921.3594, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2527.9766, -1929.3984, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2702.9063, -2007.2969, 15.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2717.0703, -2015.6719, 15.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2711.1641, -1983.3828, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2725.4453, -1991.4297, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1852.5938, -1351.9844, 15.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1862.7188, -1340.1953, 15.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1976.1328, -1341.8125, 26.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1846.2422, -1329.1094, 15.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1987.8672, -1352.6172, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1999.0781, -1340.0625, 26.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2055.7188, -1341.5000, 26.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2066.1641, -1329.9688, 26.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2072.4531, -1351.8672, 26.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2072.4219, -1312.1641, 26.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2082.8906, -1300.2656, 26.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2066.3594, -1290.2578, 26.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2072.3984, -1271.7031, 26.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2066.2578, -1249.8047, 26.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1871.6563, -1147.4063, 26.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1878.4141, -1131.1016, 26.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1862.1094, -1123.4922, 26.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2055.3516, -1136.6875, 26.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2066.0781, -1124.8359, 25.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2058.2813, -1085.2969, 26.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2072.7422, -1146.7344, 26.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2072.5313, -1103.0938, 26.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2084.3359, -1095.1250, 27.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1962.6016, -1823.5234, 15.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1972.9922, -1811.4531, 15.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1960.6094, -1802.0078, 15.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1930.3750, -1753.1016, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1952.5156, -1751.3750, 15.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1940.9063, -1741.1484, 15.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1990.6094, -1752.8438, 15.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2013.2891, -1751.7656, 15.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2001.0391, -1740.8125, 15.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2001.9219, -1683.6172, 15.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2001.3594, -1665.5391, 15.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2013.0703, -1671.8672, 15.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2030.6875, -1612.9063, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2038.7266, -1601.0625, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2053.9297, -1611.4375, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1975.1328, -1466.7109, 15.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1986.2188, -1449.5000, 15.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1998.3438, -1460.2891, 15.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2155.6875, -1384.9219, 26.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2178.2422, -1383.9141, 26.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2166.2109, -1373.1094, 26.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2155.7813, -1301.6016, 25.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2167.8125, -1311.8203, 25.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2166.1250, -1289.6875, 25.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2178.0391, -1300.0156, 25.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2270.1797, -1373.1250, 26.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2282.3750, -1382.2734, 26.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2187.0625, -1120.8125, 26.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2190.4688, -1105.7188, 27.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2200.8203, -1127.6641, 27.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2225.6563, -1129.9297, 27.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2218.2656, -1112.5234, 27.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2070.2109, -1812.8828, 15.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2080.9375, -1800.9453, 15.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2082.2734, -1823.9141, 15.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2082.0313, -1683.6719, 15.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2070.3438, -1672.7344, 15.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2081.2109, -1660.9453, 15.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2082.2656, -1623.8828, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2070.1484, -1612.9219, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2083.8047, -1611.7500, 15.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2103.8359, -1612.7266, 15.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2092.9922, -1604.1563, 15.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2113.5703, -1477.6953, 26.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2100.9688, -1466.7188, 26.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 2111.7578, -1449.9922, 26.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2535.6406, -1738.6016, 15.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2520.0313, -1729.1875, 15.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2218.7891, -1760.0078, 15.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2221.9531, -1725.0156, 15.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2335.3203, -1726.4922, 15.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2347.9297, -1516.7969, 25.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2336.8203, -1491.3516, 26.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2407.5703, -1756.6406, 15.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2421.0703, -1738.6016, 15.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2423.7188, -1726.3516, 15.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2444.7109, -1729.4531, 15.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2295.9844, -1378.2813, 26.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2310.0547, -1376.9453, 26.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2349.8047, -1390.0469, 26.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2364.0859, -1378.8125, 26.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2308.9531, -1293.3281, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2360.6484, -1303.5938, 26.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 927.9766, -1768.5781, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1041.4844, -1800.2813, 12.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1029.6016, -1789.5469, 12.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1071.4063, -1847.0781, 12.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1139.7266, -1717.4609, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1160.5391, -1706.7734, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1144.7891, -1701.7109, 12.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1184.5938, -1577.5938, 12.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1286.6797, -1577.9297, 12.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1190.1719, -1561.8047, 12.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1206.2734, -1567.0781, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 1292.2578, -1562.1484, 12.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 639.4844, -1745.4063, 15.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 749.6328, -1753.6328, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 762.7422, -1760.2031, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 804.6641, -1759.1953, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 820.5859, -1763.8828, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1350, 912.0547, -1762.9297, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1043.0781, -1220.1406, 18.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1053.2344, -1231.1953, 18.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 796.5156, -1162.9922, 25.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 796.5156, -1130.3672, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 807.7031, -1139.5859, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1053.1641, -1159.7031, 25.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1045.6094, -1140.1641, 25.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1072.2578, -1140.1953, 25.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1083.3906, -1130.2734, 25.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1093.0703, -1140.2500, 25.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 952.3828, -963.7656, 41.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 961.7266, -984.2891, 40.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 972.4922, -971.8750, 41.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1072.7109, -948.5547, 44.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1085.1641, -969.2188, 44.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1140.8984, -1280.1172, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1161.5859, -1281.3594, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1182.6484, -1280.0781, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1150.5078, -1269.9375, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1244.0391, -1406.5313, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1194.7969, -1290.8516, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1216.3203, -1281.4141, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1216.8516, -1270.7656, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1245.7266, -1281.3359, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1171.6328, -1149.8828, 25.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1152.2734, -1140.1406, 25.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1168.2344, -1135.2500, 25.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1215.6719, -1159.8672, 25.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1226.8594, -1150.0469, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1206.4844, -1140.2969, 25.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1250.4531, -1389.7500, 15.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1270.8516, -1394.6797, 15.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1261.3594, -1291.1797, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1269.5469, -1280.3203, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1354.9063, -1291.3906, 15.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1332.0625, -1281.4609, 15.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1345.1641, -1269.2578, 16.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1275.8125, -1149.7734, 25.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1252.6094, -1140.2266, 25.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1096.9453, -957.1797, 44.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1263.2891, -1130.7578, 25.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1257.2188, -1033.2109, 34.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1257.1328, -1044.3281, 33.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1262.0469, -1049.7813, 33.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1273.0625, -1039.4688, 33.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1249.0078, -938.6875, 44.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1260.3906, -946.7266, 44.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1271.0469, -934.8516, 44.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 639.4844, -1745.4063, 15.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 611.7422, -1728.8438, 16.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 633.9609, -1720.7891, 16.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 73.8125, -1543.1250, 7.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 470.7813, -1307.2656, 17.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 485.2813, -1309.9766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 489.0469, -1293.0938, 17.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1284, 513.1406, -1260.3594, 18.1797, 0.25);

	//Los Santos and Countryside
    RemoveBuildingForPlayer(playerid, 956, 1634.1487,-2238.2810,13.5077, 20.0); //Snack vender @ LS Airport
	RemoveBuildingForPlayer(playerid, 956, 2480.9885,-1958.5117,13.5831, 20.0); //Snack vender @ Sushi Shop in Willowfield
	RemoveBuildingForPlayer(playerid, 955, 1729.7935,-1944.0087,13.5682, 20.0); //Sprunk machine @ Unity Station
	RemoveBuildingForPlayer(playerid, 955, 2060.1099,-1898.4543,13.5538, 20.0); //Sprunk machine opposite Tony's Liqour in Willowfield
	RemoveBuildingForPlayer(playerid, 955, 2325.8708,-1645.9584,14.8270, 20.0); //Sprunk machine @ Ten Green Bottles
	RemoveBuildingForPlayer(playerid, 955, 1153.9130,-1460.8893,15.7969, 20.0); //Sprunk machine @ Market
	RemoveBuildingForPlayer(playerid, 955,1788.3965,-1369.2336,15.7578, 20.0); //Sprunk machine in Downtown Los Santos
	RemoveBuildingForPlayer(playerid, 955, 2352.9939,-1357.1105,24.3984, 20.0); //Sprunk machine @ Liquour shop in East Los Santos
	RemoveBuildingForPlayer(playerid, 1775, 2224.3235,-1153.0692,1025.7969, 20.0); //Sprunk machine @ Jefferson Motel
	RemoveBuildingForPlayer(playerid, 956, 2140.2566,-1161.7568,23.9922, 20.0); //Snack machine @ pick'n'go market in Jefferson
	RemoveBuildingForPlayer(playerid, 956, 2154.1199,-1015.7635,62.8840, 20.0); //Snach machine @ Carniceria El Pueblo in Las Colinas
	RemoveBuildingForPlayer(playerid, 956, 662.5665,-551.4142,16.3359, 20.0); //Snack vender at Dillimore Gas Station
	RemoveBuildingForPlayer(playerid, 955, 200.2010,-107.6401,1.5513, 20.0); //Sprunk machine @ Blueberry Safe House
	RemoveBuildingForPlayer(playerid, 956, 2271.4666,-77.2104,26.5824, 20.0); //Snack machine @ Palomino Creek Library
	RemoveBuildingForPlayer(playerid, 955, 1278.5421,372.1057,19.5547, 20.0); //Sprunk machine @ Papercuts in Montgomery
	RemoveBuildingForPlayer(playerid, 955, 1929.5527,-1772.3136,13.5469, 20.0); //Sprunk machine @ Idlewood Gas Station

	//San Fierro
	RemoveBuildingForPlayer(playerid, 1302, -2419.5835,984.4185,45.2969, 20.0); //Soda machine 1 @ Juniper Hollow Gas Station
	RemoveBuildingForPlayer(playerid, 1209, -2419.5835,984.4185,45.2969, 20.0); //Soda machine 2 @ Juniper Hollow Gas Station
	RemoveBuildingForPlayer(playerid, 956, -2229.2075,287.2937,35.3203, 20.0); //Snack vender @ King's Car Park
	RemoveBuildingForPlayer(playerid, 955, -1349.3947,493.1277,11.1953, 20.0); //Sprunk machine @ SF Aircraft Carrier
	RemoveBuildingForPlayer(playerid, 956, -1349.3947,493.1277,11.1953, 20.0); //Snack vender @ SF Aircraft Carrier
	RemoveBuildingForPlayer(playerid, 955, -1981.6029,142.7232,27.6875, 20.0); //Sprunk machine @ Cranberry Station
	RemoveBuildingForPlayer(playerid, 955, -2119.6245,-422.9411,35.5313, 20.0); //Sprunk machine 1/2 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2097.3696,-397.5220,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2068.5593,-397.5223,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2039.8802,-397.5214,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2011.1403,-397.5225,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2005.7861,-490.8688,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2034.5267,-490.8681,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2063.1875,-490.8687,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2091.9780,-490.8684,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium

	//Las Venturas
	RemoveBuildingForPlayer(playerid, 956, -1455.1298,2592.4138,55.8359, 20.0); //Snack vender @ El Quebrados GONE
	RemoveBuildingForPlayer(playerid, 955, -252.9574,2598.9048,62.8582, 20.0); //Sprunk machine @ Las Payasadas GONE
	RemoveBuildingForPlayer(playerid, 956, -252.9574,2598.9048,62.8582, 20.0); //Snack vender @ Las Payasadas GONE
	RemoveBuildingForPlayer(playerid, 956, 1398.7617,2223.3606,11.0234, 20.0); //Snack vender @ Redsands West GONE
	RemoveBuildingForPlayer(playerid, 955, -862.9229,1537.4246,22.5870, 20.0); //Sprunk machine @ The Smokin' Beef Grill in Las Barrancas GONE
	RemoveBuildingForPlayer(playerid, 955, -14.6146,1176.1738,19.5634, 20.0); //Sprunk machine @ Fort Carson GONE
	RemoveBuildingForPlayer(playerid, 956, -75.2839,1227.5978,19.7360, 20.0); //Snack vender @ Fort Carson GONE
	RemoveBuildingForPlayer(playerid, 955, 1519.3328,1055.2075,10.8203, 20.0); //Sprunk machine @ LVA Freight Department GONE
	RemoveBuildingForPlayer(playerid, 956, 1659.5096,1722.1096,10.8281, 20.0); //Snack vender near Binco @ LV Airport GONE
	RemoveBuildingForPlayer(playerid, 955, 2086.5872,2071.4958,11.0579, 20.0); //Sprunk machine @ Sex Shop on The Strip
	RemoveBuildingForPlayer(playerid, 955, 2319.9001,2532.0376,10.8203, 20.0); //Sprunk machine @ Pizza co by Julius Thruway (North)
	RemoveBuildingForPlayer(playerid, 955, 2503.2061,1244.5095,10.8203, 20.0); //Sprunk machine @ Club in the Camels Toe
	RemoveBuildingForPlayer(playerid, 956, 2845.9919,1294.2975,11.3906, 20.0); //Snack vender @ Linden Station

	//Interiors: 24/7 and Clubs
	RemoveBuildingForPlayer(playerid, 1775, 496.0843,-23.5310,1000.6797, 20.0); //Sprunk machine 1 @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1775, 501.1219,-2.1968,1000.6797, 20.0); //Sprunk machine 2 @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1776, 501.1219,-2.1968,1000.6797, 20.0); //Snack vender @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1775, -19.2299,-57.0460,1003.5469, 20.0); //Sprunk machine @ Roboi's type 24/7 stores
	RemoveBuildingForPlayer(playerid, 1776, -35.9012,-57.1345,1003.5469, 20.0); //Snack vender @ Roboi's type 24/7 stores
	RemoveBuildingForPlayer(playerid, 1775, -17.0036,-90.9709,1003.5469, 20.0); //Sprunk machine @ Other 24/7 stores
	RemoveBuildingForPlayer(playerid, 1776, -17.0036,-90.9709,1003.5469, 20.0); //Snach vender @ Others 24/7 stores

	//PPMC HQ garaza
	RemoveBuildingForPlayer(playerid, 1412, 215.0000, -224.0000, 2.0234, 0.25);

	// SR GaraZa
	RemoveBuildingForPlayer(playerid, 1265, 1539.2344, -1481.0781, 8.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1265, 1536.5078, -1481.0938, 8.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1372, 1534.9297, -1480.9922, 8.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1265, 1537.2422, -1479.7422, 8.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1372, 1537.9297, -1480.6094, 8.6094, 0.25);

    // Lovacka kuca
    RemoveBuildingForPlayer(playerid, 785, 695.820, -350.156, 5.390, 0.250);
    RemoveBuildingForPlayer(playerid, 785, 637.640, -328.687, 10.320, 0.250);
    RemoveBuildingForPlayer(playerid, 672, -35.710, 18.101, 3.476, 0.250);
    RemoveBuildingForPlayer(playerid, 790, 648.171, -371.000, 23.414, 0.250);
    RemoveBuildingForPlayer(playerid, 791, 695.820, -350.156, 5.390, 0.250);
    RemoveBuildingForPlayer(playerid, 698, 743.195, -366.890, 12.531, 0.250);
    RemoveBuildingForPlayer(playerid, 791, 637.640, -328.687, 10.320, 0.250);
    RemoveBuildingForPlayer(playerid, 698, 727.765, -319.851, 11.625, 0.250);
    RemoveBuildingForPlayer(playerid, 694, 683.101, -314.289, 12.093, 0.250);
    RemoveBuildingForPlayer(playerid, 785, -504.062, -2123.531, 80.625, 0.250);
    RemoveBuildingForPlayer(playerid, 791, -504.062, -2123.531, 80.625, 0.250);

	//4Smokva
	RemoveBuildingForPlayer(playerid, 17063, -390.2109, -1149.8047, 68.2031, 0.25);
    RemoveBuildingForPlayer(playerid, 3246, -378.8906, -1040.8828, 57.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 3425, -365.8750, -1060.8359, 69.2891, 0.25);
    RemoveBuildingForPlayer(playerid, 3250, -348.6719, -1041.9609, 58.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 3276, -340.6641, -1065.2031, 59.1875, 0.25);

	//acces lampposts
	RemoveBuildingForPlayer(playerid, 5464, 1902.4297, -1309.5391, 29.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 1842.1328, -1431.5859, 15.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2470.4688, -1674.1875, 16.3359, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2456.3672, -1662.8828, 16.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2415.8203, -1662.8828, 16.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 1092.4141, -1846.7734, 15.9297, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 792.3438, -977.1563, 39.1250, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 799.4922, -962.4453, 41.1953, 0.25);
    RemoveBuildingForPlayer(playerid, 1266, 799.1797, -917.3594, 54.9375, 0.25);
    RemoveBuildingForPlayer(playerid, 13890, 790.1328, -963.3281, 59.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 786.0938, -945.0078, 45.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 800.3203, -932.6016, 45.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1260, 799.1797, -917.3594, 54.9375, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1147.7422, -791.6016, 59.6563, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1167.2578, -753.5547, 63.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1244.1953, 84.0078, 25.2422, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 185.7969, -138.8359, 5.0313, 0.25);
    RemoveBuildingForPlayer(playerid, 1351, 143.1953, -136.0938, 0.4609, 0.25);

    // painttball
    RemoveBuildingForPlayer(playerid, 13563, 914.5156, -60.5469, 51.8359, 0.25);
    RemoveBuildingForPlayer(playerid, 698, 865.8203, -39.5938, 62.4922, 0.25);

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_YES)) // Tipka Y
	{
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, 2163.574462, -2158.066650, 13.286876)) {
			if(rampastatus == 0) {
    			SetDynamicObjectRot(rampa, 0.0000, 0.0000, 0.0000);
				rampastatus = 1;
			}
			else if(rampastatus == 1) {
    			SetDynamicObjectRot(rampa,0.00000000,270.00000,-134.399902);
				rampastatus = 0;
			}
		}
		//Harbor PD
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2840.729003, -853.287231, -22.709405)) {
			if(eastStationDStatus[0] == 0) {
				SetDynamicObjectRot(eastStationDoor[0], 0, 0, -90);
				eastStationDStatus[0] = 1;
			}
			else if(eastStationDStatus[0] == 1) {
				SetDynamicObjectRot(eastStationDoor[0], 0, 0, 0);
				eastStationDStatus[0] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2840.348632, -843.507019, -22.709405)) {
			if(eastStationDStatus[1] == 0) {
				SetDynamicObjectRot(eastStationDoor[1], 0, 0, -90);
				eastStationDStatus[1] = 1;
			}
			else if(eastStationDStatus[1] == 1) {
				SetDynamicObjectRot(eastStationDoor[1], 0, 0, 0);
				eastStationDStatus[1] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2846.740234, -843.507019, -22.709405)) {
			if(eastStationDStatus[2] == 0) {
				SetDynamicObjectRot(eastStationDoor[2], 0, 0, -90);
				eastStationDStatus[2] = 1;
			}
			else if(eastStationDStatus[2] == 1) {
				SetDynamicObjectRot(eastStationDoor[2], 0, 0, 0);
				eastStationDStatus[2] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2857.778564, -851.530944, -21.609405)) {
			if(eastStationDStatus[3] == 0) {
				SetDynamicObjectRot(eastStationDoor[3], 0, 0, -90);
				eastStationDStatus[3] = 1;
			}
			else if(eastStationDStatus[3] == 1) {
				SetDynamicObjectRot(eastStationDoor[3], 0, 0, -180);
				eastStationDStatus[3] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2864.160644, -845.110900, -21.609405)) {
			if(eastStationDStatus[4] == 0) {
				SetDynamicObjectRot(eastStationDoor[4], 0, 0, -90);
				eastStationDStatus[4] = 1;
			}
			else if(eastStationDStatus[4] == 1) {
				SetDynamicObjectRot(eastStationDoor[4], 0, 0, -180);
				eastStationDStatus[4] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2855.417724, -855.451354, -21.609405)) {
			if(eastStationDStatus[5] == 0) {
				SetDynamicObjectRot(eastStationDoor[5], 0, 0, -90);
				eastStationDStatus[5] = 1;
			}
			else if(eastStationDStatus[5] == 1) {
				SetDynamicObjectRot(eastStationDoor[5], 0, 0, 0);
				eastStationDStatus[5] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2852.416503, -854.191589, -21.609405)) {
			if(eastStationDStatus[6] == 0) {
				SetDynamicObjectRot(eastStationDoor[6], 0, 0, -90);
				eastStationDStatus[6] = 1;
			}
			else if(eastStationDStatus[6] == 1) {
				SetDynamicObjectRot(eastStationDoor[6], 0, 0, 0);
				eastStationDStatus[6] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2852.416503, -844.611267, -21.609405)) {
			if(eastStationDStatus[7] == 0) {
				SetDynamicObjectRot(eastStationDoor[7], 0, 0, -90);
				eastStationDStatus[7] = 1;
			}
			else if(eastStationDStatus[7] == 1) {
				SetDynamicObjectRot(eastStationDoor[7], 0, 0, 0);
				eastStationDStatus[7] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2857.998779, -839.790771, -21.609405)) {
			if(eastStationDStatus[8] == 0) {
				SetDynamicObjectRot(eastStationDoor[8], 0, 0, -90);
				eastStationDStatus[8] = 1;
			}
			else if(eastStationDStatus[8] == 1) {
				SetDynamicObjectRot(eastStationDoor[8], 0, 0, -180);
				eastStationDStatus[8] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2874.582519, -842.920532, -21.609405)) {
			if(eastStationDStatus[9] == 0) {
				SetDynamicObjectRot(eastStationDoor[9], 0, 0, 180);
				eastStationDStatus[9] = 1;
			}
			else if(eastStationDStatus[9] == 1) {
				SetDynamicObjectRot(eastStationDoor[9], 0, 0, 90);
				eastStationDStatus[9] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2874.582519, -836.530212, -21.609405)) {
			if(eastStationDStatus[10] == 0) {
				SetDynamicObjectRot(eastStationDoor[10], 0, 0, 180);
				eastStationDStatus[10] = 1;
			}
			else if(eastStationDStatus[10] == 1) {
				SetDynamicObjectRot(eastStationDoor[10], 0, 0, 90);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2868.307373, -854.201354, -21.609405)) {
			if(eastStationDStatus[11] == 0) {
				SetDynamicObjectRot(eastStationDoor[11], 0, 0, -90);
				eastStationDStatus[11] = 1;
			}
			else if(eastStationDStatus[11] == 1) {
				SetDynamicObjectRot(eastStationDoor[11], 0, 0, 0);
				eastStationDStatus[11] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2857.778564, -845.100036, -21.609405)) {
			if(eastStationDStatus[12] == 0) {
				SetDynamicObjectRot(eastStationDoor[12], 0, 0, -90);
				eastStationDStatus[12] = 1;
			}
			else if(eastStationDStatus[12] == 1) {
				SetDynamicObjectRot(eastStationDoor[12], 0, 0, -180);
				eastStationDStatus[12] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2867.388671, -851.470153, -21.609405)) {
			if(eastStationDStatus[13] == 0) {
				SetDynamicObjectRot(eastStationDoor[13], 0, 0, -90);
				eastStationDStatus[13] = 1;
			}
			else if(eastStationDStatus[13] == 1) {
				SetDynamicObjectRot(eastStationDoor[13], 0, 0, -180);
				eastStationDStatus[13] = 0;
			}
		}
		
		
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2879.107177, -838.282592, -22.719406)) {
			if(eastStationDStatus[14] == 0) {
				SetDynamicObjectRot(eastStationDoor[14], 0, 0, -90);
				eastStationDStatus[14] = 1;
			}
			else if(eastStationDStatus[14] == 1) {
				SetDynamicObjectRot(eastStationDoor[14], 0, 0, 0);
				eastStationDStatus[14] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2879.107177, -832.352050, -22.719406)) {
			if(eastStationDStatus[15] == 0) {
				SetDynamicObjectRot(eastStationDoor[15], 0, 0, -90);
				eastStationDStatus[15] = 1;
			}
			else if(eastStationDStatus[15] == 1) {
				SetDynamicObjectRot(eastStationDoor[15], 0, 0, 0);
				eastStationDStatus[15] = 0;
			}
		}
		//======================== [LSSD] =========================
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1443.576904, 1097.991088, -24.349899)) {
			if(sddoors1 == 0) {
				SetDynamicObjectRot(PDlobby[0], 0, 0, -90);
				sddoors1 = 1;
			}
			else if(sddoors1 == 1) {
				SetDynamicObjectRot(PDlobby[0], 0, 0, 0);
				sddoors1 = 0;
			}
		}
		//DAUT
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 779.22381, 1447.56530, 1471.46484)) {
			if(dautStatus == 0) {
				SetDynamicObjectRot(daut, 0, 0, 90);
				dautStatus = 1;
			}
			else if(dautStatus == 1) {
				SetDynamicObjectRot(daut, 0, 0, 180);
				dautStatus = 0;
			}
		}
		//bank
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1411.693603, -14.584956, 1001.244140)) {
			if(bankdoorStatus == 0) {
				SetDynamicObjectRot(bank_door, 0, 0, -90);
				bankdoorStatus = 1;
			}
			else if(bankdoorStatus == 1) {
				SetDynamicObjectRot(bank_door, 0, 0, -180);
				bankdoorStatus = 0;
			}
		}//sd neki kurac
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1322.375244, 1097.773803, -20.010866)) {
			if(sddoors2 == 0) {
				SetDynamicObjectRot(PDlobby[1], 0, 0, -90);
				sddoors2 = 1;
			}
			else if(sddoors2 == 1) {
				SetDynamicObjectRot(PDlobby[1], 0, 0, 180);
				sddoors2 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1309.093505, 1104.799560, -20.010866)) {
			if(sddoors3 == 0) {
				SetDynamicObjectRot(PDlobby[2], 0, 0, 90);
				sddoors3 = 1;
			}
			else if(sddoors3 == 1) {
				SetDynamicObjectRot(PDlobby[2], 0, 0, 0);
				sddoors3 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1335.818115, 1101.890380, -21.325223)) {
			if(sddoors4 == 0) {
				SetDynamicObjectRot(PDlobby[3], 0, 0, 90);
				sddoors4 = 1;
			}
			else if(sddoors4 == 1) {
				SetDynamicObjectRot(PDlobby[3], 0, 0, 0);
				sddoors4 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1948.360351, 773.064453, -6.772177)) { //CELL 1
			if(hroom1 == 0) {
				MoveDynamicObject(Hcell[0],1948.360351-1.6, 773.064453, -6.772177, 6.0);
				hroom1 = 1;
			}
			else if(hroom1 == 1) {
				MoveDynamicObject(Hcell[0],1948.360351, 773.064453, -6.772177, 6.0);
				hroom1 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1953.041870, 773.064453, -6.772177)) { //CELL 2
			if(hroom2 == 0) {
				MoveDynamicObject(Hcell[1],1953.041870-1.6, 773.064453, -6.772177, 6.0);
				hroom2 = 1;
			}
			else if(hroom2== 1) {
				MoveDynamicObject(Hcell[1],1953.041870, 773.064453, -6.772177, 6.0);
				hroom2 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1439.514770, 1101.999023, -24.288499)) { //CELL 3
			if(hroom3 == 0) {
				MoveDynamicObject(Hcell[2],1439.514770-1.6, 1101.999023, -24.288499, 6.0);
				hroom3 = 1;
			}
			else if(hroom3 == 1) {
				MoveDynamicObject(Hcell[2],1439.514770, 1101.999023, -24.288499, 6.0);
				hroom3 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1435.624755, 1101.999023, -24.288499)) { //CELL 4
			if(hroom4 == 0) {
				MoveDynamicObject(Hcell[3],1435.624755-1.6, 1101.999023, -24.288499, 6.0);
				hroom4 = 1;
			}
			else if(hroom4 == 1) {
				MoveDynamicObject(Hcell[3],1435.624755, 1101.999023, -24.288499, 6.0);
				hroom4 = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -2118.088, -2356.281, 630.599)) {
			if(officesdoor1 == 0) {
				SetDynamicObjectRot(security1, 0, 0, 180);
				officesdoor1 = 1;
			}
			else if(officesdoor1 == 1) {
				SetDynamicObjectRot(security1, 0, 0,90);
				officesdoor1 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2115.001,-2359.554,630.600)) {
			if(officesdoor2 == 0) {
				SetDynamicObjectRot(security2, 0, 0, -180);
				officesdoor2 = 1;
			}
			else if(officesdoor2 == 1) {
				SetDynamicObjectRot(security2, 0, 0, -90);
				officesdoor2 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2115.061,-2366.048,630.637)) {
			if(officesdoor3 == 0) {
				SetDynamicObjectRot(security3, 0, 0, -180);
				officesdoor3 = 1;
			}
			else if(officesdoor3 == 1) {
				SetDynamicObjectRot(security3, 0, 0, -90);
				officesdoor3 = 0;
            }

		}
		//DOJ VRATA
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1412.719604, -22.985584, 1095.300292)) {
			if(dojdoorsStatus[0] == 0) {
				SetDynamicObjectRot(dojdoors[0], 0, 0, 90);
				dojdoorsStatus[0] = 1;
			}
			else if(dojdoorsStatus[0] == 1) {
				SetDynamicObjectRot(dojdoors[0], 0, 0, 0);
				dojdoorsStatus[0] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1409.718139, -22.985584, 1095.300292)) {
			if(dojdoorsStatus[1] == 0) {
				SetDynamicObjectRot(dojdoors[1], 0, 0, 90);
				dojdoorsStatus[1] = 1;
			}
			else if(dojdoorsStatus[1] == 1) {
				SetDynamicObjectRot(dojdoors[1], 0, 0, 0);
				dojdoorsStatus[1] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1411.948852, -22.965583, 1099.682006)) {
			if(dojdoorsStatus[1] == 0) {
				SetDynamicObjectRot(dojdoors[1], 0, 0, 90);
				dojdoorsStatus[1] = 1;
			}
			else if(dojdoorsStatus[1] == 1) {
				SetDynamicObjectRot(dojdoors[1], 0, 0, 0);
				dojdoorsStatus[1] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1410.447509, -4.445575, 1099.682006)) {
			if(dojdoorsStatus[2] == 0) {
				SetDynamicObjectRot(dojdoors[2], 0, 0, 90);
				dojdoorsStatus[2] = 1;
			}
			else if(dojdoorsStatus[2] == 1) {
				SetDynamicObjectRot(dojdoors[2], 0, 0, 0);
				dojdoorsStatus[2] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1415.888061, -3.485574, 1099.682006)) {
			if(dojdoorsStatus[3] == 0) {
				SetDynamicObjectRot(dojdoors[3], 0, 0, 90);
				dojdoorsStatus[3] = 1;
			}
			else if(dojdoorsStatus[3] == 1) {
				SetDynamicObjectRot(dojdoors[3], 0, 0, 0);
				dojdoorsStatus[3] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1398.275634, -4.395574, 1099.682006)) {
			if(dojdoorsStatus[4] == 0) {
				SetDynamicObjectRot(dojdoors[4], 0, 0, 90);
				dojdoorsStatus[4] = 1;
			}
			else if(dojdoorsStatus[4] == 1) {
				SetDynamicObjectRot(dojdoors[4], 0, 0, 0);
				dojdoorsStatus[4] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1384.754394, -4.465575, 1099.682006)) {
			if(dojdoorsStatus[5] == 0) {
				SetDynamicObjectRot(dojdoors[5], 0, 0, 90);
				dojdoorsStatus[5] = 1;
			}
			else if(dojdoorsStatus[5] == 1) {
				SetDynamicObjectRot(dojdoors[5], 0, 0, 0);
				dojdoorsStatus[5] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1387.746093, -4.465575, 1099.682006)) {
			if(dojdoorsStatus[6] == 0) {
				SetDynamicObjectRot(dojdoors[6], 0, 0, 90);
				dojdoorsStatus[6] = 1;
			}
			else if(dojdoorsStatus[6] == 1) {
				SetDynamicObjectRot(dojdoors[6], 0, 0, 0);
				dojdoorsStatus[6] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1392.026977, 14.604436, 1099.682006)) {
			if(dojdoorsStatus[7] == 0) {
				SetDynamicObjectRot(dojdoors[7], 0, 0, 90);
				dojdoorsStatus[7] = 1;
			}
			else if(dojdoorsStatus[7] == 1) {
				SetDynamicObjectRot(dojdoors[7], 0, 0, 0);
				dojdoorsStatus[7] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1380.236938, 14.604436, 1099.682006)) {
			if(dojdoorsStatus[8] == 0) {
				SetDynamicObjectRot(dojdoors[8], 0, 0, 90);
				dojdoorsStatus[8] = 1;
			}
			else if(dojdoorsStatus[8] == 1) {
				SetDynamicObjectRot(dojdoors[8], 0, 0, 0);
				dojdoorsStatus[8] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1378.347534, 8.264427, 1099.682006)) {
			if(dojdoorsStatus[9] == 0) {
				SetDynamicObjectRot(dojdoors[9], 0, 0, 90);
				dojdoorsStatus[9] = 1;
			}
			else if(dojdoorsStatus[9] == 1) {
				SetDynamicObjectRot(dojdoors[9], 0, 0, 0);
				dojdoorsStatus[9] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1386.248657, 17.904453, 1099.682006)) {
			if(dojdoorsStatus[10] == 0) {
				SetDynamicObjectRot(dojdoors[10], 0, 0, 90);
				dojdoorsStatus[10] = 1;
			}
			else if(dojdoorsStatus[10] == 1) {
				SetDynamicObjectRot(dojdoors[10], 0, 0, 0);
				dojdoorsStatus[10] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1399.800048, 17.904453, 1099.682006)) {
			if(dojdoorsStatus[11] == 0) {
				SetDynamicObjectRot(dojdoors[11], 0, 0, 90);
				dojdoorsStatus[11] = 1;
			}
			else if(dojdoorsStatus[11] == 1) {
				SetDynamicObjectRot(dojdoors[1], 0, 0, 0);
				dojdoorsStatus[11] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1400.840087, 8.304452, 1099.682006)) {
			if(dojdoorsStatus[12] == 0) {
				SetDynamicObjectRot(dojdoors[12], 0, 0, 90);
				dojdoorsStatus[12] = 1;
			}
			else if(dojdoorsStatus[12] == 1) {
				SetDynamicObjectRot(dojdoors[12], 0, 0, 0);
				dojdoorsStatus[12] = 0;
            }

		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1400.840087, 6.594449, 1099.682006)) {
			if(dojdoorsStatus[13] == 0) {
				SetDynamicObjectRot(dojdoors[13], 0, 0, 90);
				dojdoorsStatus[13] = 1;
			}
			else if(dojdoorsStatus[13] == 1) {
				SetDynamicObjectRot(dojdoors[13], 0, 0, 0);
				dojdoorsStatus[13] = 0;
            }

		}
		//LSFD Interior
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1072.102783, -1770.428833, -36.932189)) {
			if(FdIntDoorStatus[0] == 0) {
				SetDynamicObjectRot(FdIntDoor[0], 0, 0, 180);
				FdIntDoorStatus[0] = 1;
			}
			else if(FdIntDoorStatus[0] == 1) {
				SetDynamicObjectRot(FdIntDoor[0], 0, 0, 90);
				FdIntDoorStatus[0] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1072.102783, -1773.619262, -36.932189)) {
			if(FdIntDoorStatus[1] == 0) {
				SetDynamicObjectRot(FdIntDoor[1], 0, 0, 180);
				FdIntDoorStatus[1] = 1;
			}
			else if(FdIntDoorStatus[1] == 1) {
				SetDynamicObjectRot(FdIntDoor[1], 0, 0, 90);
				FdIntDoorStatus[1] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1075.632812, -1774.569824, -36.932189)) {
			if(FdIntDoorStatus[2] == 0) {
				SetDynamicObjectRot(FdIntDoor[2], 0, 0, 180);
				FdIntDoorStatus[2] = 1;
			}
			else if(FdIntDoorStatus[2] == 1) {
				SetDynamicObjectRot(FdIntDoor[2], 0, 0, 90);
				FdIntDoorStatus[2] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1078.192871, -1768.929809, -36.912193)) {
			if(FdIntDoorStatus[3] == 0) {
				SetDynamicObjectRot(FdIntDoor[3], 0, 0, -90);
				FdIntDoorStatus[3] = 1;
			}
			else if(FdIntDoorStatus[3] == 1) {
				SetDynamicObjectRot(FdIntDoor[3], 0, 0, 0);
				FdIntDoorStatus[3] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1078.170288, -1783.308227, -38.242198)) {
			if(FdIntDoorStatus[4] == 0) {
				SetDynamicObjectRot(FdIntDoor[4], 0, 0, 180);
				FdIntDoorStatus[4] = 1;
			}
			else if(FdIntDoorStatus[4] == 1) {
				SetDynamicObjectRot(FdIntDoor[4], 0, 0, 90);
				FdIntDoorStatus[4] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1077.270385, -1784.148925, -38.242198)) {
			if(FdIntDoorStatus[5] == 0) {
				SetDynamicObjectRot(FdIntDoor[5], 0, 0, 180);
				FdIntDoorStatus[5] = 1;
			}
			else if(FdIntDoorStatus[5] == 1) {
				SetDynamicObjectRot(FdIntDoor[5], 0, 0, 90);
				FdIntDoorStatus[5] = 0;
			}
		}
		//LSPD HOOVER INT
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2096.445312, -2127.584228, -45.286499)) {
			if(pdHovDoorStatus[0] == 0) {
				SetDynamicObjectRot(pdHovDoor[0], 0, 0, -90);
				pdHovDoorStatus[0] = 1;
			}
			else if(pdHovDoorStatus[0] == 1) {
				SetDynamicObjectRot(pdHovDoor[0], 0, 0, 0);
				pdHovDoorStatus[0] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2102.835937, -2127.584228, -45.276504)) {
			if(pdHovDoorStatus[1] == 0) {
				SetDynamicObjectRot(pdHovDoor[1], 0, 0, -90);
				pdHovDoorStatus[1] = 1;
			}
			else if(pdHovDoorStatus[1] == 1) {
				SetDynamicObjectRot(pdHovDoor[1], 0, 0, 0);
				pdHovDoorStatus[1] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2098.865722, -2133.225341, -45.236507)) {
			if(pdHovDoorStatus[2] == 0) {
				SetDynamicObjectRot(pdHovDoor[2], 0, 0, -90);
				pdHovDoorStatus[2] = 1;
			}
			else if(pdHovDoorStatus[2] == 1) {
				SetDynamicObjectRot(pdHovDoor[2], 0, 0, 0);
				pdHovDoorStatus[2] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2103.714599, -2129.521728, -41.676513)) {
			if(pdHovDoorStatus[3] == 0) {
				SetDynamicObjectRot(pdHovDoor[3], 0, 0, -90);
				pdHovDoorStatus[3] = 1;
			}
			else if(pdHovDoorStatus[3] == 1) {
				SetDynamicObjectRot(pdHovDoor[3], 0, 0, 0);
				pdHovDoorStatus[3] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2097.364257, -2129.521728, -41.676513)) {
			if(pdHovDoorStatus[4] == 0) {
				SetDynamicObjectRot(pdHovDoor[4], 0, 0, -90);
				pdHovDoorStatus[4] = 1;
			}
			else if(pdHovDoorStatus[4] == 1) {
				SetDynamicObjectRot(pdHovDoor[4], 0, 0, 0);
				pdHovDoorStatus[4] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2098.265136, -2150.105468, -45.236507)) {
			if(pdHovDoorStatus[5] == 0) {
				SetDynamicObjectRot(pdHovDoor[5], 0, 0, -90);
				pdHovDoorStatus[5] = 1;
			}
			else if(pdHovDoorStatus[5] == 1) {
				SetDynamicObjectRot(pdHovDoor[5], 0, 0, 0);
				pdHovDoorStatus[5] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2103.025390, -2150.105468, -45.236507)) {
			if(pdHovDoorStatus[6] == 0) {
				SetDynamicObjectRot(pdHovDoor[6], 0, 0, -90);
				pdHovDoorStatus[6] = 1;
			}
			else if(pdHovDoorStatus[6] == 1) {
				SetDynamicObjectRot(pdHovDoor[6], 0, 0, 0);
				pdHovDoorStatus[6] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2110.802734, -2142.743164, -45.156505)) {
			if(pdHovDoorStatus[7] == 0) {
				SetDynamicObjectRot(pdHovDoor[7], 0, 0, -90);
				pdHovDoorStatus[7] = 1;
			}
			else if(pdHovDoorStatus[7] == 1) {
				SetDynamicObjectRot(pdHovDoor[7], 0, 0, 0);
				pdHovDoorStatus[7] = 0;
			}
		}
		//*******************************************PD Main HQ - Lobby VRATA********************************************
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1549.899414, -1669.359741, -19.673757)) {
			if(pdDoorsStatus1 == 0) {
				SetDynamicObjectRot(pdIntDoors1, 0, 0, -90);
				pdDoorsStatus1 = 1;
			}
			else if(pdDoorsStatus1 == 1) {
				SetDynamicObjectRot(pdIntDoors1, 0, 0, 0);
				pdDoorsStatus1 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1555.932128, -1669.289672, -19.673757)) {
			if(pdDoorsStatus2 == 0) {
				SetDynamicObjectRot(pdIntDoors2, 0, 0, -90);
				pdDoorsStatus2 = 1;
			}
			else if(pdDoorsStatus2 == 1) {
				SetDynamicObjectRot(pdIntDoors2, 0, 0, 0);
				pdDoorsStatus2 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1549.899414, -1687.001342, -19.673757)) {
			if(pdDoorsStatus3 == 0) {
				SetDynamicObjectRot(pdIntDoors3, 0, 0, -90);
				pdDoorsStatus3 = 1;
			}
			else if(pdDoorsStatus3 == 1) {
				SetDynamicObjectRot(pdIntDoors3, 0, 0, 0);
				pdDoorsStatus3 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1555.929199, -1683.443237, -19.673757)) {
			if(pdDoorsStatus4 == 0) {
				SetDynamicObjectRot(pdIntDoors4, 0, 0, -90);
				pdDoorsStatus4 = 1;
			}
			else if(pdDoorsStatus4 == 1) {
				SetDynamicObjectRot(pdIntDoors4, 0, 0, 0);
				pdDoorsStatus4 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1555.929199, -1673.981079, -19.673757)) {
			if(pdDoorsStatus5 == 0) {
				SetDynamicObjectRot(pdIntDoors5, 0.0000, 0.1000, -90);
				pdDoorsStatus5 = 1;
			}
			else if(pdDoorsStatus5 == 1) {
				SetDynamicObjectRot(pdIntDoors5, 0.0000, 0.1000, 0);
				pdDoorsStatus5 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1547.627929, -1664.209228, -16.063747)) {
			if(pdDoorsStatus6 == 0) {
				SetDynamicObjectRot(pdIntDoors6, 0.0000, 0.0000, -90);
				pdDoorsStatus6 = 1;
			}
			else if(pdDoorsStatus6 == 1) {
				SetDynamicObjectRot(pdIntDoors6, 0.0000, 0.0000, 0);
				pdDoorsStatus6 = 0;
			}
		}
		//PD MAIN HQ - ROLLCALL
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1899.520385, 1324.749267, -16.577264)) {
			if(rollcallStatus[0] == 0) {
				SetDynamicObjectRot(rollcall[0], 0, 0, 0);
				rollcallStatus[0] = 1;
			}
			else if(rollcallStatus[0] == 1) {
				SetDynamicObjectRot(rollcall[0], 0, 0, 90);
				rollcallStatus[0] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1902.511352, 1324.758789, -16.577264)) {
			if(rollcallStatus[1] == 0) {
				SetDynamicObjectRot(rollcall[1], 0, 0, 0);
				rollcallStatus[1] = 1;
			}
			else if(rollcallStatus[1] == 1) {
				SetDynamicObjectRot(rollcall[1], 0, 0, 90);
				rollcallStatus[1] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1899.520385, 1351.920043, -16.577264)) {
			if(rollcallStatus[2] == 0) {
				SetDynamicObjectRot(rollcall[2], 0, 0, 0);
				rollcallStatus[2] = 1;
			}
			else if(rollcallStatus[2] == 1) {
				SetDynamicObjectRot(rollcall[2], 0, 0, 90);
				rollcallStatus[2] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1902.463867, 1351.918823, -16.577264)) {
			if(rollcallStatus[3] == 0) {
				SetDynamicObjectRot(rollcall[3], 0, 0, 0);
				rollcallStatus[3] = 1;
			}
			else if(rollcallStatus[3] == 1) {
				SetDynamicObjectRot(rollcall[3], 0, 0, 90);
				rollcallStatus[3] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1904.413208, 1327.033325, -16.577264)) {
			if(rollcallStatus[4] == 0) {
				SetDynamicObjectRot(rollcall[4], 0, 0, 0);
				rollcallStatus[4] = 1;
			}
			else if(rollcallStatus[4] == 1) {
				SetDynamicObjectRot(rollcall[4], 0, 0, 90);
				rollcallStatus[4] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1904.430297, 1344.963378, -16.577264)) {
			if(rollcallStatus[5] == 0) {
				SetDynamicObjectRot(rollcall[5], 0, 0, 0);
				rollcallStatus[5] = 1;
			}
			else if(rollcallStatus[5] == 1) {
				SetDynamicObjectRot(rollcall[5], 0, 0, 90);
				rollcallStatus[5] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1897.627319, 1345.590087, -16.577264)) {
			if(rollcallStatus[6] == 0) {
				SetDynamicObjectRot(rollcall[6], 0, 0, 0);
				rollcallStatus[6] = 1;
			}
			else if(rollcallStatus[6] == 1) {
				SetDynamicObjectRot(rollcall[6], 0, 0, 90);
				rollcallStatus[6] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1897.633422, 1335.219604, -16.577264)) {
			if(rollcallStatus[7] == 0) {
				SetDynamicObjectRot(rollcall[7], 0, 0, 0);
				rollcallStatus[7] = 1;
			}
			else if(rollcallStatus[7] == 1) {
				SetDynamicObjectRot(rollcall[7], 0, 0, 90);
				rollcallStatus[7] = 0;
			}
		}
		//DOJ

		// PD MAIN HQ - OFFICE DOORS
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1923.728149, 634.913696, -14.858725)) {
			if(PDOffice_status[0] == 0) {
				SetDynamicObjectRot(PDOffice[0], 0, 0, 0);
				PDOffice_status[0] = 1;
			}
			else if(PDOffice_status[0] == 1) {
				SetDynamicObjectRot(PDOffice[0], 0, 0, -90);
				PDOffice_status[0] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1911.522094, 628.694458, -14.898726)) {
			if(PDOffice_status[1] == 0) {
				SetDynamicObjectRot(PDOffice[1], 0, 0, 0);
				PDOffice_status[1] = 1;
			}
			else if(PDOffice_status[1] == 1) {
				SetDynamicObjectRot(PDOffice[1], 0, 0, -90);
				PDOffice_status[1] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1911.531372, 621.373779, -14.898726)) {
			if(PDOffice_status[2] == 0) {
				SetDynamicObjectRot(PDOffice[2], 0, 0, 0);
				PDOffice_status[2] = 1;
			}
			else if(PDOffice_status[2] == 1) {
				SetDynamicObjectRot(PDOffice[2], 0, 0, -90);
				PDOffice_status[2] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1920.486694, 644.135070, -11.388713)) {
			if(PDOffice_status[3] == 0) {
				SetDynamicObjectRot(PDOffice[3], 0, 0, 0);
				PDOffice_status[3] = 1;
			}
			else if(PDOffice_status[3] == 1) {
				SetDynamicObjectRot(PDOffice[3], 0, 0, -90);
				PDOffice_status[3] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1914.598266, 644.901672, -11.402143)) {
			if(PDOffice_status[4] == 0) {
				SetDynamicObjectRot(PDOffice[4], 0, 0, 0);
				PDOffice_status[4] = 1;
			}
			else if(PDOffice_status[4] == 1) {
				SetDynamicObjectRot(PDOffice[4], 0, 0, -90);
				PDOffice_status[4] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1908.827392, 644.901672, -11.402143)) {
			if(PDOffice_status[5] == 0) {
				SetDynamicObjectRot(PDOffice[5], 0, 0, 0);
				PDOffice_status[5] = 1;
			}
			else if(PDOffice_status[5] == 1) {
				SetDynamicObjectRot(PDOffice[5], 0, 0, -90);
				PDOffice_status[5] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1903.616699, 644.901672, -11.402143)) {
			if(PDOffice_status[6] == 0) {
				SetDynamicObjectRot(PDOffice[6], 0, 0, 0);
				PDOffice_status[6] = 1;
			}
			else if(PDOffice_status[6] == 1) {
				SetDynamicObjectRot(PDOffice[6], 0, 0, -90);
				PDOffice_status[6] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1909.085205, 622.286804, -11.402143)) {
			if(PDOffice_status[7] == 0) {
				SetDynamicObjectRot(PDOffice[7], 0, 0, 0);
				PDOffice_status[7] = 1;
			}
			else if(PDOffice_status[7] == 1) {
				SetDynamicObjectRot(PDOffice[7], 0, 0, -90);
				PDOffice_status[7] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1915.746704, 622.193176, -11.402143)) {
			if(PDOffice_status[8] == 0) {
				SetDynamicObjectRot(PDOffice[8], 0, 0, 0);
				PDOffice_status[8] = 1;
			}
			else if(PDOffice_status[8] == 1) {
				SetDynamicObjectRot(PDOffice[8], 0, 0, -90);
				PDOffice_status[8] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 1920.929077, 619.437622, -11.402143)) {
			if(PDOffice_status[9] == 0) {
				SetDynamicObjectRot(PDOffice[9], 0, 0, 0);
				PDOffice_status[9] = 1;
			}
			else if(PDOffice_status[9] == 1) {
				SetDynamicObjectRot(PDOffice[9], 0, 0, -90);
				PDOffice_status[9] = 0;
			}
		}
		//*******************************************SASD VRATA********************************************
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 602.049438, -565.793701, 41.418514)) {
			if(sdDoorsStatus1 == 0) {
				SetDynamicObjectRot(sdIntDoors1, 0, 0, 90);
				sdDoorsStatus1 = 1;
			}
			else if(sdDoorsStatus1 == 1) {
				SetDynamicObjectRot(sdIntDoors1, 0, 0, 0);
				sdDoorsStatus1 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 604.469482, -568.015014, 41.418514)) {
			if(sdDoorsStatus2 == 0) {
				SetDynamicObjectRot(sdIntDoors2, 0, 0, -90);
				sdDoorsStatus2 = 1;
			}
			else if(sdDoorsStatus2 == 1) {
				SetDynamicObjectRot(sdIntDoors2, 0, 0, 180);
				sdDoorsStatus2 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 617.409057, -560.354003, 44.888515)) {
			if(sdDoorsStatus3 == 0) {
				SetDynamicObjectRot(sdIntDoors3, 0, 0, 90);
				sdDoorsStatus3 = 1;
			}
			else if(sdDoorsStatus3 == 1) {
				SetDynamicObjectRot(sdIntDoors3, 0, 0, 0);
				sdDoorsStatus3 = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 617.409057, -558.494506, 44.888515)) {
			if(sdDoorsStatus4 == 0) {
				SetDynamicObjectRot(sdIntDoors4, 0, 0, 180.0);
				sdDoorsStatus4 = 1;
			}
			else if(sdDoorsStatus4 == 1) {
				SetDynamicObjectRot(sdIntDoors4, 0, 0, -90.0);
				sdDoorsStatus4 = 0;
			}
		}
	/*}
	if(PRESSED(KEY_SECONDARY_ATTACK)) { // Tipka F
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2070.0911,2185.0234,-31.4410)) { //LSSD Lift prvi sprat za drugi
			SetPlayerPosEx(playerid, 2034.8427,2185.9893,-31.4410, 6, 20, true);
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 20);
			GameTextForPlayer(playerid, "SASD 1. kat", 3000, 1);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2034.8427,2185.9893,-31.4410)) { //LSSD Lift drugi sprat za prvi
            SetPlayerPosEx(playerid,2070.0911,2185.0234,-31.4410, 6, 20, true);
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 20);
            GameTextForPlayer(playerid, "SASD prizemlje", 3000, 1);
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 621.2169,-569.2618,26.2097)) { //LSSD HELIO ENTER
			SetPlayerPosEx(playerid, 2044.8350,2186.1943,-31.4410, 0, 27, true);
			SetPlayerInterior(playerid, 6);
			SetPlayerVirtualWorld(playerid, 20);
			GameTextForPlayer(playerid, "SASD 1. kat", 3000, 1);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2044.8350,2186.1943,-31.4410)) { //LSSD HELIO EXIT
            SetPlayerPosEx(playerid,621.2169,-569.2618,26.2097, 0, 0, true);
            GameTextForPlayer(playerid, "SASD helio", 3000, 1); */
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1333.6085,1088.5511,-20.3352)) { //LSPD ulaz u holding room
            SetPlayerPosEx(playerid,1435.3768,1088.4629,-20.5684, 0, 27, true);
            GameTextForPlayer(playerid, "LSPD Holding rooms", 3000, 1);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1435.3768,1088.4629,-20.5684)) { //LSPD izlaz iz holding rooma
            SetPlayerPosEx(playerid,1333.6085,1088.5511,-20.3352, 0, 27, true);
            GameTextForPlayer(playerid, "LSPD Lobby", 3000, 1);
		}
	return 1;
}

timer InstantStreamerUpdate[4000](playerid)
{
	Streamer_ToggleIdleUpdate(playerid, 0);
	TogglePlayerControllable(playerid, 1);
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
	//StreamerSettings
	Streamer_ToggleIdleUpdate(playerid, 1);
	TogglePlayerControllable(playerid, 0);

	//PlayerSets
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);

	if(update) defer InstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);

	//SettingPos
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	return SetPlayerPos(playerid, x, y, z);
}

stock SetPlayerSpawnEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
	//StreamerSettings
	Streamer_ToggleIdleUpdate(playerid, 1);
	TogglePlayerControllable(playerid, 0);

	//PlayerSets
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);

	if(update) defer InstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);

	//SettingPos
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	return SetPlayerPos(playerid, x, y, z);
}
