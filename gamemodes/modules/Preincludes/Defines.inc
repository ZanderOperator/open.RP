// -Macros

#define Public:%0(%1) \
		forward %0(%1); \
		public %0(%1)

#define IsANewUser(%0) \
	Bit1_Get(gr_NewUser,%0)

// KickEx
#define KickMessage(%0) \
	KickPlayer(%0)
// BanEx
#define BanMessage(%0) \
	BanPlayer(%0)

// Key Status
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// rBits
#define IsPlayerLogged(%0) 						Bit1_Get(gr_PlayerLoggedIn,%0)
#define IsPlayerLogging(%0) 					Bit1_Get(gr_PlayerLoggingIn,%0)
#define IsPlayerAlive(%0) 						Bit1_Get(gr_PlayerAlive, %0)
#define IsPlayerReconing(%0) 					Bit4_Get(gr_SpecateId, %0)

// Limits - https://www.open.mp/docs/scripting/resources/limits
#define EX_SPLITLENGTH 							(90) // Define when to split SendClientMessage into another line!
#define DIALOG_UPDATE_LIST_CHAR					(1280) // How many chars can fit into 1/4 pages of Update Info Dialog

#define MAX_DIALOG_TEXT                 		(756)
#define MAX_LOGIN_TRIES							(3)
#define MAX_PLAYER_MAIL							(32)
#define MAX_PLAYER_IP							(24)
#define MAX_ZONE_NAME                   		(28)
#define MAX_LOGIN_TIME							(60)
#define MAX_PLAYER_PASSWORD             		(BCRYPT_HASH_LENGTH)
#define MAX_PLAYER_CIDR							(32)
#define MAX_WARNS								(3)
#define MAX_DYNAMIC_PICKUPS						(500)
#define MAX_HOUSES                      		(1500)
#define	MAX_COMPLEX_ROOMS                       (50)
#define MAX_COMPLEX                             (10)
#define MAX_BIZZES         						(500)
#define MAX_PLANTS								(200)
#define MAX_CUSTOMIZED_OBJECTS          		(7)
#define MAX_SERVER_FLAMES						(200)
#define MAX_STARTED_FLAMES						(30)
#define MAX_FACTIONS							(21)
#define MAX_APARTMENTS							(500)
#define MAX_VEHICLE_TICKETS						(5)
#define MAX_VEHICLE_TYPES						(10)
#define MAX_GARAGES                 			(1500)
#define MAX_SERVER_SKINS						(800)

// Premium VIP 
#define PREMIUM_BRONZE							(1)
#define PREMIUM_SILVER							(2)
#define PREMIUM_GOLD							(3)
#define PREMIUM_PLATINUM						(4)

// Max Inactivity Time & Minimum Month PayDays before Job/Property Removal
#define MAX_JOB_INACTIVITY_TIME					(864000) // 10 days
#define MAX_INACTIVITY_TIME						(2592000) // 30 days
#define MIN_MONTH_PAYDAYS						(10)

// Experience.pwn
#define MIN_GIVER_EXP_PAYDAYS					(2) 
#define MIN_RECIEVER_EXP_PAYDAYS				(1) 
#define LEVEL_UP_EXP							(25) 
#define MAX_FURSLOTS_EXP						(100) 
#define PREMIUM_BRONZE_EXP						(150) 
#define PREMIUM_SILVER_EXP						(200) 
#define PREMIUM_GOLD_EXP						(250)

// Furniture Texture & Color Slots 
#define MAX_COLOR_TEXT_SLOTS					(5)

// House Interior Furniture
#define FURNITURE_PREMIUM_OBJECTS				(700) // => CMD: /afurniture setpremium [player_id][house_id]
#define FURNITURE_VIP_GOLD_OBJCTS				(500)
#define FURNITURE_VIP_SILVER_OBJCTS				(400)
#define FURNITURE_VIP_BRONZE_OBJCTS				(300)
#define FURNITURE_VIP_NONE						(200)
#define MAX_FURNITURE_SLOTS						(700)
#define MAX_FURNITURE_SLOT_FIELDS				(FURNITURE_PREMIUM_OBJECTS * MAX_COLOR_TEXT_SLOTS)

