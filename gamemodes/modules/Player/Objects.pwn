#include <YSI_Coding\y_hooks>

#if defined MODULE_OBJECTS
	#endinput
#endif
#define MODULE_OBJECTS 


/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/

enum {
	MALL_REGULAR_CLOTHING	= 1,
	MALL_TOOLKIT_CLOTHING,
	MALL_SPORTS_CLOTHING,
	MALL_TECHNO_CLOTHING,
	MALL_PD_CLOTHING,
	MALL_FD_CLOTHING,
	MALL_GOV_CLOTHING,
	MALL_PREM_CLOTHING,
	MALL_HALL_CLOTHING
};

enum HALLOWEEN_CLOTHING_ENUM
{
    hlmodel,
    hltype,
    hlprice,
    hlattachname[24]
}

new HLObjects[11][HALLOWEEN_CLOTHING_ENUM] = {
	{19137, 1, 12, "CluckinBellHat1"},
	{19094, 1, 12, "BurgerShotHat1"},
	{19320, 1, 12, "Pumpkin"},
	{19314, 1, 12, "Bullhorn"},
	{19590, 1, 12, "Mac"},
	{19591, 1, 12, "Lepeza"},
	{19812, 1, 12, "Bacva pive"},
	{19527, 1, 12, "Kotao"},
	{19528, 1, 12, "Sesir"},
	{11704, 1, 12, "Witch Hat"},
	{325, 	1, 12, "Cvijece"}
};

enum NORMAL_CLOTHING_ENUM
{
    ncmodel,
    nctype,
    ncprice,
    ncattachname[24]
}

new NCObjects[][NORMAL_CLOTHING_ENUM] = {
	{18638, 1, 40, "HardHat1"},
	{18639, 1, 40, "BlackHat1"},
	{18890, 1, 30, "Rake1"},
	{18891, 1, 30, "Bandana1"},
	{18892, 1, 30, "Bandana2"},
	{18893, 1, 30, "Bandana3"},
	{18894, 1, 30, "Bandana4"},
	{18895, 1, 30, "Bandana5"},
	{18896, 1, 30, "Bandana6"},
	{18897, 1, 30, "Bandana7"},
	{18898, 1, 30, "Bandana8"},
	{18899, 1, 30, "Bandana9"},
	{18900, 1, 30, "Bandana10"},
	{18901, 1, 30, "Bandana11"},
	{18902, 1, 30, "Bandana12"},
	{18903, 1, 30, "Bandana13"},
	{18904, 1, 30, "Bandana14"},
	{18905, 1, 30, "Bandana15"},
	{18906, 1, 30, "Bandana16"},
	{18907, 1, 30, "Bandana17"},
	{18908, 1, 30, "Bandana18"},
	{18909, 1, 30, "Bandana19"},
	{18910, 1, 30, "Bandana20"},
	{18911, 1, 38, "Mask1"},
	{18912, 1, 38, "Mask2"},
	{18913, 1, 38, "Mask3"},
	{18914, 1, 38, "Mask4"},
	{18915, 1, 38, "Mask5"},
	{18916, 1, 38, "Mask6"},
	{18917, 1, 38, "Mask7"},
	{18918, 1, 38, "Mask8"},
	{18919, 1, 38, "Mask9"},
	{18920, 1, 38, "Mask10"},
	{18921, 1, 32, "Beret1"},
	{18922, 1, 32, "Beret2"},
	{18923, 1, 32, "Beret3"},
	{18924, 1, 32, "Beret4"},
	{18925, 1, 32, "Beret5"},
	{18926, 1, 34, "Hat1"},
	{18927, 1, 34, "Hat2"},
	{18928, 1, 34, "Hat3"},
	{18929, 1, 34, "Hat4"},
	{18930, 1, 35, "Hat5"},
	{18931, 1, 35, "Hat6"},
	{18932, 1, 35, "Hat7"},
	{18933, 1, 35, "Hat8"},
	{18934, 1, 35, "Hat9"},
	{18935, 1, 35, "Hat10"},
	{18939, 1, 20, "CapBack1"},
	{18940, 1, 20, "CapBack2"},
	{18941, 1, 20, "CapBack3"},
	{18942, 1, 20, "CapBack4"},
	{18943, 1, 20, "CapBack5"},
	{18944, 1, 20, "HatBoater1"},
	{18945, 1, 20, "HatBoater2"},
	{18946, 1, 20, "HatBoater3"},
	{18947, 1, 20, "HatBowler1"},
	{18948, 1, 20, "HatBowler2"},
	{18949, 1, 20, "HatBowler3"},
	{18950, 1, 20, "HatBowler4"},
	{18951, 1, 20, "HatBowler5"},
	{18953, 1, 25, "CapKnit1"},
	{18954, 1, 25, "CapKnit2"},
	{18955, 1, 15, "CapOverEye1"},
	{18956, 1, 15, "CapOverEye2"},
	{18957, 1, 15, "CapOverEye3"},
	{18958, 1, 15, "CapOverEye4"},
	{18959, 1, 15, "CapOverEye5"},
	{18960, 1, 25, "CapRimUp1"},
	{18961, 1, 35, "CapTrucker1"},
	{18962, 1, 20, "CowboyHat2"},
	{18964, 1, 30, "SkullyCap1"},
	{18965, 1, 30, "SkullyCap2"},
	{18966, 1, 30, "SkullyCap3"},
	{18967, 1, 50, "HatMan1"},
	{18968, 1, 50, "HatMan2"},
	{18969, 1, 50, "HatMan3"},
	{18970, 1, 30, "HatTiger1"},
	{18971, 1, 30, "HatCool1"},
	{18972, 1, 30, "HatCool2"},
	{18973, 1, 30, "HatCool3"},
	{18974, 1, 40, "MaskZorro1"},
	{19006, 1, 25, "GlassesType1"},
	{19007, 1, 25, "GlassesType2"},
	{19008, 1, 25, "GlassesType3"},
	{19009, 1, 25, "GlassesType4"},
	{19010, 1, 25, "GlassesType5"},
	{19011, 1, 25, "GlassesType6"},
	{19012, 1, 25, "GlassesType7"},
	{19013, 1, 25, "GlassesType8"},
	{19014, 1, 25, "GlassesType9"},
	{19015, 1, 25, "GlassesType10"},
	{19016, 1, 25, "GlassesType11"},
	{19017, 1, 25, "GlassesType12"},
	{19018, 1, 25, "GlassesType13"},
	{19019, 1, 25, "GlassesType14"},
	{19020, 1, 25, "GlassesType15"},
	{19021, 1, 25, "GlassesType16"},
	{19022, 1, 25, "GlassesType17"},
	{19023, 1, 25, "GlassesType18"},
	{19024, 1, 25, "GlassesType19"},
	{19025, 1, 25, "GlassesType20"},
	{19026, 1, 25, "GlassesType21"},
	{19027, 1, 25, "GlassesType22"},
	{19028, 1, 25, "GlassesType23"},
	{19029, 1, 25, "GlassesType24"},
	{19030, 1, 25, "GlassesType25"},
	{19031, 1, 25, "GlassesType26"},
	{19032, 1, 25, "GlassesType27"},
	{19033, 1, 25, "GlassesType28"},
	{19034, 1, 25, "GlassesType29"},
	{19035, 1, 25, "GlassesType30"},
	{19039, 1, 250, "WatchType1"},
	{19040, 1, 240, "WatchType2"},
	{19041, 1, 250, "WatchType3"},
	{19042, 1, 240, "WatchType4"},
	{19043, 1, 200, "WatchType5"},
	{19044, 1, 50, "WatchType6"},
	{19045, 1, 52, "WatchType7"},
	{19046, 1, 50, "WatchType8"},
	{19047, 1, 51, "WatchType9"},
	{19048, 1, 52, "WatchType10"},
	{19049, 1, 53, "WatchType11"},
	{19050, 1, 54, "WatchType12"},
	{19051, 1, 55, "WatchType13"},
	{19052, 1, 55, "WatchType14"},
	{19053, 1, 55, "WatchType15"},
	{19067, 1, 40, "HoodyHat1"},
	{19068, 1, 40, "HoodyHat2"},
	{19069, 1, 40, "HoodyHat3"},
	{19085, 1, 20, "EyePatch1"},
	{19086, 1, 50, "ChainsawDildo1"},
	{19090, 1, 10, "PomPomBlue"},
	{19091, 1, 10, "PomPomRed"},
	{19092, 1, 10, "PomPomGreen"},
	{19093, 1, 20, "HardHat2"},
	{19095, 1, 25, "CowboyHat1"},
	{19096, 1, 25, "CowboyHat3"},
	{19097, 1, 25, "CowboyHat4"},
	{19098, 1, 25, "CowboyHat5"},
	{19101, 1, 36, "ArmyHelmet1"},
	{19102, 1, 36, "ArmyHelmet2"},
	{19103, 1, 36, "ArmyHelmet3"},
	{19104, 1, 36, "ArmyHelmet4"},
	{19105, 1, 36, "ArmyHelmet5"},
	{19106, 1, 36, "ArmyHelmet6"},
	{19107, 1, 36, "ArmyHelmet7"},
	{19108, 1, 36, "ArmyHelmet8"},
	{19109, 1, 36, "ArmyHelmet9"},
	{19110, 1, 36, "ArmyHelmet10"},
	{19111, 1, 36, "ArmyHelmet11"},
	{19112, 1, 36, "ArmyHelmet12"},
	{19113, 1, 32, "SillyHelmet1"},
	{19114, 1, 32, "SillyHelmet2"},
	{19115, 1, 32, "SillyHelmet3"},
	{19160, 1, 35, "HardHat3"},
	{19330, 1, 50, "fire_hat01"},
	{19331, 1, 50, "fire_hat02"},
	{19348, 1, 50, "cane01"},
	{19349, 1, 40, "monocle01"},
	{19350, 1, 40, "moustache01"},
	{19351, 1, 40, "moustache02"},
	{19487, 1, 30, "tophat02"},
	{19488, 1, 25, "HatBowler6"},
	{322, 	1, 15, "Dildo"},
	{19516, 1, 20, "HairCut1"},	
	{19517, 1, 20, "HairCut2"},
	{19518, 1, 20, "HairCut3"},
	{19519, 1, 20, "HairCut4"},
	{19528, 1, 20, "Witch Hat"},
	{19553, 1, 10, "Straw Hat"},
	{19554, 1, 20, "Winter Cap"},
	{19558, 1, 18, "Pizza Hat"},
	{19591, 1, 15, "Lepeza"},
	{19801, 1, 20, "Maska"},
	{19896, 1, 10, "CigarettePack1"},
	{19897, 1, 10, "CigarettePack2"},
	{-2009, 1, 10, "Calsberg pivo"},
	{-2021, 1, 150, "Prada torbica"},
	{-2028, 1, 10, "Lean"},
	{-2029, 1, 10, "Money band"},
	{-2093, 1, 10, "Kacket1"},
	{-2094, 1, 10, "Kacket2"},
	{-2095, 1, 10, "Kacket3"},
	{-2096, 1, 10, "Kacket4"},
	{-2097, 1, 10, "Kacket5"},
	{2663, 1, 10, "Vrecica"}
};

