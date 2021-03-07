#include <YSI_Coding\y_hooks>

/*
	########  ######## ######## #### ##    ## ########  ######  
	##     ## ##       ##        ##  ###   ## ##       ##    ## 
	##     ## ##       ##        ##  ####  ## ##       ##       
	##     ## ######   ######    ##  ## ## ## ######    ######  
	##     ## ##       ##        ##  ##  #### ##             ## 
	##     ## ##       ##        ##  ##   ### ##       ##    ## 
	########  ######## ##       #### ##    ## ########  ######  
*/

#define ADS_TIME_DURATION				(300)			// 5 min
#define ADS_TIME_DELAY					(60)			// 1 min - razmak izmedu oglasa
#define MAX_AD_TEXT						(128)
#define MAX_ADS							(60)
#define PRICE_PER_CHAR					(4)

static 
	Iterator:Ad<MAX_ADS>;

enum 
{
	AD_STYLE_SELL = 0,		// Prodaja
	AD_STYLE_BUY,			// Kupovina
	AD_STYLE_CMRC			// Reklama
}

enum E_ADS_DATA 
{
	adSenderId,
	adStyle,
	adPrice,
	adText[MAX_AD_TEXT],
	adTimes,
	adTimeStamp
}
static
	AdsInfo[MAX_ADS][E_ADS_DATA];
	
enum E_PLAYER_ADS_DATA 
{
	padStyle,
	padPrice,
	padText[MAX_AD_TEXT],
	padTimes
}
static
	PlayerAdsInfo[MAX_PLAYERS][E_PLAYER_ADS_DATA];
	
static
	LastAdsListIndex[MAX_PLAYERS],
	lastAdId	= -1,
	lastAdShown = -1,
	lastAdStamp = -1;

/*
	 ######  ########  #######   ######  ##    ##  ######  
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	##          ##    ##     ## ##       ##  ##   ##       
	 ######     ##    ##     ## ##       #####     ######  
		  ##    ##    ##     ## ##       ##  ##         ## 
	##    ##    ##    ##     ## ##    ## ##   ##  ##    ## 
	 ######     ##     #######   ######  ##    ##  ######  
*/

static GetAdStyleString(styleid)
{
	new
		buffer[10];
		
	switch(styleid) {
		case AD_STYLE_BUY: 	format(buffer, 10, "KUPOVINA");
		case AD_STYLE_SELL: format(buffer, 10, "PRODAJA");
		case AD_STYLE_CMRC: format(buffer, 10, "REKLAMA");
	}
	return buffer;
}

static PlayerGotAd(playerid)
{

	foreach(new i: Ad)
	{
		if(AdsInfo[i][adSenderId] == PlayerInfo[playerid][pSQLID])
		{
			return 1;
		}
	}
	return 0;
}
static ShowPlayerAdsList()
{
	new
		buffer[4096],
		motd[200];
	format(buffer, 4096, "Tip\tKontakt\tTekst\tCijena\n");
	foreach(new i: Ad)
	{
	    if(AdsInfo[i][adSenderId] != 0)
		{
			format(motd, 200, ""COL_WHITE"%s\t%d\t%s\t"COL_GREEN"%d$\n",
				GetAdStyleString(AdsInfo[i][adStyle]),
				GetMobileNumberFromSQL(AdsInfo[i][adSenderId]),
				AdsInfo[i][adText],
				AdsInfo[i][adPrice]
			);
			strcat(buffer, motd, 4096);
		}
	}
	return buffer;
}

static GetPlayerAdsInput(playerid)
{
	new
		buffer[1024];
	if(PlayerAdsInfo[playerid][padStyle] == 0) {
		if(PlayerAdsInfo[playerid][padPrice] < 1) {
			format(buffer, sizeof(buffer), "[%s] %s (cijena PO DOGOVORU) | Kontakt: [%d]",
				GetAdStyleString(PlayerAdsInfo[playerid][padStyle]),
				PlayerAdsInfo[playerid][padText],
				PlayerMobile[playerid][pMobileNumber]
			);
		}
		else {
			format(buffer, sizeof(buffer), "[%s] %s (cijena %d$) | Kontakt: [%d]",
				GetAdStyleString(PlayerAdsInfo[playerid][padStyle]),
				PlayerAdsInfo[playerid][padText],
				PlayerAdsInfo[playerid][padPrice],
				PlayerMobile[playerid][pMobileNumber]
			);
		}
	} else {
			format(buffer, sizeof(buffer), "[%s] %s | Kontakt: [%d]",
				GetAdStyleString(PlayerAdsInfo[playerid][padStyle]),
				PlayerAdsInfo[playerid][padText],
				PlayerMobile[playerid][pMobileNumber]
			);
	}
	return buffer;
}

