#include <YSI\y_hooks>
// Help module by broox. & wizzcyco for City of Angels

CMD:animations(playerid,params[])
{
	new
    anims[2048] = "";
    new anims1[256];
    format(anims1,sizeof(anims1), "/dance[1-4], /handsup, /lean [1-3], /injured [1-2], /sit [1-6], /stand [1-14], /drunk, /crack [1-2], /cpr, /hide, /chill \n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/rap [1-3], /wank [1-2], /strip [1-7], /bj [1-4], /cellin, /cellout, /piss, /follow, /greet, /hitch, /carry [1-8]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/bitchslap, /gsign [1-5], /gift [1-2], /getup, /slapped, /slapass, /celebrate [1-2], /win [1-2], /yes, /deal [1-2]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/invite[1-2], /thankyou, /scratch, /bombplant, /getarrested, /laugh, /lookout, /robman, /crossarms[1-3]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/lay [1-4], /vomit, /eatanim [1-7], /wave, /smoke [1-2], /chat, /fucku, /taichi, /relax, /bat [1-5], /nod, /cry [1-2]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/chant, /carsmoke, /aim [1-6], /gang [1-7], /bed [1-4], /stretch, /angry, /kiss [1-7], /exhausted, /ghand [1-5]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/basket [1-6], /akick, /box, /cockgun, /bar [1-4], /liftup, /putdown, /dead [1-2], /joint, /benddown, /checkout\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/face [1-8], /scared, /fall [1-4], /think, /shot[1-5], /gas, /asex [1-8], /spin [1-2], /ring, /crawl, /what [1-2]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/hide, /chill [1-3], /scared [1-7], /roll [1-4], /gunkick, /reload [1-7], /riot [1-7], /deejay [1-6], /cop [1-18]\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/console [1-3], /dancer [1-13], /parkour [1-3], /beach [1-18], /bombs [1-7], /camera [1-12], /fixcar [1-2], /dropflag\n");
    strcat(anims,anims1, sizeof(anims));
    format(anims1,sizeof(anims1), "/caranim [1-18], /casinoanim [1-24], /clothesanim [1-13], /dodge, /walk [1-15], /fwalk [1-7], /gym [1-29], /no [1-3]");
    strcat(anims,anims1, sizeof(anims));
	
	ShowPlayerDialog(playerid, 7331, DIALOG_STYLE_MSGBOX, "ANIMACIJE", anims, "Zatvori", "");
	return 1;


}

