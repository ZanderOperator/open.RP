/*
	Ban system by Slice
	This is an early release, be sure to check the release topic for updates!
	Other things by me: http://forum.sa-mp.com/search.php?searchid=3338956
	
	Changelog:
			2011-11-25:
				* Fixed a bug causing BanIP to fail.
			
			2011-11-18:
				* Minor bug fixes.
				* BanIPRange now accepts both strings IP ranges (IPRange<>).
				* New functions:
				  - GetBanIPRange
				  - GetIPString
				  - GetIPRangeString
				  - ClearBanDB
				* To  facilitate DB upgrades, tables will now be created according to gs_Tables, and 
				  missing fields (if any) will be searched for & created from gs_Columns.
				
			2011-11-08:
				* Added automatic table creation.
				* The database will have VACUUM done on initialization.
			
				* GetStringFromDuration now puts commas and, if applicable,
				  it puts "and" before the last part.
				* Packed a bunch of print and db_query statements to save space.
				* Rewrote EscapeSQLiteString to be approx. 160% faster.
				* Added Get(IP/Player)BanIndices.
				* Added LOOP_IP_BANS and LOOP_PLAYER_BANS.
				* Fixed a few bugs related to improper buffer usage.
				
				* Made DURATION(x) handle spaces better.
*/

// Make an integer from an IP
// Ex.: IP(127.0.0.1)
#define IP(%1.%2.%3.%4)                    IP:((((%1) << 24) | ((%2) << 16) | ((%3) << 8)) | (%4))

// Make an IP range from two IPs
// Ex.: IP_RANGE(192.168.0.0 - 192.168.255.255)
#define IP_RANGE(%1.%2.%3.%4-%5.%6.%7.%8)  e_IP_RANGE:{e_IP_RANGE:'#', e_IP_RANGE:IP(%1.%2.%3.%4), e_IP_RANGE:IP(%5.%6.%7.%8)}

// Get one octet from an IP
// Ex.: IP_OCTET(IP(192.168.0.123, 4) = 123
#define IP_OCTET(%1,%2)                    ((_:(%1) >>> ((4 - (%2)) * 8)) & 0xFF)

#define INVALID_IP  IP:0

// This should ALWAYS be used to declare IP ranges
#define IPRange<%1> %1[e_IP_RANGE]

// The following two macros allows me to pass IPs into SQLite queries as unsigned values, and it prevents PAWN from messing up some large numbers.
#define IP_ARG_FORMAT  "(%d<<16|%d)"

// I'm using g_iTempIP so I won't have to use %1 twice (as it could be a function call or something).
// The reason I copy %1 to g_iTempIP in the second argument is PAWN parses arguments right-to-left;
#define IP_ARG(%1)     (g_iTempIP >>> 16), ((g_iTempIP = _:(%1)) & 0xFFFF)

// Compile-time duration
// Ex.: DURATION(5 hours, 30 minutes)
#define DURATION_MS(%1)     (DURATION(%1) * 1000)
#define DURATION(%1)        (DURATION_PT:%1,0)
#define DURATION_PT:%1,     (%1:DURATION)+_:DURATION_PT:

#define second%1:DURATION
#define seconds%1:DURATION
#define minute%1:DURATION   * 60
#define minutes%1:DURATION  * 60
#define hour%1:DURATION     * 3600
#define hours%1:DURATION    * 3600
#define day%1:DURATION      * 86400
#define days%1:DURATION     * 86400
#define week%1:DURATION     * 604800
#define weeks%1:DURATION    * 604800
#define month%1:DURATION    * 2629743
#define months%1:DURATION   * 2629743
#define year%1:DURATION     * 31556926
#define years%1:DURATION    * 31556926

// Loop all bans on a specific IP.
// Ex.: LOOP_IP_BANS(new ban : IP(127.0.0.1))
#define LOOP_IP_BANS(%1:%2) \
	for (%1 = (g_iTempIndex = 0, g_iTempLength = GetIPBanIndices((%2), g_aiTempBanIndices)); (g_iTempIndex < g_iTempLength, _:__NO_NEW:%1 = g_aiTempBanIndices[g_iTempIndex]); g_iTempIndex++)

// Same as above, but for player IDs.
// Ex.: LOOP_PLAYER_BANS(new ban : playerid)
#define LOOP_PLAYER_BANS(%1:%2) \
	for (%1 = (g_iTempIndex = 0, g_iTempLength = GetIPBanIndices((ReturnPlayerIP(%2)), g_aiTempBanIndices)); (g_iTempIndex < g_iTempLength, _:__NO_NEW:%1 = g_aiTempBanIndices[g_iTempIndex]); g_iTempIndex++)

// Strip "new" from the loop variable (if any)
#define __NO_NEW:%1new  %1

// Durations (in seconds)
enum {
	DURATION_MINUTE = 60,
	DURATION_HOUR   = 60 * 60,
	DURATION_DAY    = 60 * 60 * 24,
	DURATION_WEEK   = 60 * 60 * 24 * 7,
	DURATION_MONTH  = 2629743,
	DURATION_YEAR   = 31556926,
	
	DURATION_PERMANENT = 0,
	DURATION_EXPIRED   = -1
};

// Enum for gs_DurationMultipliers
enum e_DURATION_MULTIPLIERS {
	e_szWord[7],
	e_iMultiplier
};

// Used to determine different ban types
enum {
	BAN_TYPE_NONE = 0, // Not banned!
	BAN_TYPE_SINGLE,   // When a ban is a single IP
	BAN_TYPE_RANGE     // When a ban is within a range of IPs
};

// Used for the IP ranges
enum e_IP_RANGE {
	// NOTE: If arrays are added here, update _GetIPRange and IsIPInRange.
	
	// Used to determine ranges in overloaded functions
	   e_iPoundSign,
	
	// Start and end IPs
	IP:e_iStart,
	IP:e_iEnd
};

// Used to define table columns
enum e_COLUMN {
	e_iTable, // Table in gs_Tables
	
	e_szName[32],
	e_szType[16],
	e_szConstraint[64],
	e_szDefault[16]
};