static SendAdMessage(index)
{
	new
		buffer[1024];
	
	if(AdsInfo[index][adStyle] == 0) {
		if(AdsInfo[index][adPrice] < 1) {
			format(buffer, sizeof(buffer), "[%s] %s (cijena PO DOGOVORU) | Kontakt: [%d]",
				GetAdStyleString(AdsInfo[index][adStyle]),
				AdsInfo[index][adText],
				GetMobileNumberFromSQL(AdsInfo[index][adSenderId])
			);
		} else {
			format(buffer, sizeof(buffer), "[%s] %s (cijena %d$) | Kontakt: [%d]",
				GetAdStyleString(AdsInfo[index][adStyle]),
				AdsInfo[index][adText],
				AdsInfo[index][adPrice],
				GetMobileNumberFromSQL(AdsInfo[index][adSenderId])
			);
		}
	} else {
		format(buffer, sizeof(buffer), "[%s] %s | Kontakt: [%d]",
			GetAdStyleString(AdsInfo[index][adStyle]),
			AdsInfo[index][adText],
			GetMobileNumberFromSQL(AdsInfo[index][adSenderId])
		);
	}
	
	return buffer;
}

static CreateAdForPlayer(playerid)
{			
	new 
		index = Iter_Free(Ad);
	if(index == -1) 
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Svi slotovi za oglase su popunjeni!");
	
	AdsInfo[index][adSenderId]				= PlayerInfo[playerid][pSQLID];
	AdsInfo[index][adStyle] 				= PlayerAdsInfo[playerid][padStyle];
	AdsInfo[index][adPrice]					= PlayerAdsInfo[playerid][padPrice];
	format(AdsInfo[index][adText], MAX_AD_TEXT, PlayerAdsInfo[playerid][padText]);
	AdsInfo[index][adTimes]					= PlayerAdsInfo[playerid][padTimes];
	AdsInfo[index][adTimeStamp] 			= gettimestamp();
	Iter_Add(Ad, index);
	
	new price = floatround(strlen(AdsInfo[index][adText]) * PRICE_PER_CHAR) * AdsInfo[index][adTimes];
	if(PlayerVIP[playerid][pDonateRank] > 0)
		price = 0;
	PlayerToFactionMoneyTAX( playerid, FACTION_TYPE_NEWS, price); // placanje oglasa novac u faction bank od LSNa
	va_GameTextForPlayer(playerid, "~r~Placeno za reklamu: $%d", 5000, 5, price);
	
	lastAdId = index;		
	va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Uspjesno ste postavili oglas. Trenutno je %i oglas/a za prikazivanje prije tvog.", index);
	
	SendAdminMessage(COLOR_RED, 
		"[AdTrace] - [%dx]: %s | %s", 
		AdsInfo[index][adTimes], 
		GetName(playerid, false), 
		AdsInfo[index][adText]
	);
	
	PlayerAdsInfo[playerid][padStyle] 		= -1;
	PlayerAdsInfo[playerid][padPrice]		= 0;
	PlayerAdsInfo[playerid][padText][0] 	= EOS;
	PlayerAdsInfo[playerid][padTimes] 		= 0;
	return 1;
}

task SendAutomaticAdMessage[1000]()
{
	new delad = -1;
	foreach(new i: Ad)
	{
		if(AdsInfo[i][adSenderId] != 0 && AdsInfo[i][adTimes] >= 1 && gettimestamp() >= AdsInfo[i][adTimeStamp] && gettimestamp() > (lastAdStamp + ADS_TIME_DELAY) && i > lastAdShown) 
		{
			va_SendClientMessageToAll(COLOR_GREEN, SendAdMessage(i));
			AdsInfo[i][adTimes]--;
			AdsInfo[i][adTimeStamp] = gettimestamp() + ( ADS_TIME_DURATION);
			lastAdStamp = gettimestamp();
			
			if(AdsInfo[i][adTimes] == 0) 
			{
				AdsInfo[i][adSenderId]	= 0;
				AdsInfo[i][adStyle] 	= -1;
				AdsInfo[i][adPrice]		= 0;
				AdsInfo[i][adText][0] = EOS;
				AdsInfo[i][adTimeStamp] = 0;
				AdsInfo[i][adTimes]		= 0;
				
				delad = i;
			}
			
			if(lastAdId == i)
				lastAdShown = -1;
			else
				lastAdShown = i;
			break;
		}
	}
	if(delad != -1)
		Iter_Remove(Ad, delad);
		
	return 1;
}

