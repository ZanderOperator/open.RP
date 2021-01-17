#include <YSI_Coding\y_hooks>

#define MAX_SUBJECTS_IN_RANGE			(15)

// Main Player/Commands/Action/Internal Security Logger
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

FormatNumber(number, prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}

stock abs(int)
{
    if (int < 0)
        return -int;
    else
        return int;
}

stock strreplace(sstring[], find, replace)
{
    for(new i=0; sstring[i] != EOS; i++) 
	{
        if(sstring[i] == find)
           sstring[i] = replace;
    }
}

stock StringReverse(const string[], dest[], len = sizeof (dest))
{
	new
		i = strlen(string),
		j = 0;
	if (i >= len)
	{
		i = len - 1;
	}
	while (i--)
	{
		dest[j++] = string[i];
	}
	dest[j] = '\0';
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

/*
	##     ## ######## #### ##        ######  
	##     ##    ##     ##  ##       ##    ## 
	##     ##    ##     ##  ##       ##       
	##     ##    ##     ##  ##        ######  
	##     ##    ##     ##  ##             ## 
	##     ##    ##     ##  ##       ##    ## 
	 #######     ##    #### ########  ######  
*/

stock gettimestamp()
{
	new timestamp = gettime() + GMT_ZONE_DIFFERENCE;
	return timestamp;
}

stock GetServerTime(&hours=0, &minutes=0, &seconds=0)
{
	gettime(hours,minutes,seconds);
	hours += (GMT_ZONE_DIFFERENCE/3600);
	if(hours == 24) hours = 0;
	if(minutes <= 0) minutes = 0;
}

stock ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	GetServerTime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d:%02d", date[0], date[1], date[2], date[3], date[4], date[5]);
	return date;
}

stock ReturnTime()
{
	new time[12];
	new tmphour, tmpmins, tmpsecs;
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

stock wait(ms)
{
    ms += GetTickCount();
    while(GetTickCount() < ms) {}
}

stock BubbleSort(a[], size)
{
	new tmp=0, bool:swapped;

	do
	{
		swapped = false;
		for(new i=1; i < size; i++) {
			if(a[i-1] > a[i]) {
				tmp = a[i];
				a[i] = a[i-1];
				a[i-1] = tmp;
				swapped = true;
			}
		}
	} while(swapped);
}

CreateGangZoneAroundPoint(Float:X, Float:Y, Float:width, Float:height)
{
	new
		Float:minX = ( X - width  / 2 ),
		Float:minY = ( Y - height / 2 ),
		Float:maxX = ( X + width  / 2 ),
		Float:maxY = ( Y + height / 2 );

	return GangZoneCreate(minX, minY, maxX, maxY);
}

/*
stock SetObjectFaceCoords3D(iObject, Float: fX, Float: fY, Float: fZ, Float: fRollOffset = 0.0, Float: fPitchOffset = 0.0, Float: fYawOffset = 0.0) 
{
	new
		Float: fOX,
		Float: fOY,
		Float: fOZ,
		Float: fPitch
	;
	GetDynamicObjectPos(iObject, fOX, fOY, fOZ);
	
	fPitch = floatsqroot(floatpower(fX - fOX, 2.0) + floatpower(fY - fOY, 2.0));
	fPitch = floatabs(atan2(fPitch, fZ - fOZ));
	
	fZ = atan2(fY - fOY, fX - fOX) - 90.0; // Yaw
	
	SetDynamicObjectRot(iObject, fRollOffset, fPitch + fPitchOffset, fZ + fYawOffset);
}
*/

stock GetXYInFrontOfPoints(&Float:x, &Float:y, Float:angle, Float:distance)
{	
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock GetXYBehindVehicle(vehicleid, &Float:x2, &Float:y2, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, x2, y2, a);
    GetVehicleZAngle(vehicleid, a);
    x2 += (distance * floatsin(-a+180, degrees));
    y2 += (distance * floatcos(-a+180, degrees));
}

stock GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
}

stock SendErrorMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_ERROR, smsgstring);
}

