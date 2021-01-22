#include <YSI_Coding\y_hooks>

#define MAX_WOODS (46)
#define MAX_D_WOODS (10)


#define TREE_RESPAWN_TIME (15)
#define PLAYER_TREE_RANGE (5.0)
#define TREE_RENDER_DIST  (150.0)
#define CP_DIST_FROM_TREE (5.0)
#define CP_TREE_SIZE      (2.0)

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

enum wlogger
{
	objid,
	cpid,
	bool:cut,
	pCutting,
	w_type,
	height
};
new
	TreeeInfo[MAX_WOODS][wlogger];
	
enum wcar
{
	wobjid,
	wop,
	wood[5],
	wType[5]
};
new
	CarWoodInfo[MAX_VEHICLES][wcar];
	
enum gwood
{
	oid,
	Text3D:l_id,
	wamount,
	wood,
	Float:dwx,
	Float:dwy,
	Float:dwz
};
new
	DroppedWoodInfo[MAX_WOODS][gwood];
	
new
	CuttingTree[MAX_PLAYERS] = -1,
	Timer:TreeT[MAX_PLAYERS],
	CutTreeSec[MAX_PLAYERS],
	pWood[MAX_PLAYERS],
	pWoodT[MAX_PLAYERS],
	lobj,
	loggerinfo;

/*
          				   _____  _____        __     _______
				     /\   |  __ \|  __ \     /\\ \   / / ____|
				    /  \  | |__) | |__) |   /  \\ \_/ / (___
				   / /\ \ |  _  /|  _  /   / /\ \\   / \___ \
				  / ____ \| | \ \| | \ \  / ____ \| |  ____) |
				 /_/    \_\_|  \_\_|  \_\/_/    \_\_| |_____/


*/

static const Float:trees[][] =
{
	// SF border trees

	//     x,          y,        z,      rot:z //
	{-91.00591, -1528.11609, 1.50980, -50.10001},
	{-106.48734, -1514.28210, 1.80185, 46.50000},
	{-117.45097, -1561.54602, 1.18272, 129.72000},
	{-102.44973, -1545.69031, 1.22688, -162.71999},
	{-140.97832, -1527.03687, 2.97665, -132.89999},
	{-156.64542, -1538.16748, 3.78519, 114.84002},
	{-135.04800, -1548.26978, 2.44224, 57.90000},
	{-156.35197, -1563.54712, 5.30083, -139.68001},
	{-129.42844, -1573.70105, 7.03853, -11.16001},
	{-145.33432, -1588.98267, 5.84520, -75.12001},
	{-152.92361, -1606.70654, 3.98641, -135.53999},
	{-134.26543, -1606.59277, 2.46368, -33.06002},
	{-118.65700, -1590.11328, 1.29762, -98.40001},
	{-108.09039, -1605.01208, 0.95525, -102.12001},
	{-162.41360, -1588.48120, 6.09790, -39.79999},
	{-128.01320, -1503.96082, 2.19536, 50.50005},//
	{-122.97722, -1527.89832, 1.29356, -45.48000},
	//NEAR PC RED BRIDGE
	{1800.24792, 120.86967, 31.34285, 0.00000},
	{1829.45837, 126.25150, 33.48490, 126.30000},//
	{1825.77637, 103.34960, 32.29220, 76.48000},
	{1855.52405, 120.72490, 33.03920, 215.42000},
	{1851.91992, 94.35030, 32.58210, 158.39999},
	{1883.30786, 126.18030, 34.34398, 62.75998},
	{1885.07092, 87.24130, 31.58095, 73.20000},
	{1917.47302, 111.41370, 32.25159, 155.75990},
	{1875.27466, 105.92770, 33.30102, 219.41995},
	{1911.57483, 82.59955, 29.99426, 28.67999},
	{1937.49731, 103.46194, 29.22683, 35.40001},
	{1898.57153, 107.45400, 33.04240, 129.53999},
	{1934.95459, 81.46233, 28.11582, 29.69999},
	{1955.95679, 99.55940, 28.06270, 67.02000},
	{1965.70325, 77.34610, 27.05930, 111.84000},
	{1983.63477, 93.69569, 28.32733, 75.18002},
	{1996.72778, 74.70792, 28.24112, 32.15999},
	{2021.46680, 82.84127, 28.53037, 141.12000},
	// Near LS HIGHWAY
	{1763.48523, -821.66003, 59.39035, 177.90004},
	{1784.11938, -837.39838, 64.34120, 131.46021},
	{1776.75781, -858.48950, 61.63320, 49.98020},
	{1778.35303, -811.73309, 60.38133, 170.28030},
	{1796.36536, -855.78253, 64.14286, 250.68019},
	{1800.48657, -804.22437, 66.83697, 134.88029},
	{1798.87646, -824.90991, 66.35052, 135.06020},
	{1810.08105, -846.10571, 66.35470, 47.76020},
	{1829.46497, -839.06897, 69.58420, 57.42020},
	{1820.04211, -821.74377, 71.74680, 179.64020},
	{1764.41321, -842.58990, 60.09640, 115.14030}

};
// MAYBE


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
	CreateTrees();
	
	for(new i = 0; i != sizeof(trees); ++i) TreeeInfo[i][pCutting] = -1;
	
	loggerinfo = CreatePickup(1239, 2, -534.7875, -183.1030, 78.4063, 0);

	return 1;
}

