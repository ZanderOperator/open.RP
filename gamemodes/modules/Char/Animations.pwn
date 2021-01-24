#include <YSI_Coding\y_hooks>

static const AnimLibs[][] =
{
    "BOMBER", "RAPPING", "SHOP", "BEACH", "SMOKING", "FOOD", "ON_LOOKERS",
    "DEALER", "CRACK", "CARRY", "COP_AMBIENT", "PARK", "INT_HOUSE", "FOOD",
    "DANCING", "ped", "TEC", "CASINO", "VENDING", "HEIST9", "PARACHUTE",
    "GYMNASIUM", "MISC", "SWORD", "CHAINSAW"
};

stock PreloadAnimLibFor(playerid)
{
    for(new i = 0, len = sizeof(AnimLibs); i < len; i++)
        ApplyAnimation(playerid, AnimLibs[i], "null", 0.0, 0, 0, 0, 0, 0, 0);
}

new
	bool:PlayerAnim[MAX_PLAYERS];
	
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & 128)
	{
        if(!Bit1_Get(PlayingBBall, playerid) && PlayerAnim[playerid] && (!PlayerWounded[playerid] && PlayerDeath[playerid][pKilled] == 0) && !IsPlayerAiming(playerid) && PlayerAction[playerid] == PLAYER_ACTION_NONE)
		{
			if(GetPlayerAnimationIndex(playerid))
			{
			    new
					animlib[32],
		        	animname[32];

		        GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);
		        
		        if(strfind(animname, "fall", true) != -1)
					return 1;
			}
			if(GetPlayerSpecialAction(playerid))
			{
				if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
					return 1;
				SetPlayerSpecialAction(playerid, 0);
			}
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
			PlayerAnim[playerid] = false;
		}
    }
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    PlayerAnim[playerid] = false;
	//Frozen[playerid] = false;
	return 1;
}

hook OnPlayerSpawn(playerid)
{
    PreloadAnimLibFor(playerid);
    return 1;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 1, toggleable = 1) // ReWrap
{
	forcesync = 1;
	if(PlayerWounded[playerid] || PlayerDeath[playerid][pKilled] > 0)
	   return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti animacije dok ste u Wounded/Death stanju!");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || Player_IsCuffed(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti animacije dok ste cuffani!");
	    
	if(!PlayerAnim[playerid] && toggleable == 1)
		PlayerAnim[playerid] = true;

	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	return 1;
}


stock SetPlayerSpecialActionEx(playerid, actionid) // ReWrap
{
	if(PlayerWounded[playerid] || PlayerDeath[playerid][pKilled] > 0)
	   return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti animacije dok ste u Wounded/Death stanju!");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || Player_IsCuffed(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti animacije dok ste cuffani!");
	    
	SetPlayerSpecialAction(playerid, actionid);

	if(!PlayerAnim[playerid])
		PlayerAnim[playerid] = true;
	return 1;
}

CMD:dance(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	        SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_DANCE1);
	    case 2:
	        SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_DANCE2);
	    case 3:
	        SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_DANCE3);
	    case 4:
	        SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_DANCE4);
	    default:
	        SendClientMessage(playerid, COLOR_RED, "[?]: /dance [1-4]");
	}
	return 1;
}

CMD:handsup(playerid, params[])
{
    SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:lean(playerid, params[])
{
    switch(strval(params))
    {
		case 1:
			ApplyAnimationEx(playerid,"GANGS","leanIDLE",4.0,0,1,1,1,0);
		case 2:
			ApplyAnimationEx(playerid,"MISC","Plyrlean_loop",4.1,1,0,0,0,0);
		case 3:
        	ApplyAnimationEx(playerid,"BAR","BARman_idle",3.0,0,1,1,1,0);
		default:
		    SendClientMessage(playerid, COLOR_RED, "[?]: /lean [1-3]");
	}
    return 1;
}

CMD:injured(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SWEET", "LaFin_Sweet", 4.0999, 0, 1, 1, 1, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
	    case 3:
	        ApplyAnimationEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /injured [1-3]");
	}
	return 1;
}

CMD:sit(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	        ApplyAnimationEx(playerid, "PED", "SEAT_idle", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0);
	    case 3:
	        ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /sit [1-2]");
	}
	return 1;
}

CMD:carsit(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	        ApplyAnimationEx(playerid, "CAR", "Tap_hand", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "LOWRIDER", "Sit_relaxed", 4.0, 1, 0, 0, 0, 0);
		case 3:
		    ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_idleloop", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /carsit [1-3]");
	}
	return 1;
}

