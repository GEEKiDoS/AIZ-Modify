#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\BoxFunctions;
#include AImod\_hud;
#include AImod\_player;
#include AImod\spawn;
#include AImod\_text;

main()
{
	if(getdvar("mapname") == "mp_background")
		return;
	
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	registerRoundSwitchDvar( level.gameType, 0, 0, 9 );
	registerTimeLimitDvar( level.gameType, 0, 0, 1440 );
	registerScoreLimitDvar( level.gameType, 500, 0, 5000 );
	registerRoundLimitDvar( level.gameType, 1, 0, 10 );
	registerWinLimitDvar( level.gameType, 1, 0, 10 );
	registerRoundSwitchDvar( level.gameType, 3, 0, 30 );
	registerNumLivesDvar( level.gameType, 0, 0, 10 );
	registerHalfTimeDvar( level.gameType, 0, 0, 1 );

	level.teamBased = true;
	level.onStartGameType = ::onStartGameType;
	
	level thread onPlayerConnect();
	level.spawn_equipment = 0;
	level thread AImod\functions::init();
	
	//Zombie Health -----------
	level.ZombieHealths = [];
    level.ZombieHealths[ "normal_zombie" ]  = 75;
	level.ZombieHealths[ "zombie_crawler" ] = 0;
    level.ZombieHealths[ "zombie_boss" ]    = 2500;
    level.ZombieHealths[ "hell_normal" ]    = 100;
	level.ZombieHealths[ "hell_spec" ]      = 0;
	level.ZombieHealths[ "hell_boss" ]      = 0;
	//Added Health ------------
	level.ZombieHealthFactor = [];
    level.ZombieHealthFactor[ "normal_zombie" ]  = 30;
	level.ZombieHealthFactor[ "zombie_crawler" ] = 250;
    level.ZombieHealthFactor[ "zombie_boss" ]    = 7500;
    level.ZombieHealthFactor[ "hell_normal" ]    = 35;
	level.ZombieHealthFactor[ "hell_spec" ]      = 300;
	level.ZombieHealthFactor[ "hell_boss" ]      = 10000;
	
	//game["dialog"]["gametype"] = "tm_death";
	
}