hook OnPlayerConnect(playerid)
{
    CuttingTree[playerid] = -1;
	RemoveOldTrees(playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(CuttingTree[playerid] != -1)
	{
		RespawnTree(CuttingTree[playerid]);
		TreeeInfo[CuttingTree[playerid]][pCutting] = -1;
		ResetTreeVars(playerid);

		if(CutTreeSec[playerid] != 0)
			stop TreeT[playerid];
	}
	if(pWood[playerid])
	{
		DropWood(playerid);
		pWood[playerid] = 0;
		pWoodT[playerid] = 0;
	}
	return 1;
}

hook OnDynamicObjectMoved(objectid)
{
	for(new i = 0; i != sizeof(trees); ++i)
	{
	    if(objectid == TreeeInfo[i][objid])
	    {
			new
			    Float:x,
			    Float:y;

	        GetXYInFrontOfObject(TreeeInfo[i][objid], x, y, CP_DIST_FROM_TREE);
			TreeeInfo[i][cpid] = CreateDynamicCP(x, y, trees[i][2], CP_TREE_SIZE, -1, -1, TreeeInfo[i][pCutting]);
			SendClientMessage(TreeeInfo[i][pCutting], COLOR_RED, "[!] Oti�i do checkpointa kako bi nastavio posao!");
		}
	}
	return 1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(CuttingTree[playerid] != -1)
	{
	    if(TreeeInfo[CuttingTree[playerid]][pCutting] == playerid && TreeeInfo[CuttingTree[playerid]][cpid] == checkpointid)
	    {
			new
				Float:x,
				Float:y;

			GetXYInFrontOfObject(TreeeInfo[CuttingTree[playerid]][objid], x, y, CP_DIST_FROM_TREE);
			SetPlayerLookAt(playerid, x, y);
			TogglePlayerControllable(playerid, 0);
			
			CutTreeSec[playerid] = 30;
			
			SetPlayerAttachedObject(playerid, 9, 341, 6, -0.009999, -0.010999, -0.038000); // 1463
			SetPlayerAttachedObject(playerid, 8, 18736, 6, 0.378998, 0.005999, -1.645998, 0.000000, 0.000000, 130.500045);
			
			ApplyAnimationEx(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 0, 0, 1, 0);
			
			TreeT[playerid] = repeat CutTree[1000](playerid, CuttingTree[playerid], true);
			
			//cmd_me(playerid, "zapo�inje rezati drva na komade.");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(((newkeys & KEY_JUMP) || (newkeys & KEY_CROUCH)) && pWood[playerid])
	{
		if(DropWood(playerid))
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Drva su vam ispala na pod!");
		else
		    ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1, 0), SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PlayerJob[playerid][pJob] == JOB_LOGGER)
	{
		if(pWood[playerid])
		{
			if(DropWood(playerid))
				SendMessage(playerid, MESSAGE_TYPE_ERROR, "Drva su vam ispala na pod!");
			else
				TogglePlayerControllable(playerid, 1), ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1, 0), SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		}
		if(CuttingTree[playerid] != -1)
			cmd_stopcuttree2(playerid);
	}
    return 1;
}

hook OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == loggerinfo)
	{
	    GameTextForPlayer(playerid, "Koristi /sellwood kako bi prodao drva!", 2000, 3);
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	if(RemoveWoodFromVehicle(vehicleid))
	    SendClientMessage(killerid, COLOR_RED, "[!] UniStili ste vsSe vozilo te su drva iz njega unistena.");

	return 1;
}

