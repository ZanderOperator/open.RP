#include <YSI_Coding\y_hooks>
 /*
 --*                                *
 --*   @Author:      Hanger         *
 --*   @Version:     3.2	        *
 --*                                *
 */

#if defined _avt_included
	#endinput
#endif	
#define _avt_included

new 
	Float:	VEHICLE_POSITIONS	[MAX_VEHICLES] 	[4],
	bool:	ALLOW_UPDATE		[MAX_VEHICLES] 			= 		{ false, ... },
	bool:	VEHICLE_SPAWNED		[MAX_VEHICLES] 			= 		{ false, ... },
			LAST_TRAILER		[MAX_VEHICLES],
			LAST_TOWED			[MAX_VEHICLES],
			UPDATE_COUNTER		[MAX_VEHICLES 	char];
	
new
			LAST_VEHICLE		[MAX_PLAYERS],
			FORCED_VEHICLE		[MAX_PLAYERS];
			
forward OnAntiCheatVehicleWarp(playerid, vehicleid);
forward OnAntiCheatVehicleWarpInto(playerid, vehicleid);

stock FreeVehicleCheck(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z)
{
	#pragma unused passenger_seat
	if(VEHICLE_SPAWNED[vehicleid])
	{
		if(!ALLOW_UPDATE[vehicleid])
		{
			if(GetVehicleDistanceFromPoint(
					vehicleid,
					VEHICLE_POSITIONS	[vehicleid]	[0],
					VEHICLE_POSITIONS	[vehicleid]	[1],
					VEHICLE_POSITIONS	[vehicleid]	[2])
				> 10.5)
			{
				UPDATE_COUNTER			{vehicleid} 	=	0;
				ClearAnimations(playerid, 1);
				
				SetVehicleOriginalPos(vehicleid);
				if (funcidx("OnAntiCheatVehicleWarp") != -1)
				{
					CallLocalFunction("OnAntiCheatVehicleWarp", "ii", playerid, vehicleid);
				}
				
			}
			else
			{
				if(UPDATE_COUNTER	{vehicleid} 	>= 		2)
				{
					UPDATE_COUNTER		{vehicleid}		=	0;
					VEHICLE_POSITIONS	[vehicleid]	[0] =	new_x;
					VEHICLE_POSITIONS	[vehicleid]	[1]	=	new_y;
					VEHICLE_POSITIONS	[vehicleid]	[2]	=	new_z;
					GetVehicleZAngle(
						vehicleid,
						VEHICLE_POSITIONS	[vehicleid]	[3]);
				}
				UPDATE_COUNTER	{vehicleid} 	++;
			}
		}
		else
		{	
			if(LAST_TRAILER[vehicleid] > 0)
			{
				if(!IsTrailerAttachedToVehicle(LAST_TRAILER[vehicleid]))
				{
					LAST_TOWED		[LAST_TRAILER[vehicleid]] 	=	0;
					LAST_TRAILER	[vehicleid]		=	0;
					ALLOW_UPDATE	[vehicleid]		=	false;
					UPDATE_COUNTER	{vehicleid} 	=	0;
				}
			}
			else
			{	
				if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) <= 1.5)
				{
					SaveVehiclePosition(vehicleid);
					SetVehicleOriginalPos(vehicleid);
					UPDATE_COUNTER	{vehicleid} 	=	0;
					ALLOW_UPDATE	[vehicleid]		=	false;
				}
			}
		}
	}
	return 1;
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		SaveVehiclePosition(	LAST_VEHICLE[playerid]		);
		ALLOW_UPDATE	[LAST_VEHICLE[playerid]]		=	true;
	}
	else if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(FORCED_VEHICLE[playerid] == vehicleid)
		{
			FORCED_VEHICLE		[playerid] 	=	0;
			LAST_VEHICLE		[playerid] 	= 	vehicleid;
		}
		else
		{
			if(VEHICLE_SPAWNED[vehicleid])
			{
				ClearAnimations(playerid, 1);
				SetVehicleToRespawn(vehicleid);
				if (funcidx("OnAntiCheatVehicleWarpInto") != -1)
				{
					return CallLocalFunction("OnAntiCheatVehicleWarpInto", "ii", playerid, vehicleid);
				}
			}
		}
		if(!ALLOW_UPDATE[vehicleid])
		{
			if(GetVehicleDistanceFromPoint(
				vehicleid,
				VEHICLE_POSITIONS	[vehicleid]	[0],
				VEHICLE_POSITIONS	[vehicleid]	[1],
				VEHICLE_POSITIONS	[vehicleid]	[2]) > 7.5)
			{
				UPDATE_COUNTER			{vehicleid} 	=	0;
				ClearAnimations(playerid, 1);
					
				SetVehicleOriginalPos(vehicleid);
				if (funcidx("OnAntiCheatVehicleWarp") != -1)
				{
					return CallLocalFunction("OnAntiCheatVehicleWarp", "ii", playerid, vehicleid);
				}
			}
		}
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	FORCED_VEHICLE	[playerid]	=	vehicleid;
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	SaveVehiclePosition(vehicleid);
	
	VEHICLE_SPAWNED		[vehicleid]			=	true;
	
	if(LAST_TRAILER	[vehicleid] > 0)
	{
		if(VEHICLE_SPAWNED[LAST_TRAILER[vehicleid]])
		{
			AttachTrailerToVehicle(vehicleid, LAST_TRAILER[vehicleid]);
		}
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	VEHICLE_SPAWNED		[vehicleid]		=	false;
	
	if(LAST_TOWED[vehicleid] > 0)
	{
		LAST_TRAILER		[LAST_TOWED[vehicleid]]		= 	0;
		UPDATE_COUNTER		{LAST_TOWED[vehicleid]} 	=	0;
		ALLOW_UPDATE		[LAST_TOWED[vehicleid]]		=	false;
		LAST_TOWED			[vehicleid] 				=	0;
	}
	if(LAST_TRAILER[vehicleid] > 0)
	{
		LAST_TOWED			[LAST_TRAILER[vehicleid]] 		=	0;
		LAST_TRAILER		[vehicleid]						= 	0;
		UPDATE_COUNTER		{vehicleid} 					=	0;
		ALLOW_UPDATE		[vehicleid]						=	false;
	}
	return 1;
}

