// New SA-MP callbacks by Emmet
// Created on Sunday, January 26, 2014 at 11:58 AM.

#include <a_samp>

#if !defined POTENTIAL_CRASH_DAMAGE
	#define POTENTIAL_CRASH_DAMAGE (55.0)
#endif

#if !defined POTENTIAL_SPEED_DROP
	#define POTENTIAL_SPEED_DROP (5.0)
#endif

#if !defined MAX_FORMAT_BUFFER
        #define MAX_FORMAT_BUFFER       (2048)
#endif
 
#define Packed:%0[%1] \
        %0[%1 char] = !" "

enum e_CB_DATA {
	e_CB_TIME,
	e_CB_TIMER,
	e_CB_PRESSES,
	e_CB_LAST,
 	e_CB_VEND,
  	e_CB_FPS,
  	e_CB_DRUNK,
  	e_CB_TARGET,
  	e_CB_SELECT,
	Float:e_CB_HEALTH,
	Float:e_CB_PACKET,
	Float:e_CB_POS[3]
};

enum e_CB_FLAGS (<<= 1) {
	e_CB_INIT = 1,
	e_CB_UPDATE,
	e_CB_PAUSED,
	e_CB_HOLDING
};

enum e_CB_INFO (<<= 1) {
 	e_CB_OPP = 1,
	e_CB_OPR,
	e_CB_OPHK,
	e_CB_OPRK,
	e_CB_OPF,
	e_CB_OPPL,
	e_CB_OPUV,
	e_CB_OPCV,
	e_CB_OPFC,
	e_CB_OPCJ,
	e_CB_OPWE,
	e_CB_OPFF,
	e_CB_OPTP,
	e_CB_OPDC
};

static
    e_CB_INFO: g_CallbackInfo,
    e_CB_FLAGS: g_aCallbackFlags[MAX_PLAYERS],
	g_eCallbackData[MAX_PLAYERS][e_CB_DATA],
 	g_aVehicleDamage[MAX_VEHICLES][3 char]
;

static
	g_aLastVehicle[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...},
	Float:g_aVehicleHealth[MAX_VEHICLES],
	Float:g_aVehicleSpeed[MAX_VEHICLES];
	
static
        g_sFormatBuffer[MAX_FORMAT_BUFFER],
        g_sPrintBuffer[MAX_FORMAT_BUFFER],
        g_iFormatArgs = 12
;
 
static const
        g_cBufferSize = MAX_FORMAT_BUFFER
;