DropWood(playerid)
{
	if(!pWood[playerid])
		return 0;
		
	for(new w = 0; w != MAX_D_WOODS; ++w)
	{
	    if(DroppedWoodInfo[w][wamount] == 0)
	    {
			DroppedWoodInfo[w][wamount] = pWood[playerid];
			DroppedWoodInfo[w][wood] = pWoodT[playerid];
			
			new
			    Float:a;
			    
			GetPlayerPos(playerid, DroppedWoodInfo[w][dwx], DroppedWoodInfo[w][dwy], DroppedWoodInfo[w][dwz]);
			GetPlayerFacingAngle(playerid, a);
			
			RemovePlayerAttachedObject(playerid, 9);
			
			DroppedWoodInfo[w][oid] = CreateDynamicObject(1463, DroppedWoodInfo[w][dwx], DroppedWoodInfo[w][dwy], DroppedWoodInfo[w][dwz] - 1.0, 0.0, 0.0, a, -1, -1, -1, TREE_RENDER_DIST);


			new
			    l_str[76];
			    
			format(l_str, sizeof(l_str), "Kucajte /pickupwood da bi pokupili drva!\n\n%s[%d]", GetWoodName(DroppedWoodInfo[w][wood]), DroppedWoodInfo[w][wamount]);
			DroppedWoodInfo[w][l_id] = Create3DTextLabel(l_str, COLOR_LIGHTBLUE, DroppedWoodInfo[w][dwx], DroppedWoodInfo[w][dwy], DroppedWoodInfo[w][dwz], 10.0, 0, 0);

			pWood[playerid] = 0;
			pWoodT[playerid] = 0;
			return 1;
		}
	}
	return 0;
}

PickupDroppedWood(playerid, dwid)
{
	if(pWood[playerid])
		return 0;
		
	pWood[playerid] = DroppedWoodInfo[dwid][wamount];
	pWoodT[playerid] = DroppedWoodInfo[dwid][wood];
	
	if(IsValidDynamicObject(DroppedWoodInfo[dwid][oid]))
	    DestroyDynamicObject(DroppedWoodInfo[dwid][oid]);
	    
 	Delete3DTextLabel(DroppedWoodInfo[dwid][l_id]);
	
	DroppedWoodInfo[dwid][wamount] = 0;
	DroppedWoodInfo[dwid][wood] = 0;
	DroppedWoodInfo[dwid][dwx] = 0;
	DroppedWoodInfo[dwid][dwy] = 0;
	DroppedWoodInfo[dwid][dwz] = 0;
	
	SetPlayerAttachedObject(playerid, 9, 1463, 6, 0.093999, 0.148000, -0.175000, -106.200126, -3.499998, 81.799995, 0.528000, 0.406000, 0.534999);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1, 0);
	return 1;
}