hook OnVehicleStreamIn(vehicleid, forplayerid)
{
	if(!VEHICLE_SPAWNED[vehicleid])
	{
		VEHICLE_SPAWNED		[vehicleid]			=	true;
		SetVehicleToRespawn(vehicleid);
	}
	return 1;
}

stock avt_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:angle, color1, color2)
{
	modelid	=	AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, angle, color1, color2);
	
	VEHICLE_POSITIONS	[modelid]	[0]		=	spawn_x;
	VEHICLE_POSITIONS	[modelid]	[1]		=	spawn_y;
	VEHICLE_POSITIONS	[modelid]	[2]		=	spawn_z;
	VEHICLE_POSITIONS	[modelid]	[3]		=	angle;
	
	SetVehicleToRespawn(modelid);
	return modelid;
}
#if defined _ALS_AddStaticVehicle
    #undef AddStaticVehicle
#else
    #define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle avt_AddStaticVehicle


stock avt_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:angle, color1, color2, respawn_delay)
{
	modelid	=	AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, angle, color1, color2, respawn_delay);
		
	VEHICLE_POSITIONS	[modelid]	[0]		=	spawn_x;
	VEHICLE_POSITIONS	[modelid]	[1]		=	spawn_y;
	VEHICLE_POSITIONS	[modelid]	[2]		=	spawn_z;
	VEHICLE_POSITIONS	[modelid]	[3]		=	angle;
	
	SetVehicleToRespawn(modelid);
	return modelid;
}
#if defined _ALS_AddStaticVehicleEx
    #undef AddStaticVehicleEx
#else
    #define _ALS_AddStaticVehicleEx
#endif
#define AddStaticVehicleEx avt_AddStaticVehicleEx


hook CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay)
{
	modelid	=	CreateVehicle(modelid, x, y, z, angle, color1, color2, respawn_delay);
				
	VEHICLE_POSITIONS	[modelid]	[0]		=	x;
	VEHICLE_POSITIONS	[modelid]	[1]		=	y;
	VEHICLE_POSITIONS	[modelid]	[2]		=	z;
	VEHICLE_POSITIONS	[modelid]	[3]		=	angle;
	
	SetVehicleToRespawn(modelid);
	return modelid;
}

