#if !defined AUTO_RESTART_SEQ
    #endinput
#endif

StartGMX()
{
	for (new a = 1; a <= 20; a++)
	{
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
		SendClientMessageToAll(-1, "\n");
	}
	CountSeconds_Set(30);
	foreach (new i : Player) 
	{
		// Player Camera
		TogglePlayerControllable(i, false);
		SetPlayerPos(i, 1433.4633, -974.7463, 58.0000);
		InterpolateCameraPos(i, 1431.9108, -895.1843, 73.9480, 1431.9108, -895.1843, 73.9480, 100000, CAMERA_MOVE);
		InterpolateCameraLookAt(i, 1431.8031, -894.1859, 74.0085, 1431.8031, -894.1859, 74.0085, 100000, CAMERA_MOVE);
		CountSeconds_Set(CountSeconds_Get() + 3);
	}
	GMX_Set(1);
	new rconstring[100];
	format(rconstring, sizeof(rconstring), "hostname %s [Database Saving in Process]", SERVER_NAME);
	SendRconCommand(rconstring);
	SendRconCommand("password devtest");
	SendClientMessageToAll(COLOR_RED, "[SERVER]: Server Restart procedure initiated. Please stay in game until server stores your data...");
	SaveAll();
	return 1;
}

SaveAll()
{
	printf("[SERVER]: Automatic scheduled restart initiated. Storing data into MySQL database.");
	if(Iter_Count(Player) > 0)
	{
		foreach (new i : Player) 
		{
			if(Player_SafeSpawned(i))
				Kick(i);
		}
	}
}

task GMXTimer[1000]()
{
	#if defined AUTO_RESTART_SEQ
	if(GMX_Get() == 1)
	{
		CountSeconds_Set(CountSeconds_Get() - 1);
		new 
            string[10];
		format(string, sizeof(string), "%d", CountSeconds_Get());
		GameTextForAll(string, 1000, 4);
		if(CountSeconds_Get() < 1)
		{
			GMX_Set(0);
			foreach(new i : Player) 
			{
				if(PlayerInfo[i][pAdmin] >= 1338) 
				{
					SendClientMessage(i, COLOR_RED, "[INFO]: Storing the data in server is done. Restarting Server...");
					KickMessage(i);
				}
			}
			GameModeExit();
			return 1;
		}
	}
	#endif
	if(GMX_Get() == 2)
	{
		CountSeconds_Set(CountSeconds_Get() - 1);
		if(CountSeconds_Get() < 1)
		{
			GMX_Set(0);
			CountSeconds_Set(0);
			SendRconCommand("password 0");
			return 1;
		}
	}
	return 1;
}