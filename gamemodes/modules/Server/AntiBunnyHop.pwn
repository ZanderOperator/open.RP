/* 
*		   AntiBunnyHop - AC
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*	      All rights reserved.
*	     	   (c) 2019
*/

// reminder: Na svakom PayDay-u se resetiraju varijable.
#include <YSI\y_hooks>

/*
	- defines
*/
#define MAX_BUNNY_HOPS 	(6)
#define MAX_BH_WARNINGS (5) 

/*
	- player vars
*/
new
	bh_counter[ MAX_PLAYERS ] 	= (0),
	bh_warnings[ MAX_PLAYERS ] 	= (0);

/*
	- functions
*/
ResetBH_Script(user_id) {
	bh_counter	[ user_id ] 	= (0);
	bh_warnings	[ user_id ] 	= (0);
	return (true);
}
/*
	- hooks
*/
hook OnPlayerDisconnect(playerid, reason) 
	return ResetBH_Script(playerid);

hook OnPlayerConnect(playerid) 
	return ResetBH_Script(playerid);

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if(HOLDING(KEY_SPRINT)) {
		if(PRESSED(KEY_JUMP)) {
		    if(!IsPlayerInAnyVehicle(playerid)) {
				if(!Bit1_Get( gr_OnEvent, playerid)) {
				
					if(PlayerInfo[playerid][pAdmin] >= 4)
						return (true);
					if(ABH_Online == 0)
						return true;
						
					new buff[90];
					bh_counter[ playerid ] ++;
					if( bh_counter[ playerid ] > MAX_BUNNY_HOPS ) {
							
						ApplyAnimation( playerid, "GYMNASIUM", "gym_jog_falloff", 4.1,0,1,1,0,0 );
						bh_counter[ playerid ] 	= (0);
						bh_warnings[ playerid ] ++;
							
						va_SendClientMessage(playerid, COLOR_RED, "[WARNING]: Prestanite raditi bunny hop, to je zabranjeno na nasem serveru (%d/%d).", bh_warnings[ playerid ], MAX_BH_WARNINGS);
							
						format(buff, sizeof(buff), "*[ANTICHEAT]: Igrac %s neprestajno radi Bunny Hop (/recon %d).", GetName(playerid, true), playerid);
						BhearsBroadCast(COLOR_YELLOW, buff, 1);
							
						if(bh_warnings[ playerid ] == MAX_BH_WARNINGS) {
							SendClientMessage(playerid, COLOR_RED, "[ANTICHEAT]: Dobili ste kick sa servera zbog previse Bunny Hop-anja.");
							format(buff, sizeof(buff), "[BH ANTICHEAT]: Igrac %s je dobio kick zbog konstantnog bunny hop-a.", GetName(playerid, true));
							SendAdminMessage(COLOR_RED, buff);
			
							ResetBH_Script(playerid);
							KickMessage(playerid);
						}
					}
                }
			}
		}
	}
	return (true);
}