hook DestroyVehicle(vehicleid)
{	
	VEHICLE_POSITIONS	[vehicleid]	[0]		=	0.0;
	VEHICLE_POSITIONS	[vehicleid]	[1]		=	0.0;
	VEHICLE_POSITIONS	[vehicleid]	[2]		=	0.0;
	VEHICLE_POSITIONS	[vehicleid]	[3]		=	0.0;
	VEHICLE_SPAWNED		[vehicleid]			=	false;
	return DestroyVehicle(vehicleid);
}

stock avt_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{	
	VEHICLE_POSITIONS	[vehicleid]	[0]		=	x;
	VEHICLE_POSITIONS	[vehicleid]	[1]		=	y;
	VEHICLE_POSITIONS	[vehicleid]	[2]		=	z;
	
	return SetVehiclePos(vehicleid, x, y, z);
}
#if defined _ALS_SetVehiclePos
    #undef SetVehiclePos
#else
    #define _ALS_SetVehiclePos
#endif
#define SetVehiclePos avt_SetVehiclePos

stock avt_SetVehicleZAngle(vehicleid, &Float:z_angle)
{	
	VEHICLE_POSITIONS	[vehicleid]	[3]		=	z_angle;
	return SetVehicleZAngle(vehicleid, z_angle);
}
#if defined _ALS_SetVehicleZAngle
    #undef SetVehicleZAngle
#else
    #define _ALS_SetVehicleZAngle
#endif
#define SetVehicleZAngle avt_SetVehicleZAngle

stock avt_AttachTrailerToVehicle(trailerid, vehicleid)
{	
	ALLOW_UPDATE	[trailerid]		=	true;
	LAST_TRAILER	[trailerid]		=	vehicleid;
	LAST_TOWED		[vehicleid] 	=	trailerid;
	return AttachTrailerToVehicle(trailerid, vehicleid);
}
#if defined _ALS_AttachTrailerToVehicle
    #undef AttachTrailerToVehicle
#else
    #define _ALS_AttachTrailerToVehicle
#endif
#define AttachTrailerToVehicle avt_AttachTrailerToVehicle

stock avt_DetachTrailerFromVehicle(vehicleid)
{	
	LAST_TOWED		[LAST_TRAILER[vehicleid]] 	=	0;
	
	ALLOW_UPDATE	[vehicleid]		=	false;
	LAST_TRAILER	[vehicleid]		=	0;
	
	SaveVehiclePosition(vehicleid);
	
	return DetachTrailerFromVehicle(vehicleid);
}
#if defined _ALS_DetachTrailerFromVehicle
    #undef DetachTrailerFromVehicle
#else
    #define _ALS_DetachTrailerFromVehicle
#endif
#define DetachTrailerFromVehicle avt_DetachTrailerFromVehicle

hook SetVehicleToRespawn(vehicleid)
{	
	SetVehicleToRespawn(vehicleid);
	
	ALLOW_UPDATE	[vehicleid]		=	false;
	LAST_TRAILER	[vehicleid]		=	0;
	
	SaveVehiclePosition(vehicleid);
	return 1;
}

hook PutPlayerInVehicle(playerid, vehicleid, seatid)
{	
	SaveVehiclePosition(vehicleid);
						
	FORCED_VEHICLE		[playerid]	=	vehicleid;
	LAST_VEHICLE		[playerid]	=	vehicleid;
	return vehicleid;
}

hook RemovePlayerFromVehicle(playerid)
{	
	SaveVehiclePosition(	LAST_VEHICLE[playerid]		);
						
	FORCED_VEHICLE		[playerid]	=	0;
	
	return LAST_VEHICLE[playerid];
}

stock SaveVehiclePosition(vehicleid)
{
	GetVehiclePos		(
							vehicleid,
							VEHICLE_POSITIONS	[vehicleid]	[0],
							VEHICLE_POSITIONS	[vehicleid]	[1],
							VEHICLE_POSITIONS	[vehicleid]	[2]
						);
	GetVehicleZAngle	(
							vehicleid,
							VEHICLE_POSITIONS	[vehicleid]	[3]
						);
	return 1;
}

stock SetVehicleOriginalPos(vehicleid)
{
	SetVehiclePos(
		vehicleid,
		VEHICLE_POSITIONS	[vehicleid]	[0],
		VEHICLE_POSITIONS	[vehicleid]	[1],
		VEHICLE_POSITIONS	[vehicleid]	[2]);
				
	SetVehicleZAngle(
		vehicleid,
		VEHICLE_POSITIONS	[vehicleid]	[3]);
		
	return 1;
}