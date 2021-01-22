/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//BUST AIM
//
//BustAim is a feature rich anti-aimbot include which tries to detect players who are using aimbots. BustAim is designed to
//trigger warnings and provide administrators with vital information about the suspected player. It by itself cannot do much
//and requires human intelligence to confirm if the player is using an aimbot.
//License:Public Domain
//
//Credits:
//Yashas
//RedShirt & niCe & JernejL for camera/aiming functions
//ipsLeon & Kyance for their aimbot detectors
//Pottus for constructive criticism
//Slice for the information regarding Maximum Weapon Firing Range
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Callbacks:
//	OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
//
//Stocks:
//	native BustAim::GetPlayerWeaponProfile(playerid,weaponid,&allshots,&hitshots,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns);
//	native BustAim::ResetPlayerWeaponProfile(playerid,weaponid);
//	native BustAim::GetPlayerProfile(playerid,&shotsfired,&shotshit,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns);
//	native BustAim::ResetPlayerProfile(playerid);
//	native BustAim::SetPlayerFlags(playerid,flags);
//	native BustAim::GetPlayerFlags(playerid,&flags);
//	native BustAim::ResetPlayerFlags(playerid);
//	native BustAim::GetTeleportStats(playerid,Float:arr[],sz = sizeof(arr));
//	native BustAim::GetAimStats(playerid,Float:arr[],sz = sizeof(arr))
//	native BustAim::GetRangeStats(playerid,Float:arr[],sz = sizeof(arr))
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if defined _INCLUDE_BUSTAIM_
	#endinput
#endif
#define _INCLUDE_BUSTAIM_
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define BustAim:: BS_

#if !defined BUSTAIM_MAX_PL_PERCENTAGE
	#define BUSTAIM_MAX_PL_PERCENTAGE 5
#endif
#if !defined BUSTAIM_MAX_PING
	#define BUSTAIM_MAX_PING 600
#endif
#if !defined BUSTAIM_SKIP_WEAPON_IDS
	#define BUSTAIM_SKIP_WEAPON_IDS 38
#endif
#if !defined BUSTAIM_MAX_CONTINOUS_SHOTS
	#define BUSTAIM_MAX_CONTINOUS_SHOTS 10
#endif
#if !defined BUSTAIM_PROAIM_TELEPORT_PROBES
	#define BUSTAIM_PROAIM_TELEPORT_PROBES 3
#endif
#if !defined BUSTAIM_OUT_OF_RANGE_PROBES
	#define BUSTAIM_OUT_OF_RANGE_PROBES 2
#endif
#if !defined BUSTAIM_RANDOM_AIM_PROBES
	#define BUSTAIM_RANDOM_AIM_PROBES 5
#endif
#if !defined MIN_DIST_FOR_AIM_CHECKS
	#define MIN_DIST_FOR_AIM_CHECKS 10
#endif
#if !defined MAX_B2V_DEVIATION
	#define MAX_B2V_DEVIATION 15
#endif
#if !defined BUSTAIM_PLAYER_SPHERE_RADIUS
	#define BUSTAIM_PLAYER_SPHERE_RADIUS 3
#endif
#if !defined BUSTAIM_DEFAULT_PLAYER_FLAGS
	#define BUSTAIM_DEFAULT_PLAYER_FLAGS (CHECK_FOR_OUT_OF_RANGE_SHOTS	|	CHECK_FOR_PROAIM_TELEPORT	|	CHECK_FOR_RANDOM_AIM_SHOTS	| 	CHECK_FOR_CONTINOUS_SHOTS)
#endif
#if !defined BUSTAIM_WSTATS_SHOTS
	#define BUSTAIM_WSTATS_SHOTS 3
#endif

//DO NOT CHANGE THIS
#define BS_TOTAL_SHOOTING_WEAPONS 17 //includes RPG,HS,FT
#if BS_TOTAL_SHOOTING_WEAPONS != 17
	#error BS_TOTAL_SHOOTING_WEAPONS should always be set to 17
