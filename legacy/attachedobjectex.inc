// ============================================================
//              Attached Object Ex (AOX)
//                      by Corekt a.k.a. robotmonkey
//                              © 2014
//
//      ***IMPORTANT***
//      You must include this before any other
//      include that uses SetPlayerAttachedObject or
//      RemovePlayerAttachedObject
//
//      For updates please visit
//            http://forum.sa-mp.com/showthread.php?t=506429
// ============================================================
 
#if !defined _samp_included
    #error You must include a_samp before attachedobjex.
#endif
 
forward _AOX_CheckWeaponZoom(playerid);
forward RemovePlayerTempAttachedObject(playerid, index, aoid);
forward MovePlayerAttachedObject_Timer(playerid, index, aoid, Float:OffsetX1, Float:OffsetY1, Float:OffsetZ1, Float:OffsetX2, Float:OffsetY2, Float:OffsetZ2, Float:Speed, Float:pfactor);

// Callbacks
forward OnTempAttachedObjectDestroy(playerid, index);
forward OnPlayerAttachedObjectMoved(playerid, index);
 
enum E_AOX_DATA
{
    eAO_modelid,
    eAO_bone,
    Float:eAO_fOffsetX,
    Float:eAO_fOffsetY,
    Float:eAO_fOffsetZ,
    Float:eAO_fRotX,
    Float:eAO_fRotY,
    Float:eAO_fRotZ,
    Float:eAO_fScaleX,
    Float:eAO_fScaleY,
    Float:eAO_fScaleZ,
    eAO_materialcolor1,
    eAO_materialcolor2,
    eAO_id,
    eAO_idTemp,
    eAO_tempBirth,
    eAO_tempTime,
    bool:eAO_tempRemoved,
    bool:eAO_isMoving
}
 
static
    gAOX_Tickrate = 15,
    gPlayerAO[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][E_AOX_DATA],
    gTempAttachedObjectCount[MAX_PLAYERS],
    gIsPlayerWeaponZoomedIn[MAX_PLAYERS],
    gTimerWeaponZoom[MAX_PLAYERS],
    bool:gAOWeaponZoomEnabled[MAX_PLAYERS],
    bool:gRemoveNormAOWeaponZoom[MAX_PLAYERS];
 