CMD:stand(playerid, params[])
{
    switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "car_publicertalk", 4.0999, 0, 0, 0, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "IDLE_HBHB", 4.0999, 0, 0, 0, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "woman_idlestance", 4.0999, 0, 0, 0, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.0999, 0, 0, 0, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0999, 0, 0, 0, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.0999, 0, 0, 0, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.0999, 0, 0, 0, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "GANGS", "DEALER_IDLE", 4.0999, 0, 0, 0, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "FAT", "FatIdle", 4.0999, 0, 0, 0, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "PED", "Idlestance_fat", 4.0999, 0, 0, 0, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "PED", "idlestance_old", 4.0999, 0, 0, 0, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "PED", "IDLE_armed", 4.0999, 0, 0, 0, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "BD_FIRE", "BD_Panic_Loop", 4.0999, 0, 0, 0, 1, 0, 0);
		case 14:
		    ApplyAnimation(playerid, "OTB", "wtchrace_loop", 4.1, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /stand [1-12]");
	}
	return 1;
}

CMD:drunk(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1);
	return 1;
}


CMD:walk(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
			ApplyAnimationEx(playerid, "FAT", "FatWalk", 4.0999, 1, 1, 1, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.0999, 1, 1, 1, 1, 1, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.0999, 1, 1, 1, 1, 1, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.0999, 1, 1, 1, 1, 1, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.0999, 1, 1, 1, 1, 1, 0);
		case 6:
			ApplyAnimationEx(playerid, "PED", "WALK_old", 4.0999, 1, 1, 1, 1, 1, 0);
		case 7:
			ApplyAnimationEx(playerid, "PED", "WALK_player", 4.0999, 1, 1, 1, 1, 1, 0);
		case 8:
			ApplyAnimationEx(playerid, "PED", "WALK_rocket", 4.0999, 1, 1, 1, 1, 1, 0);
		case 9:
			ApplyAnimationEx(playerid, "PED", "WALK_shuffle", 4.0999, 1, 1, 1, 1, 1, 0);
		case 14:
			ApplyAnimationEx(playerid, "PED", "Walk_Wuzi", 4.0999, 1, 1, 1, 1, 1, 0);
		case 15:
			ApplyAnimationEx(playerid, "MUSCULAR", "MuscleWalk", 4.0999, 1, 1, 1, 1, 1, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /walk [1-15]");
	}
	return 1;
}

CMD:fwalk(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.0999, 1, 1, 1, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.0999, 1, 1, 1, 1, 1, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.0999, 1, 1, 1, 1, 1, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walkold", 4.0999, 1, 1, 1, 1, 1, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walkpro", 4.0999, 1, 1, 1, 1, 1, 0);
		case 6:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.0999, 1, 1, 1, 1, 1, 0);
		case 7:
			ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.0999, 1, 1, 1, 1, 1, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /fwalk [1-7]");
	}
	return 1;
}

CMD:crack(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "SWAT", "gnstwall_injurd", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /crack [1-9]");
	}
	return 1;
}

CMD:cpr(playerid, params[])
{
    ApplyAnimationEx(playerid, "MEDIC", "CPR", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:rap(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	        ApplyAnimationEx(playerid, "RAPPING", "RAP_A_Loop", 4.0, 1, 1, 1, 1, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "RAPPING", "RAP_B_Loop", 4.0, 1, 1, 1, 1, 0);
	    case 3:
	        ApplyAnimationEx(playerid, "RAPPING", "RAP_C_Loop", 4.0, 1, 1, 1, 1, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /rap [1-3]");
	}
	return 1;
}

CMD:wank(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	        ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 1, 1, 1, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "PAULNMAC", "wank_in", 4.0, 1, 1, 1, 1, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /wank [1-2]");
	}
	return 1;
}

CMD:strip(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
			ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.0999, 1, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.0999, 1, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "STRIP", "STR_A2B", 4.0999, 1, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "STRIP", "STR_B2C", 4.0999, 1, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "STRIP", "STR_C1", 4.0999, 1, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "STRIP", "STR_C2", 4.0999, 1, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "STRIP", "STR_C2B", 4.0999, 1, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "STRIP", "STR_Loop_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "STRIP", "STR_Loop_B", 4.0999, 1, 1, 1, 1, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "STRIP", "STR_Loop_C", 4.0999, 1, 1, 1, 1, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "STRIP", "PLY_CASH", 4.0999, 0, 1, 1, 1, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "STRIP", "PUN_CASH", 4.0999, 0, 1, 1, 1, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "STRIP", "PUN_HOLLER", 4.0999, 0, 1, 1, 1, 0, 0);
		case 19:
			ApplyAnimationEx(playerid, "STRIP", "PUN_LOOP", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /strip [1-19]");
	}
	return 1;
}

CMD:bj(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.1, 0, 1, 1, 1, 1);
	    case 2:
	        ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_START_W", 4.1, 0, 1, 1, 1, 1);
	    case 3:
	        ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 0, 1, 1, 1, 1);
	    case 4:
	        ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 0, 1, 1, 1, 1);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /bj [1-4]");
	}
	return 1;
}

CMD:cellin(playerid, params[])
{
    SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_USECELLPHONE);
	return 1;
}

