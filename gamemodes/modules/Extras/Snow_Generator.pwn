/*  snow_generate.pwn
 *
 *  (c) Copyright 2015-2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin.
 *			 - Pottus for all GTA SA Object Array include.
 *			 - Y_Less for model sizes include.
*/

#include "a_samp"
#include "custom\streamer"
#include "allobjects"
#include "modelsizes"

#define INVALID_SCRIPT_ID														(-1)
#define MAX_REMOVED_OBJECTS														(500)

enum ObjectRemoved
{
	Model,
	Float:Location[3]
}

new
		RemovedObject[MAX_REMOVED_OBJECTS][ObjectRemoved],
		g_SlotID = INVALID_SCRIPT_ID
;

main() { }

stock AddSnowObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:d_stream = 200.0)
{
	new
			object = CreateDynamicObject(modelid, (x + 0.075), (y + 0.15), (z + 0.15), rx, ry, rz, .streamdistance = d_stream);
	for(new a = 0; a < 30; a++)
		SetDynamicObjectMaterial(object, a, 17944, "lngblok_lae2", "white64bumpy");
	return object;
}

stock IsPosInArea(Float:pos_x, Float:pos_y, Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{
	if(pos_x >= min_x && pos_x <= max_x
	&& pos_y >= min_y && pos_y <= max_y)
		return true;
	return false;
}

stock IsPosInRangeOfPoint2D(Float:pos_x, Float:pos_y, Float:range, Float:range_x, Float:range_y)
{
	pos_x -= range_x;
	pos_y -= range_y;
	return ((pos_x * pos_x) + (pos_y * pos_y)) < (range * range);
}

stock IsPosInRangeOfPoint3D(Float:pos_x, Float:pos_y, Float:pos_z, Float:range, Float:range_x, Float:range_y, Float:range_z)
{
	pos_x -= range_x;
	pos_y -= range_y;
	pos_z -= range_z;
	return ((pos_x * pos_x) + (pos_y * pos_y) + (pos_z * pos_z)) < (range * range);
}

stock RemoveObject(modelid, Float:pos_x, Float:pos_y, Float:pos_z)
{
	g_SlotID++;
	if(g_SlotID == MAX_REMOVED_OBJECTS)
	{
		printf("Limit for removed objects is reached. Open your script and change \"MAX_REMOVED_OBJECTS\" definition to a bigger value if you want to have more removed objects.");
		g_SlotID--;
		return INVALID_SCRIPT_ID;
	}
	if(g_SlotID == 1000)
	{
		printf("SA-MP limit: There appears to be a limit of around 1000 lines/objects. There is no workaround.");
		g_SlotID--;
		return INVALID_SCRIPT_ID;
	}
	RemovedObject[g_SlotID][Model]			=	modelid;
	RemovedObject[g_SlotID][Location][0]	=	  pos_x;
	RemovedObject[g_SlotID][Location][1]	=	  pos_y;
	RemovedObject[g_SlotID][Location][2]	=	  pos_z;
	return g_SlotID;
}

stock GetNumberOfRemovedObjects()
	return (g_SlotID + 1);

stock IsObjectRemoved(modelid, Float:pos_x, Float:pos_y, Float:pos_z)
{
	if(!GetNumberOfRemovedObjects())
		return false;
	for(new a = 0; a < GetNumberOfRemovedObjects(); a++)
	{
		if(modelid == RemovedObject[a][Model])
		{
			if(IsPosInRangeOfPoint3D(pos_x, pos_y, pos_z, 0.5, RemovedObject[a][Location][0], RemovedObject[a][Location][1], RemovedObject[a][Location][2]))
				return true;
		}
	}
	return false;
}

stock CreateSnowInArea(Float:min_x, Float:min_y, Float:max_x, Float:max_y, Float:max_z = 300.0, Float:min_obj_model_size = 30.0)
{
	new
			count;
	for(new a = 0; a < SEARCH_DATA_SIZE; a++)
	{
		if(SearchData[a][SearchZ] > max_z)
			continue;
		if(!IsPosInArea(SearchData[a][SearchX], SearchData[a][SearchY], min_x, min_y, max_x, max_y))
			continue;
		if(GetColSphereRadius(SearchData[a][Search_Model]) < min_obj_model_size)
			continue;
		if(IsObjectRemoved(SearchData[a][Search_Model], SearchData[a][SearchX], SearchData[a][SearchY], SearchData[a][SearchZ]))
			continue;
		AddSnowObject(
			SearchData[a][Search_Model],
			SearchData[a][SearchX],
			SearchData[a][SearchY],
			SearchData[a][SearchZ],
			SearchData[a][SearchRX],
			SearchData[a][SearchRY],
			SearchData[a][SearchRZ],
			(100.0 + GetColSphereRadius(SearchData[a][Search_Model]))
		);
		count++;
	}
	printf("Total snow objects: %i", count);
	return true;
}

stock CreateSnowInRange(Float:pos_x, Float:pos_y, Float:range, Float:max_z = 300.0, Float:min_obj_model_size = 30.0)
{
	new
			count;
	for(new a = 0; a < SEARCH_DATA_SIZE; a++)
	{
		if(SearchData[a][SearchZ] > max_z)
			continue;
		if(!IsPosInRangeOfPoint2D(SearchData[a][SearchX], SearchData[a][SearchY], range, pos_x, pos_y))
			continue;
		if(GetColSphereRadius(SearchData[a][Search_Model]) < min_obj_model_size)
			continue;
		if(IsObjectRemoved(SearchData[a][Search_Model], SearchData[a][SearchX], SearchData[a][SearchY], SearchData[a][SearchZ]))
			continue;
		AddSnowObject(
			SearchData[a][Search_Model],
			SearchData[a][SearchX],
			SearchData[a][SearchY],
			SearchData[a][SearchZ],
			SearchData[a][SearchRX],
			SearchData[a][SearchRY],
			SearchData[a][SearchRZ],
			(100.0 + GetColSphereRadius(SearchData[a][Search_Model]))
		);
		count++;
	}
	printf("Total snow objects: %i", count);
	return true;
}

stock PrintSnowForArea(Float:min_x, Float:min_y, Float:max_x, Float:max_y, Float:max_z = 300.0, Float:min_obj_model_size = 30.0)
{
	new
			count;
	for(new a = 0; a < SEARCH_DATA_SIZE; a++)
	{
		if(SearchData[a][SearchZ] > max_z)
			continue;
		if(!IsPosInArea(SearchData[a][SearchX], SearchData[a][SearchY], min_x, min_y, max_x, max_y))
			continue;
		if(GetColSphereRadius(SearchData[a][Search_Model]) < min_obj_model_size)
			continue;
		if(IsObjectRemoved(SearchData[a][Search_Model], SearchData[a][SearchX], SearchData[a][SearchY], SearchData[a][SearchZ]))
			continue;
		printf("AddSnowObject(%i, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.1f);",
			SearchData[a][Search_Model],
			SearchData[a][SearchX],
			SearchData[a][SearchY],
			SearchData[a][SearchZ],
			SearchData[a][SearchRX],
			SearchData[a][SearchRY],
			SearchData[a][SearchRZ],
			(100.0 + GetColSphereRadius(SearchData[a][Search_Model]))
		);
		count++;
	}
	printf("Total snow objects: %i", count);
	return true;
}

stock PrintSnowForRange(Float:pos_x, Float:pos_y, Float:range, Float:max_z = 300.0, Float:min_obj_model_size = 30.0)
{
	new
			count;
	for(new a = 0; a < SEARCH_DATA_SIZE; a++)
	{
		if(SearchData[a][SearchZ] > max_z)
			continue;
		if(!IsPosInRangeOfPoint2D(SearchData[a][SearchX], SearchData[a][SearchY], range, pos_x, pos_y))
			continue;
		if(GetColSphereRadius(SearchData[a][Search_Model]) < min_obj_model_size)
			continue;
		if(IsObjectRemoved(SearchData[a][Search_Model], SearchData[a][SearchX], SearchData[a][SearchY], SearchData[a][SearchZ]))
			continue;
		printf("AddSnowObject(%i, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.1f);",
			SearchData[a][Search_Model],
			SearchData[a][SearchX],
			SearchData[a][SearchY],
			SearchData[a][SearchZ],
			SearchData[a][SearchRX],
			SearchData[a][SearchRY],
			SearchData[a][SearchRZ],
			(100.0 + GetColSphereRadius(SearchData[a][Search_Model]))
		);
		count++;
	}
	printf("Total snow objects: %i", count);
	return true;
}

stock RemoveObjects()
{
	RemoveObject(4024, 1479.8672, -1790.3984, 56.0234);
	RemoveObject(4044, 1481.1875, -1785.0703, 22.3828);
	RemoveObject(4045, 1479.3359, -1802.2891, 12.5469);
	RemoveObject(4046, 1479.5234, -1852.6406, 24.5156);
	RemoveObject(4047, 1531.6328, -1852.6406, 24.5156);
	return true;
}

public OnFilterScriptInit()
{
	RemoveObjects();

	PrintSnowForArea(50.0, -3000.0, 3000.0, -750.0, 500.0, 30.0); // Los Santos area.
	//PrintSnowForArea(-3000.0, -3000.0, 3000.0, 3000.0, 500.0, 30.0); // Whole San Andreas area.
	//PrintSnowForRange(0.0, 0.0, 1000.0, 500.0, 30.0); // Range of 1000.0 from 0.0 center of San Andreas map.
	return true;
}

public OnFilterScriptExit()
{
	return true;
}

public OnPlayerConnect(playerid)
{
	if(GetNumberOfRemovedObjects())
	{
		for(new a = 0; a < GetNumberOfRemovedObjects(); a++)
		{
			RemoveBuildingForPlayer(
				playerid,
				RemovedObject[a][Model],
				RemovedObject[a][Location][0],
				RemovedObject[a][Location][1],
				RemovedObject[a][Location][2],
				0.5
			);
		}
	}
	return true;
}
