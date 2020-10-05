#include <YSI\y_hooks>

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
	CreatedCar	= 0,
	Admin_Vehicle[MAX_PLAYERS][MAX_ADMIN_VEHICLES],
	Admin_vCounter[MAX_PLAYERS];

static stock
    globalstring[128],
	mysqlquery[256],
    cstring[40];

new
	CountingTimer,
	cseconds,
	LearnTimer[MAX_PLAYERS] = -1,
	LastDriver[MAX_VEHICLES][MAX_PLAYER_NAME],
	ReconingVehicle[MAX_PLAYERS],
	ReconingPlayer[MAX_PLAYERS],
	ReconTimer[MAX_PLAYERS],
	AdminLoginTry[MAX_PLAYERS],
    oldskin[MAX_PLAYERS],
	PortedPlayer[MAX_PLAYERS],
	
	// Player
	Bit1: 	a_PlayerReconed	<MAX_PLAYERS>,
    Bit1: 	a_AdminChat 	<MAX_PLAYERS>,
    Bit1: 	a_PMears 		<MAX_PLAYERS>,
    Bit1:   a_AdNot         <MAX_PLAYERS>,
    Bit1: 	a_REars 		<MAX_PLAYERS>,
	Bit1: 	a_BHears 		<MAX_PLAYERS>,
    Bit1: 	a_DMCheck 		<MAX_PLAYERS>,
    Bit1: 	a_AdminOnDuty 	<MAX_PLAYERS>,
	Bit1: 	h_HelperOnDuty 	<MAX_PLAYERS>,
	Bit1:	a_BlockedHChat	<MAX_PLAYERS>,
	Bit1:	a_NeedHelp		<MAX_PLAYERS>,
	Bit1:	a_TogReports	<MAX_PLAYERS>;
	
// TextDraws
static stock 
	PlayerText:ReconBack[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconBcg1[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconTitle[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... },
	PlayerText:ReconText[MAX_PLAYERS]	= { PlayerText:INVALID_TEXT_DRAW, ... };
/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  & Timers
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

ShowPlayerCars(playerid, playersqlid, player_name[])
{
	new mysqlQuery[128], owner_name[MAX_PLAYER_NAME];
	SetString(owner_name, player_name);
	format(mysqlQuery, 128, "SELECT * FROM cocars WHERE `ownerid` = '%d' LIMIT 10", playersqlid);
	inline OnLoadPlayerVehicles()
	{
		new 
			tmpModelID,
			tmpCarMysqlID,
			vehName[ 32 ];
		va_SendClientMessage(playerid, COLOR_RED, "[ %s's Vehicle List ]:", owner_name);	
		for( new i = 0; i < cache_num_rows(); i++) {
			cache_get_value_name_int(i, "id", tmpCarMysqlID);
			cache_get_value_name_int(i, "modelid", tmpModelID);
			
			strunpack(vehName, Model_Name(tmpModelID) );
			va_SendClientMessage(playerid, COLOR_WHITE,"[slot %d] %s [MySQL ID: %d].", i+1, vehName, tmpCarMysqlID);
		}
		if(!cache_num_rows()) 
			SendClientMessage(playerid, COLOR_WHITE,"- Ovaj igrac ne posjeduje vozila.");
	}
	mysql_tquery_inline(g_SQL, mysqlQuery, using inline OnLoadPlayerVehicles, "");
	return 1;
}

stock ABroadCast(color,const string[],level)
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level)
			SendClientMessage(i, color, string);
	}
	return 1;
}

va_ABroadCast(color, const string[], level, va_args<>)
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level)
			SendClientMessage(i, color, va_return(string, va_start<3>));
	}
	return 1;
}

stock REarsBroadCast(color,const string[], level)
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_REars, i))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendHelperMessage(color,const string[],level)
{
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pHelper] >= level)
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
		if( PlayerInfo[i][pAdmin] >= level)
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
		if (PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_PMears, i))
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
		if (PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_BHears, i))
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
		if( ( PlayerInfo[i][pAdmin] >= level || PlayerInfo[i][pHelper] >= level || IsPlayerAdmin(i)) && Bit1_Get( a_AdminChat, i ) )
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
		if( PlayerInfo[i][pAdmin] >= level && Bit1_Get( a_AdminChat, i ) )
  		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendAdminMessage(color, string[])
{
	foreach (new i : Player)
	{
		if( PlayerInfo[i][pAdmin] >= 1 && Bit1_Get( a_AdminChat, i ) )
			SendClientMessage(i, color, string);
	}
}

stock SendAdminNotification(color, string[])
{
	foreach (new i : Player)
	{
		if( PlayerInfo[i][pAdmin] >= 1 && Bit1_Get( a_AdminChat, i ) )
			SendMessage(i, color, string);
	}
}


stock DMERSBroadCast(color, const string[], level)
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level && Bit1_Get(a_DMCheck, i))
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
	    if (strsrc[i] == delimiter || i == strlen(strsrc))
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
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] [ADMIN-VEH (%d)]: %d id.", i, Admin_Vehicle[playerid][i]);
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

DestroyAdminVehicle(admin, carid) {
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

/*
	d8888b. d88888b  .o88b.  .d88b.  d8b   db 
	88  `8D 88'     d8P  Y8 .8P  Y8. 888o  88 
	88oobY' 88ooooo 8P      88    88 88V8o 88 
	88`8b   88~~~~~ 8b      88    88 88 V8o88 
	88 `88. 88.     Y8b  d8 `8b  d8' 88  V888 
	88   YD Y88888P  `Y88P'  `Y88P'  VP   V8P 
*/

stock DestroyReconTextDraws(playerid)
{
	if( ReconBcg1[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, ReconBcg1[ playerid ]);
		ReconBcg1[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( ReconBack[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, ReconBack[ playerid ]);
		ReconBack[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( ReconTitle[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, ReconTitle[ playerid ]);
		ReconTitle[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
	}
	if( ReconText[ playerid ] != PlayerText:INVALID_TEXT_DRAW ) {
		PlayerTextDrawDestroy(playerid, ReconText[ playerid ]);
		ReconText[ playerid ] = PlayerText:INVALID_TEXT_DRAW;
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

	ReconText[playerid] = CreatePlayerTextDraw(playerid, 254.9, 339.1, "~y~Novac: 500~g~$~y~~n~Health: 60.0~n~Armour: 0.0~n~Package loss: 0.0%~n~Vehicleid: 550~n~FPS: 55~n~Ping: 55");
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

stock static SetPlayerReconTarget(playerid, targetid)
{
	new
		Float:targetHealth,
		Float:targetArmour,
		tmpString[ 130 ];

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
	
	CreateReconTextDraws(playerid);
	PlayerTextDrawSetString(playerid, ReconText[playerid], tmpString);
	format(tmpString, sizeof(tmpString), "%s(%d)", GetName(targetid, false), targetid);
	PlayerTextDrawSetString(playerid, ReconTitle[playerid], tmpString);
	Bit1_Set( a_PlayerReconed, playerid, true );
	
	ReconTimer[playerid] = SetTimerEx("OnPlayerReconing", 1000, true, "ii", playerid, targetid);
	return 1;
}

Function: LearnPlayer(playerid, learnid)
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
			SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je RolePlay ? â€˘");
		  	SendClientMessage(playerid, COLOR_WHITE, " ");
		  	SendClientMessage(playerid, COLOR_WHITE, "Roleplay je simulacija stvarnoga zivota. ");
		    SendClientMessage(playerid, COLOR_WHITE, "Pri takvoj igrici, vazno je dobro poznavati RolePlay pravila. ");
		    SendClientMessage(playerid, COLOR_WHITE, "Pozeljno je da sto vise vremena provodite u RolePlayu.");
		    SendClientMessage(playerid, COLOR_WHITE, "Kvalitetnim RolePlayom,povecava Vam se sansa za uspjeh na serveru. ");
		    SendClientMessage(playerid, COLOR_WHITE, "Ukoliko ste novi igrac, Vi lako mozete nauciti RolePlay pravila.");
			KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 28000, 0, "ii", playerid, 2);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ RolePlay terminologija â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Obzirom da je ovo Hardcore RolePlay server, postuju se i RolePlay pravila!");
	        SendClientMessage(playerid, COLOR_WHITE, "Neki RolePlay termini su Vam vec poznati?");
	        SendClientMessage(playerid, COLOR_WHITE, "Kroz ovaj kratak tutorial, dobit' cete uvid u osnovne termine RolePlaya.");
	        SendClientMessage(playerid, COLOR_WHITE, "Krenimo polako !");
		    KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 25000, 0, "ii", playerid, 3);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ In Character i Out of Character(OOC) Chat â€˘");
			SendClientMessage(playerid, COLOR_WHITE," ");
	   		SendClientMessage(playerid, COLOR_WHITE, "Vrlo je vazno znati razliku izmedju ova dva chata.");
			SendClientMessage(playerid, COLOR_WHITE," ");
	        SendClientMessage(playerid, COLOR_WHITE, "In Character (IC) je vezan direktno za Vasega lika, kojega glumite u igri. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Unutar IC chata, ne smije postojati stvari iz Vasega privatnog zivota i ostale OOC stvari.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer IC chata: 'Dobar dan, zovem se Mike. Odakle dolazite gospodine?')");
	       	SendClientMessage(playerid, COLOR_WHITE, "In Character tekstovi su /phone, /sms, /ct, /c, /w, /s.");
			SendClientMessage(playerid, COLOR_WHITE," ");
	       	SendClientMessage(playerid, COLOR_WHITE, "Out of Character(OOC) je vezan za stvari koje nisu direktno povezane s Vama u igrici.");
	       	SendClientMessage(playerid, COLOR_WHITE, "Primjer OOC chata: '/b Jesi pogledao novu temu na forumu? Tko su admini na ovome serveru?'");
			KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 30000, 0, "ii", playerid, 4);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je to MetaGaming(MG)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Metagaming je koristenje Out of Character (OOC) informacija u In Character (IC) svrhe.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer Metagaminga je koristenje necijega imena, bez da ste to na RolePlay nacin saznali.");
	        SendClientMessage(playerid, COLOR_WHITE, "Kada ugledate ime igraca na serveru, iznad njegove glave, Vi njegovo ime ne znate, sve dok Vam ga on ne kaze.");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer, ukoliko vidite osobu u odjeci bande/mafie, nemate pravo toj osobi iznositi da je pripadnik ilegalne organizacije.");
	        SendClientMessage(playerid, COLOR_WHITE, "Metagaming je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
			KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 30000, 0, "ii", playerid, 5);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je to PowerGaming(PG)? â€˘");
			SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Powergaming je odradjivanje radnje koju u stvarnom zivotu ne mozete odraditi. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Naime, radnja koju ne mozete izvrsiti ili u odredjenom momentu ili uopce ne mozete izvrsiti tu radnju. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Najbolji opis Powergaminga se moze vidjeti ukoliko Vas netko zeli opljackati, prijeti oruzjem - Vi skocite iz auta i krente bjezati.");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer, ukoliko padnete sa odredjene visine i nastavite se normalno kretati.");
	        SendClientMessage(playerid, COLOR_WHITE, "PowerGaming je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		    KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 30000, 0, "ii", playerid, 6);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je to Bunnyhop(BH)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop je ucestalo skakanje prilikom Vasega kretanja.");
			SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop se koristi kako bi se ubrzali, sto nikako nije RolePlay.");
			SendClientMessage(playerid, COLOR_WHITE, "Bunnyhop je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
			KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 17000, 0, "ii", playerid, 7);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je to Revenge Kill(RK)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Revenge Kill je ubojstvo iz osvete.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer Revenge Killa je kada Vas netko ubije, Vi se usredotocite na to da nabavite oruzje i ubijete natrag tu osobu.");
	        SendClientMessage(playerid, COLOR_WHITE, "Kada se dogodi PK, Vi zaboravljate situaciju u kojoj ste se nasli, te ljude koji su Vas ubili!");
			SendClientMessage(playerid, COLOR_WHITE, "Revenge Kill je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		    KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 22000, 0, "ii", playerid, 8);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ /me i /ame /do komanda? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, "");
	        SendClientMessage(playerid, COLOR_RED, "[ ! ] /me - komanda koja se koristi za trenutnu radnju Vaseg IC karaktera koja se dogodila u trenutku. ");
	        SendClientMessage(playerid, COLOR_WHITE, "Naravno, /me komanda ne smije biti koristena kako bi se izvukli iz nekog RolePlaya.");
	        SendClientMessage(playerid, COLOR_WHITE, "Primjer: /me uzima sok sa stola te ispija gutljaj.");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] /ame - komanda koja se koristi za trenutnu radnju Vaseg IC karaktera i koja poslje odredjenog vremena i dalje traje.");
			SendClientMessage(playerid, COLOR_WHITE, "Primjer: /ame se osmjehuje, /ame klima glavom potvrdno, /ame se naslanja na zid.");
			SendClientMessage(playerid, COLOR_RED, "[ ! ] /do - komanda kojom se opisuje trenutna IC situacija.");
			SendClientMessage(playerid, COLOR_WHITE, " /do se pise u trecem licu odnosno u pogledu posmatraca, moze opisivati i okolinu.");
			SendClientMessage(playerid, COLOR_WHITE, "Primjer: Sta bi se nalazilo ispred Johnnya na stolu? (( Patricia Vargas ))");
		    KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = SetTimerEx("LearnPlayer", 23000, 0, "ii", playerid, 9);
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
		 	SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ Sto je to Drive By(DB)? â€˘");
	   		SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Drive By je pucanje oruzjem s mjesta vozaca iz bilo kojeg mjesta u vozilu na civile, motore ili bicikle.");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer je zabranjeno ubijanje propelerom helikoptera i gazenje igraca vozilom.");
	        SendClientMessage(playerid, COLOR_WHITE, "Drive By je strogo kaznjiv kao i svako ostalo krsenje RolePlay pravila.");
		    KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = LearnTimer[playerid] = SetTimerEx("LearnPlayer", 23000, 0, "ii", playerid, 10);
		}
		else if(learnid == 10)
		{
			KillTimer(LearnTimer[playerid]);
			LearnTimer[playerid] = -1;
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
			SendClientMessage(playerid, COLOR_GREY," ");
	   		SendClientMessage(playerid, COLOR_RED, "[ ! ] â€˘ KRAJ TUTORIALA â€˘");
	        SendClientMessage(playerid, COLOR_WHITE, " ");
	        SendClientMessage(playerid, COLOR_WHITE, "Nadamo se da ste naucili nesto iz nasega tutoriala!");
	        SendClientMessage(playerid, COLOR_WHITE, "Takodjer se nadamo, da vise necete krsiti RolePlay pravila.");
	        SendClientMessage(playerid, COLOR_WHITE, "Uskoro slijedi kviz od deset pitanja.");
	        SendClientMessage(playerid, COLOR_WHITE, "Mozete maksimalno dati krivi odgovor dva puta na jedno pitanje.");
			StartKnowledgeQuiz(playerid);

		}
	}
	return 1;
}

stock static UpdateTargetReconData(playerid, targetid)
{
	new
		Float:targetHealth,
		Float:targetArmour,
		tmpString[ 130 ];

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

	if( ReconingVehicle[ playerid ] != GetPlayerVehicleID(targetid) ) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_VEH );
		ReconingVehicle[ playerid ] = GetPlayerVehicleID(targetid);
	}
	ReconingPlayer[ playerid ] = targetid;
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
Function: OnCreatedBusinessFinish(playerid, bizzid, level, price, canenter, exitX, exitY, exitZ, interior, viwo, bname[])
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
	else return SendClientMessage(playerid, COLOR_RED, "[GRESKA - MySQL]: Ne postoji korisnik s tim nickom!");
	return 1;
}

forward AddAdminMessage(playerid, user_name[], reason[]);
public AddAdminMessage(playerid, user_name[], reason[])
{
	new rows, query[4096], string[128];
	
    cache_get_row_count(rows);
	if (rows)
	{
		new
			on;

		cache_get_value_name_int(0, "online" , on);
		
		if(on)
		{
			sscanf(user_name, "u", on);
			
			if(on != INVALID_PLAYER_ID && IsPlayerConnected(on) && SafeSpawned[on])
			{
				va_SendClientMessage(on, COLOR_NICEYELLOW, "(( PM od %s[%d]: %s ))", 
					GetName(playerid, false), 
					playerid, 
					reason
				);
				va_SendClientMessage(playerid, COLOR_RED, "(( PM za %s[%d]: %s ))", 
					user_name, 
					on, 
					reason
				);
				SendClientMessage(playerid, COLOR_RED, "[!] Navedeni korisnik je bio in-game te mu je poslana poruka.");
				
				return 1;
			}
		}	
		mysql_format( g_SQL, query, sizeof(query), "UPDATE `accounts` SET `AdminMessage` = '%e', `AdminMessageBy` = '%e', `AdmMessageConfirm` = '0' WHERE `name` = '%e'",
			reason, GetName(playerid, true), user_name);
		mysql_tquery(g_SQL, query, "", "");

		format(string, sizeof(string), "[!] Navedeni korisnik ce sada dobiti vasu notifikaciju prilikom logina.");
		SendClientMessage(playerid, COLOR_RED, string);
	}
	else return SendClientMessage(playerid, COLOR_RED, "[GRESKA - MySQL]: Ne postoji korisnik s tim nickom!");
	
	return 1;
}

Function: SendServerMessage(sqlid, reason[])
{
	new query[4096];
	mysql_format( g_SQL, query, sizeof(query), "UPDATE `accounts` SET `AdminMessage` = '%e', `AdminMessageBy` = 'Server', `AdmMessageConfirm` = '0' WHERE `sqlid` = '%d'",
		reason, 
		sqlid
	);
	mysql_tquery(g_SQL, query, "", "");
}

forward OfflineJailPlayer(playerid, playername[], jailtime);
public OfflineJailPlayer(playerid, playername[], jailtime)
{
	new rows;
    cache_get_row_count(rows);
	if(rows)
	{
  		new TmpQuery[ 256 ];
		mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `jailed` = '1', `jailtime` = '%d' WHERE `name` = '%e'", jailtime, playername);
		mysql_tquery(g_SQL, TmpQuery, "", "");
	}
	else return SendClientMessage(playerid, COLOR_RED, "[GRESKA - MySQL]: Ne postoji korisnik s tim nickom!");
	return 1;
}

stock CheckInactivePlayer(playerid, sql)
{
	new tmpQuery[128], dialogstring[2056];
	format(tmpQuery, sizeof(tmpQuery), "SELECT * FROM  `inactive_accounts` WHERE `sqlid` = '%d' LIMIT 0,1", sql);
	inline OnInactivePlayerLoad()
	{	
		new 
			sqlid,
			startstamp,
			endstamp,
			startdate[6],
			enddate[6],
			reason[64],
			motd[150];
			
		cache_get_value_name_int(0, "sqlid"				, sqlid);
		cache_get_value_name_int(0, "startstamp"		, startstamp);
		cache_get_value_name_int(0, "endstamp"			, endstamp);
		cache_get_value_name(0, 	"reason"			, reason, 64);

		stamp2datetime(startstamp, startdate[0], startdate[1] ,startdate[2], startdate[3], startdate[4], startdate[5]);
		stamp2datetime(endstamp, enddate[0], enddate[1] ,enddate[2], enddate[3], enddate[4], enddate[5]);
		
		format(motd, sizeof(motd), "%s - [SQLID: %d] | Pocetak: %02d/%02d/%02d %02d:%02d:%02d | Traje do: %02d/%02d/%02d %02d:%02d:%02d | Razlog: %s\n",
			GetPlayerNameFromSQL(sqlid),
			sqlid,
			startdate[2],
			startdate[1],
			startdate[0],
			startdate[3],
			startdate[4],
			startdate[5],
			enddate[2],
			enddate[1],
			enddate[0],
			enddate[3],
			enddate[4],
			enddate[5],
			reason
		);
		strcat(dialogstring, motd, sizeof(dialogstring));

		ShowPlayerDialog(playerid, DIALOG_INACTIVITY_CHECK, DIALOG_STYLE_MSGBOX, "Provjera neaktivnosti igraca:", dialogstring, "Zatvori", "");
		return 1;
	}
	mysql_tquery_inline(g_SQL, tmpQuery, using inline OnInactivePlayerLoad, "i", playerid);
	return 1;
}

stock ListInactivePlayers(playerid)
{
	new tmpQuery[128], dialogstring[2056];
	format(tmpQuery, sizeof(tmpQuery), "SELECT * FROM  `inactive_accounts` ORDER BY `inactive_accounts`.`id` DESC LIMIT 0 , 30");
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
				startdate[6],
				enddate[6],
				reason[64],
				motd[150];
				
			for( new i = 0; i < rows; i++ ) 
			{
				cache_get_value_name_int(i, "sqlid"				, sqlid);
				cache_get_value_name_int(i, "startstamp"		, startstamp);
				cache_get_value_name_int(i, "endstamp"			, endstamp);
				cache_get_value_name(i, 	"reason"			, reason, 64);

				stamp2datetime(startstamp, startdate[0], startdate[1] ,startdate[2], startdate[3], startdate[4], startdate[5]);
				stamp2datetime(endstamp, enddate[0], enddate[1] ,enddate[2], enddate[3], enddate[4], enddate[5]);
				
				format(motd, sizeof(motd), "%s - [SQLID: %d] | Pocetak: %02d/%02d/%02d %02d:%02d:%02d | Traje do: %02d/%02d/%02d %02d:%02d:%02d | Razlog: %s\n",
					GetPlayerNameFromSQL(sqlid),
					sqlid,
					startdate[2],
					startdate[1],
					startdate[0],
					startdate[3],
					startdate[4],
					startdate[5],
					enddate[2],
					enddate[1],
					enddate[0],
					enddate[3],
					enddate[4],
					enddate[5],
					reason
				);
				strcat(dialogstring, motd, sizeof(dialogstring));
			}
			ShowPlayerDialog(playerid, DIALOG_INACTIVITY_LIST, DIALOG_STYLE_MSGBOX, "Najnovije neaktivnosti:", dialogstring, "Zatvori", "");
			return 1;
		}
		else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno nema prijavljenih neaktivnosti u bazi podataka!");
	}
	mysql_tquery_inline(g_SQL, tmpQuery, using inline OnInactiveAccountsList, "i", playerid);
	return 1;
}

/*
Function: ChargePlayer(playerid, const targetname[], money)
{
	new rows;
    cache_get_row_count(rows);
	if( rows ) {
		new playerMoney;
		cache_get_value_name_int(0, "handMoney", playerMoney);
		playerMoney -= money;
		
		new
			TmpQuery[ 128 ];
		mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `handMoney` = '%d' WHERE `name` = '%e'", playerMoney, targetname);
		mysql_tquery(g_SQL, TmpQuery, "", "");
	}
	else return SendClientMessage(playerid, COLOR_RED, "[GRESKA - MySQL]: Ne postoji korisnik s tim nickom!");
	return 1;
}

forward ChargepPlayer(playerid, const tagername[], Float:percent, const reason[]);
public ChargepPlayer(playerid, const tagername[], Float:percent, const reason[])
{
	new rows;
    cache_get_row_count(rows);
	if( rows ) {
		new playerMoney, ank;
		cache_get_value_name_int(0, "handMoney", playerMoney);
		cache_get_value_name_int(0, "bankMoney", ank);
		
		va_SendClientMessageToAll(COLOR_RED, "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", 
			GetName(playerid,false), 
			tagername, 
			floatround(( ank + playerMoney ) * percent), 
			reason
		);
		
		playerMoney -= floatround(( playerBank + playerMoney ) * percent);

		new
			TmpQuery[ 128 ];
		mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `handMoney` = '%d' WHERE `name` = '%e'", playerMoney, tagername);
		mysql_tquery(g_SQL, TmpQuery, "", "");
	}
	else return SendClientMessage(playerid, COLOR_RED, "Ne postoji korisnik s tim nickom!");
	return 1;
}*/

forward OnAdminCountDown();
public OnAdminCountDown()
{
	va_GameTextForAll("~w~%d", 1000, 4, cseconds - 1);
	
	foreach(new playerid : Player) {
		PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	}
	cseconds--;
	if( !cseconds ) {
		count_started = false;
		GameTextForAll("~g~GO GO GO", 2500, 4);
		foreach(new playerid : Player) {
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		}
		KillTimer(CountingTimer);
		return 1;
	}
	return 1;
}

forward CheckPlayerPrison(playerid, const targetname[], minutes, const reason[]);
public CheckPlayerPrison(playerid, const targetname[], minutes, const reason[])
{
    new 
		rows;
    cache_get_row_count(rows);
    if(!rows) return SendClientMessage(playerid,COLOR_RED, "Taj igrac nije u bazi!");
    
	new
		prisoned;
	cache_get_value_name_int(0, "jailed", prisoned);
    if(prisoned != 0) return SendClientMessage(playerid,COLOR_RED, "Taj igrac je vec u arei/zatvoru!");
	
	mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "UPDATE `accounts` SET `jailed` = '2',`jailtime` = '%d' WHERE `name` = '%e' LIMIT 1", minutes, targetname);
	mysql_tquery(g_SQL, mysqlquery, "", "");
		
	va_SendClientMessage(playerid,COLOR_RED, "[ ! ] Uspjesno si smjestio offline igraca '%s' u areu na %d minuta.",targetname, minutes);
	return 1;
}

forward LoadPlayerWarns(playerid, targetname[],reason[]);
public LoadPlayerWarns(playerid, targetname[],reason[])
{
	new
		rows;
	cache_get_row_count(rows);
	if( !rows ) return SendClientMessage(playerid,COLOR_RED,"[MySQL]: Taj igrac nije u bazi!");
	
	new
		currentwarns;
	cache_get_value_name_int(0, "playaWarns", currentwarns);
    new 
		warns = currentwarns + 1;
		
    if(warns == 3) {
		OfflineBanPlayer(playerid, targetname, "3. Warn", 10);
        SendClientMessage(playerid,COLOR_RED, "[ ! ] Taj igrac je imao 3. warna te je automatski banan!");
        va_SendClientMessageToAll(COLOR_RED,"AdmCMD: %s [Offline] je dobio ban od admina %s, razlog: 3. Warn",targetname,GetName(playerid,false));
        format(globalstring, sizeof(globalstring),"%s [OFFLINE] je dobio ban od admina %s, razlog: 3. Warn", targetname, GetName(playerid, false));
		#if defined MODULE_LOGS
		LogAdminBan(globalstring);
		#endif
		mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "UPDATE `accounts` SET `playaWarns` = '0' WHERE `name` = '%e' LIMIT 1", targetname);
        mysql_tquery(g_SQL, mysqlquery, "", "");
    } else {
		va_SendClientMessage(playerid,COLOR_RED, "[ ! ] Uspjesno si warnao igraca %s, te mu je to ukupno %d warn!",targetname,warns);
        mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "UPDATE `accounts` SET `playaWarns` = '%d' WHERE `name` = '%e' LIMIT 1", warns, targetname);
        mysql_tquery(g_SQL, mysqlquery, "", "");
    }
	return 1;
}