CMD:cellout(playerid, params[])
{
    SetPlayerSpecialActionEx(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	return 1;
}

CMD:piss(playerid, params[])
{
    SetPlayerSpecialActionEx(playerid, 68);
	return 1;
}

CMD:follow(playerid, params[])
{
    ApplyAnimationEx(playerid, "WUZI", "Wuzi_follow", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:greet(playerid, params[])
{
    ApplyAnimationEx(playerid, "WUZI", "Wuzi_Greet_Wuzi", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:hitch(playerid, params[])
{
    ApplyAnimationEx(playerid, "MISC", "Hiker_Pose", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:bitchslap(playerid, params[])
{
    ApplyAnimationEx(playerid, "MISC", "bitchslap", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:gsign(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "GHANDS", "gsign1", 4.0, 0, 1, 1, 1, 1);
	    case 2:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign2", 4.0, 0, 1, 1, 1, 1);
	    case 3:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign3", 4.0, 0, 1, 1, 1, 1);
	    case 4:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign4", 4.0, 0, 1, 1, 1, 1);
	    case 5:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.0, 0, 1, 1, 1, 1);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /gsign [1-5]");
	}
	return 1;
}

CMD:getup(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "getup", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:slapped(playerid, params[])
{
    ApplyAnimationEx(playerid, "SWEET", "ho_ass_slapped", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:slapass(playerid, params[])
{
    ApplyAnimationEx(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:celebrate(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /celebrate [1-2]");
	}
	return 1;
}

CMD:win(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "CASINO", "cards_win", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "CASINO", "Roulette_win", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /win [1-2]");
	}
	return 1;
}

CMD:yes(playerid, params[])
{
    ApplyAnimationEx(playerid, "GANGS", "Invite_Yes", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:deal(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 3.0, 0, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "DEALER", "DRUGS_BUY", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /deal [1-2]");
	}
	return 1;
}

CMD:invite(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "GANGS", "Invite_Yes", 4.1, 0, 1, 1, 1, 1);
	    case 2:
	        ApplyAnimationEx(playerid, "GANGS", "Invite_No", 4.1, 0, 1, 1, 1, 1);
     	default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /invite [1-2]");
	}
	return 1;
}

CMD:thankyou(playerid, params[])
{
    ApplyAnimationEx(playerid, "FOOD", "SHP_Thank", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:scratch(playerid, params[])
{
    ApplyAnimationEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:bombplant(playerid, params[])
{
    ClearAnimations(playerid);
    ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:getarrested(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
	return 1;
}

CMD:laugh(playerid, params[])
{
    ApplyAnimationEx(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:lookout(playerid, params[])
{
    switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "flee_lkaround_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SHOP", "ROB_Shifty", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "roadcross", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "roadcross_female", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "roadcross_gang", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "PED", "roadcross_old", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /lookout [1-6]");
	}
	return 1;
}

CMD:robman(playerid, params[])
{
    ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:crossarms(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
	    case 2:
	        ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 0, 1, 1, 1, -1);
	    case 3:
	        ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 1, 1, 1, -1);
     	default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /crossarms [1-3]");
	}
	return 1;
}

CMD:lay(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0);
		case 3:
	       	ApplyAnimationEx(playerid,"CRACK","crckidle4", 4.0, 1, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid,"BEACH","PARKSIT_W_LOOP", 4.0, 1, 0, 0, 0, 0);
        default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /lay [1-4]");
	}
	return 1;
}

CMD:vomit(playerid, params[])
{
    ApplyAnimationEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:eatanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 4.0999, 1, 1, 1, 0, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "FOOD", "EAT_Chicken", 4.0999, 1, 1, 1, 0, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "FOOD", "EAT_Pizza", 4.0999, 1, 1, 1, 0, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat1", 4.0999, 1, 1, 1, 0, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0999, 1, 1, 1, 0, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0999, 1, 1, 1, 0, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "PED", "gum_eat", 4.0999, 1, 1, 1, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /eatanim [1-7]");
	}
	return 1;
}

CMD:wave(playerid, params[])
{
    switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "BD_FIRE", "BD_GF_Wave", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "KISSING", "gfwave2", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "endchat_03", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /wave [1-4]");
	}
	return 1;
}

CMD:smoke(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
			ApplyAnimationEx(playerid, "GANGS", "smkcig_prtl", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "GANGS", "smkcig_prtl_F", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "pass_Smoke_in_car", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SHOP", "Smoke_RYD", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "SMOKING", "F_smklean_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "SMOKING", "M_smkstnd_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "SMOKING", "M_smk_drag", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "SMOKING", "M_smk_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "SMOKING", "M_smk_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "SMOKING", "M_smk_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "SMOKING", "M_smk_tap", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /smoke [1-12]");
	}
	return 1;
}

CMD:chat(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CAR_CHAT", "car_talkm_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CAR_CHAT", "car_talkm_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CAR_CHAT", "car_talkm_out", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "MISC", "Idle_Chat_02", 4.0999, 1, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "PED", "IDLE_chat", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /chat [1-7]");
	}
	return 1;
}

CMD:fucku(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:taichi(playerid, params[])
{
    ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:relax(playerid, params[])
{
    ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:bat(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "BASEBALL", "Bat_M", 4.0, 1, 0, 0, 0, 0);
	    case 3:
	        ApplyAnimationEx(playerid, "BASEBALL", "BAT_PART", 4.0, 1, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "CRACK", "Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0);
	    case 5:
	        ApplyAnimationEx(playerid, "CRACK", "Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /bat [1-5]");
	}
	return 1;
}

CMD:nod(playerid, params[])
{
    ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_nod", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:cry(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0);
     	case 3:
			ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.0999, 0, 1, 1, 1, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /cry [1-2]");
	}
	return 1;
}

CMD:chant(playerid, params[])
{
    ApplyAnimationEx(playerid, "RIOT", "RIOT_CHANT", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:carsmoke(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "Smoke_in_car", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:aim(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
			ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Gun_Aim", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Gun_Threat", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "Driveby_L", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "Driveby_R", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "PED", "gang_gunstand", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /aim [1-6]");
	}
	return 1;
}

CMD:gang(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0);
	    case 3:
	       	ApplyAnimationEx(playerid, "GANGS", "hndshkca", 4.0, 0, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "GANGS", "hndshkcb", 4.0, 0, 0, 0, 0, 0);
	    case 5:
	       	ApplyAnimationEx(playerid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0);
	    case 6:
	        ApplyAnimationEx(playerid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0);
	    case 7:
	        ApplyAnimationEx(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /gang [1-7]");
	}
	return 1;
}

CMD:bed(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "INT_HOUSE", "BED_In_L", 4.1, 0, 1, 1, 1, 1);
	    case 2:
	       	ApplyAnimationEx(playerid, "INT_HOUSE", "BED_In_R", 4.1, 0, 1, 1, 1, 1);
	    case 3:
	       	ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_L", 4.0, 1, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_R", 4.0, 1, 0, 0, 0, 0);
	    default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /bed [1-4]");
	}
	return 1;
}

CMD:stretch(playerid, params[])
{
    ApplyAnimationEx(playerid, "PLAYIDLES", "stretch", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:angry(playerid, params[])
{
    ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:kiss(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "BD_FIRE", "Grlfrd_Kiss_03", 4.0, 0, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_01", 4.0, 0, 0, 0, 0, 0);
	    case 3:
	       	ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 0, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0, 0, 0, 0, 0, 0);
	    case 5:
	       	ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_01", 4.0, 0, 0, 0, 0, 0);
	    case 6:
	        ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 0, 0, 0, 0);
	    case 7:
	        ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_03", 4.0, 0, 0, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /kiss [1-7]");
	}
	return 1;
}

CMD:exhausted(playerid, params[])
{
    ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

CMD:ghand(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "GHANDS", "gsign1LH", 4.0, 0, 1, 1, 1, 1);
	    case 2:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign2LH", 4.0, 0, 1, 1, 1, 1);
	    case 3:
	       	ApplyAnimationEx(playerid, "GHANDS", "gsign3LH", 4.0, 0, 1, 1, 1, 1);
	    case 4:
	        ApplyAnimationEx(playerid, "GHANDS", "gsign4LH", 4.0, 0, 1, 1, 1, 1);
	    case 5:
	       	ApplyAnimationEx(playerid, "GHANDS", "gsign5LH", 4.0, 0, 1, 1, 1, 1);
   		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /ghand [1-5]");
	}
	return 1;
}

CMD:basket(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_def_loop", 4.0, 1, 0, 0, 0, 0);
	    case 2:
	        ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_idleloop", 4.0, 1, 0, 0, 0, 0);
	    case 3:
	       	ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 0, 0, 0, 0);
	    case 4:
	        ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0, 0, 0, 0, 0, 0);
	    case 5:
	       	ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_Dnk", 4.1, 0, 1, 1, 1, 1);
	    case 6:
	       	ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_run", 4.1, 1, 1, 1, 1, 1);
   		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /basket [1-6]");
	}
	return 1;
}