stock SendInfoMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_INFO, smsgstring);
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

stock SendSplitMessage(playerid, color, const msgstring[])
{
    new len = strlen(msgstring);
    if(len >= EX_SPLITLENGTH)
    {
		new buffer[EX_SPLITLENGTH+10],
			colorstring[9] = EOS, colorstart = 0, colorend = 0,	
			buffer2[128], spacepos = 0, bool:broken = false;

		for(new j = 60; j < len; j++)
		{
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(msgstring[j] == ' ')
				spacepos = j;

			if(j >= EX_SPLITLENGTH && spacepos >= 60 && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;
				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));
				strmid(buffer, msgstring, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessage(playerid, color, buffer);
				strmid(buffer2, msgstring, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "%s...%s", colorstring, buffer2);
				SendClientMessage(playerid, color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessage(playerid, color, msgstring);
	}
    else return SendClientMessage(playerid, color, msgstring);
	return 1;
}

stock SendSplitMessageToAll(color, const msgstring[])
{
    new len = strlen(msgstring);
    if(len >= EX_SPLITLENGTH)
    {
		new buffer[EX_SPLITLENGTH+10],
			colorstring[9] = EOS, colorstart = 0, colorend = 0,	
			buffer2[128], spacepos = 0, bool:broken=false;

		for(new j = 60; j < len; j++)
		{
			if(msgstring[j] == ' ')
				spacepos = j;
			
			if(msgstring[j] == '{')
				colorstart = j;
				
			if(msgstring[j] == '}')
				colorend = j + 1;

			if(j >= EX_SPLITLENGTH && spacepos >= 60 && (colorstart == 0 || (colorstart != 0 && colorend > colorstart)))
			{
				broken = true;
				if(colorstart != 0 && colorend != 0)
					strmid(colorstring, msgstring, colorstart, colorend, sizeof(colorstring));
				strmid(buffer, msgstring, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessageToAll(color, buffer);
				strmid(buffer2, msgstring, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "%s...%s", colorstring, buffer2);
				SendClientMessageToAll(color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessageToAll(color, msgstring);
	}
    else return SendClientMessageToAll(color, msgstring);
	return 1;
}

stock AC_SendClientMessageToAll(color, const message[])
{
	SendSplitMessageToAll(color, message);
	return 1;
}
#if defined _ALS_SendClientMessageToAll
    #undef SendClientMessageToAll
#else
    #define _ALS_SendClientMessageToAll
#endif
#define SendClientMessageToAll AC_SendClientMessageToAll

stock AC_SendClientMessage(playerid, color, const message[])
{
	SendSplitMessage(playerid, color, message);
	return 1;
}
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage AC_SendClientMessage

/*
stock va_SendClientMessage(playerid, colour, const fmat[], va_args<>)
{
	return SendClientMessage(playerid, colour, va_return(fmat, va_start<3>));
}

stock va_SendClientMessageToAll(colour, const fmat[], va_args<>)
{
	return SendClientMessageToAll(colour, va_return(fmat, va_start<2>));
}*/

stock va_ShowPlayerDialog(playerid, dialogid, style, caption[], fmat[], button1[], button2[], va_args<>)
{
	new d_string[4096];
	va_format(d_string, sizeof(d_string), fmat, va_start<7>);
	return ShowPlayerDialog(playerid, dialogid, style, caption, d_string, button1, button2);
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
    if (strlen(namesplit[0]) > 1 && strlen(namesplit[1]) > 1)
    {
        // Firstname and Lastname contains more than 1 character + it there are separated with '_' char. Continue...
    }
    else return 0; // No need to continue...

    FirstLetterOfFirstname = namesplit[0][0];
	if (FirstLetterOfFirstname >= 'A' && FirstLetterOfFirstname <= 'Z')
	{
        // First letter of Firstname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	FirstLetterOfLastname = namesplit[1][0];
    if (FirstLetterOfLastname >= 'A' && FirstLetterOfLastname <= 'Z')
    {
		// First letter of Lastname is capitalized. Continue...
	}
	else return 0; // No need to continue...

	ThirdLetterOfLastname = namesplit[1][2];
    if (ThirdLetterOfLastname >= 'A' && ThirdLetterOfLastname <= 'Z' || ThirdLetterOfLastname >= 'a' && ThirdLetterOfLastname <= 'z')
    {
		// Third letter of Lastname can be uppercase and lowercase (uppercase for Lastnames like McLaren). Continue...
	}
	else return 0; // No need to continue...

    for(new i = 0; i < length; i++)
	{
		if (name[i] != FirstLetterOfFirstname && name[i] != FirstLetterOfLastname && name[i] != ThirdLetterOfLastname && name[i] != '_')
		{
			if(name[i] >= 'a' && name[i] <= 'z')
			{
				// Name contains only letters and that letters are lowercase (except the first letter of the Firstname, first letter of Lastname and third letter of Lastname). Continue...
			}
			else return 0; // No need to continue...
		}

		// This checks that '_' char can be used only one time (to prevent names like this Firstname_Lastname_Something)...
		if (name[i] == '_')
		{
			Underscore++;
			if (Underscore > 1) return 0; // No need to continue...
		}
	}
	return 1; // All check are ok, Name is valid...
}

ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5, bool:isDualChat = false)
{

	new Float:posx,
		Float:posy,
		Float:posz,
		Float:oldposx,
		Float:oldposy,
		Float:oldposz,
		Float:tempposx,
		Float:tempposy,
		Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

	foreach (new i : Player)
	{
		if(isDualChat == true && i == playerid)
			continue;

		
		if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)) {
			GetPlayerPos(i, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
			{
				SendClientMessage(i, col1, string);
			}
			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
			{
				SendClientMessage(i, col2, string);
			}
			else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
			{
				SendClientMessage(i, col3, string);
			}
			else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
			{
				SendClientMessage(i, col4, string);
			}
			else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				SendClientMessage(i, col5, string);
			}
		}
	}
	return 1;
}

RealProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx,
		    Float:posy,
			Float:posz,
		    Float:oldposx,
		    Float:oldposy,
			Float:oldposz,
		    Float:tempposx,
			Float:tempposy,
			Float:tempposz,
			vehicleid = GetPlayerVehicleID(playerid),
			modelid = GetVehicleModel(vehicleid),
			vehicleid2,
			modelid2;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach (new i : Player)
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);

				if(IsPlayerInAnyVehicle(playerid) && !IsACabrio(modelid) && !Bit1_Get( gr_VehicleWindows, vehicleid ))
				{
					if(IsPlayerInVehicle(i, vehicleid))
					{
						SendClientMessage(i,col1,string); //skoci
					}
				}
				else
				{
					vehicleid2 = GetPlayerVehicleID(i);
					modelid2 = GetVehicleModel(vehicleid2);

					if(!IsPlayerInAnyVehicle(i) || IsACabrio(modelid2) || Bit1_Get( gr_VehicleWindows, vehicleid2 )) {
						if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SendClientMessage(i, col1, string);
						}
						else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SendClientMessage(i, col2, string);
						}
						else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SendClientMessage(i, col3, string);
						}
						else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SendClientMessage(i, col4, string);
						}
						else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SendClientMessage(i, col5, string);
						}
					}
				}
			}
		}
	}
	return 1;
}