/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/

hook OnGameModeInit()
{
	Iter_Init(Ad);
	return 1;
}

hook function ResetPrivateVehicleInfo(vehicleid)
{
	if(VehicleInfo[vehicleid][vVehicleAdId] != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel( VehicleInfo[vehicleid][vVehicleAdId]);
		VehicleInfo[vehicleid][vVehicleAdId] = Text3D:INVALID_3DTEXT_ID;
	}
	return continue(vehicleid);
}

hook OnPlayerDisconnect(playerid, reason)
{
	LastAdsListIndex[playerid] = -1;
	
	PlayerAdsInfo[playerid][padStyle] 		= -1;
	PlayerAdsInfo[playerid][padPrice]		= 0;
	PlayerAdsInfo[playerid][padText][0] 	= EOS;
	PlayerAdsInfo[playerid][padTimes] 		= 0;
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case DIALOG_ADS_MENU: 
		{
			if(!response) return 1;
			
			switch(listitem) 
			{
				case 0:  {
				    if(PlayerGotAd(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate postavljen oglas.");
					ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
				}
				case 1: 
				{
					LastAdsListIndex[playerid] = 0;
					ShowPlayerDialog(playerid, DIALOG_ADS_WHOLE, DIALOG_STYLE_TABLIST_HEADERS, "LS OGLASNIK - Oglasi", ShowPlayerAdsList(), "Choose", "Abort");
					
					new
						string[64];
					format(string, sizeof(string), "* %s vadi mobitel i gleda oglase.", GetName(playerid, true));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				}
			}
			return 1;
		}
		case DIALOG_ADS_CREATE_STYLE: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_MENU, DIALOG_STYLE_LIST, "LS OGLASNIK", "Predaj oglas\nPregledaj oglase", "Choose", "Close");
			if(listitem == AD_STYLE_CMRC) {
				ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_CMRC, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst reklame", "Unesite tekst reklame:", "Commit", "Abort");
			}
			else if(listitem == AD_STYLE_BUY){
			    ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za kupovinu:", "Commit", "Abort");
				//ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_LIST, "LS OGLASNIK - Koliko cete puta prikazivati", "1\n2\n3\n4\n5", "Choose", "Abort");
			}
			else {
				ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_SELL, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za prodaju:", "Commit", "Abort");
			}
			PlayerAdsInfo[playerid][padStyle] = listitem;
			return 1;
		}
		case DIALOG_ADS_CREATE_BUY:{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
			if(10 <= strlen(inputtext) <= (MAX_AD_TEXT - 1)) {
				if(CheckStringForURL(inputtext) || CheckStringForIP(inputtext)) {
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedozvoljene rijeci/znakovi u oglasu!");
					new
						tmpString[128];
					format(tmpString, sizeof(tmpString), "AdmWarn: Igrac %s ID:[%d] je poslao ilegalan oglas. Sadrzaj: %s", GetName(playerid, false), playerid, inputtext);
					ABroadCast(COLOR_RED, tmpString, 1);
					ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za kupovinu:", "Commit", "Abort");
					return 1;
			 	}
 				format(PlayerAdsInfo[playerid][padText], MAX_AD_TEXT, inputtext);
		 		ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_TIMES, DIALOG_STYLE_LIST, "LS OGLASNIK - Koliko cete puta prikazivati", "1\n2\n3\n4\n5", "Choose", "Abort");
			} else {
				ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za kupovinu "COL_RED"(Min. 10, Max. 128 znak)"COL_WHITE":", "Commit", "Abort");
				return 1;
			}
		}
		case DIALOG_ADS_CREATE_SELL:{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
			if(10 <= strlen(inputtext) <= (MAX_AD_TEXT - 1)) {
				if(CheckStringForURL(inputtext) || CheckStringForIP(inputtext)) {
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedozvoljene rijeci/znakovi u oglasu!");
					new
						tmpString[128];
					format(tmpString, sizeof(tmpString), "AdmWarn: Igrac %s ID:[%d] je poslao ilegalan oglas. Sadrzaj: %s", GetName(playerid, false), playerid, inputtext);
					ABroadCast(COLOR_RED, tmpString, 1);
					ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za prodaju:", "Commit", "Abort");
					return 1;
			 	}
 				format(PlayerAdsInfo[playerid][padText], MAX_AD_TEXT, inputtext);
		 		ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_TIMES, DIALOG_STYLE_LIST, "LS OGLASNIK - Koliko cete puta prikazivati", "1\n2\n3\n4\n5", "Choose", "Abort");
			} else {
				ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_BUY, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite tekst oglasa za prodaju "COL_RED"(Min. 10, Max. 128 znak)"COL_WHITE":", "Commit", "Abort");
				return 1;
			}
		}
		case DIALOG_ADS_CREATE_CMRC: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
			if(10 <= strlen(inputtext) <= (MAX_AD_TEXT - 1)) {
				if(CheckStringForURL(inputtext) || CheckStringForIP(inputtext)) {
					SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nedozvoljene rijeci/znakovi u oglasu!");
					new
						tmpString[128];
					format(tmpString, sizeof(tmpString), "AdmWarn: Igrac %s ID:[%d] je poslao ilegalan oglas. Sadrzaj: %s", GetName(playerid, false), playerid, inputtext);
					ABroadCast(COLOR_RED, tmpString, 1);
					
					if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_CMRC) ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_CMRC, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst reklame", "Unesite tekst reklame "COL_RED"(Min. 10, Max. 128 znak)"COL_WHITE":", "Commit", "Abort");
					else ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_CMRC, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst reklame", "Unesite dodatni tekst reklame (naziv predmeta ili adresu kuce/biznisa)"COL_RED"[Min. 10, Max. 128 znakova]"COL_WHITE":", "Commit", "Abort");
					return 1;
				}
				
				format(PlayerAdsInfo[playerid][padText], MAX_AD_TEXT, inputtext);
		 		ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_TIMES, DIALOG_STYLE_LIST, "LS OGLASNIK - Koliko cete puta prikazivati", "1\n2\n3\n4\n5", "Choose", "Abort");
			} else {
				if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_CMRC) ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_CMRC, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst reklame", "Unesite tekst reklame "COL_RED"(Min. 10, Max. 128 znak)"COL_WHITE":", "Commit", "Abort");
				else ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_CMRC, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst reklame", "Unesite dodatni tekst reklame (naziv predmeta ili adresu kuce/biznisa)"COL_RED"[Min. 10, Max. 128 znakova]"COL_WHITE":", "Commit", "Abort");
				return 1;
			}
			return 1;
		}
		case DIALOG_ADS_CREATE_TIMES: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
   			PlayerAdsInfo[playerid][padTimes] = listitem + 1;
			if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_BUY)
				va_ShowPlayerDialog(playerid, DIALOG_ADS_FINISH, DIALOG_STYLE_MSGBOX, "LS OGLASNIK - Zavrsetak", ""COL_WHITE"Zelite li predati oglas?\n"COL_GREEN"%s\n"COL_WHITE"On ce se prikazivati "COL_ORANGE"%d "COL_WHITE"puta.", "Commit", "Abort", GetPlayerAdsInput(playerid), PlayerAdsInfo[playerid][padTimes]);
			else if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_SELL)
				ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_PRICE, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite cijenu za prodaju oglasa:", "Commit", "Abort");
			else if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_CMRC)
				va_ShowPlayerDialog(playerid, DIALOG_ADS_FINISH, DIALOG_STYLE_MSGBOX, "LS OGLASNIK - Zavrsetak", ""COL_WHITE"Zelite li predati oglas?\n"COL_GREEN"%s\n"COL_WHITE"On ce se prikazivati "COL_ORANGE"%d "COL_WHITE"puta.", "Commit", "Abort", GetPlayerAdsInput(playerid), PlayerAdsInfo[playerid][padTimes]);
			return 1;
		}
		case DIALOG_ADS_CREATE_PRICE:{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");
			if(isnull(inputtext))
			{
			    if(PlayerAdsInfo[playerid][padStyle] == AD_STYLE_BUY)
			        ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_PRICE, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite cijenu za kupovinu oglasa:", "Commit", "Abort");
				else
					ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_PRICE, DIALOG_STYLE_INPUT, "LS OGLASNIK - Tekst oglasa", "Unesite cijenu za prodaju oglasa:", "Commit", "Abort");
			}
			PlayerAdsInfo[playerid][padPrice] = strval(inputtext);
			va_ShowPlayerDialog(playerid, DIALOG_ADS_FINISH, DIALOG_STYLE_MSGBOX, "LS OGLASNIK - Zavrsetak", ""COL_WHITE"Zelite li predati oglas?\n"COL_GREEN"%s\n"COL_WHITE"On ce se prikazivati "COL_ORANGE"%d "COL_WHITE"puta.", "Commit", "Abort", GetPlayerAdsInput(playerid), PlayerAdsInfo[playerid][padTimes]);
			return 1;
		}
		case DIALOG_ADS_FINISH: 
		{
			if(!response) 
				return ShowPlayerDialog(playerid, DIALOG_ADS_CREATE_STYLE, DIALOG_STYLE_LIST, "LS OGLASNIK - Stil oglasa", "Prodaja\nKupovina\nReklama", "Choose", "Abort");

			new price = strlen(PlayerAdsInfo[playerid][padText]) * PRICE_PER_CHAR * PlayerAdsInfo[playerid][padTimes];
			if(PlayerVIP[playerid][pDonateRank] > 0)
				price = 0;
			else
				if(price > AC_GetPlayerMoney(playerid)) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "[GRESKA] Nemate dovoljno novaca za platiti oglas. Cijena oglasa je %d$.", price);
			
			CreateAdForPlayer(playerid);
			return 1;
		}
		case DIALOG_ADS_WHOLE: {
			if(!response) return ShowPlayerDialog(playerid, DIALOG_ADS_MENU, DIALOG_STYLE_LIST, "LS OGLASNIK", "Predaj oglas\nPregledaj oglase", "Choose", "Close");
			return 1;
		}
	}
	return 0;
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
CMD:ad(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_ADS_MENU, DIALOG_STYLE_LIST, "LS OGLASNIK", "Predaj oglas\nPregledaj oglase", "Choose", "Close");
	return 1;
}

