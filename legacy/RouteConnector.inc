#include <a_samp>
/*
		ROUTER PLUGIN
		- GPS ADDITION TO SA-MP
		- Made By Gamer_Z a.k.a. grasmanek94 , Rafal Grasman

		October-2011


		contact: gzx@live.nl

		http://gpb.googlecode.com/
*/

#if defined ROUTE_CONNECTOR_PLUGIN_INCLUDED
	#endinput
#endif

#define MAX_NODES					(32768)
#define MAX_CONNECTIONS				(5)

#define CONNECT_TYPE_BOTH			(0)
#define CONNECT_TYPE_One_To_Two		(1)

#define INCLUDE_VERSION				(184)

#define ROUTE_CONNECTOR_PLUGIN_INCLUDED
#pragma library "RouteConnectorPlugin"

native AddNode(Float:X,Float:Y,Float:Z,AddToPathFinder = 0, AddToScanner = 0);
/*
	Function: 
		AddNode
	Description: 
		Adds a node into the memory of the plugin,
		This node will be unavailable in route calculations.
	Parameters: 
		Position as X Y Z
		AddToPathFinder - if set to 1 it will also make sure the graph will be updated so when searching for a route it will be added to the list.
		AddToScanner - If set to 1 the node will be available in OnPlayerClosestNodeIDChange, else not.
	Returns the added nodeID, -1 if failed.
	Note:
		NEVER EVER set AddToPathFinder to 1 when a calculation is in progress! THAT IS YOUR OWN RESPOSIBILITY IF IT HAPPENS.
*/
native AddNodeEx(ID,Float:X,Float:Y,Float:Z,AddToPathFinder = 0);
/*
	Function: 
		AddNodeEx
	Description: 
		The only difference with AddNode is that you can specify your own NodeID here AND the node will be automaticly added to the appropriate area.
		Gaps may be present (eg AddNodeEx(0,0.0,0.0,0.0,0),AddNodeEx(6,0.0,0.0,0.0,0);).
	Parameters: 
		ID as Custom NodeID
		Position as X Y Z
		AddToPathFinder - if set to 1 it will also make sure the graph will be updated so when searching for a route it will be added to the list.
	Returns the added nodeID, -1 if failed.
	Note:
		NEVER EVER set AddToPathFinder to 1 when a calculation is in progress! THAT IS YOUR OWN RESPOSIBILITY IF IT HAPPENS.
*/
native ConnectNodes(NodeID_one,NodeID_two,AddToPathFinder = 0,direction = 0);
/*
	Function: 
		ConnectNodes
	Description: 
		This will connect two nodes stored in memory, same rules as for AddNode(Ex), it won't be available in path calculations.
		When you connect NodeID_one with NodeID_two it will automaticly connect the opposite, no distance suplying is needed as the XYZ are supplied at node creation.
	Parameters: 
		NodeID_one and NodeID_two as NodeID's
		AddToPathFinder - if set to 1 it will also make sure the graph will be updated so when searching for a route it will be added to the list.
		direction - you can choose to only connect nodeID one with nodeID two (One_To_Two = 1) or to connect them together (BOTH = 0)
	Returns:
		-1 - NodeOne is out of boundaries
		-2 - NodeTwo is out of boundaries
		-3 - NodeOne equals NodeTwo
		-4 - NodeOne doesn't exist
		-5 - NodeTwo doesn't exist
		-6 - NodeOne already connected with NodeTwo
		-7 - NodeTwo already connected with NodeOne
		-8 - No more connection slots left on one of the nodes or direction does not equal 1 or 0
		Anything above or equal to 0 means success (the NodeOne[connectid] is retuned).
	Note:
		NEVER EVER set AddToPathFinder to 1 when a calculation is in progress! THAT IS YOUR OWN RESPOSIBILITY IF IT HAPPENS.
*/
native NearestPlayerNode(playerid,Float:MaxDist=9999.99,IgnoreNodeID=(-1),UseAreas = 0);
/*
	Function: 
		NearestPlayerNode
	Description: 
		This function will get the closest player node, if you used AddNode(Ex) this nodes will also be considered.
	Parameters: 
		playerid - the playerid to count from
		MaxDist - the maximal distance to search from the player
		IgnoreNodeID - this node ID will not be returned as the closest one, it will be ignored in the search.
		UseAreas - if set to 0 it will go through all nodes in memory, else if to 1 it will do just the nodes in the area where the player is (not so accurate)
	Returns the closest nodeID, -1 if no node Id is found in range
*/
native NearestNodeFromPoint(Float:X,Float:Y,Float:Z,Float:MaxDist=9999.99,IgnoreNodeID=(-1),UseAreas = 0);
/*
	Function: 
		NearestNodeFromPoint
	Description: 
		Same as NearestPlayerNode, but here you can supply an point instead of an playerid
	Parameters: 
		XYZ - the position of the point to search from
		MaxDist - the maximal distance to search from the player
		IgnoreNodeID - this node ID will not be returned as the closest one, it will be ignored in the search.
		UseAreas - if set to 0 it will go through all nodes in memory, else if to 1 it will do just the nodes in the area where the player is (not so accurate)
	Returns the closest nodeID, -1 if no node Id is found in range
*/
native WriteNodesToFile(filename[]);
/*
	Function: 
		WriteNodesToFile
	Description: 
		Write all nodes, connections, contents of the memory into an loadable file,
		can be used by ReadNodesFromFile later.
	Parameters: 
		filename -	the "path/filename.extension" to store the information in,
					note that if you want to make a file in the scriptfiles folder you need to supply:
					WriteNodesToFile("scriptfiles/your.file.name");
	Returns 1 on success, 0 on failure.
*/
native ReadNodesFromFile(filename[]);
/*
	Function: 
		ReadNodesFromFile
	Description: 
		Read all nodes, connections, contents of the file into the memory,
		This function will automaticly create nodes, connect them, create the virtual graph to search paths on
		after it has been loaded into the memory.
	Parameters: 
		filename -	the "path/filename.extension" to read the information from,
					note that if you want to read a file in the scriptfiles folder you need to supply:
					ReadNodesFromFile("scriptfiles/your.file.name");
	Warning:
		It is not recommended to use this funcion, use at your own risk.
		The plugin calls this function only at server startup, however I have included it for you.
		You still can make aditional nodes with it (if you analyse the project source code correctly, you will know what I mean)
	Returns 1 on success, 0 on failure.
*/
native GetNodePos(NodeID,&Float:X,&Float:Y,&Float:Z);
/*
	Function: 
		GetNodePos
	Description: 
		Get the XYZ position of the supplied NodeID
	Parameters: 
		NodeID - The NodeID to get the XYZ from
		(returns) X Y Z - The XYZ positions.
	Returns 0 on failure (Out Of Range?), -1 if node doesn't exist, 1 on success.
*/
native CalculatePath(Start,End,routeID = 0,bool:CreatePolygon=false,Float:PolygonWidth=7.5,bool:GrabNodePositions=false);//Threaded calculating, everything done here will be added to an Queue
/*
	Function: 
		CalculatePath
	Description: 
		Submits information to the plugins' queue to calculate a path between the desired points
	Parameters: 
		Start - The start NodeID
		End - the destination NodeID
		routeID (optional) - [custom integer supply] Here you can specify an integer value that will be passed 
		to the callback, along with the calculated path information, for example the PlayerID.
		182:
		CreatePolygon - creates a polygon around the path if set to true
		PolygonWidth - the width from the node lines to the edge of the polygon
		183:
		GrabNodePositions - makes sure the NodePos[][] array is filled with usefull information.
		
		Please note that this can increase the needed stack size extremely.
		For storing the nodes, a polygon and all positions you need: 
		amount_of_nodes*4096*8+4096 bytes. The max amount of nodes I ever calculated wasn't higher than 1000. so:
		3280896 bytes would be needed for the stack. Make sure to use
		#pragma dynamic 4194304 //2^21 < 32772096 < 2^22, so we choose 2^22 bytes, this is 4MB of memory, so look out!
		Also make sure you know how much heap you will need (global variables etc) and add this amount to the calculated value and round up to nearest power of two
	Note:
		if you will be using the routeID parameter for recognizing routes, make sure they all are unique,
		once started route search cannot be aborted and will just be queued and the callback will still be called.

		This function is Threaded, this means that if the CalculatePath search takes 3 seconds, it won't lagg your server.
		Your server will continue to work normally.

		Only the callback in the script which calls the plugin will get executed with this, if you do CalculatePath in Script1, 
		and have your callback in Script2 then it won't get executed, however if you need that, make in script1 CallRemoteFunction in the callback to call the other script.

		Returns 1 on success, 0 when fails.
*/
native IsNodeIntersection(NodeID);
/*
	Function: 
		IsNodeIntersection
	Description: 
		Check if a node has 3 or more connections
	Parameters: 
		NodeID - The ID of the node
	Return 1 if true, 0 if false, -1 if node doesn't exist.
*/
native Float:GetAngleBetweenNodes(NodeID_one,NodeID_middle_aka_two,NodeID_three);
/*
	Function: 
		GetAngleBetweenNodes (Returns Float)
	Description: 
		Gets the angle between 3 nodes (2 connections/lines).
	Parameters: 
		NodeID* - The ID of the node
	Return 0.0 if one of the three nodes doesn't exist
*/
native GetConnectedNodes(NodeID);
/*
	Function: 
		GetConnectedNodes
	Description: 
		returns the amount of other nodes that are connected to this node, max is 5
	Parameters: 
		NodeID* - The ID of the node
	Returns amount of nodes connected (0 to 5), on failure -1.
*/
native GetNextEmptyNodeID();
/*
	Function: 
		GetNextEmptyNodeID
	Description: 
		returns the closest empty node ID (closest starting from 0 to up);
	Note:
		Example: 

				 new id = GetNextEmptyNodeID();
				 if(id != -1)AddNodeEx(id,X,Y,Z); 

				 However this example results in:

				 AddNode(X,Y,Z);
		Returns -1 if no more available node slots.
*/
native GetQueueSize();
/*
	Function: 
		GetQueueSize
	Description: 
		gets the size of all queued path calculations to do.
	Update R184: Returns amount of calculations pending 
*/
native GetConnectedNodeID(NodeID,ConnectID);
/*
	Function: 
		GetConnectedNodeID
	Description: 
		gets the ID of an connection to NodeID, -1 if ConnectID has no connection, connectid must be between 0 and (MAX_CONNECTIONS-1), however there is OFB prevention check.
*/
native Float:GetConnectedNodeDistance(NodeID,ConnectID);
/*
	Function: 
		GetConnectedNodeDistance (Returns Float)
	Description: 
		gets the distance to a connected node (ConnectID) from the selected node (NodeID).
*/
native Float:GetDistanceBetweenNodes(NodeID_one,NodeID_two);
/*
	Function: 
		GetDistanceBetweenNodes (Returns Float)
	Description: 
		gets the distance between the two nodes (NOT VIA OTHER NODES, THIS JUST DOES THE X Y Z POSITION CALCULATION).
*/
native IsNodeInPathFinder(NodeID);
/*
	Function: 
		IsNodeInPathFinder
	Description: 
		Checks if NodeID is added to the routecalculator.
	Returns -1 if the NodeID is invalid and 0 if node is not in the route calculator, 1 if yes.
*/
native GetRouteArray(ID,destination[],size = sizeof(destination));
/*
	Function: 
		GetRouteArray
	Description: 
		Stores an saved array with assigned ID to destination[]
	Returns the amount of nodes in array at ID, Returns 0 if array is empty or ID doesn't exist.
*/
native GetRouteAtPos(ID,Array_Pos,&amount_of_nodes=0);
/*
	Function: 
		GetRouteAtPos
	Description: 
		Returns the NodeID in array[Array_Pos] at ID.
		Optionally you can specify an variable to store the amount of nodes in it.
*/
native StoreRouteArray(amount_of_nodes,array[]);
/*
	Function: 
		StoreRouteArray
	Description: 
		Stores an array to the plugins vector memory, 
	returns the ID you can use in GetRouteArray or DeleteArray.
*/
native DeleteArray(ID);
/*
	Function: 
		DeleteArray
	Description: 
		Remove contents of the memory at ID.
*/
native AddExistingNodeToPathFinder(NodeID);
/*
	Function: 
		AddExistingNodeToPathFinder
	Description: 
		Adds an created node to the routecalculator.
	Returns -1 if the NodeID is invalid and 0 if node id does not exist or is already added, 1 on success.
*/
native RemoveNode(NodeID);
/*
	Function: 
		RemoveNode
	Description: 
		Deletes an node from the memory, to use in Write data, nodes loaded into the calculator won't be deleted, connections too.
	Returns -1 if the NodeID is invalid and 0 if node id does not exist, 1 on success.
*/
native DisconnectNodeFromNode(NodeIDOne,NodeIDTwo);
/*
	Function: 
		DisconnectNodeFromNode
	Description: 
		Disconnects Node ID One from Two, please see RemoveNode for information about the calculator memory.
	Returns -1 if the NodeID is invalid and 0 if node id does not exist, 1 on success.
*/
native DisconnectAllFromNode(NodeID);
/*
	Function: 
		DisconnectAllFromNode
	Description: 
		Disconnects all other nodes from NodeID, and NodeID from them.
	Returns -1 if the NodeID is invalid and 0 if node id does not exist, 1 on success.
*/
native DeleteNodeSystemAtNode(NodeID,array[],size = sizeof(array));
/*
	Function: 
		DeleteNodeSystemAtNode
	Description: 
		Get ALL nodeIDs that are CONNECTED IN ANY WAY, ALSO VIA OTHER NODES to NodeID into the array[].
		Usefull for deleting big-not-connected chunks of nodes.
	Returns 0 on failure, the array size on success.
*/
native GetNodeDirectionToConnect(NodeID,ConnectID);
/*
	Function: 
		GetNodeDirectionToConnect
	Description: 
		Get the direction this node[connectid] is connected in, 
		0 means that :
			connectid is connected to nodeid
			nodeid is connected to connectid
		1 means that:
			nodeid is connected to connectid
			connectid is NOT connected to nodeid
		2 means that:
			nodeid is NOT connected to connectid
			connectid is connected to nodeid
	Note:
		Usefull for making 'left and right' road sides.
	Returns -1 on failure.
*/
native SetNodeDirectionToConnect(NodeID,ConectID,Direction);
/*
	Function: 
		SetNodeDirectionToConnect
	Description: 
		See GetNodeDirectionToConnect, this SETS the direction manually.
		It automaticly get the nodeID of 'ConectID' and sets the connection_direction to the good value.
	Returns 0 on failure, 1 on success.
*/
native NodeExists(NodeID);
/*
	Function: 
		NodeExists
	Description: 
		Checks if the given nodeID exists in the memory.
	Returns 0 if not, 1 if yes, -1 on failure.
*/
native RemoveAllRouteIDFromQueue(/*routeid*/);
/*
	Function: 
		RemoveAllRouteIDFromQueue
	Description: 
		Removes all pending calculations with 'routeid' from the queue.
		R181 update: clears the WHOLE queue.
	Returns -1 if the Queue is locked/accessed, else it returns the amount of entries deleted.
	    R181 update: always returns 1.
*/
forward GPS_WhenRouteIsCalculated(routeid,node_id_array[],amount_of_nodes,Float:distance,Float:Polygon[],Polygon_Size,Float:NodePosX[],Float:NodePosY[],Float:NodePosZ[]);//Every processed Queue will be called here
/*
	Called when a path finding calculation is done.
	
	routeid - the id you specified for recognition of calls
	node_id_array -	this array is up to 1792 cells long
					it is build from the following information:

					node_id_array[0] ... node_id_array[1791] - 
						all points (Node ID's) on the route
						in following order:
							from start, to end
	amount_of_nodes - this is the amount of nodes the total path is, is set to 0 when it's impossible to calculate the route.
	distance - the total distance all nodes take, rounded to an integer, is -1 if it's impossible to calculate the route.
	so you can do:
	public GPS_WhenRouteIsCalculated(...)
	{
		for(new i = 0; i < amount_of_nodes; ++i)
		{
			printf("Point(%d)=NodeID(%d), Position(X;Y;Z):{%f;%f;%f}",i,node_id_array[i:NodePosX[i],:NodePosY[i],:NodePosZ[i]);	
		}
		return 1;
	}
	Polygon - the polygon around the path, only given if you specified it at calculatepath
	Polygon_Size/2 = amount of points in polygon
*/
forward OnPlayerClosestNodeIDChange(playerid,old_NodeID,new_NodeID);
/*
	Called when a player's closest nodeID changes.
	
	playerid - the id of the player
	old_NodeID and new_NodeID - the node ID's, old and new.
		new_NodeID is 'now' the closest node ID.

*/
native GetGPSdatVersion();
/*
	Function: 
		GetGPSdatVersion
	Description: 
		Gets the file version of GPS.dat
	Returns -1 if getting the GPS.dat version failed, else it returns the version number, this function is only available since package 162
*/
native GetPluginVersion();
/*
	Function: 
		GetPluginVersion
	Description: 
		Gets the plugin version
	Returns the plugin version, this function is only available since package 162
*/
stock GetIncludeVersion()
{
	return INCLUDE_VERSION;
}
/*
	Function: 
		GetIncludeVersion
	Description: 
		Gets the include file version
	Returns the inclde file version, this function is only available since package 162
*/
native gps_AddPlayer(playerid);
/*
	Function: 
		gps_AddPlayer
	Description: 
		adds the player to the update check.
	Returns 1 on success, 0 on failure, 2 if player already in list.
*/
native gps_RemovePlayer(playerid);
/*
	Function: 
		gps_RemovePlayer
	Description: 
		removes the player from the update check.
	Returns 1 on success, 0 on failure.
*/
native GetRouteArrayFromTo(ID,From,To,dest[],size=sizeof(dest));
/*
	Function: 
		GetRouteArrayFromTo
	Description: 
		Please see GetRouteArray, the only difference is you can specify an range, from to, to extract.
	Returns amount of nodes put into dest[].
*/
native GetRouteArraySize(ID);
/*
	Function: 
		GetRouteArraySize
	Description: 
		returns the amount of nodes in the <ID>array.
	Returns returns the amount of nodes in the <ID>array.
*/
native GetNextNodeInArray(ArrayID,mark_done = 0);//return nodeid, else -1
/*
	Function:
		GetNextNodeInArray
	Description:
		returns the first node with mark_done == 0 from ArrayID , else -1 on failure
*/
native IsNodeInArray(ArrayID,NodeID);//Return 1 else 0
/*
	Function:
		IsNodeInArray
	Description:
		returns 1 if nodeid is in ArrayID, else 0
*/
native SetNodeIDMarkInArray(ArrayID,NodeID,mark_done,mark_all_prevous_same=0);//return 1 on success
/*
	Function:
		SetNodeIDMarkInArray
	Description:
		Marks the nodeID in ArrayID to the value you set (1 or 0) eg player already visited the nodeID
        mark_all_prevous_same if set to 1 will mark all NodeID's before the selected NodeID@index also to the same value you set mark_done to.
*/
native SetIndexMarkInArray(ArrayID,Index,mark_done,mark_all_prevous_same=0);//returns 1 on on success
/*
	Function:
		SetIndexMarkInArray
	Description:
		Marks the Index (instead check if nodeid, just Marked[index] = mark_done) in ArrayID to the value you set (1 or 0) eg player already visited the Index according to NodeID
        mark_all_prevous_same if set to 1 will mark all NodeID's before the selected NodeID@index also to the same value you set mark_done to.
*/
native EnableOnPlayerNodeIDChange();
/*
	Function:
		EnableOnPlayerNodeIDChange
	Description:
		Enables OnPlayerClosestNodeIDChange callback.
*/
native DisableOnPlayerNodeIDChange();
/*
	Function:
		DisableOnPlayerNodeIDChange
	Description:
		Disables OnPlayerClosestNodeIDChange callback.
*/
native NodeChangeScanAllNodes();
/*
	Function:
		NodeChangeScanAllNodes
	Description:
		Goes through all nodes when checking the closest nodeID in the callback.
*/
native NodeChangeScanAreaOnly();
/*
	Function:
		NodeChangeScanAreaOnly
	Description:
		Goes only through nodes in player area when checking the closest nodeID in the callback.
*/
native GetNodeIDMarkInArray(ArrayID,NodeID);//return 1 on true, 0 on false, -1 on failure
/*
	Function:
		GetNodeIDMarkInArray
	Description:
		The get function of the Set equilivant
*/
native GetIndexMarkInArray(ArrayID,Index);//return 1 on true, 0 on false, -1 on failure
/*
	Function:
		GetIndexMarkInArray
	Description:
		The get function of the Set equilivant
*/
native ChangeOPCNIURate(TickRate = 55);
/*
	Function:
		ChangeOPCNIURate
	Description:
		Sets the OnPlayerClosestNodeIDChanged callback update rate in ticks
*/
native NearestNodeFromPointInArray(ArrayID,Float:X,Float:Y,Float:Z,Float:MaxDist=9999.99,IgnoreNodeID=(-1),IgnoreMarkedNodes=0);
/*
	Function:
		NearestNodeFromPointInArray
	Description:
		Gets the closest node to the specified XYZ coordinates which are in the route array ArrayID.
		IgnoreNode ignores the specified node, IgnoreMarkedNodes makes sure it skips nodes that are marked in the array
	Returns -1 if there is no closest node to this point (eg all nodes are marked, no such array id or other problems)
*/
native NearestNodeFromPlayerInArray(playerid,ArrayID,Float:MaxDist=9999.99,IgnoreNodeID=(-1),IgnoreMarkedNodes=0);
/*
	Function:
		NearestNodeFromPlayerInArray
	Description:
		Gets the closest node to the specified player in the route array ArrayID.
		IgnoreNode ignores the specified node, IgnoreMarkedNodes makes sure it skips nodes that are marked in the array
	Returns -1 if there is no closest node to this point (eg all nodes are marked, no such array id or other problems)
*/
native RebuildGraph();
/*
	Function:
		RebuildGraph
	Description:
		Rebuilds the internal node data for the pathfinder, usefull for use after AddNode without AddToPathFinder and ConnectNodes, change node positions, etc.
	Returns:
		1 on success, 0 on failure	
*/
native GetAmountOfFreeNodeSlots();
/*
	Function:
		GetAmountOfFreeNodeSlots
	Description:
		Gets the amount of nodes which are available for creation
	Returns:
		amount of nodes left to create
*/
forward GPS_GetPlayerPosEnablerUn();
public GPS_GetPlayerPosEnablerUn()
{
	new Float:____GPS_GetPlayerPosEnablerUn;
	GetPlayerPos(0,____GPS_GetPlayerPosEnablerUn,____GPS_GetPlayerPosEnablerUn,____GPS_GetPlayerPosEnablerUn);
	return 1;
}
