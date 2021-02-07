#include <YSI_Coding\y_hooks>

static
	bool:ForbiddenPM[MAX_PLAYERS],
	bool:Entering[MAX_PLAYERS],
	bool:Exiting[MAX_PLAYERS];

bool: Player_ForbiddenPM(playerid)
{
	return ForbiddenPM[playerid];
}

Player_SetForbiddenPM(playerid, bool:v)
{
	ForbiddenPM[playerid] = v;
}

hook function ResetPlayerVariables(playerid)
{
	RemovePlayerScreenFade(playerid);
	ForbiddenPM[playerid] = false;
	Entering[playerid] = false;
	Exiting[playerid] = false;
	return continue(playerid);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_NO))
    {
        if(Entering[playerid])
        {
            Entering[playerid] = false;
            TogglePlayerControllable(playerid, true);
            return 1;
        }
        else if(Exiting[playerid])
        {
            Exiting[playerid] = false;
            TogglePlayerControllable(playerid, true);
            return 1;
        }
	}
	if(PRESSED(KEY_SECONDARY_ATTACK)) 
	{
        if(Bit1_Get( gr_SmokingCiggy, playerid))
		{
	        SetPlayerSpecialAction(playerid,0);
	        Bit1_Set( gr_SmokingCiggy, playerid, false);

			new
				tmpString[50];
		  	format(tmpString, sizeof(tmpString), "* %s puts out a cigarette.",
				GetName(playerid, true)
			);
		  	ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		if(Player_HasDrink(playerid))
		{
	        SetPlayerSpecialAction(playerid,0);
	        Player_SetHasDrink(playerid, false);

			new
				tmpString[50];
		  	format(tmpString, sizeof(tmpString), "* %s puts his drink aside.",
				GetName(playerid, true)
			);
		  	ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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

CMD:enter(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 366.544769, 158.641189, 1008.382812))
    {
        SetPlayerPosEx(playerid, 1122.9961, -2036.8920, 1701.0578, 25, 2, true);
        return 1;
    }

    if(IsPlayerInDynamicCP(playerid, Player_GetPickupCP(playerid)))
    {
		new 
			pickup = Player_InfrontPickup(playerid);
		if(pickup == -1) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred pickupa (niste u checkpointu)!");
		if(PlayerFaction[playerid][pMember] == PickupInfo[pickup][epOrganizations] ||
			PlayerFaction[playerid][pLeader] == PickupInfo[pickup][epOrganizations] ||
			PlayerJob[playerid][pJob] == PickupInfo[pickup][epJob] ||
			PickupInfo[pickup][epOrganizations] == 255 ||
			PickupInfo[pickup][epJob] == 255)
		{
			SetPlayerPosEx(playerid,PickupInfo[pickup][epExitx],PickupInfo[pickup][epExity],PickupInfo[pickup][epExitz],PickupInfo[pickup][epViwo],PickupInfo[pickup][epInt],true);
			GameTextForPlayer(playerid, PickupInfo[pickup][epDiscription], 500, 1);
			Player_SetInPickup(playerid, pickup);

			Entering[playerid] = true;
			TogglePlayerControllable(playerid, false);
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
		}
		else GameTextForPlayer(playerid, "~r~Zakljucano", 5000, 1);
    }
	else if(IsPlayerInDynamicArea(playerid, Player_GarageArea(playerid)))
	{
		new 
			garage = Player_InfrontGarage(playerid);
		if(garage == -1)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred garaze!");

		if(PlayerInfo[playerid][pSQLID] != GarageInfo[garage][gOwnerID] && !Admin_OnDuty(playerid) && !GarageInfo[garage][gLocked])
		{
			GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
			return 1;
		}

		if(GarageInfo[garage][gOwnerID] == PlayerInfo[playerid][pSQLID])
			GameTextForPlayer(playerid, "~w~Dobrodosli u garazu", 800, 1);
		
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || vehicleid == INVALID_VEHICLE_ID)
			SetPlayerPosEx(playerid, GarageInfo[garage][gExitX], GarageInfo[garage][gExitY], GarageInfo[garage][gExitZ], GarageInfo[garage][gSQLID], 5, true);
		else
		{
			TogglePlayerControllable(playerid, 0);

			new Float:X, Float:Y, Float:Z, Float:A;
			GetVehiclePos(vehicleid, X, Y, Z);
			GetVehicleZAngle(vehicleid, A);

			PlayerSafeExit[playerid][giX] = X;
			PlayerSafeExit[playerid][giY] = Y;
			PlayerSafeExit[playerid][giZ] = Z;
			PlayerSafeExit[playerid][giRZ] = A;
			SetVehiclePosEx(playerid, GarageInfo[garage][gExitX], GarageInfo[garage][gExitY] + 1.5, GarageInfo[garage][gExitZ], GarageInfo[garage][gSQLID], 5, true);
			SetVehicleZAngle(vehicleid, 90.0);
		}
		Player_SetInGarage(playerid, garage);
		DestroyGarageInfoTD(playerid);
	}
    else if(IsPlayerInDynamicCP(playerid, Player_GetBizzCP(playerid)))
    {
		new biznis = Player_InfrontBizz(playerid);
		if(biznis == INVALID_BIZNIS_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred biznisa (niste u checkpointu)!");
        if(!BizzInfo[biznis][bCanEnter]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete uci u ovaj biznis!");

        if(PlayerKeys[playerid][pBizzKey] != biznis && BizzInfo[biznis][bLocked])
        {
            GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
            return 1;
        }
        if(BizzInfo[biznis][bEntranceCost] != 0 && !Admin_OnDuty(playerid) && PlayerKeys[playerid][pBizzKey] != biznis)
        {
            if(AC_GetPlayerMoney(playerid) < BizzInfo[biznis][bEntranceCost]) 
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novca da platite ulaz!");
            PlayerToBusinessMoneyTAX(playerid, biznis, BizzInfo[biznis][bEntranceCost]); // Novac ide u blagajnu od biznisa, a oporezivi dio drZavi
        }
        if(!isnull(BizzInfo[biznis][bMusicURL]))
        {
            StopAudioStreamForPlayer(playerid);
            PlayAudioStreamForPlayer(playerid, BizzInfo[biznis][bMusicURL]);
        }
        if(BizzInfo[biznis][bFurLoaded] == false) 
			ReloadBizzFurniture(biznis);

        SetPlayerPosEx(playerid, BizzInfo[biznis][bExitX], BizzInfo[biznis][bExitY], BizzInfo[biznis][bExitZ], BizzInfo[biznis][bVirtualWorld], BizzInfo[biznis][bInterior], true);
        Player_SetInBusiness(playerid, biznis);
        DestroyBizzInfoTD(playerid);

        Entering[playerid] = true;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
    }
    else if(IsPlayerInDynamicCP(playerid, Player_GetComplexCP(playerid)))
    {
		new 
			complex = Player_InfrontComplex(playerid);
		if(complex == INVALID_COMPLEX_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred Complexa (niste u checkpointu)!");
        
		SetPlayerPosEx(playerid, ComplexInfo[complex][cExitX], ComplexInfo[complex][cExitY], ComplexInfo[complex][cExitZ], ComplexInfo[complex][cViwo], ComplexInfo[complex][cInt], true);
        Player_SetInApartmentComplex(playerid, complex);
		DestroyCompInfoTD(playerid);
       
	    if(PlayerKeys[playerid][pComplexKey] == complex)
            GameTextForPlayer(playerid, "Dobrodosli u svoj Complex!", 500, 1);

        Entering[playerid] = true;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
    }
	else if(IsPlayerInDynamicCP(playerid, Player_GetApartmentCP(playerid)))
    {
		new 
			rcomplex = Player_InfrontApartment(playerid);
		if(rcomplex == INVALID_COMPLEX_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred stana (niste u checkpointu)!");
        if(!ComplexRoomInfo[rcomplex][cActive]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Soba nije u funkciji!");

        if(PlayerKeys[playerid][pComplexRoomKey] != rcomplex && !Admin_OnDuty(playerid) && ComplexRoomInfo[rcomplex][cLock])
        {
            GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);
            return 1;
        }

		if(PlayerKeys[playerid][pComplexRoomKey] == rcomplex)
        	GameTextForPlayer(playerid, "Dobrodosli!", 500, 1);

        SetPlayerPosEx(playerid, ComplexRoomInfo[rcomplex][cExitX], ComplexRoomInfo[rcomplex][cExitY], ComplexRoomInfo[rcomplex][cExitZ], ComplexRoomInfo[rcomplex][cViwo], ComplexRoomInfo[rcomplex][cInt], true);
        Player_SetInApartmentRoom(playerid, rcomplex);
		DestroyCompInfoTD(playerid);
    }
    else if(IsPlayerInDynamicCP(playerid, Player_GetHouseCP(playerid)))
    {
        new 
			house = Player_InfrontHouse(playerid);
        if(house == INVALID_HOUSE_ID) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred kuce (niste u checkpointu)!");
        if(HouseInfo[house][h3dViwo] != GetPlayerVirtualWorld(playerid))
        {
            SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ispred biznisa ili kuce!");
            return 1;
        }
        if(HouseInfo[house][hDoorCrashed]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrata su stradala u pozaru, vatrogasac mora koristiti /ramdoors!");
		if(PlayerKeys[playerid][pHouseKey] != house && !Admin_OnDuty(playerid) && HouseInfo[house][hLock] && PlayerKeys[playerid][pRentKey] != house)
            return GameTextForPlayer(playerid, "~r~Zakljucano", 1000, 1);

        if(HouseInfo[house][hOwnerID] == PlayerInfo[playerid][pSQLID])
            GameTextForPlayer(playerid, "~w~Dobrodosli kuci", 800, 1);
        
        if(HouseInfo[house][hFurLoaded] == false)
            ReloadHouseFurniture(house);
        
        SetPlayerPosEx(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ], HouseInfo[house][hVirtualWorld], HouseInfo[house][hInt], true);

        Player_SetInHouse(playerid, house);
        DestroyHouseInfoTD(playerid);

        if(IsHousePlayingMusic(house))
        {
            StopAudioStreamForPlayer(playerid);
            new url[256];
            format(url, sizeof(url), "%s",ReturnHouseMusicURL(house));
            PlayAudioStreamForPlayer(playerid, url);
        }

        Entering[playerid] = true;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");

		if(rob_started[playerid] == true)
        	PlayStorageAlarm(playerid, false);
    }
    return 1;
}

CMD:exit(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 1122.9961, -2036.8920, 1701.0578))
    {
        SetPlayerPosEx(playerid, 366.544769, 158.641189, 1008.382812, 0, 3, true);
        return 1;
    }

    new
        house    	= Player_InHouse(playerid),
        biznis   	= Player_InBusiness(playerid),
		complex		= Player_InApartmentComplex(playerid),
        rcomplex 	= Player_InApartmentRoom(playerid),
        garage   	= Player_InGarage(playerid),
		pickup 		= Player_InPickup(playerid);

    if(Pickup_Exists(PICKUP_TYPE_ENTERABLE, pickup))
    {
        Player_SetInPickup(playerid, -1);
        SetPlayerPosEx(playerid,PickupInfo[pickup][epEntrancex], PickupInfo[pickup][epEntrancey], PickupInfo[pickup][epEntrancez], PickupInfo[pickup][epEnterViwo], PickupInfo[pickup][epEnterInt], true);

        Exiting[playerid] = false;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
        return 1;
    }
    else if(Complex_Exists(complex))
    {
        Player_SetInApartmentComplex(playerid, INVALID_COMPLEX_ID);
        SetPlayerPosEx(playerid, ComplexInfo[complex][cEnterX], ComplexInfo[complex][cEnterY], ComplexInfo[complex][cEnterZ], 0, 0, false);

        Exiting[playerid] = false;
        TogglePlayerControllable(playerid, false);
        SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
        return 1;
    }
	else if(ComplexRoom_Exists(rcomplex))
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, ComplexRoomInfo[rcomplex][cExitX], ComplexRoomInfo[rcomplex][cExitY], ComplexRoomInfo[rcomplex][cExitZ]))
        {
            SetPlayerPosEx(playerid, ComplexRoomInfo[rcomplex][cEnterX], ComplexRoomInfo[rcomplex][cEnterY], ComplexRoomInfo[rcomplex][cEnterZ], ComplexRoomInfo[rcomplex][cVWExit], ComplexRoomInfo[rcomplex][cIntExit]);
            Player_SetInApartmentRoom(playerid, INVALID_COMPLEX_ID);
            StopAudioStreamForPlayer(playerid);

            Exiting[playerid] = false;
            TogglePlayerControllable(playerid, false);
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
        }
        return 1;
    }
    else if(Bizz_Exists(biznis))
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, BizzInfo[biznis][bExitX], BizzInfo[biznis][bExitY], BizzInfo[biznis][bExitZ]))
        {
            if(GetPlayerSkin(playerid) != PlayerAppearance[playerid][pSkin] && !Player_OnLawDuty(playerid))
            {
                new biztype = BizzInfo[biznis][bType];
                if(biztype == BIZZ_TYPE_SUBURBAN || biztype == BIZZ_TYPE_PROLAPS || biztype == BIZZ_TYPE_ZIP || biztype == BIZZ_TYPE_BINCO)
                {
                    SendClientMessage(playerid, COLOR_RED, "[!] Izasli ste iz biznisa te ste odustali od kupnje skina!");
                    ResetBuySkin(playerid);
                }
            }
			
            SetPlayerPosEx(playerid, BizzInfo[biznis][bEntranceX], BizzInfo[biznis][bEntranceY], BizzInfo[biznis][bEntranceZ], 0, 0, false);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            Player_SetInBusiness(playerid, INVALID_BIZNIS_ID);
            StopAudioStreamForPlayer(playerid);

            Exiting[playerid] = false;
            TogglePlayerControllable(playerid, false);
            SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
            return 1;
        }
    }
    else if(Garage_Exists(garage))
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, GarageInfo[garage][gExitX], GarageInfo[garage][gExitY], GarageInfo[garage][gExitZ]))
        {
            StopAudioStreamForPlayer(playerid);
            if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            {
                SetPlayerPosEx(playerid, GarageInfo[garage][gEnterX], GarageInfo[garage][gEnterY], GarageInfo[garage][gEnterZ], 0, 0, true);
            }
            else if(IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new vehicleid = GetPlayerVehicleID(playerid);

                SetVehiclePos(vehicleid, PlayerSafeExit[playerid][giX],PlayerSafeExit[playerid][giY],PlayerSafeExit[playerid][giZ]);
                SetVehicleZAngle(vehicleid, PlayerSafeExit[playerid][giRZ]);
                foreach(new i : Player)
                {
                    if(IsPlayerInVehicle(i, vehicleid))
                    {
                        SetPlayerVirtualWorld(i, 0);
                    }
                }

                PlayerSafeExit[playerid][giX] = 0;
                PlayerSafeExit[playerid][giY] = 0;
                PlayerSafeExit[playerid][giZ] = 0;
                PlayerSafeExit[playerid][giRZ] = 0;

                SetVehicleVirtualWorld(vehicleid, 0);
                LinkVehicleToInterior(vehicleid, 0);

                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 0);
            }
            Player_SetInGarage(playerid, INVALID_HOUSE_ID);
        }
        return 1;
    }
    else if(House_Exists(house))
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]))
        {
            if(IsPlayerSafeBreaking(playerid))
                return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izaci van dok ne obijete sef!");

            StopAudioStreamForPlayer(playerid);

            if(HouseInfo[house][h3dViwo] > 0) // Apartments
            {
                Streamer_ToggleIdleUpdate(playerid, 1);
                TogglePlayerControllable(playerid, 0);
                defer InstantStreamerUpdate(playerid);

                SetPlayerVirtualWorld(playerid, HouseInfo[house][h3dViwo]);
                SetPlayerInterior(playerid, 20);
                SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY]+1.0, HouseInfo[house][hEnterZ], HouseInfo[house][h3dViwo], 20, true);

                Exiting[playerid] = false;
                TogglePlayerControllable(playerid, false);
                SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
            }
            else
            {
                SetPlayerPosEx(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ], 0, 0, false);
                Exiting[playerid] = false;
                TogglePlayerControllable(playerid, false);
                SendMessage(playerid, MESSAGE_TYPE_INFO, "Pritisnite tipku 'N' ukoliko vam se mapa loadala");
            }
            Player_SetInHouse(playerid, INVALID_HOUSE_ID);
            return 1;
        }
    }
    return 1;
}