static const Float:g_aVendingMachines[][] =
{
    {2480.9548, -1958.5217, 13.5830}, {2325.9185, -1645.9553, 14.8270},
    {2352.9932, -1357.1597, 24.3984}, {2153.8535, -1015.7230, 62.8835},
    {2140.2710, -1161.4998, 23.9922}, {2224.4141, -1153.4441, 1025.7969},
    {2060.1152, -1898.4554, 13.5538}, {1634.0741, -2238.2815, 13.5078},
    {1729.7947, -1943.8628, 13.5687}, {-16.1516, -90.8512, 1003.5469},
    {-17.5205, -90.9663, 1003.5469}, {1929.5516, -1772.4803, 13.5469},
    {496.0115, -23.5306, 1000.6797}, {500.6090, -2.1074, 1000.6797},
    {501.7604, -2.2185, 1000.6797}, {-19.1310, -57.0453, 1003.5469},
    {-36.1302, -57.1351, 1003.5469}, {1153.9125, -1460.9729, 15.7969},
    {1788.3973, -1369.2472, 15.7578}, {2575.7300, -1284.6108, 1060.9844},
    {662.4797, -551.4141, 16.3359}, {200.2021, -107.5868, 1.5513},
    {1278.5977, 372.2211, 19.5547}, {2271.7053, -77.2283, 26.5810},
    {-2119.4229, -422.2747, 35.5313}, {-2119.7649, -423.4770, 35.5313},
    {-2068.6082, -397.5225, 35.5313}, {-2039.8768, -397.5218, 35.5313},
    {-2011.1292, -397.5222, 35.5313}, {-2005.6145, -490.8686, 35.5313},
    {-2034.4011, -490.8754, 35.5313}, {-2063.2300, -490.8705, 35.5313},
    {-2092.0771, -490.8697, 35.5313}, {-2229.1521, 287.1645, 35.3203},
    {-1981.6025, 142.6991, 27.6875}, {-1349.2971, 492.2820, 11.1953},
    {-1349.3674, 493.9295, 11.1953}, {-2419.5833, 984.5712, 45.2969},
    {-2419.5457, 986.0020, 45.2969}, {-1455.0173, 2592.4175, 55.8359},
    {-252.9913, 2599.6885, 62.8582}, {-252.9274, 2597.8921, 62.8582},
    {-862.7581, 1537.4230, 22.5870}, {-75.2812, 1227.9269, 19.7359},
    {-14.7254, 1176.1750, 19.5634}, {1398.8198, 2223.3601, 11.0234},
    {1659.4318, 1722.0974, 10.8281}, {1519.3350, 1055.2886, 10.8203},
    {2503.1318, 1244.5094, 10.8203}, {2647.7424, 1128.9138, 11.1797},
    {2845.7429, 1294.2975, 11.3906}, {2320.0618, 2532.0364, 10.8203},
    {2086.5894, 2071.4111, 11.0579}, {-32.5264, -185.9041, 1003.5469},
    {-33.8699, -186.0213, 1003.5469}, {361.6433, 159.3575, 1008.3828},
    {374.7823, 188.2360, 1008.3893}, {351.6473, 206.1147, 1008.3828},
    {371.6005, 177.7106, 1019.9844}, {373.8686, -178.9308, 1000.6328},
    {378.2982, -178.9220, 1000.6328}, {315.9102, -140.5504, 999.6016}
};

forward OnPlayerPause(playerid);
forward OnPlayerUseVending(playerid);
forward OnPlayerResume(playerid, time);
forward OnPlayerHoldingKey(playerid, keys);
forward OnPlayerReleaseKey(playerid, keys, time);
forward OnPlayerFall(playerid, Float:height, Float:damage);
forward OnPlayerPacketLoss(playerid, Float:oldloss, Float:newloss);
forward OnPlayerCrashVehicle(playerid, vehicleid, Float:damage);
forward OnPlayerFPSChange(playerid, oldfps, newfps);
forward OnPlayerCarJack(playerid, targetid, vehicleid);
forward OnPlayerWeaponEmpty(playerid, weaponid);
forward OnPlayerFriendlyFire(playerid, targetid, weaponid);
forward OnPlayerTargetPlayer(playerid, targetid, weaponid);
forward OnPlayerDisableCursor(playerid);
forward @_psf_sysreq_(); @_psf_sysreq_() {
        static
            str[2]
        ;
        format(str, 2, "");
        strunpack(str, !"");
        ispacked(str);
        strlen(str);
}
 

stock IsPlayerNearVending(playerid)
{
    for (new i = 0; i < sizeof(g_aVendingMachines); i ++) if(IsPlayerInRangeOfPoint(playerid, 3.0, g_aVendingMachines[i][0], g_aVendingMachines[i][1], g_aVendingMachines[i][2]))
		return 1;

	return 0;
}

stock IsPlayerPaused(playerid)
{
	return (g_aCallbackFlags[playerid] & e_CB_PAUSED);
}

stock GetPlayerFPS(playerid)
{
	return (g_eCallbackData[playerid][e_CB_FPS]);
}

stock GetPlayerPausedTime(playerid)
{
	if(IsPlayerPaused(playerid))
	    return (g_eCallbackData[playerid][e_CB_TIME]);

	return 0;
}

stock CB_SelectTextDraw(playerid, hovercolor)
{
	g_eCallbackData[playerid][e_CB_SELECT] = 1;
	
	return SelectTextDraw(playerid, hovercolor);
}

stock CB_CancelSelectTextDraw(playerid)
{
	g_eCallbackData[playerid][e_CB_SELECT] = 0;

	return CancelSelectTextDraw(playerid);
}

stock CB_GetVehicleDriver(vehicleid)
{
	for (new i = 0, l = GetMaxPlayers(); i != l; i ++)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid)
		    return i;
	}
	return INVALID_PLAYER_ID;
}

