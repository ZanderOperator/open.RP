/*
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
Contributors:
	- algorhitmically

Thanks to:
	- Incognito - streamer plugin.
	- Abagail and Crayder - modelsizes include.

Required plugins:
	- Streamer
*/

/*
	 __    __   ______    ______   __    __   ______
	/  |  /  | /      \  /      \ /  |  /  | /      \
	$$ |  $$ |/$$$$$$  |/$$$$$$  |$$ | /$$/ /$$$$$$  |
	$$ |__$$ |$$ |  $$ |$$ |  $$ |$$ |/$$/  $$ \__$$/
	$$    $$ |$$ |  $$ |$$ |  $$ |$$  $$<   $$      \
	$$$$$$$$ |$$ |  $$ |$$ |  $$ |$$$$$  \   $$$$$$  |
	$$ |  $$ |$$ \__$$ |$$ \__$$ |$$ |$$  \ /  \__$$ |
	$$ |  $$ |$$    $$/ $$    $$/ $$ | $$  |$$    $$/
	$$/   $$/  $$$$$$/   $$$$$$/  $$/   $$/  $$$$$$/

*/

public OnGameModeInit()
{
	#if defined od_OnGameModeInit
		new od_gmi = od_OnGameModeInit();
	#endif
	Streamer_ToggleChunkStream(true);
	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 250);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 975);
	Streamer_SetTickRate(25);
	#if !defined OD_DISABLE_STARTUP_MESSAGE
		print("==================================================");
		print("\t* OptiDraw v1.0.1 loaded successfully.");
		print("\t* By algorhitmically - [03.05.2020.]");
		#if OD_METHOD
		print("\t* Current method: SPHERE");
		#else
		print("\t* Current method: BOX");
		#endif
		print("==================================================");
	#endif
	#if defined od_OnGameModeInit
		return od_gmi;
	#else
		return 1;
	#endif
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit od_OnGameModeInit
#if defined od_OnGameModeInit
	forward od_OnGameModeInit();
#endif

#if defined STREAMER_ENABLE_TAGS
	stock STREAMER_TAG_OBJECT:od_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 325.0, Float:drawdistance = 365.0, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
	{
		new STREAMER_TAG_OBJECT:od_objectid = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, STREAMER_TAG_AREA:areaid, priority)
#else
	stock od_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 325.0, Float:drawdistance = 365.0, STREAMER_TAG_AREA:areaid = -1, priority = 0)
	{
		new od_objectid = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
#endif
	OptimizeDynamicObject(od_objectid);
	return od_objectid;
}

#if defined _ALS_CreateDynamicObject
	#undef CreateDynamicObject
#else
	#define _ALS_CreateDynamicObject
#endif
#define CreateDynamicObject od_CreateDynamicObject

#if defined STREAMER_ENABLE_TAGS
	stock STREAMER_TAG_OBJECT:od_CreateDynamicObjectEx(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:streamdistance = 325.0, Float:drawdistance = 365.0, const worlds[] = { -1 }, const interiors[] = { -1 }, const players[] = { -1 }, const STREAMER_TAG_AREA:areas[] = { STREAMER_TAG_AREA:-1 }, priority = 0, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players, maxareas = sizeof areas)
	{
		new STREAMER_TAG_OBJECT:od_objectid = CreateDynamicObjectEx(modelid, x, y, z, rx, ry, rz, streamdistance, drawdistance, worlds, interiors, players, STREAMER_TAG_AREA:areas, priority, maxworlds, maxinteriors, maxplayers, maxareas);
#else
	stock od_CreateDynamicObjectEx(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:streamdistance = 325.0, Float:drawdistance = 365.0, const worlds[] = { -1 }, const interiors[] = { -1 }, const players[] = { -1 }, const areas[] = { STREAMER_TAG_AREA:-1 }, priority = 0, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players, maxareas = sizeof areas)
	{
		new od_objectid = CreateDynamicObjectEx(modelid, x, y, z, rx, ry, rz, streamdistance, drawdistance, worlds, interiors, players, areas, priority, maxworlds, maxinteriors, maxplayers, maxareas);
#endif
	OptimizeDynamicObject(od_objectid);
	return od_objectid;
}

#if defined _ALS_CreateDynamicObjectEx
	#undef CreateDynamicObjectEx
#else
	#define _ALS_CreateDynamicObjectEx
#endif
#define CreateDynamicObjectEx od_CreateDynamicObjectEx
