#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;
#include AImod\_weapon;
#include AImod\_text;

BonusDropsDeadOps()
{
    self endon("disconnect");
	self endon("bot_is_dead");
	random = randomInt(20);
	randomequels = randomInt(20);
	self waittill("bot_death");
	{
		if(random == randomequels)
		{
			switch(randomInt(20))
			{
				case 0:
				BonusDrop(self.origin, self.angles, "give_weapon", "high_powered_ak47", "hud_icon_ak47", "AK47 Akimbo", "ak47_fmj_shotgun_mp", "weapon_ak47_tactical", 1, "misc/flare_ambient");
				break;
				case 1:
				BonusDrop(self.origin, self.angles, "give_weapon", "automatic_shotgun", "hud_icon_aa12", "Automatic Shotgun", "aa12_grip_xmags_mp", "weapon_aa12", 1, "misc/flare_ambient_green");
				break;
				case 2:
				BonusDrop(self.origin, self.angles, "give_weapon", "high_power_pistol", "cardicon_fmj", "High Power Pistol", "coltanaconda_akimbo_fmj_mp", "weapon_colt_anaconda", 1, "misc/aircraft_light_wingtip_green");
				break;
				case 3:
				BonusDrop(self.origin, self.angles, "give_weapon", "super_rpg", "cardicon_doubletap", "Rockets", "gl_mp", "weapon_rpg7", 1, "fire/firelp_small_pm");
				break;
				case 4:
				BonusDrop(self.origin, self.angles, "zombie_blood", "zombie_blood_drop_take", "cardicon_eagle", "Zombie Blood", "", "com_plasticcase_enemy", 0, "misc/flare_ambient");
				break;
				case 5:
				BonusDrop(self.origin, self.angles, "give_weapon", "auto_m9", "hud_icon_beretta393", "G18 Akimbo", "glock_akimbo_xmags_mp", "viewmodel_glock", 1, "misc/aircraft_light_wingtip_green");
				break;
				case 6:
				BonusDrop(self.origin, self.angles, "give_weapon", "auto_50cal", "hud_icon_barrett50cal", "Ranger", "ranger_akimbo_mp", "viewmodel_sawed_off_double_barrel", 1, "misc/flare_ambient");
				break;
				case 7:
				BonusDrop(self.origin, self.angles, "speed_boost", "speedy_boost", "specialty_lightweight_upgrade", "Speed Boost", "", "com_plasticcase_friendly", 0, "");
				break;
				case 8:
				BonusDrop(self.origin, self.angles-(90,0,0), "nuke", "nuke_off", "dpad_killstreak_nuke", "Nuke!", "", "projectile_cbu97_clusterbomb", 0, "fire/firelp_small_pm");
				break;
				case 9:
				BonusDrop(self.origin, self.angles, "insta_kill", "insta_kill_drop_take", "cardicon_fmj", "Insta-Kill", "", "com_plasticcase_friendly", 0, "fire/firelp_small_pm");
				break;
				case 10:
				BonusDrop(self.origin, self.angles, "give_weapon", "javelin", "hud_icon_javelin", "J.H.A. Tomahawk", "stinger_mp", "weapon_javelin", 1, "fire/firelp_small_pm");
				break;
				case 11:
				BonusDrop(self.origin, self.angles, "give_weapon", "rayugun", "hud_icon_pp2000", "Porters X2 Raygun", "pp2000_eotech_xmags_mp", "weapon_pp2000_blue_tiger", 1, "misc/flare_ambient_green");
				break;
				case 12:
				BonusDrop(self.origin, self.angles, "give_weapon", "1887", "hud_icon_model1887", "DUKIP 1337", "model1887_akimbo_mp", "weapon_model1887", 1, "misc/flare_ambient");
				break;
				case 13:
				BonusDrop(self.origin, self.angles, "give_weapon", "mg4_scope", "hud_icon_mg4", "MG4 Scope", "mg4_silencer_mp", "weapon_mg4", 1, "misc/flare_ambient_green");
				break;
				case 14:
				BonusDrop(self.origin, self.angles, "give_weapon", "m240", "hud_icon_m240", "Massive Twenty Nine", "m240_fmj_xmags_mp", "weapon_m240", 1, "misc/flare_ambient");
				break;
				case 15:
				BonusDrop(self.origin, self.angles, "give_weapon", "m16", "hud_icon_m16a4", "Skullcrusher 2.0", "m16_eotech_xmags_mp", "weapon_m16", 1, "misc/flare_ambient_green");
				break;
				case 16:
				BonusDrop(self.origin, self.angles, "give_weapon", "ac130", "cardicon_doubletap", "Walking AC130 25MM", "ac130_25mm_mp", "com_plasticcase_enemy", 1, "fire/firelp_small_pm");
				break;
				case 17:
				BonusDrop(self.origin, self.angles, "give_weapon", "aug", "hud_icon_steyr", "AUG Scope", "aug_silencer_mp", "weapon_steyr_arctic", 1, "misc/flare_ambient_green");
				break;
				case 18:
				BonusDrop(self.origin, self.angles, "give_weapon", "hands", "cardicon_doubletap", "God of Hands", "claymore_mp", "viewmodel_base_viewhands", 0, "misc/flare_ambient");
				break;
				case 19:
				BonusDrop(self.origin, self.angles, "give_weapon", "deathmachine", "cardicon_skull", "Death Machine", "m240_grip_reflex_mp", "vehicle_little_bird_minigun_left", 1, "fire/firelp_small_pm");
				break;
			}
		}
	}
}

