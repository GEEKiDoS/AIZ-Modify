#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;
#include AImod\_Bot;
#include AImod\_weapon;
#include AImod\_text;
#include AImod\_DoaBonusDrops;

BonusDrops()
{
    self endon("disconnect");
	self endon("bonus_end");
	self endon("bot_is_dead");

	/#
	BonusDropReg(self, self.angles, "death_machine_drop", "death_machine_drop_take", "cardicon_skull", "Death Machine", "m240_grip_reflex_mp", "vehicle_little_bird_minigun_left", 1, loadFX("misc/flare_ambient"));
	#/
	
	if(level.Wave <= 5)
	{
		random = randomInt(30);
		randomequels = randomInt(30);
	}
	else if(level.Wave <= 10)
	{
		random = randomInt(40);
		randomequels = randomInt(40);
	}
	else
	{
		random = randomInt(45);
		randomequels = randomInt(45);
	}

	//random = randomInt(5);
	//randomequels = randomInt(5);

	self waittill("bot_death");
	if(getDvar("g_gametype") == "ss" || getDvar("g_gametype") == "dom")
	{
		if(random == randomequels)
		{
			switch(randomInt(4))
			{
				case 0:
				BonusDropReg(self, self.angles-(90,0,0), "nuke_drop", "nuke_drop_take", "dpad_killstreak_nuke", "Nuke", "", "projectile_cbu97_clusterbomb", 0, level.SmallFire);
				break;
				case 1:
				BonusDropReg(self, self.angles, "double_points", "double_points_take", "cardicon_gold", "Double Points", "", "com_plasticcase_friendly", 0, loadFX("misc/flare_ambient"));
				break;
				case 2:
				BonusDropReg(self, self.angles, "insta_kill_drop", "insta_kill_drop_take", "cardicon_fmj", "Insta-Kill", "", "com_plasticcase_friendly", 0, level.SmallFire);
				break;
               case 3:
               BonusDropReg(self, self.angles, "zombie_blood", "zombie_blood_drop_take", "cardicon_eagle", "Zombie Blood", "", "com_plasticcase_enemy", 0, loadFX("misc/flare_ambient"));
               break;
			}
		}
	}
	else
	{
		if(random == randomequels)
		{
			switch(randomInt(7))
			{
				case 0:
				BonusDropReg(self, self.angles-(90,0,0), "nuke_drop", "nuke_drop_take", "dpad_killstreak_nuke", "Nuke", "", "projectile_cbu97_clusterbomb", 0, level.SmallFire);
				break;
				case 1:
				BonusDropReg(self, self.angles, "double_points", "double_points_take", "cardicon_gold", "Double Points", "", "com_plasticcase_friendly", 0, loadFX("misc/flare_ambient"));
				break;
				case 2:
				BonusDropReg(self, self.angles, "insta_kill_drop", "insta_kill_drop_take", "cardicon_fmj", "Insta-Kill", "", "com_plasticcase_friendly", 0, level.SmallFire);
				break;
				case 3:
				BonusDropReg(self, self.angles, "death_machine_drop", "death_machine_drop_take", "cardicon_skull", "Death Machine", "m240_grip_reflex_mp", "vehicle_little_bird_minigun_left", 1, loadFX("misc/flare_ambient"));
				break;
				case 4:
				BonusDropReg(self, self.angles, "ammo", "ammo_drop_take", "waypoint_ammo_friendly", "Max Ammo", "", "com_plasticcase_friendly", 0, loadFX("misc/flare_ambient_green"));
				break;
               case 5:
               BonusDropReg(self, self.angles, "fire_sale", "fire_sale_drop_take", "cardicon_award_jets", "Fire Sale", "", "com_plasticcase_enemy", 0, loadFX("misc/flare_ambient_green"));
               break;
               case 6:
               BonusDropReg(self, self.angles, "zombie_blood", "zombie_blood_drop_take", "cardicon_eagle", "Zombie Blood", "", "com_plasticcase_enemy", 0, loadFX("misc/flare_ambient"));
               break;
			}
		}
	}
}

