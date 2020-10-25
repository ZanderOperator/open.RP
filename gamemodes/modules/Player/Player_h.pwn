// For this file, include guard generation must be disabled as it might be included more than once
#if defined _player_h_included
    #undef _player_h_included
#endif

// Header file where functions should be declared that can be used/accessed from other modules

// Miscelleneous
forward Player_GetLastVehicle(playerid);
forward Player_SetLastVehicle(playerid, v);

// Rope
forward bool:Player_IsTied(playerid);
forward Player_SetIsTied(playerid, bool:v);