BonusDrop(pos, angle, type, killnotify, icon, text, gun, model, isGunModel ,fx)
{
	PreCacheModel( model );
	level.block = spawn("script_model", pos + (0, 0, 45) );
	level.block setModel(model);
	if(isGunModel == 1)
		level.block thread HideGunParts(gun);
	level.block.angles = angle;
	level.block notSolid();
	level.block.trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	level.block.trigger.angles = angle;
	level.block.fx = SpawnFX(loadFX(fx),level.block.origin);
	TriggerFX(level.block.fx);
	level.block thread BonusDropThink(pos, angle, gun, killnotify, icon, text, type);
	level.block thread BonusDropDestroy(killnotify);
	level.block thread BonusDropTimerDestroy(killnotify);
	level.block thread rotateDrop(killnotify);
	wait 0.05;
}

BonusDropTimerDestroy(killnotify)
{
	self endon(killnotify);
	{
		wait 20;
		for(count = 10;count > -1;count--)
		{
			wait 0.5;
			self hide();
			wait 0.5;
			self show();
		}
		self notify("bonusdrop_done");
		self.fx delete();
		self.trigger delete();
		self delete();
		self notify(killnotify);
	}
}

rotateDrop(killnotify)
{
    self endon(killnotify);
	for(;;)
	{
		self rotateyaw(-360,5);
		wait 5;
	}
}

BonusDropDestroy(killnotify)
{
	self waittill(killnotify);
	self.fx delete();
	self delete();
}

BonusDropThink(pos, angle, gun, killnotify, icon, text, type)
{
	self endon("disconnect");
	self endon("bonusdrop_done"); 
	while(1)
	{
		self.trigger waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			switch(type)
			{
				case "give_weapon":
				playSoundInSpace( "US_1mc_demolition",self.origin );
				if(player getCurrentWeapon() != "mg4_mp" && player getCurrentWeapon() != "ak47_fmj_mp" && player getCurrentWeapon() != "ranger_fmj_mp" )
				{
					player takeWeapon(player getCurrentWeapon());
				}
				player notify("stop_current_bonus_drop_gun");
				player thread giveTheBonusDropGun(gun, icon, text);
				self notify(killnotify);
				self notify("random_drop_destroy");
				break;
				case "speed_boost":
				playSoundInSpace( "US_1mc_demolition",self.origin );
				player notify("speed_bost");
				player thread SpeedBoost(icon, text);
				self notify(killnotify);
				self notify("random_drop_destroy");
				break;
				case "nuke":
				playSoundInSpace( "US_1mc_domination",self.origin );
				player thread AImod\_text::BonusDropText(text, 0.85, (1,1,1),(1,0.3,0.3),1); 
				player thread AImod\_text::BonusDropIcon(icon);
				player thread AImod\_bonusdrops::KaBoom(self);
				self notify(killnotify);
				break;
				case "insta_kill":
				self notify(killnotify);
				playSoundInSpace( "US_1mc_sabotage",self.origin );
				level thread AImod\_bonusdrops::InstaKill();
				break;
				case "zombie_blood":
				self notify(killnotify);
				playSoundInSpace( "US_1mc_hc_captureflag",self.origin );
				level thread AImod\_bonusdrops::ZombieBlood();
				break;
			}
			self notify("bonusdrop_done");
			self.trigger delete();
		}
		wait 0.1;
	}
}