stock static Float:CB_GetVehicleSpeed(vehicleid)
{
	static
	    Float:x,
	    Float:y,
	    Float:z,
		Float:speed;

	GetVehicleVelocity(vehicleid, x, y, z);
	speed = floatsqroot((x * x) + (y * y) + (z * z)) * 100;

	return speed;
}

stock static CB_GetCallbackData()
{
	enum g_eCallbackEnum
	{
	    g_eCallbackName[32 char],
	    e_CB_INFO: g_eCallbackFlag
	};
	static const g_aCallbackNames[][g_eCallbackEnum] =
	{
	    {!"OnPlayerPause", e_CB_OPP},
		{!"OnPlayerResume", e_CB_OPR},
		{!"OnPlayerHoldingKey", e_CB_OPHK},
		{!"OnPlayerReleaseKey", e_CB_OPRK},
		{!"OnPlayerFall", e_CB_OPF},
		{!"OnPlayerPacketLoss", e_CB_OPPL},
		{!"OnPlayerUseVending", e_CB_OPUV},
		{!"OnPlayerCrashVehicle", e_CB_OPCV},
		{!"OnPlayerFPSChange", e_CB_OPFC},
		{!"OnPlayerCarJack", e_CB_OPCJ},
		{!"OnPlayerWeaponEmpty", e_CB_OPWE},
		{!"OnPlayerFriendlyFire", e_CB_OPFF},
		{!"OnPlayerTargetPlayer", e_CB_OPTP},
		{!"OnPlayerDisableCursor", e_CB_OPDC}
	};
	for (new i = 0; i != sizeof(g_aCallbackNames); i ++)
	{
		if(funcidx(g_aCallbackNames[i][g_eCallbackName]) == -1)
		    continue;

		g_CallbackInfo |= g_aCallbackNames[i][g_eCallbackFlag];
	}
}

stock static IsPackedArgument(arg)
{
	// Load the value of our argument.
	#emit LOAD.S.pri arg

	// Load the previous frame, stored in address zero.
	#emit LOAD.S.alt 0

	// Data is stored in bytes, so convert "arg" to bytes.
	#emit SHL.C.pri 2

	// Add the result to get the start of the frame.
	#emit ADD

	// Adding 12 bytes will point us to the function's header.
	#emit ADD.C 12

	// Load the address relative to the data.
	#emit LOAD.I

	// Push our loaded address into "ispacked".
	#emit PUSH.pri
	#emit PUSH.C 4
	#emit SYSREQ.C ispacked

	// Return the result.
	#emit STACK 8
	#emit RETN

	return 0;
}