CMD:help(playerid,params[])
{
	ShowPlayerDialog(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,"POMOC","1.Account \n2.Vozilo \n3.Organizacije \n4.Biznis \n5.Novac \n6.Muzika \n7.Objekti \n8.Death System \n9.Droga \n10.Hunger \n11.Hobi \n12.License \n13.Mobitel \n14.Skills \n15.Oruzje \n16.Chat \n17.Poslovi \n18.Garaze \n19.Complexi \n20.House&Furniture\n21.Roleplay\n22.Kasino \n23.Ostalo","Zatvori","");
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext [])
{
	switch(dialogid)
	{
		case DIALOG_HELP:
		{
			if(!response)
				return 1;

			if(response)
			{
				switch(listitem)
				{
					case 0: ShowPlayerDialog(playerid, DIALOG_HELPACC, DIALOG_STYLE_MSGBOX, "Account", "/stats\n/levelup\n/changename\n/setlook\n/showme\n/pay\n/setwalk\n/spawnchange\n/account\n/resetcp\n/id\n/kill\n/inventory", "Ok", "Saznaj vise");
					case 1: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Vozilo", "/gps\n/car\n/fillcar\n/get fuel\n/tow\n/oldcar\n/doors\n/windows\n/trunk\n/seatbelt\n/showcostats\n/duplicatekey\n/tuning\n/bonnet\n/eject", "Ok", "");
					case 2: 
					{
						if(PlayerInfo[playerid][pMember] == 0)
							return SendClientMessage(playerid,COLOR_RED, "ERROR: Niste clan ni jedne legalne organizacije!");
						else
						{
							if(IsACop(playerid))
								ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "PD", "/status/checkseatbelt/tazer/arrest/cuff/uncuff/unfree/pdtrunk/pdramp/onduty/lawskin\n\
									 /pd1/m/pd2/siren/codes/pdlif/suspend/flares/deflares/impund/checktrunk/listensms\n\
									 /cleartrunk\n/udercover\n/listennumber/checkhouse/housetake/cargun/mdc/apb/erb/rb/rrb/removeall\n\
									 /putspike/removespike/ticket/giveticket/siren/afaction/faction/quitfaction/showbadge/r\n\
									 /rlow/f/togf/carsign/bk/bkc/bkall", "Ok", "");
							else if(IsFDMember(playerid))
								ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "FD", "/enablesiren/equipment/oxygen/createexplosion/fdcarenter/fdenter/rtcfdcars/fdlift/recover/stretcher/selldrug/treatment\n\
									 /confirmation\n/fire\n/f\n/togf\n/bk\n/bkc\n/bkall\n/carsign\n/siren\n/faction\n/quitfaction\n/showcreditation", "Ok", "");
							else if(IsAGov(playerid))
								ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "GOV", "/showbadge\n/govskin\n/heal\n/m\n/cuff\n/uncuff\n/vote\n/votes\n/setcity\n/city\n/govmdc\n/charity\n/finance\n/faction\n/r\n/rlow\n/f\n/togf\n/gov\n/govramp\n/carsign\n/siren\n/quitfaction ", "Ok", "");
							else if(IsANews(playerid))
								ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "LSN", "/lsncamera\n/live\n/news\n/lsnstat\n/lsnup\n/lsndown\n/reset_news\n/callnews\n/faction\n/faction members\n/quitfaction ", "Ok", "");
						}
					}
					case 3: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Biznis", "/createvip\n/biznis\n/menu\n/bmusic\n/buybiznis\n/buy\n/makedj\n/bizinfo\n/bizbank\n/bizwithdraw\n/biznis_bint\n/biznis_furniture", "Ok", "");
					case 4: ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_MSGBOX, "ATM/BANKA", "/atm\n/bank\n/payout(City Hall)", "Ok", "");
					case 5: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Music", "/music", "Ok", "");
					case 6: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Objekti", "/createobject\n/editobject\n/deleteobject\n/objects (buy,attach,detach,changebone,edit)", "Ok", "");
					case 7: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Death system", "/pickitem(money,weapon,drug)\n/alldamages", "Ok", "");
					case 8: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Drugs", "/drug\n", "Ok", "");
					case 9: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Hunger", "/order\n/menu\n/meal", "Ok", "");
					case 10: ShowPlayerDialog(playerid, DIALOG_HOBI, DIALOG_STYLE_MSGBOX, "Hobi", "RIBOLOVAC:\t\n/buybait\n/fish\n/sellfish\n/fish_inventory\n\nLOVAC:\n/usewhistle\n/cutdeer\n/buywhistle\n/sellmeat\n/checkmeat", "Ok", "Saznaj vise");					case 11: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "License", "/license(DMV centar)\n/licenses\n/showlicenses\n/sid(osobna)", "Ok", "");
					case 12: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Mobitel", "/togphone\n/ph\n/phone\n/call\n/sms\n/pcall\n/hangup\n/cryptotext\n/cryptonumber\n/phonebook", "Ok", "");
					case 13: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Skills", "/skills", "Ok", "");
					case 14: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Weapon", "/weapon\n/buygun\n/weapon hide", "Ok", "");
					case 15: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Chats", "/me\n/do\n/ame\n/c(lose)\n/s(hout)\n/carwhisper\n/w(hisper)\n/b\n/blockb\n/pm\n/blockpm\n/accent\n/mic\n/clearmychat\n/attempt", "Ok", "");
					case 16: ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_LIST, "Poslovi", "Kosac trave\nTvornicki radnik\nCistac ulice\nSmecar\nTrucker\nDrvosjeca\nMehanicar\nPizza Boy\nFarmer\nTaksista\nGun dealer\nDrug dealer\nIllegal trucker\nCar jacker\nLopov\nPilot", "Odaberi","Natrag");
					case 17: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Garage", "/garage\n/genter", "Ok", "");
					case 18: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Complex", "/buycomplex\n/complex\n/rentroom\n/unrentroom", "Ok", "");
					case 19: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "House&Furniture", "/house\n/bint\n/buyhouse\n/ring\n/knock\n/doorshout\n/picklock\n/doorram\n/renthouse\n/unrenthouse\n/furniture", "Ok", "");
					case 20: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Roleplay", "/rphelp\n/toganimchat\n/blindfold\n/screenfade\n/tie\n/frisk\n/handshake\n/accept\n/time\n/prisontime\n/coin\n/dice\n/dump\n/get\n/give\n/graffit\n/examine\n/putintrunk\n/entertrunk\n/exittrunk\n/paperdivorce\n/marry\n/rand\n/card\n/mycigars\n/taxcalculator\n/animations", "Ok", "");
					case 21: ShowPlayerDialog(playerid, DIALOG_KASINO, DIALOG_STYLE_MSGBOX, "Kasino", "/poker\n/rulet\n/rulethelp ", "Ok", "Saznaj vise");
					case 22: ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Ostalo", "/jobduty\n/prostitute\n/admins\n/helpers\n/hh\n/helpme\n/report\n/colors\n/flight\n/fr\n/buymelee\n/dog\n/jail_alert", "Ok", "");
				 }
			}
			return 1;
		}
		case DIALOG_ADMHELP:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 1","/checklastlogin,/check,/setint,/mute,/kick,/disconnect,/cnn,/a(dmin) chat,/am,/pweapons,/port\n\
						   /pm,/aon,/recon,/setviwo,/masked,/dmers,/clearchat,/slap,/checknetstats\n\
						   /learn,/freeze,/unfreeze,/akill,/count,/checkoffline,/lastdriver\n\
						   /fly,/lt,/rt,/goto,/rtc,/togadminwarns,/houseo,/bizo,/complexo\n\
						   /biznis_id,/house_id,/complex_id,/triatlonhelp", "Zatvori", "");
					case 1:
					{
						if(PlayerInfo[playerid][pAdmin] < 2)
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 2+!");
						else ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 2","/pmears,/warn,/unban,/removeall,/gethere,/toga\n\
						   /jail,/unjail,/banex,/prisoned,/weatherall,/rtcinradius\n\
						   /unbanip,/gotocar,/charge,/chargeex,/prison,/unprison,/ban,/cnn,/warnex\n\
						   /prisonex,/drivers,/jobids,/getip,/rtcacar,/iptoname,/givebullet\n\
						   /chargep,/chargepex,/removemusic,/dakarhelp,/quadhelp", "Zatvori", "");
					}
					case 2:
					{
						if(PlayerInfo[playerid][pAdmin] < 3)
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 3+!");
						else ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 3","/mark,/gotomark,/entercar,/getcar,/fpm,/fpmed,/removetuning,/setmobilecredits\n\
						   /blockreport,/setph,/findobjectowner,/aremoveallplayerobjects,/checkplayerobjects\n\
						   /tod", "Zatvori", "");
					}
					case 3:
					{
						if(PlayerInfo[playerid][pAdmin] < 4)
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 4+!");
						else ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 4","/mutearound,/atake,/aunlock,/bigears,/givegun,/fixveh,/setpharound\n\
						   /setarmoraround,/freezearound,/unfreezearound,/undie,/givelicense\n\
						   /veh,/getspawnedvehs,/setarmour,/rac,/skin,/worders,/bizinfo", "Zatvori", "");
				   }
					case 4:
					{
						if(PlayerInfo[playerid][pAdmin] < 1337)
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 1337+!");
						else ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 1337","/fstyle,/skin,/setstat, /setcostats ,/weather,/healcar,/createvip,/createware,/fuelcars,/fuelcar,/edit\n\
						   /asellhouse,/asellbiz,/asellcomplex,/asellcomplexroom,/checkbizowner,/address,/afaction", "Zatvori", "");
					}
					case 5:
					{
						if(PlayerInfo[playerid][pAdmin] < 1338)
							return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Admin Level 1338!");
						else ShowPlayerDialog(playerid, DIALOG_ADMHELP, DIALOG_STYLE_MSGBOX, "KOMANDE - Admin level 1338","/setmoney,/givemoney,/achangename,/achangenameex,/makeadminex,/setvehplates,/makehelper\n\
						   /givepremium,/removewarn,/houseint,/houseentrance,/bizentrance,/veh_plate,/approve_tax\n\
						   /happyhours,/togpm,/crash,/deletebiz,/createbiz,/customhouseint,/custombizint\n\
						   /createtower,/destroytower,/viewtowers,/item,/agps", "Zatvori", "");
					}
				}
			}
			return 1;
		}
		case DIALOG_HELPER_HELP:
		{
			if(!response)
				return 1;
				
			switch(listitem)
			{
				case 0:
				{
					if(PlayerInfo[playerid][pHelper] < 1 && PlayerInfo[playerid][pAdmin] == 1338)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Helper Level 1+!");
					ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Helper Level 1", "/learn /apm /hon /hoff /hm /a /h /ach /forumname /kick /disconnect /slap /goto /checkoffline", "Izlaz", "");
				}
				case 1:
				{
					if(PlayerInfo[playerid][pHelper] < 2 && PlayerInfo[playerid][pAdmin] == 1338)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Helper Level 2+!");
					ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Helper Level 2", "/port /recon /rtc /rtcinradius /setint /setviwo", "Izlaz", "");
				}
				case 2:
				{
					if(PlayerInfo[playerid][pHelper] < 3 && PlayerInfo[playerid][pAdmin] == 1338)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Helper Level 3+!");
					ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Helper Level 3", "/gethere /freeze /unfreeze", "Izlaz", "");
				}
				case 3:
				{
					if(PlayerInfo[playerid][pHelper] < 4 && PlayerInfo[playerid][pAdmin] == 1338)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste Helper Level 4!");
					ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Helper Level 4", "/mark /gotomark /check", "Izlaz", "");
				}
			}
			return 1;
		}
		case DIALOG_HELPACC:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,"POMOC","1.Account \n2.Vozilo \n3.Organizacije \n4.Biznis \n5.Novac \n6.Muzika \n7.Objekti \n8.Death system \n9.Droga \n10.Hunger \n11.Hobi \n12.License \n13.Mobitel \n14.Skills \n15.Oruzje \n16.Chat \n17.Poslovi \n18.Garaze \n19.Complexi \n20.House&Furniture\n21.Biznis\n22.Kasino \n23.Ostalo","Zatvori","");
				return 1;
			}
			else
			{
				new accstring [1024],
					acc [128];
				format(acc, sizeof(acc), "Zabranjeno je bilo kakvo posudjivanje racuna drugim osobama\n");
				strcat(accstring, acc, sizeof(accstring));
				format(acc,sizeof(acc), "Odaberite password koji niti na kojin nacin nije povezan sa vama i koji je siguran\n");
				strcat(accstring, acc, sizeof(accstring));
				format(acc,sizeof(acc), "Tim ne odgovara za izgubljene passworde ili ostale informacije racuna\n");
				strcat(accstring, acc, sizeof(accstring));
				format(acc,sizeof(acc), "Ukoliko primetite da na vasem racunu igra netko,momentalno ga prijavite administratorima\n");
				strcat(accstring, acc, sizeof(accstring));
				format(acc,sizeof(acc), "Prodavanje vasih server racuna je strogo zabranjeno\n");
				strcat(accstring, acc, sizeof(accstring));
				format(acc,sizeof(acc), "Dozvoljeno je posjedovati dva ili vise racuna samo ukoliko izmedju njih nema povezanosti");
				strcat(accstring, acc, sizeof(accstring));
				ShowPlayerDialog(playerid,DIALOG_HELPACC, DIALOG_STYLE_MSGBOX, "Account", accstring , "Zatvori", "");
			}
			return 1;
		}
		case DIALOG_KASINO:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,"POMOC","1.Account \n2.Vozilo \n3.Organizacije \n4.Biznis \n5.Novac \n6.Muzika \n7.Objekti \n8.Death system \n9.Droga \n10.Hunger \n11.Hobi \n12.License \n13.Mobitel \n14.Skills \n15.Oruzje \n16.Chat \n17.Poslovi \n18.Garaze \n19.Complexi \n20.House&Furniture\n21.Biznis\n22.Kasino \n23.Ostalo","Zatvori","");
				return 1;
			}
			else
			{
				new casinostring [1024];
				strcat(casinostring, "Da biste zapoceli igru pokera morate se nalaziti u prostoriji kasina, potrebno je minimalno 2 igraca za stolom kako bi nastavili sa igrom( /poker start )\n\
					Da bi diler sjeo za stol koristi se komanda /poker dealer. Ukoliko zelite prekinuti igrati, /poker cancel \n\
					Da bi diler nekog pozvao na poker koristi se /poker invite. Da bi ga kickao /poker kick.\n\
					Da bi diler promjesao karte koristi se /poker newgame. Da bi podijelio karte, /poker deal. \n\
					Dealer: Flop(prve 3 karte): /poker flop | Turn(4. karta): /poker turn | River(5. karta): /poker river. \n\
					Dealer uvijek treba dati vremena za dizanje uloga izmedju rundi!\n\n\
					Da bi provjerili svoje karte koristite /poker cards. Da bi digli ulog, koristite /poker pay. Da bi odustali, /poker fold. \n\
					Ukoliko zelite provjeriti iznos novaca na stolu, /poker checkpot. Ukoliko zelite pokazati svoje karte na kraju igre: /poker showcards.\n\n\
					Da biste zapoceli rulet u prostoriji kasina pored stola za rulet kucate komandu /rulet, nakon toga vam ne trebaju dodatne komande i nastavljate igru po zelji.", 
					sizeof(casinostring)
				);
				ShowPlayerDialog(playerid,DIALOG_KASINO, DIALOG_STYLE_MSGBOX, "KASINO", casinostring , "Zatvori", "");
			}
			return 1;
		}
		case DIALOG_HOBI:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,"POMOC","1.Account \n2.Vozilo \n3.Organizacije \n4.Biznis \n5.Novac \n6.Muzika \n7.Objekti \n8.Death system \n9.Droga \n10.Hunger \n11.Hobi \n12.License \n13.Mobitel \n14.Skills \n15.Oruzje \n16.Chat \n17.Poslovi \n18.Garaze \n19.Complexi \n20.House&Furniture\n21.Biznis\n22.Kasino \n23.Ostalo","Zatvori","");
				return 1;
			}
			else
			{
				new hobistring [1300];
				new fish [256];
				format(fish, sizeof(fish), "RIBOLOVAC:\nDa biste se mogli koristiti komandu /fish potrebno je da kupite objekat stapa u Verona Mall-u.\n");
				strcat(hobistring, fish, sizeof(hobistring));
				format(fish,sizeof(fish), "Ispod prodavnice u kojoj ste kupili stap se nalazi 24/7 u kojem kupujete mamac /buybait.\n");
				strcat(hobistring, fish, sizeof(hobistring));
				format(fish,sizeof(fish), "Mesta za pecanje su: 1) Glen Park jezero 2) Malo jezero na zapadnoj strani aerodroma 3) Drvena platforma u Santa Maria Beachu (ringispil).\n");
				strcat(hobistring, fish, sizeof(hobistring));
				format(fish,sizeof(fish), "Iako mozete pecati na vise mesta, na razlicitom mestu mozete upecati ribe razlicite velicine. Ribe mozete prodati u bilo kojem 24/7.\n\n");
				strcat(hobistring, fish, sizeof(hobistring));
				
				format(fish,sizeof(fish), "LOVAC:\nPistaljku kupujete u 24/7 marketu. Koristeci nju mozete prizvati jelena. Nakon sto ubijete jelena koristite komandu /cutdeer za koju je potrebno imati noz.\n");
				strcat(hobistring, fish, sizeof(hobistring));
				format(fish,sizeof(fish), "Ukoliko zelite prestati sa secenjem mesa koristite komandu /stopcutdeer. Kako biste videli koliko mesa imate kod sebe koristite komandu /checkmeat.\n");
				strcat(hobistring, fish, sizeof(hobistring));
				format(fish,sizeof(fish), "Zatim, odlaskom u bilo koji 24/7 market komandom /sellmeat prodajete meso, te zaradjujete novac.");
				strcat(hobistring, fish, sizeof(hobistring));

				ShowPlayerDialog(playerid,DIALOG_HOBI, DIALOG_STYLE_MSGBOX, "RIBOLOVAC I LOVAC", hobistring , "Zatvori", "");
			}
			return 1;
		}
		case DIALOG_JOBHELP: {
			if(!response) return (true);
			new jstring[4096];
    		switch(listitem) {
    			case 0: {
    				strcat(jstring, "Sjediste kosca trave se nalazi nadomak Glen Park.\n");
    				strcat(jstring, "Kada dodjete na zelenu povrsinu sa kosilicom, koristite komandu /mow. Zatim pocinjete kosnjavu sve dok ne ispunite kvotu od 100 metara.\n");
    				strcat(jstring, "Kada se kvota ispuni, kosilica ce vam nestati. Ako zelite opet da odradite jednu turu, opet se zaputite prema kosilicama gdje ponavljate proces.\n");
    				strcat(jstring, "Maksimalan broj tura je 3 puta u jednom satu igre. Iznos koji zaradite se prebacuje na devizni racun koji podizete u vijenici sa komandom /payout.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "KOSAC TRAVE", jstring, "U redu", "");
    			}
    			case 1: {
    				strcat(jstring, "Lokacija posla je nadomak El Corone.\n");
    				strcat(jstring, "Ovaj posao je jednostavan, jer je potrebno samo da pratite checkpointe koje vam skripta izbacuje. Koristite komandu /craft kako biste zapoceli posao.\n");
    				strcat(jstring, "Pocetna zarada na ovom poslu je 350$, a svakih 50 delivera vam se povecava za 25$.\n");
    				strcat(jstring, "Maksimalan broj delivera u jednom satu je 3, a zaradjeni novac sa radne knjizice podizete u vijecnici sa komandom /payout.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TVORNICKI RADNIK", jstring, "U redu", "");
    			}
    			case 2: {
    				strcat(jstring, "Posao se uzima u vijecnici sa komandom /takejob.\n");
    				strcat(jstring, "Nakon toga odlazite iza iste, gdje cete vidjeti male kamioncice/sweepere u koji ulazite i komandom /sweep start zapocinjete posao.\n");
    				strcat(jstring, "Sve sto je dalje potrebno jeste pratiti markere/checkpointe kroz grad.\n");
    				strcat(jstring, "Nakon toga, dolazite nazad do lokacije posla i dobijate zaradu shodno vasem skillu (zarada varira ovisno o vasem skill levelu).\n\n");
    				strcat(jstring, "HINT: Izlaskom iz vozila NE PONISTAVA se vasa ruta.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "CISTAC ULICE", jstring, "U redu", "");
    			}
    			case 3: {
    				strcat(jstring, "Smecar sam po sebi daje nam na izbor da obavljamo kao /garbage foot ili /garbage truck.\n");
    				strcat(jstring, "Sa skill levelom 0 ostaje nam odabir samog /garbage foot kojeg mozemo obavljati osobnim automobilom.\n");
    				strcat(jstring, "Prije samog pocetka, moramo uzeti odjecu komandom /garbage clothes na istoj lokaciji gdje se nalaze sami smetlarski kamioni (iza vijecnice),\nna serveru je prikazan pickup majice gdje kucate tu komandu.\n");
    				strcat(jstring, "Idite do najblizeg kontejnera i stiskom lijevog klika misa, ubacite smece u kontejner.\n");
    				strcat(jstring, "Tura se sastoji od 8 ubacenih vreca u smece/kontejner.\n\n");
    				strcat(jstring, "Drugi tip posla jeste /garbage truck za kojeg vam je potreban skill 1.\n");
    				strcat(jstring, "Takodje, ovaj dio posla zahtjeva radnu odoru koju uzimamo na pocetku posla istom komandom /garbage clothes.\n");
    				strcat(jstring, "Pocetkom posla pratite marker do random kontejnera koji ce vm biti zadan i ponovo klikom lijevog misa izbacite smece iz kontejnera.\nDodjite do zadnjeg dijela vaseg kamiona i lijevim klikom misa ubacite ga.\n");
    				strcat(jstring, "Nakon odradjenog broja tura dolazite na deponiju i tamo izbacujete smece, gdje vam i zarada lijeze na devizni racun.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "SMECAR", jstring, "U redu", "");
    			}
    			case 4: {
    				/*strcat(jstring, "Posao ima dvije mogucnosti: prevoz teretne prikolice kamionom i prevoz produkata kombijem.\nObe se mogucnosti svode na preuzimanje produkata i njihovu dostavu biznisima.\n");
    				strcat(jstring, "Za dostavu kamionom koristite komandu /trucker koja vam automatski nudi listu svih raspolozivih komandi.\nKamion uzimate na dvije lokacije (/gps -> Angel Pine trucks ili Desert trucks).\n");
					strcat(jstring, "Prije svega, vazno je znati koja rutu mozete voziti sa kojim skillom i sa kojom prikolicom. Da bi to doznali, koristite /trucker info\n");
    				strcat(jstring, "Nakon sjedanja u kamion, odaberite teretnu prikolicu pogodnu za rutu koju cete odraditi komandom /trucker start.\nMorate pokupiti produkte u tvornici oznacenoj na lokaciji koje kasnije dostavljate biznisima.\n");
    				strcat(jstring, "Posao mozete zaustaviti u bilo kojem trenutku komandom /trucker stop.\n");
    				strcat(jstring, "Za bolji ugodjaj, motorolom mozete komunicirati sa svim prisutnim kamiondzijama, /tc komanda.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TRUCKER", jstring, "U redu", "");*/
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Posao izbacenen");
    			}
    			case 5: {
    				strcat(jstring, "Kada uzmete posao drvosjece, idete do Palomino Creek farme kako bi sjekli drvece.\n");
    				strcat(jstring, "Stanete pored izmapanog drveta, te kucate /cuttree. Nakon 60 sekundi drvo pada, te idete na drugi checkpoint kako bi isjekli grane (proces traje 30 sekundi).\n");
    				strcat(jstring, "Poslije toga kucate /pickupwood, te otvara gepek vaseg vozila i kucate /putwood. Poslije toga se vozite do lokacije The Paonopticon gdje stajete na zuti marker.\n");
    				strcat(jstring, "Izlazite iz vozila, otvarate gepek te kucate /checkvehwood da vidite na kojem je slotu drvo, zatim /takewood ID. Kada ste uzeli jednostavno u zuti marker kucate /sellwood.\n\n");
    				strcat(jstring, "HINT: Za ovaj posao je potrebno posjedovati vozilo marke Bobcat, Sadler, Picador, Yosemite ili Walton.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "DRVOSJECA", jstring, "U redu", "");
    			}
    			case 6: {
    				strcat(jstring, "Posao mozete obavljati u mehanicarskoj garazi (/gps) u Willowfield ili bilo gdje ako se nalazite u tow truck (s tim da imate dovoljno dijelova).\n");
    				strcat(jstring, "Za obavljanje posla su vam potrebni mehanicarski dijelovi koji se kupuju iza tvornice pored junkyarda, oni se kupuju komandom /parts buy.\n");
    				strcat(jstring, "Vozila popravljate sa /repair, a blindirate sa /armorcar. Imate tri vrste popravki; popravka motora (/repair engine),\npopravka limarije (/repair bodykit) i skidanje unistenja (/repair dents).\n");
    				strcat(jstring, "Svaka popravka oduzima odredjen broj dijelova iz vaseg inventara.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MEHANICAR", jstring, "U redu", "");
    			}
    			case 7: {
    				strcat(jstring, "Sjediste ovog posla se nalazi unutar Pizza Stack u Idlewood.\n");
    				strcat(jstring, "Unutar objekta imate marker gdje uzimate /pizza skin. Onda kod sank narucujete broj pizza sa komandom /pizza order (1-8).\n");
    				strcat(jstring, "Nakon toga, pizze koje ste uzeli nosite van i /pizza put ih u motore postavljate koji se nalaze pored.\n");
    				strcat(jstring, "Kad sjednete na motor pojavljivace vam se random checkpoints raznih kuca na mapi.\n");
    				strcat(jstring, "/pizza take kad dodjete na checkpoint, zatim /pizza deliver. Mozete raditi tri ture sa po 8 pizza.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "PIZZA-BOY", jstring, "U redu", "");
    			}
    			case 8: {
    				ShowPlayerDialog(playerid, DIALOG_FARMERHELP, DIALOG_STYLE_LIST, "FARMER", "Milk Man\nEgg Picker\nPlanter\nTransporter\nCombine Driver", "U redu", "");
    			}
    			case 9: {
    				strcat(jstring, "Za posao taksiste vam je potrebno vozilo koje se kupuje u Wang Cars (/gps).\n");
    				strcat(jstring, "Kada kupite vozilo pocinjete sa radom i cekate klijente. Kad vas neko od klijenata pozove, odlazite na lokaciju.\n");
    				strcat(jstring, "Od trenutka kada klijent udje u vozilo, vi kucate komandu /taxi (taksimetar koji ce vam ocitavati potrebne podatke).\n");
    				strcat(jstring, "U slucaju da ima vise taksista na duznosti osim vas, koristite komandu /tr (radio) da bi se dogovorili i rasporedili poslove.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TAKSISTA", jstring, "U redu", "");
    			}
    			case 10: {
    				/*strcat(jstring, "Za lokaciju rudara koristite /gps.\n\n");
    				strcat(jstring, "Da biste zapoceli ovaj posao potrebno je kucati /startmining nakon cega se morate popeti na grumen zlata i pritisnuti Y/Z kako bi aktivirali obradjivanje zlata.\n");
    				strcat(jstring, "Tada vam se pojavljuje progress i vi morate pritiskati SPACE da bi zavrsili obradu.\n");
    				strcat(jstring, "U jednoj turi radite po pet grumena zlata, a po paydayu mozete ukupno raditi tri ture.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "RUDAR", jstring, "U redu", "");*/
					SendClientMessage(playerid, COLOR_RED, "[ ! ] Posao izbacenen");
    			}
    			case 11: {
    				strcat(jstring, "Kod ovog posla imate jednu osnovnu komandu, a to je /drug, ona vam ispise sve potrebne komande.\n\n");
    				strcat(jstring, "Sa ovim poslom mozete saditi marihuanu na nekom vasem tajnom mjestu, ali prethodno morate kupiti sjemenke u East Los Santos.\n");
    				strcat(jstring, "Takodje, mozete kuvati metamfetamin u svojoj kuci, ali naravno morate uzeti u Magic Shop klorovodicnu kiselinu, mravlju kiselinu i klorovodicni hidroksid.\n");
    				strcat(jstring, "Pored ove dvije droge koje mozete praviti/uzgajati, takodje imate opciju da pravite crack,\nali za ovu drogu morate imati kokain (Ilegalni trucker) i naravno uzeti u Magic Shop sodu bikarbonu kako bi mogli pomjesati.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "DRUG-DEALER", jstring, "U redu", "");
    			}
    			case 12: {
    				strcat(jstring, "Komanda kojom vas zaposljavaju je /trucker hire. Narko bossovi mogu birati izmedju kokaina/heroina/ekstazija.\n\n");
    				strcat(jstring, "Roba dolazi svakih tjedan dana, te svaka mafija ima pravo uzeti jednaku kolicinu.\n");
    				strcat(jstring, "Nije potreban proces proizvodnje. Potreban je igrac sa kljucevima Warehousea/Leader koji narucuje transport od vas.\n");
    				strcat(jstring, "Novac iz Warehousea se skida pri istovaru, a Warehouse dobiva odredjenu kolicinu narucene droge.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "ILLEGAL TRUCKER(Drug Smuggler)", jstring, "U redu", "");
    			}
    			case 13: {
    				strcat(jstring, "Sjediste ovog posla jeste kao mehanicarska garaza koja se nalazi na Ocean Docks.\n\n");
    				strcat(jstring, "U njoj se nalazi tabla sa vozilima koja su potrebna da se ukradu.\n");
    				strcat(jstring, "Koristite komandu /jacker gdje imate pick da izaberete vozilo, chop da isjecete vozilo kad ga dovucete, leave da napustite misiju i stop da pauzirate misiju.\n");
    				strcat(jstring, "Kad zavrsite sa rastavljanjem vozila, budete isplaceni zavisno od vozila do vozila od strane te garaze.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "CAR-JACKER", jstring, "U redu", "");
    			}
    			case 14: {
    				strcat(jstring, "Lokacija ovog posla je Civic Center, u blizini LSPD stanice.\n\n");
    				strcat(jstring, "Za dzeparenje igraca koristite komandu /pocketsteal, gdje mozete igracu ukrasti pare, sat i telefon iz dzepa.\n");
    				strcat(jstring, "Pljackanje kuce > skill level 2\n/crack_alarm /stealitems /dropitem /takeitem /picklock\n\n");
    				strcat(jstring, "Pljackanje para u kuci > skill level 3\n/stealmoney\n\n");
    				strcat(jstring, "Obijanje sefa u kuci > skill level 4\n/breaksafe /stealsafe\n\n");
    				strcat(jstring, "Kada zavrsite sa kradjom, stvari nosite u East Los Santos iza Car Wash. Provjera ukradenih stvari: /stolengoods, prodaja stvari /sellgoods.");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "LOPOV", jstring, "U redu", "");
    			}
    		}
    	}
    	case DIALOG_FARMERHELP: {
			new jstring[4096];
    		switch(listitem) {
    			case 0: {
    				strcat(jstring, "Milk Man:\n\n");
    				strcat(jstring, "/takebucket > Uzeti kantu za mlijeko, /dropbucket -> Baciti kantu ako vam vise ne treba.\n");
    				strcat(jstring, "/milk milking > Idete do jedne od krava unutar stale i zapocnete proces muzenja krave.\nPrilikom muzenja morate stiskati Y/N ovisno koje vam se pojavi na ekranu.\n");
    				strcat(jstring, "Ako pritisnete pravo slovo, score se povecava za 1, a ako promasite score se smanji za 1.\n");
    				strcat(jstring, "/milk transfer > Nakon uspijesnog dobijanja mlijeka, odete do kanistera i presipate mlijeko iz kante u kanister.\n");
    				strcat(jstring, "/milk store > Idete do spremista za mlijeko, spremite kanister.\n");
    				strcat(jstring, "/dropcanister > Da bacite kanister, ako ga ne zelite ili ne mozete spremiti u spremiste.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MILK-MAN", jstring, "U redu", "");
    			}
    			case 1: {
    				strcat(jstring, "Egg Picker:\n\n");
    				strcat(jstring, "/takecarton > Idete do kutija za jaja, te uzmete jednu. /dropcarton -> Baciti kutiju ako vam ne treba ili je prazna.\n");
    				strcat(jstring, "/eggs collect > Idete do kucica sa strane u kojima su kokoske i tu skupljate jaja.\n");
    				strcat(jstring, "/eggs process > Kada ste uspijesno zavrsili sa skupljanjem jaja odete do masine za procesiranje i sacekate taj proces.\n");
    				strcat(jstring, "/eggs store > Nakon procesiranja odete do skladista i tamo spremite kutiju sa jajima.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "EGG-PICKER", jstring, "U redu", "");
    			}
    			case 2: {
    				strcat(jstring, "Planter:\n\n");
    				strcat(jstring, "/seeds take > Idete do kutija sa sjemenkama i uzmete sjemenke iz kutije.\n");
    				strcat(jstring, "/seeds put > Zatim idete do prikolica za traktor, te stavite sjemenke u prikolicu.\n");
    				strcat(jstring, "/seeds check > Koristite za provjeru stanja, tj. koliko sjemenki imate kod sebe i u prikolici.\n");
    				strcat(jstring, "/seeds drop -> Za baciti sjemenke ako ste slucajno uzeli previse, ili ih ne zelite vise stavljati u prikolicu.\n");
    				strcat(jstring, "/attach_trailer -> Nakon sto imate dovoljno sjemenki u prikolici, odete do traktora te idete do prikolice i prikacite ju na traktor.\n");
    				strcat(jstring, "/detach_trailer -> Koristite za otkaciti prikolicu sa traktora, ako vam vise ne treba.\n");
    				strcat(jstring, "/plant -> Odete do polja za sadnju usjeva, te pritiskom na lijevi klik misa sadite usjeve.\nUsjeve mozete saditi samo unutar polja oderedenog za sadnju, te morate biti malo odmaknuti od prethodnog usjeva kako bi posadili novi.\nAko zelite prestati sa sadnjom usjeva, prije nego istrosite sve sjemenke, samo ponovo upisete /plant.\n");
    				strcat(jstring, "/takespade -> Po zavrsetku sadnje usjeva, idite do mjesta sa lopatama i uzmete jednu.\n");
    				strcat(jstring, "/dropspade -> Koristite kako bi bacili lopatu, ako ste zavrsili sa zetvom usjeva.\n/checkplant -> Sa ovime provjeravate da li je odredeni usjev spreman ili nije.\n/harvest -> Kada su usjevi spremni za zetvu, samo zapocnete proces zetve te zatim cekate dok vam karakter ne spremi usjeve u vrecu.\n/crops drop -> Za baciti usjeve, ako ih ne zelite ili ne mozete spremiti u spremiste.\n");
    				strcat(jstring, "/crops store -> Nakon toga idete do spremista za usjeve i spremite vrecu.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "PLANTER", jstring, "U redu", "");
    			}
    			case 3: {
    				strcat(jstring, "Transporter:\n\n");
    				strcat(jstring, "/transport -> Prvo odaberete jednu od 3 proizvoda za transportirati.\n/transport 1 je za usjeve, 2 za mlijeko, a /transport 3 je za jaja.\nZa transport morate koristiti svoje vlastito vozilo.\nVozila koja mozete koristiti su Walton, Sadler i Bobcat.\n");
    				strcat(jstring, "/stoptransport -> Koristite ako u bilo kojem trenutku zelite prestati sa transportom proizvoda.\n/eggs take -> /milk take - /crops take - Nakon sto ste odabrali sto zelite transportirati, odete do spremista za taj proizvod, te uzmete proizvod.\n/eggs put -> /milk put - /crops put - Nakon sto ste uzeli proizvod, odete do vaseg vozila i stavite proizvod na njega.\n");
    				strcat(jstring, "/eggs check -> /milk check - /crops check - Za provjeriti koliko se proizvoda nalazi na vasem vozilu.\n/eggs sell -> /milk sell - /crops sell - Nakon sto ste napunili vase vozilo, krenete prema Los Santosu.\nKada dodjete tamo, idete do jedne od 3 lokacije, ovisno o tome sto transportirate.\nSve 3 lokacije su na Ocean Docksima, prikazace vam checkpoint pa cete ih lako naci.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TRANSPORTER", jstring, "U redu", "");
    			}
    			case 4: {
    				strcat(jstring, "Combine Driver:\n\n");
    				strcat(jstring, "/work - Udjete u vas kombajn i odete na polje predvidjeno za zanje zita. Kada dodjete do polja, vidjecete da se na polju nalaze objekti zita.\n");
    				strcat(jstring, "Potrebno je proci preko njih, ali pritom morate paziti da ne vozite prebrzo, jer vam se inace nece priznati, te cete morati opet preci preko njih.\n");
    				strcat(jstring, "Kada ste ih sve poznjeli, stvorice vam se checkpoint na pocetku polja (u Sjevero-Zapadnom kutu), te kada udjete u taj CP, posao ce biti uspjesno zavrsen.\n");
    				strcat(jstring, "Ako prilikom voznje kombajna izadjete predaleko iz polja ili jednostavno izadjete iz Kombajna, automatski cete prestati sa poslom.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "COMBINE-DRIVER", jstring, "U redu", "");
    			}
    		}
    	}
	}
	return 1;
}