// House Exterior Furniture
#define HOUSE_EXTERIOR_RADIUS					(40.0)
#define EXTERIOR_OBJS_VIP_GOLD					(25)
#define EXTERIOR_OBJS_VIP_SILVER				(20)
#define EXTERIOR_OBJS_VIP_BRONZE				(15)
#define EXTERIOR_OBJS_VIP_NONE					(10)

// Bizz Furniture
#define BIZZ_FURNITURE_VIP_GOLD_OBJCTS			(500)
#define BIZZ_FURNITURE_VIP_SILVER_OBJCTS		(400)
#define BIZZ_FURNITURE_VIP_BRONZE_OBJCTS		(300)
#define BIZZ_FURNITURE_VIP_NONE					(200)
#define MAX_BIZNIS_FURNITURE_SLOTS  			(BIZZ_FURNITURE_VIP_GOLD_OBJCTS * MAX_COLOR_TEXT_SLOTS)

// Trunk - Weapon Slot Limits
#define MAX_WEAPON_SLOTS						(10)
#define MAX_PACKAGE_VEHICLE						(15) 

// Player - Weapon Slot Limits
#define MAX_PLAYER_WEAPON_SLOTS					(13)

// Weapon Packages
#define MAX_PLAYER_PACKAGES 					(10)
#define MAX_LISTED_WEAPONS						(11)	
#define MAX_PACKAGE_AMOUNT						(200)
#define MAX_PACKAGES							(10)	
#define PACKAGE_COOLDOWN						(120)	
#define MINUTES_TILL_PACKAGE_ARRIVE			 	(10) 
#define INVALID_PACKAGE_ID						(-1)	
#define KEVLAR_VEST							(60)	

// Drugs
#define MAX_PLAYER_DRUGS						(5)
#define MAX_VEHICLE_DRUGS 						(10)
#define MAX_DRUG_AMOUNT 						(1000)
#define DRUG_DAYS_QUALITY						(86400)

#define DRUG_TYPE_NONE 							(0)
#define DRUG_TYPE_SMOKE 						(1)
#define DRUG_TYPE_SNORT 						(2)
#define DRUG_TYPE_INJECT 						(3)
#define DRUG_TYPE_TABLET						(4)

// Private Vehicles - CarOwnership.pwn
#define MAX_PLAYER_CARS							(10)

// TODO: when rBits removed, change value to -1
// Invalids
#define INVALID_BIZNIS_ID     					(999)
#define INVALID_HOUSE_ID						(9999)
#define INVALID_COMPLEX_ID                      (999)

// Streaming
#define PRISON_DRAW_DISTANCE            		(250.0)

// Newly Registered User
#define NEW_PLAYER_BANK 						(2500)
#define NEW_PLAYER_MONEY 						(500)

// Economy
#define INFLATION_INDEX							(3)

// fSelection index Handler
#define MAX_MENU_ITEMS 							(2000)


// Bank - Credits
#define BUY_TYPE_VEHICLE						(1)
#define BUY_TYPE_HOUSE							(2)
#define BUY_TYPE_BIZZ							(3)

// Spawn Coordinates
#define SPAWN_X									(1107.3832)
#define SPAWN_Y									(-1389.9144)
#define SPAWN_Z									(13.6500)

// Vehicle Tire Defines
#define F_L_TIRE 0
#define B_L_TIRE 1
#define F_R_TIRE 2
#define B_R_TIRE 3

// Anti-Spam
#define ANTI_SPAM_PRIVATE_MESSAGE 				(5)
#define ANTI_SPAM_BANK_CREDITPAY 				(5)
#define ANTI_SPAM_CRIB_WEAPON					(5)
#define ANTI_SPAM_CAR_WEAPON					(5)
#define ANTI_SPAM_STEAL_MONEY					(60)
#define ANTI_SPAM_BUY_TIME						(5)
#define ANTI_SPAM_DOOR_SHOUT					(3)

// IRS Tax Logs - CheckPlayerTransactions
#define LOG_TYPE_BIZSELL 						1
#define LOG_TYPE_HOUSESELL 						2
#define LOG_TYPE_VEHICLESELL					3
#define LOG_TYPE_COMPLEXSELL    				4
#define LOG_TYPE_GARAGESELL     				5

// Warehouse
#define MAX_WAREHOUSE_WEAPONS					(100)
#define ROBBERY_DURATION						(1500) 
#define MIN_ROBBERS								(5) 
#define MIN_DEFENDERS							(5) 