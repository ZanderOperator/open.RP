#include <YSI_Coding\y_hooks>

/*
	######## ##     ## ##    ##  ######  ####  #######  ##    ## ########  ######  
	##       ##     ## ###   ## ##    ##  ##  ##     ## ###   ##    ##    ##    ## 
	##       ##     ## ####  ## ##        ##  ##     ## ####  ##    ##    ##       
	######   ##     ## ## ## ## ##        ##  ##     ## ## ## ##    ##     ######  
	##       ##     ## ##  #### ##        ##  ##     ## ##  ####    ##          ## 
	##       ##     ## ##   ### ##    ##  ##  ##     ## ##   ###    ##    ##    ## 
	##        #######  ##    ##  ######  ####  #######  ##    ##    ##     ######  
*/

new 
	g_SQL = 1,
	mysqlHost[32],
	mysqlUser[32],
	mysqlPass[32],
	mysqlDb[32];
	
INI:mysql_settings[settings](name[], value[])
{
    if (!strcmp(name, "host"))
    {
		strcpy(mysqlHost, value, sizeof (mysqlHost));
        return;
    }
	else if (!strcmp(name, "user"))
    {
		strcpy(mysqlUser, value, sizeof (mysqlUser));
        return;
    }
	else if (!strcmp(name, "password"))
    {
		strcpy(mysqlPass, value, sizeof (mysqlPass));
        return;
    }
	else if (!strcmp(name, "database"))
    {
		strcpy(mysqlDb, value, sizeof (mysqlDb));
        return;
    }
}


stock ConnectMySQLDatabase(sqlhost[], sqluser[], sqlpass[], sqldb[])
{
	printf("MySQL Report: Pokusavam se spojiti s databazom...");
	g_SQL = mysql_connect(sqlhost, sqluser, sqldb, sqlpass, 3306, true );
	
	if(!mysql_errno()) {
	    print("MySQL Report: Spajanje s databazom je uspjesno!");
	}
	else if(mysql_errno()) {
		print("MySQL Report: Neuspjelo spajanje s bazom, ponavljamo rekonektiranje!");
		mysql_reconnect();
		
		if(mysql_errno()) {
			print("MySQL Report: Neuspjelo spajanje s bazom, ponavljamo rekonektiranje #2!");
			mysql_reconnect();
		
			if(mysql_errno()) {
				print("MySQL Report: Neuspjelo spajanje s databazom, zatvaram server!");
				SendRconCommand("exit");
				return 1;
			}
		}
	}
	/*#if defined MOD_DEBUG
		mysql_log(LOG_ALL);
	#else
		mysql_log(LOG_ERROR | LOG_WARNING);
	#endif*/
	return 1;
}
