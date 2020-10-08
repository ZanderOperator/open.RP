#include <YSI\y_hooks>

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/
#define MAX_FLARES							(20)
#define FACTION_ID_PD 						(1)
#define FACTION_ID_SD 						(3)
#define IMPOUND_PRICE						(1000)
#define FLASHLIGHT_OBJECT 					(9)

// #define MODEL_SELECTION_LAWSKIN (969) // pd
//#define MODEL_SELECTION_GOVSKIN 			(968) // gov

enum flInfo
{
 	flCreated,
    Float:flX,
    Float:flY,
    Float:flZ,
    flObject
}
new FlareInfo[MAX_FLARES][flInfo];

// Global
new
	ramp,
	rampstatus,
	pdkapija,
	pdvrata,
	lspd_doors[13],
	lspd_dstatus[13];

// Player Vars
new
	Float:MolePosition[ MAX_PLAYERS ][ 3 ],
	bool:undercover_mask[MAX_PLAYERS] = (false),
	Text3D:unknown_text[MAX_PLAYERS],
	SetPDChannel_ID[MAX_PLAYERS] = 0,
	SetFDChannel_ID[MAX_PLAYERS] = 0,
	bool: flashlight_status[MAX_PLAYERS] = (false);

// rBits
new
	Bit1: gr_PlayerHaveMole		<MAX_PLAYERS>,
	Bit1: gr_PlayerPlacedMole	<MAX_PLAYERS>,
	Bit1: gr_PlayerIsSWAT		<MAX_PLAYERS>,
	Bit2: gr_PlayerListenMole	<MAX_PLAYERS>;

// Callbacks
forward GateClose();
public GateClose()
{
 	SetDynamicObjectRot(pdvrata,0,0.2471923828125,358.9912109375);
    MoveDynamicObject(pdkapija,1589.029419, -1638.166748, 15.182871, 2.5);
}

forward OnPlayerTaser(playerid);
public OnPlayerTaser(playerid)
{
	Bit1_Set( gr_PlayerTazed, playerid, false );
	TogglePlayerControllable( playerid, true );
	ClearAnimations(playerid, 1);

	KillTimer(TaserAnimTimer[playerid]);
	KillTimer(TaserTimer[playerid]);
	return 1;
}

forward OnPlayerTaserAnim(playerid);
public OnPlayerTaserAnim(playerid)
{
	return ApplyAnimationEx(playerid,"PED","KO_skid_front",4.1,0,1,1,1,1,1,0);
}

forward PASpamTimer(playerid);
public PASpamTimer(playerid)
{
	Bit1_Set(gr_Paspam, playerid, false);
	return 1;
}

Function: OnPlayerSlowUpdate(playerid)
{
	vBlinker(playerid);
	return 1;
}

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/
stock static CreateFlare(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(FlareInfo); i++)
  	{
  	    if(FlareInfo[i][flCreated] == 0)
  	    {
            FlareInfo[i][flCreated]=1;
            FlareInfo[i][flX]=x;
            FlareInfo[i][flY]=y;
            FlareInfo[i][flZ]=z-0.5;
            FlareInfo[i][flObject] = CreateDynamicObject(18728, x, y, z-2.8, 0, 0, Angle-90, -1, -1, -1, 800.0);
	        return 1;
  	    }
  	}
  	return 0;
}

stock static DeleteAllFlare()
{
    for(new i = 0; i < sizeof(FlareInfo); i++)
  	{
  	    if(FlareInfo[i][flCreated] == 1)
  	    {
  	        FlareInfo[i][flCreated]=0;
            FlareInfo[i][flX]=0;
            FlareInfo[i][flY]=0;
            FlareInfo[i][flZ]=0;
            DestroyDynamicObject(FlareInfo[i][flObject]);
  	    }
	}
    return 0;
}

