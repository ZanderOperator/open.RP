#include <YSI_Coding\y_hooks>

/*

		  ___    _   ___ ___ ___    ___ _____ _ _____ ___ ___  _  _ ___
		 | _ \  /_\ |   \_ _/ _ \  / __|_   _/_\_   _|_ _/ _ \| \| / __|
		 |   / / _ \| |) | | (_) | \__ \ | |/ _ \| |  | | (_) | . \__ \
		 |_|_\/_/ \_\___/___\___/  |___/ |_/_/ \_\_| |___\___/|_|\_|___/


*/

#define HIP_HOP_RADIO_URL			"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk6.internet-radio.com:8213/listen.pls&t=.pls"
#define RAP_RADIO_URL				"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8016/listen.pls?sid=1&t=.pls!"
#define GANGSTA_RAP_RADIO_URL		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://5.196.56.208:8048/listen.pls?sid=1&t=.pls"
#define BALKAN_HIPHOP_RADIO_URL 	"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://88.198.233.68:2022/listen.pls&t=.pls"
#define TURBO_FOLK_RADIO_URL		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://carsija.topstream.net:19406/listen.pls?sid=1&t=.pls"
#define CLASSIC_HITS_RADIO_URL		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://209.95.50.189:8025/listen.pls&t=.pls"
#define CLASSIC_ROCK_RADIO_URL		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8258/listen.pls&t=.pls"
#define REGGAE_RADIO_URL			"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us5.internet-radio.com:8487/listen.pls&t=.pls"
#define TECHNO_RADIO_URL			"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8046/listen.pls?sid=1&t=.pls"
#define SEVENTEES_RADIO_URL			"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us5.internet-radio.com:8267/listen.pls&t=.pls"
#define EUROBEAT_RADIO_URL			"https://stream.laut.fm/eurobeat.pls"
#define MORRISON_RADIO_URL 			"http://freeuk30.listen2myradio.com:37080/"
#define COOLRADIO_RADIO_URL 		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://live.coolradio.rs:80/cool192.m3u&t=.pls"
#define FREEBROOKLYN_RADIO_URL 		"https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us1.internet-radio.com:8155/live.m3u&t=.pls"

/*
	##     ##    ###    ########   ######
	##     ##   ## ##   ##     ## ##    ##
	##     ##  ##   ##  ##     ## ##
	##     ## ##     ## ########   ######
	 ##   ##  ######### ##   ##         ##
	  ## ##   ##     ## ##    ##  ##    ##
	   ###    ##     ## ##     ##  ######
*/

enum E_BOOMBOX_DATA 
{
	Float:mX,
	Float:mY,
	Float:mZ,
	Float:mRange,
	mType,
	mURL[256]
}
static 
	MusicInfo[MAX_PLAYERS][E_BOOMBOX_DATA];

static
	HouseMusicURL[MAX_HOUSES][256],
	bool:HousePlayingMusic[MAX_HOUSES],
	bool:VehiclePlayingMusic[MAX_VEHICLES],
	MusicCircle[MAX_PLAYERS],
	BoomBoxVehURL[MAX_VEHICLES][256],
	BoomBoxDialogPos[MAX_PLAYERS][12],
	//rBits
	Bit1: gr_AttachedBoombox <MAX_PLAYERS>  = Bit1: false,
	Bit1: gr_MusicApproved <MAX_PLAYERS>  = Bit1: false,
	Bit1: gr_MusicPlaying <MAX_PLAYERS>  = Bit1: false;
	

/*
	 ######  ########  #######   ######  ##    ##
	##    ##    ##    ##     ## ##    ## ##   ##
	##          ##    ##     ## ##       ##  ##
	 ######     ##    ##     ## ##       #####
		  ##    ##    ##     ## ##       ##  ##
	##    ##    ##    ##     ## ##    ## ##   ##
	 ######     ##     #######   ######  ##    ##
*/

stock ReturnHouseMusicURL(houseid)
{
	return HouseMusicURL[houseid];
}

