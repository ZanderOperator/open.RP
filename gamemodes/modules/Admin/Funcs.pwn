#include <YSI_Coding\y_hooks>

// Admin Modules included at the bottom
#define PLAYER_SPECATE_VEH		(1)
#define PLAYER_SPECATE_PLAYER	(2)

#define MAX_ADMIN_VEHICLES 		(5) // Koliko admin moze maximalno admin vozila spawnat. (/veh) 

// Premium VIP Extra EXP
#define BRONZE_EXP_POINTS		(13)
#define SILVER_EXP_POINTS		(25)
#define GOLD_EXP_POINTS			(50)
#define PLATINUM_EXP_POINTS		(80)
/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
	
new
	bool: pns_garages = true,
	bool: count_started = false,
	Timer:CountingTimer,
	Admin_Vehicle[MAX_PLAYERS][MAX_ADMIN_VEHICLES],
	Admin_vCounter[MAX_PLAYERS],
	cseconds,
	Timer:LearnTimer[MAX_PLAYERS],
	LastDriver[MAX_VEHICLES][MAX_PLAYER_NAME],
	ReconingVehicle[MAX_PLAYERS],
	ReconingPlayer[MAX_PLAYERS],
	Timer:ReconTimer[MAX_PLAYERS],
	AdminLoginTry[MAX_PLAYERS],
    oldskin[MAX_PLAYERS],
	PortedPlayer[MAX_PLAYERS],
	bool:AdminDuty[MAX_PLAYERS],
	bool:HelperDuty[MAX_PLAYERS],
	bool:NeedHelp[MAX_PLAYERS],
	// Player
	Bit1: 	a_PlayerReconed	<MAX_PLAYERS>,
    Bit1: 	a_AdminChat 	<MAX_PLAYERS>,
    Bit1: 	a_PMears 		<MAX_PLAYERS>,
    Bit1:   a_AdNot         <MAX_PLAYERS>,
    Bit1: 	a_REars 		<MAX_PLAYERS>,
	Bit1: 	a_BHears 		<MAX_PLAYERS>,
    Bit1: 	a_DMCheck 		<MAX_PLAYERS>,
	Bit1:	a_BlockedHChat	<MAX_PLAYERS>,
	Bit1:	a_TogReports	<MAX_PLAYERS>;
	
// TextDraws
static stock 
	PlayerText:ReconBack[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconBcg1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconTitle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };

static bool:OnFly[MAX_PLAYERS];		// true = player is flying, false = player on foot

// prototypes

forward InitFly(playerid);							// call this function in OnPlayerConnect
forward bool:StartFly(playerid);					// start flying
forward Fly(playerid);								// timer
forward bool:StopFly(playerid);						// stop flying

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  & Timers
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

bool:Admin_OnDuty(playerid)
{
	return AdminDuty[playerid];
}

Admin_SetOnDuty(playerid, bool:v)
{
	AdminDuty[playerid] = v;
}

bool:Helper_OnDuty(playerid)
{
	return HelperDuty[playerid];
}

Helper_SetOnDuty(playerid, bool:v)
{
	HelperDuty[playerid] = v;
}

bool:Player_NeedsHelp(playerid)
{
	return NeedHelp[playerid];
}

Player_SetNeedHelp(playerid, bool:v)
{
	NeedHelp[playerid] = v;
}

InitFly(playerid)
{
	OnFly[playerid] = false;
	return;
}

bool:StartFly(playerid)
{
	if(OnFly[playerid])
        return false;
    OnFly[playerid] = true;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z+5.0);
	ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
	Fly(playerid);
	GameTextForPlayer(playerid,"~n~~r~~k~~PED_FIREWEAPON~ ~w~- increase height~n~~r~RMB ~w~- reduce height~n~\
	~r~~k~~PED_SPRINT~ ~w~- increase spd~n~\
	~r~~k~~SNEAK_ABOUT~ ~w~- reduce spd",10000,3);
	return true;
}

timer Fly[100](playerid)
{
	if(!IsPlayerConnected(playerid))
		return 1;
	new k, ud,lr;
	GetPlayerKeys(playerid,k,ud,lr);
	new Float:v_x,Float:v_y,Float:v_z,
		Float:x,Float:y,Float:z;
	if(ud < 0)	// forward
	{
		GetPlayerCameraFrontVector(playerid,x,y,z);
		v_x = x+0.1;
		v_y = y+0.1;
	}
	if(k & 128)	// down
		v_z = -0.2;
	else if(k & KEY_FIRE)	// up
		v_z = 0.2;
	if(k & KEY_WALK)	// slow
	{
		v_x /=5.0;
		v_y /=5.0;
		v_z /=5.0;
	}
	if(k & KEY_SPRINT)	// fast
	{
		v_x *=4.0;
		v_y *=4.0;
		v_z *=4.0;
	}
	if(v_z == 0.0) 
		v_z = 0.025;
	SetPlayerVelocity(playerid,v_x,v_y,v_z);
	if(v_x == 0 && v_y == 0)
	{	
		if(GetPlayerAnimationIndex(playerid) == 959)	
			ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
	}
	else 
	{
		GetPlayerCameraFrontVector(playerid,v_x,v_y,v_z);
		GetPlayerCameraPos(playerid,x,y,z);
		SetPlayerLookAt(playerid,v_x*500.0+x,v_y*500.0+y);
		if(GetPlayerAnimationIndex(playerid) != 959)
			ApplyAnimation(playerid,"PARACHUTE","FALL_SkyDive_Accel",6.1,1,1,1,1,0,1);
	}
	if(OnFly[playerid])
		defer Fly(playerid);
	return 1;
}

bool:StopFly(playerid)
{
	if(!OnFly[playerid])
        return false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
	OnFly[playerid] = false;
	return true;
}


IsValidInactivity(sqlid)
{
	new	Cache:result,
		bool:value = false,
		endstamp;

	
	result = mysql_query(g_SQL, va_fquery(g_SQL, 
				"SELECT sqlid, endstamp FROM inactive_accounts WHERE sqlid = '%d'", sqlid)
			);

	if(!cache_num_rows())
		value = false;
	else
	{
		cache_get_value_name_int(0, "endstamp", endstamp);
		if(endstamp >= gettimestamp()) // Prijavljena neaktivnost jos uvijek traje
			value = true;
		else // Prijavljena neaktivnost je istekla
		{
			mysql_fquery(g_SQL, "DELETE FROM inactive_accounts WHERE sqlid = '%d'", sqlid);
			value = false;
		}
	}
	cache_delete(result);
	return value;
}