minrand(min, max) //By Alex "Y_Less" Cole
{
    return random(max - min) + min;
}

IsNumeric(const string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

UnixTimestampToTime(timestamp, compare = -1) 
{
    if (compare == -1) {
        compare = gettimestamp();
    }
    new
        n,
		Float:d = (timestamp > compare) ? timestamp - compare : compare - timestamp,
        returnstr[32];
    if (d < 60) {
        format(returnstr, sizeof(returnstr), "< 1 minute");
        return returnstr;
    } else if (d < 3600) {
        n = floatround(floatdiv(d, 60.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "minuta");
    } else if (d < 86400) {
        n = floatround(floatdiv(d, 3600.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "sat(i)");
    } else if (d < 2592000) {
        n = floatround(floatdiv(d, 86400.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "dan(a)");
    } else if (d < 31536000) {
        n = floatround(floatdiv(d, 2592000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "mjesec");
    } else {
        n = floatround(floatdiv(d, 31536000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "godina");
    }
    if (n == 1) {
        format(returnstr, sizeof(returnstr), "1 %s", returnstr);
    } else {
        format(returnstr, sizeof(returnstr), "%d %ss", n, returnstr);
    }
    return returnstr;
}

PlayerPlayTrackSound(playerid)
{
	defer StopPlayerTrackSound(playerid);
	PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
}

stock CarProxDetector(vehicleid, playerid, const string[], color)
{
	foreach(new i : Player) {
		if( IsPlayerInVehicle( i, vehicleid ) && i != playerid )
			SendClientMessage( playerid, color, string );
	}
	return 1;
}

stock HouseProxDetector(houseid, Float:radius, const string[], color)
{
	foreach(new i : Player) 
	{
		if( IsPlayerInRangeOfPoint(i, radius, HouseInfo[ houseid ][ hEnterX ], HouseInfo[ houseid ][ hEnterY ], HouseInfo[ houseid ][ hEnterZ ] ) )
			SendClientMessage(i, color, string);
	}
	return 1;
}

stock SendJobMessage(job, color, string[])
{
	foreach (new i : Player) 
	{
		if(PlayerJob[i][pJob] == job)
			SendClientMessage(i, color, string);
	}
}

stock ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		if( ( GetPlayerVehicleID(playerid) == GetPlayerVehicleID(targetid) ) && GetPlayerVehicleID(playerid) != 0 ) 
			return 1;
			
	    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid))
		{
			new Float:posx,
			    Float:posy,
				Float:posz,
			    Float:oldposx,
				Float:oldposy,
				Float:oldposz,
			    Float:tempposx,
				Float:tempposy,
				Float:tempposz;

			GetPlayerPos(playerid, oldposx, oldposy, oldposz);

			GetPlayerPos(targetid, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				return 1;
		}
	}
	return 0;
}

stock GetPlayerSpeed(playerid, bool:kmh)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); else GetPlayerVelocity(playerid,Vx,Vy,Vz);
    rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
    return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}

stock PlaySoundForPlayersInRange(soundid, Float:range, Float:x, Float:y, Float:z)
{
	foreach(new i: Player)
	{
	    if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,range,x,y,z))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}

