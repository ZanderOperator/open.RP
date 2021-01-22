#include <YSI_Coding\y_hooks>

#if defined MODULE_JAIL
	#endinput
#endif
#define MODULE_JAIL

/*
	########  ######## ######## #### ##    ## ########  ######
	##     ## ##       ##        ##  ###   ## ##       ##    ##
	##     ## ##       ##        ##  ####  ## ##       ##
	##     ## ######   ######    ##  ## ## ## ######    ######
	##     ## ##       ##        ##  ##  #### ##             ##
	##     ## ##       ##        ##  ##   ### ##       ##    ##
	########  ######## ##       #### ##    ## ########  ######
*/
#define GATES_CLOSED  	0
#define GATES_CLOSING  	1
#define GATES_OPEN    	2
#define GATES_OPENING   3

/*
	######## ##    ## ##     ## ##     ##  ######
	##       ###   ## ##     ## ###   ### ##    ##
	##       ####  ## ##     ## #### #### ##
	######   ## ## ## ##     ## ## ### ##  ######
	##       ##  #### ##     ## ##     ##       ##
	##       ##   ### ##     ## ##     ## ##    ##
	######## ##    ##  #######  ##     ##  ######
*/

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

// 32bit
static stock
	//Jail Job
	JailJ[MAX_PLAYERS],
	JailJobProgress[MAX_PLAYERS],
	JailSmece[MAX_PLAYERS],
	Float:SmeceX[MAX_PLAYERS], Float:SmeceY[MAX_PLAYERS], Float:SmeceZ[MAX_PLAYERS],
	smecence[MAX_PLAYERS],
	// Objectids
	smalldoors,
	smalldoors1,
	prisonramp,
	prisonrampstatus,
	biggates,
	LSPrisonGatesObject[5],
	blockA[18],
	blockB[18],
 	blockC[18],
	entranceLobby [3],
	hallDoors [6],
	jailint,
	movefridge[2],
	tmpobjid,
	arrestcell[2],
	arrestcellC[2],
	greygate,
	jailcell[35],
	
	sdholding[4],
	sdholdingStatus[4],

	// Status
	EasternGatesStatus = GATES_CLOSED,
	SouthernGatesStatus = GATES_CLOSED,
	BigGatesStatus = GATES_CLOSED,
	SmallSouthGatesStatus = GATES_CLOSED,
	SmallEastGatesStatus = GATES_CLOSED,
	InsideDoorsStatus[48] = { GATES_CLOSED, ... };

// rBits
static stock
	Bit8: r_PlayerCamera <MAX_PLAYERS> = { Bit8:0, ... };

/*
	 ######  ########  #######   ######  ##    ##  ######
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	##          ##    ##     ## ##       ##  ##   ##
	 ######     ##    ##     ## ##       #####     ######
		  ##    ##    ##     ## ##       ##  ##         ##
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ##
	 ######     ##     #######   ######  ##    ##  ######
*/
//stock PutPlayerInSector(playerid, type)
stock PutPlayerInSector(playerid)
{
	switch( random(18)) {
		case 0:  SetPlayerPosEx(playerid, 222.7028,1903.5612,1374.5774, 7, 0, true); //a1
		case 1:  SetPlayerPosEx(playerid, 219.5443,1903.6227,1374.5774, 7, 0, true); //a2
		case 2:  SetPlayerPosEx(playerid, 216.3411,1903.2964,1374.5774, 7, 0, true); //a3
		case 3:  SetPlayerPosEx(playerid, 213.3439,1902.7461,1374.5774, 7, 0, true); //a4
		case 4:  SetPlayerPosEx(playerid, 208.8438,1900.1235,1374.5774, 7, 0, true); //a5
		case 5:  SetPlayerPosEx(playerid, 208.6978,1896.9990,1374.5774, 7, 0, true); //a6
		case 6:  SetPlayerPosEx(playerid, 208.7202,1894.0602,1374.5774, 7, 0, true); //a7
		case 7:  SetPlayerPosEx(playerid, 209.1873,1890.6364,1374.5774, 7, 0, true); //a8
		case 8:  SetPlayerPosEx(playerid, 209.0244,1887.5670,1374.5774, 7, 0, true); //a9
		case 9:  SetPlayerPosEx(playerid, 208.6996,1887.4937,1378.0592, 7, 0, true); //a10
		case 10: SetPlayerPosEx(playerid, 208.8860,1890.8300,1378.0592, 7, 0, true); //a11
		case 11: SetPlayerPosEx(playerid, 209.1885,1893.8470,1378.0592, 7, 0, true); //a12
		case 12: SetPlayerPosEx(playerid, 208.8763,1897.2546,1378.0592, 7, 0, true); //a13
		case 13: SetPlayerPosEx(playerid, 209.0329,1900.4608,1378.0592, 7, 0, true); //a14
		case 14: SetPlayerPosEx(playerid, 213.1059,1903.1697,1378.0582, 7, 0, true); //a15
		case 15: SetPlayerPosEx(playerid, 216.4196,1903.4692,1378.0582, 7, 0, true); //a16
		case 16: SetPlayerPosEx(playerid, 219.5009,1903.4543,1378.0582, 7, 0, true); //a17
		case 17: SetPlayerPosEx(playerid, 222.7668,1903.2522,1378.0582, 7, 0, true); //a18
	}
 	
 	//Celije zatvora za block B i C. Blockovi su izba�eni zbog slabe upotrebe i male koncentracije ljudi.
 	/*
	else if(type == 2)
	{
		switch( random(18)) {
			case 0:  SetPlayerPosEx(playerid, 115.2149,1903.0586,1374.5774, 8, 0, true); //b1
			case 1:  SetPlayerPosEx(playerid, 111.9753,1903.7701,1374.5774, 8, 0, true); //b2
			case 2:  SetPlayerPosEx(playerid, 108.7766,1903.5815,1374.5774, 8, 0, true); //b3
			case 3:  SetPlayerPosEx(playerid, 105.4737,1903.3940,1374.5774, 8, 0, true); //b4
			case 4:  SetPlayerPosEx(playerid, 101.0810,1900.2367,1374.5774, 8, 0, true); //b5
			case 5:  SetPlayerPosEx(playerid, 100.8902,1896.8545,1374.5774, 8, 0, true); //b6
			case 6:  SetPlayerPosEx(playerid, 100.7312,1893.7544,1374.5774, 8, 0, true); //b7
			case 7:  SetPlayerPosEx(playerid, 101.5014,1890.8010,1374.5774, 8, 0, true); //b8
			case 8:  SetPlayerPosEx(playerid, 101.3189,1887.2998,1374.5774, 8, 0, true); //b9
			case 9:  SetPlayerPosEx(playerid, 101.5382,1887.5361,1378.0592, 8, 0, true); //b10
			case 10: SetPlayerPosEx(playerid, 101.2528,1890.8656,1378.0592, 8, 0, true); //b11
			case 11: SetPlayerPosEx(playerid, 101.4674,1894.0216,1378.0592, 8, 0, true); //b12
			case 12: SetPlayerPosEx(playerid, 101.3790,1897.0374,1378.0592, 8, 0, true); //b13
			case 13: SetPlayerPosEx(playerid, 101.4633,1900.3386,1378.0592, 8, 0, true); //b14
			case 14: SetPlayerPosEx(playerid, 105.5190,1903.6438,1378.0582, 8, 0, true); //b15
			case 15: SetPlayerPosEx(playerid, 108.6430,1903.7428,1378.0582, 8, 0, true); //b16
			case 16: SetPlayerPosEx(playerid, 111.8684,1903.6144,1378.0582, 8, 0, true); //b17
			case 17: SetPlayerPosEx(playerid, 115.2515,1903.4838,1378.0582, 8, 0, true); //b18
		}
	}
	else if(type == 3)
	{
		switch( random(18)) {
			case 0:  SetPlayerPosEx(playerid, 339.6225,1887.5033,1374.5774, 9, 0, true); //s1
			case 1:  SetPlayerPosEx(playerid, 339.9919,1890.7203,1374.5774, 9, 0, true); //s2
			case 2:  SetPlayerPosEx(playerid, 340.0947,1893.8228,1374.5774, 9, 0, true); //s3
			case 3:  SetPlayerPosEx(playerid, 340.2426,1897.3146,1374.5774, 9, 0, true); //s1
			case 4:  SetPlayerPosEx(playerid, 340.0411,1900.1207,1374.5774, 9, 0, true); //s2
			case 5:  SetPlayerPosEx(playerid, 345.0890,1903.7009,1374.5774, 9, 0, true); //s3
			case 6:  SetPlayerPosEx(playerid, 348.4512,1903.4705,1374.5774, 9, 0, true); //s1
			case 7:  SetPlayerPosEx(playerid, 351.6910,1903.7904,1374.5774, 9, 0, true); //s2
			case 8:  SetPlayerPosEx(playerid, 354.9163,1904.1460,1374.5774, 9, 0, true); //s3
			case 9:  SetPlayerPosEx(playerid, 340.4532,1887.4805,1378.0592, 9, 0, true); //s1
			case 10:  SetPlayerPosEx(playerid, 340.2386,1891.0054,1378.0592, 9, 0, true); //s2
			case 11:  SetPlayerPosEx(playerid, 340.1494,1894.1643,1378.0592, 9, 0, true); //s3
			case 12:  SetPlayerPosEx(playerid, 340.1164,1897.2925,1378.0592, 9, 0, true); //s2
			case 13:  SetPlayerPosEx(playerid, 340.1934,1900.4688,1378.0592, 9, 0, true); //s3
			case 14:  SetPlayerPosEx(playerid, 345.2304,1903.7239,1378.0582, 9, 0, true); //s1
			case 15:  SetPlayerPosEx(playerid, 348.3625,1903.5541,1378.0582, 9, 0, true); //s2
			case 16:  SetPlayerPosEx(playerid, 351.6469,1903.4186,1378.0582, 9, 0, true); //s3
			case 17:  SetPlayerPosEx(playerid, 354.9759,1903.8064,1378.0582, 9, 0, true); //s3
		}
	}*/
	return 1;
}

PutPlayerInCustody(playerid){
	switch(random(4)){
	    case 0: SetPlayerPosEx(playerid, 1199.1404,1305.8285,-54.7172, 0, 17, true); //SD
	    case 1: SetPlayerPosEx(playerid, 1196.1112,1306.0089,-54.7172, 0, 17, true); //SD
	    case 2: SetPlayerPosEx(playerid, 1192.3811,1305.9879,-54.7172, 0, 17, true); //SD
	    case 3: SetPlayerPosEx(playerid, 1189.5078,1305.8452,-54.7172, 0, 17, true); //SD
	}
}

