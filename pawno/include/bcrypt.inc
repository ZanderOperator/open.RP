/* The MIT License (MIT)
 * Copyright (c) 2014 Lassi R.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of 
 * this software and associated documentation files (the "Software"), to deal in 
 * the Software without restriction, including without limitation the rights to 
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
 * of the Software, and to permit persons to whom the Software is furnished to do 
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all 
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
 * SOFTWARE.
 */

#if defined bcrypt_included
	#endinput
#endif
#define bcrypt_included

#if !defined HTTP_GET
	#include <a_http>
#endif

#define BCRYPT_HASH_LENGTH 61
#define BCRYPT_PLUGIN_VERSION "2.2.3"

enum BCRYPT_DEBUG_LEVEL {
	BCRYPT_LOG_FATAL,
	BCRYPT_LOG_ERROR,
	BCRYPT_LOG_WARNING,
	BCRYPT_LOG_INFO,
	BCRYPT_LOG_DEBUG,
	BCRYPT_LOG_TRACE
}

native bcrypt_hash(key[], cost = 12, callback_name[], callback_format[] = "", {Float, _}:...);
native bcrypt_check(password[], hash[], callback_name[], callback_format[] = "", {Float, _}:...);
native bcrypt_get_hash(dest[]);
native bool:bcrypt_is_equal();
native bool:bcrypt_needs_rehash(hash[], cost);
native bcrypt_find_cost(time_target = 250);
native bcrypt_set_thread_limit(value);
native bcrypt_debug(BCRYPT_DEBUG_LEVEL:level = BCRYPT_LOG_ERROR);

// Version check
forward OnBcryptVersionCheck(index, response_code, data[]);

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
	{
		HTTP(0, HTTP_GET, "api.ls-rcr.com/bcrypt/?version_check&version=" #BCRYPT_PLUGIN_VERSION, "", "OnBcryptVersionCheck");
		return CallLocalFunction("BCRYPT_OnFilterScriptInit", "");
	}

	forward BCRYPT_OnFilterScriptInit();

	#if defined _ALS_OnFilterScriptInit
	    #undef OnFilterScriptInit
	#else
	    #define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit BCRYPT_OnFilterScriptInit
#else
	public OnGameModeInit()
	{
		HTTP(0, HTTP_GET, "api.ls-rcr.com/bcrypt/?version_check&version=" #BCRYPT_PLUGIN_VERSION, "", "OnBcryptVersionCheck");
		return CallLocalFunction("BCRYPT_OnGameModeInit", "");
	}

	forward BCRYPT_OnGameModeInit();

	#if defined _ALS_OnGameModeInit
	    #undef OnGameModeInit
	#else
	    #define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit BCRYPT_OnGameModeInit
#endif

public OnBcryptVersionCheck(index, response_code, data[])
{
	if(response_code == 200)
	{
		if(!strcmp("OK", data, false, 2))
		{
			print("plugin.bcrypt: The plugin is up-to-date.");
		}
		else if(!strcmp("UPDATE_AVAILABLE_MAJOR", data, false, 22))
		{
			print(" ");
			printf(" * plugin.bcrypt: A MAJOR UPDATE IS AVAILABLE:");
			printf(" * plugin.bcrypt: Current version: %s", BCRYPT_PLUGIN_VERSION);
			printf(" * plugin.bcrypt: Latest version: %s", data[23]);
			printf(" * plugin.bcrypt: Download: http://api.ls-rcr.com/bcrypt/?upgrade");
			printf(" * plugin.bcrypt: Upgrading is highly recommended.");
			print(" ");
		}
		else if(!strcmp("UPDATE_AVAILABLE_MINOR", data, false, 22))
		{
			print(" ");
			printf("plugin.bcrypt: A minor update is available:");
			printf("plugin.bcrypt: Current version: %s", BCRYPT_PLUGIN_VERSION);
			printf("plugin.bcrypt: Latest version: %s", data[23]);
			printf("plugin.bcrypt: Download: http://api.ls-rcr.com/bcrypt/?upgrade");
			printf("plugin.bcrypt: Upgrading is recommended.");
			print(" ");
		}
		else if(!strcmp("UPDATE_AVAILABLE_REVISION", data, false, 25))
		{
			print(" ");
			printf("plugin.bcrypt: A new revision is available:");
			printf("plugin.bcrypt: Current version: %s", BCRYPT_PLUGIN_VERSION);
			printf("plugin.bcrypt: Latest version: %s", data[26]);
			printf("plugin.bcrypt: Download: http://api.ls-rcr.com/bcrypt/?upgrade");
			printf("plugin.bcrypt: Upgrading is recommended.");
			print(" ");
		}
	}
	else
	{
		print("plugin.bcrypt: Version check failed.");
	}

	return 1;
}