// Used to define tables
enum e_TABLE {
	e_szName[32]
};

static stock const
	// Used in GetDurationFromString
	gs_DurationMultipliers[][e_DURATION_MULTIPLIERS] = {
		{"m",      DURATION_MINUTE},
		{"min",    DURATION_MINUTE},
		{"minute", DURATION_MINUTE},
		
		{"h",      DURATION_HOUR},
		{"hr",     DURATION_HOUR},
		{"hour",   DURATION_HOUR},
		
		{"d",      DURATION_DAY},
		{"day",    DURATION_DAY},
		
		{"w",      DURATION_WEEK},
		{"week",   DURATION_WEEK},
		
		{"month",  DURATION_MONTH},
		
		{"y",      DURATION_YEAR},
		{"yr",     DURATION_YEAR},
		{"year",   DURATION_YEAR}
	},
	
	gs_Tables[][e_TABLE] = {
		{
			"bans"
		},
		{
			"bans_info"
		}
	},
	
	gs_Columns[][e_COLUMN] = {
		{0, "idx",      "integer", "NOT NULL PRIMARY KEY AUTOINCREMENT", ""},
		{0, "ip_start", "integer", "NOT NULL",                           "0"},
		{0, "ip_end",   "integer", "NOT NULL",                           "0"},
		{0, "expires",  "integer", "NOT NULL",                           "0"},

		{1, "idx",        "integer", "NOT NULL PRIMARY KEY AUTOINCREMENT", ""},
		{1, "ban",        "integer", "NOT NULL",                           "-1"},
		{1, "name",       "text",    "NOT NULL",                           "''"},
		{1, "value",      "",        "NOT NULL",                           "''"}
	}
;

// Used in SetBanInfo
enum {
	VALUE_TYPE_INT = 'i',
	VALUE_TYPE_FLOAT = 'f',
	VALUE_TYPE_STRING = 's'
};

static
       gs_szBanDatabaseName[] = "bans.db",
	DB:gs_dbBanDatabase,
	   gs_iKeepAliveTime = 1,
	   gs_iKeepAliveTimer = -1,
	   gs_szBuffer[10240]
;

stock
	IPRange<g_aiTempRange> = {'#', IP:0, IP:0},
	IPRange<g_aiTempRange2> = {'#', IP:0, IP:0},
	        g_iTempIP,
	        g_iTempIndex,
	        g_iTempLength,
	        g_aiTempBanIndices[100]
;

// Convert an integer IP to a string
stock GetDotDecimalIP(IP:iIP) {
	static
		s_szBuffer[16]
	;
	
	format(
		s_szBuffer,
		sizeof(s_szBuffer),
		"%d.%d.%d.%d",
		       (_:iIP >>> 24),
		0xFF & (_:iIP >>> 16),
		0xFF & (_:iIP >>>  8),
		0xFF & (_:iIP)
	);
	
	return s_szBuffer;
}

// Prevent compiler crashes
forward __bans_funcinc();
public __bans_funcinc() {
	new szTemp[] = "";
	
	// getstringarg needs this
	strcat(szTemp, "");
}

// Compare two unsigned numbers
stock _CompareUnsigned(iOper1, iOper2) {
	if((iOper1 & 0x80000000) && !(iOper2 & 0x80000000))
		return 1;
	else if((iOper2 & 0x80000000) && !(iOper1 & 0x80000000))
		return -1;
	else {
		iOper1 &= 0x7FFFFFFF;
		iOper2 &= 0x7FFFFFFF;
	}

	return (iOper1 == iOper2) ? 0 : ((iOper1 > iOper2) ? 1 : -1);
}

// Strip tags
#define CompareUnsigned(%1,%2) _CompareUnsigned(_:(%1), _:(%2))

// Get an integer IP from a string or an integer IP
stock IP:GetIntegerIP({IP, _}:...)
{
	new
		   iPos = -1,
		IP:iIP,
		   iArg
	;
	
	switch (iArg = getarg(0)) {
		case '0' .. '9': {
			static
				s_szIP[16]
			;
		
			getstringarg(s_szIP, 0);
			
			for (new i = 24; i >= 0; i -= 8) {
				iIP |= IP:(strval(s_szIP[++iPos]) << i);

				if(i && -1 == (iPos = strfind(s_szIP, ".", _, iPos)))
					return INVALID_IP;
			}
		}
	
		default: {
			iIP = IP:iArg;
		}
	}
	
	return iIP;
}

// Get an integer IP from a player
// Questionable function name, I know.
stock IP:ReturnPlayerIP(iPlayer) {
	static
		s_szIP[16]
	;
	
	ReturnPlayerIP(iPlayer, s_szIP, sizeof(s_szIP));
	
	return GetIntegerIP(s_szIP);
}

// Detect whether or not an IP is within an IP range
stock bool:IsIPInRange({IP, e_IP_RANGE, _}:...) {
	new
		IPRange<Range>,
		IP:iIP,
		iArg
	;
	
	switch (iArg = getarg(0)) {
		case '0' .. '9': {
			new
				szIP[16]
			;
		
			getstringarg(szIP, 0);
			
			iIP = GetIntegerIP(szIP);
		}
	
		default: {
			iIP = IP:iArg;
		}
	}
	
	for (new i = 0; i < _:e_IP_RANGE; i++)
		Range[e_IP_RANGE:i] = e_IP_RANGE:getarg(1, i);
	
	return (
		(CompareUnsigned(Range[e_iStart], Range[e_iEnd]) == 1 && CompareUnsigned(iIP, Range[e_iEnd]) >= 0 && CompareUnsigned(iIP, Range[e_iStart]) <= 0) ||
		(CompareUnsigned(Range[e_iEnd], Range[e_iStart]) == 1 && CompareUnsigned(iIP, Range[e_iStart]) >= 0 && CompareUnsigned(iIP, Range[e_iEnd]) <= 0)
	);
}