IsCloseToDroppedWood(playerid)
{
	for(new dw; dw != MAX_D_WOODS; ++dw)
	{
		if(DroppedWoodInfo[dw][wamount] && IsPlayerInRangeOfPoint(playerid, 2.0, DroppedWoodInfo[dw][dwx], DroppedWoodInfo[dw][dwy], DroppedWoodInfo[dw][dwz]))
  			return dw;
	}
	return -1;
}

CreateTrees()
{
	for(new t = 0; t != sizeof(trees); ++t)
	{
		TreeeInfo[t][w_type] = minrand(1, 5);
		TreeeInfo[t][height] = 9 + random(20 - 9);
		
		TreeeInfo[t][objid] = CreateDynamicObject(617, trees[t][0], trees[t][1], trees[t][2], 0.0, 0.0, trees[t][3], -1, -1, -1, TREE_RENDER_DIST);
	}
	return;
}

RemoveOldTrees(playerid)
{
	//SF GRANICA LS SM BEACH
	RemoveBuildingForPlayer(playerid, 790, -203.4766, -1617.3516, 5.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 693, -184.8750, -1587.8516, 8.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 790, -141.2813, -1618.9531, 5.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 790, -130.3203, -1602.4922, 5.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 670, -141.8906, -1584.0156, 6.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 670, -111.7734, -1553.6875, 2.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 693, -81.5625, -1522.3828, 5.6875, 0.25);
	
	//NEAR PC BRIDGE
	RemoveBuildingForPlayer(playerid, 790, 1988.6328, 80.2734, 32.7578, 0.25);
	
	//NEAR HIGHWAY
	RemoveBuildingForPlayer(playerid, 617, 1726.9844, -826.2109, 56.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 617, 1849.3672, -807.4453, 76.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 617, 1732.3516, -799.3281, 54.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 617, 1724.1172, -746.0234, 50.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 617, 1847.8047, -946.3359, 49.2422, 0.25);
}

GetPlayerNearTreeID(playerid)
{
	for(new t = 0; t != sizeof(trees); ++t)
 	{
	    if(IsPlayerInRangeOfPoint(playerid, PLAYER_TREE_RANGE, trees[t][0], trees[t][1], trees[t][2]) && !TreeeInfo[t][cut])
			return t;
 	}
	return -1;
}

ResetTreeVars(playerid)
{
	if(IsValidDynamicCP(TreeeInfo[CuttingTree[playerid]][cpid]))
		DestroyDynamicCP(TreeeInfo[CuttingTree[playerid]][cpid]);
	if(IsValidDynamicObject(TreeeInfo[CuttingTree[playerid]][objid]))
	 	DestroyDynamicObject(TreeeInfo[CuttingTree[playerid]][objid]);
	
	TreeeInfo[CuttingTree[playerid]][pCutting] = -1;
	CuttingTree[playerid] = -1;
	stop TreeT[playerid];
}

GetWoodName(wtype)
{
	new
 		wname[7];

	switch(wtype)
	{
	    case 1: strcpy(wname, "Javor", sizeof(wname));
	    case 2: strcpy(wname, "Hrast", sizeof(wname));
	    case 3: strcpy(wname, "Jela", sizeof(wname));
	    case 4: strcpy(wname, "Bukva", sizeof(wname));
	    case 5: strcpy(wname, "Bor", sizeof(wname));
	    case 6: strcpy(wname, "Kesten", sizeof(wname));
	    default: strcpy(wname, "Prazno", sizeof(wname));
	}
	return wname;
}

PutWoodInVehFreeSlot(vehid, amount, wtype)
{
	for(new i = 0; i != 5; ++i)
	{
	    if(CarWoodInfo[vehid][wood][i] == 0)
		{
		    CarWoodInfo[vehid][wood][i] = amount;
		    CarWoodInfo[vehid][wType][i] = wtype;

			if(!IsValidObject(CarWoodInfo[vehid][wobjid]))
				AttachWoodToVehicle(vehid);

			return 1;
		}
	}
	return 0;
}

