/*	Exteriors Maps  */

#include <YSI_Coding\y_hooks>

new	exterior_maps;


hook OnFilterScriptInit() {

	// Bank Exterior by Carlos
	exterior_maps = CreateDynamicObject(19480, 594.965270, -1246.450073, 26.157077, 0.000000, 0.000000, 111.999961, -1, -1, -1, 300.00, 300.00);
	SetObjectMaterialText(exterior_maps, "LS CITY BANK", 0, 120, "Engravers MT", 40, 1, 0xFF000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateDynamicObject(11245, 587.640625, -1249.746337, 25.820413, 0.000000, 3.299999, 112.999885, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(11245, 602.608520, -1243.394775, 25.820413, 0.000000, 3.299999, 112.999885, -1, -1, -1, 300.00, 300.00);
	////////////////////////////////////SMB ENVIRONMENT BY CRUELLA///////////////////////////////////////////////
	exterior_maps = CreateObject(19445, 525.096923, -1865.575317, 1.722343, 0.000000, 0.000000, 89.999984, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 520.365783, -1870.348022, 1.722343, 0.000000, 0.000000, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 529.826171, -1870.348022, 1.722343, 0.000000, 0.000000, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 525.096923, -1875.076660, 1.722343, 0.000000, 0.000000, 89.999984, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 522.045471, -1870.307983, 3.232336, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.105163, -1870.307983, 3.372335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 528.145629, -1870.307983, 3.272335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.155273, -1870.628173, 3.252335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1871.088500, 3.072335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1871.558959, 2.902335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1872.029418, 2.722335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 520.365783, -1870.348022, 5.222342, 0.000000, 0.000000, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 529.816040, -1870.348022, 5.222342, 0.000000, 0.000000, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19399, 521.879394, -1865.618164, 5.224696, 0.000000, 0.000000, -90.000045, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19399, 528.280151, -1865.618164, 5.224696, 0.000000, 0.000000, -90.000045, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19399, 525.089782, -1865.618164, 5.224696, 0.000000, 0.000000, -90.000045, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19399, 521.889404, -1875.078369, 5.224696, 0.000000, 0.000000, -90.000045, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19399, 528.299865, -1875.078369, 5.224696, 0.000000, 0.000000, -90.000045, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 522.044982, -1870.348022, 6.892335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 528.145812, -1870.348022, 6.892335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 525.105590, -1870.348022, 7.262329, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 522.035522, -1870.348022, 7.082331, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 528.155700, -1870.348022, 7.082330, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "easykerb", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1881.660156, 2.722335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1881.660156, 2.552335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.165283, -1881.660156, 2.382336, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.105590, -1870.338012, 7.072327, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(16151, 521.414550, -1870.539306, 3.648272, 0.000000, 0.000000, 179.900039, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetObjectMaterial(exterior_maps, 5, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 7, 4835, "airoads_las", "easykerb", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(2125, 528.304016, -1866.874511, 3.698272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 528.304016, -1874.094848, 3.698272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(1815, 527.806945, -1868.766723, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 527.806945, -1873.147338, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2125, 528.304016, -1871.214721, 3.698272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 528.304016, -1869.654907, 3.698272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2773, 523.619384, -1885.063232, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 523.619384, -1877.382446, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 523.619384, -1879.312133, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 523.619384, -1881.232299, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 523.619384, -1883.152587, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 526.689636, -1877.392456, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 526.689636, -1879.312255, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 526.689636, -1881.232543, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 526.689636, -1883.152709, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 526.689636, -1885.062988, 3.168273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(19445, 525.155822, -1905.147949, 0.122336, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 521.665710, -1905.146972, 0.122338, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 528.646057, -1905.147949, 0.122335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(2773, 530.169921, -1913.143066, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 529.226013, -1914.112182, 0.678274, 0.000000, 0.000000, 90.099975, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(19445, 521.665710, -1909.548339, 0.112338, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 525.155700, -1909.547851, 0.112336, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(19445, 528.655517, -1909.547851, 0.112335, 0.000000, 90.000022, -0.000017, 300.00);
	SetObjectMaterial(exterior_maps, 0, 13625, "crowds", "ahstandside", 0x00000000);
	exterior_maps = CreateObject(2773, 527.305908, -1914.115600, 0.678274, 0.000000, 0.000000, 90.099975, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 525.385803, -1914.118774, 0.678274, 0.000000, 0.000000, 90.099975, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 523.475585, -1914.121826, 0.678274, 0.000000, 0.000000, 90.099975, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 521.555969, -1914.125732, 0.678274, 0.000000, 0.000000, 90.099975, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1913.173095, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1911.242675, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1909.322631, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1907.402343, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1905.472534, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1903.562255, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 520.559997, -1901.642333, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 530.169921, -1911.212768, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 530.169921, -1909.302612, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 530.169921, -1907.382568, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2773, 530.169921, -1905.452392, 0.678274, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2179, 521.675659, -1913.168334, -2.449886, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2179, 528.145812, -1913.168334, -2.449886, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 526.956604, -1911.587280, 0.198272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 522.816467, -1911.587280, 0.198272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 522.816467, -1907.826782, 0.198272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 526.956604, -1907.817138, 0.198272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(1815, 522.816467, -1904.336669, 0.198272, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	exterior_maps = CreateObject(2125, 527.554016, -1905.694580, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 527.554016, -1909.594604, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 527.554016, -1912.685058, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 529.123962, -1911.034912, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 529.123962, -1907.394775, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 521.713867, -1907.394775, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 521.713867, -1911.134887, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 521.713867, -1904.064697, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 523.324035, -1902.354125, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 523.324035, -1912.674194, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 523.324035, -1908.734252, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	exterior_maps = CreateObject(2125, 523.324035, -1905.284179, 0.528273, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "steel64", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetObjectMaterial(exterior_maps, 8, 16640, "a51", "a51_boffstuff3", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateObject(2707, 528.320007, -1866.211181, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 521.929870, -1874.531616, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 521.929870, -1871.731201, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 521.929870, -1868.721191, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 528.369873, -1868.721191, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 521.929870, -1866.211181, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 528.230224, -1871.731201, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 528.330078, -1874.531616, 6.778275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 528.483276, -1872.358520, 4.028273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 528.103149, -1872.938720, 4.028273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 528.103149, -1868.488159, 4.028273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 528.603332, -1868.067993, 4.028273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 523.662475, -1866.225952, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 526.442810, -1866.225952, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 526.442810, -1866.225952, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 523.662475, -1866.225952, 3.458272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19822, 528.372802, -1868.231567, 3.948272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19822, 528.372802, -1872.681762, 3.948272, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2267, 529.720397, -1870.290527, 5.028271, 0.000000, 0.000000, -89.799964, 300.00);
	exterior_maps = CreateObject(2267, 529.716308, -1869.100463, 5.688273, 0.000000, 0.000000, -89.799964, 300.00);
	exterior_maps = CreateObject(2267, 529.724731, -1871.460693, 4.398272, 0.000000, 0.000000, -89.799964, 300.00);
	exterior_maps = CreateObject(3461, 523.574951, -1886.254760, 4.338051, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2267, 520.463562, -1867.531738, 5.268272, 0.000000, 0.000000, 89.900032, 300.00);
	exterior_maps = CreateObject(2267, 520.462646, -1868.091918, 5.028271, 0.000000, 0.000000, 89.900032, 300.00);
	exterior_maps = CreateObject(3461, 526.775085, -1886.254760, 4.338051, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 521.612487, -1875.716064, 2.598273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 528.272705, -1875.716064, 2.738273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 528.272705, -1875.716064, 2.738273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2011, 521.612487, -1875.716064, 2.598273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(3461, 530.135070, -1904.295288, 1.758051, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(3461, 520.614990, -1900.565307, 1.758051, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(639, 519.945983, -1911.377319, -1.774308, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(639, 519.945983, -1905.497802, -1.774308, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(639, 522.906616, -1914.317749, -1.774308, 0.000000, 0.000000, 89.700042, 300.00);
	exterior_maps = CreateObject(639, 527.456848, -1914.340698, -1.774308, 0.000000, 0.000000, 89.700042, 300.00);
	exterior_maps = CreateObject(639, 530.362731, -1911.364624, -1.774308, 0.000000, 0.000000, 179.300048, 300.00);
	exterior_maps = CreateObject(639, 530.418395, -1906.804931, -1.774308, 0.000000, 0.000000, 179.300048, 300.00);
	exterior_maps = CreateObject(639, 519.945983, -1903.177490, -1.774308, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 527.342712, -1906.986572, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 527.782775, -1907.406738, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 527.222595, -1907.576904, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 527.222595, -1911.376953, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 527.822631, -1910.866699, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 522.992797, -1911.036743, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.492858, -1911.296997, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.492858, -1907.646606, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.102661, -1907.156372, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.102661, -1903.506591, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.482727, -1904.116821, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19819, 523.672851, -1903.616577, 0.788273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19824, 527.466613, -1907.376342, 0.698273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19824, 523.316711, -1911.057373, 0.698273, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19823, 527.507202, -1911.078613, 0.668273, 0.000000, 0.000000, 50.799995, 300.00);
	exterior_maps = CreateObject(19823, 523.316711, -1903.764404, 0.668273, 0.000000, 0.000000, 50.799995, 300.00);
	exterior_maps = CreateObject(19822, 523.284362, -1907.373535, 0.698275, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1255, 537.666503, -1879.774536, 3.299060, 0.000000, 0.000000, -104.099998, 300.00);
	exterior_maps = CreateObject(1255, 535.959411, -1879.345214, 3.299060, 0.000000, 0.000000, -85.500000, 300.00);
	exterior_maps = CreateObject(1255, 519.639953, -1880.629760, 2.999060, 0.000000, 2.099999, -85.500000, 300.00);
	exterior_maps = CreateObject(1255, 517.785644, -1880.775878, 2.999060, 0.000000, 2.099999, -67.400001, 300.00);
	exterior_maps = CreateObject(1255, 516.557739, -1881.286621, 2.999060, 0.000000, 2.099999, -50.600002, 300.00);
	exterior_maps = CreateObject(1255, 514.609863, -1896.308837, 1.187734, 0.000000, 5.000000, -50.600002, 300.00);
	exterior_maps = CreateObject(1255, 516.715759, -1895.741333, 1.368305, 0.000000, 7.899999, -135.900009, 300.00);
	exterior_maps = CreateObject(642, 536.879455, -1878.497436, 3.985617, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(642, 518.489318, -1879.817382, 3.655617, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(642, 515.589233, -1895.217895, 1.975618, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1343, 519.293212, -1874.708129, 3.369891, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1520, 536.599365, -1879.072631, 2.770495, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1520, 536.799499, -1878.842407, 2.770495, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1520, 518.989501, -1880.612670, 2.480495, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1543, 518.299499, -1880.251831, 2.432553, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1543, 516.679565, -1880.251831, 2.432553, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1551, 515.008056, -1895.275512, 0.966041, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1551, 515.858093, -1894.665283, 1.076041, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19445, 194.502593, -1829.031127, 2.963160, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 204.142639, -1829.014160, 2.963160, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 213.772705, -1828.997314, 2.963160, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 223.372802, -1828.979614, 2.963160, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 233.002731, -1828.962646, 2.963160, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 194.508682, -1832.530273, 2.877650, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 194.514846, -1836.028930, 2.792139, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 194.520980, -1839.537475, 2.706383, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 194.527130, -1843.036376, 2.620872, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 204.167160, -1843.019775, 2.620872, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 213.737213, -1843.003173, 2.620872, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 223.337249, -1842.986083, 2.620872, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 232.967376, -1842.968750, 2.620872, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 232.961181, -1839.460083, 2.706628, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 232.955001, -1835.941406, 2.792628, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 232.949005, -1832.452148, 2.877895, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 199.423461, -1835.606445, 4.397960, 0.000000, 0.000000, 0.099999, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 228.053359, -1835.557373, 4.397960, 0.000000, 0.000000, 0.099999, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 204.158935, -1830.856811, 4.397960, 0.000000, 0.000000, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 223.308837, -1830.824462, 4.397960, 0.000000, 0.000000, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 208.903350, -1835.590087, 4.397960, 0.000000, 0.000000, 0.099999, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 218.583267, -1835.574340, 4.397960, 0.000000, 0.000000, 0.099999, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 204.160964, -1839.521240, 2.706383, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 204.154769, -1836.022705, 2.791893, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 204.148620, -1832.524047, 2.877403, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 223.448577, -1832.490600, 2.877403, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 223.454818, -1835.999023, 2.791647, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19445, 223.460876, -1839.498291, 2.706138, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 5114, "beach_las2", "boardwalk_la", 0x00000000);
	exterior_maps = CreateObject(19399, 200.962051, -1840.348266, 4.390785, 0.000000, 0.000000, -89.900001, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19399, 207.392044, -1840.338256, 4.390785, 0.000000, 0.000000, -89.900001, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19399, 220.112121, -1840.315917, 4.390785, 0.000000, 0.000000, -89.900001, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19399, 226.542083, -1840.304687, 4.390785, 0.000000, 0.000000, -89.900001, 300.00);
	SetObjectMaterial(exterior_maps, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	exterior_maps = CreateObject(19445, 204.159057, -1838.545410, 6.121270, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19445, 204.152893, -1835.057373, 6.206542, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19445, 204.148605, -1832.545898, 6.207880, 0.000000, 88.600021, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19445, 223.308624, -1832.510986, 6.069077, 0.000000, 90.100013, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19445, 223.314788, -1836.010864, 6.075184, 0.000000, 90.100013, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19445, 223.319213, -1838.611572, 6.089725, 0.000000, 90.100013, 90.100006, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3653, "beachapts_lax", "sjmscorclawn", 0x00000000);
	exterior_maps = CreateObject(19353, 202.631851, -1834.423828, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(19353, 205.831863, -1834.423828, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(19353, 205.831863, -1834.604003, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(19353, 202.631835, -1834.604003, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(19353, 202.631835, -1834.774169, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(19353, 205.831771, -1834.774169, 2.189550, 0.000000, 0.000000, 90.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 3820, "boxhses_sfsx", "tanboard1", 0x00000000);
	exterior_maps = CreateObject(2644, 207.419219, -1838.922729, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 207.419219, -1836.762329, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 200.659255, -1836.762329, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 200.659255, -1839.032348, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(1716, 202.397003, -1838.671264, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 202.397003, -1836.411010, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 200.986999, -1837.341308, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 207.827041, -1837.790893, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 206.467086, -1838.581176, 2.798463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 206.467086, -1836.450927, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(2644, 196.699264, -1839.032348, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 193.229278, -1839.032348, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 193.229278, -1835.732055, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 196.619323, -1835.732055, 3.280602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 196.619323, -1832.101806, 3.370602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 193.269332, -1832.101806, 3.360602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(1716, 192.167037, -1838.740966, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 194.017044, -1840.141113, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 193.647064, -1836.830932, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 193.647064, -1833.260864, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 192.027038, -1835.390991, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 198.757034, -1835.390991, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 198.757034, -1838.631225, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 198.577026, -1831.401123, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 195.557052, -1831.621337, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 195.557052, -1835.401611, 2.878463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 195.557052, -1838.901489, 2.798463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 192.147079, -1832.031372, 2.958463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(2644, 220.299240, -1838.922729, 3.230602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 220.299240, -1835.702270, 3.290602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 226.599227, -1835.702270, 3.290602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(2644, 226.599227, -1838.952148, 3.290602, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnutLite", 0x00000000);
	exterior_maps = CreateObject(1716, 226.947082, -1836.771240, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 226.947082, -1837.191528, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 225.637130, -1838.611572, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 225.637130, -1835.581665, 2.838463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 222.017272, -1835.331420, 2.828463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 222.017272, -1838.591064, 2.828463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 220.627212, -1836.940917, 2.828463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	exterior_maps = CreateObject(1716, 219.267303, -1838.600708, 2.828463, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(exterior_maps, 0, 4828, "airport3_las", "gnhotelwall02_128", 0x00000000);
	SetObjectMaterial(exterior_maps, 1, 2567, "ab", "chipboard_256", 0x00000000);
	SetObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "ab_walnut", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateObject(2456, 202.683227, -1840.665405, 2.690092, 0.000000, 0.000000, 23.799999, 300.00);
	exterior_maps = CreateObject(2456, 201.877059, -1840.670898, 2.700092, 0.000000, 0.000000, 23.799999, 300.00);
	exterior_maps = CreateObject(2137, 200.911544, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2305, 199.987152, -1831.466918, 2.951425, 0.000000, 0.000000, 90.700012, 300.00);
	exterior_maps = CreateObject(2137, 201.851531, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2137, 202.791595, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2136, 203.720993, -1831.450683, 2.948748, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2137, 205.671691, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2137, 206.611709, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2137, 207.551879, -1831.464477, 2.956432, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2305, 208.470046, -1831.441406, 2.951425, 0.000000, 0.000000, 0.400019, 300.00);
	exterior_maps = CreateObject(2267, 208.801940, -1835.123779, 4.874003, 0.000000, 0.000000, -89.799972, 300.00);
	exterior_maps = CreateObject(2267, 208.805450, -1836.133911, 4.724001, 0.000000, 0.000000, -89.799972, 300.00);
	exterior_maps = CreateObject(2267, 208.808975, -1837.153808, 4.564000, 0.000000, 0.000000, -89.799972, 300.00);
	exterior_maps = CreateObject(2267, 199.529067, -1837.186157, 4.564000, 0.000000, 0.000000, 90.200065, 300.00);
	exterior_maps = CreateObject(2267, 199.525726, -1836.236083, 4.944001, 0.000000, 0.000000, 90.200065, 300.00);
	exterior_maps = CreateObject(2267, 199.522033, -1835.176269, 4.764000, 0.000000, 0.000000, 90.200065, 300.00);
	exterior_maps = CreateObject(2456, 201.475219, -1834.395141, 3.920091, 0.000000, 0.000000, -0.400000, 300.00);
	exterior_maps = CreateObject(2641, 203.766342, -1830.982055, 5.117453, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2641, 204.656341, -1830.982055, 5.117453, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2642, 199.574096, -1838.978027, 3.729984, 0.000000, 0.000000, 89.700012, 300.00);
	exterior_maps = CreateObject(2642, 201.663711, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(2642, 203.693695, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(2642, 202.673690, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(2642, 204.953689, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(2642, 206.823654, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(2642, 205.863647, -1834.926635, 2.709985, 0.000000, 0.000000, 0.000004, 300.00);
	exterior_maps = CreateObject(19811, 202.080993, -1834.608520, 3.994197, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19811, 202.080993, -1834.608520, 3.994197, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19811, 202.670989, -1834.608520, 3.994197, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19811, 202.371002, -1834.608520, 3.994197, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2840, 200.678207, -1839.073242, 3.718780, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2840, 207.438262, -1836.853515, 3.718780, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1545, 206.787979, -1834.241577, 4.138239, 0.000000, 0.000000, -179.600006, 300.00);
	exterior_maps = CreateObject(1541, 205.717742, -1834.274780, 4.136600, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2453, 207.098907, -1834.633422, 4.278100, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2453, 203.188781, -1834.614990, 4.318099, 0.000000, 0.000000, -0.699999, 300.00);
	exterior_maps = CreateObject(2646, 208.812866, -1838.908691, 4.913470, 0.000000, 0.000000, -90.000045, 300.00);
	exterior_maps = CreateObject(2645, 202.193542, -1840.490234, 4.532669, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2642, 206.116470, -1840.507080, 4.577873, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2219, 200.664825, -1837.066772, 3.778494, -25.100017, 22.600004, -17.099994, 300.00);
	exterior_maps = CreateObject(2220, 207.254882, -1839.089965, 3.760689, -24.799995, 20.999998, -16.300001, 300.00);
	exterior_maps = CreateObject(2707, 201.520614, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 202.550628, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 203.420623, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 204.220626, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 205.110595, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 206.000656, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 206.780670, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 206.780670, -1834.617675, 6.096521, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2642, 199.267807, -1835.314941, 4.827874, 0.000000, 0.000000, -89.699996, 300.00);
	exterior_maps = CreateObject(2642, 199.282577, -1835.949707, 4.829986, 0.000000, 0.000000, -89.899986, 300.00);
	exterior_maps = CreateObject(2645, 199.274002, -1839.008178, 4.822669, 0.000000, 0.000000, -89.500000, 300.00);
	exterior_maps = CreateObject(2645, 199.213241, -1832.047851, 4.822669, 0.000000, 0.000000, -89.500000, 300.00);
	exterior_maps = CreateObject(3461, 189.777847, -1844.750610, 4.195796, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(3461, 189.777847, -1827.390258, 4.635799, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1408, 189.712493, -1830.049804, 3.483860, 0.000000, 0.000000, -90.699996, 300.00);
	exterior_maps = CreateObject(1408, 189.648895, -1835.259033, 3.313860, 0.000000, 0.000000, -90.699996, 300.00);
	exterior_maps = CreateObject(1408, 189.645263, -1840.469116, 3.173860, 0.000000, 0.000000, -90.200004, 300.00);
	exterior_maps = CreateObject(1408, 192.552490, -1827.502319, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 197.742401, -1827.466918, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 202.932327, -1827.431030, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 208.132217, -1827.394409, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 213.382110, -1827.358520, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 218.572006, -1827.322387, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 223.771865, -1827.286254, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 228.991729, -1827.249633, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1408, 234.191589, -1827.213378, 3.544873, 0.000000, 0.000000, -179.600021, 300.00);
	exterior_maps = CreateObject(1341, 210.796264, -1842.210815, 3.614104, 0.000000, 0.000000, -89.399978, 300.00);
	exterior_maps = CreateObject(1341, 217.295898, -1842.142578, 3.614104, 0.000000, 0.000000, -89.399978, 300.00);
	exterior_maps = CreateObject(16151, 223.095352, -1831.983642, 3.257459, 0.000000, 0.000000, 90.300010, 300.00);
	exterior_maps = CreateObject(19818, 220.630157, -1835.626708, 3.799625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 220.130172, -1836.046997, 3.799625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 220.130172, -1838.817504, 3.699625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 220.640060, -1838.817504, 3.769625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 220.420059, -1838.537231, 3.769625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 226.420013, -1838.537231, 3.789625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 226.420013, -1839.197509, 3.789625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 226.420013, -1835.947265, 3.789625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(19818, 226.300003, -1835.497070, 3.789625, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1408, 236.736541, -1829.972900, 3.534873, 0.000000, 0.000000, 90.099998, 300.00);
	exterior_maps = CreateObject(1408, 236.745651, -1835.182617, 3.454873, 0.000000, 0.000000, 90.099998, 300.00);
	exterior_maps = CreateObject(1408, 236.754776, -1840.382080, 3.294873, 0.000000, 0.000000, 90.099998, 300.00);
	exterior_maps = CreateObject(2707, 220.989486, -1832.981567, 5.955374, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 224.399505, -1832.981567, 5.955374, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 226.119491, -1832.981567, 5.955374, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2707, 222.499465, -1832.981567, 5.955374, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(1342, 215.432586, -1836.039184, 3.718286, 0.000000, 0.000000, 179.799957, 300.00);
	exterior_maps = CreateObject(1340, 211.404586, -1836.026855, 3.715736, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2270, 227.451034, -1834.250366, 4.466646, 0.000000, 0.000000, -90.600028, 300.00);
	exterior_maps = CreateObject(2262, 227.472122, -1835.218994, 4.183567, 0.000000, 0.000000, -89.699981, 300.00);
	exterior_maps = CreateObject(2262, 219.168075, -1837.514160, 4.626451, 0.000000, 0.000000, 89.999984, 300.00);
	exterior_maps = CreateObject(2265, 219.165390, -1836.640869, 4.314001, 0.000000, 0.000000, 90.900032, 300.00);
	exterior_maps = CreateObject(1255, 229.756378, -1832.719116, 3.503616, 0.000000, 0.000000, -90.299995, 300.00);
	exterior_maps = CreateObject(1255, 231.586349, -1832.728271, 3.503616, 0.000000, 0.000000, -90.299995, 300.00);
	exterior_maps = CreateObject(1255, 229.764801, -1836.838745, 3.503616, 0.000000, 0.000000, -90.299995, 300.00);
	exterior_maps = CreateObject(1255, 231.594757, -1836.848266, 3.503616, 0.000000, 0.000000, -90.299995, 300.00);
	exterior_maps = CreateObject(642, 230.604141, -1831.244628, 4.356140, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(642, 230.694122, -1835.564453, 4.196139, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(2083, 230.132080, -1832.413574, 2.916186, 0.000000, 0.000000, -91.200057, 300.00);
	exterior_maps = CreateObject(2083, 230.188873, -1836.385620, 2.916186, 0.000000, 0.000000, -91.200057, 300.00);
	exterior_maps = CreateObject(1280, 191.399169, -1845.098999, 2.973001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1280, 197.468994, -1845.056274, 2.973001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1280, 235.178634, -1844.873535, 2.763001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1280, 230.258728, -1844.907836, 2.763001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1280, 225.558837, -1844.940551, 2.763001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1280, 203.189407, -1845.096801, 2.893001, 0.000000, 0.000000, 90.399978, 300.00);
	exterior_maps = CreateObject(1597, 235.635955, -1834.817138, 5.292042, 0.799999, 0.000000, 1.799999, 300.00);
	exterior_maps = CreateObject(3461, 237.637817, -1844.580444, 4.195796, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(3461, 237.637817, -1827.300659, 4.635797, 0.000000, 0.000000, 0.000000, 300.00);
	exterior_maps = CreateObject(3461, 237.637817, -1827.300659, 4.635797, 0.000000, 0.000000, 0.000000, 300.00);

	///////////////////////////Chinatown Environment by APPS /////////////////////////////////
	exterior_maps = CreateDynamicObject(1568, 1357.145751, -1465.392578, 12.541130, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1568, 1361.114135, -1450.180419, 12.541130, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(10264, 1375.834594, -1452.361572, 13.289400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3038, 1364.886962, -1481.761474, 21.056999, 0.000000, 0.000000, -14.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3038, 1367.362792, -1420.672607, 21.836999, 0.000000, 0.000000, -4.019999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1300, 1366.018676, -1429.691772, 12.896599, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3038, 1366.861450, -1428.087768, 21.836999, 0.000000, 0.000000, -4.440000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1362.902709, -1441.299804, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1364.776245, -1427.674438, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1364.776245, -1427.674438, 12.643600, 0.000000, 0.000000, 129.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1364.776245, -1427.674438, 12.643600, 0.000000, 0.000000, 125.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1364.671020, -1419.766479, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1388.249023, -1412.915893, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1364.635009, -1434.776977, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1365.334716, -1439.666748, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1378.273437, -1387.808837, 12.669699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1568, 1426.265991, -1395.118896, 12.598099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1568, 1378.603515, -1389.740722, 12.598099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1568, 1394.347534, -1389.805297, 12.598099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1568, 1409.576171, -1389.775024, 12.598099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(9482, 1448.381225, -1440.909423, 18.992599, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2957, 1386.965332, -1433.260375, 14.118100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2428, 1364.117187, -1417.981811, 12.544500, 0.000000, 0.000000, -120.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(925, 1388.159423, -1469.702514, 13.586899, 0.000000, 0.000000, 76.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(927, 1372.389038, -1487.779663, 13.574600, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(929, 1391.053588, -1460.315063, 13.487799, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(941, 1376.941284, -1487.139282, 13.004099, 0.000000, 0.000000, 74.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(971, 1390.404296, -1450.650878, 12.976200, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1221, 1377.047363, -1486.718139, 13.936800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1257, 1401.815185, -1447.979980, 13.848500, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1264, 1387.640869, -1451.853027, 13.008999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1264, 1387.345825, -1451.214721, 13.008999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1264, 1388.182006, -1451.167846, 13.008999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1299, 1389.369628, -1452.594604, 12.990500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3038, 1366.334228, -1436.275634, 21.836999, 0.000000, 0.000000, -3.059999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3038, 1362.885009, -1489.786254, 21.097000, 0.000000, 0.000000, -14.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1342, 1389.404785, -1413.802856, 13.547100, 0.000000, 0.000000, 33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1508, 1380.675415, -1472.707885, 14.167699, 0.000000, 0.000000, -16.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3061, 1367.262573, -1509.001953, 13.741800, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3042, 1366.982055, -1510.250732, 14.394499, 0.000000, 0.000000, -105.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18748, 1367.848388, -1510.641723, 15.810700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18727, 1367.808349, -1510.469726, 15.890580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1421, 1392.784057, -1451.616455, 13.226400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1623, 1378.057617, -1481.358398, 15.688300, 0.000000, 0.000000, 163.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2098, 1365.312500, -1446.693969, 14.316300, 0.000000, 0.000000, 85.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3041, 1378.660034, -1498.470581, 12.526399, 0.000000, 0.000000, 33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3040, 1371.668457, -1500.370117, 14.984100, 0.000000, 0.000000, -13.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3039, 1427.754272, -1428.632202, 12.542300, 0.000000, 0.000000, 113.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3861, 1376.918823, -1504.976196, 13.705499, 0.000000, 0.000000, -171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3862, 1380.490356, -1491.930297, 13.685099, 0.000000, 0.000000, 280.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1365.729248, -1417.500488, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1387.898803, -1448.413452, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(10264, 1379.001953, -1444.696777, 13.289400, 0.000000, 0.000000, -106.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(13187, 1430.845947, -1406.747680, 13.906999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1389.383300, -1415.912109, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1407.617919, -1386.490478, 12.643600, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1401.105102, -1386.995849, 12.643600, 0.000000, 0.000000, 183.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1396.235473, -1386.805908, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1389.395263, -1387.638916, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1383.057739, -1388.364257, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1376.038696, -1388.211669, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1370.884277, -1388.127685, 12.643600, 0.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1388.903808, -1433.169799, 12.643600, 0.000000, 0.000000, 273.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1397.520751, -1448.188110, 12.643600, 0.000000, 0.000000, 269.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 1389.290283, -1424.272583, 12.643600, 0.000000, 0.000000, 290.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1367.869628, -1414.755126, 12.569700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1377.795532, -1413.990234, 12.569700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1393.039916, -1387.154174, 12.569700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1384.859497, -1387.934692, 12.569700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 1372.282592, -1387.535766, 12.669699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1368, 1379.437622, -1386.181152, 13.273099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1368, 1370.947509, -1386.313232, 13.333100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14560, 1395.841674, -1384.432861, 15.987999, 0.000000, 0.000000, 92.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14608, 1420.886962, -1387.209350, 14.163999, 0.000000, 0.000000, 133.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1391.733886, -1388.666259, 13.033499, 0.000000, 0.000000, -33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1389.641113, -1388.755737, 13.033499, 0.000000, 0.000000, -113.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2764, 1390.739624, -1388.046752, 12.971699, 0.000000, 0.000000, 17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1391.799316, -1386.832519, 13.033499, 0.000000, 0.000000, 48.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1389.881958, -1387.057617, 13.033499, 0.000000, 0.000000, 91.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2764, 1406.604614, -1387.437500, 12.971699, 0.000000, 0.000000, 17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1407.828979, -1386.271118, 13.033499, 0.000000, 0.000000, 48.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1408.089965, -1388.095214, 13.033499, 0.000000, 0.000000, -33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1405.611938, -1388.623779, 13.033499, 0.000000, 0.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1405.364868, -1386.170532, 13.033499, 0.000000, 0.000000, 132.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1384.469848, -1388.732055, 13.033499, 0.000000, 0.000000, -113.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2764, 1385.552856, -1388.043701, 12.971699, 0.000000, 0.000000, 17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1386.507568, -1388.684204, 13.033499, 0.000000, 0.000000, -33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1386.533569, -1386.869995, 13.033499, 0.000000, 0.000000, 48.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1384.479125, -1387.116699, 13.033499, 0.000000, 0.000000, 91.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1400.161499, -1388.264282, 13.033499, 0.000000, 0.000000, -113.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2764, 1401.275634, -1387.552124, 12.971699, 0.000000, 0.000000, 17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1402.318115, -1388.168579, 13.033499, 0.000000, 0.000000, -33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1402.432861, -1386.329223, 13.033499, 0.000000, 0.000000, 48.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2807, 1400.677246, -1386.550781, 13.033499, 0.000000, 0.000000, 91.000000, -1, -1, -1, 300.00, 300.00);



    // VineWood by THUGLIFE

	new vwobjid;
	vwobjid = CreateDynamicObject(2631, 1001.775512, -1161.282714, 22.811000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF990000);
	vwobjid = CreateDynamicObject(2631, 1005.495483, -1161.282714, 22.811000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF990000);
	vwobjid = CreateDynamicObject(2631, 1022.502746, -1122.590209, 22.820999, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF990000);
	vwobjid = CreateDynamicObject(2631, 1022.499816, -1126.489990, 22.806999, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF990000);
	vwobjid = CreateDynamicObject(2631, 1022.499816, -1128.890014, 22.801000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF990000);
	vwobjid = CreateDynamicObject(19358, 1029.563964, -1170.117675, 33.657699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19404, 1032.841918, -1158.868041, 33.657699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19450, 1029.563964, -1163.696044, 33.657699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(16151, 1030.675048, -1168.041748, 32.255001, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 7, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	SetDynamicObjectMaterial(vwobjid, 8, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	vwobjid = CreateDynamicObject(19431, 1030.439941, -1158.868041, 33.657699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19450, 1032.484985, -1171.804687, 33.657699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19388, 1037.254882, -1163.545043, 33.657699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19358, 1035.722412, -1158.868041, 33.657699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19404, 1037.254882, -1160.459472, 33.657699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(1827, 1035.520874, -1168.589843, 31.880298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(vwobjid, 1, 10023, "bigwhitesfe", "sfe_arch8", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1031.385742, -1163.711059, 31.861000, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1031.385742, -1166.931030, 31.860000, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1035.445678, -1163.711059, 31.861499, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1035.445678, -1166.912109, 31.860000, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1034.845703, -1163.711059, 31.860000, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19452, 1034.865722, -1166.922241, 31.860399, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
	vwobjid = CreateDynamicObject(19358, 1037.215087, -1173.500610, 33.657699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
	vwobjid = CreateDynamicObject(19450, 1032.484252, -1175.019287, 33.657699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	SetDynamicObjectMaterial(vwobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);

	CreateDynamicObject(2643, 1195.816528, -1130.888183, 26.471900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1368, 1175.164550, -1132.277221, 23.445600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1368, 1179.304565, -1132.277221, 23.445600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19329, 1203.082519, -1131.098754, 26.516700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(11245, 983.166381, -1158.967041, 30.312799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19844, 983.119689, -1161.729614, 29.965700, 0.000000, -90.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19844, 980.219726, -1161.729614, 29.965700, 0.000000, -90.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(11245, 980.219726, -1158.967041, 30.312799, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 983.935974, -1159.685058, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 986.216003, -1159.685058, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 979.549926, -1159.686035, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 977.429870, -1159.686035, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 990.656005, -1159.684936, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 992.976013, -1159.684936, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 973.389892, -1159.465942, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 971.409912, -1159.465942, 24.044500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(7392, 1266.233642, -1157.301635, 48.146999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2456, 1193.394409, -1134.733886, 22.889400, 0.000000, 0.000000, -108.599922, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2456, 1198.811767, -1134.642211, 22.889400, 0.000000, 0.000000, -69.959922, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2599, 1114.093139, -1134.584228, 23.224399, 0.000000, 0.000000, 65.640007, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2599, 1131.382568, -1134.604125, 23.224399, 0.000000, 0.000000, 119.220008, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1359, 1205.373168, -1134.641845, 23.595899, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1443, 1304.190185, -1155.719360, 23.464099, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1443, 1312.556030, -1155.668945, 23.464099, 0.000000, 0.000000, 56.400009, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2946, 1003.437072, -1163.083251, 22.862800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2946, 1000.247924, -1163.083251, 22.862800, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2946, 1007.057128, -1163.083251, 22.862800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2946, 1003.877075, -1163.083251, 22.862800, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1023.778015, -1123.632324, 23.392200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1023.778015, -1128.292358, 23.392200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1021.177978, -1123.632324, 23.392200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1021.177978, -1128.292358, 23.352199, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1015.359008, -1130.382690, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(717, 1013.281372, -1129.724853, 22.925500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1017.539001, -1130.382690, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1006.743530, -1130.548461, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1008.943481, -1130.488525, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1011.003479, -1130.428466, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(717, 1031.702758, -1129.997314, 22.925500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1037.849487, -1130.613403, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1035.609497, -1130.613403, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1033.389526, -1130.613403, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1026.969482, -1130.613403, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1029.469482, -1130.613647, 23.344499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1363, 1046.285034, -1160.469360, 23.662000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1256, 1134.621948, -1159.047119, 23.451599, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1256, 1125.468383, -1158.878417, 23.451599, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1444, 1028.089843, -1155.669189, 23.622100, 0.000000, 0.000000, 109.439987, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1444, 1042.989135, -1155.265258, 23.622100, 0.000000, 0.000000, 109.439987, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2672, 1183.200195, -1131.057006, 23.239900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(849, 1187.885742, -1127.277099, 23.291200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1793, 1182.450317, -1126.949951, 22.540800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1439, 1182.507690, -1128.152954, 22.942800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1362, 1188.537231, -1130.016113, 23.496500, 0.000000, 0.000000, -29.760030, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2846, 1181.955322, -1124.574584, 23.209699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2670, 1187.762084, -1124.671752, 23.245599, 0.000000, 0.000000, -76.620002, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2673, 1186.331909, -1129.279296, 23.079599, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1359, 1145.146240, -1134.637939, 23.595899, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(4227, 1138.216918, -1159.567993, 24.706300, 0.000000, 0.000000, 179.339920, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1529, 1133.386718, -1159.423950, 25.130800, 10.000000, 0.000000, -90.180000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(18663, 1129.794555, -1159.377441, 24.640600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(18666, 1127.821899, -1159.358398, 25.563199, -20.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1346, 1137.906982, -1155.446533, 24.161600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1364, 1098.319213, -1131.837402, 23.599500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1364, 1107.965332, -1131.794921, 23.599500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2673, 1146.179199, -1155.566162, 22.943899, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2736, 1234.833740, -1158.652954, 28.645799, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2729, 1231.198486, -1158.722290, 24.551000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2731, 1238.365844, -1158.718017, 24.730800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2714, 1234.764648, -1159.205688, 25.388900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1045.838256, -1160.852539, 32.456100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1043.748535, -1158.787963, 32.456100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1039.588500, -1158.787963, 32.456100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1045.838256, -1164.992553, 32.456100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1043.752319, -1160.655761, 31.916099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(717, 1023.235656, -1155.693359, 23.000000, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1256, 1038.396362, -1158.212402, 23.451599, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1043.700683, -1165.235107, 31.916099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1045.277221, -1162.837280, 32.589298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1040.837768, -1159.450561, 32.589298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1040.669677, -1162.090820, 31.916099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1040.603393, -1165.230957, 31.916099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1043.438354, -1169.202514, 31.916099, 0.000000, 0.000000, 93.659988, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1569, 1029.683959, -1161.883789, 31.929599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2773, 1003.651184, -1161.084716, 23.361000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2773, 1000.230773, -1161.084716, 23.361000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2773, 1006.971191, -1161.084716, 23.361000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2773, 1282.181640, -1160.334594, 23.467100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2773, 1285.121704, -1160.334594, 23.467100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1045.838256, -1169.132446, 32.456100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(3857, 1037.260864, -1168.070800, 32.490699, 0.000000, 0.000000, -45.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19466, 1037.234863, -1160.532470, 33.987201, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(3857, 1033.231811, -1158.887084, 32.490699, 0.000000, 0.000000, -135.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1040.002075, -1169.130737, 31.916099, 0.000000, 0.000000, 156.420043, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1045.277221, -1167.577270, 32.589298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2258, 1035.347045, -1158.995727, 33.924499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19454, 1035.456665, -1163.732177, 35.324298, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19377, 1032.052246, -1170.255493, 35.329399, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19454, 1031.216552, -1163.732177, 35.344299, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19454, 1032.116455, -1163.732177, 35.325298, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2345, 1037.404052, -1162.144042, 35.198600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2345, 1037.404052, -1159.964111, 35.198600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2345, 1037.404052, -1164.083984, 35.198600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(3802, 1037.986328, -1161.855224, 34.278800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1727, 1035.903686, -1159.515258, 31.909500, 0.000000, 0.000000, 328.019592, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1727, 1035.000244, -1162.650390, 31.909500, 0.000000, 0.000000, 147.599990, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1726, 1034.518554, -1166.421752, 31.932199, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1726, 1036.529296, -1170.579589, 31.932199, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1727, 1033.891357, -1160.633422, 31.909500, 0.000000, 0.000000, 57.299999, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1822, 1035.001586, -1161.572753, 31.930000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1045.451293, -1174.960937, 32.272300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19121, 1045.519653, -1159.193725, 32.272300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2240, 1036.698486, -1164.745361, 32.442699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1361, 1038.211791, -1159.552490, 32.478900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19174, 1033.636108, -1171.714477, 34.051300, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2256, 1029.666870, -1164.955932, 34.095001, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1031.187011, -1159.548339, 32.627700, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19823, 1031.585937, -1169.133666, 32.881801, 0.000000, 0.000000, -63.419998, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19822, 1031.435180, -1170.673950, 32.881999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19818, 1031.812500, -1170.660034, 32.962299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(19818, 1031.778808, -1170.029418, 32.962299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1486, 1031.431518, -1168.792724, 33.021800, 0.000000, 0.000000, -174.899978, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1665, 1031.677246, -1168.772827, 32.902198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(17969, 1046.113403, -1165.655883, 25.257900, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(17969, 1189.214233, -1126.670043, 25.746999, 0.000000, 0.000000, 0.540000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1039.605346, -1175.310791, 32.456100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1043.765869, -1175.310791, 32.456100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(970, 1045.838256, -1173.252441, 32.456100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1040.002075, -1172.610717, 31.916099, 0.000000, 0.000000, 156.419998, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1825, 1043.581909, -1173.230957, 31.916099, 0.000000, 0.000000, 93.660003, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1361, 1037.838500, -1174.601928, 32.478900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1045.274902, -1171.666870, 32.589298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(638, 1040.837768, -1174.690795, 32.589298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2345, 1037.458984, -1172.804443, 35.198600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(2345, 1037.458984, -1173.764404, 35.198600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(3810, 1038.025268, -1172.828857, 34.258399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.0);
	CreateDynamicObject(1502, 1037.235961, -1162.758789, 31.903179, 0.000000, 0.000000, -90.100006, -1, -1, -1, 300.00, 300.0);

/*	// Italian Hood by Glibo
	exterior_maps = CreateDynamicObject(19377, 2632.661865, -1408.012329, 27.681247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 10041, "archybuild10", "vgnburgwal5_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 2632.661865, -1398.400024, 27.681247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 10041, "archybuild10", "vgnburgwal5_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 2632.661865, -1388.779785, 27.681247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 5397, "barrio1_lae", "corporate3green_128", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 2632.661865, -1379.169433, 27.681247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 5397, "barrio1_lae", "corporate3green_128", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 2632.681884, -1409.573120, 27.681247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 10041, "archybuild10", "vgnburgwal5_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1392.928466, 33.743671, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1391.787597, 33.743595, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.259277, -1390.358398, 33.742382, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.262695, -1389.177612, 33.740959, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.264892, -1387.677368, 33.739803, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.265869, -1386.416503, 33.738620, -63.299953, 89.899963, 90.000007, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1403.198730, 33.743671, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1402.057861, 33.743595, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.259277, -1400.628662, 33.742382, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1413.197753, 33.743671, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1412.056884, 33.743595, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.259277, -1410.627685, 33.742382, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1382.930053, 33.743671, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.258544, -1381.789184, 33.743595, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.259277, -1380.359985, 33.742382, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.262695, -1379.179199, 33.740959, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.264892, -1377.678955, 33.739803, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.265869, -1376.418090, 33.738620, 243.299957, -90.100021, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.262695, -1399.447875, 33.740959, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.264892, -1397.947631, 33.739803, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.265869, -1396.686767, 33.738620, -63.299945, 89.899963, 89.999984, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.262695, -1409.446899, 33.740959, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.264892, -1407.946655, 33.739803, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	exterior_maps = CreateDynamicObject(19172, 2633.265869, -1406.685791, 33.738620, -63.299938, 89.899963, 89.999961, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19607, "enexmarkers", "enexmarker4-2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateDynamicObject(1720, 2634.769531, -1377.183959, 29.427598, 0.000000, 0.000000, 65.799995, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.424804, -1377.867309, 29.427598, 0.000000, 0.000000, -113.800048, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.229248, -1378.348388, 29.427598, 0.000000, 0.000000, 157.999984, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.887939, -1376.640380, 29.427598, 0.000000, 0.000000, -24.400007, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.543457, -1377.498779, 29.838163, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2634.876220, -1382.954223, 29.427598, 0.000006, 0.000003, 51.000007, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.302246, -1384.037841, 29.427598, -0.000006, -0.000003, -128.600021, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.023193, -1384.197509, 29.427598, 0.000001, -0.000007, 143.199996, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.096435, -1382.714355, 29.427598, -0.000003, 0.000006, -39.199989, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.543945, -1383.456420, 29.838163, 0.000000, 0.000007, -14.799983, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.113525, -1389.947631, 29.427598, 0.000012, 0.000007, 29.200019, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.035156, -1391.483398, 29.427598, -0.000012, -0.000007, -150.399963, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2634.788330, -1391.156738, 29.427598, 0.000007, -0.000012, 121.399993, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.335449, -1390.178100, 29.427598, -0.000007, 0.000012, -60.999965, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.546875, -1390.661987, 29.838163, -0.000000, 0.000014, -36.599964, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.362060, -1377.315429, 30.368942, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.582275, -1377.255371, 30.368942, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1665, 2635.518066, -1377.583984, 30.287048, 0.000000, 0.000000, -85.799995, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.724853, -1377.416137, 30.417608, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.414550, -1383.459228, 30.417608, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1665, 2635.430664, -1390.558349, 30.287048, 0.000000, 0.000000, 147.099929, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19823, 2635.627197, -1383.284057, 30.279390, 0.000000, 0.000000, -18.900001, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1543, 2635.668212, -1383.449707, 30.271574, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.594726, -1383.659423, 30.417608, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1485, 2635.942382, -1383.557739, 30.264902, 0.000000, 0.000000, -173.000061, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1664, 2635.595947, -1390.426269, 30.439901, 0.000000, 0.000000, 41.099979, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.748291, -1390.668334, 30.368032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.498046, -1390.798461, 30.368032, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2634.769531, -1396.815917, 29.427598, 0.000006, 0.000003, 65.799995, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.424804, -1397.499267, 29.427598, -0.000006, -0.000003, -113.800025, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.229248, -1397.980346, 29.427598, 0.000002, -0.000007, 157.999938, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.887939, -1396.272338, 29.427598, -0.000003, 0.000006, -24.400001, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.543457, -1397.130737, 29.838163, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2634.876220, -1402.586181, 29.427598, 0.000011, 0.000007, 51.000007, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.302246, -1403.669799, 29.427598, -0.000011, -0.000007, -128.600021, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.023193, -1403.829467, 29.427598, 0.000006, -0.000013, 143.199996, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.096435, -1402.346313, 29.427598, -0.000007, 0.000011, -39.199989, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.543945, -1403.088378, 29.838163, -0.000001, 0.000014, -14.799983, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2635.113525, -1409.579589, 29.427598, 0.000015, 0.000013, 29.200019, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.035156, -1411.115356, 29.427598, -0.000015, -0.000013, -150.399963, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2634.788330, -1410.788696, 29.427598, 0.000013, -0.000016, 121.399971, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1720, 2636.335449, -1409.810058, 29.427598, -0.000013, 0.000015, -60.999954, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2725, 2635.546875, -1410.293945, 29.838163, -0.000005, 0.000021, -36.599964, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.362060, -1396.947387, 30.368942, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.582275, -1396.887329, 30.368942, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1665, 2635.518066, -1397.215942, 30.287048, -0.000007, 0.000000, -85.799972, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.724853, -1397.048095, 30.417608, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.414550, -1403.091186, 30.417608, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1665, 2635.430664, -1410.190307, 30.287048, 0.000004, -0.000006, 147.099929, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19823, 2635.627197, -1402.916015, 30.279390, -0.000002, 0.000007, -18.900001, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1543, 2635.668212, -1403.081665, 30.271574, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1486, 2635.594726, -1403.291381, 30.417608, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1485, 2635.942382, -1403.189697, 30.264902, -0.000000, -0.000007, -173.000015, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1664, 2635.595947, -1410.058227, 30.439901, 0.000005, 0.000005, 41.099967, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.748291, -1410.300292, 30.368032, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1667, 2635.498046, -1410.430419, 30.368032, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(642, 2635.491699, -1380.426513, 30.805595, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(642, 2635.491699, -1386.957397, 30.805595, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(642, 2635.491699, -1393.667358, 30.805595, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(642, 2635.491699, -1400.308471, 30.805595, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(642, 2635.491699, -1406.628784, 30.805595, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2646, 2632.940917, -1381.768554, 29.968582, -14.600002, 0.000000, 90.300079, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2646, 2632.986816, -1390.318969, 29.968582, -14.600002, 0.000000, 90.300079, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1211, 2637.050292, -1413.309936, 29.746072, 0.000000, 0.000000, 88.200012, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1216, 2633.229736, -1414.922851, 30.133794, 0.000015, 0.000000, 90.799980, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1216, 2633.238525, -1415.602661, 30.133794, 0.000015, 0.000000, 90.799980, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1223, 2636.692138, -1394.894287, 29.334640, 0.000000, 0.000000, 1.199969, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3802, 2633.399169, -1384.580200, 33.181686, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1223, 2636.418212, -1381.795898, 29.334640, 0.000000, 0.000000, 1.199969, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3802, 2633.399169, -1394.880859, 33.181686, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1223, 2636.967041, -1407.903930, 29.334640, 0.000000, 0.000000, 1.199969, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3802, 2633.399169, -1404.901611, 33.181686, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 2634.188964, -1406.606079, 29.415372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 2634.188964, -1400.366333, 29.415372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 2634.188964, -1393.625854, 29.415372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 2634.188964, -1387.005371, 29.415372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 2634.188964, -1380.514892, 29.415372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2668, 2632.726318, -1392.437133, 31.489748, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2668, 2632.726318, -1378.766479, 31.489748, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
*/

	// Verona Mall - Jibbrah
	exterior_maps = CreateDynamicObject(18766, 1129.026611, -1449.587402, 10.783200, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3998, "civic04_lan", "twintconc_LAn", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1131.044189, -1451.593261, 10.782400, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3998, "civic04_lan", "twintconc_LAn", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1129.040771, -1454.310546, 10.783208, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3998, "civic04_lan", "twintconc_LAn", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1127.026977, -1452.302001, 10.782400, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3998, "civic04_lan", "twintconc_LAn", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1129.057983, -1439.331787, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1145.701538, -1489.314941, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1112.466918, -1488.583129, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1127.970947, -1439.209594, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1130.187133, -1439.192626, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1129.081542, -1435.832275, 14.798218, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1129.081542, -1439.327026, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1129.081542, -1442.807617, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1112.478515, -1485.086791, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1112.478515, -1488.581542, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1112.478515, -1492.065185, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1145.705810, -1492.806640, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1145.705810, -1489.314208, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1145.705810, -1485.822387, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1111.260864, -1485.785888, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1111.260864, -1491.236572, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1113.696533, -1491.273193, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1113.696533, -1485.784179, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1146.936645, -1486.667724, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1146.936645, -1492.011718, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1144.540649, -1492.034179, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1144.540649, -1486.691772, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1140.898193, -1443.514770, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1140.892333, -1457.181762, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1115.937011, -1443.684692, 13.299590, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(18766, 1115.937011, -1457.321411, 13.299598, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1440.196289, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1443.689941, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1447.181396, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1453.816162, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1457.307617, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1115.946655, -1460.799926, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1460.799926, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1457.307617, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1453.816162, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1440.196289, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1443.689941, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1140.888549, -1447.181396, 14.798198, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1114.838378, -1443.527099, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1117.074096, -1457.413940, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1117.093017, -1443.434326, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1139.747802, -1457.266967, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1139.769897, -1443.496093, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1114.838378, -1457.437255, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1142.020629, -1443.592041, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1142.004150, -1457.283081, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1130.214233, -1450.348876, 14.797200, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1127.875366, -1450.348266, 14.798198, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1127.875366, -1453.555908, 14.798198, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1130.214233, -1453.555053, 14.797200, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3967, "cj_airprt", "CJ_RUBBER", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1094.840942, -1478.243164, 14.739898, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1092.127929, -1477.387939, 14.739898, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1089.401733, -1476.526977, 14.739898, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1089.436035, -1479.371582, 14.739898, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1092.162475, -1480.230102, 14.739898, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(1432, 1097.445678, -1480.126464, 14.895620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(1432, 1098.313720, -1476.899902, 14.895620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(1432, 1100.455322, -1470.128173, 14.895620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(1432, 1101.252441, -1467.511352, 14.895620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1102.519042, -1427.769287, 15.190098, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1154.810668, -1427.862792, 15.190098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1159.359130, -1504.530639, 14.734230, 0.000000, 0.000000, 69.659988, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1160.379272, -1501.799804, 14.734230, 0.000000, 0.000000, 69.659988, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1165.226806, -1500.367065, 14.647028, 0.000000, 0.000000, 158.939880, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1167.866455, -1501.385253, 14.647028, 0.000000, 0.000000, 158.939880, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1170.160644, -1502.274047, 14.647028, 0.000000, 0.000000, 158.939880, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2413, 1137.340698, -1527.187866, 14.792880, 0.000000, 0.000000, -249.659866, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2413, 1137.889038, -1528.691894, 14.792880, 0.000000, 0.000000, -249.659866, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2413, 1138.438354, -1530.168090, 14.792880, 0.000000, 0.000000, -249.659866, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2413, 1139.004150, -1531.686645, 14.792880, 0.000000, 0.000000, -249.659866, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2413, 1139.569458, -1533.205200, 14.792880, 0.000000, 0.000000, -249.659866, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(18092, 1094.210449, -1451.448120, 15.242638, 0.000000, 0.000000, -180.059967, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(1897, 1101.760498, -1454.316650, 14.717100, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	exterior_maps = CreateDynamicObject(2403, 1098.034790, -1437.126953, 14.767398, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2403, 1098.093139, -1443.176025, 14.767398, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1095.103271, -1441.239257, 14.774100, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2372, 1100.889526, -1445.508544, 14.767180, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	exterior_maps = CreateDynamicObject(2372, 1100.773803, -1435.769287, 14.767180, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2387, 1097.709472, -1436.783081, 14.785300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 4, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2387, 1097.709472, -1443.446044, 14.785300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 4, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2482, 1092.466552, -1439.615966, 14.746000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2482, 1092.466552, -1440.974853, 14.745968, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 4, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1096.928222, -1440.739746, 19.029560, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19379, 1084.823608, -1463.086791, 21.795980, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1086.595825, -1461.737915, 24.031070, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1083.438598, -1461.737548, 24.031070, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1091.959960, -1454.009765, 14.744000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1091.959960, -1455.915283, 14.744000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1091.959960, -1457.786132, 14.744000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1091.959960, -1459.670166, 14.744000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1098.066528, -1449.296752, 14.744000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 185.032226, -1449.296752, 14.744000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1101.466552, -1451.229370, 14.744000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1101.466552, -1453.434570, 14.744000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(2467, 1095.430297, -1451.482177, 14.428440, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1093.024291, -1510.939575, 16.500480, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1090.050781, -1507.757080, 16.500499, 0.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1087.062866, -1508.900878, 16.500499, 0.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1089.401733, -1476.526977, 18.198499, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1092.127929, -1477.387939, 18.198499, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(19929, 1094.840942, -1478.243164, 18.198499, 0.000000, 0.000000, -107.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(2460, 1098.008544, -1455.646362, 14.770798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	exterior_maps = CreateDynamicObject(2460, 1096.569458, -1457.823242, 14.770838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	exterior_maps = CreateDynamicObject(17951, 1163.103881, -1517.282104, 23.507259, 0.000000, 0.000000, -41.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
	exterior_maps = CreateDynamicObject(17951, 1159.015014, -1522.180541, 23.507259, 0.000000, 0.000000, -41.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
	exterior_maps = CreateDynamicObject(17951, 1155.053955, -1526.483032, 23.507259, 0.000000, 0.000000, -41.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1091.015014, -1505.758544, 16.500499, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1170.487182, -1508.522583, 14.647000, 0.000000, 0.000000, 69.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(2368, 1169.465576, -1511.179443, 14.647000, 0.000000, 0.000000, 69.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1154.827758, -1436.788452, 14.243700, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1154.827758, -1432.798706, 14.243700, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
	exterior_maps = CreateDynamicObject(19357, 1154.119750, -1434.313476, 14.243700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
	exterior_maps = CreateDynamicObject(19430, 1154.113159, -1436.083129, 14.239998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1153.979370, -1434.778320, 15.276200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18878, "ferriswheel", "railing3", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1161.952392, -1454.869750, 19.005060, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1094.671142, -1518.852661, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1093.673339, -1517.704589, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1092.651367, -1516.524780, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1091.677612, -1515.408325, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1099.598022, -1524.439453, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1100.655151, -1525.662597, 22.270599, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1101.740356, -1526.935913, 22.270599, 0.000000, 0.000000, -47.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(950, 1102.927978, -1528.193603, 22.270599, 0.000000, 0.000000, -47.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(949, 1098.261352, -1522.826049, 22.364049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(949, 1096.312988, -1520.561889, 22.364049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(5837, 1170.834350, -1474.280761, 13.455300, 0.000000, 90.000000, -162.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 18996, "mattextures", "sampblack", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 3, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(5837, 1169.676757, -1474.646240, 13.182478, 0.000000, 0.000000, -162.500000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 3, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1167.631713, -1479.578857, 15.470608, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1167.631713, -1479.578857, 15.971070, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1167.631713, -1479.578857, 16.497510, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1167.631713, -1479.578857, 17.018119, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1160.034423, -1464.020629, 16.312940, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19940, 1160.034423, -1464.020629, 16.817230, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1164.714111, -1506.454711, 19.063819, 0.000000, 0.000000, -21.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1112.812988, -1528.361328, 19.063800, 0.000000, 0.000000, -111.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1092.105102, -1506.628784, 19.063800, 0.000000, 0.000000, -159.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1094.227905, -1469.644897, 19.063800, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	exterior_maps = CreateDynamicObject(18075, 1096.679931, -1454.595825, 18.995019, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19937, 1164.574218, -1428.229248, 21.733280, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19937, 1166.487915, -1428.230468, 21.733280, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19937, 1167.662109, -1427.490356, 21.733299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1101.041259, -1459.088134, 22.143499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1097.434692, -1473.819824, 22.143499, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1096.783447, -1502.954711, 22.143470, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1102.679443, -1483.054687, 22.143499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1119.564575, -1483.193969, 22.143499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1141.115966, -1483.215209, 22.143499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1157.433837, -1483.270019, 22.143499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1138.977539, -1495.607910, 22.143499, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1155.945678, -1495.702392, 22.143499, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1120.680053, -1495.551391, 22.143499, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
	exterior_maps = CreateDynamicObject(1280, 1104.100341, -1495.521362, 22.143499, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0x00000000);
    exterior_maps = CreateDynamicObject(970, 1143.212524, -1415.921508, 13.126893, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1135.718505, -1415.921508, 13.126893, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1128.334960, -1415.921508, 13.126893, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1121.124511, -1415.886230, 13.126893, 0.000000, 0.000000, -0.199999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1113.872314, -1415.968994, 13.126893, 0.000000, 0.000000, 0.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1124.917236, -1562.271972, 13.126893, 0.000000, 0.000000, 0.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1131.859130, -1562.318481, 13.126893, 0.000000, 0.000000, 0.299999, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1186.096801, -1481.939819, 13.126893, 0.000000, 0.000000, 89.900009, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1186.102783, -1497.144287, 13.126893, 0.000000, 0.000000, 89.900009, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1186.146606, -1489.394653, 13.126893, 0.000000, 0.000000, 89.900009, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1061.152099, -1493.606811, 13.126893, 0.000000, 0.000000, -105.200004, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	exterior_maps = CreateDynamicObject(970, 1059.377075, -1500.157470, 13.126893, 0.000000, 0.000000, -105.200004, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "ws_wetdryblendsand2", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateObject(19322, 1117.585937, -1490.007812, 32.718799, 0.000000, 0.000000, 0.000000,600.00);
	exterior_maps = CreateObject(19323, 1117.58000000,-1490.01000000,32.72000000,0.00000000,0.00000000,0.00000000,600.00);
	exterior_maps = CreateDynamicObject(19325, 1155.305541, -1445.445556, 16.757499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1155.382568, -1435.131469, 16.458499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1155.264038, -1452.555175, 16.122900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1157.135375, -1467.956542, 16.326200, 0.000000, 0.000000, 19.020000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1160.604370, -1478.417114, 16.018499, 0.000000, 0.000000, 18.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1159.676147, -1502.225463, 16.009899, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1139.231445, -1523.631103, 16.172100, 0.000000, 0.000000, -69.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1116.960815, -1523.389160, 16.116600, 0.000000, 0.000000, -110.459999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1097.118408, -1502.079711, 16.306100, 0.000000, 0.000000, 21.059999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1096.577026, -1478.260864, 16.413749, 0.000000, 0.000000, -17.940000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1099.711425, -1468.494384, 16.068599, 0.000000, 0.000000, -17.799999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1101.798706, -1452.567260, 16.562299, 0.000000, 0.000000, -1.320000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1101.850708, -1445.212768, 16.177000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1984, 1158.167236, -1431.861450, 14.806448, 0.000000, 0.000000, -89.760032, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1887, 1163.909667, -1448.445190, 14.589859, 0.000000, 0.000000, -180.000122, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1887, 1166.870117, -1448.434326, 14.590588, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1887, 1169.812011, -1448.423339, 14.588068, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1888, 1163.898315, -1444.118164, 14.615368, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1888, 1166.885131, -1444.121948, 14.617480, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1888, 1169.874389, -1444.119506, 14.618080, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1848, 1168.883422, -1443.073486, 14.623888, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1848, 1164.895263, -1443.073852, 14.618300, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1163.828979, -1438.755859, 14.582248, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1166.799682, -1438.753295, 14.565070, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1169.802612, -1438.761352, 14.565070, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1169.815673, -1437.712768, 14.556280, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1166.815795, -1437.706176, 14.561100, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1843, 1163.843872, -1437.717651, 14.561100, 0.000000, 0.000000, -180.000106, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1849, 1164.901977, -1431.921508, 14.594638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1849, 1169.903564, -1431.918579, 14.594638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1883, 1176.131469, -1434.112426, 14.726980, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1883, 1176.118286, -1438.247558, 14.729760, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1883, 1176.139038, -1442.758666, 14.729760, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1883, 1176.130004, -1447.127075, 14.729760, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1846, 1176.144531, -1442.747192, 14.679840, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1846, 1176.127807, -1438.263061, 14.679840, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1846, 1176.132934, -1434.095581, 14.679840, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1846, 1176.139282, -1447.151977, 14.679840, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1847, 1182.876708, -1435.100585, 14.726888, 0.000000, 0.000000, -89.879966, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1847, 1182.903076, -1440.117065, 14.726888, 0.000000, 0.000000, -89.879966, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1847, 1182.917724, -1445.117431, 14.726888, 0.000000, 0.000000, -89.879966, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2371, 1167.426391, -1471.349121, 14.760708, 0.000000, 0.000000, 15.480010, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18001, 1166.766601, -1501.037353, 16.387109, 0.000000, 0.000000, -21.300010, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18003, 1166.061889, -1502.948242, 15.373600, 0.000000, 0.000000, -20.759990, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1159.204711, -1509.842163, 15.432970, 0.000000, 0.000000, -115.859992, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1159.986450, -1510.126586, 15.432970, 0.000000, 0.000000, -113.759986, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1160.937866, -1510.473876, 15.432970, 0.000000, 0.000000, -101.699981, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1161.751953, -1510.805419, 15.432970, 0.000000, 0.000000, -103.620002, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1162.540039, -1511.039794, 15.432970, 0.000000, 0.000000, -113.219970, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1163.341308, -1511.421142, 15.432970, 0.000000, 0.000000, -108.299972, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18092, 1140.055908, -1524.174682, 15.247200, 0.000000, 0.000000, 21.600009, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2502, 1144.622680, -1534.468872, 14.786108, 0.000000, 0.000000, -160.379928, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2502, 1143.331054, -1534.921630, 14.786108, 0.000000, 0.000000, -160.379928, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2502, 1142.042358, -1535.372802, 14.786108, 0.000000, 0.000000, -160.379928, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2475, 1146.880615, -1521.416137, 14.667968, 0.000000, 0.000000, -68.999946, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2147, 1087.242919, -1478.460327, 14.760700, 0.000000, 0.000000, 161.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2500, 1091.705688, -1480.203735, 15.638098, 0.000000, 0.000000, 159.059906, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2149, 1089.344116, -1479.323120, 15.815198, 0.000000, 0.000000, 162.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1101.842651, -1434.966796, 16.177000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1092.908935, -1517.400512, 23.398599, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1100.924316, -1526.507446, 23.398599, 0.000000, 0.000000, 42.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1094.320800, -1458.111328, 23.383600, 0.000000, 0.000000, 0.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1094.250732, -1444.782592, 23.383600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1433.016479, 14.707098, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1435.235473, 14.707098, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1437.460571, 14.707098, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360961, -1437.862060, 15.926300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360961, -1437.862060, 18.140100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.386962, -1431.845581, 15.926300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.386962, -1431.845581, 18.129999, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360839, -1433.015869, 18.056999, -89.500000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360839, -1435.236450, 18.037000, -89.500000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360839, -1437.455688, 18.017000, -89.500000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1437.460571, 15.566550, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1435.235473, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.385742, -1433.016479, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360717, -1436.441406, 14.567238, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.360717, -1434.212280, 14.567198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1443.548095, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1445.769165, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1447.989868, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.315307, -1442.425903, 15.926300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.315307, -1442.425903, 18.153200, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.289062, -1448.362670, 15.926300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.289062, -1448.362670, 18.157239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.293334, -1443.589965, 18.056999, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.293334, -1445.823364, 18.047000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.293334, -1448.039428, 18.037000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1447.989868, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1445.769165, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.314453, -1443.548095, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.291625, -1444.739746, 14.567238, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.291625, -1446.968994, 14.567198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.406738, -1441.390747, 15.351200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.406738, -1441.390747, 17.582689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.506591, -1438.965820, 17.411720, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.444824, -1440.158081, 18.037000, -90.000000, 0.000000, -2.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.506591, -1438.965820, 15.191748, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274658, -1449.508789, 15.872468, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274658, -1449.508789, 18.097578, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1450.709106, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1452.944702, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1455.172485, 14.709898, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.249633, -1455.444458, 15.926300, 1.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.249633, -1455.484497, 18.145000, 1.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.242065, -1450.759765, 18.017000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.242065, -1452.983520, 18.006998, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.242065, -1455.186523, 17.996999, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.357666, -1459.344360, 15.322098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.357666, -1459.344360, 17.547779, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.381347, -1456.623657, 16.781299, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.357666, -1459.863647, 18.017000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.357666, -1457.646850, 18.023000, -90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.381347, -1456.623657, 14.547760, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1455.172485, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1452.944702, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.274536, -1450.709106, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.250854, -1454.144531, 14.567198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1155.250854, -1451.920166, 14.567198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1156.676025, -1466.565185, 14.709898, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.393920, -1468.659545, 14.709898, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.115356, -1470.758178, 14.709898, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1156.300781, -1465.477539, 15.916500, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1156.300781, -1465.477539, 18.138809, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.234619, -1471.174072, 15.322098, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.234619, -1471.174072, 17.534940, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.381591, -1474.550537, 15.322098, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.381591, -1474.550537, 17.549999, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.039916, -1473.388916, 18.062999, -90.000000, 0.000000, 16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.720214, -1472.204223, 17.876960, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.720214, -1472.204223, 15.643070, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.839843, -1470.038940, 18.042999, -90.000000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.117797, -1467.942626, 18.052900, -89.500000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1156.394287, -1465.842529, 18.072900, -89.500000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.115356, -1470.758178, 15.566498, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.393920, -1468.659545, 15.566498, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1156.676025, -1466.565185, 15.566498, 90.000000, 90.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.760620, -1469.798095, 14.567198, 0.000000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.043579, -1467.708984, 14.567198, 0.000000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.654785, -1475.575195, 15.876500, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.045166, -1476.733886, 14.715998, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.749267, -1478.836791, 14.715998, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.457275, -1480.946289, 14.715998, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.522338, -1481.204223, 15.322098, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.522338, -1481.204223, 17.544359, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.654785, -1475.575195, 18.101509, 0.000000, 0.000000, 199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.036743, -1476.756713, 18.072998, -89.699996, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.759643, -1478.854248, 18.061000, -89.699996, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.484619, -1480.961914, 18.052999, -89.699996, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.457275, -1480.946289, 15.566498, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.749267, -1478.836791, 15.566498, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.045166, -1476.733886, 15.566498, 90.000000, 90.000000, 108.540000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.408935, -1477.885620, 14.567198, 0.000000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1161.117797, -1479.995361, 14.567198, 0.000000, 0.000000, 19.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.402343, -1500.291015, 14.736000, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.646118, -1502.378295, 14.736000, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.895751, -1504.443603, 14.736000, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.791381, -1499.228149, 15.876500, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.791381, -1499.228149, 18.103469, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.726318, -1504.835449, 15.876500, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.726318, -1504.835449, 18.092990, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.392578, -1500.248413, 18.069900, -89.699996, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.647460, -1502.295532, 18.059900, -89.699996, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.895263, -1504.367187, 18.049900, -89.699996, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.564819, -1508.190795, 15.876500, 0.000000, 0.000000, -22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.421386, -1505.920532, 17.688898, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.973266, -1507.082153, 18.069900, -90.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1157.564819, -1508.190795, 18.094640, 0.000000, 0.000000, -22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.421386, -1505.920532, 15.470140, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1158.895751, -1504.443603, 15.566498, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.646118, -1502.378295, 15.566498, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1160.402343, -1500.291015, 15.566498, 90.000000, 90.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.213623, -1503.505737, 14.567198, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1159.973632, -1501.408935, 14.567198, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1141.010498, -1522.991088, 14.736000, 90.000000, 90.000000, 20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1143.180908, -1522.204345, 15.876500, 0.000000, 0.000000, -68.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1145.459594, -1521.355102, 16.830650, 0.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1138.927490, -1523.770629, 14.736000, 90.000000, 90.000000, 20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1136.850952, -1524.552856, 14.736000, 90.000000, 90.000000, 20.799999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1144.352539, -1521.752929, 18.076000, -90.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1143.180908, -1522.204345, 18.109510, 0.000000, 0.000000, -68.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1145.459594, -1521.355102, 14.599160, 0.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1140.964721, -1522.966674, 18.035999, -90.500000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1136.507934, -1524.656738, 15.876500, 0.000000, 0.000000, -68.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1136.507934, -1524.656738, 18.108400, 0.000000, 0.000000, -68.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1142.088256, -1522.565917, 15.437600, 0.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1142.105468, -1522.555664, 17.655399, 1.000000, 0.000000, 111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1138.889526, -1523.762573, 18.055999, -90.500000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1136.809204, -1524.560913, 18.076000, -90.500000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1141.010498, -1522.991088, 15.566498, 90.000000, 90.000000, 20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1138.927490, -1523.770629, 15.566498, 90.000000, 90.000000, 20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1136.850952, -1524.552856, 15.566498, 90.000000, 90.000000, 20.799999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1137.776123, -1524.176025, 14.531768, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1139.867553, -1523.396484, 14.531768, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1118.789428, -1524.074340, 14.736000, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1113.184082, -1522.056396, 16.908750, 0.000000, 0.000000, 67.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1110.925292, -1521.179077, 15.876500, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1116.711181, -1523.295898, 14.736000, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1114.627563, -1522.516113, 14.736000, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1112.063842, -1521.604980, 18.076000, -90.000000, 0.000000, -110.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1110.925292, -1521.179077, 18.105800, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1113.184082, -1522.056396, 14.676488, 0.000000, 0.000000, 67.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1114.268188, -1522.358276, 15.876500, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1119.855468, -1524.479980, 15.902798, 0.000000, 0.000000, 67.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1119.855468, -1524.479980, 18.131900, 0.000000, 0.000000, 67.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1114.268188, -1522.358276, 18.097999, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1115.298706, -1522.742675, 18.035999, -89.699996, 0.000000, -111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1117.354736, -1523.531250, 18.045999, -89.699996, 0.000000, -111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1119.303466, -1524.243041, 18.055999, -90.000000, 0.000000, -109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1116.711181, -1523.295898, 15.566498, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1114.627563, -1522.516113, 15.566498, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1118.789428, -1524.074340, 15.566498, 90.000000, 90.000000, -20.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1115.587402, -1522.855957, 14.573908, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1117.645874, -1523.630615, 14.573908, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.838623, -1504.000976, 14.736000, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.045776, -1501.933227, 14.736000, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.248168, -1499.859741, 14.736000, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.412109, -1508.437133, 15.081898, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.412109, -1508.437133, 17.307790, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.575317, -1506.156616, 15.081898, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.997192, -1507.288208, 18.076000, -90.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.575317, -1506.156616, 17.285369, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.833129, -1503.929077, 18.038999, -90.400001, 0.000000, -159.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.241333, -1505.056518, 15.081898, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.124023, -1499.481567, 15.081898, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.241333, -1505.056518, 17.293079, 0.000000, 0.000000, 21.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.124023, -1499.481567, 17.276779, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.035644, -1501.849365, 18.054000, -90.400001, 0.000000, -159.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.239135, -1499.776367, 18.067989, -90.400001, 0.000000, -159.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.838623, -1504.000976, 15.566498, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.045776, -1501.933227, 15.566498, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.248168, -1499.859741, 15.566498, 90.000000, 90.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.631591, -1500.796264, 14.557628, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.431030, -1502.880615, 14.557628, 0.000000, 0.000000, -158.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1096.823974, -1521.941894, 23.398599, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1095.935424, -1480.198242, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.620483, -1478.084472, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.306884, -1475.972412, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.187988, -1470.059448, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.876831, -1467.943481, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.565795, -1465.826660, 14.736000, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.824584, -1471.182495, 15.081898, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.233886, -1469.999389, 18.048000, -90.000000, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.921752, -1467.883666, 18.054000, -90.300003, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.606079, -1465.779174, 18.065900, -90.300003, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.695922, -1465.511596, 15.081898, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.695922, -1465.511596, 17.286109, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.458740, -1475.585937, 15.081898, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.458740, -1475.585937, 17.286109, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.368896, -1475.853515, 18.065900, -90.300003, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.684570, -1477.958007, 18.054000, -90.300003, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.003295, -1480.054809, 18.048000, -90.000000, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1095.609008, -1481.201171, 17.317909, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1095.609008, -1481.201171, 15.081898, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.824584, -1471.182495, 17.298509, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.446044, -1472.241821, 15.339480, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.672241, -1474.547485, 16.883979, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.446044, -1472.241821, 17.555490, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1098.066284, -1473.401000, 18.048000, -90.500000, 0.000000, -198.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.672241, -1474.547485, 14.664669, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.306884, -1475.972412, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1095.935424, -1480.198242, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.620483, -1478.084472, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.565795, -1465.826660, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.876831, -1467.943481, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.187988, -1470.059448, 15.566498, 90.000000, 90.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1100.279418, -1466.784179, 14.562028, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1099.582763, -1468.928222, 14.562028, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1097.022827, -1476.920532, 14.562028, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1096.333007, -1479.047119, 14.562028, 0.000000, 0.000000, -199.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.817749, -1452.093872, 14.717100, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.876586, -1449.870117, 14.717100, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1447.206420, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1444.978759, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1442.774169, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1436.677612, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1434.457763, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1432.237426, 14.717100, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.730346, -1455.485839, 14.717100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.730346, -1455.485839, 16.816328, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.878051, -1449.513305, 14.717100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.878051, -1449.513305, 16.942539, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.832763, -1448.359008, 14.717100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.852294, -1442.436035, 14.717100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.832763, -1448.359008, 16.933670, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.852294, -1442.436035, 16.936149, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.823730, -1437.842895, 14.717100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.842773, -1431.869873, 14.717100, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.842773, -1431.869873, 16.935480, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.823730, -1437.842895, 16.951019, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.607299, -1459.344238, 15.174770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.607299, -1459.344238, 17.394960, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.608398, -1459.127441, 18.016000, -90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.609375, -1456.898925, 18.016000, -90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.746826, -1454.299316, 17.996000, -90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.801269, -1452.075439, 17.996000, -90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.859985, -1449.850219, 17.996000, -90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.832031, -1447.233154, 18.016000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.832519, -1445.012573, 18.016000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.830566, -1442.790161, 18.030000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.825805, -1437.008422, 18.016000, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.827026, -1434.787231, 18.025999, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.826782, -1432.564575, 18.037799, -89.699996, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.685913, -1438.958618, 16.802549, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.699218, -1441.394653, 14.717100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.699218, -1441.394653, 16.950838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.681030, -1440.154296, 18.045999, -90.000000, 0.000000, 1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.685913, -1438.958618, 14.586000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.760498, -1454.316650, 15.566498, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.876586, -1449.870117, 15.566498, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.817749, -1452.093872, 15.566498, 90.000000, 90.000000, 88.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1442.774169, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1444.978759, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.857055, -1447.206420, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1432.237426, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1434.457763, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.847290, -1436.677612, 15.566498, 90.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.764160, -1453.294311, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.820800, -1451.104858, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.827758, -1446.189575, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.828735, -1443.991088, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.821899, -1435.668579, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.818115, -1433.468139, 14.577098, 0.000000, 0.000000, -1.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19603, 1129.039550, -1451.955688, 15.535618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(728, 1133.567626, -1487.551391, 14.430198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(728, 1124.521240, -1487.727172, 14.430198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1115.890380, -1437.376586, 14.941590, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1116.122558, -1450.136230, 14.941590, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1115.937377, -1464.371215, 14.941590, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1140.975341, -1437.376586, 14.941598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1140.975341, -1450.136230, 14.941598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(737, 1140.975341, -1464.371215, 14.941598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1133.070190, -1491.190673, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1133.126098, -1494.224975, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1133.106811, -1497.414184, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1133.260009, -1483.623779, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1133.008544, -1478.571411, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1132.977539, -1481.031372, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.508666, -1479.208374, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.356079, -1481.823974, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.383544, -1484.390380, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.494018, -1491.520629, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.662353, -1494.217041, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 1124.443359, -1497.173339, 15.186598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.632934, -1456.608154, 17.395000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1897, 1101.632934, -1456.608154, 15.166020, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1514, 1095.001098, -1441.290161, 15.930000, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2731, 1101.859497, -1436.194702, 16.765680, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2730, 1101.859497, -1433.898193, 16.765699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2729, 1101.878051, -1444.180175, 16.765699, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2394, 1100.561035, -1435.177246, 15.477398, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2381, 1100.665405, -1444.940429, 15.464300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2436, 1092.336303, -1477.547607, 15.290100, 0.000000, 0.000000, 162.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2453, 1093.607421, -1477.769409, 16.008270, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1096.587280, -1470.145141, 15.354398, 0.000000, 0.000000, 164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1097.309082, -1467.597290, 15.354398, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2747, 1097.022583, -1468.867431, 15.176400, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1089.472900, -1472.196411, 15.354398, 0.000000, 0.000000, 163.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2747, 1089.822509, -1470.896240, 15.176400, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1090.208618, -1469.574462, 15.354398, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1090.545166, -1468.438232, 15.354398, 0.000000, 0.000000, 164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2747, 1090.980468, -1467.160522, 15.176400, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1091.266967, -1465.890380, 15.354398, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1094.311645, -1466.765625, 15.354398, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2747, 1094.025146, -1468.035766, 15.176400, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1093.589843, -1469.313476, 15.354398, 0.000000, 0.000000, 164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1093.253295, -1470.449707, 15.354398, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2748, 1092.517578, -1473.071655, 15.354398, 0.000000, 0.000000, 163.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2747, 1092.867187, -1471.771484, 15.176400, 0.000000, 0.000000, -17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1092.097045, -1462.742065, 14.750228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 185.097412, -1465.272583, 14.750228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1097.997558, -1471.612915, 14.750228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1096.982543, -1474.916625, 14.750228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1088.826782, -1473.121215, 14.750228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2642, 1097.484008, -1464.040405, 16.631900, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2642, 1094.672607, -1463.155761, 16.631900, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2641, 1096.069458, -1463.607055, 16.630439, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1094.334960, -1451.358032, 23.383600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2541, 1174.813232, -1432.035278, 14.782138, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2543, 1175.809082, -1431.900024, 14.782098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2165, 1114.953857, -1532.474365, 14.787598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2165, 1110.630981, -1530.927978, 14.787598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2165, 1113.797485, -1528.597167, 14.787598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1726, 1116.911010, -1524.242797, 14.694788, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1726, 1119.199096, -1525.763793, 14.694800, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1827, 1117.155517, -1526.272460, 14.729578, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1715, 1113.880981, -1530.199951, 14.784798, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1715, 1115.062133, -1533.999267, 14.784798, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1715, 1110.859863, -1532.535644, 14.784798, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2164, 1113.405273, -1535.182617, 14.771200, 0.000000, 0.000000, -100.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2164, 1108.341308, -1533.297851, 14.771200, 0.000000, 0.000000, -100.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1106.839599, -1528.101562, 14.781298, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1107.396118, -1526.549926, 14.781298, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1107.979980, -1524.888671, 14.781298, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2165, 1110.154907, -1527.066406, 14.787598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1715, 1110.198364, -1528.630126, 14.784798, 0.000000, 0.000000, 160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18092, 1149.606933, -1530.159790, 15.247200, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18092, 1147.907226, -1525.480590, 15.247200, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2475, 1148.300537, -1525.008300, 14.946000, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2475, 1150.049194, -1529.857910, 14.946000, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18092, 1144.285400, -1528.459594, 15.247200, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18092, 1142.030151, -1529.266479, 15.247200, 0.000000, 0.000000, 110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1569, 1094.336791, -1451.948364, 21.670850, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1092.820434, -1453.746337, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1091.540405, -1452.359375, 22.259000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1091.611083, -1449.951538, 22.259000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1091.621826, -1447.523193, 22.259000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1090.648437, -1446.122192, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1092.992797, -1443.742187, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1090.626098, -1443.742797, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2457, 1087.364624, -1441.590454, 21.715000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2457, 1085.438598, -1441.590454, 21.715000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2457, 1083.514038, -1441.590454, 21.715000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2457, 1081.590820, -1441.590454, 21.715000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(9093, 1085.006225, -1441.223876, 22.797649, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1087.198120, -1457.409423, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1084.450561, -1457.399780, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1081.645996, -1457.369506, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1087.397705, -1453.192993, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1085.225097, -1453.192993, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1083.056884, -1453.192993, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1080.886718, -1453.192993, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1087.397705, -1450.692504, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1087.397705, -1448.293579, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1087.397705, -1445.954345, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1089.291381, -1442.472656, 22.259000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1085.225097, -1450.692504, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1083.056884, -1450.692504, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1080.886718, -1450.692504, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1085.225097, -1448.293579, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1083.056884, -1448.293579, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1080.886718, -1448.293579, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1085.225097, -1445.954345, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1083.056884, -1445.954345, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2639, 1080.886718, -1445.954345, 22.334699, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1557, 1096.353393, -1521.421875, 21.696399, 0.000000, 0.000000, -49.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1090.062133, -1517.847656, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1086.934936, -1519.853027, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1089.618164, -1522.149658, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1090.965087, -1525.910644, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1094.394531, -1527.617187, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1095.918212, -1530.914306, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1099.304687, -1530.515136, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1098.443603, -1526.817138, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1092.590698, -1519.866943, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1086.186035, -1523.102294, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1092.287719, -1530.023193, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1087.412109, -1526.965942, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1825, 1094.481201, -1534.306884, 21.703069, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(16151, 1085.505126, -1532.784179, 22.051719, 0.000000, 0.000000, -139.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1078.752441, -1525.515014, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1090.185180, -1515.303588, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1102.685913, -1529.680297, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1091.272705, -1539.994750, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1097.421630, -1523.660766, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1095.480102, -1521.399291, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2286, 1080.503417, -1528.671752, 23.903369, 0.000000, 0.000000, 131.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2267, 1088.399291, -1537.670654, 23.885139, 0.000000, 0.000000, 132.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18075, 1090.834228, -1528.450683, 25.963640, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1156.412475, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1158.030883, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1159.636108, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1161.248779, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1162.854125, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1164.466552, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1166.083251, -1451.434570, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1162.854125, -1454.628173, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1161.248779, -1454.628173, 14.749798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1163.518798, -1456.922119, 14.749798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1161.907592, -1456.921386, 14.749798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1157.635498, -1460.110229, 14.749798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1161.017578, -1460.110229, 14.749798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2413, 1165.173950, -1460.110229, 14.749798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1959, 1093.160766, -1451.524780, 15.577678, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19449, 1091.649780, -1455.869262, 16.467390, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19449, 1091.649780, -1455.869262, 19.964500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19357, 1091.648315, -1449.453857, 16.467399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19357, 1091.648315, -1449.453857, 19.964500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(9833, 1128.468017, -1452.071533, 11.736160, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14683, 1088.313598, -1513.593627, 16.645399, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14684, 1089.015747, -1510.615966, 16.852460, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14685, 1089.382202, -1514.570556, 15.514398, 0.000000, 0.000000, 12.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14685, 1087.016357, -1512.322631, 15.497400, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3126, 1088.166381, -1513.174194, 16.013999, 0.000000, 80.000000, -115.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2255, 1096.629638, -1510.521728, 16.574409, 0.000000, 0.000000, 202.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1097.974487, -1432.430297, 15.539698, 0.000000, 0.000000, 2.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1097.385009, -1432.522460, 15.539698, 0.000000, 0.000000, 12.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1096.812377, -1432.626586, 15.539698, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1096.295166, -1432.865722, 15.539698, 0.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1095.781860, -1433.051513, 15.539698, 0.000000, 0.000000, 30.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2386, 1095.335449, -1433.360839, 15.539698, 0.000000, 0.000000, 36.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1098.029052, -1447.865478, 15.546198, 0.000000, 0.000000, -4.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1097.489990, -1447.819458, 15.546198, 0.000000, 0.000000, -4.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1096.900878, -1447.686157, 15.546198, 0.000000, 0.000000, -16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1096.402832, -1447.483520, 15.546198, 0.000000, 0.000000, -22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1095.904907, -1447.230957, 15.546198, 0.000000, 0.000000, -30.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1095.422851, -1446.966430, 15.546198, 0.000000, 0.000000, -36.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1094.973266, -1446.599365, 15.546198, 0.000000, 0.000000, -42.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2384, 1094.577270, -1446.198730, 15.546198, 0.000000, 0.000000, -50.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2374, 1097.741943, -1432.411621, 16.197799, 0.000000, 0.000000, 10.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2374, 1096.867431, -1432.511718, 16.208400, 0.000000, 0.000000, 14.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2374, 1096.069946, -1432.798461, 16.208400, 0.000000, 0.000000, 30.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2374, 1095.390136, -1433.195190, 16.208400, 0.000000, 0.000000, 32.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2377, 1094.799804, -1433.722412, 16.164489, 0.000000, 0.000000, 43.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2377, 1094.284057, -1434.280883, 16.164499, 0.000000, 0.000000, 53.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2377, 1093.888305, -1434.955444, 16.164499, 0.000000, 0.000000, 63.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2377, 1093.594726, -1435.554077, 16.164499, 0.000000, 0.000000, 71.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2377, 1093.379760, -1436.302734, 16.164499, 0.000000, 0.000000, 81.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1097.790771, -1447.927001, 16.166900, 0.000000, 0.000000, 85.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1096.954833, -1447.793457, 16.166900, 0.000000, 0.000000, 85.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1096.157104, -1447.516479, 16.166900, 0.000000, 0.000000, 61.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1095.491577, -1447.114135, 16.166900, 0.000000, 0.000000, 57.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1094.790039, -1446.579711, 16.166900, 0.000000, 0.000000, 47.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1094.327148, -1446.082031, 16.166900, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2383, 1093.900268, -1445.462036, 16.166900, 0.000000, 0.000000, 29.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2391, 1093.619140, -1444.784179, 16.180650, 0.000000, 0.000000, 112.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2391, 1093.420043, -1444.116333, 16.180700, 0.000000, 0.000000, 104.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2391, 1093.288208, -1443.425170, 16.180700, 0.000000, 0.000000, 92.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18891, 1093.589965, -1443.150756, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18892, 1093.602783, -1443.671264, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18892, 1093.285400, -1443.725097, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18891, 1093.250244, -1443.194580, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18891, 1093.344360, -1443.449218, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18892, 1093.694824, -1443.917724, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18892, 1093.349243, -1443.996459, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18894, 1093.846435, -1444.652587, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18894, 1093.622558, -1444.908447, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18894, 1093.975708, -1444.881469, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18901, 1093.843750, -1445.373657, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18901, 1094.128662, -1445.223144, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18901, 1093.980224, -1445.621459, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18901, 1094.225219, -1445.421997, 15.189800, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18898, 1093.546997, -1443.160034, 14.875638, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18898, 1093.553100, -1443.403442, 14.875638, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18898, 1093.559204, -1443.646850, 14.875638, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18903, 1093.615600, -1443.905761, 14.877140, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18903, 1093.690185, -1444.174682, 14.877140, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18903, 1094.320190, -1445.550781, 14.877140, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18903, 1094.179199, -1445.381713, 14.877140, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18896, 1093.962890, -1445.028686, 14.867210, -252.000000, -25.000000, -6.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18896, 1093.896240, -1444.823608, 14.867210, -252.000000, -25.000000, -6.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18896, 1093.788574, -1444.600585, 14.867210, -252.000000, -25.000000, -6.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18905, 1094.448852, -1445.987548, 15.156668, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18905, 1094.489624, -1446.328613, 15.156668, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18905, 1094.644042, -1446.052978, 15.156668, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18905, 1094.696533, -1446.437377, 15.156668, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18905, 1094.821289, -1446.188598, 15.156668, -252.000000, -25.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1095.456909, -1447.127441, 15.171698, -4.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1095.651977, -1446.879028, 15.171698, -4.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1095.681274, -1447.271362, 15.171698, -6.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1095.844116, -1447.053710, 15.171698, -6.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1095.886596, -1447.408569, 15.171698, -6.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18924, 1096.043945, -1447.146728, 15.171698, -6.000000, -91.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1095.623657, -1446.959228, 14.907050, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1095.938232, -1447.093139, 14.907050, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1096.257690, -1447.298583, 14.907050, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1096.572143, -1447.432250, 14.907050, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1095.623657, -1446.959228, 14.927100, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1095.623657, -1446.959228, 14.947098, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1095.938232, -1447.093139, 14.927100, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1096.572143, -1447.432250, 14.927100, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18639, 1096.572143, -1447.432250, 14.947098, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18939, 1096.913330, -1447.581665, 14.896328, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18939, 1097.132446, -1447.612304, 14.896328, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18939, 1097.351684, -1447.643066, 14.896328, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18939, 1096.913330, -1447.581665, 14.916298, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18939, 1096.913330, -1447.581665, 14.936300, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1096.865966, -1447.619140, 15.199118, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1097.036621, -1447.885742, 15.199118, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1097.147583, -1447.589477, 15.199118, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1097.327880, -1447.809692, 15.199118, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1096.865966, -1447.619140, 15.219099, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1097.036621, -1447.885742, 15.219099, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18941, 1097.036621, -1447.885742, 15.239100, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18942, 1097.688598, -1447.799194, 15.198300, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18942, 1097.988159, -1447.845092, 15.198300, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18943, 1097.601440, -1447.706298, 14.895568, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18943, 1097.820922, -1447.750610, 14.895568, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18943, 1098.041137, -1447.754638, 14.895568, -22.000000, -90.000000, -215.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.986938, -1432.409179, 15.209790, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.629516, -1432.471679, 15.209790, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.294433, -1432.572875, 15.209790, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1096.957641, -1432.634277, 15.209790, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.986938, -1432.409179, 15.229800, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.986938, -1432.409179, 15.249798, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.986938, -1432.409179, 15.269800, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.629516, -1432.471679, 15.229800, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.294433, -1432.572875, 15.229800, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19095, 1097.294433, -1432.572875, 15.249798, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18962, 1098.030273, -1432.529296, 14.907388, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18962, 1097.662841, -1432.565429, 14.907388, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18962, 1097.314941, -1432.595825, 14.907388, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18962, 1097.011230, -1432.696411, 14.907388, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1096.563110, -1432.868652, 14.906530, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1096.241943, -1432.983032, 14.906530, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1095.928588, -1433.115844, 14.906530, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1095.620239, -1433.311767, 14.906530, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1096.241943, -1432.983032, 14.926500, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19097, 1096.241943, -1432.983032, 14.946498, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1096.519409, -1432.733886, 15.208950, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1095.894653, -1433.052368, 15.208950, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1095.583374, -1433.189331, 15.208950, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1096.519409, -1432.733886, 15.229000, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1096.519409, -1432.733886, 15.248998, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19096, 1096.519409, -1432.733886, 15.269000, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1095.255615, -1433.589721, 14.913180, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1095.009277, -1433.798828, 14.913180, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1094.780151, -1434.078002, 14.913180, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1094.549804, -1434.328735, 14.913180, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1095.009277, -1433.798828, 14.933198, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1095.009277, -1433.798828, 14.953200, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19098, 1095.255615, -1433.589721, 14.933198, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18946, 1093.309692, -1436.323730, 15.178998, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18946, 1093.410278, -1435.996093, 15.178998, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18946, 1093.697753, -1436.099121, 15.178998, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18946, 1093.619628, -1436.465209, 15.178998, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18945, 1093.196899, -1437.067871, 15.182000, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18945, 1093.214965, -1436.705200, 15.182000, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18945, 1093.557128, -1437.045654, 15.182000, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18951, 1093.550659, -1437.075805, 14.894188, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18951, 1093.537475, -1436.753173, 14.894200, -10.000000, -90.000000, -26.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18951, 1093.616455, -1436.374877, 14.894188, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18951, 1093.685668, -1436.059204, 14.894188, -10.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.753662, -1435.660766, 14.869580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.875122, -1435.441284, 14.869580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.956542, -1435.221557, 14.869580, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.956542, -1435.221557, 14.889598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.956542, -1435.221557, 14.909600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18968, 1093.875122, -1435.441284, 14.889598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18969, 1093.577148, -1435.524780, 15.193498, 0.000000, 14.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18969, 1093.882812, -1435.608520, 15.193498, 0.000000, 14.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18969, 1093.685668, -1435.298706, 15.193498, 0.000000, 14.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18969, 1093.967407, -1435.324096, 15.193498, 0.000000, 14.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18969, 1093.773071, -1435.073852, 15.193498, 0.000000, 14.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.598266, -1438.931030, 16.118000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.606567, -1439.130981, 16.118000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.595092, -1439.332031, 16.118000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.603515, -1439.532104, 16.118000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.598266, -1438.931030, 16.138000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.606567, -1439.130981, 16.138000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.606567, -1439.130981, 16.158000, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18953, 1092.606567, -1439.130981, 16.177999, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.610595, -1440.214843, 16.439899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.606933, -1440.411254, 16.439899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.612915, -1440.634155, 16.439899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.600219, -1440.837280, 16.439899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.629516, -1441.059570, 16.439899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.600219, -1440.837280, 16.459899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.600219, -1440.837280, 16.479900, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.612915, -1440.634155, 16.459899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18954, 1092.606933, -1440.411254, 16.459899, -10.000000, -90.000000, -84.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2354, 1093.278930, -1472.142944, 15.645998, -25.000000, 24.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2354, 1096.873168, -1469.044799, 15.645998, -25.000000, 24.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2214, 1091.498901, -1467.170288, 15.651900, -25.000000, 24.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2214, 1089.693115, -1470.696044, 15.651900, -25.000000, 24.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2214, 1090.312377, -1471.293579, 15.651900, -25.000000, 24.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2641, 1090.249389, -1466.991455, 16.630399, 0.000000, 0.000000, 72.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19830, 1090.990844, -1477.007080, 15.652850, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.788574, -1479.157104, 15.737700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.624389, -1479.199462, 15.737700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.544433, -1479.059692, 15.737700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.701416, -1478.989868, 15.737700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.624389, -1479.199462, 15.757699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1088.624389, -1479.199462, 15.777700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1092.750610, -1471.470214, 15.680488, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1093.888916, -1468.219848, 15.680488, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1094.381225, -1467.829833, 15.680488, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19835, 1093.803955, -1467.740234, 15.680488, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1089.851318, -1479.559570, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.113891, -1479.659057, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.244140, -1479.363891, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1089.994995, -1479.289306, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.397583, -1479.768798, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.500122, -1479.462402, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.684326, -1479.874633, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19811, 1090.775024, -1479.611816, 15.719598, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1093.288085, -1480.462402, 15.722398, 0.000000, 0.000000, -196.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1514, 1090.335693, -1477.049194, 15.781998, 0.000000, 0.000000, 162.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2453, 1095.871582, -1478.470825, 16.008270, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2436, 1095.023803, -1478.405395, 15.290100, 0.000000, 0.000000, 162.500000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2643, 1091.896362, -1476.983886, 18.287239, 0.000000, 0.000000, 163.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2643, 1091.826904, -1477.089477, 18.287200, 0.000000, 0.000000, -18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2642, 1093.026855, -1477.241699, 18.063459, 0.000000, 0.000000, 162.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2642, 1090.840942, -1476.555419, 18.063459, 0.000000, 0.000000, 162.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18865, 1096.144287, -1451.629028, 15.769808, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18866, 1095.307128, -1451.679565, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18867, 1096.211425, -1451.677856, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18867, 1096.071289, -1451.677001, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18867, 1095.791015, -1451.675292, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18867, 1095.644531, -1451.671386, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18866, 1095.486328, -1451.684936, 16.143299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18865, 1095.984252, -1451.629028, 15.769800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18865, 1095.824340, -1451.629028, 15.769800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18865, 1095.524291, -1451.629028, 15.769800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18865, 1095.344360, -1451.629028, 15.769800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18868, 1098.158935, -1449.444824, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18869, 1098.733764, -1449.442382, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18868, 1097.858642, -1449.433837, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18868, 1098.018798, -1449.439697, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18869, 1098.334838, -1449.436035, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18869, 1098.474975, -1449.441162, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18869, 1098.595092, -1449.445556, 16.470439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1097.805664, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1097.945678, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1098.105712, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1098.365722, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1098.505737, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18870, 1098.725708, -1449.434326, 16.070198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18871, 1097.902587, -1449.444580, 15.724300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18871, 1098.082641, -1449.444580, 15.724300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18871, 1098.262573, -1449.444580, 15.724300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18872, 1098.516967, -1449.439208, 15.724220, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18872, 1098.636962, -1449.439208, 15.724200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18872, 1097.974121, -1449.429077, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18872, 1098.094116, -1449.429077, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18874, 1098.309814, -1449.433593, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18874, 1098.469848, -1449.433593, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18874, 1098.609741, -1449.433593, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18874, 1098.769653, -1449.433593, 15.340998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.046386, -1454.128417, 16.475660, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.033081, -1453.788208, 16.475660, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.021728, -1453.367065, 16.475700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.094848, -1453.367065, 16.095399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.095336, -1453.787719, 16.095359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19421, 1092.091918, -1454.128906, 16.095359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.069458, -1454.128417, 15.736398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.097167, -1453.788208, 15.736398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.080566, -1453.367065, 15.736398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.080566, -1453.367065, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.080810, -1453.788208, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.067871, -1454.128417, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.050537, -1456.036499, 16.470489, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.045288, -1455.636108, 16.470489, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.039306, -1455.255737, 16.470489, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.085327, -1456.097656, 15.733200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.050537, -1456.036499, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.045288, -1455.636108, 16.090799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.039306, -1455.255737, 16.090799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.095092, -1455.635375, 15.733200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.062500, -1455.256835, 15.733168, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.085327, -1456.097656, 15.366330, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.095092, -1455.635375, 15.366298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19424, 1092.062500, -1455.256835, 15.366298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1096.284545, -1455.817749, 15.652000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1096.544555, -1455.817749, 15.652000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1096.784423, -1455.817749, 15.652000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1097.024414, -1455.817749, 15.652000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1097.324340, -1455.817749, 15.652000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1096.326904, -1455.728881, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1096.746948, -1455.728881, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1097.146850, -1455.728881, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1097.566894, -1455.728881, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1098.238647, -1455.712402, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19623, 1098.245605, -1455.424194, 15.079000, 0.000000, 180.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.502075, -1453.205444, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.340576, -1453.197998, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.510375, -1453.512084, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.348876, -1453.504638, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.505493, -1453.855346, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.343505, -1453.884399, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.503906, -1454.175170, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 1101.344726, -1454.164428, 16.081470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1096.298950, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1096.699829, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1097.060791, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1097.482421, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1097.808837, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18875, 1098.125610, -1457.781127, 15.395000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.380371, -1451.071899, 15.794500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.375610, -1451.496337, 15.794500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.368041, -1451.920654, 15.794500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.368041, -1451.920654, 15.428480, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.380371, -1451.071899, 15.428500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19807, 1101.375610, -1451.496337, 15.428500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(11728, 1101.303344, -1451.755859, 15.074398, -90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(11728, 1101.308715, -1451.128051, 15.074398, -90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19053, 1099.997680, -1449.398925, 16.537799, -18.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19053, 1100.198486, -1449.393554, 16.537799, -18.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19053, 1100.418945, -1449.389892, 16.537799, -18.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19053, 1100.639282, -1449.386108, 16.537799, -18.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.054565, -1457.911376, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.052124, -1457.550537, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.043090, -1459.802246, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.024291, -1459.410156, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19423, 1092.032104, -1459.084838, 16.090780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.077026, -1459.901000, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.077026, -1459.500976, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19422, 1092.083129, -1459.095703, 15.368200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1984, 1158.397460, -1444.155395, 14.742548, 0.000000, 0.000000, -89.760002, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1157.856445, -1451.472290, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1158.374755, -1451.450073, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1158.804809, -1451.455566, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1157.856445, -1451.472290, 14.980620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1158.322143, -1451.482177, 14.980620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1158.914306, -1451.512695, 14.980620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1159.429931, -1451.437133, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1159.966674, -1451.434692, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1160.407592, -1451.432373, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1161.110473, -1451.467285, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1161.552612, -1451.458496, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1162.018676, -1451.470703, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1157.202636, -1451.463378, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1156.734985, -1451.459716, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1156.264160, -1451.470214, 15.310118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1157.202636, -1451.463378, 14.980600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1156.264160, -1451.470214, 14.980600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1160.407592, -1451.432373, 14.980600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1159.966674, -1451.434692, 14.980600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19941, 1161.552612, -1451.458496, 14.980600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1163.128051, -1441.743164, 23.606620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1092.161621, -1501.187011, 15.392998, 0.000000, 0.000000, -248.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14683, 1086.129272, -1507.962036, 16.645399, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14685, 1084.569213, -1505.978759, 15.497400, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14684, 1086.819946, -1504.989379, 16.852460, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1093.086181, -1500.837646, 15.392998, 0.000000, 0.000000, -248.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1093.970581, -1500.507934, 15.392998, 0.000000, 0.000000, -248.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1094.908203, -1500.192749, 15.392998, 0.000000, 0.000000, -248.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1095.276977, -1510.996337, 15.392998, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1096.318237, -1510.627685, 15.392998, 0.000000, 0.000000, -68.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1811, 1097.365722, -1510.195922, 15.392998, 0.000000, 0.000000, -66.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2010, 1115.770629, -1535.615112, 14.776438, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2010, 1118.315551, -1528.224243, 14.776438, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2010, 1105.828613, -1531.978881, 14.776438, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2010, 1109.702758, -1521.607910, 14.776438, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2010, 1112.540039, -1527.921997, 14.776438, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19805, 1118.076538, -1530.693847, 16.477899, 0.000000, 0.000000, -110.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18003, 1168.409301, -1508.321899, 15.373600, 0.000000, 0.000000, -111.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18001, 1170.296752, -1509.080566, 16.387100, 0.000000, 0.000000, -111.120002, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2643, 1098.275146, -1473.399291, 18.978040, 1.000000, 0.000000, 74.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1162.139648, -1454.654052, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.955444, -1454.645874, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.758056, -1454.651855, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.579345, -1454.648315, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.357299, -1454.670654, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.088623, -1454.680908, 15.326000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1162.139648, -1454.654052, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.955444, -1454.645874, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.758056, -1454.651855, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.579345, -1454.648315, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.357299, -1454.670654, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19039, 1161.088623, -1454.680908, 15.008000, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.750610, -1454.675292, 15.326700, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.472656, -1454.677734, 15.326700, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.202026, -1454.698730, 15.326700, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1162.949951, -1454.712158, 15.326700, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1162.635620, -1454.703002, 15.326700, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.750610, -1454.675292, 15.006698, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1162.635620, -1454.703002, 15.006698, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1162.949951, -1454.712158, 15.006698, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.202026, -1454.698730, 15.006698, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19040, 1163.472656, -1454.677734, 15.006698, -10.000000, 0.000000, 185.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.771972, -1456.878784, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.471679, -1456.867797, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.195434, -1456.874389, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.522338, -1456.878662, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.857055, -1456.862670, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.522338, -1456.878662, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.857055, -1456.862670, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.195434, -1456.874389, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.471679, -1456.867797, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1163.771972, -1456.878784, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.222534, -1456.866699, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.902343, -1456.857299, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.621948, -1456.851562, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.381347, -1456.865722, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.093994, -1456.877929, 15.319800, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1162.222534, -1456.866699, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.902343, -1456.857299, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.621948, -1456.851562, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19042, 1161.381347, -1456.865722, 15.005298, -4.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.424316, -1443.345947, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.423828, -1442.699951, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.440429, -1442.076538, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.202758, -1434.730224, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.213623, -1435.360961, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.223876, -1435.992065, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1885, 1158.185058, -1436.615112, 14.760828, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.654663, -1436.111816, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.655883, -1435.793945, 15.359600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1435.534057, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1435.274047, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1434.994018, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1434.713989, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1434.433959, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1434.153930, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1433.853881, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1349, 1154.667846, -1433.553955, 15.339598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1078.904052, -1457.356201, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1090.015747, -1457.448486, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2773, 1092.836059, -1457.426879, 22.258989, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1087.719970, -1460.319580, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1087.719970, -1459.038330, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1087.719970, -1457.777221, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1085.964111, -1460.319580, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1084.171997, -1460.319580, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1082.259521, -1460.319580, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1085.964111, -1459.038330, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1085.964111, -1457.777221, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1084.171997, -1459.038330, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1084.171997, -1457.777221, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1082.259521, -1459.038330, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2707, 1082.259521, -1457.777221, 25.969900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1091.229980, -1453.314086, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1087.130737, -1453.314086, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1079.038085, -1453.314453, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1082.820434, -1453.314086, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1091.229980, -1448.042236, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1087.130737, -1448.042236, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1082.820434, -1448.042236, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2740, 1079.038085, -1448.042236, 25.882698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1089.269409, -1461.531616, 25.065919, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1080.431030, -1461.484252, 25.065919, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1079.326293, -1441.511474, 25.065900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1091.475708, -1441.513671, 25.065900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1161.231201, -1460.069091, 15.319998, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.950317, -1460.042968, 15.319998, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.651367, -1460.004638, 15.319998, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.401367, -1460.040527, 15.319998, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.114868, -1460.028320, 15.319998, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.132934, -1460.085449, 15.636698, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.505615, -1460.072509, 15.636698, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1160.884277, -1460.078491, 15.636698, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19043, 1161.238281, -1460.134399, 15.636698, -2.000000, -2.000000, 22.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.869384, -1460.040771, 15.319990, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.641723, -1460.020751, 15.319990, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.400146, -1460.038208, 15.319990, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.166625, -1460.060913, 15.319990, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1156.886352, -1460.062744, 15.319990, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1156.778076, -1460.114746, 15.629549, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.019897, -1460.109619, 15.629549, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.279907, -1460.095825, 15.629549, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.534667, -1460.100219, 15.629549, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19041, 1157.758056, -1460.089233, 15.629549, -8.000000, 0.000000, 24.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1514, 1160.440063, -1451.381835, 16.024000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1167.297607, -1449.523315, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1167.365600, -1460.071655, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1162.713867, -1460.035034, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1156.136230, -1460.089111, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1156.173950, -1456.046020, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2001, 1155.991943, -1449.660400, 14.781000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 1107.177856, -1419.915161, 15.197090, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 1150.315673, -1419.897460, 15.197090, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1093.435668, -1529.171997, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1089.238647, -1526.764526, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(948, 1091.097778, -1521.161132, 21.688209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2287, 1083.816284, -1520.776977, 23.392969, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2287, 1088.521240, -1516.654174, 23.392969, 0.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19786, 1085.852661, -1518.300781, 24.019399, 4.000000, 0.000000, 41.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19786, 1098.725341, -1534.256469, 24.019399, 4.000000, 0.000000, 221.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2284, 1100.323364, -1532.185546, 23.322589, 0.000000, 0.000000, -139.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2284, 1096.483520, -1535.541748, 23.322589, 0.000000, 0.000000, -139.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2734, 1092.466430, -1440.129760, 17.693740, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2452, 1179.723388, -1431.795288, 14.749608, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2452, 1180.583007, -1448.379150, 14.749600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18075, 1177.097290, -1440.047241, 19.074600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18075, 1165.567749, -1440.047241, 19.074600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(336, 1141.517944, -1523.103515, 15.841620, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(336, 1141.592651, -1523.379760, 15.841620, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(336, 1141.680419, -1523.622070, 15.841620, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(336, 1141.788818, -1523.817993, 15.841620, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19631, 1142.601684, -1531.020751, 15.766300, -2.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19631, 1142.340209, -1531.102783, 15.766300, -2.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.604858, -1534.256958, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.556884, -1534.405517, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.260009, -1534.524780, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.270996, -1534.391113, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1143.955810, -1534.625854, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.003906, -1534.477172, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1143.959228, -1534.365844, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.801635, -1534.047973, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.853759, -1534.177856, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 1144.846557, -1534.374633, 15.827598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.575805, -1534.785400, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.495849, -1534.645629, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.273193, -1534.890014, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.203979, -1534.724121, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.176269, -1534.605834, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1143.052001, -1534.982299, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1142.804687, -1535.063842, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1142.735473, -1534.897949, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1142.630981, -1535.114624, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19804, 1142.560180, -1534.841064, 15.912118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19894, 1098.102172, -1457.685058, 15.630000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19894, 1097.670043, -1457.690551, 15.630000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19894, 1097.217285, -1457.687377, 15.630000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19894, 1096.524047, -1457.683593, 15.630000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19919, 1140.540039, -1535.781860, 14.779198, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19921, 1150.477294, -1531.908935, 15.821660, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19921, 1150.309204, -1531.488647, 15.821660, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19921, 1149.675415, -1532.195922, 15.821700, 0.000000, 0.000000, -77.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19622, 1145.760742, -1534.062500, 15.493788, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19622, 1146.304687, -1533.824951, 15.493788, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19622, 1146.846679, -1533.643920, 15.493788, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19622, 1147.389526, -1533.462280, 15.493788, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19622, 1145.704345, -1534.060791, 15.483798, 6.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19626, 1147.910034, -1533.325561, 15.601320, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19626, 1148.138916, -1533.251708, 15.601320, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19626, 1148.378540, -1533.151733, 15.601320, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19626, 1148.599731, -1533.059448, 15.601320, 0.000000, 0.000000, -160.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18890, 1140.990600, -1523.987426, 15.652998, 0.000000, 0.000000, -156.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18890, 1141.250732, -1523.874755, 15.652998, 0.000000, 0.000000, -156.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18890, 1140.737548, -1524.072021, 15.652998, 0.000000, 0.000000, -162.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.947875, -1528.998413, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.825927, -1528.754516, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.769897, -1528.540283, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.677734, -1528.352539, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.585449, -1528.162719, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 1137.504028, -1527.873779, 15.363080, 0.000000, 90.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.502319, -1530.493041, 15.668848, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.425659, -1530.263793, 15.668848, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.299560, -1530.028808, 15.668848, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.312744, -1529.813964, 15.668848, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.178466, -1529.434448, 15.668848, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.178466, -1529.434448, 15.372480, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.322021, -1529.675170, 15.372480, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18641, 1138.527465, -1530.358886, 15.372480, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18633, 1148.769165, -1526.823120, 15.774998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18633, 1148.601928, -1526.967651, 15.774998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18633, 1148.231933, -1527.639648, 15.774998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18633, 1148.441528, -1527.480224, 15.774998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18633, 1148.909423, -1527.514648, 15.774998, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 1148.958862, -1528.096069, 15.736000, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 1149.032714, -1528.302856, 15.736000, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 1149.101196, -1528.553955, 15.736000, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 1148.580932, -1528.760131, 15.736000, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 1148.499511, -1528.470947, 15.736000, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18632, 1145.075561, -1530.491577, 15.762298, 0.000000, 92.000000, -62.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18632, 1145.161743, -1530.467529, 15.762298, 0.000000, 92.000000, -62.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18632, 1145.248046, -1530.443359, 15.762298, 0.000000, 92.000000, -62.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18632, 1145.510375, -1530.351318, 15.762298, 0.000000, 92.000000, -62.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19308, 1149.973754, -1530.246704, 16.579940, 0.000000, 0.000000, 12.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19309, 1150.095703, -1530.778564, 15.866748, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19309, 1149.729003, -1530.061767, 15.866748, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19308, 1149.993286, -1530.242431, 17.249469, 0.000000, 0.000000, 12.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19329, 1155.183349, -1440.180297, 18.611490, 0.000000, 0.000000, 88.139999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1143.247436, -1526.458984, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1143.479125, -1526.423461, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1143.765747, -1526.419677, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1143.776367, -1527.074951, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1144.035400, -1527.004394, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19348, 1144.157104, -1527.416748, 15.760000, 0.000000, 90.000000, -55.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1159.047363, -1464.461669, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1159.994384, -1464.153564, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1160.938232, -1463.847900, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2440, 1162.522460, -1465.663208, 14.749898, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2440, 1158.731323, -1466.851074, 14.749898, 0.000000, 0.000000, -73.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1161.582519, -1465.966796, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1160.638671, -1466.272460, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2439, 1159.691650, -1466.580566, 14.749938, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19611, 1165.953979, -1475.926391, 14.917030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19610, 1165.973876, -1475.922851, 16.546100, 16.000000, -2.000000, -74.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19317, 1168.579711, -1473.229125, 15.670000, -6.000000, -4.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19609, 1168.195068, -1475.465942, 14.900930, 0.000000, 0.000000, -62.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2231, 1169.912963, -1477.719726, 14.771300, 0.000000, 0.000000, -76.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2231, 1168.301635, -1472.537231, 14.771300, 0.000000, 0.000000, -64.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2233, 1166.967773, -1466.905395, 14.761898, 0.000000, 0.000000, -73.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2233, 1166.562622, -1467.050170, 14.761898, 0.000000, 0.000000, -73.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2229, 1166.338867, -1466.327026, 14.754750, 0.000000, 0.000000, -76.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2230, 1166.229370, -1465.749755, 14.762740, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1841, 1163.401123, -1463.148437, 14.771820, 0.000000, 0.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1841, 1163.818481, -1463.011962, 14.771820, 0.000000, 0.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1841, 1164.208984, -1462.883300, 14.771820, 0.000000, 0.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1841, 1162.994384, -1463.267822, 14.771820, 0.000000, 0.000000, 109.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1841, 1163.838989, -1462.976562, 15.232998, 0.000000, 0.000000, 76.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1514, 1159.494262, -1466.528198, 15.912590, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1165.610595, -1464.749145, 15.341400, 0.000000, 0.000000, -72.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19318, 1163.377075, -1481.046752, 15.472888, -4.000000, 0.000000, -164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19319, 1164.043579, -1480.775268, 15.447230, -4.000000, 0.000000, -164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19317, 1164.828002, -1480.519042, 15.528968, -4.000000, 0.000000, -164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19317, 1165.409423, -1480.372924, 15.528968, -4.000000, 0.000000, -164.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19609, 1166.452514, -1468.521118, 14.735198, 0.000000, 0.000000, -64.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1809, 1159.028564, -1464.623413, 15.649200, 0.000000, 0.000000, 16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1783, 1160.155761, -1464.192016, 15.862500, 0.000000, 0.000000, 20.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1790, 1160.295043, -1463.880981, 16.385269, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1790, 1159.511962, -1464.130615, 16.385269, 0.000000, 0.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18075, 1163.499389, -1471.171264, 19.023950, 0.000000, 0.000000, 17.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18075, 1143.612182, -1527.977661, 19.063800, 0.000000, 0.000000, -70.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19325, 1163.112182, -1428.453369, 23.606620, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1164.582641, -1443.383789, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2628, 1178.167724, -1436.640258, 21.717500, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2629, 1178.475463, -1430.258422, 21.719999, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2630, 1173.256103, -1443.498046, 21.723800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2632, 1172.427001, -1433.418823, 21.705600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1166.802978, -1443.383789, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1169.033813, -1443.383789, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1164.582641, -1439.682373, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1166.802978, -1439.682373, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2627, 1169.033813, -1439.682373, 21.703500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2630, 1174.915771, -1443.498046, 21.723800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2630, 1176.784667, -1443.498046, 21.723800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2630, 1174.915771, -1440.067871, 21.723800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2630, 1176.784667, -1440.067871, 21.723800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2628, 1178.154785, -1434.760498, 21.717500, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2628, 1178.154785, -1432.809692, 21.717500, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2629, 1178.520507, -1428.553222, 21.719999, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2629, 1178.475463, -1426.477661, 21.719999, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2629, 1175.036010, -1426.478637, 21.719999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2629, 1173.177978, -1426.502807, 21.719999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2632, 1172.427001, -1436.376586, 21.705579, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2632, 1172.427001, -1430.431030, 21.705600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2164, 1164.878906, -1424.586547, 21.723480, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2164, 1166.726806, -1424.615356, 21.723480, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1169.788452, -1424.611450, 21.727920, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1170.817016, -1424.628295, 21.727920, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2167, 1171.827758, -1424.636596, 21.727920, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19893, 1166.909301, -1428.203002, 22.760200, 0.000000, 0.000000, 171.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1163.698974, -1424.962524, 22.328340, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2232, 1179.216796, -1444.223754, 22.328300, 0.000000, 0.000000, 208.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1649, 1179.832153, -1440.630249, 23.692810, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1649, 1179.823730, -1428.454467, 23.692810, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1108.575805, -1495.205444, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1114.690307, -1495.205444, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1143.568725, -1495.274780, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1150.469360, -1495.303833, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1151.145263, -1483.441528, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1144.963378, -1483.494018, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1114.356323, -1483.508300, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1360, 1107.267578, -1483.498779, 22.029300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);


	// Marina - Crusher
	CreateDynamicObject(6450,379.72656250,-1945.95312500,-1.21875000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(6188,836.31250000,-1866.75781250,-0.53906250,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(5172,2906.73437500,-1975.26562500,4.46875000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(6315,205.46093750,-1656.82031250,8.96875000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,124.90000153,-1876.00000000,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(3620,81.69999695,-1830.40002441,13.39999962,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1786.90002441,0.40000001,270.00000000,179.99987793,270.00537109, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1786.90002441,0.40000001,270.00000000,179.99993896,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1790.59997559,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1794.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1798.00000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1801.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1809.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1812.80004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1816.50000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59960938,-1820.19921875,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1823.90002441,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1790.59997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1794.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1798.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1801.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1805.40002441,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1809.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1812.80004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1816.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1820.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1823.90002441,0.40000001,270.00000000,179.99963379,270.00512695, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1786.90002441,0.40000001,270.00000000,180.00042725,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1790.59997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1794.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1798.00000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1801.69995117,0.40000001,270.00000000,179.99957275,270.00506592, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1805.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1809.09997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1812.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1816.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1820.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1823.90002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1786.90002441,0.40000001,270.00000000,179.99987793,270.00537109, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1790.59997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1794.30004883,0.40000001,270.00000000,180.00041199,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1798.00000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1801.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1805.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1809.09997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1812.80004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81933594,-1816.50000000,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1820.19995117,0.40000001,270.00000000,180.00036621,270.00585938, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1823.90002441,0.40000001,270.00000000,180.00012207,270.00561523, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1786.90002441,0.40000001,270.00000000,180.00036621,270.00585938, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1790.59997559,0.40000001,270.00000000,179.99957275,270.00506592, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1794.30004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1798.00000000,0.40000001,270.00000000,180.00042725,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55957031,-1801.69921875,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1805.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1809.09997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1812.80004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55957031,-1816.50000000,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1820.19995117,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1823.90002441,0.40000001,270.00000000,180.00042725,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.29980469,-1786.89941406,0.40000001,270.00000000,179.99450684,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1790.59997559,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1794.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1798.00000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.29980469,-1801.69921875,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.29980469,-1805.39941406,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1809.09997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1812.80004883,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1816.50000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1820.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1823.90002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1786.90002441,0.40000001,270.00000000,180.00000000,270.00555420, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199219,-1790.59960938,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1794.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1798.00000000,0.40000001,270.00000000,179.99987793,270.00540161, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1805.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199219,-1809.09960938,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1812.80004883,0.40000001,270.00000000,179.99957275,270.00506592, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1816.50000000,0.40000001,270.00000000,179.99853516,269.75402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1820.19995117,0.40000001,270.00000000,180.00042725,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1823.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1784.15002441,0.40000001,270.00000000,180.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1787.87988281,0.40000001,270.00000000,179.99957275,90.00506592, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1791.60900879,0.40000001,270.00000000,180.00000000,90.00552368, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,124.90000153,-1896.59997559,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,124.90000153,-1918.50000000,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,124.90000153,-1940.50000000,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,114.80000305,-1950.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,92.80000305,-1950.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,70.80000305,-1950.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,48.79999924,-1950.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1801.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(3623,110.40000153,-1844.00000000,4.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(3620,81.40000153,-1857.69995117,13.39999962,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1795.33996582,0.40000001,270.00000000,180.00000000,90.00552368, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02246094,-1799.07519531,0.40000001,270.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1802.81005859,0.40000001,270.00000000,180.00000000,90.00552368, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1806.54003906,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1810.27001953,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1814.00000000,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1817.72998047,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1821.16003418,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1835.00000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1838.69995117,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1842.40002441,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1853.50000000,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1860.90002441,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1853.50000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1857.19995117,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,111.33999634,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1831.30004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1835.00000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1838.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1842.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1846.09997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1849.80004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1857.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,114.08000183,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1831.30004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1838.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,116.81999969,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1842.40002441,0.40000001,270.00000000,180.00152588,269.75695801, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1846.09997559,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1849.80004883,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1853.50000000,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1857.19995117,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1860.90002441,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.55999756,-1864.59997559,0.40000001,270.00000000,180.00000000,269.75280762, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1827.59997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1835.00000000,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1846.09997559,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1849.80004883,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1853.50000000,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.29980469,-1857.19921875,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.30000305,-1860.90002441,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,122.29980469,-1864.59960938,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1831.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1838.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1842.40002441,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1846.09997559,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.04199982,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1824.90002441,0.40000001,270.00000000,180.00000000,90.00552368, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1828.59997559,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1832.30004883,0.40000001,270.00000000,180.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1836.00000000,0.40000001,270.00000000,179.99450684,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02246094,-1839.69921875,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1843.40002441,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1847.09997559,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02246094,-1850.79980469,0.40000001,270.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1854.50000000,0.40000001,270.00000000,180.00000000,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02300262,-1858.19995117,0.40000001,270.00000000,180.00000000,90.00552368, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,125.02246094,-1861.89941406,0.40000001,270.00000000,179.99853516,90.00949097, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1864.59997559,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.86914062,-1827.59960938,0.40000001,270.00000000,180.00000000,270.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1831.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1835.00000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1838.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1849.80004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1857.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1860.90002441,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.87000275,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1827.59997559,0.40000001,270.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1835.00000000,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1838.69995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1857.19995117,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1860.90002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1827.59997559,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1831.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1835.00000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1842.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,100.38999939,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,103.12999725,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1827.59997559,0.40000001,270.00000000,180.00041199,270.00592041, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1827.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1827.59997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1827.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,96.80000305,-1845.00000000,-2.40000010,0.00549316,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1831.30004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1842.40002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1849.80004883,0.40000001,270.00000000,179.99853516,270.00399780, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1857.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1860.90002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1831.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1835.00000000,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.92968750,-1838.69921875,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1853.50000000,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1860.90002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,94.93000031,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1831.30004883,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1835.00000000,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1838.69995117,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1842.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1846.09997559,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1849.80004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18199921,-1853.50000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1857.19995117,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,92.18000031,-1864.59997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1831.30004883,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1835.00000000,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1838.69995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1842.40002441,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1849.80004883,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1853.50000000,0.40000001,270.00000000,179.99853516,270.00402832, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1857.19995117,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1860.90002441,0.40000001,270.00000000,180.00152588,270.00701904, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,89.44000244,-1864.59997559,0.40000001,270.00000000,180.00149536,270.00698853, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,125.59999847,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1785.69995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,141.09960938,-1788.50000000,2.20000005,0.00000000,0.00000000,34.24987793, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,140.29980469,-1789.00000000,2.00000000,0.00000000,0.00000000,31.74499512, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,139.29980469,-1789.59960938,1.79999995,0.00000000,0.00000000,29.24560547, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,138.19921875,-1790.00000000,1.50000000,0.00000000,0.00000000,23.49426270, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,137.19921875,-1790.19921875,1.29999995,0.00000000,0.00000000,14.73266602, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,135.50000000,-1790.39941406,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,134.39999390,-1790.50000000,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,133.29980469,-1790.39941406,0.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,132.19921875,-1790.39941406,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,131.00000000,-1790.40002441,0.20000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,129.89999390,-1790.40002441,0.20000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,128.60000610,-1790.40002441,0.20000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,127.30000305,-1790.40002441,0.20000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,128.30000305,-1788.90002441,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,129.50000000,-1788.90002441,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,130.60000610,-1788.90002441,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,131.80000305,-1788.90002441,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,132.89999390,-1788.90002441,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,134.00000000,-1789.00000000,0.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,135.00000000,-1788.89941406,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,136.19999695,-1789.00000000,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,137.09960938,-1788.69921875,1.20000005,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,138.10000610,-1788.50000000,1.39999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,139.10000610,-1788.09997559,1.60000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,139.89999390,-1787.59997559,1.79999995,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,140.50000000,-1787.09997559,1.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,128.19999695,-1791.80004883,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,129.39999390,-1791.80004883,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,130.60000610,-1791.80004883,0.20000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,131.69999695,-1791.80004883,-0.10000000,0.00000000,0.00000000,0.0000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,132.89999390,-1791.80004883,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,133.80000305,-1791.80004883,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,134.89999390,-1791.59997559,0.60000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,136.10000610,-1791.80004883,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,137.19999695,-1791.59997559,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,138.30000305,-1791.40002441,1.29999995,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,139.30000305,-1791.00000000,1.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,140.39999390,-1790.50000000,1.70000005,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,141.30000305,-1789.90002441,1.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,142.00000000,-1789.40002441,2.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,122.19999695,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,118.09999847,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,114.00000000,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,110.90000153,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,108.00000000,-1783.69995117,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,127.50000000,-1788.30004883,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1789.90002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1794.00000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1798.09997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1802.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1806.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1810.40002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1814.50000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1818.59997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1822.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,94.90000153,-1784.69995117,0.20000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,72.90000153,-1784.69995117,0.20000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,50.90000153,-1784.69995117,0.20000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,29.10000038,-1784.69995117,0.20000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,7.09999990,-1784.69995117,0.20000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,-3.00000000,-1794.79980469,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,-2.90000010,-1816.40002441,0.30000001,0.00000000,0.00000000,180.24169922, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,-2.79999995,-1838.40002441,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,-2.79999995,-1860.40002441,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,-2.79999995,-1882.40002441,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,7.30000019,-1892.50000000,0.40000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,29.29999924,-1892.50000000,0.40000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,8.89999962,-1870.09997559,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,30.89999962,-1870.09997559,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,9.10000038,-1849.59997559,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,9.00000000,-1827.40002441,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,8.89999962,-1806.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,31.10000038,-1849.59997559,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,31.00000000,-1827.40002441,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,30.89999962,-1806.50000000,0.30000001,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,87.50000000,-1796.50000000,0.10000000,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,87.50000000,-1818.30004883,0.10000000,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,38.59999847,-1940.30004883,0.40000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,60.20000076,-1938.59997559,0.40000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,81.50000000,-1938.59997559,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,103.59999847,-1938.59997559,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,103.59999847,-1916.59997559,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(11495,81.50000000,-1916.59997559,0.30000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,103.79980469,-1824.39941406,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,99.69999695,-1824.40002441,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,95.59999847,-1824.40002441,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,91.50000000,-1824.40002441,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69921875,-1826.59960938,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1830.69995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1834.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1838.90002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1843.00000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1847.09997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1851.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1855.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1859.40002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,86.69999695,-1863.00000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,88.80000305,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,92.90000153,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,97.00000000,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,101.09999847,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.19999695,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,109.30000305,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,113.40000153,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,117.59999847,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,121.80000305,-1865.09997559,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,126.69999695,-1864.80004883,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1863.00000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1858.90002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1854.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1850.69995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1846.59997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1842.50000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1838.40002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1834.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1830.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1826.09997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1822.00000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1817.90002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1813.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1809.69995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1805.59997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1801.50000000,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1797.40002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,127.69999695,-1795.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,127.59999847,-1792.59997559,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(970,105.90000153,-1787.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,126.80000305,-1784.30004883,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1286,126.90000153,-1824.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1287,126.90000153,-1825.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1289,126.90000153,-1825.59997559,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,127.00000000,-1817.50000000,0.89999998,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1340,109.80000305,-1811.40002441,1.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1341,109.40000153,-1798.69995117,1.39999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1342,109.80000305,-1820.50000000,1.39999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1346,106.80000305,-1789.80004883,1.70000005,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2600,121.00000000,-1864.40002441,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2600,110.30000305,-1864.50000000,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2600,100.40000153,-1864.50000000,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.09999847,-1799.00000000,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,106.59999847,-1786.50000000,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,106.80000305,-1806.59997559,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,106.50000000,-1824.09997559,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,127.09999847,-1806.69995117,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,127.09999847,-1828.40002441,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1232,127.30000305,-1850.30004883,3.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.09999847,-1813.30004883,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.09999847,-1821.69995117,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.09999847,-1836.40002441,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.09999847,-1846.50000000,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,127.00000000,-1859.00000000,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1341,123.90000153,-1820.30004883,1.20000005,0.00000000,0.00000000,180.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1346,106.69999695,-1816.09997559,1.70000005,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1346,127.00000000,-1831.80004883,1.70000005,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,127.09999847,-1795.40002441,0.89999998,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,127.09999847,-1841.50000000,0.89999998,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,127.00000000,-1862.50000000,0.89999998,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,106.59999847,-1804.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.59999847,-1805.40002441,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,106.80000305,-1794.19995117,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,106.69999695,-1810.59997559,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,106.80000305,-1801.09997559,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,106.50000000,-1821.50000000,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,111.69999695,-1784.50000000,0.80000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,123.50000000,-1784.59997559,0.80000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1342,123.40000153,-1808.59997559,1.39999998,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1340,123.50000000,-1798.40002441,1.50000000,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1340,115.59999847,-1787.09997559,1.50000000,0.00000000,0.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1340,120.00000000,-1852.40002441,1.50000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1342,119.59999847,-1836.19995117,1.39999998,0.00000000,0.00000000,358.99475098, -1, -1, -1, 100.0); //
	CreateDynamicObject(1346,119.80000305,-1784.59997559,1.70000005,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.59999847,-1799.59997559,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.59999847,-1802.19995117,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.69999695,-1804.80004883,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.59999847,-1812.50000000,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.59999847,-1815.09997559,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.69999695,-1817.69995117,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1817.69995117,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1815.09997559,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1812.50000000,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1804.80004883,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1802.19995117,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(638,116.00000000,-1799.59997559,1.10000002,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(644,118.90000153,-1832.80004883,0.60000002,0.00000000,0.00000000,56.49719238, -1, -1, -1, 100.0); //
	CreateDynamicObject(646,126.40000153,-1785.50000000,1.60000002,0.00000000,0.00000000,191.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(646,103.40000153,-1829.80004883,1.60000002,0.00000000,0.00000000,120.50003052, -1, -1, -1, 100.0); //
	CreateDynamicObject(646,106.19999695,-1864.30004883,1.70000005,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,106.00000000,-1858.69995117,0.80000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,114.09999847,-1858.80004883,0.80000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1291,110.19999695,-1858.80004883,0.89999998,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1287,127.09999847,-1853.90002441,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1287,127.09999847,-1854.30004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1286,127.00000000,-1802.80004883,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1289,127.00000000,-1803.19995117,0.89999998,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2001,118.50000000,-1849.19995117,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,118.80000305,-1846.30004883,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,118.80000305,-1841.40002441,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2010,127.00000000,-1839.30004883,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2010,118.59999847,-1856.40002441,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2011,127.19999695,-1856.00000000,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2011,115.69999695,-1864.40002441,0.30000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2811,106.69999695,-1813.50000000,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2811,127.09999847,-1809.40002441,0.40000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2935,89.69999695,-1846.59997559,1.79999995,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2934,89.69999695,-1843.80004883,4.69999981,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2932,89.69999695,-1839.50000000,1.79999995,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(18257,102.09999847,-1848.19995117,0.40000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.66000366,-1846.09997559,0.40000001,270.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(3572,92.69999695,-1842.80004883,1.70000005,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(3577,93.09999847,-1849.30004883,1.10000002,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2911,102.90000153,-1839.85998535,0.40000001,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(10575,110.4575000, -1830.0486000, 2.1000000,0.00000000,0.00000000,90.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,128.60000610,-1790.30004883,0.00000000,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,129.89999390,-1790.30004883,0.00000000,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,131.00000000,-1790.30004883,0.00000000,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,132.19999695,-1790.30004883,0.10000000,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,133.30000305,-1790.30004883,0.30000001,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,135.50000000,-1790.30004883,0.89999998,179.99450684,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,136.39941406,-1790.39941406,1.10000002,0.00000000,0.00000000,3.72985840, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,138.10000610,-1789.90002441,1.29999995,179.99450684,0.00000000,23.49426270, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,139.19999695,-1789.50000000,1.60000002,180.00000000,0.00000000,29.24560547, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,140.30000305,-1789.00000000,1.79999995,180.00000000,0.00000000,31.74499512, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,141.10000610,-1788.50000000,2.00000000,180.00000000,0.00000000,34.24987793, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,118.00000000,-1802.09997559,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,114.69999695,-1802.19995117,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,114.80000305,-1815.09997559,0.80000001,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1280,118.00000000,-1815.09997559,0.80000001,0.00000000,0.00000000,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(1214,88.80000305,-1824.50000000,0.10000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1861.80004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1858.19995117,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.79980469,-1854.50000000,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1850.80004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1847.09997559,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1843.40002441,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1839.69995117,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1836.00000000,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1832.30004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1828.59997559,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1824.90002441,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1821.19995117,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1817.59997559,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1813.80004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1810.09997559,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1806.40002441,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1802.69995117,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1799.00000000,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1795.30004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1791.59997559,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1787.90002441,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.80000305,-1784.30004883,0.30000001,0.00000000,179.99450684,90.00549316, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,127.30000305,-1790.40002441,0.00000000,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,133.80000305,-1790.40002441,0.69999999,0.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,133.80000305,-1790.40002441,0.50000000,180.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,134.39999390,-1790.50000000,0.69999999,180.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,136.39999390,-1790.40002441,0.89999998,180.00000000,0.00000000,3.72985840, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,137.19999695,-1790.19995117,1.20000005,180.00000000,0.00000000,14.73266602, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,124.50000000,-1783.69995117,0.30000001,0.00000000,180.00000000,180.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,120.80000305,-1783.69995117,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,117.09999847,-1783.69995117,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,113.40000153,-1783.69995117,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,109.69999695,-1783.69995117,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,106.40000153,-1783.69995117,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1787.00000000,0.30000001,0.00000000,180.00000000,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1790.69995117,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1794.40002441,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1798.09997559,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1801.80004883,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1805.50000000,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1809.19995117,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1812.90002441,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1816.59997559,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1820.30004883,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,105.80000305,-1824.00000000,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,102.59999847,-1824.40002441,0.30000001,0.00000000,180.00000000,180.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,98.90000153,-1824.40002441,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,95.19999695,-1824.40002441,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,91.50000000,-1824.40002441,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,87.80000305,-1824.40002441,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,87.19999695,-1824.40002441,0.30000001,0.00000000,179.99450684,179.99450684, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1827.69995117,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1831.40002441,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1835.09997559,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1838.80004883,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1842.50000000,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1846.19995117,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1849.80004883,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1853.50000000,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1857.19995117,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1860.90002441,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,86.69999695,-1864.59997559,0.30000001,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,90.00000000,-1865.09997559,0.30000001,0.00000000,180.00000000,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,93.69999695,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,97.40000153,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,101.09999847,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,104.80000305,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,108.50000000,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,112.19999695,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,115.90000153,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,119.59999847,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,123.30000305,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.00000000,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(2395,127.19999695,-1865.09997559,0.30000001,0.00000000,179.99450684,0.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,117.69999695,-1845.00000000,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,113.69999695,-1845.09997559,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,96.69999695,-1844.59997559,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,117.69999695,-1803.80004883,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,115.90000153,-1803.80004883,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,115.90000153,-1806.30004883,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(8661,117.69999695,-1806.09997559,-2.40000010,0.00000000,179.99450684,270.00000000, -1, -1, -1, 100.0); //
	CreateDynamicObject(1698,127.29980469,-1790.39941406,0.00000000,180.00000000,0.00000000,0.00000000, -1, -1, -1, 100.0); //

//Vidjet cemo treba li deleteat
/*
	// Ulica - Risbo
	CreateDynamicObject(984,1306.8000000,-1823.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (4)
	CreateDynamicObject(984,1306.8000000,-1836.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (5)
	CreateDynamicObject(984,1306.8000000,-1810.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (6)
	CreateDynamicObject(984,1306.8000000,-1797.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (7)
	CreateDynamicObject(984,1306.8000000,-1784.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (8)
	CreateDynamicObject(984,1306.8000000,-1772.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (9)
	CreateDynamicObject(984,1306.8000000,-1759.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (10)
	CreateDynamicObject(984,1306.8000000,-1746.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (11)
	CreateDynamicObject(984,1306.8000000,-1733.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (12)
	CreateDynamicObject(984,1306.8000000,-1720.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (13)
	CreateDynamicObject(984,1306.8000000,-1708.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (14)
	CreateDynamicObject(984,1306.8000000,-1695.3000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (15)
	CreateDynamicObject(984,1306.8000000,-1682.5000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (16)
	CreateDynamicObject(984,1306.8000000,-1669.7000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (17)
	CreateDynamicObject(984,1306.8000000,-1656.9000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (18)
	CreateDynamicObject(984,1306.8000000,-1644.1000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (19)
	CreateDynamicObject(984,1306.8000000,-1631.3000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (20)
	CreateDynamicObject(984,1306.8000000,-1618.5000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (21)
	CreateDynamicObject(984,1306.8000000,-1605.7000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (22)
	CreateDynamicObject(984,1306.8000000,-1592.9000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (23)
	CreateDynamicObject(984,1306.8000000,-1580.1000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (24)
	CreateDynamicObject(984,1307.7000000,-1554.6000000,13.2000000,0.0000000,0.0000000,352.0000000); //object(fenceshit2) (25)
	CreateDynamicObject(984,1306.7998000,-1567.2998000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (27)
	CreateDynamicObject(984,1315.5000000,-1525.5000000,13.2000000,0.0000000,0.0000000,338.4960000); //object(fenceshit2) (28)
	CreateDynamicObject(984,1308.7998000,-1546.7002000,13.2000000,0.0000000,0.0000000,351.9960000); //object(fenceshit2) (29)
	CreateDynamicObject(984,1312.0000000,-1534.4004000,13.2000000,0.0000000,0.0000000,338.4940000); //object(fenceshit2) (30)
	CreateDynamicObject(984,1321.4000000,-1514.2000000,13.2000000,0.0000000,0.0000000,325.9940000); //object(fenceshit2) (31)
	CreateDynamicObject(984,1344.4000000,-1470.7000000,13.2000000,0.0000000,0.0000000,346.9920000); //object(fenceshit2) (32)
	CreateDynamicObject(984,1328.5000000,-1503.5996000,13.2000000,0.0000000,0.0000000,325.9920000); //object(fenceshit2) (33)
	CreateDynamicObject(984,1335.0000000,-1492.5996000,13.2000000,0.0000000,0.0000000,332.9900000); //object(fenceshit2) (34)
	CreateDynamicObject(984,1340.0996000,-1482.5996000,13.2000000,0.0000000,0.0000000,332.9900000); //object(fenceshit2) (35)
	CreateDynamicObject(984,1347.3000000,-1458.2000000,13.2000000,0.0000000,0.0000000,346.9870000); //object(fenceshit2) (36)
	CreateDynamicObject(984,1348.4000000,-1453.5000000,13.2000000,0.0000000,0.0000000,346.9870000); //object(fenceshit2) (37)
	CreateDynamicObject(984,1351.1899000,-1428.1000000,13.2000000,0.0000000,0.0000000,355.9870000); //object(fenceshit2) (38)
	CreateDynamicObject(984,1350.2998000,-1440.9004000,13.2000000,0.0000000,0.0000000,355.9850000); //object(fenceshit2) (39)
	CreateDynamicObject(984,1351.5280000,-1423.3000000,13.2000000,0.0000000,0.0000000,355.9850000); //object(fenceshit2) (40)
	CreateDynamicObject(8991,1305.9000000,-1832.3000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (1)
	CreateDynamicObject(8991,1304.3000000,-1832.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (2)
	CreateDynamicObject(8991,1304.0000000,-1818.2000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (3)
	CreateDynamicObject(8991,1305.7000000,-1818.2000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (4)
	CreateDynamicObject(8991,1305.6000000,-1804.2000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (8)
	CreateDynamicObject(8991,1304.0000000,-1804.1000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (5)
	CreateDynamicObject(8991,1304.1000000,-1790.5000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (6)
	CreateDynamicObject(8991,1305.8000000,-1790.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (7)
	CreateDynamicObject(8991,1305.7000000,-1776.0000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (9)
	CreateDynamicObject(8991,1304.1000000,-1776.0000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (10)
	CreateDynamicObject(8991,1304.0000000,-1761.9000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (11)
	CreateDynamicObject(8991,1305.9000000,-1762.2000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (12)
	CreateDynamicObject(8991,1305.8000000,-1747.8000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (13)
	CreateDynamicObject(8991,1304.2000000,-1747.8000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (14)
	CreateDynamicObject(8991,1304.1000000,-1734.5000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (15)
	CreateDynamicObject(8991,1305.7000000,-1734.0000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (16)
	CreateDynamicObject(8991,1305.6000000,-1719.9000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (17)
	CreateDynamicObject(8991,1304.0000000,-1720.2000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (18)
	CreateDynamicObject(8991,1305.6000000,-1705.7000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (19)
	CreateDynamicObject(8991,1304.2000000,-1706.0000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (20)
	CreateDynamicObject(8991,1305.6000000,-1691.3000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (21)
	CreateDynamicObject(8991,1304.0000000,-1691.7000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (22)
	CreateDynamicObject(8991,1304.1000000,-1677.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (23)
	CreateDynamicObject(8991,1305.6000000,-1677.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (24)
	CreateDynamicObject(8991,1305.8000000,-1663.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (25)
	CreateDynamicObject(8991,1304.0000000,-1663.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (26)
	CreateDynamicObject(8991,1304.0000000,-1650.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (27)
	CreateDynamicObject(8991,1305.6000000,-1650.3000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (28)
	CreateDynamicObject(8991,1305.7000000,-1635.8000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (29)
	CreateDynamicObject(8991,1304.2000000,-1635.8000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (30)
	CreateDynamicObject(8991,1304.3000000,-1622.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (31)
	CreateDynamicObject(8991,1305.8000000,-1622.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (32)
	CreateDynamicObject(8991,1305.9000000,-1608.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (33)
	CreateDynamicObject(8991,1304.0000000,-1608.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (34)
	CreateDynamicObject(8991,1303.9000000,-1594.3000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (35)
	CreateDynamicObject(8991,1305.6000000,-1594.3000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (36)
	CreateDynamicObject(8991,1305.7000000,-1580.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (37)
	CreateDynamicObject(8991,1304.1000000,-1580.6000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (38)
	CreateDynamicObject(8991,1304.2000000,-1568.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (39)
	CreateDynamicObject(8991,1305.8000000,-1568.4000000,13.1000000,0.0000000,0.0000000,90.0000000); //object(bush12_lvs) (40)
	CreateDynamicObject(8991,1306.5000000,-1554.8000000,13.1000000,0.0000000,0.0000000,82.0000000); //object(bush12_lvs) (41)
	CreateDynamicObject(8991,1305.2000000,-1554.5000000,13.1000000,0.0000000,0.0000000,81.9960000); //object(bush12_lvs) (42)
	CreateDynamicObject(8991,1308.1000000,-1545.2000000,13.1000000,0.0000000,0.0000000,81.9960000); //object(bush12_lvs) (43)
	CreateDynamicObject(8991,1306.7000000,-1545.3000000,13.1000000,0.0000000,0.0000000,81.9960000); //object(bush12_lvs) (44)
	CreateDynamicObject(8991,1310.1000000,-1532.7000000,13.1000000,0.0000000,0.0000000,69.2460000); //object(bush12_lvs) (45)
	CreateDynamicObject(8991,1311.4000000,-1533.4000000,13.1000000,0.0000000,0.0000000,69.2410000); //object(bush12_lvs) (46)
	CreateDynamicObject(8991,1314.7000000,-1525.3000000,13.1000000,0.0000000,0.0000000,69.2410000); //object(bush12_lvs) (47)
	CreateDynamicObject(8991,1313.3000000,-1524.5000000,13.1000000,0.0000000,0.0000000,69.2410000); //object(bush12_lvs) (48)
	CreateDynamicObject(8991,1319.1000000,-1513.3000000,13.1000000,0.0000000,0.0000000,55.9910000); //object(bush12_lvs) (49)
	CreateDynamicObject(8991,1320.7000000,-1514.0000000,13.1000000,0.0000000,0.0000000,55.9860000); //object(bush12_lvs) (50)
	CreateDynamicObject(8991,1327.3000000,-1503.9000000,13.1000000,0.0000000,0.0000000,55.9860000); //object(bush12_lvs) (51)
	CreateDynamicObject(8991,1326.0000000,-1503.0000000,13.1000000,0.0000000,0.0000000,55.9860000); //object(bush12_lvs) (52)
	CreateDynamicObject(8991,1332.5000000,-1491.9000000,13.1000000,0.0000000,0.0000000,62.9860000); //object(bush12_lvs) (53)
	CreateDynamicObject(8991,1333.9000000,-1492.8000000,13.1000000,0.0000000,0.0000000,62.9850000); //object(bush12_lvs) (54)
	CreateDynamicObject(8991,1339.1000000,-1482.5000000,13.1000000,0.0000000,0.0000000,62.9850000); //object(bush12_lvs) (55)
	CreateDynamicObject(8991,1337.7000000,-1481.8000000,13.1000000,0.0000000,0.0000000,62.9850000); //object(bush12_lvs) (56)
	CreateDynamicObject(8991,1342.1000000,-1470.0000000,13.1000000,0.0000000,0.0000000,77.4850000); //object(bush12_lvs) (57)
	CreateDynamicObject(8991,1343.6000000,-1470.2000000,13.1000000,0.0000000,0.0000000,77.4810000); //object(bush12_lvs) (58)
	CreateDynamicObject(8991,1346.6000000,-1456.7000000,13.1000000,0.0000000,0.0000000,77.4810000); //object(bush12_lvs) (59)
	CreateDynamicObject(8991,1345.0000000,-1456.5000000,13.1000000,0.0000000,0.0000000,77.4810000); //object(bush12_lvs) (60)
	CreateDynamicObject(8991,1347.1000000,-1443.3000000,13.1000000,0.0000000,0.0000000,86.2310000); //object(bush12_lvs) (61)
	CreateDynamicObject(8991,1349.0000000,-1443.2000000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (62)
	CreateDynamicObject(8991,1350.0000000,-1429.3000000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (63)
	CreateDynamicObject(8991,1348.1000000,-1429.5000000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (64)
	CreateDynamicObject(8991,1348.4000000,-1423.7000000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (65)
	CreateDynamicObject(8991,1350.6000000,-1423.8000000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (66)
	CreateDynamicObject(8991,1350.5996000,-1423.7998000,13.1000000,0.0000000,0.0000000,86.2260000); //object(bush12_lvs) (67)
	CreateDynamicObject(620,1305.6000000,-1559.6000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (1)
	CreateDynamicObject(620,1309.2000000,-1538.1000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (2)
	CreateDynamicObject(620,1316.2000000,-1520.2000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (3)
	CreateDynamicObject(620,1328.6000000,-1501.7000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (4)
	CreateDynamicObject(620,1341.1000000,-1478.3000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (5)
	CreateDynamicObject(620,1348.1000000,-1449.3000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (6)
	CreateDynamicObject(620,1350.3000000,-1419.3000000,12.5000000,0.0000000,0.0000000,329.9960000); //object(veg_palm04) (7)
	CreateDynamicObject(984,1347.9000000,-1423.3000000,13.2000000,0.0000000,0.0000000,355.9850000); //object(fenceshit2) (41)
	CreateDynamicObject(984,1347.5590000,-1428.1000000,13.2000000,0.0000000,0.0000000,355.9850000); //object(fenceshit2) (42)
	CreateDynamicObject(984,1346.6000000,-1440.9000000,13.2000000,0.0000000,0.0000000,355.9850000); //object(fenceshit2) (43)
	CreateDynamicObject(984,1344.7000000,-1453.5000000,13.2000000,0.0000000,0.0000000,346.9870000); //object(fenceshit2) (44)
	CreateDynamicObject(984,1343.6100000,-1458.2000000,13.2000000,0.0000000,0.0000000,346.9870000); //object(fenceshit2) (45)
	CreateDynamicObject(984,1340.7000000,-1470.7000000,13.2000000,0.0000000,0.0000000,346.9870000); //object(fenceshit2) (46)
	CreateDynamicObject(984,1336.3000000,-1482.6000000,13.2000000,0.0000000,0.0000000,332.9900000); //object(fenceshit2) (47)
	CreateDynamicObject(984,1331.9000000,-1491.1000000,13.2000000,0.0000000,0.0000000,332.9900000); //object(fenceshit2) (48)
	CreateDynamicObject(984,1325.4000000,-1502.1000000,13.2000000,0.0000000,0.0000000,325.9920000); //object(fenceshit2) (49)
	CreateDynamicObject(984,1318.3000000,-1512.7000000,13.2000000,0.0000000,0.0000000,325.9920000); //object(fenceshit2) (50)
	CreateDynamicObject(984,1312.3000000,-1524.0000000,13.2000000,0.0000000,0.0000000,338.4940000); //object(fenceshit2) (51)
	CreateDynamicObject(984,1308.8000000,-1532.9000000,13.2000000,0.0000000,0.0000000,338.4940000); //object(fenceshit2) (52)
	CreateDynamicObject(984,1305.5000000,-1545.2000000,13.2000000,0.0000000,0.0000000,351.9960000); //object(fenceshit2) (53)
	CreateDynamicObject(984,1303.9000000,-1556.3000000,13.2000000,0.0000000,0.0000000,351.9960000); //object(fenceshit2) (54)
	CreateDynamicObject(984,1303.0000000,-1569.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (55)
	CreateDynamicObject(984,1303.0000000,-1581.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (56)
	CreateDynamicObject(984,1303.0000000,-1594.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (57)
	CreateDynamicObject(984,1303.0000000,-1607.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (58)
	CreateDynamicObject(984,1303.0000000,-1620.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (59)
	CreateDynamicObject(984,1303.0000000,-1633.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (60)
	CreateDynamicObject(984,1303.0000000,-1645.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (61)
	CreateDynamicObject(984,1303.0000000,-1658.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (62)
	CreateDynamicObject(984,1303.0000000,-1671.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (63)
	CreateDynamicObject(984,1303.0000000,-1684.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (64)
	CreateDynamicObject(984,1303.0000000,-1697.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (65)
	CreateDynamicObject(984,1303.0000000,-1709.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (66)
	CreateDynamicObject(984,1303.0000000,-1722.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (67)
	CreateDynamicObject(984,1303.0000000,-1735.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (68)
	CreateDynamicObject(984,1303.0000000,-1748.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (69)
	CreateDynamicObject(984,1303.0000000,-1761.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (70)
	CreateDynamicObject(984,1303.0000000,-1773.8000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (71)
	CreateDynamicObject(984,1303.0000000,-1786.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (72)
	CreateDynamicObject(984,1303.0000000,-1799.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (73)
	CreateDynamicObject(984,1303.0000000,-1812.2000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (74)
	CreateDynamicObject(984,1303.0000000,-1825.0000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (75)
	CreateDynamicObject(984,1303.0000000,-1834.6000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(fenceshit2) (76)
	CreateDynamicObject(803,1304.6000000,-1842.7000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(genveg_bush09) (1)
	CreateDynamicObject(803,1350.1000000,-1417.4000000,13.2000000,0.0000000,0.0000000,0.0000000); //object(genveg_bush09) (2)
*/
	// Smokva - Mehanicarska 10.7.2018 added by Woo

	exterior_maps = CreateDynamicObject(8565, 218.510803, 185.158203, 2012.087036, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 14584, "ab_abbatoir01", "ab_concFloor", 0x00000000);
	exterior_maps = CreateDynamicObject(19456, 206.522705, 188.965698, 2016.168090, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "a51_vent1", 0x00000000);
	exterior_maps = CreateDynamicObject(19456, 219.522705, 188.965698, 2016.168090, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "a51_vent1", 0x00000000);
	exterior_maps = CreateDynamicObject(19327, 221.212554, 199.594619, 2020.482299, 0.000000, 0.000000, -0.200298, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 6864, "vgnvrock", "vrocksign1_256", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	exterior_maps = CreateDynamicObject(8565, 240.081893, 181.923004, 2012.087036, 0.000000, 90.000000, -179.900024, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sw_olddrum1", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 16640, "a51", "sw_olddrum1", 0x00000000);
	exterior_maps = CreateDynamicObject(8565, 197.209503, 185.137207, 2012.166137, 0.000000, -90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14661, "int_tatoo", "mp_tat_tats1", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14661, "int_tatoo", "mp_tat_tats1", 0x00000000);
	exterior_maps = CreateDynamicObject(8565, 219.566604, 171.577194, 2012.166137, 0.000000, -90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 16640, "a51", "sw_olddrum1", 0x00000000);
	exterior_maps = CreateDynamicObject(8565, 219.776092, 204.386901, 2012.087036, 0.000000, -90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 16640, "a51", "sw_olddrum1", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 16640, "a51", "sw_olddrum1", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 205.616500, 194.279495, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 205.616500, 196.436492, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 210.616500, 194.279495, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 210.615493, 196.436492, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 215.616500, 194.279495, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 215.613494, 196.436492, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 220.616500, 194.279495, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 220.614501, 196.436492, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 203.616500, 194.283493, 2014.710571, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 203.616500, 196.436492, 2014.710571, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 205.616500, 183.109497, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 205.616500, 181.041503, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 210.612503, 181.041503, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 210.615493, 183.109497, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 215.610504, 183.109497, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 220.605499, 183.109497, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 215.611495, 181.041503, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 220.610504, 181.041503, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 203.615997, 183.109695, 2014.710571, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 203.616500, 181.042495, 2014.710571, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(19631, 215.885406, 199.504699, 2018.285278, -90.000000, -180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 213.688095, 199.671905, 2019.254150, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 225.604507, 183.109497, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 225.608505, 181.041503, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 225.616500, 194.279495, 2016.382934, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(18762, 225.615493, 196.436492, 2016.374877, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(8565, 221.227706, 181.893905, 2027.360961, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 1, 16640, "a51", "stormdrain7", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 217.186096, 199.671905, 2019.254150, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 202.414093, 195.435104, 2019.254150, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 202.414093, 182.095092, 2019.254150, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 213.188095, 176.671905, 2019.754150, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "sl_metalwalk", 0x00000000);
	exterior_maps = CreateDynamicObject(19437, 216.669006, 176.677795, 2019.754150, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 16640, "a51", "metpat64", 0x00000000);
	exterior_maps = CreateDynamicObject(19631, 202.088439, 185.107818, 2017.041137, 90.000000, 1.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19631, 204.127395, 185.107803, 2017.041137, 90.000000, 1.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19631, 204.127395, 185.842803, 2017.041137, 90.000000, 1.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(2263, 203.558395, 185.456802, 2018.029541, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 2681, "cj_coin_op", "CJ_COINOP2", 0x00000000);
	exterior_maps = CreateDynamicObject(19631, 202.104400, 185.842803, 2017.041137, 90.000000, 1.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 18996, "mattextures", "sampblack", 0x00000000);
	exterior_maps = CreateDynamicObject(19327, 221.117843, 176.384460, 2020.482299, 0.000000, 0.000000, 179.699798, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	exterior_maps = CreateDynamicObject(19327, 209.068084, 176.427322, 2020.482299, 0.000000, 0.000000, 179.699798, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 11301, "carshow_sfse", "ws_Transfender_dirty", 0x00000000);
	exterior_maps = CreateDynamicObject(19327, 209.462875, 199.625717, 2020.482299, 0.000000, 0.000000, -0.200298, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 7650, "vgnusedcar", "shody1_256", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 1, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);
	SetDynamicObjectMaterial(exterior_maps, 2, 14803, "bdupsnew", "Bdup2_mask", 0x00000000);

	exterior_maps = CreateDynamicObject(3392, 216.361206, 189.674606, 2016.843017, 0.000000, 0.000000, -91.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19903, 210.994583, 189.822738, 2016.852050, 0.000000, 0.000000, 105.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3761, 221.348602, 189.842102, 2018.836059, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1714, 216.033706, 190.758468, 2016.829345, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3392, 204.501205, 189.674606, 2016.843017, 0.000000, 0.000000, -91.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1714, 204.533706, 190.858306, 2016.829345, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(925, 208.445404, 189.934997, 2017.805664, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(936, 203.473556, 188.273010, 2017.335693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(936, 205.365600, 188.272994, 2017.335693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1014, 203.557647, 188.517013, 2017.794311, 0.000000, 0.000000, 10.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1003, 205.046218, 188.278228, 2017.778686, 0.000000, 0.000000, 10.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1421, 208.350845, 188.341934, 2017.610717, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19903, 208.123001, 187.326705, 2016.852050, 0.000000, 0.000000, -124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(964, 210.095230, 187.514450, 2016.618164, 0.000000, 0.000000, -47.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1010, 209.974563, 187.468429, 2017.567382, 0.000000, 0.000000, 47.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2114, 210.490493, 187.328506, 2017.707153, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3496, 214.779296, 188.964096, 2016.614990, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3392, 222.864135, 188.254745, 2016.843017, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1714, 222.663406, 186.917312, 2016.855346, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19899, 209.435592, 199.136703, 2016.839355, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19921, 208.617172, 198.763488, 2018.526611, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19621, 205.736801, 188.212402, 2017.902343, 0.000000, 0.000000, 47.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1650, 209.608810, 199.080657, 2018.370483, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1650, 209.320770, 177.057113, 2018.240356, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1650, 210.363067, 198.986434, 2018.370483, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19815, 213.746398, 199.619705, 2018.335449, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(941, 213.513610, 199.073974, 2017.268554, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.178298, 199.145401, 2017.745117, 0.000000, 0.000000, -40.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.500701, 199.076004, 2017.745117, 0.000000, 0.000000, -135.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.316101, 198.948196, 2017.745117, 0.000000, 0.000000, -265.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 213.732254, 199.172531, 2017.725341, 91.000000, 69.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 214.012344, 198.699981, 2017.725341, 91.000000, 69.000000, 156.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18634, 214.301498, 199.030502, 2017.743286, 0.000000, 91.000000, 18.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19631, 215.826400, 199.892700, 2018.651489, -180.000000, -180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19631, 215.945404, 199.892700, 2018.651489, -180.000000, -180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(930, 213.001495, 199.240707, 2019.807983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2231, 215.319107, 199.501495, 2019.330810, 0.000000, 0.000000, -10.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(922, 220.317794, 199.177978, 2017.528320, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(964, 217.093292, 199.306503, 2016.618164, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19893, 216.999496, 199.013504, 2017.564331, 0.000000, 0.000000, -33.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(9093, 235.301101, 182.011199, 2018.528930, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(9093, 235.301101, 194.986206, 2018.648925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2063, 205.289901, 199.217605, 2017.664306, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19899, 209.312606, 176.793701, 2016.706298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(941, 213.513595, 176.848007, 2017.268554, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19815, 213.284393, 176.348693, 2018.335449, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2181, 217.152679, 176.841522, 2016.869995, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(964, 218.561096, 177.564559, 2016.618164, 0.000000, 0.000000, -108.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19903, 224.286804, 177.008270, 2016.852050, 0.000000, 0.000000, 105.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2063, 221.366561, 176.986343, 2017.664306, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1437, 215.300994, 178.808502, 2015.338500, 26.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1428, 213.826354, 197.942977, 2016.832153, 105.000000, 0.000000, 89.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(936, 216.845596, 188.272994, 2017.335693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(936, 218.733596, 188.272994, 2017.335693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2103, 220.367095, 199.061492, 2017.572143, 0.000000, 0.000000, -32.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2872, 202.070495, 185.507095, 2017.893310, -90.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19918, 202.923095, 185.245498, 2018.171630, 0.000000, 0.000000, 89.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19918, 202.923095, 185.698501, 2018.171630, 0.000000, 0.000000, 89.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1209, 224.695632, 199.269226, 2016.812500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1776, 227.065338, 199.138351, 2017.822753, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2551, 225.068099, 188.324203, 2016.781005, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786178, 187.911148, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 187.911102, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786193, 188.043106, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 188.043106, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 188.175094, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786193, 188.175094, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 188.307098, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786193, 188.307098, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 188.439102, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786193, 188.439102, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.918197, 188.571105, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(365, 224.786193, 188.571105, 2018.452880, 0.000000, -8.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.989013, 187.957687, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.988998, 188.089706, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.988998, 188.221694, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.988998, 188.353698, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.988998, 188.485702, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2749, 224.988998, 188.617706, 2017.956909, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 187.951004, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.082992, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.214996, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.347000, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.479003, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.610992, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2752, 225.011703, 188.742996, 2017.582885, 0.000000, 0.000000, 124.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2751, 225.026275, 188.001754, 2017.297363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2751, 225.026306, 188.265792, 2017.297363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2751, 225.026306, 188.529800, 2017.297363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2694, 224.963531, 188.369750, 2016.952514, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 204.074996, 185.462203, 2017.906860, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19920, 204.074401, 185.283203, 2017.906860, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1050, 202.156402, 191.398498, 2018.454345, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1060, 201.969299, 191.406692, 2017.983154, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1139, 201.996200, 191.418197, 2017.604614, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1146, 202.124404, 191.398498, 2018.908447, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(927, 235.323104, 186.545394, 2017.846313, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(927, 235.317108, 188.188400, 2016.847045, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1893, 209.570007, 181.549804, 2022.204956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1893, 221.828002, 181.548797, 2022.204467, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1893, 221.828002, 194.638793, 2022.260498, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1893, 209.570007, 194.849792, 2022.218994, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1438, 213.345535, 176.262573, 2019.818237, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 197.545303, 2022.614379, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 192.927307, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 188.308303, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 183.689300, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 179.070297, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 209.552200, 174.452301, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 183.689300, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 188.307296, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 192.924301, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 197.541305, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 179.074295, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2960, 221.851196, 174.457305, 2022.614501, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1146, 216.918899, 188.367294, 2017.810180, 0.000000, 0.000000, 16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1050, 218.667343, 188.391082, 2017.791503, 0.000000, 0.000000, 16.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2027, 213.806503, 186.583496, 2017.420410, 0.000000, 0.000000, 25.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2027, 206.369232, 178.503326, 2017.420410, 0.000000, 0.000000, -12.819990, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1096, 217.930831, 177.204971, 2020.317260, 0.799998, 0.900050, 90.199958, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1096, 217.932403, 176.735092, 2020.324096, 0.799998, 0.900050, 90.199958, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1083, 216.928298, 177.252471, 2020.326171, 0.000000, 0.000000, 90.099922, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1083, 216.929016, 176.782684, 2020.326171, 0.000000, 0.000000, 90.099922, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1084, 215.884460, 177.247283, 2020.296997, 0.000000, 0.000000, 89.399917, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1084, 215.879653, 176.797424, 2020.296997, 0.000000, 0.000000, 89.399917, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1081, 218.424667, 176.533706, 2018.200805, 0.000000, 0.699999, -89.899925, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1097, 202.313949, 180.785614, 2019.822875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1097, 202.813751, 180.785614, 2019.822875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1098, 202.761795, 181.896026, 2019.814819, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1098, 202.302001, 181.896026, 2019.814819, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1025, 202.710205, 183.037155, 2019.817626, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1025, 202.260421, 183.037155, 2019.817626, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1085, 202.346145, 194.225677, 2019.828735, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1085, 202.895965, 194.225677, 2019.828735, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1082, 202.910934, 195.301651, 2019.823242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1082, 202.391189, 195.301651, 2019.823242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1080, 202.354309, 196.394927, 2019.798339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1080, 202.904113, 196.394927, 2019.798339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1079, 214.113555, 199.565017, 2019.822753, 0.000000, 0.000000, -90.299812, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1079, 214.141143, 199.065048, 2019.822753, 0.000000, 0.000000, -90.299812, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1078, 215.946136, 199.454467, 2019.834594, 0.000000, 0.000000, -90.500198, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1078, 215.942749, 199.074584, 2019.834594, 0.000000, 0.000000, -90.500198, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1077, 217.027603, 199.384017, 2019.807128, 0.000000, 0.000000, -90.499984, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1077, 217.004425, 199.034317, 2019.807128, 0.000000, 0.000000, -90.499984, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1076, 218.051727, 199.029067, 2019.838745, 0.000000, 0.000000, -90.299995, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1076, 218.053512, 199.379013, 2019.838745, 0.000000, 0.000000, -90.299995, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.949996, 176.835494, 2017.744262, 0.000000, 0.000000, -36.099998, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.877380, 177.024581, 2017.744262, 0.000000, 0.000000, -36.099998, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19627, 213.730133, 176.822494, 2017.744262, 0.000000, 0.000000, -84.899986, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 213.312438, 177.003814, 2017.708862, 88.599998, 0.000000, -17.399999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18635, 213.026184, 177.093536, 2017.708862, 88.599998, 0.000000, 31.899997, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18644, 213.556503, 177.049484, 2017.754882, -93.700012, 0.000000, -28.600006, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18634, 212.472564, 176.746215, 2017.755859, 0.000000, 91.000000, -104.299987, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(19921, 210.119232, 177.124450, 2018.426513, 0.000000, 0.000000, -179.200149, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1650, 209.151870, 176.799377, 2018.240356, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1650, 208.903396, 176.832550, 2018.240356, 0.000000, 0.000000, -69.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3633, 229.863403, 198.863830, 2017.323852, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3633, 229.733444, 198.863830, 2018.274780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3046, 231.206497, 198.719543, 2017.203735, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3046, 232.336349, 198.719543, 2017.203735, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3046, 231.666030, 198.792892, 2017.774291, 0.000000, 0.000000, -60.899997, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(942, 229.579406, 177.392562, 2019.293212, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	// SMB exterior bina na plazi Cruella

	// Lovacka kuca - Smokva
    exterior_maps = CreateDynamicObject(19356, 704.390991, -308.704498, 9.316499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.843811, -315.120300, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.393005, -318.330505, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 705.914916, -319.216796, 9.316499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19402, 712.319580, -319.216186, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.843017, -318.330505, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.390502, -311.916687, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.843627, -305.489990, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19466, 713.878417, -302.089813, 9.488499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19386, 709.120300, -300.591308, 9.315299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(11724, 704.920288, -311.181610, 8.089400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
    exterior_maps = CreateDynamicObject(19402, 705.907714, -300.591888, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19466, 705.893798, -300.571960, 9.488499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 709.143798, -305.166412, 12.138999, -12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 709.143798, -314.612396, 12.151000, 12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 704.457214, -306.585510, 7.013599, -12.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 704.457580, -313.727111, 6.881599, 12.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 713.837829, -306.287445, 7.013569, -12.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.843627, -302.279998, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.390991, -305.493499, 9.316499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.390991, -302.279510, 9.316499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.384521, -315.118713, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.818176, -317.546508, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.818176, -314.338500, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.818176, -311.130493, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.818176, -307.922485, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.818176, -304.712493, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 713.815002, -302.143096, 9.318499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -318.330505, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -315.119506, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -311.909484, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -308.697509, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -305.490509, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 704.552978, -302.280487, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 709.124877, -319.216796, 9.316499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19402, 712.319580, -315.930206, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19386, 709.113220, -315.929107, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19364, 712.179016, -317.521301, 7.486700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0x00000000);
    exterior_maps = CreateDynamicObject(19364, 708.681030, -317.521301, 7.486700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 14709, "lamidint2", "mp_apt1_bathfloor1", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 706.905029, -317.537506, 9.314499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 705.902893, -315.928802, 9.316499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19402, 712.331726, -300.589904, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3241, "conhooses", "des_woodfence1", 0x00000000);
    exterior_maps = CreateDynamicObject(19466, 712.319824, -300.571990, 9.488499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    exterior_maps = CreateDynamicObject(16151, 712.675415, -305.004333, 7.901869, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 3, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 5, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 6, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 7, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 8, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 713.828979, -313.429901, 6.941579, 12.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 709.143798, -305.166412, 12.325269, -12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6404, "beafron1_law2", "woodroof01_128", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 709.143798, -314.612396, 12.326959, 12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6404, "beafron1_law2", "woodroof01_128", 0x00000000);
    exterior_maps = CreateDynamicObject(2762, 710.896301, -311.417114, 7.965600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3374, "ce_farmxref", "sw_barnfloor1", 0x00000000);
    exterior_maps = CreateDynamicObject(19402, 712.319580, -319.040191, 9.317299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 709.124877, -319.039794, 9.316499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19356, 705.914916, -319.039794, 9.316499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 719.641784, -305.166412, 12.138999, -12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 719.643798, -305.166412, 12.325300, -12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6404, "beafron1_law2", "woodroof01_128", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 719.641784, -314.612396, 12.151000, 12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(19378, 719.643798, -314.612396, 12.326999, 12.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6404, "beafron1_law2", "woodroof01_128", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.540588, -309.961700, 12.734399, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.314880, -319.057006, 11.116999, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.540588, -300.721710, 11.135089, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.314575, -309.962890, 12.734399, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.540588, -319.031707, 11.116999, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 724.343566, -300.732879, 11.135100, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 714.785827, -300.659210, 11.109100, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 714.962829, -300.659210, 11.109100, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 714.740600, -319.001708, 11.116999, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1308, 714.990112, -319.005828, 11.116999, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(2357, 719.591369, -311.397796, 8.121800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(2357, 719.589416, -311.411804, 7.331099, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(2357, 719.589416, -306.553802, 7.331099, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(2357, 719.591369, -306.539794, 8.121800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 721.538696, -311.349487, 8.290399, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 717.578674, -311.349487, 8.290399, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 717.578674, -306.333496, 8.290399, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 721.538696, -306.597503, 8.290399, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 721.538696, -306.605499, 7.254099, 0.000000, 180.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 721.538696, -311.357513, 7.254099, 0.000000, 180.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(19437, 714.535217, -310.471191, 8.546500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(19924, 714.539306, -309.759887, 11.224100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12822, "ce_bankalley3", "Metal1_128", 0x00000000);
    exterior_maps = CreateDynamicObject(19437, 714.535217, -309.042205, 8.546500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(19437, 713.853210, -309.757507, 8.546500, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(19437, 714.539306, -309.805297, 8.390199, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12822, "ce_bankalley3", "Metal1_128", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 717.359680, -306.333496, 7.254099, 0.000000, 180.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(19456, 713.847412, -309.546813, 9.318400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17545, "burnsground", "dirtyredwall512", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.626708, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.535705, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.444702, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.717712, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.808685, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.899688, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.990692, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.159423, -310.498687, 8.590900, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.341369, -310.498687, 8.590900, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.523376, -310.498687, 8.590900, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.725402, -310.498687, 8.590900, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.887390, -310.498687, 8.590900, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.914794, -310.076293, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -310.172698, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -310.263702, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.889404, -309.042694, 8.590900, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.723388, -309.042694, 8.590900, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.527404, -309.042694, 8.590900, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.345397, -309.042694, 8.590900, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 714.161376, -309.028686, 8.590900, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.348693, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(19871, 713.915527, -309.246704, 8.590900, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 1, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 3031, "wngdishx", "metal_leg", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 3, 3031, "wngdishx", "metal_leg", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 714.685363, -310.404876, 8.496199, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 714.120971, -310.385009, 8.496199, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 713.879882, -310.031494, 8.496199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 713.879882, -309.541503, 8.496199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 714.105529, -309.133300, 8.496199, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(11708, 714.666503, -309.134185, 8.496199, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    exterior_maps = CreateDynamicObject(19466, 712.195495, -319.145629, 9.488499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17588, "lae2coast_alpha", "LAShad1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -306.543334, 8.995400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.549804, -304.199310, 8.993399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -313.479309, 8.195400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.545776, -315.502288, 8.995400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.545776, -315.502288, 8.195400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.549804, -306.543304, 8.195400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -304.199310, 8.193400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -313.479309, 9.795399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.545776, -315.502288, 9.795399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -306.543304, 9.795399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.551818, -304.201293, 9.793399, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 724.547790, -313.479309, 8.995400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 718.486999, -318.955871, 8.195400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 720.947875, -318.966278, 8.195400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 718.486999, -318.955902, 8.985400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 720.947875, -318.966308, 8.985400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 718.486999, -318.955902, 9.775400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1251, 720.947875, -318.966308, 9.775400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(3403, 698.008422, -285.322814, 8.180350, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 6404, "beafron1_law2", "woodroof01_128", 0x00000000);
    exterior_maps = CreateDynamicObject(3657, 717.356994, -311.347503, 7.264100, 0.000000, 180.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 1, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    SetDynamicObjectMaterial(exterior_maps, 2, 6351, "rodeo02_law2", "woodboards1", 0x00000000);
    exterior_maps = CreateDynamicObject(1744, 713.964782, -312.804321, 9.169693, 0.000000, 0.000000, -89.999961, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
    exterior_maps = CreateDynamicObject(1744, 713.964782, -310.874114, 9.169693, 0.000000, 0.000000, -89.999961, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(exterior_maps, 0, 17005, "farmhouse", "sjmbigold2", 0x00000000);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    exterior_maps = CreateDynamicObject(19378, 709.143798, -305.496398, 7.483399, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 709.147827, -315.129394, 7.485400, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19356, 713.843383, -308.701507, 9.316499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19466, 704.366699, -315.218109, 9.488499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19466, 713.878356, -311.753845, 9.488499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 709.142395, -299.075103, 7.482100, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 705.642395, -299.075103, 7.482100, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19632, 705.024169, -311.213409, 7.576600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1736, 704.922180, -311.181701, 10.277299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1491, 709.856933, -300.591156, 7.572450, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 714.480407, -299.073089, 5.826700, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 709.143798, -319.857391, 2.648400, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 703.982788, -315.127410, 2.322299, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 703.982788, -305.493408, 2.320300, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 705.644409, -297.557098, 5.964900, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 703.983398, -299.075103, 5.814070, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 709.142395, -297.555114, 5.963860, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 712.642395, -297.555114, 5.963900, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 712.643371, -299.075103, 7.482100, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 709.139770, -318.341400, 7.483399, 180.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 714.478820, -321.552093, 5.825099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 709.140625, -323.070892, 2.757400, 270.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19366, 703.983825, -321.552093, 5.825099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19356, 713.843383, -311.910491, 9.316499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1828, 704.642517, -308.474395, 9.282830, 72.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1828, 704.642517, -308.474395, 9.437700, 72.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1828, 704.634399, -313.848846, 9.334950, -72.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(917, 705.097900, -312.446197, 7.704100, 0.000000, 0.000000, 6.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 705.118774, -312.507843, 7.587800, 0.000000, 0.000000, 8.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 705.094848, -312.369842, 7.587800, 0.000000, 0.000000, 8.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 705.068908, -312.455718, 7.686299, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2027, 705.951782, -301.588867, 8.132599, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2027, 705.463928, -305.332763, 8.132559, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1735, 705.994018, -312.934570, 7.572999, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1735, 707.271850, -312.991668, 7.572999, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1757, 708.557617, -309.882110, 7.548999, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1711, 706.001037, -309.208496, 7.573569, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2762, 710.898315, -313.505096, 7.965600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 710.599304, -310.813385, 8.166299, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 710.599304, -312.068389, 8.166299, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 710.599304, -314.240386, 8.166299, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2762, 711.964294, -313.505096, 7.965600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2762, 711.963195, -311.417510, 7.965600, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 712.273315, -310.813385, 8.166299, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 712.273315, -312.116394, 8.166299, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 712.273315, -314.255401, 8.166299, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 711.478881, -310.508544, 8.166299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 711.404113, -314.321258, 8.166299, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 712.101074, -310.817077, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 712.106445, -312.085174, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 712.101074, -314.149108, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.911071, -310.817108, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.911071, -312.104095, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.911071, -314.149108, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 710.910766, -311.028656, 8.389200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 710.921203, -310.574188, 8.383199, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 710.910827, -311.886688, 8.389200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 710.921203, -312.337188, 8.383199, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 710.921203, -313.906188, 8.383199, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 710.910827, -314.360687, 8.389200, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 710.599304, -312.876403, 8.166299, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2120, 712.273315, -312.877410, 8.166299, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.911071, -312.959106, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 712.124389, -312.859863, 8.386099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 712.085815, -311.028686, 8.389200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 712.096191, -310.574188, 8.383199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 712.085815, -312.306701, 8.389200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 712.096191, -311.863189, 8.383199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 712.085815, -313.105712, 8.389200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 712.096191, -312.615203, 8.383199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11715, 712.131103, -313.884124, 8.389200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11716, 712.096191, -314.401214, 8.383199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2683, 711.444946, -312.349395, 8.507379, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19570, 711.459289, -312.608367, 8.389369, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11722, 711.313964, -312.750305, 8.512479, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11723, 711.527832, -312.116394, 8.528900, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2001, 705.796630, -315.362854, 7.572609, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(15036, 709.240783, -317.466522, 8.542610, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14869, 713.446777, -317.949890, 8.381199, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 719.648986, -314.794891, 7.485400, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 719.645019, -305.165893, 7.483399, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 724.984985, -305.163909, 2.323800, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 724.989013, -314.796905, 2.323800, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 720.083679, -300.435699, 2.321799, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19378, 720.083679, -319.525695, 2.323800, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3657, 721.000000, 2747.000000, -311.000000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -301.702911, 7.481699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -301.437011, 7.301700, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -301.177001, 7.122499, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -300.916992, 6.943699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -300.622985, 6.766399, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 720.340209, -300.290008, 6.588600, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.736206, -300.290008, 6.588600, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.736206, -300.622985, 6.766799, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.735229, -300.916992, 6.943699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.736206, -301.177001, 7.122499, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.734191, -301.437011, 7.301700, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 718.734191, -301.702911, 7.481699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19843, 714.535827, -309.740112, 7.526400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710937, -310.060394, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.919403, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.778411, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.637390, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.496398, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.355407, 7.655000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.637390, 7.796000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.778411, 7.796000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.684387, 7.936999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19793, 714.710876, -309.496398, 7.796000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 715.352355, -319.809906, 6.823319, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 715.131469, -319.635925, 7.232100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 715.352355, -319.809906, 6.523320, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 715.399780, -321.189483, 6.523320, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 715.343383, -320.993499, 6.822279, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1271, 714.927673, -300.072998, 6.528600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1271, 714.927673, -300.072998, 7.208159, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1271, 715.629699, -300.072998, 6.734340, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 752.502990, -276.765014, 11.195799, 3.000000, 4.000000, 162.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 732.338562, -277.460784, 9.129329, 3.000000, 5.000000, 238.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 708.820922, -277.024810, 8.234600, 3.000000, -4.000000, -294.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 705.366027, -271.330291, 8.405690, 3.000000, -2.000000, -4.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 693.852111, -270.505645, 7.949910, 3.000000, -2.000000, -4.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 686.040161, -275.880096, 7.465010, 3.000000, -2.000000, 73.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 685.645874, -286.974609, 7.197679, 3.000000, -1.000000, 101.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 684.379577, -297.749786, 6.903419, 3.000000, 1.000000, 244.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(672, -35.710941, 18.101560, 2.955859, 3.141590, 0.000000, 0.125229, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 681.420227, -308.561706, 7.027180, 3.000000, -1.000000, 265.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 680.441467, -320.020904, 7.226160, 3.000000, -1.000000, 265.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 683.490844, -330.247741, 7.469979, 3.000000, -1.000000, 308.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 691.333129, -337.266510, 7.618500, 3.000000, 4.000000, 149.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 701.718017, -341.373596, 7.818999, 3.000000, 2.000000, 167.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 712.997924, -343.045013, 7.976469, 3.000000, 0.000000, 177.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 724.516601, -343.643341, 7.976469, 3.000000, 0.000000, 177.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 735.361572, -341.270385, 8.060279, 3.000000, 2.000000, 209.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 745.164001, -335.737335, 8.632189, 3.000000, 6.000000, 209.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 752.810485, -328.313690, 9.611289, 3.000000, 5.000000, 238.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 758.797790, -318.450683, 10.740599, 3.000000, 7.000000, 238.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 760.855285, -308.330993, 11.350640, 3.000000, 0.000000, 280.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 757.087951, -297.505645, 10.842889, 3.000000, -4.000000, 298.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 750.260986, -289.022613, 10.213549, 3.000000, -5.000000, 320.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 740.491333, -284.371704, 9.156100, 3.000000, 4.000000, 170.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(3276, 734.628845, -283.332641, 8.919529, 3.000000, 5.000000, 167.520034, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 672.340209, -340.662536, 13.867190, 356.858398, 0.000000, 65.541610, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 697.490234, -350.098449, 13.867190, 356.858398, 0.000000, 65.541610, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 735.643737, -356.035827, 13.867190, 356.858398, 0.000000, 65.541610, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 667.984924, -310.425292, 10.674730, 356.858398, 0.000000, 65.541610, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 766.815856, -326.522705, 13.867190, 356.858398, 0.000000, 65.541610, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -298.758514, 7.481699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -298.382507, 7.293700, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -298.100494, 7.113699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -297.818511, 6.935699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -297.560485, 6.759699, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -297.300506, 6.586500, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19439, 709.031921, -297.063507, 6.409200, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1462, 714.112548, -317.994323, 7.559700, 18.000000, 6.000000, -53.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 700.771911, -285.183959, 6.970540, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 699.112915, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 697.453918, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 695.794921, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 694.135925, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 692.476928, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 702.430908, -285.183990, 6.970499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 701.719909, -285.183990, 7.154779, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 699.981872, -285.183990, 7.164619, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 698.401916, -285.263000, 7.178359, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 696.584899, -285.105010, 7.134960, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 694.925903, -285.183990, 7.114089, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 693.266906, -285.183990, 7.123219, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 702.430908, -285.183990, 7.444499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 700.771911, -285.183990, 7.444499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 699.112915, -285.183990, 7.365499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 697.453918, -285.183990, 7.365499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 695.794921, -285.183990, 7.365499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 694.135925, -285.183990, 7.286499, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1463, 692.476928, -285.183990, 7.140679, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(13369, 739.883422, -308.618499, 8.975239, 0.000000, -3.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 727.142517, -293.938385, 7.379769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 726.615966, -295.144439, 7.244540, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 725.439147, -293.657653, 7.192999, 0.000000, 0.000000, 69.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 725.375610, -295.715942, 7.177899, 0.000000, 0.000000, -11.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 726.506713, -296.693206, 7.146269, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(14872, 723.411560, -295.338409, 7.198009, 0.000000, 0.000000, 193.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(694, 696.482788, -389.310974, 13.867190, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1458, 702.926696, -276.952697, 7.322800, 12.000000, 0.000000, 50.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1452, 694.818603, -273.594696, 8.018010, 0.000000, 0.000000, 69.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1457, 696.970275, -278.778503, 8.530699, 0.000000, 0.000000, 142.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2361, 711.253784, -316.514831, 7.566999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2804, 711.170166, -316.204864, 7.874969, 0.000000, 0.000000, -91.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2804, 711.170227, -316.502899, 7.875000, 0.000000, 0.000000, -91.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2804, 711.165466, -316.761169, 7.875000, 0.000000, 0.000000, -91.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2806, 711.924560, -316.407379, 7.969059, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2806, 711.703857, -316.413848, 7.969059, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19573, 714.716979, -308.786499, 8.464900, -7.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19364, -503.315246, -2103.714355, 96.302299, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19410, -501.667297, -2103.714843, 98.132499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(791, -501.564514, -2123.236328, 80.625000, 3.000000, 0.000000, -127.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19410, -504.975311, -2103.714843, 98.132499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19393, -503.280517, -2102.223876, 98.122291, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1437, -503.297576, -2101.175537, 91.655288, 21.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1437, -503.304321, -2100.059570, 85.924690, 21.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -501.816223, -2102.298828, 95.943077, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -505.000213, -2102.298828, 95.943099, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -504.834533, -2102.291259, 95.943099, 0.000000, 160.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -502.029327, -2102.303222, 95.943099, 0.000000, -160.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -501.748291, -2105.222167, 95.943099, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -504.926818, -2105.165527, 95.943099, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -504.838653, -2105.185546, 95.943099, 0.000000, 160.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -501.950500, -2105.204589, 95.943099, 0.000000, -160.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -501.758514, -2102.437744, 95.943099, 0.000000, -164.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -501.758239, -2104.685791, 95.943099, 0.000000, 164.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -504.896331, -2104.804931, 95.943099, 0.000000, 164.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(1308, -504.902374, -2102.417968, 95.943099, 0.000000, -164.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19364, -503.305633, -2105.218994, 97.971458, 90.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19364, -503.313873, -2103.762451, 99.774101, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2282, 713.259521, -306.903564, 9.271504, 0.000000, 0.000000, -90.000083, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2281, 713.247070, -309.479553, 9.614040, 0.000000, 0.000000, -90.099884, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19174, 704.635986, -303.405426, 9.896885, 0.000000, 0.000000, 89.999938, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2069, 704.970336, -309.596221, 7.606047, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2034, 704.665832, -311.192687, 9.541808, 119.199890, 91.300048, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2034, 704.703552, -311.118621, 9.558021, 118.199958, 86.199951, 167.700042, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19824, 713.637329, -310.749816, 9.509764, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19823, 713.593139, -311.265045, 9.500144, 0.000000, 0.000000, -90.099967, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19820, 713.592468, -311.666442, 9.473668, 0.000000, 0.000000, 101.800010, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19821, 713.547058, -312.159973, 9.483393, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19822, 713.578369, -312.601165, 9.492833, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19823, 713.590759, -313.015411, 9.500144, 0.000000, 0.000000, -90.099967, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19824, 713.637329, -313.429901, 9.509764, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19820, 713.598327, -313.841400, 9.483668, 0.000000, 0.000000, 101.800010, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2283, 707.402282, -315.824523, 9.478088, 0.000000, 0.000000, 179.899993, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2831, 709.200683, -318.507385, 8.204727, 0.000000, 0.000000, 94.499977, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(19830, 707.457824, -317.718688, 8.381400, 0.000000, 0.000000, 129.100006, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2149, 707.475769, -316.581420, 8.541488, 0.000000, 0.000000, 87.500007, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.893981, -318.919891, 9.840912, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 710.303405, -318.927093, 9.839449, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 709.763122, -318.923889, 9.840138, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 709.222473, -318.920684, 9.840826, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 708.621765, -318.918212, 9.841366, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(11744, 708.111328, -318.924438, 9.840102, -78.299957, -0.700000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2726, 707.219909, -316.460357, 10.031993, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2868, 707.197143, -317.350830, 9.694931, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2274, 713.243469, -317.814514, 9.273125, 0.000000, 0.000000, -90.200065, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2828, 704.877990, -311.213806, 8.597624, 0.000000, 0.000000, -111.699943, -1, -1, -1, 300.00, 300.00);
    exterior_maps = CreateDynamicObject(2238, 707.572692, -318.428588, 10.081885, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	// Illegal garage - WizzCycann
    CreateDynamicObject(13027, 2632.24341, -2104.02515, 15.74290,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3292, 2636.93750, -2101.82617, 12.51060,   0.00000, 0.00000, -180.00000);
    CreateDynamicObject(19435, 2634.52466, -2112.61450, 14.25800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19435, 2634.52271, -2112.61646, 16.58180,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19435, 2629.90771, -2112.61450, 14.25800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19435, 2629.90576, -2112.61646, 16.58370,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19435, 2631.67578, -2112.61450, 16.39920,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19435, 2632.76367, -2112.61255, 16.40120,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19466, 2635.57568, -2111.82666, 13.51920,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19466, 2635.57178, -2111.82666, 15.45620,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19466, 2635.57178, -2111.82666, 17.38519,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19466, 2629.01855, -2112.29175, 13.48760,   0.00000, 0.00000, 52.00000);
    CreateDynamicObject(19466, 2629.01855, -2112.29175, 15.41238,   0.00000, 0.00000, 52.00000);
    CreateDynamicObject(19466, 2629.01855, -2112.29175, 17.33844,   0.00000, 0.00000, 52.00000);
    CreateDynamicObject(19466, 2633.30786, -2111.82666, 17.38520,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19466, 2631.06787, -2111.82666, 17.38520,   0.00000, 0.00000, 90.00000);

	//######################################################## Benzinska by Smokva ######################################################3
	CreateDynamicObject(6959,1930.9851100,-1782.2578100,12.4104700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(6959,1889.6480700,-1782.2578100,12.4105000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(638,1928.5771500,-1785.1606400,13.2429000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(638,1928.5771500,-1782.4825400,13.2429000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(638,1928.5771500,-1779.8015100,13.2429000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(638,1928.5771500,-1771.7204600,13.2429000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(638,1928.5771500,-1769.0445600,13.2429000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19324,1915.7862500,-1765.8585200,13.1875000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(19447,1923.4117400,-1762.3969700,10.9515000,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(19447,1917.4572800,-1767.3035900,10.9515000,0.0000000,0.0000000,360.0000000); //
	CreateDynamicObject(19447,1928.1392800,-1767.3035900,10.9515000,0.0000000,0.0000000,360.0000000); //
	CreateDynamicObject(19381,1922.7977300,-1767.3001700,12.6118000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19428,1918.1707800,-1762.3957500,10.9519000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(870,1926.3627900,-1764.2330300,12.9342900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(870,1922.9616700,-1764.2031300,12.9342900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(870,1919.4465300,-1764.2804000,12.9342900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(8843,1944.6657700,-1772.7897900,12.3822000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(8843,1937.4558100,-1773.1877400,12.3822000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1686,1009.5314300,-936.1692500,41.3215300,0.0000000,0.0000000,-82.5000400); //
	CreateDynamicObject(1686,1005.7678200,-936.6673000,41.3215000,0.0000000,0.0000000,-82.5000000); //
	CreateDynamicObject(1686,1001.9625900,-937.2244900,41.3215000,0.0000000,0.0000000,-82.5000000); //
	CreateDynamicObject(1686,998.6539900,-937.7204000,41.3215000,0.0000000,0.0000000,-82.5000000); //
	CreateDynamicObject(9192,1013.6098600,-947.7370000,45.8384000,0.0000000,0.0000000,-28.0000000); //
	CreateDynamicObject(19791,997.3789100,-926.5401000,31.3238000,0.0000000,0.0000000,7.0000000); //
	CreateDynamicObject(970,997.6228000,-921.5141000,41.8065300,0.0000000,0.0000000,7.0000000); //
	CreateDynamicObject(970,998.9331100,-931.2916900,41.8065000,0.0000000,0.0000000,7.0000000); //
	CreateDynamicObject(970,995.1140700,-931.7607400,41.8065000,0.0000000,0.0000000,7.0000000); //
	CreateDynamicObject(970,993.9098500,-921.9815700,41.8065000,0.0000000,0.0000000,7.0000000); //
	CreateDynamicObject(970,999.9412800,-923.3115200,41.8065000,0.0000000,0.0000000,97.1800600); //
	CreateDynamicObject(970,1000.4610600,-927.4523300,41.8065000,0.0000000,0.0000000,97.1800600); //
	CreateDynamicObject(970,1000.6379400,-928.9841300,41.8065000,0.0000000,0.0000000,97.1800600); //
	CreateDynamicObject(970,992.4238900,-926.5471200,41.8065000,0.0000000,0.0000000,97.1800600); //
	CreateDynamicObject(1432,997.1701000,-924.0586500,41.4206600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1432,997.7130100,-928.7732500,41.4206600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1432,994.2860700,-926.2742900,41.4206600,0.0000000,0.0000000,0.0000000); //

	// ############################ Impound on Los Santos Airport by Smokva ######################################
	CreateDynamicObject(19355,1978.5655500,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1978.5655500,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1983.5986300,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1983.5986300,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1988.4856000,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1988.4856000,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1994.1015600,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1994.1015600,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1999.7176500,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,1999.7176500,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2004.8657200,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2004.8657200,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2010.4816900,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2010.4816900,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2016.5656700,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2016.5656700,-2182.4929200,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2033.0625000,-2182.4987800,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2033.0656700,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2038.0656700,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2038.0644500,-2182.4987800,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2043.0656700,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2048.5656700,-2179.2849100,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2043.0644500,-2182.4980500,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19355,2048.5654300,-2182.4980500,10.8008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19978,1966.6546600,-2176.5878900,12.5443000,0.0000000,0.0000000,-180.0000000); //
	CreateDynamicObject(19355,2025.7707500,-2203.8432600,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2028.9818100,-2203.8432600,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2025.7707500,-2209.0993700,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2028.9808300,-2209.0993700,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2025.7707500,-2199.0253900,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2028.9818100,-2199.0253900,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2025.7707500,-2214.3554700,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2028.9827900,-2214.3554700,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2028.9827900,-2219.1735800,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2025.7707500,-2219.1735800,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2000.2707500,-2199.0253900,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,1997.0588400,-2199.0253900,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,1997.0570100,-2205.1252400,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2000.2707500,-2205.1455100,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2000.2707500,-2210.9055200,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,1997.0618900,-2210.9016100,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,1997.0618900,-2217.0004900,10.8008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19355,2000.2707500,-2217.0043900,10.8008000,0.0000000,0.0000000,90.0000000); //
	
	// Casino Exterijer - Zen
	exterior_maps = CreateDynamicObject(19447, 1310.158447, -1380.307006, 12.634387, -0.799999, 89.700004, 0.699999, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1310.041137, -1370.697631, 12.500212, -0.799999, 89.700004, 0.699999, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1383.936035, 13.258644, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1383.936157, 13.258643, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1381.236572, 13.238645, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1381.236694, 13.228647, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1378.536987, 13.198653, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1378.537231, 13.178655, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1375.837646, 13.148660, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1375.837646, 13.158658, -0.899999, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1373.138183, 13.118662, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1373.137939, 13.128661, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1370.438232, 13.088662, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1370.437988, 13.098660, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1307.981567, -1367.738281, 13.028660, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(2773, 1312.334106, -1367.738037, 13.038659, -1.599981, 0.000000, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 1, 10412, "hotel1", "carpet_red_256", 0x00000000);
	exterior_maps = CreateDynamicObject(19477, 1308.479125, -1369.855957, 17.582183, 0.000000, 24.500009, 270.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "GOLDEN", 130, "Ariel", 120, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19477, 1311.780395, -1369.855957, 17.582183, 0.000000, 24.500009, 270.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "ANGELS", 130, "Ariel", 120, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19477, 1310.159179, -1369.855957, 17.582183, 0.000000, 24.500009, 270.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "v", 130, "Wingdings", 150, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(8618, 1291.128173, -1378.428466, 26.243215, 0.000000, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	exterior_maps = CreateDynamicObject(19482, 1291.738403, -1378.556396, 36.483459, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "GOLDEN", 130, "Ariel", 120, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19482, 1291.738159, -1378.576416, 34.281192, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "ANGELS", 130, "Ariel", 120, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19482, 1291.739257, -1378.506591, 35.362350, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "v", 130, "Wingdings", 150, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19482, 1291.739257, -1380.017333, 35.362350, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "z", 130, "Wingdings", 150, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19482, 1291.739257, -1376.967285, 35.362350, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "z", 130, "Wingdings", 150, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19482, 1291.773559, -1378.616455, 33.502002, 0.000000, -2.600021, 0.000000, -1, -1, -1);
	SetDynamicObjectMaterialText(exterior_maps, 0, "C  A  S  I  N  O", 130, "Ariel", 75, 1, 0xFFDC143C, 0x00000000, 1);
	exterior_maps = CreateDynamicObject(19447, 1275.101196, -1381.142578, 10.477412, -0.799999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.101196, -1377.401367, 10.477412, -0.799999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.101074, -1373.899169, 10.487411, -0.799999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.100708, -1370.599121, 10.517408, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.100463, -1367.299072, 10.537408, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.100219, -1363.999023, 10.547410, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099853, -1360.698974, 10.567411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099731, -1357.398925, 10.587410, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1354.098876, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1350.798828, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1324.536865, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1321.236816, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1317.936767, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1314.636718, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1311.336669, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1308.036621, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1304.736572, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1301.436523, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1298.136474, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);
	exterior_maps = CreateDynamicObject(19447, 1275.099487, -1294.836425, 10.607411, -0.399999, 0.000000, 90.000000, -1, -1, -1);
	SetDynamicObjectMaterial(exterior_maps, 0, 9525, "boigas_sfw", "GEwhite1_64", 0x00000000);

	CreateDynamicObject(3471, 1304.628662, -1368.636840, 13.805603, 0.000000, 0.000000, -90.000000, -1, -1, -1);
	CreateDynamicObject(3471, 1315.528808, -1368.636840, 13.805603, 0.000000, 0.000000, -90.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1312.326660, -1382.616577, 13.215988, 0.000000, 0.000000, 0.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1307.984741, -1382.616577, 13.215988, 0.000000, 0.000000, 0.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1312.326660, -1377.216674, 13.135986, 0.000000, 0.000000, 0.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1307.984741, -1377.216674, 13.175987, 0.000000, 0.000000, 0.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1312.326660, -1371.816772, 13.085985, 0.000000, 0.000000, 0.000000, -1, -1, -1);
	CreateDynamicObject(1215, 1307.984741, -1371.816772, 13.105985, 0.000000, 0.000000, 0.000000, -1, -1, -1);

	// THUGLIFE skola exterijer 7.12.2018.
	exterior_maps = CreateDynamicObject(16281, 927.506774, -1623.216552, 15.340000, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 14581, "ab_mafiasuitea", "mp_burn_ceiling", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 945.474121, -1674.095581, 12.527700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3442, "vegashse4", "Est_Gen_stone", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 934.974121, -1674.095581, 12.527700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3442, "vegashse4", "Est_Gen_stone", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 934.972900, -1686.805541, 12.527700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3442, "vegashse4", "Est_Gen_stone", 0x00000000);
	exterior_maps = CreateDynamicObject(19377, 945.474121, -1686.805541, 12.527700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 3442, "vegashse4", "Est_Gen_stone", 0x00000000);
	exterior_maps = CreateDynamicObject(19482, 927.384521, -1623.114501, 16.486894, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(exterior_maps, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterialText(exterior_maps, 0, " VERONA HIGH SCHOOL", 80, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	exterior_maps = CreateDynamicObject(8674, 954.924316, -1667.559082, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 944.485473, -1662.328369, 13.982600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 934.125488, -1662.328369, 13.982600, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3819, 933.763793, -1665.360961, 13.527600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3819, 943.263793, -1665.360961, 13.527600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 928.940795, -1667.511474, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 928.940795, -1677.881469, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 928.940795, -1688.250122, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 934.129516, -1693.429931, 13.982600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 954.924987, -1677.917358, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 954.924987, -1688.278442, 13.982600, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 944.489501, -1693.429931, 13.982600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(946, 930.869201, -1674.076049, 14.774100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(946, 949.529174, -1674.076049, 14.774100, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(946, 949.529174, -1686.975952, 14.774100, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(946, 930.869201, -1686.975952, 14.774100, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1618.033325, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1613.873291, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1628.393310, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1632.553344, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1636.713256, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1640.873291, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1645.033325, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1649.203247, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1653.363159, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1657.523193, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1661.683227, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1665.843139, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1670.003173, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1674.163208, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1678.323242, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1682.483154, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1686.643188, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1690.803222, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1694.963256, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3462, 969.527221, -1633.811645, 14.172788, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 975.831054, -1628.302001, 12.751700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(870, 968.964965, -1628.019897, 12.751700, 0.000000, 0.000000, -64.260017, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 977.580017, -1639.570434, 12.925298, 0.000000, 0.000000, 88.259986, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8623, 970.581726, -1633.776855, 13.248398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14469, 932.279174, -1628.672241, 13.140000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14402, 932.389099, -1641.099975, 13.102600, 0.000000, 0.000000, 54.060031, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14468, 938.630676, -1628.545898, 13.219698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14400, 946.179992, -1628.342285, 13.078398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 936.441345, -1632.427001, 12.925298, 0.000000, 0.000000, 27.180000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 943.868225, -1634.450195, 12.925298, 0.000000, 0.000000, 27.180000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14468, 940.127319, -1640.594116, 13.219698, 0.000000, 0.000000, 8.520000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14400, 947.077880, -1638.850341, 13.078398, 0.000000, 0.000000, 45.119998, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14402, 949.041076, -1633.366088, 13.102600, 0.000000, 0.000000, 18.000040, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 936.613586, -1637.822753, 12.925298, 0.000000, 0.000000, 27.180000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8991, 962.072143, -1634.090820, 13.188598, 0.000000, 0.000000, 89.459999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(748, 964.776672, -1628.113403, 12.532170, 0.000000, 0.000000, 186.719940, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(748, 970.511718, -1639.843383, 12.580598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14469, 932.279174, -1628.672241, 13.140000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(869, 965.286560, -1638.749023, 12.925298, 0.000000, 0.000000, -9.539990, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(792, 972.766296, -1628.267211, 12.534749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(792, 974.395629, -1640.144409, 12.534749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(14402, 931.122924, -1634.786010, 13.102600, 0.000000, 0.000000, 18.000040, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3521, 939.875183, -1634.765869, 13.982040, 0.000000, 0.000000, -91.739952, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1699.123291, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1703.263305, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(970, 927.537597, -1707.423339, 13.079198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(8674, 954.849487, -1693.429931, 13.982600, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1571, 957.941345, -1664.066406, 13.595499, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1340, 963.749633, -1663.735961, 13.535498, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1342, 968.316101, -1663.674316, 13.475500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1341, 972.635803, -1663.499389, 13.345298, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(729, 959.821838, -1685.710449, 11.400300, 0.000000, 0.000000, -66.239997, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(760, 961.234313, -1685.128906, 12.203128, 356.858398, 0.000000, -2.433028, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(748, 959.449157, -1684.049316, 12.580598, 0.000000, 0.000000, 21.239980, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(620, 958.482238, -1671.718017, 8.921878, 3.141590, 0.000000, 2.530730, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2541, 958.768615, -1665.172973, 12.525300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2541, 957.768615, -1665.172973, 12.525300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2541, 956.768615, -1665.172973, 12.525300, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2911, 955.982788, -1664.886596, 12.528400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2745, 957.950744, -1677.662719, 13.692098, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1281, 969.797729, -1669.067626, 13.292400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1281, 970.080444, -1685.915039, 13.292400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1364, 963.552185, -1673.704101, 13.288000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1364, 963.715209, -1681.357421, 13.288000, 0.000000, 0.000000, -180.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 973.814392, -1672.516967, 13.162698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 973.814392, -1666.697021, 13.162698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 973.814392, -1681.957031, 13.162698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 973.814392, -1689.437011, 13.162698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 969.591186, -1673.847656, 13.162698, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(638, 969.591186, -1681.327758, 13.162698, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2677, 962.103271, -1668.359619, 12.797598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2676, 965.142150, -1685.288574, 12.638998, 0.000000, 0.000000, -46.799999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2059, 966.031127, -1671.308593, 12.525198, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2671, 966.812622, -1666.992431, 12.526300, 0.000000, 0.000000, -125.939956, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1257, 926.353332, -1658.957763, 13.803898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(792, 958.208862, -1668.843994, 12.820308, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(634, 931.461853, -1646.377563, 11.921878, 3.141590, 0.000000, 1.373669, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(634, 931.415283, -1657.453613, 11.921878, 3.141590, 0.000000, 1.373669, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1231, 951.191894, -1626.717773, 15.217700, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1231, 960.230773, -1626.585327, 15.217700, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1297, 922.832763, -1651.870239, 15.903200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1297, 922.986145, -1616.054931, 15.903200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1297, 922.950256, -1636.752319, 15.903200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(792, 930.157409, -1651.532348, 12.820300, 356.858398, 0.000000, 3.141598, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(759, 970.628723, -1690.126098, 12.527198, 356.858398, 0.000000, 120.959999, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3065, 931.832824, -1673.311035, 12.740400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3065, 946.936828, -1688.918212, 12.740400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1256, 954.395629, -1671.505249, 13.143798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1256, 954.395629, -1676.825195, 13.143798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1256, 954.395629, -1684.445190, 13.143798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1256, 954.395629, -1689.785156, 13.143798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2671, 949.218811, -1666.979858, 12.546298, 0.000000, 0.000000, -125.940002, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(3065, 930.860900, -1668.255371, 12.740400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2677, 938.064819, -1667.777587, 12.819100, 0.000000, 0.000000, -64.439987, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1227, 962.625061, -1712.770996, 13.385198, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1331, 962.638427, -1716.984863, 13.405200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1450, 962.619384, -1714.983642, 13.125200, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(1440, 964.060913, -1718.966552, 13.041098, 0.000000, 0.000000, 155.639892, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2673, 964.294799, -1712.439697, 12.636098, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2860, 963.005065, -1710.941772, 12.535228, 0.000000, 0.000000, 185.580017, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2674, 964.548278, -1716.638671, 12.566398, 0.000000, 0.000000, -102.660011, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2670, 964.576965, -1714.425781, 12.628398, 0.000000, 0.000000, -381.719970, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(4227, 961.864379, -1713.272705, 14.081278, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18664, 982.775207, -1694.914672, 13.632300, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2676, 988.019287, -1692.168334, 12.678998, 0.000000, 0.000000, 68.160003, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(2677, 983.440673, -1692.262573, 12.837598, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(4227, 991.225708, -1695.438476, 13.999698, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18661, 986.746826, -1694.911254, 15.580498, 30.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18662, 985.753234, -1694.852294, 13.863598, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(18663, 989.034973, -1694.925781, 13.991998, -20.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	exterior_maps = CreateDynamicObject(4227, 998.936889, -1689.758056, 13.999698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);




	return (true);
}
