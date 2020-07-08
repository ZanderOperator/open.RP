/*
	##     ##    ###     ######  ########   #######   ######  
	###   ###   ## ##   ##    ## ##     ## ##     ## ##    # 
	#### ####  ##   ##  ##       ##     ## ##     ## ##       
	## ### ## ##     ## ##       ########  ##     ##  ######  
	##     ## ######### ##       ##   ##   ##     ##       ## 
	##     ## ##     ## ##    ## ##    ##  ##     ## ##    ## 
	##     ## ##     ##  ######  ##     ##  #######   ######  
*/

// Debug
#if defined MOD_DEBUG
	stock CreateDynamicObject_DEBUG(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 200.0, Float:drawdistance = 0.0)
	{
		new
			objectid = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance);
		#if defined MOD_DEBUG
			//printf("[DEBUG] CreateDynamicObject: objectid(%d)", objectid);
		#endif
		return objectid;
	}

	#define CreateDynamicObject CreateDynamicObject_DEBUG

	stock DestroyDynamicObject_DEBUG(objectid)
	{
		if( !IsValidDynamicObject(objectid) ) 
			return 0;
		#if defined MOD_DEBUG
			printf("[DEBUG] DestroyDynamicObject: objectid(%d)", objectid);
		#endif
		return DestroyDynamicObject(objectid);
	}

	#define DestroyDynamicObject DestroyDynamicObject_DEBUG

	stock EditDynamicObject_DEBUG(playerid, objectid)
	{
		if( !IsValidDynamicObject(objectid) ) return 0;
		#if defined MOD_DEBUG
			printf("[DEBUG] EditDynamicObject: playerid(%d) | objectid(%d)", playerid, objectid);
		#endif
		return EditDynamicObject(playerid, objectid);
	}
	#define EditDynamicObject EditDynamicObject_DEBUG
#endif 

//KickEx
#define KickMessage(%0) \
	SetTimerEx("KickPlayer",55,false,"d",%0)
//BanEx
#define BanMessage(%0) \
	SetTimerEx("BanPlayer",55,false,"d",%0)

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
	
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	
#define PovecajPVarInt(%0,%1,%2) SetPVarInt(%0, %1, GetPVarInt(%0, %1) + %2)
#define MAX_LOCATION_NAME 38

enum PLAYER_LOCATION
{
	SanAdreas_LocationNames[38],
	Float:SanAndreas_Area[6]
};