CMD:time(playerid, params[])
{
    if(!PlayerInventory[playerid][pWatch])
		SendMessage(playerid,  MESSAGE_TYPE_ERROR, "You don't have a watch!");
		
	new mtext[20],year, month,day,
		timeString[91];
	getdate(year, month, day);
	
	switch(month) 
	{
		case 1:   mtext = "sij/jan"; 
		case 2:   mtext = "velj/feb"; 
		case 3:   mtext = "ozu/mar"; 
		case 4:   mtext = "tra/apr"; 
		case 5:   mtext = "svi/maj"; 
		case 6:   mtext = "lip/jun"; 
		case 7:   mtext = "srp/jul"; 
		case 8:   mtext = "kol/aug"; 
		case 9:   mtext = "ruj/sept"; 
		case 10:  mtext = "list/okt"; 
		case 11:  mtext = "stud/nov"; 
		case 12:  mtext = "pro/dec";
	}

	if(PlayerJail[playerid][pJailTime] > 0) 
		format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%s~g~|~n~~w~Jail Time: %d min", 
			day, 
			mtext, 
			ReturnTime(),
			PlayerJail[playerid][pJailTime]
		);
	else 
		format(timeString, sizeof(timeString), "~y~%d %s~n~~g~|~w~%s~g~|", 
			day, 
			mtext, 
			ReturnTime()
		);
	
	GameTextForPlayer(playerid, timeString, 5000, 1);
	format(timeString, sizeof(timeString), "* %s gleda koliko je sati.", GetName(playerid,true));
	ProxDetector(30.0, playerid, timeString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	if(!IsPlayerInAnyVehicle(playerid))
		ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,0,0,0,0,1,0);

    return 1;
}

CMD:taxcalculator(playerid, params[])
{
	new pick, iznos; 
	if(sscanf(params, "ii", pick, iznos)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /taxcalculator [opcija 1 ili 2][iznos]");
		SendClientMessage(playerid, -1, "OPCIJA 1: Dodaj porez na iznos ");
		SendClientMessage(playerid, -1, "OPCIJA 2: Makni porez sa iznosa");
		return 1;
	}
	if(0 >= iznos >= 9999999999) return SendClientMessage(playerid,COLOR_RED, "Krivi iznos!");
	
	// dodavanje TAXE
	new TAX = CityInfo[cTax], 								// Porez							10%
		Float:taxed = iznos * floatdiv(TAX,100),			// Oporezivo						100*0,1 = 10$
		taxedint = floatround(taxed),						// Zaokruzivanje					10
		addTAX = iznos + taxedint,							// Dodavanje poreza iznosu			100+10 = 110$
	// oduzimanje TAXE
		Float:withouttax = iznos / (1+floatdiv(TAX,100)),	// Oduzimanje poreza od iznosa		100 /1,10 = 91$
		withouttaxint = floatround(withouttax),				// zaokruzivanje iznosa				91
		removeTAX = iznos - withouttaxint;					// Oduzimanje taxe sa iznosa		100 - 91 = 9$
		
	switch( pick) 
	{
	    case 1: 
		{
			va_SendClientMessage(playerid, -1, "Iznos: %d $  | Trenutni porez: %d | Oporezivo: %d $", iznos, TAX, taxedint);
			va_SendClientMessage(playerid, COLOR_RED, "[!] Iznos sa porezom: %d $", addTAX);
		}
		case 2: 
		{
			va_SendClientMessage(playerid, -1, "Iznos: %d $ | Trenutni porez: %d | Oporezivo: %d $", iznos, TAX, removeTAX);
			va_SendClientMessage(playerid, COLOR_RED, "Iznos bez poreza: %d $", withouttaxint);
		}
	}
	return 1;
}

CMD:toganimchat(playerid, params[])
{
    if(	Bit1_Get( gr_animchat, playerid))
	{
		Bit1_Set( gr_animchat, playerid, false);
		SendClientMessage(playerid, COLOR_WHITE, "Chat animacije iskljucene!");
	}
	else
	{
		Bit1_Set( gr_animchat, playerid, true);
		SendClientMessage(playerid, COLOR_WHITE, "Chat animacije ukljucene!");
	}
	return 1;
}

CMD:levelup(playerid, params[])
{
	if(LevelUp(playerid))
	    GameTextForPlayer( playerid, "~g~Level up!", 1000, 1);
	else {
	    new expamount = ( PlayerInfo[playerid][pLevel] + 1) * 4;
	    SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Trebas imati %d respekta, a ti trenutno imas [%d]!",expamount,PlayerInfo[playerid][pRespects]);
	}
	return 1;
}

CMD:me(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
		
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /me [radnja]");
	new string[200];
	format(string, sizeof(string), "* %s %s", GetName(playerid), params);
	ProxDetector(22.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
   	return 1;
}

CMD:lowme(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted])
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /lowme [radnja]");
	new string[200];
	format(string, sizeof(string), "* %s %s", GetName(playerid), params);
	RealProxDetector(5.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
   	return 1;
}
CMD:ame(playerid, params[])
{
	new 
		string[128];
		
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	//if(Bit1_Get( gr_DeathCountStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete pricati, u post death stanju ste!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /ame [radnja]");
	format(string, sizeof(string), "> %s %s", GetName(playerid), params);
    SendClientMessage(playerid, COLOR_PURPLE, string);
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 20000);
   	return 1;
}
CMD:do(playerid, params[])
{
	new result[256];
		
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	//if(Bit1_Get( gr_DeathCountStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete pricati, u post death stanju ste!");
	if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, COLOR_RED, "[?]: /do [radnja]");

	format(result, sizeof(result), "* %s (( %s)).", params, GetName(playerid));
	ProxDetector(22.0, playerid, result, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}
CMD:lowdo(playerid, params[])
{
	new result[256];

	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, COLOR_RED, "[?]: /do [radnja]");

	format(result, sizeof(result), "* %s (( %s)).", params, GetName(playerid));
	RealProxDetector(5.0, playerid, result, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}