BonusDropReg(ai, angle, type, killnotify, icon, text, gun, model, isGunModel, fx)
{
	pos = ai.origin;
	
	if( type == "nuke_drop" )
		pos += (0, 0, 40);
	else if( type == "death_machine_drop" )
		pos += (0, 0, 50);
		
	level.block = spawn("script_model", pos+(0,0,10) );
	level.block setModel(model);
	if(isGunModel == 1)
		level.block thread HideGunParts(gun);
	level.block.angles = angle;
	level.block notSolid();
	//if(isGunModel < 1)
		//level.block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.block.trigger = spawn( "trigger_radius", pos, 0, 100, 50 );
	level.block.trigger.angles = angle;
	level.block.fx = SpawnFX(fx,level.block.origin);
	TriggerFX(level.block.fx);
	level.block thread BonusDropRegThink(pos, angle, gun, killnotify, icon, text, type);
	level.block thread BonusDropDestroy(killnotify);
	level.block thread BonusDropTimerDestroy(killnotify);
	level.block thread rotateDrop(killnotify);
	wait 0.05;
}

BonusDropRegThink(pos, angle, gun, killnotify, icon, text, type)
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
				case "ammo":
				{	
					playSoundInSpace( "US_1mc_demolition",self.origin );
					foreach(player in level.players)
					{
						player playLocalSound("US_1mc_hq_online");
						player thread MaxAmmo();
						player thread BonusDropText(text, 0.85, (1,1,1),(1,1,0.3),1); 
						player thread BonusDropIcon(icon);
					}
				}
				break;
				case "nuke_drop":
				{
					playSoundInSpace( "US_1mc_domination",self.origin );
					self delete();
					player thread KaBoom(pos);
					foreach(player in level.players)
					{
						player thread BonusDropText(text, 0.85, (1,1,1),(1,0.3,0.3),1); 
						player thread BonusDropIcon(icon);
					}
				}
				break;
				case "insta_kill_drop":
				{
					playSoundInSpace( "US_1mc_sabotage",self.origin );
					level thread InstaKill();
				}
				break;
				case "double_points":
				{
					playSoundInSpace( "US_1mc_demolition",self.origin );
					level thread DoublePoints();
				}
				break;
				case "death_machine_drop":
				if( !(player hasWeapon("m240_grip_reflex_mp")) )
				{
					player playLocalSound("mp_spawn_sas");
					player thread DeathMachineStart();
					player thread BonusDropText(text, 0.85, (1,1,1),(1,0.3,0.3),1); 
					player thread BonusDropIcon(icon);
				}
				else
					return;
				break;
				case "fire_sale":
                		{
                    			level thread FireSale();
                		}
                		break;
                		case "zombie_blood":
                		{
					playSoundInSpace( "US_1mc_hc_captureflag",self.origin );
                    			level thread ZombieBlood();
                		}
                		break;
			}
			self.trigger delete();
			self.fx delete();
			self notify(killnotify);
			self notify("random_drop_destroy");
			self notify("bonusdrop_done");
		}
		wait 0.5;
	}
}

FireSale()
{ 
    level notify("fire_sale_start");
    level endon("fire_sale_start");
    {
        level.fire_sale = 1;
        foreach(player in level.players)
        {
            player playLocalSound("US_1mc_hc_tm_death");
            player thread FireSaleTimer();
        }
        wait 30;
        level.fire_sale = 0;
    }
    wait 0.1;
}

ZombieBlood()
{ 
    level notify("zombie_blood_start");
    level endon("zombie_blood_start");
    {
        level.zombie_blood = 1;
        foreach(player in level.players)
        {
            player playLocalSound("US_1mc_hc_freeforall");
	    player notify("unset_combathigh");
	    player thread AImod\BoxFunctions::setHPOverlay( (1,0,0) );
            player thread ZombieBloodTimer();
        }
        wait 30;
        level.zombie_blood = 0;
    }
    wait 0.1;
}

