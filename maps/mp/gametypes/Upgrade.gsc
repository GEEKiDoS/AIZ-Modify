#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;

main()
{
    level.upgrade_weapon = [];
    level.upgrade_weapon["ump45_mp"] = "ak47_gl_thermal_mp";
    level.upgrade_weapon["defaultweapon_mp"] = "claymore_mp";
    level.upgrade_weapon["usp_mp"] = "usp_akimbo_xmags_mp";
    level.upgrade_weapon["beretta_mp"] = "beretta_fmj_mp";
    level.upgrade_weapon["wa2000_acog_mp"] = "wa2000_acog_xmags_mp";
    level.upgrade_weapon["m16_reflex_mp"] = "m16_eotech_xmags_mp";
    level.upgrade_weapon["famas_mp"] = "famas_fmj_reflex_mp";
    level.upgrade_weapon["beretta393_mp"] = "beretta393_akimbo_xmags_mp";
    level.upgrade_weapon["ak47_mp"] = "ak47_fmj_xmags_mp";
    level.upgrade_weapon["aa12_mp"] = "aa12_grip_xmags_mp";
    level.upgrade_weapon["striker_mp"] = "striker_xmags_mp";
    level.upgrade_weapon["cheytac_mp"] = "cheytac_fmj_mp";
    level.upgrade_weapon["glock_mp"] = "glock_akimbo_xmags_mp";
    level.upgrade_weapon["rpd_mp"] = "rpd_eotech_grip_mp";
    level.upgrade_weapon["onemanarmy_mp"] = "m240_fmj_xmags_mp";
    level.upgrade_weapon["coltanaconda_mp"] = "coltanaconda_akimbo_fmj_mp";
    level.upgrade_weapon["m4_reflex_mp"] = "m4_eotech_shotgun_mp";
    level.upgrade_weapon["mp5k_mp"] = "mp5k_fmj_xmags_mp";
    level.upgrade_weapon["at4_mp"] = "pp2000_akimbo_silencer_mp";
    level.upgrade_weapon["barrett_mp"] = "barrett_acog_xmags_mp";
    level.upgrade_weapon["sa80_mp"] = "sa80_grip_xmags_mp";
    level.upgrade_weapon["m21_acog_mp"] = "m21_acog_xmags_mp";
    level.upgrade_weapon["spas12_mp"] = "spas12_grip_xmags_mp";
    level.upgrade_weapon["tmp_mp"] = "tmp_akimbo_xmags_mp";
    level.upgrade_weapon["mg4_mp"] = "mg4_eotech_xmags_mp";
    level.upgrade_weapon["pp2000_mp"] = "pp2000_fmj_reflex_mp";
    level.upgrade_weapon["aug_mp"] = "aug_acog_xmags_mp";
    level.upgrade_weapon["m240_grip_mp"] = "m240_eotech_xmags_mp";
    level.upgrade_weapon["tavor_mp"] = "tavor_fmj_reflex_mp";
    level.upgrade_weapon["kriss_mp"] = "kriss_reflex_rof_mp";
    level.upgrade_weapon["scar_mp"] = "scar_eotech_xmags_mp";
    level.upgrade_weapon["ranger_mp"] = "ranger_akimbo_mp";
    level.upgrade_weapon["p90_mp"] = "p90_akimbo_xmags_mp";
    level.upgrade_weapon["masada_mp"] = "pp2000_akimbo_mp";
    level.upgrade_weapon["uzi_mp"] = "uzi_acog_silencer_mp";
    level.upgrade_weapon["model1887_mp"] = "model1887_akimbo_fmj_mp";
    level.upgrade_weapon["m79_mp"] = "striker_eotech_grip_mp";
    level.upgrade_weapon["fn2000_mp"] = "fn2000_reflex_mp";
    level.upgrade_weapon["fal_mp"] = "fal_reflex_xmags_mp";
    level.upgrade_weapon["m1014_mp"] = "m1014_xmags_mp";
    level.upgrade_weapon["tmp_silencer_mp"] = "tmp_silencer_xmags_mp";
    level.upgrade_weapon["pp2000_eotech_mp"] = "pp2000_eotech_xmags_mp";
    level.upgrade_weapon["ranger_fmj_mp"] = "ranger_akimbo_mp";
    level.upgrade_weapon["ak47_fmj_mp"] = "ak47_fmj_shotgun_mp";
    level.upgrade_weapon["m16_shotgun_xmags_mp"] = "m16_shotgun_mp";
    level.upgrade_weapon["deserteagle_mp"] = "deserteagle_akimbo_mp";
    level.upgrade_weapon["deserteagle_tactical_mp"] = "deserteagle_fmj_tactical_mp";
    level.upgrade_weapon["m4_silencer_mp"] = "m4_acog_silencer_mp";
    level.upgrade_weapon["javelin_mp"] = "stinger_mp";
    level.upgrade_weapon["rpg_mp"] = "gl_mp";
}

