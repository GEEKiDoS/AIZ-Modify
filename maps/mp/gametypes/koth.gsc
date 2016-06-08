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

	level.spawn_equipment = 0;
	
	//Zombie Health -----------
	level.ZombieHealths = [];
    level.ZombieHealths[ "normal_zombie" ]  = 0;
	level.ZombieHealths[ "zombie_crawler" ] = 0;
    level.ZombieHealths[ "zombie_boss" ]    = 0;
    level.ZombieHealths[ "hell_normal" ]    = 0;
	level.ZombieHealths[ "hell_spec" ]      = 0;
	level.ZombieHealths[ "hell_boss" ]      = 0;
	//Added Health ------------
	level.ZombieHealthFactor = [];
    level.ZombieHealthFactor[ "normal_zombie" ]  = 150;
	level.ZombieHealthFactor[ "zombie_crawler" ] = 300;
    level.ZombieHealthFactor[ "zombie_boss" ]    = 10000;
    level.ZombieHealthFactor[ "hell_normal" ]    = 150;
	level.ZombieHealthFactor[ "hell_spec" ]      = 250;
	level.ZombieHealthFactor[ "hell_boss" ]      = 15000;
	
	//game["dialog"]["gametype"] = "tm_death";
	
}

onStartGameType()
{
	setClientNameMode("auto_change");
			
	//setObjectiveText( "allies", "Kill 1000 Zombies to Win" );
        //setObjectiveText( "axis", "Kill 1000 Zombies to Win" );
	level.ObjectiveText = "Kill 1000 Zombies to Win";
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
	level.mode_doa=1;
	
	maps\mp\gametypes\_gameobjects::main(allowed);	
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
		self set_Player_Acrade_Variables();
		self set_Player_Acrade_Loadout();
		self set_Player_Acrade_Threads();
	}
}

set_Player_Acrade_Variables()
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

set_Player_Acrade_Loadout()
{
	self.maxhealth = 200;
	self.autorevive += 1;
	self thread PerkLastStandPro("specialty_pistoldeath_upgrade", (0,1,1), "Quick Revive Pro");
	self playLocalSound( "UK_1mc_hq_offline" );
	self TakeAllWeapons();
	self ClearPerks();
	self setPerk("specialty_bulletaccuracy");
	self maps\mp\perks\_perks::givePerk("specialty_pistoldeath");
	self giveWeapon("mg4_mp", randomInt(10), true);
	wait 0.2;
	self switchtoWeapon("mg4_mp");
}

set_Player_Acrade_Threads()
{
	self thread KillIfUnderMap();
	self thread MonitorStance();
	self Init_Stop_Barriers();
	self thread InfiniteAmmo();
}


InfiniteAmmo()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		currentWeapon = self getCurrentWeapon();
		if(currentWeapon != "none")
		{
			self setWeaponAmmoClip( currentWeapon, 9999, "right" );
			self setWeaponAmmoClip( currentWeapon, 9999, "left" );
		}
		self waittill("weapon_fired");
	}
}