KaBoom(pos)
{
	level notify("nuke_drop_end");
	level thread NukeKill();
	level.kaboom=1;
	//wait 0.3;
	//setdvar ("timescale" , 0.5);
	//PhysicsExplosionSphere( pos, 5000000, 5000000, 10 );
	//wait 1.7;
	//setdvar ("timescale" , 1);
	foreach(player in level.players)
	{
		player playLocalSound("US_1mc_domination");
		player playLocalSound("US_1mc_hq_secured");
		player.money += 400;
		player notify("MONEY");
		player thread maps\mp\gametypes\_rank::scorePopup( 400, 0, (0,1,0), 1 );
	}
}

NukeKill()
{
    	level endon("nuke_drop_end");
	foreach(zombie in level.bots)
	{
		if(IsDefined(zombie) && zombie.pers["isAlive"] != "false")
		{
			wait 0.6;
			playFx(loadFx("props/barrelexp"), zombie getTagOrigin("j_head"));
			PhysicsExplosionSphere( zombie.origin, 230, 0, 3 );
			zombie PlaySoundToTeam("RU_1mc_draw","allies",zombie);
			zombie.head hide();
			zombie.crate1.health -= 99999999;
			zombie.crate1 notify("damage", 99999999);
		}
	}
	foreach(zombie in level.dogs)
	{
		if(IsDefined(zombie) && zombie.pers["isAlive"] != "false")
		{
			wait 0.6;
			playFx(loadFx("props/barrelexp"), zombie getTagOrigin("j_head"));
			PhysicsExplosionSphere( zombie.origin, 230, 0, 3 );
			zombie playSound("RU_1mc_draw");
			zombie.crate1.health -= 99999999;
			zombie.crate1 notify("damage", 99999999);
		}
	}
	//level.players[0] playSound("exp_suitcase_bomb_main");
	wait 1;
	level.kaboom=0;
}

DoublePoints()
{ 
	level notify("double_points_start");
	level endon("double_points_start");
	{
		level.double_points = 1;
		foreach(player in level.players)
		{
			player playLocalSound("US_1mc_enemy_apache");
			//player playLocalSound("mp_level_up");
			player thread DoublePointsTimer();
		}
		wait 30;
		/*foreach(player in level.players)
		{
			player playLocalSound("mp_level_up");
		}*/
		level.double_points = 0;
	}
	wait 0.1;
}

InstaKill()
{ 
	level notify("insta_kill_start");
	level endon("insta_kill_start");
	{
		level.insta_ko = 1;
		
		foreach(player in level.players)
		{ 
			player playLocalSound("US_1mc_hq_offline");
			player thread InstaKillTimer();
		}
		wait 30;
		/*foreach(player in level.players)
		{
			player playLocalSound("mp_level_up");
		}*/
		level.insta_ko = 0;
	}
	wait 0.1;
}

MaxAmmo()
{ 
    level endon("disconnect");
	{
		foreach(player in level.players)
		{
			weaponList = player GetWeaponsListAll();
			foreach ( weaponName in weaponList )
			{	
				player giveMaxAmmo( weaponName );
			}
			
			player setweaponammoclip("semtex_mp",3);
		}
	}
}

DeathMachineStart()
{ 
	self notify("death_machine_start");
	self endon("death_machine_start");
	self endon("player_is_down");
	tempWeapon = self getCurrentWeapon();
	self thread DeathMachine();
	self thread DeathMachineDeath();
	self _disableWeaponSwitch();
	self thread DeathMachineTimer();
	self giveWeapon( "m240_grip_reflex_mp", 0, true);
	self switchToWeapon("m240_grip_reflex_mp");
	self GiveMaxAmmo("m240_grip_reflex_mp");
	self.notusebox = 1;
	wait 30;
	self.notusebox = 0;
	self takeWeapon("m240_grip_reflex_mp");
	self _enableWeaponSwitch();
	wait 0.1;
	self switchToWeapon(tempWeapon);
	//self playLocalSound("mp_level_up");
	level notify("bonus_end");
	self notify("no_deathmachine");
	wait 0.1;
}

