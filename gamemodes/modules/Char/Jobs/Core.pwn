/* 
*	  		  Job System
*	 www.cityofangels-roleplay.com
*	    created and coded by L3o.
*		 credits: CoA dev team.
*	      All rights reserved.
*	     	   (c) 2019
*/

#include <YSI\y_hooks>

/*
	- enumerator & defines
*/	

enum {
	NORMAL_JOBS_EMPLOYERS = (25),  /* OOC POSLOVI */
	OFFICIAL_JOBS_EMPLOYERS = (20), /* IC POSLOVI */
	
	NORMAL_FREE_WORKS 		  	= (15),
	BRONZE_DONATOR_FREE_WORKS 	= (20),
	SILVER_DONATOR_FREE_WORKS 	= (25),
	GOLD_DONATOR_FREE_WORKS   	= (30),
	PLATINUM_DONATOR_FREE_WORKS	= (50)
};

enum E_JOBS_DATA {
	SWEEPER,     /* [id:1] */
	PIZZABOY,    /* [id:2] */
	MECHANIC,    /* [id:3] */
	MOWER, 	     /* [id:4] */
	CRAFTER,     /* [id:5] */
	TAXI, 	     /* [id:6] */
	FARMER,      /* [id:7] */
	LOGGER,      /* [id:14] */
	TRUCKER,     /* [id:15] */
	GARBAGE,    /* [id:16] */
	IMPOUNDER,  /* [id:17 ] */
	TRANSPORTER    /* [id:18 */
}
new JobData[E_JOBS_DATA];

/*
	- mySQL
*/

SaveJobData() {
	new query[300];
	format(query, sizeof(query), "UPDATE `server_jobs` SET `Sweeper` = '%d', `Pizzaboy` = '%d', `Mechanic` = '%d', `Mower` = '%d', `Crafter` = '%d', `Taxi` = '%d', `Farmer` = '%d', `Logger` = '%d', `Garbage` = '%d', `Impounder` = '%d', `Transporter` = '%d' WHERE 1",
		JobData[SWEEPER],
		JobData[PIZZABOY],
		JobData[MECHANIC],
		JobData[MOWER],
		JobData[CRAFTER],
		JobData[TAXI],
		JobData[FARMER],
		JobData[LOGGER],
		JobData[GARBAGE],
		JobData[IMPOUNDER],
		JobData[TRANSPORTER]
	);
	return mysql_tquery(g_SQL, query);
}

LoadServerJobs() {
	mysql_tquery(g_SQL, "SELECT * FROM server_jobs WHERE 1", "OnServerJobsLoaded");
	return 1;
}

forward OnServerJobsLoaded();
public OnServerJobsLoaded() {
	new rows = cache_num_rows();
	if(!rows) return printf( "MySQL Report: No Server Jobs exist to load.");
	
	cache_get_value_name_int(0, "Sweeper", JobData[SWEEPER]);
	cache_get_value_name_int(0, "Pizzaboy", JobData[PIZZABOY]);
	cache_get_value_name_int(0, "Mechanic", JobData[MECHANIC]);
	cache_get_value_name_int(0, "Mower", JobData[MOWER]);
	cache_get_value_name_int(0, "Crafter", JobData[CRAFTER]);
	cache_get_value_name_int(0, "Taxi", JobData[TAXI]);
	cache_get_value_name_int(0, "Farmer", JobData[FARMER]);
	cache_get_value_name_int(0, "Logger", JobData[LOGGER]);
	cache_get_value_name_int(0, "Trucker", JobData[TRUCKER]);
	cache_get_value_name_int(0, "Garbage", JobData[GARBAGE]);
	cache_get_value_name_int(0, "Impounder", JobData[IMPOUNDER]);
	cache_get_value_name_int(0, "Transporter", JobData[TRANSPORTER]);
	return (true);
}

/*
	- Functions
*/

SetPlayerJob(playerid, job_id) {
	switch(job_id) {
		case 1: JobData[SWEEPER] ++;
		case 2: JobData[PIZZABOY] ++;
		case 3: JobData[MECHANIC] ++;
		case 4: JobData[MOWER] ++;
		case 5: JobData[CRAFTER] ++;
		case 6: JobData[TAXI] ++;
		case 7: JobData[FARMER] ++;
		case 14: JobData[LOGGER] ++;
		case 15: JobData[TRUCKER] ++;
		case 16: JobData[GARBAGE] ++;
		case 17: JobData[IMPOUNDER] ++;
		case 18: JobData[TRANSPORTER] ++;
	}
	PlayerInfo[playerid][pJob] = job_id;
	PlayerInfo[playerid][pContractTime] = 0;
	SaveJobData();
	return (true);
}