stock static DeleteClosestFlare(playerid)
{
    for(new i = 0; i < sizeof(FlareInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 5.0, FlareInfo[i][flX], FlareInfo[i][flY], FlareInfo[i][flZ]))
        {
  	        if(FlareInfo[i][flCreated] == 1)
            {
                FlareInfo[i][flCreated]=0;
                FlareInfo[i][flX]=0;
                FlareInfo[i][flY]=0;
                FlareInfo[i][flZ]=0;
                DestroyDynamicObject(FlareInfo[i][flObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

stock IsAtArrest(playerid)
{
    return IsPlayerInRangeOfPoint(playerid, 10.0, 1940.9509, 809.7464, -46.6122) || IsPlayerInRangeOfPoint(playerid, 10.0, 1192.9391,1327.4951,-54.7172);
}

stock vBlinker(playerid)
{
	if(Bit1_Get(Blinking, playerid))
	{
		new Keys, ud, lr, panels, doors, lights, tires, vehicleid;
		if(!IsPlayerInAnyVehicle(playerid))
		{
			Bit1_Set(Blinking, playerid, false);
			vehicleid = Bit16_Get(gr_LastVehicle, playerid);
			GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
			lights = encode_lights(0, 0, 0, 0);
			UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
			return 1;
		}
		else
		{
			vehicleid = GetPlayerVehicleID(playerid);
			GetPlayerKeys(playerid, Keys, ud, lr);
			GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		}
		switch(Flash[vehicleid])
        {
			case 0: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
            case 1: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
            case 2: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
            case 3: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
            case 4: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
            case 5: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
        }
        if(Flash[vehicleid] >= 5) Flash[vehicleid] = 0;
        else Flash[vehicleid] ++;
	}
    return 1;
}
/*
GetPDChannelName(pdchannel_id) {
	new channel_name[20];
	switch(pdchannel_id) {
		case 1: // CH 1
			channel_name = "LSPD DISP";
		case 2: // CH 2
			channel_name = "L-TAC 1";
		case 3: // CH 3
			channel_name = "L-TAC 2";
		case 4: // CH 4
			channel_name = "L-TAC 3";
		case 5: // CH 5
			channel_name = "METRO";
		case 6: // CH 6
			channel_name = "DD";
		default:
			channel_name = "N/A";
	}
	return channel_name;
}

GetFDChannelName(fdchannel_id) {
	new channel_name[20];
	switch(fdchannel_id) {
		case 1: // CH 1
			channel_name = "Fire Department";
		case 2: // CH 2
			channel_name = "Medic Department";
		case 3: // CH 3
			channel_name = "Air Divison";
		case 4: // CH 4
			channel_name = "Hazmat Division";
		default:
			channel_name = "N/A";
	}
	return channel_name;
}



SendPDChannelMessage(color = COLOR_WHITE, message[], pdchannel_id) {
	foreach (new i : Player)
	{
		if(SetPDChannel_ID[i] == pdchannel_id) {
			SendClientMessage(i, color, message);
			PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
		}
	}
	return (true);
}

SendFDChannelMessage(color = COLOR_WHITE, message[], fdchannel_id) {
	foreach (new i : Player)
	{
		if(SetFDChannel_ID[i] == fdchannel_id) {
			SendClientMessage(i, color, message);
			PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
		}
	}
	return (true);
}
*/
/*
	##     ##  #######   #######  ##    ##
	##     ## ##     ## ##     ## ##   ##
	##     ## ##     ## ##     ## ##  ##
	######### ##     ## ##     ## #####
	##     ## ##     ## ##     ## ##  ##
	##     ## ##     ## ##     ## ##   ##
	##     ##  #######   #######  ##    ##
*/
hook OnPlayerDisconnect(playerid, reason)
{
	if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
	{
		DestroyDynamic3DTextLabel(unknown_text[playerid]);
		unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
	}
	Bit1_Set( Blinking, playerid, false );
	Bit1_Set(gr_Paspam, playerid, false);
	SetPDChannel_ID[playerid] = 0;
	SetFDChannel_ID[playerid] = 0;
	return 1;
}

hook OnPlayerConnect(playerid)
{
    Bit1_Set(gr_Paspam, playerid, false);
	//RemoveBuildingForPlayer(playerid, 3744, 1992.304, -2146.421, 15.132, 0.250);
   // RemoveBuildingForPlayer(playerid, 3574, 1992.296, -2146.414, 15.070, 0.250);

	// Heliport Map by sWiperro
	RemoveBuildingForPlayer(playerid, 5137, 2005.250, -2137.460, 16.515, 0.250);
	RemoveBuildingForPlayer(playerid, 5195, 2005.250, -2137.460, 16.515, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 1992.304, -2146.421, 15.132, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2101.789, -2162.578, 15.132, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2101.796, -2162.562, 15.070, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 1992.296, -2146.414, 15.070, 0.250);
	RemoveBuildingForPlayer(playerid, 3567, 2083.523, -2159.617, 13.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2001.023, -2119.984, 19.750, 0.250);
	RemoveBuildingForPlayer(playerid, 5337, 1995.437, -2066.148, 18.531, 0.250);
	return 1;
}

hook OnGameModeInit()
{
	CreateDynamicObject(994, 1545.21606, -1620.69897, 12.89000,   0.00000, 0.00000, 90.00000);
	ramp = CreateDynamicObject(968, 1544.6943359375, -1630.73046875, 13.27956199646, 0.000000, 90, 90);
	rampstatus = 0;

	pdkapija = CreateDynamicObject(971,1589.00000000,-1638.00000000,12.89999962,0.00000000,0.00000000,0.00000000);
	pdvrata = CreateDynamicObject(1495,1582.59997559,-1638.00000000,12.39999962,0.00000000,0.00000000,0.00000000);

	// USMS - Garage
	CreateDynamicObject(9093, 606.34991, -1488.73291, 15.62600,   2.00000, 0.00000, 90.00000);
	CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 9, -1, -1, 100.00); // world 9
	CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 9, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 9, -1, -1, 100.00);
	CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 9, -1, -1, 100.00);

	// LSPD WILSHIRE - DOORS (LEO)

	lspd_doors[0] = CreateDynamicObject(1569, -1178.213623, -1668.080688, 896.097229, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[1] = CreateDynamicObject(1569, -1202.099365, -1650.670166, 899.596374, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[2] = CreateDynamicObject(1569, -1201.181274, -1644.569702, 899.596252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[3] = CreateDynamicObject(1569, -1193.331298, -1644.569702, 899.596252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[4] = CreateDynamicObject(1569, -1187.880859, -1647.799438, 899.596252, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[5] = CreateDynamicObject(1569, -1171.442871, -1662.140991, 896.107238, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[6] = CreateDynamicObject(1537, -1165.977783, -1657.548461, 896.127258, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[7] = CreateDynamicObject(3089, -1178.615356, -1646.455932, 897.367919, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[8] = CreateDynamicObject(1569, -1171.442871, -1657.331298, 896.107238, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[9] = CreateDynamicObject(19302, -1192.597412, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[10] = CreateDynamicObject(19302, -1189.407348, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[11] = CreateDynamicObject(19302, -1186.197143, -1640.880126, 893.057312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	lspd_doors[12] = CreateDynamicObject(968, 764.66992, -1416.04749, 13.26500,   0.00000, 89.00000, 0.00000, -1, -1, -1, 600.00, 600.00);

	// Heliport Map by sWiperro
	new heliport_map;
	heliport_map = CreateDynamicObject(10063, 2080.009033, -2141.120849, 8.566017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	heliport_map = CreateDynamicObject(10063, 2020.399658, -2141.110839, 8.576017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	heliport_map = CreateDynamicObject(10063, 2000.639404, -2141.120849, 8.566017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 2, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 6, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
	heliport_map = CreateDynamicObject(970, 2036.231445, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(11504, 2058.239746, -2123.503906, 25.122892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 7488, "vegasdwntwn1", "villainnwall02_128", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 4, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 5, 3436, "motel01", "vegasmoteldoor01_128", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 6, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	heliport_map = CreateDynamicObject(16095, 2057.320556, -2124.391357, 28.212888, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 8401, "vgshpground", "vegaspawnwall02_128", 0x00000000);
	heliport_map = CreateDynamicObject(19815, 2060.319335, -2125.897460, 30.389759, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	heliport_map = CreateDynamicObject(19815, 2060.309082, -2125.897460, 31.049757, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	heliport_map = CreateDynamicObject(19815, 2054.348632, -2125.897460, 31.049757, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	heliport_map = CreateDynamicObject(19815, 2054.337646, -2125.897460, 30.379755, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0x00000000);
	heliport_map = CreateDynamicObject(970, 2040.392211, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2044.562622, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(11245, 2054.829101, -2124.099853, 34.433017, -1.399997, -68.400070, 1.899996, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
	heliport_map = CreateDynamicObject(970, 2032.081787, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2027.951660, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2023.791992, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2019.632202, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2015.482543, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2011.332153, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2007.182006, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2003.022216, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1998.862792, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1994.713012, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1990.543212, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1986.382934, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1982.232666, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1978.092651, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1973.933105, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1972.953247, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2048.672607, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2058.202148, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2062.372070, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2066.522949, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2070.692871, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2074.842529, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2078.992431, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2083.152343, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2087.313232, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2091.463134, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2095.624023, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2099.784912, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2103.935058, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2107.495605, -2119.526611, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2107.485595, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2103.315917, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2099.155517, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2095.005615, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2090.834716, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2086.684570, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2082.533691, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2078.403808, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2074.233154, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2070.072509, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2065.912597, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2061.762207, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2057.601318, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2053.440917, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2049.281738, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2045.121337, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2040.991455, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2036.840698, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2032.690551, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2028.550415, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2024.410156, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2020.270507, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2016.120727, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2011.981079, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2007.841186, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 2003.700805, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1999.561157, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1995.431152, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1991.300903, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1987.161254, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1982.990722, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1978.859985, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1974.720336, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(970, 1972.959960, -2158.785888, 25.142896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 16646, "a51_alpha", "des_rails1", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19853, "mihouse1", "yellowwall1_64", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(19452, 2096.780761, -2139.041748, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19370, 1975.499023, -2141.128417, 25.042892, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 13744, "docg01alfa_lahills", "Helipad_H", 0xFFFFFFFF);
	SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 19480, "signsurf", "sign", 0x00000000);
	heliport_map = CreateDynamicObject(19452, 2007.330932, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2020.351318, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 1992.430664, -2141.122314, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(3934, 2020.431884, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(3934, 2007.291503, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(3934, 1992.461303, -2131.737548, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(19452, 1993.020996, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 1983.401245, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2002.811157, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2012.441406, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2022.071533, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2031.701293, -2141.142333, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19370, 2105.870849, -2144.089355, 25.042892, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 13744, "docg01alfa_lahills", "Helipad_H", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 19480, "signsurf", "sign", 0x00000000);
	heliport_map = CreateDynamicObject(19452, 2041.085571, -2142.536376, 23.372894, 0.000000, 0.000000, -106.900001, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2050.489990, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2060.129882, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(3934, 2020.431884, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, -1, "none", "none", 0xFFFFFFFF);
	heliport_map = CreateDynamicObject(19452, 2069.760253, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2079.380859, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2089.009765, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2098.630126, -2143.933105, 23.372894, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19327, 2054.505615, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(heliport_map, 0, "{000000}LOS SANTOS", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	heliport_map = CreateDynamicObject(19327, 2056.606445, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(heliport_map, 0, "{000000}POLICE DEPA", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	heliport_map = CreateDynamicObject(19327, 2058.258056, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(heliport_map, 0, "{000000}RTMENT", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	heliport_map = CreateDynamicObject(19327, 2059.788330, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(heliport_map, 0, "{000000}- HOOVER", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	heliport_map = CreateDynamicObject(19327, 2061.458740, -2127.965820, 28.952896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(heliport_map, 0, "{000000}HELIPORT", 50, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	heliport_map = CreateDynamicObject(19452, 2047.369750, -2127.340576, 23.372894, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2069.108886, -2127.340576, 23.372894, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2064.218505, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2054.607910, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19452, 2052.267333, -2132.070312, 23.372894, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	heliport_map = CreateDynamicObject(19430, 2112.638183, -2134.199218, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
	heliport_map = CreateDynamicObject(19430, 2112.638183, -2131.068847, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
	heliport_map = CreateDynamicObject(19430, 2112.638183, -2128.107421, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
	heliport_map = CreateDynamicObject(19430, 2112.638183, -2125.087646, 11.832813, 90.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(heliport_map, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
	heliport_map = CreateDynamicObject(19452, 2081.080566, -2139.041748, 23.372894, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(heliport_map, 0, 18835, "mickytextures", "smileyface1", 0xFFFFCC00);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	heliport_map = CreateDynamicObject(4005, 2085.804931, -2134.004638, 10.148071, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2088.864013, -2144.255615, 10.148071, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2088.154296, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2042.645385, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 1997.125976, -2144.665039, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 1994.444702, -2144.645751, 11.008069, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 1991.384765, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2036.883789, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2084.963378, -2133.565429, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(4005, 2043.071655, -2133.575439, 11.008069, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3876, 2067.089599, -2123.622802, -5.857117, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(16101, 2054.452880, -2124.048339, 26.549764, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3287, 2044.900634, -2122.031738, 28.362894, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3934, 1992.540161, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3934, 2007.451538, -2150.377685, 25.122892, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3934, 2096.443359, -2128.563476, 25.122892, 0.000000, 0.000000, 51.800006, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3666, 1975.421752, -2141.053955, 24.622884, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3666, 2105.837890, -2144.007568, 24.622886, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(11713, 2069.240722, -2126.804199, 26.602890, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(11727, 2065.009277, -2127.627441, 28.032894, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(1537, 2110.136474, -2144.131347, 12.632811, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(8948, 2110.076171, -2139.716552, 14.342810, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	heliport_map = CreateDynamicObject(3934, 2081.253662, -2128.452636, 25.122892, 0.000000, 0.000000, 46.600006, -1, -1, -1, 300.00, 300.00);

	// Impound GaraZa
	CreateObject(17089, -1233.80469, -1451.27344, 98.76563,   356.85840, 0.00000, 3.14159);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SECONDARY_ATTACK) // LSPD INTERIORI
	{
	    if( IsPlayerInRangeOfPoint( playerid, 3.0, 629.6035, 1686.5359, 4503.2939 ) ) // NA ULAZU U HQ
			SetPlayerPosEx(playerid,1539.0114, 11.4043, 4001.5081,3,9,true);
		else if( IsPlayerInRangeOfPoint( playerid, 3.0, 1539.0114, 11.4043, 4001.5081 ) ) // IZLAZ IZ HQa
			SetPlayerPosEx(playerid,629.6035, 1686.5359, 4503.2939,3,10,true);
	}
	if( PRESSED(KEY_NO) ) { // Leo
		if(!IsACop(playerid) && !IsASD(playerid)) return true;
		if( IsObjectAttached(playerid, 18641) == -1 ) return (true);
		if( IsPlayerInAnyVehicle( playerid ) ) return (true);

		if(flashlight_status[playerid] == false)
			SetPlayerAttachedObject(playerid, FLASHLIGHT_OBJECT,18656, 5, 0.1, 0.038, -0.1, -90, 180, 0, 0.03, 0.03, 0.03), flashlight_status[playerid] = true; // Lampa sljasti ko bangkok.
		else if(flashlight_status[playerid] == true)
			RemovePlayerAttachedObject(playerid, FLASHLIGHT_OBJECT), flashlight_status[playerid] = false; // Lampa sljasti ko bangkok.
	}
	if( PRESSED(KEY_YES) ) // Tipka Y
	{
		//======================== [LSPD WILSHIRE NEW ] =========================
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 764.66992, -1416.04749, 13.26500)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[12] == 0) {
				SetDynamicObjectRot(lspd_doors[12], 0.0000, 0.0000, 0.0000);
				lspd_dstatus[12] = 1;
			}
			else if(lspd_dstatus[12] == 1) {
				SetDynamicObjectRot(lspd_doors[12], 0.0000, 89.0000, 0.0000);
				lspd_dstatus[12] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.2136, -1668.0807, 896.0972)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[0] == 0) {
				SetDynamicObjectRot(lspd_doors[0], 0, 0,  88.6089);
				lspd_dstatus[0] = 1;
			}
			else if(lspd_dstatus[0] == 1) {
				SetDynamicObjectRot(lspd_doors[0], 0, 0,  0.000000);
				lspd_dstatus[0] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1202.099365, -1650.670166, 899.596374)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[1] == 0) {
				SetDynamicObjectRot(lspd_doors[1], 0, 0,  178.4952);
				lspd_dstatus[1] = 1;
			}
			else if(lspd_dstatus[1] == 1) {
				SetDynamicObjectRot(lspd_doors[1], 0, 0,  87.5528);
				lspd_dstatus[1] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1201.1813, -1644.5697, 899.5963)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[2] == 0) {
				SetDynamicObjectRot(lspd_doors[2], 0, 0,  95.0652);
				lspd_dstatus[2] = 1;
			}
			else if(lspd_dstatus[2] == 1) {
				SetDynamicObjectRot(lspd_doors[2], 0, 0,  0.0);
				lspd_dstatus[2] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1193.331298, -1644.569702, 899.596252)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[3] == 0) {
				SetDynamicObjectRot(lspd_doors[3], 0, 0,  88.2804);
				lspd_dstatus[3] = 1;
			}
			else if(lspd_dstatus[3] == 1) {
				SetDynamicObjectRot(lspd_doors[3], 0, 0,  0.0);
				lspd_dstatus[3] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1187.880859, -1647.799438, 899.596252)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[4] == 0) {
				SetDynamicObjectRot(lspd_doors[4], 0, 0, 184.6753);
				lspd_dstatus[4] = 1;
			}
			else if(lspd_dstatus[4] == 1) {
				SetDynamicObjectRot(lspd_doors[4], 0.0000, 0.0000, 90.0000);
				lspd_dstatus[4] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1171.442871, -1662.140991, 896.10723)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[5] == 0) {
				SetDynamicObjectRot(lspd_doors[5], 0.0000, 0.0000, 348.1025);
				lspd_dstatus[5] = 1;
			}
			else if(lspd_dstatus[5] == 1) {
				SetDynamicObjectRot(lspd_doors[5], 0.0000, 0.0000, 90.0000);
				lspd_dstatus[5] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1165.977783, -1657.548461, 896.127258)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[6] == 0) {
				SetDynamicObjectRot(lspd_doors[6], 0.0000, 0.0000, 192.1085);
				lspd_dstatus[6] = 1;
			}
			else if(lspd_dstatus[6] == 1) {
				SetDynamicObjectRot(lspd_doors[6], 0.0000, 0.0000, 270.0000);
				lspd_dstatus[6] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.615356, -1646.455932, 897.367919)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[7] == 0) {
				SetDynamicObjectRot(lspd_doors[7], 0.0000, 0.0000, 181.3910);
				lspd_dstatus[7] = 1;
			}
			else if(lspd_dstatus[7] == 1) {
				SetDynamicObjectRot(lspd_doors[7], 0.0000, 0.0000, 270.0000);
				lspd_dstatus[7] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1178.615356, -1646.455932, 897.367919)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[8] == 0) {
				SetDynamicObjectRot(lspd_doors[8], 0.0000, 0.0000, 6.7015);
				lspd_dstatus[8] = 1;
			}
			else if(lspd_dstatus[8] == 1) {
				SetDynamicObjectRot(lspd_doors[8], 0.0000, 0.0000, 90.0000);
				lspd_dstatus[8] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1192.5974, -1640.8801, 893.0573)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[9] == 0) {
				MoveDynamicObject(lspd_doors[9],-1194.1974, -1640.8801, 893.0573, 3);
				lspd_dstatus[9] = 1;
			}
			else if(lspd_dstatus[9] == 1) {
				MoveDynamicObject(lspd_doors[9],-1192.8374, -1640.8801, 893.0573, 3);
				lspd_dstatus[9] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1189.4073, -1640.8801, 893.0573)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[10] == 0) {
				MoveDynamicObject(lspd_doors[10],-1190.9873, -1640.8801, 893.0573, 3);
				lspd_dstatus[10] = 1;
			}
			else if(lspd_dstatus[10] == 1) {
				MoveDynamicObject(lspd_doors[10],-1189.4073, -1640.8801, 893.0573, 3);
				lspd_dstatus[10] = 0;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.5, -1186.1971, -1640.8801, 893.0573)) {
			if(!IsACop(playerid) && !IsASD(playerid)) return true;
			if(lspd_dstatus[11] == 0) {
				MoveDynamicObject(lspd_doors[11],-1187.7971, -1640.8801, 893.0573, 3);
				lspd_dstatus[11] = 1;
			}
			else if(lspd_dstatus[11] == 1) {
				MoveDynamicObject(lspd_doors[11],-1186.1971, -1640.8801, 893.0573, 3);
				lspd_dstatus[11] = 0;
			}
		}
	}
	if(newkeys & KEY_CROUCH)
	{
		if(IsACop(playerid) || IsFDMember(playerid) || IsAGov(playerid) || IsADoC(playerid))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return 1;

			if(!IsInStateVehicle(playerid))
				return 1;

			if(!Bit1_Get(Blinking, playerid))
				Bit1_Set(Blinking, playerid, true);

			else if(Bit1_Get(Blinking, playerid))
			{
				Bit1_Set(Blinking, playerid, false);
				new panels, doors, lights, tires;
				new carid = GetPlayerVehicleID(playerid);
				GetVehicleDamageStatus(carid, panels, doors, lights, tires);
				lights = encode_lights(0, 0, 0, 0);
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			}
		}
	}
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	if(IsACop(playerid) || IsFDMember(playerid) || IsAGov(playerid) || IsADoC(playerid))
	{
		if(newstate)
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return 1;

			if(!IsInStateVehicle(playerid))
				return 1;

			if(!Bit1_Get(Blinking, playerid))
				Bit1_Set(Blinking, playerid, true);
		}
		if(!newstate)
		{
			if(Bit1_Get(Blinking, playerid))
				Bit1_Set(Blinking, playerid, false);
			new panels, doors, lights, tires;
			GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
			UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_PD_BUYGUN: {
			if( !response ) return 1;
			if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete koristiti ovu funkciju ako ste level 1!");
			new tmpString[ 65 ];
            switch (listitem) {
                case 0: {
	     			if (! CheckPlayerWeapons(playerid, WEAPON_DEAGLE) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_DEAGLE);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_DEAGLE, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Desert Eagle iz lockera.");
					format(tmpString, sizeof(tmpString), "** %s je uzeo Desert Eagle iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
				case 1: {
					if (! CheckPlayerWeapons(playerid, WEAPON_SHOTGUN) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_SHOTGUN);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Shotgun iz lockera.");
					format(tmpString, sizeof(tmpString), "** %s je uzeo Shotgun iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
                case 2: {
					if (! CheckPlayerWeapons(playerid, WEAPON_MP5) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_MP5);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_MP5, 150);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste MP5 iz lockera.");
					format(tmpString, sizeof(tmpString), "** %s je uzeo MP5 iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 3: {
					if (! CheckPlayerWeapons(playerid, WEAPON_M4) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_M4);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_M4, 200);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste M4 iz lockera.");
					format(tmpString, sizeof(tmpString), "** %s je uzeo M4 iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 4: {
					if (! CheckPlayerWeapons(playerid, WEAPON_SNIPER) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_SNIPER);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_SNIPER, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Sniper Rifle iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Sniper Rifle iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 5: {
					if (! CheckPlayerWeapons(playerid, WEAPON_KNIFE) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_KNIFE);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_KNIFE, 1);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Knife iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Knife iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 6: {
					if (! CheckPlayerWeapons(playerid, WEAPON_TEARGAS) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_TEARGAS);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_TEARGAS, 10);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Teargas iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Teargas iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 7: {
				    if (! CheckPlayerWeapons(playerid, WEAPON_COLT45) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_COLT45);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_COLT45, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Colt45 iz lockera..");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Colt45 iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 8: {
					if (! CheckPlayerWeapons(playerid, WEAPON_SILENCED) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_SILENCED);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_SILENCED, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Silenced iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Silenced iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 9: {
					if (! CheckPlayerWeapons(playerid, WEAPON_SPRAYCAN) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_SPRAYCAN);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 1000);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Spraycan iz lockera..");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Spraycan iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				case 10: {
					if (! CheckPlayerWeapons(playerid, WEAPON_NITESTICK) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_NITESTICK);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_NITESTICK, 1);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Nitestick iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Nitestick iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                }
				case 11: {
					if (! CheckPlayerWeapons(playerid, 25) ) return 1;
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, 25, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Bean bag shotgun iz Armoury-a.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Bean bag shotgun iz Armoury-a.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					Bit1_Set(gr_BeanBagShotgun, playerid, true);
				}
				case 12: {
					if (! CheckPlayerWeapons(playerid, WEAPON_RIFLE) ) return 1;
					AC_ResetPlayerWeapon(playerid, WEAPON_RIFLE);
					Bit1_Set( gr_PlayerACSafe, playerid, true );
					AC_GivePlayerWeapon(playerid, WEAPON_RIFLE, 50);
					SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uzeli ste Rifle iz lockera.");
					format(tmpString, sizeof(tmpString), "* %s je uzeo Rifle iz lockera.", GetName(playerid, true));
					ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}

            }
			return 1;
		}
		case DIALOG_PENALCODE: {
			if( !response ) return 1;
			switch( listitem ) {
				case 0: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}1. Ubojstva");
					SendClientMessage(playerid, COLOR_WHITE, "1.1 - Pokusaj ubojstva - 6,5 sati");
					SendClientMessage(playerid, COLOR_WHITE, "1.2 - Ubojstvo - 8 sati");
					SendClientMessage(playerid, COLOR_WHITE, "1.3 - Maliciozno ubojstvo - 8,5 sati");
				}
				case 1: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}2. Fizicki i verbalni kontakti");
					SendClientMessage(playerid, COLOR_WHITE, "2.1 - Prijetnje - 30 minuta");
					SendClientMessage(playerid, COLOR_WHITE, "2.2 - Nezakonita upotreba sile - 1 sat");
					SendClientMessage(playerid, COLOR_WHITE, "2.3 - Tezi oblik nezakonite upotrebe sile - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "2.4 - Napad oruzjem - 3 sata");
				}
				case 2: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}3. Tortura i otmice");
					SendClientMessage(playerid, COLOR_WHITE, "3.1 - Otmica - 4,5 sata");
					SendClientMessage(playerid, COLOR_WHITE, "3.2 - Tortura - 7 sati");
				}
				case 3: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}4. Krada imovine ( novca i drugih predmeta )");
					SendClientMessage(playerid, COLOR_WHITE, "4.1 - Krada do 3000$ - 30 minuta + 3000$");
					SendClientMessage(playerid, COLOR_WHITE, "4.2 - Krada imovine do 10 000$ - 30 minuta + 5 000$");
					SendClientMessage(playerid, COLOR_WHITE, "4.3 - Krada imovine od 10 000$ - 100 000$ - 3,5 sati zatvora + 20 000$");
					SendClientMessage(playerid, COLOR_WHITE, "4.4 - Krada imovine preko 100 000$ - 4,5 sati zatvora + 40 000$");
				}
				case 4: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}5. Ostali tipovi krade");
					SendClientMessage(playerid, COLOR_WHITE, "5.1 - Krada automobila ( kolicinski manje ) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "5.2 - Krada automobila ( kolicinski vise ) - 4,5 sati");
					SendClientMessage(playerid, COLOR_WHITE, "5.3 - Krada oruzja ( manje ) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "5.4 - Krada oruzja ( vise ) - 6 sati");
				}
				case 5: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}6. Unistavanje imovine i posjedi");
					SendClientMessage(playerid, COLOR_WHITE, "6.1 - Vandalizam - 30 minuta");
					SendClientMessage(playerid, COLOR_WHITE, "6.2 - Palez - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "6.3 - Ulazak u zabranjeno podrucje - 30 min");
				}
				case 6: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}7. Reketiranje i iznude");
					SendClientMessage(playerid, COLOR_WHITE, "7.1 - Iznuda - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "7.2 - Prevara - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "7.3 - Reketiranje - 7 sati");
					SendClientMessage(playerid, COLOR_WHITE, "7.4 - Pranje novca - 9 sati");
				}
				case 7: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}8. Uznemiravanje u javnosti");
					SendClientMessage(playerid, COLOR_WHITE, "8.1 - Isticanje stidnih mjesta i razuzdano ponasanje - 15 min$");
					SendClientMessage(playerid, COLOR_WHITE, "8.2 - Voajerstvo - 30 min");
					SendClientMessage(playerid, COLOR_WHITE, "8.3 - Prostitucija - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "8.4 - Svodnistvo - 6 sati");
				}
				case 8: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}9. Sexualno uznemiravanje i ostalo");
					SendClientMessage(playerid, COLOR_WHITE, "9.1 - Silovanje - 9 sati");
					SendClientMessage(playerid, COLOR_WHITE, "9.2 - Sexualno nanosenje tjelesnih ozljeda - 9 sati");
					SendClientMessage(playerid, COLOR_WHITE, "9.3 - Vigilantizam - 6 sati");

				}
				case 9: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}10. Mito, krijumcarenje i ne placanje kazne");
					SendClientMessage(playerid, COLOR_WHITE, "10.1 - Mito - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "10.2 - Krijumcarenje ( blazi oblik ) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "10.3 - Krijumcarenje ( tezi oblik ) - 9 sati");
					SendClientMessage(playerid, COLOR_WHITE, "10.4 - Ne placanje kazne - 1 sat");
				}
				case 10: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}11. Podmicivanje i podvodenje");
					SendClientMessage(playerid, COLOR_WHITE, "11.1 - Podmicivanje sluzbenog lica - 3 sata + 10 000$");
					SendClientMessage(playerid, COLOR_WHITE, "11.2 - Podmicivanje osoba iz drzavnih ureda - 3 sata + 20 000$");
					SendClientMessage(playerid, COLOR_WHITE, "11.3 - Podvodenje biraca - 6 sati + 100 000$");

				}
				case 11: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}12. Kriminal protiv javnoga reda i mira");
					SendClientMessage(playerid, COLOR_WHITE, "12.1 - Stvaranje nemira - 30 min");
					SendClientMessage(playerid, COLOR_WHITE, "12.2 - Poticanje na pobunu - 1 sat");
					SendClientMessage(playerid, COLOR_WHITE, "12.3 - Nezakoniti prosvjedi - 3 sata");
				}
				case 12: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}13. Kriminal protiv javne sigurnosti");
					SendClientMessage(playerid, COLOR_WHITE, "13.1 - Nezakonito prodavanje na ulici - 30 min");
					SendClientMessage(playerid, COLOR_WHITE, "13.2 - Koristenje pica u voznji - 15 min");
					SendClientMessage(playerid, COLOR_WHITE, "13.3 - Lijecenje bez license - 3 sata");
				}
				case 13: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}14. Krsenja pravila voznje motornim vozilima");
					SendClientMessage(playerid, COLOR_WHITE, "14.1 - Voznja bez dozvole - 30 min");
					SendClientMessage(playerid, COLOR_WHITE, "14.2 - Bijeg od policije - 1 sat");
					SendClientMessage(playerid, COLOR_WHITE, "14.3 - Bijeg nakon udesa(laksi oblik) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "14.4 - Bijeg nakon udesa (tezi oblik) - 4,5 sati");
					SendClientMessage(playerid, COLOR_WHITE, "14.5 - Pucanje iz automobila - 6 sati");
				}
				case 14: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}15. Kriminal oruzjem");
					SendClientMessage(playerid, COLOR_WHITE, "15.1 - Proizvodnja oruzja - 6 sati");
					SendClientMessage(playerid, COLOR_WHITE, "15.2 - Posjedovanje oruzja ( lakse oruzje ) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "15.3 - Posjedovanje oruzja ( automatske puske ) - 6 sati");
					SendClientMessage(playerid, COLOR_WHITE, "15.4 - Posjedovanje oruzja ( exploziv ) - 9 sati");
					SendClientMessage(playerid, COLOR_WHITE, "15.5 - Prodaja oruzja - 9 sati");
				}
				case 15: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}16. Prometni zakon");
					SendClientMessage(playerid, COLOR_WHITE, "16.1 - Maximalna brzina - 15 minuta");
					SendClientMessage(playerid, COLOR_WHITE, "16.2 - Nesigurna voznja - 10 000$");
					SendClientMessage(playerid, COLOR_WHITE, "16.3 - Voznja u alkoholiziranom stanju - 30 min");
					SendClientMessage(playerid, COLOR_WHITE, "16.4 - Posjedovanje NOSa - 3 sata + 10000$");
					SendClientMessage(playerid, COLOR_WHITE, "16.5 - Voznja u neregistriranome vozilu - 10 000$");
				}
				case 16: {
					SendClientMessage(playerid, 0x6F83FFFF, "[PC] Klasa: {FFA05B}17. Prodaja, preprodaja i koristenje opojnih sredstava ");
					SendClientMessage(playerid, COLOR_WHITE, "17.1 - Koristenje opojnih sredstava - 1 sat");
					SendClientMessage(playerid, COLOR_WHITE, "17.2 - Prodaja opojnih sredstava ( lakse droge ) - 3 sata");
					SendClientMessage(playerid, COLOR_WHITE, "17.3 - Prodaja opojnih sredstava ( teze droge ) - 6 sati");
				}
			}
			return 1;
		}
		case DIALOG_CODES: {
			if( !response ) return 1;
			switch( listitem ) {
				case 0: {
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - 10 Codes.", "\n{3C95C2}[10-1] Sastanak na lokaciji  / Rollcall.\n\
						{3C95C2}[10-3] Prekinite pricati na radio.\n\
						{3C95C2}[10-4] Razumeo.\n\
						{3C95C2}[10-6] Zanemarite poslednju transmisiju.\n\
						{3C95C2}[10-8] Slobodan za pozive / clear from.\n\
						{3C95C2}[10-9] Nedostupan za pozive.\n\
						{3C95C2}[10-20] Lokacija.\n\
						{3C95C2}[10-55] Zaustavljeno vozilo na [lokacija] zbog kontrole.\n\
						{3C95C2}[10-57] VICTOR -  Osumnjiceni bezi u vozilu.\n\
						{3C95C2}[10-58] FOXTROT -  Osumnjiceni bezi peske.\n\
						{3C95C2}[10-66] Felony Stop.\n\
						{3C95C2}[10-70] Potrebno pojacanje.\n\
						{3C95C2}[10-99] Situacija zavrsena.",
						"Close", ""
					);

				}
				case 1: {
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Response Codes.", "\n{3C95C2}[Code 0] Hitno potrebna asistencija, ostavite sve sto radite i odazovite se.\n\
						{3C95C2}[Code 1] Odazovite se na radio.\n\
						{3C95C2}[Code 2] Odazivanje na poziv bez upaljene sirene i rotacij.\n\
						{3C95C2}[Code 2A] Potreban additional unit (dodatna jedinica).\n\
						{3C95C2}[Code 3] Odazivanje na poziv sa upaljenom sirenom i rotacijom.\n\
						{3C95C2}[Code 4] Nepotrebna asistencija.\n\
						{3C95C2}[Code 5] Svi officeri neka napuste odredjenu lokaciju.\n\
						{3C95C2}[Code 6] Stigao na scenu.\n\
						{3C95C2}[Code 7] Na pauzi.\n\
						{3C95C2}[Code 37]  Ukradeno vozilo.\n\
						{3C95C2}[Code 77] Oprez na mogucu zasedu.",
						"Close", ""
					);
				}
				case 2: {
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Identity Codes.", "\n{3C95C2}[IC 1] Belac.\n\
						{3C95C2}[IC 2] Crnac.\n\
						{3C95C2}[IC 3] Meksikanac/Latino.\n\
						{3C95C2}[IC 4] Azijat/Asian.\n\
						{3C95C2}[IC 5] Nepoznat/Unknown.",
						"Close", ""
					);
				}
				case 3: {
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{3C95C2}LSPD - Terminology / Shortcuts.", "\n{3C95C2}[Start of Watch] Pocetak smene (Primer: Police Officer 100  Start of Watch under 2-LINCOL-10).\n\
						{3C95C2}[End of Watch] Zavrsetak smene (Primer: Police Officer 100 End of Watch from 2-LINCOL-10).\n\
						{3C95C2}[Mayday] Pad helikoptera.\n\
						{3C95C2}[DOA] Dead on Arrival.\n\
						{3C95C2}[MVA] Motor Vehicle Accident.\n\
						{3C95C2}[DUI] Driver Under Influence.\n\
						{3C95C2}[UI] Under Influence.\n\
						{3C95C2}[Sitrep] Opis situacije / Pretezno koriste supervisory kada se povezu na radio komunikaciju.\n\
						{3C95C2}[TTCF] Twin Towers Correctional Facility.\n\
						{3C95C2}[BT] Bomb Threat.\n\
						{3C95C2}[AC] Aircraft Crash.",
						"Close", ""
					);
				}
			}
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

CMD:beanbag(playerid, params[]) {
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni");
	if(AC_GetPlayerWeapon(playerid) != 25)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "[ERROR]: Kako bi uzeli gumene metke morate imati shotgun.");
	if(Bit1_Get(gr_BeanBagShotgun, playerid) == 0) {
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Prebacili ste na gumene metke! Ukucajte komandu opet da vratite na regularne.");
		Bit1_Set(gr_BeanBagShotgun, playerid, true);
	} else {
		if(Bit1_Get(gr_BeanBagShotgun, playerid) == 1) {
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Prebacili ste na regularne metke! Ukucajte komandu opet da vratite na gumene metke.");
			Bit1_Set(gr_BeanBagShotgun, playerid, false);
		}
	}
	return (true);
}
/*
CMD:setchannel(playerid, params[]) {
	new pdchannel_id, fdchannel_id;
	if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || IsAGov(playerid))
	{
	    if(IsACop(playerid))
		{
            if(sscanf(params, "d", pdchannel_id))
			{
				SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setchannel [channel_id].");
				SendClientMessage(playerid, COLOR_GREY,"[CH 1] LSPD DISP.");
				SendClientMessage(playerid, COLOR_GREY,"[CH 2] L-TAC 1.");
				SendClientMessage(playerid, COLOR_GREY,"[CH 3] L-TAC 2.");
				SendClientMessage(playerid, COLOR_GREY,"[CH 4] L-TAC 3.");
				SendClientMessage(playerid, COLOR_GREY,"[CH 5] METRO.");
				SendClientMessage(playerid, COLOR_GREY,"[CH 6] DD.");
				return (true);
			}

			if(pdchannel_id < 1 || pdchannel_id > 6)
				return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 1 ili veca od 6!");

			if(pdchannel_id == SetPDChannel_ID[playerid])
				return SendErrorMessage(playerid, "Vec se nalazite u tom kanalu.");
	        SetPDChannel_ID[playerid] = pdchannel_id;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste se spojili na channel: %s.", GetPDChannelName(pdchannel_id));
		}
        if(IsFDMember(playerid))
		{
		    if(sscanf(params, "d", fdchannel_id))
			{
				SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setchannel [channel_id].");
				SendClientMessage(playerid, COLOR_GREY,"[CH 1] Fire Department");
				SendClientMessage(playerid, COLOR_GREY,"[CH 2] Medic Department");
				SendClientMessage(playerid, COLOR_GREY,"[CH 3] Air Divison");
				SendClientMessage(playerid, COLOR_GREY,"[CH 4] Hazmat Division");
				return (true);
			}

			if(fdchannel_id < 1 || fdchannel_id > 4)
				return SendErrorMessage(playerid, "Vrijednost ne moze biti manja od 1 ili veca od 4!");

			if(fdchannel_id == SetFDChannel_ID[playerid])
				return SendErrorMessage(playerid, "Vec se nalazite u tom kanalu.");

			SetFDChannel_ID[playerid] = fdchannel_id;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste se spojili na channel: %s.", GetFDChannelName(fdchannel_id));
		}
	}
	return 1;
}

CMD:ch(playerid, params[]) {
	new string[256], message[128];
	if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid) || IsAGov(playerid))
	{
	    if(IsACop(playerid))
		{
            if(SetPDChannel_ID[playerid] == 0)
			return SendErrorMessage(playerid, "Prvo se morate spojiti na neki od kanala (/setchannel).");

			if(sscanf(params, "s[128]", message)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ch [message].");
			return (true);
			}

			format(string, sizeof(string), "**[CH: %s] %s: %s", GetPDChannelName(SetPDChannel_ID[playerid]), GetName(playerid, true), message);
			SendPDChannelMessage(0xB5AF8FFF, string, SetPDChannel_ID[playerid]);
		}

        else if(IsFDMember(playerid))
		{
		    if(SetFDChannel_ID[playerid] == 0)
			return SendErrorMessage(playerid, "Prvo se morate spojiti na neki od kanala (/setchannel).");

			if(sscanf(params, "s[128]", message)) {
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ch [message].");
			return (true);
			}

			format(string, sizeof(string), "**[CH: %s] %s: %s", GetFDChannelName(SetFDChannel_ID[playerid]), GetName(playerid, true), message);
			SendFDChannelMessage(0xB5AF8FFF, string, SetFDChannel_ID[playerid]);
		}
	} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/LSFD.");
	return 1;
}
*/

CMD:tazer(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne smijete koristiti ovu funkciju ako ste level 1!");
	new weapon, bullets;
    if(IsACop(playerid) || IsASD(playerid)) {
        if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu u autu.");
        if(Bit1_Get(gr_Taser, playerid) == 0) {
        	GetPlayerWeaponData(playerid, 2, weapon, bullets);
			Bit8_Set( gr_PoliceWeapon, 	playerid, weapon );
			Bit16_Set( gr_PoliceAmmo, 	playerid, bullets );
			AC_ResetPlayerWeapon(playerid, AC_GetPlayerWeapon(playerid));

			new
				tazerString[ 51 ];
            format(tazerString, sizeof(tazerString), "* %s uzima tazer sa pojasa.", GetName(playerid, true));
	   		ProxDetector(15.0, playerid, tazerString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            Bit1_Set(gr_Taser, playerid, true);
            AC_GivePlayerWeapon(playerid, 23, 5);
        } else {
			if(Bit1_Get(gr_Taser, playerid) == 1) {
				AC_ResetPlayerWeapon(playerid, AC_GetPlayerWeapon(playerid));
				if( Bit8_Get( gr_PoliceWeapon, 	playerid ) )
					AC_GivePlayerWeapon(playerid, Bit8_Get( gr_PoliceWeapon, playerid ), Bit16_Get( gr_PoliceAmmo, 	playerid ));

				Bit1_Set(gr_Taser, playerid, false);
			}
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate tazer u ruci (( Morate imati Silenced pistol u ruci to jest Tazer ))!");
        }
    }
    return 1;
}
CMD:arrest(playerid, params[])
{
	new giveplayerid, moneys, jailtime, reason[24], string[128];
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/USMS.");
	if(!IsAtArrest(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za uhicenje!");
	if(sscanf(params, "uiis[24]", giveplayerid, moneys, jailtime, reason)){
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /arrest [playerid][cijena][minute][razlog]");
		return 1;
	}
	if(!IsPlayerConnected(giveplayerid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uneseni igrac nije online!");
	if(moneys < 1 || moneys > 100000) 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Cijena zatvora nemoze biti manja od $1 i veca od $5000!");
	if(jailtime < 1 || jailtime > 1000) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Minute pritvora nemogu biti manje od 1 i vece od 1000!");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas!");
	//if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi uhitit!");

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Uhitili ste %s !", GetName(giveplayerid));
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Odvedite zatvorenika u celiju!");

	format(string, sizeof(string), "* [HQ] %s %s je uhitio %s. Razlog: %s; Kazna: %d$. ", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid), reason, moneys);

	if(IsACop(playerid))
		SendRadioMessage(1, COLOR_COP, string);
	else if(IsASD(playerid))
		SendRadioMessage(3, COLOR_COP, string);

	va_GameTextForPlayer(giveplayerid, "Uhitio vas je %s ~n~ za $%d", 5000, 5, GetName(playerid), moneys);
	SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Nakon sto ste uhiceni, ostali ste bez dozvole za oruzje!");

	AC_ResetPlayerWeapons(giveplayerid);
	PlayerInfo[giveplayerid][pGunLic] 		= 0; // ukidanje dozvole za oruzje
	PlayerInfo[giveplayerid][pArrested] 	+= 1; // Dodavanje arrest rekorda +1

	if(IsPlayerInRangeOfPoint(playerid, 10.0, 1940.9509, 809.7464, -46.6122))
		PutPlayerInJail(giveplayerid, jailtime, 1);
	else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1192.9391,1327.4951,-54.7172))
		PutPlayerInJail(giveplayerid, jailtime, 3);
	
	if(IsACop(playerid))
	    PlayerToOrgMoney(giveplayerid, FACTION_TYPE_LAW, moneys);
	else if(IsASD(playerid))
	    PlayerToOrgMoney(giveplayerid, FACTION_TYPE_LAW2, moneys);
	    
	InsertPlayerMDCCrime(playerid, giveplayerid, reason, jailtime); // spremanje u tablicu dosjee
	return 1;
}
CMD:editarrest(playerid, params[])
{
	new giveplayerid, pick, ammount;
	if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi Policajac.");
	if(!IsAtArrest(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za uhicenje!");
	if(sscanf(params, "iii", giveplayerid, pick, ammount)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /editarrest [pick] [ammount] ");
		SendClientMessage(playerid, -1, "Izbor: 1 - vrijeme | 2 - sektor");
		return 1;
	}
	if(!IsPlayerConnected(giveplayerid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Uneseni igrac nije online!");
	if(pick < 1 || pick > 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pogresan izbor.");
	if(PlayerInfo[giveplayerid][pJailed] != 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije u zatvoru.");
	switch(pick)
	{
		case 1:
		{
			PlayerInfo[giveplayerid][pJailTime] = ammount;
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste vrijeme u zatvoru igracu %s na %i", GetName(giveplayerid), ammount);
		}
		case 2:
		{
			if(ammount != 1 && ammount != 2 && ammount != 3) return SendClientMessage(playerid, -1, "SEKTOR: A | B | C");
			PutPlayerInSector(giveplayerid);
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Promjenili ste sektor u zatvoru igracu %s na %i", GetName(giveplayerid), ammount);
		}
	}
	return 1;
}
CMD:unfree(playerid, params[])
{
    if(!IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD!");

	if(PlayerInfo[playerid][pRank] < FactionInfo[PlayerInfo[playerid][pMember]][rUnFree])
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rank %d kako bi ste mogli koristiti ovu komandu!", FactionInfo[PlayerInfo[playerid][pMember]][rUnFree]);

	new giveplayerid, string[128];
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unfree [playerid/dio imena]");
    if(IsPlayerConnected(giveplayerid))
	{
        if(giveplayerid != INVALID_PLAYER_ID)
		{
            if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozete sami sebe oslobodit!");
			if(PlayerInfo[giveplayerid][pJailed] == 1)
			{
				format(string, sizeof(string), "* Oslobodili ste %s iz zatvora.", GetName(giveplayerid));
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oslobodjeni ste, oslobodio vas je %s %s.", ReturnPlayerRankName(playerid), GetName(playerid));
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				PlayerInfo[giveplayerid][pBailPrice] = 0;
				PlayerInfo[giveplayerid][pJailed] = 0;
				PlayerInfo[giveplayerid][pJailTime] = 1;
				SetPlayerColor(giveplayerid,TEAM_HIT_COLOR);
			}
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije zatvoren ili je u AREI!");
		}
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac je offline!");
	return 1;
}
CMD:cuff(playerid, params[])
{
	if(IsACop(playerid) || IsASD(playerid) || (IsAGov(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		new giveplayerid;
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /cuff [playerid/dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
		//if( Bit1_Get( gr_PlayerCuffed, giveplayerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Osoba vec ima lisice!");
		if (ProxDetectorS(2.5, playerid, giveplayerid)  && !IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(giveplayerid)) {
			if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes sam sebi stavit lisice!");

			va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] %s vam je stavio lisice.", GetName(playerid, true));
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Stavio si lisice %s.", GetName(giveplayerid, true));

			new
				cuffString[83];
			format(cuffString, sizeof(cuffString), "* %s stavlja lisice na %s, tako da mu nebi pobjegao.", GetName(playerid, true) ,GetName(giveplayerid, true));
			ProxDetector(30.0, playerid, cuffString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			GameTextForPlayer(giveplayerid, "~r~Uhapsen", 2500, 3);
			SetPlayerSpecialAction(giveplayerid,SPECIAL_ACTION_CUFFED);
			SetPlayerAttachedObject(giveplayerid, 7, 19418, 6, -0.027999, 0.051999, -0.030000, -18.699926, 0.000000, 104.199928, 1.489999, 3.036000, 1.957999);
			Bit1_Set( gr_PlayerCuffed, giveplayerid, true );
			TogglePlayerControllable(giveplayerid, 1);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas !");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi ovlasten!");
    return 1;
}
CMD:uncuff(playerid, params[])
{
	if(IsACop(playerid) || IsASD(playerid) || (IsAGov(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
	    new giveplayerid;
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /cuff [playerid/dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
		if (ProxDetectorS(5.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozes skiniti lisice sam sebi!");
			if( Bit1_Get( gr_PlayerCuffed, giveplayerid ) )
			{
				new cuffString[57];
				format(cuffString, sizeof(cuffString), "* Officer %s vam je skinuo lisice.", GetName(playerid));
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, cuffString);
				format(cuffString, sizeof(cuffString), "* Skinili ste lisice sa %s.", GetName(giveplayerid));
				SendClientMessage(playerid, COLOR_LIGHTBLUE, cuffString);
				GameTextForPlayer(giveplayerid, "~g~Slobodan", 2500, 3);
				SetPlayerSpecialAction(giveplayerid,0);
				Bit1_Set( gr_PlayerCuffed, giveplayerid, false );
				if(IsPlayerAttachedObjectSlotUsed(giveplayerid, 7)) RemovePlayerAttachedObject(giveplayerid, 7);
				SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
			}
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije zavezan !");
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi LSPD");
	return 1;
}

CMD:pdtrunk(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	new vehicleid = INVALID_VEHICLE_ID,
		Float:PosX, Float:PosY, Float:PosZ;

	foreach(new i : Vehicles) {
		GetVehiclePos( i, PosX, PosY, PosZ );
		if( IsPlayerInRangeOfPoint( playerid, 5.0, PosX, PosY, PosZ )) {
			vehicleid = i;
			break;
		}
	}
	if(vehicleid == INVALID_VEHICLE_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila!");

	if(IsVehicleWithoutTrunk(GetVehicleModel(vehicleid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema prtljaznik!");

	new
		engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF) {
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
		VehicleInfo[vehicleid][vTrunk] = VEHICLE_PARAMS_ON;
		GameTextForPlayer(playerid, "~w~gepek otvoren", 1000, 5);
	}
	else if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_ON) {
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_OFF, objective);
		VehicleInfo[vehicleid][vTrunk] = VEHICLE_PARAMS_OFF;
		GameTextForPlayer(playerid, "~w~gepek zatvoren", 1000, 5);
	}
    return 1;
}

CMD:pdramp(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 20, 1544.7363,-1627.0232,13.3672)) return SendClientMessage(playerid, COLOR_RED,"Niste u blizini rampe!");
	if(PlayerInfo[playerid][pLeader] != 1 && PlayerInfo[playerid][pMember] != 1) return SendClientMessage(playerid, COLOR_RED,"Niste clan LS-PDa.");
 	if(!rampstatus)
  	{
   		rampstatus = 1;
   		MoveDynamicObject(ramp, 1544.6943359375, -1630.73046875, 13.27956199646+0.0001, 0.0002, 0, 0, 90);
   		SendClientMessage(playerid, COLOR_RED, "[ ! ] Indetitet potvrdjen! Rampa se otvara...");
   	}
    else
    {
    	rampstatus = 0;
    	MoveDynamicObject(ramp, 1544.6943359375, -1630.73046875, 13.27956199646-0.0001, 0.0003, 0, 90, 90);
    	SendClientMessage(playerid, COLOR_RED, "[ ! ] Indetitet potvrdjen! Rampa se zatvara...");
    }
	return 1;
}

CMD:law(playerid, params[]) {
	new pd_counter, sd_counter, fd_counter, gov_counter;
	va_SendClientMessage(playerid, COLOR_WHITE, "{3C95C2}Law Enforcement On Duty:");
	foreach(new i: Player) {
		if(IsFDMember(i)) {
			fd_counter++;
		}
		if(IsASD(i)) {
			sd_counter++;
		}
		if(IsACop(i)) {
			pd_counter++;
		}
		if(IsAGov(i)) {
			gov_counter++;
		}
	}
	va_SendClientMessage(playerid, COLOR_WHITE, "Police: %d; Sheriffs: %d; Fire Department: %d; Government: %d;", pd_counter, sd_counter, fd_counter, gov_counter);
	return (true);
}

/*CMD:lawskin(playerid, params[]) {
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste LSPD/SASD!");
	if( !IsPlayerInRangeOfPoint(playerid,5.0,1292.9618,1097.7413,-18.9368) && !IsPlayerInRangeOfPoint(playerid,5.0,2032.1844,2206.1392,-31.4410) && !IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar LSPD/SASD armorya da bi ste mogli koristiti ovu komandu.");

	ShowModelESelectionMenu(playerid, "Police Skins", MODEL_SELECTION_LAWSKIN, lawskins_police, sizeof(lawskins_police), 0.0, 0.0, 0.0, 1.0, -1, true, lawskins_police);
	return (true);
}*/
/*
CMD:govskin(playerid, params[]) {
	if(!IsAGov(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste clan Los Santos Govermenta!");
	if( !IsPlayerInRangeOfPoint(playerid,5.0,1315.3967,758.2388,-93.1678) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste kod mjesta za presvlacenje.");

	ShowModelESelectionMenu(playerid, "Police Skins", MODEL_SELECTION_GOVSKIN, govskins_gov, sizeof(govskins_gov), 0.0, 0.0, 0.0, 1.0, -1, true, govskins_gov);
	return 1;
}*/

CMD:govrepair(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(VehicleInfo[vehicleid][vFaction] != 1 && VehicleInfo[vehicleid][vFaction] != 2 && VehicleInfo[vehicleid][vFaction] != 3 && VehicleInfo[vehicleid][vFaction] != 4 && VehicleInfo[vehicleid][vFaction] != 5) return SendClientMessage(playerid,COLOR_RED, "Mozes popravljati samo vozila organizacije!");
    if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
	new fid =  PlayerInfo[playerid][pMember];
	if( fid != 4 ) {
		if(FactionInfo[fid][fFactionBank] < 100) return SendClientMessage(playerid,COLOR_RED, "Vasa organizacija nema novaca!");
		if(IsACop(playerid))
		{
			if(PlayerInfo[playerid][pMember] == 1) 
			{
				if(IsPlayerInRangeOfPoint(playerid, 5.0, 1570.4080,-1632.6095,13.3828) || IsPlayerInRangeOfPoint(playerid, 10.0, 755.9906,-1431.2805,13.5234) || IsPlayerInRangeOfPoint(playerid, 10.0, 1136.7454,2286.2957,10.8203) || IsPlayerInRangeOfPoint(playerid, 10.0, 2055.0149,-2150.2551,26.1129)) 
				{
					AC_RepairVehicle(vehicleid);
					AC_SetVehicleHealth(vehicleid, 1200.0);
					VehicleInfo[vehicleid][vFuel] = 100;
					VehicleInfo[ vehicleid ][ vCanStart ] = 1;
					VehicleInfo[ vehicleid ][ vDestroyed ] = false;
					Bit1_Set( gr_GovRepair, playerid, false );
					OrgToBudgetMoney( FACTION_TYPE_LAW, 100); // Novac ide iz factionbank u proraeun
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Vase vozilo je popravljeno i napunjeno gorivom.");
				}
				else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za popravak vozila!");
			}
		}
		else if(IsASD(playerid))
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 622.9983,-601.3151,16.0462)) {
				AC_RepairVehicle(vehicleid);
				AC_SetVehicleHealth(vehicleid, 1200.0);
				VehicleInfo[vehicleid][vFuel] = 100;
				VehicleInfo[ vehicleid ][ vCanStart ] = 1;
				VehicleInfo[ vehicleid ][ vDestroyed ] = false;
				Bit1_Set( gr_GovRepair, playerid, false );
				OrgToBudgetMoney( FACTION_TYPE_LAW2, 100); // Novac ide iz factionbank u proraeun
				SendClientMessage(playerid, COLOR_RED, "[ ! ] Vase vozilo je popravljeno i napunjeno gorivom.");
			}
			else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za popravak vozila!");
		}
 	 	else if(IsANews(playerid) )
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 292.1505,-1545.1261,24.5938)) // NEWS
			{
				AC_RepairVehicle(vehicleid);
				AC_SetVehicleHealth(vehicleid, 1000.0);
				VehicleInfo[vehicleid][vFuel] = 100;
				VehicleInfo[ vehicleid ][ vCanStart ] = 1;
				VehicleInfo[ vehicleid ][ vDestroyed ] = false;
				Bit1_Set( gr_GovRepair, playerid, false );
				OrgToBudgetMoney( FACTION_TYPE_NEWS, 100); // Novac ide iz factionbank u proraeun
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
			}
			else return SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste na mjestu za popravak vozila!");
		}
		else if( IsFDMember(playerid) )
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 1174.9698,-1309.0844,13.9958)) // LSFD
			{
				AC_RepairVehicle(vehicleid);
				AC_SetVehicleHealth(vehicleid, 1000.0);
				VehicleInfo[vehicleid][vFuel] = 100;
				VehicleInfo[ vehicleid ][ vCanStart ] = 1;
				VehicleInfo[ vehicleid ][ vDestroyed ] = false;
				Bit1_Set( gr_GovRepair, playerid, false );
				OrgToBudgetMoney( FACTION_TYPE_FD, 100); // Novac ide iz factionbank u proraeun
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
			}
			else return SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste na mjestu za popravak vozila!");
		}
	}
	else if( IsAGov(playerid) )
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 1471.5919,-1830.6121,13.5469)) // Mayor
		{
		    AC_RepairVehicle(vehicleid);
			if(VehicleInfo[vehicleid][vBodyArmor] == 1)	AC_SetVehicleHealth(vehicleid, 1600.0);
			else AC_SetVehicleHealth(vehicleid, 1000.0);
	        VehicleInfo[vehicleid][vFuel] = 100;
			VehicleInfo[ vehicleid ][ vCanStart ] = 1;
			VehicleInfo[ vehicleid ][ vDestroyed ] = false;
			Bit1_Set( gr_GovRepair, playerid, false );
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vase vozilo je popravljeno i napunjeno gorivom.");
    	}
		else return SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste na mjestu za popravak vozila!");
	}
	else SendClientMessage(playerid,COLOR_RED, "Nisi ovlasten za koristenje ove komande.");
	return 1;
}
CMD:codes(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");

    ShowPlayerDialog(playerid,DIALOG_CODES,DIALOG_STYLE_LIST,"Police Scanner Codes","{3C95C2}[1] - 10 Codes\n{3C95C2}[2] - Response Codes\n{3C95C2}[3] - Identity Codes\n{3C95C2}[4] - Terminology","Choose","Close");
  	return 1;
}

CMD:swat(playerid, params[])
{
	if(!IsACop(playerid) && !IsASD(playerid)) return SendClientMessage(playerid, COLOR_RED, "[ ! ] Niste LSPD.");
	if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Niste na duznosti!");
	if(PlayerInfo[playerid][pLevel] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Ne mozete koristiti ovu komandu dok ste level 1!");

	new
		swString[70];
		
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2877.2317,-843.6631,-21.6994) || IsPlayerInRangeOfPoint(playerid,5.0,2040.6858,1260.2460,-11.1115) || IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) || IsPlayerInRangeOfPoint(playerid,5.0,2032.1844,2206.1392,-31.4410) || IsPlayerInRangeOfPoint(playerid,5.0,-882.4293,288.5243,535.341) )
	{
		if( !Bit1_Get( gr_PlayerIsSWAT, playerid ) ) {
			SetPlayerSkin(playerid, 285);
			SetPlayerArmour(playerid, 150.0);
			SetPlayerHealth(playerid, 150.0);
			format(swString, sizeof(swString), "*[HQ] SWAT operativac %s je slobodan za pozive.", GetName(playerid,false));
			SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, swString);
			Bit1_Set( gr_PlayerIsSWAT, playerid, true );
		}
		else {
			Bit1_Set( gr_PlayerIsSWAT, playerid, false );
			SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]);
			new Float:armour;
			GetPlayerArmour(playerid, armour);
			if(armour >= 99.0) SetPlayerArmour(playerid, 99.0);
			format(swString, sizeof(swString), "*[HQ] SWAT operativac %s je sada van duznosti.", GetName(playerid,false));
			SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, swString);
		}
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi na mjestu za uzimanje SWAT opreme");
	return 1;
}

CMD:suspend(playerid, params[])
{
	new giveplayerid, string[128];
	if(( PlayerInfo[playerid][pLeader] == 1 || (PlayerInfo[playerid][pRank] >= 11 && PlayerInfo[playerid][pMember] == 1) ) || PlayerInfo[playerid][pLeader] == 5)
	{
	    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /suspend [playerid/dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
		PlayerInfo[giveplayerid][pRank] = 0;
		PlayerInfo[giveplayerid][pLawDuty] = 0;
		format( string, sizeof(string), "[ ! ] Suspendirali ste %s sa duZnosti!", GetName(giveplayerid));
		SendClientMessage(playerid, COLOR_RED, string);
		format( string, sizeof(string), "[ ! ] Suspendirani ste sa duZnosti! Command officer %s", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_RED, string);
 	}
 	else if( PlayerInfo[playerid][pLeader] == 4)
 	{
	    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /suspend [playerid/dio imena]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije na serveru.");
		PlayerInfo[giveplayerid][pRank] = 0;
		PlayerInfo[giveplayerid][pLawDuty] = 0;
		format( string, sizeof(string), "[ ! ] Suspendirali ste %s sa duZnosti!", GetName(giveplayerid));
		SendClientMessage(playerid, COLOR_RED, string);
		format( string, sizeof(string), "[ ! ] Suspendirani ste sa duZnosti! Mayor %s", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_RED, string);
 	}
 	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi dovoljan rank!");
	return 1;
}

CMD:lawdoors(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste clan LSPDa/USMSa!");
	if( GetPlayerState(playerid) != PLAYER_STATE_DRIVER ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste vozac!");
	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lawdoors [dio imena/playerid]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan unos igraca!");

	if( Bit1_Get( gr_DoorsLocked, giveplayerid ) ) // Zakljucana
	{
		new
			tmpString[ 62 ];
		format( tmpString, sizeof(tmpString), "* %s otkljucava zadnja vrata u vozilu.",
			GetName(playerid)
		);
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		Bit1_Set( gr_DoorsLocked, giveplayerid, false );
		Bit4_Set( gr_PDLockedSeat, giveplayerid, 0 );
		Bit16_Set( gr_PDLockedVeh, giveplayerid, INVALID_VEHICLE_ID );
	} else {	 // Otkljucana
		new
			tmpString[ 62 ];
		format( tmpString, sizeof(tmpString), "* %s zakljucava zadnja vrata u vozilu.",
			GetName(playerid)
		);
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		Bit1_Set( gr_DoorsLocked, giveplayerid, true );
		Bit4_Set( gr_PDLockedSeat, giveplayerid, GetPlayerVehicleSeat(giveplayerid) );
		Bit16_Set( gr_PDLockedVeh, giveplayerid, GetPlayerVehicleID(playerid) );
	}
	return 1;
}
CMD:flares(playerid, params[])
{
    if(IsACop(playerid) || IsASD(playerid) || PlayerInfo[playerid][pAdmin] >= 2 || IsFDMember(playerid))
	{
	    new Float:x, Float:y, Float:z, Float:Angle;
	    GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid,Angle);
	    CreateFlare(x, y, z, Angle);
	    GameTextForPlayer(playerid, "Bacio si baklju!", 1000, 1);
	}
	return 1;
}
CMD:dflares(playerid, params[])
{
    if(IsACop(playerid) || IsASD(playerid) || IsFDMember(playerid)) {
  		if(PlayerInfo[playerid][pRank] >= 2)
			DeleteClosestFlare(playerid);
	}
	return 1;
}
CMD:daflares(playerid, params[])
{
    if(IsACop(playerid)  || IsASD(playerid) || PlayerInfo[playerid][pAdmin] >= 2 || IsFDMember(playerid))
	{
		if(PlayerInfo[playerid][pRank] >= 1 || PlayerInfo[playerid][pAdmin] >= 2)
		    DeleteAllFlare();
	}
	return 1;
}
CMD:take(playerid, params[])
{
	new opcija[20], giveplayerid;
    if( !IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac !");
	if(PlayerInfo[playerid][pRank] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Moras biti rank 1 ili vise da bi koristio ovo !");
	if( sscanf( params, "us[20] ", giveplayerid, opcija ) )
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /take [playerid][opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] driverslicense - flyinglicense - boatlicense - weaponlicense - weapons - toolkit");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] weaponpackage - drugs");
		return 1;
	}
	if(strcmp(opcija,"driverslicense",true) == 0)
	{
		new dani, year, month, day;
		getdate(year, month, day);
		if( sscanf( params, "us[20]i ", giveplayerid, opcija, dani ) ) return SendClientMessage(playerid, COLOR_WHITE, "KORISTI: /take [ID] [izbor] [dani]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if ( !ProxDetectorS(5.0, playerid, giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
		new
		tmpString[ 120 ];

		format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo vozacku dozvolu %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|_____________________ Oduzeta vozacka dozvola ______________________|");
		format(tmpString, sizeof(tmpString), "* %s %s vam je oduzeo vozacku dozvolu na %d dana.", ReturnPlayerRankName(playerid), GetName(playerid), dani);
		SendClientMessage(giveplayerid, 0xCC0000FF, tmpString);
		format(tmpString, sizeof(tmpString), "* Danasnji datum: %d.%d.%d.", day, month, year);
		SendClientMessage(giveplayerid, 0xCC0000FF, tmpString);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|____________________________________________________________________|");

		PlayerInfo[giveplayerid][pCarLic] = 0;
	}
	else if(strcmp(opcija,"weaponpackage",true) == 0)
	{
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if( !ProxDetectorS(5.0, playerid, giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");

		new
			tmpString[ 71 ];
		format(tmpString, sizeof(tmpString), "[ ! ] Oduzeli ste %s sve weapon pakete.", GetName(giveplayerid));
		SendClientMessage(playerid, COLOR_RED, tmpString);
		format(tmpString, sizeof(tmpString), "* Policajac %s vam je oduzeo weapon pakete.", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);

		// reset packages
		foreach(new i : P_PACKAGES[giveplayerid])
		{
			if(PlayerPackage[giveplayerid][p_weapon][i] != 0)
				DeletePlayerPackage(giveplayerid, i);
		}
		Iter_Clear(P_PACKAGES[giveplayerid]);
	}
	else if(strcmp(opcija,"flyinglicense",true) == 0)
	{
		if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if( !ProxDetectorS(5.0, playerid, giveplayerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");

		new
			tmpString[ 120 ];
		format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo dozvolu za letenje %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

		format(tmpString, sizeof(tmpString), "* Policajac %s vam je oduzeo dozvolu za letenje.", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);
		PlayerInfo[giveplayerid][pFlyLic] = 0;
	}
	else if(strcmp(opcija,"toolkit",true) == 0)
	{
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(ProxDetectorS(5.0, playerid, giveplayerid)) {
			new
				tmpString[ 77 ];
			format(tmpString, sizeof(tmpString), "[ ! ] Oduzeli ste %s opremu za obijanje.", GetName(giveplayerid));
			SendClientMessage(playerid, COLOR_RED, tmpString);
			format(tmpString, sizeof(tmpString), "[ ! ] Policajac %s vam je oduzeo opremu za obijanje.", GetName(playerid));
			SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
			PlayerInfo[giveplayerid][pToolkit] = 0;
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}
	else if(strcmp(opcija,"weaponlicense",true) == 0)
	{
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Komanda je izbacena");
	    return 1;
	}
	/*
	else if(strcmp(opcija,"weaponlicense",true) == 0)
	{
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(ProxDetectorS(5.0, playerid, giveplayerid)) {
			new
				tmpString[ 120 ];
            format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeo dozvolu za oruzje %s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
			SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

			format(tmpString, sizeof(tmpString), "[ ! ] Policajac %s vam je oduzeo dozvolu za oruzje.", GetName(playerid));
			SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
			PlayerInfo[giveplayerid][pGunLic] = 0;
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}*/
	else if(strcmp(opcija,"boatlicense",true) == 0)
	{
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(ProxDetectorS(5.0, playerid, giveplayerid)) {
			new
				tmpString[ 120 ];
			format(tmpString, sizeof(tmpString), "*[HQ] %s %s je oduzeoeku dozvolu za brod%s.", ReturnPlayerRankName(playerid), GetName(playerid), GetName(giveplayerid));
			SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);

			format(tmpString, sizeof(tmpString), "[ ! ] Policajac %s vam je oduzeo dozvolu za brod.", GetName(playerid));
			SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
			PlayerInfo[giveplayerid][pBoatLic] = 0;
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}
	else if(strcmp(opcija,"weapons",true) == 0)
	{
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(ProxDetectorS(5.0, playerid, giveplayerid)) {

			new
				tmpString[ 65 ];
			format(tmpString, sizeof(tmpString), "[ ! ] Oduzeli ste %s oruzje.", GetName(giveplayerid));
			SendClientMessage(playerid, COLOR_GREEN, tmpString);
			format(tmpString, sizeof(tmpString), "[ ! ] Policajac %s vam je oduzeo oruzje.", GetName(playerid));
			SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
			AC_ResetPlayerWeapons(giveplayerid);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}
	else if(strcmp(opcija,"drugs",true) == 0)
	{
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(ProxDetectorS(5.0, playerid, giveplayerid)) 
		{
			new
				tmpString[ 65 ];
			format(tmpString, sizeof(tmpString), "[ ! ] Oduzeli ste %s drogu.", GetName(giveplayerid));
			SendClientMessage(playerid, COLOR_GREEN, tmpString);
			format(tmpString, sizeof(tmpString), "[ ! ] Policajac %s vam je oduzeo drogu.", GetName(playerid));
			SendClientMessage(giveplayerid, COLOR_ORANGE, tmpString);
			DeletePlayerDrug(giveplayerid, -1);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	}
	else SendClientMessage(playerid, COLOR_RED, " Nepoznato ime za oduzimanje !");
    return 1;
}

CMD:checktrunk(playerid, params[])
{
 	new vehicleid = INVALID_VEHICLE_ID;
	foreach(new i : Vehicles)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(i, X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z))
		{
			vehicleid = i;
			break;
		}
	}
	if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");
	if( IsANoTrunkVehicle( GetVehicleModel(vehicleid) ) ) 		return SendClientMessage(playerid, COLOR_RED, "Ovo vozilo nema prtljaznik!");
    if( GetPlayerState(playerid) != PLAYER_STATE_ONFOOT ) 		return SendClientMessage(playerid, COLOR_RED, "Morate biti na nogama da biste koristili ovu komandu.");
    if( VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF ) 	return SendClientMessage(playerid, COLOR_RED, "Prtljaznik je zatvoren.");
	if( !Iter_Contains(COVehicles, vehicleid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo mora biti CO da bi ga pretresli!");

	ShowPlayerDialog(playerid, DIALOG_VEH_CHECKTRUNK, DIALOG_STYLE_MSGBOX, "Oruzja u vozilu:", ListPlayerVehicleWeapons(playerid, vehicleid), "Exit", "");

	new
		tmpString[ 49 ];
	format(tmpString, sizeof(tmpString), "* %s gleda u prtljaznik.", GetName(playerid));
	ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return 1;
}

// Impound
CMD:impound(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Niste policajac!");
	new
		vehicleid = GetPlayerVehicleID(playerid);
	if( VehicleInfo[ vehicleid ][ vUsage ] != VEHICLE_USAGE_PRIVATE ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Mozete zaplijeniti samo osobna vozila!");
	new
		Float:X, Float:Y, Float:Z,
		Float:z_rot;
	GetVehiclePos(vehicleid, X, Y, Z);
	GetVehicleZAngle(vehicleid, z_rot);

	VehicleInfo[ vehicleid ][ vParkX ]		= X;
	VehicleInfo[ vehicleid ][ vParkY ]		= Y;
	VehicleInfo[ vehicleid ][ vParkZ ]		= Z;
	VehicleInfo[ vehicleid ][ vAngle ] 		= z_rot;
	VehicleInfo[ vehicleid ][ vImpounded ] 	= 1;

	new
		bigquery[ 512 ];
	format(bigquery, sizeof(bigquery), "UPDATE `cocars` SET `parkX` = '%f', `parkY` = '%f', `parkZ` = '%f', `angle` = '%f', `impounded` = '%d' WHERE `id` = '%d'",
		X,
		Y,
		Z,
		z_rot,
		VehicleInfo[vehicleid][vImpounded],
		VehicleInfo[vehicleid][vSQLID]
	);
	mysql_tquery(g_SQL, bigquery, "", "");

	new
		engine, lights, alarm, doors, bonnect, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnect, boot, objective);
	SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnect, boot, objective);

	new
		tmpString[ 120 ];
	format(tmpString, sizeof(tmpString), "*[HQ] %s %s je zaplijenio vozilo (ID: %d).", ReturnPlayerRankName(playerid), GetName(playerid), vehicleid);
	SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_COP, tmpString);
	RemovePlayerFromVehicle(playerid);
	return 1;
}

CMD:payimpound(playerid, params[])
{
	if( !IsPlayerInAnyVehicle(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar vozila!");
	new
		vehicleid = GetPlayerVehicleID(playerid);
	if( !VehicleInfo[ vehicleid ][ vImpounded ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Morate biti unutar zaplijenjenog vozila!");

	VehicleInfo[ vehicleid ][ vImpounded ] 	= 0;

	new
		tmpQuery[ 128 ];
	format(tmpQuery, sizeof(tmpQuery), "UPDATE cocars SET `impounded` = '%d' WHERE id = '%d'",
		VehicleInfo[ vehicleid ][ vImpounded ],
		VehicleInfo[ vehicleid ][ vSQLID ]
	);
	mysql_tquery(g_SQL, tmpQuery, "", "");

	PlayerToOrgMoney(playerid, FACTION_TYPE_LAW, IMPOUND_PRICE); // novac igraea ide u factionbank od PDa

	SendClientMessage( playerid, COLOR_RED, "[ ! ] Uspjesno ste platili zaplijenu vozila!");
	SendClientMessage( playerid, COLOR_RED, "[ ! ] Morate kupiti novi parking inace ce vam se vozilo spawnati u impound garazi!");
	return 1;
}


CMD:fdgarage(playerid, params[]) {
	if( !IsACop(playerid) && !IsFDMember(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");

	if(IsPlayerInRangeOfPoint(playerid, 15.0, 1178.1522,-1338.7764,13.9013) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 284.8465,-1540.9485,24.5968, 9, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 287.2799,-1537.8717,24.5278);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 9);
				}
			}

			SetPlayerVirtualWorld(playerid, 9);
			SetVehicleVirtualWorld(vehicleid, 9);
			SetVehicleZAngle(vehicleid, 160);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0, 284.8465,-1540.9485,24.5968) && GetPlayerVirtualWorld(playerid) == 9)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 1178.1522,-1338.7764,13.9013, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 1178.1522,-1338.7764,13.9013);
			SetVehicleVirtualWorld(vehicleid, 0);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleZAngle(vehicleid, -90);
		}
	}
	return (true);
}

CMD:pdgarage(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pLeader] != 1)
		return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");

	if(IsPlayerInRangeOfPoint(playerid, 15.0, 755.9906,-1431.2805,13.5234) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 1583.6351, -1639.1971, 13.4000, 60, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 1589.5824, -1642.6031, 12.9500);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 60);
				}
			}

			SetPlayerVirtualWorld(playerid, 60);
			SetVehicleVirtualWorld(vehicleid, 60);
			SetVehicleZAngle(vehicleid, 198.5400);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1589.5824, -1642.6031, 12.9500) && GetPlayerVirtualWorld(playerid) == 60)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 756.1514, -1432.2513, 13.3890, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 755.1030, -1436.6173, 17.1210);
			SetVehicleVirtualWorld(vehicleid, 0);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleZAngle(vehicleid, 271.2346);
		}
	}
	return 1;
}
CMD:pdgarage1(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pLeader] != 1)
		return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");
	//MAIN HQ
	if(IsPlayerInRangeOfPoint(playerid, 15.0, 2150.9697,-2190.0781,13.2593) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 1148.2179,2264.5469,12.6698, 90, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 1148.2179,2264.5469,12.6698);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 90);
				}
			}

			SetPlayerVirtualWorld(playerid, 90);
			SetVehicleVirtualWorld(vehicleid, 90);
			SetVehicleZAngle(vehicleid, 1.0812);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 15.0, 1148.2179,2264.5469,12.6698))
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 2150.9697,-2190.0781,13.2593, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 2150.9697,-2190.0781,13.2593);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleVirtualWorld(vehicleid, 0);
			SetVehicleZAngle(vehicleid, 1.0812);
		}
	}
	return 1;
}

