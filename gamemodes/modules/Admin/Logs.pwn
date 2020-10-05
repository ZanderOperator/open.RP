#if defined MODULE_LOGS
	#endinput
#endif
#define MODULE_LOGS

stock LogAdminGiveMoney(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_givemoney.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogSetStatConnectedTime(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_setstat_connectedtime.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminBan(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_ban.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminUnPrison(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_unprison.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminCharge(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_charge.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminJail(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_jail.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminUnJail(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_unjail.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminUnban(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_unban.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminSetTeam(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_setteam.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminMessage(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_adminmessage.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogHelperMessage(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_helpermessage.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminChat(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_adminchat.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAdminKick(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_kick.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogPM(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_pm.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
} 

stock BankLog(string[])
{
	new
	    entry[256],
		month,
		day,
		year,
		hours,
		minutes,
		secs;
	getdate(year, month, day);
	gettime(hours, minutes, secs);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d , %02d:%02d:%02d] %s", day, month, year, hours, minutes, secs, string);
	new File:hFile;
	hFile = fopen("/logfiles/bank.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
} 

stock PayLog(string[])
{
	new
	    entry[256],
		month,
		day,
		year,
		hours,
		minutes,
		secs;
	getdate(year, month, day);
	gettime(hours, minutes, secs);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d , %02d:%02d:%02d] %s", day, month, year, hours, minutes, secs, string);
	new File:hFile;
	hFile = fopen("/logfiles/pay.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock CharityLog(string[])
{
	new
	    entry[256],
		month,
		day,
		year,
		hours,
		minutes,
		secs;
	getdate(year, month, day);
	gettime(hours, minutes, secs);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d , %02d:%02d:%02d] %s", day, month, year, hours, minutes, secs, string);
	new File:hFile;
	hFile = fopen("/logfiles/charity.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogAReport(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_report.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
} 

stock LogBizBank(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_biznis.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
} 

stock LogCarSell(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_carsell.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogCarBuy(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_carbuy.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogGiveGun(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_givegun.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogHouseMoney(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/a_house_cash.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogNameChange(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/namechange.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogBudget(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/proracun.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogBuyHouse(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/buy_house.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogBuyBiznis(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/buy_biznis.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogBuyComplex(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);

	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	hFile = fopen("/logfiles/buy_complex.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
stock LogMask(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/masks.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogKills(string[])
{
	new
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	hFile = fopen("/logfiles/kills.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogConnects(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	hFile = fopen("/logfiles/connects.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogGuns(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/dealer_guns.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogPDTrunk(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/pd_taketrunk.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogCreditPay(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/credit_pay.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogCarDelete(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);
	
	hFile = fopen("/logfiles/car_delete.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogCarDeath(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second,
		File:hFile;

	getdate(year, month, day);
	gettime(hour, minute, second);

	#pragma unused year
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	hFile = fopen("/logfiles/car_death.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogFurnitureBuy(string[])
{
	new
	    entry[256],
		month,
		day,
		year;
	getdate(year, month, day);
	format(entry, sizeof(entry), "\n[%02d/%02d/%d] %s", day, month, year, string);
	new File:hFile;
	hFile = fopen("/logfiles/furniture_buy.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogMySQL(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/MySQL.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock Log_GPCI(string[])
{
	new
	    entry[256],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "\n[%02d/%02d/%d, %02d:%02d:%02d] %s", day, month, year, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/GPCI.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogPINEntry(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/pinlogins.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogMakeAdmin(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/a_makeah.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogInvite(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/orgs_invite.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogLeaders(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/orgs_leader.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogSecurity(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/a_security.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogBurglar(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/job_burglar.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

stock LogPDTakes(string[])
{
	new
	    entry[1024],
		month,
		day,
		year,
		hour,
		minute,
		second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	
	#pragma unused year
	
	format(entry, sizeof(entry), "\n[%02d/%02d, %02d:%02d:%02d] %s", day, month, hour, minute, second, string);

	new
		File:hFile;

	hFile = fopen("/logfiles/pd_housetakes.txt", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

//////////////////////////////////
stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024]
	;
	if ((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return 0;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return 1;
}