stock IsHousePlayingMusic(houseid)
{
	return HousePlayingMusic[houseid];
}

stock ClearBoomBoxListItems(playerid)
{
	BoomBoxDialogPos[playerid][0]	= -1;
	BoomBoxDialogPos[playerid][1]	= -1;
	BoomBoxDialogPos[playerid][2]	= -1;
	BoomBoxDialogPos[playerid][3]	= -1;
	BoomBoxDialogPos[playerid][4]	= -1;
	BoomBoxDialogPos[playerid][5]	= -1;
	BoomBoxDialogPos[playerid][6]	= -1;
	BoomBoxDialogPos[playerid][7]	= -1;
	BoomBoxDialogPos[playerid][8]	= -1;
	BoomBoxDialogPos[playerid][9]	= -1;
	BoomBoxDialogPos[playerid][10]	= -1;
	BoomBoxDialogPos[playerid][11]	= -1;
}

stock StopPlayerVehicleMusic(playerid)
{
	StopAudioStreamForPlayer(playerid);
	Bit1_Set( gr_MusicPlaying, playerid, false );
	foreach(new i : Player) {
		if(BoomBoxPlanted[i] ) {
			if(IsPlayerInRangeOfPoint(playerid, MusicInfo[i][mRange], MusicInfo[i][mX], MusicInfo[i][mY], MusicInfo[i][mZ])) {
				PlayAudioStreamForPlayer(playerid, MusicInfo[i][mURL], MusicInfo[i][mX], MusicInfo[i][mY], MusicInfo[i][mZ], MusicInfo[i][mRange], 1);
				Bit1_Set( gr_MusicPlaying, playerid, true );
			}
		}
	}
}
stock IsPlayerInMusicCircle(playerid)
{
	new bool:circle = false;
	foreach(new m : Player)
	{
		new areaid = Bit4_Get( gr_MusicCircle, playerid );
		if(MusicCircle[m] == areaid)
		{
			circle = true;
			break;
		}
	}
	return circle;
}

stock ClearVehicleMusic(vehicleid)
{
	if(VehiclePlayingMusic[vehicleid] ) {
		VehiclePlayingMusic[vehicleid] = false;
		BoomBoxVehURL[vehicleid][0] = '\0';
	}
}

stock ResetMusicVars(playerid)
{
	if(IsValidDynamicArea(MusicCircle[playerid]))
		DestroyDynamicArea(MusicCircle[playerid]);

	MusicInfo[playerid][mX] = 0.0;
	MusicInfo[playerid][mY] = 0.0;
	MusicInfo[playerid][mZ] = 0.0;
	MusicInfo[playerid][mRange] = 0.0;
	MusicInfo[playerid][mType] = 0;
	MusicInfo[playerid][mURL] = '\0';
	MusicCircle[playerid] = -1;
	return 1;
}

/*
	##     ##  #######   #######  ##    ##
	##     ## ##     ## ##     ## ##   ##
	##     ## ##     ## ##     ## ##  ##
	######### ##     ## ##     ## #####
	##     ## ##     ## ##     ## ##  ##
	##     ## ##     ## ##     ## ##   ##
	##     ##  #######   #######  ##    ##
*/