// CALLBACK HOOK
public OnPlayerConnect(playerid)
{
    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        RemovePlayerAttachedObject(playerid, i);
        gPlayerAO[playerid][i][eAO_modelid] = INVALID_OBJECT_ID;
        gPlayerAO[playerid][i][eAO_bone] = 0;
        gPlayerAO[playerid][i][eAO_fOffsetX] = 0;
        gPlayerAO[playerid][i][eAO_fOffsetY] = 0;
        gPlayerAO[playerid][i][eAO_fOffsetZ] = 0;
        gPlayerAO[playerid][i][eAO_fRotX] = 0;
        gPlayerAO[playerid][i][eAO_fRotY] = 0;
        gPlayerAO[playerid][i][eAO_fRotZ] = 0;
        gPlayerAO[playerid][i][eAO_fScaleX] = 0;
        gPlayerAO[playerid][i][eAO_fScaleY] = 0;
        gPlayerAO[playerid][i][eAO_fScaleZ] = 0;
        gPlayerAO[playerid][i][eAO_materialcolor1] = 0;
        gPlayerAO[playerid][i][eAO_materialcolor2] = 0;
        gPlayerAO[playerid][i][eAO_id] = 0;
        gPlayerAO[playerid][i][eAO_tempBirth] = 0;
        gPlayerAO[playerid][i][eAO_tempRemoved] = false;
        gPlayerAO[playerid][i][eAO_isMoving] = false;
    }
    gTempAttachedObjectCount[playerid] = 0;
    gIsPlayerWeaponZoomedIn[playerid] = false;
    gAOWeaponZoomEnabled[playerid] = true;
    gRemoveNormAOWeaponZoom[playerid] = false;
    if(funcidx("AOXhook_OnPlayerConnect") != -1) {
        return CallLocalFunction("AOXhook_OnPlayerConnect", "d", playerid);
    }
    return 1;
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AOXhook_OnPlayerConnect
forward AOXhook_OnPlayerConnect(playerid);
 
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(gAOWeaponZoomEnabled[playerid]) {
        if(((newkeys & (KEY_HANDBRAKE)) == (KEY_HANDBRAKE)) && ((oldkeys & (KEY_HANDBRAKE)) != (KEY_HANDBRAKE)) && !IsPlayerInAnyVehicle(playerid)) {
            if(GetPlayerWeapon(playerid) == WEAPON_SNIPER || GetPlayerWeapon(playerid) == WEAPON_ROCKETLAUNCHER || GetPlayerWeapon(playerid) == WEAPON_HEATSEEKER || GetPlayerWeapon(playerid) == WEAPON_CAMERA) {
                if(!gIsPlayerWeaponZoomedIn[playerid]) {
                    if(GetAttachedObjectCount(playerid) > 0) {
                        gIsPlayerWeaponZoomedIn[playerid] = true;
                        RemoveAllTempAttachedObjects(playerid);
                        gTimerWeaponZoom[playerid] = SetTimerEx("_AOX_CheckWeaponZoom", 500, true, "d", playerid);
                    } else {
                        for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
                            gPlayerAO[playerid][i][eAO_modelid] = INVALID_OBJECT_ID;
                            gPlayerAO[playerid][i][eAO_bone] = 0;
                            gPlayerAO[playerid][i][eAO_fOffsetX] = 0;
                            gPlayerAO[playerid][i][eAO_fOffsetY] = 0;
                            gPlayerAO[playerid][i][eAO_fOffsetZ] = 0;
                            gPlayerAO[playerid][i][eAO_fRotX] = 0;
                            gPlayerAO[playerid][i][eAO_fRotY] = 0;
                            gPlayerAO[playerid][i][eAO_fRotZ] = 0;
                            gPlayerAO[playerid][i][eAO_fScaleX] = 0;
                            gPlayerAO[playerid][i][eAO_fScaleY] = 0;
                            gPlayerAO[playerid][i][eAO_fScaleZ] = 0;
                            gPlayerAO[playerid][i][eAO_materialcolor1] = 0;
                            gPlayerAO[playerid][i][eAO_materialcolor2] = 0;
                            gPlayerAO[playerid][i][eAO_id] = 0;
                            gPlayerAO[playerid][i][eAO_tempBirth] = 0;
                            gPlayerAO[playerid][i][eAO_tempTime] = 0;
                            gPlayerAO[playerid][i][eAO_tempRemoved] = false;
                            gPlayerAO[playerid][i][eAO_isMoving] = false;
                        }
                        gTempAttachedObjectCount[playerid] = 0;
                    }
                }
            }
        }
    }
    if(funcidx("AOXhook_OnPlayerKeyStateChange") != -1) {
        return CallLocalFunction("AOXhook_OnPlayerKeyStateChange", "ddd", playerid, newkeys, oldkeys);
    }
    return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange AOXhook_OnPlayerKeyStateChange
forward AOXhook_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
 
// =========================================
 
