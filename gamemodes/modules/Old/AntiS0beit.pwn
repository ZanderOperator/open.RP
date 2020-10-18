#include <YSI_Coding\y_hooks>

new playerSpawned[MAX_PLAYERS];
new carveh[MAX_PLAYERS];
hook OnPlayerConnect(playerid)
{
    playerSpawned[playerid] = 0;
	return 1;
}

stock CheckS0beit(playerid)
{
	SetPlayerVirtualWorld(playerid, 100+playerid);
	ResetPlayerWeapons(playerid);
	carveh[playerid] = CreateVehicle(457, 2109.1763, 1503.0453, 32.2887, 82.2873, 0, 1, 60);
	SetVehicleVirtualWorld(carveh[playerid], 100+playerid);
	PutPlayerInVehicle(playerid, carveh[playerid], 0);
	RemovePlayerFromVehicle(playerid);
	DestroyVehicle(carveh[playerid]);
	SetPlayerPos(playerid, 0.0, 0.0, 10000.0);
	SetTimerEx("AntiS0bek", 1000, false, "i", playerid);
}
	forward AntiS0bek(pID);
	public AntiS0bek(pID)
	{
        new dt[2];
        GetPlayerWeaponData(pID, WEAPON_GOLFCLUB-1, dt[0], dt[1]);
        if(dt[0] == WEAPON_GOLFCLUB)
		{
		    GameTextForPlayer(pID, "~y~S0beit detektovan!", 3000, 6);
  			Kick(pID);
        }
		else
		{
  			ResetPlayerWeapons(pID);
		  	GameTextForPlayer(pID, "~y~S0beit nije detektovan!", 3000, 6);
		  	playerSpawned[pID] = 1;
		  	SetPlayerPos(pID, 0.0, 0.0, 0.0);
     	}
		return 1;
	}
