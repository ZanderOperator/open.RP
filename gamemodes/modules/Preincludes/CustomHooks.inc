// Purpose of this module is declaring custom functions that will be hooked in other modules

/*

  ,ad8888ba,  88          ,ad8888ba,   88888888ba        db        88           
 d8"'    `"8b 88         d8"'    `"8b  88      "8b      d88b       88           
d8'           88        d8'        `8b 88      ,8P     d8'`8b      88           
88            88        88          88 88aaaaaa8P'    d8'  `8b     88           
88      88888 88        88          88 88""""""8b,   d8YaaaaY8b    88           
Y8,        88 88        Y8,        ,8P 88      `8b  d8""""""""8b   88           
 Y8a.    .a88 88         Y8a.    .a8P  88      a8P d8'        `8b  88           
  `"Y88888P"  88888888888 `"Y8888Y"'   88888888P" d8'          `8b 88888888888  

*/

forward LoadServerData();
public LoadServerData()
{
	return 1;
}

/*

88888888ba  88                 db   8b        d8 88888888888 88888888ba   
88      "8b 88                d88b   Y8,    ,8P  88          88      "8b  
88      ,8P 88               d8'`8b   Y8,  ,8P   88          88      ,8P  
88aaaaaa8P' 88              d8'  `8b   "8aa8"    88aaaaa     88aaaaaa8P'  
88""""""'   88             d8YaaaaY8b   `88'     88"""""     88""""88'    
88          88            d8""""""""8b   88      88          88    `8b    
88          88           d8'        `8b  88      88          88     `8b   
88          88888888888 d8'          `8b 88      88888888888 88      `8b  

*/

forward ResetPlayerVariables(playerid);
public ResetPlayerVariables(playerid)
{
    return 1;
}

forward LoadPlayerStats(playerid);
public LoadPlayerStats(playerid)
{
    return 1;
}

forward SavePlayerStats(playerid);
public SavePlayerStats(playerid)
{
    return 1;
}


/*

8b           d8 88888888888 88        88 88   ,ad8888ba,  88          88888888888 ad88888ba   
`8b         d8' 88          88        88 88  d8"'    `"8b 88          88         d8"     "8b  
 `8b       d8'  88          88        88 88 d8'           88          88         Y8,          
  `8b     d8'   88aaaaa     88aaaaaaaa88 88 88            88          88aaaaa    `Y8aaaaa,    
   `8b   d8'    88"""""     88""""""""88 88 88            88          88"""""      `"""""8b,  
    `8b d8'     88          88        88 88 Y8,           88          88                 `8b  
     `888'      88          88        88 88  Y8a.    .a8P 88          88         Y8a     a8P  
      `8'       88888888888 88        88 88   `"Y8888Y"'  88888888888 88888888888 "Y88888P"   

*/

forward ResetPrivateVehicleInfo(vehicleid);
public ResetPrivateVehicleInfo(vehicleid)
{
    return 1;
}

forward ResetVehicleInfo(vehicleid);
public ResetVehicleInfo(vehicleid)
{
    return 1;
}

forward AC_DestroyVehicle(vehicleid);
public AC_DestroyVehicle(vehicleid)
{
    return 1;
}