CMD:carad(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate biti u vozilu!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(PlayerKeys[playerid][pVehicleKey] > -1 && PlayerKeys[playerid][pVehicleKey] != vehicleid) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Morate imati spawnati CO i morate biti u njemu!");
	new pick[8];
	if(sscanf(params, "s[8] ", pick)) return SendClientMessage(playerid, COLOR_RED, "[?]: /carad [set/delete]");
	if(!strcmp(pick, "set", true))
	{
		new text[64], partOne[22], partTwo[22], partThree[22];
		if(sscanf(params, "s[8]s[64]", pick, text)) return SendClientMessage(playerid, COLOR_RED, "[?]: /carad set [text (64 znaka max)]");
		new money = strlen(text) * 6;
		if(AC_GetPlayerMoney(playerid) < money) return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate dovoljno novaca za postavljanje oglasa (%d$)", money);
		if(VehicleInfo[vehicleid][vVehicleAdId] != Text3D:INVALID_3DTEXT_ID)  return va_SendMessage(playerid, MESSAGE_TYPE_ERROR, "[GRESKA] Vec postoji oglas na vasem vozilu! Prvo korisite /carad delete");
		strmid(partOne, text, 0, 21);
		strmid(partTwo, text, 22, 43);
		strmid(partThree, text, 44, strlen(text));
		new tmpString[64];
		format(tmpString, sizeof(tmpString), "%s\n%s\n%s", partOne, partTwo, partThree);
		VehicleInfo[vehicleid][vVehicleAdId] = CreateDynamic3DTextLabel(text, COLOR_WHITE, 0.9697, -1.7760, 0.0680, 4.0, INVALID_PLAYER_ID, vehicleid, 1, -1, -1, -1, 4.0);
		
		va_SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Postavili ste oglas na vozilo i platili %d$", money);
		PlayerToFactionMoneyTAX( playerid, FACTION_TYPE_NEWS, money); // placanje oglasa novac u faction bank od LSNa
	}
	else if(!strcmp(pick, "delete", true))
	{
		if(VehicleInfo[vehicleid][vVehicleAdId] != Text3D:INVALID_3DTEXT_ID)
		{
			DestroyDynamic3DTextLabel( VehicleInfo[vehicleid][vVehicleAdId]);
			VehicleInfo[vehicleid][vVehicleAdId] = Text3D:INVALID_3DTEXT_ID;
		}
		SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Obrisali ste oglas sa svoga vozila!");
	}
	return 1;
}
