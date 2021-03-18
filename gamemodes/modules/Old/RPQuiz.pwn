#include <YSI_Coding\y_hooks>

#define MAX_RP_QUESTIONS		(10)  // Broj RP pitanja na koje igrac treba odgovoriti nakon /learn-a.
#define MAX_ANSWERED_QUESTIONS	(50)
#define MAX_WRONG_ANSWERS		(3)   // Max 2 kriva odgovora po pitanju prije reseta kviza

enum E_QUESTION_INFO {
	rpQuestion[180],
	rpAnswer0[128],
	rpAnswer1[128],
	rpAnswer2[128],
	rpAnswer3[128],
	rpCorrect
};
static QuestionInfo[][E_QUESTION_INFO] = {
	{ "Sto od navedenog je primjer PowerGaminga(PG)?", "1.Skakanje iz prozora GTA SA-MP-a na Google Chrome", "\n2.Skakanje sa price o drogi na premium accountove", "\n3.Pad sa 50m prilikom bjega od PD-a te bijeg bez stajanja", "\n4.Pad sa male visine bez RP-anja ozljede", 2},
	{ "Koji leveli na serveru ne smiju pljackati?", "1.1-6.", "\n2.1-10.", "\n3.Tko god zeli moze pljackati, nije bitan level.", "\n4.2-5.", 0 },
	{ "Koji leveli na serveru ne smiju biti pljackani?", "1.Smiju biti svi pljackani.", "\n2.Samo level 1.", "\n3.1-3.", "\n4.Oni koji ne zele to Role Playati.", 2 },
	{ "Koliko mozete novca, droge i oruzja maksimalno uzeti od nekog prilikom pljacke?", "1.3.000$, 20g droge i 50 metaka oruzja.", "\n2.Sve sto igrac posjeduje kod sebe.", "\n3.Onoliko koliko nam on da.", "\n4.5.000$, 50g droge i 199 metaka oruzja.", 0 },
	{ "Kada smijete RolePlayati seksualni sadrzaj?", "1.Kada imate OOC pristanak od osobe nad kojom to vrsite.", "\n2.Kada god ja zelim.", "\n3.Nikada.", "\n4.Svaki drugi dan.", 0 },
	{ "U brawlu/tuci ste imate 20 posto healtha, sta vam je raditi?", "1.Nastavljam se tuci dok me ne ubije do kraja.", "\n2.RolePlayam da padam na pod i kucam /crack.", "\n3.RolePlayam, da padam na pod i kucam /crack dok mi se ne podigne HP.", "\n4.Ne padam dok ne ubijem igraca sa kojim se tucem.", 1 },
	{ "Gdje ne smijete raditi nikakve ilegalne radnje?", "1.Na poslu.", "\n2.U Green Zone.", "\n3.Kod Pizza Stacka.", "\n4.U privatnim kucama.", 1 },
	{ "Koji nick je pravilan?", "1.Brad_Pitt.", "\n2.Jimmy_Pershing.", "\n3.Ashley_Tisdale.", "\n4.Jahseh_Dwayne_Ricardo_Onfroy.", 1 },
	{ "U slucaju da igrac ucestalo krsi pravila server, sta cete uraditi?", "1.Krsiti pravila zajedno sa njima.", "\n2.Prikupiti dokaze i prijaviti ga na forumu.", "\n3.Reci svojim prijateljima da zajedno krse.", "\n4.Pohvaliti ga na forumu.", 1 },
	{ "Ako primjetite neki bug na serveru, sta cete uraditi?", "1.Prijaviti ga na forumu.", "\n2.Koristiti taj bug u svoje svrhe da niko ne zna.", "\n3.Reci svojim prijateljima da zajedno sa vama ga iskoriste.", "\n4.Objaviti status na Facebooku da svi vide.", 0 },
	{ "Ako je admin na duznosti do vas, sta trebate uraditi?", "1.Nastaviti RolePlay i ignorisati radnje admina.", "\n2.Sacekati sta vam admin ima reci.", "\n3.Provocirati admina preko /b chata.", "\n4.Reci mu da nije upravu.", 1 },
	{ "Sta je Gun from ass (GFA)?", "1.Abuse u kojem se stice vise oruzija.", "\n2.Nosenje oruzija bez dozvole LSPDa.", "\n3.Izvlacenje oruzija bez roleplaya.", "\n4.Ilegalna prodaja oruzija.", 2 },
	{ "Igrac je pao sa zgrade i nastavio da trci.Koje je on pravilo time prekrsio?", "1.MG.", "\n2.DM.", "\n3.RP2WIN.", "\n4.PG.", 3 },
	{ "Ako vas drugi igrac OOC vrijedja sta cete vi uciniti?", "1.Vrijedjat cu i ja njega.", "\n2.Zgazit cu ga autom ili oruzijem kojeg imam kod sebe.", "\n3.Prijaviti adminu na /report i nastaviti Roleplay ili ako nema admina nakon RPa postaviti zalbu na forumu.", "\n4.Prekinuti RP i poceti da se svadjam sa njim na OOC chat.", 2 },
	{ "Ako vidite da je samo 1 admin online na serveru a vi ste poslali report da ga trebate prije 2 minuta i njega jos nema,sta cete uciniti?", "1.Spamati na report sve dok ne dodje.", "\n2.Strpljivo sacekati da dodje i eventualno ponoviti report jednom u par minuta jer pomaze drugim igracima.", "\n3.Poceti da vrijedjam admina i napustiti server.", "\n4.Uzeti auto i ici trazit admina po gradu dok pomaze drugome igracu kako bi meni pomogao.", 1 },
	{ "Ne svidja vam se odluka admina,sta cete uciniti?", "1.Poceti da vrijedjam admina i da govorim da je nesposoban da obavlja svoj posao.", "\n2.Pronaci na forumu PDF Zalbe na CoA Team i tu se zaliti na odluku tog admina.", "\n3.Stalno PMati InGame tog admina preteci mu i govoreci da promeni odluku u moju korist.", "\n4.Kontaktirati 1338 na forumu ili serveru trazeci kaznu za admina.", 1 },
	{ "Koriscenje CHEATova na serveru je?", "1.Dozvoljeno ako time ne uznemiravam druge igrace.", "\n2.Dozvoljeno ako naidje drugi cheater da ga mogu ubit.", "\n3.Dozvoljeno u odredjenim situacijama,na primer ako bezim od PDa.", "\n4.Strogo zabranjeno jer mi donosi prednost u bilo kom vidu u odnosu na druge igrace.", 3 },
	{ "Ako vas nakon potere PD nekako uspe naci i krene hapsiti sta cete uraditi?", "1.Odmah poceti OOC i prozivati ih da su MGeri i citeri.", "\n2.Nastaviti Roleplay i nakon roleplaya se zaliti na forumu ukoliko imam dokaze za moje tvrdnje..", "\n3.Zvati admina iste sekunde kad dodju i zapoceti svadju na OOC chat.", "\n4.Ignorisati njih sesti u moja kola i otici i nakon toga ici /q.", 1 },
	{ "Koji od ovih oglasa je pravilan?", "1.Prodajem kucu na Vinewoodu sa velikom garazom i dvoristem,cena po dogovoru.", "\n2.Kupujem oruzije,prednost imaju automatske puske i deagle.", "\n3.Prodajem Sabre,crne boje,ima 2 unistenja.", "\n4.Pisem knjigu: Dajem 200k IG za Vip GOLDa.", 0 },
	{ "Da li je dozvoljeno deljenje server imovine?", "1.Dozvoljenu je deliti imovinu igracima koji su level 5+.", "\n2.Dozvoljeno je deliti imovinu svakog igracu koga poznajemo.", "\n3.Deljenje imovine nije dozvoljeno.", "\n4.Dozvoljeno je deliti imovinu samo sa opravdanim IC razlogom.", 2 },
	{ "Ko sve moze da CKa??", "1.Samo admin.", "\n2.Svi igraci mogu CKati sa dozvolom Illegal Faction Managementa.", "\n3.Svi igraci mogu CKati sa dozvolom Admina 4+.", "\n4.Lideri oficijalnih ilegalnih fakcija sa dozvolom Illegal Faction Managementa.", 3 },
	{ "Igrac vam salje PM: Odlazim sa servera, dodi kod Pizza Stacka da ti dam auto i 20.000$. Koje pravilo krsi i da li bi pristali da vam da navedenu imovinu?", "1.MG.", "\n2.PG.", "\n3.Pravilo o dijeljenju imovine.", "\n4.RP2WIN.", 2 },
	{ "Sta je Green Zona?", "1.Mjesto gdje su ilegalne radnje dozvoljene.", "\n2.Mjesto gdje mozete saditi travu.", "\n3.Mjesto na kojem su ilegalne radnje zabranjene.", "\n4.Zelene povrsine na kojima se moze igrati tenis ili fudbal.", 2 },
	{ "Upravo ste bili PKani, ni jedno server pravilo nije prekrseno. Sta vam je za raditi?", "1.Zaboraviti sve o osobi/osobama koje su vas PK-ale.", "\n2. Otvoriti zalbu na forumu i ocekivati ishod u vasu korist.", "\n3.Spamati na /report kako ste PKani i zelite da se isti ponisti.", "\n4.Osvetiti se tim istim osobama koje su uradile PK.", 0 },
	{ "U toku je potjera od strane PDa na vas. Ostali ste bez auta, ali vas je PD opkolio i jedino gdje mozete fizicki pobjeci je neka rijeka. Sta cete uraditi?", "1.Skociti u rijeku i odbijati vratiti se na kopno.", "\n2.Ne skakati u rijeku uopste, jer je zabranjeno.", "\n3.Provocirati PD, OOC-ati i spamati na /report da ne mozete pobjeci nigdje.", "\n4.Ne skakati u rijeku uopste i RPati situaciju do kraja bez obzira na ishod.", 3 },
	{ "Vas najbolji drug je dobio ban i zavrsio je na black listi zajednice. Ali, od vas trazi sifru vaseg accounta da ude na server. Sta cete uraditi:?", "1.Dati mu vasu sifru i dopustiti mu da ude na vas account.", "\n2.Odbiti ga i ne dati mu sifru ni jednog vaseg accounta, niti praviti novi account za njega.", "\n3.Napraviti novi account za njega i dati mu sifru tog accounta.", "\n4.Dati mu sifru vaseg drugog (alternative) accounta.", 1 },
	{ "Koga LSPD smije CKati?", "1.Random igraca.", "\n2.Korumpiranog policajca.", "\n3.Zatvorenika.", "\n4.Ilegalnu organizaciju.", 3 },
	{ "Sta od navedenog nije Green Zone?", "1.Pizza Stack.", "\n2.Verona Mall.", "\n3.Banka.", "\n4.LSPD.", 0 },
	{ "Ukoliko RPate na engleskom i dode igrac koji ne zna engleski, sto cete napravit?", "1.Otici /q.", "\n2.Reci mu na PM, nek RPa na engleskom.", "\n3.Poceti rpat na nasem jeziku, jer ta osoba ne zna engleski.", "\n4.Objasniti mu da ne moze RPat sa nama ukoliko ne zna engleski.", 2 },
	{ "/me je iz Afganistana i ima manu hiperaktivnosti, ali voli zivjeti zdravo je:?", "1.Ispravna uporaba /me komande, jer ce mi olaksati develop charachtera .", "\n2.Neispravna uporaba /me komande, jer /me sluzi za izrazavanje radnji mog karaktera.", "\n3.Ispravna uporaba /me komande, jer potjece moju mastu.", "\n4.1 i 3 su tacni odgovori.", 1 },
	{ "Bjezim od policije i izgubili su me iz vida. Sada zelim ici off: ?", "1.To je dopusteno, sudeci da sam im pobjegao .", "\n2.To nije dopusteno ni u kom slucaju .", "\n3. Ako mi dozvole da odem off, mogu.", "\n4.Mogu otici off 10 minuta nakon sto sam im pobjegao .", 3 },
	{ "Primjecujem da officer ne radi bas po pravilima kodeksa i svoje duznosti?", "1.Trebam prijaviti na forumu pod zalbe za igrace .", "\n2.Trebam prijaviti pod IC rubriku zalbe na officere.", "\n3.Uz dokaze trebam pokrenuti IC sudski postupak.", "\n4.2 i 3 su tacni odgovori", 3 },
	{ "Ja sam clan bande. Drugi me je pripadnik bande uvrijedio. To svrstavam pod:", "1.Razlog za IC ubojstvo .", "\n2.Razlog za IC beef (neprijateljstvo) i fizicki sukob .", "\n3.Razlog za pokretanje OOC konflikta.", "\n4. Razlog za zalbu na forumu.", 1 }
};