CMD:close(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	//if(Bit1_Get( gr_DeathCountStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete pricati, u post death stanju ste!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /(c)lose [poruka]");
	new string[128];
	params[0] = toupper(params[0]);
	if(IsPlayerInAnyVehicle(playerid)) {
		format(string, sizeof(string), "%s (vozilo) tiho %s: %s", GetName(playerid), PrintAccent(playerid), params);
		RealProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	} else {
		format(string, sizeof(string), "%s tiho %s: %s", GetName(playerid), PrintAccent(playerid), params);
		RealProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	}
	return 1;
}
CMD:shout(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	if(DeathCountStarted_Get(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete pricati, u post death stanju ste!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /(s)hout [poruka]");
	params[0] = toupper(params[0]);
	new string[128];
	if(IsPlayerInAnyVehicle(playerid)) {
		format(string, sizeof(string), "%s (vozilo) se dere %s: %s", GetName(playerid,true), PrintAccent(playerid), params);
		ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	} else {
		format(string, sizeof(string), "%s se dere %s: %s", GetName(playerid,true), PrintAccent(playerid), params);
		ProxDetector(15.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	}
	return 1;
}
CMD:carwhisper(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	//if(Bit1_Get( gr_DeathCountStarted, playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete pricati, u post death stanju ste!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /(c)lose [poruka]");
	new 
		string[128];
	format(string, sizeof(string), "%s %s tiho: %s", GetName(playerid), PrintAccent(playerid), params);
	CarProxDetector(GetPlayerVehicleID(playerid), playerid, string, COLOR_FADE1);
	return 1;
}
CMD:whisper(playerid, params[])
{
	new 
		giveplayerid,
		message[72];
		
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	if(sscanf(params, "us[72]", giveplayerid, message)) return SendClientMessage(playerid, COLOR_RED, "[?]: /(w)hisper [dio imena/playerid][poruka]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid / Part of name!");
	if(PlayerDeath[giveplayerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Korisnik je mrtav!");
	if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi saptati!");
	if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	
	new 
		tmpString[180];
	format(tmpString, sizeof(tmpString), "* %s sapuce: %s", GetName(playerid, true), message);
	SendClientMessage(playerid, COLOR_RED, tmpString);
	SendClientMessage(giveplayerid, COLOR_RED, tmpString);
	format(tmpString, sizeof(tmpString), "[RECON-W] %s sapuce %s: %s", GetName(playerid, true), GetName(giveplayerid, true), message);
	foreach(new i : Player)
	{
	    if(IsPlayerReconing(i))
	    {
			if(ReconingPlayer[i] == playerid || ReconingPlayer[i] == giveplayerid)
			{
				SendClientMessage(i, COLOR_RED, tmpString);
			}
		}
	}
	return 1;
}

CMD:blockb(playerid, params[])
{
	new
		str[32],
		bool:status = !Player_HasBlockedOOCChat(playerid);
	Player_SetHasBlockedOOCChat(playerid, status);

	format(str, sizeof(str), "%s si OOC chat!", (status) ? ("Ukljucio") : ("Iskljucio"));
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, str);
	return 1;
}
CMD:b(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /b [tekst]");
	if(strlen(params) > 128) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prevelika poruka (max. 128 znakova)!");
	
	new tmpString[128];
	params[0] = toupper(params[0]);
	format(tmpString, sizeof(tmpString), "(( %s[%d]: %s))", 
		GetName(playerid,false), 
		playerid, 
		params
	);
	if(Admin_OnDuty(playerid) && PlayerInfo[playerid][pAdmin] >= 1)
		OOCProxDetector(10.0, playerid, tmpString, COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE,COLOR_ORANGE);
	else if(Helper_OnDuty(playerid) && PlayerInfo[playerid][pHelper] >= 1)
		OOCProxDetector(10.0, playerid, tmpString, COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER,COLOR_HELPER);
	else
		OOCProxDetector(10.0, playerid, tmpString, COLOR_FADEB1,COLOR_FADEB2,COLOR_FADEB3,COLOR_FADEB4,COLOR_FADEB5);
	return 1;
}

CMD:admins(playerid, params[])
{
	new
		buffer[768],
		motd[128];

	foreach(new i : Player)
	{
	    if(!PlayerInfo[i][pAdmin])
			continue;

		format(motd, 128, ""COL_WHITE"\n%s(%s) - Admin Level %d - %s",
			GetName(i,false),
			PlayerInfo[i][pForumName],
			PlayerInfo[i][pAdmin],
			(Admin_OnDuty(i)) ? (""COL_GREEN"On Duty") : (""COL_RED"Off Duty")
		);
		strcat(buffer, motd, 768);
	}
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "\tADMINS ONLINE", buffer, "Close","");
	return 1;
}

CMD:helpers(playerid, params[])
{
	new
		buffer[768],
		motd[128];	
	
	foreach(new i : Player)
	{
	    if(!PlayerInfo[i][pHelper])
	    	continue;

		format(motd, 128, ""COL_WHITE"\n%s(%s) - Helper Level %d - %s",
			GetName(i,false),
			PlayerInfo[i][pForumName],
			PlayerInfo[i][pHelper],
			(Helper_OnDuty(i)) ? (""COL_GREEN"On Duty") : (""COL_RED"Off Duty")
		);
		strcat(buffer, motd, 768);
	}
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "\tHELPERS ONLINE:", buffer, "Close","");
	return 1;
}

CMD:hh(playerid, params[])
{
    if(!Bit1_Get(gr_PlayerLoggedIn,playerid))	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate se ulogirati da saljete HH!");
	if(PlayerTick[playerid][ptHelperHelp] > gettimestamp()) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte 20 sekundi za ponovno slanje HHa!");

	Player_SetNeedHelp(playerid, true);

	SendHelperMessage(COLOR_HELPER,
		"[!]: %s treba pomoc Helpera, koristite /ach %d za reagiranje!",
		GetName(playerid, false), 
		playerid 
	);
	SendClientMessage( playerid, COLOR_RED, "[!]: Uspjesno ste poslali poziv u pomoc!");
	PlayerTick[playerid][ptHelperHelp] = gettimestamp() + 19;
	return 1;
}

CMD:helpme(playerid, params[])
{
	new 
		result[144];	
	if(sscanf(params, "s[144]", result)) 
		return SendClientMessage(playerid, COLOR_RED, "[?]: \"/helpme <text>\"");

	SendHelperMessage(0x5DCF8AFF, "HelpMe by %s[%d]: "COL_SERVER"%s", GetName(playerid, true), playerid, result);
    SendAdminMessage(0x5DCF8AFF, "HelpMe by %s[%d]: "COL_SERVER"%s", GetName(playerid, true), playerid, result);

	va_SendClientMessage(playerid,0x5DCF8AFF, "Poslani HelpMe glasi: "COL_SERVER"%s",result);
   	return 1;
}

CMD:stats(playerid,params[]) 
{
	ShowPlayerStats(playerid, playerid);
	return 1;
}

CMD:pm(playerid, params[])
{
	new
		giveplayerid,
		text[128];

	if(sscanf(params, "us[128]", giveplayerid, text))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /pm [playerid / Part of name][text]");

    if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos playerida/imena!");
    if(Player_ForbiddenPM(playerid) && !PlayerInfo[playerid][pAdmin]) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Zabranjeno ti je slanje PMova!");
	if(Bit1_Get( gr_BlockedPM, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Korisnik je blokirao privatne poruke!");
	if(playerid == giveplayerid) return SendClientMessage(playerid, COLOR_RED, "Fali ti prijatelja, ne mozes pisati sam sebi.");
	if(PlayerInfo[giveplayerid][pAdmin] && !PlayerInfo[playerid][pAdmin])
	{
		new
			name_colorA[60],
			name_colorB[60];

		if(!Admin_OnDuty(playerid))
			format(name_colorA, 60, "{FF9900}%s", GetName(playerid));
		else format(name_colorA, 60, "%s", GetName(playerid));

		if(!Admin_OnDuty(playerid))
			format(name_colorB, 60, "{FF9900}%s", GetName(giveplayerid));
		else format(name_colorB, 60, "%s", GetName(giveplayerid));

		va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM za %s[%i]: %s))", GetName(giveplayerid, false), giveplayerid, text);
		va_SendClientMessage(giveplayerid, COLOR_NICEYELLOW,  "(( PM od %s[%i]: %s))", GetName(playerid, false), playerid, text);
	
		foreach (new i : Player)
		{
			if(PlayerInfo[i][pAdmin] >= 2 && Bit1_Get(a_PMears, i))
			{
				va_SendClientMessage(i, 0xFFD1D1FF, "%s[%i] PM za %s[%i]: %s", GetName(playerid, false), playerid, GetName(giveplayerid, false), giveplayerid, text);
			}
		}
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/a_pm.txt", "(%s) %s(%s) for %s: %s",
			ReturnDate(),
			GetName(playerid, false),
			ReturnPlayerIP(playerid),
			GetName(giveplayerid, false),
			text
		);
		#endif
	}

	if(strlen(text) > 75)
	{
		va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM za %s[%i]: %.75s...))", GetName(giveplayerid, false), giveplayerid, text);
		va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM za %s[%i]: ...%s))", GetName(giveplayerid, false), giveplayerid, text[75]);

		va_SendClientMessage(giveplayerid, COLOR_NICEYELLOW, "(( PM od %s[%i]: %.75s...))", GetName(playerid, false), playerid, text);
		va_SendClientMessage(giveplayerid, COLOR_NICEYELLOW, "(( PM od %s[%i]: ...%s))", GetName(playerid, false), playerid, text[75]);
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_YELLOW, "(( PM za %s[%i]: %s))", GetName(giveplayerid, false), giveplayerid, text);
		va_SendClientMessage(giveplayerid, COLOR_NICEYELLOW, "(( PM od %s[%i]: %s))", GetName(playerid, false), playerid, text);
	}
	
 	foreach (new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= 2 && Bit1_Get(a_PMears, i))
		{
			va_SendClientMessage(i, 0xFFD1D1FF, "[PM] %s[%i] za %s[%i]: %s", GetName(playerid, false), playerid, GetName(giveplayerid, false), giveplayerid, text);
		}
	}
	#if defined MODULE_LOGS
	Log_Write("/logfiles/a_pm.txt", "(%s) %s(%s) for %s: %s",
		ReturnDate(),
		GetName(playerid, false),
		ReturnPlayerIP(playerid),
		GetName(giveplayerid, false),
		text
	);
	#endif
	return 1;
}