forward CheckOffline(playerid, const name[]);
public CheckOffline(playerid, const name[])
{
	new
		rowsCount;
	cache_get_row_count(rowsCount);
	if(!rowsCount)
		return SendClientMessage(playerid, COLOR_RED, "[MySQL]: Taj igrac nije u bazi!");
	
	new 
		temp[ 64 ],
		sqlid,
		aname[MAX_PLAYER_NAME],
		level,
		organizacija,
		gotovina,
		banka,
		donatorrank,
		housekey = 9999,
		bizkey = 999,
		garagekey = -1,
		admin,
		jobkey,
		warnings,
		playhrs,
		complexkey,
		cmplxroomkey;
	
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_get_value_name(0,"name", temp); 	
	format(aname,sizeof(aname),"%s",temp);
	
	cache_get_value_name_int(0,"levels",level);
	cache_get_value_name_int(0,"facMemId",organizacija);
	cache_get_value_name_int(0,"handMoney",gotovina);
	cache_get_value_name_int(0,"bankMoney",banka);
	cache_get_value_name_int(0,"vipRank",donatorrank);
	
	cache_get_value_name_int(0,"adminLvl",admin);
	cache_get_value_name_int(0,"jobkey",jobkey);
	cache_get_value_name_int(0,"playaWarns",warnings);
	cache_get_value_name_int(0,"connecttime",playhrs);
	
	foreach(new biznis : Bizzes) 
	{
		if(BizzInfo[biznis][bOwnerID] == sqlid) 
		{
			bizkey = biznis;
			break;
		}
	}
	
	foreach(new house : Houses) 
	{
		if(HouseInfo[house][hOwnerID] == sqlid) 
		{
			housekey = house;
			break;
		}
	}
	
	foreach(new complexr : ComplexRooms)
	{
		if(ComplexRoomInfo[complexr][cOwnerID] == sqlid) {
			cmplxroomkey = complexr;
			break;
		}
	}
	
	for(new garage=0; garage < MAX_GARAGES; garage++) 
	{
		if(GarageInfo[ garage ][ gOwnerID ] == sqlid) 
		{
			garagekey = garage;
			break;
		}
	}	
	
	foreach(new complex : Complex)
	{
		if(ComplexInfo[complex][cOwnerID] == sqlid) 
		{
			complexkey = complex;
			break;
		}
	}
	
	va_SendClientMessage(playerid, COLOR_ORANGE, "Ime: %s - Level: %d - Org: %d - Novac: %d$ - Banka: %d$ - Donator Rank: %d",
		aname,
		level,
		organizacija,
		gotovina,
		banka,
		donatorrank
	);
	va_SendClientMessage(playerid, COLOR_ORANGE, "Sati igranja: %d - Posao: %d - Warns: %d - Admin: %d",
		playhrs,
		jobkey,
		warnings,
		admin
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
	    vehicleid = PlayerInfo[giveplayerid][pSpawnedCar],
		price = cars * 150;
		
    if(cars == 0)
		return SendClientMessage(playerid, COLOR_RED, "Igrac ne posjeduje vozilo");
	else
	{
	    if(GetPlayerMoney(giveplayerid) < price) return SendClientMessage(playerid, COLOR_RED, "Igrac nema dovoljno novca.");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si premjestio parking svim vozilima igracu "COL_WHITE"%s"COL_YELLOW" - (%i$). ", GetName(giveplayerid, true), price);
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Admin %s vam je premjestio parking svih vozila(%i$).", GetName(playerid, true), price);
		PlayerToBudgetMoney(giveplayerid, price);
	}
	new
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		Query[1256];
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
	format( Query, sizeof(Query), "UPDATE cocars SET `parkX` = '%f', `parkY` = '%f', `parkZ` = '%f', `angle` = '%f', `viwo` = '0' WHERE ownerid = '%d'",
		x,
		y,
		z,
		angle,
		PlayerInfo[giveplayerid][pSQLID]
	);
	mysql_tquery(g_SQL, Query, "");
	
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
	if( !cache_num_rows() ) return va_SendClientMessage(playerid, COLOR_RED, "Nitko se nije logirao sa IP adresom: %s (DATABAZA)!", ip);

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
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "IP Adresa u nick", dialogString, "Ok", "");
	return 1;
}

forward CountFactionMembers(playerid, orgid);
public CountFactionMembers(playerid, orgid)
{
	if(!cache_num_rows()) return va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Organizacija %s broji 0 clanova (0 je online)!", FactionInfo[orgid][fName]);
	
	new activeMembers = 0;
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pMember] == orgid || PlayerInfo[i][pLeader] == orgid)
			activeMembers++;
	}
	
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Organizacija %s broji %d clanova (%d je online)!", FactionInfo[orgid][fName], cache_num_rows(), activeMembers);
	return 1;
}

forward CheckPlayerData(playerid, const name[]);
public CheckPlayerData(playerid, const name[])
{
	if( cache_num_rows() ) 
	{
		new sqlid;
		cache_get_value_name_int(0, "sqlid", sqlid);
		
		new string[96];
		format(string, sizeof(string),"SELECT * FROM `player_connects` WHERE `player_id` = '%d' ORDER BY `time` DESC LIMIT 1", sqlid);
		mysql_pquery(g_SQL, string, "CheckLastLogin", "is", playerid, name);
	}
	else
	    SendClientMessage(playerid, COLOR_RED, "Nick je nepostojeci u bazi podataka.");
	return 1;
}

forward CheckLastLogin(playerid, const name[]);
public CheckLastLogin(playerid, const name[])
{
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_RED, "Korisnik se nikada nije logirao!");
	
	new lastip[MAX_PLAYER_IP], lastdate, date[6];
	cache_get_value_name_int(0, 	"time"	, lastdate);
	cache_get_value_name(0,			"aip"	, lastip, MAX_PLAYER_IP);
	stamp2datetime(lastdate, date[0], date[1] ,date[2], date[3], date[4], date[5]); // formatiranje vremena iz unixa u normalno
	
	if(PlayerInfo[playerid][pAdmin])
	{
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac %s je zadnji puta bio online: %d.%d.%d - %d:%d:%d, sa IP: %s.", 
			name,
			date[2],
			date[1],
			date[0],
			date[3],
			date[4],
			date[5],
			lastip
		);
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Igrac %s je zadnji puta bio online: %d.%d.%d - %d:%d:%d", 
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

forward OnPlayerReconing(playerid, targetid);
public OnPlayerReconing(playerid, targetid)
{
	if( Bit4_Get(gr_SpecateId, playerid) == PLAYER_SPECATE_VEH ) {
		if( !IsPlayerInAnyVehicle(targetid) ) {
			SetPlayerInterior(playerid, GetPlayerInterior(targetid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
			PlayerSpectatePlayer(playerid, targetid);
			Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_PLAYER );
		}
	}
	else if( Bit4_Get(gr_SpecateId, playerid) == PLAYER_SPECATE_PLAYER ) {		
		if( GetPlayerInterior(playerid) != GetPlayerInterior(targetid) ) {
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
hook OnPlayerDisconnect(playerid, reason)
{
	// 32bit
	if(LearnTimer[playerid] != -1)
		KillTimer(LearnTimer[playerid]);
	LearnTimer[playerid]		= -1;
	ReconingVehicle[playerid]	= INVALID_VEHICLE_ID;
	ReconingPlayer[playerid]	= INVALID_PLAYER_ID;
	KillTimer(ReconTimer[playerid]);
	AdminLoginTry[playerid] = 0;
	PortedPlayer[playerid] = -1;
	
	// rBits
	Bit1_Set(a_PlayerReconed, playerid, false);
	Bit1_Set(gr_SaveArmour, playerid, false);
    Bit1_Set(a_AdminChat, playerid, false);
    Bit1_Set(a_PMears, playerid, false);
    Bit1_Set(a_AdNot, playerid, false);
    Bit1_Set(a_REars, playerid, false);
	Bit1_Set(a_BHears, playerid, false);
    Bit1_Set(a_DMCheck, playerid, false);
    Bit1_Set(a_AdminOnDuty, playerid, false);
	Bit1_Set(a_BlockedHChat, playerid, false);
	Bit1_Set(a_NeedHelp, playerid, false);
	Bit1_Set(a_TogReports, playerid, false);
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(GetPlayerState(playerid) == 2)
        {
            new carid;
            carid=GetPlayerVehicleID(playerid);
            SetVehiclePos(carid,fX,fY,MapAndreas_FindZ_For2DCoord(fX,fY,fZ));
        }
        else SetPlayerPosFindZ(playerid, fX, fY, fZ);
        SendClientMessage(playerid, COLOR_RED, "[ ! ] S obzirom da nisam vojni analiticar, moguce je da ne bude bas precizno.");
    }
    return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] %s (%d)", GetName(clickedplayerid,false), clickedplayerid);
		va_SendClientMessage(playerid, 0xC9C9C9FF, "IC:  Novac: [%d$] - Banka: [%d$] - Mob: [%d] - Org: [%s] - Rank: [%s (%d)]",
			PlayerInfo[clickedplayerid][pMoney],
			PlayerInfo[clickedplayerid][pBank],
			PlayerInfo[clickedplayerid][pMobileNumber],
			ReturnPlayerFactionName(clickedplayerid),
			ReturnPlayerRankName(clickedplayerid),
			PlayerInfo[clickedplayerid][pRank]
		);
		
		va_SendClientMessage(playerid, 0xC9C9C9FF, "OOC: Lvl: [%d] - Sati: [%d] - Warn: [%d/3] - Jail: [%d] - Jailtime: [%d]",
			PlayerInfo[clickedplayerid][pLevel],
			PlayerInfo[clickedplayerid][pConnectTime],
			PlayerInfo[clickedplayerid][pWarns],
			PlayerInfo[clickedplayerid][pJailed],
			PlayerInfo[clickedplayerid][pJailTime]
		);
		#if defined MODULE_BIZNIS
		if(PlayerInfo[clickedplayerid][pBizzKey] > 0)
		{
			new biznis;
			foreach(new i : Bizzes)
			{
				if(PlayerInfo[clickedplayerid][pSQLID] == BizzInfo[i][bOwnerID])
					biznis = i;
			}
			va_SendClientMessage(playerid, 0xCED490FF, "BIZNIS: ID: [%d] - Naziv: [%s] ", biznis, BizzInfo[biznis][bMessage]);
		}
		#endif		
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
		case DIALOG_PORT: {
			if( !response ) return 1;
			switch(listitem) {
				case 0:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1481.0739,-1741.8704,13.5469);
					else SetPlayerPos(playerid, 1481.0739,-1741.8704,13.5469);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Vijecnice.");
				}
				case 1:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 2105.6372,-1783.6501,13.3877);
					else SetPlayerPos(playerid, 2105.6372,-1783.6501,13.3877);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Pizza Stack.");
				}
				case 2:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1464.8783,-1024.6019,23.8281);
					else SetPlayerPos(playerid, 1464.8783,-1024.6019,23.8281);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Banke.");
				}
				case 3:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1697.6630,-1758.7987,13.5469);
					else SetPlayerPos(playerid, 1697.6630,-1758.7987,13.5469);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Wang Cars.");
				}
				case 4:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1962.2717,-2181.4526,13.5469);
					else SetPlayerPos(playerid, 1962.2717,-2181.4526,13.5469);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Aerodroma.");
				}
				case 5:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1714.5166,1484.5803,10.8128);
					else SetPlayerPos(playerid, 1714.5166,1484.5803,10.8128);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Las Venturasa.");
					return 1;
				}
				case 6:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 404.0537,2529.1179,16.5852);
					else SetPlayerPos(playerid, 404.0537,2529.1179,16.5852);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Desert.");
				}
				case 7:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 106.6820,1920.7625,18.5006);
					else SetPlayerPos(playerid, 106.6820,1920.7625,18.5006);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Area 51.");
				}
				case 8:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), -1417.0,-295.8,14.1);
					else SetPlayerPos(playerid, -1417.0,-295.8,14.1);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do San Fierro.");
				}
				case 9:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1212.3516,-926.2313,42.9175);
					else SetPlayerPos(playerid, 1212.3516,-926.2313,42.9175);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Burg.");
				}
				case 10:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1774.0024,-1726.3906,13.5469);
					else SetPlayerPos(playerid, 1774.0024,-1726.3906,13.5469);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Auto skole.");
				}
				case 11:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1140.2682,-1413.2601,13.6546);
					else SetPlayerPos(playerid, 1140.2682,-1413.2601,13.6546);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Verona Malla.");
				}
				case 12:
				{
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1310.6077,-1388.9838,13.5152);
					else SetPlayerPos(playerid, 1310.6077,-1388.9838,13.5152);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Casina.");
				}
				case 13: { // Rudnik
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 894.9913, -87.2169, 21.9249);
					else SetPlayerPos(playerid, 894.9913, -87.2169, 21.9249);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Rudnika.");
				}
				case 14: { // Bolnica
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 2030.5457,-1417.9918,16.9922);
					else SetPlayerPos(playerid, 2030.5457,-1417.9918,16.9922);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Bolnice.");
				}
				case 15: { // LS Jail
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 1806.6238,-1577.1790,13.4619);
					else SetPlayerPos(playerid, 1806.6238,-1577.1790,13.4619);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do LS Jaila.");
				}
				case 16: { // Mehanicarska garaza
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 2266.7559,-2041.4342,13.5469);
					else SetPlayerPos(playerid, 2266.7559,-2041.4342,13.5469);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do Mehanicarske garaze.");
				}
				case 17: { // LS Oglasnik
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 645.2079,-1357.5244,13.5714);
					else SetPlayerPos(playerid, 645.2079,-1357.5244,13.5714);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do LS Oglasnika.");
				}
				case 18: { // LSSD
					if( IsPlayerInAnyVehicle(playerid ) ) SetVehiclePos(GetPlayerVehicleID(playerid), 618.8765,-584.8453,17.2266);
					else SetPlayerPos(playerid, 618.8765,-584.8453,17.2266);
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste teleportirani do LSSDa.");
				}
			}
			SetPlayerVirtualWorld( playerid, 0 );
			SetPlayerInterior( playerid, 0 );
			
			if( IsPlayerInAnyVehicle(playerid ) ) {
				LinkVehicleToInterior( GetPlayerVehicleID(playerid), 0);
				SetVehicleVirtualWorld( GetPlayerVehicleID(playerid), 0 );
			}
			return 1;
		}
		case DIALOG_JAIL_GETHERE:
		{
			if( !response ) return 1;
			new
				Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			if (GetPlayerState(PortedPlayer[playerid]) == 2) {
				new tmpcar = GetPlayerVehicleID(PortedPlayer[playerid]);
				SetVehiclePos(tmpcar, X, Y+4, Z);
			} else {
				SetPlayerPos(PortedPlayer[playerid], X, Y+2, Z);
				SetPlayerInterior(PortedPlayer[playerid], GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(PortedPlayer[playerid], GetPlayerVirtualWorld(playerid));
			}
			format(globalstring, sizeof(globalstring), "Teleportiran si od strane admina/helpera %s", GetName(playerid,false));
			SendClientMessage(PortedPlayer[playerid], COLOR_GREY, globalstring);
			format(globalstring, sizeof(globalstring), "Teleportirao si %s, ID %d", GetName(PortedPlayer[playerid],false), PortedPlayer[playerid]);
			SendClientMessage(playerid, COLOR_GREY, globalstring);
			return 1;
		}
		case DIALOG_ADMIN_MSG:
        {
	        PlayerInfo[playerid][pAdmMsgConfirm] = true;
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

CMD:ahelp(playerid, params[])
{
	new p_dialog[2772], // 25.3.2020 - Runner
		f_dialog[256];

	if(PlayerInfo[playerid][pAdmin] == 0)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (PlayerInfo[playerid][pAdmin] >= 1) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /alogin, /forumname, /lastdriver, /toga, /bhears, /a, /houseo, /bizo, /complexo, /checknetstats.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /rtc, /gotopos, /goto, /checklastlogin, /fly, /lt, /rt, /checkoffline, /count, /akill.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /freeze, /unfreeze, /learn, /slap, /clearchat, /dmers, /masked, /setviwo, /recon, /reconoff.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /return, /aon, /pweapons, /am, /mute, /setint, /check, /kick, /approveobjects, /apm.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1]: /house_id, /biznis_id, /complex_id, /afurniture, /atoll, /adminmsg\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 2) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /getcar, /gotomark, /mark, /getip, /iptoname, /prisonex, /warnex, /ban, /unprison, /prison.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /charge, /gotocar, /unbanip, /rtcinradius, /weatherall, /prisoned, /banex, /jailex, /jail, /unjail.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 2]: /gethere, /unban, /warn, /pmears, /rtcacar(radius), /cnn, /givebullet, /rears, /checkfreq, /banip.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
    }
	if (PlayerInfo[playerid][pAdmin] >= 3) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 3]: /skin, /sethp, /pns, /blockreport, /fpm, /fpmed, /entercar, /checkcostats.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog, sizeof(f_dialog), "\n{FF9933}[A 3]: /check_gunrack, /check_hdrugs, /putplayerincar, /refillnos, /flipcar\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 4) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 4]: /aname, /rac, /setarmour, /veh, /veh_spawned, /undie, /unfreezearound, /freezearound, /setarmouraround.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 4]: /sethparound, /fixveh, /aunlock, /atake, /mutearound, /togreport, /fire, /deletevehicle, /bizinfo, /hidestatus.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 1337) {
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /fakekick, /timeout, /givemoney, /address, /edit(biz/house), /asellbiz, /asellhouse, /asellcomplex, /asellcomplexroom, /fuelcars.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /fuelcar, /factionmembers, /weather, /setstat, /fstyle, /givelicense, /givegun, /ac, /healcar, /create_garage, /garage.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FF9933}[A 1337]: /item_give/drop/reload, /checkinv, /lts, /dakar, /quad.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pAdmin] >= 1338) {
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /makehelper, /makeadmin, /playercars, /makeadmin, /happyhours, /removewarn, /crash, /givepremium, /achangename, /giveallmoney.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /customhouseint, /createpickup, /bizint, /city, /setcity, /agps.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /exp, /custombizint, /createvehicle, /bizint, /houseint, /afaction.\n/changepass, /teampin - Promjena passworda/Team PIN-a.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
		format(f_dialog,sizeof(f_dialog), "\n{FA5555}[A 1338]: /blacklist, /unblacklist, /agivedrug, /checkplayerdrugs, /checkvehdrugs, /togreg, ");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FF9933}* Game Admin Commands", p_dialog, "Zatvori", "");
	return 1;
}

CMD:hhelp(playerid, params[])
{
	new p_dialog[1024],
		f_dialog[256];

	if(PlayerInfo[playerid][pHelper] == 0 && PlayerInfo[playerid][pAdmin] < 1338)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (PlayerInfo[playerid][pHelper] >= 1 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 1]: /learn /apm /hon /hoff /hm /a /h /ach /forumname /kick /disconnect /slap /goto /checkoffline.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pHelper] >= 2 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 2]: /port /recon /rtc /rtcinradius /setint /setviwo.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
    }
	if (PlayerInfo[playerid][pHelper] >= 3 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 3]: /gethere /freeze /unfreeze.\n");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
	if (PlayerInfo[playerid][pHelper] >= 4 || PlayerInfo[playerid][pAdmin] == 1338) {
		format(f_dialog,sizeof(f_dialog), "\n[H 4]: /mark /gotomark /check.");
		strcat(p_dialog,f_dialog, sizeof(p_dialog));
	}
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{91FABB}* Helper - Commands", p_dialog, "Zatvori", "");
	return 1;
}

// All
CMD:alogin(playerid, params[])
{
	if(!PlayerInfo[playerid][pTempRank][0] && !PlayerInfo[playerid][pTempRank][1]) return SendClientMessage(playerid, COLOR_RED, "Niste admin/helper!");
	if(!strlen(PlayerInfo[playerid][pTeamPIN])) return SendClientMessage(playerid, COLOR_RED, "Nemate sigurnosni PIN!");
	if(PlayerInfo[playerid][pAdmin] || PlayerInfo[playerid][pHelper]) return SendClientMessage(playerid, COLOR_RED, "Vec imate postavljene rankove!");
	
	new	
		pin[16],
		pinHash[64],
		hashedPIN[129];
	
	if(sscanf(params, "s[16]", pin)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /alogin [PIN]");
	
	format(pinHash, 64, "%s%d", pin, PlayerInfo[playerid][pSQLID]);	
	WP_Hash(hashedPIN, sizeof(hashedPIN), pinHash);
	if( !strcmp(PlayerInfo[playerid][pTeamPIN], hashedPIN) ) {
		SendClientMessage(playerid, COLOR_RED, "[SERVER]  Dobrodosli u server team sustav!");
		PlayerInfo[playerid][pAdmin] 	= PlayerInfo[playerid][pTempRank][0];
		PlayerInfo[playerid][pHelper] 	= PlayerInfo[playerid][pTempRank][1];
		
		#if defined MODULE_LOGS
		new	
			log[256];
		format(log, 256, "%s (%s) se uspjesno ulogirao u server team sustav!", GetName(playerid, false), GetPlayerIP(playerid));
		LogPINEntry(log);
		#endif
	} else {
		SendClientMessage(playerid, COLOR_RED, "Krivi sigurnosni PIN! Pogreske ce rezultirati sa banovima!");
		
		#if defined MODULE_LOGS
		new	
			log[256];
		format(log, 256, "%s (%s) se neuspjesno pokusao se ulogirati u server team sustav!", GetName(playerid, false), GetPlayerIP(playerid));
		LogPINEntry(log);
		#endif
		
		if( ++AdminLoginTry[playerid] && AdminLoginTry[playerid] >= 3 ) {
			SendClientMessage(playerid, COLOR_RED, "[SERVER]  Tri puta ste se pokusali ulogirati u server tim sustav i zato ste kickani!");
			KickMessage(playerid);
		}
	}
	return 1;
}

// Administrator Level RCON
CMD:makehelper(playerid, params[])
{
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new 
		giveplayerid, level;
	if(sscanf(params, "ui", giveplayerid, level)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makehelper [Playerid/DioImena] [level(1-4)]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "Igrac nije online!");
	
	new
		query[512],
		saltedPin[129],
		pinHash[64];
	
	if(!level) {
		format(query, 512, "UPDATE `accounts` SET `teampin` = '',`helper` = '0' WHERE `sqlid` = '%d' LIMIT 1", PlayerInfo[giveplayerid][pSQLID]);
		mysql_tquery(g_SQL, query, "", "");
		
		PlayerInfo[giveplayerid][pTempRank][0] 	= 0;
		PlayerInfo[giveplayerid][pHelper] 		= 0;
		PlayerInfo[giveplayerid][pTeamPIN][0]	= EOS;
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Skinuli ste %s Game Helpera!", GetName(giveplayerid, false));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Skinut vam je Game Helper od strane %s!", GetName(playerid, false));
		return 1;
	}
	
	if( !strlen(PlayerInfo[giveplayerid][pTeamPIN]) ) {
		new	
			randomPin[6];
		randomString(randomPin,5);
		va_ShowPlayerDialog(giveplayerid, 0, DIALOG_STYLE_MSGBOX, "Helper PIN kod", "Cestitamo na dobijenom helper ranku!\nServer je generirao PIN za vas koji cete koristiti nakon logiranja na server sa komandom /alogin.\nNe odajite ga nikome ni pod koju cijenu i dobro ga upamtite ili zapisite!\nVas PIN glasi:"COL_COMPADMIN"%s", "Okay", "", randomPin);

		format(pinHash, 64, "%s%d", randomPin, PlayerInfo[giveplayerid][pSQLID]);	
		WP_Hash(saltedPin, sizeof(saltedPin), pinHash);
		format(PlayerInfo[giveplayerid][pTeamPIN], 129, saltedPin);
		
		mysql_format(g_SQL, query, 512, "UPDATE `accounts` SET `teampin` = '%e',`helper` = '%d' WHERE `sqlid` = '%d' LIMIT 1", saltedPin, level, PlayerInfo[giveplayerid][pSQLID]);
		mysql_tquery(g_SQL, query, "", "");
	}
	
	#if defined MODULE_LOGS
	new log[128];
	format(log, 128, "%s(%s) daje %s(%s) helper level %d", GetName(playerid,false), GetPlayerIP(playerid), GetName(giveplayerid,false), GetPlayerIP(giveplayerid), level);
	LogMakeAdmin(log);
	#endif
	
	PlayerInfo[giveplayerid][pHelper] = PlayerInfo[giveplayerid][pTempRank][1] = level;
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Postavljeni ste za Game Helper od Administratora %s", GetName(playerid,false));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ]  Postavili ste %s za Game Helper.", GetName(giveplayerid,false));
	return 1;
}