CMD:akick(playerid, params[])
{
    ApplyAnimationEx(playerid, "FIGHT_E", "FightKick", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:box(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "FIGHT_B", "FightB_1", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "FIGHT_B", "FightB_2", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "FIGHT_B", "FightB_IDLE", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /box [1-3]");
	}
	return 1;
}

CMD:cockgun(playerid, params[])
{
    ApplyAnimationEx(playerid, "SILENCED", "Silence_reload", 3.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:bar(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "BAR", "Barcustom_get", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "BAR", "Barcustom_loop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "BAR", "Barcustom_order", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "BAR", "Barserve_bottle", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "BAR", "Barserve_give", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "BAR", "Barserve_glass", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "BAR", "Barserve_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "BAR", "Barserve_loop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "BAR", "Barserve_order", 4.0999, 0, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /bar [1-12]");
	}
	return 1;
}

CMD:liftup(playerid, params[])
{
    ApplyAnimationEx(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:putdown(playerid, params[])
{
    ApplyAnimationEx(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:dead(playerid, params[])
{
	switch(strval(params))
	{
	    case 1:
	       	ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 1, 1, 1, 1);
	    case 2:
	        ApplyAnimationEx(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0, 0, 1, 1, 1, -1);
   		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /dead [1-2]");
	}
	return 1;
}

CMD:joint(playerid, params[])
{
    ApplyAnimationEx(playerid, "GANGS", "smkcig_prtl", 4.0, 0, 1, 1, 1, 1);
	return 1;
}

CMD:benddown(playerid, params[])
{
    ApplyAnimationEx(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:checkout(playerid, params[])
{
    ApplyAnimationEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:carry(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0999, 0, 0, 0, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "CARRY", "liftup", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CARRY", "liftup05", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CARRY", "liftup105", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CARRY", "putdwn", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CARRY", "putdwn05", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "CARRY", "putdwn105", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			SetPlayerSpecialActionEx(playerid, 25);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /carry [1-8]");
	}
	return 1;
}

CMD:hide(playerid, params[])
{
    ApplyAnimationEx(playerid, "ped", "cower", 4.0, 1, 0, 0, 0, 0);
    return 1;
}

CMD:what(playerid, params[])
{
    switch(strval(params))
	{
	    case 1:
			ApplyAnimationEx(playerid,"RIOT","RIOT_ANGRY", 4.0, 0, 0, 0, 0, 0);
		case 2:
			ApplyAnimationEx(playerid,"benchpress","gym_bp_celebrate", 4.0, 0, 0, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /what [1-2]");
    }
    return 1;
}

CMD:think(playerid, params[])
{
    ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 0, 1, 1, 1, 1);
    return 1;
}

CMD:chill(playerid, params[])
{
    switch(strval(params))
    {
		case 1:
			ApplyAnimationEx(playerid, "RAPPING", "RAP_A_Loop", 4.1, 1, 1, 1, 1, 1);
		case 2:
			ApplyAnimationEx(playerid, "RAPPING", "RAP_A_OUT", 4.1, 0, 1, 1, 1, 1);
		case 3:
			ApplyAnimationEx(playerid, "RAPPING", "RAP_B_Loop", 4.1, 1, 1, 1, 1, 1);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /chill [1-3]");
    }
    return 1;
}

CMD:face(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "facanger", 4.0999, 0, 0, 0, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "facanger", 4.0999, 0, 0, 0, 1, 1, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "facgum", 4.0999, 1, 0, 0, 1, 1, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "facsurp", 4.0999, 0, 0, 0, 1, 1, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "facsurpm", 4.0999, 0, 0, 0, 1, 1, 0);
		case 6:
			ApplyAnimationEx(playerid, "PED", "factalk", 4.0999, 1, 0, 0, 1, 1, 0);
		case 7:
			ApplyAnimationEx(playerid, "PED", "facurios", 4.0999, 0, 0, 0, 1, 1, 0);
		case 8:
			ApplyAnimationEx(playerid, "PED", "Idle_Gang1", 4.0999, 0, 0, 0, 1, 1, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /face [1-8]");
	}
	return 1;
}

CMD:scared(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "cower", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "DUCK_cower", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_cower", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_hide", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_point", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_shout", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /scared [1-7]");
	}
	return 1;
}

CMD:roll(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "Crouch_Roll_L", 4.0, 0, 1, 1, 0, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "Crouch_Roll_R", 4.0, 0, 1, 1, 0, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "EV_dive", 4.0, 0, 1, 1, 0, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "CAR_rollout_LHS", 4.0, 0, 1, 1, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /roll [1-4]");
	}
	return 1;
}

CMD:fall(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "FLOOR_hit", 4.0999, 0, 1, 1, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "FLOOR_hit_f", 4.0999, 0, 1, 1, 1, 1, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /fall [1-2]");
	}
	return 1;
}

CMD:crawl(playerid, params[])
{
	ApplyAnimationEx(playerid, "PED", "CAR_crawloutRHS", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:ringanim(playerid, params[])
{
	ApplyAnimationEx(playerid, "PED", "Walk_DoorPartial", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:gunkick(playerid, params[])
{
	ApplyAnimationEx(playerid, "PED", "GUN_BUTT", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:shot(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "KO_shot_face", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "KO_shot_front", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "KO_shot_stom", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PED", "KO_skid_back", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /shot [1-5]");
	}
	return 1;
}

CMD:gas(playerid, params[])
{
	ApplyAnimationEx(playerid, "PED", "gas_cwr", 4.0999, 1, 1, 1, 0, 0, 0);
	return 1;
}

CMD:spin(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PED", "KO_spin_L", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "KO_spin_R", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /spin [1-2]");
	}
	return 1;
}

CMD:asex(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SNM", "SPANKING_IDLEW", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SNM", "SPANKING_IDLEP", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SNM", "SPANKINGW", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SNM", "SPANKINGP", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "SNM", "SPANKEDW", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "SNM", "SPANKEDP", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "SNM", "SPANKING_ENDW", 4.0999, 1, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "SNM", "SPANKING_ENDP", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /asex [1-8]");
	}
	return 1;
}

CMD:reload(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PYTHON", "python_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SILENCED", "Silence_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "TEC", "TEC_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "UZI", "UZI_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "COLT45", "sawnoff_reload", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /reload [1-7]");
	}
	return 1;
}

CMD:riot(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_challenge", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_CHANT", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_FUKU", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_PUNCHES", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "RIOT", "RIOT_shout", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /riot [1-7]");
	}
	return 1;
}

CMD:deejay(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.0999, 1, 0, 0, 0, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.0999, 1, 0, 0, 0, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.0999, 1, 0, 0, 0, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.0999, 1, 0, 0, 0, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "SCRATCHING", "sclng_l", 4.0999, 1, 0, 0, 0, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "SCRATCHING", "sclng_r", 4.0999, 1, 0, 0, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /deejay [1-6]");
	}
	return 1;
}