giveTheBonusDropGun(gun, icon, text)
{ 
    level endon("disconnect");
	self endon("stop_current_bonus_drop_gun");
	{
		self thread AImod\_text::BonusDropText(text + "!", 0.85, (1,1,1),(1,0.5,0.3),1); 
		self thread AImod\_text::BonusDropIcon(icon);
		//self playLocalSound("mp_level_up");
		self thread GunNoSwitch(gun);
		self thread GunTimer(text);
	    	self giveWeapon(gun, 0, true);
		self switchToWeapon(gun);
		self GiveMaxAmmo(gun);
		self waittill("gun_time_ended");
		self notify("stop_gun_switch");
		self switchToWeapon("mg4_mp");
		self switchToWeapon("ak47_fmj_mp");
		self switchToWeapon("ranger_fmj_mp");
		self takeWeapon(gun);
		self.GunTimer destroy();
		wait 0.1;
		self thread AImod\_text::BonusDropText(text + " Ran out!", 0.85, (1,1,1),(0.9,0.3,0.3),1); 
		self thread AImod\_text::BonusDropIcon(icon);
		//self playLocalSound("mp_level_up");
	}
	wait 0.1;
}

SpeedBoost(icon, text)
{
	self endon("disconnect");
	self endon("speed_bost");
	self thread AImod\_text::BonusDropText(text + "!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
	self thread AImod\_text::BonusDropIcon(icon);
	//self playLocalSound("mp_level_up");
	self.moveSpeedScaler = 1.3;
	self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );
	self thread BoostTimer();
	self waittill("boost_time_ended");
	self.BoostTimer destroy();
	self.moveSpeedScaler = 1.0;
	self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );
	self thread AImod\_text::BonusDropText(text + " Has Ran Out!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
	self thread AImod\_text::BonusDropIcon(icon);
}

BoostTimer(text)
{
	self endon("disconnect");
	self endon("speed_bost");
	{
		time = 15;
		self.BoostTimer destroy();
		self.BoostTimer = self createFontString("objective", 1.5);
		self.BoostTimer setPoint("BOTTOMLEFT", "BOTTOMLEFT", 0, -45);
		self.BoostTimer.label = &"Boost Runs out in: ";
		self.BoostTimer.HideWhenInMenu = true;
		self.BoostTimer.color = (1,1,1);
		self.BoostTimer.glowColor = (0.3,0.9,0.3);
		self.BoostTimer.alpha = 1;
		self.BoostTimer.glowAlpha = 1;
		for(count = time;count > -1;count--)
		{
			self.BoostTimer setValue(time);
			time = count;
			wait 1;
		}
		self notify("boost_time_ended");
	}
}

GunTimer(text)
{
	self endon("disconnect");
	self endon("stop_current_bonus_drop_gun");
	{
		time = 30;
		self.GunTimer destroy();
		self.GunTimer = self createFontString("objective", 1.5);
		self.GunTimer setPoint("BOTTOMLEFT", "BOTTOMLEFT", 0, -30);
		self.GunTimer.label = &"Gun Runs out in: ";
		self.GunTimer.HideWhenInMenu = true;
		self.GunTimer.color = (1,1,1);
		self.GunTimer.glowColor = (0.9,0.3,0.3);
		self.GunTimer.alpha = 1;
		self.GunTimer.glowAlpha = 1;
		for(count = time;count > -1;count--)
		{
			self.GunTimer setValue(time);
			time = count;
			wait 1;
		}
		self notify("gun_time_ended");
	}
}

GunNoSwitch(gun)
{
    self endon("stop_current_bonus_drop_gun");
	self endon("stop_gun_switch");
    while(1)
	{
	    self switchToWeapon(gun);
		wait 0.1;
	}
}