//Toolshop objects
enum TOOLSHOP_CLOTHING_ENUM
{
    tsmodel,
    tsprice,
    tsname[24]
}

new TSObjects[][TOOLSHOP_CLOTHING_ENUM] = {
	{1210, 90, "BriefCase"},
	{18633, 45, "GTASAWrench1"},
	{18634, 50, "Pajser"},
	{18635, 50, "GTASAHammer1"},
	{18644, 44, "Screwdriver1"},
	{19116, 36, "PlainHelmet1"},
	{19117, 36, "PlainHelmet2"},
	{19118, 36, "PlainHelmet3"},
	{19119, 36, "PlainHelmet4"},
	{19120, 36, "PlainHelmet5"},
	{19583, 30, "Kitchen Knife"},
	{19621, 50, "Gas Canister"},
	{19622, 22, "Broom"},
	{19626, 10, "Wrench"},
	{19624, 95, "Rockstar Briefcase"},
	{19626, 30, "Shovel"},
	{19631, 45, "Tilt hammer"},
	{19998, 25, "Upaljac"},
	{-2050, 25, "BIC upaljac"},
	{19914, 30, "Palica"},
	{19921, 60, "Tool Box"},
	{-2007, 70, "Torba #1"},
	{-2008, 70, "Torba #2"},
	{-2011, 70, "Metalna aktovka"},
	{19623, 100,"Camera #1"},
	{19804, 40,	"Lokot"},
	{1242, 	100,"Pancirka"},
	{19904, 100,"Reflektirajuci marker"},
	{19515, 100,"Prsluk"},
	{-2088, 150, "DS smedja torba"},
	{-2089, 150, "DS siva torba"},
	{-2090, 150, "Zenska torbica"},
	{-2091, 150, "Torba za plazu"},
	{-2092, 150, "Crna aktovka"},
	{-2146, 200, "Otvorena Aktovka"},
	{-2113, 100, "Klijesta"},
	{19773, 60, "Holster"}
};


//Sports objects
enum SPORTS_CLOTHING_ENUM
{
    sportsmodel,
    sportsprice,
    sportsname[24]
}

new SportsObjects[][SPORTS_CLOTHING_ENUM] = {
	{371, 70, "ParachuteBag"},
	{18632, 100, "FishingRod"},
	{18645, 100, "MotorcycleHelmet1"},
	{18936, 80, "Helmet1"},
	{18937, 80, "Helmet2"},
	{18938, 80, "Helmet3"},
	{18952, 50, "BoxingHelmet1"},
	{18976, 100, "MotorcycleHelmet2"},
	{18977, 100, "MotorcycleHelmet3"},
	{18978, 100, "MotorcycleHelmet4"},
	{18979, 100, "MotorcycleHelmet5"},
	{19036, 20, "HockeyMask1"},
	{19037, 20, "HockeyMask2"},
	{19038, 20, "HockeyMask3"},
	{19064, 45, "SantaHat1"},
	{19065, 48, "SantaHat2"},
	{19066, 48, "SantaHat3"},
	{19421, 55, "HeadPhones_Sive"},
	{19422, 55, "HeadPhones_Crne"},
	{19423, 55, "HeadPhones_Crvene"},
	{19424, 55, "HeadPhones_Plave"},
	{1009, 150, "Boca za ronjenje x1"},
	{1010, 150, "Boca za ronjenje x2"},
	{-2006, 180, "Adidas torba"},
	{-2012, 180, "Gucci_ruksak"},
	{-2013, 180, "True_Religion_ruksak"},
	{-2014, 180, "Ralph_Lauren_ruksak"},
	{-2015, 180, "Jordan_ruksak"},
	{-2016, 180, "Planinarski_ruksak"},
	{-2017, 180, "Odd_Future_ruksak"},
	{-2018, 180, "Ruksak_1"},
	{-2019, 180, "Ruksak_2"},
	{-2020, 180, "Ruksak_3"},
	{-2098, 180, "Scary maska"},
	{-2099, 180, "Majmun maska"},
	{-2100, 180, "Ragbi kaciga"},
	{-2101, 180, "Prosjak karton1"},
	{-2102, 180, "Prosjak karton2"},
	{-2103, 180, "Prosjak karton3"}

};


//Police objects
enum POLICE_CLOTHING_ENUM
{
    pdmodel,
    pdtype,
    pdprice,
    pdname[24]
}