CMD:cop(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_nod", 4.0999, 1, 0, 0, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_shake", 4.0999, 1, 0, 0, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0999, 1, 0, 0, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_out", 4.0999, 0, 0, 0, 0, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.0999, 0, 0, 0, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_think", 4.0999, 0, 0, 0, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.0999, 0, 0, 0, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "POLICE", "CopTraf_Away", 4.0999, 0, 0, 0, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "POLICE", "CopTraf_Come", 4.0999, 0, 0, 0, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "POLICE", "CopTraf_Left", 4.0999, 0, 0, 0, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "POLICE", "CopTraf_Stop", 4.0999, 0, 0, 0, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "POLICE", "COP_getoutcar_LHS", 4.0999, 0, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "POLICE", "Cop_move_FWD", 4.0999, 0, 1, 1, 1, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "POLICE", "crm_drgbst_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "POLICE", "Door_Kick", 4.0999, 0, 1, 1, 0, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "POLICE", "plc_drgbst_01", 4.0999, 0, 0, 0, 0, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "POLICE", "plc_drgbst_02", 4.0999, 0, 0, 0, 0, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /cop [1-18]");
	}
	return 1;
}

CMD:console(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loose", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CRIB", "PED_Console_Win", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /console [1-3]");
	}
	return 1;
}