CMD:sdgarage(playerid, params[])
{
    if(!IsASD(playerid) && PlayerInfo[playerid][pLeader] != 1)
		return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");
	//MAIN HQ
	if(IsPlayerInRangeOfPoint(playerid, 15.0, 629.1385,-625.4520,17.0423) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, -1631.8292,692.3904,6.7737, 70, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, -1631.8292,692.3904,6.7737);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 70);
				}
			}

			SetPlayerVirtualWorld(playerid, 70);
			SetVehicleVirtualWorld(vehicleid, 70);
			SetVehicleZAngle(vehicleid, 358.4658);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 20.0, -1631.8292,692.3904,6.7737))
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 629.1385,-625.4520,17.0423, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 629.1385,-625.4520,17.0423);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleVirtualWorld(vehicleid, 0);
			SetVehicleZAngle(vehicleid, 271.7859);
		}
	}
	return 1;
}

CMD:pdunlock(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pLeader] != 1 && !IsASD(playerid) && PlayerInfo[playerid][pLeader] != 3)
		return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 1985.1077, -2183.0867, 13.5469))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na mjestu za koristenje /pdunlock komande!");

	new vehicleid = INVALID_VEHICLE_ID;
	foreach(new i : COVehicles)
	{
		if(!VehicleInfo[i][vLock]) continue;
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(i, X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 10.0, X, Y, Z))
		{
			vehicleid = i;
			break;
		}
	}
	if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");

	new
		engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);
	VehicleInfo[ vehicleid ][ vLocked ] = false;

	new
		string[ 48 ];
	GameTextForPlayer( playerid, "~w~Vozilo ~g~otkljucano", 800, 3 );
	format( string, sizeof(string), "* %s otkljucava vozilo.", GetName(playerid, true) );
	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
    return 1;
}