CMD:blockpm(playerid,params[])
{
    if(!PlayerInfo[playerid][pAdmin] && !PlayerVIP[playerid][pDonateRank] && !PlayerFaction[playerid][pLeader]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi ovlasten za koristenje ove komande!");

	if(Bit1_Get( gr_BlockedPM, playerid)) {
		Bit1_Set( gr_BlockedPM, playerid, false);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Odblokirao si svoje privatne poruke!");
	} else {
		Bit1_Set( gr_BlockedPM, playerid, true);
		Bit16_Set( gr_LastPMId, playerid, INVALID_PLAYER_ID);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Blokirao si svoje privatne poruke!");
	}
	return 1;
}

CMD:eject(playerid, params[])
{
    new
		para1;

	if(sscanf(params, "u", para1))
		 return SendClientMessage(playerid, COLOR_RED, "[?]: /eject [Playerid / Part of name]");

	if(!IsPlayerInAnyVehicle(playerid))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu te ne mozete koristiti ovu komandu!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vozac vozila te ne mozete koristiti ovu komandu!");

	if(para1 == playerid)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete izbaciti samog sebe!");

	if(para1 == INVALID_PLAYER_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
		
	if(!IsPlayerInVehicle(para1, GetPlayerVehicleID(playerid)))
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac se ne nalazi u vasem vozilu!");
		
	/*if(aprilfools[playerid])
		playerid = para1;*/
	    
	new
	    vehicle_eject_str[53];

    format(vehicle_eject_str, sizeof(vehicle_eject_str), "* Izbacili ste %s iz vozila!", GetName(para1));

	SendClientMessage(playerid, COLOR_LIGHTBLUE, vehicle_eject_str);

	format(vehicle_eject_str, sizeof(vehicle_eject_str), "* %s vas je izbacio iz vozila!", GetName(playerid));

	SendClientMessage(para1, COLOR_LIGHTBLUE, vehicle_eject_str);
	RemovePlayerFromVehicle(para1);
	
	return 1;
}

CMD:blindfold(playerid, params[])
{
    new
		giveplayerid;

	if(sscanf(params, "u", giveplayerid))
		 return SendClientMessage(playerid, COLOR_RED, "[?]: /blindfold [Playerid / Part of name]");
	
	if(!ProxDetectorS(3.0, playerid, giveplayerid))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije dovoljno blizu vas!");

	if(giveplayerid == INVALID_PLAYER_ID)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");

	if(giveplayerid != playerid)
	{
		if(!Bit1_Get(gr_Blind, giveplayerid))
		{
			SetPlayerScreenFade(giveplayerid);
			Bit1_Set(gr_Blind, giveplayerid, true);
			va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* %s vam je stavio povez na oci!", GetName(playerid));
			va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Stavili ste %s povez na oci!", GetName(giveplayerid));
		}
		else
		{
   			RemovePlayerScreenFade(giveplayerid);
			Bit1_Set(gr_Blind, giveplayerid, false);
			va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* %s vam je skinuo povez sa ociju!", GetName(playerid));
			va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skinuli ste %s povez s ociju!", GetName(giveplayerid));
		}
	}
	return 1;
}

CMD:screenfade(playerid, params[])
{
	if(!Bit1_Get(gr_Blind, playerid))
	{
  		SetPlayerScreenFade(playerid);
		Bit1_Set(gr_Blind, playerid, true);
		SendMessage(playerid, MESSAGE_TYPE_INFO, "Zacrnili ste si ekran, za vracanje ekrana opet koristite ovu komandu!");
	} 
	
	else {
  		RemovePlayerScreenFade(playerid);
		Bit1_Set(gr_Blind, playerid, false);
	}
	return 1;
}

CMD:licenses(playerid, params[])
{
	new tmpString[40];
	//gunlic = LicenseInfo[playerid][pGunLic];
	//tip = (gunlic == 1) ? ("PF") : ((gunlic == 2) ? ("CCW") : ("N/A"));
	
    SendClientMessage(playerid, -1, "|__________________ Licenses __________________|");
    format(tmpString, sizeof(tmpString), "** Vozacka Dozvola: %s.", 
		LicenseInfo[playerid][pCarLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(playerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za letenje: %s.", 
		LicenseInfo[playerid][pFlyLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(playerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za brodove: %s.", 
		LicenseInfo[playerid][pBoatLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(playerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za pecanje: %s.", 
		LicenseInfo[playerid][pFishLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(playerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za oruzje: %s.", 
		LicenseInfo[playerid][pGunLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(playerid, COLOR_GREY, tmpString);
	SendClientMessage(playerid, -1, "|______________________________________________|");
    return 1;
}

CMD:sid(playerid, params[])
{
	new giveplayerid;
    if(sscanf( params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "KORISTITI: /sid [playerid / Part of name]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi odabir igraca!");
	if(!ProxDetectorS( 4.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu tog igraca!");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	
	new
		tmpString[72];
	format(tmpString, sizeof(tmpString), "[!] Pokazali ste vasu osobnu iskaznicu %s.", GetName( giveplayerid, true));
	SendClientMessage(playerid, COLOR_RED, tmpString);

	SendClientMessage(giveplayerid, COLOR_RED, "_______________________"); 
	va_SendClientMessage( giveplayerid, COLOR_WHITE, "Ime: %s   Godine: %d"	, GetName( playerid, false), PlayerInfo[playerid][pAge]);
	if(PlayerKeys[playerid][pHouseKey] != INVALID_HOUSE_ID)
		va_SendClientMessage( giveplayerid, COLOR_WHITE, "Adresa: %s"			, HouseInfo[PlayerKeys[playerid][pHouseKey]][hAdress]);
	va_SendClientMessage( giveplayerid, COLOR_WHITE, "Telefonski broj: %d"	, PlayerMobile[playerid][pMobileNumber]);
	SendClientMessage( giveplayerid, COLOR_GREEN, "_______________________");

	format(tmpString, sizeof(tmpString), "[!] %s vam je pokazao svoju osobnu iskaznicu.", GetName( playerid, true));
	SendClientMessage(giveplayerid, COLOR_RED, tmpString);
	return 1;
}

CMD:showlicenses(playerid, params[])
{
    new giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /showlicenses [playerid / Part of name]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos ida/imena!");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu tebe!");
	
	new tmpString[40];
	//gunlic = LicenseInfo[playerid][pGunLic];
	//tip = (gunlic == 1) ? ("PF") : ((gunlic == 2) ? ("CCW") : ("N/A"));
	
    va_SendClientMessage(giveplayerid, -1, "|__________________ Licenses (%s) __________________|", GetName(playerid, false));
    format(tmpString, sizeof(tmpString), "** Vozacka Dozvola: %s.", 
		LicenseInfo[playerid][pCarLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(giveplayerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za letenje: %s.", 
		LicenseInfo[playerid][pFlyLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(giveplayerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za brodove: %s.", 
		LicenseInfo[playerid][pBoatLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(giveplayerid, COLOR_GREY, tmpString);
	format(tmpString, sizeof(tmpString), "** Dozvola za pecanje: %s.", 
		LicenseInfo[playerid][pFishLic] ? ("Da") : ("Ne")
	);
	SendClientMessage(giveplayerid, COLOR_GREY, tmpString);

	if(Player_HasFakeGunLicense(playerid))
	{
		format(tmpString, sizeof(tmpString), "** Dozvola za oruzje: Da.");
	}
	else
	{
		format(tmpString, sizeof(tmpString), "** Dozvola za oruzje: %s.",
			   LicenseInfo[playerid][pGunLic] ? ("Da") : ("Ne"));
	}
	SendClientMessage(giveplayerid, COLOR_GREY, tmpString);
	SendClientMessage(giveplayerid, -1, "|______________________________________________|");
    return 1;
}
CMD:frisk(playerid, params[])
{
    new 
		giveplayerid;
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /frisk [ID / Part of name]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online !"); 
	if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pretrest sam sebe!");
	if(IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti izvan vozila!");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	if(IsPlayerInAnyVehicle(giveplayerid) || !ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu igraca!");
	
	va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "*_________________________ %s _________________________*", GetName( giveplayerid, true));
	va_SendClientMessage(playerid, COLOR_WHITE, "	Novac: %d$", PlayerInfo[giveplayerid][pMoney]);
	va_SendClientMessage(playerid, COLOR_WHITE, "	Toolkit: %s", PlayerInventory[giveplayerid][pToolkit] ? ("Da") : ("Ne"));
	va_SendClientMessage(playerid, COLOR_WHITE, "	Sat: %s", PlayerInventory[giveplayerid][pWatch] ? ("Da") : ("Ne"));
	va_SendClientMessage(playerid, COLOR_WHITE, "	Mobitel: %s", GetMobileName(PlayerMobile[giveplayerid][pMobileModel]));
	
	ListPlayerWeapons(giveplayerid, playerid);
	ListPlayerPackages(giveplayerid, playerid);

	va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "*___________________ [%s - Droga] ___________________*", GetName(giveplayerid));
	for(new s = 0; s < MAX_PLAYER_DRUGS; ++s)
	{
		if(PlayerDrugs[giveplayerid][dCode][s] != 0)
		{
			va_SendClientMessage(playerid, COLOR_WHITE, "SLOT %d: %s [%.2f %s]", s+1, drugs[PlayerDrugs[giveplayerid][dCode][s]][dName], PlayerDrugs[giveplayerid][dAmount][s], (drugs[PlayerDrugs[giveplayerid][dCode][s]][dEffect] < 4) ? ("grama") : ("tableta"));
		}
	}
	
	new tmpString[88];
	format(tmpString, sizeof(tmpString), "* %s je pretrazio %s za ilegalne predmete.", GetName( playerid, true), GetName( giveplayerid, true));
	ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

CMD:refresh(playerid, params[]) 
{

	if(!IsPlayerAlive(playerid))
        return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Mrtvi ste, ne mozete koristit ovu komandu.");
        
    if(Frozen[playerid]) return SendClientMessage(playerid, COLOR_RED, "Freezani ste, ne mozete koristi ovu komandu");
		
	new
		houseid = Player_InHouse(playerid),
		biznisid = Player_InBusiness(playerid);
		
	if(!IsPlayerAlive(playerid))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR,"Mrtvi ste, ne mozete koristit ovu komandu.");
	
	if(houseid == INVALID_HOUSE_ID) {
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		TogglePlayerControllable(playerid, (true));
	} 
	else if(houseid != INVALID_HOUSE_ID) {
		SetPlayerInterior(playerid, HouseInfo[houseid][hInt]);
		SetPlayerVirtualWorld(playerid, HouseInfo[houseid][hVirtualWorld]);
		TogglePlayerControllable(playerid, (true));
	}
	else if(biznisid != INVALID_BIZNIS_ID) {
		SetPlayerInterior(playerid, BizzInfo[houseid][bInterior]);
		SetPlayerVirtualWorld(playerid, BizzInfo[houseid][bVirtualWorld]);
		TogglePlayerControllable(playerid, (true));
	}
	
	GameTextForPlayer(playerid, "~w~Game refreshed!", 5000, 5);
	return (true);
}

CMD:pay(playerid, params[])
{
	new giveplayerid, moneys;
	
	if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
	if(sscanf( params, "ui", giveplayerid, moneys)) return SendClientMessage(playerid, COLOR_RED, "[?]: /pay [ID Igraca / Part of name][kolicina]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos igraca!");
	if(giveplayerid == playerid) return SendClientMessage(playerid,COLOR_RED, "Ne mozes sam sebi dati novce!");
	if(moneys < 1 || moneys > 1000000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemojte slati manje od 1, ili vise od 1.000.000 odjednom.");
	if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 2+ da mozes koristiti ovu komandu!");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	
	new
		playermoney = AC_GetPlayerMoney(playerid);
	if(moneys > 0 && playermoney >= moneys)
	{
		PlayerToPlayerMoney(playerid, giveplayerid, moneys);
		
		new
			tmpString[71];
		format(tmpString, sizeof(tmpString), "[!] Poslali ste %s(player: %d), $%d.", GetName(giveplayerid, true), giveplayerid, moneys);
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GRAD1, tmpString);
		
		format(tmpString, sizeof(tmpString), "[!] Primili ste $%d od %s(player: %d).", moneys, GetName(playerid, true), playerid);
		SendClientMessage(giveplayerid, COLOR_GRAD1, tmpString);
		
		PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
		new
			emoteTxt[128];
		format(emoteTxt, sizeof(emoteTxt), "* %s daje novac %s (( Pay))", GetName(playerid, true), GetName(giveplayerid, true));
		ProxDetector(20.0, playerid, emoteTxt, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		#if defined MODULE_LOGS
		Log_Write("/logfiles/pay.txt", "(%s) %s(%s) paid $%d in cash to %s(%s).", 
			ReturnDate(),
			GetName( playerid, false), 
			ReturnPlayerIP(playerid),
			moneys, 
			GetName( giveplayerid, false),
			ReturnPlayerIP(giveplayerid)
		);
		#endif
	}
	else SendClientMessage(playerid, COLOR_RED, "Nepravilan iznos transakcije.");
	return 1;
}

CMD:handshake(playerid, params[])
{
    new 
		giveplayerid,
		shakeid;
		
	if(sscanf(params, "ui", giveplayerid, shakeid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /handshake [ID Igraca / Part of name][vrsta rukovanja(1-9)]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos playerida!");
	if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu tebe!");
	if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemozes se rukovati sam sa sobom!");
	if(shakeid < 1 || shakeid > 9) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vrsta rukovanja ne moze biti manja od 1 i veca od 9!");

	new
		tmpString[53];
	format(tmpString, sizeof(tmpString), "* Ponudio si rukovanje %s-u.", GetName(giveplayerid, true));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, tmpString);
	
	format(tmpString, sizeof(tmpString), "** %s ti je ponudio rukovanje.", GetName(playerid, true));
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);
	SendClientMessage(giveplayerid, COLOR_RED, "[!] Ako se zelis rukovati,prihvati rukovanje koristeci /accept handshake.");
	
	Bit16_Set( gr_ShakeOffer, 	playerid, 		giveplayerid);
	Bit16_Set( gr_ShakeOffer, 	giveplayerid,	playerid);
	Bit8_Set( gr_ShakeStyle,	giveplayerid, 	shakeid);
	return 1;
}

CMD:accept(playerid, params[])
{
	new
		pick[16];
		
	if(sscanf( params, "s[16] ", pick)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /accept [odabir]");
		SendClientMessage( playerid, COLOR_GREY, "[ODABIR]: handshake - buygun - govrepair - mechanic - swat - fire - undercover - marriage - igarage");
		return 1;
	}
	if(!strcmp( pick, "undercover", true)) {
		new
			giveplayerid;
		if(sscanf(params, "s[16]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /accept undercover [ID / Part of name]");
	    if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED, "Taj igrac nije online.");
		if(PlayerFaction[playerid][pLeader] != 1 && (PlayerFaction[playerid][pRank] < 5 && !IsACop(playerid)) || PlayerFaction[playerid][pLeader] != 3 && (PlayerFaction[playerid][pRank] < 6 && !IsASD(playerid)))  
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste lider PD-a/SD-a/R6+!");

		if(!IsACop(giveplayerid) && !IsASD(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Odabrani igrac nije u LSPD/Sherrif's Departmentu!");

		va_SendClientMessage(playerid, COLOR_RED, "[!] Dopustili ste %s da moze koristit /undercover komandu.", GetName(giveplayerid,true));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mozete koristit /undercover komandu.", GetName(playerid,true));
		Player_SetApprovedUndercover(giveplayerid, true);
		SendClientMessage(giveplayerid, COLOR_RED, "[!] Mozete koristiti /undercover.");
	}
	if(!strcmp( pick, "swat", true)) {
		new
			giveplayerid;
		if(sscanf(params, "s[16]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /accept swat [ID / Part of name]");
	    if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED, "Taj igrac nije online.");
		if(( IsACop(playerid) && PlayerFaction[playerid][pRank] >= FactionInfo[PlayerFaction[playerid][pMember]][rABuyGun]) || ( IsASD(playerid) && PlayerFaction[playerid][pRank] >= FactionInfo[PlayerFaction[playerid][pMember]][rABuyGun])) {
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dopustili ste %s da moze koristit /swat komandu.", GetName(giveplayerid,true));
			va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mozete koristit /swat komandu.", GetName(playerid,true));
			Player_SetIsSWAT(giveplayerid, true);
			SendClientMessage(giveplayerid, COLOR_RED, "[!] Mozes koristiti /swat.");
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	}
	if(!strcmp( pick, "handshake", true)) {
			new
				giveplayerid = Bit16_Get( gr_ShakeOffer, playerid);
			
			if(giveplayerid == 999) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nitko vam nije ponudio rukovanje!");
			if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije dostupan!");
			if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu igraca!");

			switch( Bit8_Get( gr_ShakeStyle, playerid)) {
				case 1: {
					ApplyAnimationEx(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0,1,0);
				}
				case 2: {
					ApplyAnimationEx(playerid,"GANGS","hndshkaa",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkaa",4.0,0,0,0,0,0,1,0);
				}
				case 3: {
					ApplyAnimationEx(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkba",4.0,0,0,0,0,0,1,0);
				}
				case 4: {
					ApplyAnimationEx(playerid,"GANGS","hndshkca",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkca",4.0,0,0,0,0,0,1,0);
				}
				case 5: {
					ApplyAnimationEx(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkda",4.0,0,0,0,0,0,1,0);
				}
				case 6: {
					ApplyAnimationEx(playerid,"GANGS","hndshkea",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkea",4.0,0,0,0,0,0,1,0);
				}
				case 7: {
					ApplyAnimationEx(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1,0);
				}
				case 8: {
					ApplyAnimationEx(playerid,"GANGS","prtial_hndshk_01",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","prtial_hndshk_01",4.0,0,0,0,0,0,1,0);
				}
				case 9: {
					ApplyAnimationEx(playerid,"GANGS","prtial_hndshk_biz_01",4.0,0,0,0,0,0,1,0);
					ApplyAnimationEx(giveplayerid,"GANGS","prtial_hndshk_biz_01",4.0,0,0,0,0,0,1,0);
				}
			}
		
			new
				tmpString[68];
				
			format(tmpString, sizeof(tmpString), "* Prihvatio si %s-ov zahtjev za rukovanje.", GetName(giveplayerid, true));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, tmpString);
			
			format(tmpString, sizeof(tmpString), "* %s je prihvatio tvoj zahtjev za rukovanjem.", GetName(playerid, true));
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, tmpString);
							
			Bit16_Set( gr_ShakeOffer, 	playerid, 		999);
			Bit16_Set( gr_ShakeOffer, 	giveplayerid,	999);
			Bit8_Set( gr_ShakeStyle,	giveplayerid, 	0);
	}
	else if(strcmp(pick,"mechanic",true) == 0)
	{
	    StartMechanicService(playerid);
		return 1;
	}
	else if(strcmp(pick,"govrepair",true) == 0)
	{
		if(FactionInfo[PlayerFaction[playerid][pMember]][rAGovRepair] == 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Komanda 'accept govrepair' je trenutno izgaSena od strane lidera! Koristite /govrepair kako bi popravili vozilo.");
		
		new
			rank = PlayerFaction[playerid][pRank],
			member = PlayerFaction[playerid][pMember],
			giveplayerid;
			
	    if(sscanf(params, "s[16]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /accept govrepair [ID / Part of name]");
	    if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED,"Taj igrac nije online.");
		
		if(rank < FactionInfo[member][rAGovRepair]) 
				return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rank %d kako bi ste mogli koristiti ovu komandu!", FactionInfo[member][rAGovRepair]);

		Player_SetCanRepairGovVehicle(giveplayerid, true);
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dopustili ste %s da moze koristit /govrepair komandu.", GetName(giveplayerid,true));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mozete koristit /govrepair komandu.", GetName(playerid,true));
		SendClientMessage(giveplayerid, COLOR_RED, "[!] Mozes jednom popraviti i napuniti auto.");
	}
	else if(strcmp(pick,"buygun",true) == 0) 
	{
		if(FactionInfo[PlayerFaction[playerid][pMember]][rABuyGun] == 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Komanda /accept buygun je trenutno izgasena od strane lidera! Koristite /buygun kako bi uzeli oruzje.");
		new giveplayerid;
	    if(sscanf(params, "s[16]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /accept buygun [ID / Part of name]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(!IsACop(playerid) && !IsASD(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo LSPD/SASD mogu davati dozvole za uzimanje oruzja u Armoury-u.");
		if(!IsACop(giveplayerid) && !IsASD(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo LSPD/SASD mogu uzimati dozvole za uzimanje oruzja u Armoury-u.");
		if(PlayerFaction[playerid][pRank] < FactionInfo[PlayerFaction[playerid][pMember]][rBuyGun]) 
			return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti rank %d kako bi ste mogli koristiti ovu komandu!", FactionInfo[PlayerFaction[playerid][pMember]][rBuyGun]);
		
		SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dopustili ste %s da moze koristit /buygun komandu.", GetName(giveplayerid));
		va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mozete koristit /buygun komandu.", GetName(playerid));
		SendClientMessage(giveplayerid, COLOR_RED, "[!] Imate pravo na oruzje iz armorya. Koristite /buygun!");
	}
	else if(strcmp(pick,"igarage",true) == 0) 
	{
		new giveplayerid;
	    if(sscanf(params, "s[16]u", pick, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /accept igarage [ID / Part of name]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(( IsACop(playerid) && PlayerFaction[playerid][pRank] >= 2)) 
		{
			SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Dopustili ste %s da moze uci u Impound Garazu!", GetName(giveplayerid));
			va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dopustio da mozete uci u Impound Garazu (/impoundgarage)!", GetName(playerid));
			Bit1_Set(gr_ImpoundApproval, giveplayerid, false);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	}
	return 1;
}
CMD:oldcar(playerid, params[])
{
    va_SendClientMessage(playerid, COLOR_RED, "[!] ID tvog prethodnog auta je: %d!", Player_GetLastVehicle(playerid));
    return 1;
}

CMD:prisontime(playerid, params[])
{
	if(PlayerJail[playerid][pJailed] < 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi zatvoren!");
	switch(PlayerJail[playerid][pJailed])
	{
		case 1: va_SendClientMessage(playerid, COLOR_RED, "[!] Zatvoreni ste u zatvoru jos %d minuta!", PlayerJail[playerid][pJailTime]);
		case 2: va_SendClientMessage(playerid, COLOR_RED, "[!] Zatvoreni ste u Fort DeMoragnu jos %d minuta!", PlayerJail[playerid][pJailTime]);
		case 3: va_SendClientMessage(playerid, COLOR_RED, "[!] Zatvoreni ste u zatvoru jos %d minuta!", PlayerJail[playerid][pJailTime]);
	}    
    return 1;
}

CMD:id(playerid, params[])
{
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "KORISTI: /id [playerid / Part of name]");

	if(IsNumeric(params))
	{
	    new
			gpid = strval(params);

		if(gpid == INVALID_PLAYER_ID)
		    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Invalidan ID igraca!");

		if(!IsPlayerConnected(gpid))
		    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");

        va_SendClientMessage(playerid, -1, "[/id] %s[%d], Level: %d", GetName(gpid, false), gpid, PlayerInfo[gpid][pLevel]);
		return 1;
	}
	else
	{
		if(strlen(params) <= 2)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ime mora biti 3 ili viSe karaktera!");

		new
			count = 0;

		foreach(new i : Player)
		{
			if(strfind(GetName(i, false), params, true) != -1)
			{
				va_SendClientMessage(playerid, -1, "[/id] #%d - %s[%d], Level: %d", count, GetName(i, false), i, PlayerInfo[i][pLevel]);
				count++;
			}
		}

		if(!count)
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nijedan korisnik nije prona�en sa navedenim imenom!");
	}
	return 1;
}
CMD:changeseat(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar vozila!");
	new seatid;
	if(sscanf(params, "i", seatid)) {
		SendClientMessage(playerid, COLOR_RED, "[?]: /changeseat [seatid]");
		SendClientMessage(playerid, COLOR_GREY, "POMOC: 0 - Vozac, 1 - Suvozac, 2 - Suputnik #1 (iza), 3 - Suputnik #2 (iza)");
		return 1;
	}
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(seatid > GetVehicleSeats(GetVehicleModel(vehicleid)) - 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo nema toliko sjedećih mjesta!");

	// Check if someone is on that seat
	foreach(new i : Player)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleSeat(i) == seatid && GetPlayerVehicleID(i) == vehicleid)
			{
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Netko se vec nalazi na tom mjestu!"); 
			}
		}
	}
	
	// Set Player Seat
	//RemovePlayerFromVehicle(playerid); Imamo fixes.inc dva puta remova lika iz auta jer je degen
    PutPlayerInVehicle(playerid, vehicleid, seatid);
	
	return 1;
}
CMD:windows(playerid, params[])
{
	new
		window, status;
	if(sscanf( params, "ii", window, status)) return SendClientMessage(playerid, COLOR_RED, "[?]: /windows [1/2/3/4][1(otvori)/0(zatvori]");
	if(window > 4 || window < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate koristiti vrijednosti od 1-4!");
	
    if(IsPlayerInAnyVehicle(playerid)) {
		new carid = GetPlayerVehicleID(playerid),
			driver, passenger, backleft, backright,
			tmpString[44];
  		if(IsACabrio(GetVehicleModel(carid))) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo nema prozora!");
		
		switch( status) {
			case 0: { // Zatvori
				format(tmpString, sizeof(tmpString), "* %s podize prozor.", GetName(playerid, true));
				ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				GetVehicleParamsCarWindows(carid, driver, passenger, backleft, backright);
				Bit1_Set(gr_VehicleWindows,carid,false);
				
				switch( window) {
					case 1: SetVehicleParamsCarWindows(carid, 1, passenger, backleft, backright);
					case 2: SetVehicleParamsCarWindows(carid, driver, 1, backleft, backright);
					case 3: SetVehicleParamsCarWindows(carid, driver, passenger, 1, backright);
					case 4: SetVehicleParamsCarWindows(carid, driver, passenger, backleft, 1);
				}
			}
			case 1: { // Otvori
				format(tmpString, sizeof(tmpString), "* %s spusta prozor.", GetName(playerid, true));
				ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				GetVehicleParamsCarWindows(carid, driver, passenger, backleft, backright);
				Bit1_Set(gr_VehicleWindows,carid,true);
				
				switch( window) {
					case 1: SetVehicleParamsCarWindows(carid, 0, passenger, backleft, backright);
					case 2: SetVehicleParamsCarWindows(carid, driver, 0, backleft, backright);
					case 3: SetVehicleParamsCarWindows(carid, driver, passenger, 0, backright);
					case 4: SetVehicleParamsCarWindows(carid, driver, passenger, backleft, 0);
				}
			}
		}
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
    return 1;
}
CMD:doors(playerid, params[])
{
	new
		door, status;
	if(sscanf( params, "ii", door, status)) return SendClientMessage(playerid, COLOR_RED, "[?]: /doors [1/2/3/4][1(otvori)/0(zatvori]");
	if(door > 4 || door < 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate koristiti vrijednosti od 1-4!");
	
    if(IsPlayerInAnyVehicle(playerid)) {
		new carid = GetPlayerVehicleID(playerid),
			driver, passenger, backleft, backright,
			tmpString[44];
  	
		switch( status) {
			case 0: { // Zatvori
				format(tmpString, sizeof(tmpString), "* %s zatvara vrata.", GetName(playerid, true));
				ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				GetVehicleParamsCarDoors(carid, driver, passenger, backleft, backright);
				
				switch( door) {
					case 1: SetVehicleParamsCarDoors(carid, 0, passenger, backleft, backright);
					case 2: SetVehicleParamsCarDoors(carid, driver, 0, backleft, backright);
					case 3: SetVehicleParamsCarDoors(carid, driver, passenger, 0, backright);
					case 4: SetVehicleParamsCarDoors(carid, driver, passenger, backleft, 0);
				}
			}
			case 1: { // Otvori
				format(tmpString, sizeof(tmpString), "* %s otvara vrata.", GetName(playerid, true));
				ProxDetector(20.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				
				switch( door) {
					case 1: SetVehicleParamsCarDoors(carid, 1, passenger, backleft, backright);
					case 2: SetVehicleParamsCarDoors(carid, driver, 1, backleft, backright);
					case 3: SetVehicleParamsCarDoors(carid, driver, passenger, 1, backright);
					case 4: SetVehicleParamsCarDoors(carid, driver, passenger, backleft, 1);
				}
			}
		}
    }
    else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
    return 1;
}
CMD:attempt(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[?]: /attempt [akcija]");
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Usutkani ste");
	new succeed = 1 + random(2);
	new
		attemptText[100];
	if(succeed == 1) {
		format(attemptText, sizeof(attemptText), "* %s pokusava %s i uspjeva.", 
			GetName(playerid, true), 
			params
		);
     	ProxDetector(10.0, playerid, attemptText, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
	}
	if(succeed == 2) {
		format(attemptText, sizeof(attemptText), "* %s pokusava %s i ne uspjeva.", 
			GetName(playerid, true),
			params
		);
	    ProxDetector(10.0, playerid, attemptText, COLOR_RED,COLOR_RED,COLOR_RED,COLOR_RED,COLOR_RED);
	}
    return 1;
}

CMD:coin(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	new succeed = 1 + random(2),
		string[54];

	format(string, sizeof(string), "*%s baca Novcic u zrak te ga hvata u letu.",
		GetName(playerid, true)
	);
	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20, 10000);

	if(succeed == 1)
	    ProxDetector(15.0, playerid, "* Novcic je pao na Glavu!", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	else if(succeed == 2)
		ProxDetector(15.0, playerid, "* Novcic je pao na Pismo!", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	return 1;
}

CMD:dice(playerid, params[])
{
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
    new dice = minrand(1,7), string[61];
	if(Player_HasDice(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kockicu");
	format(string, sizeof(string), "** %s baca kockicu koja pada na broj %d", GetName(playerid, true),dice);
	ProxDetector(5.0, playerid, string, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
    return 1;
}

CMD:dump(playerid, params[])
{
	new 
		param1[7],
		tmpString[61];
	sscanf(params, "s[7] ", param1);
	if(!strlen(param1))
	{
		SendClientMessage(playerid, COLOR_RED, "|__________________ Mozete baciti slijedece stvari{FA5656} __________________|");
		SendClientMessage(playerid, COLOR_RED, "[?]: /dump [opcija]");
		SendClientMessage(playerid, COLOR_RED, "[!] gun - phone - crypto");
		SendClientMessage(playerid, COLOR_RED, "|___________________________________________________|");
		return 1;
	}
	else if(strcmp(param1,"gun",true) == 0)
	{
		if(AC_GetPlayerWeapon(playerid) > 0)
		{
		    if(GetPlayerWeapon(playerid) == 23 && Player_HasTaserGun(playerid))
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes dumpati Tazer!");
			
			if(GetPlayerWeapon(playerid) == WEAPON_SHOTGUN && Player_BeanbagBulletsActive(playerid))
				return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes dumpati BeanBag Shotgun!");
				
			new
				weapon = AC_GetPlayerWeapon(playerid);

	        format(tmpString, sizeof(tmpString), "* %s baca oruzje na pod.", GetName(playerid, true));
            ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            
			#if defined MODULE_LOGS
            Log_Write("logfiles/dump_gun.txt", "(%s) Player %s{%d} dropped %s(%d)[AMMO: %d] on the floor!",
				ReturnDate(),
				GetName(playerid),
				PlayerInfo[playerid][pSQLID],
				GetWeaponNameEx(weapon),
				weapon,
				AC_GetPlayerAmmo(playerid)
			);
			#endif
			
			new Float:dx, Float:dy, Float:unz;
			GetPlayerPos(playerid, dx, dy, unz);
			if(!IsACop(playerid) && !IsASD(playerid))
			{
				if(weapon >= 22 && weapon <= 34)
					DropPlayerWeapon(playerid, weapon, dx, dy);
			}
			AC_ResetPlayerWeapon(playerid, weapon);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate oruzje (mora vam biti u ruci)!");
	}
	else if(strcmp(param1,"phone",true) == 0)
	{
		if(PlayerMobile[playerid][pMobileNumber] > 0)
		{
			RemovePlayerMobile(playerid);
			
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Bacio si mobitel!");
	        format(tmpString, sizeof(tmpString), "* %s baca mobitel u daljinu.", GetName(playerid, true));
            ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate mobitel!");
	}
	else if(strcmp(param1,"crypto",true) == 0)
	{
		if(PlayerMobile[playerid][pCryptoNumber] > 0)
		{
		    PlayerMobile[playerid][pCryptoNumber] = 0;
			
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Bacio si cryto!");
	        format(tmpString, sizeof(tmpString), "* %s baca crypto u daljinu.", GetName(playerid, true));
            ProxDetector(15.0, playerid, tmpString, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			
			mysql_fquery(g_SQL, "DELETE FROM player_phones WHERE player_id = '%d' AND type = '2'", PlayerInfo[playerid][pSQLID]);
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate crypto!");
	}
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepoznato ime stvari za bacanje !");
    return 1;
}

CMD:give(playerid, params[])
{
    new 
		x_nr[32],
		giveplayerid,
		job[32],
		moneys,
		globalstring[128];
		
	if(sscanf(params, "s[32] ", x_nr))
	{
		SendClientMessage(playerid, COLOR_RED, "[?]: /give [Opcija][IgracevID / Part of name][kolicina]");
		SendClientMessage(playerid, COLOR_RED, "[!] Weapon, Magazine, Watch, Job");
		SendClientMessage(playerid, COLOR_RED, "[!] Cigarette, Lighter, Weaponlicense, Dice");
		return 1;
	}
	
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online!");
	
    if(strcmp(x_nr,"weapon",true) == 0)
	{
	    if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
		if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");
		if(sscanf(params, "s[32]u", x_nr, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give weapon [Playerid / Part of name]");
		if(!IsPlayerConnected(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online");
		if(!SafeSpawned[giveplayerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan");
		if(PlayerInfo[giveplayerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid) != 0) {
		    if(giveplayerid != INVALID_PLAYER_ID) {
			    if(ProxDetectorS(3.0, playerid, giveplayerid)) {
     			    new 
						weapon = AC_GetPlayerWeapon(playerid),
						ammo 	= AC_GetPlayerAmmo(playerid);
						
					if(weapon == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nijedno oruzje u ruci!");
                    if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi davati oruzje!");
					if(PlayerInfo[giveplayerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije level 2+ da mu mozes dati gun!");
					if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 2+ da mozes koristiti ovu komandu!");
					if(IsPlayerInAnyVehicle(playerid) || IsPlayerInAnyVehicle(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti ovu komandu unutar vozila!");
					if(( IsACop(playerid) && IsACop(giveplayerid)) || ( IsASD(playerid) && IsASD(giveplayerid)) || ( IsAGov(playerid) && IsAGov(giveplayerid))) {
						if(! CheckPlayerWeapons(giveplayerid, weapon))
						{
							SendMessage(playerid, MESSAGE_TYPE_ERROR, "Weapon slotovi osobe kojoj zelite dati oruzje su zauzeti!");
							return 1;
						}
						AC_GivePlayerWeapon(giveplayerid, weapon, ammo);
						AC_ResetPlayerWeapon(playerid, weapon);
					}
					else if(( !IsACop(playerid) && !IsACop(giveplayerid)) && ( !IsASD(playerid) && !IsASD(giveplayerid)) && ( !IsAGov(playerid) && !IsAGov(giveplayerid))) {
						if(! CheckPlayerWeapons(giveplayerid, weapon))
						{
							SendMessage(playerid, MESSAGE_TYPE_ERROR, "Weapon slotovi osobe kojoj zelite dati oruzje su zauzeti!");
							return 1;
						}
						AC_GivePlayerWeapon(giveplayerid, weapon, ammo);
						AC_ResetPlayerWeapon(playerid, weapon);
					}
					else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedopustena radnja!");
					va_SendClientMessage(playerid,COLOR_RED, "[!] Dali ste %s %s s %d municije.", GetName(giveplayerid), WeapNames[weapon], ammo);
					va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dao %s s %d metaka.", GetName(playerid), WeapNames[weapon], ammo);
					format(globalstring, sizeof(globalstring), "* %s daje oruzje %s.", GetName(playerid), GetName(giveplayerid));
					ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					#if defined MODULE_LOGS
					Log_Write("logfiles/give_weapon.txt", "(%s) Player %s gave %s %s with %d bullets.",
						ReturnDate(),
						GetName(playerid, false),
						GetName(giveplayerid, false),
						WeapNames[weapon],
						ammo
					);
					#endif
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		} else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
    }
	if(strcmp(x_nr,"magazine",true) == 0) 
	{
	    if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
		if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");
		new magamount;
		if(sscanf(params, "s[32]ui", x_nr, giveplayerid, magamount)) {
			SendClientMessage(playerid, COLOR_RED, "[?]: /give magazine [Playerid / Part of name][Broj sanzera]");
			SendClientMessage(playerid, COLOR_RED, "[!] Single fire oruzja kao sto su Shotgun, Country & Sniper Rifle idu po 5 metaka u sanzeru.");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije online");
		if(!SafeSpawned[giveplayerid]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac nije sigurno spawnan");
		if(PlayerInfo[giveplayerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Level 1 igraci nemaju pristup oruzju!");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi davati oruzje!");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid)) {
		    if(giveplayerid != INVALID_PLAYER_ID) {
			    if(ProxDetectorS(3.0, playerid, giveplayerid)) {
     			    new 
						weapon = AC_GetPlayerWeapon(playerid),
						ammo 	= AC_GetPlayerAmmo(playerid),
						magsize;
						
					if(weapon == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate nijedno oruzje u ruci!");
					switch(weapon)
					{
						case 25, 33,34: magsize = 5; // Shotgun, Country & Sniper Rifle
						case 24: magsize = 7; // Deagle
						case 22,23: magsize = 17; // Colt & Silenced
						case 29,30: magsize = 30; // MP5 & AK47
						case 28,31,32: magsize = 50; // M4, Micro SMG & Tec-9
						default: 
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemoguca radnja!");
					}
					new	
						finalmag = floatround((ammo / magsize), floatround_floor),
						finalammo = (magsize * magamount),
						redammo = ammo - finalammo;
					if(finalmag < 1) return SendClientMessage(playerid,COLOR_RED, "Ne mozete davati manje od jednog sanzera oruzja!");
					if(finalmag < magamount) return SendClientMessage(playerid,COLOR_RED, "Nemate toliko sanzera oruzja koje drzite u ruci kod sebe!");
					if(redammo < 1) return SendClientMessage(playerid,COLOR_RED, "Ne moze vam ostati manje od jednog metka u oruzju!");
					if(AC_GetPlayerWeapon(giveplayerid) != weapon) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac ne drzi isti tip oruzja kao i Vi u rukama.");
					if(PlayerInfo[playerid][pLevel] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi level 2+ da mozes koristiti ovu komandu!");
					if(IsPlayerInAnyVehicle(playerid) || IsPlayerInAnyVehicle(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete koristiti ovu komandu unutar vozila!");
					if(( IsACop(playerid) && IsACop(giveplayerid)) || ( IsASD(playerid) && IsASD(giveplayerid)) || ( IsAGov(playerid) && IsAGov(giveplayerid))) {
						AC_GivePlayerWeapon(playerid, weapon, -finalammo);
						AC_GivePlayerWeapon(giveplayerid, weapon, finalammo);
					}
					else if(( !IsACop(playerid) && !IsACop(giveplayerid)) && ( !IsASD(playerid) && !IsASD(giveplayerid)) && ( !IsAGov(playerid) && !IsAGov(giveplayerid))) {
						AC_GivePlayerWeapon(playerid, weapon, -finalammo);
						AC_GivePlayerWeapon(giveplayerid, weapon, finalammo);
					}
					else return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedopustena radnja!");
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste %s %d sanzera %s(%d metaka).", GetName(giveplayerid), magamount, WeapNames[weapon], finalammo);
					va_SendClientMessage(giveplayerid, COLOR_RED, "[!] %s vam je dao %d sanzera %s(%d metaka).", GetName(playerid), magamount, WeapNames[weapon], finalammo);
					format(globalstring, sizeof(globalstring), "* %s daje %d sanzera %s %s.", GetName(playerid), magamount, WeapNames[weapon], GetName(giveplayerid));
					ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					new	puzavac = IsCrounching(giveplayerid);
					SetAnimationForWeapon(giveplayerid, weapon, puzavac);
					#if defined MODULE_LOGS
					Log_Write("/logfiles/a_givegun.txt", "(%s) %s gave %s %s with %d bullets.",
						GetName(playerid, false),
						GetName(giveplayerid, false),
						WeapNames[weapon],
						finalammo
					);
					#endif
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		} else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
    }
    else if(strcmp(x_nr,"cigarette",true) == 0)
	{
	    if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
    	if(sscanf(params, "s[32]ui", x_nr, giveplayerid, moneys)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give cigarette [Playerid / Part of name][Kolicina]");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozete sami sebi davati cigarete!");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid) != 0)
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
            {
     			if(ProxDetectorS(3.0, playerid, giveplayerid))
	            {
			    	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozete sami sebi davati cigarete!");
	    			if((PlayerInventory[giveplayerid][pCiggaretes] + moneys) > 100) return SendClientMessage(playerid, COLOR_RED, "Osoba moze najvise nositi 100 cigareta kod sebe");
	    			if(moneys > 0 && PlayerInventory[playerid][pCiggaretes] >= moneys)
					{
	    			    PlayerInventory[giveplayerid][pCiggaretes] += moneys;
   	    				PlayerInventory[playerid][pCiggaretes] -= moneys;
				        PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				        format(globalstring, sizeof(globalstring), "Poslali ste %s %d cigareta.", GetName(giveplayerid), moneys);
			       		SendClientMessage(playerid, COLOR_LIGHTBLUE, globalstring);
			     		format(globalstring, sizeof(globalstring), "Primili ste %d cigareta od %s.", moneys, GetName(playerid));
				     	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, globalstring);
				    	format(globalstring, sizeof(globalstring), "* %s vadi kutiju cigareta i daje cigarete %s.", GetName(playerid), GetName(giveplayerid));
        				ProxDetector(3.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    }
					else SendClientMessage(playerid, COLOR_RED, "Nemate toliko cigareta kod sebe !");
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
    }
    else if(strcmp(x_nr,"weaponlicense",true) == 0)
	{
	    SendClientMessage(playerid, COLOR_RED, "[!] Komanda je izbacena");
	    return 1;
	}
   	else if(strcmp(x_nr,"weaponlicense",true) == 0)
	{
		new vrsta;
	    if(PlayerDeath[playerid][pKilled]) return SendClientMessage(playerid,COLOR_RED,"Ne mozes koristiti ovu komandu dok imas opciju /die!");
    	if(sscanf(params, "s[32]ui", x_nr, giveplayerid, vrsta))
		{
			SendClientMessage(playerid, COLOR_WHITE, "[?]: /give weaponlicense [Playerid / Part of name][vrsta]");
			SendClientMessage(playerid, COLOR_GREEN, "Vrste: 1 Purchase Firearm (PF),  2 Concealed Carry Weapon(CCW)");
			return 1;
		}
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozete sami sebi davati licencu za oruzje!");
		if(vrsta > 2 || vrsta < 0) return SendClientMessage(playerid, COLOR_RED, "Nemoj ici ispod broja 0, ili iznad 2!");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid) != 0)
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
            {
     			if(ProxDetectorS(3.0, playerid, giveplayerid))
	            {
	    			if(LicenseInfo[giveplayerid][pGunLic] >= 1) return SendClientMessage(playerid, COLOR_RED, "Osoba vec ima dozvolu za oruzje!");
	    			if((IsACop(playerid) && PlayerFaction[playerid][pRank] > 5) || PlayerFaction[playerid][pLeader] == 1)
					{
	    			    LicenseInfo[giveplayerid][pGunLic] = vrsta;
				        PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
				    	format(globalstring, sizeof(globalstring), "* %s daje %s dozvolu za oruzje.", GetName(playerid), GetName(giveplayerid));
        				ProxDetector(20.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    }
					else SendClientMessage(playerid, COLOR_RED, "Niste ovlasteni!");
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
    }
    else if(strcmp(x_nr,"job",true) == 0)
	{
    	if(sscanf(params, "s[32]us[32]", x_nr, giveplayerid, job))
		{
			SendClientMessage(playerid, COLOR_RED, "[?]: /give job [Playerid / Part of name][Posao]");
			SendClientMessage(playerid, COLOR_WHITE, "Jobs: carjacker");
			return 1;
		}
		
		if(SafeSpawned[giveplayerid])
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "That player isn't online!");
		if(giveplayerid != INVALID_PLAYER_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You can't give yourself a job!");
	
		if(!ProxDetectorS(5.0, playerid, giveplayerid))  
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "You aren't close enough to player.");
		if(PlayerJob[giveplayerid][pJob] != 0) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Player already has a job!");
		if(PlayerFaction[giveplayerid][pMember] != PlayerFaction[playerid][pLeader]) 
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Player has to be in your faction!");
		if(strcmp(job,"carjacker",true) == 0) 
		{
			if(FactionInfo[PlayerFaction[playerid][pLeader]][fType] == 4 || FactionInfo[PlayerFaction[playerid][pLeader]][fType] == 6) 
			{ 
				if(IllegalFactionJobCheck(PlayerFaction[playerid][pLeader], 13) >= 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Maksimalan broj car jackera po organizaciji je 5!");
				PlayerJob[giveplayerid][pJob] = JOB_JACKER;

				SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Dali ste posao car jackera igracu %s.", GetName(giveplayerid, true));
				va_SendClientMessage(giveplayerid, COLOR_RED, "[!] Igrac %s vam je dao posao car jacker.", GetName(playerid, true));
			}
			else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi ovlasten!");
		}
		return 1;
  	}
   	else if(strcmp(x_nr,"lighter",true) == 0)
    {
        if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
    	if(sscanf(params, "s[32]u", x_nr, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give lighter [Playerid / Part of name]");
		if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas.");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online!");
		if(!ProxDetectorS(3.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi davati upaljac!");
		if(PlayerInventory[giveplayerid][pLighter]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Osoba vec ima upaljac");
		if(!PlayerInventory[playerid][pLighter]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas upaljac!");
		
		PlayerInventory[playerid][pLighter] = 0;
		PlayerInventory[giveplayerid][pLighter] = 1;
		PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
		format(globalstring, sizeof(globalstring), "* %s vadi upaljac iz dzepa i daje ga %s.", GetName(playerid), GetName(giveplayerid));
		ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
    }
    else if(strcmp(x_nr,"watch",true) == 0)
	{
     	if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
    	if(sscanf(params, "s[32]u", x_nr, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give watch [Playerid / Part of name]");
		if(IsPlayerReconing(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije dovoljno blizu vas.");
		if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online !");
     	if(!ProxDetectorS(5.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas !");
		if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebi davati sat!");
		if(!PlayerInventory[playerid][pWatch]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas sat!");
		if(PlayerInventory[giveplayerid][pWatch]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Osoba vec ima sat!");
	    
		PlayerInventory[giveplayerid][pWatch] = 1;
	    PlayerInventory[playerid][pWatch] = 0;
		PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
		format(globalstring, sizeof(globalstring), "* %s skida sat s ruke i daje ga %s.", GetName(playerid), GetName(giveplayerid));
		ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
    }
    else if(strcmp(x_nr,"dice",true) == 0)
	{
	    if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
    	if(sscanf(params, "s[32]u", x_nr, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give dice [Playerid / Part of name]");
		if(IsPlayerReconing(playerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije dovoljno blizu vas.");
		if(Player_HasDice(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas kockicu");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_RED, "Ne mozete sami sebi davati kocku!");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid) != 0)
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
		    {
     			if(ProxDetectorS(3.0, playerid, giveplayerid))
			    {
					Player_SetHasDice(playerid, false);
					Player_SetHasDice(giveplayerid, true);
    				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
					format(globalstring, sizeof(globalstring), "* %s uzima kocku iz djepa i daje ga %s.", GetName(playerid), GetName(giveplayerid));
			        ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
    }
	else if(strcmp(x_nr,"flicense",true) == 0)
	{
		if(PlayerDeath[playerid][pKilled]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes koristiti ovu komandu dok si u DeathModeu!");
		if(sscanf(params, "s[32]u", x_nr, giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /give flicense [Playerid / Part of name]");
		if(IsPlayerReconing(giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "Taj igrac nije dovoljno blizu vas.");
		if(Player_HasFakeGunLicense(playerid)) return SendClientMessage(playerid, COLOR_RED, " Nemate laznu dozvolu za oruzje");
		if(Bit1_Get(gr_PlayerLoggedIn, giveplayerid) != 0)
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
		    {
     			if(ProxDetectorS(3.0, playerid, giveplayerid))
			    {
					Player_SetHasFakeGunLicense(playerid, false);
					Player_SetHasFakeGunLicense(giveplayerid, true);
    				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
					format(globalstring, sizeof(globalstring), "* %s uzima dozvolu iz dzepa i daje je %s.", GetName(playerid), GetName(giveplayerid));
			        ProxDetector(5.0, playerid, globalstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije blizu vas !");
 			}
		}
		else SendClientMessage(playerid, COLOR_RED, "Taj igrac nije online !");
		return 1;
	}
	return 1;
}

CMD:mansion(playerid, params[]) {
	if(IsPlayerInRangeOfPoint(playerid, 15.0, 727.1630,-995.7117,52.7344) && GetPlayerVirtualWorld(playerid) == 0)
    {
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 734.0052,-1001.7106,69.8107, 7, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 734.0052,-1001.7106,69.8107);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 7);
				}
			}

			SetPlayerVirtualWorld(playerid, 7);
			SetVehicleVirtualWorld(vehicleid, 7);
			SetVehicleZAngle(vehicleid, 160);
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10.0, 734.0052,-1001.7106,69.8107) && GetPlayerVirtualWorld(playerid) == 7)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerPosEx(playerid, 727.1630,-995.7117,52.7344, 0, 0, false);
		}
		else
		{
			new
				vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, 727.1630,-995.7117,52.7344);
			SetVehicleVirtualWorld(vehicleid, 0);

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, vehicleid)){
					SetPlayerVirtualWorld(i, 0);
				}
			}

			SetPlayerVirtualWorld(playerid, 0);
			SetVehicleZAngle(vehicleid, -90);
		}
	}
	return (true);
}

CMD:changename(playerid, params[])
{
	new
		novoime[MAX_PLAYER_NAME],
		years,
		type,
		sex;

	if(sscanf( params, "s[24]iii", novoime, type, years, sex))
		return SendClientMessage(playerid, COLOR_RED, "[?]: /changename [Ime_Prezime][tip][godine][spol]"), SendClientMessage(playerid, -1, "SPOL: 2 - Zensko, 1 - Musko | TIP : 1 - standardni CN | 2- donatorski CN");
		
	switch(type)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pChangenames] > gettimestamp() && !PlayerVIP[playerid][pDonateRank]) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate vise prava na promjene imena! Izmjena dostupna za %s.", UnixTimestampToTime(PlayerInfo[playerid][pChangenames]));
			if(!PlayerVIP[playerid][pDonateRank] && AC_GetPlayerMoney(playerid) < 10000) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate 10.000$!");
		}
		case 2:
		{
			if(PlayerVIP[playerid][pDonateRank] > 0)
			{
				if(PlayerInfo[playerid][pChangeTimes] == 0)
					return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Potrosili ste sve dodatne changenameove koje ste dobili sa Premium Paketom. Izmjena dostupna za %s.", UnixTimestampToTime(PlayerInfo[playerid][pChangenames]));
			}
			else 
				return va_SendClientMessage(playerid, 
							COLOR_LIGHTRED, 
							"Niste vlasnik Premium Donator paketa. Vise o donacijama \n\
								na %s", 
							WEB_URL
						);
		}
	}
	if(strlen(novoime) > 20 || strlen(novoime) < 0)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unos imena mora biti do 20 znakova i vece od 0!");

	if(years > 100 || years < 16)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Godine nemogu biti ve�e od 100 ni manje od 16!");

	if(sex > 2 || sex < 0)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Spol mora biti 2(zensko) ili 1(musko).");
		
	if(type > 2 || type < 0)
	    return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Type mora biti 2(donatorski) ili 1(standardni).");	
	    
	if(!IsValidName(novoime))
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nepravilan Role Play format imena.");
	
	PlayerInfo[playerid][pSex] = sex;
	PlayerInfo[playerid][pAge] = years;
	
	ChangePlayerName(playerid, novoime, type, (false));
	return 1;
}

CMD:setlook(playerid, params[])
{
	new
		inputLook[120];
	
	if(sscanf(params, "s[120]", inputLook)) return SendClientMessage(playerid, COLOR_RED, "[?]: /setlook [opis]");
	if(strlen(inputLook) > 1 || strlen(inputLook) <= 120)
	{
		if(CheckStringForURL(inputLook) || CheckStringForIP(inputLook))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedozvoljene rijeci/znakovi u postavljanju izgleda!");
		
		format( PlayerAppearance[playerid][pLook], 120, "%s", inputLook);
		
		mysql_fquery(g_SQL, "UPDATE player_appearance SET look = '%e' WHERE sqlid = '%d'",
			PlayerAppearance[playerid][pLook], 
			PlayerInfo[playerid][pSQLID]
		);

		SendMessage(playerid, MESSAGE_TYPE_INFO, "Uspjesno ste postavili vas izgled, koristite /showme za prikaz izgleda.");
		
	} 
	else 
		SendMessage(playerid, MESSAGE_TYPE_ERROR, "Unos mora biti izmedju 1 i 120 charactera!");
	return 1;
}
CMD:showme(playerid, params[])
{
	if(strlen(PlayerAppearance[playerid][pLook]) >= 1 || strlen(PlayerAppearance[playerid][pLook]) <= 120)
	{
		new tmpString[200];
		format(tmpString, 200, "* %s izgleda kao %s",
			GetName(playerid, true),
			PlayerAppearance[playerid][pLook]
		);
		ProxDetector(15.0, playerid, tmpString, COLOR_SAMP_BLUE,COLOR_SAMP_BLUE,COLOR_SAMP_BLUE,COLOR_SAMP_BLUE,COLOR_SAMP_BLUE);
	} 
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate unesen izgled, koristite /setlook za postavljanje izgleda!");
	return 1;
}
CMD:examine(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /examine [ID / Part of name]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije online !"); 
	if(giveplayerid == playerid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Koristi /showme");
	if(IsPlayerReconing(giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas!");
	if(IsPlayerInAnyVehicle(giveplayerid) || !ProxDetectorS(20.0, playerid, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Taj igrac nije blizu vas ili je u vozilu!");
	if(strlen(PlayerAppearance[giveplayerid][pLook]) >= 1 || strlen(PlayerAppearance[giveplayerid][pLook]) <= 120)
	{
		new
			tmpString[200],
			string[200];
		format(tmpString, 200, "* %s izgleda kao %s",
			GetName(giveplayerid, true),
			PlayerAppearance[giveplayerid][pLook]
		);

		format(string, sizeof(string), "%s", tmpString);
		SendClientMessage(playerid, COLOR_SAMP_BLUE, string);
		
		format(tmpString, sizeof(tmpString), "* %s gleda u %s.",  GetName(playerid, true), GetName(giveplayerid, true));
		ProxDetector(15.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	} 
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Osoba nema namjesten izgled!");
	return 1;
}
CMD:accent(playerid, params[])
{
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_RED, "KORISTI: /accent [jezik]"), SendClientMessage(playerid, COLOR_WHITE, "Ukoliko Zelite izbrisati naglasak upiSite 'None'!");

	if(strlen(params) > 18 || strlen(params) < 3)
	    return SendClientMessage(playerid, COLOR_RED, "Naglasak ne moZe biti ve�i od 18 karaktera ni manji od 3 karaktera.");
	    
    if(CheckStringForURL(params) || CheckStringForIP(params))
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedozvoljene rijeci/znakovi u postavljanju naglaska!");
	    
	format(PlayerAppearance[playerid][pAccent], 32, params);
	SendClientMessage(playerid, COLOR_RED, "[!] UspjeSno ste promjenili vas naglasak.");
	return 1;
}
CMD:tow(playerid, params[])
{
	if(GetVehicleModel( GetPlayerVehicleID(playerid)) != 525) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u Tow Trucku!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste vozac!");
	
	new 
		bool:found = false,
		pvid = GetPlayerVehicleID(playerid);	
	

	foreach(new vid : StreamedVehicle[playerid])
	{
		if(IsPlayerInRangeOfVehicle(playerid, vid, 7.0) && (vid != pvid))
		{
			found = true;
			if(IsTrailerAttachedToVehicle(pvid))
			{
				if(ImpounderJob[playerid][ivID] != 0)
				{
					if(ImpounderJob[playerid][ivID] == vid)
						OPUnTowIV(playerid, vid);
				}
				DetachTrailerFromVehicle(pvid);
			}
			else
			{
				if(ImpounderJob[playerid][ivID] != 0)
				{
					if(ImpounderJob[playerid][ivID] != vid)
					{	
						SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Ovo vozilo nije na tvojoj impound listi!");
						return 1;
					}
					else
						OPTowIV(playerid, vid);
				}
				AttachTrailerToVehicle(vid, pvid);
			}
			break;
		}
	}
	
	if(!found) SendClientMessage(playerid,COLOR_RED, "Nema automobila okolo.");
	return 1;
}
CMD:putintrunk(playerid, params[])
{
	new
		vehicleid = GetNearestVehicle(playerid),
		giveplayerid;
	
    if(vehicleid == INVALID_VEHICLE_ID) 				
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu vozila.");
    if(IsVehicleWithoutTrunk(GetVehicleModel(vehicleid))) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ovo vozilo nema prtljaznik!");
    if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prtljaznik tog auta je zatvoren.");
    
	if(sscanf(params, "u", giveplayerid)) 			
		return SendClientMessage(playerid, -1, "KORISTI: /putintrunk [ID / Part of name]");
	if(giveplayerid == playerid) 						
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozets ubaciti samog sebe u prtljaznik.");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu tog igraca.");

	Bit1_Set( gr_TrunkOffer, giveplayerid, true);
	VehicleTrunk[giveplayerid] = vehicleid;
	
	SendClientMessage( giveplayerid, COLOR_RED, "[!] Sada mozes koristiti /entertrunk.");
	SendClientMessage( playerid, COLOR_RED, "[!] Ponudio si tom igracu da ga ubacis u prtljaznik.");
	return 1;
}

CMD:entertrunk(playerid, params[])
{
	if(!Bit1_Get( gr_TrunkOffer, playerid)) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nitko ti nije ponudio ulaz u gepek!");
	new 
		vehicleid = VehicleTrunk[playerid];
    
	if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 5.0)) 		
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu vozila.");
    if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF) 	
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Prtljaznik tog auta je zatvoren.");

	SendClientMessage( playerid,COLOR_RED, "[!]: Usao si u prtljaznik, mozes izaci sa /exittrunk ukoliko je otvoren.");
	SendClientMessage( playerid,COLOR_ORANGE, "[NAPOMENA]: Ukoliko se zbugas sa spectateom, re-konektuj se na server.");
	
	Bit1_Set( gr_TrunkOffer, 	playerid, false);
	Bit1_Set( gr_PlayerInTrunk, playerid, true);
	
	TogglePlayerSpectating( playerid, 1);
	PlayerSpectateVehicle( playerid, vehicleid);
	return 1;
}

CMD:exittrunk(playerid, params[])
{
	new
		vehicleid = VehicleTrunk[playerid];
	if(!Bit1_Get( gr_PlayerInTrunk, playerid)) 	return SendClientMessage(playerid,COLOR_RED, "Nisi u prtljazniku.");
    if(VehicleInfo[vehicleid][vTrunk] == VEHICLE_PARAMS_OFF) 	return SendClientMessage(playerid,COLOR_RED, "Prtljaznik tog auta je zatvoren.");
    
	GetVehiclePos(vehicleid, PlayerTrunkPos[playerid][0], PlayerTrunkPos[playerid][1], PlayerTrunkPos[playerid][2]);
	
	PlayerTrunkPos[playerid][2] += 2.0;

	TogglePlayerSpectating(playerid, 0);
	TogglePlayerControllable(playerid, true);
   	return 1;
}

CMD:setwalk(playerid, params[])
{
	new walkStyle;
	if(sscanf(params, "i", walkStyle)) return SendClientMessage(playerid, COLOR_WHITE,"[?]: /setwalk [ID stila]");
	if(walkStyle < 1  || walkStyle > 29) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi unos ID stila! (1-29)");
    SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Odabrali ste stil hodanja #%d.", walkStyle);

	PlayerAppearance[playerid][pWalkStyle] = walkStyle; 
	mysql_fquery(g_SQL, "UPDATE player_appearance SET walkstyle = '%d' WHERE sqlid = '%d'",
		walkStyle,
		PlayerInfo[playerid][pSQLID]
	);
	return 1;
}

CMD:spawnchange(playerid, params[])
{
	new spawn;
	if(PlayerJail[playerid][pJailed] == 1) return SendMessage(playerid, MESSAGE_TYPE_ERROR,"U zatvoru ste, ne mozete to!");
	if(sscanf(params, "i", spawn)) { SendClientMessage(playerid, COLOR_WHITE,"[?]: /spawnchange [0-5]"); SendClientMessage(playerid, COLOR_WHITE,"0 - Standardno | 1 - Kuca | 2 - Organizacija (LSPD/LSFD/LSN/GOV) | 3 - Complex Room | 4 - LSPD Wilshire Station. |5 LSPD Harbor"); return 1; }
	if(spawn < 0 || spawn > 5) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Neispravan ID spawna! (0-5)");
	if(spawn == 1)
	{
		if(PlayerKeys[playerid][pHouseKey] == INVALID_HOUSE_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete kucu!");
	}
	else if(spawn == 2)
	{
		if(PlayerFaction[playerid][pMember] == 0 && PlayerFaction[playerid][pLeader] == 0)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste clan organizacije!");
		
		new factionid = PlayerFaction[playerid][pMember];
		if(FactionInfo[factionid][fType] != 1 && FactionInfo[factionid][fType] != 2 && FactionInfo[factionid][fType] != 3 && FactionInfo[factionid][fType] != 7 && FactionInfo[factionid][fType] != 8) // Legalne fakcije
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste clan legalne organizacije!");
	}
	else if(spawn == 3)
	{
		if(PlayerKeys[playerid][pComplexRoomKey] == INVALID_COMPLEX_ID)
			return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne iznajmljujete stan u Complexu!");
	}
	else if(spawn == 4) {
		if(!IsACop(playerid) && !IsASD(playerid))	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac!");
		PlayerInfo[playerid][pSpawnChange] = spawn;
		SetPlayerSpawnInfo(playerid);
	}
	else if(spawn == 5){
	    if(!IsACop(playerid) && !IsASD(playerid))	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste policajac!");
		PlayerInfo[playerid][pSpawnChange] = spawn;
		SetPlayerSpawnInfo(playerid);
	}
	PlayerInfo[playerid][pSpawnChange] = spawn;
	SetPlayerSpawnInfo(playerid);
	
	mysql_fquery(g_SQL, "UPDATE accounts SET spawnchange = '%d' WHERE sqlid = '%d'", 
		PlayerInfo[playerid][pSpawnChange],
		PlayerInfo[playerid][pSQLID]
	);
	
    SendMessage(playerid, MESSAGE_TYPE_INFO, "Sljedeci put cete se spawnati na zeljenom mjestu.");
	return 1;
}
CMD:mycigars(playerid, params[])
{
	if(PlayerInventory[playerid][pCiggaretes] == 0) return SendClientMessage(playerid, COLOR_RED, "Nemas cigareta kod sebe.");
	SendClientMessage(playerid, COLOR_ORANGE, "*_______CIGARS INFO_______*");
	va_SendClientMessage(playerid, COLOR_GREY,"Cigarete: %d komada",PlayerInventory[playerid][pCiggaretes]);
	if(!PlayerInventory[playerid][pLighter]) 
		SendClientMessage(playerid, COLOR_GREY, "Upaljac: Nema");
	else  
		SendClientMessage(playerid, COLOR_GREY, "Upaljac: Ima");
	return 1;
}
CMD:clearmychat(playerid, params[])
{
    if(isnull(params))
        return SendClientMessage(playerid, COLOR_WHITE, "[KORISTENJE]: /clearmychat [linije]");
       
    new
        sval = strval(params);
       
    if(sval < 1 || sval > 20)
        return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete ocistiti vise od 20 poruka ili manje od 1 poruke!");
       
    ClearPlayerChat(playerid);
    return 1;
}
/*
CMD:marry(playerid, params[])
{
 	new
    	giveplayerid;
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 367.7090, 2325.3110, 1889.6040)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar crkve!");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_RED, "[?]: /marry [playerid / Part of name]");
	if(giveplayerid == INVALID_PLAYER_ID) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Krivi playerid!");
    if(giveplayerid == playerid) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozete sami sebe vjencati.");
	if(!ProxDetectorS(5.0, playerid, giveplayerid)) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nisi blizu tog igraca!");
	
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Poslali ste zahtjev za vjencanjem %s", GetName(giveplayerid));
    SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "%s vam je poslao zahtjev za vjencanjem, kucajte /accept marriage za vjencanje!", GetName(playerid));
    MarriagePartner[playerid] 		= giveplayerid;
    MarriagePartner[giveplayerid] 	= playerid;
	return 1;
}*/

#if defined MODULE_DEATH
CMD:acceptdeath(playerid, params[])
{
	if(!PlayerWounded[playerid] && WoundedBy[playerid] == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_GREY, "Niste u wounded stanju.");

	SetPlayerDrunkLevel(playerid, 0);
	SetPlayerHealth(playerid, 100);
	TogglePlayerControllable(playerid, 0);

	PlayerDeath[playerid][pKilled] = 2;
	SendClientMessage(playerid, COLOR_RED, "Prihvatili ste smrt, prebaceni ste u death mode..");
	ApplyAnimation(playerid,"WUZI","CS_DEAD_GUY", 4.0,0,1,1,1,0);

	DeathCountStarted_Set(playerid, true);
	DeathCountSeconds_Set(playerid, 61);

	CreateDeathTD(playerid);
	CreateDeathInfos(playerid, 1);

	DeathTimer[playerid] = repeat StartDeathCount(playerid);
	return 1;
}
#endif

CMD:rand(playerid, params[])
{
	new TempString[128];
	new MaxNum, RandAction[64];
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	if(sscanf(params, "ds[64]", MaxNum, RandAction)) return SendClientMessage(playerid, COLOR_WHITE,"[?]: /rand [Maksimalna vrijednost][Akcija]");
	if(MaxNum > 10000 || MaxNum < 2) return SendErrorMessage(playerid, "Maksimalna vrijednost moze ici od 2 do 10,000!");
	new RandNum = 1+random(MaxNum);
	format(TempString, sizeof(TempString), "** %s %s - %d (Max:%d)", GetName(playerid, true), RandAction, RandNum, MaxNum);
	ProxDetector(5.0, playerid, TempString, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
    return 1;
}
CMD:card(playerid, params[])
{
	new TempString[128];
	if(PlayerInfo[playerid][pMuted]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne mozes pricati!");
	new KartaBroj = 1+random(14);
	new KartaStr1[4];
	new KartaZnak = 1+random(4);
	new KartaStr2[8];
	if(KartaZnak == 1) { format(KartaStr2, sizeof(KartaStr2), "SRCE"); }
	else if(KartaZnak == 2) { format(KartaStr2, sizeof(KartaStr2), "PIK"); }
	else if(KartaZnak == 3) { format(KartaStr2, sizeof(KartaStr2), "KARO"); }
	else { format(KartaStr2, sizeof(KartaStr2), "LIST"); }
	if(KartaBroj == 14) { format(KartaStr1, sizeof(KartaStr1), "K"); }
	else if(KartaBroj == 13) { format(KartaStr1, sizeof(KartaStr1), "Q"); }
	else if(KartaBroj == 12) { format(KartaStr1, sizeof(KartaStr1), "J"); }
	else if(KartaBroj == 11) { format(KartaStr1, sizeof(KartaStr1), "A"); }
	else if(KartaBroj == 1) { format(KartaStr1, sizeof(KartaStr1), "A"); }
	else { format(KartaStr1, sizeof(KartaStr1), "%d", KartaBroj); }
	format(TempString, sizeof(TempString), "* %s vadi kartu iz spila i okrece je - %s %s", GetName(playerid, true), KartaStr1, KartaStr2);
	ProxDetector(5.0, playerid, TempString, COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN,COLOR_GREEN);
	return 1;
}
CMD:usetoolkit(playerid, params[])
{
	new Float:health;
	new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
	if(PlayerInventory[playerid][pToolkit] != 1) return SendClientMessage(playerid, COLOR_RED, "Nemate toolkit, mozete ga kupiti u 24/7.");
	if(health > 400) return SendClientMessage(playerid, COLOR_RED, "Vasem vozilu nije potreban popravak");
	
	AC_SetVehicleHealth(playerid, health+100);
	PlayerInventory[playerid][pToolkit] = 0;
	SendClientMessage(playerid, COLOR_RED, "[!] Popravili ste va�e vozilo za dodatnih 100hp.");
	return 1;
}
CMD:usecigarette(playerid, params[])
{
	if(PlayerInventory[playerid][pCiggaretes] < 1) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemate cigareta!");
	if(!PlayerInventory[playerid][pLighter]) return SendClientMessage(playerid, COLOR_RED, "[GRESKA]: Nemaš upaljac!");

	ApplyAnimationEx(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0,1,0);
	SetPlayerSpecialAction(playerid, 21);
	
	SendClientMessage(playerid, COLOR_LIGHTRED, "INFO: Stisni lijevu tipku misa da pocnes pusiti.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "INFO: Koristi tipku ENTER da bacis cigaretu.");
	
	new
		tmpString[50];
	format(tmpString, sizeof(tmpString), "* %s pali cigaretu i pusi.", 
		GetName(playerid, true)
	);
	ProxDetector(30.0, playerid, tmpString,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	
	Bit1_Set( gr_SmokingCiggy, playerid, true);
	PlayerInventory[playerid][pCiggaretes] -= 1;
    return 1;
}