static const SanAndreas_PlayerLocation[][PLAYER_LOCATION] =
{
 	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Section",          {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Section",          {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Section",          {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Section",          {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemical",         {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemical",         {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"Castillo del Diablo",         {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"Castillo del Diablo",         {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"Castillo del Diablo",         {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"KACC Military Fuels",         {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"LS International",            {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"LS International",            {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"LS International",            {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"LS International",            {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"LS International",            {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"LS International",            {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Section",     		{1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Section",     		{1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Section",     		{1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Ind. Estate",        {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Section",              {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"Four Dragons Casino",         {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

stock IsPlayerFalling(playerid)
{
	if(GetPlayerAnimationIndex(playerid) == 1195 || GetPlayerAnimationIndex(playerid) == 1197 || GetPlayerAnimationIndex(playerid) == 1133 || GetPlayerAnimationIndex(playerid) == 1130)
	{
		new Float:Z;
		GetPlayerVelocity(playerid, Z, Z, Z);
		if(Z != 0)
		{
		    return 1;
		}
	}
	return 0;
}

stock GetPlayerPreviousInfo(playerid)
{
	GetPlayerPos(playerid, PlayerPrevInfo[playerid][oPosX], PlayerPrevInfo[playerid][oPosY], PlayerPrevInfo[playerid][oPosZ]);
	PlayerPrevInfo[playerid][oInt] = GetPlayerInterior(playerid);
	PlayerPrevInfo[playerid][oViwo] = GetPlayerVirtualWorld(playerid);
	return 1;
}

stock SetPlayerPreviousInfo(playerid)
{
	SetPlayerPos(playerid, PlayerPrevInfo[playerid][oPosX], PlayerPrevInfo[playerid][oPosY], PlayerPrevInfo[playerid][oPosZ]);
	SetPlayerInterior(playerid, PlayerPrevInfo[playerid][oInt]);
	SetPlayerVirtualWorld(playerid, PlayerPrevInfo[playerid][oViwo]);
	SetCameraBehindPlayer(playerid);
	ResetPlayerPreviousInfo(playerid);
	return 1;
}

stock ResetPlayerPreviousInfo(playerid)
{
	PlayerPrevInfo[playerid][oPosX]			= 0.0;
	PlayerPrevInfo[playerid][oPosY]			= 0.0;
	PlayerPrevInfo[playerid][oPosZ]			= 0.0;
	PlayerPrevInfo[playerid][oInt]			= 0;
	PlayerPrevInfo[playerid][oViwo]			= 0;
	return 1;
}

stock RandomPlayerCameraView(playerid)
{
	new choosecamera = random(3);
	SetPlayerVirtualWorld(playerid, random(9999));
	
 	switch(choosecamera)
  	{
  		case 0:
  		{
  		    SetPlayerPos(playerid, 1148.4430,-1344.8217,13.6616);
  		    InterpolateCameraPos(playerid, 927.724792, -1286.564941, 51.656623, 1397.496093, -1415.905517, 32.533592, 30000);
			InterpolateCameraLookAt(playerid, 932.431823, -1288.218383, 51.324836, 1392.709960, -1414.556640, 32.011108, 30000);
       	}
       	case 1:
  		{
  		    SetPlayerPos(playerid, 2275.1340,-1700.6871,13.6479);
  		    InterpolateCameraPos(playerid, 2042.767822, -1470.297851, 54.489799, 2546.400146, -1771.930541, 41.233219, 30000);
			InterpolateCameraLookAt(playerid, 2047.054321, -1472.868164, 54.349193, 2542.777832, -1768.697875, 40.037876, 30000);
       	}
       	case 2:
  		{
  		    SetPlayerPos(playerid, 2411.5686,-1106.1973,40.1652);
  		    InterpolateCameraPos(playerid, 2515.796142, -1008.902709, 88.511833, 2062.358886, -1379.888061, 46.693622, 30000);
			InterpolateCameraLookAt(playerid, 2511.572509, -1011.466735, 87.745338, 2063.165771, -1375.001464, 46.008289, 30000);
       	}
    }
	return (true);
}

stock GetPlayerLocation(playerid)
{
	new GetPlayerLocationStreet[MAX_LOCATION_NAME];
   	PlayerLocation_Pos(playerid,GetPlayerLocationStreet,sizeof(GetPlayerLocationStreet));
   	return GetPlayerLocationStreet;
}

stock PlayerLocation_Pos(playerid, zone[], len)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i != sizeof(SanAndreas_PlayerLocation); i++ )
    {
        if(x >= SanAndreas_PlayerLocation[i][SanAndreas_Area][0] && x <= SanAndreas_PlayerLocation[i][SanAndreas_Area][3] && y >= SanAndreas_PlayerLocation[i][SanAndreas_Area][1] && y <= SanAndreas_PlayerLocation[i][SanAndreas_Area][4])
        {
            return format(zone, len, SanAndreas_PlayerLocation[i][SanAdreas_LocationNames], 0);
        }
    }
    return 0;
}

stock IsValidSkin(skinid)
	return (0 <= skinid <= 311);

stock IsVehicleOccupied(vehicleid) // Returns 1 if there is anyone in the vehicle
{
    foreach(new i : Player) 
	{
        if(IsPlayerInAnyVehicle(i))  
		{
            if(GetPlayerVehicleID(i) == vehicleid)
                return 1;
        }
    }
	return 0;
}

stock RemovePlayersFromVehicle(vehicleid)
{
	foreach(new i : Player)
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			SendMessage(i, MESSAGE_TYPE_INFO, "Vozilo je u procesu sigurnog parkiranja. Molimo nemojte ulaziti u njega 5 sekundi!");
		}
	}
	return 1;
}

stock GetWeaponSlot(weaponid)
{
	new 
		slot;
	switch(weaponid) {
		case 0,1: 			slot = 0;
		case 2 .. 9: 		slot = 1;
		case 10 .. 15: 		slot = 10;
		case 16 .. 18, 39: 	slot = 8;
		case 22 .. 24: 		slot = 2;
		case 25 .. 27: 		slot = 3;
		case 28, 29, 32:	slot = 4;
		case 30, 31: 		slot = 5;
		case 33, 34: 		slot = 6;
		case 35 .. 38: 		slot = 7;
		case 40: 			slot = 12;
		case 41 .. 43: 		slot = 9;
		case 44 .. 46: 		slot = 11;
	}
	return slot;
}
stock IsCrounching(playerid) return (GetPlayerAnimationIndex(playerid) == 1159 || GetPlayerAnimationIndex(playerid) == 1274 ? true : false);  

stock SetAnimationForWeapon(playerid, weaponid, crounch=false) // ApplyAnimation(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync); 
{ 
     switch(weaponid) 
     { 
		case 22: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "COLT45", "python_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 23: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "SILENCED", "CrouchReload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "SILENCED", "Silence_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 24: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "PYTHON", "python_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "PYTHON", "python_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 25, 27: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "BUDDY", "buddy_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 26: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "COLT45", "colt45_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 29..31, 33, 34: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "RIFLE", "RIFLE_crouchload", 8.2,0,0,0,0,0, 1, 0); 
            else ApplyAnimationEx(playerid, "RIFLE", "rifle_load", 8.2,0,0,0,0,0, 1, 0);
        } 
        case 28, 32: 
        { 
            if(crounch) ApplyAnimationEx(playerid, "TEC", "TEC_crouchreload", 8.2,0,0,0,0,0, 1, 0);
            else ApplyAnimationEx(playerid, "TEC", "tec_reload", 8.2,0,0,0,0,0, 1, 0);
        } 
    }
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
    for(new i=0; sstring[i] != EOS; i++) {
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

// Strlib by Slice
forward strcount(const string[], const sub[], bool:ignorecase = false, bool:count_overlapped = false);
stock strcount(const string[], const sub[], bool:ignorecase = false, bool:count_overlapped = false) 
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

forward bool:isempty(const string[]);
stock bool:isempty(const string[]) {
	if (ispacked(string))
		return string{0} == '\0';
	else
		return string[0] == '\0';
}
	
/*
	##     ##  #######   #######  ##    ##  ######  
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ## ##     ## ##     ## ##  ##   ##       
	######### ##     ## ##     ## #####     ######  
	##     ## ##     ## ##     ## ##  ##         ## 
	##     ## ##     ## ##     ## ##   ##  ##    ## 
	##     ##  #######   #######  ##    ##  ######  
*/
stock DEB_KillTimer(timerid)
{
	if( !timerid ) return 0;
	KillTimer(timerid);
    return 1;
}
#if defined _ALS_KillTimer
    #undef KillTimer
#else
    #define _ALS_KillTimer
#endif
#define KillTimer DEB_KillTimer

stock FIX_DestroyDynamicCP(checkpointid)
{
	if( !IsValidDynamicCP(checkpointid) || !checkpointid ) return 0;

	DestroyDynamicCP(checkpointid);
    return 1;
}
#if defined _ALS_DestroyDynamicCP
    #undef DestroyDynamicCP
#else
    #define _ALS_DestroyDynamicCP
#endif
#define DestroyDynamicCP FIX_DestroyDynamicCP
	
/*
	##     ## ######## #### ##        ######  
	##     ##    ##     ##  ##       ##    ## 
	##     ##    ##     ##  ##       ##       
	##     ##    ##     ##  ##        ######  
	##     ##    ##     ##  ##             ## 
	##     ##    ##     ##  ##       ##    ## 
	 #######     ##    #### ########  ######  
*/
stock IsPlayerUsingVPN(playerid)
{
	new 
		plrIP[16];
    GetPlayerIp(playerid, plrIP, sizeof(plrIP));
	new
		string[ 128 ];
	format( string, 128, "cityofangels-roleplay.com/abrakadabra/vpn_detection.php?ip=%s", plrIP );
	HTTP(playerid, HTTP_GET, string, "", "VpnHttpResponse");
	return 1;
}

stock wait(ms)
{
    ms += GetTickCount();
    while(GetTickCount() < ms) {}
}

stock OOCNews(color, const string[])
{
	foreach (new i : Player) 
	{
		if( IsPlayerLogged(i) || IsPlayerConnected(playerid) )
			SendClientMessage(i, color, string);
	}
}

stock IsANoTrunkVehicle(modelid)
{
	switch(modelid)
	{
	    case 403,406,407,408,416,417,423,424,425,430,432,434,435,441,443,444,446,447,449,450,452,453,454,457,460,464,465,469,472,473,476,481,485,486,493,494,495,501,502,503,504,505,509,510,512,513,514,515,520,524,525,528,530,531,532,537,538,539,544,552,556,557,564,568,569,570,571,572,573,574,578,583,584, 590,591,592,593,594,595,601,606,607,608,610,611:
	        return true;
	}
	return false;
}

stock GetServerTime(&hours=0, &minutes=0, &seconds=0)
{
	gettime(hours,minutes,seconds);
	if(hours == 24) hours = 0;
	if(minutes <= 0) minutes = 0;
}

stock bool:IsPlayerMoving(playerid)
{
    new Float:Velocity[3];
    GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
    if(Velocity[0] == 0 && Velocity[1] == 0 && Velocity[2] == 0) return false;
    return true;
}

stock IsValidVehicleModel(model)
{
    if(model >= 400 && model <= 611)
    {
        return true;
    }
    return false;
}

stock GetClosestVehicle(playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) 
		return GetPlayerVehicleID(playerid);
	
	new
		vehicleid = INVALID_VEHICLE_ID;
	foreach(new i : Vehicles)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(i, X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 3.0, X, Y, Z)) // 5.0
		{
			vehicleid = i;
			break;
		}
	}
	return vehicleid;
}

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

stock CustomStreamObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 200.0, Float:drawdistance = 0.0)
{
	if( streamdistance == 0.0 || streamdistance == 200.0 ) 
		streamdistance = (50.0 + GetColSphereRadius(modelid));
	if( drawdistance == 0.0 ) 
		drawdistance = (50.0 + GetColSphereRadius(modelid));
    return CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance);
}

stock damagePlayer(playerid, Float: fDamage) {
    new
        Float: fHealth,
        Float: fArmour
    ;
    GetPlayerHealth(playerid, fHealth);
    GetPlayerArmour(playerid, fArmour);
    
    fHealth += fArmour - fDamage;
    
    SetPlayerArmour(playerid, (fHealth > 100.0) ? (fHealth - 100.0) : (0.0));
    SetPlayerHealth(playerid, (fHealth > 100.0) ? (100.0) : (fHealth));
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	if ( health >= 100.0 )
		SetPlayerHealth(playerid, 150.0);
	else
		SetPlayerHealth(playerid,health+Health);
}

stock IsALowrider(modelid)
{
	switch( modelid ) {
		case 412, 534, 535, 536, 567, 575, 576: return 1;
		default: return 0;
	}
	return 0;
}

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

/**
    <summary>
        ProduZena verzija SetPlayerPos funkcije s dodatkom instantnog updatea Streamera, virtual worlda i interiora.
    </summary>

    <param name="playerid">
        Samo objasnjivo.
    </param>
	
	<param name="x">
        Stavlja igraca na zadanu X os.
    </param>
	
	<param name="y">
        Stavlja igraca na zadanu Y os.
    </param>
	
	<param name="z">
        Stavlja igraca na zadanu Z os.
    </param>
	
	<param name="viwo">
        Virutal world u koji Zelimo poslati igraca.
    </param>
	
	<param name="interior">
        Interior u koji Zelimo poslati igraca.
    </param>
	
	<param name="update">
        Dali Zelimo da se Streamer automatski updatea (lagg) ili da freeza igraca na 3 sekunde i updatea Streamer.
    </param>

    <returns>
        Uvijek 1
    </returns>

    <remarks>
        -
    </remarks>
*/
stock va_SendErrorMessage(playerid, const frmmat[], va_args<>)
{
    return SendFormatMessage(playerid, MESSAGE_TYPE_ERROR, va_return(frmmat, va_start<2>));
}

stock va_SendInfoMessage(playerid, const frmmat[], va_args<>)
{
    return SendFormatMessage(playerid, MESSAGE_TYPE_INFO, va_return(frmmat, va_start<2>));
}

stock SendErrorMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_ERROR, smsgstring);
}

stock SendInfoMessage(playerid, smsgstring[])
{
	return SendMessage(playerid, MESSAGE_TYPE_INFO, smsgstring);
}

stock SendUsageMessage(playerid, smsgstring[])
{
	new msgstring[256];
	format(msgstring, sizeof(msgstring), "USAGE: /%s", smsgstring);
	return SendClientMessage(playerid, COLOR_RED, msgstring);
}

stock RemoveBuildings(playerid)
{
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	//RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
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

stock SendSplitMessage(playerid, color, const final[])
{
    new len = strlen(final);
    if(len >= 100)
    {
		new buffer[EX_SPLITLENGTH+10],	
			buffer2[128], spacepos = 0, bool:broken = false;
		for(new j = 60; j < len; j++)
		{
			if(final[j] == ' ')
				spacepos = j;

			if(j >= EX_SPLITLENGTH && spacepos >= 60)
			{
				broken = true;
				strmid(buffer, final, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessage(playerid, color, buffer);
				strmid(buffer2, final, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "...%s", buffer2);
				SendClientMessage(playerid, color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessage(playerid, color, final);
	}
    else return SendClientMessage(playerid, color, final);
	return 1;
}

stock SendSplitMessageToAll(color, const final[])
{
    new len = strlen(final);
    if(len >= 100)
    {
		new buffer[EX_SPLITLENGTH+10],	
			buffer2[128], spacepos = 0, bool:broken=false;
		for(new j = 60; j < len; j++)
		{
			if(final[j] == ' ')
				spacepos = j;

			if(j >= EX_SPLITLENGTH && spacepos >= 60)
			{
				broken = true;
				strmid(buffer, final, 0, spacepos);
				format(buffer, sizeof(buffer), "%s...", buffer);
				SendClientMessageToAll(color, buffer);
				strmid(buffer2, final, spacepos+1, len);
				format(buffer2, sizeof(buffer2), "...%s", buffer2);
				SendClientMessageToAll(color, buffer2);
				return 1;
			}
		}
		if(!broken)
			SendClientMessageToAll(color, final);
	}
    else return SendClientMessageToAll(color, final);
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

stock va_SendClientMessage(playerid, colour, const fmat[], va_args<>)
{
	return SendClientMessage(playerid, colour, va_return(fmat, va_start<3>));
}

stock va_SendClientMessageToAll(colour, const fmat[], va_args<>)
{
	return SendClientMessageToAll(colour, va_return(fmat, va_start<2>));
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
	//StreamerSettings
	Streamer_ToggleIdleUpdate(playerid, 1);
	// Admin/Helper unfreeze
	if((PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pHelper] > 0) && interior == 0 && viwo == 0)
		TogglePlayerControllable(playerid, 1);
	else TogglePlayerControllable(playerid, 0);
	
	//PlayerSets
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);
	
	//SettingPos
	SetPlayerPos(playerid, x, y, z);
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	
	if(update) defer InstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);
	
	return 1;
}

// Isto ko SetPlayerPosEx
stock SetVehiclePosEx(playerid, Float:x, Float:y, Float:z, viwo=0, interior=0, bool:update=true)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(!vehicleid)
		return 0;
		
	
	//StreamerSettings
	TogglePlayerControllable(playerid, 0);
	Streamer_ToggleIdleUpdate(playerid, 1);
	
	//SettingPos
	SetVehiclePos(vehicleid, x, y, z);
	Streamer_UpdateEx(playerid, x, y, z, viwo, interior);
	
	
	
	//Vehicle Sets
	SetVehicleVirtualWorld(vehicleid, viwo);
	LinkVehicleToInterior(vehicleid, interior);
	SetPlayerInterior(playerid, 	interior);
	SetPlayerVirtualWorld(playerid, viwo);

	PutPlayerInVehicle(playerid, vehicleid, 0);
	if(update) defer InstantStreamerUpdate(playerid);
	else InstantStreamerUpdate(playerid);
	
	return 1;
}

/*stock IsVehicleOccupied(vehicleid)
{
    foreach(new i : Player)
    {
		if(IsPlayerInVehicle(i, vehicleid )) return i;
    }
    return 0;
}*/

/**
    <summary>
        Provjeravamo dali uneseni E-Mail ima '@' i domain dio.
    </summary>
	
	<param name="email">
        String u koji unosimo igracev e-mail!
    </param>

    <returns>
        1 - Dobar e-mail, 0 - Nevaljan e-mail
    </returns>

    <remarks>
        Najbolje koristiti za provjere unosa E-Mail adrese!
    </remarks>
*/

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
		imedeva[24],
		Underscore;
	
	split(name, namesplit, '_');
	if(strcmp(imedeva, Dev_Name, true)) return 1;
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

/**
    <summary>
        Ukoliko je string veci od 128 prebacuje ga u novi red (ostatak)
    </summary>
	
	<param name="playerid">
       Samo objaSnjivo
    </param>
	
	<param name="color">
       Boja teksta
    </param>
	
	<param name="message">
       Poruka koju cemo ispisati
    </param>

    <returns>
        1
    </returns>

    <remarks>
       -
    </remarks>
*/

/**
    <summary>
        Svima u odredenome radiusu prikazuje tekst s bojama.
    </summary>
	
	<param name="radi">
       Radius u kojem ce drugi igraci moci vidjeti poruku
    </param>
	
	<param name="playerid">
       Samo objaSnjivo
    </param>
	
	<param name="string">
       Poruka koju ispisujemo
    </param>
	
	<param name="color">
       Boja teksta
    </param>
	
    <returns>
        Uvijek 1
    </returns>

    <remarks>
       -
    </remarks>
*/
stock ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5, bool:isDualChat = false)
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

stock RealProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
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

/**
    <summary>
        Vraca broj unutar nekog rangea.
    </summary>
	
	<param name="min">
       Minimalni broj u rasponu
    </param>
	
	<param name="max">
       Maksimalan broj u rasponu
    </param>
	
    <returns>
        Nasumican broj iz raspona
    </returns>

    <remarks>
       -
    </remarks>
*/
stock minrand(min, max) //By Alex "Y_Less" Cole
{
    return random(max - min) + min;
}


/**
    <summary>
        Vraca nasumican broj u rasponu
    </summary>
	
	<param name="min">
       Minimalni broj u rasponu (float)
    </param>
	
	<param name="max">
       Maksimalan broj u rasponu (float)
    </param>
	
    <returns>
        Nasumican broj iz raspona (float)
    </returns>

    <remarks>
       -
    </remarks>
*/
stock Float:frandom(Float:max, Float:min = 0.0, dp = 4)
{
	new
		Float:mul = floatpower(10.0, dp),
		imin = floatround(min * mul),
		imax = floatround(max * mul);
	return float(random(imax - imin) + imin) / mul;
}

/**
    <summary>
        Uzima naziv oruzja iz danog weaponida
    </summary>
	
	<param name="weaponid">
       Id oruZja od kojeg se uzima naziv
    </param>
	
    <returns>
        Naziv oruZja
    </returns>

    <remarks>
       -
    </remarks>
*/

stock GetWeaponNameEx(weaponid)
{
	new 
		weaponName[ 32 ];

	switch(weaponid) {
		case 0:  strcat(weaponName, "Tjelesni napad", sizeof(weaponName));
		case 1 .. 17: strcat(weaponName, "Melee oruzje", sizeof(weaponName));
		case 18: strcat(weaponName, "Molotov Cocktail", sizeof(weaponName));
		case 22..38: GetWeaponName(weaponid, weaponName, sizeof(weaponName)); // Vatrena oruzja
		case 39: strcat(weaponName, "Detonirana bomba", sizeof(weaponName));
		case 40: strcat(weaponName, "Detonirana bomba", sizeof(weaponName));
		case 41: strcat(weaponName, "Spray Can", sizeof(weaponName));
		case 42: strcat(weaponName, "Protupozarni aparat", sizeof(weaponName));
		case 43: strcat(weaponName, "Kamera", sizeof(weaponName));
		case 44: strcat(weaponName, "Night Vision Goggles", sizeof(weaponName));
		case 45: strcat(weaponName, "Thermal Goggles", sizeof(weaponName));
		case 49: strcat(weaponName, "Vozilo", sizeof(weaponName));
		case 50: strcat(weaponName, "Helicopter Blades", sizeof(weaponName));
		case 51: strcat(weaponName, "Eksplozija", sizeof(weaponName));
		case 53: strcat(weaponName, "Utapanje", sizeof(weaponName));
		case 54: strcat(weaponName, "Pad s visine", sizeof(weaponName));
		case 255: strcat(weaponName, "Samoubojstvo", sizeof(weaponName));
		default: strcat(weaponName, "Nepoznat", sizeof(weaponName));
	}
	return weaponName;
}

/**
    <summary>
        Provjerava dali je unos(string) numerican
    </summary>
	
	<param name="string">
       String kojeg se provjerava
    </param>
	
    <returns>
        1 - Numerican je, 0 - Nije numerican
    </returns>

    <remarks>
       -
    </remarks>
*/
stock IsNumeric(const string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock UnixTimestampToTime(timestamp, compare = -1) 
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

stock getPlayerNearestVehicle(playerid)
{
	new
		vehicleid = INVALID_VEHICLE_ID,
		Float:PosX, Float:PosY, Float:PosZ;
	
	foreach(new i : Vehicles)
	{
		GetVehiclePos( i, PosX, PosY, PosZ );
		if( IsPlayerInRangeOfPoint( playerid, 7.0, PosX, PosY, PosZ ) )
		{
			vehicleid = i;
			break;
		}
	}	
	return vehicleid;
}

stock GetPlayerNearestPrivateVehicle(playerid)
{
	new
		vehicleid = INVALID_VEHICLE_ID,
		Float:PosX, Float:PosY, Float:PosZ;
	
	foreach(new i : COVehicles)
	{
		GetVehiclePos( i, PosX, PosY, PosZ );
		if( IsPlayerInRangeOfPoint( playerid, 7.0, PosX, PosY, PosZ ) )
		{
			vehicleid = i;
			break;
		}
	}	
	return vehicleid;
}

stock intdiffabs(tick1, tick2)
{
	if(tick1 > tick2)
		return abs(tick1 - tick2);

	else
		return abs(tick2 - tick1);
}

stock GetTickCountDifference(a, b)
{
	if ((a < 0) && (b > 0))
	{

		new dist;

		dist = intdiffabs(a, b);

		if(dist > 2147483647)
			return intdiffabs(a - 2147483647, b - 2147483647);

		else
			return dist;
	}

	return intdiffabs(a, b);
}

stock PlayerPlayTrackSound(playerid)
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
	foreach(new i : Player) {
		if( IsPlayerInRangeOfPoint(i, radius, HouseInfo[ houseid ][ hEnterX ], HouseInfo[ houseid ][ hEnterY ], HouseInfo[ houseid ][ hEnterZ ] ) )
			SendClientMessage(i, color, string);
	}
	return 1;
}

stock SendJobMessage(job, color, string[])
{
	foreach (new i : Player) {
		if(PlayerInfo[i][pJob] == job)
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
	for(new i=0; i<MAX_PLAYERS; i++)
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

stock ConvertNameToSQLID(const name[])
{
	new sqlid, sqlquery[128];
	mysql_format(g_SQL, sqlquery, sizeof(sqlquery), "SELECT `sqlid` FROM `accounts` WHERE `name` = '%e' LIMIT 0,1", name);
	
	new 
		Cache:result = mysql_query(g_SQL, sqlquery);
	cache_get_value_name_int(0, "sqlid", sqlid);
	cache_delete(result);
	return sqlid;
}

stock ConvertSQLIDToName(id)
{
	new nick[24], 
		sqlquery[128];
	format( sqlquery, sizeof(sqlquery), "SELECT `name` FROM `accounts` WHERE `sqlid` = '%d' LIMIT 0,1", id);
	
	new 
		Cache:result = mysql_query(g_SQL, sqlquery);
	cache_get_value_name(0, "name", nick, 24);
	cache_delete(result);
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
	####  ######     ###    ######## 
	 ##  ##    ##   ## ##      ##    
	 ##  ##        ##   ##     ##    
	 ##   ######  ##     ##    ##    
	 ##        ## #########    ##    
	 ##  ##    ## ##     ##    ##    
	####  ######  ##     ##    ##    
*/
stock IsAtBank(playerid) {
	return IsPlayerInRangeOfPoint(playerid, 50.0, 1396.5443,-8.5233,1001.0038);
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


/*
	##     ## ######## ######## ########  
	##     ##    ##       ##    ##     ## 
	##     ##    ##       ##    ##     ## 
	#########    ##       ##    ########  
	##     ##    ##       ##    ##        
	##     ##    ##       ##    ##        
	##     ##    ##       ##    ##        
*/
forward VpnHttpResponse(index, response_code, data[]);
public VpnHttpResponse(index, response_code, data[])
{
	if( response_code == 200 ) {
		if( !strcmp( data, "detected", true ) ) {
			va_SendClientMessage(index, COLOR_RED, "[SERVER] Koristite IP %s na kojem je otrkiven VPN koji je zabranjen na serveru!", GetPlayerIP(index));
			KickMessage(index);
		}
	}
}

// REST
stock DB_Escape(text[])
{
    new
        ret[80 * 2],
        ch,
        i,
        j;
    while ((ch = text[i++]) && j < sizeof (ret))
    {
        if (ch == '\')
        {
            if (j < sizeof (ret) - 2)
            {
                ret[j++] = '\'';
                ret[j++] = '\'';
            }
        }
        else if (j < sizeof (ret))
        {
            ret[j++] = ch;
        }
        else
        {
            j++;
        }
    }
    ret[sizeof (ret) - 1] = '\0';
    return ret;
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

stock gettimestamp()
{
	new timestamp = gettime() + 7200;
	return timestamp;
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

/*ReturnPlayerIP(playerid)
{
	new
	    ip[16];
	    
	GetPlayerIp(playerid, ip, sizeof(ip));

	return ip;
}*/

mysql_fquery(MySQL:connectionHandle, const query[], va_args<>)
	return mysql_tquery(connectionHandle, va_return(query, va_start<2>));

ReturnName(playerid)
{
	new
	    p_name[24];
	    
	GetPlayerName(playerid, p_name, 24);
	return p_name;
}

// credits go to: RyDeR`
stock randomString(strDest[], strLen = 10)
{
    while(strLen--)
        strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

public OnPlayerPause(playerid)
{
	if(SafeSpawned[playerid])
	{
		PlayerPaused[playerid] = 1;
		UpdateNameLabel(playerid, "");
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(PlayerPaused[playerid])
	{
		PlayerPaused[playerid] = 0;
		UpdateNameLabel(playerid, "");
	}
	return 1;
}

AC_SetPlayerName(playerid, nameplaya[])
{
	if(!SetPlayerName(playerid, nameplaya))
		return 0;
		
	format(plyrName[playerid], MAX_PLAYER_NAME, nameplaya);
	
	UpdateNameLabel(playerid, plyrName[playerid]);
	return 1;
}

#if defined _ALS_SetPlayerName
    #undef SetPlayerName
#else
    #define _ALS_SetPlayerName
#endif
#define SetPlayerName AC_SetPlayerName


CreateNameLabel(playerid)
{
	GetPlayerName(playerid, plyrName[playerid], 24);
	pNameTag[playerid] = CreateDynamic3DTextLabel(plyrName[playerid], 0xFFFFFFFF, 0.0, 0.0, 0.1, 15.0, playerid, INVALID_VEHICLE_ID, 1, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1);
	UpdateNameLabel(playerid, "");
	return 1;
}

UpdateNameLabel(playerid, namep[])
{
	if(!IsValidDynamic3DTextLabel(pNameTag[playerid]))
	{
		CreateNameLabel(playerid);
		return 0;
	}
	new
		playaname[40],
		cname[MAX_PLAYER_NAME];
		
	if(isnull(namep))
	{
		if(isnull(PlayerExName[playerid]))
			GetPlayerName(playerid, cname, 24);
		else
			format(cname, 24, PlayerExName[playerid]);
	}
	else
		format(cname, 24, namep);
	
	if(Bit1_Get(gr_MaskUse, playerid))
	{
		if(PlayerPaused[playerid])
			format(playaname, 40, "Maska_%d {F81414}AFK", PlayerInfo[playerid][pMaskID]);
		else
			format(playaname, 40, "Maska_%d", PlayerInfo[playerid][pMaskID]);
	}
	else
	{
		if(PlayerPaused[playerid])
			format(playaname, 40, "%s (%d) {F81414}AFK", cname, playerid);
		else
			format(playaname, 40, "%s (%d)", cname, playerid);
	}
	strreplace(playaname, '_', ' ');

	UpdateDynamic3DTextLabelText(pNameTag[playerid], 0xFFFFFFFF, playaname);
	return 1;
}

CMD:refreshname(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
		return 1;
		
	new
		giveplayerid;
	
	if(!IsNumeric(params))
		return 1;
		
	giveplayerid = strval(params);
		
	UpdateNameLabel(giveplayerid, "");
	
	va_SendClientMessage(playerid, -1, "Igracevo ime ID:%d %s", giveplayerid, plyrName[giveplayerid]);
	va_SendClientMessage(playerid, -1, "Igracov Dynamic3DTextLabel %s", (IsValidDynamic3DTextLabel(pNameTag[giveplayerid])) ? ("je validan") : ("nije validan"));
	return 1;
}