CMD:cleartrunk(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pLeader] != 1) return SendClientMessage(playerid,COLOR_RED, "Niste policajac!");
	if(PlayerInfo[playerid][pRank] < FactionInfo[PlayerInfo[playerid][pMember]][rClrTrunk])
		 return va_SendClientMessage(playerid,COLOR_RED, "Niste policajac R%d+!", FactionInfo[PlayerInfo[playerid][pMember]][rClrTrunk]);
	new vehicleid = INVALID_VEHICLE_ID,
		carname[32];
	foreach(new i : COVehicles)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(i, X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z)) {
			vehicleid = i;
			break;
		}
	}
	if(vehicleid == INVALID_VEHICLE_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");
	new
		string[ 48 ];
	format( string, sizeof(string), "* %s uzima sav sadrzaj iz vozila.", GetName(playerid, true) );
	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);

	new deleteWeaponQuery[80];
	for(new wslot = 0; wslot < MAX_WEAPON_SLOTS; wslot++)
	{
		if(VehicleInfo[ vehicleid ][vWeaponSQLID][wslot] != -1)
		{
			format(deleteWeaponQuery, 80, "DELETE FROM `cocars_weapons` WHERE `id` = '%d'",
				VehicleInfo[vehicleid][vWeaponSQLID][wslot]
			);
			mysql_tquery(g_SQL, deleteWeaponQuery, "", "");

			DeleteWeaponObject(vehicleid, wslot);
			ClearWeaponObject(vehicleid, wslot);

			VehicleInfo[ vehicleid ][vWeaponSQLID][wslot] 			= -1;
			VehicleInfo[ vehicleid ][ vWeaponId ][ wslot ]			= 0;
			VehicleInfo[ vehicleid ][ vWeaponAmmo ][ wslot ]		= 0;
			Iter_Remove(COWeapons[vehicleid], wslot);
		}
	}
	strunpack( carname, Model_Name(VehicleInfo[vehicleid][vModel]) );
	new
		log[ 128 ];
	format( log, sizeof(log), "%s(%s) je ispraznio prtljaznik na vozilu %s[SQLID: %d]",
		GetName(playerid, false),
		GetPlayerIP(playerid),
		carname,
		VehicleInfo[ vehicleid ][ vOwner ]
	);
	LogPDTrunk(log);
	SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste uzeli oruzje iz gepeka.");
	return 1;
}

