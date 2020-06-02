#include <YSI\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

#define ROOF_DOWN   0
#define ROOF_UP     1

/*
	######## ##    ## ##     ## ##     ##  ######  
	##       ###   ## ##     ## ###   ### ##    ## 
	##       ####  ## ##     ## #### #### ##       
	######   ## ## ## ##     ## ## ### ##  ######  
	##       ##  #### ##     ## ##     ##       ## 
	##       ##   ### ##     ## ##     ## ##    ## 
	######## ##    ##  #######  ##     ##  ######  
*/
///////////////////////////////////////////////////////////////////

new VehicleRoof[MAX_VEHICLES];
new VehicleRoofObject[MAX_VEHICLES];
new VehicleRoofTimer[MAX_VEHICLES];

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

hook OnVehicleDeath(vehicleid, killerid)
{
	if(VehicleRoof[vehicleid] > 0)
	{
	    DestroyObject(VehicleRoofObject[vehicleid]);
		if(VehicleRoof[vehicleid] == 3)
		{
			KillTimer(VehicleRoofTimer[vehicleid]);
		}
		VehicleRoof[vehicleid] = 0;
	}
	return 1;
}

forward MoveVehicleRoof(vehicleid, roofstatus, roofvar);
public MoveVehicleRoof(vehicleid, roofstatus, roofvar)
{
	new Float:KrovPoz[3];
	new vrVehModel = GetVehicleModel(vehicleid);
    GetVehicleModelInfo(vehicleid, VEHICLE_MODEL_INFO_SIZE, KrovPoz[0], KrovPoz[1], KrovPoz[2]);
	switch(vrVehModel)
	{
		case 536:
		{
		    if(roofstatus == ROOF_DOWN)
		    {
		        if(roofvar == 0)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1], KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1], KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 1);
				}
		        else if(roofvar == 1)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 2);
		        }
		        else if(roofvar == 2)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.2, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.2, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 3);
		        }
		        else if(roofvar == 3)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.4, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.4, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 4);
		        }
		        else if(roofvar == 4)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 5);
		        }
		        else if(roofvar == 5)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 6);
		        }
		        else if(roofvar == 6)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 7);
		        }
		        else if(roofvar == 7)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.10, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.10, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 8);
		        }
		        else if(roofvar == 8)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.20, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.20, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 9);
		        }
		        else if(roofvar == 9)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.35, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.35, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 10);
		        }
		        else if(roofvar == 10)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 11);
		        }
		        else if(roofvar == 11)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 12);
		        }
		        else if(roofvar == 12)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 0.0, 0.0, 0.0);
					DestroyObject(VehicleRoofObject[vehicleid]);
					VehicleRoof[vehicleid] = 0;
					new krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective;
					GetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective);
					SetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, 0, krobjective);
		        }
			}
		    else if(roofstatus == ROOF_UP)
		    {
		        if(roofvar == 0)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 1);
				}
		        else if(roofvar == 1)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 2);

		        }
		        else if(roofvar == 2)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 3);
		        }
		        else if(roofvar == 3)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.35, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.35, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 4);
		        }
		        else if(roofvar == 4)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.20, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.20, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 5);
		        }
		        else if(roofvar == 5)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.10, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.10, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 6);
		        }
		        else if(roofvar == 6)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 7);
		        }
		        else if(roofvar == 7)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 8);
		        }
		        else if(roofvar == 8)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 9);
		        }
		        else if(roofvar == 9)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.4, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.4, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 10);
		        }
		        else if(roofvar == 10)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.2, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.2, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 11);
		        }
		        else if(roofvar == 11)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 12);
		        }
		        else if(roofvar == 12)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1], KrovPoz[2], 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1], KrovPoz[2], 0.0, 0.0, 0.0);
					VehicleRoof[vehicleid] = 1;
					new krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective;
					GetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective);
					SetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, 0, krobjective);
		        }
			}
		}
		case 567:
		{
		    if(roofstatus == ROOF_DOWN)
		    {
		        if(roofvar == 0)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]+0.3, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]+0.3, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 1);
				}
		        else if(roofvar == 1)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]+0.2, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]+0.2, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 2);

		        }
		        else if(roofvar == 2)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 3);
		        }
		        else if(roofvar == 3)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.3, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.3, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 4);
		        }
		        else if(roofvar == 4)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 5);
		        }
		        else if(roofvar == 5)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 6);
		        }
		        else if(roofvar == 6)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 7);
		        }
		        else if(roofvar == 7)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.26, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.26, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 8);
		        }
		        else if(roofvar == 8)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.30, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.30, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 9);
		        }
		        else if(roofvar == 9)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.40, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2]-0.40, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 10);
		        }
		        else if(roofvar == 10)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 11);
		        }
		        else if(roofvar == 11)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_DOWN, 12);
		        }
		        else if(roofvar == 12)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 0.0, 0.0, 0.0);
					DestroyObject(VehicleRoofObject[vehicleid]);
					VehicleRoof[vehicleid] = 0;
					new krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective;
					GetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective);
					SetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, 0, krobjective);
		        }
			}
		    else if(roofstatus == ROOF_UP)
		    {
		        if(roofvar == 0)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.70, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 1);
				}
		        else if(roofvar == 1)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.60, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 2);
		        }
		        else if(roofvar == 2)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.50, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 3);
		        }
		        else if(roofvar == 3)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.40, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.40, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 4);
		        }
		        else if(roofvar == 4)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.30, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.30, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 5);
		        }
		        else if(roofvar == 5)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.26, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-1.0, KrovPoz[2]-0.26, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 6);
		        }
		        else if(roofvar == 6)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.8, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 7);
		        }
		        else if(roofvar == 7)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.7, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 8);
		        }
		        else if(roofvar == 8)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.5, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 9);
		        }
		        else if(roofvar == 9)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.3, KrovPoz[2]-0.24, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.3, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 10);
		        }
		        else if(roofvar == 10)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]-0.1, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 11);
		        }
		        else if(roofvar == 11)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]+0.2, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]+0.2, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoofTimer[vehicleid] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vehicleid, ROOF_UP, 12);
		        }
		        else if(roofvar == 12)
		        {
					MoveObject(VehicleRoofObject[vehicleid], KrovPoz[0], KrovPoz[1]+0.3, KrovPoz[2]-0.25, 2.0, 0, 0, 0);
					AttachObjectToVehicle(VehicleRoofObject[vehicleid], vehicleid, KrovPoz[0], KrovPoz[1]+0.3, KrovPoz[2]-0.25, 0.0, 0.0, 0.0);
					VehicleRoof[vehicleid] = 1;
					new krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective;
					GetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, krboot, krobjective);
					SetVehicleParamsEx(vehicleid, krengine, krlights, kralarm, krdoors, krbonnet, 0, krobjective);
		        }
		    }
		}
	}
	return 1;
}