new PDObjects[][POLICE_CLOTHING_ENUM] = {
	{19942, 4, 20, "Motorola"},
	{18636, 4, 20, "PoliceCap1"},
	{18637, 4, 50, "PoliceShield1"},
	{18641, 4, 20, "Flashlight1"},
	{18642, 4, 60, "Taser1"},
	{18643, 4, 100, "LaserPointer1"},
	{19080, 4, 100, "LaserPointer2"},
	{19081, 4, 100, "LaserPointer3"},
	{19082, 4, 100, "LaserPointer4"},
	{19083, 4, 100, "LaserPointer5"},
	{19084, 4, 100, "LaserPointer6"},
	{19099, 4, 35, "PoliceCap2"},
	{19100, 4, 35, "PoliceCap3"},
	{19520, 4, 35, "PoliceCap4_N"},
	{19521, 4, 35, "PoliceCap5_N"},
	{19138, 4, 26, "PoliceGlasses1"},
	{19139, 4, 27, "PoliceGlasses2"},
	{19140, 4, 28, "PoliceGlasses3"},
	{19141, 4, 66, "SWATHelmet1"},
	{19142, 4, 86, "SWATArmour1"},
	{19161, 4, 35, "PoliceHat1"},
	{19162, 4, 35, "PoliceHat2"},
	{19347, 4, 39, "badge01"},
	{19783, 4, 20, "Cadet"},
	{19784, 4, 20, "PO I"},
	{19778, 4, 20, "PO II"},
	{19785, 4, 20, "SLO"},
	{19781, 4, 20, "Sgt"},
	{19779, 4, 20, "Lt"},
	{19782, 4, 20, "Cpt"},
	{19780, 4, 20, "COP"},
	{19775, 4, 40, "Badge1"},
	{19774, 4, 40, "Badge2"},
	{19200, 4, 60, "Kaciga"},
	{19773, 4, 60, "Holster"},
	{-2142, 4, 50, "Attachment 1"},
	{-2143, 4, 50, "Attachment 2"},
	{-2144, 4, 50, "Attachment 3"},
	{334, 4, 50, "Baton"},
	{-2149, 4, 50, "GasMask 1"},
	{-2150, 4, 50, "GasMask 2"},
	{-2151, 4, 50, "KevlarVest"},
	{-2158, 4, 50, "PD Shield"},
	{-2159, 4, 50, "SD Badge"},
	{-2160, 4, 50, "SD Hat"},
    {-2163, 4, 50, "SD Vest"},
    {-2164, 4, 50, "SD Vest"},
    {19778, 4, 50, "Insignia1"},
    {19784, 4, 50, "Insignia2"},
    {19783, 4, 50, "Insignia3"},
    {19782, 4, 50, "Insignia4"},
    {19781, 4, 50, "Insignia5"},
    {19780, 4, 50, "Insignia6"},
    {19779, 4, 50, "Insignia7"},
    {19785, 4, 50, "Insignia8"}
};

// FDOBJECTS
enum FD_CLOTHING_ENUM
{
    fdmodel,
    fdtype,
    fdprice,
    fdname[24]
}

new FDObjects[][FD_CLOTHING_ENUM] = {
	{19142, 5, 86, "SWATArmour1"},
	{19472, 5, 25, "GasMask"},
	{19942, 5, 20, "Radio"},
	{371, 5, 10, "Backpack"},
	{-2104, 5, 10, "Prva pomoc torba"},
	{-2105, 5, 10, "FD torba"},
	{-2106, 5, 10, "Boca za ronjenje"},
	{-2107, 5, 10, "Maska za ronjenje"},
	{-2162, 5, 10, "SD Hat"},
	{-2165, 5, 10, "FD Maskica"},
	{-2166, 5, 10, "FD Pancir"},
	{-2167, 5, 10, "FD Znacka"}
};

// Gov
enum GOV_CLOTHING_ENUM {
    govmodel,
    govtype,
    govprice,
    govname[24]
}

new GOVObjects[][GOV_CLOTHING_ENUM] = {
	{19942, 4, 20, "Motorola"},
	{19142, 4, 86, "SWATArmour1"},
	{19161, 4, 35, "PoliceHat1"},
	{19162, 4, 35, "PoliceHat2"},
	{18641, 4, 20, "Flashlight1"},
	{18642, 4, 60, "Taser1"},
	{19138, 4, 26, "PoliceGlasses1"},
	{19139, 4, 27, "PoliceGlasses2"},
	{19140, 4, 28, "PoliceGlasses3"},
	{19773, 4, 60, "Holster"},
	{19347, 4, 60, "badgeZvezda"},
	{19785, 4, 60, "badgeCpt"},
	{19775, 4, 60, "badgeOff"},
	{19100, 4, 60, "SesirP1"},
	{19099, 4, 60, "SesirP2"},
	{19515, 4, 100, "ArmourGoV"},
	{334, 4, 50, "Baton"}
};

//TechoObjects
enum TECHNO_CLOTHING_ENUM
{
    teattachmodel,
    tetype,
    teprice,
    teattachname[24]
}

new TechnoObjects[][TECHNO_CLOTHING_ENUM] = {
	{18865, 7, 199, "MobilePhone1"},
	{18866, 7, 199, "MobilePhone2"},
	{18867, 7, 199, "MobilePhone3"},
	{18868, 7, 199, "MobilePhone4"},
	{18869, 7, 199, "MobilePhone5"},
	{18870, 7, 199, "MobilePhone6"},
	{18871, 7, 199, "MobilePhone7"},
	{18872, 7, 199, "MobilePhone8"},
	{18873, 7, 199, "MobilePhone9"},
	{18874, 7, 199, "MobilePhone10"},
	{-2022, 7, 350, "Samsung Galaxy S6"},
	{-2027, 7, 330, "Samsung Galaxy Note"},
	{-2025, 7, 350, "iPhone 6s"},
	{-2023, 7, 400, "iPhone 7"},
	{-2024, 7, 300, "Motorola"},
	{-2026, 7, 350, "Huaweii G7"},
	{18875, 7, 49, "Crypto1"},
	{19317, 7, 200, "bassguitar01"},
	{19318, 7, 300, "flyingv01"},
	{19319, 7, 450, "warlock01"},
	{19513, 7, 20, "whitephone"},
	{19609, 7, 800, "Drums"},
	{19610, 7, 50, "Mikrofon #1"},
	{-2010, 7, 50, "Mikrofon #2"}
};

// Premium objects
enum PREMIUM_CLOTHING_ENUM
{
    premmodel,
    premtype,
    premprice,
    premattachname[24]
}

new PremiumObjects[][PREMIUM_CLOTHING_ENUM] = {
	{19137, 1, 0, "CluckinBellHat1"},
	{19094, 1, 0, "BurgerShotHat1"},
	{19163, 1, 0, "GimpMask1"},
	{19078, 1, 0, "TheParrot1"},
	{19320, 1, 0, "pumpkin01"},
	{19352, 1, 0, "tophat01"},
	{19520, 1, 0, "pilotHat01"},
	{19519, 1, 0, "Hair1"},
	{19516, 1, 0, "Hair2"},
	{19517, 1, 0, "Hair3"},
	{19518, 1, 0, "Hair5"}
};

new AttachmentBones[][24] = {
	{"Spine"},
	{"Head"},
	{"Left upper arm"},
	{"Right upper arm"},
	{"Left hand"},
	{"Right hand"},
	{"Left thigh"},
	{"Right thigh"},
	{"Left foot"},
	{"Right foot"},
	{"Right calf"},
	{"Left calf"},
	{"Left forearm"},
	{"Right forearm"},
	{"Left clavicle"},
	{"Right clavicle"},
	{"Neck"},
	{"Jaw"}
};