AttachWoodToVehicle(vehid)
{
	new
	    vehm = GetVehicleModel(vehid);

	if(IsALoggerVehicle(vehm))
    	CarWoodInfo[vehid][wobjid] = CreateObject(1463, 0, 0, 0, 0, 0, 0, 80);
    	
	switch(vehm)
	{
		case 422: AttachObjectToVehicle(CarWoodInfo[vehid][wobjid], vehid, 0.000000, -1.300000, 0.200000, 0.000000, 0.000000, 0.000000);
		case 478: AttachObjectToVehicle(CarWoodInfo[vehid][wobjid], vehid, 0.000000, -1.700000, 0.200000, 0.000000, 0.000000, 0.000000);
		case 543: AttachObjectToVehicle(CarWoodInfo[vehid][wobjid], vehid, 0.000000, -1.700000, 0.400000, 0.000000, 0.000000, 0.000000);
		case 600: AttachObjectToVehicle(CarWoodInfo[vehid][wobjid], vehid, 0.000000, -1.700000, 0.500000, 0.000000, 0.000000, 0.000000);
		case 554: AttachObjectToVehicle(CarWoodInfo[vehid][wobjid], vehid, 0.000000, -1.300000, 0.500000, 0.000000, 0.000000, 0.000000);
		default: return 0;
	}
	return 1;
}

IsALoggerVehicle(modelid)
{
	switch(modelid)
	{
		case 422: return 1;
		case 478: return 1;
		case 543: return 1;
		case 600: return 1;
		case 554: return 1;
		default: return 0;
	}
	return 1;
}

RemoveWoodFromVehicle(vehid)
{
	for(new i = 0; i != 5; ++i)
	{
	    if(CarWoodInfo[vehid][wood][i] != 0)
		{
		    CarWoodInfo[vehid][wood][i] = 0;
		    CarWoodInfo[vehid][wType][i] = 0;
			return 1;
		}
	}
	
	if(IsValidObject(CarWoodInfo[vehid][wobjid]))
		DestroyObject(CarWoodInfo[vehid][wobjid]);

	return 0;
}

CreateLeaves(lid)
{
	if(IsValidObject(lobj))
	    DestroyObject(lobj);

	lobj = CreateObject(18734, trees[lid][0], trees[lid][1], trees[lid][2] + 4, 0.0, 0.0, trees[lid][3], TREE_RENDER_DIST);
	return 1;
}
/*
					  _______ _____ __  __ ______ _____   _____
					 |__   __|_   _|  \/  |  ____|  __ \ / ____|
					    | |    | | | \  / | |__  | |__) | (___
					    | |    | | | |\/| |  __| |  _  / \___ \
					    | |   _| |_| |  | | |____| | \ \ ____) |
					    |_|  |_____|_|  |_|______|_|  \_\_____/

*/