#endif

#define BS_GetNormalWeaponRange(weaponid) BustAim_g_WeaponRangeOriginal[weaponid-22]
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
forward OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum (<<=1)
{
	WARNING_OUT_OF_RANGE_SHOT=1,
	WARNING_PROAIM_TELEPORT,
	WARNING_RANDOM_AIM,
	WARNING_CONTINOUS_SHOTS
}
enum (<<=1)
{
	PREVIOUS_SHOT_DID_DAMAGE=1,
}
enum (<<=1)
{
	CHECK_FOR_OUT_OF_RANGE_SHOTS=1,
	CHECK_FOR_PROAIM_TELEPORT,
	CHECK_FOR_RANDOM_AIM_SHOTS,
	CHECK_FOR_CONTINOUS_SHOTS,
	IGNORE_PLAYER
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Modified Slice's Max Weapon Ranges from Weapon Config Include (Added 10 units extra for every weapon to make allowance for lagging players)
static const Float:BustAim_g_WeaponRange[] =
{
	45.0, // 22 - Colt 45
	45.0, // 23 - Silenced
	45.0, // 24 - Deagle
	50.0, // 25 - Shotgun
	45.0, // 26 - Sawed-off
	50.0, // 27 - Spas
	45.0, // 28 - UZI
	55.0, // 29 - MP5
	100.0, // 30 - AK47
	120.0, // 31 - M4
	45.0, // 32 - Tec9
	110.0, // 33 - Cuntgun
	320.0, // 34 - Sniper
	0.0, // 35 - Rocket launcher
	0.0, // 36 - Heatseeker
	0.0, // 37 - Flamethrower
	85.0  // 38 - Minigun
};
//Original Slice's Max Weapon Ranges'
stock const Float:BustAim_g_WeaponRangeOriginal[] =
{
	35.0, // 22 - Colt 45
	35.0, // 23 - Silenced
	35.0, // 24 - Deagle
	40.0, // 25 - Shotgun
	35.0, // 26 - Sawed-off
	40.0, // 27 - Spas
	35.0, // 28 - UZI
	45.0, // 29 - MP5
	70.0, // 30 - AK47
	90.0, // 31 - M4
	35.0, // 32 - Tec9
	100.0, // 33 - Cuntgun
	320.0, // 34 - Sniper
	0.0, // 35 - Rocket launcher
	0.0, // 36 - Heatseeker
	0.0, // 37 - Flamethrower
	75.0  // 38 - Minigun
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static BustAim_g_PlayerSettings[MAX_PLAYERS char];
static BustAim_g_PlayerPrevWeapon[MAX_PLAYERS char];

static BustAim_g_IntrnlPlayerSettings[MAX_PLAYERS char];

static BustAim_g_ContinousShots[MAX_PLAYERS char];
static BustAim_g_RandomAimShots[MAX_PLAYERS char];
static BustAim_g_TeleportShots[MAX_PLAYERS char];
static BustAim_g_OutOfRangeShots[MAX_PLAYERS char];

#if !defined BUSTAIM_DISABLE_PROFILING
static BustAim_g_TotalRandomAimWarns[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
static BustAim_g_TotalTeleportWarns[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
static BustAim_g_TotalOutOfRangeWarns[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
static BustAim_g_MaxContinousShots[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
static BustAim_g_ShotsFired[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
static BustAim_g_ShotsHit[MAX_PLAYERS][BS_TOTAL_SHOOTING_WEAPONS];
#endif

#if !defined BUSTAIM_DISABLE_WSTATS
static Float:BustAim_g_TeleportWarningStats[MAX_PLAYERS][BUSTAIM_WSTATS_SHOTS];
static Float:BustAim_g_AimWarningStats[MAX_PLAYERS][BUSTAIM_WSTATS_SHOTS];
static Float:BustAim_g_RangeWarningStats[MAX_PLAYERS][BUSTAIM_WSTATS_SHOTS];
static Float:BustAim_g_DCTTL_temp;
#endif

#if !defined BUSTAIM_IS_PAUSED_FUNCTION
static BustAim_g_LastUpdateTick[MAX_PLAYERS];
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static Float:internal_BS_DCTTL(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
	static Float:TGTDistance,Float:tmpX, Float:tmpY, Float:tmpZ;
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}
static Float:internal_BS_GPATP(Float:x2, Float:y2, Float:X, Float:Y)
{
	static Float:DX, Float:DY,Float:angle;

	DX = floatabs(floatsub(x2,X));
	DY = floatabs(floatsub(y2,Y));

	if(DY == 0.0 || DX == 0.0)
	{
		if(DY == 0 && DX > 0) angle = 0.0;
		else if(DY == 0 && DX < 0) angle = 180.0;
		else if(DY > 0 && DX == 0) angle = 90.0;
		else if(DY < 0 && DX == 0) angle = 270.0;
		else if(DY == 0 && DX == 0) angle = 0.0;
	}
	else
	{
		angle = atan(DX/DY);

		if(X > x2 && Y <= y2) angle += 90.0;
		else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
		else if(X < x2 && Y >= y2) angle -= 90.0;
		else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
	}
	return floatadd(angle, 90.0);
}
static internal_BS_GXYIFOP(&Float:x, &Float:y, Float:angle, Float:distance)
{
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}
static internal_BS_IsCameraAimingAt(weaponid,Float:x, Float:y, Float:z,Float:vector_x,Float:vector_y,Float:vector_z,Float:camera_x,Float:camera_y,Float:camera_z,Float:radius)
{
	static Float:vertical, Float:horizontal;
	switch (weaponid)
	{
		case 34,35,36:
		{
			if(internal_BS_DCTTL(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
			return false;
		}
		case 30,31: {vertical = 4.0; horizontal = -1.6;}
		case 33: {vertical = 2.7; horizontal = -1.0;}
		default: {vertical = 6.0; horizontal = -2.2;}
	}
	new Float:angle = internal_BS_GPATP(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);

	internal_BS_GXYIFOP(resize_x, resize_y, internal_BS_GPATP(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));
	#if !defined BUSTAIM_DISABLE_WSTATS
		if((BustAim_g_DCTTL_temp = internal_BS_DCTTL(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z)) < radius) return true;
	#else
		if(internal_BS_DCTTL(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
	#endif
	return false;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	static Float:pX,Float:pY,Float:pZ,Float:hX,Float:hY,Float:hZ,Float:cX,Float:cY,Float:cZ;
	if(!(21 < weaponid < 35 || weaponid == 38) || !(-1 < hittype < 5))
		#if defined BustAim_OnPlayerWeaponShot
			return BustAim_OnPlayerWeaponShot( playerid, weaponid, hittype, hitid, fX, fY, fZ);
		#else
			return 0;
		#endif

	if(hittype == BULLET_HIT_TYPE_NONE)
	{
		if(floatabs(fX) > 20000.0 || floatabs(fY) > 20000.0 || floatabs(fZ) > 20000.0)
		{
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
			#else
				return 0;
			#endif
		}
	} 
	else
	{
		if(floatabs(fX) > 1500.0 || floatabs(fY) > 1500.0 || floatabs(fZ) > 1500.0)
		{
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
			#else
				return 0;
			#endif
		}
	}

	#if !defined BUSTAIM_DISABLE_PROFILING
	BustAim_g_ShotsFired[playerid][weaponid-22]++;
	#endif

	if(hittype == BULLET_HIT_TYPE_PLAYER)
	{
		#if !defined BUSTAIM_DISABLE_PROFILING
			BustAim_g_ShotsHit[playerid][weaponid-22]++;
		#endif

		if(BustAim_g_PlayerSettings{playerid} & IGNORE_PLAYER)
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		if(BustAim_g_PlayerPrevWeapon{playerid} != weaponid)
		{
			BustAim_g_ContinousShots{playerid} =
			BustAim_g_RandomAimShots{playerid} =
			BustAim_g_TeleportShots{playerid} =
			BustAim_g_OutOfRangeShots{playerid} = 0;

			BustAim_g_PlayerPrevWeapon{playerid} = weaponid;
		}

		if(IsPlayerNPC(hitid))
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		#if defined BUSTAIM_IS_PAUSED_FUNCTION
			if(BUSTAIM_IS_PAUSED_FUNCTION(hitid))
			#if defined BustAim_OnPlayerWeaponShot
 				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif
		#else
			if((GetTickCount() - BustAim_g_LastUpdateTick[hitid]) > 1000)
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif
		#endif

		if(NetStats_PacketLossPercent(playerid) > BUSTAIM_MAX_PL_PERCENTAGE || NetStats_PacketLossPercent(hitid) > BUSTAIM_MAX_PL_PERCENTAGE)
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		if(GetPlayerPing(playerid) > BUSTAIM_MAX_PING || GetPlayerPing(hitid) > BUSTAIM_MAX_PING)
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		if(IsPlayerInAnyVehicle(playerid) || IsPlayerInAnyVehicle(hitid))
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		if(GetPlayerSurfingVehicleID(playerid) != INVALID_VEHICLE_ID || GetPlayerSurfingVehicleID(hitid) != INVALID_VEHICLE_ID)
			#if defined BustAim_OnPlayerWeaponShot
				return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
			#else
				return 1;
			#endif

		switch(weaponid)
		{
			case BUSTAIM_SKIP_WEAPON_IDS:
			{
				#if defined BustAim_OnPlayerWeaponShot
					return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
				#else
					return 1;
				#endif
			}
		}

		new warning = 0;

		GetPlayerVelocity(hitid,pX,pY,pZ);

		if(BustAim_g_PlayerSettings{playerid} & CHECK_FOR_CONTINOUS_SHOTS)
			if((pX*pX + pY*pY + pZ*pZ) > 0.01)
				if(!(++BustAim_g_ContinousShots{playerid} % BUSTAIM_MAX_CONTINOUS_SHOTS))
					warning |= WARNING_CONTINOUS_SHOTS;

		GetPlayerPos(hitid,hX,hY,hZ);
		GetPlayerLastShotVectors(playerid,pX,pY,pZ,cX,cY,cZ);

		new Float:S2V_dist = VectorSize(pX-hX,pY-hY,pZ-hZ); //Approximate Shooter to Victim Distance

		if(BustAim_g_PlayerSettings{playerid} & CHECK_FOR_OUT_OF_RANGE_SHOTS)
		{
			if(S2V_dist > BustAim_g_WeaponRange[weaponid-22])
			{
				#if !defined BUSTAIM_DISABLE_WSTATS
					BustAim_g_RangeWarningStats[playerid][BustAim_g_OutOfRangeShots{playerid}%BUSTAIM_WSTATS_SHOTS] = S2V_dist;
				#endif
				if(BustAim_g_IntrnlPlayerSettings{playerid} & PREVIOUS_SHOT_DID_DAMAGE)
				{
					if(++BustAim_g_OutOfRangeShots{playerid} > BUSTAIM_OUT_OF_RANGE_PROBES)
					{
						BustAim_g_OutOfRangeShots{playerid} = 0;
						#if !defined BUSTAIM_DISABLE_PROFILING
							BustAim_g_TotalOutOfRangeWarns[playerid][weaponid-22]++;
						#endif
						warning |= WARNING_OUT_OF_RANGE_SHOT;
					}
					BustAim_g_IntrnlPlayerSettings{playerid} &= ~PREVIOUS_SHOT_DID_DAMAGE;
				}
			}
		}

		if(BustAim_g_PlayerSettings{playerid} & CHECK_FOR_PROAIM_TELEPORT)
			if(VectorSize(cX-hX,cY-hY,cZ-hZ) > MAX_B2V_DEVIATION)
			{
				#if !defined BUSTAIM_DISABLE_WSTATS
					BustAim_g_TeleportWarningStats[playerid][BustAim_g_TeleportShots{playerid}%BUSTAIM_WSTATS_SHOTS] = VectorSize(cX-hX,cY-hY,cZ-hZ);
				#endif
				if(++BustAim_g_TeleportShots{playerid} > BUSTAIM_PROAIM_TELEPORT_PROBES)
				{
					BustAim_g_TeleportShots{playerid} = 0;
					#if !defined BUSTAIM_DISABLE_PROFILING
						BustAim_g_TotalTeleportWarns[playerid][weaponid-22]++;
					#endif
					warning |= WARNING_PROAIM_TELEPORT;
				}
			}

		if(BustAim_g_PlayerSettings{playerid} & CHECK_FOR_RANDOM_AIM_SHOTS)
			if(S2V_dist > MIN_DIST_FOR_AIM_CHECKS)
			{
				GetPlayerCameraFrontVector(playerid,pX,pY,pZ);
				GetPlayerCameraPos(playerid,cX,cY,cZ);
				if(!internal_BS_IsCameraAimingAt(weaponid,hX,hY,hZ,pX,pY,pZ,cX,cY,cZ,BUSTAIM_PLAYER_SPHERE_RADIUS))
				{
					#if !defined BUSTAIM_DISABLE_WSTATS
						BustAim_g_AimWarningStats[playerid][BustAim_g_RandomAimShots{playerid}%BUSTAIM_WSTATS_SHOTS] = BustAim_g_DCTTL_temp;
					#endif
					if(++BustAim_g_RandomAimShots{playerid} > BUSTAIM_RANDOM_AIM_PROBES)
					{
						BustAim_g_RandomAimShots{playerid} = 0;
						#if !defined BUSTAIM_DISABLE_PROFILING
							BustAim_g_TotalRandomAimWarns[playerid][weaponid-22]++;
						#endif
						warning |= WARNING_RANDOM_AIM;
					}
				}
			}
		if(warning)
			#if defined OnPlayerSuspectedForAimbot
				if(OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warning)) BustAim_g_PlayerSettings{playerid} |= IGNORE_PLAYER;
			#endif
	}
	else
	{
		#if !defined BUSTAIM_DISABLE_PROFILING
			if(BustAim_g_ContinousShots{playerid} > BustAim_g_MaxContinousShots[playerid][weaponid-22])
				BustAim_g_MaxContinousShots[playerid][weaponid-22] = BustAim_g_ContinousShots{playerid};
		#endif
		BustAim_g_ContinousShots{playerid} =
		BustAim_g_RandomAimShots{playerid} =
		BustAim_g_TeleportShots{playerid} =
		BustAim_g_OutOfRangeShots{playerid} = 0;
	}
	#if defined BustAim_OnPlayerWeaponShot
		return BustAim_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
	#else
		return 1;
	#endif
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if((0 <= damagedid < MAX_PLAYERS) && (0 <= weaponid < 50)) BustAim_g_IntrnlPlayerSettings{playerid} |= PREVIOUS_SHOT_DID_DAMAGE;
	#if defined BustAim_OnPlayerGiveDamage
		return BustAim_OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerWeaponShot
#undef OnPlayerWeaponShot
#else
#define _ALS_OnPlayerWeaponShot
#endif

#define OnPlayerWeaponShot BustAim_OnPlayerWeaponShot

#if defined BustAim_OnPlayerWeaponShot
	forward BustAim_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif

#if defined _ALS_OnPlayerGiveDamage
#undef OnPlayerGiveDamage
#else
#define _ALS_OnPlayerGiveDamage
#endif

#define OnPlayerGiveDamage BustAim_OnPlayerGiveDamage

#if defined BustAim_OnPlayerGiveDamage
	forward BustAim_OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart);
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if defined BUSTAIM_DISABLE_WSTATS
stock BustAim::GetTeleportStats(playerid,Float:arr[],sz = sizeof(arr))
{
	#pragma unused playerid
	#pragma unused arr
	#pragma unused sz
	print("[BUST-AIM] GetTeleportStats must not be used when WSTATS is disabled.");
}
stock BustAim::GetRandomAimStats(playerid,Float:arr[],sz = sizeof(arr))
{
	#pragma unused playerid
	#pragma unused arr
	#pragma unused sz
	print("[BUST-AIM] GetAimStats must not be used when WSTATS is disabled.");
}
stock BustAim::GetRangeStats(playerid,Float:arr[],sz = sizeof(arr))
{
	#pragma unused playerid
	#pragma unused arr
	#pragma unused sz
	print("[BUST-AIM] GetRangeStats must not be used when WSTATS is disabled.");
}
#else
stock BustAim::GetTeleportStats(playerid,Float:arr[],sz = sizeof(arr))
{
	memcpy(_:arr,_:BustAim_g_TeleportWarningStats[playerid],0,sz*4,sz);
}
stock BustAim::GetRandomAimStats(playerid,Float:arr[],sz = sizeof(arr))
{
	memcpy(_:arr,_:BustAim_g_AimWarningStats[playerid],0,sz*4,sz);
}
stock BustAim::GetRangeStats(playerid,Float:arr[],sz = sizeof(arr))
{
	memcpy(_:arr,_:BustAim_g_RangeWarningStats[playerid],0,sz*4,sz);
}
#endif

#if defined BUSTAIM_DISABLE_PROFILING
stock BustAim::GetPlayerWeaponProfile(playerid,weaponid,&allshots,&hitshots,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns)
{
	#pragma unused playerid
	#pragma unused weaponid
	print("[BUST-AIM] GetPlayerWeaponProfile must not be used when profiling is disabled.");
}
stock BustAim::ResetPlayerWeaponProfile(playerid,weaponid)
{
	#pragma unused playerid
	#pragma unused weaponid
	print("[BUST-AIM] ResetWeaponProfile must not be used when profiling is disabled");
}
stock BustAim::GetPlayerProfile(playerid,&shotsfired,&shotshit,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns)
{
	#pragma unused playerid
	print("[BUST-AIM] GetPlayerProfile must not be used when profiling is disabled.");
}
stock BustAim::ResetPlayerProfile(playerid)
{
	#pragma unused playerid
	print("[BUST-AIM] ResetPlayerProfile must not be used when profiling is disabled.");
}
#else
stock BustAim::GetPlayerWeaponProfile(playerid,weaponid,&allshots,&hitshots,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns)
{
	if(22 <= weaponid <= 39)
	{
		weaponid -= 22;
		allshots = BustAim_g_ShotsFired[playerid][weaponid];
		hitshots = BustAim_g_ShotsHit[playerid][weaponid];
		max_cont_shots = BustAim_g_MaxContinousShots[playerid][weaponid];
		out_of_range_warns = BustAim_g_TotalOutOfRangeWarns[playerid][weaponid];
		random_aim_warns = BustAim_g_TotalRandomAimWarns[playerid][weaponid];
		proaim_tele_warns = BustAim_g_TotalTeleportWarns[playerid][weaponid];
		return 0;
	}
	return 1;
}
stock BustAim::ResetPlayerWeaponProfile(playerid,weaponid)
{
	if(22 <= weaponid <= 39)
	{
		weaponid -= 22;
		BustAim_g_ShotsFired[playerid][weaponid] =
		BustAim_g_ShotsHit[playerid][weaponid] =
		BustAim_g_MaxContinousShots[playerid][weaponid] =
		BustAim_g_TotalOutOfRangeWarns[playerid][weaponid] =
		BustAim_g_TotalRandomAimWarns[playerid][weaponid] =
		BustAim_g_TotalTeleportWarns[playerid][weaponid] = 0;
		return 0;
	}
	return 1;
}
stock BustAim::GetPlayerProfile(playerid,&shotsfired,&shotshit,&max_cont_shots,&out_of_range_warns,&random_aim_warns,&proaim_tele_warns)
{
	for(new i = 0;i < BS_TOTAL_SHOOTING_WEAPONS;i++)
	{
		shotsfired += BustAim_g_ShotsFired[playerid][i];
		shotshit += BustAim_g_ShotsHit[playerid][i];
		out_of_range_warns += BustAim_g_TotalOutOfRangeWarns[playerid][i];
		random_aim_warns += BustAim_g_TotalRandomAimWarns[playerid][i];
		proaim_tele_warns+= BustAim_g_TotalTeleportWarns[playerid][i];
		if(BustAim_g_MaxContinousShots[playerid][i] > max_cont_shots)
			max_cont_shots = BustAim_g_MaxContinousShots[playerid][i];
	}
	return 1;
}
stock BustAim::ResetPlayerProfile(playerid)
{
	Fill68(BustAim_g_TotalRandomAimWarns[playerid]);
	Fill68(BustAim_g_TotalTeleportWarns[playerid]);
	Fill68(BustAim_g_TotalOutOfRangeWarns[playerid]);
	Fill68(BustAim_g_ShotsFired[playerid]);
	Fill68(BustAim_g_ShotsHit[playerid]);
	Fill68(BustAim_g_MaxContinousShots[playerid]);
	return 0;
}
#endif
stock BustAim::SetPlayerFlags(playerid,flags)
{
	BustAim_g_PlayerSettings{playerid} = flags;
}
stock BustAim::GetPlayerFlags(playerid,&flags)
{
	flags = BustAim_g_PlayerSettings{playerid};
}
stock BustAim::ResetPlayerFlags(playerid)
{
	BustAim_g_PlayerSettings{playerid} = BUSTAIM_DEFAULT_PLAYER_FLAGS;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static stock Fill68(loc[])
{
	new val = 0;
	#emit LOAD.S.alt loc
	#emit LOAD.S.pri val
	#emit FILL 68
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnPlayerConnect(playerid)
{
	BustAim_g_PlayerSettings{playerid} = BUSTAIM_DEFAULT_PLAYER_FLAGS;
	BustAim_g_IntrnlPlayerSettings{playerid} =
	BustAim_g_ContinousShots{playerid} =
	BustAim_g_RandomAimShots{playerid} =
	BustAim_g_TeleportShots{playerid} =
	BustAim_g_OutOfRangeShots{playerid} = 0;
	#if !defined BUSTAIM_DISABLE_PROFILING
		Fill68(BustAim_g_TotalRandomAimWarns[playerid]);
		Fill68(BustAim_g_TotalTeleportWarns[playerid]);
		Fill68(BustAim_g_TotalOutOfRangeWarns[playerid]);
		Fill68(BustAim_g_ShotsFired[playerid]);
		Fill68(BustAim_g_ShotsHit[playerid]);
		Fill68(BustAim_g_MaxContinousShots[playerid]);
	#endif

	#if defined BustAim_OnPlayerConnect
		return BustAim_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect BustAim_OnPlayerConnect

#if defined BustAim_OnPlayerConnect
	forward BustAim_OnPlayerConnect(playerid);
#endif

#if !defined BUSTAIM_IS_PAUSED_FUNCTION
	public OnPlayerUpdate(playerid)
	{
		BustAim_g_LastUpdateTick[playerid] = GetTickCount();

		#if defined BustAim_OnPlayerUpdate
			return BustAim_OnPlayerUpdate(playerid);
		#else
			return 1;
		#endif
	}
	#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
	#else
	#define _ALS_OnPlayerUpdate
	#endif

	#define OnPlayerUpdate BustAim_OnPlayerUpdate

	#if defined BustAim_OnPlayerUpdate
		forward BustAim_OnPlayerUpdate(playerid);
	#endif
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