stock GetIPString(IP:iIP) {
	static
		s_szBuffer[16]
	;
	
	format(
		s_szBuffer,
		sizeof(s_szBuffer),
		"%d.%d.%d.%d",
		(_:iIP & (255 << 24)) >>> 24,
		(_:iIP & (255 << 16)) >>> 16,
		(_:iIP & (255 <<  8)) >>> 8,
		(_:iIP & (255))
	);
	
	return s_szBuffer;
}

stock _GetIPRangeString(IPRange<Range>) {
	static
		s_szBuffer[34]
	;
	
	new
		bool:bWildCardsOnly = true,
		     iDiff,
		     iLength
	;

	for (new i = 1; i <= 4; i++) {
		iDiff = IP_OCTET(Range[e_iStart], i) - IP_OCTET(Range[e_iEnd], i);
		
		if(!(iDiff == 0 || iDiff == 255 || iDiff == -255)) {
			bWildCardsOnly = false;
			
			break;
		}
	}
	
	s_szBuffer[0] = 0;
	
	if(bWildCardsOnly) {
		
		for (new i = 1; i <= 4; i++) {
			if(i > 1)
				strcat(s_szBuffer, ".");
			
			if(IP_OCTET(Range[e_iStart], i) == IP_OCTET(Range[e_iEnd], i)) {
				iLength = strlen(s_szBuffer);
				
				format(s_szBuffer[iLength], sizeof(s_szBuffer) - iLength, "%d", IP_OCTET(Range[e_iStart], i));
			} else
				strcat(s_szBuffer, "*");
		}
	} else {
		if(CompareUnsigned(Range[e_iStart], Range[e_iEnd]) == 1) {
			strcat(s_szBuffer, GetIPString(Range[e_iEnd]));
			strcat(s_szBuffer, " - ");
			strcat(s_szBuffer, GetIPString(Range[e_iStart]));
		} else {
			strcat(s_szBuffer, GetIPString(Range[e_iStart]));
			strcat(s_szBuffer, " - ");
			strcat(s_szBuffer, GetIPString(Range[e_iEnd]));
		}
	}
	
	return s_szBuffer;
}

#define GetIPRangeString(%1)  _GetIPRangeString(GetIPRange(%1))

// Get an IP range from a string
stock IP:_GetIPRange(IPRange<Range>, {IP, e_IP_RANGE, _}:...) {
	Range[e_iPoundSign] = '#';
	Range[e_iStart] = IP:0;
	Range[e_iEnd] = IP:0;
	
	// "Overloaded" function
	switch (numargs()) {
		case 2: {
			switch (getarg(1)) {
				case '0' .. '9', '*': {
					new
						szIP[16]
					;
					
					getstringarg(szIP, 1);
					
					for (new iPos = -1, i = 24, iVal; i >= 0; i -= 8) {
						if(szIP[++iPos] == '*') {
							Range[e_iEnd] |= IP:(255 << i);
						} else {
							iVal = strval(szIP[iPos]) << i;
							
							Range[e_iStart] |= IP:iVal;
							Range[e_iEnd] |= IP:iVal;
						}

						if(i && -1 == (iPos = strfind(szIP, ".", _, iPos)))
							break;
					}
				}
				
				case '#': {
					for (new i = 0; i < _:e_IP_RANGE; i++)
						Range[e_IP_RANGE:i] = e_IP_RANGE:getarg(1, i);
				}
				
				default: {
					print(!"ERROR: Invalid argument passed to GetIPRange; expected an IP string or a range.");
				}
			}
		}
		
		case 3: {
			new
				iArg
			;
			
			for (new i = 1; i <= 2; i++) {
				switch (iArg = getarg(i)) {
					case '0' .. '9': {
						new
							szIP[16]
						;
					
						getstringarg(szIP, i);
						
						Range[(i == 1) ? e_iStart : e_iEnd] = e_IP_RANGE:GetIntegerIP(szIP);
					}
				
					default: {
						Range[(i == 1) ? e_iStart : e_iEnd] = e_IP_RANGE:iArg;
					}
				}
			}
		}
		
		default: {
			print(!"ERROR: Invalid argument count sent to GetRangeFromString.");
		}
	}
}

// This macro makes the function return an array, which normally is quite buggy.
#define GetIPRange(%1) (_GetIPRange(g_aiTempRange,%1), g_aiTempRange)