stock ps_format(dest[], size, const str[], {Float,_}:...)
{
	new
		pos = strlen(str),
		idx = numargs(),
		addr = 0,
		len
	;
	// Bug fix (thanks to kvann).
	if(g_sFormatBuffer[0]) {
			g_sFormatBuffer[0] = '\0';
	}
	if(idx == 3) {
		if(ispacked(str) && !ispacked(dest)) {
			strunpack(dest, str, size);
		} else if((!ispacked(str) && ispacked(dest)) || (ispacked(str) && ispacked(dest))) {
			strpack(dest, str, size);
		} else if(!ispacked(str) && !ispacked(dest)) {
			strcat((dest[0] = 0, dest), str, size);
		}
		return 0;
	}
	strunpack(g_sFormatBuffer, str);

	while (pos--) {
			if((idx > 2 && g_sFormatBuffer[pos] == '%') && g_sFormatBuffer[pos + 1] && g_sFormatBuffer[pos + 1] != '%') {
				idx--;

				if(g_sFormatBuffer[pos + 1] == 's' && IsPackedArgument(idx)) {
					// Load the address of our packed string.
					#emit LCTRL 5
					#emit ADD.C 12
					#emit LOAD.S.alt idx
					#emit SHL.C.alt 2
					#emit ADD
					#emit LOAD.I
					#emit STOR.S.pri addr

					// Get the length of the string.
					#emit PUSH.pri
					#emit PUSH.C 4
					#emit SYSREQ.C strlen
					#emit STOR.S.pri len
					#emit STACK 8

					strdel(g_sFormatBuffer, pos, pos + 2);

					while (len--) {
						static
								ch[2];
						// Read a single character from the packed string.
						#emit LOAD.S.pri addr
						#emit LOAD.S.alt len
						#emit ADD
						#emit ALIGN.pri 1
						#emit LODB.I 1
						#emit STOR.pri ch

						strins(g_sFormatBuffer, ch, pos);
					}
				}
				else {
					// Load the address relative to the parameter.
							#emit LCTRL 5
					#emit ADD.C 12
							#emit LOAD.S.alt idx
							#emit SHL.C.alt 2
							#emit ADD
							#emit LOAD.I
							#emit PUSH.pri
						   
							if(g_sFormatBuffer[pos + 2] == '*' && g_sFormatBuffer[pos + 3] == 's') {
								#emit LCTRL 5
									#emit LOAD.S.alt idx
									#emit DEC.alt
									#emit STOR.S.alt idx
									#emit SHL.C.alt 2
									#emit ADD
				#emit ADD.C 12
									#emit LOAD.I
									#emit PUSH.pri

								g_iFormatArgs = g_iFormatArgs + 8;
							}
							else g_iFormatArgs = g_iFormatArgs + 4;
					}
		}
	}
	#emit PUSH.C g_sFormatBuffer
	#emit PUSH.C g_cBufferSize
	#emit PUSH.C g_sFormatBuffer
	#emit PUSH.C g_iFormatArgs
	#emit SYSREQ.C format
	#emit STACK 16

	if(ispacked(dest)) {
		strpack(dest, g_sFormatBuffer, size);
	} else {
		strcat((dest[0] = 0, dest), g_sFormatBuffer, size);
	}
	g_iFormatArgs = 12;

	#emit LCTRL 5
	#emit SCTRL 4
	#emit RETN

	return 0;
}
 
stock ps_printf(const str[], {Float,_}:...)
{
	new
		args = numargs();

	// Bug fix (thanks to kvann).
	if(g_sPrintBuffer[0]) {
			g_sPrintBuffer[0] = '\0';
	}
   
	while (--args > 0) {
		// Load the address relative to the parameter.
		#emit LCTRL 5
		#emit ADD.C 12
		#emit LOAD.S.alt args
		#emit SHL.C.alt 2
		#emit ADD
		#emit LOAD.I
		#emit PUSH.pri
	}
	// Push the other variables to the function.
	#emit PUSH.S str
	#emit PUSH.C g_cBufferSize
	#emit PUSH.C g_sPrintBuffer

	// Push the number of arguments (stored in address 8).
	#emit LOAD.S.pri 8
	#emit ADD.C 8
	#emit PUSH.pri

	// SYSREQ.C is for natives and "ps_format" is not a native.
	// Therefore, we must jump to the function manually.
	#emit LCTRL 6
	#emit ADD.C 28
	#emit PUSH.pri
	#emit CONST.pri ps_format
	#emit SCTRL 6
	#emit STACK 4

	print(g_sPrintBuffer);

	#emit LCTRL 5
	#emit SCTRL 4
	#emit RETN

	return 0;
}

public OnFilterScriptInit()
{
    CB_GetCallbackData();

	if(g_CallbackInfo & e_CB_OPP || g_CallbackInfo & e_CB_OPR)
		SetTimer("_CB_TabCheck", 600, true);

	#if defined CB_OnFilterScriptInit
	    CB_OnFilterScriptInit();
	#endif

	return 1;
}