CMD:dancer(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "DANCING", "bd_clap", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "DANCING", "bd_clap1", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.0999, 1, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.0999, 1, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.0999, 1, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "DANCING", "dnce_M_d", 4.0999, 1, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.0999, 1, 1, 1, 1, 1, 0);
		case 14:
		    ApplyAnimationEx(playerid, "WOP", "Dance_G1", 4.0999, 1, 1, 1, 1, 1, 1);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /dancer [1-13]");
	}
	return 1;
}

CMD:parkour(playerid, params[]) {
	ApplyAnimationEx(playerid, "DAM_JUMP", "DAM_Dive_Loop", 4.0999, 1, 1, 1, 0, 0, 0);
	return 1;
}

CMD:beach(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SUNBATHE", "batherdown", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SUNBATHE", "batherup", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.0999, 0, 1, 1, 1, 1, 0);
		case 6:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.0999, 0, 1, 1, 1, 1, 0);
		case 7:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.0999, 0, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.0999, 0, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.0999, 0, 1, 1, 1, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.0999, 0, 1, 1, 1, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /beach [1-18]");
	}
	return 1;
}

CMD:bombs(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_2Idle", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Crouch_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Loop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "MISC", "Plunger_01", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /bombs [1-7]");
	}
	return 1;
}

CMD:camera(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CAMERA", "camcrch_cmon", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CAMERA", "camcrch_idleloop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CAMERA", "camcrch_to_camstnd", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CAMERA", "camstnd_cmon", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CAMERA", "camstnd_idleloop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CAMERA", "camstnd_lkabt", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "CAMERA", "camstnd_to_camrcrch", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "CAMERA", "piccrch_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "CAMERA", "piccrch_take", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "CAMERA", "picstnd_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "CAMERA", "picstnd_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "CAMERA", "picstnd_take", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /camera [1-12]");
	}
	return 1;
}

CMD:fixcar(playerid, params[])
{
	switch(strval(params)) 
	{
		case 1:
			ApplyAnimationEx(playerid, "CAR", "Fixn_Car_Loop", 1.0, 0, 1, 0, 1, 1, 1);
		case 2:
			ApplyAnimationEx(playerid, "CAR", "Fix_Car_Out", 4.0999, 0, 0, 0, 0, 0, 1);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /fixcar [1-2]");
	}
	return 1;
}