// FUNC HOOK
stock _AOX_SetPlayerAttachedObject(playerid, index, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
{
    if(index < 0 || index >= MAX_PLAYER_ATTACHED_OBJECTS) return 0; // prevent array index out of bounds exception
    
    new
        bool:replace = false;
        
    if(IsPlayerAttachedObjectSlotUsed(playerid, index)) replace = true;
    
    if(SetPlayerAttachedObject(playerid, index, modelid, bone, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, materialcolor1, materialcolor2) != 0) {
        if(!replace && !gPlayerAO[playerid][index][eAO_tempRemoved]) gPlayerAO[playerid][index][eAO_id]++;
        gPlayerAO[playerid][index][eAO_modelid] = modelid;
        gPlayerAO[playerid][index][eAO_bone] = bone;
        gPlayerAO[playerid][index][eAO_fOffsetX] = fOffsetX;
        gPlayerAO[playerid][index][eAO_fOffsetY] = fOffsetY;
        gPlayerAO[playerid][index][eAO_fOffsetZ] = fOffsetZ;
        gPlayerAO[playerid][index][eAO_fRotX] = fRotX;
        gPlayerAO[playerid][index][eAO_fRotY] = fRotY;
        gPlayerAO[playerid][index][eAO_fRotZ] = fRotZ;
        gPlayerAO[playerid][index][eAO_fScaleX] = fScaleX;
        gPlayerAO[playerid][index][eAO_fScaleY] = fScaleY;
        gPlayerAO[playerid][index][eAO_fScaleZ] = fScaleZ;
        gPlayerAO[playerid][index][eAO_materialcolor1] = materialcolor1;
        gPlayerAO[playerid][index][eAO_materialcolor2] = materialcolor2;
        return 1;
    } else {
        return 0;
    }
}
 
#if defined _ALS_SetPlayerAttachedObject
        #undef SetPlayerAttachedObject
#else
        #define _ALS_SetPlayerAttachedObject
#endif
#define SetPlayerAttachedObject _AOX_SetPlayerAttachedObject
 
stock _AOX_RemovePlayerAttachedObject(playerid, index)
{
    if(index < 0 || index >= MAX_PLAYER_ATTACHED_OBJECTS) return 0; // prevent array index out of bounds exception

    if(!gPlayerAO[playerid][index][eAO_tempRemoved]) {
        if(gPlayerAO[playerid][index][eAO_tempBirth] != 0) {
            gTempAttachedObjectCount[playerid]--;
        }
       
        gPlayerAO[playerid][index][eAO_modelid] = INVALID_OBJECT_ID;
        gPlayerAO[playerid][index][eAO_bone] = 0;
        gPlayerAO[playerid][index][eAO_fOffsetX] = 0;
        gPlayerAO[playerid][index][eAO_fOffsetY] = 0;
        gPlayerAO[playerid][index][eAO_fOffsetZ] = 0;
        gPlayerAO[playerid][index][eAO_fRotX] = 0;
        gPlayerAO[playerid][index][eAO_fRotY] = 0;
        gPlayerAO[playerid][index][eAO_fRotZ] = 0;
        gPlayerAO[playerid][index][eAO_fScaleX] = 0;
        gPlayerAO[playerid][index][eAO_fScaleY] = 0;
        gPlayerAO[playerid][index][eAO_fScaleZ] = 0;
        gPlayerAO[playerid][index][eAO_materialcolor1] = 0;
        gPlayerAO[playerid][index][eAO_materialcolor2] = 0;
        gPlayerAO[playerid][index][eAO_tempBirth] = 0;
        gPlayerAO[playerid][index][eAO_tempTime] = 0;
        gPlayerAO[playerid][index][eAO_isMoving] = false;
    }

    return RemovePlayerAttachedObject(playerid, index);
}
 
#if defined _ALS_RemovePlayerAttachedObject
    #undef RemovePlayerAttachedObject
#else
    #define _ALS_RemovePlayerAttachedObject
#endif
#define RemovePlayerAttachedObject _AOX_RemovePlayerAttachedObject
 
// ==========================================================
 
stock AOX_GetTickRate()
{
    return gAOX_Tickrate;
}

stock AOX_SetTickRate(tickrate)
{
    gAOX_Tickrate = tickrate;
}

stock IsPlayerAttachedObjectTemp(playerid, index)
{
    return (gPlayerAO[playerid][index][eAO_tempBirth] != 0) ? true : false;
}
 
stock GetFreePlayerAttachedObjectSlot(playerid)
{
    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
            return i;
    }
    return -1;
}
 
stock GetTempAttachedObjectCount(playerid)
{
    return (!GetAttachedObjectCount(playerid)) ? 0 : gTempAttachedObjectCount[playerid];
}
 
stock GetAttachedObjectCount(playerid)
{
    new count;
    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
            count++;
    }
    return count;
}
 
stock GetPlayerAttachedObjectID(playerid, index)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return -1;
    return (gPlayerAO[playerid][index][eAO_tempBirth] != 0) ? gPlayerAO[playerid][index][eAO_id] : -1;
}
 
stock GetPlayerAttachedObjectBone(playerid, index)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return 0;
    return gPlayerAO[playerid][index][eAO_bone];
}

stock SetPlayerAttachedObjectBone(playerid, index, bone)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
        return 0;
        
    gPlayerAO[playerid][index][bone] = bone;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}

stock GetPlayerAttachedObjectModel(playerid, index)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return INVALID_OBJECT_ID;
    return gPlayerAO[playerid][index][eAO_modelid];
}

stock SetPlayerAttachedObjectModel(playerid, index, modelid)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
        return 0;
        
    gPlayerAO[playerid][index][eAO_modelid] = modelid;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}
 