// Convert a human-readable duration into seconds
stock GetDurationFromString(const szDuration[]) {
	new
		     iPos,
		     iDuration = 0,
		     iValue,
		     szWord[8],
		     i,
		     iLength,
		bool:bMultiplierFound,
		     cTempChar
	;
	
	// Zero-out the buffer and use strcat to copy the contents of szDuration onto it
	gs_szBuffer[0] = 0;
	
	strcat(gs_szBuffer, szDuration);
	
	// Remove "and" words
	while (-1 != (iPos = strfind(gs_szBuffer, "and", true, iPos++)))
		strdel(gs_szBuffer, iPos, iPos + 3);
	
	// Convert commas to spaces
	while (-1 != (iPos = strfind(gs_szBuffer, ",", true, iPos++)))
		gs_szBuffer[iPos] = ' ';
	
	// Convert ampersands to spaced
	while (-1 != (iPos = strfind(gs_szBuffer, "&", true, iPos++)))
		gs_szBuffer[iPos] = ' ';
	
	iPos = 0;
	
	// Fix for strval ignoring long strings
	if(strlen(gs_szBuffer[iPos]) > 32) {
		cTempChar = gs_szBuffer[iPos + 32];
		
		gs_szBuffer[iPos + 32] = 0;
	}
	
	// The current position in the string (iPos) should now be at the first number
	while (0 != (iValue = strval(gs_szBuffer[iPos]))) {
		if(cTempChar) {
			gs_szBuffer[iPos + 32] = cTempChar;
			
			cTempChar = 0;
		}
		
		// Skip spaces (no need to do this before strval as it does it as well)
		while (0 < gs_szBuffer[iPos] <= ' ') iPos++;
		
		// EOS check
		if(!gs_szBuffer[iPos]) return 0;
		
		// Allow a leading minus sign
		if(gs_szBuffer[iPos] == '-') iPos++;
		
		// Skip the number we just put into strval
		while ('0' <= gs_szBuffer[iPos] <= '9') iPos++;
		
		// Skip spaces
		while (0 < gs_szBuffer[iPos] <= ' ') iPos++;
		
		// EOS check
		if(!gs_szBuffer[iPos]) return 0;
		
		// Start of the multiplier (hour, second, etc.)
		i = iPos;
		
		// Loop until the next space or number
		while (gs_szBuffer[i] > ' ' && !('0' <= gs_szBuffer[i] <= '9') && gs_szBuffer[i] != '-') i++;
		
		// No word? Invalid format
		if(i == iPos) return 0;
		
		// Zero-out szWord and use strcat to copy the fragment we just found from gs_szBuffer
		szWord[0] = 0;
		
		strcat(szWord, gs_szBuffer[iPos], i - iPos + 1);
		
		// Jump the current parsing position to the end of the word
		iPos = i;
		
		// Null check
		if(!(iLength = strlen(szWord))) return 0;
		
		// Remove trailing s so we won't have to search after, for example, both "hour" and "hours"
		if(iLength > 1 && tolower(szWord[iLength - 1]) == 's')
			szWord[iLength - 1] = 0;
		
		// Loop through the duration multiplier list
		
		bMultiplierFound = false;
		
		for (i = 0; i < sizeof(gs_DurationMultipliers); i++) {
			if(!strcmp(szWord, gs_DurationMultipliers[i][e_szWord], true)) {
				bMultiplierFound = true;
				
				// Multiply the number we got from strval with whatever this multiplier has
				iDuration += iValue * gs_DurationMultipliers[i][e_iMultiplier];
				
				break;
			}
		}
		
		// Give a warning  if a multiplier wasn't found
		if(!bMultiplierFound)
			printf("WARNING: Unknown multiplier in GetDurationFromString (\"%s\").", szWord);
		
		// Fix for strval ignoring long strings
		if(strlen(gs_szBuffer[iPos]) > 32) {
			cTempChar = gs_szBuffer[iPos + 32];
			
			gs_szBuffer[iPos + 32] = 0;
		}
	}
	
	return iDuration;
}

// Reverse of above function
stock GetStringFromDuration(iDuration) {
	new
		iMinutes = 0,
		iHours   = 0,
		iDays    = 0,
		iWeeks   = 0,
		iMonths  = 0,
		iYears   = 0,
		
		iLength,
		iPos,
		iLastPos
	;
	
	static
		s_szBuffer[256]
	;
	
	s_szBuffer[0] = 0;
	
	iYears = iDuration / DURATION_YEAR;
	iDuration = iDuration % DURATION_YEAR;
	
	if(iYears)
		format(s_szBuffer, sizeof(s_szBuffer), iYears == 1 ? ("%d year, ") : ("%d years, "), iYears);
	
	iMonths   = iDuration / DURATION_MONTH;
	iDuration = iDuration % DURATION_MONTH;
	
	if(iMonths)
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iMonths == 1 ? ("%d month, ") : ("%d months, "), iMonths);
	
	iWeeks    = iDuration / DURATION_WEEK;
	iDuration = iDuration % DURATION_WEEK;
	
	if(iWeeks)
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iWeeks == 1 ? ("%d week, ") : ("%d weeks, "), iWeeks);
	
	iDays     = iDuration / DURATION_DAY;
	iDuration = iDuration % DURATION_DAY;
	
	if(iDays)
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iDays == 1 ? ("%d day, ") : ("%d days, "), iDays);
	
	iHours    = iDuration / DURATION_HOUR;
	iDuration = iDuration % DURATION_HOUR;
	
	if(iHours)
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iHours == 1 ? ("%d hour, ") : ("%d hours, "), iHours);
	
	iMinutes = iDuration / DURATION_MINUTE;
	
	if(iMinutes)
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iMinutes == 1 ? ("%d minute, ") : ("%d minutes, "), iMinutes);
	
	if(!s_szBuffer[0]) {
		format(s_szBuffer[(iLength = strlen(s_szBuffer))], sizeof(s_szBuffer) - iLength, iDuration == 1 ? ("%d second") : ("%d seconds"), iDuration);
	} else {
		iLength = strlen(s_szBuffer);
		
		s_szBuffer[iLength - 2] = 0;
	}
	
	iLastPos = -1;
	
	while (-1 != (iPos = strfind(s_szBuffer, ",", _, iPos)))
		iLastPos = iPos++;
	
	if(iLastPos != -1) {
		s_szBuffer[iLastPos] = ' ';
		
		strins(s_szBuffer, "and", iLastPos + 1);
	}
	
	return s_szBuffer;
}

// By Y_Less
// Copies a string argument (index arg) to dest
stock static getstringarg(dest[], arg, len = sizeof (dest))
{
    // Get the address of the previous function's stack.  First get the index of
    // the argument required.
    #emit LOAD.S.pri arg
    // Then convert that number to bytes from cells.
    #emit SMUL.C     4
    // Get the previous function's frame.  Stored in variable 0 (in the current
    // frame).  Parameters are FRM+n+12, locals are FRM-n, previous frame is
    // FRM+0, return address is FRM+4, parameter count is FRM+8.  We could add
    // checks that "arg * 4 < *(*(FRM + 0) + 8)", for the previous frame parameter
    // count (in C pointer speak).
    #emit LOAD.S.alt 0
    // Add the frame pointer to the argument offset in bytes.
    #emit ADD
    // Add 12 to skip over the function header.
    #emit ADD.C      12
    // Load the address stored in the specified address.
    #emit LOAD.I
    // Push the length for "strcat".
    #emit PUSH.S     len
    // Push the address we just determined was the source.
    #emit PUSH.pri
    // Load the address of the destination.
    #emit LOAD.S.alt dest
    // Blank the first cell so "strcat" behaves like "strcpy".
    #emit CONST.pri  0
    // Store the loaded number 0 to the loaded address.
    #emit STOR.I
    // Push the loaded address.
    #emit PUSH.alt
    // Push the number of parameters passed (in bytes) to the function.
    #emit PUSH.C     12
    // Call the function.
    #emit SYSREQ.C   strcat
    // Restore the stack to its level before we called this native.
    #emit STACK      16
}