/*
	 ######  ##     ## ########   ######  
	##    ## ###   ### ##     ## ##    ## 
	##       #### #### ##     ## ##       
	##       ## ### ## ##     ##  ######  
	##       ##     ## ##     ##       ## 
	##    ## ##     ## ##     ## ##    ## 
	 ######  ##     ## ########   ######  
*/
///////////////////////////////////////////////////////////////////

CMD:vr(playerid,params[])
{
	new RoofString[128], Float:vKrovPos[3];
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Moras biti u kabrioletu i moras biti vozac!");
	new vrVehicle = GetPlayerVehicleID(playerid);
	new vrVehModel = GetVehicleModel(vrVehicle);
	if(vrVehModel == 536)
	{
		if(VehicleRoof[vrVehicle] == 0)
		{
			VehicleRoofObject[vrVehicle] = CreateObject(1128, vKrovPos[0], vKrovPos[1], vKrovPos[2], 0, 0, 0);
			AttachObjectToVehicle(VehicleRoofObject[vrVehicle], vrVehicle, vKrovPos[0], vKrovPos[1]-1.0, vKrovPos[2]-0.75, 0.0, 0.0, 0.0);
			new VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective;
			GetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective);
			SetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, 1, VRobjective);
			VehicleRoofTimer[vrVehicle] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vrVehicle, ROOF_UP, 0);
			VehicleRoof[vrVehicle] = 3;
			format(RoofString,sizeof(RoofString),"** %s podize krov na vozilu.", GetName(playerid, true));
			ProxDetector(15.0, playerid, RoofString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else if(VehicleRoof[vrVehicle] == 1)
		{
			new VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective;
			GetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective);
			SetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, 1, VRobjective);
			VehicleRoofTimer[vrVehicle] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vrVehicle, ROOF_DOWN, 0);
			VehicleRoof[vrVehicle] = 3;
			format(RoofString,sizeof(RoofString),"** %s spusta krov na vozilu.", GetName(playerid, true));
			ProxDetector(15.0, playerid, RoofString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else return SendErrorMessage(playerid, "Gumb nije u funkciji dok se krov dize/spusta!");
	}
	else if(vrVehModel == 567)
	{
		if(VehicleRoof[vrVehicle] == 0)
		{
			VehicleRoofObject[vrVehicle] = CreateObject(1131, vKrovPos[0], vKrovPos[1]-1.0, vKrovPos[2]-0.75, 0, 0, 0);
			AttachObjectToVehicle(VehicleRoofObject[vrVehicle], vrVehicle, vKrovPos[0], vKrovPos[1]-1.0, vKrovPos[2]-0.75, 0.0, 0.0, 0.0);
			new VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective;
			GetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective);
			SetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, 1, VRobjective);
			VehicleRoofTimer[vrVehicle] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vrVehicle, ROOF_UP, 0);
			VehicleRoof[vrVehicle] = 3;
			format(RoofString,sizeof(RoofString),"** %s podize krov na vozilu.", GetName(playerid, true));
			ProxDetector(15.0, playerid, RoofString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else if(VehicleRoof[vrVehicle] == 1)
		{
			new VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective;
			GetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, VRboot, VRobjective);
			SetVehicleParamsEx(vrVehicle, VRengine, VRlights, VRalarm, VRdoors, VRbonnet, 1, VRobjective);
			VehicleRoofTimer[vrVehicle] = SetTimerEx("MoveVehicleRoof", 100, false, "iii", vrVehicle, ROOF_DOWN, 0);
			VehicleRoof[vrVehicle] = 3;
			format(RoofString,sizeof(RoofString),"** %s spusta krov na vozilu.", GetName(playerid, true));
			ProxDetector(15.0, playerid, RoofString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else return SendErrorMessage(playerid, "Gumb nije u funkciji dok se krov dize/spusta!");
	}
	else return SendErrorMessage(playerid, "Ovo vozilo nije kabriolet i/ili nema pomjerajuci krov!");
	return 1;
}