CMD:catchbox(playerid, params[])
{
    ApplyAnimationEx(playerid, "BOX", "catch_box", 4.0999, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:gateopenanim(playerid, params[])
{
    ApplyAnimationEx(playerid, "AIRPORT", "thrw_barl_thrw", 4.0999, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:dropflag(playerid, params[])
{
	ApplyAnimationEx(playerid, "CAR", "flag_drop", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:caranim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopA", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopB", 4.0999, 1, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.0999, 1, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc1_BL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.0999, 0, 1, 1, 1, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.0999, 0, 1, 1, 1, 0, 0);
		case 19:
		    ApplyAnimationEx(playerid, "PED", "CAR_tune_radio", 4.0999, 0, 1, 1, 1, 0, 1);

		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /caranim [1-19]");
	}
	return 1;
}

CMD:carhide(playerid, params[])
{
    ApplyAnimationEx(playerid, "PED", "CAR_dead_RHS", 4.0999, 0, 1, 1, 1, 0, 1);
	return 1;
}

CMD:casinoanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CASINO", "cards_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CASINO", "cards_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CASINO", "cards_lose", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CASINO", "cards_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CASINO", "cards_pick_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CASINO", "cards_pick_02", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "CASINO", "cards_raise", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "CASINO", "cards_win", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "CASINO", "dealone", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "CASINO", "manwinb", 4.0999, 0, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "CASINO", "manwind", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_bet", 4.0999, 0, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_lose", 4.0999, 0, 1, 1, 1, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "CASINO", "Roulette_win", 4.0999, 0, 1, 1, 1, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "CASINO", "Slot_bet_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 19:
			ApplyAnimationEx(playerid, "CASINO", "Slot_bet_02", 4.0999, 0, 1, 1, 1, 0, 0);
		case 20:
			ApplyAnimationEx(playerid, "CASINO", "Slot_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 21:
			ApplyAnimationEx(playerid, "CASINO", "Slot_lose_out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 22:
			ApplyAnimationEx(playerid, "CASINO", "Slot_Plyr", 4.0999, 0, 1, 1, 1, 0, 0);
		case 23:
			ApplyAnimationEx(playerid, "CASINO", "Slot_wait", 4.0999, 0, 1, 1, 1, 0, 0);
		case 24:
			ApplyAnimationEx(playerid, "CASINO", "Slot_win_out", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /casinoanim [1-24]");
	}
	return 1;
}

CMD:clothesanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Buy", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Hat", 4.0999, 1, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_In_O", 4.0999, 0, 0, 0, 0, 1, 0);
		case 7:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Legs", 4.0999, 1, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Out_O", 4.0999, 0, 0, 0, 0, 1, 0);
		case 11:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Shoes", 4.0999, 1, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Torso", 4.0999, 1, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "CLOTHES", "CLO_Pose_Watch", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /clothesanim [1-13]");
	}
	return 1;
}

CMD:dodge(playerid, params[])
{
	ApplyAnimationEx(playerid, "DODGE", "Crush_Jump", 4.0999, 0, 1, 1, 0, 0, 0);
	return 1;
}

CMD:gym(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "Freeweights", "gym_barbell", 4.0999, 1, 0, 0, 0, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_A", 4.0999, 0, 0, 0, 0, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_B", 4.0999, 0, 0, 0, 0, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_celebrate", 4.0999, 0, 0, 0, 0, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_down", 4.0999, 0, 0, 0, 0, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_pickup", 4.0999, 0, 0, 0, 0, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_putdown", 4.0999, 0, 0, 0, 0, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "Freeweights", "gym_free_up_smooth", 4.0999, 0, 0, 0, 0, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.0999, 0, 0, 0, 0, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.0999, 1, 0, 0, 0, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_getoff", 4.0999, 0, 0, 0, 0, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.0999, 0, 0, 0, 0, 0, 0);
		case 14:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.0999, 1, 0, 0, 0, 0, 0);
		case 15:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.0999, 1, 0, 0, 0, 0, 0);
		case 16:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.0999, 1, 0, 0, 0, 0, 0);
		case 17:
			ApplyAnimationEx(playerid, "PED", "XPRESSscratch", 4.0999, 1, 0, 0, 0, 0, 0);
		case 18:
			ApplyAnimationEx(playerid, "PLAYIDLES", "stretch", 4.0999, 1, 0, 0, 0, 0, 0);
		case 19:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_bike_faster", 4.0999, 1, 0, 0, 0, 0, 0);
		case 20:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_bike_pedal", 4.0999, 1, 0, 0, 0, 0, 0);
		case 21:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.0999, 0, 0, 0, 0, 0, 0);
		case 22:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_falloff", 4.0999, 0, 0, 0, 0, 0, 0);
		case 23:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_getoff", 4.0999, 0, 0, 0, 0, 0, 0);
		case 24:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_geton", 4.0999, 0, 0, 0, 0, 0, 0);
		case 25:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_jog", 4.0999, 0, 0, 0, 0, 0, 0);
		case 26:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_sprint", 4.0999, 0, 0, 0, 0, 0, 0);
		case 27:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_tired", 4.0999, 0, 0, 0, 0, 0, 0);
		case 28:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_walk", 4.0999, 0, 0, 0, 0, 0, 0);
		case 29:
			ApplyAnimationEx(playerid, "GYMNASIUM", "gym_walk_falloff", 4.0999, 0, 0, 0, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /gym [1-29]");
	}
	return 1;
}

CMD:no(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "GANGS", "Invite_No", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PED", "endchat_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PED", "endchat_02", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /no [1-3]");
	}
	return 1;
}

CMD:lookaround(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "lkaround_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "lkup_loop", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /lookaround [1-2]");
	}
	return 1;
}

CMD:point(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "lkup_point", 4.0999, 0, 0, 0, 1, 1, 1);
		case 2:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_shout", 4.0999, 0, 0, 0, 1, 1, 1);
		case 3:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0999, 0, 0, 0, 1, 1, 1);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /point [1-3]");
	}
	return 1;
}

