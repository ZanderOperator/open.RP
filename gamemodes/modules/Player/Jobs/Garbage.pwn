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

#define TRASH_PRICE                         (43) 	// ovo je cijena vrece smeca u randomu
#define PRICE_TRASH                         (50) 	// cijena vrece dobijat ce jos random(150)
#define MAX_GARBAGE_CONTAINERS				(88)

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
static stock
	Float:randomTrashPos[18][3] = {
		{2381.64868, -1516.74170, 23.32640},
		{1788.82690, -1597.00281, 12.79760},
		{1670.40991, -1585.04602, 12.82960},
		{1512.28345, -1712.62939, 13.35087},
		{1759.74829, -1830.80823, 12.86500},
		{1807.24841, -1810.71436, 12.86500},
		{1996.57654, -1612.85193, 12.81510},
		{2051.40918, -1618.73083, 12.81510},
		{2365.51416, -1651.08020, 12.82430},
		{2349.59253, -1705.13574, 12.82430},
		{2566.10327, -1741.30530, 12.82290},
		{2592.17896, -1723.89966, 12.82290},
		{2664.31323, -1649.90002, 10.16820},
		{2598.53979, -1452.22046, 33.05127},
		{2598.78613, -1437.31689, 33.05127},
		{2389.75562, -1447.75110, 23.29807},
		{2361.82544, -1376.71021, 23.29807},
		{2296.12720, -1391.85034, 23.29807}
	};

// onaj sto hoda
new	garbageContainers[MAX_GARBAGE_CONTAINERS],
	garbageContainersTrash[MAX_GARBAGE_CONTAINERS],
	bool:pTakedWC[MAX_PLAYERS],	
	bool:gHasGarbage[MAX_PLAYERS],
	tObject[MAX_PLAYERS],
	// kamion
	bool:gStartedCleaning[MAX_PLAYERS],
	bool:gGarbagePicked[MAX_PLAYERS],
	pOnDepony[MAX_PLAYERS],
	gDeponyEmpty[MAX_PLAYERS],
	pBoxes[MAX_PLAYERS];
	
new
	Bit8: gr_GarbageBoxesAll <MAX_PLAYERS> 	= { Bit8:0, ... },
	Bit8: gr_TrashPickuped <MAX_PLAYERS> 	= { Bit8:0, ... };

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

