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
	 ______  __       __  _______   __       
	/      |/  \     /  |/       \ /  |      
	$$$$$$/ $$  \   /$$ |$$$$$$$  |$$ |      
	  $$ |  $$$  \ /$$$ |$$ |__$$ |$$ |      
	  $$ |  $$$$  /$$$$ |$$    $$/ $$ |      
	  $$ |  $$ $$ $$/$$ |$$$$$$$/  $$ |      
	 _$$ |_ $$ |$$$/ $$ |$$ |      $$ |_____ 
	/ $$   |$$ | $/  $$ |$$ |      $$       |
	$$$$$$/ $$/      $$/ $$/       $$$$$$$$/ 

*/

stock SetDynamicObjectData(STREAMER_TAG_OBJECT:objectid, Float:stream_distance, Float:draw_distance, priority)
{
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_DRAW_DISTANCE, stream_distance);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_STREAM_DISTANCE, draw_distance);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_PRIORITY, priority);
	return true;
}

stock OptimizeDynamicObject(STREAMER_TAG_OBJECT:objectid)
{
	if(!IsValidDynamicObject(objectid))
		return false;

	new 
		od_modelid = -1,
		Float:od_DrawDistance;

	od_modelid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID);
	#if OD_METHOD
		new Float:od_spherecol = GetColSphereRadius(od_modelid);
		if(od_spherecol <= 0.0)
			SetDynamicObjectData(objectid, 275.0, 275.0, 0);
		else if(od_spherecol <= 11.25)
		{
			od_DrawDistance = od_spherecol * 75;
			if(od_DrawDistance < 210.0)
				od_DrawDistance += 100.0;
			SetDynamicObjectData(objectid, od_DrawDistance, od_DrawDistance, floatround((od_spherecol), floatround_round));
		}
		else
			SetDynamicObjectData(objectid, 1000.0, 1000.0, floatround((od_spherecol), floatround_round));

	#else
		new 
			Float:od_priority,
			Float:od_ModelSize[3];
		
		if(GetModelColDimensions(od_modelid, od_ModelSize[0], od_ModelSize[1], od_ModelSize[2]))
		{
			if(od_ModelSize[0] > 40.0 && od_ModelSize[1] > 40.0 && od_ModelSize[2] < 12.0)
			{
				#if !defined OD_DISABLE_STATIC_OBJECTS
					Streamer_ToggleItemStatic(STREAMER_TYPE_OBJECT, objectid, 1);
				#else
					SetDynamicObjectData(objectid, 400.0, 400.0, 5000);
				#endif
			}
			else
			{
				od_priority = (od_ModelSize[0] * od_ModelSize[1] + od_ModelSize[1] * od_ModelSize[2] + od_ModelSize[2] * od_ModelSize[0]);
				if(od_priority <= 100.0) od_DrawDistance = 300.0;
				else if(od_priority <= 550.0) od_DrawDistance = 365.0;
				else if(od_priority <= 750.0) od_DrawDistance = 435.0;
				else if(od_priority <= 1000.0) od_DrawDistance = 575.0;
				else if(od_priority <= 3000.0) od_DrawDistance = 700.0;
				else if(od_priority <= 5000.0) od_DrawDistance = 850.0;
				else if(od_priority <= 8000.0) od_DrawDistance = 1000.0;
				else if(od_priority > 8000.0) od_DrawDistance = 1300.0;
				SetDynamicObjectData(objectid, od_DrawDistance, od_DrawDistance - 25, floatround((od_priority/450), floatround_round));
			}
		}
		else
			SetDynamicObjectData(objectid, 275.0, 275.0, 0);
	#endif
	return true;
}