new ObjectModel[MAX_PLAYERS] = 0;
/*
	 ######  ########  #######   ######  ##    ## 
	##    ##    ##    ##     ## ##    ## ##   ##  
	##          ##    ##     ## ##       ##  ##   
	 ######     ##    ##     ## ##       #####    
		  ##    ##    ##     ## ##       ##  ##   
	##    ##    ##    ##     ## ##    ## ##   ##  
	 ######     ##     #######   ######  ##    ## 
*/
stock HandlePlayerObjectSelection(playerid, item)
{
	switch( Bit8_Get( gr_MallType, playerid)) 
	{
		case MALL_REGULAR_CLOTHING: {
			ObjectModel[playerid] = NCObjects[item][ncmodel];
			Bit8_Set( gr_ObjectPrice, playerid, NCObjects[item][ncprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				NCObjects[item][ncattachname],
				NCObjects[item][ncmodel],
				NCObjects[item][ncprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_TOOLKIT_CLOTHING: {
			ObjectModel[playerid] = TSObjects[item][tsmodel];
			Bit8_Set( gr_ObjectPrice, playerid, TSObjects[item][tsprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				TSObjects[item][tsname],
				TSObjects[item][tsmodel],
				TSObjects[item][tsprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_TECHNO_CLOTHING: {
			ObjectModel[playerid] = TechnoObjects[item][teattachmodel];
			Bit8_Set( gr_ObjectPrice, playerid, TechnoObjects[item][teprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				TechnoObjects[item][teattachname],
				TechnoObjects[item][teattachmodel],
				TechnoObjects[item][teprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_SPORTS_CLOTHING: {
			ObjectModel[playerid] = SportsObjects[item][sportsmodel];
			Bit8_Set( gr_ObjectPrice, playerid, SportsObjects[item][sportsprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				SportsObjects[item][sportsname],
				SportsObjects[item][sportsmodel],
				SportsObjects[item][sportsprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_PD_CLOTHING: {
			ObjectModel[playerid] = PDObjects[item][pdmodel];
			Bit8_Set( gr_ObjectPrice, playerid, PDObjects[item][pdprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				PDObjects[item][pdname],
				PDObjects[item][pdmodel],
				PDObjects[item][pdprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_FD_CLOTHING: {
			ObjectModel[playerid] = FDObjects[item][fdmodel];
			Bit8_Set( gr_ObjectPrice, playerid, FDObjects[item][fdprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				FDObjects[item][fdname],
				FDObjects[item][fdmodel],
				FDObjects[item][fdprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_GOV_CLOTHING: {
			ObjectModel[playerid] = GOVObjects[item][govmodel];
			Bit8_Set( gr_ObjectPrice, playerid, GOVObjects[item][govprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				GOVObjects[item][govname],
				GOVObjects[item][govmodel],
				GOVObjects[item][govprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_PREM_CLOTHING: {
			ObjectModel[playerid] = PremiumObjects[item][premmodel];
			Bit8_Set( gr_ObjectPrice, playerid, PremiumObjects[item][premprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				PremiumObjects[item][premattachname],
				PremiumObjects[item][premmodel],
				PremiumObjects[item][premprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
		case MALL_HALL_CLOTHING: {
			ObjectModel[playerid] = HLObjects[item][hlmodel];
			Bit8_Set( gr_ObjectPrice, playerid, HLObjects[item][hlprice]);
			Bit8_Set( gr_HandleItem, playerid, item);
			
			new
				tmpString[128];
			format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
				HLObjects[item][hlattachname],
				HLObjects[item][hlmodel],
				HLObjects[item][hlprice]
			);
			ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
		}
	}
	return 1;
}

stock LoadPlayerObjects(playerid)
{
	mysql_tquery(g_SQL, 
		va_fquery(g_SQL, "SELECT * FROM player_objects WHERE player_id = '%d' LIMIT 0,7",
			PlayerInfo[playerid][pSQLID]
		), 
		"OnPlayerObjectsLoad", 
		"i", 
		playerid
	);
	return 1;
}

forward OnPlayerObjectsLoad(playerid);
public OnPlayerObjectsLoad(playerid)
{
	if(cache_num_rows()) 
	{
	    for( new i = 0; i < cache_num_rows(); i++) 
		{
			cache_get_value_name_int(i, 	"sqlid"	, PlayerObject[playerid][i][poSQLID]);
			cache_get_value_name_int(i, 	"model"	, PlayerObject[playerid][i][poModelid]);
			cache_get_value_name_int(i, 	"placed"	, PlayerObject[playerid][i][poPlaced]);
			cache_get_value_name_int(i, 	"bone"		, PlayerObject[playerid][i][poBoneId]);
			cache_get_value_name_float(i, 	"posX"		, PlayerObject[playerid][i][poPosX]);
			cache_get_value_name_float(i, 	"posY"		, PlayerObject[playerid][i][poPosY]);
			cache_get_value_name_float(i, 	"posZ"		, PlayerObject[playerid][i][poPosZ]);
			cache_get_value_name_float(i, 	"rotX"		, PlayerObject[playerid][i][poRotX]);
			cache_get_value_name_float(i, 	"rotY"		, PlayerObject[playerid][i][poRotY]);
			cache_get_value_name_float(i, 	"rotZ"		, PlayerObject[playerid][i][poRotZ]);
			cache_get_value_name_float(i, 	"sizeX"		, PlayerObject[playerid][i][poScaleX]);
			cache_get_value_name_float(i, 	"sizeY"		, PlayerObject[playerid][i][poScaleY]);
			cache_get_value_name_float(i, 	"sizeZ"		, PlayerObject[playerid][i][poScaleZ]);
			cache_get_value_name_int(i, 	"color1"	, PlayerObject[playerid][i][poColor1]);
			cache_get_value_name_int(i, 	"color2"	, PlayerObject[playerid][i][poColor2]);
		}
	}
	SetPlayerObjects(playerid);
	return 1;
}

hook function LoadPlayerStats(playerid)
{
	LoadPlayerObjects(playerid);
	return continue(playerid);
}

stock InsertObjectSlot(playerid, slot)
{
	if(PlayerObject[playerid][slot][poSQLID] == -1)
	{
		mysql_pquery(g_SQL, 
			va_fquery(g_SQL, 
				"INSERT INTO player_objects (player_id, model, placed, bone) VALUES ('%d', '%d', '%d', '%d')",
				PlayerInfo[playerid][pSQLID],
				PlayerObject[playerid][slot][poModelid],
				PlayerObject[playerid][slot][poPlaced],
				PlayerObject[playerid][slot][poBoneId]
			), 
			"OnPlayerObjectInsert", 
			"ii", 
			playerid, 
			slot
		);
		return 1;
	}
	return 1;
}

forward OnPlayerObjectInsert(playerid, slot);
public OnPlayerObjectInsert(playerid, slot)
{
	PlayerObject[playerid][slot][poSQLID] = cache_insert_id();
	SaveObjectSlot(playerid, slot);
	return 1;
}

stock SaveObjectSlot(playerid, slot)
{
	if(PlayerObject[playerid][slot][poSQLID] != -1 && PlayerObject[playerid][slot][poModelid] != -1)
	{
		mysql_fquery(g_SQL, 
			"UPDATE player_objects SET  placed = '%d', bone = '%d', posX = '%f', posY = '%f', posZ = '%f',\n\
				rotX = '%f', rotY = '%f', rotZ = '%f', sizeX = '%f', sizeY = '%f', sizeZ = '%f',\n\
				color1 = '%d', color2 = '%d' WHERE sqlid= '%d'",
			PlayerObject[playerid][slot][poPlaced],
			PlayerObject[playerid][slot][poBoneId],
			PlayerObject[playerid][slot][poPosX],
			PlayerObject[playerid][slot][poPosY],
			PlayerObject[playerid][slot][poPosZ],
			PlayerObject[playerid][slot][poRotX],
			PlayerObject[playerid][slot][poRotY],
			PlayerObject[playerid][slot][poRotZ],
			PlayerObject[playerid][slot][poScaleX],
			PlayerObject[playerid][slot][poScaleY],
			PlayerObject[playerid][slot][poScaleZ],
			PlayerObject[playerid][slot][poColor1],
			PlayerObject[playerid][slot][poColor2],
			PlayerObject[playerid][slot][poSQLID]
		);
		return 1;
	}
	return 1;
}

stock DeleteObjectSlot(playerid, slot)
{
	mysql_fquery(g_SQL, "DELETE FROM player_objects WHERE sqlid = '%d' AND player_id = '%d'",
		PlayerObject[playerid][slot][poSQLID],
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

stock GetObjectsLoadStatus(playerid)
{
	new index = 0;
	for(new i = 0; i < MAX_CUSTOMIZED_OBJECTS; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			index = 1;
			break;
		}
    }
	return index;
}

stock GetFreeSlot(playerid)
{
	new free;
    for(new i = 0; i < MAX_CUSTOMIZED_OBJECTS; i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			free = i;
			break;
		}
    }
    return free;
}

stock IsSlotFree(playerid)
{
	new found = 0;
    for(new i=0; i<MAX_CUSTOMIZED_OBJECTS; i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			found = 1;
			break;
		}
    }
    return found;
}

stock IsAnArraySlotFree(playerid)
{
	new found = 0;
    for(new i=0; i<MAX_CUSTOMIZED_OBJECTS; i++)
    {
        if(PlayerObject[playerid][i][poModelid] == -1)
		{
			found = 1;
			break;
		}
    }
    return found;
}

stock IsObjectAttached(playerid, modelid)
{
	new 
		found = -1;
	for(new i=0; i<MAX_CUSTOMIZED_OBJECTS; i++) {
		if(PlayerObject[playerid][i][poPlaced] && PlayerObject[playerid][i][poModelid] == modelid) {
			found = i;
			break;
		}
	}
	return found;
}

stock SetPlayerObjects(playerid)
{
	if(PlayerObject[playerid][0][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 0) && PlayerObject[playerid][0][poPlaced]) {
		PlayerObject[playerid][0][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 0, PlayerObject[playerid][0][poModelid], PlayerObject[playerid][0][poBoneId],PlayerObject[playerid][0][poPosX],PlayerObject[playerid][0][poPosY],PlayerObject[playerid][0][poPosZ],PlayerObject[playerid][0][poRotX],PlayerObject[playerid][0][poRotY],PlayerObject[playerid][0][poRotZ],PlayerObject[playerid][0][poScaleX],PlayerObject[playerid][0][poScaleY],PlayerObject[playerid][0][poScaleZ],PlayerObject[playerid][0][poColor1],PlayerObject[playerid][0][poColor2]);
	}
	
	if(PlayerObject[playerid][1][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 1) && PlayerObject[playerid][1][poPlaced]) {
		PlayerObject[playerid][1][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 1, PlayerObject[playerid][1][poModelid], PlayerObject[playerid][1][poBoneId],PlayerObject[playerid][1][poPosX],PlayerObject[playerid][1][poPosY],PlayerObject[playerid][1][poPosZ],PlayerObject[playerid][1][poRotX],PlayerObject[playerid][1][poRotY],PlayerObject[playerid][1][poRotZ],PlayerObject[playerid][1][poScaleX],PlayerObject[playerid][1][poScaleY],PlayerObject[playerid][1][poScaleZ],PlayerObject[playerid][1][poColor1],PlayerObject[playerid][1][poColor2]);
	}
	
	if(PlayerObject[playerid][2][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 2) && PlayerObject[playerid][2][poPlaced]) {
		PlayerObject[playerid][2][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 2, PlayerObject[playerid][2][poModelid], PlayerObject[playerid][2][poBoneId],PlayerObject[playerid][2][poPosX],PlayerObject[playerid][2][poPosY],PlayerObject[playerid][2][poPosZ],PlayerObject[playerid][2][poRotX],PlayerObject[playerid][2][poRotY],PlayerObject[playerid][2][poRotZ],PlayerObject[playerid][2][poScaleX],PlayerObject[playerid][2][poScaleY],PlayerObject[playerid][2][poScaleZ],PlayerObject[playerid][2][poColor1],PlayerObject[playerid][2][poColor2]);
	}
	
	if(PlayerObject[playerid][3][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 3) && PlayerObject[playerid][3][poPlaced]) {
		PlayerObject[playerid][3][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 3, PlayerObject[playerid][3][poModelid], PlayerObject[playerid][3][poBoneId],PlayerObject[playerid][3][poPosX],PlayerObject[playerid][3][poPosY],PlayerObject[playerid][3][poPosZ],PlayerObject[playerid][3][poRotX],PlayerObject[playerid][3][poRotY],PlayerObject[playerid][3][poRotZ],PlayerObject[playerid][3][poScaleX],PlayerObject[playerid][3][poScaleY],PlayerObject[playerid][3][poScaleZ],PlayerObject[playerid][3][poColor1],PlayerObject[playerid][3][poColor2]);
	}
	
	if(PlayerObject[playerid][4][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 4) && PlayerObject[playerid][4][poPlaced]) {
		PlayerObject[playerid][4][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 4, PlayerObject[playerid][4][poModelid], PlayerObject[playerid][4][poBoneId],PlayerObject[playerid][4][poPosX],PlayerObject[playerid][4][poPosY],PlayerObject[playerid][4][poPosZ],PlayerObject[playerid][4][poRotX],PlayerObject[playerid][4][poRotY],PlayerObject[playerid][4][poRotZ],PlayerObject[playerid][4][poScaleX],PlayerObject[playerid][4][poScaleY],PlayerObject[playerid][4][poScaleZ],PlayerObject[playerid][4][poColor1],PlayerObject[playerid][4][poColor2]);
	}
	
	if(PlayerObject[playerid][5][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 5) && PlayerObject[playerid][5][poPlaced]) {
		PlayerObject[playerid][5][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 5, PlayerObject[playerid][5][poModelid], PlayerObject[playerid][5][poBoneId],PlayerObject[playerid][5][poPosX],PlayerObject[playerid][5][poPosY],PlayerObject[playerid][5][poPosZ],PlayerObject[playerid][5][poRotX],PlayerObject[playerid][5][poRotY],PlayerObject[playerid][5][poRotZ],PlayerObject[playerid][5][poScaleX],PlayerObject[playerid][5][poScaleY],PlayerObject[playerid][5][poScaleZ],PlayerObject[playerid][5][poColor1],PlayerObject[playerid][5][poColor2]);
	}
	
	if(PlayerObject[playerid][6][poModelid] != -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 6) && PlayerObject[playerid][6][poPlaced]) {
		PlayerObject[playerid][6][poPlaced] = true;
		SetPlayerAttachedObject(playerid, 6, PlayerObject[playerid][6][poModelid], PlayerObject[playerid][6][poBoneId],PlayerObject[playerid][6][poPosX],PlayerObject[playerid][6][poPosY],PlayerObject[playerid][6][poPosZ],PlayerObject[playerid][6][poRotX],PlayerObject[playerid][6][poRotY],PlayerObject[playerid][6][poRotZ],PlayerObject[playerid][6][poScaleX],PlayerObject[playerid][6][poScaleY],PlayerObject[playerid][6][poScaleZ],PlayerObject[playerid][6][poColor1],PlayerObject[playerid][6][poColor2]);
	}
	return 1;
}

stock ResetObjectsVariables(playerid)
{
	Bit1_Set( gr_MallPreviewActive	, playerid, false);
	Bit2_Set( gr_TipEdita			, playerid, 0);
	Bit8_Set( gr_HandleItem			, playerid, 0);
	Bit8_Set( gr_ObjectPrice		, playerid, 0);
	ObjectModel[playerid] = 0;
	return 1;
}

stock ResetObjectEnum(playerid, slotid)
{
	PlayerObject[playerid][slotid][poModelid] = -1;
	PlayerObject[playerid][slotid][poBoneId] 	= 0;
	PlayerObject[playerid][slotid][poPlaced] 	= false;
				
	PlayerObject[playerid][slotid][poPosX] 	= 0.0;
	PlayerObject[playerid][slotid][poPosY] 	= 0.0;
	PlayerObject[playerid][slotid][poPosZ] 	= 0.0;
	
	PlayerObject[playerid][slotid][poRotX] 	= 0.0;
	PlayerObject[playerid][slotid][poRotY] 	= 0.0;
	PlayerObject[playerid][slotid][poRotZ] 	= 0.0;
	
	PlayerObject[playerid][slotid][poScaleX] 	= 1.0;
	PlayerObject[playerid][slotid][poScaleY] 	= 1.0;
	PlayerObject[playerid][slotid][poScaleZ] 	= 1.0;
	
	PlayerObject[playerid][slotid][poColor1] 	= 0;
	PlayerObject[playerid][slotid][poColor2] 	= 0;
	return 1;
}


/*
	##     ##  #######   #######  ##    ## 
	##     ## ##     ## ##     ## ##   ##  
	##     ## ##     ## ##     ## ##  ##   
	######### ##     ## ##     ## #####    
	##     ## ##     ## ##     ## ##  ##   
	##     ## ##     ## ##     ## ##   ##  
	##     ##  #######   #######  ##    ## 
*/

hook OnPlayerDeath(playerid, killerid, reason)
{
	for(new i = 0; i < MAX_CUSTOMIZED_OBJECTS; i++)
	{
	    PlayerObject[playerid][i][poPlaced] = false;
		SaveObjectSlot(playerid, i);
	}
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
	ResetObjectsVariables(playerid);
	
	for(new i = 0; i < MAX_CUSTOMIZED_OBJECTS; i++)
	{
		PlayerObject[playerid][i][poSQLID]		= -1;
		PlayerObject[playerid][i][poModelid]	= -1;
		PlayerObject[playerid][i][poBoneId]		= 0;
		PlayerObject[playerid][i][poPlaced]		= false;
		PlayerObject[playerid][i][poPosX]   	= 0.0;
		PlayerObject[playerid][i][poPosY]		= 0.0;
		PlayerObject[playerid][i][poPosZ]		= 0.0;
		PlayerObject[playerid][i][poRotX]		= 0.0;
		PlayerObject[playerid][i][poRotY]		= 0.0;
		PlayerObject[playerid][i][poRotZ]		= 0.0;
		PlayerObject[playerid][i][poScaleX]		= 1.0;
		PlayerObject[playerid][i][poScaleY]		= 1.0;
		PlayerObject[playerid][i][poScaleZ]		= 1.0;
		PlayerObject[playerid][i][poColor1] 	= 0;
		PlayerObject[playerid][i][poColor2] 	= 0;

		if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			RemovePlayerAttachedObject( playerid, i);
	}
	if(IsPlayerAttachedObjectSlotUsed(playerid, 7))
		RemovePlayerAttachedObject( playerid, 7);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 8))
		RemovePlayerAttachedObject( playerid, 8);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
		RemovePlayerAttachedObject( playerid, 9);

	return continue(playerid);
}

hook OnFSelectionResponse(playerid, fselectid, modelid, response)
{
	switch(fselectid)
	{
		case DIALOG_CLOTHING_BUY: 
		{
			if(!response) return 1;
			HandlePlayerObjectSelection(playerid, Player_ModelToIndex(playerid, modelid));
		}
		
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid)
	{
		case DIALOG_OBJECTS_BUY: {
			if(!response) return 1;
			new
				money = Bit8_Get( gr_ObjectPrice, playerid);

   			if(PlayerVIP[playerid][pDonateRank] > PREMIUM_BRONZE)
	   		money = 0;
			if(AC_GetPlayerMoney(playerid) < money) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate toliko novca!");
			
			new bstring[256];
            for(new x;x<sizeof(AttachmentBones);x++)
            {
                format(bstring, 256, "%s%s\n", bstring, AttachmentBones[x]);
            }
            ShowPlayerDialog(playerid, DIALOG_OBJECT_BONE_SELECTION, DIALOG_STYLE_LIST, \
            "{FF0000}Modifikacija objekata - Izaberite dio tijela gdje zelite staviti objekt", bstring, "Izaberi", "Izadji");
			return 1;
		}
		case DIALOG_OBJECT_BONE_SELECTION: {
			if(!response) {
				new
					item = Bit8_Get( gr_HandleItem, playerid);
				switch( Bit8_Get( gr_MallType, playerid)) 
				{
					case MALL_REGULAR_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							NCObjects[item][ncattachname],
							NCObjects[item][ncmodel],
							NCObjects[item][ncprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_TOOLKIT_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							TSObjects[item][tsname],
							TSObjects[item][tsmodel],
							TSObjects[item][tsprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_TECHNO_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							TechnoObjects[item][teattachname],
							TechnoObjects[item][teattachmodel],
							TechnoObjects[item][teprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_SPORTS_CLOTHING: {			
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							SportsObjects[item][sportsname],
							SportsObjects[item][sportsmodel],
							SportsObjects[item][sportsprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_PD_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							PDObjects[item][pdname],
							PDObjects[item][pdmodel],
							PDObjects[item][pdprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_FD_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							FDObjects[item][fdname],
							FDObjects[item][fdmodel],
							FDObjects[item][fdprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_GOV_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							GOVObjects[item][govname],
							GOVObjects[item][govmodel],
							GOVObjects[item][govprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
					case MALL_PREM_CLOTHING: {
						new
							tmpString[128];
						format( tmpString, 128, ""COL_GREEN"Naziv: "COL_WHITE"%s\n"COL_GREEN"Modelid: "COL_WHITE"%d\n"COL_GREEN"Cijena: "COL_WHITE"%d",
							PremiumObjects[item][premattachname],
							PremiumObjects[item][premmodel],
							PremiumObjects[item][premprice]
						);
						ShowPlayerDialog( playerid, DIALOG_OBJECTS_BUY, DIALOG_STYLE_MSGBOX, "ZELITE LI KUPITI OBJEKT?", tmpString, "Buy", "Abort");
					}
				}
				return 1;
			}
			if(IsPlayerAttachedObjectSlotUsed(playerid, Bit4_Get(gr_AttachmentIndexSel, playerid)))
                RemovePlayerAttachedObject(playerid, Bit4_Get(gr_AttachmentIndexSel, playerid));
			
			SetPlayerAttachedObject(playerid, Bit4_Get(gr_AttachmentIndexSel, playerid), ObjectModel[playerid], listitem+1);
            EditAttachedObject(playerid, Bit4_Get(gr_AttachmentIndexSel, playerid));
           
			Bit2_Set(gr_TipEdita, playerid, 1);
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
			return 1;
		}
		case DIALOG_NEWCLOTHING: {
			if(!response) return 1;
			if(PlayerObject[playerid][listitem][poModelid] != -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj slot vam nije prazan, koritite /objects delete prvo!");
			else
			{
				Bit4_Set(gr_AttachmentIndexSel, playerid, listitem);
				ResetObjectsVariables(playerid);
				ResetObjectEnum(playerid, listitem);
				
				switch( Bit8_Get( gr_MallType, playerid)) 
				{
					case MALL_REGULAR_CLOTHING: 
					{
						for(new i = 0; i < sizeof(NCObjects); i++)
						{
							if(NCObjects[i][ncmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, NCObjects[i][ncmodel]);
								fselection_add_item(playerid, NCObjects[i][ncmodel]);
							}
						}
					}
					case MALL_TOOLKIT_CLOTHING: 
					{
						for(new i = 0; i < sizeof(TSObjects); i++)
						{
							if(TSObjects[i][tsmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, TSObjects[i][tsmodel]);
								fselection_add_item(playerid, TSObjects[i][tsmodel]);
							}
						}
					}
					case MALL_TECHNO_CLOTHING: 
					{
						for(new i = 0; i < sizeof(TechnoObjects); i++)
						{
							if(TechnoObjects[i][teattachmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, TechnoObjects[i][teattachmodel]);
								fselection_add_item(playerid, TechnoObjects[i][teattachmodel]);
							}
						}
					}
					case MALL_SPORTS_CLOTHING: 
					{
						for(new i = 0; i < sizeof(SportsObjects); i++)
						{
							if(SportsObjects[i][sportsmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, SportsObjects[i][sportsmodel]);
								fselection_add_item(playerid, SportsObjects[i][sportsmodel]);
							}
						}
					}
					case MALL_PD_CLOTHING: 
					{
						for(new i = 0; i < sizeof(PDObjects); i++)
						{
							if(PDObjects[i][pdmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, PDObjects[i][pdmodel]);
								fselection_add_item(playerid, PDObjects[i][pdmodel]);
							}
						}
					}
					case MALL_FD_CLOTHING: 
					{
						for(new i = 0; i < sizeof(FDObjects); i++)
						{
							if(FDObjects[i][fdmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, FDObjects[i][fdmodel]);
								fselection_add_item(playerid, FDObjects[i][fdmodel]);
							}
						}
					}
					case MALL_GOV_CLOTHING: 
					{
						for(new i = 0; i < sizeof(GOVObjects); i++)
						{
							if(GOVObjects[i][govmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, GOVObjects[i][govmodel]);
								fselection_add_item(playerid, GOVObjects[i][govmodel]);
							}
						}
					}
					case MALL_PREM_CLOTHING: 
					{
						for(new i = 0; i < sizeof(PremiumObjects); i++)
						{
							if(PremiumObjects[i][premmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, PremiumObjects[i][premmodel]);
								fselection_add_item(playerid, PremiumObjects[i][premmodel]);
							}
						}
					}
					case MALL_HALL_CLOTHING: 
					{
						for(new i = 0; i < sizeof(HLObjects); i++)
						{
							if(HLObjects[i][hlmodel] != 0)
							{
								Player_ModelToIndexSet(playerid, i, HLObjects[i][hlmodel]);
								fselection_add_item(playerid, HLObjects[i][hlmodel]);
							}
						}
					}
				}
				Bit1_Set( gr_MallPreviewActive, playerid, true);
			}
			fselection_show(playerid, DIALOG_CLOTHING_BUY, "Clothing");
			return 1;
		}
		case DIALOG_DELETECLOTHING: {
			if(!response) return 1;
			if(PlayerObject[playerid][listitem][poModelid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj slot vam je prazan, ne mozete ga obrisati!");
			
			if(IsPlayerAttachedObjectSlotUsed(playerid, listitem))
				RemovePlayerAttachedObject(playerid, listitem);
			
			DeleteObjectSlot(playerid, listitem);
			ResetObjectEnum(playerid, listitem);
			return 1;
		}
	}
	return 0;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	// Weapon Attachment System
	if(EditingWeapon[playerid] != 0)
	{
		CallLocalFunction("OPEAW", "iiiiifffffffff", playerid, response, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
		return 1;
	}
	if(response) {
		if(Bit2_Get(gr_TipEdita, playerid) == 1) { //Kupnja	
	        PlayerObject[playerid][index][poModelid] 	= modelid;
			PlayerObject[playerid][index][poBoneId] 	= boneid;
			PlayerObject[playerid][index][poPlaced] 	= true;
						
	        PlayerObject[playerid][index][poPosX] 		= fOffsetX;
	        PlayerObject[playerid][index][poPosY]		= fOffsetY;
	        PlayerObject[playerid][index][poPosZ] 		= fOffsetZ;
			
	        PlayerObject[playerid][index][poRotX] 		= fRotX;
	        PlayerObject[playerid][index][poRotY] 		= fRotY;
	        PlayerObject[playerid][index][poRotZ] 		= fRotZ;
			
	        PlayerObject[playerid][index][poScaleX] 	= fScaleX;
	        PlayerObject[playerid][index][poScaleY] 	= fScaleY;
	        PlayerObject[playerid][index][poScaleZ] 	= fScaleZ;
			
			PlayerObject[playerid][index][poColor1] 	= 0;
	        PlayerObject[playerid][index][poColor2] 	= 0;
			
			InsertObjectSlot(playerid, index);
			SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
			PlayerToBudgetMoney(playerid, Bit8_Get( gr_ObjectPrice, playerid));
			
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste kupili objekt!");
			Bit2_Set(gr_TipEdita, playerid, 0);
			Bit4_Set( gr_AttachmentIndexSel	, playerid, 0);
			
			Bit1_Set( gr_MallPreviewActive, playerid, false);
			Bit8_Set( gr_MallType, playerid, 0);
		}
		else if(Bit2_Get(gr_TipEdita, playerid) == 2) { //Editanje
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste promjenili koordinate objekta!");
						
			PlayerObject[playerid][index][poModelid] 	= modelid;
			PlayerObject[playerid][index][poBoneId] 	= boneid;
			PlayerObject[playerid][index][poPlaced] 	= true;
			
	        PlayerObject[playerid][index][poPosX] 		= fOffsetX;
	        PlayerObject[playerid][index][poPosY] 		= fOffsetY;
	        PlayerObject[playerid][index][poPosZ] 		= fOffsetZ;
			
	        PlayerObject[playerid][index][poRotX] 		= fRotX;
	        PlayerObject[playerid][index][poRotY] 		= fRotY;
	        PlayerObject[playerid][index][poRotZ] 		= fRotZ;
			
	        PlayerObject[playerid][index][poScaleX] 	= fScaleX;
	        PlayerObject[playerid][index][poScaleY] 	= fScaleY;
	        PlayerObject[playerid][index][poScaleZ] 	= fScaleZ;
			
			SaveObjectSlot(playerid, index);
	        SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ,PlayerObject[playerid][index][poColor1],PlayerObject[playerid][index][poColor2]);
			Bit2_Set(gr_TipEdita, playerid, 0);
        }
    } else {
        if(Bit2_Get(gr_TipEdita, playerid) == 1) { //Kupnja
	        SendMessage(playerid, MESSAGE_TYPE_ERROR, "Koordinate objekta nisu spremljene!");
	        RemovePlayerAttachedObject(playerid, index);
	        Bit8_Set(gr_ObjectPrice, playerid, 0);
        	Bit2_Set(gr_TipEdita, playerid, 0);
        }
        else if(Bit2_Get(gr_TipEdita, playerid) == 2) { //Editanje
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Koordinate objekta nisu spremljene!");
        	Bit2_Set(gr_TipEdita, playerid, 0);
			new editedmodelid = PlayerObject[playerid][index][poModelid];
        	SetPlayerAttachedObject(playerid,index,editedmodelid,PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],PlayerObject[playerid][index][poColor1],PlayerObject[playerid][index][poColor2]);
        }
    }
    return 1;
}

public OnPlayerChangeSelectedColor(playerid, column, row)
{
	if(Bit1_Get(r_ColorSelect, playerid)) {
		new
			index = Bit4_Get(r_ColorSlotId, playerid);
		RemovePlayerAttachedObject(playerid, index);
		new editedmodelid = PlayerObject[playerid][index][poModelid];
		SetPlayerAttachedObject(playerid,index,editedmodelid,PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],ShiftRGBAToARGB(panelcolors[column][row]),ShiftRGBAToARGB(panelcolors[column][row]));
	}
	return 1;
}

public OnPlayerSelectColor(playerid, column, row)
{
	if(Bit1_Get(r_ColorSelect, playerid)) {
		new
			index = Bit4_Get(r_ColorSlotId, playerid);
		RemovePlayerAttachedObject(playerid, index);
		new editedmodelid = PlayerObject[playerid][index][poModelid];
		SetPlayerAttachedObject(playerid,index,editedmodelid,PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],ShiftRGBAToARGB(panelcolors[column][row]),ShiftRGBAToARGB(panelcolors[column][row]));
		PlayerObject[playerid][index][poColor1] = ShiftRGBAToARGB(panelcolors[column][row]);
		PlayerObject[playerid][index][poColor2] = ShiftRGBAToARGB(panelcolors[column][row]);
		SaveObjectSlot(playerid, index);
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(Bit1_Get(r_ColorSelect, playerid)) {
		if((newkeys & KEY_ANALOG_LEFT) && !(oldkeys & KEY_ANALOG_LEFT))
			MoveColorDialogCursor(playerid, CURSOR_MOVE_LEFT);
		else if((newkeys & KEY_ANALOG_RIGHT) && !(oldkeys & KEY_ANALOG_RIGHT))
			MoveColorDialogCursor(playerid, CURSOR_MOVE_RIGHT);
		else if((newkeys & KEY_YES) && !(oldkeys & KEY_YES))
			MoveColorDialogCursor(playerid, CURSOR_MOVE_UP);
		else if((newkeys & KEY_NO) && !(oldkeys & KEY_NO))
			MoveColorDialogCursor(playerid, CURSOR_MOVE_DOWN);
		else if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT)) {
			SelectCurrentColor(playerid);
			HidePlayerColorSelectDialog(playerid);
			DestroyColorSelectionDialog(playerid);
			Bit1_Set(r_ColorSelect, playerid, false);
			TogglePlayerControllable(playerid, true);
		}
		else if((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH)) {
			new
				index = Bit4_Get(r_ColorSlotId, playerid);
			RemovePlayerAttachedObject(playerid, index);
			new editedmodelid = PlayerObject[playerid][index][poModelid];
			SetPlayerAttachedObject(playerid,index,editedmodelid,PlayerObject[playerid][index][poBoneId],PlayerObject[playerid][index][poPosX],PlayerObject[playerid][index][poPosY],PlayerObject[playerid][index][poPosZ],PlayerObject[playerid][index][poRotX],PlayerObject[playerid][index][poRotY],PlayerObject[playerid][index][poRotZ],PlayerObject[playerid][index][poScaleX],PlayerObject[playerid][index][poScaleY],PlayerObject[playerid][index][poScaleZ],PlayerObject[playerid][index][poColor1],PlayerObject[playerid][index][poColor2]);
			HidePlayerColorSelectDialog(playerid);
			DestroyColorSelectionDialog(playerid);
			Bit1_Set(r_ColorSelect, playerid, false);
			Bit4_Set(r_ColorSlotId, playerid, 0);
			TogglePlayerControllable(playerid, true);
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

CMD:objects(playerid, params[])
{
	new item[16], izbor;
    if(sscanf(params, "s[16] ", item))
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTENJE: /objects [opcija]");
		SendClientMessage(playerid, COLOR_WHITE, "[OPCIJE]: buy, delete, attach, detach, edit, changebone");
		return 1;
	}
    if(strcmp(item,"buy",true) == 0)
	{
	    if(!IsAnArraySlotFree(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate slobodnih slotova");
	    if(!IsSlotFree(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate slobodnih slotova");
		new
			tmpString[128];
		if(IsPlayerInRangeOfPoint(playerid,10,1096.0909, -1440.6428, 14.7926))//Obican clothing
		{
	        for(new x=0; x < MAX_CUSTOMIZED_OBJECTS; x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }		
			Bit8_Set( gr_MallType, playerid, MALL_REGULAR_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid,5,1145.6530, -1528.2751, 14.7915))//Tool shop
		{
	        for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_TOOLKIT_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid,5,1166.0682, -1429.5367, 21.7419))//Sports shop
		{
	        for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_SPORTS_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid,8.0,1292.8439,1097.6317,-18.9368) || IsPlayerInRangeOfPoint(playerid,8.0,2032.1844,2206.1392,-31.4410) || IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174))//PD/SD Armoury objects
		{
		    if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi LSPD/SASD!");
	        for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_PD_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1176.3463,-1344.6559,-53.6860))//FD Armoury objects
		{
		    if(!IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi LSFD!");
	        for(new x; x < MAX_CUSTOMIZED_OBJECTS; x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_FD_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1315.2745,757.4198,-93.1678)) // Gov
		{
			if(FactionInfo[PlayerFaction[playerid][pMember]][fType] != FACTION_TYPE_LEGAL)
				return (true);
	        for(new x; x < MAX_CUSTOMIZED_OBJECTS; x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)
	            {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else
				{
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_GOV_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
		}
	    else if(IsPlayerInRangeOfPoint(playerid,5,1160.8146, -1467.8569, 15.1255))//Techno shop
		{
	        for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)  {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else {
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_TECHNO_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
		else if(IsPlayerInRangeOfPoint(playerid,10.0,2780.5273, -2380.4326, 13.3419)) { // Halloween
			for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)  {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else {
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_HALL_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
		}
		else if(PlayerVIP[playerid][pDonateRank] > 0) // Premium shop
		{
	        for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
	        {
	            if(PlayerObject[playerid][x][poModelid] != -1)  {
	                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
				 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
				}
            	else {
				    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
				    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
				}
	        }
			Bit8_Set( gr_MallType, playerid, MALL_PREM_CLOTHING);
	        ShowPlayerDialog(playerid, DIALOG_NEWCLOTHING, DIALOG_STYLE_LIST, \
	        "{FF0000}Sistem objekata - Izaberite slot", tmpString, "Izaberi", "Izadji");
	    }
	}
	else if(strcmp(item,"delete",true) == 0)
	{
		new
			tmpString[128];
	    for(new x;x<MAX_CUSTOMIZED_OBJECTS;x++)
        {
            if(PlayerObject[playerid][x][poModelid] != -1) {
                if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d (Zauzeto)\n", x);
			 	else format(tmpString, sizeof(tmpString), "%s Slot %d (Zauzeto)\n", tmpString, x);
			}
        	else {
			    if(x == 0) format(tmpString, sizeof(tmpString), "Slot %d\n", x);
			    else format(tmpString, sizeof(tmpString), "%s Slot %d\n", tmpString, x);
			}
        }
        ShowPlayerDialog(playerid, DIALOG_DELETECLOTHING, DIALOG_STYLE_LIST, \
		"{FF0000}Izaberite slot koji zelite izbrisati", tmpString, "Izaberi", "Izadji");
	}	
	else if(strcmp(item,"attach",true) == 0)
	{
	    if(sscanf(params, "s[16]i", item, izbor)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTENJE: /objects attach [0-6]");
		if(izbor < 0 || izbor > 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Index objekta ne moze biti manji od 0 i veci od 6!");
		if(IsPlayerAttachedObjectSlotUsed(playerid, izbor)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec postoji nekakav objekt na tom mjestu!");
		if(PlayerObject[playerid][izbor][poPlaced]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec postoji nekakav objekt na tom mjestu!");
		if(PlayerObject[playerid][izbor][poModelid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate objekt pod tim slotom!");
		
		PlayerObject[playerid][izbor][poPlaced] = true;
		SaveObjectSlot(playerid, izbor);
		new attachmodelid = PlayerObject[playerid][izbor][poModelid];
		SetPlayerAttachedObject(playerid, izbor, attachmodelid, PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Stavili ste objekt, mozete ga skinuti s /objects detach");
	}
	else if(strcmp(item,"detach",true) == 0)
	{
        if(sscanf(params, "s[16]i", item, izbor)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTENJE: /objects detach [0-6]");
		if(izbor < 0 || izbor > 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Index objekta ne moze biti manji od 0 i veci od 6!");
		if(!IsPlayerAttachedObjectSlotUsed(playerid, izbor)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		if(!PlayerObject[playerid][izbor][poPlaced]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		if(PlayerObject[playerid][izbor][poModelid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate objekt pod tim slotom!");
		PlayerObject[playerid][izbor][poPlaced] = false;
		SaveObjectSlot(playerid, izbor);
		RemovePlayerAttachedObject(playerid, izbor);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Skinuli ste objekt, mozete ga opet staviti s /objects attach");
	}
	else if(strcmp(item,"edit",true) == 0)
	{
		new
			pick[6];
        if(sscanf(params, "s[16]s[6]i", item, pick, izbor)) return SendClientMessage(playerid, COLOR_WHITE, "KORISTENJE: /objects edit [color/edit][0-6]");
		if(izbor < 0 || izbor > 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Index objekta ne moze biti manji od 0 i veci od 6!");
		if(!IsPlayerAttachedObjectSlotUsed(playerid, izbor)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		if(!PlayerObject[playerid][izbor][poPlaced]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		if(PlayerObject[playerid][izbor][poModelid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate objekt pod tim slotom!");
		
		if(!strcmp(pick, "edit", true)) {
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
			
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Usli ste u editanje objekta. Mozete mjenjati poziciju, velicinu i ostalo.");
			SendClientMessage(playerid, COLOR_YELLOW, "HINT: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
		}
		else if(!strcmp(pick, "color", true)) {
			Bit4_Set(r_ColorSlotId, playerid, izbor);
			CreateColorSelectionDialog(playerid);
			ShowPlayerColorSelectDialog(playerid);
			TogglePlayerControllable(playerid, false);
			Bit1_Set(r_ColorSelect, playerid, true);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Odaberite boju za svoj objekt!");
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "KORISTENJE: /objects edit [color/edit][0-6]");
	}
	else if(strcmp(item,"changebone",true) == 0)
	{
	    new bone[16], selectedmodelid;
        if(sscanf(params, "s[16]is[16]", item, izbor, bone))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "KORISTENJE: /objects changebone [0-6][bone]");
			SendClientMessage(playerid, COLOR_WHITE, "Bone IDs: spine, head, leftupperarm, rightupperarm, lefthand, righthand");
			SendClientMessage(playerid, COLOR_WHITE, "leftthigh, rightthigh, leftfoot, rightfoot, rightcalf, leftcalf, leftforearm");
			SendClientMessage(playerid, COLOR_WHITE, "rightforearm, leftclavicle, rightclavicle, neck, jaw");
			return 1;
		}
		if(izbor < 0 || izbor > 6) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Index objekta ne moze biti manji od 0 i veci od 6!");
		if(!IsPlayerAttachedObjectSlotUsed(playerid, izbor)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		
		if(!PlayerObject[playerid][izbor][poPlaced]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne postoji nikakav objekt na tom mjestu!");
		if(PlayerObject[playerid][izbor][poModelid] == -1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate objekt pod tim slotom!");
		
		if(strcmp(bone,"Spine",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 1;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"head",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 2;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
			
            selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftupperarm",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 3;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightupperarm",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 4;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"lefthand",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 5;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
           
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"righthand",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 6;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftthigh",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 7;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightthigh",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 8;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftfoot",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 9;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightfoot",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 10;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightcalf",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 11;
           
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftcalf",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 12;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
           
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftforearm",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 13;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightforearm",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 14;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"leftclavicle",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
		    PlayerObject[playerid][izbor][poBoneId] = 15;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"rightclavicle",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
			PlayerObject[playerid][izbor][poBoneId] = 16;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"neck",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
			PlayerObject[playerid][izbor][poBoneId] = 17;
           
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
		else if(strcmp(bone,"jaw",true) == 0)
		{
		    RemovePlayerAttachedObject(playerid, izbor);
			PlayerObject[playerid][izbor][poBoneId] = 18;
            
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste bone id, sada ga mozete editati!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Hint: KORISTENJE {FFFF00}~k~~PED_SPRINT~{FFFFFF} da okrenes kameru.");
            
			selectedmodelid = PlayerObject[playerid][izbor][poModelid];
			SetPlayerAttachedObject(playerid, izbor, selectedmodelid,PlayerObject[playerid][izbor][poBoneId],PlayerObject[playerid][izbor][poPosX],PlayerObject[playerid][izbor][poPosY],PlayerObject[playerid][izbor][poPosZ],PlayerObject[playerid][izbor][poRotX],PlayerObject[playerid][izbor][poRotY],PlayerObject[playerid][izbor][poRotZ],PlayerObject[playerid][izbor][poScaleX],PlayerObject[playerid][izbor][poScaleY],PlayerObject[playerid][izbor][poScaleZ],PlayerObject[playerid][izbor][poColor1],PlayerObject[playerid][izbor][poColor2]);
            
			EditAttachedObject(playerid, izbor);
			Bit2_Set(gr_TipEdita, playerid, 2);
		}
	}
	return 1;
}
