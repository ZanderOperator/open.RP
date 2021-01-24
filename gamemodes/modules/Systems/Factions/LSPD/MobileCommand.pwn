#if defined MODULE_MOBILECOMMAND
    #endinput
#endif
#define MODULE_MOBILECOMMAND

/*
    #### ##    ##  ######  ##       ##     ## ########  ######## 
     ##  ###   ## ##    ## ##       ##     ## ##     ## ##       
     ##  ####  ## ##       ##       ##     ## ##     ## ##       
     ##  ## ## ## ##       ##       ##     ## ##     ## ######   
     ##  ##  #### ##       ##       ##     ## ##     ## ##       
     ##  ##   ### ##    ## ##       ##     ## ##     ## ##       
    #### ##    ##  ######  ########  #######  ########  ######## 
*/

#include <YSI_Coding\y_hooks>


/*
    ##     ##    ###    ########   ######
    ##     ##   ## ##   ##     ## ##    ##
    ##     ##  ##   ##  ##     ## ##
    ##     ## ##     ## ########   ######
     ##   ##  ######### ##   ##         ##
      ## ##   ##     ## ##    ##  ##    ##
       ###    ##     ## ##     ##  ######
*/

static MobileCommandVehicle[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};


/*
    ##     ##  #######   #######  ##    ##  ######
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ## ##     ## ##     ## ##  ##   ##
    ######### ##     ## ##     ## #####     ######
    ##     ## ##     ## ##     ## ##  ##         ##
    ##     ## ##     ## ##     ## ##   ##  ##    ##
    ##     ##  #######   #######  ##    ##  ######
*/