stock GetPlayerAttachedObjectOffset(playerid, index, &Float:fOffsetX, &Float:fOffsetY, &Float:fOffsetZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return 0;
   
    fOffsetX = gPlayerAO[playerid][index][eAO_fOffsetX];
    fOffsetY = gPlayerAO[playerid][index][eAO_fOffsetY];
    fOffsetZ = gPlayerAO[playerid][index][eAO_fOffsetZ];
    return 1;
}

stock SetPlayerAttachedObjectOffset(playerid, index, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) || gPlayerAO[playerid][index][eAO_isMoving])
        return 0;
        
    gPlayerAO[playerid][index][eAO_fOffsetX] = fOffsetX;
    gPlayerAO[playerid][index][eAO_fOffsetY] = fOffsetY;
    gPlayerAO[playerid][index][eAO_fOffsetZ] = fOffsetZ;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}
 
stock GetPlayerAttachedObjectRot(playerid, index, &Float:fRotX, &Float:fRotY, &Float:fRotZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return 0;

    fRotX = gPlayerAO[playerid][index][eAO_fRotX];
    fRotY = gPlayerAO[playerid][index][eAO_fRotY];
    fRotZ = gPlayerAO[playerid][index][eAO_fRotZ];
    return 1;
}

stock SetPlayerAttachedObjectRot(playerid, index, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) || gPlayerAO[playerid][index][eAO_isMoving])
        return 0;
        
    gPlayerAO[playerid][index][eAO_fRotX] = fRotX;
    gPlayerAO[playerid][index][eAO_fRotY] = fRotY;
    gPlayerAO[playerid][index][eAO_fRotZ] = fRotZ;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}
 
stock GetPlayerAttachedObjectScale(playerid, index, &Float:fScaleX, &Float:fScaleY, &Float:fScaleZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved])
        return 0;
   
    fScaleX = gPlayerAO[playerid][index][eAO_fScaleX];
    fScaleY = gPlayerAO[playerid][index][eAO_fScaleY];
    fScaleZ = gPlayerAO[playerid][index][eAO_fScaleZ];
    return 1;
}

stock SetPlayerAttachedObjectScale(playerid, index, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
        return 0;
        
    gPlayerAO[playerid][index][eAO_fScaleX] = fScaleX;
    gPlayerAO[playerid][index][eAO_fScaleY] = fScaleY;
    gPlayerAO[playerid][index][eAO_fScaleZ] = fScaleZ;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}
 
stock GetPlayerAttachedObjectColor(playerid, index, &materialcolor1, &materialcolor2)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) && !gPlayerAO[playerid][index][eAO_tempRemoved]) return 0;
   
    materialcolor1 = gPlayerAO[playerid][index][eAO_materialcolor1];
    materialcolor2 = gPlayerAO[playerid][index][eAO_materialcolor2];
    return 1;
}

stock SetPlayerAttachedObjectColor(playerid, index, materialcolor1, materialcolor2)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index))
        return 0;
        
    gPlayerAO[playerid][index][eAO_materialcolor1] = materialcolor1;
    gPlayerAO[playerid][index][eAO_materialcolor2] = materialcolor2;
        
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
    return 1;
}
 
stock GetOldestTempAttachedObject(playerid)
{
    new
        oldestAO = -1,
        oldestTime = -1;

    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if(!gPlayerAO[playerid][i][eAO_tempBirth]) continue;
        if(gPlayerAO[playerid][i][eAO_tempBirth] < oldestTime || oldestTime == -1) {
            oldestAO = i;
            oldestTime = gPlayerAO[playerid][i][eAO_tempBirth];
        }
    }

    return oldestAO;
}
 
stock GetNewestTempAttachedObject(playerid)
{
    new
        newestAO = -1,
        newestTime = -1;

    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if(!gPlayerAO[playerid][i][eAO_tempBirth]) continue;
        if(gPlayerAO[playerid][i][eAO_tempBirth] > newestAO || newestTime == -1) {
            newestAO = i;
            newestTime = gPlayerAO[playerid][i][eAO_tempBirth];
        }
    }

    return newestAO;
}

stock GetTempAttachedObjectTime(playerid, index)
{
    return gPlayerAO[playerid][index][eAO_tempTime];
}