InitWeapons()
{
	level.sWeapons = [];
	level.sWeapons[level.sWeapons.size] = "beretta_mp";
	level.sWeapons[level.sWeapons.size] = "usp_mp";
	level.sWeapons[level.sWeapons.size] = "deserteagle_mp";
	level.sWeapons[level.sWeapons.size] = "coltanaconda_mp";
	level.sWeapons[level.sWeapons.size] = "glock_mp";
	level.sWeapons[level.sWeapons.size] = "beretta393_mp";
	level.sWeapons[level.sWeapons.size] = "mp5k_mp";
	level.sWeapons[level.sWeapons.size] = "pp2000_mp";
	level.sWeapons[level.sWeapons.size] = "pp2000_eotech_mp";
	level.sWeapons[level.sWeapons.size] = "uzi_mp";
	level.sWeapons[level.sWeapons.size] = "p90_mp";
	level.sWeapons[level.sWeapons.size] = "kriss_mp";
	level.sWeapons[level.sWeapons.size] = "ump45_mp";
	level.sWeapons[level.sWeapons.size] = "tmp_mp";
	level.sWeapons[level.sWeapons.size] = "ak47_mp";
	level.sWeapons[level.sWeapons.size] = "m16_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "m4_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "fn2000_mp";
	level.sWeapons[level.sWeapons.size] = "masada_mp";
	level.sWeapons[level.sWeapons.size] = "famas_mp";
	level.sWeapons[level.sWeapons.size] = "fal_mp";
	level.sWeapons[level.sWeapons.size] = "scar_mp";
	level.sWeapons[level.sWeapons.size] = "tavor_mp";
	level.sWeapons[level.sWeapons.size] = "m79_mp";
	level.sWeapons[level.sWeapons.size] = "rpg_mp";
	level.sWeapons[level.sWeapons.size] = "at4_mp";
	level.sWeapons[level.sWeapons.size] = "javelin_mp";
	level.sWeapons[level.sWeapons.size] = "barrett_mp";
	level.sWeapons[level.sWeapons.size] = "wa2000_acog_mp";
	level.sWeapons[level.sWeapons.size] = "m21_acog_mp";
	level.sWeapons[level.sWeapons.size] = "cheytac_mp";
	level.sWeapons[level.sWeapons.size] = "ranger_mp";
	level.sWeapons[level.sWeapons.size] = "model1887_mp";
	level.sWeapons[level.sWeapons.size] = "striker_mp";
	level.sWeapons[level.sWeapons.size] = "aa12_mp";
	level.sWeapons[level.sWeapons.size] = "m1014_mp";
	level.sWeapons[level.sWeapons.size] = "spas12_mp";
	level.sWeapons[level.sWeapons.size] = "rpd_mp";
	level.sWeapons[level.sWeapons.size] = "sa80_mp";
	level.sWeapons[level.sWeapons.size] = "mg4_mp";
	level.sWeapons[level.sWeapons.size] = "m240_grip_mp";
	level.sWeapons[level.sWeapons.size] = "aug_mp";
	level.sWeapons[level.sWeapons.size] = "onemanarmy_mp";
	level.sWeapons[level.sWeapons.size] = "m4_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "tmp_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "deserteagle_tactical_mp";
	level.sWeapons[level.sWeapons.size] = "m16_shotgun_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "ump45_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "usp_akimbo_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "beretta_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "wa2000_acog_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "m16_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "famas_fmj_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "beretta393_akimbo_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "ak47_fmj_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "aa12_grip_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "striker_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "cheytac_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "glock_akimbo_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "rpd_eotech_grip_mp";
	level.sWeapons[level.sWeapons.size] = "m240_fmj_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "coltanaconda_akimbo_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "m4_eotech_shotgun_mp";
	level.sWeapons[level.sWeapons.size] = "mp5k_fmj_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "ak47_gl_thermal_mp";
	level.sWeapons[level.sWeapons.size] = "barrett_acog_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "sa80_grip_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "m21_acog_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "spas12_grip_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "tmp_akimbo_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "mg4_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "pp2000_fmj_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "aug_acog_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "m240_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "tavor_fmj_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "kriss_reflex_rof_mp";
	level.sWeapons[level.sWeapons.size] = "scar_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "ranger_akimbo_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "p90_akimbo_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "masada_reflex_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "uzi_acog_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "model1887_akimbo_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "model1887_akimbo_mp";
	level.sWeapons[level.sWeapons.size] = "fn2000_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "fal_reflex_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "m1014_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "tmp_silencer_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "pp2000_eotech_xmags_mp";
	level.sWeapons[level.sWeapons.size] = "ranger_akimbo_mp";
	level.sWeapons[level.sWeapons.size] = "ak47_fmj_shotgun_mp";
	level.sWeapons[level.sWeapons.size] = "m16_shotgun_mp";
	level.sWeapons[level.sWeapons.size] = "deserteaglegold_mp";
	level.sWeapons[level.sWeapons.size] = "deserteagle_fmj_tactical_mp";
	level.sWeapons[level.sWeapons.size] = "m4_acog_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "stinger_mp";
	level.sWeapons[level.sWeapons.size] = "ak47_fmj_mp";
	level.sWeapons[level.sWeapons.size] = "kriss_akimbo_rof_mp";
	level.sWeapons[level.sWeapons.size] = "mp5k_akimbo_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "fn2000_acog_gl_mp";
	level.sWeapons[level.sWeapons.size] = "m240_grip_reflex_mp";
	level.sWeapons[level.sWeapons.size] = "aug_silencer_mp";
	level.sWeapons[level.sWeapons.size] = "mg4_silencer_mp";
}

onStartGameType()
{
	setClientNameMode("auto_change");
			
	//setObjectiveText( "allies", "Survive 50 Waves" );
	//setObjectiveText( "axis", "Survive 50 Waves" );
	level.ObjectiveText = "Survive 50 Waves";
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "axis", "mp_tdm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = level.gameType;
	allowed[1] = "airdrop_pallet";
	
	level.blockWeaponDrops = true;
	level.mode_doa=0;
	
	maps\mp\gametypes\_gameobjects::main(allowed);	
	level thread InitWeapons();
	wait 0.2;
	level thread set_StartWeaponCycleLoop();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "spawned_player" );
		self set_Player_SS_Variables();
		self set_Player_SS_Loadout();
		self set_Player_SS_Threads();
	}
}

set_Player_SS_Variables()
{
	self.pers["botKillstreak"] = 0;
	self.pers["lastKillstreak"] = "";
	self player_recoilScaleOn(100);
	self.killstreaktotal = 0;
	self.amountofkillstreaks = 0;
	self.upgrade = 0;
	self.nobuyhealth = 0;
	self.gambler = 0;
	self.speedy = 0;
	self.stalker = 0;
	self.speedreload = 0;
	self.stoppingpower = 0;
	self.zombieperks = 0;
	self.weapons = 0;
	self.inLastStand = false;
	self.inFinalStand = false;
	self.notusebox = 0;
	self.rpgup = 0;
	self.usingairstrike = "false";
	self.moveSpeedScaler = 1.0;
	self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );
}

