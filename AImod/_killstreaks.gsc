#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;
#include AImod\spawn;
#include AImod\_weapon;
#include AImod\_text;

getKS()
{
	ks = [];
	ks[0]  = getdvarInt("z_airstrike");
	ks[1]  = getdvarInt("z_predator_missile");
	ks[2]  = getdvarInt("z_random_1");
	ks[3]  = getdvarInt("z_sentry");
	ks[4]  = getdvarInt("z_random_4");
	ks[5]  = getdvarInt("z_sub");
	ks[6]  = getdvarInt("z_lmg");
	ks[7]  = getdvarInt("z_megastrike");
	ks[8]  = getdvarInt("z_super");
	ks[9]  = getdvarInt("z_vision");
	ks[10] = getdvarInt("z_nuke");
	ks[11] = getdvarInt("z_permbot");
	
	return ks;
}

MonitorKillstreaks()
{
	self endon("death");
	self endon("disconnect");
	ks = getKS();
	
	for(;;)
	{		
		self waittill("zombie_killed");
		self thread giveEarned( );
	}
}

giveEarned( ammount )
{
	if( !isDefined( ammount ) )
		ammount = self.amountofkillstreaks;
		
	ks = getKS();
	
	if( ammount == ks[0] )
		self thread give_Killstreak("z_airstrike", "uav", 20, "precision_airstrike", ks[0] + " kills you have earned an Airstrike");

	else if( ammount == ks[1] )
		self thread give_Killstreak("z_predator_missile", "predator_missile", 50, "predator_missile", ks[1] + " kills you have earned the Predator Missile");

	else if( ammount == ks[2] )
		self thread give_Killstreak("z_random_1", "", 75, "random1", ks[2] + " kills you have earned a random killstreak", 1);

	else if( ammount == ks[3] )
		self thread give_Killstreak("z_sentry", "sentry", 75, "sentry", ks[3] + " kills you have earned a Sentry Gun");

	else if( ammount == ks[4] )
		self thread give_Killstreak("z_random_4", "", 75, "random4", ks[4] + " kills you have earned 4 random killstreaks", 4);

	else if( ammount == ks[5] )
	{
		if( self thread give_Killstreak("z_sub", "", 100, "sub", ks[5] + " kills you have earned an SMG Bot") )
		{
			self thread maps\mp\killstreaks\_sniper::FriendlyBot("ump45_mp", "SMG Bot Spawned!");
			self thread HudRightMessage("Press [{+actionslot 2}] to use an SMG Bot", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
		}
	}

	else if( ammount == ks[6] )
	{
		if( self thread give_Killstreak("z_lmg", "", 125, "lmg", ks[6] + " kills you have earned an LMG Bot") )
		{
			self thread maps\mp\killstreaks\_sniper::FriendlyBot("rpd_mp", "Machine Gun Bot Spawned!");
			self thread HudRightMessage("Press [{+actionslot 2}] to use LMG Bot", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
		}
	}

	else if( ammount == ks[7] )
	{
		if( self thread give_Killstreak("z_megastrike", "", 150, "megastrike", ks[7] + " kills you have earned a Mega Air-strike") )
		{
			self thread maps\mp\killstreaks\_megastrike::MegaStreakInit();
			self thread HudRightMessage("Press [{+actionslot 2}] to use Mega Strike", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
		}
	}

	else if( ammount == ks[8] )
		self thread give_Killstreak("z_super", "counter_uav", 200, "super", ks[8] + " kills you have earned AC-130 Gunship Support");

	else if( ammount == ks[9] )
	{
		cmap = getdvar("mapname");
		if( level.day == 0 && ( cmap == "mp_boneyard" || self.pers["botKillstreak"] == 250 && ( cmap == "mp_quarry" || ( cmap == "mp_nightshift" && level.edit == 2 ) || ( cmap == "mp_highrise" && level.edit == 1 ) ) ) )
			self thread give_Killstreak("z_vision", "emp", 200, "emp", ks[9] + " kills you have earned a Vision Restorer");
	}

	else if( ammount == ks[10] )
		self thread give_Killstreak("z_nuke", "nuke", 300, "nuke", ks[10] + " kills you have earned a S.Z.B");

	else if( ammount == ks[11] )
	{
		self thread give_Killstreak("z_permbot", "", 400, "permbot", ks[11] + " kills you have earned a Permanent Bot");
		self thread maps\mp\killstreaks\_sniper::SpawnChickenFriend(self);
	}
}

give_Killstreak(killstreak_amount, killstreak, xp, killstreak_name, text, random_amount)
{
	if( killstreak_name != "" && self.pers["lastKillstreak"] == killstreak_name )
		return false;
		
	self thread HudRightMessage(text, (1,1,1), (0.3,0.9,0.3), 1, 0.85);
	self.pers["lastKillstreak"] = killstreak_name;
	
	//if( killstreak_name != "permbot" )
	//	self playlocalsound("mp_level_up");
		
	self maps\mp\killstreaks\_killstreaks::giveKillstreak( killstreak, true );
	self thread maps\mp\gametypes\_rank::giveRankXP("killstreak", xp);

	if(isDefined(random_amount))
	{
		for( i=0;i<random_amount;i++)
		{
			wait 5.0;
			self thread KillStreakRandom();
		}
	}
	
	return true;
}

KillStreakRandom()
{
	self endon("disconnect");
	switch(randomInt(4))
	{
		case 0: 
		self thread give_Killstreak("", "predator_missile", 0, "", "Random Killstreak: Predator Missile");
		break;
		case 1: 
		self thread give_Killstreak("", "uav", 0, "", "Random Killstreak: Airstrike");
		break;
		case 2: 
		self thread give_Killstreak("", "sentry", 0, "", "Random Killstreak: Sentry Gun");
		break;
		case 3: 
		self thread give_Killstreak("", "counter_uav", 0, "", "Random Killstreak: AC-130 Gunship Support");
		break;
	}
}