DeathMachine()
{
    self endon("death");
	self endon("no_deathmachine");
    for( ;; )
    {
        self waittill( "weapon_fired" );
        if ( self getCurrentWeapon() == "m240_grip_reflex_mp" )
        {
			self GiveMaxAmmo("m240_grip_reflex_mp");
			self setWeaponAmmoClip( "m240_grip_reflex_mp", 9999, "right" );
			self setWeaponAmmoClip( "m240_grip_reflex_mp", 9999, "left" );
        }
    }
}

DeathMachineDeath()
{
	self endon("no_deathmachine");
	
	self waittill_either("death","player_is_down");
	
	self _enableWeaponSwitch();
	self notify("no_deathmachine");
	level notify("bonus_end");
	self.DeathMachineTimer destroy();
}

FireSaleTimer()
{
    self endon("disconnect");
    level endon("fire_sale_start");
    {
        time = 29;
        self.FireSale destroy();
        self.FireSale = NewClientHudElem( self );
        self.FireSale.alignX = "center";
        self.FireSale.vertAlign = "middle";
        self.FireSale.alignY = "middle";
        self.FireSale.horzAlign = "center";
        self.FireSale.foreground = true;
        self.FireSale setIconShader( "cardicon_award_jets" );
        self.FireSale setIconSize( 30, 30 );
        self.FireSale.alpha = 1;
        self.FireSale.x = 70;
        self.FireSale.y = 200;
        for(count = time;count > -1;count--)
        {
            time = count;
            if(time >= 10)
            {
                wait 1;
            }
            else if(time >= 5)
            {
                self.FireSale fadeOverTime(0.50);
                self.FireSale.alpha = 0;
                wait 0.50;
                self.FireSale fadeOverTime(0.50);
                self.FireSale.alpha = 1;
                wait 0.50;
            }
            else
            {
                self.FireSale fadeOverTime(0.25);
                self.FireSale.alpha = 0;
                wait 0.25;
                self.FireSale fadeOverTime(0.25);
                self.FireSale.alpha = 1;
                wait 0.25;
                self.FireSale fadeOverTime(0.25);
                self.FireSale.alpha = 0;
                wait 0.25;
                self.FireSale fadeOverTime(0.25);
                self.FireSale.alpha = 1;
                wait 0.25;
            }
        }
	level notify("fire_sale_end");
        self.FireSale destroy();
    }
}

ZombieBloodTimer()
{
    self endon("disconnect");
    level endon("zombie_blood_start");
    {
        time = 29;
        self.ZombieBlood destroy();
        self.ZombieBlood = NewClientHudElem( self );
        self.ZombieBlood.alignX = "center";
        self.ZombieBlood.vertAlign = "middle";
        self.ZombieBlood.alignY = "middle";
        self.ZombieBlood.horzAlign = "center";
        self.ZombieBlood.foreground = true;
        self.ZombieBlood setIconShader( "cardicon_eagle" );
        self.ZombieBlood setIconSize( 30, 30 );
        self.ZombieBlood.alpha = 1;
        self.ZombieBlood.x = -70;
        self.ZombieBlood.y = 200;
        for(count = time;count > -1;count--)
        {
            time = count;
            if(time >= 10)
            {
                wait 1;
            }
            else if(time >= 5)
            {
                self.ZombieBlood fadeOverTime(0.50);
                self.ZombieBlood.alpha = 0;
                wait 0.50;
                self.ZombieBlood fadeOverTime(0.50);
                self.ZombieBlood.alpha = 1;
                wait 0.50;
            }
            else
            {
                self.ZombieBlood fadeOverTime(0.25);
                self.ZombieBlood.alpha = 0;
                wait 0.25;
                self.ZombieBlood fadeOverTime(0.25);
                self.ZombieBlood.alpha = 1;
                wait 0.25;
                self.ZombieBlood fadeOverTime(0.25);
                self.ZombieBlood.alpha = 0;
                wait 0.25;
                self.ZombieBlood fadeOverTime(0.25);
                self.ZombieBlood.alpha = 1;
                wait 0.25;
            }
        }
        self.ZombieBlood destroy();
    }
}