public OnGameModeInit()
{
	CB_GetCallbackData();

	if(g_CallbackInfo & e_CB_OPP || g_CallbackInfo & e_CB_OPR)
	    SetTimer("_CB_TabCheck", 600, true);

	#if defined CB_OnGameModeInit
	    CB_OnGameModeInit();
	#endif
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new ret;

	if(!(g_CallbackInfo & e_CB_OPFF))
	    ret = 1;

	if((g_CallbackInfo & e_CB_OPFF) && (hittype == BULLET_HIT_TYPE_PLAYER && GetPlayerTeam(playerid) == GetPlayerTeam(hitid) && GetPlayerTeam(playerid) != 0 && GetPlayerTeam(playerid) != NO_TEAM))
	    ret = CallLocalFunction("OnPlayerFriendlyFire", "ddd", playerid, hitid, weaponid);

	if((g_CallbackInfo & e_CB_OPWE) && (22 <= weaponid <= 38 && GetPlayerWeaponState(playerid) == WEAPONSTATE_LAST_BULLET && GetPlayerAmmo(playerid) == 1))
  		CallLocalFunction("OnPlayerWeaponEmpty", "dd", playerid, weaponid);

	#if defined CB_OnPlayerWeaponShot
	    CB_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
	#endif
	return ret;
}

