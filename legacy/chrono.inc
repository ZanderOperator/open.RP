// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_chrono
	#undef _inc_chrono
#endif
// custom include-guard to ensure we don't duplicate
#if defined _chrono_included
	#endinput
#endif
#define _chrono_included


// -
// Unit Conversions - Months/Years are rough approximations
// -

#define TIME_UNITS {Milliseconds,Seconds,Minutes,Hours,Days,Weeks,Months,Years}

const Milliseconds:SecondInMilliseconds = Milliseconds:1_000;
const Milliseconds:MinuteInMilliseconds = Milliseconds:60_000;
const Milliseconds:HourInMilliseconds =   Milliseconds:3_600_000;
const Milliseconds:DayInMilliseconds =    Milliseconds:86_400_000;
const Milliseconds:WeekInMilliseconds =   Milliseconds:604_800_000;
const Milliseconds:MonthInMilliseconds =  Milliseconds:2_629_746_000;
// const Milliseconds:YearInMilliseconds =   Milliseconds:31556952000; // overflow!

const Seconds:MinuteInSeconds = Seconds:60;
const Seconds:HourInSeconds =   Seconds:3_600;
const Seconds:DayInSeconds =    Seconds:86_400;
const Seconds:WeekInSeconds =   Seconds:604_800;
const Seconds:MonthInSeconds =  Seconds:2_629_746;
const Seconds:YearInSeconds =   Seconds:31_556_952;

const Minutes:HourInMinutes =  Minutes:60;
const Minutes:DayInMinutes =   Minutes:1_440;
const Minutes:WeekInMinutes =  Minutes:10_080;
const Minutes:MonthInMinutes = Minutes:(Minutes:MonthInSeconds / Minutes:60);
const Minutes:YearInMinutes =  Minutes:(Minutes:MonthInMinutes * Minutes:12);

const Hours:DayInHours =   Hours:12;
const Hours:WeekInHours =  Hours:(Hours:DayInHours * Hours:7);
const Hours:MonthInHours = Hours:(Hours:MonthInMinutes / Hours:60);
const Hours:YearInHours =  Hours:(Hours:MonthInHours * Hours:12);

const Days:WeekInDays =  Days:7;
const Days:MonthInDays = Days:30; // 30.4375
const Days:YearInDays =  Days:365; // no leap years

const Weeks:YearInWeeks = Weeks:52;


// -
// Format Specifiers
// -