// Ensure that the DB is open, return false if unsuccessful.
stock OpenBanDB() {
	static
		s_bIsInitialized = false
	;
	
	if(gs_dbBanDatabase || (gs_dbBanDatabase = db_open(gs_szBanDatabaseName))) {
		if(gs_iKeepAliveTimer == -1 || gs_iKeepAliveTime > 1) {
			if(gs_iKeepAliveTimer != -1)
				KillTimer(gs_iKeepAliveTimer);
		
			gs_iKeepAliveTimer = SetTimer("CloseBanDB", min(1, gs_iKeepAliveTime), false);
		}
		
		if(!s_bIsInitialized) {
			new
				DBResult:dbrResult,
				         iRows,
				         iLength
			;
			
			s_bIsInitialized = true;
			
			dbrResult = db_query(gs_dbBanDatabase, !"VACUUM;");
			
			if(dbrResult)
				db_free_result(dbrResult);
			
			for (new i = 0; i < sizeof(gs_Tables); i++) {
				format(gs_szBuffer, sizeof(gs_szBuffer), "PRAGMA table_info('%s');", gs_Tables[i][e_szName]);
				
				dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
				
				iRows = db_num_rows(dbrResult);
				
				if(!iRows) {
					gs_szBuffer[0] = 0;
					
					format(gs_szBuffer, sizeof(gs_szBuffer), "CREATE TABLE IF NOT EXISTS `%s` (\n\t", gs_Tables[i][e_szName]);
					
					for (new bool:bFirst = true, c = 0; c < sizeof(gs_Columns); c++) {
						if(gs_Columns[c][e_iTable] != i)
							continue;
						
						if(bFirst)
							bFirst = false;
						else
							strcat(gs_szBuffer, ",\n\t");
						
						iLength = strlen(gs_szBuffer);
						
						format(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength, "`%s` %s %s", gs_Columns[c][e_szName], gs_Columns[c][e_szType], gs_Columns[c][e_szConstraint]);
						
						if(gs_Columns[c][e_szDefault][0]) {
							iLength = strlen(gs_szBuffer);
							
							format(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength, " DEFAULT(%s)", gs_Columns[c][e_szDefault]);
						}
					}
					
					strcat(gs_szBuffer, "\n);");
					
					printf("The table \"%s\" does not exist, it will now be created.", gs_Tables[i][e_szName]);
					
					db_free_result(db_query(gs_dbBanDatabase, gs_szBuffer));
				} else {
					new
						bool:bCreateColumn[sizeof(gs_Columns)] = {true, ...}
					;
					
					for (new c = 0; c < sizeof(gs_Columns); c++) {
						if(gs_Columns[c][e_iTable] != i)
							bCreateColumn[c] = false;
					}
						
					for (new c, iRow = 0; iRow < iRows; iRow++) {
						db_get_field_assoc(dbrResult, "name", gs_szBuffer, sizeof(gs_szBuffer) - 1);
						
						for (c = 0; c < sizeof(gs_Columns); c++) {
							if(!strcmp(gs_Columns[c][e_szName], gs_szBuffer, false))
								bCreateColumn[c] = false;
						}
						
						db_next_row(dbrResult);
					}
					
					for (new c = 0; c < sizeof(gs_Columns); c++) {
						if(bCreateColumn[c]) {
							printf("Column \"%s\" does not exist in table \"%s\", it will now be created.", gs_Columns[c][e_szName], gs_Tables[i][e_szName]);
							
							format(gs_szBuffer, sizeof(gs_szBuffer), "ALTER TABLE `%s` ADD COLUMN `%s` %s %s", gs_Tables[i][e_szName], gs_Columns[c][e_szName], gs_Columns[c][e_szType], gs_Columns[c][e_szConstraint], gs_Columns[c][e_szDefault]);
							
							if(gs_Columns[c][e_szDefault][0]) {
								iLength = strlen(gs_szBuffer);

								format(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength, " DEFAULT(%s)", gs_Columns[c][e_szDefault]);
							}
							
							strcat(gs_szBuffer, ";");
							
							db_free_result(db_query(gs_dbBanDatabase, gs_szBuffer));
						}
					}
				}
				
				db_free_result(dbrResult);
			}
		}
		
		return true;
	}
	
	print(!"ERROR: OpenBanDB failed.");
	
	return false;
}

// Used mainly for debugging

stock ClearBanDB() {
	if(gs_dbBanDatabase)
		db_close(gs_dbBanDatabase);
	
	if(fexist(gs_szBanDatabaseName))
		fremove(gs_szBanDatabaseName);
	
	if(gs_dbBanDatabase) {
		gs_dbBanDatabase = DB:0;
		
		OpenBanDB();
	}
}

// Used in a timer from OpenBanDB
forward CloseBanDB();
public  CloseBanDB() {
	if(gs_dbBanDatabase)
		db_close(gs_dbBanDatabase);
	
	gs_iKeepAliveTimer = -1;
	gs_dbBanDatabase = DB:0;
}

// Get the UNIX timestsamp (with the local timezone).
// I know, I'm lazy.. The function can run approx. 120 times/ms, though, so I'm ok with it.
stock GetUnixTimestamp() {
	if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetUnixTimestamp.");
	else {
		
		new
			DBResult:dbrResult = db_query(gs_dbBanDatabase, !"SELECT strftime('%s','now','localtime')")
		;
		
		if(!dbrResult)
			print(!"ERROR: No result returned to GetUnixTimestamp.");
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);

			print(!"ERROR: No rows returned to GetUnixTimestamp.");
		} else {
			static
				s_szBuffer[12]
			;
			
			db_get_field(dbrResult, 0, s_szBuffer, sizeof(s_szBuffer) - 1);

			db_free_result(dbrResult);
			
			return strval(s_szBuffer);
		}
	}
	
	return 0;
}

