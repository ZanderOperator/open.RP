/*  Fire Department Map  */

#include <YSI_Coding\y_hooks>

static
    fd_gate   [10],
    fd_gstatus[10]
;

hook OnFilterScriptInit()
{
    // vrata na vrhu - L3o
    CreateDynamicObject(11714, 1161.67944, -1330.46667, 31.70260,   0.00000, 0.00000, 90.00000);
    fd_gate[0] = CreateDynamicObject(11313, 1277.762573, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[0], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[1] = CreateDynamicObject(11313, 1269.862304, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[1], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[2] = CreateDynamicObject(11313, 1261.960449, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[2], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[3] = CreateDynamicObject(11313, 1254.079467, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[3], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[4] = CreateDynamicObject(11313, 1246.167724, -1269.913208, 14.500725, 0.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[4], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[5] = CreateDynamicObject(11313, 1277.482299, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[5], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[6] = CreateDynamicObject(11313, 1269.582031, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[6], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[7] = CreateDynamicObject(11313, 1261.680175, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[7], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[8] = CreateDynamicObject(11313, 1253.799194, -1252.062744, 14.500725, 0.000007, 0.000000, 89.999977, -1, -1, -1, 600.00, 600.00);
    SetDynamicObjectMaterial(fd_gate[8], 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    fd_gate[9] = CreateDynamicObject(968, 1327.863159, -1235.412109, 13.384195, 0.000000, 90.000000, 270.000000, -1, -1, -1, 600.00, 600.00);

    // LSFD garaza - novo - by L3o
    CreateDynamicObject(10558, 284.01404, -1543.04895, 29.67324,   0.00000, 0.00000, 55.47064, 5, -1, -1, 100.00); // world 5
    CreateDynamicObject(10558, 284.01401, -1543.04895, 25.65790,   0.00000, 0.00000, 55.47060, 5, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81213, -1488.00415, 29.10190,   0.00000, 0.00000, 55.02290, 5, -1, -1, 100.00);
    CreateDynamicObject(10558, 320.81210, -1488.00415, 25.07890,   0.00000, 0.00000, 55.02290, 5, -1, -1, 100.00);

    // Pickup
    CreateDynamicPickup(19133, 2, 284.846497, -1540.948486, 24.596806, 5, -1, -1, 80.0); // garaza
    return 1;
}

timer firedep_close[10000](gate_id,  Float:X, Float:Y, Float:Z, Float:gate_speed, Float:RotX, Float:RotY, Float:RotZ)
{
    MoveDynamicObject(fd_gate[gate_id], X, Y, Z, gate_speed, RotX, RotY, RotZ);
    fd_gstatus[gate_id] = 0;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_YES)) // Tipka Y
    {
        // TODO: convert to loop, making this code more dynamic
        // make a const array of positions
        // make a helper function to get the gate player is closest to and return the array index
        // make a helper function to close the gate based on the gate index returned from previous step

        //======================== [LSFD NEW] =========================
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1277.762573, -1269.913208, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[0] == 0)
            {
                MoveDynamicObject(fd_gate[0], 1277.7626, -1269.9132, 10.0307, 1.4, 0.0000, 0.0000, 90.0000);

                fd_gstatus[0] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 0, 1277.762573, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1269.862304, -1269.913208, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[1] == 0)
            {
                MoveDynamicObject(fd_gate[1], 1269.862304, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[1] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 1, 1269.862304, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1261.960449, -1269.913208, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[2] == 0) {
                MoveDynamicObject(fd_gate[2], 1261.960449, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[2] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 2, 1261.960449, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1254.079467, -1269.913208, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[3] == 0)
            {
                MoveDynamicObject(fd_gate[3], 1254.079467, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[3] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 3, 1254.079467, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1246.167724, -1269.913208, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[4] == 0)
            {
                MoveDynamicObject(fd_gate[4], 1246.167724, -1269.913208, 10.030691, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[4] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 4, 1246.167724, -1269.913208, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1277.482299, -1252.062744, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[5] == 0)
            {
                MoveDynamicObject(fd_gate[5], 1277.482299, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[5] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 5, 1277.482299, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1269.582031, -1252.062744, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[6] == 0)
            {
                MoveDynamicObject(fd_gate[6], 1269.582031, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[6] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 6, 1269.582031, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1261.680175, -1252.062744, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[7] == 0)
            {
                MoveDynamicObject(fd_gate[7], 1261.680175, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[7] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 7, 1261.680175, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1253.799194, -1252.062744, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[8] == 0)
            {
                MoveDynamicObject(fd_gate[8], 1253.799194, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[8] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 8, 1253.799194, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1253.799194, -1252.062744, 14.500725))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[8] == 0)
            {
                MoveDynamicObject(fd_gate[8], 1253.799194, -1252.062744, 9.710713, 1.4, 0.000007, 0.000000, 89.999977);

                fd_gstatus[8] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 8, 1253.799194, -1252.062744, 14.500725, 1.4, 0.000000, 0.000000, 450.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~GATE OPENING...", 5000, 3);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 8.0, 1327.863159, -1235.412109, 13.384195))
        {
            if(GetPlayerFactionType(playerid) != FACTION_TYPE_FD) 
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You are not member of LSFD!");

            if(fd_gstatus[9] == 0)
            {
                MoveDynamicObject(fd_gate[9], 1327.863159, -1235.412109, 13.384195, 1.4, 0.000000, 0.000000, 270.000000);

                fd_gstatus[9] = 1;
                SetTimerEx("firedep_close", 10000, false, "dfffffff", 9, 1327.863159, -1235.412109, 13.384195, 1.4, 0.000000, 90.000000, 270.000000);
                GameTextForPlayer(playerid, "~w~LSFD~n~~g~RAMP OPENING...", 5000, 3);
            }
        }
    }
    return 1;
}