RemovePlayerJob(playerid) {
	switch(PlayerInfo[playerid][pJob]) {
		case 1: JobData[SWEEPER] --;
		case 2: JobData[PIZZABOY] --;
		case 3: JobData[MECHANIC] --;
		case 4: JobData[MOWER] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
		case 18: JobData[TRANSPORTER] --;
	}
	PlayerInfo[playerid][pJob] 	= 0;
	PlayerInfo[playerid][pContractTime] = 0;
	SaveJobData();
	return (true);
}

RemoveOfflineJob(jobid)
{
	switch(jobid) {
		case 1: JobData[SWEEPER] --;
		case 2: JobData[PIZZABOY] --;
		case 3: JobData[MECHANIC] --;
		case 4: JobData[MOWER] --;
		case 5: JobData[CRAFTER] --;
		case 6: JobData[TAXI] --;
		case 7: JobData[FARMER] --;
		case 14: JobData[LOGGER] --;
		case 15: JobData[TRUCKER] --;
		case 16: JobData[GARBAGE] --;
		case 17: JobData[IMPOUNDER] --;
		case 18: JobData[TRANSPORTER] --;
	}
	SaveJobData();
	return (true);
}

JobsList() {
	new buffer[512];
			
	format(buffer, sizeof(buffer), "{3C95C2}Job\t{3C95C2}Workers\nCistac ulica\t[%d/%d]\nPizzaboy\t[%d/%d]\nMehanicar\t[%d/%d]\nKosac Trave\t[%d/%d]\nTvornicki radnik\t[%d/%d]\nTaksista\t[%d/%d]\nFarmer\t[%d/%d]\nDrvosjeca\t[%d/%d]\nSmetlar\t[%d/%d]\nVehicle Impounder[%d/%d]\nTransporter[%d/%d]",
		JobData[SWEEPER], NORMAL_JOBS_EMPLOYERS,
		JobData[PIZZABOY], NORMAL_JOBS_EMPLOYERS,
		JobData[MECHANIC], OFFICIAL_JOBS_EMPLOYERS,
		JobData[MOWER], NORMAL_JOBS_EMPLOYERS,
		JobData[CRAFTER], NORMAL_JOBS_EMPLOYERS,
		JobData[TAXI], OFFICIAL_JOBS_EMPLOYERS,
		JobData[FARMER], NORMAL_JOBS_EMPLOYERS,
		JobData[LOGGER], NORMAL_JOBS_EMPLOYERS,
		JobData[GARBAGE], NORMAL_JOBS_EMPLOYERS,
		JobData[IMPOUNDER], OFFICIAL_JOBS_EMPLOYERS,
		JobData[TRANSPORTER], NORMAL_JOBS_EMPLOYERS
	);
	return (buffer);
}

