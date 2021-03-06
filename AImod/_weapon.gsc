#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\spawn;
#include AImod\_Mod;

getAllWeapons(whatWeapon)//What weapon to get
{
	foundWeapon = 0;
	weaponList = self GetWeaponsListAll();
	{
		foreach(weaponName in weaponList)
		{
			if(weaponName != whatWeapon)
			{
				continue;
			}	
			else if(weaponName == whatWeapon)
			{
				foundWeapon = 1;
			}
		}
	}
	if(foundWeapon == 1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

IfCanSetOnFire(sWeapon)
{
	setFire = 0;
	switch(sWeapon)
	{
		case "tmp_silencer_mp":
		setFire = 1;
		break;
		case "tmp_silencer_xmags_mp":
		setFire = 1;
		break;
		case "cheytac_mp":
		setFire = 1;
		break;
		case "cheytac_fmj_mp":
		setFire = 1;
		break;
		case "model1887_akimbo_fmj_mp":
		setFire = 1;
		break;
	}
	if(setFire == 0)
		return false;
		
	if(setFire == 1)
		return true;
}

IfCanBlowUp(sWeapon)
{
	setBlow = 0;
	switch(sWeapon)
	{
		case "rpg_mp":
		setBlow = 1;
		break;
		case "frag_grenade_mp":
		setBlow = 1;
		break;
		case "semtex_mp":
		setBlow = 1;
		break;
		case "c4_mp":
		setBlow = 1;
		break;
		case "gl_ak47_mp":
		setBlow = 1;
		break;
		case "gl_m16_mp":
		setBlow = 1;
		break;
		case "gl_m4_mp":
		setBlow = 1;
		break;
		case "gl_fn2000_mp":
		setBlow = 1;
		break;
		case "gl_masada_mp":
		setBlow = 1;
		break;
		case "gl_famas_mp":
		setBlow = 1;
		break;
		case "gl_fal_mp":
		setBlow = 1;
		break;
		case "gl_scar_mp":
		setBlow = 1;
		break;
		case "gl_tavor_mp":
		setBlow = 1;
		break;
		case "gl_mp":
		setBlow = 1;
		break;
		case "at4_mp":
		setBlow = 1;
		break;
		case "ac130_40mm_mp":
		setBlow = 1;
		break;
		case "ac130_105mm_mp":
		setBlow = 1;
		break;
	}
	if(setBlow == 0)
		return false;
		
	if(setBlow == 1)
		return true;
}

IfCanDoHitmarker(sWeapon)
{
	Hitmarker = 0;
	switch(sWeapon)
	{
		case "tmp_silencer_mp":
		Hitmarker = 1;
		break;
		case "tmp_silencer_xmags_mp":
		Hitmarker = 1;
		break;
		case "pp2000_eotech_mp":
		Hitmarker = 1;
		break;
		case "pp2000_eotech_xmags_mp":
		Hitmarker = 1;
		break;
	}
	if(Hitmarker == 0)
		return true;
		
	if(Hitmarker == 1)
		return false;
}

blowBackGrenade(vPoint)
{
	self startRagDoll(1);
	PhysicsExplosionSphere( vPoint, 30, 30, 6 );
}

AmmoMaticAdd(sWeapon)
{
	AmmoMatic = 0;
	switch(sWeapon)
	{
		case "beretta_mp":
		AmmoMatic = 4;
		break;
		case "usp_mp":
		AmmoMatic = 4;
		break;
		case "deserteagle_mp":
		AmmoMatic = 2;
		break;
		case "coltanaconda_mp":
		AmmoMatic = 2;
		break;
		case "glock_mp":
		AmmoMatic = 4;
		break;
		case "beretta393_mp":
		AmmoMatic = 4;
		break;
		case "mp5k_mp":
		AmmoMatic = 3;
		break;
		case "pp2000_mp":
		AmmoMatic = 2;
		break;
		case "pp2000_eotech_mp":
		AmmoMatic = 1;
		break;
		case "uzi_mp":
		AmmoMatic = 2;
		break;
		case "p90_mp":
		AmmoMatic = 3;
		break;
		case "kriss_mp":
		AmmoMatic = 3;
		break;
		case "ump45_mp":
		AmmoMatic = 2;
		break;
		case "tmp_mp":
		AmmoMatic = 3;
		break;
		case "ak47_mp":
		AmmoMatic = 2;
		break;
		case "m16_reflex_mp":
		AmmoMatic = 2;
		break;
		case "m4_reflex_mp":
		AmmoMatic = 3;
		break;
		case "fn2000_mp":
		AmmoMatic = 3;
		break;
		case "masada_mp":
		AmmoMatic = 3;
		break;
		case "famas_mp":
		AmmoMatic = 2;
		break;
		case "fal_mp":
		AmmoMatic = 1;
		break;
		case "scar_mp":
		AmmoMatic = 2;
		break;
		case "tavor_mp":
		AmmoMatic = 3;
		break;
		case "m79_mp":
		AmmoMatic = 1;
		break;
		case "rpg_mp":
		AmmoMatic = 1;
		break;
		case "at4_mp":
		AmmoMatic = 1;
		break;
		case "javelin_mp":
		AmmoMatic = 1;
		break;
		case "barrett_mp":
		AmmoMatic = 1;
		break;
		case "wa2000_acog_mp":
		AmmoMatic = 1;
		break;
		case "m21_acog_mp":
		AmmoMatic = 1;
		break;
		case "cheytac_mp":
		AmmoMatic = 1;
		break;
		case "ranger_mp":
		AmmoMatic = 1;
		break;
		case "model1887_mp":
		AmmoMatic = 1;
		break;
		case "model1887_fmj_mp":
		AmmoMatic = 1;
		break;
		case "striker_mp":
		AmmoMatic = 1;
		break;
		case "aa12_mp":
		AmmoMatic = 1;
		break;
		case "m1014_mp":
		AmmoMatic = 1;
		break;
		case "spas12_mp":
		AmmoMatic = 1;
		break;
		case "rpd_mp":
		AmmoMatic = 2;
		break;
		case "sa80_mp":
		AmmoMatic = 2;
		break;
		case "mg4_mp":
		AmmoMatic = 2;
		break;
		case "m240_grip_mp":
		AmmoMatic = 2;
		break;
		case "aug_mp":
		AmmoMatic = 2;
		break;
		case "m4_silencer_mp":
		AmmoMatic = 2;
		break;
		case "tmp_silencer_mp":
		AmmoMatic = 1;
		break;
		case "ump45_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "usp_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "deserteagle_akimbo_mp":
		AmmoMatic = 4;
		break;
		case "beretta_akimbo_xmags_mp":
		AmmoMatic = 0;
		break;
		case "wa2000_acog_xmags_mp":
		AmmoMatic = 2;
		break;
		case "m16_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "famas_acog_fmj_mp":
		AmmoMatic = 3;
		break;
		case "beretta393_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "ak47_fmj_xmags_mp":
		AmmoMatic = 4;
		break;
		case "aa12_grip_xmags_mp":
		AmmoMatic = 2;
		break;
		case "striker_xmags_mp":
		AmmoMatic = 2;
		break;
		case "cheytac_fmj_mp":
		AmmoMatic = 2;
		break;
		case "glock_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "rpd_eotech_grip_mp":
		AmmoMatic = 3;
		break;
		case "coltanaconda_akimbo_fmj_mp":
		AmmoMatic = 4;
		break;
		case "m4_eotech_shotgun_mp":
		AmmoMatic = 3;
		break;
		case "mp5k_fmj_xmags_mp":
		AmmoMatic = 3;
		break;
		case "ak47_gl_thermal_mp":
		AmmoMatic = 4;
		break;
		case "sa80_grip_xmags_mp":
		AmmoMatic = 3;
		break;
		case "m21_acog_xmags_mp":
		AmmoMatic = 2;
		break;
		case "spas12_grip_xmags_mp":
		AmmoMatic = 2;
		break;
		case "tmp_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "mg4_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "pp2000_fmj_reflex_mp":
		AmmoMatic = 3;
		break;
		case "aug_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "m240_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "tavor_fmj_reflex_mp":
		AmmoMatic = 3;
		break;
		case "kriss_reflex_rof_mp":
		AmmoMatic = 3;
		break;
		case "scar_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "ranger_akimbo_fmj_mp":
		AmmoMatic = 2;
		break;
		case "p90_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "masada_reflex_xmags_mp":
		AmmoMatic = 4;
		break;
		case "uzi_acog_silencer_mp":
		AmmoMatic = 3;
		break;
		case "model1887_akimbo_fmj_mp":
		AmmoMatic = 2;
		break;
		case "fn2000_reflex_mp":
		AmmoMatic = 3;
		break;
		case "fal_reflex_xmags_mp":
		AmmoMatic = 2;
		break;
		case "m1014_xmags_mp":
		AmmoMatic = 2;
		break;
		case "tmp_silencer_xmags_mp":
		AmmoMatic = 2;
		break;
		case "pp2000_eotech_xmags_mp":
		AmmoMatic = 1;
		break;
		case "deserteaglegold_mp":
		AmmoMatic = 4;
		break;
		case "m4_acog_silencer_mp":
		AmmoMatic = 3;
		break;
		case "ranger_fmj_mp":
		AmmoMatic = 1;
		break;
		case "stinger_mp":
		AmmoMatic = 1;
		break;
	}
	return AmmoMatic;
}

IncreaseDamage(sWeapon, type)
{
	switch(sWeapon)
	{
		case "ac130_105mm_mp":
		self.crate1.health -= 2000;
		break;
		case "ac130_40mm_mp":
		self.crate1.health -= 2000;
		break;
		case "ac130_25mm_mp":
		self.crate1.health -= 0;
		break;
		case "m240_xmags_mp":
		self.crate1.health -= 30;
		break;
		case "m240_fmj_xmags_mp":
		self.crate1.health -= 15;
		break;
		case "ak47_gl_thermal_mp":
		self.crate1.health -= 10;
		break;
		case "m4_eotech_shotgun_mp":
		self.crate1.health -= 15;
		break;
		case "coltanaconda_akimbo_fmj_mp":
		self.crate1.health -= 40;
		break;
		case "fal_reflex_xmags_mp":
		self.crate1.health -= 20;
		break;
		case "cheytac_mp":
		self.crate1.health -= 80;
		break;
		case "cheytac_fmj_mp":
		self.crate1.health -= 140;
		break;
		case "m21_acog_xmags_mp":
		self.crate1.health -= 15;
		break;
		case "tmp_akimbo_xmags_mp":
		self.crate1.health -= 15;
		break;
		case "spas12_grip_xmags_mp":
		self.crate1.health -= 30;
		break;
		case "beretta393_akimbo_xmags_mp":
		self.crate1.health -= 10;
		break;
		case "ump45_eotech_xmags_mp":
		self.crate1.health -= 10;
		break;
		case "aa12_grip_xmags_mp":
		self.crate1.health -= 30;
		break;
		case "kriss_reflex_rof_mp":
		self.crate1.health -= 15;
		break;
		case "deserteaglegold_mp":
		self.crate1.health -= 80;
		break;
		case "fn2000_reflex_mp":
		self.crate1.health -= 15;
		break;
		case "barrett_acog_xmags_mp":
		self.crate1.health -= 70;
		break;
		case "mp5k_fmj_xmags_mp":
		self.crate1.health -= 10;
		break;
		case "p90_akimbo_xmags_mp":
		self.crate1.health -= 5;
		break;
		case "sa80_grip_xmags_mp":
		self.crate1.health -= 10;
		break;
		case "famas_acog_fmj_mp":
		self.crate1.health -= 15;
		break;
		case "m16_eotech_xmags_mp":
		self.crate1.health -= 10;
		break;
	}
}

ZombieAirstrikeSound(sWeapon)
{
	switch(randomInt(12))
	{
		case 0:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_rightontarget" );
		break;
		case 1:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_goodkill" );
		break;
		case 2:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_yougothim" );
		break;
		case 3:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_yougothim2" );
		break;
		case 4:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_thatsahit" );
		break;
		case 5:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_directhit" );
		break;
		case 6:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_within2feet" );
		break;
		case 7:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_plt_gottahurt" );
		break;
		case 8:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_oopsiedaisy" );
		break;
		case 9:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_iseepieces" );
		break;
		case 10:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_nice" );
		break;
		case 11:
		self PlayLocalSound(maps\mp\gametypes\_teams::getTeamVoicePrefix( "allies" ) + "ac130_fco_directhits" );
		break;
	}
}