set_Player_SS_Loadout()
{
	wait 2;
	self TakeAllWeapons();
	self ClearPerks();
	self maps\mp\perks\_perks::givePerk("specialty_pistoldeath");
	self giveWeapon(level.nextWeapon, randomInt(10), true);
	self giveMaxAmmo(level.nextWeapon);
	wait 0.02;
	self switchtoWeapon(level.nextWeapon);
}

set_Player_SS_Threads()
{
	self Init_Perks();
	self thread KillIfUnderMap();
	self thread MonitorStance();
	self thread InfiniteAmmo();
	self thread MonitorSSKillstreaks();
}

set_StartWeaponCycleLoop()
{
	while(1)
	{
		level thread GiveNewWeapons(level.nextWeapon);
		wait(randomIntRange(15,30));
	}
}

GiveNewWeapons(nextWeapon)
{
	level.nextWeapon = level.sWeapons[RandomInt( 65535 ) % level.sWeapons.size];
	foreach(player in level.players)
	{
		player playLocalSound("US_1mc_hq_located");
		player thread AImod\_text::GamblerText("Weapons Cycled", (1,1,1), (0.3,0.3,0.9), 1, 0.85);
		player TakeAllWeapons();
		player giveWeapon(level.nextWeapon, randomInt(10), true);
		player giveMaxAmmo(level.nextWeapon);
		wait 0.02;
		player switchToWeapon(level.nextWeapon);
	}
}

InfiniteAmmo()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		weaponList = self GetWeaponsListAll();
		foreach ( weaponName in weaponList )
		{	
			self giveMaxAmmo( weaponName );
		}
		self waittill("weapon_fired");
	}
}

InfiniteAmmoClip()
{
    self endon("death");
	self endon("no_deathmachine");
    for( ;; )
    {
        self waittill( "weapon_fired" );
		self setWeaponAmmoClip( self getCurrentWeapon(), 9999, "right" );
		self setWeaponAmmoClip( self getCurrentWeapon(), 9999, "left" );
    }
}

CycleTimer()
{
	self endon("disconnect");
	self endon("death");
	self.CycleTimer destroy();
	self.CycleTimer = self createFontString( "objective", 1.2 );
	self.CycleTimer setPoint( "TOPLEFT", "TOPLEFT", 13, 120);
	self.CycleTimer.color = (1,1,1);
	self.CycleTimer.glowColor = (0.9,0.3,0.3);
	self.CycleTimer.glowAlpha = 0.75;
	self.CycleTimer.alpha = 1;
	self.CycleTimer.label = &"Weapons Cycling: ";
	while(1)
	{
		for(count = level.time;count > -1;count--)
		{
			level.time = count;
			self.CycleTimer setValue(level.time);
			wait 1;
		}
	}
}
/* Killstreak Section */

Init_Perks()
{
	self.rPerk = [];
	self.rPerk[self.rPerk.size] = "health";
	self.rPerk[self.rPerk.size] = "speed_reload";
	self.rPerk[self.rPerk.size] = "stamin_up";
	self.rPerk[self.rPerk.size] = "stalker";
	self.rPerk[self.rPerk.size] = "quick_revie_pro";
	self.rPerk[self.rPerk.size] = "double_tap";
	self.rKill = [];
	self.rKill[self.rKill.size] = "nuke";
	self.rKill[self.rKill.size] = "perm_bot";
	self.rKill[self.rKill.size] = "super_airstrike";
}

getKS()
{
	ks = [];
	ks[0]  = getdvarInt("z_perk_1");
	ks[1]  = getdvarInt("z_perk_2");
	ks[2]  = getdvarInt("z_perk_3");
	ks[3]  = getdvarInt("z_perk_4");
	ks[4]  = getdvarInt("z_perk_5");
	ks[5]  = getdvarInt("z_perk_6");
	ks[6]  = getdvarInt("z_perk_7");
	ks[7]  = getdvarInt("z_kill_1");
	ks[8]  = getdvarInt("z_kill_2");
	ks[9]  = getdvarInt("z_kill_3");
	
	return ks;
}

