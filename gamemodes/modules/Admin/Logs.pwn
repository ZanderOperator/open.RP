
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
	    return printf("[LOG ERROR]: File '%s' doesn't exist!", path);

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