stock GetNearestContainer(pID)
{
	new Float:objPos[3];

	for(new i = 0; i < MAX_GARBAGE_CONTAINERS; i++) {
		GetDynamicObjectPos(garbageContainers[i], objPos[0], objPos[1], objPos[2]);
		if(IsPlayerInRangeOfPoint(pID, 2.0, objPos[0], objPos[1], objPos[2])) {
			return i;
		}
	}
	return INVALID_OBJECT_ID;
}
stock IsVehicleATrashTruck(id)
{
	if(GetVehicleModel(id) == 408)
	{
		return true;
	}
	return false;
}
stock static CheckGarbages(playerid)
{
	Bit8_Set( gr_TrashPickuped, playerid, Bit8_Get( gr_TrashPickuped, playerid) + 1);
	new
		tmpString[16];
	format( tmpString, sizeof(tmpString), "~y~%d stavljeno", Bit8_Get( gr_TrashPickuped, playerid));
	GameTextForPlayer(playerid, tmpString, 1500, 1);
	
	if(Bit8_Get( gr_TrashPickuped, playerid) == 8)
	{
		new money = (TRASH_PRICE * 10) + (GetPlayerSkillLevel(playerid) * 25); 
		va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", money);

		BudgetToPlayerBankMoney (playerid, money); // novac sjeda na radnu knjizicu iz proracuna
		PaydayInfo[playerid][pPayDayMoney] += money;
		PlayerJob[playerid][pFreeWorks] -= 5;
		UpgradePlayerSkill(playerid);
		gStartedWork[playerid] = 0;
		gHasGarbage[playerid] = false;
		DestroyPlayerObject(playerid, tObject[playerid]);
		tObject[playerid] = INVALID_OBJECT_ID;
		DisablePlayerCheckpoint(playerid);
		Bit8_Set( gr_TrashPickuped, playerid, 0);
		Player_SetIsWorkingJob(playerid, false);
		return 1;
	}
	
	new Pos = random(sizeof(randomTrashPos));
	tObject[playerid] = CreatePlayerObject(playerid, 2672, randomTrashPos[Pos][0], randomTrashPos[Pos][1], randomTrashPos[Pos][2], 0.00000, 0.00000, 0.00000, 300.0);
	SetPlayerCheckpoint(playerid, randomTrashPos[Pos][0], randomTrashPos[Pos][1], randomTrashPos[Pos][2], 2.0);
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
	CreateDynamic3DTextLabel("Mjesto za bacanje smeca\nDa bacite smece pritisnite tipku\n{008000}'LMB'", 0xFFFFFFFF, 2178.7537, -1992.0636, 13.5469, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 4.0);
    CreateDynamicPickup(19198, 1, 2178.7537, -1992.0636, 13.5469, -1, -1, -1);

	/*     [KONTEJNERI]     */
	garbageContainers[0] = CreateDynamicObject(1331, 2374.13110, -1533.58521, 23.93410, 0.00000, 0.00000, 180.00000);
	garbageContainers[1] = CreateDynamicObject(1331, 2354.58911, -1478.56909, 23.86800, 0.00000, 0.00000, -90.00000);
	garbageContainers[2] = CreateDynamicObject(1331, 2332.76514, -1373.22083, 23.87720, 0.00000, 0.00000, 0.00000);
	garbageContainers[3] = CreateDynamicObject(1331, 2401.90161, -1392.72083, 23.91510, 0.00000, 0.00000, -90.00000);
	garbageContainers[4] = CreateDynamicObject(1331, 2383.80298, -1449.48755, 23.94420, 0.00000, 0.00000, 90.00000);
	garbageContainers[5] = CreateDynamicObject(1331, 2440.06519, -1415.23438, 23.87680, 0.00000, 0.00000, 90.00000);
	garbageContainers[6] = CreateDynamicObject(1331, 2440.33350, -1371.17773, 23.89960, 0.00000, 0.00000, 90.00000);
	garbageContainers[7] = CreateDynamicObject(1331, 2460.36963, -1315.03357, 23.88850, 0.00000, 0.00000, -90.00000);
	garbageContainers[8] = CreateDynamicObject(1331, 2412.69263, -1267.24316, 24.07250, 0.00000, 0.00000, 180.00000);
	garbageContainers[9] = CreateDynamicObject(1331, 2362.04614, -1200.77722, 27.49740, 0.00000, 0.00000, 90.00000);
	garbageContainers[10] = CreateDynamicObject(1331, 2582.06860, -1192.88599, 61.78150, 0.00000, 0.00000, 180.00000);
	garbageContainers[11] = CreateDynamicObject(1331, 2711.64624, -1193.00061, 69.28260, 0.00000, 0.00000, 180.00000);
	garbageContainers[12] = CreateDynamicObject(1331, 2681.58179, -1097.17395, 69.19490, 0.00000, 0.00000, 180.00000);
	garbageContainers[13] = CreateDynamicObject(1331, 2712.22949, -1128.49414, 69.49770, 0.00000, 0.00000, 90.00000);
	garbageContainers[14] = CreateDynamicObject(1331, 2711.91431, -1277.10083, 58.00080, 0.00000, -8.00000, 90.00000);
	garbageContainers[15] = CreateDynamicObject(1331, 2752.32544, -1327.09961, 49.87260, 0.00000, 0.00000, -133.00000);
	garbageContainers[16] = CreateDynamicObject(1331, 2748.32446, -1425.05981, 31.39660, 0.00000, 15.00000, -90.00000);
	garbageContainers[17] = CreateDynamicObject(1331, 2684.27026, -1452.08569, 30.45910, 0.00000, 0.00000, -90.00000);
	garbageContainers[18] = CreateDynamicObject(1331, 2680.69971, -1402.56079, 30.41720, 0.00000, 0.00000, -40.00000);
	garbageContainers[19] = CreateDynamicObject(1331, 2654.48047, -1597.17065, 12.63770, 0.00000, 10.00000, -95.00000);
	garbageContainers[20] = CreateDynamicObject(1331, 2584.11108, -1455.12061, 34.57140, 0.00000, -4.00000, 180.00000);
	garbageContainers[21] = CreateDynamicObject(1331, 2539.77588, -1475.74866, 23.90640, 0.00000, 0.00000, 90.00000);
	garbageContainers[22] = CreateDynamicObject(1331, 2498.61914, -1515.12732, 23.89500, 0.00000, 0.00000, 180.00000);
	garbageContainers[23] = CreateDynamicObject(1331, 2200.87524, -1496.08826, 23.94350, 0.00000, 0.00000, 90.00000);
	garbageContainers[24] = CreateDynamicObject(1331, 2213.53809, -1373.30225, 23.86660, 0.00000, 0.00000, 0.00000);
	garbageContainers[25] = CreateDynamicObject(1331, 2259.89404, -1262.43958, 23.87500, 0.00000, 0.00000, 90.00000);
	garbageContainers[26] = CreateDynamicObject(1331, 2082.69019, -1262.94922, 23.86700, 0.00000, 0.00000, -90.00000);
	garbageContainers[27] = CreateDynamicObject(1331, 2021.64624, -1271.71240, 23.89140, 0.00000, 0.00000, 180.00000);
	garbageContainers[28] = CreateDynamicObject(1331, 2140.40112, -1496.34473, 23.86420, 0.00000, 0.00000, -90.00000);
	garbageContainers[29] = CreateDynamicObject(1331, 2113.91284, -1373.43994, 24.02590, 0.00000, 0.00000, 0.00000);
	garbageContainers[30] = CreateDynamicObject(1331, 2056.07129, -1107.56458, 24.25010, 0.00000, 0.00000, 90.00000);
	garbageContainers[31] = CreateDynamicObject(1331, 2237.95386, -1149.94409, 25.76740, 0.00000, 0.00000, 180.00000);
	garbageContainers[32] = CreateDynamicObject(1331, 2280.55640, -1079.72729, 47.69600, 0.00000, 0.00000, 156.00000);
	garbageContainers[33] = CreateDynamicObject(1331, 2202.85254, -1004.22028, 61.94300, 0.00000, 6.00000, -26.00000);
	garbageContainers[34] = CreateDynamicObject(1331, 1855.71790, -1068.37830, 23.82190, 0.00000, 0.00000, 90.00000);
	garbageContainers[35] = CreateDynamicObject(1331, 1863.14856, -1331.91077, 13.42750, 0.00000, 0.00000, 0.00000);
	garbageContainers[36] = CreateDynamicObject(1331, 2101.67993, -1446.30432, 23.93290, 0.00000, 0.00000, 90.00000);
	garbageContainers[37] = CreateDynamicObject(1331, 2355.57739, -1395.82837, 23.61690, 0.00000, 0.00000, 0.00000);
	garbageContainers[38] = CreateDynamicObject(1331, 2444.94971, -1558.67407, 23.67610, 0.00000, 0.00000, 0.00000);
	garbageContainers[39] = CreateDynamicObject(1331, 2172.58032, -1395.28564, 23.64650, 0.00000, 0.00000, 0.00000);
	garbageContainers[40] = CreateDynamicObject(1331, 2177.72607, -1343.71265, 23.60390, 0.00000, 0.00000, 0.00000);
	garbageContainers[41] = CreateDynamicObject(1331, 2094.79199, -1344.72778, 23.50720, 0.00000, 0.00000, 0.00000);
	garbageContainers[42] = CreateDynamicObject(1331, 2312.58936, -1213.29358, 23.59900, 0.00000, 0.00000, 90.00000);
	garbageContainers[43] = CreateDynamicObject(1331, 2333.40796, -1313.00342, 23.72930, 0.00000, 0.00000, 0.00000);
	garbageContainers[44] = CreateDynamicObject(1331, 2230.5300, -1685.6113, 14.1364, 5.7400, 4.2800, 255.6006); // 2231.37769, -1689.80139, 13.87700
	garbageContainers[45] = CreateDynamicObject(1331, 2424.38232, -1770.80286, 13.46660, 0.00000, 0.00000, -90.00000);
	garbageContainers[46] = CreateDynamicObject(1331, 2450.22510, -1998.87585, 13.46750, 0.00000, 0.00000, 0.00000);
	garbageContainers[47] = CreateDynamicObject(1331, 2404.59106, -2060.95410, 13.46540, 0.00000, 0.00000, 90.00000);
	garbageContainers[48] = CreateDynamicObject(1331, 2424.65991, -1882.75476, 13.44310, 0.00000, 0.00000, -90.00000);
	garbageContainers[49] = CreateDynamicObject(1331, 2294.76440, -1647.25757, 14.71700, 0.00000, 0.00000, 90.00000);
	garbageContainers[50] = CreateDynamicObject(1331, 2174.35864, -1728.54004, 13.38960, 0.00000, 0.00000, 90.00000);
	garbageContainers[51] = CreateDynamicObject(1331, 2227.86670, -1942.56384, 13.42540, 0.00000, 0.00000, -90.00000);
	garbageContainers[52] = CreateDynamicObject(1331, 2232.19458, -1983.95862, 13.44710, 0.00000, 0.00000, 180.00000);
	garbageContainers[53] = CreateDynamicObject(1331, 2324.54907, -1949.34570, 13.49620, 0.00000, 0.00000, -90.00000);
	garbageContainers[54] = CreateDynamicObject(1331, 2282.25635, -2066.07910, 13.48550, 0.00000, 0.00000, -45.00000);
	garbageContainers[55] = CreateDynamicObject(1331, 2082.33179, -2099.21997, 13.48340, 0.00000, 0.00000, 0.00000);
	garbageContainers[56] = CreateDynamicObject(1331, 1974.21301, -2068.19043, 13.29440, 0.00000, 0.00000, -90.00000);
	garbageContainers[57] = CreateDynamicObject(1331, 1914.27808, -2063.52490, 13.44720, 0.00000, 0.00000, 180.00000);
	garbageContainers[58] = CreateDynamicObject(1331, 1813.90051, -2018.24243, 13.44740, 0.00000, 0.00000, 90.00000);
	garbageContainers[59] = CreateDynamicObject(1331, 1833.90063, -2096.84692, 13.50580, 0.00000, 0.00000, 270.00000);
	garbageContainers[60] = CreateDynamicObject(1331, 1950.02502, -1977.18103, 13.46820, 0.00000, 0.00000, 90.00000);
	garbageContainers[61] = CreateDynamicObject(1331, 1972.45715, -1892.66675, 13.54530, 0.00000, 0.00000, -90.00000);
	garbageContainers[62] = CreateDynamicObject(1331, 1972.87158, -1785.61707, 13.44540, 0.00000, 0.00000, -90.00000);
	garbageContainers[63] = CreateDynamicObject(1331, 2051.97559, -1762.90161, 13.44790, 0.00000, 0.00000, 180.00000);
	garbageContainers[64] = CreateDynamicObject(1331, 2045.16138, -1661.58215, 13.44610, 0.00000, 0.00000, 0.00000);
	garbageContainers[65] = CreateDynamicObject(1331, 2014.96680, -1601.45349, 13.43070, 0.00000, 0.00000, 0.00000);
	garbageContainers[66] = CreateDynamicObject(1331, 2088.37573, -1601.25305, 13.29120, 0.00000, 0.00000, 0.00000);
	garbageContainers[67] = CreateDynamicObject(1331, 2229.77930, -1640.54761, 15.42950, 0.00000, 0.00000, -12.00000);
	garbageContainers[68] = CreateDynamicObject(1331, 2397.89941, -1668.97827, 13.44690, 0.00000, 0.00000, 180.00000);
	garbageContainers[69] = CreateDynamicObject(1331, 2476.16846, -1742.92188, 13.44290, 0.00000, 0.00000, 180.00000);
	garbageContainers[70] = CreateDynamicObject(1331, 2539.87866, -1722.22986, 13.44590, 0.00000, 0.00000, 28.00000);
	garbageContainers[71] = CreateDynamicObject(1331, 2516.81055, -1774.24707, 13.42750, 0.00000, 0.00000, 90.00000);
	garbageContainers[72] = CreateDynamicObject(1331, 2517.92529, -1944.17029, 13.54970, 0.00000, 0.00000, 180.00000);
	garbageContainers[73] = CreateDynamicObject(1331, 2457.22046, -1945.60767, 13.46610, 0.00000, 0.00000, 180.00000);
	garbageContainers[74] = CreateDynamicObject(1331, 1832.38635, -1792.81152, 13.45490, 0.00000, 0.00000, 270.00000);
	garbageContainers[75] = CreateDynamicObject(1331, 1832.42407, -1888.00916, 13.30940, 0.00000, 0.00000, -90.00000);
	garbageContainers[76] = CreateDynamicObject(1331, 2030.46619, -1921.41699, 13.42770, 0.00000, 0.00000, 0.00000);
	garbageContainers[77] = CreateDynamicObject(1331, 2137.17407, -1905.20178, 13.44570, 0.00000, 0.00000, 180.00000);
	garbageContainers[78] = CreateDynamicObject(1331, 2013.26575, -2120.66162, 13.44620, 0.00000, 0.00000, 180.00000);
	garbageContainers[79] = CreateDynamicObject(1331, 1919.79724, -2155.08130, 13.50630, 0.00000, 0.00000, 0.00000);
	garbageContainers[80] = CreateDynamicObject(1331, 1811.38440, -2155.60840, 13.46660, 0.00000, 0.00000, 0.00000);
	garbageContainers[81] = CreateDynamicObject(1331, 1659.78662, -2113.31104, 13.44640, 0.00000, 0.00000, 90.00000);
	garbageContainers[82] = CreateDynamicObject(1331, 1810.88391, -1685.20435, 13.48230, 0.00000, 0.00000, 90.00000);
	garbageContainers[83] = CreateDynamicObject(1331, 1832.57739, -1594.36340, 13.46450, 0.00000, 0.00000, -104.00000);
	garbageContainers[84] = CreateDynamicObject(1331, 1932.78674, -1601.48621, 13.50850, 0.00000, 0.00000, 0.00000);
	garbageContainers[85] = CreateDynamicObject(1331, 1748.18384, -1589.34460, 13.41900, 0.00000, 0.00000, -8.00000);
	garbageContainers[86] = CreateDynamicObject(1331, 1699.90637, -1681.16211, 13.42760, 0.00000, 0.00000, -90.00000);

	for(new c = 0; c < MAX_GARBAGE_CONTAINERS; c++)
	{
	    garbageContainersTrash[c] = 100;
	}
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	pTakedWC[playerid] = false;
	gStartedWork[playerid] = 0;
	tObject[playerid] = 0;
    gHasGarbage[playerid] = false;
    gStartedCleaning[playerid] = false;
    gGarbagePicked[playerid] = false;
    pOnDepony[playerid] = 0;
    gDeponyEmpty[playerid] = 0;
    pBoxes[playerid] = 0;
	Bit8_Set( gr_TrashPickuped, playerid, 0);
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
	    if(PlayerJob[playerid][pJob] != JOB_GARBAGE) return 1;
		if(gHasGarbage[playerid] == true && gStartedWork[playerid] == 1)
		{
			new nContainer = GetNearestContainer(playerid);
			if(nContainer != INVALID_OBJECT_ID)
			{
				if(garbageContainersTrash[nContainer] > 200) return SendClientMessage( playerid, COLOR_RED, "Ovaj kontenjer je pun.");
				garbageContainersTrash[nContainer] = 1;
				ClearAnimations(playerid);
				gHasGarbage[playerid] = false;
				RemovePlayerAttachedObject(playerid, 0);
				CheckGarbages(playerid);
			}
		}
		else if(gGarbagePicked[playerid] == false && gStartedWork[playerid] == 2)
		{
			new nContainer = GetNearestContainer(playerid);
			if(nContainer != INVALID_OBJECT_ID)
			{
				if(garbageContainersTrash[nContainer] == 0) return SendClientMessage( playerid, COLOR_RED, "Ovaj kontenjer je prazan.");
				gGarbagePicked[playerid] = true;
				garbageContainersTrash[nContainer] = 0;
				SetPlayerAttachedObject(playerid, 0, 1264, 5, 0.352547, -0.205320, 0.184597, 212.175216, 292.318084, 151.621368, 1.000000, 1.000000, 1.000000); // vreca
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Pokupili ste smece, sada ga odnesite do vaseg kamiona. (( Lijevi klik misa kod kamiona)) ");
			}
		}
		else if(gGarbagePicked[playerid] == true && gStartedWork[playerid] == 2)
		{
			new 
				vID = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB);			
			if(!IsVehicleATrashTruck(vID)) return SendClientMessage( playerid, COLOR_RED, "Ne ubacujete smece u TrashMastera!");
			if(!IsPlayerNearTrunk(playerid, vID)) return 1;
			
			if(pBoxes[playerid] == 10) return SendClientMessage( playerid, COLOR_RED, "Vec ste utovarili 10 vreca! Odvezite kamion na deponij!");
			pBoxes[playerid] += 1;
			Bit8_Set( gr_GarbageBoxesAll, playerid, pBoxes[playerid]);
			
			SendMessage(playerid, MESSAGE_TYPE_INFO, "[!] Na mapi vam je oznacena lokacija deponije smeca.");
			va_SendClientMessage( playerid, COLOR_RED, "[!] Ubacili ste vrecu smeca u kamion sada ima %d/10 mozete ih odmah odvuci na deponiju ili skupljati jos pa onda.", pBoxes[playerid]);
			
			SetPlayerCheckpoint(playerid, 2183.8972, -1981.6560, 13.2578, 4.0);
			RemovePlayerAttachedObject(playerid, 0);
			gGarbagePicked[playerid] = false;
		}
		if(pOnDepony[playerid] == 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 2178.7537, -1992.0636, 13.5469))
			{
				if(IsPlayerAttachedObjectSlotUsed( playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);
				
				pBoxes[playerid]--;
				if(!pBoxes[playerid]) {
					new 
						money;
					switch( Bit8_Get( gr_GarbageBoxesAll, playerid))
					{
						case 1 .. 2:	money = PRICE_TRASH;
						case 3 .. 4:	money = random(100)  + PRICE_TRASH;
						case 5 .. 6:    money = random(200)  + PRICE_TRASH;
						case 7 .. 8:    money = random(255)  + PRICE_TRASH;
						case 9 .. 10:   money = random(350) + PRICE_TRASH;
					}
					money += (GetPlayerSkillLevel(playerid) * 30);
					va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", money);

					BudgetToPlayerBankMoney (playerid, money); // novac sjeda na radnu knjizicu iz proracuna
					PaydayInfo[playerid][pPayDayMoney] += money;
					PlayerJob[playerid][pFreeWorks] -= 5;
					UpgradePlayerSkill(playerid);
					gStartedWork[playerid] = 0;
					pOnDepony[playerid] = 0;
					gHasGarbage[playerid] = false;
					DisablePlayerCheckpoint(playerid);
				}
			}
			else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na deponiju!");
		}
	}
	if(PRESSED(KEY_NO))
	{
	    if(PlayerJob[playerid][pJob] == JOB_GARBAGE)
	    {
			if(gDeponyEmpty[playerid] == 1)
			{
			    new
				 	vID = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB);				
				if(!IsVehicleATrashTruck(vID)) 
					return SendClientMessage( playerid, COLOR_RED, "Ne vadite smece iz Trash Mastera!");
				if(!IsPlayerNearTrunk(playerid, vID)) 
					return 1;
			
				if(pBoxes[playerid] > 0)
				{
					pOnDepony[playerid] = 1;
					SetPlayerAttachedObject(playerid, 0, 1264, 5, 0.352547, -0.205320, 0.184597, 212.175216, 292.318084, 151.621368, 1.000000, 1.000000, 1.000000); // vreca
					
					new
						tmpString[10];
					format( tmpString, 10, "~w~%d/%d", 
						pBoxes[playerid],
						Bit8_Get( gr_GarbageBoxesAll, playerid)
					);
					GameTextForPlayer(playerid, tmpString, 2000, 1);
					SendMessage(playerid, MESSAGE_TYPE_INFO, "Uzeli ste vrecu smeca iz kamiona, sad je bacite na otpad. (( Lijevi klik misa kod otpada))");
				}
				else if(pBoxes[playerid] == 0)
				{
					gDeponyEmpty[playerid] = 0;
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "U vozilu nema vise vreca sa smecem.");
				}
			}
	    }
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerJob[playerid][pJob] == JOB_GARBAGE) 
	{	
		if(gStartedWork[playerid] == 1) 
		{
	        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage( playerid, COLOR_RED, "Ne smijete biti u vozilu!");
			DisablePlayerCheckpoint(playerid);
			ApplyAnimation(playerid, "BOMBER", "BOM_PLANT", 4.1, 1, 0, 0, 0, 0);
			defer AnimTimer(playerid);
	        gHasGarbage[playerid] = true;
	        defer CleanTimer(playerid);
		 	SetPlayerAttachedObject(playerid, 0, 1264, 5, 0.352547, -0.205320, 0.184597, 212.175216, 292.318084, 151.621368, 1.000000, 1.000000, 1.000000); // vreca
			GameTextForPlayer(playerid, "~g~Kupite smece pricekajte", 2500, 1);
			TogglePlayerControllable(playerid, false);
	    }
	    else if(gStartedWork[playerid] == 2) 
		{
			new vID = GetPlayerVehicleID(playerid);
			if(!IsVehicleATrashTruck(vID)) return SendClientMessage( playerid, COLOR_RED, "Ne istovarujete smece iz TrashMastera!");
  			gDeponyEmpty[playerid] = 1;
		    SendMessage(playerid, MESSAGE_TYPE_INFO, "Stigli ste na mjesto za istovar smeca sad izadjite iz kamiona i istovarite smece (Koristite tipku ~k~~CONVERSATION_NO~).");
			DisablePlayerCheckpoint(playerid);
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
timer CleanTimer[3500](playerid)
{
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Pokupili ste smece sada ga mozete odnijeti do najblizeg kontenjera.");
	DestroyPlayerObject(playerid, tObject[playerid]);
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}
timer AnimTimer[150](playerid)
{
    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT", 4.0, 0, 0, 0, 0, 0);
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
CMD:garbage(playerid, params[])
{
	new
		pick[8];
	if(PlayerJob[playerid][pJob] != JOB_GARBAGE) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste zaposleni kao smetlar!");
	if(sscanf( params, "s[8] ", pick)) return SendClientMessage(playerid, COLOR_RED, "[?]: /garbage [foot/truck/clothes/stop]");
	
	if(!strcmp( pick, "foot", true)) 
	{
		if(PlayerJob[playerid][pFreeWorks] < 1) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
		if(!pTakedWC[playerid]) return SendClientMessage( playerid, COLOR_RED, "Prvo morate koristiti /garbage clothes!");
		if(gStartedWork[playerid] != 0) return SendClientMessage( playerid, COLOR_RED, "Vec radite neki posao! Kucajte /garbage stop!");
		
		new Pos = random(sizeof(randomTrashPos));
		gStartedWork[playerid] = 1;
		Player_SetIsWorkingJob(playerid, true);
		tObject[playerid] = CreatePlayerObject(playerid, 2672, randomTrashPos[Pos][0], randomTrashPos[Pos][1], randomTrashPos[Pos][2], 0.00000, 0.00000, 0.00000, 300.0);
		SetPlayerCheckpoint(playerid, randomTrashPos[Pos][0], randomTrashPos[Pos][1], randomTrashPos[Pos][2], 2.0);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Smece vam je oznaceno crvenim na mapi, a kontenjeri rozim covjecicima.");
		Bit8_Set( gr_TrashPickuped, playerid, 0);
		return 1;
	}
	if(!strcmp( pick, "truck", true))
	{
		if(PlayerJob[playerid][pFreeWorks] < 1) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
		if(!pTakedWC[playerid]) return SendClientMessage( playerid, COLOR_RED, "Prvo morate koristiti /garbage clothes!");
		if(GetPlayerSkillLevel(playerid) < 1) return SendClientMessage( playerid, COLOR_RED, "Niste smetlar skill 1!");
		new vID = GetPlayerVehicleID(playerid);
		if(!IsVehicleATrashTruck(vID)) return SendClientMessage( playerid, COLOR_RED, "Niste u TrashMasteru!");
		gStartedWork[playerid] = 2;
		SendClientMessage( playerid, COLOR_RED, "[!] Krenite s praznjenjem kontenjera! Potrazite kotenjere sa smecem!");
		return 1;
	}
	if(!strcmp( pick, "clothes", true))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2199.1487,-1972.6333,13.5581)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu pickupa za presvlacenje!");
		if(pTakedWC[playerid] == false)
		{
			if(PlayerJob[playerid][pFreeWorks] < 1) return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi!");
			pTakedWC[playerid] = true;
			SetPlayerSkin(playerid, 16);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Obukli ste radnu odjecu, koristite /garbage foot ili truck da krenete raditi!");		
		}
		else if(pTakedWC[playerid] == true)
		{
			pTakedWC[playerid] = false;
			gStartedWork[playerid] = false;
			gHasGarbage[playerid] = false;
			SetPlayerSkin(playerid, PlayerAppearance[playerid][pSkin]);
			DestroyPlayerObject(playerid, tObject[playerid]);
			tObject[playerid] = INVALID_OBJECT_ID;
			DisablePlayerCheckpoint(playerid);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Ostavili ste radnu odjecu te zavrsili posao.");
			Player_SetIsWorkingJob(playerid, false);
			Bit8_Set( gr_TrashPickuped, playerid, 0);
		}
		return 1;
	}
	if(!strcmp( pick, "stop", true)) 
	{
		pTakedWC[playerid] 			= false;
		gStartedWork[playerid] 		= 0;
		tObject[playerid]			= 0;
		gHasGarbage[playerid] 		= false;
		gStartedCleaning[playerid] 	= false;
		gGarbagePicked[playerid]	= false;
		pOnDepony[playerid] 		= 0;
		gDeponyEmpty[playerid]		= 0;
		pBoxes[playerid] 			= 0;
		
		if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
			RemovePlayerAttachedObject(playerid, 0);
		
		Bit8_Set( gr_TrashPickuped, playerid, 0);
		DisablePlayerCheckpoint(playerid);
		Player_SetIsWorkingJob(playerid, false);
		SendClientMessage( playerid, COLOR_RED, "[!] Uspjesno ste prekinuli posao smetlara!");
	}
	return 1;
}