stock CheckStringForIP(text[])
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

ConvertNameToSQLID(const playername[])
{
	new 
		sqlid = -1,
		Cache:result = mysql_query(g_SQL, 
							va_fquery(g_SQL, 
								"SELECT sqlid FROM accounts WHERE name = '%e'", 
								playername
							)),
		rows;

	cache_get_row_count(rows);
	if(!rows)
		return -1;

	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	return sqlid;
}


stock ConvertSQLIDToName(id)
{
	new 
		nick[MAX_PLAYER_NAME];
		
	new 
		Cache:result = 	mysql_query(g_SQL, 
							va_fquery(g_SQL, "SELECT name FROM acounts WHERE sqlid = '%d'", id)
						);
	
	if(cache_num_rows() == 0)
		strcpy(nick, "None", MAX_PLAYER_NAME);
	else
	{
		cache_get_value_name(0, "name", nick, MAX_PLAYER_NAME);
		cache_delete(result);
	}
	return nick;
}

stock CheckStringForURL(text[])
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

stock AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

stock decode_lights(lights, &light1, &light2, &light3, &light4)
{
    light1 = lights & 1;
    light2 = lights >> 1 & 1;
    light3 = lights >> 2 & 1;
    light4 = lights >> 3 & 1;
}
 
decode_panels(panels, &front_left_panel, &front_right_panel, &rear_left_panel, &rear_right_panel, &windshield, &front_bumper, &rear_bumper)
{
    front_left_panel = panels & 15;
    front_right_panel = panels >> 4 & 15;
    rear_left_panel = panels >> 8 & 15;
    rear_right_panel = panels >> 12 & 15;
    windshield = panels >> 16 & 15;
    front_bumper = panels >> 20 & 15;
    rear_bumper = panels >> 24 & 15;
}
 