CMD:inactivity(playerid, params[])
{
	new choice[12], playername[24], giveplayerid, bool:online=false, days, reason[64];
	
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Game Admin Level 3+!");
		
	if(sscanf(params, "s[12] ", choice)) 
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity [opcija]");
		SendClientMessage(playerid, COLOR_RED, "OPCIJE: add, remove, check, list");
		return 1;
	}
	if( !strcmp(choice, "check", true) )
	{
		if (sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity check [Ime_Prezime]");
			return 1;
		}
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(!IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s nema registriranu neaktivnost u bazi podataka!");
			
		CheckInactivePlayer(playerid, sqlid);
	}		
		
	if( !strcmp(choice, "list", true) )
		ListInactivePlayers(playerid);
		
	if( !strcmp(choice, "add", true) )
	{
		new startstamp, endstamp;
		if (sscanf(params, "s[12]s[24]is[64]", choice, playername, days, reason))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity add [Ime_Prezime][broj dana][razlog]");
			return 1;
		}
		if(days < 1 || days > 45)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Neaktivnost ne moze biti kraca od 1, ni dulja od 45 dana!");
		if(strlen(reason) < 1 || strlen(reason) >= 64)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Razlog ne moze biti kraci od 1, ni dulji od 64 znaka!");
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s vec ima registriranu neaktivnost u bazi podataka!");
		
		startstamp = gettimestamp();
		endstamp = gettimestamp() + (3600 * 24 * days);
		
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && SafeSpawned[playerid])
			{
				new playername2[MAX_PLAYER_NAME];
				GetPlayerName(i, playername2, sizeof(playername2));
				if(strcmp(playername2, playername, true, strlen(playername)) == 0)
				{
					online = true;
					giveplayerid = i;
					break;
				}
			}
		}
		new insertQuery[200];
		mysql_format(g_SQL, insertQuery, sizeof(insertQuery), "INSERT INTO `inactive_accounts`(`sqlid`, `startstamp`, `endstamp`, `reason`) VALUES ('%d','%d','%d','%e')",
			sqlid,
			startstamp,
			endstamp,
			reason
		);
		mysql_pquery(g_SQL, insertQuery, "", "");
		
		Log_Write("logfiles/a_inactive_players.txt", "(%s) %s[A%d] je odobrio %s[SQLID: %d] neaktivnost od %d dana. Razlog: %s",
			ReturnDate(),
			GetName(playerid,false),
			PlayerInfo[playerid][pAdmin],
			playername,
			sqlid,
			days,
			reason
		);
		
		if(online)
		{
			va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "Game Admin %s vam je odobrio neaktivnost od %d dana, razlog: %s.", GetName(playerid, false), days, reason);
			SendClientMessage(giveplayerid, COLOR_LIGHTRED, "UPOZORENJE: Ukoliko se ulogirate na account za vrijeme neaktivnosti, ona se automatski ponistava!");
		}
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Uspjesno ste registrirali neaktivnost %s[SQLID: %d] na %d dana. Razlog: %s", playername, sqlid, days, reason);
	}
	if( !strcmp(choice, "remove", true) )
	{
		if (sscanf(params, "s[12]s[24]", choice, playername))
		{
			SendClientMessage(playerid, COLOR_RED, "[ ? ]: /inactivity remove [Ime_Prezime]");
			return 1;
		}
		new sqlid = ConvertNameToSQLID(playername);
		if(sqlid == -1)
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s ne postoji u bazi podataka.", playername);
			
		if(!IsValidInactivity(sqlid))
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Account %s nema ima registriranu neaktivnost u bazi podataka!");
		
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && SafeSpawned[playerid])
			{
				new playername2[MAX_PLAYER_NAME];
				GetPlayerName(i, playername2, sizeof(playername2));
				if(strcmp(playername2, playername, true, strlen(playername)) == 0)
				{
					online = true;
					giveplayerid = i;
					break;
				}
			}
		}
		new deleteQuery[200];
		mysql_format(g_SQL, deleteQuery, sizeof(deleteQuery), "DELETE FROM `inactive_accounts` WHERE `sqlid` = '%d'", sqlid);
		mysql_tquery(g_SQL, deleteQuery, "", "");
		
		Log_Write("logfiles/a_inactive_players.txt", "(%s) %s[A%d] je obrisao %s[SQLID: %d] registriranu neaktivnost iz baze podataka",
			ReturnDate(),
			GetName(playerid,false),
			PlayerInfo[playerid][pAdmin],
			playername,
			sqlid
		);
		
		if(online)
			va_SendClientMessage(giveplayerid, COLOR_LIGHTRED, "Game Admin %s vam je ponistio registriranu neaktivnost.", GetName(playerid, false));
			
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Uspjesno ste ponistili registriranu neaktivnost %s[SQLID: %d]", playername, sqlid);
	}
	return 1;
}