IsAccountTeamStaff(sqlid)
{
	new	Cache:result,
		bool:value = false,
		admin = 0,
		helper = 0;

	result = mysql_query(g_SQL, va_fquery(g_SQL, "SELECT adminLvl, helper FROM accounts WHERE sqlid = '%d'", sqlid));

	if(!cache_num_rows())
		value = false;
	else
	{
		cache_get_value_name_int(0, "adminLvl", admin);
		cache_get_value_name_int(0, "helper", helper);
		if(admin > 0 || helper > 0)
			value = true;
	}
	cache_delete(result);
	return value;
}

ShowPlayerCars(playerid, playersqlid, player_name[])
{
	new 
		owner_name[MAX_PLAYER_NAME];
	strcpy(owner_name, player_name, MAX_PLAYER_NAME);

	inline OnLoadPlayerVehicles()
	{
		if(!cache_num_rows())
		{
			SendFormatMessage(playerid, 
				MESSAGE_TYPE_ERROR, 
				"%s doesn't own any vehicles.",
				owner_name
			);
			return 1;
		}
		new 
			tmpModelID,
			tmpCarMysqlID,
			vehName[32];
		
		va_SendClientMessage(playerid, COLOR_RED, "[%s's Vehicle List]:", owner_name);	
		for( new i = 0; i < cache_num_rows(); i++) 
		{
			cache_get_value_name_int(i, "id", tmpCarMysqlID);
			cache_get_value_name_int(i, "modelid", tmpModelID);
			
			strunpack(vehName, Model_Name(tmpModelID));
			va_SendClientMessage(playerid, COLOR_WHITE,"[slot %d] %s [MySQL ID: %d].", i+1, vehName, tmpCarMysqlID);
		}
	}
	MySQL_TQueryInline(g_SQL,  
		using inline OnLoadPlayerVehicles,
		va_fquery(g_SQL, "SELECT id, modelid FROM cocars WHERE ownerid = '%d' LIMIT %d", 
			playersqlid,
			MAX_PLAYER_CARS
		),
		""
	);
	return 1;
}

stock ABroadCast(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level)
			SendClientMessage(i, color, string);
	}
	return 1;
}

va_ABroadCast(color, const string[], level, va_args<>)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level)
			SendClientMessage(i, color, va_return(string, va_start<3>));
	}
	return 1;
}

stock REarsBroadCast(color,const string[], level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_REars, i))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendDirectiveMessage(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level)
  		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock PmearsBroadCast(color,const string[], level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_PMears, i))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}



stock BhearsBroadCast(color,const string[], level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_BHears, i))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}


stock AHBroadCast(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(( PlayerInfo[i][pAdmin] >= level || PlayerInfo[i][pHelper] >= level || IsPlayerAdmin(i)) && Bit1_Get( a_AdminChat, i))
  		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock HighAdminBroadCast(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && Bit1_Get( a_AdminChat, i))
  		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

SendAdminMessage(color, string[], va_args<>)
{
	new 
		format_message[144];
	va_format(format_message, sizeof(format_message), string, va_start<2>);
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= 1 && Bit1_Get( a_AdminChat, i))
			SendClientMessage(i, color, format_message);
	}
	return 1;
}

SendHelperMessage(color, string[], va_args<>)
{
	new 
		format_message[144];
	va_format(format_message, sizeof(format_message), string, va_start<2>);
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pHelper] >= 1)
			SendClientMessage(i, color, format_message);
	}
	return 1;
}

stock SendAdminNotification(color, string[])
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= 1 && Bit1_Get( a_AdminChat, i))
			SendMessage(i, color, string);
	}
}


stock DMERSBroadCast(color, const string[], level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_DMCheck, i))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SoundForAll(sound)
{
    foreach (new i : Player)
    {
        PlayerPlaySound(i, sound, 0.0, 0.0, 0.0);
    }
}

stock UnLockCar(carid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(carid, engine, lights, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);
}