// Woo 12.2.18
stock PutPlayerInJail(playerid, time, type)
{
	TogglePlayerControllable(playerid, 0);
	if(type == 1) {// PD jail
		PlayerJail[playerid][pJailed] = 1;
		PlayerJail[playerid][pJailTime] = time;
		SetPlayerInterior(playerid, 0);
		PutPlayerInSector(playerid);
	}
	else if(type == 2) {// Fort De morgan
		PlayerJail[playerid][pJailed] = 2;
		PlayerJail[playerid][pJailTime] = time;
		SetPlayerPosEx(playerid, -10.9639, 2329.3030, 24.4, playerid, 0, true);

	}
	else if(type == 3) {// SD Pritvor
		PlayerJail[playerid][pJailed] = 3;
		PlayerJail[playerid][pJailTime] = time;
		PutPlayerInCustody(playerid);
	}
	/*else if(type == 4) {// Ne znam sta je al stavit cu da je tamnica u PD zatvoru
		PlayerJail[playerid][pJailed] = 4;
		PlayerJail[playerid][pJailTime] = time;
		SetPlayerInterior(playerid, 7);
		PutPlayerInSector(playerid, 3); // Stavlja ga u tamnica sektor
	}*/
	else if(type == 5) // ASGH Intenzivna - Treatment
	{
		PlayerJail[playerid][pJailed] = 5;
		PlayerJail[playerid][pJailTime] = time;
		SetPlayerPosEx(playerid, 1439.6251, 1506.4286, -68.6758, 10, 4); // Intenzivna jedinica ASGH
		ApplyAnimation(playerid,"CRACK","crckidle4", 4.0, 1, 0, 0, 1, 0);
	}
	ResetPlayerWeapons(playerid);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 7)) RemovePlayerAttachedObject(playerid, 7);
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
	Streamer_MaxItems(STREAMER_TYPE_OBJECT , 1000);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT , 1000);
	// Zidovi
	CreateObject(19794,1787.1300000,-1565.6800000,11.9688000,0.0000000,0.0000000,0.0000000);

	//Sheriff Department Hooldings
	sdholding[0] = CreateDynamicObject(19302, 1198.929687, 1308.806274, -54.487152, 0.000000, 0.000000, 0.000000, -1, 17, -1, 600.00, 600.00);
	sdholding[1] = CreateDynamicObject(19302, 1195.729125, 1308.806274, -54.487152, 0.000000, 0.000000, 0.000000, -1, 17, -1, 600.00, 600.00);
	sdholding[2] = CreateDynamicObject(19302, 1192.489501, 1308.806274, -54.487152, 0.000000, 0.000000, 0.000000, -1, 17, -1, 600.00, 600.00);
	sdholding[3] = CreateDynamicObject(19302, 1189.279541, 1308.806274, -54.487152, 0.000000, 0.000000, 0.000000, -1, 17, -1, 600.00, 600.00);

	//GATES OF PRISON EXTERIOR - CARLOS
	LSPrisonGatesObject[0] = CreateDynamicObject(971, 172.493026, -297.830718, 4.131583, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	LSPrisonGatesObject[1] = CreateDynamicObject(971, 172.352340, -329.109924, 4.131583, 0.000007, 0.000000, 90.000007, -1, -1, -1, 600.00, 600.00);
	LSPrisonGatesObject[2] = CreateDynamicObject(971, 77.302185, -221.571090, 4.160345, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	LSPrisonGatesObject[3] = CreateDynamicObject(971, 66.342163, -248.721160, 4.130342, 0.000000, -0.000007, 179.999954, -1, -1, -1, 600.00, 600.00);
	LSPrisonGatesObject[4] = CreateDynamicObject(971, 172.352340, -339.930145, 4.131583, 0.000014, 0.000000, 89.999984, -1, -1, -1, 600.00, 600.00);

	new
		objectid;

	// Eksterijer - Carlos
	objectid = CreateDynamicObject(3998, 94.765747, -264.737609, 6.872148, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(3998, 152.475692, -311.667572, 6.872148, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(3998, 51.995765, -311.337738, 6.872148, 0.000000, 0.000000, 900.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.352340, -292.915649, -4.795256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.352340, -302.755554, -4.775256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.352340, -304.915527, 8.204749, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.493026, -334.024993, -4.795256, 0.000000, -0.000007, 179.999847, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.493026, -324.185089, -4.775257, 0.000000, -0.000007, 179.999847, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.493026, -332.855133, 8.204749, -0.000007, 90.000000, -89.999946, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 107.232337, -222.205795, -5.305257, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(19446, 104.988830, -226.560806, 0.514374, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19446, 104.988830, -236.190887, 0.514374, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19446, 104.988830, -245.820861, 0.514374, 0.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19371, 101.549880, -240.967391, 0.518124, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19446, 84.598869, -226.180892, 0.514374, 0.000000, 90.000022, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19446, 84.598869, -235.810974, 0.514374, 0.000000, 90.000022, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19446, 84.598869, -245.441040, 0.514374, 0.000000, 90.000022, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(3578, 82.180160, -227.916946, 1.048110, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(3578, 82.180160, -238.217010, 1.048110, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(18980, 82.212371, -221.825836, -4.765254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(3578, 72.440208, -227.916946, 1.048110, 0.000037, 0.000000, 89.999885, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(3578, 72.440208, -238.217010, 1.048110, 0.000037, 0.000000, 89.999885, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(18980, 72.372367, -221.825836, -4.765254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(5837, 74.072021, -246.229629, 2.218125, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 4833, "airprtrunway_las", "policeha02black_128", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4833, "airprtrunway_las", "dockwall1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	objectid = CreateDynamicObject(18980, 71.262374, -248.975906, -4.765254, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 61.402374, -248.975906, -4.765254, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(3578, 71.240203, -232.956909, 1.048110, 0.000037, 0.000000, 89.999885, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(3578, 71.240203, -243.256973, 1.048110, 0.000037, 0.000000, 89.999885, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(3578, 61.500251, -243.256988, 1.048110, 0.000060, 0.000000, -90.000152, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(3578, 61.500251, -232.956924, 1.048110, 0.000060, 0.000000, -90.000152, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	objectid = CreateDynamicObject(18980, 18.322364, -249.375839, -3.575252, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(967, 70.960090, -225.713256, 0.583257, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	objectid = CreateDynamicObject(967, 61.760089, -225.713256, 0.583257, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	objectid = CreateDynamicObject(18980, 60.262374, -221.825836, -4.765254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -223.290817, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -226.790832, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -230.290939, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -233.780975, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -237.280944, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19438, 93.286888, -240.781005, 0.538124, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(11245, 85.368690, -222.305892, 6.757530, 0.000000, -64.799919, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	objectid = CreateDynamicObject(19482, 95.089614, -240.977279, 5.328125, 0.000007, 0.000000, 80.500061, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "San Andreas Department of Corrections ", 120, "Ariel", 30, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 91.207015, -240.307586, 5.018122, 0.000007, 0.000000, 80.200065, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "and Rehabilitation", 120, "Ariel", 30, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(17513, 136.759674, -254.789642, -7.343849, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 19480, "signsurf", "sign", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.493026, -344.845214, -4.795256, 0.000000, -0.000014, 179.999801, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 172.493026, -335.005310, -4.775257, 0.000000, -0.000014, 179.999801, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(18980, 83.162391, -249.845748, -4.765254, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 16388, "desn2_stud", "simplewall256", 0x00000000);
	objectid = CreateDynamicObject(16564, 36.312549, -279.923675, 0.712634, -0.299998, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	objectid = CreateDynamicObject(19379, 45.212055, -259.177154, -0.962737, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	objectid = CreateDynamicObject(19379, 45.212055, -259.187164, -0.272738, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	objectid = CreateDynamicObject(16327, 161.975601, -228.538970, 0.305409, 0.000000, 0.000000, 45.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(16327, 112.859802, -292.319885, 0.305409, 0.000000, 0.000000, 225.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(16327, 108.129806, -299.359558, 0.305409, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(16327, 57.179805, -255.529647, 0.455410, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(16327, 96.199813, -329.739532, 0.305409, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(19379, 171.789260, -275.122741, -1.222336, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	objectid = CreateDynamicObject(8555, 143.258834, -264.956787, -22.731884, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SetDynamicObjectMaterial(objectid, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	objectid = CreateDynamicObject(8555, 131.808700, -264.956787, -22.741884, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SetDynamicObjectMaterial(objectid, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	objectid = CreateDynamicObject(8555, 95.508682, -304.367126, -22.761884, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SetDynamicObjectMaterial(objectid, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	objectid = CreateDynamicObject(8555, 95.508682, -311.047180, -22.751884, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SetDynamicObjectMaterial(objectid, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	objectid = CreateDynamicObject(19377, 145.107666, -284.849517, 0.563489, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 14788, "ab_sfgymbits01", "ab_rollmat01", 0x00000000);
	objectid = CreateDynamicObject(19377, 134.607650, -284.849517, 0.563489, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 14788, "ab_sfgymbits01", "ab_rollmat01", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -298.453491, 0.543488, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -288.833465, 0.543488, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -279.203613, 0.543488, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -269.573669, 0.543488, 0.000000, 90.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -259.953643, 0.543488, 0.000000, 90.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -250.323791, 0.543488, 0.000000, 90.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 159.518966, -240.693679, 0.543488, 0.000000, 90.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.859008, -269.573669, 0.543488, 0.000000, 90.000015, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.859008, -259.953643, 0.543488, 0.000000, 90.000015, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.859008, -250.323791, 0.543488, 0.000000, 90.000015, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.859008, -240.693679, 0.543488, 0.000000, 90.000015, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 125.419052, -272.653442, 0.543488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 135.049209, -272.653442, 0.543488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 144.679244, -272.653442, 0.543488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 153.439254, -272.653442, 0.533488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 121.929275, -234.153533, 0.543488, 0.000014, 90.000015, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 131.559432, -234.153533, 0.543488, 0.000014, 90.000015, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 141.189468, -234.153533, 0.543488, 0.000014, 90.000015, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 150.819549, -234.153533, 0.543488, 0.000014, 90.000015, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 156.449508, -234.153533, 0.533487, 0.000014, 90.000015, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 112.299026, -263.103729, 0.543488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 102.669052, -263.103729, 0.543488, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 80.775245, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 77.925315, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 75.125358, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 72.385375, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 69.455390, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 66.485366, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 63.575370, -283.846740, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 68.415397, -284.366851, -1.161874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 75.915382, -284.366851, -1.161874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(2913, 130.798614, -285.264251, 1.629425, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	objectid = CreateDynamicObject(968, 143.373733, -284.807189, -3.280569, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(19087, 140.924758, -284.770019, 3.489424, 0.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(968, 141.603759, -284.807189, -3.280569, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(968, 139.843826, -284.807189, -3.280569, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(19087, 139.824859, -284.770019, 3.489424, 0.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(19087, 137.374893, -284.770019, 1.859426, 0.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(19087, 137.374893, -285.629791, 1.859426, 0.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(968, 137.393783, -284.807189, -5.130568, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(968, 137.393783, -285.667083, -5.130568, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(968, 139.833724, -285.667083, -5.130568, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(2913, 130.798614, -282.284301, 1.629425, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	objectid = CreateDynamicObject(968, 149.123703, -284.807189, -3.280569, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(19871, 149.126190, -284.784698, 3.589425, 90.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(968, 149.123703, -281.717315, -3.280569, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(19871, 149.126190, -281.694824, 3.589425, 89.999992, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(968, 149.123703, -288.017120, -3.280569, 0.000014, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 4835, "airoads_las", "concretenewb256", 0x00000000);
	SetDynamicObjectMaterial(objectid, 2, 4835, "airoads_las", "concretenewb256", 0x00000000);
	objectid = CreateDynamicObject(19871, 149.126190, -287.994628, 3.589425, 89.999992, 0.000011, -89.999969, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10778, "airportcpark_sfse", "ws_crashbarrier", 0x00000000);
	objectid = CreateDynamicObject(19482, 106.867294, -258.434906, 7.969425, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "A", 80, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 106.867294, -258.434906, 6.909420, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "BLOCK", 130, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 64.087280, -304.925079, 7.969425, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "C", 80, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 64.087280, -304.925079, 6.829419, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "BLOCK", 130, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 159.207214, -303.194488, 7.969425, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "B", 80, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 159.207214, -303.194488, 6.799417, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "BLOCK", 130, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 132.717330, -302.764282, 7.969425, 0.000007, -0.000022, 179.999816, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "B", 80, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 132.717330, -302.764282, 6.799417, 0.000007, -0.000022, 179.999816, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "BLOCK", 130, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 103.457359, -284.514892, 7.969425, -0.000007, 0.000007, -89.999946, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "A", 80, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(19482, 103.457359, -284.514892, 6.909420, -0.000007, 0.000007, -89.999946, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(objectid, 0, "BLOCK", 130, "Ariel", 60, 1, 0xFF000000, 0x00000000, 1);
	objectid = CreateDynamicObject(4848, 117.506202, -322.343536, 4.003482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	objectid = CreateDynamicObject(4848, 79.336204, -322.343536, 4.003482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0x00000000);
	SetDynamicObjectMaterial(objectid, 1, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	objectid = CreateDynamicObject(19457, 68.509025, -309.713623, 0.523500, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 78.138961, -309.713623, 0.523500, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 87.758926, -309.713623, 0.523500, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 97.388916, -309.713623, 0.523500, 0.000000, 90.000015, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 107.009033, -309.713623, 0.523500, 0.000007, 90.000015, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 116.638969, -309.713623, 0.523500, 0.000007, 90.000015, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 126.258934, -309.713623, 0.523500, 0.000007, 90.000015, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 135.888916, -309.713623, 0.523500, 0.000007, 90.000015, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 94.588897, -303.153747, 0.523499, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 94.588897, -293.523895, 0.523499, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 94.588897, -283.893920, 0.523499, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 120.008888, -316.263732, 0.523505, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 81.788902, -316.263732, 0.523495, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 69.368850, -313.203704, 0.523496, 0.000000, 90.000015, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 69.368850, -316.703582, 0.523495, 0.000000, 90.000015, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 107.858856, -313.203704, 0.523496, -0.000007, 90.000015, -89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 107.858856, -316.703582, 0.523495, -0.000007, 90.000015, -89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -327.076904, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -329.926849, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -332.726806, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -335.466766, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -338.396759, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -341.366790, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.265304, -344.276794, -1.161874, 0.000014, 0.000007, 89.999923, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.785415, -339.436767, -1.161874, 0.000007, -0.000014, 179.999862, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(19457, 197.785415, -331.936767, -1.161874, 0.000007, -0.000014, 179.999862, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	objectid = CreateDynamicObject(16327, 194.799850, -312.919616, 0.455410, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3866, "dem1_sfxrf", "ws_oldoffice3", 0x00000000);
	SetDynamicObjectMaterial(objectid, 3, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	SetDynamicObjectMaterial(objectid, 4, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	SetDynamicObjectMaterial(objectid, 7, 6284, "bev_law2", "studwalltop_law", 0x00000000);
	SetDynamicObjectMaterial(objectid, 8, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	objectid = CreateDynamicObject(19379, 202.561981, -340.588256, 1.436180, 0.000000, 0.000000, 18.500007, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 19480, "signsurf", "sign", 0x00000000);
	objectid = CreateDynamicObject(19438, 65.157188, -286.277862, 1.328124, 90.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	objectid = CreateDynamicObject(19457, 101.478912, -298.113891, 0.523500, 0.000000, 90.000015, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 98.358901, -298.113891, 0.513500, 0.000000, 90.000015, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 81.673873, -306.134765, 0.513500, -0.000007, 90.000022, -0.000007, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 81.673873, -303.024780, 0.523499, -0.000007, 90.000022, 89.999992, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.870208, -279.188659, 0.543500, -0.000007, 90.000022, 179.999893, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.870208, -284.898742, 0.533498, -0.000007, 90.000022, 269.999877, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19457, 118.870208, -281.398773, 0.533499, -0.000007, 90.000022, 269.999877, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	objectid = CreateDynamicObject(19966, 198.082519, -316.261932, 0.148125, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 1, 19480, "signsurf", "sign", 0x00000000);
	objectid = CreateDynamicObject(19457, 175.181274, -321.943786, 0.508125, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(19457, 175.181274, -318.443939, 0.508125, 0.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	objectid = CreateDynamicObject(929, 24.518787, -262.726470, 2.214049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	objectid = CreateDynamicObject(943, 27.575777, -262.412017, 1.912181, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(objectid, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	//PIPE
	objectid = CreateDynamicObject(1381, 217.748825, -398.940032, 1.400706, 14.199999, -105.999977, -75.500022, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "vent01_64", 0x00000000);
	objectid = CreateDynamicObject(1381, 217.754089, -398.968505, 1.408723, 14.199999, -105.999977, -75.500022, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_castironwalk", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	objectid = CreateDynamicObject(19313, 106.730598, -229.066482, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 118.900550, -227.596359, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 127.990638, -227.596359, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 142.060684, -227.596359, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 156.110702, -227.596359, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -234.556396, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -248.616333, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -262.676239, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -276.716094, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -290.776000, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 163.160675, -304.825836, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 114.760650, -222.116317, 3.878122, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 128.810684, -222.116317, 3.878122, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 142.850631, -222.116317, 3.878122, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 156.910491, -222.116317, 3.878122, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 165.390548, -222.116317, 3.878122, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 172.370483, -229.216278, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 172.370483, -243.276290, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 172.370483, -257.326385, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 172.370483, -271.376464, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 172.370483, -285.426391, 3.878122, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 106.730598, -243.126480, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 82.770652, -228.356521, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 82.770652, -242.416412, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 89.790649, -250.226272, 3.878122, 0.000007, 0.000000, 179.999969, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 71.830650, -228.356521, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 71.830650, -242.426544, 3.878122, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 55.525962, -244.629730, 0.578125, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 60.830699, -228.356521, 3.878122, 0.000014, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 60.830699, -242.426544, 3.878122, 0.000014, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 45.027828, -244.629730, 0.678106, 0.000000, 91.099983, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 34.582427, -244.629730, 0.958669, 0.000000, 91.999969, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 24.108818, -244.629730, 1.324409, 0.000000, 91.999969, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 13.615221, -244.629730, 1.690850, 0.000000, 91.999969, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 53.770683, -249.476562, 3.878122, 0.000014, 0.000000, 179.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 39.721225, -249.476562, 4.028117, 0.000014, -0.799998, 179.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 25.672601, -249.476562, 4.224286, 0.000014, -0.799998, 179.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 54.147029, -244.297195, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 43.787021, -244.297195, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 33.457023, -244.297195, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 23.867015, -244.297195, -1.161874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 55.525962, -254.249969, 0.608124, 0.000000, 90.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 45.027828, -254.249969, 0.708105, 0.000000, 91.099990, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 34.582427, -254.249969, 0.988668, 0.000000, 91.999977, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 24.108818, -254.249969, 1.354410, 0.000000, 91.999977, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 13.615221, -254.249969, 1.720849, 0.000000, 91.999977, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(966, 69.667350, -227.212554, 0.578125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	prisonramp = CreateDynamicObject(968, 69.644668, -227.206695, 1.308123, 0.000000, -90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 84.527046, -234.557281, 0.638123, 0.000000, 0.000014, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 84.527046, -226.557281, 0.638123, 0.000000, 0.000014, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 104.717033, -234.557281, 0.638123, 0.000000, 0.000022, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 104.717033, -226.557281, 0.638123, 0.000000, 0.000022, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 93.247039, -234.557281, -0.341874, 0.000000, 0.000029, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 93.247039, -226.557281, -0.341874, 0.000000, 0.000029, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1256, 102.757057, -226.489227, 1.158123, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1256, 102.757057, -234.259170, 1.158123, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1256, 86.897094, -234.259185, 1.158123, 0.000000, 0.000007, 179.999893, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1256, 86.897094, -226.489242, 1.158123, 0.000000, 0.000007, 179.999893, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(16101, 85.530303, -222.325546, -1.079781, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 111.910575, -234.686309, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 111.910575, -248.736328, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 104.820579, -255.756362, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 111.910575, -274.506164, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 111.910575, -286.486206, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 145.580444, -293.345916, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 152.600494, -300.325744, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 131.530410, -293.345916, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 118.870407, -293.345916, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 104.820579, -267.526580, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 113.750328, -299.865905, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 106.700355, -292.875885, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 106.730331, -278.845764, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 127.810279, -299.865905, 3.878122, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 87.610343, -291.506072, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 83.250373, -287.016174, 3.878122, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 80.610343, -298.535919, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 62.190349, -294.015960, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 76.200325, -294.015960, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 66.550354, -298.535919, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 71.530364, -330.995880, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 85.580398, -330.995880, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 99.640357, -330.995880, 3.878122, 0.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 113.690345, -330.995880, 3.878122, 0.000000, -0.000007, 179.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 127.740379, -330.995880, 3.878122, 0.000000, -0.000007, 179.999954, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 132.910232, -324.015869, 3.878122, 0.000000, -0.000007, 269.999938, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 109.090408, -335.495788, 3.878122, 0.000000, -0.000014, 179.999908, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 123.140441, -335.495788, 3.878122, 0.000000, -0.000014, 179.999908, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 137.200408, -335.495788, 3.878122, 0.000000, -0.000014, 179.999908, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 151.250396, -335.495788, 3.878122, 0.000000, -0.000022, 179.999862, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 165.300415, -335.495788, 3.878122, 0.000000, -0.000022, 179.999862, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 38.820510, -335.495788, 3.878122, 0.000000, -0.000022, 179.999862, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 52.870544, -335.495788, 3.878122, 0.000000, -0.000022, 179.999862, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 66.930511, -335.495788, 3.878122, 0.000000, -0.000022, 179.999862, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 80.980499, -335.495788, 3.878122, 0.000000, -0.000029, 179.999816, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 95.030517, -335.495788, 3.878122, 0.000000, -0.000029, 179.999816, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 77.964431, -289.249267, 0.518124, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 67.474433, -289.249267, 0.518124, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 62.274429, -289.249267, 0.528124, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 31.840524, -328.415802, 3.878118, 0.000000, -0.000022, 269.999877, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 31.840538, -314.376068, 3.878115, 0.000000, -0.000022, 269.999877, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19313, 31.840545, -304.396026, 3.878113, 0.000000, -0.000022, 269.999877, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3819, 132.157379, -239.797805, 1.472710, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3819, 146.707351, -239.797805, 1.472710, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3819, 146.707366, -267.297668, 1.472710, -0.000007, 0.000000, -89.999946, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3819, 132.157394, -267.297668, 1.472710, -0.000007, 0.000000, -89.999946, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 107.146720, -259.463653, 1.228124, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 107.146720, -258.763580, 1.228124, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 107.146720, -258.043487, 1.228124, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 157.292358, -279.904907, 0.989426, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 157.292358, -289.804901, 0.989426, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 116.632347, -253.304885, 0.989426, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 116.632347, -240.924911, 0.989426, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 128.042343, -231.964981, 0.989426, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 151.752304, -231.964981, 0.989426, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 140.362319, -231.964981, 0.989426, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 151.752304, -274.874969, 0.989426, 0.000000, 0.000000, -89.999969, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 128.042343, -274.874969, 0.989426, 0.000000, 0.000000, -89.999969, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 139.432327, -274.874969, 0.989426, 0.000000, 0.000000, -89.999969, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(947, 124.598289, -252.941680, 2.782710, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(947, 153.878356, -252.941680, 2.782710, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 161.842300, -279.904907, 0.989426, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 161.842300, -289.694915, 0.989426, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 161.842300, -261.384857, 0.989426, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1280, 161.842300, -244.314834, 0.989426, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 78.532196, -289.423095, -0.721873, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 70.432197, -289.423095, -0.721873, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 61.357902, -284.165649, 1.188123, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 60.747890, -284.165649, 1.188123, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 60.117916, -284.165649, 1.188123, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1211, 60.234825, -258.584716, 1.098124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 82.310256, -273.418640, 1.328124, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 82.310256, -275.688507, 1.328124, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 85.429916, -284.477539, 1.843487, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 64.074821, -296.804840, 1.783486, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 106.845893, -251.739974, 1.818124, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 132.720489, -309.710205, 1.833487, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(2628, 131.597610, -288.170074, 0.649425, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(2629, 131.327957, -284.826171, 0.649425, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(2629, 131.327957, -281.846099, 0.649425, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1985, 148.246139, -284.769836, 3.589423, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1985, 148.246139, -281.679962, 3.589423, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1985, 148.246139, -287.979766, 3.589423, 0.000000, 0.000014, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1327, 144.445755, -288.049987, 0.639425, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 94.569915, -284.477539, 1.843487, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 203.115097, -331.772735, 0.518123, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 203.115097, -341.402557, 0.518123, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19381, 192.745071, -296.662384, 0.518123, 0.000000, 90.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	greygate = CreateDynamicObject(3037, 198.252288, -320.283996, 1.745738, 0.000000, 0.000000, -174.199935, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 192.577423, -296.491516, -0.545937, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(673, 199.127334, -336.621551, -0.545937, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 176.381530, -344.800323, 2.889667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 197.856460, -314.098937, 4.625298, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 197.856460, -308.868988, 4.625298, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 197.856460, -303.608978, 4.625298, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 197.856460, -298.389038, 4.625298, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 197.856460, -294.868988, 4.625298, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 195.056549, -292.038787, 4.625298, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 189.909500, -291.549377, 4.625298, -0.000000, 0.000007, -10.699995, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 184.980529, -290.089599, 4.625298, -0.000001, 0.000007, -22.199996, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 180.460388, -287.627441, 4.625298, -0.000003, 0.000006, -33.300014, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 176.933670, -284.091369, 4.625298, -0.000006, 0.000003, -55.100002, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 173.952743, -279.818572, 4.625298, -0.000006, 0.000003, -55.100002, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 172.975769, -276.487304, 4.625298, -0.000007, 0.000000, -82.699989, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 199.074386, -327.375335, 4.625298, -0.000007, 0.000000, -83.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 200.048171, -332.464538, 4.625298, -0.000007, 0.000001, -74.800056, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 201.563674, -337.433471, 4.625298, -0.000007, 0.000001, -71.100044, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 203.251266, -342.362365, 4.625298, -0.000007, 0.000001, -71.100044, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 120.791557, -344.800323, 2.889667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 65.191558, -344.800323, 2.889667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 45.511531, -344.850311, 4.859664, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 17.391500, -246.550323, 6.429669, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 17.391500, -302.130340, 6.429669, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(8210, 17.401500, -320.360260, 6.429669, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 78.157058, -289.090148, 0.984062, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 72.697074, -289.090148, 0.984062, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(6046, -5.035151, -250.026809, 2.731778, 1.100000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 47.377063, -255.010055, 1.174062, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 37.317062, -255.010055, 1.204062, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 25.907058, -255.010055, 1.714061, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 83.716857, -308.467712, 4.999434, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 72.616836, -308.467712, 4.999434, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 115.976890, -308.467712, 4.999434, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 104.876869, -308.467712, 4.999434, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 125.246894, -308.467712, 4.999434, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 95.746894, -302.517761, 4.999434, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1294, 95.746894, -293.167785, 4.999434, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3398, 116.365432, -292.825164, 3.899437, 0.000000, 0.000000, 144.800003, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3398, 158.918869, -228.147537, 3.899437, 0.000000, 0.000000, 324.799987, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1300, 102.492034, -238.941741, 0.908125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 110.015350, -307.480468, 1.119437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 121.015388, -307.480468, 1.119437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 87.705375, -307.480468, 1.119437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 77.995391, -307.480468, 1.119437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 68.695350, -307.480468, 1.119437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 92.315345, -302.010467, 1.119437, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3657, 92.315345, -293.920532, 1.119437, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 101.485168, -295.227050, 1.129436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 101.485168, -297.987060, 1.129436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 101.485168, -300.797027, 1.129436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1300, 96.972915, -307.422851, 0.939437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 78.787033, -303.008483, 1.129436, 0.000007, 0.000007, 89.999946, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 81.547042, -303.008483, 1.129436, 0.000007, 0.000007, 89.999946, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 84.357009, -303.008483, 1.129436, 0.000007, 0.000007, 89.999946, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 30.698308, -290.574554, 2.004527, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 30.698308, -292.914581, 2.004527, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 30.698308, -295.234558, 2.004527, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 28.628290, -288.954620, 2.034527, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 26.298286, -288.954620, 2.064527, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 23.988286, -288.954620, 2.104527, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 121.797058, -284.794891, 1.159436, 0.000007, 0.000007, -90.000022, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 119.037048, -284.794891, 1.159436, 0.000007, 0.000007, -90.000022, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 116.227081, -284.794891, 1.159436, 0.000007, 0.000007, -90.000022, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 121.797058, -281.695068, 1.159436, 0.000000, 0.000007, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 119.037048, -281.695068, 1.159436, 0.000000, 0.000007, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1968, 116.227081, -281.695068, 1.159436, 0.000000, 0.000007, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(19966, 198.988204, -324.995239, 0.152544, 0.000000, 0.000000, 96.599906, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 106.845893, -274.500305, 1.818124, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1216, 107.146720, -266.293579, 1.228124, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 142.706100, -299.727416, 1.843488, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 96.942604, -264.491058, 15.830892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(13011, 100.585044, -263.157043, 16.230901, 0.000000, 0.000000, -90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11714, 51.392608, -311.091369, 15.830892, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(13011, 55.035049, -309.757354, 16.230901, -0.000007, 0.000000, -89.999977, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3928, 51.794143, -319.269287, 20.115461, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(3928, 95.162132, -274.426879, 20.115461, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 192.476928, -295.950042, 1.204062, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(14400, 199.946945, -340.580139, 1.204062, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11245, 175.160369, -316.948516, 9.428137, 0.000000, 0.000000, 1.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11245, 175.039276, -310.019897, 9.428137, 0.000000, 0.000000, 1.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(700, 177.648910, -320.153594, 0.458125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 182.155654, -343.877441, 1.358124, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1344, 179.865676, -343.877441, 1.358124, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1687, 26.665222, -267.117004, 2.109226, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1687, 21.465221, -267.117004, 2.179226, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(2649, 29.792140, -267.127685, 1.669807, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 28.734405, -258.946044, 2.717558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 23.504398, -258.946044, 2.717558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1411, 18.264398, -258.946044, 2.717558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 58.704856, -253.846893, 10.331028, 15.499979, 0.000000, 158.000076, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 85.815856, -260.516693, 13.695347, 15.500000, 0.000000, -74.699958, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 44.361495, -287.882263, 13.763996, 21.499998, 0.000000, 120.700057, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 153.148681, -299.235198, 19.255880, 29.100013, 0.000000, -161.599990, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 64.814491, -312.007141, 19.255451, 29.400001, 0.000000, -270.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 132.088821, -299.549865, 19.266014, 30.199996, 0.000000, -73.400001, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(1886, 176.212753, -303.008666, 13.727846, 17.500003, 0.000000, 50.899993, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11245, 57.252437, -288.946166, 9.531245, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	objectid = CreateDynamicObject(11245, 50.362453, -288.946166, 9.531245, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	//PIPE NO TEXTURES
	objectid = CreateDynamicObject(3502, 216.996002, -396.453979, 1.732307, 0.000000, 0.000000, 15.800002, -1, -1, -1, 600.00, 600.00);

	//*******************|Cook County Department of Correction by #CARLOS and sWippero|****************************//

	//Arrest Point
	jailint = CreateDynamicObject(19379, 1944.235351, 813.637084, -47.698120, 0.000000, 89.999969, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 1954.727172, 813.637084, -47.698116, 0.000000, 89.999969, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19457, 1938.918212, 813.618652, -45.872177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1956.886962, 813.618652, -45.872177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1943.811035, 817.727416, -45.872165, 0.000007, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1953.433105, 817.728271, -45.872165, 0.000007, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1947.381835, 808.728332, -45.872177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1943.822509, 808.738342, -45.872177, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1953.440429, 808.747802, -45.872165, 0.000007, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 1944.235351, 813.637084, -44.078113, 0.000000, 89.999969, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 1954.727661, 813.637084, -44.078109, 0.000000, 89.999969, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19371, 1940.926269, 808.749938, -46.102180, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	jailint = CreateDynamicObject(19457, 1952.121459, 813.467834, -43.380168, 0.000000, 179.999984, -90.000030, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19371, 1942.798095, 817.048034, -49.352188, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(338, 1941.500366, 812.865722, -47.339408, 0.000000, -15.099980, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	jailint = CreateDynamicObject(338, 1940.844116, 812.865722, -47.288822, 0.000000, 16.000011, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	jailint = CreateDynamicObject(338, 1941.210449, 812.393066, -47.286987, 0.000007, 16.000003, 90.699974, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	jailint = CreateDynamicObject(3657, 1951.353149, 817.456298, -47.122173, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 19962, "samproadsigns", "materialtext1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 19962, "samproadsigns", "materialtext1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1954.082275, 817.707397, -48.142181, 0.000007, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(3657, 1955.074096, 817.446044, -47.122173, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 19962, "samproadsigns", "materialtext1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 19962, "samproadsigns", "materialtext1", 0x00000000);
	jailint = CreateDynamicObject(2435, 1946.808959, 813.067260, -47.622180, 0.000000, -0.000007, -179.900039, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1945.878051, 813.065612, -47.622180, 0.000000, -0.000007, -179.900039, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1944.947143, 813.063842, -47.622180, 0.000000, -0.000007, -179.900039, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1944.016235, 813.062194, -47.622180, 0.000000, -0.000007, -179.900039, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1943.234252, 809.223083, -47.622180, -0.000007, 0.000000, -89.900016, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1943.233642, 810.153686, -47.622180, -0.000007, 0.000000, -89.900016, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2435, 1943.232177, 811.083862, -47.622180, -0.000007, 0.000000, -89.900016, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2265, 1943.635375, 810.807800, -46.272560, 0.000007, -88.999984, 90.299964, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18646, "matcolours", "grey-60-percent", 0x00000000);
	jailint = CreateDynamicObject(19438, 1951.384521, 813.436218, -45.922172, 0.000007, 0.000000, 90.100036, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1956.015380, 813.444580, -45.922172, 0.000007, 0.000000, 90.100036, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1951.363891, 808.598205, -45.872177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(1800, 1947.961303, 807.854431, -47.632179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 1951.962890, 807.854431, -47.632179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 1955.993652, 807.854431, -47.632179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2611, 1944.287231, 808.877685, -45.592174, 0.000000, -0.000007, 179.899963, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 3, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	jailint = CreateDynamicObject(2435, 1943.335571, 813.050781, -47.632179, 0.000000, -0.000007, -179.900039, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2265, 1942.667724, 810.077697, -46.265178, -0.000007, -90.699958, -88.900001, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(19631, 1943.129760, 810.437866, -46.703887, 89.200088, 179.999450, -179.999450, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(19893, 1943.337524, 809.815917, -46.572181, 0.000007, 0.000000, 104.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 19894, "laptopsamp1", "laptopscreen2", 0x00000000);
	jailint = CreateDynamicObject(19371, 1945.989135, 817.048034, -49.352188, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(2265, 1945.328125, 812.660156, -46.262176, 0.000000, -89.999984, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18646, "matcolours", "grey-60-percent", 0x00000000);
	jailint = CreateDynamicObject(2265, 1946.946166, 812.493286, -46.262176, -0.000003, -89.999984, -24.300001, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18646, "matcolours", "grey-60-percent", 0x00000000);
	jailint = CreateDynamicObject(2265, 1944.601074, 813.637329, -46.262176, 0.000000, -90.000000, -179.800109, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(2265, 1946.689208, 813.686462, -46.262176, 0.000003, -90.000000, 156.199768, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(11712, 1943.145874, 810.725219, -46.372173, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "redlaser", 0x00000000);
	jailint = CreateDynamicObject(11712, 1945.236938, 813.146728, -46.362171, -0.000007, 0.000000, -87.899955, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "redlaser", 0x00000000);
	jailint = CreateDynamicObject(11712, 1947.071166, 812.978332, -46.362171, -0.000006, -0.000003, -114.299972, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "redlaser", 0x00000000);
	jailint = CreateDynamicObject(19631, 1944.959106, 813.168579, -46.643375, 89.800201, 179.997802, -179.997802, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(19631, 1946.820434, 813.103820, -46.643600, 89.800201, 153.897796, -179.997802, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(19827, 1944.962402, 813.174377, -46.560955, 89.099945, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(19827, 1946.815551, 813.099487, -46.531429, 89.099945, 0.000209, 64.499763, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "sampblack", 0x00000000);
	jailint = CreateDynamicObject(2612, 1939.050048, 810.061645, -45.572181, 0.000007, 0.000000, 90.200004, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	jailint = CreateDynamicObject(1800, 1950.482177, 807.854431, -47.632179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 1955.993652, 807.854431, -46.662181, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 1951.962890, 807.854431, -46.682174, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2258, 1941.606689, 817.626098, -45.432178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 19165, "gtamap", "gtasamapbit4", 0x00000000);
	jailint = CreateDynamicObject(2258, 1944.767089, 817.626098, -45.432178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 19165, "gtamap", "gtasavectormap1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19894, "laptopsamp1", "laptopscreen1", 0x00000000);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -44.742168, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -45.122161, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -45.542179, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -46.422142, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -44.932128, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 135, 0, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -45.332115, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 135, 0, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -45.742069, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 135, 0, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -46.202087, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 135, 0, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -45.962165, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.272338, 808.842285, -45.062210, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "6'4''", 140, "Ariel", 27, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.272338, 808.842285, -45.422180, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "6'2''", 140, "Ariel", 27, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.272338, 808.842285, -45.862125, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "6'0''", 140, "Ariel", 27, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.272338, 808.842285, -46.282066, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "5'8''", 140, "Ariel", 27, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -44.792053, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "M", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.272338, 808.842285, -46.751995, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "5'6''", 140, "Ariel", 27, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -45.122005, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "U", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -45.481990, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "G", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -45.821949, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "S", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -46.191913, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "H", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -46.581886, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "O", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1939.531250, 808.842285, -46.941860, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "T", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1941.538452, 817.344787, -47.582164, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "1", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1944.271118, 817.334777, -47.582164, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "3", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1942.959838, 817.344787, -47.582164, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "2", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1945.592407, 817.324768, -47.582164, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "4", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1946.993774, 817.324768, -47.582164, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "5", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 1940.911010, 808.861267, -46.662052, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "___", 140, "Ariel", 135, 0, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(19859, 1939.030883, 817.031250, -46.352176, -0.000007, 0.000000, -90.199989, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19623, 1941.251708, 812.780456, -46.152172, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19302, 1950.111694, 813.474853, -46.362178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19302, 1954.761230, 813.474853, -46.362178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(638, 1939.304687, 813.050720, -46.962177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(638, 1956.385986, 815.421142, -46.962177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1953.860229, 817.077575, -43.944072, 15.099995, 0.000007, -0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1949.429443, 817.124755, -44.003837, 15.099995, 0.000007, -0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1946.964355, 809.178833, -43.952175, -0.000003, -0.000003, -133.199981, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2055, 1947.270996, 812.765380, -45.172180, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11713, 1939.015502, 814.675598, -45.962181, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2615, 1956.756469, 815.703247, -45.512176, -0.000007, 0.000000, -89.899978, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1939.240844, 811.417297, -47.632183, 0.000007, 0.000000, 89.799957, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19302, 1956.062011, 813.474853, -46.362178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2614, 1947.220703, 811.079956, -45.142177, -0.000007, 0.000000, -89.199966, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2164, 1946.779296, 808.868591, -47.612182, 0.000000, -0.000007, -179.499938, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1943.310180, 810.685058, -43.832172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1943.288940, 814.825195, -43.852172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1948.959838, 814.854431, -43.852172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1955.260498, 814.887573, -43.852172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2007, 1944.564453, 809.305664, -47.642185, 0.000000, -0.000007, -179.899963, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2602, 1950.877563, 812.647949, -47.092475, -0.000007, 0.000000, -89.899909, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2602, 1956.117309, 812.951599, -47.096244, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1897, 1943.233886, 810.355834, -47.682186, 0.000007, 0.000000, 90.599960, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1897, 1943.232421, 810.475830, -47.682186, 0.000007, 0.000000, 90.599960, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1943.354370, 810.911804, -46.472171, 0.000006, 0.000003, 65.399993, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19808, 1943.414184, 810.432983, -46.552169, 0.000007, 0.000000, 90.099922, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2163, 1947.293701, 811.377685, -47.622180, -0.000007, 0.000000, -89.899955, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19807, 1944.372070, 813.088989, -46.522178, 0.000000, 0.000007, 15.199997, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19807, 1946.173461, 813.059143, -46.522178, 0.000000, 0.000007, -0.699997, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19835, 1945.452514, 813.065612, -46.482170, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19835, 1945.973022, 813.065612, -46.482170, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19835, 1943.320922, 811.095336, -46.482170, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19808, 1944.971679, 812.872192, -46.552169, 0.000000, 0.000007, 0.299950, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19808, 1946.716552, 812.890441, -46.552169, -0.000003, 0.000006, -25.200037, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1947.116821, 811.668640, -46.502174, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1947.116821, 811.408386, -46.502174, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1945.298217, 809.069702, -47.262184, 0.000000, -0.000007, 178.399948, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1950.155151, 817.610046, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1951.336181, 817.622070, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1952.586181, 817.635070, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1954.016235, 817.629943, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1954.916748, 817.639343, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19418, 1955.837646, 817.628967, -47.022178, 0.000007, 0.000000, 90.599998, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1549, 1943.838623, 809.093322, -47.612182, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1549, 1956.596313, 813.824035, -47.612182, 0.000007, 0.000000, 94.299949, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2050, 1947.645996, 817.595764, -45.342170, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2055, 1950.293090, 817.616027, -45.302181, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2055, 1953.633666, 817.616027, -45.302181, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1671, 1944.577636, 810.346679, -47.172180, -0.000007, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1671, 1945.020629, 811.965393, -47.172180, -0.000000, -0.000007, -161.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2855, 1943.212890, 813.001708, -46.652179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1948.982299, 810.744506, -43.852172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19873, 1951.058105, 812.791870, -46.622177, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19873, 1955.978393, 813.172241, -46.632179, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1953.880126, 810.809326, -43.852172, 0.000007, 0.000000, 90.299911, -1, -1, -1, 300.00, 300.00);
    arrestcell[0] = CreateDynamicObject(19302, 1948.366577, 813.474853, -46.362178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    arrestcell[1] = CreateDynamicObject(19302, 1950.111694, 813.474853, -46.362178, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);

	//BlockA
    jailint = CreateDynamicObject(19379, 210.490844, 1881.759643, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.490844, 1891.389038, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.490844, 1901.017822, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 220.980850, 1881.779663, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 220.980850, 1891.409667, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 220.980850, 1901.008178, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 231.480941, 1881.779663, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 231.480941, 1891.399536, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 231.480941, 1901.028808, 1373.491455, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 205.230911, 1901.005371, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.230911, 1891.366210, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.230911, 1881.755615, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 210.131042, 1905.895019, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 219.741104, 1905.895019, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.351226, 1905.895019, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.540969, 1891.395385, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.540969, 1901.005981, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 212.590927, 1884.146240, 1375.308471, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 222.220932, 1884.146240, 1375.308471, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 222.220932, 1884.146240, 1378.789184, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 222.211105, 1876.955810, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 212.590927, 1884.146240, 1378.788085, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 202.970901, 1876.955810, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 231.830947, 1884.146240, 1375.308471, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 210.290878, 1881.205932, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 231.830871, 1884.146240, 1378.789184, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1887.685424, 1375.307983, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1890.885131, 1375.307983, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1894.084960, 1375.307983, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1897.284545, 1375.307983, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1900.494628, 1375.307983, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1900.494628, 1378.799072, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1897.284790, 1378.799072, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1894.093872, 1378.799072, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1890.874267, 1378.799072, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 210.295959, 1887.664550, 1378.799072, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.540969, 1881.765991, 1375.307373, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.540969, 1891.376098, 1378.798095, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 210.290878, 1881.186401, 1378.796875, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 205.111022, 1881.869506, 1376.973266, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 205.111022, 1891.489257, 1376.973266, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 205.111022, 1901.098754, 1376.973266, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 210.290878, 1906.905273, 1378.796875, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.540969, 1881.766601, 1378.798095, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.561019, 1886.066528, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.551055, 1889.287109, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541046, 1892.506958, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541046, 1892.506958, 1378.795898, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541107, 1895.667480, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541183, 1898.907470, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541183, 1901.896972, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541183, 1901.896972, 1378.807373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541183, 1898.907470, 1378.807617, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.541107, 1895.667480, 1378.807373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.551055, 1889.287109, 1378.797607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.561019, 1886.066528, 1378.797729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 213.535980, 1902.184814, 1375.297851, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 213.535980, 1902.184814, 1378.826660, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 207.131210, 1902.184448, 1378.817626, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 216.736038, 1902.184814, 1375.297729, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 211.167068, 1900.717285, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1897.218017, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1893.728759, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1890.249023, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1886.759277, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1883.279907, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1879.789916, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(19428, 211.167068, 1876.299682, 1376.980590, 0.000000, 90.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(13011, 212.503280, 1890.095214, 1373.680908, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19394, 216.736038, 1902.184814, 1378.818115, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 219.925994, 1902.184814, 1378.817871, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 219.925994, 1902.184814, 1375.307373, 0.000014, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 211.945129, 1890.140625, 1377.513427, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 211.945129, 1894.300292, 1377.513427, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 214.015167, 1900.559448, 1377.513427, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 207.131210, 1902.184448, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.230911, 1884.295776, 1378.828369, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.230911, 1893.885742, 1378.828369, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 205.230911, 1903.505615, 1378.828369, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(12839, 222.747711, 1900.027832, 1374.136108, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 215.171218, 1905.895019, 1378.797485, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 224.771163, 1905.895019, 1378.797485, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 229.540969, 1901.005981, 1378.798095, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 211.945129, 1898.459350, 1377.513427, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19394, 223.135986, 1902.184814, 1375.307495, 0.000007, 0.000000, 89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 223.135986, 1902.184814, 1378.808471, 0.000007, 0.000000, 89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 213.717117, 1901.337768, 1376.980590, 0.000000, 90.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19379, 217.010940, 1906.956909, 1376.972290, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 227.500976, 1906.956909, 1376.972290, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19428, 217.217147, 1901.337768, 1376.980590, 0.000000, 90.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 220.717193, 1901.337768, 1376.980590, 0.000000, 90.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 224.217208, 1901.337768, 1376.980590, 0.000000, 90.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 227.687210, 1901.337768, 1376.980590, 0.000000, 90.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.541259, 1902.185058, 1378.797485, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 224.841293, 1906.944824, 1378.787475, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 221.501281, 1906.934814, 1378.787475, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 218.341384, 1907.004882, 1378.787475, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 215.131378, 1906.935180, 1378.787475, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 211.881362, 1907.064086, 1378.787475, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 224.841293, 1906.914794, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 221.531387, 1906.925170, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 218.351425, 1906.945190, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 215.081390, 1906.915405, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 212.051330, 1906.935424, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 231.351226, 1902.204589, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 218.185211, 1900.559448, 1377.513427, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 222.355270, 1900.559448, 1377.513427, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 229.415267, 1900.559448, 1377.513427, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 217.640914, 1884.146240, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 218.532440, 1888.874267, 1375.287963, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 222.591033, 1884.146240, 1375.308471, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 220.102569, 1888.874267, 1375.287963, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 221.702682, 1888.874267, 1375.287963, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19367, 220.916488, 1887.191894, 1375.989379, 0.000000, 90.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 220.916488, 1883.991699, 1375.979614, 0.000000, 90.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 219.446578, 1883.991699, 1375.978515, 0.000000, 90.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 219.446578, 1887.191772, 1375.979492, 0.000000, 90.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 222.581039, 1884.106201, 1377.349121, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19446, 217.661117, 1884.126220, 1377.329101, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19428, 218.532440, 1888.854248, 1377.329467, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 220.132476, 1888.854248, 1377.329467, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 221.702438, 1888.854248, 1377.329467, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 222.591033, 1884.146240, 1380.668090, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0x00000000);
	jailint = CreateDynamicObject(19428, 221.702682, 1888.874267, 1380.668701, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 220.102630, 1888.874267, 1380.668701, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 218.502624, 1888.874267, 1380.668701, 180.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 217.640914, 1884.146240, 1380.668823, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 224.210754, 1888.988647, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.210754, 1898.598388, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.210754, 1908.206542, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 213.720809, 1908.206542, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 213.720809, 1898.587768, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 203.240722, 1898.587768, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 203.260711, 1888.977783, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 213.770629, 1888.977783, 1380.562744, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(1533, 220.982711, 1884.267211, 1376.046875, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 231.371231, 1902.304687, 1375.307373, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.511352, 1907.193847, 1375.307373, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.761306, 1905.843994, 1375.307373, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 224.931411, 1907.084472, 1375.307373, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.791381, 1904.054199, 1373.507446, 0.000000, 90.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 229.791381, 1904.054199, 1376.828002, 0.000000, 90.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19517, "noncolored", "gen_white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19379, 223.436264, 1894.308715, 1368.337280, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 218.536224, 1899.029663, 1368.337280, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 218.536224, 1889.578857, 1368.337280, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 213.816207, 1894.309082, 1368.337280, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 229.366073, 1889.047485, 1368.337280, 0.000000, 360.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.526046, 1884.316406, 1368.337280, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 212.765960, 1884.316406, 1368.337280, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 229.366073, 1898.566162, 1368.337280, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 229.726089, 1902.196899, 1368.337280, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.475967, 1902.026733, 1368.337280, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 214.865890, 1902.026733, 1368.337280, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.475891, 1897.217041, 1368.337280, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.475891, 1887.607666, 1368.337280, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 217.475891, 1884.316650, 1368.337280, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 222.785903, 1884.316650, 1368.337280, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 221.248092, 1889.046020, 1371.837158, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 219.138122, 1889.046020, 1371.837158, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19379, 234.686126, 1889.047485, 1380.398315, 0.000000, 270.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 234.686126, 1898.678222, 1380.398315, 0.000000, 270.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.626007, 1878.987060, 1380.398315, 0.000000, 90.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 215.005935, 1878.987060, 1380.398315, 0.000000, 90.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 224.655899, 1902.177856, 1385.569946, 0.000000, 360.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 215.045852, 1902.177856, 1385.569946, 0.000000, 360.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.305801, 1897.298583, 1385.569946, 0.000000, 360.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 210.305801, 1887.699340, 1385.569946, 0.000000, 360.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 217.545806, 1884.128417, 1385.569946, 0.000000, 360.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 217.645736, 1884.128417, 1385.569946, 0.000000, 360.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 222.565673, 1884.128417, 1385.569946, 0.000000, 360.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 222.595672, 1884.128417, 1385.569946, 0.000000, 360.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 219.068161, 1888.895874, 1382.067749, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 221.078079, 1888.895874, 1382.067749, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 221.078079, 1888.865844, 1382.067749, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 219.328109, 1888.865844, 1382.067749, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(1968, 221.466262, 1896.974487, 1374.097656, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 215.516326, 1896.974487, 1374.097656, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 215.516326, 1891.744506, 1374.097656, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 221.516281, 1891.744506, 1374.097656, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 218.426300, 1894.454467, 1374.097656, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1280, 229.016311, 1895.031494, 1373.947387, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 229.016311, 1897.701171, 1373.947387, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 229.016311, 1890.061157, 1373.947387, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 229.016311, 1887.440673, 1373.947387, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 223.889541, 1902.127319, 1373.577392, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 220.649597, 1902.127319, 1373.577392, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 217.469696, 1902.127319, 1373.577392, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 214.189743, 1902.127319, 1373.577392, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 214.259719, 1902.127319, 1377.047607, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 217.319656, 1902.127319, 1377.047607, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 220.599563, 1902.127319, 1377.047607, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 223.929504, 1902.127319, 1377.047607, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949600, 1900.996704, 1377.047607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949600, 1897.986938, 1377.047607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949600, 1894.775878, 1377.047607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949600, 1891.605346, 1377.047607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949600, 1888.384399, 1377.047607, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949645, 1901.015014, 1373.547729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949645, 1898.035278, 1373.547729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949645, 1894.784667, 1373.547729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949645, 1891.584594, 1373.547729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 208.949645, 1888.413940, 1373.547729, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(2602, 222.005401, 1904.493896, 1374.077148, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 218.835540, 1904.493896, 1374.077148, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 215.545623, 1904.493896, 1374.077148, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 212.515609, 1904.493896, 1374.077148, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 212.355667, 1904.493896, 1377.569458, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 215.615692, 1904.493896, 1377.569458, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 218.815704, 1904.493896, 1377.569458, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 221.985748, 1904.493896, 1377.569458, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1899.393188, 1377.569458, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1896.132202, 1377.569458, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1892.981079, 1377.569458, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1889.789794, 1377.569458, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1886.529052, 1377.569458, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1886.529052, 1374.078002, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1889.738037, 1374.078002, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1892.998657, 1374.078002, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1896.120117, 1374.078002, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 207.775955, 1899.351074, 1374.078002, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(18633, 226.584457, 1905.277587, 1376.173706, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 227.404479, 1905.277587, 1376.173706, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 228.304489, 1905.277587, 1376.173706, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 228.424468, 1902.606201, 1376.173706, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 227.484451, 1902.606201, 1376.173706, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19428, 217.685897, 1887.087768, 1376.255493, 90.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 217.685897, 1883.627685, 1376.255493, 90.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 222.415832, 1883.627685, 1376.255493, 90.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 222.415832, 1887.057739, 1376.255493, 90.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 220.765777, 1888.758056, 1376.255493, 90.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 219.475784, 1888.738037, 1376.255493, 90.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(2606, 220.024368, 1888.431274, 1379.550659, 28.200000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 221.810729, 1886.797973, 1376.075317, 0.000000, 0.000000, -90.199996, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 219.473617, 1888.066528, 1376.075317, 0.000000, 0.000000, -1.199995, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(19481, 229.445327, 1892.543334, 1377.587890, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 229.435333, 1892.542846, 1377.578369, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 229.445327, 1892.581542, 1376.709106, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 229.395339, 1892.522827, 1376.709106, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1887.782836, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1887.782836, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1890.923217, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1890.923217, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1894.144165, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1894.144165, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1897.294677, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1897.294677, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1900.524902, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.395172, 1900.524902, 1376.387573, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 213.485168, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 213.485168, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 216.715103, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 216.715103, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 219.925003, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 219.925003, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 223.134933, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 223.134933, 1902.076049, 1376.387573, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 223.134933, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 223.134933, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 220.014892, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 220.014892, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 216.764877, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 216.764877, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 213.524932, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 213.524932, 1902.076049, 1379.848022, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1900.545776, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1900.545776, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1897.335571, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1897.335571, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1894.134643, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1894.134643, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1890.923706, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1890.923706, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1887.723144, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 210.414871, 1887.723144, 1379.848022, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2608, 218.023590, 1887.230346, 1376.684936, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 226.052551, 1884.267211, 1373.577392, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 227.552658, 1884.267211, 1373.577392, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 215.360595, 1884.234863, 1374.817382, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 220.770980, 1895.249633, 1380.437255, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 230.253524, 1884.549682, 1380.452514, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 213.546066, 1884.233642, 1375.437622, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11710, 226.396728, 1884.247924, 1376.507446, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 225.787170, 1884.255615, 1376.507446, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 220.116287, 1886.719238, 1376.075317, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 229.048675, 1902.183471, 1379.749511, 0.000000, 0.000000, 65.900001, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 211.106582, 1884.136596, 1379.770507, 0.000000, 0.000000, -80.599990, 7, -1, -1, 600.00, 600.00);
    jailint = CreateDynamicObject(19327, 210.394927, 1887.737304, 1376.345214, 0.700000, 0.099999, 91.100196, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A01", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.393051, 1890.941772, 1376.342651, 0.700000, 0.099999, 91.100196, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A02", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.412979, 1894.104736, 1376.338989, 0.700000, 0.099999, 91.100196, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A03", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.401611, 1897.278686, 1376.335815, 0.700000, 0.099999, 91.100196, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A04", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.408493, 1900.552246, 1376.330688, 0.700000, 0.099999, 91.100196, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A05", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 213.561920, 1901.974121, 1376.341674, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A06", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 216.741058, 1902.037475, 1376.337524, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A07", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 219.940689, 1902.071655, 1376.333007, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A08", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 223.141098, 1902.065307, 1376.329345, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A09", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 223.146972, 1902.063476, 1379.761718, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A17", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 219.917358, 1902.049438, 1379.763549, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A16", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 216.736785, 1902.076049, 1379.766845, 0.700000, 0.099999, 361.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A15", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.414642, 1900.585083, 1379.811889, 0.700000, 0.099999, 451.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A14", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.406814, 1897.371459, 1379.814819, 0.700000, 0.099999, 451.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A13", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.408920, 1894.138305, 1379.820068, 0.700000, 0.099999, 451.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A12", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.411239, 1890.904418, 1379.823364, 0.700000, 0.099999, 451.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A11", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 210.393524, 1887.660522, 1379.827636, 0.700000, 0.099999, 451.100189, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A10", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 229.404251, 1894.751708, 1377.449584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 229.404251, 1890.458740, 1377.449584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);


	//Block A Doors
	blockA [0] = CreateDynamicObject(3089, 220.658752, 1902.126586, 1374.677978, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [0], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [1]  = CreateDynamicObject(3089, 223.858810, 1902.126586, 1374.677978, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [1], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [2]  = CreateDynamicObject(3089, 217.448822, 1902.126586, 1374.677978, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [2], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [3]  = CreateDynamicObject(3089, 214.258728, 1902.126586, 1374.677978, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [3], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [4]  = CreateDynamicObject(3089, 214.258728, 1902.126586, 1378.197998, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [4], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [5]  = CreateDynamicObject(3089, 217.458740, 1902.126586, 1378.197998, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [5], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [6]  = CreateDynamicObject(3089, 220.648788, 1902.126586, 1378.197998, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [6], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [7]  = CreateDynamicObject(3089, 223.858734, 1902.126586, 1378.197998, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [7], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [8]  = CreateDynamicObject(3089, 210.288848, 1901.256225, 1378.197998, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [8], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [9]  = CreateDynamicObject(3089, 210.288848, 1898.046264, 1378.197998, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [9], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [10]  = CreateDynamicObject(3089, 210.288848, 1894.856811, 1378.197998, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [10], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [11]  = CreateDynamicObject(3089, 210.288848, 1891.635864, 1378.197998, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [11], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [12]  = CreateDynamicObject(3089, 210.288848, 1888.425292, 1378.197998, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [12], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [13]  = CreateDynamicObject(3089, 210.288848, 1888.445312, 1374.697753, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [13], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [14]  = CreateDynamicObject(3089, 210.288848, 1891.646118, 1374.697753, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [14], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [15]  = CreateDynamicObject(3089, 210.288848, 1894.846679, 1374.697753, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [15], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [16]  = CreateDynamicObject(3089, 210.288848, 1898.047363, 1374.697753, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [16], 2, 18901, "matclothes", "beretred", 0x00000000);
	blockA [17]  = CreateDynamicObject(3089, 210.288848, 1901.258056, 1374.697753, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockA [17], 2, 18901, "matclothes", "beretred", 0x00000000);

	//BLOCK A LOBBY
	jailint = CreateDynamicObject(19379, 239.505599, 1711.788330, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1721.417968, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1711.788208, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1702.157714, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 239.607147, 1725.987426, -76.933288, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.447158, 1720.027343, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.187088, 1715.297485, -76.933288, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 253.517105, 1711.547607, -76.933288, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 253.517105, 1701.937377, -76.933288, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 237.687088, 1721.087646, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 237.687103, 1711.457519, -76.913276, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.027084, 1706.988037, -76.933288, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 230.387069, 1706.988037, -76.933288, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.767120, 1702.247680, -76.933288, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1692.527832, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505462, 1694.098266, -78.629226, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.037155, 1697.497680, -76.933288, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 235.217071, 1693.007812, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.057113, 1689.378051, -76.933288, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.687149, 1689.378051, -76.933288, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 248.287277, 1697.086914, -76.933288, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 252.847366, 1701.967407, -76.843276, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19385, 246.438369, 1701.966064, -76.843231, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 248.287277, 1687.456909, -76.933288, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1721.417968, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1711.797607, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1711.797607, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1702.167480, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1692.547485, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.495666, 1692.547485, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.495666, 1702.177856, -75.159248, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
	jailint = CreateDynamicObject(19446, 239.697128, 1727.627685, -75.313270, 0.000015, 90.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.037139, 1721.167602, -75.313247, 0.000000, 89.999984, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.037139, 1711.547851, -75.313247, 0.000000, 89.999984, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.037155, 1705.327880, -75.313247, -0.000015, 90.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 243.117156, 1702.257690, -75.313247, 0.000000, 89.999984, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.047073, 1699.147827, -75.313247, 0.000015, 90.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 233.557052, 1692.668212, -75.313247, 0.000000, 89.999984, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.017105, 1687.728271, -75.313247, -0.000015, 90.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.617126, 1687.728271, -75.313247, -0.000015, 90.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.947113, 1697.078125, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.947113, 1687.467895, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.657135, 1701.987060, -73.653266, 0.000015, 360.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.657135, 1701.947021, -73.653266, 0.000015, 360.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.167068, 1706.807861, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.167068, 1716.417236, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.447158, 1729.647338, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 246.107101, 1720.026611, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767120, 1718.146850, -79.363281, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.481094, 1716.045654, -79.373260, 0.000000, 180.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19387, 239.968627, 1715.303466, -76.903320, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.491088, 1717.416259, -79.373260, 0.000000, 180.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 233.577041, 1715.298339, -76.913291, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.777023, 1715.278320, -73.653274, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.777023, 1715.338378, -73.653274, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.177093, 1716.957641, -75.313293, 0.000015, 90.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 246.107101, 1729.606567, -75.313247, -0.000000, 90.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(1499, 240.712509, 1715.296264, -78.663307, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767120, 1718.146850, -74.183212, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.491088, 1717.416259, -74.183311, 0.000000, 180.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.481094, 1716.045654, -74.183273, 0.000000, 180.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767074, 1718.167602, -73.653266, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.521072, 1717.456298, -73.653312, 0.000000, 360.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.521072, 1716.026000, -73.653312, 0.000000, 360.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.441162, 1716.026000, -73.653312, 0.000000, 360.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.431167, 1717.246459, -73.653312, 0.000000, 360.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.537063, 1718.166381, -74.183280, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2260, 241.150863, 1715.870239, -77.023300, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "notice01", 0x00000000);
	jailint = CreateDynamicObject(19327, 244.341644, 1723.297973, -75.953315, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}SAN ANDREAS", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1720.918334, -75.953315, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}CORRECTIONAL", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1718.968627, -75.953315, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}FACILITY", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1722.538330, -76.373313, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RECIEVING", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1721.738769, -76.373313, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}AND", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1721.008178, -76.373313, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RELEASE", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1720.258544, -76.373313, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}UNIT", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1721.618774, -76.493324, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}___________________________________________________", 80, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19446, 235.127227, 1693.877685, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.477203, 1720.946411, -76.933288, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2612, 237.824508, 1721.387695, -76.603302, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2260, 243.880889, 1717.589965, -77.113304, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "KeepOut_64", 0x00000000);
	jailint = CreateDynamicObject(19369, 237.701324, 1711.146240, -77.153305, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.633277, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.853271, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1709.896850, -76.313323, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}79", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.133255, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.173248, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.123237, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.073219, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.303207, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.373214, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.433227, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.383277, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.543212, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.603202, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.663208, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.783218, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.833213, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -76.893218, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -77.013229, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -77.063224, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1711.147338, -77.113235, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1712.367187, -76.303245, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}1", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1712.367187, -76.563262, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}2", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1712.367187, -76.833282, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}3", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1712.377197, -77.063293, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}4", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1709.896850, -76.573341, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}49", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1709.896850, -76.813331, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}39", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1709.896850, -77.043319, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}29", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19368, 237.056060, 1711.145874, -78.443283, 0.000000, 90.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(2612, 239.434478, 1707.119750, -76.603302, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2616, 243.268234, 1707.120239, -76.723251, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2181, 251.167434, 1714.759521, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2612, 253.389404, 1707.203369, -76.653282, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 253.389404, 1712.883789, -76.653282, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2616, 249.133300, 1702.105468, -76.683280, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19327, 244.858642, 1704.625854, -76.283256, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2612, 248.129348, 1695.953613, -76.653282, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 248.129348, 1697.663940, -76.653282, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.497055, 1693.007812, -79.063293, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.447082, 1693.308349, -80.283309, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.447082, 1697.188354, -80.283309, -0.000015, 180.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19940, 242.414459, 1693.010375, -77.313278, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 240.444381, 1693.010375, -77.313278, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 238.454376, 1693.010375, -77.313278, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 236.464401, 1693.010375, -77.313278, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 234.464340, 1693.010375, -77.313278, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(2708, 239.277420, 1689.680053, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2708, 241.677490, 1689.680053, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(936, 243.214401, 1690.035522, -78.083290, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(19327, 235.351486, 1695.247802, -75.763259, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}PRISON ENTRANCE", 80, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(1499, 247.172439, 1701.995971, -78.603317, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1533, 241.136901, 1725.879394, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 239.646881, 1725.879394, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 238.244033, 1717.733398, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 241.074050, 1717.753417, -78.543289, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 241.557083, 1715.327392, -77.313278, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	entranceLobby [0] = CreateDynamicObject(19302, 243.301284, 1715.317871, -77.313262, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 245.047073, 1715.327392, -77.313278, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 245.047073, 1715.327392, -74.823280, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 241.557083, 1715.327392, -74.833259, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 243.297119, 1715.327392, -74.833259, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 241.169418, 1725.906616, -75.733291, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 238.614135, 1718.157104, -77.563308, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 241.514129, 1716.707153, -77.563308, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 238.678222, 1717.537719, -77.583328, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 240.888198, 1716.847534, -77.583328, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 237.552917, 1716.452026, -75.983291, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 237.552917, 1716.452026, -76.513290, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2010, 238.177413, 1714.795532, -78.543289, 0.000011, 0.000009, 49.999992, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1719.673828, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 238.769897, 1716.097290, -78.543289, -0.000011, 0.000009, -51.200000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 238.258163, 1725.481811, -78.073303, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 243.778213, 1725.481811, -78.073303, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2690, 237.899353, 1719.169067, -76.953308, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19611, 241.303192, 1711.121582, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19623, 241.292083, 1711.121704, -76.903327, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 241.393096, 1707.120361, -76.563308, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2308, 249.202102, 1713.739379, -78.543289, 0.000000, 0.000022, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 249.336334, 1714.910278, -77.773292, -0.000000, 0.000022, -1.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 249.225463, 1713.911621, -77.733276, 0.000022, 0.000000, 89.999931, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 250.418273, 1713.925903, -78.543289, 0.000022, 0.000000, 89.999931, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 251.788299, 1713.315673, -78.543289, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2174, 252.967620, 1704.992309, -78.543289, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2175, 252.958938, 1703.059448, -78.543289, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 251.496871, 1703.423461, -78.543289, -0.000013, 0.000006, -65.599983, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 253.025421, 1702.251342, -77.773292, -0.000009, -0.000012, -143.100006, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 252.845474, 1703.372070, -77.733276, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 249.451995, 1707.896118, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 250.451980, 1708.866210, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 242.611953, 1707.565673, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 250.138320, 1706.635620, -78.543289, -0.000000, 0.000015, -0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 249.918350, 1709.925903, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 241.998306, 1709.065551, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 247.186798, 1715.167480, -76.613281, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19787, 253.418899, 1710.068115, -76.633300, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2202, 252.964141, 1710.773925, -78.543289, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2700, 237.969558, 1714.741577, -76.034729, -0.000006, 15.200013, -23.600000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 247.256881, 1689.488647, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 245.367797, 1689.480590, -76.833267, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 235.326873, 1693.698730, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 235.326873, 1695.199096, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 241.529739, 1689.840942, -76.753273, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 240.539733, 1689.840942, -76.753273, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 239.079727, 1689.840942, -76.753273, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 238.139663, 1689.840942, -76.753273, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1689.837036, -78.303306, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1689.837036, -78.303306, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1689.837036, -78.303306, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1689.837036, -77.463294, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1689.837036, -77.983299, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1689.837036, -77.983291, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1689.837036, -77.453285, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1689.837036, -77.983314, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1689.837036, -77.453315, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 239.273941, 1689.761230, -78.303314, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.744003, 1689.761230, -78.303314, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.184036, 1689.761230, -78.003334, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.184036, 1689.761230, -77.463325, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.704040, 1689.761230, -77.463325, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 236.847854, 1689.599365, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 235.837890, 1689.599365, -78.543289, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 243.104568, 1689.179565, -77.613296, 0.000010, 0.000010, 44.999984, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 247.997207, 1692.512207, -78.043395, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 249.247177, 1702.251708, -78.043395, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 238.927169, 1707.312011, -78.043395, 0.000000, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 238.017181, 1722.191894, -78.043395, -0.000015, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 244.545578, 1715.050292, -78.543289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 245.106872, 1705.591674, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 235.536941, 1691.961425, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 235.942077, 1693.866821, -74.939231, 18.300012, -0.000003, 102.399955, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 246.541717, 1690.113403, -74.921684, 16.099998, -0.000015, 179.999908, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 252.942184, 1702.446166, -74.964241, 12.699987, -0.000011, -137.199996, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 244.011322, 1725.379516, -75.007385, 18.099988, 0.000013, -31.199991, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1723.874145, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1710.973876, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 247.666534, 1710.973876, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 247.666534, 1705.723754, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 245.966567, 1699.504028, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 245.966567, 1694.163818, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.176544, 1694.163818, -74.973289, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3657, 246.703109, 1714.817504, -78.033317, 0.000000, 0.000015, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1722.002197, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1722.672851, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1721.332031, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1720.681396, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 245.503265, 1714.984741, -78.178771, -37.799983, 90.000015, -0.199986, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 246.273300, 1714.981567, -78.178771, -37.799983, 90.000015, -0.199986, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 247.073226, 1714.978881, -78.178771, -37.799983, 90.000015, -0.199986, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 247.863159, 1714.976440, -78.178771, -37.799983, 90.000015, -0.199986, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1302, 238.092178, 1723.783569, -78.543289, 0.000015, 0.000000, 89.999954, 7, -1, -1, 600.00, 600.00);

	//BLCK A HODNIK
	jailint = CreateDynamicObject(19379, 254.871612, 1816.089477, 1402.666625, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 254.871612, 1806.480346, 1402.666625, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 254.871612, 1796.849975, 1402.666625, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 265.371459, 1801.320678, 1402.666625, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.104156, 1810.818481, 1404.402832, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.104156, 1820.448608, 1404.402832, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.234008, 1820.948486, 1404.402832, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.083938, 1816.089355, 1404.402832, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.083938, 1806.460693, 1404.402832, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.083938, 1796.851440, 1404.402832, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.863937, 1792.092041, 1404.402832, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 259.773956, 1793.101928, 1404.402832, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.493988, 1797.892578, 1404.402832, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 269.303924, 1801.362182, 1404.402832, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.834014, 1806.052124, 1404.402832, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19379, 255.351608, 1816.089477, 1406.197631, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 255.351608, 1806.469482, 1406.197631, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 255.351608, 1796.839965, 1406.197631, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 265.841705, 1800.039916, 1406.197631, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 265.841705, 1809.649902, 1406.197631, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.493988, 1801.642822, 1404.402832, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.253982, 1820.782592, 1401.013671, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.264068, 1815.902099, 1401.013671, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.264068, 1806.312255, 1401.013671, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.264068, 1796.692138, 1401.013671, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 254.923995, 1792.272216, 1401.013671, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 259.593963, 1793.302978, 1401.013671, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.333862, 1798.042724, 1401.013671, 0.000000, 0.000000, 810.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.443908, 1801.453735, 1401.013671, 0.000000, 0.000000, 810.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.443908, 1801.623901, 1401.013671, 0.000000, 0.000000, 810.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.443908, 1801.804077, 1401.013671, 0.000000, 0.000000, 810.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.833953, 1805.894287, 1401.013671, 0.000000, 0.000000, 810.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 269.123992, 1801.043090, 1401.013671, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 259.964019, 1810.622924, 1401.013671, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 259.964019, 1816.403320, 1401.013671, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.094055, 1810.763671, 1407.723510, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.094146, 1816.074462, 1407.723510, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.094146, 1806.454956, 1407.723510, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 251.094146, 1796.845458, 1407.723510, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.954116, 1792.105346, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.954116, 1820.945800, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.094055, 1820.353881, 1407.723510, 0.000000, 0.000000, 900.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.833984, 1806.034057, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.473968, 1797.903198, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 269.284057, 1802.802978, 1407.723510, 0.000000, 0.000000, 1080.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 259.764221, 1793.062988, 1407.723510, 0.000000, 0.000000, 1080.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.473968, 1801.633544, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 264.473968, 1801.663574, 1407.723510, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 251.749984, 1820.135620, 1403.072875, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 259.200042, 1793.345092, 1403.072875, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19172, 251.175582, 1807.746093, 1404.562988, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	jailint = CreateDynamicObject(19172, 260.015380, 1808.896728, 1404.562988, 0.000000, 0.000000, 630.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 252.775375, 1792.177734, 1404.562988, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10023, "bigwhitesfe", "lomall_ext2_", 0x00000000);
	jailint = CreateDynamicObject(19385, 260.583709, 1803.331787, 1404.392700, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.574157, 1809.753295, 1404.402832, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19385, 260.583709, 1799.940673, 1404.392700, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 260.574035, 1793.542846, 1404.372802, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19430, 262.258941, 1802.663818, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 262.258941, 1804.263916, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 262.258941, 1805.823974, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 265.748840, 1805.803955, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 269.248840, 1805.823974, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 269.198791, 1804.223388, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 269.208862, 1802.623657, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 265.708862, 1802.623657, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 265.708862, 1804.204101, 1402.672485, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
    jailint = CreateDynamicObject(19482, 262.978851, 1805.944458, 1404.378540, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 265.649169, 1805.944458, 1404.378540, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "A", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 264.588989, 1801.540649, 1404.378540, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "LAUNDRY", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 251.218719, 1802.532592, 1405.569702, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "KITCHEN", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 251.218719, 1812.445190, 1405.569702, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "LIBRARY", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 255.668914, 1820.802246, 1405.629760, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "YARD", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1216, 259.714324, 1818.059204, 1403.313110, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 259.714324, 1817.328491, 1403.313110, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 259.714324, 1816.597900, 1403.313110, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 255.593597, 1820.863525, 1403.993774, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 255.968490, 1792.204833, 1402.752563, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 251.208389, 1801.025146, 1402.752563, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 251.208389, 1811.635498, 1402.752563, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 259.988342, 1813.156494, 1402.752563, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 251.208389, 1802.515869, 1402.752563, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 251.208389, 1795.065063, 1402.752563, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 255.415603, 1795.593994, 1406.523925, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	hallDoors [0] = CreateDynamicObject(1495, 260.545715, 1802.626953, 1402.752563, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	hallDoors [1] = CreateDynamicObject(1495, 260.545715, 1800.716918, 1402.752563, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 255.415603, 1803.844238, 1406.523925, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 255.415603, 1811.263793, 1406.523925, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 255.415603, 1818.143676, 1406.523925, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 264.765502, 1803.654174, 1406.523925, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 264.765502, 1799.853637, 1406.523925, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 251.473144, 1792.784667, 1406.301635, 19.700000, 0.000000, 154.400024, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 259.513366, 1820.168945, 1406.319091, 20.599996, 0.000000, -34.799983, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 266.248443, 1805.936035, 1402.752563, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 268.468444, 1798.005737, 1402.752563, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 264.318511, 1798.005737, 1402.752563, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 257.468536, 1792.204833, 1402.752563, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 265.619964, 1797.979492, 1404.292480, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);

	//BLOCK A KITCHEN
	jailint = CreateDynamicObject(19379, 1152.049926, 1557.615966, 2092.408447, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.551269, 1557.615966, 2092.408447, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 1173.050415, 1557.615966, 2092.408447, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	jailint = CreateDynamicObject(19379, 1152.049926, 1547.995605, 2092.408447, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.551269, 1547.995605, 2092.408447, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 1173.050415, 1547.995605, 2092.408447, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	jailint = CreateDynamicObject(19457, 1146.828125, 1548.028198, 2094.245117, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1146.828125, 1557.638061, 2094.245117, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1151.717163, 1562.498413, 2094.245117, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1161.326904, 1562.498413, 2094.245117, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1170.956787, 1562.498413, 2094.245117, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1151.717163, 1543.198730, 2094.245117, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1161.326904, 1543.198730, 2094.245117, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1170.956787, 1543.198730, 2094.245117, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1545.893676, 2093.014892, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1547.273803, 2093.014892, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1548.654296, 2093.014892, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1550.034790, 2093.014892, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1555.614990, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1556.995117, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1558.375610, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1153.132812, 1559.756103, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1545.893676, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1547.273803, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1548.654296, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1550.034790, 2093.014892, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1555.614990, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1556.995117, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1558.375610, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1157.343627, 1559.756103, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1545.893676, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1547.273803, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1548.654296, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1550.034790, 2093.014892, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1555.614990, 2093.014892, 0.000000, 0.000037, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1556.995117, 2093.014892, 0.000000, 0.000037, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1558.375610, 2093.014892, 0.000000, 0.000037, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(1968, 1161.164672, 1559.756103, 2093.014892, 0.000000, 0.000037, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(19457, 1156.081665, 1544.821044, 2090.752929, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1158.252319, 1544.821044, 2090.752929, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1156.081665, 1551.090942, 2090.752929, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1158.252319, 1551.090942, 2090.752929, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1156.081665, 1554.632080, 2090.752929, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1158.252319, 1554.632080, 2090.752929, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1156.081665, 1560.702758, 2090.752929, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1158.252319, 1560.702758, 2090.752929, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1165.872314, 1551.390869, 2090.752929, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1151.343505, 1559.188232, 2090.752685, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1151.343505, 1556.247680, 2090.752685, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1162.984497, 1559.188232, 2090.752685, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1162.984497, 1556.247680, 2090.752685, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1162.984497, 1549.416992, 2090.752685, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1162.984497, 1546.476440, 2090.752685, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1151.363403, 1549.416992, 2090.752685, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19371, 1151.363403, 1546.476440, 2090.752685, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1549.483276, 2092.494384, -0.000029, 0.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2449, 1167.548950, 1548.483642, 2092.494384, -0.000029, 0.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 2, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1550.483764, 2092.494384, -0.000029, 0.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1551.474609, 2092.494384, -0.000029, 0.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1552.474243, 2092.494384, -0.000037, 0.000000, -89.999885, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1553.474731, 2092.494384, -0.000037, 0.000000, -89.999885, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1554.465576, 2092.494384, -0.000037, 0.000000, -89.999885, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1555.465332, 2092.494384, -0.000045, 0.000000, -89.999862, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2446, 1167.585327, 1556.456176, 2092.494384, -0.000045, 0.000000, -89.999862, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(2449, 1167.548950, 1558.853515, 2092.494384, -0.000029, 0.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 2, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(19457, 1165.872314, 1554.342407, 2090.752929, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.077880, 1546.099487, 2094.245117, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.047851, 1559.420043, 2094.245117, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1167.317871, 1564.169433, 2094.245117, 0.000007, 0.000000, 179.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1167.317871, 1541.708984, 2094.245117, 0.000007, 0.000000, 179.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.798583, 1550.690917, 2094.245117, 0.000007, 0.000000, 179.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.798583, 1562.630615, 2094.245117, 0.000007, 0.000000, 179.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1180.345458, 1562.685302, 2094.351806, 270.000000, 270.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19457, 1146.828125, 1548.028198, 2097.737304, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1146.828125, 1557.638061, 2097.737304, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1151.717163, 1562.498413, 2097.737304, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1161.326904, 1562.498413, 2097.737304, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1170.956787, 1562.498413, 2097.737304, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1151.717163, 1543.198730, 2097.737304, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1161.326904, 1543.198730, 2097.737304, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1170.956787, 1543.198730, 2097.737304, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1564.166870, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1564.166870, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1541.685668, 2096.025634, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1541.685668, 2096.025634, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1144.937622, 1554.161376, 2096.035644, 0.000014, 90.000015, 89.999923, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1144.937622, 1543.671142, 2096.035644, 0.000014, 90.000015, 89.999923, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1562.955688, 2099.576171, 0.000000, 90.000015, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1562.955688, 2099.576171, 0.000000, 90.000015, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1542.726196, 2099.576171, 0.000000, 90.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1542.726196, 2099.576171, 0.000000, 90.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1145.938598, 1554.161376, 2099.586181, 0.000029, 90.000015, 89.999877, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1145.938598, 1543.671142, 2099.586181, 0.000029, 90.000015, 89.999877, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1558.202514, 2104.338623, 89.999992, 193.368530, -103.368469, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1558.202514, 2104.338623, 89.999992, 193.368530, -103.368469, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.105834, 1547.472412, 2104.338623, 89.999992, 193.368530, -103.368469, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.615600, 1547.472412, 2104.338623, 89.999992, 193.368530, -103.368469, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1150.669799, 1553.127929, 2104.338623, 89.999992, 248.836318, -68.836265, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1150.669799, 1542.637695, 2104.338623, 89.999992, 248.836318, -68.836265, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.649536, 1557.615966, 2101.661621, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "concretewall22_256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.150878, 1557.615966, 2101.661621, 0.000000, 90.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "concretewall22_256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1151.649536, 1547.995605, 2101.661621, 0.000000, 90.000015, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "concretewall22_256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1162.150878, 1547.995605, 2101.661621, 0.000000, 90.000015, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "concretewall22_256", 0x00000000);
	jailint = CreateDynamicObject(18769, 1157.935424, 1551.160888, 2100.228759, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	jailint = CreateDynamicObject(19379, 1167.318725, 1553.127929, 2104.338623, 89.999992, 259.069000, -79.068916, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1167.318725, 1542.637695, 2104.338623, 89.999992, 259.069000, -79.068916, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10856, "bakerybit_sfse", "ws_oldwarehouse10a", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.059570, 1554.161376, 2099.586181, 0.000037, 90.000015, 89.999855, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.059570, 1543.671142, 2099.586181, 0.000037, 90.000015, 89.999855, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.606445, 1564.166870, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.606445, 1554.546875, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.606445, 1544.925292, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19385, 1167.435058, 1560.960693, 2097.833251, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19385, 1167.435058, 1544.889160, 2097.833251, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.410888, 1548.222656, 2096.441894, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.430908, 1547.281860, 2097.823242, 360.000000, 180.000000, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.430908, 1551.712890, 2096.441894, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.430908, 1555.202880, 2096.441894, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.440917, 1558.462280, 2096.451904, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.410888, 1548.222656, 2099.614990, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.440917, 1548.222656, 2099.614990, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.430908, 1551.712890, 2099.614990, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.430908, 1555.202880, 2099.614990, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.440917, 1558.462280, 2099.625000, 89.999992, 89.999992, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1167.460937, 1558.603881, 2097.823242, 360.000000, 180.000000, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(18980, 1167.745849, 1555.715576, 2095.614501, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.916381, 1547.378051, 2097.737304, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.916381, 1557.007812, 2097.737304, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 1172.059570, 1564.650268, 2099.586181, 0.000037, 90.000015, 89.999855, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 10041, "archybuild10", "Upt_Conc floorClean", 0x00000000);
	jailint = CreateDynamicObject(19457, 1172.916381, 1566.637939, 2097.737304, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1151.401245, 1546.451171, 2096.441894, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1154.901611, 1546.451171, 2096.441894, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1158.401000, 1546.451171, 2096.441894, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1161.901977, 1546.451171, 2096.441894, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1165.402587, 1546.451171, 2096.441894, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1165.652832, 1546.441162, 2096.431884, 89.999992, 89.999992, 0.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1151.401245, 1559.391113, 2096.441894, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1154.901611, 1559.391113, 2096.441894, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1158.401000, 1559.391113, 2096.441894, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1161.901977, 1559.391113, 2096.441894, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1165.402587, 1559.391113, 2096.441894, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1165.652832, 1559.381103, 2096.431884, 89.999992, 134.999984, -44.999992, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1149.700195, 1557.729858, 2096.451904, 89.999992, 134.999984, 45.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1149.700195, 1554.229003, 2096.451904, 89.999992, 134.999984, 45.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1149.700195, 1550.728881, 2096.451904, 89.999992, 134.999984, 45.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19438, 1149.690185, 1548.108276, 2096.441894, 89.999992, 134.999984, 45.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(18633, 1166.977294, 1553.250366, 2093.355224, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(18633, 1166.977294, 1550.048706, 2093.355224, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(18633, 1166.977294, 1556.009277, 2093.355224, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(19089, 1167.058715, 1549.249023, 2093.365234, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(19089, 1166.928588, 1549.249023, 2093.365234, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(19089, 1166.818481, 1549.249023, 2093.365234, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 2887, "a51_spotlight", "stormdrain5_nt", 0x00000000);
	jailint = CreateDynamicObject(2420, 1163.696166, 1562.363891, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2420, 1163.035888, 1562.363891, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2420, 1150.004882, 1562.363891, 2092.494384, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2420, 1149.344604, 1562.363891, 2092.494384, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2420, 1149.304687, 1543.331787, 2092.494384, 0.000000, 0.000007, 179.999893, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2420, 1149.964965, 1543.331787, 2092.494384, 0.000000, 0.000007, 179.999893, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 16322, "a51_stores", "metalic128", 0x00000000);
	jailint = CreateDynamicObject(2604, 1167.966674, 1556.617065, 2096.872314, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2604, 1167.966674, 1552.947265, 2096.872314, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2604, 1167.966674, 1549.276977, 2096.872314, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2606, 1167.723754, 1557.285888, 2099.157714, 12.100011, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2606, 1167.723754, 1555.315551, 2099.157714, 12.100011, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2606, 1167.723754, 1553.335205, 2099.157714, 12.100011, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2606, 1167.723754, 1551.354614, 2099.157714, 12.100011, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2606, 1167.723754, 1549.374145, 2099.157714, 12.100011, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(19172, 1170.264648, 1543.298461, 2098.103027, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1559.112182, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1557.342041, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1555.571411, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1553.800903, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1552.030151, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(2163, 1172.838500, 1550.259277, 2096.111572, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 3629, "arprtxxref_las", "ws_corrugateddoor1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19438, 1179.575317, 1561.055786, 2092.419921, 180.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1179.575317, 1561.075805, 2094.652099, 180.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1178.844604, 1561.075805, 2092.750244, 270.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1180.345458, 1561.095825, 2092.750244, 270.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1180.345458, 1562.685302, 2092.750244, 270.000000, 270.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1545.532836, 2094.464843, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1548.233398, 2094.464843, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1557.014892, 2094.464843, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1559.715454, 2094.464843, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19438, 1178.844604, 1561.075805, 2094.351806, 270.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1180.345458, 1561.095825, 2094.341796, 270.000000, 270.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19438, 1180.345458, 1559.404174, 2095.362792, 270.000000, 270.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1789, 1169.866210, 1546.538696, 2093.054931, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1737, 1168.104614, 1550.787963, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(1737, 1168.104614, 1553.648437, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(1737, 1168.104614, 1556.339111, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 18901, "matclothes", "beretred", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1547.263183, 2098.007568, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1549.953125, 2098.007568, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1552.644409, 2098.007568, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1555.335937, 2098.007568, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1146.915893, 1558.026855, 2098.007568, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	jailint = CreateDynamicObject(19172, 1154.316284, 1562.397094, 2098.007568, 0.000007, 0.000000, 359.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 1160.596923, 1562.397094, 2098.007568, 0.000007, 0.000000, 359.999969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 1161.877929, 1543.295288, 2098.007568, 0.000007, 0.000000, 179.999862, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 1152.304687, 1543.295288, 2098.007568, 0.000007, 0.000000, 179.999862, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19379, 1183.105590, 1549.105590, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
	jailint = CreateDynamicObject(19379, 1183.105590, 1558.734741, 2096.025634, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jailint, 0, 4833, "airprtrunway_las", "greyground256", 0x00000000);
    jailint = CreateDynamicObject(2140, 1178.757812, 1558.777099, 2092.509277, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	movefridge[0] = CreateDynamicObject(2140, 1179.748779, 1558.777099, 2092.509277, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(movefridge[0], 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(movefridge[0], 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(movefridge[0], 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1537, 1146.947021, 1552.635253, 2092.494384, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1146.947021, 1554.135498, 2092.494384, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1163.397705, 1543.314453, 2092.494384, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1167.188110, 1559.974853, 2092.494384, 0.000014, 0.000000, 269.999938, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1171.198852, 1559.305419, 2092.494384, 0.000014, 0.000000, 359.999938, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3961, 1179.646240, 1555.445922, 2094.485839, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2649, 1165.648925, 1556.727294, 2101.114013, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2653, 1155.731079, 1551.436035, 2101.132080, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2653, 1155.731079, 1559.326171, 2101.132080, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2653, 1151.431152, 1556.416259, 2101.132080, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3675, 1166.162841, 1550.569824, 2101.926025, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3675, 1157.632934, 1550.569824, 2101.926025, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3470, 1162.585815, 1547.906005, 2104.320068, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2653, 1159.960815, 1553.835693, 2101.132080, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2653, 1163.621337, 1557.295288, 2101.142089, 0.000000, 180.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1159.297119, 1543.495971, 2092.494384, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1155.076538, 1543.495971, 2092.494384, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1155.076538, 1562.207153, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1159.297119, 1562.187500, 2092.494384, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18014, 1147.298339, 1557.908081, 2092.884765, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18014, 1147.298339, 1547.358154, 2092.884765, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1157.457397, 1543.314453, 2096.095458, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1155.967529, 1543.314453, 2096.095458, 0.000014, 0.000000, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1537, 1172.798339, 1545.434936, 2096.095458, 0.000014, 0.000000, 269.999938, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1808, 1172.602661, 1561.277587, 2096.111572, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1166.936645, 1551.139770, 2093.423828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.198486, 2093.593994, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.198486, 2093.654052, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.198486, 2093.714111, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.198486, 2093.774169, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.548828, 2093.593994, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.548828, 2093.654052, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.548828, 2093.714111, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.548828, 2093.774169, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.889160, 2093.593994, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.889160, 2093.654052, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.889160, 2093.714111, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19809, 1167.457153, 1549.889160, 2093.774169, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2425, 1167.620605, 1556.411987, 2093.515380, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19273, 1163.131713, 1543.233276, 2093.865722, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2416, 1172.140747, 1553.357788, 2092.484375, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2416, 1172.140747, 1551.496704, 2092.484375, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2416, 1172.140747, 1549.626220, 2092.484375, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2451, 1172.106811, 1547.744018, 2092.494384, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2419, 1172.145751, 1555.046875, 2092.494384, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2531, 1172.220581, 1558.538818, 2092.494384, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19325, 1167.410034, 1556.165405, 2100.793701, 89.999992, -89.999992, -90.000022, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19325, 1167.410034, 1552.045166, 2100.793701, 89.999992, -89.999992, -90.000022, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19325, 1167.410034, 1547.924926, 2100.793701, 89.999992, -89.999992, -90.000022, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1559.543701, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1558.223754, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1556.903320, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1555.582763, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1554.261596, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1552.940795, 2097.723144, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1560.015991, 2098.003417, 90.000000, 450.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1559.425415, 2098.003417, 90.000000, 450.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1558.784790, 2098.003417, 89.999992, 360.000000, -90.000022, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1558.194213, 2098.003417, 89.999992, 360.000000, -90.000022, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1557.583862, 2098.003417, 89.999992, 360.000000, -89.999992, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1556.993286, 2098.003417, 89.999992, 360.000000, -89.999992, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1556.382934, 2098.003417, 89.999992, 360.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1555.792358, 2098.003417, 89.999992, 360.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1555.191894, 2098.003417, 89.999992, 360.000000, -89.999969, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1554.601318, 2098.003417, 89.999992, 360.000000, -89.999969, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1554.000976, 2098.003417, 89.999992, 360.000000, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1553.410400, 2098.003417, 89.999992, 360.000000, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1552.819824, 2098.003417, 89.999992, 360.000000, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1551.620117, 2097.723144, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1552.219848, 2098.003417, 89.999992, 360.000061, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1551.629272, 2098.003417, 89.999992, 360.000061, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1550.298828, 2097.723144, -0.000014, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1551.018676, 2098.003417, 89.999992, 360.000091, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1550.428100, 2098.003417, 89.999992, 360.000091, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1172.827026, 1548.977539, 2097.723144, -0.000022, 0.000000, -89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1549.857543, 2098.003417, 89.999992, 360.000122, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(18637, 1172.817382, 1549.266967, 2098.003417, 89.999992, 360.000122, -89.999961, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2509, 1167.545532, 1559.323486, 2097.723144, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1558.946411, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1559.106567, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1559.256713, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1559.406860, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1559.557006, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(349, 1167.618774, 1559.707153, 2097.673095, 0.000000, -76.100067, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11729, 1169.282836, 1562.127929, 2096.081542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11729, 1169.973510, 1562.127929, 2096.081542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11729, 1170.654174, 1562.127929, 2096.081542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11729, 1171.344848, 1562.127929, 2096.081542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(11729, 1172.025512, 1562.127929, 2096.081542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1164.756835, 1543.387817, 2097.793212, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1148.015991, 1562.308593, 2097.793212, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1165.086303, 1562.308593, 2097.793212, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1148.015991, 1543.387817, 2097.793212, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1168.214355, 1558.008056, 2097.072509, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1168.214355, 1558.078125, 2097.072509, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1168.214355, 1558.138183, 2097.072509, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1168.214355, 1558.208251, 2097.072509, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19942, 1168.214355, 1558.268310, 2097.072509, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1560.156372, 2097.853271, 0.000000, 4.099990, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1559.565795, 2097.853271, 0.000000, 4.099990, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1558.975341, 2097.853271, 0.000000, 4.099990, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1558.325439, 2097.853271, 0.000000, 4.099984, 179.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1557.734863, 2097.853271, 0.000000, 4.099984, 179.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1557.144409, 2097.853271, 0.000000, 4.099984, 179.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1556.514770, 2097.853271, 0.000000, 4.099977, 179.999862, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1555.924194, 2097.853271, 0.000000, 4.099977, 179.999862, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1555.333740, 2097.853271, 0.000000, 4.099977, 179.999862, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1554.754028, 2097.853271, 0.000000, 4.099967, 179.999816, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1554.163452, 2097.853271, 0.000000, 4.099967, 179.999816, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1553.572998, 2097.853271, 0.000000, 4.099967, 179.999816, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1552.972778, 2097.853271, 0.000000, 4.099959, 179.999771, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1552.382202, 2097.853271, 0.000000, 4.099959, 179.999771, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1551.791748, 2097.853271, 0.000000, 4.099959, 179.999771, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1551.181030, 2097.853271, 0.000000, 4.099954, 179.999725, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1550.590454, 2097.853271, 0.000000, 4.099954, 179.999725, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1550.000000, 2097.853271, 0.000000, 4.099954, 179.999725, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1549.409423, 2097.853271, 0.000000, 4.099954, 179.999725, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(334, 1172.872192, 1548.828857, 2097.853271, 0.000000, 4.099954, 179.999725, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2040, 1172.110107, 1562.119995, 2098.222412, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2040, 1171.869873, 1562.119995, 2098.222412, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2040, 1171.629638, 1562.119995, 2098.222412, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2040, 1171.759765, 1562.119995, 2098.442626, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2040, 1171.979980, 1562.119995, 2098.442626, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1147.434326, 1543.652343, 2096.151611, 18.000001, 0.000000, 124.200042, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1166.645996, 1561.930297, 2096.074462, 11.300004, 0.000000, -61.700046, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1886, 1150.525756, 1546.974853, 2099.628417, 23.200000, 0.000000, 122.200004, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1620, 1179.093750, 1560.150634, 2092.730468, 180.000000, -20.399999, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1163.526123, 1555.061279, 2099.706298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1153.545410, 1555.061279, 2099.706298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1158.446044, 1555.061279, 2099.706298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1163.526123, 1549.321533, 2099.706298, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1153.545410, 1549.321533, 2099.706298, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1893, 1158.446044, 1549.321533, 2099.706298, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2611, 1152.520385, 1562.372924, 2094.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2614, 1157.223754, 1543.334960, 2094.916503, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2010, 1166.843994, 1543.644897, 2092.494384, 0.000000, 0.000000, -47.700000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2010, 1166.939331, 1561.997802, 2092.494384, 0.000000, 0.000000, 52.999996, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2611, 1161.261352, 1562.372924, 2094.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1167.275268, 1556.153930, 2093.775634, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1167.595581, 1556.153930, 2093.775634, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1167.275268, 1555.933715, 2093.775634, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1167.595581, 1555.933715, 2093.775634, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.036010, 1556.163940, 2093.515380, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.036010, 1556.484252, 2093.515380, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.256225, 1556.163940, 2093.515380, 0.000007, 0.000014, 89.999946, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.256225, 1556.484252, 2093.515380, 0.000007, 0.000014, 89.999946, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.486450, 1556.163940, 2093.515380, 0.000014, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.486450, 1556.484252, 2093.515380, 0.000014, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.706665, 1556.163940, 2093.515380, 0.000014, 0.000014, 89.999923, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.706665, 1556.484252, 2093.515380, 0.000014, 0.000014, 89.999923, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.946899, 1556.163940, 2093.515380, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1168.946899, 1556.484252, 2093.515380, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1169.167114, 1556.163940, 2093.515380, 0.000022, 0.000014, 89.999900, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2663, 1169.167114, 1556.484252, 2093.515380, 0.000022, 0.000014, 89.999900, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.072021, 1553.463134, 2093.285156, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.072021, 1553.863525, 2093.285156, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.072021, 1553.863525, 2093.425292, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.072021, 1553.463134, 2093.435302, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.332275, 1553.463134, 2093.285156, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.332275, 1553.863525, 2093.285156, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.332275, 1553.863525, 2093.425292, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.332275, 1553.463134, 2093.435302, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.612548, 1553.463134, 2093.285156, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.612548, 1553.863525, 2093.285156, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.612548, 1553.863525, 2093.425292, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.612548, 1553.463134, 2093.435302, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.872802, 1553.463134, 2093.285156, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.872802, 1553.863525, 2093.285156, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.872802, 1553.863525, 2093.425292, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1168.872802, 1553.463134, 2093.435302, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1169.163085, 1553.463134, 2093.285156, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1169.163085, 1553.863525, 2093.285156, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1169.163085, 1553.863525, 2093.425292, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19567, 1169.163085, 1553.463134, 2093.435302, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1167.998535, 1551.025146, 2093.275146, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1167.998535, 1550.784912, 2093.275146, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1167.998535, 1550.534667, 2093.275146, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.228759, 1551.025146, 2093.275146, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.228759, 1550.784912, 2093.275146, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.228759, 1550.534667, 2093.275146, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.448974, 1551.025146, 2093.275146, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.448974, 1550.784912, 2093.275146, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.448974, 1550.534667, 2093.275146, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.649169, 1551.025146, 2093.275146, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.649169, 1550.784912, 2093.275146, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.649169, 1550.534667, 2093.275146, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.849365, 1551.025146, 2093.275146, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.849365, 1550.784912, 2093.275146, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1168.849365, 1550.534667, 2093.275146, 0.000029, 0.000000, 89.999908, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1169.079589, 1551.025146, 2093.275146, 0.000037, 0.000000, 89.999885, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1169.079589, 1550.784912, 2093.275146, 0.000037, 0.000000, 89.999885, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19563, 1169.079589, 1550.534667, 2093.275146, 0.000037, 0.000000, 89.999885, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2611, 1169.901367, 1546.221679, 2094.554687, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1715, 1169.577148, 1548.645263, 2096.111572, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1715, 1169.577148, 1552.317260, 2096.111572, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1715, 1169.577148, 1555.918212, 2096.111572, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2163, 1171.703002, 1543.315185, 2096.111572, 0.000000, -0.000007, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2163, 1169.942504, 1543.315185, 2096.111572, 0.000000, -0.000007, 179.999954, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(2690, 1167.639526, 1546.564941, 2097.662109, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3089, 1167.432617, 1561.726806, 2097.202636, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(3089, 1167.432617, 1544.156372, 2097.202636, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19273, 1167.372070, 1546.003906, 2097.497070, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(19273, 1167.372070, 1559.896362, 2097.497070, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    jailint = CreateDynamicObject(19327, 1161.661743, 1562.377929, 2094.273681, 0.000000, 9.899993, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "fridge", 140, "Calibri", 29, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 1160.690673, 1562.377929, 2094.817626, 0.000000, 9.899993, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "move", 140, "Calibri", 29, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 1152.855712, 1562.397094, 2094.306152, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "LINCOLN", 140, "Ariel", 19, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 1152.855712, 1562.397094, 2094.186035, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "BURROWS", 140, "Ariel", 19, 1, 0xFF000000, 0x00000000, 1);

	//BLOCK A LIBRARY
	jailint = CreateDynamicObject(19379, 270.874328, 1773.476806, 1463.522705, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354248, 1773.476806, 1463.522705, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354248, 1763.866577, 1463.522705, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1763.866577, 1463.522705, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.784515, 1773.453247, 1465.338867, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.784515, 1763.844116, 1465.338867, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.644653, 1759.023681, 1465.338867, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.274505, 1759.023681, 1465.338867, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.894470, 1759.023681, 1465.338867, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.654449, 1763.882934, 1465.338867, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.654449, 1773.512573, 1465.338867, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.794494, 1778.332397, 1465.338867, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 272.164581, 1778.332397, 1465.338867, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.534515, 1778.332397, 1465.338867, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1763.866577, 1467.153808, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1773.476562, 1467.153808, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354156, 1773.476562, 1467.153808, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354156, 1763.857299, 1467.153808, 0.000000, 90.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.954467, 1763.823974, 1461.867919, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.954467, 1773.444458, 1461.867919, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.814636, 1778.155273, 1461.867919, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.434661, 1778.155273, 1461.867919, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 290.044525, 1778.155273, 1461.867919, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.474548, 1773.275268, 1461.867919, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.474548, 1763.655395, 1461.867919, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.604644, 1759.204467, 1461.867919, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 271.994842, 1759.204467, 1461.867919, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.384918, 1759.204467, 1461.867919, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.664947, 1759.024291, 1468.658325, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.254638, 1759.024291, 1468.658325, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.634552, 1763.883666, 1468.658325, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.854553, 1759.024291, 1468.658325, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.844757, 1759.024291, 1468.658325, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.634552, 1773.513793, 1468.658325, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.814605, 1778.314697, 1468.658325, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 272.224700, 1778.314697, 1468.658325, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.614837, 1778.314697, 1468.658325, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.785064, 1773.434448, 1468.658325, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.785064, 1763.874389, 1468.658325, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1765.098388, 1463.608642, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1765.098388, 1463.608642, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1765.098388, 1463.608642, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1765.098388, 1463.608642, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1770.659301, 1463.608642, -0.000007, 0.000000, -89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1770.659301, 1463.608642, -0.000007, 0.000000, -89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1770.659301, 1463.608642, -0.000007, 0.000000, -89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1770.659301, 1463.608642, -0.000007, 0.000000, -89.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1775.068847, 1463.608642, -0.000014, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1775.068847, 1463.608642, -0.000014, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1775.068847, 1463.608642, -0.000014, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1775.068847, 1463.608642, -0.000014, 0.000000, -89.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 268.521881, 1766.988647, 1463.608642, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(1428, 277.590423, 1759.586425, 1465.059082, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 278.400451, 1759.586425, 1465.059082, 0.000000, 0.000000, 450.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 266.930419, 1774.156738, 1465.059082, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 266.930419, 1773.326416, 1465.059082, 0.000000, 0.000000, 720.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 283.630249, 1777.295898, 1465.059082, 0.000000, 0.000000, 990.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 284.440185, 1777.295898, 1465.059082, 0.000000, 0.000000, 1170.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1772.032104, 1465.599609, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1775.462768, 1465.599609, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1763.482421, 1465.599609, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1811, 283.378784, 1764.725830, 1464.188476, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1764.725830, 1464.188476, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1764.725830, 1464.188476, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1764.725830, 1464.188476, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 283.378784, 1770.286743, 1464.188476, 0.000000, 0.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1770.286743, 1464.188476, 0.000000, 0.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1770.286743, 1464.188476, 0.000000, 0.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1770.286743, 1464.188476, 0.000000, 0.000007, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 283.378784, 1774.696289, 1464.188476, 0.000000, 0.000014, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1774.696289, 1464.188476, 0.000000, 0.000014, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1774.696289, 1464.188476, 0.000000, 0.000014, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1774.696289, 1464.188476, 0.000000, 0.000014, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 266.989196, 1767.485473, 1464.188476, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 286.543426, 1768.905151, 1463.608642, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 281.480407, 1759.072021, 1465.188720, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 275.810516, 1759.072021, 1465.188720, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 270.140563, 1759.072021, 1465.188720, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 264.490539, 1759.072021, 1465.188720, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1764.231079, 1465.188720, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1769.880615, 1465.188720, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1775.600708, 1465.188720, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1781.280151, 1465.188720, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 270.960540, 1778.259887, 1465.188720, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 276.630493, 1778.259887, 1465.188720, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 282.300445, 1778.259887, 1465.188720, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 287.970336, 1778.259887, 1465.188720, 0.000000, 0.000000, 540.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1764.149047, 1464.409301, 0.000000, 0.000000, 108.300003, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1764.738769, 1464.409301, 0.000000, 0.000000, 80.699989, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1764.946533, 1464.409301, 0.000000, 0.000000, 98.999984, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1764.389404, 1464.409301, 0.000000, 0.000000, 98.999984, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1769.709960, 1464.409301, 0.000007, -0.000000, 108.299980, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1770.299682, 1464.409301, 0.000007, 0.000000, 80.699966, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1770.507446, 1464.409301, 0.000007, 0.000000, 98.999961, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1769.950317, 1464.409301, 0.000007, 0.000000, 98.999961, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1774.119506, 1464.409301, 0.000014, -0.000003, 108.299957, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1774.709228, 1464.409301, 0.000014, 0.000000, 80.699958, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1774.916992, 1464.409301, 0.000014, -0.000000, 98.999938, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1774.359863, 1464.409301, 0.000014, -0.000000, 98.999938, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 280.506774, 1773.639038, 1467.029907, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 272.006774, 1773.639038, 1467.029907, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 272.026855, 1764.169433, 1467.029907, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 280.536804, 1764.169433, 1467.029907, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 285.892974, 1777.012695, 1467.327392, 11.800000, 0.000000, -34.200004, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 266.575714, 1759.770263, 1467.259887, 21.899999, 0.000000, 126.500007, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 286.569122, 1768.153564, 1466.349243, 0.000000, 0.000000, 90.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 286.573181, 1766.203125, 1464.929077, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 286.311737, 1760.868408, 1463.608642, 0.000000, 0.000000, -90.000000, 7, -1, -1, 600.00, 600.00);


	//*******************| ZATVOR BLOCK B |***********************************
	//AMBULANCE B
    jailint = CreateDynamicObject(19379, 9.617314, 1784.995239, -90.832038, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, -0.872685, 1784.995239, -90.832038, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19449, 13.740179, 1785.036987, -89.136108, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 8.990176, 1789.586181, -89.136108, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.619822, 1789.586181, -89.136108, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.619822, 1780.295776, -89.136108, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 9.000164, 1780.295776, -89.136108, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.619822, 1784.845581, -89.136108, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(2163, 6.970407, 1789.519042, -88.996070, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(19611, 10.155385, 1789.290405, -90.746109, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19611, 4.605384, 1789.290405, -90.746109, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19087, 4.602934, 1789.300170, -88.616088, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19087, 10.152946, 1789.300170, -88.616088, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19570, 10.152331, 1789.230346, -88.626129, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19570, 4.592326, 1789.230346, -88.626129, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19379, 9.617314, 1784.845825, -87.342071, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, -0.882688, 1784.845825, -87.342071, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19087, 9.496109, 1782.093383, -85.896125, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19993, 2.958157, 1783.476806, -88.315628, 0.000000, -156.999984, 3.099998, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(11744, 2.929980, 1783.476440, -88.391326, 0.000000, -155.000076, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19893, 1.724719, 1784.768310, -89.926109, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 9818, "ship_brijsfw", "ship_greenscreen1", 0x00000000);
	jailint = CreateDynamicObject(19787, -0.578303, 1785.214599, -88.526084, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 9818, "ship_brijsfw", "ship_screen1sfw", 0x00000000);
	jailint = CreateDynamicObject(19993, 9.491789, 1782.121948, -88.315322, -22.800001, 180.000015, 0.000003, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(11744, 9.491514, 1782.102783, -88.393013, -22.199979, 180.000015, 0.000003, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(2167, 13.727680, 1788.312011, -90.746101, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(2167, 11.277672, 1780.381347, -90.746101, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(19087, 2.926110, 1783.473510, -85.896125, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.595481, 1784.870727, -85.856124, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 4.214512, 1780.330688, -85.856124, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 13.844506, 1780.330688, -85.856124, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 13.724509, 1785.140380, -85.856124, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 9.044510, 1789.580444, -85.856124, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.585487, 1789.580444, -85.856124, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, 4.094511, 1789.420288, -92.476119, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 13.594505, 1789.420288, -92.476119, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 13.594505, 1784.699829, -92.476119, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 8.774508, 1780.469482, -92.476119, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.805490, 1780.469482, -92.476119, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -0.465489, 1785.308959, -92.476119, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 7.404510, 1786.359130, -92.476119, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 12.134515, 1791.239013, -92.476119, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, 2.684514, 1791.239013, -92.476119, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(2260, 11.562324, 1789.017822, -89.346092, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "notice01", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1533, 13.580716, 1784.260986, -90.746101, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3390, 5.908452, 1780.934204, -90.746101, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3386, 3.261336, 1780.820556, -90.746101, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3387, 1.938261, 1780.876708, -90.746101, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3393, 0.117090, 1784.744995, -90.766113, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2343, 9.455650, 1781.738403, -90.156089, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1716, 8.823543, 1782.001708, -90.746101, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2146, 12.948669, 1785.755981, -90.266098, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1789, 2.863744, 1785.444580, -90.196136, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1997, 2.718084, 1783.491333, -90.766105, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2603, 9.160679, 1788.139282, -90.306068, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2603, 5.440681, 1788.139282, -90.306068, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19903, 7.362430, 1788.969726, -91.026092, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19809, 2.657093, 1785.464233, -89.736091, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19918, 3.765130, 1785.592407, -90.746101, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11738, 4.677772, 1781.160522, -89.786102, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11736, 2.992764, 1785.461547, -89.766090, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, 3.414860, 1785.407226, -89.796104, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, 3.344861, 1785.447265, -89.796104, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, 2.923276, 1783.478759, -87.416069, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11745, 5.058742, 1781.674316, -90.616081, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 13.084042, 1780.668945, -90.746101, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11709, 0.777408, 1789.134643, -90.076110, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11707, 2.388613, 1789.430419, -89.306106, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2685, 0.785072, 1789.436523, -88.926109, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2225, 1.442994, 1784.922973, -90.766113, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19903, 8.352424, 1780.710083, -91.026092, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(932, 3.809885, 1788.976196, -90.746101, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, 9.491963, 1782.101196, -87.426086, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 6.138378, 1782.476928, -90.746101, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 7.408381, 1782.476928, -90.746101, 0.000004, -0.000006, 147.899993, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 13.624932, 1781.645141, -89.116127, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 9.026329, 1784.886962, -87.336105, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 5.596329, 1784.886962, -87.336105, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 2.116331, 1784.886962, -87.336105, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 13.050626, 1788.800903, -87.116439, 12.699988, 0.000005, -47.200000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2684, 12.349431, 1789.456176, -88.876113, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2611, 13.601023, 1786.087036, -88.936119, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 10.834300, 1789.123168, -90.746101, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, -0.236280, 1787.547119, -90.746101, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);

	//HODNIK BLOCK B
	jailint = CreateDynamicObject(19379, 142.051498, 1816.089477, 1402.666625, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 142.051498, 1806.480346, 1402.666625, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 142.051498, 1796.849975, 1402.666625, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 152.551345, 1801.320678, 1402.666625, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.284042, 1810.818481, 1404.402832, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.284042, 1820.448608, 1404.402832, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 142.413894, 1820.948486, 1404.402832, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.263824, 1816.089355, 1404.402832, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.263824, 1806.460693, 1404.402832, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.263824, 1796.851440, 1404.402832, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 143.043823, 1792.092041, 1404.402832, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 146.953842, 1793.101928, 1404.402832, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.673873, 1797.892578, 1404.402832, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 156.483810, 1801.362182, 1404.402832, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 152.013900, 1806.052124, 1404.402832, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19379, 142.531494, 1816.089477, 1406.197631, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 142.531494, 1806.469482, 1406.197631, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 142.531494, 1796.839965, 1406.197631, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 153.021591, 1800.039916, 1406.197631, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 153.021591, 1809.649902, 1406.197631, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.673873, 1801.642822, 1404.402832, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 142.433868, 1820.782592, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.443954, 1815.902099, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.443954, 1806.312255, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.443954, 1796.692138, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 142.103881, 1792.272216, 1401.013671, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 146.773849, 1793.302978, 1401.013671, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.513748, 1798.042724, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.623794, 1801.453735, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.623794, 1801.623901, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.623794, 1801.804077, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 152.013839, 1805.894287, 1401.013671, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 156.303878, 1801.043090, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.143905, 1810.622924, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.143905, 1816.403320, 1401.013671, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.273941, 1810.763671, 1407.723510, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.274032, 1816.074462, 1407.723510, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.274032, 1806.454956, 1407.723510, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 138.274032, 1796.845458, 1407.723510, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 143.134002, 1792.105346, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 143.134002, 1820.945800, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.273941, 1820.353881, 1407.723510, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 152.013870, 1806.034057, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.653854, 1797.903198, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 156.463943, 1802.802978, 1407.723510, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 146.944107, 1793.062988, 1407.723510, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.653854, 1801.633544, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 151.653854, 1801.663574, 1407.723510, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 138.929870, 1820.135620, 1403.072875, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 146.379928, 1793.345092, 1403.072875, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19172, 138.355468, 1807.746093, 1404.562988, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	jailint = CreateDynamicObject(19172, 147.195266, 1808.896728, 1404.562988, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 139.955261, 1792.177734, 1404.562988, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10023, "bigwhitesfe", "lomall_ext2_", 0x00000000);
	jailint = CreateDynamicObject(19385, 147.763595, 1803.331787, 1404.392700, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.754043, 1809.753295, 1404.402832, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19385, 147.763595, 1799.940673, 1404.392700, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 147.753921, 1793.542846, 1404.372802, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19430, 149.438827, 1802.663818, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 149.438827, 1804.263916, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 149.438827, 1805.823974, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 152.928726, 1805.803955, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 156.428726, 1805.823974, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 156.378677, 1804.223388, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 156.388748, 1802.623657, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 152.888748, 1802.623657, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 152.888748, 1804.204101, 1402.672485, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
    jailint = CreateDynamicObject(19477, 142.772323, 1820.855590, 1405.603515, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "YARD", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 138.382324, 1802.614501, 1405.533447, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "LIBRARY", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 150.772247, 1797.993530, 1405.653564, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "AMBULANCE", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 138.382324, 1816.303955, 1404.013549, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "SECTOR", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 138.382324, 1816.303955, 1404.663696, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "B", 130, "Ariel", 120, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 146.832153, 1795.832763, 1404.013549, 0.000000, 0.000000, 179.999893, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "SECTOR", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 146.832153, 1795.832763, 1404.663696, 0.000000, 0.000000, 179.999893, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "B", 130, "Ariel", 120, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 151.012191, 1805.954589, 1404.073608, -0.000007, -0.000007, -90.000068, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 151.012191, 1805.954589, 1404.723754, -0.000007, -0.000007, -90.000068, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "B", 130, "Ariel", 120, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1216, 146.894210, 1818.059204, 1403.313110, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 146.894210, 1817.328491, 1403.313110, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 146.894210, 1816.597900, 1403.313110, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 142.773483, 1820.863525, 1403.993774, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 143.148376, 1792.204833, 1402.752563, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 138.388275, 1801.025146, 1402.752563, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 138.388275, 1811.635498, 1402.752563, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 147.168228, 1813.156494, 1402.752563, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 138.388275, 1802.515869, 1402.752563, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 138.388275, 1795.065063, 1402.752563, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 142.595489, 1795.593994, 1406.523925, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	hallDoors[2] = CreateDynamicObject(1495, 147.725601, 1802.626953, 1402.752563, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	hallDoors[3] = CreateDynamicObject(1495, 147.725601, 1800.716918, 1402.752563, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 142.595489, 1803.844238, 1406.523925, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 142.595489, 1811.263793, 1406.523925, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 142.595489, 1818.143676, 1406.523925, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 151.945388, 1803.654174, 1406.523925, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 151.945388, 1799.853637, 1406.523925, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 138.653030, 1792.784667, 1406.301635, 19.700002, -0.000007, 154.399993, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 146.693252, 1820.168945, 1406.319091, 20.599992, 0.000006, -34.799983, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 153.428329, 1805.936035, 1402.752563, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 155.648330, 1798.005737, 1402.752563, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 151.498397, 1798.005737, 1402.752563, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 144.648422, 1792.204833, 1402.752563, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 152.799850, 1797.979492, 1404.292480, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);

	//BLOCK B
	jailint = CreateDynamicObject(19379, 102.770843, 1881.759643, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.770843, 1891.389038, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.770843, 1901.017822, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 113.260848, 1881.779663, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 113.260848, 1891.409667, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 113.260848, 1901.008178, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 123.760940, 1881.779663, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 123.760940, 1891.399536, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 123.760940, 1901.028808, 1373.491455, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 97.510910, 1901.005371, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.510910, 1891.366210, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.510910, 1881.755615, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 102.411041, 1905.895019, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 112.021102, 1905.895019, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.631225, 1905.895019, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.820968, 1891.395385, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.820968, 1901.005981, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 104.870925, 1884.146240, 1375.308471, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 114.500930, 1884.146240, 1375.308471, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 114.500930, 1884.146240, 1378.789184, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 114.491104, 1876.955810, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 104.870925, 1884.146240, 1378.788085, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 95.250900, 1876.955810, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 124.110946, 1884.146240, 1375.308471, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 102.570877, 1881.205932, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 124.110870, 1884.146240, 1378.789184, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1887.685424, 1375.307983, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1890.885131, 1375.307983, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1894.084960, 1375.307983, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1897.284545, 1375.307983, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1900.494628, 1375.307983, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1900.494628, 1378.799072, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1897.284790, 1378.799072, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1894.093872, 1378.799072, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1890.874267, 1378.799072, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 102.575958, 1887.664550, 1378.799072, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.820968, 1881.765991, 1375.307373, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.820968, 1891.376098, 1378.798095, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 102.570877, 1881.186401, 1378.796875, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 97.391021, 1881.869506, 1376.973266, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 97.391021, 1891.489257, 1376.973266, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 97.391021, 1901.098754, 1376.973266, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 102.570877, 1906.905273, 1378.796875, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 121.820968, 1881.766601, 1378.798095, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.841018, 1886.066528, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.831054, 1889.287109, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821044, 1892.506958, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821044, 1892.506958, 1378.795898, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821105, 1895.667480, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821182, 1898.907470, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821182, 1901.896972, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821182, 1901.896972, 1378.807373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821182, 1898.907470, 1378.807617, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.821105, 1895.667480, 1378.807373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.831054, 1889.287109, 1378.797607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.841018, 1886.066528, 1378.797729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 105.815979, 1902.184814, 1375.297851, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 105.815979, 1902.184814, 1378.826660, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 99.411209, 1902.184448, 1378.817626, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 109.016036, 1902.184814, 1375.297729, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 103.447067, 1900.717285, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1897.218017, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1893.728759, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1890.249023, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1886.759277, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1883.279907, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1879.789916, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(19428, 103.447067, 1876.299682, 1376.980590, 0.000015, 90.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(13011, 104.783279, 1890.095214, 1373.680908, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19394, 109.016036, 1902.184814, 1378.818115, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 112.205993, 1902.184814, 1378.817871, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 112.205993, 1902.184814, 1375.307373, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 104.225128, 1890.140625, 1377.513427, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 104.225128, 1894.300292, 1377.513427, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 106.295166, 1900.559448, 1377.513427, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 99.411209, 1902.184448, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.510910, 1884.295776, 1378.828369, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.510910, 1893.885742, 1378.828369, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 97.510910, 1903.505615, 1378.828369, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(12839, 115.027709, 1900.027832, 1374.136108, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 107.451217, 1905.895019, 1378.797485, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 117.051162, 1905.895019, 1378.797485, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 121.820968, 1901.005981, 1378.798095, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 104.225128, 1898.459350, 1377.513427, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19394, 115.415985, 1902.184814, 1375.307495, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 115.415985, 1902.184814, 1378.808471, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 105.997116, 1901.337768, 1376.980590, 0.000000, 89.999984, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19379, 109.290939, 1906.956909, 1376.972290, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 119.780975, 1906.956909, 1376.972290, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19428, 109.497146, 1901.337768, 1376.980590, 0.000000, 89.999984, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 112.997192, 1901.337768, 1376.980590, 0.000000, 89.999984, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 116.497207, 1901.337768, 1376.980590, 0.000000, 89.999984, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 119.967208, 1901.337768, 1376.980590, 0.000000, 89.999984, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 121.821258, 1902.185058, 1378.797485, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 117.121292, 1906.944824, 1378.787475, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 113.781280, 1906.934814, 1378.787475, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 110.621383, 1907.004882, 1378.787475, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 107.411376, 1906.935180, 1378.787475, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 104.161361, 1907.064086, 1378.787475, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 117.121292, 1906.914794, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 113.811386, 1906.925170, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 110.631423, 1906.945190, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 107.361389, 1906.915405, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 104.331329, 1906.935424, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 123.631225, 1902.204589, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 110.465209, 1900.559448, 1377.513427, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 114.635269, 1900.559448, 1377.513427, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 121.695266, 1900.559448, 1377.513427, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 109.920913, 1884.146240, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 110.812438, 1888.874267, 1375.287963, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 114.871032, 1884.146240, 1375.308471, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 112.382568, 1888.874267, 1375.287963, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 113.982681, 1888.874267, 1375.287963, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19367, 113.196487, 1887.191894, 1375.989379, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 113.196487, 1883.991699, 1375.979614, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 111.726577, 1883.991699, 1375.978515, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 111.726577, 1887.191772, 1375.979492, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 114.861038, 1884.106201, 1377.349121, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19446, 109.941116, 1884.126220, 1377.329101, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19428, 110.812438, 1888.854248, 1377.329467, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 112.412475, 1888.854248, 1377.329467, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 113.982437, 1888.854248, 1377.329467, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 114.871032, 1884.146240, 1380.668090, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0x00000000);
	jailint = CreateDynamicObject(19428, 113.982681, 1888.874267, 1380.668701, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 112.382629, 1888.874267, 1380.668701, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 110.782623, 1888.874267, 1380.668701, -0.000007, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 109.920913, 1884.146240, 1380.668823, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 116.490753, 1888.988647, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.490753, 1898.598388, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.490753, 1908.206542, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 106.000808, 1908.206542, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 106.000808, 1898.587768, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 95.520721, 1898.587768, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 95.540710, 1888.977783, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 106.050628, 1888.977783, 1380.562744, 0.000000, 90.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(1533, 113.262710, 1884.267211, 1376.046875, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 123.651229, 1902.304687, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 121.791351, 1907.193847, 1375.307373, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 122.041305, 1905.843994, 1375.307373, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 117.211410, 1907.084472, 1375.307373, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 122.071380, 1904.054199, 1373.507446, -0.000015, 90.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 122.071380, 1904.054199, 1376.828002, -0.000015, 90.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19517, "noncolored", "gen_white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19379, 115.716262, 1894.308715, 1368.337280, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 110.816223, 1899.029663, 1368.337280, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 110.816223, 1889.578857, 1368.337280, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 106.096206, 1894.309082, 1368.337280, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 121.646072, 1889.047485, 1368.337280, 0.000000, 360.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.806045, 1884.316406, 1368.337280, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 105.045959, 1884.316406, 1368.337280, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 121.646072, 1898.566162, 1368.337280, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 122.006088, 1902.196899, 1368.337280, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.755966, 1902.026733, 1368.337280, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 107.145889, 1902.026733, 1368.337280, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.755889, 1897.217041, 1368.337280, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.755889, 1887.607666, 1368.337280, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 109.755889, 1884.316650, 1368.337280, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 115.065902, 1884.316650, 1368.337280, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 113.528091, 1889.046020, 1371.837158, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 111.418121, 1889.046020, 1371.837158, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19379, 126.966125, 1889.047485, 1380.398315, 0.000000, 270.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 126.966125, 1898.678222, 1380.398315, 0.000000, 270.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.906005, 1878.987060, 1380.398315, -0.000015, 90.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 107.285934, 1878.987060, 1380.398315, -0.000015, 90.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 116.935897, 1902.177856, 1385.569946, -0.000015, 360.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 107.325851, 1902.177856, 1385.569946, -0.000015, 360.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.585800, 1897.298583, 1385.569946, -0.000000, 360.000000, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 102.585800, 1887.699340, 1385.569946, -0.000000, 360.000000, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 109.825805, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 109.925735, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 114.845672, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 114.875671, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 111.348159, 1888.895874, 1382.067749, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 113.358078, 1888.895874, 1382.067749, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 113.358078, 1888.865844, 1382.067749, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 111.608108, 1888.865844, 1382.067749, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(1968, 113.746261, 1896.974487, 1374.097656, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 107.796325, 1896.974487, 1374.097656, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 107.796325, 1891.744506, 1374.097656, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 113.796279, 1891.744506, 1374.097656, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 110.706298, 1894.454467, 1374.097656, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1280, 121.296310, 1895.031494, 1373.947387, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 121.296310, 1897.701171, 1373.947387, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 121.296310, 1887.880859, 1373.947387, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 121.296310, 1890.550537, 1373.947387, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 116.169540, 1902.127319, 1373.577392, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 112.929595, 1902.127319, 1373.577392, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 109.749694, 1902.127319, 1373.577392, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 106.469741, 1902.127319, 1373.577392, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 106.539718, 1902.127319, 1377.047607, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 109.599655, 1902.127319, 1377.047607, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 112.879562, 1902.127319, 1377.047607, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 116.209503, 1902.127319, 1377.047607, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229598, 1900.996704, 1377.047607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229598, 1897.986938, 1377.047607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229598, 1894.775878, 1377.047607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229598, 1891.605346, 1377.047607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229598, 1888.384399, 1377.047607, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229644, 1901.015014, 1373.547729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229644, 1898.035278, 1373.547729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229644, 1894.784667, 1373.547729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229644, 1891.584594, 1373.547729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 101.229644, 1888.413940, 1373.547729, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(2602, 114.285400, 1904.493896, 1374.077148, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 111.115539, 1904.493896, 1374.077148, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 107.825622, 1904.493896, 1374.077148, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 104.795608, 1904.493896, 1374.077148, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 104.635665, 1904.493896, 1377.569458, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 107.895690, 1904.493896, 1377.569458, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 111.095703, 1904.493896, 1377.569458, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 114.265747, 1904.493896, 1377.569458, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1899.393188, 1377.569458, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1896.132202, 1377.569458, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1892.981079, 1377.569458, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1889.789794, 1377.569458, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1886.529052, 1377.569458, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1886.529052, 1374.078002, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1889.738037, 1374.078002, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1892.998657, 1374.078002, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1896.120117, 1374.078002, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 100.055953, 1899.351074, 1374.078002, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(18633, 118.864456, 1905.277587, 1376.173706, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 119.684478, 1905.277587, 1376.173706, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 120.584487, 1905.277587, 1376.173706, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 120.704467, 1902.606201, 1376.173706, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 119.764450, 1902.606201, 1376.173706, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19428, 109.965896, 1887.087768, 1376.255493, 89.999992, 89.999992, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 109.965896, 1883.627685, 1376.255493, 89.999992, 89.999992, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 114.695831, 1883.627685, 1376.255493, 89.999992, 89.999992, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 114.695831, 1887.057739, 1376.255493, 89.999992, 89.999992, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 113.045776, 1888.758056, 1376.255493, 89.999992, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 111.755783, 1888.738037, 1376.255493, 89.999992, 179.999984, -89.999984, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(2606, 112.304367, 1888.431274, 1379.550659, 28.199996, 0.000017, -0.000008, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 114.090728, 1886.797973, 1376.075317, -0.000015, -0.000000, -90.199951, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 111.753616, 1888.066528, 1376.075317, -0.000000, 0.000015, -1.199995, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
    jailint = CreateDynamicObject(19327, 102.674911, 1887.730468, 1379.922607, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterialText(jailint, 0, "B10", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1887.833740, 1376.448608, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B01", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1890.894287, 1376.448608, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B02", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1894.086791, 1376.448608, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B03", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1897.298461, 1376.448608, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B04", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1900.420288, 1376.448608, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B05", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 105.758438, 1902.091918, 1376.448608, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B06", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 109.038490, 1902.091918, 1376.448608, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B07", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 112.148399, 1902.091918, 1376.448608, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B08", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 115.348426, 1902.091918, 1376.448608, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B09", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
    jailint = CreateDynamicObject(19327, 102.678390, 1890.916137, 1379.871093, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B11", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1894.158935, 1379.871093, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B12", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1897.321166, 1379.871093, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B13", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 102.678390, 1900.493896, 1379.871093, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B14", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 105.788505, 1902.065429, 1379.871093, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B15", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 108.978538, 1902.065429, 1379.871093, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B16", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 112.158508, 1902.065429, 1379.871093, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B17", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 115.388542, 1902.065429, 1379.871093, 0.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B18", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 121.712295, 1894.797607, 1377.479125, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 121.712295, 1890.457763, 1377.479125, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jailint, 0, "B", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(19481, 121.725326, 1892.543334, 1377.587890, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 121.715332, 1892.542846, 1377.578369, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 121.725326, 1892.581542, 1376.709106, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 121.675338, 1892.522827, 1376.709106, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1887.782836, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1887.782836, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1890.923217, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1890.923217, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1894.144165, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1894.144165, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1897.294677, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1897.294677, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1900.524902, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.675170, 1900.524902, 1376.387573, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 105.765167, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 105.765167, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 108.995101, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 108.995101, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 112.205001, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 112.205001, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 115.414932, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 115.414932, 1902.076049, 1376.387573, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 115.414932, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 115.414932, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 112.294891, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 112.294891, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 109.044876, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 109.044876, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 105.804931, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 105.804931, 1902.076049, 1379.848022, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1900.545776, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1900.545776, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1897.335571, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1897.335571, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1894.134643, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1894.134643, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1890.923706, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1890.923706, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1887.723144, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 102.694869, 1887.723144, 1379.848022, -0.000000, 0.000015, -0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2608, 110.303588, 1887.230346, 1376.684936, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 118.332550, 1884.267211, 1373.577392, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 119.832656, 1884.267211, 1373.577392, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 107.640594, 1884.234863, 1374.817382, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 113.050979, 1895.249633, 1380.437255, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 122.533523, 1884.549682, 1380.452514, 0.000015, 0.000000, 89.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 105.826065, 1884.233642, 1375.437622, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11710, 118.676727, 1884.247924, 1376.507446, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 118.067169, 1884.255615, 1376.507446, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 112.396286, 1886.719238, 1376.075317, 0.000000, 0.000015, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 121.328674, 1902.183471, 1379.749511, 0.000013, 0.000006, 65.899986, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 103.386581, 1884.136596, 1379.770507, -0.000015, 0.000002, -80.599945, 8, -1, -1, 600.00, 600.00);

	//BLOCK B DOORS CELL
 	blockB[0] = CreateDynamicObject(3089, 112.938751, 1902.126586, 1374.677978, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[0], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[1] = CreateDynamicObject(3089, 116.138809, 1902.126586, 1374.677978, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[1], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[2] = CreateDynamicObject(3089, 109.728820, 1902.126586, 1374.677978, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[2], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[3] = CreateDynamicObject(3089, 106.538726, 1902.126586, 1374.677978, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[3], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[4] = CreateDynamicObject(3089, 106.538726, 1902.126586, 1378.197998, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[4], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[5] = CreateDynamicObject(3089, 109.738739, 1902.126586, 1378.197998, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[5], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[6] = CreateDynamicObject(3089, 112.928787, 1902.126586, 1378.197998, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[6], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[7] = CreateDynamicObject(3089, 116.138732, 1902.126586, 1378.197998, 0.000000, -0.000015, 179.999908, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[7], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[8] = CreateDynamicObject(3089, 102.568847, 1901.256225, 1378.197998, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[8], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[9] = CreateDynamicObject(3089, 102.568847, 1898.046264, 1378.197998, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[9], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[10] = CreateDynamicObject(3089, 102.568847, 1894.856811, 1378.197998, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[10], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[11] = CreateDynamicObject(3089, 102.568847, 1891.635864, 1378.197998, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[11], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[12] = CreateDynamicObject(3089, 102.568847, 1888.425292, 1378.197998, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[12], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[13] = CreateDynamicObject(3089, 102.568847, 1888.445312, 1374.697753, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[13], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[14] = CreateDynamicObject(3089, 102.568847, 1891.646118, 1374.697753, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[14], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[15] = CreateDynamicObject(3089, 102.568847, 1894.846679, 1374.697753, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[15], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[16] = CreateDynamicObject(3089, 102.568847, 1898.047363, 1374.697753, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[16], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	blockB[17] = CreateDynamicObject(3089, 102.568847, 1901.258056, 1374.697753, -0.000015, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockB[17], 2, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);

	//KANTE ZA SMECE
	jailint = CreateDynamicObject(1333, 113.226722, -248.827789, 1.390041, 0.000007, -0.000015, 90.700141, -1, -1, -1, 300.00, 300.00);
	jailint = CreateDynamicObject(1334, 113.116523, -246.202423, 1.553488, -0.000007, 0.000015, -89.999946, -1, -1, -1, 300.00, 300.00);


	//LIBRARY B
	jailint = CreateDynamicObject(19379, 270.874328, 1659.336303, 1463.522705, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354248, 1659.336303, 1463.522705, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354248, 1649.726074, 1463.522705, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1649.726074, 1463.522705, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.784515, 1659.312744, 1465.338867, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.784515, 1649.703613, 1465.338867, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.644653, 1644.883178, 1465.338867, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.274505, 1644.883178, 1465.338867, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.894470, 1644.883178, 1465.338867, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.654449, 1649.742431, 1465.338867, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.654449, 1659.372070, 1465.338867, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.794494, 1664.191894, 1465.338867, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 272.164581, 1664.191894, 1465.338867, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.534515, 1664.191894, 1465.338867, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1649.726074, 1467.153808, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 270.864318, 1659.336059, 1467.153808, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354156, 1659.336059, 1467.153808, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 281.354156, 1649.716796, 1467.153808, 0.000000, 90.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.954467, 1649.683471, 1461.867919, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.954467, 1659.303955, 1461.867919, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.814636, 1664.014770, 1461.867919, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.434661, 1664.014770, 1461.867919, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 290.044525, 1664.014770, 1461.867919, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.474548, 1659.134765, 1461.867919, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.474548, 1649.514892, 1461.867919, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.604644, 1645.063964, 1461.867919, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 271.994842, 1645.063964, 1461.867919, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.384918, 1645.063964, 1461.867919, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19451, 270.664947, 1644.883789, 1468.658325, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 280.254638, 1644.883789, 1468.658325, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.634552, 1649.743164, 1468.658325, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.854553, 1644.883789, 1468.658325, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19451, 289.844757, 1644.883789, 1468.658325, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19451, 286.634552, 1659.373291, 1468.658325, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 281.814605, 1664.174194, 1468.658325, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 272.224700, 1664.174194, 1468.658325, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 262.614837, 1664.174194, 1468.658325, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.785064, 1659.293945, 1468.658325, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19451, 265.785064, 1649.733886, 1468.658325, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1650.957885, 1463.608642, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1650.957885, 1463.608642, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1650.957885, 1463.608642, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1650.957885, 1463.608642, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1656.518798, 1463.608642, -0.000014, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1656.518798, 1463.608642, -0.000014, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1656.518798, 1463.608642, -0.000014, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1656.518798, 1463.608642, -0.000014, 0.000000, -89.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 281.901977, 1660.928344, 1463.608642, -0.000021, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 278.261993, 1660.928344, 1463.608642, -0.000021, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 274.611968, 1660.928344, 1463.608642, -0.000021, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 270.991943, 1660.928344, 1463.608642, -0.000021, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(2180, 268.521881, 1652.848144, 1463.608642, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	jailint = CreateDynamicObject(1428, 277.590423, 1645.445922, 1465.059082, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 278.400451, 1645.445922, 1465.059082, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 266.930419, 1660.016235, 1465.059082, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 266.930419, 1659.185913, 1465.059082, -0.000000, 0.000007, -0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 283.630249, 1663.155395, 1465.059082, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(1428, 284.440185, 1663.155395, 1465.059082, 0.000007, -0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1657.891601, 1465.599609, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1661.322265, 1465.599609, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	jailint = CreateDynamicObject(19172, 286.563812, 1649.341918, 1465.599609, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1811, 283.378784, 1650.585327, 1464.188476, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1650.585327, 1464.188476, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1650.585327, 1464.188476, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1650.585327, 1464.188476, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 283.378784, 1656.146240, 1464.188476, 0.000000, 0.000014, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1656.146240, 1464.188476, 0.000000, 0.000014, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1656.146240, 1464.188476, 0.000000, 0.000014, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1656.146240, 1464.188476, 0.000000, 0.000014, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 283.378784, 1660.555786, 1464.188476, 0.000000, 0.000021, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 279.818878, 1660.555786, 1464.188476, 0.000000, 0.000021, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 276.328918, 1660.555786, 1464.188476, 0.000000, 0.000021, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 272.528991, 1660.555786, 1464.188476, 0.000000, 0.000021, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1811, 266.989196, 1653.344970, 1464.188476, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 286.543426, 1654.764648, 1463.608642, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 281.480407, 1644.931518, 1465.188720, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 275.810516, 1644.931518, 1465.188720, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 270.140563, 1644.931518, 1465.188720, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 264.490539, 1644.931518, 1465.188720, 0.000000, 0.000007, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1650.090576, 1465.188720, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1655.740112, 1465.188720, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1661.460205, 1465.188720, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 265.830505, 1667.139648, 1465.188720, -0.000007, -0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 270.960540, 1664.119384, 1465.188720, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 276.630493, 1664.119384, 1465.188720, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 282.300445, 1664.119384, 1465.188720, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(14455, 287.970336, 1664.119384, 1465.188720, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1650.008544, 1464.409301, 0.000007, -0.000002, 108.299980, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1650.598266, 1464.409301, 0.000007, 0.000001, 80.699966, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1650.806030, 1464.409301, 0.000007, -0.000001, 98.999961, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1650.248901, 1464.409301, 0.000007, -0.000001, 98.999961, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1655.569458, 1464.409301, 0.000014, -0.000003, 108.299957, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1656.159179, 1464.409301, 0.000014, 0.000001, 80.699958, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1656.366943, 1464.409301, 0.000014, -0.000001, 98.999938, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1655.809814, 1464.409301, 0.000014, -0.000001, 98.999938, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 281.874237, 1659.979003, 1464.409301, 0.000021, -0.000005, 108.299934, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 278.272186, 1660.568725, 1464.409301, 0.000021, 0.000002, 80.699958, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 274.594390, 1660.776489, 1464.409301, 0.000021, -0.000002, 98.999916, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2813, 271.078247, 1660.219360, 1464.409301, 0.000021, -0.000002, 98.999916, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 280.506774, 1659.498535, 1467.029907, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 272.006774, 1659.498535, 1467.029907, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 272.026855, 1650.028930, 1467.029907, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 280.536804, 1650.028930, 1467.029907, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 285.892974, 1662.872192, 1467.327392, 11.799996, 0.000006, -34.199996, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 266.575714, 1645.629760, 1467.259887, 21.900003, -0.000004, 126.499984, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 286.569122, 1654.013061, 1466.349243, 0.000007, 0.000000, 89.999977, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 286.573181, 1652.062622, 1464.929077, 0.000000, -0.000007, 179.999954, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 286.311737, 1646.727905, 1463.608642, -0.000007, 0.000000, -89.999977, 8, -1, -1, 600.00, 600.00);

	//ENTRACEN B BLOCK
	jailint = CreateDynamicObject(19379, 239.505599, 1593.958007, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1603.587646, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1593.957885, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1584.327392, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 239.607147, 1608.157104, -76.933288, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.447158, 1602.197021, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.187088, 1597.467163, -76.933288, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 253.517105, 1593.717285, -76.933288, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 253.517105, 1584.107055, -76.933288, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 237.687088, 1603.257324, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 237.687103, 1593.627197, -76.913276, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.027084, 1589.157714, -76.933288, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 230.387069, 1589.157714, -76.933288, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.767120, 1584.417358, -76.933288, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 250.005569, 1574.697509, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505462, 1576.267944, -78.629226, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.037155, 1579.667358, -76.933288, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 235.217071, 1575.177490, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.057113, 1571.547729, -76.933288, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.687149, 1571.547729, -76.933288, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 248.287277, 1579.256591, -76.933288, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 252.847366, 1584.137084, -76.843276, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19385, 246.438369, 1584.135742, -76.843231, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 248.287277, 1569.626586, -76.933288, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1603.587646, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.505599, 1593.967285, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1593.967285, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1584.337158, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 249.995681, 1574.717163, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.495666, 1574.717163, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 239.495666, 1584.347534, -75.159248, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
	jailint = CreateDynamicObject(19446, 239.697128, 1609.797363, -75.313270, 0.000022, 90.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.037139, 1603.337280, -75.313247, 0.000000, 89.999977, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.037139, 1593.717529, -75.313247, 0.000000, 89.999977, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.037155, 1587.497558, -75.313247, -0.000022, 90.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 243.117156, 1584.427368, -75.313247, 0.000000, 89.999977, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.047073, 1581.317504, -75.313247, 0.000022, 90.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 233.557052, 1574.837890, -75.313247, 0.000000, 89.999977, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 240.017105, 1569.897949, -75.313247, -0.000022, 90.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.617126, 1569.897949, -75.313247, -0.000022, 90.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.947113, 1579.247802, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.947113, 1569.637573, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.657135, 1584.156738, -73.653266, 0.000022, 360.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.657135, 1584.116699, -73.653266, 0.000022, 360.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.167068, 1588.977539, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 255.167068, 1598.586914, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.447158, 1611.817016, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 246.107101, 1602.196289, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767120, 1600.316528, -79.363281, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.481094, 1598.215332, -79.373260, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19387, 239.968627, 1597.473144, -76.903320, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.491088, 1599.585937, -79.373260, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 233.577041, 1597.468017, -76.913291, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.777023, 1597.447998, -73.653274, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.777023, 1597.508056, -73.653274, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 249.177093, 1599.127319, -75.313293, 0.000022, 90.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 246.107101, 1611.776245, -75.313247, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(1499, 240.712509, 1597.465942, -78.663307, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767120, 1600.316528, -74.183212, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.491088, 1599.585937, -74.183311, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.481094, 1598.215332, -74.183273, 0.000000, 180.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.767074, 1600.337280, -73.653266, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.521072, 1599.625976, -73.653312, 0.000000, 360.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.521072, 1598.195678, -73.653312, 0.000000, 360.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.441162, 1598.195678, -73.653312, 0.000000, 360.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 241.431167, 1599.416137, -73.653312, 0.000000, 360.000000, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 236.537063, 1600.336059, -74.183280, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2260, 241.150863, 1598.039916, -77.023300, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "notice01", 0x00000000);
	jailint = CreateDynamicObject(19327, 244.341644, 1605.467651, -75.953315, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}SAN ANDREAS", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1603.088012, -75.953315, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}CORRECTIONAL", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1601.138305, -75.953315, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}FACILITY", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1604.708007, -76.373313, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RECIEVING", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1603.908447, -76.373313, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}AND", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1603.177856, -76.373313, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RELEASE", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1602.428222, -76.373313, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}UNIT", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 244.341644, 1603.788452, -76.493324, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}___________________________________________________", 80, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19446, 235.127227, 1576.047363, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 244.477203, 1603.116088, -76.933288, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2612, 237.824508, 1603.557373, -76.603302, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2260, 243.880889, 1599.759643, -77.113304, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "KeepOut_64", 0x00000000);
	jailint = CreateDynamicObject(19369, 237.701324, 1593.315917, -77.153305, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.633277, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.853271, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1592.066528, -76.313323, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}79", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.133255, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.173248, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.123237, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.073219, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.303207, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.373214, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.433227, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.383277, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.543212, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.603202, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.663208, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.783218, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.833213, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -76.893218, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -77.013229, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -77.063224, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1593.317016, -77.113235, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1594.536865, -76.303245, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}1", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1594.536865, -76.563262, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}2", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1594.536865, -76.833282, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}3", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1594.546875, -77.063293, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}4", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1592.066528, -76.573341, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}49", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1592.066528, -76.813331, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}39", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 237.791534, 1592.066528, -77.043319, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}29", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19368, 237.056060, 1593.315551, -78.443283, 0.000000, 90.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(2612, 239.434478, 1589.289428, -76.603302, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2616, 243.268234, 1589.289916, -76.723251, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2181, 251.167434, 1596.929199, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2612, 253.389404, 1589.373046, -76.653282, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 253.389404, 1595.053466, -76.653282, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2616, 249.133300, 1584.275146, -76.683280, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19327, 244.858642, 1586.795532, -76.283256, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2612, 248.129348, 1578.123291, -76.653282, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 248.129348, 1579.833618, -76.653282, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.497055, 1575.177490, -79.063293, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.447082, 1575.478027, -80.283309, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19446, 238.447082, 1579.358032, -80.283309, -0.000022, 180.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19940, 242.414459, 1575.180053, -77.313278, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 240.444381, 1575.180053, -77.313278, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 238.454376, 1575.180053, -77.313278, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 236.464401, 1575.180053, -77.313278, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 234.464340, 1575.180053, -77.313278, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(2708, 239.277420, 1571.849731, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2708, 241.677490, 1571.849731, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(936, 243.214401, 1572.205200, -78.083290, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(19327, 235.351486, 1577.417480, -75.763259, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}PRISON ENTRANCE", 80, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(1499, 247.172439, 1584.165649, -78.603317, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1533, 241.136901, 1608.049072, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 239.646881, 1608.049072, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 238.244033, 1599.903076, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 241.074050, 1599.923095, -78.543289, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 241.557083, 1597.497070, -77.313278, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	entranceLobby [1] = CreateDynamicObject(19302, 243.301284, 1597.487548, -77.313262, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 245.047073, 1597.497070, -77.313278, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 245.047073, 1597.497070, -74.823280, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 241.557083, 1597.497070, -74.833259, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 243.297119, 1597.497070, -74.833259, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 241.169418, 1608.076293, -75.733291, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 238.614135, 1600.326782, -77.563308, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 241.514129, 1598.876831, -77.563308, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 238.678222, 1599.707397, -77.583328, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 240.888198, 1599.017211, -77.583328, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 237.552917, 1598.621704, -75.983291, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 237.552917, 1598.621704, -76.513290, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2010, 238.177413, 1596.965209, -78.543289, 0.000016, 0.000013, 49.999992, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1601.843505, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 238.769897, 1598.266967, -78.543289, -0.000016, 0.000013, -51.200000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 238.258163, 1607.651489, -78.073303, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 243.778213, 1607.651489, -78.073303, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2690, 237.899353, 1601.338745, -76.953308, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19611, 241.303192, 1593.291259, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19623, 241.292083, 1593.291381, -76.903327, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 241.393096, 1589.290039, -76.563308, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2308, 249.202102, 1595.909057, -78.543289, 0.000000, 0.000029, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 249.336334, 1597.079956, -77.773292, -0.000000, 0.000029, -0.999999, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 249.225463, 1596.081298, -77.733276, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 250.418273, 1596.095581, -78.543289, 0.000029, 0.000000, 89.999908, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 251.788299, 1595.485351, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2174, 252.967620, 1587.161987, -78.543289, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2175, 252.958938, 1585.229125, -78.543289, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 251.496871, 1585.593139, -78.543289, -0.000019, 0.000009, -65.599983, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 253.025421, 1584.421020, -77.773292, -0.000013, -0.000018, -143.100006, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 252.845474, 1585.541748, -77.733276, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 249.451995, 1590.065795, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 250.451980, 1591.035888, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 242.611953, 1589.735351, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 250.138320, 1588.805297, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 249.918350, 1592.095581, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 241.998306, 1591.235229, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 247.186798, 1597.337158, -76.613281, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19787, 253.418899, 1592.237792, -76.633300, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2202, 252.964141, 1592.943603, -78.543289, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2700, 237.969558, 1596.911254, -76.034729, -0.000009, 15.200019, -23.600000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 247.256881, 1571.658325, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 245.367797, 1571.650268, -76.833267, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 235.326873, 1575.868408, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 235.326873, 1577.368774, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 241.529739, 1572.010620, -76.753273, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 240.539733, 1572.010620, -76.753273, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 239.079727, 1572.010620, -76.753273, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 238.139663, 1572.010620, -76.753273, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1572.006713, -78.303306, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1572.006713, -78.303306, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1572.006713, -78.303306, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1572.006713, -77.463294, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1572.006713, -77.983299, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 240.429748, 1572.006713, -77.983291, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.099761, 1572.006713, -77.453285, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1572.006713, -77.983314, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 241.699737, 1572.006713, -77.453315, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 239.273941, 1571.930908, -78.303314, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.744003, 1571.930908, -78.303314, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.184036, 1571.930908, -78.003334, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.184036, 1571.930908, -77.463325, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 238.704040, 1571.930908, -77.463325, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 236.847854, 1571.769042, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 235.837890, 1571.769042, -78.543289, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 243.104568, 1571.349243, -77.613296, 0.000015, 0.000015, 44.999984, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 247.997207, 1574.681884, -78.043395, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 249.247177, 1584.421386, -78.043395, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 238.927169, 1589.481689, -78.043395, 0.000000, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 238.017181, 1604.361572, -78.043395, -0.000022, 0.000000, -89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 244.545578, 1597.219970, -78.543289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 245.106872, 1587.761352, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 235.536941, 1574.131103, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 235.942077, 1576.036499, -74.939231, 18.300020, -0.000004, 102.399932, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 246.541717, 1572.283081, -74.921684, 16.099998, -0.000022, 179.999862, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 252.942184, 1584.615844, -74.964241, 12.699981, -0.000016, -137.199996, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 244.011322, 1607.549194, -75.007385, 18.099985, 0.000019, -31.199991, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1606.043823, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.666458, 1593.143554, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 247.666534, 1593.143554, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 247.666534, 1587.893432, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 245.966567, 1581.673706, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 245.966567, 1576.333496, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 240.176544, 1576.333496, -74.973289, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3657, 246.703109, 1596.987182, -78.033317, 0.000000, 0.000022, 0.000000, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1604.171875, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1604.842529, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1603.501708, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 244.278076, 1602.851074, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 245.503265, 1597.154418, -78.178771, -37.799980, 90.000022, -0.199980, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 246.273300, 1597.151245, -78.178771, -37.799980, 90.000022, -0.199980, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 247.073226, 1597.148559, -78.178771, -37.799980, 90.000022, -0.199980, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 247.863159, 1597.146118, -78.178771, -37.799980, 90.000022, -0.199980, 8, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1302, 238.092178, 1605.953247, -78.543289, 0.000022, 0.000000, 89.999931, 8, -1, -1, 600.00, 600.00);
	
	//|****************************|BLOCK C ALL MAPS|**********************
	//BLOCK C
	jailint = CreateDynamicObject(19379, 342.350769, 1881.759643, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.350769, 1891.389038, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.350769, 1901.017822, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 352.840759, 1881.779663, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 352.840759, 1891.409667, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 352.840759, 1901.008178, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 363.340881, 1881.779663, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 363.340881, 1891.399536, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 363.340881, 1901.028808, 1373.491455, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 337.090820, 1901.005371, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.090820, 1891.366210, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.090820, 1881.755615, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 341.990966, 1905.895019, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 351.601013, 1905.895019, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.211151, 1905.895019, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.400878, 1891.395385, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.400878, 1901.005981, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 344.450866, 1884.146240, 1375.308471, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 354.080871, 1884.146240, 1375.308471, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 354.080871, 1884.146240, 1378.789184, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 354.071044, 1876.955810, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 344.450866, 1884.146240, 1378.788085, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 334.830810, 1876.955810, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 363.690856, 1884.146240, 1375.308471, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 342.150817, 1881.205932, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 363.690795, 1884.146240, 1378.789184, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1887.685424, 1375.307983, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1890.885131, 1375.307983, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1894.084960, 1375.307983, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1897.284545, 1375.307983, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1900.494628, 1375.307983, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1900.494628, 1378.799072, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1897.284790, 1378.799072, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1894.093872, 1378.799072, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1890.874267, 1378.799072, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 342.155883, 1887.664550, 1378.799072, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.400878, 1881.765991, 1375.307373, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.400878, 1891.376098, 1378.798095, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 342.150817, 1881.186401, 1378.796875, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 336.970947, 1881.869506, 1376.973266, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 336.970947, 1891.489257, 1376.973266, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 336.970947, 1901.098754, 1376.973266, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 342.150817, 1906.905273, 1378.796875, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.400878, 1881.766601, 1378.798095, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.420959, 1886.066528, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.410980, 1889.287109, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.400970, 1892.506958, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.400970, 1892.506958, 1378.795898, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401031, 1895.667480, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401123, 1898.907470, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401123, 1901.896972, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401123, 1901.896972, 1378.807373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401123, 1898.907470, 1378.807617, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.401031, 1895.667480, 1378.807373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.410980, 1889.287109, 1378.797607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.420959, 1886.066528, 1378.797729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 345.395904, 1902.184814, 1375.297851, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 345.395904, 1902.184814, 1378.826660, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 338.991149, 1902.184448, 1378.817626, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 348.595947, 1902.184814, 1375.297729, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 343.026977, 1900.717285, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1897.218017, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1893.728759, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1890.249023, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1886.759277, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1883.279907, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1879.789916, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(19428, 343.026977, 1876.299682, 1376.980590, 0.000007, 90.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16023, "des_trainstuff", "metpat64shadow", 0x00000000);
	jailint = CreateDynamicObject(13011, 344.363220, 1890.095214, 1373.680908, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19394, 348.595947, 1902.184814, 1378.818115, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 351.785919, 1902.184814, 1378.817871, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 351.785919, 1902.184814, 1375.307373, 0.000021, 0.000000, 89.999931, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 343.805053, 1890.140625, 1377.513427, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 343.805053, 1894.300292, 1377.513427, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 345.875091, 1900.559448, 1377.513427, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 338.991149, 1902.184448, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.090820, 1884.295776, 1378.828369, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.090820, 1893.885742, 1378.828369, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 337.090820, 1903.505615, 1378.828369, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(12839, 354.607635, 1900.027832, 1374.136108, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16646, "a51_alpha", "des_rails1", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 347.031127, 1905.895019, 1378.797485, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 356.631103, 1905.895019, 1378.797485, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 361.400878, 1901.005981, 1378.798095, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 343.805053, 1898.459350, 1377.513427, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19394, 354.995910, 1902.184814, 1375.307495, 0.000014, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19394, 354.995910, 1902.184814, 1378.808471, 0.000014, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 345.577026, 1901.337768, 1376.980590, 0.000000, 89.999992, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19379, 348.870849, 1906.956909, 1376.972290, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 359.360900, 1906.956909, 1376.972290, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19428, 349.077087, 1901.337768, 1376.980590, 0.000000, 89.999992, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 352.577117, 1901.337768, 1376.980590, 0.000000, 89.999992, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 356.077148, 1901.337768, 1376.980590, 0.000000, 89.999992, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19428, 359.547119, 1901.337768, 1376.980590, 0.000000, 89.999992, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.401184, 1902.185058, 1378.797485, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 356.701232, 1906.944824, 1378.787475, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 353.361206, 1906.934814, 1378.787475, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 350.201293, 1907.004882, 1378.787475, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 346.991302, 1906.935180, 1378.787475, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 343.741271, 1907.064086, 1378.787475, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 356.701232, 1906.914794, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 353.391296, 1906.925170, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 350.211364, 1906.945190, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 346.941314, 1906.915405, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 343.911254, 1906.935424, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19446, 363.211151, 1902.204589, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(970, 350.045135, 1900.559448, 1377.513427, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 354.215209, 1900.559448, 1377.513427, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(970, 361.275207, 1900.559448, 1377.513427, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	jailint = CreateDynamicObject(19446, 349.500854, 1884.146240, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 350.392364, 1888.874267, 1375.287963, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 354.450958, 1884.146240, 1375.308471, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19428, 351.962493, 1888.874267, 1375.287963, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 353.562622, 1888.874267, 1375.287963, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19367, 352.776428, 1887.191894, 1375.989379, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 352.776428, 1883.991699, 1375.979614, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 351.306518, 1883.991699, 1375.978515, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19367, 351.306518, 1887.191772, 1375.979492, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 354.440979, 1884.106201, 1377.349121, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19446, 349.521057, 1884.126220, 1377.329101, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	jailint = CreateDynamicObject(19428, 350.392364, 1888.854248, 1377.329467, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 351.992401, 1888.854248, 1377.329467, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 353.562377, 1888.854248, 1377.329467, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19004, "roundbuilding1", "capitolwin1_lawn2", 0xFF000000);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 354.450958, 1884.146240, 1380.668090, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 19004, "roundbuilding1", "capitolwin1_lawn2", 0x00000000);
	jailint = CreateDynamicObject(19428, 353.562622, 1888.874267, 1380.668701, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 351.962554, 1888.874267, 1380.668701, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19428, 350.362548, 1888.874267, 1380.668701, 0.000000, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	SetDynamicObjectMaterial(jailint, 1, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 349.500854, 1884.146240, 1380.668823, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0xFFFFFFCC);
	jailint = CreateDynamicObject(19379, 356.070678, 1888.988647, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.070678, 1898.598388, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.070678, 1908.206542, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 345.580749, 1908.206542, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 345.580749, 1898.587768, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 335.100646, 1898.587768, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 335.120635, 1888.977783, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(19379, 345.630554, 1888.977783, 1380.562744, 0.000000, 90.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "gun_ceiling1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "gun_ceiling1128", 0x00000000);
	jailint = CreateDynamicObject(1533, 352.842651, 1884.267211, 1376.046875, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	jailint = CreateDynamicObject(19446, 363.231140, 1902.304687, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.371276, 1907.193847, 1375.307373, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.621215, 1905.843994, 1375.307373, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 356.791320, 1907.084472, 1375.307373, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.651306, 1904.054199, 1373.507446, -0.000007, 90.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14815, "whore_main", "WH_tiles", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19446, 361.651306, 1904.054199, 1376.828002, -0.000007, 90.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19517, "noncolored", "gen_white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jailint, 1, 14815, "whore_main", "WH_tiles", 0x00000000);
	jailint = CreateDynamicObject(19379, 355.296203, 1894.308715, 1368.337280, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 350.396148, 1899.029663, 1368.337280, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 350.396148, 1889.578857, 1368.337280, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 345.676147, 1894.309082, 1368.337280, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 361.226013, 1889.047485, 1368.337280, 0.000000, 360.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.385986, 1884.316406, 1368.337280, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 344.625885, 1884.316406, 1368.337280, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 361.226013, 1898.566162, 1368.337280, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 361.585998, 1902.196899, 1368.337280, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.335876, 1902.026733, 1368.337280, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 346.725830, 1902.026733, 1368.337280, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.335815, 1897.217041, 1368.337280, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.335815, 1887.607666, 1368.337280, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 349.335815, 1884.316650, 1368.337280, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 354.645812, 1884.316650, 1368.337280, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 353.108032, 1889.046020, 1371.837158, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 350.998046, 1889.046020, 1371.837158, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19379, 366.546051, 1889.047485, 1380.398315, 0.000000, 270.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 366.546051, 1898.678222, 1380.398315, 0.000000, 270.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.485931, 1878.987060, 1380.398315, -0.000007, 90.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 346.865844, 1878.987060, 1380.398315, -0.000007, 90.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 356.515808, 1902.177856, 1385.569946, -0.000007, 360.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 346.905761, 1902.177856, 1385.569946, -0.000007, 360.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.165710, 1897.298583, 1385.569946, -0.000000, 360.000000, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 342.165710, 1887.699340, 1385.569946, -0.000000, 360.000000, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 349.405731, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 349.505676, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 354.425598, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19379, 354.455596, 1884.128417, 1385.569946, 0.000000, 360.000000, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19523, "sampicons", "oranggrad32", 0x00000000);
	jailint = CreateDynamicObject(19401, 350.928100, 1888.895874, 1382.067749, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 352.937988, 1888.895874, 1382.067749, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 352.937988, 1888.865844, 1382.067749, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(19401, 351.188049, 1888.865844, 1382.067749, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19655, "mattubes", "bluedirt1", 0x00000000);
	jailint = CreateDynamicObject(1968, 353.326171, 1896.974487, 1374.097656, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 347.376251, 1896.974487, 1374.097656, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 347.376251, 1891.744506, 1374.097656, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 353.376220, 1891.744506, 1374.097656, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1968, 350.286224, 1894.454467, 1374.097656, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18642, "taser1", "metalshinydented1", 0x00000000);
	jailint = CreateDynamicObject(1280, 360.876220, 1895.031494, 1373.947387, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 360.876220, 1897.701171, 1373.947387, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 360.876220, 1887.880859, 1373.947387, 0.000000, 0.000014, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1280, 360.876220, 1890.550537, 1373.947387, 0.000000, 0.000014, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(1800, 355.749450, 1902.127319, 1373.577392, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 352.509521, 1902.127319, 1373.577392, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 349.329620, 1902.127319, 1373.577392, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 346.049682, 1902.127319, 1373.577392, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 346.119628, 1902.127319, 1377.047607, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 349.179565, 1902.127319, 1377.047607, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 352.459472, 1902.127319, 1377.047607, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 355.789428, 1902.127319, 1377.047607, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809509, 1900.996704, 1377.047607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809509, 1897.986938, 1377.047607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809509, 1894.775878, 1377.047607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809509, 1891.605346, 1377.047607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809509, 1888.384399, 1377.047607, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809570, 1901.015014, 1373.547729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809570, 1898.035278, 1373.547729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809570, 1894.784667, 1373.547729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809570, 1891.584594, 1373.547729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(1800, 340.809570, 1888.413940, 1373.547729, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 2669, "cj_chris", "Bow_Fence_Metal", 0x00000000);
	jailint = CreateDynamicObject(2602, 353.865325, 1904.493896, 1374.077148, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 350.695465, 1904.493896, 1374.077148, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 347.405548, 1904.493896, 1374.077148, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 344.375549, 1904.493896, 1374.077148, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 344.215576, 1904.493896, 1377.569458, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 347.475616, 1904.493896, 1377.569458, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 350.675628, 1904.493896, 1377.569458, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 353.845672, 1904.493896, 1377.569458, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1899.393188, 1377.569458, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1896.132202, 1377.569458, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1892.981079, 1377.569458, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1889.789794, 1377.569458, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1886.529052, 1377.569458, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1886.529052, 1374.078002, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1889.738037, 1374.078002, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1892.998657, 1374.078002, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1896.120117, 1374.078002, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2602, 339.635864, 1899.351074, 1374.078002, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 2, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 4, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 5, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 6, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(18633, 358.444396, 1905.277587, 1376.173706, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 359.264404, 1905.277587, 1376.173706, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 360.164428, 1905.277587, 1376.173706, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 360.284393, 1902.606201, 1376.173706, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(18633, 359.344360, 1902.606201, 1376.173706, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19428, 349.545837, 1887.087768, 1376.255493, 89.999992, 89.999992, -89.999992, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 349.545837, 1883.627685, 1376.255493, 89.999992, 89.999992, -89.999992, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 354.275756, 1883.627685, 1376.255493, 89.999992, 89.999992, -89.999992, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 354.275756, 1887.057739, 1376.255493, 89.999992, 89.999992, -89.999992, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 352.625701, 1888.758056, 1376.255493, 89.999992, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(19428, 351.335693, 1888.738037, 1376.255493, 89.999992, 179.999984, -90.000007, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14668, "711c", "cj_white_wall2", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 14668, "711c", "cj_white_wall2", 0x00000000);
	jailint = CreateDynamicObject(2606, 351.884277, 1888.431274, 1379.550659, 28.199998, 0.000008, -0.000004, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 353.670654, 1886.797973, 1376.075317, -0.000007, -0.000000, -90.199974, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	jailint = CreateDynamicObject(2165, 351.333557, 1888.066528, 1376.075317, -0.000000, 0.000007, -1.199995, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 3, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
    jailint = CreateDynamicObject(19327, 342.249206, 1887.679321, 1376.358032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C01", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1890.959716, 1376.358032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C02", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1894.130493, 1376.358032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C03", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1897.300659, 1376.358032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C04", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1900.481445, 1376.358032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C05", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1887.679321, 1379.830932, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C10", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1890.959716, 1379.830932, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C11", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1894.130493, 1379.830932, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C12", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1897.300659, 1379.830932, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C13", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 342.249206, 1900.481445, 1379.830932, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C14", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 345.359039, 1902.081787, 1376.358032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C06", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 348.558898, 1902.081787, 1376.358032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C07", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 351.728790, 1902.081787, 1376.358032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C08", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 354.978820, 1902.081787, 1376.358032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C09", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 345.359039, 1902.081787, 1379.869995, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C15", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 348.558898, 1902.081787, 1379.869995, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C16", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 351.728790, 1902.081787, 1379.869995, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C17", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 354.978820, 1902.081787, 1379.869995, 0.000000, 0.000007, 0.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C18", 140, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 361.297393, 1894.023193, 1377.587768, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19482, 361.297393, 1890.012329, 1377.587768, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C", 140, "Ariel", 170, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(19481, 361.305236, 1892.543334, 1377.587890, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 361.295257, 1892.542846, 1377.578369, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 361.305236, 1892.581542, 1376.709106, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 361.255249, 1892.522827, 1376.709106, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1887.782836, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1887.782836, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1890.923217, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1890.923217, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1894.144165, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1894.144165, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1897.294677, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1897.294677, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1900.524902, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.255096, 1900.524902, 1376.387573, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 345.345092, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 345.345092, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 348.575012, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 348.575012, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 351.784912, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 351.784912, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 354.994873, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 354.994873, 1902.076049, 1376.387573, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 354.994873, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 354.994873, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 351.874816, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 351.874816, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 348.624816, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 348.624816, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 345.384857, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 345.384857, 1902.076049, 1379.848022, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1900.545776, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1900.545776, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1897.335571, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1897.335571, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1894.134643, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1894.134643, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1890.923706, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1890.923706, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1887.723144, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19481, 342.274780, 1887.723144, 1379.848022, -0.000000, 0.000007, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2608, 349.883514, 1887.230346, 1376.684936, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 357.912475, 1884.267211, 1373.577392, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 359.412597, 1884.267211, 1373.577392, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 347.220520, 1884.234863, 1374.817382, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 352.630920, 1895.249633, 1380.437255, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(18075, 362.113464, 1884.549682, 1380.452514, 0.000007, 0.000000, 89.999977, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 345.406005, 1884.233642, 1375.437622, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11710, 358.256652, 1884.247924, 1376.507446, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 357.647094, 1884.255615, 1376.507446, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 351.976196, 1886.719238, 1376.075317, 0.000000, 0.000007, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 360.908599, 1902.183471, 1379.749511, 0.000006, 0.000003, 65.899986, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2921, 342.966491, 1884.136596, 1379.770507, -0.000007, 0.000001, -80.599967, 9, -1, -1, 600.00, 600.00);

	//BLOCK C DOORS VRATA
	blockC [0] = CreateDynamicObject(3089, 352.518676, 1902.126586, 1374.677978, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [0], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [1] = CreateDynamicObject(3089, 355.718750, 1902.126586, 1374.677978, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [1], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [2] = CreateDynamicObject(3089, 349.308746, 1902.126586, 1374.677978, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [2], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [3] = CreateDynamicObject(3089, 346.118652, 1902.126586, 1374.677978, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [3], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [4] = CreateDynamicObject(3089, 346.118652, 1902.126586, 1378.197998, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [4], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [5] = CreateDynamicObject(3089, 349.318664, 1902.126586, 1378.197998, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [5], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [6] = CreateDynamicObject(3089, 352.508728, 1902.126586, 1378.197998, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [6], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [7] = CreateDynamicObject(3089, 355.718658, 1902.126586, 1378.197998, 0.000000, -0.000007, 179.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [7], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [8] = CreateDynamicObject(3089, 342.148773, 1901.256225, 1378.197998, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [8], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [9] = CreateDynamicObject(3089, 342.148773, 1898.046264, 1378.197998, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [9], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [10] = CreateDynamicObject(3089, 342.148773, 1894.856811, 1378.197998, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [10], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [11] = CreateDynamicObject(3089, 342.148773, 1891.635864, 1378.197998, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [11], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [12] = CreateDynamicObject(3089, 342.148773, 1888.425292, 1378.197998, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [12], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [13] = CreateDynamicObject(3089, 342.148773, 1888.445312, 1374.697753, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [13], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [14] = CreateDynamicObject(3089, 342.148773, 1891.646118, 1374.697753, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [14], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [15] = CreateDynamicObject(3089, 342.148773, 1894.846679, 1374.697753, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [15], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [16] = CreateDynamicObject(3089, 342.148773, 1898.047363, 1374.697753, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [16], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);
	blockC [17] = CreateDynamicObject(3089, 342.148773, 1901.258056, 1374.697753, -0.000007, -0.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(blockC [17], 2, 1315, "dyntraffic", "trafficlight_64", 0x00000000);

	//ENTRANCE
	jailint = CreateDynamicObject(19379, 376.695373, 1593.958007, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.695373, 1603.587646, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.195373, 1593.957885, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.195373, 1584.327392, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 376.796936, 1608.157104, -76.933288, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 381.636962, 1602.197021, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.376892, 1597.467163, -76.933288, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 390.706909, 1593.717285, -76.933288, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 390.706909, 1584.107055, -76.933288, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 374.876892, 1603.257324, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 374.876892, 1593.627197, -76.913276, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.216857, 1589.157714, -76.933288, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 367.576843, 1589.157714, -76.933288, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 381.956909, 1584.417358, -76.933288, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.195373, 1574.697509, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.695251, 1576.267944, -78.629226, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.226928, 1579.667358, -76.933288, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 372.406860, 1575.177490, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.246887, 1571.547729, -76.933288, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.876953, 1571.547729, -76.933288, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 385.477050, 1579.256591, -76.933288, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 390.037170, 1584.137084, -76.843276, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19385, 383.628173, 1584.135742, -76.843231, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 385.477050, 1569.626586, -76.933288, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.695373, 1603.587646, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.695373, 1593.967285, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.185485, 1593.967285, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.185485, 1584.337158, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 387.185485, 1574.717163, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.685455, 1574.717163, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 376.685455, 1584.347534, -75.159248, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
	jailint = CreateDynamicObject(19446, 376.886901, 1609.797363, -75.313270, 0.000030, 90.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.226928, 1603.337280, -75.313247, 0.000000, 89.999969, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.226928, 1593.717529, -75.313247, 0.000000, 89.999969, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.226928, 1587.497558, -75.313247, -0.000030, 90.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 380.306945, 1584.427368, -75.313247, 0.000000, 89.999969, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.236877, 1581.317504, -75.313247, 0.000030, 90.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 370.746826, 1574.837890, -75.313247, 0.000000, 89.999969, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 377.206909, 1569.897949, -75.313247, -0.000030, 90.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.806915, 1569.897949, -75.313247, -0.000030, 90.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 387.136901, 1579.247802, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 387.136901, 1569.637573, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.846923, 1584.156738, -73.653266, 0.000030, 360.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.846923, 1584.116699, -73.653266, 0.000030, 360.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 392.356872, 1588.977539, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 392.356872, 1598.586914, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 381.636962, 1611.817016, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 383.296875, 1602.196289, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.956909, 1600.316528, -79.363281, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.670898, 1598.215332, -79.373260, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19387, 377.158416, 1597.473144, -76.903320, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.680877, 1599.585937, -79.373260, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 370.766845, 1597.468017, -76.913291, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.966796, 1597.447998, -73.653274, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.966796, 1597.508056, -73.653274, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 386.366882, 1599.127319, -75.313293, 0.000030, 90.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 383.296875, 1611.776245, -75.313247, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(1499, 377.902282, 1597.465942, -78.663307, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.956909, 1600.316528, -74.183212, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.680877, 1599.585937, -74.183311, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.670898, 1598.215332, -74.183273, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.956848, 1600.337280, -73.653266, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.710876, 1599.625976, -73.653312, 0.000000, 360.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.710876, 1598.195678, -73.653312, 0.000000, 360.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.630950, 1598.195678, -73.653312, 0.000000, 360.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19427, 378.620971, 1599.416137, -73.653312, 0.000000, 360.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 373.726867, 1600.336059, -74.183280, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2260, 378.340637, 1598.039916, -77.023300, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "notice01", 0x00000000);
	jailint = CreateDynamicObject(19327, 381.531433, 1605.467651, -75.953315, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}SAN ANDREAS", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1603.088012, -75.953315, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}CORRECTIONAL", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1601.138305, -75.953315, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}FACILITY", 50, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1604.708007, -76.373313, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RECIEVING", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1603.908447, -76.373313, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}AND", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1603.177856, -76.373313, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}RELEASE", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1602.428222, -76.373313, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}UNIT", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 381.531433, 1603.788452, -76.493324, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}___________________________________________________", 80, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19446, 372.317016, 1576.047363, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 381.666992, 1603.116088, -76.933288, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(2612, 375.014282, 1603.557373, -76.603302, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2260, 381.070678, 1599.759643, -77.113304, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "KeepOut_64", 0x00000000);
	jailint = CreateDynamicObject(19369, 374.891113, 1593.315917, -77.153305, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.633277, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.853271, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1592.066528, -76.313323, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}79", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.133255, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.173248, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.123237, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.073219, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.303207, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.373214, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.433227, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.383277, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 80, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.543212, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.603202, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.663208, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.783218, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.833213, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -76.893218, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -77.013229, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -77.063224, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1593.317016, -77.113235, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}______________________________________", 60, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1594.536865, -76.303245, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}1", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1594.536865, -76.563262, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}2", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1594.536865, -76.833282, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}3", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1594.546875, -77.063293, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}4", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1592.066528, -76.573341, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}49", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1592.066528, -76.813331, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}39", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19327, 374.981323, 1592.066528, -77.043319, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}29", 130, "Ariel", 25, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19368, 374.245849, 1593.315551, -78.443283, 0.000000, 90.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(2612, 376.624267, 1589.289428, -76.603302, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	SetDynamicObjectMaterial(jailint, 3, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2616, 380.458007, 1589.289916, -76.723251, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2181, 388.357238, 1596.929199, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2612, 390.579193, 1589.373046, -76.653282, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 390.579193, 1595.053466, -76.653282, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2616, 386.323089, 1584.275146, -76.683280, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19327, 382.048431, 1586.795532, -76.283256, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 12853, "cunte_gas01", "starspangban1_256", 0x00000000);
	jailint = CreateDynamicObject(2612, 385.319152, 1578.123291, -76.653282, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(2612, 385.319152, 1579.833618, -76.653282, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19853, "mihouse1", "yellowwall1", 0x00000000);
	jailint = CreateDynamicObject(19446, 375.686828, 1575.177490, -79.063293, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10051, "carimpound_sfe", "poundwall1_sfe", 0x00000000);
	jailint = CreateDynamicObject(19446, 375.636871, 1575.478027, -80.283309, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19446, 375.636871, 1579.358032, -80.283309, -0.000030, 180.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "smileyface1", 0x00000000);
	jailint = CreateDynamicObject(19940, 379.604248, 1575.180053, -77.313278, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 377.634155, 1575.180053, -77.313278, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 375.644165, 1575.180053, -77.313278, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 373.654174, 1575.180053, -77.313278, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19940, 371.654113, 1575.180053, -77.313278, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(2708, 376.467224, 1571.849731, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(2708, 378.867279, 1571.849731, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(936, 380.404174, 1572.205200, -78.083290, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	jailint = CreateDynamicObject(19327, 372.541259, 1577.417480, -75.763259, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "{000000}PRISON ENTRANCE", 80, "Ariel", 19, 1, 0x00000000, 0x00000000, 1);
	jailint = CreateDynamicObject(1499, 384.362243, 1584.165649, -78.603317, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(jailint, 1, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1533, 378.326690, 1608.049072, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 376.836669, 1608.049072, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 375.433837, 1599.903076, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2206, 378.263854, 1599.923095, -78.543289, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 378.746887, 1597.497070, -77.313278, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	entranceLobby[2] = CreateDynamicObject(19302, 380.491088, 1597.487548, -77.313262, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 382.236877, 1597.497070, -77.313278, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 382.236877, 1597.497070, -74.823280, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 378.746887, 1597.497070, -74.833259, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19302, 380.486907, 1597.497070, -74.833259, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 378.359191, 1608.076293, -75.733291, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 375.803924, 1600.326782, -77.563308, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 378.703918, 1598.876831, -77.563308, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 375.868011, 1599.707397, -77.583328, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 378.078002, 1599.017211, -77.583328, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 374.742706, 1598.621704, -75.983291, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2606, 374.742706, 1598.621704, -76.513290, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2010, 375.367187, 1596.965209, -78.543289, 0.000022, 0.000018, 49.999992, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 377.856262, 1601.843505, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 375.959686, 1598.266967, -78.543289, -0.000022, 0.000018, -51.200000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 375.447937, 1607.651489, -78.073303, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2241, 380.968017, 1607.651489, -78.073303, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2690, 375.089141, 1601.338745, -76.953308, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19611, 378.492980, 1593.291259, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19623, 378.481872, 1593.291381, -76.903327, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 378.582885, 1589.290039, -76.563308, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2308, 386.391906, 1595.909057, -78.543289, 0.000000, 0.000037, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 386.526123, 1597.079956, -77.773292, -0.000000, 0.000037, -0.999999, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 386.415252, 1596.081298, -77.733276, 0.000037, 0.000000, 89.999885, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 387.608062, 1596.095581, -78.543289, 0.000037, 0.000000, 89.999885, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 388.978088, 1595.485351, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2174, 390.157409, 1587.161987, -78.543289, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2175, 390.148742, 1585.229125, -78.543289, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 388.686645, 1585.593139, -78.543289, -0.000026, 0.000012, -65.599983, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2190, 390.215209, 1584.421020, -77.773292, -0.000018, -0.000024, -143.100006, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19808, 390.035278, 1585.541748, -77.733276, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 386.641784, 1590.065795, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 387.641784, 1591.035888, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2165, 379.801757, 1589.735351, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 387.328125, 1588.805297, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 387.108154, 1592.095581, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, 379.188110, 1591.235229, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2615, 384.376586, 1597.337158, -76.613281, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19787, 390.608703, 1592.237792, -76.633300, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2202, 390.153930, 1592.943603, -78.543289, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2700, 375.159362, 1596.911254, -76.034729, -0.000012, 15.200026, -23.600000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 384.446655, 1571.658325, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19810, 382.557586, 1571.650268, -76.833267, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 372.516662, 1575.868408, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 372.516662, 1577.368774, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 378.719543, 1572.010620, -76.753273, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 377.729522, 1572.010620, -76.753273, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 376.269531, 1572.010620, -76.753273, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 375.329467, 1572.010620, -76.753273, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.889526, 1572.006713, -78.303306, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.289550, 1572.006713, -78.303306, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 377.619537, 1572.006713, -78.303306, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 377.619537, 1572.006713, -77.463294, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.289550, 1572.006713, -77.983299, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 377.619537, 1572.006713, -77.983291, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.289550, 1572.006713, -77.453285, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.889526, 1572.006713, -77.983314, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 378.889526, 1572.006713, -77.453315, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 376.463745, 1571.930908, -78.303314, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 375.933776, 1571.930908, -78.303314, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 375.373840, 1571.930908, -78.003334, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 375.373840, 1571.930908, -77.463325, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 375.893829, 1571.930908, -77.463325, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 374.037658, 1571.769042, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2167, 373.027679, 1571.769042, -78.543289, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 380.294372, 1571.349243, -77.613296, 0.000020, 0.000020, 44.999984, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 385.187011, 1574.681884, -78.043395, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 386.436950, 1584.421386, -78.043395, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 376.116943, 1589.481689, -78.043395, 0.000000, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1738, 375.206970, 1604.361572, -78.043395, -0.000030, 0.000000, -89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, 381.735351, 1597.219970, -78.543289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 382.296661, 1587.761352, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 372.726745, 1574.131103, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 373.131866, 1576.036499, -74.939231, 18.300025, -0.000006, 102.399909, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 383.731506, 1572.283081, -74.921684, 16.099998, -0.000030, 179.999816, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 390.131958, 1584.615844, -74.964241, 12.699976, -0.000022, -137.199996, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 381.201110, 1607.549194, -75.007385, 18.099981, 0.000026, -31.199991, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 377.856262, 1606.043823, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 377.856262, 1593.143554, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 384.856323, 1593.143554, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 384.856323, 1587.893432, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 383.156372, 1581.673706, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 383.156372, 1576.333496, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 377.366333, 1576.333496, -74.973289, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3657, 383.892883, 1596.987182, -78.033317, 0.000000, 0.000030, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 381.467864, 1604.171875, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 381.467864, 1604.842529, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 381.467864, 1603.501708, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1722, 381.467864, 1602.851074, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 382.693054, 1597.154418, -78.178771, -37.799976, 90.000030, -0.199974, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 383.463073, 1597.151245, -78.178771, -37.799976, 90.000030, -0.199974, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 384.263000, 1597.148559, -78.178771, -37.799976, 90.000030, -0.199974, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11750, 385.052947, 1597.146118, -78.178771, -37.799976, 90.000030, -0.199974, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1302, 375.281982, 1605.953247, -78.543289, 0.000030, 0.000000, 89.999908, 9, -1, -1, 600.00, 600.00);

	//HODNIK
	jailint = CreateDynamicObject(19379, 24.261459, 1816.089477, 1402.666625, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 24.261459, 1806.480346, 1402.666625, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 24.261459, 1796.849975, 1402.666625, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, 34.761306, 1801.320678, 1402.666625, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.494003, 1810.818481, 1404.402832, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.494003, 1820.448608, 1404.402832, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 24.623855, 1820.948486, 1404.402832, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.473785, 1816.089355, 1404.402832, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.473785, 1806.460693, 1404.402832, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.473785, 1796.851440, 1404.402832, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 25.253784, 1792.092041, 1404.402832, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.163803, 1793.101928, 1404.402832, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.883834, 1797.892578, 1404.402832, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 38.693771, 1801.362182, 1404.402832, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 34.223861, 1806.052124, 1404.402832, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19379, 24.741455, 1816.089477, 1406.197631, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 24.741455, 1806.469482, 1406.197631, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 24.741455, 1796.839965, 1406.197631, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 35.231552, 1800.039916, 1406.197631, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 35.231552, 1809.649902, 1406.197631, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.883834, 1801.642822, 1404.402832, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
	jailint = CreateDynamicObject(19446, 24.643829, 1820.782592, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.653915, 1815.902099, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.653915, 1806.312255, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.653915, 1796.692138, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 24.313842, 1792.272216, 1401.013671, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 28.983810, 1793.302978, 1401.013671, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.723709, 1798.042724, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.833755, 1801.453735, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.833755, 1801.623901, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.833755, 1801.804077, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 34.223800, 1805.894287, 1401.013671, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 38.513839, 1801.043090, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.353866, 1810.622924, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.353866, 1816.403320, 1401.013671, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.483901, 1810.763671, 1407.723510, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.483993, 1816.074462, 1407.723510, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.483993, 1806.454956, 1407.723510, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 20.483993, 1796.845458, 1407.723510, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 25.343963, 1792.105346, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 25.343963, 1820.945800, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.483901, 1820.353881, 1407.723510, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 34.223831, 1806.034057, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.863815, 1797.903198, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 38.673904, 1802.802978, 1407.723510, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.154067, 1793.062988, 1407.723510, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.863815, 1801.633544, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19446, 33.863815, 1801.663574, 1407.723510, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 21.139831, 1820.135620, 1403.072875, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(1300, 28.589889, 1793.345092, 1403.072875, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 9583, "bigshap_sfw", "freighterhull1", 0x00000000);
	jailint = CreateDynamicObject(19172, 20.565429, 1807.746093, 1404.562988, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14842, "genintintpolicea", "cop_notice", 0x00000000);
	jailint = CreateDynamicObject(19172, 29.405227, 1808.896728, 1404.562988, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0x00000000);
	jailint = CreateDynamicObject(19172, 22.165222, 1792.177734, 1404.562988, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10023, "bigwhitesfe", "lomall_ext2_", 0x00000000);
	jailint = CreateDynamicObject(19385, 29.973556, 1803.331787, 1404.392700, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.964004, 1809.753295, 1404.402832, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19385, 29.973556, 1799.940673, 1404.392700, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19446, 29.963882, 1793.542846, 1404.372802, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0x00000000);
	jailint = CreateDynamicObject(19430, 31.648788, 1802.663818, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 31.648788, 1804.263916, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 31.648788, 1805.823974, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 35.138687, 1805.803955, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 38.638687, 1805.823974, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 38.588638, 1804.223388, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 38.598709, 1802.623657, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 35.098709, 1802.623657, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
	jailint = CreateDynamicObject(19430, 35.098709, 1804.204101, 1402.672485, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "sm_conc_hatch", 0x00000000);
    jailint = CreateDynamicObject(19477, 24.993619, 1820.845214, 1405.602905, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "YARD", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 33.093616, 1805.941894, 1404.021728, -0.000007, -0.000007, -90.000068, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "BLOCK", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 20.573595, 1812.362304, 1405.612548, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "LAUNDRY", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 32.883609, 1797.994506, 1405.612548, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "AMBULANCE", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 20.573595, 1795.832397, 1405.612548, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "LIBRARY", 140, "Ariel", 70, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 20.573595, 1816.893066, 1404.021728, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "SECTOR", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 20.573595, 1816.893066, 1404.732299, 0.000000, 0.000000, 720.000000, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C", 130, "Ariel", 160, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 29.033615, 1795.691650, 1404.021728, 0.000000, 0.000000, 179.999893, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "SECTOR", 130, "Ariel", 100, 1, 0xFF000000, 0x00000000, 1);
    jailint = CreateDynamicObject(19477, 29.033615, 1795.691650, 1404.732299, 0.000000, 0.000000, 179.999893, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C", 130, "Ariel", 160, 1, 0xFF000000, 0x00000000, 1);
	jailint = CreateDynamicObject(19477, 33.093616, 1805.941894, 1404.732299, -0.000007, -0.000007, -90.000068, -1, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterialText(jailint, 0, "C", 130, "Ariel", 160, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1216, 29.104171, 1818.059204, 1403.313110, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 29.104171, 1817.328491, 1403.313110, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1216, 29.104171, 1816.597900, 1403.313110, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11714, 24.983444, 1820.863525, 1403.993774, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 25.358337, 1792.204833, 1402.752563, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 20.598236, 1801.025146, 1402.752563, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 20.598236, 1811.635498, 1402.752563, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 29.378189, 1813.156494, 1402.752563, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 20.598236, 1802.515869, 1402.752563, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 20.598236, 1795.065063, 1402.752563, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 24.805450, 1795.593994, 1406.523925, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	hallDoors[4] = CreateDynamicObject(1495, 29.935562, 1802.626953, 1402.752563, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	hallDoors[5] = CreateDynamicObject(1495, 29.935562, 1800.716918, 1402.752563, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 24.805450, 1803.844238, 1406.523925, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 24.805450, 1811.263793, 1406.523925, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 24.805450, 1818.143676, 1406.523925, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 34.155349, 1803.654174, 1406.523925, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 34.155349, 1799.853637, 1406.523925, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 20.862991, 1792.784667, 1406.301635, 19.700006, -0.000014, 154.399963, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 28.903213, 1820.168945, 1406.319091, 20.599988, 0.000013, -34.799983, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 35.638290, 1805.936035, 1402.752563, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 37.858291, 1798.005737, 1402.752563, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 33.708358, 1798.005737, 1402.752563, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1533, 26.858383, 1792.204833, 1402.752563, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 35.009811, 1797.979492, 1404.292480, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);

	//LAUNDRY
	jailint = CreateDynamicObject(19379, 298.131347, 1855.107543, 1414.672241, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10765, "airportgnd_sfse", "sf_pave2", 0x00000000);
	jailint = CreateDynamicObject(19379, 307.761413, 1855.107543, 1414.672241, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 10765, "airportgnd_sfse", "sf_pave2", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.481262, 1855.133300, 1416.318359, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 302.331298, 1859.292846, 1416.318359, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.941345, 1859.292846, 1416.318359, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.581390, 1854.563110, 1416.318359, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 306.751373, 1850.983642, 1416.318359, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.151275, 1850.983642, 1416.318359, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19379, 307.761413, 1855.107543, 1418.131591, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, 298.131378, 1855.107543, 1418.131591, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(936, 308.365295, 1858.613647, 1415.218139, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(936, 310.235412, 1858.613647, 1415.218139, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19430, 311.518035, 1852.964355, 1416.388061, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(19430, 311.518035, 1852.964355, 1415.807495, 0.000015, 90.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(2371, 306.726440, 1851.604125, 1414.738159, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(2371, 303.966522, 1851.604125, 1414.738159, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(2371, 301.596557, 1851.604125, 1414.738159, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19454, 302.331298, 1851.163818, 1413.018310, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.811279, 1851.163818, 1413.018310, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 302.311279, 1859.124633, 1413.018310, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.811279, 1859.124633, 1413.018310, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.661376, 1854.364624, 1413.018310, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.421264, 1854.364624, 1413.018310, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 311.571380, 1854.364624, 1419.658691, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 306.761352, 1859.254272, 1419.658691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.141296, 1859.254272, 1419.658691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.501342, 1855.734252, 1419.658691, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 306.761352, 1850.993652, 1419.658691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 297.181335, 1850.993652, 1419.658691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19454, 303.921264, 1852.343627, 1413.018798, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 299.191223, 1847.533569, 1413.018798, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19454, 308.651153, 1847.533569, 1413.018798, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19438, 304.632568, 1854.299926, 1413.967651, 89.999992, 180.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19438, 304.632568, 1855.569702, 1413.967651, 89.999992, 180.000000, -89.999977, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1537, 297.606384, 1855.877197, 1414.758178, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 303.518066, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 304.188049, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 304.848144, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 305.518127, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 306.178100, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 306.848083, 1858.903808, 1414.758178, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 303.518066, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 304.188049, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 304.848144, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 305.518127, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 306.178100, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1208, 306.848083, 1858.903808, 1415.668823, 0.000000, -0.000022, 179.999862, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1345, 300.538635, 1858.452026, 1415.528442, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 301.256347, 1857.001342, 1414.758178, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 301.555847, 1858.084838, 1414.758178, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 310.881774, 1858.802246, 1415.798217, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 310.331787, 1858.802246, 1415.798217, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 310.315429, 1858.839843, 1415.998413, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 310.845397, 1858.839843, 1415.998413, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2846, 307.966308, 1858.176391, 1415.698364, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2006, 309.206512, 1859.043090, 1415.768432, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19570, 309.040130, 1858.756103, 1415.668457, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19570, 309.040130, 1859.126464, 1415.668457, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19570, 308.880157, 1859.126464, 1415.668457, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1778, 311.570343, 1857.388916, 1414.758178, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1789, 307.308898, 1857.263916, 1415.298706, -0.000014, -0.000003, -103.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 307.307189, 1857.232910, 1415.818237, -0.000003, 0.000014, -14.899997, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 307.307189, 1857.232910, 1415.027465, -0.000003, 0.000014, -14.899997, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 307.307189, 1857.232910, 1415.547973, -0.000003, 0.000014, -14.899997, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2518, 310.941741, 1857.393066, 1414.758178, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2596, 311.195983, 1855.027343, 1417.188720, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2713, 305.770843, 1857.670166, 1414.888305, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2742, 309.063293, 1858.931396, 1416.518188, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1513, 309.688842, 1858.898681, 1415.978515, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, 311.195556, 1856.023193, 1414.748168, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19903, 307.901672, 1858.871704, 1414.887695, -0.000015, -0.000000, -90.799942, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19809, 309.249694, 1858.360473, 1415.748779, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19621, 309.598022, 1858.620483, 1415.788574, 0.000011, 0.000009, 49.599979, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1854.179199, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1853.658935, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1852.538452, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1853.078613, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1851.998535, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2384, 311.094238, 1851.508178, 1416.558593, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1854.213623, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1853.663208, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1853.093139, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1852.512939, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1851.973022, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2386, 311.077239, 1851.462524, 1415.978759, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 306.122558, 1851.989501, 1415.438598, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 306.122558, 1851.319580, 1415.438598, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 300.942596, 1851.319580, 1415.438598, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2392, 300.942596, 1851.970214, 1415.438598, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2382, 303.283111, 1851.994384, 1415.408691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2382, 303.283111, 1851.324218, 1415.408691, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 307.694763, 1854.957519, 1418.468383, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, 300.634826, 1854.957519, 1418.468383, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, 298.205810, 1851.898437, 1418.270263, 20.600011, -0.000011, 133.500030, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, 298.565185, 1859.209838, 1416.548339, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11711, 297.537109, 1855.125976, 1417.588989, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);

	//AMBULANCE C
	jailint = CreateDynamicObject(19379, -104.672668, 1784.995239, -90.832038, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19379, -115.162673, 1784.995239, -90.832038, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	jailint = CreateDynamicObject(19449, -100.549804, 1785.036987, -89.136108, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -105.299812, 1789.586181, -89.136108, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.909805, 1789.586181, -89.136108, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.909805, 1780.295776, -89.136108, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -105.289825, 1780.295776, -89.136108, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.909805, 1784.845581, -89.136108, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(2163, -107.319580, 1789.519042, -88.996070, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(19611, -104.134597, 1789.290405, -90.746109, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19611, -109.684600, 1789.290405, -90.746109, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19087, -109.687049, 1789.300170, -88.616088, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19087, -104.137039, 1789.300170, -88.616088, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19570, -104.137657, 1789.230346, -88.626129, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19570, -109.697662, 1789.230346, -88.626129, 0.000000, 180.000000, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19379, -104.672668, 1784.845825, -87.342071, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19379, -115.172676, 1784.845825, -87.342071, 0.000000, 90.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
	jailint = CreateDynamicObject(19087, -104.793876, 1782.093383, -85.896125, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19993, -111.331825, 1783.476806, -88.315628, 0.000000, -156.999984, 3.099998, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(11744, -111.360008, 1783.476440, -88.391326, 0.000000, -155.000076, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(19893, -112.565269, 1784.768310, -89.926109, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 9818, "ship_brijsfw", "ship_greenscreen1", 0x00000000);
	jailint = CreateDynamicObject(19787, -114.868286, 1785.214599, -88.526084, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 9818, "ship_brijsfw", "ship_screen1sfw", 0x00000000);
	jailint = CreateDynamicObject(19993, -104.798194, 1782.121948, -88.315322, -22.799999, 180.000030, 0.000006, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	jailint = CreateDynamicObject(11744, -104.798469, 1782.102783, -88.393013, -22.199977, 180.000030, 0.000006, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	jailint = CreateDynamicObject(2167, -100.562301, 1788.312011, -90.746101, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(2167, -103.012313, 1780.381347, -90.746101, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	jailint = CreateDynamicObject(19087, -111.363876, 1783.473510, -85.896125, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.885467, 1784.870727, -85.856124, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -110.075469, 1780.330688, -85.856124, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -100.445480, 1780.330688, -85.856124, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -100.565475, 1785.140380, -85.856124, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -105.245475, 1789.580444, -85.856124, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.875473, 1789.580444, -85.856124, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8057, "vgsswarehse02", "ws_warehousewall1", 0x00000000);
	jailint = CreateDynamicObject(19449, -110.195472, 1789.420288, -92.476119, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -100.695480, 1789.420288, -92.476119, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -100.695480, 1784.699829, -92.476119, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -105.515480, 1780.469482, -92.476119, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -115.095474, 1780.469482, -92.476119, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -114.755477, 1785.308959, -92.476119, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -106.885475, 1786.359130, -92.476119, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -102.155471, 1791.239013, -92.476119, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(19449, -111.605468, 1791.239013, -92.476119, -0.000000, 0.000015, -0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 0, 8035, "vgsshospshop", "bincoLogo", 0x00000000);
	jailint = CreateDynamicObject(2260, -102.727661, 1789.017822, -89.346092, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(jailint, 1, 969, "electricgate", "notice01", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	jailint = CreateDynamicObject(1533, -100.709266, 1784.260986, -90.746101, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3390, -108.381530, 1780.934204, -90.746101, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3386, -111.028648, 1780.820556, -90.746101, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3387, -112.351722, 1780.876708, -90.746101, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(3393, -114.172897, 1784.744995, -90.766113, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2343, -104.834335, 1781.738403, -90.156089, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1716, -105.466445, 1782.001708, -90.746101, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2146, -101.341316, 1785.755981, -90.266098, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1789, -111.426239, 1785.444580, -90.196136, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1997, -111.571899, 1783.491333, -90.766105, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2603, -105.129302, 1788.139282, -90.306068, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2603, -108.849304, 1788.139282, -90.306068, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19903, -106.927558, 1788.969726, -91.026092, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19809, -111.632888, 1785.464233, -89.736091, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19918, -110.524856, 1785.592407, -90.746101, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11738, -109.612213, 1781.160522, -89.786102, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11736, -111.297218, 1785.461547, -89.766090, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, -110.875122, 1785.407226, -89.796104, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, -110.945121, 1785.447265, -89.796104, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, -111.366706, 1783.478759, -87.416069, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11745, -109.231246, 1781.674316, -90.616081, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11706, -101.205940, 1780.668945, -90.746101, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11709, -113.512580, 1789.134643, -90.076110, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11707, -111.901374, 1789.430419, -89.306106, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2685, -113.504913, 1789.436523, -88.926109, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2225, -112.846992, 1784.922973, -90.766113, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(19903, -105.937561, 1780.710083, -91.026092, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(932, -110.480102, 1788.976196, -90.746101, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11747, -104.798019, 1782.101196, -87.426086, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, -108.151611, 1782.476928, -90.746101, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1806, -106.881607, 1782.476928, -90.746101, 0.000008, -0.000012, 147.899993, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(11713, -100.665054, 1781.645141, -89.116127, 0.000000, -0.000015, 179.999908, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, -105.263656, 1784.886962, -87.336105, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, -108.693656, 1784.886962, -87.336105, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1893, -112.173652, 1784.886962, -87.336105, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1886, -101.239356, 1788.800903, -87.116439, 12.699981, 0.000010, -47.199996, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2684, -101.940551, 1789.456176, -88.876113, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(2611, -100.688964, 1786.087036, -88.936119, -0.000015, 0.000000, -89.999954, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, -103.455688, 1789.123168, -90.746101, 0.000000, 0.000015, 0.000000, 9, -1, -1, 600.00, 600.00);
	jailint = CreateDynamicObject(1808, -114.526268, 1787.547119, -90.746101, 0.000015, 0.000000, 89.999954, 9, -1, -1, 600.00, 600.00);
	// Skladiste - Kenny
	objectid = CreateDynamicObject(19376,1796.949,-2037.537,2112.512,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 3442, "vegashse4", "Est_corridor_ceiling", 0);
	objectid = CreateDynamicObject(19376,1806.767,-2038.694,2109.042,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 7526, "vgnlowbild", "pavedark128", 0);
	objectid = CreateDynamicObject(19456,1802.421,-2033.900,2114.311,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19456,1802.170,-2036.881,2110.839,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19456,1805.173,-2033.909,2110.839,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19456,1806.387,-2036.827,2114.311,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19456,1800.097,-2036.839,2114.311,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19456,1802.170,-2036.891,2114.311,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19393,1808.440,-2036.886,2110.839,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19394,1808.429,-2036.944,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19457,1814.614,-2036.954,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19438,1807.035,-2037.712,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19457,1811.928,-2041.753,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19457,1802.315,-2038.462,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(941,1810.322,-2037.616,2109.571,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 1842, "shop_shelf1", "formica", 0);
	objectid = CreateDynamicObject(19457,1805.219,-2042.880,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19457,1808.624,-2043.517,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_wallbreeze", 0);
	objectid = CreateDynamicObject(19393,1809.927,-2035.311,2110.839,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 12964, "sw_block09", "GB_truckdepot18", 0);
	objectid = CreateDynamicObject(19378,1815.266,-2032.124,2109.052,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18038, "vegas_munation", "mp_gun_floorred", 0);
	objectid = CreateDynamicObject(19392,1810.016,-2035.301,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8373, "vegass_jetty", "coasty_bit6_sfe", 0);
	objectid = CreateDynamicObject(19455,1814.761,-2036.893,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8373, "vegass_jetty", "coasty_bit6_sfe", 0);
	objectid = CreateDynamicObject(19455,1810.010,-2029.256,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8373, "vegass_jetty", "coasty_bit6_sfe", 0);
	objectid = CreateDynamicObject(19455,1815.244,-2032.799,2110.829,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8373, "vegass_jetty", "coasty_bit6_sfe", 0);
	objectid = CreateDynamicObject(19455,1814.641,-2031.502,2110.829,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8373, "vegass_jetty", "coasty_bit6_sfe", 0);
	objectid = CreateDynamicObject(941,1811.035,-2032.225,2109.596,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 1842, "shop_shelf1", "formica", 0);
	objectid = CreateDynamicObject(941,1813.537,-2032.225,2109.596,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 1842, "shop_shelf1", "formica", 0);
	objectid = CreateDynamicObject(2843,1811.832,-2032.834,2110.069,0.000,0.000,37.220, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 14803, "bdupsnew", "Bdup2_wallpaperC", 0);
	SetDynamicObjectMaterial(objectid, 1, 14803, "bdupsnew", "Bdup2_wallpaperC", 0);
	SetDynamicObjectMaterial(objectid, 2, 14803, "bdupsnew", "Bdup2_wallpaperC", 0);
	SetDynamicObjectMaterial(objectid, 3, 8423, "pirateship01", "tislndshpmast", 0);
	objectid = CreateDynamicObject(2704,1811.377,-2032.707,2111.701,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 1, 14803, "bdupsnew", "Bdup2_wallpaperC", 0);
	objectid = CreateDynamicObject(19379,1811.707,-2036.236,2112.497,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 4550, "skyscr1_lan2", "sl_librarycolmn2", 0);
	objectid = CreateDynamicObject(19379,1810.364,-2043.203,2112.487,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 4550, "skyscr1_lan2", "sl_librarycolmn2", 0);
	objectid = CreateDynamicObject(1569,1800.160,-2035.963,2112.566,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 16093, "a51_ext", "des_backdoor1", 0);
	objectid = CreateDynamicObject(19379,1802.338,-2035.565,2115.925,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 4550, "skyscr1_lan2", "sl_librarycolmn2", 0);

		// Staticni
	CreateDynamicObject(14407,1803.997,-2035.851,2109.385,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1431,1811.392,-2040.162,2109.129,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1431,1811.374,-2042.052,2109.667,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1721,1805.690,-2038.718,2109.338,0.000,45.000,247.240, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1721,1805.745,-2039.299,2109.428,0.000,90.000,247.240, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1744,1805.868,-2038.727,2109.481,0.000,-70.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(14882,1814.981,-2041.055,2110.906,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2900,1805.884,-2042.944,2110.292,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2900,1807.011,-2042.934,2109.129,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2900,1805.894,-2042.934,2109.129,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1208,1812.510,-2036.525,2109.138,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1208,1813.213,-2036.525,2109.138,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1208,1813.918,-2036.525,2109.138,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1208,1814.636,-2036.525,2109.138,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(18074,1810.569,-2032.693,2111.931,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2386,1814.172,-2031.888,2110.070,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2386,1814.680,-2031.883,2110.175,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2689,1811.009,-2032.695,2111.708,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2986,1815.125,-2036.120,2112.356,180.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1494,1809.177,-2036.924,2109.084,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1494,1809.939,-2034.532,2109.084,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(3785,1801.667,-2034.070,2114.732,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(3785,1811.732,-2039.162,2112.000,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(3785,1811.732,-2041.354,2112.000,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1886,1800.741,-2036.354,2115.947,28.000,0.000,120.100, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1025,1810.662,-2037.296,2110.512,0.000,-15.000,270.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(18633,1809.944,-2037.853,2110.075,0.000,90.000,320.861, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(3785,1815.064,-2033.687,2111.721,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(3785,1813.064,-2036.701,2111.721,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1886,1810.816,-2036.256,2112.544,26.599,0.000,129.799, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1886,1805.729,-2039.117,2112.547,25.900,0.000,42.600, -1, -1, -1, 50.0, 50.0);

	// Bolnica - Kenny
	objectid = CreateDynamicObject(19379,1595.519,-1974.351,2131.574,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 9907, "monlith_sfe", "window5b", 0);
	objectid = CreateDynamicObject(19445,1600.231,-1972.690,2133.377,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19399,1599.226,-1971.023,2133.377,0.000,0.000,45.000);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19353,1599.879,-1971.684,2133.377,0.000,0.000,45.000);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(2254,1598.830,-1970.566,2133.520,0.000,0.000,-45.000);
	SetDynamicObjectMaterial(objectid, 0, 8396, "sphinx01", "luxorceiling02_128", 0);
	objectid = CreateDynamicObject(19445,1598.507,-1974.867,2133.377,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19445,1593.364,-1969.990,2133.377,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(2165,1597.833,-1974.205,2131.661,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 3, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0);
	SetDynamicObjectMaterial(objectid, 4, 10226, "sfeship1", "sf_ship_generic8", 0);
	objectid = CreateDynamicObject(19445,1600.231,-1983.096,2133.377,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19445,1587.315,-1974.867,2133.377,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19445,1591.675,-1973.939,2133.377,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(19399,1600.241,-1976.778,2133.377,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(2254,1600.203,-1977.666,2133.520,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 8396, "sphinx01", "luxorceiling02_128", 0);
	objectid = CreateDynamicObject(19445,1596.067,-1978.686,2133.377,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0);
	objectid = CreateDynamicObject(2610,1599.376,-1978.496,2131.660,0.000,0.000,179.400, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 2, 14576, "mafiacasinovault01", "ab_vaultmetal", 0);
	objectid = CreateDynamicObject(1369,1593.977,-1977.908,2132.257,0.000,0.000,132.381, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	SetDynamicObjectMaterial(objectid, 1, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	SetDynamicObjectMaterial(objectid, 2, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	SetDynamicObjectMaterial(objectid, 3, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	SetDynamicObjectMaterial(objectid, 4, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	objectid = CreateDynamicObject(2610,1597.531,-1978.496,2131.660,0.000,0.000,179.699, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 2, 14576, "mafiacasinovault01", "ab_vaultmetal", 0);
	objectid = CreateDynamicObject(1369,1593.487,-1970.677,2132.257,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	SetDynamicObjectMaterial(objectid, 1, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	SetDynamicObjectMaterial(objectid, 2, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	SetDynamicObjectMaterial(objectid, 3, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	SetDynamicObjectMaterial(objectid, 4, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	SetDynamicObjectMaterial(objectid, 5, 14745, "rystuff", "mp_CJ_CHROME2", 0);
	SetDynamicObjectMaterial(objectid, 6, 2994, "trolex", "trolley03", 0);
	SetDynamicObjectMaterial(objectid, 7, 2994, "trolex", "trolley03", 0);
	SetDynamicObjectMaterial(objectid, 8, 2994, "trolex", "trolley03", 0);
	objectid = CreateDynamicObject(1671,1599.557,-1973.479,2132.104,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 1, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	objectid = CreateDynamicObject(1721,1596.000,-1973.865,2131.662,0.000,0.000,283.067);
	SetDynamicObjectMaterial(objectid, 0, 6283, "pierb_law2", "sancorn6", 0);
	SetDynamicObjectMaterial(objectid, 1, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	objectid = CreateDynamicObject(2167,1599.227,-1974.854,2131.661,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0);
	objectid = CreateDynamicObject(2687,1595.065,-1974.744,2133.489,0.000,0.000,-179.900);
	SetDynamicObjectMaterial(objectid, 0, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	objectid = CreateDynamicObject(1569,1591.739,-1973.037,2131.635,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 16093, "a51_ext", "des_backdoor1", 0);
	objectid = CreateDynamicObject(1721,1595.674,-1975.103,2131.662,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 6283, "pierb_law2", "sancorn6", 0);
	SetDynamicObjectMaterial(objectid, 1, 11631, "mp_ranchcut", "mpCJ_SPEAKER4", 0);
	objectid = CreateDynamicObject(1738,1599.974,-1975.826,2132.277,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	SetDynamicObjectMaterial(objectid, 1, 18056, "mp_diner1", "mp_cj_sheetmetal", 0);
	objectid = CreateDynamicObject(19377,1596.370,-1974.533,2135.051,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 1684, "portakabin", "ws_portacabin3", 0);
	objectid = CreateDynamicObject(2709,1597.655,-1972.950,2132.556,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 1246, "icons", "pill_32", 0);
	SetDynamicObjectMaterial(objectid, 1, 6873, "vgnshambild1", "fitzwallvgn1_256", 0);
	objectid = CreateDynamicObject(2258,1597.603,-1974.970,2133.842,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(objectid, 0, 14599, "paperchasebits", "sign_firstaid", 0);
	SetDynamicObjectMaterial(objectid, 1, 14599, "paperchasebits", "sign_firstaid", 0);
	// Bolnica
	tmpobjid = CreateDynamicObjectEx(19858, 1842.233398, -1531.345947, 2008.587646, 0.000000, 0.000000, 0.000000, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(1368, 1844.734008, -1538.831298, 2008.038818, 0.000000, 0.000000, -124.919998, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(1721, 1841.699707, -1533.591308, 2007.352050, 0.000000, 0.000000, 270.000000, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(1721, 1841.707519, -1534.206787, 2007.352050, 0.000000, 0.000000, 270.000000, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(1721, 1841.713134, -1534.818969, 2007.352050, 0.000000, 0.000000, 270.000000, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(2167, 1845.937133, -1533.277465, 2007.333496, 0.000000, 0.000000, -53.819999, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(19172, 1841.553955, -1534.227172, 2009.542358, 0.000000, 0.000000, 90.000000, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(2001, 1844.319335, -1531.586425, 2007.341430, 0.000000, 0.000000, 57.540008, 500.00, 500.00);
	tmpobjid = CreateDynamicObjectEx(1808, 1841.739868, -1535.947143, 2007.354492, 0.000000, 0.000000, 90.000000, 500.00, 500.00);
	// Staticni
	CreateDynamicObject(19379,1595.552,-1983.879,2131.564,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1997,1595.260,-1970.755,2131.660,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1997,1598.568,-1977.506,2131.660,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1997,1596.703,-1977.506,2131.660,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2690,1595.090,-1974.625,2133.502,0.000,0.000,180.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2518,1596.707,-1970.580,2131.691,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2685,1597.566,-1970.107,2133.443,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(14677,1597.662,-1968.329,2132.862,0.000,90.000,0.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2647,1597.576,-1978.347,2132.617,0.000,0.000,280.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(2687,1600.097,-1973.063,2133.690,0.000,0.000,270.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1886,1599.538,-1974.335,2135.081,15.000,0.000,249.456, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1886,1592.373,-1978.057,2135.081,15.000,0.000,123.874, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1893,1595.829,-1973.144,2135.471,0.000,0.000,90.000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(1893,1596.871,-1976.358,2135.471,0.000,0.000,0.000, -1, -1, -1, 50.0, 50.0);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	//Novi zatvor

	RemoveBuildingForPlayer(playerid, 13191, 65.257, -303.984, 14.453, 0.250);
	RemoveBuildingForPlayer(playerid, 13192, 164.710, -234.187, 0.476, 0.250);
	RemoveBuildingForPlayer(playerid, 13193, 173.515, -323.820, 0.515, 0.250);
	RemoveBuildingForPlayer(playerid, 13194, 140.593, -305.390, 5.593, 0.250);
	RemoveBuildingForPlayer(playerid, 13195, 36.828, -256.226, 0.468, 0.250);
	RemoveBuildingForPlayer(playerid, 1426, 29.171, -292.273, 1.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1431, 36.429, -291.062, 1.570, 0.250);
	RemoveBuildingForPlayer(playerid, 1426, 24.593, -291.757, 1.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1438, 29.234, -286.054, 1.218, 0.250);
	RemoveBuildingForPlayer(playerid, 1440, 32.406, -289.218, 1.648, 0.250);
	RemoveBuildingForPlayer(playerid, 1438, 33.601, -279.351, 1.117, 0.250);
	RemoveBuildingForPlayer(playerid, 12861, 36.828, -256.226, 0.468, 0.250);
	RemoveBuildingForPlayer(playerid, 1450, 43.484, -252.570, 1.203, 0.250);
	RemoveBuildingForPlayer(playerid, 1449, 43.109, -254.960, 1.218, 0.250);
	RemoveBuildingForPlayer(playerid, 12859, 173.515, -323.820, 0.515, 0.250);
	RemoveBuildingForPlayer(playerid, 12805, 65.257, -303.984, 14.453, 0.250);
	RemoveBuildingForPlayer(playerid, 13198, 140.593, -305.390, 5.593, 0.250);
	RemoveBuildingForPlayer(playerid, 12956, 96.328, -261.195, 3.859, 0.250);
	RemoveBuildingForPlayer(playerid, 12860, 164.710, -234.187, 0.476, 0.250);

	//--

	RemoveBuildingForPlayer(playerid, 4000, 1787.13, -1565.68, 11.9688, 250.0); // Walls
	RemoveBuildingForPlayer(playerid, 4080, 1787.13, -1565.68, 11.9688, 250.0); // LOD
	//Govornice
	RemoveBuildingForPlayer(playerid, 1216, 1805.406, -1600.460, 13.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1216, 1806.390, -1599.617, 13.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1216, 1807.382, -1598.781, 13.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1216, 1808.375, -1597.921, 13.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1216, 1809.343, -1597.085, 13.226, 0.250);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_JAILJOB)
	{
	    if(PlayerJail[playerid][pJailJob] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec si zaposlen u zatvoru!");
		if(!response)
	    {
	        SendMessage(playerid, MESSAGE_TYPE_ERROR,"{FBE204}* Odbili ste zatvorski posao smecara.");
	        return true;
		}
		if(response)
	    {
	        SendMessage(playerid, MESSAGE_TYPE_ERROR,"{FBE204}* Od sada u zatvoru mozete raditi kao smecar. Dobijacete honorarni posao. Da zapocnete pisite /jailjob.");
	        PlayerJail[playerid][pJailJob] = 1;
	        return true;
		}
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if(PRESSED(KEY_NO))
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1179.748779, 1558.777099, 2092.509277))
		{
		    if(EasternGatesStatus == GATES_CLOSED) {
				MoveDynamicObject(movefridge[0], 1179.748779-1.10, 1558.777099-1.10, 2092.509277, 3);
				EasternGatesStatus = GATES_OPENING;
			} else {
				MoveDynamicObject(movefridge[0], 1179.748779, 1558.777099, 2092.509277, 3);
				EasternGatesStatus = GATES_CLOSED;
			}
		}
	}
	if(PRESSED(KEY_YES)) {
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 172.49, -297.83, 4.13)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(EasternGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[0], 172.493026, -297.830718, -3.9, 3);
				EasternGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[0], 172.493026, -297.830718, 4.131583, 3);
				EasternGatesStatus = GATES_CLOSED;
			}
		}
		
		//SD Holding
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1198.929687, 1308.806274, -54.487152)) { //CELL 1
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(sdholdingStatus[0] == 0) {
				MoveDynamicObject(sdholding[0],1197.368408, 1308.926391, -54.487152, 2.5);
				sdholdingStatus[0] = 1;
			}
			else if(sdholdingStatus[0] == 1) {
				MoveDynamicObject(sdholding[0],1198.929687, 1308.806274, -54.487152, 2.5);
				sdholdingStatus[0] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1195.729125, 1308.806274, -54.487152)) { //CELL 2
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(sdholdingStatus[1] == 0) {
				MoveDynamicObject(sdholding[1],1194.138793, 1308.916381, -54.487152, 2.5);
				sdholdingStatus[1] = 1;
			}
			else if(sdholdingStatus[1] == 1) {
				MoveDynamicObject(sdholding[1],1195.729125, 1308.806274, -54.487152, 2.5);
				sdholdingStatus[1] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1192.489501, 1308.806274, -54.487152)) { //CELL 3
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(sdholdingStatus[2] == 0) {
				MoveDynamicObject(sdholding[2],1190.928222, 1308.926391, -54.487152, 2.5);
				sdholdingStatus[2] = 1;
			}
			else if(sdholdingStatus[2] == 1) {
				MoveDynamicObject(sdholding[2],1192.489501, 1308.806274, -54.487152, 2.5);
				sdholdingStatus[2] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1948.366577, 813.474853, -46.362178)) { //CELL 4
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(sdholdingStatus[3] == 0) {
				MoveDynamicObject(sdholding[3],1187.778442, 1308.916381, -54.487152, 2.5);
				sdholdingStatus[3] = 1;
			}
			else if(sdholdingStatus[3] == 1) {
				MoveDynamicObject(sdholding[3],1948.366577, 813.474853, -46.362178, 2.5);
				sdholdingStatus[3] = 0;
			}
		}
		
		//
		
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1948.366577, 813.474853, -46.362178)) { //CELL 1
			if(arrestcellC[0] == 0) {
				MoveDynamicObject(arrestcell[0],1948.366577, 13.474853-1.6, -46.362178, 6.0);
				arrestcellC[0] = 1;
			}
			else if(arrestcellC[0] == 1) {
				MoveDynamicObject(arrestcell[0],1948.366577, 813.474853, -46.362178, 6.0);
				arrestcellC[0] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1950.111694, 813.474853, -46.362178)) { //CELL 2
			if(arrestcellC[1] == 0) {
				MoveDynamicObject(arrestcellC[1],1950.111694, 813.474853-1.6, -46.362178, 6.0);
				arrestcellC[1] = 1;
			}
			else if(arrestcellC[1] == 1) {
				MoveDynamicObject(arrestcell[1],1950.111694, 813.474853, -46.362178, 6.0);
				arrestcellC[1] = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 1.0, 108.0369, -256.7454, 1.5781))
		{
  			if(!IsPlayerInAnyVehicle(playerid))
	    	{
	    	    if(PlayerJail[playerid][pJailJob] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Imas zatvorski posao!");
	    	    if(PlayerJail[playerid][pJailed] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nije te PD uhapsiom, zato ne mozes raditi zatvorski posao!");
				ShowPlayerDialog(playerid, DIALOG_JAILJOB, DIALOG_STYLE_MSGBOX, "{FBE204}Zatvorski posao", "Da li zelite da radite kao smecar u zatvoru?\nDobijate honorarnu platu, plus vam se smanjuje kazna.", "Yes", "No");
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 69.644668, -227.206695, 1.308123)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(prisonrampstatus == 0) {
				SetDynamicObjectRot(prisonramp, 0.0000, 0.0000, 0.0000);
				prisonrampstatus = 1;
			}
			else if(prisonrampstatus == 1) {
				SetDynamicObjectRot(prisonramp, 0.0000, -90.0000, 0.0000);
				prisonrampstatus = 0;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 172.35, -329.10, 4.13)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(SouthernGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[1], 172.352340, -329.109924, -3.9, 3);
				SouthernGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[1], 172.352340, -329.109924, 4.131583, 3);
				SouthernGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 198.252288, -320.283996, 1.745738)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(SouthernGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(greygate, 198.252288, -320.283996, -3.9, 3);
				SouthernGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(greygate, 198.252288, -320.283996, 1.745738, 3);
				SouthernGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 77.30, -221.57, 4.16)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(SouthernGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[2], 77.302185, -221.571090, -3.9, 3);
				SouthernGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[2], 77.302185, -221.571090, 4.160345, 3);
				SouthernGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 66.34, -248.72, 4.13)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(SouthernGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[3], 66.342163, -248.721160, -3.9, 3);
				SouthernGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[3], 66.342163, -248.721160, 4.130342, 3);
				SouthernGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 172.35, -339.93, 4.13)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

			if(SouthernGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se otvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[4], 172.352340, -339.930145, -3.9, 3);
				SouthernGatesStatus = GATES_OPENING;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Prison vrata~n~~b~~h~se zatvaraju!", 3000, 3);
				MoveDynamicObject(LSPrisonGatesObject[4], 172.352340, -339.930145, 4.131583, 3);
				SouthernGatesStatus = GATES_CLOSED;
			}
		}
		//HALLWAY DOORS WORLD 7
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 260.545715, 1802.626953, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [0], 0.00000, 0.00000, 180.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [0], 0.000,0.000, 90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 260.545715, 1800.716918, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [1], 0.00000, 0.00000, 0.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [1], 0.000, 0.000, -90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//HALLWAY DOORS WORLD 8
        else if(IsPlayerInRangeOfPoint(playerid, 2.5, 147.725601, 1802.626953, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [3], 0.00000, 0.00000, 180.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [3], 0.000,0.000, 90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 147.725601, 1800.716918, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [4], 0.00000, 0.00000, 0.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [4], 0.000, 0.000, -90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//HALLWAY DOORS WORLD 9
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 29.935562, 1802.626953, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [4], 0.00000, 0.00000, 180.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [4], 0.000,0.000, 90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 29.935562, 1800.716918, 1402.752563)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [5], 0.00000, 0.00000, 0.0000);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(hallDoors [5], 0.000, 0.000, -90.0000);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//Lobby Door World 7
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 243.30128, 1715.31787, -77.31326)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [A] ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [0],243.301284-1.6, 1715.317871, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [A] ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [0],243.301284, 1715.317871, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//Lobby Door World 8

		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 243.301284, 1597.487548, -77.313262)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [B] ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [1],243.301284-1.6, 1597.487548, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [B] ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [1],243.301284, 1597.487548, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//Lobby Door World 9
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 380.491088, 1597.487548, -77.313262)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallEastGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [C] ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [2],380.491088-1.6, 1597.487548, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Lobby vrata [C] ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(entranceLobby [2],380.491088, 1597.487548, -77.313262, 6.0);
				SmallEastGatesStatus = GATES_CLOSED;
			}
		}
		//Block A World 7
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1781.1902, -1539.0604, 8.8641)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(SmallSouthGatesStatus == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata 2~n~~b~~h~su otvorena!", 3000, 3);
				SetDynamicObjectRot(smalldoors1, 0.00000, 0.00000, 357.52155);
				SmallSouthGatesStatus = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata 2~n~~b~~h~su zatvorena!", 3000, 3);
				SetDynamicObjectRot(smalldoors1, 0.0000, 0.0000, 95.2370);
				SmallSouthGatesStatus = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 220.65875, 1902.12658, 1374.67797)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus [0] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockA[0],220.658752+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[0],220.658752, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_CLOSED;
			}
		}

		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 223.85881, 1902.12658, 1374.67797)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[1] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
                MoveDynamicObject(blockA[1],223.858810+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[1],223.858810, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 217.44882, 1902.12658, 1374.67797)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[2] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[2],217.448822+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[2],217.448822, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 214.25872, 1902.12658, 1374.67797)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[3] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[3],214.258728+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[3],214.258728, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 214.25872, 1902.12658, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[4] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[4],214.258728+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[4],214.258728, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 217.45874, 1902.12658, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[5] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[5],217.458740+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[5],217.458740, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 220.64878, 1902.12658, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[6] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[6],220.648788+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[6],220.648788, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 223.85873, 1902.12658, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[7] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[7],223.858734+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[7],223.858734, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1901.25622, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[8] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[8],210.288848+0.10, 1901.256225+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[8],210.288848, 1901.256225, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1898.04626, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[9] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[9],210.288848+0.10, 1898.046264+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[9],210.288848, 1898.046264, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1894.85681, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[10] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[10],210.288848+0.10, 1894.856811+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[10],210.288848, 1894.856811, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1891.63586, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[11] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[11],210.288848+0.10, 1891.635864+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[11],210.288848, 1891.635864, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1888.42529, 1378.19799)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[12] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[12],210.288848+0.10, 1888.425292+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[12],210.288848, 1888.425292, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1888.44531, 1374.69775)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[13] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockA[13],210.288848+0.10, 1888.445312+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[13],210.288848, 1888.445312, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1891.64611, 1374.69775)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[14] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[14],210.288848+0.10, 1891.646118+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[14],210.288848, 1891.646118, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1894.84667, 1374.69775)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[15] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[15],210.288848+0.10, 1894.846679+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[15],210.288848, 1894.846679, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1898.04736, 1374.69775)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[16] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[16],210.288848+0.10, 1898.047363+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[16],210.288848, 1898.047363, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 210.28884, 1901.25805, 1374.69775)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[17] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockA[17],210.288848+0.10, 1901.258056+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockA[17],210.288848, 1901.258056, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_CLOSED;
			}
		}
		//BLOCK B WORLD 8
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 112.938751, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[0] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockB[0],112.938751+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[0],112.938751, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_CLOSED;
			}
		}

		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 116.138809, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[1] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
                MoveDynamicObject(blockB[1],116.138809+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[1],116.138809, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 109.728820, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[2] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[2],109.728820+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[2],109.728820, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 106.538726, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[3] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[3],106.538726+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[3],106.538726, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 106.538726, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[4] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[4],106.538726+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[4],106.538726, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 109.738739, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[5] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[5],109.738739+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[5],109.738739, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 112.928787, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[6] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[6],112.928787+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[6],112.928787, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 116.138732, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[7] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[7],116.138732+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[7],116.138732, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1901.256225, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[8] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[8],102.568847+0.10, 1901.256225+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[8],102.568847, 1901.256225, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1898.046264, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[9] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[9],102.568847+0.10, 1898.046264+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[9],102.568847, 1898.046264, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1894.856811, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[10] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[10],102.568847+0.10, 1894.856811+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[10],102.568847, 1894.856811, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1891.635864, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[11] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[11],102.568847+0.10, 1891.635864+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[11],102.568847, 1891.635864, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1888.425292, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[12] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[12],102.568847+0.10, 1888.425292+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[12],102.568847, 1888.425292, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1888.445312, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[13] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockB[13],102.568847+0.10, 1888.445312+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[13],102.568847, 1888.445312, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1891.646118, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[14] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[14],102.568847+0.10, 1891.646118+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[14],102.568847, 1891.646118, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1894.846679, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[15] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[15],102.568847+0.10, 1894.846679+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[15],102.568847, 1894.846679, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1898.047363, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[16] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[16],102.568847+0.10, 1898.047363+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[16],102.568847, 1898.047363, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 102.568847, 1901.258056, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[17] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockB[17],102.568847+0.10, 1901.258056+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockB[17],102.568847, 1901.258056, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_CLOSED;
			}
		}
		//BLOCK C WORLD 9
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 352.518676, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[0] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockC[0],352.518676+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[0],352.518676, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[0] = GATES_CLOSED;
			}
		}

		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 355.718750, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[1] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
                MoveDynamicObject(blockC[1],355.718750+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[1],355.718750, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[1] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 349.308746, 1902.126586, 1374.677978)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[2] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[2],349.308746+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[2],349.308746, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[2] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 346.118652, 1902.126586, 1374.6779788)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[3] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[3],346.118652+1.5, 1902.126586-0.07, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[3],346.118652, 1902.126586, 1374.677978, 1.0);
				InsideDoorsStatus[3] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 346.118652, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[4] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[4],346.118652+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[4],346.118652, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[4] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 349.318664, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[5] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[5],349.318664+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[5],349.318664, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[5] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 352.508728, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[6] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[6],352.508728+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[6],352.508728, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[6] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 355.718658, 1902.126586, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[7] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[7],355.718658+1.5, 1902.126586-0.07, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[7],355.718658, 1902.126586, 1378.197998, 1.0);
				InsideDoorsStatus[7] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1901.256225, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[8] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[8],342.148773+0.10, 1901.256225+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[8],342.148773, 1901.256225, 1378.197998, 1.0);
				InsideDoorsStatus[8] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1898.046264, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[9] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[9],342.148773+0.10, 1898.046264+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[9],342.148773, 1898.046264, 1378.197998, 1.0);
				InsideDoorsStatus[9] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1894.856811, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[10] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[10],342.148773+0.10, 1894.856811+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[10],342.148773, 1894.856811, 1378.197998, 1.0);
				InsideDoorsStatus[10] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1891.635864, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[11] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[11],342.148773+0.10, 1891.635864+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[11],342.148773, 1891.635864, 1378.197998, 1.0);
				InsideDoorsStatus[11] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1888.425292, 1378.197998)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[12] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[12],342.148773+0.10, 1888.425292+1.5, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[12],342.148773, 1888.425292, 1378.197998, 1.0);
				InsideDoorsStatus[12] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1888.445312, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[13] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
    			MoveDynamicObject(blockC[13],342.148773+0.10, 1888.445312+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[13],342.148773, 1888.445312, 1374.697753, 1.0);
				InsideDoorsStatus[13] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1891.646118, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[14] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[14],342.148773+0.10, 1891.646118+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[14],342.148773, 1891.646118, 1374.697753, 1.0);
				InsideDoorsStatus[14] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1894.846679, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[15] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[15],342.148773+0.10, 1894.846679+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[15],342.148773, 1894.846679, 1374.697753, 1.0);
				InsideDoorsStatus[15] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1898.047363, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[16] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[16],342.148773+0.10, 1898.047363+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[16],342.148773, 1898.047363, 1374.697753, 1.0);
				InsideDoorsStatus[16] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 342.148773, 1901.258056, 1374.697753)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[17] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su otvorena!", 3000, 3);
				MoveDynamicObject(blockC[17],342.148773+0.10, 1901.258056+1.5, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~b~~h~Vrata ~n~~b~~h~su zatvorena!", 3000, 3);
				MoveDynamicObject(blockC[17],342.148773, 1901.258056, 1374.697753, 1.0);
				InsideDoorsStatus[17] = GATES_CLOSED;
			}
		}
//*********************************************************cELIJE*********************************************************
//*********************************************************SAMNICE********************************************************
		else if(IsPlayerInRangeOfPoint(playerid, 2.0,  1848.19641, -1524.76440, 2003.84851)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[13] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '1'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[0], 0.0000, 0.0000, 90.0);
				InsideDoorsStatus[13] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '1'~n~~r~~h~~h~~h~je ztvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[0], 0.000,0.000,0.0);
				InsideDoorsStatus[13] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0,  1848.19641, -1527.13269, 2003.84851)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[14] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '2'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[1], 0.0000, 0.0000, 90.0);
				InsideDoorsStatus[14] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '2'~n~~r~~h~~h~~h~je ztvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[1], 0.000,0.000,0.0);
				InsideDoorsStatus[14] = GATES_CLOSED;
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0,  1848.19641, -1529.46545, 2003.84851)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[15] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '3'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[2], 0.0000, 0.0000, 90.0);
				InsideDoorsStatus[15] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Samnica '3'~n~~r~~h~~h~~h~je ztvorena!", 3000, 3);
				SetDynamicObjectRot(jailcell[2], 0.000,0.000,0.0);
				InsideDoorsStatus[15] = GATES_CLOSED;
			}
		}
//*********************************************************SEKTOR A********************************************************
/*a1*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1861.07056, -1567.25439, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[16] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A1'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[3], 1860.28223, -1566.94165, 2008.56665);
				SetDynamicObjectRot(jailcell[3], 0.00000, 0.00000, 21.72002);
				InsideDoorsStatus[16] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A1'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[3], 1861.07056, -1567.25439, 2008.56665);
				SetDynamicObjectRot(jailcell[3], 0.000,0.000, 90.0);
				InsideDoorsStatus[16] = GATES_CLOSED;
			}
		}
/*a2*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1861.07605, -1569.63647, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[17] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A2'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[4], 1860.26843, -1569.31396, 2008.56665);
				SetDynamicObjectRot(jailcell[4], 0.00000, 0.00000, 21.72000);
				InsideDoorsStatus[17] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A2'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[4], 1861.07605, -1569.63647, 2008.56665);
				SetDynamicObjectRot(jailcell[4], 0.000,0.000, 90.00000);
				InsideDoorsStatus[17] = GATES_CLOSED;
			}
		}
/*a3*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1860.35962, -1571.99841, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[18] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A3'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[5], 1860.03381, -1571.19824, 2008.56665);
				SetDynamicObjectRot(jailcell[5], 0.00000, 0.00000, -23.58000);
				InsideDoorsStatus[18] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A3'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[5], 1860.35962, -1571.99841, 2008.56665);
				SetDynamicObjectRot(jailcell[5], 0.000,0.000, 45.00000);
				InsideDoorsStatus[18] = GATES_CLOSED;
			}
		}
/*a4*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1858.40015, -1573.10999, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[19] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A4'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[6], 1858.62537, -1572.37842, 2008.56665);
				SetDynamicObjectRot(jailcell[6], 0.00000, 0.00000, -61.31999);
				InsideDoorsStatus[19] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A4'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[6], 1858.40015, -1573.10999, 2008.56665);
				SetDynamicObjectRot(jailcell[6], 0.000,0.000, 3.36000);
				InsideDoorsStatus[19] = GATES_CLOSED;
			}
		}
/*a5*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1855.76904, -1573.10315, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[20] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A5'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[7], 1855.90808, -1572.40955, 2008.56665);
				SetDynamicObjectRot(jailcell[7], 0.00000, 0.00000, -57.48000);
				InsideDoorsStatus[20] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A5'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[7], 1855.76904, -1573.10315, 2008.56665);
				SetDynamicObjectRot(jailcell[7], 0.000,0.000, -3.00000);
				InsideDoorsStatus[20] = GATES_CLOSED;
			}
		}
/*a6*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1852.78223, -1572.92102, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[21] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A6'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[8], 1853.14844, -1572.10107, 2008.56665);
				SetDynamicObjectRot(jailcell[8], 0.00000, 0.00000, -71.52001);
				InsideDoorsStatus[21] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A6'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[8], 1852.78223, -1572.92102, 2008.56665);
				SetDynamicObjectRot(jailcell[8], 0.000,0.000, -3.00000);
				InsideDoorsStatus[21] = GATES_CLOSED;
			}
		}
/*a7*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1849.83032, -1571.93115, 2008.56665)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[22] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A7'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[9],  1850.62341, -1571.51770, 2008.56665);
				SetDynamicObjectRot(jailcell[9], 0.00000, 0.00000, -109.98000);
				InsideDoorsStatus[22] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A7'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[9], 1849.83032, -1571.93115, 2008.56665);
				SetDynamicObjectRot(jailcell[9], 0.000,0.000, -35.88000);
				InsideDoorsStatus[22] = GATES_CLOSED;
			}
		}
/*a8*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1849.83032, -1571.93115, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[23] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A8'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[10],  1850.64111, -1571.52234, 2011.96606);
				SetDynamicObjectRot(jailcell[10], 0.00000, 0.00000, -105.24001);
				InsideDoorsStatus[23] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A8'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[10], 1849.83032, -1571.93115, 2011.96606);
				SetDynamicObjectRot(jailcell[10], 0.000,0.000, -35.88000);
				InsideDoorsStatus[23] = GATES_CLOSED;
			}
		}
/*a9*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1847.82666, -1570.39819, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[24] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A9'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[11], 1848.49268, -1569.90149, 2011.96606);
				SetDynamicObjectRot(jailcell[11], 0.00000, 0.00000, -99.83999);
				InsideDoorsStatus[24] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A9'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[11], 1847.82666, -1570.39819, 2011.96606);
				SetDynamicObjectRot(jailcell[11], 0.000,0.000, -37.68000);
				InsideDoorsStatus[24] = GATES_CLOSED;
			}
		}
/*a10*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1852.78223, -1572.92102, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[25] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A10'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[12], 1853.08704, -1572.16418, 2011.96606);
				SetDynamicObjectRot(jailcell[12], 0.00000, 0.00000, -70.31998);
				InsideDoorsStatus[25] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A10'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[12], 1852.78223, -1572.92102, 2011.96606);
				SetDynamicObjectRot(jailcell[12], 0.000,0.000, -3.00000);
				InsideDoorsStatus[25] = GATES_CLOSED;
			}
		}
/*a11*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1855.76904, -1573.10315, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[26] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A11'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[13], 1856.14453, -1572.37866, 2011.96606);
				SetDynamicObjectRot(jailcell[13], 0.00000, 0.00000, -73.56000);
				InsideDoorsStatus[26] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A11'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[13], 1855.76904, -1573.10315, 2011.96606);
				SetDynamicObjectRot(jailcell[13], 0.000,0.000, -3.00000);
				InsideDoorsStatus[26] = GATES_CLOSED;
			}
		}
/*a12*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1858.40015, -1573.10999, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[27] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A12'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[14], 1858.47839, -1572.37903, 2011.96606);
				SetDynamicObjectRot(jailcell[14], 0.00000, 0.00000, -53.10000);
				InsideDoorsStatus[27] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A12'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[14], 1858.40015, -1573.10999, 2011.96606);
				SetDynamicObjectRot(jailcell[14], 0.000,0.000, 3.36000);
				InsideDoorsStatus[27] = GATES_CLOSED;
			}
		}
/*a13*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1860.35962, -1571.99841, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[28] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A13'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[15], 1860.07373, -1571.04102, 2011.96606);
				SetDynamicObjectRot(jailcell[15], 0.00000, 0.00000, -34.44000);
				InsideDoorsStatus[28] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A13'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[15], 1860.35962, -1571.99841, 2011.96606);
				SetDynamicObjectRot(jailcell[15], 0.000,0.000, 45.00000);
				InsideDoorsStatus[28] = GATES_CLOSED;
			}
		}
/*a14*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1861.07605, -1569.63647, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[29] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A14'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[16], 1860.19800, -1569.19275, 2011.96606);
				SetDynamicObjectRot(jailcell[16], 0.00000, 0.00000, 11.40000);
				InsideDoorsStatus[29] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A14'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[16], 1861.07605, -1569.63647, 2011.96606);
				SetDynamicObjectRot(jailcell[16], 0.000,0.000, 90.00000);
				InsideDoorsStatus[29] = GATES_CLOSED;
			}
		}
/*a15*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1861.07056, -1567.25439, 2011.96606)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[30] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A15'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[17], 1860.25977, -1566.76331, 2011.96606);
				SetDynamicObjectRot(jailcell[17], 0.00000, 0.00000, 11.39999);
				InsideDoorsStatus[30] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'A15'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[17], 1861.07056, -1567.25439, 2011.96606);
				SetDynamicObjectRot(jailcell[17], 0.000,0.000, 90.00000);
				InsideDoorsStatus[30] = GATES_CLOSED;
			}
		}
//*********************************************************SEKTOR B********************************************************
/*b1*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1863.32019, -1546.21948, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[31] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B1'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[18], 1862.48022, -1545.79626, 2008.60535);
				SetDynamicObjectRot(jailcell[18], 0.00000, 0.00000, 12.66000);
				InsideDoorsStatus[31] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B1'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[18],  1863.32019, -1546.21948, 2008.60535);
				SetDynamicObjectRot(jailcell[18], 0.000,0.000, 90.00000);
				InsideDoorsStatus[31] = GATES_CLOSED;
			}
		}
/*b2*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1863.32275, -1543.87195, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[32] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B2'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[19], 1862.48535, -1543.34558, 2008.60535);
				SetDynamicObjectRot(jailcell[19], 0.00000, 0.00000, 6.30001);
				InsideDoorsStatus[32] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B2'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[19], 1863.32275, -1543.87195, 2008.60535);
				SetDynamicObjectRot(jailcell[19], 0.000,0.000, 90.00000);
				InsideDoorsStatus[32] = GATES_CLOSED;
			}
		}
/*b3*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1863.31946, -1541.17932, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[33] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B3'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[20], 1862.49622, -1540.66858, 2008.60535);
				SetDynamicObjectRot(jailcell[20], 0.00000, 0.00000, 5.52001);
				InsideDoorsStatus[33] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B3'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[20], 1863.31946, -1541.17932, 2008.60535);
				SetDynamicObjectRot(jailcell[20], 0.000,0.000, 90.00000);
				InsideDoorsStatus[33] = GATES_CLOSED;
			}
		}
/*b4*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1862.11096, -1538.47986, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[34] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B4'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[21], 1861.13696, -1538.78931, 2008.60535);
				SetDynamicObjectRot(jailcell[21], 0.00000, 0.00000, 53.99998);
				InsideDoorsStatus[34] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B4'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[21], 1862.11096, -1538.47986, 2008.60535);
				SetDynamicObjectRot(jailcell[21], 0.000,0.000, 135.00000);
				InsideDoorsStatus[34] = GATES_CLOSED;
			}
		}
/*b5*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1860.32349, -1536.67725, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[35] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B5'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[22], 1859.29492, -1536.87939, 2008.60535);
				SetDynamicObjectRot(jailcell[22], 0.00000, 0.00000, 48.72000);
				InsideDoorsStatus[35] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B5'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[22], 1860.32349, -1536.67725, 2008.60535);
				SetDynamicObjectRot(jailcell[22], 0.000,0.000, 135.00000);
				InsideDoorsStatus[35] = GATES_CLOSED;
			}
		}
/*b6*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1857.58215, -1535.63196, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[36] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B6'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[23], 1857.14795, -1536.47644, 2008.60535);
				SetDynamicObjectRot(jailcell[23], 0.00000, 0.00000, 100.37999);
				InsideDoorsStatus[36] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B6'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[23], 1857.58215, -1535.63196, 2008.60535);
				SetDynamicObjectRot(jailcell[23], 0.000,0.000, 180.00000);
				InsideDoorsStatus[36] = GATES_CLOSED;
			}
		}
/*b7*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1855.22095, -1535.63306, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[37] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B7'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[24], 1854.81714, -1536.42896, 2008.60535);
				SetDynamicObjectRot(jailcell[24], 0.00000, 0.00000, 104.63998);
				InsideDoorsStatus[37] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B7'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[24], 1855.22095, -1535.63306, 2008.60535);
				SetDynamicObjectRot(jailcell[24], 0.000,0.000, 180.00000);
				InsideDoorsStatus[37] = GATES_CLOSED;
			}
		}
/*b8*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1852.84521, -1535.62866, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[38] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B8'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[25], 1852.23560, -1536.48535, 2008.60535);
				SetDynamicObjectRot(jailcell[25], 0.00000, 0.00000, 91.68004);
				InsideDoorsStatus[38] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B8'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[25], 1852.84521, -1535.62866, 2008.60535);
				SetDynamicObjectRot(jailcell[25], 0.000,0.000, 180.00000);
				InsideDoorsStatus[38] = GATES_CLOSED;
			}
		}
/*b9*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1850.20081, -1536.87744, 2008.60535)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[39] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B9'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[26], 1850.43762, -1537.88391, 2008.60535);
				SetDynamicObjectRot(jailcell[26], 0.00000, 0.00000, 139.14003);
				InsideDoorsStatus[39] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B9'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[26], 1850.20081, -1536.87744, 2008.60535);
				SetDynamicObjectRot(jailcell[26], 0.000,0.000, 227.03998);
				InsideDoorsStatus[39] = GATES_CLOSED;
			}
		}
/*b10*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1852.48181, -1535.07117, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[40] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B10'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[27], 1852.73926, -1535.68994, 2012.06494);
				SetDynamicObjectRot(jailcell[27], 0.00000, 0.00000, 227.82002);
				InsideDoorsStatus[40] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B10'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[27], 1852.48181, -1535.07117, 2012.06494);
				SetDynamicObjectRot(jailcell[27], 0.000,0.000, 180.00000);
				InsideDoorsStatus[40] = GATES_CLOSED;
			}
		}
/*b11*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1854.87280, -1535.07190, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[41] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B11'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[28], 1855.11304, -1535.64954, 2012.06494);
				SetDynamicObjectRot(jailcell[28], 0.00000, 0.00000, 224.45999);
				InsideDoorsStatus[41] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B11'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[28], 1854.87280, -1535.07190, 2012.06494);
				SetDynamicObjectRot(jailcell[28], 0.000,0.000, 180.00000);
				InsideDoorsStatus[41] = GATES_CLOSED;
			}
		}
/*b12*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1857.23193, -1535.07471, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[42] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B12'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[29], 1857.40222, -1535.50720, 2012.06494);
				SetDynamicObjectRot(jailcell[29], 0.00000, 0.00000, 215.33994);
				InsideDoorsStatus[42] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B12'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[29], 1857.23193, -1535.07471, 2012.06494);
				SetDynamicObjectRot(jailcell[29], 0.000,0.000, 180.0000);
				InsideDoorsStatus[42] = GATES_CLOSED;
			}
		}
/*b13*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0,  1859.91443, -1536.04895, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[43] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B13'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[30], 1859.68909, -1536.60413, 2012.06494);
				SetDynamicObjectRot(jailcell[30], 0.00000, 0.00000, 174.89999);
				InsideDoorsStatus[43] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B13'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[30], 1859.91443, -1536.04895, 2012.06494);
				SetDynamicObjectRot(jailcell[30], 0.000,0.000, 135.12000);
				InsideDoorsStatus[43] = GATES_CLOSED;
			}
		}
/*b14*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1861.60742, -1537.74780, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[44] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B14'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[31], 1861.38086, -1538.32117, 2012.06494);
				SetDynamicObjectRot(jailcell[31], 0.00000, 0.00000, 178.73997);
				InsideDoorsStatus[44] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B14'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[31], 1861.60742, -1537.74780, 2012.06494);
				SetDynamicObjectRot(jailcell[31], 0.000,0.000, 135.12000);
				InsideDoorsStatus[44] = GATES_CLOSED;
			}
		}
/*b15*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1862.84314, -1540.43115, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[45] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B15'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[32],  1862.13904, -1540.71729, 2012.06494);
				SetDynamicObjectRot(jailcell[32], 0.00000, 0.00000, 139.24089);
				InsideDoorsStatus[45] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B15'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[32], 1862.84314, -1540.43115, 2012.06494);
				SetDynamicObjectRot(jailcell[32], 0.000,0.000, 90.00000);
				InsideDoorsStatus[45] = GATES_CLOSED;
			}
		}
/*b16*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1862.80994, -1542.88232, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[46] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B16'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[33], 1862.08203, -1543.29932, 2012.06494);
				SetDynamicObjectRot(jailcell[33], 0.00000, 0.00000, 148.23781);
				InsideDoorsStatus[46] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B16'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[33], 1862.80994, -1542.88232, 2012.06494);
				SetDynamicObjectRot(jailcell[33], 0.000,0.000, 90.00000);
				InsideDoorsStatus[46] = GATES_CLOSED;
			}
		}
/*b17*/	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1862.23364, -1545.22729, 2012.06494)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
			if(InsideDoorsStatus[47] == GATES_CLOSED) {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B17'~n~~r~~h~~h~~h~ je otvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[34], 1862.38721, -1546.12195, 2012.06494);
				SetDynamicObjectRot(jailcell[34], 0.00000, 0.00000, 337.45609);
				InsideDoorsStatus[47] = GATES_OPEN;
			} else {
				GameTextForPlayer(playerid, "~r~~h~~h~~h~Celija  'B17'~n~~r~~h~~h~~h~ je ztvorena!", 3000, 3);
				SetDynamicObjectPos(jailcell[34], 1862.23364, -1545.22729, 2012.06494);
				SetDynamicObjectRot(jailcell[34], 0.000,0.000, 45.00000);
				InsideDoorsStatus[47] = GATES_CLOSED;
			}
		}
	}

	if(PRESSED(KEY_SECONDARY_ATTACK)) {
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 1780.8057, -1535.7936, 21.0193)) { // ULAZ SA OGRADE
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1804.9254, -1549.9565,2011.8240, 0, 7, true);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1804.9254,-1549.9565,2011.8240)) { // IZLAZ NA OGRADU
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1780.8057, -1535.7936, 21.0193, 0, 0, true);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1774.6196,-1551.1420,23.0249)) { // ULAZ U POLJSKI CONTORLL ROOM
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1845.2667,-1566.9664,2011.8219, 0, 7, true);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1845.2667,-1566.9664,2011.8219)) { // ULAZ U INSIDE CONTROLL ROOM
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1774.6196,-1551.1420,23.0249, 0, 0, true);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1842.8771, -1531.7197, 2008.3539)) { // Ulaz u bolnicu
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1592.4298,-1972.1902,2132.6599, 0, 7, true);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1592.4298,-1972.1902,2132.6599)) { // Izlaz iz bolnicu
	        TogglePlayerControllable(playerid, 0);
	        SetPlayerPosEx(playerid, 1842.8771, -1531.7197, 2008.3539, 0, 7, true);
		}
		return 1;
	}
	return 1;
}

public OnDynamicObjectMoved(objectid)
{
	if(objectid == LSPrisonGatesObject[0])
		EasternGatesStatus = ( EasternGatesStatus == GATES_CLOSING) ? GATES_CLOSED : GATES_OPEN;
	else if(objectid == LSPrisonGatesObject[2])
		SouthernGatesStatus = ( SouthernGatesStatus == GATES_CLOSING) ? GATES_CLOSED : GATES_OPEN;
	else if(objectid == biggates)
		BigGatesStatus = ( BigGatesStatus == GATES_CLOSING) ? GATES_CLOSED : GATES_OPEN;
	return 1;
}
stock SendMessageToPrisoners(option[], message[])
{
	new jInt;
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pJailed] == 1 || PlayerInfo[i][pJailed] == 4)
		{
			jInt = GetPlayerInterior(i);
			if(!strcmp(option, "out", true))
			{
				if(jInt == 0)
					SendClientMessage(i, COLOR_JAIL, message);
			}
			else if(!strcmp(option, "in", true))
			{
				if(jInt == 7)
					SendClientMessage(i, COLOR_JAIL, message);
			}
			else if(!strcmp(option, "all", true))
			{
				SendClientMessage(i, COLOR_JAIL, message);
			}
			else break;
		}
	}
	return 1;
}
hook OnPlayerDeath(playerid, killerid, reason)
{
	JailJobProgress[playerid] = 0;
	JailJ[playerid] = 0;
	JailSmece[playerid] = 0;

    return 1;
}
CMD:jail_alert(playerid, params[])
{
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste autorizovani!");
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1849.7317,-1554.1625,2011.8259) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1772.4279,-1543.7100,23.0249)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu kontrolne sobe.");
	new
		string[156], result[86];
	if(sscanf(params, "s[86]", result)) return SendClientMessage(playerid, COLOR_RED, "[?]: /jail_alert [text]");
	format(string, sizeof(string), "[Jail Alert] %s %s: %s", ReturnPlayerRankName(playerid), GetName(playerid, false), result);
	SendRadioMessage(PlayerFaction[playerid][pMember], COLOR_COP, string);
	return 1;
}
/*
CMD:cells(playerid, params[])
{
	if(IsASD(playerid) || IsACop(playerid))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1847.7703, -1543.2189, 2011.8159) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1852.0300,-1554.4509,2011.8259) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1847.7236,-1565.3138,2011.8219)) return SendClientMessage(playerid,COLOR_RED, "Niste u kontrolnoj sobi.");

	}
	else	SendClientMessage(playerid,COLOR_RED, "Niste LSPD/LSSD.");
	return 1;
}
*/

CMD:grabtrash(playerid,params[])
{
 	if(PlayerJail[playerid][pJailed] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste u zatvoru!");
	if(PlayerJail[playerid][pJailJob] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemas zatvorski posao smecara.");
	if(JailJ[playerid] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemas pokrenut zatvorski posao!");
	if(JailSmece[playerid] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Vec si pokupio smece!");
	if(!IsPlayerInRangeOfPoint(playerid, 2, SmeceX[playerid], SmeceY[playerid], SmeceZ[playerid])) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi kod crne kese!");
	DestroyPlayerObject(playerid, smecence[playerid]);
	SetPlayerAttachedObject( playerid, 9, 1265, 6, 0.281522, -0.151917, -0.094952, 213.986679, 255.047500, 265.017791, 1.000000, 1.000000, 1.000000);
	JailSmece[playerid] = 1;
	ApplyAnimation(playerid,"CAMERA","camcrch_idleloop",4.1,1,1,1,1,1,1);
	return true;
}

CMD:droptrash(playerid,params[])
{
	if(PlayerJail[playerid][pJailed] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste u zatvoru!");
	if(PlayerJail[playerid][pJailJob] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemas zatvorski posao smecara.");
	if(JailJ[playerid] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemas pokrenut zatvorski posao!");
	if(JailSmece[playerid] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nisi pokupio smece!");
	if(!IsPlayerInRangeOfPoint(playerid, 2.5, 113.226722, -248.827789, 1.390041)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi kod kontejnera!");
	if(JailJ[playerid] > 13)
	{
	    JailJobProgress[playerid] += 20;
	    JailJ[playerid] = 0;
	    JailSmece[playerid] = 0;
    	RemovePlayerAttachedObject(playerid, 9);
    	SmeceX[playerid] = 0.0;
    	SmeceY[playerid] = 0.0;
    	SmeceZ[playerid] = 0.0;
    	new kolicina = JailJobProgress[playerid] * 55;
		BudgetToPlayerMoney(playerid, kolicina);
		new string[34];
		format(string, sizeof(string), "Dobili ste %d$ za obavljeni posao.",  kolicina);
		SendMessage(playerid, COLOR_RED, string);
	    return true;
	}
	ApplyAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
	SendClientMessage(playerid, COLOR_RED, "Ubacili ste kesu u kontejner, nastavite skupljati dalje!");
	JailJ[playerid]++;
	JailSmece[playerid] = 0;
    RemovePlayerAttachedObject(playerid, 9);
    new srand = random(7)+1;
	if(srand == 1)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 115.1711, -246.9955, 0.922910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 115.1711;
		SmeceY[playerid] = -246.9955;
		SmeceZ[playerid] = 0.922910;
	}
	else if(srand == 2)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 125.8775, -238.6588, 0.722910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 125.8775;
		SmeceY[playerid] = -238.6588;
		SmeceZ[playerid] = 0.722910;
	}
	else if(srand == 3)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 138.9342, -230.1289, 0.622910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 138.9342;
		SmeceY[playerid] = -230.1289;
		SmeceZ[playerid] = 0.6229101;
	}
	else if(srand == 4)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 147.0394, -229.2490, 1.000910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 147.0394;
		SmeceY[playerid] = -229.2490;
		SmeceZ[playerid] = 1.000910;
	}
	else if(srand == 5)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 155.7619, -248.4534, 0.722910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 155.7619;
		SmeceY[playerid] = -248.4534;
		SmeceZ[playerid] = 0.722910;
	}
	else if(srand == 6)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 152.9234, -266.5890, 0.822910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 152.9234;
		SmeceY[playerid] = -266.5890;
		SmeceZ[playerid] = 0.822910;
	}
	else if(srand == 7)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 143.1682, -276.9901, 0.922910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 143.1682;
		SmeceY[playerid] = -276.9901;
		SmeceZ[playerid] = 0.922910;
	}
	return true;
}
CMD:jailjob(playerid,params[])
{
    if(PlayerJail[playerid][pJailed] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Niste u zatvoru!");
	if(PlayerJail[playerid][pJailed] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Ne mozes raditi ovaj posao, jer te nije PD uhapsio!");
	if(PlayerJail[playerid][pJailJob] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Nemas zatvorski posao smecara.");
	if(!IsPlayerInRangeOfPoint(playerid, 2, 108.0369, -256.7454, 1.57817)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti kod pickup-a posla!");
	if(JailJ[playerid] > 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Vec radite u zatvoru.");
	if(JailJobProgress[playerid] > 0)
	{
	    new dada[128];
	    format(dada, 128, "Ovaj posao mozes pokrenuti tek za %d minuta", JailJobProgress[playerid]);
		SendClientMessage(playerid, COLOR_RED, dada);
	    return true;
	}
	JailJ[playerid] = 1;
	SendClientMessage(playerid, COLOR_RED, "Zapoceli ste sa zatvorskim poslom.");
	SendClientMessage(playerid, COLOR_RED, "Sada nadjite crnu kesu u dvoristu zatvora, zatim je pokupite - /grabtrash i odnesite do kontejnera - /droptrash.");
	new srand = random(7)+1;
	if(srand == 1)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 115.1711, -246.9955, 0.922910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 115.1711;
		SmeceY[playerid] = -246.9955;
		SmeceZ[playerid] = 0.922910;
	}
	else if(srand == 2)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 125.8775, -238.6588, 0.722910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 125.8775;
		SmeceY[playerid] = -238.6588;
		SmeceZ[playerid] = 0.722910;
	}
	else if(srand == 3)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 138.9342, -230.1289, 0.622910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 138.9342;
		SmeceY[playerid] = -230.1289;
		SmeceZ[playerid] = 0.6229101;
	}
	else if(srand == 4)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 147.0394, -229.2490, 1.000910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 147.0394;
		SmeceY[playerid] = -229.2490;
		SmeceZ[playerid] = 1.000910;
	}
	else if(srand == 5)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 155.7619, -248.4534, 0.722910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 155.7619;
		SmeceY[playerid] = -248.4534;
		SmeceZ[playerid] = 0.722910;
	}
	else if(srand == 6)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 152.9234, -266.5890, 0.822910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 152.9234;
		SmeceY[playerid] = -266.5890;
		SmeceZ[playerid] = 0.822910;
	}
	else if(srand == 7)
	{
		smecence[playerid] = CreatePlayerObject(playerid, 1265, 143.1682, -276.9901, 0.922910,   0.00, 0.00, 0.00, 300.0);
		SmeceX[playerid] = 143.1682;
		SmeceY[playerid] = -276.9901;
		SmeceZ[playerid] = 0.922910;
	}
	return true;
}

CMD:runaway(playerid, params[]){

    if(!IsPlayerInRangeOfPoint(playerid, 1.5, 1179.6763,1562.2493,2093.5093)) return false;
	SetPlayerPos(playerid, 218.0549, -400.3850, 1.2720);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
 	SendMessage(playerid, COLOR_RED,"Uspjesno ste pobjegli iz zatvora!");
 	
 	if(PlayerJail[playerid][pJailed] == 1)
		defer RunAwayTimer();

	return 1;
}

timer RunAwayTimer[120000]()
{
	foreach(new playerid : Player)
	{
		if(IsACop(playerid) || IsASD(playerid))
		{
			new prisonbreak[256];
			SendRadioMessage( 1, COLOR_LIGHTBLUE, "*________________________ [PRISON BREAK IN PROGRESS] ________________________*");
			format(prisonbreak, sizeof(prisonbreak), "Last seen: %s", GetPlayerStreet(playerid));
			SendRadioMessage(1, COLOR_WHITE, prisonbreak);
			format(prisonbreak,sizeof(prisonbreak),"Description: ** Full description of %s ** ((SID: %d))", GetName(playerid, false), GetPlayerSkin(playerid));
			SendRadioMessage(1, COLOR_WHITE, prisonbreak);
			SendRadioMessage(1, COLOR_LIGHTBLUE, "*_______________________________________________________________________________*");
		}
	}
	return 1;
}
