// Purpose of this module is range banning IP's and prevent them from accesing your server.

#include <YSI_Coding\y_hooks>

/*
                                                                  
88888888888                                                       
88                                                                
88                                                                
88aaaaa     8b,dPPYba,  88       88 88,dPYba,,adPYba,  ,adPPYba,  
88"""""     88P'   `"8a 88       88 88P'   "88"    "8a I8[    ""  
88          88       88 88       88 88      88      88  `"Y8ba,   
88          88       88 "8a,   ,a88 88      88      88 aa    ]8I  
88888888888 88       88  `"YbbdP'Y8 88      88      88 `"YbbdP"'  
                                                                  
*/

enum E_BLOCKED_IP_DATA 
{
	biIp[16],
	biBlockTime
}
static stock
	BlockedIp[][E_BLOCKED_IP_DATA] = 
	{
		{"199.255.*.*", 0},
		{"185.117.*.*", 0},
		{"185.117.*.*", 0},
		{"188.126.71.*.*", 0}
	};


/*

88888888888                                           
88                                                    
88                                                    
88aaaaa 88       88 8b,dPPYba,   ,adPPYba, ,adPPYba,  
88""""" 88       88 88P'   `"8a a8"     "" I8[    ""  
88      88       88 88       88 8b          `"Y8ba,   
88      "8a,   ,a88 88       88 "8a,   ,aa aa    ]8I  
88       `"YbbdP'Y8 88       88  `"Ybbd8"' `"YbbdP"'  

*/

hook OnGameModeInit()
{
	for(new i=0; i < sizeof(BlockedIp); i++)
		BlockIpAddress(BlockedIp[i][biIp], BlockedIp[i][biBlockTime]);
	return 1;
}