timer CutTree[1000](playerid, id, bool:situation)
{
	if(CuttingTree[playerid] != id)
	{
	    stop TreeT[playerid];
	    return 0;
	}
	    
    static
		cstr[34];
		
	format(cstr, sizeof(cstr), "~w~Preostalo %s%d ~w~sekundi.", (situation) ? ("~r~") : ("~g~"), CutTreeSec[playerid]);
	GameTextForPlayer(playerid, cstr, 1000, 3);

	switch(situation)
	{
	    case false:
		{
			if(-- CutTreeSec[playerid] <= 0)
			{
  				MoveDynamicObject(TreeeInfo[id][objid], trees[id][0] + 0.1, trees[id][1] + 0.1, trees[id][2], 0.1, 76.0, 0.0, trees[id][3]);

				SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prerezali ste drvo!");
				
				ClearAnimations(playerid, 1);
				
				TogglePlayerControllable(playerid, 1);
				
				RemovePlayerAttachedObject(playerid, 8);
				RemovePlayerAttachedObject(playerid, 9);
				
				defer RespawnTree(id);
				
				stop TreeT[playerid];
			    return 1;
			}
			CreateLeaves(id);
	    }
	    case true:
	    {
	        if(IsPlayerInRangeOfPoint(playerid, 20.0, trees[id][0], trees[id][1], trees[id][2]))
	        {
				if(-- CutTreeSec[playerid] <= 0)
				{
				    SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prerezali ste drva na komade! Utovarite drva u vase vozilo.");
				    stop TreeT[playerid];

                    ClearAnimations(playerid, 1);

					TogglePlayerControllable(playerid, 1);
                    
                    pWood[playerid] = TreeeInfo[id][height] * 10;
                    pWoodT[playerid] = TreeeInfo[id][w_type];
                    
                    TreeeInfo[id][cut] = true;
                    
					if(IsValidDynamicCP(TreeeInfo[id][cpid]))
	    				DestroyDynamicCP(TreeeInfo[id][cpid]);
	    				
                    if(IsValidDynamicObject(TreeeInfo[id][objid]))
	 					DestroyDynamicObject(TreeeInfo[id][objid]);

					ResetTreeVars(playerid);
					
					RemovePlayerAttachedObject(playerid, 8);
					RemovePlayerAttachedObject(playerid, 9);

					SetPlayerAttachedObject(playerid, 9, 1463, 6, 0.093999, 0.148000, -0.175000, -106.200126, -3.499998, 81.799995, 0.528000, 0.406000, 0.534999);
					ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1, 0);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		
					return 1;
				}
	        }
	        else
	        {
	            SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Prekinuli ste posao!");
	            cmd_stopcuttree2(playerid);
	        }
	    }
	}
	return 0;
}