hook function ResetVehicleInfo(vehicleid)
{
	ClearVehicleMusic(vehicleid);
	return continue(vehicleid);
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(VehiclePlayingMusic[vehicleid] ) {
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, BoomBoxVehURL[vehicleid]);
		Bit1_Set( gr_MusicPlaying, playerid, true );
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && newstate == PLAYER_STATE_ONFOOT && Bit1_Get(gr_MusicPlaying, playerid))
		StopPlayerVehicleMusic(playerid);

	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	StopPlayerVehicleMusic(playerid);
	return 1;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	if(MusicCircle[playerid] == areaid && !Bit1_Get( gr_MusicPlaying, playerid))
	{
		new
			veh = GetPlayerVehicleID(playerid),
			model = GetVehicleModel(veh),
			driverw,
			passengerw,
			backleftw,
			backrightw;
		GetVehicleParamsCarWindows(veh, driverw, passengerw, backleftw, backrightw);
		if(!IsPlayerInAnyVehicle(playerid) || IsABike(model) || IsAMotorBike(model))
		{
			PlayAudioStreamForPlayer(playerid, MusicInfo[playerid][mURL], MusicInfo[playerid][mX], MusicInfo[playerid][mY], MusicInfo[playerid][mZ], MusicInfo[playerid][mRange], 1);
			Bit1_Set( gr_MusicPlaying, playerid, true );
			Bit4_Set( gr_MusicCircle, playerid, areaid );
		}
		else if(driverw == 0 && !VehiclePlayingMusic[veh] || passengerw == 0 && !VehiclePlayingMusic[veh] || backleftw == 0 && !VehiclePlayingMusic[veh] || backrightw == 0 && !VehiclePlayingMusic[veh] )
		{
			PlayAudioStreamForPlayer(playerid, MusicInfo[playerid][mURL], MusicInfo[playerid][mX], MusicInfo[playerid][mY], MusicInfo[playerid][mZ], MusicInfo[playerid][mRange], 1);
			Bit1_Set( gr_MusicPlaying, playerid, true );
			Bit4_Set( gr_MusicCircle, playerid, areaid );
		}
	}
	return 1;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	if(MusicCircle[playerid] == areaid)
	{
		new
			veh = GetPlayerVehicleID(playerid),
			model = GetVehicleModel(veh);
		if(!IsPlayerInAnyVehicle(playerid) || IsABike(model) || IsAMotorBike(model))
		{
			StopAudioStreamForPlayer(playerid);
			Bit1_Set( gr_MusicPlaying, playerid, false );
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	ResetMusicVars(playerid);
	if(BoomBoxPlanted[playerid] == true)
	{
		DestroyDynamicObject(BoomBoxObject[playerid]);
		StopAudioStreamForPlayer(playerid);
		BoomBoxPlanted[playerid] = false;
	}
	if(Bit1_Get( gr_AttachedBoombox, playerid ))
	    Bit1_Set( gr_AttachedBoombox, playerid, false );
	if(Bit1_Get( gr_MusicPlaying, playerid ))
	    Bit1_Set( gr_MusicPlaying, playerid, false );
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new
		Float:x, Float:y, Float:z,
		vehicleid;
	GetPlayerPos(playerid, x, y, z);
	vehicleid = GetPlayerVehicleID(playerid);
	switch(dialogid)
	{
	    case DIALOG_MUSIC_MAIN:
		{
			if(!response ) return 1;
			new url[256];
			ClearBoomBoxListItems(playerid);
			// TODO: refactor, make an array of all URLs
			switch(listitem)
			{
				case 0: format(url, sizeof(url), "%s", HIP_HOP_RADIO_URL);
				case 1: format(url, sizeof(url), "%s", RAP_RADIO_URL);
				case 2: format(url, sizeof(url), "%s", GANGSTA_RAP_RADIO_URL);
				case 3: format(url, sizeof(url), "%s", BALKAN_HIPHOP_RADIO_URL);
				case 4: format(url, sizeof(url), "%s", TURBO_FOLK_RADIO_URL);
				case 5: format(url, sizeof(url), "%s", CLASSIC_HITS_RADIO_URL);
				case 6: format(url, sizeof(url), "%s", CLASSIC_ROCK_RADIO_URL);
				case 7: format(url, sizeof(url), "%s", REGGAE_RADIO_URL);
				case 8: format(url, sizeof(url), "%s", TECHNO_RADIO_URL);
				case 9: format(url, sizeof(url), "%s", SEVENTEES_RADIO_URL);
				case 10: format(url, sizeof(url), "%s", EUROBEAT_RADIO_URL);
				case 11: format(url, sizeof(url), "%s", MORRISON_RADIO_URL);
				case 12: format(url, sizeof(url), "%s", COOLRADIO_RADIO_URL);
				case 13: format(url, sizeof(url), "%s", FREEBROOKLYN_RADIO_URL);
			}
			new
				houseid = Player_InHouse(playerid);

			if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT )
			{
				if(houseid != INVALID_HOUSE_ID )
				{
					HouseMusicURL[houseid][0] = EOS;
					// TODO: strcpy
					format(HouseMusicURL[houseid], 256, "%s", url);
					foreach(new i : Player) {
						if(IsPlayerInRangeOfPoint(i, 25.0, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY],HouseInfo[houseid][hExitZ]) && GetPlayerVirtualWorld( i ) == HouseInfo[houseid][hVirtualWorld] ) {
							StopAudioStreamForPlayer(i);
							PlayAudioStreamForPlayer(i, HouseMusicURL[houseid]);
							Bit1_Set( gr_MusicPlaying, playerid, true );
						}
					}
				}
				else
				{
					MusicInfo[playerid][mURL][0] = EOS;
					format(MusicInfo[playerid][mURL], 256, "%s", url);
					MusicInfo[playerid][mType] = 1;
					MusicInfo[playerid][mRange] = 15.0;
					MusicCircle[playerid] = CreateDynamicCircle(MusicInfo[playerid][mX], MusicInfo[playerid][mY], MusicInfo[playerid][mRange], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
					foreach(new i : Player) {
						if(IsPlayerInRangeOfPoint(i, MusicInfo[playerid][mRange], x, y, z)) {
							StopAudioStreamForPlayer(i);
							PlayAudioStreamForPlayer(i, MusicInfo[playerid][mURL], MusicInfo[playerid][mX], MusicInfo[playerid][mY], MusicInfo[playerid][mZ], MusicInfo[playerid][mRange], 1);
							Bit1_Set( gr_MusicPlaying, i, true );
						}
					}
				}
			}
			else if(IsPlayerInAnyVehicle(playerid))
			{
				BoomBoxVehURL[vehicleid][0] = EOS;
				format(BoomBoxVehURL[vehicleid], 256, "%s", url);
				foreach(new i : Player)
				{
					if(IsPlayerInVehicle(i, vehicleid )) {
						StopAudioStreamForPlayer(i);
						PlayAudioStreamForPlayer(i, BoomBoxVehURL[vehicleid]);
						Bit1_Set( gr_MusicPlaying, i, true );
					}
				}
			}
			return 1;
		}
	}
	return 0;
}