CMD:panicanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_loop", 4.0999, 0, 0, 0, 0, 1, 1);
		case 2:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_point", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_shout", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_hide", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_cower", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /panicanim [1-5]");
	}
	return 1;
}

CMD:shoutanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_01", 4.0999, 0, 1, 1, 1, 1, 1);
		case 2:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_02", 4.0999, 0, 1, 1, 1, 1, 1);
		case 3:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_in", 4.0999, 0, 1, 1, 1, 1, 1);
		case 4:
			ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_loop", 4.0999, 0, 1, 1, 1, 1, 1);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /shoutanim [1-3]");
	}
	return 1;
}

CMD:giftanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "KISSING", "gift_get", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "KISSING", "gift_give", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /gift [1-2]");
	}
	return 1;
}

CMD:argue(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "KISSING", "GF_StreetArgue_01", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "KISSING", "GF_StreetArgue_02", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "KISSING", "GF_CarArgue_01", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "KISSING", "GF_CarArgue_02", 4.0999, 1, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /argue [1-4]");
	}
	return 1;
}

CMD:comeon(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "RYDER", "RYD_Beckon_01", 4.0999, 0, 0, 0, 1, 1, 0);
		case 2:
			ApplyAnimationEx(playerid, "RYDER", "RYD_Beckon_02", 4.0999, 0, 0, 0, 1, 1, 0);
		case 3:
			ApplyAnimationEx(playerid, "RYDER", "RYD_Beckon_03", 4.0999, 0, 0, 0, 1, 1, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /comeon [1-3]");
	}
	return 1;
}

CMD:serve(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_End", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_Idle", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_Loop", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_Start", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /serve [1-4]");
	}
	return 1;
}

CMD:idles(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "PLAYIDLES", "shift", 4.0999, 1, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "PLAYIDLES", "shldr", 4.0999, 1, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "PLAYIDLES", "strleg", 4.0999, 1, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "PLAYIDLES", "time", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.0999, 0, 1, 1, 0, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /idles [1-5]");
	}
	return 1;
}

CMD:windowanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "MISC", "bng_wndw", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "MISC", "bng_wndw_02", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /windowanim [1-2]");
	}
	return 1;
}

CMD:hiker(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "MISC", "Hiker_Pose", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "MISC", "Hiker_Pose_L", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /hiker [1-2]");
	}
	return 1;
}

CMD:push(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "GANGS", "shake_cara", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "GANGS", "shake_carK", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "GANGS", "shake_carSH", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /push [1-3]");
	}
	return 1;
}

CMD:shakehead(playerid, params[])
{
	ApplyAnimationEx(playerid, "MISC", "plyr_shkhead", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:gro(playerid, params[])
{
	ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.0999, 0, 1, 1, 1, 0, 0);
	return 1;
}

CMD:parksit(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /parksit [1-9]");
	}
	return 1;
}

CMD:hairanim(playerid, params[])
{
	switch(strval(params)) {
		case 1:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Beard_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Buy", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Cut", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Cut_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Cut_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Hair_01", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Hair_02", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Sit_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 12:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Sit_Loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 13:
			ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Sit_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]:  /hairanim [1-13]");
	}
	return 1;
}

CMD:cribanim(playerid, params[])
{
	switch(strval(params))
	{
		case 1:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_In_L", 4.0999, 0, 1, 1, 1, 0, 0);
		case 2:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_In_R", 4.0999, 0, 1, 1, 1, 0, 0);
		case 3:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_L", 4.0999, 0, 1, 1, 1, 0, 0);
		case 4:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_R", 4.0999, 0, 1, 1, 1, 0, 0);
		case 5:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Out_L", 4.0999, 0, 1, 1, 1, 0, 0);
		case 6:
			ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Out_R", 4.0999, 0, 1, 1, 1, 0, 0);
		case 7:
			ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.0999, 0, 1, 1, 1, 0, 0);
		case 8:
			ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_Loop", 4.0999, 1, 1, 1, 1, 0, 0);
		case 9:
			ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_Out", 4.0999, 0, 1, 1, 1, 0, 0);
		case 10:
			ApplyAnimationEx(playerid, "INT_HOUSE", "wash_up", 4.0999, 1, 1, 1, 1, 0, 0);
		case 11:
			ApplyAnimationEx(playerid, "CRIB", "CRIB_Use_Switch", 4.0999, 0, 1, 1, 1, 0, 0);
		default:
			SendClientMessage(playerid, COLOR_RED, "[?]: /cribanim [1-11]");
	}
	return 1;
}

CMD:facepalm(playerid, params[])
{
	ApplyAnimationEx(playerid, "MISC", "plyr_shkhead", 4.0999, 0, 1, 1, 0, 0, 0);
	return 1;
}

CMD:counteranim(playerid, params[])
{
    ApplyAnimationEx(playerid, "WEAPONS", "SHP_Tray_Pose", 4.0999, 0, 1, 1, 1, 0, 1);
	return 1;
}
