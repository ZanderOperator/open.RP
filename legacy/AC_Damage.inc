// Damage AntiCheat by Logan

#include <a_samp>

#define WEAPON_UNARMED		0
#define WEAPON_HELIBLADES	50
#define WEAPON_PISTOLWHIP 	100
#define WEAPON_CARPARK		150

static stock RejectHit(playerid)
{
	new Float: oldhealth, Float: oldarmour;	
	GetPlayerHealth(playerid, oldhealth);
	GetPlayerArmour(playerid, oldarmour);
	SetPlayerHealth(playerid, oldhealth);
	SetPlayerArmour(playerid, oldarmour);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    new bool:melee = bool:((WEAPON_UNARMED <= weaponid <= WEAPON_KATANA) || (WEAPON_DILDO <= weaponid <= WEAPON_CANE) || weaponid == WEAPON_PISTOLWHIP);

    // Adjust invalid amounts caused by an animation bug
    switch (amount)
    {
        case 3.63000011444091796875,
            5.940000057220458984375,
            5.610000133514404296875:
        {
            amount = 2.6400001049041748046875;
        }

        case 3.30000019073486328125:
        {
            if(weaponid != WEAPON_SHOTGUN && weaponid != WEAPON_SAWEDOFF)
            {
                amount = 2.6400001049041748046875;
            }
        }

        case 4.950000286102294921875:
        {
            if(melee)
            {
                amount = 2.6400001049041748046875;
            }
        }

        case 6.270000457763671875,
            6.93000030517578125,
            7.2600002288818359375,
            7.9200000762939453125,
            8.5799999237060546875,
            9.24000072479248046875,
            11.88000011444091796875,
            11.22000026702880859375:
        {
            amount = 2.6400001049041748046875;
        }
    }

    // Car parking
    if(weaponid == WEAPON_HELIBLADES && _:amount != _:330.0)
    {
        weaponid = WEAPON_CARPARK;
    }

    // Finish processing drown/fire/carpark quickly, since they are sent at very high rates
    if(weaponid == WEAPON_FLAMETHROWER || weaponid == WEAPON_DROWN || weaponid == WEAPON_CARPARK || weaponid == WEAPON_SPRAYCAN || weaponid == WEAPON_FIREEXTINGUISHER)
    {
        // Apply reasonable bounds
        if(weaponid == WEAPON_DROWN)
        {
            if(amount > 10.0)
            {
                amount = 10.0;
            }
        }
        else if(amount > 1.0)
        {
            amount = 1.0;
        }

        // Make sure the distance and issuer is valid; carpark can be self-inflicted so it doesn't require an issuer
        if(weaponid == WEAPON_SPRAYCAN || weaponid == WEAPON_FIREEXTINGUISHER || (weaponid == WEAPON_CARPARK && issuerid != INVALID_PLAYER_ID))
        {
            if(issuerid == INVALID_PLAYER_ID)
            {
                return RejectHit(playerid);
            }

            new Float:x, Float:y, Float:z, Float:dist;
            GetPlayerPos(issuerid, x, y, z);
            dist = GetPlayerDistanceFromPoint(playerid, x, y, z);

            if(dist > 15.0)
            {
                return RejectHit(playerid);
            }
        }
    }

    // Bullet or melee damage must have an issuerid, otherwise something has gone wrong (e.g. sniper bug)
    if(issuerid == INVALID_PLAYER_ID && ((WEAPON_COLT45 <= weaponid <= WEAPON_SNIPER) || weaponid == WEAPON_MINIGUN || melee))
    {
        return RejectHit(playerid);
    }

    // Punching with a parachute
    if(weaponid == WEAPON_PARACHUTE)
    {
        weaponid = WEAPON_UNARMED;
    }

    // Collision damage should never be above 165
    if(weaponid == WEAPON_COLLISION)
    {
        if(amount > 165.0)
        {
            amount = 1.0;
        }
        else
        {
            amount /= 165.0;
        }
    }

    // Check for pistol whip
    switch (weaponid)
    {
        case WEAPON_COLT45 .. WEAPON_SNIPER, WEAPON_MINIGUN, WEAPON_SPRAYCAN, WEAPON_FIREEXTINGUISHER:
        {
            // A pistol whip inflicts 2.64 damage
            if(_:amount == _:2.6400001049041748046875)
            {
                // Save the weapon in the bodypart argument (it's always BODY_PART_TORSO)
                bodypart = weaponid;
                weaponid = WEAPON_PISTOLWHIP;
            }
        }
    }

    melee = bool:((WEAPON_UNARMED <= weaponid <= WEAPON_KATANA) || (WEAPON_DILDO <= weaponid <= WEAPON_CANE) || weaponid == WEAPON_PISTOLWHIP);

    // Can't punch from a vehicle
    if(melee && IsPlayerInAnyVehicle(issuerid))
    {
        return RejectHit(playerid);
    }

    if(melee)
    {
        new Float:x, Float:y, Float:z, Float:dist;
        GetPlayerPos(issuerid, x, y, z);
        dist = GetPlayerDistanceFromPoint(playerid, x, y, z);

        if(dist > 15.0)
        {
            return RejectHit(playerid);
        }
    }

    new Float:bullets;
    switch (weaponid)
    {
        // The spas shotguns shoot 8 bullets, each inflicting 4.95 damage
        case WEAPON_SHOTGSPA:
        {
            bullets = amount / 4.950000286102294921875;

            if(8.0 - bullets < -0.05)
            {
                return RejectHit(playerid);
            }
        }

        // Shotguns and sawed-off shotguns shoot 15 bullets, each inflicting 3.3 damage
        case WEAPON_SHOTGUN, WEAPON_SAWEDOFF:
        {
            bullets = amount / 3.30000019073486328125;

            if(15.0 - bullets < -0.05)
            {
                return RejectHit(playerid);
            }
        }
    }

    if(_:bullets)
    {
        new Float:f = floatfract(bullets);

        // The damage for each bullet has been tampered with
        if(f > 0.01 && f < 0.99)
        {
            return RejectHit(playerid);
        }

        // Divide the damage amount by the number of bullets
        amount /= bullets;
    }

    // Check chainsaw damage
    if(weaponid == WEAPON_CHAINSAW)
    {
        switch (amount)
        {
            case 6.6000003814697265625,
                 13.5300006866455078125,
                 16.1700000762939453125,
                 26.40000152587890625,
                 27.060001373291015625:
            {
            }
            default:
            {
                return RejectHit(playerid);
            }
        }
    }

    #if defined SS_OnPlayerTakeDamage
        return SS_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerTakeDamage
    #undef OnPlayerTakeDamage
#else
    #define _ALS_OnPlayerTakeDamage
#endif
#define OnPlayerTakeDamage SS_OnPlayerTakeDamage
#if defined SS_OnPlayerTakeDamage
    forward SS_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
#endif