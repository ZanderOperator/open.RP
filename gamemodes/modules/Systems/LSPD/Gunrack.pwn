#include <YSI\y_hooks>

new gunrackinuse[MAX_VEHICLES];
new
	gunrackWeapon	[2][MAX_VEHICLES],
	gunrackAmmo		[2][MAX_VEHICLES];
	
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_GUNRACK: {
		    if(!response)
		    {
				new vehicleid 	= 	GetPlayerVehicleID(playerid);
				gunrackinuse[vehicleid] = 0;
				return 1;
		    }
		    new
				vehicleid 	= 	GetPlayerVehicleID(playerid),
				weaponid 	= 	AC_GetPlayerWeapon(playerid),
				ammo 		=	AC_GetPlayerAmmo(playerid);
				
            gunrackinuse[vehicleid] = 0;
			switch(listitem)
			{
				case 0: //Slot 1
				{
				    if(gunrackWeapon[0][vehicleid] == 0 && weaponid == 0)
					{
      					SendClientMessage(playerid,COLOR_RED, "Nemate oruzje u rukama niti imate oruzja u gunracuku.");
						gunrackinuse[vehicleid] = 0;
						return 1;
     				}
					else if(gunrackWeapon[0][vehicleid] != 0 && weaponid == 0)
					{
						if (! CheckPlayerWeapons(playerid, gunrackWeapon[0][vehicleid]) ) return 1;
					    AC_GivePlayerWeapon(playerid, gunrackWeapon[0][vehicleid], gunrackAmmo[0][vehicleid]);
					    gunrackWeapon[0][vehicleid] = 0;
					    gunrackAmmo[0][vehicleid] = 0;
                        new string[128];
						format(string, sizeof(string), "> %s uzima oruzje iz gunracka Police Cruisera.", GetName(playerid));
    					SendClientMessage(playerid, COLOR_PURPLE, string);
    					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
					    gunrackinuse[vehicleid] = 0;
					    return 1;
					}
					else if(gunrackWeapon[0][vehicleid] == 0 && weaponid != 0)
					{
                        gunrackWeapon[0][vehicleid] = weaponid;
                        gunrackAmmo[0][vehicleid] = ammo;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        gunrackinuse[vehicleid] = 0;
                        new string[128];
						format(string, sizeof(string), "> %s posrema oruzje u gunrack Police Cruisera.", GetName(playerid));
    					SendClientMessage(playerid, COLOR_PURPLE, string);
    					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
    					SetPlayerArmedWeapon(playerid, 0);
                        return 1;
                        
					}
					else if(gunrackWeapon[0][vehicleid] != 0 && weaponid != 0)
					{
						if (! CheckPlayerWeapons(playerid, gunrackWeapon[0][vehicleid]) ) return 1;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        AC_GivePlayerWeapon(playerid, gunrackWeapon[0][vehicleid], gunrackAmmo[0][vehicleid]);
                        gunrackinuse[vehicleid] = 0;
     					gunrackWeapon[0][vehicleid] = weaponid;
                        gunrackAmmo[0][vehicleid] = ammo;
   						SendClientMessage(playerid, COLOR_RED, "[ ! ] Zamijenili ste oruzje u gunracku.");
						return 1;
					}
				}
				case 1: //Slot 2
				{
					if(gunrackWeapon[1][vehicleid] == 0 && weaponid == 0)
	   				{
						SendClientMessage(playerid,COLOR_RED, "Nemate oruzje u rukama niti imate oruzja u gunracuku.");
						gunrackinuse[vehicleid] = 0;
						return 1;
					}
					else if(gunrackWeapon[1][vehicleid] != 0 && weaponid == 0)
					{
						if (! CheckPlayerWeapons(playerid, gunrackWeapon[1][vehicleid]) ) return 1;
					    AC_GivePlayerWeapon(playerid, gunrackWeapon[1][vehicleid], gunrackAmmo[1][vehicleid]);
					    gunrackWeapon[1][vehicleid] = 0;
					    gunrackAmmo[1][vehicleid] = 0;
					    gunrackinuse[vehicleid] = 0;
					    new string[128];
					    format(string, sizeof(string), "> %s uzima %s iz gunracka Police Cruisera.", GetName(playerid), gunrackWeapon[1]);
    					SendClientMessage(playerid, COLOR_PURPLE, string);
    					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
					    return 1;
					}
					else if(gunrackWeapon[1][vehicleid] == 0 && weaponid != 0)
					{
                        gunrackWeapon[1][vehicleid] = weaponid;
                        gunrackAmmo[1][vehicleid] = ammo;
                        gunrackinuse[vehicleid] = 0;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        new string[128];
                        format(string, sizeof(string), "> %s posrema oruzje u gunrack Police Cruisera.", GetName(playerid));
    					SendClientMessage(playerid, COLOR_PURPLE, string);
    					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
    					SetPlayerArmedWeapon(playerid, 0);
                        return 1;

					}
					else if(gunrackWeapon[1][vehicleid] != 0 && weaponid != 0)
					{
						if (! CheckPlayerWeapons(playerid, gunrackWeapon[1][vehicleid]) ) return 1;
                        AC_ResetPlayerWeapon(playerid, weaponid);
                        AC_GivePlayerWeapon(playerid, gunrackWeapon[1][vehicleid], gunrackAmmo[1][vehicleid]);
                        gunrackinuse[vehicleid] = 0;
     					gunrackWeapon[1][vehicleid] = weaponid;
                        gunrackAmmo[1][vehicleid] = ammo;
						SendClientMessage(playerid, COLOR_RED, "[ ! ] Zamijenili ste oruzje u gunracku.");
						return 1;
     }
			 }
			}
		}
	}
	return 0;
}
CMD:gunrack(playerid, params[])
{
	if( !IsACop(playerid) && !IsASD(playerid) ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(VehicleInfo[vehicleid][vUsage] == VEHICLE_USAGE_FACTION && (VehicleInfo[vehicleid][vFaction] == 1 || VehicleInfo[vehicleid][vFaction] == 3))
	{
  		if(gunrackinuse[vehicleid] == 1) return SendClientMessage(playerid, COLOR_RED,"Pokusaj poslije.");
	    gunrackinuse[vehicleid] = 1;
	    new str[156],
		gun1[32],
		gun2[32];
		GetWeaponName(gunrackWeapon[0][vehicleid], gun1, sizeof(gun1));
		GetWeaponName(gunrackWeapon[1][vehicleid], gun2, sizeof(gun2));
		if(isnull(gun1))
		    format(gun1, sizeof(gun1), "Prazno");
		if(isnull(gun2))
		    format(gun2, sizeof(gun2), "Prazno");

	    format(str, sizeof(str),"Weapon\tAmmo\n\%s\t%i\n%s\t%i",gun1, gunrackAmmo[0][vehicleid], gun2, gunrackAmmo[1][vehicleid]);
	    ShowPlayerDialog(playerid, DIALOG_GUNRACK, DIALOG_STYLE_TABLIST_HEADERS, "Police Gunrack",str, "Odaberi", "Odustani");
	}
	else SendClientMessage(playerid,COLOR_RED, "Niste u vozilu LSPDa.");
	return 1;
}

new wepID[MAX_PLAYERS];

SetPlayerArmedWeaponEx(playerid, weaponid)
{
    wepID[playerid] = weaponid;
    PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
    return SetPlayerArmedWeapon(playerid, weaponid);
}

IsBulletWeapon(weaponid)
    return (WEAPON_COLT45 <= weaponid < WEAPON_SNIPER);
 

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_PASSENGER)
    {
        wepID[playerid] = GetPlayerWeapon(playerid);
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && IsBulletWeapon(wepID[playerid]) && GetPlayerCameraMode(playerid) != 55)
    {
        if(newkeys & KEY_LOOK_RIGHT)
        {
            new curWeap = wepID[playerid], weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;
           
            for(new i = weapSlot + 1; i <= 7; i++)
            {
                GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
                if(IsBulletWeapon(weapID) && weapID != curWeap)
                {
                    SetPlayerArmedWeaponEx(playerid, weapID);
                    break;
                }
            }
        }
        if(newkeys & KEY_LOOK_LEFT)
        {
            new curWeap = wepID[playerid], weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;
           
            for(new i = weapSlot - 1; i >= 2; i--)
            {
                GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
                if(IsBulletWeapon(weapID) && weapID != curWeap)
                {
                    SetPlayerArmedWeaponEx(playerid, weapID);
                    break;
                }
            }
        }
    }
 
    return 1;
}