MonitorSSKillstreaks()
{
	self endon("death");
	self endon("disconnect");
	ks = getKS();
	
	while(1)
	{		
		self waittill("zombie_killed");
		self thread giveEarned(self.amountofkillstreaks);
	}
}

giveEarned( ammount )
{
	if( !isDefined( ammount ) )
		ammount = self.amountofkillstreaks;
		
	ks = getKS();
	
	if( ammount == ks[0] )
		self give_rPerk("perk_1");

	else if( ammount == ks[1] )
		self give_rPerk("perk_2");
		
	else if( ammount == ks[2] )
		self give_rPerk("perk_3");
		
	else if( ammount == ks[3] )
		self give_rPerk("perk_4");

	else if( ammount == ks[4] )
		self give_rPerk("perk_5");

	else if( ammount == ks[5] )
		self give_rPerk("perk_6");
		
	else if( ammount == ks[6] )
		self give_rPerk("perk_6");

	else if( ammount == ks[7] )
		self give_rStreak("killstreak_1");
	
	else if( ammount == ks[8] )
		self give_rStreak("killstreak_2");
	
	else if( ammount == ks[9] )
		self give_rStreak("killstreak_3");
}

give_rStreak(killstreak_name)
{
	if( killstreak_name != "" && self.pers["lastKillstreak"] == killstreak_name )
		return false;
	self.pers["lastKillstreak"] = killstreak_name;
	number = randomInt(self.rKill.size);
	pick_perk = self.rKill[number];
	self thread HudRightMessage("Random Killstreak Earned", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
	self playlocalsound("mp_level_up");
	switch(pick_perk)
	{
		case "nuke":
		self maps\mp\killstreaks\_killstreaks::giveKillstreak( "nuke", true );
		break;
		case "perm_bot":
		self thread maps\mp\killstreaks\_sniper::SpawnChickenFriend(self);
		break;
		case "super_airstrike":
		self maps\mp\killstreaks\_killstreaks::giveKillstreak( "counter_uav", true );
		break;
	}
	self.rPerk[number] = [];
}

give_rPerk(killstreak_name)
{
	if( killstreak_name != "" && self.pers["lastKillstreak"] == killstreak_name )
		return false;
	self.pers["lastKillstreak"] = killstreak_name;
	number = randomInt(self.rPerk.size);
	pick_perk = self.rPerk[number];
	self thread HudRightMessage("Random Perk Earned", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
	switch(pick_perk)
	{
		case "health":
		self.zombieperks += 1;
		self.maxhealth += 100;
		self thread PerkHud( "cardicon_juggernaut_2", (1,0.3,0.3), "200 Health");
		self playLocalSound( "UK_1mc_hq_online" );
		break;
		case "speed_reload":
		self.zombieperks += 1;
		self _setPerk("specialty_fastreload");
		self _setPerk("specialty_quickdraw");
		self thread PerkHud( "specialty_fastreload_upgrade", (0.3,0.9,0.3), "Reload Lightning Fast");
		self playLocalSound( "UK_1mc_hq_destroyed" );
		break;
		case "stamin_up":
		self.zombieperks += 1;
		self _setPerk("specialty_marathon");
		self _setPerk("specialty_lightweight");
		self _setPerk("specialty_fastsprintrecovery");
		self thread PerkHud( "specialty_lightweight_upgrade", (0.9,0.9,0.3), "Run and Sprint Longer and Faster");
		self playLocalSound( "UK_1mc_hq_located" );
		break;
		case "stalker":
		self.zombieperks += 1;
		self thread SetStalker();
		self thread PerkHud( "cardicon_expert_aug", (0.9,0.9,0.3), "Faster moving while ADS and Laser Sight");
		self playLocalSound( "UK_1mc_hq_secured" );
		break;
		case "quick_revie_pro":
		self.autorevive += 1;
		self thread PerkLastStandPro("specialty_pistoldeath_upgrade", (0,1,1), "Quick Revive Pro");
		self playLocalSound( "UK_1mc_hq_offline" );
		break;
		case "double_tap":
		self.zombieperks += 1;
		self.stoppingpower = 1;
		self thread PerkHud( "cardicon_doubletap", (0.9,0.5,0.2), "Doubles the Damage of all Guns" );
		self playLocalSound( "UK_1mc_hq_captured" );
		break;
		case "infinite_ammo":
		self.zombieperks += 1;
		self thread InfiniteAmmoClip();
		self thread PerkHud( "cardicon_skull", (0.3,0.3,0.9), "Infinite Ammo in Clip" );
		break;
	}
	self.rPerk[number] = [];
}