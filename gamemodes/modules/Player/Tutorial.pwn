#include <YSI_Coding\y_hooks>

/*
	##     ##    ###    ########   ######  
	##     ##   ## ##   ##     ## ##    ## 
	##     ##  ##   ##  ##     ## ##       
	##     ## ##     ## ########   ######  
	 ##   ##  ######### ##   ##         ## 
	  ## ##   ##     ## ##    ##  ##    ## 
	   ###    ##     ## ##     ##  ######  
*/
new
	TutorialStep[MAX_PLAYERS],
	Timer: TutTimer[MAX_PLAYERS];


/*
	######## ##     ## ##    ## ##    ##  ######  ####       ## ######## 
	##       ##     ## ###   ## ##   ##  ##    ##  ##        ## ##       
	##       ##     ## ####  ## ##  ##   ##        ##        ## ##       
	######   ##     ## ## ## ## #####    ##        ##        ## ######   
	##       ##     ## ##  #### ##  ##   ##        ##  ##    ## ##       
	##       ##     ## ##   ### ##   ##  ##    ##  ##  ##    ## ##       
	##        #######  ##    ## ##    ##  ######  ####  ######  ######## 
*/

ClearChatBox(playerid)
{
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
	SendClientMessage(playerid, -1, "\n");
}

SendPlayerOnFirstTimeTutorial(playerid, step)
{
	if(!Bit1_Get(gr_PlayerOnTutorial, playerid))
	{
		Bit1_Set( gr_PlayerOnTutorial, playerid, true);
		OnPlayerFirstTimeEnter(playerid, step);
	}
}

/*
	######## #### ##     ## ######## ########   ######  
	   ##     ##  ###   ### ##       ##     ## ##    ## 
	   ##     ##  #### #### ##       ##     ## ##       
	   ##     ##  ## ### ## ######   ########   ######  
	   ##     ##  ##     ## ##       ##   ##         ## 
	   ##     ##  ##     ## ##       ##    ##  ##    ## 
	   ##    #### ##     ## ######## ##     ##  ######  
*/