hook OnPlayerEditAtObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(modelid == 2226 || modelid == 2103 ) {
	    if(response )
	        Bit1_Set( gr_AttachedBoombox, playerid, true );
		else
	        RemovePlayerAttachedObject( playerid, 9);
	}
	return 1;
}
/*
	 ######  ##     ## ########
	##    ## ###   ### ##     ##
	##       #### #### ##     ##
	##       ## ### ## ##     ##
	##       ##     ## ##     ##
	##    ## ##     ## ##     ##
	 ######  ##     ## ########
*/
CMD:music(playerid, params[])
{
	new
		option[12], string[64],
		Float:x, Float:y, Float:z,
		Float:ox, Float:oy, Float:oz;

    if(sscanf(params, "s[12] ", option))
		return SendClientMessage(playerid, -1, "KORISTI: /music [opcija]"), SendClientMessage(playerid, COLOR_RED, "[!] take, play, stream, stop, attach, detach");

	if(!strcmp(option, "put"))
    {
		if(!PlayerInventory[playerid][pBoomBox] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati boombox kako bi mogli koristiti ovu komandu!");
		if(BoomBoxPlanted[playerid] == false) {

			format(string, sizeof(string), "*%s stavlja svoj boombox na pod.", GetName(playerid, true));
			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
			GetPlayerPos(playerid, x, y, z);
			MusicInfo[playerid][mX] = x;
			MusicInfo[playerid][mY] = y;
			MusicInfo[playerid][mZ] = z;
			switch(PlayerInventory[playerid][pBoomBox]) {
				case 1: { // Obican crveni boombox
					BoomBoxObject[playerid] = CreateDynamicObject(2226, x, y, z-0.9, 0, 0, random(100), -1, -1, -1, 200.0);
					BoomBoxPlanted[playerid] = true;
				}
				case 2: { // Silver King
					BoomBoxObject[playerid] = CreateDynamicObject(2103, x, y, z-0.9, 0, 0, random(100), -1, -1, -1, 200.0);
					BoomBoxPlanted[playerid] = true;
				}
			}
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec ste postavili vas boombox te ne mozete koristiti ovu komandu!");
	}
	else if(!strcmp(option, "take"))
	{
		if(!PlayerInventory[playerid][pBoomBox] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati boombox kako bi mogli koristiti ovu komandu!");
		if(BoomBoxPlanted[playerid] == true) {
			GetDynamicObjectPos(BoomBoxObject[playerid], ox, oy, oz);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, ox, oy, oz)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog boom boxa!");
			foreach(new i : Player) {
				if(IsPlayerInRangeOfPoint(i, 20.0, ox, oy, oz))
					StopAudioStreamForPlayer(i);
			}

			ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
			ResetMusicVars(playerid);
			format(string, sizeof(string), "*%s uzima svoj boombox s poda.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);

			DestroyDynamicObject(BoomBoxObject[playerid]);
			BoomBoxObject[playerid] = INVALID_OBJECT_ID;
			BoomBoxPlanted[playerid] = false;
		}
		else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste postavili radio! ((/music put))");
	}
	else if(!strcmp(option, "approve"))
	{
		new giveplayerid;
		if(sscanf( params, "s[12]u", option, giveplayerid )) return SendClientMessage(playerid, COLOR_RED, "[?]: /music approve [playerid]");
		if(PlayerInfo[playerid][pAdmin] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 2+");
		if(Bit1_Get(gr_MusicApproved, giveplayerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Igrac vec ima odobreno pustanje glazbe!");
		Bit1_Set(gr_MusicApproved, giveplayerid, true);
		va_SendClientMessage(playerid, COLOR_RED, "[!] Odobrili ste igracu %s da koristi /music url.", GetName(giveplayerid));
		SendFormatMessage(giveplayerid, MESSAGE_TYPE_INFO, "Admin %s Vam je odobrio da korisite /music url na Boomboxu", GetName(playerid));
	}
	else if(!strcmp(option, "url"))
	{
		if(!Bit1_Get(gr_MusicApproved, playerid))
		{
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate odobrenje od admina da koristite /music url!");
			SendClientMessage(playerid, COLOR_WHITE, "[HINT]: Ukoliko zelite pustati muziku radi RP eventa/RP-a, zamolite admina za approve na /report.");
			return 1;
		}
		new
			url[200], radius;
		if(sscanf( params, "s[12]s[200]i", option, url, radius )) return SendClientMessage(playerid, COLOR_RED, "[?]: /music url [MP3_download_link/Stream link][radius]");
		if(radius < 10 || radius > 200) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Radius ne moze biti manji od 10 ni veci od 200!");
		GetDynamicObjectPos(BoomBoxObject[playerid], ox, oy, oz);
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, ox, oy, oz)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog boom boxa!");
		ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
		format(string, sizeof(string), "*%s pali radio i namjesta pjesmu.", GetName(playerid, true));
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);

		strmid(MusicInfo[playerid][mURL], url, 0, sizeof(url), 200);
		MusicInfo[playerid][mType] = 1;
		MusicInfo[playerid][mRange] = floatround(radius);
		MusicCircle[playerid] = CreateDynamicCircle(ox, oy, MusicInfo[playerid][mRange], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
		foreach(new i : Player)
		{
			if(IsPlayerInRangeOfPoint(i, MusicInfo[playerid][mRange], ox, oy, oz)) {
				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url, ox, oy, oz, MusicInfo[playerid][mRange], 1);
				Bit1_Set( gr_MusicPlaying, i, true );
			}
		}
	}
	else if(!strcmp(option, "stream"))
	{
		new
			url[200];
		if(sscanf( params, "s[12]s[200]", option, url )) return SendClientMessage(playerid, COLOR_RED, "[?]: /music stream [www.internet-radio.com Stream link]");
		if(IsPlayerInMusicCircle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec netko u vasoj blizini koristi BoomBox. Udaljite se 20m i pokusajte ponovno!");
		GetDynamicObjectPos(BoomBoxObject[playerid], ox, oy, oz);
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, ox, oy, oz)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog boom boxa!");
		ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
		format(string, sizeof(string), "*%s pali radio i namjesta radio stanicu.", GetName(playerid, true));
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
		MusicCircle[playerid] = CreateDynamicCircle(ox, oy, 15.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
		strmid(MusicInfo[playerid][mURL], url, 0, sizeof(url), 200);
		foreach(new i : Player)
		{
			if(IsPlayerInRangeOfPoint(i, MusicInfo[i][mRange], ox, oy, oz)) {
				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url, ox, oy, oz, MusicInfo[playerid][mRange], 1);
				Bit1_Set( gr_MusicPlaying, i, true );
			}
		}
	}
	else if(!strcmp(option, "play"))
	{
		new
			pick;
		if(sscanf( params, "s[12]i", option, pick )) return SendClientMessage(playerid, COLOR_RED, "[?]: /music play [1-foot/2-auto/3-kuca]");

		if(pick == 1 ) {
			GetDynamicObjectPos(BoomBoxObject[playerid], ox, oy, oz);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, ox, oy, oz)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog boom boxa!");
			ShowPlayerDialog(playerid, DIALOG_MUSIC_MAIN, DIALOG_STYLE_LIST, "Odaberite kategoriju", "Hip Hop\nRap\nGangsta Rap\nBalkan Hip Hop\nTurbo Folk\nClassical Hits\nClassical Rock\nReggae\nTechno\n70s music\n EuroBeat\nMorisson\nCool Radio\nFree Brooklyn", "Choose", "Exit");
			format(string, sizeof(string), "*%s pali radio, te trazi stanicu.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
			foreach(new i : Player)
			{
				if(IsPlayerInRangeOfPoint(i, 10.0, ox, oy, oz)) {
					StopAudioStreamForPlayer(i);
					PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/e39z7fe1xp/Radio_Tuning_Sound_Effect.mp3", ox, oy, oz, 20.0, 1);
				}
			}
		}
		else if(pick == 2 ) {
			if(!IsPlayerInAnyVehicle( playerid )) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste u vozilu!");
			new
				vehicleid = GetPlayerVehicleID(playerid);
			if(!VehicleInfo[vehicleid][vAudio] ) 	return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vozilo nema stereo!");

			ShowPlayerDialog(playerid, DIALOG_MUSIC_MAIN, DIALOG_STYLE_LIST, "Odaberite kategoriju", "Hip Hop\nRap\nGangsta Rap\nBalkan Hip Hop\nTurbo Folk\nClassical Hits\nClassical Rock\nReggae\nTechno\n70s music\nEuro Beat\nMorisson\nCool Radio\nFree Brooklyn", "Choose", "Exit");

			format(string, sizeof(string), "*%s pali radio u automobilu, te trazi stanicu.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);

			VehiclePlayingMusic[GetPlayerVehicleID(playerid)] = true;
		}
		else if(pick == 3 ) {
			new
				houseid = Player_InHouse(playerid);
			if(houseid == INVALID_HOUSE_ID ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar kuce!");
			if(!IsPlayerInRangeOfPoint(playerid, 25.0, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY],HouseInfo[houseid][hExitZ]) && GetPlayerVirtualWorld( playerid ) != HouseInfo[houseid][hVirtualWorld] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste unutar kuce!");
			if(!HouseInfo[houseid][hRadio] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Kuca ne posjeduje radio!");
			ShowPlayerDialog(playerid, DIALOG_MUSIC_MAIN, DIALOG_STYLE_LIST, "Odaberite kategoriju", "Hip Hop\nRap\nGangsta Rap\nBalkan Hip Hop\nTurbo Folk\nClassical Hits\nClassical Rock\nReggae\nTechno\n70s musi\nEuro Beatc\nMorisson\nCool Radio\nFree Brooklyn", "Choose", "Exit");

			format(string, sizeof(string), "*%s pali radio u kuci, te traZi stanicu.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);

			HousePlayingMusic[houseid] = true;
		}
	}
	else if(!strcmp(option, "stop"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			if(Player_InHouse(playerid) != INVALID_HOUSE_ID)
			{
				new
					houseid = Player_InHouse(playerid);
				HouseMusicURL[houseid][0] = EOS;
				foreach(new i : Player) {
					if(IsPlayerInRangeOfPoint(i, 25.0, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY],HouseInfo[houseid][hExitZ]) && GetPlayerVirtualWorld( i ) == HouseInfo[houseid][hVirtualWorld] ) {
						StopAudioStreamForPlayer(i);
					}
				}
				ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1, 0);
				ResetMusicVars(playerid);
				format(string, sizeof(string), "*%s gasi radio.", GetName(playerid, true));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
				return 1;
			}

			GetDynamicObjectPos(BoomBoxObject[playerid], ox, oy, oz);
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, ox, oy, oz)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu postavljenog boom boxa!");

			format(string, sizeof(string), "*%s gasi radio.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
			foreach(new i : Player) {
				if(IsPlayerInRangeOfPoint(i, 20.0, ox, oy, oz))
					StopAudioStreamForPlayer(i);
			}
		}
		else
		{
			format(string, sizeof(string), "*%s gasi radio u vozilu.", GetName(playerid, true));
			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 10000);
			VehiclePlayingMusic[GetPlayerVehicleID(playerid)] = false;

			foreach(new i : Player) {
				if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) )
					StopAudioStreamForPlayer(i);
			}
		}
	}
	else if(!strcmp(option, "attach", true)) {
	    if(!PlayerInventory[playerid][pBoomBox] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati boombox kako bi mogli koristiti ovu komandu!");
	    if(Bit1_Get( gr_AttachedBoombox, playerid )) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate boombox na sebi!");

		SetPlayerAttachedObject(playerid, 9, ( PlayerInventory[playerid][pBoomBox] == 1 ) ? 2226 : 2103, 5);
		EditAttachedObject(playerid, 9);
		Bit1_Set( gr_AttachedBoombox, playerid, true);
		SendClientMessage(playerid, COLOR_RED, "[HINT]: Za okretanje kamere koristite ~k~~PED_SPRINT~. Da maknete boombox iz ruke kucajte /music detach!");
	}
	else if(!strcmp(option, "detach", true)) {
	    if(!PlayerInventory[playerid][pBoomBox] ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati boombox kako bi mogli koristiti ovu komandu!");
	    if(!Bit1_Get( gr_AttachedBoombox, playerid )) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate boombox na sebi!");

		RemovePlayerAttachedObject(playerid, 9);
		Bit1_Set( gr_AttachedBoombox, playerid, false );
	}
	return 1;
}
CMD:removemusic(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
    new
		Float:ox, Float:oy, Float:oz;
	foreach(new i : Player)
 	{
		if(BoomBoxPlanted[i] )
		{
			GetDynamicObjectPos(BoomBoxObject[i], ox, oy, oz);
			if(IsPlayerInRangeOfPoint(playerid, 10.0, ox, oy, oz))
			{
				DestroyDynamicObject(BoomBoxObject[i]);
				StopAudioStreamForPlayer(i);
			}
		}
	}
	return 1;
}