public OnPlayerUpdate(playerid)
{
 	if(g_CallbackInfo & e_CB_OPTP)
	{
	    if(g_eCallbackData[playerid][e_CB_TARGET] == 0 && GetPlayerTargetPlayer(playerid) == INVALID_PLAYER_ID)
	        g_eCallbackData[playerid][e_CB_TARGET] = INVALID_PLAYER_ID;
	
  		else if(GetPlayerTargetPlayer(playerid) != g_eCallbackData[playerid][e_CB_TARGET])
  		{
  		    g_eCallbackData[playerid][e_CB_TARGET] = GetPlayerTargetPlayer(playerid);
  		    CallLocalFunction("OnPlayerTargetPlayer", "ddd", playerid, g_eCallbackData[playerid][e_CB_TARGET], GetPlayerWeapon(playerid));
		}
	}
	if(g_CallbackInfo & e_CB_OPFC)
	{
	    static
	        level,
			amount;

	    if((level = GetPlayerDrunkLevel(playerid)) < 100)
	    {
	        SetPlayerDrunkLevel(playerid, 2000);
	    }
	    else if(g_eCallbackData[playerid][e_CB_DRUNK] != level)
	    {
	        if((amount = g_eCallbackData[playerid][e_CB_DRUNK] - level) && g_eCallbackData[playerid][e_CB_FPS] != amount) {
	        	CallLocalFunction("OnPlayerFPSChange", "ddd", playerid, g_eCallbackData[playerid][e_CB_FPS], amount);

				g_eCallbackData[playerid][e_CB_FPS] = amount;
			}
		    g_eCallbackData[playerid][e_CB_DRUNK] = level;
		}
	}
	if(g_CallbackInfo & e_CB_OPPL)
	{
		static
		    Float:packet;

		packet = NetStats_PacketLossPercent(playerid);

		if(floatcmp(packet, 0.0) != 0 && floatcmp(packet, g_eCallbackData[playerid][e_CB_PACKET]) != 0) {
		    CallLocalFunction("OnPlayerPacketLoss", "dff", playerid, g_eCallbackData[playerid][e_CB_PACKET], packet);

			g_eCallbackData[playerid][e_CB_PACKET] = packet;
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
        if(g_CallbackInfo & e_CB_OPUV)
		{
			if(IsPlayerNearVending(playerid) && GetPlayerAnimationIndex(playerid) == 1660 && (GetTickCount() - g_eCallbackData[playerid][e_CB_VEND]) > 3500) {
				CallLocalFunction("OnPlayerUseVending", "d", playerid);

				g_eCallbackData[playerid][e_CB_VEND] = GetTickCount();
			}
		}
		if(g_CallbackInfo & e_CB_OPF)
		{
	        if(!(g_aCallbackFlags[playerid] & e_CB_INIT))
			{
			    g_aCallbackFlags[playerid] |= e_CB_INIT;

			    GetPlayerHealth(playerid, g_eCallbackData[playerid][e_CB_HEALTH]);
			    GetPlayerPos(playerid, g_eCallbackData[playerid][e_CB_POS][0], g_eCallbackData[playerid][e_CB_POS][1], g_eCallbackData[playerid][e_CB_POS][2]);
			}
			else if(GetPlayerAnimationIndex(playerid) < 1130 || GetPlayerAnimationIndex(playerid) > 1132)
			{
				static
				    Float:health,
					Float:x,
					Float:y,
   					Float:z;

				GetPlayerPos(playerid, x, y, z);
				GetPlayerHealth(playerid, health);

				if(g_eCallbackData[playerid][e_CB_HEALTH] > health && g_eCallbackData[playerid][e_CB_POS][2] > z)
					CallLocalFunction("OnPlayerFall", "dff", playerid, floatsub(g_eCallbackData[playerid][e_CB_POS][2], z), floatsub(g_eCallbackData[playerid][e_CB_HEALTH], health));

				GetPlayerHealth(playerid, g_eCallbackData[playerid][e_CB_HEALTH]);
   				GetPlayerPos(playerid, g_eCallbackData[playerid][e_CB_POS][0], g_eCallbackData[playerid][e_CB_POS][1], g_eCallbackData[playerid][e_CB_POS][2]);
			}
		}
	}
	else if(g_CallbackInfo & e_CB_OPCV && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new
			vehicleid = GetPlayerVehicleID(playerid),
			damage[4],
			Float:health,
			Float:speed;

		GetVehicleHealth(vehicleid, health);
		speed = CB_GetVehicleSpeed(vehicleid);

		if((g_aVehicleHealth[vehicleid] > health && floatabs(g_aVehicleHealth[vehicleid] - health) >= POTENTIAL_CRASH_DAMAGE) && floatabs(g_aVehicleSpeed[vehicleid] - speed) >= POTENTIAL_SPEED_DROP)
		{
			GetVehicleDamageStatus(vehicleid, damage[0], damage[1], damage[2], damage[3]);

			if(g_aVehicleDamage[vehicleid]{0} != damage[0] || g_aVehicleDamage[vehicleid]{1} != damage[1] || g_aVehicleDamage[vehicleid]{2} != damage[2])
				CallLocalFunction("OnPlayerCrashVehicle", "ddf", playerid, vehicleid, floatsub(g_aVehicleHealth[vehicleid], health));

			for (new i = 0; i < 3; i ++) {
				g_aVehicleDamage[vehicleid]{i} = damage[i];
			}
		}
		g_aVehicleSpeed[vehicleid] = speed;
		g_aVehicleHealth[vehicleid] = health;
	}
	g_aCallbackFlags[playerid] |= e_CB_UPDATE;
	g_eCallbackData[playerid][e_CB_LAST] = GetTickCount();

	#if defined CB_OnPlayerUpdate
		CB_OnPlayerUpdate(playerid);
	#endif
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(g_CallbackInfo & e_CB_OPCJ)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
			g_aLastVehicle[playerid] = GetPlayerVehicleID(playerid);
		}
		else if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER) {

			static
				driverid = INVALID_PLAYER_ID;

			if((driverid = CB_GetVehicleDriver(g_aLastVehicle[playerid])) != INVALID_PLAYER_ID)
			    CallLocalFunction("OnPlayerCarJack", "ddd", driverid, playerid, g_aLastVehicle[playerid]);

			g_aLastVehicle[playerid] = INVALID_VEHICLE_ID;
		}
	}
	#if defined CB_OnPlayerStateChange
	    CB_OnPlayerStateChange(playerid, newstate, oldstate);
	#endif
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(g_CallbackInfo & e_CB_OPHK)
	{
		if(!(g_aCallbackFlags[playerid] & e_CB_HOLDING)) {

	    	g_aCallbackFlags[playerid] |= e_CB_HOLDING;

	    	g_eCallbackData[playerid][e_CB_TIME] = GetTickCount();
			g_eCallbackData[playerid][e_CB_TIMER] = SetTimerEx("_CB_HoldCheck", 200, true, "dd", playerid, newkeys);
		}
	}
	#if defined CB_OnPlayerKeyStateChange
	    CB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#endif
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if((g_CallbackInfo & e_CB_OPDC) && (clickedid == Text:INVALID_TEXT_DRAW && g_eCallbackData[playerid][e_CB_SELECT]))
	    CallLocalFunction("OnPlayerDisableCursor", "d", playerid);
	    
	#if defined CB_OnPlayerClickTextDraw
		CB_OnPlayerClickTextDraw(playerid, clickedid);
	#endif
	return 0;
}