CMD:hon(playerid, params[])
{
	if(Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Vec ste na Helper duznosti!");
    if(PlayerInfo[playerid][pHelper] >= 1)
	{
		SendClientMessage(playerid,COLOR_RED, "[ ! ] Sada si na Helper duznosti!");
		Bit1_Set(h_HelperOnDuty, playerid, true);
        SetPlayerColor(playerid, COLOR_HELPER);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
        foreach (new i : Player)
			SetPlayerMarkerForPlayer(i, playerid, COLOR_HELPER);
    }
    else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:hoff(playerid, params[])
{
    if(!Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Niste ste na Helper duznosti!");
    if(PlayerInfo[playerid][pHelper] >= 1)
	{
		SendClientMessage(playerid,COLOR_RED, "[ ! ] Vise nisi na Helper duznosti!");
		Bit1_Set(h_HelperOnDuty, playerid, false);
        SetPlayerColor(playerid,TEAM_HIT_COLOR);
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 100);
		foreach (new i : Player)
  			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
    }
    else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    return 1;
}

CMD:hm(playerid, params[])
{
	if(!Bit1_Get(h_HelperOnDuty, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Niste ste na Helper duznosti!");
	if (Bit1_Get(gr_MaskUse, playerid))
		return SendClientMessage(playerid,COLOR_RED, "Skinite masku prije nego sto koristite /hm!");
	if(PlayerInfo[playerid][pHelper] >= 1)
	{
	    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /hm [poruka]");
		new motd[180];
		format(motd, sizeof(motd), "(( HELPER %s:  %s ))", GetName(playerid, true), params);
		SendClientMessageToAll(COLOR_HELPER, motd);
		#if defined MODULE_LOGS
		LogAdminMessage(globalstring);
		#endif
 	}
    else SendClientMessage(playerid, COLOR_RED, "Niste autorizirani za koristenje ove komande!");
    return 1;
}

CMD:ach(playerid, params[]) {
	new targetid;
	//if(!Bit1_Get(h_HelperOnDuty, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ste na Helper duznosti!");
	if(sscanf(params, "d", targetid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ach [target_id].");
	if(!Bit1_Get(a_NeedHelp, targetid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Ta osoba nije pozvala pomoc helpera.");
	
	SendFormatMessage(targetid, MESSAGE_TYPE_INFO, "Admin %s je prihvatio vas poziv za pomoc.", GetName(playerid));
	format(globalstring, sizeof(globalstring), "[ ! ] Admin %s je prihvatio pomoc od %s.",GetName(playerid, true), GetName(targetid, true));
	SendHelperMessage(COLOR_RED, globalstring, 1);
	
	Bit1_Set(a_NeedHelp, targetid, (false));
	return (true);
}

CMD:playercars(playerid, params[]) {
	new 
		Cache: mysql_search,
		player_sqlid,
		buffer[128],
		player_nick[MAX_PLAYER_NAME];
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "s[MAX_PLAYER_NAME]", player_nick)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /playercars [Ime_Prezime].");
	
	// mysql
	mysql_format(g_SQL, buffer, sizeof(buffer), "SELECT sqlid FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", player_nick);
	mysql_search = mysql_query(g_SQL, buffer);
	cache_get_value_name_int(0, "sqlid"	, player_sqlid);
	cache_delete(mysql_search);
	
	ShowPlayerCars(playerid, player_sqlid, player_nick);
	return (true);
}

CMD:teampin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 1338!");
		
	new giveplayerid,
		teampin[12],
		pinHash[64],
		saltedPin[129],
		query[256];
		
	if(sscanf(params, "us[12] ", giveplayerid, teampin)) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /teampin [Playerid/DioImena] [Novi Team PIN za /alogin]");
	if(!IsPlayerConnected(giveplayerid))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
	if(!SafeSpawned[giveplayerid])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan!");
	if(!PlayerInfo[giveplayerid][pTempRank][0] && !PlayerInfo[giveplayerid][pTempRank][1] && !PlayerInfo[giveplayerid][pAdmin] && !PlayerInfo[giveplayerid][pHelper]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije Team Staff!");
	if(strlen(teampin) < 1 || strlen(teampin) > 12)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Team PIN ne moze biti kraci od jednog, ni dulji od 12 znakova!");
	
	format(pinHash, 64, "%s%d", teampin, PlayerInfo[giveplayerid][pSQLID]);	
	WP_Hash(saltedPin, sizeof(saltedPin), pinHash);
	format(PlayerInfo[giveplayerid][pTeamPIN], 129, saltedPin);
	
	mysql_format(g_SQL, query, 256, "UPDATE `accounts` SET `teampin` = '%e' WHERE `sqlid` = '%d' LIMIT 1", saltedPin, PlayerInfo[giveplayerid][pSQLID]);
	mysql_tquery(g_SQL, query, "", "");
	
	va_SendClientMessage(playerid, COLOR_RED, "[SERVER]  Uspjesno ste postavili %s Team PIN na: %s", GetName(giveplayerid, true), teampin );
	va_SendClientMessage(giveplayerid, COLOR_RED, "[SERVER] Administrator %s Vam je uspjesno postavio Team PIN na: %s", GetName(playerid, true), teampin );
	
	return 1;
}


CMD:makeadmin(playerid, params[])

{
	if( !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pAdmin] != 1338 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new 
		giveplayerid, level;
	if(sscanf(params, "ui", giveplayerid, level)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makeadmin [Playerid/DioImena] [level(1-1338)]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "Igrac nije online!");
	
	new
		query[512],
		saltedPin[129],
		pinHash[64];
	
	if(!level) {
		format(query, 512, "UPDATE `accounts` SET `teampin` = '',`adminLvl` = '0' WHERE `sqlid` = '%d' LIMIT 1", PlayerInfo[giveplayerid][pSQLID]);
		mysql_tquery(g_SQL, query, "", "");
		
		PlayerInfo[giveplayerid][pTempRank][0] 	= 0;
		PlayerInfo[giveplayerid][pAdmin] 		= 0;
		PlayerInfo[giveplayerid][pTeamPIN][0]	= EOS;
		
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Skinuli ste %s Game Admina!", GetName(giveplayerid, false));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Skinut vam je Game Admin od strane %s!", GetName(playerid, false));
		return 1;
	}
	
	if( !strlen(PlayerInfo[giveplayerid][pTeamPIN]) ) {
		new	
			randomPin[6];
		randomString(randomPin,5);
		va_ShowPlayerDialog(giveplayerid, 0, DIALOG_STYLE_MSGBOX, "Admin PIN kod", "Cestitamo na dobijenom admin ranku!\nServer je generirao PIN za vas koji cete koristiti nakon logiranja na server sa komandom /alogin.\nNe odajite ga nikome ni pod koju cijenu i dobro ga upamtite ili zapisite!\nVas PIN glasi:"COL_COMPADMIN"%s\nObavezno podesite svoj Forum Nick sa komandom /forumname.", "Okay", "", randomPin);

		format(pinHash, 64, "%s%d", randomPin, PlayerInfo[giveplayerid][pSQLID]);	
		WP_Hash(saltedPin, sizeof(saltedPin), pinHash);
		format(PlayerInfo[giveplayerid][pTeamPIN], 129, saltedPin);
		
		mysql_format(g_SQL, query, 512, "UPDATE `accounts` SET `teampin` = '%e',`adminLvl` = '%d' WHERE `sqlid` = '%d' LIMIT 1", saltedPin, level, PlayerInfo[giveplayerid][pSQLID]);
		mysql_tquery(g_SQL, query, "", "");
	}
	
	PlayerInfo[giveplayerid][pAdmin] = PlayerInfo[giveplayerid][pTempRank][0] = level;
	
	#if defined MODULE_LOGS
	new log[128];
	format(log, 128, "%s(%s) daje %s(%s) admin level %d", GetName(playerid,false), GetPlayerIP(playerid), GetName(giveplayerid,false), GetPlayerIP(giveplayerid), level);
	LogMakeAdmin(log);
	#endif
	
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Postavljeni ste za Game Admina level %d od Administratora %s", level, GetName(playerid,false));
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Postavili ste %s za Game Admina.", GetName(giveplayerid,false));
	return 1;
}

CMD:saveall(playerid, params[])
{
	if( !IsPlayerAdmin(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande.");
    new 
		tmp[64];
	if( sscanf(params, "s[64]", tmp) ) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /save [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Accounts, Bizzes, Houses");
		return 1;
	}
	if( !strcmp(tmp, "accounts", true) ) {
		new start_tick = GetTickCount();
		new count = 0;
		foreach (new i : Player) {
			if (Bit1_Get(gr_PlayerLoggedIn, i) != 0) {
				SavePlayerData(i);
				count++;
			}
		}
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Updating %d players took: %d ms", count, GetTickCount() - start_tick);
	}
	else if( !strcmp(tmp, "bizzes", true) ) {
		#if defined MODULE_BIZNIS
		new start_tick = GetTickCount();
		SaveBizz();
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Updating bizzes took %dms.", GetTickCount() - start_tick);
		#endif
	}
	else if( !strcmp(tmp,"houses", true) ) {
		new start_tick = GetTickCount();
		SaveHouses();
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Updating houses took %dms.", GetTickCount() - start_tick);
	}
	return 1;
}

CMD:makeadminex(playerid, params[])
{
	if( IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] == 1338 ) {
		new
			level,
			gplayername[MAX_PLAYER_NAME];
		if(sscanf(params, "s[24] ", gplayername)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /makeadminex [Ime_Prezime] [Level(1-1338)]");
		mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "UPDATE `accounts` SET `adminLvl` = '%d' WHERE `name` = '%e' LIMIT 1", level, gplayername);
		mysql_tquery(g_SQL, mysqlquery, "", "");
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

// Administrator Level 1338

//Kojeg ce ti djavla kad ne radi, lol.
/*
CMD:kickallplayers(playerid, params[])
{
	if( !IsPlayerAdmin(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	foreach(new i : Player)
	{
		if(i != playerid)
			KickMessage(i);
	}
	return 1;
}
*/
CMD:happyhours(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		happy;
	if( sscanf( params, "i ", happy ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /happyhours [0-makni/1-stavi]");
	if( 0 <= happy <= 1 ) {
		new
			gstring[64];
		if( happy ) {
			new
				level;
			if( sscanf( params, "ii", happy, level ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /happyhours 1-stavi [level]");
			format(gstring, sizeof(gstring), "hostname City of Angels RP [Happy Hours do %d level]", level);
			SendRconCommand(gstring);
			HappyHoursLVL = level;
		} else {
			format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
			SendRconCommand(gstring);
		}
		HappyHours = happy;
		
	} else SendClientMessage(playerid, COLOR_RED, "Morate staviti 0 za skidanje happy hoursa i 1 za stavljanje!");
	return 1;
}
CMD:removewarn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /removewarn [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    PlayerInfo[giveplayerid][pWarns] -= 1;
    format(globalstring, sizeof(globalstring), "Maknuli ste warn igracu %s", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "*WARN: Admin %s je skinuo warning igracu: %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_YELLOW, globalstring);
	return 1;
}

CMD:explode(playerid, params[])
{
	new giveplayerid;
 	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Komanda /explode ne postoji!");
  	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[ ? ]: [ID/DioImena]");
  	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac� nije online!");

    new Float:SLX, Float:SLY, Float:SLZ;
    GetPlayerPos(giveplayerid, SLX, SLY,SLZ);
    CreateExplosion(SLX, SLY, SLZ, 11, 0.25);
    va_SendClientMessage(playerid, COLOR_YELLOW, "Raznio si %s", GetName(giveplayerid, true));
    return 1;
}

CMD:fakekick(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Komanda '/fakekick' ne postoji!");
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fakekick [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SendClientMessage(giveplayerid, 0xA9C4E4AA, "Server closed the connection.");
	return 1;
}
CMD:crash(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Komanda '/crash' ne postoji!");
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /crash [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac� nije online!");
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
	GameTextForPlayer(giveplayerid, "??!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	return 1;
}

//

CMD:givepremium(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		giveplayerid,
		dLevel[10];

    if(sscanf(params, "us[10] ", giveplayerid, dLevel)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givepremium [ID/DioImena][Bronze/Silver/Gold/Platinum]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");

	if(strcmp(dLevel,"bronze",true) == 0)
	{
		ExpInfo[giveplayerid][ePoints] += BRONZE_EXP_POINTS;
		ExpInfo[giveplayerid][eAllPoints] += BRONZE_EXP_POINTS;
		SavePlayerExperience(giveplayerid);

	    PlayerInfo[ giveplayerid ][ pMaskID ] = 100000 + random(899999);
		new log[128],
			playerip[MAX_PLAYER_IP];
		GetPlayerIp(giveplayerid, playerip, sizeof(playerip));

		format(log, sizeof(log), "%s(%s), maskid %d.",
			GetName(playerid, false),
			playerip,
			PlayerInfo[ giveplayerid ][ pMaskID ]
		);
		LogMask(log);
		PlayerInfo[giveplayerid][pFreeWorks] 	= 25;
 		PlayerInfo[giveplayerid][pDonateRank] 	= 1;
		PlayerInfo[giveplayerid][pRespects] 	+= 10;
		PlayerInfo[giveplayerid][pChangeTimes] 	+= 2;
		PlayerInfo[giveplayerid][pLevel] 		+= 1;
		PlayerInfo[giveplayerid][pDonatorVehPerms] 	= 2;
		PlayerInfo[giveplayerid][pDonateTime]	= gettimestamp() + 2592000;

		if(PlayerInfo[giveplayerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(giveplayerid, -1, PlayerInfo[ giveplayerid ][ pHouseKey ]);
		if(PlayerInfo[giveplayerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(giveplayerid);
		new
			vipUpdtQuery[ 128 ];
		format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d', `dvehperms` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[giveplayerid][pDonateRank],
			PlayerInfo[giveplayerid][pDonateTime],
			PlayerInfo[giveplayerid][pDonatorVehPerms],
			PlayerInfo[giveplayerid][pSQLID]
		);
		mysql_tquery(g_SQL, vipUpdtQuery);


		// MySQL Log
		new vipLog[200];
		format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
			PlayerInfo[giveplayerid][pSQLID],
			PlayerInfo[playerid][pSQLID],
			PlayerInfo[giveplayerid][pDonateRank],
			gettimestamp(),
			PlayerInfo[giveplayerid][pDonateTime]
		);
		mysql_pquery(g_SQL, vipLog);

		// a_givepremium.txt
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s je dao VIP Bronze %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Bronze VIP Account od admina %s.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Bronze VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));
    }
    else if(strcmp(dLevel,"silver",true) == 0)
	{
		ExpInfo[giveplayerid][ePoints] += SILVER_EXP_POINTS;
		ExpInfo[giveplayerid][eAllPoints] += SILVER_EXP_POINTS;
		SavePlayerExperience(giveplayerid);

	    PlayerInfo[ giveplayerid ][ pMaskID ] = 100000 + random(899999);
		new log[128],
			playerip[MAX_PLAYER_IP];
		GetPlayerIp(giveplayerid, playerip, sizeof(playerip));

		format(log, sizeof(log), "%s(%s), maskid %d.",
			GetName(giveplayerid, false),
			playerip,
			PlayerInfo[ giveplayerid ][ pMaskID ]
		);
		LogMask(log);

		PlayerInfo[giveplayerid][pFreeWorks] 	= 25;
 		PlayerInfo[giveplayerid][pDonateRank] 	= 2;
		PlayerInfo[giveplayerid][pRespects] 	+= 20;
		PlayerInfo[giveplayerid][pLevel] 		+= 2;
		PlayerInfo[giveplayerid][pChangeTimes] 	+= 3;
		PlayerInfo[giveplayerid][pDonatorVehPerms] 	= 2;
		PlayerInfo[giveplayerid][pDonateTime]	= gettimestamp() + 2592000;

		if(PlayerInfo[giveplayerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(giveplayerid, -1, PlayerInfo[ giveplayerid ][ pHouseKey ]);
		if(PlayerInfo[giveplayerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(giveplayerid);
		new
			vipUpdtQuery[ 128 ];
		format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d', `dvehperms` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[giveplayerid][pDonateRank],
			PlayerInfo[giveplayerid][pDonateTime],
			PlayerInfo[giveplayerid][pDonatorVehPerms],
			PlayerInfo[giveplayerid][pSQLID]
		);
		mysql_tquery(g_SQL, vipUpdtQuery);

		// MySQL Log
		new vipLog[200];
		format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
			PlayerInfo[giveplayerid][pSQLID],
			PlayerInfo[playerid][pSQLID],
			PlayerInfo[giveplayerid][pDonateRank],
			gettimestamp(),
			PlayerInfo[giveplayerid][pDonateTime]
		);
		mysql_pquery(g_SQL, vipLog);

		// a_givepremium.txt
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s je dao VIP Silver %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Silver VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Silver VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));
    }
    else if(strcmp(dLevel,"gold",true) == 0)
	{
		ExpInfo[giveplayerid][ePoints] += GOLD_EXP_POINTS;
		ExpInfo[giveplayerid][eAllPoints] += GOLD_EXP_POINTS;
		SavePlayerExperience(giveplayerid);

	    PlayerInfo[ giveplayerid ][ pMaskID ] = 100000 + random(899999);
		new log[128],
			playerip[MAX_PLAYER_IP];
		GetPlayerIp(giveplayerid, playerip, sizeof(playerip));

		format(log, sizeof(log), "%s(%s), maskid %d.",
			GetName(giveplayerid, false),
			playerip,
			PlayerInfo[ giveplayerid ][ pMaskID ]
		);
		LogMask(log);

		PlayerInfo[giveplayerid][pFreeWorks] 	= 30;
		PlayerInfo[giveplayerid][pDonateRank] 	= 3;
		PlayerInfo[giveplayerid][pRespects] 	+= 30;
		PlayerInfo[giveplayerid][pLevel] 		+= 3;
		PlayerInfo[giveplayerid][pChangeTimes] 	+= 5;
		if(PlayerInfo[giveplayerid][pWarns] >= 1)
			PlayerInfo[giveplayerid][pWarns] 		-= 1;
		PlayerInfo[giveplayerid][pDonatorVehPerms] 	= 2;	
		PlayerInfo[giveplayerid][pDonateTime]	= gettimestamp() + 2592000;

		PlayerInfo[giveplayerid][pCarLic] 	= 1;
		PlayerInfo[giveplayerid][pFlyLic] 	= 1;
		PlayerInfo[giveplayerid][pBoatLic] 	= 1;
		PlayerInfo[giveplayerid][pFishLic]  = 1;
		PlayerInfo[giveplayerid][pGunLic]	= 1;

		if(PlayerInfo[giveplayerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(giveplayerid, -1, PlayerInfo[ giveplayerid ][ pHouseKey ]);
		if(PlayerInfo[giveplayerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(giveplayerid);
		new
			vipUpdtQuery[ 128 ];
		format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d', `dvehperms` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[giveplayerid][pDonateRank],
			PlayerInfo[giveplayerid][pDonateTime],
			PlayerInfo[giveplayerid][pDonatorVehPerms],
			PlayerInfo[giveplayerid][pSQLID]
		);
		mysql_tquery(g_SQL, vipUpdtQuery);

		// MySQL Log
		new vipLog[200];
		format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
			PlayerInfo[giveplayerid][pSQLID],
			PlayerInfo[playerid][pSQLID],
			PlayerInfo[giveplayerid][pDonateRank],
			gettimestamp(),
			PlayerInfo[giveplayerid][pDonateTime]
		);
		mysql_pquery(g_SQL, vipLog);

		// a_givepremium.txt
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s je dao VIP Gold %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Gold VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za mjesec dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Gold VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));

    }
	else if(strcmp(dLevel,"platinum",true) == 0)
	{
		ExpInfo[giveplayerid][ePoints] += PLATINUM_EXP_POINTS;
		ExpInfo[giveplayerid][eAllPoints] += PLATINUM_EXP_POINTS;
		SavePlayerExperience(giveplayerid);

	    PlayerInfo[ giveplayerid ][ pMaskID ] = 100000 + random(899999);
		new log[128],
			playerip[MAX_PLAYER_IP];
		GetPlayerIp(giveplayerid, playerip, sizeof(playerip));

		format(log, sizeof(log), "%s(%s), maskid %d.",
			GetName(giveplayerid, false),
			playerip,
			PlayerInfo[ giveplayerid ][ pMaskID ]
		);
		LogMask(log);

		PlayerInfo[giveplayerid][pFreeWorks] 		= 50;
		PlayerInfo[giveplayerid][pDonateRank] 		= 4;
		PlayerInfo[giveplayerid][pRespects] 		+= 50;
		PlayerInfo[giveplayerid][pLevel] 			+= 4;
		PlayerInfo[giveplayerid][pChangeTimes] 		+= 7;
		PlayerInfo[giveplayerid][pWarns]			= 0;
		PlayerInfo[giveplayerid][pDonatorVehPerms] 	= 2;
		PlayerInfo[giveplayerid][pDonateTime]		= gettimestamp() + 3888000; // 45 dana

		PlayerInfo[giveplayerid][pCarLic] 	= 1;
		PlayerInfo[giveplayerid][pFlyLic] 	= 1;
		PlayerInfo[giveplayerid][pBoatLic] 	= 1;
		PlayerInfo[giveplayerid][pFishLic]  = 1;
		PlayerInfo[giveplayerid][pGunLic] 	= 2;

		if(PlayerInfo[giveplayerid][pHouseKey] != INVALID_HOUSE_ID)
			UpdatePremiumHouseFurSlots(giveplayerid, -1, PlayerInfo[ giveplayerid ][ pHouseKey ]);
		if(PlayerInfo[giveplayerid][pBizzKey] != INVALID_BIZNIS_ID)
			UpdatePremiumBizFurSlots(giveplayerid);
		new
			vipUpdtQuery[ 128 ];
		format( vipUpdtQuery, 128, "UPDATE `accounts` SET `vipRank` = '%d', `vipTime` = '%d', `dvehperms` = '%d' WHERE `sqlid` = '%d'",
			PlayerInfo[giveplayerid][pDonateRank],
			PlayerInfo[giveplayerid][pDonateTime],
			PlayerInfo[giveplayerid][pDonatorVehPerms],
			PlayerInfo[giveplayerid][pSQLID]
		);
		mysql_tquery(g_SQL, vipUpdtQuery);

		// MySQL Log
		new vipLog[200];
		format(vipLog, sizeof(vipLog), "INSERT INTO `player_vips`(`player_id`, `admin_id`, `rank`, `created_at`, `expires_at`) VALUES ('%d','%d','%d','%d','%d')",
			PlayerInfo[giveplayerid][pSQLID],
			PlayerInfo[playerid][pSQLID],
			PlayerInfo[giveplayerid][pDonateRank],
			gettimestamp(),
			PlayerInfo[giveplayerid][pDonateTime]
		);
		mysql_pquery(g_SQL, vipLog);

		// a_givepremium.txt
		Log_Write("logfiles/a_givepremium.txt", "(%s) Administrator %s je dao VIP Platinum %s[SQLID: %d].",
			ReturnDate(),
			GetName(playerid, false),
			GetName(giveplayerid, false),
			PlayerInfo[giveplayerid][pSQLID]
		);

		va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Dobili ste Platinum VIP Account od admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Vas VIP paket istice za 45 dana, zahvaljujemo na vasoj donaciji!");
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Dali ste %s Platinum VIP Account sa svim mogucnostima.", GetName(giveplayerid,false));

    }
	else SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givepremium [ID/DioImena] [Bronze/Silver/Gold/Platinum]");
	return 1;
}

CMD:achangename(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		giveplayerid,
	    novoime[MAX_PLAYER_NAME+1],
		oldnick[MAX_PLAYER_NAME+1],
		name[MAX_PLAYER_NAME+1];
		
    if(sscanf(params, "us[24]", giveplayerid, novoime)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /achangename [ID/Dio imena] [Ime_Prezime]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	GetPlayerName(giveplayerid, oldnick, sizeof(oldnick));
	GetPlayerName(playerid, name, sizeof(name));
	if(!IsValidName(novoime)) return SendClientMessage(playerid, COLOR_RED, "Nepravilan Role Play format imena.");
    format(globalstring, sizeof(globalstring), "[ ! ] Administrator %s je promjenio tvoj nick u %s!", name, novoime);
    SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	ChangePlayerName(giveplayerid, novoime, 1, (true));
	return 1;
}

CMD:aname(playerid, params[]) {
	if( !isnull(PlayerExName[playerid]) ) {
		SetPlayerName(playerid, PlayerExName[playerid]);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste vratili svoj prijasnji nick!");
		PlayerExName[playerid][0] = EOS;
		return (true);
	}
	new newName[ MAX_PLAYER_NAME ];
	if( sscanf(params, "s[24]", newName) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aname [novi nick].");
	if( !IsValidName(newName) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan roleplay nick!");
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	format(PlayerExName[playerid], 24, GetName(playerid, false));
		
	switch( SetPlayerName(playerid, newName) ) {
		case -1: SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko na serveru posjeduje taj nick!");
		case 0: SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec posjedujete taj nick!");
		case 1: SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste promjenili nick u %s", newName); 
	}
	return (true);
} 

CMD:givemoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid, amount;
   	if (sscanf(params, "ui", giveplayerid, amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givemoney [ID/Dio imena] [Iznos]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    BudgetToPlayerMoney(giveplayerid, amount); // budjet - igrac
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je stvorio igracu %s $%d (/Givemoney)", GetName(playerid,false), GetName(giveplayerid,false), amount);
	SendAdminMessage(COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "%s[%s] je dao %s %d$ putem /givemoney.", playerid, GetName(playerid,false), GetName(giveplayerid,false), amount);
	#if defined MODULE_LOGS
	LogAdminGiveMoney(globalstring);
	#endif
    return 1;
}

CMD:giveallmoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new amount;
   	if (sscanf(params, "i", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /giveallmoney [Iznos]");
	foreach( new giveplayerid : Player)
	{
		if (!IsPlayerLogged(giveplayerid) || !IsPlayerConnected(playerid) ) continue;
		BudgetToPlayerMoney(giveplayerid, amount); // budjet - igrac
		format(globalstring, sizeof(globalstring), "%s[%s] je dao %s %d$ putem /givemoney.", playerid, GetName(playerid,false), GetName(giveplayerid,false), amount);		
		#if defined MODULE_LOGS
		LogAdminGiveMoney(globalstring);
		#endif
	}
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je stvorio svim igracima $%d (/givemoneyallmoney)", GetName(playerid,false), amount);
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

// Administrator Level 1337
CMD:address(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni !");
	new id, address[32];
	if( sscanf(params, "is[32] ", id, address) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /address [houseid] [adresa]");
	if( strlen(address) > 32 ) return SendClientMessage( playerid, COLOR_RED, "Maksimalna velicina adrese je 11 znakova!");
	if( !Iter_Contains(Houses, id) ) return SendClientMessage(playerid, COLOR_RED, "Morate biti blizu kuce!");
	if( !IsPlayerInRangeOfPoint(playerid, 15.0, HouseInfo[ id ][ hEnterX ], HouseInfo[ id ][ hEnterY ], HouseInfo[ id ][ hEnterZ ] ) ) return SendClientMessage( playerid, COLOR_RED, "Morate biti blizu kuce!");
	
	new TmpQuery[105];
	format(HouseInfo[id][hAdress], 32, address);
	mysql_format(g_SQL, TmpQuery, 105, "UPDATE `houses` SET `adress` = '%e' WHERE `id` = '%d'", address, HouseInfo[id][hSQLID]);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Promjenili ste adresu kuce u %s", address);
	return 1;
}
CMD:edit(playerid, params[])
{
	new x_job[32], proplev, proptype = 0, propid = -1;
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have premissions to use this command!");
	if (sscanf(params, "s[32]i", x_job, proplev)) {
		SendClientMessage(playerid, COLOR_RED, "|___________ Edit Houses/Business ___________|");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /edit [option] [value]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Level, Price, Funds, Locked, BizViwo");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] DoorLevel, LockLevel, AlarmLevel, hviwo");
		SendClientMessage(playerid, COLOR_RED, "|____________________________________________|");
		return 1;
	}
    foreach(new i:Houses)
	{
		if (IsPlayerInRangeOfPoint(playerid,2,HouseInfo[i][hEnterX], HouseInfo[i][hEnterY], HouseInfo[i][hEnterZ]) && HouseInfo[i][h3dViwo] == GetPlayerVirtualWorld(playerid))
		{
		    new TmpQuery[128];
			if(proplev > 0)
			{
			    if(strcmp(x_job,"level",true) == 0)
			    {
					proptype = 1;
					propid = i;
					HouseInfo[i][hLevel] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `level` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"price",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hValue] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `value` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"locked",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hLock] = proplev;
				}
				else if(strcmp(x_job,"doorlevel",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hDoorLevel] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `doorlevel` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"locklevel",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hLockLevel] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `locklevel` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"alarmlevel",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hAlarm] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `alarm` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"hviwo",true) == 0)
				{
					proptype = 1;
					propid = i;
					HouseInfo[i][hVirtualWorld] = proplev;
					format(TmpQuery, 128, "UPDATE `houses` SET `viwo` = '%d' WHERE `id` = '%d'", proplev, HouseInfo[i][hSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
			}
		}
	}
	foreach(new i:Bizzes)
	{
		if (IsPlayerInRangeOfPoint(playerid,3,BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ]))
		{
		    new TmpQuery[128];
			if(proplev >= 0)
			{
			    if(strcmp(x_job,"level",true) == 0)
			    {
					proptype = 2;
					propid = i;
					BizzInfo[i][bLevelNeeded] = proplev;
					format(TmpQuery, 128, "UPDATE `bizzes` SET `levelneeded` = '%d' WHERE `id` = '%d'", proplev, BizzInfo[i][bSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"price",true) == 0)
				{
					proptype = 2;
					propid = i;
					BizzInfo[i][bBuyPrice] = proplev;
					format(TmpQuery, 128, "UPDATE `bizzes` SET `buyprice` = '%d' WHERE `id` = '%d'", proplev, BizzInfo[i][bSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"funds",true) == 0)
				{
					proptype = 2;
					propid = i;
					BizzInfo[i][bTill] = proplev;
					format(TmpQuery, 128, "UPDATE `bizzes` SET `till` = '%d' WHERE `id` = '%d'", proplev, BizzInfo[i][bSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"locked",true) == 0)
				{
					proptype = 2;
					propid = i;
					BizzInfo[i][bLocked] = proplev;
				}
				else if(strcmp(x_job,"bizviwo",true) == 0)
				{
					proptype = 2;
					propid = i;
					BizzInfo[i][bVirtualWorld] = proplev;
					format(TmpQuery, 128, "UPDATE `bizzes` SET `virtualworld` = '%d' WHERE `id` = '%d'", proplev, BizzInfo[i][bSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
				else if(strcmp(x_job,"type",true) == 0)
				{
					proptype = 2;
					propid = i;
					if(proplev < 0 || proplev > 14) return SendClientMessage(playerid, COLOR_RED, "[ ! ]: Type range is 0-14!");
					BizzInfo[i][bType] = proplev;
					format(TmpQuery, 128, "UPDATE `bizzes` SET `type` = '%d' WHERE `id` = '%d'", proplev, BizzInfo[i][bSQLID]);
					mysql_tquery(g_SQL, TmpQuery, "", "");
				}
			}
		}
	}
	if(proptype != 0 && propid != -1)
	{
		switch(proptype)
		{
			case 1: va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You just adjusted %s on House ID %d[SQLID: %d][Adress: %s] on value %d.", x_job, propid, HouseInfo[propid][hSQLID], HouseInfo[propid][hAdress], proplev);
			case 2: va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You just adjusted %s on Bizz ID %d[SQLID: %d][Name: %s] on value %d.", x_job, propid, BizzInfo[propid][bSQLID], BizzInfo[propid][bMessage], proplev);
		}
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unfortunately, house/business for editing wasn't found in proximity.");
	return 1;
}
CMD:asellbiz(playerid, params[])
{
    new biz, foundonline = 0;
    if(sscanf(params, "i", biz)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellbiz [bizid]");
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{	
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pOnline] == true)
			{
				if(PlayerInfo[i][pSQLID] == BizzInfo[biz][bOwnerID])
				{
					PlayerInfo[i][pBizzKey] = INVALID_BIZNIS_ID;
					va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your business has been moved out by Game Admin %s, you got %s refund in return.", GetName(playerid, false), FormatNumber(BizzInfo[biz][bBuyPrice]));
					BudgetToPlayerMoney(i, BizzInfo[biz][bBuyPrice]);
					foundonline = 1;
				}
				if(BizzInfo[biz][bco_OwnerID] == PlayerInfo[i][pSQLID])
				{
					PlayerInfo[i][pBusiness] = INVALID_BIZNIS_ID;
					PlayerInfo[playerid][BizCoOwner] = false;
					va_SendClientMessage(i, COLOR_RED, "[ ! ] Your co-owned business has been moved out by Game Admin %s.", GetName(playerid, false));
				}
			}
		}
		new TmpQuery[128];
		// Update bizzes
		format( TmpQuery, sizeof(TmpQuery), "UPDATE `bizzes` SET `ownerid` = '0', `co_ownerid` = '0' WHERE `id` = '%d'", 
			BizzInfo[ biz ][bSQLID]
		);
		mysql_tquery(g_SQL, TmpQuery, "", "");
		if(foundonline == 0)
		{
			// Update accounts
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `handMoney` = `handMoney` + '%d' WHERE `sqlid` = '%d'", 
				BizzInfo[ biz ][bBuyPrice],
				BizzInfo[ biz ][bOwnerID]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			// Update proracun
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = `budget` - '%d'", 
				BizzInfo[ biz ][bBuyPrice]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
		}
		
		//------------------------------------------------------

		BizzInfo[biz][bLocked] 	= 1;
		BizzInfo[biz][bOwnerID] = 0;
		BizzInfo[biz][bco_OwnerID] = 0;
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold Business %s with admin command, buy price was returned to the previous owner!", BizzInfo[biz][bMessage]);
		format(globalstring, sizeof(globalstring), "Game Admin %s moved out Business %s [ID %d][SQLID: %d].",GetName(playerid, false), BizzInfo[biz][bMessage], biz, BizzInfo[biz][bSQLID]);
		SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_sellbiz.txt", "(%s) Game Admin %s moved out Business %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), BizzInfo[biz][bMessage], biz, BizzInfo[biz][bSQLID]);
		#endif
		
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have permissions to use this command.");
	return 1;
}

CMD:asellgarage(playerid, params[])
{
    new garage,
		TmpQuery[158];
    if(sscanf(params, "i", garage)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellgarage [garageid]");
	
	if(!Iter_Contains(Garages, garage)) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Garage ID %d doesn't exist!", garage);
		
	
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{	
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pGarageKey] == garage)
			{
				PlayerInfo[i][pGarageKey] = -1;
				va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your garage has been moved out by Game Admin %s!", GetName(playerid, false));
				break;
			}				
		}
		
		format( TmpQuery, sizeof(TmpQuery), "UPDATE `server_garages` SET `ownerid` = '0' WHERE `id` = '%d'", 
			GarageInfo[garage][gSQLID]
		);
		mysql_tquery(g_SQL, TmpQuery, "", "");
		
		GarageInfo[garage][gOwnerID] 				= 0;
		GarageInfo[ garage ][ gLocked ] 			= 1;
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "You sold garage %s with admin command!");
		format(globalstring, sizeof(globalstring), "Game Admin %s moved out garage %s[ID: %d][SQLID: %d].", GetName(playerid, false), GarageInfo[garage][gAdress], garage, GarageInfo[garage][gSQLID]);
		SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_sellhouse.txt", "(%s) Game Admin %s moved out garage %s[ID: %d][SQLID: %d].", ReturnDate(), GetName(playerid, false), GarageInfo[garage][gAdress], garage, GarageInfo[garage][gSQLID]);
		#endif
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have permissions to use this command.");
	return 1;
}

CMD:asellhouse(playerid, params[])
{
	new house, foundonline = 0;
    if(sscanf(params, "i", house)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellhouse [houseid]");
   	if(PlayerInfo[playerid][pAdmin] >= 1337) 
	{
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pOnline] == true && PlayerInfo[i][pSQLID] == HouseInfo[house][hOwnerID])
			{
				PlayerInfo[i][pHouseKey] = INVALID_HOUSE_ID;
				va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your house has been moved out by Game Admin %s, you got refunded buy price in return!", GetName(playerid, false));
				BudgetToPlayerMoney(i, HouseInfo[house][hValue]);
				foundonline = 1;
				break;
			}				
		}
		new TmpQuery[128];
		// Update houses
		format(TmpQuery, 128, "UPDATE `houses` SET `ownerid`='0' WHERE `ownerid` = '%d'", HouseInfo[ house ][hOwnerID]);
		mysql_tquery(g_SQL, TmpQuery, "", "");
		
		if(foundonline == 0)
		{
			// Update accounts
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `handMoney` = `handMoney` + '%d' WHERE `sqlid` = '%d'", 
				HouseInfo[ house ][hValue],
				HouseInfo[ house ][hOwnerID]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			
			// Update proracun
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = `budget` - '%d'", 
				HouseInfo[ house ][hValue]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
		}
		
			
		HouseInfo[house][hOwnerID]		= 0;
		HouseInfo[house][hLock] 		= 1;
		HouseInfo[house][hSafePass] 	= 0;
		HouseInfo[house][hSafeStatus] 	= 0;
	    HouseInfo[house][hOrmar] 		= 0;
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold a house on adress %s, buy price was returned to the previous owner!", HouseInfo[house][hAdress]);
		format(globalstring, sizeof(globalstring), "Game Admin %s moved out House on adress %s[ID %d][SQLID: %d]", GetName(playerid, false), HouseInfo[house][hAdress], house, HouseInfo[house][hSQLID]);
		SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_sellhouse.txt", "(%s) Game Admin %s moved out House on adress %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), HouseInfo[house][hAdress], house, HouseInfo[house][hSQLID]);
		#endif
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have permissions to use this command.");
	return 1;
}

// COMPLEX cmds - Woo 17.2.2018. --------------------------------------------------------------------------------------------------------
CMD:asellcomplex(playerid, params[])
{
	new complex, foundonline = 0;
    if(sscanf(params, "i", complex)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellcomplex [complexid]");
   	if(PlayerInfo[playerid][pAdmin] >= 1337) {
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pOnline] == true)
			{
				if(PlayerInfo[i][pSQLID] == ComplexInfo[complex][cOwnerID]) 
				{
					PlayerInfo[i][pComplexKey] = INVALID_COMPLEX_ID;
					va_SendClientMessage(i, COLOR_RED, "[ ! ]: Your Complex has been moved out by Game Admin %s, you got refunded buy price of it!", GetName(playerid, false));
					BudgetToPlayerMoney(i, ComplexInfo[ complex ][ cPrice ]);
					foundonline = 1;
					break;
				}
			}
		}
		
		new TmpQuery[128];
		
		// Update Complex MySQL table
		format(TmpQuery, 128, "UPDATE `server_complex` SET `owner_id`= '0' WHERE `id` = '%d'", ComplexInfo[ complex ][ cSQLID ]);
		mysql_tquery(g_SQL, TmpQuery, "", "");
		
		if(foundonline == 0)
		{
			// Update accounts
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `accounts` SET `handMoney` = `handMoney` + '%d' WHERE `sqlid` = '%d'", 
				ComplexInfo[complex][cPrice],
				ComplexInfo[complex][cOwnerID]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
			
			// Update proracun
			format( TmpQuery, sizeof(TmpQuery), "UPDATE `city` SET `budget` = `budget` - '%d'", 
				ComplexInfo[complex][cPrice]
			);
			mysql_tquery(g_SQL, TmpQuery, "", "");
		}
				
		ComplexInfo[complex][cOwnerID]		= 0;
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ]: You sold Complex %s with admin command, the owner got the buy price of Complex in return!", ComplexInfo[complex][cName]);
		format(globalstring, sizeof(globalstring), "Game Admin %s moved out Complex %s[ID %d][SQLID: %d]", GetName(playerid, false), ComplexInfo[complex][cName], complex, ComplexInfo[complex][cSQLID]);
		SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_sellcomplex.txt", "(%s) Game Admin %s moved out Complex %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), ComplexInfo[complex][cName], complex, ComplexInfo[complex][cSQLID]);
		#endif
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have permissions to use this command.");
	return 1;
}

CMD:asellcomplexroom(playerid, params[])
{
	new complex;
    if(sscanf(params, "i", complex)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /asellcomplexroom [complexroomid]");
   	if(PlayerInfo[playerid][pAdmin] >= 1337) {
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pOnline] == true)
			{
				if(PlayerInfo[i][pSQLID] == ComplexRoomInfo[complex][cOwnerID]) 
				{
					PlayerInfo[i][pComplexKey] = INVALID_COMPLEX_ID;
					va_SendClientMessage(i, COLOR_RED, "[ ! ]: You got moved out of Complex Room on adress %s by Game Admin %s!", ComplexRoomInfo[complex][cAdress], GetName(playerid, false));
					break;
				}
			}
		}
		
		//Enum
		PlayerInfo[playerid][pComplexRoomKey] = INVALID_COMPLEX_ID;
		PlayerInfo[ playerid ][ pSpawnChange ] = 3;
		ComplexRoomInfo[complex][cOwnerID] = 0;
		
		//SQL
		new
			Query[ 128 ];
		format( Query, sizeof(Query), "UPDATE `server_complex_rooms` SET `ownerid` = '0' WHERE `id` = '%d'",
			ComplexRoomInfo[ complex ][cSQLID]
		);
		mysql_tquery( g_SQL, Query, "", "" );
		
		format(Query, sizeof(Query), "UPDATE `accounts` SET `spawnchange` = '%d' WHERE `sqlid` = '%d'", 
			PlayerInfo[playerid][pSpawnChange],
			PlayerInfo[playerid][pSQLID]
		);
		mysql_tquery(g_SQL, Query);

		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Iselio si complex sobu admin komandom!");
		format(globalstring, sizeof(globalstring), "Game Admin %s moved out Complex Room on adress %s[ID %d][SQLID: %d]", GetName(playerid, false), ComplexRoomInfo[complex][cAdress], complex, ComplexRoomInfo[complex][cSQLID]);
		SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_sellcomplex.txt", "(%s) Game Admin %s moved out Complex Room on adress %s[ID %d][SQLID: %d]", ReturnDate(), GetName(playerid, false), ComplexRoomInfo[complex][cAdress], complex, ComplexRoomInfo[complex][cSQLID]);
		#endif
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "You don't have permissions to use this command.");
	return 1;
}

CMD:forumname(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pHelper])
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
		
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /forumname [nick]");
	else if(isnull(PlayerInfo[playerid][pForumName]))
		strcat(PlayerInfo[playerid][pForumName], params, 24);
	else
		return strdel(PlayerInfo[playerid][pForumName], 0, 24), SendClientMessage(playerid, COLOR_RED, "[ ! ] Obrisao si svoj forum nick!");
		
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si postavio forum ime!");
	return 1;
}

CMD:healcar(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new health;
	if (sscanf(params, "i", health)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /healcar [Iznos]");
	SetVehicleHealth(GetPlayerVehicleID(playerid), health);
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je healao svoj auto za %d", GetName(playerid,false), health);
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:fuelcars(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	foreach(new c: Vehicles)
		VehicleInfo[c][vFuel] = 100;

	SendClientMessage(playerid, COLOR_RED, "[ ! ] Svi auti napunjeni gorivom ! ");
	return 1;
}

CMD:fuelcar(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		fuel, vehicleid;
	if( sscanf( params, "ii", vehicleid, fuel ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /fuelcar [vehicleid][kolicina]");
	if( vehicleid == INVALID_VEHICLE_ID || !Iter_Contains(Vehicles, vehicleid) ) return SendClientMessage( playerid, COLOR_RED, "Nevaljan unos vehicleida!");
	if( 1 <= fuel <= 100 ) {
		VehicleInfo[ vehicleid ][ vFuel ] = fuel;
		va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Vozilo %d je napunjeno %d posto goriva!", vehicleid, fuel);
	} else SendClientMessage( playerid, COLOR_RED, "Kolicina mora biti izmedju 1 i 100!");
	return 1;
}

CMD:factionmembers(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new orgid;
	if (sscanf(params, "i", orgid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /factionmembers [Orgid]");
	if (orgid < 1 || orgid > 16) return SendClientMessage(playerid, COLOR_RED, "Ne dopusten unos (1-16)!");
	
	new selectFactionMemb[96];
	format(selectFactionMemb, sizeof(selectFactionMemb),"SELECT * FROM `accounts` WHERE `facMemId` = '%d' LIMIT 1", orgid);
    mysql_tquery(g_SQL, selectFactionMemb, "CountFactionMembers", "ii", playerid, orgid);
	return 1;
}

CMD:weather(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new weather;
	if (sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weather [Weatherid]");
	if (weather < 0 || weather > 45) return SendClientMessage(playerid, COLOR_RED, "ID vremena ne moze ici ispod 0 ili iznad 45!");
	SetPlayerWeather(playerid, weather);
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je sebi stavio vrijeme ID %d.", GetName(playerid,false), weather);
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:setstat(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid, stat, amount;
    if (sscanf(params, "uii", giveplayerid, stat, amount))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setstat [ID/DioImena] [Statcode] [Amount]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Level), (2 - SpawnHealth), (3 - UpgradePoints), (4 - Age), (5 Bank Money)");
		SendClientMessage(playerid, COLOR_GREY, "(6 - PhoneNumber), (7 - RespectPoints), (8 - HouseKey), (9 - BizKey), (10 - PremiumAccount)");
		SendClientMessage(playerid, COLOR_GREY, "(11 - Connected Time), (12 - Sex)");
		SendClientMessage(playerid, COLOR_GREY, "(13 - Seeds), (14 - Players Job), (15 - PlayerContractTime), (16 - VrijemeDoPlace)");
		SendClientMessage(playerid, COLOR_GREY, "(17 - Job Key), (18 - Muscle Skill), (19 - Puta uhicen), (20 - Changename Dozvola)");
		SendClientMessage(playerid, COLOR_GREY, "(21 - PayDay Money), (22 - DonateRank), (23 - Casino cool), (24 - Garage key)");
		SendClientMessage(playerid, COLOR_GREY, "(25 - Complex Key), (26 - Complex Room Key), (27 - Fishing skill)");
		return 1;
    }
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	switch (stat)
	{
		case 1:
		{
			PlayerInfo[giveplayerid][pLevel] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik je postavljen na level %d.", amount);
			SetPlayerScore( giveplayerid, amount );
			
			new levelUpUpdate[100];
			format(levelUpUpdate, 100, "UPDATE `accounts` SET `levels` = '%d', `respects` = '%d' WHERE `sqlid` = '%d'",
				PlayerInfo[giveplayerid][pLevel],
				PlayerInfo[giveplayerid][pRespects],
				PlayerInfo[giveplayerid][pSQLID]
			);
			mysql_tquery(g_SQL, levelUpUpdate);
		}
		case 2:
		{
			PlayerInfo[giveplayerid][pSHealth] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik ce se od sada stvarati sa %d energije.", amount);
		}
		case 3:
		{
			format(globalstring, sizeof(globalstring), "   Korisnikovi Upgrade Poeni su postavljeni na %d.", amount);
  		}
		case 4:
		{
		    PlayerInfo[giveplayerid][pAge] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikove godine su promjenjene na %d.", amount);
		}
		case 5:
		{
			PlayerInfo[giveplayerid][pMoney] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada na banci ima $%d novaca.", amount);
  		}
		case 6:
		{
		    PlayerInfo[giveplayerid][pMobileNumber] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov broj telefona je postavljen na %d.", amount);
  		}
		case 7:
		{
		    PlayerInfo[giveplayerid][pRespects] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikovi Respekt Poeni su postavljeni na %d.", amount);
  		}
		case 8:
		{
		    PlayerInfo[giveplayerid][pHouseKey] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima kljuc od kuce broj %d.", amount);
  		}
		case 9:
		{
		    PlayerInfo[giveplayerid][pBizzKey] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima kljuc od tvrtke broj %d.", amount);
  		}
		case 10:
		{
		    PlayerInfo[giveplayerid][pDonateRank] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik je sada Premium Account Level %d.", amount);
  		}
		case 11:
		{
		    PlayerInfo[giveplayerid][pConnectTime] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikovo ukupno vrijeme provedeno na serveru je postavljeno na %d.", amount);
			new log[126], Day, Month, Year,
				playerip[MAX_PLAYER_IP];
			getdate(Year,Month,Day);
			GetPlayerIp(playerid, playerip, sizeof(playerip));
			
			#if defined MODULE_LOGS
			format(log, sizeof(log), "[%02d/%02d/%d] %s[%s] je stavio vrijeme %s na %d sata.", Day, Month, Year, \
				GetName(playerid,false), playerip, GetName(giveplayerid,false), PlayerInfo[giveplayerid][pConnectTime]);
			LogSetStatConnectedTime(log);
			#endif
  		}
		case 12:
		{
		    PlayerInfo[giveplayerid][pSex] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov spol je postavljen na %d.", amount);
  		}
		case 13:
		{
        	PlayerInfo[giveplayerid][pSeeds] = amount;
            format(globalstring, sizeof(globalstring), "   Korisnikovi Seedsi za maricu postavljeni na %d.", amount);
  		}
		case 14:
		{
			if(PlayerInfo[giveplayerid][pJob] != 0) 
				RemovePlayerJob(giveplayerid);
					
			SetPlayerJob(giveplayerid, amount);
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima posao broj %d.", amount);
  		}
		case 15:
		{
            PlayerInfo[giveplayerid][pContractTime] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov ugovor je postavljen na %d.", amount);
  		}
  		case 16:
  		{
  		    PlayerInfo[giveplayerid][pPayDay] = amount;
  		    format(globalstring, sizeof(globalstring), "   Korisnikovo vrijeme do place je postavljeno na %d.", amount);
  		}
		case 17:
		{
		    PlayerInfo[giveplayerid][pJob] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov Job Key je postavljen na %d.", amount);
  		}
		case 18:
		{
		    PlayerInfo[giveplayerid][pMuscle] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov Muscle Skill je postavljen na %d.", amount);
  		}
		case 19:
		{
		    PlayerInfo[giveplayerid][pArrested] = amount;
			format(globalstring, sizeof(globalstring), "   Namjestio si da je korisnik uhicen %d puta.", amount);
  		}
		case 20:
		{
		    PlayerInfo[giveplayerid][pChangeTimes] = amount;
		    format(globalstring, sizeof(globalstring), "   Namjestio si da korisnik moze koristiti /changename %d puta.", amount);
			// Log
			Log_Write("logfiles/approve_changename.txt", "(%s) %s[A%d] je dozvolio %d /changenameova %s[SQLID: %d].",
				ReturnDate(),
				GetName(playerid,false),
				PlayerInfo[playerid][pAdmin],
				amount,
				GetName(giveplayerid,false),
				PlayerInfo[giveplayerid][pSQLID]
			);
  		}
		case 21:
		{
		    PlayerInfo[giveplayerid][pPayDayMoney] += amount;
		    format(globalstring, sizeof(globalstring), "   Korisnikov Payday money je sada %d", amount);
		}
		case 22:
		{
		    PlayerInfo[giveplayerid][pDonateRank] = amount;
		    format(globalstring, sizeof(globalstring), "   Korisnikov DonateRank je sada %d", amount);
		}
		case 23:
		{
			PlayerInfo[giveplayerid][pCasinoCool] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov Casino Cooldown je sada %d", amount);
		}
		case 24:
		{
			PlayerInfo[giveplayerid][pGarageKey] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnikov Garage key je sada %d", amount);
		}
		case 25:
		{
		    PlayerInfo[giveplayerid][pComplexKey] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima kljuc od complexa broj %d.", amount);
  		}
		case 26:
		{
		    PlayerInfo[giveplayerid][pComplexRoomKey] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima kljuc od complex sobe broj %d.", amount);
  		}
  		case 27:
		{
		    PlayerInfo[playerid][pFishingSkill] = amount;
			format(globalstring, sizeof(globalstring), "   Korisnik sada ima skill posla ribar  %d.", amount);
  		}
		default:
			SendClientMessage(playerid, COLOR_RED, "Krivi kod stats-a!");
	}
	SendClientMessage(playerid, COLOR_SKYBLUE, globalstring);
	return 1;
}

CMD:skin(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, skin;
	if (sscanf(params, "ui", giveplayerid, skin)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /skin [ID/DioImena] [Skin id]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	//if (skin > 320 || skin < 0) return SendClientMessage(playerid, COLOR_RED, "Ne idite ispod 0 i preko 320!");
	
	SetPlayerSkin(giveplayerid, skin);
	PlayerInfo[giveplayerid][pSkin] = skin;
	PlayerInfo[giveplayerid][pChar] = skin;
	
	// MySQL Query
	new skinUpdateQuery[128];
	format(skinUpdateQuery, 128, "UPDATE `accounts` SET `playaSkin` = '%d' WHERE `sqlid` = '%d'", PlayerInfo[giveplayerid][pChar], PlayerInfo[giveplayerid][pSQLID]);
	mysql_tquery(g_SQL, skinUpdateQuery);
	return 1;
}

CMD:fstyle(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, item, string[64];
	if (sscanf(params, "ui", giveplayerid, item))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fstyle [ID/DioImena] [Opcija]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Normal), (2 - Boxing), (3 - Kung Fu), (4 - Kneehead), (5 - Grabback) (6 - Elbow)");
		return 1;
	}
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	switch(item)
 	{
  		case 1:
    	{
     		format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Normal.", GetName(playerid,false));
       		SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
         	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Normal.", GetName(giveplayerid,false));
          	SendClientMessage(playerid, COLOR_SKYBLUE, string);
           	SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_NORMAL);
            PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_NORMAL;
     	}
      	case 2:
       	{
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Boxing.", GetName(playerid,false));
         	SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
          	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Boxing.", GetName(giveplayerid,false));
            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_BOXING);
	        PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_BOXING;
        }
        case 3:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Kung Fu.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na Kung Fu.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_KUNGFU);
	        PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_KUNGFU;
        }
        case 4:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na KneeHead.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na KneeHead.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_KNEEHEAD);
	        PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_KNEEHEAD;
        }
        case 5:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na GrabBack.", GetName(playerid,false));
	        SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	        format(string, sizeof(string), "* Postavio si igracu %s fighting style na GrabBack.", GetName(giveplayerid,false));
	        SendClientMessage(playerid, COLOR_SKYBLUE, string);
         	SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_GRABKICK);
	        PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_GRABKICK;
        }
        case 6:
        {
        	format(string, sizeof(string), "* Admin %s je postavio vas fighting style na Elbow.", GetName(playerid,false));
         	SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
          	format(string, sizeof(string), "* Postavio si igracu %s fighting style na Elbow.", GetName(giveplayerid,false));
           	SendClientMessage(playerid, COLOR_SKYBLUE, string);
            SetPlayerFightingStyle(giveplayerid, FIGHT_STYLE_ELBOW);
            PlayerInfo[giveplayerid][pFightStyle] = FIGHT_STYLE_ELBOW;
	    }
  		default:
  		SendClientMessage(playerid, COLOR_RED, "Krivi broj opcije!");
  	}
	return 1;
}

// Administrator Level 4
CMD:rac(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	va_SendClientMessageToAll(COLOR_LIGHTRED, "[AdmCmd]: Admin %s je respawnao sva non-occupied vozila na serveru.", GetName(playerid));
	foreach(new c : Vehicles) {
		if( !IsVehicleOccupied(c) )
			SetVehicleToRespawn(c);
	}
	return 1;
}

new
	player_pip[35];

hook OnPlayerConnect(playerid)
{
	GetPlayerIp(playerid, player_pip, sizeof(player_pip));
	ResetAdminVehVars(playerid);
	return 1;
}

CMD:timeout(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
		
	new
	    user;
		
	if(sscanf(params, "u", user))
	    return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /timeout [DioImena/PlayerID]");

	new
	    str[35];

	format(str, 35, "banip %s", ReturnPlayerIP(user));
	SendRconCommand(str);
	
	SetTimerEx("TimeoutPlayer", 2000, false, "d", user);
	//BlockIpAdress(
	
	return 1;
}
forward TimeoutPlayer(playerid);
public TimeoutPlayer(playerid)
{
	new
		string[44];

	format(string, sizeof(string), "unbanip %s", player_pip);
 	SendRconCommand(string);
	
	SendRconCommand("reloadbans");
 	return 1;
}

CMD:sethp(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new
	    giveplayerid,
	    Float:health;

	if (sscanf(params, "uf", giveplayerid, health)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /sethp [ID/DioImena] [Health]");
	if (health > 100) return SendClientMessage(playerid, COLOR_RED, "Ne mozete vise od 100hp-a nekome dati.");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerHealth(giveplayerid, health);
	return 1;
}

CMD:setarmour(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    Float:armour;
	if (sscanf(params, "uf", giveplayerid, armour)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setarmour [ID/DioImena] [Armor]");
	if (armour < 0.0 || armour > 99.9) return SendClientMessage(playerid, COLOR_RED, "Minimalan unos je 0, a maksimalan 99.9!");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerArmour(giveplayerid, armour);
	Bit1_Set(gr_SaveArmour, giveplayerid, true);
	return 1;
}

CMD:veh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new car, color1, color2, engine, lights, alarm, doors, bonnet, boot, objective;
	if (sscanf(params, "iii", car, color1, color2)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /veh [Model] [Color(1)] [Color(2)]");
	if (car < 400 || car > 611) return SendClientMessage(playerid, COLOR_RED, "Broj auta ne moze ici ispod 400 ili iznad 611!");
	if (color1 < 0 || color1 > 255) return SendClientMessage(playerid, COLOR_RED, "Broj boje ne moze ici ispod 0 ili iznad 255!");
	if (color2 < 0 || color2 > 255) return SendClientMessage(playerid, COLOR_RED, "Broj boje ne moze ici ispod 0 ili iznad 255!");
	if(Admin_vCounter[playerid] == 5)
		return SendErrorMessage(playerid, "Vec imate maximalno vozila spawnovano (5).");
	
	
	new
		Float:X, Float:Y, Float:Z, Float:ang;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid, ang);
	new carid = AC_CreateVehicle(car, X, Y+4, Z+3, ang, color1, color2, 60000,0);
	ResetVehicleInfo(carid);

	VehiclePrevInfo[carid][vPosX] = X;
	VehiclePrevInfo[carid][vPosY] = Y;
	VehiclePrevInfo[carid][vPosZ] = Z;
	VehiclePrevInfo[carid][vRotZ] = 0.0;
	VehiclePrevInfo[carid][vPosDiff] = 0.0;
	
	VehicleInfo[ carid ][ vModel ] 		= car;
	VehicleInfo[ carid ][ vColor1 ] 	= color1;
	VehicleInfo[ carid ][ vColor2 ] 	= color2;
	VehicleInfo[ carid ][ vParkX ]		= X;
	VehicleInfo[ carid ][ vParkY ]      = Y;
	VehicleInfo[ carid ][ vParkZ ]      = Z;
	VehicleInfo[ carid ][ vAngle ]      = 0.0;
	VehicleInfo[ carid ][ vHealth ]		= 1000.0;
	VehicleInfo[ carid ][ vType ]		= VEHICLE_TYPE_CAR;
	VehicleInfo[ carid ][ vUsage ] 		= VEHICLE_USAGE_NORMAL;
	VehicleInfo[ carid ][ vInt ]		= GetPlayerInterior(playerid);
	VehicleInfo[ carid ][ vViwo ]		= GetPlayerVirtualWorld(playerid);
	
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(carid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	PutPlayerInVehicle(playerid, carid, 0);
	CreatedCar ++;
	CreateAdminVehicles(playerid, carid);
	
	format(globalstring, sizeof(globalstring), "[ ! ] Spawnali ste vozilo ID %d, Model: %d. (/veh)", carid, car);
	SendClientMessage(playerid, COLOR_RED, globalstring);
	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
	return 1;
}

CMD:veh_spawned(playerid, params[]) {
	if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(1337+)!");
	ShowAdminVehicles(playerid);
	return (true);
}

CMD:givelicense(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande(1337+)!");
	new giveplayerid, item, string[64];
	if (sscanf(params, "ui", giveplayerid, item))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givelicense [ID/DioImena] [Vrsta]");
		SendClientMessage(playerid, COLOR_GREY, "(1 - Drivinglicense), (2 - Gunlicense), (3- Flyinglicense), (4 - Boatlicense), (5 - Fishlicense)");
		return 1;
	}
	if (IsPlayerConnected(giveplayerid))
	{
	    switch(item)
	    {
	        case 1:
	        {
	            PlayerInfo[giveplayerid][pCarLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Drivinglicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Drivinglicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 2:
	        {
				//new vrsta;
				if (sscanf(params, "uii", giveplayerid, item))
				{
					SendClientMessage(playerid, COLOR_WHITE, "[ ? ]: /givelicense [Playerid/DioImena] [odabir] ");
					//SendClientMessage(playerid, COLOR_GREEN, "Tipovi: 1 - Concealed Carry Weapon(CCW),  2 - Open Carry Weapons + CC (OCW)");
					return 1;
				}
				//if(vrsta > 2 || vrsta < 0) return SendClientMessage(playerid, COLOR_RED, "   Nemoj ici ispod broja 0, ili iznad 2!");
	    		PlayerInfo[giveplayerid][pGunLic] = 1;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
	            format(string, sizeof(string), "* Admin %s vam je dao Gunlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Gunlicensu.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 3:
	        {
	            PlayerInfo[giveplayerid][pFlyLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Flyinglicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Flyinglicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 4:
	        {
	            PlayerInfo[giveplayerid][pBoatLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Boatlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Boatlicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        case 5:
	        {
	            PlayerInfo[giveplayerid][pFishLic] = 1;
	            format(string, sizeof(string), "* Admin %s vam je dao Fishlicense.", GetName(playerid,false));
	            SendClientMessage(giveplayerid, COLOR_SKYBLUE, string);
	            format(string, sizeof(string), "* Dao si %s Fishlicense.", GetName(giveplayerid,false));
	            SendClientMessage(playerid, COLOR_SKYBLUE, string);
	        }
	        default:
	        SendClientMessage(playerid, COLOR_RED, "Krivi ID license!");
	    }
	}
	return 1;
}
#if defined MODULE_DEATH
CMD:undie(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
 	new
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /undie [dio imena/playerid]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, " Nevaljan playerid!");
	
	DestroyDeathInfo(giveplayerid);
	DestroyDeathTDs(giveplayerid);
	KillTimer(DeathTimer[giveplayerid]);

	Bit8_Set(gr_DeathCountSeconds, giveplayerid, 0);
	Bit1_Set(gr_DeathCountStarted, giveplayerid, false);
	
    DeathData[ giveplayerid ][ ddOverall ] = 0;

	PlayerInfo[ giveplayerid ][ pDeath ][ 0 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 1 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeath ][ 2 ] 	= 0.0;
	PlayerInfo[ giveplayerid ][ pDeathInt ] 	= 0;
	PlayerInfo[ giveplayerid ][ pDeathVW ] 		= 0;
	PlayerInfo[ giveplayerid ][ pKilled ] 	 	= 0;

	ResetPlayerWounded(giveplayerid);

	SetPlayerHealth(giveplayerid, 25.0);
	TogglePlayerControllable(giveplayerid, true);

	new
		deleteQuery[128];
	format(deleteQuery, 128, "DELETE FROM `player_deaths` WHERE `player_id` = '%d'", PlayerInfo[giveplayerid][pSQLID]);
	mysql_tquery(g_SQL, deleteQuery, "", "");

 	format(globalstring, sizeof(globalstring), "AdmWarn: %s je ugasio RPDeath stanje korisniku %s!", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);

	format(globalstring, sizeof(globalstring), "[ ! ] Admin %s vam je ugasio RPDeath stanje sada mozete normalno igrati!", GetName(playerid,false));
	SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	return 1;
}
#endif
CMD:unfreezearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
        if (IsPlayerConnected(i))
	    {
    	    if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) TogglePlayerControllable(i, 1); Frozen[i] = false;
		}
	}
	return 1;
}

CMD:freezearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
        if (IsPlayerConnected(i))
	    {
    	    if(IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) TogglePlayerControllable(i, 0); Frozen[i] = true;
	    }
	}
	return 1;
}

CMD:setarmoraround(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new Float:amount;
   	if (sscanf(params, "f", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setarmoraround [Iznos]");
    if (amount < 0 || amount > 99.9) return SendClientMessage(playerid, COLOR_RED, "Iznos mora biti izmedju 0 i 99.9!");
    new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
    foreach (new i : Player)
	{
	    if (IsPlayerConnected(i))
	    {
	        if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) { SetPlayerArmour(i, amount); Bit1_Set(gr_SaveArmour, playerid, true); }
	    }
	}
    return 1;
}

CMD:sethparound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new Float:amount;
   	if (sscanf(params, "f", amount)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /sethparound [Iznos]");
    if (amount < 0 || amount > 100) return SendClientMessage(playerid, COLOR_RED, "Iznos mora biti izmedju 0 i 100!");
	new
		Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    foreach (new i : Player)
	{
	    if (IsPlayerConnected(i))
	    {
	        if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid) SetPlayerHealth(i, amount);
	    }
	}
    return 1;
}


CMD:fixveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (IsPlayerInAnyVehicle(playerid))
	{
	    RepairVehicle(GetPlayerVehicleID(playerid));
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vBodyArmor] == 1) 
			AC_SetVehicleHealth(GetPlayerVehicleID(playerid), 1600.0);
		else
			AC_SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
		
		if(VehicleInfo[GetPlayerVehicleID(playerid)][vTireArmor] == 1)
		{
			vTireHP[GetPlayerVehicleID(playerid)][0] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][1] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][2] = 100;
			vTireHP[GetPlayerVehicleID(playerid)][3] = 100;
		}
		VehicleInfo[ GetPlayerVehicleID(playerid) ][ vCanStart ] = 1;
		VehicleInfo[ GetPlayerVehicleID(playerid) ][ vDestroyed ] = false;
	    TogglePlayerControllable(playerid, 1);
	    SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si popravio vozilo. (/fixveh)");
	}
	return 1;
}

CMD:fixaveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car;
    if (sscanf(params, "i", car)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fixaveh [VehID]");
    
    RepairVehicle(car);
	if(VehicleInfo[car][vBodyArmor] == 1)
		AC_SetVehicleHealth(car, 1600.0);
	else
		AC_SetVehicleHealth(car, 1000.0);

	if(VehicleInfo[car][vTireArmor] == 1)
	{
		vTireHP[car][0] = 100;
		vTireHP[car][1] = 100;
		vTireHP[car][2] = 100;
		vTireHP[car][3] = 100;
	}
	VehicleInfo[ car ][ vCanStart ] = 1;
	VehicleInfo[ car ][ vDestroyed ] = false;
    TogglePlayerControllable(playerid, 1);
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno si popravio vozilo ID: %d.", car);
	return 1;
}

CMD:aunlock(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car;
    if (sscanf(params, "i", car)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aunlock [CarID]");
	UnLockCar(car);
	format(globalstring, sizeof(globalstring), "Automobil ID: %d je otkljucan samo za vas.", car);
	SendClientMessage(playerid, -1, globalstring);
	return 1;
}

CMD:atake(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    x_nr[24],
	    giveplayerid;
    if (sscanf(params, "s[24]u", x_nr, giveplayerid))
	{
 		SendClientMessage(playerid, COLOR_SKYBLUE, "|___________________Oduzmite predmet____________________|");
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /atake [Predmet] [ID/DioImena]");
		SendClientMessage(playerid, -1, "Predmeti: Driverslicense, Flyinglicense, Boatlicense, Fishinglicense, Weaponlicense, Weapons, Drugs, Materials");
		SendClientMessage(playerid, COLOR_SKYBLUE, "|___________________________________________________|");
		return 1;
	}
	if (strcmp(x_nr, "driverslicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s vozacku dozvolu.", GetName(giveplayerid,false));
  		SendClientMessage(playerid, -1, globalstring);
    	format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo vozacku dozvolu.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    PlayerInfo[giveplayerid][pCarLic] = false;
	}
	else if (strcmp(x_nr, "flyinglicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
  		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za avione.", GetName(giveplayerid,false));
    	SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za avione.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    PlayerInfo[giveplayerid][pFlyLic] = false;
	}
	else if (strcmp(x_nr, "boatlicense", true) == 0)
	{
	    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
 	    format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za brodove.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za brodove.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    PlayerInfo[giveplayerid][pBoatLic] = false;
	}
	else if (strcmp(x_nr, "fishinglicense", true) == 0)
	{
	    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za ribolov.", GetName(giveplayerid,false));
		SendClientMessage(playerid, -1, globalstring);
		format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za ribolov.", GetName(playerid,false));
		SendClientMessage(giveplayerid, -1, globalstring);
		PlayerInfo[giveplayerid][pFishLic] = false;
	}
	else if (strcmp(x_nr, "weaponlicense", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
  		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s dozvolu za oruzje.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo dozvolu za oruzje.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    PlayerInfo[giveplayerid][pGunLic] = 0;
	}
	else if (strcmp(x_nr, "weapons", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s oruzje.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo oruzje.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    AC_ResetPlayerWeapons(giveplayerid);
	}
	else if (strcmp(x_nr, "drugs", true) == 0)
	{
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		format(globalstring, sizeof(globalstring), "* Oduzeli ste %s drogu.", GetName(giveplayerid,false));
	    SendClientMessage(playerid, -1, globalstring);
	    format(globalstring, sizeof(globalstring), "* Admin %s vam je oduzeo drogu.", GetName(playerid,false));
	    SendClientMessage(giveplayerid, -1, globalstring);
	    DeletePlayerDrug(giveplayerid, -1);
	}
	return 1;
}

CMD:mutearound(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach (new i : Player)
	{
		if (IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && i != playerid)
		{
			if (PlayerInfo[i][pMuted] == 1) PlayerInfo[i][pMuted] = 0;
			else if (PlayerInfo[i][pMuted] == 0) PlayerInfo[i][pMuted] = 1;
		}
	}
	return 1;
}

// Administrator Level 3
CMD:pns(playerid, params[]) {
	if (PlayerInfo[playerid][pAdmin] < 3) 
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(pns_garages == false) {
		pns_garages = true;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste omogucili koriscenje Pay'n'Spray garaza.");
	}
	else if(pns_garages == true) {
		pns_garages = false;
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste onemogucili koriscenje Pay'n'Spray garaza.");
	}
	return (true);
}

CMD:blockreport(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /blockreport [ID/DioImena]");
	if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if( !Bit1_Get(gr_Blockedreport, giveplayerid)) {
		Bit1_Set(gr_Blockedreport, giveplayerid, true );
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je zabranio %s da salje reporte.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je zabranio da saljes reporte.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	else if (Bit1_Get(gr_Blockedreport, giveplayerid)) {
		Bit1_Set(gr_Blockedreport, giveplayerid, false);
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je dopustio %s da ponovno salje reporte.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je dopustio da ponovno saljes reporte.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	return 1;
}

CMD:fpm(playerid, params[])
{
    if( PlayerInfo[playerid][pAdmin] < 3 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new 
		giveplayerid;
    if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /fpm [ID/DioImena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    if( PlayerInfo[giveplayerid][pAdmin] >= 1 ) return SendClientMessage(playerid, COLOR_RED, "Adminima i Helperima se ne blokiraju PMovi.");
	if( !Bit1_Get(gr_ForbiddenPM, giveplayerid)) {
		Bit1_Set(gr_ForbiddenPM, giveplayerid, true );
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je zabranio %s da salje PMove", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je zabranio da saljes PMove.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	else if (Bit1_Get(gr_ForbiddenPM, giveplayerid)) {
		Bit1_Set(gr_ForbiddenPM, giveplayerid, false);
		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je dopustio %s da ponovno salje PMove.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
		format(globalstring,sizeof(globalstring),"[ ! ] Admin %s ti je dopustio da ponovno saljes PMove.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	}
	return 1;
}

CMD:fpmed(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	SendClientMessage(playerid, COLOR_GREY, "Igraci kojima je zabranje slanje PMova:");
	foreach (new i : Player)
	{
		if (IsPlayerConnected(i))
		{
 			if (Bit1_Get(gr_ForbiddenPM, i))
			{
				format(globalstring, sizeof(globalstring), "[%d] %s", i, GetName(i));
				SendClientMessage(playerid, -1, globalstring);
			}
		}
	}
	return 1;
}

CMD:getcar(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new plo;
	if (sscanf(params, "i", plo)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /getcar [CarID]");
	
	new
		Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetVehiclePos(plo, X-floatsin(2.0, degrees), Y+floatcos(2.0, degrees), Z);
	LinkVehicleToInterior(plo, GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
	return 1;
}

CMD:entercar(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new testcar, seat;
    if (sscanf(params, "ii", testcar, seat)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /entercar [CarID] [seat]");
	PutPlayerInVehicle(playerid, testcar, seat);
	return 1;
}

CMD:putplayerincar(playerid, params[])
{

    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, testcar, seat;
    if (sscanf(params, "uii", giveplayerid, testcar, seat)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /putplayerincar [playerid] [carID] [seat]");
	PutPlayerInVehicle(giveplayerid, testcar, seat);
	return 1;
}

CMD:gotomark(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new id;
	
    if (sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gotomark [1-5]");
	if (id > 5 || id < 1) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 5!");
	if (id == 1)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, PlayerInfo[playerid][pMarker1][0],PlayerInfo[playerid][pMarker1][1],PlayerInfo[playerid][pMarker1][2]);
		}
		else
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pMarker1][0], PlayerInfo[playerid][pMarker1][1], PlayerInfo[playerid][pMarker1][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 1");
	}
	else if (id == 2)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, PlayerInfo[playerid][pMarker2][0],PlayerInfo[playerid][pMarker2][1],PlayerInfo[playerid][pMarker2][2]);
		}
		else
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pMarker2][0], PlayerInfo[playerid][pMarker2][1], PlayerInfo[playerid][pMarker2][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 2");
	}
	else if (id == 3)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, PlayerInfo[playerid][pMarker3][0],PlayerInfo[playerid][pMarker3][1],PlayerInfo[playerid][pMarker3][2]);
		}
		else
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pMarker3][0], PlayerInfo[playerid][pMarker3][1], PlayerInfo[playerid][pMarker3][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 3");
	}
	else if (id == 4)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, PlayerInfo[playerid][pMarker4][0], PlayerInfo[playerid][pMarker4][1], PlayerInfo[playerid][pMarker4][2]);
		}
		else
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pMarker4][0], PlayerInfo[playerid][pMarker4][1], PlayerInfo[playerid][pMarker4][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 4");
	}
	else if (id == 5)
	{
		if (GetPlayerState(playerid) == 2)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, PlayerInfo[playerid][pMarker5][0], PlayerInfo[playerid][pMarker5][1], PlayerInfo[playerid][pMarker5][2]);
		}
		else
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pMarker5][0], PlayerInfo[playerid][pMarker5][1], PlayerInfo[playerid][pMarker5][2]);
	 	    SetPlayerInterior(playerid, 0);
  			SetPlayerVirtualWorld(playerid, 0);
		}
		SendClientMessage(playerid, -1, "Teleportirani ste na oznaku 5");
	}
	return 1;
}

CMD:mark(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new id;
	
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mark [1-5]");
	if (id > 5 || id < 1) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 5!");
	if (id == 1)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pMarker1][0], PlayerInfo[playerid][pMarker1][1], PlayerInfo[playerid][pMarker1][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 1.");
	}
	else if (id == 2)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pMarker2][0], PlayerInfo[playerid][pMarker2][1], PlayerInfo[playerid][pMarker2][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 2.");
	}
	else if (id == 3)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pMarker3][0], PlayerInfo[playerid][pMarker3][1], PlayerInfo[playerid][pMarker3][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 3.");
	}
	else if (id == 4)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pMarker4][0], PlayerInfo[playerid][pMarker4][1], PlayerInfo[playerid][pMarker4][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 4.");
	}
	else if (id == 5)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pMarker5][0],PlayerInfo[playerid][pMarker5][1], PlayerInfo[playerid][pMarker5][2]);
		SendClientMessage(playerid, -1, "Teleporter destinacija 5.");
	}
	return 1;
}