timer OnPlayerFirstTimeEnter[12000](playerid, step) 
{ 
	switch(step) {
		case 1: {
			stop TutTimer[playerid];
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			va_SendClientMessage(playerid, COLOR_GREY, "Dobrodosli na %s server!", SERVER_NAME); 
			SendClientMessage(playerid, COLOR_GREY, "Nadamo se da ces igrati sa uzitkom i roleplayati bez ikakvih smetnji."); 
			va_SendClientMessage(playerid, COLOR_GREY, "Ovo je kraci tutorial %s Servera.", SERVER_NAME);
			SendClientMessage(playerid, COLOR_GREY, "Ovim putem cete na brzinu saznati nesto o serveru, lokacijama na mapi i jos o necemu.");
			va_SendClientMessage(playerid, COLOR_GREY, "Greetings from %s Administrator Team!", SERVER_NAME);
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		} 
		case 2: { 
			stop TutTimer[playerid];
			ClearChatBox(playerid); 
			TutorialStep[playerid] = step;
            new TutYear, TutMonth, TutDay;
			getdate(TutYear, TutMonth, TutDay);
			va_SendClientMessage(playerid, COLOR_GREY, "Prije svega trebate znati da se na serveru RPa %d godina.", TutYear);
			SendClientMessage(playerid, COLOR_GREY, "Tehnologija na serveru prati onu istu iz stvarnoga zivota tako da imate relativno velik raspon mogucnosti u roleplayu.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		} 
		case 3: {
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		1504.6589, -1678.3022, 36.9156, 1504.6589, -1678.3022, 36.9156, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	1505.6600, -1678.3047, 36.5906, 1505.6600, -1678.3047, 36.5906, 10000, CAMERA_MOVE);

			ClearChatBox(playerid); 
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Na serveru postoji jedna law organizacija a to je upravo Los Santos Police Department.");
			SendClientMessage(playerid, COLOR_GREY, "Zgrada se nalazi u samom centru grada, na podrucju Pershing Squarea.");
			SendClientMessage(playerid, COLOR_GREY, "Pripadnike ove organizacije cete redovno gledati na serveru a i sami se mozete prijaviti za istu preko naseg foruma:");
			va_SendClientMessage(playerid, COLOR_GREY, "%s", WEB_URL);
			TutTimer[playerid] =defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 4: {
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		1469.6799, -1723.6831, 17.2949, 1469.6799, -1723.6831, 17.2949, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	1469.8987, -1724.6602, 17.3499, 1469.8987, -1724.6602, 17.3499, 10000, CAMERA_MOVE);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Opstina/Vijecnica je mjesto gdje se zaposljavate, dizete platu i eventualno glasate za svog kandidata kad je vrijeme izbora.");
			SendClientMessage(playerid, COLOR_GREY, "Nalazi se nedaleko od zgrade LSPDa, takodjer na Pershing Squareu.");
			SendClientMessage(playerid, COLOR_GREY, "Unutra mozete koristiti komandu /takejob kako bi se zaposlili te takodje mozete koristiti /payout");
			SendClientMessage(playerid, COLOR_GREY, "kako bi podigli platu koja je stigla na vas racun nakon sto ste odradili svoj posao.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		} 
		case 5: {
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		2076.3655, -1806.9199, 15.6703, 2076.3655, -1806.9199, 15.6703, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	2077.3665, -1806.9343, 15.6753, 2077.3665, -1806.9343, 15.6753, 10000, CAMERA_MOVE);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Idlewood je jedan od prometnijih djelova Los Santosa, samim time i centar roleplaya.");
			SendClientMessage(playerid, COLOR_GREY, "U Idlewoodu mozete naici cesto na okupljene igrace, da budemo precizniji, na parkingu Pizza stacka.");
			SendClientMessage(playerid, COLOR_GREY, "Tamo mozete naci partnera u svom RPu ali isto tako i sami sebi mozete stvoriti isti s obzirom da su u blizini");
			SendClientMessage(playerid, COLOR_GREY, "nekoliki marketa, frizerski salon i naravno pizzeria ali i mnostvo drugih mogucnosti.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 6: {
			stop TutTimer[playerid];
			SetPlayerCameraPos(playerid, 543.1867, -1232.8118, 39.8129);
			SetPlayerCameraLookAt(playerid, 543.1999, -1233.8103, 39.3828);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Ovo je dealership u kojem mozete birati vozilo po zelji. Naravno, jaca i brza vozila su skuplja dok su ona starija jeftina.");
			SendClientMessage(playerid, COLOR_GREY, "Cijene vozila su optimizirane sa nasim platama, tako da cete se morati potruditi kako bi zaradili pare za neko skuplje vozilo.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 7: {
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		2245.3982, -1221.8511, 39.6657, 2245.3982, -1221.8511, 39.6657, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	2246.2612, -1222.3558, 39.3557, 2246.2612, -1222.3558, 39.3557, 10000, CAMERA_MOVE);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Ovdje mozete da sjednete i da se prebacite javnim prevozom u drugi grad ili jednostavno udaljeniji dio istog grada.");
			SendClientMessage(playerid, COLOR_GREY, "Naravno, ovo je ekonomican sistem ukoliko zelite da ustedite pare sto se tice goriva i potrosnje vaseg vozila.");
			SendClientMessage(playerid, COLOR_GREY, "Gradski prevoz moze da vam bude kljucan u nekim slucajevima.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 8: { //KAMERA SE PREBACUJE NA VERONA MALL
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		1126.1462, -1393.0825, 16.2678, 1126.1462, -1393.0825, 16.2678, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	1126.1935, -1394.0809, 16.2729, 1126.1935, -1394.0809, 16.2729, 10000, CAMERA_MOVE);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Ovdje mozete pronaci raznovrsnu ponudu odjece za vaseg karaktera.");
			SendClientMessage(playerid, COLOR_GREY, "Od satova, naocala do kapa, sesira, stapova za pecanje i slicno, uredite vaseg lika kako zelite.");
			SendClientMessage(playerid, COLOR_GREY, "U Mallu mozete takodje naci i 24/7 prodavnicu, prodavnicu sa hranom, sportsku radnju i slicno.");
			SendClientMessage(playerid, COLOR_GREY, "Ukratko, skoro sve sto vam treba na jednom mjestu.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 9: {
			stop TutTimer[playerid];
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Sitnica koju mi trazimo od vas je da postujete odredjena pravila. A neka od tih pravila su slijedeca:");
			SendClientMessage(playerid, COLOR_GREY, "Deathmatch(DM), Powergaming(PG), Metagaming(MG),");
			SendClientMessage(playerid, COLOR_GREY, "Revenge Kill(RK), RP2WIN, takodjer probajte sto manje koristiti komandu /b. Za vrijeme RPa je nemojte uopce koristiti.");
			SendClientMessage(playerid, COLOR_GREY, "Da vidite definicije ovih pravila koristite komandu /rphelp!");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 10: {//KAMERA PRIKAZUJE CIJELI LOS SANTOS
			stop TutTimer[playerid];
			InterpolateCameraPos(playerid, 		1989.7639, -1784.5078, 65.5361, 1989.7639, -1784.5078, 65.5361, 10000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 	1990.7200, -1784.2158, 65.2812, 1990.7200, -1784.2158, 65.2812, 10000, CAMERA_MOVE);
			
			ClearChatBox(playerid);
			TutorialStep[playerid] = step;
			SendClientMessage(playerid, COLOR_GREY, "Ovo je bio kraci tutorial u kojem ste, nadamo se, naucili nesto novo o nasem serveru.");
			va_SendClientMessage(playerid, COLOR_GREY, "For more informations, please visit %s", WEB_URL);
			SendClientMessage(playerid, COLOR_GREY, "Ukoliko trazite neki tutorial najvjerovatnije je da cete ga pronaci u Pravila i Upute > Sluzbeni tutorijali i upute.");
			TutTimer[playerid] = defer OnPlayerFirstTimeEnter(playerid, step + 1);
		}
		case 11:
		 { 
			stop TutTimer[playerid];
			PlayerNewUser_Set(playerid, false);
			Bit1_Set( gr_PlayerOnTutorial, playerid, false);
			ClearChatBox(playerid);

			AC_GivePlayerMoney(playerid, 			NEW_PLAYER_MONEY);
			PlayerInfo[playerid][pBank] 			= NEW_PLAYER_BANK; 
			PlayerInfo[playerid][pRegistered] 		= 1;
			PlayerInfo[playerid][pLevel] 			= 1;
			PlayerAppearance[playerid][pTmpSkin] 	= 29;
			PlayerAppearance[playerid][pSkin] 		= 29;
			PaydayInfo[playerid][pPayDayMoney] 		= 0;
			PlayerJob[playerid][pFreeWorks] 		= 15;
			PlayerInfo[playerid][pMuted] 			= false;
			PlayerInfo[playerid][pAdmin] 			= 0;
			PlayerInfo[playerid][pHelper] 			= 0; 
			PlayerCoolDown[playerid][pCasinoCool]	= 5;
			
			SendClientMessage(playerid, COLOR_SAMP_GREEN, "[HINT]: Ukoliko trebate prijevoz koristite /calltaxi!");
			
			SendAdminMessage(COLOR_RED, 
				"AdmWarn: %s[%d] has just registered on server! IP: %s", 
				GetName(playerid,false), 
				playerid, 
				ReturnPlayerIP(playerid)
			);
			
			ClearChatBox(playerid); 
			SetPlayerVirtualWorld(playerid, 0); 
			SetPlayerInterior(playerid, 0); 
			SetCameraBehindPlayer(playerid);
			SetSpawnInfo(playerid, 0, PlayerAppearance[playerid][pSkin], SPAWN_X, SPAWN_Y, SPAWN_Z, 0, 0, 0, 0, 0, 0, 0);
			Player_SetSafeSpawned(playerid, true);
			SpawnPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
			TutorialStep[playerid] = 0;

			SavePlayerData(playerid);
		} 
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	stop TutTimer[playerid];
	TutorialStep[playerid] = 0;
	return 1;
}