stock ForbiddenWeapons(weaponid)
{
	switch(weaponid)
	{
		case 16,35,36,37,38,39,44,45,47: return 1;
		default: 
			return 0;
	}
	return 1;
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new
		i,
	    li,
		aNum,
	    len;
	    
	while (i <= strlen(strsrc))
	{
	    if(strsrc[i] == delimiter || i == strlen(strsrc))
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}

// l3o - ShowAdminVehicles - CreateAdminVehicles - DestroyAdminVehicle - ResetAdminVehVars
ShowAdminVehicles(playerid) {
	for (new i = 0; i < MAX_ADMIN_VEHICLES; i ++) {
		if(Admin_Vehicle[playerid][i] != -1) {
			va_SendClientMessage(playerid, COLOR_RED, "[!][ADMIN-VEH (%d)]: ID %d.", i, Admin_Vehicle[playerid][i]);
		}
	}
	return (true);
}

CreateAdminVehicles(admin, carid) {
	for (new i = 0; i < MAX_ADMIN_VEHICLES; i ++) {
		if(Admin_Vehicle[admin][i] == -1) {
			Admin_Vehicle[admin][i] = carid;
			Admin_vCounter[admin]++;
			break;
		}
	}
	return (true);
}

Public:DestroyAdminVehicle(admin, carid) 
{
	for (new i = 0; i < MAX_ADMIN_VEHICLES; i ++) {
		if(Admin_Vehicle[admin][i] == carid) {
			Admin_Vehicle[admin][i] = -1;
			Admin_vCounter[admin]--;
			break;
		}
	}
	return (true);
}

ResetAdminVehVars(admin) {
	for (new i = 0; i < MAX_ADMIN_VEHICLES; i ++) {
		Admin_Vehicle[admin][i] = -1;
		Admin_vCounter[admin] = 0;
	}
	return (true);
}

Public: OnHelperPINHashed(playerid, level)
{
	new 
		saltedPin[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(saltedPin);

	strcpy(PlayerInfo[playerid][pTeamPIN], saltedPin, BCRYPT_HASH_LENGTH);

	mysql_fquery(g_SQL, "UPDATE accounts SET teampin = '%e', helper = '%d' WHERE sqlid = '%d'", 
		saltedPin, 
		level, 
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

forward OnAdminPINHashed(playerid, level);
public OnAdminPINHashed(playerid, level)
{
	new 
		saltedPin[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(saltedPin);

	strcpy(PlayerInfo[playerid][pTeamPIN], saltedPin, BCRYPT_HASH_LENGTH);
	
	mysql_fquery(g_SQL, "UPDATE accounts SET teampin = '%e', adminLvl = '%d' WHERE sqlid = '%d'", 
		saltedPin, 
		level, 
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

Public: OnTeamPINHashed(playerid)
{
	new 
		saltedPin[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(saltedPin);
	
	strcpy(PlayerInfo[playerid][pTeamPIN], saltedPin, BCRYPT_HASH_LENGTH);

	mysql_fquery(g_SQL, "UPDATE accounts SET teampin = '%e' WHERE sqlid = '%d'", 
		saltedPin, 
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

Public: OnPINChecked(playerid, status)
{
	new bool:match = bcrypt_is_equal();
	if(match) 
	{
		SendClientMessage(playerid, COLOR_RED, "[SERVER]: Welcome to Server Team System! Use /ahelp for commands.");
		PlayerInfo[playerid][pAdmin] 	= PlayerInfo[playerid][pTempRank][0];
		PlayerInfo[playerid][pHelper] 	= PlayerInfo[playerid][pTempRank][1];
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/pinlogins.txt", "(%s) %s (%s) sucessfully logged into server team system!", 
			ReturnDate(), 
			GetName(playerid, false), 
			ReturnPlayerIP(playerid)
		);
		#endif
	} 
	else 
	{
		SendClientMessage(playerid, COLOR_RED, "Wrong PIN input! Mistakes will lead to sanctions!");
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/pinlogins.txt", "(%s) %s (%s) unsucessfully tried to log into server team system!", 
			ReturnDate(), 
			GetName(playerid, false), 
			ReturnPlayerIP(playerid)
		);
		#endif
		
		if(++AdminLoginTry[playerid] && AdminLoginTry[playerid] >= 3) {
			SendClientMessage(playerid, COLOR_RED, "[SERVER]:  You have reached the team login try limit, you're kicked!");
			KickMessage(playerid);
		}
	}
	return 1;
}


/*
	d8888b. d88888b  .o88b.  .d88b.  d8b   db 
	88  8D 88'     d8P  Y8 .8P  Y8. 888o  88 
	88oobY' 88ooooo 8P      88    88 88V8o 88 
	888b   88~~~~~ 8b      88    88 88 V8o88 
	88 88. 88.     Y8b  d8 8b  d8' 88  V888 
	88   YD Y88888P  Y88P'  Y88P'  VP   V8P 
*/

stock DestroyReconTextDraws(playerid)
{
	if(ReconBcg1[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, ReconBcg1[playerid]);
		ReconBcg1[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(ReconBack[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, ReconBack[playerid]);
		ReconBack[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(ReconTitle[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, ReconTitle[playerid]);
		ReconTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	if(ReconText[playerid] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, ReconText[playerid]);
		ReconText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock static CreateReconTextDraws(playerid)
{
	DestroyReconTextDraws(playerid);
	ReconBcg1[playerid] = CreatePlayerTextDraw(playerid, 409.649871, 317.507995, "usebox");
	PlayerTextDrawLetterSize(playerid, ReconBcg1[playerid], 0.000000, 8.967220);
	PlayerTextDrawTextSize(playerid, ReconBcg1[playerid], 246.399993, 0.000000);
	PlayerTextDrawAlignment(playerid, ReconBcg1[playerid], 1);
	PlayerTextDrawColor(playerid, ReconBcg1[playerid], 0);
	PlayerTextDrawUseBox(playerid, ReconBcg1[playerid], true);
	PlayerTextDrawBoxColor(playerid, ReconBcg1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, ReconBcg1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ReconBcg1[playerid], 0);
	PlayerTextDrawFont(playerid, ReconBcg1[playerid], 0);
	PlayerTextDrawShow(playerid, ReconBcg1[playerid]);

	ReconBack[playerid] = CreatePlayerTextDraw(playerid, 409.650115, 317.619995, "usebox");
	PlayerTextDrawLetterSize(playerid, ReconBack[playerid], 0.000000, 1.897220);
	PlayerTextDrawTextSize(playerid, ReconBack[playerid], 246.300033, 0.000000);
	PlayerTextDrawAlignment(playerid, ReconBack[playerid], 1);
	PlayerTextDrawColor(playerid, ReconBack[playerid], 0);
	PlayerTextDrawUseBox(playerid, ReconBack[playerid], true);
	PlayerTextDrawBoxColor(playerid, ReconBack[playerid], 102);
	PlayerTextDrawSetShadow(playerid, ReconBack[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ReconBack[playerid], 0);
	PlayerTextDrawFont(playerid, ReconBack[playerid], 0);
	PlayerTextDrawShow(playerid, ReconBack[playerid]);

	ReconTitle[playerid] = CreatePlayerTextDraw(playerid, 253.050018, 319.872100, "John_Doe(6)");
	PlayerTextDrawLetterSize(playerid, ReconTitle[playerid], 0.363299, 1.148640);
	PlayerTextDrawAlignment(playerid, ReconTitle[playerid], 1);
	PlayerTextDrawColor(playerid, ReconTitle[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ReconTitle[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ReconTitle[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ReconTitle[playerid], 51);
	PlayerTextDrawFont(playerid, ReconTitle[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ReconTitle[playerid], 1);
	PlayerTextDrawShow(playerid, ReconTitle[playerid]);

	ReconText[playerid] = CreatePlayerTextDraw(playerid, 254.9, 339.1, "~y~Money: 500~g~$~y~~n~Health: 60.0~n~Armour: 0.0~n~Package loss: 0.0%~n~Vehicle ID: 550~n~FPS: 55~n~Ping: 55");
	PlayerTextDrawLetterSize(playerid, ReconText[playerid], 0.293500, 0.871440);
	PlayerTextDrawAlignment(playerid, ReconText[playerid], 1);
	PlayerTextDrawColor(playerid, ReconText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ReconText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ReconText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ReconText[playerid], 51);
	PlayerTextDrawFont(playerid, ReconText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ReconText[playerid], 1);
	PlayerTextDrawShow(playerid, ReconText[playerid]);
}

SetPlayerReconTarget(playerid, targetid)
{
	new
		Float:targetHealth,
		Float:targetArmour,
		tmpString[130];

	GetPlayerHealth(targetid, targetHealth);
	GetPlayerArmour(targetid, targetArmour);
	
	new 
		stats[401],
		packets[80],
		Float:PacketLoss;

	GetPlayerNetworkStats(targetid, stats, sizeof(stats));
	strmid(packets, stats, strfind(stats, "Packetloss: ") + 11, strfind(stats, "Packetloss: ") + 14);
	PacketLoss = floatstr(packets);

	format(tmpString, sizeof(tmpString), "~y~Money: %d~g~$~y~~n~Health: %.2f~n~Armour: %.2f~n~Package loss: %.2f%~n~Vehicle ID: %d~n~FPS: %d~n~Ping: %d",
		AC_GetPlayerMoney(targetid),
		targetHealth,
		targetArmour,
		PacketLoss,
		GetPlayerVehicleID(targetid),
		GetPlayerFPS(targetid),
		GetPlayerPing(targetid)
	);
	
	CreateReconTextDraws(playerid);
	PlayerTextDrawSetString(playerid, ReconText[playerid], tmpString);
	format(tmpString, sizeof(tmpString), "%s(%d)", GetName(targetid, false), targetid);
	PlayerTextDrawSetString(playerid, ReconTitle[playerid], tmpString);
	Bit1_Set( a_PlayerReconed, playerid, true);
	ReconTimer[playerid] = repeat OnPlayerReconing(playerid, targetid);
	return 1;
}

timer LearnPlayer[1000](playerid, learnid)
{
    if(IsPlayerConnected(playerid))
	{
	    if(learnid == 1)
	    {
			GetPlayerPreviousInfo(playerid);
			SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid, 0);
			RandomPlayerCameraView(playerid);
		    SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_RED, "[!] â€˘ What is RolePlay ? â€˘");
		  	SendClientMessage(playerid, COLOR_WHITE, " ");
		  	SendClientMessage(playerid, COLOR_WHITE, "RolePlay is simulation of real life. ");
		    SendClientMessage(playerid, COLOR_WHITE, "In that kind of game, it's good to know the RolePlay rules. ");
		    SendClientMessage(playerid, COLOR_WHITE, "It is desireable to spend as much time as possible RolePlaying.");
		    SendClientMessage(playerid, COLOR_WHITE, "With quality RolePlay, your chances of suceeding in the game are very increased. ");
		    SendClientMessage(playerid, COLOR_WHITE, "If you are new player, you can easily learn RolePlay rules.");
			stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 2);
		}
		else if(learnid == 2)
		{
		    SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ RolePlay terminology â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Since this is Hardcore RolePlay server, RolePlay rules are very important to follow!");
	        SendClientMessage(playerid, COLOR_WHITE, "Are you familiar with some RolePlay terms?");
	        SendClientMessage(playerid, COLOR_WHITE, "Through this tutorial, you'll get some insight on basic RolePlay rules.");
	        SendClientMessage(playerid, COLOR_WHITE, "Let's begin!");
		    stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 3);
		}
		else if(learnid == 3)
		{
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ In Character and Out of Character(OOC) Chat â€˘");
			SendClientMessage(playerid, COLOR_WHITE," ");
	   		SendClientMessage(playerid, COLOR_WHITE, "It's very important to know the difference between these two chats.");
			SendClientMessage(playerid, COLOR_WHITE," ");
	        SendClientMessage(playerid, COLOR_WHITE, "In Character (IC) is bound by your character, who you impersonate InGame. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Inside IC chat, you can't mix things from your private life and other OOC stuff.");
	        SendClientMessage(playerid, COLOR_WHITE, "Example of IC chat: 'Good day sir, my name is Mike. Where do you come from?')");
	       	SendClientMessage(playerid, COLOR_WHITE, "In Character chats are /call, /sms, /ct, /c, /w, /s.");
			SendClientMessage(playerid, COLOR_WHITE," ");
	       	SendClientMessage(playerid, COLOR_WHITE, "Out of Character(OOC) is bound to things that aren't directly related with your character InGame.");
	       	SendClientMessage(playerid, COLOR_WHITE, "Example of OOC chat: '/b Did you look at that topic on forum? Who are admins on this server?'");
			stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 4);
		}
		else if(learnid == 4)
		{
		    SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ What is MetaGaming(MG)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "MetaGaming is using Out of Character (OOC) informations for In Character (IC) purposes.");
	        SendClientMessage(playerid, COLOR_WHITE, "Example of MetaGaming is shouting person's name you saw first time InGame, just because you saw his nick.");
	        SendClientMessage(playerid, COLOR_WHITE, "When you see a name of other player above his head, you don't know his name, until he tells it himself.");
	        SendClientMessage(playerid, COLOR_WHITE, "Also, if you see someone wearing gang/mafia clothes, you have no right to call him a gangster/mobster.");
	        SendClientMessage(playerid, COLOR_WHITE, "MetaGaming is strictly punishable(1h+ prison, etc.), as is any other form of abiding RolePlay rules.");
			stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 5);
		}
		else if(learnid == 5)
		{
		    SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ Sto je to PowerGaming(PG)? â€˘");
			SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Powergaming je odradjivanje radnje koju u stvarnom zivotu ne mozete odraditi. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Naime, radnja koju ne mozete izvrsiti ili u odredjenom momentu ili uopce ne mozete izvrsiti tu radnju. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Najbolji opis Powergaminga se moze vidjeti ukoliko Vas netko zeli opljackati, prijeti oruzjem - Vi skocite iz auta i krente bjezati.");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer, ukoliko padnete sa odredjene visine i nastavite se normalno kretati.");
	        SendClientMessage(playerid, COLOR_WHITE, "PowerGaming je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		  	stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 6);
		}
		else if(learnid == 6)
		{
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ Sto je to Bunnyhop(BH)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop je ucestalo skakanje prilikom Vasega kretanja.");
			SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop se koristi kako bi se ubrzali, sto nikako nije RolePlay.");
			SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
			stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 7);
		}
		else if(learnid == 7)
		{
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ Sto je to Revenge Kill(RK)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Revenge Kill je ubojstvo iz osvete.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer Revenge Killa je kada Vas netko ubije, Vi se usredotocite na to da nabavite oruzje i ubijete natrag tu osobu.");
	        SendClientMessage(playerid, COLOR_WHITE, "Kada se dogodi PK, Vi zaboravljate situaciju u kojoj ste se nasli, te ljude koji su Vas ubili!");
			SendClientMessage(playerid, COLOR_WHITE, "Revenge Kill je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		    stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 8);
		}
		else if(learnid == 8)
		{
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ /me i /ame /do komanda? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, "");
	        SendClientMessage(playerid, COLOR_RED, "[!] /me - komanda koja se koristi za trenutnu radnju Vaseg IC karaktera koja se dogodila u trenutku. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Naravno, /me komanda ne smije biti koristena kako bi se izvukli iz nekog RolePlaya.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer: /me uzima sok sa stola te ispija gutljaj.");
			SendClientMessage(playerid, COLOR_RED, "[!] /ame - komanda koja se koristi za trenutnu radnju Vaseg IC karaktera i koja poslje odredjenog vremena i dalje traje.");
			SendClientMessage(playerid, COLOR_WHITE, "Primjer: /ame se osmjehuje, /ame klima glavom potvrdno, /ame se naslanja na zid.");
			SendClientMessage(playerid, COLOR_RED, "[!] /do - komanda kojom se opisuje trenutna IC situacija.");
			SendClientMessage(playerid, COLOR_WHITE, " /do se pise u trecem licu odnosno u pogledu posmatraca, moze opisivati i okolinu.");
			SendClientMessage(playerid, COLOR_WHITE, "Primjer: Sta bi se nalazilo ispred Johnnya na stolu? (( Patricia Vargas))");
		    stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 9);
		}
		else if(learnid == 9)
		{
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
		 	SendClientMessage(playerid, COLOR_RED, "[!] â€˘ Sto je to Drive By(DB)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Drive By je pucanje oruzjem s mjesta vozaca iz bilo kojeg mjesta u vozilu na civile, motore ili bicikle.");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer je zabranjeno ubijanje propelerom helikoptera i gazenje igraca vozilom.");
	        SendClientMessage(playerid, COLOR_WHITE, "Drive By je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		    stop LearnTimer[playerid];
			LearnTimer[playerid] = defer LearnPlayer[28000](playerid, 10);
		}
		else if(learnid == 10)
		{
			stop LearnTimer[playerid];
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
	   		SendClientMessage(playerid, COLOR_RED, "[!] â€˘ KRAJ TUTORIALA â€˘");
	        SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Nadamo se da ste naucili nesto iz nasega tutoriala!");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer se nadamo, da vise necete krsiti RolePlay pravila.");
			SetPlayerPreviousInfo(playerid);
		}
	}
	return 1;
}

stock static UpdateTargetReconData(playerid, targetid)
{
	new
		Float:targetHealth,
		Float:targetArmour,
		tmpString[130];

	GetPlayerHealth(targetid, targetHealth);
	GetPlayerArmour(targetid, targetArmour);

	new 
		stats[401],
		packets[80],
		Float:PacketLoss;

	GetPlayerNetworkStats(targetid, stats, sizeof(stats));
	strmid(packets, stats, strfind(stats, "Packetloss: ") + 11, strfind(stats, "Packetloss: ") + 14);
	PacketLoss = floatstr(packets);
	
	format(tmpString, sizeof(tmpString), "~y~Novac: %d~g~$~y~~n~Health: %.2f~n~Armour: %.2f~n~Package loss: %.2f%~n~Vehicleid: %d~n~FPS: %d~n~Ping: %d",
		AC_GetPlayerMoney(targetid),
		targetHealth,
		targetArmour,
		PacketLoss,
		GetPlayerVehicleID(targetid),
		GetPlayerFPS(targetid),
		GetPlayerPing(targetid)
	);
	PlayerTextDrawSetString(playerid, ReconText[playerid], tmpString);

	if(ReconingVehicle[playerid] != GetPlayerVehicleID(targetid)) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_VEH);
		ReconingVehicle[playerid] = GetPlayerVehicleID(targetid);
	}
	ReconingPlayer[playerid] = targetid;
	return 1;
}

/*
	######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
	##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
	##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
	######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
	##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
	##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
	##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
*/

/*
Public:OnCreatedBusinessFinish(playerid, bizzid, level, price, canenter, exitX, exitY, exitZ, interior, viwo, bname[])
{
	BizzInfo[bizzid][bSQLID] = cache_insert_id();
	BizzInfo[bizzid][bOwnerID] = 0;
	format(BizzInfo[bizzid][bMessage], 16, bname);
	
	return 1;
}
*/

forward OfflineBanPlayer(playerid, playername[], reason[], days);
public OfflineBanPlayer(playerid, playername[], reason[], days)
{
	new rows;
    cache_get_row_count(rows);
	if(rows)
	{
		new playerip[MAX_PLAYER_IP];
		cache_get_value_name(0, "lastip", playerip, 24);
		
		#if defined MODULE_BANS
		HOOK_BanEx(playerid, playername, playerip, playerid, reason, days);
		#endif
	}
	else return SendClientMessage(playerid, COLOR_RED, "[ERROR - MySQL]: There's no player with that nickname!");
	return 1;
}

forward OfflineJailPlayer(playerid, jailtime);
public OfflineJailPlayer(playerid, jailtime)
{
	new rows;
    cache_get_row_count(rows);
	if(rows)
	{
		new sqlid;
		cache_get_value_name_int(0,  "sqlid", sqlid);
  		mysql_fquery(g_SQL, "UPDATE player_jail SET jailed = '1', jailtime = '%d' WHERE sqlid = '%d'", 
		  	jailtime, 
			sqlid
		);
	}
	else return SendClientMessage(playerid, COLOR_RED, "[ERROR - MySQL]: There's no player with that nickname!");
	return 1;
}

stock CheckInactivePlayer(playerid, sql)
{
	new dialogstring[2056];
	inline OnInactivePlayerLoad()
	{	
		new 
			sqlid,
			startstamp,
			endstamp,
			startdate[12],
			starttime[12],
			enddate[12],
			endtime[12],
			reason[64],
			motd[150];
			
		cache_get_value_name_int(0, "sqlid"				, sqlid);
		cache_get_value_name_int(0, "startstamp"		, startstamp);
		cache_get_value_name_int(0, "endstamp"			, endstamp);
		cache_get_value_name(0, 	"reason"			, reason, 64);

		TimeFormat(Timestamp:startstamp, HUMAN_DATE, startdate);
		TimeFormat(Timestamp:startstamp, ISO6801_TIME, starttime);

		TimeFormat(Timestamp:endstamp, HUMAN_DATE, enddate);
		TimeFormat(Timestamp:endstamp, ISO6801_TIME, endtime);
		
		format(motd, sizeof(motd), "%s - [SQLID: %d] | Start Time: %s %s | End Time: %s %s | Reason: %s\n",
			ConvertSQLIDToName(sqlid),
			sqlid,
			startdate,
			starttime,
			enddate,
			endtime,
			reason
		);
		strcat(dialogstring, motd, sizeof(dialogstring));

		ShowPlayerDialog(playerid, DIALOG_INACTIVITY_CHECK, DIALOG_STYLE_MSGBOX, "Checking player inactivity:", dialogstring, "Close", "");
		return 1;
	}
	MySQL_TQueryInline(g_SQL,  
		using inline OnInactivePlayerLoad,
		va_fquery(g_SQL, "SELECT * FROM  inactive_accounts WHERE sqlid = '%d'", sql),
		"i", 
		playerid
	);
	return 1;
}

stock ListInactivePlayers(playerid)
{
	new dialogstring[2056];

	inline OnInactiveAccountsList()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows)
		{
			new 
				sqlid,
				startstamp,
				endstamp,
				startdate[12],
				starttime[12],
				enddate[12],
				endtime[12],
				reason[64],
				motd[150];
				
			for( new i = 0; i < rows; i++) 
			{
				cache_get_value_name_int(i, "sqlid"				, sqlid);
				cache_get_value_name_int(i, "startstamp"		, startstamp);
				cache_get_value_name_int(i, "endstamp"			, endstamp);
				cache_get_value_name(i, 	"reason"			, reason, 64);

				TimeFormat(Timestamp:startstamp, HUMAN_DATE, startdate);
				TimeFormat(Timestamp:startstamp, ISO6801_TIME, starttime);

				TimeFormat(Timestamp:endstamp, HUMAN_DATE, enddate);
				TimeFormat(Timestamp:endstamp, ISO6801_TIME, endtime);
				
				format(motd, sizeof(motd), "%s - [SQLID: %d] | Start Time: %s %s | End Time: %s %s | Reason: %s\n",
					ConvertSQLIDToName(sqlid),
					sqlid,
					startdate,
					starttime,
					enddate,
					endtime,
					reason
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_INACTIVITY_LIST, DIALOG_STYLE_MSGBOX, "Recent inactivities:", dialogstring, "Close", "");
			return 1;
		}
		else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "There are currently no reported inactivity in the database!");
	}
	MySQL_TQueryInline(g_SQL,  
		using inline OnInactiveAccountsList,
		va_fquery(g_SQL, "SELECT * FROM  inactive_accounts ORDER BY inactive_accounts.id DESC LIMIT 0 , 30"),
		"i", 
		playerid
	);
	return 1;
}

timer OnAdminCountDown[1000]()
{
	va_GameTextForAll("~w~%d", 1000, 4, cseconds - 1);
	
	foreach(new playerid : Player) 
	{
		PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	}
	cseconds--;
	if(!cseconds) 
	{
		count_started = false;
		GameTextForAll("~g~GO GO GO", 2500, 4);
		foreach(new playerid : Player) 
		{
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		}
		stop CountingTimer;
		return 1;
	}
	return 1;
}

forward CheckPlayerPrison(playerid, sqlid, const targetname[], minutes, const reason[]);
public CheckPlayerPrison(playerid, sqlid, const targetname[], minutes, const reason[]) 
{
    new 
		rows;
    cache_get_row_count(rows);
    if(!rows) return SendClientMessage(playerid,COLOR_RED, "That player's not in base!");
    
	new
		prisoned;
	cache_get_value_name_int(0, "jailed", prisoned);
    if(prisoned != 0) return SendClientMessage(playerid,COLOR_RED, "That player's already in area/prison!");
	
	mysql_fquery(g_SQL, "UPDATE player_jail SET jailed = '2', jailtime = '%d' WHERE sqlid = '%d'", minutes, sqlid);
		
	va_SendClientMessage(playerid,COLOR_RED, "[!] You have successfully placed the offline player %s in the arena for %d minutes.",targetname, minutes);
	return 1;
}

forward LoadPlayerWarns(playerid, targetname[],reason[]);
public LoadPlayerWarns(playerid, targetname[],reason[])
{
	new
		rows;
	cache_get_row_count(rows);
	if(!rows) return SendClientMessage(playerid,COLOR_RED,"[MySQL]: Taj igrac nije u bazi!");
	
	new
		currentwarns;
	cache_get_value_name_int(0, "playaWarns", currentwarns);
    new 
		warns = currentwarns + 1;
		
    if(warns == 3) 
	{
		OfflineBanPlayer(playerid, targetname, "3. Warn", 10);
        SendClientMessage(playerid,COLOR_RED, "[!] That player had 3 warns and he's automatically banned!");
        va_SendClientMessageToAll(COLOR_RED,"AdmCMD: %s [Offline] got banned from Game Admin %s, reason: 3. Warn",targetname,GetName(playerid,false));
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_ban.txt", "(%s) %s [OFFLINE] got banned from Game Admin %s. Reason: 3. Warn", ReturnDate(), targetname, GetName(playerid, false));
		#endif
		mysql_fquery(g_SQL, "UPDATE accounts SET playaWarns = '0' WHERE name = '%e'", targetname);
    } 
	else 
	{
		va_SendClientMessage(playerid,COLOR_RED, "[!] You have successfully warned player %s and that's his %d warn!",targetname,warns);
        mysql_fquery(g_SQL, "UPDATE accounts SET playaWarns = '%d' WHERE name = '%e'", warns, targetname);
    }
	return 1;
}

forward CheckOffline(playerid, sqlid, const name[]);
public CheckOffline(playerid, sqlid, const name[])
{
	new 
		aname[MAX_PLAYER_NAME],
		level,
		org,
		rank,
		cash,
		bank,
		housekey = INVALID_HOUSE_ID,
		bizkey = INVALID_BIZNIS_ID,
		garagekey = -1,
		admin,
		helper,
		jobkey,
		contracttime,
		warnings,
		playhrs,
		complexkey,
		cmplxroomkey;
	
	// accounts table
	cache_get_value_name(0, "name", aname, MAX_PLAYER_NAME); 	
	cache_get_value_name_int(0,"levels",level);
	cache_get_value_name_int(0,"handMoney",cash);
	cache_get_value_name_int(0,"bankMoney",bank);
	cache_get_value_name_int(0,"adminLvl",admin);
	cache_get_value_name_int(0,"helper",helper);
	cache_get_value_name_int(0,"playaWarns",warnings);
	cache_get_value_name_int(0,"connecttime",playhrs);

	// player_job table
	cache_get_value_name_int(0,"jobkey",jobkey);
	cache_get_value_name_int(0,"contracttime",contracttime);

	// player_faction table
	cache_get_value_name_int(0,"facMemId",org);
	cache_get_value_name_int(0,"facRank",rank);
	
	housekey = GetHouseFromSQL(sqlid);
	bizkey = GetBizzFromSQL(sqlid);
	garagekey = GetGarageFromSQL(sqlid);
	complexkey = GetComplexFromSQL(sqlid);
	cmplxroomkey = GetComplexRoomFromSQL(sqlid);
	
	va_SendClientMessage(playerid, COLOR_ORANGE, "Name: %s - Level: %d - Org: %s[Rank %d] - Cash: %d$ - Bank: %d$",
		aname,
		level,
		FactionInfo[org][fName],
		rank,
		cash,
		bank
	);
	va_SendClientMessage(playerid, COLOR_ORANGE, "Hours of gameplay: %d - Warns: %d - Admin Level: %d - Helper Level: %d",
		playhrs,
		warnings,
		admin,
		helper
	);
	va_SendClientMessage(playerid, COLOR_ORANGE, "Job: %s - Contract Time on job: %d hours",
		ReturnJob(jobkey),
		contracttime
	);
	va_SendClientMessage(playerid, COLOR_ORANGE, "House Key: %d - Biz Key: %d - Garage Key: %d - Complex Key: %d - Complex Room Key: %d",
		housekey,
		bizkey,
		garagekey,
		complexkey,
		cmplxroomkey
	);
    return 1;
}

forward OfflinePlayerVehicles(playerid, giveplayerid);
public OfflinePlayerVehicles(playerid, giveplayerid)
{
	new
	    cars = cache_num_rows(),
	    vehicleid = PlayerKeys[giveplayerid][pVehicleKey],
		price = cars * 150;
		
    if(cars == 0)
		return SendClientMessage(playerid, COLOR_RED, "Player has no car!");
	else
	{
	    if(GetPlayerMoney(giveplayerid) < price) return SendClientMessage(playerid, COLOR_RED, "Player does not have enough money.");
		va_SendClientMessage(playerid, COLOR_RED, "[!] You have successfully moved the parking lot of all vehicles to the player "COL_WHITE"%s"COL_YELLOW" - (%i$). ", GetName(giveplayerid, true), price);
		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Admin %s has moved the parking of all your vehicles(%i$).", GetName(playerid, true), price);
		PlayerToBudgetMoney(giveplayerid, price);
	}
	new
	    Float:x,
		Float:y,
		Float:z,
		Float:angle;

	if(IsPlayerInAnyVehicle(playerid))
	{
	    GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
	}
	else
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
	}
	
	mysql_fquery(g_SQL, 
		"UPDATE cocars SET parkX = '%f', parkY = '%f', parkZ = '%f', angle = '%f', viwo = '0' WHERE ownerid = '%d'",
		x,
		y,
		z,
		angle,
		PlayerInfo[giveplayerid][pSQLID]
	);
	
	if(vehicleid != -1) {
	    VehicleInfo[vehicleid][vParkX]	= x;
		VehicleInfo[vehicleid][vParkY]	= y;
		VehicleInfo[vehicleid][vParkZ]	= z;
		VehicleInfo[vehicleid][vAngle] 	= angle;
	}
	return 1;
}

forward LoadNamesFromIp(playerid, const ip[]);
public LoadNamesFromIp(playerid, const ip[])
{
	if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_RED, "No one logged in with an IP address: %s (DATABASE)!", ip);

	new
		dialogString[1024];
	format(dialogString, 1024, "Ime\tIP Adresa\tOnline\n");
	for(new i = 0; i < cache_num_rows(); i++) 
	{
		new
			tmpName[MAX_PLAYER_NAME],
			tmpIp[MAX_PLAYER_IP],
			tmpOnline;
		
		cache_get_value_name(i, "name", tmpName, sizeof(tmpName));
		cache_get_value_name(i, "lastip", tmpIp, sizeof(tmpIp));
		cache_get_value_name_int(i, "online", tmpOnline);
		
		format(dialogString, 1024, "%s%s\t%s\t%s\n", dialogString, tmpName, tmpIp,tmpOnline);
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "IP Address to nickname", dialogString, "Ok", "");
	return 1;
}

forward CountFactionMembers(playerid, orgid);
public CountFactionMembers(playerid, orgid)
{
	if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_RED, "[!] Faction %s has 0 members (0 is online)!", FactionInfo[orgid][fName]);
	
	new activeMembers = 0;
	foreach(new i : Player)
	{
		if(PlayerFaction[i][pMember] == orgid || PlayerFaction[i][pLeader] == orgid)
			activeMembers++;
	}
	
	va_SendClientMessage(playerid, COLOR_RED, "[!] Faction %s has %d members (%d is online)!", FactionInfo[orgid][fName], cache_num_rows(), activeMembers);
	return 1;
}

forward CheckPlayerData(playerid, const name[]);
public CheckPlayerData(playerid, const name[])
{
	if(cache_num_rows()) 
	{
		new sqlid;
		cache_get_value_name_int(0, "sqlid", sqlid);
		
		mysql_tquery(g_SQL, 
			va_fquery(g_SQL, "SELECT * FROM player_connects WHERE player_id = '%d' ORDER BY time DESC LIMIT 1", sqlid), 
			"CheckLastLogin", 
			"is", 
			playerid, 
			name
		);
	}
	else SendClientMessage(playerid, COLOR_RED, "That nickname does not exist in database.");
	
	return 1;
}

forward CheckLastLogin(playerid, const name[]);
public CheckLastLogin(playerid, const name[])
{
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_RED, "Player never logged in!");
	
	new lastip[MAX_PLAYER_IP], lastdate, date[12], time[12];
	cache_get_value_name_int(0, 	"time"	, lastdate);
	cache_get_value_name(0,			"aip"	, lastip, MAX_PLAYER_IP);

	TimeFormat(Timestamp:lastdate, HUMAN_DATE, date);
	TimeFormat(Timestamp:lastdate, ISO6801_TIME, time);
	
	if(PlayerInfo[playerid][pAdmin])
	{
		va_SendClientMessage(playerid, COLOR_RED, "[!] Last time player %s was online: %s - %s, with an IP: %s.", 
			name,
			date,
			time,
			lastip
		);
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_RED, "[!] Last time player %s was online: %d.%d.%d - %d:%d:%d", 
			name,
			date[2],
			date[1],
			date[0],
			date[3],
			date[4],
			date[5]
		);
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

timer OnPlayerReconing[1000](playerid, targetid)
{
	if(Bit4_Get(gr_SpecateId, playerid) == PLAYER_SPECATE_VEH) {
		if(!IsPlayerInAnyVehicle(targetid)) {
			SetPlayerInterior(playerid, GetPlayerInterior(targetid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
			PlayerSpectatePlayer(playerid, targetid);
			Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_PLAYER);
		}
	}
	else if(Bit4_Get(gr_SpecateId, playerid) == PLAYER_SPECATE_PLAYER) {		
		if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid)) {
			SetPlayerInterior(playerid		, GetPlayerInterior(targetid));
			SetPlayerVirtualWorld(playerid	, GetPlayerVirtualWorld(targetid));
			PlayerSpectatePlayer(playerid, targetid);
		}
	}
	UpdateTargetReconData(playerid, targetid);
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

hook function LoadPlayerStats(playerid)
{
    LoadPlayerAdminMessage(playerid);
	return continue(playerid);
}

hook function SavePlayerStats(playerid)
{
    SavePlayerAdminMessage(playerid);
	return continue(playerid);
}

hook OnPlayerConnect(playerid)
{
	InitFly(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(SafeSpawned[playerid])
    {
        mysql_fquery(g_SQL, "UPDATE player_admin_msg SET AdminMessage = '', AdminMessageBy = '', AdmMessageConfirm = '0' \n\
            WHERE sqlid = '%d'", 
            PlayerInfo[playerid][pSQLID]
       );
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    PlayerAdminMessage[playerid][pAdminMsg][0] = EOS;
    PlayerAdminMessage[playerid][pAdminMsgBy][0] = EOS;
    PlayerAdminMessage[playerid][pAdmMsgConfirm] = false;

    ResetAdminVehVars(playerid);

	// 32bit
	stop LearnTimer[playerid];
	ReconingVehicle[playerid]	= INVALID_VEHICLE_ID;
	ReconingPlayer[playerid]	= INVALID_PLAYER_ID;
	stop ReconTimer[playerid];
	AdminLoginTry[playerid] = 0;
	PortedPlayer[playerid] = -1;

	AdminDuty[playerid] = false;
	HelperDuty[playerid] = false;
	NeedHelp[playerid] = false;	

	Bit1_Set(a_PlayerReconed, playerid, false);
    Bit1_Set(a_AdminChat, playerid, false);
    Bit1_Set(a_PMears, playerid, false);
    Bit1_Set(a_AdNot, playerid, false);
    Bit1_Set(a_REars, playerid, false);
	Bit1_Set(a_BHears, playerid, false);
    Bit1_Set(a_DMCheck, playerid, false);
	Bit1_Set(a_BlockedHChat, playerid, false);
	Bit1_Set(a_TogReports, playerid, false);

	if(IsPlayerReconing(playerid)) 
	{
		stop ReconTimer[playerid];
		DestroyReconTextDraws(playerid);
		Bit4_Set(gr_SpecateId, playerid, 0);
	}
	return continue(playerid);
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(GetPlayerState(playerid) == 2)
        {
            new carid;
            carid=GetPlayerVehicleID(playerid);
            SetVehiclePos(carid,fX,fY,MapAndreas_FindZ_For2DCoord(fX,fY,fZ));
        }
        else SetPlayerPosFindZ(playerid, fX, fY, fZ);
        SendClientMessage(playerid, COLOR_RED, "[!] Since I'm not a military analyst, it may not be very accurate.");
    }
    return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		va_SendClientMessage(playerid, COLOR_RED, "[!] %s (%d)", GetName(clickedplayerid,false), clickedplayerid);
		va_SendClientMessage(playerid, 0xC9C9C9FF, "IC:  Money: [%d$] - Bank: [%d$] - Mob: [%d] - Org: [%s] - Rank: [%s (%d)]",
			PlayerInfo[clickedplayerid][pMoney],
			PlayerInfo[clickedplayerid][pBank],
			PlayerMobile[clickedplayerid][pMobileNumber],
			ReturnPlayerFactionName(clickedplayerid),
			ReturnPlayerRankName(clickedplayerid),
			PlayerFaction[clickedplayerid][pRank]
		);
		
		va_SendClientMessage(playerid, 0xC9C9C9FF, "OOC: Lvl: [%d] - Hours: [%d] - Warn: [%d/3] - Jail: [%d] - Jailtime: [%d]",
			PlayerInfo[clickedplayerid][pLevel],
			PlayerInfo[clickedplayerid][pConnectTime],
			PlayerInfo[clickedplayerid][pWarns],
			PlayerJail[clickedplayerid][pJailed],
			PlayerJail[clickedplayerid][pJailTime]
		);
		if(PlayerKeys[clickedplayerid][pBizzKey] != INVALID_BIZNIS_ID)
		{
			new 
				biznis = GetBizzFromSQL(PlayerInfo[clickedplayerid][pSQLID]);
			va_SendClientMessage(playerid, 0xCED490FF, "BIZ: ID: [%d] - Name: [%s] ", biznis, BizzInfo[biznis][bMessage]);
		}	
	}

}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER) strmid(LastDriver[GetPlayerVehicleID(playerid)], GetName(playerid,false), 0, strlen(GetName(playerid,false)), 255);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(PlayerInfo[playerid][pAdmin] > 0)
	{
		Bit1_Set(a_AdminChat, playerid, true);
		Bit1_Set(a_TogReports, playerid, false);
	}
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_JAIL_GETHERE:
		{
			if(!response) return 1;
			new
				Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			if(GetPlayerState(PortedPlayer[playerid]) == 2) {
				new tmpcar = GetPlayerVehicleID(PortedPlayer[playerid]);
				SetVehiclePos(tmpcar, X, Y+4, Z);
			} else {
				SetPlayerPos(PortedPlayer[playerid], X, Y+2, Z);
				SetPlayerInterior(PortedPlayer[playerid], GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(PortedPlayer[playerid], GetPlayerVirtualWorld(playerid));
			}
            new string[100];
			format(string, sizeof(string), "You've been teleported by an admin/helper %s", GetName(playerid,false));
			SendClientMessage(PortedPlayer[playerid], COLOR_GREY, string);
			format(string, sizeof(string), "You teleported %s, ID %d", GetName(PortedPlayer[playerid],false), PortedPlayer[playerid]);
			SendClientMessage(playerid, COLOR_GREY, string);
			return 1;
		}
		case DIALOG_ADMIN_MSG:
        {
	        PlayerAdminMessage[playerid][pAdmMsgConfirm] = true;
   			return 1;
        }
	}
	return 0;
}