timer RespawnTree[TREE_RESPAWN_TIME * 60 * 1000](treeid)
{
	if(TreeeInfo[treeid][cut] != true)
	    return 0;
		
	TreeeInfo[treeid][objid] = CreateDynamicObject(617, trees[treeid][0], trees[treeid][1], trees[treeid][2], 0.0, 0.0, trees[treeid][3], -1, -1, -1, TREE_RENDER_DIST);

	TreeeInfo[treeid][cut] = false;
	TreeeInfo[treeid][w_type] = minrand(1, 5);
	TreeeInfo[treeid][height] = 9 + random(20 - 9);
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

CMD:cuttree(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosjeca!");
		
    if(PlayerJob[playerid][pFreeWorks] < 1)
		return SendClientMessage( playerid, COLOR_RED, "Ne mozes vise raditi, pricekajte Pay Day!");
	    
	if(IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes to raditi dok si u vozilu!");

	if(CuttingTree[playerid] != -1)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ve� rezete drvo!");

	if(pWood[playerid])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prvo spremite vasa drva u vozilo!");
        
	new
	    id = GetPlayerNearTreeID(playerid);
	    
	if(id != -1)
	{

		if(TreeeInfo[id][pCutting] != -1)
		    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko reze ovo drvo!");

		TreeeInfo[id][pCutting] = playerid;
		CuttingTree[playerid] = id;
		printf("ID:%d, CuttingTree[playerid]:%d", id, CuttingTree[playerid]);
		CutTreeSec[playerid] = 60;
		Player_SetIsWorkingJob(playerid, true);

		TreeT[playerid] = repeat CutTree[1000](playerid, id, false);
		
		for(new a = 8; a != 9; ++a)
		{
		    if(IsPlayerAttachedObjectSlotUsed(playerid, a))
                RemovePlayerAttachedObject(playerid, a);
		}
		SetPlayerAttachedObject(playerid, 9, 341, 6, -0.009999, -0.010999, -0.038000); // 1463
		SetPlayerAttachedObject(playerid, 8, 18736, 6, 0.378998, 0.005999, -1.645998, 0.000000, 0.000000, 130.500045);
		
		SetPlayerLookAt(playerid, trees[id][0], trees[id][1]);

		TogglePlayerControllable(playerid, 0);
		
		ApplyAnimationEx(playerid, "CHAINSAW", "WEAPON_csaw", 1.0, 1, 0, 0, 0, 0, 1, 0);
		//cmd_me(playerid, "vadi motorku te je potom pali i zapo�inje s rezanjem drveta.");
	}
	else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu drveta!");
	return 1;
}

CMD:stopcuttree(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");
		
    if(CuttingTree[playerid] == -1)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vi ne reZete drvo!");

	cmd_stopcuttree2(playerid);
	return 1;
}

cmd_stopcuttree2(playerid)
{
	RemovePlayerFromVehicle(playerid);
	ResetTreeVars(playerid);
	stop TreeT[playerid];

	RemovePlayerAttachedObject(playerid, 8);
	RemovePlayerAttachedObject(playerid, 9);

	Player_SetIsWorkingJob(playerid, false);
    TogglePlayerControllable(playerid, 1);
    ClearAnimations(playerid, 1);
	return 1;
}

CMD:treeinfo(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	new
	    id = GetPlayerNearTreeID(playerid);

	if(id == -1)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu nikojeg drveta!");
		
	static
	    tstr[55];
	    
	format(tstr, sizeof(tstr), "[!] Drvo u koje gledate je %s i visine je %dm!", GetWoodName(TreeeInfo[id][w_type]), TreeeInfo[id][height]);
	SendClientMessage(playerid, COLOR_WHITE, tstr);
	//cmd_me(playerid, "baca pogled na drvo te ga potom detaljno pregledava.");
	return 1;
}

CMD:gototree(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate pristupa ovoj komandi!");
	    
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_RED, "KORISTI: /gototree [0 - 45]");

	new
		trid = strval(params);

	if(trid < 0 || trid > 45)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Drvo ne moZe biti manje od 0 ni ve�e od 45!");

	SetPlayerPos(playerid, trees[strval(params)][0], trees[strval(params)][1] + 2, trees[strval(params)][2]);
	return 1;
}

CMD:putwood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	if(!pWood[playerid])
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate drva za spremiti u vozilo!");

	new
	    vid;

	if((vid = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB)) != INVALID_VEHICLE_ID)
	{
		new
			vm = GetVehicleModel(vid);
			
		if(!IsALoggerVehicle(vm))
		    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZete staviti drva u ovo vozilo!");

		if(VehicleInfo[vid][vTrunk] == VEHICLE_PARAMS_OFF)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Gepek vozila nije otvoren!");

		if(!PutWoodInVehFreeSlot(vid, pWood[playerid], pWoodT[playerid]))
	 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi slotovi u vozilu su popunjeni!");
	
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Stavili ste nekoliko komada drva u vaSe vozilo!");
		
        ApplyAnimationEx(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1, 0);
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

		pWood[playerid] = 0;
		pWoodT[playerid] = 0;
		//cmd_me(playerid, "stavlja drva u vozilo.");
		ClearAnimations(playerid, 1);
	}
	else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu nikojeg vozila!");
	return 1;
}

CMD:checkvehwood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZeS to raditi dok si u vozilu!");

	new vid = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB);
	if(vid == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid,COLOR_RED, "Niste blizu vozila!");
	
	new
		vm = GetVehicleModel(vid);

	if(VehicleInfo[vid][vTrunk] == VEHICLE_PARAMS_OFF)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Gepek vozila je zatvoren!");
		
	if(!IsALoggerVehicle(vm))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema drva!");

	static
		vstr[21];

	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Trenutna koli�ina drva u vozilu u svim slotovima:");
	for(new i = 0; i != 5; ++i)
	{
		format(vstr, sizeof(vstr), "Slot %d: %s[%d]", i + 1, GetWoodName(CarWoodInfo[vid][wType][i]), CarWoodInfo[vid][wood][i]);
		SendClientMessage(playerid, COLOR_WHITE, vstr);
	}
	//cmd_me(playerid, "baca pogled unutar gepeka.");
	return 1;
}