#define WEEKDAY_NAME_ABV  "%a" // The locale's abbreviated weekday name. If the value does not contain a valid weekday, std::ios::failbit is set.
#define WEEKDAY_NAME      "%A" // The locale's full weekday name. If the value does not contain a valid weekday, std::ios::failbit is set.
#define MONTH_NAME_ABV    "%b" // The locale's abbreviated month name. If the value does not contain a valid month, std::ios::failbit is set.
#define MONTH_NAME        "%B" // The locale's full month name. If the value does not contain a valid month, std::ios::failbit is set.
#define YEAR_DIV          "%C" // The year divided by 100 using floored division. If the result is a single decimal digit, it is prefixed with 0. The modified command %EC produces the locale's alternative representation of the century.
#define DAY_OF_MONTH      "%d" // The day of month as a decimal number. If the result is a single decimal digit, it is prefixed with 0. The modified command %Od produces the locale's alternative representation.
#define DATE_MDY          "%D" // Equivalent to %m/%d/%y - aka the dumb american date format
#define DAY_OF_MONTH_PAD  "%e" // The day of month as a decimal number. If the result is a single decimal digit, it is prefixed with a space. The modified command %Oe produces the locale's alternative representation.
#define DATE_YMD          "%F" // Equivalent to %Y-%m-%d - aka the international standard date format
#define WEEK_NUMBER_ISO   "%g" // The last two decimal digits of the ISO week-based year. If the result is a single digit it is prefixed by 0.
#define YEAR_PAD          "%G" // The ISO week-based year as a decimal number. If the result is less than four digits it is left-padded with 0 to four digits.
#define HOUR_24           "%H" // The hour (24-hour clock) as a decimal number. If the result is a single digit, it is prefixed with 0. The modified command %OH produces the locale's alternative representation.
#define HOUR_12           "%I" // The hour (12-hour clock) as a decimal number. If the result is a single digit, it is prefixed with 0. The modified command %OI produces the locale's alternative representation.
#define DAY_OF_YEAR       "%j" // The day of the year as a decimal number. Jan 1 is 001. If the result is less than three digits, it is left-padded with 0 to three digits.
#define MONTH             "%m" // The month as a decimal number. Jan is 01. If the result is a single digit, it is prefixed with 0. The modified command %Om produces the locale's alternative representation.
#define MINUTE            "%M" // The minute as a decimal number. If the result is a single digit, it is prefixed with 0. The modified command %OM produces the locale's alternative representation.
#define NEWLINE_CHAR      "%n" // A newline character.
#define MERIDIAN          "%p" // The locale's equivalent of the AM/PM designations associated with a 12-hour clock.
#define TIME_12           "%r" // The locale's 12-hour clock time.
#define HM_COLON          "%R" // Equivalent to %H:%M.
#define SECOND            "%S" // Seconds as a decimal number. If the number of seconds is less than 10, the result is prefixed with 0. If the precision of the input can not be exactly represented with seconds, then the format is a decimal floating point number with a fixed format and a precision matching that of the precision of the input (or to a microseconds precision if the conversion to floating point decimal seconds can not be made within 18 fractional digits). The character for the decimal point is localized according to the locale. The modified command %OS produces the locale's alternative representation.
#define TAB_CHAR          "%t" // A horizontal-tab character.
#define HMS_COLON         "%T" // Equivalent to %H:%M:%S.
#define WEEK_DAY          "%u" // The ISO weekday as a decimal number (1-7), where Monday is 1. The modified command %Ou produces the locale's alternative representation.
#define WEEK_OF_YEAR      "%U" // The week number of the year as a decimal number. The first Sunday of the year is the first day of week 01. Days of the same year prior to that are in week 00. If the result is a single digit, it is prefixed with 0. The modified command %OU produces the locale's alternative representation.
#define WEEK_OF_YEAR_ZERO "%V" // The ISO week-based week number as a decimal number. If the result is a single digit, it is prefixed with 0. The modified command %OV produces the locale's alternative representation.
#define WEEK_DAY_ZERO     "%w" // The weekday as a decimal number (0-6), where Sunday is 0. The modified command %Ow produces the locale's alternative representation.
#define WEEK_OF_YEAR_ALT  "%W" // The week number of the year as a decimal number. The first Monday of the year is the first day of week 01. Days of the same year prior to that are in week 00. If the result is a single digit, it is prefixed with 0. The modified command %OW produces the locale's alternative representation.
#define LOCALE_DATE       "%x" // The locale's date representation. The modified command %Ex produces the locale's alternate date representation.
#define LOCALE_TIME       "%X" // The locale's time representation. The modified command %Ex produces the locale's alternate time representation.
#define YEAR_ABV          "%y" // The last two decimal digits of the year. If the result is a single digit it is prefixed by 0.
#define YEAR              "%Y" // The year as a decimal number. If the result is less than four digits it is left-padded with 0 to four digits.
#define UTC_OFFSET        "%z" // The offset from UTC in the ISO 8601 format. For example -0430 refers to 4 hours 30 minutes behind UTC. If the offset is zero, +0000 is used. The modified commands %Ez and %Oz insert a : between the hours and minutes: -04:30. If the offset information is not available,  failbit will be set.
#define TIME_ZONE_ABV     "%Z" // The time zone abbreviation. If the time zone abbreviation is not available, failbit will be set.  UTC is used for sys_time.
#define PERCENTAGE        "%%" // A % character.


// -
// Format Tempates
// -

