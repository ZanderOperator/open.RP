#include <YSI_Coding\y_hooks>

#define MAXLEN  (77)

//FORWARDS
forward PublishAdvertisment( playerid ) ;
forward RemoveToken( playerid ) ;
forward MinusSecond( playerid ) ;

//ENUMS
enum aData {
    ID ,
	Text[ 255 ] ,
	Text2[ 255 ] ,
	Tokens ,
	AdLength,
	TokenTimer

} ;
new AdData[ MAX_PLAYERS ][ aData ] ;

//THE CODE ITSELF
new adqueue = 0 ;
new adstatus = 1 ;

new adtime[MAX_PLAYERS];
new adtimer[MAX_PLAYERS];

public PublishAdvertisment( playerid ){
	if( AdData[ playerid ][ AdLength ] == 2 ){
        SendClientMessageToAll( COLOR_GREEN, AdData[ playerid ][ Text ] ) ;
        SendClientMessageToAll( COLOR_GREEN, AdData[ playerid ][ Text2 ] ) ;
	}else{
		SendClientMessageToAll( COLOR_GREEN, AdData[ playerid ][ Text ] ) ;
	}

	for(new a = 0; a < MAX_PLAYERS; a++){
		if(AdData[ a ][ ID ] > AdData[ playerid ][ ID ] && a != playerid){
            AdData[ a ][ ID ] -= 1 ;
        }
	}

	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno imas %d ad tokena. Koristi komandu /adcost za vise informacija!", AdData[playerid][Tokens]);
	if( Bit1_Get( a_AdNot, playerid ) ) {
		new msg[77];
		format( msg,sizeof( msg ), "AdmCmd: %s je upravo objavio oglas!", GetName( playerid, false ) ) ;
		SendAdminMessage( COLOR_LIGHTRED, msg ) ;
	}
	format( AdData [ playerid ] [ Text ], 255, "None" ) ;
	format( AdData [ playerid ] [ Text2 ], 255, "None" ) ;
	AdData[ playerid ][ TokenTimer ] = SetTimerEx( "RemoveToken", 300000, 1, "d", playerid ) ;
	AdData[ playerid ][ ID ] = 0 ;
	AdData[ playerid ][ AdLength ] = 0 ;
	adqueue -= 1 ;
	return 1 ;
}

public RemoveToken( playerid ){
	if( AdData[ playerid ][ Tokens ] > 1){
	    AdData[ playerid ][ Tokens ] -= 1 ;
	}else if( AdData[ playerid ][ Tokens ] == 1 ){
        AdData[ playerid ][ Tokens ] -= 1 ;
		KillTimer( AdData[ playerid ][ TokenTimer ] );
	}
	return 1 ;
}

public MinusSecond( playerid ){
	if(adtime[ playerid ] >= 2){
	    adtime[ playerid ] -= 1 ;
	    adtimer[ playerid ] = SetTimerEx( "MinusSecond", 1000, 0, "d", playerid ) ;
	}else{
	    adtime[ playerid ] = 0 ;
	    KillTimer( adtimer[ playerid ] ) ;
	}
	return 1 ;
}

CMD:adqstatus( playerid, params[ ] ){
    if (PlayerInfo[playerid][pAdmin] < 4)
		return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste ovlasteni za koristenje ove komande!");
	new msg[77];
	if( adstatus == 1 ){
		adstatus = 0;
        format( msg,sizeof( msg ), "AdmCmd: %s je iskljucio oglase!", GetName( playerid ) ) ;
		SendAdminMessage( COLOR_LIGHTRED, msg ) ;
	}else if( adstatus == 0 ){
		adstatus = 1;
        format( msg,sizeof( msg ), "AdmCmd: %s je ukljucio oglase!", GetName( playerid ) ) ;
		SendAdminMessage( COLOR_LIGHTRED, msg ) ;
	}
	return 1;
}

