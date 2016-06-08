#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;
#include AImod\spawn;
#include AImod\_weapon;
#include AImod\_text;
#include AImod\_killstreaks;

give_Loadout()
{
	wait 1;
	self.health = 100;
	self.pers["botKillstreak"] = 0;
	self.pers["lastKillstreak"] = "";
	self thread MonitorKillstreaks();
	//self TakeAllWeapons();
	//self ClearPerks();
	//self thread Pistols();
	self maps\mp\perks\_perks::givePerk( "semtex_mp" );
	self maps\mp\perks\_perks::givePerk("specialty_pistoldeath");
	self Init_Stop_Barriers();
}

Pistols()
{
	pistols = [];
	pistols[0] = "beretta_mp";
		
	if(getDvar("mapname") == "ending")
		pistols[0] = "beretta_silencer_mp";
	
	pistols = pistols[randomInt(pistols.size)];
	self giveWeapon(pistols,10,false);
	wait 0.2;
	self switchtoWeapon(pistols);
	self giveMaxAmmo(pistols,10,false);
}

/* Connect Variables */
set_Player_AIZ_Connect_Variables()
{
	self.bonus = 0;
	self.money = getdvarInt("z_money");
	self.standpro = 0;
	self.autorevivecount = 0;
	self.autorevivenum = 0;
	self.tombstone_speedcola = 0;
	self.tombstone_jugger = 0;
	self.tombstone_speedy = 0;
	self.tombstone_mulekick = 0;
	self.tombstone_mulekickweapon = "";
	self.tombstone_doubletap = 0;
	self.tombstone_deadshot = 0;
	self.tombstone_phd = 0;
	self.tombstone_whoswho = 0;
	self.tombstone_cherry = 0;
	self.tombstone_aid = 0;
	self.moving = 0;
	self.isup = 0;
	if(level.zState != "intermission" && level.mode_doa != 1)
		self.playerIsDead = 1;
	else
		self.playerIsDead = 0;
	self.RankUpdateTotal = 0;	
}

set_Player_AIZ_Connect_Threads()
{
	self setClientDvar("ui_wave", level.wave);		
	self setClientDvar("ui_zombies", level.ZombieCount);		
	self setClientDvar("ui_money", self.money);		
	self setClientDvar("ui_bonus", self.bonus);		
	self setClientDvar("ui_power", level.power);
	
	self thread CustomMapnames();
	self thread AImod\_Intro::IntroInit();
	self thread SetVision();
	self thread AImod\_hud::IntermissionHud();
	//self thread ShowHost(self);
	self thread QuickMessages();
}

/* Spawn Variables */
set_Player_AIZ_Variables()
{
	if(level.Wave >= 10 && self.money < 1500)
		self.money = 1500;
	self.needsToSpawn = false;
	self player_recoilScaleOn(100);
	self.killstreaktotal = 0;
	self.amountofkillstreaks = 0;
	self.upgrade = 0;
	self.nobuyhealth = 0;
	self.gambler = 0;
	self.autorevive = 0;
	self.speedy = 0;
	self.stalker = 0;
	self.speedreload = 0;
	self.stoppingpower = 0;
	self.juggernaut = 0;
	self.deadshot = 0;
	self.phd = 0;
	self.tombstone = 0;
	self.mulekick = 0;
	self.mulekicktakeweapon = "";
	self.whoswho = 0;
	self.cherry = 0;
	self.aid = 0;
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

set_Player_AIZ_Threads()
{
	self give_Loadout();
	self thread KillIfUnderMap();
	self thread MonitorStance();
}

/* Other Functions for Players */
KillIfUnderMap()
{
	self endon("death");
	while(1)
	{
		if(getdvar("mapname") == "mp_rust" && self.origin[2] <= -429 && level.edit == 0 || getdvar("mapname") == "mp_rust" && self.origin[2] <= -306 && level.edit == 1)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_estate" && self.origin[2] <= -713)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_afghan" && self.origin[2] <= -1585)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_vacant" && self.origin[2] <= -350)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_overgrown" && self.origin[2] <= -243)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_highrise" && level.edit == 0 && self.origin[2] <= -2200)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_highrise" && level.edit == 1 && self.origin[2] <= -108)
		{
			self suicide();
		}
		/*if(getdvar("mapname") == "mp_quarry" && self.origin[2] <= 835)
		{
			self suicide();
		}*/
		wait 0.1;
	}
}

Init_Stop_Barriers()
{
	switch(getDvar("mapname"))
	{
		case "mp_afghan":
		self thread StopBarriers();
		break;
		case "mp_highrise":
		self thread StopBarriers();
		break;
		case "mp_estate":
		self thread StopBarriers();
		break;
		case "estate":
		self thread StopBarriers();
		break;
		case "mp_favela":
		self thread StopBarriers();
		break;
	}
}

QuickMessages()
{
	self endon("disconnect");
	self notifyOnPlayerCommand("radio", "+talk");
	for(;;)
	{
		self waittill("radio");
		self openpopupMenu(game["menu_quickcommands"]);
		wait 1;
	}
}

MonitorStance()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self.deadshot == 1)
		{
			self player_recoilScaleOn(60);
		}
		else
		{
			self player_recoilScaleOn(1000);
		}
		wait 0.05;
	}
}