stock decode_doors(doors, &bonnet, &boot, &driver_door, &passenger_door)
{
    bonnet = doors & 7;
    boot = doors >> 8 & 7;
    driver_door = doors >> 16 & 7;
    passenger_door = doors >> 24 & 7;
}
 
stock decode_tires(tires, &tire1, &tire2, &tire3, &tire4)
{
    tire1 = tires & 1;
    tire2 = tires >> 1 & 1;
    tire3 = tires >> 2 & 1;
    tire4 = tires >> 3 & 1;
}


/*
	####  ######        ###       ######## ##     ## ##    ##  ######   ######  
	 ##  ##    ##      ## ##      ##       ##     ## ###   ## ##    ## ##    ## 
	 ##  ##           ##   ##     ##       ##     ## ####  ## ##       ##       
	 ##   ######     ##     ##    ######   ##     ## ## ## ## ##        ######  
	 ##        ##    #########    ##       ##     ## ##  #### ##             ## 
	 ##  ##    ##    ##     ##    ##       ##     ## ##   ### ##    ## ##    ## 
	####  ######     ##     ##    ##        #######  ##    ##  ######   ######  
*/

stock IsACabrio(model)
{
	switch(model) {
		case 424, 429, 430, 439, 446, 448, 452, 453, 454, 457, 461, 462, 463, 468, 471, 472, 473, 476, 480, 481, 484, 485, 486, 493, 500, 506, 509, 510, 512, 513, 521, 522, 523, 530, 531, 533, 536, 539, 555, 567, 568, 571, 572, 575, 581, 586:
			return 1;
		default:
			return 0;
	}
	return 0;
}

stock IsAAirCraft(modelid)
{
	switch(modelid) {
		case 417, 425, 447, 460, 469, 476, 487, 488, 497, 511, 512, 513, 519, 520, 548, 553, 563, 577, 592, 593: return 1;
	}
	return 0;
}

stock IsSafeForTextDraw(str[])
{
	new safetil = -5;
	for (new i = 0; i < strlen(str); i++) {
		if ((str[i] == 126) && (i > safetil)) {
			if (i >= strlen(str) - 1) // not enough room for the tag to end at all. 
				return false;
			if (str[i + 1] == 126)
				return false; // a tilde following a tilde.
			if (str[i + 2] != 126)
				return false; // a tilde not followed by another tilde after 2 chars
			safetil = i + 2; // tilde tag was verified as safe, ignore anything up to this location from further checks (otherwise it'll report tag end tilde as improperly started tag..).
		}
	}
	return true;
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

timer StopPlayerTrackSound[5000](playerid)
{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
}

timer InstantStreamerUpdate[4000](playerid)
{
	Streamer_ToggleIdleUpdate(playerid, 0);
	TogglePlayerControllable(playerid, 1);
}

forward UnfreezePlayer(playerid);
public UnfreezePlayer(playerid)
{
	TogglePlayerControllable(playerid, true);
}

stock SetPlayerLookAt(playerid, Float:X, Float:Y)
{
    new
        Float:Px,
        Float:Py,
        Float:Pa;

    GetPlayerPos(playerid, Px, Py, Pa);

    Pa = floatabs(atan((Y-Py)/(X-Px)));
    if(X <= Px && Y >= Py) Pa = floatsub(180, Pa);
    else if(X < Px && Y < Py) Pa = floatadd(Pa, 180);
    else if(X >= Px && Y <= Py) Pa = floatsub(360.0, Pa);
    Pa = floatsub(Pa, 90.0);
    if(Pa >= 360.0) Pa = floatsub(Pa, 360.0);
    SetPlayerFacingAngle(playerid, Pa);
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

ReturnName(playerid)
{
	new
	    p_name[24];
	    
	GetPlayerName(playerid, p_name, 24);
	return p_name;
}

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