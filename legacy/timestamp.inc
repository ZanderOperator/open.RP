//AbyssMorgan
//%d:%02d:%02d:%02d (day hour minute second) 
#define SecToTimeDay(%0)            ((%0) / 86400),(((%0) % 86400) / 3600),((((%0) % 86400) % 3600) / 60),((((%0) % 86400) % 3600) % 60) 
#define MSToTimeDay(%0)                SecToTimeDay((%0)/1000) 

//%02d:%02d:%02d (hour minute second) 
#define SecToTime(%0)                ((%0) / 3600),(((%0) % 3600) / 60),(((%0) % 3600) % 60) 
#define MSToTime(%0)                SecToTime((%0)/1000) 

//%02d:%02d (minute second) 
#define SecToTimeMini(%0)            ((%0) / 60),((%0) % 60) 
#define MSToTimeMini(%0)            SecToTimeMini((%0)/1000)  



static stock const
	SECONDS_PER_MINUTE		= 60,
	SECONDS_PER_HOUR		= 3600,
	SECONDS_PER_DAY			= 86400,
	SECONDS_PER_YEAR		= 31556952,	// based on 365.2425 days per year
	monthdays[12]			= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
	//monthnames[12]			= {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"},
	weekdays[7][10] = {"Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};

stock stamp2datetime(sec1970, &year=0, &month=0, &day=0, &hour=0, &minute=0, &second=0, gmh = 0, gmm = 0) {
	new days, seconds;

	for(year = 1970; ; year += 1) {
		days = (365 + (!(year & 0x03) ? 1 : 0)); // Will fail for 2100
		seconds = days * SECONDS_PER_DAY;
		if(seconds > sec1970)
			break;
		sec1970 -= seconds;
	}

	for(month = 1; ; month += 1) {
		days = monthdays[month - 1];
		seconds = days * SECONDS_PER_DAY;
		if(seconds > sec1970)
			break;
		sec1970 -= seconds;
	}

	for(day = 1; sec1970 >= SECONDS_PER_DAY; day += 1)
		sec1970 -= SECONDS_PER_DAY;

	for(hour = gmh; sec1970 >= SECONDS_PER_HOUR; hour += 1)
		sec1970 -= SECONDS_PER_HOUR;

	for(minute = gmm; sec1970 >= SECONDS_PER_MINUTE; minute += 1)
		sec1970 -= SECONDS_PER_MINUTE;

	second = sec1970;
}

stock datetime2stamp(&sec1970, year, month, day, hour, minute, second, gmh = 0, gmm = 0) {
	for(new y = 1970; y < year; y++)
        day += (365 + (!(y & 0x03) ? 1 : 0));

	for(new m = 1; m < month; m++)
		day += monthdays[m - 1];

    if(!(year & 0x03) && month > 2)
        day += 1;
    day -= 1;
	
    sec1970 += (day * SECONDS_PER_DAY);
    sec1970 += ((hour + gmh) * SECONDS_PER_HOUR);
    sec1970 += ((minute + gmm) * SECONDS_PER_MINUTE);
    sec1970 += second;

    return sec1970;
}

stock weekday(day, month, year) {
    if(month <= 2) {
        month += 12;
		--year;
	}
    new j = year % 100;
    new e = year / 100;
    return ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7);
}

stock SecondsInTime(&sec1970, year, month, day, hour, minute, second) {
    sec1970 += (year * SECONDS_PER_YEAR);
    sec1970 += (month * SECONDS_PER_DAY * 30);
    sec1970 += (day * SECONDS_PER_DAY);
    sec1970 += (hour * SECONDS_PER_HOUR);
    sec1970 += (minute * SECONDS_PER_MINUTE);
    sec1970 += second;
	
    //sec1970 += (y * 31556952) + (m * 2592000) + (d * 86400) + (h * 3600) + (i * 60) + s;
}

stock TimeInSeconds(sec1970, &year, &month, &day, &hour, &minute, &second) {
	#define MINUTES_IN_HOUR 60
	#define HOURS_IN_DAY 24
	#define DAYS_IN_WEEK 7
	#define DAYS_IN_MONTH 30
	#define DAYS_IN_YEAR 365.2425

	second = sec1970 % SECONDS_PER_MINUTE;
	sec1970 /= SECONDS_PER_MINUTE;
	minute = sec1970 % MINUTES_IN_HOUR;
	sec1970 /= MINUTES_IN_HOUR;
	hour = sec1970 % HOURS_IN_DAY;
	sec1970 /= HOURS_IN_DAY;
	day = sec1970 % DAYS_IN_WEEK;
	sec1970 /= DAYS_IN_WEEK;
	//week = sec1970 & WEEKS_IN_MONTH;
	month = sec1970 / WEEKS_IN_MONTH;
	year = floatround(sec1970 / DAYS_IN_YEAR, floatround_floor);
	
	/*seconds = sec1970 % SECONDS_PER_MINUTE;
	minutes = sec1970 / SECONDS_PER_MINUTE % MINUTES_IN_HOUR;
	hours = sec1970 / SECONDS_PER_MINUTE / MINUTES_IN_HOUR % HOURS_IN_DAY;
	days = sec1970 / SECONDS_PER_MINUTE / MINUTES_IN_HOUR / HOURS_IN_DAY;*/
}
