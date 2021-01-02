/* Houses Maps  */

#include <YSI_Coding\y_hooks>

new	houses_map;


hook OnFilterScriptInit() {

	//A kuca nakva
	houses_map = CreateDynamicObject(1746, 763.660766, -1013.273498, 78.974822, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(19457, 739.625854, -1018.670898, 78.154853, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.955261, -1027.255493, 77.229011, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19379, 742.491943, -1028.973266, 77.228950, 0.000007, -0.000012, 149.999938, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 737.358337, -1028.422729, 77.228950, 0.000007, -0.000012, 149.999938, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 736.672851, -1029.609008, 77.228950, -0.000012, -0.000007, -119.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19325, 739.199523, -1019.425231, 80.814811, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19371, 741.168457, -1016.015380, 80.704826, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 737.143615, -1022.986938, 80.704826, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.180114, -1028.078491, 77.229011, 0.000012, 0.000007, 149.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19379, 744.132690, -1021.249389, 78.918876, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 750.867858, -1022.782714, 78.908882, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 756.660827, -1021.888854, 78.898887, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 760.991821, -1014.388732, 78.888885, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 737.571838, -1032.611938, 76.488891, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19438, 741.052856, -1026.395385, 77.551780, 56.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 740.703247, -1027.018188, 75.534828, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19379, 743.697387, -1022.003295, 74.568870, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19371, 738.424133, -1023.530029, 80.704826, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19457, 746.169067, -1017.075622, 80.714820, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 743.790161, -1015.715759, 80.454841, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4887, "downtown_las", "ws_glassnbrassdoor", 0x00000000);
	houses_map = CreateDynamicObject(19457, 756.445556, -1011.797668, 80.714820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19457, 754.021423, -1015.975891, 80.714820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19457, 747.486267, -1017.836364, 80.714820, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(18980, 757.124145, -1006.847290, 78.444862, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
	houses_map = CreateDynamicObject(18980, 761.030151, -1024.101806, 78.444862, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
	houses_map = CreateDynamicObject(19325, 765.173522, -1011.118713, 80.814811, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 759.423950, -1007.799133, 80.814811, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 766.389343, -1015.654418, 80.814811, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 763.068969, -1021.405151, 80.814811, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 759.748840, -1027.155639, 80.814811, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(18980, 757.124145, -1006.847290, 82.814781, -0.000007, 90.000015, -29.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(18980, 761.030151, -1024.101806, 82.814781, 0.000012, 90.000000, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19457, 754.650634, -1026.348754, 80.714820, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 742.303771, -1024.246826, 77.094818, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 742.303771, -1024.246826, 73.594779, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(14397, 758.966735, -1020.115478, 80.504783, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(14397, 758.161010, -1019.650024, 80.504783, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(14397, 757.390075, -1019.204833, 80.504783, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(14397, 756.610046, -1018.754394, 80.504783, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(19381, 748.738281, -1028.541137, 78.934822, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	houses_map = CreateDynamicObject(19381, 744.251831, -1025.950561, 73.814849, 0.000000, 180.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19381, 750.773437, -1024.115356, 73.814849, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19172, 755.559875, -1013.522216, 80.854797, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14771, "int_brothelint3", "GB_midbar10", 0x00000000);
	houses_map = CreateDynamicObject(19172, 756.525573, -1011.850158, 80.854797, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14771, "int_brothelint3", "GB_midbar10", 0x00000000);
	houses_map = CreateDynamicObject(19457, 756.192687, -1005.993225, 80.714820, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(2259, 747.074829, -1018.252807, 80.584800, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING34", 0x00000000);
	houses_map = CreateDynamicObject(2259, 749.387268, -1019.588256, 80.584800, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING35", 0x00000000);
	houses_map = CreateDynamicObject(2388, 742.176086, -1025.084472, 78.864830, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(2388, 744.194946, -1026.250366, 78.864830, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(2388, 743.146789, -1025.644897, 78.864830, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(19987, 741.872680, -1025.168212, 80.134788, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 741.872680, -1025.168212, 79.664817, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 741.872680, -1025.168212, 79.194854, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19172, 758.689208, -1018.513610, 80.924835, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	houses_map = CreateDynamicObject(11685, 758.436218, -1015.108337, 78.974822, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(11685, 759.096862, -1013.964538, 78.974822, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(11685, 759.757019, -1012.821350, 78.974822, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(11685, 760.412170, -1011.686950, 78.974822, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(11685, 760.719299, -1011.575378, 78.964820, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(11685, 761.845275, -1012.225402, 78.964820, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(1746, 762.829101, -1012.793212, 78.974822, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(19371, 761.266296, -1014.943176, 78.904830, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19379, 756.063354, -1021.566833, 74.568870, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 760.519104, -1013.850891, 74.558876, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 743.619934, -1010.838623, 74.568870, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19371, 741.747070, -1022.170593, 77.074806, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 741.742065, -1022.179260, 76.354827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19379, 742.748596, -1017.125305, 73.628929, 0.000012, 0.000007, 149.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19381, 754.008850, -1025.972534, 73.814849, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19381, 746.506713, -1018.163879, 69.394905, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19381, 747.916503, -1015.559814, 73.584922, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(2388, 750.941650, -1020.665588, 74.604827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(2388, 752.296508, -1018.319030, 74.604827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(19381, 754.378051, -1013.828735, 73.584922, 0.000000, 180.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19987, 750.621032, -1020.737304, 75.924804, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(2388, 745.793273, -1017.681152, 74.604827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(2388, 747.707824, -1018.786621, 74.604827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(2388, 749.501159, -1019.822509, 74.604827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2772, "airp_prop", "cj_chromepipe", 0x00000000);
	houses_map = CreateDynamicObject(19987, 745.484863, -1017.771423, 75.924804, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 747.797607, -1019.107116, 75.924804, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 745.484863, -1017.771423, 75.374847, 89.999992, 151.719009, -91.718994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 747.797607, -1019.107116, 75.374847, 89.999992, 151.719009, -91.718994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 745.484863, -1017.771423, 74.824890, 89.999992, 150.859710, -90.859672, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 747.797607, -1019.107116, 74.824890, 89.999992, 150.859710, -90.859672, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.975036, -1020.167358, 77.074729, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.884948, -1020.323364, 77.074729, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.975036, -1020.167358, 73.584709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.884948, -1020.323364, 73.584709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18018, "genintintbarb", "GB_midbar01", 0x00000000);
	houses_map = CreateDynamicObject(19987, 750.612365, -1020.732360, 75.374847, 89.999992, 151.719009, -1.718994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19987, 750.612365, -1020.732360, 74.804870, 89.999992, 151.719009, -1.718994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19379, 754.929443, -1023.453979, 70.658866, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 759.739807, -1015.122985, 70.658866, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19381, 761.761230, -1012.485717, 69.314903, -0.000006, 180.000000, -119.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(19381, 753.429809, -1007.675354, 69.314903, -0.000006, 180.000000, -119.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(19381, 746.406616, -1018.337219, 69.394905, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19381, 746.435302, -1018.307556, 69.394905, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 745.602478, -1023.506713, 68.718841, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 736.518127, -1018.261474, 68.718841, -0.000003, -89.999992, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0xFF333333);
	houses_map = CreateDynamicObject(19379, 747.169189, -1025.288696, 69.248939, 0.000012, 0.000007, 239.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19381, 746.578002, -1027.363403, 68.734848, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	houses_map = CreateDynamicObject(19379, 740.699096, -1027.014282, 69.248939, 0.000012, 0.000007, 329.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19381, 737.442077, -1022.966186, 73.814849, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 739.759521, -1020.855346, 72.744773, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 739.759521, -1020.855346, 69.244758, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19385, 737.679321, -1019.656555, 70.544807, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19379, 737.978210, -1013.675292, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 743.223876, -1004.590332, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.468994, -995.505981, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 729.647216, -1008.865112, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 734.897583, -999.771911, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 740.147460, -990.679199, 68.724784, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 4550, "skyscr1_lan2", "sl_librarywall1", 0x00000000);
	houses_map = CreateDynamicObject(19379, 740.147460, -990.679199, 68.244781, 0.000000, 360.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 741.842041, -1016.403503, 68.244781, 0.000000, 360.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 746.657104, -1008.063659, 68.244781, 0.000000, 360.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 751.472412, -999.723815, 68.244781, 0.000000, 360.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 724.791625, -1007.583557, 68.244781, 0.000003, 360.000000, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 729.606689, -999.243713, 68.244781, 0.000003, 360.000000, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 734.421997, -990.903869, 68.244781, 0.000003, 360.000000, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.486999, -995.494323, 68.244781, 0.000000, 360.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 732.136840, -1016.434692, 68.244781, 0.000000, 360.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 723.797546, -1011.619812, 68.244781, 0.000000, 360.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19379, 737.978210, -1013.675292, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(3037, 729.627563, -999.254638, 70.846389, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18045, "gen_munation", "mp_gun_shutter", 0x00000000);
	houses_map = CreateDynamicObject(19379, 743.223876, -1004.590332, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.468994, -995.505981, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 729.647216, -1008.865112, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 734.897583, -999.771911, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 740.147460, -990.679199, 73.534812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "chr_flags_256", 0x00000000);
	houses_map = CreateDynamicObject(18980, 733.877258, -1008.162170, 61.310722, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 11395, "corvinsign_sfse", "shutters", 0x00000000);
	houses_map = CreateDynamicObject(18980, 739.597595, -998.254455, 61.310722, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 11395, "corvinsign_sfse", "shutters", 0x00000000);
	houses_map = CreateDynamicObject(18980, 745.192138, -1001.484741, 61.310722, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 11395, "corvinsign_sfse", "shutters", 0x00000000);
	houses_map = CreateDynamicObject(18980, 739.487060, -1011.366333, 61.310722, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 11395, "corvinsign_sfse", "shutters", 0x00000000);
	houses_map = CreateDynamicObject(19325, 765.782165, -1015.165161, 76.484840, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 762.461914, -1020.915405, 76.484840, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 759.141967, -1026.665405, 76.484840, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 759.417297, -1019.630554, 76.564826, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 755.716247, -1019.399475, 76.564826, 0.000000, 0.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19385, 753.310852, -1023.643066, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.582885, -1017.963867, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19385, 758.181030, -1015.207885, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 759.404479, -1019.610534, 76.394844, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.212402, -1021.214233, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.211547, -1028.142700, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19325, 760.201049, -1011.631469, 76.564826, 0.000000, 0.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 764.562316, -1010.638977, 76.484840, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 765.782165, -1015.165161, 72.434791, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 762.461914, -1020.915405, 72.434791, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19325, 759.141967, -1026.665405, 72.434791, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
	houses_map = CreateDynamicObject(19385, 752.771118, -1023.297363, 72.494819, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19385, 753.702026, -1018.384338, 72.494819, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 754.374328, -1020.518920, 72.494827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 755.820434, -1021.353942, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 759.215942, -1023.314697, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 757.253234, -1022.192687, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 754.386657, -1020.537597, 72.494827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19385, 752.789794, -1023.285156, 72.504814, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19385, 753.729370, -1018.377014, 72.504814, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(14446, 760.517211, -1013.900817, 71.464790, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.492858, -1010.215393, 72.484840, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 765.148864, -1014.636169, 72.484840, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19172, 758.412231, -1020.835693, 72.864845, 3.399997, 0.000000, 151.700073, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	houses_map = CreateDynamicObject(2257, 754.094482, -1020.753173, 72.794731, 0.000000, 0.000000, 600.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING19", 0x00000000);
	houses_map = CreateDynamicObject(2140, 758.448547, -1027.861694, 78.974815, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2140, 757.608398, -1027.376342, 78.974815, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2137, 756.757385, -1026.864624, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2137, 755.899658, -1026.369506, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2136, 755.035705, -1025.886108, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 4, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2135, 753.312744, -1024.885986, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 5, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2137, 752.470397, -1024.389648, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2140, 751.615478, -1023.916503, 78.974815, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 757.840576, -1024.836425, 78.984825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 756.982849, -1024.340820, 78.984825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 756.125488, -1023.845703, 78.984825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 755.267639, -1023.350097, 78.984825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 754.410278, -1022.855224, 78.984825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 754.946533, -1021.986694, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 755.804199, -1022.481872, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 756.661682, -1022.976928, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 757.519042, -1023.472045, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2139, 758.376647, -1023.967529, 78.984825, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 3, 3440, "airportpillar", "metalic_64", 0x00000000);
	houses_map = CreateDynamicObject(2350, 755.691589, -1021.094970, 79.354850, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
	houses_map = CreateDynamicObject(2350, 756.471496, -1021.545349, 79.354850, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
	houses_map = CreateDynamicObject(2350, 757.173400, -1021.950622, 79.354850, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
	houses_map = CreateDynamicObject(2350, 757.857604, -1022.345947, 79.354850, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
	houses_map = CreateDynamicObject(2350, 758.611511, -1022.781372, 79.354850, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
	houses_map = CreateDynamicObject(19172, 759.475341, -1019.393432, 76.774345, 4.899998, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	houses_map = CreateDynamicObject(2960, 759.577392, -1019.197265, 75.438346, 60.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	houses_map = CreateDynamicObject(19379, 753.800170, -1026.318725, 78.224861, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 745.478576, -1021.513671, 78.224861, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 759.045349, -1017.234802, 78.224861, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 760.575927, -1014.584472, 78.204856, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 750.718444, -1012.438110, 78.194862, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19438, 751.393798, -1022.730041, 78.074798, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19371, 752.797546, -1020.596618, 78.084815, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19371, 755.022399, -1016.742614, 78.084815, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19371, 760.957092, -1010.405761, 76.364830, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.755126, -1010.878906, 76.364830, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 755.984069, -1009.279235, 76.364830, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 757.212646, -1012.949707, 78.084815, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 748.362609, -1020.980041, 78.074798, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 745.705322, -1020.542297, 78.074798, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.960449, -1023.564331, 78.074798, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 747.511840, -1017.093139, 78.074798, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 744.828186, -1016.641723, 78.074798, 0.000000, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.077941, -1019.672790, 78.074798, 0.000000, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.998657, -1022.024108, 78.054779, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.648193, -1024.362548, 78.054779, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.638977, -1017.550048, 78.054779, 0.000003, 89.999992, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.839355, -1015.471008, 78.054779, 0.000003, 89.999992, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.009521, -1013.444213, 78.054779, 0.000003, 89.999992, 149.999954, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19425, 759.762695, -1019.222778, 74.644813, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	houses_map = CreateDynamicObject(19425, 759.704956, -1019.200683, 74.876823, -0.000003, -13.599993, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	houses_map = CreateDynamicObject(19425, 759.704956, -1019.200683, 74.876823, -0.000003, 11.400004, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	houses_map = CreateDynamicObject(2916, 761.506652, -1020.117553, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 761.212158, -1019.947448, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 760.926147, -1019.782287, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 760.631469, -1019.612121, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 760.345458, -1019.446960, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 760.068115, -1019.286804, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 759.782104, -1019.121643, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 759.496093, -1018.956481, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 759.201477, -1018.786315, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 758.898132, -1018.611145, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 758.620788, -1018.450988, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 758.343444, -1018.290832, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2916, 758.022766, -1018.105651, 75.458763, 0.000000, 25.900016, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
	houses_map = CreateDynamicObject(2257, 753.328369, -1015.876464, 76.494796, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING24", 0x00000000);
	houses_map = CreateDynamicObject(2257, 755.177917, -1012.672973, 76.494796, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING26", 0x00000000);
	houses_map = CreateDynamicObject(2257, 758.381652, -1010.804443, 76.494796, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING12", 0x00000000);
	houses_map = CreateDynamicObject(2257, 749.784423, -1023.409667, 76.494804, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING4", 0x00000000);
	houses_map = CreateDynamicObject(2257, 745.701721, -1023.199462, 76.494804, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING27", 0x00000000);
	houses_map = CreateDynamicObject(2257, 741.785583, -1019.021118, 76.494804, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING37", 0x00000000);
	houses_map = CreateDynamicObject(2257, 743.485961, -1016.076232, 76.494804, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING34", 0x00000000);
	houses_map = CreateDynamicObject(14455, 753.501464, -1025.605834, 76.264793, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	houses_map = CreateDynamicObject(2257, 759.313110, -1019.691894, 76.494796, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING23", 0x00000000);
	houses_map = CreateDynamicObject(2205, 758.830017, -1021.925964, 74.624809, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2637, 757.460266, -1022.906250, 75.084815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2637, 756.870056, -1023.928222, 75.094810, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19379, 756.599792, -1021.411560, 74.314880, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 761.844543, -1012.327209, 74.314880, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.854431, -1020.981140, 74.324882, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 761.105163, -1011.888000, 74.324882, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.750427, -1020.921081, 74.504852, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.750427, -1020.921081, 74.554847, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 743.644958, -1022.867919, 74.324882, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 735.322998, -1018.063476, 74.324882, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19438, 752.391296, -1020.490783, 74.152343, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 750.292724, -1022.224731, 74.152343, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 747.261779, -1020.474670, 74.152343, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.278503, -1019.272277, 74.152343, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 745.529541, -1019.474426, 74.162345, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 740.124694, -1022.833251, 74.152343, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 741.527893, -1022.303771, 74.132347, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 737.093505, -1021.082946, 74.152343, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19379, 742.036804, -1024.737548, 63.578926, 0.000012, 0.000007, 329.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	houses_map = CreateDynamicObject(19379, 748.548217, -1022.919921, 63.578926, 0.000012, 0.000007, 419.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3967, "cj_airprt", "Road_blank256HV", 0x00000000);
	houses_map = CreateDynamicObject(19379, 733.822204, -1022.985717, 69.248939, 0.000012, 0.000007, 329.999969, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(2257, 745.589660, -1018.002136, 71.624748, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING21", 0x00000000);
	houses_map = CreateDynamicObject(2257, 748.646911, -1019.767211, 72.444755, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING16", 0x00000000);
	houses_map = CreateDynamicObject(2257, 749.634643, -1023.316650, 72.794731, 0.000000, 0.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING10", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.950195, -1023.357055, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.330200, -1021.035339, 72.474769, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.363952, -1022.464111, 70.824775, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.332580, -1020.713806, 70.824775, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.363952, -1022.464111, 74.154716, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.375854, -1020.738464, 74.154716, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 754.960205, -1019.910095, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.653198, -1020.899597, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.286071, -1022.419799, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.407409, -1022.489868, 71.634834, 180.000000, 90.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2133, 760.059020, -1022.244079, 70.604820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2133, 760.778381, -1022.659484, 70.604820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2133, 755.676879, -1019.713745, 70.604820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2133, 756.500061, -1020.189208, 70.604820, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.480285, -1020.799682, 71.634834, 180.000000, 90.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.480285, -1020.799682, 73.494834, 180.000000, 90.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.399414, -1022.485168, 73.494834, 180.000000, 90.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	houses_map = CreateDynamicObject(2694, 760.395080, -1022.593566, 73.684791, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14668, "711c", "CJ_CHIP_M2", 0x00000000);
	houses_map = CreateDynamicObject(2694, 756.541198, -1020.368103, 73.684791, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14581, "ab_mafiasuitea", "goldPillar", 0x00000000);
	houses_map = CreateDynamicObject(2694, 756.133911, -1020.132873, 73.684791, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14787, "ab_sfgymbits02", "sign_cobra1", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.098999, -1023.119384, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 765.674377, -1015.195007, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19196, 757.273315, -1020.268066, 72.114830, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19058, "xmasboxes", "silk6-128x128", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 19058, "xmasboxes", "silk6-128x128", 0x00000000);
	houses_map = CreateDynamicObject(19379, 762.686950, -1017.248657, 70.634811, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 757.442016, -1026.332641, 70.634811, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 765.892517, -1013.417785, 78.844802, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 760.647521, -1022.501892, 78.844802, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.402404, -1031.586303, 78.844802, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 764.058288, -1013.432922, 74.524856, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 758.818176, -1022.509033, 74.524856, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 758.372741, -1023.280273, 74.514854, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 763.129577, -1011.821777, 78.824806, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19438, 771.862548, -1012.807556, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 770.117431, -1015.829895, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 768.372619, -1018.852111, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 766.627441, -1021.874877, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 764.877258, -1024.906005, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.127014, -1027.936889, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.386840, -1030.950805, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.641540, -1033.973754, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.891662, -1037.005004, 79.110725, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.578613, -1037.690795, 79.110725, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 771.278930, -1010.497436, 79.110725, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 768.248107, -1008.747314, 79.110725, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 765.225524, -1007.002075, 79.110725, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.194519, -1005.252014, 79.110725, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19457, 760.679321, -1006.354125, 78.340744, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19457, 760.614257, -1006.466796, 78.340744, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 769.329406, -1010.434204, 74.790733, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 766.315429, -1008.693603, 74.790733, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.301696, -1006.953491, 74.790733, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19457, 762.537841, -1007.497131, 73.850730, 90.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 769.866149, -1012.845642, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 768.116210, -1015.876403, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 766.365722, -1018.907531, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 764.615356, -1021.938598, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.865173, -1024.969726, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.119384, -1027.992553, 74.790733, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.772033, -1028.738403, 74.790733, 90.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 765.892517, -1013.417785, 78.784805, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 760.647521, -1022.501892, 78.784805, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.402404, -1031.586303, 78.784805, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 768.048034, -1014.314453, 70.970756, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 768.567382, -1016.715942, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 766.821838, -1019.738769, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 765.076538, -1022.761474, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.326232, -1025.792358, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.581115, -1028.814575, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.831298, -1031.845581, 70.990760, 90.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.533813, -1032.505004, 70.990760, 90.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 763.129577, -1011.821777, 78.804809, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 764.058288, -1013.432922, 74.514854, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 758.818176, -1022.509033, 74.514854, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 758.372741, -1023.280273, 74.504859, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.617675, -1023.972167, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.097290, -1028.337036, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(2136, 754.576538, -1021.321289, 70.744804, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 4, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(2136, 756.291137, -1022.311218, 70.744804, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 4, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(2528, 755.393554, -1026.021118, 70.744804, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.238464, -1024.864257, 70.744804, 270.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.488403, -1027.895629, 70.744804, 270.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.615600, -1025.660034, 70.744804, 270.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.870117, -1028.682739, 70.744804, 270.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.860412, -1028.711547, 71.464775, 360.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.695190, -1027.265502, 69.784782, 540.000000, 180.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.715454, -1023.766601, 69.784782, 540.000000, 180.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.810302, -1025.334106, 70.684761, 540.000000, 270.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.060363, -1028.365112, 70.684761, 540.000000, 270.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2139, 757.989685, -1023.310546, 70.734802, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 2, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 3, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19379, 739.761474, -1027.903930, 82.544837, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.549011, -1021.807556, 72.874809, 90.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 16322, "a51_stores", "metalic128", 0x00000000);
	houses_map = CreateDynamicObject(19379, 745.011291, -1018.810974, 82.544837, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 753.351074, -1023.626220, 82.544837, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 758.601013, -1014.533264, 82.544837, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 756.521118, -1021.357604, 82.534843, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19379, 760.112243, -1015.137939, 82.554832, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19457, 741.640686, -1025.780151, 82.374809, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 745.535644, -1019.715087, 82.374809, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 760.241821, -1015.804321, 82.374809, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.493530, -1023.318847, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.833129, -1011.446960, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.082336, -1014.478637, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.332031, -1017.509948, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 753.582397, -1020.540710, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 764.427551, -1014.677917, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.677307, -1017.708984, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.927368, -1020.739746, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.177246, -1023.770874, 82.394844, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 753.929626, -1021.838439, 82.404846, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.126647, -1021.201599, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 15046, "svcunthoose", "mplid02", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.854492, -1025.895141, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 753.823181, -1024.144775, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 750.791503, -1022.394226, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 746.672912, -1024.046630, 82.394844, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 747.773132, -1024.682128, 82.404846, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 739.922363, -1021.418884, 82.374847, 0.000000, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 741.667419, -1018.396240, 82.384849, 0.000000, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19604, 760.061279, -1015.923583, 82.414779, 180.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 5998, "sunstr_lawn", "sunneon01", 0x00000000);
	houses_map = CreateDynamicObject(19604, 760.095397, -1015.944213, 82.394783, 180.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14561, "triad_neon", "lightalp1a", 0x00000000);
	houses_map = CreateDynamicObject(19604, 758.765014, -1018.168029, 82.404777, 180.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 5998, "sunstr_lawn", "sunneon01", 0x00000000);
	houses_map = CreateDynamicObject(2315, 752.176452, -1019.131652, 79.504829, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 752.716735, -1018.196044, 79.994865, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 752.716735, -1018.196044, 80.964874, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 752.176452, -1019.131652, 80.474815, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 757.526611, -1009.865295, 79.364845, 0.000006, 0.000003, 59.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 757.526611, -1009.865295, 80.254875, 0.000006, 0.000003, 59.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(2315, 757.526611, -1009.865295, 81.104881, 0.000006, 0.000003, 59.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2994, "trolex", "trolley03", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.549072, -1018.815795, 80.530731, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.403930, -1019.067138, 80.530731, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(2913, 762.647094, -1018.621887, 75.614807, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(2828, 752.705566, -1018.862182, 79.574790, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 18064, "ab_sfammuunits", "gun_targeta", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 5, 14787, "ab_sfgymbits02", "sign_cobra2", 0x00000000);
	houses_map = CreateDynamicObject(2247, 757.041198, -1023.371948, 75.954795, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 10023, "bigwhitesfe", "clubpole_SFw", 0x00000000);
	houses_map = CreateDynamicObject(19379, 765.892517, -1013.417785, 82.644767, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 760.642761, -1022.510437, 82.644767, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 755.397705, -1031.594604, 82.644767, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 757.552917, -1008.603149, 82.644767, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 2951, "a51_labdoor", "washapartwall1_256", 0x00000000);
	houses_map = CreateDynamicObject(19379, 733.609802, -1019.374328, 78.858261, -3.199999, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19379, 738.846862, -1010.283264, 79.028015, -3.199999, 88.200027, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_slatetiles", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.963195, -1014.997436, 79.380729, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19940, 760.980041, -1014.917846, 79.004844, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19940, 760.980041, -1014.917846, 79.224815, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(2314, 759.491699, -1018.700805, 78.974822, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2352, 758.219726, -1018.487121, 80.984809, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2352, 758.964965, -1018.917480, 80.984809, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2352, 759.335815, -1019.536132, 76.874794, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2352, 758.271972, -1020.977844, 72.854789, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19828, 757.677490, -1017.923583, 80.234825, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18996, "mattextures", "sampred", 0x00000000);
	houses_map = CreateDynamicObject(19828, 758.423767, -1018.851684, 76.084846, -5.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18996, "mattextures", "sampred", 0x00000000);
	houses_map = CreateDynamicObject(19604, 758.809997, -1018.169433, 82.364784, 180.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14561, "triad_neon", "lightalp1a", 0x00000000);
	houses_map = CreateDynamicObject(19457, 762.011413, -1011.291381, 74.144805, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 762.186584, -1010.988037, 74.134803, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 762.186584, -1010.988037, 70.824821, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 759.091003, -1009.189086, 69.244812, 90.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 765.231567, -1012.734802, 69.254798, 90.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19457, 762.011413, -1011.291381, 70.814842, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.692199, -1012.199584, 74.174797, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.286926, -1015.430175, 74.174797, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 761.682495, -1018.269104, 74.174797, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.645935, -1020.084228, 74.174797, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.651550, -1016.517822, 74.174797, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 756.113525, -1015.052429, 74.184791, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.614562, -1018.333679, 74.174797, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.067749, -1016.862731, 74.184791, 0.000000, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(2083, 759.770935, -1011.231323, 71.074775, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(2083, 764.101562, -1013.731628, 71.074775, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19604, 762.183776, -1012.848083, 69.084770, 270.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14561, "triad_neon", "lightalp1a", 0x00000000);
	houses_map = CreateDynamicObject(19604, 757.853576, -1010.347900, 69.084770, 270.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14561, "triad_neon", "lightalp1a", 0x00000000);
	houses_map = CreateDynamicObject(2314, 758.751159, -1015.481872, 70.744804, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19371, 759.606811, -1018.881408, 70.674812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14533, "pleas_dome", "club_zeb_SFW1", 0x00000000);
	houses_map = CreateDynamicObject(19371, 756.827392, -1017.276733, 70.674812, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14533, "pleas_dome", "club_zeb_SFW1", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.583801, -1013.088623, 70.664817, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14533, "pleas_dome", "club_zeb_SFW1", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.606628, -1015.988647, 70.664817, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14533, "pleas_dome", "club_zeb_SFW1", 0x00000000);
	houses_map = CreateDynamicObject(14867, 754.569030, -1013.747314, 72.260749, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	houses_map = CreateDynamicObject(2259, 757.294738, -1010.754089, 72.334800, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 14489, "carlspics", "AH_landscap1", 0x00000000);
	houses_map = CreateDynamicObject(19172, 764.680786, -1017.068786, 73.830680, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 763.330200, -1019.407592, 73.830680, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 761.980041, -1021.745910, 73.830680, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 759.594726, -1025.877075, 73.830680, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 758.244873, -1028.215209, 73.830680, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 767.372680, -1013.947265, 82.060592, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 766.022521, -1016.285766, 82.060592, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 764.672241, -1018.624328, 81.820610, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 763.321838, -1020.963256, 81.820610, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 761.972412, -1023.300781, 82.060592, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 760.622253, -1025.639282, 82.060592, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 759.271484, -1027.978149, 81.820610, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 766.868225, -1012.100585, 81.820610, 0.000000, 180.000000, -210.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 764.529785, -1010.750366, 82.120597, 0.000000, 180.000000, -210.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 762.191223, -1009.399780, 81.820610, 0.000000, 180.000000, -210.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 759.861572, -1008.054687, 81.820610, 0.000000, 180.000000, -210.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.004028, -1021.484069, 80.714775, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.359008, -1029.416381, 80.594810, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 767.639404, -1013.455505, 80.714775, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(2259, 762.516540, -1021.188354, 80.664833, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING34", 0x00000000);
	houses_map = CreateDynamicObject(2259, 767.131896, -1013.194702, 80.664833, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING23", 0x00000000);
	houses_map = CreateDynamicObject(2257, 738.738586, -1030.654907, 78.664817, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2254, "picture_frame_clip", "CJ_PAINTING4", 0x00000000);
	houses_map = CreateDynamicObject(2257, 742.320190, -1029.051147, 79.084815, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 2266, "picture_frame", "CJ_PAINTING28", 0x00000000);
	houses_map = CreateDynamicObject(2346, 742.978088, -1025.565307, 78.306861, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(2346, 744.121459, -1026.225708, 78.306861, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(2346, 744.111450, -1026.243041, 78.486839, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(2346, 742.968261, -1025.582641, 78.486839, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.632507, -1020.377319, 78.914825, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 753.977966, -1019.377807, 78.914833, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.728454, -1016.346679, 78.914833, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.473632, -1013.323974, 78.914833, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 759.224060, -1010.292724, 78.914833, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 760.307189, -1023.178466, 78.914833, 0.000012, 90.000000, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 762.057678, -1020.147399, 78.914833, 0.000012, 90.000000, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 763.802856, -1017.124694, 78.914833, 0.000012, 90.000000, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 765.553283, -1014.093444, 78.914833, 0.000012, 90.000000, 59.999977, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(16500, 745.468200, -1024.056640, 80.924812, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1255, "lounger", "lounger_back", 0x00000000);
	houses_map = CreateDynamicObject(16500, 743.887695, -1026.793334, 80.924812, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1255, "lounger", "lounger_back", 0x00000000);
	houses_map = CreateDynamicObject(19425, 746.820556, -1021.949279, 80.734809, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1255, "lounger", "lounger_back", 0x00000000);
	houses_map = CreateDynamicObject(19425, 746.820556, -1021.949279, 80.734809, 0.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1255, "lounger", "lounger_back", 0x00000000);
	houses_map = CreateDynamicObject(19425, 745.100341, -1024.928710, 80.734809, 0.000000, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1255, "lounger", "lounger_back", 0x00000000);
	houses_map = CreateDynamicObject(2081, 745.049194, -1024.262451, 79.004814, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	houses_map = CreateDynamicObject(1708, 745.866149, -1021.775390, 79.004814, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 2, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(1708, 744.325805, -1024.443359, 79.004814, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 2, 18773, "tunnelsections", "stonewall4", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.688903, -1022.779296, 78.934829, 0.000006, 90.000000, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(2247, 745.084777, -1023.656982, 79.934822, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.043579, -1017.637023, 78.934829, 0.000006, 90.000000, 149.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 746.074279, -1019.387207, 78.934829, 0.000006, 90.000000, 149.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.105285, -1021.137573, 78.934829, 0.000006, 90.000000, 149.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19172, 739.787658, -1018.344848, 82.060592, 0.000000, 180.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 738.442504, -1020.674560, 82.060592, 0.000000, 180.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 766.787536, -1013.481933, 77.470588, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 765.437744, -1015.819641, 78.030570, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 764.087707, -1018.157958, 78.030570, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 762.736816, -1020.497009, 77.470588, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 761.231262, -1023.104125, 77.470588, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 759.881225, -1025.442504, 77.900566, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 758.535888, -1027.772094, 77.900566, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 766.294860, -1011.614685, 77.470588, 0.000000, 180.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 763.956909, -1010.265075, 77.770576, 0.000000, 180.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19172, 761.618286, -1008.914550, 77.770576, 0.000000, 180.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 2718, "cj_ff_acc2", "GRATE", 0x00000000);
	houses_map = CreateDynamicObject(19438, 766.983337, -1012.952270, 76.384834, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 755.845397, -1021.391357, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 758.625305, -1022.996337, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 759.115661, -1023.267944, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 753.397827, -1025.590454, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 756.177856, -1027.195434, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 756.666809, -1027.489379, 72.494827, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x00000000);
	houses_map = CreateDynamicObject(19371, 754.388000, -1020.515258, 72.494827, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19438, 754.513244, -1024.594482, 74.174797, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.128417, -1026.104370, 74.164794, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.523498, -1022.844726, 74.174797, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 758.138305, -1024.355468, 74.164794, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.687011, -1024.117187, 70.674842, 0.000006, 90.000000, 149.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.163085, -1023.421386, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 751.972412, -1021.971679, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 749.297363, -1021.525085, 74.574821, 0.000006, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 746.265747, -1019.774536, 74.574821, 0.000006, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 744.990661, -1021.982849, 74.574821, 0.000006, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 743.245483, -1025.005371, 74.574821, 0.000006, 90.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 744.944030, -1016.284545, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 744.584899, -1018.803771, 74.584823, 0.000006, 90.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 753.722473, -1018.940979, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 755.467590, -1015.918762, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(19438, 757.217956, -1012.887695, 74.574821, 0.000006, 90.000000, 239.999984, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14735, "newcrak", "carp21S", 0x00000000);
	houses_map = CreateDynamicObject(2163, 753.872436, -1025.713256, 70.720787, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(1549, 753.868041, -1021.893371, 70.750778, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19457, 753.449340, -1025.661499, 70.664802, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 8486, "ballys02", "walltiles_128", 0x00000000);
	houses_map = CreateDynamicObject(19457, 756.480651, -1027.411743, 70.664802, 0.000000, 90.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 8486, "ballys02", "walltiles_128", 0x00000000);
	houses_map = CreateDynamicObject(2515, 757.865173, -1027.089965, 71.560745, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19480, "signsurf", "sign", 0x00000000);
	houses_map = CreateDynamicObject(2036, 758.126403, -1009.464355, 80.904975, 90.200004, -0.499998, -120.199989, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	houses_map = CreateDynamicObject(2250, 753.939880, -1025.520629, 72.030738, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 1, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	houses_map = CreateDynamicObject(19173, 755.130859, -1026.482543, 73.070800, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	houses_map = CreateDynamicObject(355, 754.999328, -1026.387329, 73.080772, 0.000000, 0.000000, -26.899988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 1564, "ab_jetlite", "CJ_BULLETBRASS", 0x00000000);
	houses_map = CreateDynamicObject(19172, 754.574523, -1015.228393, 80.854797, 0.000000, 90.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14771, "int_brothelint3", "GB_midbar10", 0x00000000);
	houses_map = CreateDynamicObject(1499, 752.979125, -1024.302001, 74.640769, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_officewall3", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(1499, 757.849853, -1015.866394, 74.640769, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_officewall3", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(1499, 754.342773, -1018.760437, 70.730773, 0.000000, 0.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_officewall3", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(1499, 752.407348, -1023.913330, 70.730773, 0.000000, 0.000000, 780.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 18757, "vcinteriors", "dt_officewall3", 0x00000000);
	SetDynamicObjectMaterial(houses_map, 1, 17146, "cuntwroad", "Tar_blenddrtwhiteline", 0x00000000);
	houses_map = CreateDynamicObject(19385, 737.692993, -1019.652893, 70.564804, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19438, 739.774536, -1020.829345, 71.754783, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19438, 739.779541, -1020.820678, 68.264770, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19371, 737.690551, -1019.648315, 73.780708, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 17049, "cuntwf", "ws_corrugated3", 0x00000000);
	houses_map = CreateDynamicObject(19371, 737.685546, -1019.656982, 73.780708, 0.000000, 180.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	houses_map = CreateDynamicObject(19457, 737.727722, -1007.815734, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 734.470275, -1003.987792, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 742.663330, -1008.718566, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 739.342712, -1005.018859, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 739.868041, -1004.109436, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 741.393493, -1001.467895, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 744.728576, -1005.141906, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 736.536010, -1000.411682, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 743.393615, -998.003723, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 740.141540, -994.167602, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 745.003845, -995.215087, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 748.343200, -998.902770, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 735.482727, -1011.704650, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 730.540222, -1010.794616, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19457, 733.802612, -1014.614624, 67.080734, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19371, 738.733581, -1015.525268, 67.070732, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 19308, "taxi01", "taxi01", 0x00000000);
	houses_map = CreateDynamicObject(19438, 754.947875, -1019.891418, 72.474784, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	SetDynamicObjectMaterial(houses_map, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	houses_map = CreateDynamicObject(19325, 731.576416, -1011.437500, 68.820724, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19325, 735.501708, -1004.638671, 68.820724, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19325, 737.622192, -1000.966613, 68.820724, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19325, 741.177551, -994.808898, 68.820724, 0.000000, 90.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 748.046020, -1016.429809, 73.664924, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 738.885864, -1025.360961, 77.994895, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 737.770935, -1027.292358, 76.454902, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 742.626281, -1028.362182, 75.584930, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(681, 748.438171, -1024.862792, 78.884826, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(760, 747.361999, -1024.086791, 78.634826, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(631, 738.071472, -1022.639770, 79.864845, 0.000000, 0.000000, 360.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19317, 758.012145, -1009.803710, 81.765625, 180.000000, 80.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2257, 738.616638, -1023.504882, 80.904808, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 756.752441, -1018.066101, 78.994819, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 760.153076, -1019.946655, 78.994819, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 750.470825, -1017.829956, 71.734916, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 752.401977, -1018.944946, 70.184928, -0.000003, 0.000006, -29.999994, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14387, 749.032348, -1020.360107, 69.754951, -0.000003, 0.000006, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2627, 764.923583, -1013.811462, 74.644813, 0.000000, 0.000000, -120.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2627, 764.213134, -1015.041564, 74.644813, 0.000000, 0.000000, -120.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2627, 763.492492, -1016.289062, 74.644813, 0.000000, 0.000000, -120.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2628, 762.043334, -1010.648681, 74.644813, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2628, 761.301086, -1012.033630, 74.644813, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2629, 762.419860, -1017.942138, 74.644813, 0.000000, 0.000000, -120.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1808, 762.806396, -1019.776489, 74.644813, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 743.629455, -1024.074218, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 744.729858, -1022.168762, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 746.135314, -1019.734924, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 750.569763, -1022.295593, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 748.482482, -1021.090332, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 752.234985, -1019.412170, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 753.500183, -1017.221252, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 754.690917, -1015.159545, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.716308, -1013.384094, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 756.846313, -1011.426818, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 752.561035, -1023.296386, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 754.226257, -1020.412963, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.491455, -1018.222045, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 756.682189, -1016.160339, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.707580, -1014.384887, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.837585, -1012.427612, 77.974815, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 756.976135, -1021.389648, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 759.011474, -1022.564941, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.626098, -1024.964111, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.595703, -1023.780273, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 742.505432, -1020.560729, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 745.240844, -1015.822998, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 748.514831, -1017.713867, 77.974815, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 761.597595, -1018.086791, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 762.797790, -1016.008178, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 763.973083, -1013.973144, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 759.546508, -1016.938110, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 760.771850, -1014.816223, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 761.926818, -1012.815673, 77.944816, 0.000012, 0.000007, 59.999977, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2855, 754.677856, -1022.441345, 79.974838, 0.000000, 0.000000, 121.399978, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 756.925109, -1010.250366, 74.644813, 0.000000, 0.000000, 14.999997, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 752.389770, -1018.026245, 74.654808, 0.000000, 0.000000, 13.199996, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(638, 742.042846, -1021.709960, 75.304817, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1808, 756.333251, -1017.805725, 74.644813, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19999, 758.965515, -1020.347351, 74.654808, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 756.164672, -1021.657470, 74.634811, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 755.634277, -1022.575805, 74.634811, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 755.134338, -1023.441650, 74.634811, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 758.070678, -1025.137451, 74.634811, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 758.556030, -1024.297363, 74.634811, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1714, 759.096191, -1023.361816, 74.634811, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 761.664794, -1021.373535, 74.654808, 0.000000, 0.000000, 14.300000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 756.759094, -1018.469909, 74.644813, 0.000000, 0.000000, 18.600004, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 752.956359, -1019.661193, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 751.170959, -1022.753173, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 743.748901, -1018.467468, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 740.973327, -1023.274169, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 736.443847, -1020.658752, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 746.953491, -1020.317687, 74.041061, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(810, 744.997497, -1021.799133, 68.804779, 0.000000, 0.000000, 68.399986, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(847, 744.869079, -1022.663208, 70.594810, 0.000000, 0.000000, -155.999938, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2257, 741.848388, -1018.902038, 71.314765, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2010, 743.311767, -1017.056274, 68.804779, 0.000000, 0.000000, 8.699997, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2392, 756.150268, -1020.545837, 73.014846, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2399, 759.531250, -1023.118652, 72.854789, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2389, 760.157897, -1023.466552, 72.854789, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2386, 760.694641, -1022.880004, 71.744766, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2386, 760.027709, -1022.494628, 71.744766, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2704, 755.667846, -1020.201965, 73.004798, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2704, 755.494506, -1020.101867, 73.004798, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19624, 756.571411, -1020.651489, 72.124778, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(355, 756.272338, -1021.283813, 72.024803, 180.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(355, 756.229003, -1021.258789, 72.024803, 180.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(355, 756.194335, -1021.238769, 72.024803, 180.000000, 90.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(359, 755.561584, -1020.791931, 71.704780, 90.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(359, 755.549926, -1020.678955, 71.707397, 72.900032, 5.799999, 330.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19832, 755.036376, -1020.122802, 71.734779, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19832, 755.241577, -1019.767517, 71.734779, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19832, 755.126464, -1019.966857, 71.954750, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2064, 750.940429, -997.840026, 69.390693, 0.000000, 0.000000, 270.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19325, 759.482482, -1021.632812, 70.744804, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2694, 760.767761, -1022.808837, 73.684791, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2654, 759.852783, -1023.311767, 71.924781, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19325, 757.109069, -1020.262329, 70.774772, 90.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1829, 764.574584, -1015.340881, 71.204780, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.586425, -1026.336791, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 750.848449, -1022.446105, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 752.995971, -1023.686035, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.534118, -1025.151611, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 748.191528, -1022.506042, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 741.549377, -1018.671081, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 743.965942, -1020.067077, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 746.157165, -1021.332702, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 748.181396, -1024.927246, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 746.007446, -1023.671875, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 739.444091, -1022.317016, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 744.570129, -1022.841796, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 740.859436, -1029.267944, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 742.709655, -1026.063354, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 742.629760, -1021.721557, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 740.708312, -1025.047851, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 738.888366, -1028.200073, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 742.664672, -1016.739501, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 745.106994, -1018.149475, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 747.237487, -1019.379577, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 749.307189, -1020.574707, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 753.083251, -1021.416137, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 759.183654, -1010.850891, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.043334, -1014.557983, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.293518, -1017.588806, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 760.879882, -1020.815490, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 762.604736, -1017.828002, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 764.729736, -1014.147644, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.708984, -1024.575195, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.894409, -1022.950073, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 756.260620, -1020.655273, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.183227, -1021.765563, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 763.318420, -1012.870910, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 760.042785, -1018.543457, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 761.587951, -1015.867309, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 759.422790, -1014.617065, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 761.133117, -1011.654968, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.862182, -1017.317993, 82.274787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(14705, 752.479797, -1019.179443, 81.184806, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2630, 760.327331, -1013.612182, 74.644813, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2915, 753.451110, -1017.438781, 80.164787, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19623, 752.894165, -1018.526428, 80.584846, 0.000000, 0.000000, 32.599998, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2854, 753.709533, -1017.243713, 80.494834, 0.000000, 0.000000, 420.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(359, 753.124755, -1017.892517, 81.072334, 13.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19200, 752.534057, -1019.140686, 80.104804, -160.100021, 90.299995, 58.799999, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.718994, -1014.397827, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 760.970764, -1015.697998, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 763.410644, -1015.513366, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.521362, -1012.112854, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.895874, -1014.927551, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 761.785522, -1018.328613, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.823608, -1016.618713, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.763000, -1018.455078, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 760.742187, -1020.175231, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 754.827026, -1016.759948, 74.044792, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2241, 758.026916, -1015.123046, 71.204795, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2241, 760.694702, -1016.663146, 71.204795, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2259, 764.785888, -1015.079528, 72.334800, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2811, 767.295043, -1013.288818, 78.974822, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2811, 762.649169, -1021.334045, 78.974822, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2244, 737.118103, -1029.494506, 76.844810, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2244, 740.625915, -1031.520141, 76.844810, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1670, 761.256042, -1014.413513, 79.480781, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2344, 758.163269, -1017.748901, 79.484794, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(11745, 764.863891, -1015.975585, 70.900756, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(11743, 756.678649, -1027.013549, 80.024787, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1670, 756.487670, -1023.092285, 80.054801, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2500, 754.604675, -1026.067749, 80.024757, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2683, 755.880615, -1026.817749, 80.154777, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19568, 752.073120, -1024.377685, 80.034805, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19568, 752.298461, -1024.507812, 80.034805, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19568, 752.073120, -1024.377685, 80.184806, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2222, 757.945068, -1024.402343, 80.114814, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2855, 744.677368, -1023.506958, 79.050758, 0.000000, 0.000000, 180.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1808, 745.949768, -1017.320190, 79.004814, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2404, 740.972229, -1016.666564, 80.804779, 0.000000, 22.800010, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2406, 741.470214, -1015.764648, 80.794799, 0.000000, 20.800003, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2811, 756.289672, -1026.760864, 70.750778, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2245, 754.549743, -1021.146118, 72.030746, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2245, 758.126892, -1023.211669, 72.030746, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 754.009826, -1024.309570, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 757.630432, -1026.399780, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 758.635620, -1024.658935, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.060302, -1022.490478, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 756.940063, -1023.575683, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(957, 755.894653, -1025.385864, 74.070793, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2061, 753.417968, -1025.197509, 71.920776, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2061, 758.529968, -1008.708740, 81.864814, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(11707, 759.740966, -1023.826660, 72.280761, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(11707, 753.752929, -1021.917480, 72.280761, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2227, 756.828552, -1021.872558, 70.980751, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19824, 758.003112, -1027.947875, 71.550773, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19819, 757.752014, -1027.871948, 71.630722, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19819, 757.832092, -1027.733276, 71.630722, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19820, 758.105041, -1027.752563, 71.540702, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(18976, 757.964233, -1009.757690, 80.430763, 0.000000, 0.000000, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(18645, 758.341003, -1008.988769, 80.400337, 0.000000, -20.699998, -30.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2102, 758.244445, -1009.415161, 79.434783, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1569, 738.298889, -1020.043395, 68.804779, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 728.373901, -1010.279357, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 732.344299, -1003.402893, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 734.444458, -999.765441, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 737.999694, -993.608093, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 744.105651, -997.133728, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 740.464782, -1003.438842, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 738.459655, -1006.911926, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1893, 734.573669, -1013.641418, 73.500709, 0.000006, 0.000003, 59.999988, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2690, 739.300170, -998.801086, 70.700706, 0.000000, 0.000000, 330.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(2690, 734.209838, -1007.617309, 70.700706, 0.000000, 0.000000, 510.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1083, 746.230529, -1008.445861, 71.980720, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1074, 747.442932, -1006.299804, 71.980728, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(1079, 745.023986, -1010.530151, 71.980720, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19899, 744.015563, -1011.414916, 68.830734, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19899, 746.585998, -1006.963745, 67.550758, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19899, 745.300964, -1009.189697, 67.550758, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19899, 747.870788, -1004.737915, 68.830734, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19903, 743.079101, -1013.169494, 68.810722, 0.000000, 0.000000, 150.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19921, 745.395202, -1008.331665, 69.740699, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19921, 745.395202, -1008.331665, 69.260734, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19900, 745.937744, -1001.874145, 68.790733, 0.000000, 0.000000, 60.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19815, 750.840087, -1000.644226, 71.170707, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19815, 741.364990, -1017.055175, 71.170707, 0.000000, 0.000000, 240.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(11745, 743.602905, -1011.824645, 70.230743, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);
	houses_map = CreateDynamicObject(19898, 732.400573, -1000.882934, 68.820732, 0.000000, 0.000000, 0.000000, 7, -1, -1, 600.00, 600.00);


	// Kuca - Crusher
	CreateDynamicObject(15054,111.00000000,44.09999847,1001.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2117,103.19999695,53.40000153,999.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2108,106.50000000,56.50000000,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1742,108.80000305,48.72999954,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1765,114.00000000,57.09999847,999.00000000,0.00000000,0.00000000,297.50000000); //
	CreateDynamicObject(1764,110.59999847,57.70000076,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2128,102.30000305,56.40000153,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2129,101.30000305,56.40000153,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2304,100.30000305,56.40000153,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2576,109.80000305,43.79999924,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2593,115.09999847,55.09999847,999.90002441,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1745,113.40000153,41.79999924,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2127,100.30000305,50.40000153,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2130,100.30000305,52.40000153,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2517,105.19999695,45.20000076,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2518,104.90000153,47.90000153,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2525,107.59999847,48.00000000,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2526,106.80000305,45.00000000,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2129,100.30000305,55.40000153,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2129,100.30000305,54.40000153,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2304,100.30000305,49.40000153,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2129,101.30000305,49.40000153,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2129,102.30000305,49.40000153,999.00000000,0.00000000,0.00000000,179.99450684); //
	CreateDynamicObject(2128,103.30000305,49.40000153,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1720,103.19999695,54.79999924,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1720,101.90000153,53.20000076,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1720,101.90000153,52.50000000,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1720,103.19999695,51.00000000,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1720,104.59999847,52.50000000,999.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1720,104.59999847,53.20000076,999.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1765,108.90000153,56.40000153,999.00000000,0.00000000,0.00000000,47.99877930); //
	CreateDynamicObject(2315,110.90000153,55.90000153,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1750,114.90000153,49.00000000,999.50000000,0.00000000,0.00000000,191.75000000); //
	CreateDynamicObject(1765,114.59999847,51.59999847,999.00000000,0.00000000,0.00000000,348.49877930); //
	CreateDynamicObject(1765,112.80000305,50.90000153,999.00000000,0.00000000,0.00000000,31.49877930); //
	CreateDynamicObject(2321,115.19999695,49.20000076,999.00000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2028,113.90000153,49.29999924,999.59997559,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2741,106.00000000,48.40000153,1000.09997559,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2742,104.69999695,48.29999924,1000.09997559,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1506,123.50000000,52.09999847,997.53002930,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1502,111.12560272,48.70000076,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1502,113.11199951,44.37599945,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1502,109.69999695,47.35490036,999.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2108,115.30000305,38.70000076,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1555,116.00000000,45.79999924,999.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2816,111.00000000,55.90000153,999.50000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2852,112.30000305,55.90000153,999.50000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(631,115.09999847,48.00000000,999.90002441,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2001,116.59999847,51.20000076,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2001,116.50000000,54.50000000,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2010,105.19999695,49.50000000,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2011,110.50000000,38.79999924,999.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2247,111.59999847,56.09999847,1000.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2811,110.59999847,45.09999847,999.00000000,0.00000000,0.00000000,0.00000000); //
	
	
	// Complex v2 - Owen
	CreateDynamicObject(19364, 189.85130, 1844.62292, 1566.18835,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 191.54550, 1843.10803, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 188.15649, 1843.10803, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 187.04781, 1840.43018, 1566.18835,   0.00000, 0.00000, 135.00000);
	CreateDynamicObject(19364, 193.06450, 1841.41296, 1566.18835,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19364, 184.36980, 1839.31921, 1566.18835,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19364, 182.85350, 1837.62402, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 184.36980, 1835.92920, 1566.18835,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19364, 186.06551, 1834.41394, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 194.58051, 1839.71704, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 193.06450, 1838.02295, 1566.18835,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19364, 191.55029, 1836.32813, 1566.18835,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19364, 188.15759, 1829.53894, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 193.06270, 1834.63477, 1566.18835,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 191.55161, 1829.55701, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 193.06270, 1831.24780, 1566.18835,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 194.57829, 1832.94006, 1566.18835,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19364, 187.04820, 1832.21753, 1566.18835,   0.00000, 0.00000, 225.00000);
	CreateDynamicObject(2959, 189.12511, 1844.53149, 1564.43005,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19858, 194.50841, 1840.45752, 1565.68774,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19858, 194.50841, 1833.65955, 1565.68774,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19858, 182.93340, 1838.43555, 1565.68774,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1764, 190.94890, 1837.67004, 1564.42175,   0.00000, 0.00000, -93.00000);
	CreateDynamicObject(1486, 190.91490, 1838.04419, 1564.48792,   0.00000, 91.00000, 135.00000);
	CreateDynamicObject(1486, 190.31070, 1835.58789, 1564.48792,   0.00000, 91.00000, 98.00000);
	CreateDynamicObject(14762, 184.35490, 1835.06665, 1566.51343,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(1421, 186.86150, 1833.39075, 1565.18750,   0.00000, 0.00000, -62.00000);
	CreateDynamicObject(14762, 188.26801, 1847.03162, 1566.51343,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14762, 191.39500, 1846.97864, 1566.51343,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1349, 186.73450, 1835.27844, 1565.01172,   0.00000, 0.00000, 280.00000);
	CreateDynamicObject(1264, 183.46860, 1836.54285, 1564.79346,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 190.99519, 1828.57935, 1564.79346,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2675, 189.54761, 1832.91028, 1564.50195,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2675, 189.17360, 1839.79492, 1564.50391,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1442, 191.02609, 1834.95605, 1564.92993,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2670, 192.68840, 1840.08911, 1564.51965,   0.00000, 0.00000, -25.00000);
	CreateDynamicObject(2670, 184.48000, 1837.55981, 1564.51965,   0.00000, 0.00000, -25.00000);
	CreateDynamicObject(2670, 192.81528, 1832.76489, 1564.51965,   0.00000, 0.00000, -25.00000);
	CreateDynamicObject(1220, 186.91730, 1839.63525, 1564.75085,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(1220, 187.47227, 1840.22180, 1564.75085,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(924, 188.15141, 1840.78650, 1564.62866,   0.00000, 0.00000, 21.00000);
	CreateDynamicObject(19878, 186.41631, 1839.40735, 1564.80615,   0.00000, 62.00000, -45.00000);
	CreateDynamicObject(918, 187.47910, 1832.35205, 1564.79346,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2048, 191.44960, 1836.36938, 1566.77539,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2691, 187.11050, 1840.33020, 1566.47278,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(2696, 194.46690, 1831.73291, 1565.92944,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2693, 193.03090, 1841.49756, 1566.43713,   10.00000, 0.00000, 0.00000);
	CreateDynamicObject(14407, 189.80180, 1827.98486, 1564.74890,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19364, 193.06270, 1825.95093, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 189.85159, 1822.91992, 1569.68201,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19364, 192.53040, 1821.81152, 1569.68201,   0.00000, 0.00000, 225.00000);
	CreateDynamicObject(19364, 193.63760, 1819.13684, 1569.68201,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 195.33070, 1817.62195, 1569.68201,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 197.02460, 1819.13684, 1569.68201,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 198.71770, 1820.65112, 1569.68201,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 194.75861, 1827.46875, 1569.67700,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 196.45270, 1828.98474, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 198.15060, 1827.46875, 1569.67700,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 199.84370, 1825.95203, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 188.15759, 1826.33093, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 191.55161, 1826.34692, 1566.18835,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 188.15759, 1824.43689, 1569.68201,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 201.53860, 1827.46875, 1569.67700,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 203.23270, 1828.98474, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 204.92661, 1827.46875, 1569.67700,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 200.55820, 1821.28149, 1569.68201,   0.00000, 0.00000, 135.00000);
	CreateDynamicObject(19364, 206.44460, 1825.77478, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 207.96060, 1824.08081, 1569.67700,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 206.44460, 1822.38684, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 203.23360, 1822.38684, 1569.67700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18981, 189.67371, 1843.71521, 1568.43030,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18981, 182.22060, 1822.73169, 1577.12378,   0.00000, 45.00000, -90.00000);
	CreateDynamicObject(18981, 189.67371, 1816.50623, 1571.92456,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19364, 191.55161, 1829.55701, 1569.68054,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 191.55960, 1827.63684, 1569.68054,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 188.15759, 1829.53894, 1569.68054,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19364, 188.14760, 1826.33093, 1569.68054,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19858, 195.78300, 1828.91479, 1569.18164,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19858, 202.49800, 1828.91479, 1569.18164,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19858, 194.50011, 1817.69250, 1569.18860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19858, 207.85080, 1824.74731, 1569.20276,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(14762, 202.44279, 1820.76550, 1569.92334,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1369, 193.62570, 1821.44116, 1568.54480,   0.00000, 0.00000, 225.00000);
	CreateDynamicObject(2677, 196.16046, 1821.46594, 1568.22314,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2677, 202.50681, 1824.64172, 1568.22314,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 197.61520, 1828.65613, 1568.38757,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 194.21730, 1818.41077, 1568.38757,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1763, 200.78210, 1822.29456, 1567.92834,   0.00000, 0.00000, -135.00000);
	CreateDynamicObject(1421, 189.24200, 1823.41724, 1568.70605,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1362, 190.69521, 1823.36938, 1568.53564,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1349, 198.06650, 1821.36096, 1568.50964,   0.00000, 0.00000, 18.00000);
	CreateDynamicObject(2048, 199.79610, 1825.85242, 1570.42944,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1440, 199.91980, 1825.14429, 1568.46228,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1429, 198.97391, 1825.57031, 1568.76135,   -12.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 204.32895, 1828.42200, 1568.38757,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2691, 193.12550, 1825.83569, 1569.66882,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2692, 197.00211, 1819.16821, 1569.64075,   10.00000, 0.00000, -90.00000);
	CreateDynamicObject(2677, 191.58133, 1822.66602, 1568.22314,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2677, 196.20598, 1827.08667, 1568.22314,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 207.00842, 1823.03699, 1568.38757,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2695, 207.88560, 1825.22290, 1569.35876,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2047, 206.47050, 1825.67456, 1570.08374,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1582, 199.79185, 1821.92102, 1567.94861,   0.00000, 0.00000, 25.00000);
	CreateDynamicObject(1357, 193.33710, 1825.41882, 1568.21106,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19878, 194.54820, 1825.25745, 1568.02905,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(2696, 202.06400, 1828.87329, 1569.77185,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18981, 214.66170, 1816.50623, 1571.92456,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19447, 189.89481, 1839.75378, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 193.39380, 1839.75378, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 186.39680, 1839.75378, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 182.89880, 1839.75378, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 186.39680, 1830.11975, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 189.89481, 1830.11975, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 193.39380, 1830.11975, 1564.35303,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(19447, 192.85500, 1824.11414, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 192.85500, 1820.61707, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 192.85500, 1817.11707, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 196.36400, 1827.61316, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 202.48950, 1824.11414, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 202.48950, 1820.61414, 1567.85645,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 202.48950, 1827.61011, 1567.84436,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19447, 212.12151, 1824.11414, 1567.85645,   0.00000, 90.00000, 90.00000);
	
	// Complex - Javier
	CreateDynamicObject(14407,70.0000000,55.2000010,1001.8000000,0.0000000,0.0000000,90.0000000); //object(carter-stairs01) (1)
	CreateDynamicObject(19447,71.5996090,53.7001950,1001.4000000,0.0000000,90.0000000,0.0000000); //object(cs_detrok13) (1)
	CreateDynamicObject(19456,73.1999970,53.7000010,1003.2000000,0.0000000,0.0000000,0.0000000); //object(cs_detrok03) (1)
	CreateDynamicObject(19447,68.0999980,53.7000010,1001.4000000,0.0000000,90.0000000,180.0000000); //object(cs_detrok13) (2)
	CreateDynamicObject(19456,68.5000000,48.9000020,1003.2000000,0.0000000,0.0000000,270.0000000); //object(cs_detrok03) (2)
	CreateDynamicObject(19447,64.5996090,53.7001950,1001.4000000,0.0000000,90.0000000,359.9835200); //object(cs_detrok13) (3)
	CreateDynamicObject(19456,71.9000020,53.2000010,1003.2000000,0.0000000,0.0000000,270.0000000); //object(cs_detrok03) (3)
	CreateDynamicObject(19456,63.7998050,53.7001950,1003.2000000,0.0000000,0.0000000,0.0000000); //object(cs_detrok03) (4)
	CreateDynamicObject(19437,67.0996090,53.9003910,1003.2000000,0.0000000,0.0000000,0.0000000); //object(cs_landbit_50_a) (1)
	CreateDynamicObject(19456,71.8000030,54.5999980,1003.2000000,0.0000000,0.0000000,270.0000000); //object(cs_detrok03) (6)
	CreateDynamicObject(19456,71.9003910,57.2998050,1003.2000000,0.0000000,0.0000000,270.0000000); //object(cs_detrok03) (7)
	CreateDynamicObject(19447,64.5999980,63.2999990,1001.4000000,0.0000000,90.0000000,359.9890100); //object(cs_detrok13) (4)
	CreateDynamicObject(19447,64.5996090,63.2998050,1001.4000000,0.0000000,90.0000000,359.9890100); //object(cs_detrok13) (5)
	CreateDynamicObject(19447,68.0999980,63.2999990,1001.4000000,0.0000000,90.0000000,179.9945100); //object(cs_detrok13) (6)
	CreateDynamicObject(19447,71.5999980,63.2999990,1001.4000000,0.0000000,90.0000000,0.0000000); //object(cs_detrok13) (7)
	CreateDynamicObject(19456,63.7999990,63.2999990,1003.2000000,0.0000000,0.0000000,0.0000000); //object(cs_detrok03) (8)
	CreateDynamicObject(19456,68.2001950,62.0996090,1003.2000000,0.0000000,0.0000000,0.0000000); //object(cs_detrok03) (9)
	CreateDynamicObject(19393,65.5000000,57.2998050,1003.2000000,0.0000000,0.0000000,270.0000000); //object(land_34_sfw) (1)
	CreateDynamicObject(19447,73.5996090,58.0000000,1004.9000000,0.0000000,90.0000000,359.9835200); //object(cs_detrok13) (8)
	CreateDynamicObject(19437,67.7998050,57.2998050,1006.7000000,0.0000000,179.9945100,90.0000000); //object(cs_landbit_50_a) (2)
	CreateDynamicObject(19437,69.4000020,57.2999990,1006.7000000,0.0000000,179.9945100,90.0000000); //object(cs_landbit_50_a) (3)
	CreateDynamicObject(19437,71.0000000,57.2998050,1006.7000000,0.0000000,179.9945100,90.0000000); //object(cs_landbit_50_a) (4)
	CreateDynamicObject(19447,77.0996090,58.0000000,1004.9000000,0.0000000,90.0000000,179.9835200); //object(cs_detrok13) (9)
	CreateDynamicObject(19437,71.9000020,53.9000020,1006.7000000,0.0000000,179.9945100,0.0000000); //object(cs_landbit_50_a) (5)
	CreateDynamicObject(19456,67.0000000,54.5996090,1006.7000000,0.0000000,179.9945100,270.0000000); //object(cs_detrok03) (12)
	CreateDynamicObject(19456,76.5000000,53.0999980,1006.7000000,0.0000000,179.9945100,270.0000000); //object(cs_detrok03) (13)
	CreateDynamicObject(19447,73.5999980,67.5999980,1004.9000000,0.0000000,90.0000000,359.9890100); //object(cs_detrok13) (10)
	CreateDynamicObject(19447,77.0999980,67.5999980,1004.9000000,0.0000000,90.0000000,179.9890100); //object(cs_detrok13) (11)
	CreateDynamicObject(19456,76.0000000,56.7001950,1006.7000000,0.0000000,179.9945100,0.0000000); //object(cs_detrok03) (14)
	CreateDynamicObject(19456,71.7998050,62.0000000,1006.7000000,0.0000000,179.9945100,0.0000000); //object(cs_detrok03) (15)
	CreateDynamicObject(1493,69.5996090,49.0000000,1001.5000000,0.0000000,0.0000000,0.0000000); //object(gen_doorshop01) (1)
	CreateDynamicObject(1347,64.5000000,49.5999980,1002.1000000,0.0000000,0.0000000,0.0000000); //object(cj_wastebin) (1)
	CreateDynamicObject(918,72.6999970,49.2999990,1001.9000000,0.0000000,0.0000000,160.0000000); //object(cj_flame_drum) (1)
	CreateDynamicObject(1217,72.6999970,52.5999980,1001.9000000,0.0000000,0.0000000,0.0000000); //object(barrel2) (1)
	CreateDynamicObject(1647,64.4473650,51.5960310,1001.7552000,0.0000000,0.0000000,0.0000000); //object(lounge_wood_dn) (1)
	CreateDynamicObject(2260,66.5000000,54.2000010,1003.4000000,0.0000000,35.0000000,270.0000000); //object(frame_slim_1) (1)
	CreateDynamicObject(17969,69.9000020,53.0000000,1003.1000000,0.0000000,0.0000000,90.0000000); //object(hub_graffitti) (1)
	CreateDynamicObject(19456,66.1999970,66.0000000,1003.2000000,0.0000000,0.0000000,270.0000000); //object(cs_detrok03) (9)
	CreateDynamicObject(19456,76.0000000,66.2998050,1006.7000000,0.0000000,179.9945100,0.0000000); //object(cs_detrok03) (14)
	CreateDynamicObject(19456,75.3000030,66.5000000,1006.7000000,0.0000000,179.9945100,270.0000000); //object(cs_detrok03) (15)
	CreateDynamicObject(2911,68.0999980,60.7000010,1001.5000000,0.0000000,0.0000000,270.0000000); //object(kmb_petroldoor) (1)
	CreateDynamicObject(2911,68.0999980,64.1999970,1001.5000000,0.0000000,0.0000000,270.0000000); //object(kmb_petroldoor) (2)
	CreateDynamicObject(2911,63.9000020,63.2000010,1001.5000000,0.0000000,0.0000000,90.0000000); //object(kmb_petroldoor) (3)
	CreateDynamicObject(2911,63.9000020,59.5000000,1001.5000000,0.0000000,0.0000000,90.0000000); //object(kmb_petroldoor) (4)
	CreateDynamicObject(1721,67.6999970,57.7999990,1001.5000000,0.0000000,0.0000000,55.9918210); //object(est_chair1) (1)
	CreateDynamicObject(1810,67.6999970,65.0999980,1001.5000000,0.0000000,0.0000000,325.9973100); //object(cj_foldchair) (1)
	CreateDynamicObject(1810,66.1999970,65.5000000,1001.5000000,0.0000000,0.0000000,57.9968260); //object(cj_foldchair) (2)
	CreateDynamicObject(1721,64.0999980,62.5000000,1001.8000000,0.0000000,90.0000000,295.9973100); //object(est_chair1) (2)
	CreateDynamicObject(1369,75.3000030,54.0000000,1005.6000000,0.0000000,0.0000000,201.9981700); //object(cj_wheelchair1) (1)
	CreateDynamicObject(1357,64.7001950,65.2998050,1001.8000000,0.0000000,0.0000000,31.9976810); //object(cj_fruitcrate3) (1)
	CreateDynamicObject(1265,72.6999970,51.5999980,1002.0000000,0.0000000,0.0000000,0.0000000); //object(blackbag2) (1)
	CreateDynamicObject(2670,65.5999980,50.5999980,1001.6000000,0.0000000,0.0000000,320.0000000); //object(proc_rubbish_1) (1)
	CreateDynamicObject(2673,66.8000030,65.0999980,1001.6000000,0.0000000,0.0000000,0.0000000); //object(proc_rubbish_5) (1)
	CreateDynamicObject(2674,74.3000030,54.2999990,1005.0000000,0.0000000,0.0000000,0.0000000); //object(proc_rubbish_2) (1)
	CreateDynamicObject(1428,72.6999970,50.5999980,1003.1000000,0.0000000,0.0000000,270.0000000); //object(dyn_ladder) (1)
	CreateDynamicObject(1747,68.0999980,62.0000000,1001.9000000,90.0000000,0.0000000,303.9971900); //object(low_tv_2) (1)
	CreateDynamicObject(1778,72.3000030,58.0000000,1005.0000000,0.0000000,0.0000000,270.0000000); //object(cj_mop_pail) (1)
	CreateDynamicObject(1808,72.0000000,66.0999980,1005.2000000,0.0000000,90.0000000,346.0000000); //object(cj_watercooler2) (1)
	CreateDynamicObject(1840,64.0999980,56.9000020,1001.5000000,0.0000000,0.0000000,146.0000000); //object(speaker_2) (1)
	CreateDynamicObject(2146,75.3000030,65.0999980,1005.5000000,0.0000000,0.0000000,0.0000000); //object(cj_trolly1) (1)
	CreateDynamicObject(2819,64.9000020,51.5999980,1001.5000000,0.0000000,0.0000000,18.0000000); //object(gb_bedclothes01) (1)
	CreateDynamicObject(1440,67.6999970,49.7000010,1002.0000000,0.0000000,0.0000000,180.0000000); //object(dyn_box_pile_3) (1)
	CreateDynamicObject(2911,71.9000020,64.5999980,1005.0000000,0.0000000,0.0000000,270.0000000); //object(kmb_petroldoor) (5)
	CreateDynamicObject(2911,71.9000020,59.7000010,1005.0000000,0.0000000,0.0000000,270.0000000); //object(kmb_petroldoor) (6)
	CreateDynamicObject(2911,75.9000020,60.2999990,1005.0000000,0.0000000,0.0000000,90.0000000); //object(kmb_petroldoor) (7)
	CreateDynamicObject(2911,75.9000020,55.9000020,1005.0000000,0.0000000,0.0000000,90.0000000); //object(kmb_petroldoor) (8)
	CreateDynamicObject(17969,73.3000030,53.4000020,1007.1000000,0.0000000,0.0000000,270.0000000); //object(hub_graffitti) (2)
	CreateDynamicObject(2725,73.4000020,53.7000010,1005.4000000,0.0000000,0.0000000,0.0000000); //object(lm_striptable) (1)
	CreateDynamicObject(1810,72.5000000,54.2000010,1005.0000000,0.0000000,0.0000000,135.9942600); //object(cj_foldchair) (3)
	CreateDynamicObject(1810,74.0000000,53.9000020,1005.0000000,0.0000000,0.0000000,199.9896200); //object(cj_foldchair) (4)
	CreateDynamicObject(1670,73.4000020,53.7999990,1005.8000000,0.0000000,0.0000000,0.0000000); //object(propcollecttable) (1)
	CreateDynamicObject(2056,74.0999980,66.4000020,1006.8000000,0.0000000,0.0000000,0.0000000); //object(cj_target6) (1)
	CreateDynamicObject(2916,66.8000030,57.5999980,1001.6000000,0.0000000,0.0000000,15.9960940); //object(kmb_dumbbell) (1)
	CreateDynamicObject(2943,75.5000000,58.7000010,1005.3000000,0.0000000,90.0000000,270.0000000); //object(kmb_atm2) (1)
	CreateDynamicObject(2961,71.9000020,58.0000000,1006.5000000,0.0000000,0.0000000,90.0000000); //object(fire_break) (1)
	CreateDynamicObject(19377,71.5000000,57.2999990,1008.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (2)
	CreateDynamicObject(19377,68.0996090,49.7998050,1004.8000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (3)
	CreateDynamicObject(19377,61.5999980,59.4000020,1004.8000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (4)
	CreateDynamicObject(19456,66.9000020,53.9000020,1006.7000000,0.0000000,179.9945100,180.0000000); //object(cs_detrok03) (12)
	CreateDynamicObject(19377,61.5999980,69.0000000,1004.8000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (5)
	CreateDynamicObject(19377,72.0999980,62.0999980,1004.8000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (6)
	CreateDynamicObject(19377,61.5999980,59.4000020,1004.9000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (8)
	CreateDynamicObject(1766,72.5000000,60.5000000,1005.0000000,0.0000000,0.0000000,86.5000000); //object(med_couch_1) (1)
	CreateDynamicObject(1764,64.4000020,53.7000010,1001.5000000,0.0000000,0.0000000,90.0000000); //object(low_couch_2) (1)
	CreateDynamicObject(1328,75.4000020,63.2000010,1005.3000000,0.0000000,90.0000000,262.0000000); //object(binnt10_la) (1)
	CreateDynamicObject(1527,75.9000020,63.0000000,1006.6000000,0.0000000,0.0000000,0.0000000); //object(tag_rollin) (1)
	CreateDynamicObject(1529,75.9000020,58.4000020,1006.7000000,15.0000000,0.0000000,0.0000000); //object(tag_temple) (1)
	CreateDynamicObject(1531,63.9000020,51.7999990,1003.3000000,0.0000000,0.0000000,180.0000000); //object(tag_azteca) (1)
	CreateDynamicObject(1528,66.0000000,65.9000020,1003.4000000,0.0000000,0.0000000,90.0000000); //object(tag_seville) (1)
	CreateDynamicObject(1490,68.0999980,61.9000020,1003.4000000,0.0000000,0.0000000,0.0000000); //object(tag_01) (1)
	CreateDynamicObject(19377,71.5000000,66.9000020,1008.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (2)
	CreateDynamicObject(2670,71.3000030,51.5999980,1001.6000000,0.0000000,0.0000000,300.0000000); //object(proc_rubbish_1) (2)
	CreateDynamicObject(2671,65.4000020,61.2000010,1001.5000000,0.0000000,0.0000000,0.0000000); //object(proc_rubbish_3) (1)
	CreateDynamicObject(2672,74.6999970,65.0000000,1005.3000000,0.0000000,0.0000000,336.0000000); //object(proc_rubbish_4) (1)
	CreateDynamicObject(2673,74.8000030,59.5000000,1005.1000000,0.0000000,0.0000000,0.0000000); //object(proc_rubbish_5) (2)
	CreateDynamicObject(2673,65.6999970,54.7999990,1001.6000000,0.0000000,0.0000000,0.0000000); //object(proc_rubbish_5) (3)
	
	// Woods Cabin #2 - Unknown
	CreateDynamicObject(19458,2360.3442400,-656.7186300,127.0000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19362,2360.8129900,-650.3195800,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19362,2360.8212900,-647.1785900,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19362,2364.2727100,-650.3200100,126.9600000,0.0000000,-80.0000000,0.0000000); //
	CreateDynamicObject(19362,2364.2788100,-647.1696800,126.9600000,0.0000000,-80.0000000,0.0000000); //
	CreateDynamicObject(19458,2355.5947300,-661.4653900,127.0000000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(19458,2344.6115700,-656.6513700,127.0000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19366,2349.2270500,-661.4650300,127.0000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19366,2346.1001000,-661.4650300,127.0000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19366,2344.6140100,-650.2556200,127.0000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19366,2344.6140100,-647.1062000,127.0000000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19458,2349.3425300,-645.5871000,127.0000000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(19366,2355.6787100,-645.5860000,127.0000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19366,2358.8186000,-645.5860000,127.0000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19362,2357.3400900,-650.3195800,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19362,2353.8601100,-650.3195800,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19362,2357.3400900,-647.1785900,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19362,2353.8798800,-647.1757200,127.2600000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19376,2354.9951200,-656.7180800,128.6640000,0.0000000,-90.0000000,0.0000000); //
	CreateDynamicObject(19452,2348.0061000,-656.7180800,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2350.1770000,-651.1062000,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2350.1760300,-649.5058000,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2350.1760300,-647.9058200,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2350.1760300,-646.3258100,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2346.6923800,-646.3258100,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2346.6923800,-647.9090000,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2346.6926300,-649.5100700,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2346.6926300,-651.1101100,128.6640000,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19433,2345.4672900,-659.6660200,128.6640000,0.0000000,90.0000000,-90.0000000); //
	CreateDynamicObject(19433,2345.4699700,-656.1649800,128.6640000,0.0000000,90.0000000,-90.0000000); //
	CreateDynamicObject(19433,2345.4699700,-653.6229200,128.6599000,0.0000000,90.0000000,-90.0000000); //
	CreateDynamicObject(19433,2345.4099100,-650.1364700,128.6599000,0.0000000,90.0000000,-90.0000000); //
	CreateDynamicObject(19433,2345.3896500,-647.3231800,128.6599000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19367,2352.0197800,-647.2656900,127.0008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2352.0197800,-650.3200100,127.0008000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2353.6562500,-651.8612700,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2356.8569300,-651.8640100,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2358.8168900,-651.8640100,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2358.8173800,-645.7627600,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2355.6357400,-645.7630000,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2353.0000000,-645.7630000,127.0008000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19459,2349.4641100,-645.6149900,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2355.8718300,-645.6144400,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2358.8173800,-645.6149900,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19413,2344.6284200,-656.7614100,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2344.6262200,-653.5894800,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19413,2344.6284200,-650.4000200,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2344.6262200,-647.1890300,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2344.6262200,-659.8895300,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19367,2346.2263200,-661.4086300,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19413,2349.3718300,-661.4079000,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2352.4462900,-661.4086300,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2346.2263200,-661.4086300,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2354.6999500,-661.4080200,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19413,2356.1897000,-659.8288000,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19395,2356.1897000,-656.6239000,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19413,2356.1897000,-653.4301800,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19459,2355.6037600,-651.8649900,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19395,2352.0190400,-648.7979100,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.0190400,-646.4813200,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.0207500,-651.1425200,130.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19395,2346.1606400,-651.8649900,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19367,2349.3298300,-651.8649900,130.4800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19440,2350.7192400,-648.7811900,128.3999900,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2351.0791000,-648.7811900,128.1000100,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2351.4589800,-648.7811900,127.8000000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2351.8190900,-648.7811900,127.4800000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.3789100,-648.7819800,126.7200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.7390100,-648.7819800,126.4200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2353.1189000,-648.7819800,126.1200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2353.4790000,-648.7819800,125.8000000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2353.3188500,-648.7819800,125.8000000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2353.2587900,-648.7819800,125.8000000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.9589800,-648.7819800,126.1200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.8588900,-648.7819800,126.1200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.5588400,-648.7819800,126.3000000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2352.1989700,-648.7819800,126.6200000,180.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19440,2359.0825200,-652.7000100,128.3999900,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2359.4025900,-652.7000100,128.2200000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2359.7224100,-652.7000100,128.0399900,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2360.0625000,-652.7000100,127.8600000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2360.4226100,-652.7000100,127.6800000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2360.7624500,-652.7000100,127.5000000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2361.1025400,-652.7000100,127.3200000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2361.4226100,-652.7000100,127.1400000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19440,2361.7224100,-652.7000100,126.9600000,0.0000000,270.0000000,0.0000000); //
	CreateDynamicObject(19466,2356.2251000,-653.5009200,130.7881000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19466,2356.1794400,-659.9533100,130.7881000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19466,2344.6088900,-656.7309000,130.7881000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19466,2344.6142600,-650.4127200,130.7881000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19466,2349.4191900,-661.4204100,130.7881000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1491,2356.2033700,-657.3809800,128.7400100,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1491,2352.0258800,-649.5376600,128.7400100,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19865,2360.3501000,-656.0238000,127.8835000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19865,2360.3488800,-658.9190100,127.8835000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19865,2357.8393600,-661.4295700,127.8835000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(17951,2360.4868200,-648.7407800,130.6045100,0.0000000,85.0000000,180.0000000); //
	CreateDynamicObject(19377,2349.7919900,-656.6771900,132.1499900,0.0000000,90.0000000,0.0000000); //
	CreateDynamicObject(19435,2355.4572800,-659.7465800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19435,2355.4514200,-656.2680100,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19435,2355.4448200,-653.6107800,132.1479900,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2346.1499000,-650.1190200,132.1499900,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2346.1499000,-647.2899800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2349.3000500,-647.2899800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2352.5000000,-647.2899800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2355.6999500,-647.2899800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2358.8139600,-647.2899800,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2349.3000500,-650.6500200,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2352.5000000,-650.6500200,132.1490000,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2355.6855500,-650.2000100,132.1479900,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19362,2358.8139600,-650.1699800,132.1479900,0.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(19440,2360.2717300,-650.1558800,131.4200000,90.0000000,270.0000000,90.0000000); //
	CreateDynamicObject(19440,2360.2690400,-647.2758800,131.4200000,90.0000000,90.0000000,90.0000000); //
	CreateDynamicObject(2114,2359.8383800,-651.3427700,127.4862000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2559,2345.0913100,-650.9478100,130.0099900,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(11724,2346.8845200,-661.0410200,129.2588000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(11728,2356.1599100,-655.4241900,130.4864000,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(1491,2345.3891600,-651.8592500,128.7400100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19815,2356.2319300,-651.7899800,128.5945000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(19900,2352.4748500,-646.1851200,127.3467000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19900,2352.4751000,-646.8234900,127.3467000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19900,2352.4751000,-647.4635000,127.3467000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19921,2352.6823700,-647.3956300,128.3006000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19878,2352.2866200,-651.2291900,127.7672000,0.0000000,70.0000000,0.0000000); //
	CreateDynamicObject(19621,2352.4785200,-646.6809100,128.3204000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19622,2352.2258300,-650.6502100,128.0674000,10.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(15036,2346.2102100,-647.9282800,129.8970000,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(19807,2347.4135700,-646.1353800,129.8131900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19830,2345.1230500,-649.7368800,129.7475000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(11721,2349.6208500,-645.7996800,129.3695100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11721,2355.5788600,-645.8953200,128.0637800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2964,2352.9135700,-658.9783900,128.7512800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3004,2353.8569300,-658.8715200,130.2260000,-114.8400000,45.1800000,90.0000000); //
	CreateDynamicObject(2558,2355.7443800,-652.9329800,130.0019200,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(2558,2356.5039100,-653.8896500,130.0019100,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2238,2350.9843800,-652.4608800,129.6474000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(947,2363.4768100,-645.6620500,129.1401400,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1481,2356.8793900,-661.0026900,129.4414100,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1368,2357.8862300,-652.3696900,129.4521000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1281,2358.3737800,-658.5853900,129.5457000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2315,2350.2343800,-652.5040300,128.7499500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19786,2350.9856000,-652.3975200,129.9572000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2229,2352.7685500,-652.4368900,128.7494000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2229,2349.8273900,-652.4230300,128.7493700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1753,2351.9187000,-655.9989600,128.7498000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1754,2348.4646000,-654.7598300,128.7505000,0.0000000,0.0000000,130.0000000); //
	CreateDynamicObject(1754,2353.4296900,-655.1886600,128.7505000,0.0000000,0.0000000,230.0000000); //
	CreateDynamicObject(1823,2350.4777800,-654.5760500,128.6844000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2075,2355.9057600,-648.7843000,131.7353100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2559,2345.0905800,-657.2454200,130.0099900,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2559,2356.5034200,-660.3176300,130.0099900,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2559,2355.7233900,-659.3176300,130.0099900,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(2559,2356.5034200,-660.3176300,130.0099900,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2559,2344.2971200,-656.2757000,130.0099900,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(2559,2344.3046900,-649.9395800,130.0099900,0.0000000,0.0000000,270.0000000); //
	CreateDynamicObject(2226,2352.5002400,-646.3253200,128.2204000,0.0000000,0.0000000,50.0000000); //
	CreateDynamicObject(2828,2347.3418000,-661.0817300,129.7758000,0.0000000,0.0000000,-10.0000000); //
	CreateDynamicObject(19172,2353.0048800,-661.3256800,130.6608300,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1735,2346.0756800,-658.7292500,128.7513000,0.0000000,0.0000000,30.0000000); //
	CreateDynamicObject(1735,2348.0141600,-658.8045700,128.7513000,0.0000000,0.0000000,-30.0000000); //
	CreateDynamicObject(11734,2356.8945300,-654.7489600,128.7487900,0.0000000,0.0000000,100.0000000); //
	CreateDynamicObject(1736,2346.8501000,-660.9962800,130.9895900,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(2868,2346.3354500,-661.1409300,129.7758900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2842,2346.3654800,-660.5501700,128.7310000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2559,2348.8369100,-661.7413900,130.0099900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2559,2349.9169900,-660.9480000,130.0099900,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1690,2347.4746100,-658.3527800,132.8927000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1691,2349.2861300,-648.8065200,132.6609000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19632,2346.8547400,-660.8931900,128.7598600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.3166500,-654.6416600,127.3711000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.3967300,-656.3090800,127.3711000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.2683100,-655.4402500,127.3711000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.2395000,-655.7937000,127.8708300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.1167000,-655.1168200,127.8708300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1463,2361.0656700,-655.3789700,128.2506300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1418,2356.9145500,-659.7305900,132.0357100,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1418,2356.9201700,-656.2299800,132.0357100,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1418,2356.9201700,-653.5499900,132.0357100,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1418,2358.3300800,-653.5499300,131.7860000,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1418,2358.3300800,-656.2299800,131.7860000,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1418,2358.3300800,-659.7299800,131.7860000,100.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1307,2358.8288600,-661.0883200,131.3669000,0.0000000,180.0000000,0.0000000); //
	CreateDynamicObject(2267,2348.3413100,-651.9843100,130.5817900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2195,2355.4914600,-652.3942300,129.3502000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2253,2344.9978000,-652.3511400,129.0260900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1594,2348.9511700,-649.0802000,129.2319000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2835,2348.4104000,-648.9701500,128.7400100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2835,2348.4077100,-649.8770100,128.7400100,0.0000000,0.0000000,0.0000000); //
	
	// Mansion interior
	
	houses_map = CreateDynamicObject(19464, 1405.207397, -33.613407, 1002.462768, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(8533, 1398.262939, -27.737220, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x99FFFFFF);
    houses_map = CreateDynamicObject(19465, 1408.885986, -39.483196, 1002.466857, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1408.059936, -36.473442, 1002.462768, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19465, 1405.205444, -27.753200, 1002.466857, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1405.207397, -21.813419, 1002.462768, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1405.207397, -15.883428, 1002.462768, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1404.448852, -13.053407, 1002.462768, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1398.519287, -13.053407, 1002.462768, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1395.659545, -10.183401, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1393.828491, -12.073407, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1392.158691, -10.183401, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1389.309814, -13.053407, 1002.462768, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1390.861206, -14.483410, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19465, 1390.864013, -20.393188, 1002.466857, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1390.861206, -26.333406, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1387.990478, -29.193433, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.070556, -29.193433, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1379.209106, -32.033454, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1379.209106, -37.963459, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.098999, -40.903476, 1002.462768, 0.000000, 0.000000, 630.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1388.019409, -40.903476, 1002.462768, 0.000000, 0.000000, 630.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19465, 1393.955200, -40.933197, 1002.466857, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1396.799316, -43.783443, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1408.720214, -42.383464, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1405.850463, -45.233531, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1401.389526, -45.233531, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1403.650146, -43.403530, 1002.462768, 0.000000, 0.000000, 990.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1398.549804, -42.373527, 1002.462768, 0.000000, 0.000000, 990.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1407.298950, -10.213409, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1411.720458, -10.213409, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1409.469726, -12.083415, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1414.560668, -13.063421, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1414.120239, -16.053432, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1416.971557, -18.913444, 1002.462768, 0.000000, 0.000000, 630.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1416.971557, -23.253446, 1002.462768, 0.000000, 0.000000, 630.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1415.000488, -21.093452, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1414.120239, -26.103460, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1416.971557, -28.973434, 1002.462768, -0.000007, 0.000000, -89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1416.971557, -33.313438, 1002.462768, -0.000007, 0.000000, -89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1415.000488, -31.153442, 1002.462768, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1414.120239, -36.243495, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1413.999267, -36.473442, 1002.462768, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1412.147216, -42.333473, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    houses_map = CreateDynamicObject(19465, 1390.613769, -20.393188, 1002.466857, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1414.087524, -39.563449, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    houses_map = CreateDynamicObject(2898, 1410.930053, -39.314888, 999.880126, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_marble", 0x99FFFFFF);
    houses_map = CreateDynamicObject(2898, 1414.999511, -39.314888, 999.880126, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_marble", 0x99FFFFFF);
    houses_map = CreateDynamicObject(2898, 1410.930053, -44.724834, 999.880126, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_marble", 0x99FFFFFF);
    houses_map = CreateDynamicObject(2898, 1414.999511, -44.714836, 999.880126, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_marble", 0x99FFFFFF);
    houses_map = CreateDynamicObject(19366, 1393.905029, -12.115483, 1002.980529, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1409.514648, -12.125480, 1002.980529, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1414.956054, -21.075504, 1002.980529, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1414.956054, -31.195491, 1002.980529, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1403.606201, -43.335498, 1002.980529, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19479, 1383.464233, -37.607269, 999.920166, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15055, "svlamid", "AH_flroortile3", 0x99FFFFFF);
    houses_map = CreateDynamicObject(1502, 1408.991943, -40.253929, 999.910156, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 18028, "cj_bar2", "GB_nastybar01", 0x00000000);
    houses_map = CreateDynamicObject(1502, 1390.770263, -19.633892, 999.910156, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 18028, "cj_bar2", "GB_nastybar01", 0x00000000);
    houses_map = CreateDynamicObject(1502, 1393.191040, -40.923912, 999.910156, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 18028, "cj_bar2", "GB_nastybar01", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1374.793945, -24.163324, 1005.040466, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1374.793945, -14.533329, 1005.060485, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1387.770263, -17.273464, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1381.839599, -17.273464, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.474243, -24.343328, 999.930053, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_stonefloor", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.474243, -14.723327, 999.930053, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_stonefloor", 0x00000000);
    houses_map = CreateDynamicObject(19465, 1409.146240, -39.483196, 1002.466857, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1412.230346, -36.573436, 1002.462768, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1390.610961, -26.333406, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1387.990478, -29.073431, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.070556, -29.073431, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(11313, 1386.119995, -17.391601, 1001.986145, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 9515, "bigboxtemp1", "ws_garagedoor3_white", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.264038, -24.163324, 1005.040466, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.264038, -14.563325, 1005.060485, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16640, "a51", "ws_stationfloor", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1397.794677, -20.743330, 1006.150878, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "AH_wdpanscum", 0xFF8C7B66);
    houses_map = CreateDynamicObject(19377, 1397.794677, -33.823314, 1006.160888, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "AH_wdpanscum", 0xFF8C7B66);
    houses_map = CreateDynamicObject(19456, 1395.793457, -27.261875, 1005.069641, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1405.413818, -27.261875, 1005.069641, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1392.462402, -33.823314, 1010.241027, 0.000000, -180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1403.113037, -33.823314, 1010.251037, 0.000000, -180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1397.791137, -28.923313, 1009.810607, 90.000000, -180.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1397.791137, -38.723331, 1009.810607, 90.000000, -180.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1397.791137, -25.573343, 1009.810607, 90.000000, -180.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1397.791137, -15.853355, 1009.810607, 90.000000, -180.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19377, 1403.113037, -20.703319, 1010.241027, 0.000000, -180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19456, 1390.793334, -20.721834, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1392.461059, -20.703319, 1010.241027, 0.000000, -180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0xFFBFAD99);
    houses_map = CreateDynamicObject(19456, 1395.793457, -14.191859, 1005.069641, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1395.793457, -10.701848, 1005.069641, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1405.401855, -14.191859, 1005.069641, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1404.793212, -20.721834, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -33.811859, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1404.794189, -33.811859, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1401.295776, -43.451927, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -43.441864, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1404.794189, -43.431880, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1408.295532, -41.261898, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1397.795166, -43.451927, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1394.294555, -43.451927, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.063110, -34.111934, 1003.797973, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.063110, -43.711933, 1003.788024, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1382.743774, -43.711933, 1005.478149, 0.000000, 180.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1382.743774, -34.081893, 1005.478332, 0.000000, 180.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1387.311523, -34.131889, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1383.809448, -34.131889, 1005.069641, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1384.229858, -40.691883, 1005.069641, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -27.641868, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -24.141885, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -20.671886, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -17.171882, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -13.701889, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -31.131868, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.062866, -34.621868, 1005.059631, 0.000014, 90.000000, 89.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1410.975708, -41.451904, 1003.589172, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "rest_wall4", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1414.475830, -41.451904, 1003.589172, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "rest_wall4", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1398.433227, -13.121053, 1001.640136, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3603, "bevmans01_la", "lasbevcit7", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1396.751953, -11.581046, 1001.960449, 90.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1400.131103, -11.581046, 1001.960449, 90.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1396.751953, -11.581046, 998.749267, 90.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1400.131103, -11.581046, 998.759948, 90.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1398.440917, -11.511026, 1003.500366, 0.000000, 270.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(1502, 1405.210815, -28.504827, 999.910156, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 18028, "cj_bar2", "GB_nastybar01", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1395.698486, -43.783443, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1395.698486, -49.713462, 1002.462768, 0.000000, 0.000000, 720.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1392.628051, -52.783458, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1389.778442, -55.643398, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1384.797973, -55.643398, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1381.948730, -52.783458, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.779418, -49.723453, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.779418, -43.813507, 1002.462768, 0.000000, 0.000000, 900.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1386.928100, -54.183418, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1388.009643, -40.913520, 1002.462768, 0.000000, 0.000000, 990.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1382.079956, -40.913520, 1002.462768, 0.000000, 0.000000, 990.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -42.781864, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -46.281867, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -49.781879, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1390.793334, -53.251876, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.163208, -42.781894, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.163208, -46.281913, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.163208, -49.781925, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19456, 1381.163208, -53.261928, 1005.049621, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14808, "lee_strip2", "Strip_Ceiling", 0x00000000);
    houses_map = CreateDynamicObject(19366, 1387.284667, -54.125488, 1002.980529, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15041, "bigsfsave", "windo_blinds", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1376.150512, -29.073431, 1002.462768, 0.000000, 0.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1374.964477, -24.343328, 999.930053, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_stonefloor", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1374.954467, -14.723327, 999.930053, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_stonefloor", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1375.910156, -17.273464, 1002.462768, 0.000000, 0.000000, 810.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1373.089477, -26.163444, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1373.089477, -20.263441, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_gs_libwall", 0x00000000);
    houses_map = CreateDynamicObject(11313, 1377.559692, -17.391601, 1001.986145, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 9515, "bigboxtemp1", "ws_garagedoor3_white", 0x00000000);
    houses_map = CreateDynamicObject(2176, 1397.694824, -20.705856, 1002.539123, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.766601, -20.984830, 1002.070922, 0.000001, 0.000007, 18.599996, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "StainedGlass", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1398.045288, -20.497997, 1002.340942, 0.000007, -0.000000, 110.099899, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.430053, -20.818405, 1002.631103, -0.000006, 0.000003, -52.400012, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "StainedGlass", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.706298, -20.240531, 1002.931213, 0.000000, -0.000007, 176.899948, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.300903, -20.644842, 1003.341308, -0.000007, 0.000000, -89.299957, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "StainedGlass", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.766601, -20.984830, 1003.711425, 0.000000, 0.000007, 18.599996, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.971435, -20.482198, 1004.080932, 0.000007, 0.000000, 120.899940, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "StainedGlass", 0x00000000);
    houses_map = CreateDynamicObject(3385, 1397.699340, -20.651002, 1006.069519, 180.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(19843, 1397.684326, -20.675888, 1001.150512, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1398.204833, -21.195901, 1001.180541, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1397.184570, -21.195901, 1001.180541, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1397.184570, -20.175888, 1001.180541, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1398.204467, -20.175888, 1001.180541, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19846, 1397.429931, -20.403129, 1004.371704, 0.000000, 0.000007, -134.399963, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(1953, 1386.547363, -34.545509, 1004.791259, 180.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(1953, 1386.547363, -36.035511, 1004.801269, 180.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -34.965141, 999.920166, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -32.635131, 999.920166, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -30.295148, 999.920166, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1390.909667, -37.873508, 1002.462768, 0.000000, 0.000000, 1080.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1411.720458, -10.213409, 1002.462768, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_wall", 0x00000000);
    houses_map = CreateDynamicObject(19464, 1389.549926, -37.853466, 1002.462768, 0.000000, 0.000000, 540.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14387, "dr_gsnew", "mp_gs_kitchwall", 0x00000000);
    houses_map = CreateDynamicObject(19429, 1390.230834, -34.974052, 1001.640014, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19429, 1390.230834, -34.964054, 1004.379577, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(1953, 1386.547363, -37.525489, 1004.801452, 180.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.774902, -36.123302, 1005.060363, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(19927, 1379.757812, -39.811164, 999.910156, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14581, "ab_mafiasuitea", "ab_wood01", 0x00000000);
    houses_map = CreateDynamicObject(19929, 1379.774414, -37.414749, 999.910156, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14581, "ab_mafiasuitea", "ab_wood01", 0x00000000);
    houses_map = CreateDynamicObject(19929, 1379.774414, -30.764755, 999.910156, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14581, "ab_mafiasuitea", "ab_wood01", 0x00000000);
    houses_map = CreateDynamicObject(2127, 1379.837158, -33.847286, 999.910156, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF909090);
    houses_map = CreateDynamicObject(2123, 1385.053955, -35.342681, 1000.510192, 0.000007, -0.000007, 179.999908, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1385.053955, -36.332794, 1000.510192, 0.000007, -0.000007, 179.999908, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1385.053955, -37.152740, 1000.510192, 0.000007, -0.000007, 179.999908, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1386.254028, -37.882843, 1000.510192, -0.000007, -0.000007, -89.999961, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1387.424072, -37.122711, 1000.510192, -0.000007, 0.000007, -0.000007, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1387.424072, -36.082061, 1000.510192, -0.000007, 0.000007, -0.000007, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1387.424072, -35.011993, 1000.510192, -0.000007, 0.000007, -0.000007, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2123, 1386.374023, -34.191680, 1000.510192, 0.000007, 0.000007, 89.999946, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(14804, 1383.702392, -40.295356, 1000.870239, 0.000000, 0.000000, -161.999984, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 2811, "gb_ornaments01", "GB_vase01", 0x00000000);
    houses_map = CreateDynamicObject(19429, 1386.581420, -34.313999, 1004.900207, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(1734, 1386.549316, -34.568550, 1003.210754, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(2257, 1384.021728, -29.375354, 1002.090270, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 19173, "samppictures", "samppicture3", 0x00000000);
    houses_map = CreateDynamicObject(2257, 1386.970458, -29.375354, 1002.090270, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 19173, "samppictures", "samppicture1", 0x00000000);
    houses_map = CreateDynamicObject(11717, 1386.268920, -30.059652, 999.910156, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(2108, 1384.693115, -30.262203, 999.910156, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(2108, 1387.733154, -30.262203, 999.910156, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(1734, 1386.549316, -36.038539, 1003.550720, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(1734, 1386.549316, -37.528511, 1003.880859, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(19087, 1386.555541, -34.555576, 1005.050048, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19087, 1386.555541, -34.555576, 1005.719787, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19087, 1386.555541, -36.035568, 1005.280273, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19087, 1386.555541, -37.525550, 1005.760498, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(2163, 1386.600708, -40.734737, 999.910156, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(2828, 1385.810546, -40.493774, 1000.840332, 0.000000, 0.000000, -20.100000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 4, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    houses_map = CreateDynamicObject(19377, 1385.774902, -26.543306, 1005.060363, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(14804, 1388.605102, -39.903793, 1000.870239, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 2811, "gb_ornaments01", "GB_vase01", 0x00000000);
    houses_map = CreateDynamicObject(19429, 1386.581420, -37.784008, 1004.900207, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -34.965141, 1004.960083, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -32.655143, 1004.960083, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1390.916503, -30.325143, 1004.960083, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(2176, 1397.694824, -33.815849, 1002.538452, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
    houses_map = CreateDynamicObject(3462, 1397.704223, -33.831531, 1002.700195, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(19478, 1380.096679, -33.274402, 1001.040100, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14526, "sweetsmain", "mp_CJ_BIG_TELLY1", 0x00000000);
    houses_map = CreateDynamicObject(19478, 1380.106689, -32.674427, 1001.150207, -11.100000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_apt1_pic3", 0x00000000);
    houses_map = CreateDynamicObject(19478, 1380.106689, -32.892890, 1000.802734, 14.499995, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_apt1_pic8", 0x00000000);
    houses_map = CreateDynamicObject(19478, 1380.106689, -33.142848, 1001.838867, -8.500000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14420, "dr_gsbits", "mp_apt1_pic7", 0x00000000);
    houses_map = CreateDynamicObject(19478, 1380.106689, -33.782901, 1001.277099, 8.699995, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14489, "carlspics", "AH_picture2", 0x00000000);
    houses_map = CreateDynamicObject(19825, 1384.565185, -40.752941, 1002.370788, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1654, "dynamite", "clock64", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(11706, 1379.768066, -35.067020, 999.910156, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF505050);
    houses_map = CreateDynamicObject(19482, 1397.694580, -21.640825, 999.920166, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x90202020);
    houses_map = CreateDynamicObject(19482, 1397.694580, -27.230833, 999.920166, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x90202020);
    houses_map = CreateDynamicObject(19482, 1397.694580, -32.830837, 999.920166, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3922, "bistro", "Marble2", 0x90202020);
    houses_map = CreateDynamicObject(11721, 1393.862304, -12.315416, 1000.640747, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(11721, 1403.583862, -43.165367, 1000.640747, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(1569, 1390.978881, -28.704252, 1001.670410, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18055, "genintsmlrst_split", "GB_restaursmll17a", 0x00000000);
    houses_map = CreateDynamicObject(1569, 1390.978881, -26.994243, 1001.510314, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18055, "genintsmlrst_split", "GB_restaursmll16a", 0x00000000);
    houses_map = CreateDynamicObject(1569, 1390.978881, -25.244255, 1001.670410, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18055, "genintsmlrst_split", "GB_restaursmll17b", 0x00000000);
    houses_map = CreateDynamicObject(2267, 1405.046508, -34.642997, 1002.320495, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14706, "labig2int2", "HS_art7", 0x00000000);
    houses_map = CreateDynamicObject(2267, 1405.046508, -32.272994, 1002.320495, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14706, "labig2int2", "HS_art5", 0x00000000);
    houses_map = CreateDynamicObject(2252, 1391.782714, -37.949687, 1000.999938, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 3, 1731, "cj_lighting", "CJ_PLANT_POT", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1398.204833, -34.305900, 1001.180541, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1397.184570, -34.305900, 1001.180541, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1397.184570, -33.285888, 1001.180541, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(19843, 1398.204467, -33.285888, 1001.180541, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
    houses_map = CreateDynamicObject(2167, 1408.648559, -41.433086, 999.900146, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(11724, 1409.597412, -36.071331, 1000.420410, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 14584, "ab_abbatoir01", "ab_ceiling1", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 14584, "ab_abbatoir01", "ab_ceiling1", 0xFF808080);
    houses_map = CreateDynamicObject(1828, 1409.699829, -34.062892, 999.880126, 0.000000, 0.000000, 9.899997, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(1735, 1408.399658, -32.222045, 999.900146, 0.000000, 0.000000, 44.200000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1735, 1411.427856, -32.582561, 999.900146, 0.000000, 0.000000, -39.999992, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1814, 1409.301147, -34.187068, 999.900146, 0.000000, 0.000000, -7.599998, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(2848, 1409.504516, -33.586166, 1000.420959, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(14455, 1405.513305, -21.278989, 1001.571289, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(14455, 1405.513305, -15.528985, 1001.571289, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(11721, 1414.758666, -21.115453, 1000.680603, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(11721, 1414.758666, -31.345478, 1000.680603, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(11721, 1409.566650, -12.325467, 1000.680603, 0.000000, 0.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(1709, 1409.658203, -20.039051, 999.900146, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1730, "cj_furniture", "CJ-COUCHL2", 0x00000000);
    houses_map = CreateDynamicObject(19786, 1413.550537, -17.219184, 1001.210693, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF606060);
    SetDynamicObjectMaterial(houses_map, 1, 14571, "chinese_furn", "ab_tv_noise", 0x00000000);
    houses_map = CreateDynamicObject(1445, 1413.591918, -17.961990, 1000.520446, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(1445, 1413.591918, -16.431966, 1000.520446, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1413.565429, -17.945804, 1001.160705, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19834, 1413.565429, -16.405782, 1001.160705, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19479, 1409.629882, -25.006719, 999.910156, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14803, "bdupsnew", "Bdup2_Rug", 0x00000000);
    houses_map = CreateDynamicObject(19474, 1409.574218, -26.088884, 1000.460266, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1410.834350, -26.811449, 1000.730102, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1410.834350, -25.451442, 1000.730102, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1410.383666, -24.316488, 1000.730102, 0.000006, 0.000003, 64.099967, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1408.992797, -24.386322, 1000.730102, 0.000006, -0.000003, 120.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1408.992797, -27.956338, 1000.730102, -0.000006, -0.000003, -115.899955, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1410.383666, -27.886505, 1000.730102, -0.000006, 0.000003, -58.999980, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(1739, 1408.093505, -26.161453, 1000.730102, 0.000000, -0.000007, 179.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(2357, 1413.129638, -26.134853, 1000.310424, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gym_floor6", 0x00000000);
    houses_map = CreateDynamicObject(19893, 1412.733154, -27.818626, 1000.720153, 0.000000, 0.000000, -143.999954, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 15054, "savesfmid", "cspornmag", 0x00000000);
    houses_map = CreateDynamicObject(2225, 1410.889038, -14.136539, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 2, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(3385, 1409.746826, -20.954597, 1004.990722, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(3385, 1409.746826, -31.184644, 1004.990722, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(2188, 1408.809692, -26.005558, 1000.971069, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 5, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 6, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 7, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 10, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(14826, 1378.731933, -21.205738, 1000.696044, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(14878, 1382.068115, -20.543523, 1000.756225, 58.100002, -89.999916, 2.599925, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 5422, "idlewood6_lae", "las69str2", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    houses_map = CreateDynamicObject(1942, 1382.410644, -22.393785, 1000.336120, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1716, "cj_seating", "bras2_base", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    houses_map = CreateDynamicObject(1942, 1382.370605, -22.393785, 1000.336120, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1716, "cj_seating", "bras2_base", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    houses_map = CreateDynamicObject(1962, 1382.426147, -22.394878, 1000.335632, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 19076, "xmastree1", "goldplate", 0x00000000);
    houses_map = CreateDynamicObject(1962, 1382.356079, -22.404878, 1000.345642, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 19076, "xmastree1", "goldplate", 0x00000000);
    houses_map = CreateDynamicObject(19348, 1382.440185, -22.381296, 1000.345886, 32.800003, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(1942, 1382.359985, -24.215637, 1000.336120, 0.000022, 0.000000, 88.299919, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1716, "cj_seating", "bras2_base", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    houses_map = CreateDynamicObject(1942, 1382.269897, -24.212965, 1000.336120, 0.000022, 0.000000, 88.299919, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1716, "cj_seating", "bras2_base", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    houses_map = CreateDynamicObject(1962, 1382.375488, -24.217189, 1000.335632, 0.000022, 0.000000, 88.299919, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 19076, "xmastree1", "goldplate", 0x00000000);
    houses_map = CreateDynamicObject(1962, 1382.255126, -24.223619, 1000.345642, 0.000022, 0.000000, 88.299919, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 19076, "xmastree1", "goldplate", 0x00000000);
    houses_map = CreateDynamicObject(19348, 1382.320068, -22.381296, 1000.345886, 32.800003, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19590, 1382.389160, -24.166788, 1000.376281, 0.000000, -0.000007, 178.299942, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(19590, 1382.229003, -24.162033, 1000.376281, 0.000000, -0.000007, 178.299942, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
    houses_map = CreateDynamicObject(18644, 1382.627197, -22.806852, 1000.996154, 0.000000, 90.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 8391, "ballys01", "CJ_blackplastic", 0x00000000);
    houses_map = CreateDynamicObject(18644, 1382.156738, -22.806852, 1000.996154, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 8391, "ballys01", "CJ_blackplastic", 0x00000000);
    houses_map = CreateDynamicObject(1942, 1382.299926, -24.213855, 1000.336120, 0.000022, 0.000000, 88.299919, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 1716, "cj_seating", "bras2_base", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 7103, "vgnplantgen", "metalwheel4_128", 0x00000000);
    houses_map = CreateDynamicObject(2256, 1409.299804, -37.668910, 1001.890258, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
    houses_map = CreateDynamicObject(2256, 1409.279785, -37.668910, 1001.890258, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
    houses_map = CreateDynamicObject(11732, 1412.636108, -38.241729, 999.910034, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 2, 14387, "dr_gsnew", "mp_gs_pooltiles", 0x00000000);
    houses_map = CreateDynamicObject(19477, 1412.813964, -37.602329, 1000.490295, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 19071, "wssections", "waterclear1", 0x00000000);
    houses_map = CreateDynamicObject(19477, 1412.813964, -38.992343, 1000.490295, 0.000000, 90.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 19071, "wssections", "waterclear1", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.128295, -48.707027, 1000.240417, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.128295, -45.227016, 1000.240417, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -45.227016, 1000.070251, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -48.717029, 1000.070251, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -48.717029, 999.900085, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -45.227054, 999.900085, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -48.717029, 1005.000610, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1385.398559, -45.217021, 1005.000610, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1382.846923, -45.217021, 1005.090576, 90.000000, 180.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(19447, 1382.846923, -48.697025, 1005.090576, 90.000000, 180.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    houses_map = CreateDynamicObject(2789, 1382.880371, -46.966865, 1002.926635, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 1, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
    houses_map = CreateDynamicObject(2789, 1382.860351, -46.966865, 1002.926635, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 10765, "airportgnd_sfse", "black64", 0x00000000);
    houses_map = CreateDynamicObject(11721, 1387.221801, -53.945323, 1000.640747, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    houses_map = CreateDynamicObject(19433, 1395.218872, -43.267951, 1000.950134, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.218872, -45.017982, 999.979858, 0.000007, 90.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.218872, -48.507991, 999.979858, 0.000007, 90.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.218872, -50.347965, 1000.940124, 0.000007, 0.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.629272, -49.497886, 1000.909606, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.629272, -47.927875, 1000.919616, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.629272, -46.327873, 1000.939636, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.629272, -44.147888, 1000.909545, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.609252, -45.127861, 1000.939636, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.218872, -48.507991, 1002.609741, 0.000007, 90.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    houses_map = CreateDynamicObject(19433, 1395.218872, -45.037979, 1002.609558, 0.000007, 90.000000, 89.999977, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    houses_map = CreateDynamicObject(19864, 1394.527099, -46.025085, 1002.530700, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10839, "aircarpkbarier_sfse", "glass_64a", 0x00000000);
    houses_map = CreateDynamicObject(19864, 1394.457031, -47.615036, 1002.530700, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10839, "aircarpkbarier_sfse", "glass_64a", 0x00000000);
    houses_map = CreateDynamicObject(14804, 1383.543457, -42.406978, 1000.870239, 0.000000, 0.000000, 138.799987, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 2811, "gb_ornaments01", "GB_vase01", 0x00000000);
    houses_map = CreateDynamicObject(14804, 1383.417114, -51.266662, 1000.870239, 0.000000, 0.000000, 138.799987, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(houses_map, 1, 2811, "gb_ornaments01", "GB_vase01", 0x00000000);
    houses_map = CreateDynamicObject(19479, 1383.464233, -31.067285, 999.920166, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 15055, "svlamid", "AH_flroortile3", 0x99FFFFFF);
    houses_map = CreateDynamicObject(19087, 1397.699462, -20.659566, 1004.375305, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19087, 1397.699462, -20.659566, 1006.805541, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1565, 1397.682739, -20.689937, 1001.430358, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19923, 1381.993164, -34.976181, 999.920166, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19924, 1382.000854, -34.958564, 1002.870849, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19937, 1379.543457, -38.897357, 1002.030212, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19937, 1379.543457, -36.997318, 1002.030212, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19937, 1379.543457, -30.297325, 1002.030212, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19935, 1379.543457, -31.745883, 1002.029968, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19936, 1379.822265, -40.311985, 1002.022521, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19933, 1379.614379, -35.661617, 1002.550354, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19922, 1386.309448, -35.999420, 999.910156, 0.000007, 0.000007, 89.999946, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19581, 1379.564208, -38.161735, 1001.890563, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19581, 1379.564208, -37.001731, 1001.890563, 90.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19584, 1379.610473, -38.607761, 1001.930847, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19586, 1379.512329, -37.779029, 1001.950256, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19586, 1379.512329, -36.679061, 1001.950256, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19583, 1379.510375, -37.356380, 1001.930847, 90.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19585, 1379.719116, -36.484088, 1001.030456, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19585, 1379.663208, -36.467247, 1001.138244, -13.500004, 0.000000, 13.899999, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19993, 1379.674438, -37.951515, 1000.810546, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19993, 1379.674438, -37.928943, 1000.861267, 10.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19579, 1379.791381, -31.888998, 1000.830688, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19579, 1379.979003, -31.685058, 1000.830688, 0.000000, 0.000000, 21.700002, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19571, 1379.685302, -31.158615, 1000.860473, 90.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19571, 1379.776245, -31.220922, 1000.910522, 90.000000, 55.499992, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19571, 1379.781127, -31.171150, 1000.960632, 90.000000, 84.499984, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19583, 1379.822998, -30.715173, 1000.840209, 0.000000, 0.000000, 29.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11743, 1379.784912, -38.531558, 1000.830139, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19572, 1379.727661, -30.069271, 1000.820556, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2149, 1379.723632, -37.418395, 1000.980468, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2863, 1379.773559, -40.340377, 1000.779785, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19874, 1379.981933, -40.132831, 1000.810302, 0.000000, 0.000000, 41.300003, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19937, 1381.243530, -40.567302, 1002.030212, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19940, 1381.167114, -40.564273, 1001.579162, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19940, 1381.167114, -40.564273, 1001.148986, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2864, 1380.735595, -40.578533, 1001.161743, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11718, 1381.416381, -40.559566, 1001.178527, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19830, 1379.649169, -30.893058, 1000.833374, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19873, 1380.346801, -40.469230, 1001.655639, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19873, 1380.496948, -40.609222, 1001.655639, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11722, 1380.738037, -40.572708, 1001.740905, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11723, 1380.925903, -40.525573, 1001.719238, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19823, 1381.240112, -40.518928, 1001.598693, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2813, 1381.759887, -40.531005, 1001.600769, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(938, 1381.974853, -31.873163, 1002.539855, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(938, 1381.974853, -38.103149, 1002.539855, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2870, 1386.260253, -36.003223, 1000.670227, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -32.649169, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -31.859182, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -31.059167, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -38.879131, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -38.089141, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19871, 1381.960815, -37.289131, 1003.710632, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19787, 1386.186523, -40.756248, 1001.580505, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2233, 1387.108642, -40.930507, 999.900146, 0.000000, 0.000000, -169.399978, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2233, 1384.518066, -40.722633, 999.900146, 0.000000, 0.000000, 161.900009, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19920, 1386.934936, -40.448997, 1000.840393, 5.199998, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19807, 1386.557983, -40.479583, 1000.890136, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2286, 1389.398803, -36.072158, 1002.020141, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2288, 1388.937622, -37.801445, 1000.950073, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2279, 1388.927001, -36.197643, 1000.850219, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2271, 1388.940673, -39.167785, 1002.520446, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2277, 1388.928222, -37.488506, 1002.740417, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2274, 1388.930541, -39.151790, 1001.210083, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2275, 1388.931030, -35.970279, 1002.910522, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19932, 1379.660034, -35.665039, 1001.900451, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1401.297973, -23.889087, 1005.900390, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1401.297973, -17.499071, 1005.900390, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1394.206176, -17.499071, 1005.900390, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1394.206176, -23.919122, 1005.900390, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1401.297973, -37.059089, 1005.900390, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1401.297973, -30.669071, 1005.900390, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1394.206176, -30.669071, 1005.900390, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2740, 1394.206176, -37.089122, 1005.900390, 0.000000, 0.000007, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2725, 1394.995361, -12.587449, 1000.300537, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2245, 1394.979370, -12.608980, 1001.040771, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(15038, 1392.738281, -12.806745, 1000.520141, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2248, 1404.438598, -13.749059, 1000.479736, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(862, 1404.457275, -13.763010, 1000.970275, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2115, 1399.207275, -41.596786, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2115, 1402.207519, -13.836793, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2869, 1402.790527, -13.829228, 1000.710021, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11746, 1401.977783, -14.174123, 1000.710449, 90.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11746, 1401.964111, -14.136561, 1000.710449, 90.000000, 20.100000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11746, 1401.966064, -14.156461, 1000.710449, 90.000000, 5.699996, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19807, 1402.049438, -13.754028, 1000.780273, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19828, 1400.778076, -13.170248, 1001.670654, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19828, 1389.422363, -35.103515, 1002.020507, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19828, 1382.549438, -29.323736, 1001.800598, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2986, 1391.010498, -13.805942, 1000.060424, 0.000000, 90.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2986, 1408.281372, -36.635940, 1000.060424, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19273, 1390.237304, -34.927928, 1001.720764, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2986, 1381.539550, -29.335901, 1000.460632, 0.000000, 90.000000, 450.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1615, 1379.348754, -34.795787, 1002.710571, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2256, 1405.070068, -23.099004, 1002.580322, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2261, 1404.586181, -17.260295, 1001.890502, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2289, 1391.020996, -15.922559, 1002.250610, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2285, 1391.479614, -14.450063, 1002.440673, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2254, 1405.058227, -20.532264, 1002.550109, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2264, 1404.583496, -15.957249, 1001.980285, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2240, 1391.649902, -38.607498, 1001.220458, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2248, 1391.611938, -40.317142, 1000.489868, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(948, 1402.342163, -42.744697, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(948, 1404.912719, -42.744697, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2243, 1392.048950, -39.639793, 1000.119934, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(630, 1397.664794, -41.345397, 1000.919982, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2031, 1391.703369, -38.965309, 999.910156, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2868, 1400.087280, -41.786640, 1000.710144, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(14705, 1399.354003, -41.584682, 1000.930175, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2816, 1400.073608, -41.396751, 1000.710083, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19172, 1399.451904, -42.242061, 1002.380493, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11725, 1409.603149, -35.957073, 1000.320434, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2283, 1409.683593, -36.331508, 1001.750183, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19623, 1410.057006, -36.224929, 1000.990783, 0.000000, 0.000000, -168.999954, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19807, 1409.273193, -36.165699, 1001.010498, 0.000000, 0.000000, 170.799942, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2824, 1409.785888, -33.776145, 1000.400512, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1736, 1409.575927, -36.011280, 1003.240234, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19806, 1409.733398, -31.180522, 1004.059997, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19806, 1409.733398, -20.960500, 1004.059997, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2813, 1410.387451, -33.827083, 1000.022216, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19829, 1405.329711, -26.601268, 1001.640380, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1827, 1411.043701, -17.388067, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2028, 1410.679443, -17.525131, 1000.410522, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1670, 1411.200805, -17.543813, 1000.350280, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2811, 1406.305297, -13.849283, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2811, 1413.016967, -13.849283, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2811, 1413.457397, -35.639312, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2811, 1405.976318, -35.639312, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2986, 1413.981079, -26.095977, 1000.060424, 0.000000, 90.000000, 360.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2855, 1413.313720, -27.339944, 1000.720703, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1829, 1412.957153, -24.873472, 1001.169921, 0.000000, 0.000000, -75.500038, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2869, 1413.114257, -26.312265, 1000.720275, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19897, 1412.980834, -27.195858, 1000.740051, 0.000000, 0.000000, -24.800001, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2229, 1413.589965, -19.033100, 999.900146, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2229, 1413.589965, -15.943097, 999.900146, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1410.040649, -24.910196, 1000.970153, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1409.930541, -24.850194, 1000.920104, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1409.930541, -24.960195, 1001.000183, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1930, 1409.175903, -24.893423, 1000.869995, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1409.270141, -24.850194, 1000.920104, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1410.260253, -26.600202, 1000.930114, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1410.190185, -26.470199, 1000.990173, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1930, 1410.165893, -26.563425, 1000.900024, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1930, 1409.165527, -27.323438, 1000.900024, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1408.979370, -27.260200, 1000.990173, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1902, 1409.079467, -27.180198, 1000.990173, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(942, 1384.921508, -27.419778, 1002.425842, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(939, 1377.780029, -27.470052, 1002.385620, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1208, 1390.059448, -25.549255, 1000.015991, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1208, 1390.059448, -24.669239, 1000.015991, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2846, 1388.697509, -26.782863, 1000.015991, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2844, 1388.767578, -26.692861, 1000.116027, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2843, 1388.587402, -26.582857, 1000.186157, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19624, 1385.490234, -26.983146, 1000.706054, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1210, 1385.260375, -26.996990, 1000.455139, 12.900000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19921, 1385.013671, -27.196798, 1000.716369, 270.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19918, 1385.119995, -26.930755, 1001.955993, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19919, 1414.062133, -22.558872, 999.900146, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19078, 1414.125732, -22.450550, 1001.379943, 0.000000, 270.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19621, 1385.576416, -26.717617, 1002.056640, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19622, 1387.450439, -26.246255, 1000.695373, -5.599997, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19626, 1381.405639, -28.835578, 1000.818420, 10.099999, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19626, 1381.615844, -28.835578, 1000.818420, 10.099999, 0.000000, -9.100005, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(18635, 1387.054565, -26.550598, 1000.266235, 90.000000, 0.000000, -42.899990, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19468, 1382.859619, -26.625558, 1000.376220, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19468, 1382.859619, -26.625558, 1000.506347, 0.000000, 0.000000, 115.099975, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2102, 1377.432128, -26.659345, 1001.896179, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11745, 1384.681518, -27.342184, 1002.096313, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19631, 1384.226928, -26.656923, 1001.985961, 0.000000, 90.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2827, 1377.647460, -27.048374, 1000.236206, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2827, 1377.647460, -27.608379, 1000.236206, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2630, 1374.289306, -26.897672, 1000.015991, 0.000000, 0.000000, 21.600000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11733, 1373.582153, -27.671955, 1000.046020, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1789, 1388.690429, -27.571893, 1000.556152, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1778, 1389.823486, -23.512676, 1000.026000, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19878, 1380.832275, -27.163230, 1000.076049, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(18634, 1384.406494, -26.500818, 1000.306152, 0.000000, 85.500007, 78.200027, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(3470, 1373.391601, -21.507198, 1003.985229, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(927, 1390.480712, -25.249973, 1000.955322, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2653, 1378.697998, -25.817739, 1004.337158, 0.000000, 180.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2653, 1386.588500, -25.817739, 1004.337158, 0.000000, 180.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2653, 1370.809082, -25.817739, 1004.337158, 0.000000, 180.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1893, 1386.377197, -22.333347, 1004.947082, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1893, 1381.914794, -22.333347, 1004.947082, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1893, 1378.222045, -22.333347, 1004.947082, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19759, 1382.652465, -18.129537, 1004.446960, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19759, 1389.602661, -18.129537, 1004.446960, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19759, 1381.081787, -18.129537, 1004.446960, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19759, 1374.058959, -18.129537, 1004.446960, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19826, 1381.183715, -17.402269, 1001.526245, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19826, 1389.775634, -17.402269, 1001.526245, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19829, 1390.481933, -21.642036, 1001.456298, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11280, 1388.815673, -15.910793, 1000.015991, 0.000000, 0.000000, 167.600006, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19898, 1385.862182, -20.756053, 1000.036010, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1744, 1390.617553, -22.679159, 1001.526000, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2752, 1390.300537, -22.639297, 1001.856262, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2749, 1390.190917, -22.995304, 1001.866027, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2751, 1390.281005, -23.365312, 1001.916137, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(18641, 1390.255859, -23.820091, 1001.887756, 93.599975, 0.000000, 33.599983, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2528, 1410.271972, -41.711738, 999.910034, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19873, 1410.148193, -42.139205, 1000.910705, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19873, 1410.318359, -42.129207, 1000.910705, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2518, 1409.780029, -38.154060, 1000.120239, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2517, 1413.286010, -40.708198, 999.910034, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11707, 1413.888427, -40.313911, 1000.870239, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19874, 1411.563842, -38.935859, 1000.560607, 0.000000, 0.000000, 28.800001, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2741, 1409.805786, -36.788475, 1001.540161, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2750, 1408.537963, -41.187862, 1001.460632, 90.000000, -36.900001, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2742, 1410.620605, -36.984855, 1001.510437, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(14446, 1384.700927, -47.007518, 1000.656616, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2177, 1389.342285, -44.138019, 1003.100097, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2177, 1389.342285, -49.767967, 1003.100097, 0.000000, 180.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2179, 1389.313720, -44.138290, 1002.180847, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2179, 1389.313720, -49.768249, 1002.180847, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2373, 1395.688476, -44.066692, 1000.039672, 0.000000, 0.000000, 270.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2371, 1395.376586, -48.993232, 1000.079772, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2394, 1394.971313, -48.366420, 1000.690307, 0.000000, 0.000000, 90.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2401, 1395.288818, -47.473701, 1001.799804, -0.000007, 0.000000, -89.999977, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2386, 1394.955566, -45.809810, 1000.180053, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2384, 1394.836425, -45.117469, 1000.180358, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2382, 1395.292236, -44.263954, 1000.506225, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2392, 1395.235961, -44.159820, 1001.446228, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2654, 1394.775268, -44.160972, 1000.270507, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2397, 1395.288818, -48.343673, 1001.799804, -0.000007, 0.000000, -89.999977, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2383, 1395.288818, -49.243652, 1001.799804, 0.000000, -0.000007, 179.999954, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2115, 1386.639160, -53.268768, 999.900146, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2120, 1386.911010, -52.629096, 1000.520690, 0.000000, 0.000000, 134.300018, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2894, 1386.879760, -53.216907, 1000.700317, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19807, 1387.680297, -53.148319, 1000.750427, 0.000000, 0.000000, 180.000000, 5, 5, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2251, 1388.946166, -53.394805, 1000.740356, 0.000000, 0.000000, 0.000000, 5, 5, -1, 300.00, 300.00);

 // interijer za kucu 1
	//enter AddPlayerClass(0,-1614.0940,-394.9534,-11.1206,173.0752,0,0,0,0,0,0); //
	CreateDynamicObject(19378, -1616.00562, -398.83948, -12.20650,   0.00000, 90.00000, 87.72001);
	CreateDynamicObject(19378, -1616.42578, -409.31696, -12.20650,   0.00000, 90.00000, 87.72001);
	CreateDynamicObject(19449, -1607.95447, -395.72748, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19387, -1620.93872, -405.76746, -10.43065,   0.00000, 0.00000, -2.40000);
	CreateDynamicObject(19430, -1612.06299, -408.16779, -10.44954,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19449, -1612.62012, -390.78818, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19449, -1615.34094, -390.71494, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19449, -1613.34424, -393.72421, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19449, -1620.26038, -395.28003, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19449, -1620.27795, -399.29077, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19449, -1611.36462, -400.35748, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(14395, -1610.06873, -408.17969, -11.20055,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19449, -1606.83679, -405.33093, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19430, -1610.51892, -408.22733, -10.44954,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19449, -1606.66699, -406.50500, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19430, -1609.84058, -409.07608, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1609.89282, -410.40106, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19461, -1608.35339, -415.93600, -9.12774,   0.00000, 90.00000, -2.22000);
	CreateDynamicObject(19430, -1609.96790, -411.94052, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1610.02954, -413.52145, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19449, -1607.02917, -416.06299, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19375, -1615.41541, -418.81729, -9.12079,   0.00000, 90.00000, -2.16000);
	CreateDynamicObject(1768, -1612.70081, -400.24512, -12.11901,   0.00000, 0.00000, -90.53999);
	CreateDynamicObject(1769, -1613.14575, -398.36526, -12.11866,   0.00000, 0.00000, -65.40000);
	CreateDynamicObject(2023, -1612.07776, -396.31198, -12.11842,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1643, -1614.67346, -401.08975, -12.11855,   0.00000, 0.00000, -2.40000);
	CreateDynamicObject(1768, -1613.52979, -403.93353, -12.11901,   0.00000, 0.00000, -180.96002);
	CreateDynamicObject(2126, -1615.21436, -400.55811, -12.11601,   0.00000, 0.00000, -92.09997);
	CreateDynamicObject(1506, -1614.82031, -393.74265, -12.11908,   0.00000, 0.00000, -2.10000);
	CreateDynamicObject(2296, -1619.97534, -402.01636, -12.12040,   0.00000, 0.00000, 87.78000);
	CreateDynamicObject(19449, -1625.20203, -403.92227, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19377, -1626.07373, -403.87277, -12.20425,   0.00000, 90.00000, -2.40000);
	CreateDynamicObject(19430, -1621.03796, -408.12125, -10.43077,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(1502, -1620.91272, -404.97055, -12.12067,   0.00000, 0.00000, -92.39999);
	CreateDynamicObject(19387, -1615.98193, -408.00320, -10.43065,   0.00000, 0.00000, 86.82001);
	CreateDynamicObject(19430, -1613.60413, -408.12573, -10.44954,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19449, -1622.32227, -407.70270, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(14384, -1616.66785, -408.68433, -10.67414,   0.00000, 0.00000, -182.76006);
	CreateDynamicObject(19430, -1612.85510, -408.92850, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1619.63281, -408.14847, -10.44954,   0.00000, 0.00000, -246.29973);
	CreateDynamicObject(19449, -1620.52600, -413.09003, -10.43938,   0.00000, 0.00000, -2.52000);
	CreateDynamicObject(19449, -1615.54175, -412.34048, -10.43938,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(2528, -1622.65820, -407.16382, -12.11653,   0.00000, 0.00000, 179.03992);
	CreateDynamicObject(2526, -1624.53516, -405.79086, -12.11661,   0.00000, 0.00000, -92.22000);
	CreateDynamicObject(1208, -1621.97998, -404.39423, -12.11680,   0.00000, 0.00000, 177.66003);
	CreateDynamicObject(2524, -1623.81702, -404.54773, -12.11595,   0.00000, 0.00000, -0.24000);
	CreateDynamicObject(19449, -1625.42993, -403.90170, -10.43938,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19430, -1612.91736, -410.52731, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1612.97925, -412.12653, -10.44954,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19387, -1610.12061, -415.86887, -7.35556,   0.00000, 0.00000, -1.92000);
	CreateDynamicObject(1502, -1610.10181, -415.08109, -9.09270,   0.00000, 0.00000, -92.39999);
	CreateDynamicObject(19449, -1614.79224, -414.15228, -7.34831,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19449, -1616.91211, -418.76627, -7.31683,   0.00000, 0.00000, -2.52000);
	CreateDynamicObject(2025, -1610.62158, -417.53452, -9.03572,   0.00000, 0.00000, -92.58001);
	CreateDynamicObject(2021, -1615.28430, -418.43155, -9.03584,   0.00000, 0.00000, 86.75996);
	CreateDynamicObject(2023, -1616.29211, -414.63855, -9.03359,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1799, -1613.10730, -416.92624, -9.03349,   0.00000, 0.00000, 87.84000);
	CreateDynamicObject(19449, -1610.38525, -422.11743, -7.31683,   0.00000, 0.00000, -2.52000);
	CreateDynamicObject(19449, -1614.59998, -419.53012, -7.34831,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(2025, -1612.15320, -419.29022, -9.03572,   0.00000, 0.00000, -181.68002);
	CreateDynamicObject(2010, -1613.40784, -408.90976, -12.11887,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2010, -1620.10718, -407.20288, -12.11887,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2811, -1619.27307, -396.18961, -12.12085,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19174, -1617.51550, -395.52142, -10.76960,   0.00000, 0.00000, -2.64000);
	CreateDynamicObject(1742, -1620.14758, -398.03745, -12.12401,   0.00000, 0.00000, 88.38000);
	CreateDynamicObject(19430, -1609.84058, -409.07608, -7.00105,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1609.89282, -410.40106, -7.01870,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1609.96790, -411.94052, -7.02943,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19430, -1610.02954, -413.52145, -7.06748,   0.00000, 0.00000, -182.51979);
	CreateDynamicObject(19449, -1606.66699, -406.50500, -7.01965,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19449, -1607.02917, -416.06299, -7.02157,   0.00000, 0.00000, -2.16000);
	CreateDynamicObject(19449, -1605.29407, -417.22223, -7.34831,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(2811, -1607.60071, -416.48923, -9.04144,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, -1616.42029, -395.48438, -8.69075,   0.00000, 90.00000, -2.76000);
	CreateDynamicObject(19375, -1616.88245, -405.05115, -8.69075,   0.00000, 90.00000, -2.76000);
	CreateDynamicObject(19375, -1617.05493, -409.03287, -8.69740,   0.00000, 90.00000, -2.76000);
	CreateDynamicObject(19375, -1627.34741, -404.58527, -8.69075,   0.00000, 90.00000, -2.76000);
	CreateDynamicObject(19375, -1611.20020, -416.82550, -5.75367,   0.00000, 90.00000, -2.76000);
	CreateDynamicObject(19430, -1610.51892, -408.22733, -7.00939,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19430, -1612.06299, -408.16779, -7.01669,   0.00000, 0.00000, -91.80000);
	CreateDynamicObject(19449, -1606.83679, -405.33093, -6.96968,   0.00000, 0.00000, 87.60001);
	CreateDynamicObject(19449, -1611.70874, -406.73468, -7.01965,   0.00000, 0.00000, -2.34000);
	CreateDynamicObject(19375, -1610.74341, -407.25446, -5.75367,   0.00000, 90.00000, -2.76000);

	// Custom D-Mob House Interior(crack dent) by Fajr
	CreateDynamicObject(14383,-1286.6099900,2405.0690900,3506.4719200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2451,-1283.8210400,2404.4760700,3504.7399900,0.0000000,0.0000000,-89.6000000); //
	CreateDynamicObject(14532,-1284.1159700,2409.1279300,3505.5600600,0.0000000,0.0000000,144.9989900); //
	CreateDynamicObject(3041,-1287.2929700,2400.9150400,3504.7299800,0.0000000,0.0000000,-179.2000000); //
	CreateDynamicObject(19835,-1283.7450000,2405.2919900,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19835,-1283.8149400,2405.1640600,3505.8010300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19482,-1281.9270000,2405.0930200,3506.1189000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19835,-1284.0849600,2405.0869100,3505.8010300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2611,-1298.7390100,2402.2539100,3506.6240200,0.0000000,0.0000000,89.4990000); //
	CreateDynamicObject(19825,-1290.4799800,2404.4829100,3507.7729500,1.2990000,0.0000000,88.2990000); //
	CreateDynamicObject(19482,-1282.4659400,2404.4108900,3506.0791000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.4630100,2404.4108900,3509.4689900,-63.4990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1284.1639400,2402.2370600,3509.5481000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1282.7370600,2404.0639600,3508.7160600,-63.4990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1284.4250500,2401.9079600,3510.2749000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1284.4000200,2401.9389600,3510.2290000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1281.9699700,2405.0380900,3506.0991200,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.7039800,2404.1059600,3508.7570800,-63.4990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.9969500,2403.7309600,3509.4409200,-63.4990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1284.9489700,2401.2519500,3510.2390100,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1282.9539800,2403.7900400,3506.0668900,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.0030500,2403.7270500,3505.6669900,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.0589600,2403.6569800,3505.4470200,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.4050300,2403.2099600,3509.3259300,-63.4990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1284.4250500,2401.9079600,3510.2749000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1284.4250500,2401.9079600,3510.2749000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1283.1889600,2403.4919400,3506.1770000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.1889600,2403.4919400,3506.3269000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1285.2869900,2400.8269000,3510.2981000,-122.2000000,0.3990000,141.6990100); //
	CreateDynamicObject(19482,-1283.4809600,2403.1240200,3506.0271000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.5219700,2403.0668900,3505.8259300,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.9060100,2402.5710400,3504.5200200,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.5300300,2404.3230000,3505.1250000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.5300300,2403.0490700,3504.9680200,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.5489500,2404.3000500,3505.0139200,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.4429900,2404.4331100,3504.9040500,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.4000200,2404.4880400,3504.7939500,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1282.6099900,2404.2209500,3505.2839400,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1283.0050000,2403.7150900,3505.1001000,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(2700,-1284.2390100,2403.8930700,3511.3149400,0.0000000,0.0000000,139.0000000); //
	CreateDynamicObject(2479,-1286.5059800,2405.3960000,3505.8911100,0.0000000,0.0000000,88.7000000); //
	CreateDynamicObject(2287,-1286.9489700,2403.8300800,3510.7338900,0.0000000,0.0000000,-179.9989900); //
	CreateDynamicObject(2258,-1289.1080300,2409.6398900,3511.0739700,0.0000000,0.0000000,0.8000000); //
	CreateDynamicObject(19835,-1283.5550500,2405.4418900,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19835,-1283.8850100,2405.7409700,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19835,-1283.9849900,2405.4541000,3505.8010300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2360,-1298.1040000,2408.6088900,3504.7219200,0.0000000,0.0000000,91.0990000); //
	CreateDynamicObject(19811,-1283.4300500,2407.8190900,3505.6230500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2047,-1290.8149400,2401.7890600,3506.8420400,0.0000000,0.0000000,-89.6990000); //
	CreateDynamicObject(19811,-1295.4499500,2407.5090300,3505.1621100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19482,-1283.1450200,2403.5380900,3504.6101100,-0.1990000,0.0000000,141.8990000); //
	CreateDynamicObject(19482,-1294.3280000,2402.1440400,3505.7150900,-0.3990000,-3.0990000,163.3000000); //
	CreateDynamicObject(2266,-1284.4520300,2407.8430200,3510.4250500,0.0000000,0.0000000,-90.6990000); //
	CreateDynamicObject(2282,-1289.4389600,2406.0000000,3510.3540000,0.0000000,0.0000000,89.7000000); //
	CreateDynamicObject(2260,-1284.3960000,2405.9919400,3510.2241200,0.0000000,0.0000000,-87.6990000); //
	CreateDynamicObject(2256,-1291.5730000,2405.3720700,3510.6940900,0.0000000,-0.2990000,-179.8990000); //
	CreateDynamicObject(2068,-1294.7700200,2405.2119100,3507.7561000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(936,-1285.6770000,2409.1250000,3505.2229000,0.0000000,0.0000000,0.2000000); //
	CreateDynamicObject(1501,-1297.1140100,2399.1860400,3504.7219200,0.0000000,0.0000000,-0.3000000); //
	CreateDynamicObject(941,-1287.8430200,2406.0549300,3505.2399900,0.0000000,0.0000000,-89.3990000); //
	CreateDynamicObject(2418,-1283.7609900,2408.2380400,3504.7299800,0.0000000,0.0000000,-89.0990000); //
	CreateDynamicObject(937,-1287.5730000,2409.1579600,3505.2199700,0.0000000,0.0000000,0.2990000); //
	CreateDynamicObject(2419,-1283.7320600,2406.3540000,3504.7319300,0.0000000,0.0000000,-88.9990000); //
	CreateDynamicObject(2048,-1296.6049800,2409.5991200,3506.9709500,0.0000000,0.0000000,-0.1000000); //
	CreateDynamicObject(19996,-1290.1120600,2406.9099100,3504.7299800,0.0000000,0.0000000,107.0000000); //
	CreateDynamicObject(11707,-1290.4329800,2409.0510300,3506.6001000,0.0000000,0.0000000,89.3000000); //
	CreateDynamicObject(930,-1290.1929900,2402.1189000,3505.1809100,0.6000000,0.0000000,-88.5990000); //
	CreateDynamicObject(11709,-1289.8490000,2409.3181200,3505.4089400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3633,-1289.8969700,2400.8999000,3505.2128900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19474,-1286.8690200,2405.5161100,3508.8850100,0.0000000,0.0000000,-94.0000000); //
	CreateDynamicObject(1921,-1286.1870100,2406.0949700,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1907,-1287.0410200,2405.5979000,3509.4150400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(941,-1286.6180400,2405.5639600,3505.2399900,0.0000000,0.0000000,90.6000000); //
	CreateDynamicObject(1265,-1283.3599900,2401.0800800,3505.1210900,0.0000000,0.0000000,6.8000000); //
	CreateDynamicObject(2709,-1283.2769800,2408.1379400,3505.8210400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19472,-1287.8380100,2408.8588900,3505.0090300,0.0000000,0.0000000,-82.9990000); //
	CreateDynamicObject(19472,-1288.2189900,2408.7929700,3505.0300300,0.0000000,0.0000000,-98.7000000); //
	CreateDynamicObject(19472,-1288.0290500,2408.7251000,3505.0400400,0.0000000,0.0000000,-91.5000000); //
	CreateDynamicObject(19915,-1288.8349600,2409.4189500,3504.7299800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2390,-1290.4449500,2405.9741200,3506.0400400,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2389,-1290.4050300,2406.5739700,3506.0610400,0.0000000,0.0000000,90.0990000); //
	CreateDynamicObject(19809,-1283.4699700,2406.6699200,3505.7299800,0.0000000,0.0000000,-88.6990000); //
	CreateDynamicObject(2994,-1286.4370100,2401.0639600,3505.0800800,0.0000000,0.0000000,90.9990000); //
	CreateDynamicObject(2846,-1291.2919900,2409.0019500,3504.7319300,0.0000000,0.0000000,151.8999900); //
	CreateDynamicObject(366,-1290.3649900,2402.8759800,3505.3479000,-16.7000000,44.1990000,95.7000000); //
	CreateDynamicObject(341,-1286.8750000,2406.0080600,3505.9050300,-1.7000000,17.5000000,178.4989900); //
	CreateDynamicObject(11737,-1296.3750000,2399.7819800,3504.7219200,0.0000000,0.0000000,-0.2990000); //
	CreateDynamicObject(1575,-1287.5999800,2404.9270000,3505.7099600,0.0000000,0.0000000,-91.7990000); //
	CreateDynamicObject(1575,-1287.5589600,2405.4580100,3505.6999500,0.0000000,0.0000000,-90.4990000); //
	CreateDynamicObject(1575,-1287.6230500,2405.0119600,3505.8811000,0.0000000,0.0000000,-89.4990000); //
	CreateDynamicObject(1498,-1282.6750500,2402.1870100,3504.7019000,0.0000000,0.0000000,-90.2000000); //
	CreateDynamicObject(1579,-1287.5529800,2405.9851100,3505.7009300,0.0000000,0.0000000,87.5000000); //
	CreateDynamicObject(1579,-1287.5780000,2405.5620100,3505.8710900,0.0000000,0.0000000,-90.7990000); //
	CreateDynamicObject(1279,-1287.0810500,2405.2919900,3505.6809100,0.0000000,0.0000000,90.1000000); //
	CreateDynamicObject(18635,-1286.5379600,2400.8950200,3505.1950700,87.1000000,105.5990000,11.9990000); //
	CreateDynamicObject(1337,-1284.2679400,2400.6721200,3505.3811000,-0.6000000,0.0000000,-178.2990000); //
	CreateDynamicObject(2709,-1283.4270000,2408.0271000,3505.8210400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1644,-1283.3320300,2407.3120100,3505.8310500,91.4000000,-88.9990000,0.0000000); //
	CreateDynamicObject(2709,-1283.2559800,2408.3181200,3505.8310500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2709,-1283.2480500,2407.9260300,3505.8210400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2676,-1288.5319800,2407.6179200,3504.8300800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2709,-1283.4410400,2408.2399900,3505.8310500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2671,-1286.6850600,2402.1750500,3504.7299800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2670,-1285.7130100,2404.8200700,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2953,-1287.7469500,2404.9370100,3506.0610400,0.0000000,0.0000000,-47.4000000); //
	CreateDynamicObject(2674,-1294.8549800,2408.2629400,3504.7419400,0.0000000,0.0000000,35.9000000); //
	CreateDynamicObject(19920,-1288.3230000,2406.7470700,3505.7299800,0.0000000,0.0000000,-39.8000000); //
	CreateDynamicObject(11722,-1283.2130100,2408.5900900,3505.8210400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2683,-1283.2900400,2407.0319800,3505.8310500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11734,-1298.2769800,2403.5161100,3504.7619600,0.0000000,0.0000000,42.9990000); //
	CreateDynamicObject(1916,-1286.9759500,2405.5190400,3509.4140600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2840,-1293.1689500,2409.3000500,3504.7219200,0.0000000,0.0000000,157.7990000); //
	CreateDynamicObject(2670,-1293.1350100,2407.9719200,3504.8120100,0.0000000,0.0000000,110.1990000); //
	CreateDynamicObject(2831,-1294.3790300,2409.2680700,3504.7319300,0.0000000,0.0000000,145.7000000); //
	CreateDynamicObject(19898,-1283.6629600,2403.9870600,3505.7099600,-2.0990000,2.0000000,134.5990000); //
	CreateDynamicObject(17969,-1290.6550300,2401.1831100,3507.0329600,0.0000000,0.2990000,4.3990000); //
	CreateDynamicObject(2069,-1298.2170400,2407.1960400,3504.8020000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2059,-1292.7099600,2408.4121100,3504.7319300,0.0000000,0.0000000,-51.0990000); //
	CreateDynamicObject(1940,-1286.2159400,2405.9951200,3509.3740200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2673,-1294.0200200,2407.7041000,3504.7219200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3077,-1284.5730000,2401.6750500,3504.7299800,0.0000000,0.0000000,-127.8990000); //
	CreateDynamicObject(19621,-1283.3139600,2407.6298800,3505.8320300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11719,-1288.7130100,2409.2619600,3505.6999500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1916,-1286.9709500,2405.7309600,3509.4140600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11743,-1283.2609900,2405.7900400,3505.6909200,0.0000000,0.0000000,-92.8990000); //
	CreateDynamicObject(19830,-1283.2240000,2406.1250000,3505.6799300,0.0000000,0.0000000,-92.4000000); //
	CreateDynamicObject(19921,-1285.8520500,2409.1870100,3505.8010300,0.0000000,0.0000000,-18.8990000); //
	CreateDynamicObject(19631,-1290.4150400,2402.7060500,3505.1669900,100.1000000,88.3000000,-4.1000000); //
	CreateDynamicObject(1916,-1286.9069800,2405.5390600,3509.4250500,74.6000000,-129.2990000,-31.5000000); //
	CreateDynamicObject(1941,-1286.1529500,2406.0129400,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1917,-1286.9709500,2405.6709000,3509.4150400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1917,-1286.9709500,2405.5610400,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2663,-1286.7230200,2406.1899400,3505.9609400,0.0000000,0.0000000,-27.0990000); //
	CreateDynamicObject(2857,-1287.4300500,2409.1130400,3505.6999500,0.0000000,0.0000000,88.3990000); //
	CreateDynamicObject(19996,-1293.3740200,2402.0778800,3504.7219200,0.0000000,0.0000000,60.6990000); //
	CreateDynamicObject(19996,-1291.9050300,2402.6440400,3504.7219200,0.0000000,0.0000000,-23.8990000); //
	CreateDynamicObject(19996,-1293.7910200,2400.8811000,3504.7219200,0.0000000,0.0000000,102.2990000); //
	CreateDynamicObject(1748,-1291.0949700,2400.8059100,3505.5019500,0.0000000,0.0000000,-126.9000000); //
	CreateDynamicObject(1546,-1291.8120100,2401.6230500,3505.5930200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19897,-1292.7399900,2400.8960000,3505.5229500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1665,-1292.6529500,2401.0969200,3505.5329600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2676,-1293.2230200,2407.6179200,3504.8300800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2866,-1292.2500000,2401.1521000,3505.5129400,0.0000000,0.0000000,-21.6000000); //
	CreateDynamicObject(1543,-1298.3549800,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19920,-1292.9870600,2401.3659700,3505.5229500,0.0000000,0.0000000,-115.6000000); //
	CreateDynamicObject(2102,-1288.8280000,2409.4389600,3506.5410200,0.0000000,0.0000000,10.1990000); //
	CreateDynamicObject(11728,-1298.3709700,2400.3190900,3506.2439000,0.0000000,0.0000000,-178.1990100); //
	CreateDynamicObject(19823,-1288.3439900,2409.2561000,3505.7109400,0.0000000,0.0000000,38.5000000); //
	CreateDynamicObject(1808,-1289.5999800,2408.6389200,3503.3979500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1930,-1287.3079800,2406.0490700,3509.3840300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(18644,-1286.3590100,2401.1379400,3504.9350600,85.5990000,36.5990000,0.0000000); //
	CreateDynamicObject(18633,-1286.4399400,2400.8149400,3504.9389600,0.2990000,-97.9990000,47.3000000); //
	CreateDynamicObject(1931,-1287.3680400,2406.0390600,3509.3649900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1932,-1287.3079800,2405.9680200,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(346,-1288.3230000,2404.8798800,3505.7141100,87.6990000,-15.1000000,9.8000000); //
	CreateDynamicObject(336,-1298.0980200,2400.4799800,3505.4050300,-174.3990000,0.0000000,0.0000000); //
	CreateDynamicObject(344,-1287.8700000,2405.1699200,3505.9140600,-9.3000000,0.0000000,-159.4989900); //
	CreateDynamicObject(344,-1287.9389600,2405.1650400,3505.9240700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1905,-1286.9930400,2405.3940400,3509.4541000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19914,-1293.8020000,2406.8920900,3505.2829600,0.0000000,0.0000000,-179.3000000); //
	CreateDynamicObject(1905,-1286.8530300,2405.7041000,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1907,-1286.9709500,2405.6279300,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(335,-1288.1960400,2404.8920900,3505.7060500,91.6990000,41.5000000,-10.7990000); //
	CreateDynamicObject(1907,-1286.9110100,2405.6279300,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1907,-1286.8609600,2405.5979000,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1941,-1288.0699500,2405.5681200,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1941,-1286.8399700,2405.5380900,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(365,-1294.2159400,2406.8310500,3505.2260700,80.8990000,154.5990000,99.1990000); //
	CreateDynamicObject(2653,-1286.8060300,2409.1579600,3508.0180700,-179.3000000,0.4000000,92.0990000); //
	CreateDynamicObject(19809,-1283.9539800,2406.3779300,3505.7299800,0.0000000,0.0000000,-88.6990000); //
	CreateDynamicObject(2649,-1283.9439700,2407.1970200,3507.7419400,179.8990000,0.0000000,-88.4990000); //
	CreateDynamicObject(1761,-1291.5810500,2408.3278800,3504.7219200,0.0000000,0.0000000,-103.2000000); //
	CreateDynamicObject(19809,-1283.9599600,2406.6579600,3505.7299800,0.0000000,0.0000000,-88.6990000); //
	CreateDynamicObject(2694,-1286.9740000,2408.9899900,3505.0900900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2694,-1287.4740000,2409.0009800,3505.0900900,0.0000000,0.0000000,-8.4990000); //
	CreateDynamicObject(2654,-1287.7950400,2400.9370100,3504.9799800,0.0000000,0.0000000,90.1990000); //
	CreateDynamicObject(19810,-1290.8039600,2405.6721200,3506.2338900,0.0000000,0.0000000,89.8990000); //
	CreateDynamicObject(2694,-1288.7110600,2400.9431200,3504.8630400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2694,-1288.5219700,2401.0400400,3505.1230500,0.0000000,0.0000000,75.6000000); //
	CreateDynamicObject(19639,-1283.7970000,2407.5390600,3505.0000000,-0.1990000,0.0000000,10.1000000); //
	CreateDynamicObject(1907,-1286.9110100,2405.6779800,3509.4150400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1941,-1286.9200400,2405.4880400,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1808,-1290.1490500,2409.3840300,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2055,-1298.7609900,2403.6379400,3506.8339800,0.0000000,0.0000000,91.5000000); //
	CreateDynamicObject(1808,-1289.8079800,2409.3230000,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1808,-1289.4489700,2409.4240700,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1808,-1289.3990500,2408.9729000,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1940,-1285.7159400,2405.5739700,3509.3740200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1905,-1286.9830300,2405.4641100,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1905,-1287.0629900,2405.4939000,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1808,-1289.8389900,2408.9929200,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19874,-1289.4360400,2409.6499000,3505.8310500,0.0000000,0.0000000,11.2000000); //
	CreateDynamicObject(1808,-1290.2490200,2409.0229500,3503.3989300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1905,-1286.8530300,2405.7539100,3509.4040500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19583,-1283.5450400,2405.2209500,3505.6818800,-178.2990000,0.0000000,-57.5990000); //
	CreateDynamicObject(1760,-1296.0500500,2406.0481000,3504.7219200,0.0000000,0.0000000,135.1000100); //
	CreateDynamicObject(19873,-1291.4350600,2400.9660600,3506.0329600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1941,-1285.6929900,2405.5429700,3509.3950200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1941,-1285.7629400,2405.5429700,3509.3950200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1940,-1286.2159400,2404.8649900,3509.3740200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1921,-1286.1870100,2404.9350600,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1921,-1286.2970000,2404.9350600,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1930,-1287.3079800,2404.9880400,3509.3840300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1921,-1287.3960000,2405.0439500,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1921,-1287.4060100,2404.9650900,3509.4050300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1931,-1288.0179400,2405.6079100,3509.3649900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(18634,-1286.4770500,2401.0210000,3504.7260700,9.7990000,91.2990000,-42.0000000); //
	CreateDynamicObject(1932,-1288.0980200,2405.6079100,3509.4150400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3052,-1298.5069600,2401.1689500,3504.8330100,0.0000000,0.0000000,89.7000000); //
	CreateDynamicObject(3052,-1298.5019500,2401.8491200,3504.8430200,0.0000000,0.0000000,89.4000000); //
	CreateDynamicObject(16155,-1288.9599600,2399.0859400,3507.0170900,-0.6000000,0.7000000,10.7000000); //
	CreateDynamicObject(1670,-1286.7700200,2406.1088900,3509.4250500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3052,-1298.5040300,2401.5200200,3505.0830100,0.0000000,0.0000000,90.6000000); //
	CreateDynamicObject(1670,-1286.8490000,2404.8779300,3509.4150400,0.0000000,0.0000000,154.8000000); //
	CreateDynamicObject(2255,-1291.2960200,2408.1079100,3506.6530800,0.0000000,0.0000000,-92.7000000); //
	CreateDynamicObject(1714,-1284.7280300,2404.9641100,3508.3501000,6.7000000,0.4000000,-136.6990100); //
	CreateDynamicObject(2046,-1290.3509500,2402.9519000,3506.9340800,0.0000000,0.0000000,92.3990000); //
	CreateDynamicObject(2276,-1297.9849900,2409.1579600,3506.1940900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19138,-1298.5030500,2401.3769500,3505.2319300,0.0000000,0.0000000,26.5000000); //
	CreateDynamicObject(19820,-1284.0360100,2404.6169400,3509.4541000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19822,-1284.0059800,2404.2370600,3509.4350600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19824,-1284.0369900,2403.5568800,3509.4550800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19873,-1298.5870400,2400.9409200,3505.0229500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1667,-1288.0429700,2405.4460400,3509.5029300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1499,-1290.6889600,2405.4360400,3504.7219200,0.0000000,0.0000000,-90.6990000); //
	CreateDynamicObject(1667,-1285.6330600,2405.6760300,3509.5029300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19792,-1288.1810300,2404.8898900,3505.7299800,0.0000000,0.0000000,74.0990000); //
	CreateDynamicObject(1664,-1298.4820600,2401.7060500,3505.3750000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11747,-1298.5100100,2402.0190400,3505.0119600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1669,-1298.5920400,2401.3259300,3505.4030800,0.0000000,0.0000000,72.5990000); //
	CreateDynamicObject(1487,-1288.1920200,2409.4199200,3505.8999000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1575,-1287.5660400,2406.5358900,3505.7351100,3.8990000,0.0000000,87.7990000); //
	CreateDynamicObject(1575,-1287.5689700,2406.3369100,3505.8950200,3.8990000,0.0000000,79.8990000); //
	CreateDynamicObject(1950,-1288.1030300,2409.1130400,3505.8898900,0.0000000,0.0000000,-91.3000000); //
	CreateDynamicObject(2045,-1288.0389400,2405.4370100,3505.7399900,0.0000000,0.0000000,-30.0990000); //
	CreateDynamicObject(1487,-1285.1700400,2403.4990200,3509.6550300,0.0000000,0.0000000,-77.8990000); //
	CreateDynamicObject(2059,-1287.9250500,2406.1589400,3505.7509800,0.0000000,0.0000000,-122.8000000); //
	CreateDynamicObject(1264,-1283.6240200,2402.1320800,3505.1630900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1264,-1284.1540500,2401.3720700,3505.1630900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19823,-1284.0169700,2403.8630400,3509.4541000,0.0000000,0.0000000,-88.8000000); //
	CreateDynamicObject(1757,-1286.5939900,2409.1040000,3508.3129900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2494,-1298.7080100,2400.9751000,3506.8530300,-0.1990000,0.0000000,93.2990000); //
	CreateDynamicObject(1951,-1288.0009800,2409.5800800,3505.9008800,0.0000000,0.0000000,-90.9000000); //
	CreateDynamicObject(1543,-1287.9379900,2408.9780300,3505.6899400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1288.3380100,2408.9780300,3505.6899400,0.0000000,0.6990000,61.4990000); //
	CreateDynamicObject(1544,-1288.1369600,2408.7749000,3505.6809100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1544,-1287.8570600,2408.7749000,3505.6809100,0.0000000,0.0000000,-19.1990000); //
	CreateDynamicObject(1543,-1288.3210400,2408.7189900,3505.6999500,0.0000000,0.0000000,-17.2000000); //
	CreateDynamicObject(1543,-1288.3409400,2409.5000000,3505.6999500,0.0000000,0.0000000,-17.2000000); //
	CreateDynamicObject(2046,-1290.3179900,2402.1521000,3506.9340800,0.0000000,0.0000000,92.3990000); //
	CreateDynamicObject(2046,-1290.2850300,2401.3610800,3506.9340800,0.0000000,0.0000000,92.3990000); //
	CreateDynamicObject(11748,-1298.6070600,2401.9460400,3504.9628900,0.0000000,0.0000000,148.6000100); //
	CreateDynamicObject(19998,-1292.2139900,2401.4719200,3505.6230500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2101,-1292.8690200,2409.2600100,3505.2128900,0.0000000,0.0000000,10.5000000); //
	CreateDynamicObject(1971,-1290.8439900,2400.9990200,3507.9729000,0.0000000,0.0000000,-88.6990000); //
	CreateDynamicObject(1736,-1291.7950400,2409.3330100,3507.3830600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19626,-1289.5379600,2401.6120600,3505.5090300,-9.1990000,0.0000000,174.8000000); //
	CreateDynamicObject(2315,-1295.4539800,2407.7639200,3504.7219200,0.0000000,0.0000000,-23.3990000); //
	CreateDynamicObject(2296,-1294.9730200,2409.3579100,3504.7219200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2196,-1283.9189500,2405.1750500,3505.6899400,0.0000000,0.0000000,130.2990000); //
	CreateDynamicObject(2074,-1296.5710400,2400.8278800,3507.9838900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3014,-1291.1259800,2409.2189900,3504.9528800,0.0000000,0.0000000,156.8999900); //
	CreateDynamicObject(2358,-1291.9300500,2409.3830600,3504.8830600,0.0000000,0.0000000,8.4990000); //
	CreateDynamicObject(2358,-1291.9300500,2409.3830600,3505.1130400,0.0000000,0.0000000,8.4990000); //
	CreateDynamicObject(2040,-1291.0789800,2408.7150900,3504.8430200,0.0000000,0.0000000,65.2990000); //
	CreateDynamicObject(2607,-1287.9300500,2409.0439500,3508.6940900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.4350600,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.2650100,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2695,-1295.3210400,2413.3798800,3509.8679200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2840,-1295.4449500,2407.7700200,3505.2028800,0.0000000,0.0000000,-25.1000000); //
	CreateDynamicObject(19996,-1294.7600100,2405.4008800,3504.7219200,0.0000000,0.0000000,-175.2000000); //
	CreateDynamicObject(19873,-1292.7230200,2409.3989300,3505.8129900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1665,-1294.6850600,2407.0100100,3505.2419400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11747,-1292.6490500,2409.2619600,3505.7919900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2356,-1296.4370100,2409.5849600,3504.8139600,89.1990000,12.1000000,9.1000000); //
	CreateDynamicObject(11748,-1292.8339800,2409.1430700,3505.7829600,0.0000000,0.0000000,44.1000000); //
	CreateDynamicObject(2866,-1294.1610100,2407.1550300,3505.2229000,0.0000000,0.0000000,32.2000000); //
	CreateDynamicObject(2002,-1289.6190200,2409.0869100,3508.3540000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1292.5610400,2409.4021000,3505.2099600,0.0000000,0.0000000,-17.2000000); //
	CreateDynamicObject(2850,-1287.3740200,2409.2929700,3509.1040000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19993,-1287.4370100,2408.9570300,3509.0839800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19897,-1294.8449700,2407.8430200,3505.2329100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2102,-1288.5329600,2409.2810100,3509.0839800,0.0000000,0.0000000,22.5990000); //
	CreateDynamicObject(2670,-1296.4539800,2408.1889600,3504.8120100,0.0000000,0.0000000,134.8990000); //
	CreateDynamicObject(19994,-1300.3690200,2405.2180200,3506.0190400,157.0000000,16.3000000,16.2990000); //
	CreateDynamicObject(11745,-1288.6619900,2408.9340800,3509.2539100,0.0000000,0.0000000,-49.4000000); //
	CreateDynamicObject(2831,-1294.4310300,2407.2009300,3504.7829600,0.0000000,-2.8000000,53.3000000); //
	CreateDynamicObject(1714,-1286.2509800,2403.4470200,3508.4169900,9.8000000,0.0000000,177.5990000); //
	CreateDynamicObject(19624,-1289.1240200,2409.1369600,3508.7739300,0.0000000,4.0000000,-71.1990000); //
	CreateDynamicObject(2849,-1295.1980000,2407.7260700,3504.7629400,0.0000000,0.0000000,-82.5000000); //
	CreateDynamicObject(2860,-1294.7170400,2407.3469200,3505.2529300,0.0000000,0.0000000,-18.1000000); //
	CreateDynamicObject(19896,-1287.5400400,2408.8181200,3509.1140100,0.0000000,-2.8990000,-28.5000000); //
	CreateDynamicObject(19897,-1287.4899900,2408.8081100,3509.1269500,0.0000000,5.8990000,0.0000000); //
	CreateDynamicObject(1486,-1287.9150400,2409.3129900,3509.2539100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(11746,-1288.2060500,2404.9719200,3505.7380400,-86.8990000,-142.1990100,0.0000000); //
	CreateDynamicObject(1486,-1287.9150400,2409.3129900,3509.2539100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1486,-1287.9849900,2409.2429200,3509.2539100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1486,-1287.9849900,2409.2429200,3509.2539100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1486,-1288.0150100,2409.3129900,3509.2539100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1546,-1287.8780500,2409.2460900,3509.1850600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2855,-1298.4019800,2402.5239300,3504.7219200,0.0000000,0.0000000,106.4990000); //
	CreateDynamicObject(2674,-1292.8179900,2401.6398900,3504.7319300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1714,-1287.5570100,2403.5109900,3508.3220200,5.0000000,-0.6990000,179.4989900); //
	CreateDynamicObject(2670,-1296.9730200,2401.1669900,3504.8310500,0.0000000,0.0000000,-178.2990000); //
	CreateDynamicObject(2059,-1292.9990200,2403.2170400,3504.7419400,0.0000000,0.0000000,116.3000000); //
	CreateDynamicObject(2260,-1291.7650100,2409.1940900,3505.9819300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1714,-1289.4820600,2405.5271000,3508.3469200,7.1000000,-0.6990000,89.1990000); //
	CreateDynamicObject(1493,-1291.2409700,2407.3369100,3504.4680200,-8.7990000,0.0000000,-90.4990000); //
	CreateDynamicObject(1714,-1288.0529800,2406.9860800,3508.3400900,2.7000000,-1.5000000,49.4990000); //
	CreateDynamicObject(1714,-1285.6099900,2407.0371100,3508.3269000,5.3000000,0.1990000,-42.8990000); //
	CreateDynamicObject(19818,-1295.2600100,2407.4140600,3505.3129900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19818,-1293.9300500,2406.7141100,3505.3129900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1770,-1292.4859600,2401.0700700,3504.7209500,0.0000000,0.0990000,15.1990000); //
	CreateDynamicObject(19570,-1283.4849900,2408.5271000,3505.6999500,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2827,-1288.0229500,2408.9660600,3509.1250000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2058,-1300.3459500,2411.6579600,3508.3339800,0.0000000,0.0000000,-74.7000000); //
	CreateDynamicObject(11736,-1292.9959700,2409.3339800,3505.7729500,0.0000000,0.0000000,55.7990000); //
	CreateDynamicObject(11738,-1292.7929700,2409.1589400,3507.2451200,0.0000000,0.0000000,-23.3000000); //
	CreateDynamicObject(19592,-1285.0649400,2409.2329100,3506.1909200,0.0000000,0.0000000,-166.1990100); //
	CreateDynamicObject(3027,-1288.0639600,2404.9509300,3505.7299800,86.8990000,42.1990000,0.0000000); //
	CreateDynamicObject(2709,-1285.0510300,2409.0979000,3505.7570800,0.0000000,-97.2990000,0.0000000); //
	CreateDynamicObject(2601,-1285.0489500,2409.2509800,3505.7561000,-3.3990000,86.2990000,23.3990000); //
	CreateDynamicObject(19039,-1288.2590300,2404.7099600,3505.7309600,0.0000000,0.0000000,137.4989900); //
	CreateDynamicObject(1666,-1288.0959500,2408.6220700,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1666,-1287.9759500,2408.7419400,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1666,-1288.1760300,2408.9318800,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19116,-1298.4720500,2401.0739700,3505.0439500,-18.8990000,-86.8000000,34.5000000); //
	CreateDynamicObject(1759,-1291.6469700,2405.9641100,3508.3159200,0.0000000,0.0000000,153.9989900); //
	CreateDynamicObject(346,-1291.1970200,2409.2810100,3505.2858900,-93.0990000,0.0000000,0.0000000); //
	CreateDynamicObject(1729,-1290.9670400,2412.8601100,3508.3220200,0.0000000,1.0990000,-35.1990000); //
	CreateDynamicObject(2680,-1291.0830100,2403.6289100,3504.7819800,135.8990000,0.0000000,-12.5990000); //
	CreateDynamicObject(2056,-1300.7559800,2411.8630400,3510.0869100,0.0000000,0.0000000,90.5000000); //
	CreateDynamicObject(19570,-1285.3380100,2409.0170900,3505.7028800,2.1000000,0.0000000,-40.0000000); //
	CreateDynamicObject(1666,-1284.9799800,2409.4570300,3505.7810100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19564,-1285.1600300,2409.3840300,3505.7539100,-26.4990000,0.0000000,15.2990000); //
	CreateDynamicObject(1429,-1290.9360400,2412.8798800,3509.2060500,1.6990000,30.5000000,-31.6000000); //
	CreateDynamicObject(19920,-1291.2619600,2412.5920400,3508.8569300,-1.2990000,-6.5990000,26.4000000); //
	CreateDynamicObject(2674,-1291.5760500,2412.0839800,3508.3540000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(928,-1289.5360100,2402.2280300,3504.9929200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1297.9950000,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(924,-1289.6669900,2402.9670400,3504.9130900,0.0000000,0.0000000,-17.2000000); //
	CreateDynamicObject(2047,-1300.7810100,2405.4890100,3508.3239700,0.0000000,0.0000000,90.6990000); //
	CreateDynamicObject(11730,-1292.0429700,2413.1579600,3508.3239700,0.0000000,0.0000000,3.0990000); //
	CreateDynamicObject(2637,-1284.5990000,2403.0319800,3509.0148900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2637,-1283.5799600,2404.0061000,3509.0139200,0.0000000,0.0000000,88.2990000); //
	CreateDynamicObject(1755,-1300.5200200,2412.4619100,3508.2758800,0.0000000,0.0000000,28.5000000); //
	CreateDynamicObject(2037,-1287.9339600,2404.8120100,3505.8811000,0.0000000,0.0000000,76.8000000); //
	CreateDynamicObject(1491,-1289.9909700,2408.4729000,3508.3239700,0.0000000,0.0000000,-89.4000000); //
	CreateDynamicObject(19996,-1293.1750500,2405.3889200,3504.7019000,0.0000000,0.0000000,-147.2000000); //
	CreateDynamicObject(11699,-1295.1460000,2399.6589400,3504.3501000,-3.9990000,0.0000000,-109.1000000); //
	CreateDynamicObject(1664,-1284.0510300,2404.9099100,3509.6040000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2673,-1299.4820600,2411.9641100,3508.4340800,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1520,-1284.3020000,2403.4870600,3509.4951200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19821,-1284.5720200,2403.4890100,3509.4418900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19820,-1284.9019800,2403.4990200,3509.4418900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1668,-1285.4429900,2403.4951200,3509.6040000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2060,-1298.9890100,2413.0219700,3508.3540000,0.0000000,0.0000000,16.3000000); //
	CreateDynamicObject(2060,-1299.0119600,2413.0610400,3508.5739700,0.0000000,0.0000000,5.2000000); //
	CreateDynamicObject(2060,-1299.0119600,2413.0610400,3508.7338900,0.0000000,0.0000000,-5.0990000); //
	CreateDynamicObject(1810,-1291.1099900,2405.8820800,3508.3168900,0.0000000,0.0000000,-133.1990100); //
	CreateDynamicObject(2670,-1291.6949500,2407.3479000,3508.4140600,0.0000000,0.0000000,-85.5000000); //
	CreateDynamicObject(2671,-1298.8239700,2411.9689900,3508.3469200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(14860,-1300.0030500,2414.3129900,3509.7839400,-0.4990000,0.0000000,-89.5000000); //
	CreateDynamicObject(14860,-1293.3499800,2412.7680700,3509.3679200,2.3000000,0.4990000,-179.3999900); //
	CreateDynamicObject(19362,-1291.8449700,2412.6340300,3512.7419400,0.0000000,-86.1990000,-87.2990000); //
	CreateDynamicObject(2270,-1284.7829600,2409.1499000,3510.2529300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2281,-1292.3320300,2408.6359900,3510.2439000,0.0000000,0.0000000,89.8000000); //
	CreateDynamicObject(2073,-1287.0009800,2406.3640100,3511.9360400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1295.2070300,2409.2028800,3505.2229000,0.0000000,0.0000000,-20.6000000); //
	CreateDynamicObject(1543,-1294.8850100,2409.3898900,3505.2229000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1295.0040300,2409.2028800,3505.2229000,0.0000000,0.0000000,-20.6000000); //
	CreateDynamicObject(1543,-1295.1679700,2409.4609400,3505.2229000,0.0000000,0.0000000,-96.0000000); //
	CreateDynamicObject(1543,-1295.3809800,2409.3430200,3505.2229000,0.0000000,0.0000000,-96.0000000); //
	CreateDynamicObject(1544,-1295.3549800,2409.2219200,3505.2229000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1544,-1295.0550500,2409.3220200,3505.2229000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(336,-1291.8649900,2413.2060500,3509.2099600,-174.3990000,0.0000000,-163.8999900); //
	CreateDynamicObject(1544,-1294.8649900,2409.1320800,3505.2229000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(336,-1292.0150100,2413.1630900,3509.2009300,-175.5990000,7.0990000,-166.2000000); //
	CreateDynamicObject(1544,-1295.2950400,2408.6030300,3504.8588900,-100.6990000,0.0000000,-66.0000000); //
	CreateDynamicObject(1543,-1298.1750500,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.0849600,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.0040300,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1297.8850100,2409.4440900,3504.8930700,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.4549600,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.3349600,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.2249800,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.1040000,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1297.8940400,2409.3039600,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.4539800,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.3339800,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.2139900,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1298.0839800,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1297.9840100,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1543,-1297.8640100,2409.1440400,3504.8530300,0.0000000,0.0000000,0.0000000); //
	
	//NEW HINTS # RUNNER
	CreateDynamicObject(14795, 1386.39771, -97.79871, 1381.96582,   0.00000, 0.00000, 3.14159, -1, -1, -1, 200.0, 150.0);
	CreateDynamicObject(14859, 231.05659, 303.30231, 1700.14844,   0.00000, 0.00000, 3.00000, -1, -1, -1, 200.0, 150.0);
	CreateDynamicObject(14383, 2817.79199, -1193.10767, 1726.32031,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 150.0);
	
	//Level 2 complex - hodza
	CreateDynamicObject(19367, 453.14264, 510.56024, 1001.95453,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19367, 453.13803, 507.28854, 1001.95453,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19367, 454.89056, 511.40518, 1002.05139,   0.00000, 0.00000, 89.98003);
	CreateDynamicObject(19367, 457.33362, 511.39551, 1002.05139,   0.00000, 0.00000, 89.98003);
	CreateDynamicObject(19860, 442.43753, 508.58945, 1001.78705,   0.00000, 0.00000, 89.11897);

	//Level 3 complex - hodza
	CreateDynamicObject(19860, -2168.85596, 641.47437, 1057.83325,   0.00000, 0.00000, 89.50050);
	CreateDynamicObject(19367, -2168.90820, 644.57104, 1058.29810,   0.00000, 0.00000, 0.00000);
	
	// Franklins Crib - Atomic (403.1289,-1007.5123,92.5263)
	houses_map = CreateDynamicObject(2991, 434.61646, -1006.53577, 92.44875,   90.00000, 0.00000, 1.74000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 430.79706, -1006.64160, 92.44875,   90.00000, 0.00000, 1.74000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 437.15765, -1005.00165, 92.44875,   90.00000, 0.00000, 60.36001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.05969, -1001.59619, 92.44870,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.05225, -997.70544, 92.44870,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.02481, -995.45477, 92.44870,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.06970, -1001.59619, 90.52280,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.05219, -997.70538, 90.53660,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(2991, 438.04080, -995.45282, 90.52930,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	SetDynamicObjectMaterial(houses_map, 1, 5768, "sunrise05_lawn", "hedge1", 0xFF354D2F);
	houses_map = CreateDynamicObject(19371, 407.74591, -1005.52063, 90.79300,   -60.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19446, 412.76050, -1007.94470, 91.02430,   0.00000, 0.00000, 89.88000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19446, 422.34799, -1007.80762, 91.02830,   0.00000, 0.00000, 91.74000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19446, 431.94980, -1007.51178, 91.02430,   0.00000, 0.00000, 91.74000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19431, 437.29620, -1006.84210, 91.01750,   0.00000, 0.00000, -47.52000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19371, 438.51877, -1004.86298, 91.01357,   0.00000, 0.00000, -23.94000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19377, 439.15759, -998.18921, 87.95150,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFBAB8B5);
	houses_map = CreateDynamicObject(19378, 412.85361, -1005.98999, 89.60250,   0.00000, 0.00000, 90.18000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 406.49551, -1005.28662, 90.04150,   90.00000, 0.00000, 65.40000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 404.95255, -1002.88312, 90.04150,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 400.15643, -995.98376, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 401.83026, -994.30798, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 404.08850, -994.30908, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 403.52838, -985.71118, 93.06653,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 404.25290, -984.99072, 93.06650,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 403.52841, -993.44519, 93.06650,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19371, 419.99484, -985.03650, 93.00140,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 411.75290, -984.99072, 93.06650,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 430.29285, -995.42010, 93.06650,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19371, 419.99484, -985.03650, 89.47885,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 411.75290, -984.99072, 89.47000,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 404.25290, -984.99072, 89.47000,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 403.52841, -985.71118, 89.47000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19431, 403.52841, -993.44519, 89.47000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 391.35971, -988.36890, 86.49180,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 394.79541, -988.35101, 86.49780,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 400.06839, -992.57971, 86.49780,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 400.06671, -990.03729, 86.49780,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 398.27850, -988.36670, 86.49780,   90.00000, 0.00000, 89.52000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 434.03400, -991.68433, 86.04320,   0.00000, 0.00000, 4.86000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 430.25381, -988.31018, 86.04320,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 433.57181, -989.77698, 86.04320,   0.00000, 0.00000, -1.14000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 425.11200, -976.39008, 82.97950,   90.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 429.84439, -981.71637, 82.97950,   90.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.62360, -993.11407, 86.06230,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 390.99713, -1003.45148, 87.59550,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19446, 399.59018, -988.64880, 84.18714,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 433.56781, -989.77698, 75.73740,   0.00000, 0.00000, -1.14000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 430.25381, -988.31018, 75.55193,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 429.84039, -981.71637, 73.36050,   90.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 425.10800, -976.39410, 73.37910,   90.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 416.44531, -972.45239, 81.86760,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 416.44531, -972.44843, 72.27190,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 405.98819, -972.45392, 81.86760,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 405.98819, -972.44989, 72.26846,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 395.48819, -972.44989, 81.86760,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 395.48819, -972.45587, 72.27220,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 395.48819, -972.44989, 62.69630,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 394.73911, -972.44043, 81.86760,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 394.73911, -972.43439, 72.29880,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 394.73911, -972.44043, 62.91160,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.58105, -977.66022, 81.86760,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.58710, -977.66022, 72.28200,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.58109, -977.66022, 62.76260,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.61716, -988.10229, 81.86760,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.61719, -988.09631, 72.46870,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 388.61435, -997.07855, 86.06230,   0.00000, 0.00000, 141.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.34781, -1003.78278, 86.05630,   0.00000, 0.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19379, 389.63159, -993.11407, 87.00720,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19377, 434.38596, -992.99933, 85.27452,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19378, 439.23160, -998.17120, 85.70786,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  6056, "venice_law", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19378, 422.32953, -1005.82867, 89.60250,   0.00000, 0.00000, 90.18000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19378, 429.68790, -1005.79749, 89.60250,   0.00000, 0.00000, 90.18000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19378, 394.07431, -1001.34442, 90.65676,   0.00000, 0.00000, 141.48007,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 395.68866, -996.57300, 91.09130,   90.00000, 0.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 392.97525, -994.41241, 91.09130,   90.00000, 0.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 389.80078, -1004.00201, 91.09130,   90.00000, 0.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 387.11349, -1001.85962, 91.09130,   90.00000, 0.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19378, 388.67902, -997.08441, 90.65676,   0.00000, 0.00000, 141.48007,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19378, 434.44635, -1001.01257, 90.65680,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 432.76968, -996.27765, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 430.72592, -996.28656, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0xFFB3754B);
	houses_map = CreateDynamicObject(19446, 403.82748, -997.67615, 91.09133,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFE3D9BC);
	houses_map = CreateDynamicObject(19446, 401.52341, -997.67261, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFE3D9BC);
	houses_map = CreateDynamicObject(19389, 398.50049, -997.67242, 94.16170,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFE3D9BC);
	houses_map = CreateDynamicObject(19449, 397.57285, -980.39020, 87.54060,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 400.69891, -977.25702, 87.53060,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 407.18411, -980.39172, 87.53460,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 416.81281, -980.39258, 87.54060,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 421.60291, -977.25702, 86.09250,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 416.87451, -972.50751, 86.09250,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 407.25909, -972.50598, 86.08850,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 397.68506, -972.49884, 86.75433,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 389.63336, -983.75720, 87.73753,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 394.35239, -972.50232, 86.76030,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19449, 389.62891, -977.38629, 86.75430,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19451, 393.10684, -989.95599, 86.36147,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19371, 393.12997, -978.53583, 86.37150,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19371, 393.13089, -975.33508, 86.36950,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19371, 393.12921, -974.17590, 86.37150,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19371, 389.75699, -989.93964, 90.63930,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19447, 389.02191, -997.08392, 92.27290,   0.00000, 90.00000, 206.28000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19447, 391.17566, -997.04047, 92.31290,   0.00000, 90.00000, 206.28000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 395.01114, -996.13831, 91.54164,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 395.00488, -996.63416, 91.93864,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 392.86841, -994.93079, 91.93460,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 393.45700, -994.89758, 91.53760,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 393.88739, -994.75153, 91.13700,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(2991, 394.84781, -995.52087, 91.14100,   0.00000, 0.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19446, 403.01550, -1007.45355, 91.46100,   0.00000, 60.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19446, 395.78320, -1007.44952, 91.46100,   0.00000, 60.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19447, 402.99481, -1004.27063, 92.33340,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19447, 395.86771, -1004.26270, 92.32540,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19447, 401.33569, -1000.79272, 92.33740,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19447, 394.52972, -1000.77948, 92.33340,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19447, 400.84470, -999.45319, 92.32940,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 398.30475, -989.73499, 87.74430,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 408.67871, -986.86981, 87.75030,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 416.40771, -986.88672, 87.74430,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 426.50540, -984.61121, 87.75034,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 394.84161, -989.75348, 87.72080,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 398.30469, -986.86902, 87.73830,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(19377, 394.84161, -986.86951, 87.71480,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10412, "hotel1", "ws_stationfloor", 0);
	houses_map = CreateDynamicObject(14416, 398.11356, -995.40662, 89.20570,   0.00000, 0.00000, 180.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	SetDynamicObjectMaterial(houses_map, 1, 16150, "ufo_bar", "GEwhite1_64", 0xFFEDEDE8);
	houses_map = CreateDynamicObject(19371, 386.89929, -991.80432, 92.13750,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 390.05710, -991.80890, 92.13350,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(14416, 393.51834, -992.02917, 89.20570,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	SetDynamicObjectMaterial(houses_map, 1, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19377, 394.86447, -993.11310, 91.27232,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 390.05710, -991.80890, 92.31450,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 388.66849, -990.03912, 92.31030,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 386.89929, -991.80432, 92.31850,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 386.90451, -990.04108, 92.31430,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 399.80023, -986.15765, 91.23293,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 406.87830, -983.22803, 91.22690,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 416.50397, -983.22522, 91.23290,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 423.04999, -981.10828, 91.22690,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19377, 429.68539, -990.98651, 91.25030,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19377, 427.38400, -986.04962, 91.25430,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 406.87830, -983.22803, 95.86624,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 416.50400, -983.22522, 95.86020,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 423.04999, -981.10828, 95.86620,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19377, 427.38400, -986.04962, 95.86020,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19377, 429.68539, -990.98651, 95.86620,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 401.87869, -989.29169, 95.86420,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 405.10486, -985.66302, 95.86020,   0.00000, 90.00000, 56.64000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 409.68170, -1005.84833, 94.79570,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 419.31079, -1005.84558, 94.79970,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 428.78171, -1005.84192, 94.80570,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 429.70480, -1005.83789, 94.79970,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19450, 396.85638, -976.91345, 87.67130,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19450, 396.85321, -974.21198, 87.66530,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(14414, 401.54550, -989.90369, 88.14270,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	SetDynamicObjectMaterial(houses_map, 1, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 403.50696, -992.53247, 95.08949,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 403.51099, -989.03247, 95.08950,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 403.50699, -986.53247, 95.08950,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 405.16870, -984.83008, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 408.66870, -984.83612, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 412.16870, -984.83008, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 415.66870, -984.83612, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 419.16870, -984.83008, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 422.16870, -984.83612, 95.08950,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 423.12411, -983.55920, 95.08950,   90.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 425.53278, -983.41431, 95.08950,   90.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 427.97247, -985.85577, 95.08950,   90.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 429.15851, -987.06042, 95.08950,   90.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 430.30249, -989.97333, 95.08950,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 430.30859, -993.39368, 95.08950,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19431, 430.31509, -996.02441, 95.08950,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 429.67209, -1005.75677, 94.14350,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 420.16266, -1005.73206, 94.14350,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 410.68237, -1004.99957, 94.14350,   0.00000, 0.00000, 81.11998,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 409.76004, -1004.21228, 94.14350,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 391.52780, -990.11896, 90.63930,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(14397, 424.88797, -977.33813, 80.50827,   0.00000, 90.00000, -47.40001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(14397, 432.90430, -985.35846, 80.50827,   0.00000, 90.00000, -47.40001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(14397, 402.07184, -981.59729, 80.50827,   0.00000, 90.00000, -47.40001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19617, 399.60471, -973.29187, 88.39570,   -90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19617, 398.74200, -973.29187, 88.39170,   -90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(14397, 385.16556, -988.80768, 76.85319,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(14397, 386.16559, -995.80768, 76.80520,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19379, 408.66730, -989.81927, 91.22330,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 397.16510, -981.70270, 86.64720,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 395.66000, -980.18652, 86.65120,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 393.81699, -980.19281, 86.64720,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 392.29520, -981.72009, 86.65120,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 392.29681, -983.57458, 86.65520,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 393.82071, -985.10748, 86.64720,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 395.64999, -985.10681, 86.65120,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19371, 397.17001, -983.59180, 86.65720,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19448, 405.12247, -999.29785, 94.14350,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 5401, "jeffers4_lae", "floorboard256128", 0);
	houses_map = CreateDynamicObject(19446, 422.16251, -986.90631, 91.41350,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19377, 424.02759, -989.33539, 91.09700,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19377, 424.02759, -989.33539, 87.91279,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 408.75729, -989.75928, 91.39050,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 419.15302, -989.77789, 91.38650,   0.00000, 90.00000, -0.12000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 425.06561, -993.03229, 91.39050,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 428.78220, -988.98822, 91.09130,   90.00000, 0.00000, 116.52003,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 424.15491, -983.99707, 91.09130,   90.00000, 0.00000, -8.06000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 426.19958, -986.54211, 91.09130,   90.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 428.57141, -991.51782, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 422.89679, -986.09558, 91.09130,   90.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 418.29321, -986.70569, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 412.63849, -986.68420, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 415.38324, -986.69843, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 410.86963, -986.69135, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 405.13538, -986.69312, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 407.95630, -986.69299, 91.09130,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 405.27768, -989.75604, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 405.23221, -992.55688, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 405.19833, -986.57684, 91.09130,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 408.75729, -989.75928, 94.26366,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 419.15302, -989.77789, 94.26770,   0.00000, 90.00000, -0.12000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 425.06561, -993.03229, 94.26370,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 424.58066, -984.71667, 91.41545,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 427.03769, -987.17761, 91.41150,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 427.94250, -988.08929, 91.41550,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 424.58069, -984.71667, 94.26312,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 427.03769, -987.17761, 94.26710,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19371, 427.94250, -988.08929, 94.26310,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19446, 422.16251, -986.90625, 94.26107,   0.00000, 90.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19379, 408.75729, -989.75928, 87.89653,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19379, 408.75729, -989.75928, 91.06618,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 419.15302, -989.77789, 87.89340,   0.00000, 90.00000, -0.12000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19378, 419.15302, -989.77789, 91.06391,   0.00000, 90.00000, -0.12000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19431, 413.54050, -1005.98853, 93.97420,   88.00000, 90.18000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19431, 430.62680, -1005.79340, 93.98620,   88.00000, 90.18000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19380, 409.83786, -985.93201, 91.06963,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19380, 417.31400, -985.95697, 91.06963,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19380, 420.40292, -987.98804, 91.06960,   90.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19380, 428.52075, -993.89307, 91.06960,   90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(19380, 425.61713, -988.17682, 90.71343,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 1223, "dynsigns", "white64", 0xFF000000);
	houses_map = CreateDynamicObject(3850, 400.07175, -990.03406, 91.83410,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 391.77994, -988.30890, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 393.51471, -988.30627, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 396.49490, -987.06372, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 398.95911, -984.60260, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 400.82565, -982.71832, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 403.82764, -981.56683, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 407.31421, -981.56488, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 410.79279, -981.56610, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 414.27170, -981.56488, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 417.75360, -981.56580, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 418.48740, -981.57330, 91.83410,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 421.46997, -980.32587, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 423.94949, -977.84601, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 426.46027, -977.80988, 91.83410,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 428.95490, -980.30078, 91.83410,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 431.39575, -982.74780, 91.83410,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 433.18314, -984.52240, 91.83410,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 434.44641, -987.49921, 91.83410,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 434.44601, -990.97021, 91.83410,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 434.44800, -994.44342, 91.83410,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 388.47711, -988.34503, 92.87469,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 387.04630, -988.34979, 92.87470,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 385.33224, -990.13513, 92.87470,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 422.94083, -973.87177, 88.38380,   0.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 425.26321, -976.47748, 88.38380,   0.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 427.66519, -979.01349, 88.38380,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 430.12509, -981.47931, 88.38380,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 432.28629, -983.62457, 88.38380,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 401.26047, -987.00470, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 402.23444, -986.03473, 91.83410,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 385.33282, -991.79553, 92.87470,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 402.01556, -997.76337, 93.12420,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	houses_map = CreateDynamicObject(3850, 403.73663, -1001.15509, 93.12420,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF363636);
	CreateDynamicObject(19325, 415.36823, -984.97253, 93.33739,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 408.05667, -984.98425, 93.33739,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 403.53705, -989.60315, 93.33740,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 421.97302, -984.65289, 93.33740,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 430.29483, -991.56738, 93.33740,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 426.72736, -984.67596, 93.33740,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 427.91891, -985.87280, 93.33740,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 408.05667, -984.98425, 89.20091,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 415.36819, -984.97247, 89.20090,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 426.72739, -984.67603, 89.20090,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 431.42169, -989.37042, 89.20090,   0.00000, 0.00000, 45.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 403.53699, -989.60309, 89.20000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19325, 421.97299, -984.65289, 89.20000,   0.00000, 0.00000, 135.00000,-1,-1,-1,200,200);
	houses_map = CreateDynamicObject(19378, 391.27597, -999.10394, 95.85965,   0.00000, 90.00000, 231.48010,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19446, 405.11691, -985.67297, 96.01160,   0.00000, 90.00000, 56.64000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 404.95010, -989.73450, 95.99820,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 409.67819, -1000.63593, 95.99220,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 419.26410, -1000.65167, 95.99820,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 429.34140, -1001.09277, 95.99220,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 429.77341, -991.02649, 95.98240,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 427.41400, -986.04962, 96.01820,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 424.90710, -983.53857, 96.01220,   0.00000, 90.00000, 45.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 406.85110, -986.70837, 96.00420,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19377, 416.43970, -986.69312, 96.01020,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 421.62543, -992.42834, 96.04304,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 411.35861, -992.43134, 96.04900,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19378, 405.37280, -992.97113, 95.98700,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFA3A3A3);
	houses_map = CreateDynamicObject(19448, 416.81320, -981.19720, 87.61864,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "ab_tile2", 0xFF5E4343);
	houses_map = CreateDynamicObject(19448, 407.19809, -981.19739, 87.61460,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "ab_tile2", 0xFF5E4343);
	houses_map = CreateDynamicObject(19448, 397.57080, -981.19812, 87.61860,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "ab_tile2", 0xFF5E4343);
	houses_map = CreateDynamicObject(19446, 406.80899, -999.43347, 92.50930,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "ab_tile2", 0xFF5E4343);
	houses_map = CreateDynamicObject(19450, 421.57690, -977.27100, 85.87050,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 416.69336, -972.51160, 85.87050,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 407.28351, -972.51190, 85.86450,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 402.37021, -977.26233, 85.86450,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 416.69339, -978.71362, 85.87050,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 407.28351, -978.71393, 85.86450,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19377, 407.11890, -977.33038, 86.86982,   0.00000, -88.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19377, 416.29919, -977.40027, 86.67147,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19603, 394.73669, -982.62268, 87.90163,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10444, "hotelbackpool_sfs", "Bow_sub_walltiles",  0xFF195B75);
	houses_map = CreateDynamicObject(19450, 391.43661, -977.32440, 87.79684,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 8671, "vegassland62", "greystones01_128", 0xFF575757);
	houses_map = CreateDynamicObject(19450, 391.43661, -986.72852, 87.80080,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 8671, "vegassland62", "greystones01_128", 0xFF575757);
	houses_map = CreateDynamicObject(19431, 394.42886, -994.97034, 91.70667,   0.00000, 90.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 8671, "vegassland62", "greystones01_128", 0xFF575757);
	houses_map = CreateDynamicObject(19431, 394.32706, -995.35699, 92.08372,   0.00000, 90.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 8671, "vegassland62", "greystones01_128", 0xFF575757);
	houses_map = CreateDynamicObject(19431, 394.16116, -995.71936, 92.48610,   0.00000, 90.00000, 141.48000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 8671, "vegassland62", "greystones01_128", 0xFF575757);
	houses_map = CreateDynamicObject(19451, 423.27484, -981.04462, 87.65623,   0.00000, 90.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19451, 426.09521, -980.10541, 87.65220,   0.00000, 90.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19431, 423.28955, -975.55865, 87.61754,   0.00000, 90.00000, 131.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19431, 422.45261, -975.92157, 87.62350,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19617, 422.02301, -973.79944, 87.66218,   -90.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19617, 422.25940, -973.64410, 87.65820,   -90.00000, 0.00000, 41.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19565, 421.79315, -973.14032, 87.70290,   90.00000, 0.00000, 131.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19565, 421.67099, -972.95618, 87.70690,   90.00000, 0.00000, 131.70000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19565, 421.68140, -973.22449, 87.69890,   90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19377, 434.40393, -998.21375, 90.11829,   0.00000, 90.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(17951, 394.07999, -1001.46625, 93.75027,   0.00000, 0.00000, 141.12012,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0,  -1, "none", "none", 0xFF4D4D4D);
	houses_map = CreateDynamicObject(1481, 399.15894, -973.33392, 88.40007,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1,  -1, "none", "none", 0xFF4D4D4D);
	houses_map = CreateDynamicObject(1827, 395.75470, -975.70166, 87.72066,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0xFF919191);
	SetDynamicObjectMaterial(houses_map, 1, 12954, "sw_furniture", "CJ_WOOD5", 0xFF919191);
	houses_map = CreateDynamicObject(2121, 394.68637, -974.38947, 88.22180,   0.00000, 0.00000, 48.54001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(2121, 394.31726, -976.45258, 88.22180,   0.00000, 0.00000, 82.32003,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(2121, 396.19583, -977.13214, 88.22180,   0.00000, 0.00000, 221.34001,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(2121, 397.41058, -975.90204, 88.22180,   0.00000, 0.00000, 264.11996,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(2121, 396.20850, -974.24408, 88.22180,   0.00000, 0.00000, 369.47989,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19617, 399.60471, -973.29187, 88.39570,   -90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19617, 398.74200, -973.29187, 88.39170,   -90.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 12954, "sw_furniture", "CJ_WOOD5", 0);
	CreateDynamicObject(700, 436.17715, -994.51044, 90.31755,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(700, 437.24506, -998.98285, 90.36063,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(700, 436.91080, -1003.23779, 90.03526,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(632, 423.13608, -980.33417, 87.70369,   0.00000, 0.00000, -14.10000,-1,-1,-1,200,200);
	CreateDynamicObject(632, 425.99023, -977.18225, 87.70369,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(632, 422.98386, -973.76666, 87.55424,   0.00000, 0.00000, 16.50000,-1,-1,-1,200,200);
	CreateDynamicObject(3920, 389.57111, -987.85651, 88.55440,   5.00000, 0.00000, -90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 430.51413, -984.82513, 91.88787,   0.00000, 0.00000, 61.85999,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 429.25507, -983.27271, 91.88787,   0.00000, 0.00000, 23.69999,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 423.27237, -977.94617, 88.28993,   0.00000, 0.00000, -191.75999,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 423.36148, -976.33826, 88.28993,   0.00000, 0.00000, -170.51999,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 419.24954, -980.64703, 88.26631,   0.00000, 0.00000, 109.26000,-1,-1,-1,200,200);
	CreateDynamicObject(1255, 400.31067, -977.53040, 88.31216,   0.00000, 0.00000, 25.02000,-1,-1,-1,200,200);
	CreateDynamicObject(1687, 408.33630, -987.26392, 96.81170,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1687, 429.13925, -1001.49323, 96.81170,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1688, 412.35629, -997.83063, 97.03570,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1688, 423.41104, -988.26477, 97.03570,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1691, 412.24344, -987.87628, 96.26630,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(1691, 419.05649, -998.23267, 96.26630,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(3109, 399.36377, -997.66602, 93.64747,   0.00000, 0.00000, -22.20000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF7A7A7A);
	CreateDynamicObject(762, 422.35898, -974.78357, 73.17046,   0.00000, 0.00000, -22.26000,-1,-1,-1,200,200);
	CreateDynamicObject(762, 407.46085, -974.52039, 72.74217,   0.00000, 0.00000, 24.18000,-1,-1,-1,200,200);
	CreateDynamicObject(640, 412.03146, -1006.85071, 91.76908,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(640, 390.34085, -975.60425, 88.52028,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19573, 399.70547, -973.35980, 87.75389,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19582, 398.86725, -973.37439, 88.53191,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19582, 399.13895, -973.37994, 88.53190,   0.00000, 0.00000, 180.00000,-1,-1,-1,200,200);
	CreateDynamicObject(19582, 399.36441, -973.37842, 88.53191,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	CreateDynamicObject(3920, 395.98880, -972.53717, 87.48462,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	houses_map = CreateDynamicObject(10444, 406.48074, -979.78680, 87.53819,   0.00000, 0.00000, 90.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none",  0xFF2D7591);
	houses_map = CreateDynamicObject(19603, 394.73672, -982.62268, 88.22840,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none",  0xFF2D7591);
	houses_map = CreateDynamicObject(630, 390.59500, -986.97528, 88.86813,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 391.59698, -987.56702, 88.78748,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 398.60916, -987.46344, 88.85558,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 401.16232, -973.13885, 88.60751,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(632, 394.73416, -973.12115, 88.03860,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 393.91241, -978.28589, 88.60750,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 430.24133, -987.23175, 88.72894,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(632, 433.17719, -984.63983, 88.16268,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 424.62451, -978.78040, 92.27953,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 426.27509, -978.73297, 92.27950,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 433.85687, -986.96008, 92.29714,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 421.30777, -984.45538, 92.22260,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 396.55719, -995.85797, 92.65020,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 393.18625, -993.13422, 92.65020,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 392.42419, -993.50598, 93.45020,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 396.55649, -996.79999, 93.45020,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 389.76819, -988.91132, 93.39810,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 390.00351, -994.51300, 93.39810,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 388.72000, -995.73511, 93.39810,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(632, 389.18011, -994.65448, 92.67810,   0.00000, 0.00000, 0.60000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 403.18390, -982.36298, 88.70200,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(630, 402.60010, -998.26959, 93.59000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 404.49921, -998.32703, 93.59000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(631, 404.46255, -1000.75592, 93.59000,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(632, 404.59973, -1002.20825, 92.81000,   0.00000, 0.00000, -9.24000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(19371, 405.09259, -999.38379, 94.32180,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, 10377, "cityhall_sfs", "ws_bigwooddoor", 0);
	houses_map = CreateDynamicObject(1409, 399.79181, -998.15338, 92.50060,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF3E85A8);
	SetDynamicObjectMaterial(houses_map, 1, -1, "none", "none", 0xFF3E85A8);
	houses_map = CreateDynamicObject(1409, 400.63181, -998.15338, 92.50060,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF359437);
	SetDynamicObjectMaterial(houses_map, 1, -1, "none", "none", 0xFF359437);
	houses_map = CreateDynamicObject(1409, 401.44379, -998.15338, 92.50060,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterial(houses_map, 0, -1, "none", "none", 0xFF3E85A8);
	SetDynamicObjectMaterial(houses_map, 1, -1, "none", "none", 0xFF3E85A8);
	houses_map = CreateDynamicObject(19327, 400.61548, -997.76678, 93.7,   0.00000, 0.00000, 0.00000,-1,-1,-1,200,200);
	SetDynamicObjectMaterialText(houses_map, 0, "3671", OBJECT_MATERIAL_SIZE_512x512, "Arial", 100, 0, 0xFF636363,0,0);

	// House Int - Atomic
	houses_map = CreateDynamicObject(19377, 232.38838, -1364.25452, 50.48890,   90.00000, 0.00000, -50.58000, -1, -1, -1, 50,50);	
	SetDynamicObjectMaterial( houses_map, 0,  6293, "lawland2", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19377, 224.28000, -1370.92236, 50.48890,   90.00000, 0.00000, -50.58000, -1, -1, -1, 50,50);	
	SetDynamicObjectMaterial( houses_map, 0,  6293, "lawland2", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19377, 223.36754, -1378.45361, 50.48890,   90.00000, 0.00000, -144.48007, -1, -1, -1, 50,50);	
	SetDynamicObjectMaterial( houses_map, 0,  6293, "lawland2", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19377, 229.45770, -1386.97742, 50.48890,   90.00000, 0.00000, -144.48007, -1, -1, -1, 50,50);	
	SetDynamicObjectMaterial( houses_map, 0,  6293, "lawland2", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19377, 235.53410, -1395.47888, 50.48890,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);	
	SetDynamicObjectMaterial( houses_map, 0,  6293, "lawland2", "stonewall_la", 0);
	houses_map = CreateDynamicObject(19378, 235.58496, -1368.49060, 48.27315,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19378, 241.63609, -1376.96924, 48.27320,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19378, 243.79504, -1380.04468, 48.27320,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19378, 242.79883, -1396.61621, 48.27120,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 241.95381, -1385.64697, 53.00675,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 238.62500, -1388.04346, 53.00470,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 232.32100, -1384.51453, 53.00670,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 227.26759, -1377.43628, 53.00470,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 228.82605, -1372.60571, 53.00675,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 231.39290, -1370.77295, 53.00870,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 240.77870, -1378.66199, 53.00470,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19446, 237.50610, -1374.06934, 53.00670,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19378, 248.28461, -1386.33618, 48.27320,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19378, 247.03410, -1393.58899, 48.27320,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19464, 238.20108, -1390.60730, 52.96310,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(14407, 247.43468, -1381.45288, 49.73536,   0.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  10226, "sfeship1", "CJ_WOOD5", 0);
	houses_map = CreateDynamicObject(19445, 232.73964, -1388.45483, 52.96870,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19445, 227.17133, -1380.63892, 52.96870,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19445, 224.60590, -1377.11816, 52.96670,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19445, 226.02725, -1371.79089, 52.96870,   0.00000, 90.00000, -50.58000, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19445, 229.74280, -1368.73425, 52.96670,   0.00000, 90.00000, -50.58000, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19464, 241.06880, -1394.63000, 52.92710,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19445, 237.26691, -1394.74036, 52.96670,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  9495, "vict_sfw", "Grass_128HV", 0);
	houses_map = CreateDynamicObject(19379, 244.26601, -1389.60327, 52.83600,   0.00000, 90.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  16109, "des_se1", "des_ripplsand", 0);
	CreateDynamicObject(634, 233.87325, -1366.81519, 50.38449,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(634, 224.47630, -1373.98120, 50.38449,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(904, 224.28770, -1372.83862, 53.03551,   0.00000, 0.00000, 72.41999, -1, -1, -1, 50,50);
	CreateDynamicObject(904, 224.89383, -1378.64978, 53.03551,   0.00000, 0.00000, 156.47998, -1, -1, -1, 50,50);
	CreateDynamicObject(634, 231.38261, -1386.64026, 51.83828,   0.00000, 0.00000, -34.50000, -1, -1, -1, 50,50);
	CreateDynamicObject(904, 231.63779, -1388.14514, 52.08462,   0.00000, 0.00000, 148.50000, -1, -1, -1, 50,50);
	CreateDynamicObject(1597, 227.33490, -1382.14014, 54.98816,   0.00000, 0.00000, 40.38000, -1, -1, -1, 50,50);
	CreateDynamicObject(1597, 228.48430, -1369.39331, 54.98816,   0.00000, 0.00000, -54.06001, -1, -1, -1, 50,50);
	CreateDynamicObject(677, 232.93715, -1365.12891, 53.01820,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(677, 231.89711, -1367.10645, 53.01820,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(677, 232.13892, -1366.39954, 53.01820,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(677, 223.07515, -1373.73914, 53.01820,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(802, 222.84898, -1376.23206, 53.23454,   0.00000, 0.00000, 35.88000, -1, -1, -1, 50,50);
	CreateDynamicObject(802, 226.79955, -1381.62830, 53.23454,   0.00000, 0.00000, 35.88000, -1, -1, -1, 50,50);
	CreateDynamicObject(802, 230.56239, -1386.76611, 53.23454,   0.00000, 0.00000, 35.88000, -1, -1, -1, 50,50);
	CreateDynamicObject(806, 234.06010, -1390.89502, 55.62674,   0.00000, 0.00000, -32.46000, -1, -1, -1, 50,50);
	CreateDynamicObject(828, 224.19908, -1377.46912, 52.92670,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(829, 232.63602, -1390.04517, 52.92670,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(634, 239.82062, -1397.95618, 51.83828,   0.00000, 0.00000, -34.50000, -1, -1, -1, 50,50);
	CreateDynamicObject(1597, 239.53131, -1395.01489, 54.98816,   0.00000, 0.00000, 107.46001, -1, -1, -1, 50,50);
	CreateDynamicObject(806, 242.44455, -1392.64136, 55.62674,   0.00000, 0.00000, -32.46000, -1, -1, -1, 50,50);
	CreateDynamicObject(802, 235.40652, -1393.38062, 53.23454,   0.00000, 0.00000, 35.88000, -1, -1, -1, 50,50);
	CreateDynamicObject(651, 248.56134, -1390.03223, 52.92250,   0.00000, 0.00000, -65.40000, -1, -1, -1, 50,50);
	CreateDynamicObject(650, 246.65239, -1390.70300, 52.92250,   0.00000, 0.00000, -293.21997, -1, -1, -1, 50,50);
	CreateDynamicObject(634, 253.37074, -1391.88403, 51.25135,   0.00000, 0.00000, -34.50000, -1, -1, -1, 50,50);
	CreateDynamicObject(673, 261.18607, -1385.92065, 50.33250,   356.85840, 0.00000, 26.05654, -1, -1, -1, 50,50);
	CreateDynamicObject(673, 248.35350, -1394.91943, 50.33250,   356.85840, 0.00000, 26.05654, -1, -1, -1, 50,50);
	CreateDynamicObject(700, 230.67885, -1362.29492, 52.34375,   356.85840, 0.00000, -2.00713, -1, -1, -1, 50,50);
	CreateDynamicObject(700, 255.43462, -1388.86121, 52.34375,   356.85840, 0.00000, -2.00713, -1, -1, -1, 50,50);
	houses_map = CreateDynamicObject(19379, 238.68408, -1382.88135, 52.05040,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19379, 233.49550, -1375.88330, 52.03070,   0.00000, 90.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 233.67720, -1383.57483, 51.33910,   0.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 228.85890, -1376.82434, 51.33910,   0.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 236.21410, -1375.11133, 51.33910,   0.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 239.4220, -1379.5905, 51.3391,   0.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 239.61571, -1385.29639, 51.33910,   0.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(19448, 230.80370, -1373.22961, 51.33910,   0.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0,  8532, "tikigrass", "swimpoolbtm1_128", 0);
	houses_map = CreateDynamicObject(10444, 236.22914, -1382.41272, 52.70797,   0.00000, 0.00000, -144.00000, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, -1, "none", "none", 0xFF0078B3);
	CreateDynamicObject(1255, 239.90657, -1389.99329, 53.64958,   0.00000, 0.00000, 150.11998, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 238.68410, -1391.28040, 53.64958,   0.00000, 0.00000, 127.73997, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 236.62907, -1390.91174, 53.64958,   0.00000, 0.00000, 88.61996, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 235.02661, -1389.32373, 53.64958,   0.00000, 0.00000, 73.43996, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 225.28261, -1374.79822, 53.64958,   0.00000, 0.00000, 4.25996, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 226.09299, -1376.69983, 53.64958,   0.00000, 0.00000, 51.71997, -1, -1, -1, 50,50);
	CreateDynamicObject(1255, 227.13922, -1372.98035, 53.64958,   0.00000, 0.00000, -82.62003, -1, -1, -1, 50,50);
	houses_map = CreateDynamicObject(9131, 241.50830, -1382.41479, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 234.42700, -1384.80688, 52.85670,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 233.18073, -1383.06519, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 237.65517, -1377.03247, 52.85670,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 230.5475, -1379.3801, 52.8587,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 229.3364, -1377.6962, 52.8567,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 234.02242, -1371.97217, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 228.20670, -1376.12976, 52.85870,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 236.34470, -1375.20740, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 235.04262, -1373.38660, 52.85670,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 231.8627, -1381.2237, 52.8567,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 238.95718, -1378.85388, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 240.20346, -1380.59558, 52.85670,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 235.73184, -1386.62610, 52.85869,   90.00000, 0.00000, -144.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 237.08141, -1387.19177, 52.85670,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 238.84180, -1385.93408, 52.85870,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 240.60130, -1384.68054, 52.85670,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 241.65450, -1383.93774, 52.85470,   90.00000, 0.00000, -234.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 228.25316, -1374.88281, 52.85670,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 230.09540, -1373.56628, 52.85870,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 231.81416, -1372.33154, 52.85670,   90.00000, 0.00000, -54.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	houses_map = CreateDynamicObject(9131, 232.82608, -1371.61523, 52.85470,   90.00000, 0.00000, -234.48010, -1, -1, -1, 50,50);
	SetDynamicObjectMaterial( houses_map, 0, 14675, "civic02cj", "ab_hosWallUpr", 0xFFFFFFFF);
	CreateDynamicObject(1481, 246.61758, -1388.19592, 53.59464,   0.00000, 0.00000, -144.36002, -1, -1, -1, 50,50);
	CreateDynamicObject(19582, 246.81734, -1388.00635, 53.71546,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(19582, 246.69769, -1388.08167, 53.71546,   0.00000, 0.00000, 40.02001, -1, -1, -1, 50,50);
	CreateDynamicObject(19582, 246.47363, -1388.21948, 53.71546,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50,50);
	CreateDynamicObject(19582, 246.36949, -1388.31335, 53.71546,   0.00000, 0.00000, -152.93996, -1, -1, -1, 50,50);
	CreateDynamicObject(19573, 246.12401, -1388.50085, 52.92409,   0.00000, 0.00000, -56.52000, -1, -1, -1, 50,50);
	CreateDynamicObject(19573, 246.38200, -1388.31812, 53.30050,   -85.00000, 0.00000, -56.52000, -1, -1, -1, 50,50);

	//Smokva int
	houses_map = CreateDynamicObject(19379, 2060.111816, 2587.504882, 3008.462402, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 17933, "carter_mainmap", "mp_carter_carpet", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 16338, "dam_genroom", "dam_terazzoedge", 0x00000000);
    houses_map = CreateDynamicObject(19456, 2064.881591, 2587.692138, 3010.283203, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19456, 2059.987304, 2592.231933, 3010.283203, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19456, 2055.427490, 2587.692138, 3010.283203, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19916, 2057.903564, 2583.226318, 3008.530517, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16137, "des_bigearstuff", "dirtyledge_law", 0x00000000);
    houses_map = CreateDynamicObject(2132, 2056.998535, 2583.403320, 3008.490722, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3906, "libertyhi5", "walldirtynewa256128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 1, 3906, "libertyhi5", "walldirtynewa256128", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 2, 3906, "libertyhi5", "walldirtynewa256128", 0x00000000);
    houses_map = CreateDynamicObject(19937, 2058.531005, 2583.773437, 3008.541259, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 3906, "libertyhi5", "walldirtynewa256128", 0x00000000);
    houses_map = CreateDynamicObject(11706, 2058.468017, 2585.012451, 3008.526855, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 16137, "des_bigearstuff", "dirtyledge_law", 0x00000000);
    houses_map = CreateDynamicObject(19456, 2060.333251, 2582.964355, 3010.266845, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(1814, 2061.321044, 2583.667724, 3008.550537, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5520, "bdupshouse_lae", "sw_woodflloor", 0x00000000);
    houses_map = CreateDynamicObject(1814, 2061.319091, 2583.667724, 3008.129882, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 5520, "bdupshouse_lae", "sw_woodflloor", 0x00000000);
    houses_map = CreateDynamicObject(2313, 2062.929687, 2587.764404, 3008.546875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 2, 5520, "bdupshouse_lae", "sw_woodflloor", 0x00000000);
    houses_map = CreateDynamicObject(19364, 2063.680664, 2588.333251, 3010.281005, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19437, 2061.293945, 2588.333984, 3010.280761, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19437, 2060.402343, 2589.046875, 3010.270019, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19393, 2060.401855, 2591.437011, 3010.267578, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 18202, "w_towncs_t", "pax256hi", 0x00000000);
    houses_map = CreateDynamicObject(19364, 2063.680664, 2588.512207, 3010.281005, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "Bow_sub_decortop", 0x00000000);
    houses_map = CreateDynamicObject(19437, 2061.293945, 2588.510009, 3010.280761, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 13724, "docg01_lahills", "Bow_sub_decortop", 0x00000000);
    houses_map = CreateDynamicObject(2462, 2060.792480, 2588.162353, 3008.548339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "cj_sheetmetal", 0x00000000);
    houses_map = CreateDynamicObject(19379, 2060.111816, 2587.504882, 3012.107177, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 17562, "coast_apts", "pave_dirty", 0x00000000);
    houses_map = CreateDynamicObject(2231, 2061.275390, 2584.504394, 3009.056396, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 2, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    houses_map = CreateDynamicObject(2231, 2061.275390, 2583.304443, 3009.056396, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 2, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 3, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 6, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 7, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 8, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 9, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 10, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 11, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 12, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 13, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 14, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    SetDynamicObjectMaterial(houses_map, 15, 11391, "hubprops2_sfse", "blackbag", 0x00000000);
    houses_map = CreateDynamicObject(19379, 2065.567138, 2593.449951, 3008.502441, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 10399, "countryclbgnd_sfs", "ws_tantiles1btm", 0x00000000);
    houses_map = CreateDynamicObject(2462, 2061.523193, 2588.162353, 3008.548339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(houses_map, 0, 14584, "ab_abbatoir01", "cj_sheetmetal", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    houses_map = CreateDynamicObject(2764, 2055.971191, 2586.145019, 3008.937500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2121, 2057.666748, 2585.697021, 3009.029296, 0.000000, 0.000000, -113.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2587, 2064.731689, 2585.859375, 3010.277587, 0.000000, -10.800000, -90.099891, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2121, 2055.976562, 2586.683593, 3009.029296, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2121, 2055.976562, 2585.663574, 3009.029296, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2858, 2056.100341, 2586.383544, 3009.355468, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2821, 2055.733398, 2585.911132, 3009.355712, 0.000000, 0.000000, -48.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(3034, 2055.518554, 2586.285888, 3010.810546, 0.000000, 0.000000, 89.900085, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2848, 2056.798339, 2583.333251, 3009.540771, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2149, 2057.284667, 2583.358886, 3009.692871, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.507324, 2583.075195, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.369873, 2583.399169, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.368408, 2583.130371, 3009.604003, 0.000000, 90.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(917, 2058.538085, 2583.744384, 3009.707275, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.958251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.958251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.958251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.883300, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.808349, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.733398, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.658203, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.424316, 2583.583251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.883300, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.883300, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.808349, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.808349, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.733398, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.733398, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.658203, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.658203, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.514404, 2583.583251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2058.604248, 2583.583251, 3009.559814, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1764, 2059.184570, 2583.126708, 3008.516601, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19611, 2060.798095, 2584.146972, 3007.676025, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19611, 2060.797363, 2584.691162, 3007.625976, 19.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19611, 2060.797607, 2583.599365, 3007.625976, -19.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(18868, 2060.821289, 2584.122558, 3009.322998, 0.000000, -90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1707, 2064.330078, 2583.786621, 3008.494384, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1795, 2063.096923, 2582.962158, 3008.539062, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19787, 2063.650390, 2587.708007, 3009.581298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19611, 2063.663574, 2587.635986, 3008.004882, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2145, 2062.259765, 2588.005126, 3008.528808, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2819, 2061.491455, 2584.184570, 3008.569335, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2844, 2062.995117, 2584.341064, 3008.554931, 0.000000, 0.000000, 59.280010, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2062.325195, 2586.232421, 3008.828125, 0.000000, 0.000000, 164.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2056.461914, 2588.352050, 3008.824462, 0.000000, 0.000000, 55.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2057.321533, 2585.247558, 3008.824462, 0.000000, 0.000000, 153.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2060.105712, 2585.753417, 3008.824462, 0.000000, 0.000000, 4.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1498, 2059.969238, 2588.496826, 3008.534423, 7.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1498, 2057.187500, 2592.153076, 3008.534423, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1491, 2060.391601, 2590.679931, 3008.526367, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2058.306640, 2588.260498, 3008.824462, 0.000000, 0.000000, 273.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2121, 2056.975585, 2587.031250, 3008.813964, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2588, 2064.733398, 2584.573974, 3010.168945, 0.000000, 22.699998, -89.899978, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19631, 2062.221435, 2583.833740, 3008.977294, 105.000000, -90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2677, 2057.801513, 2590.506347, 3008.824462, 0.000000, 0.000000, 76.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1440, 2056.202880, 2590.659179, 3009.055419, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1785, 2061.079589, 2584.152099, 3009.157470, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19141, 2058.609863, 2584.195556, 3009.608886, -22.000000, -90.000000, -93.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19137, 2058.563964, 2584.543945, 3009.719238, 16.000000, -90.000000, -95.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19319, 2059.921386, 2583.153076, 3009.237548, -8.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1665, 2060.542236, 2583.558105, 3009.068115, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1543, 2060.724853, 2583.850097, 3009.053710, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(3034, 2060.830810, 2583.068359, 3010.679199, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1582, 2061.695556, 2583.429931, 3008.534667, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1583, 2059.351806, 2592.201660, 3008.552978, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2629, 2056.273925, 2588.336914, 3008.531494, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2913, 2055.745117, 2587.888916, 3009.505615, 0.000000, 89.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2526, 2063.106933, 2589.020996, 3008.549560, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(11707, 2064.792236, 2590.707763, 3009.356933, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2525, 2063.101806, 2591.620849, 3008.557861, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2523, 2063.662353, 2591.681884, 3008.590332, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1208, 2061.826171, 2588.866699, 3008.538330, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19422, 2060.673828, 2584.332031, 3009.072509, 0.000000, 0.000000, -47.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2047, 2063.701660, 2588.231445, 3011.095947, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2068, 2057.953613, 2584.034912, 3011.962402, -4.899997, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2068, 2064.395996, 2584.034912, 3011.962402, -4.899997, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2068, 2057.042236, 2592.122070, 3012.191650, 7.699995, 5.299995, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1840, 2060.551025, 2587.991943, 3010.744873, 0.000000, 0.000000, 90.000030, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1840, 2061.521972, 2587.991943, 3010.744873, 0.000000, 0.000000, 90.000030, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1840, 2061.021484, 2587.991943, 3010.744873, 0.000000, 0.000000, 90.000030, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1790, 2060.631103, 2588.017333, 3010.477050, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1790, 2061.371826, 2588.017333, 3010.477050, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1783, 2060.630859, 2588.010986, 3010.118896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1783, 2061.371582, 2588.010986, 3010.118896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1787, 2060.674072, 2588.011718, 3009.759033, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1787, 2061.384765, 2588.011718, 3009.759033, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1785, 2060.665283, 2587.999755, 3009.435302, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1785, 2061.385986, 2587.999755, 3009.435302, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1809, 2060.068847, 2588.135498, 3008.534423, 0.000000, 0.000000, -90.499870, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1809, 2060.068847, 2588.135498, 3009.084960, 0.000000, 0.000000, -90.499870, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(1809, 2060.068847, 2588.135498, 3009.625488, 0.000000, 0.000000, -90.499870, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19612, 2060.546386, 2588.016845, 3008.989257, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19612, 2061.036865, 2588.016845, 3008.989257, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(19612, 2061.527343, 2588.016845, 3008.989257, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2102, 2060.669433, 2587.846435, 3008.673339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    houses_map = CreateDynamicObject(2102, 2061.410156, 2587.846435, 3008.673339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	return (true);
}
