//Mapu je dobrovoljno radio Carlos.
//Gay Pride Event 23.3.2020.

#include <a_samp>
//#include <zcmd>
#include <streamer>
#include <sscanf2>
#include <YSI\y_timers>
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

public OnFilterScriptInit()
{
	//////lobby
	//Hotel
	new stenah1 = CreateObject(8419,1489.5380859,-1575.0000000,3400.0000000,270.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenah1, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenah2 = CreateObject(8419,1489.5380859,-1505.0000000,3400.0000000,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenah2, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenah3 = CreateObject(5882,1461.4990234,-1540.1992188,3400.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenah3, 5, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenah3, 1, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenah4 = CreateObject(5882,1517.3291016,-1540.1992188,3400.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenah4, 5, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenah4, 1, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ???????
	new potolokh = CreateObject(8421,1489.5380859,-1541.7666016,3420.7939453,0.0000000,90.0000000,270.0000000);
    SetObjectMaterial(potolokh, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0xFFC0C0C0);
    SetObjectMaterial(potolokh, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0xFFC0C0C0);
    SetObjectMaterial(potolokh, 2, 2439, "cj_ff_counters", "CJ_WOOD6", 0xFFC0C0C0);
    SetObjectMaterial(potolokh, 3, 2439, "cj_ff_counters", "CJ_WOOD6", 0xFFC0C0C0);

	//---- ???
	new polh = CreateObject(8555,1489.5380859,-1541.7666015,3374.3950195,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(polh, 7, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	//---- ???????
	new reception1 = CreateObject(2439,1497.0909424,-1540.1992188,3397.7351074,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(reception1, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception1, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception2 = CreateObject(2439,1499.0999756,-1544.2259521,3397.7351074,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(reception2, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception2, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception3 = CreateObject(2439,1497.0909424,-1541.1999512,3397.7351074,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(reception3, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception3, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception4 = CreateObject(2439,1497.0908203,-1542.1992188,3397.7351074,0.0000000,0.0000000,269.9890137);
	SetObjectMaterial(reception4, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception4, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception5 = CreateObject(2439,1497.0908203,-1543.1992188,3397.7351074,0.0000000,0.0000000,269.9890137);
	SetObjectMaterial(reception5, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception5, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception6 = CreateObject(2439,1497.0908203,-1539.1992188,3397.7351074,0.0000000,0.0000000,269.9890137);
	SetObjectMaterial(reception6, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception6, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception7 = CreateObject(2439,1497.0908203,-1538.1992188,3397.7351074,0.0000000,0.0000000,269.9890137);
	SetObjectMaterial(reception7, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception7, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception8 = CreateObject(2439,1497.0909424,-1537.1999512,3397.7351074,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(reception8, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception8, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception9 = CreateObject(2439,1498.0989990,-1544.2259521,3397.7351074,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(reception9, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception9, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception10 = CreateObject(2439,1498.1180420,-1536.1920166,3397.7351074,0.0000000,0.0000000,180.0000000);
	SetObjectMaterial(reception10, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception10, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

    new reception11 = CreateObject(2440,1497.0920410,-1544.1949463,3397.7351074,0.0000000,0.0000000,270.0000000);
    SetObjectMaterial(reception11, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception11, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new reception12 = CreateObject(2440,1497.1230469,-1536.1929932,3397.7351074,0.0000000,0.0000000,180.0000000);
	SetObjectMaterial(reception12, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);
	SetObjectMaterial(reception12, 1, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	//---- ??
	new tvh1 = CreateObject(2267,1497.6650390,-1530.3449707,3399.5,0.0000000,0.0000000,270.0000000);
    SetObjectMaterial(tvh1, 0, 16000, "con_drivein", "drvin_screen", 0xFF000000);
    SetObjectMaterial(tvh1, 1, 9362, "sfn_byofficeint", "CJ_TV_SCREEN", 0);

    new tvh2 = CreateObject(2267,1481.1699218,-1530.3449707,3399.5,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(tvh2, 0, 16000, "con_drivein", "drvin_screen", 0xFF000000);
    SetObjectMaterial(tvh2, 1, 9362, "sfn_byofficeint", "CJ_TV_SCREEN", 0);

	//---- ????? ? ????????
	new doorrec = CreateObject(1569,1499.6298828,-1533.1992188,3397.7199707,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(doorrec, 0, 16150, "ufo_bar", "des_backdoor1", 0);

	//---- ???????
	new kar = CreateObject(2790, 1489.5380859, -1516.6999511, 3403.5, 0.00000, 0.00000, 0.00000);
    SetObjectMaterial(kar, 1, 2267, "picture_frame", "CJ_PAINTING30", 0);

	//---- ????
	new oknoh1 = CreateObject(1569,1495.1992188,-1563.1494141,3400.5000000,90.0000000,0.0000000,270.0000000);
	SetObjectMaterial(oknoh1, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh2 = CreateObject(1569,1495.1992188,-1563.1494141,3398.1157227,90.0000000,0.0000000,269.9890137);
	SetObjectMaterial(oknoh2, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh3 = CreateObject(1569,1492.6337891,-1563.1484375,3398.0551758,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(oknoh3, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh4 = CreateObject(1569,1495.2529297,-1563.1484375,3398.0551758,0.0000000,0.0000000,269.9890137);
	SetObjectMaterial(oknoh4, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh5 = CreateObject(1569,1486.3800049,-1563.1494141,3398.1157227,90.0000000,0.0000000,269.9890137);
	SetObjectMaterial(oknoh5, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh6 = CreateObject(1569,1486.3800049,-1563.1494141,3400.5000000,90.0000000,0.0000000,269.9890137);
	SetObjectMaterial(oknoh6, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh7 = CreateObject(1569,1486.4344482,-1563.1484375,3398.0551758,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(oknoh7, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	new oknoh8 = CreateObject(1569,1483.8149414,-1563.1484375,3398.0551758,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(oknoh8, 0, 2439, "cj_ff_counters", "CJ_WOOD6", 0);

	//---- ???????? ?????
	new nazvanie = CreateObject(19175,1499.5996093,-1540.1992187,3400.5,0.0000000,0.0000000,270.0000000);
	SetObjectMaterialText(nazvanie, "????? ??????", 0, OBJECT_MATERIAL_SIZE_512x512,\
    "Verdana", 80, 0, 0xFFFFFFFF, 0xFF000000, 1);


	//-- ??????? ????? --
	//---- ?????
	new stenak1 = CreateObject(8419,1489.5380859,-1504.9880371,3285.0000000,0.0000000,90.0000000,270.0000000);
	SetObjectMaterial(stenak1, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenak2 = CreateObject(8419,1538.4699707,-1532.8000488,3300.0000000,0.0000000,90.0000000,90.0000000);
	SetObjectMaterial(stenak2, 1, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak2, 2, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak2, 3, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak2, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenak3 = CreateObject(8419,1440.6298828,-1532.7998047,3300.0000000,0.0000000,90.0000000,90.0000000);
	SetObjectMaterial(stenak3, 1, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak3, 2, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak3, 3, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);
	SetObjectMaterial(stenak3, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenak4 = CreateObject(8419,1446.5498047,-1522.0000000,3300.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(stenak4, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenak5 = CreateObject(8419,1532.3291016,-1522.0000000,3300.0000000,0.0000000,90.0000000,180.0000000);
	SetObjectMaterial(stenak5, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	new stenak6 = CreateObject(8419,1489.5380859,-1550.0000000,3285.0000000,0.0000000,90.0000000,90.0000000);
    SetObjectMaterial(stenak6, 4, 4002, "cityhall_lan", "LAcityhwal1", 0xFFC0C0C0);

	//---- ???????
	new potoloko = CreateObject(8555,1489.5380859,-1535.0000000,3332.5000000,0.0000000,179.9945068,0.0000000);
    SetObjectMaterial(potoloko, 7, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF363636);

	//---- ???
	new polo = CreateObject(8555,1489.5380859,-1535.0000000,3281.6589355,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(polo, 7, 14858, "gen_pol_vegas", "grey_carpet_256", 0);

	//---- ?????? ??????
	new kosykk1 = CreateObject(1507,1481.4200439,-1520.9399414,3305.0000000,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(kosykk1, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk2 = CreateObject(1507,1480.0000000,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk2, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk3 = CreateObject(1507,1479.9667969,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk3, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk4 = CreateObject(1507,1481.4200439,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk4, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk5 = CreateObject(1507,1480.0000000,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk5, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk6 = CreateObject(1507,1479.9667969,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk6, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk7 = CreateObject(1507,1472.5999756,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk7, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk8 = CreateObject(1507,1474.0250244,-1515.3299561,3305.0000000,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(kosykk8, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk9 = CreateObject(1507,1472.5693359,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk9, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk10 = CreateObject(1507,1474.0250244,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk10, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk11 = CreateObject(1507,1472.5999756,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk12 = CreateObject(1507,1472.5693359,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk13 = CreateObject(1507,1466.6250000,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk13, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk14 = CreateObject(1507,1465.1999512,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk14, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk15 = CreateObject(1507,1465.1660156,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk15, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk16 = CreateObject(1507,1465.1999512,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk16, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk17 = CreateObject(1507,1466.6250000,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk17, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk18 = CreateObject(1507,1465.1660156,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk18, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk19 = CreateObject(1507,1499.0699463,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk19, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk20 = CreateObject(1507,1497.6569824,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk20, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk21 = CreateObject(1507,1497.6191406,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk21, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk22 = CreateObject(1507,1497.6569824,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk22, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk23 = CreateObject(1507,1499.0699463,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk23, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk24 = CreateObject(1507,1497.6191406,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk24, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk25 = CreateObject(1507,1506.4429932,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk25, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk26 = CreateObject(1507,1505.0100098,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk26, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk27 = CreateObject(1507,1513.8299561,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk27, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk28 = CreateObject(1507,1512.4000244,-1520.9399414,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk28, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk29 = CreateObject(1507,1504.9794922,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk29, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk30 = CreateObject(1507,1512.3691406,-1520.9560547,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk30, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk31 = CreateObject(1507,1512.4000244,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk31, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk32 = CreateObject(1507,1513.8299561,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk32, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk33 = CreateObject(1507,1512.3691406,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk33, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk34 = CreateObject(1507,1506.4429932,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk34, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk35 = CreateObject(1507,1505.0100098,-1515.3299561,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk35, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk36 = CreateObject(1507,1504.9794922,-1514.3222656,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk36, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk37 = CreateObject(1507,1488.0810547,-1538.0999756,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk37, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk38 = CreateObject(1507,1491.0129395,-1538.0999756,3305.0000000,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(kosykk38, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk39 = CreateObject(1507,1489.5498047,-1538.1169434,3307.4050293,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykk39, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykk40 = CreateObject(1507,1489.5710449,-1538.1169434,3307.4328613,270.0000000,0.0000000,180.0000000);
	SetObjectMaterial(kosykk40, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);


    //??????? ???????
    CreateObject(19172,1481.1359863,-1550.270019,3400,0.0000000,0.0000000,90.0000000);
    CreateObject(19174,1497.6970214,-1550.270019,3400,0.0000000,0.0000000,270.0000000);
	CreateObject(18755,1489.5380859,-1514.6894531,3399.6599121,0.0000000,0.0000000,90.0000000);
	CreateObject(18756,1487.5292969,-1514.7099609,3399.6499023,0.0000000,0.0000000,90.0000000);
	CreateObject(18757,1491.5322266,-1514.7099609,3399.6499023,0.0000000,0.0000000,90.0000000);
	CreateObject(14629,1489.5380859,-1532.5500488,3406.5500488,0.0000000,0.0000000,0.0000000);
	CreateObject(1569,1488.0400391,-1563.2900391,3397.7199707,0.0000000,0.0000000,0.0000000);
	CreateObject(1569,1491.0400391,-1563.2841797,3397.7199707,0.0000000,0.0000000,179.9945068);
	CreateObject(1726,1480.3499756,-1541.3496094,3397.7351074,0.0000000,0.0000000,90.0000000);
	CreateObject(1726,1480.3496094,-1545.1396484,3397.7351074,0.0000000,0.0000000,90.0000000);
	CreateObject(1726,1480.3499756,-1537.5439453,3397.7351074,0.0000000,0.0000000,90.0000000);
	CreateObject(1569,1479.1800537,-1521.1999512,3397.7199707,0.0000000,0.0000000,270.0000000);
	CreateObject(1569,1479.1800537,-1524.1999512,3397.7199707,0.0000000,0.0000000,90.0000000);
	CreateObject(1726,1480.4000244,-1519.3399658,3397.7351074,0.0000000,0.0000000,44.9945068);
	CreateObject(1726,1497.0000000,-1517.8994141,3397.7351074,0.0000000,0.0000000,314.9945068);
	CreateObject(630,1480.3499756,-1538.4492188,3398.7600098,0.0000000,0.0000000,0.0000000);
	CreateObject(630,1480.3499756,-1542.2500000,3398.7600098,0.0000000,0.0000000,0.0000000);
	CreateObject(632,1480.9794922,-1546.7998047,3398.1000977,0.0000000,0.0000000,0.0000000);
	CreateObject(632,1480.9794922,-1533.8496094,3398.1000977,0.0000000,0.0000000,0.0000000);
	CreateObject(1726,1498.4794922,-1521.5585938,3397.7351074,0.0000000,0.0000000,270.0000000);
	CreateObject(1726,1498.4179688,-1525.7656250,3397.7351074,0.0000000,0.0000000,225.0000000);
	CreateObject(948,1498.4794922,-1520.5673828,3397.6999512,0.0000000,0.0000000,0.0000000);
	CreateObject(948,1498.4794922,-1524.5478516,3397.6999512,0.0000000,0.0000000,0.0000000);
	CreateObject(1827,1482.5999756,-1540.3499756,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(1827,1496.1999512,-1522.5870361,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(2852,1496.1999512,-1522.5999756,3398.1599121,0.0000000,0.0000000,0.0000000);
	CreateObject(2852,1482.5600586,-1540.3499756,3398.1599121,0.0000000,0.0000000,0.0000000);
	CreateObject(2894,1497.0468750,-1540.1999512,3398.7800293,0.0000000,0.0000000,90.0000000);
	CreateObject(2753,1497.0908203,-1542.1992188,3398.9299316,0.0000000,0.0000000,270.0000000);
	CreateObject(2753,1497.0908203,-1538.1992188,3398.9299316,0.0000000,0.0000000,269.9945068);
	CreateObject(1726,1498.4794922,-1555.0000000,3397.7351074,0.0000000,0.0000000,270.0000000);
	CreateObject(948,1498.4794922,-1554.1699219,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(18084,1493.9492188,-1562.3330078,3399.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(18084,1485.1199951,-1562.3330078,3399.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(948,1498.4794922,-1557.8994141,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(3935,1497.8000488,-1561.5500488,3399.0000000,0.0000000,0.0000000,45.0000000);
	CreateObject(3935,1480.8499756,-1561.5500488,3399.0000000,0.0000000,0.0000000,315.0000000);
	CreateObject(948,1480.3496094,-1554.1699219,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(948,1480.3496094,-1557.8994141,3397.7351074,0.0000000,0.0000000,0.0000000);
	CreateObject(1726,1480.3496094,-1557.0050049,3397.7351074,0.0000000,0.0000000,90.0000000);
	CreateObject(1363,1478.9499512,-1526.9554443,3398.5720215,0.0000000,0.0000000,0.0000000);
	CreateObject(1363,1478.9499512,-1526.2590332,3398.5720215,0.0000000,0.0000000,0.0000000);
	CreateObject(1363,1478.9499512,-1525.5620117,3398.5720215,0.0000000,0.0000000,0.0000000);
	CreateObject(2773,1487.7900391,-1561.5999756,3398.2529297,0.0000000,0.0000000,0.0000000);
	CreateObject(2773,1491.1989746,-1561.5999756,3398.2529297,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1499.4746094,-1524.5478516,3399.6499023,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1499.4749756,-1520.5673828,3399.6499023,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1499.4749756,-1554.1699219,3399.6499023,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1499.4749756,-1557.8994141,3399.6499023,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1479.3549805,-1557.8994141,3399.6499023,0.0000000,0.0000000,180.0000000);
	CreateObject(1731,1479.3549805,-1554.1699219,3399.6499023,0.0000000,0.0000000,179.9945068);
	CreateObject(18755,1489.5380859,-1514.6894531,3306.9350586,0.0000000,0.0000000,90.0000000);
	CreateObject(18756,1487.5292969,-1514.7099609,3306.8999023,0.0000000,0.0000000,90.0000000);
	CreateObject(18757,1491.5322266,-1514.7099609,3306.8999023,0.0000000,0.0000000,90.0000000);
	CreateObject(1504,1489.5500488,-1538.2900391,3304.9299316,0.0000000,0.0000000,0.0000000);
	CreateObject(1504,1489.5830078,-1538.2619629,3304.9299316,0.0000000,0.0000000,180.0000000);
	CreateObject(1506,1479.9670410,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1472.5699463,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1465.1660156,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1497.6199951,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1504.9799805,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1512.3699951,-1521.1099854,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1465.1660156,-1516.6989746,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1472.5693359,-1516.6982422,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1479.9670410,-1516.6989746,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1497.6199951,-1516.6989746,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1504.9799805,-1516.6989746,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(1506,1512.3699951,-1516.6989746,3304.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(18084,1521.4599609,-1518.8800049,3306.6999512,0.0000000,0.0000000,270.0000000);
	CreateObject(1569,1458.2399902,-1520.4100342,3305.0048828,0.0000000,0.0000000,90.0000000);
	CreateObject(1569,1458.2343750,-1517.4090576,3305.0048828,0.0000000,0.0000000,270.0000000);
	CreateObject(1731,1509.4365234,-1516.8593750,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1502.0292969,-1516.8593750,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1516.8193359,-1516.8593750,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1494.6748047,-1516.8593750,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1484.4200439,-1516.8599854,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1477.0300293,-1516.8599854,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1469.6199951,-1516.8599854,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1462.2199707,-1516.8599854,3307.0000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1731,1462.2199707,-1520.9250488,3307.0000000,0.0000000,0.0000000,270.0000000);
	CreateObject(1731,1469.6199951,-1520.9250488,3307.0000000,0.0000000,0.0000000,269.9945068);
	CreateObject(1731,1477.0300293,-1520.9250488,3307.0000000,0.0000000,0.0000000,269.9945068);
	CreateObject(1731,1484.4199219,-1520.9248047,3307.0000000,0.0000000,0.0000000,269.9890137);
	CreateObject(948,1520.0000000,-1517.3599854,3305.0048828,0.0000000,0.0000000,0.0000000);
	CreateObject(948,1520.0000000,-1520.4699707,3305.0048828,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1494.6748047,-1520.9248047,3307.0000000,0.0000000,0.0000000,269.9890137);
	CreateObject(1731,1502.0292969,-1520.9248047,3307.0000000,0.0000000,0.0000000,269.9890137);
	CreateObject(1731,1509.4365234,-1520.9248047,3307.0000000,0.0000000,0.0000000,269.9890137);
	CreateObject(1731,1516.8193359,-1520.9248047,3307.0000000,0.0000000,0.0000000,269.9890137);
	CreateObject(1731,1491.5699463,-1524.0200195,3307.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1491.5699463,-1529.9219971,3307.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1491.5699463,-1535.8199463,3307.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1731,1487.5250244,-1524.0200195,3307.0000000,0.0000000,0.0000000,180.0000000);
	CreateObject(1731,1487.5250244,-1529.9219971,3307.0000000,0.0000000,0.0000000,179.9945068);
	CreateObject(1731,1487.5250244,-1535.8199463,3307.0000000,0.0000000,0.0000000,179.9945068);
	CreateObject(18075,1489.5380859,-1521.6300049,3309.1799316,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1502.3000488,-1521.6300049,3309.1799316,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1514.9000244,-1521.6300049,3309.1799316,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1476.5999756,-1521.6300049,3309.1799316,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1464.0000000,-1521.6300049,3309.1799316,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1489.5380859,-1532.5000000,3309.1799316,0.0000000,0.0000000,90.0000000);


    //---- ??????? ?????? 1 ? 2 ----//
    //??????? ? ??????????? ??????????
    //---- ??? (????? 1)
	new polnom11 = CreateObject(19380,1511.2998047,-1530.3652344,3480.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(polnom11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFFFFFFFF);

	new polnom12 = CreateObject(19380,1511.2998047,-1540.0000000,3480.0000000,0.0000000,90.0000000,0.0000000);
    SetObjectMaterial(polnom12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFFFFFFFF);

	//---- ????? (????? 1)
	new stenan11 = CreateObject(19377,1507.0000000,-1530.3652344,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan11, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

    new stenan12 = CreateObject(19377,1507.0000000,-1540.0000000,3483.0000000,0.0000000,0.0000000,0.0000000);
    SetObjectMaterial(stenan12, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan13 = CreateObject(19377,1515.5898438,-1540.0000000,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan13, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan14 = CreateObject(19377,1515.5898438,-1530.3652344,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan14, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan15 = CreateObject(19377,1511.2998047,-1527.5000000,3483.4333496,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan15, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan16 = CreateObject(19377,1511.2998047,-1544.8496094,3483.4333496,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan16, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan17 = CreateObject(19377,1507.3281250,-1539.9443359,3483.4333496,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan17, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan18 = CreateObject(19362,1512.5000000,-1544.6806641,3481.8359375,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan18, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan19 = CreateObject(19362,1512.5000000,-1544.6806641,3485.3359375,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan19, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan110 = CreateObject(19362,1512.5000000,-1541.4697266,3485.3359375,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan110, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new stenan111 = CreateObject(19391,1512.5000000,-1541.4697266,3481.8359375,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan111, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ???????? (????? 1)
	new plintus11 = CreateObject(19375,1507.0292969,-1530.3652344,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus12 = CreateObject(19375,1507.0292969,-1540.0000000,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus13 = CreateObject(19375,1507.3769531,-1539.9150391,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus13, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus14 = CreateObject(19375,1511.2998047,-1527.5263672,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus14, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus15 = CreateObject(19375,1515.5546875,-1530.3652344,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus15, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus16 = CreateObject(19375,1515.5546875,-1540.0000000,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus16, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus17 = CreateObject(19375,1511.2998047,-1544.8125000,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus17, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus18 = CreateObject(19375,1507.3281250,-1539.9799805,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus18, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus19 = CreateObject(19386,1512.5400391,-1541.4794922,3478.5000000,0.0000000,179.9945068,0.0000000);
	SetObjectMaterial(plintus19, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus110 = CreateObject(19386,1512.4599609,-1541.4814453,3478.4980469,0.0000000,179.9945068,0.0000000);
	SetObjectMaterial(plintus110, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus111 = CreateObject(19356,1512.5400391,-1544.6923828,3478.5000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus111, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new plintus112 = CreateObject(19356,1512.4599609,-1544.6923828,3478.5000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus112, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	//---- ??????? (????? 1)
	new potolokn11 = CreateObject(19381,1511.2998047,-1530.3652344,3484.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(potolokn11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF363636);

	new potolokn12 = CreateObject(19381,1511.2998047,-1540.0000000,3484.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(potolokn12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF363636);

	//---- ???? ???? (????? 1)
	new raman11 = CreateObject(1569,1510.0400391,-1527.6992188,3480.8144531,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(raman11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF000000);

	new raman12 = CreateObject(1569,1510.0400391,-1527.6992188,3483.1989746,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(raman12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF000000);

	new raman13 = CreateObject(1569,1509.9863281,-1527.6992188,3480.7548828,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(raman13, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF000000);

	new raman14 = CreateObject(1569,1512.6054688,-1527.6992188,3480.7548828,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(raman14, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF000000);

	//---- ?? (????? 1)
	new tvn1 = CreateObject(2267,1515.4794922,-1533.8007812,3482.1000977,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(tvn1, 0, 16000, "con_drivein", "drvin_screen", 0xFF000000);
    SetObjectMaterial(tvn1, 1, 9362, "sfn_byofficeint", "CJ_TV_SCREEN", 0);

	//---- ?????? (????? 1)
	new komodn1 = CreateObject(1743,1514.0292969,-1533.2988281,3480.0859375,0.0000000,0.0000000,270.0000000); //????? ??? ??
	SetObjectMaterial(komodn1, 0, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);
	SetObjectMaterial(komodn1, 1, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);
	SetObjectMaterial(komodn1, 2, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);

	new schkafn1 = CreateObject(2576,1513.9228516,-1528.0996094,3480.0859375,0.0000000,0.0000000,0.0000000); //????
	SetObjectMaterial(schkafn1, 0, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);

	new kreslon11 = CreateObject(1724,1507.5100098,-1528.7299805,3480.0859375,0.0000000,0.0000000,45.0000000); //?????? 1
	SetObjectMaterial(kreslon11, 1, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);

	new kreslon12 = CreateObject(1724,1512.0996094,-1539.2753906,3480.0859375,0.0000000,0.0000000,179.9945068); //?????? 2
	SetObjectMaterial(kreslon12, 1, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);

	new divann1 = CreateObject(1723,1511.5000000,-1534.8291016,3480.0859375,0.0000000,0.0000000,90.0000000); //?????
	SetObjectMaterial(divann1, 1, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);

	new schkafvn1 = CreateObject(2145,1510.3291016,-1540.2500000,3480.0000000,0.0000000,0.0000000,0.0000000); //???? ? ??????
    SetObjectMaterial(schkafvn1, 1, 2566, "cj_hotel_sw", "CJ_WOOD_DARK", 0);
    SetObjectMaterial(schkafvn1, 2, 2566, "cj_hotel_sw", "CJ_WOOD1", 0);

	//---- ????? ? ?????? (????? 1)
	new doorvn1 = CreateObject(1491,1512.5000000,-1542.2197266,3480.0791016,0.0000000,0.0000000,90.0000000);
    SetObjectMaterial(doorvn1, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	//---- ????? ????? (????? 1)
	new kosykn11 = CreateObject(1505,1513.3496094,-1546.1800537,3480.0859375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(kosykn11, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykn12 = CreateObject(1505,1514.7998047,-1546.1800537,3480.0859375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(kosykn12, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);

	new kosykn13 = CreateObject(1505,1513.2998047,-1544.6650391,3482.5000000,90.0000000,0.0000000,0.0000000);
	SetObjectMaterial(kosykn13, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF2F2D2D);



	//---- ??? (?????? 2)
	new polnom21 = CreateObject(19380,1511.2998047,-1560.0000000,3480.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(polnom21, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF0482FF);

	new polnom22 = CreateObject(19380,1511.2998047,-1569.6328125,3480.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(polnom22, 0, 14858, "gen_pol_vegas", "grey_carpet_256", 0xFF0482FF);

	//---- ????? (????? 2)
	new stenan21 = CreateObject(19377,1511.2998047,-1555.1999512,3483.4333496,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan21, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan22 = CreateObject(19377,1515.5898438,-1560.0000000,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan22, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan23 = CreateObject(19377,1515.5898438,-1569.6328125,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan23, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan24 = CreateObject(19377,1507.0000000,-1560.0000000,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan24, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan25 = CreateObject(19377,1507.0000000,-1569.6328125,3483.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan25, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan26 = CreateObject(19377,1511.4414062,-1572.0000000,3483.4333496,90.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan26, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan27 = CreateObject(19377,1512.3652344,-1571.9492188,3485.3369141,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(stenan27, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan28 = CreateObject(19362,1513.9000244,-1567.1999512,3485.3359375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan28, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	new stenan29 = CreateObject(19391,1513.8994141,-1567.1992188,3481.8359375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(stenan29, 0, 4002, "cityhall_lan", "LAcityhwal1", 0xFF0482FF);

	//---- ???????? (????? 2)
	new plintus21 = CreateObject(19375,1515.5546875,-1560.0000000,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus21, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus22 = CreateObject(19375,1515.5546875,-1569.6328125,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus22, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus23 = CreateObject(19375,1507.0292969,-1560.0000000,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus23, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus24 = CreateObject(19375,1507.0292969,-1569.6328125,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus24, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus25 = CreateObject(19375,1511.4414062,-1555.2230225,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus25, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus26 = CreateObject(19375,1511.4414062,-1571.9599609,3475.4331055,90.0000000,90.0000000,0.0000000);
	SetObjectMaterial(plintus26, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus27 = CreateObject(19375,1512.3242188,-1571.9000244,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus27, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus28 = CreateObject(19375,1512.4000244,-1572.0000000,3475.0000000,0.0000000,0.0000000,0.0000000);
	SetObjectMaterial(plintus28, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus29 = CreateObject(19386,1513.9100342,-1567.1700439,3478.5000000,0.0000000,180.0000000,90.0000000);
	SetObjectMaterial(plintus29, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new plintus210 = CreateObject(19386,1513.9079590,-1567.2290039,3478.5000000,0.0000000,179.9945068,90.0000000);
	SetObjectMaterial(plintus210, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ??????? (????? 2)
    new potolokn21 = CreateObject(19381,1511.2998047,-1560.0000000,3484.0000000,0.0000000,90.0000000,0.0000000);
    SetObjectMaterial(potolokn21, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new potolokn22 = CreateObject(19381,1511.2998047,-1569.6328125,3484.0000000,0.0000000,90.0000000,0.0000000);
	SetObjectMaterial(potolokn22, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ???? ???? (????? 2)
	new raman21 = CreateObject(1569,1510.9300537,-1571.8000488,3480.8144531,90.0000000,0.0000000,270.0000000);
	SetObjectMaterial(raman21, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new raman22 = CreateObject(1569,1510.9300537,-1571.8000488,3483.1989746,90.0000000,0.0000000,270.0000000);
	SetObjectMaterial(raman22, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new raman23 = CreateObject(1569,1508.3649902,-1571.8000488,3480.7546387,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(raman23, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new raman24 = CreateObject(1569,1510.9843750,-1571.8000488,3480.7546387,0.0000000,0.0000000,269.9945068);
	SetObjectMaterial(raman24, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ?? (????? 2)
	new tvn21 = CreateObject(2267,1515.4794922,-1561.4799805,3482.1000977,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(tvn21, 0, 16000, "con_drivein", "drvin_screen", 0xFFFFFFFF);
    SetObjectMaterial(tvn21, 1, 9362, "sfn_byofficeint", "CJ_TV_SCREEN", 0);

	new tvn22 = CreateObject(2267,1512.2500000,-1569.5000000,3482.0000000,0.0000000,0.0000000,270.0000000);
	SetObjectMaterial(tvn22, 0, 16000, "con_drivein", "drvin_screen", 0xFFFFFFFF);
    SetObjectMaterial(tvn22, 1, 9362, "sfn_byofficeint", "CJ_TV_SCREEN", 0);

	//---- ?????? (????? 2)
	new schkafn2 = CreateObject(2576,1507.5999756,-1567.3010254,3480.0000000,0.0000000,0.0000000,90.0000000); //????
	SetObjectMaterial(schkafn2, 0, 2563, "cj_hotel_sw", "CJ_WOOD1", 0);

	new schkafvn2 = CreateObject(2145,1515.2500000,-1567.5600586,3480.0859375,0.0000000,0.0000000,0.0000000); //???? ? ??????
	SetObjectMaterial(schkafvn2, 1, 2563, "cj_hotel_sw", "CJ_WOOD1", 0xFF0482FF);
	SetObjectMaterial(schkafvn2, 2, 2563, "cj_hotel_sw", "CJ_WOOD1", 0);

	//---- ????? ? ?????? (????? 1)
	new doorvn2 = CreateObject(1491,1514.6440430,-1567.1992188,3480.0791016,0.0000000,0.0000000,180.0000000);
	SetObjectMaterial(doorvn2, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	//---- ????? ????? (????? 2)
	new kosykn21 = CreateObject(1505,1513.3496094,-1555.3994141,3480.0859375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(kosykn21, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new kosykn22 = CreateObject(1505,1514.7998047,-1555.3994141,3480.0859375,0.0000000,0.0000000,90.0000000);
	SetObjectMaterial(kosykn22, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);

	new kosykn23 = CreateObject(1505,1513.2998047,-1552.8691406,3482.5000000,90.0000000,0.0000000,0.0000000);
    SetObjectMaterial(kosykn23, 0, 4002, "cityhall_lan", "LAcityhwal1", 0);


    //??????? ???????
    CreateObject(1738,1511.6992188,-1571.8193359,3480.5600586,0.0000000,0.0000000,179.9945068);
	CreateObject(1738,1512.6999512,-1568.0000000,3480.5600586,0.0000000,0.0000000,90.0000000);
    CreateObject(2262,1508.8399658,-1539.359985,3481.5,0.0000000,0.0000000,180.0000000);
    CreateObject(1738,1509.1992188,-1527.6992188,3480.5600586,0.0000000,0.0000000,0.0000000);
	CreateObject(1738,1511.5498047,-1540.4023438,3480.5600586,0.0000000,0.0000000,0.0000000);
    CreateObject(1506,1513.2998047,-1544.7998047,3480.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1702,1507.6350098,-1570.4000244,3480.0783691,0.0000000,0.0000000,90.0000000);
	CreateObject(18084,1511.2998047,-1528.4873047,3481.6999512,0.0000000,0.0000000,179.9945068);
	CreateObject(2566,1509.5898438,-1535.3496094,3480.6660156,0.0000000,0.0000000,90.0000000);
	CreateObject(2568,1510.3994141,-1539.3496094,3480.0859375,0.0000000,0.0000000,179.9945068);
	CreateObject(2517,1508.5693359,-1544.2998047,3480.0859375,0.0000000,0.0000000,90.0000000);
	CreateObject(2526,1508.8193359,-1540.5292969,3480.0859375,0.0000000,0.0000000,179.9945068);
	CreateObject(2528,1510.0234375,-1544.2998047,3480.0859375,0.0000000,0.0000000,179.9945068);
	CreateObject(2523,1511.9238281,-1543.0156250,3480.0849609,0.0000000,0.0000000,270.0000000);
	CreateObject(14677,1510.6494141,-1545.2148438,3482.0600586,0.0000000,0.0000000,90.0000000);
	CreateObject(2836,1507.6796875,-1542.2988281,3480.0859375,0.0000000,0.0000000,0.0000000);
	CreateObject(2836,1507.6800537,-1543.4000244,3480.0859375,0.0000000,0.0000000,0.0000000);
	CreateObject(630,1513.3994141,-1528.0996094,3481.1110840,0.0000000,0.0000000,271.9995117);
	CreateObject(18075,1511.2998047,-1533.7998047,3483.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(18075,1507.0999756,-1546.5600586,3483.9499512,0.0000000,0.0000000,0.0000000);
	CreateObject(18084,1509.6700439,-1571.0000000,3481.6999512,0.0000000,0.0000000,0.0000000);
	CreateObject(2563,1509.5517578,-1562.9799805,3480.0859375,0.0000000,0.0000000,90.0000000);
	CreateObject(1506,1513.2998047,-1555.2792969,3480.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2562,1507.1999512,-1555.7979736,3480.0859375,0.0000000,0.0000000,0.0000000);
	CreateObject(1705,1511.3000488,-1555.8199463,3480.0859375,0.0000000,0.0000000,0.0000000);
	CreateObject(1743,1514.0292969,-1560.9499512,3480.0859375,0.0000000,0.0000000,270.0000000);
	CreateObject(948,1507.6500244,-1567.7580566,3480.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(948,1507.6500244,-1571.1500244,3480.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2517,1513.0780029,-1570.4129639,3480.0859375,0.0000000,0.0000000,180.0000000);
	CreateObject(2528,1515.0400391,-1569.5500488,3480.0859375,0.0000000,0.0000000,270.0000000);
	CreateObject(2523,1514.9899902,-1570.8000488,3480.0859375,0.0000000,0.0000000,270.0000000);
	CreateObject(2836,1514.3599854,-1570.0000000,3480.0859375,0.0000000,0.0000000,90.0000000);
	CreateObject(14677,1513.7399902,-1573.0100098,3482.0600586,0.0000000,0.0000000,90.0000000);
	CreateObject(1720,1508.1519775,-1556.4720459,3480.0859375,0.0000000,0.0000000,180.0000000);
	CreateObject(2120,1508.8170166,-1538.5000000,3480.7241211,0.0000000,0.0000000,90.0000000);
	CreateObject(18075,1511.2998047,-1561.2080078,3483.9399414,0.0000000,0.0000000,0.0000000);
	CreateObject(18075,1516.6700439,-1573.8000488,3483.9399414,0.0000000,0.0000000,0.0000000);

	//Rooms
	new tmpobjid;
	tmpobjid = CreateDynamicObject(19379, -330.349304, 1543.246215, 1906.178588, 0.299999, -0.099999, -46.100006, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19438, -326.720855, 1546.718505, 1909.736328, 0.000000, 0.000000, -46.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(6959, -339.432373, 1570.247558, 1904.598632, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	tmpobjid = CreateDynamicObject(6959, -339.432373, 1549.617553, 1904.621948, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	tmpobjid = CreateDynamicObject(4141, -338.441528, 1555.872802, 1915.383544, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 5766, "capitol_lawn", "capitol3_LAwN", 0xFFB2BB91);
	SetDynamicObjectMaterial(tmpobjid, 1, 5766, "capitol_lawn", "capitol3_LAwN", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 2, 4569, "civic1_lan2", "posh_eagle11_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 3, 14888, "gf6", "mp_vicgrill", 0x00000000);
	tmpobjid = CreateDynamicObject(1533, -333.238616, 1576.125976, 1904.570800, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "barbersmir1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1533, -331.748382, 1576.125976, 1904.570800, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "barbersmir1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1533, -360.048217, 1545.889038, 1904.410644, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "barbersmir1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1533, -360.048217, 1547.369750, 1904.410644, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "barbersmir1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -345.273681, 1576.564208, 1917.683349, -0.500000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -345.246704, 1576.564208, 1914.493530, -0.500000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -345.407226, 1576.554199, 1914.532104, -0.500000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -345.393798, 1576.554199, 1917.732299, -0.500000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(14675, -340.414916, 1557.910888, 1915.578369, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18018, "genintintbarb", "GB_midbar01", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 4, 8394, "ballysign01", "vgnmetaltopwal1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 5, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 7, 14674, "civic02cj", "sl_hotelwallplain1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 8, 14758, "sfmansion1", "AH_flroortile6", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 14847, "mp_policesf", "mp_cop_vinyl", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(14674, -338.535278, 1558.478393, 1909.590576, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 8680, "chnatwnfnce", "ctmallfence", 0xFF000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, -359.984863, 1543.910278, 1905.878540, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0xFFB2BB91);
	tmpobjid = CreateDynamicObject(18762, -359.984863, 1547.750488, 1905.878540, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0xFFB2BB91);
	tmpobjid = CreateDynamicObject(18762, -360.004882, 1545.869018, 1907.378540, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0xFFB2BB91);
	tmpobjid = CreateDynamicObject(18762, -360.004882, 1545.869018, 1907.958496, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0xFFB2BB91);
	tmpobjid = CreateDynamicObject(18762, -333.184326, 1576.569824, 1907.558471, 90.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0xFFB2BB91);
	tmpobjid = CreateDynamicObject(19438, -326.720855, 1546.718505, 1906.235595, 0.000000, 0.000000, -46.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, -330.081207, 1543.675659, 1909.768676, -0.099999, -0.100003, -46.100040, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "SKYLINE", 140, "Ariel", 120, 1, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325, -330.081207, 1543.672607, 1908.968261, -0.099999, -0.100003, -46.100040, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "`FEEL THE CLASS`", 140, "Ariel", 50, 1, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(14599, -323.250488, 1557.844848, 1906.579345, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 5, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 7, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 10, 3902, "libertyhi3", "newall9-1128", 0x00000000);
	tmpobjid = CreateDynamicObject(1256, -338.657348, 1552.964965, 1905.233032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1256, -338.657348, 1563.324951, 1905.233032, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1256, -343.047485, 1557.994506, 1905.233032, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(1256, -333.645751, 1557.994506, 1905.233032, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19329, -354.377441, 1566.210083, 1906.963623, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14816, "whore_furn", "WH_keys", 0x00000000);
	tmpobjid = CreateDynamicObject(19329, -354.377441, 1566.210083, 1906.113525, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14816, "whore_furn", "WH_keys", 0x00000000);
	tmpobjid = CreateDynamicObject(19309, -354.633911, 1563.432250, 1905.493530, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19309, -356.444824, 1563.392211, 1905.493530, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19309, -358.385986, 1563.412231, 1905.493530, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19610, -358.392700, 1563.426391, 1905.592895, 270.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19610, -356.452392, 1563.416381, 1905.592895, 270.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19610, -354.641845, 1563.436401, 1905.582885, 270.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -358.414428, 1562.918457, 1905.683227, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -356.474731, 1562.918457, 1905.683227, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -354.656616, 1562.918457, 1905.683227, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -354.623657, 1563.909423, 1905.683227, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -356.435058, 1563.909423, 1905.683227, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, -358.376464, 1563.909423, 1905.683227, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19940, -355.163330, 1563.916992, 1905.449707, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19940, -357.144409, 1563.916992, 1905.449707, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19940, -357.995239, 1563.916992, 1905.450805, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	tmpobjid = CreateDynamicObject(1713, -359.240844, 1557.381591, 1904.604003, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
	tmpobjid = CreateDynamicObject(1713, -359.240844, 1553.320556, 1904.604003, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
	tmpobjid = CreateDynamicObject(1713, -359.240844, 1549.349487, 1904.604003, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
	tmpobjid = CreateDynamicObject(19997, -359.255249, 1552.121948, 1904.294189, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19997, -359.255249, 1556.182739, 1904.294189, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	tmpobjid = CreateDynamicObject(2414, -349.708618, 1542.546997, 1904.548828, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	SetDynamicObjectMaterial(tmpobjid, 2, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFF453F39);
	SetDynamicObjectMaterial(tmpobjid, 3, 3980, "cityhall_lan", "LAcityhwal1", 0xFFC67151);
	tmpobjid = CreateDynamicObject(2414, -351.708618, 1542.546997, 1904.548828, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	SetDynamicObjectMaterial(tmpobjid, 2, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFF453F39);
	SetDynamicObjectMaterial(tmpobjid, 3, 3980, "cityhall_lan", "LAcityhwal1", 0xFFC67151);
	tmpobjid = CreateDynamicObject(2414, -353.678833, 1542.546997, 1904.548828, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	SetDynamicObjectMaterial(tmpobjid, 2, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFF453F39);
	SetDynamicObjectMaterial(tmpobjid, 3, 3980, "cityhall_lan", "LAcityhwal1", 0xFFC67151);
	tmpobjid = CreateDynamicObject(2414, -355.679443, 1542.546997, 1904.548828, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	SetDynamicObjectMaterial(tmpobjid, 1, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	SetDynamicObjectMaterial(tmpobjid, 2, 14415, "carter_block_2", "mp_gs_woodpanel", 0xFF453F39);
	SetDynamicObjectMaterial(tmpobjid, 3, 3980, "cityhall_lan", "LAcityhwal1", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 4, 10101, "2notherbuildsfe", "gz_vicdoor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, -355.582275, 1542.228515, 1903.845092, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	tmpobjid = CreateDynamicObject(19357, -352.421386, 1542.228515, 1903.845092, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	tmpobjid = CreateDynamicObject(19357, -349.639404, 1542.228515, 1903.845092, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_gs_woodpanel1", 0xFF57524C);
	tmpobjid = CreateDynamicObject(11687, -356.032592, 1543.720581, 1904.609497, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF808080);
	tmpobjid = CreateDynamicObject(11687, -354.671997, 1543.720581, 1904.609497, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF808080);
	tmpobjid = CreateDynamicObject(11687, -353.411376, 1543.720581, 1904.609497, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF808080);
	tmpobjid = CreateDynamicObject(11687, -352.020874, 1543.720581, 1904.609497, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF808080);
	tmpobjid = CreateDynamicObject(11687, -350.770263, 1543.720581, 1904.609497, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFC67151);
	SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF808080);
	tmpobjid = CreateDynamicObject(14455, -355.503295, 1539.574584, 1906.178588, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14537, "pdomebar", "club_bottles1_SFW", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -345.640136, 1576.561279, 1922.279174, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(19329, -333.185058, 1577.077270, 1907.564453, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -329.604614, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -330.484497, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -331.325317, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -335.475952, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -336.446411, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -337.316650, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -338.966918, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -339.947143, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -340.897216, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2011, -341.887817, 1571.360595, 1905.024658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3802, -329.822753, 1558.129638, 1908.226318, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3802, -329.822753, 1566.100708, 1908.226318, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3810, -347.387329, 1550.290649, 1907.931274, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3810, -347.387329, 1558.281860, 1907.931274, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2442, -353.151733, 1563.439575, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -354.138183, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -355.118774, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -356.098999, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -357.079833, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -358.040405, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -359.040771, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -360.010742, 1563.447265, 1904.553833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2163, -356.749389, 1566.211181, 1904.603149, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2163, -356.749389, 1566.211181, 1905.523071, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2163, -356.749389, 1566.211181, 1906.433105, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2174, -358.785034, 1565.769775, 1904.602661, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19808, -354.602294, 1563.985107, 1905.469482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19808, -356.472900, 1563.985107, 1905.469482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19808, -358.323608, 1563.985107, 1905.469482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2441, -352.678710, 1565.908691, 1904.553833, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2816, -359.191528, 1556.195312, 1905.173583, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2816, -359.191528, 1552.075073, 1905.173583, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	//Nekakav klub
	tmpobjid = CreateDynamicObject(19378, 1086.129272, 1536.609252, 1736.582763, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1086.412719, 1548.945800, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1096.909057, 1548.947509, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1075.917602, 1548.945190, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.181396, 1531.736206, 1738.395874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1081.439453, 1536.354858, 1738.395874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1090.844970, 1536.354858, 1738.395874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, 1086.863403, 1566.947143, 1730.101806, 89.799995, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{E53838} _ _ _ _ ", 60, "Ariel", 20, 1, 0x00000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19604, 1086.873779, 1566.963623, 1730.076538, -90.100051, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{E53838} _ _ _ _", 60, "Ariel", 20, 1, 0x00000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19357, 1083.095703, 1540.049560, 1738.395874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.192626, 1540.049560, 1738.395874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.918945, 1538.469360, 1738.395874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1082.326538, 1538.470581, 1738.395874, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1088.311279, 1539.183105, 1738.395874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1083.930541, 1539.183105, 1738.395874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1086.078735, 1543.266601, 1733.478515, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1079.882446, 1544.545898, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1092.404052, 1544.531982, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1084.612060, 1542.906616, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1084.612915, 1540.913330, 1735.991943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1084.612915, 1540.913330, 1739.488525, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1084.612060, 1542.906616, 1739.488525, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1087.675659, 1542.998046, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1087.676757, 1540.926879, 1735.991943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1087.676757, 1540.926879, 1739.488525, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1087.675659, 1542.998046, 1739.488525, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1084.536499, 1555.615966, 1731.056274, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1088.533325, 1555.615966, 1731.056274, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1088.705932, 1555.698974, 1731.050048, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1088.705932, 1559.687255, 1731.050048, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1084.420654, 1555.720458, 1731.050048, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1084.420654, 1559.713989, 1731.050048, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1084.609375, 1559.838623, 1731.056274, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(14416, 1088.602294, 1559.838623, 1731.056274, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1085.897705, 1558.775634, 1733.760986, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1077.314941, 1558.574584, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1087.813842, 1566.504882, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1095.806762, 1558.578491, 1734.197998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1077.319335, 1568.203857, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1098.309692, 1568.190307, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1073.465698, 1544.547119, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.438110, 1558.977661, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.438720, 1568.591308, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1077.237548, 1570.745849, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.856201, 1570.745361, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1096.487915, 1570.745971, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.765625, 1565.907836, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.764770, 1556.276123, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.764648, 1546.650634, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1086.129272, 1536.289306, 1740.225341, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1083.649902, 1550.059448, 1746.193725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1088.790649, 1550.059448, 1746.193725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.030883, 1544.532836, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1083.649902, 1564.558959, 1746.193725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1088.790649, 1564.558959, 1746.193725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1086.412719, 1548.945800, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1075.917602, 1548.945190, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1096.909057, 1548.947509, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.083862, 1540.143310, 1740.422485, -33.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1087.813842, 1566.504882, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1077.314941, 1558.574584, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1077.319335, 1568.203857, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1098.309692, 1568.190307, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1095.806762, 1558.578491, 1737.818359, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1085.897705, 1558.555541, 1737.819335, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.181396, 1531.776245, 1741.834838, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1081.479492, 1536.354858, 1741.834838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1082.326538, 1538.430541, 1741.834838, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1083.970458, 1539.143066, 1741.834838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1090.805053, 1536.354858, 1741.834838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.918945, 1538.429443, 1741.834838, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1088.271240, 1539.143066, 1741.834838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.152587, 1540.009643, 1741.834838, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1083.135742, 1540.009643, 1741.834838, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.181396, 1531.776245, 1734.981323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1081.479492, 1536.354858, 1734.981323, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1082.326538, 1538.430541, 1734.981323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1083.970458, 1539.143066, 1734.981323, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.918945, 1538.429443, 1734.981323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1088.271240, 1539.143066, 1734.981323, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1090.805053, 1536.354858, 1734.981323, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1083.135742, 1540.009643, 1734.981323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1089.152587, 1540.009643, 1734.981323, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338256, 1569.574584, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1100.245483, 1569.285644, 1734.279541, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338256, 1568.836914, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338256, 1568.101562, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338256, 1567.368652, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338256, 1566.633056, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1100.245483, 1566.430419, 1734.279541, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.338134, 1570.311157, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1100.245483, 1566.430419, 1736.944580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1100.245483, 1569.285644, 1736.944580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1099.516235, 1570.317138, 1736.946655, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.724853, 1556.276123, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.724609, 1546.650634, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.030883, 1544.572753, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1092.404052, 1544.572021, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1079.882446, 1544.585937, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1073.465698, 1544.587158, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.478149, 1558.977661, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.478759, 1568.591308, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1077.237548, 1570.705810, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.856201, 1570.705444, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1096.487915, 1570.706054, 1732.591674, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.725585, 1565.907836, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.437500, 1552.585815, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19387, 1072.436889, 1549.384399, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.437500, 1546.194946, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1065.419555, 1548.943725, 1734.193847, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 6064, "law_beach1", "musk1", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1065.797973, 1558.404418, 1734.203857, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1071.584472, 1553.513183, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1067.565551, 1545.713134, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1062.812622, 1548.752563, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19387, 1067.986083, 1547.387817, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1070.789672, 1558.312744, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19387, 1069.241333, 1553.514404, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1062.834106, 1553.514892, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1067.986450, 1551.936767, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1067.986572, 1549.775390, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1066.030639, 1561.094238, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1061.954101, 1558.278076, 1735.992309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.477539, 1552.585815, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.477539, 1546.194946, 1732.591674, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19387, 1072.476928, 1549.384399, 1732.591674, 0.000000, 180.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19387, 1072.476928, 1549.384399, 1739.424804, 0.000000, 180.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.477539, 1552.585815, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.478149, 1558.977661, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1072.478759, 1568.591308, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1077.237548, 1570.705810, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1086.856201, 1570.705444, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1096.487915, 1570.706054, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.725585, 1565.907836, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.724853, 1556.276123, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1100.724609, 1546.650634, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.030883, 1544.572753, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1092.404052, 1544.572021, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1079.882446, 1544.585937, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1073.465698, 1544.587158, 1739.424682, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.477539, 1546.194946, 1739.424682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1072.446044, 1548.649047, 1734.241210, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_table", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1067.995361, 1546.652832, 1734.241210, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_table", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1069.976806, 1553.519409, 1734.241210, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_table", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.403320, 1549.322509, 1734.987548, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.403320, 1558.949096, 1734.987548, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1102.403320, 1568.581054, 1734.987548, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1095.160766, 1572.387207, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1085.531005, 1572.387207, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1075.910400, 1572.387207, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1079.900634, 1542.900878, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1073.506591, 1542.900878, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1092.383911, 1542.900878, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1098.788696, 1542.901000, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1101.955078, 1542.900878, 1734.987548, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1087.210449, 1540.581420, 1736.659179, 0.000000, 0.000000, -33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1085.106201, 1540.581420, 1736.659179, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1086.101806, 1535.529785, 1740.222045, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1093.195312, 1544.872070, 1733.326049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1100.121704, 1545.179931, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1097.003295, 1545.137207, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1093.846923, 1545.177734, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1093.195312, 1553.121093, 1733.326049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1093.192993, 1559.098999, 1733.326049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1093.190307, 1547.576049, 1734.750000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1093.186645, 1543.453613, 1734.750000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1093.182373, 1542.572387, 1734.750000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1093.190307, 1553.635742, 1734.750000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1093.196289, 1554.173706, 1733.326904, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1093.190307, 1559.628662, 1734.750000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1093.193847, 1560.144042, 1733.326904, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1100.111450, 1550.749389, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1100.102294, 1554.035156, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1100.133178, 1557.401123, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1101.182861, 1561.581787, 1733.326049, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1100.167358, 1560.841186, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1096.758789, 1560.971801, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1098.502197, 1561.573608, 1734.750000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19929, 1086.197631, 1567.346557, 1734.267456, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19925, 1084.334838, 1567.349975, 1734.267456, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19925, 1088.058471, 1567.348754, 1734.267456, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19932, 1098.341064, 1565.896362, 1734.155029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1098.359130, 1565.309692, 1735.304565, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.600341, 1543.045043, 1733.324951, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1072.616821, 1572.242431, 1733.324951, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19939, 1083.818115, 1544.819580, 1736.401855, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19939, 1088.498779, 1544.819580, 1736.401855, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1073.009765, 1569.440185, 1734.898925, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2635, 1073.136108, 1567.760253, 1734.620239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(19893, 1084.984130, 1567.465332, 1735.190429, 0.000000, 0.000000, 156.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 19894, "laptopsamp1", "laptopscreen2", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1073.027587, 1566.189941, 1734.898925, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2635, 1073.136230, 1563.378906, 1734.620239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1073.037231, 1565.034423, 1734.898925, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1072.968383, 1561.640991, 1734.898925, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2635, 1073.136108, 1558.935913, 1734.620239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1072.960693, 1560.635742, 1734.898925, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1072.935302, 1557.179199, 1734.898925, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2635, 1073.136108, 1554.473266, 1734.620239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1072.984863, 1556.134155, 1734.898925, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1072.940795, 1552.875244, 1734.898925, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1074.747924, 1554.493652, 1734.898925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1074.747924, 1558.974243, 1734.898925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1074.747924, 1563.475097, 1734.898925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2123, 1074.747924, 1567.749633, 1734.898925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1073.062744, 1570.187744, 1734.270019, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1073.096069, 1565.580932, 1734.270019, 0.000000, 0.000000, -47.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1072.805541, 1561.104980, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1072.885009, 1556.616577, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1072.843017, 1552.169311, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19380, 1062.713989, 1548.667114, 1734.218017, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1063.179199, 1547.207763, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1063.179199, 1548.729248, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1063.179199, 1550.229980, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1063.179199, 1551.730590, 1735.992309, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19940, 1066.282226, 1553.229736, 1735.112426, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19940, 1066.282226, 1553.229736, 1734.301391, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19937, 1066.290527, 1553.261596, 1734.076660, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1071.981689, 1552.943115, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1071.953979, 1546.206542, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1063.597534, 1552.621093, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.495361, 1560.895996, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.932617, 1560.896850, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.494506, 1561.333129, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.928955, 1561.333251, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.481567, 1558.389282, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.917846, 1558.391357, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.916381, 1558.826171, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.480468, 1558.826049, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.928466, 1555.978393, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.491455, 1555.975097, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.926391, 1556.412353, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.489135, 1556.411010, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.462036, 1553.771850, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.897827, 1553.773803, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.897827, 1554.209350, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1080.460693, 1554.207763, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.586059, 1555.357543, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.025146, 1554.922973, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.023559, 1555.359741, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.587524, 1554.920776, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.080200, 1557.677978, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.080078, 1557.239501, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.641845, 1557.677001, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.641479, 1557.239135, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.628662, 1560.445434, 1735.324584, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.065917, 1560.445556, 1735.324584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1077.629638, 1560.008300, 1735.324584, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19938, 1078.067016, 1560.008300, 1735.324584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19449, 1062.229370, 1546.995849, 1734.251831, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1826, 1065.822509, 1558.178833, 1734.268920, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1070.394042, 1553.829345, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1070.302978, 1560.615112, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1062.431152, 1560.525268, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19786, 1066.318725, 1553.590332, 1736.442138, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1065.419555, 1548.943725, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 1065.797973, 1558.574584, 1737.817260, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1070.182861, 1549.744750, 1734.202148, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19430, 1070.182861, 1549.744750, 1737.801513, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1066.103637, 1557.338623, 1734.208862, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1066.103637, 1557.338623, 1737.803955, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1084.201782, 1532.341064, 1736.659179, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1088.023681, 1532.277465, 1736.659179, 0.000000, 0.000000, 33.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18058, "mp_diner2", "mp_diner_slats", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1090.440551, 1540.018188, 1739.493652, 133.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1081.839477, 1540.021606, 1739.564575, -45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1090.440551, 1540.018188, 1738.324462, 133.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1090.440551, 1540.018188, 1737.158569, 133.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1081.839721, 1540.021606, 1738.350341, -45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1081.839477, 1540.021606, 1737.228759, -45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.791870, 1549.625976, 1731.906005, 45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.645751, 1549.625976, 1731.906005, 45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.355102, 1550.038085, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1089.225585, 1550.053222, 1731.906005, 45.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.781738, 1550.494262, 1731.906005, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.634277, 1550.494262, 1731.906005, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.214843, 1550.041870, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.083251, 1550.053833, 1731.906005, 45.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.625732, 1549.622924, 1740.097656, -134.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.681884, 1550.493164, 1740.097656, -134.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.213989, 1550.093872, 1740.097656, -134.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.083862, 1550.033935, 1740.097656, -134.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.764404, 1549.624877, 1740.097656, -134.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1089.225341, 1550.020751, 1740.097656, -134.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.819702, 1550.493774, 1740.097656, -134.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.355224, 1550.091064, 1740.097656, -134.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(1536, 1084.579345, 1531.800415, 1736.651611, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "csheistbox01", 0x00000000);
	tmpobjid = CreateDynamicObject(1536, 1087.590942, 1531.838012, 1736.651611, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 15046, "svcunthoose", "csheistbox01", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.804809, 1564.123901, 1731.906005, 45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.779785, 1564.994384, 1731.906005, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.356567, 1564.553222, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1089.224853, 1564.566528, 1731.906005, 45.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.084716, 1564.561157, 1731.906005, 45.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.214599, 1564.546508, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.648315, 1564.122924, 1731.906005, 45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.642822, 1564.993774, 1731.906005, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.756469, 1564.125610, 1740.097656, -134.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.619262, 1564.125366, 1740.097656, -134.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.682250, 1564.996337, 1740.097656, -134.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.826782, 1564.993896, 1740.097656, -134.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1089.229980, 1564.526733, 1740.097656, -134.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.084838, 1564.527099, 1740.097656, -134.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1083.213623, 1564.587890, 1740.097656, -134.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.354614, 1564.588745, 1740.097656, -134.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1087.489379, 1569.961425, 1738.896484, 0.000000, 0.000000, -89.999977, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 1084.941162, 1569.961669, 1738.895996, 0.000000, 0.000000, 90.100013, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, 1090.722167, 1533.256958, 1737.794433, 0.000000, -90.200042, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{E53838} ||||||", 20, "Ariel", 20, 1, 0x00000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19604, 1081.562866, 1533.583984, 1736.568969, 0.000000, 90.099960, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{E53838} ||||||", 20, "Ariel", 20, 1, 0x00000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19604, 1072.555908, 1561.168579, 1734.174926, 0.000000, 91.199974, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{E53838} ||||||", 20, "Ariel", 20, 1, 0x00000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19939, 1072.413208, 1556.164794, 1736.055786, -89.599983, -90.800025, -87.999961, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19939, 1072.412231, 1566.154663, 1735.999389, 90.200004, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1092.236938, 1563.356933, 1733.963745, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1092.212646, 1552.092163, 1733.963745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1080.898315, 1552.104736, 1733.963745, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1080.901977, 1563.363159, 1733.963745, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1088.168457, 1559.353515, 1733.663208, 2.000000, 2.000000, 88.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.612548, 1556.032348, 1733.663208, 2.000000, 2.000000, 268.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.265747, 1568.291381, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.264404, 1569.010986, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.254150, 1569.693115, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.244506, 1570.436889, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.236083, 1571.179687, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.227416, 1571.899536, 1733.261474, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1102.008056, 1565.066406, 1732.960449, 90.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1089.183227, 1537.277709, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1090.207519, 1537.257812, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1090.141723, 1535.417968, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1089.209472, 1535.417968, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1089.186523, 1532.810913, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1090.112670, 1532.810913, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1083.035034, 1537.150756, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1082.174804, 1537.150756, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1082.968017, 1535.085327, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1082.164550, 1535.085327, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1082.875610, 1532.996948, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(957, 1082.035644, 1532.996948, 1740.116088, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1093.168090, 1559.619628, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1093.168090, 1553.612304, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1093.168090, 1547.058593, 1731.906005, 45.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1098.348632, 1567.540527, 1733.245117, -0.199924, 91.499977, 179.699768, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18008, "intclothesa", "mp_cloth_vicgird", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1098.508422, 1565.281982, 1734.187011, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1100.713378, 1565.488891, 1735.927368, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1098.399291, 1570.779418, 1736.302246, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "mp_cop_panel", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1087.407958, 1567.049072, 1731.993164, 61.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1084.946899, 1567.049072, 1732.014404, 28.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.180786, 1567.049072, 1731.776245, 45.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.399414, 1567.473022, 1733.162475, 0.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.017211, 1567.448974, 1733.162475, -270.000000, 90.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19329, 1066.300659, 1553.430175, 1736.071899, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "barbersmir1", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1544.556030, 1731.661010, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1544.237915, 1731.880371, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1543.917846, 1732.097412, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1543.597778, 1732.315917, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1543.277832, 1732.538818, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1542.959960, 1732.752563, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1542.640014, 1732.970092, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1542.322021, 1733.192382, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1542.002929, 1733.409179, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1541.688964, 1733.608276, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19128, 1086.082885, 1541.366943, 1733.848266, 45.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, 1086.386840, 1570.628173, 1733.920532, 90.699951, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18067, "intclothes_acc", "mp_cloth_vicrug", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1897, 1088.503784, 1531.750854, 1737.699096, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.503784, 1531.750854, 1739.917602, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.504272, 1532.967407, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.504272, 1535.198486, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.504272, 1537.419067, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.527221, 1532.987670, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.527221, 1535.223266, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.527221, 1537.443603, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.527587, 1538.460937, 1737.699096, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1088.527587, 1538.460937, 1739.927001, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.694091, 1531.749389, 1739.932617, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.694091, 1531.749389, 1737.706054, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.717285, 1532.988525, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.717285, 1535.223266, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.717285, 1537.443603, 1736.589843, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.713134, 1538.467651, 1737.699096, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.713134, 1538.467651, 1739.924438, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.688232, 1537.432250, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.688232, 1535.198486, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1897, 1083.688232, 1532.967407, 1740.211914, -90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1099.396850, 1545.267944, 1734.240844, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1727, 1095.103027, 1548.777221, 1734.240844, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1100.063720, 1547.927368, 1734.240844, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1823, 1097.742187, 1546.461181, 1734.257934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1096.533569, 1545.286865, 1734.240844, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1093.868774, 1545.980590, 1734.240844, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1823, 1095.104858, 1546.461059, 1734.257934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1727, 1097.730346, 1548.954711, 1734.240844, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1100.063720, 1553.352783, 1734.240844, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1100.063720, 1556.728393, 1734.240844, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1100.063720, 1560.143554, 1734.240844, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1823, 1097.827148, 1551.794555, 1734.257934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1823, 1097.827148, 1555.168212, 1734.257934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1823, 1097.827148, 1558.576049, 1734.257934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1727, 1096.498046, 1551.848022, 1734.240844, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1727, 1096.498046, 1555.079223, 1734.240844, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1727, 1096.498046, 1558.572753, 1734.240844, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1726, 1097.388671, 1560.798095, 1734.240844, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1088.789916, 1570.225219, 1734.872680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1083.584350, 1570.233398, 1734.872680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1088.789916, 1570.225219, 1736.063110, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1083.584350, 1570.233398, 1736.063110, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1083.814453, 1544.657592, 1737.011596, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1088.474365, 1544.657592, 1737.011596, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1100.213623, 1563.313842, 1734.872680, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1088.068725, 1570.217041, 1734.872680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1084.307250, 1570.233398, 1734.872680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2232, 1086.272094, 1570.211181, 1734.872680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2739, 1066.472045, 1552.932617, 1734.398559, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2739, 1065.784179, 1552.932617, 1734.398559, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2739, 1065.094848, 1552.932617, 1734.398559, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2010, 1067.564331, 1546.155273, 1734.270019, 0.000000, 0.000000, -55.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1080.707763, 1561.116333, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1080.693969, 1558.608520, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1080.716674, 1556.204833, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1080.694091, 1554.000610, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1077.810302, 1555.138793, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1077.859497, 1557.462524, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19871, 1077.842651, 1560.232543, 1734.283935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1721, 1065.738769, 1556.341796, 1734.280761, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1721, 1066.872924, 1556.434448, 1734.280761, 0.000000, 0.000000, 18.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19357, 1088.289306, 1.000000, 1738.395874, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19325, 1088.529907, 1535.072021, 1738.661254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19325, 1083.692382, 1535.072021, 1738.661254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(807, 1082.718139, 1533.530883, 1736.850341, 0.000000, 0.000000, -76.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(816, 1082.551147, 1536.659790, 1736.870727, 0.000000, 0.000000, 69.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(867, 1090.285156, 1535.942993, 1737.097900, 0.000000, 0.000000, 257.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(828, 1082.449462, 1532.588256, 1736.930419, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(816, 1081.586791, 1535.330688, 1736.870727, 0.000000, 0.000000, 32.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(816, 1089.481079, 1533.582885, 1736.870727, 0.000000, 0.000000, 32.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(816, 1089.729370, 1536.941772, 1736.870727, 0.000000, 0.000000, 53.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19380, 1093.739746, 1533.586059, 1736.594360, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19380, 1078.462402, 1533.609252, 1736.594360, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(870, 1082.359863, 1533.591918, 1736.675659, 0.000000, 0.000000, -41.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(870, 1082.303100, 1536.584228, 1736.675659, 0.000000, 0.000000, -41.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(870, 1090.360229, 1535.205322, 1736.675659, 0.000000, 0.000000, -41.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2345, 1090.672119, 1534.930053, 1737.055175, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2345, 1081.658569, 1535.404174, 1737.023681, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(3532, 1089.728027, 1535.566894, 1737.059814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(3532, 1082.416137, 1535.520507, 1736.877685, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(870, 1089.964111, 1533.296630, 1736.675659, 0.000000, 0.000000, -41.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2001, 1082.627197, 1537.425537, 1736.380249, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2001, 1082.915161, 1533.185791, 1736.380249, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2011, 1082.549072, 1535.288574, 1736.354248, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2011, 1089.400634, 1533.174804, 1736.354248, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2010, 1089.428955, 1537.776000, 1736.445678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2010, 1090.245605, 1534.694824, 1736.445678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2125, 1097.255737, 1569.911499, 1734.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2125, 1097.255737, 1568.839843, 1734.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2125, 1097.255737, 1567.778930, 1734.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2125, 1097.235717, 1566.736938, 1734.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2125, 1097.235717, 1565.660522, 1734.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(14820, 1086.222900, 1567.346313, 1735.157714, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19610, 1087.363159, 1567.572265, 1735.210815, 4.000000, -2.000000, -159.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1541, 1100.623046, 1568.404052, 1735.757690, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1545, 1100.601440, 1567.490112, 1735.802612, 0.000000, 0.000000, -90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1486, 1098.261108, 1568.119995, 1735.458740, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1486, 1098.340820, 1568.286743, 1735.458740, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1486, 1098.323486, 1569.998291, 1735.458740, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1486, 1098.355712, 1565.821411, 1735.458740, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1666, 1098.322753, 1570.171386, 1735.400390, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1666, 1098.288330, 1569.078613, 1735.400390, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2738, 1063.353027, 1546.423339, 1734.945556, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2738, 1063.353027, 1547.924438, 1734.945556, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2738, 1063.353027, 1549.444946, 1734.945556, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2738, 1063.353027, 1551.046386, 1734.945556, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1708, 1065.852050, 1559.969848, 1734.200683, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2163, 1068.644653, 1561.059692, 1734.265136, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2163, 1063.348999, 1560.988891, 1734.265136, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19894, 1066.395019, 1558.301025, 1735.090576, 0.000000, 0.000000, -25.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19513, 1066.834106, 1558.318481, 1735.090698, 0.000000, 0.000000, -164.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2164, 1062.039306, 1557.785644, 1734.262207, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(2164, 1062.058105, 1555.475341, 1734.262207, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(1721, 1070.735229, 1553.073730, 1734.280761, 0.000000, 0.000000, 171.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(19810, 1070.295288, 1553.425292, 1735.904052, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(18728, 1085.715087, 1557.186645, 1727.591186, 0.000000, 178.899963, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(18728, 1084.472656, 1570.461059, 1729.046875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	tmpobjid = CreateDynamicObject(18728, 1088.319580, 1570.501464, 1728.760498, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
	return 1;
}