CMD:undercover(playerid, params[])
{
    if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik LSPDa/USMSa!");
	if( !IsPlayerInRangeOfPoint(playerid, 6.0, 2877.2317,-843.6631,-21.6994) && !IsPlayerInRangeOfPoint(playerid,6.0,2040.6858,1260.2460,-11.1115) && !IsPlayerInRangeOfPoint(playerid, 10.0, -1167.5934, -1662.6095, 896.1174) && !IsPlayerInRangeOfPoint(playerid,5.0,1073.3243,1309.4116,-47.7425) ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti unutar LSPD/SASD armorya da bi ste mogli koristiti ovu komandu.");

	if( !isnull(PlayerExName[ playerid ]) ) {
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj pravi nick!");
		SetPlayerName(playerid, PlayerExName[ playerid ]);
		PlayerExName[ playerid ][ 0 ] = EOS;
		return 1;
	}

	if( !Bit1_Get( gr_ApprovedUndercover, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati odobrenje za undercover!");
	new
		param[8],
		item;
	if( sscanf( params, "s[8] ", param ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /undercover [skins/name/mask]");
	if( !strcmp(param, "skins", true) ) {
		if( sscanf( params, "s[8]i", param, item ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /undercover skins [skinid]");
		if( 1 <= item <= 299 ) {
			switch(item) {
				case 147, 277, 278, 289, 286, 285, 287, 282, 283, 274, 275, 276: return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan Skin ID!");
			}

			new
				tmpString[ 65 ];
			format(tmpString, sizeof(tmpString), "* %s skida svoju uniformu i presvlaci se.", GetName(playerid, true));
			ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerSkin(playerid, item);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Presvukli ste se i sada vas nitko nece moci prepoznati.");
			Bit1_Set( gr_ApprovedUndercover, playerid, false );
		} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nevaljan Skin ID!");
	}
	if( !strcmp(param, "name", true) ) {
		if( !isnull(PlayerExName[playerid]) ) {
			SetPlayerName(playerid, PlayerExName[playerid]);
			SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj prijasnji nick!");
			PlayerExName[playerid][0] = EOS;
			return 1;
		}
		new
			newName[ MAX_PLAYER_NAME ];
		if( sscanf(params, "s[7]s[24]", param, newName) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /undercover name [novi nick]");
		if( !IsValidName(newName) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan roleplay nick!");
		format(PlayerExName[playerid], 24, GetName(playerid, false));

		switch( SetPlayerName(playerid, newName) ) {
			case -1: SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko na serveru posjeduje taj nick!");
			case 0:  SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete taj nick!");
			case 1: {
				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili nick u %s", newName);
				Bit1_Set( gr_ApprovedUndercover, playerid, false );
			}
		}
	}
	if( !strcmp(param, "mask", true) ) {
		if(undercover_mask[playerid] == false)
		{
			foreach(new i : Player) {
				ShowPlayerNameTagForPlayer(i, playerid, 0);
			}
			SendClientMessage(playerid, COLOR_RED, "[Undercover]: Iznad glave vam pise 'unknown', sto znaci da igraci vise nece imati mogucnost vidjet vas nick.");

			new
				undercover_Name[24];
			format(undercover_Name, sizeof(undercover_Name), "Unknown_%d", PlayerInfo[playerid][pMaskID]);
			if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
			{
				DestroyDynamic3DTextLabel(unknown_text[playerid]);
				unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
			}
			undercover_mask[playerid] = true;
			unknown_text[playerid] = CreateDynamic3DTextLabel(undercover_Name, 0xB2B2B2AA, 0, 0, -20, 25, playerid);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, unknown_text[playerid] , E_STREAMER_ATTACH_OFFSET_Z, 0.18);
		}
		else if(undercover_mask[playerid] == true)
		{
			foreach(new i : Player) {
				ShowPlayerNameTagForPlayer(i, playerid, 1);
			}

			undercover_mask[playerid] = false;
			va_SendClientMessage(playerid, COLOR_RED, "[Undercover]: Vise niste undercover, nick iznad glave vam je vracen na defualt (%s).", GetName(playerid));

			if(IsValidDynamic3DTextLabel(unknown_text[playerid]))
			{
				DestroyDynamic3DTextLabel(unknown_text[playerid]);
				unknown_text[playerid] = Text3D:INVALID_3DTEXT_ID;
			}
		}
	}
    return 1;
}

CMD:listennumber(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pRank] < FactionInfo[PlayerInfo[playerid][pMember]][rLstnNumber]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac r%d+!", FactionInfo[PlayerInfo[playerid][pMember]][rLstnNumber]);

	if( Bit1_Get( gr_PlayerTraceSomeone, playerid ) ) {
		foreach(new gplayerid : Player) {
			if( Bit16_Get( gr_PlayerTracing, gplayerid ) == playerid ) {
				Bit16_Set( gr_PlayerTracing, gplayerid, 9999 );
				break;
			}
		}
		Bit1_Set( gr_PlayerTraceSomeone, playerid, false );
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prestali ste prisluskivati mobitel!");
		return 1;
	}

	if( !IsPlayerInRangeOfPoint(playerid, 5.0, -1194.4789,-1649.6088,900.7064) && !IsPlayerInRangeOfPoint(playerid, 5.0, 2845.8594,-846.8279,-21.6994) && !IsPlayerInRangeOfPoint(playerid, 5.0, 1907.0248,627.1588,-14.942) ) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u policijskoj stanici!");
	new
		number,
		string[8];
	if( sscanf( params, "i", number ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /listennumber [broj mobitela]");
	valstr(string, number);
	if( strlen(string) != 6 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unesite broj mobitela!");
	foreach(new gplayerid : Player) {
		if( PlayerInfo[ gplayerid ][ pMobileNumber ] == number ) {
			if( Bit16_Get( gr_PlayerTracing, gplayerid ) != 9999 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Netko vec prisluskuje taj broj!");
			Bit16_Set( gr_PlayerTracing, gplayerid, playerid );
			SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Poceli ste prisluskivati %d.", number);
			Bit1_Set( gr_PlayerTraceSomeone, playerid, true );
			return 1;
		}
	}
	SendMessage(playerid, MESSAGE_TYPE_ERROR, "Broj nije u bazi podataka!");
	return 1;
}

CMD:listensms(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pRank] < FactionInfo[PlayerInfo[playerid][pMember]][rLstnSMS]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac r%d+!", FactionInfo[PlayerInfo[playerid][pMember]][rLstnSMS]);
	if( !IsPlayerInRangeOfPoint(playerid, 5.0, 1907.0248,627.1588,-14.942) && !IsPlayerInRangeOfPoint(playerid, 5.0, -1194.4789,-1649.6088,900.7064) && !IsPlayerInRangeOfPoint(playerid, 5.0, 2845.8594,-846.8279,-21.6994) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u policijskoj stanici!");
	if( Bit1_Get( gr_PlayerTraceSMS, playerid ) ) {
		Bit1_Set( gr_PlayerTraceSMS, playerid, false );
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prestali ste pratiti SMSove!");
		return 1;
	}
	foreach(new gplayerid : Player) {
		if( Bit1_Get( gr_PlayerTraceSMS, gplayerid )) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Netko vec prisluskuje SMSove!");
		return 1;
		}
	Bit1_Set( gr_PlayerTraceSMS, playerid, true );
	SendClientMessage(playerid, COLOR_GREEN, "** Poceli ste pratiti SMSove!");
	return 1;
}

CMD:mole(playerid, params[])
{
	if( !IsACop(playerid) && PlayerInfo[playerid][pRank] < 2 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac rank 2+.");
	new
		param[7];
	if( sscanf( params, "s[7] ", param ) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mole [odabir]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] buy - take - place - listen");
		return 1;
	}
	if( !strcmp(param, "buy", true) ) {
		if( !IsPlayerInRangeOfPoint(playerid, 10.0, 2037.5465,1256.3229,-11.1115)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u policijskoj stanici!"); //PD LOCKER
		if( Bit1_Get( gr_PlayerHaveMole, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate uredaj za prisluskivanje!");
		Bit1_Set( gr_PlayerHaveMole, playerid, true );
		new
			tmpString[80];
		format(tmpString, sizeof(tmpString), "* %s uzima uredjaj s police.", GetName(playerid, true));
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else if( !strcmp(param, "place", true) ) {
		if( !Bit1_Get( gr_PlayerHaveMole, playerid ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate uredaj za prisluskivanje!");
		new
			string[ 69 ];
		format( string, sizeof(string), "* %s se saginje i nesto postavlja blizu sebe.", GetName(playerid, true) );
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
		SendClientMessage(playerid, COLOR_PURPLE, string);

		new
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		MolePosition[ playerid ][ 0 ] = X; MolePosition[ playerid ][ 1 ] = Y; MolePosition[ playerid ][ 2 ] = Z;

		Bit1_Set( gr_PlayerPlacedMole, playerid, true );
		Bit1_Set( gr_PlayerHaveMole, playerid, false );
	}
	else if( !strcmp(param, "take", true) ) {
		if( !IsPlayerInRangeOfPoint(playerid, 5.0, MolePosition[ playerid ][ 0 ], MolePosition[ playerid ][ 1 ], MolePosition[ playerid ][ 2 ] ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog uredaja za prisluskivanje!");

		new
			string[ 69 ];
		format( string, sizeof(string), "* %s se saginje i uzima nesto blizu sebe.", GetName(playerid, true) );
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
		SendClientMessage(playerid, COLOR_PURPLE, string);

		MolePosition[ playerid ][ 0 ] = 0.0; MolePosition[ playerid ][ 1 ] = 0.0; MolePosition[ playerid ][ 2 ] = 0.0;
		Bit1_Set( gr_PlayerHaveMole, playerid, true );
		Bit1_Set( gr_PlayerPlacedMole, playerid, false );
	}
	else if( !strcmp(param, "listen", true) ) {
		new type;
		if( sscanf( params, "s[7]i", param, type ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mole listen [1 - samostalno/2 - zvucnik]");
		if( type == 1 ) {
			Bit2_Set( gr_PlayerListenMole, playerid, 1 );
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Sada cete cuti sve razgovore koji se vode oko vaseg uredaja!");
		}
		else if( type == 2 ) {
			Bit2_Set( gr_PlayerListenMole, playerid, 2 );
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Sada cete cuti sve razgovore koji se vode oko vaseg uredaja!");
		}
	}
	return 1;
}
CMD:pa(playerid, params[])
{
	if(!IsACop(playerid) && !IsASD(playerid) && !IsFDMember(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD/LSFD!");
	if(Bit1_Get(gr_Paspam, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate malo pricekati prije koristenja Panic Alarma ponovno.");
	new tmpString[128];
	format(tmpString, sizeof(tmpString), "** %s pritisce Panic Alarm dugme na radio-prijamniku.", GetName(playerid, true));
	SetPlayerChatBubble(playerid, tmpString, COLOR_PURPLE, 20, 20000);
	SendClientMessage(playerid, COLOR_PURPLE, tmpString);
    new zone[100];
	format( zone, 100, GetPlayerStreet(playerid));
	format(tmpString, sizeof(tmpString), "[HQ] Panic Alarm se upalio od strane %s %s.",	ReturnPlayerRankName(playerid), GetName(playerid, false));
	SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_SKYBLUE, tmpString);
	format(tmpString, sizeof(tmpString), "[HQ] Zadnja lokacija je %s.", zone);
	SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_SKYBLUE, tmpString);
	Bit1_Set( gr_Paspam, playerid, true);
	SetTimerEx("PASpamTimer", 60000, false, "i", playerid);
	return 1;
}
CMD:hq(playerid, params[])
{
	if(strlen(params) >= 86)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Tekst ne smije imati vise od 86 znakova!");
		
	if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste LSPD/SASD!");
	new
		string[156], result[86];
	if(sscanf(params, "s[86]", result)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /hq [text]");
	format(string, sizeof(string), "[HQ] %s %s: %s", ReturnPlayerRankName(playerid), GetName(playerid, false), result);
	SendRadioMessage(PlayerInfo[playerid][pMember], COLOR_SKYBLUE, string);
	return 1;
}
CMD:ramdoor(playerid, params[])
{
	if( !IsACop(playerid) && !IsFDMember(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PD/FD!");
 	if( !IsPlayerInDynamicCP(playerid, PlayerHouseCP[ playerid ] ) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce!");
	new
		house = Bit16_Get( gr_PlayerInfrontHouse, playerid );

	if( house == INVALID_HOUSE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne nalazite se pred vratima kuce!");
	if( !HouseInfo[ house ][ hLock ] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su otkljucana!");

	if(Bit1_Get( gr_CrowbarBreaking, playerid )) {
		DisablePlayerKeyInput(playerid);
		TogglePlayerControllable(playerid, true);
		Bit1_Set( gr_CrowbarBreaking, playerid, false );
		return 1;
	}

	new
		object = IsObjectAttached(playerid, 18634);
	if( object == -1 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pajser u rukama!");
	if( 5 <= PlayerObject[playerid][object][poBoneId] <= 6 ) {
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Pricekajte tipke koje morate unijeti, za prekid probijanja kucajte /ramdoor!");
		SetPlayerCrowbarBreaking(playerid);
	} else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pajser mora biti u rukama!");
	return 1;
}

CMD:housetake(playerid, params[])
{
	if( !IsACop(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PDa!");
	new
		takeQuery[ 200 ],
		param[8],
		house = Bit16_Get( gr_PlayerInHouse, playerid );

	if( house == INVALID_HOUSE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u kuci!");
	if(sscanf(params, "s[8] ", param)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /housetake [weapons]");

	if( !strcmp(param, "weapons", true) ) {
		// Enum
		new id = Storage_RackNear(playerid);
		if(id == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u blizini police s oruzjem!");

		for (new i = 0; i < 4; i++)
		{
			HouseStorage[id][storageWeapons][i] = 0;
			HouseStorage[id][storageAmmo][i] = 0;
			HouseStorage_SaveWep(id, i);
		}
		Storage_RackRefresh(id);
		HouseStorage_Save(id);

		format(takeQuery, sizeof(takeQuery), "%s je ispraznio sva oruzja sa police[SQLID:%d] kuce[SQLID: %d]", GetName(playerid, false), HouseStorage[id][storageID], HouseInfo[house][hSQLID]);
		LogPDTakes(takeQuery);

		new
			tmpString[ 55 ];
		format(tmpString, sizeof(tmpString), "* %s uzima svo oruzje sa police.",
			GetName(playerid, true)
		);
		ProxDetector(10.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
CMD:returnduty(playerid, params[])
{
    if(!IsACop(playerid) && !IsFDMember(playerid) && !IsASD(playerid) && !IsAGov(playerid)) return SendClientMessage(playerid,COLOR_RED, "Niste ovlasteni!");
	if(PlayerInfo[playerid][pLawDuty] == 1) return  SendClientMessage(playerid,COLOR_RED, "Vec ste na duznosti!");
	new tmpstring [ 120 ];
    new
		Float:X, Float:Y, Float:Z, vehicleid = -1;
	if(IsACop(playerid))
	{
		foreach(new i : Vehicles) {
			GetVehiclePos(i, X, Y, Z);
			if(VehicleInfo[i][vFaction] == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z)) {
				vehicleid = i;
				break;
			}
		}
	}
	else if(IsFDMember(playerid))
	{
		foreach(new i : Vehicles)
		{
			GetVehiclePos(i, X, Y, Z);
			if(VehicleInfo[i][vFaction] == 2 && IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z)) {
				vehicleid = i;
				break;
			}
		}
	}
	else if(IsASD(playerid))
	{
		foreach(new i : Vehicles)
		{
			GetVehiclePos(i, X, Y, Z);
			if(VehicleInfo[i][vFaction] == 3 && IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z)) {
				vehicleid = i;
				break;
			}
		}
	}
	else if(IsAGov(playerid))
	{
		foreach(new i : Vehicles)
		{
			GetVehiclePos(i, X, Y, Z);
			if(VehicleInfo[i][vFaction] == 4 && IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z)) {
				vehicleid = i;
				break;
			}
		}
	}
	if(vehicleid == -1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu fakcijskog vozila!");
		
	PlayerInfo[playerid][pLawDuty] = 1;
	Bit1_Set( gr_PDOnDuty, playerid, true );
	format(tmpstring, sizeof(tmpstring), "*[HQ] %s %s je ponovo na duznonosti ((crash)).", ReturnPlayerRankName(playerid), GetName(playerid,false));

	if(IsACop(playerid))
		SendRadioMessage(1, COLOR_COP, tmpstring);
	if(IsASD(playerid))
		SendRadioMessage(3, COLOR_COP, tmpstring);
	else if(IsFDMember(playerid))
		SendRadioMessage(2, COLOR_ALLDEPT, tmpstring);
	else if(IsAGov(playerid))
		SendRadioMessage(4, COLOR_DARKYELLOW, tmpstring);
				
	return 1;
}
CMD:callsign(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste pripadnik PDa/SDa!");
    if(PlayerInfo[playerid][pLawDuty] == 0) return  SendClientMessage(playerid,COLOR_RED, "Morate biti na duznosti!");
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /callsign [UNIT]");

	new
		str[128];

	format(PlayerInfo[playerid][pCallsign], 60, "%s", params);

	format(str, sizeof(str), "** HQ: %s %s je sada pod callsignom %s! **", ReturnPlayerRankName(playerid), GetName(playerid,false), params);
	if(IsACop(playerid))
		SendRadioMessage(1, COLOR_COP, str);
	if(IsASD(playerid))
		SendRadioMessage(3, COLOR_COP, str);
	return 1;
}
