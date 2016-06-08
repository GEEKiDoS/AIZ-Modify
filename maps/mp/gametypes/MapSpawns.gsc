#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\SolidStuff;
#include maps\mp\gametypes\MapEdit;
#include AImod\_OtherFunctions;
#include AImod\_weapon;
#include AImod\BoxFunctions;

/* How to use Spawn Boxes */
/* SpawnBoxes(model, pos, pos_add, angle, add_to_objective, objective_Icon, add_to_headIcon, headImage, headSize, nameofItem, isPerkBox, powerIsRequired, cashAmountRequired, variableforPlayer, perkHudIcon, perkHudColor, perkHudText, perkThread) */
/* Load MapEdit from txtfile available in AIZE 2.1 R2. Made by A2ON.*/
Afghan()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-2692,-1314,-1301),(0,0,-50),(0,168,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	SpawnBoxes("com_plasticcase_friendly", (-2199,-28,-1444),(0,0,-50), (0,313,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	if( level.spawn_equipment )
	{
		RandomWeapon((-1672,-1081,-1444),(0,44,0));
		SpawnBoxes("com_plasticcase_friendly", (-2710,-424,-1444),(0,0,-50), (0,34,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-3136,41,-1446),(0,333,0));
		SpawnBoxes("com_plasticcase_friendly", (-2841,-394,-1332),(0,0,-50), (0,12,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-2502,-13,-1444),(0,0,-50), (0,7,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3499,920,-1448),(0,0,-50),(0,282,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3822,1390,-1448),(0,0,-50),(0,185,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3541,-511,-1448),(0,0,-50),(0,343,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-1500,-900,-1444),(0,0,-50),(0,44,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-2702,-53,-1444),(0,0,-50), (0,7,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((-2135,-62,-1440),(-2209,43,-1297));
	CreateWalls((-3501,567,-1443),(-3410,1545,-1233));
	CreateHurtArea((-2110,-1344,-1444),170,150);
}

Afghan2()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (9153,3597,134),(0,0,-50),(0,318,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (8632,3797,124),(0,0,-50),(0,270,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((9374,3234,130),(0,268,0));
		SpawnBoxes("com_plasticcase_friendly", (9373,3042,122),(0,0,-50),(0,268,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((8632,3668,123),(0,263,0));
		SpawnBoxes("com_plasticcase_friendly", (8632,3668,123),(0,0,-50),(0,263,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (8977,3748,131),(0,0,-50),(0,317,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (9309,3467,137),(0,0,-50),(0,317,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (9373,2842,115),(0,0,-50),(0,268,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (9373,2642,105),(0,0,-50),(0,268,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (9373,2442,95),(0,0,-50),(0,268,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (9373,2242,85),(0,0,-50),(0,268,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
	}
}

Derail()
{
	player = undefined;
	CreateWalls((1506,1760,130),(1501,1462,244));
	CreateWalls((1671,3064,130),(1600,2944,244));
	CreateWalls((2711,1122,130),(2523,1152,244));
	CreateWalls((2713,3136,142),(2520,3131,244));
	CreateWalls((1680,3110,158),(1687,3345,227));
	CreateBlocks((2346,3447,294),(0,0,0));
	CreateBlocks((2346,3447,250),(0,0,0));
	CreateBlocks((2346,3447,350),(0,0,0));
	CreateBlocks((1884,3190,456),(0,90,0));
	CreateBlocks((1884,3190,500),(0,90,0));
	CreateBlocks((1884,3190,550),(0,90,0));
	CreateBlocks((1884,3254,450),(0,90,0));
	CreateBlocks((1884,3254,500),(0,90,0));
	CreateBlocks((1884,3254,550),(0,90,0));
	CreateBlocks((2602,2809,158),(0,0,0));
	CreateBlocks((2602,2809,200),(0,0,0));
	CreateBlocks((2602,2809,250),(0,0,0));
	CreateBlocks((1820,2127,320),(0,90,0));
	CreateBlocks((1820,2127,370),(0,90,0));
	CreateBlocks((1820,2198,320),(0,90,0));
	CreateBlocks((1820,2198,370),(0,90,0));
	CreateBlocks((1683,3186,344),(0,90,0));
	CreateBlocks((1684,3269,344),(0,90,0));
	SpawnBoxes("com_plasticcase_friendly", (1810,3084,158),(0,0,-50),(0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (2488,2400,153),(0,0,-50),(0,105,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((1790,3371,294),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (1888,2672,158),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((1959,2233,294),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (2495,3319,294),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (1896,2060,158),(0,0,-50),(0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1824,2450,158),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2154,2606,282),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2299,2788,153),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (2499,2788,153),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Derail2()
{
	player = undefined;
	//thread CreateVisableWalls((784,-5567,120),(919,-5570,300));
	thread CreateWalls((784,-5567,120),(919,-5570,170));
	SpawnBoxes("com_plasticcase_friendly", (759,-6005,131),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	SpawnBoxes("com_plasticcase_friendly", (944,-5998,131),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	if( level.spawn_equipment )
	{
		RandomWeapon((863,-6096,131),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (759,-5842,131),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((944,-5846,131),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (944,-5846,131),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (944,-5684,131),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (759,-5697,131),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (850,-5598,131),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
	}
}

Estate()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-2121,25,-286),(0,0,-50), (0,10,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-2067,-901,-333),(0,0,-50), (0,23,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-3191,-1275,-527),(0,156,0));
		Power3((-3591,-749,-527),(0,24,0));
		SpawnBoxes("com_plasticcase_friendly", (-3591,-749,-527),(0,0,-50), (0,24,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-3473,-814,-575),(0,0,-50), (0,116,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-2378,-55,-292),(0,0,-50),(0,10,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-2578,-90,-292),(0,0,-50),(0,10,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2778,-150,-292),(0,0,-50), (0,10,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2978,-200,-300),(0,0,-50),(0,10,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-3178,-250,-310),(0,0,-50),(0,10,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3378,-300,-310),(0,0,-50), (0,10,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateHurtArea((-2276,-1298,-434),55,150);
	CreateHurtArea((-2168,-1125,-369),55,150);
}

Favela()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (2356,2736,291),(0,0,-50), (0,30,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (1266,2254,327),(0,0,-50), (0,105,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((1909,2486,291),(0,30,0));
		SpawnBoxes("com_plasticcase_friendly", (1803,2683,291),(0,0,-50), (0,30,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((2148,2620,291),(0,30,0));
		SpawnBoxes("com_plasticcase_friendly", (2043,2561,291),(0,0,-50), (0,30,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (1468,2492,291),(0,0,-50), (0,30,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1756,2400,291),(0,0,-50), (0,30,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2695,3160,291),(0,0,-50), (0,352,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1049,2424,292),(0,0,-50), (0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (2003,2800,291),(0,0,-50), (0,30,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2203,2920,291),(0,0,-50), (0,30,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
	}
	CreateWalls((2740,2858,250),(3047,3047,469));
	CreateWalls((1340,2442,408),(1719,2657,448));
	CreateWalls((987,2440,408),(1366,2446,470));
}

Favela2()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-3188,2046,-813),(0,0,-50), (0,70,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-2434,1632,-753),(0,0,-50), (0,240,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-2395,2354,-765),(0,283,0));
		SpawnBoxes("com_plasticcase_friendly", (-2375,2850,-779),(0,0,-50), (0,252,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-4701,2173,-922),(0,92,0));
		SpawnBoxes("com_plasticcase_friendly", (-2362,2007,-759),(0,0,-50), (0,270,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-3568,2091,-840),(0,0,-50), (0,86,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (-3568,2091,-840),(0,86,0));
		SpawnBoxes("com_plasticcase_friendly", (-3320,3703,-872),(0,0,-50), (0,236,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));//Speedy - SpawnBoxes("com_plasticcase_friendly", (-3320,3703,-872),(0,236,0));
		SpawnBoxes("com_plasticcase_friendly", (-3513,3293,-874),(0,0,-50), (0,102,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));//Health - SpawnBoxes("com_plasticcase_friendly", (-3513,3293,-874),(0,102,0));
		SpawnBoxes("com_plasticcase_friendly", (-3088,1453,-779),(0,0,-50), (0,236,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (-3088,1453,-779),(0,236,0));
	}
	CreateHurtArea((-3538,5014,-935),1000,500);
	CreateHurtArea((-2121,4154,-796),800,500);
}

Favela3()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-3054,-10211,-765),(0,0,-50), (0,168,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	SpawnBoxes("com_plasticcase_friendly", (-3414,-10075,-688),(0,0,-50), (0,160,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	if( level.spawn_equipment )
	{
		RandomWeapon((-3782,-9312,-791),(0,160,0));
		SpawnBoxes("com_plasticcase_friendly", (-3206,-9600,-816),(0,0,-50), (0,162,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-3010,-9853,-817),(0,167,0));
		SpawnBoxes("com_plasticcase_friendly", (-3248,-9972,-763),(0,0,-50), (0,165,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-3497,-9583,-779),(0,0,-50), (0,260,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3782,-9148,-808),(0,0,-50), (0,174,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3238,-9723,-802),(0,0,-50), (0,167,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3436,-9789,-751),(0,0,-50), (0,170,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
	
	}
}

HighRise()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-2754,9895,2275),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-1210,10063,2179),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-1608,9688,2179),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (-551,11091,2179),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-2824,11461,2179),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (-1471,10415,2179),(0,0,-50),(0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-1096,10414,2179),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1458,11087,2179),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-1642,11089,2179),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-850,11023,2179),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2184,10012,2275),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-1258,11087,2179),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateRamps((-2368,10168,2256),(-2368,11271,2256));
	CreateRamps((-2368,11271,2256),(-2655,11271,2256));
	CreateRamps((-2655,11271,2256),(-2655,10168,2256));
	CreateRamps((-2655,10168,2256),(-2368,10168,2256));
	CreateRamps((-2525,10916,2192),(-2521,11271,2256));
	CreateRamps((-2503,10469,2192),(-2507,10168,2256));
}

HighRise2()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (1383,10895,3371),(0,0,-50),(0,180,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (3513,3144,2355),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((2308,10069,4075),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (5046,2666,2355),(0,0,-50),(0,180,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (1384,10768,3371),(0,0,-50),(0,180,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (1896,10863,4075),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((1451,10172,4075),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (1707,10096,3371),(0,0,-50),(0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (2943,11008,3371),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (4981,3698,2355),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1394,11458,4075),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1936,10035,3371),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1455,10185,3371),(0,0,-50),(0,180,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (5281,3698,2355),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateProgressArea((2208,10676,3371),1500,150,1,0);
	CreateProgressArea((2230,10895,4075),1500,150,1,1);
	CreateProgressArea((5074,2460,2355),2500,150,1,2);
}

Invasion()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-960,1363,267),(0,0,-50),(0,99,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-786,933,259),(0,0,-50),(0,195,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	CreateRamps((-501,1868,167), (-401,1500,267));
	CreateRamps((-501,1868,167), (-601,2100,267));
	if( level.spawn_equipment )
	{
		RandomWeapon((-401,1368,267),(0,100,0));
		Power3((-603,996,259),(0,190,0));

		SpawnBoxes("com_plasticcase_friendly", (-929,1158,267),(0,0,-50),(0,100,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-1990,-2805,425),(0,0,-50),(0,180,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1810,-3010,430),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2420,-2961,424),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-2356,-2865,424),(0,0,-50),(0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-2346,-3055,424),(0,0,-50),(0,180,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2245,-3114,424),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-1810,-3160,430),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));

	}


}

Karachi()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (2701,2889,3),(0,0,-50),(0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (2377,3162,11),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((2740,2738,8),(0,90,0));
		Power3((2597,2610,3),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (2582,2892,8),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (2588,2714,3),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (2490,2216,12),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2364,2267,11),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (2490,3258,11),(0,0,-50),(0,270,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (2364,2407,12),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2364,2557,12),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2364,2707,12),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
	}
}

Quarry()
{
	player = undefined;
	CreateWalls((-335,1062,907),(-335,735,1000));
	SpawnBoxes("com_plasticcase_friendly", (-3375,-781.6,-162),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	SpawnBoxes("com_plasticcase_friendly", (-4029,-156,-104.8),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	if( level.spawn_equipment )
	{
		RandomWeapon((-3422,504,-269),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-3459,245,-248),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-3523,671,-100),(0,0,-50), (0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		Power3((-4563, 847, -136),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-4040,1270,21),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2703,1441,123),(0,0,-50), (0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2703,1233,97),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));		
		SpawnBoxes("com_plasticcase_friendly", (-4009,-449,-43),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2927,-442,-21),(0,0,-50),(0,45,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-3523,920,-100),(0,0,-50), (0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Rundown()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (1215,2988,77),(0,0,-50),(0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (1535,2699,75),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((1407,2651,77),(0,0,0));
		Power3((497,3358,59),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (830,2953,75),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-475,-1729,175),(0,0,-50),(0,117,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (1800,2393,71),(0,0,-50),(0,110,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (296,-1869,64),(0,0,-50),(0,135,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (893,-1218,195),(0,0,-50),(0,298,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1708,3040,73),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (495,2252,101),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1708,3240,73),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((1536,2303,50),(1472,2300,200));
	CreateWalls((695,2131,100),(495,2174,200));
	CreateWalls((304,2327,140),(163,2936,250));
}

Rust()
{
	player = undefined;
	thread CreateWalls((486,699,114),(906,730,200));
	thread CreateBlocks((1153,660,-17),(0,0,0));
	thread CreateBlocks((634,978,-3),(0,0,0));
	thread CreateWalls((992,1465,-26),(945,1480,100));
	SpawnBoxes("com_plasticcase_friendly", (-172,1581,-118),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (1316,155,-229),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((111,819,-104),(0,90,0));
		Power3((1315,-48,-227),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-266,490,-200),(0,0,-50),(0,38,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (534,1069,277),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (897,802,-154),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (741,1088,277),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (1640,905,-121),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (744,825,-89),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1553,1025,-121),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1640,-42,-215),(0,0,-50), (0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Scrapyard()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (960,-1661,-51),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (248,-3140,-77),(0,0,-50),(0,293,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((167,-1775,-124),(0,105,0));
		SpawnBoxes("com_plasticcase_friendly", (-56,-1799,-120),(0,0,-50), (0,100,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((88,-2355,-119),(0,120,0));
		SpawnBoxes("com_plasticcase_friendly", (-537,-2008,-88),(0,0,-50), (0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-370,-756,-65),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-875,-1093,-84),(0,0,-50),(0,163,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-122,-875,-108),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1301,-2258,-51),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-565,-2420,0),(0,0,-50),(0,70,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-570,-765,-79),(0,0,-50), (0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Skidrow()
{
	player = undefined;
	CreateWalls((-760.1, -918.8, 12.1), (-760.1, -918.8, 100.9));
	CreateWalls((-856.2, 343.4, 152.1), (-856.8, 235.9, 235.9));
	CreateWalls((-152.7, 719.5, 101.2), (55.9, 722.2, 236.8));
	CreateWalls((-266.6, -720.1, 16.1), (-266.6, -767.9, 100.0));
	CreateWalls((-2.1, -1840.1, 16.1), (-5.5, -1935.7, 111.8));
	CreateWalls((-647.9, -1676.0, 152.1), (-536.1, -1676.3, 253.9));
	SpawnBoxes("com_plasticcase_friendly", (-2496.9,-433.0,139.1),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-1087,155,8),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-2000.1,-366.9,144.1),(0,90,0));
		Power3((-923.7,217.4,152.1),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-2281.3,267.9,32.1),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-2016.4,-50.8,8.1),(0,0,-50), (0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-1576.1,-2213.3,27.1),(0,0,-50), (0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-318.6,-2023.9,16.1),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-496.1,-1728.4,152.1),(0,0,50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-752.6,-883.2,12.2),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1968,-292,3),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-1968,-492,13),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Skidrow2()
{
	player = undefined;
	CreateWalls((-760,-918,12),(-760, -918, 100));
	CreateWalls((-856,343,152),(-856, 235, 235));
	CreateWalls((-152,719,101),(55, 722, 236));
	CreateWalls((-266,-720,16),(-266, -767, 100.0));
	CreateWalls((-685,-1840,16),(-684,-1935,111));
	CreateWalls((-647,-1676,152),(-536, -1676, 253));
	CreateWalls((-197,-275,200),(-200,-448,263));
	CreateBlocks((-126,-458,214),(0, 0, 0));
	SpawnBoxes("com_plasticcase_friendly", (1818,-185,227),(0,0,-50), (0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (543,-696,11),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((1965,-500,16),(0,90,0));
		Power3((-185,96,16),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (1772,-284,16),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (1947,309,119),(0,0,-50), (0,360,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (31,-991,11),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (504,-912,11),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (615,-112,19),(0,0,-50),(0,180,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1867,186,224),(0,0,-50),(0,245,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1104,-2112,43),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (415,-112,19),(0,0,-50),(0,180,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Skidrow3()
{
	player = undefined;
	CreateWalls((2057,-3601,0),(1576,-3623,200));
	CreateBlocks((2032,-833,16),(0,180,0));
	CreateBlocks((2032,-833,50),(0,180,0));
	CreateBlocks((2032,-833,100),(0,180,0));
	SpawnBoxes("com_plasticcase_friendly", (1792,-1580,8),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (1591,-2068,11),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((2040,-1266,16),(0,90,0));
		Power3((1584,-1842,16),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (1608,-1247,8),(0,0,-50), (0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (1834,-2794,8),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (2023,-1613,16),(0,0,-50), (0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2023,-1990,16),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (1576,-2521,16),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1576,-2863,16),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1787,-1748,3),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1576,-2721,16),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

SubBase()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-488,-4360,25),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-488,-4677,20),(0,0,-50), (0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-215,-4048,26), (0,90,0));
		Power3((-339,-6440,11),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-488,-4122,25),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-215,-4328,22),(0,0,-50), (0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-339,-6440,11),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-215,-4571,21),(0,0,-50), (0,270,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-215,-4728,22),(0,0,-50), (0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-215,-4928,22),(0,0,-50), (0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-488,-4977,20),(0,0,-50), (0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-488,-4877,20),(0,0,-50), (0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Terminal()
{
	player = undefined;
	thread CreateVisableWalls((4583,3232,200),(4428,3232,335));
	SpawnBoxes("com_plasticcase_friendly", (3793,3335,203),(0,0,-50), (0,223,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (3743,4709,203),(0,0,-50), (0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	//MusicPlayerBox((3680, 4883, 203), (0,90,0));
	if( level.spawn_equipment )
	{
		RandomWeapon((4107,3232,203),(0,90,0));
		Power3((3883,2003,225),(90,90,0));
		SpawnBoxes("com_plasticcase_friendly", (-901,4753,552),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (3531,3232,203),(0,0,-50), (0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (4085,3584,203),(0,0,-50), (0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (3308,2757,204),(0,0,-50), (0,135,0), true, true, 16, "Tombstone Soda", "perkBox", true, 3000, "", "cardicon_expert_m21", (0.7,0.5,1));
		SpawnBoxes("com_plasticcase_friendly", (2959,4763,203),(0,0,-50), (0,90,0), true, true, 16, "Deadshot Daiquiri", "perkBox", true, 2500, "", "cardicon_expert_fn2000", (0.1,0.1,0.1));
		SpawnBoxes("com_plasticcase_friendly", (3727,4322,203),(0,0,-50), (0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (4408,2176,204),(0,0,-50), (0,270,0), true, true, 16, "PhD Flopper", "perkBox", true, 2000, "", "cardicon_expert_kriss", (0.7,0.5,1));
		SpawnBoxes("com_plasticcase_friendly", (3007,2965,205),(0,0,-50), (0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Underpass()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (3691,2508,400),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (3651,2240,395),(0,0,-50),(0,-45,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((3968,2426,395),(0,90,0));
		Power3((3655,1726,400),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (3545,1552,400),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (3732,2105,395),(0,0,-50),(0,48,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (3851,3404,395),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (3542,1426,395),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (3660,1968,395),(0,0,-50),(0,46,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (3015,3354,395),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (4164,1904,427),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (3832,1426,395),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((4113,3144,432),(4129,3448,500));
	CreateWalls((4129,3448,432),(4008,3468,500));
	CreateWalls((3669,2446,400),(3426,2553,500));
	CreateWalls((3414,2536,400),(3659,2529,500));
	CreateWalls((3426,2553,400),(3414,2536,500));
	CreateWalls((3669,2446,400),(3659,2529,500));
}

Bailout()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (1695,-543,395),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
	SpawnBoxes("com_plasticcase_friendly", (1120,-541,395),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((2500,-907,407),(0,90,0));
		Power3((469,-852,407),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (2147,-1132,407),(0,0,-50),(0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
		SpawnBoxes("com_plasticcase_friendly", (-1588,-1515,683),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (559,-23,395),(0,0,-50),(0,90,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-108,-852,407),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-1556,-2910,691),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-407,-1526,683),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-597,-69,395),(0,0,-50),(0,326,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (2347,-1132,407),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Carnival()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-1759,2968,3),(0,0,-50),(0,138,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-2691,900,-2),(0,0,-50),(0,50,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-2779,2928,3),(0,54,0));
		Power3((-2339,2609,3),(0,50,0));
		SpawnBoxes("com_plasticcase_friendly", (-2307,3170,3),(0,0,-50),(0,234,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-1553,2798,3),(0,0,-50),(0,141,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-2119,3865,3),(0,0,-50),(0,20,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3878,2865,3),(0,0,-50),(0,140,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-3281,2486,3),(0,0,-50),(0,318,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2248,1351,3),(0,0,-50),(0,323,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1901,1150,3),(0,0,-50),(0,189,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-2739,2609,3),(0,0,-50),(0,50,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}

Wasteland()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (10113,8312,358),(0,0,-50),(0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (10360,6935,353),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((10113,7044,358),(0,90,0));
		Power3((10113,7198,358),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (9480,6527,358),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (10901,7439,1481),(0,0,-50),(0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (10727,7210,1486),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (9983,6227,358),(0,0,-50),(0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (10241,6224,358),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (10374,6224,358),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (10528,6222,358),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (11911,6989,1486),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (10116,6224,358),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
}
	
Overgrown()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-1287,-5965,-153),(0,0,-50),(0,223,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-756,-5439,-159),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-1700,-5439,-148),(0,353,0));
		Power3((-2788,-6076,-148),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (-1836,-5554,-148),(0,0,-50),(0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-1959,-6334,-156),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2788,-6076,-148),(0,0,-50),(0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-1020,-6103,-150),(0,0,-50),(0,255,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-2765,-5876,-148),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-2765,-6276,-148),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-556,-5439,-159),(0,0,-50),(0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-956,-5439,-159),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateHurtArea((-1155,-5490,-150),45,150);
	CreateHurtArea((-1480,-5470,-156),45,150);
}

Trailerpark()
{
	player = undefined;
	CreateRamps((1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
	SpawnBoxes("com_plasticcase_friendly", (858,-2676,15),(0,0,-50), (0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (2403,-2568,18),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((271.1,-2360.1,11.1),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (2732,-2642,13),(0,0,-50), (0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-105,-1470,4),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (1958.9,-1706.1,15.4),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (1613.4,-2907.3,190.1),(0,0,-50), (0,73.6,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (2165.5,-2986.4,190.1),(0,0,-50),(0,282,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1672.3,-2478.2,190.1),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (649,-2676,15),(0,0,-50),(0,180,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1910,-3195,185),(0,0,-50),(0,180,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (2110,-3195,185),(0,0,-50),(0,180,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((246,-2267,96),(252,-2599,171));
	CreateWalls((-754,-2247,17),(-1424,-2261,120));
}

Vacant()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-828,-261,-37),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-1783,512,-91),(0,0,-50),(0,180,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((445,1526,-96),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-241,692,-31),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		Power3((-1659,208,-91),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (-1625,972,-83),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-1404,152,-98),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-659,78,-100),(0,0,-50),(0,90,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-867,409,-98),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (196,1600,-101),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (53,1093,-36),(0,0,-50),(0,90,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (53,725,-36),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((-846,-503,-8),(-849,-384,50));
	CreateWalls((-520,16,-31),(-518,-96,50));
	CreateWalls((-848,640,-8),(-846,520,50));
	CreateWalls((-4,677,-32),(-52,675,50));
	CreateWalls((72,959,-32),(73,848,46));
	CreateWalls((343,-880,-32),(346,-928,50));
}

Storm()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (4826,-1328,-52),(0,0,-50), (0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (3424,-2051,3),(0,0,-50),(0,90,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((3465,-975,-52),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (4207,-1009,-52),(0,0,-50), (0,90,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");//AMMO - SpawnBoxes("com_plasticcase_friendly", (4207,-1009,-52),(0,90,0));
		Power3((4646,-975,-52),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (3843,-1903,8),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (3913,-1519,16),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (3668,-1335,-48),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (2120,-902,8),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (3412,-844,8),(0,0,-50),(0,90,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (5097,-1360,8),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (4215,-2051,3),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((4700,-62,8),(4737,-59,100));
	CreateWalls((2163,-843,8),(2120,-842,100));
	CreateWalls((5088,-1360,8),(5004,-1347,100));
}

Salvage()
{
	player = undefined;
	CreateRamps((1957.5,2666.8,0.1),(2027.9,2406.3,130));
	SpawnBoxes("com_plasticcase_friendly", (1921,2007,11),(0,0,-50), (0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (2670,2888,57),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((2250.3,3311.6,63.7),(0,0,0));
		Power3((1608.1,2025.3,152.1),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (1899,3185,67),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (1200,-315,19),(0,0,-50), (0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (1019,-744,19),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1652,2344,11),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (2480,2428,25),(0,0,-50),(0,90,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1079,32,30),(0,0,-50),(0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (1380,2831,65),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (1608.1,2025.3,152.1),(0,0,-50),(0,90,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateBlocks((3505.8,2665.8,11.1),(0,0,0));
	CreateBlocks((3505.8,2665.8,51.1),(0,0,0));
	CreateBlocks((3505.8,2665.8,91.1),(0,0,0));
	CreateBlocks((2044.4,1984.2,42.1),(0,0,0));
	CreateBlocks((1998.0,1986.2,42.1),(0,0,0));
	CreateBlocks((1846.3,1989.2,178.1),(0,0,0));
	CreateBlocks((1787.8,1982.3,178.1),(0,0,0));
	CreateBlocks((1595.5,2060.3,45.1),(0,90,0));
	CreateWalls((1936.1,2335.9,300.9),(2487.9,2339.0,0.8));
	CreateWalls((984.1,2623.8,96.1),(1095.9,2614.9,202.4));
}

Strike()
{
	player = undefined;
	SpawnBoxes("com_plasticcase_friendly", (-2577,1615,24),(0,0,-50), (0,0,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	SpawnBoxes("com_plasticcase_friendly", (-2905,1608,19),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	if( level.spawn_equipment )
	{
		RandomWeapon((-2199,1240,31),(0,0,0));
		Power3((-3116,1240,20),(0,0,0));
		SpawnBoxes("com_plasticcase_friendly", (-2185,1615,24),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-2385,1608,19),(0,0,-50), (0,0,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (-2777,1247,16),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2950,1247,15),(0,0,-50),(0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
		SpawnBoxes("com_plasticcase_friendly", (-3302,1247,12),(0,0,-50),(0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-2577,1247,16),(0,0,-50), (0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-3065,1608,19),(0,0,-50),(0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (-3116,1240,20),(0,0,-50),(0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
	}
	CreateWalls((-3538,1216,32),(-3959,1211,128));
	CreateWalls((-3530,1627,16),(-3959,1621,128));
}

Fuel()
{
	player = undefined;
	thread CreateGrids((17794,27616,6953),(18703,27165,6953),(0,0,0));
	SpawnBoxes("com_plasticcase_friendly", (17920,27175,6994),(0,0,-50),(0,0,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
	SpawnBoxes("com_plasticcase_friendly", (18705,27380,6994),(0,0,-50), (0,90,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball");
	if( level.spawn_equipment )
	{
		RandomWeapon((18220,27175,6994),(0,0,0));
		Power3((17794,27366,6994),(0,90,0));
		SpawnBoxes("com_plasticcase_friendly", (18520,27175,6994),(0,0,-50), (0,0,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (17794,27366,6994),(0,0,-50), (0,90,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (17935,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (18085,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Mule Kick", "perkBox", true, 2500, "", "cardicon_expert_aug", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (18235,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (18385,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (18535,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (18685,27608,6994),(0,0,-50), (0,0,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2));
	}
}

Crash()
{
	player = undefined;
	if( level.spawn_equipment )
	{
		RandomWeapon((-746,-2175,155),(0,0,0));
		Power3((-993,-3925,59),(0,180,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (-1045,-2365,106),(0,0,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (-873,-3073,81),(0,273,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (-1280,-3015,81),(0,90,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (-1191,-3578,68),(0,97,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (-993,-3925,59),(0,180,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (-1075,-2027,121),(0,46,0));
	}
	CreateWalls((-716,-2169,160),(-753,-3861,254));
	CreateWalls((-684,-2152,235),(-430,-2152,310));
}

Safehouse()
{
	if( level.spawn_equipment )
	{
		RandomWeapon((-166,63,179),(0,168,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (125,48,179),(0,74,0));
		Power3((281,271,27),(0,167,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (83,884,179),(0,345,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (65,232,27),(0,77,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (8144,7377,-838),(0,22,0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (222,776,179),(0,118,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (724,-127,307),(0,255,0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (587,112,179),(0,256,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (851,36,307),(0,254,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (8745,6708,-810),(0,224,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (557,344,27),(0,345,0));
	}
	CreateWalls((832,166,250),(839,203,170));
	CreateWalls((428,599,130),(459,595,230));
	CreateWalls((356,-174,0),(282,-164,113));
	CreateWalls((779,380,32),(741,385,102));
	CreateWalls((-278,490,223),(-345,411,309));
	CreateWalls((-370,306,223),(-348,211,325));
}

Village()
{
	if( level.spawn_equipment )
	{
		RandomWeapon((2956.47, 10501, 228.433),(0,27 + 90,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (3659.47, 10384.3, 207.103),(0, 112 + 90, 0));
		Power3((3874.88, 10103.7, 207.125),(0, -155 + 90, 0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (2760.23, 9506.87, 221.125),(0, -65 + 90, 0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (2484.55, 10107.8, 335.125),(0, 115 + 90, 0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (2349.68, 10306.4, 229.125),(0, 27 + 90, 0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (2318.35, 10264.3, 230.399),(0, -149 + 90, 0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (2580.18, 9595.12, 221.388),(0, 112 + 90, 0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (3031.74, 9474.53, 221.125),(0, 20 + 90, 0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (3315.41, 9414.79, 207.025),(0, 107 + 90, 0));
	}
}

Arcadia()
{
	if( level.spawn_equipment )
	{
		RandomWeapon((4256,-7531,2380),(0,330,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (4160,-7697,2380),(0,330,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (4474,-7657,2380),(0,330,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (3861,-7303,2380),(0,330,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (4438,-7857,2380),(0,330,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (3942,-7571,2380),(0,330,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (3577,-7361,2380),(0,0,0));
	}
	CreateHurtArea((2987,-6930,2383),650,200);
	CreateHurtArea((5317,-8274,2382),750,200);
}

Oilrig()
{
	thread CreateGrids((184,768,-1430),(687,999,-1430),(0,0,0));
	thread CreateWalls((941,756,-1360),(1183,748,-1280));
	thread CreateRamps((1184,-6110,-286),(1174,-5741,-286));
	if( level.spawn_equipment )
	{
		RandomWeapon((-56,1022,-1388),(0,90,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (-45,413,-1388),(0,90,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (259,1086,-1388),(0,90,0));
		Power3((109,280,-163),(0,180,0));
	}
}

Nuketown()
{
	player = undefined;
	if( level.spawn_equipment )
	{
		RandomWeapon((-219,502,-50),(0,34,0));
		SpawnBoxes("com_plasticcase_friendly", (-652,232,-45),(0,0,-50),(0,339,0), true, true, 16, "Ammo", "ammoBox", false, 5000, "", "waypoint_ammo_friendly");
		SpawnBoxes("com_plasticcase_friendly", (-500,414,90),(0,0,-50),(0,250,0), true, true, 16, "Gambler", "gamblerBox", false, 20, "", "cardicon_8ball" );
		Power3((13,-522,-55),(0,2,0));
		SpawnBoxes("com_plasticcase_friendly", (1402,505,-46),(0,0,-50),(0,16,0), true, true, 16, "Double Tap Root Beer", "perkBox", true, 2000, "", "cardicon_doubletap", (0.9,0.5,0.2) );
		SpawnBoxes("com_plasticcase_friendly", (721,68,90),(0,0,-50) ,(0,100,0), true, true, 16, "Pack-a-Punch", "upgradeBox", true, 5000, "", "cardicon_juggernaut_1");
		SpawnBoxes("com_plasticcase_friendly", (772,387,-45),(0,0,-50) ,(0,13,0), true, true, 16, "Speed Cola", "perkBox", true, 3000, "", "specialty_fastreload_upgrade", (0.3,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-710,294,-45),(0,0,-50) ,(0,155,0), true, true, 16, "Stamin-Up", "perkBox", true, 2000, "", "specialty_lightweight_upgrade", (0.9,0.9,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1619,1190,-52),(0,0,-50) ,(0,32,0), true, true, 16, "Juggernog", "perkBox", true, 2500, "", "cardicon_juggernaut_2", (1,0.3,0.3));
		SpawnBoxes("com_plasticcase_friendly", (-1812,376,-52),(0,0,-50) ,(0,65,0), true, true, 16, "Quick Revive", "perkBox", true, 2500, "", "specialty_pistoldeath_upgrade", (0,1,1));
		SpawnBoxes("com_plasticcase_friendly", (741,813,-53),(0,0,-50) ,(0,193,0), true, true, 16, "Random Killstreak", "killstreakBox", true, 200, "", "cardicon_harrier");
		MusicPlayerBox((506,1000,-52),(0,340,0));
	}
}

Burgertown()
{
	thread CreateWalls((1135,4952,2344),(246,4954,2500));
	thread CreateWalls((246,4954,2344),(260,5749,2500));
	thread CreateWalls((260,5749,2344),(332,5744,2500));
	thread CreateWalls((1013,-5029,2326),(1011,-5059,2397));
	thread CreateWalls((666,-5190,2334),(700,-5191,2401));
	thread CreateWalls((46,-5156,2326),(45,-5126,2400));
	thread CreateWalls((394,-4425,2326),(364,-4425,2397));
	thread CreateWalls((797,-4431,2321),(813,-4423,2397));
	if( level.spawn_equipment )
	{
		RandomWeapon((1240,5291,2291),(0,270,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (1196,5549,2285),(0,270,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (430,5042,2285),(0,270,0));
		Power3((792,5076,2286),(0,0,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (231,-4471,2321),(0,180,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (419,-5172,2329),(0,180,0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (298,-5342,2321),(0,270,0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (521,-4924,2329),(0,90,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (387,-4579,2329),(0,0,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (280,-5071,2329),(0,0,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (769,5379,2286),(0,90,0));
	}
}

Crossfire()
{
	CreateRamps((2750, -4440, -170), (2408, -4127, -160));
	CreateWalls((2844, -4400, -125), (2658, -4700, 75));
	CreateGrids((2260, -3523, -70), (2084, -3171, -70));
	if( level.spawn_equipment )
	{
		RandomWeapon((2391,-3274,-48),(0,60,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (2620, -2948, -6), (0,60,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (2159, -3964, -85), (0,60,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (2329, -4530, -136), (0,-40,0));
	}
}

Contingency()
{
	CreateHurtArea((-14481,2623,645),500,200);
	if( level.spawn_equipment )
	{
		RandomWeapon((-13071,2834,620),(0,90,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (-13071,3174,641),(0,90,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (-13147,2531,669),(0,0,0));
		Power3((-13932,2906,640),(0,90,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (-26601,-8943,781),(0,52,0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (-25921,-9067,811),(0,234,0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (-26113,-8752,783),(0,315,0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (-27064,-8658,840),(0,90,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (-13392,3311,682),(0,0,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (-25863,-8877,834),(0,2,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (-13660,2531,658),(0,0,0));
	}
}

Caves()
{
	thread CreateWalls((-5214,2895,791),(-5203,2916,900));
	if( level.spawn_equipment )
	{
		RandomWeapon((3781.02, 15314, -1376.76),(0, 10.0322, 0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (4074.91, 15366.9, -1395.4),(0, 14.0037, 0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (4111.42, 14535.5, -1339.31),(0, 12.6249, 0));
		Power3((4432, 15266.6, -1435.26),(0, 106.553, 0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (3282.3, 11762, -3847.72),(0, -7.90478, 0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (2739.8, 11595.1, -3838.36),(0, -7.04235, 0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (2643.01, 11857.9, -3820.52),(0, -176.221, 0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (2324.67, 11221.5, -3815.89),(0,-7.4,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (1956.41, 12211.1, -3774.88),(0,201.7,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (2404.64, 11762.3, -3813.42),(0,156,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (2464.01, 11448.3, -3802.85),(0,93,0));
	}
}

Shanties()
{
	thread CreateWalls((-5214,2895,791),(-5203,2916,900));
	if( level.spawn_equipment )
	{
		RandomWeapon((-4859,1994,791),(0,142,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (-4479,2717,791.4),(0,324,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (-4427,1909,791),(0,235,0));
		Power3((-4129,2335,791),(0,235,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (-7181,1388,1515),(0,55, 0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (-6897,1187,1516),(0,54,0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (-6952,1389,1515),(0,55,0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (-7271,1100,1515),(0,144,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (-4309,2598,791),(0,324,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (-7140,1012,1515),(0,215,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (-4620,2321,791),(0,235,0));
	}
}

Shanties_Hotel()
{
	thread CreateWalls((2648,-2712,651),(2599,-2711,730));
	if( level.spawn_equipment )
	{
		RandomWeapon((3176,-2047,651),(0,0,0));
		//AMMO - SpawnBoxes("com_plasticcase_friendly", (3544,-2590,651),(0,90,0));
		//GAMBLER - SpawnBoxes("com_plasticcase_friendly", (3172,-2555,651),(0,135,0));
		Power3((2769,-2688,651),(0,0,0));
		//DOUBLETAP - SpawnBoxes("com_plasticcase_friendly", (-7181,1388,1515),(0,55, 0));
		//UPGRADE - SpawnBoxes("com_plasticcase_friendly", (-1620,-1957,779),(0,90,0));
		//SpeedReload - SpawnBoxes("com_plasticcase_friendly", (-1391,-1183,779),(0,90,0));
		//Speedy - SpawnBoxes("com_plasticcase_friendly", (-1513,-687,779),(0,0,0));
		//Health - SpawnBoxes("com_plasticcase_friendly", (3008,-2098,651),(0,90,0));
		//LastStandPro - SpawnBoxes("com_plasticcase_friendly", (-1631,-1404,779),(0,90,0));
		//KillstreakBox - SpawnBoxes("com_plasticcase_friendly", (3008,-1922,699),(0,90,0));
	}
}

Bloc()
{

}

WetWork()
{

}