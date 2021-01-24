#if defined _lsfd_amb_included
  #endinput
#endif
#define _lsfd_amb_included

/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/
#include <YSI_Coding\y_hooks>


/*
    ##     ##    ###    ########   ######  
    ##     ##   ## ##   ##     ## ##    ## 
    ##     ##  ##   ##  ##     ## ##       
    ##     ## ##     ## ########   ######  
     ##   ##  ######### ##   ##         ## 
      ## ##   ##     ## ##    ##  ##    ## 
       ###    ##     ## ##     ##  ######  
*/
static
    AmbulanceId[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};


/*
    ######## ##     ## ##    ##  ######   ######  
    ##       ##     ## ###   ## ##    ## ##    ## 
    ##       ##     ## ####  ## ##       ##       
    ######   ##     ## ## ## ## ##        ######  
    ##       ##     ## ##  #### ##             ## 
    ##       ##     ## ##   ### ##    ## ##    ## 
    ##        #######  ##    ##  ######   ######  
*/
stock Player_AmbulanceId(playerid)
{
    return AmbulanceId[playerid];
}

stock Player_SetAmbulanceId(playerid, v)
{
    AmbulanceId[playerid] = v;
}

/*
    ##     ##  #######   #######  ##    ##  ######  
    ##     ## ##     ## ##     ## ##   ##  ##    ## 
    ##     ## ##     ## ##     ## ##  ##   ##       
    ######### ##     ## ##     ## #####     ######  
    ##     ## ##     ## ##     ## ##  ##         ## 
    ##     ## ##     ## ##     ## ##   ##  ##    ## 
    ##     ##  #######   #######  ##    ##  ######  
*/
hook OnGameModeInit()
{
    new ambulance_new;
    ambulance_new = CreateDynamicObject(19457, 1557.011962, 1515.938232, -16.263973, 0.000000, 90.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 4604, "buildblk555", "gm_labuld5_b", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1560.511962, 1515.938232, -16.263973, 0.000000, 90.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 4604, "buildblk555", "gm_labuld5_b", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1558.661743, 1520.656005, -14.473980, 0.000000, 360.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 6871, "vegascourtbld", "courthse2_256", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1555.439941, 1518.107666, -14.473980, 0.000000, 360.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 6871, "vegascourtbld", "courthse2_256", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1560.473022, 1518.107666, -14.473980, 0.000000, 360.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 6871, "vegascourtbld", "courthse2_256", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1557.252197, 1515.938232, -12.713948, 0.000000, 90.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 4604, "buildblk555", "gm_labuld5_b", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1560.742797, 1515.938232, -12.713948, 0.000000, 90.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 4604, "buildblk555", "gm_labuld5_b", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1556.116333, 1515.338134, -12.928019, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1556.116333, 1518.829467, -13.588027, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1556.116333, 1514.387207, -14.448036, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1557.287353, 1520.230590, -12.818017, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1559.747558, 1520.808837, -13.588027, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1557.947998, 1520.230590, -12.818017, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1561.407592, 1519.137695, -13.588027, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1561.387329, 1517.145996, -13.588027, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1559.735229, 1515.338134, -12.928019, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1559.726806, 1514.387207, -14.448036, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1560.447509, 1513.666503, -14.448036, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1560.447509, 1515.107421, -14.448036, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1555.377319, 1515.107421, -14.448036, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1555.377319, 1513.666992, -14.448036, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1555.377319, 1517.167114, -12.648027, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1555.377319, 1516.916870, -13.648023, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1555.377319, 1518.847290, -14.308029, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1560.458007, 1515.456420, -13.648031, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1561.408935, 1519.857543, -14.308034, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1557.938354, 1520.958251, -13.538030, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1518.069458, -14.378031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1519.939331, -14.378031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.608764, 1518.069458, -14.378031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1517.099609, -13.368020, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1520.130249, -12.618011, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1519.939331, -13.638017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1518.108154, -13.638017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1518.108154, -12.818010, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1519.259277, -12.818010, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1516.139282, -12.818010, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1514.568481, -12.818010, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.718872, 1514.568481, -12.818010, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1520.550659, -13.368020, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1516.107543, -13.718020, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1514.576904, -13.718020, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.698852, 1514.576904, -13.718020, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1557.178833, 1520.358032, -13.608016, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1558.759643, 1520.358032, -13.608016, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1558.759643, 1520.358032, -12.818010, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1557.099365, 1520.358032, -12.818010, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.860839, 1520.130249, -12.628014, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1557.970092, 1520.360473, -12.628014, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.539428, 1517.290527, -13.368023, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.198852, 1517.090332, -13.538025, 180.000000, -90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.198852, 1515.189331, -13.538025, 180.000000, -90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.651123, 1520.360473, -12.628014, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1515.179077, -13.768018, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1515.179077, -15.278022, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1513.598266, -15.278022, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1513.598266, -13.758017, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1514.566894, -16.178030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.738891, 1514.566894, -16.178030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1519.069213, -13.398027, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.181640, 1519.069213, -13.398027, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.079711, -14.378026, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.079711, -13.628021, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.079711, -12.818013, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.059692, -13.998033, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.860839, 1520.550659, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.181152, 1520.550659, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.039672, -13.628021, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1520.039672, -13.628021, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.871337, 1520.039672, -12.818011, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.181640, 1520.039672, -12.818011, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.370727, 1519.259399, -13.398024, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.371215, 1520.400512, -14.178032, 180.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(2154, 1555.761108, 1518.401733, -16.178035, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 3, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(2152, 1555.760131, 1519.773193, -16.178035, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(2155, 1555.754272, 1517.576782, -16.178035, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(1562, 1555.912597, 1516.609252, -15.568028, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 7415, "vgwwelcome", "ws_coppersheet2", 0x00000000);
    ambulance_new = CreateDynamicObject(1562, 1555.912597, 1515.758422, -15.568028, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 7415, "vgwwelcome", "ws_coppersheet2", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1516.238525, -13.718023, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1516.238525, -12.818018, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1514.567382, -12.818018, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1514.567382, -13.718030, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1514.567382, -13.718030, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1516.238403, -13.718030, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1516.238403, -12.818031, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.999145, 1516.078369, -16.178030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.698852, 1516.078369, -16.178030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1515.176147, -13.808030, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1515.176147, -15.778038, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1513.595092, -15.778038, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1513.595092, -13.798030, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1514.567382, -12.818018, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.371826, 1513.795776, -15.208032, 90.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.371826, 1513.795776, -13.758028, 90.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.191650, 1514.567382, -16.168031, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1514.567382, -16.168031, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.371826, 1514.986816, -15.208032, 90.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.371826, 1514.986816, -13.758029, 90.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(2155, 1560.164794, 1517.406616, -16.178035, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(2152, 1560.161499, 1518.782226, -16.178035, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(2152, 1560.161499, 1520.153198, -16.178035, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "whiteforletters", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.850830, 1517.210083, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.220092, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.069946, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.089965, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.119995, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.150024, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.200073, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.561523, 1517.170043, -13.398031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.571899, 1516.058837, -13.728032, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.141113, 1517.210083, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.850830, 1517.079956, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.181152, 1517.079956, -13.398030, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.642089, 1514.977783, -13.748026, 180.000000, 180.000000, 450.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.652099, 1517.067626, -13.548024, 180.000000, 270.000000, 450.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1556.691284, 1513.995361, -14.688032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1556.691284, 1514.756103, -14.688032, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1559.143310, 1514.786132, -14.688032, 0.000000, 0.000000, -89.999969, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1559.143310, 1514.015380, -14.688032, 0.000000, 0.000000, -89.999969, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.989135, 1514.691284, -14.968025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.989135, 1514.100708, -14.968025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.989135, 1514.390991, -14.468018, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.989135, 1514.390991, -14.228013, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.850585, 1514.390991, -14.228013, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.850585, 1514.390991, -14.478016, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.850219, 1514.691284, -14.968025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.850219, 1514.100708, -14.968025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1556.692504, 1515.776733, -13.328027, 0.000000, 90.000000, 90.000030, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(2270, 1559.152709, 1516.497436, -13.328027, 0.000000, 90.000000, 270.000030, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.086181, -15.238031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.676757, -15.238031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.086181, -15.508036, 0.000000, 0.000007, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.676757, -15.508036, 0.000000, 0.000007, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.086181, -15.848045, 0.000000, 0.000014, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1559.848876, 1514.676757, -15.848045, 0.000000, 0.000014, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.991943, 1518.663696, -13.148029, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.991943, 1520.135009, -13.868041, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.991943, 1514.394775, -15.458045, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1555.991943, 1514.394775, -15.928048, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(2146, 1557.976562, 1517.093872, -15.938030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18835, "mickytextures", "smileyface1", 0x00000000);
    ambulance_new = CreateDynamicObject(2146, 1557.976562, 1517.023803, -16.098033, 10.200000, 180.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(1310, 1558.766357, 1520.282592, -14.098025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 11738, "mediccase1", "medicalbox1b", 0x00000000);
    ambulance_new = CreateDynamicObject(1310, 1557.375000, 1520.282592, -14.098025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 11738, "mediccase1", "medicalbox1b", 0x00000000);
    ambulance_new = CreateDynamicObject(19893, 1559.933349, 1518.161743, -15.128030, 0.000000, 0.000000, -80.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 19894, "laptopsamp1", "laptopscreen2", 0x00000000);
    ambulance_new = CreateDynamicObject(1562, 1560.003417, 1516.609252, -15.568028, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 7415, "vgwwelcome", "ws_coppersheet2", 0x00000000);
    ambulance_new = CreateDynamicObject(1562, 1560.003417, 1515.758422, -15.568028, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 7415, "vgwwelcome", "ws_coppersheet2", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1559.851318, 1516.068725, -16.168031, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1560.201660, 1516.068725, -16.168031, 180.000000, 180.000000, 360.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19457, 1557.791015, 1513.449707, -14.473980, 0.000000, 360.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 6871, "vegascourtbld", "courthse2_256", 0x00000000);
    ambulance_new = CreateDynamicObject(19572, 1560.191284, 1520.287231, -15.138028, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 15046, "svcunthoose", "csheistbox01", 0x00000000);
    ambulance_new = CreateDynamicObject(19572, 1560.191284, 1519.836914, -15.138028, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 15046, "svcunthoose", "csheistbox01", 0x00000000);
    ambulance_new = CreateDynamicObject(19832, 1555.839111, 1520.395874, -15.148030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 14600, "paperchase_bits2", "ab_medbag", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1514.389038, -15.118022, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1514.389038, -15.398030, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1514.389038, -15.698037, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1514.389038, -16.018043, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1514.389038, -13.608030, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1516.119506, -13.658031, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1519.819946, -13.848034, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1559.997436, 1519.819946, -14.208044, 90.000000, 90.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1560.007446, 1519.189453, -13.478047, 180.000000, 450.000000, 540.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1560.007446, 1514.288452, -14.318055, 180.000000, 450.000000, 540.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1560.007446, 1514.458618, -14.318055, 180.000000, 450.000000, 540.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1514.488647, -14.318055, 180.000000, 450.000000, 720.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1514.318481, -14.318055, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1514.318481, -15.578056, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1514.488647, -15.578056, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1518.530151, -13.508052, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1518.810424, -13.508052, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1518.680297, -14.298066, 270.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1520.210937, -14.248064, 180.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1558.816284, 1520.498535, -13.518035, 270.000000, 90.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1557.084716, 1520.498535, -13.518035, 270.000000, 90.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19626, 1555.826782, 1514.399658, -13.578063, 270.000000, 450.000000, 1080.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1557.180541, 1518.951171, -12.808021, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1557.180541, 1517.009643, -12.808021, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1557.180541, 1514.947998, -12.808021, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1558.882080, 1518.951171, -12.808021, 0.000000, 0.000007, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1558.882080, 1517.009643, -12.808021, 0.000000, 0.000007, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(957, 1558.882080, 1514.947998, -12.808021, 0.000000, 0.000007, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(3089, 1556.392089, 1513.519653, -14.858031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 19278, "skydiveplatforms", "hazardtile19-2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 19467, "speed_bumps", "speed_bump01", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 3, 18646, "matcolours", "grey-50-percent", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 4, 18646, "matcolours", "grey-50-percent", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 5, 18646, "matcolours", "grey-50-percent", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 6, 18646, "matcolours", "grey-50-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(3089, 1559.372558, 1513.519653, -14.858031, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 19467, "speed_bumps", "speed_bump01", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(2986, 1557.145507, 1513.570312, -14.818025, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(2986, 1558.596435, 1513.570312, -14.818025, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1558.382080, 1516.224853, -16.968050, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1557.591430, 1516.224853, -16.968050, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1557.591430, 1512.735107, -16.968050, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(19438, 1558.382080, 1512.735107, -16.968050, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(19939, 1557.983032, 1517.965332, -16.248058, 180.000000, -90.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 960, "cj_crate_will", "CJ_FLIGHT_CASE", 0x00000000);
    ambulance_new = CreateDynamicObject(1789, 1558.039428, 1520.192749, -15.618021, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(19087, 1558.525878, 1517.982055, -12.098031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
    ambulance_new = CreateDynamicObject(11736, 1558.493408, 1517.953613, -14.218003, -0.600000, 270.000000, 237.499984, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 19523, "sampicons", "reeedgrad32", 0x00000000);
    ambulance_new = CreateDynamicObject(2101, 1558.057739, 1520.194580, -15.208035, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 2, 18835, "mickytextures", "smileyface1", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 3, 18835, "mickytextures", "smileyface1", 0x00000000);
    ambulance_new = CreateDynamicObject(2986, 1558.046386, 1520.542358, -14.688022, 0.000000, 90.000000, 270.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
    ambulance_new = CreateDynamicObject(19893, 1558.053222, 1520.142333, -14.688025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 1, 9818, "ship_brijsfw", "ship_screen1sfw", 0x00000000);
    ambulance_new = CreateDynamicObject(11705, 1558.283447, 1520.222167, -14.908027, 0.000000, 90.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 3, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 6, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(11705, 1557.802978, 1520.222167, -14.898027, 0.000000, 270.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 3, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(ambulance_new, 6, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.328491, 1516.107543, -13.738020, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.328613, 1515.199096, -14.698017, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.328613, 1515.199096, -15.298019, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.338500, 1518.069458, -14.388031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.338500, 1520.029418, -14.388031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.989135, 1521.530517, -14.388031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    ambulance_new = CreateDynamicObject(19940, 1555.768920, 1521.530517, -14.388031, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    SetDynamicObjectMaterial(ambulance_new, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ambulance_new = CreateDynamicObject(11707, 1555.576416, 1519.118408, -14.488027, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11738, 1555.825561, 1517.666992, -15.088027, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11738, 1555.825561, 1517.416748, -15.088027, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11736, 1560.038818, 1517.693725, -15.088025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11736, 1560.038818, 1517.403442, -15.048024, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11736, 1560.038818, 1517.403442, -15.088025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(2690, 1560.271484, 1518.190673, -13.698020, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11728, 1556.817382, 1520.664306, -14.658029, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(19809, 1555.872192, 1520.125000, -15.068025, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(19809, 1555.872192, 1519.824707, -15.068025, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11748, 1558.592529, 1520.345581, -15.238023, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11748, 1558.592529, 1520.195434, -15.238023, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(11723, 1558.584838, 1520.083251, -15.108017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(1785, 1558.045410, 1520.174072, -15.398019, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(1783, 1558.045532, 1520.184082, -15.708026, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(18875, 1559.388671, 1520.556396, -14.788031, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(1008, 1558.536254, 1517.968139, -13.583344, 0.000000, 270.000000, 450.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(1008, 1557.665405, 1520.148193, -15.553356, 0.000000, 270.000000, 720.000000, -1, -1, -1, 1410065408.00, 1410065408.00); 
    ambulance_new = CreateDynamicObject(19472, 1558.486206, 1517.953491, -14.677927, -0.299999, 90.000000, 41.599990, -1, -1, -1, 1410065408.00, 1410065408.00);
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_PASSENGER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);

        if(GetVehicleModel(vehicleid) == 416 && (2 <= GetPlayerVehicleSeat(playerid) <= 4))
        {
            SetPlayerPosEx(playerid, 1557.8597, 1514.3241, -15.3713, vehicleid, 1, true);
            SetCameraBehindPlayer(playerid);
            Player_SetAmbulanceId(playerid, vehicleid);
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
    {
        new vehicleid = Player_AmbulanceId(playerid);

        if(IsValidVehicle(vehicleid))
        {
            new 
                Float:X, Float:Y, Float:Z;
            GetVehiclePos(vehicleid, X, Y, Z);
            
            SetPlayerPosEx(playerid, X + (-0.1012), Y + (-4.2191), Z, 0, 0, false);
            Player_SetAmbulanceId(playerid, INVALID_VEHICLE_ID);
        }
    }
    return 1;
}

hook function ResetPlayerVariables(playerid)
{
    Player_SetAmbulanceId(playerid, INVALID_VEHICLE_ID);
	return continue(playerid);
}