// Escape single-quotes in a string for usage in SQLite queries
stock EscapeSQLiteString(String[], iSize = sizeof(String)) {
	new
		iPos
	;
	
	while (-1 != (iPos = strfind(String, "'", _, iPos))) {
		strins(String, "'", iPos, iSize);
		
		iPos += 2;
	}
}

// Ban an IP range
stock __BanIPRange(IPRange<Range>, iDuration = DURATION_PERMANENT, ...) {
	if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in BanIPRange.");
	else {
		new
			         iBanIndex,
			         iExpires = DURATION_PERMANENT,
			DBResult:dbrResult
		;
		
		if(iDuration)
			iExpires = GetUnixTimestamp() + iDuration;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "INSERT INTO bans (ip_start, ip_end, expires) VALUES (" IP_ARG_FORMAT "," IP_ARG_FORMAT ", %d); SELECT last_insert_rowid();", IP_ARG(Range[e_iStart]), IP_ARG(Range[e_iEnd]), iExpires);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(!dbrResult) {
			print(!"ERROR: No result returned to BanIPRange.");
			printf("ERROR: Query: %s", gs_szBuffer);
		} else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);
			
			print(!"ERROR: No rows returned to BanIPRange.");
			printf("ERROR: Query: %s", gs_szBuffer);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
			db_free_result(dbrResult);
			
			if(!(iBanIndex = strval(gs_szBuffer)))
				print(!"ERROR: Invalid ban index given from query in BanIPRange.");
			else
				return iBanIndex;
		}
	}
	
	return 0;
}

#define BanIPRange(%1)      _BanIPRange(%1,DURATION_PERMANENT)
#define _BanIPRange(%1,%2)  __BanIPRange(GetIPRange(%1),%2)

// Ban an IP (basically, create an IP range and call BanIPRange)
stock BanIP({IP, _}:...) {
	new
		iArgCount,
		iArg,
		iDuration = 0,
		IPRange<Range>
	;
	
	iArgCount = numargs();
	
	Range[e_iPoundSign] = '#';
	
	if(!(1 <= iArgCount <= 2)) {
		printf("ERROR: An invalid number of arguments were passed to BanIP (%d), expected 1 or 2.", iArgCount);
		
		return 0;
	}
	
	if(iArgCount > 1)
		iDuration = getarg(1);
	
 	switch (iArg = getarg(0)) {
		case '0' .. '9': {
			new
				   szIP[16],
				IP:iIP
			;

			getstringarg(szIP, 0);

			iIP = GetIntegerIP(szIP);
			
			Range[e_iStart] = iIP;
			Range[e_iEnd] = iIP;
		}

		default: {
			Range[e_iStart] = IP:iArg;
			Range[e_iEnd] = IP:iArg;
		}
	}
	
	return BanIPRange(Range, iDuration);
}

// Same as above, but for a player ID
stock BanPlayer(iPlayer, iDuration = DURATION_PERMANENT) {
	new iBanIndex = BanIP(ReturnPlayerIP(iPlayer), iDuration);
	
	if(iBanIndex) {
		GetPlayerName(iPlayer, gs_szBuffer, sizeof(gs_szBuffer));
		
		SetBanInfoString(iBanIndex, "nickname", gs_szBuffer);
		
		Kick(iPlayer);
	}
	
	return iBanIndex;
}

// Remove a ban (still keeps it in the database, but its expiration will be set to DURATION_EXPIRED which means lifted)
stock LiftBan(iBanIndex) {
	if(!iBanIndex)
		print(!"ERROR: Invalid ban index passed to LiftBan.");
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in LiftBan.");
	else {
		new
			DBResult:dbrResult
		;

		format(gs_szBuffer, sizeof(gs_szBuffer), "UPDATE bans SET expires = %d WHERE idx = %d; SELECT changes();", DURATION_EXPIRED, iBanIndex);

		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);

		if(!dbrResult)
			printf("ERROR: No result returned to LiftBan(%d).", iBanIndex);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);

			printf("ERROR: No rows returned to LiftBan(%d).", iBanIndex);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);

			db_free_result(dbrResult);

			return (strval(gs_szBuffer) == 1);
		}
	}

	return false;
}

// Get the index of the first ban for an IP; 0 if none
stock GetIPBanIndex({IP, _}:...) {
	new
		   iArgCount,
		   iArg,
		IP:iIP = INVALID_IP
	;
	
	if((iArgCount = numargs()) != 1) {
		printf("ERROR: An invalid number of arguments were passed to GetIPBanIndex (%d), expected 1.", iArgCount);
		
		return 0;
	}
	
	switch (iArg = getarg(0)) {
		case '0' .. '9': {
			new
				szIP[16]
			;
		
			getstringarg(szIP, 0);
			
			iIP = GetIntegerIP(szIP);
		}
	
		default: {
			iIP = IP:iArg;
		}
	}
	
	if(iIP == INVALID_IP)
		print(!"ERROR: Invalid IP passed to GetIPBanIndex.");
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetIPBanIndex.");
	else {
		new
			DBResult:dbrResult
		;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT idx FROM bans WHERE " IP_ARG_FORMAT " BETWEEN ip_start AND ip_end AND expires != %d AND expires = 0 OR strftime('%%s','now','localtime') < expires LIMIT 1;", IP_ARG(iIP), DURATION_EXPIRED);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(dbrResult) {
			if(!db_num_rows(dbrResult)) {
				db_free_result(dbrResult);
			} else {
				db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
				db_free_result(dbrResult);
			
				return strval(gs_szBuffer);
			}
		}
	}
	
	return 0;
}

// Same as above, but for a player ID
stock GetPlayerBanIndex(iPlayer)
	return GetIPBanIndex(ReturnPlayerIP(iPlayer));