#define HUMAN_DATE         "%d/%m/%y"           // 31/05/18
#define ISO6801_TIME       "%H:%M:%S"           // 09:55:22
#define ISO6801_DATE       "%Y-%m-%d"           // 2018-05-31
#define ISO6801_FULL_UTC   "%Y-%m-%dT%H:%M:%SZ" // 2018-05-31T09:55:22Z
#define ISO6801_FULL_LOCAL "%Y-%m-%dT%H:%M:%S"  // 2018-05-31T09:55:22


// -
// Natives
// -

native Timestamp:Now();
native TimeFormat(ts, const fmt[], output[], len = sizeof output);
native TimeParse(const string[], const fmt[], &Timestamp:output);
native DurationParse(const string[], &Milliseconds:output);


// -
// Conversion Operators
// -

// Difference
stock Seconds:operator-(Timestamp:future, Timestamp:past) {
	return Seconds:(_:future - _:past);
}

// Seconds
stock Timestamp:operator+(Timestamp:t, Seconds:d) {
	return Timestamp:(_:t + _:d);
}
stock Timestamp:operator-(Timestamp:t, Seconds:d) {
	return Timestamp:(_:t - _:d);
}

// Minutes
stock Timestamp:operator+(Timestamp:t, Minutes:d) {
	return Timestamp:(_:t + (_:MinuteInSeconds * _:d));
}
stock Timestamp:operator-(Timestamp:t, Minutes:d) {
	return Timestamp:(_:t - (_:MinuteInSeconds * _:d));
}

// Hours
stock Timestamp:operator+(Timestamp:t, Hours:d) {
	return Timestamp:(_:t + (_:HourInSeconds * _:d));
}
stock Timestamp:operator-(Timestamp:t, Hours:d) {
	return Timestamp:(_:t - (_:HourInSeconds * _:d));
}

// Days
stock Timestamp:operator+(Timestamp:t, Days:d) {
	return Timestamp:(_:t + (_:DayInSeconds * _:d));
}
stock Timestamp:operator-(Timestamp:t, Days:d) {
	return Timestamp:(_:t - (_:DayInSeconds * _:d));
}


// -
// Helpers
// -

stock DurationFormat(Seconds:duration, output[], len = sizeof output) {
	new
		Seconds:years,
		Seconds:days,
		Seconds:hours,
		Seconds:minutes;

	if(duration > YearInSeconds) {
		years = (duration / YearInSeconds);
		duration -= (YearInSeconds * years);
	}

	if(duration > DayInSeconds) {
		days = (duration / DayInSeconds);
		duration -= (DayInSeconds * days);
	}

	if(duration > HourInSeconds) {
		hours = (duration / HourInSeconds);
		duration -= (HourInSeconds * hours);
	}

	if(duration > MinuteInSeconds) {
		minutes = (duration / MinuteInSeconds);
		duration -= (MinuteInSeconds * minutes);
	}

	if(years > Seconds:0) {
		format(
			output,
			len,
			"%s%d year%s",
			output,
			_:years,
			(_:years > 1) ? ("s, ") : (", ")
		);
	}
	if(days > Seconds:0) {
		format(
			output,
			len,
			"%s%d day%s",
			output,
			_:days,
			(_:days > 1) ? ("s, ") : (", ")
		);
	}
	if(hours > Seconds:0) {
		format(
			output,
			len,
			"%s%d hour%s",
			output,
			_:hours,
			(_:hours > 1) ? ("s, ") : (", ")
		);
	}
	if(minutes > Seconds:0) {
		format(
			output,
			len,
			"%s%d minute%s",
			output,
			_:minutes,
			(_:minutes > 1) ? ("s, ") : (", ")
		);
	}

	if(duration > Seconds:0) {
		format(
			output,
			len,
			"%s%d second%s",
			output,
			_:duration,
			(_:duration > 1) ? ("s, ") : (", ")
		);
	}

	// trim the trailing comma
	output[strlen(output) - 2] = EOS;

	return 0;
}