new CurrentQuestion[MAX_PLAYERS],
	WrongAnswers[MAX_PLAYERS],
	CorrectAnswers[MAX_PLAYERS],
	Iterator:AnsweredQuestion[MAX_PLAYERS] <MAX_ANSWERED_QUESTIONS>;

stock GenerateQuestion(playerid)
{
	if(Iter_Count(AnsweredQuestion[playerid]) > 25)
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ] Previse puta ste netocno odgovorili na pitanja te ste zbog toga kickani!");
		SendClientMessage(playerid, COLOR_RED, "Uzitak na nasem serveru ovisi upravo o postivanju pravila i simulaciji pravog zivota.");
		va_SendClientMessage(playerid, 
			COLOR_RED, 
			"SAVJET: If you didn't catch rules of our server, please visit %s.", 
			WEB_URL
		);
		KickMessage(playerid);
		return 1;
	}
	question_start:
	new question = random(sizeof(QuestionInfo));
	if(Iter_Contains(AnsweredQuestion[playerid], question))
		goto question_start;
	ShowPlayerDialog(playerid, DIALOG_TEST_QUESTION, DIALOG_STYLE_MSGBOX, "Pitanje:", QuestionInfo[question][rpQuestion], "Answer", "");
	CurrentQuestion[playerid] = question;
	return 1;
}