stock _GetIPBanIndices(IP:iIP, aiDestination[], iDestinationSize = sizeof(aiDestination)) {
	new
		iIndices = 0
	;
	
	if(iIP == INVALID_IP)
		print(!"ERROR: Invalid IP passed to GetIPBanIndices.");
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetIPBanIndices.");
	else {
		new
			DBResult:dbrResult,
			         iRows
		;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT idx FROM bans WHERE " IP_ARG_FORMAT " BETWEEN ip_start AND ip_end AND expires != %d AND expires = 0 OR strftime('%%s','now','localtime') < expires;", IP_ARG(iIP), DURATION_EXPIRED);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(dbrResult) {
			if(!(iRows = db_num_rows(dbrResult))) {
				db_free_result(dbrResult);
			} else {
				while (iRows--) {
					db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
					
					aiDestination[iIndices++] = strval(gs_szBuffer);
					
					if(iIndices >= iDestinationSize) {
						printf("WARNING: There were more ban indices found than the destination array could fit in GetIPBanIndices (found: %d, array size: %d).", iRows + iIndices, iDestinationSize);
						
						break;
					}
					
					db_next_row(dbrResult);
				}
				
				db_free_result(dbrResult);
			}
		}
	}
	
	// Zero-out the rest of the array
	for (new i = iIndices; i < iDestinationSize; i++)
		aiDestination[i] = 0;
	
	return iIndices;
}

#define GetIPBanIndices(%1,%2)  _GetIPBanIndices(GetIntegerIP(%1), %2)
#define GetIPBanIndexes(%1,%2)  _GetIPBanIndices(GetIntegerIP(%1), %2)

stock GetPlayerBanIndices(iPlayer, aiDestination[], iDestinationSize = sizeof(aiDestination))
	return _GetIPBanIndices(ReturnPlayerIP(iPlayer), aiDestination, iDestinationSize);

// Get the type of a ban index
stock GetBanType(iBanIndex) {
	if(!iBanIndex)
		return BAN_TYPE_NONE;
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetBanType.");
	else {
		new
			DBResult:dbrResult
		;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT (ip_start == ip_end) FROM bans WHERE idx = %d;", iBanIndex);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(!dbrResult)
			printf("ERROR: No result returned to GetBanType(%d).", iBanIndex);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);
			
			printf("ERROR: No rows returned to GetBanType(%d).", iBanIndex);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
			db_free_result(dbrResult);
			
			return strval(gs_szBuffer) ? BAN_TYPE_SINGLE : BAN_TYPE_RANGE;
		}
	}
	
	return BAN_TYPE_NONE;
}

// Get the expiration date of a ban
stock GetBanExpirationTime(iBanIndex) {
	if(!iBanIndex)
		return BAN_TYPE_NONE;
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetBanExpirationTime.");
	else {
		new
			DBResult:dbrResult
		;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT expires FROM bans WHERE idx = %d;", iBanIndex);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(!dbrResult)
			printf("ERROR: No result returned to GetBanExpirationTime(%d).", iBanIndex);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);
			
			printf("ERROR: No rows returned to GetBanExpirationTime(%d).", iBanIndex);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
			db_free_result(dbrResult);
			
			return strval(gs_szBuffer);
		}
	}
	
	return 0;
}

// Set the expiration date of a ban
stock SetBanExpirationTime(iBanIndex, iExpiration) {
	if(!iBanIndex)
		return BAN_TYPE_NONE;
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in SetBanExpirationTime.");
	else {
		new
			DBResult:dbrResult
		;

		format(gs_szBuffer, sizeof(gs_szBuffer), "UPDATE bans SET expires = %d WHERE idx = %d; SELECT changes();", iExpiration, iBanIndex);

		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);

		if(!dbrResult)
			printf("ERROR: No result returned to SetBanExpirationTime(%d, %d).", iBanIndex, iExpiration);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);

			printf("ERROR: No rows returned to SetBanExpirationTime(%d, %d).", iBanIndex, iExpiration);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);

			db_free_result(dbrResult);

			return (strval(gs_szBuffer) == 1);
		}
	}

	return false;
}

// Set info for a ban
static stock SetBanInfo(iBanIndex, const szKey[], iValueType, {_, Float}:...) {
	if(numargs() != 4) {
		printf("ERROR: An invalid number of arguments were passed to SetBanInfo (%d), expected 4.", numargs());
		
		return 0;
	}
	
	switch (iValueType) {
		case VALUE_TYPE_INT, VALUE_TYPE_FLOAT, VALUE_TYPE_STRING: {}
		default: {
			printf("ERROR: Invalid value type passed to SetBanInfo (%d).", iValueType);
			
			return false;
		}
	}
	
	if(!iBanIndex)
		print(!"ERROR: Invalid ban index passed to SetBanInfo.");
	else if(!strcmp(szKey, "expires", true))
		return SetBanExpirationTime(iBanIndex, getarg(3));
	else if(!strcmp(szKey, "time_left", true))
		return SetBanExpirationTime(iBanIndex, GetUnixTimestamp() + getarg(3));
	else if(!strcmp(szKey, "type", true))
		print(!"ERROR: The ban type cannot be changed with SetBanInfo.");
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in SetBanInfo.");
	else {
		new
			DBResult:dbrResult,
			         iLength,
			         xValue = getarg(3)
		;
		
		gs_szBuffer[0] = 0;
		
		strcat(gs_szBuffer, szKey);

		EscapeSQLiteString(gs_szBuffer);
		
		format(
			gs_szBuffer,
			sizeof(gs_szBuffer),
			"INSERT OR REPLACE INTO bans_info (idx, ban, name, value) VALUES ((SELECT idx FROM bans_info WHERE ban = %d AND name = '%s'), %d, '%s', ",
			iBanIndex, gs_szBuffer, iBanIndex, gs_szBuffer
		);
		
		iLength = strlen(gs_szBuffer);
		
		switch (iValueType) {
			case VALUE_TYPE_INT: {
				format(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength, "(%d<<16|%d)); SELECT changes();", (xValue >>> 16), (xValue & 0xFFFF));
			}
			
			case VALUE_TYPE_FLOAT: {
				format(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength, "'%f'); SELECT changes();", xValue);
			}
			
			case VALUE_TYPE_STRING: {
				gs_szBuffer[iLength++] = '\';
				
				getstringarg(gs_szBuffer[iLength], 3, sizeof(gs_szBuffer) - iLength);
				
				EscapeSQLiteString(gs_szBuffer[iLength], sizeof(gs_szBuffer) - iLength);
				
				strcat(gs_szBuffer, "'); SELECT changes();");
			}
		}
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);

		if(!dbrResult)
			printf("NOTICE: No result returned to SetBanInfo(%d, \"%s\", %d, ...).", iBanIndex, szKey, iValueType);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);

			printf("NOTICE: No rows returned to SetBanInfo(%d, \"%s\", %d, ...).", iBanIndex, szKey, iValueType);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);

			db_free_result(dbrResult);
			
			return (strval(gs_szBuffer) == 1);
		}
	}

	return false;
}

