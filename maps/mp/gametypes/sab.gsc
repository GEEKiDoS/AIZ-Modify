#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\MapEdit;
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
	
	level thread AImod\functions::init();

	level thread onPlayerConnect();
	level.spawn_equipment = 1;
	
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

onStartGameType()
{
	setClientNameMode("auto_change");
			
	setObjectiveText( "allies", "If you see this message,please leave this server and rejoin" );
	setObjectiveText( "axis", "If you see this message,please leave this server and rejoin" );
	level.ObjectiveText="Survive 50 Waves";
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
	InitBoxWeapons();
}

InitBoxWeapons()
{
	level.weapons = [];
	level.weapons[level.weapons.size] = "beretta_mp";
	level.weapons[level.weapons.size] = "usp_mp";
	level.weapons[level.weapons.size] = "deserteagle_mp";
	level.weapons[level.weapons.size] = "coltanaconda_mp";
	level.weapons[level.weapons.size] = "glock_mp";
	level.weapons[level.weapons.size] = "beretta393_mp";
	level.weapons[level.weapons.size] = "mp5k_mp";
	level.weapons[level.weapons.size] = "pp2000_mp";
	level.weapons[level.weapons.size] = "pp2000_eotech_mp";
	level.weapons[level.weapons.size] = "uzi_mp";
	level.weapons[level.weapons.size] = "p90_mp";
	level.weapons[level.weapons.size] = "kriss_mp";
	level.weapons[level.weapons.size] = "ump45_mp";
	level.weapons[level.weapons.size] = "tmp_mp";
	level.weapons[level.weapons.size] = "ak47_mp";
	level.weapons[level.weapons.size] = "m16_reflex_mp";
	level.weapons[level.weapons.size] = "m4_reflex_mp";
	level.weapons[level.weapons.size] = "fn2000_mp";
	level.weapons[level.weapons.size] = "masada_mp";
	level.weapons[level.weapons.size] = "famas_mp";
	level.weapons[level.weapons.size] = "fal_mp";
	level.weapons[level.weapons.size] = "scar_mp";
	level.weapons[level.weapons.size] = "tavor_mp";
	level.weapons[level.weapons.size] = "m79_mp";
	level.weapons[level.weapons.size] = "rpg_mp";
	level.weapons[level.weapons.size] = "at4_mp";
	level.weapons[level.weapons.size] = "javelin_mp";
	level.weapons[level.weapons.size] = "barrett_mp";
	level.weapons[level.weapons.size] = "wa2000_acog_mp";
	level.weapons[level.weapons.size] = "m21_acog_mp";
	level.weapons[level.weapons.size] = "cheytac_mp";
	level.weapons[level.weapons.size] = "ranger_mp";
	level.weapons[level.weapons.size] = "model1887_mp";
	level.weapons[level.weapons.size] = "striker_mp";
	level.weapons[level.weapons.size] = "aa12_mp";
	level.weapons[level.weapons.size] = "m1014_mp";
	level.weapons[level.weapons.size] = "spas12_mp";
	level.weapons[level.weapons.size] = "rpd_mp";
	level.weapons[level.weapons.size] = "sa80_mp";
	level.weapons[level.weapons.size] = "mg4_mp";
	level.weapons[level.weapons.size] = "m240_grip_mp";
	level.weapons[level.weapons.size] = "aug_mp";
	level.weapons[level.weapons.size] = "onemanarmy_mp";
	level.weapons[level.weapons.size] = "m4_silencer_mp";
	level.weapons[level.weapons.size] = "tmp_silencer_mp";
	level.weapons[level.weapons.size] = "deserteagle_tactical_mp";
	level.weapons[level.weapons.size] = "aug_silencer_mp";
	level.weapons[level.weapons.size] = "mg4_silencer_mp";
	//Intricate - Ported weapons.
	//level.weapons[level.weapons.size] = "ak74u_mp";
	//level.weapons[level.weapons.size] = "m40a3_mp";
	//level.weapons[level.weapons.size] = "peacekeeper_mp";
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
		self set_Player_AIZ_H_Variables();
		self set_Player_AIZ_H_Loadout();
		self set_Player_AIZ_H_Threads();
	}
}

set_Player_AIZ_H_Variables()
{
	self.needsToSpawn = false;
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

set_Player_AIZ_H_Loadout()
{
	self TakeAllWeapons();
	self ClearPerks();
	self maps\mp\perks\_perks::givePerk("specialty_pistoldeath");
	self maps\mp\perks\_perks::givePerk( "semtex_mp" );
	self giveWeapon("defaultweapon_mp", randomInt(10), true);
	wait 0.2;
	self switchtoWeapon("defaultweapon_mp");
}

set_Player_AIZ_H_Threads()
{
	self thread KillIfUnderMap();
	self thread MonitorStance();
	self Init_Stop_Barriers();
}