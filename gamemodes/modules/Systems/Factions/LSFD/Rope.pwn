/*
 	    FD Rope
 	Autor: Khawaja
	Released: 2020

*/

#include <YSI_Coding\y_hooks>

#define chopperid 497
#define ropelength 50

#define offsetz 12
#define ROPE_ANIM_DUR 250

static r0pes[MAX_PLAYERS][ropelength],
	Float:pl_pos[MAX_PLAYERS][5],
	Timer:RopeTimer[MAX_PLAYERS],
	bool:Roped[MAX_PLAYERS],
	ChopperID[MAX_PLAYERS]; 

hook OnPlayerDisconnect(playerid, reason)
{
    if(Roped[playerid])
	{
	    for(new destr=0;destr<=ropelength;destr++)
		{
		    DestroyObject(r0pes[playerid][destr]);
		}
	}
	Roped[playerid] = false;
	ChopperID[playerid] = -1;
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(Roped[playerid])
	{
	    for(new destr2=0;destr2<=ropelength;destr2++)
		{
		    DestroyObject(r0pes[playerid][destr2]);
		}
		Roped[playerid] = false;
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == chopperid)
	{
	    foreach(new shg: Player)
	    {
	        if(ChopperID[shg] == vehicleid && Roped[shg])
	        {
	            DisablePlayerCheckpoint(shg);
	            Roped[shg] = false;
	            DisablePlayerCheckpoint(shg);
	            ClearAnimations(shg);
	            TogglePlayerControllable(shg,1);
	            for(new destr3=0;destr3<=ropelength;destr3++)
				{
				    DestroyObject(r0pes[shg][destr3]);
				}
			}
		}
	}
	return 1;
}

timer RopeSyncAnim[ROPE_ANIM_DUR](playerid)
{
	if(!Roped[playerid]) 
	{
		stop RopeTimer[playerid];
		return 1;
	}
	ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == chopperid && ispassenger)
	{
		ChopperID[playerid] = GetPlayerVehicleID(playerid);
		Roped[playerid] = false;
	}
	else ChopperID[playerid] = -1;
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(Roped[playerid] && (IsFDMember(playerid) || IsASD(playerid)))
    {
        Roped[playerid] = false;
        ChopperID[playerid] = -1;
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid,0);
        TogglePlayerControllable(playerid,1);
        DisablePlayerCheckpoint(playerid);
        for(new destr4=0;destr4<=ropelength;destr4++)
		{
		    DestroyObject(r0pes[playerid][destr4]);
		}
	}

	return 1;
}

CMD:rope(playerid, params[])
{
	if(IsASD(playerid) || IsFDMember(playerid) && !Roped[playerid] && GetPlayerVehicleSeat(playerid) != 0 && IsPlayerInAnyVehicle(playerid))
	{
		GetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][2]);
		MapAndreas_FindZ_For2DCoord(pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][3]);
		pl_pos[playerid][4] = floatsub(pl_pos[playerid][2],pl_pos[playerid][3]);
		if(pl_pos[playerid][4] >= ropelength) return SendClientMessage(playerid,0xAA3333AA,"Ne mozes sa ove visine.");
		if(pl_pos[playerid][4] <= 2) return RemovePlayerFromVehicle(playerid);
		Roped[playerid] = true;
		SetPlayerCheckpoint(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][3],offsetz),20);
		SetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][2],2));
		SetPlayerVelocity(playerid,0,0,0);
		for(new rep=0;rep!=10;rep++) ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
		for(new cre=0;cre<=pl_pos[playerid][4];cre++)
		{
		    r0pes[playerid][cre] = CreateObject(3004,pl_pos[playerid][0],pl_pos[playerid][1],floatadd(pl_pos[playerid][3],cre),87.640026855469,342.13500976563, 350.07507324219);
		}
		RopeTimer[playerid] = repeat RopeSyncAnim(playerid);
	}
	return 1;
}