InstaKillTimer()
{
	self endon("disconnect");
	level endon("insta_kill_start");
	{
		time = 29;
		self.KoTimer destroy();
		self.KoTimer = NewClientHudElem( self );
		self.KoTimer.alignX = "center";
		self.KoTimer.vertAlign = "middle";
		self.KoTimer.alignY = "middle";
		self.KoTimer.horzAlign = "center";
		self.KoTimer.foreground = true;
		self.KoTimer setIconShader( "cardicon_fmj" );
		self.KoTimer setIconSize( 30, 30 );
		self.KoTimer.alpha = 1;
		self.KoTimer.x = -35;
		self.KoTimer.y = 200;
		for(count = time;count > -1;count--)
		{
			time = count;
			if(time >= 10)
			{
				wait 1;
			}
			else if(time >= 5)
			{
				self.KoTimer fadeOverTime(0.50);
				self.KoTimer.alpha = 0;
				wait 0.50;
				self.KoTimer fadeOverTime(0.50);
				self.KoTimer.alpha = 1;
				wait 0.50;
			}
			else
			{
				self.KoTimer fadeOverTime(0.25);
				self.KoTimer.alpha = 0;
				wait 0.25;
				self.KoTimer fadeOverTime(0.25);
				self.KoTimer.alpha = 1;
				wait 0.25;
				self.KoTimer fadeOverTime(0.25);
				self.KoTimer.alpha = 0;
				wait 0.25;
				self.KoTimer fadeOverTime(0.25);
				self.KoTimer.alpha = 1;
				wait 0.25;
			}
		}
		self.KoTimer destroy();
	}
}

DoublePointsTimer()
{
	self endon("disconnect");
	level endon("double_points_start");
	{
		time = 29;
		self.DoublePointsTimer destroy();
		self.DoublePointsTimer = NewClientHudElem( self );
		self.DoublePointsTimer.alignX = "center";
		self.DoublePointsTimer.vertAlign = "middle";
		self.DoublePointsTimer.alignY = "middle";
		self.DoublePointsTimer.horzAlign = "center";
		self.DoublePointsTimer.foreground = true;
		self.DoublePointsTimer setIconShader( "cardicon_gold" );
		self.DoublePointsTimer setIconSize( 30, 30 );
		self.DoublePointsTimer.alpha = 1;
		self.DoublePointsTimer.x = 0;
		self.DoublePointsTimer.y = 200;
		for(count = time;count > -1;count--)
		{
			time = count;
			if(time >= 10)
			{
				wait 1;
			}
			else if(time >= 5)
			{
				self.DoublePointsTimer fadeOverTime(0.50);
				self.DoublePointsTimer.alpha = 0;
				wait 0.50;
				self.DoublePointsTimer fadeOverTime(0.50);
				self.DoublePointsTimer.alpha = 1;
				wait 0.50;
			}
			else
			{
				self.DoublePointsTimer fadeOverTime(0.25);
				self.DoublePointsTimer.alpha = 0;
				wait 0.25;
				self.DoublePointsTimer fadeOverTime(0.25);
				self.DoublePointsTimer.alpha = 1;
				wait 0.25;
				self.DoublePointsTimer fadeOverTime(0.25);
				self.DoublePointsTimer.alpha = 0;
				wait 0.25;
				self.DoublePointsTimer fadeOverTime(0.25);
				self.DoublePointsTimer.alpha = 1;
				wait 0.25;
			}
		}
		self.DoublePointsTimer destroy();
	}
}

