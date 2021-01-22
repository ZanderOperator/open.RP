#include <YSI_Coding\y_hooks>

#define MAX_SUBJECTS_IN_RANGE			(15)

// Main Player/Commands/Action/Internal Security Logger
Log_Write(const path[], const str[], {Float,_}:...)
{
		
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024]
	;
	if((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if(!file)
	    return printf("[LOG ERROR]: File '%s' doesn't exist!", path);

	if(args > 8)
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

FormatNumber(number, prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if(prefix[0] != 0)
	    strins(value, prefix, 0);

	if(number < 0)
		strins(value, "-", 0);

	return value;
}

strreplace(sstring[], find, replace)
{
    for(new i=0; sstring[i] != EOS; i++) 
	{
        if(sstring[i] == find)
           sstring[i] = replace;
    }
}

strcount(const string[], const sub[], bool:ignorecase = false, bool:count_overlapped = false) 
{
	new
		increment = count_overlapped ? 1 : strlen(sub),
		pos = -increment,
		count = 0
	;
	
	
	while (-1 != (pos = strfind(string, sub, ignorecase, pos + increment)))
		count++;
	
	return count;
}


gettimestamp()
{
	new timestamp = gettime() + GMT_ZONE_DIFFERENCE;
	return timestamp;
}

GetServerTime(&hours=0, &minutes=0, &seconds=0)
{
	gettime(hours,minutes,seconds);
	hours += (GMT_ZONE_DIFFERENCE/3600);
	if(hours == 24) hours = 0;
	if(minutes <= 0) minutes = 0;
}

ReturnDate()
{
	new
	    date[36];

	getdate(date[2], date[1], date[0]);
	GetServerTime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d:%02d", date[0], date[1], date[2], date[3], date[4], date[5]);
	return date;
}

ReturnTime()
{
	new 
		time[12],
		tmphour, tmpmins, tmpsecs;
	GetServerTime(tmphour, tmpmins, tmpsecs);
	format(time, 12, "%s%d:%s%d:%s%d",
		(tmphour >= 10) ? ("") : ("0"),
		tmphour,
		(tmpmins >= 10) ? ("") : ("0"), 
		tmpmins,
		(tmpsecs >= 10) ? ("") : ("0"), 
		tmpsecs
	);
	return time;
}

CreateGangZoneAroundPoint(Float:X, Float:Y, Float:width, Float:height)
{
	new
		Float:minX = ( X - width  / 2),
		Float:minY = ( Y - height / 2),
		Float:maxX = ( X + width  / 2),
		Float:maxY = ( Y + height / 2);

	return GangZoneCreate(minX, minY, maxX, maxY);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock IsValidEMail(email[])
{
	if(strlen(email) < 2) return 0;
	//TraZimo '@' znak unutar teksta.
	new 
		strPos 			= 0,
		bool:haveMonkey = false;
	
	if(email[strPos] == '@') return 0; //'@' je odmah na prvome mjestu!
	while(email[strPos] != EOS) {
		if(email[strPos] == '@') {
			haveMonkey = true;
			break;
		}
		strPos++;
	}
	if(!haveMonkey) return 0;
	
	//Dali je valjan hostname dio e-maila
	
	new 
		bool:haveDomain = false;
		
		
	new const emailServices[7][12] = { "gmail.com", "net.hr", "yahoo.com", "hotmail.com", "gmx.com", "outlook.com", "msn.com" };
	
	for(new domainPos = 0; domainPos != 5; domainPos++)
	{		if(strfind(email, emailServices[domainPos], false) != -1) {
			haveDomain = true;
			break;
		}
	}
	if(haveDomain && haveMonkey) return 1;
	return 0;
}

stock IsValidNick(name[])
{
	new length = strlen(name),
		namesplit[2][MAX_PLAYER_NAME],
		FirstLetterOfFirstname,
		FirstLetterOfLastname,
		ThirdLetterOfLastname,
		Underscore;
	
	split(name, namesplit, '_');
    if(strlen(namesplit[0]) > 1 && strlen(namesplit[1]) > 1)
    {
        // Firstname and Lastname contains more than 1 character + it there are separated with '_' char. Continue...
    }
    else return 0; // No need to continue...

    FirstLetterOfFirstname = namesplit[0][0];
	if(FirstLetterOfFirstname >= 'A' && FirstLetterOfFirstname <= 'Z')
	{
        // First letter of Firstname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	FirstLetterOfLastname = namesplit[1][0];
    if(FirstLetterOfLastname >= 'A' && FirstLetterOfLastname <= 'Z')
    {
		// First letter of Lastname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	ThirdLetterOfLastname = namesplit[1][2];
    if(ThirdLetterOfLastname >= 'A' && ThirdLetterOfLastname <= 'Z' || ThirdLetterOfLastname >= 'a' && ThirdLetterOfLastname <= 'z')
    {
		// Third letter of Lastname can be uppercase and lowercase (uppercase for Lastnames like McLaren). Continue...
	}
	else return 0; // No need to continue...

    for(new i = 0; i < length; i++)
	{
		if(name[i] != FirstLetterOfFirstname && name[i] != FirstLetterOfLastname && name[i] != ThirdLetterOfLastname && name[i] != '_')
		{
			if(name[i] >= 'a' && name[i] <= 'z')
			{
				// Name contains only letters and that letters are lowercase (except the first letter of the Firstname, first letter of Lastname and third letter of Lastname). Continue...
			}
			else return 0; // No need to continue...
		}

		// This checks that '_' char can be used only one time (to prevent names like this Firstname_Lastname_Something)...
		if(name[i] == '_')
		{
			Underscore++;
			if(Underscore > 1) return 0; // No need to continue...
		}
	}
	return 1; // All check are ok, Name is valid...
}

minrand(min, max) 
{
    return random(max - min) + min;
}

IsNumeric(const string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if(string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

UnixTimestampToTime(timestamp, compare = -1) 
{
    if(compare == -1) {
        compare = gettimestamp();
    }
    new
        n,
		Float:d = (timestamp > compare) ? timestamp - compare : compare - timestamp,
        returnstr[32];
    if(d < 60) {
        format(returnstr, sizeof(returnstr), "< 1 minute");
        return returnstr;
    } else if(d < 3600) {
        n = floatround(floatdiv(d, 60.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "minuta");
    } else if(d < 86400) {
        n = floatround(floatdiv(d, 3600.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "sat(i)");
    } else if(d < 2592000) {
        n = floatround(floatdiv(d, 86400.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "dan(a)");
    } else if(d < 31536000) {
        n = floatround(floatdiv(d, 2592000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "mjesec");
    } else {
        n = floatround(floatdiv(d, 31536000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "godina");
    }
    if(n == 1) {
        format(returnstr, sizeof(returnstr), "1 %s", returnstr);
    } else {
        format(returnstr, sizeof(returnstr), "%d %ss", n, returnstr);
    }
    return returnstr;
}

CheckStringForIP(text[])
{
	new
			string[16], position, ipnum[4];
	new
			delimiters[] =
			{
				'.', ',', '*', ':', ';', '|',
				'_', '-', '~', '/', '^', ' ',
				EOS
	};
	while(text[position])
	{
		for(new a = 0; delimiters[a] != EOS; a++)
		{
			format(string, 16, "p<%c>iiii", delimiters[a]);
			if(!sscanf(text[position], string, ipnum[0], ipnum[1], ipnum[2], ipnum[3]))
			{
				if(ipnum[0] >= 0 && ipnum[0] <= 255 && ipnum[1] >= 0 && ipnum[1] <= 255
				&& ipnum[2] >= 0 && ipnum[2] <= 255 && ipnum[3] >= 0 && ipnum[3] <= 255)
					return true;
			}
		}
		position++;
	}
	return false;
}

CheckStringForURL(text[])
{
	new
		URL_Advert[21][] =
		{
			{	"http://"	},
			{	"www."		},
			{	".com"		},
			{	".net"		},
			{	".org"		},
			{	".info"		},
			{	".biz"		},
			{	".eu"		},
			{	".us"		},
			{	".me"		},
			{	".mobi"		},
			{	".ca"		},
			{	".ws"		},
			{	".cc"		},
			{	".tk"		},
			{	".tw"		},
			{	".hr"		},
			{	".ba"		},
			{	".si"		},
			{	".sr"		},
			{	".mk"		}
		};
	for(new a = 0; a < sizeof(URL_Advert); a++)
	{
		if(strfind(text, URL_Advert[a], true) != -1)
			return true;
	}
	return false;
}

IsSafeForTextDraw(str[])
{
	new safetil = -5;
	for (new i = 0; i < strlen(str); i++) 
	{
		if((str[i] == 126) && (i > safetil))
		{
			if(i >= strlen(str) - 1) // not enough room for the tag to end at all. 
				return false;
			if(str[i + 1] == 126)
				return false; // a tilde following a tilde.
			if(str[i + 2] != 126)
				return false; // a tilde not followed by another tilde after 2 chars
			safetil = i + 2; // tilde tag was verified as safe, ignore anything up to this location from further checks (otherwise it'll report tag end tilde as improperly started tag..).
		}
	}
	return true;
}

stock GetXYInFrontOfObject(objectid, &Float:x, &Float:y, Float:distance, bool:rotation = false)
{
    new
        Float:z,
		Float:a,
		Float:rx,
		Float:ry;

	GetDynamicObjectPos(objectid, x, y, z);
	GetDynamicObjectRot(objectid, rx, ry, a);

	#pragma unused rx
	#pragma unused ry
	#pragma unused z

	switch(rotation)
	{
	    case false:
	    {
	    	x -= (distance * floatsin(-a, degrees));
   			y -= (distance * floatcos(-a, degrees));
	    }
	    case true:
	    {
    		x += (distance * floatsin(-a, degrees));
   			y += (distance * floatcos(-a, degrees));
	    }
	}
}

stock randomEx(min, max)
    return random(max - min) + min;

enum E_CLOSEST_SUBJECTS
{
	cID,
	Float:cDistance
}
SortNearestRangeID(v[MAX_SUBJECTS_IN_RANGE][E_CLOSEST_SUBJECTS], pool_size)
{
	new tmp = INVALID_VEHICLE_ID, bool:swapped;
	do
	{
		swapped = false;
		for(new i=1; i < pool_size; i++) 
		{
			if(v[i-1][cDistance] > v[i][cDistance]) 
			{
				tmp = v[i][cID];
				v[i][cID] = v[i-1][cID];
				v[i-1][cID] = tmp;
				swapped = true;
			}
		}
	} while(swapped);
}