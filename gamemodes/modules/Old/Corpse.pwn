#include <YSI\y_hooks>

/* ----- */

#define MAX_REMAINS																(25)
#define TYPE_REMAINS_PERSON														(1)
#define INVALID_SCRIPT_ID														(-1)

/* ----- */

new
		Iterator:Remains<MAX_REMAINS>;

enum DataRemains
{
	Type,
	Model,
	Time,
	Text3D:Information
}

new
		RemainsData[MAX_REMAINS][DataRemains], timer;

/* ----- */

forward Global_Timer();
public Global_Timer()
{
	new
			iter_next;
	foreach(new a : Remains)
	{
		if(RemainsData[a][Time] > 0)
			RemainsData[a][Time]--;
		else
		{
			DestroyRemains(a, true);
			Iter_SafeRemove(Remains, a, iter_next);
			a = iter_next;
		}
	}
	return true;
}

stock CreateRemains(name, type, model, time, Float:pos_x, Float:pos_y, Float:pos_z, Float:angle, world, interior)
{
	new
			r_id = Iter_Free(Remains);
	if(r_id == INVALID_SCRIPT_ID)
		return INVALID_SCRIPT_ID;
	Iter_Add(Remains, r_id);
	// Type of the remains.
	RemainsData[r_id][Type]				=					   type;
	// Model of the remains.
	switch(type)
	{
		case TYPE_REMAINS_PERSON:
		{
			// Actor for the remains.
			RemainsData[r_id][Model]	=				CreateActor(
				model,
				pos_x,
				pos_y,
				pos_z,
				angle
			);
			SetActorVirtualWorld(RemainsData[r_id][Model],	world);
			SetActorHealth(RemainsData[r_id][Model],		  0.0);
			ApplyActorAnimation(RemainsData[r_id][Model], "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 0, 0);

			pos_z = (pos_z - 0.5);
		}
	}
	// Time before the remains are destroyed.
	RemainsData[r_id][Time]				=					   time;
	// 3d label for the remains.
	new
		tmpString[ 85 ];
	format(tmpString, sizeof(tmpString), "** Leš pripada %s **", name);
	RemainsData[r_id][Information] = CreateDynamic3DTextLabel(tmpString, COLOR_DEATH, pos_x, pos_y, pos_z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, world, interior, INVALID_SCRIPT_ID, 10.0);


	return r_id;
}

stock DestroyRemains(r_id, bool:iter = false)
{
	if(!Iter_Contains(Remains, r_id))
		return false;
	if(!iter)
		Iter_Remove(Remains, r_id);
	// Model of the remains.
	switch(RemainsData[r_id][Type])
	{
		case TYPE_REMAINS_PERSON:
		{
			if(IsValidActor(RemainsData[r_id][Model]))
				DestroyActor(RemainsData[r_id][Model]);
		}
	}
	RemainsData[r_id][Model]			=					 0xFFFF;
	// Type of the remains.
	RemainsData[r_id][Type]				=						  0;
	// Remains time.
	RemainsData[r_id][Time]				=						  0;
	// 3d label for the remains.
	if(IsValidDynamic3DTextLabel(RemainsData[r_id][Information]))
	{
		DestroyDynamic3DTextLabel(RemainsData[r_id][Information]);
		RemainsData[r_id][Information] = Text3D:INVALID_3DTEXT_ID;
	}
	return true;
}

/* ----- */

hook OnGameModeInit()
{
	timer = SetTimer("Global_Timer", 1000, true);
	return true;
}

hook OnGameModeExit()
{
	KillTimer(timer);

	new
			iter_next;
 	foreach(new a : Remains)
	{
		DestroyRemains(a, true);
		Iter_SafeRemove(Remains, a, iter_next);
		a = iter_next;
	}
	return true;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	new
			Float:pos[4];
	GetPlayerPos(playerid,			pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid,	pos[3]);
	
	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    
	CreateRemains(
		name,
		TYPE_REMAINS_PERSON,
		GetPlayerSkin(playerid),
		120, // 2 minutes.
		pos[0],
		pos[1],
		pos[2],
		pos[3],
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)
	);
	return true;
}
