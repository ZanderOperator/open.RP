public OnGameModeInit()
{
	SendRconCommand("password 6325234hbbzfg12312313gz313"); // Server Lock while everything loads	

	MapAndreas_Init(MAP_ANDREAS_MODE_FULL, "scriptfiles/SAfull.hmap");
	print("Report: MapAndreas Initialised.");

	// Streamer config
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, OBJECT_STREAM_LIMIT, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_PICKUP, 3900, -1);
	Streamer_SetVisibleItems(STREAMER_TYPE_3D_TEXT_LABEL, 1000, -1);
	print("Report: Streamer Configuration Complete.");

	Reg_SetEnabled(true); // Enable Account Registration

	// SA-MP gamemode settings
	ShowNameTags(1);
    SetNameTagDrawDistance(15.0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(1);
	ManualVehicleEngineAndLights();
	SetMaxConnections(3, e_FLOOD_ACTION_GHOST);
	SendRconCommand("cookielogging 0");
	SendRconCommand("messageholelimit 9000");
	SendRconCommand("ackslimit 11000");
	print("Report: GameMode Settings Loaded.");

	// Server Informations
	new 	
		gstring[64];
	format(gstring, sizeof(gstring), "hostname %s", HOSTNAME);
	SendRconCommand(gstring);
 	SetGameModeText(SCRIPT_VERSION);
	print("Report: Server Info Loaded.");

	// Auto Unlock Settings
	GMX_Set(2);
	CountSeconds_Set(SERVER_UNLOCK_TIME);

	printf("Report: GameMode Time Set on %s", 
		ReturnTime(),
		SERVER_NAME
	);
	return 1;
}