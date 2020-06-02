#include <a_samp>
#include <YSI\y_hooks>

new TrainVeh; //Global variable!

hook OnFiterScriptInit()
{
  print("CoA.RP | Train loaded");
  ConnectNPC("TrainNPC","mynpc");
  TrainVeh = AddStaticVehicle(538, 1744.9969,-1953.8707,13.5469,-269.1238, 1, 74);
  return 1;
}

hook OnPlayerSpawn(playerid)
{
  if(IsPlayerNPC(playerid)) //Checks if the player that just spawned is an NPC.
  {
    new npcname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, npcname, sizeof(npcname));
    if(!strcmp(npcname, "TrainNPC", true))
    {
      PutPlayerInVehicle(playerid, TrainVeh, 0);
      SetPlayerColor(playerid, 	COLOR_PLAYER);
      SetPlayerSkin(playerid, 2);
    }
    return 1;
  }
  return 1;
}