forward _CB_HoldCheck(playerid, key);
public _CB_HoldCheck(playerid, key)
{
	static
	    keys[3];

	GetPlayerKeys(playerid, keys[0], keys[1], keys[2]);

	if(keys[0] & key) {
	    g_eCallbackData[playerid][e_CB_PRESSES]++;

	    CallLocalFunction("OnPlayerHoldingKey", "dd", playerid, key);
	}
	else
	{
	    if(g_CallbackInfo & e_CB_OPRK && g_eCallbackData[playerid][e_CB_PRESSES] > 0)
	    	CallLocalFunction("OnPlayerReleaseKey", "ddd", playerid, keys, GetTickCount() - g_eCallbackData[playerid][e_CB_TIME]);

        KillTimer(g_eCallbackData[playerid][e_CB_TIMER]);

	    g_aCallbackFlags[playerid] &= ~e_CB_HOLDING;
		g_eCallbackData[playerid][e_CB_PRESSES] = 0;
	}
}

forward _CB_TabCheck();
public _CB_TabCheck()
{
	for (new i = 0, l = GetMaxPlayers(); i != l; i ++)
	{
	    if(GetPlayerState(i) != PLAYER_STATE_ONFOOT && GetPlayerState(i) != PLAYER_STATE_DRIVER && GetPlayerState(i) != PLAYER_STATE_PASSENGER)
	        continue;

		if(g_aCallbackFlags[i] & e_CB_UPDATE)
		{
		    if(g_CallbackInfo & e_CB_OPR && g_aCallbackFlags[i] & e_CB_PAUSED)
		    	CallLocalFunction("OnPlayerResume", "dd", i, GetTickCount() - g_eCallbackData[i][e_CB_TIME]);

		    g_aCallbackFlags[i] &= ~e_CB_UPDATE;
		    g_aCallbackFlags[i] &= ~e_CB_PAUSED;
		}
		else if(g_CallbackInfo & e_CB_OPP)
		{
			if(!(g_aCallbackFlags[i] & e_CB_PAUSED) && (GetTickCount() - g_eCallbackData[i][e_CB_LAST]) >= 2000) {
			    g_aCallbackFlags[i] |= e_CB_PAUSED;

		    	g_eCallbackData[i][e_CB_TIME] = GetTickCount();
				CallLocalFunction("OnPlayerPause", "d", i);
			}
		}
	}
}

#if defined _ALS_SelectTextDraw
	#undef SelectTextDraw
#else
	#define _ALS_SelectTextDraw
#endif

#if defined _ALS_CancelSelectTextDraw
	#undef CancelSelectTextDraw
#else
	#define _ALS_CancelSelectTextDraw
#endif

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define SelectTextDraw          CB_SelectTextDraw
#define CancelSelectTextDraw    CB_CancelSelectTextDraw

#define OnFilterScriptInit  	CB_OnFilterScriptInit
#define OnGameModeInit 			CB_OnGameModeInit
#define OnPlayerUpdate 			CB_OnPlayerUpdate
#define OnPlayerStateChange  	CB_OnPlayerStateChange
#define OnPlayerKeyStateChange  CB_OnPlayerKeyStateChange
#define OnPlayerWeaponShot      CB_OnPlayerWeaponShot
#define OnPlayerClickTextDraw   CB_OnPlayerClickTextDraw

#if defined CB_OnPlayerUpdate
	forward CB_OnPlayerUpdate(playerid);
#endif

#if defined CB_OnFilterScriptInit
	forward CB_OnFilterScriptInit();
#endif

#if defined CB_OnGameModeInit
	forward CB_OnGameModeInit();
#endif

#if defined CB_OnPlayerStateChange
	forward CB_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

#if defined CB_OnPlayerKeyStateChange
	forward CB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

#if defined CB_OnPlayerWeaponShot
	forward CB_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
#endif

#if defined CB_OnPlayerClickTextDraw
	forward CB_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

#if defined _ALS_format
        #undef format
#else
        #define _ALS_format
#endif
 
#if defined _ALS_printf
        #undef printf
#else
        #define _ALS_printf
#endif
 
#define format ps_format
#define printf ps_printf