/*
	- hooks
*/	

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new jstring[1500];
	switch(dialogid) 
	{
		case DIALOG_JOBS: 
		{
			if( !response ) return (true);
			switch( listitem )
			 {
				case 0: 
				{
					if(JobData[SWEEPER] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 1);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao cistac ulica!");
				}
				case 1: 
				{
					if(JobData[PIZZABOY] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 2);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao Raznosac pizza!");
				}
				case 2: 
				{
					if(JobData[MECHANIC] == OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendClientMessage( playerid, COLOR_RED, "Morate biti level 3+ za ovaj posao (treba vozilo)!");

					SetPlayerJob(playerid, 3);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao mehanicar!");
				}
				case 3: 
				{
					if(JobData[MOWER] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 4);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao kosac trave!");
				}
				case 4: 
				{
					if(JobData[CRAFTER] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 5);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao tvornicki radnik!");
				}
				case 5: 
				{
					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 3+ mogu biti taksisti.");
					if(JobData[TAXI] == OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 6);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao taksista!");
				}
				case 6: 
				{
					if(JobData[FARMER] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 7);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao farmer!");
				}
				case 7: 
				{
					if(JobData[LOGGER] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 14);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao drvosjeca!");
				}
				case 8: 
				{
					if(JobData[GARBAGE] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");

					SetPlayerJob(playerid, 16);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao smetlar!");
				}
				case 9:
				{
					if( PlayerInfo[ playerid ][ pLevel ] < 5 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 5+ mogu biti veh impounderi.");
					if(JobData[GARBAGE] == OFFICIAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");
					SetPlayerJob(playerid, 17);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao impounder!");
				}
				case 10:
				{
					if(JobData[GARBAGE] == NORMAL_JOBS_EMPLOYERS)
						return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Ova firma trenutno ne prima radnike, pokusajte kada bude slobodnih mjesta.");
					SetPlayerJob(playerid, 18);
					SendMessage( playerid, MESSAGE_TYPE_INFO, "Zaposlili ste se kao transporter!");
				}
			}
			// Set FreeWorks
			if(PlayerInfo[playerid][pDonateRank] == 0)
				PlayerInfo[playerid][pFreeWorks] = NORMAL_FREE_WORKS;	
			else if(PlayerInfo[playerid][pDonateRank] == 1)
				PlayerInfo[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 2)
				PlayerInfo[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 3)
				PlayerInfo[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
			else if(PlayerInfo[playerid][pDonateRank] == 4)
				PlayerInfo[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
				
			return (true);
		}
		case DIALOG_IJOBS: {
			if(!response) return (true);
			switch(listitem) {
				case 0: {
					if( PlayerInfo[ playerid ][ pLevel ] < 3 ) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Samo igraci level 3+ mogu biti lopovi.");
					PlayerInfo[ playerid ][ pJob ] 			= 9;
					if(PlayerInfo[playerid][pDonateRank] == 0)
						PlayerInfo[playerid][pFreeWorks] = NORMAL_FREE_WORKS;	
					else if(PlayerInfo[playerid][pDonateRank] == 1)
						PlayerInfo[playerid][pFreeWorks] = BRONZE_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 2)
						PlayerInfo[playerid][pFreeWorks] = SILVER_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 3)
						PlayerInfo[playerid][pFreeWorks] = GOLD_DONATOR_FREE_WORKS;
					else if(PlayerInfo[playerid][pDonateRank] == 4)
						PlayerInfo[playerid][pFreeWorks] = PLATINUM_DONATOR_FREE_WORKS;
					SendClientMessage( playerid, COLOR_RED, "[ ! ] Zaposlili ste se kao lopov!");
				}
			}
		}
		case DIALOG_JOBHELP: {
			if(!response) return (true);
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
    				strcat(jstring, "Posao ima dvije mogucnosti: prevoz teretne prikolice kamionom i prevoz produkata kombijem.\nObe se mogucnosti svode na preuzimanje produkata i njihovu dostavu biznisima.\n");
    				strcat(jstring, "Za dostavu kamionom koristite komandu /trucker koja vam automatski nudi listu svih raspolozivih komandi.\nKamion uzimate na dvije lokacije (/gps -> Angel Pine trucks ili Desert trucks).\n");
					strcat(jstring, "Prije svega, vazno je znati koja rutu mozete voziti sa kojim skillom i sa kojom prikolicom. Da bi to doznali, koristite /trucker info\n");
    				strcat(jstring, "Nakon sjedanja u kamion, odaberite teretnu prikolicu pogodnu za rutu koju cete odraditi komandom /trucker start.\nMorate pokupiti produkte u tvornici oznacenoj na lokaciji koje kasnije dostavljate biznisima.\n");
    				strcat(jstring, "Posao mozete zaustaviti u bilo kojem trenutku komandom /trucker stop.\n");
    				strcat(jstring, "Za bolji ugodjaj, motorolom mozete komunicirati sa svim prisutnim kamiondzijama, /tc komanda.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TRUCKER", jstring, "U redu", "");
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
    				strcat(jstring, "Kod ovog posla imate jednu osnovnu komandu, a to je /drug, ona vam ispise sve potrebne komande.\n\n");
    				strcat(jstring, "Sa ovim poslom mozete saditi marihuanu na nekom vasem tajnom mjestu, ali prethodno morate kupiti sjemenke u East Los Santos.\n");
    				strcat(jstring, "Takodje, mozete kuvati metamfetamin u svojoj kuci, ali naravno morate uzeti u Magic Shop klorovodicnu kiselinu, mravlju kiselinu i klorovodicni hidroksid.\n");
    				strcat(jstring, "Pored ove dvije droge koje mozete praviti/uzgajati, takodje imate opciju da pravite crack,\nali za ovu drogu morate imati kokain (Ilegalni trucker) i naravno uzeti u Magic Shop sodu bikarbonu kako bi mogli pomjesati.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "DRUG-DEALER", jstring, "U redu", "");
    			}
    			case 11: {
    				strcat(jstring, "Komanda kojom vas zaposljavaju je /trucker hire. Narko bossovi mogu birati izmedju kokaina/heroina/ekstazija.\n\n");
    				strcat(jstring, "Roba dolazi svakih tjedan dana, te svaka mafija ima pravo uzeti jednaku kolicinu.\n");
    				strcat(jstring, "Nije potreban proces proizvodnje. Potreban je igrac sa kljucevima Warehousea/Leader koji narucuje transport od vas.\n");
    				strcat(jstring, "Novac iz Warehousea se skida pri istovaru, a Warehouse dobiva odredjenu kolicinu narucene droge.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "ILLEGAL TRUCKER(Drug Smuggler)", jstring, "U redu", "");
    			}
    			case 12: {
    				strcat(jstring, "Sjediste ovog posla jeste kao mehanicarska garaza koja se nalazi na Ocean Docks.\n\n");
    				strcat(jstring, "U njoj se nalazi tabla sa vozilima koja su potrebna da se ukradu.\n");
    				strcat(jstring, "Koristite komandu /jacker gdje imate pick da izaberete vozilo, chop da isjecete vozilo kad ga dovucete, leave da napustite misiju i stop da pauzirate misiju.\n");
    				strcat(jstring, "Kad zavrsite sa rastavljanjem vozila, budete isplaceni zavisno od vozila do vozila od strane te garaze.\n");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "CAR-JACKER", jstring, "U redu", "");
    			}
    			case 13: {
    				strcat(jstring, "Lokacija ovog posla je Civic Center, u blizini LSPD stanice.\n\n");
    				strcat(jstring, "Ovaj posao je ilegalan, svakoga koga policija uhvati u obavljanju ovog cina ima pravo uhapsiti.\n");
    				strcat(jstring, "Zbog opisa posla i opasnosti da budete uhvaceni od strane policije ili vlasnika kuca koje pljackate, prihodi su malo veci od ostalih poslova.\n");
    				strcat(jstring, "Za dzeparenje igraca koristite komandu /pocketsteal, gdje mozete igracu ukrasti pare, sat i telefon iz dzepa.\n");
    				strcat(jstring, "Komande i skill leveli koji su vam potrebni za obijanje kuce su sljedeci:\n\n");
    				strcat(jstring, "Pljackanje kuce > skill level 2\n/crack_alarm /stealitems /dropitem /takeitem /picklock\n\n");
    				strcat(jstring, "Pljackanje para u kuci > skill level 3\n/stealmoney\n\n");
    				strcat(jstring, "Obijanje sefa u kuci > skill level 4\n/breaksafe /stealsafe\n\n");
    				strcat(jstring, "Kada zavrsite sa kradjom, stvari nosite u East Los Santos iza Car Wash. Provjera ukradenih stvari: /stolengoods, prodaja stvari /sellgoods.");
    				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "LOPOV", jstring, "U redu", "");
    			}
    		}
    	}
    	case DIALOG_FARMERHELP: {
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

/*
	- Commands
*/

CMD:jobhelp(playerid, params[]) {
	ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_LIST, "JOB-HELP", "Kosac trave\n\
		Tvornicki radnik\n\
		Cistac ulice\n\
		Smecar\n\
		Trucker\n\
		Drvosjeca\n\
		Mehanicar\n\
		Pizza Boy\n\
		Farmer\n\
		Taksista\n\
		Gun dealer\n\
		Car jacker\n\
		Lopov", "(odaberi)", "(x)"
	);
	return (true);
}

CMD:jobcmds(playerid, params[]) {
	switch(PlayerInfo[playerid][pJob])
	{
		case 1: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t CISTAC ULICA: /sweep");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 2: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t PIZZA BOY: /pizza");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 3: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");		
			SendClientMessage(playerid, -1, "\t MEHANICAR: 'Y - otvaranje garaze' - /repair - /parts - /armorcar");
			SendClientMessage(playerid, -1, "\t MEHANICAR: /mechanic - /tow");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 4: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t KOSAC TRAVE: /mow");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 5: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t TVORNICKI RADNIK: /craft");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 6: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t TAKSIST: /taxi");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 7: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");			
			SendClientMessage(playerid, -1, "\t FARMER: /work - /finish - /takebucket - /dropbucket - /milk - /dropcanister");
			SendClientMessage(playerid, -1, "\t FARMER: /seeds - /attach_trailer - /detach_trailer - /plant");
			SendClientMessage(playerid, -1, "\t FARMER: /takespade - /dropspade - /checkplant - /harvest - /crops");
			SendClientMessage(playerid, -1, "\t FARMER: /takecarton - /dropcarton - /eggs");
			SendClientMessage(playerid, -1, "\t FARMER: /transport - /stoptransport");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 9: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t LOPOV: /stolengoods - /pocketsteal - /sellgoods - /picklock - /doorram");
			SendClientMessage(playerid, -1, "\t LOPOV: /crack_alarm - /stealitems - /dropitem - /takeitem - /stealmoney");
			SendClientMessage(playerid, -1, "\t HOUSE: /gunrack_rob(gunrack) - /storage_rob(drugs)");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 13: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");			
			SendClientMessage(playerid, -1, "\t CAR JACKER: /jacker - /igarage");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 14: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");		
			SendClientMessage(playerid, -1, "\t DRVOSJECA: /cuttree - /stopcuttree - /treeinfo - /putwood - /checkvehwood");
			SendClientMessage(playerid, -1, "\t DRVOSJECA: /checkmywood - /pickupwood - /takewood - /sellwood");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 16: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t SMETLAR: /garbage");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 17:
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t IMPOUNDER: /jobimpound - /stopimpound - /tow");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		case 18:
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* _______________________ JOB COMMANDS _______________________ *");
			SendClientMessage(playerid, -1, "\t TRANSPORTER: /transporter");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ______________________________________________________________ *");
		}
		default:
			SendMessage(playerid, MESSAGE_TYPE_ERROR, "Nemate posao!");
	}
	return 1;
}