giveUpgradedWeapon(pos, angle, gunup)
{
    self endon("disconnect");
    self endon("death");
    self endon("upgrade_weapon_take");
    ismulekickweapon = 0;
	if(self.mulekicktakeweapon == gunup)
    {
    		ismulekickweapon = 1;
    }
    if(IsSubStr(level.upgrade_weapon[gunup],"akimbo") && !IsSubStr(level.upgrade_weapon[gunup],"ranger"))
    {
        level.upgradeweapon = spawn("script_model", pos);
        level.upgradeweapon setModel(GetWeaponModel(level.upgrade_weapon[gunup]));
        level.upgradeweapon.angles = angle;
        level.upgradeweapon thread HideGunParts(level.upgrade_weapon[gunup]);
        level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
        level.upgradeweapon2 setModel(GetWeaponModel(level.upgrade_weapon[gunup]));
        level.upgradeweapon2.angles = angle;
        level.upgradeweapon2 thread HideGunParts(level.upgrade_weapon[gunup]);
        wait 0.4;
        level.upgradeweapon MoveTo(pos+(0,0,40), 2);
        level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
        wait 2;
        self thread giveWeaponUpgrade(pos, level.upgrade_weapon[gunup], level.upgradeweapon, level.upgradeweapon2, ismulekickweapon);
        level.upgradeweapon MoveTo(pos+(0,0,10), 10);
        level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
        wait 10;
        level.upgradeweapon delete();
        level.upgradeweapon2 delete();
        self notify("upgrade_gone");
        self.weapons = 0; 
    }
    else
    {
        if(level.upgrade_weapon[gunup] == "ak47_fmj_mp" || level.upgrade_weapon[gunup] == "ak47_fmj_shotgun_mp") //add other akimbo weapon to here
        {
            level.upgradeweapon = spawn("script_model", pos);
            level.upgradeweapon setModel(GetWeaponModel(level.upgrade_weapon[gunup]));
            level.upgradeweapon.angles = angle;
            level.upgradeweapon thread HideGunParts(level.upgrade_weapon[gunup]);
            level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
            level.upgradeweapon2 setModel(GetWeaponModel(level.upgrade_weapon[gunup]));
            level.upgradeweapon2.angles = angle;
            level.upgradeweapon2 thread HideGunParts(level.upgrade_weapon[gunup]);
            wait 0.4;
            level.upgradeweapon MoveTo(pos+(0,0,40), 2);
            level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
            wait 2;
            self thread giveWeaponUpgrade(pos, level.upgrade_weapon[gunup], level.upgradeweapon, level.upgradeweapon2, ismulekickweapon);
            level.upgradeweapon MoveTo(pos+(0,0,10), 10);
            level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
            wait 10;
            level.upgradeweapon delete();
            level.upgradeweapon2 delete();
            self notify("upgrade_gone");
            self.weapons = 0; 
        }
        else
        {
            level.upgradeweapon = spawn("script_model", pos);
            level.upgradeweapon setModel(GetWeaponModel(level.upgrade_weapon[gunup],8));
            level.upgradeweapon.angles = angle;
            level.upgradeweapon thread HideGunParts(level.upgrade_weapon[gunup]);
            wait 0.4;
            level.upgradeweapon MoveTo(pos+(0,0,40), 2);
            wait 2;
            self thread giveWeaponUpgrade(pos, level.upgrade_weapon[gunup], level.upgradeweapon, ismulekickweapon);
            level.upgradeweapon MoveTo(pos, 10);
            wait 10;
            level.upgradeweapon delete();
            self notify("upgrade_gone");
            self.weapons = 0;
        }
    }
}

giveWeaponUpgrade(pos, weap, upgradeweapon, upgradeweapon2, ismulekickweapon)
{
    self endon("disconnect");
    self endon("upgrade_gone");
    while(1)
    {
        if(Distance(pos, self.origin) <= 75)
        {
            self setLowerMessage("upgradetrade", "Press & Hold ^3[{+activate}]^7 to trade your weapon" );
        }
        else
        {
            if(Distance(pos, self.origin) >50) self ClearLowerMessage("upgradetrade", 1);
        }
        if(Distance(pos, self.origin) <= 75 && self useButtonPressed())
        {
            self ClearLowerMessage("upgradetrade", 1);
            self notify("newWeapon");
            wait 0.1;
            if(weap == "pp2000_eotech_xmags_mp")
                self giveWeapon(weap, 4, true);
            else
                self giveWeapon(weap, 8, true);
            self switchToWeapon(weap);
            self giveMaxAmmo(weap);
            if(ismulekickweapon)
            {
            	self.mulekicktakeweapon = weap;
            }
            upgradeweapon delete();
            upgradeweapon2 delete();
            self notify("upgrade_weapon_take");
            self notify("upgrade_gone");
            wait 0.05;
        }
        wait 0.05;
    }
}

WeaponBiu()
{
    self endon("death");
    for(;;)
    {
        self waittill( "weapon_fired", gun );
        if ( IsDefined(level.upgrade_weapon[gun]) )
        {
            self playSound("mp_levelup_final");
        }
    }
}

GetCursorPos()
{
    forward = self getTagOrigin("tag_eye");
    end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
    location = BulletTrace( forward, end, 0, self)[ "position" ];
    return location;
}

vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}