// Administrator Level 2
CMD:jobids(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	SendClientMessage( playerid, COLOR_LIGHTBLUE, "*_____________________ POSLOVI _____________________*");
	SendClientMessage( playerid, COLOR_GREY, "LEGALNI: 1 - Sweeper, 2 - Pizza Boy, 3 - Mehanicar, 4 - Kosac trave, 5 - Tvornicki Radnik, 6 - Taksist, 7 - Farmer, 8 - Rudar");
	SendClientMessage( playerid, COLOR_GREY, "LEGALNI: 14 - Drvosjeca, 15 - Trucker, 16 - Smecar");
	SendClientMessage( playerid, COLOR_GREY, "10 - Drug Dealer, 12 - Gun Dealer, 13 - Car Jacker");
	return 1;
}
CMD:buyparkall(playerid, params[])
{
	new
	    Query[128],
		giveplayerid;
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /buyparkall [playerid/dio imena]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	format(Query, sizeof(Query), "SELECT COUNT(ownerid) FROM cocars WHERE ownerid = '%d'",
	    PlayerInfo[giveplayerid][pSQLID]
	);
	mysql_tquery(g_SQL, Query, "OfflinePlayerVehicles", "ii", playerid, giveplayerid);
	return 1;
}
CMD:getip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new	
		giveplayerid;
	if( sscanf( params, "u", giveplayerid ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /getip [playerid/dio imena]");
	new
		playaIp[ 20 ],
		tmpString[ 54 ];
		
	GetPlayerIp( giveplayerid, playaIp, 16 );
	format( tmpString, sizeof(tmpString), "[ ! ] Playerov IP: %s", 
		playaIp
	);
	SendClientMessage( playerid, COLOR_RED, tmpString );
	return 1;
}
CMD:iptoname(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		ip[ MAX_PLAYER_IP ];
	if(sscanf(params, "s[24]", ip)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /iptoname [IP adresa]");
	if(strcount(ip, ".") < 3) return SendClientMessage(playerid, COLOR_RED, "Niste unijeli valjnu IP adresu!");
	new
		ipToNameQuery[ 256 ];
	mysql_format(g_SQL, ipToNameQuery, 256, "SELECT `name`,`online`,`lastip` FROM  `player_connects` INNER JOIN  `accounts` ON accounts.sqlid = player_connects.player_id WHERE `aip` = '%e'", ip);
	mysql_tquery(g_SQL, ipToNameQuery, "LoadNamesFromIp", "is", playerid, ip);
	return 1;
}

CMD:lastdriver(playerid, params[])
{
	new vpick, tmpString[128];
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (sscanf(params,"d", vpick)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /lastdriver [VehicleID]");
	if(!strlen(LastDriver[vpick])) return SendClientMessage(playerid, COLOR_RED, "Vozilo ne postoji ili nije vozeno!");
	format(tmpString, sizeof(tmpString), "[ ! ] Vozilo ID %d je zadnji vozio %s", vpick, LastDriver[vpick]);
	SendClientMessage(playerid, COLOR_RED, tmpString);
	return 1;
}

CMD:prisonex(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    sati,
		reason[20];
    if (sscanf(params,"s[24]is[20]", targetname, sati, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /prisonex [Ime] [minute] [Razlog]");
    if (strlen(reason) < 1 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");

   	mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 1", targetname);
    mysql_tquery(g_SQL, mysqlquery, "CheckPlayerPrison", "isis", playerid, targetname, sati, reason);
	
	new sqlid, prsnQuery[256];
	mysql_format(g_SQL, prsnQuery, sizeof(prsnQuery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", targetname);
	
	new 
		Cache:result = mysql_query(g_SQL, prsnQuery);
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	
	new
		forumname[ MAX_PLAYER_NAME ],
		tmp_reason[ 32 ];
		
	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	
	mysql_format( g_SQL, prsnQuery, sizeof(prsnQuery), "INSERT INTO prisons (`id_igraca`,`name`, `forumname`, `time`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		sqlid,
		targetname,
		PlayerInfo[playerid][pForumName],
		sati,
		tmp_reason,
		date
	);
	mysql_tquery(g_SQL, prsnQuery, "", "");
	return 1;
}

CMD:warnex(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    reason[20];
    if (sscanf(params,"s[24]s[20]", targetname, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warnex [Ime] [Razlog]");
	if (strlen(reason) < 1 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");
   	
   	mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 1", targetname);
    mysql_tquery(g_SQL, mysqlquery, "LoadPlayerWarns", "iss", playerid, targetname, reason);
	
	new sqlid, TmpQuery[200];
	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e'", targetname);
	
	new 
		Cache:result = mysql_query(g_SQL, TmpQuery);
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	
	new
		forumname[ MAX_PLAYER_NAME ],
		tmp_reason[ 32 ];
		
	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	
	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "INSERT INTO warns (`id_igraca`,`name`, `forumname`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%e', '%e')",
		sqlid,
		targetname,
		PlayerInfo[playerid][pForumName],
		tmp_reason,
		date
	);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

CMD:ban(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid, reason[21],  days;
		
    if (sscanf(params,"us[21]i", giveplayerid, reason, days)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ban [ID/Dio imena] [Razlog][Dana (-1 za 4life)]");
	
	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "Igrac je offline! Koristi /banex.");
		
	new string[128];
	if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
	{
		format(string, sizeof(string), "AdmCmd: %s je dobio automatski kick poku�avajuci banovati veceg admina.", GetName(playerid, true));
		SendAdminMessage(COLOR_RED,string);
		KickMessage(playerid);
		return 1;
	}
	
	#if defined MODULE_BANS
	HOOK_Ban(giveplayerid, playerid, reason, days, false);
	#endif
	return 1;
}

CMD:unprison(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, year, month, day;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unprison [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    getdate(year, month, day);
	format(globalstring, sizeof(globalstring), "Admin: %s, Igrac: %s, Datum: (%d-%d-%d)", GetName(playerid,false), GetName(giveplayerid,false), month, day, year);
	format(globalstring, sizeof(globalstring), "[ ! ] Admin: %s je oslobodio Igraca: %s iz Fort DeMorgan", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "* Oslobodili ste %s iz Fort DeMorgan zatvora.", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, globalstring);
	format(globalstring, sizeof(globalstring), "* Admin %s vas je pustio iz Fort DeMorgan zatvora.", GetName(playerid,false));
	SendClientMessage(giveplayerid, COLOR_RED, globalstring);
	PlayerInfo[giveplayerid][pJailed] = 0;
	PlayerInfo[giveplayerid][pJailTime] = 0;
	SetPlayerPosEx(giveplayerid, 1481.0739,-1741.8704,13.5469, 0, 0, true);
	SetPlayerWorldBounds(giveplayerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
	new playerip[MAX_PLAYER_IP];
	GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
	format(globalstring, sizeof(globalstring), "%s je oslobodio %s iz F.DeMorgan (%s)", GetName(playerid,false), GetName(giveplayerid,false), playerip);
	#if defined MODULE_LOGS
	LogAdminUnPrison(globalstring);
	#endif
    return 1;
}

CMD:prison(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, ptime, year, month, day, reason[80];
	if (sscanf(params, "uis[80]", giveplayerid, ptime, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /prison [ID/DioImena] [Vrijeme(minute)] [Razlog]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");
	new string[350];
    format(string, sizeof(string), "PRISON: Admin: %s je zatvorio %s u F.DeMorgan na %d minuta. Razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), ptime, reason);
	SendClientMessageToAll(COLOR_RED, string);

	format(string, sizeof(string), "* Stavio si %s in Fort DeMorgan.", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_RED, string);
	format(string, sizeof(string), "* Zatvoreni ste u Fort Demorgan od Admina %s na %d minuta. Razlog: %s", PlayerInfo[playerid][pForumName], ptime, reason);
	SendClientMessage(giveplayerid, COLOR_RED, string);

	PutPlayerInJail(giveplayerid, ptime, 2); // 2 je Fort De Morgan

	ExpInfo[giveplayerid][ePoints] -= 5;
	ExpInfo[giveplayerid][eAllPoints] -= 5;
	SavePlayerExperience(giveplayerid);
	SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Radi Admin prisona, izgubili ste 5 trenutnih i 5 Overall EXP-ova.");

	new playerip[MAX_PLAYER_IP];
	GetPlayerIp(giveplayerid, playerip, sizeof(playerip));

	new hour, minute, second;
	GetServerTime(hour, minute, second);
	getdate(year, month, day);

	new date[20], time[20];
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	format(time, sizeof(time), "%02d:%02d:%02d", hour, minute, second);

 	new
		prsnQuery[256],
		forumname [ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ];

	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);

	mysql_format(g_SQL, prsnQuery, sizeof(prsnQuery), "INSERT INTO prisons (`id_igraca`,`name`, `forumname`, `time`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		PlayerInfo[playerid][pForumName],
		ptime,
		reason,
		date
	);
	mysql_tquery(g_SQL, prsnQuery, "", "");
	return 1;
}

CMD:tod(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new time;
	if (sscanf(params, "i", time)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /tod [vrijeme]");
	if (time < 0 || time > 24) return SendClientMessage(playerid,COLOR_RED, "Vrijeme moze biti od 0-24!");
	SetWorldTime(time);
	return 1;
}

CMD:charge(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid, money, result[64];
    if(sscanf(params, "uis[64]", giveplayerid, money, result)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /charge [ID/DioImena] [Iznos] [Razlog]");
    if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
 	if(money < 1) return SendClientMessage(playerid, COLOR_RED, "Cijena kazne nemoze biti manja od $1!");
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), money, result);
	#if defined MODULE_LOGS
	LogAdminCharge(globalstring);
	#endif
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", PlayerInfo[playerid][pForumName], GetName(giveplayerid,false), money, result);
	SendClientMessageToAll(COLOR_RED, globalstring);
	PlayerToBudgetMoney(giveplayerid, money);


	new TmpQuery[200];
	new
		forumname[ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ];

	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);

	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);

	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "INSERT INTO charges (`id_igraca`,`name`, `admin_name`, `money`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		PlayerInfo[playerid][pForumName],
		money,
		result,
		date
	);
	mysql_tquery(g_SQL, TmpQuery);
	return 1;
}

/*CMD:chargeex(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    money,
		reason[32];
    if( sscanf(params,"s[24]is[31]", targetname, money, reason) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /chargeex [Ime][Iznos][Razlog]");
    if( strlen(targetname) > 24 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina imena je 24!");
	if( strlen(reason) > 31 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina razloga je 31!");
	mysql_format(g_SQL, globalstring, sizeof(globalstring), "SELECT * FROM `accounts` WHERE `name` = '%e'", targetname);
	mysql_tquery(g_SQL, globalstring, "ChargePlayer", "isi", playerid, targetname, money);
	
	format(globalstring, sizeof(globalstring), "[ ! ] Uspjesno ste chargeali igraca %s!", targetname);
	SendClientMessage(playerid, COLOR_GREEN, globalstring);
	
	new sqlid, TmpQuery[200];
	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", targetname);
	
	new 
		Cache:result = mysql_query(g_SQL, TmpQuery);
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	
	new
		admin_name[ MAX_PLAYER_NAME ];
	GetPlayerName(playerid, admin_name, MAX_PLAYER_NAME);
	
	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "INSERT INTO charges (`id_igraca`,`name`, `admin_name`, `money`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		sqlid,
		targetname,
		admin_name,
		money,
		reason,
		date
	);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

CMD:chargep(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new percentage, giveplayerid, reason[36];
	
	if( sscanf( params, "uis[36]", giveplayerid, percentage, reason ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /chargep [ID/DioImena] [Postotak] [Razlog]");
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage(playerid, COLOR_RED, "Igrac nije online!");
	if( percentage < 0 || percentage > 100 ) return SendClientMessage(playerid, COLOR_RED, "Ne mozete unijeti manje od 0 i vise od 100 posto!");
	
	new razlika = floatround(( PlayerInfo[ giveplayerid ][ pBank ] + PlayerInfo[ giveplayerid ][ pMoney ] ) * floatdiv(percentage, 100), floatround_round);
	
	va_SendClientMessageToAll(COLOR_RED, "AdmCMD: %s je novcano kaznio igraca %s sa $%d, razlog: %s", 
		GetName(playerid,false), 
		GetName(giveplayerid,false), 
		razlika,
		reason
	);
	AC_GivePlayerMoney(giveplayerid, -razlika);
	
	new year, month, day, date[32];
	getdate(year, month, day);
	format(date, sizeof(date), "%02d.%02d.%d.", day, month, year);
	
	new 
		TmpQuery[256],
		admin_name[ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ];
		
	GetPlayerName(playerid, admin_name, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);
	
	mysql_format(g_SQL, TmpQuery, sizeof(TmpQuery), "INSERT INTO charges (`id_igraca`,`name`, `admin_name`, `money`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%d', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		admin_name,
		razlika,
		reason,
		date
	);
	mysql_tquery(g_SQL, TmpQuery, "", "");
	return 1;
}

CMD:chargepex(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		percentage,
		playerName[ MAX_PLAYER_NAME ],
		reason[ 36 ];
	if( sscanf( params, "s[24]is[36]", playerName, percentage, reason ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /chargepex [ime][postotak][razlog]");
	if( percentage < 0 || percentage > 100 ) return SendClientMessage(playerid, COLOR_RED, "Ne mozete unijeti manje od 0 i vise od 100 posto!");
	new
		Float:precent = percentage / 100;
		
	mysql_format(g_SQL, globalstring, sizeof(globalstring), "SELECT * FROM accounts WHERE name = '%e'", playerName);
	mysql_tquery(g_SQL, globalstring, "ChargepPlayer", "isfs", playerid, playerName, precent, reason);
	return 1;
}*/

CMD:gotocar(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new testcar;
	if (sscanf(params, "i", testcar)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gotocar [Carid]");
	new
		Float:X, Float:Y, Float:Z;
	GetVehiclePos(testcar, X, Y, Z);
	if (GetPlayerState(playerid) == 2) {
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehiclePos(tmpcar, X, Y, Z);
	}
	else SetPlayerPos(playerid, X, Y, Z);
	return 1;
}

CMD:unbanip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new playersip[16];
	if (sscanf(params, "s[16]", playersip)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unbanip [Igracev IP]");
	if( strlen(playersip) > 15 || strlen(playersip) < 1) return SendClientMessage(playerid, COLOR_RED, "Igracev IP mora biti izmedju 1 i 16!");
	
	new
		unbanString[ 25 ];
	format(unbanString, sizeof(unbanString), "unbanip %s", playersip);
	SendRconCommand(unbanString);
	SendRconCommand("reloadbans");
	
	#if defined MODULE_BANS
	UnbanPlayerIP(playersip, playerid);
	#endif
	
	format(globalstring, sizeof(globalstring), "AdmWarn: %s je odbanao IP %s", GetName(playerid,false), playersip);
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

CMD:rtcinradius(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new Float: radius;
	if( sscanf( params, "f", radius)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rtcinradius [radius]");
	if(radius < 1.0 || radius > 300.0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Minimalni radius je 1.0, a maksimalni 300.0!");
	new
		Float:X, Float:Y, Float:Z,
		engine, lights, alarm, doors, bonnet, boot, objective;
	
	foreach(new c: Vehicles)
	{
		GetVehiclePos(c, X, Y, Z);
        if( IsPlayerInRangeOfPoint(playerid, radius, X, Y, Z) ) {
            if( !IsPlayerInVehicle(playerid, c) ) {
			
				if( VehicleInfo[ c ][ vUsage ] == VEHICLE_USAGE_EVENT ) {
					VehicleObjectCheck(c);
					GetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(c, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleToRespawn(c);
					LinkVehicleToInterior(c, 0);
				} else {
					VehicleObjectCheck(c);
					GetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(c, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleToRespawn(c);
					LinkVehicleToInterior(c, 0);
				}
		    }
		}
	}
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sva vozila u radiusu %2.f od vas su respawnana! Ukoliko zelite respawnati prikolicu, koristite /dl te /rtcacar!", radius);
	return 1;
}

CMD:weatherall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new weather;
	if (sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /weatherall [Weatherid]");
	//if (weather < 0 || weather > 50) return SendClientMessage(playerid, COLOR_RED, "ID vremena nemoze ici ispod 0 ili iznad 50!");
	
	SetWeather(weather);
	
	foreach (new i : Player)
	{
		SetPlayerWeather(i, weather);
	}
	
	SendClientMessage(playerid, COLOR_GREY, "Vrijeme postavljeno svima!");
	format(globalstring, 128, "AdmWarn: %s je stavio vrijeme ID %d", GetName(playerid,false), weather);
	WeatherSys = weather;
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:prisoned(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    type[12];
    SendClientMessage(playerid, COLOR_SKYBLUE, "*___________________________ Online igraci u bolnici/zatvoru/arei ___________________________*");
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pJailed] >= 1)
		{
			if (PlayerInfo[i][pJailed] == 1) 		
			{ 
				type = "Jail"; 
			}
			else if(PlayerInfo[i][pJailed] == 3) 	
			{ 
				type = "Bolnica"; 
			}
			else 
			{
				type = "F.DeMorgan";
			}
			va_SendClientMessage(playerid, COLOR_GREY, "%s | %s (%d) - Vrijeme: %d minuta", type, GetName(i), i, PlayerInfo[i][pJailTime]);
		}
	}
	return 1;
}

CMD:newbies(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    SendClientMessage(playerid, COLOR_SKYBLUE, "*___________________________ Online igraci sa levelom 1 ___________________________*");
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pLevel] == 1)
		{
			va_SendClientMessage(playerid, COLOR_GREY, "%s[%d]", GetName(i), i);
		}
	}
	return 1;
}

CMD:banex(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    targetname[MAX_PLAYER_NAME],
	    reason[24], days;
		
    if (sscanf(params,"s[24]s[24]i", targetname, reason, days)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /banex [Ime][Razlog][Dana (-1 za 4life)]");
	if( strlen(targetname) > 24 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina imena je 24!");
    if (strlen(reason) < 1 || strlen(reason) > 24) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina razloga je 24, a minimalna 1!");
	
	mysql_format(g_SQL, globalstring, sizeof(globalstring), "SELECT * FROM `accounts` WHERE `name` = '%e'", targetname);
	mysql_tquery(g_SQL, globalstring, "OfflineBanPlayer", "issi", playerid, targetname, reason, days);

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste banali igraca %s!", targetname);
	return 1;
}

CMD:jailex(playerid, params[])
{
	new LoopName[MAX_PLAYER_NAME];
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayername[24],
	    time;
	if (sscanf(params, "s[24]i", giveplayername, time)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jailex [Ime] [Time(minutes)]");
	if( strlen(giveplayername) > 24 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina imena je 24!");
	if (time < 1) return SendClientMessage(playerid, COLOR_RED, "Vrijeme pritvora ne moze biti manje od 1 minute!");
	foreach (new i : Player)
	{
	    GetPlayerName(i, LoopName, sizeof(LoopName));
		if(!strcmp(giveplayername, LoopName)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè je online!");
	}
	mysql_format(g_SQL, globalstring, sizeof(globalstring), "SELECT * FROM `accounts` WHERE `name` = '%e'", giveplayername);
	mysql_tquery(g_SQL, globalstring, "OfflineJailPlayer", "issi", playerid, giveplayername, time);

	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste zatvorili igraca %s!", giveplayername);
	return 1;
}

CMD:jail(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    time;
	if (sscanf(params, "ui", giveplayerid, time)) {
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /jail [ID/DioImena][Time(minutes)]");
		return 1;
	}
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (time < 1) return SendClientMessage(playerid, COLOR_RED, "Vrijeme pritvora ne moze biti manje od 1 minute!"); 
	va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Stavio si %s u zatvor.", GetName(giveplayerid,false));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Stavljeni ste u zatvor od strane administratora %s.", PlayerInfo[playerid][pForumName]);
	
	PlayerInfo[giveplayerid][pArrested] 	+= 1;
	PutPlayerInJail(giveplayerid, time, 1); // County Jail je 1
    PutPlayerInSector(giveplayerid);
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ADMIN JAIL] Pritvoreni ste na %d minuta. Jamcevina: Nedostupna", time);
	
	if(PlayerInfo[giveplayerid][pGunLic] != 0) {
		SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Nakon sto ste uhiceni, ostali ste bez dozvole za oruzje!");
		PlayerInfo[giveplayerid][pGunLic] = 0;
	}
	new playerip[MAX_PLAYER_IP];
	GetPlayerIp(playerid, playerip, sizeof(playerip));
	format(globalstring, sizeof(globalstring), "Admin %s(%s) je zatvorio %s na %d", PlayerInfo[playerid][pForumName], playerip, GetName(giveplayerid,false), time);
	LogAdminJail(globalstring);
	return 1;
}

CMD:unjail(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unjail [ID/DioImena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerInfo[giveplayerid][pJailed] == 0) return SendClientMessage(playerid, COLOR_RED, "Igrac nije u jailu!");
	if (PlayerInfo[giveplayerid][pJailed] == 1)
	{
		format(globalstring, sizeof(globalstring), "* Oslobodili ste %s.", GetName(giveplayerid,false));
		SendClientMessage(playerid, COLOR_RED, globalstring);
		format(globalstring, sizeof(globalstring), "* Oslobodio vas je Admin %s.", GetName(playerid,false));
		SendClientMessage(giveplayerid, COLOR_RED, globalstring);
		SetPVarInt(giveplayerid, "WantedPoints", 0);
		AC_SetPlayerWeapons(giveplayerid);
		PlayerInfo[giveplayerid][pJailed] = 0;
		PlayerInfo[giveplayerid][pJailTime] = 0;
		PlayerInfo[playerid][pBailPrice] = 0;
		SetPlayerPos(giveplayerid, 90.6552, -236.3789, 1.5781);
		SetPlayerInterior(playerid, 0);

		new playerip[MAX_PLAYER_IP];
		GetPlayerIp(playerid, playerip, sizeof(playerip));
		format(globalstring, sizeof(globalstring), "%s(%s) je oslobodio %s", GetName(playerid,false), playerip, GetName(giveplayerid,false));
		#if defined MODULE_LOGS
		LogAdminUnJail(globalstring);
		#endif
	}
	else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije u zatvoru!");
    return 1;
}

CMD:toga(playerid, params[])
{
	#pragma unused params
    
	if(PlayerInfo[playerid][pAdmin] || IsPlayerAdmin(playerid))
	{
		if( !Bit1_Get(a_AdminChat, playerid))
		{
			Bit1_Set(a_AdminChat, playerid, true);
			SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost Admin chat-a!");
		} else {
			Bit1_Set(a_AdminChat, playerid, false);
			SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost Admin chat-a!");
		}
	}
	else 
		SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    
	return 1;
}

CMD:togreport(playerid, params[])
{
	#pragma unused params
	
	if( PlayerInfo[playerid][pAdmin] < 4 ) return SendClientMessage( playerid, COLOR_RED, "Niste ovlasteni!" );
	if( !Bit1_Get( a_TogReports, playerid ) ) {
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Iskljucili ste reportove!");
		Bit1_Set( a_TogReports, playerid, true );
	} else {
		Bit1_Set( a_TogReports, playerid, false );
		SendClientMessage( playerid, COLOR_RED, "[ ! ] Ukljucili ste reportove!");
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pHelper] >= 3)
	{
		new giveplayerid;
		
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /gethere [ID/DioImena]");
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
		if (PlayerInfo[giveplayerid][pAdmin] > 1337) return SendClientMessage(playerid, COLOR_RED, "Pitajte Administratora da se teleportira do Vas.");
		if (PlayerInfo[giveplayerid][pJailed] > 0) {
			ShowPlayerDialog(playerid, DIALOG_JAIL_GETHERE, DIALOG_STYLE_MSGBOX, "Warning", "Igrac kojeg zelite portati je u zatvoru.", "Port", "Exit");
			PortedPlayer[playerid] = giveplayerid;
			return 1;
		}
		new
			Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		if (GetPlayerState(giveplayerid) == 2) {
			new tmpcar = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(tmpcar, X, Y+4, Z);
		} else {
			SetPlayerPos(giveplayerid, X, Y+2, Z);
			SetPlayerInterior(giveplayerid, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(giveplayerid, GetPlayerVirtualWorld(playerid));
		}
		if( Bit16_Get( gr_PlayerInBiznis, playerid ) != INVALID_BIZNIS_ID ) 
			Bit16_Set( gr_PlayerInBiznis, giveplayerid, Bit16_Get( gr_PlayerInBiznis, playerid ) );
		if( Bit16_Get( gr_PlayerInHouse, playerid )  != INVALID_HOUSE_ID )  
			Bit16_Set( gr_PlayerInHouse, giveplayerid, Bit16_Get( gr_PlayerInHouse, playerid ) );
		if( Bit16_Get( gr_PlayerInComplex, playerid ) != INVALID_COMPLEX_ID )
			Bit16_Set( gr_PlayerInComplex, giveplayerid, Bit16_Get( gr_PlayerInComplex, playerid ) );
		if( Bit16_Get( gr_PlayerInRoom, playerid ) != INVALID_COMPLEX_ID )
			Bit16_Set( gr_PlayerInRoom, giveplayerid, Bit16_Get( gr_PlayerInRoom, playerid ) );
		if( Bit16_Get( gr_PlayerInPickup, playerid ) != -1 )
			Bit16_Set( gr_PlayerInPickup, giveplayerid, Bit16_Get( gr_PlayerInPickup, playerid ) );
			
		format(globalstring, sizeof(globalstring), "Teleportiran si od strane admina %s", GetName(playerid,false));
		SendClientMessage(giveplayerid, -1, globalstring);
		format(globalstring, sizeof(globalstring), "Teleportirao si %s, ID %d", GetName(giveplayerid,false), giveplayerid);
		SendClientMessage(playerid, -1, globalstring);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:unban(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new targetname[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", targetname )) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unban [Igracev Nick]");
   	format(globalstring,sizeof(globalstring),"Uspjesno si unbanao account: %s!", targetname);
   	SendClientMessage(playerid, COLOR_ORANGE, globalstring);
	
	#if defined MODULE_BANS
	UnbanPlayerName(targetname, playerid);
	#endif
	format(globalstring, sizeof(globalstring), "%s[%s] je unbanao %s", GetName(playerid,false), GetPlayerIP(playerid), targetname);
	
	#if defined MODULE_LOGS
	LogAdminUnban(globalstring);
	#endif
	return 1;
}

CMD:warn(playerid, params[])
{

    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
        giveplayerid,
		reason[24],
		playerip[MAX_PLAYER_IP],
		year,
		month,
		day;
    if (sscanf(params, "us[24]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /warn [ID/DioImena] [Razlog]");
	if (strlen(reason) < 1 || strlen(reason) > 24) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina razloga je 24, a minimalna 1!");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrae nije online!");
	GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
	new
	    hour,
		minute,
		second;
	GetServerTime(hour, minute, second);
	getdate(year, month, day);

	new
	    date[20],
	    time[20];
	format(date, sizeof(date), "%02d.%02d.%d", day, month, year);
	format(time, sizeof(time), "%02d:%02d:%02d", hour, minute, second);


	PlayerInfo[giveplayerid][pWarns] += 1;

	ExpInfo[giveplayerid][ePoints] -= 10;
	ExpInfo[giveplayerid][eAllPoints] -= 10;
	SavePlayerExperience(giveplayerid);

    if (PlayerInfo[giveplayerid][pWarns] >= MAX_WARNS)
	{
		PlayerInfo[giveplayerid][pWarns] = 0;
		#if defined MODULE_BANS
		HOOK_Ban(giveplayerid, playerid, "Tri warna", 10, false);
		BanMessage(giveplayerid);
		#endif
		return 1;
	}
	va_SendClientMessage(playerid, COLOR_RED, "AdmCMD: Upozorili ste Igraca %s, razlog: %s", GetName(giveplayerid,false), reason);
	va_SendClientMessage(giveplayerid, COLOR_RED, "AdmCMD: Upozorio vas je Admin %s, razlog: %s", PlayerInfo[playerid][pForumName], reason);
	SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Radi Admin Warna, izgubili ste 10 trenutnih i Overall EXP-ova.");

	new
		forumname[ MAX_PLAYER_NAME ],
		playername[ MAX_PLAYER_NAME ],
		wrnQuery[256];

	GetPlayerName(playerid, forumname, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, playername, MAX_PLAYER_NAME);

	mysql_format(g_SQL, wrnQuery, sizeof(wrnQuery), "INSERT INTO warns (`id_igraca`,`name`, `forumname`, `reason`, `date`) VALUES ('%d', '%e', '%e', '%e', '%e')",
		PlayerInfo[giveplayerid][pSQLID],
		playername,
		PlayerInfo[playerid][pForumName],
		reason,
		date
	);
	mysql_tquery(g_SQL, wrnQuery, "", "");
	return 1;
}

CMD:pmears(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_PMears, playerid)) {
		Bit1_Set(a_PMears, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih PM-ova!");
	} else {
		Bit1_Set(a_PMears, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih PM-ova!");
	}
	return 1;
}

CMD:togadnot(playerid, params[])
{
	#pragma unused params

	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_AdNot, playerid)) {
		Bit1_Set(a_AdNot, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost oglas reporta!");
	} else {
		Bit1_Set(a_AdNot, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "[ ! ] Iskljucili ste vidljivost oglas reporta!");
	}
	return 1;
}

CMD:rears(playerid, params[])
{
	#pragma unused params

	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_REars, playerid)) {
		Bit1_Set(a_REars, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih radio komunikacija!");
	} else {
		Bit1_Set(a_REars, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih radio komunikacija!");
	}
	return 1;
}

CMD:bhears(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_BHears, playerid)) {
		Bit1_Set(a_BHears, playerid, true);
 		SendClientMessage(playerid, COLOR_RED, "[ ! ] Ukljucili ste vidljivost svih BH-ova!");
	} else {
		Bit1_Set(a_BHears, playerid, false);
  		SendClientMessage(playerid, COLOR_RED, "Iskljucili ste vidljivost svih BH-ova!");
	}
	return 1;
}

// Administrator Level 1
CMD:a(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: (/a)dmin [Admin chat]");

	if( PlayerInfo[playerid][pAdmin] == 1338 ) {
		format(result, sizeof(result), "{FA5555}A[%d] {819BC6}%s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		LogAdminChat(result);
		#endif
	}
	else if( PlayerInfo[playerid][pAdmin] >= 1 ) {
		format(result, sizeof(result), "{FF9933}A[%d] {819BC6}%s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid,false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		LogAdminChat(result);
		#endif
	}
	else if( PlayerInfo[playerid][pHelper] >= 1 ) {
		format(result, sizeof(result), "{91FABB}H[%d] {819BC6}%s: %s", PlayerInfo[playerid][pHelper], GetName(playerid,false), params);
		AHBroadCast(0x819BC6FF, result, 1);
		#if defined MODULE_LOGS
		LogAdminChat(result);
		#endif
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:ac(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: (/ac)dmin [Admin chat]");

	if( PlayerInfo[playerid][pAdmin] >= 1337 ) {
		format(result, sizeof(result), "AC[%d] %s(%s): %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), PlayerInfo[playerid][pForumName], params);
		HighAdminBroadCast(0x4C3A8CFF, result, 1337);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:aa(playerid, params[])
{
	new result[256];
    if (isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /aa [TEXT]");

	if( PlayerInfo[playerid][pAdmin] >= 1338 ) {
		format(result, sizeof(result), "[!] A[%d] %s(%s): %s", PlayerInfo[playerid][pAdmin], GetName(playerid, false), PlayerInfo[playerid][pForumName], params);
		SendDirectiveMessage(COLOR_RED, result, 1);
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}


CMD:houseo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		house;
	if( sscanf( params, "i", house ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /houseo [houseid]" );
	
	if(house < 0 || house > MAX_HOUSES-1) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /houseo [houseid]" );
	
	if(HouseInfo[ house ][ hEnterX ] == 0.0)
		return SendClientMessage(playerid, COLOR_RED, "Taj kuca ne postoji!");

	SetPlayerPosEx(playerid, HouseInfo[ house ][ hEnterX ], HouseInfo[ house ][ hEnterY ], HouseInfo[ house ][ hEnterZ ], 0, 0, true);
	return 1;
}

CMD:bizo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		biznis;
		
	if( sscanf( params, "i", biznis ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /bizo [biznisid]" );
	
	if(biznis < 0 || biznis > MAX_BIZZS-1) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /bizo [biznisid]" );
	
	if(BizzInfo[ biznis ][ bEntranceX ] == 0.0)
		return SendClientMessage(playerid, COLOR_RED, "Taj biznis ne postoji!");
	
	SetPlayerPosEx(playerid, BizzInfo[ biznis ][ bEntranceX ], BizzInfo[ biznis ][ bEntranceY ], BizzInfo[ biznis ][ bEntranceZ ], 0, 0, true);
	
	return 1;
}

CMD:complexo(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		complex;
	if( sscanf( params, "i", complex ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /complexo [complexid]" );
	if( 0 <= complex || complex <= MAX_COMPLEX-1 ) 
	{
		if( ComplexInfo[ complex ][ cEnterX ] == 0.0)
			return SendClientMessage(playerid, COLOR_RED, "Taj complex ne postoji!");
			
		SetPlayerPosEx(playerid, ComplexInfo[ complex ][ cEnterX ], ComplexInfo[ complex ][ cEnterY ], ComplexInfo[ complex ][ cEnterZ ], 0, 0, true);
	} 
	else 
		SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /complexo [complexid]" );
	
	return 1;
}

CMD:checknetstats(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
		number;
	if (sscanf(params, "ui", giveplayerid, number))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checknetstats [ID/DioImena] [0-1]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ] 0 - Player Connection 1 - Player Network Stats");
		return 1;
	}
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (number < 0 || number > 1) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 1!");
	if (number == 0)
	{
        new
		    stats[400+1],
		    string[41];
        new dest[24];
        NetStats_GetIpPort(giveplayerid, dest, sizeof(dest));

	    format(stats, sizeof(stats), "You have been connected for %i milliseconds.\nYou have sent %i network messages. \
		\nYou have sent %i bytes of information to the server.\nYou have recieved %i network messages. \
		\nYou have received %i bytes of information from the server.\nYou have sent %i network messages in the last second. \
		\nPackets lost: %.2f percent.\nYour current connection status: %i.\nYour current IP and port: %s.",
		NetStats_GetConnectedTime(giveplayerid), NetStats_MessagesReceived(playerid), NetStats_BytesReceived(playerid),
		NetStats_MessagesSent(playerid), NetStats_BytesSent(playerid), NetStats_MessagesRecvPerSecond(playerid),
		NetStats_PacketLossPercent(playerid), NetStats_ConnectionStatus(playerid), dest);

        format(string, sizeof(string), "%s Connection Stats", GetName(giveplayerid,false));
	    ShowPlayerDialog(playerid, DIALOG_NETWORK_STATS, DIALOG_STYLE_MSGBOX, string, stats, "Okay", "");
	}
	else if (number == 1)
	{
	    new
		    stats[400+1],
	        string[39];
	    GetPlayerNetworkStats(giveplayerid, stats, sizeof(stats));
	    format(string, sizeof(string), "%s Network Stats", GetName(giveplayerid,false));
	    ShowPlayerDialog(playerid, DIALOG_NETWORK_STATS, DIALOG_STYLE_MSGBOX, string, stats, "Okay", "");
	}
	return 1;
}

CMD:rtc(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[ playerid ][ pHelper ] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new car = GetPlayerVehicleID(playerid);
    if( !IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Niste unutar vozila!");
	Bit1_Set( gr_SafeRemoting, playerid, true );	
	RemovePlayerFromVehicle(playerid);
	SetVehicleToRespawn(car);
	format(globalstring, sizeof(globalstring), "AdmWARN: %s je respawnao vozilo ID %d (/rtc).", GetName(playerid,false), car);
	SendAdminMessage(COLOR_ORANGE, globalstring);
	format(globalstring,sizeof(globalstring),"Respawnao si vozilo ID %d. (/rtc)", car);
	SendClientMessage(playerid, -1, globalstring);
    return 1;
}

CMD:rtcacar(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
		vehicleid;
	if( sscanf( params, "i", vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /rtcacar [vehicleid]");
	if(!Iter_Contains(Vehicles, vehicleid))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo ID %d ne postoji na serveru!", vehicleid);
	if(IsVehicleOccupied(vehicleid))
		return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Netko se trenutno nalazi u vozilu ID %d!", vehicleid);
		
	SetVehicleToRespawn(vehicleid);
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Vozilo ID %d je uspjesno respawnano.");
	format(globalstring, sizeof(globalstring), "AdmWARN: %s je respawnao vozilo ID %d (/rtc).", GetName(playerid,false), vehicleid);
	SendAdminMessage(COLOR_ORANGE, globalstring);
	return 1;
}

CMD:gotopos(playerid, params[])
{
	if( PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	
	new
		Float:tmpPos[3], tmpInt, tmpViWo;
	if( sscanf( params, "fffii", tmpPos[0], tmpPos[1], tmpPos[2], tmpInt, tmpViWo ) ) 
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]:  /gotopos [X][Y][Z][Interior ID][Virtual World ID]");
	SetPlayerPosEx(playerid, tmpPos[0], tmpPos[1], tmpPos[2], tmpViWo, tmpInt);
	return 1;
}

CMD:goto(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 1) {
		new giveplayerid;
		if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /goto [ID/Dio imena]");
		if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
		if( IsPlayerReconing(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Morate iskljuciti reconing!");
		if( IsPlayerReconing(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Igrac recona drugog igraca!");
		
		new
			Float:plocx,
			Float:plocy,
			Float:plocz;
		GetPlayerPos(giveplayerid, plocx, plocy, plocz);
		
		
		if (GetPlayerState(playerid) == 2) {
			AC_SetVehiclePos(GetPlayerVehicleID(playerid), plocx, plocy+2, plocz);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(giveplayerid));
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(giveplayerid));
		}
		else {
			SetPlayerPos(playerid, plocx, plocy+2, plocz);
			SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
		
			if( Bit16_Get( gr_PlayerInBiznis, giveplayerid ) != INVALID_BIZNIS_ID ) 
				Bit16_Set( gr_PlayerInBiznis, playerid, Bit16_Get( gr_PlayerInBiznis, giveplayerid ) );
			if( Bit16_Get( gr_PlayerInHouse, giveplayerid )  != INVALID_HOUSE_ID )  
				Bit16_Set( gr_PlayerInHouse, playerid, Bit16_Get( gr_PlayerInHouse, giveplayerid ) );
			if( Bit16_Get( gr_PlayerInComplex, giveplayerid ) != INVALID_COMPLEX_ID )
				Bit16_Set( gr_PlayerInComplex, playerid, Bit16_Get( gr_PlayerInComplex, giveplayerid ) );
			if( Bit16_Get( gr_PlayerInRoom, giveplayerid ) != INVALID_COMPLEX_ID )
				Bit16_Set( gr_PlayerInRoom, playerid, Bit16_Get( gr_PlayerInRoom, giveplayerid ) );
			if( Bit16_Get( gr_PlayerInPickup, giveplayerid ) != -1 )
				Bit16_Set( gr_PlayerInPickup, playerid, Bit16_Get( gr_PlayerInPickup, giveplayerid ) );
			
			format(globalstring, sizeof(globalstring), "Teleportiran si do %s, ID %d", GetName(giveplayerid,false), giveplayerid);
			SendClientMessage(playerid, COLOR_GREY, globalstring);
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:checklastlogin(playerid, params[])
{
	//if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!"); Da vratimo na staro da igraci mogu gledat kad je tko bio online zadnji put radi kuca i biznisa..
	new targetname[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "s[24]", targetname)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checklastlogin [Ime_Prezime]");
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", targetname); // da budemo sigurniji jos vise haha iako je %e ista stvar al dobro
    mysql_tquery(g_SQL, string, "CheckPlayerData", "is", playerid, targetname);
	return 1;
}

CMD:ninja(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:px,
        Float:py,
		Float:pz;
	GetPlayerPos(playerid, px, py, pz);
	GetXYInFrontOfPlayer(playerid, px, py, 10.0);
	SetPlayerPos(playerid, px, py, pz+5);
    return 1;
}

CMD:fly(playerid,params[])
{
	#pragma unused params
	new
	    Float:X,
		Float:Y,
		Float:Z;
		
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste autorizovani. [MAYDAY]");

	if(adminfly[playerid] == 0)
	{
		StartFly(playerid);
		adminfly[playerid] = 1;
		SetPlayerHealth(playerid, 99999);
	}
	else if(adminfly[playerid] == 1)
	{
	    GetPlayerPos(playerid, X, Y, Z);
		ACPosX[playerid] = X;
		ACPosY[playerid] = Y;
		ACPosZ[playerid] = Z;
		StopFly(playerid);
		adminfly[playerid] = 0;
		SetPlayerHealth(playerid, 100);
	}
	return true;
}
CMD:lt(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:slx,
		Float:sly,
		Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerPos(playerid, slx, sly+2, slz);
    return 1;
}

CMD:rt(playerid, params[])
{
	#pragma unused params
    
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    Float:slx,
	    Float:sly,
		Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerPos(playerid, slx, sly-2, slz);
    return 1;
}

CMD:checkoffline(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new targetname[MAX_PLAYER_NAME];
	if (sscanf(params, "s[24]", targetname)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checkoffline [Ime]");
	mysql_format(g_SQL, globalstring, sizeof(globalstring),"SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 1", targetname);
    mysql_tquery(g_SQL, globalstring, "CheckOffline", "is", playerid, targetname);
	return 1;
}

CMD:count(playerid, params[])
{
	new
	    seconds,
	    string[64];
	if (sscanf(params, "i", seconds)) return SendClientMessage(playerid, COLOR_RED, "Morate unijeti vrijednost u sekundama.");
	if (seconds < 1 || seconds > 60) return SendClientMessage(playerid, COLOR_RED, "Sekunde nemogu biti manje od 1 i vece od 20!");
	if (count_started == true) return SendClientMessage(playerid, COLOR_RED, "Timer/Counter je vec startan.");
 	if( PlayerInfo[playerid][pAdmin] >= 1 && seconds > 0 )
    {
 		format(string, 40, "Zapoceli ste odbrojavanje od %d sekundi.", seconds);
  		SendClientMessage(playerid, COLOR_SKYBLUE, string);
		count_started = true;
   		cseconds = seconds + 1;
		CountingTimer = SetTimer("OnAdminCountDown", 1000, true);
     	format(string, sizeof(string), "AdmWarn: %s koristi komandu /count.", GetName(playerid,false));
      	SendAdminMessage(COLOR_RED, string);
   	}
    else SendClientMessage(playerid, COLOR_RED, "Niste clan Street Racers organizacije / Niste Admin / Sekunde moraju biti vece od 1 i manje od 20!");
	return 1;
}
CMD:respawn(playerid, params[])
{
	if( PlayerInfo[ playerid ][ pAdmin ] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /respawn [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");

    format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je respawnao igraca %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);

	new resstring[120];
	format(resstring, sizeof(resstring), "Admin %s vas je respawnovao.", GetName(playerid,false));
	SendMessage(giveplayerid, COLOR_RED, resstring);
    Bit16_Get(gr_PlayerInHouse, giveplayerid, 0);
    Bit16_Get(gr_PlayerInGarage, giveplayerid, 0);
    Bit16_Get(gr_PlayerInRoom, giveplayerid, 0);
    Bit16_Get(gr_PlayerInBiznis, giveplayerid, 0);
    Bit16_Get(gr_PlayerInComplex, giveplayerid, 0);
	
    SpawnPlayer(giveplayerid);
	
	return 1;
}

CMD:akill(playerid, params[])
{
    
    if( PlayerInfo[ playerid ][ pAdmin ] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if( sscanf(params, "u", giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /akill [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
	if( !Bit1_Get( gr_PlayerSendKill, giveplayerid ) ) return SendClientMessage( playerid, COLOR_RED, "Taj igrac ne treba ubojstvo!" );
	
	AC_ResetPlayerWeapons(giveplayerid);
	SetPlayerHealth(giveplayerid, 0);
	Bit1_Set( gr_PlayerSendKill, giveplayerid, false );
	format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je odobrio kill igracu %s", GetName(playerid,false), GetName(giveplayerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	
	return 1;
}

CMD:freeze(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /freeze [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerInfo[giveplayerid][pAdmin] > 0) return SendClientMessage(playerid, COLOR_RED, "Administratori ne mogu biti zaledjeni!");
	TogglePlayerControllable(giveplayerid, 0);
	Frozen[giveplayerid] = true;
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je zaledjen od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /unfreeze [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	TogglePlayerControllable(giveplayerid, 1);
	Frozen[giveplayerid] = false;
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je odledjen od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
	return 1;
}

CMD:learn(playerid, params[])
{
    new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /learn [Playerid/DioImena]");
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 1)
	{
		if(IsPlayerConnected(giveplayerid))
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
            {
     			PlayerInfo[giveplayerid][pMustRead] = true;
     			PlayerInfo[giveplayerid][pMuted] = true;
     			TogglePlayerControllable(giveplayerid, 0);
        		LearnTimer[playerid] = SetTimerEx("LearnPlayer", 1000, 0, "ii", giveplayerid, 1);
				SendClientMessage(giveplayerid,COLOR_LIGHTRED, "Niste naucili pravila Roleplaya. Primorani ste ih ponovo procitati.");
				SendClientMessage(giveplayerid, COLOR_LIGHTRED, "Poslije pravila, slijedi kviz od 10 pitanja, tako da bolje pratite!");
				format(globalstring, 128, "AdmCMD: %s je poslao %s da procita tutorial o Roleplayu.", GetName(playerid, false), GetName(giveplayerid, false));
				SendClientMessageToAll(COLOR_LIGHTRED, globalstring);
			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije na serveru!");
	}
	else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	return 1;
}

CMD:slap(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid;
   	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /slap [ID/Dio imena]");
   	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	new
	    Float:shealth,
		Float:slx,
		Float:sly,
		Float:slz;
	GetPlayerHealth(giveplayerid, shealth);
	SetPlayerHealth(giveplayerid, shealth-3.0);
	GetPlayerPos(giveplayerid, slx, sly, slz);
	SetPlayerPos(giveplayerid, slx, sly, slz+5);
	PlayerPlaySound(giveplayerid, 1130, slx, sly, slz+5);
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je slapan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
	SendAdminMessage(COLOR_RED, globalstring);
    return 1;
}

CMD:clearchat(playerid, params[])
{
	#pragma unused params
    
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    for (new a = 1; a <= 20; a++)
    {
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        SendClientMessageToAll(-1, "\n");
        GameTextForAll("Chat cleared!", 6000, 1);
    }
    format(globalstring, sizeof(globalstring), "* Admin %s je ocistio chat!", GetName(playerid,false));
    SendClientMessageToAll(COLOR_ORANGE, globalstring);
    return 1;
}

CMD:dmers(playerid, params[])
{

	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (!Bit1_Get(a_DMCheck, playerid))
	{
		Bit1_Set(a_DMCheck, playerid, true);
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Sad cete dobivati dojave o ubojstvima igraca!");
		
	}
	else
	{
  		Bit1_Set(a_DMCheck, playerid, false);
   		SendClientMessage(playerid, COLOR_RED, "[ ! ] Vise necete dobivati dojave o ubojstvima igraca!");
	}
    return 1;
}

CMD:masked(playerid, params[])
{

	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	SendClientMessage(playerid, COLOR_SKYBLUE, "Igraci s maskama:");
	foreach (new i : Player)
	{
		if (Bit1_Get(gr_MaskUse, i))
		{
			format(globalstring, sizeof(globalstring), "** ID: %d *** %s, MASK ID: %d", i, GetName(i, false), PlayerInfo[i][pMaskID]);
			SendClientMessage(playerid, -1, globalstring);
		}
	}
	return 1;
}

CMD:setviwo(playerid, params[])
{
    
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
	    viwoid,
	    string[32],
		giveplayerid;
    if (sscanf(params, "ui", giveplayerid, viwoid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setviwo [ID/Dio imena] [VirtualWorld]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerVirtualWorld(giveplayerid, viwoid);
	format(string, sizeof(string), "   Virtual World %d", viwoid);
	SendClientMessage(giveplayerid, COLOR_GREY, string);
	return 1;
}

CMD:onrecon(playerid, params[])
{
	if(!(PlayerInfo[playerid][pAdmin] >= 1337) && IsPlayerAdmin(playerid) == 0)
		return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	foreach (new h : Player) {
		if( IsPlayerReconing(h) ) {
			
			va_SendClientMessage(playerid, 0x7A93BCFF, "RECON: Admin %s [%s] -> %s", GetName(h,false), PlayerInfo[h][pForumName] ,GetName(ReconingPlayer[h],false));
		}
	}
	return 1;
}

CMD:recon(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new 
		giveplayerid;
	if( sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /recon [ID/Dio imena]");
    if( !IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    if( PlayerInfo[giveplayerid][pAdmin] >= 3 && PlayerInfo[playerid][pAdmin] < 1338) return SendClientMessage(playerid,COLOR_RED, "Ne mozes reconati admina level3+.");
	if( IsPlayerReconing(giveplayerid) ) return SendClientMessage(playerid, COLOR_RED, "Igrac vec recona nekoga!");

	oldskin[ playerid ] = GetPlayerSkin(playerid);

	if( IsPlayerReconing(playerid) ) {
		KillTimer(ReconTimer[playerid]);
		DestroyReconTextDraws(playerid);
		Bit4_Set(gr_SpecateId, playerid, 0);
	}
	
	ReconingPlayer[ playerid ] = giveplayerid;
	
	SetPlayerInterior(playerid, 	GetPlayerInterior(giveplayerid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
	
	if( IsPlayerInAnyVehicle(giveplayerid) ) {
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(giveplayerid));
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_VEH);
	} else {
		TogglePlayerSpectating(playerid, 1);
		Bit4_Set(gr_SpecateId, playerid, PLAYER_SPECATE_PLAYER);
		PlayerSpectatePlayer(playerid, giveplayerid);	
	}
	SetPlayerReconTarget(playerid, giveplayerid);
	return 1;
}

CMD:reconoff(playerid, params[])
{
	if( !IsPlayerReconing(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Ne reconate nikoga!");	
	
	KillTimer(ReconTimer[playerid]);
	DestroyReconTextDraws(playerid);
	Bit4_Set(gr_SpecateId, playerid, 0);
	TogglePlayerSpectating(playerid, 0);
	
	ReconingPlayer[ playerid ] = -1;
	
	new
		tmpMoney = PlayerInfo[playerid][pMoney];
	AC_GivePlayerMoney(playerid, -tmpMoney);
	AC_GivePlayerMoney(playerid, tmpMoney);
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Koristite /return za vracanje svojih oruzja i objekata prije recona!");
	return 1;
}

CMD:return(playerid, params[])
{
	#pragma unused params
    if( PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if( !Bit1_Get( a_PlayerReconed, playerid ) ) return SendClientMessage(playerid, COLOR_RED, "Ovu komandu mozete koristiti samo jednom!");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspjesno ste vratili oruzja i objekte koje ste imali.");
	SetPlayerObjects(playerid);
	AC_SetPlayerWeapons(playerid);
	SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
	SetPlayerSkin(playerid, oldskin[playerid]);
	Bit1_Set( a_PlayerReconed, playerid, false );
	return 1;
}

CMD:aon(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (!Bit1_Get(a_AdminOnDuty, playerid))
	{
	    SetPlayerColor(playerid, COLOR_ORANGE);
		SetPlayerHealth(playerid, 100, true);
		SetPlayerArmour(playerid, 100, true);
		
	    Bit1_Set(a_AdminOnDuty, playerid, true);
	    SendClientMessage(playerid, -1, "Sada ste na admin duznosti!");
	    foreach (new i : Player)
		{
	  		SetPlayerMarkerForPlayer(i, playerid, COLOR_ORANGE);
		}
	} 
	else 
	{
	    SetPlayerColor(playerid, COLOR_PLAYER);
		SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
		Bit1_Set(a_AdminOnDuty, playerid, false);

		SendClientMessage(playerid, -1, "Vise niste na admin duznosti!");
		foreach (new i : Player)
		{
	  		SetPlayerMarkerForPlayer(i, playerid, COLOR_PLAYER);
		}
	}
    return 1;
}

CMD:pweapons(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /pweapons [ID/Dio imena]");
	if( !IsPlayerLogged(giveplayerid) || !IsPlayerConnected(playerid) ) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije ulogiran!");
	
	new
	    weapon[13],
	    bullets[13];
	format(globalstring, sizeof(globalstring), "%s", GetName(giveplayerid,false));
	SendClientMessage(playerid, COLOR_GREEN, globalstring);
	for (new slot = 0; slot < 13; slot++)
    {
        GetPlayerWeaponData(giveplayerid, slot, weapon[slot], bullets[slot]);
        format(globalstring, sizeof(globalstring), "    SLOT: %d, ORUZJE: %s, METAKA: %d.", slot, WeapNames[weapon[slot]], bullets[slot]);
		SendClientMessage(playerid, -1, globalstring);
	}
	if(HiddenWeapon[giveplayerid][pwWeaponId] != 0)
		va_SendClientMessage(playerid, COLOR_WHITE, "	[Sakriveno ispod odjece]: %s, Metaka: %d.", WeapNames[HiddenWeapon[giveplayerid][pwWeaponId]], HiddenWeapon[giveplayerid][pwAmmo]);
	return 1;
}

CMD:am(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if (isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /am [Poruka]");
	format(globalstring, sizeof(globalstring), "(( ADMIN %s: %s ))", PlayerInfo[playerid][pForumName], params);
	SendClientMessageToAll(COLOR_YELLOW2, globalstring);
	#if defined MODULE_LOGS
	LogAdminMessage(globalstring);
	#endif
    return 1;
}

CMD:cnn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if (isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /cnn [Cnn textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
    if (strlen(params) < 0 || strlen(params) > 50) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 50 znakova!");
	format(globalstring, sizeof(globalstring), "~b~%s: ~w~%s", GetName(playerid,false), params);
	foreach (new i : Player)
	{
		if (IsPlayerConnected(i)) GameTextForPlayer(i, globalstring, 5000, 6);
	}
	return 1;
}

CMD:mute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /mute [ID/Dio imena]");
    if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	if (PlayerInfo[giveplayerid][pMuted] == 0)
	{
		PlayerInfo[giveplayerid][pMuted] = 1;
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je usutkan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	else
	{
		PlayerInfo[giveplayerid][pMuted] = 0;
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je odsutkan od strane %s", GetName(giveplayerid,false), GetName(playerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	return 1;
}

CMD:setint(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new intid, giveplayerid;
	if (sscanf(params, "ui", giveplayerid, intid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setint [ID/Dio imena] [Interiorid]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
	SetPlayerInterior(giveplayerid, intid);
	PlayerInfo[giveplayerid][pInt] = intid;
	format(globalstring, sizeof(globalstring), "Interior %d.", intid);
	SendClientMessage(giveplayerid, -1, globalstring);
	return 1;
}

CMD:check(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 4) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new giveplayerid;
    if (sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /check [ID/DioImena]");
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igraè nije online!");
    ShowPlayerStats(playerid, giveplayerid);
	return 1;
}

CMD:checkcostats(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new giveplayerid;
	if (sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /checkcostats [playerid/PartOfName]");
		return 1;
	}
	if(PlayerInfo[giveplayerid][pSpawnedCar] == -1) return SendClientMessage(playerid, COLOR_RED, "Igrac nema spawnano vozilo.");
	
	new name[ 36 ];
	strunpack( name, Model_Name(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vModel]) );
	format(globalstring, sizeof(globalstring), "Vozilo: %s [Model ID: %d] | Vlasnik: %s", name, VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vModel], GetName(giveplayerid, true));

	SendClientMessage(playerid, COLOR_SKYBLUE, globalstring);
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vNumberPlate] != 0)
	{
		format(globalstring, sizeof(globalstring), "Registriran    ||    Registracija: %s", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vNumberPlate]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Neregistriran");
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vLock] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Kvaliteta brave: Nekvalitetna");
	else
	{
		format(globalstring, sizeof(globalstring), "Kvaliteta brave: %d", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vLock]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vImmob] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Imobilizator: Nema");
	else
	{
		format(globalstring, sizeof(globalstring), "Imobilizator level: %d", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vImmob]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vAlarm] > 0)
	{
		format(globalstring, sizeof(globalstring), "Alarm level: %d", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vAlarm]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Alarm: Nema");
	
	va_SendClientMessage(playerid, COLOR_WHITE, "Akumulator: %s", GetBatteryTypeString(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vBatteryType]));
	
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vInsurance] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Osiguranje: Neosigurano");
	else
	{
		format(globalstring, sizeof(globalstring), "Osiguranje: %d", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vInsurance]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	if(VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vDestroys] == 0)
		SendClientMessage(playerid, COLOR_WHITE, "Puta unisteno: Nikada");
	else
	{
		format(globalstring, sizeof(globalstring), "Puta unisteno: %d", VehicleInfo[PlayerInfo[giveplayerid][pSpawnedCar]][vDestroys]);
		SendClientMessage(playerid, COLOR_WHITE, globalstring);
	}
	return 1;
}

CMD:kick(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    reason[21];
    if( sscanf(params, "us[21]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /kick [ID/Dio imena] [Razlog].");
    if( strlen(reason) < 0 || strlen(reason) > 20) return SendClientMessage(playerid, COLOR_RED, "Ne mozete ispod 0 ili preko 20 znakova za razlog!");
	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "Krivi ID igraca!");
	
	if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_RED, "Ne mozes kickati admina veceg levela!");
	
	format(globalstring, sizeof(globalstring), "%s je dobio kick od Admina %s, razlog: %s", GetName(giveplayerid,false), PlayerInfo[playerid][pForumName], reason);
	#if defined MODULE_LOGS
	LogAdminKick(globalstring);
	#endif
	format(globalstring, sizeof(globalstring), "AdmCMD: %s je dobio kick od Admina %s, razlog: %s", GetName(giveplayerid,false), PlayerInfo[playerid][pForumName], reason);
	SendClientMessageToAll(COLOR_RED, globalstring);
	KickMessage(giveplayerid);
	return 1;
}

CMD:approveobjects(playerid, params[]) {
	new giveplayerid;
	
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    if( sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /approveobjects [ID/Dio imena].");
    if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage( playerid, COLOR_RED, "Krivi unos playerida/imena!" );
	
	if(Bit1_Get(gr_CreateObject, giveplayerid)) {
		Bit1_Set(gr_CreateObject, giveplayerid, false);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "%s vam je zabranio/maknuo kreiranje objekata.", GetName(playerid));
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je zabranio/maknuo igracu %s da koristi /createobject.", GetName(playerid,false), GetName(giveplayerid,false));
	}
	else if(!Bit1_Get(gr_CreateObject, giveplayerid)) {
		Bit1_Set(gr_CreateObject, giveplayerid, true);
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "%s vam je dopustio kreiranje objekata, komanda: /createobject.", GetName(playerid));
		format(globalstring, sizeof(globalstring), "AdmCMD: %s je dopustio igracu %s da koristi /createobject.", GetName(playerid,false), GetName(giveplayerid,false));	
	}	
	SendAdminMessage(COLOR_LIGHTBLUE, globalstring);
	return (true);
}

CMD:apm(playerid, params[])
{
	new
		name[ MAX_PLAYER_NAME ];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	if(!IsValidNick(name)) return Ban(playerid);
	if ( !IsPlayerLogged(playerid) || !IsPlayerConnected(playerid) ) return SendErrorMessage(playerid, "Igrac nije ulogiran/connectan!");
	new 
		result[160], pmString[ 256 ],
		giveplayerid;
    if( sscanf( params, "us[160]", giveplayerid, result ) ) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /apm [ID/Dio Imena][text]" );
	if( giveplayerid == INVALID_PLAYER_ID ) return SendClientMessage( playerid, COLOR_RED, "Krivi unos playerida/imena!" );
	if( giveplayerid == playerid ) return SendClientMessage(playerid, COLOR_RED, "A ti i na viberu sam sebi pi�e�?" );
	if( strlen(result) > 160 ) return SendClientMessage(playerid, COLOR_RED, "Maksimalna velicina unosa je 90!" );
	if( PlayerInfo[playerid][pAdmin] ) {
	
		va_SendClientMessage(giveplayerid, 0x70B9FFFF, "[PM] Admin %s: %s", 
			GetName(playerid, false), 
			result
		);
		va_SendClientMessage(playerid, 0xE5C43EAA, "Poslali ste PM igracu %s [%d]: %s", 
			GetName(giveplayerid, false), 
			giveplayerid, 
			result
		);
		format(pmString, sizeof(pmString), "[A] %s je poslao PM igracu %s",
			GetName(playerid, false), 
			GetName(giveplayerid, false)
		);
		AHBroadCast(COLOR_NICEYELLOW,pmString,1);
		
		format(pmString, sizeof(pmString), "[APM] %s za %s: %s", 
			GetName(playerid, false), 
			GetName(giveplayerid, false), 
			result
		);
		PmearsBroadCast(0xFFD1D1FF,pmString, 1337);
		Bit16_Set( gr_LastPMId, giveplayerid, playerid );
	}
	else if(PlayerInfo[playerid][pHelper] >= 1) {
		va_SendClientMessage(giveplayerid, 0x82FFB4FF, "[PM] Helper %s: %s", 
			GetName(playerid, false), 
			result
		);
		va_SendClientMessage(playerid, 0xE5C43EAA, "Poslali ste PM igracu %s [%d]: %s", 
			GetName(giveplayerid, false), 
			giveplayerid, 
			result
		);
		
		format(pmString, sizeof(pmString), "[H] %s je poslao PM igracu %s",
			GetName(playerid, false), 
			GetName(giveplayerid, false)
		);
		AHBroadCast(COLOR_NICEYELLOW,pmString,1);
		
		format(pmString, sizeof(pmString), "[HPM] %s za %s: %s", 
			GetName(playerid, false), 
			GetName(giveplayerid, false), 
			result
		);
		PmearsBroadCast(0xFFD1D1FF,pmString, 1337);
		Bit16_Set( gr_LastPMId, giveplayerid, playerid );
	}
	
	if(playeReport[giveplayerid] != -1)
	{
		ClearReport(playeReport[giveplayerid]);
		playeReport[giveplayerid] = -1;
		
		new str[128];
		format(str, sizeof(str), "[REPORT] %s je odgovorio na report ID od %s", GetName(playerid, false), GetName(giveplayerid, false));
 		SendAdminNotification(MESSAGE_TYPE_INFO, str);
	}
	new log[128],
		playerip[MAX_PLAYER_IP];
	GetPlayerIp(playerid, playerip, sizeof(playerip));
	
	format(log, sizeof(log), "%s(%s) za %s: %s", 
		GetName(playerid, false),
		playerip, 
		GetName(giveplayerid, false), 
		result
	);
	LogPM(log);
	return 1;
}

CMD:givegun(playerid, params[])
{
    
	if (PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    gun,
		ammo;
	if (sscanf(params, "uii", giveplayerid, gun, ammo))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givegun [ID/DioImena] [Weaponid(eg. 46 = Parachute)] [Ammo]");
		SendClientMessage(playerid, COLOR_GREY, "Hladna: 1(Brass Knuckles) 2(Golf Club) 3(Nite Stick) 4(Knife) 5(Baseball Bat) 6(Shovel) 7(Pool Cue)");
		SendClientMessage(playerid, COLOR_GREY, "	8(Katana) 10-13(Dildo) 14(Flowers) 15(Cane)");
		SendClientMessage(playerid, COLOR_GREY, "Vatrena: 24(Deagle) 25(Shot Gun) 27(Combat Shot) 28(Micro Uzi) 29(MP5) 30(AK47) 31(M4) 32(Tec9)");
		SendClientMessage(playerid, COLOR_GREY, "	33(C. Rifle) 34(Sniper) 41(Spray Can) 42(Fire Ext.) 43(Camera) 46(Parachute)");
		return 1;
    }
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
    if (PlayerInfo[giveplayerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Igrac nije level 2!");
	if (gun < 1 || gun > 46 || gun == 35 || gun == 16 ||gun == 26 || gun == 44 || gun == 45)
	{ SendClientMessage(playerid, COLOR_RED, "Pogresan WeaponID!"); return 1; }
	if (ForbiddenWeapons(gun)) return SendClientMessage(playerid, COLOR_RED, "To oruzje je zabranjeno!");
	if (ammo < 1 || ammo > 9999) return SendClientMessage(playerid, COLOR_RED, "Nemojte ici ispod broja 1 ili iznad 9999! (Ammo)");
	if (! CheckPlayerWeapons(giveplayerid, gun) ) return 1;
	AC_GivePlayerWeapon(giveplayerid, gun, ammo);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste %s %s sa %d metaka.", GetName(giveplayerid, false), GetWeaponNameEx(gun), ammo);
	SendFormatMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, "Game Admin %s vam je dao %s sa %d metaka.", GetName(playerid, false), GetWeaponNameEx(gun), ammo);
	
	if(gun != 36 && gun !=38)
	{
		new
			tmpLog[ 128 ];
		format( tmpLog, 128, "Admin %s je dao %s %s sa %d metaka.",
			GetName(playerid, false),
			GetName(giveplayerid, false),
			GetWeaponNameEx(gun),
			ammo
		);
		#if defined MODULE_LOGS
		LogGiveGun(tmpLog);
		#endif
	}
	return 1;
}

CMD:givebullet(playerid, params[])
{
    
	if (PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	new
	    giveplayerid,
	    gun; 
		
	if (sscanf(params, "ui", giveplayerid, gun))
	{
		SendClientMessage(playerid, COLOR_RED, "[ ? ]: /givebullet [ID/DioImena] [Weaponid(eg. 46 = Parachute)] ");
		SendClientMessage(playerid, COLOR_GREY, "Hladna: 1(Brass Knuckles) 2(Golf Club) 3(Nite Stick) 4(Knife) 5(Baseball Bat) 6(Shovel) 7(Pool Cue)");
		SendClientMessage(playerid, COLOR_GREY, "	8(Katana) 10-13(Dildo) 14(Flowers) 15(Cane)");
		SendClientMessage(playerid, COLOR_GREY, "Vatrena: 24(Deagle) 25(Shot Gun) 27(Combat Shot) 28(Micro Uzi) 29(MP5) 30(AK47) 31(M4) 32(Tec9)");
		SendClientMessage(playerid, COLOR_GREY, "	33(C. Rifle) 34(Sniper) 41(Spray Can) 42(Fire Ext.) 43(Camera) 46(Parachute)");
		return 1;
    }
	if (!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online!");
    if (PlayerInfo[giveplayerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_RED, "Igrac nije level 2!");
	if (gun < 1 || gun > 46 || gun == 35 || gun == 16 ||gun == 26 || gun == 44 || gun == 45)
	{ SendClientMessage(playerid, COLOR_RED, "Pogresan WeaponID!"); return 1; }
	if (ForbiddenWeapons(gun)) return SendClientMessage(playerid, COLOR_RED, "To oruzje je zabranjeno!");
	if (! CheckPlayerWeapons(giveplayerid, gun) ) return 1;
	AC_GivePlayerWeapon(giveplayerid, gun, 1);
	
	SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste %s %s sa jednim metkom.", GetName(giveplayerid, false), GetWeaponNameEx(gun));
	SendFormatMessage(giveplayerid, MESSAGE_TYPE_SUCCESS, "Game Admin %s vam je dao %s sa jednim metkom.", GetName(playerid, false), GetWeaponNameEx(gun));
	
	if(gun != 36 && gun !=38)
	{
		new
			tmpLog[ 128 ];
		format( tmpLog, 128, "Admin %s je dao %s %s s 1 metkom municije (/givebullet).",
			GetName(playerid, false),
			GetName(giveplayerid, false),
			GetWeaponNameEx(gun)
		);
		#if defined MODULE_LOGS
		LogGiveGun(tmpLog);
		#endif
	}
	return 1;
}

CMD:house_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	foreach(new i:Houses)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][hEnterX], HouseInfo[i][hEnterY], HouseInfo[i][hEnterZ]) && HouseInfo[i][h3dViwo] == GetPlayerVirtualWorld(playerid))
		{
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] House ID: %d", i);
		}
	}
	return 1;
}

CMD:biznis_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	foreach(new i:Bizzes)
	{
		if (IsPlayerInRangeOfPoint(playerid,3,BizzInfo[i][bEntranceX], BizzInfo[i][bEntranceY], BizzInfo[i][bEntranceZ]))
		{
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Biz ID: %d", i);
		}
	}
	return 1;
}

CMD:complex_id(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
	foreach(new i:Complex)
	{
		if (IsPlayerInRangeOfPoint(playerid,3,ComplexInfo[i][cEnterX], ComplexInfo[i][cEnterY], ComplexInfo[i][cEnterZ]))
		{
			va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Complex ID: %d", i);
		}
	}
	return 1;
}

CMD:portplayer(playerid, params[])
{
	new locations, giveplayerid;

	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");

	if(sscanf(params, "un", giveplayerid, locations))
 	{
	 	SendClientMessage(playerid, COLOR_RED, "[ ? ]: /portplayer [playerid/DioImena] [location]");
	 	SendClientMessage(playerid, COLOR_GREY, "|1. Los Santos |2. Verona Mall |3. Richman |4. Grotti & Bank |5. Market Street");
	 	SendClientMessage(playerid, COLOR_GREY, "|6. Fire Department |7. Downtown LS |8. Vinewood |9. Ammunation |10. Verdant Bluffs");
	 	SendClientMessage(playerid, COLOR_GREY, "|11. El Corona |12. Idlewood |13. El Corona |14. Playa Del Seville |15. Ganton");
	 	SendClientMessage(playerid, COLOR_GREY, "|16. East LS |17. Jefferson |18. Glen Park |19. Mullholand");
	 	SendClientMessage(playerid, COLOR_GREY, "|20. Star Street |21. Trucker |22. Trucker (desert)");
	}
	else
	{
	    switch(locations)
	    {
	        case 1:
	        {
	            SetPlayerPosEx(giveplayerid, 1476.9183,-1679.6967,14.0469, 0, 0);
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
			case 2:
			{
			    SetPlayerPosEx(giveplayerid, 1102.3347,-1382.8169,13.7813, 0, 0);
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
			case 3:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 387.1776,-1173.8473,78.3563, 0, 0);
			}
			case 4:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 583.9010,-1240.2880,17.3085, 0, 0);
			}
			case 5:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 776.9227,-1388.4016,13.1934, 0, 0);
			}
			case 6:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1188.3400,-1316.9271,13.1330, 0, 0);
			}
			case 7:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1436.7577,-1167.1057,23.3978, 0, 0);
			}
			case 8:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1348.1587,-923.2181,34.6007, 0, 0);
			}
			case 9:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1364.0243,-1280.9617,13.1143, 0, 0);
			}
			case 10:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1194.3335,-2036.6687,68.5756, 0, 0);
			}
			case 11:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
           		SetPlayerPosEx(giveplayerid, 1955.3833,-2090.6282,13.1154, 0, 0);
			}
			case 12:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2041.3593,-1743.9049,13.1112, 0, 0);
			}
			case 13:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1882.9041,-2016.5022, 13.5469, 0, 0);
			}
			case 14:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2723.9143,-1943.1840,13.1113, 0, 0);
			}
			case 15:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2225.5811, -1742.8641, 13.5634, 0, 0);
			}
			case 16:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2392.5415,-1381.8247,23.5676, 0, 0);
			}
			case 17:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 2095.8801,-1377.7487,23.5560, 0, 0);
			}
			case 18:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1975.2610,-1197.4194,25.3582, 0, 0);
			}
			case 19:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1647.8340,-1154.4443,23.6376, 0, 0);
			}
			case 20:
			{
	            SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
	            SetPlayerPosEx(giveplayerid, 1236.0244,-1155.5094,23.1332, 0, 0);
			}
			case 21:
			{
				SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
				SetPlayerPosEx(giveplayerid, -303.6173,-2136.2605,28.0347, 0, 0);
			}
			case 22:
			{
				SetPlayerPosEx(giveplayerid, -231.5353,2621.0098,62.8980, 0, 0);
				SendClientMessage(giveplayerid, COLOR_GREY, "Teleportovani ste.");
			}
		}
  		format(globalstring, sizeof(globalstring), "AdmCMD: Admin %s je teleportovao igraca %s na lokaciju.", GetName(playerid,false), GetName(giveplayerid,false));
		SendAdminMessage(COLOR_RED, globalstring);
	}
	return 1;
}
CMD:adminmsg(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new playerb[25], n_reason[128];

	if (sscanf(params, "s[25]s[128]", playerb, n_reason))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /adminmsg [character name] [message]");

	mysql_format(g_SQL, mysqlquery, sizeof(mysqlquery), "SELECT * FROM `accounts` WHERE `name` = '%e' LIMIT 1", playerb);
    mysql_tquery(g_SQL, mysqlquery, "AddAdminMessage", "iss", playerid, playerb, n_reason);
	return true;
}

CMD:kickall(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !IsPlayerAdmin(i))
    {
        Kick(i);
        printf("SERVER: Developer je kickovao sve igrace sa servera");
    }
    format(globalstring, sizeof(globalstring), "AdmCMD: %s je kickovao sve igrace sa servera.", PlayerInfo[playerid][pForumName]);
	SendClientMessageToAll(COLOR_RED, globalstring);
    return true;
}

CMD:banip(playerid,params[]) {
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED,"[ ? ]: /banip [ip]");
	new string[128];
	format(string,sizeof string,"banip %s",params);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	format(string,sizeof string,"[ ! ] Uspje�no ste banovali IP.");
	return SendClientMessage(playerid,-1,string);
}
CMD:ptp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
    new
		Float:X, Float:Y, Float:Z;
	new giveplayerid, targetid;
    if(sscanf(params, "uu", giveplayerid, targetid)) return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /ptp [giveplayerid] [targetid]");
	
	GetPlayerPos(targetid, X, Y, Z);
	SetPlayerPos(giveplayerid, X, Y, Z);
	
	va_SendClientMessage(targetid, COLOR_RED, "[ ! ] Admin je teleportova igraca %s do vas.", GetName(giveplayerid));
	va_SendClientMessage(giveplayerid, COLOR_RED, "[ ! ] Admin vas je teleportovao do igraca %s", GetName(targetid));
    va_SendClientMessage(playerid, COLOR_RED, "[ ! ] Uspje�no ste teleportovali %s do %s", GetName(giveplayerid), GetName(targetid));
	return 1;
}
CMD:forceduty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");
 	new
 		giveplayerid;

	if(sscanf(params, "us[128]", giveplayerid))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /forceduty [playerid/DioImena]");

	if(!IsPlayerConnected(giveplayerid))return SendClientMessage(playerid, giveplayerid, "Taj igrac nije konektovan.");
	if(!PlayerInfo[giveplayerid][pAdmin])return SendClientMessage(playerid, giveplayerid, "Taj igrac nije admin.");
	new
		str[128];

	if (!Bit1_Get(a_AdminOnDuty, playerid))
	{
		Bit1_Set(a_AdminOnDuty, playerid, true);

		format(str, sizeof(str), "AdmCmd: %s je sada na admin duznosti (forced by %s).", GetName(giveplayerid, false), GetName(playerid, false));
		SendAdminMessage(COLOR_RED, str);
		SetPlayerColor(giveplayerid, COLOR_ORANGE);
		Streamer_Update(giveplayerid);

	}
	else
	{
		Bit1_Set(a_AdminOnDuty, playerid, false);

		format(str, sizeof(str), "AdmCmd: %s vise nije na admin duznosti (forced by %s).", GetName(giveplayerid, false), GetName(playerid, false));
		SendAdminMessage(COLOR_RED, str);

		SetPlayerColor(giveplayerid, COLOR_PLAYER);
		Streamer_Update(giveplayerid);

		SetPlayerHealth(giveplayerid, 100);
	}
	return true;
}

CMD:togreg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
		return 0;
		
	if(regenabled)
		regenabled = false;
	else
		regenabled = true;
	
	va_ABroadCast((regenabled) ? (COLOR_GREEN) : (COLOR_RED), "AdmWarn: %s je %s registraciju na serveru!", 1, GetName(playerid, false), (regenabled) ? ("ukljucio") : ("iskljucio"));
	return 1;
}
CMD:setservertime(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni za koristenje ove komande!");

	new tmphour;
	if(sscanf(params, "i", tmphour))
		return SendClientMessage(playerid, COLOR_RED, "[ ? ]: /setservertime [time]");
		
	foreach (new i : Player)
	{
	    if (IsPlayerConnected(i))
	    {
	        SetPlayerTime(i,tmphour,0);
	    }
	}
	return 1;
}