CMD:ad( playerid, params[] ){
	new cost, timertime;
	if( isnull( params ) ) return SendClientMessage( playerid, COLOR_WHITE, "{FA5656}[ ! ] (/ad) [text]" ) ;
 	if(!PlayerInfo[playerid][pMobileNumber]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete mobitel!");
	if( AC_GetPlayerMoney( playerid ) < cost ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novaca(%d$) za objavljivanje oglasa!", cost);
	if( adstatus == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Oglasi su trenutno iskljuceni od strane Game Admina.");
	if( AdData[ playerid ][ ID ] != 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate jedan oglas na cekanju. Kucajte /adqueue za provjeru oglasa.");

	if( strlen( params ) > MAXLEN )
	{
  		new pos = MAXLEN ;
		if(pos < MAXLEN-1) pos = MAXLEN ;
		AdData[ playerid ][ AdLength ] = 2;
		format( AdData [ playerid ] [ Text ],  255, "[Oglas] %.*s ...", pos, params ) ;
		format( AdData [ playerid ] [ Text2 ], 255, "[Oglas] ... %s, Kontakt:[%d]", params[ pos ], PlayerInfo[playerid][pMobileNumber] ) ;
		adqueue += 1 ;
	}
	else
	{
        adqueue += 1 ;
		format( AdData [ playerid ] [ Text ], 255, "[Oglas] %s, Kontakt:[%d]", params, PlayerInfo[playerid][pMobileNumber] ) ;
	}

	if( adqueue == 0 ){
	    timertime = 30000;
	}else{
	    timertime = adqueue * 30000 ;
	}

	if( AdData[ playerid ][ Tokens ] >= 1){
	    cost = (AdData[ playerid ][ Tokens ] * 100) + 500 ;
	}else{
		cost = 700;
	}
	PlayerToBudgetMoney( playerid, cost ) ;
	AdData [ playerid ][ ID ] = adqueue;
	AdData [ playerid ][ Tokens ] += 1;
	adtime[ playerid ] = AdData[ playerid ][ ID ] * 30;
	SetTimerEx( "PublishAdvertisment", timertime, 0, "d", playerid ) ;
	adtimer[ playerid ] = SetTimerEx( "MinusSecond", 1000, 0, "d", playerid ) ;
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Oglas je uspjesno postavljen na cekanje.Koristite komandu /adqueue kako bi provjerili informacije i status vaseg oglasa.");
	return 1;
}

CMD:cad( playerid, params[] ){
	new cost, timertime;
	if( isnull( params ) ) return SendClientMessage( playerid, COLOR_WHITE, "{FA5656}[ ! ]: /cad [text]" ) ;
 	if(!PlayerInfo[playerid][pMobileNumber]) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ne posjedujete mobitel!");
	if( AC_GetPlayerMoney( playerid ) < cost ) return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, "Nemas dovoljno novaca(%d$) za objavljivanje oglasa!", cost);
	if( adstatus == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Oglasi su trenutno iskljuceni od strane Game Admina.");
	if( AdData[ playerid ][ ID ] != 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Vec imate jedan oglas na cekanju. Kucajte /adqueue za provjeru oglasa.");
	if( adqueue == 0 ){
	    timertime = 30000;
	}else{
	    timertime = adqueue * 30000 ;
	}

	if( AdData[ playerid ][ Tokens ] >= 1){
	    cost = (AdData[ playerid ][ Tokens ] * 100) + 500 ;
	}else{
		cost = 700;
	}

	if( strlen( params ) > MAXLEN )
	{
		new pos = MAXLEN ;
		if(pos < MAXLEN-1) pos = MAXLEN ;
		AdData[ playerid ][ AdLength ] = 2;
		format( AdData [ playerid ] [ Text ],  255, "[Biznis] %.*s ...", pos, params ) ;
		format( AdData [ playerid ] [ Text2 ], 255, "[Biznis oglas] ... %s", params[ pos ] ) ;
		SetTimerEx( "PublishAdvertisment", timertime, 0, "d", playerid ) ;
	}
	else
	{
		format( AdData [ playerid ] [ Text ], 255, "[Biznis oglas] %s", params ) ;
		SetTimerEx( "PublishAdvertisment", timertime, 0, "d", playerid ) ;
	}
	PlayerToBudgetMoney( playerid, cost ) ;
	adqueue += 1 ;
	AdData [ playerid ][ ID ] = adqueue;
	AdData [ playerid ][ Tokens ] += 1;
	adtime[ playerid ] = AdData[ playerid ][ ID ] * 30;
	adtimer[ playerid ] = SetTimerEx( "MinusSecond", 1000, 0, "d", playerid ) ;
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Oglas je uspjesno postavljen na cekanje.Koristite komandu /adqueue kako bi provjerili informacije i status vaseg oglasa.");
	return 1;
}

CMD:adcost( playerid, params[] ){
	new nextcost ;
	nextcost = (AdData[ playerid ][ Tokens ] * 250) + 1000 ;
	if( AdData[ playerid ][ Tokens ] == 0 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Trenutno nemate dovoljno tokena!");
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Trenutno imas %d tokena za oglase. Sljedeci oglas ce vas kostati %d$", AdData[playerid][Tokens], nextcost);
	return 1 ;
}

CMD:adqueue( playerid, params[] ){
	if( adtime[ playerid ] == 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate oglasa na cekanju!");
	SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Tvoj oglas ce biti objavljen kroz %d sekundi. Trenutno imamo %d oglasa na cekanju. Tvoj broj u nizu je #%d", adtime[playerid], adqueue, AdData[playerid][ID]);
	return 1 ;
}