CMD:checkmywood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	if(!pWood[playerid])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate drva kod sebe!");

	static
	    wstr[11];

	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Trenutna koli�ina drva koje nosite:");
	format(wstr, sizeof(wstr), "%s[%d]", GetWoodName(pWoodT[playerid]), pWood[playerid]);
	SendClientMessage(playerid, COLOR_WHITE, wstr);
	return 1;
}

CMD:pickupwood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZeS to raditi dok si u vozilu!");

	new
	    wid;

	if((wid = IsCloseToDroppedWood(playerid)) != -1)
	{
		if(PickupDroppedWood(playerid, wid))
			return SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Sakupio si drva s poda! Odnesi ih i spremi ih u vozilo!"), SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		else
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ve� imaS drva u rukama prvo ih spremi prije nego sakupiS ova!");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu ba�enih drva!");

	return 1;
}

CMD:takewood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosje�a!");

	if(pWood[playerid])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ve� nosite drva!");
		
	if(IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne moZeS to raditi dok si u vozilu!");

	new vid = GetNearestVehicle(playerid, VEHICLE_USAGE_JOB);
	if(vid == INVALID_VEHICLE_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila!");
	if(VehicleInfo[vid][vTrunk] == VEHICLE_PARAMS_OFF)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Gepek vozila je zatvoren!");
	
	new slot;
	if(sscanf(params, "d", slot))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /takewood [slot]");
	if(slot <= 0 || slot >= 6)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Slot vozila ne moZe biti manji od 1 ni veci od 5!");
		
	slot -= 1;
		
	if(CarWoodInfo[vid][wood][slot] == 0)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj slot je prazan!");

	pWood[playerid] = CarWoodInfo[vid][wood][slot];
	pWoodT[playerid] = CarWoodInfo[vid][wType][slot];
	
	CarWoodInfo[vid][wood][slot] = 0;
	CarWoodInfo[vid][wType][slot] = 0;

	if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
		RemovePlayerAttachedObject(playerid, 9);

	SetPlayerAttachedObject(playerid, 9, 1463, 6, 0.093999, 0.148000, -0.175000, -106.200126, -3.499998, 81.799995, 0.528000, 0.406000, 0.534999);
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	
	static
		takestr[47];
		
	format(takestr, sizeof(takestr), "[!] Uzeli ste %s[%d] drva iz vozila!", GetWoodName(pWoodT[playerid]), pWood[playerid]);
	SendClientMessage(playerid, COLOR_GREEN, takestr);
	
	//cmd_me(playerid, "grabi drva iz gepeka te ih nosi.");
	
	for(new i = 0; i != 5; ++i)
	{
		if(CarWoodInfo[vid][wood][i])
			return 1;
	}

	if(IsValidObject(CarWoodInfo[vid][wobjid]))
		return DestroyObject(CarWoodInfo[vid][wobjid]);
		
	return 1;
}

CMD:sellwood(playerid, params[])
{
	if(PlayerJob[playerid][pJob] != JOB_LOGGER)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste drvosjeca!");
	    
	if(IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti ovu komandu dok ste u vozilu!");
	    
	if(!pWood[playerid])
 		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate drva kod sebe! Koristite /takewood kako bi izvadili drvo iz vaSeg vozila.");
 		
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -534.7875, -183.1030, 78.4063))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste na lokaciji gdje se prodaju drva!");
	
	// Placa
	new money = pWood[playerid] + 200 + (GetPlayerSkillLevel(playerid) * 25);
	va_SendClientMessage(playerid, COLOR_RED, "[!] Zaradio si $%d, placa ti je sjela na racun.", money);
	BudgetToPlayerBankMoney(playerid, money); // novac sjeda na racun iz proracuna
	PaydayInfo[playerid][pPayDayMoney] += money;
	PlayerJob[playerid][pFreeWorks] -= 5;
	Player_SetIsWorkingJob(playerid, true);
	
	pWood[playerid] = 0;
	pWoodT[playerid] = 0;
	
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
		RemovePlayerAttachedObject(playerid, 9);
		
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid, 1);
	return 1;
}