CMD:takejob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 0) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Imate posao, koristite /quitjob!");
	if( IsACop(playerid) || IsFDMember(playerid) || IsASD(playerid) || IsAGov(playerid) ) return SendClientMessage( playerid, COLOR_RED, "Ne smijete biti u organizaciji!");
	
	if( IsPlayerInRangeOfPoint(playerid, 7.0, 1617.5137,-1560.1582,14.1662) )
		ShowPlayerDialog(playerid, DIALOG_IJOBS, DIALOG_STYLE_LIST, "ILEGALNI POSLOVI", "Lopov", "Odaberi", "Odustani");
	else if( IsPlayerInRangeOfPoint(playerid, 5.0, 1301.4661, 764.3820, -98.6427) )
		ShowPlayerDialog(playerid, DIALOG_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "{3C95C2}* Lista i kvote poslova", JobsList(), "Odaberi", "Odustani");
		
	else SendMessage(playerid, MESSAGE_TYPE_ERROR, "Niste blizu mjesta za uzimanje posla!");
	return (true);
}

CMD:quitjob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 0) return SendClientMessage( playerid, COLOR_RED, "Nemate posao!");
	if(PlayerInfo[playerid][pFreeWorks] < 15) return SendMessage(playerid, MESSAGE_TYPE_ERROR, "Pricekajte PayDay i NE radite ture da mozete dati otkaz na svome poslu!");
	switch( PlayerInfo[playerid][pDonateRank]) {
		case 0: {
			if(PlayerInfo[playerid][pContractTime] >= 5) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 5 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 5 - PlayerInfo[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 1: {
			if(PlayerInfo[playerid][pContractTime] >= 2) {
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 2 sata ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
			} else {
				new chours = 2 - PlayerInfo[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 2: {
			if(PlayerInfo[playerid][pContractTime] >= 1)
			{
				SendMessage(playerid, MESSAGE_TYPE_INFO, "Vec ste ispunili vas 1 sat ugovora, i dali ste otkaz na poslu.");
				RemovePlayerJob(playerid);
				PlayerInfo[playerid][pContractTime] = 0;
			} else {
				new chours = 2 - PlayerInfo[playerid][pContractTime];
				SendFormatMessage(playerid, MESSAGE_TYPE_INFO, "Jos imate %d sati rada da bi ste ispunili svoj ugovor i dali otkaz.", chours);
			}
		}
		case 3,4: {
			SendMessage(playerid, MESSAGE_TYPE_INFO, "Dali ste otkaz na poslu.");
			RemovePlayerJob(playerid);
		}
	}
	return (true);
}
