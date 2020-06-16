/*
*	 	 Anti - Silent Aimbot
*	 www.cityofangels-roleplay.com
*	    created and coded by Khawaja
*	      All rights reserved.
*	     	   (c) 2020
*/

#include <YSI\y_hooks>

new AimbotWarnings[MAX_PLAYERS];

Float:AC_DisCameraTargetToLocati(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
        new Float:TGTDistance;

        TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

        new Float:tmpX, Float:tmpY, Float:tmpZ;

        tmpX = FrX * TGTDistance + CamX;
        tmpY = FrY * TGTDistance + CamY;
        tmpZ = FrZ * TGTDistance + CamZ;

        return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y)
{

  new Float:DX, Float:DY;
  new Float:angle;

  DX = floatabs(floatsub(x2,X));
  DY = floatabs(floatsub(y2,Y));

  if (DY == 0.0 || DX == 0.0)
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

GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance)
{
        x += (distance * floatsin(-angle, degrees));
        y += (distance * floatcos(-angle, degrees));
}

AC_IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
        new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
        GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
        GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

        new Float:vertical, Float:horizontal;

        switch (GetPlayerWeapon(playerid))
        {
                        case 34,35,36: {
                        if (AC_DisCameraTargetToLocati(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
                        return false;
                        }
                        case 30,31: {vertical = 4.0; horizontal = -1.6;}
                        case 33: {vertical = 2.7; horizontal = -1.0;}
                        default: {vertical = 6.0; horizontal = -2.2;}
        }

        new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
        new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
        GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

        if (AC_DisCameraTargetToLocati(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
        return false;
}

bool:AC_IsPlayerAimingAtPlayer(playerid, target)
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(target, x, y, z);
        if (AC_IsPlayerAimingAt(playerid, x, y, z-0.75, 0.25)) return true;
        if (AC_IsPlayerAimingAt(playerid, x, y, z-0.25, 0.25)) return true;
        if (AC_IsPlayerAimingAt(playerid, x, y, z+0.25, 0.25)) return true;
        if (AC_IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
        return false;
}

hook OnGameModeInit()
{
    return print("Anti-Aimbot script loaded!");
}

hook OnPlayerConnect(playerid)
{
        AimbotWarnings[playerid] = 0;
        return 1;
}


hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    switch(weaponid){ case 0..18, 39..54: return 1;}//invalid weapons

    if(hittype == BULLET_HIT_TYPE_PLAYER && IsPlayerConnected(hitid) && !IsPlayerNPC(hitid))
    {
            new Float:Shot[3], Float:Hit[3];
            GetPlayerLastShotVectors(playerid, Shot[0], Shot[1], Shot[2], Hit[0], Hit[1], Hit[2]);

            new playersurf = GetPlayerSurfingVehicleID(playerid);
            new hitsurf = GetPlayerSurfingVehicleID(hitid);
            new Float:targetpackets = NetStats_PacketLossPercent(hitid);
            new Float:playerpackets = NetStats_PacketLossPercent(playerid);

            if(~(playersurf) && ~(hitsurf) && !IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(hitid))
            {
                    if(!AC_IsPlayerAimingAtPlayer(playerid, hitid) && !IsPlayerInRangeOfPoint(hitid, 5.0, Hit[0], Hit[1], Hit[2]))
                    {
                            new string[128], issuer[24];
                            GetPlayerName(playerid, issuer, 24);
                            AimbotWarnings[playerid] ++;
							SendClientMessage(playerid, COLOR_RED, "[ ! ] Dobibi ste aimbot warning. Ukoliko nastavite AC ce vas iskljuciti sa servera!");

                            format(string, sizeof(string), "Igrac %s, opomenut za aimbot ili lag [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);
                            SendAdminMessage(COLOR_RED, string);

                            if(AimbotWarnings[playerid] > 5)
                            {
                                    if(targetpackets < 1.2 && playerpackets < 1.2){
                                        SendClientMessage(playerid, COLOR_RED, "[ ! ] Dobili ste kick nakon pet warninga za aimbot.");
										Kick(playerid);
									}
                                    else
                                    {
                                        format(string, sizeof(string), "Igrac %s moguce koristi aimbot [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);
                                        SendAdminMessage(COLOR_RED, string);
                                    }
                            }
                            return 0;
                    }
                    else return 1;
            }
            else return 1;
    }
    return 1;
}

