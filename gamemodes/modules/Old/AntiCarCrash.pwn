#include <YSI\y_hooks>

new bool:PlayerBlocked[MAX_PLAYERS] = false;

static stock BlockUpdate(playerid)
{
	return PlayerBlocked[playerid] = true;
}

static MaxSeats[212] = {
4,2,2,2,4,4,1,2,2,4,2,2,2,4,2,2,4,2,4,2,4,4,2,2,2,1,4,4,4,2,1,9,1,2,2,1,2,9,4,2,
4,1,2,2,2,4,1,2,1,6,1,2,1,1,1,2,2,2,4,4,2,2,2,2,2,2,4,4,2,2,4,2,1,1,2,2,1,2,2,4,
2,1,4,3,1,1,1,4,2,2,4,2,4,1,2,2,2,4,4,2,2,2,2,2,2,2,2,4,2,1,1,2,1,1,2,2,4,2,2,1,
1,2,2,2,2,2,2,2,2,4,1,1,1,2,2,2,2,0,0,1,4,2,2,2,2,2,4,4,2,2,4,4,2,1,2,2,2,2,2,2,
4,4,2,2,1,2,4,4,1,0,0,1,1,2,1,2,2,2,2,4,4,2,4,1,1,4,2,2,2,2,6,1,2,2,2,1,4,4,4,2,
2,2,2,2,4,2,1,1,1,4,1,1
};

static stock GetMaxSeats(vehicleid)
{
    return MaxSeats[(GetVehicleModel(vehicleid) - 400)];
}

hook OnPlayerConnect(playerid)
{
	PlayerBlocked[playerid] = false;
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if (PlayerBlocked[playerid] == true)
		return 0;
	
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if (newstate == PLAYER_STATE_PASSENGER)
		{	
			new
				model = GetPlayerVehicleSeat(playerid);
				
			if (0 < GetPlayerVehicleID(playerid) < MAX_VEHICLES)
			{
				if (model != 128 && model != -1)
				{
					new maxseat = GetMaxSeats(GetPlayerVehicleID(playerid));
					printf("DEBUG: maxseat: %d, seat: %d", maxseat, model);
					if(maxseat < 1 || model > maxseat) // Kralj brije da je putnik a nije
					{
						// They are a driver, but not in the driver's seat.
						printf("DEBUG: Player BlockUpdate - fixes.inc -8303 line\n");
						BlockUpdate(playerid);
					}
				}
			}
			else
			{
				printf("DEBUG: Player BlockUpdate - fixes.inc -8303 line\n");
				BlockUpdate(playerid);
			}
		}
		else if (newstate == PLAYER_STATE_DRIVER)
		{
			new
				model = GetPlayerVehicleSeat(playerid);
			
			if (0 < GetPlayerVehicleID(playerid) < MAX_VEHICLES)
			{
				if (model != 128 && model != -1)
				{
					new maxseat = GetMaxSeats(GetPlayerVehicleID(playerid));
					if(maxseat < 1 || model > 0) // Kralj brije da je putnik a nije
					{
						// They are a driver, but not in the driver's seat.
						printf("DEBUG: Player BlockUpdate - fixes.inc -8337 line\n");
						BlockUpdate(playerid);
					}
				}
			}
			else
			{
				printf("DEBUG: Player BlockUpdate - fixes.inc -8303 line\n");
				BlockUpdate(playerid);
			}
		}
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1)
	{	
		if (!IsVehicleStreamedIn(vehicleid, playerid) || !(0 < GetPlayerVehicleID(playerid) < MAX_VEHICLES))
		{
			printf("DEBUG: Player BlockUpdate - fixes.inc -8330 line\n");
			BlockUpdate(playerid);
			return 0;
		}
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1)
	{	
		if (!IsVehicleStreamedIn(vehicleid, playerid) || !(0 < GetPlayerVehicleID(playerid) < MAX_VEHICLES))
		{
			printf("DEBUG: Player BlockUpdate - fixes.inc -8330 line\n");
			BlockUpdate(playerid);
			return 0;
		}
	}
	return 1;
}
		