hook OnGameModeInit()
{
    new mobilecommand;
    mobilecommand = CreateDynamicObject(19379, -880.597961, 287.127899, 534.255981, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -870.745666, 284.864013, 536.105773, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -875.465393, 280.134033, 536.105773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -880.285095, 283.574218, 536.105773, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -887.638488, 284.864013, 536.105773, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -882.896301, 280.134033, 536.105773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19379, -889.694152, 288.433837, 534.269775, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 14577, "casinovault01", "vaultWall", 0x90FFFFFF);
    mobilecommand = CreateDynamicObject(19457, -880.285095, 282.814208, 535.215148, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18882, "hugebowls", "wallwhite2top", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -882.775817, 279.714111, 533.544555, 0.000000, 180.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18882, "hugebowls", "wallwhite2top", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -884.064392, 285.063964, 536.105773, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -875.595764, 279.714111, 533.544555, 0.000000, 180.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18882, "hugebowls", "wallwhite2top", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -879.286804, 279.714111, 533.544555, 0.000000, 180.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18882, "hugebowls", "wallwhite2top", 0x00000000);
    mobilecommand = CreateDynamicObject(19787, -883.990905, 286.062500, 537.006225, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 19894, "laptopsamp1", "laptopscreen2", 0x00000000);
    mobilecommand = CreateDynamicObject(19787, -883.990905, 287.892333, 537.006225, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 19894, "laptopsamp1", "laptopscreen1", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -887.638488, 289.074218, 536.105773, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -882.896301, 293.804199, 536.105773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19438, -879.548034, 286.967773, 535.086425, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18882, "hugebowls", "wallwhite2top", 0x00000000);
    mobilecommand = CreateDynamicObject(19379, -878.985778, 287.938476, 537.926391, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -879.971130, 282.621582, 537.406311, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 4829, "airport_las", "liftdoorsac256", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -880.020202, 284.301513, 539.086303, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 4829, "airport_las", "liftdoorsac256", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -876.884704, 287.945068, 537.816528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -882.591857, 291.161621, 537.116027, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 4829, "airport_las", "liftdoorsac256", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -880.285095, 290.114013, 536.105773, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -879.675354, 287.945068, 537.816528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -877.716125, 293.964111, 536.105773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -872.816467, 290.083984, 536.105773, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -875.465393, 293.814208, 536.105773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -870.737121, 289.074218, 536.105773, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 3042, "ct_ventx", "liftdoorsac128", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -874.715148, 289.134033, 536.105773, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 17555, "eastbeach3c_lae2", "decobuild2d_LAn", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -882.416198, 287.945068, 537.816528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -876.884704, 285.764892, 537.816528, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -876.499084, 284.402343, 535.656188, 0.000000, 89.999984, 179.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 14544, "ab_woozieb", "ap_screens1", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -877.219787, 283.422363, 535.656188, 0.000000, 90.000015, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2352, -876.852966, 283.845214, 535.676452, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -877.870300, 284.402343, 535.656188, 0.000000, 89.999977, 179.999862, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18063, "ab_sfammuitems02", "gun_xtra1", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -878.591003, 283.422363, 535.656188, 0.000000, 90.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2352, -878.224182, 283.845214, 535.676452, -0.000007, 90.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -879.868957, 284.402343, 535.656188, 0.000000, 89.999977, 179.999862, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 19894, "laptopsamp1", "laptopscreen2", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -880.589660, 283.422363, 535.656188, 0.000000, 90.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2352, -880.222839, 283.845214, 535.676452, -0.000007, 90.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -881.240173, 284.402343, 535.656188, 0.000000, 89.999969, 179.999816, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 19165, "gtamap", "gtasavectormap1", 0x00000000);
    mobilecommand = CreateDynamicObject(2265, -881.960876, 283.422363, 535.656188, 0.000000, 90.000030, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(2352, -881.594055, 283.845214, 535.676452, -0.000014, 90.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 18901, "matclothes", "hatmancblk", 0x00000000);
    SetDynamicObjectMaterial(mobilecommand, 1, 18901, "matclothes", "hatmancblk", 0x00000000);
    mobilecommand = CreateDynamicObject(19787, -877.589538, 283.622314, 536.705932, 0.000000, -0.000014, 179.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 9818, "ship_brijsfw", "ship_screen1sfw", 0x00000000);
    mobilecommand = CreateDynamicObject(19787, -879.149963, 283.622314, 536.705932, 0.000000, -0.000014, 179.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 9818, "ship_brijsfw", "ship_greenscreen1", 0x00000000);
    mobilecommand = CreateDynamicObject(19787, -880.710632, 283.622314, 536.705932, 0.000000, -0.000014, 179.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 19894, "laptopsamp1", "laptopscreen3", 0x00000000);
    mobilecommand = CreateDynamicObject(19457, -882.591857, 289.491455, 538.786010, 0.000000, 180.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 4829, "airport_las", "liftdoorsac256", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -879.675354, 285.764892, 537.816528, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(957, -882.416198, 285.764892, 537.816528, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 1, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
    mobilecommand = CreateDynamicObject(19379, -870.109375, 287.127899, 534.255981, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(mobilecommand, 0, 14577, "casinovault01", "vaultWall", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    mobilecommand = CreateDynamicObject(2133, -878.314025, 289.545166, 534.355712, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2134, -879.306091, 289.552001, 534.355712, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2134, -880.306457, 289.552001, 534.355712, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2133, -881.314514, 289.545166, 534.355712, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2133, -882.315246, 289.545166, 534.355712, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2614, -874.849060, 286.974853, 536.746398, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1808, -875.015197, 288.572509, 534.355712, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2186, -883.482849, 286.396484, 534.355712, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1892, -880.030822, 286.988769, 533.555236, 0.000000, 360.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(3111, -879.500671, 286.918212, 535.185852, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -878.415100, 286.671630, 535.245666, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19808, -876.763854, 284.293945, 535.316589, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19808, -878.134216, 284.293945, 535.316589, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19808, -880.135803, 284.293945, 535.316589, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19808, -881.526916, 284.293945, 535.316589, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19874, -877.152526, 284.273437, 535.306457, 0.000000, 360.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19874, -878.573425, 284.273437, 535.306457, 0.000000, 360.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19874, -880.554016, 284.273437, 535.306457, 0.000000, 360.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19874, -881.904724, 284.273437, 535.306457, 0.000000, 360.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -878.945617, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -879.155822, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -879.366027, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -877.585021, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -876.294860, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -880.975524, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(19807, -882.206481, 284.161621, 535.365783, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2611, -879.032043, 289.972900, 536.275756, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(11743, -882.408874, 289.774902, 535.376464, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2853, -881.169860, 289.692382, 535.396118, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(2101, -875.370056, 284.283935, 535.706176, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1714, -876.827209, 285.614257, 534.355712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1714, -878.178039, 285.604248, 534.355712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1714, -880.268371, 285.604248, 534.355712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1714, -881.579040, 285.604248, 534.355712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    mobilecommand = CreateDynamicObject(1537, -875.832092, 289.968505, 534.355712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    static vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);

    if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(vehicleid) == 427 &&
       (2 <= GetPlayerVehicleSeat(playerid) <= 4))
    {
        SetPlayerVirtualWorld(playerid, 12);
        SetPlayerPosEx(playerid, -876.5789, 288.9277, 535.3419, vehicleid, 1, true);
        SetCameraBehindPlayer(playerid);

        MobileCommandVehicle[playerid] = vehicleid;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
    {
        if(MobileCommandVehicle[playerid] != INVALID_VEHICLE_ID)
        {
            new
                Float:X, Float:Y, Float:Z;
            GetVehiclePos(MobileCommandVehicle[playerid], X, Y, Z);
            SetPlayerPosEx(playerid, X + (-0.1012), Y + (-4.2191), Z, 0, 0, false);

            MobileCommandVehicle[playerid] = INVALID_VEHICLE_ID;
        }
    }
    return 1;
}
