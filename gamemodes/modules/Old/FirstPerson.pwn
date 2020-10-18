#include <YSI_Coding\y_hooks>

new FirstPerson[MAX_PLAYERS];
new FirstPersonObject[MAX_PLAYERS];
new bool:FPS[MAX_PLAYERS];


hook OnPlayerDeath(playerid, killerid, reason)
{
	if(FirstPerson[playerid] == 1)
	{
    	StopFPS(playerid);
	}
	return 1;
}


stock StartFPS(playerid) //Start FPS
{
    FirstPersonObject[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    AttachObjectToPlayer(FirstPersonObject[playerid],playerid, 0.0, 0.12, 0.7, 0.0, 0.0, 0.0);
    AttachCameraToObject(playerid, FirstPersonObject[playerid]);
    FirstPerson[playerid] = 1;
    CallLocalFunction("OnPlayerHaveFirstPerson", "i", playerid);
    return 1;
}

stock StopFPS(playerid)
{
    SetCameraBehindPlayer(playerid);
    DestroyObject(FirstPersonObject[playerid]);
    FirstPerson[playerid] = 0;
    CallLocalFunction("OnPlayerDoNotHaveFirstPerson", "i", playerid);
    return 1;
}

stock Reset(playerid)
{
    FirstPerson[playerid] = 0; //ako se igrac zbuga da se moze resetovat.
}

CMD:fps(playerid, params[])
{
    if(FPS[playerid] == false)
    {
        FPS[playerid] = true;
        StartFPS(playerid);
    }
    else if(FPS[playerid] == true)
    {
        FPS[playerid] = false;
        StopFPS(playerid);
    }
    return 1;
}
CMD:resetfps(playerid, params[])
{
    Reset(playerid);
    return 1;
}