stock StartKnowledgeQuiz(playerid)
{
	CurrentQuestion[playerid] = -1;
	WrongAnswers[playerid] = 0;
	CorrectAnswers[playerid] = 0;
	GenerateQuestion(playerid);
}

stock EndQuiz(playerid)
{
	SendMessage(playerid, MESSAGE_TYPE_SUCCESS, "Cestitamo! Uspjesno ste odgovorili na svih 10 pitanja.");
	SendClientMessage(playerid, COLOR_RED, "[ ! ] SAVJET: Ubuduce, molimo Vas da postujete pravila servera. Uzivajte u igri!");
	PlayerInfo[playerid][pMustRead] = false;
	PlayerInfo[playerid][pMuted] = false;
	
	if(Bit1_Get(gr_FristSpawn, playerid))
		FinishPlayerSpawn(playerid);
	else
	{
		SetPlayerPreviousInfo(playerid);
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	CurrentQuestion[playerid] = -1;
	WrongAnswers[playerid] = 0;
	CorrectAnswers[playerid] = 0;
	Iter_Clear(AnsweredQuestion[playerid]);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_TEST_QUESTION:
		{
			new question = CurrentQuestion[playerid];
			if(!response)
			{
				SendClientMessage(playerid, COLOR_RED, "[OBAVIJEST]: Kickani ste sa servera jer ste odbili poloziti RP kviz.");
				SendClientMessage(playerid, COLOR_RED, "Uzitak na nasem serveru ovisi upravo o postivanju pravila i simulaciji pravog zivota.");
				va_SendClientMessage(playerid, 
					COLOR_RED, 
					"SAVJET: If you didn't catch rules of our server, please visit %s.", 
					WEB_URL
				);
				KickMessage(playerid);
			}
			else
			{
				new astring[512];
				strcat(astring, QuestionInfo[question][rpAnswer0], sizeof(astring));
				strcat(astring, QuestionInfo[question][rpAnswer1], sizeof(astring));
				strcat(astring, QuestionInfo[question][rpAnswer2], sizeof(astring));
				strcat(astring, QuestionInfo[question][rpAnswer3], sizeof(astring));
				ShowPlayerDialog(playerid, DIALOG_TEST_ANSWER, DIALOG_STYLE_LIST, "Ponudjeni odgovori:", astring, "Choose", "Question");
			}
		}
		case DIALOG_TEST_ANSWER:
		{
			new question = CurrentQuestion[playerid],
				rest = 0,
				wrest = 0;
			if(!response)
				ShowPlayerDialog(playerid, DIALOG_TEST_QUESTION, DIALOG_STYLE_MSGBOX, "Pitanje:", QuestionInfo[question][rpQuestion], "Next", "");
			else
			{
				if(listitem == QuestionInfo[question][rpCorrect])
				{
					CorrectAnswers[playerid]++;
					if(CorrectAnswers[playerid] == 10)
					{
						EndQuiz(playerid);
						return 1;
					}
					WrongAnswers[playerid] = 0;
					Iter_Add(AnsweredQuestion[playerid], question);
					rest = MAX_RP_QUESTIONS - CorrectAnswers[playerid];
					SendFormatMessage(playerid, MESSAGE_TYPE_SUCCESS, "Tocan odgovor. Preostalo je jos %d pitanja do kraja kviza!", rest);
					GenerateQuestion(playerid);
				}
				else
				{
					WrongAnswers[playerid]++;
					wrest = MAX_WRONG_ANSWERS - WrongAnswers[playerid];
					if(WrongAnswers[playerid] < MAX_WRONG_ANSWERS)
					{
						va_SendClientMessage(playerid, COLOR_RED, "Netocan odgovor, imas pravo jos %d puta netocno odgovoriti na ovo pitanje.", wrest);
						va_SendClientMessage(playerid, COLOR_RED, "Ukoliko %d puta netocno odgovoris, cijeli kviz krece isponova.", MAX_WRONG_ANSWERS);
						ShowPlayerDialog(playerid, DIALOG_TEST_QUESTION, DIALOG_STYLE_MSGBOX, "Pitanje:", QuestionInfo[question][rpQuestion], "Next", "");
					}
					else
					{
						SendMessage(playerid, MESSAGE_TYPE_ERROR, "Previse puta ste netocno odgovorili na pitanje. Kviz ponovno krece.");
						StartKnowledgeQuiz(playerid);
					}
				}
			}
		}
	}
	return 1;
}					