DeathMachineTimer()
{
	self endon("disconnect");
	self endon("death_machine_start");
	
	total_time = 30;
	
	self.DeathMachineTimer destroy();
	self.DeathMachineTimer = NewClientHudElem( self );
	self.DeathMachineTimer.alignX = "center";
	self.DeathMachineTimer.vertAlign = "middle";
	self.DeathMachineTimer.alignY = "middle";
	self.DeathMachineTimer.horzAlign = "center";
	self.DeathMachineTimer.foreground = true;
	self.DeathMachineTimer setIconShader( "cardicon_skull" );
	self.DeathMachineTimer setIconSize( 30, 30 );
	self.DeathMachineTimer.alpha = 1;
	self.DeathMachineTimer.x = 35;
	self.DeathMachineTimer.y = 200;
	for(timer = total_time; timer > 0; timer--)
	{
		if(timer >= 10)
		{
			wait 1;
			continue;
		}
		else if(timer >= 5)
		{
			self.DeathMachineTimer fadeOverTime(0.50);
			self.DeathMachineTimer.alpha = 0;
			wait 0.50;
			self.DeathMachineTimer fadeOverTime(0.50);
			self.DeathMachineTimer.alpha = 1;
			wait 0.50;
		}
		else
		{
			self.DeathMachineTimer fadeOverTime(0.25);
			self.DeathMachineTimer.alpha = 0;
			wait 0.25;
			self.DeathMachineTimer fadeOverTime(0.25);
			self.DeathMachineTimer.alpha = 1;
			wait 0.25;
			self.DeathMachineTimer fadeOverTime(0.25);
			self.DeathMachineTimer.alpha = 0;
			wait 0.25;
			self.DeathMachineTimer fadeOverTime(0.25);
			self.DeathMachineTimer.alpha = 1;
			wait 0.25;
		}
	}
	self.DeathMachineTimer destroy();
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

//original code at http://pastebin.com/nepncBr6

/*powerup_hud_overlay()
{
	level endon ("disconnect");
	level.powerup_hud_array = [];
	level.powerup_hud_array[0] = true;
	level.powerup_hud_array[1] = true;
	level.powerup_hud_array[2] = true;
	level.powerup_hud_array[3] = true;
	
	level.powerup_hud = [];
	level.powerup_hud_cover = [];
	for(i = 0; i < 4; i++)
	{
		level.powerup_hud[i] = NewClientHudElem(self);
		level.powerup_hud[i].foreground = true; 
		level.powerup_hud[i].sort = 2; 
		level.powerup_hud[i].hidewheninmenu = false; 
		level.powerup_hud[i].alignX = "center"; 
		level.powerup_hud[i].alignY = "bottom";
		level.powerup_hud[i].horzAlign = "user_center"; 
		level.powerup_hud[i].vertAlign = "user_bottom";
		level.powerup_hud[i].x = -32 + (i * 15); 
		level.powerup_hud[i].y = level.powerup_hud[i].y - 5; 
		level.powerup_hud[i].alpha = 0.8;
	}
	
	//level thread Power_up_hud( "specialty_doublepoints_zombies", level.powerup_hud[0], -44 );
	//level thread Power_up_hud( "specialty_instakill_zombies", level.powerup_hud[1], -04 );
	//level thread Power_up_hud( "specialty_firesale_zombies", level.powerup_hud[2], 36 );	
	//level thread Power_up_hud( "zom_icon_bonfire", level.powerup_hud[3], 116 );	
	
}

//BO Shader Stuff
//Power_up_hud( Shader, PowerUp_Hud, X_Position )
{
	timer = 30;
	
	while(true)
	{
		if(timer < 5)
		{
			wait(0.1);		
			PowerUp_Hud.alpha = 0;
			wait(0.1);
		}
		else if(timer < 10)
		{
			wait(0.2);
			PowerUp_Hud.alpha = 0;
			wait(0.18);
		}
		if( timer != 0 )
		{
			PowerUp_Hud.x = X_Position;
			PowerUp_Hud.alpha = 1;
			PowerUp_Hud setshader(Shader, 32, 32);
		}
		else
		{
			PowerUp_Hud.alpha = 0;
		}
		wait( 0.05 );
	}
}*/
//So far this won't show anything. I have no idea why. Also yes I removed the level thread Power---
//and put it in with the actual foreach(player in level.players) code there
//but it still won't show.