stock ToggleRemoveAOWeaponZoom(playerid, toggle)
{
    gAOWeaponZoomEnabled[playerid] = (toggle) ? true : false;
}

stock ToggleRemoveNormAOWeaponZoom(playerid, toggle)
{
    gRemoveNormAOWeaponZoom[playerid] = (toggle) ? true : false;
}

stock IsPlayerAttachedObjectMoving(playerid, index)
{
    return (IsPlayerAttachedObjectSlotUsed(playerid, index)) ? gPlayerAO[playerid][index][eAO_isMoving] : false;
}

stock SetPlayerTempAttachedObject
(playerid, time, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
{
    new
        index = GetFreePlayerAttachedObjectSlot(playerid);
   
    if(index == -1) {
        // All slots used
        new
            oldestTemp = GetOldestTempAttachedObject(playerid);
                   
        if(oldestTemp == -1) return -1;
        index = oldestTemp;
        RemovePlayerAttachedObject(playerid, index); // no need for count decrement; hook handles it
    } else {
        gTempAttachedObjectCount[playerid]++;
    }
   
    gPlayerAO[playerid][index][eAO_tempBirth] = gettime();
   
    SetPlayerAttachedObject(playerid, index, modelid, bone, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, materialcolor1, materialcolor2);
   
    if(time != -1) {
        gPlayerAO[playerid][index][eAO_tempTime] = time;
        SetTimerEx("RemovePlayerTempAttachedObject", time, false, "ddd", playerid, index, gPlayerAO[playerid][index][eAO_id]);
    }
    return index;
}
 
stock RemoveAllTempAttachedObjects(playerid)
{
    if(!gIsPlayerWeaponZoomedIn[playerid]) return 0;
    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i)) continue;
        if(gPlayerAO[playerid][i][eAO_tempBirth] != 0 || gRemoveNormAOWeaponZoom[playerid]) {
            gPlayerAO[playerid][i][eAO_tempRemoved] = true;
            RemovePlayerAttachedObject(playerid, i);
        }
    }
    return 1;
}
 
stock RestoreAllTempAttachedObjects(playerid)
{
    if(!gIsPlayerWeaponZoomedIn[playerid]) return 0;
    for (new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
        if((gPlayerAO[playerid][i][eAO_tempBirth] != 0 || gRemoveNormAOWeaponZoom[playerid]) && gPlayerAO[playerid][i][eAO_tempRemoved]) {
            SetPlayerAttachedObject(playerid, i, gPlayerAO[playerid][i][eAO_modelid], gPlayerAO[playerid][i][eAO_bone],
                gPlayerAO[playerid][i][eAO_fOffsetX], gPlayerAO[playerid][i][eAO_fOffsetY], gPlayerAO[playerid][i][eAO_fOffsetZ],
                gPlayerAO[playerid][i][eAO_fRotX], gPlayerAO[playerid][i][eAO_fRotY], gPlayerAO[playerid][i][eAO_fRotZ],
                gPlayerAO[playerid][i][eAO_fScaleX], gPlayerAO[playerid][i][eAO_fScaleY], gPlayerAO[playerid][i][eAO_fScaleZ],
                gPlayerAO[playerid][i][eAO_materialcolor1], gPlayerAO[playerid][i][eAO_materialcolor2]);
            gPlayerAO[playerid][i][eAO_tempRemoved] = false;
        }
    }
    return 1;
}
 
public _AOX_CheckWeaponZoom(playerid)
{
    if(!gIsPlayerWeaponZoomedIn[playerid]) return 0;
    new camMode = GetPlayerCameraMode(playerid);

    if(camMode != 7 && camMode != 8 && camMode != 16 && camMode != 46 && camMode != 51) {
        RestoreAllTempAttachedObjects(playerid);
        gIsPlayerWeaponZoomedIn[playerid] = false;
        KillTimer(gTimerWeaponZoom[playerid]);
    }
    return 1;
}
 
