#include <YSI_Coding\y_hooks>

static 
    MySQL:g_SQL,        // Main Database Connection Handler
    va_query[2048];     // Main MySQL query string 

/*

    88888888888                                           
    88                                                    
    88                                                    
    88aaaaa 88       88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
    88""""" 88       88 88P'   `"8a a8"     "" I8[   ""  
    88      88       88 88       88 8b          `"Y8ba,   
    88      "8a,   ,a88 88       88 "8a,   ,aa aa   ]8I  
    88       `"YbbdP'Y8 88       88  `"Ybbd8"' `"YbbdP"'  

*/

MySQL:SQL_Handle()
{
    return g_SQL;
}

// Formated mysql_tquery
mysql_fquery(MySQL:connectionHandle, const fquery[], va_args<>)
{
	mysql_format(connectionHandle, va_query, sizeof(va_query), fquery, va_start<2>);
	return mysql_tquery(connectionHandle, va_query);
}

// Formated mysql_pquery
mysql_fquery_ex(MySQL:connectionHandle, const fquery[], va_args<>)
{
	mysql_format(connectionHandle, va_query, sizeof(va_query), fquery, va_start<2>);
	return mysql_pquery(connectionHandle, va_query);
}

// Formated mysql_format with direct string returning
va_fquery(MySQL:connectionHandle, const fquery[], va_args<>)
{
	mysql_format(connectionHandle, va_query, sizeof(va_query), fquery, va_start<2>);
	return va_query;
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
    Log_Write("logfiles/AMX_Query_Log.txt", 
        "[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s", 
        ReturnDate(), 
        errorid, 
        error, 
        callback, 
        query
    );
    printf("[%s] - MySQL Error ID: %d\nError %s: Callback %s\nQuery: %s", 
        ReturnDate(), 
        errorid, 
        error, 
        callback, 
        query    
    );
    return 1;
}

/*

    88        88                         88                   
    88        88                         88                   
    88        88                         88                   
    88aaaaaaaa88  ,adPPYba,   ,adPPYba,  88   ,d8  ,adPPYba,  
    88""""""""88 a8"     "8a a8"     "8a 88 ,a8"   I8[   ""  
    88        88 8b       d8 8b       d8 8888[     `"Y8ba,   
    88        88 "8a,   ,a8" "8a,   ,a8" 88`"Yba,  aa   ]8I  
    88        88  `"YbbdP"'   `"YbbdP"'  88   `Y8a `"YbbdP"'  

*/

hook OnGameModeInit()
{
	g_SQL = mysql_connect_file();
	if(g_SQL == MYSQL_INVALID_HANDLE)
	{
		print("[SERVER ERROR]: Failed to connect MySQL Database!");
		return 1;
	}
	mysql_log(ERROR | WARNING);
	print("Report: MySQL Connection & Log Mode Established.");

    // Global Loads - Database Load Functions
	LoadServerData();
    return 1;
}

hook OnGameModeExit()
{
    mysql_close();
    return 1;
}