// Wrappers for above:
stock SetBanInfoInt(iBanIndex, const szKey[], iValue)
	SetBanInfo(iBanIndex, szKey, VALUE_TYPE_INT, iValue);

stock SetBanInfoFloat(iBanIndex, const szKey[], Float:fValue)
	SetBanInfo(iBanIndex, szKey, VALUE_TYPE_FLOAT, fValue);

stock SetBanInfoString(iBanIndex, const szKey[], const szValue[])
	SetBanInfo(iBanIndex, szKey, VALUE_TYPE_STRING, szValue);

// Get info for a ban (set by SetBanInfo)
static stock GetBanInfo(iBanIndex, const szKey[], iValueType) {
	switch (iValueType) {
		case VALUE_TYPE_INT, VALUE_TYPE_FLOAT, VALUE_TYPE_STRING: {}
		default: {
			printf("ERROR: Invalid value type passed to GetBanInfo (%d).", iValueType);
			
			return false;
		}
	}
	
	if(!iBanIndex)
		print(!"ERROR: Invalid ban index passed to GetBanInfo.");
	else if(iValueType == VALUE_TYPE_INT && !strcmp(szKey, "expires", true))
		return GetBanExpirationTime(iBanIndex);
	else if(!strcmp(szKey, "time_left", true))
		return max(0, GetBanExpirationTime(iBanIndex) - GetUnixTimestamp());
	else if(iValueType == VALUE_TYPE_INT && !strcmp(szKey, "type", true))
		return GetBanType(iBanIndex);
	else if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetBanInfo.");
	else {
		new
			DBResult:dbrResult
		;
		
		gs_szBuffer[0] = 0;
		
		strcat(gs_szBuffer, szKey);
		
		EscapeSQLiteString(gs_szBuffer);
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT value FROM bans_info WHERE ban = %d AND name = '%s';", iBanIndex, gs_szBuffer);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(!dbrResult)
			printf("NOTICE: No result returned to GetBanInfo(%d, \"%s\").", iBanIndex, szKey);
		else if(!db_num_rows(dbrResult)) {
			db_free_result(dbrResult);
			
			printf("NOTICE: No rows returned to GetBanInfo(%d, \"%s\").", iBanIndex, szKey);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
			db_free_result(dbrResult);
			
			switch (iValueType) {
				case VALUE_TYPE_INT:
					return strval(gs_szBuffer);
				
				case VALUE_TYPE_FLOAT:
					return _:floatstr(gs_szBuffer);
				
				case VALUE_TYPE_STRING:
					return 1;
			}
		}
	}
	
	return 0;
}

stock GetBanInfoInt(iBanIndex, const szKey[])
	return GetBanInfo(iBanIndex, szKey, VALUE_TYPE_INT);

stock Float:GetBanInfoFloat(iBanIndex, const szKey[])
	return Float:GetBanInfo(iBanIndex, szKey, VALUE_TYPE_FLOAT);

stock GetBanInfoStringCopy(iBanIndex, const szKey[], szDestination[], iLength = sizeof(szDestination)) {
	szDestination[0] = 0;
	
	if(GetBanInfo(iBanIndex, szKey, VALUE_TYPE_STRING)) {
		strcat(szDestination, gs_szBuffer, iLength);
		
		return true;
	}
	
	return false;
}

stock GetBanInfoString(iBanIndex, const szKey[]) {
	static
		s_szBuffer[256]
	;
	
	if(!GetBanInfo(iBanIndex, szKey, VALUE_TYPE_STRING))
		gs_szBuffer[0] = 0;
	
	s_szBuffer[0] = 0;
	
	strcat(s_szBuffer, gs_szBuffer);
	
	return s_szBuffer;
}

stock _GetBanIPRange(IPRange<Range>, iBanIndex) {
	Range[e_iPoundSign] = '#';
	Range[e_iStart] = IP:0;
	Range[e_iEnd] = IP:0;
	
	
	if(!OpenBanDB())
		print(!"ERROR: Unable to open the ban DB in GetBanIPRange.");
	else {
		new
			DBResult:dbrResult
		;
		
		format(gs_szBuffer, sizeof(gs_szBuffer), "SELECT ip_start, ip_end FROM bans WHERE idx = %d;", iBanIndex);
		
		dbrResult = db_query(gs_dbBanDatabase, gs_szBuffer);
		
		if(!dbrResult) {
			printf("NOTICE: No result returned to GetBanIPRange(%d).", iBanIndex);
			
			return;
		} else if(!db_num_rows(dbrResult)) {
			printf("NOTICE: No rows returned to GetBanIPRange(%d).", iBanIndex);
		} else {
			db_get_field(dbrResult, 0, gs_szBuffer, sizeof(gs_szBuffer) - 1);
			
			Range[e_iStart] = IP:strval(gs_szBuffer);
			
			db_get_field(dbrResult, 1, gs_szBuffer, sizeof(gs_szBuffer) - 1);

			Range[e_iEnd] = IP:strval(gs_szBuffer);
		}
		
		db_free_result(dbrResult);
	}
}

// This macro makes the function return an array, which normally is quite buggy.
#define GetBanIPRange(%1) (_GetBanIPRange(g_aiTempRange2,%1), g_aiTempRange2)