public RemovePlayerTempAttachedObject(playerid, index, aoid)
{
    if(aoid == -1) aoid = GetPlayerAttachedObjectID(playerid, index);

    // Avoid conflicts
    if(aoid != gPlayerAO[playerid][index][eAO_id] || !IsPlayerConnected(playerid)) return 0;
    
    new
        bool:setRemove = true;

    if(funcidx("OnTempAttachedObjectDestroy") != -1) {
        if(CallLocalFunction("OnTempAttachedObjectDestroy", "dd", playerid, index) == 0 && gPlayerAO[playerid][index][eAO_tempTime] != 0) {
            // Don't remove if callback returns 0 and temp AO has expiry time
            setRemove = false;
        }
    }
    gPlayerAO[playerid][index][eAO_tempRemoved] = false;
    
    if(setRemove) {
        RemovePlayerAttachedObject(playerid, index);
    } else {
        SetTimerEx("RemovePlayerTempAttachedObject", gPlayerAO[playerid][index][eAO_tempTime], false, "ddd", playerid, index, gPlayerAO[playerid][index][eAO_id]);
    }
    return 1;
}

// ============= MOVE ATTACHED OBJECT ==============

stock MovePlayerAttachedObject(playerid, index, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:Speed)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid, index) || gPlayerAO[playerid][index][eAO_isMoving] || floatcmp(Speed, 0.0) == 0) return 0;

    gPlayerAO[playerid][index][eAO_isMoving] = true;
    
    // Begin movement
    SetTimerEx("MovePlayerAttachedObject_Timer", gAOX_Tickrate, false, "dddffffffff", playerid, index, gPlayerAO[playerid][index][eAO_id],
        gPlayerAO[playerid][index][eAO_fOffsetX], gPlayerAO[playerid][index][eAO_fOffsetY], gPlayerAO[playerid][index][eAO_fOffsetZ],
        OffsetX, OffsetY, OffsetZ,
        floatabs(Speed), 0.0);
    return 1;
}

public MovePlayerAttachedObject_Timer(playerid, index, aoid, Float:OffsetX1, Float:OffsetY1, Float:OffsetZ1, Float:OffsetX2, Float:OffsetY2, Float:OffsetZ2, Float:Speed, Float:pfactor)
{
    // Avoid conflicts
    if(!IsPlayerConnected(playerid) || !IsPlayerAttachedObjectSlotUsed(playerid, index) || aoid != gPlayerAO[playerid][index][eAO_id] || !gPlayerAO[playerid][index][eAO_isMoving])
        return 0;
    
    new
        Float:newPFact = floatadd(pfactor, floatdiv(Speed, floatdiv(1000, gAOX_Tickrate)));
        
    if(floatcmp(newPFact, 1.0) == 1 || floatcmp(newPFact, 1.0) == 0) {
        // AO has reached its offset destination
        gPlayerAO[playerid][index][eAO_isMoving] = false;
        SetPlayerAttachedObject(playerid, index,
            gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
            OffsetX2, OffsetY2, OffsetZ2,
            gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
            gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
            gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
        CallLocalFunction("OnPlayerAttachedObjectMoved", "dd", playerid, index);
        return 0;
    }
    
    new
        Float:newOffsetX = floatadd(OffsetX1, newPFact * floatsub(OffsetX2, OffsetX1)),
        Float:newOffsetY = floatadd(OffsetY1, newPFact * floatsub(OffsetY2, OffsetY1)),
        Float:newOffsetZ = floatadd(OffsetZ1, newPFact * floatsub(OffsetZ2, OffsetZ1));
    
    SetPlayerAttachedObject(playerid, index,
        gPlayerAO[playerid][index][eAO_modelid], gPlayerAO[playerid][index][eAO_bone],
        newOffsetX, newOffsetY, newOffsetZ,
        gPlayerAO[playerid][index][eAO_fRotX], gPlayerAO[playerid][index][eAO_fRotY], gPlayerAO[playerid][index][eAO_fRotZ],
        gPlayerAO[playerid][index][eAO_fScaleX], gPlayerAO[playerid][index][eAO_fScaleY], gPlayerAO[playerid][index][eAO_fScaleZ],
        gPlayerAO[playerid][index][eAO_materialcolor1], gPlayerAO[playerid][index][eAO_materialcolor2]);
        
    SetTimerEx("MovePlayerAttachedObject_Timer", gAOX_Tickrate, false, "dddffffffff", playerid, index, aoid,
        OffsetX1, OffsetY1, OffsetZ1, OffsetX2, OffsetY2, OffsetZ2,
        Speed, newPFact);
        
    return 1;
}