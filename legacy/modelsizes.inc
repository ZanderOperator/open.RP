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

	Thanks Y-Less for releasing the old one (modelsizes).
	Thanks Pottus, Chris420, and Slice for ColAndreas (making this possible).
	Thanks Abagail and Crayder for creating modelsizes.
	
	SQL Version of modelsizes by: algorhitmically
	
	 __       __   ______   _______   ________  __         ______   ______  ________  ________   ______            ______    ______   __       
	/  \     /  | /      \ /       \ /        |/  |       /      \ /      |/        |/        | /      \          /      \  /      \ /  |      
	$$  \   /$$ |/$$$$$$  |$$$$$$$  |$$$$$$$$/ $$ |      /$$$$$$  |$$$$$$/ $$$$$$$$/ $$$$$$$$/ /$$$$$$  |        /$$$$$$  |/$$$$$$  |$$ |      
	$$$  \ /$$$ |$$ |  $$ |$$ |  $$ |$$ |__    $$ |      $$ \__$$/   $$ |      /$$/  $$ |__    $$ \__$$/  ______ $$ \__$$/ $$ |  $$ |$$ |      
	$$$$  /$$$$ |$$ |  $$ |$$ |  $$ |$$    |   $$ |      $$      \   $$ |     /$$/   $$    |   $$      \ /      |$$      \ $$ |  $$ |$$ |      
	$$ $$ $$/$$ |$$ |  $$ |$$ |  $$ |$$$$$/    $$ |       $$$$$$  |  $$ |    /$$/    $$$$$/     $$$$$$  |$$$$$$/  $$$$$$  |$$ |_ $$ |$$ |      
	$$ |$$$/ $$ |$$ \__$$ |$$ |__$$ |$$ |_____ $$ |_____ /  \__$$ | _$$ |_  /$$/____ $$ |_____ /  \__$$ |        /  \__$$ |$$ / \$$ |$$ |_____ 
	$$ | $/  $$ |$$    $$/ $$    $$/ $$       |$$       |$$    $$/ / $$   |/$$      |$$       |$$    $$/         $$    $$/ $$ $$ $$< $$       |
	$$/      $$/  $$$$$$/  $$$$$$$/  $$$$$$$$/ $$$$$$$$/  $$$$$$/  $$$$$$/ $$$$$$$$/ $$$$$$$$/  $$$$$$/           $$$$$$/   $$$$$$  |$$$$$$$$/ 
																																$$$/           
*/

new DB:ModelSizes;

stock ms_LoadDB()
{
	if(db_get_mem_handle(ModelSizes) != 0)
		return true;
	if(!fexist("modelsizes.db")) 
	{
		print("ERROR: (modelsizes-SQL): Cannot find \"modelsizes.db\".");
		SendRconCommand("exit");
		return false;
	}
	if((ModelSizes = db_open("modelsizes.db")) == DB:0)
	{
		print("ERROR: (modelsizes-SQL): Failed to load database \"modelsizes.db\".");
		SendRconCommand("exit");
		return false;
	}
	else
		print("(modelsizes-SQL): Database loaded successfully.");
	return true;
}

public OnGameModeExit()
{
	#if defined _ms_OnGameModeExit
		new ms_ = _ms_OnGameModeExit();
	#endif
	if(db_get_mem_handle(ModelSizes) != 0)
		db_close(ModelSizes);
	#if defined _ms_OnGameModeExit
		return ms_;
	#else
		return 1;
	#endif
}

#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit _ms_OnGameModeExit
#if defined _ms_OnGameModeExit
	forward _ms_OnGameModeExit();
#endif


stock GetColCount()
{
	ms_LoadDB();
	new Query[64], dOut = 0, DBResult:query;

    format(Query, sizeof(Query), "SELECT COUNT(ColRadius) AS ColCount FROM modelsizes");
    query = db_query(ModelSizes, Query);
    if(db_num_rows(query) > 0) {
        dOut = db_get_field_assoc_int(query, "ColCount");
        db_free_result(query);
    }
    return dOut;
}

stock Float:GetColSphereRadius(objectmodel)
{
	ms_LoadDB();
	new Query[64], Float:dOut = 0.0, DBResult:query;
	
    format(Query, sizeof(Query), "SELECT ColRadius FROM modelsizes WHERE modelid = %d", objectmodel);
    query = db_query(ModelSizes, Query);
	if(db_num_rows(query) > 0)
	{
 		dOut = db_get_field_assoc_float(query, "ColRadius");
        db_free_result(query);
		return dOut;
	}
	return 0.0;
}

stock GetColSphereOffset(objectmodel, &Float:x, &Float:y, &Float:z)
{
	ms_LoadDB();
	new Query[86], DBResult:query;

    format(Query, sizeof(Query), "SELECT ColOffsetX, ColOffsetY, ColOffsetZ FROM modelsizes WHERE modelid = %d", objectmodel);
    query = db_query(ModelSizes, Query);
   	if(db_num_rows(query) > 0)
	{
		x = db_get_field_assoc_float(query, "ColOffsetX");
		y = db_get_field_assoc_float(query, "ColOffsetY");
		z = db_get_field_assoc_float(query, "ColOffsetZ");
		return 1;
	}
	else
	{
		x =
		y =
		z = 0.0;
	}
	return 0;
}

stock GetModelBoundingBox(objectmodel, &Float:MinX, &Float:MinY, &Float:MinZ, &Float:MaxX, &Float:MaxY, &Float:MaxZ)
{
	ms_LoadDB();
	new Query[96], DBResult:query;

    format(Query, sizeof(Query), "SELECT MinX, MinY, MinZ, MaxX, MaxY, MaxZ FROM modelsizes WHERE modelid = %d", objectmodel);
    query = db_query(ModelSizes, Query);
   	if(db_num_rows(query) > 0)
	{
		MinX = db_get_field_assoc_float(query, "MinX");
		MinY = db_get_field_assoc_float(query, "MinY");
		MinZ = db_get_field_assoc_float(query, "MinZ");
		MaxX = db_get_field_assoc_float(query, "MaxX");
		MaxY = db_get_field_assoc_float(query, "MaxY");
		MaxZ = db_get_field_assoc_float(query, "MaxZ");
		return 1;
	}
	else
	{
		MinX =
		MinY =
		MinZ =
		MaxX =
		MaxY =
		MaxZ = 0.0;
	}
	return 0;
}

stock GetModelColDimensions(objectmodel, &Float:l, &Float:w, &Float:h)
{
	ms_LoadDB();
	new Query[96], DBResult:query;

    format(Query, sizeof(Query), "SELECT MinX, MinY, MinZ, MaxX, MaxY, MaxZ FROM modelsizes WHERE modelid = %d", objectmodel);
    query = db_query(ModelSizes, Query);
   	if(db_num_rows(query) > 0)
	{
		l = floatabs(db_get_field_assoc_float(query, "MaxX") - db_get_field_assoc_float(query, "MinX"));
		w = floatabs(db_get_field_assoc_float(query, "MaxY") - db_get_field_assoc_float(query, "MinY"));
		h = floatabs(db_get_field_assoc_float(query, "MaxZ") - db_get_field_assoc_float(query, "MinZ"));
		return 1;
	}
	else
	{
		l =
		w =
		h = 0.0;
	}
	return 0;
}
